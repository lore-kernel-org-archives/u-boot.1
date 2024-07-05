Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DA9C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174018899E;
	Fri,  5 Jul 2024 17:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OhqCztY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439AE889B7; Fri,  5 Jul 2024 17:05:10 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7B3889D1
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnxxeOvC9aDWLvqeM4Yw78vPMXEHRA1Jd0QmSuEM5QvjR3zfgY6+EYZgk8dRUHyKcdptJ1h3cIlOYtEfeYNKHiULE46ydM3WNpmLXMxXdAlHM5Mfj5ZRhDvMwyIlFmxtFabSBu9GfDUMxEpGJvDDkrfndSvMDfq/kJkclIqPEY+exOSqRKr/zz+/AtZOzdvhin/gSAIXs8E6/jDX5JhoCPdKgov4LAn2SlI73QFdo8KZPbW3SyBZssr0Z4fJPOTAf6Fsw5Nf+P2SugRLwaeRNrvoPOBgySlQW0rbXmkptEHbT7k8kg6vna+JPwOZM/zAASZvPIchJb3m+FjH+M4WBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF5PMfE8fM9n2gWZYei0bHX4NrqB9rEYLYdUPFrjfhQ=;
 b=Nan2dww1mCYfFA9JAH93Aum9+t9HvyGeEKHW2FJPi5lHxQ7WORm3QY4Tp0N/cRCu0XmibYHTL2PwXk8o8yLmwubapAZyaDSZprkwua1xMh8E07kF+13mJxJAjCY1eZ5PrqrF5OiOMSpoCT3lfUvxt5J68thEVgzFZ8qTHmEXg3gRigpMgp5jDnO/UdHBX3i3ApfSQxPFnjH9RQCpgIA0/5yG9vDcMVq6Z3OLZ9x/J9aI2ubVJi0FAugij3cm1i1k69yAPRWPlL1elw7GoY2Fs/a5kZKKyXjrPLd7Nkh2inixVhwywtH/sg2mxzMEENUdLq+W7a7zh5qp/8UhGjH4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF5PMfE8fM9n2gWZYei0bHX4NrqB9rEYLYdUPFrjfhQ=;
 b=OhqCztY22bR3YuQ9OkPopVzIOQsHKcU5tWZGt3hZxVBmHBHSma/fq7Ju8KgYd+ZEjg/vRRxgzCNnnUrHG/T3816CmYyf+x0v3FSc9pKUbjaObpAfZ5i/atyMXUw6aEXeyqsl23E0WMZ7AHO2o5PRHWmDnkXCW2TG7GBZEalk6NEtaN8heEBIAFS/zEltz5BVBaW78vSzZr/QDmmX/KmgC0xi/D2zTYFoRAHxeNG+Hnbx0usNZeTrdHBSJIX8GK4kNNqgPqaY/eunoUJjkwu+wjNTM3SnUhpTkc0yxU1u8fND99VupFj27u8AToFlIzjdta0x1h1Rqd1PA41xrSnB8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 15:05:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:05:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 8/9] net/tcp: define a fallback value for rcv_wnd size
