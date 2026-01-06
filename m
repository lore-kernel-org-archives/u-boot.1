Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B0BCD0438
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 05:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070C083D9F;
	Tue,  6 Jan 2026 06:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="v52bbfZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3232883E7F; Tue,  6 Jan 2026 06:15:19 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02A083A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 06:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRiiydEMrRB4QZWGnwapM4j+s9ZmvT7r1KYiMrWnjgcA9y45a+LtJ/xdrsKVtBpe/y8Q3WHYr0Jt32EAlFF7qqiuxIHQ2UXhPwUbETdxjALYUYe2CjSSvvDM26DYc2G76LyVi1YMaXl3nw2kUMvVesUOctUxMTGQKHHMIDORMIbiTJJMnaZTkwzbzv8vXnUgWeCknx9tPuh43aRaudIcVSlZbKJx0Hdjts2PVv/fFtyjAag3YmzZlPj+vqgD77hdfMVQTLBbFXSOfvj+/z37Yp2An5xRs/cXEUkbTmGqlvxtqs4kbzj0CwZBsYAoDv4vsclRLmR4E6xzfllcRtd8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZlNgKm0TzruCsy2y51N52hmKdYpPmu1CvO3sSHrMe0=;
 b=aUWb75GG18QjsMgo9H992zh4CkQ2kq8B0x3Dor3thPuS2wbqpGLwQRlAovI9VPjpXaC+wAjNXMo/8ctKviczd4NqSsVJPVUuyg8xaiLmYUVxZxYnwKgz/db6ZpAY01CdSrSvVDQ7vH4MQUTubMXK6zYIOXtXk9ASBHJFhlq78uyh43FbPgBynE4nPhxanBIpTStyr1AdoqpH+G9Y8GdllNG5FDu7pQPh7BzX8jzXzyVBsTOdzn+26whqdXENS9tatQCcMqpk06ZGbN8LpPg0EmnLQbaHSDrVfqbLLjEn8bkyeZJ+Z8jndSAbWxJH/tk0fZYhVKlV+p7Ai97PZj20xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZlNgKm0TzruCsy2y51N52hmKdYpPmu1CvO3sSHrMe0=;
 b=v52bbfZ+dA2nZ5FVDHUYhRIBZVjD4NvULLdy1x4/6Yr3f0JdOQvBpZLNXH1ltLC/cymvQxoq+xn9ePBswotFsNwB/fzqI1OESAk7pb/DEWk6GFgL7RhjkoWvGKwFxWkUbLKoHgAZ89OaH1ErgCJUVQ/7JlyqT70OqTZOuQP/p9tW+MHVvDZpMjjJAUgLlB/+41e9ozXTXU5I7frljwWSqCL/QwCTTINyo2JYroJapVXv4J6FU6Wuy9gZG4xzbrQo2goKuQGO8mAbsxWnUvC5cMxBrLzqvEnZ69m0enkUEyFEEZmTfqMJciRet9bcsQC4Xmyl7WkiiYtgGY92PRa5pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GVXPR08MB11096.eurprd08.prod.outlook.com (2603:10a6:150:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 05:15:08 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 05:15:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Tia <javier.tia@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: [PATCH] disk: part: fix partition search boundaries
Date: Tue,  6 Jan 2026 08:14:57 +0300
Message-ID: <20260106051457.3600260-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GVXPR08MB11096:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c04d1a-d8e5-4d2c-04f1-08de4ce28ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wZSRkkNUqdWBq21wyOOZQdez2UmJ62Kq4QMrkpA98fSC93Z3/y2hC8LccpjT?=
 =?us-ascii?Q?+zJ4T5CW0tvREBR7y4cGIyP0VQ0k4SU/G5i+dsUSOJCmpi/pDi6x56SyY847?=
 =?us-ascii?Q?+ZBGqVlFS8ZjYjV2Owp3xkGoBAuCoy7zIKRg8WHj6VTrnX5aU0bvb5ksMKf3?=
 =?us-ascii?Q?WHjUAb+4NnPUWbTJCrQ87XX9LIvMIhONjzes+TD59NAb00eNGwYxOr6dEmPg?=
 =?us-ascii?Q?BbpYBZ3TBAKzoD/WQK5R53dZAKkukfy1oZFuTrepNu7nnKogpEdlRarQY6/q?=
 =?us-ascii?Q?A9iYkMrGqHuw8LH5MB7oV4/4FTb/ETIUWAUaEdJsKY2Xon94MLFpx+hX1l1x?=
 =?us-ascii?Q?JneMSIeLP4ediqJsfCUW/fH9OKigF8DxF1rMa4JLTgQa9jfQg3ZLHzldD6Dy?=
 =?us-ascii?Q?RcBGXhXOoV+mFwYeHdlquq6nwMrCKeP8aZIt6EbeVVtCl2I4X8ycLbOHE562?=
 =?us-ascii?Q?O8+N7t0dtdzg4nuEg684lgJabJ4m3KOGKQvj+F8VP8pC0A+ETkoQd45CJ3PK?=
 =?us-ascii?Q?I7d/ed2EAAsWyPCsAvAaIlS6pxCCEmuiWxShwKowBEJyuyslO706wLznqZiB?=
 =?us-ascii?Q?uVrdepEGEjhCBJMvv11BCk41CP7hRSCbXwEwOO1VIaQau7ht5VXryFRdYOYI?=
 =?us-ascii?Q?TzDKdpyajeLC09lrfnX4wttg7hGeWGWGxzwD/z4YypjRDK2tELakb0VVIqAL?=
 =?us-ascii?Q?YIL2EOxIyUAufQxWYe0dn/Qju6sPnTePBbNf1YJ+B3EOY9tXKcl4IWeHuCHg?=
 =?us-ascii?Q?EN7JHb0eO4YDO5mnx9deJpcmoEU1bMORG33tjgJV6Eb5zV3JD8xLG5HMghq6?=
 =?us-ascii?Q?HvEHjEcwdzvzNYd6ygw0CeIrDarbOYuG66qDMW5V+YYB6exIr5Bo55qUlJ4U?=
 =?us-ascii?Q?7UPOODyBD6rZl9zdCttfq+esUGUkhkrmS5OvgMF87oPDNl0avUus4t4fVQrK?=
 =?us-ascii?Q?t/aspUA0v+5s2j/P9cf01MO14p2WKVwTa4l5mYtchNKQR4f8raBzRUEcP/7+?=
 =?us-ascii?Q?0Shb098S/iw3fEf/dlYkJxnYSPKpatto2f3Uhh0QFWPIQv3QSmU0iCfT/mhA?=
 =?us-ascii?Q?OupLMIn86rwPIuqs78MErVmsjnEPgVaLO6MH0fqX18Oq9N4oBBdRSbU5NV+Y?=
 =?us-ascii?Q?Y9tueT5rLheibhFtHWP1FXEfhfCrkIH18lGzhxSZnLsUBPJPBq71ucqYSUWX?=
 =?us-ascii?Q?Ode6O3Yr5fTJWtZNXahnEjDip+Qqjs83nKtwsMLNDA/9WvnItg7aYb/32F9r?=
 =?us-ascii?Q?E7BxSbHtkbn3QzmYRy8vlcZSzbVCRnPBTCFOYQWWpW/ELf5JuiLFreKGuRNs?=
 =?us-ascii?Q?T3b+bbICWM+QXOduhGrBW11Gx/TQORrcQBmlskPFqtIijWMrs+9qQX2LnKgB?=
 =?us-ascii?Q?aZg90GgM7I689kc800iT4rBKW2zQZpssALC9wB1o7nMFkUwwZsUmzcicOHEz?=
 =?us-ascii?Q?k2j/HdFrvETKW2oVuBaMO+Gr6go21bSjzGw+lAsHetbTqt+jhSNlmJ0q7+a9?=
 =?us-ascii?Q?CyTAvqzxYT5wfvj4UhC2bMirDskU/NtqYtCLL7SJ4GCcsfAPXe0NcL41qA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0AAkS0fD8aayGqMO58LtfRxGFGBZWLVyb+RXn5AVH03b5svaFyKBFzniI2T?=
 =?us-ascii?Q?CdwHu+S8YGSx7oyQnDSFMKESus8OqIBE4tonxyCF/C83Trp6Pr2GQLdbMjct?=
 =?us-ascii?Q?X0q8HSRi7fW1VQCOl7F+xeLWbuqsSu8mIpAn2syAHABAbCIj/zNnBJokB+Ah?=
 =?us-ascii?Q?K5M9y9CdAH4SCIbMcs/nG7Y7aEamTngkGgxhefQYwzeI4lPhTM2Ub2NikhVq?=
 =?us-ascii?Q?bIM51KeYzHYDCUSuSHpB9oGMWww6dsN9tukrTOKrSDw5uQCV9jZTN1NXpW9/?=
 =?us-ascii?Q?AvqwYwz/QEoLZDdcCC99gAX9OsReQTue4MVCe6cxbeXfWRxRZFjjQpLVlX0w?=
 =?us-ascii?Q?1wZN7HcwdExQp/TwtU7g2bqAI8WnXxDgtFkyaLY+4xuXorov51HczrE2+0M+?=
 =?us-ascii?Q?7GkzEoQXfH27Wv/Ox220qdtYahtslqTmjGNS7eyaaSFc5vK1mQccspIaYA1a?=
 =?us-ascii?Q?LmOh8TxsPPI006ikB6m0PizKveLejnJ7jEPdjURmrNnaDs5QEurehuweFpT5?=
 =?us-ascii?Q?qXCvrK8yCMIBx5nqvFGtv88LBYAjN1INO2PZ0FZgns34czmVXurkNbW/kC+L?=
 =?us-ascii?Q?j/kNBXl5ft1lXSd6UtIqA7/8GKvxRyhArf3hXhcmh/4ukqKGHeVJahNS14Al?=
 =?us-ascii?Q?vSwnFANdzCT0rgix0CYw6SkZ+8MQVzXpml12HI7OHYr6bUfLOFE5tsbs5TuL?=
 =?us-ascii?Q?l1cBHabuSggfdfYRJf7Y+BiUVIyPOOXxUSO7qgknTH44plR4Xfm36B2AZ1JZ?=
 =?us-ascii?Q?+GBDKFe0oJJeuWiuRlMnMcQWvazT2pdCDGEXtMVOoDYqLfAPCMPSkf8UCLuy?=
 =?us-ascii?Q?+/9sJniXShPXK3FPVslmmtA40lwvthM8zs+HlPDmoQOO3XPlFruho3BHHof4?=
 =?us-ascii?Q?NqGIfGXDXhEEuCynDIS3X+hx/27DDxKFblV64P+IhBP5a59PaUbb3pbcktcr?=
 =?us-ascii?Q?xgJ4H8q0BWgzYLZF9wpU0Kcrp8mcZLdI5iJZRJWqVNkf8FFeqJDPqWtA74Er?=
 =?us-ascii?Q?WHpVfytnJwETNQFnfYDktsILISEr3QimFAra2tUw3GybzRysEYXtINPqGrat?=
 =?us-ascii?Q?B0lE8RK31qLEWAe7o/X19uzACtTlwJ5BPjgrM/W/6aOIvS32iOUAlPO1VpO7?=
 =?us-ascii?Q?dQl5vCkjgFkN8MiMWG034jn61+wA1RkkYvqdJvak2lPPdJdpEXpU/y4to3J0?=
 =?us-ascii?Q?3UXcYxu14DVm/RT7ODlA2/oILaa2F9uUxl+xoBXCOUw7DXJssf9fe7Dqsspv?=
 =?us-ascii?Q?F/E9U0gHHonzecpT8LAVkLocQ2zJqygr0wfK3EYFhNV9SbigXy1PrxwivWgM?=
 =?us-ascii?Q?7nlB5Z0QLLo5zpCafwVZ/uG02zl4bF9Mo+By2SvRwzQ8XGULZwdj5l8qsTKX?=
 =?us-ascii?Q?5EFmEGCye4j/qDzwC3SsHmJTJhrwfBoqUgxAho1s+3gEAz+mwPBo9Ieg+HQ5?=
 =?us-ascii?Q?ND36wHBo05MKYcZfXVhUC0bFHf1/akzitJAXFB+4LAuqYxLmgshNrk71/yIB?=
 =?us-ascii?Q?8s3DvrZN0GxvDlIrD9mQ6TjeDoNaKUyN7KfX2tlujOSqXUqqBQd6UGBV2pcc?=
 =?us-ascii?Q?hMaVPdZ0YxMKcKIaYgJoK8f3Ub6VYG1JP4kWOobVGVyqWfGlWzitb3YN035h?=
 =?us-ascii?Q?gPWBvtD7+SwO27qS7pRhDFUeSDoFAtgAA0idTWCTyQAg0NCTJHwt1hLOp0xT?=
 =?us-ascii?Q?aBBgzCxg4j5JGacJqytKR7myQjDGbFf5tHPEjpcLqUsBI/zIZeV+V+45yhvx?=
 =?us-ascii?Q?Zn8IZLeqPlVS+cgW6nIoUO1DlVS71m0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c04d1a-d8e5-4d2c-04f1-08de4ce28ec5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 05:15:07.8102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ8F0HCG7vLMC/ojhbpq/vEss+AAgNHu+vE8gM4bNDvFnzwqlXPR/IN+EcoYq21SwzkyWUpXDwbUq8UIQKnU1LAHuCcwYanFZoBk7/XZqlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11096
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

GPT disk partition with max available number (ex: /dev/mmcblk128) can't
be read/write from U-Boot using read/write command. Here is an example:

  => mmc part

  Partition Map for mmc device 0  --   Partition Type: EFI

  Part	Start LBA	End LBA		Name
	Attributes
	Type GUID
	Partition GUID
  1	0x00001000	0x000013ff	"env1"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb02
  2	0x00001400	0x000017ff	"env2"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb03
  .................
  8	0x00158000	0x0034bfff	"apps"
	attrs:	0x0000000000000000
	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
	guid:	5452574f-2211-4433-5566-778899aabb09
  128	0x00000420	0x00000fff	"fip"
	attrs:	0x0000000000000000
	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
	guid:	5452574f-2211-4433-5566-778899aabb01

  => read mmc 0#fip ${loadaddr} 0 4
  Could not find "fip" partition
  ** Bad device specification mmc 0#fip **
  ** Bad device specification mmc 0#fip **
  Couldn't find partition mmc 0#fip

The error is caused by invalid boundary checks. This patch fixes an
issue.

Fixes: 43fd4bcefd4e ("disk: part: implement generic function part_get_info_by_uuid()")
Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 disk/part.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 49a0fca6b89..4923dc44593 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -674,7 +674,7 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	if (!part_drv)
 		return -1;
 
-	for (i = 1; i < part_drv->max_entries; i++) {
+	for (i = 1; i <= part_drv->max_entries; i++) {
 		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
 			/* -ENOSYS means no ->get_info method. */
@@ -709,7 +709,7 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	if (!part_drv)
 		return -1;
 
-	for (i = 1; i < part_drv->max_entries; i++) {
+	for (i = 1; i <= part_drv->max_entries; i++) {
 		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
 			/* -ENOSYS means no ->get_info method. */
-- 
2.51.0

