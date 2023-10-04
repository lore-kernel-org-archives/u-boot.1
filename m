Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36538E7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E1387622;
	Wed,  4 Oct 2023 19:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZHtWBbPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF33E87605; Wed,  4 Oct 2023 19:58:33 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3974B875D7
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-534659061afso59242a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442311; x=1697047111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HfiTcmaklQ+AblE9Ui25zg6+JQZoZ5wNB+tpVOdlpoc=;
 b=ZHtWBbPLePu72YiN5YZdrZkClHcaAXdJiagSUnMlrjiIJ2yit7MQ1WCDhFU3TgV/X3
 GU/BbLC0CNr9mUZuUfTj9hk6VXy/KeOV6Wshfevv1sGCEkblz/USJ7052DzWQGQirepP
 D7lSScB2xUNMJRjAHekITDldmSZocNX9a+34k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442311; x=1697047111;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HfiTcmaklQ+AblE9Ui25zg6+JQZoZ5wNB+tpVOdlpoc=;
 b=UqIrCxXLLXa0WLM9BVc8TXdLr7B9vHWl/CJGDtZaZiyPTXz2yVnXLJfPwSuJ2BdKTU
 QBJys2ZCAbHzt8SgReKX1w1wGVADj/nam/ufPxiwxX5OERZyesMKmRyYb+177hc4ctOx
 20q/QErTQD3H//DhHtqQhQ0DWTf5hQC+Xtw+zu/iBMdk96lxqefblOp/GTpFCvqj/YXY
 oswVDSfFReCMC+DRh7Dlm6H5ns2JBss+r90AHVPkKxZmry4aVKAGlCivRx12tab8mPdU
 eOlUcYdvlEgwXsVV7N1vzD1QGNP6Vq/gp4hnmRwyk0v/YiI5v/QiBJKCwgdZRDbM26vn
 81ng==
X-Gm-Message-State: AOJu0YxLd7tCBBIcJ9lhr+wqxXLNiETM4jTiBXq80LXjc0KWFmGOTyIj
 UXPSeLCtwCeKI2faYIYnA9m00gt9yptCtHl5kM/o+w==
X-Google-Smtp-Source: AGHT+IHAIbrua6ptmeC/TmJ2UCJza8wp2tOnzHEYTxdzhPYd3KcinEhFFfgPwrAEE865wU2vNTWrTdJHLtV3mYDTBZo=
X-Received: by 2002:a17:907:720b:b0:9a1:f4e8:87b9 with SMTP id
 dr11-20020a170907720b00b009a1f4e887b9mr3274478ejc.45.1696442310654; Wed, 04
 Oct 2023 10:58:30 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:28 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-19-sjg@chromium.org>
References: <20230923194424.1739224-19-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:28 -0700
X-Google-Sender-Auth: aagfkDkuf6GjtkzLc14IOqdaWs4
Message-ID: <CAPnjgZ17Hy9cXNFGKKrvzJnmtQ7NKhjeh7Sw-6_RWdH6gpZKVw@mail.gmail.com>
Subject: Re: [PATCH v3 18/27] moveconfig: Reduce the amount of output
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Output a single line in the case where the defconfig only has one line
of output. Show the name without the _defconfig suffix, since that is the
same for all boards.

Use a list for the log so it is easier to process at the end.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

Applied to u-boot-dm, thanks!
