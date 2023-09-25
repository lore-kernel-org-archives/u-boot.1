Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF4DCE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CA286B9B;
	Mon, 25 Sep 2023 10:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ZOvzfh8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5161686B4E; Mon, 25 Sep 2023 10:10:14 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0716.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0500D86B76
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X53c08AdsUW654fHwR46lOABN+iOTdsaqgz3RBq+QSjMRKzx619DisD4b4dqi/cEAe74OmGbZ3zSgPGxbicfAhxi8O44Fx0/ChMTdSj+K19MlSG4s+gVakwSnqope3uUSbI0G80RMpBVjSL54iDYfdWfkdTfzQ9DgZhozJW4b65LYp6VacFprjnApqo7Wc35fXca+o6xs7e5gkZ7ixr5PXC+03DyuFzpfq6ATRf4HHgh2sejx8kzrB24GcbMb91DWLBl8l0WYasygcVuW83J8kQPHQ2LQwREw+mvWtogjuY8i+aZKnNrbXszUHx7O+LPZ4SqtYsU4qd9GqnYhhG06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkk+AU9Ln+DPYtRwRkV8l1xFhoE83A8JjLjWZviLUaA=;
 b=FRaAzP27BMmbu0xKfQMoeFQJXo9EaUmLRs0QqvvtUHsCZHRWbwkeGxWu8m142X1AJwo5Gwk9CfaLDV1Vp9LBIWP4l+YZR8HmxMem9S+FI2a2XTYKGjkTVE+GqfjVZDAcqC+CUuEJ/GrAMDPtz4kslJtg5ffGWKm+GRC8O0POKja6lMzHG4V4hxzigfo/JGRbPMrB+1I/YpaweotETcqoMRnW8ad0Hs3vMKINXx2vw0ORK+/kMX/OeBClKc/7MtSz1duVldxiyaopI6a2Xpo28geWOy+voH+YW9pHFLC8tgyXrCsYRcxhOtsgH8nkukSAvXb+wq4aGitN/PCo7blNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkk+AU9Ln+DPYtRwRkV8l1xFhoE83A8JjLjWZviLUaA=;
 b=ZOvzfh8ypAsjSX2xWVDK+whAEj4aSiNtohX4Gfqf/ko830a0KV4T9w2JovX8qUSIczqH3X+pkoSblgavpJpraf3WcdCjlx8fK8kDqJWQCNg8UhD9fsZ+9byZw/fSuJ0w8pNyRHhLiSS2BSb2wyH98zEL6NP4mryl9uOt2O1AV8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:10:08 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:10:08 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4/5] sandbox: rename overlay sources to .dtso
