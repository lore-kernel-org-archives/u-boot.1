Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55344C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 09:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E00834A3;
	Wed,  9 Jul 2025 11:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="x5Vce/Qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6BAA83423; Wed,  9 Jul 2025 11:28:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3BC83447
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 11:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwXOCf5tLFKtJiLwUun4LtJ0Vs/6uIkt37AyPI9wluRpSQdOBlLmlp0db0teM9wp3wi+1cGOtHnU3rqHK2OQBeksdjYJWh/Cdj2esimBsyB+hicNjO+yNI7Zy/7TXscY/szval3cI/EgLJev5QALyxPODTdpiKEWWNewhFS8/qqIg//2SI7XM37g0x2WnN9wsLnyv/cHA+ghU+UK4ImCTBthYqGTHJ0LE6/+guUGzr6MmMZUofhxyOgOso8DNFfVz2kRqz0z3HKunO4pi16TTtmrvaSoKuPipWVweWz1+VS3G1BufcPj3n7Fwjx/B/WKfUrslX2DMXUxU4tX6DaEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY8iS+bTnHt6v8XiFPF4BEaDxuxhFO7valpgWyAHnkQ=;
 b=mb49tnN7UdvOJZ0X7GWNnw22Vt6J9U0rJxS0e2ZMBX5ytjam7jjAZRTDIoq0b+PS2SRvToHgEnsj6unbmS87t9jMpqPt6mnHoR8b4fioVlUDHkvs/t8oHuKoRki4+NYjtVkda0YuxntWCFdeVhrOmYF2WOPKAqWoPo4sjT6BjBirjWZgKGviBZWG8nBxRGftb3cslYdleSMy4iT1WZKo890dV7RJscpmhNSySakEi70XoKDl/cL2RcLQH6rAr55UWikcW0SS/h3WQOVm5Ef5MTEFXje4FGkLSfEtwTb5FiVoFxYs5BI0BwB4MlOf1DeKm80jb8XS8sF9V0qjbjCfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY8iS+bTnHt6v8XiFPF4BEaDxuxhFO7valpgWyAHnkQ=;
 b=x5Vce/QdUxKRGkrap68vfpBQdofX83wl3L2agW54+DYmp6ELVp4XBFm53jxrfn60AfwABm8lji5TfYnPYJujbfgAbC7J5Mbwdu5iPhV4wDJ0vZoOhX3bIy4cq1B61KeoItY/ein+FBl6FahW1tLpFWgXdKHTbaZlEqpNWN42Lg237ciRNDlHWh2AD0HX5Xs892RWKdqNVGZki/L1qaLnQoEr+IEGp+d3AGv+linA9kiUnab5j/xRvEyRcaYwIi4uofHts0a5xd0RzEM2eCOoOWXY7HjgbJPKG9hVpO5Z8EXgCyPUhPeSRElEXff1j7LbM6FR+ZCmCM75MPGi+6hMdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10805.eurprd08.prod.outlook.com (2603:10a6:150:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 09:28:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 09:28:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v4 3/4] drivers/net/airoha_eth: fix stalling in package
 receiving
