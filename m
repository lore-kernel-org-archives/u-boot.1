Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA198606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Iqw4LQ6d;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jTPOQC3J
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A931B40847;
	Mon, 16 Nov 2026 17:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3BO0N6g23kQn; Mon, 16 Nov 2026 17:41:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 036FA40842
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850913;
	b=dbo1Yu2F3ji+HPW/AJbV+aT40y+fagga/4tMNsgMNUiYMwo1dO4lwviB3JjTfyYPBSof
	 SK1NHkfXHaN+CYPCnkLQ0Jd1EQ+KpM1s+wbkB4wsm0BBW1lxD0K7V8Ow8q9VxwReVKyZP
	 z9P35yeSIZETZMhjc0LXV0FA2wEJf7O8TTjt9pG+djlWGT4hgHxDSkAQP8F7dzrYfpcAC
	 TR41+8lxn1o6+xO90tztXZwEZRrQbvNfchU3MmnxXzjh39tNlyzUkLQvtNFvN5buaUPDo
	 kKndcNoP5o1XMsAFJwLo423wIaAFWvDYKPw8AGrvr9WyJU6xGyWwaX2NeiHqO306B7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yqY+YgPfBtGUynimAOo6P9066A+5qmuJzv34uuGniSM=;
	b=demkFIJCfweewuZoCClVar0BEb65khoRXyYnrw19olnvfxHpCb31nqVmkXYN1pCq2nua
	 7pzJpaK50nhM9ErWF/R8uI9GuevClc9Z+/21lNtirOF0peMfPO0RMEBWhfH4dlk8MZhTF
	 6YRh6+Trf0w3vYTQKu32x/+F5K1omqFhPQuCrAXi6mRt7XfEqz34gt2jUvOsRzI6SyEs/
	 cjjXGMkQ0QXfxQUj5E5xz9Jj3hkV9m7icqJsLjTduVA7qqDOIRPLRb+2Usk5AMWexqRSX
	 vqy+WKNZxiXYUygX27Fsk3SCks0On9aEBPhPvMTwS4yN3hyhlzMPsbsNK7dv4fs9IuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850913;
	bh=yqY+YgPfBtGUynimAOo6P9066A+5qmuJzv34uuGniSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iqw4LQ6dv0IQhlqFoYhS0q65zrNeIJF9CI4ti/YD1St5mFv0m0U8SD9P/XNPb+UA0
	 ZU0z9vDUvE1rUkS0MX6KXxrancC5EIARg5d4wEoBrOziOP7u3oDwQ2dnldWdcvC0S9
	 1BSqkSwD7jTS7WrcCF6jV8vH485LHiUqGGPLa2lXaY40HhR4uMbO9cj8oyuZ0JdWod
	 ucU2ZK4ssTg6PkKWu9tO0YLZq0lxjLjuzJbZ1gB2XlOLbyKpxC3TdS+8yF2DuY+TIz
	 3AaLHo1Ua4EogD8eDmrfLz1QV3M5fCVKR2kq496wS/HrhnWbpZpyLfKv0VMo1WF0LR
	 bX0shvCE6uuyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 036FA40842;
	Mon, 16 Nov 2026 17:41:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29E594DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BA3F40282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHy7G3BvZtQT for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:41:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A2C3F4009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jTPOQC3J
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2C3F4009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:49 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSwCb0k3zzKr6D;
 Mon, 16 Nov 2026 18:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqY+YgPfBtGUynimAOo6P9066A+5qmuJzv34uuGniSM=;
 b=jTPOQC3JHcQcvLsiaAcdyqsmYoz32moQjrKTUrUgthV6cs6XMKtLJrJhukjfGU2wEBlHZv
 mEW5YPHyPXLPFtsFCLrFApzM8S3yqVl85R8+30Y5RqdSTrs/YBsj18dODUIwjDXupg/ccU
 3EaI31zC8G1m2xqaey7pGUCNS2iEJUn1bEzNq2JGUMXEeahQEPNoj08waaZH5cyPJHVVgX
 rSAlw8771xHWxCS93+23tnUNTPBIPcE6uc+9tVqt77NfvIeAdB3WeVTQ3V3HwyMzTAcDY6
 AhT3OXEdv8NGKGrqiqrKOkbpsKVmmNdxk8duDBErk+IFEhBZrKeCZsORUFSXZg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <u-boot@0leil.net>,
 Ryder Lee <ryder.lee@mediatek.com>, Stephan Gerhold <stephan@gerhold.net>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot-qcom@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] power: pmic: Constify driver ops
