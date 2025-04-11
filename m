Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EC1C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5E583F53;
	Fri, 11 Apr 2025 10:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RWRyca0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3DA83F58; Fri, 11 Apr 2025 10:10:50 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4035D82A33
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPzL2l07ZRaeEFGr1Zt5TSyoXifkdXI001ObUCKMgnSz5PApTHu5VHLz01knkfEdCzTymbHLVHjxnzukMmhq4WReMFlkEwwHIbFscKMaiN4IRtgFqal8a4rDjfiG+0VdvowVdOR/oZR0KmEbl5GPhgKPYdQ+NIiAUJoypSJtLoFdMsanh1qirLPT5cOv4XIwSLxkYOoE5UYa5xlO8mtXpH3IY7O93tczMVZ7F8IbgTok2LSGJ963oQnQ+C68S3hEQZe5vk1u4hZXrQtgIema0vbgx/R00A2/8sFDO2gEZyqJzxa6F3S0KfnhIbBG3n05UHQdsyQWZaEuGCHEd8fBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEZLXkaxU5uv260+udEj/mY5J09u3Q/mEI3CRzkhjCA=;
 b=yf2pZQbscFShrIi5t0P6CSyFaZ5UTmnBEtO27nZRcGOWXrhtuIzqoafpnyaf4IN04g7iuejD/hGA1QBGgNq9JbF9jS0IqX1tb4U1cThKwLXMLC4Xu3R6SBpvLCmazzV7fopDmeOVK4FDItk9ZvVEDV1snjs8/OBZ/a6DhDaA3fO1xp6LHB3dVDL5FsH4DTC33nnVjQOUT5+dY4pU4BYAoCHAgTCsqK01yMPU6+ukDM3IdDWHHupZkiZvWGexwEcEgQKAjwe/HeIVqjwujrT8/Lew39oUrQQJCXhrdX6D949bKgZCHIE0eYNNCV1et6kNd+XqnsOT0D0fOFjSQEPFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEZLXkaxU5uv260+udEj/mY5J09u3Q/mEI3CRzkhjCA=;
 b=RWRyca0Jestt4fe2v7Wb4Ic7rrYyjrh0S0oip3nDvVFcZPJ94n05+ApKvO/gAwlCYqAd5i+IXQAKzMdfJfTUGQzZZ62QIJEXhJ7AFAtUwpkGmsF77YknMoLhe+fVFR52XIoha6UPS/JWwRdr7Fhz2r4NIqdMeyG7oSp+w+GV8FHKpL2H7LLBK6/S0steidXwVi04kk5XRbKkekMbZh8dAseSb8Uy0wZyLyosFhr3SnEjPRfPMibpQfcNJPgK9fbRTP9se9A6eBrZji7O3nqw6is8UC61D5TW0gm/TixRoZvvoJYT3IZRs7Dqa6hdu1Q3a5Tq6OofTom8MhbeIf/9fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:10:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:10:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 09/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Date: Fri, 11 Apr 2025 16:06:52 +0800
