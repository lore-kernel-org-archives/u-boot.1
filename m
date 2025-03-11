Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4058DC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 07:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D5280F92;
	Tue, 11 Mar 2025 08:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="aNAnlfqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762C480F92; Tue, 11 Mar 2025 08:01:40 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F66806D8
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 08:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj7C8FHXaO6YERvrByqKaWlUt/TYyxnFUVo+GwxcClwc0PFLyTAi1yFBazHWvmpXU5iZw7PaK0dbyaMqYcrEWLkWv2y+dJ5oYugDn8oW1Zg0SPn1VHQDsAQX0ZTsOnPKrx9++YoRbP/w7z7uUmSA06Nj/GtlkovuAmy5E8A2d7Wj/GdToHN1qAJqH1NSmeK19s1yVNaJjlnatGYMeOce9hncPZ1FNpd9VGt59wexZTJcZ9y+XGGrpbq3/DnkxJbMSy8UQG7uN2vCNsAcCVcFUXTP+5mn6qAs0dCKCIhN7K8J53LBEcxBFo2B6Inpu7lfAXFloVEisSOrxJ9FV1KYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDT8k383Cfl7ce10UftradtlwfiI0xmhOccU5y4/fqA=;
 b=u/vQJLFERIGyXM4KxYFYD6Tgi4pFhi3oCA+A7dE6hEet6M2WpLGefTG7cPEj7EBfE4SfrquKC7Bl5W3Kzp15qrsJI+uH1XRMSgURkh1CZkL8zXgHIFdzuKT9MjSs8RhdiR7WueQoW9Ko2SDjLtzP95MRX1N3gS5+E9CObA9HuxW5nd1A5d/0s7hpJPUhi2tOgzutBAfAz6MpKQ3DSJc0h/jm6Omb5Es/Y8jG4lTA74ET5j7dMP70BRx7fcj/XTFuhgDyI1tFNuRWYCN3FNZaKjX2xIyuyxBlkIbtEgWDGRamLs9vRyUJg+5zSJ14LpiVPFxecceqNMp+iRTrkupVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDT8k383Cfl7ce10UftradtlwfiI0xmhOccU5y4/fqA=;
 b=aNAnlfqP8ceaeFT9lyRW0HhWKQwnanQQ+iRR5iX++HTUQBAJ2h/O/cFry7yRVrJS5Iu0HeFokO0cr1h6jivsv2AtbHUX4WOS5DmJ4M5tuyYwoVuVrZM6VbMq+aa3EIHCJxR/VHL89wO9CXvS/Hz6l4ZvS/E+kakKVP9ktqARalJKbZ9KI2u7ieAzX5qVBVKZS3FQjYb5SguYusqYC+767Esju8qAacY4vp8czdjNWIDJFqJsw1D6YzhAI/bCbm1EUkVgoAGDKLLTkahPnnYEeF2ECrrOAXxx/JV5JFFbQbJa7b2XHcbYz2Y9QYv16fs9TPYJPk6967j13rb19cELsQ==
