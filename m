Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C7606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nJyaD1ND;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=esh64DUK;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=UCIo03Bx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FEC940A55;
	Fri, 27 Nov 2026 08:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZpcegmzchIr; Fri, 27 Nov 2026 08:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC8E940A52
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795767554;
	b=I/KY+cntcj7/iPPiYgSEhRqQFC4iXzvyIXacQ8m+iCIdnzz4mweCylM08rvWGfIdDL6R
	 NpgYrO+B2RZb9CvQDm58GaPCngk3qAsPpZ9Ox39SvRt/8OFjnlhW2hwodARiQNvwCRlCX
	 SE1R+addMbW6sFdxTPSy9yWoVF08iRcyqzVkHKpJs9WApWKSu1KAXIkkzfBA7/8BLgBEy
	 oRqqrnJB4DsBaRXvnwdHbL4NDo1M3x/d6SXW3W/NF3iN9Kab9XwLnnCRUm3H+anK2AwML
	 MPqg7d+pwF+XdcN/obP+u5Ja62djUUJenw4wATQUDq0WFVfQz0rE6vd53+6u1pXGL2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795767554;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CPKuaXnGdmeGdYVlGSECzfBZLo+W8YGQt2wbnMLlbus=;
	b=hlM/YPmDRp3dWUSIlf9qoG/IbtcSYa7n4TL95KzLjv8jggJWpZtsXUHvSsBvL89zVGT7
	 /0yiv+WMmsl6G2rpX9xXhJlYtsSCnSAUXOXk0lZCfbQ+NqHoeKQ0ur/zcl1xxnEvm3Xuo
	 IzYGRKsdM6NdGiJWHxmCheDCUMw458WRTghHWcW3mUAlrPnvmYC8S+5drP5L4XfAcN5c2
	 c3XTLNXaZi1KoC5vFVBSNV2FtUlKKVMTlLyMciZGRnYj4EXhay3QCr8W5LtmuOehPTeVa
	 ka1/UdD2i17GyWblb4r5ktZTFDkBEVXE8lG1WRYq18zNxUKCRwPwZpxAqAYY8wa3JkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795767554;
	bh=CPKuaXnGdmeGdYVlGSECzfBZLo+W8YGQt2wbnMLlbus=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nJyaD1NDviFyRTwwjZTypfvoBmA47a2oGZrrYlOFImYIgLUmMWZp1S2or807oxl/l
	 gLrurWCJhJw1mcF5GV3vzEHlJKQzupJqOC1sj+X6m7M5yKTvaH/8j17cP45lzKw/pf
	 V+itJh0XAZ/0IKYDpRsZvy24EX252INoURzenN9+CrToGEWidG2lrQUsUOtCNYt/+L
	 0v+ZPOAiMY3ir8iXUhHbk4VfhBBKCn2n+98yhwlKkxyU0yckEPv66fI5Ux8hF0bzt8
	 Bf1P3hC1VEnbgFQljCBN1WBJUvvMMRUUK0zEwdXNZSvR+/aNPr3nuSJ8YURILQqORu
	 rolNonHL05XhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC8E940A52;
	Fri, 27 Nov 2026 08:19:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05BE13D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E095F60698
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctM6JCUHE9bh for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 08:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 235FC606E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=esh64DUK; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=UCIo03Bx
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 235FC606E7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:19:11 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7GmAN1896265; Fri, 27 Nov 2026 02:19:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=CPKuaXnGdmeGd
 YVlGSECzfBZLo+W8YGQt2wbnMLlbus=; b=esh64DUKiHKWgzdbR05bt9ZcWka0w
 NtLle97pP1m7R6FY6Fe2RpKtvsgOY+QMmM3veOo8xnZDHAX23rZ/OXt8akHn6Ia3
 DnAi7mvqEzXFn0eFBi1LZgNaZxtDFlhzLe8L+8BObRSHzLiSn2gqOwQQ6n50xnmK
 404srI0lkyRLOglAMPuvFn/r2ASKHe54OEC1Ipuxn+0d5LdL998+0opVozZBICkp
 qBwDzr2NCHnMxpPm27sIutERFqFqYSpY3KdasaedAJjNLjFe5NawoWNfNdtcQoXc
 arndXHnW2JVYF131vIvYnR12XZT1rVwwgJQa7RcwLwKkuv33rCdlBEOVQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013039.outbound.protection.outlook.com
 [40.107.201.39])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j6hud5e0e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 02:19:09 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPKuaXnGdmeGdYVlGSECzfBZLo+W8YGQt2wbnMLlbus=;
 b=UCIo03Bx/eZ2pocwh/hXo/EDz87yalkF9dOpO526oSw70762UG99v+iTUyjcBYXNwNrxWcU8HnyaNAj24UIqZWu20bScRnKVYPQcyQBg7WkHDfmA21FxI4uqJKx4lqZF58bQGOleloQMcdjQjFGwEF50pqD8pGIvNuNnc2vqB04=