Date: Fri,  5 Jul 2024 19:04:30 +0400
Message-Id: <20240705150431.2274662-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ecf1e7-e917-4b65-0a92-08dc9d03da36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KYFKxw8n648niURyw4gWzqJwj6DtOJ7r3578gPNHwMtR0igXuSx49piGGmYC?=
 =?us-ascii?Q?/FSfhQ+R142I6A9MT8Cu5gLxxFbfy8WCflUjG5vIr2uwc+xLVxph0yn/HLql?=
 =?us-ascii?Q?fEdjBLxtW6ETbKoABmc3k7CRNQAWVxjhPoboBCqEbFst1VURHcQMUWy3h8XL?=
 =?us-ascii?Q?lkDfPGRx+WC5/6DErKMn1y23mM2sJaqDCr65bD0ytAQwzAX3oLh61oyXaCbd?=
 =?us-ascii?Q?uzF1dPJR6E091uV2zpP9gf9ZeufQs7ag10Q3uS5vsG5RwC294lEkCN/lHPuK?=
 =?us-ascii?Q?S2/HbHEPdmLfUeJP9uCCb+CXqJ6Wgrk5RArGEDND3W3Ifk02T+lSQqDMUyr3?=
 =?us-ascii?Q?fnBsA1cJeckKb1kcLwNxlBoh4cNHgZlwxOe+Il/1oZQRybvLGBJAQ5GuS8Bt?=
 =?us-ascii?Q?RcnvuGoMicMWo0J5jxO8J0LOYisRl7SJELgMUtkDn89cBTq410nITvGxw4lv?=
 =?us-ascii?Q?Ns+Hphbl4chaRzCIY9ENtVrDix+Wz+nE4Rs5i/9L/xdwnvFp6syjcSwoirdS?=
 =?us-ascii?Q?xtHBzFMOhxajpiyFuiIQs3sgPpqQ28npQhRIxakPRA4fvGVHOvKO0LU/nE/z?=
 =?us-ascii?Q?q2uIFXwmE7cIg+Jckdr78jCHAM59qKYWNXxWOourHMYM+AB70yeH+9p1n7W5?=
 =?us-ascii?Q?AFZmkDDPmhjrY+/1YHvL51ebxeVFwU0QWvAJHvVKiViIn4AcVmNQV1LYqwnt?=
 =?us-ascii?Q?BcrJDJq51+OjR+q++J08FLFeddS+VGGSvTzBMG+/OYGndo+/E/zpXyH843ny?=
 =?us-ascii?Q?BXN6eMN8MPGWzNRQkJGIJhoivHdNvlquZ8VD+Dn/8eWaGRi69qppKaikQHmy?=
 =?us-ascii?Q?QEZtMqUrsb4rGlbw665nWHfLhWblfTimhwPjr6yYVqy6yYukTBitCBGF9eBn?=
 =?us-ascii?Q?4Xg8L0w6/v4iGizE3tUQgO3NrKJ5APbCM/NiemMQhjxWW+tWopBVkWd5rAw6?=
 =?us-ascii?Q?fYCigv4MNan0R4sta31N6yW9xuMsldk2thprFGkmtWo3Mbt4EAUC1JiPFeL0?=
 =?us-ascii?Q?JmcrNilCQ7fCUixZwMtCXJKwBcW0knK/rgVxL8/T/MamJswY3LU6DjVUcjFF?=
 =?us-ascii?Q?aMPEXXPUUIua92Dhglfwql9qILPVcSqcGnrq+zrbU80cNLifRKYzth8PZkIs?=
 =?us-ascii?Q?C42n0SOEQkRV+mX++2VyDdKjhhwYRoTCrL5L8ZT+Eh4WzzXghQKmDuTmsFOK?=
 =?us-ascii?Q?tOyG0kKRd6tfVrGPNsxhLM9eocBBDgtYE8vFtp0yioofeB5Os1BamG9C7ihh?=
 =?us-ascii?Q?Ijr8qpAijVLb4FKygms2QcJ1Lz/A7QzhF3aGyYKaT9EhHWvP/Xl1FZ1b2XPH?=
 =?us-ascii?Q?JSKXeOpMf8eSm0HkkFiJdKTnc4icGLCPRO+VHYDAj5Y0O1Kzqirm2GRSJGS/?=
 =?us-ascii?Q?1t+byFCqJrgfDW/LYyPqutkh1bXu+CDT7OA0rPuQrKBkDnPbZutFTnXSTQSG?=
 =?us-ascii?Q?xBWYgX3Yq7c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5RXfFMx2tUT9ePbyjFYo/en4P9A4mtT/2+hJFbvW903QNFvwd2xE08GexTAm?=
 =?us-ascii?Q?kqSc9TqL89QyivRCYXc02cgZnyl4eys4PlopJ2jrsoxXZSDGSRPorOqAa9p9?=
 =?us-ascii?Q?zkcvzWBjEEBfrcUqb8RXD93PVrBdpm4gD3FRZAd/k1oRU3M4I8mLW6KztWtq?=
 =?us-ascii?Q?imtrDXnWuLmj7Cw/rI1ybPjYfuAAwN6rJ6jdiw28IQ72i3o9WM8QIe+lejpQ?=
 =?us-ascii?Q?9aPIpf5zbezMi4UHSD30cDLIE/pAc6ZUBvAPDOi1ilFHt3uedxEh8UmlYojc?=
 =?us-ascii?Q?NZpgyD8gGQgAONs4qAgKT7z7QmWM17vVLsEXsm5HCN9sT7mAwHkm++mf0w1a?=
 =?us-ascii?Q?X5h0MIN7YWwsl3W2aqc452YjVKx8VKFOXpxogIwGmJ+VtHctn4A5XSekcQLs?=
 =?us-ascii?Q?Z+3r7Shw+ueMEzR8U9tObMVr8IhnqZkr+4OBvl89u5sJgfPPteRc11PyQxbN?=
 =?us-ascii?Q?P2a1hwxUbu1UTZ3QogBUHlgoe4Fa1MbcZA3OYlY1b9c1O1VsiCOEdTdB33DI?=
 =?us-ascii?Q?xZpQFUhRNSTvXx/g4J82ZZc+XKlssoRmEpoIM8MOS3/gDy4L7l9NkGKGICq+?=
 =?us-ascii?Q?spKHXoV5a5PfjCtAnKTc+gmO4siZRm5TlILL+Rl4f8Rr5f8reu620PIXcUK1?=
 =?us-ascii?Q?iSDsxv2rVJTlBwqLHhSdFqEEBruV7QO+DPX2m1JT8q1UnuqoHtIOCnNkyTYY?=
 =?us-ascii?Q?5/PDHEXPX2BEJIs+IsK+1gZp7wE9bKylT+HlFSbf68H5lWlOOflRYij1rKe3?=
 =?us-ascii?Q?3d/eF7n8fgDgfH0SzQmjRJkuXhZoMRX8T9Mwu9X6cUfuB7D5FS7M4lxDVUmb?=
 =?us-ascii?Q?gi3jlDgUpcnU8uoe+ZUDB76UuIsDWss3XOV91AR6BzPxIIxfHfxDKNvllsAZ?=
 =?us-ascii?Q?1KJc+kaMW8Qm0MJJIJ7YB7+AEQr8c1ezHiRH4l1HscYFBCddkPGVBqMHbhba?=
 =?us-ascii?Q?jN9qxxXnrbgUXX9bEM7VmYw2HQboW/hFouPPff3rZvPnvD20f2SUXpJS7gcP?=
 =?us-ascii?Q?giWeqzooxqv8bLabk9Fc0OEUzUMXspc4P4oL2wW6J76OH/HFttKUWtUHZZgn?=
 =?us-ascii?Q?GBtyCDits9bsnhBL2ruNxw2LMvFyMIB+q38uMpg952l49wk0N56+3j+Jib6i?=
 =?us-ascii?Q?NrbhznZw4QoAnxBs7Gy/7dVLmaRD440F4C/qgZXnx9P+ASkiNUX5m9pPnnSy?=
 =?us-ascii?Q?9OVSa5AvLMxRT09Qddu08prfKRMcN+ewu8psYcT7EkG8UGkmvqbpUU2GQNpb?=
 =?us-ascii?Q?qvcON9GKvVFeKql1iZKPx1S5VEKNsWZ65RA/vylGAUL751NC2HwiE5pNSX2W?=
 =?us-ascii?Q?Rua2VBJ8Gxe6+2kpyRCnCC/j1xorkyi8KIdbrRrnW6MnsO6QeQJ3ldtyy1OM?=
 =?us-ascii?Q?6zMfdzFp3/nfOMyD7l9om44TvhyEqJ51nnG/SYtcLb84VkSTKaVIHNm7SoDA?=
 =?us-ascii?Q?1bCEB/yGI60X9/l3kvZEdWFZ7oKOidNSYk/Kr1/sq1Lbjj2PrUsinhfTzAL+?=
 =?us-ascii?Q?8KH/I5aF5liwg7XS42TMNuDrhtHmgFkf7pjhD2qlQOIZjbjwqbrtHMznaT08?=
 =?us-ascii?Q?iI+dIoZrEx+JURbijxvWzJ7YRjYzI7+rZVMeRQzZpsm1Fg0BaQ96gWjlGM2i?=
 =?us-ascii?Q?37VQlyA0CkVzJs3L5DWB2jQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ecf1e7-e917-4b65-0a92-08dc9d03da36
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:05:05.2720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhIJbylvJC0aWX659YTwG/lAg4g1PahLqisbjSp+MUD/5IjFVPjGmvcwI103ioFILTvmHI+Gdhh0RWq4JqzuM/s9rI//o30yZnAKiNVs0R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9834
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
work. Avod it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 9fb80f9c2a8..fc713f503fa 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -29,7 +29,11 @@
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
 #define TCP_START_SEQ_INC	2153	/* just large prime number */
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.39.2

