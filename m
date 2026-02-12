Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D93EB491C
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 12:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21F583DB6;
	Thu, 12 Feb 2026 13:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="t57tKwcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA4F83CE3; Thu, 12 Feb 2026 11:40:16 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B93483015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrxTmYVUCe7fbSEfsHtGdUI07wzqMrIKpSj2T7km0iH1tVnydb1c54Qb+Wy6VFnnCvnqL2ZVs/LRPGoVqr++YVztmwfXw+fVUCruYqNdTihEpVrwLe52SShHWK5N4+JEeFhSE1YAzlpx5kIK2LW3E2rBUlJ3xVsjL3aMYaFo3uAkWMiVgQQtjntXKp7PlN3mQJpa0vWTFiNdtB9K10PopptlGRdfqrbrh6TWiwLM8tYGma/EXunpFeTwQ9fXoZpX5yWWIrwUah1I7t9Qo+6lZ3lxVOUnjT/tgfyunuxBqJPjSn8fUmKRyvE/ahE0848FCNdC6DIHOyXUDKBvf4V/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2XKhaX0MJwPwUxsuJBGIElEloBN6Sneki6wuBgQJQk=;
 b=AbC2mPxvo+18DvmHTfgAZ0BF6gthizIa3UHQZC/3w6wx864Ivr2OBr84Bu0ltT6c3F5g5FmNUG1fW+fDnsxoUbGOcXTS9F8aGjzunL5R7GcU0yMGG5/ayxBsrOZIHUbfp/1ygaq6aWYGVfOH5v0igAHDQYn9U0yxbiKECdBthkv34OG2jbf9d4FhmlgnOnepLOVhVr3pgrsMQz1HIZO8sM6CoKQkBvUS3zhwyoGFffUy1sKy9DuqdKwGaM129cWCM1pN2mWcUS1OrLaD1gCqNaHSrVAnBbGRW42fIMFYdJ+Ti75oFWnkhzM0kxNGLcOdFImWooBUBjKSWokdLea5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2XKhaX0MJwPwUxsuJBGIElEloBN6Sneki6wuBgQJQk=;
 b=t57tKwcy8X7lV+J7qGBBGuU0r0G1hqiUezRVnVPr4oD7Ac92z1jTysr8UyELenkAWK/toKShEa8oPb9L/M4JykkwprOMJvK1R6uiR/Eys/hs7PNH0jwA5mUAvVl+eHZw+p0XZjY5TNCH/aVpV0rvWM3L0FiGk36c5EE5f5ubbevubJsYKxo+4EMNq7vvSZxUIMQoHl51oOattNb2fflkHrGwJz5rW48r6OR6OkvDcSyOfIYbGqB6ywB8K22PNFTFJcrBjUbc0lFwVWobSnkFpjALkARrfkieh48Bss1/LAx0rDAQAIEOkLCmbJ54acf95ewKjLXtdKE1dNsQyI6LJQ==
