Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11025C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5952984A26;
	Wed,  1 Jul 2026 09:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PBzyRvmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0438B84B1A; Wed,  1 Jul 2026 09:33:44 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2823384A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7S4wNaDLVTJAMT+KCIYP/4oboDC1StH9KO20KhRRxTN/RNS6VJCt7V4GahjAMl7lv24599mnO1pu2C14zc6y6CMDj7aZvwXjYV1I7Wc6tGfnva35KNe4FYdGmG7oluZI9lVVz4XV+jEPznVFNjyJu+RWXfUz9AOn0/Ebb3dmMvo5x7mezkDEVpmIQLed1NwXmSyaOxw321f/82ePtWUJYvRnFyTm4ZbMJDRje+vCnt2yVxbr5LpCAWdUJyYHoEp+nnxrETSpHZrLyZEm+iC7AuARrA6EqkEwGjDs7jPkdTrauD5mVEhanx+qXcnle6eQXweZ3M5AtA+vHMuPfywww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noqEnoHpJh0mNF3TUVnaODGUOiTxdW62eejlg6e+wqE=;
 b=S5XmhIc8PK1gZi+guVwuiuSY+ly572LvJ+gXmwh7t4IcoReA4l9M2VNa4KwvfLcGmtSSIPX9RlPb/dnouvfFdhkhLWx6nr4k4UPdi/WZmXW7uoYG+PKiv7BVWPtvK6FNKhaiQnz5dVzRsd0KRBv4bcLunjKPXTbNVgn7V2W+OpZYiejJHTaTZ6MjJM/mzF5Ra8TPL9orCnBNI0O6YfwMpQdWmqLFeToCZHl2DXhUFQQCvP829wFHQ6PXLNKC0F0yD0ZwuGIKcVhcN8I7KnfmcGzJyxzLu/FBB5meyeizDJSdfZRRIBiRoI8vgT9uKhqCXSiVATZPryWNuk2P9V9vVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noqEnoHpJh0mNF3TUVnaODGUOiTxdW62eejlg6e+wqE=;
 b=PBzyRvmnsCpviuNS9yrWAYKePNveX5xtB7h7KOFceareXtCSofVh1mQ0sf7KpguOktp2e5Fae3lkOg3kFCSBjhNu34NS014PQq4m5P9gYYoJD7YwH9rkytb4JdNo9eEJyac/I6K6v547JG6QnrPmgw5hItpwtfWPl33OybMkv/0pgYeMK0/6UM48j0XLRe83q3+DkCw/CWdS4LPw5LaYyFxKZR+S67LHRkP+V1m3XLdKpBZ3gHkL9Cv5gCyJ9yKlOYHOX90szLh4LNGOWTlheHLzboKowqM67NII/Eue7sfycH5zDjNWcMJ/xbHV5ycXv70TeSsh8+tEg0JCHPEN7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:33:40 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 1 Jul 2026
 07:33:40 +0000
Date: Wed, 1 Jul 2026 15:37:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v2 1/3] binman: imx8mimage: Generate FSPI header in
 binman instead of mkimage
