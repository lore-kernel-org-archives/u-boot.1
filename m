Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37A9CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E0B832BC;
	Thu, 11 Sep 2025 07:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nscSlUWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1CF583321; Thu, 11 Sep 2025 07:12:38 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FB583303
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPKIETJG6pjvHXFf5RmOyXWi9ePcMVNCXJIHv5i5DA3dGMt1foYc/FyusSkgKtQoaAiymuj5fxSKZOvY0lB4H8O+BDeIRU6RFFYMpye11h8IEXxtKkpKyMdkfZn0+KyStHPD9dAux4yahFEQV3E0G21TIVxuLn2tU+V2EerQ5WfhAQaJ19I8t1F+gK/umMirG1lVkGHG/2YKvQibU2jJAkhiwRjOyfVr1uSNASTi7GwGV2rGmnskK8dVJIsl/EkitS41M8+6QJy6RMxm+k4g5NGdnPJvjKnBz+qeimyw2dhqgnZa79SmqjHGb1mC3v0VwuFwZ/Ob+XRZca5kmB/7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlIQl+07N2IbwQTFrIUU+0Bi9dwA/mj6wNLze7f8Ub4=;
 b=xDVha+Q0x5g16bcFh6qUH3SQqlTu1bxeSSxYllnoZ7H6MrLK1+8VGh6EfdtcCqPF3FhD5Puj/d7DXqcNSE36b4pvBLqVuKuVjrvMCgea1anZ9J338malBRttuUzShDcvNuvx4p98ciJn8z+egvvHsuWNIIPvTCA9p82sTYGyJefDegfEZ0PsHwnsNqbCCwmd893AS1uUrwn027rilpb5iuRgbNYBEwQT5MpA3lwJiuuCN6CTpIJKrt7hFyip4SlD1bqrb6SkQcSY3DLiEDNnTasXUCiaA8HPIxOp0ZAZ1OGfZ0uLut3MOaXylTNqGuNDcbvCXj+j5FkHGpQ20lpPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlIQl+07N2IbwQTFrIUU+0Bi9dwA/mj6wNLze7f8Ub4=;
 b=nscSlUWDysbm/wCeXx68kcXUZlI/nYmsqw5nke2HVGC8hicWojpzuna1e92QGbN2x0VJaDwalSMm7PGjEzbMwW9++ZIOpJR6sCUGn8+Fr7Tc6/fk6xIXEtn6cqZoJFwt1+yf55rlrN9+gVyvnMKCcpf/5iDFANEDQPVG5QWjHItEAVo9tonLrsdQHddaKFiR8W/FJgcFXS0K7luihCjBwJSKM5C3eBiQ1hsNrToS9GLXoyXYDzevKfybg6pSFZhTFICThnco2PjvtxrUzgXreiU5+dk4WAG9sPIExQmactXvd7JC3KbtbZUdDixZ1nN2HZQaAG93p4tXSvOSPT5/Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:12:32 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:12:32 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Date: Wed, 10 Sep 2025 22:12:06 -0700
