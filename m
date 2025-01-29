Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DE9C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6298083C;
	Wed, 29 Jan 2025 15:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="C+gLNs/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822A4809D4; Wed, 29 Jan 2025 15:54:09 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E420C8083C
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wo0mDV82Tee8q0tJiRutOgKLUhL6kixiysUnYBKniwZ+UwAJ+yFPmRzvGeAfVIOeLl423Uk2iqy53bkq/JDuhaUgZG0UR6HNIDhlOvQ+oT3+fDDCAWARfXXtDW4RV6Kb86r2fPiQtM3j/67RpW16hG+hwS+16CYk98VSvkSe6Yr4FYKC4v3+z3zwnpr0PjRg67tUsMkgYqpBCUCppivxnWLlvILqEAP+rhVOHhcsTwB8loZNX7VlHI1voagj9CoZx1E/UpOlyYQU2U/xwjUhklZFNMm0gpK0Xv35AsCW6MsG6VhFtZEtBuZ943jNZJkrDJffjiIEgeA8iuhH8C3D7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WciX8sDpIJDMA6f8ElYw3scdMsdrMx31irYGdaiZSGc=;
 b=hRs6Z/wTlWvhr0cTaCzotFlD2RepwMqTpP5tB1FLlNNF9w6HG9E3WZJlab23ytGiHeJIc6vZDJdOVYt+A4c+TSpXQKr3R/kpejIh1yCk67TC0Z31SrldDfslkDq7ZlUT3m6TrHSVTKTOvPtM6vfcXS9DOE+RIMWxivwNH49hV+9E17bvhQvsl2WkPw6K98WCTi19mlHAm8eWs4BgmM4FgcmkWfRUWTwEzFqvcxkW3cpGfoim1ZAywoACQiLOIS+x0wJiZndFkPubmOLKnpu7Gtkzn54s+mmZe/FVIo9DApSrJIX57gZu/AYyAQB6E5xIRgexDMvC0AOzPT8LKHwudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WciX8sDpIJDMA6f8ElYw3scdMsdrMx31irYGdaiZSGc=;
 b=C+gLNs/N11NJyQr7pEldLmzdovDbOw5KyqGHSVTdDBvbCcEhfSo0ZbKLTN4r10D3k/eAkMbtRnIABk4zF3zHNGPdi5XYLbmGpamtluj2Uu/8hQwTLjKW2wa8rTyOTbCYjedaEeKyZR7/XWiqOVi4ZqLH/pndVN/5StIugoiY8BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10830.eurprd04.prod.outlook.com (2603:10a6:800:260::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Wed, 29 Jan
 2025 14:54:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 14:54:03 +0000
Message-ID: <3bf8432b-619c-4834-8d0c-c91f45a8f167@cherry.de>
Date: Wed, 29 Jan 2025 15:54:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ARM: renesas: Simplify board Makefiles
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
 <20250118111621.362188-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250118111621.362188-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0197.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10830:EE_
X-MS-Office365-Filtering-Correlation-Id: 359ffbc7-6903-4ce5-d415-08dd4074c51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHRKVnVKQnJ0ZGJldFA0clhVdUZYNFI3TUZIdFg3ZDRhcTFoOWtOVjYvdXc0?=
 =?utf-8?B?UnFRR3kxTnBtUlREWSs5Q3k1cVNkOG5NV2NveDZkU1FocjZ5aE51NzBVZFd3?=
 =?utf-8?B?Yk9EK3hOV1V2UHVjbjNGa3g2WnM2c2UrV21RUHdCTWJXQUpqbXRsTkNJL251?=
 =?utf-8?B?V2RDOUhtRTNER0ZrZnFmejY2d3l0L2gwZXNQN0twU0hsb1REVnVGZ2Nha2RV?=
 =?utf-8?B?akhOd0RXWTZNUFVzZGlMZXlQYVh0dTQ5SkVHWVNZZXdjWkt3Z3Nyc1cwVDNZ?=
 =?utf-8?B?ZXFuRzB2OGdMMzlZWWluaWpKODN5dWtZY2ZHM1dVMUpRTFV4RXBWM2diN2Y5?=
 =?utf-8?B?VTRMc3lKZG11SVp6Q2xaVXVKRXluMFlPRjQ1dXRzRTcxVktKMmV3aDMxZjZu?=
 =?utf-8?B?dFdhYkJzVHRoSHBGSUVOSE96YUZ0MVVwcDlpWHJlZU9PRzJvUXl4Y29xenZn?=
 =?utf-8?B?dzU5U1Q2SjVoN2J4eE9DdHh3dkdTT3ZlRVRvaDFJQ0tHM2RrWFdxdUJvWHFk?=
 =?utf-8?B?U1JkY3h1SzkrdVhMSTZ4cE05RWhFNnZkVEszWXd6M25ZR0RzOWoyT21EVnJm?=
 =?utf-8?B?ZkVWQ0pNRVZGREtIeUZrclJoQ2dLc2pocjZCTFYzZEYxcWtFeWxudFpndnNr?=
 =?utf-8?B?Wm56VCt2Si9lL0JzaERYRWcyZXFsTVFQZG0wUnl2bGFUS05wbmh4dXVic1ZH?=
 =?utf-8?B?cTluMTU4TldzVmZtOWJTNVpIZmJ4bkVRQmRFdEZWeTlKamM3M0JQWlRGRkZO?=
 =?utf-8?B?RlFCK21OZGxsWTlMYzlSQUdmUy9zV3ZGMU9xYTQxQ1ZhK3M2eklZNjVFMHV0?=
 =?utf-8?B?VGhUNzRzYUVpSllMMHp0S1lGTndlOW1tRUNwMDBZTSt4SUFIYXZIT05lcVkv?=
 =?utf-8?B?T1lydEJIbzJ1S3UybmQ3ZmZpc0ZRSDR1SlVVZ2ZURlRjTCthSGdXWDNvNXZz?=
 =?utf-8?B?ZDZicmpRU0MxaFR2QVBkQWxuYWR6ejhzSGR2T0UrZnQ5MGF5L1BwVWlwYldl?=
 =?utf-8?B?Qnh5RjdiNEpNYktJMXZCbzdFY0o4NWN1cXQ4R2xuOFdxTm5PV2ZYcjZnZXJY?=
 =?utf-8?B?NmZ0N1VNVU9lbWNPcFF6QmY0UnZGQk9BVExCYkZLcFg3bXNzSnlzSnRVWmNt?=
 =?utf-8?B?WmRGMmgrYUsrSWpHUS9aZzlzaUNUc1FwRnBWTXJLOGQ3RVdPR0ZEUFMxSWt4?=
 =?utf-8?B?cll6TjBGQ2xoazhnSWpzR21RNXZhdjViQ0dINWg0ek00RmpERURTVzlEaVVz?=
 =?utf-8?B?R2QvL2Y5Wm43VzdlelVaSU4rWGcwL3djSHBYRVJadk5vd051Y0JyWFpMN1px?=
 =?utf-8?B?TGUrdWtsQ1dDcUtKRyt5Z3lrVStuK0xXeEpzd1lLa1BjRFllQXBNUGwrZDhH?=
 =?utf-8?B?REZiWDNzUlNDNlN1MkZtR0c3Vm5CODRFVVl6WDBkY2ZWWm1EZzk0M3FldmFI?=
 =?utf-8?B?REcwUEQ3bkpINW5McS95VnBqd0xncGVLT3huOEZPVExjUHdSV2MyZ0lJQ1pY?=
 =?utf-8?B?aVlHL25HKzhuM2V3a3BJV21kZHVpNG41NG9BWlY0a3N5QTlQd3ZvTXZjS3p0?=
 =?utf-8?B?UWpsU3hTbFZEUDZNbnNqRWl4ZU0rOWQzS3FKZ2oySU1OeUlvdW9QaUsvZVFB?=
 =?utf-8?B?bGREUDN4bGZpUlFueVlPWDRLQnpmTjg0N0VmMmRqZDQ3ZDhSdWJ5RTh6WktZ?=
 =?utf-8?B?YU9udEVjWGdCYWxqUnh1ZHdpby9WVEV6N0JoYjI3eEZIUlpzbGJnM1I4LzB4?=
 =?utf-8?B?SEFNS1poM3orR0RyUzUzelFtOHdneVh6TDNaT1QzVldqMmhaKzFLWGQvdVh6?=
 =?utf-8?B?cTEzcnNrUGcxaUNnMjVJV1ZRRlJwTTlKazdkT3RyMjhJRnBSNHlwanoreWFE?=
 =?utf-8?Q?iza9NRSCeIbO5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFdYb1VMcnFNRkZNZm5VSXdlWC9PUENTL3QyTGM5bjArdm9Ec1BxUlFCa2s2?=
 =?utf-8?B?eThCSzIvUC9obGk5b0tGdG03cXNhV1BtRklJNThiWjlBU2E3N3pMSnVOeExK?=
 =?utf-8?B?MzBnY1duMXBncjVPSlNPSVV1TnlWclF3eGg2Q0lkQ2JIWkZRRzVFYzllb0pq?=
 =?utf-8?B?YlFla01RUzJ4QWFXUy9tTGl4Umo5WFR2dnpoUmE1a1lmVXJGVmxtNXNEZXFO?=
 =?utf-8?B?ZVIxc3EzWXNuSExPK2pWbGhZdzhjOFQ0R3lqYWh1cnMyUUE3cnd1UnJXdk13?=
 =?utf-8?B?MEFnemk3bDU5NXlNNEJpTlR0UndzaThCbTFNb0FnV2tPQnRXUk0yN05GREgw?=
 =?utf-8?B?T3lDY1lJeHB6aWJYY1RzY0szNlZOdXY5NkEyZlI4ZC9JeC9pZGFiQWZxbjRt?=
 =?utf-8?B?dnhxT0R1ZnY4cXN6Zmh6VXU0RzlkUWcvMDl5N1grU1NTSU9BckZuVnd5OWJ3?=
 =?utf-8?B?S1Z1UnVlSFZRc0FyTlliRFd6a0pwSFc1SENzeGtwdDNiQnNNcWJFS0orb3p0?=
 =?utf-8?B?NUdNeS9Od3ZDaWltUU04U2xXRDVwZDlXYkV6bkpFUElIWmgzMncwRjc1cy9u?=
 =?utf-8?B?V3NVaWtsdVpZcXNiL0FUaGxTeVR3d2FIUTVsUUMxMkxYVndHcDRkUDdvaVgy?=
 =?utf-8?B?K2pFblNlenZMUldRZW1Cc0M5TGRjWDdVU1RGUVkyQk1UL2h0NWUyWEcxcDVp?=
 =?utf-8?B?Mzdnb2FGZjNjTDNUUDE1M1gxY0FLWUQ0ZmVBVStQMkFDZjk1blFJbG8xaWxy?=
 =?utf-8?B?UW03SFZvWE5xd1ZkbklqWE5TV1JQbnUxOTM1eXhESFA3a25WenNTNTNJNC8r?=
 =?utf-8?B?SVdFMlVIOWxLRXlUZEtTS0laVEJlZXkxOVJSbytkSzNHVXlOZWJuZFJDSXFV?=
 =?utf-8?B?WU13VllMY0VsWG1wTTlNeWFra1M2cDdUSWVXR3lxR0VlakJhMUJUWlIwY2sy?=
 =?utf-8?B?MGhvSkNPZmNxZWhZY3NrMmVZL3I4QlkzVkhlOFVtckZrK1NDSkpVRGRTcXZt?=
 =?utf-8?B?UnlMZ2c5UXdOK25HbjRrQm9wU2EzT3praE5qSU5xeHRydEZpcWFGaTNwaE5E?=
 =?utf-8?B?ajV0S3FEeHRkZU45dTNHbWxoMURVZE1zQmg1VkV4WHkrV2RCelFISWlpWGtD?=
 =?utf-8?B?anVIOGxBV3RUekc1dU9LZURBTDJkS21yY25oenVkL3NoYTBEcWVkbzFTOXZ0?=
 =?utf-8?B?RzR0bFg4U2lqeTBOMHRXRGN5UmlOY1hPZTJEVTJvSGh1NzdncFllSS9vd2ls?=
 =?utf-8?B?YVppZEZzWFNmdnZ1SHdvOHVYUityWDc0aStCV01mZVUrKzVqQ295V2ZhZSs4?=
 =?utf-8?B?VmVZOGRlb1RkKzRHM0didkV1c2t4ME44ajcreVpzRXFZSW1DTFFzL0cyL0NL?=
 =?utf-8?B?MyswWGJYeGMrSVhRb1RYNldrcnlkV2IzQmlWUFllLzBWNmVjK2hWaStMeWY2?=
 =?utf-8?B?KzZPeGx3RU9XZEh0TjZBOXlVczQyaVJtVmdMN0RQVHZWeXhXSHB6MUVlVlpF?=
 =?utf-8?B?ak9Qa2oyK0RKLzZOSUp0ZWlEdWNzTk12bTM2aWJRbWgrNHlZSUpCelZaLzNy?=
 =?utf-8?B?QUdGQUVEN1V5TUo3V0l5T3BWN0YrUDJsOEJKMDZ2UjhzZDhkTDErdTRPYTdQ?=
 =?utf-8?B?VS80TkM5T2JjRFVQdGYwYTZ6Z0Q0a1ZiOGw1VlRmSkRLamt1U3JHSWJMcnJt?=
 =?utf-8?B?akpBRFVCYVRaYzU0TEtpSTQ1ZHNORU5BcUdXMVhKRjFLSmJvVVRCN0d4ZVlh?=
 =?utf-8?B?RHZ4VGNrYTVDdHcrNGJPcURTVEc1eHBkZ2J1TmdIeGE2SkJSd1YyT0o3NEll?=
 =?utf-8?B?dXdKcWxCcHZaZHcxYUtxaWZaZ0NMQjh0d3NQc0tBajF5Q2pSMUNhOHA5NW1I?=
 =?utf-8?B?VkdNYXVmKzlTaWFNQXdEaXMzSnhVcUg4NVhMd3paM01nYnF2elNHd01LUGUr?=
 =?utf-8?B?blh5RjZlRGZvUGpnQ0NGbUkzR2lRNzJNMUREWktXdnlWZDJxMmVScFo2d0xK?=
 =?utf-8?B?RnR2UUVSeG1sRGJTUlRmck9RaUwxakpWdit1SnY2dUVZM21zUS9mdTlNd2Rk?=
 =?utf-8?B?OEZ4MnBldFlqdjNxUC8vWVVGUGxNQjdoTWdpbzNIYjUwTTJ5Q0tYZEdEZ1hp?=
 =?utf-8?B?VXoyRnJudHFGWVBpQmZNOHphYlNybkoycWdzaVZ1MU9YcndEczZoalBVdy9u?=
 =?utf-8?Q?gDpZmwi4G39+0trbloIGB4E=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 359ffbc7-6903-4ce5-d415-08dd4074c51a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:54:03.3464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHfcFn7jVwLPA4UmToEW9DWZkYguERHeycIBkzZlEA8kd7RS3+TYxc2iJb5KNB4hUGhR3BNUt4TrWpwbB8kvQ1z91MuXhr9W587rjOiO8+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10830
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

Hi Marek,

On 1/18/25 12:15 PM, Marek Vasut wrote:
> Introduce board/renesas/common/Makefile and remove the multiple
> duplicate copies of obj := ../common/*.o from board Makefiles.
> Let the build system include the common Makefile using the
> HAVE_VENDOR_COMMON_LIB and build the common objects that are
> shared by all the boards that way. No functional change intended.
> 
> Some of the remaining board files which include board specific
> settings have been updated to use obj-y += to avoid rewriting
> the board obj-y target and avoid dropping object files from the
> build.
> 
> The board/renesas/common/Makefile is now also used when building
> RZG2L targets which also set CONFIG_RCAR_64 symbol and 32bit R-Car
> Gen2 targets, however, this common code is specific to 64bit R-Car
> only. Inhibit the build of this common code for RZG2L using extra
> ifndef CONFIG_RZG2L and do not include any code for R-Car Gen2 so
> far.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: Depends on https://patchwork.ozlabs.org/project/uboot/patch/20250112223252.179123-1-marek.vasut+renesas@mailbox.org/
> ---
> V2: - Add paragraph about RZG2L/R-Car Gen2 at the end of commit message
>      - Add ifdef RCAR_32 around ifdef RCAR_GEN2
>      - Drop paragraph about non-empty Makefiles which was bogus
>      - Drop the ifdeferry from board files again
> ---
>   board/renesas/common/Makefile      | 47 ++++++++++++++++++++++++++++++
>   board/renesas/common/gen3-common.c |  3 --
>   board/renesas/condor/Makefile      | 13 ---------
>   board/renesas/draak/Makefile       |  6 ++--
>   board/renesas/eagle/Makefile       | 13 ---------
>   board/renesas/ebisu/Makefile       | 13 ---------
>   board/renesas/falcon/Makefile      | 13 ---------
>   board/renesas/grayhawk/Makefile    |  9 ------
>   board/renesas/salvator-x/Makefile  |  6 ++--
>   board/renesas/spider/Makefile      |  9 ------
>   board/renesas/ulcb/Makefile        |  6 ++--
>   board/renesas/v3hsk/Makefile       |  5 +---
>   board/renesas/v3msk/Makefile       |  5 +---
>   board/renesas/whitehawk/Makefile   | 13 ---------
>   14 files changed, 55 insertions(+), 106 deletions(-)
>   delete mode 100644 board/renesas/condor/Makefile
>   delete mode 100644 board/renesas/eagle/Makefile
>   delete mode 100644 board/renesas/ebisu/Makefile
>   delete mode 100644 board/renesas/falcon/Makefile
>   delete mode 100644 board/renesas/grayhawk/Makefile
>   delete mode 100644 board/renesas/spider/Makefile
>   delete mode 100644 board/renesas/whitehawk/Makefile
> 
> diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
> index e69de29bb2d..c531738b22e 100644
> --- a/board/renesas/common/Makefile
> +++ b/board/renesas/common/Makefile
> @@ -0,0 +1,47 @@
> +#
> +# board/renesas/whitehawk/Makefile
> +#
> +# Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +
> +# R-Car SoCs
> +ifndef CONFIG_RZG2L
> +
> +# 32 bit SoCs
> +ifdef CONFIG_RCAR_32
> +ifdef CONFIG_RCAR_GEN2
> +endif
> +endif
> +
> +# 64 bit SoCs
> +ifdef CONFIG_RCAR_64
> +ifndef CONFIG_XPL_BUILD
> +obj-y	+= common.o
> +endif
> +
> +ifdef CONFIG_RCAR_GEN3
> +ifdef CONFIG_XPL_BUILD
> +obj-y	+= gen3-spl.o
> +else
> +obj-y	+= gen3-common.o
> +ifdef CONFIG_R8A77970
> +obj-y	+= v3-common.o
> +endif
> +ifdef CONFIG_R8A77980
> +obj-y	+= v3-common.o
> +endif
> +endif
> +endif
> +
> +ifdef CONFIG_RCAR_GEN4
> +ifdef CONFIG_XPL_BUILD
> +obj-y	+= gen4-spl.o
> +else
> +obj-y	+= gen4-common.o
> +endif
> +endif
> +endif
> +
> +endif
> diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3-common.c
> index 05b01c846c6..94da00985d3 100644
> --- a/board/renesas/common/gen3-common.c
> +++ b/board/renesas/common/gen3-common.c
> @@ -18,8 +18,6 @@
>   #include <asm/arch/renesas.h>
>   #include <linux/libfdt.h>
>   
> -#ifdef CONFIG_RCAR_64
> -
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   /* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup. */
> @@ -178,4 +176,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	return 0;
>   }
>   #endif
> -#endif
> diff --git a/board/renesas/condor/Makefile b/board/renesas/condor/Makefile
> deleted file mode 100644
> index 3b1756b44cd..00000000000
> --- a/board/renesas/condor/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/condor/Makefile
> -#
> -# Copyright (C) 2019 Renesas Electronics Corporation
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/gen3-common.o ../common/common.o
> -endif
> diff --git a/board/renesas/draak/Makefile b/board/renesas/draak/Makefile
> index 6ce05bcd649..0a6a325d761 100644
> --- a/board/renesas/draak/Makefile
> +++ b/board/renesas/draak/Makefile
> @@ -6,8 +6,6 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= draak.o ../common/gen3-common.o ../common/common.o
> +ifndef CONFIG_XPL_BUILD
> +obj-y	+= draak.o
>   endif
> diff --git a/board/renesas/eagle/Makefile b/board/renesas/eagle/Makefile
> deleted file mode 100644
> index a5c18d81eef..00000000000
> --- a/board/renesas/eagle/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/eagle/Makefile
> -#
> -# Copyright (C) 2015 Renesas Electronics Corporation
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
> -endif
> diff --git a/board/renesas/ebisu/Makefile b/board/renesas/ebisu/Makefile
> deleted file mode 100644
> index 72130b76234..00000000000
> --- a/board/renesas/ebisu/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/ebisu/Makefile
> -#
> -# Copyright (C) 2018 Renesas Electronics Corporation
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/gen3-common.o ../common/common.o
> -endif
> diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
> deleted file mode 100644
> index 949953f6981..00000000000
> --- a/board/renesas/falcon/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/falcon/Makefile
> -#
> -# Copyright (C) 2020 Renesas Electronics Corp.
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/gen4-common.o ../common/common.o
> -endif

Was this a mistake on Falcon? It used to use the gen3-spl while being a 
gen4? If that's the case, please have a separate commit to switch to 
gen4-spl before this one. Otherwise, I believe this introduces a change 
since Falcon is a gen4 and will thus compile the gen4-spl and not the 
gen3-spl like before this commit, so if that's wanted, we need special 
handling in the common makefile now.

The rest is fine.

Cheers,
Quentin
