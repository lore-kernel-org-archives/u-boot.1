Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F2EC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 06:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E4DD60603;
	Wed, 26 Aug 2026 06:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XRcAPmoXJozt; Wed, 26 Aug 2026 06:33:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787725998;
	bh=erDd/BViDZmNrBfvh6FUoKt4PsN5DgS+RiFKBfU1fq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CHXzybPJxnRR4Jf2rh7bvovUGoo3UPsPObb5JphumEmNZFsSgZyLVYH9SZROnQClb
	 vuuZyBagyaIIyf1fRWyFn1amPRwIpKQLqueh3dngHkgPZBunak4ZEzlmuCfCGmErHp
	 QfVmWSZ6BuayF+v+wFQIu3pE8GbIKpsNr4j+rmWprxWr5LW4c+614F1WUUw3DrxmkB
	 3bDbjLw+j63M6AnVuqxI8GjdflfuVgadW2+43cISJuP/WXfpynwDmIby+bY3R46ga8
	 bdXN8K+Zu7E+6t4o2uBFzz4neT2L1p0GuNhDnOkbAtG0WrkJKOV5hyOdor6kv83ATW
	 M+4p3hgrlWAGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BA1A605FC;
	Wed, 26 Aug 2026 06:33:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7760D23E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D89D80A80
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCqUTVEXaUNC for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 06:33:15 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=I/gE91Rk
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9292C80602
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwCzByRVI7tAvM8+oiOmb2qRL6jc6X74kUfKP+6fDiPru77chfc94+J4olOAuBMeaF5F0UBzy0/liUzwHMxTgXNJcE9ppA5iQvhXC7wU0CI9hah36Wq+/zA/RA+IzUkvT3MaVC5cdloPe0e8FzyY2Pr3jX9acBpVgszOD1nNnyedZX3akZK0nd82zQrPZJSQgVnwiokfEY7t2BL7bRd5S5mN2SNkmL3qBVq89+EYpYrfZwvz9Zpp7seLcc7lkxNwi3kgFfZPQikppMOIi6s3koDip+pHGyAIFnps4oyUumqYeRxnA//oKO1NlkKEe80bPjlOtIPuOtja3GvDAt3tQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erDd/BViDZmNrBfvh6FUoKt4PsN5DgS+RiFKBfU1fq8=;
 b=ab4bdkL4G7VHLGbP86JnKiH0p4q37Pg8QBKnFPogy4JrJ62ycJR7A4QrNfv88dG1YJNiaBKQIC76azQEuvFfBwhsHnkLzEr78CRBvMbn51W1S5rXCWNmqLGAS6NbTp3WUQ81G2hefbGaPr9B7G6asZj1yb5WZuVbPMlxELUpRpOEq7YWhFgFQD5vd0WkQ0Da2ZTZq7NZddVBD46+n0fOCOGLpWuq6+n4k5snNlK96OxYrwDcolwiFjPMCKOrAzk9I70vZjI6ElgWlGgdxz8NC1ZLFg2r+PWS5EqP6jsMBu0RVxEo6fs9XHnhJJRC6t8XT5cUdmP+uPaUEst9m0i+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erDd/BViDZmNrBfvh6FUoKt4PsN5DgS+RiFKBfU1fq8=;
 b=I/gE91RkePOchrJ0Cmr78mr55yyATOERAFqyqObV6INuaa6ID+ggbP7H+/LLM79DCFWk9yDMsOTU3q8639GOTqR9tnZlqvmxwvS0Ex7g6yOEE+UOkpS2yLaFgKbnjb0cf82Ep09+m2rZ9qnOKfO8Db6o43ewk51UbfPdSXF3dtr9dMtAB6MqGrlvxGnF8oFc82jBjTyBDAzwkiLK5Nx0l40Ihh3TKUk62+1VeLTO5Sa0TRNkrOufVvfdSOM4fwPthQUdJm6lcuFEgmpVjHTqTYOGJhWqNhULVoJQntX0RzeyYWdpitMuhRM7rrTt6GINS3orwMoZLvHtgSTT9C0wwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:33:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:33:09 +0000
