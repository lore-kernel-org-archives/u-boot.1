Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07AAD15D8A
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 13:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D8C88CFB;
	Mon, 21 Oct 2024 15:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="VDnG6baZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3876F88A24; Mon, 21 Oct 2024 09:37:26 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11AA889B3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZebVnv//4ufnhznAtEUm50xFxWovpBCOnj+KtALhsFEt3pN/k1e61musRFnNuE4ULHoa9Fea9GwENXkbgkwR+4edBxaBgTFEJ5Yh4hxtIXeomIzfZn3OzqCGQ/6s+sYJhyfj2P7Fp/ZZHnOql2Ew6vzsIfIw8hVm7Bg2Zf5xHsSaMpElEN8vPZI5uUe0GawQbFEZT1JDleKGgrr2xWaElZBHgoqUptbrJFzx45r2Ucep3l3BI0KNj4RhBczoDoEONVnowGtwA2cHZcDFpjVP5qq+Yj/j3M3oYv99kR+NTfyf86ZR7hFxVrk7qqp8exTKHhdLwmaCWynuYmrvF6rNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qsv7k/Dv7ebgCnYR2LIjnXgOdsTDcXKhJAxIj6drqKI=;
 b=iftHU3pP0xZEMrqLkza36Dx3ivAFdlmtMvlGcM/i0koMzsTqrURnF6xaZfxPn7wcL5ygeRyttSxMV3jKIhp2T0hLmcQstxUl/WOCy5gMtDbnbQ2j0NqkoA4RRM9Jz3B0nF0C1pNocVrd1Shng8bNEctr5WS+iqMWxTA68ORStOZr8Z5lvZF/BjJKzfF5OMDQByAaJxK95SeLo7W8N2wxW0g7aePf5lxr2QTRCmlRimReNriFNvQ3V8Vx24LdjYzMchPsZDQFOuWXfwjMG0ryt62lYy7xx3HaT8OoiKSagEllQbpdG71UXIw9DnOuqcFXUen+YTcykkbw9JJaJ7Ymng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsv7k/Dv7ebgCnYR2LIjnXgOdsTDcXKhJAxIj6drqKI=;
 b=VDnG6baZvV9HQ+GvUIYl61ObbUg6nHALkJk7HzN3UchTNvfMf1lvfcAPhoIjp3Pw3Gxi2+RX28nW4WUZ+hMScE/KL/NVaXjduX9aC7lzPfn0OVE2DuMofBoDd1aw3OYeTSO/Emk7IISMT9q8lfwjuf5wMeEHn/bubFjaQ7H6L8+u8tVBKM5cQClOAIXYUfRrboMIlCR86Tx+lqepwmJ6O/9IYwcawyiFP7a2KVi9i/1iR1WmJRPMyTOu3ICG/mY8fXj6DeyzYz/v4169v6GN6PH5dL5q+5MkMgs22dHR7AyhYnbZcd8yAsQ82IU+tZmg2scClpN48/Sn66D2NBjKxA==
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by SJ0PR22MB2970.namprd22.prod.outlook.com (2603:10b6:a03:424::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:37:20 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::1d) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 07:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 07:37:20 +0000
Received: from zoo11.em.health.ge.com (unknown [10.168.174.93])
 by builder1.em.health.ge.com (Postfix) with SMTP id 389FB613D;
 Mon, 21 Oct 2024 10:37:18 +0300 (EEST)
Date: Mon, 21 Oct 2024 10:37:17 +0300
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] binman: expand test coverage to nxp_imx8mcst
Message-ID: <ZxYErbzoPScLkL2s@zoo11.em.health.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTg3RWyx_Z6waYaBkJMRKCQnv_cQr6xaMF3v9s_R3bKmYQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ0PR22MB2970:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e11acb-adf0-44d8-db04-08dcf1a33227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kvv+JeMGcjQ4LswN9Mk5a3lp/y2+nDJZWiGtxz9uwhAg1RJZBo2vBiYs4uiP?=
 =?us-ascii?Q?Ca4u7yc007sUB5KXvL2qbOdAAkzbb8G9wGbB4DfcYdi1u6nmyh8Bme3nFad0?=
 =?us-ascii?Q?46XvnR9e4ZtsT4mTRG+w7q5gexi5VbFRmrgS1CXeYsDCh4wOiw6v2XfpkNs7?=
 =?us-ascii?Q?vPT5+G/QhZWGh3CCPxL3vhH1QDTg0+Jwnw5bSe//2m36oDkEjQ1MtfgdFqfe?=
 =?us-ascii?Q?nXycencvDjo8Ic0uDLe7QspL6sOZx7vhlv17SPgyzodz974xXF1FSefflPr5?=
 =?us-ascii?Q?56SDMDAiIf3BbAGuuMggfMMdc/YmA8eOcaCLXKADwc+q8rMNHB/UXpzSnmGL?=
 =?us-ascii?Q?aXdpMN0b3ifhUtB0UEc6zYiPtz97UdvU8/WMNTkmFCdagEaWMtR9K+LUZPlc?=
 =?us-ascii?Q?dc/+ULVpllMqW1BENgumi4mzxI2dvHS8fRLjay0EgJ9V/XuvXdp8ZKjJ12Qc?=
 =?us-ascii?Q?TBWw2UOds9fhMb7iaQtDR+yxnoS2zlp1n+SOtjQ1VFvJBUYbl+ayAuOOK3VK?=
 =?us-ascii?Q?C3aB5E8mVlxXgBr9FnbiVKXG74CGnEm72Q0bew68Tw00yhnoIuO36djahgmg?=
 =?us-ascii?Q?kQp42G2QBnRLU8jut4q82BQke6ClfjI0TQEolRpAPjPGAYXkXf+z1leqPB+d?=
 =?us-ascii?Q?EHeoayS/e25u5qlRFyS+huTF1sf/ZzRAtEEimjTBUiNcHk1MEYbqZhoJB7E+?=
 =?us-ascii?Q?F3IOrCqjZq9xzbLwY0mQ84P/JETx56RFnlTbYo9bAgrQ0f5/ycJi+9cHROwe?=
 =?us-ascii?Q?UJ+tQiAy86wXVcsa1dyTE306FlVR9cRxCqtBo21v16S/S9YyJ4qzRESRm5a1?=
 =?us-ascii?Q?apDDuvuqTwmwoEtJbF9k2eCXG10pDSbTn/P0rB47p710ACGrUUpWvppXX1Pt?=
 =?us-ascii?Q?qvPOVBldPLuhckZeM/AZTPtwKOJ6khORLnOnZeQhKs0+FpzGeHFLlZJKUFnN?=
 =?us-ascii?Q?G+d3CxofCH4rJPQJ5P4UKwg9b8+ksuFgvIZUAaDIhqgziSAt4BzNlEE6DPl3?=
 =?us-ascii?Q?+NmMcIP+A3KA21Xvb0+g7gzoz01GnTnu2LhyN+rUxANYO8jTDOaS266recte?=
 =?us-ascii?Q?U+sljK9qQ39rZImA1oTbh3fBtz2cPOCw2Tl+FmAx8mjhC3Dy1O3E6u/65Pj6?=
 =?us-ascii?Q?dfUG6YY/BT9AllKzpsSk0hu5X3R0XVMWGmzuBPnJaJvStbXTk5yfQ0xbSq/T?=
 =?us-ascii?Q?btknhW24lexXsmVg3Qwa7yX3HD361KkE23k7HYwtwVHXOTJUvaImfNVwEHfX?=
 =?us-ascii?Q?CdrqrB59wZDMqoNsOyiKedyfmtLKrQRasihliJv/uujSO+BsvKi7BIa0brWu?=
 =?us-ascii?Q?QnK9qE/fb6cpsiDdwRZczNGxA6eqU3mnx72xL7FxaNc9wF2/hYEdDFjSRk5P?=
 =?us-ascii?Q?0UdUYaVMBG5ignPAm8Xh1KDNlfGgGEVnSoNtjnJmWvE4D/IsUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
