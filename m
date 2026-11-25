Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C986606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MO0qidRH;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ApftrDR7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BB9140655;
	Wed, 25 Nov 2026 09:48:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HGt-FBIRyiYI; Wed, 25 Nov 2026 09:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B138C40653
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795600097;
	b=m7T3dpAr0dDxvkhqXQW3BBvI+XOfBEHtbwTKW9H5NR+6RGnPDwUJYEFQ9fo41gm5cKix
	 9OiSlpw2XOajLvEGvR1Imihz3c1w916i56cqGX3dsJte9FORUzSWUXjKU+cYYtOo4INtM
	 dX350S3Jgj5yRkwPKXyjAK/tJf9xYPzFTLykC00/Z9iLwjmZVMUyFlBLgfagtHWGdFyKz
	 s/fZgQyXHiK41H/0IANMU7dos2Zb4Q/35bl+mK91KT3RS7wsw0JoGvWjY3WB8I+NjEYn1
	 bUlSgpg84ZQD55Wvj6OM4irkZE9mh7m9yQMt0ktpW6QPFVwH71KbbdQiy8HmN+3yQIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795600097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zn7+WXqatWFPTS5knrckTx9Ev6QaYDigG3u35wpefXg=;
	b=bvtOW1iSoe0VIBeOJJhYOcBfYVlhDswLaTgCstnVP1dHUFWfQtYZzk1A28DGK/dczH7v
	 SIZZnuaDeUJQ7cTB5Vp0aAKw5W6dI/sDzI3CaYElRXPzq9fvVgvN/21XwwVVex8tQXsNI
	 Du2uxPfrhXc1U6txyQ7fCHkdhJNt1segb5q8XlhCWgoDNrXYmDsGHshj0gNI7inIaHkpe
	 gbsPL1WXiRkqLNi5Go6V4/8jZCM3gWFRGUs60/5Z8u4OpdhhQKrQvwOeWs28LigkStEhZ
	 LKyPIFplwRrAs51ilaQdQLMCfw6XWw6yBaSUiEZyhNccPXKowP2pA54btJLkBnLDYhQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795600097;
	bh=zn7+WXqatWFPTS5knrckTx9Ev6QaYDigG3u35wpefXg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MO0qidRHTCUfj0KbEVzt8QHLIuUM4VtdRNzJCi6ObHSs4JlIVAzxzx/2BkInckwpN
	 9NiL5A4MkUWuL9tSVLxAGwPpF3r19n78D7rz4I5LoNFV2ndIw1QeEUIFinh1Eyk4fg
	 r55cV5+EviNtbXpwWiMt1hhSG2nHEmFEx9hWmlD/1RCo8RcWnaVGGEBN6KRN2EDMHa
	 pqu/WJWMiJtBwpPQ5YfKy1OONTtD8ddBfVkG0JiE4M5szmSUITHjnn0ONO1NamfSxA
	 nFvOY4KbTdF/YpLNSWyrme7Yxnxw7AGcWCaVVcVR296v9VYZehyBAsaEqwM1rwM1bh
	 yw1ge4oqDG5Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B138C40653;
	Wed, 25 Nov 2026 09:48:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 44207311
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3631640199
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NoUVvxFMcTJs for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 09:48:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7D7B440180
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ApftrDR7
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D7B440180
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn7+WXqatWFPTS5knrckTx9Ev6QaYDigG3u35wpefXg=;
 b=ApftrDR73LzbXZkr1nsZayUPRMqj7hwwfU/ueODjf9sJAlkKzlEFfQhSaZFAE4MzTq6CZUim+m1mbtCSNWfMKEuC+0Pf8bt/AEenE+NXYEkmgxyEK8sVQwhI6rAp8StlVw7UV2RyTZLC1rJjhblZ9q2+TOOINoxWgTuT+tHtBas=
