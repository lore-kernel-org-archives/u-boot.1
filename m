Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC32C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFB388C05;
	Fri, 23 Aug 2024 22:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qtVqmTLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49B688BCE; Fri, 23 Aug 2024 22:45:36 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872D688B9C
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k06EUtsbxPEAFGvaKWmgyKmSosI9zgqTGP5nfTXs0InZnkeYORE0RNcb2dR9XJQekxGv+/hdiMtYlCssUZFY7wdkSWGAooUccAD61YDJ1pUfo9JcO4lx0h67nhDAHzsIaQ4lvGSkOsyCUR8T4jItzfoemn3fQNJUySX1evYyvGzfPoLEUZGLyhpNYaed2Q4Cylqrcha005Ec2uCwQL0rmZkjQBn3mCMkBXioD7Ons/BqNcVBX/Mh3pVQI8RgdWnWGNZYoNF089a8yi4B1Kl+Ub1IyKdeu7AXdgDRzU4pcikhC/tBDdz2y7DfN4yr4I3QQL0qSQpK2RlGyG+2AprHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9pbOhI8s5B2K1Y/7rqsd19hOSqmpKiA2CjeqvaXvxM=;
 b=ms2L3vSKukLNgmtUB9UJZR+wyEQ/5kkUfa3Nd2uZfglLDFfMqr7U7OtRBTsuw+3x9OIOooRt9ihUw42A9MzeRu7u5uiYq/3IPwPf19qnY5QIP6X+fmha5LPf3bDP5Rf0ySYMOEcRzGS0azZlBgivd5Te/E1ojRmzD5nQFhY28BKDHQ3WnpdZiER0QCnRKcowNuAYKYNF6n4Yy8sb+xDEJGPXN+zSXqIKS1ngEE4y/PW/nS6vK9h3kVkZlECVDSAT1UaQ3UT8zOV690++KF7ueWiiaq+0lKRK5Wwc6y+evXuVxYEqta1xxry0UmnwfxSBfuf0m6tolPCEoE/j+yihNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9pbOhI8s5B2K1Y/7rqsd19hOSqmpKiA2CjeqvaXvxM=;
 b=qtVqmTLbXX40gTyJIMMfcsl2CHuhL5l0PWYu9ZWf01bVhN70rSb0VwXhd5jF9Vd6Tkdj2RsZgN23NAZQwt2G10hJMczngcTsBfgGMYJxzuIM5ja4CgLSQcaomHhtU1+SXhtXwGu1hfbjXhFJp4RvgWQ2VnfiB6SjIpg4senViZWQ167sOHAfdEtoUGtijN35UiVZ6SMtwCwBMsWSRAxqxeGrjc84cTNwM2zBq8I2qJ5wvzwGJ6Stu2LcLInuTHrjIv4aUO8u7BqWY1UfNYZtwkVL/rvFE9O91YYoWR8t6kjDu2piOWtKyw8UU/DO/9vlq1H1GT3SKcmpmP8vdRItZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Fri, 23 Aug
 2024 20:45:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 20:45:33 +0000
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
Subject: [PATCH v4 5/9] net/tcp: rename ack_edge and seq_init to more common
 rcv_nxt and irs