Received: from PA7P264CA0013.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::18)
 by AM8PR04MB7924.eurprd04.prod.outlook.com (2603:10a6:20b:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:01:36 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:102:2d3:cafe::53) by PA7P264CA0013.outlook.office365.com
 (2603:10a6:102:2d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 07:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 07:01:35 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (104.47.11.240)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Tue, 11 Mar 2025 07:01:35 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS4PR04MB9289.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:01:30 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:01:30 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.denx.de
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] xilinx: Allow alternative boot strategies in zynq-common.h
Date: Tue, 11 Mar 2025 08:01:04 +0100
Message-ID: <20250311070124.20696-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0002.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AS4PR04MB9289:EE_|AMS0EPF000001A5:EE_|AM8PR04MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: b765b77a-b455-4efb-2afc-08dd606a9039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?Y1pKm21NCVbkyKY7ZlHm0KLJeYM5rdUagAzraDEtWr1Z0wGHp5YtH08dCQ4J?=
 =?us-ascii?Q?+a/ACms4wERiLfdVbvHkF+h8+qBPs0LA4zex3lRvNgVpQOo4/8o4w1ybI2EB?=
 =?us-ascii?Q?sMnUAccQ7vAipVGaQa7LPrGuezN0bGYr5Achfnip7Ha4gPfHkZCt8fDcvjWT?=
 =?us-ascii?Q?KxYqqPq1sAp93B9VKHFx+vP38Mc4awe0BIR0SBGF2LbwUfkjh+mtVKUV4eDX?=
 =?us-ascii?Q?Jbp0c0NCpwALrVeUXAjNVnj/Zd0USdVweq2RikGkAt58lGt14mpSQjl3BEN/?=
 =?us-ascii?Q?+waRZsBYxB+25fil8Gut+OQXzuGcnllOjUUX6xm1V1L74jbGARX2L4+vEnde?=
 =?us-ascii?Q?lYkgdMimMpZyq7at+s+HX6XFl4hYV6EBtl6UIX9LNWhU796m8YI0f/9FtuKr?=
 =?us-ascii?Q?cmtwPmNlXY6Bjd63yHdRL00mLZgDMngdCLSRn7O7pc07BUiuO5k3feGU69jv?=
 =?us-ascii?Q?qJe/ICVQlvtRM0x2RCYfFMBSNwz/Bufvv8DVPDHL3FPmu8QP2WRD2m/w+nzP?=
 =?us-ascii?Q?V+f+Kb6yR8X8z/o4/3ES26csDWP+UleGxtE3Ot7RD3pcPW31/Aakf0G4xCXU?=
 =?us-ascii?Q?VwFlT6PtmIqITgylHwtdjhd/11c2YZsTFi10f2bFoZSJK+gVNEMtKRYKzQaT?=
 =?us-ascii?Q?Z6HbdX2VFHGjZAWGiC8wFTtJT4CcrqqMXIcyAZghyPV51xmkypRuzvHxaVH8?=
 =?us-ascii?Q?KG2wnxKoRgvFZxydBaP90rvWMo/yDWPeaOi9Hjdlnlgg73+bGuK7T8EitChJ?=
 =?us-ascii?Q?R8W3ULxV/ibJbGdkDH1QoPhxBOFaXlTvh7pqoXfBmJ7EuFpYFDjYb8AEisv4?=
 =?us-ascii?Q?de/wgeNFtqrLXtwOCCBVIzkIB+FteuUDNcFRuiBslB22Wo+kfY/DYPMK3GAU?=
 =?us-ascii?Q?hTrG0C0vDXR0Ona1Jm4g31H/WEPIAHMCHBFK6JxsOSaS7y3DhWYvPRgPRazB?=
 =?us-ascii?Q?avhsJYWokFyJaB07kSTvVNLPYB9+FiNWEZk2FQsomJ/p/hHJN0yOVxjtl/zj?=
 =?us-ascii?Q?Ee/fA4bAeXXijNpakHmfDjYWlo6a3AGHyK+QO/ME49BRQppvwe/Vl8PUJjhA?=
 =?us-ascii?Q?k1jOzo01QHpnhACLfr9w+eNWuisn7wDdTu5/rtiZLYxGf5V/7TlCWqodOk3F?=
 =?us-ascii?Q?JIikm17mGYombbw0Jly5q60tpCEim477XWXV0expru9ChVzpM9rGpf5GLQfq?=
 =?us-ascii?Q?b2WeatDQyN5nenNPu5pZANnPZkU2Jh2FoL5fipgp0aj38OIP93wyaXJmB+Vc?=
 =?us-ascii?Q?sDl2hAmggipMYb75CsFPnwZ5uV28EGwDeS0cR1miVe+GddMenTp2LridtQd0?=
 =?us-ascii?Q?tywYBMFfro9JP2THOueVl5d894h8YNIyIVVl06If4anKfvPZ+kksGm+l8q6o?=
 =?us-ascii?Q?wrQDorfJ9RMpW28S1JHYgaaYSRTLWqKSkQlPkftDD4DaZDyexcsoyHWDg4hJ?=
 =?us-ascii?Q?SNXcr+4ONIO39VZbQTcxlFTWRIymBvux?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9289
