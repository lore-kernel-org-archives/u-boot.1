Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEC0CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 11:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32CE836C1;
	Thu, 25 Sep 2025 13:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JVqCRMcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E1F83710; Thu, 25 Sep 2025 13:56:48 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79831830CA
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so684852f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758801406; x=1759406206; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JnL+qLFR+Yh1i61tXnLgxZCPbHw9TMGycovl0q1P9E8=;
 b=JVqCRMcp5LsL7R++PV9EiKMQ2qWni5g+s5YIFu+sEOTptY62hBAqqs1/kDpIroZDsc
 FQ8swJ86Mkx6jTY8MyFqHICRO7YoI0SDDjuZmAHMj16iP9sCefgMsRz0n0EOWWYvixt6
 NLS+yfTDAyzsWlMh7+w+1IoBFEqr27OiHnK0ykujZWsiE/hZDaC3mNquzMe8QXAZEVkO
 VFJyAUvFSqpx4sXP3tIlJHHCZXFwW+lKDJUdXGWwLYZ49Nlq0xPdEtgOMMtoqoxZHxHU
 xdXxhQ4Z0AI2Merbljb/FQ3IutDJwVkt+GDn53ULLAbFz0cah1Zw+3+DOrk5bP1xIRG8
 lIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758801406; x=1759406206;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnL+qLFR+Yh1i61tXnLgxZCPbHw9TMGycovl0q1P9E8=;
 b=ncKxkNpcGMsTtH8StA9VgUnXqAy5msSqaMDEAh73LQ/78X04FGMGDtaakBEQDQDXaW
 mxXlAsMVZfxk7PCa4lvtO+7ZaYEEQyu9mBjAXP4jmqwHoERtNWrVTzQWPNhax3QKQNuP
 QqPS32WkrRYnsQ+aZIRsSz+5p1ssF2t+57auOwaNjD5MkicB0vdCL6bTo+0TLLYJbJb4
 7nvpNQAYFemkEXJ9w+8duv1EBiEdiEcEyWl1a7/sFdB75fnQFfIOPcsv4uJqoQcCW1N+
 PvPoi9fA1g5H0aqUkX7LBuMxPVX5/1rDgXJr4dLe61N1Nvjie5FVR8hh8iQgzMrkAQHt
 bQHQ==
X-Gm-Message-State: AOJu0YwLCEyHA+zkw895ehHkdaGTjutDz/WK+vcNW2Fu+L7XqX0jI4SH
 r3tIekP/z6/I5nRD2t8TWyB1uL9cV35CBdVp9KdAs9b/Mro9qb3nL043RvFCt2odtyUpq9U+uCW
 eRQQE
X-Gm-Gg: ASbGncugwaifAldqrlpkyfHYmBoMYuYOU1V3siuLY8txD0rtvjGEMFgj0X4U5xgG4b4
 SXXJm5/1//VZYofDU5sdyl5mDNtiXC8aXB1a9w1ebAwRFy/nhZwK4hkZkXncc4Pvf1sgEAAyNAu
 HvsHQU5JHJLcA0rDKoA31shhjihWUw1XRW/rRbiehHJlz3BE7iQBNoxPUbjT3RABf+A/083hwCn
 YMsTrIvwZABGPr0uNEgJeFU9F0owAEjuJOXjxQV3CRXFnh9UMdulZv4Fa84jkh+vG9yh1Sy1gfw
 9gQn4f64qw3smtprlKOK4YMoDqDqzHlKvoToF/lSFxpiZy894NXPbbt+NHLLJcHc1wlsyDmoXTB
 /lASdjppK4xMgeLJXerqQV536D19Roo/Sp8Zmd/XHWLqjg8J6OdY=
X-Google-Smtp-Source: AGHT+IHV5kyIwY0yBb/ASMfEzF9twqqc87ylLh3kgzzj93xJP5/aOq9KRJDgZac+QG6wIGXsMGxz4g==
X-Received: by 2002:a05:6000:2203:b0:3ea:63d:44ca with SMTP id
 ffacd0b85a97d-40e4adceb15mr3044019f8f.32.1758801405920; 
 Thu, 25 Sep 2025 04:56:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b9e902sm30352405e9.5.2025.09.25.04.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 04:56:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 25 Sep 2025 12:56:44 +0100
Subject: [PATCH] usb: fsl-dt-fixup: Return an error code on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-fsl_dt_fixup-v1-1-c11962904d5b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPst1WgC/x2NUQqDMBAFryL73YCGhmivUkpI9EUXSipZLYJ4d
 6OfM7zh7STIDKFXtVPGn4V/qUDzqKiffBqheChMutam7rRRUb5uWFzkbZ1VaGxn2qeNsKCSBC9
 QIfvUT1eUsC2XnjPK/n55f47jBPHKhfV1AAAA
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

fsl_fdt_fixup_usb_erratum uses strcmp to detect an error but then
returns 'err' without it being set to an error. Calling code may not
detect that an error occurred leading to a silent failure. Instead just
return -EINVAL.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/common/fsl-dt-fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/fsl-dt-fixup.c b/drivers/usb/common/fsl-dt-fixup.c
index 6a68bd76c27..55176f7a871 100644
--- a/drivers/usb/common/fsl-dt-fixup.c
+++ b/drivers/usb/common/fsl-dt-fixup.c
@@ -99,7 +99,7 @@ static int fsl_fdt_fixup_usb_erratum(void *blob, const char *prop_erratum,
 	else
 		node_name = node_type;
 	if (strcmp(node_name, controller_type))
-		return err;
+		return -EINVAL;
 
 	err = fdt_setprop(blob, node_offset, prop_erratum, NULL, 0);
 	if (err < 0) {

---
base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
change-id: 20250925-fsl_dt_fixup-b1795847fe7e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

