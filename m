Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C2C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C62B84297;
	Wed,  6 Aug 2025 07:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Cb+WLEbm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E079083950; Wed,  6 Aug 2025 06:34:01 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD98984230
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZscwzL2Of4I4v5WRow+eqdOK09NLvdYL491gXTBDUeUJnhkxl9ti7eiF+UP3KOXfuTWr1FypyKI8BUlQ9JlLU6jZnJrLimzyGdmTLwsBiun5WiALlsJYCkz+I1OmX+tTurHKHITd2xs7v4mSoC/GWFQkKlvjH+4zPZ8M/rySMBHdZugDOJD//mTdjP6cvo0MbWDrOOuuKwiLS+4sWM3vFogRvCfPXdUA6gGytBBGEN568R29hrilJ5XtUB32leULa8iwqfSg39V/t22nr4ooEhhmsYf3iaU0CffsTdOS8+J6dJjqLKHuqcR6ht3KXnqkilaZdnmJZU50r6O+kkH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWD88UTyoYP8O+BHbGqrk4cPRswnVkC8+tCKPcN2qII=;
 b=rh6aM2vvF72eWE2UiNJncMn9fbOOP9cpvT1OH7+eAmszV5iD8qnJKb2aMEAMipeLdCLPvuQWxPUierKEQzN12Q5FnkDY0w0fe8J5j0Rd0LZ8yVFLAQ6Snd4ydWW+qGEs5W4DyCwSg2fHp3fdJL0YprRBxegV4tEZOtoC89CjnQUZT1o3Y5pJJPA9ZVqVz4CgljF925ndiHX4e14xxau3Myq+gIalBF3zwuEiqzgccvRYCvKi5fd38xIAV3hMf9p4RvDWTB+k4M9x5DTfU8P2207F3gnaAP+RUPLCPAG80LkGtnDmxodQLXssvzREdJuQkTt4mY/XiO9jfbKXo5AlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWD88UTyoYP8O+BHbGqrk4cPRswnVkC8+tCKPcN2qII=;
 b=Cb+WLEbm6evy0AwxKTYA3hqtYezwm14bt7xMzdwUAbrOSRP2ksQ3iOFUFam+IuqGC8BaYb9xae1No30LUncrf9ld/7TPM9LT0Q7DJStrIByvc6ohIi3XC5wzLIWEGc2kYsKVkt21LxvuU5AApqNbarnwtWBkWzIrmmDLlvdoN+1araXgNx8Io1JUpydJ3zyvJRgjprovgMyFEi3fMykownFTXgAkCYK4JIzkskFLa6qCLDd0OKu5EkIxfuN/JDLEqrTx1wVs4m7JLNgNCbjFbJ0CdetkpWhIbSCiBC+LrHQFaZX9yigxiN4UTWBqjM3YAAcp5vAQoA9L1sYrJy7TWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:47 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 07/12] drivers: i3c: master: Enable probe i3c without slave
 device
