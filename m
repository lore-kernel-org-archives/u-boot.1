Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DA3C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 08:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AD78825A;
	Thu, 16 May 2024 10:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715848593;
	bh=EBfvndYPO4zl31rp48E2KdT56YLxTGPbpjWUOJ806nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=udiV2McoAockhwFxP83o31yDfC9Ya4jCyOakZc3/k0OZzPXu88l2yRN1XPIN4fWYK
	 WW6bIq7vVENKf2Z7DU5qwrU+V57llVkBtdkaTZP1z4Q8upUSwaNc8Ai3RV10YerXNr
	 NcRkyBydh2JWOPaDnQq9XfL2zeqrdxOnc6pkjXheBno8BNt394BDTzOKDDF/QwE6vT
	 Lui1SaFeFO/0Yazn0x57cS3Cok4fvXfOEdQA3f8IOg4sd70rbSdOiIvcp7eqggE5z4
	 Ohyn8N2mQCN1sYZ75BoGWlm/PIRDkasiLLHMYzEOeYpR7z293+srzwQHcATbELDzpb
	 lkZeEmD0NpqDw==
Received: from localhost (dslb-088-077-007-084.088.077.pools.vodafone-ip.de
 [88.77.7.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ECE2A8812B;
 Thu, 16 May 2024 10:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715848592;
 bh=EBfvndYPO4zl31rp48E2KdT56YLxTGPbpjWUOJ806nQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b1YHg/Lf4eRduNH0ATpWaz3zruMDBuLN2j/h0ckT9qrpGAwHERhTqz7yqH06yzAJG
 GjGW2GWTSzFUmiHUATykxwBzD093RsQHsGgqhlM8o+BAFLmHULD6L/N4WBxPiCR9fd
 w2WZHs311YO8blDSSHvk/GoCT30aVta3CPBRMemekJYreS37BB4ardRC83C9sJv6Fp
 gTLjQHD8Vxo8bUH+BjiMoUBMJF2g0j9hloD3o633K6VLgnw8mDN/gbERW3cglK2y0l
 d+9/+bQdE9BCBm5HySiDbfgyoVTeyF4ZBuqb3DV8lAtBsTZnD5kvC2joblonH/45Hy
 wekfdKmcP/nWg==
From: Claudius Heine <ch@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: Claudius Heine <ch@denx.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2] imx: hab: add documentation about the required keys/certs
Date: Thu, 16 May 2024 10:36:14 +0200
Message-ID: <20240516083614.510948-1-ch@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240507130650.713801-1-ch@denx.de>
References: <20240507130650.713801-1-ch@denx.de>
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
Hi,

this patch documents some changes of the
'<20240503010518.263458-1-marex@denx.de>' patchset. So am posting it as
a reply to my earlier patch in that thread.

Changed from v1:
 - added 'symbolic link' option for making keys/certs available in build
 - `node` -> `node(s)`

---
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
index ce1de659d8..75089fba4d 100644
--- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
+++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
@@ -144,6 +144,23 @@ The signing is activated by wrapping SPL and fitImage sections into nxp-imx8mcst
 etype, which is done automatically in arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
 in case CONFIG_IMX_HAB Kconfig symbol is enabled.
 
+Per default the HAB keys and certificates need to be located in the build
+directory, this means creating a symbolic link or copying the following files
+from the HAB keys directory flat (e.g. removing the `keys` and `cert`
+subdirectory) into the u-boot build directory for the CST Code Signing Tool to
+locate them:
+
+- `crts/SRK_1_2_3_4_table.bin`
+- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
+- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
+- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
+- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
+- `keys/key_pass.txt`
+
+The paths to the SRK table and the certificates can be modified via changes to
+the nxp_imx8mcst device tree node(s), however the other files are required by
+the CST tools as well, and will be searched for in relation to them.
+
 Build of flash.bin target then produces a signed flash.bin automatically.
 
 1.4 Closing the device
-- 
2.42.0

