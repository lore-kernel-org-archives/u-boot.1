Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D23C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08B3889BA;
	Wed, 14 Aug 2024 12:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="th/Vd87P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA37B889B4; Wed, 14 Aug 2024 12:32:06 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94616889BD
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEw524krzbsZ+4NAgXeBGfFw0zhCGt3mCMTCeSn0cHeyAloyqOFJHtO+42xkQT2FubEhnTUed9qzsI5qDeF0ahAPzNhA+xw1FvbQ+KbOA4WiwuD8ZSo00lkRrV7xa3gospz5TcsCmXX6ActxIXrgKLn9bfmYJgXCy52mH8r1XzaSHAkGqOwSi8PRZ/0Jw6DoezrVCjFAVCxkwloxRG22wFz6WYGG6c+r0C+sPXs5tLF+oD+z2yVZn8JoLijn0PBUe4uSN/yZd45ti1cUVD0ph6sVeMUHz7Q409mgivvlc/1FFu+F6brxiwKaGZXsYj6yEUCmNR1uWRqUlmCOJ8TBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDh9nmeaVX1B03YZeUmx1GHxUxxjZR20kqyfubesKzA=;
 b=Ef82S9gxIIVvmanjqrMo5PTfK5OAyrpk2L9IMowXxjUPkDSMimXZdXuM2E+s0pksfrB6pUqhM9Fu/g+DRB/Owx00mQg9JPZjTR9+mHsxjKfmYxtAg1N40SADtfKZ+/0y9/2gqckAZl8xNM5a084lD23/ds2oaT9ONdnnwUDdAgfX8llYVtTS2Q25ZwOzASOgGjHugb80mG2V3LizkryhgLroKco5OUgzOWeF9rqOPnAtoIp+Lk1ADyc/wtDPOIJZHJHr0fu09rx71tBf2QOpAJqK3KaDNZGkxLbureEMA0OKo3/CWvI7O7JzVATY9L9x+GusjEekjEnfgrPVj2Fshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDh9nmeaVX1B03YZeUmx1GHxUxxjZR20kqyfubesKzA=;
 b=th/Vd87PJO3FYN6jwb2h4nIdjPwbYjSdger4ENPwhCSIdEyjPuKlzwN6yMRiGh62L7sBIS5YUT9XBoFCqg5CCinkWn4nHFSMYl7CBX5mMe8cUCSEyx7/++JPQ8YEWinq151kIy8KyduCFtWWGGIuhpdwwLXjpbTsL3RUFwrZ1eBYKEDcUIJK0YHAlOC72JGNQouC0SIRjRAzi9uzXJisCjhNn2h3rJ/tFN68RlBvpdbpVYC7hUz1/WedV9GcSpk1liBPlVuuTNx9N93qI8s/W7gBg8gGT0kupRVgSj/BNbAwc4BPU9kVDhfz5ef8UkLW1QKniYe+4ksadRMb6L0c9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB8887.eurprd08.prod.outlook.com (2603:10a6:102:33b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Wed, 14 Aug
 2024 10:32:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:32:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v3 1/9] net/tcp: fix TCP options processing
