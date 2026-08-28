Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E93C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A34280ED1;
	Fri, 28 Aug 2026 10:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k4Lrg8KU_nHp; Fri, 28 Aug 2026 10:50:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914221;
	bh=Whc1v39abiv3ZQte9+0aRMlR5xiwrTdl+7JiHlJpWiI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L3RQ6Lb/PHqpp/Tn8c5SFeooRiWnvUd/j4yT6M7dZHV1Wjsdg3ShucjIEgq1pWMSq
	 KN4hr6CjCCVWdjv7w/k8PC9PVz5ORUWc2nma6klY1DM2xXYnY3N9BztJfcX+HostL3
	 T21QKyu2VyILrt69fcEXgq/wAtSjqPJrF/vW75YBdpVg7OcVctufQDh9AAS+WS+AwQ
	 Da5WY2QX/MKiZ8v7c32tKzyYZR5WFPQcajlmDGMZ3YYTUIyIs48+xQteedpE62Nnwq
	 dq68ymdOKIkoFUzpn0X6KeYSrzyYjKcf36JUaLFrZ0EfrvDHUkwQjA4QgVf4Hwi8dy
	 Ln9qxfdRT9juA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5025780EB6;
	Fri, 28 Aug 2026 10:50:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67F4A334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59FB840834
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vxNQx1f5P57j for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:50:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=QSqkJ1HS
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A18044082B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUIjnvkUmTt2gN13lvwAW5puBlYCfbjrKCXoJwrHL6Owiin0cBckJpkzwRDAUUw8tg4JnL2WNpzrLYAInDGuCEgD1+173mPTL17R3qYi5vd2/60Ipe4qbASeYAoE9xZzTx9nKhS8IAJ5Y9fH8yuDgczr2DeFFb1aoQpdHqEX5SITXM5DSCMmuailEydCJDCUeoiQEHEuMWs+nO3jS8ZrFS8FIQsAM2zh9uh30i4vo7GS8Qd1SYdaRh9Zmk6wvbnP5FZfUBisIAr7of0i4m0bAFBwIaHWRoAEH2P74wbOzxTbzuLOY5puzwxAfb8fUQsdROdRkn6lH5KSPkrjEysM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Whc1v39abiv3ZQte9+0aRMlR5xiwrTdl+7JiHlJpWiI=;
 b=Wnz1BJHvN7thcBe39rxCvQXtDUkEw1igrROZYWQOx0I1dqWikQAJV4nCuEesSepB6H1gFGah8nA3rUag4EGVnxnkkDwLPnTSBYMGikmEJ3X/nvkbHR5qlpSHba8zYvfoC2j3vFFm+H/u83tghL4wl+rHOvDJOdJg9Hl0uTgUYDQ4Xjj9WQBcke7CClWp3/SYd8DkYzNlQy36rkJjv5m/pelrQWsA3i1kcp2fA3oZPJ7cpyFfDJx60XoLQ1dSkQ+GDrLWUvoydsOw9KqADDAkeiwKZwqOTkDXZD3xD8twZpnTQHuEmSogSNm9uSNhXnfKBYCivfe6spkhEImlp+sZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whc1v39abiv3ZQte9+0aRMlR5xiwrTdl+7JiHlJpWiI=;
 b=QSqkJ1HSl8Dr/ivf4hxDwHk6BugVyzRjlu3co4OhxZZc9jbobI8rCuU8Q2Af1u0dtIjfEIfw8Jt8MUAAHw+cKubpBqGLlafdVNUEXM8IzFHqVltgbou4sGz4m/DtX4UJONM6KfMlt3ifwWHu3nzOA42KDx6B8f5YewMeTLUSx+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 10:50:08 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:50:08 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/3] avb: start handling too small buffer for reading
 persistent values