Date: Fri, 23 Aug 2024 23:45:14 +0300
Message-ID: <20240823204518.1010194-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 43504b5b-1f43-48e4-a396-08dcc3b48892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0sGK1hhOy0x3d8ZDNlax6RijusK/o47XnBImoRoJ3ghhMqCUqy2gvh8zqL0f?=
 =?us-ascii?Q?KSPIYIqfkr7l0OHhKS3oVtKU1J9uAc7kSwT6T8BQ5cr6NEeHzYBqcI1mjvvI?=
 =?us-ascii?Q?AO8gSuhBl9fA39jp7r4xpDd61y2JDUn3SImDUrwuv1H1vZFTD063Ps4Wng/E?=
 =?us-ascii?Q?dipIzYVY6h3dSWPX9lxW0cjq5B4EOdwwNlG91mluaIkDgtlxc6I+84borrWg?=
 =?us-ascii?Q?IZmL6EK3WCVDuk2o8A8WyxJmvEYgPKm2pW5bvQtq3KCF9+BzZM0Q95zuf/vP?=
 =?us-ascii?Q?qmrU6JJQajV/6bqXqM2ADAGxukt60TXDOXOSqds29tB6zHmGP2gkEDukatxz?=
 =?us-ascii?Q?3Tcb1jfIbz5xTX2xJUCigUMi09uI7ZqWZjJWFDkpWRcKXazOdwClVo2t1pGj?=
 =?us-ascii?Q?fSwfxKpbwbFCviNjnlLSlRUBJfFeg/Z+p86xxpzlk6Q5ryD+/HHxPSpWEq2I?=
 =?us-ascii?Q?rvALW88tiqFsniJPQLHRHQrf3KkLx8dRMbTlnRsu8dtJgekJ2Vt05yaCaawM?=
 =?us-ascii?Q?fWcxLX99uAeNHQ3aVkxijfH3g8mWcgmZduEUKVsKjVeOA3nFWOc+SSu9kTOf?=
 =?us-ascii?Q?HGV2xDtkMq0EcQhDH1vzi0E6ltytMXQlMfqvP+h5LUp/zk9NfAWbeQP4rMCK?=
 =?us-ascii?Q?FmCMA0C6njhlSmhphdtxpmZj458mCLbMzUeH/fzgC/Xk0SiTZS4ZJ0KOYTqw?=
 =?us-ascii?Q?wHhhmB+zgqT/1jS5ANeX0n3TSbVMBYRWHMnoce3+aoGaxCY9gi1LoTpSrtC8?=
 =?us-ascii?Q?mBTxpnVAgM2qVDIPSaqV2wdS66IDyNrTIZ5LKysjMI8oRFSmKYfdZty87XfM?=
 =?us-ascii?Q?1HjYMIwaD7rXPRWrfCQT7bLaQ/xnQen1rPPX47EJWjvL0l8SOSirbcBQIThn?=
 =?us-ascii?Q?mNSmtqR2u245l/rowcSnkmewkBiIAuXGRHoNcvGqZI5kT/5vy8QgePr0Sv68?=
 =?us-ascii?Q?UjPOnV2ShMmSTvl8PMzkcqJLHQDnrnXdph9tz9UpBiCrs7GTwP7yngpFTDVY?=
 =?us-ascii?Q?kb13OmAnIaf3BHYWhCBQQvtiSqNOT8grgCuxZUkGNcXY5+fyLKru9uGPTy+D?=
 =?us-ascii?Q?Nc7TEys9FMDiy4lWMJt94Kv7EG2ZCViy2JldK6gZjs7/RpV75fejtRGuekK2?=
 =?us-ascii?Q?JTHT+/HxeLPpoS+UuiAxLB2V5V3TnaSBSdG12XHJJa+bih/5AlovSEP0aqwg?=
 =?us-ascii?Q?ONj6fuRO1htOWu9lNo669CIpB5IPAguizZNjwHoAnR0wYk+spceVpet6n0+E?=
 =?us-ascii?Q?VCO/tmrv7J4PNHXCMSAkX6KK4C+aXiImfswpOgAFEcfPy22NtkKMJvU2nokz?=
 =?us-ascii?Q?DcvG9lI0MkW8qe807vK2C/AiCRRMh31IkxzJzjGtrlVy2/UN0U9+iI3kNOTh?=
 =?us-ascii?Q?Le6FH5BKsrwyS4BW0hsgvUUGtnRMRMCEnLrItxxtIx1/g4GLCOE6FYJ8KFQs?=
 =?us-ascii?Q?6mMtSzmyFBU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCIT751hQ4QirZM7rq4yhgsqUI5GiJrp97qnlgRn9gb7VDZIEh2cCUsvsUne?=
 =?us-ascii?Q?iQ8ISaD34netdm8N2eb1pzQoX69ZVYl4xF1OeOxIue8J3yg8iMrfsEHdvuVI?=
 =?us-ascii?Q?vrbBE0Q0OL6WbWQK29npRgJxjJKANRTc9sCQLuiz6IXEFdj9Sf/6N+XTwmbV?=
 =?us-ascii?Q?WZa2FtQS8C15srTk3+tsN1eUT9WUm6uRkEeF9siVJpFPqUJy3l+j31QxuJI4?=
 =?us-ascii?Q?b+vh74e1/PioyK+YbVYzfbMyOWvbt7/dzuhApCSD++MTlD8oDYS7z9FXJ039?=
 =?us-ascii?Q?lFqsuinXdwlfEpBr6iaUKJvKooeocfgIBWxnKOegmxaIaxNVrB/BlGEttWlz?=
 =?us-ascii?Q?avOLNHYgEcBKLGkDzU5NH9X40MRBTOM08fmwV2vkhRumuqUQ7r2/8/6/g+bq?=
 =?us-ascii?Q?umQe7YQ+PeJdNroKuhtwM1v8Q3KDOwdbwwkihKn4IEyGmiUKRg+RlC5JW/tM?=
 =?us-ascii?Q?XxHkZUd5VSllH9VvPMSrcDFcPQl8lrzcOIufPxVNLD6W21vmWhD76h1qKaYh?=
 =?us-ascii?Q?QbKQoXpiqdNC6vjMMSmsbVMRtMx0TVUw0JzvFluHs6Ic2SDHsDiDU+0wLe9b?=
 =?us-ascii?Q?gjTSGGitMAAXi4gG3iffQFEPoeZ0i2gsP0cL/eMgPb/wI84KmrhwNLBDG7Z8?=
 =?us-ascii?Q?MPT3xKCiTJ+LNFAGv037DbjnSMZiHteiK2lYdSjmbYpBa0KFrPfvUurHji9y?=
 =?us-ascii?Q?lPoJaxwBhweC8SHc7EeDZBRQ6zFueEEkmxIcLhLpCM+uOpRx2CNs4AupNd53?=
 =?us-ascii?Q?15vJynLC9xHW193HDVcNdOEmwdg/sZpFjBzO/TrxC1EyCiNAl3AdYQNj6ren?=
 =?us-ascii?Q?cWWdtd6sDGy43ZolABw/cwe9gUNDh95Q1eJkvi+a0CEEcgjA2EAm+FBArYO0?=
 =?us-ascii?Q?RivPXJptSJMi73XZtzv0CW84Dl9B3A7X/KsgsM6RRsOcqOlm+2WxWj8wdxq+?=
 =?us-ascii?Q?MIEuafxpMW8x6vHpHMXDhSjJmDmvBOvThIFFkpjltG35N295jPmzi3xOxZif?=
 =?us-ascii?Q?sRlCIquiCMN6LUkcNiJuim860waFhHT6VXJpLa6C2RkfUawR3+6KCXjhvjaL?=
 =?us-ascii?Q?MXuWWoxyhKaOoM20Sb8X6VvpxbXBzTsNafW6vJehLhVRgW0+acZwunTWPPPj?=
 =?us-ascii?Q?fbp1o22Zxk+cALSm4h2d8spSNtuugxbWy/FT6NJruwfO6501+gb7ebSDen3x?=
 =?us-ascii?Q?gN2hKYpNRuCadCME1qTKgCq0vj5LlDjMlcA0R+BNldLi1T0xg5MDdPQJLMet?=
 =?us-ascii?Q?y3Esbko68nvVlHMflCutdicaRAF6ad/4IfKyIca6EXfYFre0qtS/N3Ma+mz1?=
 =?us-ascii?Q?Ah8KrOs9DU2osZapuzqqIWjpokip/RSbR6rbr3JTt5ThbkMhEPpM9kAQVZLg?=
 =?us-ascii?Q?D723XvGNQRpU4S1OMuR1Y2mCivDSiV0d6IYvpS9TMun7MlCDfJl9yJeANDIE?=
 =?us-ascii?Q?T0nqN5aMO917ExnyaxkG6M5kOWvKEHvtejoRcvNNeC4PlgPTsEcqQVagulgj?=
 =?us-ascii?Q?ZDiiu+vFZCm5SFlAJIlk5dAv9WNR0Rn2STGoxCfZ6kzAqrklnUPeIz+8Pa1d?=
 =?us-ascii?Q?ymfgQZUxchzeWXlsVTXBc/DmGYy4hYjF816NfseXeVAwoYI/fsVLdEXhgo1b?=
 =?us-ascii?Q?2N5CaYeNA3zlLJk1ZH2vUUQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43504b5b-1f43-48e4-a396-08dcc3b48892
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:45:33.3931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqH9S59WOgDtzJZhyAEXmd/ldlhH6PVVC+dLBUi6MYRH2WHT9jDAfZU7Lu2LxQG5mLc1kAXPIcmbVGuoBpPUbITn2gMA7DuLWe+20IKi1+Q=
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

