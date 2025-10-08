Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7ACCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C9D83981;
	Wed,  8 Oct 2025 09:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3eseER39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6861E83A5D; Wed,  8 Oct 2025 09:32:03 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF8283956
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2zLuyMIgkedgQjkplFq4OxmYtyiCuQRO6UzjJ2OqGRBZERN/vhWFbHRk66NO5tmTk2AKogQWTIMu/Ta/eRKYdgcpah8q7Ru378Bz9eEgoEQ7IP3SNjXGMU8Vc9bVC01rOQj2FzgJNDNqyIRJxLg3G2u1rpMfaMW6/sQo9ZynrQVUK6XDYuttjEHvZ67kwdZxuMJl5hgkEiYLoyyXMRZ7rph3dSGnrSLzOqelHnv4w7NV4RwPIiZKUz0DhcFDksAFA08os+KXoijiI/o0cpcCpktzo2Rm9dhKEfDAp6hPodbuptOHg+bPunu7F4Z3d19UG3n9GFYpoQnUYMibRXnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDJVfY8TkU73HmCyVTViX5KAlTS1UBa18s+G8WEumiY=;
 b=yb5qbpUPr4FUWQycmB6WCb8Xh8Eyh5eOByAGpZoqhOZraEdFkYD3nFfvDJIbFK3DEuCB9UdiNoxPuIWjur7mM/8O29Of3TVKBgP3+fQyk6zTh4CTW0/Nw6F4F+w71epoQDYLr56qJJAuJS1TNFR02LTvFYMPH6xWIu0Dow+qhXyUzt/stncM/f/bmS9pwF5NFRI6gQeMfaizXBuBv67fvaWTG3PpjWgxnCYZRU08ujVgG8E23hIzpwTl6lYpLLU73OOKwxJuhw1nRWd4UZ7eH7uNEWvSwVpCy8joLfXV8qSyIIaPTk7q+36dlr0jTqXXPl6DwJvbmQ1XnZEnd3t2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDJVfY8TkU73HmCyVTViX5KAlTS1UBa18s+G8WEumiY=;
 b=3eseER39v6DTVKEwSw84eGVOcuUq+7+G3eYmN61YqsOAwwUQAtsBvBL1Ze31fUofo3TygQi68JzETOldKKORoLulSFk/qdw1qeJt/TIAUdNNGKmAa+FGRxjruraM5SWD3aQccdRd8b8xaTVDg5rGUbZa9dTP2burBi0jzXzRsfCR+N0FyNn0udfislVRb251J7zT1LmZGJ//VGdfaZQRG6cPfqEsxbyFUH6A0EInXE4MsjRyXcM4Yzrtg6z6UgrEfTTJv0hHmzrhjyRoYXvtQXI7rznhIznQmPncQmLoS+l1Kx/r1BttJCLYtftjs03XzB86qaaZY6FjV+7WhuS0/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6579.eurprd08.prod.outlook.com (2603:10a6:20b:356::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:31:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:31:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 0/2] net: airoha: improvements
