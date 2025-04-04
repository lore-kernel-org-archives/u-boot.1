Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230DBC3600C
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 02:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9FD58293C;
	Fri,  4 Apr 2025 04:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="f1q3aMXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694EB8295C; Fri,  4 Apr 2025 04:07:35 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c004::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A5281FAA
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 04:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx9YLsl5BHxxzR++5ermFGKyKkbPSdK3E6w9vV2xkj9KLyEFcj0D4e7AaK4fZVODhGBHLtzDqZsd+1q4dx+o/4RKhe0kTA34riyOsytlfljBQ2X3RB/DMRNRZAOtGotecup1ZXiugktoSWVlrUSJMw4VCXWDK2pl1XiC7Fk+tDKpf/cqvfE7AMl6FKR6tGINVRqYdS4QQWFJtEv7zlLM8yPL/P4l6KYfcEskKSla8xXyM6OumshvtjCvKYtFRHsxlOVyzsthKqsjB3Kggryd1DffHaPdxlXAFvnUwIjbMMDBzEz7MNhddmJEmzMa6aE5QJqZH7zwfb8VIaE9rOMXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehiHwCnmC6Akh0ASWXJC7kvTVmVcckX0G6CopWf2qXA=;
 b=HsQYrpXuTeKgKfXA0iQZfLeoXTlC/2z5SvBVd2G3RH2R8gRzN9CDygk5KUAigxsIJhUVU7vd7L1xVg1ezSfaevtgvqnDCjrusIXwWNwGKz+YgWu03GIItdZND1S/T3RpjqvFlzfp6USEnNmMmnIzmF7k4qf0FvhqJqYW6zmwp53k4KDD0tyUvG+FlNWtRHxJ567nGD41m9yTpzpQRghr0nyeL983FPsBZrzM70leINoHUc4+tDI9rMRzrl7YU0dks9kIjf7pUnI4xCsKGLKO7GdheT8im/rsBX1VwzJwgOVYGGhnBvJLma4imZUOtu8wnQ+gKB7AxJWYvquoFNujoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehiHwCnmC6Akh0ASWXJC7kvTVmVcckX0G6CopWf2qXA=;
 b=f1q3aMXQzPEzNvvpGFTZ6kjjD7Wk1q9SyMECYGcpoN/hh+Z3RiDH8ruZcxUOzjC/Cor1oePy20G8Qoq7gry3fb7NWdxST7LFTz8KtVOrH+Jqvj7kvNr4RZ/r7QqHTLwBwy2FVFWnXLU4fquJSQ6Gm+isZ1RoBCLcHDef29EztvaNddTcGYLbp77xFR3TTm3o7GETn2Q5VsWh7xdT5MP5H2LhSrYsHyd4NWIcIt/XsrjwnHFohe9i3L13wA5JeV2di5Qvn8CRLPdKxz+8FsVgzmqE90oOFqt3o1iPyZvNQDM1aSFvNNkce92k1cUKLxRnLULfu9+qcMkixDHIbNY7Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3877.namprd03.prod.outlook.com (2603:10b6:a03:6a::11)
 by MN2PR03MB5151.namprd03.prod.outlook.com (2603:10b6:208:1ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 02:07:10 +0000
Received: from BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868]) by BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868%7]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 02:07:10 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 0/2] SoCFPGA: Add reset support for SoC64 F2S bridges
Date: Thu,  3 Apr 2025 19:07:01 -0700
Message-Id: <20250404020703.4261-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To BYAPR03MB3877.namprd03.prod.outlook.com
 (2603:10b6:a03:6a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3877:EE_|MN2PR03MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: b4669167-db59-4ea2-2ac0-08dd731d688d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qfAbpi+q9DM0/AAiubl8NiDhtqFZ4IvE3dqUPE8xjiQktT84mMzc3rqtVPxn?=
 =?us-ascii?Q?7GAmwK8YDEoFAu/y+wtKBRscThh0XjByl1wQ2rHDfhRRHkrX9G+/tWPVb9Lr?=
 =?us-ascii?Q?KUXlabn39/fBVa5aMZbtragKLy3yDKI2swvHIYl8mRK8k+F8xgItPJjQo0Qz?=
 =?us-ascii?Q?GlCaIOhn+hAuWOOvrU/wmjPjzHhq2QJ+i1nZhAY9UypV+7LbaaTuoCR8Lbk/?=
 =?us-ascii?Q?4ZmWHDa46dBM3rsW6JnpVDfE1n85PChB8EKnlaIO6yGVUxEwJfMpbmnLV84l?=
 =?us-ascii?Q?TWU1lQCL2k90fCCsipR8xm+nhtuSOYCMzDLEMq/VbkoBeJdbk3Q5yew0pfuv?=
 =?us-ascii?Q?G+cSfbszyQBakx0GjkrzyS0SrbAeSoxGwSUX3/vbaBFvkuVyYd9Dq+XuJxYK?=
 =?us-ascii?Q?mGjcAn1vY+IKz1KiuHoKJs8zPJBE4l6MG/w1vk+NKHLCgd0Fx+XE1OH7qAh6?=
 =?us-ascii?Q?YIfewhh5OexrmmEH+usU9I9A98j3J0pFGLaMmXhtc+b+7cUR1hn+nAfTFci+?=
 =?us-ascii?Q?1l4WMUvdzezjrn4eb180sBOYrj8e2ARCAM1FaAiIipWXxK76WD/q8CJ42ZiF?=
 =?us-ascii?Q?mMv9Lxiayx4RYLllT/GY5Gt4YdIPG+y3KVWhoOjzX0DuRYUIm3mKSdfh6DWK?=
 =?us-ascii?Q?wcOxkCeUdu2l0ifDaRrGGExe3LSE3LxTqwQmsFCc+VUECb6pt3lbAAxgWzLw?=
 =?us-ascii?Q?d/LG3WRMnJp8+UlVrnMJqKg0wh8dCKkbvrP6TJEppdlKzwcnGeF2ufBjbvTJ?=
 =?us-ascii?Q?3lOg7FmF6GfYcvNMZjKRSWglZ3STkxAUPzgkpwPgyxYY1oAOmTn8c5mUl9eJ?=
 =?us-ascii?Q?LMV/McQCf5l8U8HXlI5uSJnhtl3wy9cSNq52E9Z550nYStClcl80uPf7hrdx?=
 =?us-ascii?Q?xq9jWuXKm0zjvOybV5c7tIF5/m+nV6eLcXV1tvzsQHQwF/DlKK0r5PAsvUnY?=
 =?us-ascii?Q?O8c16vxq8mSLA74gPAYmQyYAKyZgipP9rw4CPDwkD0nePXofTbDGOchr9DWK?=
 =?us-ascii?Q?zcBa0sf0yASx096pQjdmJr05getm7h0IC9c7fd8/AqSUgyzZLlBWYOPJpdju?=
 =?us-ascii?Q?x9OXPtgclxs2F+2llIe1XD+M5q3fJmkMlPw8V5AgB+oeHxXkuoNHXm9e4zxl?=
 =?us-ascii?Q?5JicBp/DnoxsfsDd8CzN9pskvqn0ds4tBr/etvE0rXdp1ZhktTbr+QeFZMXG?=
 =?us-ascii?Q?o+1BSxNo2YL9+xGlftwGmATsz3QIhIaRDE8AKuxWgYPYmhQaBrGRsYE+EuPB?=
 =?us-ascii?Q?eBm6Jl0/KdNIdLs6fjcfGN8VJxWXB8C39p28Z97XUFVpnOqWkWgO2UFQqSd2?=
 =?us-ascii?Q?3PQQPpG5TpF6Y7iyolsvYu5cMZ52nRtAM3NIlo9feB14mRVA1J1rjY3vfEmH?=
 =?us-ascii?Q?0OEWXm0Q/WfDSX77bVRmRDUNliES?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB3877.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kacqCyI67g20qPMjU7BycntcL2oPguYY5PFVqNeMfJw4xrF6643F0ceVZJp?=
 =?us-ascii?Q?EUt8fUKBtH3MVYu7cC1cNwCgp/om9kwqDiqeR+Yv7fYfxanad+xSzQHjk2iv?=
 =?us-ascii?Q?rLer8GPqIZO7OCOKthcaaqJC/r3SR6VtGKNvXVZEmBF0/Hivj411/a2S40pa?=
 =?us-ascii?Q?w5sQf6uLCVk+6NuPexv0I7eIsn+TczcjpPL4q+owemaP3wiqSEztJfMkB5lu?=
 =?us-ascii?Q?ZAQFulQmhO/Q/EYRupkcht7ohn0rwNcHyFx+57GzXyPBuXvxe3Qs0IlLYirw?=
 =?us-ascii?Q?IeUUmSwOXKQjpOPRjQ+iC5O/DvPSF+f2rzyFZ/zQUvz1I8CbJwdZoM8xjPjt?=
 =?us-ascii?Q?Iiu96jnJYg4XhR7pDZa0Dv4jch+cVprQApTUgfvTBhHFbMLe6gz6CBre6CaP?=
 =?us-ascii?Q?HN8d4wl53aV0DNhNQ1RjPMoJa/9MG2/0kygJQ+9edZhaxXdn1yPuxdwflKrF?=
 =?us-ascii?Q?N6DGdmVIB/H/E+mT6vw7qi7sMeoNsKKAhfCwtwX6M4NLIACdunPw4GBOBto7?=
 =?us-ascii?Q?sIOVOcBJNgfUUi1H8VlbmE8PXP1SK2II3IbFucQsY1hwafdEmsDh3eVoCpDY?=
 =?us-ascii?Q?tXomw05smIzRsCS9AhpCmHx9jrppjY50TMuk18/I6lcvdJu67aiyASpPGicb?=
 =?us-ascii?Q?NfEnop+YG2BS88kT9ewXPwz4U4wFzXy5q9L4DRCv+WNo9AVqgJQEs4ar42C9?=
 =?us-ascii?Q?x3O+vzA7ijIsqthSeW/qiQCH8oSYRjWlLS+oLP+LnS2ADVd4CVGS5xQ36oVi?=
 =?us-ascii?Q?jqQ3s3qEYOK31wIFimkArDp8XFwBaPVDGwtFfQsaEf5z7LlL/maYFTSX8wbi?=
 =?us-ascii?Q?eFdduqnILTqC4mmMNohKRuHpbjLuUWBzeBxAzSZ/pJ7kdxcRjxnDcO+l3H7J?=
 =?us-ascii?Q?os2X84W4rBD+mOtkubiVb+mJLtj+ZrLurQf5GJRBLSrrbJqa/A4A8omGbFVG?=
 =?us-ascii?Q?FbKizb3cti1fC5Zs33fSRtrXggzvG5FMe12YcPguXEj+9sUHNdmkkFDqOnq1?=
 =?us-ascii?Q?7hTafG+3RoYSCJ0wZWUYxl90KwmuxResPz/Ux4GsF2yQlfQhBydFSQpmr7iW?=
 =?us-ascii?Q?UuQd8lbtYuvJgGkUBYo2KR3BdUjz4KTbuTU8fCqSu1EoIbK9hcdBNMza9oPz?=
 =?us-ascii?Q?waLFEo+uPpOiSxfPXdKm/NJNOqqKdZO0Ft2kTURxv87Lktu+bh/krNE69yrV?=
 =?us-ascii?Q?2oPXJWUI0CtVHm7bqC0ulUUIvVs9NX6Z8rXYDLiAi8mr9QdaVgvbInZ4Sa2t?=
 =?us-ascii?Q?INPPLexahfqoEjzLhTG8oonj0Yhg6G/NRpAMUwz6dw5l+B7ZEyMb4ur/QAaQ?=
 =?us-ascii?Q?Xpnlkvj+PZdlfJEZepK2XmDCWrAVPXEu/tTCShQRKLBI5F3+Vcpxa916z8u1?=
 =?us-ascii?Q?YOmI3oc08+oXz46oAcScToxJNhTXe/J9CmLIqCVV9rW/9xYHrHOpL1XHDULE?=
 =?us-ascii?Q?RJGqfCC72Jn7ThvfBM4AZAvIlCLxbs68zpk7t3cgSLNP9s/PgzROfODD1Kk1?=
 =?us-ascii?Q?X7Od8f9OUSWK2QBQvMXokupaTMMRPCiaz7Edk6Q54gYX3JvcNDwPTbxU7OUk?=
 =?us-ascii?Q?v3T3QemM2gVM8CbAcnrUSkdtHEBAb/SUP0UnrHh7Y/xxD+p2vSl397Do8p8D?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4669167-db59-4ea2-2ac0-08dd731d688d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3877.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 02:07:10.3382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGNzclIV7WX+pgiDmvlQttDB7494/JyNU4KAH/ABPnYdSfBJ4ICpeq7zHojD5cMHXJJSLnupjFiPsy734LBQYPMpYvFKhpXErR69Q9V/9dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5151
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable F2S bridge reset support for SoC64 families.

The F2S bridges are soc2fpga, lwhps2fpga, fpga2soc, f2sdram0, f2sdram1,
and f2sdram2.

F2SDRAM bridge is only available on Stratix10.

This patch set has been tested on Agilex 5 devkit with QSPI boot
(UBI/UBIFS).

Alif Zakuan Yuslaimi (2):
  arm: socfpga: soc64: Update reset manager registers for F2S bridge
  arm: socfpga: soc64: Enable F2S bridge reset support

 .../include/mach/reset_manager_soc64.h        |  18 +-
 arch/arm/mach-socfpga/misc_soc64.c            |   2 +-
 arch/arm/mach-socfpga/reset_manager_s10.c     | 236 +++++++++++++++---
 include/linux/intel-smc.h                     |  15 +-
 4 files changed, 225 insertions(+), 46 deletions(-)

-- 
2.25.1

