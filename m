Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0A9CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A46A838BB;
	Wed, 13 May 2026 11:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FB6ZpfF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D18B844BF; Wed, 13 May 2026 11:57:37 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23DC8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBerKIdZ5bzzcTidO+vSISk4Yo6Uhoa+2IcvV0rS8Tdw4Di31qGwSqeTY+pCkyfCwOCSsSnqtrYyLxDYxMoEMfYZlMwLqoPMXnREvHZxvzutuRpJInTOQJrIp6mTo//L5z+MUfjCXWp0joDltKYTfKWXJmUof+VfkBXcoGQEQk8HJkMbImOfB3BSm7K0/qJvfs7v73t4cttv8GHP+cLraE1XtWaPZxxAAeHamWufGeABnJxD8lR5SwMdGtSuA8FDhxUEqhmbwfMdeG4Y+1KY6xtp6GiEHAFVph3zO9j0RMx4/n7kDqY8rKttLgLm2vzKq4fryHlaw3gFPTznOjIkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n6zYSEUAciJMt0oIezMQielThrscX7VweYujVrsSas=;
 b=afNrpmxroXQm3v4/yT4YiFnqYoHh2rDktmBT126+h/nmIL7PccjopHgubSpHURNC72nDAnXkEEsWA8wdCmm+qc+O9pjAtE4s4NP8DvjadGyaaX3p7fou2Gv4zTwUzjW9dpI8Be8mVwMTpD2Ms6H/v7utzGSCWdL9JxEqwYB2K+ovEBDADejOsU/C3tIJxP3LHMJTtIFgwjxFZhLdVXktIlTLvtWyhdoKi55sODiyYZkhqetyaMO31mEcwt+GDn9OaA///WjbhyeAzrJWeXDiZhsM/qHGcPXx6WyS+ebn1L3hK1J9rft+mqXlhWFlcPavWrI3dHFdndxwV0Y1ZNB40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n6zYSEUAciJMt0oIezMQielThrscX7VweYujVrsSas=;
 b=FB6ZpfF9Im/xa2h1v/AalRhHwj41NnhDWF0e/HYwuvMUVjnCwZEuZdAG2Xhp6UxVXWM+D9Emq5ucmWeP+RGDLLhrOIMbE42OSeEut2k0cXYzmOav4dffmqUzQqU/l2Q99fESF2ln5wAh51jQzwFqYG9ndIqAdUMWWRryjJvq07LlvuFjS0fTMPm2xBN+UWPE3zKEYDWI0MemI5KndPnb1v/6Si6kjfFSeUxR0wIiIrpoXtre3HPOHoIKltSouSiBV97cmOsDJe53Y5uHL7CEH/y5NN+81Jtv3RnFoDU7zM0s6ZhaGh8iXALcMNcXIV2VgV5CdHrwYMo8lB1uzJh6LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA2PR04MB10085.eurprd04.prod.outlook.com (2603:10a6:102:3ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:57:32 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:57:32 +0000
Date: Wed, 13 May 2026 18:00:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 01/14] power: domain: apple: Staticize and constify
 driver ops
