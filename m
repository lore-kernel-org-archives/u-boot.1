Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135BAC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 21:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695F1879A0;
	Tue, 12 Mar 2024 22:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710278204;
	bh=BtmOfXCddIV994DP4RejMEjxtNen5Qq/ce5w6fWAOng=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=an2CUwHNKzBkR6e9VhFVZcFcNHwrq191Nxw8ZKPqHazzDTMFRRcYp0bg697OobyJE
	 laY+N7OaM7dcDd8PHEgInmb7oXM/0ILrVbI2AW3OFLHsUrEldlOOpgNddp8bke1Wjr
	 6PPY+JpYplAf8gd6nHx7A6NRQlAN5ewftN8nCtz6metKO54zoLCTjtU+IN9Al/5d+A
	 xNm0K27B+lX6JnFMOqfkeDGheDHuS9Qr9JbhVZR0PXzQdCM2X7zT68ZeiLk30mhwgN
	 6D/fEWOkzqtrY9FE/juHkFMzihp1isqG4kHNNiRLq2/mSPCotx4u27aJQWiJJ4Wiob
	 slpPG4RE2UBlQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 85D5B8785F;
 Tue, 12 Mar 2024 22:16:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710278203;
 bh=BtmOfXCddIV994DP4RejMEjxtNen5Qq/ce5w6fWAOng=;
 h=From:To:Cc:Subject:Date:From;
 b=ywdF+X1d5/NRjKJXYTAfvZURtCoHZIi6skQtOUmt2VBYbNx3P1W4npZ1RDbGEFhKw
 lyVjQMNMVVW0y5c4fgF3WDaeAc/4I3rZPuybpzDpVXw7BNWShGqU3cQjoWc3tttPBK
 jLLBA6WNcPwY8O6xMQd5khyy0YpW+46i+IfsWYL01XpCWKcB6/a7ADXTlTh9ouA9Dg
 7F1EzzBs+ALxN+vzDuiQX6yQEzvTD9o40FP0Y1JY29pX6QgglWUGtNPtDdI5jF3esp
 XzDT2nvU3GEh9djIvhP7VEhFKQhjnVTzEkaKwrRbDguUGlnSLz0od2eX+0D/xuTU1g
 6W3ZeXwG+BOaQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: imx: stm32: Test whether ethernet node is enabled before
 reading MAC EEPROM on DHSOM
Date: Tue, 12 Mar 2024 22:15:58 +0100
Message-ID: <20240312211628.32842-1-marex@denx.de>
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

Check whether the ethernet interface is enabled at all before reading
MAC EEPROM. As a cost saving measure, it can happen that the MAC EEPROM
is not populated on SoMs which do not use ethernet.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
NOTE: It is probably best if this goes in via either imx or stm32 tree,
      I can break the patch up, but that would introduce dependency
      between two PRs in different trees. Let me know what you prefer.
---
 board/dhelectronics/common/dh_common.c           | 16 ++++++++++++++++
 board/dhelectronics/common/dh_common.h           |  8 ++++++++
 board/dhelectronics/dh_imx6/dh_imx6.c            |  3 +++
 .../dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c  |  6 ++++++
 board/dhelectronics/dh_stm32mp1/board.c          |  6 ++++++
 5 files changed, 39 insertions(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 67e3d59b1f3..34094a020b0 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -18,6 +18,19 @@ bool dh_mac_is_in_env(const char *env)
 	return eth_env_get_enetaddr(env, enetaddr);
 }
 
+int dh_get_mac_is_enabled(const char *alias)
+{
+	ofnode node = ofnode_path(alias);
+
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	if (!ofnode_is_enabled(node))
+		return -ENODEV;
+
+	return 0;
+}
+
 int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
 {
 	struct udevice *dev;
@@ -57,6 +70,9 @@ __weak int dh_setup_mac_address(void)
 	if (dh_mac_is_in_env("ethaddr"))
 		return 0;
 
+	if (dh_get_mac_is_enabled("ethernet0"))
+		return 0;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		return eth_env_set_enetaddr("ethaddr", enetaddr);
 
diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
index 2b24637d96d..a2de5b1553e 100644
--- a/board/dhelectronics/common/dh_common.h
+++ b/board/dhelectronics/common/dh_common.h
@@ -11,6 +11,14 @@
  */
 bool dh_mac_is_in_env(const char *env);
 
+/*
+ * dh_get_mac_is_enabled - Test if ethernet MAC is enabled in DT
+ *
+ * @alias: alias for ethernet MAC device tree node
+ * Return: 0 if OK, other value on error
+ */
+int dh_get_mac_is_enabled(const char *alias);
+
 /*
  * dh_get_mac_from_eeprom - Get MAC address from eeprom and write it to enetaddr
  *
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index 07fc9b1fe6d..0676587c38a 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -92,6 +92,9 @@ int dh_setup_mac_address(void)
 	if (dh_mac_is_in_env("ethaddr"))
 		return 0;
 
+	if (dh_get_mac_is_enabled("ethernet0"))
+		return 0;
+
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto out;
 
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 5f12d787d38..ff2c0e87215 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -47,6 +47,9 @@ static int dh_imx8_setup_ethaddr(void)
 	if (dh_mac_is_in_env("ethaddr"))
 		return 0;
 
+	if (dh_get_mac_is_enabled("ethernet0"))
+		return 0;
+
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto out;
 
@@ -66,6 +69,9 @@ static int dh_imx8_setup_eth1addr(void)
 	if (dh_mac_is_in_env("eth1addr"))
 		return 0;
 
+	if (dh_get_mac_is_enabled("ethernet1"))
+		return 0;
+
 	if (!dh_imx_get_mac_from_fuse(enetaddr))
 		goto increment_out;
 
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 88eb7d1b8d4..b3309c9d330 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -129,6 +129,9 @@ static int dh_stm32_setup_ethaddr(void)
 	if (dh_mac_is_in_env("ethaddr"))
 		return 0;
 
+	if (dh_get_mac_is_enabled("ethernet0"))
+		return 0;
+
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		return eth_env_set_enetaddr("ethaddr", enetaddr);
 
@@ -142,6 +145,9 @@ static int dh_stm32_setup_eth1addr(void)
 	if (dh_mac_is_in_env("eth1addr"))
 		return 0;
 
+	if (dh_get_mac_is_enabled("ethernet1"))
+		return 0;
+
 	if (dh_stm32_mac_is_in_ks8851())
 		return 0;
 
-- 
2.43.0