Date: Mon, 25 Sep 2023 10:09:08 +0200
Message-Id: <20230925080909.365098-5-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:122::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: c62ee477-bd32-4d28-3731-08dbbd9ed54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAvyjChzjcXosPf4Hgy5TMJW8KcVhuPWXI5dm08xGeYQYTSZsqK+lYegKuTVThcgR9U1q0bt8ovwcSuwKN+lIymyxQyfKRodaK5qJqC2TjSwW34gu1BQiLPtJiUogENeL7daWsaQkYoP0TlzSuTD/1mxIDyh3VK0nr5zEqIOss/iTc3PCl7jTfTiR8wn5MU4Y2jNwlphy/sX4jQ03sbLi43oLarPIDRb2VAPGnw3RxdqrBpnbB75ddioqIxXciCxLIbeQCLVU4Y7FVFqXrcXwOaXx0Q52X6bwlCIdbKM3EaQ26zT5ND2Ym6Af/slZFxVUfcRYOiap2TWhfb6RspVp6NHtbr8OdhZCfV3gV38D2/RL+kTpDs+bHW8wHYReXRZxB9u2RC2hCWwbrMd28wWDuREKlnrwmMNGHzltqkBERib77x22TXQ17pY6b6DlqY1E+Ulih+dQ01CVgK2BW6yfRTq01vQ4YaRr0WgHrtx9lwW2hN8LMYZFAXaiI6fsB060bp/Vvwy9h66YC2k824Y9F9tx70PV4I4VZJu+c0GKiliKtMdnAyU16IXDMyjs1SZzbUPWdo5wGWzOA29N5ebmKvoDP6EGPYQz09aNZyTa1bcuku8LNZqw4HKbn2Ou5JIXLjbXfQWvNkkGAo5QL8szg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(36756003)(6486002)(6506007)(26005)(5660300002)(52116002)(6512007)(54906003)(66476007)(66556008)(66946007)(2616005)(316002)(6916009)(41300700001)(44832011)(1076003)(107886003)(478600001)(4326008)(8676002)(8936002)(8976002)(2906002)(38350700002)(38100700002)(83380400001)(142923001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LiBaO+H9G/jnqQFXNYrgx8DMH2Nsb4RQhtB6w2q7yh2u4r2PQ2B6Z9dIKrD?=
 =?us-ascii?Q?M4NyDnVuiZE3bzbxTQiQtQvwryGI3sL2w2MFxpzUfA66ZX8NWAbCOSWRtWpP?=
 =?us-ascii?Q?3Oyn7CUYHemGR0Ji4SbHFeJcgr1binL23TcxBmrdW1McDtlbrzS+X5fA1Shg?=
 =?us-ascii?Q?rJZQ8ZY7jUYE5g3ct/ilGP18GF+pjPBGg/2IpoVST9Y7QG7tSeIh5AnhBsHy?=
 =?us-ascii?Q?lfoPQEwJG/HT4s7xlRjptMCIltF43V8Go5BBwU2fPPoc1sM8B/Pr5hSVYe8/?=
 =?us-ascii?Q?bp97dGSO/WhM1NjaLy92Ed4zSOt/mRwS9vWf35TnCUNirpt+2FIlQww+7Btc?=
 =?us-ascii?Q?nu4tWxLkxvROTZZ8wXy1Y9Fi/fyj4SJ+cV5QJaN0YBXhbDa2T+Fe9yQcjgYX?=
 =?us-ascii?Q?7WbhH7I61pd5RG54fPh7cOGsUaVDW87tE1XDpwG4zqHaA9NPM/PZnT01Om1a?=
 =?us-ascii?Q?qVewoCj1iMoYwiJxH5IdPLKazn4HLwpLdhvqc/CCW0j/Hi2BGFaG2V6+/Ecp?=
 =?us-ascii?Q?Th+h6DFU/fdmsitwyshLsrlJC1gRgIFCmxJJmkW9JHrQyaRFb2AT48hhPLmu?=
 =?us-ascii?Q?xvwuwmbBZLyBgpo19w46esexDx0SPaNpjqrcCd13a3Z8bhday3AH8aJ507oi?=
 =?us-ascii?Q?fWl+EwXkAAyMhFL/Qk+SljdtNhEkU/t1GbghZdUXOmKWboZ9Fii+UbcYpE2n?=
 =?us-ascii?Q?/q0bgLyiBbdghfuSg0cfwXtSmG9PvNOtU7lyHg/j41nB507jIjGmw8dGbF5t?=
 =?us-ascii?Q?Q3p5t5UshSueQmtVqsicafjFXmt/6VV2+uuTVZIAQ8SPQxyETj9l+6+N+6ns?=
 =?us-ascii?Q?PhqNmEBhS1I0n8qt87qeDkJLDjeKFBEpc8E9Pr8PB/JLaQAO7VCpQvwuX1nW?=
 =?us-ascii?Q?r6731lg71jZwpnXT2R2ufZcI8syTNGHVJ0LMCKZ/O2ayb7vHIS9C84QUkwr6?=
 =?us-ascii?Q?zaHocOigyms/PpZUeDFD/BQjOQRggLs4PKfTBhqeQwM9OBXuwWWZZzdxEDbM?=
 =?us-ascii?Q?8AXFXZwt0iJa/3G/Wvj8Jd10ki2XSHQMXzuBInQFa65/8MI/zkIbvTy4vFdo?=
 =?us-ascii?Q?VryvLqC51O76Mj3fA7S6UPSqVtrboErA+t/x9EJt61Hsa4mDDa8doqmMreS+?=
 =?us-ascii?Q?ix5crAjXzyn09OTzipvPObnqCokKniX09Ns6cpD6klrZr2BxYFz6FRS+EEbY?=
 =?us-ascii?Q?0Y7h2W0/Mo1meYabdSBztzCILcuSF5jOpFpZbLdtnMZ9ccKLvHHbjV6eXV+g?=
 =?us-ascii?Q?XXqp7cOWn+FURIS1phxfpkEEgAR1ysP7nGdYvrUtNUshp+UmozOg4RQ0641J?=
 =?us-ascii?Q?k3FPP7JQtMWYppu0w1jPfTgGiidFUYn3Wt6epmORAmsGqx5lKcnyLOF0k8yN?=
 =?us-ascii?Q?u1yjkxnaBo1NhpC9kjRV5oZc61Y14nGLJUWrN9d2ZmPbQ/V+YwvPDTm7TPQc?=
 =?us-ascii?Q?C6WVXTIQem8caFN8kh27f1V0kmYcZPfwnlQaXQQIj+T0icPvsWvEYmdqProN?=
 =?us-ascii?Q?5HVlA5T1fBXXb+KXxkIgKIxLpwb/STpliXCmGhUVewtZxRWuUOBlPpUmcQrk?=
 =?us-ascii?Q?V4aZlDjOfIknM6Nvys4szpj75eHDMj2je2ji1epk4FY2PRxGL+Tguk+oeL7x?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c62ee477-bd32-4d28-3731-08dbbd9ed54b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:10:08.5404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKJLAbn3kkilPbW76RDEOxTXgOeP/oj8mk49WHwUzk2JH864vi+YXD+qtMXk4ffUpUtRn51FdZFOnQuMLOVXLRZNZHu3yosM40WW5+7jBDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo. No functional change, as we
currently have rules for producing a foo.dtbo from either foo.dts or
foo.dtso.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/sandbox/dts/{overlay0.dts => overlay0.dtso} | 0
 arch/sandbox/dts/{overlay1.dts => overlay1.dtso} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/sandbox/dts/{overlay0.dts => overlay0.dtso} (100%)
 rename arch/sandbox/dts/{overlay1.dts => overlay1.dtso} (100%)

diff --git a/arch/sandbox/dts/overlay0.dts b/arch/sandbox/dts/overlay0.dtso
similarity index 100%
rename from arch/sandbox/dts/overlay0.dts
rename to arch/sandbox/dts/overlay0.dtso
diff --git a/arch/sandbox/dts/overlay1.dts b/arch/sandbox/dts/overlay1.dtso
similarity index 100%
rename from arch/sandbox/dts/overlay1.dts
rename to arch/sandbox/dts/overlay1.dtso
-- 
2.37.2

