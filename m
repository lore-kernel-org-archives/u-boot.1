Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D618E784BE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E93683C65;
	Mon, 29 Dec 2025 02:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XXdkgqDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3459B80325; Mon, 29 Dec 2025 01:06:00 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A478003E
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c75fc222c3so4018959a34.0
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766966757; x=1767571557; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cUvMQ3xZaXZhiELlYbthjMqzCPf37by5U4ZKP1wq7zU=;
 b=XXdkgqDcEMGtsIafx89ZvJ041l/c/DDxPT07kfNE2E1Sz6le5+KoZqyHs3qrOiuzsN
 dJXMKdpKvaOzceSp+/GKoXv80fF+G4qsfLXODOMqdcstlB48nuZj0LEfaBqKA4lsJWm1
 lr+cnZjQLw+bDP8vpJgkqZsDzoy9rX5wg70BLX4dKvq7aJ15NlyBbva0EPYXUbKoHmJS
 5jC23J+GKHKUY5Il/lJYfJGOwxjWwOGd8rfDkNWlDi3pNjWhCGnKvWb/UUQx7DdxkpNy
 xNgPEMS9gnhGiI3KDPi6xasePFWDWZ7QuzJhirF8FZ7xKgiNltv+C5QBq/O13//VKQz2
 IPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766966757; x=1767571557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cUvMQ3xZaXZhiELlYbthjMqzCPf37by5U4ZKP1wq7zU=;
 b=rIGWeypETD3WhWWjkCNpY7ChNZzdxCgSwxnKcxnVv59JICzqAJ9b/g/3gLrIbtcO4Y
 FyuCVckpnXJLhnOcCtuSGx4CmiSQpKhUiLPK4b9fbG+WZtT92ePK3r9CiL02gzD8Fb4H
 GAgA+ewTjwB6bCXiFElGtRWO0jdzAAK8tNxrqMu19K2Aw0dHirogZ6oKG4iSHL33TM53
 LImnAefhqZ/bHz/tY3Y37lKaTKl2vL3K9Lkpqp+1D/oac+R7/6PjG2wJU+FpUwvLCWmD
 /WJctHYGJcM7dvXvnx/0ZZO3oo9/IxJP4wdUdiuWkxsNvWnsy9m/lAkwWlekb4eS9coH
 aXyA==
X-Gm-Message-State: AOJu0Ywdb66YSiQru/wBmzS99/po+mPX+D46fpAKx4bx3qKvEK1yR8t4
 l+9qtl9XrJ0HXgI0+/KU8iMqfG9sDhGfY2mWoBXjhSESZvw3rR5oHZLV
X-Gm-Gg: AY/fxX7mWwCARSRF2teLVgOQwK8Z1ScLhVBeu+lU+Ma55uIcRubA3ZLdPRgNHxOthDv
 +Fzlj2mQXFBzKdRQ7k9THMtlsWQ3elaUI2FATZbr0qFfBQsA8QvIHfW2xF/ue4vXQ9R1jEFF3Bo
 5We8QjRMOkDljN8cmydF/rASHFl4FDfntU3DLdWBP7q1Xz+TlL9HVj7SyLTQc+LKn1Zw/mctWMn
 ZI1z8dEmkvho2zjd+ZTpjKTrH9jJFXPyGn2IT/Uq7L6gQVbLk8N7Bba3pNQ9yKQnUXOBc/p1jJO
 pozKIdML+j0Gi5ymFyspej9RgYIFvjDwxaZREOpPjvnq88Zs2DJA021JCYSvGlVLq8idaEUQQko
 Tq+asNXlSoJdMZcbSjfFAutMrxsKBuBCJA0u65tY7izSfDnZKhRY4gUR7AOvQimIinYrkg6K28s
 rPAuIM3ActJloNb9Btyp9Ft9j/YKSZzV21432TcoaNkjl8h4b7+6zWV7oT
X-Google-Smtp-Source: AGHT+IEe8j2p9u5lCmuUoFI22AgtpkD3rVZFoo/iaRs8sEL221ZiawJwE7iu5Zjz8kkzZQcHH1wa2Q==
X-Received: by 2002:a05:6830:4ac4:b0:7c7:6063:8e0f with SMTP id
 46e09a7af769-7cc668eb42emr14402662a34.15.1766966756713; 
 Sun, 28 Dec 2025 16:05:56 -0800 (PST)
