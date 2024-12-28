Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9FFE77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09798050A;
	Sat, 28 Dec 2024 11:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zpvYQ7aX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0F4804CE; Sat, 28 Dec 2024 11:47:05 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 981A68056D
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5yKfRA60gKYeWEic+RjhVyKaGUI+W/oroERXeTyCUyXkjfyHESeLYSrCczAcyLuaY74syMnNWlVRILarEOvJZCH4D+rWS1Vh4PDsRnvHmSCY4mDEJciUzqHznIq0xPM6dA9TWxF/BYH/jfiSP3r6WP6z9Bead/Xaaap1smRfcLn+KhMbKNoF8NAbpFKHyGP/IzdqfMR9OE2bkDA/232DiAicQsq4wHJO7ErfBoOUTs9nPE8uYww0RZEiRdweo5hP7tqUcWyoLzEhznylNQGqXrM/ggNVPobrt3iTqBQo2FdgyQIYYTWX/Df7E8+RRXny0ZUqfb+kT5783CvVp2ivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7i18DeIyH/sjCeXiGcuZ+OJ4i4PcQpShwSI8Y3eQS4=;
 b=aeBj6v3JLuv8z/Vyl5QtXpouT3yLVHjiWqq5FnxC0eABY7svAOy+/pdeKw/fbjPfdtG2NRrjaP4s/oxq42FHHpiAhyecdGzpihnPuEGbydusLYzXB6MT/+HJez4J4LsuOK3gUhhawj9Ps+nlylXKusMiFzkGW9Wha9vhCUjWASysd7JwgOzrDViBPXd87TZdIDoWCyVyg+QXFeczogwS6NAbhtAL7VOkvDq4AIg+o11o2mT/jo8prXZCI/mbQbpN7PLUzWSI31YQMt/VcmyQmoUiPYCR+c+vCfPusfvEYOKtF8JMHwO3BahEMEGOnlaAxnRFe0/Jneu0NynVtaSkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7i18DeIyH/sjCeXiGcuZ+OJ4i4PcQpShwSI8Y3eQS4=;
 b=zpvYQ7aXUyVkwQI+N/UznIVKtFz2se23S5RRIfA7OwVw5mURxrTfUfDABbxnFjoNxbXTTtEWfH+mlbdEgwSOOFZPfH0qtelrKECRo+TmHy4PnE4Kf6WAeAyhaakxCsgq1RpCm9okCZ9N2cntday4UEHZCw3bhCBzarSGMhXu87N90mNk2AQIOBK/YcFnLTqW4Zg4TgEYEZF5+3vigaVJ2bxN9zotV3vXEx2+NT9COARUMu23/nYP7IKOZ3LnZ1tIsFDBe3YrYcTXDPsJB1DMAC3bhXyDSpowhgIyszBvrXHebz9RHfjfER6359BoPwOAVFAouG5IoFps9LxWo2vwvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 07/11] test/cmd/wget: fix the test
