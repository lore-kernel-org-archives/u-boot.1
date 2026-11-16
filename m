Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71363606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wci5v47P;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RSsVQRkV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 470E24056F;
	Mon, 16 Nov 2026 17:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QB3k6XXxkOvI; Mon, 16 Nov 2026 17:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5ABF7404C9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850768;
	b=LbMY8uDTkEcH6bCC4XJIhYjBpLb+iHE/6drUD+aC7T5b1yoylplBBmZZXiEs+jAubS/I
	 +UzlXewOCTMcY5Q/gUpKfCUYccXJ5FEW66u0kqxArayBUy3Lk43UcsMYUwztrR70mI2lC
	 QlfRLn41Ly2SurO0epwX+KNVy6qCJ7pwgOLDnmzDxe03DQ2AHR8gIp0cAabozSBJiCRZz
	 ytN2YzA020xscUqbBurqD8ucECjytYNkBEV5dvuc4UI940WeEXb2nd9UVQxXeLi+VuXJs
	 vZmFoPBClUc3dRUGVAue0Md4YJCPAmoobTU8Av/QtLFqXqvN3CXG6Jj8oSjCmTLrCNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850768;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+m0CBcEW//Ak8o2bPFaChpGiqNpC842n4k990TkIqKw=;
	b=c3yHFnCbT/dt5TV9oMqw53t/EGBepcm+SUgjuYkS91A2eh3vqP7WvK9PGAtS7EOuC7bW
	 d407tyhxBtyKTXApzwoAcUxJ6/eCnieOxZ/wxlCh7AWnxe7k5LHltzwFR3D5JLP/0jUuo
	 cjjPdH1kLCMzr8W6M9MfIKXoxVM/f5u/jbXl5OK5wVp9qP6W4RhFEtALrkv4zSvqk3+hN
	 0TZH7cSo4p3V6vl6JuM/R6Qp6VsPOrR28t8/pgrSO1n4tTgDVMimA7APqMLYvANGXJyem
	 9oonElNGLyLxXTVtZaImn/7+K8ob7GWlT5fkADp9K6Aw3GomMAOB6B8KkzWiBxZkeUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850768;
	bh=+m0CBcEW//Ak8o2bPFaChpGiqNpC842n4k990TkIqKw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wci5v47P2CuAyo24xnkBBVvUlagtqY+ROGdXFdVRMuo+yDcbhSdhk46He/gVMlELd
	 ALUHmPKVjXTvq3WdNwYlH/7JJAZ+i4ak9R2C03oesVw7DqomJl4hn7aqT3GKa/L7UM
	 vX1TxKQvMbe9FUG4O3Fnly1yKplc9wuwlKwq/sHN/mDF5VMU0kh/jWoJJpMrSGkC+S
	 D+jVwoZg0xii2d7635nEnlkIHplzJxiLpkbzZV5XigwFiPpRyh0QvBEy0suyKGWquH
	 P/0kqcL+VVKLcP8mLsB/DwMpAcwEIeJX7TlaFpu/+j8kR+3z0OsYn4oRXs6VoaQHza
	 0ujZNrDmeGEiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ABF7404C9;
	Mon, 16 Nov 2026 17:39:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3D4070B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96765402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:39:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Emdm62idA8l for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9C23C4009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=RSsVQRkV
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C23C4009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:39:25 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw8p14mTzKr6g;
 Mon, 16 Nov 2026 18:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+m0CBcEW//Ak8o2bPFaChpGiqNpC842n4k990TkIqKw=;
 b=RSsVQRkVOsUUmQ4oAFkfeNWGdBHb16hymhMNejr6JjDrPXkudyV9mDq6lKxySa4iHej6Sm
 7p+neV3JJkPe4fDIV55vZ533bwLsNmy72ov4RBwJCAMt23ltCmEGc4mO/6CX8UwC7n1NB8
 36flZwC+rcwosSwfU5b0bT4FGD1EFRAvr83VZbqEQrGZdU903lfVLJojuu0TPMhCz+AYXI
 +c+5lEhLb8RNTdYzxs3Z9hyf7j42MDYPsCBktPx9qTwvKXw3g2aHCZoDQjf+gIaK6PIk3m
 RHBQBOcHVSXdxaXul+L2IDvhhH/3nGKMk0nfuTR0mDzMzJgFvcm0xooztwfKQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] misc: Constify driver ops
