Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2319FC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EB181DCF;
	Tue, 28 Jan 2025 14:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="HMdHPboC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1CB81DD3; Tue, 28 Jan 2025 14:37:50 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4692481DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738071463; bh=+XRqOpwc+jRQ/sJZiGSB51797LcMyBDdJ+hA+ItuB/w=;
 h=From:To:Cc:Subject:Date;
 b=HMdHPboC8LjZICPNmWQVDVC408MDUPRmbf/yUP/O1NruVAEaLgrJdsGu7ZIn9ff2e
 bOAS0r/gvuv0hjLMfVKNGu69D9etObjwXBdhCTkGD+GqmOI+3GdYrjfDF66gmTBLMa
 oKjHYZJc8wu1ScgMFGceggbevn94YcCBGw0a2HKE=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
 id 96806C22; Tue, 28 Jan 2025 21:37:40 +0800
X-QQ-mid: xmsmtpt1738071460tu8if5m81
Message-ID: <tencent_1A2035CCAD490A9F919EF0412BB6E3E02407@qq.com>
X-QQ-XMAILINFO: NvLNdcR2o3c4fyIfp0AI+qmQW1aZkl8Kb1LsqQkpwSMkEZLXE4n4F3Z1U8WtA2
 +x7Q50g4HKIj5mYAw49n+N1isEk0KB8h5I3tBG7UtSUNIXcHAuaeb6PwBMVA//b9HcOSA77yFYY8
 hrOgjPbDeHcWtnrUOI2y8fDQ5px5jvPHs+T4W151mUOCKcwCbAeFlwKyiqJN/lH+w9rQdkWH9J5G
 N9rANEg+FsQD83xDiOg1S2KJ4TnMZVHRhvBg14dj6vsePaWSs+X7FJNvTSMLJlK+FkHN9Qg1iv2m
 1id/BrWcb27Q6q2splVNN1Z9Lb9OGGuDB20MwTPKf0Wzwkg6BTMig6gpXSYwIfhTdn0WAFWpJbbZ
 nByG4GxaQ8FWWfreFiQXYAtSCnyZeOx4VAGyQzkAf0nTeqCHQlTT87tIlAXNkxigbYWKPWPHWhj3
 Gq3rMy+F2gA09ppn1WICMZJrRMnVIJ/AgKyPPPYHfNXxmobjteeHitOfyYb9CCqu8FAyYa5tSbNg
 BamsvtmRrkkvcdWhkoEC4NfXvm5xyywZz4p4v5E+HnZ1QAt9PwLftC/PObZrDKQxw3E/rM7nzvbQ
 f+89DLn7FV7Qd1u7K12lBgAeiuYounG0ucyviu3Mn2xOFipKwHsbCyUkLMZQoZfXVXmWHmn5IDCn
 5S3dKxyWcdeqhZ9qeebsC3fM+KacDHJr/X15HwfteEQnhCx6wTCgAWu+/wJrAJhNO5HdWGqPikTz
 fMyZ2OTC1ET+KghsgHc06HOFBiA8OqEWUqgAi7gv4jUZZQ61kWUhn4W9Mfo2rxU1hI6fDXQYKL7d
 lMH0RICcEDFnIujIP+PyaC3pN2Pc5p3R5LTA57BUOKog5AFnPZC2Wg49wEgKVoDPpvuuX4OA1UkI
 dFhEhzXBRUxQ9ihAXCbIxeN1T5qrRfBRE9e8GJNdrTKmjf8tGr+EXrYNnjPDX8p/bWVthbH+aXGP
 GlUSV2vWq9c1WOq1TEE3fmJIgQkWadqDGuuA8bTyTzpYXzyFIunbVE7BEex8XnCvpf45LjJPA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] arm: The CHIP DIP SCAN option should not be displayed in
 other mach
Date: Tue, 28 Jan 2025 21:37:37 +0800
X-OQ-MSGID: <20250128133737.195319-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

When I use mach STM32,
menuconfig sees this option; It bothers me.
I observed that the root cause was that the
option was not included in the endif,
but when I tried to fix it, an error occurred.
I didn't find a solution. Only deponds can be used for hiding.

Signed-off-by: Liya Huang <1425075683@qq.com>
---

 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ba1b1541437..48dd1e68363 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1137,6 +1137,7 @@ endif
 
 config CHIP_DIP_SCAN
 	bool "Enable DIPs detection for CHIP board"
+	depends on ARCH_SUNXI
 	select SUPPORT_EXTENSION_SCAN
 	select W1
 	select W1_GPIO
-- 
2.25.1

