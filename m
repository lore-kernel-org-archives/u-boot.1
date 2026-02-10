Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950B5EB26E0
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CBB083A5A;
	Tue, 10 Feb 2026 17:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Yu6QdNvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364B283CBD; Tue, 10 Feb 2026 16:55:20 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAD683B03
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExomM7k79dO0Wdp96bfbkaPGc7TS93elpQ2eWSTs/EbdlEIV7Lj0XMREO9C4LKiLAw+4sHHfJloC8CQljzpR71hQQpQfPXulwhp1hOWtRvnyCwJIor6b+1oxBB4JF4vCVxvmUKAfrqF42NerShkOyNjTWBfUZvzt85/xotMRUPF5EmkzSurOyXRbqjpZgQI3lQg0dArFVsZBrkVclrSQxuXHG8wb6vKfw3WYCy0ONsjTX5u2yKpuvCyypJpaonCK2dzgHkMWOloON/Wmx3rYepC0obEzwEkssMWAUJO9f6eymgBxBZgjjcX2Rgq4BNzTL3aI2QGsmYbiXzLL7MB9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At69e+E+UiPi5RFbuxCq1jPAgI7dlL5T3aI65AzlXiE=;
 b=S8m5epOHdxuXSjDd4995kXSjLp66hZlRVApe7NcLS4mwHQ7HWuSn0TVTKurJ4fdqfuDBMxRMxN34uiXBjrWr3sU/udZeGQMJVogV0nONvPZTyOjomrIQ5aOWWiXJ+crHdxJGlSUmxOTprobt5WA6vNeb6XEKx6mo2MGopqrWzw+m0g1gpawfoY2aQHKmhXKsZkcSbQVtDHnh8Y/fgJYtNiS3po5Qah65gyok2uZjlmyzfOrVa0hmcHVNOepYfihz9gOaDoquwom+4B3IqG3zXEEeL6NMzNEtvbGeBNkXBAp4H3VyCB9rRzJwDMUX8v6+kCb/k01fFigQTHSr4DrPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At69e+E+UiPi5RFbuxCq1jPAgI7dlL5T3aI65AzlXiE=;
 b=Yu6QdNvftLFZv6X2AvykWHD4JmMbo6Oc6BJDtsOvPSRNO4uxd66wubd7iyh3osF3rPyQ6QzQ3Gv/pL1w3LmZnXSnY17rbzD6UPMIhoeblET4FjUkGmlQD9M05f8sZrAIJ2BTpn61ivE+SFZ/25I9TM1ItG/cKxOzHxi+fYHSFPGmwjSlBeF7ukivE7Va7xJmv+s52aFbHIW43V15SkRxBlYb2a+kMyek8aDTU2vfq10jxynR/HllEKqDiwumbY1hOfYYQnxuHnlEVox1EaEKJwqXucu9kzC/POl4yGpcTscsX1dv59Qj9cPMKZHc4XuVfEanaAkbDyqcbFDw5CQeIw==
