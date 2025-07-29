Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A541C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 14:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8AA82BA1;
	Tue, 29 Jul 2025 16:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KjTe3sVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3DC82BA7; Tue, 29 Jul 2025 16:07:52 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD0281E13
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 16:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EI6KTVmDBWsfvQYe9vk8hGEtgm/HOrf1JtD0XDo8L1chxupQgRKG2hOkssy7l8pAWzlrtvV1kbNDWmYnK2B1bY27aa/hDfKkb5KZm0SrxAqjISs20Wml67KA8VUNbwttKifUnkldbJHDR+rFcFlUUy2liVrXeruJRTRGrUiKGGgmyn2KLdl3rCG9jM4wckmGqDWo6bBf2Wkn5aw8oqIzgf5KRQNWkoGw6hsrhGXwpbjOu6NyMwQTd3fvytyASyf4CsdhGm1MGEnOB3yZ0dyDx+RWHtDMHQNKicAzsJAlue8KDwvgUVbJv6R9IYWHuFyDl4pWYaHsRSicojtpCGUU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgsQ5cOPJ5vemNFTxgzY9DIruOPqWZqK01av18P5v3s=;
 b=lvEKlGIhXB8vjNfBqkx/sx+1kST4zmzAFdbGW+c3kAP59eHAnhwVZvfdhK0jdisomQFDOf9+mWFpSKf34nqUDeHzUk6URpnLbRFD9B/zh1klub1o5CudvI9nEaeLUMQz6oBBc+0Ko4CXmqz/ZaaaikDXGvoOBcFR1Y+OZ1YYgQg+6/XdxnVsuInKv3bcUuvm+msvOzYPe3qjgLOBXDMKm7n2Rz81rxxLpIz32Yj8mag3noUCR/L156shcDM8LA4ubhnAv4Q/flGEZ2TNgQfRQhN+cU42iZTzt9KspHLEQA5qljfNToQB+AUIBDI/3nHZARuVOL140dMnKGI/cBzVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgsQ5cOPJ5vemNFTxgzY9DIruOPqWZqK01av18P5v3s=;
 b=KjTe3sVou+k6jvXvssDjChiDiHjtvO+tJ9oyHa3bXb9Koa0F2wfiyw09J8uw4bqXU2Pfa2G3PR/osZeQ9wIIsMDETyL8N3MByf3chGZtrclKxqvFSVQt6GPo0lh2LRZPSpAHjdj2pnvjlOwRVWg6KZQ+AGcZ72C5Dki5vtCLby3oKIjS56ZLPeS4VoORQdLMqt3ZmOQ9ys3E18IU+5+k2eMLC/CIillaVA0KrqzuGCUimJwgfbmJV88OW4LMmcFIWrcUlgL4Wi2vESqpDlhdeo+/olqPprjFZeAj8oNoxY9t7gDYArit3+ZPLnSAQtid1xM/NHmIWYgJPf64wHsdnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB11417.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 14:07:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 14:07:48 +0000
