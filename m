Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371DCD3569F
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77D783CBD;
	Thu, 29 Jan 2026 06:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MtdF5hys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCDD83BB1; Thu, 29 Jan 2026 06:06:10 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E48383C23
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6MMCf2mJhyt9KqwQa4RSIS1yyryEybk37Lp7HE6abNHTpOxTnecGw7e3f6YxB39bSmaYHykkbgZP+WSgXodMxra+yswKA0gSe2AoxgmDE3mcMpuc6KVPep1yp80yJOf1HiNW3Ehj6E6UpS5/Iku12a5+pJm2s62n3Sh/Rz2bulsErjpgB+mBLnPHYeyGbECtJLAH/4CuvtpSELxlgN7pTYeHTNoVwPEKF1yqC3lg6PbJf7xCG3O/8MTIqGfDv8e0aIQvfaexZ8KED1NV9S2yJagVLzlmwKXzWX3fnvhgFJ7f+m/AJ8/rUWQhrG9sWNhXrjzxw4PyDylebZaVMiVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcg7BQxvbcO1C3ZoEF0rBxT+xV0Ku9WZ5LGiDG9yUI8=;
 b=j8ZnncOh+4+jY5CL0VKdqplMLY4MuQj+fri8JBkZ4gUZiNeUxW4sy2dGUV7ND0gENSD5SvdrTBrmCjTUlCmdPgnFGE5McVpHeGtnfnwcU3V7EZwOfnWEk/cLENuHyXVR9mcSKDLi6mRfpPv4Amzy+LS6wR2uIA/Q80dppKoZefRD8loZR+4NNktKxqpCBnUWbyKjdZSzF5+COz/BzyCXBVeda5GAHzSJdJKqwNjgAfciVpAU2mWximmI+0G5u7vsy/l7I1pL7uK7K+aq0a/DNq2ZvDACiMIQiS9O+cIpJj5JbDJDAEB5HA/zrcURp9DuLqBU8xiYBNg8MnBKXa0oHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcg7BQxvbcO1C3ZoEF0rBxT+xV0Ku9WZ5LGiDG9yUI8=;
 b=MtdF5hysNtQNxQ2TFYdq47rKSY5pLUaxusP6TYlTm2cWa4hEmT5rm6/JXx4lLFDguoaO6JvhowpRIaPUWd8i587XjAOAKdHbrKlT+sk4Kh+BrFZ877GjoEmiKbdKuqtpRST8veAkx0xQRi8We4YAhzJ/pm8XHc98bH1EvmLKwaeIgZen6pL7ftz48tNUYcsBC/52mZl/4MP5PCuS8tFQDQm2vAIW35/kfrNIwDXTzd8sqJ0ue8cIUjnw7Z3mNID/C10ZHL0GkU8+vCBUiSEf1v7nkH1h2tA0IwXQT32D71zIu08J4V6psU0Xbr5clYOnUfw3412aaET1efjNWrFiQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS4PR03MB8422.namprd03.prod.outlook.com (2603:10b6:8:325::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Thu, 29 Jan
 2026 05:06:04 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 05:06:04 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 5/5] arm: socfpga: enable NAND support for Agilex
