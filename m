Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2481CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D156F809A5;
	Tue, 19 Aug 2025 06:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="M6JE/OMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21D680EE5; Tue, 19 Aug 2025 06:53:04 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC158006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuD5pcmtwj7I9nHZ31XGx56hLR0gyvO+XZtVDj2+oo5QhBVo4VLLswlN1rSxUg/BPgKTZXGgoUrkh/psLYg9SLWzco4T7z3sOW1NME3Etxll46ku8UDsqeqKGjfkvA9yldyuRfX+yTqDoZJ2mENpIMxoJIEisSfYJ96YiEZJ4gZW7PgwJ0DMsobDfcRvI6PyR9X8v6V0L6eHnCZNE0c5AIv2fEqvUKm+JW05Eud5Sr1fmgiBnaYn1KmvlvpOVWZwvameO+RvvnHQHkb7djq6w8T4A5c7gtOYGaYcaUA1UUZV0Pljda328P57qDZ2N3pOtGELJI0BWnTAd68kuHGiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o4CBOOZyNDIzJSDfq4oECJDTSqgFfluq7I+qovyNYw=;
 b=wX6mIZFPyWbiIGVkSa9yJVvqgfUtflI/7za04ZOWQsVHgCRL+g+s+bZyiTscUtDhodIJPsf31oY+3ObK5Ud+rCId0640FD3SV7PGLRij78+IE1qZxYljKXHQvLtCd/sWgoGgYmklo+58iIWOqf4CDCKvQ7zk8dEBMHW84Z3nd0Pm9Cb1dmYWUvBAlDYncQhGCCeH9QEXdSnMzCQmOBgr79/1JJ3WOjh8L2jFcJleTSWSrplAEU3pXPm8B7Z8WVFArQpYTli10rJW29yKvxaNHhzsuz/iZhBqlSk55TTw64PCrljJu84Gm7apkuUDb0ujTWOi/N50l5+1jW47fClqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o4CBOOZyNDIzJSDfq4oECJDTSqgFfluq7I+qovyNYw=;
 b=M6JE/OMmmo81JO3B3gOhNsInrlSTE2mYngF00fzEwUzpP/nP9mgnOPwPqSyCujbmhK59V23ET6OF1DqCf0srHA1IaaIkFjakoj33sFDNOJFFEitHPTj5FJffW8IS107Ugb2EpoTPK4cMOD7w3edgHxf41RtlPjwsFIImkUixzRjt0x1ORi2+LRnyoCeJXB4WD1HAJxm8hrBOWSwTEdpyvVOsGxNeOA86dPQKyp0XOMvW7XWzk8GagNvDKbRO6F668c0i6Av2XRrZTeYHrkWDDoda4/kDiauH+KcEae99GJ9gPKGfzXXBt43HlPGEC4Qhl+v3kAuLGiI24zui+74jMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA6PR03MB8000.namprd03.prod.outlook.com (2603:10b6:806:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:53:00 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:53:00 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 1/4] arch: arm: socfpga: Add SMMU initialization and setup
