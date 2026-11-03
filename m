Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2182606A330
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u5WQJuTB;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=b4gQVsX9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C09C780CA6;
	Tue,  3 Nov 2026 09:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_3V-o9pPSG3; Tue,  3 Nov 2026 09:09:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DF9280C6C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793696987;
	b=hwQPrV5Eq4kJEGJLnfEzi/pceq5XobsL6qKDQnIr4tEjabdGNni/GpafrXN9QSEzVGvP
	 JSSRcnJuvx25wnTnUngfQWkDcwN3EH3aqQS01KDY/kiSzBltO6kO2FRbmNkQKhqQuw4oe
	 booT07gngA72Wk/wQGngTQS2pTh3mAxCXkAYjlzitT8eoQXHArQWebJ3IC+x5SCm3x2RW
	 ES9NDE9YR9EcZe/9YqvTpTTo6nEGEpin2CTcnZmt4y5Xw1A9JOhEAapx/PNZpWK7KD5k7
	 zf526wBCvIJH7et7KXeHWuISWyCu8VrJDDH6QlBR3qphREQDpBsvHlZ0gUHsCx5knsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793696987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tAfg3L8vnGd//qxH2WnQEmKpQTzgCRzGyoBj/hHQ2W8=;
	b=IPsL1m1inCWMl8XK/adQLZIB8eadTo/0IetfvKwLI+iJd+wULjeAT3xYVLHHIWGxmcLW
	 BwJdeqaYov1VS3obFWBKkDfSU63KD2qBaOSw48oBK8Ob3BcASKSs/l1gGuIpsU7mzYD9w
	 z2v4plTLFRYn4DRGMqcG5Vy+OualFxQfgij4LNbCjl1fRIalXhD6j8Nx+fIT83qFbRDFz
	 ajfNrK8cQVYEClIOYFLvDvAe4/mfa3Esyl70qIaplTefRJ1SfqLizG9Z2gFGGYHzCO8RM
	 Xqpy/mrWvX3tHIERe10pnvB45epywXHZbF1+2ZwpSRbYlDT/xBE+FvQm9FJHOeuczFw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793696987;
	bh=tAfg3L8vnGd//qxH2WnQEmKpQTzgCRzGyoBj/hHQ2W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u5WQJuTBpxbjoS01PqFAlgKy+D22xH8VbHO1XLSzYWCYVYmcV6duZyx9YXDyVZBKX
	 VTzLcP6rK/SE3shYER/zc9uRKKZ4R3M7a7xBqZ6fApAQEiDL7Ihq1GI5dG1E04YheO
	 ZAE+JY7KkHV7qZSV8oysZcUm7VSsvPLDrmWoNP23F02zyCe+d8AOYX6KyMIQTY/25z
	 q5mT7Ri6YRiA+kvD38aSjFv8o6TWJBOrnNdx7A9fsFVHsdX2K9Om+mw16/384PV8lB
	 LZOUCTcWEjmL8tnzBQhRVaa+xV4ERzSMUCUdEWyz3JuyEwpsqdbK3UH9gWWkvRu2r7
	 ZMnri+P4K0e9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DF9280C6C;
	Tue,  3 Nov 2026 09:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 44E32A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2222B40218
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZd0XK9Cm86C for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1A8D8401DB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793696984;
 b=K40n6UWe8lhgdA2W8HSDEAzI3LmT7XfTepMEzdMB1CEevI/16RFWzSsuOVfrb0r3n4WY
 meDOr7mpiST6vJPR29X7IIqw4Qms0piHQyf8VyDKZ0OIxmEJXSr0MX6owcXcsZzJacNAj
 iUpXC8m993uHaTjuSemA7kzfAbF6FHRM5nQGzJdOGAMm1rKxiUqlfhkWLzE7ccvD1biUO
 Y2LmSp8auPb5p0m1FOPMhTKSTSl87PK8E2BD4o8INCDYVXaExF5qo+3Enfh/hCPJrjbZw
 YeYiRckoYUomF3YkrAxZvw95s27ITE4bMBheAI1/ktCO+2n3p9EXYBI0XxmFiYNwwHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793696984;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=tAfg3L8vnGd//qxH2WnQEmKpQTzgCRzGyoBj/hHQ2W8=;
 b=VzKUE2he2vmw5xTWVYQA0owyugZf7+9KSO0Vq8X4IC0/OLMgHjs2AZijpt6e1Yss0kfd
 46CFiNVtxI9cyGa+hYiPmDxL5ObsTLBOhpgPCzOD5l4tZ/wDYOWEnU/y++v5KcxamEMe4
 asTJDzo/qWb/KQULOW2xG6Mfjkur5YYrAlWOvlanvrYd4HqRpOY2DTe6rFt0rXHQOOrUE
 fntVPSayt7aFywuiMBis80tt5AHq/jCqyL3ZjqCT0g7kCbaGHtf7qdoaJEugE1NHyUY/6
 gPAlYSBApMFiVEsw0olG3hEQTwGsw2UEtDXknTxFzKT3uxgh786KLjvPECsEbFopvLA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=b4gQVsX9;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=b4gQVsX9
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A8D8401DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFdlNNCbRxPfTLLyRPMz2e8dAfljGHxrqFKiTRV70N5jzdw85uRnY74ECWsCT9qAqnCJBXDSRQwpz9QsugEdCzrq1cwm5cAtHms6cidFs1GUnsZra9RhZmSGVeyq7OV1LIJzeRaTVlyG+cItYWmhMgnWYGjiQ0LY6Mr15oH28NDaE2OD0Rbo935n4Zr13EcJ80KDDz9VJvfZOGKtZUMK+SkPn3MZ7tDn7Avv8oifck3gzJ2VkqPfuXZZF1XymfC574E66eG8Xn8I7bWR4fB64/Bmba7Mol0UnIzPsGc5l/tYZ5BDB2sKkiouDrOiN3xWl7l38fqJA/IKsYcJkWD0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAfg3L8vnGd//qxH2WnQEmKpQTzgCRzGyoBj/hHQ2W8=;
 b=kgh6iJqeE/06n9PiTLLUaZgvdCQO0EqXtvTJuzVpyAeadjUguYX+fNT4oISl1dkpmRKs+ePX5qOpY/MgFl706xBEHSOlKomiprfdtuA4l+539b2cJ53mT99idvcOIXl5J+CNXAVnkqu8QowpD3nIu0p5WuOAAQDLV6KEX6wE+ByQh6MvU8lB/u+tFTaakBGNAluQ4DRP9tMntVViWtscoXCgolUTiG2K+jBpCJpf097sMSVVkbAnKjfEZgcctmGv9eD5G5q4qGMIDbh2w1phrcSp8jfw7LneJy3nniMamKeUxg1/HkfIDoPHb4X43gtoXDDjLwbNJPZEBuDTi98Wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAfg3L8vnGd//qxH2WnQEmKpQTzgCRzGyoBj/hHQ2W8=;
 b=b4gQVsX9pJsE/R7oRrgHTEENfycm8KRLQIZ4Fkrv9QywfzwAcRwp9BV/h+iQjglyGI/GnuupODGq44dq8jQNfRlaDFunQtxl4xrWxfHmE4U21Pl08X+sgNFCkoLuFEKfnd8Fpg0Xcpff8deZBxho+gldwatuZdeXIK/Ax3ZhO3Ve4C5QamaihSM8qOOmcElXcsJaA28Qng5rOcPt3h1yX+1aeWobTRe+KLiYNIwHLQPuJp0nmi5T2QaAe0JORaCAXaIpDx9HKfkmoFnIweFmAZPoqmyyquLoSY9sKpP6U2ZjTRQwR3Ud2ZhbkTlBrX481DGnm5JH+XyUYmUQsaYMjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:09:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:09:38 +0000
