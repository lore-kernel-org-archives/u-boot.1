Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A9AC83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C1283252;
	Wed, 16 Jul 2025 09:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kxmKDV7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49BF8319C; Wed, 16 Jul 2025 09:09:14 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDFB182E37
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEz3xatr1ltiPDHVkrBNzpVPuh1WY4FoZxNbQ/TluINaEdzB4x42KcfjQvFUGO7ZzyOvBrFITqVn/e9XY7kRSkhjVdVooAUraJUWKF+nUW0K77lH+OgrJ6ygxL1Hrl6IpgsSN3bpLZyNqc6ocw5Lf6cY0czHYUlbXHsUcnJVKRhkLOtQE9o1GYUn3Jpf+HMThuOt8jTrWBhGfXHdJ3d3cm42/EeZPf3CPPyCcWOWdgs1jx5noxY4TtHwAza4OuYMm5IFgVAHiZE/lvg3+Sh1T9FPR2eYf1oYJ5F/xhPbjS2SKNZlZwIplgJNVxzEh6dkjDkqRB+H+ngTmmZH8W1u3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwthSkHgoiil+GXcTl5+zELnlp+QoSrk6hn87zm2sIs=;
 b=l4hro7eJznX4+lDT9cUDPVWuEuCefxTCljZpgysv8/3c/bGMksUXNPcHO2jJ6HU/39SZUp5+GlYzLaOvca4VZAMPa3ZLrv+tMTrxNjyFBkgMrYL63JEjw6ujsA+/uAhi99x+otiMidOaQq6aIrFZavE6S/xB7uaNvBU6ztPg48OXEKVEk0+Yt0B1fdAmghCAzxFSHE1iESn7wNzlsPnwe4pi2aw6U/9BPK8LMiZPXBie4BvfirKV57auNY4QhbtXiHePnYg03nOnJRgBK/Svl/LTip3NG4aJN8VYLGDw5eg7YjtMZVfJAEMrmIucQCXSVkp6kd0OtkILRrcvelYSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwthSkHgoiil+GXcTl5+zELnlp+QoSrk6hn87zm2sIs=;
 b=kxmKDV7r+W2WFAG7Q/dTiokBbU5i7oghx6pmk/GFNnZpQzks6q3ndpeaviEdXkkAxfhPfFdOLDmwHn0zqCN+q0f6mBeP773zy2Iu0cPKuK55i7RezYPlvRr/0K9NM15rI+S8iL42R1H8/KuOZa2V/W+kIUoGyLjRiBKB9torKs64FQ/sbHKmtUsNz51NvN5yV1HalTgBrzwufMzbTgEqG4yDHpk8flmi81wJ9X3Vuv8+KT1onYDdnqrovt3k1H8mCWN91m6q5CB14RtVoWoqT65UB12Rw+mEjbdwpnU+laRTlIBbLSiaqMNVy0zW112QP5Meug7tr6Ly1GDk7Iq3gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:09:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:09:10 +0000
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
Subject: [PATCH v6 07/12] drivers: i3c: master: Enable probe i3c without slave
 device
