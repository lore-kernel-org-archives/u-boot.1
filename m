Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F63C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483228175D;
	Tue, 11 Mar 2025 14:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nvJPW5U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9935E807D9; Tue, 11 Mar 2025 07:39:17 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D486806D8
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbheAXgRvzg7IaQdaCACTnp++c87HesIvA1YYLjcvstFPAG6YUp9fl4hmMMsH04tYq0OGokTaGGOeJKCJQgNAWd+PC46J/gzvF3a5zETBm3kS2FkGqyEVxao/S2DSmRXksxlDJ43x6OXuxLPAN77ei1DpZEx9SUovGyCJBPBchpMrMYd7K1wxKVFu38jcFv5oV9m0vPCROCCg0jVmMVTdfEplyx+Ld5HWIcO9tF32K2ah+sjUS+4n5A92hs208Jus6oV5xqxYwuiwJP+BVFNcIpu8J1HRcOwG/Vc3Vlo0ewU4Nv3kjbfxCkVsidoQOv6NAutlvP3POw2ifjWoYzjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsWXWFkfwn5Ut2mMMInbIUCd0pIpMlFW6FJGKf5+q+w=;
 b=d1Co3oO7EjSCqQrFcMvmplYyvmOFYJOUcUYw7V1iEto52NAcinakLLx/V+37TfuDYZxOtxD0Gykpv05M233y7q0cWT12coKq0b/2SZmzBW52HxYSw500XORzCVYqFve5p6Y01IJ4KgLUtfwD5pz/f45KrbI70aMsBcMjCXElNUgEYXpNedr0eKKMX3+Vf4WEKkErcuCz8uwsMcVDWoapG2K9xy6NZuvqghKBXqP5otMfQukl+kFb4p8RzdZcyk/nCHWDWxy8+f/2tX+sFPo2FlWbsgmu1ywSbBCI0jd9qq4VZW1dd58dydMMb3qBuGZx/l5COgaaAe7MVAjs+3qs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsWXWFkfwn5Ut2mMMInbIUCd0pIpMlFW6FJGKf5+q+w=;
 b=nvJPW5U0ykcGM6JjfaP3W6J7YNwcWDgGnUmZU8uEX4tts/xZP1/l8C7q53CTtG5bOEr66Ir1F2SIh6+Vf+ee/rCBW+9OAYxyhJSvwpY41hI1nE9IsZHIcJfAeSN+LCb05ksGbB/J5LZ34y/8MgACqJoiAPjEx2NDZ6tIC+kZBw9p0Q3O9Y6PF44Vs50l8eLx2I+vBmq0TLei09XPX6EAjyBcEhhV3GOqnCXd9zO7hp8BLtx4H3AGzoGP8mCpN7lfk754oV7kJ5/lRhFuDURgZe5E2GcYBOeAslFVm17Rd8bhCrkAVCy6UiW/YmGdlBuuq/ksohbye5bV3+PCkb/Chw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3877.namprd03.prod.outlook.com (2603:10b6:a03:6a::11)
 by CH0PR03MB6049.namprd03.prod.outlook.com (2603:10b6:610:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:39:13 +0000
Received: from BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868]) by BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 06:39:13 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mahesh Rao <mahesh.rao@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 1/2] arm: socfpga: mailbox: Notify SDM on HPS code
 execution stages
