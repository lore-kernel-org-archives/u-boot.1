Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D20C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8359F87142;
	Mon,  6 Nov 2023 18:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sachsensolar.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56E48272A; Mon,  6 Nov 2023 17:40:55 +0100 (CET)
Received: from DEU01-FR2-obe.outbound.protection.outlook.com
 (mail-fr2deu01on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e24::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C88787068
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=sachsensolar.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=verkauf@sachsensolar.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1fGlKkxBJlAULNCAAzlSpeZerCN7VtJeqtVkQX/5n27mZAkWnf1hSFvtcGlnQaQSa7gMxJaODqww59EBvFkB8xX1hzSE19CXsHI8FK3cM4CJy67sLy62m/q2SzyaluSlJsYdQJ576+XryaCW8QHdXp/tMnkealN6a20MY1hbEIEySz75KTeBQwIf0vQG8DjR8HBZEDe5qOJJetM2h94567qeweHk8C5Ald16h9BP+BJYDIfnwsCESq3Qq8gmIMoCCJpdNpcvcD+wC1F95cKhV5hWinm2BV083ILLwmonlGI3FB0TR5UU20i4vCelxJUoZE7lf7hCW7Glsoc13CpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPfNXh/Hd+klZZaQ0VxfziQID91LNJ6ZI8aPcXPjc7E=;
 b=mzW5g+nJEiLJmt2YUWftqTbD5IVQggE9qluPLGEBvdd6p/WjB+jpyaoZfcvk1UGf+ryK2Ji2ai2Mx2V2zVDoxxV5tLzYAoO0PVzyQDKp+3l5OnY/esy1TBJNNlEINy+KxlREFq1gHgQC1FAqNKzF6gDKPmLs0+LhBBR4K36/dpolS8NP/iFNs2beG/1aIuVpzKivmvkgsRR9kGcxEximy8GfHqNkTp99ZbdE3mSC2dZbxdXpbNxOPjscI+8SinFUOxz/EIP9Mad863yw4qOkayf/OkkGKaULV4qtCL895hmS4GIgQ+mDB6OqfViG05ggy7XsdOT0bEa6FbLugFufZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sachsensolar.de; dmarc=pass action=none
 header.from=sachsensolar.de; dkim=pass header.d=sachsensolar.de; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sachsensolar.de;
Received: from BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::7) by
 BE1P281MB1620.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 16:40:45 +0000
