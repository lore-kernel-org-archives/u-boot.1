Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C20ECF8552
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE61583E0E;
	Thu, 20 Nov 2025 09:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sV8hjNAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C3383FD3; Thu, 20 Nov 2025 06:06:56 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA1883E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 06:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRbPbK+jszYq/UkFibFedav5jutMru3orgFhm6RLVXrmuOWsV7sQ2WZk1QjOMLfCyISK+GeEBsbEsh8B24nGGlq1/NQONJ7Qt3OPTi62Qm+Xbxw0xVWcAMLAWuQ+V6G7YB4Le79Kk0+T0DZ4UoFX+qCu0H7Qe7XtUDDSsi/JfmtLp/3h/rX2oXxPhIRICYCo7scPgHnipp8sYkJAeykn06XZyWo91d7viiYkXlQQ43+8aITGt3aElPYMu8fb+Ngkz8vU3Mj+ennkO1G+OocVhupr7QHv3mKtgWtft37A+c4E/CgDGnxuaWfCDDxj5DUxtze/eI3LRfTC6zTpmUcYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+qUnzm9mG1li/T9ZUqlVJ+r/BxJtBUCH2y+0/JDNoo=;
 b=DsmuA34Uzg7SZSU60bbsNmokVTP+HIa608uNh8jbFPfMTYRUpfLlu8EsnfK2HTvLBZjJ/LSrKMBILB+C1+N1colez6D3Uswg+RDFpkiESCi5Pp0zbJJUIz2pBDfPKJ6674tEtH22E+1LDZqf/GY5vIIhjY0/WZMwsykEZdyAKNfFLmtDcZSgks1KV8g1S7xq8FpBiEVOgBYue0ASffrfkA0WR6/WO0PjMrvAIHehmBypQzPwrMxlpYPKaMfIITK1QxbqGK/ElC4+rmAHmT+ge9LCoqx0X9H18kNM/4AuHodhVLraZaKxl4IdiyJLn/D3CLATPk3sV/oXCMNpGFjrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+qUnzm9mG1li/T9ZUqlVJ+r/BxJtBUCH2y+0/JDNoo=;
 b=sV8hjNASG7TadFWb+/GAT6UgQ+jfY1PzDeSYed88PoOWi8Bhx1v0tnKQQXehsrgZ6uMWml3yHMN1QsXDMhYyT5OwIdsiNhKXDNJivsayWgFB7kPe8wFYLCnvBccMBWKDJg8OiJ0kzv7LPk6B1mNjvL/2Qa+OQy8kDZ754lCH/XnKtAyHHCNr8acfGl5FLPvHGCzKt430GgoBAzUoUIuCwYDxZTGlgD1G3H5Cz/oLcOxqyQQYk1OngA4wi3wnfMdMNUgZJjHKsn+1U3OpC8vwS/95XMuBKDPg1oXDbJmR4r/so+Re/wt1JWZd+SmDblxkgVCq3K4xFIFm12AuVFdDhg==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY1PR03MB7804.namprd03.prod.outlook.com (2603:10b6:a03:5b3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 05:06:50 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 05:06:49 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, david regan
 <dregan@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, William Zhang
 <william.zhang@broadcom.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH] nand: denali: enable SoC64 SPL NAND boot with proper
 Kconfig selection
Thread-Topic: [PATCH] nand: denali: enable SoC64 SPL NAND boot with proper
 Kconfig selection
Thread-Index: AQHcTa89PMBX4mf9jESLHao9nlTmGLT5bmoAgAGrGw0=
Date: Thu, 20 Nov 2025 05:06:49 +0000
Message-ID: <PH7PR03MB69422AD39045D28F827ABB8DF7D4A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20251104171902.15039-1-dinesh.maniyam@altera.com>
 <610e4623-90e3-40c4-be65-66c19bf6d7d5@altera.com>
