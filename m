Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6A0C4452B
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 03:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E5AA60744;
	Wed, 22 Jul 2026 03:07:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v__kj_lnSpsk; Wed, 22 Jul 2026 03:07:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C981E60718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784689655;
	bh=OE5gSDuJrcC24BvSPbx2AGQ/o2sDA0EcKqCenuSkvc4=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JFJZzxX8C0zoTp34/lyZ2nHfdOcguizgajWIt35qViBvt6FjBbMb1LkC3OeL/lCsG
	 oi8sOh84MzWf/+ItGR8mIY4FjVDqeqZHnIEQqrYhacjinSPZZLxQsahQevwG1zB4qv
	 fSEl6EK7f3xRyIraMOxxDvZ6xwb8fZSAWNgmG0A2S6HCvlys+9czqv5/eIxttdzLby
	 gBOiUC9e3JEipfW5qjlH0pe9cbyVBARVmZ8TR7K3Qqr1s9uFnb1kF/7qQmQNdGd0Dq
	 jTxKSxBVOdibDeLPybSx6GcWVHB44Qw36UMtZhN5y6oRh83qW5c8Bf22VTI6z10JbL
	 V640frefCWyUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C981E60718;
	Wed, 22 Jul 2026 03:07:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F2F2313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85F4740692
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBVZ4GNcSf5O for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 03:07:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2E3E94040E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E3E94040E
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E3E94040E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:07:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E838846A4; Wed, 22 Jul 2026 05:07:31 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F4A803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 05:07:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYiyeDPjq4ecjQOwY3HbQwjEARlcOdI4nXS93H4aIOLpdSoXeUTS/bXdsHYFryTzo9cED91Ou9aNVK+TzVq6XG6b4hpWTfW3T73dtsgrfjobY/l0o68/B9BmhbxvLtEv5oeIMOe2cWJHJl7GNcAdM5znVgPBDe1leK88DSLyFxfqsdDBeb8zV0KO42rMTHhYBrSfJF368Eb2DkIbxQOaYrRzdrCptA2IhnKwdOadEjG80r0f4ECZ8AydYDKTi95tfg6XOcZbcQZXytUd0V+FMrpr0Sf3KZ9rHb44ybtX80JIpy0usvlgXU47XoDMOCWauKoYdOJ+GOe+9Sx72eUGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE5gSDuJrcC24BvSPbx2AGQ/o2sDA0EcKqCenuSkvc4=;
 b=dtH3Tu3XfA2+1uFxjpDIMxPicw0kFW9sr6Q/WRjx7k9txQ7rQ0puh3oGzWlpFaeKR+gn9Hz0rlWMN8FGoIHKAbFrPyvhCxb3VFJsF8rIOKRyMWTCLBTSdSI4swHybjQwpdFfgenQ425J3LypEqKoSxxYj/qbG2OYDo3fkz4TGdipWkdc2x784Hx4+C9/ObNVvmr9cz6wGWxvGXJtF27mF5AOFEhC2+uACLVGuBrhgzZzahpmWTtcklY6yPyCJT1dCL8Qwm48UqQAdwHBQ9l4Lg/wx7D9pcKaddE2LVhn2JI2pHXK8zm+4yOU1bH4sWU22Tas5FX8WVe0c3bj0uva2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH2PR03MB5253.namprd03.prod.outlook.com (2603:10b6:610:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 03:07:24 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:07:24 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Brian Sune <briansune@gmail.com>, Tingting Meng <tingting.meng@altera.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH v2] arch: arm: agilex5: Configure DFISEL for SDMMC/NAND