Date: Mon, 16 Nov 2026 18:41:25 +0100
Message-ID: <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 682979afc427ef7a3a3
X-MBO-RS-META: ips8ekacxgj1qa6ekn4xzn341ntgqfpn
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.u-boot-project.org
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/power/pmic/ab8500.c           | 2 +-
 drivers/power/pmic/act8846.c          | 2 +-
 drivers/power/pmic/as3722.c           | 2 +-
 drivers/power/pmic/axp.c              | 4 ++--
 drivers/power/pmic/bd71837.c          | 2 +-
 drivers/power/pmic/cpcap.c            | 2 +-
 drivers/power/pmic/da9063.c           | 2 +-
 drivers/power/pmic/fan53555.c         | 2 +-
 drivers/power/pmic/lp873x.c           | 2 +-
 drivers/power/pmic/lp87565.c          | 2 +-
 drivers/power/pmic/max77663.c         | 2 +-
 drivers/power/pmic/max77686.c         | 2 +-
 drivers/power/pmic/max8907.c          | 2 +-
 drivers/power/pmic/max8997.c          | 2 +-
 drivers/power/pmic/max8998.c          | 2 +-
 drivers/power/pmic/mc34708.c          | 2 +-
 drivers/power/pmic/mp5416.c           | 2 +-
 drivers/power/pmic/mtk-pwrap.c        | 2 +-
 drivers/power/pmic/palmas.c           | 2 +-
 drivers/power/pmic/pca9450.c          | 4 ++--
 drivers/power/pmic/pfuze100.c         | 2 +-
 drivers/power/pmic/pmic_qcom.c        | 2 +-
 drivers/power/pmic/pmic_tps65217.c    | 2 +-
 drivers/power/pmic/pmic_tps65910_dm.c | 2 +-
 drivers/power/pmic/raa215300.c        | 2 +-
 drivers/power/pmic/rk8xx.c            | 4 ++--
 drivers/power/pmic/rn5t567.c          | 2 +-
 drivers/power/pmic/s2mps11.c          | 2 +-
 drivers/power/pmic/s5m8767.c          | 2 +-
 drivers/power/pmic/sandbox.c          | 2 +-
 drivers/power/pmic/stpmic1.c          | 4 ++--
 drivers/power/pmic/tps65090.c         | 2 +-
 drivers/power/pmic/tps65219.c         | 2 +-
 drivers/power/pmic/tps65941.c         | 2 +-
 drivers/power/pmic/tps80031.c         | 2 +-
 35 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/power/pmic/ab8500.c b/drivers/power/pmic/ab8500.c
index b9fae7000b7..2c93a8031df 100644
--- a/drivers/power/pmic/ab8500.c
+++ b/drivers/power/pmic/ab8500.c
@@ -215,7 +215,7 @@ static int ab8500_write(struct udevice *dev, uint reg, const uint8_t *buf, int l
 	return 0;
 }
 
