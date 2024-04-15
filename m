Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192D1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D57588229;
	Mon, 15 Apr 2024 10:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="bFbXZjBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2245988232; Mon, 15 Apr 2024 10:58:40 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D698820E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXj+43u74UyLpFrGws6fgEk9UyjAcHsO7qLeeDX+r3ImvotqG+K+2Y1i865COPa1rjP6BBmiEfi1w0+oPmVoznGYpXhiMIdCsNw/HQJGto5/z/giBUhGJl4xvEv+NpAUyLplKP0Jpv48JMwczlHcPSUxPIN4pBPlVOMXhWEizPCU0YKpVa+wScqhMF/QBHqOE5eEKc/hymyvKX59MJgPqtQtkKpoXDEvsabcB+P06lyL94bl1vtmmlWG+C3ZG7cuBUn6IflJPH+B0AEQvd+QRLx/eUxmzWiEnl8dbjKuKW7s+FsmIHeRiEbTBFVak2HglhE/ekb1ssMjlL11+cVSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtR6c/S5tg7bxiq4kCxNqHx6XWSCqeLhb/E8FPakVbg=;
 b=nPGmp1SNdHuruTfAwi10cBCqVIfIJQGdvyGnC0oPVN7qikLrYXMB3CQ+Q1Zn1tT/FYaSjw/JebsApgXWLXPCzXkDrxplBT+/4yKZmw1CMTfbXLFa/qXrnQEDq36laqd9IvhzJKTThQeUbhIxB0CS8NdSqDKAOV07qW1IpQTukMomZPDv1wABanF+7s47uAwtGk+jpVK1YwmcVjHNbADoAGOYJUTZVHCDOhoUAr8TQaM1ESCuv4XPMI4K4rhXdPbG6oX9gHFXoPLFXIeyd+/n2TXncHJy6y1t5rdg58SvsWvHC4qck7wU30nD7Gj5nQDMpFeYQIcIIEXNr4W/wnU++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtR6c/S5tg7bxiq4kCxNqHx6XWSCqeLhb/E8FPakVbg=;
 b=bFbXZjBI2vAcHNSYFzN2yRnVa3FWbjzEmlocnlRgLLZa3JhjwkrkKmYhUUTEkxcexVULAFna2jA47pDi2tE8VrHL60afPeCShWyal+qAiXsn2uFpqUKoAew1vhXHaNHE97U0ndxXS7Ms49jlGR2La1z/0nR52SbKT0YjLCx3vM8SQGDb2txVbmdJbuFymjWbkCJOmovv2u13jRRngxOFsK7v2LCWGI+GblMzlSYk7i8mLetp1L35LgbaN+gz+xfxnzGgKrxN/6zwzk8dS279iKOVt3mZb3mhx/WRo62Q1HG1wAZU79lRCMln78Lh2DmmjSRxuPid3d/AIzj0ioVHBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AM9PR04MB8440.eurprd04.prod.outlook.com (2603:10a6:20b:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:58:36 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:58:36 +0000
Message-ID: <ab33123f-05a5-4edd-b720-a5b8792d5443@theobroma-systems.com>
Date: Mon, 15 Apr 2024 10:58:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/23] rockchip: rk3588-toybrick: Add missing Kconfig
 options
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-16-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240413181425.1384357-16-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::14) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AM9PR04MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3f23f3-89bf-4ab9-fb45-08dc5d2a3c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idS5HR73RkXRxjt+7ZXjSc9EtjmkX2YE+hKz9RHUbMwsJfEUto7CeMyZSUfu+GVmTyyb3r6vITrANp2Cu6ekCJSCd6bA7MqlaRx8KBenh5TiDQlvgBuBikMvNbxH6k/UQ6Ze2db7cs9RM+bZ1sPPDavIORu/UFwyxbffP2FNnYCV6k/JWCvyUh5Tqr9Yy7BPNk8un/YdbWL6u8PrQnOuewB692fr2xiulm6l1/Z1yA+jWjqFJrtVCUmsE+r2H9/IFiw0zvLBSTUROsn1qLuC1424oFk6A1cQV0r63lD11wTMcjY89M/wv34xmOrOQt/7yYcxtvVWT0+8To2eu1XCyAXAVZ+bNx8cve4PaXelqlAW02pfuQVKthF6Jb8WWQTV5Tzdxn8Pe6k7AyLrm8cRDcvdgjg/oA1LTsgbsZBQtfYSoCNCw3ufvJqexryu3NwM1mG3yxeh96YuCjp0hsO0pe51KrBrxNzB/FJPsjIQpcmqG5QIWrZmHt+nNH0QHWsTCogkC+Kf/BJKkZmWocvZkjNUdVZjnoLAYjOJyH4omN8zz0rVOAcEj8tGj5tEyTpwW8OBqVr/ISS2KcBYOul9VBL0PFlOx3k2ByoKOIaWuDQrGngqvhq7QJjU2up9wqvSrTZ/9y9/xPBM9JG4lsOQH9vqlxZZiuk6YGbQGZwadi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFY5amtIQWRaT3dQM2RNUmRlV1JnK2t0dUNtM3ZHWnpFMFozejVRbXhVSkta?=
 =?utf-8?B?aDZRWDVOdUswSjByLzJFYU1tNmV4QzBPdkUvQXJCSzZSZ0xHQ2F1S1U2bWZB?=
 =?utf-8?B?azBJZTIzUVZkMjFGK3RPaVpzVnoxUURPQTlEVmVEV0dDNmxRc0FLLzc4Z0l0?=
 =?utf-8?B?N3IvenN2b3lNRTI5U2wrM3FPNzd0b0pSaFRxSGJBUXRBUkttVlRxTU02OGRs?=
 =?utf-8?B?aUcxT2VzMFZWcXJIRHFkb3BaZGlXNUt4aWdJMk5TL3NlM1FMeU5NM3hYckJ6?=
 =?utf-8?B?clBLbzlLamdkeElrb0Q5NDUxUzR1T2tzOEtnLzZvV2x4ampodWhrTTNxaVl4?=
 =?utf-8?B?NWYzQm5mMStWSU04c3RhYWNFK1V3U09sVGZYYTJocThBS3IwaUxxRnRjYWc2?=
 =?utf-8?B?QWUwN2ZnMzFqZW5GOVo3QVU4eVlyRFM5cGgwdTE2TTRjNVFvZmE5V0EzNUt1?=
 =?utf-8?B?bXlvTSt6SittR0crci9tUVF6RE8vTFZOQ0daa1U1V0ZvQnY4bDlpRDM1TFAw?=
 =?utf-8?B?eFNKVjg0KzVmcHlXQXhQd3Rja210dTFianRoNzUxd1dMeHpnRFU1VkFUc1pv?=
 =?utf-8?B?SUJZeVF2cmVmVDB2ZU4xeWN1VGh5M08wZFhvaHdCcFNvWXlCaDZiRXRkOXBU?=
 =?utf-8?B?d2tyVzZ6VFpST3psMXI1dzVjQmlsMGEzSWtkeUpJSWQ3WWYxM29DR21XQ0Er?=
 =?utf-8?B?N1U3UXRFUHNSSGZreDNhS0dZeEgxRUdIOTlkZC8wLzgxUnNEYmFBVTJDaFVD?=
 =?utf-8?B?dGFPL1NpNlpVYTJFRStDUnRidmZQQmxHcVI4QS9WUnk2NmRyUkxUZ2tYN0VH?=
 =?utf-8?B?b2JHQXRLODVvdTNROWRMeXBOMWE5ZG9tckhvRXNQVSsyUkJ3UHFwOGJydHND?=
 =?utf-8?B?S2ZLR2d3WHk3YVEwMkVmVDJHbVQ3U3hNNGhLVEFnaGpEL1Y4TlNPUzVVK3lv?=
 =?utf-8?B?N3JEWm9ZVndSRjh0YWMwWklJRmVPcEJCMjBBUU9jZU5aYUlMREdYSEl4bzdH?=
 =?utf-8?B?bndzaWRFMWRROTcxcnJDS0c2RHR4RHhTa2s2S0I1OHUxbkgvMDlxUHhGQ2Jw?=
 =?utf-8?B?eGlrQVV4NG51TDkwY1FGbzBBT3ArQXdJaGV6YnFQbmFZTjYyMzJ0aXJyT3JW?=
 =?utf-8?B?ZjhPdDg5WCs2dGlRa2MzV29uQTZWL2JMNFU2dWF2dUxlR05kZ1dvOWVXWElu?=
 =?utf-8?B?TVVoNVBEdDdJT0hpN3Jlcjl1RU9EM05UcEpZQkpHUVFBelV2VitERUtDQmJZ?=
 =?utf-8?B?Tlh4Nm1MVU9EdTlhUUFtS3pwU2VYOTVtaHdDM0JVaXpGVjdVNGJmZlk5bmxF?=
 =?utf-8?B?d2dUczBuQmZESVQzb0FDbVJnaW9qZ3M1R1Q5RmhNcGY4M2NWTVJVeEtibmho?=
 =?utf-8?B?d3pjSlBhRFh2Qjk1UnRMU1FBaVFPUk5zakNtYytVNlNQVEJKTGlTVU00WjFo?=
 =?utf-8?B?ZmZ5SmNiMytQRnZyQjk5YldidHd3OUZPdWNjVEFWYVViSk5EU1lRaSsyWEov?=
 =?utf-8?B?MTJlU0lMVDhyTVVvbG5BWmNDRjRhY2lFZ2xrVU0wNFduR0djQ0M0MEdNeElu?=
 =?utf-8?B?K0JhSWZqRDZwQ2k0c3Q5ZTNtTWtqdWhMLy9UUE5KakhNREJoUHRxYXV6ZmhR?=
 =?utf-8?B?RzRvZE5RbEJoYk5MS1BlcTlQaFlQZmwzMDVxcEFCRjFCalRpUkQ3ZDZoWUJU?=
 =?utf-8?B?VHJRY2VOOGFqTzdRLzFIbGsrZmhqQ1dGakFQSWwyWjVUNkdtNWZNOEJpWHVF?=
 =?utf-8?B?Zm5PVGpySFpsRHhiYnExbkorSHRERk90ZUo2SWlNZnhIcHVHWmlUejVHTitL?=
 =?utf-8?B?QTRLcXlWRVRFZDF0RWdKdm5KRVhuSlE0bzJpcmUwMGxkcXZPTXJZL2dDKzFN?=
 =?utf-8?B?Snl5cjVLb0dyT2Yzd3J5N1RTYVI1ZUpkb0J1UUNDQlJ3WUxrcmF1NmtUZk9t?=
 =?utf-8?B?MnArZDh2QS9DenplbVpKTS9FL3czNk1QazJXek9MREVNKzNsVTZWVjRPWkxM?=
 =?utf-8?B?blNtSWU1UUVQb2JUZDhtV2xNZzQrMDdCYjN0bk1sYzBDaTFnRFpYa1pOTU4x?=
 =?utf-8?B?OC8vdkw0bkh2SEkvQVhpcU5rc1lQSmhQR2tFNWEyWm9CNXBNOTBaQ1M1cHV0?=
 =?utf-8?B?anRzMlRrWGp4ckVURjBPQ3p0OG5Ka05ROFE1UEwza3BqWnJyRnYrekpYZWdZ?=
 =?utf-8?Q?iv3YErGZ53sudXaGf8y9D6s=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3f23f3-89bf-4ab9-fb45-08dc5d2a3c26
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:58:36.2169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16ziUtMfDMEZuXqhcLm6h1jrj4I+qwTOHz9VCTD2mG6FIJ1hVa1RpYCM3zlAXAS2bpRrbBLnWb0JqJ3RHuBFV0zXVkYXzGkzplWAwv7hLKjwOgsJt3Y3mjEAV38ej8v9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8440
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

Hi Jonas,

On 4/13/24 20:13, Jonas Karlman wrote:
> Add .dtb-file entry to Makefile and enable Kconfig options required to
> configure pinctrl in SPL. Also add missing PHY_ROCKCHIP_NANENG_COMBOPHY.
> 

Separate commits please.

Sum of changes is fine though (but a bit more verbose commit log would 
be welcome, why SPL_DM_SEQ_ALIAS for example).

Cheers,
Quentin