In-Reply-To: <610e4623-90e3-40c4-be65-66c19bf6d7d5@altera.com>
Accept-Language: en-MW, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|BY1PR03MB7804:EE_
x-ms-office365-filtering-correlation-id: 7e3cd8a9-b697-435f-c392-08de27f29cc5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|31052699007|1800799024|39142699007|366016|376014|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?JgHdsQdpnKGW/UlVtXBS/AmR+4CPLN8fFl6QWXlsUvIe8X/EKTDByW1KX+Fh?=
 =?us-ascii?Q?uxF/2hvEk0D4v+WZiNjYnKBtFDQscw96XMXgwfD7ACuKSH8MLZHnve7JOlM/?=
 =?us-ascii?Q?fea8UE48j1FqJCVHPz3Wd0e7dqpchAy2dCNmL0aR+vnEdtOr3uYzDWZVfqnT?=
 =?us-ascii?Q?0P4YgiWM5zYCpvWkUzXBa0/OflgqjiA+veac5dyeZMNICQfzwn3rOEPswHfc?=
 =?us-ascii?Q?EiQtlZTAio/3GsPDV49sGdUOAYG6zLN4d2u2QKrD9bCeZbvn0M0r645BQ/pf?=
 =?us-ascii?Q?jVgrg6vLq+aMKSrNN2vU8HAReoyL7MlG4LjEALM6qqOIwEfN4oQk/1P9242t?=
 =?us-ascii?Q?RGSxaO5x5kHIs+OXZ6j49W3WABar8p5aFD1xKhR8K0ukFcoDI6RvJbIk01zD?=
 =?us-ascii?Q?osjhzFE3wJz9OPfukcCLNneYCK+EwIlRHhZE5tUb9PdPYgMXCRHP8J4mswys?=
 =?us-ascii?Q?fjuwsnr2byuw4mtetv/HYO4E1mkH3iGDsiWfv045vqJtT7Ih79L0iMtuPtsF?=
 =?us-ascii?Q?RC+RvyEVxoNB3VxhOJRayu91M8/5vwWZJL1hhYdaVD/4UeEfw6h4vD5YkJUO?=
 =?us-ascii?Q?LnNj7VDfJkVUYdBZaKmpHLB4QckqICmLxGBEGOalspND/2m1iio0vZboIxp2?=
 =?us-ascii?Q?R5JuQma1Gp9JZwucgidRYhtQ97xKjezaMNgl5SMZQGQ8pIew4lG9lpJLQS6C?=
 =?us-ascii?Q?soNia2KF3mhT0qLvDx3p0RnGsPHB0z4q8QTaipKMZdlqqwF0TbJZ8z9+XeLP?=
 =?us-ascii?Q?RzTqmcdVr+3qA5NfOc+VLO2g3rFBv9atBCq5vHCfkRi+kuFi3kpMTHnCJNZ8?=
 =?us-ascii?Q?57lTRahEa7Y1Oi4jYmQKTSjKzlRo1k04VoFagpo3W0WReSDVkyZUb2KD259v?=
 =?us-ascii?Q?rhGXRU8fNzr79ERpIWU/Sj7BUdTqL1OKZ0GeJhppfKy9/WTAHza1XktJ7Hme?=
 =?us-ascii?Q?ZJqb7Efx2LIivxpn+EDWwnSerbCj8VO5zomednyTdw6fGgPMhqnI3dgmeMxm?=
 =?us-ascii?Q?eqECzO9nnZXr9mwYDN8g106JbQQ4IFfjEd/TYeZ+EShovhODglXA7WmX5f8V?=
 =?us-ascii?Q?eyxldUvJq0jxt9N8S09Xfue+HXIVj7Cz9NBDhVdbRa7aVAxbpymE/sLH41s/?=
 =?us-ascii?Q?LQ0vJlO4m+9AvScYCj3IBGM1eF0WyKOEkHTl5kE8PL6GC9JLj69HVxCdzIZV?=
 =?us-ascii?Q?Imd45AIsJ6BZgqnfc796NRMvnCIbG9whomnHoUJdiu/9vN5wCDATo7Xr07T4?=
 =?us-ascii?Q?bQJWA/hqSmgi/V/L5e3Kd9rtmyuR+0y4swDyeE/5krCKmmUqN8HVARmQkEro?=
 =?us-ascii?Q?PbM7LSYWiZPXdCSKVxYhwvhfquMjpGdJBSxrU/xE4k9c3TXIv33jK0uaqAxB?=
 =?us-ascii?Q?Ro3A6UdaUUYx9bl8dhYxNT+UoRyM/DqCI+ivKtyMG0onxbkPWlaKFQVpJd5U?=
 =?us-ascii?Q?PMvFzD7yIJ5ASvrUFyxGDPemtByyPMAFh9CcFcBW73YjaXa/9B8EsX+5VzYo?=
 =?us-ascii?Q?iHEeih6+pQYAjaf3DsgnPcPBVj9W8EUsfAnE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(31052699007)(1800799024)(39142699007)(366016)(376014)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cxcoY0GIJtYwnsJ34YWdckA+NvrmVE3Ea74x8/6+fBpimkfz0EigZjXsISXk?=
 =?us-ascii?Q?/BwB0ptcFvPHRjqVpX8ksxokVeO8z1GrX6e4nGNrN3ZJqhzbB2pR2qSOy/gV?=
 =?us-ascii?Q?t2QksfSlu15AhHO8VEi2suidkZOkY3td0hlvcYkcgxQ2vW2sxziZGd8gXI/l?=
 =?us-ascii?Q?OYoR68/z33hE4yvFk/h75kpMVb6yihaDNi5EKqFCcT776ZdeTEHZNvPMRVbH?=
 =?us-ascii?Q?wF/+Ep0P2yWWSoudnMULPxhA4y8hI8OnQKWcJbU2vIrvdqx93alyCdNTgvM6?=
 =?us-ascii?Q?Edfdi4/muonmOn/WXulb5mYzC7FDmBobXbdMgVEapXi4WGZ4Xo0ebUJF6mTQ?=
 =?us-ascii?Q?rOjsaQN6Jzm7MWXRgG7c5Pd+TQk2Wr2yHQWEtZSbmpTverfB/HlbeomYG0nM?=
 =?us-ascii?Q?8n87BEf6U8EiwEqfULO6KZGx3COp9cA+FOlPjnq6JtkBlfm4daRbdHvM2w/r?=
 =?us-ascii?Q?h0qscz5ImP+d4J5YmZzDzdklbSC79Q89BlwA7hRm6lRGMDZDRckke0ELyZGK?=
 =?us-ascii?Q?mIfA9W5k6XksPEGe2sVx4szcZ2cFkZ4KH3Bm/0v5M1U5rkCxm6efCbv9gpyB?=
 =?us-ascii?Q?z0g7ccVOdruSire2fJ3AaYeH//vjCTHhy/3BrzBE3NsAfRQ895YxTY52xd0l?=
 =?us-ascii?Q?c8tbjl90QctHDJDvqlpwWMHKL3IYn1i4WyUNXJUcpbnw4qWw0lXCid7enA+/?=
 =?us-ascii?Q?OLUm8ayZC7g7XA+RXfey7f3cONE9wT0BWQQ8tfTtELF48cWdNN0JIXgqHctH?=
 =?us-ascii?Q?w8GmfranCTQ6FQmh0MJ4nV7ciHNTN8ZC76s91+9FXn4CecEJnuyDgJWsYEft?=
 =?us-ascii?Q?p+Tfln4ytvpNrSzCHtgF9OHkUWrZe4C6REjKb+uwUs5N3YV4eib24mMvc6Z4?=
 =?us-ascii?Q?bJ/LIdCvLHqY1EE+ubAt26HB0hyhfX7qAWzaCDls1+YR8BtqktFh9kevjO8G?=
 =?us-ascii?Q?zUrTG7rcgBYblmPmlqDEJ7X3ZiCoANB0aEF8D3G4qdKclAYAI/0rRlvm+/2r?=
 =?us-ascii?Q?nL9sT5GkrMuOACFn4cNuPkFWisk/PKIr8CXCjBDLwiP9lF3Y+rqOpisotiuw?=
 =?us-ascii?Q?SQSZ2R49ty/sdt8ayxjMWYWR34uRz2Il8ccQUWgAaAO8+hAxHEKXtqmw76jF?=
 =?us-ascii?Q?1X5kK2K2n4AYiLCBBFcFtOZ92XPtylwyArAFRf/N7AMpb5NgYRyxlwEFZHmJ?=
 =?us-ascii?Q?ZxK0ERrx4JXUIS8Rk0IDGed+lMAe04SnpAGYGY+6ZCe7hMGveK3vRYgBOsVH?=
 =?us-ascii?Q?zs81+I85wV6cR6ubv9obB42uI4ZPp5uee+/N6guLkvGQYxlY3tPxEicIXCzZ?=
 =?us-ascii?Q?q4WHs8eObqCw6gMeEZkB0xvfgnxzKAaAb8Xz8pY4j6D1L041Yr2eaVeq4oHN?=
 =?us-ascii?Q?Pstr+vkAeYxijI8864vgrke93oeHRV97SHk8a6lXnIsYxGj2AtPQ8UkB7Nfy?=
 =?us-ascii?Q?vFlgX7+jRc+wFqT7W1MJAQpjz906WGnRbruWd4Uwbdqytj+WHzhMq3Pd6zPz?=
 =?us-ascii?Q?sounnttomNIIPcbCHo50qlOCNXDzjS+oa2siqIQK+w8Ktx31BITnIDRyIL8J?=
 =?us-ascii?Q?NIZaN2Gf2PyZMkfQiCfmjwgNf0psj8l9LEDhzy24?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3cd8a9-b697-435f-c392-08de27f29cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 05:06:49.8623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lma8SEq74xXY+JfMTxxATWBw9ENBqTePBjAINFitpykvSLi5JRggjRUvdZMhKCZpMw3IeyCzAsqAPFErT2msfcrF/P+RXHIse/paK1RsGBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7804
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:14:12 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


