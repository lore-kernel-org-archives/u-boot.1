Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D49DCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDD98489E;
	Mon,  1 Jun 2026 21:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nSV3zstZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D87F848B0; Mon,  1 Jun 2026 21:53:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A498848A1
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvtL9q0mq+83qk+e42vPnyGa8vX2EdVnceDV4TiWQcxCAnYd2PHpK0jiphO6AGGJp0F8PGeSnSlytMfFOeJBDprCOQQODF3HRhfVfE8HftNQCUCue9Uhhcy6V+BqvoWH4St27112wIBdBMNY0UGxQb7WpW+cddy9CuRzRnJzeBI7bw8AmomC7c711RolinqRPBr1AqkRgVV4ZNVwRNYln58LNWqxxo5ut5d1l/wLBtUlfBMc0xKr3jV40YWmZw20UQvxHzpKjfMt4WEKdh5ZDAW4V1flhJ+gAbLC9Qq9EN3iFFmomYigU+PkppjUszBuFGEtSr70zYoLUjmTBinI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=lrBbyO1tADjyC2dmnJgQfRZ9hzkGs2so6sVsreE2zPUMMxJVfI29iqMvOo13zvxVL4Ryp/D/i6bb2xIQaQFVZy0HxV04nSK4s3LUZrdfIP7YbNBdIOj8J1ArVkTlcHLUcyMt5cRE5FxSEYzfdUfNC4LlWeHiYVge+gX5NXHk4uB31FmcgBCyca/H276WVCZh/JMU7avC50MqFYjK5O90K42i+VuO5m39+TLBxWLFvlqaG1i74EyUEz2nug2rDJPvQ60oKQKIqzliutcwtcJ2n+GVmZ10AEoJJpYdmhExlEcZDu2+mAwTzp+8YuN0vbojwZwxOeSX2+GfXs4FmmS+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=nSV3zstZOPz4EXovfs+CCJbHDGeqCoY4TnuwTgufSsB3SaP9LzUC2euwSzGuC3VWbuquX+tK5QuMR2UPOwgARTTM064qRPlIfNfa6QHfoXkQggCjpjbZZRWepk34c0iYfgc8WP8PxCboodYoRPasrnwNhRbW4shdbtTpy37YX1z4RDyY5gEgym/18sYZZ+0cTTqwJBK7OSgde9Dj7TjIgKLsbk3E/yzn/vhA7br9ASnLiBlc2TRXf2Ue5OEN0lcaGMsA+H6MFXEwiScPUnwtgSOYYkZRgAtZtNSuXkHnRvin97btsZNdcIRPJFckhHyM+NbCQW4vPcPZuF1zJSnOrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:22 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 01/12] bitops: import BITS_PER_TYPE() macro from linux
Date: Mon,  1 Jun 2026 22:53:00 +0300
Message-ID: <20260601195311.2390473-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: e8823558-3734-4987-8dcf-08dec0176f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oyTEL9WNNBWyyVQyTP15y6Re4rc1OdGlwoosZeAkb/P5Jf8AjYCPhQFN9r9h4UVvTZyLZN6dSmvBqF7orh/XQtlEueHgrTLgZZBNlTC2V0RV/Dm9mIOSG4U2749to0IZRojZ2vBncj/1dJQrd3cTaiJiaJTzzKJ2OBXN/NwfN+YqW0Mlq1aJvNzmlqLS3Y2M8K/RDO1bUvXxEtvDmhR/vDvsMIto/pN6mktX0CxXZKjSryZV+DvSDmQSSQhiSlbHXuSu/BD1CO759JgaxT+vqeKX8cpwItBlxngXN6s/TVxiVpp8xPoUx5i/0pHDIHpCiEhbH7vrYolkYeS1mtspqI5lkB7gU7U0HjVMa7ZD5vxiqCYdJ17DQfAEbLWjX0BQpishoD6rgqStADp0rS7WgQcogdIujrqWQ19xhUqB6W91GXThjRY76LhOrZXilZel+DDCuGAwrcrwBnnVDX6vEtdMtmSOVRG0VZ3GNKuRubCmMVJ03jKOqELdxOJGhesUCiwblPnc8G7HNgsfApcGtKqEwUV6jczs6JEay7SrHvdUcb55WYZBp/JkC0YRuhDJyHOlIP0ik+iybI5/s9SvCfwGbWj3RuPB5YpQd1UqLfCh6NtWJU/+eTMA04UtW1R0JA7KC1I47RGVWwKf4Tq01tVlm2wYjFIEeNFJydAeo+iW3HwYyClitYe6owFDwyUx8TV9Cr7HVULe5Wy798dlnb5q4gG4t4CAf8VCbLfPNBcNckgDlmlTqQn9Dm3ZCQY4ZlHpdCBx9S8OsWwrsLqQuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PZbAxhmVHK7KJrkRrogg2uR8U9KIQ756FplyrYmE3JtrtBeBX44LBKPnsS0U?=
 =?us-ascii?Q?1UUXp9XXseN2fmpm/VitjwLYCV1FR9hUVQl0kcMtdXl3evV7CWPJcoKSDxPR?=
 =?us-ascii?Q?2zVNbTPPNxLxUTa4U/4EKoPqfEkdgIfA3TG8LJG4tUcHDQH2AqWN8NXmgl8t?=
 =?us-ascii?Q?gIcLMOeJKvy+U4SOJBIGZdMvWuV/oIflKtPDZB8jF/Tgs97xrg7sE29gre1U?=
 =?us-ascii?Q?/KxfTeFlSTj/PSjIC/z1KTgE7n4+0+Vt/Jwc7OycY4vKMTXigW2yfOQgHJFz?=
 =?us-ascii?Q?4QyPNDd7MFTC+Tgr2BoWTSv2L+MnM6cBPOOeO7MllkrjPvwu0GunkEwBeYXH?=
 =?us-ascii?Q?BIe7Aq5JJtfkT8ecksUd5WcD3k2ZKNzZ1Y3G+X2497O88O1wEp5+/qtVF08F?=
 =?us-ascii?Q?on/uuZdgpCyjpwaNl+yfGv3kVXZXk7voLWi2zYBj4kkgKqXzxY4+gNmbcSiy?=
 =?us-ascii?Q?+0VXf49reCuBCoeMxql3yx424s4Z3W62uJZzcNGJX5kgFvX3ANyHa9uKk8b6?=
 =?us-ascii?Q?gNbxzope1MsmCC3lW41eGlSfA//GdKwl8+XxMt09k7OHs+KNpIS8/kDE9BU8?=
 =?us-ascii?Q?U8IPshD4YENJXz3XfvcrNZEzxTzkj4ngH7APWc2AdS6ThnsYVaWNRRgw9ts9?=
 =?us-ascii?Q?mj8EZzq8WDE8v4bM4933NdU3COexmut+y/smbr8vxG8MV05roIVfI9MSDccr?=
 =?us-ascii?Q?C306tcIf1JtcgQ4L67+WcSCjGzLuCFdP1rSF5F3jDrvPCivsDXnQ51yyM4Y8?=
 =?us-ascii?Q?e5uAyErHdgaOoW6fD8z0QM9B6cBuAY3NffIVLORfCCFOunUJ6UJ8QUnA7cig?=
 =?us-ascii?Q?8Bg4SsxVoQfsgjpqXlfUZCIvf8bEPoXBVCN5tk6P7ZXSWkFNtrZNLUY4zZI/?=
 =?us-ascii?Q?QeGOI3fW2A5v3dEJoUZJiFaty856wgDih/8ZwkIfcGsUwDiZTDQkhty8389a?=
 =?us-ascii?Q?dNaBxpj8xTHLxZhCq2DU/zGmY3UXGGvGXnNKYqvStT51Do4wn70XcUs78/tv?=
 =?us-ascii?Q?ysH8vP0XBuVghM+2dBN3O0qavGWVJdPR6fY/m7g6SpmHrZOsGwa+b9McIYKw?=
 =?us-ascii?Q?rPy0C3+W4CQ4l4psokyFfqCpwYxGDZWpmAXvMK3yCb8nsGJYrdRDfoH5OUPH?=
 =?us-ascii?Q?NtSU2XbAUij37vWzy6h5lhVa1YxzakDBKTZeTYM/Vx4TZ0NW4t1R/dRhnO5/?=
 =?us-ascii?Q?PapDihLnMQHg0Hx7Z47O7rJDwFrxgKaUn9/vpv/C7ibaJnOr5QyPEnxvjhWo?=
 =?us-ascii?Q?2dBIRG1r2V/ZwMn1YMBCVO91zezfb4w14sHaB8Hxm+ZmtrS3fHpUtHIT/KmT?=
 =?us-ascii?Q?FSuoMRIBJd1iiGw7zbcEnyjFvAVHO9oKunNlcANx6ysqzdLRQqcKuL6ii4Bo?=
 =?us-ascii?Q?yQPDCbybAp0wdgwMc1kuTexET4rJkyJ6AhasUhP3gROVzH0w1lGtNdIo9zCh?=
 =?us-ascii?Q?TgAoy2f9WFxKi0OqnF5+6e1l7o+bQLaGiKSapELqU8hWsm4Jq1ImQyDn0LTf?=
 =?us-ascii?Q?jHRbEhVlEc3ra+FbeBYw32LL6oUoWkRVe26cmSx74+6MjZh+/SFZk5rqAMCz?=
 =?us-ascii?Q?Ws5qfpM6kAdwLsqk1rZx+utD4Om8AMaPImZBzuqqMLLR3gqTNwzJnz731wwc?=
 =?us-ascii?Q?Cl0AlRW+eb75tGB9bujzU8YbCHdh65aJga9TyYh0kFnDGvcZMKQy6NrhKK6r?=
 =?us-ascii?Q?8I2HxpgkIK/s7HOHdvbQKydcQQOLA75oTqOgygmqAIZBoqg25EY1TeV9GCZG?=
 =?us-ascii?Q?JsJCfeo95NRcUgB2oSe7VZYU8ZRJKE0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e8823558-3734-4987-8dcf-08dec0176f59
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:22.0059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNJheay3cKRQnxgz07ODzvfQQDJUdWTRgqq/sTutnXxGBQqeDM8ItMFti7q+hqcavsxOM7YzM3b5+XqskfFvPe/k4SbWOMIZ/dx3EF4Qsg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

