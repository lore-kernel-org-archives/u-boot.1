Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769F606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uW3gHp8p;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XiH5NSk6;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=sY9RgTR7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5252C80DF3;
	Mon, 16 Nov 2026 05:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7xFKhAGHjFB; Mon, 16 Nov 2026 05:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7651480DE8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808321;
	b=PNtJW64eR2dk1K49uKBC4iPy+rq5vZZAPkEt9F9lqgjONrjPo3LWes44LjUeaTk5Br74
	 SezPg4JZu0cBD2E7q2OwQ+i55lVMppmrcNwdoq7UuVhwmKZ1OjcDzk4wb58FrH9l0NoRJ
	 KIJ7AHNQl82e/KfJn3BGNFoWNDD8aipH1loQe4UVFy9CZmQBCWZIN74v+/hlLvBOw1hDs
	 Yiu0NheR+WXgn9y45hjQbuHL0WmNTSEHNYhcP5QM6c2NRxnNSkFrbnk8iknJsjhJ6udjx
	 mNUrJlQoDZSaIZc9T7Rcf2Cem6sBcO4yI2do75l2S6odsQUHbGiQEt+MGkqszlcGAOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qe1NG1WVvTP/1VsleOayTFjyDKCenV3QkdQ9y/8n+KM=;
	b=QaD7kQ8z+MHnKER4O7BW8ku3FkDmpMlQ+lZ+0HQUYG4kM1RNbSrfWLv/bOxgE2bgth8j
	 4RWja/+hMYhszIaBwYAq6zcn5zvWL2k+U2W7CQgsSznqPnwprUn8AupaNLB28ilIlF0v/
	 hzFt36qf+XCBNzPiq9F/ooRwIzuhMjOLsUHzAAFkMH/jeg4FT8LVpapbReORccagpCXag
	 nru4WnYNiOW3DRlxfmhM2h56c5OHmveUPVZLBEDMIIe1i42RIqLkdlNrFHry7jJiuYgWk
	 TwqTSG0/sn7BkA8FJQG688tp5+WN8MtiaVNv2CMH2iQh3kDseQ1tIdNlkX8sgITfZWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808321;
	bh=qe1NG1WVvTP/1VsleOayTFjyDKCenV3QkdQ9y/8n+KM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uW3gHp8plxUUQFjk8/Abwu8JlNBwmK2PZ8VjXdRMSSIohrmlbjNIuFPleMKfCdKXN
	 kqjQFX6/5m+t6DR/44vDFIirRfpv0GqpdlqDlbiHdfKd6TtVKmjkgl783UqLx7dsOR
	 UAeDWa/QTHQ4BLMnMi9Z65SGKGpVQjdaGHyaXpuI9my+vsnIdUbJxfZ+bXvA+u8qca
	 7Mg8c/EhwdjtWFZuSsTrZe/NIZO+tj4ApIX/6PDsNJ+kISvHWW566bT8HPSdrnCeSl
	 NgZ85dOhzC7JzISu4c39TvxtVWPy4kHO0Ltm63Hi1cslvdA4l04jHpytfx9Mid5B21
	 3/7zHLqo5QRrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7651480DE8;
	Mon, 16 Nov 2026 05:52:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0B3F4A0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 874E6405E2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wk5ZVt4lrxct for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:51:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA8FA40600
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XiH5NSk6; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=sY9RgTR7
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA8FA40600
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:58 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AG4RIKG1154132;
 Sun, 15 Nov 2026 23:51:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=qe1NG1WVvTP/1VsleOayTFjyDKCenV3QkdQ9y/8n+
 KM=; b=XiH5NSk6HYETbYLjSNJu4diLCg10n2ujJ1HKaGgtv0lKDeB+WCmdDIlFs
 OEtjCUg/61emG7Al8cTTlRN7dco2gtuiP7eXOeBL4GHtWPnK6oFYBWcp3BKfq5xH
 RA+fgFLTDMvAGkr8K3u4fLwgct6z+5OMhtnFdvGdaA9uxPRlg72sQzSJ+PNHe49N
 da2qyCTIAbhU+w6nplZMtPtCQ2PDDCDtdF//Gh4e1/6SOlMsaMfAM93eqopvp8Uo
 b2g1SWD7Hx4Bd5fIBk3Oizx3y3yZLAkMFAxoDjRhnScEVJrgrl/fLA0J0tw1/Adi
 6Y5GIMmoZiAAH0bjOHv+VBcL3mRVA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hyafsbmf1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:51:55 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe1NG1WVvTP/1VsleOayTFjyDKCenV3QkdQ9y/8n+KM=;
 b=sY9RgTR7nZEwHXYxqXtTDS6jzAG62v1Jekt+qtEPyVJvfCzDs8D+Hsa2m4a/vs6/hRz2AD4Hfl3vEHfD1dk3M4D7AsEg7omKx55Kou5yG9PyxBFwdOohqAiXLqW3ykam+YJlIf6UeAt7rrteli4I2FRvwJiCBDQgN3CQagfsPbE=
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by LV3PR10MB7769.namprd10.prod.outlook.com (2603:10b6:408:1b7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 05:50:53 +0000
Received: from MW1PEPF00018892.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::8a) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Mon, 16
 Nov 2026 05:50:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF00018892.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 05:50:51 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:35 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:35 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:35 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbm091724;
 Sun, 15 Nov 2026 23:50:33 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/7] phy: ti: phy-ti-am654: fix logic for programming clock
 parent
