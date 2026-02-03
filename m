Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD6E7FDCF
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EDF78409A;
	Tue,  3 Feb 2026 12:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nmFkcizU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A84840AA; Tue,  3 Feb 2026 12:53:58 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546108405A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFr34tZaEgFe4n+Ma94LibZY8UhK3bBZiRUNR6rv9+PXe3hRRya0c7WNbOk/FziM5MT1F92BdOmrHNOak2x5K+PZVfJjcWeIQSrMipdlOHpHpe7iheqbQi7GcZTWET6s0R3KtgvDsgQL0vTn/UK8wOwJU9uTYBRYd2ENWqqcA23OQssazIceZMO8gmFNc0kub719OMUjyqw7kVjiL1niYj8jKoGjGVRDitLOfXjRwektzGAqzAADLkUZXkXn0Vou+nwGLk4RlGeKXH/zkKtYgrTnT6d/LhxMbnhguUI7wAx2iPr93sS7TaPyi2xhAp+97FQ0+OSS2b63dx5W4cOvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJkT8jpAuCC+QObuhevfgldgS9oO4ajrUv6K44f9xVw=;
 b=NtCnT8NANaE5obp+nCKYIQmZbx0VnQejmrseT4Mt8hKrpvDh3HOZ3Y49F+d1AcT2e/dL4X3rxOHvvFpoD6hvA46rsIrnPOMwv6xf+5RZFDPxdUjoj4YQdEFaz3TFc28GvjEskmxvzi5/KuFXNpQdlJxnwZmwzJ6D+Dv8Oz58W2hWZhQDKOoNkvvDSbZ/XiTkgiUAWb5gCRTnAOMXnQhjY+y7imR/jRUNc+36fNQ183pSQP6xR1W7shbqpNohoKrjFS0zdMUcLXPXMD6wXlep5cRWBDG6KP4HQggMNLVkPz+EUjBGenItXiXqZTfJ5TEwEFv+MOqAFehUZSI/lAguOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJkT8jpAuCC+QObuhevfgldgS9oO4ajrUv6K44f9xVw=;
 b=nmFkcizUxHuK1Di08utQ0HvzjZEf1qhUP92GIntCem2TTBLU/mCuFySHyZOh0926x15GdSf3da3eYkU7srKG79RIesaGTQrAb7tH6fQgZc7JJwB+/UEkY+bBnBycxzwNFsYurdYVLjQyqlJjt9m+qSOTdSk7aCfRywsqLgq7isz3xEMbNTbs5sQDlrswUXjbNV+2U55duF8TBGlZXjVoXyM11Ik6S5Y12cwSTBtoFU3wMsDH+t4CjQIfQOMznqACZ0NvAiw9gL9CQTkWKIu4PbYPN4JMlLOhsT9zhlU7JsY7NS7Bpgq9+j5xa66ZoNI2OLTqrE1Yl07xcy00YQtYyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:53:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:53:54 +0000
Date: Tue, 3 Feb 2026 19:55:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yao Zi <me@ziyao.cc>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] Code improvements and argument checks for mmc dev
 subcommand
