Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C301C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72192884E0;
	Fri,  5 Apr 2024 11:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bX/d/y/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76279882B4; Fri,  5 Apr 2024 11:08:33 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 697DB884E0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso12536215ad.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712308109; x=1712912909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dc669Hxd3L7ik8h7lySNB1oUOUXkl0Eh2aotssT77X4=;
 b=bX/d/y/ryPeE3f0BvpEFi3lQ81uMRreB2KUMw6itjOEL/2Oeb6p4J6/+J/tKC/Ocw3
 Bhso9GGM3/t0KPA95i3BzR2Z9aTWg8HxgANiFmfU1PmDOWeggn1zZzpdeJWELMGhGEoI
 SDB9zI/RG7Gy16ue8f1KHWihReQFQtVP9nEgZY3kTtWMCbCwGi78gwqNbLN768iZPHbs
 dZapkCyy/WDwHQSoqcgUG73zM17PzNcm2AnrEraXUFgXW+IIST/taF6lMxrPoW2YUuzp
 3ZUaZhIzkdcQKGQ84+U05WJrkQDEPxtJFaJ7528tUGVP85CeFi62VAsFRMtah7vdtQWF
 mLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712308109; x=1712912909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dc669Hxd3L7ik8h7lySNB1oUOUXkl0Eh2aotssT77X4=;
 b=sCmz9hqGQmlSAGy7Oall1o17jOxQk4WNATITURychToZIzch0DETj5aeTEnSfkkCVu
 k2fxMdhH9XINoDnFgBxL7gOYJUXR5Xvwj3/oVVo2AtoPzEwi65J5HESgRoQYMdeMgxc7
 sP70Lo9r6ObYaEtCvaLwW0Pl/nI2GTnKYtZCXQkRjL6ux9rxn43B/519X0HNq9eN2rSY
 j+Wwjfyqmo2ax3e+Dayeg1pSrjlqmF9lmJY81/CcgqDTWqTQEQKHdV3SnpGWE+jOKDA3
 TOaM3I8oRCDLcInNnEKTBJWKJS+SmxW+ZmNwuTbCdHwafevwnNJFbvyiDpQaWOGT0PxM
 BjQw==
X-Gm-Message-State: AOJu0YzJTNNTQkq6AIsP9qBWPLSkbmrotBINqJ2biDt339110n8UBgIe
 H6EKOhHfciaRPKyho0sVfwA0C8dYXFRv3BjW/zv58fpxQPmIq8GYdasiiSJnez66cG7Glv4ZPpx
 M
X-Google-Smtp-Source: AGHT+IHJkwTbkZPw9ZwHgqM7eKEtIfFhATes8F8bwzImBeJE8fYsAEeB6AGFkanwP49OhryeMJJ8eA==
X-Received: by 2002:a17:902:ec83:b0:1e3:c419:35c2 with SMTP id
 x3-20020a170902ec8300b001e3c41935c2mr798221plg.34.1712308109670; 
 Fri, 05 Apr 2024 02:08:29 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.62]) by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001e2c0b77b53sm1055959plk.255.2024.04.05.02.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:08:29 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/6] qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
Date: Fri,  5 Apr 2024 14:37:37 +0530
Message-Id: <20240405090742.4148304-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405090742.4148304-1-sumit.garg@linaro.org>
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
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

Enabling LINUX_KERNEL_IMAGE_HEADER by default doesn't allow
ENABLE_ARM_SOC_BOOT0_HOOK to work properly on db410c when U-Boot is
loaded as a first stage bootloader. It leads to secondary CPUs bringup
failure and later causing the Linux kernel to freeze.

So fix it via selectively enabling LINUX_KERNEL_IMAGE_HEADER where it's
actually required.

Fixes: 059d526af312 ("mach-snapdragon: generalise board support")
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4cdf08dd695..08ae7e51a6d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1088,7 +1088,7 @@ config ARCH_SNAPDRAGON
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
-	select LINUX_KERNEL_IMAGE_HEADER
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	imply CMD_DM
 
 config ARCH_SOCFPGA
-- 
2.34.1

