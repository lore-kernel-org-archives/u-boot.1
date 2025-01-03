Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEE7E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B28E804C8;
	Fri,  3 Jan 2025 07:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rlEabvOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671E2803F5; Fri,  3 Jan 2025 07:46:50 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A82800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syTFy+vZLwRjczfgF7im3rL18svXp8SkURV2hXcBCI8d3gF+Azb7gIwwx0JphSfKFcSlBZl6YmETP4d+UYURMq6a7XNEnZIoKrgI/Zow5M3gfPl4P+7KoytwZ5tISigp9sPyNjE3Xu/Dk1IL6CqaAy+C0fNI+7gjow+js4F4LgxZQQKfqYnBwc5qdfbiBqnHMW+mWHK3rIxRLGGDs5OUTN3F+n6hpnkdMtkdGbeUt1Xn+CDqQv5BhkmQanaHIol/n/8wYPeArU2XMFUPT7EwlmkcFK9BRZpzw4f7LG+z0ycVL+Yov6SifbEklshwyZ1/3tjFiwwIH0pu7eK9V/u5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzIS+EorfZphE3L8vZkLouOGYwj24TBhySa75d2mYo4=;
 b=gAg9U3M8N3NaryPQbLAaWAj1DRc1x2mEL6FDV/vg+/4oe0xDhNJXFdTBCBejgp5xPB9i39ZbKxfmTEsBFkFZAfdH8IrZw1f4A3TdW434AYQvBOHsW33m6icGMMcjqd5r453uXIAq0Az3XKGrQBY0PPvESdWD5Rl40c0DlGLBTY5l8SY1/8PMVTFQOwfw202rTZqlcyTC8tu1YQ9xk1kGH5PCGmvTX5D3QaH8kAW+vf4lcqzPn9VqPIrWecIMvaklWtYR2rZpgqD7K0gB5jwSf9UO9sLNRnOXoiG6Dq1gqLguXiuPayq1pnoDVQGIRshmVAVBOPfI2TWw1hqnr98p0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzIS+EorfZphE3L8vZkLouOGYwj24TBhySa75d2mYo4=;
 b=rlEabvOhZIsiWWnNf/D5+nRUqqFUi4d1Xp0pVaSZWnGqYqwSJvh7UkiccZNLjv432FOiluh4FUAmTwd0u7RPzyHp9fGKr1GRTkWG5wdlRUKEAxlvYus4EUnnZWlmKsU9liNuDb9+mCOJuORCTSFRYoGQMXyCHw8kMsTdcogtdD8ccXNO4g1kReGzWQ/PUFrOIpdP9+SakG/gJ3fzosOrsFm7+i/p5NcfOB78K0ZLAU8iqkQ5KJgS/3i5ngw2IwU7V0tXG2/D2CSFj0HE/iFvbLvCoG3pBXajuj64gOTBAWuzg5YQm1tjt8VER+PkMiY55SWUbjjbEpcWEq4wa2Y/jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:42 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:48 +0800
