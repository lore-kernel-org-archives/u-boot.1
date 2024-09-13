Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F88FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0070D88DBE;
	Fri, 13 Sep 2024 11:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CYghReN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6216988DAA; Fri, 13 Sep 2024 11:57:38 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EFA388DB8
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so11794651fa.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221448; x=1726826248;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxLcrsk7KRUbBJ1NKSDZt5CMW8u++VHiwt7yzGRE7kA=;
 b=CYghReN7gjmvre0YkJJ0d70ydpqSMDMFYOPeUsRuXoM9YmFQaBEe3RfnCjLK0RxRCA
 E6icEbEk1l3H5S309lCUmoUfMQ70lFgeMzIbXzAtboYkb+bRIfbrJ4FAsYX7UWcGshx7
 Nx5WlEkNxU4100GjKaAtJJ0NZM3jRy23Z01Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221448; x=1726826248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxLcrsk7KRUbBJ1NKSDZt5CMW8u++VHiwt7yzGRE7kA=;
 b=jlJwZwSXTc9aRULI2VkNH+FkJhbSVQoNCNLqTgXx6krrri1NUMeZiTIxw11k4CYgC1
 wyjA4+bnfJDifORi8bXZDLfiTa3NLL/9UvEatQ1qSVzM1VQeTLMrI4C2HgBXfwFvgDTA
 cnBDGCPUcXUSd9VNSGDbJVEw07W4JmQxDv7f8OEDoQWxi7JbcMxsu1BHbXqKtOmk2PWG
 k1GmFmOFrb1RjcEGdOcfMJtUJIUW6KwZzhLIEyTuS5w/UF63lo8WpXIKHedsKPj1+QfQ
 vMz/c4NmvdMfwYx7+SuIp2mb30Mg5N9SfrA9PSMwiAA5WcsWOMsvdmTJkwPvmc8QWsW/
 wpWQ==
X-Gm-Message-State: AOJu0Yy/CkG0hyTYwJ2EbgH9jHV1EiBNjcMO9E5XL3IZCLK6nBGn+/Qc
 A/LZ0JKWIDDNi5OjwXMh6mGxrcQwTPJfVSKoHdEw/Qhwjg1D86dJWqovtNLB5FXu+M93CI2+eOf
 H75U=
X-Google-Smtp-Source: AGHT+IFeOaLsPLYZMQviF0g6kLcZbEnarvoFoMx6MYVWiGC06mF7Q38ieJxutYrjE1Yi43UkEJs/+g==
X-Received: by 2002:ac2:4c4a:0:b0:52c:76ac:329b with SMTP id
 2adb3069b0e04-5367fef1b91mr1744190e87.35.1726221448156; 
 Fri, 13 Sep 2024 02:57:28 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:27 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 24/26] imx8mn_bsh_smm_s2/pro: support simple frame-buffer
Date: Fri, 13 Sep 2024 11:56:06 +0200
Message-ID: <20240913095622.72377-25-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

If you want to pass the frame-buffer to the kernel, the video output is
initialized by U-Boot, and kept by the kernel. The commit modifies the
device tree to be passed to the kernel just before launching it, to
prevent the kernel from reinitializing hardware that has already been
configured by the bootloader.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c | 99 +++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c b/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
index c99896873991..87eb4e7ed63e 100644
--- a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
+++ b/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
@@ -5,6 +5,8 @@
 
 #include <asm/arch/sys_proto.h>
 #include <env.h>
+#include <fdt_simplefb.h>
+#include <fdt_support.h>
 
 int board_init(void)
 {
@@ -20,3 +22,100 @@ int board_late_init(void)
 
 	return 0;
 }