Date: Thu, 29 Jan 2026 13:04:46 +0800
Message-ID: <20260129050446.8858-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260129050446.8858-1-dinesh.maniyam@altera.com>
References: <20260129050446.8858-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS4PR03MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2436b4-7e5f-46cc-8528-08de5ef41a41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PNhewnHGOybyD1TUW2V2fMnHGdr99FaCIPeBDNGxVk+YEvZNer8zmh5U6cd1?=
 =?us-ascii?Q?4CCU3cFJ9wj5dqZy2prPgRBD07HDgVerokjjLKNGdCOgGioRbqT3BWROjV65?=
 =?us-ascii?Q?zf/3pd6LyWteO9Ts+Ql1/J1f5KNj5PE4yiEccDmzUZQFSF8Q68Zv7j9lHHfN?=
 =?us-ascii?Q?OKUo5oSJevWlklLq89jEZfCtdMEKHWCA6iB0yXRfzuzYJSDiGMqmMMGVtOIX?=
 =?us-ascii?Q?kFo6m9VoDzXFW5a6tC9P3SNsauhZ5SSYqG2UrkYrb4YHFWzUY2vEEDuegFAI?=
 =?us-ascii?Q?DXT75v1Nt0U8U7o4oGeiXOqaUiDU5GOLkALI1/ElJOfTecYfp6qzKGdWBqbu?=
 =?us-ascii?Q?bdHoJGiJxUN4dRvANXzqa+2LxNuX0GTAYtkHjngsBnwcHzhW8N5ATIy3tETR?=
 =?us-ascii?Q?udeLCkabLhjpeCmv3XGS7KM2h5NQWdWigpGMNjp0j38K99Y5MmBbhm+rlDG7?=
 =?us-ascii?Q?M1MkRRRc1hDFKJQM50pWRBQV6b9BIyb44pXEoq0e/eHQ2L9sYzFPtGyOrwG/?=
 =?us-ascii?Q?njguD9Upb14NVpi+lJq5XQ7jOBXdqoaH650bnTWDSGxo/g85JRKB8+9mCn2h?=
 =?us-ascii?Q?oN2bOz5OSUjLA8mxQqA3c5hZiY0rvRp+MBqtx1RNob0yrwBkwslkhGmenqHd?=
 =?us-ascii?Q?lfb56aUdtpoPZTZWDjVJ+irmR0wNfyQrLp47MXuzm6qxJvCmnmuahoDlMoS2?=
 =?us-ascii?Q?0QVbU9Zs4K54dB28gmEK/MC674KzDuZXrSJvt1wW9iSwz8KLKpp9t4fw60Fz?=
 =?us-ascii?Q?oILmZk9A2/wB6ZU3l95GxGlbMAKS8X+ZyhOcztSbypU4E1A3KoGuVK3mnykb?=
 =?us-ascii?Q?6VQ4HhmZ+Ih+azTWL3Nsa5dx+ynNMi+JK0/LzL8nsgscMDCMhSK91SEc8t5k?=
 =?us-ascii?Q?bGnW3DoeHrKy09JtF99PJgHA9/UCt+sb3fne8BT9oEP5KXwasXAsYlbncaNL?=
 =?us-ascii?Q?l/IzZGaDTo2MYR3FWYIpAh+Qk9O+eAZuPRiJYUgh7pHJO0LkBPALsjhdOCwH?=
 =?us-ascii?Q?kdCkrSvdODgAZGv4ywIbVhUpBKcz6LU2KRwk7A/paV77OQmk6cnztPtjLIYv?=
 =?us-ascii?Q?sHVCupEB5jZFx4qOZdlXWXQLZ5QsltXDPo19cXJr0VcgF1Nzp29qetQXLKB4?=
 =?us-ascii?Q?DCk4Cp5gPXioLUxlLEP2GAMOBhCq3f+zQ2y27+F1voL+QRvJHp3e4z2Bmyg2?=
 =?us-ascii?Q?UsFUvsWS1tI4w9r3oiTuy1VJ7pYXzwU8zn9C2mi6TlnHAj1m2FZLSLRt/p1Z?=
 =?us-ascii?Q?4DpoCaAQrdp9l0VPbX5U7yPNRRm4ZTt65WRSxKK8218qZAzU5VbkDw/6mLwM?=
 =?us-ascii?Q?Nzi6j3OqhQOxVLmO4VfOMjry9PFnJWl4oakMsWYGJPtShVeSI0WHshVr33rI?=
 =?us-ascii?Q?zIMwUUeIO4iODOUs8EYwwzl0X+grXatS08Jf5GmODG2k2TX+tEN766DDF/V4?=
 =?us-ascii?Q?/Y/s6jXSNXkUSpopgIXL69Sw7OUZ/k6SfZYSgr/D/POkFYzlJgbQo9zStH2e?=
 =?us-ascii?Q?n5znDNDunGJz/1miTKYn7w/zBL9uU4fWxlQQLUmkdDhwJKA/tId0yPM5Rzoa?=
 =?us-ascii?Q?tqDXLkE2FZZrw8w7reI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXIs6+X0s93lR0ADdkOG1ycieX83RG0KhfgUUrSZTcmAiz12H+0Ve5nuRh2X?=
 =?us-ascii?Q?9gjhV8Q7kjrno1IZGqSx8AyjtqGJxtmX5iMiY2h1dhNGvg+HFQ0gEnsOEnnC?=
 =?us-ascii?Q?6ZK4EK4EKSzHbd+IYJ4hGhZRR7/Jm57PvBPiPYB4sF7THOXyxalJKrF94Hu7?=
 =?us-ascii?Q?8YL1jEEc3cPGHKfDCwhzBc416mpWLIvD3mY/xteJ5hVTB/J9VbDOyDRdEhPL?=
 =?us-ascii?Q?+CPkO3cjzTGWmWHmbRoV2RoG9Q5OzXGqv1Oz9QcU9YrxK28E5OJ4gVxMb5T1?=
 =?us-ascii?Q?APE0x4sGjcsOc03I/FyVslVhTFVDDRdnNuBcGP/bXwOnCPZSZwwezfu81iig?=
 =?us-ascii?Q?SQ37hiSEMV5fQfQB6F/9SOm5hLrxyiNxfWIH8C85q4hlVnYNF4rcKI9tuAA/?=
 =?us-ascii?Q?7PBec5BSMjNfZJVEj2B2pKK3ZfiYL4zwdxJLgqRwicx0m101LGDxjSsv2w6w?=
 =?us-ascii?Q?ErNVHseiQsvwXI2eiIdYcEdPTqFslTu8v/OnfIeNLsffpDBd+UTky7Rcohu4?=
 =?us-ascii?Q?meAWLfBfCl1xYqt1iRbEMJ5CQvFzf7kwnrqji+dZSj2vkD81g+8OXHiKPcgF?=
 =?us-ascii?Q?P3CFxOLp3WuMgHZQTGQ3GU6sXv81QtQBtKXH/sxvcp9ST7q5dNvdgKiMoKKv?=
 =?us-ascii?Q?4r370/bLFXMM7L9JkyegtcWGpLeVCiLiP9iLsVrJEfTSfbBuIxvlmF3M37ag?=
 =?us-ascii?Q?pf6En2fX9IuQmK5b4+IXQvH565jciFy7bQqmoSqTUfx2A/W1xkAxOmnf8tmN?=
 =?us-ascii?Q?OOljhmrySw6VJzAeZ6blGQUcfUVLLe4sfxVZmKQUdkI5FUkazKIVyKXoKtJa?=
 =?us-ascii?Q?io7KtGUBu8V9rxOl9CpF2RulJ2ktfF2Snxgp7053rvrAr337s+JVygDrvAT4?=
 =?us-ascii?Q?kpxs1FXYzwhI3J0NTpEFOIdfNbOyWWbzL+P+NaUwIIwBHw3+NIx6BaO8k3od?=
 =?us-ascii?Q?zd7YVUAZZTMJMtIGuG+dOMgy1KWtbPrqSO0y6cvkjH6Ed6Yio3ofqjjpXcb2?=
 =?us-ascii?Q?XXz3PcIARhxK+g4U4i7FGlxVcxHpK/7qxnjK5KnAwh+OXwKXB+u1DIPpRVhS?=
 =?us-ascii?Q?QWJI/SV5yzBh9m0+hAWBByR1NOh3HlgtT4BotbB1ca2zYbz3207uI7tg5f9P?=
 =?us-ascii?Q?9Jv5vYLNUqo+R4neV1EoDNRnNhy1R/YzBYDXRmh0oDA/hZI/ueQsA9GQWvZn?=
 =?us-ascii?Q?l6yF4TpvD2ZS3vycDmfgpAVw7TIjcmdgALA+G4dtjJ/Sea6ybtN3PhEjkNCw?=
 =?us-ascii?Q?wWosWhdToEMAdPqIwplcuAHE/Dh4+25MFKIRQqHG1jfEPhqLso7UW9TCPe/K?=
 =?us-ascii?Q?8QDHxr/aAfbLgCvAdl271rSf4ga/rS0en+qM3rjLCieBxYMVZm0Ew6pVMAeC?=
 =?us-ascii?Q?sAQkk/ketDkNc6hSfyeASIhVSGk0GYpUT5/T4CLKEllixR5qWjUAXADGcCzb?=
 =?us-ascii?Q?yvsM1iXGlU5K6fUFys3R8CIIXXs+RTS/9T6YnRu0fn0PBvhjIj4c/aAc3PJT?=
 =?us-ascii?Q?jqfAW91GlGoppc4YX8lLzZNr/TMbdc4VbkK9Z5qGKSrHMuwUpCY5Aa4pb8G/?=
 =?us-ascii?Q?+aJFvawkKp02hZixdSzpii7Zg2936p8AwSEr4cha/bWubgVsJcXIfT7ZdbEA?=
 =?us-ascii?Q?H44rxM4nCg/xF44CfaRRMg3FG+mbLHGLxTMSPxLkBzOA/eGAabYE1wIHZ87A?=
 =?us-ascii?Q?VYvbOH54m8KHwnoUyVBPrQOU6I86ZUl3rR6kJI/+oyOZvLwcF86K+MeG9ZcY?=
 =?us-ascii?Q?JboilFulq3TQqwA94MKtLl7pG0e2xaQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2436b4-7e5f-46cc-8528-08de5ef41a41
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:06:04.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEnGOB7sxiCtvQOOKWfxkk9j8rzv9P6LtvwioIfMNeAG8+QM2nnHZ1wJ1j9tUakLTgSc8TMGtNKvi7v86DmdsDgVwcst3K0xVBL/bWLmsXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8422
X-Mailman-Approved-At: Thu, 29 Jan 2026 06:31:37 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable NAND support for the SoCFPGA Agilex platform by enabling
Denali NAND, SPL NAND support, and environment storage in NAND.
This allows SPL and U-Boot to boot from NAND using the NAND/MTD
infrastructure.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index eb99392f0ea..81e33b02b93 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -7,6 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x00200000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga_agilex_socdk"
 CONFIG_DM_RESET=y
@@ -25,6 +26,7 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_NAND_BOOT=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
@@ -39,7 +41,9 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_MTD=y
+CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
@@ -60,6 +64,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_LIST=""
 CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_ENV_UBI_PART="root"
@@ -74,6 +79,10 @@ CONFIG_MISC=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_DM_MTD=y
+CONFIG_NAND_DENALI_DT=y
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
+CONFIG_SPL_NAND_USE_NAND_FRAMEWORK=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
@@ -94,3 +103,5 @@ CONFIG_WDT=y
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_MTDIDS_DEFAULT="nand0=ffb90000.nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=ffb90000.nand.0:2m(u-boot),-(root)"
-- 
2.43.7

