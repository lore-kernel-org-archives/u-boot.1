Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685E7D132BB
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C107788785;
	Mon,  4 Nov 2024 13:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="k23jt52Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9AC58852B; Mon,  4 Nov 2024 09:33:09 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B9E88001
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 09:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuYd1Hg5wrnIHgqMdgqtlyYMdcWx2ImxTxLKP8Snz6vMB9T+RL0qmDm30HWd0v888cxhpHZZOOWXcHYfqD6F+AqB15BkdQEVwyVdAi+VxeBMToKJQ/SYj4vNLh6M/BKmQPVra8koXcR3xvAlB9b8hikSOUAeXGyXSpef1lap6zKMOWogy2Uy1OJHmB0zOqJeJFb52Bc9GKO718B/6NcdOJ0nLyFE2ZUajb0rNPJ+nfkQ3SAWdEoFw7PKiOoZxWjwo1BBJtikMP9ek/+PXloCfeWRAf541mZK7tU0GMdAkrVKXeXpRv9MOY2Xgzt6Cuca62PWL2jvrhKRnvrtGIkMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um4QsGxy+332SvoYoqBD8avwlQDhus+0pWKnD9EVSn8=;
 b=yKzBwQ9AwFFlsLOAuNeHSlBEOxMvByC3qtk4GmQbraJhwbxGkRC7ruCS0YmgYYzN8dn0toiz9vor6x8ru8GWnafdlNNsoghVbkSwZnui/SsiqhiflZjgENJ+WpqzOoiBBNa9FRjBhUB9VmfFWESUy3g2sRXlzDMfdvefG5yBujNLhLOSKaBLFfQfC43dBBcfthec17bf0D0dx95GhpvY9UNZsntG9Fcuvsv43hkOJauotqCbDHX+2WyDvR1Ezp2KYztYUOfi2gww7dj9EWLzWgM1Gtyi0qQqqCQRzhJrAjsziAZ1tWQ1qDEwVFV5i6A71XZfb7gwayvBFc2LZ0wJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um4QsGxy+332SvoYoqBD8avwlQDhus+0pWKnD9EVSn8=;
 b=k23jt52YxCs9r2OBeD8f/Z5sU41CBqLyctk+Pz4rO5gwgxP8aEQqSZKNQZEgsmSFJ4fRr6FOFQ0uLPUBnA/WDo2K08dHoRzqHWRXqEe0PU3hkxzomS/KAq6khFdVhcYnhqCaqkvqZJckjA3x/Ae9EKFLPONBC6B7fWCKoegkCOul7A2OrsF/0F+KFW0XsugOqo/qO8cOMYTYmwzjTOsRg2I0AtWJnoXJhHeJRgX8gez8UfMLnkkjK80A2lAczitj8chzYvzIhm+Dd3W0M3tKAOMIyUT5/I/8O1Yrq9H0k5fmMuxaOQNqETQTVCgNeBB7TB0P6M7GXsVVKyAFA8omtA==
