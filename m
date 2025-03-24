Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8762FC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBB681E06;
	Mon, 24 Mar 2025 16:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="G/eX4KBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5A581EA2; Mon, 24 Mar 2025 09:40:52 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD9981F28
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQaz0W9wKUB5gh+x5fVJdQ6oUBQz+vy5pq5jq9AAuZAszyaNBvXKbICFNCpVH6PZtCfnPGOQb5LMWq6UgHIGm3jhWjF3Jl5y1vbwupBweQi0uhUVcIwRxPpklEjwwguboMk5/4QcRHQ8WwC7V1X4x8Jqo2h08uixEIQu9lbG02uLRgTdoQnwknq+or6VfSxvNOTpJFftP1Frj7wJ8Rrm9v9Qs3MBiJ4zcyO5MS1H7WfQ2fs5CeOta0K8Y1lD4G3O46OSNBunAO8OeNUM9KLWFOZdQCzqcPqKy0ovU3OC+VnRTT0vLz7t9cbni0KTAZOTwejSSyRvTbO84BL1/pD5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcqWFj1FNQ9EAN+vvWcrd2/otJEddB2tNLCM5knZrdo=;
 b=Pos3SOmy75OB5u4ZxlWLqxWOVEjnBQCoFBPRzXlTrafVPJYOJNSYmCWIvJ9pJKyQ9nP9cyJNWnoot5PVyAbu8PGJdZxakQnZwKBBzWWpM1rnFwD5JfQYQ+zsycpF1nO0M8WfsTq/s+uqDJxx/avSyBu/0O0QQGlF45FljBcm8XDHZMj5PJrU4FvRlFy53CtUxsAWph+khdjFGpqmwR+UIUjZ9qxL6zfbG/leKuK/WfN3yrNnl6GaysTyamh1XMuMl01HkAI5MIEd/vM0/Z1PcH9fi5Up5v2CrdMRym5bcaHQJVvtOUWTciFLFD+9COwz7otSqmf4/2iflNbXaH2NlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcqWFj1FNQ9EAN+vvWcrd2/otJEddB2tNLCM5knZrdo=;
 b=G/eX4KBXM1qrMPkyP8tJDs2ZukswHBB7X/z+Wz3XLysN1o7LJgl4HodLR6UiIVWpgPyQABFb/tBA2KW7GFbdNWPf1s0p45x52iPkD7zv8vHkIqspI1pYnGubFelW1rM9f8H4eNw6uqbXahMFQtAbu/rBo71XlshRvxwNyMGHOukQ/GKT8U8KHruaisoAWn+Ah/vSgA+eh0QyBiamywmr2VwpAPbpmPqNJJq81VA5D0JsAND0TY/r4z+/QocJiMTjRXhZT9gQ9WGK1it9C6wm+0i+J4mSxvkPhjr5GoUTi5JyQdVjFSCk/Lz4G8a1IFAelz36pyEKkRfMijDSS9C1tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:40:47 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:40:47 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 08/12] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Mon, 24 Mar 2025 16:37:00 +0800
