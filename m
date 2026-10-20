Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7B606A323
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g24wmL55;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uhzsCiXo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDF8D40860;
	Tue, 20 Oct 2026 13:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-0uUcAgdQgO; Tue, 20 Oct 2026 13:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00BA24083E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504275;
	b=aMQSuOJHNTpcYF8efSkTJz9/AikoJbx2fwmUEEmNdQJCcrJD7Dzf5xMGTHXHEzcEGhWV
	 CQ7X4PxyLkF1wNgIiflGOGBKPOYfaTckkHQtD+QvDCcPwTSlhePGxfxPMdLkWtQiXp78C
	 MTw7MGWg4d+3lO74Y0YhyjFDhtEAWWAAzrGbxtiHegtRGUDMypCvmfl1btomvRiHBz7Io
	 1w3yCJqqxP1Li2EG21kWDGv1Bi0GV5QceNq1YNF9qB+m3zxFGZVi84ZAIxWbbwfPu+N2/
	 jK8ezLbh02W5lEAu6ZzC4pfp0z1PFcSqE3CTPdAXH9DftaxbDl0LIvPC5h/4URSe8Jw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=YawDLAF2tBBwYKCLeaeUHgCi1xvtCY/EH1vlctxP5Wg=;
	b=sPd55obLOVoFTnCiVqiGnS5+JIUeBJSTTFK289GgTA40hewrc39wR/2eW1jIHnugJZh3
	 a78IU8+mXiGI1L6aSZ4MX2KoipHXoQIXAGHMARrgteYRIxCcidEb5RepTZGvy/N0FoHFY
	 IaHEmnX4CD/+ZnpdAu8H8RzSUkkar266necI1/GWTFRFF05IXVZ1QYsQDLCpNA5oiZIO0
	 +J4mxdMwiE8klDcVxTs+5m+akquWayYA2ozCOcqbziApb9rKL6+fA0SrbwVDGidxu22nD
	 6ec4huHgraDD13pnX22qbguekWvzffKKv/mm4vImO2+ZcmHpTJemdWCTGPH+bu7iFXw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504275;
	bh=YawDLAF2tBBwYKCLeaeUHgCi1xvtCY/EH1vlctxP5Wg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g24wmL55Wp9PxDiqhHowN5ddYr77CLmbkSW/nfP2z7BqzWYsERNCZXGzB991DY3EV
	 zO98zpY2h25pbkxG4azgioUagwLQOsbeDq3puNnsxTIAEWtkNkloEwy5GkXpqKDbXi
	 JBAtosOnVfBr0q04qFV/QAtC4Icds/H2YiUB+Fy0XplkzrTZ7bc6DP47y9jNbu2Cir
	 xh7WbV5dt6E8LQstQjeIunh448iVKN4p+TmRT9laCITqe3jpmgn/8xxfR+vbFTzgkF
	 yMzqgegjWm9INIR2CX+l4N3NjQvIjChjo3YHWnYANlCuF0ON/HB8sIa8NoJ8o8PsVT
	 MmI3WHwUVlc3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00BA24083E;
	Tue, 20 Oct 2026 13:51:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E96A255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3032E4034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZsuI9PmrxIn for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7AF4840070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504272;
 b=sC+2bVRI30yaoBSQcQxGyamsugwAcz4AAAuYtSo0mxFsv+/PIPSo0Q8SQl1UxMkpOHAj
 SW8BYIn0erbJJzGt13j5QC7fTxjHrjrEl+OwAPPfLtVUiRPQt2/NfRs8q4YaCx0cKrWCu
 1FxjN2oBQxYBy7RaZnxqo5zy7uTBAV4r4RtAWhH3lMioP03sUk4wmoacaQLqKa93Lzg3p
 zJo6I4Z34SA/UG/Am4rvu8E18nuGOXy8xEopIeOE3+Ea/90KWPEugmnBgljqJjYUNHiBV
 CVGl+1vWESkwQp0G3BrjnDcQfqV58k+G2rlnCWaKngTfKK+E64N1HwrtIT0o4LU3XQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504272;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=YawDLAF2tBBwYKCLeaeUHgCi1xvtCY/EH1vlctxP5Wg=;
 b=UXwSYm3gR7ofMbCthKs9LViTSsSaMEiUYe5bmJ3UeWO3VGYwet6K8mVGGo9veRtyKQM7
 I/7/d6TIA6Vex6FH10f27xYj09kNnwoKZXwSjwgjN5ffog+y2MRQQkfqJjB7utsdvwVeX
 Asn4VEsmH4bvHPfMPuf0OOjbURjAfdUQEPURnqyjznYFtbfTWBlM66TY/zVZ7zYoQV5tA
 MlqfDm5IZOUxo+gziTEtdhz5Txv9yEkoVtN8BHCP7eJRnshQqdfPS6SqbIjvGEFoUBElK
 spXnaSMULYhdvkDCO68OcK7dY0kHnfuC6C5FN93iEoWnXmnqpWSE4l1b6I6AQiJEEQw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uhzsCiXo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uhzsCiXo
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AF4840070
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEoOCQ4Zjepik7KBWEjh6cGHshDKmqyI/s5HVCteZjl54fqM6f6t9DfKVulDshmt09MHiMXwnI2n+pyGb+2Oz6v22vaf+FDfOurTjHdrryaBSyP5LXC9esBmbBveJcMczJXp5YFEzlnrxC+XGF/S3dCVT5BT46Uc9YKAEcUn8Ti7sTf4Xj4i5KuaZdqPrc43I3JPkcoJ/Bqc7l3OMWlRqxsMLZ/r3sTzwAKzNUU4gZw8CudzMPSohY1UHhbA4zml4nBuMuLybjcDikthGAWgADYp+m9waFAKGm4ft2R9DNEnTOOvwUMcsDwjNaeBsrZMBpMAo00lZ/7grXubGfW4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YawDLAF2tBBwYKCLeaeUHgCi1xvtCY/EH1vlctxP5Wg=;
 b=YfMAJIgVv0pdcrdFLT4yUCCzRFvy4U1QI7Fl5hNMbre+YU9JGCKPj/uVBY14X2ec6s7CwIl0mt37QRkh0zn+bsrCXPlG2WQoC4Wyd/6JdAkJoJ5r72iAO80bo2tDCN/JaI0OVGHv9Q78CHaZ9LDSuNr5Pp87LxegsyBDUwIYx9zEmZUU97TP1wbcBSALPW0K1yzEuSIYjf5icYr5h8ZfWkObT10PP9Yw8iPIRylhC3VC1jcigS1brLiz5Dzf6wTb4xI9P2bU03H+yNhcY/ADyOwD+/n8bjjh2e+nyfUOLQ8se5xNvI8yGMwK1FEmo57i/g1Iv9F9plxuRZhDTN6p2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YawDLAF2tBBwYKCLeaeUHgCi1xvtCY/EH1vlctxP5Wg=;
 b=uhzsCiXopgbdUC4iCiqcYsSwkdLvjp93bnKoxxfgN3mgpgauwUj2fnRH0mKf9xarWwa+MSaN/UxptiVtVGrK2AFQ17kHJ71+AZ/yIGhzY9EOeu58VFSyCidj2uOVwu9zVBdn/qQPv1nXSWUCuMmkxFFtIuXTijsM6wq6V5ZBRK0=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:51:06 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::f) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 13:51:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:51:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:51:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:51:02 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:51:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Suraj Kakade <suraj.hanumantkakade@amd.com>, Pranav Sanwal
 <pranav.sanwal@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: zynqmp: Enable Xilinx AXI Quad SPI driver