Date: Wed,  6 Aug 2025 12:32:30 +0800
Message-Id: <20250806043235.2260-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 56796a6d-2950-4fa7-305f-08ddd4a26f5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I6qzFZR51kOiFnYbALUymb+ewObacI1LXr2fE1RKXxsP9wyo+cuVA5y5kDLI?=
 =?us-ascii?Q?tu8c7d3kK9cgW/77xDmqf9ZQBd5GQZrBupOjmM3RUA5BvLza9eAZO4cgI8Wc?=
 =?us-ascii?Q?H5MMWjepp7vfYJQTC63HQgq5ZDLT+FVzJ/9KYYbvZwYwFhG2r7XwyFrlMuuM?=
 =?us-ascii?Q?Y4jo3IwgQQolW8Zd2VZIxQhc+R1I2SUw+bl5NbhFmrGvZ4UuQd5u25JcXi6L?=
 =?us-ascii?Q?q1EGOfHVnGmmAVhlJArFbOpYvd6cIBrXKmctcwtMBCKXp3jHu0sFAV3rpnyB?=
 =?us-ascii?Q?xoBhSPNvEE9UDVq271iXZeN4Ymjk9VDVJdJkbkHY4N2kf84k6W/ue9bQfTk8?=
 =?us-ascii?Q?HbZ93B9oabb8PRFjIi2wYCkLgCwQVKG30Pdi6vTv+V0/L/anlTu4hPO3GnWJ?=
 =?us-ascii?Q?U5vdbaBxTKauhUtmlgVYz8ec+HkfCY8z76nASh40bgdysEUWn7MwhX6VOC28?=
 =?us-ascii?Q?yIZvoQQ0/ysSo/slxOHbe93pvpsG1zogm3OZ2DFdEOC09jQI446Osnyu0wht?=
 =?us-ascii?Q?ZPycr5HW2iEcSDiU51TID5/7Fk3pQUMxLZ/Ul8GCASOio4opxt7md5OjmRSG?=
 =?us-ascii?Q?jyFxP01RYETfqPKmuLVK1wfRQdhNCSa66ZQT23kpH5/b9w1vO7oRwOczSdTz?=
 =?us-ascii?Q?8AcOcr4KU29t+hKOiMBC6LBcG+OeDJYVypWpqIpFEO169hmZSKiycRHniyun?=
 =?us-ascii?Q?lsvboo+qSx6zvHIjrRNVCKGoRvFz5sYjpDIQ1XF++1ishXF5CfqUPZWLnFJz?=
 =?us-ascii?Q?r2FjfWpuZE3sIDuKFxYcEc5iszZUK632FfhtWiBNrnDqhqv/soswA2UDYKvh?=
 =?us-ascii?Q?NMIB4OT662mklWyEz/LL/qktUX65an0Wqg8EnFWx66GAw+4WWzZ9WJHPnIh9?=
 =?us-ascii?Q?H/ohOa99z/rGO0eE6o67es0mj75bklzd3+BQx7R4VcdSmdsTKU9V+TBKARWk?=
 =?us-ascii?Q?wAxRjCZWjVMmld6SqnpxyA9O6pfnIgJxA9ZfxWOCmutUnt3ZpwdEcOK/lkdk?=
 =?us-ascii?Q?NlWnSIDpD3KhCAoFDdck11YBS5sCKLkcVg85r+0DQzPS0PiPhH8a2R9Thmyw?=
 =?us-ascii?Q?15q6KBbAzz9zRrSRl60D7/fUqN30vVy7guquCyujHH5xgYGbj3jsx/GIzETo?=
 =?us-ascii?Q?waIWjo94CQKS+jewCZIIKb5xIURrg40nxScDDRB8h3ZbBXcz7Q8tYLuBkJWz?=
 =?us-ascii?Q?ciJrFyjT5b3LdLRvONh+9E5yrWdQ05La1vpIxqYx8G6VPb7/0hIo6cseg+Z1?=
 =?us-ascii?Q?ZKBNqNJqHQqiVwgEqxhVzUX0zLQ/bi7aqgDbWgDuIq6DQYTgSCFBOpBGIhL6?=
 =?us-ascii?Q?Z7rZc16z4JMk+v/fYged2YC3KaekfTrrVQkDVWPsyeY6Rz6u3tdKjDgwurSs?=
 =?us-ascii?Q?2YrsLrMVSnFyz1cRS96YIJvRSQFKW+wWQbfgXV/8iqL4SiDdP7WV+qJFUK2X?=
 =?us-ascii?Q?5qiMNdQLzBI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVnMJSswzgvUYD4QHbxsda1a/2MmCCbT+PTq0LyakKu2xMBHsd3RtSrumfca?=
 =?us-ascii?Q?mHVu9TQ1pqS0QtRJqk8KN4KB1uMJiaemEjE3IfSX/mBggHnCL1trD16ziPNU?=
 =?us-ascii?Q?cqCcJygX8s8KAmp1Hgp0h4dx07P6l2rqavOu6Q4DdMa9M37GXU7nS5xGYGmh?=
 =?us-ascii?Q?npeBGRGBjlwdU0DEE0QgbvOyJdW05S8Ek0FD87Ccqzt5f32ZT1i2vGNgJVve?=
 =?us-ascii?Q?1kQg7xt6WdltZkmjvSk9mSZ4+Yhy5uklUu8fdZLZ90qk7APXiy+ZWuVFUZDR?=
 =?us-ascii?Q?h5DgaRlhGSxK269mM2SBD3MX4I03nBZOBT3wU6haOuGD4Q050RA9gVzb4wPO?=
 =?us-ascii?Q?8VV7ZpleHzta93G2xjp5RJmfd9kjWcoZSo8NkVmKn6cUqbo8JPtlbb5452Ou?=
 =?us-ascii?Q?y31dwJrk7S6fKAo5Tvodyg2hgJeQlDrgw4YHAlP4Kraq7F8laQJXtrvwoKsj?=
 =?us-ascii?Q?C5rovwalpf3B3V6U54CTvhoh34WswRxbbDNHhmXnCr3DVRUX+E3h86erCRyp?=
 =?us-ascii?Q?/MTvDIAP90bhOPFRSpOP9gMyz1BtfGTwpuxAvsFWlgz7QazqjOkAgbayowTa?=
 =?us-ascii?Q?4rsremYARkMF4czCEuuosmJgiN7CFBRy1RkdmEFyFAbamfNrnMzu7sZ3z9pS?=
 =?us-ascii?Q?Z66lL8FaqTnuhaRb+PUXn8Yt75caUv73wohNGBVD1HBF7O3dB5VIGTj8ikB0?=
 =?us-ascii?Q?HJ2nZuoWyGjZcHRQSbjm0x2M7gILgc+MjNsSkJERXE9zdZeZWwEFMGdYukTv?=
 =?us-ascii?Q?BJNjBOtCuj7bCanoTLgkiQ5JP/lXXKZZHh9AXZBDmwgKoj47Hm03cL6i6Kgk?=
 =?us-ascii?Q?UwnuZzeO9BrEJatsDM5z6OKshrCJEni88yHITHj9FnpobaEfDYY8O/rqhuPe?=
 =?us-ascii?Q?DNaM1BHfj799OZpASFeKFuwXCqXPnsu5CYWbcyyZurz8CbTJmwJVlwSUXT9F?=
 =?us-ascii?Q?5aUc6zqnu56m7L8VNa3vs4weFynZONJXKtdb1/eRNnTseSr47ji9HF3oqOLL?=
 =?us-ascii?Q?7iteh3+uxJT6jCkhaJPZwt3JmHhFMqkdJlxmnHdndvQZdivOHAWP7cXNvSAU?=
 =?us-ascii?Q?MNEyYkuAeDxL4bsrVlhayMXY7rhJjFauMDQKcrgtRMvyOrVemf5kKs2jHOVq?=
 =?us-ascii?Q?wqir+GS8SfvYOcgscVoHTIbN7KcYJSJF0nhZEzt/fp9dLmGQfuyFb8rb9jaH?=
 =?us-ascii?Q?BOlrlfivrdV5XqDsgDDqgbwsKTOsLM101OzTI6rx6oDtsYNt8jB/r6iWClMb?=
 =?us-ascii?Q?D/kiEYZ0WzOdFbwpswIp47DMhW8KWUqGBwIomPrweEC/Ektr9WGMOUvPoiRE?=
 =?us-ascii?Q?PjJwJUs14GwA1obgFIe+QIOf999OTBAMHwHLUo716NDfrmS1ZYetVeHYqGnp?=
 =?us-ascii?Q?Q6RgBKkJwZfEzHh/RRx3f19SS34LI/TiIhwuH3dcQF0EqH4V897qb/tpHOKl?=
 =?us-ascii?Q?5ZRCa9fvFZ1oGvPEjPzS/hm1KHCi6qZ371moPOKVQVDfM9sul9gN0+5PFGha?=
 =?us-ascii?Q?bIQQwUqhzthHk0gil31ztgUA8gAG6dLEwh8qi+sdJ0DPbBf0KF8snddrC4uj?=
 =?us-ascii?Q?GcdukQVQoQP7NM+2NSkqTmGjMRPX9V4dRdaDDb8c/blM1GUgfnhf+pDvrl++?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56796a6d-2950-4fa7-305f-08ddd4a26f5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:47.7967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5zDcrsT15HPl+GQXno1FIvmzs5W7Bx7sm4cLhXAV5l6Dxggd4bDHUUVb5S/kEj5T2C2+Sb7e8+5leTEI5pKmgABjI8NYmTWLzMBLyVhla0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Picked linux i3c driver upstraming patch to fix the issue to
probe for i3c controller without slave device attached.
With this fix, the ret check will be on command error and will success
without slave device attached.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index cf659c040a2..019167a2dc5 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -452,6 +452,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
@@ -507,6 +510,9 @@ static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.35.3