Message-Id: <20250324083704.26259-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a67120-71ec-47f9-5f41-08dd6aaf92ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mKT779Qva2ZiNbeuvATEeZ02jvXXnPsV+XIubItJVv3UqRka1RHyI8WxAhlZ?=
 =?us-ascii?Q?pXnN6sEF2Rpquqj53cbNXbbQ6/CdPuYBtNvPnrPv+nVi0Ynr4Cwh/00630ZM?=
 =?us-ascii?Q?Dw3LKt53Gc5dnP7hemXGPpbanYa+v1yf54zEsiFk0Kh4y0W5ebFpHvvii7+7?=
 =?us-ascii?Q?vxab+QK3c6IuuAoArjn4j7Kgxqw40QZqnGugm72I/YZ2JgxvKbXu5HQsuBYN?=
 =?us-ascii?Q?Aez+AtHv77n8dqP1x3+65mFWXO9vDrPMfwgXBEwkRhu8fJtWI2AZc9FqB6jq?=
 =?us-ascii?Q?REbVCxWSVljqQiYlmmpHBYsIjuIYZbDXHW+P8aSrE+kzFx9JiTtHuAOixW3i?=
 =?us-ascii?Q?uarCwpIEXkzKlq9bf3i/1q0WxXy3rKM/wznjtCNKaBVPYOuHVl9O6ESj7MKy?=
 =?us-ascii?Q?mhn76LC981C7Lg3bew5wn2+8fhNafI7pEHE+MISwJHLGuKriKGxz44LJJyy5?=
 =?us-ascii?Q?oVgsC+F34ldeQumc441aNiohRnvS1b7dsd+JBs+Mw7c/kkcLYddOA/AX35qQ?=
 =?us-ascii?Q?Q8z4/bxVZ2Dr7XJwVSx4UmZ7SlkiE6rY2o27zF+eP1f2jyAsrAwv1bvjNUg2?=
 =?us-ascii?Q?CaVDjvalWh+ClDOlGAY9YSYX4IYDmuX2GlkFkp1/tCKaWA2c211f2/btehAc?=
 =?us-ascii?Q?ezqNQmEoQUQTMdyAK5EbGRzFw+2+vkl8963noW2cNvFZi6URqU0V4ChM3d+m?=
 =?us-ascii?Q?ExiCQLXdNoqkHaRDp1diRT8G273LD0V5hc1dmRVWPhUK6I+txph6a56yRL3E?=
 =?us-ascii?Q?7EEbcbuPUwd3vxPMuaja4H5JNEjwQbZN4ezy88SmhBBUtlFQK55hN7xttlNr?=
 =?us-ascii?Q?2s3iKAoHGlQEEHbLX/uO1jTptANUfGGwfh0sQw04tHWCetRiHRpFAW3CGS5+?=
 =?us-ascii?Q?l9p++KMZCBXNYIVHr8d3OFOQy9h16jCeuHoeBEpUjvJHPm5uEWE7GIYRbiki?=
 =?us-ascii?Q?0N9k/bewmfJp0pdWcL7bEg8BFM4eWLrN4E8+Suh/3TISkmfqCrl99rb0DqGf?=
 =?us-ascii?Q?m6CRY8MWAmGC6OTg/V7bSFHvrcsIy+BVzKLili4BIfKDmKPkBFckuAhrMW+g?=
 =?us-ascii?Q?Dxrww4HSbOY0V/+B7Jc9bHYhS/Pyzb1xBwF6dSrO8UFvpc4YtVA2gnJXuMQI?=
 =?us-ascii?Q?fw6As/Rrbl9L+jSoq8uTOFJvhONHd4ybd5z+60orYsRujYOiV9CPIdmZwOIa?=
 =?us-ascii?Q?Fqn15RQWU57phrw2l/3qSVGrZ40/w8MweEqy3QBZKF3xZAM+42i8Av7TRwdl?=
 =?us-ascii?Q?Y46Jvv6sJt4JqnLfk2impNgRL0nCuc3A5ZrbWoTDvu4jlP0gIDJq/vE7rIcc?=
 =?us-ascii?Q?RFczBdFXEIZjE6BjtczEBXkyY8v/8Tn17E0KxTcoPDdaW5+cETF8SLFGdOlh?=
 =?us-ascii?Q?t7uIkmMcolCRzVAqo4V8ABWuO69i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3viBnwBPg7Xr8SnL+uDd7zSg3p83yKYdnjwBjde3emn0SYRf1AsraIK2KHh2?=
 =?us-ascii?Q?XAba03evMwgbS3tWu45kTv1BHErRinqo9PmdgmZM3BRTRnoHAdPHECtwvnLw?=
 =?us-ascii?Q?wSZ7jX/i99osOIXR2NosbW44kU8XN1Q0zwlG+H1BNu9L2v2XM2oILTFzCEE2?=
 =?us-ascii?Q?iJoBt7ljk6O/6oWu7DxdWiH0SQmUdOvb33jRbydTdT5zLoonsY2MLn8UGAW8?=
 =?us-ascii?Q?iD9mI1+4F6VXOFokMAtkjXccuqovxwc1NQY92wG71nr1NKoS6PCLwfukxDN6?=
 =?us-ascii?Q?1R8uCDZ4RUZEWnPEkUDVwM+34RdYt2zQ7H2KDuYNkVyscDWE3GfaEkyhxwQz?=
 =?us-ascii?Q?UczUrl+LmFm5v0q8QFONW+L9z60xFf9QhXHyytsiyZOmHTGvjX8QXQFjoldO?=
 =?us-ascii?Q?18aMcGt8rTGLpISlDCsffKwS0NAgjUQhK/c3XDIPWOzKuR3dX0T2XWTgdNnG?=
 =?us-ascii?Q?Rnv/damxqHyBH0OszQy0jGGEplSdfsIfBELtDUZE0aw7O9fRpwUvwyVGf+nc?=
 =?us-ascii?Q?C7FkN6sZcRMkZd4QQ6SLgRGcp9rPqU/B+w37XbGCdvWPQXcaYAhQYstPKRqZ?=
 =?us-ascii?Q?A0ecHx3Ns/xYhzYBz2iBWiEj8bBU4Sl2OOfRhgFJ6AqLZ3l5O3vxRtGomMnD?=
 =?us-ascii?Q?VdcIWbaV3vWvl/VNQCkFWwApGFQ4eBTdA+4DrLChvTCOSfslhtuzb4zs6U6o?=
 =?us-ascii?Q?F1J7+z+qg01rJbMhmW10OEuJxotjc8wTWHwLF8RuwEKibPNk3KBqbpxiuWP7?=
 =?us-ascii?Q?/iMmZrHmD0ycsvpkSnClgIQ0upvWU2NruOaovAHuaFVriL7MZtprKB8cE/be?=
 =?us-ascii?Q?GJGymg7BPdGpc+uW7IKsjE42DD/Za5B+1le+0gV3g7UIjhSGcUBhJrcogKOW?=
 =?us-ascii?Q?Y2l6EqzdIkUOwRnsURdjtW57ZP+07Xiifg0YlNaskf6k3G8Gft7wrI5S39KH?=
 =?us-ascii?Q?KgIYmpbchaO/7G1jiVL9P01BX7lOdIg266IpA0ou3dV979Dotd6bzmlEE4oz?=
 =?us-ascii?Q?xLn+5agsHwri13INjd9ff5PJgJ1UEGRHzjipD62b6XYciWCHiQHvizB9M1Fs?=
 =?us-ascii?Q?7PGirj/7fHsGsPOwv7ydvnncXKE5bEskLrYyCdZf2wngK+wraMZHVvyLFXzp?=
 =?us-ascii?Q?QqrPUnwIx74cDvwILUrkwyreYTgwJwJeM3uIXA1mXOcOojjnqGE7dTcAkWyN?=
 =?us-ascii?Q?PVxPsfHLjRBh5t+z00Opkz4JNmaQ/8IhRyBUXkleBJT0RvxgD0l3TvVb0of6?=
 =?us-ascii?Q?me4XzOdUIquFH4Rlo9+XeM6q0tIa//ySFiFv5RuhFt2bX2vRPCez1hPXjyZJ?=
 =?us-ascii?Q?MW+VD2Fx6O8boI+BkON+tDM/2bbDhf/jh/lSXLZbQrhEfsi0BH2WzgYMbQ0S?=
 =?us-ascii?Q?ROt1NczOk9MMQd/RtDy7v1x5wuLAGCz2e9PvQ3D+MXssDO3JZjUFb/2ZjO+s?=
 =?us-ascii?Q?9t/m1tGNhsdtENIs4WmBKtJbl3YxRylkI+5JzjpcVIDftiQjYdovwZepUqlg?=
 =?us-ascii?Q?Bv2REbNcRDBjosFxabdUPbKJdlqtxeMnNz54PDvVyzC5ILhWwmPEujDgmoIt?=
 =?us-ascii?Q?tcm8KHlIaueTgc+oAK5GL6jV3mtdqz9Uc8dvO0YzewnRvpkAN9GHwaAmnw5+?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a67120-71ec-47f9-5f41-08dd6aaf92ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:40:47.3658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nzuoGykH8mZ4r66zUdJGXbeoH0BBdZ7isnmeBXljaTMtIie+aI2BiMJYaR/xqnJ342PxSs0bUa5xPD1Hqi65HSHn9TGituelwp/i/GAke8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

