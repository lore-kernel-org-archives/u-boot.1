Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0511C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 03:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43AD880C1A;
	Tue,  4 Aug 2026 03:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNw-HB9wgfGA; Tue,  4 Aug 2026 03:00:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7138F80C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785812420;
	bh=aPqPk0LmLAWxEo0j2uMpVssVIbHcVfzFL+IEAIZXSfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hVWx5JwDXlHQ7qBIHUFfm52hhOR8/gj3bI5cIX6afL8N+mwn5W45/YWK0ZeT/W38N
	 TrizlYC9lgZAqSDlCseaLT4gT+1rBgiuz68i97YKP72nfru66m/VsRs38x6669lSCV
	 0lOHSJ7nH/8U+L2sbNWtwaYgDnRpeUqe/EPAouK0gBUfOvs9qY55SBjU22POZH/r/f
	 AnqVlvpsEmj6/pw0x6QFgJ27l0GmkEOFUzNbubEkWWq3rknh+HKHYiK3GJO9J/p620
	 xbqsZjJaZovwXwEUWtyuiXcB7ovKNxr3Sb7x4C5Dg4Lgji0lxFrGbmNltHDUXKCLP7
	 nWySkLVZ/gqwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7138F80C12;
	Tue,  4 Aug 2026 03:00:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBA01198
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 02:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9429606F7
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 02:42:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VsnOtnI0WfVQ for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 02:42:52 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DF4A3606F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF4A3606F6
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF4A3606F6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 02:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0g90qIuk3AgK7kpmKvMr8vRqoWxccdVKa2qF8smNlibRH+188bNDnQvDZ8HlL1Fokoa85WNkIhotgflyMQJPxH88qCXwa4EKsVEGJqSo6uhYFaZeWAQklbswg33zSkJA2X1Ny1nMfh8cMthd10z+TYR5ZE+3oB6Wkmniv5loom+wsBKzPpxRB2f7Kqvo665qfcdaxqlqtWA/r1AqKES26LX6VNCrxV8URhERRY+Jitif5o5T489jMfymZZuyQhp4DUE7nhGnEuEjGj7bW7bwbOGnMTZf7I4pyDSNiVKoU2uTQsIDVyFXrvnkrI9ReF0U4WmYYWZyASa2dPXUS1y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPqPk0LmLAWxEo0j2uMpVssVIbHcVfzFL+IEAIZXSfU=;
 b=OXKnw5sEiSvf+3GaWK+35g9pZRQUglr/9FPTwvJQQNhHxcAr/6fs/N4z+nIe/R80SGVPyaXQwJkQP28mrN+3TLB5e7hwG2CccQutwPR7xm9+LVvZoHx1NDWD0wMsA6UAT09X4U0vr9lNChgezdZfAjLD9yqWoeMTWoKvfy/TfAR8xeAzLn9v8gv3+14GNmFaFuRkTbB6UTNqRVGkPuiZ3oJvnK8uLI3PlipGJw2mABWyWQXPHptYuheAnibkLD4SJ/AIPqDSMwqtu0F8qB8CvGWwEIKtT6/6JzidE0wDpr8CzV8R/LeBI/PLPyYKsx0ZymwUdtTVAomYzF5yWeN42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:42:46 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 02:42:46 +0000
Message-ID: <4024d372-29c2-4c6d-8185-9b97fe27f91d@nxp.com>
Date: Tue, 4 Aug 2026 10:42:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
 <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
 <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
 <b362330e-c919-46c0-a1ca-b000f9c89be4@nxp.com>
 <CAOMZO5AhOZcsAc6DThNDcXudk5fWrm1gxgzwvETWX3hQ+Pj6=w@mail.gmail.com>
