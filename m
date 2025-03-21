Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761FFC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F190E81B42;
	Fri, 21 Mar 2025 08:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VNwen61h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40C281CA8; Fri, 21 Mar 2025 08:16:30 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A43181D25
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZC3bwCBQDLn0DSxm5aU5+xZf0eSbmGb+nAV13qHitNbgVY/gzyBfknnh0HzCOPK9sWbeqtl7jZtoadURrEFQM3F8xsT/zf7AMWi8rJUn1lni3x9EJifCmWynfKkjCVi3AndbZ/Lyxj2jUF3+izDZzESDXhNc56Eb/ewYYP4nhN2YtDucFGna3/zxDMjXBqEZMPmgfcQ0HSuX7uLsDdaosoeeUJTUywev2q1OckakGGiz5jPYbtRNoPKihWKIORRsuhqveEe5k1dFFGZDmR/B1yKtvc5mveSYlEqpeFjyw0X1QRl7XUrQxB58PFyIvIgnEav8e2BlJYgk8zFlTxrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9+It9L2QfiZ5GzRSWJHUlr6ud+tpHmWbslmFiKPX4U=;
 b=DXoJEi0xUP09hbqAn8Ad1hvVpcxb7oy6nZipGvkZ3FlWtOqZDDjM1YO+pUYBqKGrBoV74LuxsKaKLQf2IhZV0Jfs3uf3HyOgVqgUngbGzP7MVYl1KqyFTzMfULbBvDHzjuR/P9wovPK25cTSuR3bIoEUxuNzBQXtvwRMynaxFAEvQ/5kptyLY7tjl0/CCGGWham1TeLNe8ZZedLRAs0E0h5seqjP7xcMhZhor6zBU/YGPXgXd3dTiaJhuwjIFEwZzIrHQWl0vt87twiQPcWg/HG5dKM0AK5aOP374MV9fr9BOIF7Z0tSA/MyQaStATgmsKQlqSsoUxiyqOaRgFfBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9+It9L2QfiZ5GzRSWJHUlr6ud+tpHmWbslmFiKPX4U=;
 b=VNwen61hahSe6KQfk/wKXujp+f0VjrB9he1zCM7vfxc/7mFm1BekwSXPIK1Kz/3Ipjcr9EOZnvtjA1B4LvrJADarxUwZnEIGbkAKD/8h2NTTKojhwfy3LrVrR6P6Li9meiO8rQDY3Bkhht43MMCvJIHJIrFkz89lHd7GxiwdMm9trA+Z4BmcD04ak/4kl8kK+7oYZDEqfvGdmH4Gs6Ghm3VqqygmlVp0xCHT/fOWDwHdQ0boCtNldK3gMx+wj26z55NIVVj4li5ytkcRotDT932dEbcwkNTVaaEGNOjSS6Fxqya8BlyH7EvSACNN0bqLnOQGgtmnDb9Dr6S/eR2ihg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:25 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:22 +0800