Date: Mon, 18 Aug 2025 21:52:34 -0700
Message-Id: <20250819045237.18142-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
References: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA6PR03MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6553f6-bfc0-4487-063d-08dddedc45f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QzW2wMwHWPz2s81z0U3kvtviGpHTWST0+0n3YG7e8nhyULRPmzt9TAg4Xqrx?=
 =?us-ascii?Q?MHICeuTAdqVQ7eCr2sRLa/xHG174lVonod/cUyr1fhZuhVNJvdIZfak3NocG?=
 =?us-ascii?Q?dlc8jKAvHEj61excDa8Su5reRU+HDCIMg90KNOwoR+Nd1opqKy5ZuOXp/iE0?=
 =?us-ascii?Q?m5ClSZMRdONb7ZWBdZJHcHww6ni3QIV41+eBJ+PFWhsQfev8XeKtRGOV2368?=
 =?us-ascii?Q?D8iombnDQ4uZHqr+Nhs5gICs36zO1D10aQN9yNSe82icZnjdhkmq/oSSQb9V?=
 =?us-ascii?Q?gVsNNs7adR7NGTUpUajkdULxtkFNXkIEZAEPjbORMZoDtmR/OkskNJtze5Lw?=
 =?us-ascii?Q?K2cQ0HbTxR7oWYIO0FGaJHhgScNs16Oo6VcTGmDlfFSjMEwPEEzKk5BVt/pX?=
 =?us-ascii?Q?HP+Hyt+Tagnongb61gqY1qINeyk8NlRHv474g0ZNIkJWXzC2HvWQx74S/we/?=
 =?us-ascii?Q?uHz4UnsMqCCPrsFGBKFB3eC/GJYyodYF85LcJlY4xF9Pso7SwOBBephpFnrG?=
 =?us-ascii?Q?OcksV1dfd4SRcn2dRcNPJpXxXDnVgLU51D33NQjwvIy9fOvdDzKXwNLHsbfW?=
 =?us-ascii?Q?NwyIiD6Irx+nVBzyZJKCGu6LeMp5FfeYif/j/79Bi4sSMd55zHsnC9xUCYRY?=
 =?us-ascii?Q?BwMQqKpIdaUEhNLf3eXX4ea5eG8Je5MRviL5CwSNxVfpDSdhnXEwsici3CeR?=
 =?us-ascii?Q?Kz0PUsIEuv6IktmCOSMjHwGLAxzEnbhzpJbmEkVrqfP77MmJVaF5QoAO9LKp?=
 =?us-ascii?Q?+hIGlbF7VJPH2nmbCJNbNj28K7YC0A1O7yIdIw18j3SrjFUQunWVvQdNH+uX?=
 =?us-ascii?Q?pKaPyem6gjTddOtyIMW3oSeyaeEgsDE99FvSb46vsdFpJnYiYXZZhLYndHTT?=
 =?us-ascii?Q?Fv//v/2lUm7Vz0XwNuOK+cLA4VCIzUItd4Ekx45buQbie64yxfnEYbPh/N9V?=
 =?us-ascii?Q?bsoecFpAugbrXnZil9gUXGNBEB5+yPwetaZoo7b9xFh6fWhMvGEHtdwWy61u?=
 =?us-ascii?Q?nbKaifGIMRMDXZk8f0nGY7pqD+rXMC+IwnPriH2vnEWBIFVCa8qIMsDJ4Oj8?=
 =?us-ascii?Q?Qu6mECJqXLYPTpZkySqwGmfuxGBH7/2ku3uXnI113cQKJVwfaf9R7Etrvk3e?=
 =?us-ascii?Q?IPWz9DOGHwRWvXPigGn/AMlEGojCxUK+YxFfPRdBFzolEcIcu80UMuoXIGo2?=
 =?us-ascii?Q?5dDp8gF+Nms7SAWxM15bvHiR7C6JcidImh+I6loY/HvMiqWTk9DTrg/FNSms?=
 =?us-ascii?Q?prNMyGF+sgTewqauV1S25FILfiRYPKpPpYQLNSzDYoSQ00ZZ2vGYIQLhLHLd?=
 =?us-ascii?Q?JCvfSFiNd0D6Fv9e22/3pDJCitXVIq/WHjbIQACzZ9+odbDDitVjx0y/emJ7?=
 =?us-ascii?Q?wLprV2Tu3gQIyUYgYvvlY6R88dz7vPU1yfsypvMaCbsaI0guW6sZcT3F5Qgo?=
 =?us-ascii?Q?IG1QRAkf9s8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMtciWxkcvSWhc+vNF4ka7WMiOjmBNO+CjIkM8XL05m30YhPUAbnBwUqWQr4?=
 =?us-ascii?Q?cLKH6polSU4obeum5ZS6DNon3R5RUBtJm9qcUTx9JjBeAx/wGeFQx0CszcL8?=
 =?us-ascii?Q?9jSckZOXjtGkBVAE4QM1MzBugeobl10rvGXWFdE2Xu5bf6sCl9taw2zk4ubK?=
 =?us-ascii?Q?kLp9rJjnqH3pmegjBiotmYMs7nZ9RN46uMK/fdWDn0/DiV9/vpSlvOc+vg/k?=
 =?us-ascii?Q?tibVxPpty7cQ8iHpmXbhipKYO5TUzkSHdwIdxB4RMq3gk/14fVjcMDjwybAo?=
 =?us-ascii?Q?gqQ9AhrLuXZkrfAydp0NEphhmS9ZwJ+lE9lb+jDtG2SYP5lu2fo1yz8STsX4?=
 =?us-ascii?Q?YHvGeIALRCd7SCBXmC9ebrBkIUedzR4W12l1JUpQ7vAmy1n1hZV/iZMP1zza?=
 =?us-ascii?Q?UEXHDyva7Vz3AS6iwIBgOenFqeNOZ+A6umoirEf7FtRcVfEWN/4tnaKFKHWN?=
 =?us-ascii?Q?ryiMJZURAJcLiw07W/SR7tZNwfbde4ftXHIOEDvYbgEjcqw9JJeVSG8iJEQF?=
 =?us-ascii?Q?8nJTgHVMCuOtybvposK2bIvMWDcHU6QM2gpkYv9UbDA8p8PlnkIYROuEWTT6?=
 =?us-ascii?Q?0ypybOTgVB/gqusevb57fIkMZ9qQVK9wZtTydf9d64cPvtCRtsKzbHx6qkig?=
 =?us-ascii?Q?1/9hCRWOp0clN//rZ30gdnj9K6FZvddO1HqsNqb9kQrO1a9dLR+RjrUnx4OH?=
 =?us-ascii?Q?2w5gpB9ohaTW+HlQ4AS5f/eINsfMsv54L7/QfghcBO1OWpoSOKk+LMlyvAj2?=
 =?us-ascii?Q?cbut/+J9Kn9GQqixN1e7Q7/ofmWpBaO7TCjs16ydOB8CIXE0ALy1vT/hEqFa?=
 =?us-ascii?Q?9Tz6sUXFHVSQrUkzbykOMJBR0hotthz+x1nnky42zsED1SUF2XN2IOEBbfFh?=
 =?us-ascii?Q?6lczZXaqGmTG82woU+m2zrlSwbzhmkiQX5PipHQxAyqXYdVXAeE/CcloMSS1?=
 =?us-ascii?Q?YJQcrtARhtz5Scw9j5Y8n/Y3Eo53eF6wqMXn/FIcw1gO8JCE51EMbu03712f?=
 =?us-ascii?Q?RaOd/OBXnpI39ai8x5YchBu54XvQ76Rj8FXoVBJcbcY2m24uVldhy1+hmjJp?=
 =?us-ascii?Q?2zcGaRQkb+oAXrNa1DKpIaSJb3oPDhRtRjDW5LSCULNQRqB34+Opr9mqJvEo?=
 =?us-ascii?Q?1D97/Z+HohtMZ+35RxOWjMuwCtJRQbK0DHs3HA0gxMacu9+KpCwzfi+iiDKN?=
 =?us-ascii?Q?jKUk+pjU0ahsJ4FApqXVRYgec7k/W5bvzFY2e2b4hxMy/Mc3hox7/OL1CHo7?=
 =?us-ascii?Q?qx3jY3QtD450etmZjHw+i80r70HF7Gqh2QZn7GCCERiZNTePB5ImgtxOU+JP?=
 =?us-ascii?Q?Mlu+JMd47vxaye9h9iKQYlNdGpv1ylWizTTK8tqSPApCULjLYSQhFLSwGjWz?=
 =?us-ascii?Q?uds7ENNNSfgJthiBqxKwPPHc76C1DdJz0vSXHoZGQkMTdmeb1ttTImD+JsRX?=
 =?us-ascii?Q?JOOdJEE0fRMlCpLxEhao0EkSw/qTl83md6e69OsH9D9MIYPcK0shMxqUE0Si?=
 =?us-ascii?Q?WlqkAjukXzVJL2U0qtm4wiRmr20qV+CPZelvyEzjTalRqtRs14AjG8PK/Etd?=
 =?us-ascii?Q?rtvzYziyNKlSdNdISvcGoumC3D+FknAS8xWkH1BUWgHzYyIPaSeA9mpiTDA+?=
 =?us-ascii?Q?PJHvVcX7d7rKM+feaQ8srLo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6553f6-bfc0-4487-063d-08dddedc45f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:53:00.5823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPYYnYzJ3ldQv2vgp/sh5DtiNHlGcWGBkAq/8j6aV/WmTGuTVppYU5068+PrkwO1JTdaCXYTw+ibSozf762P3wWggD40zalQJ7lDJM0Q+7AczDtcWbePev+kUmYHYpqQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8000
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

