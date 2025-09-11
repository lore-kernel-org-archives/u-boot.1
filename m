Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8056CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9A983236;
	Thu, 11 Sep 2025 07:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WVGQLkAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA1D8329C; Thu, 11 Sep 2025 07:21:21 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA0C28319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcMUQVFjolpTXwTqVZ24OWa+9FMeKuN13JbFUSnmaNHCg+pXiHSNgkxFEcw9iIdg6pAzgtfnhs8bNOJpJiGeDN8rjZUb5uCbkWitVP5OEo0VV5pEYJc8MjuoULQ3YDjnBk0liPAANDNnQTFyDt85zio0WRTLpwYimny7R7v/j7EAjeRTRui9fwu7P/gmckVvT8OhxdUnw8QeJuEmDBRJrJbFuJTf18gYEpYVshMCyHTdmjPoyGT/P7fb4jDyhu85lOiefiYJ3GM7bIk6rzbELKZGMI5G6AshUUdPikUcMrC5yx+Fut9Yi80mulCPSxMeFQfQaWYh3qSLxtd5V9KKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrA7ImNbHRFkgSjajVS0f73XsAwmXGLpnlfCBMTTL7o=;
 b=S3O2k35Ncb2YIN+gIdFwUaVQrVnz55U/zTmxI8JbJLj32F/Kgiv8tqkdzJEfR72bItUog/WkS3M7jc4jpt2xh3zkFC4rZ14GbCCm2Ld9Ek106KIOsxWD7Rsal8mJh3CSrFUcYADqRW1Re5RIeke+jHsEKUdIVGR9Dd/eU9CG9sKXfFRUzLn/eZRIeq2HpE2asM2KIRb7UciwwvhPo9R/yOdtHmhbZBDNHNFxudDTwfGmpQ14QZqrrnJqFMd8isyWsT7hKV1QFeTZcb8gIwPLLKKH2UkYMVy4fL67+g4jhpLVhHWZ2YwYZzEy8MWgKSXD9W3PTreWMvHXgac2/YZfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrA7ImNbHRFkgSjajVS0f73XsAwmXGLpnlfCBMTTL7o=;
 b=WVGQLkAozSqQthFPR7Z/KTOPN60/pt0PSLKQSJjlauQvb/qfIlULqKLXl4E1X+oLsAH0AK3lnvPKx/JDR5paoRiUg2CJDx+8hZRyaIl0gsRLx9oPyoGvQ6cnoI9GQyK3Yz/+RBt6LP+0eOS9SA3NlvYMpDOiyvV7Cc3MMEFQt5lLNMs1KydHv/GejYit6QMsqaZ4XgSxdjJFlIfKfXGHrmefALECXRI0M/KoipAjUTEM3oin428TBE7E8IQSclRA96WZiNDkyyTBwOzMDTF3edrN9qvy9EZ9gLyk2Wk3Nh6fYD8ar96XBExAF8UVBFxdvojFBUEMDxpKbN1RkviySw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:21:16 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:21:16 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 0/2] Fix EMAC clock source selection