Date: Wed, 16 Jul 2025 15:08:05 +0800
Message-Id: <20250716070810.8030-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 883815e6-bb9a-4e22-a951-08ddc437a940
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VETKTjvFeeUdLOuew/7cCEXru69CX5aef3B3/R+mYzx343N+WGgNDgdp3UbY?=
 =?us-ascii?Q?H051Zz7srQUgpT8izK3+mwfpSs/HjJO1pAotid3ZavE9KntRRjgGtCoIvXhr?=
 =?us-ascii?Q?HyOATrUE0aSzbQvnjpSR6vfW6g+8gLMDj4kTboJ3dfRn21WtWVK7tT798m2H?=
 =?us-ascii?Q?kZdcMdkiXtgjyZbF7Q7QVNwekxPe3+WmT7cqfXDT9qT/o5QLbmSkpSIaZqzk?=
 =?us-ascii?Q?8Uxv6aryGJIqYyrYn6h8plqVvajL1Vyw0Eh2I87C/YPk6RDfRHXQUcD7GQ9W?=
 =?us-ascii?Q?wO8beO4vEsVEvM5JfRarcb1eNsekY77FjubKzXTDK0mNegIQX33eCCupkeVe?=
 =?us-ascii?Q?pGvkfNlqVGADw+1wqetGP+jdvNW/xRAdVLxbvpUxH+z+sIHdlpHtMxN5W94R?=
 =?us-ascii?Q?tskNE0bdKTfdGqH7zqh0Xpv8zY1Pbw+OwKWNNoClaKlOdm21guTs7iu9nBG7?=
 =?us-ascii?Q?mjZPBcdCSI5jmDkbgXctTqzc7S5hJA7Y/6B4Y8Bw6Pl3aSp63j3G0KGZvXEu?=
 =?us-ascii?Q?Zh0qglgoH526H2BiBYSuT9IgY4mVnEUOsm3KJvdqbmt3hDsxd708Q2z6h8bC?=
 =?us-ascii?Q?gHHgldlxeNq3ad/BL59iAchSNo7MjXd+ULPr6izp8ntV6gqlWCY7nVeZtJJP?=
 =?us-ascii?Q?3oxAo+SD+pEsu53r7h9AOBcuDgjBhcUIu17EVCNA64NS+MFy6bHorPrgY8E2?=
 =?us-ascii?Q?2La3vXXEH7SnF1iSdDA8qrt4n42iD8l1xq415AC/iiP8H/DDcZgJpBGxtE9Z?=
 =?us-ascii?Q?LB71ZeMyzUJv+B27FmKOFlYkbBo5kT7C00VWGWImC937MpoDL86v4DI1Nf0c?=
 =?us-ascii?Q?8X8ZfVebIQzmio5jsPSAm0uA5VYWnH5WtN62eD7BWI2gW1grqqBAUECHmkB1?=
 =?us-ascii?Q?TSTAGyr1CaQuxonaWyPBEHCygQfATg4odSprKYI66mNtJkHCWjMF3FHp3M/v?=
 =?us-ascii?Q?MGwb4W66vNPmDKKgmQJDlp9FKIh4t5WQV7gV4ungbQjoRwzALpKkNRuv/034?=
 =?us-ascii?Q?XclJFtGjQXmEiSWW8ebK2SUmWXqZXrzgbo8JLa8oIqLIumVsXhQ60cGiTfo5?=
 =?us-ascii?Q?wrsA4mqmGG7Si+kFILWq1byfCP4iLvRSYQjSA3uONcJRWh66mAYE4H2vOZNB?=
 =?us-ascii?Q?5dEx+WlQYL1qUhcfJBZHs9ZrIvfhxYWlfiE/MV4oS6ypdHqQ81aYfvXRaG3E?=
 =?us-ascii?Q?z7im0ELCf3adyNq4b3VF8smWeJUW22Ie3t7BTAMM8npY3Iv3Vv8LQ06bAJuf?=
 =?us-ascii?Q?xLwp5ZecF3MILQmT4dUMIoNum368aS5C2+F+/XGmeL0QMk6cApPWsKNv+vgn?=
 =?us-ascii?Q?XS0PlplSIW6VzFGUWWoSQ2TKEgeCv2qgtCm6kraOKqq3oxUOJzAZoiIBdgps?=
 =?us-ascii?Q?3fXYzF0F4pov0lWyC12tbykCI6sixeip1Fg1RnMHCwQ+aNJlOHb106zr3Zt4?=
 =?us-ascii?Q?goH1+Dzy6y4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ssbYvChNeJ8sWZ/733MXt+Zc51tTVE9QSoJ8/NIPL6s47/J0ozxdhdwDK8aI?=
 =?us-ascii?Q?2U4mlE+D1gGe9WtlCBMsYTsQ4D4metIMeysVW6op7NzgUOjmmJDS6npqAWfP?=
 =?us-ascii?Q?7zEUa0zIuyvpWFpqgWLhSMN8btJ3LQoxH+f8A24yuynjQFKFXukF3TK6YoF4?=
 =?us-ascii?Q?xamiwp+a0F/mkfWI2egPuPmqRi/C9f36sd8Srx4Syn1QZTlSg4HJqD7Sobyl?=
 =?us-ascii?Q?P0vOxgF1O4GjTAZ1dXl3uaJYq7iriEY7EPZ63OLhXL+PJFG11sKMdytks36O?=
 =?us-ascii?Q?fP1A5sh6Dl20pF/8lF7AnGSbDRq8drFfAlh2atLVdh7F6mwxV1LPoCbTayoB?=
 =?us-ascii?Q?hekL3U1hvk67mVGGSXdcwN5CyLMNE+mKdGFUiiCpQGE04iNj5zHEOCTjrN7R?=
 =?us-ascii?Q?pkepCkitRfNGwxMuUn22+R3lKyHNHelbrtFw8il5PCbDV9sUDkv/BAgCOfb5?=
 =?us-ascii?Q?bT3RutiXWv8Eu5l1X4KiqTq26hPvct/3TGrZUHr9M4KX5jdfSlET9LoppqLm?=
 =?us-ascii?Q?poYhd1MRynsrbQMSHyqVPEoAPQ/MHIZEk7ssxMRfygZUh5f86QupQ5CbuDUm?=
 =?us-ascii?Q?ibfiI7PfQqOJ4IQSeODQ0AmqHqTOzsaDMSG4DBqxJ2LLxl3AqJ1xteLVkdGZ?=
 =?us-ascii?Q?PhdBaZN8e/wfwtYWb1AlpZ7PPxH2XGQrQYG5TDRh9tTJq2CymmUMZdMKRAZl?=
 =?us-ascii?Q?5t3i58GvPwvuHCWqDNv6SdWLag+G4p6SDPNoupoJCt9ftufdSZEg7itCtFK1?=
 =?us-ascii?Q?tQFMUt7J7PQQ2QcNujwwSC4X78e8+bVEWWO6zQf65YlTatyj3C8OF62mguld?=
 =?us-ascii?Q?o8K1cJ3esTF1Nk6gHbNfgNQnCwk/dpIuewqRosl5NO2wXViMipHL+0e3DgSf?=
 =?us-ascii?Q?ItCmfNe6WjdEfTlL4vC36bKjMGiSo84gfFOl5Ch59whrs1lvEvGule5sRtsG?=
 =?us-ascii?Q?jqVeyL0VlnhQDBJC5Poje53hrXjuxa4aRI223pzAE36Yg2vZmLphtHlA95Wk?=
 =?us-ascii?Q?Nuq/rnRMFYEocl6CeBrZ0/TIPVQm07D16t/NSf4Z/59G2tvks4XkVAW17lIl?=
 =?us-ascii?Q?BzgvpSk2cxxtBNKu1VDJeq3ESDkjtybEYZmEvISeo8XrjO+OzNLpp9PVWZma?=
 =?us-ascii?Q?KK1s17VAiUUCXurJvHi4bQhUvJCrfIMVM/gK4CFpMk4v2IFTlRMRfEBDXX8I?=
 =?us-ascii?Q?8Mg2nPjebwfFSlaPISTpMcQmI13rbcZHJqU8Hc+q0Nv0N6dWrNqbVDdkhEKB?=
 =?us-ascii?Q?5qbhf0ElxMSbbgsGCOuQj3uhcmqxs1SZ1t7sg5FnNKKhqLScNHmQ19LaCR9G?=
 =?us-ascii?Q?ZX17IhZplOaL/295ziiRuxzNPqAKm1yBNPWPl5RRiK2Fm3OBuh5qdv1bSrGY?=
 =?us-ascii?Q?76iLnYmlVjQHxJUeMGzPufPsMAHy6a6cN4ZSQ/YxUSMs8uP2WXHNobP/10ZV?=
 =?us-ascii?Q?y7BIuf4txoVIdsGDfawfduN/H6igCtIvWHKRz45/7quAv3QKqEJ98quuZqPs?=
 =?us-ascii?Q?NJp5o1S+hGakkzc3/nUJkaJBjuNCuovCotIEyui1s/JzANuXUGSuD0pMjaUh?=
 =?us-ascii?Q?iBooI3QbAN1X3kMzim+f/Ee+zn5GbLnSMhTajJ9iX9Un5tHWJGx1fGZtALEB?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883815e6-bb9a-4e22-a951-08ddc437a940
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:09:10.1519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40iC0Nf/g4DdIV3mbXbdTc1PLmWvK+IUC8S+LKeLHES/vGozCLi+FoEJNWF0gb0asB5F2lYXNhS7SbXNiEY0bS5q8rdbgH4uvn4A2lY4HtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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
index fe12a2a1b46..909d650e951 100644
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