Date: Wed,  8 Oct 2025 10:31:37 +0300
Message-ID: <20251008073139.373796-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f15530c-c8d7-4c4f-1585-08de063cc0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/rULrbxgOV/TRByQuxvfzdQuWnfqqCMGHunp/w4zQcYO2T4ZkLj0V85Keh1p?=
 =?us-ascii?Q?fPMLl4faFIFkQBkAuR6+GgMy2CwHbRXpdD5dPT5N06Zt/fh4S5dNuJTMXYCZ?=
 =?us-ascii?Q?578Zgbpd7KFpqR7a+aE+g0k+LrxAfOcxdEt2VV7eGzy5UJi5fQ21ORjFfvFs?=
 =?us-ascii?Q?qzYTrSL8CFFgm2h44J7YDCrrj3LLqeiI2w5Rf+d+XJSeY9fkFMVt5yPT8kRp?=
 =?us-ascii?Q?3aeU+d04DV5ayxce7OfsMl8cKht5bzeAul1xMZ62eDw/58k9vj2omP+r5pKu?=
 =?us-ascii?Q?XuaE7l0QnmbLDijNJYKwdco57epcqjeZJIQ31e2aVOWo+pEp45fkrDg3r7gV?=
 =?us-ascii?Q?Lpy4vPZP5eVwOFfrIpsUVFd1vAFGvXoRSOmQnssuwYKjSw86pXswbn1UZV3q?=
 =?us-ascii?Q?a0hVPJxgQ/heM7YQmnqDGZrw27ZxW4LTgfuxV01h2LVEL79Cm9+tyVp0bDQU?=
 =?us-ascii?Q?uLw6Dat5+lyIL9iVAvP8V0O97yGj7zN4hqIsaZ1p0/k0vEC7P3qPnU5dO2+D?=
 =?us-ascii?Q?aEMYE36ujSo7y1dEwHgwPc+Cnbj57UPxU2O2MMufb9pZddmgWzgMKqF/iZJI?=
 =?us-ascii?Q?Rq/XyWg1xviipgTOthWFzrATNJsPO+bj7oEwnt5VL2y8dSRp77YsxzvHb59v?=
 =?us-ascii?Q?/M1U1DsfO5VzR5IChYDzZDPnZfBcBVgMQ0Qvu0mCKCUK7EKWop2AmbRrT5F5?=
 =?us-ascii?Q?zVJK5uqcuOUn0mTMjEb/CVjszEqLgIyVTroymW4Qn2CEUcwXtIW72q1xDWz/?=
 =?us-ascii?Q?BH3chhY/NrXm6q6K4SGYaDzx5y198Pq5kdOdldDuX7ZeMEWVvZO0GCuaABOZ?=
 =?us-ascii?Q?KvQKp7oo+YJbw7V1CTYbvPnQOeba6i3N+j9PzjaPzyxWWnaGNyYrlxrn+Jze?=
 =?us-ascii?Q?SVQC02Dx4oaD64mFCwLwSv4ElMoZgITUfu+2f6dTL32gVRRzWH2u/h40cqoU?=
 =?us-ascii?Q?8oQawu5cne2SWQOpz9rUTjqpEBO5YiNqLgKKoJc5CPtaOvB4JOStP+GQI8zo?=
 =?us-ascii?Q?49tX7EpaAaGAy+CHgLnL/4UlNZ5Ltyc/I3CFSfaZPRNEMnqMbC5UgeucAizz?=
 =?us-ascii?Q?WmL1dtbL9Oxc8qeiImCoeZBm3rMnk+hljdg749Nq1y9agGiabTB8MMhA/vJ1?=
 =?us-ascii?Q?0WV4j8D0LGMM8b9GrR/nWds0cj+f1gVk0tiI5feqX4vLW3EYzWR/zFFA4c39?=
 =?us-ascii?Q?I3/Pxl6BcmG+8aPI7WFIAy+FZHqksbvpTWm7Px1smMfvg6/6gRRTON9dcgBF?=
 =?us-ascii?Q?D0iIwC4acF5bim2BLqEG6cuaVExzIE19KeefMOqLjpmHXsU4kS/oUIl2Iow3?=
 =?us-ascii?Q?dJdSil/Q627FBHqf1W85Z1FyEjKyXjY2ww8eHkfp+rL2LAIpXh1JYLdbsHqb?=
 =?us-ascii?Q?63hTZyxWvhqQabLdSiUjreAUJ4lDum4SsRDpJsON7FnzhC6k/DGq+hbZgZpr?=
 =?us-ascii?Q?pCsoKNFWb9Yn+GqhtbCN4GL96V879h9pBzx9L9sjFB54DXrq6NENRqtQve6N?=
 =?us-ascii?Q?gCYIvl9lczFTXmBAjxd7df9txi518l/kLDpR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQZVEq3mDKM93fZDeo2+M1lX1kI9KjlOOs6CJPWL2f/dNqQIHFFc49jjJ0br?=
 =?us-ascii?Q?1bslIM4rjPMO6S6E/UGTRxJO8ZVGwjWG4NyANRh6+P2+VlYc+m4V3c5kq6i0?=
 =?us-ascii?Q?7w0QIPaLMnY+K/eGs8OFHUxCg/qopTiyg4sl19zpfAIXVJ7NIFTnZjUQhQxt?=
 =?us-ascii?Q?1aj6j20fv2qKOVclreSkznut32RcVRCse5DoS40GD92UtPX3aKucjS8yyRDW?=
 =?us-ascii?Q?6QRqh3EldMQ3HZxaquSqVHvLIPI4zs5jVVpeS86SwGjS2D1oyRAALmxDP0so?=
 =?us-ascii?Q?lAyVKfYjr724yz6yldyb+kJBK57OvJ845LIwVh/xVF0tckZT1A9Kgt2iwLDw?=
 =?us-ascii?Q?W6UbGV0WWB6IjeyP/PFaxvN12T1CwLF+jRTatWE6DvOFG568PGmRLq7yrZZa?=
 =?us-ascii?Q?SkzaMqkUFs+X/qCrYWoZVaAIjwdtkx67B8UtksKdhnUO0/+PJpf3onCROGYi?=
 =?us-ascii?Q?vQ9fEnCj+4xloi6V85CoCrdq/fl40Y5WBZHsBHzXl5Z1Qx/elH6c7SuPk4B+?=
 =?us-ascii?Q?FBzfDSt8A8FpjJEyeLBRqmcrAmdrZIdDwCDXlOGEDRXup0dugOXU9BygxmSK?=
 =?us-ascii?Q?LdUC4Rkh1GpOSAfxDqp6kmpo9fwS/zACXfuEndpsReUSmAnKvJrZlqDZowUL?=
 =?us-ascii?Q?zbabYvARhe0/sxFbYBLqL0Ze34hy++lXwHwpIarGMmPhsU3q0m+0ylLZHhUK?=
 =?us-ascii?Q?tlkwSzRI8l8H4g1LbDT0W7+INzZLn/Ho33UqoYMzaWIxJksl8bb6Xaqlo4N3?=
 =?us-ascii?Q?sXP9v1tb3ZXw7DuBUn973KYNBMkPdNMnPqrExH9P7DGLE9Ape5eh92/ihtoe?=
 =?us-ascii?Q?OfsircxfB0CfP307fV0U34K07e8f4Ua4tCIGF3DVWakFgu6fJMEWAKFS+M95?=
 =?us-ascii?Q?9zBDDe+ps+bbvjBluG4n+/U/gASl9mniYMV/fIaypuPp9ClpTVJ0osJJgBnl?=
 =?us-ascii?Q?8x0ggcNAOkYj4ZqigbHLjrByN5DFjPdah2LNt0UnwWN+V1NQ0dkypskn2LIy?=
 =?us-ascii?Q?nqE7gMzM5BCuw8mtc9J1NGN3W6X83tnDOZBIp0RWdix/1JDwWZWde0OLjJFW?=
 =?us-ascii?Q?3wnCx8zcSgUpMS6WkYHxgNR1P1VSYwsx7Wpwh5oSnax968lPpTGfxjFgxv0p?=
 =?us-ascii?Q?G9D3HwkE7rDkMLPwIZnArGCryISRhlz2zO0xsoEaOGqB2yr/11yVDwafTTt5?=
 =?us-ascii?Q?vbl0k0YaouppeWg0XCQEntJ5q1ZORw12myttUKUQ0bnhsjJeezpcdlHeegna?=
 =?us-ascii?Q?lrPOGufWCfyuLowqmnMiQALBP1uyHFuPZ9e4iO2u1D70uTTVn0FSVWfi8dJQ?=
 =?us-ascii?Q?5sy2fpTYwTUCxf+iSl4HJj23j39iJGZBF4/SKsIizPyQcglUMLgGWbU+Sq0D?=
 =?us-ascii?Q?FjUNKhRlNzv+3ze3wHrLiJ7oj4cJMWT5L5wKNKjBjNui03YwnnewrBfSoaVJ?=
 =?us-ascii?Q?ZNhltLECQO55Q/7V1ibQvytIJzAPriSgmVEIPq02HAUOu0DX7h+oY6C+21Tv?=
 =?us-ascii?Q?eF2gNrBzf7VGqR6nmQ9VPzj7GLMg+cdPV1B6xFNRB9aI27mqyDQjkTVtOIRj?=
 =?us-ascii?Q?YTNrIv6HXNQnM1CkEtmq/w3l48OBPIuPBsoSfHIawLy1uW47t4sL0/810NLV?=
 =?us-ascii?Q?OdiOeU/mTRe1xb4eW9WArVA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f15530c-c8d7-4c4f-1585-08de063cc0f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:31:54.1179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZaEZtJ6FA8tlncslDzgVXnMY7qblHzkR2LRdYRObTBO5NLlDJZUBV6o6msvfCNaeMSqMK8I4R9DagpiWT3ERjXvYIA5UXP1RdnKPRcqptk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6579
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

This patch series:
* improve logic of rx packets freeing
* increase the number of rx network buffers to make ping stable

Changes v2:
 * added patch to increase number of rx network buffers

Mikhail Kshevetskiy (2):
  net: airoha: simplify rx/free packet logic a bit
  net: airoha: increase the number of rx network buffers

 configs/an7581_evb_defconfig |  1 +
 drivers/net/airoha_eth.c     | 40 +++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 19 deletions(-)

-- 
2.51.0

