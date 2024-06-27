Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE87C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4407287FA1;
	Thu, 27 Jun 2024 13:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BaeUOx1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D744E88511; Thu, 27 Jun 2024 13:14:48 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADF387A9C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpw6FNVUFnGYInVEzO2V2hRmqW/7y//fqNumnz6sPjrIGm6A98g9bL65ttch6oGgLZjru1iu2VsoDIW5fdWpUzjQlunZJ20CM5krPMyvqC49pKdP5TrdDgOyUmszr54yBnGAIvMLnqRQD4vkOd0fU0rYtZAtnEkqJm+LgG6ECFd7Kd8E1UlJQP8roUJgtn4jjrh3b+BqnzM2CgG0G0QgwlcZ3dgFlqkIwvd0xRtvvc60nJSwa10gUVpKQ3hkL4gWF/VonEuqJ0RI/T2EBJ/Y5sqyB7T3spNVIqN7ig1RypAcb11iyAPna6n32O1iZn+xJ9yrux74re9CclNgM/E9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIU6n2V7JTLySLkX8jVrAvvgLXChUCYNpOP3Y5kgX1s=;
 b=b8iq5kdjhFGJLZmChVsjk7S+ACXJPswef2Kqxr1ZhDbO+6Y7FwOPKFga2kml2vTzJtiZv+eNukvm/10KzDZFN4nlG5PaJGSGf8CKsC7mB9m5ropPJZFd7lcTWjZMniQ7IZwiymZHnESyYfKlg8iBeB5voqPBOkDJDfXi6XA6Hs22mtIi20vD29xrHJc5wt9oY2ZRFvLfqIkh8zZ52c/fHOPxEV+s5WzkfCnI9+jFIpheYYw9ki1beIpO2i9QG3SR0Ueyq2Ulo0jacvXbk88wuloaDvWvPL0MP2q2Ay19cuWzRdWms3KzsrrcNnwCSKM8cUTHtS4x0EH89T5opetpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIU6n2V7JTLySLkX8jVrAvvgLXChUCYNpOP3Y5kgX1s=;
 b=BaeUOx1KWFyAdyXtVfubmwTd5NXHiHme5j8z+CWlWtujx/DbW8pIPVQ9fyHYXjDWFJKSh+LywxHedm8Iz8MUnfoD2vXOD/EkLZOE76px4NeRz5rPwebRNpnxflAKOkaAMCJcL2FriWMy5l+XWDrvI3xdln/0mI2XfTNxfXQuP3XqA+YMvwEtZiCcWK8Oonekgu42DxGGSqGU90gcXdPja5wwMV2HF2jPMty6rDA7L5u+AK8+tE+fY6BX9uGsqCQR5vKi/nnkuK/t8U0T8teCawaT5XNPCOKtchvIVXZ0S3kuXHq0E3/iNbzPwK9BPYgKnR8rR/XSx0TZUcjczwt7vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB10284.eurprd08.prod.outlook.com (2603:10a6:102:369::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:14:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:14:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 01/79] net/tftp: make tftpput working with servers that do not
 use OACK
