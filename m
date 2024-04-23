Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A00C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1234288511;
	Tue, 23 Apr 2024 11:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="k0qZGJ6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAAD884F0; Tue, 23 Apr 2024 11:14:40 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DB2884E9
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPjp1oeb5sBJBhwwo3z4S+s/voI88D8iZKQ352xLhgPvTdhiGoap87VHK6BT80j3IYMMCPIHDWtcWHIQvsUa1O0gp2QcLbTl0aZCrkfJFwerMhQhWthtiR6UnR1VYKL0vtlfBlQB0ouZmniQKdYK9u9wg2dJhIwkMh0FDWenXnBauU8KT+CljnXiLDDLu1H+IIVSs3dyhVQ0cvcP4Lsb/0RnsMbdzZvf6nMQ6TmlmYp3RzcdgZvXLD6SPIkfvgnM273t8Jc8rGGjQDHF5X0z2jTWYgZEdaEqayKORN7Ke5HIxFBer4p9h0J2YuovecLfdCwSqAdHCLmOXTnEGcnbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIliNDEJyRp5u4pR/ihJZ1etU3Nv59bvUhv1v9TNrY8=;
 b=UzJ+Y+L8MYzPKNNRN0wt635WUWomYDlgQuKVHefOfCtAI/Oxtu7sh8yRZ7I7TYvmOYmor5TYkg/GMWov7Vux5Q4rR5+wQyNSiBtXktYukU4y/X2LfJiB7j9P1phIf6os0ph/tfr+2B4uN+qPsx09Oczu3ewM7gGh7FpkakXqQBWzkixtiKuitgc3rlhrCnkLaNcEKH0qGxIaWzJrgjuHkl5Z3/z59y5XAL26/elsREv7jsHCqGfHvaxoQON6Vfujr0euP9ctdd9fohS9v94xrvQD5G+Z5NGcXBAqoxR82G48rtJwLGYztj/qlGpaDcFjGUwCugvkDi0NWEQBqAeLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIliNDEJyRp5u4pR/ihJZ1etU3Nv59bvUhv1v9TNrY8=;
 b=k0qZGJ6G/2YO3PLlZhXnk4uLqmAnfIAulzUTbedp+9kIUaMBDGq9t1U/Yba13mISGIFxCgslByg0nbEZTgweMDvGByKJyekhRpR18+Mf48m2MrhiY5hu099N2fEG7WrLVLYd5ylwhgWg8JOvzAkWAh6QQ7A8gBiw005cnMBHSJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DU0PR08MB7461.eurprd08.prod.outlook.com (2603:10a6:10:354::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:14:36 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:14:36 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Alison Wang <alison.wang@nxp.com>, Atish Patra <atishp@atishpatra.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Green Wan <green.wan@sifive.com>, Leo <ycliang@andestech.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Scott McNutt <smcnutt@psyent.com>,
 Thomas Chou <thomas@wytron.com.tw>, Zong Li <zong.li@sifve.com>
Subject: [PATCH v2 0/3] riscv: Rename spl_soc_init() to spl_dram_init()
Date: Tue, 23 Apr 2024 11:14:26 +0200
Message-Id: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DU0PR08MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 673d33cb-99a7-4983-6446-08dc6375cbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DuOIuZFYxIyV72ihc1eB6qs1szx65R5y1uqio0z//HaJ/2p/S8AZjQPJaXP/?=
 =?us-ascii?Q?fsR+3mCHiOxnsF/MRd+Np8dtAa4tk7vhEEyazsQfW28sDgieFQXWPsG83H4c?=
 =?us-ascii?Q?Td2v8bqbLQTKNOIwLu5mk3Xq/xhQHpJW3HSJh/PJ4mbZxFZA3tA7Mo8zksg5?=
 =?us-ascii?Q?wnDArPBIKfk0VY+wEOEpNbvPTQNR8eA4Wa/qAND1TYxOerOthBtWWuo1XR5p?=
 =?us-ascii?Q?ygpRGKoEzAfah4mq/9ANv0GYyoTuO3YAr5fUQvIWlbrD3NlP69zAaZye+XdJ?=
 =?us-ascii?Q?f5WKLSvXIkk5O12zmzz3EoGxb9Ol4cKIRsTB0bGxvbc9xQCWijL3IbONuUBj?=
 =?us-ascii?Q?5dQL+c/z9WI9zRr1wAJTXv6wP5kyMHHtEEHwNahPc2M92yD1kFNLF4IceZIx?=
 =?us-ascii?Q?8+lcnG/SNNlXu7thsmovCmPbvLMd0tK3JkMpMWNvM8xFEsSQEI9iFvvUH3lc?=
 =?us-ascii?Q?mqQPYACgfjxUs1vrf0DkzZdCuu64Ar/9VGHXjlSMpAzdPnYiFca6IlojNx0c?=
 =?us-ascii?Q?myIP2ZjoIe2W0XSDg0mxRY3SF9cZW+uKsZP174yC1DuIcWLdr39R1dMHdSDg?=
 =?us-ascii?Q?fn4C3X/v6FgZejhMxCLE6HoxZmXWDKBFdd4iKQb3RgJKzEVOX3GsqUqF8yBi?=
 =?us-ascii?Q?8dW5ps90I4HVJBRjI1on77kvyIyQba0pvb3BSWbUQ3lUwRSdHsW9ldKUlUn3?=
 =?us-ascii?Q?o/mslK2Q7mo9HeukVJknUGK8+xhvL7cShCiNf1eqfod/w9yesCDzHbCwJsZO?=
 =?us-ascii?Q?k2qF74zWiBq+jeglxDLAV7eNcO9TUUOpKHlsUMnSkVDpBNAEsvFVKVSq+Pu/?=
 =?us-ascii?Q?G4ef9fco/AYFwkL7DYXbsnBA+p0uOC2DiGTUMRJW6y6Ns99NK8E0sBo7icgu?=
 =?us-ascii?Q?2tu4nscugThqUpHowN2Vwe6ud2SxfjFXJAQHELOrTiYipt83ywO8Y/34i04G?=
 =?us-ascii?Q?2hLAS7ih17YwEsdy4MMtFP6JQ6/WdLc5V+QFNgsHu9UmuY0OKS48imK3XIvj?=
 =?us-ascii?Q?0G2BxPKSU9TUoo+s2ZwnfD/zMTp7snG52kIpvGm2xS6nLigLLviWU/HNAcu0?=
 =?us-ascii?Q?rk5dS/l5WAR/MkN8xzd+dQRenPmEyDIKDRv5nvEJjodfOW7MCIDP4UcLIxSx?=
 =?us-ascii?Q?EbJKpHd62+7DQI99UIzgu4rTFTlzj8+kY9vCLTQvLS5G8KRVTJzwbtLFChlA?=
 =?us-ascii?Q?kI554Y/4xe+BPkVGdWAptdpLMPrkhf1qUVHzGwAPuiWqItjdnMMdmsYYPgC9?=
 =?us-ascii?Q?trbs7z5FxNDd2ycK0Qj1tH3z0jy4OnibCzTowSHJsbsL9yW8iYGC4oc8IhDH?=
 =?us-ascii?Q?muva2Ompmsen748peRUepFEq0He0KSSAyPTnbGZF4tlpEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+c7LFdCwCPYX5WCcQuaJ1Sm95U/i9TpeDNUbXLV5Mh7Aoqyo3S5/ZGJvwkG?=
 =?us-ascii?Q?jrcCx7PcfaSN63ZSETspewo62sskK9yXoHSO2NeK24w+maM2ElVEaIabhjPN?=
 =?us-ascii?Q?R4I58HV224hVohJ0spIz05GJr17a163292+VOar21rQmdM3qIcyyJ8ioQXUR?=
 =?us-ascii?Q?Mr7a30kVXA77Bf1Pd9V1DF+9s9dCwnK2vfyAoPm1qpaQygELhsiW1R9cncaB?=
 =?us-ascii?Q?kXFm2C7XM3LjU/nWZJ56n6L317cYXMgsmPRbwoJHuYu+smi+CvFLUn/IP5W+?=
 =?us-ascii?Q?WsyndnohrAflvsJyOOgk99Gmc4dQHG9d63EJ77iYviy1MczQipTMiox4GYyY?=
 =?us-ascii?Q?J1gn7Euk4/ozDyf/AhCjmFALLKKVtyzpiVrUjY7f8/mCnEu8itUexrYimWPn?=
 =?us-ascii?Q?Xm9wMaHLdw0fy0cJUsKR+nMe1HHmWMlBL2gtXPj6Il8ANAJdLzq5xMUM3a70?=
 =?us-ascii?Q?222Y3MBr+V20cU9Rs6aN1GagtIhAHw4mcaAq1dUQqTPGVZg8GgWitqvnMA9e?=
 =?us-ascii?Q?scA0zCs5yXfd2fiYDwNTdTtKOjohQQ6UIfW09YVzPa+BKZS8P9o/NUOlUBmz?=
 =?us-ascii?Q?OZyvNA3vm+JmNLw7cJEo8NJ4T1mF9YtvCSZLWPRq9Ydmv3fyZbrKOGZCX5oS?=
 =?us-ascii?Q?1owupeufdi3WFDpCUSQJdjHvg2cCQa2ipTT163CXf0j3DBKnaxn6iTNFOLDz?=
 =?us-ascii?Q?T2qtG0TV21+Fg7KP7vuIqvJMNy5ShUj2D4+LZ0U4MDDCwiCwO1kR3nVwbYZT?=
 =?us-ascii?Q?D/Ui872iyVcNGmFPQkxcKWeIoddUk+73g9W5OLvWgc7V45lHAxXtqUs6kJJo?=
 =?us-ascii?Q?wFwmIDuGYPPXFCIKWudZV1+lwKmlHP5q2L3u+jguUTCWksHhbgTpwSxiWdQf?=
 =?us-ascii?Q?ZappWDwaqguoVpgvo7R+J8J0YeRKeQvCBKFS1AI8oSfSKEJBgiaKIEQ8qjPH?=
 =?us-ascii?Q?5i9qHit6539ROuOIqPE/o60HB3WyqGxsWLY8UcU7LtTWyjtwt3Czaeit219U?=
 =?us-ascii?Q?0GUER83RfvScjJNt8UJGaZF0lbQuD62CouSN60iHU5Ktdekntt+U/AdFSRXD?=
 =?us-ascii?Q?je1PdY/HH0L0IYXYZA5GpRV9lLMPCJEjJ2gZMNit2R7mixNk5t1M74hkoQGs?=
 =?us-ascii?Q?DA/xeq9ye6NNmUYUIjimJKIgFyp4WjuMnnxV07vf+fd16FmYcw5HQeSxTrOd?=
 =?us-ascii?Q?TiaKREE6BMIluaiij88tHosi6F1DE6At/KEA25LPSfjv9Ryj0MnxN13ifxKs?=
 =?us-ascii?Q?RH8camsJThlLBR8aHFISeaYCU51y9N+sVfvwCHvVrXQB/p4FWUJIfCPwYO6k?=
 =?us-ascii?Q?WjqkjHLQe1+Tg43HWuzQs9Qe1uHigHKGsT15+a0QcwjR0po0JoMN0uZJsRD+?=
 =?us-ascii?Q?A7gD7feWV0EYgykh5TzYACSB1uFaWZxh0Nav3i74CG9+DJav4lRR9yEdjqnj?=
 =?us-ascii?Q?q7Rjm1AbkbXWAagi1CqiuzSvmz6OFDdeWkgTNRESwEMxBQTJ3wM/ki9HJGvP?=
 =?us-ascii?Q?sb1ar0wfYV9xL732UMb1uKsoUmIM1jSgI93vilp7kj2yYo5xBdAAYF6h/iFM?=
 =?us-ascii?Q?kuofezUQqL/859ZOnVZsQRc1OeEBYB96t/OYNhrb0ImTI4lerxdOT97gCwCE?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673d33cb-99a7-4983-6446-08dc6375cbd6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:14:36.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZkrv0Q0r8g5JhSgto4JJRGTcULIdcdIMxWZqj+xEf1M7/k68HGGM6kUbomLHSRn9lgBsP/JMpWzX6z8r6S5qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7461
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This patch series renames spl_soc_init() to spl_dram_init() since the
purpose of the function is to initialization the DRAM on sifive/starfive
boards. spl_dram_init() is a commonly used function for this purpose.

Changes in v2:
 - capitalized acronym DRAM

Lukas Funke (3):
  arch: riscv: Rename spl_soc_init() to spl_dram_init()
  board: sifive: Call spl_dram_init() for DRAM initialization
  board: starfive: Call spl_dram_init() for DRAM initialization

 arch/riscv/cpu/fu540/spl.c               | 2 +-
 arch/riscv/cpu/fu740/spl.c               | 2 +-
 arch/riscv/cpu/jh7110/spl.c              | 2 +-
 arch/riscv/include/asm/arch-fu540/spl.h  | 2 +-
 arch/riscv/include/asm/arch-fu740/spl.h  | 2 +-
 arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
 board/sifive/unleashed/spl.c             | 4 ++--
 board/sifive/unmatched/spl.c             | 4 ++--
 board/starfive/visionfive2/spl.c         | 4 ++--
 9 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.30.2