Content-Language: en-US
From: Joseph Guo <qijian.guo@nxp.com>
In-Reply-To: <CAOMZO5AhOZcsAc6DThNDcXudk5fWrm1gxgzwvETWX3hQ+Pj6=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d60ab0-cdd3-44fd-fa4c-08def1d21137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|23010399003|11063799006|3023799007|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: eW38R+FxiqiLOpsZBWLb5nkvZufx/4YS3NSbrRVbFyZloe2mkcF2r/LcZdPJ6rimqpQ8LcueOMs9ov3rYbiztmF/Nf58bwAETgUa0rJxApi+iSjLOgQ0me/htpx6+RrFPWE2shHXwVyNusTluXt4khYCSn3/gwrbfKLdIC4BOSc7ltfzIT4RSZdc0qEP/b5fJQaeyDUHKxh0onXr8gRMRXWGSXaQAPm7mphKyFOIYX/A1pLtwD4jRhenbMX9yZ6nWstp5JHcpFuCmkegKuXKCRf/8lrY4coT/veRQNa6VBdbFoK9LNiKZ+6njdnT3H0s8sJWgr3IBD0Xn+tv1I//19wyfKBwfkmIpScWj1OUxzHNtE/EErXScZND5dClyH6wabWs32CPqv/7qtR1gh0uBc+9JCL3oWglC0nZRbGWzhPR4gTtlp7MXkTbhiRobTVdfSuCzdmOTdEWhZ3eOff7fjHwPZvsyC5na8njJNcDsMx4enZoCTVSW9C6QCPvg4iFUmmZpSR+5J6CI1c5/7FajxSqXaTpkkydl6+gHFtd1ht0PKP1OvT5J6wL6LplqFPXn6tX0FnqZsaoYlKURIn2cOWxN9hIFcq26KzU7+pEoV1iHo+tTBlYPlcUnAP7VFtFCDLdGRy3xY3rz/eFUaL4q2vt9nDd3oqasWlmtrJwjH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(23010399003)(11063799006)(3023799007)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFUrSmhYYXU0VnJlWXlRbWxVdkRMRUc2M2V6aitIUnNES0lqbk9wVlRYR080?=
 =?utf-8?B?dWJjSHNzWUdEU0NIb3I2bVYxU0E5QVo0ek0wSWdDTVRZY0NDanVaOWtjRjNS?=
 =?utf-8?B?bEJtZ0lTMkl0NmNCaFNIK2RQa1U2TWRFZEtCa0JLcGV3RmlUdjRwQzJoWkw1?=
 =?utf-8?B?ZGlyczdEMGxSNGxLTVlCVjM3czQ0Y1lEVGNrQWo5YU80L3BUL1hPaTFPenNi?=
 =?utf-8?B?a0pHbXgrSEtDZzBGd2hNWE9YRjg5MVpibEo5dWhMajY0b2g1OTEyV0l3cEVk?=
 =?utf-8?B?a0YwUTJEY09hbHcyaVhaMGE1VTRBdlJCSnZ6dnc5Z2REcjlWaG9MSWt1MDgx?=
 =?utf-8?B?Y1UxenN3akU5cDhLd1NFQjFpc0lma2I3a3lQNEg1TXptMFRCc0N2WXZjeWta?=
 =?utf-8?B?WDA4Z1VrbTlOUUk0V3lJNXhyL2MxdUJOT2dJUlBhYlhMVDArRnFWaTN6T29L?=
 =?utf-8?B?UUE0NW9ZVTl2akZYOE5laTFCQmxheWp3NkpySHNubTRTVUNYNFM0YzVzZWJu?=
 =?utf-8?B?dy9uZFZDZ25Nb2Z2djJrc05MeFRPRmxtRzNFRm9aak51Z1ltWnY1N0JIMFE4?=
 =?utf-8?B?RHZvemRsWWs4U0UwL3h1ZzVTeVhTQzcvSUtWb1d1VVpsTmR0MzlSUmp0blVm?=
 =?utf-8?B?OGg0U2cvVnRSOEFUSEZWSVJlYWRGZmFxQmhQalhLaURtRjR3Vzg1UUFnWlEz?=
 =?utf-8?B?aGZma3Vtaml0SXBNWGU2QjFMV3p0V0hVUnZuT2pGTFN5VUxidE9BNDR5RzM4?=
 =?utf-8?B?OXNDRG8wMndPUzM1aC9qMjdNcnFIUUVVUHVWQ0RaN1BmZy9tYmFSdHJaWUxQ?=
 =?utf-8?B?SUI3UkpHS2FtMXVuaCtXRXFCblE3bk1udk03ZzBwMzhQV1NTcTEyckNETDQr?=
 =?utf-8?B?U0hqdHA1YU9IZ1R1dFU4UElPTVcxRHByL1J0cExDb21GZFZIYjZTaUxtRk9x?=
 =?utf-8?B?WmtVT1QzNmk0RUVNdUJSZFNFZkkzbHBkeDlIYmI4dkdPVitSS0xkTGxiRHk3?=
 =?utf-8?B?K09MUS9PMUg1NmxjdTlqcXZmMEQyKzFiK2FYTW42UkNlMHN5b1BTcWZmUkUv?=
 =?utf-8?B?UWd4aEpsaGh6dGUxdU81TVBsc0ErOTVqZDQ4aGQ5WnczL3Q3bkxPWUZxdFVF?=
 =?utf-8?B?aFZyU0RTb1JwbWsrUUxHektZVG5LV1VtenZveVgxWC9EcGdkVXJ4WEJOTmpE?=
 =?utf-8?B?RjRsMDlwdVZRMG5pTktjNHVoeTZqMWRBOCt6Z3VKQXVYN0h5YjlLa0VYOHV1?=
 =?utf-8?B?TEFkekdENFc5YlJMWDhKWnNVaEx1Y2VvZGZROTdWandYSGxVak93OERteHdq?=
 =?utf-8?B?N0JkTGd2N3d3ZlJmNVNGQXg1aG9jelJ1U3JkUGptS3Fsd0VkMzE0dnF6WDk5?=
 =?utf-8?B?am1YNXEvdHh6SVdhb1VUYnR4K2xsMFJJR2c4bmJFTWZPaExwL0ZqNEEzNDJw?=
 =?utf-8?B?Mk53WEV4WGlaU2o5RW5lQ1NTczZOdGdXRjZqRHVxOU1HcFMwQU1wTTk3a1R4?=
 =?utf-8?B?cFVvcXIvb0pTYXpBZjVNRFVLUHo3WVZUNXhHUHFiSUR2UGFUUkw4a2pTaXRl?=
 =?utf-8?B?T09SNEJrSFpHcUxPMm9mSmpURVNYQnYreXRnM1RVajJGUzdGU3pjNGovb3Jr?=
 =?utf-8?B?Ry95ajJnUDB3MGZ2eXFicVRCOUpCRllsUkZiWU1DMDlOSFNiaC92RWVsRlRK?=
 =?utf-8?B?M0w5R0pNUDlxSVNua2p2NC9nWDdFMzR2RmxhMDgrNDYxMmpZd3MyVkU2MWFJ?=
 =?utf-8?B?OHVLMHJKV3dkRnQ4WXhRQjJnSVZOTEtnaFI1d0ZaMFBPUXhOaENJQS84cTNp?=
 =?utf-8?B?WFRJUDl3MTVURmhGTk9DSTF0MnVLOGhReVR0NlhEK2RPL2l0dnJTd2taZUlo?=
 =?utf-8?B?UkhFZVpHZXVJRmpyMytIUW0rTHEvMU5NYU9oRkVBQW1wdXhiMnEzbzRsRTd5?=
 =?utf-8?B?ZGJTSzIxZ1h2emVjRVRtTWkyQ0dvdktlTXJWRzV2NTRiZ2xEb1c3eDhNWkZj?=
 =?utf-8?B?a2E5aUMxYll3bjNrdjgrdTRCOFJ6citCY2JEQnZIdFpKaVByYjBLT0hyZ3Vo?=
 =?utf-8?B?b01XYjB4VXBtOC8yTW95Rk14bGtXRlRscW51dFhPSUxnd09SYmpiL3c2NlQx?=
 =?utf-8?B?cHdrWjBxY25iNDVNZE1sWjNDZ05JYk5mekF0cnBYRDVnd01na3RLN2RnQ3pZ?=
 =?utf-8?B?enhORTlwTVBiSnROcUhzUXEwcGRHTzJacHJGN25OQ1R6UCtHOHI5UmtQS1kw?=
 =?utf-8?B?ZVdmcGRYOWwycDhXc2hza3NyVHJ1VFQrZEZ1bURPMWwrZW1jS1lSbURwSkpM?=
 =?utf-8?B?Vi8weGJOdE52aHE5UnVEMDFkQ2FRVmlkTUowYS9Zb2JBaFR6VTdRUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d60ab0-cdd3-44fd-fa4c-08def1d21137
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:42:46.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQjBTyL/xPSEzaJi8llxj6wApYkeAY1/ux8tsvBupxDwn4AVD9eaPiVDnZxgbbUGJvTD7rTK7A8Pz4FgAqiZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371
X-Mailman-Approved-At: Tue, 04 Aug 2026 03:00:19 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPqPk0LmLAWxEo0j2uMpVssVIbHcVfzFL+IEAIZXSfU=;
 b=g3JLJFfXWyurBGnZcVCrZ15pcUP7doAF8rn1qMMnP1/2gPyb+7UOarTR0yWgk7s+Gu156HmJro4ShlphO4JbDm+V3+Lzt4s1ZqImCxb+EgZLJRZ4CqCqX6ZXyYKVpsXKzHmQtCfsDF++9Qhd2WJAk7ZYnvgKcX3ko2Rdt8N//773B4cNkmhBn6SEFvf/B1REQjB3YNVDULdfDpK1p2/B6praaUrwie9+M4p37nJQaX3udw7QsV34bCA+qIvhCCcZZ3Mk1NBKt7oWOos47AYWVwxCsVcEtICdR0q3OhMyEitZ0pApFwEEh9W8qpyVq5x9TGDw8EMsf1gTXA1+ctZUmw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=nxp.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=g3JLJFfX
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/3/2026 8:16 PM, Fabio Estevam wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> Hi Joseph,
> 
> On Mon, Aug 3, 2026 at 4:36 AM Joseph Guo <qijian.guo@nxp.com> wrote:
> 
>> On i.MX95, `netc_bus0`/`netc_bus1` are internal pseudo-PCI buses used by the NETC subsystem for register access — they are not real external PCIe root complexes.
>> Without explicit ordering, `netc_bus0`/`netc_bus1` may be enumerated before or interleaved with the real external PCIe root complex,
>> making it difficult to predictably identify and target the true PCIe interface (e.g., for NVMe, PCIe Ethernet, or other add-in cards) in boot scripts and environment variables.
>>
>>
>> The `pci0`/`pci1` aliases fix the enumeration order in U-Boot only. Linux does not use `pci` aliases for bus ordering. In kernel, it use 'linux,pci-domain = <0>;' instead.
>> I prefer keep the alias in u-boot.dtsi instead of upstream.
> 
> Why can't U-boot use 'linux,pci-domain = <0>;' just like the kernel, then?
Hi Fabio,

This is difference of general pcie driver in u-boot and kernel. Sorry I can't answer why U-boot didn't use the property.

-- 
Best Regards,
Joseph