Hi Tien Fong,
________________________________
From: Chee, Tien Fong <tien.fong.chee@altera.com>
Sent: Wednesday, 19 November 2025 11:30 am
To: Maniyam, Dinesh <dinesh.maniyam@altera.com>; u-boot@lists.denx.de <u-bo=
ot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Michael Tr=
imarchi <michael@amarulasolutions.com>; Tom Rini <trini@konsulko.com>; davi=
d regan <dregan@broadcom.com>; Anand Gore <anand.gore@broadcom.com>; Willia=
m Zhang <william.zhang@broadcom.com>; Chee, Tien Fong <tien.fong.chee@alter=
a.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai <boon.khai=
.ng@altera.com>; Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH] nand: denali: enable SoC64 SPL NAND boot with proper K=
config selection


Hi Dinesh,

On 5/11/2025 1:19 am, dinesh.maniyam@altera.com<mailto:dinesh.maniyam@alter=
a.com> wrote:

From: Dinesh Maniyam <dinesh.maniyam@altera.com><mailto:dinesh.maniyam@alte=
ra.com>

Add SoC64-specific NAND SPL load support in denali_spl.c and update the
related Kconfig dependencies.

This patch introduces new helper functions to enable NAND boot support
for SoCFPGA SoC64 devices using the Denali NAND controller during the
SPL stage:

- nand_get_mtd(): safely retrieves the active NAND device instance.
- nand_spl_load_image(): supports image loading with page alignment and
  bad block skipping using nand_read_skip_bad().
- Includes nand_util.c for required NAND utility helpers.
- Wrapped under IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64) to limit
  inclusion to SoC64 targets.

In addition, the SPL_NAND_DENALI Kconfig entry has been updated to:
- Select required NAND SPL components (BASE, DRIVERS, IDENT, INIT, ECC).
- Exclude NAND_DENALI_SPARE_AREA_SKIP_BYTES from SoC64 builds, as SoC64
  NAND handling no longer uses this configuration.

These changes collectively enable functional NAND SPL image loading
support for SoCFPGA SoC64 devices with Denali NAND.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com><mailto:dinesh.man=
iyam@altera.com>
---
 drivers/mtd/nand/raw/Kconfig      |  7 ++-
 drivers/mtd/nand/raw/denali_spl.c | 73 +++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 754b99bf3eb..5e567ca4993 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -781,6 +781,11 @@ config SPL_NAND_CADENCE

 config SPL_NAND_DENALI
        bool "Support Denali NAND controller for SPL"
+       select SPL_NAND_BASE
+       select SPL_NAND_DRIVERS
+       select SPL_NAND_IDENT
+       select SPL_NAND_INIT
+       select SPL_NAND_ECC


Are these strictly required for all Denali users?
If these are only needed for SoC64, it would be better to move them into:

arch/arm/Kconfig under SOCFPGA / SOC64, or the SoC64 defconfig