Message-ID: <agRLtQ3g7wfEATqx@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA1PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::20) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA2PR04MB10085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1406aa7d-055f-4ecf-c5f6-08deb0d60d06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u9oFKZA8UgbhMTS0Mk4NzjC0deW9CeO6G5K+LZzuFTfhzOr+cPhnUDOHyiKunRUju+jTJPGULK8Qhk/J/LsIfo9kf5E89W9Qb1TRFSp8wanNv6xZyv3su4sDHTvrOSaR3vp2jgyTHrpClXa8j5FEgz008YWEC+0qRakyMJnGIUxOPDebuRkuw10kkncSElXOtY7OCEIEf1z03cP7P61GmB0/CPHTVrOufyAnEuXQMxf/GqbYic34XHl43X9TKz8RQ1gE8FXR48wWm1kz6qi2dhcIXg9CYPXsuuyNHTe/bddLsCR4Dciwq+632oqsBGfPnnCe9aAsvErvverhnsD+pFbQyW76fRH/jgwNp6p1PYxYxzKwb1bZMNZasatLm8/LHgRfEoZSKZAdrWQqKgD7CDqctkglLtnaP/y1sWVw/C7drOSSf8tz9afgwcDrlte7xVlf33GkAUWymgPKry/enEl+yYY91wywPx5mDHA8D5OGKHRnB/zRJiD7T31SjVP3Rd7JFFXLVlXRCITqhstCbg2VNg4TE5NaUbSKjGptpYvgGXPn26v4MB4FPTdCK35mDtk+8TTlFjZiPwRROv333M5ubO1cuUq9eCMHt15NLyMAcwnzKyHM43KpwfzzMK5wsrHKBlCD+Is0eTEdNW1G5aYixnj5h3SgdLR8q5CZ3McYRQYYfNURoJy6Ak8Cm2Vl7ru/GmhobuC84Qy9mo+QF0Mm6WHOARW+AK9jMO4WowifCMiofhH+56jrO8apDa6q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7R3h7BnhUj0u1GB+OdPjLvArOd6jscbyMZ57V8UqRqwsddixaBtKgjSMujS?=
 =?us-ascii?Q?SjAgPEh2zY7C7tAcxVGNIiE8Bx2QeSnZd7Occ0NKrGiJ9ACqOYPZF32k8tXH?=
 =?us-ascii?Q?aJXZDjv8Vg5+j9zZ9uREqbONsfwojVOCYXWsR/s/2MDB+csOjVmcooiyNecn?=
 =?us-ascii?Q?wBlTlKCERn9aLs3KYdWujFbf9w91+FjJnevVlBFQ9weySXvAX3w4o4QZH6Qx?=
 =?us-ascii?Q?ndpq/g6hwmegWQT0UqHEkM6rBQwbuUK60gDKXxnrBWmW5S8r3qKXZ3r9zfUt?=
 =?us-ascii?Q?7iC3kGv7F7Cy3nhqNn46VKqmjDOrC9tW3OtEl8Zjj/zVQkhWoLzf1z2vQBNj?=
 =?us-ascii?Q?hxrbjpGMGdRv/5/GvLkKzLHPNO603RmhFGmHIn0Yg0f47eQrKggaT/fp16QT?=
 =?us-ascii?Q?WbKgJ1WqPKwjckZISjxDhDYA81PcEhU86dARSSmJ9Scbi1C8qpeB8FeRlPaT?=
 =?us-ascii?Q?VDxg+hwsLeC8HfphMPlFfhidBWlrNgkRhtCoMkrykO4yByKSYxmQZh+Tu4Bu?=
 =?us-ascii?Q?Arb+y0OhYDjisF+T4w7LxrSobG4j9axqa+/T+dSD6tpgEzw8xA29R5kMCf5s?=
 =?us-ascii?Q?aEAQtsdyDsBvEdO9eFiW4Cu9vVIElH3tn7eJjqK1XrTQt301nv1OpVMDKRQF?=
 =?us-ascii?Q?4zcEXGb9ouup253aU5tin9xEB9MpGbCloi5SuhLDD8k/J6jcFkqFWBkXa6GE?=
 =?us-ascii?Q?/433Skc4YiD7F3PgpHrbYwyq75LbprTIEB0Gg7rj6VveVa6dcSyJvGALtGzZ?=
 =?us-ascii?Q?KCCKjR8Kdmm5Wc8AG0mpF5pZVU85i8ZyZzxfpaQVG3qHzFK1b+tCZaCVNL2+?=
 =?us-ascii?Q?nygLGB4AgHWJy4HQhQhqOkVK74uFDz0ZMtpWsaoDE+s7kmQ3Sa+PyGjZFoJJ?=
 =?us-ascii?Q?cTem4BE/0E5H8YAoYNfZiG0wBRNDUAs9v5ve9bcafg18eOz9KOOuRz+mFUm6?=
 =?us-ascii?Q?PMd3whQPxda2340TJWp9Rc0ttUwuqA/Fj0dizZI1rMNIu8Q9Lr/H3cLmJ8+T?=
 =?us-ascii?Q?S6mmuwxLSBDykysIIEuPoT1o1l/OTJ6sKUF5L+X2Z2j/NjpFONtHgLNaT9Z2?=
 =?us-ascii?Q?OQ051w7sIW3LcNQFWHQi058y/LJAmwbpEoXQzVJaE4gJmYhZ8xhrqb42zJbi?=
 =?us-ascii?Q?cW6qnU8u6gap0bqTBb9J1evh+BKDq7iVIpg9ac+HKvgewMg6QQv5NAg8yIxi?=
 =?us-ascii?Q?P/atwFlInP8x692+v12BWNyJEbkNxqyLTuz/TC+j+3bryHGvOZVTNO0r0cVJ?=
 =?us-ascii?Q?7gcitQHc8+qhE8LEIi1mLq4IL48Gw2ibQSnQcSXfODGZ2fEDph22xqQGjB/v?=
 =?us-ascii?Q?cS4P1DDK4vCMaaN6U+w2CNQx2+3ImL2uF540yVqCtCtVLY5ubKV5Q8gmm60B?=
 =?us-ascii?Q?Yhr2Thk0UVuAUZNLRNmM/ORSqyvERX8elwKi4f6UaUhHIbzRY5JCSvTGZ/Lk?=
 =?us-ascii?Q?dMjFgDactxiuR+NZ/mBrvYxngIcgufAMH9IIPNYnOsf1XY01s9kFalVpq+9t?=
 =?us-ascii?Q?9IVDG1QEPcCBDinXHCps9GDeLf/VpzlmrZ3MpNVJGvo4fqeCyaTc8ltZ7jK1?=
 =?us-ascii?Q?GeFlC8Kp1zaAPMzEfR4xz4WC9w/NnSPPd7Ij9dNZPStllgKvZoNdwBu7NsGM?=
 =?us-ascii?Q?++uON+CRZAT1cVQajLnbXLahMJznZYV3chuPzg5ZjiBfvQvcg/jN8HyNow9O?=
 =?us-ascii?Q?0zTgC2lnQWTnkpWwWZ+s4j5ybMaSgzvITslYMkhuIgBuQIv4MIaPogDrQyCc?=
 =?us-ascii?Q?DIKna+vqCQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1406aa7d-055f-4ecf-c5f6-08deb0d60d06
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:57:32.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrlOHnR/t/Cxq8jQW2Ksg5ZPq3JuWtoPJ2mOhafZA6F3hTT237NWvhBVarq0rrGXr4O1yUwA0V/4yiMnp4K/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10085
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

On Fri, May 08, 2026 at 02:22:01PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