Received: from PH0PR07CA0090.namprd07.prod.outlook.com (2603:10b6:510:f::35)
 by CH3PR22MB5962.namprd22.prod.outlook.com (2603:10b6:610:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 10 Feb
 2026 15:55:10 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::d2) by PH0PR07CA0090.outlook.office365.com
 (2603:10b6:510:f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 15:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 15:55:09 +0000
Received: from zoo11.em.health.ge.com (zoo11.fihel.lab.ge-healthcare.net
 [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 1D9E8F882B;
 Tue, 10 Feb 2026 17:55:07 +0200 (EET)
Date: Tue, 10 Feb 2026 17:55:06 +0200
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>, Mark Jonas <mark.jonas@de.bosch.com>,
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: Re: [PATCH v2 2/6] clk: imx6q: apply clang-format
Message-ID: <aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com>
References: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
 <20260210090029.728636-3-brian.ruley@gehealthcare.com>
 <CAOMZO5BF-jfjunxhW2_9ZF+r-c1GE2UvEBqeg9ruKutAW3H4ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BF-jfjunxhW2_9ZF+r-c1GE2UvEBqeg9ruKutAW3H4ig@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH3PR22MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 2081f1bb-9c17-4900-ef78-08de68bcc4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sLr+X+tisq+pAPyQgkg7ZbU/mozJ2tRMwACQfhvXU6n/3ND3ePi+MyPDTtB9?=
 =?us-ascii?Q?YVm9OIAgt1SUCjnobO1C+ynq47uxs8wcERBGQHwxmsev2IHoDe6iXNpSm3p/?=
 =?us-ascii?Q?76kVVNp+4vNgFLHme6XNWHb0CauELF71LklJczNAV2n3XFoiE+SrfrmGVgPi?=
 =?us-ascii?Q?95RnJUTSsvuPhb+hhIlb2ssp/bPoWYrYWjUHMhRvpSINSSVGmzctdjFIsYFb?=
 =?us-ascii?Q?3cd10NNBanM8OyZJN8OoYEZj19rHfWCbloLfwb9GRM0rP9ReSfjT9s1s2I05?=
 =?us-ascii?Q?ZtLtZPqTPcEzPq6Iax1+luhKvaf0fnIO+YRLc1Rq2KEO0+nVnoVdMItVBUyA?=
 =?us-ascii?Q?GuPsvVBrxeRibKWqX456TKJRadInBsDk2BKz0UxKLY+gkJLeRBMhszlSIpFD?=
 =?us-ascii?Q?XknpH4dyP/QP/s3a3He6PYoh5rE/wPz5R3ULhCx4fcxGMfX7/QmQ8ShL40hf?=
 =?us-ascii?Q?o8yr1PupmYeeYzJVuoUo8nk/pb14parxXSjSfKJl7S3JNmulXMp527fc8WdK?=
 =?us-ascii?Q?BnwEwcM/509ytVjjzQS8+BCxV3tcHyAj8ja5p0Q1VFfioFcVn+/ORTU9ko5I?=
 =?us-ascii?Q?m3+vt72/qUegW1mPqePS+RD97t7Mn6o4OilCCepNPyp4kV7ZI1AtTr9C7MB/?=
 =?us-ascii?Q?eb44MI4fIVWIMgnzFG3FdQn1yuMZOY+4fEhZMCUs0kTPPc7fqz/tUwXYXYQL?=
 =?us-ascii?Q?LcsG1AigeC9gHwUgAAZXHrrM2VwlKNtoyJat0DkayFwk7AjDBkjt2ZJaJZFr?=
 =?us-ascii?Q?aC61NEEpmtB/YZJ7vlHFe+lT3jL6Qs7aDhj349xvSmOq7dmR1m0VGm2VM7sJ?=
 =?us-ascii?Q?IbKOMsdoEUPn0zKAEibeBaXZGN5KrB9u1B3nZoluTrDqkg+Iln3MAr0eoT/w?=
 =?us-ascii?Q?BLMdq9Z3rJEL/E8xiYR0LQsDIawl8MI+K0mbg6AbkVIS4BEjr+XO7gkeDa7K?=
 =?us-ascii?Q?Y+NcRl/pdU05E5x0SmOuh4hK/trQf8XyAp4h8w9jFMiJNgGHToQeCKxQxIVE?=
 =?us-ascii?Q?HTMwgJsimxcrdyFO3GMny9ngzULOIlmsTaMA9TcypNRmZX+U2gFK13dviDyd?=
 =?us-ascii?Q?RRpZY/5AgKixFW7YkkeHHwY04Mz8UltW/B4VmOq7Gx3NwAyeQaX1VAzv6ITJ?=
 =?us-ascii?Q?mS9HslSA58q23FypiqWKj3XYbqlEmn3hdUtu2tcynOikZnz1yBWbdn8MOoKJ?=
 =?us-ascii?Q?xDaumV94AkifZCT+lwlLQ/X1+Itr8zaWyqk9MdPyKzfDTBdzvhv+s+TRqvyW?=
 =?us-ascii?Q?sNtkq0ctYlXZlZHBWmsyXL6Wt57xw98Bzq3K6P81jV/N1/08Qn82tcNZFceC?=
 =?us-ascii?Q?zMax+E0DNf8BywURquV6HsUl+Rw/t5E5p3Hkev4BzHlhAG5DsySRF5Gqq2fs?=
 =?us-ascii?Q?Q66z6Q9VXIof5ReQpd/91GXE0TNPRSOIyNKxJnB9t6bCYnJanNY1wPGurrjN?=
 =?us-ascii?Q?L43FFIRQNbQb65CmeuG5mP7wjmz+bkpg4PPbGg+uAJtygff8stZEgR/JqOSI?=
 =?us-ascii?Q?SHRh8K6doR8ISoLswEG5dvRyu4GjbHi0cONT+NZT7hKHjzYZvsSBefAW2bJK?=
 =?us-ascii?Q?G4x//LrVm9b2oe/PZTClWK6S7gMGGFWvxnEFrHBDPqgivKT82mjU4+97/xD2?=
 =?us-ascii?Q?XQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XG9bDMU877SlNXi68xnmwH4C/YFYs69cRQNZSUbXtp9YJH73swJwrgj3/SUV8VRG+V2LVwxejU1LGoJb9SeUgAwQYLPyWjppsdUZeWS/ZYPhkHq1Yo7q4n4ggWSW345GX4KIQKRQZB80AFnbSMiAWtpoMK2vJcmO6djTgDNdpxn1J9RJqRBbmMUP5jfEIdCcT8D2kY13Th2IJzlVZbIbS0NZhWpihbxBbp+oLGhYeL0nSAaZ2T8mQVLXgpP7fN4xoOnZyo6dh3KNuePdGvMjPG4Xzm4TejtAfvuReeKlKLlMngP8gNs+2zHN/VqBqM7ERrQOnThGjlh57zMnr8f0LWjiBpHCIEHxQy8LcUZSU8l9GSw1IkeeOcOsltD7+1WTD2J4u2dLFOaCMvT4TfQwl8ffkDi3CCToVO5SUX5RmDJXg2h6ySGzGbAuqIRJb7RN
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 15:55:09.8324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2081f1bb-9c17-4900-ef78-08de68bcc4eb
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB5962
X-Mailman-Approved-At: Tue, 10 Feb 2026 17:45:17 +0100
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

On Tue, Feb 10, 2026 at 12:09:17PM -0300, Fabio Estevam wrote:
> On Tue, Feb 10, 2026 at 9:49???AM Brian Ruley
> <brian.ruley@gehealthcare.com> wrote:
> >
> > Conform with U-boot guidelines.
> 
> Which guidelines? Please explain.
> 
> I don't see any improvements made by this patch, sorry.

Hi there,

I'm simply following U-Boot coding style:
https://docs.u-boot.org/en/stable/develop/codingstyle.html

Checkpatch has already complained a bunch whenever I touched this
particular code base, so I applied clang-format (since the project
has it) before making my changes to suppress some of the warnings.

If you feel like there's no visual improvement, I can of course remove
the patch, but I feel it odd to have a coding style in the docs if it's
completely optional.

Best regards,
Brian
