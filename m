Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4A5CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBDFD86C18;
	Sat, 23 Sep 2023 21:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bc+PzqU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD80C86C16; Sat, 23 Sep 2023 21:47:45 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E5D86BD6
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-533df112914so598628a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498462; x=1696103262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s9S8+sY7Y4UN2/JmQBSPcpmCOM8KPrSCCIA9MUYyyb8=;
 b=bc+PzqU8z442M5oLEqsALpF2F0MH/4t9vxxhgvOZ7sPmEI/VyzcCJjsvzxZxYVkEB1
 paj3JcKsQqFyneMviFmdbkXhyjVEJiMEFv3DDFCGrmYbn7lTQDllUoUEN3xjIYrPxzpm
 92/pcwgAhq9P9oMwf0qn81z76poz3uYoKMqh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498462; x=1696103262;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9S8+sY7Y4UN2/JmQBSPcpmCOM8KPrSCCIA9MUYyyb8=;
 b=Q7hYlPy0KAzhBFJ5DvKVehQmTJbJW/jqsZeOUXeBwEgYISFagmux5GVoaEFZ9BmUqU
 bTNgIEkoh872oqzgluu2liMwkp4wCE96Z4YWMNiurWcqGv/8Ko6dlicMTq9NUz+LtKZu
 88uF2Bcw49Jvob6sTyUEswsBbCZmmQczfsuFDLQkpi+b/EbQyQqngiYyxesre7XUsKHA
 o3TXXmrNhzjWi7Th3Xhqh/Q2/XfQQ9bsp+CCb2zfMBlGx/YumIu4LfnufB9eHmLZdhop
 3/uzru3aKTjf0KXZ/SN9c5uUmu2L1ryYl7UPtthfzvD+kPXXMcAcFEh8EE/moCT86M5U
 nUrA==
X-Gm-Message-State: AOJu0YzztZa06O0zwWJC22pD8Y88rhfyb1q3nqlLTuVHxdbrEmbpy4YA
 4ddkDMMf/NCJk5fqR5xtKWOENBkK8L1Tn4ulJJ4Xww==
X-Google-Smtp-Source: AGHT+IFIKKf/v/j90gFr/ccHGaNf+fm0R5m2J35hjxH1DaSWZpr2+UiTut9HXr2dRYyxSVVEzIJ1WUZhAM1NJWmgvIA=
X-Received: by 2002:a05:6402:334:b0:533:4c15:c337 with SMTP id
 q20-20020a056402033400b005334c15c337mr2608927edw.16.1695498461938; Sat, 23
 Sep 2023 12:47:41 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 12:47:40 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230907160023.49339-3-sjg@chromium.org>
References: <20230907160023.49339-3-sjg@chromium.org>
 <20230907160023.49339-1-sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:47:40 -0700
X-Google-Sender-Auth: cpnrj58gvH1YJAv2F8mswcyDpCE
Message-ID: <CAPnjgZ3O7Nnj5v-rq712QDGQJYqwNH6Aw8e6132Vt19cJnsdPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] buildman: Show progress when regenerating the
 board.cfg file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This can take a while, so show a message when starting.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/buildman/boards.py  | 15 ++++++++++++---
 tools/buildman/control.py |  3 ++-
 2 files changed, 14 insertions(+), 4 deletions(-)

Applied to u-boot-dm/next, thanks!
