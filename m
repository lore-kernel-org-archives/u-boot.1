Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB68CCF6499
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 12:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B85488953;
	Sun, 29 Sep 2024 14:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZY5LkidG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E60288960; Sun, 29 Sep 2024 14:54:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4C38868E
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 14:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9xdWVQvQ7lCUABwAtmpmS63m0Q4nH/t76tWc74tp1SdWoMPe/NbCHj67fWFaR7OfuPAjTrGhNyrrnTqEaC6cUxFRgoWz1RPz2x/sLFaJ6BjhA8ijbXDF29XuGWAmifRQYNT9cZTqVn+YkK6ESbiRY638EVMAOGJIjOtNR8P4VkpkwosCSDHV/wDAYUk/QKPnEHxYL0CZqrmFdCp+bnR/f1FwYmyLwHqhymDiIwtMilBgblP/3SRqIh6n6LlHohwaWJWEHx5PKbDYA/VYXrCW9QSZjKwZaB19kW/T/CWmYQVZVAmjlPwaYB94o1r8p/e66tyDteYepT6NBIldXfSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZnL2yD4Fr276Y9aIlEgXGqGb0y9k4VQxDTQET8/R0U=;
 b=GoZCTpD8z+NcpdqIelQa0aPrgtmgGxJi0wieCFhBbSYQBumj1UyGOprO6X1/wJGV0u4At97ma8p0JintWdr9VkNwK0IIfTg4I6oJTKx5RkrsiV0BU1wvVZdfMGJULwMkW8EZ9/6TiVDEq/WWvS/9yJbbvuMCim/mu/WnGZrDJoy9lTq/I76fPcc1bTRFQXAlZsPsBfiFutqA+nypkHwnIm3r1fXa1dbVZlM8J7QfVQPpo63VSpy05dZVV/+aFeC6xpjWuf13T3k7c2L2PIPxh4Lvg3vA3jt7TNV1vyE6bXBMLD4IhWTsuA3X5tKSWqnNa6Nw9irWgMGzJk97rpMx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZnL2yD4Fr276Y9aIlEgXGqGb0y9k4VQxDTQET8/R0U=;
 b=ZY5LkidG8EmeZE+OeaUAfHnBjnMChSt+fizP5kEKQYf4tmUH4xam9aYz28IjF7jJxizxb8GrhTDrno6qo97ohsRLy65YGtvyf+LE13M/dWrTeyhs3Rsux4RqSUanAggXaM0gIyKTpT/ALcQLKwXKwzwepAaR6luM9+sF5M72tmSfZqBJucwSVmaH6/LXudCE6oSuT7Rylbf8Vivs+IXBcK673L30s9j0MZg4ZNzgq+ZMih8IH/yK4tdWHIWnmoWfCX+N9Rvnqx+VZtk/IHUGlDy5AI4VpgbKZYoUFdsFpqAXnjk2PwsZj2vGHzuU0WSUG71HOMA6OztToPNu6InL2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 12:54:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 12:54:46 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com,
 Alice Guo <alice.guo@nxp.com>
