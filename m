Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0245AD2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D388183A9A;
	Tue, 20 Jan 2026 09:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="LrW9mez7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856B683A8F; Tue, 20 Jan 2026 09:12:27 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB43E83A9A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvuDvB4Nn15q0BNB+vVwdFwT/EuJTLbdy59Xuxo64jU1f6319M3PClv1oikReY3tOrZJpHUXfiztCgGuWtharXak4tN5mR+8GYkP+n80me2C1OicrIhM8dsh94TE3cknKow9azUsyYpzWncP4QxORpNWCXkOeeNSI1d1r5v68mrjRfLifrv/l1pJBqTr0gNiQFUNO8ACUllV8RGd4xzvbd1JYd7ljs9qJvrQJLM4oE5zT2EO5XntpXt1H9WCfZRcQEq4YvWEqSqBEpCbME+omVzOuo5PH2t0B/5KNqrt8FdoHXyoFoAwVWhVqDZ9Yrdtk8jrG4144K1tMjnX4ddPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfPqhmFfW6VvSaz1mQ9cH9gifoUcp0j+yOxLilvid5k=;
 b=Vj58ooJELBHG8MhoPxIn1d5pwpvbqq0EitB4vjdUYwvfhuW9p4EKeA4b88kN+IBgau9VXr63CoSlAuXU2vFuX2YByUqWSGVMYb9aS9VH21UsVIdOzSo8K+P5yshcakZhMMSwCOk9x/507A3oxTXBV0Ktgr3VsjUviB36vjIEASE36LQgV6FKnkbaoO/7+zkppZPLwGXOqrmZKrn2vG/zG27YNE/VNa6K7TjwsUPr1/4ATm2lWi5rjZUl+Hbul4fV4U+c2RjQ3vgz4w1nbicCq9k8HVBaD+o4ONVVFTxg3CYQJOVVNXRiQvCxXGHRfuHAP6Y+8qnXmZ58p6wZ8z3c0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfPqhmFfW6VvSaz1mQ9cH9gifoUcp0j+yOxLilvid5k=;
 b=LrW9mez7LWpwZ/Lv5M3n9d8xVWldyYkaGTHacu0uGMvdjqgdzh3FK0IGzFzruYrVUCXUvoG2vNzqt4B58jNciwPQD7eXbhbfayKU9AV57d//CNoY4grGr/1uRuSFjj4iqJo7qe4soZ/PyTji1doUd7YIxWoGqytay1sYX3sKpNEDc0CjhgVuS5L43+1KLy8l7Evq+1SbOu3G/JPbToQ3sd98CF7BjeqrBqbNv568QT7T+wlBjxyZgvz94sxixKJV5PzuZOaExlSWjkWBd5FgYCTv8kYwUPdPX6eRe3dbhoe460dslrYZDMbd1KFFwlL3hqJFHXhGiiVsnAl2/NZ+dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA4PR03MB6750.eurprd03.prod.outlook.com (2603:10a6:102:ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 08:12:23 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.009; Tue, 20 Jan 2026
 08:12:22 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v4 3/6] tools: Fix long option --dump_sig in mkeficapsule
