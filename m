Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C87AC5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBAF082998;
	Wed,  4 Jun 2025 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XbyxlUP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDB381FEE; Wed,  4 Jun 2025 21:56:23 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4694E80BAE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOTUJdcaKfgxpfJ/u5j0wDj9eKpDzGAUosJttXzMlOt9dyT/hUJtiOwPeeVvgWDwbm7d7OmaSEe96KPCGxr0AnAdSJLKcI3z5gI5t7UiLzV76RsggahSlQBFbULxEYQzZpltdsrtKFs/IB9mdJ8JAkKXyFLweu5s1pXaNfvsyE87m5f3htQt/44oxrRdmCJnJlSDnooJ/mU6sNX+06eKXOEHzy2B3CdVUqsFhUDQ5d9uUCtoYam2y/6OmEOgBkDVn5o7qWHD0JvaU5jEqprKZwpTym1+Xz8SAH/qwLnJgFbu/Vu3PDnwR23YX54ANQ8L4mtPc5PUtWAuQGtW2qXQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc8tcpDMJEw8kCR4W5QekbW78nsOeWuvW80OpQJqh6A=;
 b=LZasoqYAzV+zvExhx2rdVg92BjRv/rrQs+h0Y65GtGf15i23QbWYTmtyWpQlPWq7ZiUXjfJGWku3VKcPm/N6YZQPVFe6ksa7/vmdvYUKkAEC1llpCQyRvtFzvUwQc3IgUlI3NFNfaH8tb105Nn0Zs0WjPcFAZY0DOxErMnl9BOuL48ZRcFx+H2f7IQm9fkbD8Uan6oDwBAN0c7ecupU9KEb90eaDemLzpRbR+DCgbIoj6ESt7HAB/6bEYdwctHMlj0/8W7AsMuA+zbUTw41EHpZxe1RivwFr8truEBt4SwCpVrWQLQeu1Ctk3dNKBQrgvuBt0XMupW16H0ORTd89fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc8tcpDMJEw8kCR4W5QekbW78nsOeWuvW80OpQJqh6A=;
 b=XbyxlUP+plPcAfWhU8XsZhxWClYvd1QXkJRanVD6jVZKQqxzXKPZPBMZtVs/CZpRJeZdno3tCbU9K36Bw69t3iApw+sCnMVQ3dhuYN+disHwpb/jwJblIYpTAwHRlYHjGeSytZYbEIDjitMIruoaiX76LVFaTxfgJdwjKJ36XG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:18 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 03/12] mips: drop volatile qualifier from gd pointer
