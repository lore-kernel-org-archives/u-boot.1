Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6064C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 07:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B2781EC9;
	Mon, 24 Mar 2025 08:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YDRkfwOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DF081ECD; Mon, 24 Mar 2025 08:12:54 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693BC81EC5
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 08:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoYs8EAV2rHMyqIGMaYfYXD6ku74+XsHIVJLw9UpR2mfYUIsO0XhjIPYpB+Ua7D+6XOEPLFuysaHbWp6kFvNbafaj2shuwgYYavP4uhjfcnurwyZgwXTX8biZuGKnJPWff8p6CXmF4gy3a/G10AuFOn9nAY3alANyjwAtTfG3He1oWCdNpAZVo2Ihf9qWT1plcb1Pji4A/hQs16Hqm9ggNPORg08s6JOd1PSRnW6+lXwZgecYUfrFJ3vVS9z2vv44aie16uB9Wheh/cMO2tYfKuAk/xD2Mla6mRMf4+m0PMMilKmrPhZd1+QhHZsQuyQ1kLwZtjovUpH0Cc7S9BmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIYaVWdMFlPeGG0q2DXsLsHQ75vKf0eU/ybUVc0wiSU=;
 b=RLKc/9yr5sykyyfVAy/Uhl0qFBMFLsN45cL9lBwidpyk3MtDgJjY3X638QgBj8FbnS0fW4nAOoOos6liFAdhFsLic3f/Q4rX7SIqmh6MoBabM9dCTAPIWLY598S2rBKWShPi+qkrBtHb7c638ArFiTMJfDir5tV4wPhVXhS73GGI9VGm2o3ODSncCMIUiN4P5yokSBC1NPtrW5xHPA5ZutX4doDPrrwleuOocB7APSp0+nYSmnWjHtEczjMJWeHErFsv/IbwwmXgZriJLmkWzTvJFWFSCYdOk2uV3IG9VPhVsLSGh0AFlbxBO3/HGUf11P4nNVIHY16oSUs6Ao+iDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIYaVWdMFlPeGG0q2DXsLsHQ75vKf0eU/ybUVc0wiSU=;
 b=YDRkfwOjKWvzVLC6PJa/uFb8TMlavh4uxW+KTRY74Zh8s0Yh754gR47Jeqy5Y6ZznwuJEBMCAXOw49SACrRSFCiTP74svyuQ1CzFAOIuYfZRM7u4WG1vNea9RR40J7lohcVAdckKxehm1Jskb1soCSYEuVQza1h0qU9On8nGFDaUxFo+TENo6OyHXzd6Koj5eiSMVCDqEvi770uBYNLHlUrG892bBG55+TPrb7RYxn3TZ2z2Q/FJ2yuegu9h5jK5CsUPIT/sEmEZteJtVa5MYBn0dAvCoI115IdGIHnDHkMTDPtwxuJg6dgP66rer9V2X/QE7+S9oTONOvxM/cfQqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:12:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:12:50 +0000
Date: Mon, 24 Mar 2025 16:20:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: ziniu.wang_1@nxp.com
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 tharvey@gateworks.com, jonas@kwiboo.se, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] mmc: mmc_boot: support sandisk and micron emmc
 boot/rpmb partition resizing
