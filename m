Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23574D3398C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097AA89099;
	Mon, 28 Oct 2024 15:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="k+4gXo0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC9189121; Mon, 28 Oct 2024 15:32:14 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F3B890BF
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1xMbdu48EnDJ0N1O6qQkRJmETvXh7cefi4rki9fG6JmwHM4Ixn34vf0EK54d7Z17dw+wqKGhacFBujG9O07uOjyWPONV7aoLSaK60M6/iX55gyJiaQ0hPBVSGJ2HU6oGOjSiFROg6mcqRyyqDP5KKs8kx+uGKom+DyFZKbeTh08N/ni7tnKgLtGZQaE/azAIxEjnljib0g/7o/Y9jlLZ7IMXeRnOD2qfc4/g8XmtUeA52p0sFvW3vpp4UWyASVo7spkPlzl/Z2hBh4ruRumvtuFPGEUcvJHi20GlNJPF2/M3B2EXXirqJfGX75mHH5sOJtxxBPE2NP1gdQv3LLZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0QxNhYk007BUN0+KDemFnhIlSOWA/3ecO7E0C8dIFA=;
 b=hmVgTnX1PERcgJxR0MqZDDk1jLpPOm3iaHaVuy9atLFxfamFvO5dcUXEXMMEE+eG2WlrTvr9ffjhJSzICJUa8ZYDR7SWg1NKOc77cDSfrOMBA3rU4zZkx+qLnjZpfa33KWev7bTzWATTEk94QvEsLi0HkiX59ISH3/wBg0m2hgoXpAeP78eIRFGdwv6hylZiFfTztF+WnH8FmC/NfPPvI2ZSO8EkJzy/EVoqUKDzkvKUgbXbc74E6mewX1vQJ15b/g38w1l5Y3NsCFVPmvDvjS/fKhlC5Q1GQT1PlqtEFpwXTyRP4clvUWqglGLNvMAiH2o5AoTjq9LC69bzOpQ2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0QxNhYk007BUN0+KDemFnhIlSOWA/3ecO7E0C8dIFA=;
 b=k+4gXo0xAtq1TazdiR6Vqc9/zBd9ZRmdDVHsLsglcViZUZtfeyH58oHr0Xv6ceufTAcwF0purK8X2aESu/f4Ck+naBIDS4d1iONJzHurT53L2N7XKjChp6YvF6u62H9B9BKnKf/XXG6iVxQC7BCZmOjOqO0Z4t/czp7lDC5IunZX0F0RaslN3pLOXfy8QbJ1Q3X26BSF/Eao/TnQcSQHOtfUaYy0DdkzI3OIHdSdQB863rKwyvgIpDb4YJw13iep5/Ig3Tfiam5sFYl3pDCgYfCnZZEEHGgM2TiK3vxr28kCc53i26R33oe7lhze0bDlaC3Fr2tg7/qmx5iISXfgDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7714.eurprd08.prod.outlook.com (2603:10a6:10:3be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:32:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:32:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 09/13] net/tcp: define a fallback value for rcv_wnd size
