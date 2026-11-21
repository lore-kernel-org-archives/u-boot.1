Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E6606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XmNEZ+O0;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=fft5qai7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AA6740AE2;
	Sat, 21 Nov 2026 12:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gErZ-2ewrp1U; Sat, 21 Nov 2026 12:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41DC540AD2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264516;
	b=F+qKoP2IAXn5u0LV/bYyoOuV0zHzVl0Hr/buNiG9uqgrzCA/ougutrtuAzYGFhjZaF2d
	 fJlDM8cYQZ2sVQa2azhbR/ajI0SeOz6/Qb097r5H+Osp55dkYUZBZDxEpk5mGC2Jc+OLt
	 RqB+0X+QInznfJGltgE6Nubj/pFu8Ze4khwS/92c6BXC01ykEtN4prHGJlcN628o9UkCZ
	 t18QDfT83U/w6cYflsIYSuqBuDOx238oOFgEKTgVk5PwsHlgibN4Logbe2ganZjUlfvOx
	 9Xri1xmLQsGWOcWfZgUvNnzPgbFoGnXrMCBJ+5sU9TaZSCDZALmYbh2Bzt8TRWquG9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y3rSAhHFTW3m1MHruJaqkw7SO9pK7sEgrbdjyFUbmvg=;
	b=PV/rNHm9TALbW3MX5BZ9yoFcvKQoa0G/mSNTSiDJ9NAOt78H8TmKXq5X+sC1vW5Rdj6/
	 ywBY/4oFjdGCqggGTe51ngB1/s3FvY3/P+5u2aOMfEn/XKVf167NiXXj+q4hoMsg3eZbY
	 hPXU29/7fd7+9jAmcLZoJmtkwq7NrSAgB7187ICcG7/gzKrMnr8K9CauxwM36cfuB+te2
	 whC8sXoYzXDrY44qF9pf6NQedOuB3PaUjqvju+XqrP+k/jrlBrnKdW+NngzgEW/Q2EY6M
	 nqFVyQaGF/LZOCQIUYHmFhQJJ1qaaNYs9cD2/6Sb6VKATYI2y2VRYyovg07a0JRNpJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264516;
	bh=Y3rSAhHFTW3m1MHruJaqkw7SO9pK7sEgrbdjyFUbmvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XmNEZ+O0Tkqnzx1xPCKo900BCaDH5GMNeY2YCdgMahUx7/Ftuh4dT1Oh3lQJQgLrf
	 5Kpi4YNlf43lamar7+4j9L2UhwqPH9vP0aM9yKnqIy4qebh5TXrOXL3t9Kjw2XUZKb
	 Qhc7XoiW2OHQcqd5xeEfwiJelDE+P5wjg6CoSQLAkUJdXX9APVBxnDryaVW/4pMTA8
	 40Elr2+cVWSB/dTQYZjxPZ/EEbv2gj6htfuXJ+V7ksEOHc5h/00QIpaPNDStOE5pnQ
	 JAC3NtuiBfiZDGPWeEQLNqza3HX11zxCoLQZB0euJYhuAZ5afsoyAo1RZYpV4tentO
	 eLKC+nu0QBttA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41DC540AD2;
	Sat, 21 Nov 2026 12:35:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41CA99C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 318BD60653
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wBR0ph6tNl-i for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71ED8605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=fft5qai7
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71ED8605DA
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:10 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso818324f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264508; x=1795869308;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y3rSAhHFTW3m1MHruJaqkw7SO9pK7sEgrbdjyFUbmvg=;
 b=fft5qai7TCzYf7uNZL9DBKFozaDEQt9hCENaYsg+mihUlqTf15LG2qjUMl3V5MxngX
 bd23WsDd8QpLm3R5D09hrmN28H/gmtztx3pj9GvU5im8tOohjX81MUmxK71vQMsEJ5Ca
 sVyzDe/9yeV/qOusExzxJEUz7mKO0K7yYzt4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264508; x=1795869308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y3rSAhHFTW3m1MHruJaqkw7SO9pK7sEgrbdjyFUbmvg=;
 b=nnqawK75jHu7LC/riFSJcuCrMUYlP9B9MWcW8if5NpEJXTOtiFRJL68UIqhgUEjVg5
 Ivl0yTNju7lr8VvfdY8PTFbBnxqeRcOsHeXVszYRhyNcs9VO1oAxfXvkv1e8eHmyOFre
 TxkGMDxnvGULoLA0SYXqK3Qk6iV+YmC38jXbzsIusA7g6gYVwL+zZaakzwNggybDySbx
 KaKuhnz5j6vGzgMdxowoiFULesn7Dh4dIYhHL/a2rYhIRMm0IVwltssSq8Xp3Cr4HDs+
 T8mVB0zOgHta7JWi2I1dqMyBTXXQBki6FSos1wM3aSsFMSJYt+XspJ6IrhmBVznbteuH
 2hbQ==
