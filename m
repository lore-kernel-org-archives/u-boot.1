Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zrx2znfY;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v+UW7yPA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D65AC60885;
	Tue, 20 Oct 2026 13:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9XZ6U4RVLrE; Tue, 20 Oct 2026 13:45:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0753160833
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792503934;
	b=IfyEThF5OTneyRk1NsMpy+qnSSFvxzNjJu7tID6WIawzNrZ1LhALfDQX6zmNbp2Dz4JB
	 PNuX/qk4HgBSqNgLNKVGf7U4q2Da9Vjft/nnVqZThKWKKijpcEjvGflmvoDimH71dRcYe
	 3PaSm9gq2a3PH6+TYVBEg5Y+16oyHZITCTCxrSGWa6Ni02r0sJDbrx7TF9WQHmvppZP0E
	 Go45Kw0HntlTGvaJPpVlPd8ZfFPsFjv3dVDFvlANgLRG/U1UReTwuH0MaBB8BLdNaqGtg
	 BBKpUAk9WuuKDw/LKJ1MJUaeCk9pPmZNKDremdSjKEy+JYC+8RG7ddVEf4cmkJPOY7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
	bh=I2LDH9vZj5LjKqvVrg43SMlgizkoP+32qn1pvx3im3s=;
	b=DCQ8o4lv7npY6FrvbSIXvpEY9qUZTXCJYYCDfS5IWgNln7cFC4ZrmjurG/G72ZdYAgLD
	 GL6kkP/3JLobJkRDSWmL4AeXKrZwDn2feH2X1FhnThiITVVSuEBjMwnFPuQ+ClrkLOAQw
	 1aBRzmnd0SSwVXVCieI51YG2HG6NBiG/Pj0k69zm/j/xgRaD2AodHr5UPjBbiL3S517g6
	 dAIQBPjMnGWDpfHglOkn6P+PrLaopWiOjXc/WymKlASJohnhTU5lvbXXNebVpfiZkqSjO
	 5h8brSVLPm7NVDCYIDVGQtbtyqgBzSkHFdeWyduGEhOMBEsH7ewYY62DGt+fsUZS32A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792503934;
	bh=I2LDH9vZj5LjKqvVrg43SMlgizkoP+32qn1pvx3im3s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zrx2znfYoekD985Aa7C9QAbf31Dijup7sh+pSTR1UNzhAjcWNcwfDhlizdHxvgXLM
	 z4qCYoX0JDHaJqGpZerLcndVjBGekHCQb/YsBsJlCP43wz+gsYHqhVi5s+IiNf7rS1
	 zKfsl1A009gXz7+CogrNYR8Cf6iKhuYQT3+msf5wu00K6Z1yXjEUeacms7QWXM/I7b
	 boFOXYJ6Jp174go21J+KedaAl7ghCRX6TKMh9aF38xLx/fjr1RYUNyBVtJkjvWMTHs
	 mrxwX9ZumDHE2IQZZDYsLey9gjpCUWQUuIj/VdB/DMdU6hyxKrLLZDFF2cJgGWdM5W
	 pKjijKmlSy9Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0753160833;
	Tue, 20 Oct 2026 13:45:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43D791E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 354984034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZVrHr0XPaIt for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:45:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C43040070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792503930;
 b=UzjpuYq0jQ60zC1vXB5uO5VmPll4YCADTFPdXnD4GoJNdfGPpCFRhNdqaCBrKwhNVLfv
 mgFLBGnrI0i63aSBrBuMMA4xwxeFdvZ9OoASvaF6m0+MUYZ2JecKnxoxdxzB5GDTRTYJg
 Qa7WGXw1JoenTBZH6XAOrMO8M5SLv9CWhu3mL0BU6dec6FMicxHVeatWdfRgnnQJfSmQ1
 tS4PS+xiNYa0wdEwVYYKD+E1m5bU8DwqeReNHCF4I8/1AP5VdjulqWeXEA5pQcLgAyfuD
 0Qqoxb58KtvJBrr8uRSCJPJVhD4bfCykbYSct2hv3XZ1XNnbW56tagAWqZO7CAMwIrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792503930;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=I2LDH9vZj5LjKqvVrg43SMlgizkoP+32qn1pvx3im3s=;
 b=iFbxVPxrkL8WQtr7HvCa136htdr5GK8csbHVtILlGvSpu0xr1bRWobgg738d2OwVEVUo
 KqTTerCBOtG6OApM2xbFGGvstA0NK0+kyCHTm6dJO6LDc4USTWve0FAhAfwIU2KEsCV5v
 rJE0bDIU07TqmTzgrVydPmnLleKHtTZPX/Bp4OSl7OTVhMArQS8yhJGeTOCwcCPpRdvEa
 5UELerR0WS2AosvN+G6F1kXaHM+NixFgh7FBI2rZLSNte4JJmvX9MiautmJuLczODlDp7
 5I+57U8FI3NXk9hdE+tOT2EEoVdo5eMMvsCPf1QRVybk/e6pNODVWGY41oDQTwBMQqA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=v+UW7yPA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=v+UW7yPA
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C43040070
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR3Xz4nLDDBXFTE4H8n6u6Lffuxvbmg1+PXdFsX97FPt/5XXB41Vlk7ful2VLZ5PoOLfPcBpoOkfbQRkaX4oka+rM40u+n9D+C6SUvDZyZKW1AX7IctiXrowDtEHTZ46flxvC5PCDeErhkYdIk0Wwscq2CSfkmWRJJyC9wsdYjfWUDg1gFA1sIxUlaZ8S6n5SwJU5iMZJkLm0od68JxIw/CIbS3BBkFQGDPNChlO3LULKeCK1TunUP3gk2UrGKSrXXdnRTf8Tp1a5F0Cc5gHw3akLRCKlpH/+XOSA8x2s1wBYoaFEEUf6aWbpwKHrnLv10rylcb/f7/onkIG5i1jpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2LDH9vZj5LjKqvVrg43SMlgizkoP+32qn1pvx3im3s=;
 b=LI1tZdJcfMN9masNrodoX2dvbxFllJ6Hz2e+7LjjZ0ybrekNGOGhk9oNgMhe+RE1NcKmUnibRVvC5TT6ruWZmPz1dfm260uS5c45Jh8rcIfhTkSrGuntvaohNoj9jZjVTSTbcIDYo/vepcg1q1oPgi64KDuReH6eNsZwlFGPH/kBG5v3BgW3cpw5FqiXWzj6rzTNEC5AHuCJYpadrMwlfaoOL4OwgPSn90xRGgH1hpAVZrfDKQY2IqxWNdnxi8uXquFOvWV4LBO2GfKQRA/QDBrOyvpoJ9fD/wHxxQLcqTqmyB+OZGFB9S5DDA/eiMGdJGZ352bU8PAF5a1zCJsj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2LDH9vZj5LjKqvVrg43SMlgizkoP+32qn1pvx3im3s=;
 b=v+UW7yPAf8SE7l2haFexFT23iFrsXDujqtV0cejiPQ27hP80ECrtKnmxk+iFlNk3ZLQL5496SBjQJh5bn1DtAMKRrNLzym//OiOW9pFDJ2Q88I9D8HwIy9qghi6jveUuYrrzCFEtlDcqNf+/H2EAFiDNiWxfsq8vcR4D8uMRxdo=