Date: Mon, 16 Nov 2026 18:39:11 +0100
Message-ID: <20261116173918.3488067-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b50001c0ea200a75169
X-MBO-RS-META: 7jnkogb8f54pceuptbmxy1o9pimxswfi
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/misc/cros_ec_i2c.c     | 2 +-
 drivers/misc/cros_ec_lpc.c     | 2 +-
 drivers/misc/cros_ec_spi.c     | 2 +-
 drivers/misc/imx8/scu.c        | 2 +-
 drivers/misc/imx_ele/ele_mu.c  | 2 +-
 drivers/misc/p2sb_emul.c       | 2 +-
 drivers/misc/qfw_mmio.c        | 2 +-
 drivers/misc/qfw_pio.c         | 2 +-
 drivers/misc/qfw_sandbox.c     | 2 +-
 drivers/misc/sandbox_adder.c   | 2 +-
 drivers/misc/swap_case.c       | 2 +-
 drivers/misc/tegra186_bpmp.c   | 2 +-
 drivers/misc/vexpress_config.c | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/cros_ec_i2c.c b/drivers/misc/cros_ec_i2c.c
index cbdc55054ba..6e546284359 100644
--- a/drivers/misc/cros_ec_i2c.c
+++ b/drivers/misc/cros_ec_i2c.c
@@ -219,7 +219,7 @@ static int cros_ec_probe(struct udevice *dev)
 	return cros_ec_register(dev);
 }
 
-static struct dm_cros_ec_ops cros_ec_ops = {
+static const struct dm_cros_ec_ops cros_ec_ops = {
 	.command = cros_ec_i2c_command,
 	.packet = cros_ec_i2c_packet,
 };
diff --git a/drivers/misc/cros_ec_lpc.c b/drivers/misc/cros_ec_lpc.c
index e2a3226362a..33b7f5b8a33 100644
--- a/drivers/misc/cros_ec_lpc.c
+++ b/drivers/misc/cros_ec_lpc.c
@@ -241,7 +241,7 @@ static int cros_ec_probe(struct udevice *dev)
 	return cros_ec_register(dev);
 }
 