Date: Tue, 3 Nov 2026 17:06:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board: nxp: fix memory leak and check calloc in
 ft_board_setup
Message-ID: <aumkD3pcPnEw3jL8@nxa18884-linux-1.ap.freescale.net>
References: <20261023030353.153360-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023030353.153360-1-oss.patchbox@gmail.com>
X-ClientProxiedBy: SI3PR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:4:297::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: a5072622-2efe-4c6f-d363-08df398a2fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|366016|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261021121427099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: qHigwnT3+59loGQpbMkG+naVGQXMYLoS7zA7Avf28z5fuXxtkCUEe2Bo2qDedmVgD5UrQvswsmbimkAJ7nuj7gFv5RBKFgMDJ/EF+Fd9tlIxbEcnEtHtx9ox+iaAkvXM2Xt2u30JryeJSYWas5KqQLijfgcHtrR1tdRWolg3lqfyL96Lo7wT8D1/79oqNNjOmDTs8rttffBu6piNBwh3eHm/FEZpaRkFgMeT9BfNRyCv0V/67GVeU9QT9ldoHuRi3YMEqbuD1CUPNXnYrISPnF/H5YZsIS+Gy3QosxqlsqYPMfXUGo5Trn4T5nuyhEhdBHiyp8NSwykhf1wH3+7Hj8blFxUQmlWWjmIaRqsVlbBDaAMk4UskvPlPHoEY0XO6xgaz7Prw/4Ig0W8Fs4fb99BynmtKp5XnUaX4C86nXeLdP7Yvb1pDm+YaS2DW+LSfBZ9FTnOL/3O+EOq5Zs+iKr5laJS1zHuUQmVL1+lyby4sG4Z83Tg7rBVdz+LnlbSjqnPmdcvrsq0IFB6PqWIqPsY7aLA24o8+9erJAY2c7LT2vdA7DoWjb0mhryT1O9oWhDrKV7vvl1LdAg4fLcisAFd23drE4pgx0p4tb9JlqyDEMplrqujWpVIgqjVy9+hmOB6dnOwWnvrZm1rVndrV4q/JyCG+pSKm3p1FlERz0yc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261021121427099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uU9UU3MqWxrV6fKFV9mhMoqhbKtmAOD70uKfVHt/REu64IsZ1aaR9PdYyb3L?=
 =?us-ascii?Q?jc9exNZS7y/59V+6WdwHNSIfC2QsQ/S2lQvWRf9xMNexd1/KqFsSl2niSsB/?=
 =?us-ascii?Q?99XgrLJ7CSypOFiocI2o8PztYHUhOXEXU2Xuqii2bpI73O50R4TP6Nh5xZwu?=
 =?us-ascii?Q?DqktiGCIqEbfo6Zse2vo4jov32kjipVXWWntFljsKGj6iKxnHDDrWr+kr87Q?=
 =?us-ascii?Q?RSxBkQasq5kPVZWOycEmLZ7ronBEYDGSRo5Hn/vKC1mCnU8/zpJ3dT6UivW0?=
 =?us-ascii?Q?vdYocYQvcaB/MYsVA8/L6kOgF2mu9YSrBgptSKcnHtjtY1/lepwJwY1Nrfrt?=
 =?us-ascii?Q?aTxpzOeAM1TbcHalaufrU4ghCnCJna2pgXPBINuK+gN2dKoI9oHdPiJUkHlK?=
 =?us-ascii?Q?sLyGp9xfH1mChhcEQ5YkdODpbX3Hat6DYUtar/G8LW1OncgHsSxCPrDuERRH?=
 =?us-ascii?Q?AI8xmHwFU86TK5d2UXCyQKzQ8o2+2C9duq9/Qm9Vjfn6eIKnU6IJCu3wT3UX?=
 =?us-ascii?Q?37fm6Un7xfV31jVchMOiqTbpP+zQOEo/SZo69TbW5T8y6X/mmJ5+0fWjedLi?=
 =?us-ascii?Q?BQ+mljD9V/O02q+Z8FbJNJwv5LmkOrJlp+7SeYUBBMwjY0MDqOIeLdZ4i/Jq?=
 =?us-ascii?Q?ozuh77JxS37c7NtwxqCBwFdc+fPhzRR1BUxyYIWT7f+aTTv9gPEsuJlL377H?=
 =?us-ascii?Q?38mnqAwZDGGpbnmckr4NnLJSN9AVBZc+6OjDVrKZR0SE+JoumOWvx6pCVuok?=
 =?us-ascii?Q?l4wePQyM5S4bjL5BOW7Pkba4vdIwRBL9Wjzu19MZH1S2xfSCiuW2qIjzl4Mu?=
 =?us-ascii?Q?zq/pRRSXvJZ2d57qtEH3lyHVJLIeekMQutrMDNZiTCTIU03uzItiDccR46Gg?=
 =?us-ascii?Q?VOVu5v9P97qxNjh10q69tKLNQS+kIr9JKElwVKjw2FCrb6XeijV6N0WkoQvJ?=
 =?us-ascii?Q?+an+GeSeOYWSZs1erQHYYKUR2msGZNGwrLUG715pzSD3agEE7ObkPzKyguyR?=
 =?us-ascii?Q?E74bZtNaLaEfAWFOyq3ZyjvAPr0Ywq6tYtivjWi34rMnVcLSENE9QaLvE9bn?=
 =?us-ascii?Q?n0YXuna40o6tJnGymDL0F10K9ZMa5/msLT+MUhfnFdXdjU59px0yFGZFZqFt?=
 =?us-ascii?Q?Rxr4qJ+W8oOp7Y/W05Pf+DNYmGLjHAsDkFzIs/BvdofCRwGGltwqqk6TbWVe?=
 =?us-ascii?Q?4sxfmtT6bH8XqoZoXV45c9tmrfGHIUHyMJMBOc6wdKqjyiuS7MZa7gZQmEHA?=
 =?us-ascii?Q?xTUzyJbiafXyJYPah3Vfqi667B6DBkm8G8j3nCPQ7S5iMD1sS92Mk2AHr04X?=
 =?us-ascii?Q?UOcfYU2kiBJJfBz6x3LfI1j28J+nxpqG/Ltvo5knnqmyg6o4MdYag5l5d5PT?=
 =?us-ascii?Q?uGrqspjxyfQdPFl5hFZ60CImVlh9lFPeQcsw4f8NLxQF8WcTtM46KJX6MHnK?=
 =?us-ascii?Q?o0bUMS3ehDsKC//d06jPvzXNqpiJGrGkSuw4eAhqysd3kgn0MuEEjmUzQVRA?=
 =?us-ascii?Q?zF/fEwvFU1XykLDKSIJrXx1x43tbwtBZgK5zkAjn3PW3VXGUCcThUsl9D5SP?=
 =?us-ascii?Q?OrKtx6L92qhne3dl5FU/RCtE703L5F+gbkMlbgrIHPu8ZDLsdRd3UU8c2MGC?=
 =?us-ascii?Q?Cdu4yOscytyLda+l7ODfUCgI3lMe5L775KCOac2D1rKn9z+Mw9gY6eYz6KEv?=
 =?us-ascii?Q?2/l4CooGDJ1A4O6BnBdpQUJmQ2QtYnptz7SyyDjALGWlSJKSatk62vzklQ6u?=
 =?us-ascii?Q?9+zFwFFJpYA8KibDZuALppIQE7GJdwLJBGJFVp51Yv7E/6Ed2KpE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5072622-2efe-4c6f-d363-08df398a2fc1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:09:38.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL7uWW0GXwgKv+MV36BtU/lP119XcmOdBEy5uYTLsX1U+vNENBwxXso1X2BMS+r3FaW0Jvkn4wfrq31fWLIp3usHAREzYe4R/Bsqjh867d4Zl/gRgj/DIH02oO+WztMg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 11:02:39PM -0400, Yuho Choi wrote:
>In ft_board_setup() for NXP Layerscape platforms (LS1088A, LS2080A,
>and LX2160A), base and size arrays are allocated via calloc() to pass
>DRAM bank parameters to fdt_fixup_memory_banks().
>
>On LS2080A and LX2160A, the return values of calloc() are not checked
>for NULL, which can cause a NULL pointer dereference if allocation fails.
>Furthermore, on all three platforms, base and size are never freed after
>fdt_fixup_memory_banks() only consumes these arrays during the call and
>does not retain them. However, neither array is freed after the call,
>leaking memory regardless of whether the FDT update succeeds.
>
>Fix these issues by validating the calloc() return values where missing
>and freeing both base and size after fdt_fixup_memory_banks().
>
>Fixes: cf0bbbd1ee7b ("drivers: net: mc: Report extra memory to Linux")
>Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
