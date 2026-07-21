Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E512C4452D
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D99E480E36;
	Tue, 21 Jul 2026 06:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dxjFAsdcYT1o; Tue, 21 Jul 2026 06:16:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF88C80E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784614603;
	bh=d0PXVZtftiEm8491TxZNS2WLkeSiniZ0yRwHpsMToSc=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=A6Rp8bughWlq/1/B7NmjMcri8TSRj3tUoNvOEvuF0y79cZnmSejahKPBkH/MMKTtG
	 3oqW+dprCvpwWXns4vDDsR9AAGJB5biU5Ybj4x9POnqkxE8PWyH5sI7IqH6znfo31v
	 mfQHkIe01PnLv/H+CmOpXF61Y7Vg25OTrsOinRwRwHa+JvCnNb12Hh5odPQQiF/pvd
	 1WzEM5NZrDuhsOlsQUrxXd96Pmkw9dJHwJJ7t1S6dF9ZMsWAeRGXMbx3O5chpdNn3e
	 LGrg47zejd4QBo8vv8uymCYDKZQQX79oWVev5CT4u8tz8Gj+gkWSL1YvMA3/udrUEf
	 2WRRrwemkloaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF88C80E1D;
	Tue, 21 Jul 2026 06:16:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FA1E1099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBCDF80E19
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O_fdprOHwSvx for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:16:41 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E286080E1F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E286080E1F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E286080E1F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E069F803F6; Tue, 21 Jul 2026 08:16:38 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC84844F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:16:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWesCYWiZTfP8IQp+K18tVRFov3fuT3wCvxtQLcqm6HKrT8/gElt2hagvtvGPnnvMFGTqDnQR9n2Oc3j2RkFw+u7VmZIsY5AAlouFthlB1PuKpl8pTUa33TXAM/WQQi4l5bphxhLMpAS0/oPBRBNcxi8WPdxdl+jJtWbaq6nJ6OzOOlQxlS9iOMDWct9AbPc9uDwMNcOM7OgTfU+fz2K57elb8HG0jW1tQYlHmPE4Ia+dc2S+cemyMmGtK7e0U3C+KAp2dS4qNUrzLLGnj0qrw/cLInuL0qV3oLzm/FLeZiliFrnUfdMoKpRQ4RE89rCMqLJl29sHaUcHbiFPvBiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0PXVZtftiEm8491TxZNS2WLkeSiniZ0yRwHpsMToSc=;
 b=yPN4MRiOc1XGTY+6zmef+Z1D39/Funp07jstP5VqGtPP/1zUZ9pzjyBFaEU06I4Kn/cGX83vMB90XVT3qL2c6PthLMjC0tm7Ucp8DFWzEkEc5sWgc9TqGgbIvmisfQB8NrkguBvK9zRe0Y6TCYwB0sEEgpPi4/xp6M0QKkMDzJWFyreN3mw7tifmekoanqrcNVVmJO9uQDkOSzXWWkyy9FWYnl6nbuXBBuR94LIOOjhqS8tPBX9XyBlVKYL5fXhczXME+Xoi9ealvYNcckLtsz8YzqKpt6W8iM7HmoPsACvR9gpMoRACDiLV7FLK+gpRq4MDt/bFNsFLtuZhemWxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB7031.namprd03.prod.outlook.com (2603:10b6:806:337::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Tue, 21 Jul
 2026 06:16:30 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:16:30 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 1/3] arm: socfpga: Use custom header target buffer in SPL
