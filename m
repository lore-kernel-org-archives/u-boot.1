Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fF9UiIq2;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=nVFaJQg0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A3406078D;
	Mon, 23 Nov 2026 14:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwqpK7CDzJbX; Mon, 23 Nov 2026 14:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B08F460782
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442687;
	b=DcJAQeFBKsFAk7tlSl5WjPUyqlV4sBxtnQUKJWsdDuePIbarBqMPMjUKyQSDmYBiN+uw
	 S/RuZCTpJUauEEDAxqsVg4UL9UUgO6FvRw8VM8ADU5MQEhjo7s9P4LnlvXzEvvpkPsJhZ
	 WPoDLF+vJmHI92HcTif0hpHOFOV79Ess570REl3XnYnXlDUR7rBeQ57LdiGN2xPV2YVvG
	 pdvNVcDeGYmTMDPzUw4uvbAmb2rfMtJmnzh7R4bRyZT3xvp1Z6mcvcJlFYuibCdODNphG
	 H9OaWHVqjHdZBR3QuHelyI1Z7q1rvW6gpT4n0MHIcr9jjWxyTEmofuTZ79ouMCHdT5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SvZEBkOlioBngW7+G+7dYmUuemS3K2Z+6SrVqtYkTxw=;
	b=VO8WNNSMPLajTTUVE65Y4U42XywywRA8+1I5wQ5QKhIL4Il1kVwXxHwMq4UBU71p4FZp
	 4s/OxqqZdobx6bafzzG5Wyj6xXC/v0/hhjY77vDl1eMgRkS462n+0B6P/Mdi2FIJLRS91
	 o9N5w5zYfr0t9ce7Bt/VAoZEDzNCLV9YPq+yjtMS9YH9tNe5hcCgA6Jek9mBPdfdBXmAN
	 ySwV4e2WCXp3so1DuYqvLoZinhpukPNbacNK4Kh5cyuH2LOufFrBxFhENNiWZnpAq1aXR
	 6y8nfHpHi4YXrveJ1uQItOVyFjxawNBhEZsd/qutSo1nl8mIBsDMOv+HjWzs3X8ming==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795442686;
	bh=SvZEBkOlioBngW7+G+7dYmUuemS3K2Z+6SrVqtYkTxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fF9UiIq2m5ask0Uo3eFcgcZ4+HEnXK2PtYDVNkOZryGmtySf/sfIL2/LPxCw5ftbX
	 jjuNmov8TrG+4WgQiIOrj647kTXDENXq8f40IpJ8umzN/wYvBmvDeAs8JU2sBsig05
	 z0F0igih+iV85xIT0fCiaxl4Ok3CmUA/H6Z6M4G8aeGMpZs/obj8seBlo70NQr4ajv
	 Jh5mWRgL2xSydtjTWQ/o74at3FDI8NSymmEpopCnVS7sT+Rzi85BgjOnKWPQNWDCMH
	 sD5SuP03pUMCHwb7shSc0gHLKiXUXtFt26bGPOSBspKZ4omhR5bqauUByGyyIFBqg2
	 8h5FScnBXi7JA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B08F460782;
	Mon, 23 Nov 2026 14:04:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B52C5759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B8A54022A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PsP1hjgqNm8A for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6BC6B400BD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=46.19.12.180
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.19.12.180;
 helo=cp2.siel.si; envelope-from=primoz.fiser@norik.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256
 header.s=default header.b=nVFaJQg0
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BC6B400BD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SvZEBkOlioBngW7+G+7dYmUuemS3K2Z+6SrVqtYkTxw=; b=nVFaJQg08RFj1m/amag9aPYQQD
 UzSsImnJsbu9vKxsHiBfRx2YkNKCA5p3uFH7y+i+TNawBqexY7MTO329lqGqSLuwQLOZD0g/h5kBJ
 Spgz6J7WMAk5bOWZpELBNPYJL0smLAeJ//wEepILRoAc28mZAZSPLFPwgHf4QTnhGZ7Rjkk6ZIpAR
 xYyIhf3TTpRBBarOygd0G/Do3cBDRKMYAkh9cYYbR8MAvIfp7tTSc7cFeMIoii8Qrli4wdtfVPwrw
 UlBarvpUZZGPL57TClyrYZKEk5r2sdyNSE0VMY4L7Ymq5mKaJe2AHP1NoOQiZoeyjdaVGZ0jFZor8
 HA8dqoRg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:59646
 helo=z840.taila37813.ts.net)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <primoz.fiser@norik.com>)
 id 1xVUet-0000000H57M-1Fwi; Mon, 23 Nov 2026 15:04:37 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH 2/3] configs: phycore-imx8mm, tauri-l: Enable mmc reg command
Date: Mon, 23 Nov 2026 15:04:36 +0100
Message-Id: <20261123140437.1526666-3-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123140437.1526666-1-primoz.fiser@norik.com>
References: <20261123140437.1526666-1-primoz.fiser@norik.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Enable CONFIG_CMD_MMC_REG to allow reading eMMC card registers, e.g.
"mmc reg read extcsd 212" for EXT_CSD SEC_COUNT as required by the
PHYTEC automated testing.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 1 +
 configs/phycore-imx8mm_defconfig         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index e4674eabdce6..3bff958a00c0 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -56,6 +56,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MMC_REG=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index a9858f5e2291..39672b3fc211 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -64,6 +64,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MMC_REG=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
-- 
2.34.1

