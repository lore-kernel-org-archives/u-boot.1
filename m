Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2FEF55454
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 04:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AB683D8A;
	Wed, 25 Feb 2026 05:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BfJXVBUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB08383E61; Wed, 25 Feb 2026 03:12:58 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EC983C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 03:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEBc2BLjB5FAYhwtBYRZDuazdYa27FCQFnricdFwIsthG0AHFWVKunvjCXDvClLA93MFMF0dXXgRG6WVcl54Eeyn+ES5xgILC4moVccbNOd4eNjluViL3pJFWTNF9nMQsCT85cpToEqOggsj5c8OJRkNB+ViiT4rqNMUi6ehisynglkf/HyNXbD6Ol6IvoG/e1hohtCC1N/ei9HtStwHSuMdTKn6nCCaEz6gDXkGWtr2AV5q0aKxbaeZDk9jZq3XaW58raBuR0jj7nkKP5QE7bu8a/ElxhJ+a47JvHXlM/knd/WEHzIjcXsWDSzBX9vnByybQzBqiAUdzjvlqsgD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfKObAUpMyKPiI1s0F7r5hyReuaMewHaFoGGECegXds=;
 b=V7KTt0WkMSdzQ53fYZ+uD22pLQ2h7ikAjB6juE+21I35fO10Qi4dV/IrtJIkBjmUpUDuSnF4HEXDt/YQ70kPRo99juc5IJl90sHXJndgAjaTm6JzN+4Gjet8kYJN51v/UeKP7sIKeKOX+jZ9aJMyCNLA2h2dL2tb2pCHKP2sAGgZh5LHewKut/0jesXbA+lmbnohxi7+dJTEBnIWHSUS246gg8cYd61GBPMLwnHivwFNUC6YtsTRuk8tGqBDRHhbwVENz/Yd17kNJVQqTvMqJ1r0jIay8Pb1TjXv6gXfXmyq9DAFn77AHtQes/AmPD9t3jpQdBcS275fyDxuatVhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfKObAUpMyKPiI1s0F7r5hyReuaMewHaFoGGECegXds=;
 b=BfJXVBUfR3j1BPI0xbZJg0ZNWtybIh4bcVKUqp8fQZOLWor3Dy7hpqCkTUWubXvZ0TT8tEwAFBn6GvNsctq/4KXZ67H5vC6r2arltsmn0Pc1jaJd8d0xd8lxxRW2Xz5sivN0nuFp6wInPG1OvSwRDE17DKj01s/O2MC3po5tmE9jsHskmuFZfrftErWFvSCmsGD522tr/QOUKSgwNqPwavQxCn7vfui2dVCl4rC2Cvf4nJLii79pFRMJjXagfO7Jbgm1ab+FTDdnp5yUFpj2LSR96uBJ9bba3+3yDtqiMwcofZ/nmP3kH7Hf6FCXMFlEi9ZZfH1Vmfer/NAIhLpyXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by BY5PR03MB5141.namprd03.prod.outlook.com (2603:10b6:a03:1e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Wed, 25 Feb
 2026 02:12:53 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 02:12:51 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] arch: arm: dts: agilex5: Enable autostart on watchdog0 only