Message-ID: <20250324082049.GA24365@nxa18884-linux>
References: <20250317084649.1059257-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317084649.1059257-1-ziniu.wang_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 12830ac9-d118-4914-aad1-08dd6aa34939
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i0abvd9DL1JOV7EnpM8R4SSwLSm+62+8XXbP5IHJdOQj7HvLzo/ACJuSD8so?=
 =?us-ascii?Q?NtSMeIuCUSDIiUdS/V3X6p9lAkugs4BS7UpvdRfQKz2UuOCeB7/CG0uvFz+6?=
 =?us-ascii?Q?jLteIEUGt9/cScgaaTb/Td5Au/ta9wlnMCi2rYH17UZEWdb5yPGtw6xI1Jkz?=
 =?us-ascii?Q?MwTXvBrZpwITbWXPXfbkS8onXUf579bfWxmIfvg780bb68R2KCTSTEpJFugY?=
 =?us-ascii?Q?cybcBpFfkx9ZGD3ULSognzUCJ9Ly+3ITI/PZ3fzGVDFXopE1w77ap+VzdKD8?=
 =?us-ascii?Q?YK4nSdmV96NUP/siAI0uFFJLiJfXPAcUawfVk3Nc6o74wgL4wr/ScT+UCQDM?=
 =?us-ascii?Q?o4IF0GsVY3soCSMXWrrP/KrTPHXSAPD6WgOkOHyS0r2j9+ohEBAEVKBHsOip?=
 =?us-ascii?Q?gmDj7EpEbKxEqTJJe2f/yppx78An6xH+ohrrDEIplf1NvsRxOIlltGG3E7Y8?=
 =?us-ascii?Q?aam3hDzO7kQY/Man8bVfCAHITEjzJrvzGaxlqiz3KAU9g1YPDuMZXBKumQgJ?=
 =?us-ascii?Q?D/GGbkZ8TieJyDm53lF2Q32qR87NLese/TRu4KKiipZ4gaIRB0fB5uuqxeCZ?=
 =?us-ascii?Q?kSdYtcSpVaThYkb0hII5/wq2KMd8HryqqD6/YRi/MbU6pQY67R0xfk78BNJj?=
 =?us-ascii?Q?D6mapePiErDh2CRa3tX0rydpx76ZF7V2OD3YOrW4hZ4ujlJGxzy0aoPs/FbT?=
 =?us-ascii?Q?BdSof+nMEOfx6ZkpuGH+kUx3ycGdMs8/icTN00OX2Ki5iVGEHsbyMhvuupCT?=
 =?us-ascii?Q?QA1XdD3zqeh7Me/AF0KoYMjSnwWfTyYAuCEfq2Rq5WlsqRHfGanK+NJnQmFV?=
 =?us-ascii?Q?Wi+kXS1l7oJFfMS3TByajfAW7nvRv0IkOBhWiMiuicFQjiO2Tm1bVoHAkMnq?=
 =?us-ascii?Q?RQNqUYVdutGAgZ/WYqRYCAFV6fsQicIvXGXsP4YRLs6ou6yfsy5VtXe04uIN?=
 =?us-ascii?Q?EMedvc52PFA0xQNg/MLryUYk2rNPLGDNxS7EICRlvnyC1F7myai2cJJE1IPE?=
 =?us-ascii?Q?C1KlpSo2kPd69Mlf6Ma5jGN74W5W8O87rC7m9+lbkltayrtojC2lTs5e5GeU?=
 =?us-ascii?Q?ERyBF9FLFjvA4BRU5DpU3BYHDypHqtInOPorc5bck3gvIwSSVgoW9ztmvjn2?=
 =?us-ascii?Q?Z81qzYaXY8jfe/9C54nwabLeXh5NxrzOQYmQbinAkzlhpsPYZ18p1etHHMEh?=
 =?us-ascii?Q?zcU8kY1tD6WJfsRFg2mP5oAFFSGeNCB2FtR0uvReiXacZGeptZ1gqA7qeijo?=
 =?us-ascii?Q?Xi9PeqmwJGEppz/JLfLQhZR68EeTXHj3bImA1LrJLa/zHA7w7LU7ZUA9IlTD?=
 =?us-ascii?Q?oFfebAHyxMN5folkiJoxBpmn+1v6C7lcwwQuJiwl5jYetqZLiKlgZPPvQmKn?=
 =?us-ascii?Q?QGtcgKMBXJ7XK+Xy2KqL0vFDaCMYT3jVVUkagcwuANn0Ty8vs91WTEfHpz7A?=
 =?us-ascii?Q?Af2c9IW/+jqPd18xjh6krG+0H8CbGZLO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1q+O5JUWDAu94KPQzdV68drTKhNqQQWbCrd6SLoQrXH4jUgd19O1L0+93f+E?=
 =?us-ascii?Q?Y7AKuEBwUCsFNX7FPjL2REDaHzvk5m/Ruzyu6g3lge/YlgdSJqcujgDw75C0?=
 =?us-ascii?Q?KD1nx9eONNo8AQR9atsArTmVAP8m79eK8KKGM5HXHzB3XP7R/a7S8VMg9IQG?=
 =?us-ascii?Q?V3LJ9+jjQeYbgqzbEsXYoB5YXOqnCr0QHdQtg3H6AsGXdpapegH3izKRyYf2?=
 =?us-ascii?Q?oUK0G7HKMfUUTHrY1PTkPc3EIf1ybmMChaMNaZ32BsEaNIHtZAqiXoRHDaOX?=
 =?us-ascii?Q?JaniAoA9vL15nU43ycc+Xuv4y1Fl054Bbj6cCn2sgRwIGOn+GO7Jcv/Q01u9?=
 =?us-ascii?Q?x9jleUShoI24FO5DeFNAtX9CZc8eHcw13JV7SkQJRep3YRR0Jr9HhSpdjryp?=
 =?us-ascii?Q?Fj9xWe86GlFat7VZ8etqGbJ27FOYAqFrIcu+gS32CDhLy+q2A7jLNinoa9ca?=
 =?us-ascii?Q?PylzIK19HbPrm+Q+y5M1DZh1TY1Pg8FFK1sQUGDbpwhlPul5silZyDTKyRwL?=
 =?us-ascii?Q?R/j3djdQXwD9UhKhX2nANPuDcWcATYEQBYpHH6HrPxDaD8T+NjSo+IY66kQF?=
 =?us-ascii?Q?/xUWz1NEnnSM8I60QYAFHcBXP3jKiuWUp+tDC2lqZCxIiPwkjhmLh1ZOGz0O?=
 =?us-ascii?Q?e06CPkB5yCB0f7IAAZYRmDzfKGECk+epPayRMZXBl6Bi9ILRSUxt1/q/2nz0?=
 =?us-ascii?Q?ys4zTECqqJVjAnoQhJAGih72X/9ks/z9kj2Gn0+EIRfEo8Mk6V8RUo7i+lkQ?=
 =?us-ascii?Q?rz6R2YvmSTPk91feqgzsMbEv18tRoIZNZ7q54U/yepJD20OyIk0yYI3IbnxD?=
 =?us-ascii?Q?ELDE1+D1ww1l9WZKE7ZSfGwxKoWkWWN3NzAMXhHjvslkNGf8Mh8LoO+nkumj?=
 =?us-ascii?Q?4MxJqHh5KcN3EqCt+I2HpavPYSK6gCeZdbQycZsBAhaEQJyU43/6E/I3LY6F?=
 =?us-ascii?Q?RKPj51jg2Zkvh0ZFGuzt4fvVmYNfJOZnvSuEUz42ZkQYKBPBMOU5y8YjwpA/?=
 =?us-ascii?Q?Xie7cjpQX3CXXrX3f1r5mslgiB7xnV5XzDJpNhJkk+vvTjDIA9dMX5BGd1cs?=
 =?us-ascii?Q?x+C/TsOM6x75tPSoFeqahFArrabFkB2sVGQ/dAXVkWkAVLrPbfi699nDE6yR?=
 =?us-ascii?Q?dujGAYLz2PSY1KONi4gQs+LWFpm/tBrpWica3UGtYXWbj19JKb4dNJP0VIBc?=
 =?us-ascii?Q?86A7PajMvgOevl7WNOoWefBLdff0xpwVp55guMXsL4WzyF67FD8ux5pAULEB?=
 =?us-ascii?Q?E/xk85/esrxkfJ0111FUJ9rZqN3eydX+4Shu8Wj9klMaBtArcJz9cx6T/6sN?=
 =?us-ascii?Q?0/ryVzs6Beka+hAWru1r07xGMqZTgYd2r8oJWpBngs7w2oa8yd/yiz5FRoQH?=
 =?us-ascii?Q?JO9TZl2iPlzwNnUcZ8dPVXm0DX/f06ZGynFZWvWC9S2gi69LtVkPA+a6lBqY?=
 =?us-ascii?Q?UGxB1iImA9qqM9emDYi7X4Famkmyqherai3bmrv9j3eeGOir7yAiNV7jdVFt?=
 =?us-ascii?Q?8kVXNXU1vA53KISgxXhj8ZEMh5trnSE9toQglIi0gCp9bh+9RPCC+YWl7vmH?=
 =?us-ascii?Q?EbwVrpZHYi3zaT62nRm3knhPNhP0xCAM97u5RnDn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12830ac9-d118-4914-aad1-08dd6aa34939
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:12:49.9629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeducbNzRL0RjMylrIN7tGDfAoe4KzJse7Cf2BDi7SF4Q56FVo3ydJKibyIB8+ofbpK9U5nkcKloUygbC5RvBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
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

On Mon, Mar 17, 2025 at 04:46:49PM +0800, ziniu.wang_1@nxp.com wrote:
>From: Luke Wang <ziniu.wang_1@nxp.com>
>
>Current mmc bootpart-resize cmd only support samsung emmc boot/rpmb
>partition resizing. Add sandisk and micron emmc boot/rpmb partition
>resizing support. The commands and parameters for resizing partitions
>are different for each manufacturer. Select the corresponding function
>according to cid.
>
>Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