Date: Mon, 16 Nov 2026 11:20:01 +0530
Message-ID: <20261116055029.3493551-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116055029.3493551-1-s-vadapalli@ti.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018892:EE_|LV3PR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: f4524eae-9f3a-4f63-a539-08df43a592bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261009223027099003|261021123027099003|261021121427099003|56012099006|261102123227099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: Jyx2Uo/BRiYsoLIF/vW0VCjBiSWIXD7cSt3hptxpLsI4Lu6idQLxllNLD0qsrTZOZenADDzuxGzLyGN3d04xydoI+YtixE4MMkrYeK21akCFUs20bDTNHdVsLSogdRAX+F8Exhxh4EP1x/IfhjIMcT8/hKMQVhwqgk7Z6Pf/FVIGfRi9yD8ieWJP4rZhY3b7Z9q5xju2B/nPam3GwKdHy2mWbyQTQm+oRZhmb5Qu20g50wW1YZPZ3FkP97K7eS8Qx5pD4zWfnuphW9QkgOvracFewzM+CIRv3/jm9u4BSr0YNPtw9gL8pcw8DfjoOrIyYYa64e7dv7vEA5rhZQEUgcMKVaPXK1983MpQqVEjdKVBOQ7K3nO7dTpwKgaF1+guWqPzZL6RpJQ7ZvuoXwoNXVZmAxw+oL17lKnIHVQCkDCLqZyQVuOm0JOEIXoZr7gTnqAfF7yskZ5m/5pUhhgNpldWKkpPwxMHtSIlcQPocnPjOJa/CMeDXWkIO/CpY3NN93Qh2UNbPiRnBbtwpYmH+wdrIGOIQqPGGiearWaNpEXeOEITAHa46DBDbF+BQj1M+hY+8+XgjJO5xx0hl/H9G9WLeo/WJic1Ewwhx1vzBuMDMAc6STmowpR1T4sqo5teaA4AK6OJlWHLrOTuUy8OdDW/o+j1FjusjqMO0di780+lwL/omobve0u/oYy8CTc7F6CzcFlSqT/XcJPAXOaYsg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261009223027099003)(261021123027099003)(261021121427099003)(56012099006)(261102123227099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: emQVU3wRHgprz6MqCVZ2a+m/4lKyi8hmrzKuD32JNkWMGIBQPtTVpu8bf/zWNrp0QKi0YOwbt1VKmKbDW9rvEHhlubO3n4O4vZvwqmSHXwliA8GoLsOtV6r5lmKZtQkyqbfuCAMM9X/NH/w9kzpAIsvzx96VQUXvclxGWcqRddlTkSveSeCfUT0awKyli33Buxe7dDhuwL4joDYZuX6zpEKC/m5woXegO9jMdfZbXPgULLhQOByOfhZwwA4fH81PmqXId6Y+W2mwNAyVAg0kAV4S4GrIseWU7AOaNrnQMUYDf4t5aC6nuuBLGwIK/xuRxxtvZJduROPSCyHdGwG0HWm6WqEf2Not4FyGaKYVS4lvYpb2VKioXZxj0IrLMpEieJGwOwGwIHRgwMVR6+BTZhPRvQYoCaq6TCUgOKY3MYYCWGTy2CDm3hk90rmAsdSj
X-Exchange-RoutingPolicyChecked: AMj162YKkGodoTBL+FOk9FiVCRmEMLh0deJAz16btXePdLz55Pqbxgil+/pFz+Ki6buFupS+mGRTvOk4pau1UcRS/Lo6PlaH5axLB2GJNyiUlGEE3ttHAP7JakrfodZ0MBAQllT/V9Xrc05UgpkyMMCCjXk7CT41yVCsxAeGp+7XdZC3nMYjuxSe2+5Lz4c3HktgV/TP/p4+0ymGTi4dPYOFnMIH5IA/KmM1J70H3yefxhKUiQD8JN5grHAtsmjQFlZf/xISR9CLM7Plxtq8+VzvLD/7JltKKPw/MXDq9VexlqtAXZ/3UP0KoQhNFDSsPMTXF5HFg315NvLaOzzfdg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:50:51.9281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4524eae-9f3a-4f63-a539-08df43a592bf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018892.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7769
X-Proofpoint-ORIG-GUID: ZixRtFhUQYPPViiUqxCuNtFO1VajYFVt
X-Authority-Analysis: v=2.4 cv=UanE26SN c=1 sm=1 tr=0 ts=6afa99fb cx=c_pps
 a=9D7zFwNo98o+tMWDMQIn6w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=g8noQebMVTy4tJefGO0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfXyqRsYAmLQWrK
 8h1iznmw21Au6GYsrRpoXJI+FP/z2t1AVUl1rrgS0i626hC6l4JkXY1YZONj1M/4xdoXxDiGkyX
 YPtfcKkAMQueltVGr9XanZBDx/+YBLc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX+LKOKW7g1y0j
 WByCyq/wL5z63YoJEEFAa401vb4OlmaOaep4qxCFv4GDPLpL9tUYVT2kvI20Md/a4Bq2xXIkJ5S
 nTj4Yb8TbN4Y3hPBLH6TFtDWTHQ5Ul03mDtYVU8jBJmasI8qSlVYlmudU7fBKBE+8znK6WyxG7F
 QoIXwfCH129lXZALStyw1eR1pZ6BCEKbCDkLNkbvtg/GN9WateGM7Gc3dgyqFwTVDmXh2LmDW7G
 nxrs7uWD49laVaDXZ3MU9vWiwAKpKtTYpTbgmB5ByQloRW8l0V1Uy0a6cyBmI6j98PRrOmIpQLO
 9mBRtAtxfIP23T+C/C+VkYhYWu0Sx7lMOomrCNQnsMtm5kZxN9p/eXEjaPpMPeXaQMKZjqOLCgG
 pfEfvt455pPTAaEQRLG+9aZQVMiCAwjl71U3NaV5i5JlnxQHpFvIxqcm86oE3ETGFLAupQM8owf
 5yZbJRse7mFgOo38P7Q==
X-Proofpoint-GUID: ZixRtFhUQYPPViiUqxCuNtFO1VajYFVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160023
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

The current implementation of serdes_am654_mux_clk_set_parent() assumes
that the register for programming the clock parents is exclusive to the
SERDES instance. However, that isn't the case when both instances of the
SERDES on the AM654 SoC are used (for PCIe x2 Lane as an example), which
results in the second SERDES instance's clock parent programming
overwriting that of the first one.

Fix this by using a dynamic mask rather than the existing static mask
namely SERDES_CTL_CLK_SEL_MASK.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/phy-ti-am654.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-ti-am654.c b/drivers/phy/phy-ti-am654.c
index c3d9972397a..23a5d1483b2 100644
--- a/drivers/phy/phy-ti-am654.c
+++ b/drivers/phy/phy-ti-am654.c
@@ -142,8 +142,8 @@ static int mux_table[SERDES_NUM_CLOCKS][3] = {
 static int serdes_am654_mux_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct serdes_am654_mux_clk_data *data = dev_get_priv(clk->dev);
-	u32 val;
-	int i;
+	u32 val, mask = 0;
+	int i, j;
 
 	debug("%s(clk=%s, parent=%s)\n", __func__, clk->dev->name,
 	      parent->dev->name);
@@ -169,10 +169,16 @@ static int serdes_am654_mux_clk_set_parent(struct clk *clk, struct clk *parent)
 	if (i >= data->parents.count)
 		return -EINVAL;
 
+	for (j = 0; j < SERDES_NUM_CLOCKS; j++) {
+		if (mux_table[clk->id][j] != -1)
+			mask |= mux_table[clk->id][j];
+	}
+
+	mask <<= SERDES_CTL_CLK_SEL_SHIFT;
 	val = mux_table[clk->id][i];
 	val <<= SERDES_CTL_CLK_SEL_SHIFT;
 
-	regmap_update_bits(data->regmap, 0, SERDES_CTL_CLK_SEL_MASK, val);
+	regmap_update_bits(data->regmap, 0, mask, val);
 
 	return 0;
 }
-- 
2.56.0

