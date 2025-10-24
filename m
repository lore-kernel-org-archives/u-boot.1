Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746A9CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBBA1838AE;
	Fri, 24 Oct 2025 16:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F397A83693; Fri, 24 Oct 2025 10:59:51 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C76483631
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5saI+JBGG1RycKsF1wKk+rt/CO0PZQ/f853tCRpauEmbuGFuK+XKTct9UnWn+QFktWuoNAIpFsCftHRl2b9uE5aTccpTcKzBykaiSBePnTVhUYNxgNqhQ8lPGOKJ+L5JNXBh0CYkA9TC7C+M9prQcCyJSbuKuTTAduC+M6jx9uwyeRIGgJrJcPK5clY/SrrSW9OKiHnHMYisEyzwX9XYt+lym8YRrgN0afCjZIb3QvfhPxoQ0WSkR39okObX0/eNo3O62s8mdQ6XV5fvpTGR0J6hhc+muXtEmw0JrW051pKMINAHqhY4mHNewAlZyOSncdU2UR4GnLgNi9XH9qDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trxrzPq1pbo8Gi/iySNUqLyGRL3VeJfie2RHrDpkdro=;
 b=XXiQqhwdrnaZWDwt12++XNy4G6+8E0iKg3aF1hkTLHWs0hmLQuoG95ccXtun6CdyuTLo5tAW/9FI+P3SJ3DJRkCTGt1e0Db0LaXWzb5T97TYbMFysgUsVsXxBMupxcsiaQdU98iD002m6tsfwEfoemD5H83zf4/iwa1JEVrrl06sjV1NudpJuHh8RJ8ufBsqezzIuExt1sIWdpt1mlMktUnUXlWlFOcpeFl4nlrH1Y/nQdaskVbzgxoGH5z3sVl8U0s4V93g11KCIs4iySz9MXQ81d9vnLh5TpX2pWRp0bgRVSavU/qZogNx0ELWNe1iqUMvAXz2D3onWO4hsPgLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:46 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 8/9] board: starfive: spl: Support VisionFive 2 Lite