Date: Tue, 29 Jul 2025 23:18:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/7] arm64: stack backtraces
Message-ID: <20250729151415.GA28867@nxa18884-linux.ap.freescale.net>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: 690d28b2-38bb-4aae-841b-08ddcea94c09
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wa8XbCJn9CvaKug+vMFkfZ5kt5UxGDX7vXJuJz6trgPJfARLV1WDUy0fxatr?=
 =?us-ascii?Q?58LJWRjfWOQ2S78pXYRNarWqRa75tP/wqgz6fxg5xthmCDdbyOxMC10bgid5?=
 =?us-ascii?Q?32WFe0gavK4AV2bLBB4osF0kZeW+DjtLLLTJJ3w8UtN345knsXZI+KCJi+f/?=
 =?us-ascii?Q?Aj2Qg/lETZDe9+P+Pop0cIHzXmGddUhNMLC2pENlPbB6XGeZgXWnEYqds3ca?=
 =?us-ascii?Q?Ez1UNR/SRzQIsy0UxTBgs6OYgUMkbu0LPc2NJjCuzWOCDSiFCxd21lQeCpmM?=
 =?us-ascii?Q?hfKCqogcZHSXp422YhfqRzPRNh2OnFTCEUBxFXpvfXEiX/1IRhsOX5bDQG2A?=
 =?us-ascii?Q?jugkTDL808s/kf+Vw3ATJDnR4O3yy3HppufOm0cSXyAXKYOqPOdu5For1NMq?=
 =?us-ascii?Q?XnVUxxnyKBPbx/Q3KqA1vQA7BFdd9/8K5MXXwdfd1L8lpLBWsmhj1vPNqg63?=
 =?us-ascii?Q?fDVeBllmKYJoQ/S1RkgkLVQku8JPTYtvvFdbG4L7AO1TXdOeQ5vW++QJ5RG/?=
 =?us-ascii?Q?mRAQqw/oqR01udD46v0HofvY9MS/JkOHQXowxl/jEc3wYhmLCB0R9EKnf9iO?=
 =?us-ascii?Q?NHAvkjQ33vDPUah87YfNU+Ehsbp27ihZZO9uy0HdRgSz1CdFkCnOWO1ENVKs?=
 =?us-ascii?Q?ln8P8tUMZEJ19pBD6JN9ZMjTNKppelYC13+7tGAVdbe6m5o2KfPn9HUWtelr?=
 =?us-ascii?Q?IXgi/d26YJoZ3tuvcovano2x3OfWw1qHWGlnY3wD9akLXmpdiMJpQy0c43F2?=
 =?us-ascii?Q?alhS9uPT7K5gz/Ykr/BA7y852gjzH8xg6O61rgaHy3fEg84Rvz0KBWYA4x8u?=
 =?us-ascii?Q?u9qdd7Wt/Y7L9qu4rR9IK+jcSNkHA8FGE38KJupdsEy4AVpfQoubLdsTzDmK?=
 =?us-ascii?Q?jIj2HPhr6XrO8emHtnoO9wzfzbZw1E4exPGt50CjD/n9VJNG87synHj/aSt6?=
 =?us-ascii?Q?ZVidbFvJGrfMHwFdQ1LTl5VIQEnkCR6pbvOZMnQPkUPdwFA6G4PZ+/WtfK21?=
 =?us-ascii?Q?c3FqhCsCPDfo/xX03RsRVLCyYgafVY13A5MaGYIErfxvA4I44LGKQQZvcMZh?=
 =?us-ascii?Q?4dUoZ9EwD22dgbpF+8T92lAyqr5sQ/pcIUaqU7v7mArTjA+q6OQxPuxflyY4?=
 =?us-ascii?Q?2Av2ZCNHI6oKnqDH7l1dx8RUl8KRpm+SSs9eY64T1Dgft7Wnud5n+GjCWo3f?=
 =?us-ascii?Q?Hx9UTX4t/LwNYvlmghdDkd65BHBCft0/CKI/N2EkRrkv1TO/pgccDEW3xpDR?=
 =?us-ascii?Q?Hho/BA1y3Q+GmJ+n96m7yxTukudr3L1IVtEMVn9/+lzuvNb+SaIfBjrZXVut?=
 =?us-ascii?Q?P3Fg2+am6VYCbldVrW8Etrws3BcLYxR8TC4i9vGww28taTAwxeGcsTY0lnY7?=
 =?us-ascii?Q?sNCo1B7VnuZSXsBZPDQ/mh2AP6xTx0HfbDIxyKhDDQr6Lx/u0+8Z+IKc+cYn?=
 =?us-ascii?Q?WDcCyBEA7q3uPHN10lo97scO8oIILFYF7wPDAovL2RMy3Q+/RSrTDD1svQRZ?=
 =?us-ascii?Q?TEksRtFSwwsI0Gk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2pxtvmd3hP0S7opO+HWNTHXXbGFn1vszkWOVbM59eRMUqweVPQNrQrl69T/f?=
 =?us-ascii?Q?h9WErhUALJVeA/lv4BUcFEbOEhKrmA706nL1da5Te2UME1Ej1FAKYnwzT2cu?=
 =?us-ascii?Q?UE6GjDRsGz9HupzG/M7ibiC1pghg+KgusTxCm3/r6xhcXIQyFGhdOIX4Y0V5?=
 =?us-ascii?Q?z9T6kjETtGPUoYuGl5fHM/PXnmMI762jhT2p9YWxBw+6n86iPMDdI4aS6V3d?=
 =?us-ascii?Q?OlbujCpDeG3MphtUz3VLWgocZAnJCxlVLtELf3xfGHQJC69peWrEs3hr1aYy?=
 =?us-ascii?Q?VxwkxOFP4Z5RQ5s2BVaRr131r8Z766FQV7KGMy7BVcjEHm/ZpympEXsGwUQs?=
 =?us-ascii?Q?6sgyCJqODwfeX41sxP94u6J5XJUdG7cb7iBdS1UDWhLpQuo2IMl8lo2aFO0w?=
 =?us-ascii?Q?lHco8TFB56XhlW1ip4XNMy8UuZcwAV1cZUEvAjY3G/sxhOY6TaaDsr6EmicG?=
 =?us-ascii?Q?0MlFCMN7guIHKf85Pz1iTPyc9ak87YRdWEc5QQjudukuVlwMwxuOFDF49Ul5?=
 =?us-ascii?Q?URtNk+iSa69zKuDuzRPxwMB8cZ5U9FM7+JFz6sU7t9euog2BnueflIo/S29c?=
 =?us-ascii?Q?dYgLc19LICPM+SpGYWkyXlVzTeU6z8oqX5k47ip3O1HlSTDDxPGgsqY7DEm5?=
 =?us-ascii?Q?RHAiCHp0iJ0eyPOMJIWCc/USILL5eTfecKgM4JVO0Hzw8u8mZ0gcwdAcaDKM?=
 =?us-ascii?Q?brkYjxQbPTCTq2f5pqDNto4w/09GIDz/Yreqo30jAvhaGhEqeh913vSn6Fgr?=
 =?us-ascii?Q?hpE17TM/IAGQQCjd+0Hu6EySD6yhP5n1v8kKluxo4z4mr90CrGQGJ4OXYOIH?=
 =?us-ascii?Q?xevqds3rj8F0rdK8dgFQTxcl82Rf34M61EF3/LVClKaQgOu0Dg8MltJEzePy?=
 =?us-ascii?Q?7lVWWiZ7KwyqHDM8e22+5G3MQ0+JjpUjn8tWyQaX3a3LaqspKVNTnMPqPsbF?=
 =?us-ascii?Q?wWUCSFN/sxMCHDQkZ4uKfZg7AhOdB2ouP02ZooA1W5VHCAy6dsDJahqDyYDn?=
 =?us-ascii?Q?WgmD3oWP9aJH3bOAT0FoCUFNXr2vpBRs3k+Q3WVpJGlBpXk3LjiL3Qo1GY8s?=
 =?us-ascii?Q?jM9RhsNeU8z+hH0dR4KoAmbeg6K2hHBAtg5wsmnDH7QZ+vpYzlF8Z3sPayyd?=
 =?us-ascii?Q?lzkanFPmeYXO7wR/MSX7m8/BNSqtjHOYKAAPhU7iU0rFpCu8YZVsLS8xTSH/?=
 =?us-ascii?Q?Qo2IeXuxYL2v/ilrjNXPSHqoXr+9Sd5gm8Pn/VKhl7TyN02Y3KqBUGbJP/AC?=
 =?us-ascii?Q?qYg2IrlyeMCmVK4Ex2IQN0r1jTn9gBB+Jawpgo6Ty3MInUQChWk2xe1s489e?=
 =?us-ascii?Q?hnHxlicTqelC2TZjah9TrNn1yN3RA0YLkLAXRUnjw96FbbWHPhZUWubdSVw5?=
 =?us-ascii?Q?iZ6SrpdH8J2TWQ2me4Vkg4T/4JfQzgsWoVQiKa023+Lfqsq16UjKlGHBuJID?=
 =?us-ascii?Q?dEsae9lQXsN/mRBw5293YCvUR5FzzWKfdi/0XROarU1L/oI/WM27mnVrUH4Y?=
 =?us-ascii?Q?7ljHzekGcntc/bT0vak3YXRBZ52znjCvAL8XiWHFJSZJ9BJHzZxMR+6dkw8u?=
 =?us-ascii?Q?bs4k9ZsjO7g0kaMgpZ6Z70Ml/XJc2SxPedS4k51l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690d28b2-38bb-4aae-841b-08ddcea94c09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:07:48.4341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/GMyJeD/Fyw4GRkwS0lr2PRFTJ+vdUsSiO5Dz3KLyDu7VeGsKQRabS88NCMz516uwEbCMCwUryFi0FX3uRgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11417
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

