Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5B3C3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 16:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443AD877DE;
	Sat, 23 Dec 2023 17:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQ8o1/Ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA71877CB; Sat, 23 Dec 2023 17:45:54 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DA1876BA
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 17:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a235500d0e1so293195366b.2
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703349952; x=1703954752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EuibXtYxBa2Or6x75XxPjAmyyk8Bo/S0OL5GNGpuPE=;
 b=HQ8o1/TsIl4SFczh4UovGfl275c5sgyTWh5xXkmaXRXendLglJK4iZfdVZtNgEADWs
 tSvoMHBbsITQsF5L08LJoWusWtzhmesHL1tlk5LIw8qiqLOetul0gzGi6Sy8rTTT9yK+
 iibnBdFwf6aws/kJdOMMSv2eaAhl49+F6EaqhsbvLEgJSleXgw+x0MaHEIGvS7iV9tLa
 xXt+0Pbhqw34nAAxr06fxKJR0TfwM4KyCqTKWyMKSx16fqCRUHgWzOKigscT37aZqMFU
 84twRI5uE2XNraI224t7BLZjFxrPu0d8DeWypYYKe4w4YeNhr5KnPp7UAq/Stu52GijE
 7AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703349952; x=1703954752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EuibXtYxBa2Or6x75XxPjAmyyk8Bo/S0OL5GNGpuPE=;
 b=hEgRpQyLpkXEZik/4nDNvZoEVBgVsKHuBZlHhE6EAnz7QSMHdz7qBW5tw7GMkLhnpH
 WIV9IeAhR2qJ6GjVRGgiHUTEoUEAB5ctqDs5fBRq/ti4dycJg19cUb0AU7WrrgpsQsjP
 LpXwYlqpVuxgFYwd+dgHMyjCkVGQutfl6E6GGAeJIpnzlF5M07ffcqbVUcrYMrRlwJQb
 q+pcavhaVLFbnW0b8NZ2zN8UabXahyz08JmjC8FlNDH+nOkm3aXA6YOeNR0orDAEjClc
 QscPhuoCH8lUKEyU0REZWrNACBIrR0be6Q4mLCz4UDqufZZ2UApHSFvmcesB+g8+0UgJ
 dDTA==
X-Gm-Message-State: AOJu0YyeIkTbGUYwYIPYBKyjIqAmPZENrfhSDZVFxCqnSgaGLU4XPSRt
 1YYcsZtcYUijkym0ao9xu8Y=
X-Google-Smtp-Source: AGHT+IHS7NtbtqAapGoQh2thxq5hM+3aA8CMjt6jydGVTm+WBMkwdxc4XcDhMx3j9f9mhr4EaptlxQ==
X-Received: by 2002:a17:906:b746:b0:a26:9dc4:6695 with SMTP id
 fx6-20020a170906b74600b00a269dc46695mr1491214ejb.39.1703349952267; 
 Sat, 23 Dec 2023 08:45:52 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 h1-20020a17090791c100b00a235e5139d5sm3221139ejz.110.2023.12.23.08.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Dec 2023 08:45:51 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Sean Anderson <seanga2@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] ARM: tegra114: expand MC register map
Date: Sat, 23 Dec 2023 18:45:24 +0200
Message-Id: <20231223164525.3660-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231223164525.3660-1-clamor95@gmail.com>
References: <20231223164525.3660-1-clamor95@gmail.com>
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

This expansion is required for nonsecure detection to work correctly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra114/mc.h | 29 +++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra114/mc.h b/arch/arm/include/asm/arch-tegra114/mc.h
index 3930bab571..2fd2f50b0e 100644
--- a/arch/arm/include/asm/arch-tegra114/mc.h
+++ b/arch/arm/include/asm/arch-tegra114/mc.h
@@ -25,9 +25,34 @@ struct mc_ctlr {
 	u32 mc_emem_adr_cfg;			/* offset 0x54 */
 	u32 mc_emem_adr_cfg_dev0;		/* offset 0x58 */
 	u32 mc_emem_adr_cfg_dev1;		/* offset 0x5C */
-	u32 reserved3[12];			/* offset 0x60 - 0x8C */
+	u32 reserved3[4];			/* offset 0x60 - 0x6C */
+	u32 mc_security_cfg0;			/* offset 0x70 */
+	u32 mc_security_cfg1;			/* offset 0x74 */
+	u32 reserved4[6];			/* offset 0x7C - 0x8C */
 	u32 mc_emem_arb_reserved[28];		/* offset 0x90 - 0xFC */
-	u32 reserved4[338];			/* offset 0x100 - 0x644 */
+	u32 reserved5[74];			/* offset 0x100 - 0x224 */
+	u32 mc_smmu_translation_enable_0;	/* offset 0x228 */
+	u32 mc_smmu_translation_enable_1;	/* offset 0x22C */
+	u32 mc_smmu_translation_enable_2;	/* offset 0x230 */
+	u32 mc_smmu_translation_enable_3;	/* offset 0x234 */
+	u32 mc_smmu_afi_asid;			/* offset 0x238 */
+	u32 mc_smmu_avpc_asid;			/* offset 0x23C */
+	u32 mc_smmu_dc_asid;			/* offset 0x240 */
+	u32 mc_smmu_dcb_asid;			/* offset 0x244 */
+	u32 reserved6[2];                       /* offset 0x248 - 0x24C */
+	u32 mc_smmu_hc_asid;			/* offset 0x250 */
+	u32 mc_smmu_hda_asid;			/* offset 0x254 */
+	u32 mc_smmu_isp_asid;			/* offset 0x258 */
+	u32 reserved7[2];                       /* offset 0x25C - 0x260 */
+	u32 mc_smmu_mpe_asid;			/* offset 0x264 */
+	u32 mc_smmu_nv_asid;			/* offset 0x268 */
+	u32 mc_smmu_nv2_asid;			/* offset 0x26C */
+	u32 mc_smmu_ppcs_asid;			/* offset 0x270 */
+	u32 reserved8[1];                       /* offset 0x274 */
+	u32 mc_smmu_sata_asid;			/* offset 0x278 */
+	u32 mc_smmu_vde_asid;			/* offset 0x27C */
+	u32 mc_smmu_vi_asid;			/* offset 0x280 */
+	u32 reserved9[241];			/* offset 0x284 - 0x644 */
 	u32 mc_video_protect_bom;		/* offset 0x648 */
 	u32 mc_video_protect_size_mb;		/* offset 0x64c */
 	u32 mc_video_protect_reg_ctrl;		/* offset 0x650 */
-- 
2.40.1