Received: from BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::6)
 by SA1PR22MB3779.namprd22.prod.outlook.com (2603:10b6:806:325::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:33:03 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f6) by BL1P223CA0001.outlook.office365.com
 (2603:10b6:208:2c4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 08:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 08:33:03 +0000
Received: from zoo11.em.health.ge.com (unknown [10.168.174.93])
 by builder1.em.health.ge.com (Postfix) with SMTP id 17CE29D4A2;
 Mon,  4 Nov 2024 10:33:01 +0200 (EET)
Date: Mon, 4 Nov 2024 10:33:00 +0200
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: ian.ray@gehealthcare.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v4 2/2] binman: expand test coverage to nxp_imx8mcst
Message-ID: <ZyiGvONusmq03cBO@zoo11.em.health.ge.com>
References: <20241021073749.63-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-2-brian.ruley@gehealthcare.com>
 <CAOMZO5CC683+5_xohQw_F0kuiE9mmL2PqjqHk66A1oUXje=oSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CC683+5_xohQw_F0kuiE9mmL2PqjqHk66A1oUXje=oSQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA1PR22MB3779:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ce5c75-7905-48be-1426-08dcfcab4c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yyGN3P8noIndPulyrRutLdbOsPpnA/s+kUtPy31zvVzM4JbhCpZft7lXAm5e?=
 =?us-ascii?Q?pQRYyhMCBeSILMxFO6wh3awHho5FVLgN2rlUxu3glF1HbAVzKx74wIkSUjyu?=
 =?us-ascii?Q?+puT7yOdQkyUa1ZvC7PXR6HJvgtFZ3Ria2a5NnbYBWFSKiJ75eg4oeIoPFea?=
 =?us-ascii?Q?bCmPyjVbn3PdGRI9f7ttD2J2LFmFJ1kIjZCluPVqFVN0KOVUzIKyKRMSjLtf?=
 =?us-ascii?Q?fPpehdCehKByGGBMe6OG4Sj7afYSmDJbLgZ+ZBWOVIpvC9jXi5aqNnEwFDiy?=
 =?us-ascii?Q?XbJDqeDGak9mU0nrFFkR4rZiK6N8OY9DFO7mjHvLyPDeARWxnGH9OKiMu6Nd?=
 =?us-ascii?Q?jy3J/W91YuhlDDTPKTz9DglOnQVZiR0sk53qFscZg/MHdHqGhXilZXG1EusO?=
 =?us-ascii?Q?d5N6AfeREahtQm3oF1F8iJw/j7nUOEbHUBZvrHG1imBeZjttT0+9/9/9ithg?=
 =?us-ascii?Q?nlf1G2RWWiZwjLV7oQBIRLwbzXaxEF95dLVU3BY2J0T33xd8f0iHjjlPiUWX?=
 =?us-ascii?Q?yw2n/YIOYVz7CEz2kAqqtK9u5vwXESHbtUEFiH1TsOZmu7/HBJ5SMLDpNyWI?=
 =?us-ascii?Q?QEZk/LGG8NMnGhn/tJ0wHQK30l1gxj2x4poMskSJhGlc3Ni+ZqYs1beVtqlW?=
 =?us-ascii?Q?7EOMmZkcQJDCPRRhPBfXO3IUVDYE1g80APJbGuwcewQ3J8+Hk0TWaL9Mhy/M?=
 =?us-ascii?Q?MQP7bbgzb/QGS7m1OFerch/In8wdrXP1n8c7OZm5ZH9iULtaFYIFrXn9EXbx?=
 =?us-ascii?Q?QgJmyVrkl61Ms+PIP0KvXohzVFTqm1DeYDAmuJrtQXbpeLR/u/qlnDOdyuJ6?=
 =?us-ascii?Q?DnI0TiGrn1y8grzdwI+qmNvH6JztxbLuR5XqH9NcrMuiMmfCk8Et2E6bs1tY?=
 =?us-ascii?Q?tHI1kmXWsiGHi7iE7j9JTgkVLvxrkljmugwB0RqCUg07U0l/8Z3gPEJjmtjk?=
 =?us-ascii?Q?HzA0hmM1JDGBARIy7HBs2f9miV2+yYUHs7iSKhZYqwNq+4b/suX+vV414jeZ?=
 =?us-ascii?Q?P80x+oGisMIFW+ryy6EYYLp3DdwAHCYtNrUJNEu1UAaj6w4lZaoMGDgC3nE0?=
 =?us-ascii?Q?0eDKjyUJmQckisQSKtEHyut+pzxyN/WH+1oZ7Q87TAa455VM4Fmus8msbcxA?=
 =?us-ascii?Q?3FYpF1nlhVUqb1tYOT0R6nCC6meHlyvev98dd7UyIO6JqjkaTpanQ3EW4TYq?=
 =?us-ascii?Q?s+E4LE3k55XTCaghnrVh0ID3/XyTOXfwIP+TiQA5FTaW9q4MnTkQiSnbnjVe?=
 =?us-ascii?Q?aTo1qZENT90d8Dv0Zf4SF7xociHScr/ExwOcQ6nq+inRflm06Uxhqaojgz75?=
 =?us-ascii?Q?FVO0Gm7J8uQvybxUaOab67O9xIznfLcLxABKiXpk3fl4bA0hOUW05RaN8ZLt?=
 =?us-ascii?Q?YWi15W4dW3gcHIvg2WaSaL7qLIysiz64bB3lQzzM6wdyutFWog=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