Date: Wed, 25 Feb 2026 10:12:38 +0800
Message-ID: <20260225021238.21547-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|BY5PR03MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: defa2535-3aae-4374-2361-08de741360b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8VRWN19Smsn6q+n9rRAAYAOHEvG5DT7EacoKL5AO18ynkRmaBDUopLx07QCB?=
 =?us-ascii?Q?YBS1vDnitFFBp5vdRuHtM5RTuk1H8bWAvPNfHvakPobmgSTzx7QA//XgXEtI?=
 =?us-ascii?Q?tit5dstrFdXxoOH7t4tsUl+72f26oq1FsyKKUpS9I8EADSyBKj3q+eZ9UFig?=
 =?us-ascii?Q?KnxaHPOZg1auVk0w6FPECLlczF4QVZ6C0mhL5SRAAsKDBOUFozHbyqUyi2/q?=
 =?us-ascii?Q?EunkfrSsrbY8f5ixpGUfnduSc7gQPEBqCo9SeYVCyZx2A6iAqTdNKAXRGAcY?=
 =?us-ascii?Q?VUCV0m7R/CMIPeqBg4MXeLmMm9LnAY0v+DWvAyyszuhUhbt+L369UU8j3YoI?=
 =?us-ascii?Q?yqPjDv5MRQT/maaLolMA5ZQ4H8JEjOQAjII6SiLf2naCuFaptpprsqBfGP2Y?=
 =?us-ascii?Q?quxE73PQLT3nEg7zsFQs96vy4uY7QaFTd1kdGG4SUcIozrMunRq4dL/lg2xH?=
 =?us-ascii?Q?+AhFrlUCe34ZUAdRh9E1iYpcGk+ieBNSSaOsJH6eVIz5P5Zd479R9ICBAi5R?=
 =?us-ascii?Q?6S6bvq0decRC+fvMTI8KDx9BfdPzAQUaZNf7Pa/LPgssVIDgGsxnMe8Z8bTy?=
 =?us-ascii?Q?RAYJlvKcn6s/db8kE+O05JyUx7R+b3se6Tg1rzeQFAGSXjcr121j0uwLOpYL?=
 =?us-ascii?Q?wfR3m9za/pjZAlFmFzykAKmXHojbuCmOl85nHO3gIsBZmh5YZLY9hvWEHGcV?=
 =?us-ascii?Q?hMEGteqSkfJzzw+R1i8oU7uLdbxY5ttHIRGCYakyxsSK5sMwt8PUeFnQUtbq?=
 =?us-ascii?Q?d3+MN8L9hRgdNrbM+mBmQTBtKS0K/+iQsxPhnfDHhnMpO4CHKF0At+PnmkWD?=
 =?us-ascii?Q?annWrU582w5xvNQ/Gx1hb7Wn69evIPjMUCKfYdqQYaI66VjkP9RWcXGuWgoM?=
 =?us-ascii?Q?4RIWDKxRwBVRamUf27zLaGKlY2/r1UMMiBEkY0hSWjwURND93mDJLiCBrPA/?=
 =?us-ascii?Q?847+m7dkHonek4oLtqmozWBV+mNj3iC97NE4jU/2YXvrvuDAx6hr+k53nNKh?=
 =?us-ascii?Q?zEC/RDTaA4joWX16ytp50tYjikP40TVV++DJVzU0h2fDGzMq6qAlBM8MCDnX?=
 =?us-ascii?Q?+Br3krmEhJCLPqo4/FfAcqVhm+SdZBdT7CQUk9EzoGrcuzOvzGnFHKb+ymQ/?=
 =?us-ascii?Q?clNQ7GQm5oE3BZmwA8bl/2zu72GI77Ipy6sBXuziydTwQK4SoMwWju5ZWfyS?=
 =?us-ascii?Q?3sjh91J23JiC9b5VZbwurIARZWZKQx8X0w0KfWZ+vJdA8oLL5u5oxxbt/gZI?=
 =?us-ascii?Q?CXYbs08ddAfDEp+wSjnvq9DbRmCMkS9+HnZjQwXrsHH4jZ1SQYxCfUMVFyXg?=
 =?us-ascii?Q?2KRplq75emYHtu9E2N6R6OFO1RDV8R048qjdVgnzj0o1RdluZInWke+yuwgM?=
 =?us-ascii?Q?+0CnOk11nr32Fw2sCz/Lha6PvkQDHLjcfIfBk0b/03SFM4He8OfmCZ5SWMQe?=
 =?us-ascii?Q?dgbI/sVm5T2xd8NcjUrxH1xtBwdP6u2E2+IOFnCEUvOwhDIcesNF55fzGPD9?=
 =?us-ascii?Q?KT6VQ9Gq5MWl0LOvK/H/gshry12gmvUJiGA5Y82U4VX8u4mTbl+FcrpeGKlr?=
 =?us-ascii?Q?UjbN/6gtfwkRZuCeiWM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WsCw/PQylt2XLR8WnoZ1idIVkUafbm+IsWgRmLl7TLUxH0LSMPO+RBlh8+WV?=
 =?us-ascii?Q?HjG6Oc9CVNZ4+Ph2+gSCzGwMhgbVqUG+QomG9K2qaEtcCmOXfL05uQMH72t4?=
 =?us-ascii?Q?/rLFb/8CVnwSNGWCRWcWZqhhGXtsbCQ49Qr/CUxeavpx3rrsLHkQ574K1L6H?=
 =?us-ascii?Q?oo6Hq5bpUn4mU9b/ZWZAStyEjbJJTbiX18/s04rA+7cq0+LijVckH1K5VGwj?=
 =?us-ascii?Q?SR+bHrepansLFsMWiWUThzJQRT/zkPQUmmIvuX2RX7GJVGVNWhw7q5n10Udl?=
 =?us-ascii?Q?pOwyVIv2eOUwrBkB762MyEtvJoC+mAYGj+Zk6JBLm0fDUcxz0deMSDe8DF+0?=
 =?us-ascii?Q?nUzk95U+e0MZ13jAFC5RbQ/TRotUzYRdviEs9mal9nQH3MbNm59mesqoq6Io?=
 =?us-ascii?Q?rpbm1BziFqZweM1OMphR2Xy2co3Urq57mlDEz74XV/llPT3je0rD/3gWmb5u?=
 =?us-ascii?Q?4LnyhTYKA/nXzO2jO628WqbPnmp4MusIYT1/Ym1dDfiv6OqHOr0a8saxq8Ym?=
 =?us-ascii?Q?i0E09x+YIqK9chFlPnumKivTcNvSK2Ub42PTqWRn01u/6DcGE3qQr2p67z3j?=
 =?us-ascii?Q?+4A2PUF9/eKs1IBcL8yoy0Z3oZYYrr95sivf9nG8ywdV6bplmbxgvnVL85ld?=
 =?us-ascii?Q?ssS0tWS9yRoqjSIGcue5lP9NtiljJR2BP6rKQXL76zgifoRuOuBZUZu1XmAw?=
 =?us-ascii?Q?BmnVSsYFFNY2NOvFJbam6rSzLki9Dt7G+49HssCz/JLerdGMbY1QtcELuxqt?=
 =?us-ascii?Q?jjv/EuuTezzxIf3tXg4UV7tavCfwp/qBh57Z0YKz+BAX8VZ6HW6z3Q3658VL?=
 =?us-ascii?Q?VpGOi7DP0eXcScQhZ8fDfaPAY6kMFJcxOUCarwFIbzePWblfDMUyQ2ftMp96?=
 =?us-ascii?Q?NEySEXH7s4Mfs5u5GF6a6xL1P5pr6ydnT4gqwpkha9a3WunjGzTC4G2wkKai?=
 =?us-ascii?Q?xBiSEYB+7y9FUMB7ciE7j602Kn7FVCXoM9Q4wn/Dd7J6E210X6oMV1UJ64mD?=
 =?us-ascii?Q?SjAZb19UZ4/5lSVb1JDy/fadxLlATKoTiVM+DQBVlLPEJnglqyNO9kceNeYT?=
 =?us-ascii?Q?DP9SjYY3j1p2ovAW5+sM6Y1fHGcVTHvClprkbxgqa2cxHaueqnGsdLoAWUZz?=
 =?us-ascii?Q?Sy0/rh536zcmj12fRPi7p90MXh0IajjdxPctaxOi25e9kdDNzaNlDilOro62?=
 =?us-ascii?Q?xp/w71TwLnTT3YC/TEm1HBaqXwRtqCwaoHxgUjI2z/IXlGfQmf9xYhiiIOPX?=
 =?us-ascii?Q?RoB7AZm/8A1PLslnCWNBUeFN0OFI0XLqcJ3FYy4b47HImf+ccqpXNRGz2xQx?=
 =?us-ascii?Q?Gvs+Kif6qd5J3MG0MvHUaWbnYlNJZSJKcdGDWIMeqlQNnZZDKRaCcDU2gGV9?=
 =?us-ascii?Q?KQ8WlfvV9urnNT6vSyY48wtS0tI86ZiJ8anBSQpQU9ij/7TmFMpIRyPz1WeI?=
 =?us-ascii?Q?Ursy3ymQVkaBrhvln032/85wegS5PtAxrrw80sxF0NPxCy8wqss49vpT0IDe?=
 =?us-ascii?Q?HOjYOeFu9MijxjbQ6dvTWa1qPjdtJIgMIKoC9VcLgv9nzQpfzqc6A1dWCP36?=
 =?us-ascii?Q?FWGCtidWYUxrHD040tjBw+mze+MpQSDj+7jEO+iqoaKiYwvRrmzDgKwLX0Tu?=
 =?us-ascii?Q?nUIhZOY0RwtDb1VWk4f1faCcSKqKKbZybL0J7tswRke5//8OpdvT3ifMeQmd?=
 =?us-ascii?Q?cXLPDgAHBo0ZeubIHqomgG/QlWF6W0bQJx7/hOpzJQCw/nz8t2PDtmVLRwow?=
 =?us-ascii?Q?iSutPrLyyA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defa2535-3aae-4374-2361-08de741360b1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 02:12:51.5948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsfIc+t4MrTtsPhhGoeiUGa+NGfaX+9mpa54mKKJ9miXcAY6Sv4T89PqC2UPe2tX+vawjXNAPo9rCor9rE+rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5141
