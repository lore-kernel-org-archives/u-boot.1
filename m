Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053E8C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B94D8407CB;
	Fri, 11 Sep 2026 12:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ij688znGCiYl; Fri, 11 Sep 2026 12:06:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7939D407CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789128376;
	b=K4nGU9QQs7OnToyA32Eh/5khPVz8aBQnlKv9QfpxKQoDIboxAs6nqxVUF2gqdPu774UZ
	 vgPoouVfHwfM9UlC2W8slYT9/rjlOpug1ZLrVF3cUsoaA9+5/rqy+Pqzjdgb1sr+i8ZGS
	 exnbQRxfKkIVzYkTJGp1R7bumL6ICIbx42ATwwZ83VokXIPiI5jqiZb2BiCV5TuoebcVD
	 5QPh2X2KUnKNMEIsp6fYzbv0cztpoF51+WjZFVjhf9NEN4OYPrUGk+0YQ10WNFtrkc9Ct
	 n/VY8A01nlPwi4UfRH+LGAlWuHrQXdg0ntwVXiuwI4MxBbdMAkIPQFKxIRpcikq/qag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789128376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
	b=FhxHys9JF9FUk/Le4so57OM768eEQ1drh/QXe1syRr9nTBhokSf1QrkRCeTlH1Bp2K3H
	 ZgeIp4lu/2IdncudqXlB7rQJj8p9FLYgoDCUzQl+nH7xQVp4GHBpk7IIGVS7qMGjs6NuY
	 HcsV2fIq9OGv2RXF2YKQbKhS4jr4214WwadFzINz9cRkWd6+ZBIQ5DHTRY/F0WMecvoug
	 Rp71WODG7jMW6vglOcFmleQoahgF5UTEA6g3jNNs532VmvttAjuPN9b0Dbi8Lh71SwPiz
	 m1xsgaQydh9x1BBAfxKtDbyE9FATbzc1XMu3dMJpbfPcze+0b8k3ibUPoX92DlYLKew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789128376;
	bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfLl1AKbGlTizzIaNES+4P+GcAjHgz4NHAwXpDh7Etky8MhTx7DUaIRe8ibdBmE5t
	 F+iVMYLHsjQ4HamxEzv87RJLUboas+iC8r5iUnj5eCldoIyV8b0/taPrHg18wo2O4d
	 b9ouxWHQaMf/lX6bFaGOKVzd2NUiLN3oWnuykiiAZIBwwmP+J8nRd+/IBpBqfhN1ES
	 KHkK4vLOwnbOiIYErZYbLv13Q5e5gZOgOqGac3n4MV6EJf4RwpBDJFJqYww0YM3pGY
	 VvJHGjSer09xf1ECP6g0CgeADKx3ASWBpZlqdgz4GSIbQTsdyksTwdevxQQLaWSesl
	 w3QjCAa+PRlGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7939D407CE;
	Fri, 11 Sep 2026 12:06:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EE712E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30F0C80EDD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id za_FJMT9p6Jq for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0DAEA80EC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789128373;
 b=RM7z3WQ9aBqhIwQZDxWzBmRW7NkwiZduBaseXGE2wPEuXhGhkEWtCaUy3TOMiawiPDad
 9kMnDVLZxP+KuUEHa3MfrO+o3G/RZGIG9l+I2PRe+hrSc3id5QQMzhwIe9OrrqN0LiHt6
 SDq+MKasbSoA+N/14YWDQ7GF4fUd9hg+rLRm+D7D5t223o3SXk6yIxHT+Km0bqtTtOlzd
 1WKPsqpPddVI7IzlBGuJVVgurn1roO8nRTYHUsCsQQSAYWZxTGMkltuRXYSUx1JQekqi7
 f8MHhkDEwKBuUFpPUB0wpoLJLZvJYK1mLLpuLtr2hEsc7zcl8bxEuOpc/6FWJMzrxYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789128373;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
 b=KXxDX7L1W/3w7lexvF4x1f35tN4CdvlR/gx7Ms9A77UPoYYDfXMjHD6Qr/XqN4kAXboT
 4XVYXGTl4GV1Cm6tscVtXWa5oqZqTh+l7jyTCI05SuXDN+a7z7woirJEJWf3OQuaC2O5X
 PVvd05FZOmYGShmLKFIoTQAY5ImOFR9lVqrldr/hX2mEi0AT3BrS4kMits2OhtV+ICO2b
 Q36tx7sjVMheIVCZ/+sWL8fviVprWiaNMLe0C9HzE2sJW2i6XDzVRLMRYaCCShAnM6cPk
 6syB9G3cGdyJ60XMr8Pxi7utNspPDSgle1dJpAL9lIDT0kY+gJGpxXrAK0852V99lNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OFDR1Vet; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OFDR1Vet
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DAEA80EC2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:12 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so497240f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789128370; x=1789733170;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
 b=OFDR1VetRgNHBwoH3S/IHrHUWcYDa/LJnp4GpXVNqF17L+uvjIfTnC5iE9+36USPrH
 EKpGy6zVTLt712IrPKSVP5iGm5ERG+z5BTBZYYMSYq6HZPbQIyqsOj/Ir/3QR8uNNu3r
 idMjfYw7BeGUUik70L+lEQ9XcRO4fXwpa0U3UlfI8N4cqdrmcEpUX1MIXwOhUyq39Se9
 SvPqgtd+JqoqjpD4nGsaEDz1C1elS5qDzVnALIKnlgrC6ozKeUq3gAagO2LzRi6hWdU4
 GjlzQbpOgZRRJ8SBRut03Q4O4bbifewcvQaiSqiX7H7zgzZsFdM1o11SFLBfct7BtNdw
 CGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789128370; x=1789733170;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d5eaHkYIX3NVCsDR8ydkaQHJuSCv0DbjiyseA+kNAGw=;
 b=AW9skGabN08ax8OTLio+Gt16YGtvQeVtzSjZjab+JlYZZ56sGJCqbTK2r44VLEMNik
 cSFy33BWRqB9YGbxfXYZrPXMfT6julCqgTKO+8PNMGtwUMUX1yd/rlaMHYxB6616L+xk
 Dx0laC4/6jyVv1HUnTAjZVhDQPEdFab9qa4RKx+s5O/yiyvNQm8/cjwF4f14QpBE026a
 6GpQZ96aj83m0Yyda4dG0bimHS90etUrtOUu8SBDTh9WK6l6btn/97WcM9/dPb9lz+ix
 uMTZhOUzV29C2rw4VlsqgSphie4ovBWYwCF24r3BLm4CJIudzqJCxQVJCTv8q0fgUGIu
 EjPQ==