Message-ID: <20250411080707.602371-10-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0be936-27f3-4164-dca1-08dd78d05cfc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RjG6jZ6AVxlNRQFOXV9hcTTJIgEOZQ2nTFrq03GSVB4166GQ+qXesOZxmDn3?=
 =?us-ascii?Q?lgIJIA3Yc8W+R3nyFX5fm9GpJDbb2RbtYHl3ccdUCkLd2f0sXgb7aROKwQWh?=
 =?us-ascii?Q?o3hyXl9EhrCH1L+3871PYrJQ7qRNXiGHA0BmIEU5nqN7NIMDbsDPFgvFT7U+?=
 =?us-ascii?Q?VVcGZ15V8e2qqx8+bWctsyeYApIKYXuxUQOZ1W8AfpRIDAGXXJMdZ9b9x768?=
 =?us-ascii?Q?BXuiH7qks3JRkQhUIJegqQcc8urGu8Q+FpZvSN/89O5oA4GftHySPfFuSszg?=
 =?us-ascii?Q?lObbdFHWOxanaaQsDLW/WEcjUNT5+C8C8LgKsnFkR4YdGavus3iAum3vDN2+?=
 =?us-ascii?Q?GQGCyX7/TFyWnSdvJeUdntX0XBX2lBJFQxf/JSqp55+szfnxQ9ED/AkKtSSL?=
 =?us-ascii?Q?sKjhna5UUcuAhemceu7T0ZjMNdIDXnbRt/R/2wE2HLN/E2eFSxIeTDNhETwx?=
 =?us-ascii?Q?gtBjZCc2TkL/cw4gKN0EuLxPCDt88alagcOp+pkKTDLM0HvLHEuodjrNqrTS?=
 =?us-ascii?Q?qlnEcZQtTP7ZtZbkXrQw7PtULx11TIU1ubKh30JfgVyYktWAT+NhG0DDEDoN?=
 =?us-ascii?Q?RJllWsxDOQbqtP45FO+aj1kUU/qqlX6lOB4H2MCV/zVLD4HViRiseXukms80?=
 =?us-ascii?Q?LmnD4Pk0DgkKzh2f8D433m3TXdrAQbR1avQP1oC34xqWI5YFsIqIQnhVR0+f?=
 =?us-ascii?Q?FY0y7W631uQytTNpRklsxoq1je3Y7a8TIuYwtO9qbvbvA70xsd6liH/Ij54r?=
 =?us-ascii?Q?E/LuGPuSM0tvth30Kii3j5jtcAetx+/MBUl5vTfHq1kAdu1PVOABSRBS5xpC?=
 =?us-ascii?Q?UfAJzqx/C3FDTRq4g9Rw7/yiXOIPRSRUJrUe2so8YVzz51hqd/kpT/Br7efv?=
 =?us-ascii?Q?ArpZuQ+aI3miw9+HBVfykPC4NcEKLQtXV65Oz5PSNAH5bEdxpDTTNlxQuXhO?=
 =?us-ascii?Q?+prjsPSRNfTuyQSlG2LINQk9hkYA4t2dcVdmKAocJoPltTjpl14i6itDSFdV?=
 =?us-ascii?Q?goaCmXc9JyV4Yghr7q2h7XsQqkIDxFB/OG/Gthsl0ywyTLCaAr7uuIZ7ObSI?=
 =?us-ascii?Q?LsL8VTd74vPCz9LS8GvwB6csIIbQQ7vm/jv9hTm2lZi5KT0z5sroaNFT4ze9?=
 =?us-ascii?Q?GWwE6fYNqyDcoQa+Xmu9hNVChVipfwBsl/uj23i/DZvTuxTESBa4mbHrXUIN?=
 =?us-ascii?Q?RfJYmMs9y78UzEaF+3MWZSV+x0qIxhXsmtVK541MkRKc5WBD0tSI5zqfdWri?=
 =?us-ascii?Q?Z8WjA6zeXGZbxxNHCUeTSblZwE19eB7dAtEa39JySRQPUCqSR4401wmTuMZt?=
 =?us-ascii?Q?6Xr+5SSh/I1P8p5lLV4sebeQfQKMQvX+J0bIENnDO/rt2v1kIhyWbvYdcMTX?=
 =?us-ascii?Q?GzpUmGgxIISyatg8OXBAhCvdvfr/0A79lA6tJxCsh28f+Ipn+/BeAgkb4cer?=
 =?us-ascii?Q?2KpvGN2VSfDdE2Yeg7xyCEyMsTz9fYAZBSUb+9kLRhwGYPd+Uvqgyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yL2UpMRVn3nZN0eWJ9HuyTrZiBKF7iUEiehaoH4s92NrKG2NVyLbEjX8yNzp?=
 =?us-ascii?Q?O5Yf4YtyTqeaKTLmRWC+8pLAtQXYvVy6RMKqu+NnqR+MWKETtVhhhpRY81N0?=
 =?us-ascii?Q?l7AVt0J69Sz2cvMShi+B1fyvKCFoISAlHl4/LlyCO7yzgLfQfcEnrE8CnVfX?=
 =?us-ascii?Q?BT6oQtFqnBgl7zU4J/fwCYlqXvWJVW5KnVduj4Cjg8HadxZswvao6PcOrOWr?=
 =?us-ascii?Q?6cvzC2J4xlj4umh3ZpfDXL93p1QDEGvUBcK2jO6plN8xmajf7Ywb07pjo5a8?=
 =?us-ascii?Q?oeP9tGGkcg+zMP9FStaYhyRIK1lMX35ah0D8UOg+X+e55EjBc08TadWD0bRc?=
 =?us-ascii?Q?LC347ov7GuRhMP0XHzrPcrR3ugiC9d3jJ0CkmrQLisSwv6gMtZzyzWhMZEnn?=
 =?us-ascii?Q?YSJZa4zc9DVEtJnvfC2h/Y43j8TtdNF4eK1gvdNLREa2nrpi655wjeHxW8nV?=
 =?us-ascii?Q?AnhJ645Fv0kUN4w4GABxvjNJn4gu3iJTe6f+Ss3a45n/iXHaO0cgP3QmKumN?=
 =?us-ascii?Q?dLwTek9EVt5RRtVryxppLc7wlaCysU9s8lodDOEIBwZCDt/9f2/Topl9R0Oh?=
 =?us-ascii?Q?ZJbp/IT1SI0YksB2JjaWV/1ZIkT07cj+FJ8fuka+Hfltq4zuETYfpZudMKgo?=
 =?us-ascii?Q?J7M6NJBan+vesEf4K3jK7gkIV8SY25cIb773ezPL1OZR5ufCUD11nrDftabw?=
 =?us-ascii?Q?9tDeYaZJ+mFySTOMRS2RKeBtT2E2Dr6ZvMhmFz9+etdZMxFczF44tb8heuyQ?=
 =?us-ascii?Q?ijVlTwp7+xnmLx2pHRf+IwiUKf0PWrfDwG+NkBGZKbCWCGQV/BA3QkRtUy/R?=
 =?us-ascii?Q?8wkg1Yf5BJZMpc4KpVwl+jqSQBpiKVeqqUB7SuxCszlfyFFcEMVnAlCNvSVD?=
 =?us-ascii?Q?D3y/k20jYoYG7JJuLWAToKEIJA5aLW3X49tKiaiWnpxEIswkjhfgkLYCMNOo?=
 =?us-ascii?Q?Cm8Q5TVgZ9mvU2Li4WRl7HfQissRHG7X+cFvGHsSCW03CWYY50YzB0zbb9uf?=
 =?us-ascii?Q?H0lo4YjNF46Y12DZmxefT/WSDyEBz00OjWHDSZitTYBB8HkLzTtwubbii5Fp?=
 =?us-ascii?Q?DyyO6a3cAoz+jUJPukDbx8e2GqLvm0YJyqOEy3cGvIGTv2S4skPZQmygBCvQ?=
 =?us-ascii?Q?KcSqDKYmQ5dadPC5C/Z6NZ19j88aadppABhH4IUDCC8atsaJcJV72maoHAMz?=
 =?us-ascii?Q?GbpqW0HahKPoW5SR7PpAAcJF8vnnEjugg9KhsqOBXnZFcnlaITB9cH5HCL4X?=
 =?us-ascii?Q?vSgMbt0c1UTV3ypWNk5VpaoMFneJjhLldt+Lwy2MZEAT2GTNr3tKyhExqr0C?=
 =?us-ascii?Q?LftjZRwp7UOYJ3BPb8LvSJAU1jyqTOSsmqrKs/5M9K/hJXpNW8NeV+B5GCV6?=
 =?us-ascii?Q?4jJb7ZPj0Lkpva6oHp1wmY3IoYiCxas/aUtV7N3ilTxn3MfIeOr4g1aFuOAM?=
 =?us-ascii?Q?XxP6q3GWZRLJPB75EvVZZYKUjjP6xzUjkgfUWU/yMT2AR7FSMZ3Nto3uUiah?=
 =?us-ascii?Q?SOfBJ0xeBia5vOzeLRATPRp8F1MKPUvs7XRO18mVOotr3OPgXsFRzSgn0zAe?=
 =?us-ascii?Q?X/Yerac7wQ6yE/i3pdLcNllH90r0pkuDcTNnAjWl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0be936-27f3-4164-dca1-08dd78d05cfc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:46.7906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6RY9e93c/9TTrOxykHfqxlV32xWy9h9wyOjNSyV1xurBdkOKvtwDQu9DaT6UjsZPuVqMqzscJayiKdctInMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. Four protocol identifiers are packed into
