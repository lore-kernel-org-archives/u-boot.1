Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833E4C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9DB082D2B;
	Wed, 18 Jun 2025 09:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f+Rh4RdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B81982BF6; Wed, 18 Jun 2025 09:30:30 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA1482E8E
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xod8sJuxWfYdG+GbtG/Jmgv3eD0+WNFMdNajWSnfMQciVYnXa6gDOvPNng++gw88whAFcHimFsUM2CWRV58XohBGwZpa9lwZRAzYVLxL2kaae2WEAOVz5Jp8XVv+GSEdm1+MWEKWfnrDa0IrY4hBuJNos1wPMvLw5otOcfV2gdTnSJUl0Ce4aLbWXQT6OJY3uYDqdSbOVHSgRWw1NCDXjqufeT6SJwNYsxShVNSK9A6jTjzvEaLrZYWnEGaKThb49dvRjupDmR3VIYoS2xHt75wRGYNjSMiYACf5Z69yDcEQc6TKak/I8bMsXBG/i5sRGt+iLs1zBF5P1SCCllr01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCn004oja2FgrhcOvPWx/KljnFPSRylT3zJ11uzDWrs=;
 b=USBSu41R/mRQbeq+vn0q9z82hbRDQHB6OBPQ+pDwv6Yaps+YSiFzqXrNcNj7nb+LPjtyP+fCnlx6ao2WOgKeBX8JUa6zlB0SxaX7bl/kkx46o3+VASK5O2MFBdOCY+PB9WIdIZRa5Z6Bs6I/cUusg/+RiGrvVG6sQkKpaS8ZGFLjG7zHdYFb43HIEn0okH8M2tLUqc/CqgtzDkEhuVhUv0jJyrZd8iA0znEQDYfiOxSvW41gBzOsK7dHVZVpixEj7ixtDgNexwx7OuWFoKhHXUqZglANz8JNrwNsDSCcUy/6PWUd3dP3FMGSkpil1mUDXxHCHZVfx1MO52fT2nw2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCn004oja2FgrhcOvPWx/KljnFPSRylT3zJ11uzDWrs=;
 b=f+Rh4RdMKSAQbqMVV3Wvvs0MJvY6hGV9PEooCzmwvZ/v+fXyCqYs9cFI36kKAU23ITyqPngtfhu93L+pXsDgvnQFYHqt0eZ+ZK/gQnbxJY+O6WQQKlKQ209A7xTaLWYTqw1HvLnMGv93xLflouHg7MDhhUYiWumwrKLwxrx7xDbGKn/6XP2W0zcw2bfBWVveyAA8Wzd0vfiNFkaO17PJ9nT+cauRsdms/a/DOzrSLyz2ZzTxuvVHADGRhA00MzJBL8fFE7IFGUN7NP/Y2fme8jhUOjxyEMKmWcl84OUtmxnqVTev+NiIvMuo9o9R5+KiMK0USGnlfcgW5q8fhr+nRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 07:30:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:26 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:15 +0800
