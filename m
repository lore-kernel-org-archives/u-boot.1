Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82733C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 11:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B346481A02;
	Fri, 14 Mar 2025 12:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="e/z9M3EX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A41781A04; Fri, 14 Mar 2025 12:48:28 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A988197F
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGBYBiFOp+liWeopfG2L7qjAXR4dMWPjVyunxJ1Nb9wm10q6C1jLTNuURIAUk0jzwrYRFSWzG3WBWNtO+d0Tu6Q2B2XDKL2HSbM3wEAom6trTTOpymkv/wrfQrhM1hYjSoQXScd+gxeMXt/gDKnQJby8As/uQhSXe1iLVMpWZWuK5Tx18Njy6JpcgjWpkuGGzXxo88C6XGUYOZhoZPzaGMb3yaLpzQCGlEa9Ba6zAzcGIEnPrPIB0U8XSoYUsOwaKlit9+lpe5AU0fz5Y9EsRObSGoEZ6mhQXMX1Sc34TTHUqQW4aNiZc4mvs9z+O+1Jz165UwtwWtpPmPpfMcytVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siakBN3zl2ehbULCggMcY8DNdFrzbHZYnyKaTO++kKs=;
 b=Nnme39ia6CEyBcuJXtlDu8koVWuxdujRJzO3Ui8EHu1rvyiT7Tcyn52O0Hc0tiSZ1BwuIvGWcj+niMYAYAgEvu3BUm8vXLAsnXr46axuj/KR0LZ80XUpT/tKyjQ3R2ADSV8/T2xT0o/mRzvbO0HC3rW9UhUAeDcHwteJqYUov7r8fk3pwbt5rfqIzCvTX10vc69z8JmFRcU4RIV/0Y/EV+5JFfLDVm4OrwpHvImWAqgnbFjMNv9OwkrLeVJhihKwo+tlrf+GIz4gHyvSEjvN09DtXtdMdhAX/QG7apwYGdSxDEKp26GNzn7FuqwhE0mTiLmDeM9iPr6z/oWzmVUJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siakBN3zl2ehbULCggMcY8DNdFrzbHZYnyKaTO++kKs=;
 b=e/z9M3EXZJhevvnej+gAKyEDdut4SV4YLdso7rvpx0A7NjWQw1/RETFPyYTTQ3ypSDJcvAYZVHlZXln4A4wL9yr9swnGrVPCOtK3YQczv+c5+wObGpbgl8fTFqwQhJmVQLbrZiJdbJETA6/M5lbVRwnMJpnQfvWBvvzlRR5ojDRRnnfrk90QJNIKZyQXTDg4M6PFrQjpts5XkombAq2Sm5f6AbpIh1Cf/khhfSHl4pxMAk7OEej+S5CSSoWELctjrjfImVRJrrvIjNxphAbozsZkOH0S/+i1Ytc3nZbVbstIGz0gyjsKqO/3iTesIWj6S+QLpWltOadEAgUTfPWa9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6651.namprd03.prod.outlook.com (2603:10b6:303:12e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 11:48:22 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 11:48:21 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 0/1] Add partial reconfiguration console commands