each array element. The number of elements of @protocols is specified by
callee-side.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/base.c | 24 +++++++++++++++++-------
 include/scmi_protocols.h     |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index f4e3974ff5b..78ee2ffd2da 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -258,7 +258,7 @@ static int scmi_base_discover_impl_version_int(struct udevice *dev,
 static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 						 u8 **protocols)
 {
-	struct scmi_base_discover_list_protocols_out out;
+	struct scmi_base_discover_list_protocols_out *out;
 	int cur;
 	struct scmi_msg msg = {
 		.protocol_id = SCMI_PROTOCOL_ID_BASE,
@@ -268,7 +268,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 		.out_msg = (u8 *)&out,
 		.out_msg_sz = sizeof(out),
 	};
-	u32 num_agents, num_protocols;
+	u32 num_agents, num_protocols, out_size;
 	u8 *buf;
 	int i, ret;
 
@@ -276,22 +276,31 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	out_size = sizeof(*out) + sizeof(u32) * (1 + num_protocols / 4);
+	out = calloc(1, out_size);
+	if (!out)
+		return -ENOMEM;
+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = out_size;
+
 	buf = calloc(sizeof(u8), num_protocols);
-	if (!buf)
+	if (!buf) {
+		free(out);
 		return -ENOMEM;
+	}
 
 	cur = 0;
 	do {
 		ret = devm_scmi_process_msg(dev, &msg);
 		if (ret)
 			goto err;
-		if (out.status) {
-			ret = scmi_to_linux_errno(out.status);
+		if (out->status) {
+			ret = scmi_to_linux_errno(out->status);
 			goto err;
 		}
 
-		for (i = 0; i < out.num_protocols; i++, cur++)
-			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
+		for (i = 0; i < out->num_protocols; i++, cur++)
+			buf[cur] = out->protocols[i / 4] >> ((i % 4) * 8);
 	} while (cur < num_protocols);
 
 	*protocols = buf;
@@ -299,6 +308,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	return num_protocols;
 err:
 	free(buf);
+	free(out);
 
 	return ret;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 519b906b4ce..9046de7e3e7 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -145,7 +145,7 @@ struct scmi_base_discover_impl_version_out {
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[];
 };
 
 /**
-- 
2.43.0

