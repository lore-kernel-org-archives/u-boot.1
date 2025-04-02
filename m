Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839F5C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 04:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6649781703;
	Wed,  2 Apr 2025 06:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m3ncLG6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88354817C4; Wed,  2 Apr 2025 06:36:12 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BA880584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 06:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw64PWKUPrfmirve3oQNkOwGQvGIXLNxYCPL4lWjwiDBNET2hXWgc4qWuxeslFYQ/Y9CnWWzQhx3IDG3YYluvlg4EkBwJqPDTXS2CCSfaLj2Fyl6U3nA06udlZ5qIzFrtP06DIMazF5eS5CtkePtt8chtU/iNf8j29wt0XT8lIOpJwRygt/8o4gLgdFGzlHAilhLoOM/TJg+9pjU/8McMn10Ib7sRABH/cB9gXXh2EAEpAZznhrtr3mHkI6czgwq2hWzu4eYdLXCcEW0l6Tmg7rSSfpXF/dLK5aZ6f75xrUi5n2MXwggefP8C5q9Y8nZQsX7w0SgLtLBixqgMk4hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYEq6haabY1SeJNasorcwGbckdmq/6QMmQElW9N6L+Q=;
 b=QASGWR4btAonM8awehkaYFlX0GjwfgAojH+Rcw2timJIYpOe2V6dkuLHm6lAf2we6htjilFRK4gqGI0iAju9oTtaINSg2oBmky3P0WfAPGr7Nu/lgDrnCslVlru5F5pyEe2D0GDt1Dv6ZUYtlKxhuY1ve/sI7w/KmSeIqk7bDHabQHtdzi8mVoundyCYSUwVPKGhKaCnrCXn7MWzVoqCAf97SYDGyf0AFMXb3bwQLsQA/Z7P2vYrrttuY3ZhAgydHoqntxp4z7d1EVl0HnDUTkfyk8MIda0b+zEqsnu8kJfyM2GYgs758lx/eJ3oI5Gspr4jA8E9SpwJGP9l6ya0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYEq6haabY1SeJNasorcwGbckdmq/6QMmQElW9N6L+Q=;
 b=m3ncLG6TsEHbaKvGgkTMFyDppKMVW1d2V2IispzExPNtINBwCE00u4benpFJ8NVBX7m8Pf9aaJa9dusWT+CzyJKHS7QBbPYHTpXEMgmezyBPq6rwurnqUqDAyHVenR2hepEShBvj5UZUDV2L80uhpUpjQ7uDKtzbYlxk+R80dXxIfDTRFm56TwVYwGnBrIJx4doOpqmSCRBeMbjaCpP0OWGFfMo5iX1TcNF6os69EpP5tZD2id+rdxxRrKk+F1ylU/2AdOvVZX6XFFh28Q3krf/JmpZZslsscTbG39fjeef5kc/FE8ctDUZ2X+yZJRm6WvSwJFPVSM2rJjbdch5G+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 04:36:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 04:36:05 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com,
	festevam@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] firmware: scmi: support to manage SCMI protocol drivers with
 a linker-genetated array
