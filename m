Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6EBC4167D
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF6E8745A;
	Wed, 15 Nov 2023 14:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XVs5upbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DC087227; Wed, 15 Nov 2023 14:17:09 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32ADF87285
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-543c3756521so10171199a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054226; x=1700659026; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0XrXqNngxVMEMWGVDHLA3DMG3wrV3DPJ5th5DxTleQc=;
 b=XVs5upbgGOeDVX5zoZVVbt+Bjrvo7TV4HkajMs1QKl/MZzdG+1SZnw9W0N6SsR71Pj
 GFDCPsokpg9zEG6iyBc6fAUjygjUdI1moRXZoJqBRl40GRTsRJXgwTQyCy0i3k3gCkQb
 hSLLZs78/eHgqc/k5wog4yAsNBk8RBK9O1bIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054226; x=1700659026;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0XrXqNngxVMEMWGVDHLA3DMG3wrV3DPJ5th5DxTleQc=;
 b=tuLosqiHmijIxOisOpIm32VTxbjMsI8hF66e+j8vX9vEvaxDcb+60/fiwn6AbkQdbd
 owgpCfPdSg4W43/qPsFbzTw/yLClKb1HVGhNPVZNVSU2QVucVqjDXrZpLTB6otUcqUM4
 HDG0oOcYDNbx6lsKCDiuWW4YlKy8wKz3V/P8t+IwAEZIXbJTS2zETy8FABv3PH40hYym
 5E4TOOfEzbWExAJkKdaZfuNtub+LX3DEebMW9+mEJLCnt7cmd8dln9UTGNYkMDVOe9bc
 ZfBNEnXZucjCg/o3JdF8rU7v8Ux4bXJxLuqhaGNZrqM53/dqqcLu6x+wTV9Vzo2ZiVE+
 cA8g==
X-Gm-Message-State: AOJu0YwtVz9C1CyrbkzlRu0o5X4quGIdHpXXPGtDXpDs2W471UbW/wZe
 7VAeeBwnRHhKEzKeQp1XIOgo9MUfhzHJW4u9CR1P2g==
X-Google-Smtp-Source: AGHT+IHDlboxKT48g7Kl7LO8UzTMeb7Fz4ErgSazNm1JAV6BEF9TK26KlvAz2JqggVks9/xyvIvVGFZ13VNeA9s6Xqw=
X-Received: by 2002:a17:906:1147:b0:9da:f372:4f6c with SMTP id
 i7-20020a170906114700b009daf3724f6cmr8014892eja.32.1700054226551; Wed, 15 Nov
 2023 05:17:06 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:17:05 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231001191444.v3.3.Iaa9b5bbab0f25012cfc68a803a9da83e71b19aaf@changeid>
References: <20231001191444.v3.3.Iaa9b5bbab0f25012cfc68a803a9da83e71b19aaf@changeid>
 <20231002011450.462468-1-sjg@chromium.org>
Date: Wed, 15 Nov 2023 05:17:05 -0800
X-Google-Sender-Auth: 4GyIxx4dkS3eGPhRGGEtaxvz94M
Message-ID: <CAPnjgZ03LgGX4B50eTzgExu7wXRtKN=mi5ZpbwozwEz78S9uPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] bootstd: Add a return code to bootflow menu
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Return an error when the user does not select an OS, so we know whether
to boot or not.

Move calling of bootflow_menu_run() into a separate function so we can
call it from other places.

Expand the test to cover these cases.

Add some documentation also, while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add missing word 'function' in the commit message

Changes in v2:
- Add new patch to add a return code to bootflow menu

 cmd/bootflow.c             | 53 +++++++++++++++++++++++-------
 doc/usage/cmd/bootflow.rst | 67 ++++++++++++++++++++++++++++++++++++++
 test/boot/bootflow.c       | 15 +++++++++
 3 files changed, 123 insertions(+), 12 deletions(-)

Applied to u-boot-dm, thanks!
