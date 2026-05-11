Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3FECD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06538800AE;
	Mon, 11 May 2026 14:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wkibiBzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4A384706; Mon, 11 May 2026 10:27:33 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54DF484836
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbHlUqzzkk5i2GKP/sc6QCFqhxs+UwwAVpAbqHIRdP5wGnAtfgtqZdPwpcA6ArTdWq7ybHokEq/ZdnAD7bXEIM93M8+Y0jyH0oT11EGppvKAQy7TMBDvvdBJ0uwlOKXgoAF/GRZRYY0CdPusWciAf0K+W76fOa7iyH+VkhBNmT4jgNn/HRlvBTULj4UbuEEcMZ8P3vamaQ+xQvVlVUkAMF/kd6Ik2PPgHq2Pk8OeddOBQYyTd0Pn8b5NEcet80s2cJdwrfdbDB8Bk2VXnNpfYXWBnHKQlCmVgtiytbhPkN3QVAdskpy0eN2mnWvUMyl0THZC/88lDLwpNWqbq8vr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k22FvsWspMqC81QT7ZVSIZKWDeSyCNBqXCp/7+onews=;
 b=Qcr0UpHjQV6RK14q34OxepAsrDPWFb0QvVdfIu89B6t6z3YxnNevwV9qXzfIMRpD7ykAoDG9hopbl07uCGD5W6igcE2Ms7mUKVZDgMYR44q624RRXvsy0j/SA+u1Dvll4Wke0BJunfQC0smZgRNa+TULa9GP6BITBWwbZfDIzmJUsezJydKP5XQ3M1TnUcPS6fz5wfMw+HWmkQMkQzJpv62lhe93+huqbwuv3ePAEBM5HyD5H3ljFqTMlHqmAR32P912JnrC1ndANjPjd2cb2QgkSmnkm2rtEmq5NT8VqdrE0sbqu82cMZAp7lEB0nuLbJCOrPP1P24fhFayCCB/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=arm.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k22FvsWspMqC81QT7ZVSIZKWDeSyCNBqXCp/7+onews=;
 b=wkibiBznOLOMX4X+oQ80r2gdHWxFVobdtKiES9bltRLjDlr++OVGI579KG6h3FveSnaSJJbq/NxPT8mZ4amv4LBwneGF4ORVRIKZmN+EsvHtudWsyTwoS0y49F0rLnCscpP5rOIJC1giI5O7FX3OxsE0ofNe89PNpdRp7V9EekI=