Subject: [PATCH v3 13/17] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-13-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=838;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=qFnDLk5UGg3n289p9q9s+aG7DJldt3JWcpA6cpeJkUc=;
 b=GjNBu+OuI09YT58+qahLtFzg+HWAYfZcoBb8c9VXvexldbvpCiojAsfYEkMIoWznRTCfxRJfw
 M+vnenNXZSkA7XOV54tubUJCxDmKwb8Qe+4K20NTK/sDvExyUyLB3bG
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b09d67-580c-4fc9-dae7-08dd2bc261f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjJnc2RaVWNQekF1UHlpWmE1YkttbjYzV2hQbGE2cVhuYzNTMmRZU2xUb3hx?=
 =?utf-8?B?QUZiOGo0cWh2WGFOZlNaZHVUVHpHN0hYWGhjdE5oV2VHUUx6bW05OEF3d0U4?=
 =?utf-8?B?SmNBamlIdWN2TVYzTklVY0UwaGZ4U3AvMlNIZ2l1T29tY2NYR2tWTTZSckRl?=
 =?utf-8?B?QitBdElLeFh3a2Y0NXQyNGJndS9vbUxVeENMSzhSMm5GaUFKVFRmTFk3SzRJ?=
 =?utf-8?B?TXVxZzVQOHo0TGpJaUwxNmRJbEM1Q3l6MU1HU3V3c2VvRkdIQ001L3oreU1x?=
 =?utf-8?B?SWhaSHZmTUloNERYUnhsaHNwbTV4ZDE2OXJKeU9lRTN4dWZMZFFDekhaa3ZN?=
 =?utf-8?B?dmNUb25iL1BkS0Fzdmh1ZnJ1MnZ4VDRXQ0t3dVJaQWtKUFNYOGhjM1I2ekUz?=
 =?utf-8?B?UlYvb1grMlJVNTRybDBoblVVbVE5R3lhL1hEd21Bc0FCbEFmbGI2OUladTVt?=
 =?utf-8?B?dE0zOElDdmxRdXF5M0ZwbXc2dFZWeVlnR1cxU3NhOEllUzc3REFDNW1YdDVO?=
 =?utf-8?B?WHkreTVCdWd3a2N6UzRsTHVEOEdrK1pXUlB0T1dhM0ZlTjZMUVZGRHg3Z1Vy?=
 =?utf-8?B?bnd0KzdLRVJHOWQzOEZ6RGgwaUdNS1FlbTRHQjVYSjdQZGxtUkJEdENMYllB?=
 =?utf-8?B?RE5mWVErV2dFUEpmN29JVk1kOVp4c2lSWlZrZ0J1MlgyTEF0Ky9VUkVydkdL?=
 =?utf-8?B?WmVKK3NPZTMzVUQ5c0JIVmsxNmFPS2FtWEpKQ29YVGlrN3JhS3FjbjZiQ2wr?=
 =?utf-8?B?MEYxQUpWS1JUZ0ZJL0NhRUlFenFNalhKL1lrdGZTdWRHM2twWjY5UExnUnEx?=
 =?utf-8?B?WGlNSGpGYjl6R2ROcHg0TVBPSXR0RGpBYnRQVnJoUk05MkM5dnhXdUdVTWpj?=
 =?utf-8?B?MFZYOEl5VTJGQ21CbW8xZEZ0Njltc2k0cC9jOVMxTk1HamFmMG5aOUFWcTEy?=
 =?utf-8?B?WElmL3pGRm8vZDllWlJQYTZpUUVqVmlhaDZjVWMycWFvemwwSHk3dWhXaFhB?=
 =?utf-8?B?YmFIUlptLzJLZ0JRTG1iTUozNlB3bVQxdDd3QVM0bi80U2RMWmFKL0pkSUV6?=
 =?utf-8?B?SVB4NC9PZjd3c3dhRm5UQ2YvMDM5MmJYa1U0YmFNWmdxS2srcmpldFRyZ0p4?=
 =?utf-8?B?aGNKMGZkMGdJVnZkQ3VveUduK295ZVE4RlJyNXNHenBoK0lKK3hCZytkdDhE?=
 =?utf-8?B?R0RMSUlhM2dQNkxCQVVYQ1lzRm43dnpCVUZNcHYreWo0dGJOUFhUVTl0Vkc1?=
 =?utf-8?B?TDZQQUhvM3paNWRPdHB4d3lLS05BY0pkZUxsK1ZrRndDWk93cDVmVVZjY1RW?=
 =?utf-8?B?K3BkVmRnYzhuWERyTjRXQXBjZnBVcEFUWEp1NUlvRnQrK0pxTU5rTEJ1WkJp?=
 =?utf-8?B?ZVVzdjN0T1p6aGIvTFIxTXc0OXZ3YlFoTDZxVHdGdjhHV0dJSEpGV0lveWZB?=
 =?utf-8?B?d011WHNZeUNMK3ZVb3NnTHZJKzF2MHlmZTl3dGExVEJ1d0FTTVNhZE96RmFD?=
 =?utf-8?B?eENSY2ZLUkptL1VZRVNIbTN6Rm9MNE90QXErMXFIOXg2VXhHeStmWVZqSGZo?=
 =?utf-8?B?MjVvZDVTYTlReFhDejJWYXU3Si9QTnlLdGNia29CUlZ2cWZxYk1BbVduc2tv?=
 =?utf-8?B?VnluMXJqamtPK0g2dDhJa1JSem8wWGd5L2RJN3JDVi9wbGVyV2FXMlRyamMx?=
 =?utf-8?B?ekZ5WWRRMkVHOS9TNllaQ3ZnU3JIOXhCU0x6SnpYMCtUTnlqenNJejZKTmVm?=
 =?utf-8?B?RVA5SWZWSlZhNC95MndyOVRVZXlwUkkyanFHSW55RElNSG5UaVBnMi9JRVhC?=
 =?utf-8?B?MWhISGtkL2lWR3FRcWlwNjFVbVhndkVsSzJNc0FHdTVQNTgwakhOb2REQnpY?=
 =?utf-8?B?bmdJWlU1L3NZSFlXYjI2SUhoeWhHNGJqMTMvSHQ3V3BmcWxsSkh0ZzR4Z2Qx?=
 =?utf-8?Q?Y0KR5eht1HOL8AAJnYfdF9Xz0cUO8Dg8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEg5MzhBWUNFeGNPc2tRV1JnN1BQU0l6WUZLRkUxYStTbzBuaTVSem9IdFF6?=
 =?utf-8?B?RXpJcndITDYxc2dkTmtPMXFtMk5pK0h4WVpiVEhJZU4zSWVHQzk5MjRkL1JQ?=
 =?utf-8?B?dUdpS2wxUjM1ejUrK3lrQ2g4U0tsUFFiVDR5WUJqQm9ORkJxb1VETVB3dnlw?=
 =?utf-8?B?cUZldHhNcXhKWU1WM0N0Q005YktVcFBwMHArbEJQWjZTM3lreU5oclRjcXZq?=
 =?utf-8?B?VGlZMjE1VVdYMmV3SjBtN1JSRWFWVTNPTkVXQ0pXQTQydk5uM0xyMWR3M1d6?=
 =?utf-8?B?cGZGM1h0TDgxZ0pJY245cVh5MFZ0ZVVYWE1vNjdHTUpYM3lrYXlDNHREaTFO?=
 =?utf-8?B?MjIwdXpISSt1QWlaR2ZTWE1tUFV4QzJqQW91YWtqaG9hTVZJUUdaS1Z0RGFF?=
 =?utf-8?B?QmhRTVl0bkxBM0dpUk9HNSt4T1BOYWw4VDVhSU5ESm9hYlJuNXkvN0VFd0FK?=
 =?utf-8?B?VmRLYlV4dXl0QUFPK2xpWFZ1ZCtvVWJ6WHY1Zmh3L2UwbGQ4L2pwa3o1ZHlu?=
 =?utf-8?B?bUFZMkQxL21hZStDNy9xWDdLNUVvQmRLU202V3llcXJaMHlqN01QMVRQNldm?=
 =?utf-8?B?K1V1R2RCSGhPSHdyL0dCU2RzZjRHeFdBUUZOM0RKUWIxcHBNbWU5Yzc4M2RC?=
 =?utf-8?B?NFFLd2ZNbkRNclBYUWNxRGN6d2xaYW9QL25SQk1WaXBSSDFkZS83ZkdLRnR3?=
 =?utf-8?B?UDQ4dVQzc1c0RzJBUGdSRDdidlE5MzZwaVZKV1FiZ2ZBZHFBeit4RGJKempQ?=
 =?utf-8?B?bkhBWlZpZXpTb2EwQ1lSWVZDMjU0Yysya1pjaSs1UzY4aDVyUnMyQXlLMVYr?=
 =?utf-8?B?NkI1VUxmbmR5cW9WenUxNjJveTZCYTRGbmVVUCtRTHNkNlkxRVo3OTRITjNa?=
 =?utf-8?B?OWgyTUh2T1h3NlV6QmZCem5HL0RPR1VXMGZyOWVoTjBwRVd1cXEvdU1RWWdr?=
 =?utf-8?B?OTZ3TS8wRTN1VHVOZFNPbFpLb296K0VYZ0I0SFp5R1Z4Mm1zaS8vZ1Y4WHpl?=
 =?utf-8?B?cmdFcXdIMWd3cEh6TzNRWXk2U0pmM3RWRkViQVdiR2xoa2NkQnprbW1DWHBr?=
 =?utf-8?B?SStGNjcwM0liL0NDNkpvaGE2RzNNNDN3a2NBVG05RjFpVEhxY2I0dm9DWGtG?=
 =?utf-8?B?VmQ3SmRaU0oxMGtjTHRGbThYVVVDbGw0dkh1cnFDVVRmYVM2VFZoaisrdkc5?=
 =?utf-8?B?ZnNuWHpuaUlOdytVbXhsQ1pQNzlFaVJiZHFuT3dydnBETUprcldsM1QzaDJZ?=
 =?utf-8?B?QWoyaWpUaXdhZ1ZqdHhzMmk1dmp2eXRuK3BnS0gvL3JTSnNib3hpQ0VWR1kw?=
 =?utf-8?B?VWI3RWt6ZWtpNkthQXcybzdXTFcybDd3QURoNFVlZEZkMDhoTHd3a2E1aWpC?=
 =?utf-8?B?ODNPT3pEcGpjWFJHa0J2dEVxa0cxLzV1d245bkhqeDJ4Y1hvL0ZlVUUyWWho?=
 =?utf-8?B?b29wYnRwSHEzaGxFZ3F5TEl1aXdBdE0yTXRIbUlUT0NFRmZsbC9xZjhVWmMv?=
 =?utf-8?B?S3RrNmZiSzQ2dFhUd3VNU0xBVW5XbStXa2NaN043TElHM2tzcDBNM1F3NWgx?=
 =?utf-8?B?dS9sR3pFM2R3K2tIdk9GT1dkejJpZ2djSCt2VmtzK2FvV2ZhRmoyQThSYTlX?=
 =?utf-8?B?R2Z1dnA5MStkZEo2Z0IvR0ZPa3lVVmxTZTNSbUg4SUg5TUJSeVdpb0VwTW1V?=
 =?utf-8?B?cXBVUFdOaTIxUlJ3MFpCTWlybjRidTJGYUlUUEx3eVJWb3pOQWx2RTIyUkFU?=
 =?utf-8?B?NWdwU2U0eHNSWmVic1ZpNUJWazRKNnJ6N2lUKzJ2bmFvdXZNMWFrbEw1NHd0?=
 =?utf-8?B?SzFFRFZ0L1JIaEtTTUhuOUZpb3dTYy81ZTEyUy8xMm1SdWN3MGZQN3MrWTNm?=
 =?utf-8?B?cWZSeXB2bWExM3k3UmZOMHZUZEZ6akE5WWZ1VHpFemo3dUk4Skt2SGU5cWoy?=
 =?utf-8?B?a0ZyUGNpRVBJOHVNekFScXpybzJ0YmJMTFJNQ3E3c3pwazdiUXVnUGdhUjBJ?=
 =?utf-8?B?ZW8zZm9iYjVZRVVrNTBaRnE2THNMM2djdk5uMzFnU3FxRm5hMFA5QWJCcXZK?=
 =?utf-8?B?ZStUTkI4b0lSQWU0cmZxWXd1Q2ladFkweU9ELzBaelZpbGJWbVpJNTNTTTVP?=
 =?utf-8?Q?zBKgDlkpFNLSWU9okrbMmNDPu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b09d67-580c-4fc9-dae7-08dd2bc261f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:42.4371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDh7F2nTQEe1IixhSVq6MNiLs6uiWPhjI0VV2MXRHyllnTfv2bLrVcx8VUrP+um8UN5eHAgvnlv/ldukajycRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3787d78e28af03d40c41a8b2b1981b..daf6443aa5b40b6410f2645937239a4ec785fa34 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || (IMX9 && !IMX95)
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.34.1