Received: from CH0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:610:e7::35)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:45:25 +0000
Received: from DM3PEPF000265B7.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::63) by CH0PR03CA0240.outlook.office365.com
 (2603:10b6:610:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 13:45:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B7.mail.protection.outlook.com (10.167.23.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:45:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:45:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:45:17 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:45:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Pranav Tilak <pranav.vinaytilak@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] xilinx: fru: Use sizeof() for board header size
Date: Tue, 20 Oct 2026 15:44:48 +0200
Message-ID: <74d8eae19c90dadace5a16ee8b589fff563e086a.1792503883.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503883.git.michal.simek@amd.com>
References: <cover.1792503883.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=P1zhyz3shCHH1yQHt02wb8i/+vv1/NTgLxzQ/9OS03w=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdLwh9X9spf7p37oIDfIsfZcntee84xyz5a+zVAnWz7
 OO7n1/+1FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQAT+fGXkeHiPnkt1oy1sQ51
 EUmrfoTpLvrF/XJlxOsTFyNdsoSmMisy/M+J1MliP5VYmHVX/CDPdO64/SsjFxz+PXX2pA4HmX2
 RMSwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B7:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a12d660-720a-4cc4-870e-08df2eb064cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HOHv08TY5pwznTalNfGPSI9JEkO1PWZ125Fka2r52ChKNNqmtZnvqbuJwYaBznhTpZvp2t96rOytRvvS8/EauYpudQjSCaLD7M941aaPtbjxPqQm5DUMErihuONX03ZnCVDEFs0Gt9pk0LNjST0V91tEel+PIv+lBS0f3+6M18TlB+SdK3iwurs7ulDlaM2acjx/fKi2ZUkE8oXDM91sC0896oA4PyT9qIiBlG0gP6nxLdyktMiOGYO6vS8BiZL1YQ5hOSAmM9sAdhgnY9+WIx07iUhhmNJxKDe4NAJwrh8ptUJrk5gEPLMRVeiPbvuW9MvsBpWhFewgtX7WxlqK6FmSHFbG2MS0j+6TWrkYsre+gzzTQcyIfePD9DKDb7Jsk4rDF0P45tvh3yxrR6+bELEZSDKUylPY09fnmcDJMOiz8IigPj8FaST8a5g5wz44Ny2RlipFjvHEt2N7lYyofnOu/D3LJHP21iOgCIxuiWnNmwlnulEo5MoxsomRrTuAuMSYhcA4krxHMnTkM5AsIZ4HKdw1a/pCyeaDxn5PYIEDJq56HhfOa5kE1LXkGVobYKsa/GYKl5/TzMUdCTweDq7+7IPZuIUcPxGU5tuPm77CDmc6SzTEmyzsOlNXpgTitY1t49P+JxuEziZk7oihxxkxMLYjosBaSZEHdgESBSR6ymxDmb9O5Q4Ma4G0Z7N83B9KrhF3bV14Miv4ghkJng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5sAo2k6NRA1e+okRwiiEjyGBrACkg31UnX9R0N4d8cbPLHf+R3qkTdzuulmX2dxrCGXu8U4YXlk2FOLi9EvtX628047T565LaDgOJIzGQ1J/+vFMhMX96/9nrG+MdaENJKv7MRCcJO/rEWsV+NQ2+Ti0ITqFxSc44G+7aoABOw7hqB9xQZBHRIPmOXXyC8vzEZcUs+MpD56nXOVig0BwJh/V1SayNWc097apIY7fwHjmm4qaXe7kiOWtcNbMz1XEPfebs+s/WynGFhW8rOQDbBYxg6HZ5XwJO0qNEnxgtF0l5uH5uBg/SaGc3+3lADk/xQlGiwAZtTd2z/oHKBpI16FvZUKSVV/3foKY76PfT373T1ZNUmt3xuRlazLu2pw9521t2jhOrphShJs50z4a267p6biRnEFqHyBxqQ/wawB8XbeeHZrhQGngmVqLxNkg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:45:24.9352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a12d660-720a-4cc4-870e-08df2eb064cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pranav Tilak <pranav.vinaytilak@amd.com>

fru_parse_board() copies the board area header and then skips past
it using the bare literal 6, the header's size.

Use sizeof(struct fru_board_info_header) at both sites instead, so
the two copies of this constant cannot drift apart if the struct
ever changes.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/common/fru_ops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/xilinx/common/fru_ops.c b/board/xilinx/common/fru_ops.c
index fb88c21cdf6f..0fc95b927f8e 100644
--- a/board/xilinx/common/fru_ops.c
+++ b/board/xilinx/common/fru_ops.c
@@ -178,7 +178,8 @@ static int fru_parse_board(unsigned long addr, u32 size)
 		return -EINVAL;
 	}
 
-	memcpy(&fru_data.brd.ver, (void *)addr, 6);
+	memcpy(&fru_data.brd.ver, (void *)addr,
+	       sizeof(struct fru_board_info_header));
 
 	area_len = fru_data.brd.len * FRU_COMMON_HDR_LEN_MULTIPLIER;
 	if (area_len > size) {
@@ -198,7 +199,7 @@ static int fru_parse_board(unsigned long addr, u32 size)
 	eof = (u8 *)(area_len + addr - 2);
 	end = (u8 *)addr + size;
 
-	addr += 6;
+	addr += sizeof(struct fru_board_info_header);
 	data = (u8 *)&fru_data.brd.manufacturer_type_len;
 
 	/* Record max structure limit not to write data over allocated space */
-- 
2.43.0