Received: from BYAPR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:74::33)
 by SA1PR22MB5501.namprd22.prod.outlook.com (2603:10b6:806:3df::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 12 Feb
 2026 10:40:10 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::8c) by BYAPR05CA0056.outlook.office365.com
 (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Thu,
 12 Feb 2026 10:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:40:10 +0000
Received: from zoo11.em.health.ge.com (zoo11.fihel.lab.ge-healthcare.net
 [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id D8E9AE8F33;
 Thu, 12 Feb 2026 12:40:06 +0200 (EET)
Date: Thu, 12 Feb 2026 12:40:06 +0200
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>, Mark Jonas <mark.jonas@de.bosch.com>,
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: Re: [PATCH v2 2/6] clk: imx6q: apply clang-format
Message-ID: <aY2uBu2B5TROaRq9@zoo11.em.health.ge.com>
References: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
 <20260210090029.728636-3-brian.ruley@gehealthcare.com>
 <CAOMZO5BF-jfjunxhW2_9ZF+r-c1GE2UvEBqeg9ruKutAW3H4ig@mail.gmail.com>
 <aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com>
 <CAOMZO5Dq5fOFUYHxyW2SrmsZ4QTmkwAJrswEqBMwqfVMDQZe6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dq5fOFUYHxyW2SrmsZ4QTmkwAJrswEqBMwqfVMDQZe6g@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR22MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b4c8c9-095f-46c5-551e-08de6a2318a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wNolwrmmGtsaMTzJZLpKg238r7mxtROInna8RucBA8M81ZD9vPloMTfe9+wV?=
 =?us-ascii?Q?cSeaYYTVbr5PG5TpsgPJFQ0qwXArncBFVj4618iR6DUqcS7Ie5lWVVDsM+Xv?=
 =?us-ascii?Q?+j04zYuGy+vzEy8V2YWqEeZgJqYO+oBBSWFumBv/dsu32T9cwpunxQW4Oq8q?=
 =?us-ascii?Q?n/7DIOuZocOKKwyn0wDzGgVV63TYWCkWvdcBGJImpAoIkogi4DOuyZFD71sH?=
 =?us-ascii?Q?zxpi7w6lCGcf4gIF5pkCkb499jcWQOZKkCL63LNRJ+vli7Ou7cnrmMqGUx3a?=
 =?us-ascii?Q?BXvwWsIbEEHm29v7Dv2yziqKdv56WZ82be5p7EvWgN96QuKBFE0tmtuF5u6e?=
 =?us-ascii?Q?1DG1/b5y/GCCAjdy+7LKKgnWdKHhAd+prqKrP/36mHjc1FMw0ibIj+sgeJiE?=
 =?us-ascii?Q?i6xolPasLNbB0tp9WgnB6nG2j2lGOdFxK443MznAf3uPa471BxO/xqSiYidt?=
 =?us-ascii?Q?x/gHFJs1NfMebsOiKdHPl7hhSskI5j2H+z03wS20qhRS8R6PKt6dksftubBp?=
 =?us-ascii?Q?wWheATRIslUPp7mTM7NZB5hdn5iIqQ1/Lc4FVYbtKSBO4gHbvhIV3yLtTPiy?=
 =?us-ascii?Q?gTonngntxTECXAfSiPTZMSpojD0aCvDlHRAmsfC3rpFMvr1vIeApXeEJVya4?=
 =?us-ascii?Q?adpjJWdkMG086MQAmkfmWGmWOjX7JKnRf7MeXOctr/RtJJT6Dja3NWadeC9B?=
 =?us-ascii?Q?xAOqT80m5YbeRyLuZZGK3lLhuS/xYlGfyyfLWHMokeIZra4u4OvveyB8+7rM?=
 =?us-ascii?Q?cLPiX94+qDplFi/M7vWEf8Y9OTvGXwz0Y1wLG/K4AOweWeazCaA8b8AKdPgP?=
 =?us-ascii?Q?DD1LQS+3aPbJ6Ct7z0cWqF2TeST/XOqOT67Y5QdWgo6KAXI2eBLpJHXlW+K7?=
 =?us-ascii?Q?zTth56U/gRsgZ/70jA91w4aL9+DSTszg0nt0Xr1E6FiaHAcftdhZKKJy9rQs?=
 =?us-ascii?Q?mxkAbcr/U+vAYvTaie+GDYy4N/inP+ZuV3+l8eTMjUANstHkwkZzASqHKkES?=
 =?us-ascii?Q?w5n8GkV1nw7+LlPfxy8eJnEp1hLeMZQPEgLv75NchOuCFcMC8BllS1fFjvYN?=
 =?us-ascii?Q?xMexV9RsFSWj0rnWNylWcwUeuKl+676dYStrlwshmEEarKlwG28cqqHRuFEa?=
 =?us-ascii?Q?3n9ZE7pYrIO1dyctpe1AoDT/RqY2NQuiNVEefRO6o8y7IOIb7UtUYYZlVZ3+?=
 =?us-ascii?Q?RYESupJAFNISFSFrdDW1ASRvOp9BTgeep9VjB+l9HEQwdtxf0aIpc0mJEssD?=
 =?us-ascii?Q?CnXWGTkfNPpu8dslJ2r70kLQFm6VHwfQrskhfry0+sA+u3FmRzIXZQwo+2Ny?=
 =?us-ascii?Q?RsGT+q2EZTFAO/Hgs0LVyv2EuScYOLW6fjAxtjX9RzpMQGwSBPd0XE5KrpZA?=
 =?us-ascii?Q?VGeJ1K+GPM8OTLozcnHliHcwMXXPTyFZI//MGhKyPV0GOUFLduscT3Yo84mr?=
 =?us-ascii?Q?v+BVyowtLq86/ww66EBx/uaNOZZi/QZwUJt3EAvril+oQtqUzZOIdD0iS5BN?=
 =?us-ascii?Q?AetGOspK3Mw4btsrMv72H+FMM2e70YvXNtlDznOSb/wCfdpHvENCnnOOOL4n?=
 =?us-ascii?Q?DySnU27tHbfYSFq1MTmq+o0ENPVmNl4amYlT8sLUfUsLKSi6qQZubtzQKJqi?=
 =?us-ascii?Q?W9lBh5Gfb0Pl9iAyJqHbBWo4oUWLgNP018l5XJJwxzSYnx6ZAviK6Z1EZcxW?=
 =?us-ascii?Q?zyjUbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KsxIrlHUsDCC5ffiaDjrTl4b4NR+4oe0o4LHWdkoVdgabKkN6dKYDzaPcb6NT4ZDkRnTLDMWwGyrCL06B3F6GGbM+PyuO8iY3xlfoGOGnSz2s7nbu1IDw6m9qHfk1fzAygPokWEvZE3/aFH4ibQzxGBxvB3+7MtxtvKpevrFDCw4jCp0qxdkt5puxpWBtvBxTkyKvR96Cvd5kzXvsKYZBUa6KJ3F94tC6TDKGa6kbo9FFVOJfo0j1YHIBt3lAxo5IYu4ghWeIQLBWJUPNzn7oUsqYPWJIFlTor5WWuqHrQJ3gphAkar3jC/wtDP3DUQ7ZgzwNg7zsS0Yy4CKc5MZfRuUYyLORxneV+Hypi7fvqDbZ4rbPz13poEJ7tpbGLj7klciYBujx4Obrcr611h6xoL+65i5LG9rqgi/1+hEEG/aaLbkISDGxRxFw3TyGn3d
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:40:10.0407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4c8c9-095f-46c5-551e-08de6a2318a0
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5501
X-Mailman-Approved-At: Thu, 12 Feb 2026 13:44:52 +0100
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

On Tue, Feb 10, 2026 at 01:04:57PM -0300, Fabio Estevam wrote:
> 
> On Tue, Feb 10, 2026 at 12:55???PM Brian Ruley
> <brian.ruley@gehealthcare.com> wrote:
> 
> > I'm simply following U-Boot coding style:
> > https://docs.u-boot.org/en/stable/develop/codingstyle.html
> >
> > Checkpatch has already complained a bunch whenever I touched this
> > particular code base, so I applied clang-format (since the project
> > has it) before making my changes to suppress some of the warnings.
> >
> > If you feel like there's no visual improvement, I can of course remove
> > the patch, but I feel it odd to have a coding style in the docs if it's
> > completely optional.
> 
> Please explain in the commit log that you're fixing checkpatch/clang warnings.
> 
> Simply stating "Conform with U-boot guidelines" is too vague.
> 
> Thanks

Okay, fair point. I'll fix it, but I'd rather not send a v3 just for
a commit message unless that's the only issue here.

Br,
Brian