Fix the I3C device with spike filter unable to detect issue by setting
tHIGH_INIT to 200ns for first broadcast address.
This is according to MIPI SPEC 1.1.1 for first broadcast address
which is already part of linux upstreamed patch.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
 include/dw-i3c.h                   |  1 +
 include/linux/i3c/master.h         |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index b3c5bf210c6..af6e472f232 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -330,6 +330,14 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (!master->first_broadcast) {
+		lcnt = SCL_I3C_TIMING_LCNT(readl(master->regs + SCL_I3C_OD_TIMING));
+		scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | lcnt;
+		writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+		return 0;
+	}
+
 	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
@@ -347,6 +355,9 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	lcnt = max_t(u8,
 		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 
+	/* first broadcast thigh to 200ns, to disable spike filter */
+	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_INIT_OD_MIN_NS, core_period);
+
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
@@ -402,6 +413,9 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 thld_ctrl;
 	int ret;
 
+	/* first broadcast to disable spike filter */
+	master->first_broadcast = true;
+
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -481,6 +495,15 @@ static void dw_i3c_master_irq_handler(struct dw_i3c_master *master)
 	if (status & INTR_TRANSFER_ERR_STAT)
 		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (master->first_broadcast) {
+		master->first_broadcast = false;
+		int ret = dw_i3c_clk_cfg(master);
+
+		if (ret)
+			pr_err("Failed to set clk cfg\n");
+	}
+
 	spin_unlock(&master->xferqueue.lock);
 }
 
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 920f18bccb4..42c37d6dfa2 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -240,6 +240,7 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	u8 addrs[MAX_DEVS];
+	bool first_broadcast;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index bafb1448b57..c2391170ae1 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -278,6 +278,7 @@ struct i3c_device {
 #define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
 #define I3C_BUS_I2C_FM_SCL_RATE		400000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
+#define I3C_BUS_THIGH_INIT_OD_MIN_NS	200
 
 /**
  * enum i3c_bus_mode - I3C bus mode
-- 
2.26.2