Date: Wed,  4 Jun 2025 21:56:03 +0200
Message-ID: <20250604195612.2312979-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6a4189-e1f1-4b0d-690c-08dda3a1df1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V9z1DJ7jp2gI2yBbBfWzVyJxulnbYRcnNZmneLDPp4VDF1sDs9aJUwk0B/BZ?=
 =?us-ascii?Q?FYv7x9dTT1mwW3ZS+JTL5M93ApGFSzg7LWfkwEDzSL3kSV/uDir7I1oe94c9?=
 =?us-ascii?Q?Fj72TTxiEVfjSm5HcIw2MKmRSYl9K7RtW0YZIp4EEl9w7UMJmsmgs/rec59P?=
 =?us-ascii?Q?w7W7mMP0+4soHc1UXEO1UtDaMm9Vc4hPg4hG6lH1zRyWvZv/5FjAG93D/h8i?=
 =?us-ascii?Q?Muy9tYGVipuBsq2c1RDFrqd4YlmLT3nsfub+5IG/y3znKTjiqg7ZR7rViqER?=
 =?us-ascii?Q?vquFSrxDv39w8IdYJ6dMuqxWH+pDz731fFBCpLF/5WqfiZLMbC7ylHq+VJco?=
 =?us-ascii?Q?4yItWuGhDPv3Bfj8Tc6u0pN3NzXs/J+8AoPwwQsqlFXnWOBPYAUUbReILrM7?=
 =?us-ascii?Q?1qp2wJyN6E/uwKWWzZr4WnioR2okarWyfAF7C65PoMQ+LAF/ehT0MRVUhtpX?=
 =?us-ascii?Q?GHJFE5xcr6wCiUfFCKRscGaGsLUsfn0yw8LdJGC+Y9B2RKfuJd6RNGleBYfX?=
 =?us-ascii?Q?SyCJ/zLU342PCUutgBeALQ1l0a0W+3G7lnzfh613VeroJmR3upialUANZGuE?=
 =?us-ascii?Q?tvSevkTCssZAMr5lm+tmPziY0tOoSqmqI0lQxLwPN7ciQKP8p/lWQhJVhAhl?=
 =?us-ascii?Q?HZKbNSvNFxVan4R5HqP1A9VrerMvFp+PpN29Pj8iPMojFapzMK4W0ucnN15v?=
 =?us-ascii?Q?C29wiNQLBYmzncdUgT9gfGHl3gz/E29VVyQ9lrEbaVRgp27B6vINOfM6VO1s?=
 =?us-ascii?Q?DuK3GwEetnz5HWi6CiQMdObHiFOkox6fzsPZ3Pdb3Q3r91/1Ew6NADRdR8yB?=
 =?us-ascii?Q?F6KUpEW95/cXV4qqslVyr8UCV8YJfNUb9bV826vJ8kJzH5oUMlb0Tjw/P6Cy?=
 =?us-ascii?Q?QemqhWt30usCsMn4DNpjC7/X+cb8LJ8B5U2pjgfAr8d1Fgo1mYya2H9xMGC7?=
 =?us-ascii?Q?q2Qa+ntLFeONY2xysvgDkaP8U147FEGTn8e7oMW1S7rphCCNphK8UffjNe35?=
 =?us-ascii?Q?jmMt1VJf7JNwWPpeWrpQLA3hhutwToC1irhJmNbfKGH2i2SZe5ac0Phgqtx+?=
 =?us-ascii?Q?aNEflzYMaYTGduBnTiTrwubvWVBr7rHP7YZuEtYWSBabLDk7KPHB9mRTYO+S?=
 =?us-ascii?Q?LtZvr58aXdEL3EtNooD5tBmGwDaJb8+zw63ExvTc2+NGWmf+g1LeQ3+B8lHc?=
 =?us-ascii?Q?TKeZ6HolPW4juZ0ed9bqUDMFGgV3G5BVD1QPcdrzHkuk4Ue3ioxkyV/91VWl?=
 =?us-ascii?Q?KZPdLyQzuFt4hZs0uHnlo4Nc+eHn0G6aARAaovPUJgOknmBY1qiOXe0W5wn8?=
 =?us-ascii?Q?BoVELdY9JlsWjpLBZ49rR5VrYGceAvBy2HOAwZKwwg0sd8uEV0thtWjhlndM?=
 =?us-ascii?Q?ysEXyaYjfQODOCCgLOQmnOcDYa780Q2zvd4ak//cZZhtQwk9yO1/nV2C+JgO?=
 =?us-ascii?Q?Rxv7/C/w6CEZw+YLsSqRCN6L7Sz072NiKt8I/gDOPR0yGkjToEXqpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DJQQdAzajZs6CT0dGu613fA6p8FU6MRNHkEw32VZWc5uCintiIVZMjPQh40w?=
 =?us-ascii?Q?ucn7olV2WzbadFnLc6bohrnnDgJNw99urKgtpZXzTIKvgZcIn+nEVQixcP2I?=
 =?us-ascii?Q?pLZJYR9siCRqlFI+pF7Z5ajwvByP+ESybTUl+5CSn+cDy7PZbQNnxG/MUkkq?=
 =?us-ascii?Q?TP2nn6jAwHFGqFSlaZjC2wFC5LuQbXoVJsEw9GBb/gdZo88j6DAP7qqbiCau?=
 =?us-ascii?Q?m7jQJ3y+V7Ii0dmsY6hiee65cOyk4XHsPzyp7kMn/W2UBTNBbcyIHWb7E+JY?=
 =?us-ascii?Q?S0SXXCjioX86Pc5E0QDQEvGSo/PWH1MqWNeuwmfG2/rHhMXjGGEFtVP2CFmc?=
 =?us-ascii?Q?cSPftpQJ61vgOcGG8RTgzPtFYOhku8StpR9moKHoHiVzZ99OluPOpgjVLSQb?=
 =?us-ascii?Q?brjdajeplLiUnSA3Rd1655ZNyKy5bnojyvgZcoMrjEUZk8+jWOuJiGRE4B+S?=
 =?us-ascii?Q?twbuE+uZqVpU6yAXukbjIvf1SNTv5B3dBgaQtb1AtOfq2sYPQ3kUFZrNzXf0?=
 =?us-ascii?Q?jVgddO4q4QvT7WHL8C7MnBp9mLuRnz3AnS4LcEyUufALcqx1DO22Fj7tuefb?=
 =?us-ascii?Q?NdD5hZl++inxWnaPFjALxPRQ/wD2kXa00hIOAnP3UUQZwe9JfZADPTu4emGP?=
 =?us-ascii?Q?6pBZb+ROs9AsY2LqU2FlimqY5UpvBOD7C4OI5ycQbnPGJm683Esp/N0eY3Pb?=
 =?us-ascii?Q?yIXxS2Qlee48mWpw6OiUDKJhf7fa+Rn31Vb9IIHOioClqja2Ze31Fdrf39R7?=
 =?us-ascii?Q?XXAH7S9YRBfb0zwRLyExM9QhLuccUxyV9qQ1eU5FKZOBJBnwr1IydvzI6igR?=
 =?us-ascii?Q?w9v0XxTHgYnARy+bK8fCLR2XojXRRT9sceSHLF1aC9gdiscrltoBIHU/I45k?=
 =?us-ascii?Q?JU2Iaz0NbUAyIpMYbIMQhgv3Gf6GtcvKMycekWyEiviUZ+feMWc14/HOTuRj?=
 =?us-ascii?Q?/lKETyq+SO0LM1uxpowqVOLec+2gtCX896O8iTa80YlNiU5O1KjOm040yGtu?=
 =?us-ascii?Q?W64oYdK54ffc1RSTV5qkLUfnVBoHNd9x7SOSdUOkwdFA22aaiyJJAXGyLTrg?=
 =?us-ascii?Q?2qHQBrYzAJ/0wjdpxhW96U+G/m6BpnQxedZPJDCSocC915UxfCRYqwby+MWV?=
 =?us-ascii?Q?BXo32hfgNPI6JMIp2P4T5JHZj9fuDcVULBhoDsFWO9A4PPnCcj2L6yzzVrb0?=
 =?us-ascii?Q?8AudC1Y6rEKvJQRZx1NCTXAxgXPv+LdamKu0qe1jLsQ5uRAFy78Hkf9izjcB?=
 =?us-ascii?Q?bjwIVz7F/tRNLMzX91Lm83lm4i2GAMCjkLh931xXdXprwEOWzsQVxeZTOvii?=
 =?us-ascii?Q?QdCAeq6MXi7mUuCTGAqW+8MYRinXpzlhhN+1YRIw2PJAWFP5meKMeFg/JaEJ?=
 =?us-ascii?Q?Sqgj7op+MrCEtYWrH1YV8MNxDMup5SFvAoEgRQyBHKgBfbywQm9yMXuWOI8D?=
 =?us-ascii?Q?Ujgj+WHVOtXMR6cRm1iOlDKDy6KwT68SIK3LWnqgA6dqc8iD4uxFNDIGtfwR?=
 =?us-ascii?Q?dF1hvNL5lvb/lFRhr8+EHp0GkWu+XlNqJnJLnJFbuxZeMqCGigi0pCkwJ2RD?=
 =?us-ascii?Q?FST5zrPNaQNi62Tzs+RIcHftrQy8e5Pux5evnjPiqNZsx7ZHRAwRhL/+2SIm?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6a4189-e1f1-4b0d-690c-08dda3a1df1a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:18.5590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4MkfXNwYYaPc2Uy9IvJF0AVrPW1qRU+Ipvxe1zYwJ7CQ7Y9Mm+XpzOBQRDyAOXJtIota5Jfek+yAi+D976tjwBUSt2wfPp0zHv87Sf8Z/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/mips/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/global_data.h b/arch/mips/include/asm/global_data.h
index 147a95ecea8..265dd2a3ec4 100644
--- a/arch/mips/include/asm/global_data.h
+++ b/arch/mips/include/asm/global_data.h
@@ -44,6 +44,6 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#define DECLARE_GLOBAL_DATA_PTR     register volatile gd_t *gd asm ("k0")
+#define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("k0")
 
 #endif /* __ASM_GBL_DATA_H */
-- 
2.49.0