+
+#if (IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_FDT_SIMPLEFB) && \
+	IS_ENABLED(CONFIG_VIDEO))
+static void smm_s2_setup_simplefb(void *blob)
+{
+#define DT_BLK_CTRL_NODE_PATH "/soc@0/bus@32c00000/blk-ctrl@32e28000"
+#define DT_GPC_NODE_PATH "/soc@0/bus@30000000/gpc@303a0000"
+#define DT_MIPI_DSI_NODE_PATH "/soc@0/bus@32c00000/dsi@32e10000"
+#define DT_LCDIF_NODE_PATH "/soc@0/bus@32c00000/lcdif@32e00000"
+
+	const char *dt_addnode[][2] = {
+		{ DT_BLK_CTRL_NODE_PATH, "lcdif" },
+		{ DT_BLK_CTRL_NODE_PATH, "mipi-dsi" },
+	};
+
+	const char *dt_addprop[][2] = {
+		{ "/regulator-3v3-O2", "regulator-boot-on" },
+		{ "/regulator-3v3-O3", "regulator-boot-on" },
+		{ DT_GPC_NODE_PATH "/pgc/power-domain@3", "fsl,boot-on" },
+		{ DT_GPC_NODE_PATH "/pgc/power-domain@4", "fsl,boot-on" },
+		{ DT_BLK_CTRL_NODE_PATH "/lcdif", "fsl,boot-on" },
+		{ DT_BLK_CTRL_NODE_PATH "/mipi-dsi", "fsl,boot-on" },
+		{ DT_MIPI_DSI_NODE_PATH, "samsung,boot-on" },
+		{ DT_MIPI_DSI_NODE_PATH "/panel@0", "syna,boot-on" },
+		{ DT_LCDIF_NODE_PATH, "fsl,boot-on" },
+	};
+	const char *dt_delprop[][2] = {
+		{ DT_BLK_CTRL_NODE_PATH, "assigned-clock-rates" },
+		{ DT_GPC_NODE_PATH "/pgc/power-domain@3", "assigned-clock-rates" }, // pgc_dispmix
+		{ DT_LCDIF_NODE_PATH, "assigned-clock-rates" },
+	};
+	int i, ret, offset;
+
+	ret = fdt_simplefb_enable_and_mem_rsv(blob);
+	if (ret) {
+		printf("Failed to enable framebuffer DTS node\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dt_addnode); i++) {
+		const char *path = dt_addnode[i][0];
+		const char *node = dt_addnode[i][1];
+
+		offset = fdt_path_offset(blob, path);
+		if (offset < 0) {
+			printf("Missing node %s, err=%s\n", path,
+			       fdt_strerror(offset));
+			continue;
+		}
+
+		offset = fdt_find_or_add_subnode(blob, offset, node);
+		if (offset < 0)
+			printf("Failed to create node %s, err=%s\n", path,
+			       fdt_strerror(offset));
+		else
+			debug("Add node %s:%s\n", path, node);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dt_addprop); i++) {
+		const char *path = dt_addprop[i][0];
+		const char *prop = dt_addprop[i][1];
+
+		ret = fdt_find_and_setprop(blob, path, prop, NULL, 0, 1);
+		if (ret < 0)
+			printf("Failed to add property %s:%s, err=%s\n", path, prop,
+			       fdt_strerror(ret));
+		else
+			debug("Add property %s:%s\n", path, prop);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dt_delprop); i++) {
+		const char *path = dt_delprop[i][0];
+		const char *prop = dt_delprop[i][1];
+
+		offset = fdt_path_offset(blob, path);
+		if (offset < 0) {
+			printf("Missing node %s\n", path);
+			continue;
+		}
+
+		ret = fdt_delprop(blob, offset, prop);
+		if (ret < 0)
+			printf("Failed to delete property %s:%s\n", path, prop);
+		else
+			debug("Delete property %s:%s\n", path, prop);
+	}
+}
+#endif
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	if (IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_FDT_SIMPLEFB) &&
+	    IS_ENABLED(CONFIG_VIDEO))
+		smm_s2_setup_simplefb(blob);
+
+	return 0;
+}
-- 
2.43.0