Subject: [PATCH v1 2/8] arm: mach-imx: Change to use IMX_CONTAINER_CFG to
 specify i.MX8 container config file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-2-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdff085-49d5-49f5-38ea-08ddae39feb9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3pEbHM2d3diMEhZUDVoV0FJRFo5UURQK2VZM2E5QjF2MmN3YmU5TzY3dFlG?=
 =?utf-8?B?NkhKRTNSek5NZjJXN001YjhwZG9CQkl2Vk1MekNvQ1V3dU5yaDJVL0kybzNS?=
 =?utf-8?B?VkUxc1l4SkcxSU1oMmYwRXVFeWFsMjF5cC9RQnF5amh5emFic3NOYmJSZERl?=
 =?utf-8?B?QVdBOWVXNXp1OFpKZmgwSWFFbndJMG1jR1lBcWtqUXZnaHM4L25EVFdvSHRD?=
 =?utf-8?B?Vm5hV0NOeHR5YkEraG8wODdoUzhFZFBlQURtcWxFVmxIVmpuTkE1MUp2b3pl?=
 =?utf-8?B?aXVUdkpaSFZyWC9xY0RpeDA5YnlkeEg3S0RFTGxYSTRzTUdhakZaUitHRzRH?=
 =?utf-8?B?UVVaR29KTEJtVk5FVVVPV1BxdUZoWForZFYzM0RqNmsrbGNWZTF2cEIyT2FT?=
 =?utf-8?B?N080TEx3TmdFM2JuY1Mya1V1UndONy95Qnh4Vk92T1lxN0RNVzhDTjREcmdH?=
 =?utf-8?B?dmpuTjZhSVExTWtiTHFaM0lyaldDY1JaNU9OOVBLd0F4UlN2Q1N4VC9lRCs0?=
 =?utf-8?B?TnY2RVZiTmRTZEMxSmRlaDhaTzUzR1JBd09QRWM4REdUWEhCODZNOW5JOGh6?=
 =?utf-8?B?SjEzYVhOb3JkUmZwYW5UQitJdHNzMnJFaDZnOWVpYUlxa1F2K2wrNUNyS2RF?=
 =?utf-8?B?RWdNOXJkVXNCVG5OL3VSemJqQWhWLzVGSm5pV2g1SlJpYmRFaVJMV2JRU1Jj?=
 =?utf-8?B?ekN1eHZ1TkhnQ0NNNjdLdmVBQXVQNENMSEdhV1lnZjdSeXBHWnFxbUd1UE8y?=
 =?utf-8?B?b2pJekRBSjFBWEFmb01JMHIwbld1SFNLSUFJRDV3VG82V3B5Tm5ZS1cxSDFh?=
 =?utf-8?B?eE9TVGtLc2FPZEFrMmFMK1EwamloblpSWXQxbk5XYWsxTHJrRzkwOCtvQTdC?=
 =?utf-8?B?aUkyWTdOVzJpVU5XdmhLOEU2WWJ3Q0tla3dKNTBSNU5pV2dJUTR6eUZKc2J6?=
 =?utf-8?B?S3JscUQ4ZTY3M2p4NWlIS1FIU1N1eFZkUm9UVVEwUXBOUUU2YjlDVVRJdnh2?=
 =?utf-8?B?NzNtSTBRTVNxYUVlVHVhUFd6OXlIWnY0YzNNaUJ1MVZmU1JiQzRCdUczNngw?=
 =?utf-8?B?MjNqek96OHdoVkVCM2FsUmd4UGRodUFESng4VWtoOWtYdGN2SE9QMzZKOWw2?=
 =?utf-8?B?UDdNWVZzY1pqak5iQWJMTEZVdlBRc2p4TGNoU0M5WDRMWnYxemNLUWMyekYr?=
 =?utf-8?B?NVlXTlFZdDF4TTU3Z3U1NUU4ZURjZThpd3ViYkNZR0E5RzNOTVp5M3VrMndp?=
 =?utf-8?B?MWt0ZEpKUjZjU1JUWUkrb2NWRXMvUmIyRU5Lb25nVVFYd0tPZGkvRWRFL3JF?=
 =?utf-8?B?RVRUbWZKNzR0cUlWUVliTjcrZE91VFZNQlhzczUrdE9KTDN0UFdRZGthQXVz?=
 =?utf-8?B?eWtiK2dYMzgrTktFZmxyK3ZQUzByblR1ZFgvOXFxSVhFQXAvYkt5U2ZrQWk5?=
 =?utf-8?B?bytKWFFkYTM3VEJ6bm91YmZhenpYNXIweTVTdHJySFhwSTI4bUNzTGJKV3M2?=
 =?utf-8?B?Z0FGS0gzc2dYekludTN6QXBrQXpFcDlUWjNBeTEvc0x2cVp2U0ZERUxETkp2?=
 =?utf-8?B?YWQrYlU3cUx0UG9LUjNMNGc3N1VmUmJ6YWw0MGxzM0JkSFRNam5KSXBKd3dH?=
 =?utf-8?B?c1hQSkNRYVdHK3hVd001Q3ZKYVUrQ2F6UVRmVU84ZzdrOHJWUEhXbmtZcmlB?=
 =?utf-8?B?U1ZNRnZmbFM4Q0dFc3FWM28xNmh3d1JnL2J5NEVkWjlpblFDb1pYTXBMc2dC?=
 =?utf-8?B?VXkxYm9ZK25ObnBITUxRNFFndmxzdTRELzNyR2NKbEtRbXdyMUdEVmxtaFk4?=
 =?utf-8?B?eWVwY3Q2TDZLVStUVzhpSlJya3RzNXpBYnU0OVF0cGY2VG55NWxCTkllQ2hS?=
 =?utf-8?B?ejNZOWhORWtBc2pYTnk1NUpRaHlQdk5yeDdzQWo2SXZOY2NtVDRYY3VQYnJ1?=
 =?utf-8?B?dHB6Nm5MZGVmZmViL1ppV2RoQXJSeWYvbmVVdG45SHRNc2hWTHlia0ozZkJ0?=
 =?utf-8?B?N0lGTERVaFdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hwVUVmMTJ5dVR5cDhMcnhvbXo2WmVjZUtiaXcwRVFiTUdhQVNvWEFoQUpK?=
 =?utf-8?B?bWJzdktCeDJtY1p5Zm9ZWXZua295Z1YvekVqNy95N3MvaUhuYlVYNFE3NTdC?=
 =?utf-8?B?S01uTEVsYlJrVTd6dWRmampKbnJ1TVRXZkR6Nm02VHZVd1ZyQmJ2aERCVjl4?=
 =?utf-8?B?WHNpYlJ6VWE2aHRMNnQ4NDZCZUJodUUzcVc0NS9zSHpYTy84WWlGK015dldJ?=
 =?utf-8?B?RExGamNqOHNxUFRCSjV3THN3RldZTjVFb3o3QlprZTVmT0UvRU90dGc2emFX?=
 =?utf-8?B?b0VTRm5zdmQ1SWVzbTM4Ynp4M0lDMEJ6eVlwU04vZ0NiVzkxcXdTWEF4bDky?=
 =?utf-8?B?YW9VRWhIYS82SCtVZ2l1OVBXdTdackVPbzlQWXJrUmU0TEw1OVovdlc5VE9s?=
 =?utf-8?B?SFM1c1B5bGpTVVdJQjh1ZjVjNjg2aHhEUFN1K0VBUDJkNGN2M1pneTB0Rzkw?=
 =?utf-8?B?RFA0TWhNVngvNUNyZXM1U0JlTFozbS9CKzRYejBiVzluT01FcDA5V2VRdWxH?=
 =?utf-8?B?WTBBSTBScHUwZmZsbVByazFwd1MwMWtMUGJRYXN4WUltWkhDRDRueERjMTlM?=
 =?utf-8?B?bk5iNk95eGNERitOK2JJd0dqcmduaHdNdFgzTTFMdXg3Y3RWRTZRNEtkSTAw?=
 =?utf-8?B?RGxobG9SbUkxY0ZNcG04UlYrTFhtWUE5YVltdzk1bU43NTN2enhKeE43eG9u?=
 =?utf-8?B?ZzZtalNsODd6NWJNT0Z0SUx0aDB2SzM5eGVMcGJMd2paVXRIR2VCOUsrMU11?=
 =?utf-8?B?bGZOcEY4SDRibTdRRklQc3JkeklzT3pNOVRTSTFXNzdwL1R2SDYxNTZoVU8y?=
 =?utf-8?B?Y21lRlBaamw3K2xIdUxmQmQ5bkFxTUZkcFg3VnJibTJOcVc0WWd4MVVZb1Vn?=
 =?utf-8?B?ZU9SVTZtVlBFc0Q0dS9PM2JrNzJmOWZ1UGt1dkI1b2d6ZGx6amhPdkxNWXNl?=
 =?utf-8?B?MTg3dXhsUG93VDh3dlBraTdBdWhsTEZISGZjWDdVU052Y2hGVU50UUc1d1JF?=
 =?utf-8?B?bnNaZ2Z0anh6c2Z0ZG43eWl1Mm5UKzFHK2pQcXBETEhsL09XeUtKNzkraFl4?=
 =?utf-8?B?VUxMU21IaGlRMDJ1M1ZkQlgrdnBxZ1N5RHJ4VjJVNTZJd0JEaEoyNWNxUVh6?=
 =?utf-8?B?Y1o4ellOWWVuVnFzVldDSGllb01hL1pWamxuczd6RktEN0RCZFJxWHZsc3Fx?=
 =?utf-8?B?NDd6K3NwVVl6NTk2c3Y0SXViSU5YQjdMcXlycWRjZXFFS1E2NDJ2VVdoMWtZ?=
 =?utf-8?B?WkdHOHhjS2I5UDZTWlREcWF2VEx1U3VoTVVRK1ZwL1dnOCtHcmtpejI4WnBG?=
 =?utf-8?B?MHRBMEUzMHBoZU1IcmhSb25DN2VJbzhZd1BlSXRnNG40czUyaDhXS0Vwd2ZX?=
 =?utf-8?B?NjAvM2pMQ1llcEhBVE1CZ2VSdlQ4ekp3Z1ltUExNTEtodWVHZGpnd01nSnpv?=
 =?utf-8?B?eU92dGExWU1pT3hzc2ZWbUVXM2UxRThxQTFZZFhPbWlFRjdON2I2NWUvV2Q5?=
 =?utf-8?B?djUxcDNXSEZiV1czVVVReGlaUkN6MXJaR0orZTVIdTNEUFRKelpxTXZ0N1hm?=
 =?utf-8?B?OWZTcUxBcHFZbncvR2RLZXVTaEs5K1BXd25uN042Y3BSMGNRQWVjY3lEQmJj?=
 =?utf-8?B?d05zd3gxVk1oVk1zRzY2OUdDV3pZTTZyamNZbVhKdHd6dnpUaFZheWNoTEV0?=
 =?utf-8?B?SWhUeXBIejBJdWczUCtnZ1JmQWNYWFZRYjJqWFBEdjVaRFlpWUpwMGxmVEU4?=
 =?utf-8?B?b3BKMDBUN0IyYjQ2SFBKclBoa2REUlhpNDdCZEVrb2EremZxaVRNcTJWNE5j?=
 =?utf-8?B?RnppajYwa1Y5ZkVWQ1dsU0N5ZUlHWnRuMXpvM1RQSTk5OEpxTXdRR1BuVW1S?=
 =?utf-8?B?cGxNWC80NEYrNHl1b0Z5cmpudHByZUYvN3NJZVZSUDlSNE9BOTZ0WTNkS1py?=
 =?utf-8?B?RTZqN3VsR3pzNHBONFRNWTFVZ1JQWmYwVmNFN3QySll4WE1lNU90bDgwUVpU?=
 =?utf-8?B?TVRoTDNNU0xnQkZmNkxxdVZpV1dzZzdodk0wOERXdkh2eU9HdE1SV3BGQm5Q?=
 =?utf-8?B?bjNoaUIyWS9IQTNtNEdBdjhqTTRLL3VuS2c0THJJYVhuTGdhNDF5ajYraU5x?=
 =?utf-8?Q?5rwFyPpnHgZU4GKHa6fy5nZzz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdff085-49d5-49f5-38ea-08ddae39feb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:26.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLclSbowrdn41qHO1hIACJZdjGy9QbrfElC8662OFVYgJVSbnGc8H4Yh8gLZock+KcnmHbrYAtfGDQUa5qBE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
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

