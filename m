Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421D0C531C9
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 02:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B8F080CF8;
	Mon, 27 Jul 2026 02:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_mBblwQM4cG; Mon, 27 Jul 2026 02:28:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F0D880CCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785119325;
	bh=nj3FQWkGDgCHFMubasNcNLEZI+W7pAhhyqytbuaMhBA=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=fxyV7jcxzKpsIz1sSFR+klPbGVg62H4XZZ5v+MM56ocF7aGBU965pLFNr56R9qO+Y
	 E8DpCyl8IYpl55Npe7Z0+IXL5N+EE9+gUao2gGsTENqQ4iQGpMcEL/uJKySjvCPYmo
	 +//VdNlxV86NhTq92+lnolDak3fgzmr/zj/dr5qamBI74Cqc68ihqYubG833U2Y3WE
	 67WGQ+EaEeLoqrnhSyVszd80weAVZSnHuzGGwAbPqMTkdQlCisy6ykIxvlLG7tNxrV
	 ka//lZK2vVPWsYVrLIywXHnbTzg/ywUP5gMqPqMrUWw4H/2xzlct6MbC0jP4O7gJ2+
	 QtJ4JSJ4QdxLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F0D880CCE;
	Mon, 27 Jul 2026 02:28:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 193ED350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 02:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0ADA3400BC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 02:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lg2kfnHYXk5z for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 02:28:42 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AC8FB40042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC8FB40042
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC8FB40042
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 02:28:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B8A846A3; Mon, 27 Jul 2026 04:28:39 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A4D82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 04:28:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUw2eG7ino0+SbvBvE2ND3OLDkiZ7RGbImmkyHmgDSaN0YnyDUNRpRAVJ780n/Mtqjr3vpsNDckw4QHIzuJf0Eqsf82u9FbtV547v7BNMhO6eraXrFF75XBeOZaHT3UvcT7jsTJkhCl+rgRE2qRAwjLfXcp+EIcrrgbakSXAQQo/ocD5MmAOaEFnNj+s5if5VmeZOJPJVZTXuyKCpnYm50OIvsVANkf8rjFOkMaTfxhRkIDKHeEuXpeFdF1C83SFkVqalA1b2F3fBX5G+T9AKzYiQIeBYiZN5VT5WdT0jsZRuDETwfe7W87Mwl+S/HWvVyS+9iSskm23K9O2tNvZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj3FQWkGDgCHFMubasNcNLEZI+W7pAhhyqytbuaMhBA=;
 b=WX84r68J+pJncKnHw9kSePaU/vBnGSTDU6YH24Wa8gP2S3wz7Q/g+hCJephHfdEow8HKxsIBlxALqxvFmPNwG4ynBtRZpOWr+7XwdebyClAdnDFlfv42LeKhmiTGI7cGVLMNrO9BhdQynPMODJHHe6lkT9xvH/f1ilt9lDcMUsoq2hcz1w/Ue/fjG7lsqv1ZXjVDg0JI3bi3STXKlgoSyW+GvzeCGnhn64Q1tQz9wVF8ACSrCU3dT9BjQ1Yu8EypcKcUXiBXwsc6dJ7ZnJx0ctLFoevfT87DAeAXOxs7/+0yW0aZy9Hemk/hT0WKLm5TjnV/S9QCARkybJBfV0zuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW5PR03MB6906.namprd03.prod.outlook.com (2603:10b6:303:1c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 02:28:29 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 02:28:29 +0000
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: socfpga: agilex3: Add Agilex3 SoCFPGA support
Date: Mon, 27 Jul 2026 10:28:17 +0800
Message-ID: <20260727022817.31050-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW5PR03MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f852646-5c51-4ddf-9f19-08deeb86beae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|11063799006|6133799003|18002099003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info: 80kFPjRhFUiYpSSonzzKFEyvxEjz7t5Cf7riqZfRgqq/d7gs6TYCzZfw8jeu7AnllZqeNxwK+avxZOEbLWdrD78JcfmTqcm3Qmn+HKlMjVqVHdvspbc8IDQmjs7P9x7/EK8FBln8nTAgFTvEnLtCWYPQPyIU2miiPX3Awz2jbKX8xPMkVn2Rjqb054BYotclmclvN+kIUnduSLqECzUuFhymv2TcQDZ4fgoy+Hf2aR8A2XPhvDstj61jUv1kRfSifvasJUjOuDhgAZlK3NgdMKp89t7M0yNiEchGTnmlk4rcWeflgbRK2udPzDHQioWRTca1pq+V47ZPs0CetjA7GK/VRgPrazpverOVL6uRbD+WtpLbgOnzqNd371V+CpL2paxJFPfsOJSG9UApURBZFPpsau6LJFxm9H+G3+7hq/NGQADBpdl/lQtOb9B7sa3NRvTWTFdfnHNlw9Xf+TAno3P0bCb+UCOkGPNyHIiJ+tmGtWnbA750ZDJB5P3VQS7HDXPd1bO2pEt4FdznxqdKeaHfuU1fZ6TkQ7W5DQIQlvBfwp3/cFemQF9wx1BYkTMjbdMM9cZsNsC7AbjHtbX8ujj5YV+RQ1+RRphqALCMttY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(55112099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1PIW4CrdOcoDmb7Ll7AX3yanNW9x8W5144vjnFhFtT3zy0Puhmqq37Lle9ev?=
 =?us-ascii?Q?u9PTraJZ3TNXJ1dceC/1CneMq0kxEDThsVuAlGlEzJ6no4cZ1NnpIHAOTsAR?=
 =?us-ascii?Q?vq55lmXKy3cqNuQyqnhs8nbVPT6M0RMRz3+f1N68CsDIGGZ73JWPiCrXYMNg?=
 =?us-ascii?Q?ZGiy3IGnY2acUI+B0g6uODIi8gi7qr1J3uPDattnluBDMOPnv+hPXi2y26qQ?=
 =?us-ascii?Q?DA6qPFW2eDOzm+qb1PBQFquucy4kY1YeBc7KqWlT/z7LzCdH6dXstZjlcs0b?=
 =?us-ascii?Q?EecWAHj40S/r52ApgCGZscfF5KxcDna4NLUWXyfi4RfgCZz2Jl9FkRCLdL5v?=
 =?us-ascii?Q?nbHa9Psp54v/zq/MkzcHF/cBKZZU6AxRJmq9ApqVDqxVcix3i0B675QmWqOX?=
 =?us-ascii?Q?koJ6SFJmQ4+3MYoaKRkOzG9d8L7i4MH0f5SubPu62L+vLC7Exn6npR3WF9ve?=
 =?us-ascii?Q?uLPAq58uN4LJv2/75HOEKyzBZnhzuLJbwx+vXdSL3/FwuudTkQRopiTJy2nO?=
 =?us-ascii?Q?9sA25CWxqi+x9bxkMsHw/5ZvXwZNkf9ZXeN2+bNKkFdHY7W1LncTQENabC6f?=
 =?us-ascii?Q?ndO0AKo2oedgoW4C3UQ0ytAsKCbZI+dIp61/DyqXasCXEV1TlgFuVWd5fylq?=
 =?us-ascii?Q?Lcqg3lApzWhmUHtHi7wo41kVSLs65HO1y/ApEheSiBW1TjfH+tXuwrDHaR0q?=
 =?us-ascii?Q?QoD13KO1euInNHS14vPgc7jX7uHccT6OhuuR7xuBxrMHPnjeiEhL+MBwI5mG?=
 =?us-ascii?Q?nxKPbQjz2xnRKYPlra58DYo3nmdgXjJDBw0Llj0+Ii36aDyFLf39BjXI9L9R?=
 =?us-ascii?Q?2i4vg8JHYyONOUiW81Vqsaazo4+ca/I9k3avwM2T14OQjJ+FclBZXq+P1fuv?=
 =?us-ascii?Q?ayJA8P/kHyfsyYHQbdrGcfcBjOV7VLfmjJ7BuPM3kObpompdKdRYSAm+1CWz?=
 =?us-ascii?Q?gaV3/W+9cRvcYQ96yAoMPNdUDD7JUR//eSUxHsIL9rDh512VNfkMlQCtVtAc?=
 =?us-ascii?Q?4jxFHPJGvIIBQRUpHT6QbqFsP+d2zsr7dIYt248oxxwS/VApOcBEXLrevo1B?=
 =?us-ascii?Q?tZw8pZQ23yMxrvgVQlmVv4WGDwrLPw+G5w7UfgLmr7ewXdMXHPxi1RW0Uz1n?=
 =?us-ascii?Q?Wg2nN7wuxMlGktuYhPXQ8/zOaCmrGdQaZoxkeNoW+qkrze1l16N072LIkMeL?=
 =?us-ascii?Q?mD51OVrsqm4V03e6HBEcBimeZggQgwCc3JAwOixItKj5nph1LUbs1jfWdgTw?=
 =?us-ascii?Q?+P9UIcd1C5F0uKBWjBpj+jcG9NPgHAjpnU0Qnb8/E9cK7ZA96Bposcme8yuQ?=
 =?us-ascii?Q?b8B5QuJP62RoL1uvMpfZKBh/LRA14IDvWSABU3pXuCRGjoXe67uLD+MyB+yv?=
 =?us-ascii?Q?FPMA4ZzuTsXxZOLlK7GiQR9A82be1rPDTF3TqDf+A5iLYWp6NSBPjz6bVoVc?=
 =?us-ascii?Q?sCRxCgk8euB4gpXmuLn/hOlqsLpWToj7ZLIgyPNNhC+81jX7X4pHrlr0Ti2O?=
 =?us-ascii?Q?FCB/Jn/LXk9UBPWB/nqf+DWzW0le+D6/lIXtUcgPt7f3jrhKZ7jwGawJDv5V?=
 =?us-ascii?Q?bYYh4JaKVCgZOYXHdtresNCAvOYbWYOWBWpUTBp5xQbgvlnGf+TZKJWmrQNY?=
 =?us-ascii?Q?g1708oHGRNPB1iZkmSabhox8xAbWrLqvC7YMWZa+zLhzPSN7PTx4a/zFNXnB?=
 =?us-ascii?Q?2+e1AmUMmB6MYm4apYcu0+RMy4uQ3aVeNqU4kxatQTuPHGNwHvCdzhzu/GNT?=
 =?us-ascii?Q?+UzLTAEWAK1tWSDC0hDq7KEng2V31wg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f852646-5c51-4ddf-9f19-08deeb86beae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 02:28:29.6217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msx5PcsHT1hochlYnHYqvsF+HqLMtb+3zwPvVBU3Lfp4BcN1yvrBba4+IbT8PP2fOm0aHu9lM2W9YlOyAEfdE5Ea5/UQE7FI03s7Y050vMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6906
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj3FQWkGDgCHFMubasNcNLEZI+W7pAhhyqytbuaMhBA=;
 b=ItcuPPymOxsj/nZNIAokkFxzH/QxcJWQUiLKQwLRB3fQ/kKTwOL6Vwj+Dc4YAS/DQDcDZhWEKAVo6l+qp6rhpkg1ioGwH4SCFMum0nWnrHXjH6nJUwD+QYtEBAo5h0REclLGFUATv02gOUUHXAlu3n7ThcsWQ4D/c39H6JMqXc5H9e6ImZlXfGb0cvg8TXV9UiiKN176tjI9xdHIW88Zd2M9uRv5pDs41eChNOfNCifwi8pEoNDldzIkIWRk7cCNXw+MJnhUE74uY/TV+idsQuyHgzBs01vmQTO1Js05QLqlVMW+KPxw1xamFsig/6mTA4cH636XS1+zMZOXQrJfsg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ItcuPPym
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="ItcuPPym"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: Alif Zakuan Yuslaimi via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: alif.zakuan.yuslaimi@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Add initial Agilex3 SoCDK board support based on the Agilex5 platform.
Agilex3 reuses the Agilex5 SoC DTSI, U-Boot DTSI, and defconfig, with
these board-level differences:

- Ethernet uses GMAC2 only with a Micrel KSZ90X1 PHY. Agilex5 enables
  GMAC0 and GMAC2 with a Marvell PHY
- QSPI map is 12 MiB u-boot + 52 MiB root with U-Boot offset 0xa00000.
  Agilex5 uses 66 MiB + 190 MiB and offset 0x4000000
- QSPI boot script adds a fallback MTD layout for the smaller Agilex3
  flash
- MMC enables SDR104 (sdhci-caps-mask) in the board DT

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../arm/dts/socfpga_agilex3_socdk-u-boot.dtsi | 179 ++++++++++++++
 arch/arm/dts/socfpga_agilex3_socdk.dts        | 222 ++++++++++++++++++
 configs/socfpga_agilex3_defconfig             |   8 +
 include/configs/socfpga_soc64_common.h        |  22 +-
 5 files changed, 426 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex3_socdk.dts
 create mode 100644 configs/socfpga_agilex3_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 25234697e6a..90755277bab 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -415,6 +415,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex3_socdk.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
new file mode 100644
index 00000000000..b14277d5b8d
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 */
+
+	/*
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 */
+
+	/*
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 */
+
+	/*
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 */
+
+	/*
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&service_reserved {
+	reg = <0x0 0x80000000 0x0 0x2000000>;
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_agilex3_socdk.dts b/arch/arm/dts/socfpga_agilex3_socdk.dts
new file mode 100644
index 00000000000..2f331a30996
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex3_socdk.dts
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex3 SoCDK";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i3c0 {
+	status = "okay";
+};
+
+&i3c1 {
+	status = "okay";
+};
+
+&mmc {
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&usb31 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&nand {
+	status = "okay";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00c00000>;
+			};
+
+			root: partition@c00000 {
+				label = "root";
+				reg = <0x00c00000 0x03400000>;
+			};
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
diff --git a/configs/socfpga_agilex3_defconfig b/configs/socfpga_agilex3_defconfig
new file mode 100644
index 00000000000..9072312a015
--- /dev/null
+++ b/configs/socfpga_agilex3_defconfig
@@ -0,0 +1,8 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex3_socdk"
+CONFIG_IDENT_STRING="socfpga_agilex3"
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX3 # "
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x0a00000
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 4d333c63ad9..126f1e5cf97 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -77,12 +77,22 @@
 	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
 	"setenv mtdparts 'mtdparts=nor0:66m(u-boot),190m(root); " \
 	"nand.0:2m(nand_uboot),500m(nand_root)' && " \
-	"env select UBI; saveenv && " \
-	"ubi part root && " \
-	"if ubi part root && ubi readvol ${scriptaddr} script; " \
-	"then echo QSPI: Running script from UBIFS; " \
-	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
-	"then echo QSPI: Running script from JFFS2; fi; " \
+	"env select UBI && " \
+	"if ubi part root && ubi readvol ${scriptaddr} script; then " \
+		"echo QSPI: Running script from UBIFS; " \
+	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; then " \
+		"echo QSPI: Running script from JFFS2; " \
+		"source ${scriptaddr}; " \
+		"echo QSPI: UBIFS/JFFS2 load failed, trying fallback layout...; " \
+		"setenv mtdids 'nor0=nor0' && " \
+		"setenv mtdparts 'mtdparts=nor0:12m(u-boot),52m(root)' && " \
+		"env select UBI && " \
+		"if ubi part root && ubi readvol ${scriptaddr} script; then " \
+			"echo QSPI: Running script from UBIFS fallback; " \
+		"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; then " \
+			"echo QSPI: Running script from JFFS2 fallback; " \
+		"fi; " \
+	"fi; " \
 	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
 	"source ${scriptaddr}; " \
 	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
-- 
2.43.7

