Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF656C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 13:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15ADE8785E;
	Wed, 22 May 2024 15:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SScbObNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F31F87C83; Wed, 22 May 2024 15:59:32 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EB58785E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 15:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoESDfF29/WfF+tQ2j7QwKUGl49yqt14zLwh9oftRygsfbXW3OVueEzpGzEJpfdxM3K+Dt/oL41/ZCPQi5fw12K9Ha7gsN4iY1k6GQ22Gmg4oBW+ilEo3J89hU3zOnO8yWLP0zEHKqgqIKaHzVtWaxwuxfcL4mxYOwzUmIImh/Rkt2m/WCadgDzbYAXDGWblOsf8MJ5ecJxbnOqOY/EhNGcZBVs07fTduGlzL/1IadMx90JMXvgsG8s5rXOFVyfMTu/64rwIAwUyZn3R/7LOQuMlRI2FYHZCF9JF1Ibp+uwl8/K4tk/hsMInciYjqSQSKM8voMWJVM2ELGPLqbl79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvj66wW1TgWVAVTq332fT7gvVVv0COVgY/jQE2a7Qnc=;
 b=P7WqLa5GtibpN57gu02KroaoQqnLmD9LN66y3WIuENXWzpJoDbZ/KjPoAPlGGvT0o+cCKlLdl7wak3XflAoDnR86wF/J9NzVkMBDacc5t11Jh9cSny598Ysqo3iNDQ4LVCI48DGDZ2ceMTDz7vklFoKcjg6RpoJnZPHs3czF400GnSxCPkpMbqOeopRiH5FIPqyHcjqr0RlJyAKYbyLYRsmB8qO8H/VoFgHJ4T3z2TgHjRj5yhp60kShG+PWG67dHigDOpNrsMFypCHncVLqxp6LIkOFhEsMMuL2PcWUMdaUbafv6tx8HuGMXz6+gBZ4e0L4s2vBQyXayleEe0nXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvj66wW1TgWVAVTq332fT7gvVVv0COVgY/jQE2a7Qnc=;
 b=SScbObNPc8JIEJvMR8STWitZBjhx3yh5lTgw26OPgM91mts80wfVmTqm97cs24OkWG+YJbdbd8ivlr3tLInRhouMszeQna8eHak24s2xoBEXgfppbWiMBrvlHnPguj9U0QIJIOpb6HGvg/eTWg3FHmqaG9mgTp2Fnx7SyYde9EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 13:59:27 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 13:59:26 +0000
Message-ID: <f04e4d06-82ec-43ab-a077-592685fd7d56@cherry.de>
Date: Wed, 22 May 2024 15:59:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] clk: rockchip: rk3588: Set SPLL frequency during
 SPL stage
To: Heiko Stuebner <heiko@sntech.de>, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: lukma@denx.de, seanga2@gmail.com, quentin.schulz@theobroma-systems.com,
 zhangqing@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Andy Yan <andy.yan@rock-chips.com>
