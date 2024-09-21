Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A0CCF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C200488703;
	Sat, 21 Sep 2024 05:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dcKs6XUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC34887FA; Sat, 21 Sep 2024 05:44:09 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E2D884DB
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvaVis1j9AOeB3nTvLxtlqHgo+GmwTaLeZeJVXH3RJATqGZlV6BINyCSTboZ9aLZcn6yFO8SkBdxvbhdixwC0Krs0ytQnKfGiRv9hDshpGXx1oP6hzY6/Wvnf8tA4y+yMRzfDpj8oxLbLOedosfcqGodxfpuSTDZlua9Bxu+zmPBuPT9lY93wO7C7N5AcRY5iwU2OizRFyk5hjnYSuI90/JGIDsEqshs5eyQVfljn/TXtOjKIe6IbCjni6NUC/GTy4H2ilS69siHuvXHgBy/JAOT6xj1GGheQYTaPz/FauaZ6xhg80Ebk6O4xF2sj4sdG8wyJWoxv+en/H1ijvvrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=g1VlX2GFr2uyOEepnJTJyC5VLObcrT6zT6lewzmC6QGSAIXcbFfvaGgqLSYcDc6SoxicnmrKXx2cC8lHlYu3oT3P0oz1S1pQYu6uwOYEjov36/6xon8NyJsQ5WfKnI+4PAzZ3KcQsvUV5Fo9K4IUhRvtAk8HDsauU5VsxE2aQAE+mXJm2NLiF5G62/Tyts1UlIwzIklEMB6+z5pAjakCR0h3gKrt3p/x3yHOfPE917/v7WhD+vDcR7zxBQ/rWJ6NNuC70Lr42CTh0xJVsoq51+7G7RJ5vSCCyrWnJSUNFmRMi+hb5jQUcmiZ2ruP1Vt6KluXPK0T2IRnsNXv/yCyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=dcKs6XUv67ZwTsgaLntmvu2nsuyzUNTzCHz2NkU1E7xDwv06N3RUnIAmsF2rVEKLePNctw4cpRQtYGxKZV5wSUtABNZgZBEATJdj2Gbf/ZGqmlZpLqyAiN/cCey3KJ/MQHGejIFeETX5MmgLHbbGmtCcnkwtX75ectemYSwAPU3A9fyxkrai5PCmTwaDr6bWY6i4tSNf664jOANAF0K4aXj+MluYafsXAAgDWWBeTZ+pi0sExn2i3noml4/YRM4BFmH1BgWfY5dYyinO8YdEpu/t2EtxJOCVbpiTLbOylPtAuzow5X8SVhpjbwkHUyC39WQF2DmxUzviEk8ZqcfkMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 01/13] net/tcp: fix TCP options processing
Date: Sat, 21 Sep 2024 06:43:41 +0300
Message-ID: <20240921034353.1298452-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c747d5-4e67-409a-cba6-08dcd9efa2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYhCPJYZEDOq3nQPnWPlPvE8mu638QsTQzH8UlVYUrdHyNmbALi5uL2nQt6e?=
 =?us-ascii?Q?ViCnnJYTYU1fG1cWjx/jIyrKIv020Bw33cul/kYsKDlQR5O2va29F4qmZUJo?=
 =?us-ascii?Q?GceI5SxoTbbZkE8CHbcwOEuxmkCZ8AiLwM8qIFGNRdOftEblSSKWcbN1P39T?=
 =?us-ascii?Q?zpMetANO3cU92l+jxJR2nZsG3PDBupgaNg/9VXXFdnhDPNn1kh8YAvTse6ZK?=
 =?us-ascii?Q?XPdBfnjVmKpCta21qz5YQae+c6XSO7y8kBerW9TvigEVWT0UStWTGNMs47YF?=
 =?us-ascii?Q?4yQ+BD7JKwmiUy6ohT88ZAgH3xC7LQoZpHB1NPhiyo3NT3PPftMMLXGLWr0B?=
 =?us-ascii?Q?ukrtGVIard3z/i3eHU7DfPPFKupRIIhlcVqe+vhPiILpYHP48IXCj7Ov2+Sq?=
 =?us-ascii?Q?LcwBnGeFEBO+ek3yD/7V8ectII5JIKBIGDepvdsgEf6C+C3NEoSIRSmDIQpj?=
 =?us-ascii?Q?JijImcUEdLmTueBEPEUpQGFroVpP9vv/w8l/r3bR4qCo4iMR5071rsdil0KM?=
 =?us-ascii?Q?79yeXJeGKv3595agDDIp8BV/UFIDpZ5OxoQgG2jdKnsn3S7v/Y57nJZgs0tU?=
 =?us-ascii?Q?vGwJTCk+rQ4FRYMmCf8jueYxDY9HeJzthBZPMGyDHm74iYgtcoX/IuNGSOe0?=
 =?us-ascii?Q?UmrQUvGXlRoC2+/6T9Sxr7K+SsANiKkTRftdRW20ZqscXZeuA+uImlfzLgNS?=
 =?us-ascii?Q?Og1U3ls8GbbieCanatrlsVuuOVdrBrY6WuzM2mvIMkWCq0+fjdSeNcYRqLdl?=
 =?us-ascii?Q?0+jDcmaNSThjfU+PLJhay78OMZMCQWTb+7ubwMRRFR+Fcjn4swgKV0vwul/j?=
 =?us-ascii?Q?DnSQxsP/Bm77tTnB2jTBwi1DU1mDD30JOGHzzhhWQrjXXEelykCfpHPz0JaX?=
 =?us-ascii?Q?CKdx+abcWvA9JQfCSGWqam4Y7G/420nWmY/RvAYsK6XtY7I5lFtHyq8QbBRq?=
 =?us-ascii?Q?qjqLoWRelMtUq8FxltUOPITvDVGW4aR1JkdoY0lMv5ryFjKb5wopbDPJR0vn?=
 =?us-ascii?Q?wYL3Lp2asaloueJdT+JysGDKnjWtXjOx60doRCOT5KnD5bOsHHA4MS+hOsD5?=
 =?us-ascii?Q?glv664i9YwOTHyDIFAd2WJynfLOE2/F6CjG7d2mDb37NPeeWR1bZST5CXdV0?=
 =?us-ascii?Q?awvuQgXDpj53GmgVKrCQgQYzCGNnDxvqiDV80/T4jiOymlmY5JqS7ghMSYas?=
 =?us-ascii?Q?2sHhpbJIJm0a5ImEdpch1YKQyWX48P92Dqvb5Ko+VPy1lwmrl8CEgozTvz6E?=
 =?us-ascii?Q?xJEKpAelKbINZ0JcOdL4eadx1bSVtC8uUHP17jXUQgh1SGJbIX/tb2FBP1sV?=
 =?us-ascii?Q?EUX7IwTXjyuVIFJi2jy5m09/l228vROKLuDhIzeu1Rr5b9wEhLPX4iCkpZFm?=
 =?us-ascii?Q?CNghYzE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+98Yzoz0GqMO9ZB0AIuLHpKxbI7ylbjyE/j3uiCrk+RN7ewhP1uB3+bhrB1S?=
 =?us-ascii?Q?kOfS/JXFFybTU8aSeGxKONPDfskBfMIdoT8z2xtDcurQ5yZCMCTQ/JFbUlV4?=
 =?us-ascii?Q?I1U+ylF+Th21Q8wHQO9kz2gIQRQVPABEjyOomGD8dHtil6GWuElgUmFp2O/L?=
 =?us-ascii?Q?rrpDa9z7cXVKojccoYA2ux6lO7UvjXqmnculMo8jtzIEh8fM7d9QxgEGpvlO?=
 =?us-ascii?Q?G1A+P/VrIt8FIInhryrFI3YqWiU2Gs0LtIo93DUv5J9Zl8y7fHySk7VnIwor?=
 =?us-ascii?Q?1FTpnW7VYELZkFvOp6NnXYAOVKNx89651UNFbeP8XomrEkanfNNwefo6MjT/?=
 =?us-ascii?Q?PjmQXyRf50Vl+dsLUnBvgqaCxZi0Pko+IfGOt2IufGLRwjku+Ro718XDosAb?=
 =?us-ascii?Q?3YhT6DWEuMFFgcc4we+SCsiqiC7p5da1IGWpZ/SQpm8y7r3yTg+9O+GP819r?=
 =?us-ascii?Q?2c+kOYhwErGIWWNxa5G7HrZsTuF/usf1rThVx2ckzwUn8MwtDq9VVVX6Drw0?=
 =?us-ascii?Q?XijbgRGWyQUmfg7E9rF2oHZBGf+ZpMs1T28eAZs8Pi69q0mKOPb80xYIual0?=
 =?us-ascii?Q?BYQfuMOuuzWlxEQAsjXzrwTZHSjrm0df61T2VFWs43OnFYtAFejjMZEYk0dX?=
 =?us-ascii?Q?5Y6AoPuF1QLqFVWOERzVQFOeDCW6Bb7OVu0v8xWvSCkCdCvcQHOGAljSSS+u?=
 =?us-ascii?Q?O2B0kS5oO0Miom8TTV0R2Nuhu0YmY//kw33YwiKm/d2HbUmAVyhUHn0Trcnv?=
 =?us-ascii?Q?oeApFm5ypsi5dz2VUo62TKi8MAM3loCi7re1jum0KUAs4+QxCZk2ZuHjkBP+?=
 =?us-ascii?Q?/Pzqksa0I4XRa5xFQtVwj7neK6c6eSIF/OgZBuVyyGrprgiwrkTlBSd4DD9c?=
 =?us-ascii?Q?qehtZIeAGTDTIBMN3UxBQA5AkqjCw4zv6Do/vxtr8fHToGEek52Ia4bqzzsn?=
 =?us-ascii?Q?5neMZ6WYFmFrYCGrVVcnj4CPtzaQghpGuKqExWKqjvFoSgr9o0HKlAV0eJLC?=
 =?us-ascii?Q?BtsbPDQrvdEx2e4ThS+6l71dsISdaRM85Z8Qi2NXYrJrencJsDEKRnwodvKH?=
 =?us-ascii?Q?98Bc/O1vVpLFoL6JpzyX/bZbXZMm5R94ra+knGD33R7Q+RCVE+Vf7wKCLzTq?=
 =?us-ascii?Q?Hr1vAwWN1kGVT917m0Q6W0/QkMNnGct//pKC7V/iRrGbFUGMi7c8KZkxs8dX?=
 =?us-ascii?Q?Kfd7bSOe6sPmusPr/0dP8pJ7XKzjT5TUBWlGEa+oJ+y5alxD8db9u+gsGUPv?=
 =?us-ascii?Q?P41R52lExv4EIxZakxF6j54P9TTlqymoSvMCBnu7xHfzNCTXDoZg6NLvaVch?=
 =?us-ascii?Q?/cIqg3zzqgyJJvWr+TX5hJd7NbxHIgZ1duJn4NQJ3wueMQD0kWa9zoZelIz/?=
 =?us-ascii?Q?67WFo+VBxBZBi7QnnhGIsM8qUW4twinJIpUyKFEtRVAZeCs/01XT7TZKCPpJ?=
 =?us-ascii?Q?XocVrRBy0WSkekumsmjqyWuQ3TsPjxo3FHImwgz39FqF6DGSKgQ09wfCT4dT?=
 =?us-ascii?Q?N/+D3eQGn9FpLFYuolrie4Ti3IpXNbTsT8HR7J/GBfMYHct6udZZ01FLTZyV?=
 =?us-ascii?Q?ePN9aMXDxU7a4uzqBsGSnUjTji2C5BR25zb892UqKflZrP3+URK6XjOayHR5?=
 =?us-ascii?Q?+8Bl8H9sahC9NwmK/KDcb8k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c747d5-4e67-409a-cba6-08dcd9efa2de
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:03.4555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6myVi2t3VgDS0+tWSGhNZAduRDlwckx6LE2e/HNd3uTtsXxVEUfgobypJ6q8LSq9o2u+83BCE4+HnIswvyLx53nRJWM8pbo8VfI9oi9h3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2

