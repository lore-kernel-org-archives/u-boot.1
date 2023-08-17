Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A63C2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B091586A42;
	Thu, 17 Aug 2023 03:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BgiF9epm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F7ED86A77; Thu, 17 Aug 2023 03:52:11 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7E586A64
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-56d263da4f2so5087489eaf.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237126; x=1692841926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsaeCdTReyIjPXDRcv75dWGxTxNU7L29hfv+KPz6jWQ=;
 b=BgiF9epm2boC5p1q8ujfpexS142AeZUpoobSEX/xQL8mdM867E61x3e+sB0laRJ99E
 LV5dSYE9ntxbxJ+ETmDXTUJfc4uoaWcBgzvsK5qPUG/Rfhaw9cDegx//utQxPZ5lKx3+
 K875lODZzyzPUMXP5WHtY7VK408Go3dP+gIbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237126; x=1692841926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsaeCdTReyIjPXDRcv75dWGxTxNU7L29hfv+KPz6jWQ=;
 b=IrQaa+tMJvLMSgNtEyC5XpB4XhIm0+RpVfIvRRnJaLjrUUAofla2+ugAv2Zz04cfcV
 sMNp0Wg7oX1VjklGZeKWeqP9f+V3SbiFBPklwccpTmFHgEW0WUxsyNDpY5NXWq2AmaPL
 Gfjgrr3OlRW+5x6W86yXkslFQWFFVZwzcEWiE/Gl6bB8lsNbo7thf9EprqYXjrbEXIEm
 f5xwRHHOJKGxng7JDEs0n3qqOZqbpB0qDysGZx78ZrjtikwfQbtnk4pkIR609fcPgi2k
 seB42BB+5YqM8eEkZIPAS8SULD8pzDlXxjsgy9GPbi6HStt9TBS72WWA6nL5ToDdvWyA
 gKTg==
X-Gm-Message-State: AOJu0YzPu65qp/daehpMYzWud/md2pRROqcx21Yd0IiEtJ1CkflUaDkf
 JXSeezW9L+MJRf3QItkFC3h2aDc/PMDaIwlbAwY=
X-Google-Smtp-Source: AGHT+IEia38uegB2ujznohv20czqauKQ334e8gVWw2jPZ58rLPyMvGsTMd3dWTDXunq3K67pQLds3A==
X-Received: by 2002:a05:6870:c0cd:b0:1c8:b870:4e62 with SMTP id
 e13-20020a056870c0cd00b001c8b8704e62mr1269164oad.52.1692237126543; 
 Wed, 16 Aug 2023 18:52:06 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 8/9] bootstd: cros: Correct condition for reading the kernel
Date: Wed, 16 Aug 2023 19:51:43 -0600
Message-ID: <20230817015149.774847-9-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A typo prevents this code from behaving as it should. The tests pass
because they do not actually read the kernel. Fix the typo.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_cros.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 20e0b1e89c36..3439d31121b3 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -406,7 +406,7 @@ static int cros_read_file(struct udevice *dev, struct bootflow *bflow,
 	return -ENOSYS;
 }
 
-#if CONFIG_IS_ENABLED(BOOSTD_FULL)
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
 static int cros_read_all(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
@@ -458,7 +458,7 @@ static struct bootmeth_ops cros_bootmeth_ops = {
 	.read_bootflow	= cros_read_bootflow,
 	.read_file	= cros_read_file,
 	.boot		= cros_boot,
-#if CONFIG_IS_ENABLED(BOOSTD_FULL)
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
 	.read_all	= cros_read_all,
 #endif /* BOOSTD_FULL */
 };
-- 
2.41.0.694.ge786442a9b-goog

