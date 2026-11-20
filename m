Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06D606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D3YxTmMg;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=OM/LCo+m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A68F8169E;
	Fri, 20 Nov 2026 14:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uUtNtmE69wv6; Fri, 20 Nov 2026 14:56:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6A42816EF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795186577;
	b=Kk28f6R+9lHZlKZCz8UhsxKkALvUulR8gK34EkZzfq0d6oLNXntgkqv4FSwZfIznpMkM
	 xLHR7rodQOMji7YKfk0P3QKcA9URaj3g7aGv8V9p8xdU05nPCHT25H+P8n8tmKVCvHli0
	 fdVMspV7phWAO4vVA+6ipTzoRAMou1mtkEtJvSJUYhzal0sGKDLt4bB5ivXhK1UW6k5EU
	 gNbAx0mxB0cYOkaYN92riz5hBgN1IbX36PpLno3aT/lMhUKTzutd++04NqrJIe9GyeWLU
	 xe6EGnddErjsV0PazjbLTNwD+c4vG5VXCbLD1ERKSpdSPxgab0SD/lg5SKEVpYZ//HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795186577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=xRIhiY8sa7cTDZ6zxV18IJbuXkYIBLAgA478O7vFp4g=;
	b=px1qZxBuJ6azbXsJO5bBHqYeVXdQRJkaUyS3gwsQUn/+npbNzWoQJk2SO0M1gmLE6wZH
	 6fJFjed6f9V/3ZF55CzRAyxeoDE6u/ykpAmbI9sz65EDnwG8g5v2wf4Rl8paalglP8jpB
	 luXjsHumu/d+7OJEVF8njjO4Jms73QsBH0zo5LVex1ADAD0bHuRoZ1K32JS+1+o0orBgT
	 CwYnPG+wBhwZugWJgM3Ctne+OtZ9kxEJ+gFutmulEemF3TyAmx0aYPcTqgD5iA+9dEYrI
	 dax69dcsZJKIa1V83rdGmanS95lMeLKNTsCkZhombtTuq4BwQrhF3RrtdYgJDr5/yNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795186577;
	bh=xRIhiY8sa7cTDZ6zxV18IJbuXkYIBLAgA478O7vFp4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D3YxTmMgvrHRYyf67jlbOZCkhBLWxDfJR7nojZLPleQcM58P0Jagz8aH26e+V7tGL
	 mgnFpD+KQx8zENBX+jmRa0x2XMqeKQ7NBCY/YqcbPUCPVzKtGjoy50tjCmOtCdoqhp
	 0zlQSfQzj1agRUNGKNAedvr6EyzHMyRiGGzjnv9nG/ZesB7wbBPtoiv8jQEJ0XKHY5
	 YE21T02nIMcE0/5GEQyt0c9NpqET17RPUqpwkjDVTvGUtrcdopi/aQ4CZm2Dp0tOAt
	 m0ftvHPYLq4WW83RnFQVGRZi0B8CMCQyRWDirfn4R8glMFRFiEVEVj237Ox8cyAaVD
	 /X5fNRh1Ahhdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6A42816EF;
	Fri, 20 Nov 2026 14:56:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A698AE52
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97C5640176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q57Jvily5K4j for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 14:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9614440098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=OM/LCo+m
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9614440098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRIhiY8sa7cTDZ6zxV18IJbuXkYIBLAgA478O7vFp4g=;
 b=OM/LCo+mpqmP8fCZGTRGS508JPCGgMOzbj1+edQ09bYNfvasJee4i3AmQTrD9KIJnnOjnn6oXwr5li2RbHvdmSZZwRohBtzN20YE0LS+5LdxHx8i8XEv31B86jcPZN8AE9aUxf6OBTVWSqHVVyGISr3O53/wdqgDjnoJkteM9NQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10850.eurprd04.prod.outlook.com (2603:10a6:150:216::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 20 Nov
 2026 14:56:02 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 14:56:01 +0000
Message-ID: <0042aeba-1431-4736-9f59-e36454b026c3@cherry.de>
Date: Fri, 20 Nov 2026 15:56:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] configs: pinephone-pro-rk3399: add a DFU alt
 setting for the SPI NOR
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>,
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <ag.dev.uboot@gmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
 <20261011-b4-pinephone-pro-defconfig-v2-9-6b7be35fbee7@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-9-6b7be35fbee7@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0081.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::14) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2fb56b-b972-476f-36d2-08df471664ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|261009223027099003|6133799003|18002099003|3023799007|261021123027099003|261022105027099003|56012099006|4143699003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4E8F0GaEb3zeoyvjN1nRLmbfWXp219mRFH4acT+NgWyZUc/7XnLcdOcT6fdVjma65G+IPuF5ClB7VmgfCzRORQoYWK/cIO/TGS5wso8eLbvis12WOwyZ7xUw97IBH+aWjXzePyzAHdFXhMC6VO1lbucrW1vSWToBoDdz9DIeZ/5MfMF7SqTSDyM+6SzBtKSgTcUQeYorjg/9THoUJns2XlKUpmoq+8uKpKnoeRYVqhex8QRT1QSBKBmpmLIqtvF2Mv/JpQOkqBQsPIDZTctN62Q/RilRCrhXD30ovG47KgyRoo2ahkkZDkzctQTRdAUWKWeUqcfVmFSXIBT7SYrd2V+A3ru4RmeWDQ3TBhK67pfYg/2vyFd9aT1H2jiM/EDFfl2TFcdC6gGB6AnCOTyJ0693gBkDPiZgtgsus98ATSXp9jYwJ/eqSqnAjquKaTFY5+o9UxoqfFpPIFmfF/Xhn6H+wZGpqTP7VO8twYJq6iSaZu2akzE9LPws93QQgIR/dtAtfHIX87SK4m704i8bACvDfDF7Grw3h55h0qrJM60eBDevR2I0VZYH9pN4aeuu/G1EnXhTg3fkWpqFn2SmwhrpLeYnakhsUqZ9k0I0E/Bq4w/fl6wh47GLuazay/5QP+9tF2LXl+Pet+epd8QVYC6EXQAck3bXadRisLH348g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(261009223027099003)(6133799003)(18002099003)(3023799007)(261021123027099003)(261022105027099003)(56012099006)(4143699003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRJeWlBc1BhaWxlampzdGdjaWFKbFlNZkMvYVo4WjVIREpSdnJoN3FTRnlY?=
 =?utf-8?B?WXE2Rmg2Y1ZQMmZWZ1JVZVdsMGtYUVVpclJJRE1ESWdObTcrVTZuaWFCTDY5?=
 =?utf-8?B?YVdxU01kUi9raFd6d09iMjZzQzE0czYvOFNQVkxJTmhmQVRQc3NzcWRyUUR1?=
 =?utf-8?B?Z3JtTWE5WGI3dzc0QXBmOVJIeGQrVExLTWZtN1hHa3cxTTZXWFhmK29IVDlQ?=
 =?utf-8?B?ZzJOM01MUGZqWTZzZTlxbCtqRTVuWWdoWlVtcDFIN2k1WXR3VzhTSXN1NjMy?=
 =?utf-8?B?UndDc1JuSnI1K1NuWnJqVEJaVTVPL3cvbEhSNjFScUNmMmZhZTJnbVIzRCtz?=
 =?utf-8?B?VHJ2bXVOcVQzclI4bWRGa1NJenRlNE1Sd3ZkMFp0OUwzNDkvR25Pb0d2YUVR?=
 =?utf-8?B?R24vR21VdGx4aVJiRk1ETlhHY2FIL1BrWkREU0xSWmZuTDRVem9WTmpxV3RD?=
 =?utf-8?B?cWtDYnRiOVFlYVZOaWRkNnAvZGVxWC9UTU0vTFl0Z1pWVEFVblFPWHFYc2hi?=
 =?utf-8?B?TDVFWE9HV0JqVkFzUlhmdXlScHVPQUhkbU1RL0p3TStYdHBaWlVWcVFNcDdZ?=
 =?utf-8?B?WklYQkRPeVh5cS9JZk1Da3JIWFU1bzY3MjhWeXB1TEFDekozWldTa1lyTUY1?=
 =?utf-8?B?QS9wZ1F4VmdZcVZKUm5SQUxMZ0pKSlFIbkF4L3dhaTFKS0xFZGJnNVRIbjN1?=
 =?utf-8?B?SURONTlxOUpFRnhLbWw3TWJyRVlKenEvZG52MzQ0V21ma1ZMckRySVBXU0Nw?=
 =?utf-8?B?VnZsakxTMzB1WWhKdHJINGhuWUxVQTNKQ2lneHVkcTM4RnJYMlowRzNqNW5H?=
 =?utf-8?B?RjVCdTVxbEJWakV5RzFFVWxZU25IaEdLbVpsK09CZVRGZFdxRUluekhDTVBD?=
 =?utf-8?B?bkVkSU56OFl1Nm1zR2R4L1VJakw2WHFJQnV6UHVkbEF2cFAvNi85TVA4Z2x1?=
 =?utf-8?B?RUEwazMwMzcrdlg0Vk9pVU1Bclk0Y04rOStOdzdhVU1HY1UzRFYvRUMwQXJt?=
 =?utf-8?B?R2tDTXFHVGw2Q3F2aTZublNFUU40UUcrbFFlU2VKRHhpdUpxZnUyVzlCMHEw?=
 =?utf-8?B?TnViQWlRS0d3TXV1NlBWSU03bFJTcG1ac3JzVzJ4djRPVytLYWduTmZ1MUNH?=
 =?utf-8?B?UEtLTEJ0TTI4TFBacit6ZEZsUlZ0cjFaY2duMWtoUmR6eHdROHo2VE0xdHlx?=
 =?utf-8?B?VVgzWmdSaVF3K01vK0I1Y3lYUkdBSzVEQjViUndtckZ4bDhVd1lEV2xNZ1Bz?=
 =?utf-8?B?cFBOMEl5STc0NXhQVFBnZ1lqSHJCZTNvZ1g2OTVrQlg2Nk5QUURsRXhpY3dY?=
 =?utf-8?B?Mzlpc2cwQ2o5RUwzbStJeWtVaVEyTy9hcmRZcEVNQTMzblZVOHMwTFdJazN0?=
 =?utf-8?B?cHdVSlBsVWFpdzZHYmlpejBiQTJ1OVZvVjdFSkx3Tm1uc0xZTnRPeGhTdTJK?=
 =?utf-8?B?Yzc5SHh4Y3BaemluMHpvejdiZFVScUsyMVp5ZWovMEJXRzEyU3JQcUJHeVRo?=
 =?utf-8?B?aHpZNy9IUFZ0cmhEcXhjRE8zejFlN3MyZHdCUlh4T0h1dE9lSi8zUzBvTE9W?=
 =?utf-8?B?MjlpOUZlK1pvaGlvc1RRL1ExelNWQ2cwZW5iMmFBemxKekRVcnc3UjJ1SStV?=
 =?utf-8?B?UFlVSWlsR21LaStzOGIyZ0EvRXdUNmc5V0o5T3JRYXlsVlEyZjhxOXU0Wjky?=
 =?utf-8?B?S0Q2YjROL2pFakJaNDgyUjcyTVFPam1odGUyUEZXK0tJOFJJSEUwLzd5Q0I2?=
 =?utf-8?B?RVNJak01MWJ0R1hHNU8xYUVIWDRoeXZrZ0hoNTBqeUtiQ0xrVGRmUXJGVVY5?=
 =?utf-8?B?NVk2dzFDTWJqd2hTWkx4M0grZW5FOUt3cUh5ZXhVR3RUNlV1TDZpRCtMdm1F?=
 =?utf-8?B?MVhvdUxzZ29CNWFMMWFmL1FVNHk2YUVuWGNKVENrelMweFBncHoyS0NnaHZG?=
 =?utf-8?B?MjJSRWNKRVNYWFl5cnNYemFlZCt4Z3NFazYyMEdzdlZDeFMreG03N1BqcXkw?=
 =?utf-8?B?TmZpS3BTNlM3NGg3akpyR2o0Z3oyMEdTQnVOcHc2My9vaXgvNnNpYUYxVW9j?=
 =?utf-8?B?QUVVcGJ1RWxYeG9QQjhrU1RlMGl3bmZuM3AyUDZTMWVnQzJ2UmtvczlNN2hw?=
 =?utf-8?B?aWMrK293SHUrd1BXNS9DbVlqcStXSUtGR0h1TTdKSUJxQlpQczhXZmNJTzQ0?=
 =?utf-8?B?MTJYMUtqdWhTQytxdHZ0N1VIZFBxL0U5R3RNVGEyYm1XN3Y0L0lwMVF6VDI0?=
 =?utf-8?B?aWN5ci9hVzNGU0NXNkhmQmZWRU9FRWVzc2FVQWUyem1xbytTYk9FeGdPUlI3?=
 =?utf-8?B?RWpqbGE1YUxRWVY1dWlSRzJHSVpiM1RacUxGeVQ2MEIrQ0txK21WUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2fb56b-b972-476f-36d2-08df471664ae
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:56:01.8236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lDvMGUiWjy69XAEg9V9jFnRx5UOcST5EFS37QaJHlen+TczlQDT3Z0wR51Ef2M4r5L7LcumzZyYobmrUIzxUBIRZVc/XL/QweX33lHY1uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10850
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Petr,

On 10/11/26 9:35 PM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Define dfu_alt_info with a single entry that maps the whole 16 MiB
> SPI NOR on bus 1, chip select 0 to "u-boot-spi". With this
> "dfu 0" from the U-Boot prompt exposes it, so u-boot-rockchip-spi.bin
> can be flashed over USB without going through maskrom:
> 
>    dfu-util -a u-boot-spi -D u-boot-rockchip-spi.bin
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   include/configs/pinephone-pro-rk3399.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/configs/pinephone-pro-rk3399.h b/include/configs/pinephone-pro-rk3399.h
> index 9cd44473439..9e5d3800347 100644
> --- a/include/configs/pinephone-pro-rk3399.h
> +++ b/include/configs/pinephone-pro-rk3399.h
> @@ -10,7 +10,8 @@
>   #define ROCKCHIP_DEVICE_SETTINGS \
>   		"stdin=serial,usbkbd\0" \
>   		"stdout=serial,vidconsole\0" \
> -		"stderr=serial,vidconsole\0"
> +		"stderr=serial,vidconsole\0" \
> +		"dfu_alt_info=sf 1:0=u-boot-spi raw 0x0 0x1000000\0"
>   

I think this will be overridden if/when someone enables EFI capsule 
support, c.f. set_dfu_alt_info() in arch/arm/mach-rockchip/board.c. You 
can see it's enabled on the Radxa Rock 4 (RK3399 variants). I'm 
unfamiliar with DFU and EFI capsule but the fact one can update EFI 
capsules with fwupd should probably be the way to go in the mid/long 
term, possibly with official releases made to fwupd for U-Boot (I know 
Casey has been working on it with Tauchgang though I don't know how far 
she's on that topic).

For now, I guess this will do and we can revisit later on:

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
