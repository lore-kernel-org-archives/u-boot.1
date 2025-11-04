Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306B6CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 17:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FAAC808AF;
	Tue,  4 Nov 2025 18:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="R3Xe8vxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C751583655; Tue,  4 Nov 2025 18:45:07 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE538003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuEqqJCBMMisRDZSBhVdH1Enb68oCMCzbZMH2Pfao/SevZWP5Z9yrvZDbjOWUBAc2e5f60s8iIvZfOEOMPvKopxKQjGFh2BEjvSnxXdHx69SPWDAQYLwCnkEhlm+T5JPNC6vcA3SZggdABB4YsQEQqTAgLEuwJapy1HXCJ47Q9xTq4Bl5nwZDDjTLCWnJVefZqftc5VK/G88Bd6g33TegbXNo1VBqEiUd2r2GNbM2Elf1geQYk+r7NnWZMXC8IvqGGEoWV/0NP+0w2G+hc2xdTCp6YJ+L9NmB2205ZR4jCTq9tztiqKXs7UeV6U/exNxqk/yQ8k/478n+D6wFYcr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ5FM513p+YDAeH3ykq5rCOeTzLBKo4kh0xjDHxOiDs=;
 b=fO2SRmG+ZibRZXt4pIqwhNyJSOYsmHJAVNwwbXgRtNa8GtfjrMnwssCCKihR8YHizeAGxu0QFNGQX/SylLbi9y0Qy+sZJg/fZrOhrGWjMlv2sfgDG/y0uyCSQ0g+zp19F2KfZxiASNCM5KCqJfnbhYFzx5bruxGE3GG+Kon8K+wH7xOSrOsnOe0c8o5/8+jYLiG6e/JAtOL1nPugOxKTSBuJAx0ergR8Ho3I183xtN/almHuk0ISlk8iJltNAAht7cvSYzM5eoUmrmrAzSvjOf/VfF+qdSuaBaNvmOvNwsXIxGpffAnKgxvfVvNagoyJIsaeOUQgstwUr2zY+5IqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ5FM513p+YDAeH3ykq5rCOeTzLBKo4kh0xjDHxOiDs=;
 b=R3Xe8vxCgDwIfrBmFvEXbFnoXSau0DT80dLJImYqIIdAHcDLWznka4FupknUSvGiKX82dp8qxlA0eg3/53dn1EDdpYegSySKd36Vc5wWzZ2GUUPvH6MwLjkGyldlHxOqTHWbZxnHo5PbTmWffzuEvAsaGVFil6mQ5eJl6vpGcHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:45:02 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:45:02 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 0/3] reenable dm_gpio tests,
 add support for gpio-line-names lookup
