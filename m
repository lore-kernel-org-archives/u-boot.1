Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A787C88E40
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC3783DFA;
	Mon, 26 Jan 2026 02:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="byCgVpT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F001083E40; Mon, 26 Jan 2026 02:47:19 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14AC483DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWfTbrWWPVFzrt2UNtkUt5+YbMwvMsC6GZwTqZvWraZtgLkXNkA4gA+TZZ/wE6bPE0CKQ0HKHLN8HrdWgWCGfAf9vn3e22aVHA1v4taM48X1CZulLNzFGom6jvyqgI2rX6/NTPCdMIKe5xkd4FzL03rp5oCMKCE1l9KfAcfwUgXt92NU9veKHuI71Ps0wTIKfN92HXt5PO96pHKXVkhBCrV2WBSOez6DdQbrsuzenfib5k5I9khtzysojAXk+UFHg5AbCjP5Ov5mopDl2blBOEG++9Bb9dPhT8hAA2+SDA44bjEplAiAzK7CWvNTq/q/GQiox3ETeFPyfngw5mIXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np+IvZ+8UGCSCjcQ8i/+ohGbAEFXigev4Ng7ZgfrQoo=;
 b=M8Q0ra4TzLf8ZiSgeUpOUpgePA3g8K7jQovwEudCPheqGauhfZGo58E2P3GvWP5NnKZQ5uGNIhP8J5NdNdrrAQFhrSy3DPt9wz/ygRTMNmRDWygwbZMVpNQ/Y4h6YadAg3jfphHedTZoZ5pEHoyqG6vq8lxzEIdlAx0fxPjdMpx7OJcJEJAS+5dfZS/O1qTaLJYCypu8hPwPC9EogE/DpPPYsBhtv2rYTVakUBuBZ1uUvATA3J74qyT0ka/VGd+TH1XNKkpRp3iz3AuQfXW56bLPv2O1hD6r/1WkqziOzhf1rwnGBDwG8nrJzUMGcWMeQGc7d/NBrli0BhSLnlF7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np+IvZ+8UGCSCjcQ8i/+ohGbAEFXigev4Ng7ZgfrQoo=;
 b=byCgVpT+Av0kkKpcaSbAW6MdUl0pZR2Dfb6zXumAyTJt/4jaNTlba+Kgi5IO8ZE08HzbXdrPcCZJmsd2DCSEJWj5aNEH3hrCh3mXs8h/xmLeG1uuW0p4E7W0enOtsPghc36afbzVTiDHwIsbzlLxBstO/xMh/op5vHX/t9XH9evq8hglhu8/HAZ3hUfuNrKm9OzXZ7qDRsPqrf0MRVjP2Nvk5FuEXVzZhdJpuu6V7ClfmtyAInbXRi9PotpdlDaij53PAFr6MCZI2+7aqsQW5UM7bMhb25q/a2qMofPmhTmoauARZt97KRw6RkVVUoN/OYiOKPDycHFFsc2fBVNv4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB7268.eurprd04.prod.outlook.com (2603:10a6:20b:1de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 01:47:17 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:47:17 +0000
Date: Mon, 26 Jan 2026 09:47:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 John Ripple <john.ripple@keysight.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/2] imx: scu_api: implement sc_misc_get_boot_type
Message-ID: <aXbHoqPyPLPQVF85@shlinux89>
References: <20260124055044.8149-1-hs@nabladev.com>
 <20260124055044.8149-2-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055044.8149-2-hs@nabladev.com>
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM8PR04MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 53db0042-8ab6-4775-4d10-08de5c7cd62a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p3nblf2i76W2AbTyu03NOUI7SJ0lFiFrkl5xVWsfm/kELZ+TRsEmu21STQFY?=
 =?us-ascii?Q?78W4S+rm3Z2huFb6wGfxPWi0JjwujT1ueFmOZBQPtmZfBqf2pPWZavVmB26U?=
 =?us-ascii?Q?RMDzVZPIiPC+XoGbErF6We691IJRlEEFmlNBYm0T1y4IvbDy12nIBKR/5dHk?=
 =?us-ascii?Q?pa7tcQazdf7D1xiLP+Bp06igf5Rk1Cv0wtQUs/bfeZhhSTAoDFfGwh2zuPaz?=
 =?us-ascii?Q?2XkpANp9zSE9SnXrxSkQYXB1i9Ze5d2HEN/brypnnF3y56u1snOnhtByVpSc?=
 =?us-ascii?Q?9q9Fro+41I6eYAvl1HY5NqkHo3Klv0uEAxHiceLZrbzJcGC24D9v94p4MbV5?=
 =?us-ascii?Q?gXVzqJw5nr2dxdCE7T0hIXo+P7SI8nxcwRJln8wUuyynXjHZMCgsUInBT2Gp?=
 =?us-ascii?Q?m2mjz3YWYezfJLHj2jK0INKNog0SF2BbRTVklIkRxlRnMDWXrxHtW7BgqJep?=
 =?us-ascii?Q?Lz9lyxUJsTTsq584vRnovAslQ2CParduaRa1PXiJhzmGX4L14uEUgUWGZe4z?=
 =?us-ascii?Q?z+yx8nw8GOPmHidtGhZKqQbY67J74ni5Ldz122DzP67m3S9+miwS6/4g3RGq?=
 =?us-ascii?Q?Tk3W/3t5tn+Ux8TGrLYm464XeybmuzWfPQF0vUKuE64iuZqR2gi18Hnk5ghb?=
 =?us-ascii?Q?SAOcZd7hsEmrPBCILUULHETONYaptq51fjPLMLyUHVMEF/dvj1RPLQn8tDJL?=
 =?us-ascii?Q?gFFsUWKSAAVwR9Z3nzKbBj/x0u/UWHH7ls8qABj9/3cFiLKGDSuulkTKNp/G?=
 =?us-ascii?Q?mIfGli6qu1CgX0BQJREb8R7X9SizoEfGNexKmCV8d4dmpUzilSol24LJ+x2V?=
 =?us-ascii?Q?pw97AhhPlDD7UaxGS+3V/2GCkIDRlJ6VPwNXf4jgmXpjWhTFfafok2LiDWRv?=
 =?us-ascii?Q?47K6CX37BzVzcxiHIr0xgBAQGDi73I42Kb5dL33XH3oonMxUSHLahGwbcxT1?=
 =?us-ascii?Q?GRNPqIdCg8zgt03Mn+6lIGegiCTNI6ZLT71oSLXNPE4TtCXVk4kdaXKdTW8t?=
 =?us-ascii?Q?8tc8Z8pJ/R32jwMQ0vIDxpyc/Qlx9MhELR29QQYVU0iBtFnAex/OaH6Ey/fz?=
 =?us-ascii?Q?GZXP5DQR8xY+xdazEuL86vqSxvJzflhzJUgQVy9EXZYAC2La28JnsFmq+f4Z?=
 =?us-ascii?Q?/hmNQU+qO/xmWw3750H0YFFC4LvlyZmuvnoN99U51+iPyg9BZDPe//RjxD6x?=
 =?us-ascii?Q?Ay9QQBFp4Cs0I/4bmotnPqOWYCqiY39j2ZeM9PHYsfH6KLtBpdyjoTxpEFss?=
 =?us-ascii?Q?bV4e7DuGCBXzSfAKCb5zWwkmdtPG2S/qKLcKxA+cu5HBPBi/gA9lvdIn4T+m?=
 =?us-ascii?Q?bSTdr1/cGLyvRdKBmaG1XbbDv1wyWPYphtjTf1SBzX3K9zV4h4tbUl7YEDKl?=
 =?us-ascii?Q?wt48/5VIBj0Hlz5iI4iCXtl59i4c7acPWxT//dTqnssECD6hXiaHbtZ5hXbt?=
 =?us-ascii?Q?0J+6xyfMauPfYPNbMu+1FuAvYhNe/qv6NJubnqs1NQ/m914uQlH3D7TDei4m?=
 =?us-ascii?Q?8fBFrrkeWIZ4YcgJaoCZO/S2Xcp+DWQPRZ3wL4+3zvWY8dCmC6IgE79rxVlc?=
 =?us-ascii?Q?qO25uPCD/7Y5rOZOM8HDcD7vHMSyNPsnP0/RGPo3fMA0xSq3HGuCuVMFZsBY?=
 =?us-ascii?Q?iu6HuRd4op5d5sUEy+JRgbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHm1rQgwlWaDEh8DYpJy9i6TyqUIH5/mST+gIDErLCINwrChTMgOlBaIXluN?=
 =?us-ascii?Q?9ooxSRvjXAQhqM9JgltrDVKVRHiWwLoTNqBlsIb1TRhYK5gXvAvozptPtyDl?=
 =?us-ascii?Q?lkl+97+OKBg9CHaWsn/d5lEFb52YJxVELQgAe5H/TkIk3T+/jWLCGeFtOrSa?=
 =?us-ascii?Q?ATG3l5TyNWhXINYSRpi+t7PBQL3BiILI+ebrBFmZzo2K4H8Xl0k78bFhWB+X?=
 =?us-ascii?Q?6n7BWVrVJWirW8SuC3X4LSP/y7/3uT/nEPcvL/8m60l1PhX+YVtmLS18y18Z?=
 =?us-ascii?Q?HNEhC6aUYWzW1IGwzMJsD8vZiiZOmoe4Jk3X19aGqn+pJOtlajaZBsf5r68O?=
 =?us-ascii?Q?OLfP0SdgNS3PZFd3xLa/E3cq3VyGIGLlgk+LbYmb6UNZnlKwTNdPXvMJcmwF?=
 =?us-ascii?Q?c/YHnQxZ/zwmqCvp0CuHv7KjyJdRBXms6MlBE9djx+rDqHiIXv6OGpxXPLru?=
 =?us-ascii?Q?r7ORtgxxNIg1ikHrKEjBlTiJuZeoq2eqmySjarDzWOnIQTwVVO3RKpsJcDup?=
 =?us-ascii?Q?5zFcXk+PCR51DqRgsnAYr1kJD8oLqA5teACFfVEK2V6jM1m66Z2R7o3hC0nZ?=
 =?us-ascii?Q?FzQBiOFvQIq9yQtu0iWJY0WvcuHz3Ei98RAJ+FL7Rt2mY9ZqI+VCqje0YYmG?=
 =?us-ascii?Q?/YZK8kBScovV2c2ihyafExa3spT7GbOzrFHbNIThXULejTj/ewq61z14Jsdu?=
 =?us-ascii?Q?GDV3AWjIcLnqKTwLenEs0DDb/rUFstA/bP4dRUiIqJ3aAG00Vq27nEbKipv2?=
 =?us-ascii?Q?zyar9FI8dW1EPAdx2bls5n9wvZWepVLw3IxqBoLrLgLrFIGc6Ea2s8cuKm5T?=
 =?us-ascii?Q?Jm0pUhXVU+HPrLqXpsl8UgpbMWYwleOJi74rqsOX8PN80yo69Uyg6xIQSINO?=
 =?us-ascii?Q?vX8pIbYLd0daneEjF6uSH4qQVKg5wMpZKfKiKL7xxfeV56SA23hhl7Lut57e?=
 =?us-ascii?Q?2596zSAowXCd3qat+9EkffTzVPYL5jrs8qpi4bKRpzGmaEvbZrRWjQDu0U01?=
 =?us-ascii?Q?RV0H3HymPvCeIeIeczG7otQ9lBO1d6BCTfn+xtZwbGTpiIiF5+HXB0RH2vid?=
 =?us-ascii?Q?KYqhwTVE4Q22NueAROE7g6SPWFhgWZnIP9+cxuv6vjuAjXRcxBTPr1NKF6b3?=
 =?us-ascii?Q?Yx7nQayRxY3eH22WAbcEDgMHLwISN7lt7XDEreArkoKD5Vipz/VJGgZa6pii?=
 =?us-ascii?Q?GbxvmDqQPwlRWPT1v8693cGsZ62R/u9NrbJZW16JeYctC95J38VDLpF6KrHH?=
 =?us-ascii?Q?fLgoXvuq7lL8ijyixrps8hab6w4BnzEMr3FoJpGC2zPMR9ujgWPD3sTiWG8t?=
 =?us-ascii?Q?2VH2NLPES4CU7kNDiKlo907Azjsj/lCFO/tEn9ZSPnrma6g+iLgKuZ0vtspv?=
 =?us-ascii?Q?Aj1Sf/M7gCpTiVrbAQDUDpPCSSXWmEqceKPvknAM451/pjlQrfut7Bb0HAwt?=
 =?us-ascii?Q?h/zC9O4Ous0HtHOJH5GBX5KwT9sXhkLFMlk245cNO9AyaUOyJX1QwI90jsC7?=
 =?us-ascii?Q?fqjEQWY10bMCGu8NH+QO7HheLuU06BmrrP2zWJNT2EvYN1W8zg51Gb/c5yoh?=
 =?us-ascii?Q?+l6vs7+SOWHcCj93CdC/zpAnO0B5S2Qabmp/Gk/J8WNt+bgVXur/LiXo2rtH?=
 =?us-ascii?Q?ht5IgbvKxzuWO7F320crxFin/A9HKQBg+Q9mZKa73Mq+wkcpn2tAhNR09K+z?=
 =?us-ascii?Q?un4tjc9oBRLViEn0opJ8YlT6TS5urnxUWwQyEFI7XCwYOvmnOGWmThzXqjvS?=
 =?us-ascii?Q?qpDchKkELg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53db0042-8ab6-4775-4d10-08de5c7cd62a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:47:17.4308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QzfjquV09ieadNTIqBAHWuify/vtuv8jUWMpsxmpI1wGuA+lrYMB41SjqkvwJK6E/Sw7GXmXsVNJZeU6sZYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
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

On Sat, Jan 24, 2026 at 06:50:43AM +0100, Heiko Schocher wrote:
>add function sc_misc_get_boot_type() which returns the
>boot type.
>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>
>Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