Subject: [PATCH v1] mailbox: support timeout when sending
Date: Sun, 29 Sep 2024 20:53:42 +0800
Message-Id: <20240929125342.2758708-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: eef39bf2-b07d-41d6-be52-08dce085e594
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ECvNbAZCAwUdRY0d84+CcKjrvzGu3yGXATVD/D6INNmfIYbkKgMVydizMsp?=
 =?us-ascii?Q?JXz+m+T3Qmt7t7z3YJqzIAVQ8UdQpwK/pQvDDnUkTeZp6+qD2EX5s2IfXYYy?=
 =?us-ascii?Q?jDY0tsakpCz1Kz+qG3UlNXolinOR0pqO1uR0QKVzP2ydGfCRZI5hX/tViyoW?=
 =?us-ascii?Q?19AvnLPiGBR+nGncUOEup0oWLhTV8j1bgdp2cJdLImp7F0NCxjd4pbMyyaxo?=
 =?us-ascii?Q?Ejt4P5ag9QxhpyqSwhJNGZtSRBXwJ7KAKfbic6IAlNdtP1MFFWzudzZbK+5G?=
 =?us-ascii?Q?OD5WiFOHCpM/en5ZVF1yW49jPEWglfvJaORM/moy+OgnLCwQ+s4Si6aNfNio?=
 =?us-ascii?Q?EBD+feFWlOL+jPtpgkxKRPejRjJMxEQ9bK5gZZyFPo1cKW8hSnTWbV3D6uvj?=
 =?us-ascii?Q?ykGkW2wF2jY6Zbp7NYSkRl+siE5I1HNTSTYw4wavL61FBsr/y6mp7Rx76uFm?=
 =?us-ascii?Q?i+DHM/QKFR0q6J3R+sGiXdyDHBlEAOo7YGfiAgL0jU43tujgMhaz+N5ak8Rp?=
 =?us-ascii?Q?1tU1ueOzIonBCBFJ1/MJbeEH2yBDnwNRw0TtAgsguDKzGoTSiW/CepXD12xx?=
 =?us-ascii?Q?HTsVotTO4FFohmtVMSAhecbGCS1Yr5az4AjebKKgCnWszhy3rHHBJw03GRKL?=
 =?us-ascii?Q?RMrUfeCj8jfWQWY3gESIgRgavjchUqkuVKxjbsSODUEIcu2NyIIVW0kIzDGQ?=
 =?us-ascii?Q?8THAmAn5XyeV6XHeQDYhUYDh7KxAgEgTT9bjEp+Rv/EIqkyC5aVnHMsZzRb1?=
 =?us-ascii?Q?umGc0SNNoOK170uoc+YHaOqtMjZehFILT1YF5BrUmoJEuJuLB65ZfFJLt2IZ?=
 =?us-ascii?Q?wFQYs49yZv7sMwlUO59vXAv1I+bVofqBWDWwDti2Mj5bseMBY/s20Y7/AaBJ?=
 =?us-ascii?Q?fwXEy23Ula+O8iubHSvoD5V5Rgl6dhi8+NdJUg4H8d5Ky73R9c8StMa4plH9?=
 =?us-ascii?Q?9XkvCk5iH/ylQGUoR9PuEFOuoju0gWQUSvAkzj5QAwU+gWweJ0mJ/jxQAsoD?=
 =?us-ascii?Q?tfmv2i/mr5/YXMJuFFtyDP2OA0RVD6mSzH/DoaafSYwFsTwaWGkWD1iwmDH2?=
 =?us-ascii?Q?zRuaPtYRTaqvVXGUOkOHg8VWWY0g3Hb5vC/dVUgl/RuMltCRPkX+S1OlDdNE?=
 =?us-ascii?Q?OqBS/ThptXqGGj7MSCVd3nE1iHSTmPzbTM/uglO1hxQ7s3J1rsIeIQJgVOoU?=
 =?us-ascii?Q?lbPs4x8EXTLMF1Rgh43f5KFXFM1CentC3V8vbExfENXq+dGuPFRVq0Xt4hM8?=
 =?us-ascii?Q?DvyjSPjMoTj9MIoq2sV8Ltv2ybdcWe3KIR+1UhKeTZiPcAOMYyhJXZ6R3kzJ?=
 =?us-ascii?Q?qD/Y9DDcTItfr2dgzfL8VJql8jaUCuTl46m0cuRRmLVkOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/utbEgao6sbit8z2KPMpgn8fXwKKDgYYGLPLft3EO4XJoFF7Z95S36CEiI6X?=
 =?us-ascii?Q?icImcIR2DuM7SX/ztSifgPO7Ry8kvGHGQKynxvobqdvtTXI+xfA1ZsZR1I3E?=
 =?us-ascii?Q?tu+ciwJ1ynsY7/nz6nDuy2Vpfy6EgKZHAQHgoRYlv5UDXCJlucU5ysZcryA8?=
 =?us-ascii?Q?AQDOpw5UBdFTttiFx1A1M4pccrHcxEKJmg1sBiogN/MIJbBoEpzKW1Y4uYZ/?=
 =?us-ascii?Q?wFQ/5vkvEYMzSXQYIMtKRGDQK6gJOJjGVChYl9nWZE4whXW9jkR7R0DEfw7e?=
 =?us-ascii?Q?DcBTmqfcBmCfoaYnZHLbKjg9iuBSbU0WNXgrYC6/iaUJJsC29ZyF48QPsrHg?=
 =?us-ascii?Q?5KO5yTirQnrj9NaUWzrB+Byfo1WQwiCeGqsAvvqfGKWo28QG+jMlMOH5iz8+?=
 =?us-ascii?Q?bso4m5QiB7nlkGpBaJPDoCPThoQBy9PEgfhIHntVNG2S2+be2qDL7cbcbXJl?=
 =?us-ascii?Q?ixSLRLmI8SVKogwjlLDKRUMToTSymXY15lQ9aZbm+xQx+pZZ5LRv9tYZdmub?=
 =?us-ascii?Q?QFgUXDXLrlZmKGB2heTC7F4usw2Ng3z+4TH/+av9UbeXtrtXq680GIG7LwLM?=
 =?us-ascii?Q?uPkgC4ZxIXlVUhNlZATXhlH5IR1aImB1ADEpxXPMJNoCQjhzW/UgFRJJZL7J?=
 =?us-ascii?Q?mbUvdEN2afe5yo1FhpU1dSi9Y/BLE9yuEh/xtmHoSCS5XCTDwaGghlc5FLsk?=
 =?us-ascii?Q?g42LR9Le/AfWzTgpnDml6tUpUTdBbD3rtLP/9gxAxlKUQgp8yeIrXYOsU7nP?=
 =?us-ascii?Q?md4TnTB+6Mc1eR0qJAuit+rhccTMruWAqXr/WEM0y78XcxdAdO0/nYaCy0KN?=
 =?us-ascii?Q?+vJnTsyV0OHwK9/kdXJDtG3FOEDFMRQwYEvKY2Ko1pwbdvjUlJc4tdGR6aaw?=
 =?us-ascii?Q?QDi32pTcjYg1HpgDfbuUx+FknI8ZbGsqtTYBWJ4OUh3FY2H1UteHMoIKYBag?=
 =?us-ascii?Q?PBhNbcvUcpAOZ1cJJOginBo9tOsS91JObRxPlV0Gy71HUoabBA/NgaaEOK16?=
 =?us-ascii?Q?8G6s7fe2Fke211e9npdeKZ0cTHl16aroX/JYaPi3jGdPUFWybAmtIydcq5L8?=
 =?us-ascii?Q?HwzFzS/WtW7mAtvNFwsqwJ+cSnu2GTzkN4/gF6oTqv4Z8laKWEHQrXjZdkSt?=
 =?us-ascii?Q?5uI/TIj3K4b1oa8UuzcQ36Afo/3HZluP5NfG4d2wGKDM5mYbMs86HUMd3PBt?=
 =?us-ascii?Q?KHSzTx/SsIJ4B6wvloPbYi7xzi/kUV5kQHrdThprcqMpuFsNDBiN8ORfEnUT?=
 =?us-ascii?Q?2Wj/cgd+AVj57wEacUr5q1DWy+TTxMdgNAmgIwX/EqWHkjC6d4pIdpPkXF/P?=
 =?us-ascii?Q?Mxueb+L2OCYe2MnAT7qUZ0ZZqGG/Fx0o6mFxtTxhh6D6Yn4TQkOatSip46Ms?=
 =?us-ascii?Q?0vImmzaB1vy1Z74o0SZH8KzP6UqkAHEkATpMueUo0jFl2BypJ9gEFtzAhO+C?=
 =?us-ascii?Q?TYe/IBhaseOTwRpNv+KpZnDtHQc6UKWxfE9EHQ9MmB8Rxi4gZVEMwLrEfSLq?=
 =?us-ascii?Q?Ml+6/XOpeIi5lsJ6SIRoBUluuCOdUQiU+zaAtK3+vh5jT4aET+KYlNqxq0eJ?=
 =?us-ascii?Q?NH+P92tzfLacnxjt5Om4gglx+kRgzdWs3KBrs+2x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef39bf2-b07d-41d6-be52-08dce085e594
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 12:54:46.8890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p6ZinaXfV5BINYyQJ+UWaKgJyNCjfXKGIjxCE3+6UqkQLPrZ9EeL+kYBB257IPUaWkIunae1x1hDGpzBfvVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387
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