On Fri, Jul 25, 2025 at 02:57:04PM +0200, Casey Connolly wrote:
>Implement support for printing stack backtraces on ARM64, make
>framepointer support configurable by the build system with
>CONFIG_FRAMEPOINTER and teach U-Boot to walk the framepointers and
>unwind the stack when an exception occurs. Also show all 64 bits of the
>exception syndrom register (ESR).
>
>Additionally, a new global unwind_stack() function is added, this can
>be called from anywhere to print a backtrace which can be useful when
>debugging certain problems.
>
>In the future, stack unwinding with symbol support could be extended
>to for example only emit log messages when a function is called in a
>specific code path. This would allow for less noise when debugging hot
>paths under certain conditions, but this feature is left as future work.
>
>=== Handling relocation ===
>
>Since U-Boot relocates itself at runtime, and can be built to be
>position independent in the first place (effectively "relocating" itself
>when it first starts too), we can't really rely on gd->reloc_off.
>
>The approach taken here is to subtract CONFIG_TEXT_BASE from the address
>of each symbol in the lookup table (while it's being generated), then
>when decoding we just subtract the address of the _start label since it
>is always correct pre and post relocation. This allows us to avoid all
>the awkward maths since the symbols are always relative to 0x0 in the
>lookup table.
>
>Example output:
>
>"Synchronous Abort" handler, esr 0x0000000096000004, far 0xfffffffffffff
>elr: 000000009fc6f768 lr : 000000009fc6f710 (reloc)
>elr: 00000001ffe49768 lr : 00000001ffe49710
>x0 : 000fffffffffffff x1 : 0000000000000009
>x2 : 00000001efdbadd0 x3 : 0000000000000000
>x4 : 00000001efd99a28 x5 : 00000001ffec7676
>x6 : 00000001efdbac70 x7 : 0000000000000000
>x8 : 0000000000000002 x9 : 0000000000000034
>x10: 000000000000000d x11: 0000000000000006
>x12: 0000000000001000 x13: 00000000c3400000
>x14: 00000000fffffff8 x15: 00000001efd99837
>x16: 00000001ffe146b8 x17: 0000000000000000
>x18: 00000001efdbac70 x19: 000000000a6f8800
>x20: 00000001efe06fd0 x21: 0000000000000001
>x22: 00000001ffef5b80 x23: 00000001ffee08c0
>x24: 0000000000000002 x25: 0000000000000000
>x26: 0000000000000000 x27: 0000000000000000
>x28: 00000001efe512c0 x29: 00000001efd99c80
>
>Code: 2a010000 b9001260 d5033fbf 92fffe00 (39400001)
>
>CONFIG_TEXT_BASE   : 0x9fc00000
>Relocated base addr: 0x1ffdda000
>Backtrace:
>	<0x000001ffe496d0> dwc3_qcom_glue_configure+0x40
>	<0x000001ffe494a4> dwc3_glue_probe+0x10c
>	<0x000001ffe1757c> device_probe+0x254
>	<0x000001ffe1757c> device_probe+0x114
>	<0x000001ffe4ff70> usb_init+0x158
>	<0x000001ffe00fe4> do_usb_start+0xc
>	<0x000001ffe01018> do_usb+0x78
>	<0x000001ffe0dec4> cmd_process+0x140
>	<0x000001ffe04e24> run_list_real+0x6f0
>	<0x000001ffe05554> parse_stream_outer+0x148
>	<0x000001ffe04d30> parse_string_outer+0x90
>	<0x000001ffe0d148> run_command_list+0x50
>	<0x000001ffe02be0> main_loop+0x28
>	<0x000001ffe065c0> board_init_r+0x3c8
>	<0x000001ffddd00c> relocation_return+0x4

Nit: If this address could be printed with pre-relocated address
(built address in elf), it would be better.

Regards
Peng

>
>Resetting CPU ...
>
>---
>Changes in v2:
>- Include calling function in backtrace (current LR)
>- Implement support for runtime symbol lookup
>- Use symbol lookup to print more informative backtraces when available
>- Adjust backtrace format and print U-Boot base address
>- Link to v1: https://lore.kernel.org/u-boot/20250703051951.43372-1-heinrich.schuchardt@canonical.com
>
>To: Tom Rini <trini@konsulko.com>
>To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>Cc: Simon Glass <sjg@chromium.org>
>Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>Cc: Ben Dooks <ben.dooks@codethink.co.uk>
>Cc: Rick Chen <rick@andestech.com>
>Cc: Leo <ycliang@andestech.com>
>Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>Cc: u-boot@lists.denx.de
>
>---
>Casey Connolly (3):
>      drop unused kallsyms support
>      add support for symbol lookups
>      arm64: implement printing backtraces with symbols
>
>Heinrich Schuchardt (4):
>      cmd/exception: missing include string.h
>      Kconfig: make CONFIG_FRAMEPOINTER available on arm64
>      arm64: initialize the frame pointer register
>      arm64: simplify interrupt code
>
> Kconfig                      |  25 ++
> Makefile                     |  24 +-
> arch/arm/Makefile            |   9 +-
> arch/arm/lib/crt0_64.S       |   1 +
> arch/arm/lib/interrupts_64.c | 133 ++++++---
> arch/riscv/Kconfig           |  21 --
> common/Makefile              |   1 -
> common/kallsyms.c            |  42 ---
> common/system_map.c          |   8 -
> include/exception.h          |   1 +
> include/symbols.h            |  22 ++
> lib/Kconfig                  |   9 +
> lib/symbols.c                | 141 ++++++++++
> tools/Makefile               |   3 +
> tools/symbols.c              | 646 +++++++++++++++++++++++++++++++++++++++++++
> 15 files changed, 965 insertions(+), 121 deletions(-)
>---
>base-commit: f2f451d9d6d3756458d5037e3e5135e5211582d7
>
>// Caleb (they/them)
>
