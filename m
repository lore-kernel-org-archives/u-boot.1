Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B294CCF9E5
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 00:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B8483952;
	Tue, 28 Oct 2025 01:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="KUDbwXF2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31CCE83968; Tue, 28 Oct 2025 01:04:57 +0100 (CET)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DE68391C
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh/c0s5nndEH1ewKcrXun99bctDyGG6HSPuRDxUvew5ILrDgG8MnXiU9Fivdt3/ndDGL/B6q7V9SY9yN7WiOs7Dvlh5nwKjlyaHpNK9aEhJUT4xAXoTaLr79v0b3Wn3ecy+BQKkOxLBXHMvQQO0H4WRRAReii1nwmLoBHef1smBQisTrPlVhSL/kiPTZ0iF7y8nGkoiiX07kvoi/JydCWWG0bl/KHoHB64zX2Vs+kd8c3v1HuQKreal+fF2kxBmJkqJ2AK+XpsvDq1PKOCWID9kJeOsY8Pgp7xlifkUv24N4KMWN9y0b/5X7ne5EyCAMwCi0a+TnYOmIePjGURQaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGkiDdxsEhK34MlPGnVa5Fj1VaDwvoUAN8dN00upWKw=;
 b=J8KZOBZWde2kC1BinCRFmOLy77qgl3XY9454iFGvUfTyIMmn3ay4Skqvqx/Z2kM6eTosl0n8PeFLyP7ifSVfITck5IyE7WlK/0+iCngeAjS+Ds2CJ9cudAuS+ao9pc+nmWMIwbbUY42BWB2Bl381txJIS5l8M87pucbFVHF0WSe79AX+YOeEkFW8ekD3vTF3gXjKHlx/levCwcu+CjMJXOQ+Vj+YFLT9WAMLWEf4W5LWfgiUk20FZpxneVVnyUd5bypWRdDHktqs1Ypec2kAv48yWk9cLyHqTqevxC/uWfSmbncDDiwGmTsxDXNQB0pjhhOZ5OjLwUgUqSdI7Bjrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGkiDdxsEhK34MlPGnVa5Fj1VaDwvoUAN8dN00upWKw=;
 b=KUDbwXF2lZ/b/+yWYkpRC4yrDwcXnMv61dr3GmOr6S7haE+xfrQBJkxuxCYOeABGIceRRUwNEXZPF3+3zzsQZvjKRJWlQR3/DtVxiBgMimP6TZId2zxKUb4wuElWpgMVeknPGOHgiPASIF81gNXReCMyycfNntshZ2OMXEmI2ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by SEZPR06MB5668.apcprd06.prod.outlook.com (2603:1096:101:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 00:04:48 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 00:04:47 +0000
From: Victor <vlim@gigadevice.com>
To: u-boot@lists.denx.de, git@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, tudor.ambarus@linaro.org, trini@konsulko.com,
 Takahiro.Kuwano@infineon.com, venkatesh.abbarapu@amd.com,
 marek.vasut+renesas@mailbox.org, havish.mutya@amd.com
Cc: vlim@gigadevice.com
Subject: [PATCH V1 0/1] add new part numbers
Date: Mon, 27 Oct 2025 17:04:25 -0700
Message-Id: <20251028000426.90860-1-vlim@gigadevice.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To SI6PR06MB7813.apcprd06.prod.outlook.com
 (2603:1096:4:26f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7813:EE_|SEZPR06MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd87c10-ed24-4103-a101-08de15b59b62
X-LD-Processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pUO90Hi8lumIfcJ38o9NPOFfoO1mAEplPhTW3mxpJ+CceNVIRWS9NRCPsuCQ?=
 =?us-ascii?Q?fHJRWOZC78MTcSK3TamEjZ5a/+hzGq2R2m8aplzkRiArQeXVJuQpSxLOkAPn?=
 =?us-ascii?Q?YWUQ9SWkoeBpQMAgAZ62xC9EP/VWk2Mi6K9UZzxKuOBbH9tHB/wmeXtMojPS?=
 =?us-ascii?Q?yxi/1t/aGUe5niKL61uyPO091lDfxG8n7K6LDEd55ucPH81Sa5ytrORugQPF?=
 =?us-ascii?Q?fcxqbPfR19OrK0H/PiBGdefNtFt3kFY63W5NtAyR9kccobnZUQ3AUN6iWDBO?=
 =?us-ascii?Q?7difdgyIqi7i4KZGYrCo8jGqZMDw87AwDhk+abSbmMx/VFLy/1IgXf1eBUzA?=
 =?us-ascii?Q?zKlQmzlbDImLeEC+o7QYycY6MT264+gGq/2LKzTKCM40W5bJKZ28XcPlgEhv?=
 =?us-ascii?Q?lZsJzWNzBifb8HwQoIKw0Cc2Bs0O7aYghOQkt2AyxPxRPhaV1qeBUmnxMIRF?=
 =?us-ascii?Q?8sSEIVB4qKf+M0N6cXu+RooSdkWtg/VwxGJytL4tLEJYFDtXCvvRvJ+ocGG+?=
 =?us-ascii?Q?z+T7cLEyj4iUuD3l+Eo3nfULwLU9kNIHmy0I+6gWQzM7Qtu+Ku5f3Y2S5cPD?=
 =?us-ascii?Q?BeF39UODFcB4Y4M6B5tHsItFGQWaWthrmqXeUq1wzjZIGi4aXy4hdQ/OWGht?=
 =?us-ascii?Q?VvLuBKIiRv3IHOBvFTROPYgT+A578NfTvzWt/6BtUYS9QgQUhaW26UUqxsNw?=
 =?us-ascii?Q?GQt82t7Rc1VMmZ8t5bzcdq12F3C/jkAx5xX6cb1BghLsjpQk5Tv+iHjvpHP1?=
 =?us-ascii?Q?mA3izMXA56exXK2Gc2JHKXA9yTQ2+6Cpn0btR36Wz7wd2riGFGl+AfyJAHYE?=
 =?us-ascii?Q?A5LuzcmIsfpPYoWxASDcBj408L5ZrPSjfzh0zal1/JQPxnNdXal1xh18sTbs?=
 =?us-ascii?Q?E/r3nJdIZC1r/3SYkz1D+KMkpmo4EI1W89NUFN7I2lc3a7LhObOb8b6l/vaB?=
 =?us-ascii?Q?f9J0x8+WuKrOVPRm8iEBxr+vyq0nZ/FXUj4SEnoOdtgmZabsuv8YygSetTP2?=
 =?us-ascii?Q?i9g0lDcwPfg/Ddfu1nexbDDPyjv0KgVqhbUFMbGUpNfBEdX1jwSB5Mig6X0I?=
 =?us-ascii?Q?UlXMONACglAwuIJ1WwSOsQ4/teQG9qx751DZGUVpHHMOXvtjnNRBk2FHseGQ?=
 =?us-ascii?Q?IfktHzSC4ILCZLfNgojiUgZjWr9+dfE7aEVRmiQ3LjrL8f6XR01ExLofSCIa?=
 =?us-ascii?Q?UYH108WLJiSibe49W1PVJpgSHvVSqgcIpBsC37K5fKQgFYRmZxq6x/Cc+nJz?=
 =?us-ascii?Q?YYFKNvLP1+P96IihvH8HLTqLWSC1APaDULyG6MYpxt9fuoDAHeiJVAuQJpqL?=
 =?us-ascii?Q?06JOnGuM46jf18bVE1ONU3PQU0s80yK35On473xTkJwAA/2VAagXoRNufgM9?=
 =?us-ascii?Q?MAFLhPyHQLToUMnQk1sQNHHtLQAmY+iE/7t6o8lzqRhJWay9XtT82h1yMJkf?=
 =?us-ascii?Q?zfmR83lBhJi/rMQuyXEu1BcO9IL+IMZYipU4xIQSd4mBk9FGgD6y4//VhRQo?=
 =?us-ascii?Q?TziFiParSLZXCA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPR/jrcPAR6x7/fCia/LvGu0aJFgeg/9ZbHFgG8ztunLAcBbw/O6aGOY1kRe?=
 =?us-ascii?Q?ORalxx8zYMvIYs4WP6IBlmX47JmkggdIwvyN7SFpWtujperx90yFgj90AXre?=
 =?us-ascii?Q?x7NBik7F1dft4TgOkGp1uhxrhZXcGvX4NlkFUshNvN3AcF/YvOUjYXseqn18?=
 =?us-ascii?Q?9r+D7tOfp1/fKdFMP+bUyx4kYpkrliS3usEDa2ZmMOCkZZCNJfrumOUc6tmB?=
 =?us-ascii?Q?I658DWF171WmlzPdFuQTvy4/h8OimRjFLcEnr8KGKI5R0Nmqd4BOLpjA70yD?=
 =?us-ascii?Q?EfWiwehUy8SbarsCZpM0COhmLMYVE+2gOfGHS6wSmjAdn/qJOP329f/+DZh6?=
 =?us-ascii?Q?1sNtsj4MjkfTszM4iMbW+4hHnEyQ2yx3pj7A96gQXXfSINrCEn8rVGObigLQ?=
 =?us-ascii?Q?p8Yoy/uGqZ72BZeF1pMbuIi91MtE03dImRkZwa0c072oDUUNgFn0dbjRFRYE?=
 =?us-ascii?Q?S8fu/rCDF9DHux8T75Fc5M3jI0piPVnfcYCngy0XhSYhoTIOWBiNGgs5cQc4?=
 =?us-ascii?Q?wcVpHWGWQFgtQOnu9OyofrnfcscsrbC7zCfuEP1yBn16KwYRUa5w/N45J9iI?=
 =?us-ascii?Q?olZiFxdP1h5PsSj8LFSVIAWsFMV2hXMUzU4/g5fBU9dDPGWCUFEXwINRCXUe?=
 =?us-ascii?Q?5LtecgMBoE5KQjRbqgh+G4mnAtpTKX1ZXtlzaObmkDorsOr1Y7lDs/jpF1+T?=
 =?us-ascii?Q?I1wa+oxhwUVW0LSvoG2IwfD3Rsef4cfVSzHwekcJUvLoCjMsZWxTjfpsSk0V?=
 =?us-ascii?Q?3XIoYbAXWtVFzHUQM7R4hepuPAiDV1yC4ddjQ9pvefo6UNrDm89VhCEj50h0?=
 =?us-ascii?Q?fZ4FDQbRHjQWVnjg3g/V814XErn1VSePPlNKklW+7V2t0IlrKBN50gYnKCpk?=
 =?us-ascii?Q?HQALrBVPvmHzRpjq4lw0+MR1RvWSElMXqOyLp9aW2MCCx2M3g/7t7HHfK3Vf?=
 =?us-ascii?Q?qNYadHHCZcB3RkxL6EJFnqSsbKQ+KbBg+qigSqF4BMAcw5gvbA4tQFEv8Agr?=
 =?us-ascii?Q?TPxld/EkUhK4U/We+5/pjGN/JNGGyhqq2dA5VaHJHgQPdz7A5hNWAYrePje9?=
 =?us-ascii?Q?e4druToLx9ctcxUhWSyEE5R7lLk45DP1pnMdxO+fBfRhTZzq+qrTMyuNEdyr?=
 =?us-ascii?Q?0cDpBlj6Y3FdHhUOdJ/QJ9GwXdILKAWF6TNwrRji/obSL9kCbfPlNIFaZQCp?=
 =?us-ascii?Q?UmS3JozZR6qp89x27wbv/ntgbzsXfI/lEjhCqUPioJaQh3Qegn3DkzLyIKev?=
 =?us-ascii?Q?wxHLxmM+XoOfX0WaljAQmiJuqWmieNysaHQehhvR+oqgFV3AX1k5IStGGfYJ?=
 =?us-ascii?Q?eSaQafukFXUCpa0rtPC7xJt9xhDd8yjoQdw5A7iPv/3tAX8/AajCNtlrtM7H?=
 =?us-ascii?Q?V+h2viNEPja2Kzt4wIV9eLgNtmMKvAZFC6WXBOepOdvCVjJ/jBwVvjqm3b6L?=
 =?us-ascii?Q?HMAYnCslDseKwj94l37c0uI6FZxW1VSEkWW7RXlo9JfJADU5237O+0NW69JW?=
 =?us-ascii?Q?BxWQKxrsAugdgVM6ThEjLiwFU5ZGBcW8EwXyrQu1hLU4uwAM14OX8BeZBiPM?=
 =?us-ascii?Q?JERiaH3LuatyZsdHbay/y+aQRtpDXX24vM6yd5376P2qjeiF0R3tdX6yBMNs?=
 =?us-ascii?Q?QguSu7BAwRgQBDzEqrI9J+PtKu6aWkXsDOKGHdIKMfcS?=
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd87c10-ed24-4103-a101-08de15b59b62
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 00:04:47.6852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxpSndqgH+HeiZ6r3irkfMVsFiswnRN41gWCiRDQ71W9rfuIaNw2psxwbZb/tO5SgRSov/MtASampH8pJt7t+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5668
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

GD25B512: ID C8401A, 3V 512Mbit
https://download.gigadevice.com/Datasheet/DS-00649-GD25B512ME-Rev1.6.pdf

GD55B01G: ID C8401B, 3V 1Gbit
https://download.gigadevice.com/Datasheet/DS-00979-GD55B01GF-Rev1.1.pdf

GD55B02G: ID C8401C, 3V 2Gbit
https://download.gigadevice.com/Datasheet/DS-00980-GD55B02GF-Rev1.2.pdf

GD55F01G: ID C8431B, 3V 1Gbit high performance
I can send the datasheet via email

GD55F02G: ID C8431C, 3V 2Gbit high performance
I can send the datasheet via email.

These parts are tested on Digilent Atry Z7 board and Xilinx Vitis.

Victor (1):
  mtd/spi: add new part numbers

 drivers/mtd/spi/spi-nor-ids.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1