Date: Mon, 10 Mar 2025 23:38:51 -0700
Message-Id: <20250311063852.9059-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250311063852.9059-1-alif.zakuan.yuslaimi@altera.com>
References: <20250311063852.9059-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To BYAPR03MB3877.namprd03.prod.outlook.com
 (2603:10b6:a03:6a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3877:EE_|CH0PR03MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d14777e-9197-4ecb-39f1-08dd60676fc7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yaOPucQpbPtppw7MhhzOjbiMPvRFH5i6VqU6QgXw0jegiQI0JmtwTQDoU2XK?=
 =?us-ascii?Q?qGxKMy9PV3G7vAISEwQZLM+HZHaNbrt0wiKg53MI2A2DsC4WVrL7YDfwHYLJ?=
 =?us-ascii?Q?6sFeXKzdVp3JDUC7OQjWP11NSFIQeZvzKvhieV5HAlDV/BRZeN7RChmBjUAS?=
 =?us-ascii?Q?n3lvC9HZmwXynr/PYTmICINwiBcQElXluO+l+Pf9ITpGZWj4xHsnlHjcNBNi?=
 =?us-ascii?Q?v3ro2t7Pk8b+0iDa0ngiwTHFKIJph6dvD3cDKGZ8opknJXeE8JZ3+UAOfgbQ?=
 =?us-ascii?Q?BpVszmelmG1rZ2w55mQGHHrU0EB5fQ+pCZ9JPIzHl2Pm4y+15oakK20kvmiW?=
 =?us-ascii?Q?Lyb5qkMRh+u7bjtmxL6C/oX2c/PNGgF2CQWPu4y+ivz6Jot67ib4UspdVqdT?=
 =?us-ascii?Q?3RNj4Wn89/+/zGVZIK6Pt2LyveiemWLt7kJ0AH1Nhn9umWW6tZaAtiuHwxk6?=
 =?us-ascii?Q?x6y2/rvb5Av/TlpOx/hkPB0MclekQkbnczh0z+rnuWy0cG8DF3jRl1uaiRAf?=
 =?us-ascii?Q?LTwPTM1XanoJHFy3wE1yRHOX9vBgG5of+3k9639TV1mK5bvwNg2A1172tb3L?=
 =?us-ascii?Q?v8g2kJpFbgGzJZnhT7PH8uDXaUq0rrV9YnVmhpYmIljJJdjP7OdMpfnzvYtm?=
 =?us-ascii?Q?IdI1vEwx9v49wTGYZ66aMqGCCd0SoHqDVo3MtSZtRIn55023yRkv7sk3nlqm?=
 =?us-ascii?Q?9C42gI6oS+mcfu+kJoAebEXa6ogY4doAKp4PIB+sphZbGIg8MrwveRVe5GEf?=
 =?us-ascii?Q?I33oVxfMxsaVCeup6qJsVlhazg/iZP52Uk3MALEq/IHXT4eyaxuxNgCdLCJf?=
 =?us-ascii?Q?T3QDEvgyeImUb4VsOAsAXZielUAWUGWntXpK0im63sOTPCGSQCzEauYAPs3e?=
 =?us-ascii?Q?Dzfmpo0qV8RwchMav22S2o4ndNZpEhXzrNMxG01Eo+MsyoS+ILZ2lmi1gR3o?=
 =?us-ascii?Q?8WXoh2Sri/CtYpgTl1hNpk3nnERu0v1+AhkDjhvqObfX+/FqsztiZnhyF0NN?=
 =?us-ascii?Q?fUmx0BStudXzJD7+qNYS6ZrxpwacEdvnywumaNdZHdnMqq4EmkHjdRmESg6s?=
 =?us-ascii?Q?7KHrtg9vSe0jfvl5ft0tkGbFg20iWhstS97wwiqcflc3MF/d6TlqEWlKn169?=
 =?us-ascii?Q?F4THXTNcdTNWBXBekpnuEpMxYgrC2SMD3OaVgihBmp8WnqQpmgBR6ZU+cTXm?=
 =?us-ascii?Q?DDR5LEar7C2ktZf7nfePGieL+gZSIfZJi/lvOCNUbtC9tSuU3sUPlJ3fZkXE?=
 =?us-ascii?Q?hPKKlbIIYiNWJqQqls1viWCDMg5rhX1JVQlZjRg6woVWtFlbz7AFr7eVMK1c?=
 =?us-ascii?Q?Yk3n1tSyuf6DFieXVvsLBPtCG6QqQlp27+MT+Gxfcj1lrxloaSOJ1RivibZg?=
 =?us-ascii?Q?Hnn5no1zYfuiM+SmA/qT6oUz8lJ0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB3877.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYkwL+2K971ovN/pIqufX1BlVcDZ9tLfDds1rmGxcAWQTRVX5DamFsgxLutF?=
 =?us-ascii?Q?XCpz22it9COf61IPqk5aF9FqArwXyba6WvNIgaAfi51ZAUtxcrTSqBxdzD4r?=
 =?us-ascii?Q?K3RCc16W4gzguAmvLrDYEHjBCVotBsw5CMRfvtgGNUCdBgJE+zPU75BuIQd4?=
 =?us-ascii?Q?SJoBhze5Vr46kqhhDrs0h1phR5gyWMeC1R72Tqej3NcUum0+2cmFG6OuauUF?=
 =?us-ascii?Q?s2KSV1D7fRblzxkeLXtE+d8ZOXbeeK2GT5YajhPYgC8LKdZDTSV4sHHG21ZS?=
 =?us-ascii?Q?kG7l9xhJr4CcwYqaaWcOQhgj08oncDgmBPR1Yyd07n1JUROgrLMkUpcq2VJ+?=
 =?us-ascii?Q?oK8XI8ZVRQjb3nTKHAlVzZEuNV8VbuCETB1V1h2UYdFhVePczfsL9xwlz7pV?=
 =?us-ascii?Q?nNBCPDdADi7sG/lVWULQ/JNe8844PHqBBEdr0gllwG64+PJ+4l1hPphlmRxU?=
 =?us-ascii?Q?EeE4mDdKER+wT+5abe58Dh17NOdphlfoBlH6RwhxuEjltu/P5ZzRolxboDGt?=
 =?us-ascii?Q?7MXuE5qBa4i6AYTytqdLO6N4mAecqNZgQIb2jdZUcZc/BzjDlm7hqIT1olKS?=
 =?us-ascii?Q?RKCAXyw57Oc7jcbe6HeKRAmy2oTO6gAr2i9C52xvQ0Y3PRFu/qwUscJ3Pa8A?=
 =?us-ascii?Q?dbL3om07E0o8+iDzGrOC3BHz+hWaoa5FLQcwApOYThYRKY7gFtaFmDUnc81b?=
 =?us-ascii?Q?S/sZMnXrZD2vBtDU/dueXxRFTcjxtxiBZUpjIzZvtXoiOrTKEJZvZ84s+xoF?=
 =?us-ascii?Q?hGw+ciKlmOP3+ckWMsbugmW/fgMqVMD4Jc1EbvrGx+daPjZhdix3s+pWgWev?=
 =?us-ascii?Q?iP4D6X3H+HyhKlc5K2icOHm8j2s+DNgLI9gObMapvL+EM7w2MW/M+wfAGeQ8?=
 =?us-ascii?Q?eg031jBcR4iPnanqiU4NhUVwpl5zYmPkmiJNGZuBNMd4ScvPDrtUUwb0ZP+m?=
 =?us-ascii?Q?KNNfgpAIGBHnatLpc0C1ge5CZqZ5THWgtpFf2tRWSxPWm+5YvELyhYa6Wu3r?=
 =?us-ascii?Q?bMBkchjh0rQUkT2b//H05w9rqNFAp8QekEBibnFkUM7hx+2Zm4H/PJrP3AiW?=
 =?us-ascii?Q?dZTnP4IKIRMe5Vw6VXLzm6DBdg+Wrtamrw5fXnbh52KsalD4NSiVZrOXiL4t?=
 =?us-ascii?Q?IzWdUnvscKxh/U5kjrJBn45KsviRfbyL1d819YJkhiOZ2Fi2JW52ortvqLMC?=
 =?us-ascii?Q?Y17GDe0i5HnFV13jB5k6OVpG0RmuAecLoTHsfIEVJFDtmfpGHWgB7e3AlZjv?=
 =?us-ascii?Q?Cr6cElvLMxpxL9KB7zMtPyED40Bu3zojoTwaneJK+3P/Y3XHZpPiUJ070ESM?=
 =?us-ascii?Q?JlUX4GzNCPkkyiFtkzCRTqW7Asd9umMM/r1XG9z6fUSuSYT7fjnIGh+FEus2?=
 =?us-ascii?Q?bCr/HU+hWGgZ2dkzZlTUaZ3Hm7uZ/73h77LeLon1QRSZQ1vamRZ/MBv8aFfX?=
 =?us-ascii?Q?G82Ynb7UOV1pZ4hzgdVE+bjARZlHHfEx40MrIJqWWmw6Q5UJElEwlNnWUwb9?=
 =?us-ascii?Q?1BcBEHz7ZcOJYjMSZAyc+lcBO7E4Npyk5dzapAWssBgSOW07ocF0EqZebjGr?=
 =?us-ascii?Q?3EbGDy2RhdMl1aURRfQhYhtv7GmxJ55S6KHkCQ+scopO6RWVGi+219DebsBF?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d14777e-9197-4ecb-39f1-08dd60676fc7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3877.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 06:39:13.0925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h61SbdoRVKr4AZ+Is/5z4DXzipWdiqAL3zjhK5OqmxhuRvFo50L/qPShDswNN4P/VAciA18FgdbZaZ6PDCjUj61sK0jpKHypRceCOmgqBAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6049
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

Introducing a new mailbox command "HPS_STAGE_NOTIFY" to notify Secure
Device Manager (SDM) on the stage of HPS code execution.

Generally, there are three main code execution stages: First Stage Boot
Loader (FSBL) which is U-Boot SPL, Second Stage Boot Loader (SSBL) which
is U-Boot, and the Operating System (OS) which is Linux.

This enables the user to query the SDM for HPS error details.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/mailbox_s10.h |  4 ++++
 arch/arm/mach-socfpga/mailbox_s10.c              | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
index 45cc9912f94..2099c51b682 100644
--- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
@@ -128,6 +128,7 @@ enum ALT_SDM_MBOX_RESP_CODE {
 #define MBOX_QSPI_CLOSE		51
 #define MBOX_QSPI_DIRECT	59
 #define MBOX_REBOOT_HPS		71
+#define MBOX_HPS_STAGE_NOTIFY		93
 
 /* Mailbox registers */
 #define MBOX_CIN			0	/* command valid offset */
@@ -385,6 +386,8 @@ enum MBOX_CFGSTAT_MINOR_ERR_CODE {
 #define RCF_SOFTFUNC_STATUS_SEU_ERROR			BIT(3)
 #define RCF_PIN_STATUS_NSTATUS				BIT(31)
 
+#define HPS_EXECUTION_STATE_FSBL	0
+
 int mbox_send_cmd(u8 id, u32 cmd, u8 is_indirect, u32 len, u32 *arg, u8 urgent,
 		  u32 *resp_buf_len, u32 *resp_buf);
 int mbox_send_cmd_psci(u8 id, u32 cmd, u8 is_indirect, u32 len, u32 *arg,
@@ -401,6 +404,7 @@ int mbox_qspi_open(void);
 #endif
 
 int mbox_reset_cold(void);
+int mbox_hps_stage_notify(u32 execution_stage);
 int mbox_get_fpga_config_status(u32 cmd);
 int mbox_get_fpga_config_status_psci(u32 cmd);
 #endif /* _MAILBOX_S10_H_ */
diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/mailbox_s10.c
index b69bd3e47ec..f9c34e85711 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -6,6 +6,7 @@
 
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/mailbox_s10.h>
+#include <asm/arch/smc_api.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -474,6 +475,17 @@ int __secure mbox_send_cmd_psci(u8 id, u32 cmd, u8 is_indirect, u32 len,
 					  urgent, resp_buf_len, resp_buf);
 }
 
+int mbox_hps_stage_notify(u32 execution_stage)
+{
+#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+	return smc_send_mailbox(MBOX_HPS_STAGE_NOTIFY, 1, &execution_stage,
+				0, 0, NULL);
+#else
+	return mbox_send_cmd(MBOX_ID_UBOOT, MBOX_HPS_STAGE_NOTIFY,
+			     MBOX_CMD_DIRECT, 1, &execution_stage, 0, 0, NULL);
+#endif
+}
+
 int mbox_send_cmd_only(u8 id, u32 cmd, u8 is_indirect, u32 len, u32 *arg)
 {
 	return mbox_send_cmd_only_common(id, cmd, is_indirect, len, arg);
-- 
2.25.1

