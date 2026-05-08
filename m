Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0437CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA9784C9C;
	Fri,  8 May 2026 14:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TVOfKFzX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ygFSwWfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F8D84C90; Fri,  8 May 2026 14:21:52 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB8783DBF
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBpC23DByz9v6D;
 Fri,  8 May 2026 14:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9sh5q41WmJ82qaPR8z66G/sen5CU52wBzVRZFPuHOTA=;
 b=TVOfKFzXn+vCcImzjgCQkCxSlz7U+gI7CXPiPYc4RwRVp1XK63o4p8K/tH4Y5wiFcT5AaY
 KBtUw4yYqDA9ksO9RYoIqd7ddMCMsrh0hbE4VnMWYd0VCNR85EBtPPDeZjZ0/fA1Uxi4D6
 1w2KJ+zCotsGwCsD7PwSk5V5LtJPBcK4B4zpkhX9YGSQkeAROeswatWJ4gAK1WhHfLvaQM
 +saC0GaJ0+n2R0r3Rcpro6kQ5Lq1PUWyWmvBnNpBhNOr2UyBoOUVRD9RfBKeLXrZBBj4+h
 TTaCqRk5U368cPDlNA7UeDKoIrQ/oCcqA4H+EuOHFUKwG2cdcWQ8iSLfhO/AXQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ygFSwWfU;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9sh5q41WmJ82qaPR8z66G/sen5CU52wBzVRZFPuHOTA=;
 b=ygFSwWfUc7gVgQue+MEFixtacDXP+O/z48XfjQEhUjQ0vBp2ebWiO6V2pP351rbFjqZF8G
 dWjjyd/V9D49tvycCJqGtPnzCZfobVypRXlOyj8HsdicQcT1THISfMKz4ZbyC4PQCAfRCL
 u0wwHuBIG8hqPH6l/GBn1mJ4AkaltWTcoe+TCQPzznbpuLW5LcuofQpRURa/DW2niA4eYy
 JbLtqC9bL5QXI1pPrNEObaFV4f5R24sjtW4h7mifZ58/C7DFcP/1AqMUUssIToWvrA+LQk
 Rabm57rO4eqj7OU6r19QNpmdmRWzg8KItPbybMZzygaIiqdmjzaQpxr3Y39BHA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, u-boot-qcom@groups.io
Subject: [PATCH] pci: pcie_dw_qcom: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:21:37 +0200
Message-ID: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 50170e9c0974c4996a5
X-MBO-RS-META: 85u5mzrosizio8o9o9hajptmmyeon3h3
X-Rspamd-Queue-Id: 4gBpC23DByz9v6D
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/pci/pcie_dw_qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index 10c45aaba20..ce6b4d97d1d 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -22,7 +22,7 @@
 
 struct qcom_pcie;
 
-struct qcom_pcie_ops {
+static const struct qcom_pcie_ops {
 	int (*config_sid)(struct qcom_pcie *priv);
 };
 
-- 
2.53.0