Date: Sat, 28 Dec 2024 13:46:33 +0300
Message-ID: <20241228104637.4173913-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5bce77-0c59-4321-139f-08dd272cf1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ej9Mhx2n2Nz67Ii65MZrBsPdpTcYcARekjzDfeh+z/jgaNBaXp9+33bO4G9J?=
 =?us-ascii?Q?/GTYWt/kmJl50D9xtOGUot1z6SGJYrZ24FygMybf/ZFjsaCCGppsgMhqkzBK?=
 =?us-ascii?Q?Lk4mrFic4Tz3Ik9dcukTPGwcjRSvHLiICQ5b3a5FGJPs+IpwGeRtp5sYR4Ge?=
 =?us-ascii?Q?I/USHZSko2dnphZj3/ArrostUfj7r9lW+XkLax9vCLnmO6/VjIiiv0tHvcbV?=
 =?us-ascii?Q?u8juhgnvyFMFBJfE3AV5WhO1nHMtCjdR4AOC2cC2WL4+EiayNFzSrOx2mckz?=
 =?us-ascii?Q?3Mrfu5Md5VMojDJvoRTgL5ssqe/17mMJulRsOtd2mVC+XfrRNXsey8n05l7l?=
 =?us-ascii?Q?1+230+RhvM3l2WBA3csiGQ/UBzXD1N+QMOWdlijqLy3xaX0wqcp/SmJXq6rT?=
 =?us-ascii?Q?ATCanRz888O4oCu680qKY2TKBDuWWLp6uTYB0jJ52I1wCdfzHe17XcSerJdc?=
 =?us-ascii?Q?p8qzZs8C3TRgjRX2gL/EQctz1jIAYvge6y435ZjaGMbCUaLBCqI6cg8P84UQ?=
 =?us-ascii?Q?VfNG2iiUwosCK85zf2ibLS5J8W+BroPWxP6UGF5AEoPrefp8m2x7Jhb7kRM9?=
 =?us-ascii?Q?XzMqH95ZybaQSxfjrDxRaCzkgjpPgMsZxvYKznK/sbzz24ANgb6MPe4vA2Cb?=
 =?us-ascii?Q?9y4Ey/oQqXTVQq7OjQMrIE/YfNg18H1CQGHhls73OM6d65ZmHDfgRvDCCc4A?=
 =?us-ascii?Q?lBYTyzR/vT335uGS+QNK6l/WIKNkqzJmwEaw19M/iW3kPrSc67JRiAXSg606?=
 =?us-ascii?Q?VOO/Fr6j2Ga7O42AQTbJhEPbi94CCfFwBb6DQd1M7Ax+XkG3COU9JL5CFUE9?=
 =?us-ascii?Q?gJsz6KKx+Y0KjYFVtopM58RS6CAb/uECDKxAs/lF26xnodK2w4pBnufwO4rx?=
 =?us-ascii?Q?l/jiYCfZ3RZZwS1B/ccvzH5e7I2MwYgJz/u7zc17Tah21GobQNrSH/BRFlKY?=
 =?us-ascii?Q?pZrexcZlQVMALVitnu5bVenyfRNoX1m8LKTJY7UrBf1/tqqGHIr3nnkN1c3Q?=
 =?us-ascii?Q?q2UjqoJXLTYHTx6swRqqKaZAWkbYjMyhp7aqiDKAdB06jilrKfVz2RY07k3B?=
 =?us-ascii?Q?0d80z+z69hVJXFGVCrrmyHq/YHjjCXUPyQSIib4Sf8ytNrnf1K4o6h32AZzB?=
 =?us-ascii?Q?hnTgASCK6M8esVNP0amJe+sdOxbhsUfMxcZllqCN+KORe6knNeaeHyMfhj5L?=
 =?us-ascii?Q?tZv/NqV7R5T68sXMG9A8qCVoGKclTsPN8TColw3Er8QdcoZNwVW33cCLeKux?=
 =?us-ascii?Q?kSmiK9OU2XUCwocGZggdjB0s/5bsCCQmolmumAxv4ZDj1FwG1jWlZ2VpXPDR?=
 =?us-ascii?Q?ZVbbJp5vJlMlrCvWVgOFWzIugCvOhzKqyXigQLLsCcTo/jBrQ72JOjgTNMvj?=
 =?us-ascii?Q?v/nfwc6NJdqD8PcVa3AsRFQWbnM28pClidjgfzOOaIRpDSwOFgONvyI/UrXh?=
 =?us-ascii?Q?+0ZtU46Xie+MChlSzhPZTfz6hAS1KUVZhnNAT4o6dfdrruzeNBAnJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tr03qTRPht/DGlzjCgTaoUOe3APh9ymDljpVSyDlD+flMB2CnflYR/IWqb2z?=
 =?us-ascii?Q?YxEi32jhtfoTTOelLT/8nU0FErCqSF6CwJTS2Dx7fEXEojlkbVe5t9X9EyCZ?=
 =?us-ascii?Q?x4Uf8Frmd7UbAdl3nr8md8UC20rsWVp3PG+gsD2OWem2vT4rYaRLXZOPTWIT?=
 =?us-ascii?Q?NUDvVhZYkDR8x4Y5HPHpCqqU2fKIsztrqGJy+IYMTGXFXStLh+AF18S/Xq97?=
 =?us-ascii?Q?LuLHkbS1+pjEKPZDIpKvBvi6a15qo7VtoK/DL/nSy1xXj1DlOcy0spO9zsIE?=
 =?us-ascii?Q?QzpHURgzGS5rl7CrwY4M8YPDte1buW+A5xtV75qAz24bvoERRmHGxuMCAUno?=
 =?us-ascii?Q?H8rqySBvH6spzGVJBYoPGPQKuy+rFjDi/lKZ9FNdCHA33vwYJrbDhnOMH+ra?=
 =?us-ascii?Q?K61h7p6/qo/HgwL1pVapy4vqCjfJzy63rk/UFBVrj39ud7i7T9IfAQdDAhZp?=
 =?us-ascii?Q?zrGNKK3vnP2lTT/gYmueE1db0+/KgeYjVlLWXEofE/2b9fHVttvbK1I7qFMJ?=
 =?us-ascii?Q?NtNPl6rYYDc/c81hkb5jp50z0T2tOZH4mVLFtagwdrYgNDWrWnR3i1FO4bvV?=
 =?us-ascii?Q?RmEVYwMBkPb/VVdTGThLMTdpAEWcvsGh9ELY3OhWhjuZ0T4i7NR5/R5NUZcQ?=
 =?us-ascii?Q?hXhNdKJ/EeeOJ53PoeUOPFoxEmWRNHFuFmbNQfgNUF5XOUSKVSlWEY59VqtI?=
 =?us-ascii?Q?8QUgMxfs9H8hvPzJGah1YkekXlgIEu0cc8QpPbelnuMc/RVQYRPo7d4N0sbQ?=
 =?us-ascii?Q?zv3uWl8DXW7lMY4JESb/xY4G/4yDcxztidc9E1lmwMaTze/2mJJKv54AzZMT?=
 =?us-ascii?Q?8erwJPMH6aVQcUmyWxuXhrJecKFqu7yvu3LDGm7SlcDcaESachkx2hUW8GHr?=
 =?us-ascii?Q?5xQlW85ydfD656fZk1eP7ecerUGWvGuqsAqzXAkrcL/1sLqNhi/xd/ROo3if?=
 =?us-ascii?Q?4lz8r+yIjrTRp8axeG3txrtVfKT8TduUAWGh9gKcf5aaF4oByxKpE1tDiCMV?=
 =?us-ascii?Q?QoZ9nFjiFrvxPKjgm62AYegkAm1uJ4aStnAQc9kJwOe1oS7LduKcwp+InhFD?=
 =?us-ascii?Q?MdJDR+BeEPv1nQjcfThjg0+0POTOXEq+bfmmgA7GW8t8hnvSnwJ3759J9VHw?=
 =?us-ascii?Q?EH2ykfjJjrhtIYeeL02qHA5tOS3i+u6aCSzlJBJBo4f7lpEMiHgKir7Aztzn?=
 =?us-ascii?Q?9nurB0DW2S82Kl4Cp/CjH4UxPV5pjL3C8tiuEXGaDXm+tcmE2XGWF8N1TE7b?=
 =?us-ascii?Q?UCEFkj2lwd2ROmbuIDpATij/tf7aEKw9rf64hiUX5ahj3vktQrKOphSJuSyw?=
 =?us-ascii?Q?5KWOnkXdV+ouqFZsvAbcG0DRq+yedhH3N5hdA1JGzcYssu4LwNRUkfuUU7ar?=
 =?us-ascii?Q?Gm0ihsMJrDjO5rvaJ1IdbA5f2+u5gGWV5t4o+nkcA1K9sd7PqaB/lZodHT21?=
 =?us-ascii?Q?4PZ0WQzoPR5xmhkZi8BaEkvKaU6mKhqeOKQR3pl+4kmxok86pqdEYTBtl2SN?=
 =?us-ascii?Q?kkx8oCrZxzpXU7wATRSlEY35bovYFHbscrHhZYbrlL1MdWkHAhXIX5iiRSEZ?=
 =?us-ascii?Q?MLTxxtU7heRGAVARr2OzjZbYOTXQgEpHvbVMO0e+woOC8i8c9wt0jKMH3ox+?=
 =?us-ascii?Q?i03jbzrDJMpHx1fIgriSU1A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5bce77-0c59-4321-139f-08dd272cf1b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:54.5386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE2g4zJ+clTYLPItsqfOz3VhjuKEou+utaMhNb/DGXDVj45E6gNvj/BypsHySD3Q0MBYxEfHxvyKRpRtNyOhz0EiH8J5MtbjmW0R7XjEMEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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

