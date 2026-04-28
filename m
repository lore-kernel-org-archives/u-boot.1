Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED4AFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84048466F;
	Tue, 28 Apr 2026 09:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Q+4+sihP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D309E8416F; Tue, 28 Apr 2026 08:50:22 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C9083A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfYFoW75Vc5KVB1tcRWVlRtEc5SLZIfEAEHToTx29fturcddbeviwHXXk09w/qrKnWQzZGDfBwZO+rj+BalwWqeIkOzrUlAcDi0Cro4uUN96KQJ2l67x5TqCWaI88dUFgupiuHzFKHI6khfUgMlxH9i6frkpK0NHdBlkrykFFTFdh7mOxmzBBP+hScztLuNkV/75BsCpczw7RZ4+NCvHpIiaC6FsqxOUPbyf3jAQMEKuSvtHUbJAwUkANuOW6BMpsOq/fQlRiRC5qfBQcCgPr1aXGs+3eeu6Dkjam8AcoZab7F0QaCEyLKE6X8fc/9RZYeQKoPsGBygVNabAtgP6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEEBZggfMbtVxv7UA5sXQLCtscKkEF1ZFkGZcJP/+Hg=;
 b=q5FX6dPBcqCM1Rxwgnkbd1JKm0+2Ltjun8WlvEgSfcG3kWn1CwqTsa7GX8T8JtQhNarTiarZOEGR1Qqu1PwYrN/KCQVkGR3WR+XURDGkCsFD1NgTxHYfbdodu99aH5ef7Jm0wLcu/PIgthnM+JxKtELE41SpNzvUGilaJRar8mSj1dAXnpi6+tR3IlWkhxzHsRAa2eRAM4tdNd4VoHmEAObnGDRJ+N+kC+jLZvwfnGMwbPHcFNdE4fce0Ldo5vcFCcXBq5Hoqn9vvlDw8geEu2qkflOQKdZ/VD71SuvnFHutWmJFlBeWBftXZC6GFCra+zBih6NPLVV4fPTSJdt/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEEBZggfMbtVxv7UA5sXQLCtscKkEF1ZFkGZcJP/+Hg=;
 b=Q+4+sihPEYol9TQht2Drw6O4wejdfrQRdHMBJISb82YbB9Us2lD9rKWXR8wUL7ixXiK2kSLXiqzjYgW/yAhi/d7pNbO3llHQXIpiOEOlP4CcOl0UDsX57SMe6/ZCVcvK8U3qTLKbEfY7hc0DtDqzkgRyhO1rJYOf1mIrWADjPx56+G9eoPMN4sp2V8IRbbKMEHmCL0MulBvaUaeYSxkSHKoafXfl0/JHicn5eR7yFbtQJC/DW+M1hQYNp8QKQjw6Alpj/Wq2+CVNOxAr+Jqs0XhhRLwMw5p0PLau8B7gAHjsu/hGzR+HwEiSg0O6PiX6tcKptioo3unZP2/7Stj7uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:18 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:18 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 3/8] configs: socfpga: n5x: enable CMD_MTD and SPL SDRAM
 support
