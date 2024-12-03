Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C1DE64A89
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455D989671;
	Tue,  3 Dec 2024 14:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="HMAISgJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9163F89345; Tue,  3 Dec 2024 12:44:31 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9AF888BE
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 12:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcYEmSBET7Lbq3VUDlQG4LLILKcOj0R+1U3UdbFfv+0AJuLk63jRV7YIBFft4DSp4tsfL6ZfK1sryiYgnTos09f3UIyVuMdiPKl6e+JwDO6bu8TgWT57rqA/fSb0Y+eo6BFsopTnXat/8IjDnep6sq2A6crLr29bfwLjcqS+bQJGR+0oQ9oIEkXt2hFRXpAKrSVa7M7jPRbpkDqwKI1t//x5geP+icE8/xFLMaTHXRwsBXzVEW2oKwhmlE4aQQk/+K6/NriaAhRY39qLV/fvvy5L60C4l99IIdyVEmQ9rzioVQg3kJOmsnPUU+UJFr6dQvlh6G8KhgZ9qf5DL6fmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZxSlyj32ljr2qhkUKoH+25GSRmXJQF7aV+PTqY1bJ0=;
 b=JgYG81L89bLr2pOW2eGfdhBXXAIrpyJ/uGp+hwmFD/PfbQglCKPqATC3UGMTtGoaKno+0kq3AdtMiOc7jBGtVP+bEeqzo1ZAjhFsLkGDsyDX8YzNy7DWld2Y7X4GuZFvCUZfvaqr600CHX3yw79WPPNJNYqOMUSfwi4qjmhPCMfIlYm+OOwNG4Y2w3e+4UuwI83bTNYD/fOWDdalSnyB5/3WxaKbLGHBhwsEVTBDKcZ+M9IWOgxazTfJUx/Rl8DxzmHQ45JrrLUAabU9aAf9npmFJgy4mRFI4ZHP7Z8rjQ0w6n0eASIQOLEkn6Vm+LazuwBqu38yvLOU6hbD3gnXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZxSlyj32ljr2qhkUKoH+25GSRmXJQF7aV+PTqY1bJ0=;
 b=HMAISgJuuOi7c5ER+X3A74q5hABvAUB3geRokGCP1KVCaUpaHrg3ZmoiE83isgMn1G/G2c5NFCHj19XeW4AiDlmskJ/rA9xaCWdiLM4PTAkU1V3tQ0eq+RDBiEg/ivTz+vsQJwZYkKyivsMYCPSYwayK4HX713M79F5oNBLk3IrDgAoegWafclZRtHVGVqM0ZNGQwSN1nPFaSp1ndNTnus9+LkhyH/Y4kN5CIRI+9K3mgSrx+R+QI8PMpzTW6jVrkEwXpnZs4iz+4T9Lux84+b06LsQl77c9NMO6vb/BvppKDvXWiQwSlF9Y/5B/5+YXGv5GeNBI4BrjPIX37QfLaA==