Use the names from RFC 9293

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net/tcp.h |  8 ++++----
 net/tcp.c         | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f224d0cae2f..0694af9d5b1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -285,8 +285,8 @@ enum tcp_state {
  *
  * @state:		TCP connection state
  *
- * @seq_init:		Initial receive sequence number
- * @ack_edge:		Receive next
+ * @irs:		Initial receive sequence number
+ * @rcv_nxt:		Receive next
  *
  * @loc_timestamp:	Local timestamp
  * @rmt_timestamp:	Remote timestamp
@@ -301,8 +301,8 @@ struct tcp_stream {
 	/* TCP connection state */
 	enum tcp_state	state;
 
-	u32		seq_init;
-	u32		ack_edge;
+	u32		irs;
+	u32		rcv_nxt;
 
 	/* TCP option timestamp */
 	u32		loc_timestamp;
diff --git a/net/tcp.c b/net/tcp.c
index 9acf9f3ccb2..96d499a42ed 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -360,9 +360,9 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	pkt_len	= pkt_hdr_len + payload_len;
 	tcp_len	= pkt_len - IP_HDR_SIZE;
 
-	tcp->ack_edge = tcp_ack_num;
+	tcp->rcv_nxt = tcp_ack_num;
 	/* TCP Header */
-	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
+	b->ip.hdr.tcp_ack = htonl(tcp->rcv_nxt);
 	b->ip.hdr.tcp_src = htons(tcp->lport);
 	b->ip.hdr.tcp_dst = htons(tcp->rport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
@@ -396,10 +396,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	return pkt_hdr_len;
 }
 
-static void tcp_update_ack_edge(struct tcp_stream *tcp)
+static void tcp_update_rcv_nxt(struct tcp_stream *tcp)
 {
-	if (tcp_seq_cmp(tcp->ack_edge, tcp->lost.hill[0].l) >= 0) {
-		tcp->ack_edge = tcp->lost.hill[0].r;
+	if (tcp_seq_cmp(tcp->rcv_nxt, tcp->lost.hill[0].l) >= 0) {
+		tcp->rcv_nxt = tcp->lost.hill[0].r;
 
 		memmove(&tcp->lost.hill[0], &tcp->lost.hill[1],
 			(TCP_SACK_HILLS - 1) * sizeof(struct sack_edges));
@@ -434,7 +434,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			tcp_seq_num = tcp->lost.hill[i].l;
 		}
 		if (tcp_seq_cmp(tcp->lost.hill[i].r, tcp_seq_num + len) >= 0) {
-			tcp_update_ack_edge(tcp);
+			tcp_update_rcv_nxt(tcp);
 			return;
 		}
 
@@ -463,12 +463,12 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 			}
 		}
 
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
 	if (i == TCP_SACK_HILLS) {
-		tcp_update_ack_edge(tcp);
+		tcp_update_rcv_nxt(tcp);
 		return;
 	}
 
@@ -489,7 +489,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 	tcp->lost.hill[i].r = tcp_seq_num + len;
 	tcp->lost.len = TCP_OPT_LEN_2 + cnt * TCP_OPT_LEN_8;
 
-	tcp_update_ack_edge(tcp);
+	tcp_update_rcv_nxt(tcp);
 };
 
 /**
@@ -566,8 +566,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
 		if (tcp_syn) {
 			action = TCP_SYN | TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->lost.len = TCP_OPT_LEN_2;
 			tcp->state = TCP_SYN_RECEIVED;
 		} else if (tcp_ack || tcp_fin) {
@@ -583,8 +583,8 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 			tcp->state = TCP_CLOSE_WAIT;
 		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
 			action |= TCP_ACK;
-			tcp->seq_init = tcp_seq_num;
-			tcp->ack_edge = tcp_seq_num + 1;
+			tcp->irs = tcp_seq_num;
+			tcp->rcv_nxt = tcp_seq_num + 1;
 			tcp->state = TCP_ESTABLISHED;
 
 			if (tcp_syn && tcp_ack)
@@ -633,7 +633,7 @@ static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
 	case TCP_FIN_WAIT_1:
 		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
 		if (tcp_fin) {
-			tcp->ack_edge++;
+			tcp->rcv_nxt++;
 			action = TCP_ACK | TCP_FIN;
 			tcp->state = TCP_FIN_WAIT_2;
 		}
@@ -748,7 +748,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp->ack_edge, payload_len);
+			   tcp_action, tcp_ack_num, tcp->rcv_nxt, payload_len);
 
 		/*
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
@@ -756,7 +756,7 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 */
 		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp->ack_edge);
+				    tcp_ack_num, tcp->rcv_nxt);
 	}
 }
 
-- 
2.43.0

