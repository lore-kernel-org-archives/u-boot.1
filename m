Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8B1CD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97606848BC;
	Tue,  9 Jun 2026 18:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="3TXQV2jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 876FE848D8; Tue,  9 Jun 2026 18:52:38 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CB1848BC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490b4e1ade7so62698205e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1781023956; x=1781628756; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U+BPdu+ndakijMcdfclSub06nie7r7261eIZ/jznZnQ=;
 b=3TXQV2jdkK6GN3CsvTOnoG1y80FeHCNgS/G8GEUHvC+glQD+pHYaCPArYAESzTwUqa
 WcXEVB1CzeSvsCQ7t76BsDTquAFCdDAA6NcS9BYn1r2n4g2zX/sIY7yom62nWrGSuzN8
 pRyqrpLUMHY1usE1zWvFHlkjQF9icPpeiCMAkXte8UzyHV/NI5lOOjSFCEvRgn5hOMPp
 dsu/h8SZljF6X6c96Tq3mNTxKyY3E8AcG6GukwwJdKBd3hZgegncdMufIhHficEL6/pD
 bzmDp6n7HhzG0hoxsHh3Lgp3We2Bmtdzmg4Slnj7dN8baS3E/Z1kimEWWKXaSQGBxmla
 SuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781023956; x=1781628756;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U+BPdu+ndakijMcdfclSub06nie7r7261eIZ/jznZnQ=;
 b=L1yODp0OoFmw1c/rqH1UCuCVGhVjg8XNlMLmMS0GUXHDlHXbeZgOO0Ts3nYCsKi8j+
 6uf2af7drsVCQIwanFkL1ciKlHCO64ayPU1+eNCuGIdK9kpdLt/+JikV2AgxmVhvroqc
 QsV2BVKzPJoBvpOqJVq2TE5DVBzqkQi4mt78U4vYx44xcLsHkW9uIxf2I2pt6WR4HGvI
 7O80DF9aVjOqArWbtH1okUXH9rA1XbFzU+jUrD2xcZIZqa9PWyuThCmeazPT/1FZU0c+
 z7kn16PdekBPaMHFu8c+ziNWRYHu29ahvThGrd2Yn33wIZcIB1aNmO8HIcC6GK4wOONJ
 4srg==
X-Gm-Message-State: AOJu0YwiO2jd0p8IXnwefCdDHHXHJ/6LkBYOn6Asmv/i+LsDNdSsBeau
 4zg6peOAJUe34nF5Lw5nHhfdB2mpauTU6s2d1JPh9qGEbylF1CDfoidfbxhUAz3Bkd8=
X-Gm-Gg: Acq92OFSKSY3cZ8bbTc2iw/TiFCRPhTT/VK/57pV6dvShULHxwt2KHHmYFtfGCVeANt
 xIhWzcJkCzDde2gWHOswrhItW3rd+gBeWujumnezxfH8+f6DcJr88zUxZOW4VUCL3d3ioZb240w
 YGoJdJFP87Lo640AdGl7CEqRFfZ8xl7ry2wlgrsQyDm5958mHuDA3g2k62zuubTVgwSNtG6GIAm
 F5E/fGds9An4nNagFqj/2mXqjVFKlqmYBNg5k4hX+IypVaQx5Rec1XcgS0yzJWF13pesXozcf0j
 GswcL28AwnlSz94g7L30LondNqUv7ds2YgyQbUzaPgrJAOjjHUHKo4UDLzW9t0asHj6uv0rZRMe
 wwIl+/y5A8JxFvprNXL+8Xb71dmZNa9Wt7dd2f8RWWtLWTp6oqNjRS9faACFIW6cxUrNI1GqmdR
 xZQ/3iK+LWH90klvUY8eirBUS8DmkJXOG+pfP5wk/wS0qkqTWyZS5lhq/L64be1w==
X-Received: by 2002:a05:600d:8653:10b0:490:d079:2919 with SMTP id
 5b1f17b1804b1-490d0792a47mr95988035e9.14.1781023955773; 
 Tue, 09 Jun 2026 09:52:35 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b5b06sm450121115e9.3.2026.06.09.09.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 09:52:35 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 09 Jun 2026 20:52:24 +0400