X-Gm-Message-State: APuU4Z/cNlyY7qO2M2e28zfEJyKtN1xnu4/4OKdddF/Tg/V8VXSZ/v3I
 sYtuDd8sFeydnpf86bqd3aTF7u5BSabGP2eA23jLNQUGoBOrZw2BIJal29EkB6A4kL/E2fqJM92
 I5aB7
X-Gm-Gg: AZFdTZfUixUSEE0KQ582CD2f7XFsCyxQ7B/6zao/otWsoUG2dhsSuYYL9tnXWNRjpJi
 azmaB1BsLTBUtYLNbH3M5UyeKUDK0gX/02GExrB5dRkrnkCHpeR0oiIRwfQYC2ImBksSQ6HzRpV
 E37tBzGr+sYTHglurZdrZPtc8nylvuo0cJn9jiJdPWgeo3XR3WLXTGSHZWUOI9AdfflB5OSDfhS
 vxOuXyAurAgevR07eFFSzpDnUFzLL0x+SSo/XmXL5UjY/t8gqQrjXK1b4qQLshNHSe7jBZMdn0i
 upEc4PemFSfQvc2493yv0QDzQH3ymH58KFQVE1Z3uH7q7PgYNRpiTfWRRYUpk4WkRnQcLDbuEQ+
 uRCY9lzcI/nSPVNFkMG76xuuVS2LexqnXv+GIm+8N9fdOjHyIZGJkxzm70H5DFtjMH6qzePTCpa
 iE8e2unNBBErr+XafUP3HKC2D3e3oYtQFamB90caBlrLNgs/TayPC+V+IwNIKijy4DaG27usBbh
 qBDjy0hYM0lFCIt1FabRrjw3ePq4vSJN/qeblYq+0q0735wTccj9FBDqX9pDkzuOXd35it9Ldqs
 djZ2gxIc8cFBeAfO+tzZp45cwYTG7Vst2QE+1H02Yy26OQnQhR6JxygOZtKApm1Zw0SOHmyEjYg
 0Y71WHmX1xc3vVy2W16jQXva51qBQc/j/DTtdEV5BdpzMdFcU9AcFaEvxW0RCGb2sPQXjU4PSfb
 yaHvedKUBSfzICsV+k4Nouf3cEdQI91tV0kfijEBWh2VfZ0FM=
X-Received: by 2002:a05:6000:186b:b0:4a6:4f35:336b with SMTP id
 ffacd0b85a97d-4abab02c60amr13013268f8f.5.1795264508156; 
 Sat, 21 Nov 2026 04:35:08 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:07 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 David Lechner <dlechner@baylibre.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/25] power: domain: add i.MX8MM/i.MX8MN display block
 control driver
Date: Sat, 21 Nov 2026 13:33:56 +0100
Message-ID: <20261121123451.2471185-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Add a driver for the display block control (DISPLAY_BLK_CTRL) of the
i.MX8MM and i.MX8MN, which provides the power domains of the LCDIF, the
MIPI DSI/CSI and the CSI bridge/ISI, as the Linux imx8m-blk-ctrl driver
does. The i.MX8MP media block control is already handled by the
imx8mp-mediamix driver.

The block control domains sit on top of the GPC DISPMIX and MIPI
domains, so add them, together with the GPUMIX, VPUMIX and related
domains, to the i.MX8MM/i.MX8MN PGC domain tables.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Fix build error
- Drop i.MX8MP support, already provided by the imx8mp-mediamix driver
- Let the power domain uclass count the domain references
- Check the domains allocation
- Reword subject and commit message

 drivers/power/domain/Kconfig              |   7 +
 drivers/power/domain/Makefile             |   1 +
 drivers/power/domain/imx8m-blk-ctrl.c     | 355 ++++++++++++++++++++++
 drivers/power/domain/imx8m-power-domain.c | 166 +++++++++-
 4 files changed, 528 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 13a661ce04f8..9d883d4eaaee 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -48,6 +48,13 @@ config IMX8M_POWER_DOMAIN
 	  Enable support for manipulating NXP i.MX8M on-SoC power domains via
 	  requests to the ATF.
 