Date: Wed, 26 Aug 2026 14:30:45 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v6 02/13] mmc: arm_pl180: Configure Ux500 signal direction
Message-ID: <ao6IFST6eSqIYdA7@nxa18884-linux-1.ap.freescale.net>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-2-61446b6c289e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-ux500-external-sdcard-v6-2-61446b6c289e@kernel.org>
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cd5e1c-cfd7-4538-0d3a-08df033be525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|1800799024|376014|10067099003|3023799007|10063799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: +rjXZo2dX7MLagUsNRRaS7JMuBThM/BUnsNZYAhV/7rG4k/HJrc3WY5Cf0J22zMXB1uDhq2VhemcFY/9En7oUjlnYrG4Zq5f7P4pYDq0/Vl0rHvGp30CsEymk47q7C07ircHvXkFVmWFlPoiGiBh9kdeBhmC17W9Z52nhGg5F/fjj3BVc3IoWJTQ2WXhlUBqB7ep+Nnd4PN3K/27HYSfFQIhXgDgjoGhT8XwqKnGEj8AEfG7//TPt+v0tosZc7y3aEDpqUJTe8Fq9kH+HWS0wwYMzWNzHryIXRpfVh7ySeSLXWd99upl362G3Q5xW3P3gcS/eTbR4W0NcmOZxVAvXr5SH7VB/3k966R2VD5CJEbamMWXrCdeQ3DXSsEeTxQ9AcWTBy8WS8wKzSdmzDctJ8CmGtb6EJqL/G13xjlj2cbec2r/QEtyTaIZojQIHFloaLmybh9lxOQMoMDIzoXoK6nRquG59ovuDkjv3ZaWH+ZHv/4UKiUCuJm6dKYBitdahDwx0HhCWkCQjtzVmYFHUij15g6xMSztwVXqrwCYer/DYQfi+Rei89PYchVh+jFmA7CEBYDblBt8YUdPfDvsnl+fJ/GLwNZg3AsIYJeYbaRO6WhFeTYoem3Yz6z/mCXf5HBSEYoRTI2xBIlFGiyyYsAE0Edl3DcUKF/n4OmVR8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(10063799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2oy8hynTCeCPfQK8h4LAPLGPKCRFOABag8vRCn46RPMLZCvFQNgWajPJBvVn?=
 =?us-ascii?Q?QI34Pu5/9JcEObGzLXtDgwguIQmswekyqpU33T0QYcUpUtjzvTF5bR919aW+?=
 =?us-ascii?Q?dIFKwDCsX2UNuikL9IyGX4pSz14PpvT33iUtrNOH+I1e+ZMFf7MQqvjhW7fe?=
 =?us-ascii?Q?bFQjgie78JjCdAZA56nP38Hs8vJJi+RYEGXOIOVYaVKE+RY5YwQOoCHrXLoA?=
 =?us-ascii?Q?9ZD8Eop/bmNvJ9n19vgyD91NFjan6puHKUXBuks9vNXDxcSqKWVDEZfnuOeE?=
 =?us-ascii?Q?UPMdBrAzIx7tRx4qvlTQZZMTrmURpVgZpDsTg328390OBGsivrZ7nBUbv9KF?=
 =?us-ascii?Q?AGKViXPNI+RrbTaUjGV5Mid/ENiCfmL/fStclQ3xCgLeTmTlL4qMfaeYrWtf?=
 =?us-ascii?Q?nspAvK7mhBgAXz7tQ6ah/cpGqeNjH+Ml+8i2PsMaEc2mxb6dhSf5bOOLisgv?=
 =?us-ascii?Q?aZ13ijD3oYFU2wqZJiqFA2mgnyAoH+j/tBRhLurotwRwzGsKcO/tYBymbmsq?=
 =?us-ascii?Q?pC9C4LXFS+Nq3Z/pBfM9k21RxD5JtvnLpNbvdpSsJEHVpjP+EuJZHz0FA6P0?=
 =?us-ascii?Q?Igx/J1g5Ab1YZRgu1EiGRbPA4fwqaYBLZSz7puRLywN2pbKmNv7quICwnkAm?=
 =?us-ascii?Q?EBSp7fS8+AmlIF/p/Vr9OEhzF+o8Mn51m4FK6x/BGIs1QjzpHuqUGP0V1/x2?=
 =?us-ascii?Q?ld0Rqonl5T1eKC86GdaPGFS8Z0KLwgF+0vI0bOuwq/mJUp/1GBCLNilWDNy+?=
 =?us-ascii?Q?S8OH9aTx7AXEfhxzGUUusjVk8ZcuzHXcA9bT89PDl5YqLoQyIg2Vh1l/QBp+?=
 =?us-ascii?Q?X4zSBrY+TpUtkKKJldn0MA6k9R8+sQV2EpArql50OoLjuez2MIJURoy8kyuT?=
 =?us-ascii?Q?5bFmqqyLUKk2yJJdx/b7Xc8xawAVbFs1XZzGM6RhEyaRH0sKqpgZ8Vabf3fc?=
 =?us-ascii?Q?AxJUzUfa3RijaXJW+jtJzG1sqXZE4UeDaK/d9eaKWJW2rrDTowCLSbWEPhdm?=
 =?us-ascii?Q?XBrd0/glRbExItDV0Kf5cO2zIDfuH63hFIkrY40Zhb70z08AWKhPEHpPZc10?=
 =?us-ascii?Q?0YJ9RAdT9/I0EJVLZqII7x1obgc+6Pxiz5BgnSaqwovc4fCh/s6sFyNeTSJk?=
 =?us-ascii?Q?UIJ5syFp6IYVdVx9jljTLV++cbgJThoN9GD679rwPUjjdyfxZ1Y7U/7H10nI?=
 =?us-ascii?Q?lXe3zJmbnpgri4jzk0mBZwTZHO68959wAtXZNkYnp25yh/9oonW/BWzDPaDr?=
 =?us-ascii?Q?sXyP9y2VYiZcbYvK45Cpnfv32+0CjGmP9M3VPAX48Pd/OBDDUekxxvE7Lq8X?=
 =?us-ascii?Q?nHff/qLQX63227mPiO6pkyO52+qul71olsXGHyFmexGG5jH1BMed/wmjt2sg?=
 =?us-ascii?Q?yMjwZYY2Bes8n8VouRZd/tqW1gSHtKQCF6qrZPsNurrO4oCTv/vS+TUqR1zs?=
 =?us-ascii?Q?FR+ffgc9qcrXdpEvTUlQtkIIZQhGAwSNQmLNiFMCWftWUPE3UiCRuIUVjDGV?=
 =?us-ascii?Q?txfXnM09KQCxD9pSU1+MPOh5EG8Q8d/Dtb3SWv2/8u0PwxK7t8gjU+V8rUsH?=
 =?us-ascii?Q?VZFJvQBEoVCqc9ydWVyAd0OdQHK7skQtInAhm7CUPfiyFHIW2DAJfRnyqkUz?=
 =?us-ascii?Q?tui4q0dBbimg7EE5x3DxL/HPwDwvh7Pf9Kz1oIeYlbqzd0ZKH8/UbfIo+jv5?=
 =?us-ascii?Q?Mt4y0DsRtSW6zNRtIZN2/OhfvlTm/p/f6glqOmhMphna9ILm/cQ72TOeE//N?=
 =?us-ascii?Q?uAxMxtB1HpKVkoNm6671uFcFRqfCyes9fEzvYodLjQkqBgHIq7yY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cd5e1c-cfd7-4538-0d3a-08df033be525
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:33:09.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fC04RzInGQXSROGRkaHeBSys3JiNDdbOVJ9dfgqk08ocLtzcP2GF7Vwr9UmhoRUFRfN27FNFiY3cmtC5rYsLdd3hfZ336YpvcUftBH5bj+RD6oNxyQxeLGd7HfWtkd9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 25, 2026 at 09:04:02PM +0200, Linus Walleij wrote:
>The Ux500 MMCI variant can control external level-shifter signal
>directions through the power register. Parse the standard ST MMCI
>device tree properties and set the corresponding direction and
>feedback-clock bits.
>
>This is required by the external SD card slot on Samsung Janice, where
>commands cannot reach the card unless the direction controls are set.
>
>Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