Subject: [PATCH 1/4] spl: atf: support Linux as BL33 with ATF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-atf-falcon-v1-1-2b20c5e83615@flipper.net>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
In-Reply-To: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4691; i=alchark@flipper.net;
 h=from:subject:message-id; bh=e+U7lTu3uN2m77+hfPREopHeXZYhu2DbIWiWKGfQ6tE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRpuJxpC4yuLzrHkbqIaXl0Wtc6jil8cyVFuw43HowX0
 1/sEWPcMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFQL3mD4HxL9holT1uPBQ5VTuvaGIosfKNdN7vq15kpbYeOy7GN3LjL8ldssWmW
 Yb1vgEl88q7Mlw2Rz38fwNxM+1HIdsA6+GLmeHQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Modern SoCs such as Rockchip RK3576 need ATF to be running to provide
firmware services to the OS.

Enable the ATF boot flow to allow using Linux as BL33 (including its
calling convention) to facilitate Falcon mode boot on such SoCs.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_atf.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 8bc5db773950..1f030cab0928 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -17,6 +17,9 @@
 #include <spl.h>
 #include <asm/cache.h>
 
+/* BL33 defaults to U-Boot unless Falcon mode selects Linux. */
+static int spl_atf_bl33_os;
+
 /* Holds all the structures we need for bl31 parameter passing */
 struct bl2_to_bl31_params_mem {
 	struct bl31_params bl31_params;
@@ -87,8 +90,11 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
 		       ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
+	/* Linux-at-BL33 expects DTB in x0, U-Boot expects primary CPU MPID in x0. */
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_atf_bl33_os == IH_OS_LINUX)
+		bl33_ep_info->args.arg0 = fdt_addr;
+	else
+		bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
 	bl33_ep_info->pc = bl33_entry;
 	bl33_ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 				     DISABLE_ALL_EXECPTIONS);
@@ -162,8 +168,11 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl_params_node->ep_info, ATF_PARAM_EP,
 		       ATF_VERSION_2, ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
+	/* Linux-at-BL33 expects DTB in x0, U-Boot expects primary CPU MPID in x0. */
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_atf_bl33_os == IH_OS_LINUX)
+		bl_params_node->ep_info->args.arg0 = fdt_addr;
+	else
+		bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
 	bl_params_node->ep_info->pc = bl33_entry;
 	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 						DISABLE_ALL_EXECPTIONS);
@@ -189,7 +198,8 @@ static inline void raw_write_daif(unsigned int daif)
 typedef void __noreturn (*atf_entry_t)(struct bl31_params *params, void *plat_params);
 
 static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
-				  ulong bl33_entry, ulong fdt_addr)
+				  ulong bl33_entry, ulong fdt_addr,
+				  ulong plat_param)
 {
 	atf_entry_t  atf_entry = (atf_entry_t)bl31_entry;
 	void *bl31_params;
@@ -206,7 +216,7 @@ static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
 	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		dcache_disable();
 
-	atf_entry(bl31_params, (void *)fdt_addr);
+	atf_entry(bl31_params, (void *)plat_param);
 }
 
 static int spl_fit_images_find(void *blob, int os)
@@ -255,7 +265,7 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 {
 	ulong  bl32_entry = 0;
 	ulong  bl33_entry = CONFIG_TEXT_BASE;
-	void *blob = spl_image->fdt_addr;
+	void *blob = spl_image_fdt_addr(spl_image);
 	ulong platform_param = (ulong)blob;
 	int node;
 
@@ -269,15 +279,22 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 		bl32_entry = spl_fit_images_get_entry(blob, node);
 
 	/*
-	 * Find the U-Boot binary (in /fit-images) load addreess or
-	 * entry point (if different) and pass it as the BL3-3 entry
-	 * point.
-	 * This will need to be extended to support Falcon mode.
+	 * Find BL33 entry point. In Falcon mode, prefer Linux when requested.
+	 * Fall back to U-Boot if Linux cannot be resolved.
 	 */
+	node = -FDT_ERR_NOTFOUND;
+	spl_atf_bl33_os = IH_OS_U_BOOT;
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && !spl_start_uboot())
+		node = spl_fit_images_find(blob, IH_OS_LINUX);
 
-	node = spl_fit_images_find(blob, IH_OS_U_BOOT);
-	if (node >= 0)
+	if (node >= 0) {
 		bl33_entry = spl_fit_images_get_entry(blob, node);
+		spl_atf_bl33_os = IH_OS_LINUX;
+	} else {
+		node = spl_fit_images_find(blob, IH_OS_U_BOOT);
+		if (node >= 0)
+			bl33_entry = spl_fit_images_get_entry(blob, node);
+	}
 
 	/*
 	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform
@@ -293,5 +310,5 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 	 * using similar logic.
 	 */
 	bl31_entry(spl_image->entry_point, bl32_entry,
-		   bl33_entry, platform_param);
+		   bl33_entry, (ulong)blob, platform_param);
 }

-- 
2.53.0

