Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B762DE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 03:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0DC8021A;
	Wed,  1 Jan 2025 04:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Gf0uXi/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64F58031D; Wed,  1 Jan 2025 04:33:43 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE2C80196
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 04:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK4HfUnWIAuKZDMmwcxLXkl9gWV6YEGbAsKf7yFChpsKj2ZECCMgHwBWTApMvlh/Tyt628z4W4FEYxPKcgUpYGxK32tT+i2lU4EKrZGVz4mDg3sWC2kVQPIb0ZIppbaykbfszKdzwfNALPeXBMia7LSjQhcWV6YIH8sX4GcXbBkJX5A6NogH3Ux+XXc5i6X1pq3yXIcCoXtA3DCdAzUo6HzNVCcaPFggyny14yDB9Q90WMul968t5gxzVmHAKfjdCedFlcMIQq+XPvhOvaob4FZNpLstrK2DmYbCLxanyIzAx+UIKNzJ3U6gEIlLUAPT69VhlTLT0MZyUKKt4QMpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmq7TyuAXrkQydgQE6erLCdK17kc0U6cJcR3Ecbt52U=;
 b=GJNoUhmZrIU1VQzbFaA/qhFk4Zt2QKrvqor8WdyaFdnwWlAzR0OU6vr9sIESxsUkidLMrGTCWBN6LpXx9WUdU9WaASX/32FsT7rABQ7DkwpU98mK5OtRCg4B0bj7tLzgIuTM/3dGwip5tLuYU4TMrlRVVtq/jpSeMTn4LTsRDM5M8DpEw38wvtJBgm+G2W12oDjsi3JNinc8TXZLtk4AjtdFqlezFC9JRuPi0G/FdTvk8YiaJuMw/0dwHPtelKZ2uEdd/RQ+gfZqVVmqrBLcmeGm3qDKImF/Dit8ubBjUFfr0vtWr5fqXO3Emx6CY26ohi80icJbJGU+DR+RYjySkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmq7TyuAXrkQydgQE6erLCdK17kc0U6cJcR3Ecbt52U=;
 b=Gf0uXi/sdLZxaI2Jisx/yKMepJ3T59FQi0En55TWFImZGjLpvpfQKrb41/iW5ng5HlwVPAYYMrqWiDq7HbVWtC0Polfy5t8W9kCcodgybCO2n42C5S+QFEdJJqlCz5pdUH3FwRqpHkYO5dtleP7gaS7aGdZdo+ME5D/40GsfCVBLU89Jf1BFo3V6G6/0XPVJO7QSF4wKMrJDDjx7Xvy+ce1y95DSsXAM2JYMI0kSFBoZKk36rk3HrmUDN4z93A/v4RHqjGmSWyjNV0b7XL+YxnzcmjYL8Lf7/kJf/KRL0pdufrSwJ9hYPBiu20dWLqAAEYMa9Pyn22b9zG5xZZTV6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB5534.eurprd08.prod.outlook.com (2603:10a6:803:135::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Wed, 1 Jan
 2025 03:33:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 03:33:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] net/netcat: add netcat over tcp support