Date: Mon, 28 Oct 2024 17:31:39 +0300
Message-ID: <20241028143143.1807305-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d12165-7b9b-4c62-2565-08dcf75d4ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qHLbZAZuNXINfN/bHLH0zxFElLLwOCepAhyDhzKF51YBFnCXgzD6PIeW+n06?=
 =?us-ascii?Q?/IOqWZlkoMTJy9up0oGmflZDxaHCxxwoOy+m233EaW6nA4k1mZdSqmvsOydf?=
 =?us-ascii?Q?aw+8OSKJxasFW3RxoEzcFGvlKeX+VebZ+XU1Cgcv6HaHcqdzNsOE0eTQTq0L?=
 =?us-ascii?Q?Zc96MUB0ysNjRX/qQSlmOdlDxYyG8WPS/NYuCiglr9rJiejof4mnPDG1mGjE?=
 =?us-ascii?Q?A9mWDWJzdqENo+4hwUhu+tORnpR1tFjN9LgAV3HpCtwAZWbqe6MGELJGMWtZ?=
 =?us-ascii?Q?II8zuYIgt+szYplS1VlIWxa9lA1cffQbDqaqOYBRlDFnc9rseMONisRpLNAw?=
 =?us-ascii?Q?gXT/103awoGtuXKBu9+Iey/GNj336kaORmnwKCjx/aE12JeLEtX8bFdXQDiT?=
 =?us-ascii?Q?CahGJoeo81w06N9miSeNgR9BtC4IjmW3tXEKYrsW6shs6NjumViVVGHG0SFo?=
 =?us-ascii?Q?A4D3RPUENoKFmLlA1H30xnexOai3ZdDphTZiqbucr/wQKADVtB94WdzSMz6i?=
 =?us-ascii?Q?1BGxsoNh2CtOpfAaTLazS/VIjdlnxzMa8+RncTH1xHlFsEP9xcl+iHlBXqX3?=
 =?us-ascii?Q?qIOdhSV1CHUILQXh6JVhJA/k7WUdDeNESi74o33YmYms4xut94ogolbf6Y9b?=
 =?us-ascii?Q?RHA1virzADvbDV49p+oc4IcrSGFwCTUnTly5z/pjeqGzpL6eUo+SYyr/A0L+?=
 =?us-ascii?Q?HUqFVZHO2mP4UXakUFfnN6AKQgPaPjZSSm1S8Xh65AnbbB9wm5snduZDcN8+?=
 =?us-ascii?Q?yQDRr1mtSqR2exVt0AHhtDKbW9voV9+TCRo5d5dH+wt7Fimuom2y2wg/AvdX?=
 =?us-ascii?Q?yFIM5Yp2h8KUunZKn+s2v9at6/dHNwY9L3KSSVHnW5GLUxt8KFGdvjYzxVAg?=
 =?us-ascii?Q?ojiyxvQSEFcicN3DAOgx4aVzR0rUyYO5KQTVlgcYU9lm21Ay/uqygYT4a10o?=
 =?us-ascii?Q?Ko6fxVFbRsxyG6ivJOAj1HZpKQ4oWP1dM8VbZoa17OO2V4T4npF1b3nNwUEF?=
 =?us-ascii?Q?xvt6kL18h7dje7NAi9ildEsjP37BxZ4mmE1p9ZrppkxrVDxogJtayPkbmIQg?=
 =?us-ascii?Q?tR0Hq6Wm3N2bqZsQFMp18h8dIcY1bEqjdOe5f2NorhBSVzwPS7G1aB1h9j/c?=
 =?us-ascii?Q?kEMYEUc5TST/ldR0Xc5V6grF6mzKx0Nocve/nks31+vuF9o3GWfq8v4hakaK?=
 =?us-ascii?Q?iLVamqrFsV4EqbXWCgHzLYO56I7rIuFT35KSVKxa04K2CRIKTq5w+DDZdSg7?=
 =?us-ascii?Q?docQtIkt+gZqJcsciIGWFyX0Vea2cCnp3mSNos8rnJAvPYyRvhxOg1dJKlWG?=
 =?us-ascii?Q?SSSx3566bSnn9jSNcIxZTc58gLI0EWiRW0fuqI+qThnHBR5QBEAE4klKDfLC?=
 =?us-ascii?Q?yTmltNXQJIn+S6g71/tTVc47+SVO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/Cx/ZdpCNqem5sEPoC66zKMNGmiQV5fZ+Gqwktu4YftiMumdoFCvSVbrD9+?=
 =?us-ascii?Q?FEfckBdHg63ouEC8Ebs6jmT5JnqX0pbfVrwejuRNWfLU8jOxxuhYsw1PI4WT?=
 =?us-ascii?Q?BTXBFADuonk/5zfDWk1JCjS3u+3LOCUdSUSJ8HG7++SvlHXNXwz7sRY8k7UM?=
 =?us-ascii?Q?HCWC/mytL4Gh8BvumHGxwNPS9qOxPBJzmY3pk2WRF6rZT1TTF1CtdvS8ecx4?=
 =?us-ascii?Q?Wnk/R8KerH/v/RdeT9uljzVovdoOVrEd/p8QKvae8GuLHC6BcX8gJkvIQ+6N?=
 =?us-ascii?Q?AuK7QL44H8fM+q7swbjKpFQFGKR1PVnEoO6uPWY2b8KLB1Iz7r90ZzeFNjTj?=
 =?us-ascii?Q?XSKOJCxAHiUuuSYBfj5e9woWpFUPTMdPH5vhg9Ta4x4gtHN40D0QO8xfZXEq?=
 =?us-ascii?Q?qtkPOw+4GRxnHYfAl0ClVaqhM5YGfTxPNIypwNloMUfq0Lc0Y90UQDeJFGYk?=
 =?us-ascii?Q?nqvf6tGUDtOIE3/m1aE13TiO5T+FM0X/N8UKdGWrbdBgx7cqm4Wh3kn8cMKO?=
 =?us-ascii?Q?l1Ct0591PL0HT0pBNDmrFfOOaSfvWNWwocLqiHYnxmgyt9gb8NNPgG7voQmM?=
 =?us-ascii?Q?5Zcd6wjQBI5U54JMPbCi5Dfh5188Z2KOYwTswLeLgIZ6sdEgTKJcy7pY7GQE?=
 =?us-ascii?Q?12pncycnz3dZ7h/5qeOkgpdAmbc6kIDrhz9zOQITPFPwz82AxUKEDxl5GdAN?=
 =?us-ascii?Q?3kjV1S8IezUE15oh403kTlpgTr6MB+aqwv6iphoD2piNZN/dFIOns9pU4KZD?=
 =?us-ascii?Q?WWB8fPLZCZqnLoIkQsXJXobLsEa0iLSoaxwG/30qqv7M2GUGOYhBpP2VHEv0?=
 =?us-ascii?Q?E5At+cGlENDiiUqrI/WZEevn37fDUwXlgdVm7L7D87EKaLp6QX2+C80nviVk?=
 =?us-ascii?Q?7ZIzaHaNxQxECoc8M1k6cPPqevwd9E9q5FI0VLkmGKAdL1v/M3fLtijEiqel?=
 =?us-ascii?Q?cgp6KzX0KIVOZVdI5yux/vVOqDxsBz3Tr8h2pSOl/wDIqQGPLE4NeMuQcL6h?=
 =?us-ascii?Q?+0+HLqSW2PGZ7A8izFRsgKTdhmuKs6WmR7hF1ZU7UxoiwU2bTXcrpY2eS46N?=
 =?us-ascii?Q?cnOFuNQy6acuFkegPJEXkstlhS6sYmWZJowBue2uT4DC1Y1UHFwCZjAmcR4e?=
 =?us-ascii?Q?I5BdpmXtVYRmqjHiazyCkS66K3nDy+PUqju99IgHRnBgs/moOv0Ih4YINWV7?=
 =?us-ascii?Q?HXqOplC0z1x27jqR28xZ81jkOLauUgLvEDL6A/JighVbfNYzS+QjkXYKYq+J?=
 =?us-ascii?Q?YC3mTLvYHQYNIBX90l49t8/9X6fjKUUbaJH9zZ0NlaFTJi+BLxzqLyED1n3h?=
 =?us-ascii?Q?0P6wt5TBALYx0gM/LFpO0iVOBnyRdS2p32CC90ODDOyJTdrbzy8ykG/4C9mL?=
 =?us-ascii?Q?oXR8yXP0+LOWP9i4N618x6Xc1dn6Xmn1WnYkEFK5EhUmMBEw3Xc9rn5802UR?=
 =?us-ascii?Q?u+CqnYgi4KZid/IfPGMKV+l6K/UYmCvN0lcT0quI82++A6theud4HTvVe33n?=
 =?us-ascii?Q?fvbOk8gYvgKsW7TMSr6jwEnm6RiWLG2TupuwkFLUbBGR+aMZQ7E6ZmPvmVeM?=
 =?us-ascii?Q?7cAY6hAyNg4Ce9YPoCV1Kbd9UXAMui17XVlfjcHocEKahwl1K/O+Uaq/8Jwq?=
 =?us-ascii?Q?IFAgtdQU3m0+YBB6pEKzdNE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d12165-7b9b-4c62-2565-08dcf75d4ec6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:32:11.4760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc/ZK7fsQyGdltMkyC4geYh+9Z3aPxW3Xqq6lHKBCm1/Jwb60m3nOWv7Hf7w6xuFdQE7fUZtXVN+Vi/1EZO9GfXbCzq63XJJGg5H5hXjUHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7714
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 153f5183b25..5e76b1a24bc 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.45.2