-static struct dm_cros_ec_ops cros_ec_ops = {
+static const struct dm_cros_ec_ops cros_ec_ops = {
 	.packet = cros_ec_lpc_packet,
 	.command = cros_ec_lpc_command,
 	.check_version = cros_ec_lpc_check_version,
diff --git a/drivers/misc/cros_ec_spi.c b/drivers/misc/cros_ec_spi.c
index e86791c03a7..006a67a2a1e 100644
--- a/drivers/misc/cros_ec_spi.c
+++ b/drivers/misc/cros_ec_spi.c
@@ -174,7 +174,7 @@ static int cros_ec_probe(struct udevice *dev)
 	return cros_ec_register(dev);
 }
 
-static struct dm_cros_ec_ops cros_ec_ops = {
+static const struct dm_cros_ec_ops cros_ec_ops = {
 	.packet = cros_ec_spi_packet,
 	.command = cros_ec_spi_command,
 };
diff --git a/drivers/misc/imx8/scu.c b/drivers/misc/imx8/scu.c
index 5d3db0bc4df..a76fb5f9b6a 100644
--- a/drivers/misc/imx8/scu.c
+++ b/drivers/misc/imx8/scu.c
@@ -227,7 +227,7 @@ static int imx8_scu_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct misc_ops imx8_scu_ops = {
+static const struct misc_ops imx8_scu_ops = {
 	.call = imx8_scu_call,
 };
 
diff --git a/drivers/misc/imx_ele/ele_mu.c b/drivers/misc/imx_ele/ele_mu.c
index 65a4779c041..06f88fc9630 100644
--- a/drivers/misc/imx_ele/ele_mu.c
+++ b/drivers/misc/imx_ele/ele_mu.c
@@ -237,7 +237,7 @@ static int imx8ulp_mu_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct misc_ops imx8ulp_mu_ops = {
+static const struct misc_ops imx8ulp_mu_ops = {
 	.call = imx8ulp_mu_call,
 };
 
diff --git a/drivers/misc/p2sb_emul.c b/drivers/misc/p2sb_emul.c
index 3dac6bd82e3..2f86a2481ae 100644
--- a/drivers/misc/p2sb_emul.c
+++ b/drivers/misc/p2sb_emul.c
@@ -242,7 +242,7 @@ static int sandbox_p2sb_emul_map_physmem(struct udevice *dev,
 	return 0;
 }
 
-static struct dm_pci_emul_ops sandbox_p2sb_emul_emul_ops = {
+static const struct dm_pci_emul_ops sandbox_p2sb_emul_emul_ops = {
 	.read_config = sandbox_p2sb_emul_read_config,
 	.write_config = sandbox_p2sb_emul_write_config,
 	.read_io = sandbox_p2sb_emul_read_io,
diff --git a/drivers/misc/qfw_mmio.c b/drivers/misc/qfw_mmio.c
index f397384054a..559740e6312 100644
--- a/drivers/misc/qfw_mmio.c
+++ b/drivers/misc/qfw_mmio.c
@@ -98,7 +98,7 @@ static int qfw_mmio_probe(struct udevice *dev)
 	return qfw_register(dev);
 }
 
-static struct dm_qfw_ops qfw_mmio_ops = {
+static const struct dm_qfw_ops qfw_mmio_ops = {
 	.read_entry_io = qfw_mmio_read_entry_io,
 	.read_entry_dma = qfw_mmio_read_entry_dma,
 };
diff --git a/drivers/misc/qfw_pio.c b/drivers/misc/qfw_pio.c
index e2f628d3383..5bd6d972f8d 100644
--- a/drivers/misc/qfw_pio.c
+++ b/drivers/misc/qfw_pio.c
@@ -56,7 +56,7 @@ static int qfw_pio_probe(struct udevice *dev)
 	return qfw_register(dev);
 }
 
-static struct dm_qfw_ops qfw_pio_ops = {
+static const struct dm_qfw_ops qfw_pio_ops = {
 	.read_entry_io = qfw_pio_read_entry_io,
 	.read_entry_dma = qfw_pio_read_entry_dma,
 };
diff --git a/drivers/misc/qfw_sandbox.c b/drivers/misc/qfw_sandbox.c
index 1002df75339..f42f393510d 100644
--- a/drivers/misc/qfw_sandbox.c
+++ b/drivers/misc/qfw_sandbox.c
@@ -109,7 +109,7 @@ static int qfw_sandbox_probe(struct udevice *dev)
 	return qfw_register(dev);
 }
 
-static struct dm_qfw_ops qfw_sandbox_ops = {
+static const struct dm_qfw_ops qfw_sandbox_ops = {
 	.read_entry_io = qfw_sandbox_read_entry_io,
 	.read_entry_dma = qfw_sandbox_read_entry_dma,
 };
diff --git a/drivers/misc/sandbox_adder.c b/drivers/misc/sandbox_adder.c
index de1c6357582..9ca7cd38ed2 100644
--- a/drivers/misc/sandbox_adder.c
+++ b/drivers/misc/sandbox_adder.c
@@ -39,7 +39,7 @@ static int sandbox_adder_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct axi_ops sandbox_adder_ops = {
+static const struct axi_ops sandbox_adder_ops = {
 	.read	= sandbox_adder_read,
 	.write	= sandbox_adder_write,
 };
diff --git a/drivers/misc/swap_case.c b/drivers/misc/swap_case.c
index d4a5620c62c..e9f991fe6d9 100644
--- a/drivers/misc/swap_case.c
+++ b/drivers/misc/swap_case.c
@@ -383,7 +383,7 @@ static int sandbox_swap_case_unmap_physmem(struct udevice *dev,
 	return 0;
 }
 
-static struct dm_pci_emul_ops sandbox_swap_case_emul_ops = {
+static const struct dm_pci_emul_ops sandbox_swap_case_emul_ops = {
 	.read_config = sandbox_swap_case_read_config,
 	.write_config = sandbox_swap_case_write_config,
 	.read_io = sandbox_swap_case_read_io,
diff --git a/drivers/misc/tegra186_bpmp.c b/drivers/misc/tegra186_bpmp.c
index a1585b81867..09434d78f43 100644
--- a/drivers/misc/tegra186_bpmp.c
+++ b/drivers/misc/tegra186_bpmp.c
@@ -241,7 +241,7 @@ static int tegra186_bpmp_remove(struct udevice *dev)
 	return 0;
 }
 
-static struct misc_ops tegra186_bpmp_ops = {
+static const struct misc_ops tegra186_bpmp_ops = {
 	.call = tegra186_bpmp_call,
 };
 
diff --git a/drivers/misc/vexpress_config.c b/drivers/misc/vexpress_config.c
index e7655ceff74..0a34a666c51 100644
--- a/drivers/misc/vexpress_config.c
+++ b/drivers/misc/vexpress_config.c
@@ -83,7 +83,7 @@ static int vexpress_config_write(struct udevice *dev,
 	return vexpress_config_exec(priv, true, (void *)buf, size);
 }
 
-static struct misc_ops vexpress_config_ops = {
+static const struct misc_ops vexpress_config_ops = {
 	.read = vexpress_config_read,
 	.write = vexpress_config_write,
 };
-- 
2.53.0