Received: from [127.0.1.1] (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm19397294a34.28.2025.12.28.16.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 16:05:55 -0800 (PST)
From: Aaron Griffith <aargri@gmail.com>
Date: Sun, 28 Dec 2025 19:05:23 -0500
Subject: [PATCH 1/5] rockchip: sdram: add option to read bank information
 from TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-rockchip-tpl-use-atags-v1-1-8ac5140c3763@gmail.com>
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
In-Reply-To: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Aaron Griffith <aargri@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:48:58 +0100
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

Existing code to read DDR_MEM tags from the Rockchip external TPL is
gated behind CONFIG_ARM64. These changes instead place it behind a new
config, ROCKCHIP_EXTERNAL_TPL_DDR_MEM. This option is implied by the
four SoCs that currently use this feature (RK3528, RK3568, RK3576, and
RK3588).

Signed-off-by: Aaron Griffith <aargri@gmail.com>
---
 arch/arm/mach-rockchip/Kconfig | 11 +++++++++++
 arch/arm/mach-rockchip/sdram.c | 12 +++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index e32e49ff59acc633feba96f8870754b60fc366c6..1f80ff3136e2bb565a2f4be59d9b025dd0d70d95 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -348,6 +348,7 @@ config ROCKCHIP_RK3528
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_EXTERNAL_TPL_DDR_MEM
 	imply ROCKCHIP_OTP
 	imply SPL_ATF
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
@@ -392,6 +393,7 @@ config ROCKCHIP_RK3568
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_EXTERNAL_TPL_DDR_MEM
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
@@ -432,6 +434,7 @@ config ROCKCHIP_RK3576
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_EXTERNAL_TPL_DDR_MEM
 	imply ROCKCHIP_OTP
 	imply SPL_ATF
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
@@ -477,6 +480,7 @@ config ROCKCHIP_RK3588
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_EXTERNAL_TPL_DDR_MEM
 	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
@@ -608,6 +612,13 @@ config ROCKCHIP_EXTERNAL_TPL
 	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
 	  include the external TPL in the image built by binman.
 
+config ROCKCHIP_EXTERNAL_TPL_DDR_MEM
+	bool "Use DDR_MEM information from external TPL"
+	depends on ROCKCHIP_EXTERNAL_TPL
+	help
+	  Some Rockchip external TPLs provide information about DDR memory.
+	  Enable this option to parse and use this information.
+
 config ROCKCHIP_BOOT_MODE_REG
 	hex "Rockchip boot mode flag register address"
 	help
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index d560f90e873d02e1a799ab0d7c1e085df0c1c54a..f549baaa8e7e0664029f37de012dd22dfe92b07f 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -36,7 +36,7 @@ struct tos_parameter_t {
 	s64 reserve[8];
 };
 
-#ifdef CONFIG_ARM64
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL_DDR_MEM
 /* Tag size and offset */
 #define ATAGS_SIZE		SZ_8K
 #define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
@@ -287,14 +287,14 @@ static int rockchip_dram_init_banksize(void)
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_ROCKCHIP_EXTERNAL_TPL_DDR_MEM */
 
 int dram_init_banksize(void)
 {
 	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
 	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
 
-#ifdef CONFIG_ARM64
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL_DDR_MEM
 	int ret = rockchip_dram_init_banksize();
 
 	if (!ret)
@@ -302,7 +302,9 @@ int dram_init_banksize(void)
 
 	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
 	      ret);
+#endif
 
+#ifdef CONFIG_ARM64
 	/* Reserve 2M for ATF bl31 */
 	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
 	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
@@ -314,7 +316,7 @@ int dram_init_banksize(void)
 	} else if (ram_top > SZ_4G && top == SZ_4G) {
 		gd->bd->bi_dram[0].size = ram_top - gd->bd->bi_dram[0].start;
 	}
-#else
+#else /* !CONFIG_ARM64 */
 #ifdef CONFIG_SPL_OPTEE_IMAGE
 	struct tos_parameter_t *tos_parameter;
 
@@ -340,7 +342,7 @@ int dram_init_banksize(void)
 	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
 	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
 #endif
-#endif
+#endif /* CONFIG_ARM64 */
 
 	return 0;
 }

-- 
2.47.3