SMMU initialization for SoC64 devices is added and stream IDs are
setup for SMMU peripheral matching. This allows non-secure
accesses with SMMU peripherals.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/Makefile                |  3 +
 arch/arm/mach-socfpga/include/mach/smmu_s10.h | 39 ++++++++++
 .../include/mach/system_manager_soc64.h       |  3 +
 arch/arm/mach-socfpga/smmu_s10.c              | 77 +++++++++++++++++++
 arch/arm/mach-socfpga/spl_agilex.c            |  5 ++
 arch/arm/mach-socfpga/spl_s10.c               |  4 +
 6 files changed, 131 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/include/mach/smmu_s10.h
 create mode 100644 arch/arm/mach-socfpga/smmu_s10.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index c43fdee4a48..5b414c6e995 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -35,6 +35,7 @@ obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
+obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-y	+= wrap_handoff_soc64.o
@@ -49,6 +50,7 @@ obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
+obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
@@ -80,6 +82,7 @@ obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
+obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
new file mode 100644
index 00000000000..4a28b109b0d
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+void socfpga_init_smmu(void);
+
+#define SMMU_SET_STREAMID(x, r, w)	(((x) << (r)) | ((x) << (w)))
+
+#define SYSMGR_EMAC0_SID_ADDR	0xffd12050	/* EMAC0 (emac0_ace) */
+#define SYSMGR_EMAC1_SID_ADDR	0xffd12054	/* EMAC0 (emac1_ace) */
+#define SYSMGR_EMAC2_SID_ADDR	0xffd12058	/* EMAC0 (emac2_ace) */
+#define SYSMGR_NAND_SID_ADDR	0xffd1205c	/* NAND (nand_axuser) */
+#define SYSMGR_SDMMC_SID_ADDR	0xffd1202c	/* SDMMC (sdmmcgrp_l3master) */
+#define SYSMGR_USB0_SID_ADDR	0xffd12038	/* USB0 (usb0_l3master) */
+#define SYSMGR_USB1_SID_ADDR	0xffd1203c	/* USB0 (usb1_l3master) */
+#define SYSMGR_DMA_SID_ADDR	0xffd12074	/* DMA (dma_l3master) */
+#define SYSMGR_ETR_SID_ADDR	0xffd12078	/* ETR (etr_l3master) */
+
+/* Stream ID field offsets */
+#define EMAC_W_OFST	20
+#define EMAC_R_OFST	8
+#define NAND_W_OFST	0
+#define NAND_R_OFST	16
+#define SDMMC_OFST	16
+#define USB_OFST	16
+#define DMA_W_OFST	0
+#define DMA_R_OFST	16
+#define ETR_W_OFST	0
+#define ETR_R_OFST	16
+
+struct smmu_stream_id {
+	unsigned long addr;
+	u32 sid;
+	u32 r_bit_ofst;
+	u32 w_bit_ofst;
+	u32 secure_bit_offset;
+};
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 8a7d47bee44..3f91707ec49 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -80,6 +80,9 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_WDDBG			0x08
 #define SYSMGR_SOC64_SDMMC			0x28
 #define SYSMGR_SOC64_SDMMC_L3MASTER		0x2C
