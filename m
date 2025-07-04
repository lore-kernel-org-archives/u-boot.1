Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75D8C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4AA82AF6;
	Fri,  4 Jul 2025 23:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="eHkHysy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B6F82F30; Fri,  4 Jul 2025 23:00:01 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5EF82063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 22:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o75twYAEVo7bocAntw4P2x/JU+ZoT3ALVfymDIMOj122lbNyCoOyCbGSdhMUXDcxpnAwNuTzo/38ok8uDKMENltkgUCzSIZhyOFsh92xbeOL/kV4+FPeO2iZN7GN74pOTfYjK/ehnzlKd5uk2mLOuF4GXLOxK7osnvuLugH3c9GRQ38cGfOHjRdyK5Fzt5ovS/R1slqFRyuvTdI4CXjbTEu4TNoRcQs9ZhwSggYn+Zfnd55omSPIiEmv9QM3vYyvF+qhb5qNjZTEWuUln7yGnXPj8++9Z4lOCNIaBW7t2UXPYV8uJoy7XU9NL2NQLbO1NdiRAJcHgoneqjbNs0DfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY8iS+bTnHt6v8XiFPF4BEaDxuxhFO7valpgWyAHnkQ=;
 b=XBrac5JEEF6X/Tk6hElrm+2YOurnfGLebOHenopb9jpDLH6WjjcWD2xFlIcuP7cKo90aKloxkQvHtQ62z66LasED/8kWYJOFS+70WeN0iHF6o3s4ExiT0/FOOamTWkiS+czrYYBbSHgyeMzV7eLq2/BAvquTeIiIKT45ARGqTgx98bgJOWzYy9QCRG8QgitlNQtebsHCfN2B5map6YvYYb+XD+TvxScdOGmYxlp7VycQF6wvJ/b3TT+zss39jFLq6b2uTwfr8iKhpE2Yxg/HAz/t333KI9Hf2kq2x0obs9DgyLHSAfYB1C86o9qRKAVRNjQt1rBb4nU2zO3duBpPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY8iS+bTnHt6v8XiFPF4BEaDxuxhFO7valpgWyAHnkQ=;
 b=eHkHysy6VAfQwgIzuOtvUAuzqCkE0FNiwPwEOwzLdfoEhp9q3SN5npOSlcmhKcIRD7Hk72YAU5oUb9/FXol8lKEwIUGNY5oPAEjMJuHs4swfdGyG44eIq8qCi5/r692jGyZYpIkOSCmEaOB9X3hMcExctticiiIMpyjPS/AtYifvqZ6s1hCrwHWqFTSuf7R4FPRhL9qhJHtHVmLUqjiS+Y/3zK7UOFxEQ6n6aWhJqWQzwmjpuz6NT+UQ7XKMeD1VcIHJ2VV/HJ4+uMX/IUGzYmD8OmRZHQN/R0lHAmMyHcUO1H/WkFRDsa7yIPwNBcbfdJ1hmakvlGWRAs4N5sIWnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6342.eurprd08.prod.outlook.com (2603:10a6:20b:31a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 20:59:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 20:59:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 3/4] drivers/net/airoha_eth: fix stalling in package
 receiving