From: Peng Fan <peng.fan@nxp.com>

Add timeout support for mbox_send.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/mailbox/mailbox-uclass.c | 19 ++++++++++++++++++-
 include/mailbox.h                |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-uclass.c b/drivers/mailbox/mailbox-uclass.c
index 4bf4987ce0..0ca8b3770f 100644
--- a/drivers/mailbox/mailbox-uclass.c
+++ b/drivers/mailbox/mailbox-uclass.c
@@ -117,10 +117,27 @@ int mbox_free(struct mbox_chan *chan)
 int mbox_send(struct mbox_chan *chan, const void *data)
 {
 	struct mbox_ops *ops = mbox_dev_ops(chan->dev);
+	ulong start_time, timeout_us;
+	int ret;
 
 	debug("%s(chan=%p, data=%p)\n", __func__, chan, data);
 
-	return ops->send(chan, data);
+	start_time = timer_get_us();
+	timeout_us = chan->tx_timeout_us;
+	/*
+	 * Account for partial us ticks, but if timeout_us is 0, ensure we
+	 * still don't wait at all.
+	 */
+	if (timeout_us)
+		timeout_us++;
+
+	for (;;) {
+		ret = ops->send(chan, data);
+		if (ret != -EBUSY)
+			return ret;
+		if ((timer_get_us() - start_time) >= timeout_us)
+			return -ETIMEDOUT;
+	}
 }
 
 int mbox_recv(struct mbox_chan *chan, void *data, ulong timeout_us)
diff --git a/include/mailbox.h b/include/mailbox.h
index e70266fb61..3cc64f20b7 100644
--- a/include/mailbox.h
+++ b/include/mailbox.h
@@ -46,6 +46,7 @@ struct udevice;
  *
  * @dev: The device which implements the mailbox.
  * @id: The mailbox channel ID within the provider.
+ * @tx_timeout_us: The tx timeout in us.
  * @con_priv: Hook for controller driver to attach private data
  *
  * Currently, the mailbox API assumes that a single integer ID is enough to
@@ -61,6 +62,7 @@ struct mbox_chan {
 	struct udevice *dev;
 	/* Written by of_xlate.*/
 	unsigned long id;
+	unsigned long tx_timeout_us;
 	void *con_priv;
 };
 
-- 
2.34.1

