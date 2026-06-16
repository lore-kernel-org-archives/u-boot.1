Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FEECD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11BBA84704;
	Tue, 16 Jun 2026 07:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TyHqELLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BCA784884; Tue, 16 Jun 2026 07:31:25 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A70846CF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcOczloVMj2YIE3wWH0h7Jl1k06GicRUh7lk+zqozIRjidU4EyRQhzq7kpYSXjkizSFzuNSgM8c4kAdE5KopN0F1LmsG/hhoOLttv5ncVWKtN3ilCeLto4bXaykyoh1jsi6K+0NPWO7sBVbGrzGYU79KyiXjXwo6x0hh5LKe7hm2E9HB4KYaMGg9j4/Z+xJNE+inQ24FbXD30x3kbtu457bRom9+QsNwanV8uHjsjoDP7MRV4jqEhuc+qa5ZMi0d2VgRZqgkYoWx9J8r9ir5E33hav597pDxt5IbTIMagXoN27nj3xYqq+71sxBrBH0Y/5MvnOf0ZqsQ9NCH1VKNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=y94FUc3XT5uqkWmdGfbglYMiboV32aASo315ST0w7TWcAYCWsiiD8MIWsBDUKN25RRyVnaGUAYPab6boZAfASK8FbjNNr/VdBbAjvsDXqC3koiGmRzoMenOznTYvkUZNtRFtT2y72fcJ2QOAumZXqW9zpANRNyu5aJD9RlIBRn9RjG+05Fr3DRRRDuP9WhiExzpDfjmKaAVayR/AQrIYr8D9HcSDBe/vZcHLgeWJTtPym7hmOTvSecHTyBxYQGp/nPtoYNcozi5EtBxYi8sJqxxK31MphM72EAupWsfKFOJUDqxyZ+wvdouiyL7IzMlprlmke5kUFJ8VwxsM8bxykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=TyHqELLPcCxW7lxE/yn1XULcGsXgTnLzKZlPX+R84maRDt8m9k32guXs+4lWHVpYUyd9yabXjNvWrDim7fTDZqiAN0SdOeoP/nxTN77UXBZO1z28mqeZPy48Fsubnqusz/K/8+OMk8A694NnEPtoZ+0mdF0tzm8wFtRT8oFLvNa7OuC9ea/d9xEUupc8L3qktZNw43Mmyf8SIwXcPmScHYpiMV4xazyZjhupgWow00RZJ4pU5loHsVaBp9PEV3ECVCeTT8zlUmFcypYxQn89N/1dnZBmpg7CncsCKGLvoODSfvIXBfrK/kiXmH57wul+hSdQTjWF24bOnXCdOBjfew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:31:20 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 01/12] bitops: import BITS_PER_TYPE() macro from linux