Date: Fri,  4 Jul 2025 23:59:42 +0300
Message-ID: <20250704205943.1398968-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
 <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf52801-9369-43c3-5309-08ddbb3dbbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OQtE3vwWPCbTpihwgktXgsGtI+MePsouGitqeOU+wFQ8UrFT9zhU+5JZYRO?=
 =?us-ascii?Q?wT9kVrd+A/ETztoPDwhM131mTEuVRzvXAFNu8kRy0nTVNsnQHvJ19Xk9Q6al?=
 =?us-ascii?Q?i6FG5ZlRUSyGlh+Pa4sAwPOWer+/YDXuIIrNR/4QJPPpVYaOISjoUpZ/C8FW?=
 =?us-ascii?Q?9+xKdSz/2F6+0R9lT9o7XnbCgFYoxto5nfOU/PWZPT/bR1VyEjhlERQ2Gcik?=
 =?us-ascii?Q?aC2B5BBC8us3QsXNZwvDdNM6YYiaTb+Kj6CpJHj7YX1qEFbmO2eOXbrGdU3Q?=
 =?us-ascii?Q?csvd+vnEY84kqW/qm1Hd+n0AczTsKhEZ17D2Dg6WJ5UbAp4vFpJbcs4vHpUP?=
 =?us-ascii?Q?PdnRY7Azofbc3V5KY5cg422eH+oxp43ZaxgUEwyFRap8iWLaOW/efgswTE6j?=
 =?us-ascii?Q?E6M07/inx+5lwwcuhmIRRz/9uMhnXnaWK7DWqQbzCFJrjG7/feFdAtOsfHRc?=
 =?us-ascii?Q?ja/kejWq1aRx5RUZ8yUXiEwJSDnmvKMJ/h+REdSWjBWJdH8coWy9tdIsweaH?=
 =?us-ascii?Q?rxvxQ98vH6IrzCqgnknSXG0LOK+jZOWZmj7v0ZiqoryIjktDDNjoa8Sp1dnr?=
 =?us-ascii?Q?bPQAhlLsEFgq6twrx/fJKUJ9jZ0iCz3IIBnS9MtAY+0ajwbx6ut9xve8+WtC?=
 =?us-ascii?Q?4zzpGovThpxt0/h0GDPPqMw3FKKA1kQVqy+VT8jCTmwlL64c9i1zNUg31/kO?=
 =?us-ascii?Q?c7MkH3S1/R8WzUvGvxbJ5AMDsCcF4genpRhoHBKj64YJgTea+PMyGjOdE/mF?=
 =?us-ascii?Q?HqwjZJEmDQkPy3lPyM5Sti/7zy5+937z4HrK8gTTefJdGmGIbeyeZ8oaG2Ql?=
 =?us-ascii?Q?/arw/UsY+GrqgFuVxvVopb9uJIOCSvxkZTiUed+6Ic9q38bDpKE2fm408ENq?=
 =?us-ascii?Q?lNMArr1jr+aar0hRvdyk+X0sRNsAtc+uxGb2nfMdPQbUvMp9OjuAKonJNsiw?=
 =?us-ascii?Q?yFzpI9oYRTlRERHfYLscqh9/Mxpv/ZnRgbejkoRYegyj/bg8NQb5HU9YmtTl?=
 =?us-ascii?Q?awqPTkl1F/vFaxVq5gqR38SUQIm/oHIf0ennFSzUd1LBYHPzx1LZeEKgcXeu?=
 =?us-ascii?Q?9hT38spjgGOqT0v5iAyi75LuLDYJog0P8Kf9o3jW1X0/6n5FI8up46Ub5BDG?=
 =?us-ascii?Q?G8v9vCPplMIPVFH0yYE0hLbJyd4g+zq7t9iY4QuY3N3miJSGspbA5cBo/HPl?=
 =?us-ascii?Q?2ra+3x8ReTP9r1QfQUROMa7Of2MfGqSu6xiXVhQgtZOacouVG5+5rY9nY1By?=
 =?us-ascii?Q?6DrY90IfH6IeHv6mXQb7PWW7u+ONWRYsrlpYtnFeZndt7YeUwSsVA2hLlsS0?=
 =?us-ascii?Q?3+39p8qPDsZ0ImTzvQoqVeQrtbRvrR4McTDFr08UqgnVXN4m1QIsvddHOyhk?=
 =?us-ascii?Q?MWTQTTrCGKa4VYeV1A1iXEZDa/5fpiyOYscUXEOFJWWQebzEYY75SHUYce4d?=
 =?us-ascii?Q?y3h4LHxfZWY1HP+9lRMsG303xQ2LAtEOK3s6EjjbeAZOOsFiyWT/Hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/pGGyRSb2DwMSH/0CTultCplESfJS2f5bgcrn4p5kSQ1lHpLAWW6L5uMFfUQ?=
 =?us-ascii?Q?jTAJSwlDO/0VOW70owkY95t3MP5YAR9YOBVak8BTF2ht1Yw121yNvEQOc1K7?=
 =?us-ascii?Q?fyECveCqmXjavKEGFEErqBxqJEGQp/WveK6Jr5JxuArzjIw8890xDm1HqNOP?=
 =?us-ascii?Q?L/KKUA7UH+VOYvSzBhB9EE9b8i6JaaTmy8MFy1AonO7zb2EYy93oMkHkaQ9m?=
 =?us-ascii?Q?A3eUY1Bxf6FJECopbyuieQC64zouq5dlNRyQKs2HkLDrnghjAIzu/D40PPdf?=
 =?us-ascii?Q?a1IyNlL9fkqLLaUKSSHMs/knHj+UB8XmIsrTxa1fqxkjRM67rpe0HD/aA5rH?=
 =?us-ascii?Q?I/bsY0kpDqu7oNqIUXFUpDo5tZamqaiwS0Z1A+E6J+OGGR4ASoVsObN5Ik5A?=
 =?us-ascii?Q?SMOz3u4c8Udca2gCA5IB5bH2SpvNLMtPQA9dVxKIOSpiVceOM1k5qold++iW?=
 =?us-ascii?Q?sOYtnzKgUNe5OP6Q6UklBjTFZzKSSwgSsFsKwPx7eVFrta5gX1FTpsXwj5Li?=
 =?us-ascii?Q?laa4qj1qg2tuhBtZvosVkD8AfpZHDgFHhHdRa03jLkuSiq99PTfIU189WsY8?=
 =?us-ascii?Q?wtobcNjPKIYZcsv4/XCmRxaH1rsJ0RK17NQArAEU8IRz/r6TIIAZ+RmOhOJa?=
 =?us-ascii?Q?Gj0Bo1zIO7JbRzMGr2ZokyNo/vL0CWSrmzA0eoKhnZszLBtfLKnSoRp+NOqD?=
 =?us-ascii?Q?0MzQvhjl7ELVFmxr4/PEDux1xDsFMchAk9LLsao5GTL2K2YWQO9X8bE5wO2u?=
 =?us-ascii?Q?6LALfy83BdJIBcVe1OWJuFrhwVKy34+dBj6U49Bm2hAMxaBXzx0xMgbFzwvA?=
 =?us-ascii?Q?MELBe13DX1hZ5Sqsie7s7/A+6t8Q6SQFDQMtaw8CBWKNJ+jYrdlxfNUvc/b8?=
 =?us-ascii?Q?6thU0zaSSBZx3jMQOzmhzRF6om/WHGs6pfsVLF+o01w7Hm1GkozgsMHB21X6?=
 =?us-ascii?Q?E0pYlIzlxca3fx7VQYPz9yWfLDyWuo4yaMmHo54v0EdVcu3C1Zp1bx7g4eQs?=
 =?us-ascii?Q?nR7h/mCHlQZL9EMeMm2L1lZ+TCE0Kg5Gr/7W+le6pENkDg9u0tpEpf5L12Rp?=
 =?us-ascii?Q?p3tkUQVhmDbHzaukNJJiGA9qxxbqzRTxCE3yaJbi2VqtyXy+XcP2f1pAm3qX?=
 =?us-ascii?Q?pMDAOfD5wGsU5EbWLm8SAgbUhsJl5KExsIPG+RYIbXtruP3e8wL/zaI7/67m?=
 =?us-ascii?Q?DgIKHvW1ZgxR2q4+86clTDi7j8KTSiBqOdZAlMKoIH6poQh/MzsYmpHXTFAU?=
 =?us-ascii?Q?OUj3yXxbznT1bLpkvZxuhzOAFZujYnmdLkwFwlHMktdy3TS8L4IERJA2mgAN?=
 =?us-ascii?Q?7f6Dg4+ffGpfbEgcTr6Zl+2Mdoi9tCJLutdsf+F/pHb2BG5PLsLD3RRcPFPO?=
 =?us-ascii?Q?g2s91egH93DO/5/g2mCW1wVwa8usbNvh18X3i6FeLvsHVahWKTTW72bdZbMf?=
 =?us-ascii?Q?I7Es9qgiMqEz8HBtA1ci6wmRepD+aLj84Z2KoAegq38AgB0j5EvwltF1OfdW?=
 =?us-ascii?Q?S+0DAHCeLGGxTrCmOyo1o9Y/Xb+7j5GKyfK8nbbkkUTkRzYYvNeJQy1Ciin+?=
 =?us-ascii?Q?hI0CDwhDomh8jcrsQePSLAApGzqhjlIPiWiOprhBjFwCP0VrQVUi1RvOOJoJ?=
 =?us-ascii?Q?cf4ISzOb5qqFVdH2Dqnt1DU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf52801-9369-43c3-5309-08ddbb3dbbda
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 20:59:57.7694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVkSfr6UaqR8XHN2oNIrNV+MkwZ0EGxTUBPw1pahQCwywQuGmok9fMi78oVv1Z8E9/h3FgkgHcqozRXhngAjhFomfPikLBvb4oq1WhPd/7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6342
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

