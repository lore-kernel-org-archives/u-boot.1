Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2E2E7D24C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B387C86CBC;
	Tue, 26 Sep 2023 09:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PA+Wx0dD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2828786B4E; Tue, 26 Sep 2023 09:58:50 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BA086C1D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38Q7wjPt112988;
 Tue, 26 Sep 2023 02:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695715125;
 bh=rPF/gbNh275hs5hum5ZyB1KxO8Q/xltm6/aUUvzxqS4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=PA+Wx0dDuq3SO9UViNNpk0OteHF6OB2mtLTQifcLF9fJZCOgNqp0hydcbiw2Be0Bq
 SSSYqc9h0XXpA9rnwjlISbEs5e4FrfR0KAo3vXAfJmv1HUNTNTIMgDuuAzU0tyWpHp
 xqqAuTV66DzMg2dTbX0lqaMDbHP8KdkD+7hfeEWg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38Q7wj7e002745
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 02:58:45 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 02:58:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 02:58:45 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38Q7wauJ019632;
 Tue, 26 Sep 2023 02:58:41 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 26 Sep 2023 13:28:29 +0530
Subject: [RFC PATCH v2 1/8] dtoc: openssl: Add GetHexOctet method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230926-binman-firewalling-v2-1-b1a084ec634d@ti.com>
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
In-Reply-To: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695715116; l=1507;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=k+UylzefhZRtp1mJzE9erZQVQCvMXWr5xTuZtPQMEks=;
 b=zBfLF+Wp3o4/BOTvU78sD6vW1NseeGn12U8QBmRX0HcChGOIC+FDpUxCnAe4sqztkHC3SvTkc
 YoBgeePIfliAtAlu2aKGEqjZOPx9KVGjgZGzf+6TeOdcsM9DByc8y5+
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

HexOctet format is used by openssl for FORMAT:HEX,OCT property in x509
certificates. Add a helper function to extract the integer numbers in
HEX,OCT format to pass to openssl directly.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 tools/dtoc/fdt_util.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/dtoc/fdt_util.py b/tools/dtoc/fdt_util.py
index f1f70568cfef..d51dbf5633d0 100644
--- a/tools/dtoc/fdt_util.py
+++ b/tools/dtoc/fdt_util.py
@@ -100,6 +100,26 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
     command.run(dtc, *args, capture_stderr=capture_stderr)
     return dtb_output
 
+def GetHexOctet(node, propname, default=None):
+    """Get an integer from a property in hex octet form required by openssl
+
+    Args:
+        node: Node object to read from
+        propname: property name to read
+        default: Default value to use if the node/property do not exist
+
+    Returns:
+        Integer value read as a String in Hex Octet Form
+    """
+    prop = node.props.get(propname)
+    if not isinstance(prop.value, list) or len(prop.value) != 2:
+        value = GetInt(node, propname)
+    elif isinstance(prop.value, list) and len(prop.value) == 2:
+        value = GetInt64(node, propname)
+
+    hex_value = '%x' % (value)
+    return ('0' * (len(hex_value) & 1)) + hex_value
+
 def GetInt(node, propname, default=None):
     """Get an integer from a property
 

-- 
2.41.0

