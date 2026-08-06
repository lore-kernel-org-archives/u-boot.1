Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA5BC5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87E116085D;
	Thu,  6 Aug 2026 23:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UbJtEHRc8j_D; Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 908B760867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059899;
	bh=verjvkNO1FIKP9AkL4x7HfiXfVmaII1PYPquNIYquIk=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bBbsZZWTFAXjB+Wa7Q5XZyLVRm44PseHI163lR8SqDduml28XyHiMKfH/x9ptqpjc
	 91hfASxNovGXw5WmE5b7WJ37jch9oUTyymRtG9piXjJacPpzrhIfuw0jYwifvxJcFo
	 CkzrbwvokY3tt98US8jhMLShiM+E5jYSpwovhfrYNamY2Vj8OCUgNkxvhq/+Bqj635
	 wclNCZMOiS8c1Ls4n+pWjpQonwd4Mz9qH2fqEnF2si7lLCWN7yZPwvtAuRxIQsL+aK
	 v0iAjPN/T/mfi1UU8sJXobSyeFCY2ONOq7hJNqpt0PdAGFmULEoqNKlEZqyqQbc32e
	 JnN94sPDS1TBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 908B760867;
	Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00B77397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E669740910
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfpqSyuzfc8T for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 019DD4090A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 019DD4090A
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 019DD4090A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDmuvccMKniaV1GuLbykX5uytyklBCZ0HfduifgdKUpshApkfD3HLIbNo37yZ4oMutE6sheFKS6B1r+om0ZIT3/q7S2qZiVBAwGDi2g1O+PdNwusbyWG06braTuWiQa2hYKTX41FBudqdhk022zg9XqolJzSGNIqtDdvTzZQrIAxGBnA104OlTPvqSC1MsTz72CGKDGn87/s93K94uAFdJEUR9Bzm4zD+RLLEE3VvYtEi7y0sb2F8nXFHbLyj1jzmVUOpWUM0gqp2LjXvOwPqeNK9Dc6Q7OTC4TUFF/PKBMEB8gUfousiZturVoBf6o1UVgaMP3Uqs36ZsGCCTM8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=verjvkNO1FIKP9AkL4x7HfiXfVmaII1PYPquNIYquIk=;
 b=gPgEYr7WRw01fZ6TKj0PgnCQ45o2FYrGY27mEuHI0y55bNFLDT7RKy0+pVOtYZWEQt0bPnzOemgOWTc9xp2+trNQcjmV0GooTAtRXXfiJtqVxq1K1byhQT2/oIXMZKiDPue0EctQdOyi073xHCdn4wAnUEMJaXusVzHvF4R4yXmf7Rud6tR8iRFZ65e3a6HFDN32+jEkNVTDHS/RVRQhqM+n1Roy7EY5p3dMHTUa2uEeA+lpcw7e6F3n+FoONuyytgGQy1W+ueOdYPthjf9kr/KydZ/1kOzU/ez/1W7Rw4D8wZT4vNt7w7hzzARDVUOddDFkFD5Cnftbn/KQfsKFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:45 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:45 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 05/16] reset: airoha: Add support for Airoha AN7583 reset