Content-Transfer-Encoding: 7bit
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:33:03.1289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ce5c75-7905-48be-1426-08dcfcab4c85
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB3779
X-Mailman-Approved-At: Mon, 04 Nov 2024 13:47:00 +0100
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

On Wed, Oct 30, 2024 at 09:23:46AM -0300, Fabio Estevam wrote:
> 
> WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> 
> Hi Brian,
> 
> On Wed, Oct 30, 2024 at 5:08???AM Brian Ruley
> <brian.ruley@gehealthcare.com> wrote:
> >
> > Add coverage for IMX8M code siging. Create PKI tree and other assets
> > required by `cst' using `hab4_pki_tree.sh' script and `srktool' in
> > `cst_3.4.1' [1].
> >
> > [1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW
> >
> > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > ---
> > Changes for v4:
> > - Rebased on master:
> >     340_nxp_imx8mcst.dts -> 343_nxp_imx8mcst.dts
> >     341_nxp_imx8mcst_fast_auth.dts -> 344_nxp_imx8mcst_fast_auth.dts
> 
> Here is the result when I tried applying and testing this:
> 
> $ git am ~/Downloads/v4-1-2-binman-nxp_imx8mcst-read-certificates-from-input-path.patch
> Applying: binman: nxp_imx8mcst: read certificates from input path
> Applying: binman: expand test coverage to nxp_imx8mcst
> .git/rebase-apply/patch:206: trailing whitespace.
>             X509v3 Basic Constraints:
> .git/rebase-apply/patch:208: trailing whitespace.
>             Netscape Comment:
> .git/rebase-apply/patch:210: trailing whitespace.
>             X509v3 Subject Key Identifier:
> .git/rebase-apply/patch:212: trailing whitespace.
>             X509v3 Authority Key Identifier:
> .git/rebase-apply/patch:333: trailing whitespace.
>             X509v3 Basic Constraints:
> warning: squelched 7 whitespace errors
> warning: 12 lines add whitespace errors.
> 
> 
> $ ./tools/binman/binman test testNxpImx8mCstFastAuth
> ======================== Running binman tests ========================
> E
> ======================================================================
> ERROR: testNxpImx8mCstFastAuth (binman.ftest.TestFunctional)
> Test that binman can sign an iMX8M image using fast authentication
> ----------------------------------------------------------------------
> ValueError: Error -11 running 'cst -i
> /tmp/binman.tf697xr9/nxp.csf-config-txt.nxp-imx8mcst -o
> /tmp/binman.tf697xr9/nxp.csf-output-blob.nxp-imx8mcst':
> 
> ----------------------------------------------------------------------
> Ran 1 test in 1.318s
> 
> FAILED (errors=1)
> 
> Any ideas?

Hi Fabio,

Strange, but I don't have a clue. I was able to find the bit of Python
where things go wrong in my reply to Simon:

> Odd, -11 means that is the resouce is temporarily unavailable, no? I
> don't see how that could be caused by my changes. I managed to trace it
> to line 367 in `tools/u_boot_pylib/tools.py`, which takes us to
> the run_pipe() function in `tools/u_boot_pylib/commands.py`, where we
> wait on a pipe:
> 
>    108:    result.return_code = last_pipe.wait()

I also described the environment I was running:

> I've compiled the NXP Code Signing tool myself from version 3.4.1
> and added that to path. The system I'm running on is:
> 
>    cat /etc/fedora-release && uname -msrv
>    Fedora release 40 (Forty)
>    Linux 6.10.12-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 30 21:38:25 UTC 2024 x86_64
> 
> Also, prior to running any tests, I've built the `tools-only_defconfig`.
> I admit that I find the test suites sightly confusing, so I might have
> missed something.

I can try to run it in different environment to see if I can reproduce
the issue.

Regards,
Brian