Date: Tue, 21 Jul 2026 14:16:11 +0800
Message-Id: <20260721061613.8615-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260304033029.10825-1-dinesh.maniyam@altera.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf845c4-d2c1-44a0-205f-08dee6ef9aa7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5MwJ6Q2CRlu5UN+8qkkide5W0Zbw/e8ePy2vsuk5jalKjQHMk5k5zwPSvTjRHyIc8upcG7Bup94TF4BE1lOaHGF3ued/N2ZscPSvk2QreVkkFljeBd+rFsA2CT6oucyF4PL3zWR5Sju0G9ulXry0tThCcUTkyrs6rh3nFhnxc9mor7M4BMI8fPEgyFLcBcOWE2QSHmX17x6Nqzl5JAaH3kgl6FFMVtFqwZK0yV+0gSuqPmhMzxm3vgiXXrPh/cjgJc+8a1J/wobdj+Tz+PIqfeXMDqCoItf13XbRnJ1VTOnsOHWdYZT3/wzHY8cbuBkYuglMKZdbfgA9Fu25uSIpL2WB/Jqi5EAKm3dyAJig0+WH5c3YLf9OxIRFrbwhMB0l5KDf13TKRCOXtOR+sgl1wMPjmNCp/sA6dpG4jhMiUVjS0wDfwWC6VY1HLg1s4Y47tzXr4WHO3nudltxcF43QJGZ17jzJG/qBs41tz4GcuyWamiiwso7JXrrQkLOfT8x+2dxhnKU+/D5ZU/lQ9eFE00u33cPaNdmgbwvnpRoVYRUOIUdS1Wzj66A0god5Wyna2Ql1J7imiTzmQHrzSMb3zl6cGGDjsWagP+MVWW7Ju26sN9aDBveNDtm9BYVu0rLeMwjrp7s2MXrGRCtN95LlwxSTP4brGfG1Tjc59hgICAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sg2benOtYo5yTxuuQcjefhl2FgYuFadBDjiZFZ2hG1twITdzq2yVD9RRW9cU?=
 =?us-ascii?Q?N/WJ+CdctDyJoiVUPGvI4Kw+R1nLMDVueEFibfAksp+pIuDZktqy/FK4104B?=
 =?us-ascii?Q?PgwxDWd7cErhRex8falXjuNkiXqSMRDS12eiJYLUCb4SME/XRLui6j+QAOTX?=
 =?us-ascii?Q?jOZl3sUvWcfKCX5EU//rohntI4sKznD+ZSlQYCne03Mvc6aa6TA96X3sBZIS?=
 =?us-ascii?Q?LK0t5Dfe2A7RWJsv3EwIfwUblHO0OMgV8sKBkHdlFjoWrMAWI46EB145Jgf3?=
 =?us-ascii?Q?VqF9fz2Fcj48oyeUccKElV8PxLYu7zRI0CNsS8C9LgXOhJROgua/rIgSQWui?=
 =?us-ascii?Q?JnfZFmFwHHZkR4URYqGVwCOBgoW/oAwsQjn6T+38g38h0t+Tghsg8q8ewilo?=
 =?us-ascii?Q?v4JIoirlhJUex+43KDda1Lb26YFgiFYYIuF3jXAiYwVxPOYtXdpCbO5oaliS?=
 =?us-ascii?Q?x7oVccI0hUGnpMFuyUsmLHirHfzDFPBhlpfvFCnqEavTZw5oWyll/PfNl5Az?=
 =?us-ascii?Q?XPp1f1Vw+s62gcKogfWwNIRYzI7re2W3KfQbGcn4Q0kVEUwNeEE6W5WFhTnS?=
 =?us-ascii?Q?T11WIBvU8WdhxxCXE8haMLopuU9Ym+L6N1Z0gKPxe5VgZ0sTEsjerFjFqFSM?=
 =?us-ascii?Q?S0fkrtJV5X5uJWAHufZmUvT2327hqml4P2tPFgNDWFYjHf1MwNYOzsKGpKmq?=
 =?us-ascii?Q?meja6vnOgPeFhZz42AuGngbar/z9ZZbjjcpXtHxtBhNwCnioTixsGdVqex7B?=
 =?us-ascii?Q?mfOC3TH93VV524k2qpo7WmY5YBQyl2qphKBoozn0vozZQPsIOz6YgedhOPMI?=
 =?us-ascii?Q?dp1zgk/dPlrdmTxdWQ76Y0Wr1DRzDWcIbO1gZhojOLcB485NX5ljUhDoQOfr?=
 =?us-ascii?Q?zwfsUv31jKGU8nCHkrhK/CSRN0WQI/B//4A+b61J7BYaB1Jr0YIeT86j5jM0?=
 =?us-ascii?Q?LbfXTI+Bvw7DMB3J8orZzlah4dZ80MyovKEOJFXbAjU5XvSesNjiZPAgtQ5o?=
 =?us-ascii?Q?GaiwVkgkQ4euxhfT5avd88uIPeb0U6uD/Ef2go05jrshYnFOCLnIFj4aOy9x?=
 =?us-ascii?Q?hMCiCxP4y97m9sxMYlgMipZmbRoSVrqdO63+mYw06ztjDLmAnPPhnN2cA5hP?=
 =?us-ascii?Q?/fy1giV3Y4MW7CqRgeiVjcuDzhwe1LFscWIrlAJ+YfOy2sn7qlcur8Li/UZ4?=
 =?us-ascii?Q?v5dDU+FffKcp7yD+11f0XFJmIlYYNTIvf3kQHptpb/tVGs0Rq6zTbCi9dkKk?=
 =?us-ascii?Q?RVKB0XNLmYmOx6R/pquRRvZG3pg8M788c9O4SBrdQnS4Qoc+SEwJ2UWhCjnU?=
 =?us-ascii?Q?2oM6lsasHtRTPRW7Ifw4RkVOImr4Ib2kSKwCKeytPB3EC/biurgCM8WckP2f?=
 =?us-ascii?Q?txDtnKhK2VVK1wKKAOCES29xwfbM7pZFR8jt+L2uy2wbVLljplaJ4CtnoDTj?=
 =?us-ascii?Q?AHa2Q5AmZYUilyZM+grpNzeeae+5p0xU2j70WNY/TEu041eYmXNTSuXFI3kn?=
 =?us-ascii?Q?J6JkVa2X8PTHCmIbDJPk8OkrQmYPUOdIbktuRKuwRXLpUOs5degi+0j20gkJ?=
 =?us-ascii?Q?XlQysornmuvx2JwEh+LV6EccfSWcreDMJ6WSHwH6dEBSZ/ZpzRMrrk28kRQl?=
 =?us-ascii?Q?HYyZQZt5HkCp2FOdKs1jxo5S1zWqcTeHHJVSmjhF96VVhe9SwVVvnjFpPRIh?=
 =?us-ascii?Q?t+nHmGmFPLQvCaM7atAa6l4zMDpRXP3rJens166dbNgLxL30P0mdQPDp72DO?=
 =?us-ascii?Q?O3xibz2kIzLPOx80eCo2B7tb88WBGbY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf845c4-d2c1-44a0-205f-08dee6ef9aa7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:16:30.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0Ynizbyx8/EmTyTqkgK/mEQl0Y/V8cKe6fHoCnXLH4YofhItJpILef5f/tZw8hprjN2DLK2wZF8gXqlLN0twtmJBrzHFbvQhLvhGE/C8r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7031
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0PXVZtftiEm8491TxZNS2WLkeSiniZ0yRwHpsMToSc=;
 b=JsH0bMCGNou05Mtf1kPy1O2okTJh4vXXJK4dFTmFq00gwyHjfLELUo8kpCXx6EeGDQNIYMwjzwh+bean5wHqSpu1Olb2Pw4S8kv2yvWi0uoa+o3PyXsrLCt7NnJiU5p83NwSQg6blz/JqhO/oyF33ZS2fq+zrYj4Es9HX7eKMArW/eLdfwf5NYKFu12oAKCtj6gwipMxhin27L61AjYBS86HPNoUr6G70Hp1Uhz0MrljOxBI20+3XkmF/PisgaDMZJeDUBrZY/BPDEz9RKomejSxwphkci2MBPAf+c9ltJVTAEZIxxAsQU/N3egoNymlssAw3yUQJtY0Z/W7WaZRSQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=JsH0bMCG
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="JsH0bMCG"; 
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: dinesh.maniyam@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Reserve the upper half of DRAM for image headers in SPL on Arria10.
This allows SPL to load the fitImage header, parse it, extract the
FPGA core bitstream section from it, and program the FPGA.