Date: Wed,  2 Apr 2025 12:35:20 +0800
Message-ID: <20250402043521.3908918-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10444:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b00c8c9-0783-49d3-ebd5-08dd719fe123
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/VGWlc5d5vCCQ1O6Nc0FaNnmMohlGc5lLj3mNBKE1QthPQoCeeLxFbb+MGHQ?=
 =?us-ascii?Q?8WmzulUAhwrtbvfpkH8EA2ae9LF6tNN+nY6zmFytdUU25IF31dZB8/j4muqp?=
 =?us-ascii?Q?WMqja89+LOIh1fP6lILGw0G8Pr7zbRPTrI1TEXEd0ZfbbgnFal6p5Gkn1gR1?=
 =?us-ascii?Q?zmmRvSBKWoPHrOdSSc+aeJVo+h4sS9y+bBZ9wGN6sfd7cFhDegyTvJhzDmJN?=
 =?us-ascii?Q?SAD+Kopb0g4oRFEyOODH7PeLXSAjF6UuZdUSFnyS12FO/Pxfua9AuqdmpkfS?=
 =?us-ascii?Q?AQZse224tBqtdaxulfM5D3gHGl1MYebJR1xPYM2bJik6sJqWWxHSosP2OGjk?=
 =?us-ascii?Q?+tMOdKqSUfFWpblgFzKN2Uo3VwP1oYzkMlUU9hmx2Rz88sWR3r4+IJnblIlI?=
 =?us-ascii?Q?J3lWt6HY6pqCVlxE0Y+XCiG4FmvWtcRWkoOqeXfU6Wx+Wp5Hb+IufUed7gmR?=
 =?us-ascii?Q?FER/KQZoW5dGjBOlh/4vopQJocdSwv2CG8GcxKIsJlnqTwsL8D8B7pBlgh5a?=
 =?us-ascii?Q?nyJnK005G37Y1HX2JL9dOAybqe8XpcO29h/TAq23+QoKbcPaMzSFpQJMMNH/?=
 =?us-ascii?Q?eO+ZXgq5O+kXsaKA5hRPo5LsFpwFURDPiNWhHsm/Eodt0APG/QF3HqoLi0yT?=
 =?us-ascii?Q?IAAzZjAZMm4N5R02X+vM9b4POJcJ5fCOaG6GQY143/6pvfs2B+OgIl/GN5Ye?=
 =?us-ascii?Q?HAO0hNlGVgBAwGmLDK9w2ZmrvYx8Hf4+iV5GXyjPZktCWDsbdQpcHw+WaRYN?=
 =?us-ascii?Q?EkZ3onC4FZCMcDis6jJyHZyP1lddtAgcYxCHN46FsQBYWJyydvFnxxFhMWDB?=
 =?us-ascii?Q?Es5R22xKp4YS95BSHhI3l8TjaPypxrfHqJZwy780GZ9U46PAE4rkV09GdCDq?=
 =?us-ascii?Q?MAKX5FagGrhwi8aZ54VyY7QcEsjmcsO/dj3qe6PhwCdyr8O0MMNX9f114PFb?=
 =?us-ascii?Q?OpnDXj+8CsCB4HsPbatjHyA6HmgAE6j4dUzanVcu/dcYu4xT6eekYpzRvy5F?=
 =?us-ascii?Q?IlANjgT+4n3e4Y15TOabAgqmLP3pt6MlsE2VQAEatq66dwNR2AqB0yffjvhh?=
 =?us-ascii?Q?jyj37ZCPyEciD1PbDG6vdSQ1VLvpTus2GOqYfv+Gx1urb9YQpeOWYa4dHm9u?=
 =?us-ascii?Q?GLy6B417ljkO6xh4o9HcBqMl24Sk77RQnvCAbprYGLL+YT3YZCzZ3liF0ev7?=
 =?us-ascii?Q?EZZSY/wt6gEc9BDnlEF+I0ihsWxRN+u57YaXhEa+N3yBN7OguFJjs1wqlvj0?=
 =?us-ascii?Q?33Nm4fKTfxTzTnd7mt1vOKizAOOR8F613VFqsPmdDnRtRZ7osPWcqbU2+aD3?=
 =?us-ascii?Q?Qzq1yNaBmhV5WPj1DocooCXJnxyKdqBi0l+Ihzq7yXLGARwnxg6ytn/AJCYm?=
 =?us-ascii?Q?iqKR7pn1nhhGGpo5dRTYtMOBBQryH7oAYzCkmb/Av8CWtFABAD9lgYU9SZlX?=
 =?us-ascii?Q?mvXfufYFx8X4C2iOdNjdGKW8J9X5Wz7W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+06HW+bi+GHDxNUxR3EBbBrpEGV8jiSyEJAocxJEco0/v78tL4JhL5nbGXk?=
 =?us-ascii?Q?YtNKRBy62KMLr2RwXdYf7M4sn0f4nqV2vp+PigxpdGh/lt4cjd1kpaw9qSL4?=
 =?us-ascii?Q?dfWGSaFDNW87luImJNd9/UShdMj/yefJrlykgB9/QwA+WBVxqwR/ZOgjiwqT?=
 =?us-ascii?Q?IRyeG+GKlfdRNYxfVa04C5ANfATHFlxYiH/BhLmXJDsy3VhpV3ELjuhna0S/?=
 =?us-ascii?Q?xy17F9DIXCGKFXf3d1Ju91edsDrVRFl9YuUeIfZmXdXTJKdSstadBq8MQwNM?=
 =?us-ascii?Q?vKOaM2lpgppkr5zzNW1SuzqjOKpBAa+XF/+7UF6rAl98IQiuIqTo5ypH3TEI?=
 =?us-ascii?Q?ThutwoWu2uTCCTDce+MdzQlDUrkEChVzoptvFQCiZElOIWcxMDpjf8evV81U?=
 =?us-ascii?Q?HCWjZuv7798XsiroOQQgKEjF206HWguq+JKqZde0YUkgTGbwC0TxeyZmrdXQ?=
 =?us-ascii?Q?sqFbcF/JVasGRJYRQf2IuDtIs+PU+xypXVE2xJ0x171jfY6J9nszc6dZ5Wz7?=
 =?us-ascii?Q?GrCi5H6aKgWLdzb/r1xx2VieF1jVJgi0Kq7989f5dgdXaF/XVgFDtN8DVoHO?=
 =?us-ascii?Q?q9DFa0id51JiixJ7OJpZ6aSZt61hhcFElGP7gz+nt/PhDsb8OsWYt+nnYzS0?=
 =?us-ascii?Q?1jLSl0tM9PImQPEJqT8i8kG0gmHtXM11zKYn4K7Cu2oU1rYAZYK9F09Fqf/Y?=
 =?us-ascii?Q?9WaqtoUTqc93ksYIX09zA2esGggKOsAWGvAGve2g3UjCqHlf+iQ+AuB5At1Y?=
 =?us-ascii?Q?SJUUuL3N23k1XOEA9C6XGnLMwa0mtU/9gZpUQGt4pnY64zc6QniRzdUGg/KT?=
 =?us-ascii?Q?2yQ/X89+nCMo4cR7rQ0RfSaSkAkYytrsLIorUi/KAbayHL6caU9Y5ewhNW+W?=
 =?us-ascii?Q?s1jaVfT8JZ/luQu6OB4LhT+wLaafko0ZeG1i0imQZaPPuP4hrBxOHAO/nQgt?=
 =?us-ascii?Q?q8ypJRGuD9lmYSX3ErnQnUcma+qsnJElBBucXZHkJ+Kk7yuVHzO/dSIfpUoe?=
 =?us-ascii?Q?AEXFCGpmyq8MmItT/DuZRoX9ttVA5kwbi+9+6zD/d+YcCcYwsBiKTAH1zBnR?=
 =?us-ascii?Q?ZuC4iz6TqFjW7lnHBcs1a26730uVHZzVWeHlhE9CG7e7HweGAqr//UQSo/6Z?=
 =?us-ascii?Q?R91zWaYo1uESGiRsp3fZAB2iLwxyQHpU8qGW6pnpa4fqn5K7ZSV8JPtn5kFf?=
 =?us-ascii?Q?UOK2k98tVSpkK7kJX976aLg4uOeEd1G0WNTuEc6ejVvmOiO64FW3FR7pDy7L?=
 =?us-ascii?Q?1ZJfKKrxxp1fDfKr4PdWpGvfvVWolQoAUieXqjcLbi+veVaX98Q3pumByZZ1?=
 =?us-ascii?Q?39x5sv91+/zJIDPlVauKeY5OUGQB9azT/L2DWuP95ZRv4RtY4BK7wqBrcty+?=
 =?us-ascii?Q?oH4wQ28FgDTHou0tMoARCtf2ucnJKYkluzf2Os31U95dvP09+ZMEtA4rj+gs?=
 =?us-ascii?Q?sLwk0CchYvlB6+41P0PrCKIlzjLAauuThHpUPK53idueTGVqORP163OelGJL?=
 =?us-ascii?Q?0BSBsHfxCayQqIeCVhWJPALSvmf/IoecPOn1XfgYdTesdqhMz2XDbiCuMYtL?=
 =?us-ascii?Q?jmmgwIFsKw+CT6HFDILYOjH8RTIPqAC8VfURW05Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b00c8c9-0783-49d3-ebd5-08dd719fe123
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 04:36:05.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI4Qh6NJy20eh/iesgYx9zlm/uYqQDqt2pHUCmMDjiUxHAVD/AMf2YncxyiufsdzpjhZazo8KoayMwFcsy+T+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444
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