Date: Tue, 20 Oct 2026 15:50:51 +0200
Message-ID: <d04f32937d9abdd81c13f680714a4e36cd0c1897.1792504249.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=765; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=IIfMy6c0A9GiXedamN9rWR2T67O/nEQxoVzgpi0ymu8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdLzxs5NfX+unalYl/81/pcp7kbPlrndQ1Vzzly7bfl
 yzSzxRv6ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJzBBh+GdS+XfX6cXGNo+/
 GSxrcpVjaXvgVvBW/tDsdvGC7V5XO3gZ/jusfPReK+D5MpWeyI/vP+Z/XbmWacpVlX3P/j39yNo
 h/YsZAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: cb93342e-83c6-44a7-0700-08df2eb12ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: forgHpalptvk+q/mpjDJemQ+K7uLrSmpfmuyXRxGU8lff401R9dQ/flFhedsf7dEJ7Ikl9nOgrRUOmFT1SBQfZdnvCBq4g2B3QblVfuu1PC1HpGXM1TZSF9xhq7ofFXDKQUusr72LNIWhDwdrtxsnQSubfayybd99YvU5goO0ssMOUhgzJ4HJjiiF3MaFoE9dXrb08wnMlWH+ExYW/Zz5aT1pDKJAhWZgqzbl0cIBXWZWe98AdUQ8Q/jEOcnNFMbOJ2qTBxTf/4CLXvVcF3pEi3aa6sqfZVZbP663Bf5yLi92nMWV2dwoNalZMvpk2ujzcu8DGOLasMlvtLzXvrLHiRhM8PiPLtSifqw0k4MXtvCQB+MwQwxvrfKSXDOfSn75O+iGvKzS6i+n9NMZFFUHvtvNMPvjcHTZCeg6cinpHOiYtqJcFidVOE91ClmfTkC+JKoJ6piD5jTh9Xb5VD55xpqhKKmnoNZwwbi6TfgStgUJS15LlQwaylILuuPIdUIW20ru9gH4d7SIhD0/ZPhn6NkJYIn1t4fCgwL6BxDP6Fl7UyQMFrw4qinm0jY0U4UBUCpu5e0/a2xt96EYAUyU80MokOS63P5N1PrzfgOOyOoBcQaJQccMDbAgSOP6VSAO2Tt13rJmDru1b+1H5MBsXNs5xqWZ6PxapoW6qN6Vzxi5XD3sDUfXoSxVA/WjBAiDgTu2yY3iKT5Kc9Vh38LSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iqtnDhSf9wINMkeW3q2DSU4O4sRmmjlmegEsp6rgPXp0tfR4bpObW+ghcria8JXp1Y2LsvLRHN1QeXMfyje1NjmMaMNgBdhV1Wvdm/c1pBAnqgbUU0sR8hH2EldlCnKJrwt1dkmfg4jIwcGrVlxV/kUHe6FV39wHKvBEop/GhBhd9fKmeZA9kktxKn3LzW/PFxmZKjp5eD2IKwy9WU1oJ3AdH3vwilQ84Df24wQfzrL5B4J1qqFMTDMdyRSvwG1cyp402yJdhyhXuEoVkQ55Nv0OPOeHX1kpcmU19JtEiC2+hrxS/Ehit1QLxpNzNUra3I0MMQX1JUC50aUmAYIatuUpV9sy4IExyvpsKqOOCpeppudynujFd1OE8EppM4DFr6CqTBJFEk/QjxsUA7bj8cyMapVLG5G8FlC3jsilnsBomAr8XGQHImQNKrxnB8wU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:51:03.5299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb93342e-83c6-44a7-0700-08df2eb12ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Suraj Kakade <suraj.hanumantkakade@amd.com>

Enable CONFIG_XILINX_SPI to build in the AXI Quad SPI driver,
needed for designs that include this IP core in their PL.

Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 4684edfad031..ed5d7cd55174 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -203,6 +203,7 @@ CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_SOC_XILINX_ZYNQMP=y
 CONFIG_SPI=y
+CONFIG_XILINX_SPI=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
 CONFIG_SPI_STACKED_PARALLEL=y
---

-- 
2.43.0

