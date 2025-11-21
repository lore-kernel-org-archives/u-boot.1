Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF534CFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC3283A8A;
	Fri, 21 Nov 2025 18:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eXyh71xO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64FF683A5A; Fri, 21 Nov 2025 18:36:38 +0100 (CET)
Received: from mx-relay50-hz3.antispameurope.com
 (mx-relay50-hz3.antispameurope.com [94.100.134.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D911839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=T15JxTIZFrHnLj5qENkHCscZnfb/ptF2He6fr/GtFRI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746595;
 b=e0mSF7DMvONX0OdWuX1G/xlp6ZAXV5+2copvpr1CjlxGVmEdvql7ZwY5lEQ7n/cznuN3Zr4k
 KQfgTCT1n9HK8YluUAJIEAjcxyfZ/6NHAMDmgnM+f654P8V9wKg19yLMmSkLRACEBKiG4z5S6Tu
 lPp9kHQzAqX89KLEy5tNzpuO21er7ZHHEfl26eJiYYFYTtII6RRif6dVEVy2ITVCoFVqMlAeby1
 zysGfCQoxNdFspARM+38T7q/JMURw+tVCn6av3kYmncs7M07T78YGH8YkIl1u5l3Y7Wbn0Ei8QD
 uRjqO5s5Rnjp/wZeQP27P8kA3MrkDju6UWBJvGd5rvIJQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746595;
 b=QeJJw2xjVcTBecJ/qVERkyIMU4ra+9/TxuHgtXHVQmfTenalu5a04RZpF42r7PvJFBa3A6tv
 eb6qLD7aptrRBQDlbQLbNR7XyqQi6ySoe0qpKCPTy7GPNAFAN459wYaaAv3WJg72FwR9zxMrCk+
 19dIK/UVjxlgna1tYoO/udYqObAWEAESEx1zW4qiAJxesaCHHQUpWCVS/0frOiIPZfxkN3NMbHC
 0iLXMhKelvtug1R/4DK8htUF+xJMXpna5kPbyiVjpwPsU3VjRR5IJK7Omh+HqjA6BdacpO3k4yD
 ntaPjA8NnjSGA8S+9vXe4WhC3nHcIJV9qpp1PXOQhjk0Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay50-hz3.antispameurope.com; Fri, 21 Nov 2025 18:36:35 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id BD298A404C3;
 Fri, 21 Nov 2025 18:36:15 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 1/8] net: fec_mxc: respect return value of phy_config
Date: Fri, 21 Nov 2025 18:34:41 +0100
Message-Id: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay50-hz3.antispameurope.com with 4dCj7N2p3Cz2nH2B
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 90f5ab0fcfc264a7e22f6c6d7c33d8ef
X-cloud-security: scantime:2.044
DKIM-Signature: a=rsa-sha256;
 bh=T15JxTIZFrHnLj5qENkHCscZnfb/ptF2He6fr/GtFRI=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746595; v=1;
 b=eXyh71xO0Lk3LnxG0pJivqjUt1sbyBpETQlDQDd0NkwLw2dzTjcJRIXxgCC+ziH1kkGwBz4O
 tG4pDPqwr4Mj+DeuJ1ML+Fe5kGicq2LH4oj/8s91jaB8AJ4X656wiwUfNn6sln0IJdV6991zi7q
 hs+G+eguqvGPc9mP5QL0auF4+fKcjRvkDCCycTzX/R31CuAxpOvmkg68TUvxicuThWyy3A/HK0M
 NToOl2+MBaLNb5vOR1SL/XsQueuhlzB0hRmJA44dvmJoAA14ybSFW+Hwg39fO26nfBQBbnhNMmJ
 XshavYPNDq5cXd+n756WnDXt4hRCurRLmJXHvPmbpPdJw==
X-Mailman-Approved-At: Fri, 21 Nov 2025 18:48:51 +0100
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

phy_config may fail - for instance in parsing device tree.
This should be handled correctly. So return errors from
phy_config to caller.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 9ac72d25ef6..471e3de44a6 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1189,9 +1189,11 @@ static int fec_phy_init(struct fec_priv *priv, struct udevice *dev)
 
 	priv->phydev = phydev;
 	priv->phydev->node = priv->phy_of_node;
-	phy_config(phydev);
+	ret = phy_config(phydev);
+	if (ret)
+		pr_err("phy_config failed: %d", ret);
 
-	return 0;
+	return ret;
 }
 
 #if CONFIG_IS_ENABLED(DM_GPIO)
-- 
2.34.1