CONFIG_IMX_CONTAINER_CFG="xxx" specifies i.MX8 container config file
which is used to pack u-boot container.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8bd85e889ab..6d68b0c635e 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -131,7 +131,7 @@ IMAGE_TYPE := imx8image
 ifeq ($(CONFIG_XPL_BUILD),y)
 SPL_DEPFILE_EXISTS := $(shell $(CPP) $(cpp_flags) -x c -o spl/u-boot-spl.cfgout $(srctree)/$(IMX_CONFIG); if [ -f spl/u-boot-spl.cfgout ]; then $(CNTR_DEPFILES) spl/u-boot-spl.cfgout; echo $$?; fi)
 endif
-DEPFILE_EXISTS := $(shell $(CPP) $(cpp_flags) -x c -o u-boot-dtb.cfgout $(srctree)/$(IMX_CONFIG); if [ -f u-boot-dtb.cfgout ]; then $(CNTR_DEPFILES) u-boot-dtb.cfgout; echo $$?; fi)
+DEPFILE_EXISTS := $(shell $(CPP) $(cpp_flags) -x c -o u-boot-dtb.cfgout $(srctree)/$(IMX_CONTAINER_CFG); if [ -f u-boot-dtb.cfgout ]; then $(CNTR_DEPFILES) u-boot-dtb.cfgout; echo $$?; fi)
 else ifeq ($(CONFIG_ARCH_IMX8M), y)
 IMAGE_TYPE := imx8mimage
 DEPFILE_EXISTS := 0

-- 
2.43.0

