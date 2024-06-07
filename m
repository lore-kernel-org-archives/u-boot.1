Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30546C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 09:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD9287F6F;
	Fri,  7 Jun 2024 11:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="jEs6+DfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81CB08822F; Fri,  7 Jun 2024 11:26:21 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74D7987842
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 11:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS5yHvCYJLTSOsHUHZaVRY/EigEI1E+oaB/Kqj0T/9SeJkkRs69V7EpU4d0PEez0uIsxH6GlYAEuATirVLwo7rnvJIgr0yhGyCpOBzn48KAi16pGHlQr40rlK5FAFB4+UuDblc5iqundpnlydyWkesrHlxaqKlMgr19gPwX1XgsSTlgO0Yx04jH2Rv+Rj+rOX60zNrvINBun46aO32bszTm41pddEBZZRBeQASBwUeIT85lcfSroMDr6/qIjLRuxfpY5up7l09UzQGkGzXDlmFLCYRUGP3oTziP5Lg0jZEhOG/4JlUH25soUFbkvooRNlzgp6X3kJykYGzIZKuLhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUL9tK1Sre30z5yOMD+50pJOnne40hKXZymLcdTPFy0=;
 b=LfZDRuS1t/8tuGlZ2PnpL3mzdCQtcHo2RNJY9SJuvwhDLGkoHkpWWz6ZkoRAavIyj7nNbCWXWXY5wfpMw0tuLF3SBNZuauDgj1EmP+CKWe//B447mJwQdN8Ebe0aQaD7hPxG65f1iphUe7bjmBxLBhghmprk0LJ0UYCCn2ZOOWcVw/SQvRidCC7jm6ZiwCf/774BwvVoUDg1qSET24xQamvtZZYxXvLsYlFv9i3q5bX7tWec9doIObydqNEAliAmAYz9ISkIJJDbL7rq4b/zv8GGdu20Knh7ewrg8R37FU1MXJaAL8lcusgSbd674i8LhxN3MCZrqyPeVt2rBqtjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUL9tK1Sre30z5yOMD+50pJOnne40hKXZymLcdTPFy0=;
 b=jEs6+DfZ1FjmWqjYBDe3rySCF8NaLt409NEWBniN4Wkogu0vsneZp0odpDySjFKmW5hn5aZp6iul5A/qLU2w3e6LrsNN1IcxEB1cHBzYsJzHkwubJGHweIgejOUhdJqBBR8r9W4RozSPtQrBBmff0Chw/n7+pHplnrXt0YJiGKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB9193.eurprd08.prod.outlook.com (2603:10a6:20b:57d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Fri, 7 Jun
 2024 09:26:17 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 09:26:17 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 0/1] Enable reset_cpu() in SPL for ZynqMP