Content-Transfer-Encoding: 7bit
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:37:20.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e11acb-adf0-44d8-db04-08dcf1a33227
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB2970
X-Mailman-Approved-At: Mon, 21 Oct 2024 15:02:15 +0200
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

Hi Simon,

Sorry for the late response, we had some recent network changes, so it
seems that my replies were not relayed correctly.

On Tue, Oct 15, 2024 at 12:06:55AM -0600, Simon Glass wrote:
>
>Hi Brian,
>
> > On Thu, 10 Oct 2024 at 05:25, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> >
> > Add coverage for IMX8M code siging. Create PKI tree and other assets
> > required by `cst' using `hab4_pki_tree.sh' script and `srktool' in
> > `cst_3.4.1' [1].
> >
> > [1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW
> >
> > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > ---
> > Changes for v2:
> > - Added missing *.pem files
> > - Rebased on top of "[PATCH v4 2/2] binman: add fast authentication
> >   method for i.MX8M signing"
> > - Included a test for fast authentication

> Thanks for doing this! When I run it I get:

No problem, we made an implicit deal that you get some test coverage and
I get my feature :)

>
> inman test testNxpImx8mCstFastAuth
> ======================== Running binman tests ========================
> E
> ======================================================================
> ERROR: binman.ftest.TestFunctional.testNxpImx8mCstFastAuth
> (subunit.RemotedTestCase)
> binman.ftest.TestFunctional.testNxpImx8mCstFastAuth
> ----------------------------------------------------------------------
> testtools.testresult.real._StringException: Traceback (most recent call last):
> ValueError: Error -11 running 'cst -i
> /tmp/binman.lk6cfgwh/nxp.csf-config-txt.nxp-imx8mcst -o
> /tmp/binman.lk6cfgwh/nxp.csf-output-blob.nxp-imx8mcst':
> 
> 
> ----------------------------------------------------------------------
> Ran 1 test in 0.198s
> 
> FAILED (errors=1)
>

Odd, -11 means that is the resouce is temporarily unavailable, no? I
don't see how that could be caused by my changes. I managed to trace it
to line 367 in `tools/u_boot_pylib/tools.py`, which takes us to
the run_pipe() function in `tools/u_boot_pylib/commands.py`, where we
wait on a pipe:

   108:    result.return_code = last_pipe.wait()

For me, at least, everything works fine:

    ./tools/binman/binman test testNxpImx8mCst
    ======================== Running binman tests ========================
    .
    ----------------------------------------------------------------------
    Ran 1 test in 0.318s
    
    OK
    
    ./tools/binman/binman test testNxpImx8mCstFastAuth
    ======================== Running binman tests ========================
    .
    ----------------------------------------------------------------------
    Ran 1 test in 0.333s
    
    OK

I've compiled the NXP Code Signing tool myself from version 3.4.1
and added that to path. The system I'm running on is:

   cat /etc/fedora-release && uname -msrv
   Fedora release 40 (Forty)
   Linux 6.10.12-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 30 21:38:25 UTC 2024 x86_64

Also, prior to running any tests, I've built the `tools-only_defconfig`.
I admit that I find the test suites sightly confusing, so I might have
missed something.

> Another test fails too. Do you know why I see this and you don't?
>
No clue. All I know is that the CST might work better if re-compiled.
Why would other tests be impacted I'm unsure -- what's the other test?

Oh, and I noticed that the first dts file had some missing path prefix,
so I'll send an updated version to fix that.

Best,
Brian