ARCH_DMA_MINALIGN is 64 for ARMv7a/ARMv8a architectures, but RX/TX
descriptors are 32 bytes long. So they may not be aligned on an
ARCH_DMA_MINALIGN boundary. In case of RX path, this may cause the
following problem

1) Assume that a packet has arrived and the EVEN rx descriptor has been
   updated with the incoming data. The driver will invalidate and check
   the corresponding rx descriptor.

2) Now suppose the next descriptor (ODD) has not yet completed.

   Please note that all even descriptors starts on 64-byte boundary,
   and the odd ones are NOT aligned on 64-byte boundary.

   Inspecting even descriptor, we will read the entire CPU cache line
   (64 bytes). So we read and sore in CPU cache also the next (odd)
   descriptor.

3) Now suppose the next packet (for the odd rx descriptor) arrived
   while the first packet was being processed. So we have new data
   in memory but old data in cache.

4) After packet processing (in arht_eth_free_pkt() function) we will
   cleanup the descriptor and put it back to rx queue.

   This will call flush_dcache_range() function for the even descriptor,
   so the odd one will be flushed as well (it is in the same cache line).
   So the old data will be written to the next rx descriptor.

5) We get a freeze. The next descriptor is empty (so the driver is
   waiting for packets), but the hardware will continue to receive
   packets on other available descriptors. This will continue until
   the last available rx descriptor is full. Then the hardware will
   also freeze.