Message-ID: <aYHiNrWqCSwzIcBy@shlinux89>
References: <20260130180353.42205-1-me@ziyao.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130180353.42205-1-me@ziyao.cc>
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0110177f-2df4-4bbd-2b4d-08de631ae7e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+G+fL5WTccgqWhPrcok5heYEQlN3RKHtFh8a8ABui6WP8tNOKZy2tXvkF2Pm?=
 =?us-ascii?Q?ekTve4UfGQuf2qcFMSKdpG4ugt7p5EkOjZf38PYaVr25ffWTUaVwBVbZ4fZ1?=
 =?us-ascii?Q?yVrsEK7GcwA+cYiuLPCyvIjCv1P7XUnAr0teDVaJLGSaWVYqUXubID1SpEDb?=
 =?us-ascii?Q?8IdJsHh+jsMnSrApe8VdBRnq/yRIllkEmtQ49RA/ZFghqObRjkdF4JfqpoZs?=
 =?us-ascii?Q?sXkO+2tt6P2eSJqBep5IVQeJLST+e43kQ3tBnY6w4+4uCLpY08dZqH/iM0He?=
 =?us-ascii?Q?5DV4kf8nBgs7fhiiQ1Z+aWI0f86J7Z9kaGflmzPrara9YKDwaaKUxS2pnDvj?=
 =?us-ascii?Q?oleutu9VVh1kfol4QXr9++jhNzTPaA38metJeeyFstQ+2G2IvZP2ZFWveEJ4?=
 =?us-ascii?Q?z4sSOX7CIkILLhk3+9kiWSmgZ9sxVwv6Ceg41irZusis41bmilnX4+DOxR6R?=
 =?us-ascii?Q?g/wzW5i4oyjA/gwRqZvB2mJO2NMh4nvJh1o0RiBThd2HK4ORnkDLcQbULyT5?=
 =?us-ascii?Q?EwHEo4t7Ly0II1BSxN9h1QAa6nmMevrTiiUm7jEC9CfE99TONOtqiWzoEBW6?=
 =?us-ascii?Q?5BVNA/b0iIDmI8TM25HpaUAVgH6b2dntRXA5RQbX8lCRgUMTDihKBURDOgT1?=
 =?us-ascii?Q?AAG4fHW9IpE19F46Sfs4PfVluZGcUdhVQi3DFqQ6Itil+fI+9GloMpl8oCkZ?=
 =?us-ascii?Q?rBD2lDFWfAn8L1BU5EK7Mi2TyF3yqmX1Rmg2fLocc92ktFRCdTZg95XKdq50?=
 =?us-ascii?Q?SQSuRquojoWkH4fh0VWBKHBrKxVeuWPfbbogOSNpt6poIlMSs2nWPa80N7yp?=
 =?us-ascii?Q?DX/xyzxmtLEvAXV6pCcB6U+VnhOkgiVStFqgj3DQYEwSgFmCbznvSAvtM1Oe?=
 =?us-ascii?Q?OKMxUi1qpE95A5D1lBrjNAw5ue71e/i2V0PZr4hF4EkxcdpzwFo5EoJcTELW?=
 =?us-ascii?Q?Y5FGVwcIgnj2muwxx5lbBeGOvvcSDkK4I6jcsh/xbg282yeoN+FkHlAGw0TS?=
 =?us-ascii?Q?l+PyH7JeoKCpl+PsTcQex6q6WEcCa0k40gjMs2wuls9zaWOXbCRnuqQTM8Qd?=
 =?us-ascii?Q?WQ0NddGb2QZqF7NZbe7hBk26xTlJ06LjJmwqwF+0wjx5s1gX5QFaM72jnoxv?=
 =?us-ascii?Q?fvbKem8cbNnJB1/P45if/hndKpylLGga9FlTBa1RaoRKDsv7L3krRczxH20n?=
 =?us-ascii?Q?XQ5sJVYNW6h8WVxpCKWsItImSHzOCUhNsDnEBUSioDRmS3VaCuzEGYTzK9b6?=
 =?us-ascii?Q?ygKrAFBJMviX4J4CIvF7/IevXKA4t+Y9uLVxMfeWtKhA7K3O5v7eR/lH2mic?=
 =?us-ascii?Q?mlyPlNPl2m3I3ySGZryaeCZ5cjOldLvz63hbh6NeUcEWvL7wfWJkh5t3Pll+?=
 =?us-ascii?Q?PKAydFLvQsLVwojOiypIJQlCr/NavTNuKKzpSHMi2PMNFry8w1sCHptlkkyv?=
 =?us-ascii?Q?J7KsfXHFg3hc0XFripLoduVS8C3z7BkwZco1KViOyPKcDCA7ihbPEcOlXAVS?=
 =?us-ascii?Q?L9PDi854aJ5y9ysBiE4RDVoj48700hkNy9JxzeCt4fEEvrZCLQ7MtFwLvn0u?=
 =?us-ascii?Q?1jMKILWa4eaM+ox9K1jCCZOiFzao/tgTEGBTtiQRKShLBZnh1TO23KoYc99T?=
 =?us-ascii?Q?QIyZ9oXik9JovBJ+pq94yww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rFqBQlDSKLnrYnHFPCSKYK1/7lFYZJ2LODLYifD4La4hxYg+dzTTdkjCwygz?=
 =?us-ascii?Q?i1UDbJx40w2BqCYds566bFlWb5UWK/cU7k67We+8xcGgD+ZBhFJvJJFIt+ff?=
 =?us-ascii?Q?gxoiFiMJwcJ8+0HyI+UbN8qmN1zIHfP5diF5S1HkAR+Q4DlbqyL/Xc6dbLTe?=
 =?us-ascii?Q?tjQkpdyLmoo8B7VRvpCYb8ibRJQ4GtfnWGI3vl9GfjZ+pqbGCIkOQpFlic63?=
 =?us-ascii?Q?7D684NzuyShx/rUBEmNuXct9onmbGqeCh/3Xl9QfVX4GGX5J0ACqrURevJ2v?=
 =?us-ascii?Q?7K7naRqhRZjvf/XoQ6GzTcHJZJ29Exg6RPg53BfNzoUsiZw6PkGTZO42EgKH?=
 =?us-ascii?Q?MsANix+CIQIQKjwwKgSjGczCg0hNPupbCpwihxUtoYEackFnRKH7e7445uQc?=
 =?us-ascii?Q?nsBcWqJPBqBht8M4AXxdks7HFaRF6BgEMaMkCePOBfNCvpRnMS2HWJtMajI5?=
 =?us-ascii?Q?zBtkY/IPdBlq/Ei6RPax2THtjdJbf9wUxRNyNrEoksUpD2dKV2G4zc7/Av3S?=
 =?us-ascii?Q?sD4e+gqbkM6PU81w+FWzjtZWfZXrDooaORp4CVh65TjEccx7jdGe+IJ73JJq?=
 =?us-ascii?Q?sJDkOBwdv7r6vWOOaro2r3L0RFLFvDACTI9iPD+gZFrlWIJ35AOE5WFpfrSB?=
 =?us-ascii?Q?1/YcVl29fZojY/zx5aJ/xI+Toph31OJGp3Hwu8P3hSSnA6U/EE6A3m7uiKS3?=
 =?us-ascii?Q?6jgm26Z6odMWHKKhwuoA4tIfNNrfwyfPfvvOl3XUWW5cJUx7+xrxvS/rKlaK?=
 =?us-ascii?Q?nosxR8nXa3I+M/S1ZZ3fGFS909VGNepuxQOxpoyemeXZ8NrUfTzGZhmApRJi?=
 =?us-ascii?Q?FIxo1Lt4g0/O+ChmRFUQaSGQPbbyjQ9n280qk427q72sNkZjPxsiW1imXnTg?=
 =?us-ascii?Q?geXIIyLJoxf8xixqmG5XFvDuZIVBPGYpKi2R8Wr9ZZP0xlPc/ZuXrVQia8EB?=
 =?us-ascii?Q?ZJA9ssKLd97WmdMMYN+QvaXnyl66EAlMtWUIWzFHm1H4gWWnkdZdYEqBRICj?=
 =?us-ascii?Q?SoMkQ+Dzl+GJ2hvWRXN6pvysibw3rYHdRXMOmdHnE/q1yDmndNKuR+7MAZOs?=
 =?us-ascii?Q?FFCimJYSTBwyXoFt+9yf5XcdXnaQNRFZGUYTiCUualkMQR1axeqkZeiE+d+Y?=
 =?us-ascii?Q?eGJ2atOWYxnlagslXVr25Wrf5TBEiWeiS0nfUEGB0WvmMszU7KGrRGNV0KkL?=
 =?us-ascii?Q?UiNjUGOC+Qsac6ZRLObIHw/osx/Fq/qJCz/R4Tn1sfksionLTmx73Jec95Av?=
 =?us-ascii?Q?EvYUa9s8BperdDsPcQBPbRQvG1WcaH5WKjYFFimb5/bhASuLIwwEpMl/8eR5?=
 =?us-ascii?Q?5BnG01xTLWNaUxfs7q2BfBoR22kTRKwVyOWUF6j3phxJdmDz1nbJ/cPKgw1A?=
 =?us-ascii?Q?uJWCaGAJEXJvT2xRxzDIPb39z1M5/ySdCj+I7XQZO7D0la8ADpb2ouVxS7rk?=
 =?us-ascii?Q?ra8dJmr1OhKQTVkNxGGLw1hNBXF3vv1vW4ws65Eahlgrixnc6RP+VQtDQyZP?=
 =?us-ascii?Q?EKHmlEZ2yqqkQd/H/kqMj6C8pXdEhbsCCratPexothlqt5UAcQKaDvXl6bCr?=
 =?us-ascii?Q?s7jbjDvQi6e9azdOpo9TzPbByt5SkbpKY+m2G0WbZ8yrnTVqc3lZzrSPLNmq?=
 =?us-ascii?Q?DDiH14IrTnSmbS9WLSCBaCZJ/aV1V+6SpdpLbFUEglWOaSOHPVLgQgYzxBUU?=
 =?us-ascii?Q?qkSWy5AhHwq7ubAvjmsO4CCxkCCJ1gKJDCTS8ZWbmZCxdYIcCJ2/jI0DTgUt?=
 =?us-ascii?Q?opHHedWnAg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0110177f-2df4-4bbd-2b4d-08de631ae7e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:53:54.5688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEp7BfJ2kS+wGAisuFaV0nEO8xrk+4gXk5S+Ij+XYvABKJ11N3zGIjHHYJGxIuaQGNXVoJU+zkF5LwIiBAtzmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
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

On Fri, Jan 30, 2026 at 06:03:50PM +0000, Yao Zi wrote:
>This series reduces code duplication by utilizing fallthrough, then adds
>extra checks for arguments of mmc dev to ensure they're valid numbers,
>preventing unexpected behavior.
>
>The last patch replaces an integer literal returned in do_mmc_dev() by
>its corresponding symbolic constant, CMD_RET_FAILURE to improve
>readability, no function change is involved.
>
>Yao Zi (3):
>  cmd: mmc: Simplify dev subcommand handling
>  cmd: mmc: Check whether arguments are valid numbers in dev subcommand
>  cmd: mmc: Return symbolic value when part switching fails in mmc dev
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
