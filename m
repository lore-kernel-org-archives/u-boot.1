Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E40CC982D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 124F680FA3;
	Thu, 17 Sep 2026 13:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y1hinD6eKMxd; Thu, 17 Sep 2026 13:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4038580F81
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789651528;
	b=LAQz1xiOO4NrNQjF1s7tl/fnOI2WOcvLBd/mik3Ws1v9NE43uIc7TKPDCjaUdE4fM+GC
	 hiKTAk6eAZZuovrw20BNYI8HKnL+2XeHkrhJuhU1mPuRxA3piA/0gqZLgohKz3uV3bg7n
	 TDThzH5VNlmwLLP5QRY4v0t8uABJ1SvodIrs2NUMGI17TAAaHHgD3VuSQ43XapbXhuxt3
	 ihKLhu7aGsizffehCa51P+dAwrt6cg+06YSbs18KxMX24N9psatqd5JobIQMCddNaob/s
	 +hjfSviSppT1VO2xD8qBlgxXfHap8vaNMBGSnCtsRmXuT69mj6//d+QDX0xoonjBkRw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789651528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
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
	bh=M6TX9DsK6MjQjl6bTO5fdZuaQ9l7em68yhrDRXd/R+A=;
	b=lcVBDPW1CRXRvdGlymxvBqs+OSE7bkvJkYjektNF++6qJIzoj+R20oIMZnlcwbhzgJFF
	 Xtq2w6E55X730+EOcMW1P0XLHtRLrpPcyp6BRVd5V4poi7YjWk6rek5N6/cN1kilJE8BT
	 RUndQP8BRvjeVMfk/9BiNVjVLCZ6u7KA8Be6/0Og9T1EHX6Dfb0dPHebL0uBHCmw0ZgU+
	 2WyGatopm2JnHJGxWT1XbY4Kp0sxwEjGR1jaVEW+VXhzIHPtYzIUS0Uxm4kLGaS0Wtejg
	 6Oaezw92bzifZO+q7l65pvOx3NXIp6812WuwRyY71pQZkI2j8ABm4VdKZSIOtwoMAZQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789651528;
	bh=M6TX9DsK6MjQjl6bTO5fdZuaQ9l7em68yhrDRXd/R+A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyzgxqZ5ICNgo7/TcU+cDbE/SiNEPK6lR9EkBQVw6XwRxEFrK5v+EBxtIDoX4GjIG
	 xanbQSnfnSEpxi/tvnymr8ayeuJQ/p40DuRHYCNgC+3Z57BpOyN/4XeoEKRYZDe7ev
	 grHxjrV8+3OXVZCAQW0ak943cc47GxcN7zAL+frDIdwANHVxlqOXkfJCt9NtLdP7VV
	 gA8sxAxC+6p/p/VQUO78fjJnpqJ8StT9Nsr0EthrtGTcGipkj11uRZGI6I/NB3oUdQ
	 iLepBYjccsMg3reM5uG5kRzCnz1/sNzKLX60mZxdLbFlz/XpuXkTJ2+Rx1IFTEKCAK
	 79SoiboRBCYrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4038580F81;
	Thu, 17 Sep 2026 13:25:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 69E093AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FE07407ED
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 72SHsbNJ_Xx9 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 13:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 11F7E40715
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789651525;
 b=XwaJ721yWi0ORS0UWC1tFuRBkOHKcalgwbDfxjmP9VONk2nLSXYZsBZP9ujHEldBLOAj
 zBv5WqkDAYWZT5XJAOCfj9DiHu6zk2yp/aHlmGiXF9Sbhhp4EeoGzGkZ62Rb1shmkJfkL
 vD8K8O9a05C8DviLBJ7kTDjnbs8eQcIDrkeRaJnjw4imx4D+Sukt5BHIBePetbdhcnYyN
 UXabWGOJTOfKQvMjn9GWvzUI/Swv3DxmvqsDUl8bYVbRgrhHDF6XexkbYDjS+TJH4lt/L
 X2jRIYuGgDwULTX/tGWHoZ4oqVX975XJHbm7Ha+dUbLdSpW2wgn1HQMaXs7JNeX1GgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789651525;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
 bh=M6TX9DsK6MjQjl6bTO5fdZuaQ9l7em68yhrDRXd/R+A=;
 b=XQ1qJV+0xPDjCem6ZzJpMfUYVNt03G+63/xnGrTpd/h2U67YIZ33jQf9gc7an5s20F/X
 +AzvoiAnXLHTKUMx9sbCqNAyE7gd7GLdXloGwO+AQaZfX5tOXWYxMo6YHCrwuVIkMKQak
 onjbBr7nnKwu+6aRKMXOGC8oZruLENP9iASa3pO+If6q9UHzMZkuG6yH6iAOlUngiOj88
 MFdlrdyFRS4EyfqGioUMce8OwznQyl0bZ47iJ9HGiawwgqbzRDKi9SSqOoYpOAxUXAduY
 Y2OP9KjkNIdsciTpgOh7tWzCRLz3PXAz+bdyIgphBpyAFKhm4/PXyforsamguCyJxGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b="RK/hBo2U"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=RK/hBo2U
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11F7E40715
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqUrGvO//tUpVdqDaj+GJnYCeEroOuAlNxzpojN7mvvstx/WErPb+I0F6phw+XzrefF7+TL71KE3XMpBAqffqkZPZzz1HDC50SIMHNoVM+VtVfhbhhwfwlz307CGk0DbIjxR9fjfJvvkxF1pwltQF20jO8NL/cPNj5qC8IOcuFYwOq4JR2BzuNyU/gHCUo32XHrS2BmzicaOnJ5XNiZxoCa7nszWbdzekfjUVkndGSDWEPfhiWBNORA4dggMBATzKvFTXBBpNcRzexodH5OogeLwDbbxYfvyKzuvuEP8SNjsb9qJuQEqAzJcx3D1T20fTcrfDKR2wsAWYDbwTkwbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6TX9DsK6MjQjl6bTO5fdZuaQ9l7em68yhrDRXd/R+A=;
 b=utbx9EYEQjCaCkJYRAAN9RKoWRKTLMCIDzjdkpwL5s2CI5b086Ddtk5mrQdcO/8FJp0Q401olRQrNUMd3HvinBjgnqba/9/K6iIPhP7AsaLXqck0c+Lqdq/gi6+gjsWqhxTghejTmkCcmwViFZwGDdVu53vOal7zeewzfincYF360uzcaMuuO5vW2JO1c6r5ULorPpDI0Kf8DVzfJKKlT6tTlOxeoKr4Qu1N3dphPN8s2A1wAgtqGzspV5tiDoZxnEexetibeK5gEUvsXKFUiIwLs5E1P60sKaw80Q3xjyAUasVS2roiUZqJC4/TN3FGUkZncQn62IwWt4r2MZuHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6TX9DsK6MjQjl6bTO5fdZuaQ9l7em68yhrDRXd/R+A=;
 b=RK/hBo2U3cH8C4Uf+hWzb+ciYDF7/K1g5VORakYZM6l0ajSMWrStGHcxmcAQDKxMKAWYrylq257+XAWoehh5egC6QkA2pvCg5Ce9F2ACGlvujUaUPe6C7ckWXWL5eFRtXLlRB8CJIpJhVGOBXISLCpDOK+f1U4AIij6eolWH4vZnQWEdOywUTcBBtS3VE0+9qb4I7LBBrZb0QBh/I7NcNAFrNLVL3h4x2BfTE4y9Mgme9rhYaaUJGawZLCcdHFRqWcAbNYHRxbhRQGew48mg2m6FcSnaTskU1ZzF4fyw39uuPC5uUmfXPfohQE3a7o1zO/aWiLbDIfppwqA19LOUZg==