X-Gm-Message-State: AFuF++lrWzRS2yxz+OUL5YNgJS9TgFX4Asq91usIA7EiKY98lbR1Pwjk
 r3gmd68XDsdBVqWwWVmPNHUFwgLs8RTBVvxShzujz/8CmVMuMWA4Hdv4qm7V2vC9LDg=
X-Gm-Gg: AYBFou3tP+3n1OjZzhy9naASOqtna8s0s092yMzy3hJdmC6MJItjK2k09GANxt2HZxF
 PbFhfOcuVhQEJUwI+F1YcO0QZH1qw3rme1a9iyunYrGNUkR1OW2CT8NyVNhmC3alDwV2RkyyUWR
 O/AuX7L7IKZs99WHfjW90UO2atXsYo46Q4FyFXNpvuFpAg1VVtk8ZeEj8UsxvcKVdqbekOIxJq9
 t4EyeEXHVf3Ounr2+w9l9pPvL1jRjua/AwteiqmBaBaJpLGZMpygDb0dS3MuGP4Anw447+ShJMv
 5sYCuUDpu65OI0iG8bWxG/ZvXA5KB+0T0fenz7faXeZHQPhTb/k04N//v5mHn0T4XacOiHSpZ+3
 UrQiRqC9t9Ns/hn83aJO+Cv2G/ymn74rELKxhzkUx2wErwsw3OXsxHR84tEgf/XJ6ibyaWbGnN3
 kR7qtyCIPbHI3k1W6v3iNaY0ifZn6L0kr/eb6dcyG8Vqh51Tb+nQgydjdUhYGSMjC1YDh015Fry
 n4co2qjma9BhEQ8bGP3+ky+lu/bVtYfKsR2A31Fw5wRdQVxrnUMKAUFNkRnA7EzQfwc/tL2XNY3
 Wux28Os+OZyLmXsRbzAShstQJg==