Date: Wed,  9 Jul 2025 12:28:09 +0300
Message-ID: <20250709092810.4032971-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e982dc-038d-424e-5458-08ddbecaf32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vI/zmZiI3zrtFq3XfB9atHyAS9Elcnh/TZjMEbwUshcos9POSnaN+fkI+qCR?=
 =?us-ascii?Q?rRlHEEqI2HrdVlzeAKx6mx5J5j9X8UJqGQZq6GNtTMaut+55wRCj7c+0bpr7?=
 =?us-ascii?Q?3VdBudUa0sVSz9ljdGVQUjkz3XDPTyrRV15d6vfWbVT62YuALhErBVeLtn+Y?=
 =?us-ascii?Q?srPmxDgYE8s3iHTRwFwBmZFMDNX989HPk2frWsFdT1vARkl5YlDHhK3wKZx1?=
 =?us-ascii?Q?6Mlmq6lNwJ/FrYBySdQdgQ+ZoBDXOjnfVEy0lrqIcE2Dgm78+hLaGauvdecr?=
 =?us-ascii?Q?8+1Vm1KY44+Vao54Hd3hU+cFqc38SWvOItClsVom8BO2flqp4rrNn2h8dGKO?=
 =?us-ascii?Q?y2mFuSs6SY18c947YPgD1+8M4SBOMvEct2Pj1tfU7OJ0NeqA3f7xNr3RsR28?=
 =?us-ascii?Q?2mzMJv+nmZI3/A33tnJoIlTrBKf3j6uP2QZ1CiG3Qm/S1OEd0Uln8k0nkIjn?=
 =?us-ascii?Q?7fj6P81H8vDRMguWCBO8uZlNDltPXAT/5GbfIt3gT3VMU0yndknpHAqued6b?=
 =?us-ascii?Q?KLm9baknPauNq1tpt/qaCxS7Bk6aSogAk+hcsWZR9oujoclETQ9ZrQ6ZAKrn?=
 =?us-ascii?Q?krbigx1tfTwNyBjrEZ9LxZuNPfmxwtO7H666BVQXmgmrhxtSPer81uyq0LnN?=
 =?us-ascii?Q?Sjrp/jV7gXZN4qqHKzTFeX48ARsADqz0CR+p62fqqoC9uqtFPZeOjipgiN8j?=
 =?us-ascii?Q?lH8H45JiExi1LvnCMV1McE3gM8elAOfbSa1uAHKE/kqH6gMGOYLn+Dke3RlU?=
 =?us-ascii?Q?yaViAYiB7FyILVDbf8DN/+BgIjnHAnkKcWqoDZoJvknr5FdIPszFJ7TfI2Zy?=
 =?us-ascii?Q?jVq497aX8IPoooA2gEcIR46dA/Rz2zalSaJ04zQW85z1cvtirDWhPieKvX77?=
 =?us-ascii?Q?kJcD0g+lziAfYqTJx6ElGVdDIsf8e5CKEnM+JDwbmBGQ6WdxAbaegsO/zckl?=
 =?us-ascii?Q?8v/5einKK4PCMGANiNSm76nh4ymU1t82XpPG+dmOnFBOG+nxhno27qkOgNn2?=
 =?us-ascii?Q?II06miD01nd9PXq98h0m8lawU8wg+6bn032hXMNHu5BLG4Lkw6n5YGUMGYNu?=
 =?us-ascii?Q?JH6rBlJILVzvII7jkbX146sZnOTsEM/GNppxKG0bvCN8UzFmq4cyUtVrk/0g?=
 =?us-ascii?Q?DTHRM4wVEUjoWvA1smochuTbGaJpXveGDi8PKKHjoN2mfUzApOhJ0KkyxrnP?=
 =?us-ascii?Q?0luX0oO6i/1l+j0MIQCGPCYr9TppVKV8nPmvoGvUNa6IfsfY06FB01H6sT1D?=
 =?us-ascii?Q?s6ZzQHNdJIO+gee2/AZX6KpNqkZLF0+hZ2tp51xBc4JJj41Hht9U802xQ3LY?=
 =?us-ascii?Q?tpSvM3aUMo3DE29Jyk5wZO4z3EE7nfY3z9bGFQeXCcaRj0qMSDisZtu9IH5v?=
 =?us-ascii?Q?jmBIVzJJXnK/19G9DTc2v5R448oDTlj2+hcibfOtbg7BDQftRBydeBOB3uMa?=
 =?us-ascii?Q?WbSL3QAlE/yjPtxPD+w4oZ6kZSlNlCP8A1ITfTXf0Pis+ox27TaeMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOPUC0vFMuIQAxg9FRbv1nAhxXG9g7Z0jRhIC+v+t+ZAPd13+j+48OjMbQyr?=
 =?us-ascii?Q?7OsbcJaEReyT6tEu12vm3n5GzwJJoKWlNrk71b6gt503u4ITBcYjCks9bPQW?=
 =?us-ascii?Q?yu5vMXNtu4wjo6oEMbsVpYwH1Jon05WSJ0FAAslESqJ3voofjU3Ultp192Ed?=
 =?us-ascii?Q?ljR7yusTl5mr6/HeZGxfytu2UIuGspF33SV3I3N+hDpPexvx/utUkHYuOPnk?=
 =?us-ascii?Q?O9iE3h6fAnbQv9NJCNGJK1T2cEJHj9ywJMfRGsIqtxhpSUWDY4esVzI9Bn3Y?=
 =?us-ascii?Q?GmX+Ug34/8PVlJ8xaviqLOGZ9n1Fz4EnfTs2huNNJt21v0KZq4gdeI9TE+Pf?=
 =?us-ascii?Q?Wy9sCeOSolRIOVulhie29nVoPmH112MxwcaYZiTZ8IdRiVB4iLWHgBnjW49E?=
 =?us-ascii?Q?PasY7eveSMAnvqGOd5p8pazlihyb8Gbf4MG27IaiLxgPwz7Kb33Vf/oI9KaM?=
 =?us-ascii?Q?4wMNGDVe+Crh5qVkLbtppf+6xAd5PcxwAIZj107Mhb5zj7ncrU45AXpP09DQ?=
 =?us-ascii?Q?MuqqKOqXHON9bM5JYwlTa29gs37W4/qN37C/s21sk7juRSq2T6sV3Ucl4vbw?=
 =?us-ascii?Q?tv5JyX5FR19qZu4QlPRmfEu/17pVNVVGeCiQH23XvfA01/kIVgWTIR4YR34n?=
 =?us-ascii?Q?PtGJGSJ9mLDe/yK9a5i6oYT8NOHtSMzeQ8iF+ATkDsLniQYFP77ALPMO1Jju?=
 =?us-ascii?Q?7AxKAilb1/UXFLB++dbPJ7BL3o2HbcbNc8TsmK53DLC+Lnly4IbTKDaNC1pD?=
 =?us-ascii?Q?+yO3LLhbdZNdWHet5G+Mqw9P4enNlHH/kA8lUERNZHf3oMoBfAr9jLCsay6H?=
 =?us-ascii?Q?G1+IVg56EdBpp8a00ROuyNeLAP7yFcbXr0OaGtQBPBTulk0OoXDHEmW5K1lH?=
 =?us-ascii?Q?53h7kcRS6NoR4t+wqIcMolTQH22pwWiaTJMQHwg5GETg/gDNXMTZSEHPUsmH?=
 =?us-ascii?Q?PyrixC9VVrLh9y03uFMIBhM6Soffe5Ztv+LoC88PJkrSZsdBca8X4Ygs8snm?=
 =?us-ascii?Q?zi7xAKypmjOEnhNpGMqkSycptX9BuQMsdBQS1ZmZTaCyrYtw0M3wiVmDdIuh?=
 =?us-ascii?Q?IJAaEcxiWDaLqvL/MCl0wHVlcPGCE++IHfohpvQXoLJQW/F9Ye0bkBT96r51?=
 =?us-ascii?Q?PsT9W2lubMY4W1cRCeUk0vFX/FvGD4c+XNKdMRN4bR+N3Pzk9AQ0nVKfnJCs?=
 =?us-ascii?Q?CoMJTRiCBCq8fyrsyN4LhnWyFq9mBpkWe4f2kL/3P6DCtM04QMd9lBdCotpH?=
 =?us-ascii?Q?ig50GqBuOqgNHveKhccNyiNadjZldx/QPLvRMzsmFi0qEUxyh5e1Y1knwvMN?=
 =?us-ascii?Q?kZPilF78actEXYUxzwamUFP8oPlgLSszstcJDgXoRBzKa7xdVafexZkh+6wq?=
 =?us-ascii?Q?fQl+VWFBTv+A5UZCbQ/CPTugnuW+86cfx8S1c88RciJlDjfWU5IsPnMIUcb9?=
 =?us-ascii?Q?s/VXoSJt2QLl+MCDOq8WAOBpm1mc0F5+IUgBotwuDNkzaJfPSCQ1L2kS+IqY?=
 =?us-ascii?Q?+j/oNpKnmEfHIozd9YDu0XEDCRvdIC9TO5a4w5BIjwplchbWWpSUJqr8Hmih?=
 =?us-ascii?Q?ZwDq2uTdboiKRL/ArNxGAZIPHos7ASuj5LNsv6bfkC5eOawlxxBtKhlCape8?=
 =?us-ascii?Q?e9yxf3rKgQPMCMXuZpRQ3Bk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e982dc-038d-424e-5458-08ddbecaf32a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:28:23.0816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiGX2f+qei1Pwq/NdBZwCsVx6aLF7VttxLaVPOAx1LnmxzSftp9sD4QGv+GqbjL4hIeA6MvQVVJpQbJ7kc/LqoxsaU2mkUokjs7qyzOMLEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10805
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