Message-Id: <20250911051207.10479-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
References: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: ca17b71f-fe73-406e-1dc5-08ddf0f1cf52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86RHjPqIcAz/Dax+HZX9OquskTJHj7O0plaLyG4epi6f5+SmAXXrEhEu8FmJ?=
 =?us-ascii?Q?I42g1Rj/x7+ZVpFWR7pUHfvK2yoFOcMG88qefE2NY+4Ko0j8r72sPEYUa5lm?=
 =?us-ascii?Q?YwGsEPeirG4vmgX/6hH1mQQh/JkXixb45ZffQ2AxKIT/hB0DEsb2W9O/FCDO?=
 =?us-ascii?Q?Vbtv7RGgrOqtKutgQN9wASCc/z86Zrziq54og5x65m1hkmvwUcuhxpxL5KiJ?=
 =?us-ascii?Q?A/vHNvOtnOEcDRro6yzhP1p4PBpj5jo+6ZL3yYh12HwhLzcWcNa7rNrFnigS?=
 =?us-ascii?Q?yK+lFPfku89LfQsrRdH23DzwrVXr4OBJslfK19d3xzK6rlvOdavV+T1P5We6?=
 =?us-ascii?Q?CcAB8BL1ftoEH8wCgyZgxyGpZIzgRtsIieZ8NcUDtGP2N5JjQP58PiKdQEAj?=
 =?us-ascii?Q?14B4yg5e8zDUMI+lNLAF2nMThds3JxexqpUozjJvqSLpmEMjMgQKMGUHjxUy?=
 =?us-ascii?Q?IgMYyZyIDSvaYG/+8P4L0B8GxaXUmczTtxUhqfuNMf+KaF+jxIBWR5Q3fQnU?=
 =?us-ascii?Q?Gpi3EErikbHK7VHjTDe0iEBJtuCc/ZjDbjyUjI91oawlCyMCrL1XSJ7e+law?=
 =?us-ascii?Q?/PmqIsS92d2LRz364jmoj/S9ggJncSf4UNh9zprnCikD9PJIXjFnXlyfWbns?=
 =?us-ascii?Q?KUsHdbxka1REaZJHfn9X32Uk6rU671IhTzyx0fji05LRZAq03OjQ6//FXVwZ?=
 =?us-ascii?Q?bjx9wahRL3wdzd8LfhOAKcnH4xhUNtZ6+nOhro2xFfSsap1KQnV36M5BWGp+?=
 =?us-ascii?Q?4jpopqzy+rE/2B3Q2463FxIr1nEeBjqFMKpEhXZugryQ4y3tuw9Z7RAHhlWc?=
 =?us-ascii?Q?Lo0hI2LBaDf8+sASkQwMvswlnbXY/4aMeOFaiLYcveT7NSPLDiNNkgleUGZV?=
 =?us-ascii?Q?PZCRVa+DFqQQCYJVbPczbMtmA2aHRwdqkNl9nMKpZHwANZkWCm+fa5Pbnbo2?=
 =?us-ascii?Q?hHicc7bEyDWpORgwmAH5BZNTbi4y0oN1i4Fiicqqppk82DrpQ2DMPBS2GnvX?=
 =?us-ascii?Q?vxLfxPTL+n2N4LVLoo31IjCV0ZVA/c5/72gbN1zsJb2uKlPEDERwtGssJwt1?=
 =?us-ascii?Q?TspMZ+nS38fAY+9Ej1eO0x2sxHImgz01MgO9lcn/JqBfS0X7UAhRW9vhqJtQ?=
 =?us-ascii?Q?QrI5E2ysyjzdVid7QAcGUAYUeoLiGyING6qM2hyJU+UgltVF1tsyHk8XlAWY?=
 =?us-ascii?Q?ehLtWfSfmV0BAU6UX7EoJDwM6EXqWpoCHCLf3i/3ZBLal1euk0xGLuG5rzaY?=
 =?us-ascii?Q?/pz+9zc6ZW75FOmiAP3nuwIqjsoNPVq7Dp+atlNhEMGYnLH0EoQQEAC/z3lj?=
 =?us-ascii?Q?ZUjwOaB+Asj0d9KU6PR5euPCZAXqR3mhDtkgCqoJf5phBcLHQk9dfRuFE8yX?=
 =?us-ascii?Q?kzj8FYz2oVWPra1CQBYtgcbttQmG8Sa5bN+l/jvAX/YMZImhnFYveCXgEliM?=
 =?us-ascii?Q?ezlTb9gMBF0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lnRgCgN+Oam0ZZ7D+v/JSanSTQA8GY+YQxsZMGsVT1nJN+RstWkoBi9/qtkY?=
 =?us-ascii?Q?LYrG8BjcKYhC+7fd1/bwMhDJaacTa8XdL28UJRSu5UPLcFnMGJGn8zXyDoCf?=
 =?us-ascii?Q?R5VfgdrBPFjAMWHZMaVRJK+ApVL2H3DYDU0rXwzz25fJB8fc531yS4LMGqj9?=
 =?us-ascii?Q?JoYUjMJQaRLlYqjUaKnzEcaa4IEwuBrl4WT+/Bf9MCmn1Ek0fVtJlMyIPeCF?=
 =?us-ascii?Q?kPeFdXwQQ+xII08CDYpPYtnYlaJucxyU5g8vinspwGZ9ghpaLgtcxVDjnXAC?=
 =?us-ascii?Q?UFk0M5Ef6+DZhskJp0slOCkjR1CH7t1E6aGDFJRHeqAKdV9BT62EIiV/kFf2?=
 =?us-ascii?Q?xkqMwHReNvnNVVwwmNC0P6C4qDkLf1ZJotGFzPifqPwrAsooyRn+kmiRpzo7?=
 =?us-ascii?Q?tm+4p1eXX+xuy5u9D/ZnBW/usefrwaQGUOT9RVEXz/hX8CAzZEm3mNtEUJ6j?=
 =?us-ascii?Q?Ms3CS0srHkm+izT1tEEgJ1Mz6Qr5Z93mNlTI7zt0qEKKBSIP9jLjNBQL+Dha?=
 =?us-ascii?Q?cTVc+Cej1RKdbrnYp2T4VUeE0zYMTCr8LQmN3cyzsfYupEEmN62Ol1wjK3Gf?=
 =?us-ascii?Q?hSs7RWrz8U6XjUEUmdbU2f1WrRzh6GVzGb+54M+9afM9TtSwU1cPJL+dOgpf?=
 =?us-ascii?Q?apcMrxUIIbdiH/YQaPpEpVbXhz8CQSpzYdbreAhXmvV5+jY491uv+Zm8wFdh?=
 =?us-ascii?Q?9s4+9tlhzNmGKnIhoMJJkx3mvnNihyuRBNbNMkNNuicJiEvmlQP+5/AGbnN6?=
 =?us-ascii?Q?MIZkBPuW2ZzEk0N7yFZTmKSaZrZ5Qp+yd1OTPB7DNXWHghp0BBk7UQyeW1Hc?=
 =?us-ascii?Q?2D/Ni6LQ93TaEZhkkkFDV4XPafX7t0UGhWmWJepVMsa2eXlWM1ES6wv8mB/b?=
 =?us-ascii?Q?u93svhhKKyIJmsgRd5YxQKAhxt1VIHxYJoqhbk89uDgVQ5sCSJviAHewk9fe?=
 =?us-ascii?Q?ESPIzdBdiO+t7EOe707ydyY9c/PLtN4KogTyE0/bTIvhGLHci3ydBbTk64nD?=
 =?us-ascii?Q?3K9KPlC6I0sDNNNZEjHqnjmoswwM6XmEts7/EW91DjuQyLAhRBZrer9aNbQ9?=
 =?us-ascii?Q?HajY5DvmBMXNwJAloY7jyYCaa5pnH0KVHq+B0Hf65G7FGoK4+0KxnNxHIXTm?=
 =?us-ascii?Q?SbhVga9Np/Ff0BdX6JFT+hgGKlWqPBCqX04JwNNu7zX7a/bOZs5+D95slq0k?=
 =?us-ascii?Q?OGXrbtvltcp2hq8Hkd5wWtGFbiygIKFTEg0/BFvfueAZzdKVullFOKO1Am46?=
 =?us-ascii?Q?vfCs4/+nxUkkmbbH49996z8316CM68mrDvWhaMPFJGHETuYCvpZMZJ1Bz2fD?=
 =?us-ascii?Q?2WlCMSXvQym8u33LukqUBsGV6zPTZDpCeUxUtNesXO2DDWlAwx4VU5O4I/ua?=
 =?us-ascii?Q?49czSUUwAV6v2BggmQWVFcC41/mPSr58GjeCTRRJio4GSsbwpX6S7LR2LPrR?=
 =?us-ascii?Q?RTTe+iA93N4Nf6bxzS8vCTY8sC5xnFtX8GMtQcYT+q7VN1HoTvxdwY/Lmfgb?=
 =?us-ascii?Q?JNv+TRf9cmUm3J6bzoXMRG/5/t2d52YwALtiPnqztpeC/Q0DSwHbqmLwNB2N?=
 =?us-ascii?Q?WTwCvbC+s9YtgsbprUgqemIRq6FnHQpKjbKTYd6xcqcZ5tW3K6AFXKFZCXoF?=
 =?us-ascii?Q?TP4DTkA/MH0FpmCM3tgTWZM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca17b71f-fe73-406e-1dc5-08ddf0f1cf52
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:12:32.0706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nExDALKgPXeLQrLqcNw+Qnlq274Nc3mU6oa+PQ8xLbvrUa4+xkuvaUy0je+c74vZyrAn8jMXBoznwk/AnNjbYDo/mfJjIPUWJiOupXV+5B51da6LitksrUxWkBpeet2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

Some legacy USB mass storage devices during connection were
observed to have debounce issues. Hence, increasing the default
USB Hub debounce timeout value to handle this issue for devices
connected to Agilex5 boards.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 7cd2fcbf4ac..69be3bf79d0 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -104,6 +104,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3000
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3