Date: Wed,  1 Jan 2025 06:33:26 +0300
Message-ID: <20250101033326.439585-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB5534:EE_
X-MS-Office365-Filtering-Correlation-Id: a978a752-5cd2-4419-b90b-08dd2a151196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bDqGfpSfDrKTRAsOZwKkZ1jNPmE5zGFo824ijLg8QHcTeNOVuZM7WEQ1BhnR?=
 =?us-ascii?Q?QIa0nZwDj8Ah41USliA6aCElykJLJ2pcLwk7m59kdBxmD9gqCZ0gHih+qcvg?=
 =?us-ascii?Q?wxNjbEYldNnXRd56Q0owszTRQprODb90EOxAcslBnoqswEKNAI3I7sawhPrY?=
 =?us-ascii?Q?r5dfIotP5O124Lxdc6jxec84oDS+Od3Q3AREVly4iFmQclU6tgikSlJ0n6JO?=
 =?us-ascii?Q?pMMtTu2vMQvcsMG4Bn5Udnuywd60bo0KcTyhY9tevtZfLPVAEXlGVBQ5ma6j?=
 =?us-ascii?Q?zcHKEr1cmZ9fnbuJ+k/lVl+7gZ/BK+UR2FM/jFo88lpVDuR3VHEZlfEQnZRY?=
 =?us-ascii?Q?O+VRU0iZkwe2S4eIfndgKgj3FXJsCrocarrep+o+1mgrSrJcxFsVj3oPuvWj?=
 =?us-ascii?Q?/nWltxS9/YUU0xS96AQuAMEkZl2Bj3oGFfVumYMBkK+XkZScBp8wQ/+E5Yib?=
 =?us-ascii?Q?3KGJ16ClsrmWLiRbWDR3jOtmz6O2v2ZF/n0MDq7wiCT2K/GefrRR7Zw++8y0?=
 =?us-ascii?Q?fEPCIeCBms9N2DvbqTR3jFKqyR7zVB9aKjB0TENwekJGXNkRasOZTin07ZmY?=
 =?us-ascii?Q?teYWSg9nOK4tReTJtKyoBYkzvHkJvzm0WkF9i5x1HhQrgy4DVUV1UpKR5OeW?=
 =?us-ascii?Q?byvdUxTEdeGOmVqCkWbUTtYPY43cWa8B+YUP7FVQncBp/G5djM3DEGsoMPoo?=
 =?us-ascii?Q?QJPTHKSx+T7QRjdUYy8Og3TG6g3vvmeeTLS8NjqFSTwJqiFN/y4s66ou4nxS?=
 =?us-ascii?Q?2Dewv03BEvv+38rjr7x+XNgJKXI0Sa/18kjqfg+PjFBPphf14p4HErDYnGFE?=
 =?us-ascii?Q?8/h0UgsHo50OVYX/D1Zsn/yfe+rK9c/V+DipgMiXZXiJYxWwvag6VNbHSAGo?=
 =?us-ascii?Q?UA3/yz4YXVRCYQdTxG57GrzsYdCg3T4racq2EB0n715OC8SHH6BbPAwhFXfW?=
 =?us-ascii?Q?Kq/GAqNaKYzMDdrCmqccPiYVZtMEirLvHCKNFl0hi2pzigjx4simsyFw547+?=
 =?us-ascii?Q?3u2rAfF+JUPP3wi/ZFK+EeQ/4e4H6jH8vfoTxvEJpvF/vef0TIE+owp5OIX0?=
 =?us-ascii?Q?yvgwWZ+y2s+Kh0rkUuU4YhYebptG/D3+nlX82BHurXwRMlKOTWnpxnwcBs7u?=
 =?us-ascii?Q?Se54oof8uJiZ5rQa9LC0H3pQJMBtGcRHSD8LpFNIuWJVtCbmBylIDTI6ig9I?=
 =?us-ascii?Q?m18zL1vAc28RWGf3XM3kGPQ3Yd/XHnR/t0oKOPP5pfNZsj44Sk5rQSaR6jTQ?=
 =?us-ascii?Q?XwkzTS7IhSlzQRpJYzBKU39C1U15UecbrxLjYwCA0/5+h2Z9ZCdZpvHxiZvp?=
 =?us-ascii?Q?V3oDk2Kqn3fqwlcsPh9naGMVpC/7WGV4h7ZfkaojOVSlc2QHvvUIMTmBvfhc?=
 =?us-ascii?Q?4YZtD8NHci+kTzAtXtv+YQbHVbD5ZDUFq/0pmzIBqbvix3zsfYCLcbyKI6dg?=
 =?us-ascii?Q?fH7aXMk46djGmrJksv1fDbYDqeoeKlkqFfUWJY7e6wiNrJBXtuwsIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zw3KRH3VbwMQPsVDtLEzf9KTbvezJrSa31YtL9LE2A0wLPmLljz6AjWQuNKk?=
 =?us-ascii?Q?hgZvVA9wEgZrfrpsQ7mcsnGEvJWJuaqJxLXuSaSdkkxUeTV7RGtcjDd4qlEQ?=
 =?us-ascii?Q?JtBkKHU3dycOBYlBXrHwuoGmuOUmncq1jQjIENrdkw/ecA5KuHAzn/a57pPD?=
 =?us-ascii?Q?s4jg7gAhEU1/ZM4peJCfwW/+aysZGu7jih6TDo+LRkuv2U4T294+Fdm3gbb3?=
 =?us-ascii?Q?Uchxl6gcl4TzqvyNpWVfMKwQoc1flN+l/2KJC3G0o3aSiKTev+OVWMhTDAHS?=
 =?us-ascii?Q?e+tZ3t9+1/cYpoVqnYST/ngZc+I/szDW9ukir8qKSKlNp6Vjek3bOtc5UvHa?=
 =?us-ascii?Q?UP4nA6uUIQihhe6zSO0SIoWiPWw5ff2cVnn+9trzaGX3ZMjjN9dElaTeWAau?=
 =?us-ascii?Q?I6RTQCw0mdSuU1FunjOQYDv2cnJu6u4+7vCfc6Dpb5l5/FhBQpw93yDHeIht?=
 =?us-ascii?Q?/AWfeG6almgSVeDb4oHNw6eEBtJX2N5cZo3GEod/DNI/pEZFtZpiNtlqweO0?=
 =?us-ascii?Q?nKPIf0zJDib4iOQ1zeYvqYaBPXIZ5rjXIjAvoPjIYk+IP2g1xzRVs/r0XXCX?=
 =?us-ascii?Q?J22krlNMgo5ifpJiS8LMwni9CexUfpsef4w9hP6pUx7gfxmnqqgzU4G3zPTs?=
 =?us-ascii?Q?f8QT+EAa7E62N+vb6fDyTLuwv8WwCxr042hy1KQpvmFgTyP5eeuPGO3wWN1I?=
 =?us-ascii?Q?syz69Kda3e+Jkr9QlG5/DsMkDoFd93gZ5p7NLa41eeR/Uz0fR4tDocHq/COC?=
 =?us-ascii?Q?JF0vDbQMfTni2Y+OVrpJ2LxlGjvaBa4qwCIM7vjutLJY1YJYqkTFKY6iylMh?=
 =?us-ascii?Q?iTaZeArfM8DmvYvCftbQG8NCABDIFMhW+y6EePWKjDTmiJx+pRECjWstipRy?=
 =?us-ascii?Q?iyYjmhsRIjSf2lQNqgTPlVOhWmlp8c4z+l3HR4obT2Xi2g2fTHKdi9fHQ/Cn?=
 =?us-ascii?Q?irQMUbN30o0x62XiV11xPX9AJVjmIUJa03pbmpuQGBhAmoJGJPiOouPySvh0?=
 =?us-ascii?Q?/W+dQ0TqSC+TH4c4GEUz99QI1O8z7e31olk+981o4jfIwhvDWFXXrCCDoY/r?=
 =?us-ascii?Q?3VKvvcyrSaquseKn8aGQmW1Ixgn/A2PeJy4yDm+IGZ/9+8vzsvKo/YyryoKI?=
 =?us-ascii?Q?1TqlK73ZXCaLuHrtL0sdBY8wF2EQSYGP8YNQbb27+wsGrUAmJ1InqCszUxx3?=
 =?us-ascii?Q?XyCYq5VJGCQsInkLqA/KJ4DgPBqahGspC+HRU6XOLBVKw6QP3PLsflCsNHbw?=
 =?us-ascii?Q?XIAACD4MoS+yzNc9EGOaSzi5QbQpGcOSYLsJtoCDotGwsw+amGp7CdA9P/Pe?=
 =?us-ascii?Q?ko8KcHI44eIlnEtySKmvGqhgNnwfPgSrsMrMWqo4pvLcIFhOD/TAnHQZSAiJ?=
 =?us-ascii?Q?5GbxuIdw/uBq2h4nELO8zKEMXl/l0rmc/gIb9Yaauuc9HD9zwsD7Uc+Px1K7?=
 =?us-ascii?Q?FX3OYAQB8PwIFxc9vV/mXajoBjsuZsZji/181tIqc6yrdWzgLdNzqzRwmG0j?=
 =?us-ascii?Q?6kwbDBtBVSXKnynYUm+NYBNjUCM9nYHNuwiegaC4V7zhNVPG37SGzQlER9tK?=
 =?us-ascii?Q?lKwqxUPCx4B0kguHSI1vtIEtDIGnyXbEhq7n4aWmB65JunEDBEJIa8GLuOZB?=
 =?us-ascii?Q?BicocvSX+CSkGU2DACAPKCc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a978a752-5cd2-4419-b90b-08dd2a151196
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 03:33:33.5789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10usHyMmNqwFU/1eJ2qwGQUHdbM6gW0odEjChyVN0Mr4Jvy6h6Rtlb3ZFnEj8YQzeolrenv4dcabElnjmWO9t1xV9JH+SgGapZNIuKaUK7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5534
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