Received: from DU2PR04CA0289.eurprd04.prod.outlook.com (2603:10a6:10:28c::24)
 by DU2PR10MB7883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:491::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 13:25:16 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::50) by DU2PR04CA0289.outlook.office365.com
 (2603:10a6:10:28c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 13:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:25:16 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 15:31:03 +0200
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 15:24:58 +0200
Message-ID: <5b6f9d4b-7a20-408a-adb4-0e82f7d4fcda@foss.st.com>
Date: Thu, 17 Sep 2026 15:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: stm32mp21: Enable CMD_BDINFO_EXTRA flag
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
 <20260904-upstream_update_mp2_defconfig-v1-2-695c0abaac73@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260904-upstream_update_mp2_defconfig-v1-2-695c0abaac73@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.100]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9A:EE_|DU2PR10MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: fffc739f-ebec-4895-58c1-08df14bf1d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rNdn9KiwfHbcN7muf1o8qpJDIRRzTTdMxOF39rar7qNU9m2TFifpy3S8OIXDQMpy+VLiwJr8shfrr/t90/dMIh99G/fymMvyejPy2OvxwoT2KGYz5U6ZvzLQv5Nbu8tZ4qIcUsAyRCK2cka0BmFeTU0mMa2BSsYFUr4UGXvELuhx2589WSRDNQDAwqZDKDW6Cr+vwzOij9hhQcP0scruiT/Ks5xI+Km2bOjSyWTZ0XJttr+aSXES0QZjh1riTmL9zxA5JLrpnPnxGoLnRRKkGpKZlyd204jRj+VtSbDkSAaD26zV9reCyr3nsRRbAHGmCR/JSz/O7lVbIBiZnnIf5p9OfJuSf4VNzqCObaQXSfZ+dbQ8wVGJFMX9zXFx1R4usvov6Yqt8Xy+TTONt9w+XNhMx8EdnKVPjS0JyzwiOLR6FwN2+0UoSG+MB3eB3rfi2CkWF0DreB7xTtBWL9MZjj8CZTCxfz+037jI03IeL1hTSeClEHCE8ZD9TdL2UoWygf6o+2HYYppajGTvhVYwuMt1GuLYoXMKCuo/fyP7OCf5Jd6qjOO6aSf7OYOYYuifWg1og6wyikXy8nPM0bKLuFKEqzj4MO3QEY9vx65ndC18TfHU1JsgwsPt0+H3ZsFTFIcgG9NnE+b6oqhb4/lfBEFSeEMCnkeLFQKaYCxazqqYQ4ApI+DmFJ9pJKoRYyrLd4jt9AVbx3dZ+gtm3PTDPg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ElpLqPc3IBqDPpIA9vx0rYHfPCpKnFazTxolRKv59kO65ojRgh8P5v+IqKZQDG/UIM4VqqHLkhjRfyTJ3C3KjTVkEhg5tf5MxbeSbRxqk455WJtRnmanyWC47HgqboZ2LwOJMaDtpWTXGU4NGzVApyz+nHYPCXKgpcxxIuBekmLlH9t3fUslOMcDInV4SRBwl4KRIh+ww+N0NHPeHAW4tSR2tIuzNJKnSk1WiENRi7DVgJhjQZEW4Jgig6zOxSDOP2N9X+FvvcKyi/Rulci3Z9ryW+LJchY/VsY66AiwQ9O86fb0vb9ngkPRq2kpe9CQKuyMBQ+QtNaX6CfbwC/z2VFueZRkMKxGWpOCADRvLyqLnBbTWdTiJ7VRw1PG4IhM8EzNae9HofLUgk4ZBigSC8RKWMeHAsuuunIwhC7O3rdbFWpkG+1fYmQMM0lJKrS7
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:25:16.6995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffc739f-ebec-4895-58c1-08df14bf1d05
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7883
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

Hi,

On 9/4/26 12:18, Patrice Chotard wrote:
> Enable CMD_BDINFO_EXTRA flag for stm32mp25_defconfig


s/stm32mp25_defconfi/stm32mp21_defconfig/

minor, update commit message when you appliy the patch, bad copy-paste 
of previous patch of the series


>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   configs/stm32mp21_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/stm32mp21_defconfig b/configs/stm32mp21_defconfig
> index 6a74a435f8d..22077e1291b 100644
> --- a/configs/stm32mp21_defconfig
> +++ b/configs/stm32mp21_defconfig
> @@ -20,7 +20,7 @@ CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_BOOTDELAY=1
>   CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
>   CONFIG_SYS_PROMPT="STM32MP> "
> -# CONFIG_CMD_BDI is not set
> +CONFIG_CMD_BDINFO_EXTRA=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_ADTIMG=y
>   # CONFIG_CMD_ELF is not set
>

With update of commit message


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