+#define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
+#define SYSMGR_SOC64_USB0_L3MASTER		0x38
+#define SYSMGR_SOC64_USB1_L3MASTER		0x3c
 #define SYSMGR_SOC64_FPGAINTF_EN1		0x68
 #define SYSMGR_SOC64_FPGAINTF_EN2		0x6C
 #define SYSMGR_SOC64_FPGAINTF_EN3		0x70
diff --git a/arch/arm/mach-socfpga/smmu_s10.c b/arch/arm/mach-socfpga/smmu_s10.c
new file mode 100644
index 00000000000..50be049538b
--- /dev/null
+++ b/arch/arm/mach-socfpga/smmu_s10.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/firewall.h>
+#include <asm/arch/smmu_s10.h>
+#include <asm/arch/system_manager.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const struct smmu_stream_id dev_stream_id[] = {
+	{SYSMGR_EMAC0_SID_ADDR, 0x01, EMAC_W_OFST, EMAC_R_OFST},
+	{SYSMGR_EMAC1_SID_ADDR, 0x02, EMAC_W_OFST, EMAC_R_OFST},
+	{SYSMGR_EMAC2_SID_ADDR, 0x03, EMAC_W_OFST, EMAC_R_OFST},
+	{SYSMGR_NAND_SID_ADDR,  0x04, NAND_W_OFST, NAND_R_OFST},
+	{SYSMGR_SDMMC_SID_ADDR, 0x05, SDMMC_OFST, SDMMC_OFST},
+	{SYSMGR_USB0_SID_ADDR,  0x06, USB_OFST, USB_OFST},
+	{SYSMGR_USB1_SID_ADDR,  0x07, USB_OFST, USB_OFST},
+	{SYSMGR_DMA_SID_ADDR,   0x08, DMA_W_OFST, DMA_R_OFST},
+	{SYSMGR_ETR_SID_ADDR,   0x09, ETR_W_OFST, ETR_R_OFST},
+};
+
+static void set_smmu_streamid(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev_stream_id); i++) {
+		u32 mask = SMMU_SET_STREAMID(0x3FF,
+					 dev_stream_id[i].r_bit_ofst,
+					 dev_stream_id[i].w_bit_ofst);
+		u32 value = SMMU_SET_STREAMID(dev_stream_id[i].sid,
+					 dev_stream_id[i].r_bit_ofst,
+					 dev_stream_id[i].w_bit_ofst);
+
+		clrbits_le32(dev_stream_id[i].addr, mask);
+		setbits_le32(dev_stream_id[i].addr, value);
+	}
+}
+
+/*
+ * Need to set the Secure bit (to make it non-secure) on each peripheral
+ * so that SMMU can access the peripheral
+ */
+static void set_smmu_accessible_reg(void)
+{
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC0,
+		     BIT(27) | BIT(25));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC1,
+		     BIT(27) | BIT(25));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_EMAC2,
+		     BIT(27) | BIT(25));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_NANDGRP_L3MASTER,
+		     BIT(21) | BIT(17));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_SDMMC_L3MASTER,
+		     BIT(5));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB0_L3MASTER,
+		     BIT(9));
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB1_L3MASTER,
+		     BIT(9));
+}
+
+static inline void setup_smmu_firewall(void)
+{
+	/* Enable nonsecure SMMU accesses */
+	writel(FIREWALL_L4_DISABLE_ALL, SOCFPGA_FIREWALL_TCU);
+}
+
+void socfpga_init_smmu(void)
+{
+	setup_smmu_firewall();
+	set_smmu_streamid();
+	set_smmu_accessible_reg();
+}
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 91c27a5543d..95e092377ef 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -17,6 +17,7 @@
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
+#include <asm/arch/smmu_s10.h>
 #include <asm/arch/system_manager.h>
 #include <watchdog.h>
 #include <dm/uclass.h>
@@ -67,6 +68,10 @@ void board_init_f(ulong dummy)
 	cm_print_clock_quick_summary();
 
 	firewall_setup();
+
+	/* Setup and Initialize SMMU */
+	socfpga_init_smmu();
+
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
 		debug("CCU init failed: %d\n", ret);
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index fa83ff96adc..9eebeda308f 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -18,6 +18,7 @@
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
+#include <asm/arch/smmu_s10.h>
 #include <asm/arch/system_manager.h>
 #include <watchdog.h>
 #include <dm/uclass.h>
@@ -72,6 +73,9 @@ void board_init_f(ulong dummy)
 
 	firewall_setup();
 
+	/* Setup and Initialize SMMU */
+	socfpga_init_smmu();
+
 	/* disable ocram security at CCU for non secure access */
 	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADMASK_MEM_RAM0),
 		     CCU_ADMASK_P_MASK | CCU_ADMASK_NS_MASK);
-- 
2.35.3