Changes:
 * update to new tcp stack
 * fix zero values for ISS and IRS issue (see RFC 9293)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/eth.h |  4 +++
 test/cmd/wget.c                | 58 ++++++++++++++++------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/sandbox/include/asm/eth.h b/arch/sandbox/include/asm/eth.h
index f042a5f3b92..083a7371a3f 100644
--- a/arch/sandbox/include/asm/eth.h
+++ b/arch/sandbox/include/asm/eth.h
@@ -77,6 +77,8 @@ typedef int sandbox_eth_tx_hand_f(struct udevice *dev, void *pkt,
  * fake_host_hwaddr - MAC address of mocked machine
  * fake_host_ipaddr - IP address of mocked machine
  * disabled - Will not respond
+ * irs - tcp initial receive sequence
+ * iss - tcp initial send sequence
  * recv_packet_buffer - buffers of the packet returned as received
  * recv_packet_length - lengths of the packet returned as received
  * recv_packets - number of packets returned
@@ -87,6 +89,8 @@ struct eth_sandbox_priv {
 	uchar fake_host_hwaddr[ARP_HLEN];
 	struct in_addr fake_host_ipaddr;
 	bool disabled;
+	u32 irs;
+	u32 iss;
 	uchar * recv_packet_buffer[PKTBUFSRX];
 	int recv_packet_length[PKTBUFSRX];
 	int recv_packets;
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 7570c065a10..d51650d5854 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -25,8 +25,7 @@
 
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
-
-int net_set_ack_options(union tcp_build_pkt *b);
+#define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
 static int sb_arp_handler(struct udevice *dev, void *packet,
 			  unsigned int len)
@@ -64,12 +63,14 @@ static int sb_syn_handler(struct udevice *dev, void *packet,
 	eth_send = (void *)priv->recv_packet_buffer[priv->recv_packets];
 	memcpy(eth_send->et_dest, eth->et_src, ARP_HLEN);
 	memcpy(eth_send->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	priv->irs = ntohl(tcp->tcp_seq);
+	priv->iss = ~priv->irs; /* just to differ from irs */
 	eth_send->et_protlen = htons(PROT_IP);
 	tcp_send = (void *)eth_send + ETHER_HDR_SIZE;
 	tcp_send->tcp_src = tcp->tcp_dst;
 	tcp_send->tcp_dst = tcp->tcp_src;
-	tcp_send->tcp_seq = htonl(0);
-	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	tcp_send->tcp_seq = htonl(priv->iss);
+	tcp_send->tcp_ack = htonl(priv->irs + 1);
 	tcp_send->tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
 	tcp_send->tcp_flags = TCP_SYN | TCP_ACK;
 	tcp_send->tcp_win = htons(PKTBUFSRX * TCP_MSS >> TCP_SCALE);
@@ -104,13 +105,11 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	void *data;
 	int pkt_len;
 	int payload_len = 0;
+	u32 tcp_seq, tcp_ack;
+	int tcp_data_len;
 	const char *payload1 = "HTTP/1.1 200 OK\r\n"
 		"Content-Length: 30\r\n\r\n\r\n"
 		"<html><body>Hi</body></html>\r\n";
-	union tcp_build_pkt *b = (union tcp_build_pkt *)tcp;
-	const int recv_payload_len = len - net_set_ack_options(b) - IP_HDR_SIZE - ETHER_HDR_SIZE;
-	static int next_seq;
-	const int bottom_payload_len = 10;
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -125,35 +124,32 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	tcp_send->tcp_dst = tcp->tcp_src;
 	data = (void *)tcp_send + IP_TCP_HDR_SIZE;
 
-	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1 && recv_payload_len == 0) {
-		// ignore ACK for three-way handshaking
-		return 0;
-	} else if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
-		// recv HTTP request message and reply top half data
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	tcp_seq = ntohl(tcp->tcp_seq) - priv->irs;
+	tcp_ack = ntohl(tcp->tcp_ack) - priv->iss;
+	tcp_data_len = len - ETHER_HDR_SIZE - IP_HDR_SIZE - GET_TCP_HDR_LEN_IN_BYTES(tcp->tcp_hlen);
 
-		payload_len = strlen(payload1) - bottom_payload_len;
-		memcpy(data, payload1, payload_len);
-		tcp_send->tcp_flags = TCP_ACK;
+	if (tcp->tcp_flags & TCP_FIN)
+		tcp_data_len++;
 
-		next_seq = ntohl(tcp_send->tcp_seq) + payload_len;
-	} else if (ntohl(tcp->tcp_ack) == next_seq) {
-		// reply bottom half data
-		const int top_payload_len = strlen(payload1) - bottom_payload_len;
+	tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
+	tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + tcp_data_len);
 
-		tcp_send->tcp_seq = htonl(next_seq);
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+	if (tcp_seq == 1 && tcp_ack == 1) {
+		if (tcp_data_len == 0) {
+			/* no data, wait for GET request */
+			return -1;
+		}
 
-		payload_len = bottom_payload_len;
-		memcpy(data, payload1 + top_payload_len, payload_len);
+		/* reply to GET request */
+		payload_len = strlen(payload1);
+		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
-	} else {
-		// close connection
-		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
+	} else if (tcp_ack == 1 + strlen(payload1)) {
 		payload_len = 0;
 		tcp_send->tcp_flags = TCP_ACK | TCP_FIN;
+	} else if (tcp_ack == 2 + strlen(payload1)) {
+		payload_len = 0;
+		tcp_send->tcp_flags = TCP_ACK;
 	}
 
 	tcp_send->tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
@@ -217,7 +213,7 @@ static int net_test_wget(struct unit_test_state *uts)
 	env_set("ethrotate", "no");
 	env_set("loadaddr", "0x20000");
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
-	ut_assert_nextline("HTTP/1.1 200 OK");
+	ut_assert_nextline_empty();
 	ut_assert_nextline("Packets received 5, Transfer Successful");
 	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
 
-- 
2.45.2