Compute the buffer from gd->ram_base + gd->ram_size / 2, honor the
offset argument, bounds-check against the reserved region, and return
a 64-byte-aligned address.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/spl_a10.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index c20376f7f8e..a0729ece4b4 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -284,3 +284,35 @@ void spl_board_prepare_for_boot(void)
 	writel(FSBL_IMAGE_IS_VALID, socfpga_get_sysmgr_addr() +
 	       SYSMGR_A10_ROMCODE_INITSWSTATE);
 }
+
+#if CONFIG_IS_ENABLED(LOAD_FIT) && CONFIG_IS_ENABLED(SPI_LOAD)
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+	uintptr_t hdr_base, addr;
+	size_t hdr_size;
+
+	if (offset < 0)
+		return NULL;
+
+	/* Need DRAM initialized and sized */
+	if (!gd->ram_size)
+		return NULL;
+
+	/*
+	 * Reserve the upper half of DRAM for FIT/uImage header parsing so
+	 * the buffer scales with DDR size and stays clear of early SPL use
+	 * of low memory.
+	 */
+	hdr_base = gd->ram_base + gd->ram_size / 2;
+	hdr_size = gd->ram_size / 2;
+
+	if (size > hdr_size || (size_t)offset > hdr_size - size)
+		return NULL;
+
+	addr = ALIGN(hdr_base + (size_t)offset, 64);
+	if (addr < hdr_base || addr - hdr_base + size > hdr_size)
+		return NULL;
+
+	return (struct legacy_img_hdr *)addr;
+}
+#endif
-- 
2.43.7