Date: Tue, 28 Apr 2026 14:49:47 +0800
Message-ID: <20260428064952.3965-4-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8ca645-733c-46eb-c693-08dea4f268ef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: IodY25uGn88K0SLtIcwb4JJLEkqHMpd+6z/wCjDY9UpWJzOlEtqoU4zBNAmVv3AC3rfE9RGmzqj4QiaSFCA+2CNztjHvUDb7vZ/zm78HibMY/8D+D4YoKyJ3tlyQIxpPY13OZsCMdK3lFrp6YJ+IX7oAL3bUVXQB4g85EPqVA5X0Q+xzKTw1A1OcOec8oSOlibrX73y+2AfDjX9wy/bsCMa2iZyS/CNBZMPtretgEWDnxo/HgMewt35KYNzLIPp4MXqLXCBR4gQv0ocISfvqyXeGi0ubSXwcyhnGUaT6th5rCDLFvfx6V9VIHOnXTdfJMeE1HGxS8kd4flMOabadaPz9gEHvh5Ar0Ce3uhQNz8hpoIGavuSEqYSce2dCuOmGOqEG3LSy5A2sy8gOaWeeNCntiYS+4WPhCDmvHudcMA8rYFgQbU2K1LLsBLdqiTth7a/DLdU8z8HY99xd+EGXOSmDpIInSLZfdE5GabEaooiEEJNQmaxKPscgb6pWJbWyFIG49EMI4kWkj+DlTuJPlwCrVGcl64SqAJKHWoKxyOZhY7er7UMr2s+2gXAsg9mLbZoK4DERpcB/3stpM4YJJJSEejun2fSzk0WBMDk5Mc1R0uaCfQB3RjH4KpQzZ6nTMUqbiK/rDpLhRzE5b7o+jRR8K62SwmM8NJXMV51y8RzJ3V2aqQuvAzUFcZvkL1dS4QWquGi0tyXGwPuwdPwww0m16tw7MKCqcQBWAMU2YW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k7IBHVXyWQ9Y9DNgUcsDt6NDqwj+BazQJeIUcrd/eW6ak8glTQQZHZaQ1S9P?=
 =?us-ascii?Q?D4nhDW5s/txZxqkFqOrsUeAuV9gyMezrrxuQpiGrKLzClb4GlpcuaYqdQ92O?=
 =?us-ascii?Q?ApCFG1HK1Tg5UqPNmDPKIwhu/y5v2oK2WOE6XrvGWn5nfhtDQkBD9wn2qJlT?=
 =?us-ascii?Q?cdtlU5Q6nufWuBknINkC2WER1sSAiAgEbC/FB4bu40vHsSRfd4SeJGkB8Bff?=
 =?us-ascii?Q?oyMMKa1f7K8xx2dlmLtmDn0A0nxJY3+3t98VH3IzNM78wytPCm6JNK2l4cBY?=
 =?us-ascii?Q?42f15CgFUVxGMsS0TodDfsyBqUsRPvNpgv8std9d93UxZMbzwTOFQoUf8qlF?=
 =?us-ascii?Q?obMS7p6c+fO0vOFiPDeUg4ZkrQvx0vDhmY1KQ4iyHfjixbwN7N6lZKVF7780?=
 =?us-ascii?Q?G8H7+/+wmXlMQuBl2h2g8OCL0I306BQZiTLH+AhgdBNI1muNC+7zBh6d+kN5?=
 =?us-ascii?Q?FyKEMOK+X0wvp+7RAh5MDqI13R9ooZe58UUzveec77QSq7lMBmpo7nduk4Wo?=
 =?us-ascii?Q?sdWx99MieuHj+yYZkM0JML45VBGDXO5ISgF66HaRxV2E8W18+XHk8tfw7w9d?=
 =?us-ascii?Q?HT0hpM8E8qliVu1uF5MHhq9iJSlYzeUxFP5Z6FiuSaMLooxl/zIkVsF1oOrR?=
 =?us-ascii?Q?SP6Ln8PEBDkjJAeb1APKZKfI0mCkgFgsFtFoyIvoWSL4bDGa9t+3SMZ5E0ab?=
 =?us-ascii?Q?U5FqStmK4IncZvwsQp9qqVc5abHCxPLo/TLBslgXwwslyK775UytIFh68cDT?=
 =?us-ascii?Q?UtBEMzPSi/0K4G/Hb6D6XEQg+Kf1AgwrswMpQMyiMWADn+yWvCxGdlJpKpBW?=
 =?us-ascii?Q?31Bf3bmnRDBHt4sucTVEVbhhOF5zKKpmUoxzpusR8q/ZLLQBkuhU9vg3/aI1?=
 =?us-ascii?Q?uG5Ia+JgtAsZCvUY2JvcvDZ9z80NbG9mSFoNcCpM8S7vhQLjy57XJ51w8K0O?=
 =?us-ascii?Q?oAq5lDE5vo0/npV4Xxy+dRQaJVR3Db/T3IjNE8g9KegLQlm0MNswM0z1XgHF?=
 =?us-ascii?Q?pql2D6hSIGKBj6/sbYdAnBexx+NIaUK+2xpcgIrt1Qt2xwwvZSMpw+jEa6hb?=
 =?us-ascii?Q?4BU1Zp5glYC1ng9YwVRRS/n9o1T9KdrA3GIG41qdJqQGKJ4tlQRiWYW45mjF?=
 =?us-ascii?Q?gkiXPXYU5Pd+egNpdeBUvI9enlPKc7bSsgMuNHfCU59Ftd8kW1zRlLBEb3Vq?=
 =?us-ascii?Q?8FxRyVFPbD5VN3tdkPC8vCNeMRpoIg7sCVujGC1oEsgGxduX/JVpir+r4/rW?=
 =?us-ascii?Q?uFkU6WiRqt9HW6mvhNCTN7JIlvEFCq3lYCZcaBXrvMCqnJWewzpJoOhDbNm8?=
 =?us-ascii?Q?MFqmzZighTXHCWJhuHmbPsY+cXtRJhUqv3XZoqbjTmCMh+7EZ9W4pILkOM2K?=
 =?us-ascii?Q?v5CjeIwkbEPs+hKJ5PiWeaYnVwCSZw5kekhSeTNd3JF0GiH+hFErSGTk0hQA?=
 =?us-ascii?Q?tBe0VZsDWlE1zp+AAW598NlXLn5vUYZ3S/vQSHhbqcIT+UwvLmq7R2zi3VIN?=
 =?us-ascii?Q?jpwedTPx+uapP42Z+ZnREZ2Y6KyHvK4Qd4eG9A6Oy2SY+5QSWvMfr9NfqHm3?=
 =?us-ascii?Q?d4SxrlQ/p2nbOhdn9Th3aegIDk4NA3jOydDDJG6XGabOCTD/oaHALhciE+ya?=
 =?us-ascii?Q?S+mCMhPp+c7onl4zJaMKW7UYCcFB+Qz3p5Xczit43fb4bdnnNfRkSq13JrIW?=
 =?us-ascii?Q?VYV9L8bshAIwJUw9oUWA+UH/qOfKCvUvVD9xSSl7dp8KYdNh2bt4ywlGldVN?=
 =?us-ascii?Q?2naXT9+4qCSMGJ4SIuX7Q7x+bsU6SVc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8ca645-733c-46eb-c693-08dea4f268ef
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:18.5891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2mB8V1qJRQy5m/ZNAwra5fxZjHKVXfj1i0DAZqp9w7y2EmnTvAkZSm7imThp+UT/2l0NjYTVL5q7yMg0v6EJAc41GDXpcp4fUoacsKldB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable MTD command support and SPL SDRAM driver for the N5X platform.
- Enable CONFIG_CMD_MTD to allow MTD operations from the U-Boot shell
- Enable CONFIG_SPL_ALTERA_SDRAM to initialize SDRAM in SPL

These options align N5X configuration with other SoCFPGA platforms
that use the same SDRAM controller and MTD framework.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index aeeaa1636ae..b6df9946ef3 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -55,6 +55,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -68,6 +69,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.43.7