References: <20240522121559.1024535-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522121559.1024535-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 410c33db-66a6-4a60-294e-08dc7a676470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDcyTUlFaTV0K2ZQelpwaXN3NTFCV1ZBWVFWc0FKaGtRcFhKSlk5Y0hObzVY?=
 =?utf-8?B?aWFRRW9rNVZ3Tk8zMFlHOGU1VzRuMUYwb01hS2FJTlBRdkhZWVpPMjU2bzRq?=
 =?utf-8?B?M3hXclVUZE1KMVQ3NnVpczlYdFNwSG9SaXJwZmlqc2VCY3M1RUFyemhZS2Vw?=
 =?utf-8?B?bEp2RGd6anpLT0MrQnpGOGgvNVFKUk1VNnNmYjlDUU9sdDJGTnpaUEZidnI2?=
 =?utf-8?B?UjV5YWxBUjQ5azNoZ2xBZFRYcTRvck9qV1hWekhVSjh5TDBSNVFJcmIrYktu?=
 =?utf-8?B?QXF1a2lDZy96aE90MTM4YXRBZTVuaWdnb2s1NzJUZkwvUnlKWmFzanRXS1RS?=
 =?utf-8?B?eXpadHJBMzFRTWZobXRMN1NpU2Z0ZVRLZitLYU0xRUhicytyUk5tN0FvRUlT?=
 =?utf-8?B?ZlBWalg4S2xhSGY1TTA5cVNuc3JSbXRrQ1lhdnRpRmlpUkV2Z3luOVAyVVlR?=
 =?utf-8?B?YTRtS0ViZkVWaGhsY2pPWFlBZ1JwYmE4bjlmQ0tGekdvV1NqOTJMV3EvVDlv?=
 =?utf-8?B?S2FNR1NueEtZaHFuSk5IMVVlZDZuamJnbUtaTVdPZmZBOGtFUWFtQmd3WERM?=
 =?utf-8?B?V1ZCUmx4eitnc1hIWnJQT3QrUkROQkYzQ01ycG9RcG9Ra2VOcVp2TFZ2cjgz?=
 =?utf-8?B?M3VhZXExVnJ2N2FVWlpIdE1JaUYvSTNLMi9hZ09qL3pNbjhxdzhjZVpuYnBz?=
 =?utf-8?B?R1hWZ080MktJaUY5U2pRMUxrZTdkTFh5TGdRUmx1S2lTcjJMVWx1OUcyRDJw?=
 =?utf-8?B?NThodHBqT3VMTWhwb2ViZERuMmVZMWRRbEhneEg1bG0wRUR3L0oyTFJiZUhF?=
 =?utf-8?B?Rzl2dWY3dkhUdnV4N1c2bkRINko0Zm1KSkpnWCtMS05mZXk0VlBTWVpPYVlQ?=
 =?utf-8?B?ckxZT21MdGZyTU1lTHc2UlZ5ZC9aVGRlS1RTS1c4V25sdjQrZ2dBRHlMajFF?=
 =?utf-8?B?VXJpakpJWTNVSnZ2Wk1la2NlT1BWZE9kcU9LRi9kdTR4Ky9kMVFLOWlPWHlz?=
 =?utf-8?B?MEM1N05tSjBuY0s2VS9kcGZUcFkrZmxBSXJsRGE4aUcxdkVId29TUWtpYnhB?=
 =?utf-8?B?eUR5R3JlY1grcHlESU9WdmQ4SzJaTHVCMTF6MGwrS0loUlRUVTNnZnBkZDQ3?=
 =?utf-8?B?QWU0QTJhemkvem45dEZQczBTcUVsQUE1U2lyVEtWS0wzUUdmbW5LSkEzR0l1?=
 =?utf-8?B?ZEkvV1Y1c2U4QnVpS2RYejk4amRFOGV5NUppbC92cHphK004UHZkbnZEMzZw?=
 =?utf-8?B?ZzVKMy9mZjM2R09kc1JxcXlTaDBtZ2ZvaklHMXRjRnZEWXF3dHR6TVByb21M?=
 =?utf-8?B?K041K3ljWGZhenZYTlo5aEE5OU5uamw5aWorZlEydnhQSjllbFRYck9qMTVD?=
 =?utf-8?B?azA5NkFnNVMweFE5RUV0YVY3YzU5Zm1UWm9FRS9DM1dJYjhDWGV4bm1JZEY4?=
 =?utf-8?B?YXhhdGJTSVU5S2lFSUtWc0pibWJhOERGckpESEdkZ2thbENWd1NONHBuckpO?=
 =?utf-8?B?SDZJVEc3bUlxWm01TXhwSTBDNTRMdUhCNXZhSjhsQ0M5ejhHanBGSTdKekdJ?=
 =?utf-8?B?d1NEc2xQMzdLd2UzdXFveWpIS0w2SzNVUCtKeUNwZEFvSm1uVFlyeGNCMVlL?=
 =?utf-8?B?WVhLSnNOT012YVVEVWJrNCtEVVcwc0I3L2hBN1BKRUxScW95QURSSG1oQlVs?=
 =?utf-8?B?Q2QrN0dqTzZiUkErL3RwSXFpcm5JaTd5L1lUYjFqaFZLYXFJNmtPcnlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZWTklOajVQKzF2R2FSMWlwb1hCeVpiTjJwcU9kU1BiL25hUWJFTWk5Nk1q?=
 =?utf-8?B?NC93dFVhTWFDT053Z1FFRTlKQkRiNmtVQkRqMzk5OU5RQnhqVmQvejhZR3JL?=
 =?utf-8?B?TWZMQjZCTmx3L0R4UXZZWVdYaVlNbVpSL1Y5aWFjSmxxcjJQcVJYelBJU0lN?=
 =?utf-8?B?amZpN2JPMFRJUkFOYUdOdkFRVmVxcldrbVN6OWhjaUtYQ0FRWEJGajUrcTdP?=
 =?utf-8?B?d05SZDl2T0RHcGRVVHV6NitEd3JKQll4c2Y3bDk0TXA3YkVJMjhFZmQ4UjNO?=
 =?utf-8?B?b0JGVnRpZ1hxZmduQTdWVlhVelBuT3V1aXpmZTNXSlpQa0RpZW9ONlE4ZlJP?=
 =?utf-8?B?a3lzSGlLYVNHTDV5YjJpNHRXNHh2cDlJNEVXajkzaVg4WFRFQWRoUVIvNDN5?=
 =?utf-8?B?Ui9EeFgzQjUrYXpka3AzOUpnc2VMaWUvUEhHYW9lMGc3TkJyaXVwN3dzbjNF?=
 =?utf-8?B?VnZjWjJPSTRWREJ3NnExNlNib1dZRzV6akQ1cG9BMnBiSldLUHE5dG9IN3Rt?=
 =?utf-8?B?c25Ja0x4K1RxVEx2T2pqcFZnNzJnckxvZmRUUkJDVktIcEw2Rlovanc5UWVi?=
 =?utf-8?B?TGdCSW5IUGZMZHVHQWNUM1pGOTl0UnBXNFErZXRDSksyYnlXV0FOY2xMd1B6?=
 =?utf-8?B?ZWFFaGs0bUEwL0J3WC9YaWp3d2VKcjFOcmRweFg5dS90aU1BaHA5ZURiWnpE?=
 =?utf-8?B?TjhKUEk1WlVaUjg1eWd6UGp0R25ZOFI0YWM5TjhLazl3aUZjK0lDYldMd1BG?=
 =?utf-8?B?K3VvWXdoUklNb0F3VjA0cHN3dnk0aWd5VE55OUxwRWt3aFNEbE5zN2VkZ08r?=
 =?utf-8?B?SGlxZ2o1R3RsQlljeVlrcDFEYnRPc2dWQ2xZVHlDL3B5QmY4cEoyK000Wm9Z?=
 =?utf-8?B?eGlJenZ1RFlyODR6YmpWNUxKeFpCZ1NCSWhjNmd4K21DamxReGdiMkhDa2tp?=
 =?utf-8?B?eFhMQStKdmtRNXVrZllNODlyL3dseXIvT05heWVMOFZaYVFMcmlxb3Z3VENE?=
 =?utf-8?B?ZXJNQ1dxclU3RVkzMU1CN0VIS1J5SGJnL3RJYTErRWNwSnI1V3VWaStSZGd4?=
 =?utf-8?B?UFg1ZG4zcHp5OERhRWRIVzQ3TjBDaHRHREZPQTZUQTczMEZiSWhhWi9zSXJH?=
 =?utf-8?B?Yzhpa2ROT3JQaCt2blJoWWZqNzJ6aWFCWnRwakd1dTdVRWlIZDNOMU1sd3ht?=
 =?utf-8?B?T2ZpY1hLV3BCSW05YWlGb2FMVnBJMmtoalQ4RG9VL05MRU50SGl6SXJqcjZR?=
 =?utf-8?B?d2o5ZVZDSktPRUV2R2didHFkUXEyS2EzeDVUZ0FBRW1leVg2K0dWVHRFYklC?=
 =?utf-8?B?RHpnUXpGVTlEWlAxTFY5REU2UTM5VklDSXV4RVpSTDFaY1JoajdscTQ0NlVP?=
 =?utf-8?B?SHhnQlA2NDRGcWJzY0JhYUJQalpVeHJoeGZZUVhrRnJkUlRObnN2aWRYNTlw?=
 =?utf-8?B?K1JxZTMxZW40OHREeTZtcHBjTGdqK0FxS0I0VFRMVlNtTGkwTjJRMFdMeGxs?=
 =?utf-8?B?UC91dXQyYkVCVThmV1NGK0E1ZmRCdUhFSHplODBONjZrU2hZUXVoc1VPNERw?=
 =?utf-8?B?UlRvTnN2ZXB6clk1aWFuaHhweWppY1NXTzlNU1pyMC9iU0NFTnJEbGdFdnox?=
 =?utf-8?B?Q21zdEdLeFNVWjg2WVVLVk5YZVdHM2lIbUg0UTk1S2R4WjZ1S2lSTHlibGI5?=
 =?utf-8?B?WllkR1RkV3Qzc3RUY2dLSCtIbHlUUk9Nbm5xZEhkNDhtY2puWVhMZHpZMUpI?=
 =?utf-8?B?NDQyNDdwNEtodFVxTzdjY2pKZDNlbm56QVo2QWxnQUV5Nk9XTnhPZGVqcktr?=
 =?utf-8?B?NkhlNzdkMVRHM0lESGZYZWRIWFg1bEV5RTkwYkJTZW53T2hYVlNwWUZkUmtq?=
 =?utf-8?B?S1NTZDNrTDQxRmZLZmh2YjBPb251Mmc0RUtnK01nQ2tuaGMvdmt2QllFeHVZ?=
 =?utf-8?B?QWVrZVBJUDFCZExRaldGcVFhZldBcmIvZk9YbG5GUVA0TzNPNkwvRWhDakYz?=
 =?utf-8?B?RXkzc29SMVJOQkhBUnJjRk9wNDhjcU5pRXZpM0NjNGxkaGpkVm8zeDRSZStG?=
 =?utf-8?B?dDJXMzJoQm1uMElYTldjdmV1d1hLOEU0T2kzZkpKZ1YwNXlUNVRIb3Y1V2JF?=
 =?utf-8?B?NkgzUUNPNEFoUDVUWDAwM2tMaThPVDd3UXlHYjNmMytqemtHV0JXZ29FRXU4?=
 =?utf-8?Q?BfCyG+k33Zo2MkH0oK/J4Ps=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 410c33db-66a6-4a60-294e-08dc7a676470
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:59:26.6960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O9sMWJbEbJfrXFxoK7LpnuDM2/+2eadVzT06HPLDVqurfliah6NTs4gkOUE525Dx3a8O8ltxN6dkvUISLc0DVDxeK6IbQHPgb5Z87bFeCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279
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