Received: from BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cf6e:ba41:12d0:25e9]) by BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cf6e:ba41:12d0:25e9%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 16:40:45 +0000
From: Sachsensolar GmbH <verkauf@sachsensolar.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH] mips: fix change_k0_cca()
Date: Mon,  6 Nov 2023 17:40:29 +0100
Message-ID: <20231106164031.297170-1-verkauf@sachsensolar.de>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::20) To BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:19::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB1602:EE_|BE1P281MB1620:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6f1ae0-6d7e-4fd8-988a-08dbdee71f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cuGq51gUEfc//rOQ2PEDklIHcNM1QV1ReiUXCWy1uYlybY0403zy5vDrZ9z2V0HUoDVMirgJCTjDE3avo0qMEGV8iBkfID9RZ3VJpMNGhIvWEGS7hQMrAAVPGCmr1jPpaE0kP3Q2fxQpMHnRPHYih8wlKbykqQIz3PvbrmLOpQKgCek2RLnzZuZkM3WjGRHwLusfKMFgZ0IXsfPthmmn7tCFrcZw8M4FjHU8Q1XrfvfEnAgTdB4faSDXgnQt625kzc3ko5MMDDPIckaQPoo425K5wrC9Maz8rBEG/bBfPERtcsanjxaSr6cHepu6e1NcKBoNFYTMH0Lkzxa86gPIVLh5yvVQ8FRmwr53W4Hghgo0GKuqxm4wovg/gZxCaraRG1+w/giEWFyx180LOLYeXAb1adBM4jjVd44tjCd5fYm1WtdVMbUUe6ro9nBMSzcUqsxotMcpb5qBgEohU4W5PC3DeH3eeFb7ZGpTkBCCzNHF5al4mN5+dFL3IwYJCKTly+qPHrv4FLYg88BtooJPkpGA/MEaa6BosX3HKQpldM+ByNYTmIFVDoYSrA+pxLbYBgGfSRPEJJubuWkYlTFyWO9yQY0wt8UkVhaTzupHWaM/71EX1zESTq0zrDk2PsUufWMHiLveZH7BPz6ILwi7qcy4pmMtAf7HP67Z1GmutVnq9S9o+GNUnpxsQhhqxL6k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(136003)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(52116002)(6506007)(2616005)(6666004)(6512007)(966005)(6486002)(478600001)(83380400001)(26005)(1076003)(2906002)(54906003)(41300700001)(66476007)(66946007)(66556008)(5660300002)(6916009)(316002)(8936002)(8676002)(4326008)(38350700005)(38100700002)(36756003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U1T4EHumOoLp8T6kh73gzoQGIfkQyIwD2456vQHDldM5/mB8V9wBUqkp8QZ7?=
 =?us-ascii?Q?ZIRsl8hgchA/mTN0wOcMDuIczkFrUGloJd2q59W0KFy5P/Bg4NHN/LgtUvYW?=
 =?us-ascii?Q?C/CK7ioJR2oxOM0lmwVVk3StxjBrF0r5mdmgLVZ/z0tMEsLZH6bNAXI7bRbA?=
 =?us-ascii?Q?qvTlwynPB6OJDnAdXAzcTDexUlUpU4XMREyH7JJXjcc4ZXpVOGOhs8vr6ASL?=
 =?us-ascii?Q?lYFwQs9YO9kjrTK1kEOBXWq1cbc3PxFhI/4reikRtMbgcorK2F91WtfSASx2?=
 =?us-ascii?Q?yx/cPpFEDjc8jAB4R62wzAkJYNjnSwB3as9ejIAsCoRgI9/biQqQ+R33lFNE?=
 =?us-ascii?Q?5tU5itbUpQ5KtN4ea8NCTcNkNbIENEdaxGE8eoN8cF1m/K6kYmLz19r3hjtd?=
 =?us-ascii?Q?GrwizU/dvkmqEwTDQEb7Tvcxt1y7tewijGpbI1tMNAjzCKAVzaZDYSIe17Qz?=
 =?us-ascii?Q?PoqAqHVOMYIR0jAbx0U5k1VCpE6KCAgFLU1N9N9T8k5Sj+xyK4OrlCbTicCd?=
 =?us-ascii?Q?Z0A977tMKIdGvUQ7jjWREhc0G5SaOhbLxzEciGFT59xze46dLnAPcM4L97eV?=
 =?us-ascii?Q?q0YEzUMTwTBzjigoYD69O3wq4EcQ6XYubuU5xT9Kr5f4nIeUy5nj9qKOWWB0?=
 =?us-ascii?Q?/eZap3nIpRrQ3pYq+UalO9TVIzKkc3xRGw9wjjjMXdNwgfLVBmUzL0JyaAny?=
 =?us-ascii?Q?bR4XNauhv+Krv6r06np6NkcZJkh1tLZUqI2SZFNz9jaUspd9QgRKFrLI4Glc?=
 =?us-ascii?Q?DxKnWjyjLyxyz+oJ8iOwOW7OupwnThnDZ822A/dFxMwE7G2/F3bEqK2u1FRa?=
 =?us-ascii?Q?3syJ7uzODrHTMIgV9UMjCRBRMY7OKc3BwAwsFCLPnlNp3N28stCScC+TuVAh?=
 =?us-ascii?Q?uX9BovLy+oFFxaw2Mg8STLbXd4jxLOhwMvWnFP6Ujb2zkxsWZTuZmYQjrjQY?=
 =?us-ascii?Q?4ouMwWZcWX6WpGRvISl+JZrDoMZW+nI26CJg3LzaD+GKfl6FbIU0N1GYM/0Q?=
 =?us-ascii?Q?DzoOCVppa+rLl9qRuTimYd+ZNAXmEyUQzrarIJCw1pjqih1q8mqM4IYrOGOV?=
 =?us-ascii?Q?MOoicGpLbfIajYh/+DG4/jhC4QY3U1YJBNbsQFwlFuhUopeAZcH+6sePyOPW?=
 =?us-ascii?Q?ZnMep1HKuhv0cJvA39UsvfNISU3fqJ3y2hCjHFMUblEsL3fHvG3hkArmyBse?=
 =?us-ascii?Q?C0bP3A2H6ygY9nGe37K8KjobYQmzitLG8E/NX9fDhwQzWDSTjO18bsOwMnOa?=
 =?us-ascii?Q?N6yI63pUg8V8ildYbPzZLANnt78jPHlO7/WvEOL4T9wBTAZhhn4hEyPKgYJQ?=
 =?us-ascii?Q?dtGFut8c4kSDMa2/7oMMyVZNAgViGgFSJgOf2eddPQ5E9T6mPitgPEAhenIu?=
 =?us-ascii?Q?Z2SflVeD45os/ZsTpyG0hLO/WgjoX4/vMBQ1DJq7Gt1wuLcUZa48HX3GDhiw?=
 =?us-ascii?Q?vWwC/1Et2CC6LRnGrMzo8AFwR6RKi3l3fzhp7oum3eIaM9tG/87IVoQnvy8i?=
 =?us-ascii?Q?TCvpEYrNUaKJcjb7uLdYX2UW15ZrBctlBZG+JcFHFyhZlQfb42sQCmzMH5X/?=
 =?us-ascii?Q?VkWt72PMcTb6n4+VLw3DSL9Vxe8szvKMxE0B2HDuKFhyhYhoDG1I8lRuJi0h?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: sachsensolar.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6f1ae0-6d7e-4fd8-988a-08dbdee71f7f
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1602.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:40:45.2088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f3a0975-10d3-4ef6-8a35-d1ecb2505887
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHZJg6U00K/fNinx6yf1BBjevMGPM9QMFphy6+7+V1s/w8730mPYnE+BpT9sqvlvuDeeZe21ATi1YZXeZKNaMOEAaJtMgTAmwcU/Ge9IAYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1620
X-Mailman-Approved-At: Mon, 06 Nov 2023 18:11:22 +0100
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