Date: Fri, 28 Aug 2026 12:50:02 +0200
Message-ID: <20260828105005.200338-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBD2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b9) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAXPR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad93132-6efd-4aaf-bfe1-08df04f22060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: GfI38qIzzP5lFW68LRFBCFYZHDDbNjkevaunTqjqi+lnNX1g21Kmr3ozlyJtyEdwT6qiPjz/40Qsbjjm+ASCOUblVMQlyo2IySOUFgnVeb6rbEi2Jg8+ZDFs8rjc4kSJWlElK+WTfp81AGwblh5g5DmPu+/QtywyoHH8PFSod5lU87ptv68JWTG9vADBeFBrTFX3W6T/5GrU19zrSbdubf6jukZUEgcH0mFUcM8j503imhKoIQTfApquctoKwBbYVkjFciKNj96QLx0+3joPIsUhX3Ltx+fRRcVXzfdUq/pQfVIYnmxGt1yC1BskIXqG5VrV+pbjbatHSZV5/nZyioQ8MrhYH1cdsWz153YoYCrK6ftDNFJQXOOj2NLF5P84z0jKM8i9hAOIV8+SiERzQF+v8N5zRp9Q+eEHWwsdEChK4pND0G3NgavBbEO04PJ1EeuINU+6bd4c+yyftvYlQ9EsZhmyRLLmWzMVo7Iaj4fGRscmjJtqJrvsOKNvuH+MMy5+IO+BFtQULL68GbTZuXpW2GDvRSVL7gCQuMwpMDYffWFII8mC0fjhnHrcPnBFasQ/AexHfuuGlltq9I/99tgTIGSwdtbGf3g8Din4LyoME2t6W6G3+PY4IrdJWLvFZA0IQmvKG0HlNZ+nGMH/2e9pQBIb4UXYxglPkXV8H3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MOjL2RGikEcSInN96KGY7bflYPzwOvfFdJfLDsGQjGhzARDnO17oLVdabwQh?=
 =?us-ascii?Q?42m0uBwTsSrb+L42I/tnIx0FwWy5YBStB7BgAtS3HZZbm4zhY83ecGRyASCi?=
 =?us-ascii?Q?Jv6zU19zRDHA540JDe/vrU46N51IHtwmfRDGsO9B26tuLjnlbTRtqPg0HLXJ?=
 =?us-ascii?Q?OPaK1xQdpZ6Pb0iZuyfWHsK6hhpRTYt/Bt7hO8DHxxPSVNYeT2cYkyyM14U4?=
 =?us-ascii?Q?useQHS3jjfpgoC6G3Ekpp1T/rriiJozlQ8wYrDoDSEJ8qGvD9tFiO0SqGTQ6?=
 =?us-ascii?Q?NfrNe9ZIhGiCcLIuSrY4LnCmwfYD/t4fFoTowro5+sKSbsDi9lMYng5A4BWc?=
 =?us-ascii?Q?laAWhkCWICy4pnI9GHVSf+9yCXECSlHwxCsiZ7zClkbUxIp8qbNPDC/uhng3?=
 =?us-ascii?Q?/2eOvWIgFPl8oD578ERB0caiYQqI3K/0D8bQtmV9ZYEMaoio+gHBYe1QADGw?=
 =?us-ascii?Q?0IqHLd2j5GVrwsc4hty6n1+dGez8EI8ZUGJ8ACu492LCLcUpzskogJFgHCdF?=
 =?us-ascii?Q?kAXwYipuP5SGs0bSo8EGDGcpdJzqqJxntKhlw5sfr7QZkgb5GZRfvEbLioq/?=
 =?us-ascii?Q?qQrC4wSY0Qf+JcXhLhGc51mRK24OyRRar9LlhaUzZRrXUohpahObUT8/6zzU?=
 =?us-ascii?Q?CgJl0vNFCCjvAK5yBfDPkodmnOSyVjDlIgE4E3bT4YMyCUvONC9MuUDVZcNk?=
 =?us-ascii?Q?oTITwAj7mhz++QQsDAR8lR6xPKZ6QkrpJgKYgxudGjjJsbhExEiA6S2eCzkx?=
 =?us-ascii?Q?70cVzl7q4H245DqYVvOXh4Ff5V5ziHZGwTjRcIvb5fMjCBTePx59Up/hgNhh?=
 =?us-ascii?Q?CTitHoLmZID1ZyBHBuJAThadHYIYVZcFskKZJY9qdSYlNgCdSvNtbkEbSrEW?=
 =?us-ascii?Q?vq/43zxCOG9Ty6l7nXfkV398em10gq2ex/QwBqmijHBh6HjXAKtM4mT9BIDr?=
 =?us-ascii?Q?jXTL6ozXE+7lbmtKbTJaMhOnRBck0xNnewpA57szN7Wvdpp+Y/fwrJcEUMF8?=
 =?us-ascii?Q?qjEjik5Uz+zUXFkS7Vjag1eqd7Ru9Ts97PijorxvMRRhA4WHT5rlX+KbEl3o?=
 =?us-ascii?Q?LCdk7wkONGiNrLdmmIE/GgnukfzH/Wf1AKFkBsaIblAJiM6Ca7ZVlScu9A+o?=
 =?us-ascii?Q?IQdCM3VbbBfs1+kS8P6YDMyd0a7NRYkZXT8SEFiVcjwi/x24tVtXhh0En4Pe?=
 =?us-ascii?Q?BTj2gnVADE0Ohk5Qt+tPoRck9ajsPeI5DHJs1AavugC1S/FoyyNtkcr+f2m2?=
 =?us-ascii?Q?Wq9P94XaP1gZRDrpXEq9Cf70eoWyinfYvtZ1eYzu8Bx6/vKPUMkFF/shM5mR?=
 =?us-ascii?Q?jTM7UkOWfVHgBxOcgOa6ALIw6pO2HrCV81lqLDVPyxP5D1FsYnII4HDXsMYl?=
 =?us-ascii?Q?EyniVFfS16Zu7NRIEylRJFxEjHoNabBbzq1zG1s1zPC6ZLbw3IQjU+CmDzv6?=
 =?us-ascii?Q?qYHKumBzoOeQ5L6dAIlc0I+M+CrnWvSoLtmcR8pdo+YvnoQPD8oh9cvsFyH4?=
 =?us-ascii?Q?VkP1RTFymzpHx/FJHfTG6OnAnCMX40ofkgdiVK1AamQIP4vDcFGmH5D3KzEY?=
 =?us-ascii?Q?ryPpRG2dil9AHq7VuWtL9k6tVzTejDFE7C+W2u8rqm1p9rBgZS0yxGfElUz/?=
 =?us-ascii?Q?vnCxpgkK9X2XBpFUy/mYQCRDX8evV4muz0geff0MHZYw6AezWlvyh4a9qg1z?=
 =?us-ascii?Q?VpOSdAO0xND7rQXzdOzFdTcbQFahjGW15c60X7e8LP72fiJiPwF0X8Llj+St?=
 =?us-ascii?Q?nIwHlZ6rl0sn55TL5RLPi5D4Er6Y4VM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad93132-6efd-4aaf-bfe1-08df04f22060
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:50:08.3389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSxBl3gg8oR2Ur8gtL1BAf24c3XdYyMItn/KvPuaY81dM55U4+k7QMZyUWokuIZ4oCMGyvBoI4rBqaNqympbDDn/Mf9Bi6otjsmBAZPQb8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757
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

The avb_ops.h header clearly indicates that it should be possible for
the callers of the read_persistent_value interface to know that they
provided too small a buffer, and the interface should also tell the
callers how big a buffer would need to be.

However, that was never really implemented, neither here nor on the
op-tee side. So if a too small buffer is passed, the caller simply
gets a silently truncated result.

I've proposed a fix on the op-tee side:
https://github.com/OP-TEE/optee_os/pull/7959 . Since that is an ABI
change (returning an error where it previously "succeeded", for some
definition of succeed), the maintainer would like to see client side
updates as well before that can be merged. So here are some of the
changes that would be needed in U-Boot.

I have not yet looked at any of the callers of the
->read_persistent_value method via the avb_ops structure, only the
implementation of that method itself.

Rasmus Villemoes (3):
  cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
  cmd: optee_rpmb: try to allocate large enough buffer when reading
    persistent value
  avb_verify: read_persistent_value: honour contract regarding too small
    buffer

 cmd/optee_rpmb.c    | 45 ++++++++++++++++++++++++++++++---------------
 common/avb_verify.c |  5 ++++-
 2 files changed, 34 insertions(+), 16 deletions(-)

-- 
2.55.0