Subject: [PATCH v8 08/19] sandbox: add SCMI clock control permissions to
 sandbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-8-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c65f704-71ce-4914-d7cd-08dd68484ac3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEFrM2l6UTBIWGhUUS9aekJVNGVOa1p6RWtUT0xKNjU0dXRCQWV1RlJkRDhW?=
 =?utf-8?B?c202RHcrTU95YUgvRGNRak1Rd0p2NFJBUDF4QUpzNGpCNFd3VE1PQ0FCWnI3?=
 =?utf-8?B?cjcwUENsVDYvZjJRejZRWS9JMkc2REFlQ2wrR04vYXVaMXdIUkVFZUNuZkxn?=
 =?utf-8?B?QTNJalVKUWIxRmpJV1dDZENyZkRka1A3WFlySiszWjRKT2VoQ0VJajQ1R3pC?=
 =?utf-8?B?N29heFV1enJEMHpLMDlKSk1sK2hSMks4RXh0THJjS3pGbjJpaWZhY2JkVkRK?=
 =?utf-8?B?TG8zN3MwOUZqaG5kb1l6QWlzK2xLUlZsNldhTTM2Z1pvWTdSdEdwUVZraTg3?=
 =?utf-8?B?U2xSVEdyWldBRS9ZdzdrdCtLRkdOSEJIWnVBdkFLWDl3TGxnQ3NTWmlsdFhs?=
 =?utf-8?B?Umw1Z3QvZ3ZqSmVjOEZETllQTUJjMlVYQmpyZ3RiYUpTWG1RV0V2UzAwOEtw?=
 =?utf-8?B?MVNNcHZnMzdxVVY0RmdJblMxd2lxRVRHY09QdGZBMmtQVHMyU05KTjIrdFZJ?=
 =?utf-8?B?aW5aVHZvMkdNVHhrQ080blF0NGhUUkdUQjl6blN1VWJSVk5pT1ZnTjJCc1h5?=
 =?utf-8?B?VjBZaDU4S0d1bjRJMzNqUG9vMVNYdVZFK2VqYndUcXQxTkl2WHlVdUNvb0h5?=
 =?utf-8?B?N25GdzNmTHBGMWRwL1VrdXBrdnVibi81ZFVHMUFGRnEzUVQyWndTSzRUMDl6?=
 =?utf-8?B?bTd0MlFlQitFMytuU0oxZHY4QWk5eFVseTRJc3Y5ZGVIM0svekV6VGZUR2Y1?=
 =?utf-8?B?UkF1RjhMRDJ5U25JL1RvU1ZTMEhTeUFyNUlRanVheG9FQlFPa1ErWXJLQWpG?=
 =?utf-8?B?aHc5TUlGQytJS0dsTDFVMktpR09jWndiOFNHOWFUQ2lnWXNGaHFKTytYUHBV?=
 =?utf-8?B?M3JFTTM2aXZDNDFvbHhVSjNhS0thR0d6eXlXQTFUcG1xQU1td2FMbFo3LytI?=
 =?utf-8?B?Lzh4TWVXelltZTBvemtZeEZmQXprTFlZb0d6Nk1wdWt4NW5UMVFjVkM3RTFy?=
 =?utf-8?B?bDZDTGd3YTg4YlZYakF1Y0wvK24wMlNxS0o2bXZoOG1QWVVGSHBrWWY0OUta?=
 =?utf-8?B?d0tZSGVUZ094bUc0NGpCSjRHWnhuanQ1OVhFS09RaTlsRThKYlg2SlgyMEVI?=
 =?utf-8?B?VUZaOGE2dzY2dzBRc1NqWTU2bklmQnBoOVNjU0h1TlBpNEZUT1BuWDVlMHlu?=
 =?utf-8?B?RUtzSFhVaG5TNndtZ0IxY0JUeTAzSkVlcEpIYUE2TW94eVdNanltaU85T3Ri?=
 =?utf-8?B?Qm9GWGdXbUcvSHgxcWZUbmZhbE5Xdk1HMHY2Rm11bUUyOEM5QnlONDRJS1VK?=
 =?utf-8?B?ZktudEpRTTBNYzgvV0FlVWFyclJqZmprVVgxZWwrbTlqQ3JNZFdld0FnckJh?=
 =?utf-8?B?bUVCYkZRNW5vN0ZnMHE4bjFmMVhZa3o1QzJ4YmpncWorYlJudWdmRDVIVXZn?=
 =?utf-8?B?cjY2ckNmbXppaStnUjY5MnBOdzMyU2ZPTkFoTkFuQ2duMXBMckM1ZFB0Yysx?=
 =?utf-8?B?bnNLb3I5QlJuenhrdVptMk1xbnFtVVp1UnNRQTh1eTJXUlRQM1RUcWNkM01T?=
 =?utf-8?B?bVpoMVJXT0Evd2FKVitzczEwMThBRUx3cXJ5SlBPT21rWVRoa3hJb2JYR21m?=
 =?utf-8?B?S1RTdUNwZUJrb3l0d0FaUDI5NTlOaExzdXZmNEdnY3Q3YjFvMFJaRk5LOEtL?=
 =?utf-8?B?NUNFWmNkOXo1clBKNVZqSlR1WGV6VHcwMnJBdWJzU1c4em9rdCtrUDlZSmdI?=
 =?utf-8?B?aHc0KzI3RTh0b1JrZEY0NXVabnNUVXo4U0hLdjdmbVZRc2hoZi9ENlgrcWpI?=
 =?utf-8?B?Wmp0ZW9vT0RGU3NyMU05Vi9SRnVzOC9kZ1NpQ2k5bUZBVHdHbmo1R216T0Rv?=
 =?utf-8?B?c1hBd0diaHVodHF0d3FmYTVoSTgrVEhJVG5zZ0tGbzhMejF2Sk81Q2o0eEM0?=
 =?utf-8?B?bnRlNWJzSmNUd0JtcHFDMDB6K1lvQnF6Q2lxeGg0UTFyallraDdBVEU2clAr?=
 =?utf-8?B?Z1hKMENYS3lnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRtR2RNMDVESnMrVG5LamVqNUhtcXFtOHFMOUEySjRyS2hSek5QR0w4aVg5?=
 =?utf-8?B?ZVJYYU5mRWNZa0ZtNUtlcFFMRmdidmNPTy9sSkd2K2JFRnhJbk5PT1JZdXFQ?=
 =?utf-8?B?SVVqZ3JsK0FlbkpqZlpaZXkyMXB4WDRwOFREbTJZNWNZVERXMjJqL0dKR1BW?=
 =?utf-8?B?Q1YxWmhYbjdNN1ZYZWsyU0hwdHBiK0kwWjJZZWdrbWFOUzNTd0Nna0ZTYVhu?=
 =?utf-8?B?VTB5aFpWcTZoWWNaYzhIQ3dZVUJQMkZ2blFSdlJmWWdJb0srU1NGYnJFcitQ?=
 =?utf-8?B?UHBCLzhDV1pvRDRGbDlQTmk3OGhDVDBONm1XZFJkSklaVzNqYndQYndUckMv?=
 =?utf-8?B?TXhuWnBVM3VPNDNIMzFNNFk4Y0s2MlFlalhNWUZMYlhwNWFHMWZ3YmZqM2Zy?=
 =?utf-8?B?elFsKzhiTlRFZ2syUlBjbStlQ1gzOUdCRncyZlV3cy83TU1XUmVWaURIdlRL?=
 =?utf-8?B?K1IxT1psLzEvVWtieFdtUGhMZlF1dHVyVWExWldETWczcWR3WWFBSjN2Q0VP?=
 =?utf-8?B?d2pNdVc4cUdBVHJJVVNidFlOMTlXRmdmNnd5THNDemYraEdVWG1EY0RRK1N1?=
 =?utf-8?B?RHdZWi9KdzlVaVA2M1RVRkpRbFZ3U21SVWt2TTNTM2g5aGdEdWZjWmd2THh0?=
 =?utf-8?B?R0xmM3lqVFM2VmlBdFlxU01HakV6VTN1eUIvdmtrTHNRTU9IbXFXZXltWXMr?=
 =?utf-8?B?aTNNM2FtMWttZ2ZkVE5aV3U4RTlvOEhjZjAxaU12dU90ZGFKNnZiR2UzNnow?=
 =?utf-8?B?aDQyMExWWXBJTTNJTDQ4blBUY1k1Qmh2OHI1NWhIMkIzaFFoR1daN2RaQ1Ax?=
 =?utf-8?B?ZklJUGFRbEZBcVlWaTEwcXRudEhITStOSnpZNmNCYmNmUm5UN2ZMdTMxY2Vn?=
 =?utf-8?B?SnFKNzJRNTBZYWdod25vcHFBSVNVM3ZucVBxekY4ZWkyUnd3Q0NqQldHZG9O?=
 =?utf-8?B?Y0s3MmdmbHUvM0dEajlFN1RvNE5JRXNEZW40bi9BaDhUY3BHNEtVditsMm03?=
 =?utf-8?B?bmV0cGFpb215NFlDS1A4WXRRK2Y5WHVxemVaM1hhT2ZHSm5EcEVqY0pUc0w2?=
 =?utf-8?B?UkovMkRsaDAxNU0rS1JCWFZLYmZrMEp1K1pHTTMyTDgxVGFYdWQrdExnSnlq?=
 =?utf-8?B?U3JiUWVoLzJUek1JL2MxRloxWXA1SS9QbEtZVGh5YlR5VFJ6cS8zTjNLb2xS?=
 =?utf-8?B?VndYNEdEUC9LREFzbTlEaVZ1cWdrZFVGZ3hBZjBxdUpkYm5paHBOekNlYk9Y?=
 =?utf-8?B?UG02VkVnZHF6b1BWejVMN0dsdVhUTXZZbUdsK3hveU5vVUJQMVZMSWxBbTNa?=
 =?utf-8?B?OFdabnZ5c21pT1d3QThEdDFOK1Rrbjg4UzRrWWQ1dng4VGtBeGMzOTJTTEt3?=
 =?utf-8?B?TWJ4b3ZaVmRoUDVmVXNxTHRTWHprcFU4WGludXFBWFMrUFRuUFA3Sk9OZGFv?=
 =?utf-8?B?ZDhqR0xMUFY3VEpUN21yS3FWR2lRY0JxMjlIU3ZXSG5YVUVPdkkrajFWcDVh?=
 =?utf-8?B?Qjc4K1FHbTZtYnc2eGJhSTFxNy83UFlyN2lqaDVrQmFKSXBsVmM1MFRKOXVz?=
 =?utf-8?B?TEJxalR6ajVWWGF0bmtWNFBwMWpKVnA1Y0ZDMmg1bDg0YXIyWmlrb1dpMlc3?=
 =?utf-8?B?YWE4ZTB0VmhQOWRiR215Q0dhaElSRHRGKzRWYUVVeUYrbXZhQy9hd08zM2Jr?=
 =?utf-8?B?MUJLMjIzYTQ2ZjVTcVdmd1FkdlNqaWFWZWQwdU9oUlBZSzZDVitRR3lSM1dn?=
 =?utf-8?B?d2k5YUE1dExMTHArQXJMb0FuZEhxTG51RlAraExhNlFxd09hNHRlS3M5TmNt?=
 =?utf-8?B?ZG1rKzVWKzJ2Q3RyaGxJTnNCUkhVaERGQU9RUWpxUEZoYnVlQlNvN2RhcjJk?=
 =?utf-8?B?bkVwZi9KdGMvN0tqVGlHTFh6MkY4MXFhVjl2WU9Nem1QT0dnbnIxR2dHZFlx?=
 =?utf-8?B?UWNKS1pKdzloOGROS2R0dytVQXNkMHhPZDk3V1NySHR2a1RkYWt2S21vaGt2?=
 =?utf-8?B?VjRvb2ZsR3lLd2VNcTRrd1RMdkZ4dGw3d1U1OTNzVWVocDV4VWNTa0laRXAw?=
 =?utf-8?B?OEFmbVh0MHpZbzBIK053RXJKcFlpbmtqSjdvNXpQMUJ1NWlBS0hDNFpBTXJX?=
 =?utf-8?Q?BTiDUFmpPUi0kHPujRJxChSzV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c65f704-71ce-4914-d7cd-08dd68484ac3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:25.8672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scnq9anEEqRm2WK0bczxtLbNrwF4hkz3rrDoWVLunV0GftXSmnrG4wsVGtITJY3ifdPXSnKBwMhAdayayjZ+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 ++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098c..b30e536a357 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44..74a87832dcb 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}

-- 
2.43.0

