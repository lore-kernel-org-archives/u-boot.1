Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62179C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0923D87EDC;
	Mon, 12 Feb 2024 08:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1A787EF0; Mon, 12 Feb 2024 08:48:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 87BCE87EE7
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 944DBDA7;
 Sun, 11 Feb 2024 23:48:45 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C804B3F762;
 Sun, 11 Feb 2024 23:48:00 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 08/21] drivers: fwu: allocate memory for metadata copies
Date: Mon, 12 Feb 2024 13:16:59 +0530
Message-Id: <20240212074712.3657076-9-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
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

With migration of the FWU metadata access code to version 2, the size
of the metadata is obtained at runtime. Allocate memory for both the
metadata copies from the driver's probe function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1: None

 drivers/fwu-mdata/gpt_blk.c | 4 ++++
 drivers/fwu-mdata/raw_mtd.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/fwu-mdata/gpt_blk.c b/drivers/fwu-mdata/gpt_blk.c
index 97eac3611f..c2cb7ef7c3 100644
--- a/drivers/fwu-mdata/gpt_blk.c
+++ b/drivers/fwu-mdata/gpt_blk.c
@@ -159,6 +159,10 @@ static int fwu_mdata_gpt_blk_probe(struct udevice *dev)
 
 	priv->blk_dev = mdata_dev;
 
+	ret = fwu_mdata_copies_allocate();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
index da36094644..d91518bf0a 100644
--- a/drivers/fwu-mdata/raw_mtd.c
+++ b/drivers/fwu-mdata/raw_mtd.c
@@ -260,6 +260,10 @@ static int fwu_mdata_mtd_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = fwu_mdata_copies_allocate();
+	if (ret)
+		return ret;
+
 	/* Read the metadata to get number of banks and images */
 	ret = fwu_get_banks_images(&nbanks, &nimages);
 	if (ret)
-- 
2.34.1