The problem will be solved if the previous descriptor will be put back
to the queue instead of the current one.

If the current descriptor is even (starts on a 64-byte boundary),
then putting the previous descriptor to the rx queue will affect
the previous cache line. To be 100% ok, we must make sure that the
previous and the one before the previous descriptor cannot be used
for receiving at this moment.

If the current descriptor is odd, then the previous descriptor is on
the same cache line. Both (current and previous) descriptors are not
currently in use, so issue will not arrise.

WARNING: The following restrictions on PKTBUFSRX must be held:
  * PKTBUFSRX is even,
  * PKTBUFSRX >= 4.

The bug appears on 32-bit airoha platform, but should be present on
64-bit as well.

The code was tested both on 32-bit and 64-bit airoha boards.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e18816b2943..477a132fb1f 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -392,13 +392,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	return 0;
 }
 
-static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index,
-				      uchar *rx_packet)
+static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index)
 {
 	struct airoha_qdma_desc *desc;
+	uchar *rx_packet;
 	u32 val;
 
 	desc = &q->desc[index];
+	rx_packet = net_rx_packets[index];
 	index = (index + 1) % q->ndesc;
 
 	dma_map_single(rx_packet, PKTSIZE_ALIGN, DMA_TO_DEVICE);
@@ -420,7 +421,7 @@ static void airoha_qdma_init_rx_desc(struct airoha_queue *q)
 	int i;
 
 	for (i = 0; i < q->ndesc; i++)
-		airoha_qdma_reset_rx_desc(q, i, net_rx_packets[i]);
+		airoha_qdma_reset_rx_desc(q, i);
 }
 
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
@@ -444,10 +445,14 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
+	/*
+	 * See arht_eth_free_pkt() for the reasons used to fill
+	 * REG_RX_CPU_IDX(qid) register.
+	 */
 	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, 0));
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 1));
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 3));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
@@ -906,6 +911,7 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct airoha_qdma *qdma = &eth->qdma[0];
 	struct airoha_queue *q;
 	int qid;
+	u16 prev, pprev;
 
 	if (!packet)
 		return 0;
@@ -913,13 +919,24 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	qid = 0;
 	q = &qdma->q_rx[qid];
 
-	dma_map_single(packet, length, DMA_TO_DEVICE);
-
-	airoha_qdma_reset_rx_desc(q, q->head, packet);
+	/*
+	 * Due to cpu cache issue the airoha_qdma_reset_rx_desc() function
+	 * will always touch 2 descriptors:
+	 *   - if current descriptor is even, then the previous and the one
+	 *     before previous descriptors will be touched (previous cacheline)
+	 *   - if current descriptor is odd, then only current and previous
+	 *     descriptors will be touched (current cacheline)
+	 *
+	 * Thus, to prevent possible destroying of rx queue, only (q->ndesc - 2)
+	 * descriptors might be used for packet receiving.
+	 */
+	prev  = (q->head + q->ndesc - 1) % q->ndesc;
+	pprev = (q->head + q->ndesc - 2) % q->ndesc;
+	q->head = (q->head + 1) % q->ndesc;
 
+	airoha_qdma_reset_rx_desc(q, prev);
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
-	q->head = (q->head + 1) % q->ndesc;
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, pprev));
 
 	return 0;
 }
-- 
2.47.2

