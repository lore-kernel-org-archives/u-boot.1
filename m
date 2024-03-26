Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99A6C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 08:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BEA87F65;
	Tue, 26 Mar 2024 09:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TQPX5AeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA2887F65; Tue, 26 Mar 2024 09:07:21 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF7A87FAC
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 09:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q87EjY008061;
 Tue, 26 Mar 2024 03:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711440434;
 bh=kCH3al5dwe1a9EbL6arsV2+t0/G+I9UiOAJ1d5L9rt0=;
 h=From:Date:Subject:To:CC;
 b=TQPX5AeMHAPSM94ZIwIF39Vqtviv/x//2RZGN7BCyMN8McSW0OyAMrGSFBUrtVXwh
 s6fsXNgYKxIddsCr9vOmd/m9RTjhJkn+xnPhyoLjT86TL1xHBDC/yQwiNg2rqFF4Dr
 3JVTUvsESL3b/oqHETnxTr0UeQjWI0O/OB2oyj98=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q87EnH001398
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Mar 2024 03:07:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 03:07:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 03:07:13 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q87AOk119764;
 Tue, 26 Mar 2024 03:07:11 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 26 Mar 2024 13:37:06 +0530
Subject: [PATCH] binman: ti-secure: Enable debug extension for combined
 boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-b4-upstream-jtag-debug-unlock-v1-1-720d8635a4f4@ti.com>
X-B4-Tracking: v=1; b=H4sIACqCAmYC/x3MSwqAIBAA0KvErBsokxZdJVqojTZ9LDQjiO6et
 Hyb90CkwBShKx4IdHHk3WfUZQFmUt4R8pgNohKyakSLWmI64hlIbTifyuFIOjlMft3Ngq01oqZ
 GSmM15OMIZPn+/3543w8J+eEsbwAAAA==
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711440430; l=1592;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=AbARQ3DR+qCIJZ1sd0Q5YhQLPyZQE2eu+IRir0gwl08=;
 b=1PV8+nkHLqjOn15eDeQZgJrxTK5VbgPAvfLnVpqijqxCN6JAJdHETwkWfRf26ydGwTzffrSvK
 WXISLN6su8/CDmCfNc0giwIKJbP3H25pYYnvbYEwFam91FU0Zo2LP0l
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

To debug using jtag, ROM needs to unlock jtag debugging on HS devices
and it does that looking at this debug extension.

Add the debug extension and enable it by default.

Link: https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/sec_cert_format.html?highlight=debug#sysfw-debug-ext
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Keeping this enabled by default as this is enabled for non-combined boot
as well by default.
---
 tools/binman/btool/openssl.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index fe81a1f51b1e..c6df64c5316d 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -283,6 +283,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
 basicConstraints = CA:true
 1.3.6.1.4.1.294.1.3=ASN1:SEQUENCE:swrv
 1.3.6.1.4.1.294.1.9=ASN1:SEQUENCE:ext_boot_info
+1.3.6.1.4.1.294.1.8=ASN1:SEQUENCE:debug
 
 [swrv]
 swrv=INTEGER:{sw_rev}
@@ -323,6 +324,12 @@ compSize = INTEGER:{imagesize_sysfw_data}
 shaType  = OID:{sha_type}
 shaValue = FORMAT:HEX,OCT:{hashval_sysfw_data}
 
+[ debug ]
+debugUID = FORMAT:HEX,OCT:0000000000000000000000000000000000000000000000000000000000000000
+debugType = INTEGER:4
+coreDbgEn = INTEGER:0
+coreDbgSecEn = INTEGER:0
+
 {sysfw_inner_cert_ext_boot_block}
 
 {dm_data_ext_boot_block}

---
base-commit: fb49d6c289d942ff7de309a5c5eaa37a7f4235db
change-id: 20240326-b4-upstream-jtag-debug-unlock-6fc21e344cfb

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