+config IMX8M_BLK_CTRL
+	bool "Enable i.MX8MM/i.MX8MN display block control driver"
+	depends on POWER_DOMAIN && (IMX8MM || IMX8MN)
+	help
+	  Enable support for the power domains of the display block control
+	  (DISPLAY_BLK_CTRL) on i.MX8MM and i.MX8MN.
+
 config IMX8MP_HSIOMIX_BLKCTRL
 	bool "Enable i.MX8MP HSIOMIX domain driver"
 	depends on POWER_DOMAIN && IMX8MP
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 3b816ed3bed7..8cd298c924f2 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AGILEX5_PMGR_POWER_DOMAIN) += altr-pmgr-agilex5.o
 obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
+obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
 obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
 obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/domain/imx8m-blk-ctrl.c
new file mode 100644
index 000000000000..d1385eb734ed
--- /dev/null
+++ b/drivers/power/domain/imx8m-blk-ctrl.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <power-domain-uclass.h>
+#include <asm/io.h>
+#include <dm/device-internal.h>
+#include <dm/device.h>
+#include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mn-power.h>
+#include <clk.h>
+#include <linux/delay.h>
+
+#define BLK_SFT_RSTN	0x0
+#define BLK_CLK_EN	0x4
+#define BLK_MIPI_RESET_DIV	0x8 /* Mini/Nano/Plus DISPLAY_BLK_CTRL only */
+
+#define DOMAIN_MAX_CLKS 4
+
+struct imx8m_blk_ctrl_domain {
+	struct clk clks[DOMAIN_MAX_CLKS];
+	struct power_domain power_dev;
+};
+
+struct imx8m_blk_ctrl {
+	void __iomem *base;
+	struct power_domain bus_power_dev;
+	struct imx8m_blk_ctrl_domain *domains;
+};
+
+struct imx8m_blk_ctrl_domain_data {
+	const char *name;
+	const char * const *clk_names;
+	const char *gpc_name;
+	int num_clks;
+	u32 rst_mask;
+	u32 clk_mask;
+	u32 mipi_phy_rst_mask;
+};
+
+struct imx8m_blk_ctrl_data {
+	int max_reg;
+	const struct imx8m_blk_ctrl_domain_data *domains;
+	int num_domains;
+	u32 bus_rst_mask;
+	u32 bus_clk_mask;
+};
+
+static int imx8m_blk_ctrl_request(struct power_domain *power_domain)
+{
+	return 0;
+}
+
+static int imx8m_blk_ctrl_free(struct power_domain *power_domain)
+{
+	return 0;
+}
+
+static int imx8m_blk_ctrl_enable_domain_clk(struct udevice *dev, ulong domain_id, bool enable)
+{
+	int ret, i;
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+
+	debug("%s num_clk %u\n", __func__, drv_data->domains[domain_id].num_clks);
+
+	for (i = 0; i < drv_data->domains[domain_id].num_clks; i++) {
+		debug("%s clk %s\n", __func__, drv_data->domains[domain_id].clk_names[i]);
+		if (enable)
+			ret = clk_enable(&priv->domains[domain_id].clks[i]);
+		else
+			ret = clk_disable(&priv->domains[domain_id].clks[i]);
+		if (ret && ret != -ENOENT) {
+			printf("Failed to %s domain clk %s\n", enable ? "enable" : "disable",
+			       drv_data->domains[domain_id].clk_names[i]);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+	int ret;
+
+	debug("%s, id %lu\n", __func__, power_domain->id);
+
+	if (!priv->domains[power_domain->id].power_dev.dev)
+		return -ENODEV;
+
+	ret = power_domain_on(&priv->bus_power_dev);
+	if (ret < 0) {
+		printf("Failed to power up bus domain %d\n", ret);
+		return ret;
+	}
+
+	/* Enable bus clock and deassert bus reset */
+	setbits_le32(priv->base + BLK_CLK_EN, drv_data->bus_clk_mask);
+	setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->bus_rst_mask);
+
+	/* wait for reset to propagate */
+	udelay(5);
+
+	/* put devices into reset */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
+	if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
+		clrbits_le32(priv->base + BLK_MIPI_RESET_DIV,
+			     drv_data->domains[power_domain->id].mipi_phy_rst_mask);
+
+	/* enable upstream and blk-ctrl clocks to allow reset to propagate */
+	ret = imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, true);
+	if (ret) {
+		printf("failed to enable clocks\n");
+		goto bus_powerdown;
+	}
+
+	/* ungate clk */
+	setbits_le32(priv->base + BLK_CLK_EN, drv_data->domains[power_domain->id].clk_mask);
+
+	/* power up upstream GPC domain */
+	ret = power_domain_on(&priv->domains[power_domain->id].power_dev);
+	if (ret < 0) {
+		printf("Failed to power up peripheral domain %d\n", ret);
+		goto clk_disable;
+	}
+
+	/* wait for reset to propagate */
+	udelay(5);
+
+	/* release reset */
+	setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
+	if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
+		setbits_le32(priv->base + BLK_MIPI_RESET_DIV,
+			     drv_data->domains[power_domain->id].mipi_phy_rst_mask);
+
+	return 0;
+clk_disable:
+	imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, false);
+bus_powerdown:
+	power_domain_off(&priv->bus_power_dev);
+	return ret;
+}
+
+static int imx8m_blk_ctrl_power_off(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+
+	debug("%s, id %lu\n", __func__, power_domain->id);
+
+	if (!priv->domains[power_domain->id].power_dev.dev)
+		return -ENODEV;
+
+	/* put devices into reset and disable clocks */
+	if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
+		clrbits_le32(priv->base + BLK_MIPI_RESET_DIV,
+			     drv_data->domains[power_domain->id].mipi_phy_rst_mask);
+
+	/* assert reset */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
+
+	/* gate clk */
+	clrbits_le32(priv->base + BLK_CLK_EN, drv_data->domains[power_domain->id].clk_mask);
+
+	/* power down upstream GPC domain */
+	power_domain_off(&priv->domains[power_domain->id].power_dev);
+
+	imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, false);
+
+	/* power down bus domain */
+	power_domain_off(&priv->bus_power_dev);
+
+	return 0;
+}
+
+static int imx8m_blk_ctrl_probe(struct udevice *dev)
+{
+	int ret, i, j;
+	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+
+	/* Let the uclass refcount each domain */
+	plat->subdomains = drv_data->num_domains;
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	priv->domains = kcalloc(drv_data->num_domains,
+				sizeof(struct imx8m_blk_ctrl_domain), GFP_KERNEL);
+	if (!priv->domains)
+		return -ENOMEM;
+
+	ret = power_domain_get_by_name(dev, &priv->bus_power_dev, "bus");
+	if (ret) {
+		printf("Failed to power_domain_get_by_name %s\n", "bus");
+		return ret;
+	}
+
+	for (j = 0; j < drv_data->num_domains; j++) {
+		ret = power_domain_get_by_name(dev, &priv->domains[j].power_dev,
+					       drv_data->domains[j].gpc_name);
+		if (ret)
+			continue;
+
+		for (i = 0; i < drv_data->domains[j].num_clks; i++) {
+			ret = clk_get_by_name(dev, drv_data->domains[j].clk_names[i],
+					      &priv->domains[j].clks[i]);
+			if (ret) {
+				printf("Failed to get clk %s\n", drv_data->domains[j].clk_names[i]);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int imx8m_blk_ctrl_remove(struct udevice *dev)
+{
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+
+	kfree(priv->domains);
+
+	return 0;
+}
+
+static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[] = {
+	[IMX8MM_DISPBLK_PD_CSI_BRIDGE] = {
+		.name = "dispblk-csi-bridge",
+		.clk_names = (const char *[]){ "csi-bridge-axi", "csi-bridge-apb",
+					       "csi-bridge-core", },
+		.num_clks = 3,
+		.gpc_name = "csi-bridge",
+		.rst_mask = BIT(0) | BIT(1) | BIT(2),
+		.clk_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5),
+	},
+	[IMX8MM_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.clk_mask = BIT(6) | BIT(7),
+	},
+	[IMX8MM_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(5),
+		.clk_mask = BIT(8) | BIT(9),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(3) | BIT(4),
+		.clk_mask = BIT(10) | BIT(11),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
+	.max_reg = 0x2c,
+	.domains = imx8mm_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
+	.bus_rst_mask = BIT(6),
+	.bus_clk_mask = BIT(12),
+};
+
+static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
+	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(0) | BIT(1),
+		.clk_mask = BIT(0) | BIT(1),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+	[IMX8MN_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.rst_mask = BIT(4) | BIT(5),
+		.clk_mask = BIT(4) | BIT(5),
+	},
+	[IMX8MN_DISPBLK_PD_ISI] = {
+		.name = "dispblk-isi",
+		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
+						"disp_apb_root"},
+		.num_clks = 4,
+		.gpc_name = "isi",
+		.rst_mask = BIT(6) | BIT(7),
+		.clk_mask = BIT(6) | BIT(7),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
+	.max_reg = 0x84,
+	.domains = imx8mn_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
+	.bus_rst_mask = BIT(8),
+	.bus_clk_mask = BIT(8),
+};
+
+static const struct udevice_id imx8m_blk_ctrl_ids[] = {
+	{.compatible = "fsl,imx8mm-disp-blk-ctrl", .data = (ulong)&imx8mm_disp_blk_ctl_dev_data},
+	{.compatible = "fsl,imx8mn-disp-blk-ctrl", .data = (ulong)&imx8mn_disp_blk_ctl_dev_data},
+	{}
+};
+
+struct power_domain_ops imx8m_blk_ctrl_ops = {
+	.request = imx8m_blk_ctrl_request,
+	.rfree = imx8m_blk_ctrl_free,
+	.on = imx8m_blk_ctrl_power_on,
+	.off = imx8m_blk_ctrl_power_off,
+};
+
+U_BOOT_DRIVER(imx8m_blk_ctrl) = {
+	.name = "imx8m_blk_ctrl",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = imx8m_blk_ctrl_ids,
+	.bind = dm_scan_fdt_dev,
+	.probe = imx8m_blk_ctrl_probe,
+	.remove = imx8m_blk_ctrl_remove,
+	.priv_auto	= sizeof(struct imx8m_blk_ctrl),
+	.ops = &imx8m_blk_ctrl_ops,
+	.flags  = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index a3ef49aa67c5..1576eb384730 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -29,10 +29,22 @@
 #define IMX8M_OTG1_A53_DOMAIN			BIT(4)
 #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
 
+#define IMX8MM_VPUH1_A53_DOMAIN			BIT(15)
+#define IMX8MM_VPUG2_A53_DOMAIN			BIT(14)
+#define IMX8MM_VPUG1_A53_DOMAIN			BIT(13)
+#define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
+#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(11))
+#define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
 #define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
 #define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
 #define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
+#define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MN_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MN_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MN_DDR1_A53_DOMAIN			BIT(7)
 #define IMX8MN_OTG1_A53_DOMAIN			BIT(4)
 #define IMX8MN_MIPI_A53_DOMAIN			BIT(2)
 
@@ -49,14 +61,34 @@
 #define GPC_PU_PGC_SW_PDN_REQ			0x104
 
 #define IMX8M_PCIE2_SW_Pxx_REQ			BIT(13)
+#define IMX8M_MIPI_CSI2_SW_Pxx_REQ		BIT(12)
+#define IMX8M_MIPI_CSI1_SW_Pxx_REQ		BIT(11)
+#define IMX8M_DISP_SW_Pxx_REQ			BIT(10)
+#define IMX8M_HDMI_SW_Pxx_REQ			BIT(9)
+#define IMX8M_VPU_SW_Pxx_REQ			BIT(8)
+#define IMX8M_GPU_SW_Pxx_REQ			BIT(7)
+#define IMX8M_DDR2_SW_Pxx_REQ			BIT(6)
+#define IMX8M_DDR1_SW_Pxx_REQ			BIT(5)
 #define IMX8M_OTG2_SW_Pxx_REQ			BIT(3)
 #define IMX8M_OTG1_SW_Pxx_REQ			BIT(2)
 #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
 
+#define IMX8MM_VPUH1_SW_Pxx_REQ			BIT(13)
+#define IMX8MM_VPUG2_SW_Pxx_REQ			BIT(12)
+#define IMX8MM_VPUG1_SW_Pxx_REQ			BIT(11)
+#define IMX8MM_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MM_VPUMIX_SW_Pxx_REQ		BIT(8)
+#define IMX8MM_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MM_GPU_SW_Pxx_REQ			(BIT(6) | BIT(9))
+#define IMX8MM_DDR1_SW_Pxx_REQ			BIT(5)
 #define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
 #define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
 #define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
+#define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MN_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MN_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MN_DDR1_SW_Pxx_REQ			BIT(5)
 #define IMX8MN_OTG1_SW_Pxx_REQ			BIT(2)
 #define IMX8MN_MIPI_SW_Pxx_REQ			BIT(0)
 
@@ -71,10 +103,22 @@
 #define IMX8MP_GPC_PU_PWRHSK			0x190
 #define GPC_PU_PWRHSK				0x1fc
 
+#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
+#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
+#define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
+#define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
 #define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
+#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
+#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
+#define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
+#define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
 
+#define IMX8MN_GPUMIX_HSK_PWRDNACKN		(BIT(29) | BIT(27))
+#define IMX8MN_DISPMIX_HSK_PWRDNACKN		BIT(25)
 #define IMX8MN_HSIO_HSK_PWRDNACKN		BIT(23)
+#define IMX8MN_GPUMIX_HSK_PWRDNREQN		(BIT(11) | BIT(9))
+#define IMX8MN_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MN_HSIO_HSK_PWRDNREQN		BIT(5)
 
 #define IMX8MP_HSIOMIX_PWRDNACKN		BIT(28)
@@ -94,11 +138,25 @@
 #define IMX8M_PGC_OTG2			19
 #define IMX8M_PGC_PCIE2			29
 
+#define IMX8MM_PGC_MIPI			16
 #define IMX8MM_PGC_PCIE			17
 #define IMX8MM_PGC_OTG1			18
 #define IMX8MM_PGC_OTG2			19
-
+#define IMX8MM_PGC_DDR1			21
+#define IMX8MM_PGC_GPU2D		22
+#define IMX8MM_PGC_GPUMIX		23
+#define IMX8MM_PGC_VPUMIX		24
+#define IMX8MM_PGC_GPU3D		25
+#define IMX8MM_PGC_DISPMIX		26
+#define IMX8MM_PGC_VPUG1		27
+#define IMX8MM_PGC_VPUG2		28
+#define IMX8MM_PGC_VPUH1		29
+
+#define IMX8MN_PGC_MIPI			16
 #define IMX8MN_PGC_OTG1			18
+#define IMX8MN_PGC_DDR1			21
+#define IMX8MN_PGC_GPUMIX		23
+#define IMX8MN_PGC_DISPMIX		26
 
 #define IMX8MP_PGC_PCIE			13
 #define IMX8MP_PGC_USB1			14
@@ -233,6 +291,82 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		},
 		.pgc   = BIT(IMX8MM_PGC_OTG2),
 	},
+
+	[IMX8MM_POWER_DOMAIN_GPUMIX] = {
+		.bits  = {
+			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_GPUMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPU] = {
+		.bits  = {
+			.pxx = IMX8MM_GPU_SW_Pxx_REQ,
+			.map = IMX8MM_GPU_A53_DOMAIN,
+			.hskreq = IMX8MM_GPU_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPU_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_GPU2D) | BIT(IMX8MM_PGC_GPU3D),
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUMIX] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_VPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_VPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_VPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG1] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUG1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG1_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUG1),
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG2] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUG2_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG2_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUG2),
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUH1] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUH1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUH1_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUH1),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_DISPMIX] = {
+		.bits  = {
+			.pxx = IMX8MM_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MM_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_DISPMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_MIPI] = {
+		.bits  = {
+			.pxx = IMX8MM_MIPI_SW_Pxx_REQ,
+			.map = IMX8MM_MIPI_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_MIPI),
+	},
 };
 
 static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
@@ -261,6 +395,36 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 		},
 		.pgc   = BIT(IMX8MN_PGC_OTG1),
 	},
+
+	[IMX8MN_POWER_DOMAIN_GPUMIX] = {
+		.bits  = {
+			.pxx = IMX8MN_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MN_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MN_POWER_DOMAIN_DISPMIX] = {
+		.bits  = {
+			.pxx = IMX8MN_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MN_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_DISPMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MN_POWER_DOMAIN_MIPI] = {
+		.bits  = {
+			.pxx = IMX8MN_MIPI_SW_Pxx_REQ,
+			.map = IMX8MN_MIPI_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_MIPI),
+	},
 };
 
 static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
-- 
2.43.0

