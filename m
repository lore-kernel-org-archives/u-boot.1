Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6B606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=glLZXvBM;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=RNVkiVdA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2666E81AEA;
	Sat, 14 Nov 2026 02:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8gYGaN1feWc; Sat, 14 Nov 2026 02:04:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 568D681AC1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794621884;
	b=Ctmr8TNKotgMR5Xsgp9FC55/fWJoYC8XtY4WZyN6XJ7rcxMDJ9m+9T8XYAquKAlzmBPO
	 3wJaH6K9YEE/a8vgwjLYUav87LL1nIFxJAvNssMFA2ZmYFJhfuZPecJCUGQ+/C0EvYOLR
	 S44wpCBX3+lYR6Pahh+7s/YccFAbQCPe+TNw3fsL5II3blQB6azHSKt8jMQLp9tbTgcA1
	 l08/xdZaY78MP/DeKIVZfUpdbwHGXmhm0W0GOdiPXBMAH6+eiCFJJcj+LFcxdTOTafJsP
	 BbBYtqIKa5V3D+XzJsiSxp1jO4AAraM7YXkHQ/mWkH1kXcYFp68ydAPCp5wLPBMhkMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794621884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=oPdq2wPTGoJO/9C+iBCr9LBt+4/c0BnggRxIcYTxVO4=;
	b=sil4Ic8KRZt4e4CIVSBkbXzGg/28R17MdlRNMA9dWn/H3kUghutIvxyDqRkxxY/n8SpS
	 kbh3tS5iRowNZV1yaXqPIbC95gba1LNR6Qs98OkFK1xPWOcmueZg0AsCTOxjzpKrGtSUD
	 mOiag22D9UxpaijaYE0G3Tb5S0jZlPCBWVfAXK74DxVucCzb8KjWkmaVjASar6/IY5d65
	 GSSH3//Lt5hRAFnpYvrQDCWjLqiw7QRG0IFEbyagwtdhdkuQ3WGd/SzTEVFwXHvU+WAPW
	 bxifH6SvBlio0ZKiPN38MvHM56lojG09c7HKTfS4g84t3N5+ynTTb8MgykTuw3BO8yw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794621884;
	bh=oPdq2wPTGoJO/9C+iBCr9LBt+4/c0BnggRxIcYTxVO4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glLZXvBMF2WwR3Aa4EyYUELXH9Ps7Ph2wnyWeV8uFERmmv3B4/3d7nLnbnYhT+1LY
	 R50yGpHQPXeLb5CYnfluTxNL5+LjaK1aI6JcrCnTmsPDSdDaQDIj8myUvTN3d+bZXx
	 md5usIbe1om55qHpFGe43oxcmQwhj3R8MMDhBIWkfXQmwvQZKcJZMp02LOXMz/2AuH
	 NHRyh1cL2UrM4oAi8m5hMRxBho/Uw2Z7WIjhjFfblZjdCGJshORT+X13ETCj5nLBel
	 jKCwiKbSMMOlmHpl3CNPoHuByEusqZZeyAkrVH+VYSfd/fUAFEt05ChrsmBRd1gGQ8
	 PbNaTMjLxAt/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 568D681AC1;
	Sat, 14 Nov 2026 02:04:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AEE71E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CE126077C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvDEEGm2aogv for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:04:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44A896071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=d.haller@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=RNVkiVdA
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44A896071D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPdq2wPTGoJO/9C+iBCr9LBt+4/c0BnggRxIcYTxVO4=;
 b=RNVkiVdA1B00Qwg+xjkQFd5DLI3tUH+WD/IKp4sC64U/QWSjTsD51S3E8EOlL1OgHl9vswPn2AosSHpqJ9dEAQ/voOC8LxmHNupWMrlf5vn7LxT41fRKqWnS+11UJrDRigU/65+dE5feQKoQGwwU5PaCFmCockqztT04QlQRT+DNgal3cJkgh2sppEDIXD5CcMlSd79pkFgKnAunaaQ5RGwJSQU75bCV2Z1YtcDc7XEDR8/WzyZPK/MnEdlo3fWkeNw5/GmibbFoRxg3HS6zbLcsnxu65ygD9WNvO5JfqRD44CAMk3zUDn+UB46a7iyhj1XrGZNzVYlnDTtCQ1Jpyw==
Received: from AS4P195CA0038.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::21)
 by PRAP195MB1579.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:298::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 02:04:34 +0000