-static struct dm_pmic_ops ab8500_ops = {
+static const struct dm_pmic_ops ab8500_ops = {
 	.reg_count = ab8500_reg_count,
 	.read = ab8500_read,
 	.write = ab8500_write,
diff --git a/drivers/power/pmic/act8846.c b/drivers/power/pmic/act8846.c
index 3058ef0f893..61f49fa76af 100644
--- a/drivers/power/pmic/act8846.c
+++ b/drivers/power/pmic/act8846.c
@@ -65,7 +65,7 @@ static int act8846_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops act8846_ops = {
+static const struct dm_pmic_ops act8846_ops = {
 	.reg_count = act8846_reg_count,
 	.read = act8846_read,
 	.write = act8846_write,
diff --git a/drivers/power/pmic/as3722.c b/drivers/power/pmic/as3722.c
index 9b0f4fb9736..febe0a72852 100644
--- a/drivers/power/pmic/as3722.c
+++ b/drivers/power/pmic/as3722.c
@@ -155,7 +155,7 @@ static int as3722_reg_count(struct udevice *dev)
 	return AS3722_NUM_OF_REGS;
 }
 
-static struct dm_pmic_ops as3722_ops = {
+static const struct dm_pmic_ops as3722_ops = {
 	.reg_count = as3722_reg_count,
 	.read = as3722_read,
 	.write = as3722_write,
diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
index 7d8348b0769..f6a9396ae43 100644
--- a/drivers/power/pmic/axp.c
+++ b/drivers/power/pmic/axp.c
@@ -22,7 +22,7 @@ static int axp_sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return -EINPROGRESS;
 }
 
-static struct sysreset_ops axp_sysreset_ops = {
+static const struct sysreset_ops axp_sysreset_ops = {
 	.request	= axp_sysreset_request,
 };
 
@@ -39,7 +39,7 @@ static int axp_pmic_reg_count(struct udevice *dev)
 	return 0x100;
 }
 
-static struct dm_pmic_ops axp_pmic_ops = {
+static const struct dm_pmic_ops axp_pmic_ops = {
 	.reg_count	= axp_pmic_reg_count,
 	.read		= dm_i2c_read,
 	.write		= dm_i2c_write,
diff --git a/drivers/power/pmic/bd71837.c b/drivers/power/pmic/bd71837.c
index 13642794765..9c9eba6343a 100644
--- a/drivers/power/pmic/bd71837.c
+++ b/drivers/power/pmic/bd71837.c
@@ -87,7 +87,7 @@ static int bd718x7_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops bd71837_ops = {
+static const struct dm_pmic_ops bd71837_ops = {
 	.reg_count = bd71837_reg_count,
 	.read = bd71837_read,
 	.write = bd71837_write,
diff --git a/drivers/power/pmic/cpcap.c b/drivers/power/pmic/cpcap.c
index b9d783773ed..b3889f6bcf4 100644
--- a/drivers/power/pmic/cpcap.c
+++ b/drivers/power/pmic/cpcap.c
@@ -106,7 +106,7 @@ static int cpcap_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops cpcap_ops = {
+static const struct dm_pmic_ops cpcap_ops = {
 	.read = cpcap_read,
 	.write = cpcap_write,
 };
diff --git a/drivers/power/pmic/da9063.c b/drivers/power/pmic/da9063.c
index 59c65702863..a6177ecb92c 100644
--- a/drivers/power/pmic/da9063.c
+++ b/drivers/power/pmic/da9063.c
@@ -118,7 +118,7 @@ static int da9063_probe(struct udevice *dev)
 	return i2c_set_chip_addr_offset_mask(dev, 0x1);
 }
 
-static struct dm_pmic_ops da9063_ops = {
+static const struct dm_pmic_ops da9063_ops = {
 	.reg_count = da9063_reg_count,
 	.read = da9063_read,
 	.write = da9063_write,
diff --git a/drivers/power/pmic/fan53555.c b/drivers/power/pmic/fan53555.c
index 95bf600cbc3..7cf4d0b9d73 100644
--- a/drivers/power/pmic/fan53555.c
+++ b/drivers/power/pmic/fan53555.c
@@ -65,7 +65,7 @@ static int pmic_fan53555_bind(struct udevice *dev)
 					    dev_ofnode(dev), &child);
 };
 
-static struct dm_pmic_ops pmic_fan53555_ops = {
+static const struct dm_pmic_ops pmic_fan53555_ops = {
 	.reg_count = pmic_fan53555_reg_count,
 	.read = pmic_fan53555_read,
 	.write = pmic_fan53555_write,
diff --git a/drivers/power/pmic/lp873x.c b/drivers/power/pmic/lp873x.c
index 2c8fa4ea312..f8c6736f437 100644
--- a/drivers/power/pmic/lp873x.c
+++ b/drivers/power/pmic/lp873x.c
@@ -62,7 +62,7 @@ static int lp873x_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops lp873x_ops = {
+static const struct dm_pmic_ops lp873x_ops = {
 	.read = lp873x_read,
 	.write = lp873x_write,
 };
diff --git a/drivers/power/pmic/lp87565.c b/drivers/power/pmic/lp87565.c
index c2ff75bbcdc..b77feaf57da 100644
--- a/drivers/power/pmic/lp87565.c
+++ b/drivers/power/pmic/lp87565.c
@@ -65,7 +65,7 @@ static int lp87565_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops lp87565_ops = {
+static const struct dm_pmic_ops lp87565_ops = {
 	.read = lp87565_read,
 	.write = lp87565_write,
 };
diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
index a06042e2918..10f692e894c 100644
--- a/drivers/power/pmic/max77663.c
+++ b/drivers/power/pmic/max77663.c
@@ -83,7 +83,7 @@ static int max77663_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops max77663_ops = {
+static const struct dm_pmic_ops max77663_ops = {
 	.read = max77663_read,
 	.write = max77663_write,
 };
diff --git a/drivers/power/pmic/max77686.c b/drivers/power/pmic/max77686.c
index bfe57b386d3..900a33a2219 100644
--- a/drivers/power/pmic/max77686.c
+++ b/drivers/power/pmic/max77686.c
@@ -68,7 +68,7 @@ static int max77686_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops max77686_ops = {
+static const struct dm_pmic_ops max77686_ops = {
 	.reg_count = max77686_reg_count,
 	.read = max77686_read,
 	.write = max77686_write,
diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.c
index 34bef0c8cd6..cb0d0feceb1 100644
--- a/drivers/power/pmic/max8907.c
+++ b/drivers/power/pmic/max8907.c
@@ -76,7 +76,7 @@ static int max8907_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops max8907_ops = {
+static const struct dm_pmic_ops max8907_ops = {
 	.read = max8907_read,
 	.write = max8907_write,
 };
diff --git a/drivers/power/pmic/max8997.c b/drivers/power/pmic/max8997.c
index fb65a3ca730..d80257d0e6a 100644
--- a/drivers/power/pmic/max8997.c
+++ b/drivers/power/pmic/max8997.c
@@ -39,7 +39,7 @@ static int max8997_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 	return ret;
 }
 
-static struct dm_pmic_ops max8997_ops = {
+static const struct dm_pmic_ops max8997_ops = {
 	.reg_count = max8997_reg_count,
 	.read	= max8997_read,
 	.write	= max8997_write,
diff --git a/drivers/power/pmic/max8998.c b/drivers/power/pmic/max8998.c
index 05669023753..e59e79e6248 100644
--- a/drivers/power/pmic/max8998.c
+++ b/drivers/power/pmic/max8998.c
@@ -39,7 +39,7 @@ static int max8998_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 	return ret;
 }
 
-static struct dm_pmic_ops max8998_ops = {
+static const struct dm_pmic_ops max8998_ops = {
 	.reg_count = max8998_reg_count,
 	.read	= max8998_read,
 	.write	= max8998_write,
diff --git a/drivers/power/pmic/mc34708.c b/drivers/power/pmic/mc34708.c
index 0ec52e25a9e..0bd1ea72b39 100644
--- a/drivers/power/pmic/mc34708.c
+++ b/drivers/power/pmic/mc34708.c
@@ -82,7 +82,7 @@ static int mc34708_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops mc34708_ops = {
+static const struct dm_pmic_ops mc34708_ops = {
 	.reg_count = mc34708_reg_count,
 	.read	= mc34708_read,
 	.write	= mc34708_write,
diff --git a/drivers/power/pmic/mp5416.c b/drivers/power/pmic/mp5416.c
index 899c2beeb37..382b93415a8 100644
--- a/drivers/power/pmic/mp5416.c
+++ b/drivers/power/pmic/mp5416.c
@@ -74,7 +74,7 @@ static int mp5416_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops mp5416_ops = {
+static const struct dm_pmic_ops mp5416_ops = {
 	.reg_count = mp5416_reg_count,
 	.read = mp5416_read,
 	.write = mp5416_write,
diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 468af1fba04..4e350cc97c6 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -862,7 +862,7 @@ static int mtk_pwrap_write(struct udevice *dev, uint reg, const uint8_t *buf, in
 	return pwrap_write(wrp, reg, *(u32 *)buf);
 }
 
-static struct dm_pmic_ops mtk_pwrap_ops = {
+static const struct dm_pmic_ops mtk_pwrap_ops = {
 	.reg_count = mtk_pwrap_reg_count,
 	.read = mtk_pwrap_read,
 	.write = mtk_pwrap_write,
diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index e5b497dfc39..efc455ac6a7 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -118,7 +118,7 @@ static int palmas_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops palmas_ops = {
+static const struct dm_pmic_ops palmas_ops = {
 	.read = palmas_read,
 	.write = palmas_write,
 };
diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index cbe8cd05be7..7278b6407e9 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -99,7 +99,7 @@ static int pca9450_probe(struct udevice *dev)
 			       PCA9450_PMIC_RESET_WDOG_B_CFG_MASK, reset_ctrl);
 }
 
-static struct dm_pmic_ops pca9450_ops = {
+static const struct dm_pmic_ops pca9450_ops = {
 	.reg_count = pca9450_reg_count,
 	.read = pca9450_read,
 	.write = pca9450_write,
@@ -180,7 +180,7 @@ int pca9450_sysreset_get_status(struct udevice *dev, char *buf, int size)
 	return 0;
 }
 
-static struct sysreset_ops pca9450_sysreset_ops = {
+static const struct sysreset_ops pca9450_sysreset_ops = {
 	.request	= pca9450_sysreset_request,
 	.get_status	= pca9450_sysreset_get_status,
 };
diff --git a/drivers/power/pmic/pfuze100.c b/drivers/power/pmic/pfuze100.c
index 9e09805d251..dedd149a3f6 100644
--- a/drivers/power/pmic/pfuze100.c
+++ b/drivers/power/pmic/pfuze100.c
@@ -71,7 +71,7 @@ static int pfuze100_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops pfuze100_ops = {
+static const struct dm_pmic_ops pfuze100_ops = {
 	.reg_count = pfuze100_reg_count,
 	.read = pfuze100_read,
 	.write = pfuze100_write,
diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
index 4b8dcc6104c..8dfac183a48 100644
--- a/drivers/power/pmic/pmic_qcom.c
+++ b/drivers/power/pmic/pmic_qcom.c
@@ -51,7 +51,7 @@ static int pmic_qcom_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 	return 0;
 }
 
-static struct dm_pmic_ops pmic_qcom_ops = {
+static const struct dm_pmic_ops pmic_qcom_ops = {
 	.reg_count = pmic_qcom_reg_count,
 	.read = pmic_qcom_read,
 	.write = pmic_qcom_write,
diff --git a/drivers/power/pmic/pmic_tps65217.c b/drivers/power/pmic/pmic_tps65217.c
index bd44e0d9ae0..eb3c5cf926e 100644
--- a/drivers/power/pmic/pmic_tps65217.c
+++ b/drivers/power/pmic/pmic_tps65217.c
@@ -210,7 +210,7 @@ static int tps65217_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops tps65217_ops = {
+static const struct dm_pmic_ops tps65217_ops = {
 	.reg_count = tps65217_reg_count,
 	.read = tps65217_read,
 	.write = tps65217_write,
diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
index bce35603275..9811b75f1df 100644
--- a/drivers/power/pmic/pmic_tps65910_dm.c
+++ b/drivers/power/pmic/pmic_tps65910_dm.c
@@ -95,7 +95,7 @@ static int pmic_tps65910_probe(struct udevice *dev)
 			       TPS65910_I2C_SEL_MASK);
 }
 
-static struct dm_pmic_ops pmic_tps65910_ops = {
+static const struct dm_pmic_ops pmic_tps65910_ops = {
 	.reg_count = pmic_tps65910_reg_count,
 	.read = pmic_tps65910_read,
 	.write = pmic_tps65910_write,
diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215300.c
index a581a1f6dc1..cb90bb2d09d 100644
--- a/drivers/power/pmic/raa215300.c
+++ b/drivers/power/pmic/raa215300.c
@@ -16,7 +16,7 @@ static int raa215300_reg_count(struct udevice *dev)
 	return RAA215300_REG_COUNT;
 }
 
-static struct dm_pmic_ops raa215300_ops = {
+static const struct dm_pmic_ops raa215300_ops = {
 	.reg_count = raa215300_reg_count,
 	.read = dm_i2c_read,
 	.write = dm_i2c_write,
diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 95b71d2fe49..8c51d86bb0e 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -47,7 +47,7 @@ static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return -EINPROGRESS;
 }
 
-static struct sysreset_ops rk8xx_sysreset_ops = {
+static const struct sysreset_ops rk8xx_sysreset_ops = {
 	.request	= rk8xx_sysreset_request,
 };
 
@@ -351,7 +351,7 @@ static int rk8xx_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops rk8xx_ops = {
+static const struct dm_pmic_ops rk8xx_ops = {
 	.reg_count = rk8xx_reg_count,
 	.read = rk8xx_read,
 	.write = rk8xx_write,
diff --git a/drivers/power/pmic/rn5t567.c b/drivers/power/pmic/rn5t567.c
index 0124d84a729..aba04a1b659 100644
--- a/drivers/power/pmic/rn5t567.c
+++ b/drivers/power/pmic/rn5t567.c
@@ -44,7 +44,7 @@ static int rn5t567_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 	return 0;
 }
 
-static struct dm_pmic_ops rn5t567_ops = {
+static const struct dm_pmic_ops rn5t567_ops = {
 	.reg_count = rn5t567_reg_count,
 	.read = rn5t567_read,
 	.write = rn5t567_write,
diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 5cf9d34ffaf..8c19d2a1e53 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -94,7 +94,7 @@ static int s2mps11_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops s2mps11_ops = {
+static const struct dm_pmic_ops s2mps11_ops = {
 	.reg_count = s2mps11_reg_count,
 	.read = s2mps11_read,
 	.write = s2mps11_write,
diff --git a/drivers/power/pmic/s5m8767.c b/drivers/power/pmic/s5m8767.c
index 799d0012540..7bdd9760a82 100644
--- a/drivers/power/pmic/s5m8767.c
+++ b/drivers/power/pmic/s5m8767.c
@@ -72,7 +72,7 @@ static int s5m8767_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops s5m8767_ops = {
+static const struct dm_pmic_ops s5m8767_ops = {
 	.reg_count = s5m8767_reg_count,
 	.read = s5m8767_read,
 	.write = s5m8767_write,
diff --git a/drivers/power/pmic/sandbox.c b/drivers/power/pmic/sandbox.c
index ddc11d6df86..59385be47dc 100644
--- a/drivers/power/pmic/sandbox.c
+++ b/drivers/power/pmic/sandbox.c
@@ -58,7 +58,7 @@ static int sandbox_pmic_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops sandbox_pmic_ops = {
+static const struct dm_pmic_ops sandbox_pmic_ops = {
 	.reg_count = sandbox_pmic_reg_count,
 	.read = sandbox_pmic_read,
 	.write = sandbox_pmic_write,
diff --git a/drivers/power/pmic/stpmic1.c b/drivers/power/pmic/stpmic1.c
index f0415fbd172..86d73e52c3b 100644
--- a/drivers/power/pmic/stpmic1.c
+++ b/drivers/power/pmic/stpmic1.c
@@ -105,7 +105,7 @@ static int stpmic1_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops stpmic1_ops = {
+static const struct dm_pmic_ops stpmic1_ops = {
 	.reg_count = stpmic1_reg_count,
 	.read = stpmic1_read,
 	.write = stpmic1_write,
@@ -258,7 +258,7 @@ static int stpmic1_sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return -EINPROGRESS;
 }
 
-static struct sysreset_ops stpmic1_sysreset_ops = {
+static const struct sysreset_ops stpmic1_sysreset_ops = {
 	.request = stpmic1_sysreset_request,
 };
 
diff --git a/drivers/power/pmic/tps65090.c b/drivers/power/pmic/tps65090.c
index ad2ab34719e..ff9e854cf03 100644
--- a/drivers/power/pmic/tps65090.c
+++ b/drivers/power/pmic/tps65090.c
@@ -70,7 +70,7 @@ static int tps65090_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops tps65090_ops = {
+static const struct dm_pmic_ops tps65090_ops = {
 	.reg_count = tps65090_reg_count,
 	.read = tps65090_read,
 	.write = tps65090_write,
diff --git a/drivers/power/pmic/tps65219.c b/drivers/power/pmic/tps65219.c
index 1fecde84795..35108509377 100644
--- a/drivers/power/pmic/tps65219.c
+++ b/drivers/power/pmic/tps65219.c
@@ -68,7 +68,7 @@ static int tps65219_bind(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
-static struct dm_pmic_ops tps65219_ops = {
+static const struct dm_pmic_ops tps65219_ops = {
 	.reg_count = tps65219_reg_count,
 	.read = tps65219_read,
 	.write = tps65219_write,
diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
index 57d470521fc..0b6c25ee7a1 100644
--- a/drivers/power/pmic/tps65941.c
+++ b/drivers/power/pmic/tps65941.c
@@ -64,7 +64,7 @@ static int tps65941_bind(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
-static struct dm_pmic_ops tps65941_ops = {
+static const struct dm_pmic_ops tps65941_ops = {
 	.read = tps65941_read,
 	.write = tps65941_write,
 };
diff --git a/drivers/power/pmic/tps80031.c b/drivers/power/pmic/tps80031.c
index 6004a14cd6c..318ebc5ca23 100644
--- a/drivers/power/pmic/tps80031.c
+++ b/drivers/power/pmic/tps80031.c
@@ -73,7 +73,7 @@ static int tps80031_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops tps80031_ops = {
+static const struct dm_pmic_ops tps80031_ops = {
 	.read = tps80031_read,
 	.write = tps80031_write,
 };
-- 
2.53.0

