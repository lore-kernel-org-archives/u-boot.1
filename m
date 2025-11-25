Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156EECFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F9283FA5;
	Tue, 25 Nov 2025 09:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Eb8KWLT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE1B83E8E; Tue, 25 Nov 2025 09:13:38 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4980583F88
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA4RSH9z21MCAKixKtJxguqlEbsm4aR4LhpRrAd7KTtsuoGjducEHh0SY8Yx8tc4fQIeq9ku0vAyObqnAQpo2+3Ir4urrMTDd00xyFgp4WksDxLESQkM4hKyZ7OmZZWxDIHqPT4kr03lNkvp2YpvwLLSQ0BYm5lJEjERf5yFjf5kvVEKCAukGwd5AvqJlgk0QWaDpeR3kRpU41DIBdd/D9WxOofR0V9sXeMNKdH3ltuzwpjrJ8BJ7tfqyPO6ry581tO+Ok75NfXK/EnOxMWQbVxWNt0q5o9zC8fs0jpElYMXrbJG6N44v1RoLpeu7hXVlUL3eks0dJgC5WX8WU22YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATg8KO14tTH3lODgKiqCypX944Dkeq/8f4RPIMtuVqw=;
 b=w1YErcaH6w2+jdtLCu/RXdD72CQMZRLO9h4kbQw4/KkFWNXd4bIAJEGaCiB+OuLHWygnKMungMMerYaeSx1EQLFRk+kwVjpTmgJf+EnGodrllig+JgtMWE+xERroJ6mk7e7jSf4uov9iM5Rp2dIjCOpXauqAc1AstKTHzFZHGKM4MoEOqjSMMEsZq+SJtdU0muRHoX+K677n/1n6ibJCZrbQkPPwYLh/zzTxh1sMJjDD567TrnUQ2mM2/K4LPah5F73dQWAd4RhgNztwUU1Vr7pUhy9hUJqwFTQlGo1Ymzidz4oz6JKGW+PGJsV54etIsCviRoBou/XoPWSOP0rVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATg8KO14tTH3lODgKiqCypX944Dkeq/8f4RPIMtuVqw=;
 b=Eb8KWLT2W+7pFrj3n4F8CGcS1pnWn9L+aMDZVrgdWZWJWhXQSJUI4Jm1NlxaxQwJg6Rgcwnv2cuw9VaXrI9XZ/nhpF+ySAkA2+1QvCIw2r0RiEEDxJIH2LE+Eb494t8g9QwMYgz3WdR0y2er04uDmJLS421ELhH2/l6CcjblRxvQoWqAWlc+8AiCuHE5ju6bYdsDGtbkopIjEsS8nJuUmKBaYGQp0Inc3SLK60JH612FXVe7l6/5aFPo+ORHcHZIN1WnYxRIqX4/vVMA8KAK3fZMD0dD61C1jR09SeqnSMUlHMNJopKAgqR1hznxwzJAyuDfEzznhJTVhejvumydDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:31 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:31 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 7/8] configs: cyclone5: Update boot command for CycloneV