Date: Fri,  7 Aug 2026 02:44:21 +0300
Message-ID: <20260806234432.4098414-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bf4391-1dda-4326-5dda-08def414b20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X0ZkCex/E9i6xBnbft+B5BNf5Dgc5zKWifIMTipPkaQaAsafHK11GXfXntOPVrtacLvqHWRAhAx3d7Evs715IeT5hgTsc6p8JF16Pm2FJg1J0blv4r2rzETR8QK9k/wNHl0wOQgryy08TibWRMxmDzmekGMhBxaEYloKkXaHJ9GeMSy2dYWvAElbStvzA6lgrSlVQLghJQ5Q3vcZq72eP+M9mV0aYLISO64jA8u2TrjYdl9iKcEwOjF2Tk/uoQnvbJvM0RwH1NTcZ7VLLk/8/suBAnMn7icfHl2HDdgz8f396g5mQG1pEd23zA+UGHkb5OtdOaMEfPSzA9OYAuvRnxeFEwO5oGkgR/AOpsOouT3qzLl+STOjbhPYTzu9SCxtmUaRN21DwrUaoBlrZWnKwuRYz+IgSrf9McxSxsuIptfcfNvX6hXMCpI6PTrEOcriUvmBRS1fhKAvma7VAvrnUVPc2Z8edLsKa8Z7/RStrtjur7CXe3CAke8defOtdnIru8UEFgZistVAlxEOWW9q3LiQHQBezQ/3f9pHAm9J1YVsj1Ln9upLtnl19a+W6xBGJNFIhp865tcrU428/26awnggZuNHRnugge3iC4Kzi8hFneS9ZdqGPlyd/Xa1LDrTc8o9lp4KLQ7VI3rSZ0jpxhj7LdiE0IBpQ9E7i2DrZK2ECXySwjYTOuuY6b5IxvUDsrauIgI14L8KiX6K43zErA61OwZ41Q3eo0NOxY3J77vuyB8+35rIU7Pj6gTHHQUa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?baRP/ueEypmyzVWDUcJYY7U7bOsBEtukEacSPmKZlqfR5atmIDJwGc/4cKd+?=
 =?us-ascii?Q?tpIlg7cLn6LD1p3jrNkrrCgNvpR97l7+A/foE26M8J4rwh5uAXnkuNOQSdXI?=
 =?us-ascii?Q?B5dA4Yfr+hH0kKpE5MhowK1C0OLKxAeM2Y9ta9FT5lETbXyAU9LnXshC2WWs?=
 =?us-ascii?Q?9g31lxBVgEhUY73jFcTsO+8zV9otV9z1BvjpGKfkxnkRdS8ww2hXuKX0xwlZ?=
 =?us-ascii?Q?g4aLFzz2U4p4rMXzFJrj5yN4wTl0QVSe2cS4STeAqeUUvSxJ8cVBrt66Xt3Q?=
 =?us-ascii?Q?tP0XFtXr6lnUutybOszVMHVFqwa3aNgRLaWOlP2yJ2tSSUeH7bYx0XjA41L9?=
 =?us-ascii?Q?VoHpoycziYR44D1tou3IlpO+vUuzkTB6wj3IvtsK7iUqLnb+Sws68xi/PYL7?=
 =?us-ascii?Q?RoAt/bM4voDB27OwWsF3ZZHv7Yx0GRvJfshgP4h1m2bRVgvrOMnW/vSWb+L/?=
 =?us-ascii?Q?9VyvadGP0qv+3v3IJm0EkTObswdzBr5iL9etfK2b7N/nWstfWvvFsZaiYVKU?=
 =?us-ascii?Q?IxJrTZrPRuGoFXW5SPIL8MCaavzIDExMGbK26nRwhhv4gV1yveEQBtsTeIUd?=
 =?us-ascii?Q?xCpetVZLTLmJWO53QUER63NNb5MdgjIshG29HDMOTJvlCQ2Rj9lA62Ed2Ctr?=
 =?us-ascii?Q?LAcbXkW6qWTtiMaz3GZvdhKWF7Z4c3Td7SDFTmUkkHSNMhpafAMvk6SHjRnB?=
 =?us-ascii?Q?/BmVrESAsHr0wefJfiWidOrO9lNC8srKXMf46SQ5nauA8dEM/t2DPMIpV9Xi?=
 =?us-ascii?Q?oIr+UKjOpvvNUSlCtUggHmrRw0d1q3mJ4LgNdKyNvlLJwoidvj6kv843aiLT?=
 =?us-ascii?Q?UWhgYCPxBA2Z3b6tVeTEaY490qWq8B9MZPY50wJn4FNlBUUkqAj9h5P85zhS?=
 =?us-ascii?Q?OqTbndSN2/GUWlSRTka+ys0Wm/zIncM/7Ew0rlVbeMjGyPss30NFcOWtYngS?=
 =?us-ascii?Q?RkP3v59WeqIglrAUN4ZKRfaIc6ZuwC5B4DAZpm3SHre2ZXVBBWwI1jVw09Ig?=
 =?us-ascii?Q?U3cJJc2UM5ghbuNefOViYGiqtqTNCALAyQXgLlBwE8Wj6hEStvmHQQsDiZ+E?=
 =?us-ascii?Q?nUZMKwaXXlwg9LxDNM98NY7DBBIZKpjbmoFm4GYSEBkBEwVYUdcxleBtof7h?=
 =?us-ascii?Q?9+QBDL8r2KrvGNLoen9DeX9D/haDbgxNs6kKrdI3e5/copfbT3czUS3eBVn6?=
 =?us-ascii?Q?V4tD6/IWJv38ICYkXKOuRLlsYuoGO65WxUcZcrerP5/g1O3e8aXalKgYW++W?=
 =?us-ascii?Q?ZBccwS0CxDDqcYgTEwK/h5tAwRnswpTTueraMPB7HppzrjSeKWCgOFcvLviJ?=
 =?us-ascii?Q?5zet/TQ7PjdkgpX+EBr9Gbt1sv8uzY+Zorw+hOqHhxpj7v2hLFbd2ogKpUcK?=
 =?us-ascii?Q?s86rUnIhrWuJIRnxKShOFXHjEyF1f0zU9euqaSz4TH1/fUDPe0t/6p+wQ135?=
 =?us-ascii?Q?/taVpb0EjV7sfV6AfK+JONt3vA9KX0nHRs2qv/u5pqTwGffT4GzY/5FEX1d/?=
 =?us-ascii?Q?2sn0llqRwIhOIyIDpxqAj9Q7WpFFbWQXWVFMIFjW0EsMxC8BjTdJGW6FUUZF?=
 =?us-ascii?Q?g7+En3Gn6vtyIYnpF/eATZpiFBnDeWv3/rrNt1EiKiI5+SLyRe+hodhGJuCA?=
 =?us-ascii?Q?Hg2ergFP5l/jvmwqFaJpAwDP3nvSd5qQjEuytJeZhh+UnHB0PEeM5fYObBU/?=
 =?us-ascii?Q?fla8Z/AjMG1Krk6UZL1FzCeUzlTFvCIfWKZl1Dw9MDLezmgFENCFhiDckBYn?=
 =?us-ascii?Q?6EcbMTf7hp2DbbcqFaoE8QdbboLVEHg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bf4391-1dda-4326-5dda-08def414b20c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:45.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utKGadWHL31m3OwRj6S9kN+mzd5NUFJsrfqdvH9uZMNrpONQ4R078Xwr7uziBiF8PD3bn8Dd38GXmPQ8unNWre8i7Nnuk8bbJuYeBdaKLx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=verjvkNO1FIKP9AkL4x7HfiXfVmaII1PYPquNIYquIk=;
 b=hdqXYctdQ+bnygsynJjG+nTCxbBcMaNmwKKKpR7GVngxgrghIxj0nQMNebrzLmKiYRZNfEl1vP8LZMufWkQ4qUsId0L5hBswkm7+4NVmskCsJmJscUT2/DgH2J8CnSl1x9/ndGo0R89pXjYrIMt1yJRCvC0PPEMg8u36s6AkVjimqTAEfLCoG2svkDK7RJuqk3xgoIxYWCit+VYy//Yuwua64SmQlRlRWxrRBXvhf8yLOlijKlCodipJgvEKDHXGOS2nfYjxRAT2Zwdz4nnBBPy81TYmGE4+mMcOAqK20bO/R/x5+daYnpiodwUrpG50XR+Qb5mOFk6nnGpCan4sMg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=hdqXYctd
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