Date: Fri,  7 Jun 2024 11:26:07 +0200
Message-Id: <20240607092608.712996-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad4d88f-670b-415e-0b0d-08dc86d3e248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|52116005|366007|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nk++Z3mH43myFxy40f6osRCBZHYRjSzbQoAoCoYCDIFHt2FTEi+ZLqsPdeMx?=
 =?us-ascii?Q?JKF4MYvHA8EOg7eNmTDFDpZVRHEVjcRPnd12Sq50Y01YI0xUfzXkDwSGauLL?=
 =?us-ascii?Q?iQcrN0MLEmY6F2oiJXydlxYfZ/KRQwBPN/XWgajSrWQKNNMbOu5mqTMllTDM?=
 =?us-ascii?Q?TXkFeLVE5W3iTMOmI7hTzKvOVrZrHtqVszGJTFj8gYG5LbE3SdoUumcqPvyR?=
 =?us-ascii?Q?/QV0C8nT8F4cL7PsnhZghYeh7hvJEwmwQ7/w2M5tkz2tuZkxASOI0nHo80XV?=
 =?us-ascii?Q?zhoUlT7GUDkh+uWFH6FEmo5h6599QswgbV2ogP5kGy3dy28YDYF9sJAHpDeo?=
 =?us-ascii?Q?WZN9GQDD+mhwrHOq3fPpJNfnCzjP+Ew2pouh+1r/A/vtCQDjfc2xC8dVznB8?=
 =?us-ascii?Q?Sj/FSA/5ovVT2vfVOn1nGtyXFDJRou35wT6/I6pzTTzTNFaRJE4pfey93miD?=
 =?us-ascii?Q?BlTMbr3XiJQtJ+ktgF9wimC1g7htaF2mGfs/3sNsE/y8qE2trVYMGPkz8+ME?=
 =?us-ascii?Q?3XKuAcC69ZTpyEs3VeogpI8ZUCsC9p1hBq0UvjetPz4eX6yjt9c7ZZI0y9aO?=
 =?us-ascii?Q?nK/7ZvOxpSZENMxmq0dWnVO/SrEV9JUnbPi2LmNcd4f1L2ZhCq0ypBWzxm4p?=
 =?us-ascii?Q?QNKvLR3mIvG0pyTe7+dQaHbZZiflB8lglg8gMBlGXeoIcla3QYMuZm7U5RDr?=
 =?us-ascii?Q?eeit6zrGK8HD0Z75/z5w3CMXJW+1yt6+o2NCCeGiCPpuMc1jUxrj57yOutEA?=
 =?us-ascii?Q?HD4Mw0UWrnkIVHmKfFIjLOQbJ+fyjOHfXPf23U6Pt9AAmsKbV+MU5a28smAy?=
 =?us-ascii?Q?/lytlw9CguSR9KoaoJ30VdUsq5RR6N/Ap/2Bj9Vl0hxFuKDIPPZLuZELs58r?=
 =?us-ascii?Q?kW14n0wgLU1MFTG0D5fx4u76vM5Z+S7PN40C8+NMVwERY11ahRGX4TnsESYG?=
 =?us-ascii?Q?IbkEjYBWa1HJGJuSbgERS4OIgKMkvmTIflUoeNbi+EYrV0P8KkUqmzZZHPfR?=
 =?us-ascii?Q?1xKMg8yzDrtD2swmqdT6FYkVN0qyj8Ez4wqXG+RCDuZQzorgqMwoBKwFRYqk?=
 =?us-ascii?Q?n4FU46ZAkTNIHCiy8tqbfY7/sc/KaJHd2J21cvq3y1lKYBsJkCigErTcg6Xx?=
 =?us-ascii?Q?hUeu6RUejvgBvYcfmQe4+kOnOu7PqxPxMVFuWWT+Fn6x8/gaSG/fuwz+4bfc?=
 =?us-ascii?Q?PDEzDyjR+1vv06V3jhbgQoucleAyAQQzs0v9F+peQ+0AuJ3myZxbRJWDKlmK?=
 =?us-ascii?Q?3Alph6fjZg/zFn7JyiZLsP51OfHK6rXhMCMBeg4kMVxswuWQD6FSaKFWg7z8?=
 =?us-ascii?Q?yaGbWQqvfJXNu9GvwrtAVbXUcWB/X/MSh7kWoAhrzx4ai5gJ0gF/Fy3JIpqO?=
 =?us-ascii?Q?6Wdf8CI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aK+ySnksKeMH4onWXKkXoY+C3AnypVtxn6/achDwqodhNp5/7ydrXsdfeENN?=
 =?us-ascii?Q?zuX0n6tD+5zp8DAssXwgRLvJbfFw9tSyh4+t3iOdqMb6hcP2LmRHdTRARMvg?=
 =?us-ascii?Q?Su31v8DHKjzxCA0VIPsOP9LhcokmTK7IA7xY+0NQT0tomYGZpM33eSBsnpRT?=
 =?us-ascii?Q?OwtFYkPp4896rsKGKP11GVXyynfMwJxpElb08XU+YfGCtmivgzy/7noE4FdH?=
 =?us-ascii?Q?wGvcI5JGmGfLdr0ZMDkFjgAKLJJoq/vGqAEecziECFyny47yy/O3s5XQGBLV?=
 =?us-ascii?Q?rEVbVEhNpHGPLwOtaLUy6iHzos9GySMauL3cfvjA6aL5kQ80cynBEOWxJhQ6?=
 =?us-ascii?Q?gpSunoQ+rSKY6qCV2PyR8e8F9bhTm6V5VCcOnI6yYEAOjHxNsmqbsWOyxiau?=
 =?us-ascii?Q?hA/U5iiOv0ruRhoEFa6ZyvgrVWDmPb37VecHb0d9E+0UDpr9C8uxITOcftjv?=
 =?us-ascii?Q?m8IRmhYpEFlWvmHDBydIEZEN0GwGICbxkdtqgbsDbtqn1U4xRFYukV5QnGb0?=
 =?us-ascii?Q?KXotjT0s9sJ3cn6FXpRC5mkvq9DdbAy9awYlkXh+CoicYSlSpOHgznQ44U4A?=
 =?us-ascii?Q?1686295GJiJGkwa15QzFuDpxt4OH+sHUcxdH5DX0o4tZ7lHDrs1+g6clRCyf?=
 =?us-ascii?Q?xA7Igxdf42YO4JRYmNLvMlxtSq11HNNeGSBHqQQCePLFajWFL7OTEQ4AZxQY?=
 =?us-ascii?Q?DTxtry4eOsj1CbEtU72ICgEeDXV7jzv0oBjkhuTDGuLxLiJ8UIXv24Ft41L8?=
 =?us-ascii?Q?sEn7PnCB2mGWzGK/a/shNf5RjS9Ww2zmanHixjk4HBomhiAr5y+SZzUW3ThV?=
 =?us-ascii?Q?GH4w27UabbnSUlKvYSJmmK6vnpR8oeJTJBhHe4scNWoL3ifijMnhuiq+axUg?=
 =?us-ascii?Q?4hIMNFPD+NCLjclLJcgsxoEjPD8F+S09rSjBrG9E6NwIVpidTbtICU1kA5ln?=
 =?us-ascii?Q?3Z9ySMNQJg6bpd0tkxhTvQy6JiiZbx1AhhWr0SrDBqLWhxLdopa9fv9ddNrt?=
 =?us-ascii?Q?f+jobOL6YjlNot/2BEsRUvtID2+RoML54YtriSFZLv1UOBI21GF32F6TqC8x?=
 =?us-ascii?Q?qNgnkHKHmQ03Uz4EUNgZfi3H2FyrDdwQEGuPGBJq8kmEKpyk9YnZ1FKUUlGb?=
 =?us-ascii?Q?zEw5rvg72rLvVFmO5Z3iOF3fEXP2Ms4eYg+QzP2nf1zZBbA30RAWPWB4leXx?=
 =?us-ascii?Q?461TfttC7rqqjHU6kVzHKN5AfV5mpsLWzGrHYslthUuTKv6KwL+2WhriG1Zx?=
 =?us-ascii?Q?8e83aVCqgA3KC8opkeYc1ZAjHd845c2dyqWPpO0giM8XGeoKwZgFIIeNhc8s?=
 =?us-ascii?Q?ZCVy0wKZ6JsX17cThkIFo9pAJAg4wTfnTZ/LvcEouJ3S/PoiWpqwjSuecUrN?=
 =?us-ascii?Q?+p1RpXm2PDf/D8d3zBb0Cm0mH+1dQ5AGE20Z+Kio76vKigZqBk6qpq//hOks?=
 =?us-ascii?Q?abBlp2H1IW4QtPuo5Wl7JEdf2qRFijXiLDRC8pkJPn2BjYtMkF5yrooWFmFr?=
 =?us-ascii?Q?WZN97auOZ0Xmki9yeDO9kkkGR33RrjMdS51F0pgItm2oeemmQ1rW8NkE2fcb?=
 =?us-ascii?Q?GXc0du7LWJtcFmIZJPc380sSqpr2swsp8OcaD9pQ/H2xL7hulNozoDSFrHCZ?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad4d88f-670b-415e-0b0d-08dc86d3e248
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 09:26:17.3732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVnfVfqsG27xPeJxzYX8+l5Wj+bx7C4RPkVmOxJCiQ+8aUjozh1R093TMoELg/1wfy75h2F28nl+B9T86J8TnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9193
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series enables the CPU reset in the SPL for ZynqMP based platforms.
This only works if CONFIG_SYSRESET is disabled. This is usually the
case since the the regular sysreset requires bl31 firmware to be loaded
in order to hand the sysreset over to PMU firmware. In SPL we can talk
to the PMU firmware directly and request a CPU reset.


Changes in v3:
- Use 'ZYNQMP_PM_RESET_SOFT' directly
- Add comment on what happens if CONFIG_ZYNQMP_FIRMWARE is not enabled

Changes in v2:
- Drop 2/2 since reworking ZYNQMP_FIRMWARE dependency is out-of-scope

Lukas Funke (1):
  xilinx: zynqmp: Enable reset_cpu() in SPL

 board/xilinx/zynqmp/zynqmp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.30.2