From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

The intention of change_k0_cca() is to read the C0.Config register into
register $t0, update $t0 with the new cache coherency mode passed in $a0
and write back $t0 to C0.Config. With MIPS32 R2 or later instruction
sets, this can be achieved with a single instruction with INS. The
source and destination register of the INS instruction is passed as
first parameter. In case of change_k0_cca() it is register $t0. But
for writing back the updated value to C0.Config, the incorrect $a0
register is used. This is only correct in the MIPS32 R1 code path.

Fix the `mtc0` instruction to write back the value of the $t0 register.
Fix the MIPS32 R1 code path to also store the updated value in $t0.

Reported by user ddqxy138 on Github.
https://github.com/u-boot/u-boot/commit/b838586086af3278bcaead3720c7a18813cf4619

Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

---

 arch/mips/lib/cache_init.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/cache_init.S b/arch/mips/lib/cache_init.S
index 602741c65d..d64209d76a 100644
--- a/arch/mips/lib/cache_init.S
+++ b/arch/mips/lib/cache_init.S
@@ -431,9 +431,9 @@ LEAF(change_k0_cca)
 #else
 	xor		a0, a0, t0
 	andi		a0, a0, CONF_CM_CMASK
-	xor		a0, a0, t0
+	xor		t0, a0, t0
 #endif
-	mtc0		a0, CP0_CONFIG
+	mtc0		t0, CP0_CONFIG
 
 	jr.hb		ra
 	END(change_k0_cca)
-- 
2.41.0