Adapt the Airoha reset driver to support Airoha AN7583 node structure.
In AN7583 the register is exposed by the parent syscon hence a different
logic needs to be applied. Also the reset line differ from AN7581 hence
a dedicated table is needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/reset/reset-airoha.c                  | 60 ++++++++++++++++++
 .../dt-bindings/reset/airoha,an7583-reset.h   | 62 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
index ef8c47a067b..071f29b6f22 100644
--- a/drivers/reset/reset-airoha.c
+++ b/drivers/reset/reset-airoha.c
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/reset/airoha,en7523-reset.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
+#include <dt-bindings/reset/airoha,an7583-reset.h>
 
 #define RST_NR_PER_BANK			32
 
@@ -138,6 +139,60 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
 
+static const u16 an7583_rst_map[] = {
+	/* RST_CTRL2 */
+	[AN7583_XPON_PHY_RST]		= 0,
+	[AN7583_GPON_OLT_RST]		= 1,
+	[AN7583_CPU_TIMER2_RST]		= 2,
+	[AN7583_HSUART_RST]		= 3,
+	[AN7583_UART4_RST]		= 4,
+	[AN7583_UART5_RST]		= 5,
+	[AN7583_I2C2_RST]		= 6,
+	[AN7583_XSI_MAC_RST]		= 7,
+	[AN7583_XSI_PHY_RST]		= 8,
+	[AN7583_NPU_RST]		= 9,
+	[AN7583_TRNG_MSTART_RST]	= 12,
+	[AN7583_DUAL_HSI0_RST]		= 13,
+	[AN7583_DUAL_HSI1_RST]		= 14,
+	[AN7583_DUAL_HSI0_MAC_RST]	= 16,
+	[AN7583_DUAL_HSI1_MAC_RST]	= 17,
+	[AN7583_XPON_XFI_RST]		= 18,
+	[AN7583_WDMA_RST]		= 19,
+	[AN7583_WOE0_RST]		= 20,
+	[AN7583_HSDMA_RST]		= 22,
+	[AN7583_TDMA_RST]		= 24,
+	[AN7583_EMMC_RST]		= 25,
+	[AN7583_SOE_RST]		= 26,
+	[AN7583_XFP_MAC_RST]		= 28,
+	[AN7583_MDIO0]			= 30,
+	[AN7583_MDIO1]			= 31,
+	/* RST_CTRL1 */
+	[AN7583_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[AN7583_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[AN7583_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[AN7583_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[AN7583_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[AN7583_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[AN7583_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[AN7583_UART_RST]		= RST_NR_PER_BANK + 12,
+	[AN7583_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[AN7583_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[AN7583_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[AN7583_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[AN7583_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[AN7583_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[AN7583_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[AN7583_FE_RST]			= RST_NR_PER_BANK + 21,
+	[AN7583_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[AN7583_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[AN7583_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[AN7583_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[AN7583_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[AN7583_CPU_TIMER_RST]		= RST_NR_PER_BANK + 28,
+	[AN7583_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[AN7583_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
 static int airoha_reset_update(struct airoha_reset_priv *priv,
 			       unsigned long id, bool assert)
 {
@@ -227,6 +282,11 @@ static int airoha_reset_probe(struct udevice *dev)
 		return reset_init(dev, en7581_rst_map,
 				  ARRAY_SIZE(en7581_rst_map));
 
+	if (ofnode_device_is_compatible(dev_ofnode(dev),
+					"airoha,an7583-scu"))
+		return reset_init(dev, an7583_rst_map,
+				 ARRAY_SIZE(an7583_rst_map));
+
 	return -ENODEV;
 }
 
diff --git a/include/dt-bindings/reset/airoha,an7583-reset.h b/include/dt-bindings/reset/airoha,an7583-reset.h
new file mode 100644
index 00000000000..be80d0e0bf5
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,an7583-reset.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 AIROHA Inc
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+
+/* RST_CTRL2 */
+#define AN7583_XPON_PHY_RST		 0
+#define AN7583_GPON_OLT_RST		 1
+#define AN7583_CPU_TIMER2_RST		 2
+#define AN7583_HSUART_RST		 3
+#define AN7583_UART4_RST		 4
+#define AN7583_UART5_RST		 5
+#define AN7583_I2C2_RST			 6
+#define AN7583_XSI_MAC_RST		 7
+#define AN7583_XSI_PHY_RST		 8
+#define AN7583_NPU_RST			 9
+#define AN7583_TRNG_MSTART_RST		10
+#define AN7583_DUAL_HSI0_RST		11
+#define AN7583_DUAL_HSI1_RST		12
+#define AN7583_DUAL_HSI0_MAC_RST	13
+#define AN7583_DUAL_HSI1_MAC_RST	14
+#define AN7583_XPON_XFI_RST     	15
+#define AN7583_WDMA_RST			16
+#define AN7583_WOE0_RST			17
+#define AN7583_HSDMA_RST		18
+#define AN7583_TDMA_RST			19
+#define AN7583_EMMC_RST			20
+#define AN7583_SOE_RST			21
+#define AN7583_XFP_MAC_RST		22
+#define AN7583_MDIO0                    23
+#define AN7583_MDIO1                    24
+/* RST_CTRL1 */
+#define AN7583_PCM1_ZSI_ISI_RST		25
+#define AN7583_FE_PDMA_RST		26
+#define AN7583_FE_QDMA_RST		27
+#define AN7583_PCM_SPIWP_RST		28
+#define AN7583_CRYPTO_RST		29
+#define AN7583_TIMER_RST		30
+#define AN7583_PCM1_RST			31
+#define AN7583_UART_RST			32
+#define AN7583_GPIO_RST			33
+#define AN7583_GDMA_RST			34
+#define AN7583_I2C_MASTER_RST		35
+#define AN7583_PCM2_ZSI_ISI_RST		36
+#define AN7583_SFC_RST			37
+#define AN7583_UART2_RST		38
+#define AN7583_GDMP_RST			39
+#define AN7583_FE_RST			40
+#define AN7583_USB_HOST_P0_RST		41
+#define AN7583_GSW_RST			42
+#define AN7583_SFC2_PCM_RST		43
+#define AN7583_PCIE0_RST		44
+#define AN7583_PCIE1_RST		45
+#define AN7583_CPU_TIMER_RST		46
+#define AN7583_PCIE_HB_RST		47
+#define AN7583_XPON_MAC_RST		48
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_ */
-- 
2.53.0

