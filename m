Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB649CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72858352B;
	Mon, 29 Sep 2025 08:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BSYT6WqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CC380819; Mon, 29 Sep 2025 03:45:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A21E800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2g7YNKrOrI9XEHfvgjrul1r7S5bBztUDOp7pz3T6Ns41P9/YgD2uQ0dzQFerUDEUKdb1nmmKFHpB2T8xfOCNNngHQAq/XEkNxplacNqOvciDBhTyjoxjplMGi7SXUeIo+dbg5VijbCJstUnOh2i+YoUn8xG+7tAyMOCg7Q5LbWoWkztp2SRfC+k/Z97G9sC8IzKlb/a2OceIvb13KoiUy50DNJc3q+H/qV7QQxxFRMhFq1FfzIh6M3YiOoyNN0rzytrB5Eke9YAO81CVStIDD0Vwsl6/dAf84OEDvk0H29Gb7HQzbGVfxz2dnsBGJqpB3IheeP/ufmqXj5aoq5rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9wj79b7uG53G9wFvGxmfIoJd7m8eAIrgyJwU9HJrtE=;
 b=bweXD6N9dlJglMI/cmzwt2tEE8e11sJbyy/NuCOyIAa5SDvbURueqUHb3FnD2ZrtkBqUQEXeTatbFGQG7Hz7ldXU+jCKOj+wmjDmQwtnViB7In1NjDHG7aaHopFy1lPnCobT9TlNnhEoBU324O4j+s7Q91nyUT6EMqX2znP1LSx73c2qPDHRVxB34DEb8zS0OgP0aXokLITAQa1gUL4MIfbYybfBclHAp++7Hw4+L9qadmo+++pfUpzcLRELnPkqNRgL1M1i1JsaOiv8+AupF2hsjI/bXiP9Hqe/IcQLEWyLluaNLF9mfzK1HcJRQwh2aDmUDRXMaLC5ZN56cKC3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9wj79b7uG53G9wFvGxmfIoJd7m8eAIrgyJwU9HJrtE=;
 b=BSYT6WqXPMqhKplRzTrMv4IIPvdCygn5SBxC5PAJKCm0xZAgemSYW69VKG5IIJYbaNqUIkeuRU3hUplu039wurmRow5acb63hrFgI83IOBCkWVSJkp0EPm+NgZptfpAQrPFsr1BB0DdGL2DmaOCrvjHRrK5O5DpfJFchsabaSUPa3VB6sApxY98wnWH8Nu0FWHdBel2wWAlmR5Q4JFgtE7HYXIJqbRKf62n6V2J5Me6qPjZVmRNsG2CxLJOFAuPXbaHS8b0FJ6fFbwIAyzhoCXbVxfbzjCLyMZxEEYzVnnv8GBVxavDauYBIFzDVEb3Ce4en5r5lvQhALlVk8zjuEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by MRWPR04MB11520.eurprd04.prod.outlook.com (2603:10a6:501:75::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 01:45:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:45:01 +0000
Date: Mon, 29 Sep 2025 10:56:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: bigunclemax@gmail.com
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Dinh Nguyen <dinguyen@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] i2c: designware_i2c: Don't warn if reset DT property
 is not present
