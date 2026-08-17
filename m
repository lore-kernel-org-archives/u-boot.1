Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3F9C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3EC940720;
	Mon, 17 Aug 2026 15:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEOIdRW-gzkB; Mon, 17 Aug 2026 15:36:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C52C74061E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980996;
	bh=t00zWPnxrQj+nDHcLMorMyW+jdlZyd5DGTcHeQ/0icM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u24xVkuDyNexG0EWaRn8Mcxhmi1yyfS7eOZD08+bp0RHwLmAZwdMPXBjWNIlEqXRd
	 2ckgYkwfEzBEpK7xXSzLekXRV/Rylvd8KLMNNGBpaVHC3XJa2unZI5gW8/odGxTODq
	 9PaMLIbQLGaBCqAQYeEG/R4EIGXNwOau1ZD9x8z6GWS8Wo1soDJAEO7WKj0Ib5ppku
	 9kRDWBOhX9hYJdcyIljRet+kIHI1vL/Z5eO5ZGiJPiUIgpxxYe6pphXHLmVnwGRZso
	 fTYhPjkZDYHsPIvfJa7YmvI30oKvlOaGx50jWMgIVuT1M1zRNVC7XEUIwU1nfkeFV/
	 fKzJImBTMt6NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C52C74061E;
	Mon, 17 Aug 2026 15:36:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AAE2194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B01B401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KuhV7ipwE2VR for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:36:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 830D2401E3
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 830D2401E3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=B51qofp+
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 830D2401E3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 86059B0057C;
 Mon, 17 Aug 2026 17:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980985;
 bh=Q1qRLpfh/s6ngkUF3fjOLViVqtuS5ApD8Bhgu+ZL1uw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B51qofp+MPEjKc7+HeEi7UxxwyCNSKIxu/mQMLZVIds8Z4vZs8OVgkjVhPAmKducA
 7NrMu8k9mEc5MmjYqqPZngaQCrAR0rEk/9b3IeGszYi7NOwO/BiCP8nsl5AjrppIEj
 o7oRpzFfSZe61n4XIwBcR1JtN2wVcI6YeORqqizB1Cbmu0hkd8d8Fe0iRFqntPEabl
 j7w0iu5KpPu0Cep4aosFN5XayiEu7UX2ZtlDJJslUg3FvtBqAsijvqPWtX+hROEFCJ
 i0BVNEeCc5i37sF7vduv34/2KpXmD2+FBdHt3KNmFgM5A1yCqTUO5FYNh6cmlkcNzz
 yW5ivZ23SUqeA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 15/23] board: nbxv3: enable both USB host controllers
Date: Mon, 17 Aug 2026 17:31:33 +0200
Message-ID: <20260817153144.1951036-16-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the two USB host controllers on the LX2160A.

The dts nodes are already enabled by default in fsl-lx2160a.dtsi.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 configs/nbxv3_tfa_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index e87373a52c3..7043c5c0df6 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -36,6 +36,7 @@ CONFIG_CMD_HISTORY=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -60,6 +61,10 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_DM_SERIAL=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_NXP_FSPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_MAX_CONTROLLER_COUNT=2
 CONFIG_WDT=y
 CONFIG_WDT_SBSA=y
 CONFIG_ZSTD=y
-- 
2.43.0