Received: from SJ0PR05CA0197.namprd05.prod.outlook.com (2603:10b6:a03:330::22)
 by SJ2PR22MB4154.namprd22.prod.outlook.com (2603:10b6:a03:540::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 11:44:24 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::65) by SJ0PR05CA0197.outlook.office365.com
 (2603:10b6:a03:330::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Tue, 3
 Dec 2024 11:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 11:44:22 +0000
Received: from zoo11.em.health.ge.com (unknown [10.168.174.93])
 by builder1.em.health.ge.com (Postfix) with SMTP id 607E110F;
 Tue,  3 Dec 2024 13:44:19 +0200 (EET)
Date: Tue, 3 Dec 2024 13:44:19 +0200
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/2] binman: expand test coverage to nxp_imx8mcst
Message-ID: <Z07vE7Rwvv6xH737@zoo11.em.health.ge.com>
References: <20241021073749.63-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-2-brian.ruley@gehealthcare.com>
 <CAOMZO5CC683+5_xohQw_F0kuiE9mmL2PqjqHk66A1oUXje=oSQ@mail.gmail.com>
 <ZyiGvONusmq03cBO@zoo11.em.health.ge.com>
 <CAFLszTj=AfwqRU=ON4psoJR8Rdu=c3RtPzzSKDsX_BoteWHZFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTj=AfwqRU=ON4psoJR8Rdu=c3RtPzzSKDsX_BoteWHZFw@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SJ2PR22MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 61093b50-e9b5-46ac-b67c-08dd138fd4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ki0zl9dFLk0NXfTG2M75hTUalUdVgy6JkpzD4YXAlJiAAsbVK6O/ZWB/VufK?=
 =?us-ascii?Q?hB0uto+uxNCCiNgFU1D12bfGruy+DtF+lZ4HnNFrSue4RW3fJ9lFz04nZDE5?=
 =?us-ascii?Q?wdtveuLTWJ9q1OpOpLaN/bg/VAbx3n0786KT3xikjAT2WqV/l8yHKzVOoPGe?=
 =?us-ascii?Q?gowThwfc0fDdZuqCEfhzN/sBMaIIoeSGAbCSSwxg4yTu80P450+TPggZq0EL?=
 =?us-ascii?Q?8I8wiHymnP0dLiDacd97eRUlldGzGefkxbaEWC0Fp1kOR24phuvThGnPjMMw?=
 =?us-ascii?Q?pGSUFS6mPL5/1l0Gs4d3tRLLFSsww3/YoMMDO9ASiJCa+sfSdM/Ms4pYHLzI?=
 =?us-ascii?Q?2+fT8MBTA1dBEjGf7iAq+0gts28SO2779FzDU7fbxLCQ02q1gMG1uF5xrUcJ?=
 =?us-ascii?Q?+o6jaBq4F1FFSyHgpk9yDoJK7PLLuhc0U0SyVvAOCM/GcHZJlQ6zqffa+H59?=
 =?us-ascii?Q?L4TJNi5qytausS2Qp2FR8HewBUcno7wwyCv6weCmIg82/AFeZd5RItu4SM5O?=
 =?us-ascii?Q?QEMf2VF/rCY7Gk/ylolTM2KDKtWGG1IdMTaG1gGgsl7VIgyjJ7zCuiKbzGFj?=
 =?us-ascii?Q?IqguJ+ryH+dpHZoFCUFhFWUCSKtVnrvtbtByI8xUNg7P/OTQsgQgU4Nyn2nv?=
 =?us-ascii?Q?Hm3Tit1D9Z8sIZNdnqB6tKbySBb8dQULiSpQh4pFPEsolMaIfTuD88O8DNjw?=
 =?us-ascii?Q?Vw/nRLI1+Qk/2e2HDqgodqyNH1rD8r89yLzSsaHrVoMf4qMasFcNgQ2c5Jfb?=
 =?us-ascii?Q?+N0MDPX8WFcrssBMrgieM9Du0zJ+fxJhM7giw8FfTa+fkVf5EX8sK+YIygdW?=
 =?us-ascii?Q?PgJIJsi2REHZ7PM7rtK+fqM9Paa248SvE5SPa/4qfp9U+WGki3PaNXIEYHP9?=
 =?us-ascii?Q?dtCDwQwLtSvzYeQkLvl8k5Q1i5ENnpWSyTEyUM9koaWXSfXUJFcWTOq5UCxD?=
 =?us-ascii?Q?+ExjRVVKKrgGVH92huXp2ljUjEU1MJjK9Q+ep7cFklUcz3T7vwIDHoa78WJX?=
 =?us-ascii?Q?R9mUi/Cbmjk5y4V9t0r8aGkjyyZavxS4ELc4lftSpFU5u4hLHJH9vOXKl0yu?=
 =?us-ascii?Q?8ViA6254xNyt11yRmKVVuq8IZY732lwcl/7GENIXvpa09wRl9lHy685dguB8?=
 =?us-ascii?Q?3CmK+pJwXGi65LrSRZ3NvsiMbqDn1qs7/9WZW35ARq885uCjGPvSKPmA7Grm?=
 =?us-ascii?Q?Ojp9n9LYrAjU3A3m5VtJC7hpzr2Yoh+5uZeAiWnMLoDRp9pOjM5YyBYH620P?=
 =?us-ascii?Q?ENyAHvEsNDr+wcT2aDBWZAqN1jghEtre/wlcoLosrtPNFN4hlkDWaFDy0+v3?=
 =?us-ascii?Q?wgw7HdKD3dKFVPzNPBWM6ioQQND/KKE7hiI5wQx/IV139F7La1jSBcReviSO?=
 =?us-ascii?Q?dkOY6i+xDQxTEMBi/Rre24BHWLAn?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
Content-Transfer-Encoding: 7bit
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 11:44:22.6020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61093b50-e9b5-46ac-b67c-08dd138fd4da
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4154
X-Mailman-Approved-At: Tue, 03 Dec 2024 14:04:42 +0100
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