Date: Fri, 14 Mar 2025 04:47:57 -0700
Message-Id: <20250314114758.29078-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MW4PR03MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 006ae2be-fc29-48fe-1d3b-08dd62ee1ee0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3/0c5Dv5xauvlmluRNcxpXYdJqVkNb9VMWpPwGL/v1pCkbEt91sjQ2Zl9Apw?=
 =?us-ascii?Q?8Moopw9r5bMO0RstJjaLGq6jPVrGKwo0WGX5Et6bK+6DkhjAlyQVXxft99zC?=
 =?us-ascii?Q?CB9BHtSElPLeCJF6Lln8CXKiI+eH4w+7t0l/7hMGAEs+utujNRfoo6u7kDvv?=
 =?us-ascii?Q?ndG0gIeD+RWIMYhKlnxeu6Hp5AjHHEPVNBwpOA4PIZo78MC7TO7NIb7vyadU?=
 =?us-ascii?Q?e7gsXNTI/aKtVmR+qTFgk5JascqM3yVU2Lzz3rTTnx9FQIIT0NQ2zqiEoRRt?=
 =?us-ascii?Q?pguGBoTX3ecUncrbZ1uq9BJgFgcg9XcU5qEzS1MTdPHHXCU3BKYf4y/xJe+s?=
 =?us-ascii?Q?1SgFXpVmGw8qTLtkvAscOmPD6cG0Kx0seVMsgr5sNODjmR38C76z/CwoCmlv?=
 =?us-ascii?Q?FdMHyhmBGZdubJsb+KrzhVj8pBD4PkWSBYOf0mABZeUt41v6GHCRv6wSJIgh?=
 =?us-ascii?Q?ynid9DqnTTe+MNajk0Arb8QrZFGsGvLsoD46YtbNrEUA3UYY7p1I6KSSTmY9?=
 =?us-ascii?Q?nM3IKwG1eZS8VEcDcl3Fks8PHhXveCSSI7StTo+1nrdBw2dTlGbLM3XVqEcd?=
 =?us-ascii?Q?G8mQe6ZGX6lIacpZZ+BuWqF41Cx/ILBY+ekaF1X4EvgURyxFaz1Tz+WE9+ae?=
 =?us-ascii?Q?gh5GXsYPwxX5L8OUYsUf92XVYXb9SzRezgmkDrUWKJlDGg0phRZeUhcXYvfz?=
 =?us-ascii?Q?jz5jG+1RQlqTpYuCUDKA6m1HGvKSNVo/blkKgNK8m8VwT4zbKTxtlxLX/1lH?=
 =?us-ascii?Q?9xdvm2ULpUujENYwFOBcchQYQxFXx1Vq/DEs5cs0HCU/wXXusZ1HYoKCjyzx?=
 =?us-ascii?Q?fjrt7Ae6I3+G9u5Run7fC+fDcaYIgHakNqD5P0dGkTG2qLiabjvbMRxV+kMc?=
 =?us-ascii?Q?xHoRIIsuRSJGVa4LDsBg5xLwM/PCbRVzjeF1bunk8lNoKl83mGixWxckrkAN?=
 =?us-ascii?Q?Ng3gKuXdxd8Q0YYPJ078sXv8vPr0m8hGThzjDuj5uqDUxMDteN90Wtzm2yKz?=
 =?us-ascii?Q?qb24hPCANjPloGYqAODco+c5fpMcEne8jGZeJmf742Vy3juklKKHJ6bs7KhG?=
 =?us-ascii?Q?Dm20UpVH3S+ACHkr3u8oDZrp3mVIhejpoGv6T7egFetLDwsnxJqAuJZpxxVJ?=
 =?us-ascii?Q?yvWVRTNB2zG/93K8s7C45NgJNEQ9n7TDiARWEEIDN5i+HWY+7DsG5D/KVagb?=
 =?us-ascii?Q?04vcxJOjhdZwmk0m5XlOezB8+6thA10dCb9RTTTwwgk9GO6o14Xt19bpWonZ?=
 =?us-ascii?Q?lCkewsqobS2AQZ5tAJ+1YAV+NBd+k0IRNs5/HflJ6LZsbsWAURt4PQ1uPLq8?=
 =?us-ascii?Q?W307fEkd/MOcJ7TleC7n2B02Xqp/QNju834V3qCFR/LSzzIAkWh2sj5/1ux/?=
 =?us-ascii?Q?kVtlsKQT8AzybOP339PkzxbJ1V0d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HlZ8BRWlRyIY0f+yAVv6LaXpEwYp0ySSbe/h2uGr9dpHzd/NvJyKxR0kL3hF?=
 =?us-ascii?Q?ztBrKtM9IxGpgxOfnXMNdwmq0a03GgHobAhEEBKejA35BO92AyoDvjBTPl1+?=
 =?us-ascii?Q?OzDPjv5BCmEHD/z/MoNONWa2KfCOqvWlbJ5XS7R0OtjHStrm6Nm7Lj+pObG6?=
 =?us-ascii?Q?AJYOdLLguaPwmnb3L/ZMzaDpN5PepStS4j/f+Gt9GUkXMs7umOFSuNm6G1MD?=
 =?us-ascii?Q?i8IvIs1ofwmKomXjAE8/IWJw0U0DYqUGF+cASQ6QXLHb1UeUQ4wTjVhNa8qw?=
 =?us-ascii?Q?hnRfefyGKToF8+CEwmcC6MXi0WkLi/kw/uXRY1lThDtQ+XuZyoZBwFUYAuA/?=
 =?us-ascii?Q?RpaX+o2cTa1DgkGj6CWLYtxMgmaqlQEsrcWIdJ6bKW5X0A5kSm18x4L9f793?=
 =?us-ascii?Q?m382QlDOOjZpjYt9Bgms4lVZJRDA4L8RtgmmRMAksXq9/nVQOivKwnDcsy3w?=
 =?us-ascii?Q?EQoBftF6kZ00YXOv0A2VrNTcaIWzaJu7SzxhUWN3VUvkJGWaoymODdKVOc6K?=
 =?us-ascii?Q?WDsF8+D8YiRK29FPqebXg69CcjYXxRUg9vzpLlBZe/26ltQZ7VQYuMM0uR/E?=
 =?us-ascii?Q?Ut/ONxHvtshmWNltpS+P+T2ZE8857aJ3RUSCmwDBVOto6JocD3tr+1MOFPIe?=
 =?us-ascii?Q?3GqWcEYHYSPY7Puhd2ExFchr2fQTb+evn7NRQhcYaTo4LzjAsVXVwOr1Amcx?=
 =?us-ascii?Q?ZKAIr007trdOBxwkvSHr1JwJI0XDyH5X3bwO8pAJfUDdgzLbYXFaUQxlSPjS?=
 =?us-ascii?Q?vDzsRMDX+0oA0JhgfQil9OyMZPhBDIUNSw+qj/d4j1twZ5E3uain+XwQOr5y?=
 =?us-ascii?Q?w/IBpYNXcZJcxp/DrMWDNWFJiVNJQmEoTP05JKhmCY+UKbmEZ+ARzd30eYrS?=
 =?us-ascii?Q?d+vBNezbE39pvT72c4olwz27r4LpY4twzoe1GcPHDdeVRhnmVWxDO1SvziYO?=
 =?us-ascii?Q?HpGBmNEFJrUl//Y89Se0u2Wh5OIr7BcDuF1KkbRiRyFLdxTPJj9UJ/i2OeAc?=
 =?us-ascii?Q?zg9U8pb07GHoLL/CUipScpMIwoTlUVIBc/Z5eM5w4adC9bYPq0PdBynt7R20?=
 =?us-ascii?Q?DMfIp7w9u+uJuJIEwLJgO2es9EQyfBmqxNAduja8w04+oZuDI6vWwcFBFGoH?=
 =?us-ascii?Q?CP2o5am/TfCgicstrpgHnLW13O2qeORcPmNdSJZzmubTMreg4DnHrEC6jgNN?=
 =?us-ascii?Q?xY/+3Zw57ixCDHsjA3UWpBzCWELNIWG73/Wdk2tm5O0QtpPIkSIWK36DgZUu?=
 =?us-ascii?Q?Q7hjTjCGTCcs8JXtVVkTitQS65Zt0jTBuwC0pb+ZJLn/npUwrO1UpdhxTRRv?=
 =?us-ascii?Q?2RjhTlCqKQ0pjyLd3oCxqWbCV8Wjg0Mb7dNZbZqkNF4NVB+XaHhWh+fCZfrS?=
 =?us-ascii?Q?BEOWBoEz2thzSiTtO52xbxHPRsTrHkw+4t6uwHrjWz856cqVn2UgbfJ6GTxa?=
 =?us-ascii?Q?xGBoG7iFLpskMoUpDlIb9Y1Uz9Jb/MvoKnQ/MaWwERBVtxvGiTsRsWXBY7Sy?=
 =?us-ascii?Q?W+wQkPFqgzofCcXdzTj4Yiley/2d/x3Px8cuao8JTzVqhq4IM8/SlowAZUUk?=
 =?us-ascii?Q?iNtL9BCj2uPXVRgZid+euGJQAF9X2CeHDWzYhsi8zQV2ITMLP27Qh7O07rOi?=
 =?us-ascii?Q?naKFAwlnR2MgAybteYTxJKo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006ae2be-fc29-48fe-1d3b-08dd62ee1ee0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:48:21.8313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K1MdQUAUrUWybLqwwvKHEwhHgbvZ5DYIyv3KA4cdMQc+hSt7VTB5w4DX+8W3MHl0wW5Jsa3TyXXSp3L4VRx0vT9HH1WB6JDomW4ziAPhK9mhk7zh7Ljh1gIwPa4kI5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6651
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

Partial Reconfiguration (pr) command is added to U-Boot console.
Internally the driver uses freeze controller to freeze and unfreeze
a region.

Command is defined as
$ pr start [region ID]
$ pr stop [region ID]

Command can be used as below from U-Boot UART console:
$ bridge enable
$ fatload mmc 0:1 100 pr_bitstream.rbf
$ pr start 0
$ fpga load 0 100 $filesize
$ pr end 0

Naresh Kumar Ravulapalli (1):
  drivers: fpga: Add partial reconfiguration console commands

 drivers/fpga/Kconfig                |   9 ++
 drivers/fpga/Makefile               |   1 +
 drivers/fpga/intel_pr.c             | 191 ++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/fpga/intel_pr.c

-- 
2.35.3