Will move into SoC64 defconfig.



        depends on SPL_NAND_SUPPORT
        help
          This is a small implementation of the Denali NAND controller
@@ -788,7 +793,7 @@ config SPL_NAND_DENALI

 config NAND_DENALI_SPARE_AREA_SKIP_BYTES
        int "Number of bytes skipped in OOB area"
-       depends on SPL_NAND_DENALI
+       depends on SPL_NAND_DENALI && !TARGET_SOCFPGA_SOC64


This should not be added here in the common Kconfig.
If SoC64 does not require this option, simply disable it in:

SoC64 defconfig, or arch/arm/Kconfig under SOCFPGA


The common Denali code should not embed SoCFPGA-specific constraints.

Noted. Will handle it in SoC64 defconfig.


        range 0 63
        help
          This option specifies the number of bytes to skip from the beginn=
ing
diff --git a/drivers/mtd/nand/raw/denali_spl.c b/drivers/mtd/nand/raw/denal=
i_spl.c
index b1e2c9d8161..78cdab51a5a 100644
--- a/drivers/mtd/nand/raw/denali_spl.c
+++ b/drivers/mtd/nand/raw/denali_spl.c
@@ -5,13 +5,84 @@
  */

 #include <config.h>
+#include <hang.h>
 #include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <nand.h>
+#include <system-constants.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 #include <linux/mtd/rawnand.h>
 #include "denali.h"

+/* Only compile this code for SoCFPGA SoC64 targets */
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)


Cannot add the platform specific change here in the common driver.

The Denali SPL driver is shared across platforms, so we should not add SoCF=
PGA-specific logic here.

The function:

int nand_spl_load_image(...)


should be moved to platform-specific code, e.g.:

arch/arm/mach-socfpga/misc_soc64.c


Similarly, helper functions such as:

nand_get_mtd()
nand_spl_load_image()
#include "nand_util.c"

Will move to platform specific code misc_soc64.c


+
+struct mtd_info *nand_get_mtd(void)
+{
+       struct mtd_info *mtd;
+
+       mtd =3D get_nand_dev_by_index(nand_curr_device);
+       if (!mtd)
+               hang();
+
+       return mtd;
+}
+
+int nand_spl_load_image(u32 offset, u32 len, void *dst)
+{
+       size_t count =3D len, actual =3D 0, page_align_overhead =3D 0;
+       u32 page_align_offset =3D 0;
+       u8 *page_buffer;
+       int err =3D 0;
+       struct mtd_info *mtd;
+
+       if (!len || !dst)
+               return -EINVAL;
+
+       mtd =3D nand_get_mtd();
+
+       if ((offset & (mtd->writesize - 1)) !=3D 0) {
+               page_buffer =3D malloc_cache_aligned(mtd->writesize);
+               if (!page_buffer) {
+                       debug("Error: allocating buffer\n");
+                       return -ENOMEM;
+               }
+
+               page_align_overhead =3D offset % mtd->writesize;
+               page_align_offset =3D (offset / mtd->writesize) * mtd->writ=
esize;
+               count =3D mtd->writesize;
+
+               err =3D nand_read_skip_bad(mtd, page_align_offset, &count,
+                                        &actual, mtd->size, page_buffer);
+
+               if (err)
+                       return err;
+
+               count -=3D page_align_overhead;
+               count =3D min((size_t)len, count);
+               memcpy(dst, page_buffer + page_align_overhead, count);
+               free(page_buffer);
+
+               len -=3D count;
+               if (!len)
+                       return err;
+
+               offset +=3D count;
+               dst +=3D count;
+               count =3D len;
+       }
+
+       return nand_read_skip_bad(mtd, offset, &count, &actual, mtd->size, =
dst);
+}
+
+void nand_deselect(void) {}
+#include "nand_util.c"
+
+#else
+
 #define DENALI_MAP01           (1 << 26)       /* read/write pages in PIO =
*/
 #define DENALI_MAP10           (2 << 26)       /* high-level control plane=
 */

@@ -240,3 +311,5 @@ unsigned int nand_page_size(void)
 }

 void nand_deselect(void) {}
+#endif
+

Thanks.

Tien Fong

Thanks.

Dinesh