On Wed, Nov 20, 2024 at 05:40:42AM -0700, Simon Glass wrote:
> 
> WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> 
> Hi Brian,
> 
> On Mon, 4 Nov 2024 at 01:33, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> >
> > On Wed, Oct 30, 2024 at 09:23:46AM -0300, Fabio Estevam wrote:
> > >
> > > WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> > >
> > > Hi Brian,
> > >
> > > On Wed, Oct 30, 2024 at 5:08???AM Brian Ruley
> > > <brian.ruley@gehealthcare.com> wrote:
> > > >
> > > > Add coverage for IMX8M code siging. Create PKI tree and other assets
> > > > required by `cst' using `hab4_pki_tree.sh' script and `srktool' in
> > > > `cst_3.4.1' [1].
> > > >
> > > > [1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW
> > > >
> > > > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > > > ---
> > > > Changes for v4:
> > > > - Rebased on master:
> > > >     340_nxp_imx8mcst.dts -> 343_nxp_imx8mcst.dts
> > > >     341_nxp_imx8mcst_fast_auth.dts -> 344_nxp_imx8mcst_fast_auth.dts
> > >
> > > Here is the result when I tried applying and testing this:
> > >
> > > $ git am ~/Downloads/v4-1-2-binman-nxp_imx8mcst-read-certificates-from-input-path.patch
> > > Applying: binman: nxp_imx8mcst: read certificates from input path
> > > Applying: binman: expand test coverage to nxp_imx8mcst
> > > .git/rebase-apply/patch:206: trailing whitespace.
> > >             X509v3 Basic Constraints:
> > > .git/rebase-apply/patch:208: trailing whitespace.
> > >             Netscape Comment:
> > > .git/rebase-apply/patch:210: trailing whitespace.
> > >             X509v3 Subject Key Identifier:
> > > .git/rebase-apply/patch:212: trailing whitespace.
> > >             X509v3 Authority Key Identifier:
> > > .git/rebase-apply/patch:333: trailing whitespace.
> > >             X509v3 Basic Constraints:
> > > warning: squelched 7 whitespace errors
> > > warning: 12 lines add whitespace errors.
> > >
> > >
> > > $ ./tools/binman/binman test testNxpImx8mCstFastAuth
> > > ======================== Running binman tests ========================
> > > E
> > > ======================================================================
> > > ERROR: testNxpImx8mCstFastAuth (binman.ftest.TestFunctional)
> > > Test that binman can sign an iMX8M image using fast authentication
> > > ----------------------------------------------------------------------
> > > ValueError: Error -11 running 'cst -i
> > > /tmp/binman.tf697xr9/nxp.csf-config-txt.nxp-imx8mcst -o
> > > /tmp/binman.tf697xr9/nxp.csf-output-blob.nxp-imx8mcst':
> > >
> > > ----------------------------------------------------------------------
> > > Ran 1 test in 1.318s
> > >
> > > FAILED (errors=1)
> > >
> > > Any ideas?
> >
> > Hi Fabio,
> >
> > Strange, but I don't have a clue. I was able to find the bit of Python
> > where things go wrong in my reply to Simon:
> >
> > > Odd, -11 means that is the resouce is temporarily unavailable, no? I
> > > don't see how that could be caused by my changes. I managed to trace it
> > > to line 367 in `tools/u_boot_pylib/tools.py`, which takes us to
> > > the run_pipe() function in `tools/u_boot_pylib/commands.py`, where we
> > > wait on a pipe:
> > >
> > >    108:    result.return_code = last_pipe.wait()
> >
> > I also described the environment I was running:
> >
> > > I've compiled the NXP Code Signing tool myself from version 3.4.1
> > > and added that to path. The system I'm running on is:
> > >
> > >    cat /etc/fedora-release && uname -msrv
> > >    Fedora release 40 (Forty)
> > >    Linux 6.10.12-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 30 21:38:25 UTC 2024 x86_64
> > >
> > > Also, prior to running any tests, I've built the `tools-only_defconfig`.
> > > I admit that I find the test suites sightly confusing, so I might have
> > > missed something.
> >
> > I can try to run it in different environment to see if I can reproduce
> > the issue.
> 
> I believe this is something wrong with the tool. This is on Ubuntu 22.04:
> 
> $ binman test -X testNxpImx8mCst
> ======================== Running binman tests ========================
> Preserving output dir: /tmp/binman.imy5s98_
> Preserving input dir: /tmp/binmant.izmi883v
> E
> ======================================================================
> ERROR: binman.ftest.TestFunctional.testNxpImx8mCst (subunit.RemotedTestCase)
> binman.ftest.TestFunctional.testNxpImx8mCst
> ----------------------------------------------------------------------
> testtools.testresult.real._StringException: Traceback (most recent call last):
> ValueError: Error -11 running 'cst -i
> /tmp/binman.imy5s98_/nxp.csf-config-txt.nxp-imx8mcst -o
> /tmp/binman.imy5s98_/nxp.csf-output-blob.nxp-imx8mcst':
> 
> 
> ----------------------------------------------------------------------
> Ran 1 test in 0.157s
> 
> FAILED (errors=1)
> 
> $ cst -i /tmp/binman.imy5s98_/nxp.csf-config-txt.nxp-imx8mcst -o
> /tmp/binman.imy5s98_/nxp.csf-output-blob.nxp-imx8mcst
> Install SRK
> Install CSFK
> Segmentation fault
> 
> So the tool is segfaulting, for some reason.

Yes, I've noticed that too.

I'd suggest compiling the tool yourself, you can get it from:

https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW

or:

https://gitlab.apertis.org/pkg/imx-code-signing-tool/

or use the .deb package from Debian unstable:

https://packages.debian.org/unstable/imx-code-signing-tool

Pick your poison :)

Best regards,
Brian
