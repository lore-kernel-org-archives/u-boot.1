Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A158C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC0C88B84;
	Fri, 23 Aug 2024 22:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vNBOzj5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C8C88C0B; Fri, 23 Aug 2024 22:45:40 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0548895A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhWGRZBP7OOHbmb2qZqOYjEu+8GwiMVXYNmEwXaT0Ay5G2BfXsXZnj04KOQFf2GsRTEarZlkZ8TFlTOKyo76NYP63BFZ5SMSzBWDTQ9PEzb1HE3i7km1IXLoYycbcSz5b6Qq1Kg6T9GT8hwKSdAPf0+dk5SFKU0vbnQM/xotrq2W0jhjMhfER7YC2B0ds0FK89VXOPLkV/PMyUExQk0QkV8rJA0z9IIo5buVA1QVg04QIO+EfVz+ytrLp/AJHLN6hdXdn5Nov4vgTEIKX2zSBwDCzfsY/Lr68aXSeGbEUT9WAKGWPV4bOo7SRfgtEG9fk5Lx7927WTsoqVbfoQotIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLGv+pg5SORkHPEXuvhdPc0FAqiQkZHz4iUUkazxOuA=;
 b=Df5BG6roIhnguiNNBYKCutIMa6IYu6Hiuxt385gL4qJ7XggLDSG6zG/Nd9uByt81YoQHtu8Pu2gvNNlh+L0VMDmhNq5AAOdp4bx7QvDhj5KUt69vVq0lgA8OGzPxSI5SrpBsx2zb9VBuEWVVYlAmnhw7Mszz3StrW83y29uYttkA91HnuwOd4wOBvBjjq1tuWiGfDrGMqNHz363jYJ27nVAVOcXfHh1Fke2EfIuLTp0AbM847MuEWK0SV0mUdHBi6ZryHOc4xqKFt3Ca/Ei7fiRsNsWh6txexHdPV4VlGgHlTF2tq6ZxnpL5nGcLntDnk2yU5Dmvj2O55mtqAQH3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLGv+pg5SORkHPEXuvhdPc0FAqiQkZHz4iUUkazxOuA=;
 b=vNBOzj5nznSOTNP+lmMbGyIEW8AOTbPPuE588C7jorgXQYvXRUFftNuFQyohOwHEnTQvNcoi9QgSSxhkr0kZ8Vy+fzVQ+7o2+A649zHnnpNKGgSUTq0wJGGcOou7Zgi7G87z60H1dKioQ+DurKWDKB//GeVgrAnoEks8RmJu6mFaR1CZEg8d6Tmyv1C1dlLri4uFpjaJZj2tVrLXtn3NQedDAvGirfcW3/oDba2AJGe0PVsXJcpavyoR/X/RsH+a1rAITYzOPuc1UrqJkkKsLHzhZW4DOQ4b3Te7m8wkBkI3nPKYUMzDWk9O67w9KrdnEdzcOZg4N+1/WYwL5H8Nbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Fri, 23 Aug
 2024 20:45:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 20:45:37 +0000
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
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 8/9] net/tcp: define a fallback value for rcv_wnd size
Date: Fri, 23 Aug 2024 23:45:17 +0300
Message-ID: <20240823204518.1010194-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: bc51e85f-8c3b-452c-7b7e-08dcc3b48ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mXWUcMSF1xyVFyKhzNWPOnAxLTaQ7U62/ORCBglROEEcm3EMjAHMUOjhY9Rp?=
 =?us-ascii?Q?/Hdi2kMCfJ9fL2JVnJibAY0yoveW2F/rx0BiQWbFmInqUwPtBxBtO0ZTqD+G?=
 =?us-ascii?Q?17rabO6swypxISQslcwOiuSNjrn20Y1lf/76R0wG/j8EvOfFzGk1HVgxrhBS?=
 =?us-ascii?Q?NlU/mxJrvpUFCb9gf3AwFqxEsbvu1WI5qllb33HGFnHYfLR88Z0TqtjYpjIb?=
 =?us-ascii?Q?pvUt3o1WLvBErKGgpkeMn1UEXtQoC1LN516J9dUQwh8dU4S2lXKmwVdnxQqo?=
 =?us-ascii?Q?3pYIhJTEZPWP+89Ab7HzLLmvAgApOQ4nbtvuS2a7yOkIiwYhcH88g4ZnBjRq?=
 =?us-ascii?Q?EolVIv/nZWYxhwgCGUqJYA49t5HufGwoC/64Jqo6X3QoNCKijEMv7RVogw2U?=
 =?us-ascii?Q?P3lbbA95IxHvMFYC/n9u5En19qwUlihWV8RKn3UMTuxmiN+Aj4Dt+XE37cbP?=
 =?us-ascii?Q?JKCxKnGZd3e3ey94Wf2h++18dZoFkn/W06DP9FZ9uYSClxvHqcOBgIV87pRq?=
 =?us-ascii?Q?kPgul9okvM8YTxh65UnFnuHJI4Bz2H1m7RGZ2GQEsg5hvujltXpuQrL5/XXI?=
 =?us-ascii?Q?5MVGh/kPpMwOnHc0c+hk2RKYMi/XRJ58jqFU1CtQU+L56LfZMCtjv8zuRi3O?=
 =?us-ascii?Q?SXR91WrQuFcHb6By/5akzlpj7Oy5ucSlb93f70jxs5UX3i2+sDE0gJIRITwc?=
 =?us-ascii?Q?IiA6vyXnm7mmtUD9RzoIoM47XXz4M7Pa7K7fw+1n8wQrmM5Za2z0xnNjIpYN?=
 =?us-ascii?Q?989DPmK0A2V8FeQW3L0p3ksR/ZpWAzSLq3qyJK2t+zYYFj5ZqmTIE73ILqVi?=
 =?us-ascii?Q?Pm2QAgkZ3g2/6aYtmxAG2bgj0YvQOFXAbHQ3Xe2gte1teVDY+cKExMYlBCpG?=
 =?us-ascii?Q?u4kT6redpozuSebOMZI86qKLqRnJc2e7zSkhjqlemQV5pA7SIO5/2KNcdebI?=
 =?us-ascii?Q?AiTpsamRju/9M7p3q9JnCyxZIOR+29I/XU/F1Yefhj8jc6juD0j9QlRqfLTQ?=
 =?us-ascii?Q?+iiWyvUA3pRor3ZzF6rK8lXAMLdN+u/2oLyyXs4lsCfedbioQ0X010yxASr0?=
 =?us-ascii?Q?rtFXNHHLkHCFLX66F7GzpGksM96EIYV0apw5ypFbbS4amsbTZSEL+pBZkBeR?=
 =?us-ascii?Q?lmGfl5/pZV0xtRFBGzoduXcZom3mX4ec5Ed5zvY4/nE+tuAwQ1/gO6NVJ6oP?=
 =?us-ascii?Q?dl/mIQFoAl+fURAzIu0jUY9Qc7h4nQRO8GdLw0uvx0kEHhBa+ewZviF4NX0h?=
 =?us-ascii?Q?py73ppZNSBE5f7Tpv0bpI/3ykRKpcKiGOYdMmv9x4sMGFathISjpmdV196cK?=
 =?us-ascii?Q?yhVb7WBZ0Tpkq9WXpReozzo8IBpYFiLpFpszL9xAXy4w+Y3ChxViPIs/DDZH?=
 =?us-ascii?Q?xKkamYrFU/s2VA4uDwwd7VStHa+evgbCVOGy0oC8zGyUVHBXq/G+l7wGodHc?=
 =?us-ascii?Q?6VS6woQ9j0k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cx8wUssgdu7LD+WGn59X9ZS+gBZuGCXeDVU3p7BtGNRmDQyiYRhCQUNtrh+z?=
 =?us-ascii?Q?ESQUVxk46Vu0A0ODmY+2O9A9zIU0wpvZtZgZ8z3aCvEq84ZZQ3hbT+hGbrPs?=
 =?us-ascii?Q?Z/Yh/wBiqrdmqWrx5HWJ6h34goJgpC7fZNBciKoKJvP+JsjUQg4CFumWkLV6?=
 =?us-ascii?Q?n641HbkMyR9E+uNQcEZZCMPhTfW6m/pDXK4hsGeFMZUACQoQEQdH9EDMzk/2?=
 =?us-ascii?Q?15IWOlQ9XdifMlPAJUlyMQ87WSte8NbrGPp/7fqzqIbcMsHJqkviLolL/JkW?=
 =?us-ascii?Q?hC5/13gsPtzSnczdBiAwviYRd1SFpFxhXifaFQwUG2Sv3wg6+PYFsLktloq+?=
 =?us-ascii?Q?LdEj7gYI/Gmw7/9lfE6qoaXrNSmw3NIX/Q4iBQEf83iTdUJeHFrN8udNlGss?=
 =?us-ascii?Q?Fx8x0StJEdztgKAAXSCFwVmZ4UE9fOVT+5bhY11Eo7i7XJ4eImwbvlzCpGUF?=
 =?us-ascii?Q?kKbNbZ4tyAE50okCwDYjmhz9kbS3rcusucO6x4TxLptQTmStCTZZcNu9utL5?=
 =?us-ascii?Q?TKmH++aUtu7Qhb/xwkf7NadI2/r/GKPksrHSF8XB9f1NLcuKlaKLJ07UpbK4?=
 =?us-ascii?Q?Dj94lj5tVuL+iLV0OMju3SCdTCozYnH0wjM8vJVvXdwzVDiUl7NTPUICqapD?=
 =?us-ascii?Q?9GHynXehKlJFt6QvF0uB3uHEkXh1bO1EK0PBg6adITpc6vZkf6NQk80eWDOJ?=
 =?us-ascii?Q?Ex2ldP0NayF3y4f4+1N5WGqKZ5s2wIpGdL9mP8XEdmWNGhRhhfEfqve3YwHg?=
 =?us-ascii?Q?9HF/IG1WOiqbYhfILAsZtuS5jDbFiM/YZD7j4R3D9NQPIIyEsLO7xO97xN+m?=
 =?us-ascii?Q?7Sk8czflwhUFlblsIhR5oftZE4W6bHn4dtqhw7HLwYprJysnjUbE+gpIHwUs?=
 =?us-ascii?Q?3uKTpbWJLeINM+BuWjLU42DbsNCB/Y7SlR5XAaxRIDPGgZW65shqnvt2K5ei?=
 =?us-ascii?Q?JTxP6SJ7KWbh0gxB9+W6RMld9rW7gELN0NDq/+EAGyDc+9Lkw2iBU1VZtwwO?=
 =?us-ascii?Q?MV5/Sko7MFgAjcJApkj1Rm5x9SEN33q5YuS49KXS5tYxqtbYVFF63+YeN+cK?=
 =?us-ascii?Q?nYgiKONOWEdXD8mhRxo1/muH8y9G/q0nQFWzWjYZerGCFv8e7xXAcKSSMZkj?=
 =?us-ascii?Q?0881yfQJN0h2n8Rlr7l3/Z/dJdgOeOhyxtk9X1fcwrem/wQE4T2rwCy40m4N?=
 =?us-ascii?Q?ML65li8ZukOV5wlZ9ZFRZNC/Br8p+GG4X7xlDrPJ8pcPl/hfvXEY/bo47V+T?=
 =?us-ascii?Q?x+gJcBW2YkQVMPXBhcs636uT44TgVHBLDvmZiYL2RQr87Td+PcQsKxxfJzBD?=
 =?us-ascii?Q?geznFKKHHkRIqZBpae8Z0jRzpgJHnNsAbonbWb93HArjsNSbe3fTb1DB3sVX?=
 =?us-ascii?Q?WFZoatHqEkqPpbU/t0Z59yTInZUZCrCkEblFewHEhM611o8yupg5yLlxlOde?=
 =?us-ascii?Q?Uyn7PZTDEK07mj79Z809xantFrD+oNh5VEWJHnIMDS5i7r/n9DhxR8jlLtay?=
 =?us-ascii?Q?1sTJ/qr9KyIJFepDSHHK8PN9H+hfiK3utB6WDuyHmFHPD5nxRa6VQGD0zFV1?=
 =?us-ascii?Q?1j+mcItnBNlVP+F2T8tIUJhnDZaHIndWy0jekJQcONgPJIjdL0kcKMxgaKco?=
 =?us-ascii?Q?3Frlu2CnLPo/o1Dbir3Ghhk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bc51e85f-8c3b-452c-7b7e-08dcc3b48ad4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:45:37.2361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrkxDZeQUddH5Jldfgtic5hQJpfU/exCLJA13Eja632hceUcfi53ygWJ2214VKjZa3Se3HNYummEXfHRN/Qca/LlIL51fsd59ZCvQAIbJJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11224
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
index 7014d5b4f43..f0889d72d44 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -28,7 +28,11 @@
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
2.43.0

