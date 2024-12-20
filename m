Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E44DE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C269A80381;
	Fri, 20 Dec 2024 03:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fQpWsP/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E548021D; Fri, 20 Dec 2024 03:55:13 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D108034E
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ9glV+iE/896MwrWRYh+xO/ldpoAkACSidNsuAkY0bTUkhCPM47V6QkUXSe7wceFQQgPPUaH+7ypU32Cf+isrxiWfthS3dLBE6NzmF3L1KlBRYVSPzb+K14swZV/q/61C1YB35sxkD7pzvH9B5BdbhA050yIW9yC+k7lJj0qJWW1ki/7JFX1QnQZt4H5avm5oBnfl8AZBFVt70gXcmcWg3qCtUQCLBwmEqM63fN/5PKKWTUNSEBxCJ+LYVO0OR6B66xwJvO2iNcSqiaLp7OyVUKhp7saba4dJgxWH1ZvxoyCZw7hCBRAjMiXl40s8x/xKALYcZATIhckYZ20O4j2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHH/BeJixfFAaRGnZvP5XqAcoUrFQBpwmuK7FnFL5A4=;
 b=Vycqw0Ok7cbOx9wFVYPRrLJp4uccewiAKjuIRiMBGBtrHdSF+aA1uCMpYl3XBGr5Fu41DTeGA2WHzHhXbsi+/m2ypJzNGTke3uWyWLOCKS+JjqyWBg1AGIAFJGRBHFtAIVqEKvUdzjpIrX1eQW8m9mrEJucPGoksAgBa1h2r0U6tsdxjREPcp28mG+//kITIymQ8j+LmFu2cjiOZTdfZrI9z97G8wRYH16txawFzyN+qWUdFP2wQzNUuFAo2gyrmm7SJPSZ4AQqvIzu/bvEFOw8mt0wc1kjdjZAwDD3yYwbTYhIrTx8keiP2L/bN3UcURszNQc0C1EylByAu3dnF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHH/BeJixfFAaRGnZvP5XqAcoUrFQBpwmuK7FnFL5A4=;
 b=fQpWsP/RuWTanDAfpH26WtryF219Omr+Xxq652TKXFj7xuleHpyDqgIPgkZHwE88Bs2gULphnpDLig+z6TzeQGL7vgUXRyo34tqCXn1ZBxkIiv0qSIfdanRVy1B9SRt0acOS4WnLZ57UlC0lsuU8fqltxtzkLisgg8dTgFgqW7kp39wrD8uJ5NywvHupDg2TMHSRBMnmrKtVW3WgFn5VtQH7bxL2L8PrOAhK2hNCoAWfK9/UjBIFch+s3/2TutGsLU7ZqAwMUg1JV9FdvuiV9zDwrSPIJHxOuLZbcPThoFxVrwLN7DTYJ77djw1ghg0SfxTetY8hbOiKL44jBdBNZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:09 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:54:59 +0800
