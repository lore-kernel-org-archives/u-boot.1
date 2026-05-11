Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04684CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6E383C2B;
	Mon, 11 May 2026 22:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jj9Y2Rgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A19E84198; Mon, 11 May 2026 22:44:34 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002898394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso2940392fac.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778532270; x=1779137070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zxf77JKDOCDVtuYZRu5LUEnn4pVWSbaEv9oI4izvcMs=;
 b=Jj9Y2Rgn1f5fCj8PCTJ24PR8BM6wU4HrsvnPPqE7nlLopyPPYaOeocTgZkKUaqeH/1
 eWU38f3TDQelgIVixgA53jX+Or+ScN5R1IDWWK31pD64sUHcaiIqx97R5aqfrIRK+5Pk
 V+nP+VicQNtPEbc56s+iYW0BEeRdzdBh1Pxfr3Lwx+AmMDFwIJZjdmreuXQOWdL5Iu/5
 Xp1e7gIH79ccywLkrxp/2sINZ0Si7j50MDwjEgIOuICW7DR3xgDhq3Y0/2NhDcHXUNbL
 Nm2+wuHZgRD20bTuaC2oRR5Ilwn6Noy7ViX6vooifq5tzD2DvUrxriJ4B73E0IIQw1EH
 DBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778532270; x=1779137070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxf77JKDOCDVtuYZRu5LUEnn4pVWSbaEv9oI4izvcMs=;
 b=XWRm7JmK+5YWfqw6bHOwxTglB3h10BXZIKAPJa8yhuJxJPKf1Fkf900n6u6qz2PTF+
 EzwmuCH/j1ZGzRTGOG2MCa+wUIWo55Mk5rbG9ViX2s2pDAlr2zXdh+9u/rVNYIaLCsWX
 9sTxEshhgLrFGfWda80QUQMgFRN3q94vnQat85T6vfKjP7iryOu6GWmbbY4snWxxNVFI
 +4hrUjyyuIE2V1Npmh/WFoSAMmL4iA/J85D7V/eplfI2m2GIeIyLrWXFDaAdF4gIO0Y7
 WeWhm87iT1atlL8+zExUDZTRe4k7ijyNnpuyqkgxraHn3nqp5udsu4KADbDY3YGDjjLV
 wWzg==
X-Gm-Message-State: AOJu0YwdM8rcICNdiTE12bmpd3D57PFcU54aLDu1EzpwOg/wvsvtROdg
 0CBWPVeoiiQOIVesxxTZQ6cQL0wcTDMM690lXxjsCis/SlORp3t3CsHsiaXETQbr
X-Gm-Gg: Acq92OEX3l18t2QMmJBhHnvdHPW5eaykjVPHSa9POf65Q4Hl1p4krGsWlkW1oXnCUOw
 /RiEvMmPHclf50RyHOIrH5JGTv8mJpj46sQj3ZiW8F3C0GPf0KU1lDhnEeoN9032Ah8jxij/3+G
 2Ilyl1Ndm/o44AxDo0SbwtHXhtgjcXo9ANdhv7j6CwTLIg3JYh50eZiXMN4LcEgmpUzVmNdhU2e
 NGu8JPe7hoQOQmp5cZZQCN1PCeJ2IdfdQ75wPWeEuW3pIF852DdWqfrB2fRtWecD7uK21IlnrNO
 4k3lp6Ba9GSjVTR+U2DpkaHtR82RHpW1G6QuaGN1QuegTsYDOAtKgs0Ipj017y9ypxAAXzhtofN
 4Dd4ttLQp+MEULxQKm601w+ZIPYFljbV8eY8hv/XoJkoYJvdEQe7y2sNt0WGm2wWHnPPCOHQdab
 g3vsrP0ReHfZIyut6btHQg1PkUklFumvwAORTfFc1nPYIt+6C2YwP6utfGtzr/au/gR8lBPwTpc
 374wXDV0HTcTiVktMYn2B5AiWkWI8afRmQ3NnUdng1NlEzfY7eawAbzpspnfsWtksgvbA==
X-Received: by 2002:a05:6871:2218:b0:42e:49e1:e511 with SMTP id
 586e51a60fabf-434f66d1089mr15485729fac.33.1778532270504; 
 Mon, 11 May 2026 13:44:30 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (71-218-106-55.hlrn.qwest.net.
 [71.218.106.55]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355744b05dsm11082077fac.18.2026.05.11.13.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:44:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Bohdan Chubuk <chbgdn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] sunxi: add NAND MTD partition fixups
Date: Mon, 11 May 2026 14:44:26 -0600
Message-ID: <20260511204427.81653-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When CONFIG_FDT_FIXUP_PARTITIONS is enabled, update NAND partition
subnodes in the FDT from the mtdparts environment before booting Linux.

Add the Allwinner NAND controller compatibles supported by the U-Boot
sunxi NAND driver. Gate the fixup by CONFIG_NAND_SUNXI so it is only
used when the sunxi NAND driver is enabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 board/sunxi/board.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 3d1afec7c66..ef7139be310 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -19,6 +19,8 @@
 #include <init.h>
 #include <log.h>
 #include <mmc.h>
+#include <mtd.h>
+#include <mtd_node.h>
 #include <axp_pmic.h>
 #include <generic-phy.h>
 #include <phy-sun4i-usb.h>
@@ -932,6 +934,16 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	int __maybe_unused r;
 
+	static const struct node_info sunxi_nand_nodes[] = {
+		{ "allwinner,sun4i-a10-nand", MTD_DEV_TYPE_NAND, },
+		{ "allwinner,sun50i-h616-nand-controller", MTD_DEV_TYPE_NAND, },
+	};
+
+	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) &&
+	    IS_ENABLED(CONFIG_NAND_SUNXI))
+		fdt_fixup_mtdparts(blob, sunxi_nand_nodes,
+				   ARRAY_SIZE(sunxi_nand_nodes));
+
 	/*
 	 * Call setup_environment and fdt_fixup_ethernet again
 	 * in case the boot fdt has ethernet aliases the u-boot
-- 
2.53.0