Date: Tue,  4 Nov 2025 18:44:55 +0100
Message-ID: <20251104174458.3385564-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0102.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::23) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e309969-ff5b-4f1f-c439-08de1bc9e1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jhjFqMQ0bGJQUpcV6GuAZORDVhYYPAdU0V2cYZgCn7QQO4v5L2Hc8EdJ7Lub?=
 =?us-ascii?Q?I+wIIqBxzt2Fs0lwVclePheFR3BIMKvXzSGUdhkVUlCm19C/BxVNHRZ4lnqK?=
 =?us-ascii?Q?ft7tbWQgkVq8+8rI0zztEb1wRT7h04HL9POQJpOwYEtOU95MNKEb9fE5rqIz?=
 =?us-ascii?Q?aV6YLiW7avsmA9Q8ap7+Tbh9e7wjx0uxH1dGfriJyPumZ7Fi3S8zTKvJjMBP?=
 =?us-ascii?Q?LMxA2SKx4kABcWKgJlWBtq8fzu7XIO/ek6bm9K7GUuSQVN1N6dMa2qG5uhQ1?=
 =?us-ascii?Q?+CLthBFEeOJZKJCNx/gNACz8v5FGrbsMcktIyn5aGsjfM/eynflwEZV6n8mh?=
 =?us-ascii?Q?v8OI8ns9Pq0ugwMnUYF3L5+Wm/qm+6RzgRhf4pAtB1obZE1KtjeDswVZDix6?=
 =?us-ascii?Q?QKLBzqSccRjDWbQMo8i1gZyT6sSU7SyhMZN7VwrSAGZsPI+33BdRWrR9ValF?=
 =?us-ascii?Q?5rWJfdjJTw4qY+HrafHZ4+k5X6RiUKCqvARWR/iolNoo84VzXCPkROyipm9z?=
 =?us-ascii?Q?G3QXxZ8sNCPJijRTYoUWoVm2cvMkgZeVSrM+ITBrbxL0Y7gHeDEvksnMwdEG?=
 =?us-ascii?Q?BuNr9Hv85AzKLqLEfUGvQu3QlXnn6ZMB7wnr+7tZjyQZvmSh/Ji1KvpDA2po?=
 =?us-ascii?Q?fYzqrfLlpuTPLDBXiG44FnmNqRObYgs4om8AJFqRhS6dBFElNrl0pdprixQF?=
 =?us-ascii?Q?RVXqOhKL2POi0z6ugmHRxrXM4fiWxrL0OXMXE3+SLeD/sPzKeP09wcnsLEGJ?=
 =?us-ascii?Q?gJ1Dd2aPjsnNKLODIQQ3qvNaVetS/Cuw9DQVbgHxSJIIhZ9Fp4EuVQjQkPzv?=
 =?us-ascii?Q?GMFcqEMLE8Y8MyC2ssfttRIr7pCv3JCX3XKQ7Q/px5BMXKX+k2SDLOedouck?=
 =?us-ascii?Q?+Md8RFV4lXZjZpLMiP15cc1MIrgcuR4fNSO6Gr3sja9O+jxmOxozdcMplzP6?=
 =?us-ascii?Q?tGTmqsQ4T0dmGS8/U2UrAIMzC+zAVhJCVxfAbmuDdctfkKXK1hpmsK8/+ruG?=
 =?us-ascii?Q?u1tBWLjUDt8+pHSMGo3tPBxAxUtU1PSZ03oPES61P9/YR566FEKNzrNaywk4?=
 =?us-ascii?Q?/cOiPwW2jC+6UPxRT3zeD5TZU0+5fYfxU0msaPB/t9WnFM2XLkQfmYo/IoTp?=
 =?us-ascii?Q?2Vdseo7ZJZdnbjbkcri1+konPTKvIMnc9ICjbnBJjsxnKpPSJ6X9D4cConIY?=
 =?us-ascii?Q?tFp6KrDFYrYkh10JJE0eCDUEICSi8kfHjcjtPmjGNx3g4NO2E27vf8ezhIom?=
 =?us-ascii?Q?QHOBPmKxA+OnQygDQqI8uVyyw0NiwmuDs72F8tSB3qytaG6v4tI1Qv2XPSHW?=
 =?us-ascii?Q?IfZN6tbDM87waoEe1+oyW9b33sDxBZntMDP7QOZShRrO/7F8X/SFeDd+08Fj?=
 =?us-ascii?Q?kk9+kFCvzLp5cm0wo4kRsluLH8mTM27TWvpt8RQzytlxbkhJd9gP60YiESua?=
 =?us-ascii?Q?YyeMWmuBX1Wv6LMWlgcsErm0OQ/UMFObmOPL0EUGGNkYFXDSBJu4BDS1xyls?=
 =?us-ascii?Q?ojqA/xhj2xBcv2T4ym/bdKcX6Oy9uqtuhn8l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8tSon9oRqrz+8c0TpSEwUFWCoCNS5tjDPVMdmJDZOW2NuXkj2+S2X/Ivb6Nm?=
 =?us-ascii?Q?sD8xLGHtSWaHv2Phhf+LYJjxmoTtQaqDTher5fFm36eoGDcHml4kyJ1zjSDt?=
 =?us-ascii?Q?XX7qN1Oo9pMDua5d1dfnr++BYnC9dQziogE+rXd1yOUIJCKS9yR9rmJCZ8vE?=
 =?us-ascii?Q?9VOL6LJxWT0o6OskepL4lIDi6NKAUZU9dKOMbIvgQu1tyOVdPTzwGHJUqV90?=
 =?us-ascii?Q?F/V3WJfTNxke083d487k+iMAE8T2n7clX3NsxMBM4qf6es+6kDOjPMlEBtaA?=
 =?us-ascii?Q?MitB/GDrKuojrkuP4GgJT2lH90jYWvf31h+Cj2tdDOH7hSeIwfkuZiHDJTRA?=
 =?us-ascii?Q?NM3/7LnXoxaK/FgvL7JqxtNZzwQHk3+F71y7/ZEyaG0UwEBUiY+ESeMiyEmq?=
 =?us-ascii?Q?53RBPrpP/AoCEeMEz+l1Pvpswlwr/b3oGvJljmRSsqTx+4EZgXYi3Xv4FW2M?=
 =?us-ascii?Q?zatPOaWnU3FWFgLVLfsPBrOvaVqWREiE/zhPLvuP/D+3sB4zPQiRV/KYUDiS?=
 =?us-ascii?Q?JUvYdrvDxlcOuURAQ/1wivss3dtD6NH6UVLQooUeMhPJpbUAWRHOk99OGo1C?=
 =?us-ascii?Q?573p+WmmHfMucRHHdjZROx7RsykKENVCiDghxRgfxEE0U2y4i+zpwyZVwxDb?=
 =?us-ascii?Q?HAh8xI9RlZ7bA4RBtKJEuUDwwY3IOYpWCy8hsX8s6a7QGvCEz7csA2jXOkP5?=
 =?us-ascii?Q?fn2Gw1OOYDGd8mmOGFyrzJK6Li6cGxkLbDowfgqpY6uv+7OyfPYWsfIYD8AS?=
 =?us-ascii?Q?hXNTD4CLkFs/u8OCYavwUpPcp5yuNyek8z11K4ykKeX2d6Kkf+I3z5Wiul6B?=
 =?us-ascii?Q?/N6sZDfb21gs/OQ/7GEw8AsuRBfEM9DOSEHFnNf0ywWeKOIMUo7sbe7Mlnj8?=
 =?us-ascii?Q?dqVBp41RGSc/ivcCcSOqWvbeQQoLQj1OlO88izk6NQDj1oFHaQmFWNTMhnnZ?=
 =?us-ascii?Q?mv/lTuUTFY6j+ytubdM1ca0eYMCIqoitATbByoU5PO1c37iZdBnO2Xs+E48e?=
 =?us-ascii?Q?0VichRvrBjOQCQWuqJ+GX3Y77tLZtfcYc0SBgf/mxvFCfdj0BdwhHSy0L+s0?=
 =?us-ascii?Q?OybATjc/hyRfahojwT0IZZ48WdlUQn6lBf/XmPkHVb4/nfyr/zeaoRKOZhij?=
 =?us-ascii?Q?uFdC27iDMXCmEKMXNXsuL4CfCefEJ2+T2A8tzR7dLfmvy7e7ym1o4xkyqelk?=
 =?us-ascii?Q?p1GAqmNLaTaKkVFy44H+4pZRhXHr+V2FLI/XOxu/tYEROi/7P6/4cWSP19fx?=
 =?us-ascii?Q?uDPwpQJkBFrjugZH9AKWhgu3qZL98n0je99HUyzfX3zC/g003rQ9olJd4kI7?=
 =?us-ascii?Q?0bGChOkQJHObLum/JyX080BXb3vA4KZOUqxvTtDMKX1SI89brXKA6qJnqVeO?=
 =?us-ascii?Q?FxteX5hPmPXl6Jl75UpIOL53UgV0nLxz4I4XGKIYGe4co6gcvOuttuxxrQYC?=
 =?us-ascii?Q?yKchDxO5kHX3WsBhVoD6tKUUE8vOY2GX9sWSc0YA6iWRQlj4+TSnM3TLZ6h7?=
 =?us-ascii?Q?TDJ4EoTBr9g6JgbM3ZMDDnTa2a/+FrEp+i0ukhUIsHGWzSgz81/5HCxFn1/5?=
 =?us-ascii?Q?PGgS20vAZatqBehOGLKQLEhGUdg+0ohPpWy1Kw1LZiMKIbTMVg+Nd8UcokBG?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e309969-ff5b-4f1f-c439-08de1bc9e1bb
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:45:02.4575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU56NjM1SVhHJXTHnR/gU8tAMs13HJcjI/WsOzTDiY7GvNZU7QiT81LMEKGjfLGnIdq5Eh4WAbGUSdzxle+Iv7w3WPiI/VyvLa07vZ4tbvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6286
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