Date: Thu, 27 Jun 2024 14:14:37 +0300
Message-ID: <20240627111437.98987-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0093.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB10284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fde52b6-4c6f-4c8e-9658-08dc969a592c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oIZlGURMd2ueDnU0Llt7jlcnJVNOjPXURs8Yh7l4ISENSmSOzyx48j3YgmWu?=
 =?us-ascii?Q?svKkT5VHldgLkuEaWGGWfy/2OM1rqdhZPWMKQzvb/q5XblNQqsNKk876DI1R?=
 =?us-ascii?Q?OXNJPpMZmT34bz38Owr1FCEP0FGNVVyuMM02Sztx5aP5yfro/vK3eSRg/tHb?=
 =?us-ascii?Q?FDB2RhDDGWcJI7ZCYWjmsc74UeLUf8IObbXsxlzHlgJi71OpXx02SVwR6nCO?=
 =?us-ascii?Q?Bzl46yDEstO/R8Y3y+IoKbXEZ2PFnPl7XPYXvZk6I/PeLoUZvY3KGU4mI4g8?=
 =?us-ascii?Q?UF0y1ufCa5xDSvzdhpfnfEN8ytV7ZHFhpVIfd/1JLNeLvefWVlF3BqMsBxAm?=
 =?us-ascii?Q?uAkCosAnbNYppKNyVAGUPIxATTSU7d8GmCmL8+xxXRPnHW2JnxpZ/RBLNkKn?=
 =?us-ascii?Q?a5XKQvDad24F7CPIwVlCCGLyYerFabr5dhzcB5kmJWKzqBGlghod7KdwKoL7?=
 =?us-ascii?Q?iBSsoo9gpSWChMamoti3vYv6Ukf3BzBoUQZ2KeZXVGeRRBRosNqCE1Aw4ill?=
 =?us-ascii?Q?4W0DzGTBMW998HsZf9gf8wx20ApI5AYuLzayMAPUYA7iTslcyyNyrHqfQEKl?=
 =?us-ascii?Q?J70Y/Y36GgkRH3IQPH910nYND6+vSM+/FMfu4Fc8rI2p2QFX40dcFiLKGbi3?=
 =?us-ascii?Q?Ir5sZLgXZEdFjhMF+mlsxPDHUalTgqgitorWmI3/lCfyrHydMV5AFTMVavot?=
 =?us-ascii?Q?3pDuKc+4Z5z9jRY+QWHUMtCyndUfLmg0zOWLhhfrnwmEFYAiYupcGx/cpm4n?=
 =?us-ascii?Q?FAetx5Ag9dzJxkLQTlSlbVAcHQbTRocb1o+aVtOBNy4Pmigb5fpnYKRZPumo?=
 =?us-ascii?Q?0MbjVzqSovaW2S9vWm71N8ddljvKna0eWfEYCHEqcbWPViUqt9VZ8OBE+yy+?=
 =?us-ascii?Q?Os/5fdA+6MHVOgS2JjmLQLF4M8OtUYFQAtJGEpjmPYpRVrYf7s0WKwgFCRWX?=
 =?us-ascii?Q?w71l0JFI5D9G8f89gBFv+pnI3x6JrAbLf6RXGpEd79Ci8hEXsL2itpsiz3FU?=
 =?us-ascii?Q?yiM5dO1O/oA3vKcnmOOVwSZ+KCuiqjlsNmg1kA0zyrLTDT6+/PjzwaEjfAKV?=
 =?us-ascii?Q?20HmojWUbh1Sr+UJs8938u/1L3FWorlDdwoiJlGKrEvwhI+ScC8wFlOZGnwR?=
 =?us-ascii?Q?88/L7Opi11dOMnaMw32XUWrXsZCy+vrsRQ0vWZZYEozP9qTO7YkU8iNebP+g?=
 =?us-ascii?Q?5LKt1pQR/Z0FAWkmbT+ezndIOaHOB7saC0mXeFKg90ccoobkbE335Db0kGpZ?=
 =?us-ascii?Q?zm4sexiFoTpWcTbfA3OMwHWz/Plow+O+Uvxf/iQwh6u1Osisg4WEsukR8Qa9?=
 =?us-ascii?Q?dL+EMmkIJwK3bD8IwWhxFITpftOeDSP4lWrd77ncIoQ5RJffstXGzBa9xFCA?=
 =?us-ascii?Q?VSYS+WuBC0w2gc3eP22ix2KnFO9b/rSvySsteD8g3JMnAFQ2Qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgFmNM7RsjQgjAoQuMKIbSs9xszcOWvi1lwBPgqNd4GgRac9b+03vIJyl7LN?=
 =?us-ascii?Q?a2aJeQQ4YIVB+8RfFmDHfeGV6gaDxBTimID9dna4CWEpDB4wM3sj0i+8hJcg?=
 =?us-ascii?Q?E+XBNm+z6/EOGCaiLtuTPc1YPtKtKUjmbFjiW1EA2QrHfLLpzsm8dulsVret?=
 =?us-ascii?Q?Tr/7BOC4YRw5BUqPruu6/H4VZuQ07B1wAn3neTb7S/WWowy0J12Hw3NQUwfa?=
 =?us-ascii?Q?QlhFF0SnRO+eoU6eoHztERPa66NsyrqhUvVl2W5bv8lJKi1xexhqNznfiQgh?=
 =?us-ascii?Q?p8iJFErBaf8y3m4GTaL9ILDqY+ra/nAefEAdB4c9+U11Wmbt1P96JZ1WcFuy?=
 =?us-ascii?Q?LHNUfZ1bFVReiJJ0hj2EzkM8PJ0HcAcYYSqJcVAIXJlraIUipevVeOubek6H?=
 =?us-ascii?Q?U7K3Qw6NZi6fKn21RCmgYg0BmqI9XsSMc7Yc57aEWIowBpLo569nmRBSP3pv?=
 =?us-ascii?Q?oS6CeRrVLc9Y6EhmwcCBvmqc0L++E1ViR1HuC43ulcY5Dg4or/OeuNgbKI4j?=
 =?us-ascii?Q?eP7wxTqyZL9ktpbTw8Brm6PUwwYgo4aP4ua7L8dNsqGUfExNXodfUXsCnSC+?=
 =?us-ascii?Q?7hirkaxfSBc2rd8rAR7yXR7Gby5RiaIJ1WZvH6RZOMizVeDiG0FgI4fbaqyX?=
 =?us-ascii?Q?om1lOnQOPDFKn8aAsENuoD8IcW7YX3d1x+AL3T8MxGA74x62cptjqYB1H6rf?=
 =?us-ascii?Q?q9jCsFc5KkBq1FhgYOyU7lBI9htuBBanu8YFx/1DCpJhALjLQRA/DAXTGpoM?=
 =?us-ascii?Q?U1AeHdPleCNDhFExbJRuxkmdbShvnd0YeXhCHHf2AWsGzygNW8TEbsBN5qDh?=
 =?us-ascii?Q?7NeAb+n9cDErJsGb+zcFvVpqqyeFvXkiJqNFAdYH3WOr7qbkQVu6tdvXtYhx?=
 =?us-ascii?Q?e0EhdZoiTb1RAxV55vKwjlhycHssOPUP7JITdWSdOhUC4K0uSL2ZZ1xZQ2Fg?=
 =?us-ascii?Q?jjOLkFdVsTWMOyYc1zAOavoDS0VViBxSm3gCR3Qh9bPFGso5nzon38e8VDTn?=
 =?us-ascii?Q?BZQdqBGo/DFGFRJmIjEY6TZEavfwHn2wQi1tKc7znW2JyujD6Dm1hOqUL44y?=
 =?us-ascii?Q?GvndRK1SG+262I1Thg1r8JOTG8GcAREXDVdiqWQ8LDKlPsX7Hho9ag5PESMu?=
 =?us-ascii?Q?5sXfYa6qCiHWpxt32L0omHRxwOWDhBSShOKDgRJUV1/WgOqa7U+BxhM6guza?=
 =?us-ascii?Q?poiRZnzh/wlZUvLy2n1ZXOjb8TV48M+Vj0FAUE/wJ+V1ZtyJCuIztjnW+Ie2?=
 =?us-ascii?Q?s2DmAYOh5ozWp9R0eJzoNrtAAri1Q4fFBJTQA+4XzYchNZ7N4ZNCdr3MXath?=
 =?us-ascii?Q?NteDhqd+/MRs8ubMUk2AZgDYIUAL/O4vamELJXpLJde8ANGwLbqNuNlIqFRv?=
 =?us-ascii?Q?jIoimP32OrpCB4nTkyRVfuFQcwDnNgNh756YjYiuAa1EIt4Z8P3/brkoFDiL?=
 =?us-ascii?Q?QJdmTqeGh4jCWvd6CetvBOHFsHzheCTstCRiMIIvS3HKD8NhF3NUhRpUfNk+?=
 =?us-ascii?Q?WdYgMntwNrcJtiNBu4fNgaJdYpWz23/DnIlLIEvrMqTkmfi8QeD4YuMZQ+uv?=
 =?us-ascii?Q?GXRHWMhGaIYrg0ZbjtEbPjIzKGxgrx4lwFAXeWAROqZkvzKi9ailHMCS9SGu?=
 =?us-ascii?Q?cj5cG8jk75iBw/rzITwR8PY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fde52b6-4c6f-4c8e-9658-08dc969a592c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:14:44.6578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRDHRiAg1TPVT0FsV/9DGSHOOifXYxvvZH0hTLw/HOXZH0NTF7UgbrtUdpafPfIWXP/6E7O5DO0jiK9ARZaBbPgdb56NEXr6lcObfkiWltI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10284
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tftp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/tftp.c b/net/tftp.c
index 2e335413492..2534dec1c9f 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -494,8 +494,15 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				tftp_prev_block = tftp_cur_block;
 				tftp_cur_block = (unsigned short)(block + 1);
 				update_block_number();
-				if (ack_ok)
+				if (ack_ok) {
+					if (block == 0 &&
+					    tftp_state == STATE_SEND_WRQ){
+						/* connection's first ACK */
+						tftp_state = STATE_DATA;
+						tftp_remote_port = src;
+					}
 					tftp_send(); /* Send next data block */
+				}
 			}
 		}
 #endif
-- 
2.43.0