X-CodeTwo-MessageID: 3d8bef4f-edc7-4f10-bc81-86e6ad72a792.20250311070134@westeu12-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.39d305af-e006-447e-a675-c4e243ffeb48@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 22e46b9c-c284-41f6-460d-08dd606a8ced
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|35042699022|376014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JjcCYdxNjRPCc6Tal0umEvnI+NOLpmom1raFwb/+BOLQJ+M7qwAavOyMrjux?=
 =?us-ascii?Q?czErsXe4WSzT0lLgEHOngdnDBuhvEUe6eZM2G3rbsyX9ZWmxC0AAZeZws8Fq?=
 =?us-ascii?Q?ft/cER7W52JUOk+QUPMUYYWL/1mytH+tEjTujvE5oYk2kgrgBMIsVFnR3BvU?=
 =?us-ascii?Q?eUvSoG+SML/ymGruZ982VvQUtBcULyGzX/juA9DiqVyl1ntP5a79zlXPpdEK?=
 =?us-ascii?Q?+yfGos7yM70cZVz3A8wnOHBrInKkycMXanXTStHYDSukNI6R1ZJfZ9407GC+?=
 =?us-ascii?Q?+IpweUmybzFLfPlfG/DowhWw4QydjELhsgFCyQYlvK/t/C9pFK5EVDaGyQGY?=
 =?us-ascii?Q?Q/NXdbBRIBrWM8kKPrd4u51AFj6ZYeASk6Ka6YH3VgZId2rjLvdkEl08hVyJ?=
 =?us-ascii?Q?Dwa++9Il8CEgZ+cQyTJ4Sgl+KouLh7SROrCn2sFnic0ZN14aV5BARYWswVdD?=
 =?us-ascii?Q?XA/aFs8VN+gmB7SL6EU2ge9TmnPQL1KgT6QJAbL3mmvm5SVXq/r9xieuyyQO?=
 =?us-ascii?Q?oxP/J17Mi3pbX8zNJmIS5eSApSIS7RgseVuL+id2bZHFlkEvo8DgBtxy4FHH?=
 =?us-ascii?Q?9CG3JLso2bHUysdz+FRk+iNigtrV8WxvorKy6FtKqZ6/VqNhIh/kewJBh85K?=
 =?us-ascii?Q?8XqRgoJmFV1oElb3Gya/GsVLEhzQsoECtSxhqxusa+0SpPtkTRv6qVU6jZ2Z?=
 =?us-ascii?Q?3F7OjKz/77cDYR8a6+Yub1NFlRBKdBxiUlKguDiPaOJiq7EY7EsjsfPjLRew?=
 =?us-ascii?Q?bGPUhU6oZVv11o4cOUzdd2/gQQYk0FSKeJg7RyB6KRqdiiTUaaj5tQSYJcsZ?=
 =?us-ascii?Q?Gc9axkzaEVGrUKgQxKMLrrwh9cTMuUja4NBvrxX4NbLSs0rImyglxKnM7ias?=
 =?us-ascii?Q?A4Rd/o/soZKvteEydNmn8Zq5+WAKhIp25p9QsP7qhSY953YAOLDa84r4TvAZ?=
 =?us-ascii?Q?TbQ0aDZ2ECbzHf6N+sVFFj8fWpnTt0RwFK5wrAgnHAcpCF4nKb/kVWsKsUZ+?=
 =?us-ascii?Q?uGdOcBWjeawGC5l+UjXrGkX65ZttKvu/IYXyrrYNfTpx3eXoeJh5/gN+nxXf?=
 =?us-ascii?Q?ybxY4Saz3vhoXJLZ7uf+DQGWhbQkhXqYGMAS0OQDCcaZ4IHi9p154haL5lX9?=
 =?us-ascii?Q?Hs054tjMiMMM/3yHcoD7OkmQo9RSzgByVDSmcJ3v5NiA7HSPIJaagrytCUI6?=
 =?us-ascii?Q?rKvkGCbJs3i0uzncvDzFIbU8Y6UtfDqZt2vsIAjAqdEH+tx5wtGahOzBE7E1?=
 =?us-ascii?Q?5XgHpqvyzprKHkfQ3CeJJ0maoIc/bSJ5wCZMSK5ejZQfo/UzJ6K7OPLRuTOa?=
 =?us-ascii?Q?BK/pK7RPbqJXMekzfHgodMC5alKBwPrSovzbRVrfjzNbIs5OXs4xVyKNfysS?=
 =?us-ascii?Q?RFRNpDFrHEXe7iCFRjl4okpDYQL3KKLdxf+lh8HKOuX5qhYTybnFH7xrPDNt?=
 =?us-ascii?Q?5R6BSB1mJgo=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(35042699022)(376014)(82310400026)(14060799003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 07:01:35.8787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b765b77a-b455-4efb-2afc-08dd606a9039
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7924
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

Allow config headers that include zynq-common.h to provide their own
(distro) boot strategies. This is implemented by skipping the section
when BOOT_ENV has already been defined.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 include/configs/zynq-common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 37c77aa1611..ad872c9d922 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -48,6 +48,9 @@
 #define BOOTENV
 #else
=20
+/* Only use this section if no BOOTENV has been configured yet */
+#ifndef BOOTENV
+
 #ifdef CONFIG_CMD_MMC
 #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
 #else
@@ -167,6 +170,9 @@
 	BOOT_TARGET_DEVICES_DHCP(func)
=20
 #include <config_distro_bootcmd.h>
+
+#endif /* BOOTENV */
+
 #endif /* CONFIG_XPL_BUILD */
=20
 /* Default environment */
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