Date: Wed, 22 Jul 2026 11:07:08 +0800
Message-Id: <20260722030708.6131-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260311050117.23037-1-dinesh.maniyam@altera.com>
References: <20260311050117.23037-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH2PR03MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 430c4e4b-9331-4b2d-a113-08dee79e5a15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|55112099003|22082099003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 5EwLYhKeDrj2/hyb963oV/27/ZBNvGGPPU5U8t6OUxvj/oQh0WLZjzW9Gg569rKYTrJnDIopZJS7dVaEDiaqxjjQym5oV00brONzdqZGkAsLF7eq+TcGs4KJqvCIPaofzofsIaZKYtXB/0yoo8lvJD4W9dUAG+/fW+Ytzwkt6ycHbayrCvWo9kwmOBg1++nLb555PVVgKG9SF8eWCxKvDZruvCwyza6N1dEgF0wl5OHQ5NR2dm0MD8Rh6H8vmM1YosUBugYswtaZ6cMrUIPNPGTc+0gG2alakb/uCmdv7UGAILo6Esn6m3Tm9jnWZ1KaE/7MUBHHwHTYSyi1AdgAAsU4YXWjkwOJwQwvh9yQHBfDjQC8lZMcQrz+p9p2Vvu6WOaUBtRlKQHXE5SNIJbU1xKDOMAQLxSF9cVXnaN3VuyDS2tenPhgkxMCAtdpS0KFZ2i7y99rSO/a31PX7dUZ8A326ElVssyFGfJIg7SsD9kY3ROc6PLFNd/kAiESJyZcecFDrI2e1YMXJN/+I3hZxwEUa/EGxYS5F2HAdubBWKHsrLE1RZ1MZ/aRTL7+nnJIoXh67d+xlEZlfoKtSqFeEDJacrc0uKx/Ena4hwqWONTX/esF4NN+Hldb0sSvXrx5vMPnPIpM8nsuKyEkENMc97YE/V07A9QquhVUh4PXSMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(55112099003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m8/RQhiQsqdTsr1NqfrD0oMob7Fiw7iXdtYKBKFcLqfiDxFBdEzFzIABbwCz?=
 =?us-ascii?Q?Gn6cRHvEDJRBiTMUz+sFVikpTOVn5WlA4t9ZZGr4lesx4p3te3OsCM1Q5d9l?=
 =?us-ascii?Q?SszxIcOzDmy8yrGCRIcQzYpTk6XBbbNYwdLuUmViuppeth7oROwBOpozY5QR?=
 =?us-ascii?Q?DQIqQwqHu/kj5WukHpmtAgpJW6Z77YnONeXN8zrgn7h2W7aw7pj/l8O8TmH1?=
 =?us-ascii?Q?zwofP6/L7gFkw2eZVorIBWk+sWzuHj6GeRdvnBJyR6eaVyZvMXLFi+rygvvr?=
 =?us-ascii?Q?lngQSK8h/crDFuiys49coBPSvyTEhzdaqntEED6rEuw+QV3y4bOegFCxWvOt?=
 =?us-ascii?Q?sNV5qseNpynrFJz52TwcM7ehNf9AmY5BA/0n2J3v+APFmDZAaVhVWPD6MclS?=
 =?us-ascii?Q?9cvi6uVO+pgCYvnOd/QZRSI2uxlMwi7Ztsnou6L/zOqVokjomPqJ313HxbaC?=
 =?us-ascii?Q?dSMMeEBlmIxXq94ivC2+NUnzBISXbZ1a02oOQE4vQ+PZiKusxyIGyDfzJt41?=
 =?us-ascii?Q?nn6oLLTs1rbQqs1E6DDYhCBmXsXTaVPWYX9iFF5IKS8uGitlb2lNF9Rauci4?=
 =?us-ascii?Q?HKSNmdg3xqYcgkMtqXbFmABh9w66N1pM8jtF9GwBSCDxd7N8ykz3jTk5aTsb?=
 =?us-ascii?Q?oBFHfxXTlyIBK2dGItublFGOfUoLV9Nu6RvON1ZAU+znhqUXMDW6Jt4BwE5q?=
 =?us-ascii?Q?+N4FhumgLKowQ7Y56xIxYGtTZe/aU3h3FSMrQ7oj3MoAumHjSzaQjJuSpdVt?=
 =?us-ascii?Q?JSvT6ZwrS+CJfFWOqUE41QKEw78YNQMsJISNv2X/aJT7obSzQuCb+xD/RPcC?=
 =?us-ascii?Q?iy/qYfxgH/ik3J0Bt6gsNNS+FbG1LyQ+9FucS8IfBcKca4C+E6jJ+C293/6K?=
 =?us-ascii?Q?DrANIgH2fzx6lOTCrk8935G9PehJo7T8a5hio2pftxSdmEzzaplMXld3U1Eo?=
 =?us-ascii?Q?rxpNcw2bEMoCTyqaSzHn6SinKm/MBvQ/L2pyPRyPZgm4JHdEHS8uudU7R33q?=
 =?us-ascii?Q?Q3PwGTiJJL/phoIWwD4oC7FcHUOa9HUE6+0j/+jbrhB8VfU1PoG3pW8H0dhj?=
 =?us-ascii?Q?Lf/f/5uUrGn6zYY6u3SMZCM2ruPfdcu73MozkG47SrPfoWrLKBhWZ4iFzu/W?=
 =?us-ascii?Q?KChW98e0hDIsY8m9Vi+ERotNLr8T9HDSEQZJSNK0fpNW3B2hSXH43UmONSXn?=
 =?us-ascii?Q?4tf7L+ScnA5GyqHBhCPdKwLwaODcDWb70PZQDe5kw6NG9DJ+92b7v1+C9qxe?=
 =?us-ascii?Q?XFOTnsmlDT4s0PgpobudpbhA5t8e+bbZcO3Ovxee58x0eIuJFfngqaeaIANK?=
 =?us-ascii?Q?DkD44X40nEHga+FJYzeMX5AHh96K4UqmEA3nI/OgqTSKXkvaRUQncAlYPVsy?=
 =?us-ascii?Q?l4jrXOz6w3UelovKO0GGyaKYsAz4lKg71C8LIWMa8TXZeftjY2/E2ZHNSNow?=
 =?us-ascii?Q?/vX0qETTetOyShZwDte91PI3jP97Cecn4WCUlRPG7cD/PwlwLpvq2TlrkqRA?=
 =?us-ascii?Q?gG575bK+oYm/Zy4CKR7j5/E/L9RHNPWTkeDFA7YOoZYrlCjafgsHWlltKy3J?=
 =?us-ascii?Q?vWibnaL7FPdeCHs64jGze5wwCw4hpZ4mb1mGyaPPUZ2ERcEmdhRZuylPHTgM?=
 =?us-ascii?Q?o+gh/jEnnG0Ah++WYONpStfp4aunc/Q3XAjoIwVytNnUKUp0UfHhrD6rSFv4?=
 =?us-ascii?Q?9wvwZucnpBOZDPuJg8pJFAJCJTmqOzWhoutxR6RpUbXcfFO3k+AKlJJ5xVGj?=
 =?us-ascii?Q?IYH/ZJxyplHeTFBIoxwczZ7nbugdvFI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430c4e4b-9331-4b2d-a113-08dee79e5a15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:07:23.9883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp3sUTCqywkv1U06z9LIjcw2WSaTU9uFHUb6xvOZRsBHLpun9pXfCNTDR44BYtBsqpt5k0QL9O4hHWYW64w8t3bplqcWWo78zwCLA5akFQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5253
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE5gSDuJrcC24BvSPbx2AGQ/o2sDA0EcKqCenuSkvc4=;
 b=ecGpwe4Aa141S6Ar78UD/sxs1jEEcGmqF24MNu+jsxm6aeKWfKPiJum6J3ap9PWL1uM7W1ykO6ab2Y4K/00k3cYtm6p9OC3En7eTSh/3/io0QgqznNdm3jQJVvJZShR5gL6If+7yFN1UkMjZoTVq3WUyBUC61FB5IuZSLdP4DLA7yavNiG3HWi8RZA0GSm/3y4gEta80dbbkLC2M0mvuNAzqTl0TOwkl7YEwKzBi2/apzpylN1W6YzEM/ARcxMOQkRNfmk6+jr3gFxJLM+Cx5udMyhdRhGjTzMjMpChO2A4drkmcplLmHZnsHHlg8dpt3rjXu+lnrylRDFYWG9Vx8Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ecGpwe4A
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="ecGpwe4A"; 
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

By using the handoff COMBOPHY selection data [BIT 16], we can determine
whether the combophy used for SDMMC or NAND. The DFISEL configured for
SDMMC if the handoff COMBOPHY sel [BIT 16] selected for SDMMC.
This ensures that the appropriate PHY interface is enabled during
early boot based on handoff configuration.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
Changes in v2:
- Drop unused asm/arch/firewall.h include
- Use fixed-size handoff_table[SOC64_HANDOFF_PERI_LEN] (no VLA)
- Pass SOC64_HANDOFF_PERI_LEN directly to socfpga_handoff_read()
- Fix comment to describe COMBOPHY/DFISEL selection from PERI handoff
- Include asm/arch/handoff_soc64.h for handoff symbols

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/patch/20260311050117.23037-1-dinesh.maniyam@altera.com/

 .../mach-socfpga/include/mach/handoff_soc64.h    |  1 +
 .../include/mach/system_manager_soc64.h          |  1 +
 drivers/clk/altera/clk-agilex5.c                 | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index ae5af1f0100..e291d000907 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -81,6 +81,7 @@
 #define SOC64_HANDOFF_PERI_LEN		1
 #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
 #define SOC64_HANDOFF_SDRAM_LEN		5
+#define SOC64_HANDOFF_COMBOPHY_SEL_MASK	BIT(16)
 #endif
 
 #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 8be98d0ee46..ce780da76d9 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -18,6 +18,7 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_MPU_STATUS			0x10
 #define SYSMGR_SOC64_COMBOPHY_DFISEL		0xfc
 #define SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC	0x1
+#define SYSMGR_SOC64_COMBOPHY_DFISEL_NAND	0x0
 #define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
 #define SYSMGR_SOC64_USB0_L3MASTER		0x38
 #define SYSMGR_SOC64_USB1_L3MASTER		0x3c
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index 92b91a9dfc8..a100be32c94 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -21,6 +21,9 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <asm/arch/clock_manager.h>
+#include <asm/arch/handoff_soc64.h>
+#include <asm/arch/system_manager.h>
+#include <asm/arch/system_manager_soc64.h>
 #include <dt-bindings/clock/agilex5-clock.h>
 #include <wait_bit.h>
 #include <clk-uclass.h>
@@ -241,10 +244,15 @@ static void clk_basic_init(struct udevice *dev,
 	struct socfpga_clk_plat *plat = dev_get_plat(dev);
 	u32 vcocalib;
 	uintptr_t base_addr = (uintptr_t)plat->regs;
+	u32 handoff_table[SOC64_HANDOFF_PERI_LEN];
 
 	if (!cfg)
 		return;
 
+	/* Read PERI handoff for COMBOPHY select (DFISEL SDMMC vs NAND) */
+	socfpga_handoff_read((void *)SOC64_HANDOFF_PERI, handoff_table,
+			     SOC64_HANDOFF_PERI_LEN);
+
 	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU)) {
 		/* Take both PLL out of reset and power up */
 		CM_REG_SETBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
@@ -320,6 +328,14 @@ static void clk_basic_init(struct udevice *dev,
 		CM_REG_WRITEL(plat, cfg->per_pll_emacctl, CLKMGR_PERPLL_EMACCTL);
 		CM_REG_WRITEL(plat, cfg->per_pll_gpiodiv, CLKMGR_PERPLL_GPIODIV);
 
+		/* Combophy Selection for SDMMC */
+		if (!(handoff_table[0] & SOC64_HANDOFF_COMBOPHY_SEL_MASK))
+			writel(SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC,
+			       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_COMBOPHY_DFISEL);
+		else
+			writel(SYSMGR_SOC64_COMBOPHY_DFISEL_NAND,
+			       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_COMBOPHY_DFISEL);
+
 		/* Configure ping pong counters in control group */
 		CM_REG_WRITEL(plat, cfg->ctl_emacactr, CLKMGR_CTL_EMACACTR);
 		CM_REG_WRITEL(plat, cfg->ctl_emacbctr, CLKMGR_CTL_EMACBCTR);
-- 
2.43.7