Date: Wed, 10 Sep 2025 22:21:10 -0700
Message-Id: <20250911052112.15383-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: d8710adc-6b29-46a1-2662-08ddf0f3083f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t1xw/4RNkKsTjQLhQq7W6OElCcUTlYBaxglixzSI0SzdxMt+rPwRa1sC3TKR?=
 =?us-ascii?Q?dIC/kbGE5C61sZ2E+W2gZTAzpPMeE30Uuxq3pAVAZDObXCe+wpQuR/1YoP8s?=
 =?us-ascii?Q?ERBbj6KGm6H1SBX4fDG8Nzqa3izqheGPAS9btQ+DYKThG2jf7f7OURK52K3A?=
 =?us-ascii?Q?Oumoi285PxQ+5n3vLSJx2gHf55pAebOGqxowRfj9dRCrcMUNBTpN1Eq+XRba?=
 =?us-ascii?Q?DvUUbc5tLks9WcxZsIv2G8CnAPoq+5b45/nKtjUxmul+bDhukIP/ITgSJAzj?=
 =?us-ascii?Q?dKyOG2vsDa64dViP7savtBk/PpLxQbauFDRBqexRnxc224NJmJf1aLFHBMHZ?=
 =?us-ascii?Q?4ms6Lq2ND2IBaA+QYnbzBPMv6AVMyGy+Z+GJzKQJT09HgzU70weo8OxMZy1m?=
 =?us-ascii?Q?YSuwFQFVnJ0qZN8RrTwqJ409No+c8omUzRQmhPY6jpM3GAgB3yHCGGF4S1KV?=
 =?us-ascii?Q?WPDOZx54BeRFnfavjWm7WX4anrhqbvNH+lmBdAoiLlwgW3+2wBZ+mB4rxKG5?=
 =?us-ascii?Q?7QAVH8w7PK1JzU09PEh/PLQBwjN9DDzyGUM+6qPP+ycnKrCdpd3JrHa1jZno?=
 =?us-ascii?Q?LZG/mS18xdaE6ocvFfVRT2zyW+ZWIEjJXl+mohpKoWpe94Uk9IFfFKOL2C53?=
 =?us-ascii?Q?M+1k4ky2VecNeBY6RSIS3yFhg++PK7JDLBKc6Mg926eymtcJZ0FCpULZx2b7?=
 =?us-ascii?Q?IHTcbIWIvZfaxGF1APjY+DwgHH/dByNrWprYJClFxdIX1CgZPALTfZdaj0pg?=
 =?us-ascii?Q?njFjvFLTWqhtOmiDZotC5CSLsYYVJ4XX81fhrOzb35i8XkR6RRL3IY/zI83n?=
 =?us-ascii?Q?+XgLwOWatKF7uALtAfzseQ8QZ04o/hl4Q06U8XQhNG052nOX71uR1qe0FCQF?=
 =?us-ascii?Q?Ds5iQkrWX01XNYHxgJYeytc234YKbmTIpZycaj3Kf3vbTLQnasDkNtpC73yP?=
 =?us-ascii?Q?9HG/OLbID8WqciBllJ6xvgLxEDxGxkxz1RxNpaSbVlFP1DHKYTqeP1ft9xKe?=
 =?us-ascii?Q?nw1fgznn9c46HzugP0+NnMmqrs05pDV66AvdkNb8bGe+hXVs5fWYlZAgyyP7?=
 =?us-ascii?Q?mzt3SlrNU7C25HvbzaWduuP+vJyaS6p0MghsacnSMOld9kzD7n1AQRO8/iid?=
 =?us-ascii?Q?/P2FAMmq37Q2nEJAe6Mt6dWUdLO0ivN4pIBzjeYQhNWRE3tJ13cuK8IcNu9q?=
 =?us-ascii?Q?PqUveUILYjtMra0MzPFx8bo7kBcSBUARuKMkC3mJBglsFK0pAi+daxf2mLe2?=
 =?us-ascii?Q?bAd6fBMFXoyXRbrU8X/jKuUlk+O3rlKk48qjMO6e8vx8VmX73Tq79qaxOtQH?=
 =?us-ascii?Q?WuqZGyd0Vu2FaxjTqZUeGYjtPpCVFBLF9LVz6yDYVEigzGsVsty3XY8toQwR?=
 =?us-ascii?Q?N/erMrgkvLdISlrRL+GkpehhO1vnRf2VHteS/LAQCYuUC9+8E7v8uziD3xVg?=
 =?us-ascii?Q?THZWrpYDLtw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzuu+GdX7V38bKEc2kaCaszOa18QPdTpZdMSNTtXQ+KAi813DebvKGi6k2ZH?=
 =?us-ascii?Q?wYm+5Glpc2cfa5FgXPK84Ovqf94rZ2VynBzX4mJFGps609ibWn4nVooIigS+?=
 =?us-ascii?Q?z0dKb1XffAXBGayYSgq0C4K+8GbOsRookxeIY3BpY0K8D0exZJgvbPgc0dbe?=
 =?us-ascii?Q?1211SvtlERCb4l00A58wJ2Z67svM1n5uyLYg3laT1aPQ4F6n8zCi3lzRCGcf?=
 =?us-ascii?Q?+gMe4IdEbDNIAeewyRqlrIoTrmo79b8e/NhahvBqjZplSdz2Rc7rW7MX5UCO?=
 =?us-ascii?Q?ANoStlOLPSmqvEsxvnSOk2lfGxsTze3Yz7uLQGCkJQkhnfGEcvht5bZWRhN1?=
 =?us-ascii?Q?T/ukXBljyZpcnmT1DVuH3s2Yty79bI8QSucIZ1vWDQYiMXsfeXN+y20/o7uS?=
 =?us-ascii?Q?95DadaENGDokdSatXkwwtmo2Qk6IZaYc9sx9XMrlPdeGFy1dYWAaP64uW6k0?=
 =?us-ascii?Q?d6/iulF9M5dGqadQWpIcnBPONzJOTyACrGqlWzhABGoubz3OCESVCLVHV+Qe?=
 =?us-ascii?Q?gIn7cXmY40NY8e5yCeFvKi6312GmNmcBzTizv9mMJL+F72k5sMrcl0E2++2D?=
 =?us-ascii?Q?ce07l2mwL6XJTBmcjhBIJrFjnQ/aLzqqhmZlqrHftxv0TZPFs5s2ma2f9jYO?=
 =?us-ascii?Q?T9cfSGhwy4a+Siel9OafeSSYLC45fNFBROpnVZKGOk/ySBqHtSPC3Zkg29oL?=
 =?us-ascii?Q?Mzk6Q9QpbAN+GNjEEwZo4ZM9VKMa2b39lYyVeXujMUOXUWzPWf0PYxH6etcu?=
 =?us-ascii?Q?O/oZ4SExew/9l8HOe3Fn6BvM3KC+VdtZcUkR1vGmd96ImRywn48wfyethpsJ?=
 =?us-ascii?Q?bPHyAwiyo3UlDp5UheBHd5Arkc3tGAYAQiuDpHo5HtcJIiVtcP6MPGCx6n/6?=
 =?us-ascii?Q?A2pVJ+1uCtnfeIlkYaEmyp2a5tpnBOl2+2HarhKIeWu0J/voTTwh70gsr4w0?=
 =?us-ascii?Q?EhQP206j0CwK7B9ytqx4v2GlY9XYNRT81PExF5FcUiYiOqPon6Doek1jdDi/?=
 =?us-ascii?Q?yXHM5OTkeawk9fCXgQPLeVkWEQF4YQ/UkLR2py2ndyXmeZa7qlC6ImzgdHEQ?=
 =?us-ascii?Q?LPGZ+GuwxgPBlyRMygYtlH09r528GZslqSFP9F/esdVg+PPvzD3Zgv4+sdvW?=
 =?us-ascii?Q?vNLd0szmI66ES3PlIe0m4HGnSgAFjLBdljltG0UJV/ZxyOCxXLOh9ndF0iZo?=
 =?us-ascii?Q?VydTFkG3spIRMIAmR408NGmlVb1emPej3J+bewDYEfTJd6mr+KSbc5NhncIF?=
 =?us-ascii?Q?WLUrLS6iKaD1FEKRZVDaFT1MhuMbFrJnhBWtXhFdrhcYt3gQH4zLKteP7per?=
 =?us-ascii?Q?psTVidLcwORWFggjHW7sGgmT4gol0WytLn8u89+OYgbjv97O33sjPA8C2j7g?=
 =?us-ascii?Q?qj0oq0kX0p1N9aDjlN5hXeOf4mJXDFS2+Fu50+BSa3PWUyvgQoUSVM6lg+F7?=
 =?us-ascii?Q?AezM1p7y8z+7hx7LOgDw5+RefZu2+s9GB9c91Cx72VYFmZIYzC1EhlL2cB/J?=
 =?us-ascii?Q?PQYT4JsM3HenBoOvZMOupGzBeiUmoWkhoyH7QP0akyaop5KPGcB7t3925zak?=
 =?us-ascii?Q?H0uByRFb0tRkrgJxJtCzGfa0LXtBrGCks1RuLLXvmJ7a9RtiSRZFBeVVPKOp?=
 =?us-ascii?Q?elP1UPG7AmFf6+e55j6DNm8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8710adc-6b29-46a1-2662-08ddf0f3083f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:21:16.4581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5rsdyM/GSa/3xZlJOElAfcQqz+LAbcmLT0cIEKqPwwfuN/TePyBgNmupmcRrV9vgaLNmlk2A4GD4AEZj5K4o3hdzDy96XOi/Sl5Bk+S2GdVWFSwV/YXNu6pt4ATzz7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

Changes in v3:
- Revert license change
- Separate fixing mask issue and using FIELD_GET() macro
 into two different patches

Naresh Kumar Ravulapalli (2):
  drivers: clk: agilex: Fix EMAC clock source selection
  drivers: clk: agilex: Use FIELD_GET during EMAC clock selection

 drivers/clk/altera/clk-agilex.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.35.3

