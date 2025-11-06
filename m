Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7719CCCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 11:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A1083B7E;
	Thu,  6 Nov 2025 12:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kP8FLaLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0469083B7F; Thu,  6 Nov 2025 12:02:01 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA6183B72
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 12:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429c7e438a8so786663f8f.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 03:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762426918; x=1763031718; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qZ5UM7ykr6iHsqZktuLyza1mmgeAcooPHvX25WOqvbM=;
 b=kP8FLaLmt1dFTBPhrgpRWsj1sFlV+9H70sPGWWiM3TnPsejuC8zF5bOrOmJK8XsEGW
 OZWpc0LNSCD3CAJ/f/CQGo+HKLMseD3N2w9QmTmLrQpaRBpgrnmG+ikOv98+3TaqdyVa
 xaX2lzdd5Iul3Pew46P2wxpziRTIHKy5joP3EdpBcnL9A5jLxVIyEweRMDTcBzpay5VR
 cBcGviO6N85qBIkVmMtDnaGj5uVvK6kY9KuVUJzcDXGTX/DNcZD/4mcNrqY3BUsjdasx
 hA5z7ADIJvxuf+dvxy2M8bIm0mIRfKDOzkuQzkl+DfQjzUDK0O6LqDnSC5ebwSmXAcvf
 GfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762426918; x=1763031718;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qZ5UM7ykr6iHsqZktuLyza1mmgeAcooPHvX25WOqvbM=;
 b=lDfrn4qji8bSu41qOt1AYqo/J7OrfsCLf+l5cvWYG4WAVn6vzxRfdHSOI4cjW9jJNN
 mNx2BlObtTzYt50x9gGZztUZbw3i+EFfSgk2Sh3YqNbWsKXRXWHdZuhBesN2YGpmXBOf
 JSthLNOIkyByh3QmRgmo+e59VnZ19f1XPHdIUMseOLlGWvRQcP1QOeNBsPLap/Y7wIke
 NSr9LBkFsWHllWHNMkO18Hit28WLi+UAO2X0BlC1oFddpasm+HLu+O9z8bWwGKtjuzHl
 z6PWQcxF9dAo57G4bVV/AR8K649V99quLQcvOAW9GrX/KTJ6rRJqtr6VcHq2xYDwrxVD
 gAYw==
X-Gm-Message-State: AOJu0YzF2M03XfJrBlE6dS3QW+LMN8VlPHtJWVXYuHTQl6UkgjG1YPgk
 5/8X18nwCMx2Ct3WQlyPYWKI6y1vKkEziYMDpm1t06FVWUL36j6oZokTUcbyC7Q1wx8=
X-Gm-Gg: ASbGncv1vWLUVfWgavDkY5HXEDgIvhLz8XbMKK/uDQJaL5bI1A0Rzevsxf1D92/tjvC
 LKnP/tiDrbFIThZ0c628PndE7Yot6KxtkYmKQ78IwjxHzpzwZsJkfVzwtfOSCkwu8QcbbyZQrZM
 EypX+HIT3+0yO/FxYofQfuYgR3ij3Gu7o+8JE6jzz5NB2RxlmQLT20k2VPLtv/bYF/dhSgtcKXi
 LcqHBfFkJFeeCRwW5huozfJ8U9OvPsLfP9GlGmaEKX2NB4+/ZIZwUHoiI4rHg12uOStLqmEL3lE
 XN9m3r3F2TgmltBNJMUDEDbjNYUjzRDo+X95hbf91B5QPo/BvWPUOl4KaHA/rkwLq7Gd03Mx1Sg
 QetFqWRoQcy99kY+iLTVtCIZyHF+p5hTEDCaa6fqvIrx8YlAnTEMVcd5YhtfikQ1uVuUvKiSO3G
 fvj4oAQ5+/dB/x/h27QYkJ
X-Google-Smtp-Source: AGHT+IGdaKUQP2wORwnYEASzy2AJKRbSwBSUx5QoxwUfxd69enKwo9lXIXwnODwY+cfi8BXMMgc5fw==
X-Received: by 2002:adf:9d8c:0:b0:429:ef2d:5dc8 with SMTP id
 ffacd0b85a97d-429ef2d5e0emr858887f8f.49.1762426918173; 
 Thu, 06 Nov 2025 03:01:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb4037d3sm4412640f8f.6.2025.11.06.03.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:01:57 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Nov 2025 12:01:48 +0100
Subject: [PATCH] mach-snapdragon: enable MMU_PGPROT by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-topic-snapdragron-en-pgprot-v1-1-d2b9e802230b@linaro.org>
X-B4-Tracking: v=1; b=H4sIABuADGkC/x3MMQrDMAwAwK8EzRFYKQmkXykdjK06WmQhhxII/
 ntNx1vuhsYu3OA53eD8lSZVB2ieIB1RC6PkYVjCshKFDc9qkrBptOyxeFVkRSvm9cTEFNYH5Y1
 3gjGY80eu//569/4DfaeTrW0AAAA=
X-Change-ID: 20251106-topic-snapdragron-en-pgprot-ce10531d6e91
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1Kzlf1ovi8ltuvFTbADX1IMhZC6Kx/q+a/5pbCuE1X8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpDIAlpb43CPSuWaBNBo4JpLjfHmX6J68hIJ4PF9ZI
 MR2CICGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaQyAJQAKCRB33NvayMhJ0frGD/
 0Y+Zon8fHnSR1ONDm04eZITZ6JEi23Gth1Po8lSXQFPrEgS3vsfFP0wncxU4iDeJWNTcn42NQkZ343
 odmcGihDl0Pu3LpYmGnR0Iip6hb/ljdXl6B8p+aKFusutXLWD1NbjMA0m8d5Zk+SQvpX9IJ0tX+i8e
 LNzMLl8dNpOOSL8E99Wf4j3g2z+YgyaCJdKlVU3yQDMdf0ViNqEHtL/WHGBaVypcNG0+zAJjV0N0iS
 Gd2wFITzpUyGKzHikRjkJXBJg7jhN64AylAMNYgVGMR9K7hJLlAK9kAW42xJK7sPWZ9c9/K9/LBco3
 3FBnHqlYPTzxTIzE/eTqaR8lOATvY9wQJApZj5wotj25KIoVlyTLta2yJy1zebSM0M6kExa+Oy5sxt
 YUkC0BERB0Ud3mmb25i1CwWxDVGAEeL2FAjqzn9l73DOPGs5RYv0FzHYMMOt4XZ4YXpEEotPtUBYI/
 jxQ3KIp7crtwqpg5HnVgj3r33r55Yyd+UG7XFzwo6fk1lpww+E0eJQja3zs4QfZaV0MmJFeU1rBOnO
 Fdb4NeMfXH9+EOcVourOAEh2SbTODqKUNLOrzAtbtcLqTxwTS4Obr3xiLBnWP2pD4guk59+UpeEIyS
 c2LDS/daAGQ/TdvYIQa7nZLLxPgF9RzL3srM/z0sY3npEOFnVreJLv8Lr4WQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Let's enable proper MMU page table protection to properly
protect write-protected and non-executable sections.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ef834542bd4..b200e9c730a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1142,6 +1142,7 @@ config ARCH_SNAPDRAGON
 	select SYSRESET
 	select SYSRESET_PSCI
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
+	select MMU_PGPROT
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET

---
base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
change-id: 20251106-topic-snapdragron-en-pgprot-ce10531d6e91

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

