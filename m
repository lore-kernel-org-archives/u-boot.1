Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7361CCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4F986ABC;
	Sat, 23 Sep 2023 20:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7vcsNUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B33869F4; Sat, 23 Sep 2023 20:13:51 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDE386945
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50444e756deso2397671e87.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695492829; x=1696097629; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgmP1zwlJHA39xmuPMv218+s/gzvT+599vtNKZkuUYk=;
 b=h7vcsNUFvftl5xaEwB2OeZFkehNfHQBnODGWul76qObZgcFIJYAHuqgUWS3gBLNKuv
 tbvn58BVJQw+aZnSXQWYQ892iyx9qur/LbBkZIfLu22dXjhQeHRT6wnJBbvBVWqETwGF
 2ThgzgEePaI8I5DTUaCgNRz/nQpUgYps3L774=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695492829; x=1696097629;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZgmP1zwlJHA39xmuPMv218+s/gzvT+599vtNKZkuUYk=;
 b=Cg1qKInHbK/ItLedFbDuArGO8nYRl250SIsoOa0aAyWhMNNG808HFyRAIf7UldaFX1
 IhAXOvL0nQ6cYIQnbcec1eGHn3Q+v/4CORpseSmHaaG5/bqu+N5K6xQl6pm7PjQ14/a/
 NhZVLmXqGsZsdQzAGdL2G1cOKoEeCMmT26IJFVqwuaoBX/WJsyJgo3/TuSRWBumbTyUe
 jBLA9AazRLYNfOqN0lYCZfPtOzZv+BfaiXYo7lAVmKqJnhj0PwasqhnqNe8zgb2ORntS
 BLf/HvCC+1GocfcxYnMcG/hpReCg0VNsQcKAuu5LxbgPg1xapwx+wzViSTdOst7lH3I/
 0vBg==
X-Gm-Message-State: AOJu0YzL1iPD2tksit0RTpB1KqYzHbYvaOpiijag191mrsh1ZbiRmsqa
 P6W8ayc9HBv6tbdlZDFGFbphDglMOj7c2O667zBiQg==
X-Google-Smtp-Source: AGHT+IEnezVsDt+nogggmmXrVfwfhdzjzIqKRVp+Cc1j0iIMXc8obQ84QXkSBxiHdL7t0hERopCJuemH6YaBo2UU/7c=
X-Received: by 2002:a19:e019:0:b0:500:92f1:c341 with SMTP id
 x25-20020a19e019000000b0050092f1c341mr2081579lfg.54.1695492829031; Sat, 23
 Sep 2023 11:13:49 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 11:13:48 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <6edb34ef1f10010d2380f964fb6b4fb3dc257799.1694779918.git.michal.simek@amd.com>
References: <6edb34ef1f10010d2380f964fb6b4fb3dc257799.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
Date: Sat, 23 Sep 2023 11:13:48 -0700
X-Google-Sender-Auth: t-jiQSSmjuNLZWFfhQrDjoB0Ci8
Message-ID: <CAPnjgZ1mzMvyiWjO_NL2dO-MDkUOxNn50ufvfqDggVjLFu_p9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] trace: Use 64bit variable for start and len
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

tputq() requires variables to have 64bit width that's why make them 64bit
to clean alignment requirement.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/proftool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