Received: from SJ2P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::15)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 09:48:06 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:5db:cafe::58) by SJ2P221CA0001.outlook.office365.com
 (2603:10b6:a03:5db::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 09:48:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 09:48:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 03:48:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 03:48:03 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 03:48:02 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>, T
 Karthik Reddy <t.karthik.reddy@xilinx.com>
Subject: [PATCH] spi: xilinx_spi: Fix TX bus width check
Date: Wed, 25 Nov 2026 15:17:22 +0530
Message-ID: <20261125094755.4156910-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7381352e-2dc7-46bd-cb17-08df4ad9344e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2dpyc7coiT3hIuCtl4dT1PfZf+V4FyMyjMkRyFAbkohvevG4l8k4bDMfBtrvLLwMEi25SDoY75XD1EeuwlCHwYsne3mzli2n8/entIjlVtVehIZxuGPrF7XwWJ+X5slm1ZlkwI5yCONr8aqdJJF8u6LdTQRokGwFEihT5eaosgHNtlACYWxblnJr/xIve4OFwDuSAy8CSPHWDgIaLpC2PE6CFtx1HVVKH+J4wGfHdvzOkYbDCNXLLb8EYrMehQf6+eiwSyk3RQ5DOeMSrRRedI2So9XLnIVSemCRmOgchybHb13luVLW9cm6XPNKCR9hSpHba0nic0pBYT0aeNx3paJGuA5iclTaCTbZEbdawuJDnDLRQBzw3JthrSOtU8a19aFgi1WlaRulOYULIAMw+TC1gjo7HinvkRrviUsOEGbeWSmdYRFg7mv6vjPks6wVhaz90RwtJKL4AWydcSqFfAisUCUJCMUbhvkO4Puzg+zhFRBnkXeS7+Ag4xBtQKtqyKKdpQXuvNtl5eGDPw/6tRT3yqIXwZmdHQuK7/Ymo6nzi/0cRYPBwRlaJJaw8y9Kz4y15IVhREaPUdUL8Vng9EsaBafOYF8u1B0qg1M4yBLaX0sLzIzRZ18/rMwAp7xC6yKXgbOnHY+oIPKasVLT9iX5D31aiNKuIkPjisLG1b7DLTKvWlszgzxeroXAKAg3tFk17StR5ybs5vbYmuBfbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UsP6v6nIz/L3mlIzv5FqwbfWVbUuHNkzcpoVHTLLIcmA4IIlMXxKi6zHq2byUTlg+2u4Hky0cgHrJqoBnb0UI5N+ddB1hPRbL2rTxv1NbiBQyo9h48jZC5fh4vDG+vyKyQKi2ceGTJ0kvuDwjSABEvQF6GkVUX7o+ceJbJPk/DgHKqzOznr3YCOf4cS9wwVGUDy4JkKFD5EExOWEFfIVfFWzKoenw7G6TB5sY6y2bvTa45fC3v/KsY2pA1UYnTfe43zFSI3vYIdYih+yDsTyZzY4I/5EUnuzKpx9GSBFXYI+ZTisKowzQRUbrxtrUCZ5yPsHlcFost4+Xt9u0UPqTps9UCCArhZdWdpEWPgyrXfJ3DdfJiJFN67nWwXvnb9aDUVMOC9EbcVImONFoYAPrbZfnhsvSgkYVHqNofmLPGKuccQerYd/FciZJOt0QJWM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:48:05.4583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7381352e-2dc7-46bd-cb17-08df4ad9344e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xilinx_qspi_check_buswidth() checks only the RX bus width for all
phases, so spi-tx-bus-width is ignored. With spi-tx-bus-width = <1>
and spi-rx-bus-width = <4>, operations that send the address or data
on four lines are still accepted.

Check the command, address and data out phases against the TX bus
width, and the data in phase against the RX bus width. Keep checking
the dummy phase against the RX bus width, as it carries no data.

Fixes: 557832bd8835 ("spi: xilinx_spi: Add support ops to axi qspi driver")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/xilinx_spi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 011bbc93076..579bc09a53e 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -396,7 +396,8 @@ done:
 	return ret;
 }
 
-static int xilinx_qspi_check_buswidth(struct spi_slave *slave, u8 width)
+static int xilinx_qspi_check_buswidth(struct spi_slave *slave, u8 width,
+				      bool tx)
 {
 	u32 mode = slave->mode;
 
@@ -404,11 +405,11 @@ static int xilinx_qspi_check_buswidth(struct spi_slave *slave, u8 width)
 	case 1:
 		return 0;
 	case 2:
-		if (mode & SPI_RX_DUAL)
+		if (mode & (tx ? SPI_TX_DUAL : SPI_RX_DUAL))
 			return 0;
 		break;
 	case 4:
-		if (mode & SPI_RX_QUAD)
+		if (mode & (tx ? SPI_TX_QUAD : SPI_RX_QUAD))
 			return 0;
 		break;
 	}
@@ -419,19 +420,24 @@ static int xilinx_qspi_check_buswidth(struct spi_slave *slave, u8 width)
 static bool xilinx_qspi_mem_exec_op(struct spi_slave *slave,
 				    const struct spi_mem_op *op)
 {
-	if (xilinx_qspi_check_buswidth(slave, op->cmd.buswidth))
+	if (xilinx_qspi_check_buswidth(slave, op->cmd.buswidth, true))
 		return false;
 
 	if (op->addr.nbytes &&
-	    xilinx_qspi_check_buswidth(slave, op->addr.buswidth))
+	    xilinx_qspi_check_buswidth(slave, op->addr.buswidth, true))
 		return false;
 
+	/*
+	 * Dummy cycles carry no data, so a multi-line dummy phase only
+	 * needs the lines to be usable, which the RX width guarantees.
+	 */
 	if (op->dummy.nbytes &&
-	    xilinx_qspi_check_buswidth(slave, op->dummy.buswidth))
+	    xilinx_qspi_check_buswidth(slave, op->dummy.buswidth, false))
 		return false;
 
 	if (op->data.dir != SPI_MEM_NO_DATA &&
-	    xilinx_qspi_check_buswidth(slave, op->data.buswidth))
+	    xilinx_qspi_check_buswidth(slave, op->data.buswidth,
+				       op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
 
 	return true;
-- 
2.34.1