This patch adds downloading/uploading of data with netcat utility.
Client/server modes are supported both.

This patch is also an example of using new tcp api for legacy stack.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig          |  10 +++
 cmd/net.c            |  35 ++++++--
 include/net-legacy.h |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 265 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 93efeaec6f4..e37e50a18b5 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2091,6 +2091,16 @@ config CMD_DNS
 	help
 	  Lookup the IP of a hostname
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using well-known netcat (nc) utility. Unlike classic netcat utility
+	  this command supports TCP-based data transfer only, thus no data
+	  will be lost or reordered. Any netcat implementation should work,
+	  but openbsd one was tested only.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 79525f73a51..d7a5025f940 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -208,6 +208,29 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_LOAD, cmdtp, argc, argv);
+}
+
+static int do_netcat_save(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_SAVE, cmdtp, argc, argv);
+}
+
+U_BOOT_LONGHELP(netcat,
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]");
+
+U_BOOT_CMD_WITH_SUBCMDS(netcat,
+	"load/store data over plain TCP via netcat utility", netcat_help_text,
+	U_BOOT_SUBCMD_MKENT(load, 3, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 4, 0, do_netcat_save));
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -325,16 +348,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -356,7 +380,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -367,7 +392,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net-legacy.h b/include/net-legacy.h
index bc0f0cde9fe..84a4beb9ec1 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -305,7 +305,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 /* Indicates whether the file name was specified on the command line */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 7c917b318c0..bc5f2f123be 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 1828f1cca36..595bffdc532 100644
--- a/net/net.c
+++ b/net/net.c
@@ -103,6 +103,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -572,6 +573,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..47dbebe5ae2
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+#define MARKER_STEP		10
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static int			marker, marks_in_line;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(int packets)
+{
+	for (; marker + MARKER_STEP <= packets; marker += MARKER_STEP) {
+		marks_in_line++;
+		putc('#');
+		if (marks_in_line == HASHES_PER_LINE) {
+			marks_in_line = 0;
+			puts("\n");
+		}
+	}
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS) {
+		net_boot_file_size = 0;
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	} else {
+		env_set_hex("filesize", net_boot_file_size);
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted",
+		       reading ? tcp->rx_packets : tcp->tx_packets);
+	}
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker(tcp->rx_packets);
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker(tcp->tx_packets);
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len)
+{
+	void *ptr;
+
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+
+	return len;
+}
+
+static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (!maxlen)
+		return 0;
+
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if (tcp->rhost.s_addr != server_ip.s_addr ||
+		    tcp->rport != server_port)
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	marker = 0;
+	marks_in_line = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (!strchr(net_boot_file_name, ':')) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (!tcp) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+
+	return netcat_start();
+}
-- 
2.45.2