Message-ID: <akTDoiZsrHsBpU/y@shlinux89>
References: <20260630084112.13259-1-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630084112.13259-1-marex@nabladev.com>
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: bbce996a-2a91-46d1-87a4-08ded7431239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9IXaJD+QwdVAzEBp4ku60kmnJykTEdivkbH+BrKD8/5QcoEsufA63e/hAOG1wfsAJdHOngAERyIZzwzNurz/XSEb65KWlesUYVYCOLnwSeLekS2eq8eR2OUOdREFtDy5UvSDOb3/428zna9P5hVoPCJtLZOguJ3DXrtphWoOjn0rSnsnhzcIOmLrs8kfDHNcYDWswljOzjpJFpScHFwKDLRNMp/21x2Lg9y0ntOzTGXEyobwzfcf3g4M2qJZFHo9ncexIRXCXhM7lgRFpi+dqwhTw7kUag0BAKflfvYJn6jzEIjjF6UC6kLXCZspBB9RSreXaItifB/tcb3xNjBFUgsZn+GFQvImZWFetd+Nh4iwYMkblGkJjpMpjvqUtLi4KQ93miJ4X8X3hrQBomMK5REzGEenzAEsZMWq3k5Oy26jN9cBNA9oi6SO7xNpJq5+o1mmpiTqdHLY4jU7jUWBMIWfvEzUQm5Xec5SaoIzWmP5rA/Lor2gbqzSe0La+GIaArd0V6i26SY9vHHO4W2+nHNKzs9EmUD5zLQ8RoI/1jWNaRQvUxUcCOQCYN1gv+YoNWDmBHoYEHlqVuNB5x7QBScvEDJckXCIPr9Vw/LVfMWVAmXam6H4UpcQQQnQKKRGWD9O9LjkF3ZqdB6LjWZrz6m3NPS73i7aKlIzGhOMlsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJSVQkzlvLK39kRG+7qKhzYHnbblwMKy1ER0mDp54St8Z8f7z0/mUIWx4cbV?=
 =?us-ascii?Q?SRAojsnCSa/3zIg8smb+KgGZQm6BP/VnIJf2F/C7dPyEA2xpdIYhRnvDQHcj?=
 =?us-ascii?Q?Z3DQuvSj9YhU11Z+yH4TDKxOv6xhuhFQ3+m0q879wC02WOV8c6frqitEIDiI?=
 =?us-ascii?Q?xmv5FM8R/HTDEAYZFB0OBn7LkUrPi9dw96XINvgM2zsFpKFWDpY1cLrlIUUo?=
 =?us-ascii?Q?JHeWdDkRupcV2ziOY2t+/VVOFJuWoVnLh7i57eUkdWP6sZBDo6cJKfHqnWY/?=
 =?us-ascii?Q?n66UN+0kUd59EIpdw1aLVURzwW0lzTCOJeKNwSA+IjZHs9Wrp1YIsDox9g4L?=
 =?us-ascii?Q?KdqyXSrJFTn65tFpyn08m8K5WJ3vQ+JFPUW+QQUwOnwLIGmXThckryu/2vfw?=
 =?us-ascii?Q?VJg6tss1u3BUx8mpgkLIkYKvrrQVIHk5EIITxQtBGAzaPJleyzhWJJDvIIhU?=
 =?us-ascii?Q?f1wqtK84M7IPvRJspUR1B5ETnMw88fSbUlRducHPWhfyhiL0YmYl0VCxPo7t?=
 =?us-ascii?Q?5MHOVwu6+2s9ldYl/N5F5Jwut48IHk25p8tN/jPSb4jhF6Wf/NWegms7/3EH?=
 =?us-ascii?Q?8zWcIZbN082Ft3BxBv6L670tTVYq+c3IxTffOC4lQaOXaeGa9BcM5/QXOQ70?=
 =?us-ascii?Q?31I/WwQp3iV66Thb3e2vZTTS116ry662d7CXsN9vJk7pQG9vhI32KDQz3yJE?=
 =?us-ascii?Q?c9V60cfEudm2T/SUadqRb3YZwcOX8UQ6a1MtkE7VbRpjC3vYR0uDeJjHO58v?=
 =?us-ascii?Q?2wwMJJKci2nptW2/hzBLXJdve3Lu+lNeq5iXPW4fZfrbuq7vpGd5KfBrZ+EQ?=
 =?us-ascii?Q?2DcrEYbeYyMgWUDAqJi9djcLzUpsa6+AX/09vq5lHDAMV44wT0p6qSwjhZlm?=
 =?us-ascii?Q?SdWgu3+Q4Y/3R3xRHW0lV1tj1Vjw5GchV3ATriXqQ6PyoqIRkq+DSQz7v414?=
 =?us-ascii?Q?qSzxNSrw5kKhWbpNft3AoBADZTa+w+4AOJNZO2/o3y8uw42fwTy2rh4j2v14?=
 =?us-ascii?Q?Lx8nQQP1dduOISR6utkxLKzfG/eeAsZ7OVamMLtMMUgb9WHcDQEZbzJ3n7yt?=
 =?us-ascii?Q?E3Bz0PYsM+Ft/xpklrIC/QTaUF8ZP8iamoX0LhfUr76KIXlaBGv5k5vT9WwM?=
 =?us-ascii?Q?cUGmvMARIoUMmrA9kdG0mTb9E0P+P3JH88yVgtnnPtnLgEwV62LV+AapfywI?=
 =?us-ascii?Q?9CuLff2TH21iNyqzMHwEoEnyPDuk+HorP//AVmcs6/i2UwgVQid5/LNDeknY?=
 =?us-ascii?Q?+4xbGg+t5T+A6bJNqtt6WYq8MkZnwLViC7QAHLn1MY0h/ym5kTQus1J2Q8BC?=
 =?us-ascii?Q?5blD5I+57G8nU7188dfm7/j5XBviaj8uFaDP6oD1Nww750ZuNQ8YC7J1mgjX?=
 =?us-ascii?Q?HO9GQ65nW7IVkX/HAeu301AluW7jCnFd2aOCLkXkIC0pfnrKO7PXNZkzM0Us?=
 =?us-ascii?Q?9qcFvW4ay0r1jeUG7srzwGhO3XOnmWGIcLeApXIJHitPT/T6mxP5yjmZAtCo?=
 =?us-ascii?Q?3pP5ltfxfSA+bteh+m6PF+EKqSZfHoFR1wr7WqzKg2lqcRkHCdg1GHCkOQy7?=
 =?us-ascii?Q?J0xfc0th/W1vCWMPcQaimhcQdLB5xeTsBBa+i2RKwRglvVKLfJlj2g2gduS9?=
 =?us-ascii?Q?0jPuzkwHZpuSnv9zaXo4+iBhfV5kk0B5OhsChFl4x8pNVsLJiUqN0hKZVBJz?=
 =?us-ascii?Q?cMiAhaISvOOjJwX6e6FjxV3639Zpfc2oPRX6k8dvVNbvkEh7j9hHUprAfkn/?=
 =?us-ascii?Q?aiGHISe12LZvhXTGgxdA8T2KkHt1Pw7Ll5LnnuVjNqeVn2O3OO4D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbce996a-2a91-46d1-87a4-08ded7431239
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:33:40.3339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk2GR2SDYmYB6NhFe597TJk+ay6QdL03cqP6HTScj3Dykc7Ns4hDFLYO5g4001Vzg09Q1f9VeDzUKKqqhxDwH6uGxmkPsNYDAJDA/YwMo+8mrK2KQcags8Na3C6mT1sE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7497
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

On Tue, Jun 30, 2026 at 10:40:46AM +0200, Marek Vasut wrote:
>Stop depending on the current mkimage method of generating the FSPI
>header, instead generate the FSPI header within binman itself. This
>is more flexible, as the FSPI header properties can be configured
>from within the board-specific DT instead of being hard-coded in
>mkimage at build time.
>
>Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
