Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86011FD88F4
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 04:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B5CB83FAF;
	Wed, 11 Mar 2026 05:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="poiJAlOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8EB83FA6; Wed, 11 Mar 2026 05:29:15 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB6183FAF
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 05:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZQiuRPaWTmuHtfytsdkFLeY8f3tZMdjAM3W5RZ2yA/JYVH+ZiITQP+vDY6z1GxP1uFOmSvfw8SH3ANif1iRja/xtsnO8veK82j5sfLw+u3U2xVe6RzpEIZfmsfvFMfBKDUAmm4q7hvU5fMH0Cxcu1JPm61dRrYO3xBXyzOvSMKSmdU72jtz/Cpv0jg26IyfEKbbs+kIos1pk1FqjnrLPh4K68MP1p4PlK9ZKpKJ5nMLHmmp262hZk9pYACqXBicmpFH5Ej5QsR1bqw2jJg0vSeHbHmhs1CnYN1c2Z9X1qjVJLjdfIQiCuXTaO20ujj5iRIerYBcioEelxTJr0haZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+W34hbMtGLo3huNxzsvgHpFqzxj3tq680DnfURecX0=;
 b=roBhcJ2JIG0a4zhosqKRtPyzinHp2Q7GoVGH0emOYV2gw+AEOZS2N3CWQW8vjG2wsgsN6Xi7oIGGVVlrYRS6h3mLL3LIgUbHVj0VPnQbyCjKk/QO2EWCOLsRp2zwxrYkaq+Ak7ZyHhi2t6/Uz0gQmrLTXeMPXP3zqxYVeLvEDgPiRlhgDy3O49zENlM0p6krkFwX5/tn1Uk0dTbbf83pDCFHisUhrU/6p+Z2nHzymOkR8huyXDEbz5CBDDxdfDHKcNno0EgnpXhSKftsGCfBKCqA3e8OTd4+IRWjHHubHw1ptrxnEcBMN/9QzDCT49mzesN4Py188LnqzezYQmxGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+W34hbMtGLo3huNxzsvgHpFqzxj3tq680DnfURecX0=;
 b=poiJAlOE2tiURyjEDAdnfytAGOTNqAud+KAB2Ngw2o7kXnXJAUW5qqiV+FDn7RR7I7K7oMbQMOGh0Tdk3g3U1jwqbJWkTdi1W+M9iBDI5bBUviaREDJ8cBdje40A7e6bdMwSNgxJRwO6Rbc7+hjD9ZfHRk4Nvn9c67qxfq1uJKg=
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by DS7PR10MB7376.namprd10.prod.outlook.com (2603:10b6:8:d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 04:28:56 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::12) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:28:54 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 23:28:51 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 23:28:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 23:28:50 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62B4Sl103836436;
 Tue, 10 Mar 2026 23:28:48 -0500
Message-ID: <1238423c-cb59-4a25-9fb3-4935c0cf283e@ti.com>
Date: Wed, 11 Mar 2026 10:00:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] Update AM62AX and J722S CPSW PKTDMA Resource Sharing
To: Tom Rini <trini@konsulko.com>
References: <20260224120557.1476390-1-s-vadapalli@ti.com>
 <20260310175111.GL1388590@bill-the-cat>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260310175111.GL1388590@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS7PR10MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 362bfd26-f55b-4547-c75a-08de7f26b463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TS652Hqp0Vud46bNypEcCo+f1ECKG68Pt1Zw+8uJqZg4DXTfjlZYDv/sAydoWndQQtNK8tB9WOlksteeyuqR/JNDa/rNSmc3EyI3gUWVZ4wXnpQeJ8fxY2Xg+hIAOp2wsMr2xsaDCJTvNBxE5tZ+vT8Wx87gpKgsW3coC/pbNua3SWqBbn1qpFIFSNe9YY2+krF+Lt0uTH/e/qTDP4KHlBAyamiCg7iQH9YjMXGPCDc3wMAtmrIh6luDf/WOi+6/PFXmb+Qgcr6i8nEpovTAYtkJ4PagDVdSIvGzh93JlRs6gSsJLZtzPz1yZW3UpCqNM5dikjfyQsFQQKjHG+kOqdstNSJScwDHOIw3a+9k0Y8JOCL+aQGVZkjemCgs50MZw1Ni6akC37rExDLWqmUc/uvKG79l9JAlfWwOm9lJWFoJq/UVT61SMGJDav7qS7ailOp4cM9uYWhMA3GaAq9gHfixcqIGFUEzH+klUIuXL3HLV+dlLm7Rac+RxNJjw4EGHaBunyVxbQIVu8PXw4R2mTtroctCaUaAM+71BJDCtlW+DOR4agp8sxUkC91cKhD6gIUKSjgDejL7eutZhiNAkIRxifnTLSrFK/9ku8+cxCxfXGaCQ93gmmHEKovBqt2vHDCY7d33HdKhG7Vwp6vIITp7TpZnOC7H7kcpJltfAiXIOBK/R9vVxc89OoVkk9U0Ix1+8la86MQONGI5HMAARtNuXL3Qx5eN3G9URKXVJr4=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ekZskvO1E2H6IEGmtM/7N6HpdZN/MzQ3EvbjKMrb89eYIalpJDmSgi4GDidNc46K5NWq2Ya2WVA9Vyjs2dbQIpzUydLnYupyIdvaICCQZlSbLNGjMMAV1TK6AEkHr4DHpWkG3gKQoaPySu2zLqWahcg5AGfaGzspvRcymtRLtndUO4R0XO0RnAn+vd3huPvc+MiQYJAR5R397y7Pp71EMWEvZSuk61l6cKO0p58GqOHXF9QbfGPbZWJlizaScOJ5kbI35WFnTl/sGmVaPiuZ83ds31tczrQNH7cCuKmfeUSFzMFSuSPTm7yNy/ePYN8DwjWb9xIlRFv+tDdvKhtlKpR3RAu3MivCZnkmPzQl9p0CmGbRNjG8qjBZj7xCRoL/u+tOoymFZWbtOprT6apl2+DuxbEHQ/3j1fKEx9OC/RgKrR/QHFTyz7ZyiC6ZeKd9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:28:54.3998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362bfd26-f55b-4547-c75a-08de7f26b463
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7376
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

On 10/03/26 23:21, Tom Rini wrote:
> On Tue, Feb 24, 2026 at 05:34:46PM +0530, Siddharth Vadapalli wrote:
> 
>> Hello,
>>
>> This series updates the resource sharing for CPSW PKTDMA resources
>> of the AM62AX and J722S SoCs while maintaining backward compatibility.
>>
>> Series is based on commit
>> 4f70106beaf Prepare v2026.04-rc3
>> of the master branch of U-Boot.
>>
>> The updated resource sharing changes made by this series have been validated
>> with Linux running on the A53 cores of both AM62AX and J722S SoCs verifying
>> Ethernet functionality.
>> Test Logs:
>> 1. AM62A7-SK:
>> https://gist.github.com/Siddharth-Vadapalli-at-TI/ecc69e5d9cd3f09ca767bc2108ce1d0d
>> 2. J722S-EVM:
>> https://gist.github.com/Siddharth-Vadapalli-at-TI/d5b3509d548be194fbafb41480a6c15e
> 
> Please rebase this to current -next, or if critical for v2026.04 please
> confirm that. Thanks.

This series is __not__ critical for v2026.04 release. I will rebase and 
post the v2 series which you may review and apply at your convenience. 
Thank you.

Regards,
Siddharth.