Hi Heiko,

On 5/22/24 2:15 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> All parts expect the SPLL to run at 702MHz. In U-Boot it's the SPLL_HZ
> declaring this rate and in the kernel it's a fixed clock definition.
> 
> While everything is expecting 702MHz, the SPLL is not running that
> frequency when coming from the bootrom though, instead it's running
> at 351MHz and the vendor-u-boot just sets it to the expected frequency.
> 
> The SPLL itself is located inside the secure-BUSCRU and in theory
> accessible as an SCMI clock, though this requires an unknown amount
> of cooperation from trusted-firmware to set at a later stage, though
> during the SPL stage we can still access the relevant CRU directly.
> 
> The SPLL is for example necessary for the DSI controllers to produce
> output.
> 
> As the SPLL is "just" another rk3588 pll, just set the desired rate
> directly during the SPL stage.
> 
> Tested on rk3588-rock5b and rk3588-tiger by reading back the PLL rate
> and also observing working DSI output with this change.
> 
> Fixes: 6737771600d4 ("rockchip: rk3588: Add support for sdmmc clocks in SPL")
> Suggested-by: Andy Yan <andy.yan@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> ---
> Resend, because I forgot the u-boot list
> 
>   .../include/asm/arch-rockchip/cru_rk3588.h    |  1 +
>   drivers/clk/rockchip/clk_rk3588.c             | 26 ++++++++++++++++---
>   2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index a4507e5fdd7..85b4da0bc2c 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -29,6 +29,7 @@ enum rk3588_pll_id {
>   	V0PLL,
>   	AUPLL,
>   	PPLL,
> +	SPLL,
>   	PLL_COUNT,
>   };
>   
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 4c611a39049..5384b3213f5 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -37,6 +37,7 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
>   	RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
>   	RK3588_PLL_RATE(742500000, 4, 495, 2, 0),
>   	RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
> +	RK3588_PLL_RATE(702000000, 3, 351, 2, 0),
>   	RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
>   	RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
>   	RK3588_PLL_RATE(200000000, 3, 400, 4, 0),
> @@ -65,6 +66,11 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
>   		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
>   	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
>   		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
> +#ifdef CONFIG_SPL_BUILD
> +	/* SBUSCRU MODE_CON has the same register offset as the main MODE_CON */
> +	[SPLL] = PLL(pll_rk3588, 0, RK3588_PLL_CON(136),
> +		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),