Hopefully third time's the charm.

I merely wanted to add support (mostly for use by the 'gpio' shell
command) for looking up a gpio via the gpio-line-names DT property. We
already have a "gpio_request_by_line_name()", but cmd/gpio.c does a
separate "lookup + request", so it felt more natural to teach the
lookup machinery this as well. That ran into
OF_CONTROL-but-not-OF_LIBFDT being a thing for SPL, so here's yet
another attempt.

Now, when trying to do my civic duty and add tests for this, I found
that test/dm/gpio.c has been defunct for a couple of years, and
reinstating it is not entirely trivial.

After a couple of rounds CI is now happy with this:
https://github.com/u-boot/u-boot/pull/828

Rasmus Villemoes (3):
  test: gpio: include in build, and fixup bitrot
  gpio: search gpio-line-names property in dm_gpio_lookup_name
  test: gpio: add test for gpio-line-names lookup

 arch/sandbox/dts/test.dts  |  2 ++
 drivers/gpio/Kconfig       | 16 ++++++++++++++++
 drivers/gpio/gpio-uclass.c | 11 ++++++++++-
 test/dm/Makefile           |  2 +-
 test/dm/gpio.c             | 24 +++++++++++++++++++-----
 5 files changed, 48 insertions(+), 7 deletions(-)

-- 
2.51.0

