Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D2606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T/2CEhfC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5D208102D;
	Tue, 20 Oct 2026 05:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KvO9EDMi4oiX; Tue, 20 Oct 2026 05:49:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2976380DEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792475355;
	b=R970HcADwokrOWla8u0ufP2L6uTHTp4CVNUh3H9h9o1O6EyVCaUJBRfldv3SeXbPAtwU
	 2ZVIvd5u73PvT2/cGusmuoOlqIKu7VprTtz7xVOkd8eRUigiJjIbc2AwCQ2feONkFNxHI
	 4jMMsY7BUzzHuhIRJCXJP23f4HCL0rOS/CWWHiGfTIpYUsR1HMSYjJMiSjxQt8XDKBLcq
	 K63P+SiEXmoo4JKJfjBBRwKPDOr0kGS4UcENIIo1JDTgmLVbZPS9IROEVTFNlT+oOfTde
	 jeU1IfGI8RL3ZhpkuAQd2n3jasheLmq9oGj8IH9fl18+MUMgbNzF9du1wiz2s3y07Aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792475355;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=34bRKFBlYFkTbx/+2kh05epm5lW0w6WUZv8fWgif8sY=;
	b=RLgvgkJd2TmXR8QVgHNHe9d71z+yKNcWHFH0kAJwTxTGIM33T+JS58K7qH2/ETdZ6TTs
	 gg2LK3i0EgD83tS/wUe8lW8fhw8QzjmdpajTXsDo/mZJPTkDcigEVC2Mh3Sx29NB0UZ60
	 4+mNzqbjEyXYDMhM1DYvldYRh7DEUzJfAKWBxca3+kXKg60B/WPMIgodrhMYy8Qgde5F9
	 YzIybeVizKYOYRzAh/Ivvp2/8mlN1C0iH3GUrBzkXEjSsfpVnECsvloDBk6sjFsOHoiil
	 CkuZ0hCt8k3kryZ+eY5iuSa7WMxBQER4cXlvzJ/imegwkWfNoS5DDEz6SV7SsvFT/gA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nxp.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792475355;
	bh=34bRKFBlYFkTbx/+2kh05epm5lW0w6WUZv8fWgif8sY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T/2CEhfC6lLTb/eyo9DouzqrJARVISwHfuVs9ow6vAkzYtARuY9dtJ9Mlbjz9ZWuD
	 jo8Kjhe0mIbkXXeIY/dKMEK3GtcnPtaiczTSLG1hA2CYasWBDPsKjIxPFa5f/EAFnL
	 PzXBqw7z1FqnySl8QxU8lZ5IWqxDDzAAuZ4t82pFEDQ/5t3b6boiN8i7c2VHqAPo0w
	 sRblsIZwXRGgQEKz48shXHLg82pjkIQ3Q9lQXkJxDcErd4T3Oqc9Wewr4cqqMfJIgE
	 dXMHcgZnh12umaIDrvJC4yaPYtLDy8DdXALuOiYZkAc3HhxFWMiJR+jMo6DQ91OZtB
	 XhzC5zkQOGs0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2976380DEC;
	Tue, 20 Oct 2026 05:49:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9484E23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B37781045
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id naFw6gLsJXvz for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F7608101D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792475080;
 b=At2HHKbH9kBvMpvjv9BuuTKmBgtRZPooSi/PfsmGDQYSgizo1XYqtYPINNScma6IbH0Q
 vqmDUjIe+pDwX2+blc6wBCiCMzDiR4u80+MQW7nRJqr546A08vy9ngubWjAjQMepU/HRL
 JPR+es74e9VqGcwhJ7IWhT2ea56gL7JT7zxXwLdUbj7SJkWfDuLvlLBCrSE88UBTVY71M
 bvM+hfvlyrIw0azJrwb82IORt6rywOwos9pk/Oqrd6R/4+JAbef0pGxsrkK8qCcrM7CVq
 vf8WD5ELhm/9133GSb2grgqrm5bLocfStQTiw1pInw7Cqi1nfSOUKQ+gABNzBXAW5SA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792475080;
 h=Received-SPF:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Virus-Scanned;
 bh=34bRKFBlYFkTbx/+2kh05epm5lW0w6WUZv8fWgif8sY=;
 b=G5nGzGsTsnsjvLsrUbDZNppMAgKBUE82r+nNKRI7DmJJnECCbO3gBs2vnUsuMxs1B24j
 0h7+2KoM9kYnDLaHDPoxfYu9DI6wQ7L/tGQszjB+lcXJwuzQXvugVFE39ZQa4EI7QyrvZ
 I8/4IO/yV1EqZnjes6V2T0BWih56w4s3zEEiaV4qJYboj9aKvf4BLxmNiHyqkVCLM1+gL
 7r/SV+4e2d5LjVgrgqeB8bavLbnnTQhEEFeaS70Yl4XC1uHJlCfJM0Yj6BibIgq1YZwxM
 oFIZLr4rRSducwJ18Iu0U/RNNKTkDmCAHDv56pUvaePNQnWsVi9k0Eki1jj2posfMFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 arc=none smtp.remote-ip=92.121.34.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.13;
 helo=inva020.nxp.com; envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F7608101D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:39 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C71D21A0076;
 Tue, 20 Oct 2026 07:34:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 90F151A007B;
 Tue, 20 Oct 2026 07:34:38 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 68E32180006C;
 Tue, 20 Oct 2026 13:34:36 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Tue, 20 Oct 2026 12:25:09 +0900
Subject: [PATCH v2 2/4] imx95: Remove container.cfg and imximage.cfg
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-frdm-imx95-pro-v2-2-09b188f16738@nxp.com>
References: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
In-Reply-To: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792474473; l=2208;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=u1QHOwcbpInvTCjT7VAyrwbHcN27DGDQExH77IvFg1M=;
 b=DYFQqvT/YqpvXNxj2kilS0KhBZkanyHwqx/q69B8YrHBu1u3gtJkJByskPS6X1Z5T3McSrM59
 V5vIdqHnnSiD9PUuIOQqxGU0pF7J2TNPI4Q+/mY9fBBsOfmXcmd0foo
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 20 Oct 2026 05:49:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove both config since these properties are already deleted
and replaced by adding their content to properties of node
which type is nxp-imx9image under binman mode.

Fixes: b3bbbf5fee21 ("imx95_evk: Restore support for i.MX95 A0 silicon")

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
 configs/imx95_15x15_evk_defconfig  | 2 --
 configs/imx95_15x15_frdm_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index 82d4aae56bb54c84f9bcce1e2b61133d17dfbbd1..c07160715bc05faca7a7b6367c484ae3939eb7da 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -11,7 +11,6 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
-CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-15x15-evk"
 CONFIG_TARGET_IMX95_15X15_EVK=y
@@ -45,7 +44,6 @@ CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
diff --git a/configs/imx95_15x15_frdm_defconfig b/configs/imx95_15x15_frdm_defconfig
index 3b631b8ba22f76ec71cb49ba0fdae6631b39fd02..803db9adff7c49a52879421cfb516ebb92b9bc9a 100644
--- a/configs/imx95_15x15_frdm_defconfig
+++ b/configs/imx95_15x15_frdm_defconfig
@@ -10,7 +10,6 @@ CONFIG_ENV_SOURCE_FILE="imx95_frdm"
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
-CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-15x15-frdm"
 CONFIG_TARGET_IMX95_15X15_FRDM=y
@@ -44,7 +43,6 @@ CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000

-- 
2.34.1

