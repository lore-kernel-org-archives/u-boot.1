Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737A4C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 16:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9717787E8E;
	Thu, 21 Mar 2024 17:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711038385;
	bh=iIFD99U7urplfufHFrsqr9Ilax1QwtcVp9YtQ8XFUWY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SLSZF7h2aKggIQQHJRRk6BxoUMAC8O3IXQP5rClUhkXYnedE0cmxTW4oDybvPN1Q4
	 67TfMv/83wTX+mCTMCBx4HG871HMnHyLenkgfhhq/Uz3/X/HJ3wzeit+Kp3f3ztQaj
	 1CcVFvSe3mkZV/J05dVTLM+HxJm3RAvKfsTouWM6yiSxgCJBHhejZFys7hsPUUl3XY
	 ulEzHjf4ESciP60EpqNULDWNMGLxbu/MlVKE5Nuwuswbj7JH/wyKAGyWnajIBOccHU
	 IvfLD0jvqxvViWab56KMjxt2HqP1R9Qojd8xXXZndWQHHToInTVpnilweY3BQHyd/d
	 cmfBjeymxpFqg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 702D387D5E;
 Thu, 21 Mar 2024 17:26:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711038384;
 bh=iIFD99U7urplfufHFrsqr9Ilax1QwtcVp9YtQ8XFUWY=;
 h=From:To:Cc:Subject:Date:From;
 b=GReUJYg6uFkuJ1/IR+/xAld+JOq0K9ygMMg9GcMrggEq2Uy3puNaPmJ9/C4Q/aGxU
 8NrdYIOnyREPP/giuVyU6xwurv0ghayQ9JOpRTXNV7UDFqBzEtV+HUzPNGv/iYt62p
 N4OX8QcoqNvLkatTtCUgVK2MAYOMeFzKXhg42DtRXVS5LUazulEOtHcjfqGHbYxIUH
 L4hgzS//YMdz8HH/pSTh6Yl7+VqlaL++5JfnHVR6p65xRDsFTYahC/QIbgMa534yF8
 1QnS3dtQqjcbdbOv/ljG08RCNJG+plh8s0z6PmHkENP4aPtv0/LSF1erR/vhd/A7vV
 PqYWwZOIXWdJw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Johan Jonker <jbx6244@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC][PATCH] syscon: Add syscon_regmap_lookup_by_compatible wrapper
Date: Thu, 21 Mar 2024 17:23:36 +0100
Message-ID: <20240321162611.76415-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Add a wrapper to look up a system controller by a compatible string.

This operates by looking up the given name in the device (device
tree property) of the device using the system controller.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/core/syscon-uclass.c | 27 +++++++++++++++++++++++++++
 include/syscon.h             | 13 +++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/core/syscon-uclass.c b/drivers/core/syscon-uclass.c
index a47b8bd3c01..b89006c030d 100644
--- a/drivers/core/syscon-uclass.c
+++ b/drivers/core/syscon-uclass.c
@@ -111,6 +111,33 @@ static int syscon_probe_by_ofnode(ofnode node, struct udevice **devp)
 	return 0;
 }
 
+struct regmap *syscon_regmap_lookup_by_compatible(struct udevice *dev,
+					          const char *compatible)
+{
+	struct udevice *syscon;
+	struct regmap *r;
+	ofnode node;
+	int err;
+
+	node = ofnode_by_compatible(ofnode_null(), compatible);
+	if (!ofnode_valid(node)) {
+		dev_dbg(dev, "unable to find syscon device\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	err = syscon_probe_by_ofnode(node, &syscon);
+	if (err)
+		return ERR_PTR(-ENODEV);
+
+	r = syscon_get_regmap(syscon);
+	if (!r) {
+		dev_dbg(dev, "unable to find regmap\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	return r;
+}
+
 struct regmap *syscon_regmap_lookup_by_phandle(struct udevice *dev,
 					       const char *name)
 {
diff --git a/include/syscon.h b/include/syscon.h
index 7a5ee3fa26b..88f264d801b 100644
--- a/include/syscon.h
+++ b/include/syscon.h
@@ -60,6 +60,19 @@ int syscon_get_by_driver_data(ulong driver_data, struct udevice **devp);
  */
 struct regmap *syscon_get_regmap_by_driver_data(ulong driver_data);
 
+/**
+ * syscon_regmap_lookup_by_compatible() - Look up a controller by a compatible string
+ *
+ * This operates by looking up the given name in the device (device
+ * tree property) of the device using the system controller.
+ *
+ * @dev:	Device using the system controller
+ * @compatible:	Compatible string of the system controller
+ * Return:	A pointer to the regmap if found, ERR_PTR(-ve) on error
+ */
+struct regmap *syscon_regmap_lookup_by_compatible(struct udevice *dev,
+						  const char *compatible);
+
 /**
  * syscon_regmap_lookup_by_phandle() - Look up a controller by a phandle
  *
-- 
2.43.0