Date: Tue, 20 Jan 2026 09:12:00 +0100
Message-ID: <20260120081206.251544-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA4PR03MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f6b7ac-0612-4fe5-99e1-08de57fb9dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ujBV/MOSme7WeAzWupVLdDqU2Ip5dWOsuOxEpl5hI4oNIpn6psuYYGVo9ShC?=
 =?us-ascii?Q?fAXi/lD4OxQaNEz+dsLBmrD20gteh6GTPRZs4IRGTFgdA9qNxrPDrmbHm+Te?=
 =?us-ascii?Q?KVQOMYORwr/WdLPbAoZYTepRhsaYJpug3284lVw4W4pirWC/37o/kZGRHFY0?=
 =?us-ascii?Q?qiJ2J8PJuPKwmgnAltLfETPLdHBlE9nCx/aZTqRLiM5XnzKR1a8e2pgizH4d?=
 =?us-ascii?Q?Hneae3CSieC3Sb5W+zS5GfJNdCLUoi7SQytTQ/s/6s4dEkK+j6zETlVNf5zA?=
 =?us-ascii?Q?mOIWYeFvkBdbI4PZafDYUXAbitNIk4fnenlR7mO4P50n3Eh1lMUDsnd75sxF?=
 =?us-ascii?Q?xNHMKlan5PnO89fplthxswCoxG52FraxuHTtgIfTFr53AOwztBarAXuGCwDg?=
 =?us-ascii?Q?1pBTGN4b2gkrrj2k7ceqczYRyIBGNCjzCvjMjq/vsL/gEVX/3Dhm486dZcVD?=
 =?us-ascii?Q?Kdhu7oIzgLFwbF9mBzG1a6whBiSpMXtGnhxaTeWpOJh6E6lZqpmq9BpU7Xm3?=
 =?us-ascii?Q?ClFxXvx/85T6qDnytikUsxDYH7z8dciftVR6P9DrND3m2N9V5ZeWrxRi5hQh?=
 =?us-ascii?Q?CMkIuKInF71fTUuQ1bd0pHPynwueO/S1L2O+ZNc94goCRNcwWyUz5ipK1xOm?=
 =?us-ascii?Q?gTc3gHsDrtOr34pIXYdN24kwvupfrt0fqEhHKn5TmZG7PiGHAXJsEFKy/kGX?=
 =?us-ascii?Q?yoNqgGQFTxvCGjMcBqGA9v/iC2E3hdoTKkiTD1Uvc8+yvt/xfbysr0C7v4Th?=
 =?us-ascii?Q?QNNJDCEYDN7wu0Cxn8HAbPzySavyMiSeyp7baFVQkZLfto2UWaCAZGDZKwkn?=
 =?us-ascii?Q?QFqRlu/9dgKJgd6iTNDZOOuwNYWevkXStN3UV9k38oR097t29UEL28wUQEiQ?=
 =?us-ascii?Q?WLKJKJefc/veAtLITEKXC4RRriXA32GGdLmH2R796nAW02Cj10HzLx9AjO/T?=
 =?us-ascii?Q?Xxp4Je2krm3Tt6r6N1dYUwYVyDU8W0t+l1WzcZS6iyncGl2AEStFwh4wobq+?=
 =?us-ascii?Q?SUeH9NFlGE5KdvYwTkR/EaIZ1ynUwhGi3IXo6aewJ8Ru0rvrb/H77jFeb0/l?=
 =?us-ascii?Q?KzgREfD6ONO9nAtbyAgOgn7c12V3GCn790YRnA8HaVws3+dvQgUBcTP9SyLH?=
 =?us-ascii?Q?OFhP+s9tVeCfLYeSYAgFSeEVb/9D9ocMvMQFgJWyt55ggXWyej9EhSBQwKpm?=
 =?us-ascii?Q?CtZJBvYGppG0apiJ5ctEl+Uz1WSQvaHckToIt1PAj8uWilXKPnwHq6JX9zBE?=
 =?us-ascii?Q?HJDmRl7y94bWDgomp8VmEkfA4oBlpTqBiFD/0+GckTm+iUDkvUzaO6VaO9NS?=
 =?us-ascii?Q?fACGI+hWxo5xzxGsscBuQgVQOroSZBx49H35teDv0GH7R2HfuqEYaG4Sn8vT?=
 =?us-ascii?Q?+1pJxNhmf7EusDYI7N55CSg9UqvTCFS/kiwSOzz6y6TV8QGXPFffGBV18cU/?=
 =?us-ascii?Q?6N1HTkMh75XLgVCEdB6tMactClMrE6BJxpii35u3F8vRkq7n5TOdeiRUvIkA?=
 =?us-ascii?Q?mDhp94TBmwKGzjvwRPyfL1yJqH27PjmTVkZBacQO0WnR3CFrYrj5KBRGt1q6?=
 =?us-ascii?Q?03X1+PKk51dGIoAgtisL8CNtzf8XN/XPZ3W+tJbxFDvPNso6PTFqSkmJCHBC?=
 =?us-ascii?Q?3+AX/89zxXPnywWZfXOKKs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+R4gyNQqUBzsNL70cwCzUj3K8VPioHx7ztgX1qtO/PsQkAWa6sCJNRQ2Pse?=
 =?us-ascii?Q?f3W8DprVULYsR9e6aDwV7GuLI15U9MDPNFEyDs0bU2qkif/OMx+ihLiDr0zB?=
 =?us-ascii?Q?t+Dze4HKy3usxkDo8pyL5yulyPWy3wZBZ1wahG1Mmb9smEzh2nba7gwKHRan?=
 =?us-ascii?Q?awRbHsqmXZEmOIrEfyJX1kWYIotUBjkifvBMvIxQC3eWwaP/XW+JANP9KnF7?=
 =?us-ascii?Q?qcgnPURR/bEtrGOV1jkOlpai7bC13UfZbfKS45p0lvpms1mhgsZ06Gv/wmuM?=
 =?us-ascii?Q?aP0FQXhcTOX5OugLaiLeiGVIkv6ij0P77znDoBPmbeNRUGdSdawvInael13p?=
 =?us-ascii?Q?j1oSvHvU6S/HuYW8UX0h4LipJ6zLj/3G1m97g65C3Be1RywI8sN9Pw7Zd3lB?=
 =?us-ascii?Q?csAZzY6E6bWIp2R3Ku+KkLBdq5J2Nx3npxAX5muR8ieqA3Do6oLgvFOswWRD?=
 =?us-ascii?Q?EuHiNt23ejaH2UrYzwkwmdGIlNfb1DaZ2ty7emSTLjIBBSPusRiJZoAa3Bo+?=
 =?us-ascii?Q?AvzlIb2X1MNYYt0qPOY2RLtbXav/u05h3wpkdhlB+ambXIuf8Wjqj2ImsTAa?=
 =?us-ascii?Q?84nUUAR6aT5dulqliu68mlxZtRs41858GJg09HmtO9JupYbeR1gXh6jAYVdY?=
 =?us-ascii?Q?Aaw9VHZXXDnxk1uqHcNmh6Az1EULMIjDCc50IAMdwmncM8iNEwyULM0fYlck?=
 =?us-ascii?Q?MjjvhjBLZZ6+3YUauUEY4lLceek5X4fbPzCV29OWurkgIQoaEnkv9r7kDXZZ?=
 =?us-ascii?Q?lV0tt3DUonDBavmLxAyhsnaiwk9VlURkkAF3nWS9JaIiB1KHkPni9NZc9ctu?=
 =?us-ascii?Q?oNHU7mp6Mu6T+76QFLAiJv3738A/9L8aFkJhcnYwNP19Xic+nBvEOSNP20rb?=
 =?us-ascii?Q?iBIsWQBGUHoDqXXU5dz0eFFYGywcRvCnmLso7JmKIPfIhJdj6MzE3mVt/YmA?=
 =?us-ascii?Q?Ttyos9eNWVn5+twK7+wpXWIwbpNTEf4aVQ+F3QEUoS9M3opSDmcWYlmp2az8?=
 =?us-ascii?Q?F6Nk5ZdhdOKHktABvE3dZZlGWQ8aXNA4+OVoSZW6Otfi0SElUFGev2JuRQUr?=
 =?us-ascii?Q?YcQFRXY7EcYqo7ilO9gMK8CrKZTM5j3HpKmKc72CODQMBuIIXKZ988JGpn+6?=
 =?us-ascii?Q?7TMpvh3tUz/fSoZrt5FViGBGs0WVkOt9Mu2epR3KODDh+gETdacgHPrPSFxR?=
 =?us-ascii?Q?CFCLePnckuOuCdTf98hZvFpiLWhG9GpTGGGcVVCGyvrkjoxHhK5dvYu87eaJ?=
 =?us-ascii?Q?Gq8+sp4o6iRtxuj5f0nUXvO/+i+0fQADuzXGGj27G9Vkn0dNrilJlIoaa8Dr?=
 =?us-ascii?Q?Kd+Ca0T/3FeRoLLOeYu7hn6IfbK3GxJEv5GD1sNBnXw8iHuu8JO7UIST5OnY?=
 =?us-ascii?Q?xh5gkf4/m2qui4jT6/mMBHG74Zk4bU/6YQxx/oVu/PPskjBJjqdKQQazFG0s?=
 =?us-ascii?Q?95yH8WZ1eshN2sxbzcC6zAp7bU+ZqLedOYv0fUyTqh2At5n4QiN1Jhf/8GqE?=
 =?us-ascii?Q?Sc1Fzo8sUyv+HmF/zrq710Yh5PkOdGEnbij6GIRnvuzyE3SN2mLBpHfjqoCe?=
 =?us-ascii?Q?3DJr/6CbnKadl+ljvukYeiuBSLzX93NXWbI5RtqqWzE/7YaGblLZKrDm+Gem?=
 =?us-ascii?Q?VJrseuM5T7VbtbYmePF0oINFUbqDOlO6WmXIEQEyYfydOA4G6ZRhg74N5R1i?=
 =?us-ascii?Q?NtQ7qxaxSTsQI8NBoYmL5rwr5nrK0a0h7Qo+0onTobIXdyAeODtRoRWphqvV?=
 =?us-ascii?Q?zn/QFG0RMA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f6b7ac-0612-4fe5-99e1-08de57fb9dab
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:12:12.7748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUphKotovmD+/TzJMPlfqLh+dPFxGngEpw4hFOlvfpPUiE6aTlEcwhKy7+QZEwURY/kGhlEvdHoyGdmu+0EKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6750
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

Only short option has been present.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/mkeficapsule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index a61557b73bef..a89f11713d67 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -56,6 +56,7 @@ static struct option options[] = {
 	{"fw-revert", no_argument, NULL, 'R'},
 	{"capoemflag", required_argument, NULL, 'o'},
 	{"dump-capsule", no_argument, NULL, 'D'},
+	{"dump_sig", no_argument, NULL, 'd'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
-- 
2.47.3