FYI, it seems the rk3588 clock driver doesn't lock the PLL with the 
lock_shift member, so 15 here is useless. Maybe we should switch 
RK3588_PLLCON6_LOCK_STATUS to (1 << lock_shift) there for it to make 
sense. Anyway, nothing specific to your patch.

RK3588_PLL_CON(136) is unreadable :/ Though I understand where it's 
coming from as we have the same issue from V0PLL to PPLL. Can't we have 
something a bit more proper here, e.g.

#define RK3588_SBUSCRU_SPLL_CON(x) ((x) * 4 + 0x220)

and then use RK3588_SBUSCRU_SPLL_CON(0) here?

I'm also a bit wary of defining SPLL (and for that matter also V0PLL to 
PPLL) with offsets relative to a different base than CRU (SBUSCRU for 
SPLL for example) while all the others seem to have offsets relative to 
CRU, c.f. RK3588_B0_PLL_CON(x). Specifically, it seems we are calling 
rockchip_pll_set_rate with priv->cru which is the base of CRU. I am now 
not entirely sure anything from V0PLL to PPLL is actually working since 
we use offsets relative to some xCRU but call the function with the 
CRU_BASE.

So... wondering if we shouldn't have:

#define RK3588_SBUSCRU_BASE        0x18000
#define RK3588_SBUSCRU_SPLL_CON(x) ((x) * 4 + 0x220 + RK3588_SBUSCRU_BASE)

and then in the probe of the scru driver, use CRU_BASE as the base, 
otherwise we're doing some mixing and I don't like that too much. Or.... 
What about making this handled the same way as other clocks in SCRU, 
without actually using the table? Or... Have another table just for SCRU 
in SPL and migrate existing clocks to use rockchip_pll_set_rate with 
that new table?

> +#endif
>   };
>   
>   #ifndef CONFIG_SPL_BUILD
> @@ -2044,6 +2050,7 @@ U_BOOT_DRIVER(rockchip_rk3588_cru) = {
>   
>   #ifdef CONFIG_SPL_BUILD
>   #define SCRU_BASE			0xfd7d0000
> +#define BUSSCRU_BASE			0xfd7d8000

Can you please rename to SBUSCRU_BASE to match the TRM?

Cheers,
Quentin