Received: from CYXP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::15)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:27:28 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:ee:cafe::8a) by CYXP220CA0008.outlook.office365.com
 (2603:10b6:930:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 08:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 08:27:27 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 03:27:27 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 03:27:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 03:27:27 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B8RQrD2975442;
 Mon, 11 May 2026 03:27:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 May 2026 13:57:25 +0530
Message-ID: <DIFPE908BASV.3P48QMSO3YZ7I@ti.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andre Przywara
 <andre.przywara@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, "Casey
 Connolly" <casey.connolly@linaro.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ion Agorria
 <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, "Stephan
 Gerhold" <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, Weijie Gao <weijie.gao@mediatek.com>, Zixun LI
 <admin@hifiphile.com>, Jerome Forissier <jerome.forissier@arm.com>, "Chintan
 Vankar" <c-vankar@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
From: Anshul Dalal <anshuld@ti.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, <u-boot@lists.denx.de>, "Marek
 Vasut" <marex@denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS7PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab241c8-b74d-4b2a-8b72-08deaf3722fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: le/aAFYhCgP44dzJeOPsAbKTVqDLwWq8z3ocEQ8gHnp5qr4l9HlIcu5E2f2k3bJj3pQVVdpfNwWXY5/ecPlk0qtT5A/SFatyTzbIHVBWeuRGRmcVLzQi7UUA5oU9romT2R5/LZMh73C509DTElmv9mjAMxDBjRYIoP0JLASG6VIYXQ4wcTh43aCCyGhAIg2Aq8qWanUTK3MUrhPFmYVcp+dRSyrCGIShPpBnPHTnuyuEUVOS2K6kbqE5mMfrlyV3mZ8ecrsYUm67u69Fa0lQOH1uf0FrRf3kPEzYuf0O0F8zUuHdepfXooZXdPUt0GfZN4oGsuRIcBVdafxOW3JNH7Agn9UMnlVGgw/P9C6EEuh/NORaRwWUd0jrpB6aIGYjWQPRZ6oZWUJKfmLZYlwtIDrjf4ZYQ/z0rn3O2urjJNXiopLudO3bbufDivVh+alEt9cjkTgBoHa3f73nW027HVJhVB55lVQUdoc7luHsKTVFTf/Zg8tT4/XHgNVK6df4O9x42dUv1Lz5bsj86Y/rQtysvkzhowHDOHRfiGAY41EZNWAK2uAkvKDLMKs0PSF6jqqQSE9RaGXWCAYe7ShjsgYot1GySbujpg4qqjjomzNDfToTGpqT4O2jX2i/ySL9HxrhWh16awTHE2PGtoy9mjbCcRIoq3EjvcTUS3bWSIr/IpgmL+5g72nfaHOQOuSh9KBkYTyTYHsWchH4IxrbG3ETY5JoDUr0sJgPEcMH3Dg=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VIawn/wffPHqCh5A33lNmHqJtNCMxGWjIHqCR3JCgxYaye0niFOkUrdcMipag/JrQEupuCP29gQXEMP5mCy5fCjzQ5yOT/GX28MfTlNxjyHtCsEbLrH9c8/6Vmc/hK+/wjTTS1Za59Be7Ju58H1mKAF9KrdRD7FtMD+/MJKaJJ6xy8N6GAt0/g6L0m+wklSf4Pscsx02hkLh0QRQLs/3eKV7y09zN7QbgQSrR+Z4BaS0p1QtcmWjR8FZf19Z366nkiCRsUHXAk41QqFLhZNynxEggBtFJiZBHtEYYw+qzhiPZWLljd0VFSPozOlF3ZMc2Ggrnwq2z8tdEnrmMNGXM5bWOh1gS5hptK3+pjfDjvSFC9kK8zlf8bjdyWXGy/NV4ZMsF34qzj3ENz6NHSKlGR0PaAr+zNsfzbRuLMKWOTJlQY/BQF5Nz6yu+MYWHjD5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:27:27.7595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab241c8-b74d-4b2a-8b72-08deaf3722fa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Mailman-Approved-At: Mon, 11 May 2026 14:50:48 +0200
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

On Thu May 7, 2026 at 2:57 PM IST, Jens Wiklander wrote:
> Hi,
>
> This is a follow-up to Jerome's patchset [1], addressing previous feedbac=
k
> regarding the monolithic nature of the driver update.
>
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven yea=
rs
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back in=
to
> U-Boot.
>
> This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide=
=20
> a clear audit trail and maintain bisectability, I have structured the=20
> series as follows:
>
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes=
=20
>    to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state=
.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing=
=20
>    a "snapshot" import of the drivers/usb/dwc3 directory for every major=
=20
>    kernel version (v3.19 through v6.16-rc7).=20
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work)=
=20
>    re-introduce the necessary glue code, XHCI/UDC updates, and build fixe=
s=20
>    required for U-Boot integration.
>
> The final diff is identical to [1]. I decided to stick with that for now =
to
> focus on the method of how we import or update the code.
>
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [2].=20
>
> The previous patchset was tested on xilinx_zynqmp_kria_defconfig and sinc=
e
> this diff is identical to the previous, it should still work on that
> platform. With the help of a custom build script [3] and with an addition=
al
> patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
> plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> platforms using the DWC3 driver are still OK, but at least there is some
> hope. If this breaks your platform I'd like to know, and if you can send =
a
> fix it's even better.
>
> I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. The=
re
> were a few conflicts, even when backing out the original U-Boot patches o=
n
> top of the original v3.19-rc1 import. However, the resulting state still
> diverged significantly from [1].
>
> Instead, I've imported each new kernel in a separate commit. That way it'=
s
> very clear which kernel patches are included. Since there aren't too many
> patches for each kernel I'm listing the relevant commits in the U-Boot
> commit message for easier reference. I did this with a script so it's eas=
y
> to make changes, if the approach is OK but we need to tune it. With this
> approach it should be easy to tell if a Fixes patch for the kernel might
> also be needed here.

Hi Jens,

Thanks for the work though I wasn't able to test out the series since it
doesn't apply cleanly on master.

Could you respin with a rebase?

CC+: Chintan, Siddharth

Regards,
Anshul