Received: from AMS1EPF00000098.eurprd02.prod.outlook.com
 (2603:10a6:20b:65a:cafe::34) by AS4P195CA0038.outlook.office365.com
 (2603:10a6:20b:65a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sat,
 14 Nov 2026 02:04:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 AMS1EPF00000098.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 02:04:34 +0000
Received: from lws-haller-privat.attlocal.net (172.25.39.212) by
 Postix.phytec.de (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 14 Nov
 2026 03:04:32 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>
CC: Dominik Haller <d.haller@phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH 2/2] board: phytec: phycore_am64x: Limit RAM_SIZE_FIX
Date: Fri, 13 Nov 2026 18:03:58 -0800
Message-ID: <20261114020400.131274-2-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114020400.131274-1-d.haller@phytec.de>
References: <20261114020400.131274-1-d.haller@phytec.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000098:EE_|PRAP195MB1579:EE_
X-MS-Office365-Filtering-Correlation-Id: cf625173-6d25-4b8a-e55f-08df41f3a0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|261021121427099003|261026121527099003|261009223027099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NtghrpSlPKIxWKy9wy8PRLXamfKD04wlC9paBP7Qaa5zN/yIX4zXaaZOrCuwV1fZQuwL1GoMLdltfcgPHbyqmWingLFzidNsmVizR8QCpqwwjFH3juRMvwgeRP3eDjdXB0QerpcHVCWMiuhbsdKOIbeA7ihOG2pe8WIKbpb3wNk+c6p7kWB41Y827Zce2ZmbSqGpPAHWwWqOAgjPxk7tTz7wAUabDGbNFqdPW6pIyn/Mw+yhpEu/T7IxTVCY/JC2JQSqHl1y0yPtNTZx6/6Tw8+SY4ssCF+VCoJS+eB413oIB31LI2KyKxzGm0uNjMWC4Wrg1TanU3lynUoJtaRd7RCNuUNuTqN8/8TuP3QUKgjgY3lHbJPxOjo/PBm5kiM86rODJv0SAsmvy6UrSzIzgmGFMdx0JMqPvIiABT9xIfGJf/tc1QQ9PDOJHjtLwKP1ZKHACqghpgvVv9KT+OjXMv9WZNIM0MPC7C2Osnb+C/hhUejDxRBy4TqAQrjZIoBA6YDTG17Pdk5AY6PnRlBY0oeQCRnAerVfhf6rwVeCHjg1KKnTy4plwzyN7pYlUyxAopPaSCyO/E1uXJTfyu4UvIdn0KPClP9s412L14XqvgkbwdLc9ye3r984odxvvQaDscrcETaRmQGfpMkFFwh2u8n0J7QHKC/Zdu5pGbvVsMEBDvtQP7cM4n6K9d7mApmplRwpbDdocQUlj4CusSMrWw==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +0BqRL+/vihaDuOrPZEDXQ1mJicWA+m4lD1NKm3juDJSoNVbY1kCHCFvem+RDYX23EKBKGh1+nxqaLMF+23CE58aO9zMOVAgMTPaj+QfqxDaIQL6vWPYFrLyhs7Um+Hw5xMJ1utT+eGuUr5XrGOfKUc+SwQlqG1yqRepU6ZfZ9i57uNx5TrWM7KM5pa2+rEv9H9f036+8J2sG55bE+Q9YcBT7x0M9kI6QvHZIaagrlbRpWoFiBITqlkAVcZLSDAe2Mnaw1rIcFD3BfyWDBWtvsoHkhZ8wah+2BZGXZgTVBJBpv4UOYBiETJNWzBWJ/fhvIYSMFPqjBvqCHjn8xBcaPORGBw4T631EPFVPVlPuKan9XzpEvv8S78i/E5sHiP4zATrPdt0SW+e9wiuAOo6BqVOsWM5BFJ1pU6gPqdCWFbDlOCdddbAn2/rchV58NMk
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 02:04:34.2940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf625173-6d25-4b8a-e55f-08df41f3a0f7
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000098.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1579
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add guard for PHYCORE_AM64X_RAM_SIZE_FIX to hide it from all the other AM64
configs.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 board/phytec/phycore_am64x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
index a4d25b84b96c..c396f116aa0b 100644
--- a/board/phytec/phycore_am64x/Kconfig
+++ b/board/phytec/phycore_am64x/Kconfig
@@ -38,6 +38,7 @@ endif
 
 config PHYCORE_AM64X_RAM_SIZE_FIX
 	bool "Set phyCORE-AM64x RAM size fix instead of detecting"
+	depends on TARGET_PHYCORE_AM64X_R5
 	default false
 	help
 	  RAM size is automatic being detected with the help of
-- 
2.43.0