Received: from CY8PR11CA0023.namprd11.prod.outlook.com (2603:10b6:930:48::17)
 by PH0PR10MB5871.namprd10.prod.outlook.com (2603:10b6:510:149::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Fri, 27 Nov
 2026 08:19:06 +0000
Received: from CY7PEPF000000F6.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::93) by CY8PR11CA0023.outlook.office365.com
 (2603:10b6:930:48::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 08:19:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY7PEPF000000F6.mail.protection.outlook.com (10.167.247.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:19:05 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 02:18:53 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 02:18:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 27 Nov 2026 02:18:53 -0600
Received: from [10.24.50.11] (dhcp-10-24-50-11.dhcp.ti.com [10.24.50.11])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AR8Ips32362585;
 Fri, 27 Nov 2026 02:18:52 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 27 Nov 2026 13:48:33 +0530
Subject: [PATCH] configs: am6254atl_evm: hide reserved-memory from U-Boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-sip_reserved_mem_fix-v1-1-039a1c8ac72c@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMXQqDMBAGryL73IBJW0WvUiTY+Kkr+EPWSkG8e
 9f6OAMzOwkiQ6hMdorYWHieFOwtodDXUwfDjTK51GXWutwILz5Cqw2NHzH6lr8mfT6Cuxe2zhB
 I0yVC9X/7qi6Wz3tAWM8XHccP7J/HBXgAAAA=
X-Change-ID: 20261127-sip_reserved_mem_fix-054c2391a6ec
To: <u-boot@lists.u-boot-project.org>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Hari Nagalla
 <hnagalla@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F6:EE_|PH0PR10MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e7f0c8-55f6-4a60-35e5-08df4c5f1a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|261102123227099003|10067099003|56012099006|261022075727099003|261022105027099003|261022113327099003|261009223027099003|261026140227099003|261021121427099003|261028144727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: lH4HjUV4xCLvQHgXSX/sN2gAgFHKUYBA5rCj6H7N59MyK/R1/gNExMbu58nM/KJW3idNl+9XAdWJGF6qVc21hZ++A8pPWaRj0HmiG1589Cev/I1wdiSIaMHPNXmNh7P1RFw7pec18eqtnYzSCkhsdzABOiJ+UTCUsyuX4qj7KcXF/m2yTUNflrSPG1csUcmcYsxgSM08s41NoDzyjbnEgJryohzOSTXaxs0KPB7zWZ7VbGintZVzDOBjAapwIQy41pyPdth342cCw4kOU5enZMu5hr02/Ogw4im5uSkrlc0P46oS2NxRiadm1gDjeHPDJnnjWnw2BNNYfVIjd5O3AtDHVJBm+6XfhL8lUhpvE3dYEg+nD6gwjUZMF2D8F1f8tU32AH6/nrogmOP30jTzPwb28UvPjMDVnwV4MNsbBi5nVYujPspyeuRVAzrqF8icI+zxFk5G3h7JUqRJqAIDiXqdjcPOL0wpBUtGk77w58enFtYKwHkzU/k1JVnPiB0FvC19VzXxSWzBIiT0vinEzn4SoV++y4+7rNGJpbE3AudMLWr9jYE9pL18I2TRVtUzwBg0xWefmRal2UiqCFO2RPB50aUWuPetwEPDO/O4jdQaAAzuQcrnxV9C6iE8Dh2S3p+Yny2wKB6yJat0vNixcEVH5bWgi+yru99s8UAusEY=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(261102123227099003)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261022113327099003)(261009223027099003)(261026140227099003)(261021121427099003)(261028144727099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oWayjzTujhL/UistG4FPV4RTVRzUCwJMOHwkbeLdOv0pfwaUqoAeL/6sk+1DQeObJPmNIDTzmyV3EJY4A8AafNcxJgqQNq3T1n5EqkMFOc+CYCTgyTOWy4PfnEjpB9fAb5O/sGT2VbhBoplejmJmBPi7B/10kz2Uh9nOqXfZ7P6Tmf1vCF02xFlnEg+glDhZM7U3pFqx/2mqeHEHxQtZKHDAkIl9HO/nHxk0X2WanVzncWqAcj01mqleIE6rPyN9SdWWMs58sLsX+mNHMVSIS1y0Unf1hjp5ILTpag9gDIIkUam4g6QKGF1SRspxZQVPgakG8GxdGN3CZHPetBlh+Uj5yRVUPZHqPBPzPRXqJD/dSclHjWnGDefOWblz0+iwtZNhK4td4lBfXQR1ysVRXoxGdrwr5mdZdqXhB9mS2onjDKxOLmaVIkxPHaXK/N/0
X-Exchange-RoutingPolicyChecked: mtRZPJ9pxEPSgN2mCXTBLnp+ptkWBH/YFlWxWlwXcNJL8VLUFPlkfaW25VocS50/R5U1fee6QiwJO6UjOjnyxJVLUfs8ovRIsGvZ7k3WVpnOqqiCdPvzYgB3tTwWM/i30WCJBbiMTV+AFh3wLvyUO8b3S5mTAlaea6dSNpMo+ps8VgEbK+HldKKkz4ciRp9MdyQrW0h/Zop5bvRpJv6UH09k/pLGAtkZphoZvD0RWNrJiv/GlwuEXaPO7w/0gwUJlFrrbHmrfekS19GTpKb4CjHsByuyUfVhJUrIqnl+So1OfUXWEK8Xo7Ct+9UnlqekZ+a46kRX2y27Q5SxjM8bgg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:19:05.5372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e7f0c8-55f6-4a60-35e5-08df4c5f1a45
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5871
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzMiBTYWx0ZWRfX2r7VtD1rVGBJ
 lKPPBUfgPPGR4G/GOorcAYazf/HoSQW9HWKnJWYE+3IcpdRn0w8Hf3izDWkeOEQsPEb7XWv1T7j
 cl4C63eIfKl/ww2RpCKeg5FPVCaDyQc=
X-Proofpoint-GUID: wMr8TbTvGQyHQDDbvZvykdKPcvSyDoOc
X-Authority-Analysis: v=2.4 cv=a4KlZkSF c=1 sm=1 tr=0 ts=6b093cfd cx=c_pps
 a=U/rLDH1MEKAiLKQqfACAEw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=oEFaNFtToe2V6eqqVvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wMr8TbTvGQyHQDDbvZvykdKPcvSyDoOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzMiBTYWx0ZWRfXyZ5KVJGlBfk8
 Sobzifj4PnXw+gFwbo+GQqfHE5x+csPrLgud0uboFYGgODUDr8TpmnJjEtuWxepdYvToMxxW6uT
 /n4nh8l+qiV2EQ5nbNPBCH7ETdwIxBjTIp3y8q0Y4nbKehIDAV5R3x27hJrkAch7LOd9DRcRy3P
 jx3dnxGglr5tggv0ZZ3okq1xYMza16SPd1hIxgAUDsDp/O957GPfqc8mxHuHj6VvyL3EnhddIOt
 RZxOKjBoZn30S2ZUNILhLAFBW49/Cfp00ggXOExX0qgBDlf6b8RcAjc2M9W5h6ruiUHTm+6xEKz
 bWXn9fZFKXCua6RTXCDdi7dvZsiJIKgP1vJiErx6JJEFvVWo2rCV8OePBHkCF7gRUIqd0CJdfRJ
 XaA9AGDkEe4Cz1F96bbwb9K4bwSI6UuC3QEMpdwod8NyQoeYxTEZCET9HkhmGDUw/lGdsgsIl2X
 lQHf8qZxv1hHQGdZgtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270032
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AM62-SIP SK boards have only 512 MB of DDR space. When U-Boot relocates
to end of DDR, it begins to overlap with reserved-memory regions for
Firmware IPC. Which causes lmb reservation failures during U-Boot
initialization.

Furthermore in cases when the relocated fdt lies in a reserved-memory
region, the kernel fails to reserve the memory as well.

Therefore this patch hides the top 57MiB from U-Boot so that the
reserved-memory regions remain unused during boot.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
This is a continuation of the earlier RFC fix[1]. The following errors in the
boot logs are fixed by this patch:

	U-Boot 2027.01-rc3-00004-g788e6770c028 (Nov 27 2026 - 13:44:01 +0530)
	[...]
	ERROR: reserving fdt memory region failed (addr=9da00000 size=100000 flags=2): -17
	ERROR: reserving fdt memory region failed (addr=9db00000 size=c00000 flags=2): -17
	ERROR: reserving fdt memory region failed (addr=9cc00000 size=e00000 flags=2): -17
	[...]
	Loading Environment from nowhere... OK
	In:    serial
	Out:   serial
	Err:   serial
	=>

[1]: https://lore.kernel.org/u-boot/20260729-am62_sip_fdt_fix-v1-1-b0d814983d28@ti.com/
---
 configs/am6254atl_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am6254atl_evm_a53_defconfig b/configs/am6254atl_evm_a53_defconfig
index 2aaa50ae4d2d..73e70618bf45 100644
--- a/configs/am6254atl_evm_a53_defconfig
+++ b/configs/am6254atl_evm_a53_defconfig
@@ -14,3 +14,4 @@ CONFIG_SPL_LOAD_FIT_ADDRESS=0x82f80000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b00000
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am6254atl-sk"
 CONFIG_ENV_SOURCE_FILE="am6254atl"
+CONFIG_SYS_MEM_TOP_HIDE=0x3900000

---
base-commit: ee39963aa7d7858e4ffbcbc2b2a0a32c0b3dab35
change-id: 20261127-sip_reserved_mem_fix-054c2391a6ec

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

