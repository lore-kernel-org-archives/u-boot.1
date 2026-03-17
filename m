Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B67FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B35842AB;
	Tue, 17 Mar 2026 02:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TCeJ++p1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327F78429E; Tue, 17 Mar 2026 02:24:46 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C6E283F9A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d756f2a06dso253628a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710683; x=1774315483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi9/63OGg1CclNIYXJtc3SixAp2BJTjYdcXGKvmL3XM=;
 b=TCeJ++p1Z3bakqP3fX64MhDj3rwvectYR1wEdUlnllhLXparKZTY7W96GlnySsdt9E
 QZHZaByu06ceyDle3Oi364WxaWA6rBxdk0faWkmkvkYhIvEMOV1FN94L8Y/khaNGDeKK
 5/2+a6n2FKSw9ICYojTpMh/XSkJJSHPTCMQP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710683; x=1774315483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oi9/63OGg1CclNIYXJtc3SixAp2BJTjYdcXGKvmL3XM=;
 b=cuf+Fru61R/7zC+7AOesqdqsNagy3jmCsp5ELso2d3S3Zq7j/WvH5YoqlsNFTS6Td+
 4bhTFXLmYPUQSkXKVo8lMU9spWGs7UL9+hlaLrUmxLzcr4hrydHa9gYH/aJ1DGX+tK+C
 4R6SlucZfhm1ZPxM4j9Ycx5dXfRtW7kZKI8rDeSBcPoQDDIe9SxpoUW030TrorpYj1LL
 5vq6miiv/Ltr5flZ2AESYrbiu1lgPiDkFjrBLlG75xhKkEyPBK3SjmrMbgGEl7C61U7S
 8EzGvJ0c5uvKoESestBUIRSW8ItTNdM6KwIu7LqEjwmjl34mvcu3I1UNzOvhXD4NU+KL
 dmPg==
X-Gm-Message-State: AOJu0Yx5fkpZoRQna+cs4stCyRCg0VeSZJudyt8zr3hBJtdP4LcU0rJB
 kiB20LSsNBJVGd+ynCJjVQD+XVYd1SZZRv4dM/4avBHVggzgcZhApnD4IUG6YcUhFS5hAcDNFuu
 MfSDCcZs=
X-Gm-Gg: ATEYQzzQIr4gIY0RAAXkrNF8ENbrXSF/B16rpdX989NXdR4ycP2yb/AvBqNrlTbM+Iz
 y6OA6gwzf7pXdO7f9ndc9FWzH15VoGbbcwPLSFdJjrRjEgkwMYMKU1aBztLws2T27aeoj8SJqpY
 kHM2zz22Tjj0DBGKzDBOuRZEshgmxc9jMBTeLLCAIpNy0y3v1shVKJYdc06RE0VOE6bGfyMfEkI
 XZ1kGuoLWUR5WOBiO9+pqQT0tkYEAaQDbnoGv7+GnHIhPOSwaIEL0xcp4WzPFV5YrtrwQMYgYh3
 PVUTxVjcMtIJlGvXEIXI8Sa44YOg2OJjQzpbpyrs5RmVJidPWx9wJI76BKqQUNgBWXVsKiWV3iu
 ruvDBQ13YnuiBmvFZ6ok0ThJmzBG9Ck31SCXqfnRH4h+lEDKN5fpXpbD/ByZVkOi0Bp5RoD24rt
 DFFlXCnfcE9SCu5UFDgR8VfOf8nrTTDolYsbs4h4gjA+x6vbxiH3A5+2LOgPqIymXdNeHE/HOUH
 LlLnGUJrI6X2tBS1xO0bqnnMJNMKRMPbXug+eVTby/jt4pEe6Q=
X-Received: by 2002:a05:6830:81f9:b0:7d7:b682:65f4 with SMTP id
 46e09a7af769-7d7bb6e99e9mr1041877a34.8.1773710682813; 
 Mon, 16 Mar 2026 18:24:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae398fcsm12889108a34.16.2026.03.16.18.24.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] pinctrl: Correct dependencies for PINCTRL_TH1520
Date: Mon, 16 Mar 2026 19:24:41 -0600
Message-ID: <20260317012441.4162586-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issue with the dependencies
for PINCTRL_TH1520. It really needs to depend on PINCTRL_GENERIC rather
than select it, and PINCTRL_GENERIC in turn already depends on
PINCTRL_FULL.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/pinctrl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 73dd5ff4a793..360f2156c065 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -345,7 +345,7 @@ config SPL_PINCTRL_STMFX
 
 config PINCTRL_TH1520
 	bool "T-Head TH1520 pinctrl driver"
-	depends on DM && PINCTRL_FULL
+	depends on DM && PINCTRL_GENERIC
 	select PINCONF
 	help
 	  Support pin multiplexing and configuration control blocks on the
-- 
2.43.0