X-Received: by 2002:a05:6000:2311:b0:485:8d9c:47d2 with SMTP id
 ffacd0b85a97d-486e0f955c8mr11697069f8f.30.1789128369703; 
 Fri, 11 Sep 2026 05:06:09 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm5824487f8f.37.2026.09.11.05.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 05:06:07 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 11 Sep 2026 14:05:58 +0200
Subject: [PATCH v2 1/2] spl: mmc: select the boot partition after device
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-ccaione-upstream-part-dynamic-v2-1-295fefc9a3c4@baylibre.com>
References: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
In-Reply-To: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
To: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Boards may need to read boot metadata before choosing the partition
containing U-Boot. The partition hook currently runs before the MMC
device is initialized, so it cannot do this reliably.

Defer selection until the raw partition load and provide the initialized
device to the existing hook. Explicit partition loads keep their supplied
coordinates, and a successful Falcon boot needs no U-Boot selection.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-stm32mp/stm32mp1/spl.c |  2 +-
 common/spl/spl_mmc.c                 |  7 +++++--
 include/spl.h                        | 15 +++++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index d2e41b8e65f..2229ebf5eeb 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -62,7 +62,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 }
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-int spl_mmc_boot_partition(const u32 boot_device)
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	switch (boot_device) {
 	case BOOT_DEVICE_MMC1:
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index cc16709dc9b..3e637f5adbd 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -301,7 +301,7 @@ u32 __weak spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 }
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-int __weak spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
 }
@@ -431,6 +431,9 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 			return 0;
 #elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
       defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+		if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) &&
+		    raw_part == -1)
+			raw_part = spl_mmc_boot_partition(mmc, bootdev->boot_device);
 		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 						   mmc, raw_part,
 						   raw_sect);
@@ -466,7 +469,7 @@ int spl_mmc_load_image(struct spl_image_info *spl_image,
 			    NULL,
 #endif
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
-			    spl_mmc_boot_partition(bootdev->boot_device),
+			    -1,
 #else
 			    0,
 #endif
diff --git a/include/spl.h b/include/spl.h
index 5078d7525ab..08a84536f51 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -595,18 +595,20 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device);
 
 /**
  * spl_mmc_boot_partition() - MMC partition to load U-Boot from.
+ * @mmc:		Initialized MMC device
  * @boot_device:	ID of the device which the MMC driver wants to load
  *			U-Boot from.
  *
- * This function should return the partition number which the SPL
- * should load U-Boot from (on the given boot_device) when
- * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is set.
+ * Called before loading U-Boot in raw partition mode, after any Falcon
+ * attempt. The hook may select the hardware area containing the image;
+ * it must leave that area selected. It may run for each MMC load attempt.
  *
  * If not overridden, it is weakly defined in common/spl/spl_mmc.c.
+ *
+ * Return: Partition number to load U-Boot from.
  */
-int spl_mmc_boot_partition(const u32 boot_device);
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device);
 
-struct mmc;
 /**
  * default_spl_mmc_emmc_boot_partition() - eMMC boot partition to load U-Boot from.
  * mmc:			Pointer for the mmc device structure
@@ -972,7 +974,8 @@ int spl_mmc_load_image(struct spl_image_info *spl_image,
  * @param spl_image	Image data filled in by loading process
  * @param bootdev	Describes which device to load from
  * @param filename	Name of file to load (in FS mode)
- * @param raw_part	Partition to load from (in RAW mode)
+ * @param raw_part	Partition to load from (in RAW mode), or -1 to call
+ *			spl_mmc_boot_partition() in partition-number mode
  * @param raw_sect	Sector to load from (in RAW mode)
  *
  * Return: 0 on success, otherwise error code

-- 
2.55.0