Message-ID: <20250929025657.GF4184@nxa18884-linux.ap.freescale.net>
References: <20250926100530.732938-1-bigunclemax@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926100530.732938-1-bigunclemax@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|MRWPR04MB11520:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a17fd7-e5e2-4463-0b6c-08ddfef9ce0a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UcTq9+W3212XeBovCkBjvxQP4c/iRH0YkOOZzGvRkyaAKVOHr5Lbiu+tY9Ob?=
 =?us-ascii?Q?FgDHuPE6hM34cEu8IPZiRguCOEq3TquOCy3guHBApToEwUcmdNcb8OS6MIgd?=
 =?us-ascii?Q?51BosrRzwR/WnHfsg3LugBNoLR+kTf37nz/0vtUNhmeJh8pZZ/EZnK7l5foy?=
 =?us-ascii?Q?wg4W02O9Pmk5h4CIAHu3zMzR8AWKha0fbLxfGXQlMJXer9atb44wtji5L8EK?=
 =?us-ascii?Q?DRgz7qf23GlFs3oGMg1EMlAFcFi7rLQ+VGWb4s2efhJyTvKtxtv8X5F6PlO/?=
 =?us-ascii?Q?BDEml3hKTatRpbfNL2iUtxH3k5jYLhj4AKXdU3Lz9K+Zp4/2Uw1gP/jvagGo?=
 =?us-ascii?Q?HmQKet15ISIRm3LhRsHk69XVjm9/OXmgL263xRbRw9cFkNVkGNEFKkpxzURB?=
 =?us-ascii?Q?CGH90acFkpc3booZ0De1q1iU9tVtXxiDL1HmVozb0esdEtcwG6Gl/TZ45CF9?=
 =?us-ascii?Q?NJMesfHyhkLZyls5BNk4jTc7Vh5MXGFpciB0Jkv0F/P7qOL+U4PCPXc4ev19?=
 =?us-ascii?Q?q3pCa6oPBp/E39PnYifSobKW3Y0ilstOcLutNV/rsBZfN5BCh1/hoNRilvzZ?=
 =?us-ascii?Q?wQVA6TCfWnn7tRwzXOIIhPUbOqlFptvCg+gUEt/CCb7H2AAFaIt0UHUTvK09?=
 =?us-ascii?Q?2RRUelO9S8hV3eDtPuLEDRVLqRvuFA+p90W5BJ1SJv1d7iRO8KIO8w3/MKw1?=
 =?us-ascii?Q?yydqnpqtfNU8SsBQ0Tr0f/KH1kMHUioJ9LZJgUxtMbV8mdBNdldRUtlN8Sw5?=
 =?us-ascii?Q?Xr5CmFaZPHHD8eO9Q56PRM7X+dHk5WjaxoD7IcbbprI55zFUXpB5en/XOotw?=
 =?us-ascii?Q?sgrESZS3WM4SrL1AeqJ/p34voY4lvZQcT0WXOtuqcLJ5gA3CR7ykhGVVWntY?=
 =?us-ascii?Q?StETIydGwIqS5VEAsec+gq695jollYVTqHxu+SxMDkMsJprHWaNW2TtxCLN8?=
 =?us-ascii?Q?Q1Zf8w/ILa+Qn0fcDy0gYwfZNwujdH3OMrQl+AjFXhR88/IioKjDreJM1wsa?=
 =?us-ascii?Q?/tMgk+z46k4O9R5JkUEruxwHv1Ciqae0cEn8q8dACrvhV4Q+ixJqail9W3TC?=
 =?us-ascii?Q?YBIOi48/YEZ1/omPkUjfrKKpSpV+zfmXxlfXmMsFg+7TcmzBZP2CJsNbHMGk?=
 =?us-ascii?Q?p3RrKu0cVMSMNeiXHNSUQoztNy616c7aBtARfIdRDfxj5/EXKcV8h7o7767q?=
 =?us-ascii?Q?ruuzyk2NcpCrpucRwHDGt2HiiILHYHBZwQnpZtrOSzcV6CdkT60Oi48lgTtq?=
 =?us-ascii?Q?17sFCIQV+/yfzTlBpjcJlWghGWhai96LO05B2Abbtm+SgcduhRAdZtsJ/KPx?=
 =?us-ascii?Q?OzHbnOKVwn8DCW2zAM3JATMGyYyqqzgwLQsbJUJnE2GMNED6DiRIOdjarKWk?=
 =?us-ascii?Q?TLMg2oXKvzUyHS5NELEqV6TwV3bOcsfZ8jMJPTMqbnE2A7H/ZasESn02hFvN?=
 =?us-ascii?Q?wgmsSFGYkez8E1IZvY+KKVwPtwy5rZwBmfXNP82tsOekHsIGNkltDW9zkJOh?=
 =?us-ascii?Q?9AZGfmbthr+PRmK3pJmf1ADGEVKSMvd6b7na?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u1EYNBPEtKc9GVLLYa9pfiohjQoxI5tnWhZ7s6Hx0jTcJsspq05xEuvPDQ6o?=
 =?us-ascii?Q?AHWXXLSHHxNo7TDNQ1b5+jBysapXtbjazgXpl1G0iNKBe7E2dKrDH4sFAk8b?=
 =?us-ascii?Q?rmZ9qQ3sU1iTx54Hv71ZJkXG82gAy70xPzTVMvJ7IFH2YEqKmdMDeS9lh061?=
 =?us-ascii?Q?si8lms7zA0cPjh+a/nccg/z1onMjY4sWQQX2CEpSEjwvJ5H4CuKGCWH20IF+?=
 =?us-ascii?Q?imT8zTqPNdZW8lMG8GYt/WMgzJ/+dKGtSDom39mXE3bPb/H6nh9npmogF3JA?=
 =?us-ascii?Q?a1wMx9b7i8nguJmMdvlmH/er1YM8eka4HxTFGlfrnjQbYwEl7kI+Ux3q8Ar8?=
 =?us-ascii?Q?doPeNfpDAE7jc2P9O52VRb1EVTo+CMo5pkXf901s9e4RWBASHKP6Jn1S4FDn?=
 =?us-ascii?Q?6dPOoNiQCm7BgFLBS7fh4BcJCafvsoqdLksoy2sq/6cb3CTo3L/seZi07Ymr?=
 =?us-ascii?Q?wmix61nsZWgeqNZ8H/d+nZwXblSQEpl0tkRWKQyGZ7504mnCdskNbNiAdKwi?=
 =?us-ascii?Q?pTVysF/KL7RRaOHDfenlE+BqazsJUMAC1bvOHBof9y1M3hf+HsjriwO9Pu8l?=
 =?us-ascii?Q?2ot93aZ6oLcuyIh3n5IAnStPcTUpsFe1fix3Hs8G0DFg6nQAHHTjnfD8y9Cs?=
 =?us-ascii?Q?sESY4N8ufa6BBLgTmEyOtO0DovI/6g2Q59tK/g1Nny/6l0T5k5Eub2YZuAJG?=
 =?us-ascii?Q?9q0Jm7SnFrdQBxfDEoLkrXHQ6QsS+qzhPtM+lbIbzUwQq2lCO6my9wYVvTcI?=
 =?us-ascii?Q?0KYKqPS/adJB4WyGuuCKY6Hc9bBRCOft8PX0cMyZXPvwGIb1rt6MLKJOUmgv?=
 =?us-ascii?Q?w4mHmzXVYe1qH2GozjTFhQ0+SHrujU2J11K+TcFFHnnoP20+17xVwKM6NItv?=
 =?us-ascii?Q?kFx59Lh4k8Adj/Q37QMkHFzHn0ONlleLYdFV1OgxvWsVVbEYMjxOS92b8Y3K?=
 =?us-ascii?Q?m56boNB9aXdnsAvvehckHDhQO4vyWcGOVulz4Lz5zKZEMTbFl0kgn9zP4v3D?=
 =?us-ascii?Q?3NvrEFF943NsPPq/1yTKiuwQuYJhLzlBl/RFBGlF0Frm/2eXjOZcBEbOKqvL?=
 =?us-ascii?Q?ELI1XLOQTcTm4ujfKGNQLt402e3e8/Heb1xmUAE7niXuoDSZBZ7AnCIfb1kA?=
 =?us-ascii?Q?cGXITXqADk56dTTuL5AcvVGi+ARW+C8GZ/s5bIR8SBXYNCsBaU3gIBIP1yny?=
 =?us-ascii?Q?QFhJj3Z+0mx92bGaIfD9NgiV3vlsGr0KyjnzCF6Ofc7AM/1kATpqq7EQJlym?=
 =?us-ascii?Q?B+RhJ42sEiNUAHkkF0NI0KK3aMhBTgGahrrqFjdh5418avSJHuWi60JNVGVo?=
 =?us-ascii?Q?bZmUD4eJKlgtyJdeCY3eFb45z4AV8UX1BnBkrrsHiSabprjI68THoZfUh66i?=
 =?us-ascii?Q?Xjqm48AzdZ6ck9a2DS5pYLe7WMW21zAY0L1xIdQcjLPCwn9KAqL/VOMZPiEa?=
 =?us-ascii?Q?8t4wuUrH94Jih99jkTlZDww3mdWBV7PECd5vpS2EtC2bHs6Yj9jvLtKk/t1q?=
 =?us-ascii?Q?VKwQCeELeIWk0rETXd/S+aaRlIX62tl3uIwS6OLh9ftdSSC04KMpW+MC+iao?=
 =?us-ascii?Q?xsrkD4SS2R32hXAlq8vALzksC85tB2eeXusd1M5H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a17fd7-e5e2-4463-0b6c-08ddfef9ce0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:45:01.5638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2dwyEuATB0z5g6m/gvw/HGmbhjYPlQtsLdDN995IeZlPGhdUZ+QHLxq7NvqUtex1KvLqBUzoR05Ei7Fu+hcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11520
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Fri, Sep 26, 2025 at 01:05:26PM +0300, bigunclemax@gmail.com wrote:
>From: Maksim Kiselev <bigunclemax@gmail.com>
>
>If reset property is missing in DT, then we get this warning:
>	designware_i2c@0: Can't get reset: -2
>
>Avoid this by checking if reset DT property is present, first.

I would add more:
"reset is an optional property per snps,designware-i2c.yaml"

>
>Fixes: 622597dee4f ("i2c: designware: add reset ctrl to driver")
>Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
>---
> drivers/i2c/designware_i2c.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
>index a54976e7889..8ad716f410e 100644
>--- a/drivers/i2c/designware_i2c.c
>+++ b/drivers/i2c/designware_i2c.c
>@@ -764,7 +764,7 @@ int designware_i2c_of_to_plat(struct udevice *bus)
> 
> 	ret = reset_get_bulk(bus, &priv->resets);
> 	if (ret) {
>-		if (ret != -ENOTSUPP)
>+		if (ret != -ENOTSUPP && ret != -ENOENT)
> 			dev_warn(bus, "Can't get reset: %d\n", ret);
> 	} else {
> 		reset_deassert_bulk(&priv->resets);

Otherwise:


Reviewed-by: Peng Fan <peng.fan@nxp.com>

>-- 
>2.48.1
>