Date: Fri, 24 Oct 2025 16:59:31 +0800
Message-ID: <20251024085932.83596-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: e51983aa-293a-4b1e-1425-08de12dbade9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: 2t11CUquz7os2xcITt46Wpd9Tdfw6yIr9I+Kery4tW1NFUolr4q2WdjgSbOVUoxnl7KulmW6ZORIMNNxGe+6f9GxsN+T//rjl4Cn3FlWh8QrOjkP2ka+8qjiFuwEmNFMzvdcBi57GBbR8O6vv19QI7+IDyXWdwBMbKJPXdGvuW786ah2PpG7em+w24u8cGVMR9h2NpYNIjQHlYO3m1HxuzTXIUfTHX7PiuGSjXv5QFvo/D92aOpSCwN5bdfEIO+MyAdMGxsxckldh6RVR2fIkxY2sWeANU/qMd7MZmyPv0KcREcb7O/jxZwJzFLzK8HUeKyCaHP6h/aKwmEpSi0KNaob0OBW/oKfMZrqwexAMK2IV/jwg1h49gWBlvBkU5EAxvT1fqV8oVqC87SDQEHGSrrhqtBJtFygl+zqhcjYrzpvt0snUuYyU0MBKmNuD8Onp1AyyhegcGvtYfbQimUcYNHlvhe5S0THJpjO4GubLl5+CXLcU1jhUsD22KZZDX3LtN5ckRVwZLPPf62mQty6e7pxr8t3eqPuFlVMLFpG7FQjMd3ZEXnrdZJbHejnSNcZ63d7ElhZ2LYZLwj5FUXWlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U9JXlN2URX8ZOqzh/s6g8Oo4NmyCbu4qpEx478d4lt81aViUy3oRLFLx1Hc0?=
 =?us-ascii?Q?n9VcStx5kZgfibTv5W71QbrF9BZkUCMWwsJplPMQEOvJseoWH+vT8S8rxQfT?=
 =?us-ascii?Q?DW8XvGi4heqLLUi1z3aQKCml5BpXZolqVvWAzDURD8v/iiXIlePM25Fd5axt?=
 =?us-ascii?Q?aPa+NNf04tVtih7EEUR4uZuAkZ700TSjElt1SOW8gbpFABuy91kQmi8I59GK?=
 =?us-ascii?Q?tWDbz68sPvFdVhFQ39kJt9Ga1isRqPyvSjxE+T1zi6ubPrRXLTBdq1dFNkc2?=
 =?us-ascii?Q?BmS74t+tjMdxyVoGq252BpOyMUMEKbAvREOZ/7am/BE5EfGMo7C8F9Om2anQ?=
 =?us-ascii?Q?W9xX1bA+CwnYfwRzRcnLVXPwSSCaKStt4Keqb1XTokwbXLpq6t+LoiS2ksFF?=
 =?us-ascii?Q?6sZZHmqz+J8JNHs26BMrRaEJ+g+LFtSzZ6Wvz50DJRILD61D4tsJVWfsvUO0?=
 =?us-ascii?Q?VZzAQLVlZpeyX4rat3VgLaCWl2J3or6wLXwHYa0GaCGUY1dpDFFMEH8uMKbV?=
 =?us-ascii?Q?hIT6MPBV+sOD6gEZgQxEmgSXVEL5bjTYfsLXuQPYHycFqLhtMRnl6nTjdC2O?=
 =?us-ascii?Q?nCQkGNAl1SijBT6pZwdlWvEOIyxWHUOn74VMUfUIYauxSn57O+uNzqEJjTbb?=
 =?us-ascii?Q?iyp1NpOKMqEsDXPoRV79i+qw16zIL1NX6giAHnv71O5fpSHo9Hc2TDoX7yzz?=
 =?us-ascii?Q?6/jWgzD8N9zyTWFdnWTBDVeA4pJtA1CwLrr4SpE1p89dvgZ9ZyqFcGiI1NbK?=
 =?us-ascii?Q?P1FNXm6L8NDzSUCukp6B1agU0yxoyynwjtQAJrouawxAXRC8lhS6phkMfa9D?=
 =?us-ascii?Q?zq1RRU1wg5Je5o//ixCfG0HVirl+ZtQ3hezzKpYL45DtAnHEQSE/OQBWofht?=
 =?us-ascii?Q?PDAPMbD4Z0H/IdGRq3NNAqD0nYkbmqh+n/h7D9u5poZJlkDtaHkdk8RQ3mP8?=
 =?us-ascii?Q?BgLj1f9xopzmO+poroqTJJgzg/4O009csPJv4Egqh24X7YRPK9NWqDUtMiLU?=
 =?us-ascii?Q?2jA+LVKaP3oVMjG+FNpu4N/qTkOmYC0/rD4o/n+QhVo9urbRhpncXMOE8E2t?=
 =?us-ascii?Q?xi15lb9+MwApqRH5SsrlfcLvSeqSZ4iPT6BUIFbGA4z66MY66NJL/FWPRjYk?=
 =?us-ascii?Q?B2q3EoR493rhyCWfwvmJsPiHG64ZO0l7j8Tor4B1BophD1OzPlbJ/j7IdUYv?=
 =?us-ascii?Q?wKx0nZh2/tqmsaUSRc00TM13fInRjqjUpHU88H6vRHDIz8nkadLosdTupIAO?=
 =?us-ascii?Q?4Kc4BO9NC++IdkrtbkdrYOknC7oBo5ht87Xf48B3U8Mh+KjBI4NFKUkfiEX7?=
 =?us-ascii?Q?NzBGKxhrg4bQ3Ch8UvneuRqRq1ZwNrZNqveT4ZhS88ReBqQGH/pa0zk7F2K7?=
 =?us-ascii?Q?fHW0olwonIZ+7ua0mtn8l4sKCoYUncR1zY+wJ19hQm0ml3/2ExY5M1rtSMuv?=
 =?us-ascii?Q?j4U7hoJaB7cAXz8tOEpkxf1B73OVxh91pr1ZLNXrGAoz/4P6t7ex57hF0Eib?=
 =?us-ascii?Q?rJEEaZFOzAae5FLGNVZEVe4UzUDQVi+MUcMmSAMOIi6OSqBo1prA+EpIacer?=
 =?us-ascii?Q?CSJEELJk/IkFmMuiiS268c+BWOTOZmkwubRIhZ7QSo9+fjYAj4rjK0m0g4Bx?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51983aa-293a-4b1e-1425-08de12dbade9
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:45.9052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axDMqT9JHV8F4Zu7/QYwlKDuxtVG38b2MGixjdXeKBXRIgYwN0/cJED/tpGYLseB6sZMeHmruvMOljSfMolDU8sluF8T+6cuGN4PSh7jWmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

Choose the matching FIT config on the VisionFive 2 Lite board.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 48b034af305..b2eb04b3b82 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -132,6 +132,9 @@ int board_fit_config_name_match(const char *name)
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.3b") &&
 		    !strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		return 0;
+	} else if (!strcmp(name, "starfive/jh7110s-starfive-visionfive-2-lite") &&
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.43.2