Subject: [PATCH v2 01/17] mailbox: add i.MX95 Messaging Unit (MU) driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-1-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=13832;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=c8AVN6wT7IEHbfMf/SIFbMZZ703OWRYFC4tbMQjjxQs=;
 b=g5Q0A2LgfKyF6A1cjYrT2Jm+7ot/OOR0ogQWzC9gFOypn6woa21cHx2TUAlF00SiJuPNiaZek
 iFTJUkECwkzATH5LeDj0ltrWAjunC8lpEv4R1S6qBxRSZjGGaO+VnUX
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae613b-8e66-4a16-023f-08dd20a1b755
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXJ0TUwxVStuQzgvUWZpdXc5ZzUyaDVxdGJvSyt1cWlmNXhRdFpmdm9DUEl5?=
 =?utf-8?B?dEFpUFZDb1Uyb1FHUVJFdTBtM2RDb08ySkJNSldKYVBVT2Z5SVZsQy81dzlV?=
 =?utf-8?B?MWorUktnb3BQTU1Eb0tndFJGanZNZ2IzNlRLblo1Q2dTYkxpZW9PUFA4WUo0?=
 =?utf-8?B?OEhxWnVCRVhXVXl2TU1iWkgxaEs5WWhUOHZNUnBtSGk0aW5IVDVxUDlmalI1?=
 =?utf-8?B?YktlUlVVMjAxOWF3ZmVMdFJKdkJRd3hjOXRZVWcrYm05UWp1bXhRbXU4MEpL?=
 =?utf-8?B?SW5aRnBaRHJQdEx6MVBNbGNYSURid3orS1pKRFduVXpDd3RPaC9vNGFTRzhT?=
 =?utf-8?B?THJvb1RTeFZ1Um1weTd2cmNENnp1WFlrUnZ3Q1lGQUloeVRrZ2kraDB1ckM4?=
 =?utf-8?B?VnIwdmNTcG5xeTd2SnFnTll0K1lYNkRlTEgrcFcxd3R2RFp6UzluMjBGeEtK?=
 =?utf-8?B?VExOOG5qQ0hsaGZrTEpJVUUzZ2VwN1Vkb3hYTXAxaGJuU3NvY3hsbC9TQ1I0?=
 =?utf-8?B?WXRoRkJRWmhjNVNPUE5yQ3RXZFJhY1ptaEFndTRjNTF1R1QrOGh2cndPK2Z1?=
 =?utf-8?B?STQwaXh5SWN4Rzd6ZkY1MUpFOFV6TU5seVlOUnRleTR4YmZ3YWxMODgzUVlS?=
 =?utf-8?B?dFlJZUpPSWJmNVdjSWRjUEhFWlc1bWRkSTBUMkJyMjhnTENLclFKdWxVeFNY?=
 =?utf-8?B?TXhSTTJsZGVTb0taY3UvbGVBSWcxWTRUZXpCOHpHMzV4NUpWWVhXejd0LzUy?=
 =?utf-8?B?ZlNjaDM3MVlpQzNNejhJVUxja2FmLzZabjhuZDJiOGt2TWc1ZG0wNmIwdWpa?=
 =?utf-8?B?N3dQdW84eHUxdWRHV1hlMzJ1cXJlNmhPRm9DQ3VrVnRWbmZETWs1WmNBU1ND?=
 =?utf-8?B?OWxUdmF5VjFYdGZ0b2RVYzZGRnRsaHBxNFN2dVcydit5eXQ0Z0JWaTlMaFVC?=
 =?utf-8?B?bVpETUQ4SHE1RkJKNTNnbm0wM2x4T3A3YUFsWU04SzNheFVMUTlJem5Db3hS?=
 =?utf-8?B?N3U3c3Y3d1pnaG9vL3ExWUNCNndockJ4WUxkRTlXZGRtenM0eFh0TFREKzlu?=
 =?utf-8?B?YjhlUkNZWGpYbDJDbThZNUcxSFo0RXNKZnFxZmhld1BaNnVZdW5zMEpoSldG?=
 =?utf-8?B?bmxnQUhTbkg0NEJYdVdlOWpHSUNLNWt2YXNzaWRrTExqK2hyeUlMVTNSd1FK?=
 =?utf-8?B?ZkxrWnpXNitPYlZLcVVmajIwSUJvRGk3RGpBSTJQVmhCWWtPNDNIUU9KZ0E4?=
 =?utf-8?B?Zmhlc25wZjFBZjVNT1dNT1FsV3kvSThCV0c3NTlBMmFXTncxTk1SLzRhTFhh?=
 =?utf-8?B?cEJtUjFJZXRacVhCZTI2ZmRHZmxBK2t2TWRwUWdkOEx0U1BzNjBoU0VpNE42?=
 =?utf-8?B?YUtrTUM3VTVzK0lWN3ZFMWdtQlRTbnN2cHAwdHFndDlOd2t6OTEvdDZJTXRq?=
 =?utf-8?B?QnVUQ0dod21MRmpHeGc4K3N5eWlFRnBrdUk4ZWhIdFhQdmlRRjM1UGtzZVhK?=
 =?utf-8?B?UFNXT1d2ZUd6OXpaRUsvTGZXMEo0ODBPYzEvOUJ2UzdTcU9zbEtRR2lyRkdq?=
 =?utf-8?B?b29YODVpeElWU0RVMkF5b2Z3V2VXSi92M1NJL3V1NHd2Y3JYKzFxM2t6NGJU?=
 =?utf-8?B?NkN3d0dVMzN4QUhQSFdqRDdlaEdhazh1YWtOVEM3WVJSNiszQVZlRDRhcUpW?=
 =?utf-8?B?TmcxSVV2a1NKdEtlclYvbzhDMkQ2S2xyRHF0cTR6WWJNK3A0cVFDSmdpZHR5?=
 =?utf-8?B?NkpyeW1CSExleUEyUEsrVWVHaXpmeW1reTVJR25rRzNHZzdXSlVhcjRiWS9J?=
 =?utf-8?B?SUxWR3p5V0J0R2JZZkg5eWhjeCtndFRYazVsL0twaCtINVczbnJIM05ETStP?=
 =?utf-8?B?alRobWkrL0t6Sm5KeXZYMmpYRDZnengzZ1V0KytjNnh3aU9ZSng2Q2c0Uzdl?=
 =?utf-8?Q?DkdHFJeI2z7ih3dHrPYgKYhMeG6klpBI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlaRkRaZG85T2NZZTBrTG1wcm5rd3BYbEJwZU5kTlFHRlRsWXJ3RDc3L0hE?=
 =?utf-8?B?Ky9haVVaWmdlTFNNTTh3eFNqVjFhTUVWdVg1SzJUaFRnajdFVDM0cGwvbzFy?=
 =?utf-8?B?M3lmVUFPaEdTZmJ4WlpUN2lMaHhDV0xmZ0FiZXhjWWdmUUJxMjRMVE9Ha0hK?=
 =?utf-8?B?WTNEN056b21pZUxlZGRxZExDdWp2ZS93a05ra3NWQmRRQXc4RlZTc04zK0xr?=
 =?utf-8?B?THZEaFlFQjNPdnJ1YW5MeSs2cFArSXRORUJJSGgxQkRkZXBxdjVxLzBzWUJh?=
 =?utf-8?B?MnVxbjFlMnBkVjhpWlliMGhZVjVJWXczRWxtN0FuY0RuNmZxcnFzR3ZvblVh?=
 =?utf-8?B?NE1uUWxyT0ZhYzdHSjNVcmxiNHY4MjdndFQvRmdFeXZNa21IdHY3WTRJK0FO?=
 =?utf-8?B?NW95aWVjckxqTGZibXE4bmJNTUVIQ01QVkNoUjhyV1RxQlI3SFNZQit1OEpV?=
 =?utf-8?B?Nm9ZUllROHpEUExOSVZlTHhTUFRUNGc3dFN3STZqV1pwYVhZRm9oMENwT2s4?=
 =?utf-8?B?VmNZSk5WRlkwcnBRczN1ckZBaEhGcVNmMmVDajRFWGtOVDZ4R2NWS1FVM3N4?=
 =?utf-8?B?eFQwd212aExvMG5TMWVFMzgydEppOXJmeVF2cmhhU1JuV2FPVEJ2VHFXRFJS?=
 =?utf-8?B?eGg4TmlJWC9hRG1lQzViSzVXVGwrcWZQTVRNVjczL3NTZlVDNm4rbW5mR1lJ?=
 =?utf-8?B?b2taYUZ5eUVBR2xmb1JKU2UySnp4Ujgza3UwRTlvQWJPbE9wVUZ2YTE4R0lW?=
 =?utf-8?B?RTFqSFhMRjRMK1lCbURLckFsSmw3OHFTNHdLLzlONW1BR0Jmb20vQmcyYzZE?=
 =?utf-8?B?RHNYMlhGaUM1N1gwdlRYbmg4ajhkSzc5aHRveVVNc0hwUllFWTVXZTdtOWxP?=
 =?utf-8?B?a0d6ajNqQTQzU1Y0RW9qaS9VckZOVFdmRDZqWGVURFF3KzlhUjhpQ1ZvVWRh?=
 =?utf-8?B?ZXF4OG8vNFJQZytkTFY2M2I5ZllGaXBsK0s0Z0luaEN3LzJWbEZRM013U2Jo?=
 =?utf-8?B?V0hEbnc4SHFRUFU5Qk8vRmJQWTlsVzlDVU9PZnFIaGc4ck5hZmRMVEJNeEI4?=
 =?utf-8?B?NmFVVGhsQ1BpNVpScUhjSWhOVjMraTJ4TzR4R3hNOW1UL2FwOFYwTnFVN2RY?=
 =?utf-8?B?bEZHVnQ1MjFBdEJPMVVHQzJNTGRvaktrQXJrcTg0UXY1RFBkb3pmS3ZDSlc5?=
 =?utf-8?B?aFJCOFhzUHRwNnZqeFluVmM5NUgyS3RsSFR6cGJ5UGNkcllVeTNRd0N4eE8r?=
 =?utf-8?B?YllueW12UEZPa2orZXFyU0lMY1RXVUVCQlNsS3R1NWFyYXVsbkFsU2ZaYXdr?=
 =?utf-8?B?eXdRdDR6MEpaa003c245M3JIM1RwN3Y5dUYrbDQyR1VSZGtFOHlnL25hNk12?=
 =?utf-8?B?a3cvSkNCaXJvTG9OOVQ5aW5rWDVRTTUyaThIOVZabGsvZjEyMGVlV0dBMjhs?=
 =?utf-8?B?NExwckpVd1RJSW9CeVkwdGhhUXRORU4remZhS1R3c0pZQXZUanlsV25aaWVR?=
 =?utf-8?B?YXpWWTFRaDF6cno1Y3hrd290bFo5cnJuUVRGaHdMTERsMEFySXdqRFVPdDBO?=
 =?utf-8?B?TllFeVdEQ1R3UUZlZ3M3YXBOZjZETlhmcHgvWERtSnZodUNqOExReWwyckhs?=
 =?utf-8?B?SXI0eTVOMStPVThVUVpVSWZOb3dza0dvUnZybUlTM0Fjem5TYzhzVUtVelNh?=
 =?utf-8?B?UHo5M2s1ODZvVXkzd1lBV2k5eGRDVUhsZ3VkTjBaSGZjSzFEclJ6TER3dFJE?=
 =?utf-8?B?ZmpXWE0yN0tDOEpYRU1VUmduVzlZSmRWUHk0S0x1dEJqWDQ2SnUwU2gvTS9C?=
 =?utf-8?B?V2JObXEyQWNScVVQWHdyb1BVZ0Izc25sZWdBNXIwVERPbnRRRUNMV1p6RE9j?=
 =?utf-8?B?RUlWbXZ5TEQzUXBDYno1NzV4Ny8ySXF4ZC95NmtxaFZRbXAvNzRtaHBNNVNp?=
 =?utf-8?B?dXBFYUpTcE8zM3RZN1hnZDg2eHRkall1a21UZVJHcXZ4V3dZaW9qQ1FyZVEw?=
 =?utf-8?B?K2t1WFpmUDdXbms2d0xBN2M2c1RnSTVCRjVGMFRDSlVOTjBnTWVKcTgzR2lk?=
 =?utf-8?B?UHJjVjRzOWI1M2t1cVg1TzN4a2xWbTVjakZ0em5wUGdmZ2Z1azdRLzhMUU5y?=
 =?utf-8?Q?Ivl2f84EXyQP7/8BvSiU+cz0J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae613b-8e66-4a16-023f-08dd20a1b755
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:09.5257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGzIiZR7XJ7zowtSAASFgeQey88kfhOz6BLTsZH4iJwrBTFgaS2hUxnPmSK3g6GrITDaleFD8LcBQ1ARIYBTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

From: Peng Fan <peng.fan@nxp.com>

i.MX95 Messaging Unit (MU) enables 2 processors on a chip to communicate
and coordinate by passing messages (e.g. frame information, event
notices and requests) through the MU interface. This patch provides a
driver for i.MX95 MU using the common mailbox framework. Currently, SCMI
exchanges on i.MX95 uses a mailbox transport with SMT format, and the
hardware used is this MU.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 MAINTAINERS                   |   1 +
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 417 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 426 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6da266cddd160a041d0594ac86d274..5ab2b72d0f93afaf70c4c2dcb8fc48210683b749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -313,6 +313,7 @@ F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/imx/
+F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74228ccd82b2725c0bb745354d099948..4d9f004ebad7f57034a6cdae3bff9645fa0ee67d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 6072fa1956b793636c35aa0d1419c9dcaae27095..574add60005fe73d2beba715a12e0157fe4b0552 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000000000000000000000000000000000..082c7740f4fc0155dce0e0ce861fec27f7a24ccc
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2023 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+			val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