X-Mailman-Approved-At: Wed, 25 Feb 2026 05:19:00 +0100
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

Exclude watchdog1, watchdog2, watchdog3 and watchdog4 from automatically
starting when probed with watchdog autostart enabled in the defconfig

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/dts/socfpga_agilex5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
index 769678af31a..9a63a0b8d5a 100644
--- a/arch/arm/dts/socfpga_agilex5.dtsi
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -534,6 +534,7 @@
 			interrupts = <0 118 4>;
 			resets = <&rst WATCHDOG1_RESET>;
 			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			u-boot,noautostart;
 			status = "disabled";
 		};
 
@@ -543,6 +544,7 @@
 			interrupts = <0 125 4>;
 			resets = <&rst WATCHDOG2_RESET>;
 			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			u-boot,noautostart;
 			status = "disabled";
 		};
 
@@ -552,6 +554,7 @@
 			interrupts = <0 126 4>;
 			resets = <&rst WATCHDOG3_RESET>;
 			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			u-boot,noautostart;
 			status = "disabled";
 		};
 
@@ -561,6 +564,7 @@
 			interrupts = <0 175 4>;
 			resets = <&rst WATCHDOG4_RESET>;
 			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			u-boot,noautostart;
 			status = "disabled";
 		};
 
-- 
2.43.7