Date: Tue, 16 Jun 2026 08:30:55 +0300
Message-ID: <20260616053106.2623475-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 387f98da-6314-4547-44aa-08decb687f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|23010399003|376014|18002099003|22082099003|38350700014|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5zqDaCzZ6GSDv8w/mNXinJB1o0GN1WxBvWE2EzsBnpa6NtWI1w1wvUocz/RCmreoO/coy6g8wZZeaUgCuWNgEt1s3gO47SGxQnBR4ykWo+r8O3sEiSBqMKhPzv5fFU46ErDCoP0daeL4agy46IjGITmyJOW0FKjbXXlHhYG2CprOHBLgjUeBxUdHr056nbwy4wZgKyonuYIbNBpp44Fkrid9I16tGHg8wAfGPAaEb1dVpy4hp5ozkJIWHi4C966qLkaVvgUTicOSXdYXQig36IWr7Axq2awhJurKTPt9+E/puhMZqomOVEzpWX9+NF6hrXQdZM3ETa0/GgWV8H60tLdFjY1F8nuE3tnOZ66sQF6FrrClGDHGEBFVkuUJHFG6HBnCd5vN2f8XiahE7QH8+IhFjCxbeAuFVRhSWvEgOAdLh8Xf5GS4GxZ9JvaL8VkPRiUy4NDiiIFGWEwPR0ZwoHpaYnlD26j5TQt/4JlU6avqGurVoQ2lNlNG8JRUpv4Nor3Y9lga/eDa46kuC3t5y2gBgugQBh9L4dJceH/WBds9O7IwspSHwwqwLrRucmAdXtQ8eb8So+qU/ozeG35QTFjNFefx0apG9VkaJBYzXnvx0Fr+ejZPZ86EwW+eSEHElvWLTRJZWf6ZJ6Tb6aH0IGFgT8qEtQ9Yag54p8eAWwSZFX2MmC2fr4RPkNbecXrmVQpKRnnumtFhFWh/zkCZV7X6oMtv/4a1aKrbmai/edShTPdoPUJTW8Z14+ipPgkbV727VEaVNE4LNPYCF9tIiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(23010399003)(376014)(18002099003)(22082099003)(38350700014)(921020)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjyhApj69dHN6/v7ucR2U8hZ5HE5YaFCms0twYcdR842N5wIh4J+x7Bg0c4C?=
 =?us-ascii?Q?nAaHQ3iTMjE9aa4zcQfjHOT+vAGXlzPdU4Av6/DADm6gWOnspvhFXK5D/6bm?=
 =?us-ascii?Q?0CvRDi/KcIWyg7R6fcgO4OKqMmk9q31p1zuznJQn9fppJ4rO3tzrr6Ir7Hsu?=
 =?us-ascii?Q?lLY4Z37ohkycS39eaTPLbflD5ZAbrEaYsAwOKmm9zDBBEX+YOFEyPZRyX/ry?=
 =?us-ascii?Q?4fJL2bZDupL69b2U3ofD4cahMBa8IRKA8rX4vW/GoSinD1MQglPjKj0NaDo9?=
 =?us-ascii?Q?NrmCq2AbwNF42SM62/7pUmrt/RRUxQbiBd8Ff8oT/+MfGdz3wWHrLoZ/49Ub?=
 =?us-ascii?Q?Dqe3865WzLRKsGZVLFwN83mlyacNKDej2WeSb3s9HlR3MyABBwXTvjPZT3Bd?=
 =?us-ascii?Q?e91a4lyrbqJ4vpjMS+FfJFgHbUDWO5frsllTBYkkbIbzdRFBnhgIHfPJfFMT?=
 =?us-ascii?Q?6Z9tgvWBpFzI/q/vDPCNs2upTi4HKv9QAg7OgLKuuwSjK8xV6IyS8IeTcIm6?=
 =?us-ascii?Q?jIjvliJZAQDfccDRyzK6XNn8dc/ZmvAVANk1p/4j6KG0PtVxQqSGZrtJ1B1i?=
 =?us-ascii?Q?ALTGZ4NCqtbPWMsWeAfq/pEBAhhO3JfBH2Ym+Hkm5pi5A61DQM1rIpIGukHI?=
 =?us-ascii?Q?NALMvMzE/Ifr6YlQjDDovejtn+OD4gSLgzjKCDjvH6XZm1UWTSPFDDXfUkwW?=
 =?us-ascii?Q?hI4jgdzFE1hTINJYG7JXUHs6DdLt2h2jMlQ/Dw7G/ifKnudvY4XP34iP0Te8?=
 =?us-ascii?Q?id1yQgJz6NuTxiIvkCB2GpzwqDqVT62fcj0bcm5AeaVTUSHK/HZfZRFNYnK2?=
 =?us-ascii?Q?bdnSBMzuI910hX+lhBi/jJYGo8uW6annAMVxzglKItxQz1bYyIvdvEF5ONBs?=
 =?us-ascii?Q?D2AVtNjsI9Un+VGwJZX5Ou96627p1N1ySRd/l1MO2uUPSDLgKp8s1JjJh2fC?=
 =?us-ascii?Q?o5Bhz013GoJF4gV+JVPz7ScGyPWec6RLPr0fuFRk9P1XrBMWNu8gnNCEQ7wd?=
 =?us-ascii?Q?dCwYC4UxNBVfOQoypHeZpNTKzFGgDlXc89Yai5Ho4r3hZ2zv0dGIj8AyWe3Z?=
 =?us-ascii?Q?9oSlJfsExvc6HNuhbWUdJl4NEUnovdY1TmB5Wr41M0o3WrX9rtXP0ohn8I1t?=
 =?us-ascii?Q?7gdJSJieHJGGVExdi9poYaEcr+qcquolhaTSQiwX/ly3mncoswUlJ9NuhV8l?=
 =?us-ascii?Q?BBgXFakGOT8hQi88Cr3MKk/koKzxBrfODAcEtoVuPMKuWXnIsxibyNBXHwai?=
 =?us-ascii?Q?YNuUCojqhJCBkAgCl8vMSfPyLi/m/BZDyQE6n3ZB8KNUEfbZYPqwVP3s3mRF?=
 =?us-ascii?Q?7FLi6wOdLL4SvLl6XM2/M4L8jyAczeXpr5zihgYTO92JDPHpWriHwHQSetoJ?=
 =?us-ascii?Q?Gq57H8pIGl6VOoFE5mEfnxsRjpdywoOsC/k1Np/CnUfIYzdlWSQoFMrftDbE?=
 =?us-ascii?Q?YGWcbqjetcxAwBM9hhFmdgbX70UrU9FMPQj3kczII7Lu4Lk+VIbWC9ejhZxz?=
 =?us-ascii?Q?9dcA8KYBgVOdnmW6vlpwcF/G3BLMo4AxP8l1nrngAaniLlFXXlhXtFPtlIAm?=
 =?us-ascii?Q?yodAVwVRR4XA97QNA26S3vVYx+JhYkflwwLxcYFYv6jL8kJdLjZwYi+mcsRa?=
 =?us-ascii?Q?nz2wblQD0regI9056qB6cUhvloVWQSE1jnNtbOuKzthuQ8sjDY8zdjUUR2oG?=
 =?us-ascii?Q?PPvzeRCGgfe2G+svCtLRCZ1qaKC//iuAreYh9IHlpq0Z4WfwDx6ZyOsMCc1n?=
 =?us-ascii?Q?j3LH7HHaX3a7iA8iqBCfXfXAJkdkMSA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 387f98da-6314-4547-44aa-08decb687f1a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:20.4739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTUgIfa4VQqVSmUu9Ipm4sb3ji0O+Y7bjesLBnxJ0PyvhlnBLIO6ND/Iiu9KEf29HSfMh3EKg6yJxiCNxnfRiTP/R59j0dfR8WAh/Tt2X38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8996
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