Date: Tue, 25 Nov 2025 00:13:15 -0800
Message-ID: <20251125081316.17329-8-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: c8255539-0afb-4c49-65c9-08de2bfa84e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3PEvbb9Uwm39Z3Rc+yYKYPGhmDF3SdRukue+QVtMi/LTdqVgVH+M6eHt5Ltz?=
 =?us-ascii?Q?PoDJvp0V2rNIo0KaaaJUKvdPIyP6/WwtYcS8HRI8Arvfe2qtVf7JbRU78JTl?=
 =?us-ascii?Q?I3ejzrVGfsTvQf43yuCRaok+jScNtEBx9BWFGM/j05JN2Mil3rJjlApivMHG?=
 =?us-ascii?Q?jcOd/5evuhfAglEt6HZJ1Pf2Xhhum1oQ2FyLBO4DNIcRAm4QLJuqNkCxKzQx?=
 =?us-ascii?Q?z4nTErKKcpuGBqD2HZ8pq2n6tgJfZ6p32vOypn9Mm4RNuHwoAoi3Yk0hxHva?=
 =?us-ascii?Q?qxL6AvCuVL3VExK4EnhZWQ1V4RnaMVuzL4n5CW6Om+QAGe59MCiQh8SW8nXC?=
 =?us-ascii?Q?DNpQZVi58bfRwk+gqz9YEv3MAkqFFlcGqSw3or1f4nKOXS7M0G1a+J483CuY?=
 =?us-ascii?Q?Vb1dRU2e7sWKZE/IzrbQ9Dax/DwoEfWTa10yJOof47fPSFkLNlHT0Ypw/kMA?=
 =?us-ascii?Q?LSZr6AmRYLSLH9lxgNr0PVSJcfJE/vHZ4rmMaJftmR3L6EmX6GTebMF23D82?=
 =?us-ascii?Q?IXCoI4Xk/PWYS/v564jMIuj2q8k/XJnrdyxGldQsfCfJAhIFLe1Dh/uqy87v?=
 =?us-ascii?Q?Qt78UkVxx7b6X6BN0jkigb6wplwhPtYCMnaE0ezT7Yj1nXapZXxiTHuz3vrr?=
 =?us-ascii?Q?lTUhHTSJoul7Kj1Fegop8tlIqg0Pb25Q4jzjFlEaF+Wo0aBv/PyMnv5bmMbm?=
 =?us-ascii?Q?wG0Waw2fsgXLcg206MLdTIUsEv11lCBuieJNA05joR9E22fx6L/EcVDlWCpv?=
 =?us-ascii?Q?OjoTlyLXIaRImY4vg6hsxeMAGsvCYDOLdkH3UAXZZnAtAkElTYJMKxlr3uwa?=
 =?us-ascii?Q?MONPH8n+XfSHwEVes8A6cWx/wgiHxK9kKzCyOFta6DNpDmYmjlb+bTLJz5ry?=
 =?us-ascii?Q?0RTaxU35GhTwKWWmrwBKnzX+zPaDn8LbJQIHGHw5lzCeRwxXiUL3e60CaEyq?=
 =?us-ascii?Q?JlO9kY9f2s+dL0cqrTQzBgVkar+CnRFhfDPn9BhRb0vGf5zUnxUtg35uXRJ3?=
 =?us-ascii?Q?hlCycRmXqGjc3uHRspQCdcQBmpMuwoj33Bs8vaZQ4gGx4XcHmkga28oLSiWB?=
 =?us-ascii?Q?7pGjIryyrYcaqBrIj6ifRBXbuV5YnvM0LDlr2QYsGm+rVTyzQ4Rh7MQXR58B?=
 =?us-ascii?Q?CTda4LKSgoDF+1fCDqXJ+A0sNdW0KexYLzfic3Y5mv1d70ObERggrXj/jbkA?=
 =?us-ascii?Q?eLQKX5WG/f+EHfiZOw/hZSMcTPXfphA0kymtadISkMy9gZ16yr9hr4ZwF8ME?=
 =?us-ascii?Q?MXliIEUD1ScKwj0Y5qBJqRhqy/L4V5LFrgDcGJVnNa7Um+imiUa5rOmt1u0D?=
 =?us-ascii?Q?ojtdnxBtX6QhqhyHfehSDN0pYCdPHmBg0TGLP/RIUpz62/dd1ny0yczjFWWj?=
 =?us-ascii?Q?cuugeueLPE9oGzRZdzTj8orq9O/4cNlXzUdDflXzlDx6BnTKtxz0gmxIsaft?=
 =?us-ascii?Q?x0ePrO0EB32N+UMsv45vdIXsvwPNpHI2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCiKVNwqpYzJi3CBClMu5JS+KPIy2QZ+xJnh8QaMmQhgx+YT7t9H4m+yhtZc?=
 =?us-ascii?Q?NCgIUz6Qfa/OtnVnXTxGbfBn5PlbknV3Q1BoDoICrLGh5RPUzsi6J66yX9FX?=
 =?us-ascii?Q?SsrUjoPpB5Khg+BiP97Dhgo9zDu3R8qWZ/4O0mPnYnJQwTxzhCR6Y3eu2/0E?=
 =?us-ascii?Q?aW41KUPuyF2XPbYgoV0a4tOFVsa9HEuJHkS/VK2LgVLYo3kSlHET0iYwV+Z0?=
 =?us-ascii?Q?DkeQ6/f1Zl6G442pTW8rcmhDSF+nDLgRS2cCp1LzTcZ9L3rroySnge0o6o7x?=
 =?us-ascii?Q?X68Y+oexLvWdtFmgi4Iwu3JSnj3j0OGdFxoV24cx1fehwfLoMGtqnhtZDzNh?=
 =?us-ascii?Q?YkKERQIisij3hVizbYhxW6gP4UtgiV6gtRThiWSSHrl0fUCohtFMrVfHsgt0?=
 =?us-ascii?Q?XAjf9aolmxqpMW/lwmfpuRoJQ91lKE8jb8yRMCkRDTpa5tcygGK+5/YdNg4e?=
 =?us-ascii?Q?Vkw7mF+MmLuYbjWhHgAHJUkYmKiwX0P9eLOrxARB2cSZCmvxgv0nj+0+0ikf?=
 =?us-ascii?Q?bUoIp56ykUdbwrcZkQ/7lx4Q6/orjsAsecRvHYC3nWRV25d4fPqUGJAGm8+F?=
 =?us-ascii?Q?Zh00wl10LL9+wgLHpjPA0oFOc84dTYimy9t4M6hYNCG+QNzmTRnMyvwiThki?=
 =?us-ascii?Q?GXHXTjqoAQYiox19a9SHFyDvlxjhbo+cHLp+WM8W3GxLrII0LwYWgjcYcdJe?=
 =?us-ascii?Q?EDVfv7TiaLCAx2cnT5ZHTsSZKh/0NdVqX12ARiZ6ZEjLtWgw/6J5pwWGUW02?=
 =?us-ascii?Q?noIjpDta+V7lo8hHVktRC6yLuJonz1VVztdACqVqKVal8S1xBtZXFf2aKxry?=
 =?us-ascii?Q?cacf8Q2xVRVh6VPiGou0nZWts0M79qMeujdN8ND7ZoV81FJLnZb96pM5Yo6u?=
 =?us-ascii?Q?SH14ZbZQHS8Ywb2UHpuq5EkXknoyzFk03/CtB1Oa74eugdlj91sgcfGd4r/d?=
 =?us-ascii?Q?inTxMG/iSXnw7Kcl3X6bJ6k/cMnNzaJ+Jw4MB8TOJ+XrGi63ZWDr3GiDvLQr?=
 =?us-ascii?Q?P0zaMK7Y0lTkZOrKvCqLfHh/BCyY21EuQSWQngqqFx60fgOdNjbwYaelZOYI?=
 =?us-ascii?Q?t2Xe4EBekt7cuDzSMGTZIK/NOAufnqSRQQhfinHHhvvW7q3NDyOxEF8PrO9X?=
 =?us-ascii?Q?SI6BycKhIEMC+8Vk/ULVQYN/Smao76WrlL1jycQW2e9f1BlK/7kUPFU65SXV?=
 =?us-ascii?Q?RYu52Wf/IG2GT7VvOt3D/R8s2LD14rtIpSOc2YhxVUWiEt9kB50K/D7Q/RR1?=
 =?us-ascii?Q?291W1tOShRC0UrvPdHzLH9nsLeVTiCDsLjAEVMI+3KgmpbVUzMZjUEMBqN9v?=
 =?us-ascii?Q?ZUwYhSihulrJH3W55SPneS+z4hXXegcNavlNaLUU59aMhoHXv7oX+At202PZ?=
 =?us-ascii?Q?ezIf1ylSIysovtfChDiLVPYczEXdgZeuYxrIz8IUxw+tsA0ONYfI+kO6LXf1?=
 =?us-ascii?Q?lRlx1c3ctdlMQV6sPM70ZH3py6tHt1WBYcmga6y0fbutTD2/1Lk8DpoYgtKV?=
 =?us-ascii?Q?tpf0IZo5R12/GvZu3p/RHu9+tMEmBqtOmPW5I2EeEjGK6YF3fK18+tBUvqZl?=
 =?us-ascii?Q?zyUy9jPADToZKhKXzuB43Iah9B+i62AZHf4w4X6TkpKONTgiD6CfiNJTisND?=
 =?us-ascii?Q?nKkBpGKM8oD1ve2Olf81E1A=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8255539-0afb-4c49-65c9-08de2bfa84e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:30.6077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk5h43RztiGFLiJ2bC7hu5v28ZpIFH0G9SR6kaZ6+9cCxE/bql64RMSPOkidry7x1S6Cx4BWbFVqNpaWXt2VXfMnzCRRbKKhEmKBZ3Ce/kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

Update CycloneV boot command to sync with Altera official release

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_cyclone5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 2b2435a27bb..94bb05d20ff 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -16,7 +16,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
-# CONFIG_USE_BOOTCOMMAND is not set
+CONFIG_BOOTCOMMAND="run fatscript;bridge enable; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_socdk.dtb"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-- 
2.43.7

