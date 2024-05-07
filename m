Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EA4C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 13:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1ECE88739;
	Tue,  7 May 2024 15:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715087219;
	bh=Ali34y/sW+NWcJguDuR5pqwA4KDR/mdQG+HoQ9R/ZF4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xTu4Hb/4zVbYn+dSejSsYYvI5E925tMMkwnU0hI4rPWmVuikN+emCKIRw2dLDJY1C
	 LC/sE1HBXKPfnJN/EAGGmHVpzqPto0Alr47Uy55f0zUpuJm/1W3x2IOhpIxy/3r3La
	 9CxVt00XarAOJhyVLn5RzRXDfI3gvS+3vpaORK5eaV2bnmV1Dtu/j4nH+0NNAlSwFi
	 XAnXTP5/PQS41+/jUPECEkR1s7zw4PaRN4mnVawR0qYkz1G252lXLs0tGzUpBbLv2b
	 fGkmIh8TgiNBwXMhlOwtvAdlmPdckGxVzrg4qeN/uPCwIgDImO+GfG5NfsEwFPbp2B
	 2d/Lx8QLZVvCg==
Received: from localhost (dslb-088-077-007-084.088.077.pools.vodafone-ip.de
 [88.77.7.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 83B8088723;
 Tue,  7 May 2024 15:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715087218;
 bh=Ali34y/sW+NWcJguDuR5pqwA4KDR/mdQG+HoQ9R/ZF4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qF4okJ1isGQU26bS/SdGyf3Cy35BXx18QQZ0umbKw3QDVocjVBkJwCo4k+Y3YbLcr
 YFLOJXBxqZV7lpdGw5UnQ/n8QAN1YFsR1AZXSo+JBsmc2MBK7JPEypSJyIOgB2PwGH
 SCEt0e39htxFD+/dUt4KxsUndTqreh0kU4mM25EEA+4me92IrCs8Gjgx7FjRR6E/RA
 /kz7mioE3adXYOx9F4ZQ/VSB5Pb4KowQbMvgsmEeL95oFOls65bmbimNRlQ3qy+i8/
 SNGmiBsiIU5eGZ8P5qpfWXuv2sYfKIOi6WdbFYksS5DN1bTGbJ7gyCHJVrvId+d1Fj
 d4vghWdIEKdCQ==
From: Claudius Heine <ch@denx.de>
To: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Claudius Heine <ch@denx.de>, u-boot@lists.denx.de (open list)
Subject: [PATCH] imx: hab: add documentation about the required keys/certs
Date: Tue,  7 May 2024 15:06:50 +0200
Message-ID: <20240507130650.713801-1-ch@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240503010518.263458-1-marex@denx.de>
References: <20240503010518.263458-1-marex@denx.de>
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

For CST to find the certificates and keys for signing, some keys and
certs need to be copied into the u-boot build directory.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
index ce1de659d8..42214df21a 100644
--- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
+++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
@@ -144,6 +144,22 @@ The signing is activated by wrapping SPL and fitImage sections into nxp-imx8mcst
 etype, which is done automatically in arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
 in case CONFIG_IMX_HAB Kconfig symbol is enabled.
 
+Per default the HAB keys and certificates need to be located in the build
+directory, this means copying the following files from the HAB keys directory
+flat (e.g. removing the `keys` and `cert` subdirectory) into the u-boot build
+directory for the CST Code Signing Tool to locate them:
+
+- `crts/SRK_1_2_3_4_table.bin`
+- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
+- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
+- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
+- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
+- `keys/key_pass.txt`
+
+The paths to the SRK table and the certificates can be modified via changes to
+the nxp_imx8mcst device tree node, however the other files are required by the
+CST tools as well, and will be searched for in relation to them.
+
 Build of flash.bin target then produces a signed flash.bin automatically.
 
 1.4 Closing the device
-- 
2.42.0