From: Alice Guo <alice.guo@nxp.com>

U_BOOT_SCMI_PROTO_DRIVER macro is used to add a SCMI protocol driver to
scmi_proto_driver list. scmi_proto_driver_get() function can be used to
match a SCMI protocol id and its driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 16 ++++++++++++++++
 include/scmi_agent-uclass.h               | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index e6e43ae936a..ea79cfa0cf2 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -352,6 +352,22 @@ static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
 	return 0;
 }
 
+static struct driver *scmi_proto_driver_get(unsigned int proto_id)
+{
+	struct scmi_proto_driver *start, *entry;
+	int n_ents;
+
+	start = ll_entry_start(struct scmi_proto_driver, scmi_proto_driver);
+	n_ents = ll_entry_count(struct scmi_proto_driver, scmi_proto_driver);
+
+	for (entry = start; entry != start + n_ents; entry++) {
+		if (entry->match->proto_id == proto_id)
+			return entry->driver;
+	}
+
+	return NULL;
+}
+
 /*
  * SCMI agent devices binds devices of various uclasses depending on
  * the FDT description. scmi_bind_protocol() is a generic bind sequence
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d..842c56858af 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -115,4 +115,19 @@ struct scmi_agent_ops {
 			   struct scmi_msg *msg);
 };
 
+struct scmi_proto_match {
+	unsigned int proto_id;
+};
+
+struct scmi_proto_driver {
+	struct driver *driver;
+	const struct scmi_proto_match *match;
+};
+
+#define U_BOOT_SCMI_PROTO_DRIVER(__name, __match) \
+	ll_entry_declare(struct scmi_proto_driver, __name, scmi_proto_driver) = { \
+		.driver = llsym(struct driver, __name, driver), \
+		.match = __match, \
+	}
+
 #endif /* _SCMI_TRANSPORT_UCLASS_H */
-- 
2.43.0

