Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64090FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1715E842EF;
	Sat, 25 Apr 2026 18:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PFoy4ptb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D19AF843AF; Sat, 25 Apr 2026 18:10:05 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46E58441A
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8d933da14f0so832901285a.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777133354; x=1777738154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyoqRnpLn3U8DmIlRDRnqH4sjc8KpglGpEl5t9ziWtw=;
 b=PFoy4ptb5iwopBk6KaCICZG3kWflPbzV9AEyJ6bBejAyeyDM+ZmJAvvPIaFSZ9y5BL
 ipTNHuVokH43IpbtK+i8EPW790r8bGk+5HM5hVIdeyM1MMwhlF3G7zHPRokmkuB+6J7x
 p4QQu1AMzsfv1Ic1Nfex7c3a4myAGVAP73nN02bx5YIkdMtTMPHSprdUb5TBZK1gJ0a8
 BJK9xvLx7D1cfumHp9CVYamp2FyYqtsn5yARKDOnkvfGDvzRDJx66XTPUcn+wYmYzeK0
 bvLrNEp1hRRWdoff1Sz3F5GV4SA5sO/xZgX6bo6B1WjJHrebePNqqjKH0fxc/dZer9UH
 JrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777133354; x=1777738154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GyoqRnpLn3U8DmIlRDRnqH4sjc8KpglGpEl5t9ziWtw=;
 b=k9C0BLNvinGMaaXx8U3rtY56yap5bsuWkWimBdzStAvC7EiBjQIMbk1paDQWJGcW/M
 Drm3QBmYR7RrwMP7CCDi/8SgI5Sa1zcwwU1H2yHK/Lp6RTS6gJZaLLI6yuQpzHR/SepT
 SEkwzne8xXgyrNvwVp59WIXRl2zlKesKFrTOyY7742lcZMSBRmocJzZZXToURHguQscS
 Gu5KMI6jQDrMU1etm5KHZqXGYdDMojSKaIrtPmb5j3939s98O9RNlne4JMmLD4oi0mw8
 2KlAZwiA5trX9GtDUNQC3rOI3hzT4eYMm2aXWYcKDVZxEmXh7OjJ7W03QV2XFeG4HwXw
 Aj4A==
X-Gm-Message-State: AOJu0Yw6VgFDQ6hLpzAITMp9gcSvTzcF8dwpbkG1lp0VIjr+Y3WWEyGM
 9HYQgh+QeEcsLNFWpvKxKGXPs3voY2hpXfSLqZ0fcQkIemz6TEwreiOw/OL3pyyI
X-Gm-Gg: AeBDietE5yENOiJ9LRlZNYhcaxhdq5eDR83Qd4AlvNUcJ5LNePqIJRBIsrrrxHaMl3y
 MgkfVzux4MKUZiRZ5hd2jH2YOnw/LE6ulFYkZ5acHiWz9vnsLuDEtYwhTNR7wPIx3j27YMand2I
 ogRfHos1u+/PK+KD2lfovi8j8LFI4DX9OgEnlYSjHCcEYO9UiHVKrjHA79BjfwQFbjT8YV+6ib/
 3J8rT6ju1pn87pyeJmfHzrSiwox1/3MkOuu4/SZIjygWMut+UleyXzXoZERct8u9GLvx9krcOxq
 jr7DUZ/mH9aco3Vvnu5QhOSuUZlT0FPHL1J5WfkloURvOWFjSEuhX8i7toYORvO3M6F8hhr9Dnf
 jp3RBQgayTpLBGJ/FVFrVrQYAWqUcgg6/hzzkcW4glq+iI0K4KLr+h/lh0FSAT6Pi/6ogiq2qm2
 iYq5jBK/33PQi5nzyKKnbeIsUfBVJJ80YCOCFxox96LqCJ
X-Received: by 2002:a05:6102:dcd:b0:610:6e69:5235 with SMTP id
 ada2fe7eead31-616f71f0a70mr14250142137.22.1776954358396; 
 Thu, 23 Apr 2026 07:25:58 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:58 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 15/15] mach-sc5xx: Remove unused image offset Kconfig
 options
Date: Thu, 23 Apr 2026 10:24:50 -0400
Message-Id: <2294454ca0c4c4ba0974868d9d8b8d51e92ecd8a.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:32 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Remove SC5XX_UBOOT_SPL_OFFSET, SC5XX_UBOOT_OFFSET, SC5XX_FITIMAGE_OFFSET
and SC5XX_ROOTFS_OFFSET as they are no longer needed in the Kconfig.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 44402b2568d..0f4e63a355e 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -116,30 +116,6 @@ endchoice
 
 endif
 
-config SC5XX_UBOOT_SPL_OFFSET
-	hex "SPL offset"
-	default 0x0
-	help
-	  The default offset where the SPL is located.
-
-config SC5XX_UBOOT_OFFSET
-	hex "U-Boot offset"
-	default 0x40000
-	help
-	  The default offset where u-boot is located.
-
-config SC5XX_FITIMAGE_OFFSET
-	hex "FitImage offset"
-	default 0x1a0000
-	help
-	  The default offset where the fitImage is located.
-
-config SC5XX_ROOTFS_OFFSET
-	hex "RootFS offset"
-	default 0x102000
-	help
-	  The default offset where the rootfs is located.
-
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
-- 
2.34.1