Date: Wed, 14 Aug 2024 14:31:37 +0400
Message-Id: <20240814103145.1347645-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 45212e11-63e2-4d02-82e1-08dcbc4c54f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: Nk5EpYAKWz4MIuPW6bT/Ki1BAFKeKemBeZjt3upTaHYANA7nz7t9OBKfh+UV7z1zr+toaIVXJFqLFOQtx3+6rhnMuGHX000rgX/wUHOMXLOlLasLH1vZ2zYqu8lBKIGwSwyQEP/JorPXvrvY6I0gnQHqpLnXlfUK1PCXMn18Kjmh6IWgu2HtQl3jH3tHS+2QC6UYR+zpYmZsDoanAJSLFB94IccTOu/d1ddkufGF9LxgivX3utlgjwq3lccH1PmDrWa68QHgYBjYd0DX03Ba9z9+To2EsmPzIaE1AlDY7hC0MXIe1HwpOodvdMOrPBhSMMswFFMg1S8AJHwxFVQIIL5HIaOZul18KIEYA+fwZ/fk9lnhqAcpPpsLFPDs2sZFBSzsaKH/8Ph79lvYsuDPXUF4HcT/JQAEO410NNRT8KVb/W3GaVvJA9orvfxDzE1bqg0w8vOB8OreskyXLF1mwbf4+yrwWfHcnqy4Iqk3QWvF3yvDUIMChN4R52dZtZBsLg76UCzuvCtTTRqo1mgPft1Qkg0GDOQWOzwIDMs9MDfAUXJ8A8RS7K8iGk1z+AfSZZULMy6NBp+8WAL8LSt4X5Wr4BeA6AQWBbiE/dxGjqD5aUrjs2lIVJZyylSWYEIikzXg/MKk7jMCICaqoALFXm4ZnR0BacmofdK8lBYIe+qHzTGNOAuYucu6uIEiSj03kNw00MOgGJ3cx4qeEeC+7aJHRKF224HfM3pKwY4G5A8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SzM9Ao1qA+iBD8WG52yaQRlbwiqC1kdymPUgzIYoWfmIjMKtBJ5b1S82GVAp?=
 =?us-ascii?Q?JrT++QirwL1gEYbIlpAvI1HMamFUOKykwWhLYJkfqR5ldQX3mZJJi+klXBgQ?=
 =?us-ascii?Q?UZSevuILuI7x2IS4dPluf/3U1YZiAc5tr4nTYhzo/IcKzfVvpi8ah/mi8STu?=
 =?us-ascii?Q?GPYDOoAsVH+ttFIxPLamxvICLvwdoqS3L9d8HCKwPTn4LZNRHosjIVM8ACRW?=
 =?us-ascii?Q?xlVQ0qveQEOBcKmRaq0RoUKtCxt/JUSOnJj3D8k6hdGrJsHkLLHy+8xcfkWk?=
 =?us-ascii?Q?T2EkxahWCY/wPtcQLV7GsXH/y8Tcp9Cf9XUhoTQyHCHxek9f4pMcey/azESx?=
 =?us-ascii?Q?KaD3wRz3HTkAUpOBwYYcVvxE00b6SkGxQS/hOLLUlzpezBRt2YONq3TMeiaf?=
 =?us-ascii?Q?U5yMh/zIjNnf6ZFzQworMgl50x5Zv1MTySI+TuFroqj7u6mPffoY5n8bPy1T?=
 =?us-ascii?Q?h4MPTKYL8TtY3jVrM+OpDCjEP0FFrSPQy4lhoCVqOpdnTDtkYt4AvMBc11y7?=
 =?us-ascii?Q?DKGhdvZ0cim6kxEERPLa7dvDOYXRbnvC04UCzXis1U2uxi5xDdlMO+4tvhvA?=
 =?us-ascii?Q?4crsFBcDX8iTReCPSu6GIa/aycy7GaEn2Rt/Ay96jfddstavCr1n7QGvydWN?=
 =?us-ascii?Q?BMVsd2ibDZhuApaz6JjvZkA3E7Nbsi2h2PcSKQ3GGfKsbYJGuauiQIBO3tej?=
 =?us-ascii?Q?DXwLy+5bZ3ja9buKqpF4gEZR3P6pOlQi4soQzXZK7kZhGNO4xI/sn16dMMC+?=
 =?us-ascii?Q?v11sPzoQwHb0uHO0/A0T89wvA6M5ZaVrrwqCHpVCyfkE+THhuwQ5M2zacDlR?=
 =?us-ascii?Q?E3yqggLfqGdwuTuybrOtI1W7ZLiPeXA1jnrSTP80ga3dYcBf48zrWSUdHxCk?=
 =?us-ascii?Q?cmsF7TkljS1YQVB8YTZekSzgSjKZScOTx8q5PG2dAfL9U8HC4xC+plXOR+9V?=
 =?us-ascii?Q?bYj0QWeamxbW1nvTW0LlPRaS3XQXbqmjHH6o0ueQqRz8SGXFYFIprMy0Ah7f?=
 =?us-ascii?Q?sls1GozL+JwBdZefBTK3BkD1yUOC2tteowAgSv4cDVI2icIBIJMM5P3O6szA?=
 =?us-ascii?Q?E2jdih2dJi2Nv+QKxocHru+FunciGkZFP89vGJdQnJF1VaFmC3c5tjTrrpVU?=
 =?us-ascii?Q?7ZJzZ8KW6E4dgcCTM+5Wuqfum40c/WpeInXzXYkTRNnbEnfo/Ybh0ubh8YTM?=
 =?us-ascii?Q?nZV/sxQz5qo3vvkopk+QyZ90PeLCuVij+7N+wi0St+Fn+9Lc0+McQ/3Fmbdp?=
 =?us-ascii?Q?TOk8gOwACqZWh+2fCVO+ZXZvh7PbHFxRTtlKSmGi1u2go3bcCciJXJfC7lYz?=
 =?us-ascii?Q?G+0OPwJAbBfJXnDtcwwEsXlYA8t5hdoIs8OoZTdvqSMyI9pvFDtywI6bo4Ou?=
 =?us-ascii?Q?NN5r/XZl7MSpumrWmt6JJCLDRKtnoyRRXT6cu/Y7zsAktXcCnT3oi/tRQTIZ?=
 =?us-ascii?Q?EJ/RuI3zBx3lLVucgdscDIN+ONBdSFjCgG1i1nuTpSRVwTKnTmMSKCFGJvTJ?=
 =?us-ascii?Q?gMlQHneo6I1QWBPnVIa/IFD0wuIJ6MI0NXHo2WWTJoIgZE7s1datZ+igiBlP?=
 =?us-ascii?Q?BmZ24gNmSB+MAIlKECpVN1OQgMnKjLIUP12vGJaPbZtXOLMwQHEMf0+YUcmO?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 45212e11-63e2-4d02-82e1-08dcbc4c54f4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:32:01.0548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWzJt1lp3NlP2wVjkf/wZDIYoR1ygm4XTxZFY4MavtnXIwEpTg8ZcHTpmedA4AQ4uMnuuVOAD7Lf4scHJVHMndmoB1ps6uyQksz1v3p+Jio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8887
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
2.39.2

