Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA1CCF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A0D5891F6;
	Wed,  9 Oct 2024 12:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ywmdAMhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D962891E6; Wed,  9 Oct 2024 12:51:23 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE10B891C3
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pkek4XQ5Dfw9rdMiDt3EvanlnlTLV7lXnponhZdSu8KenCVkqsGU58EVCrsVzq/1L5TpUhKy0UzK6z3fMoD2s2Vn3EigUVQgm19xZdhKQJ1fvdFuuOwX8Odi+JixBu2/bJScLMC5FOGyf6vXv/ECVSP3aIlzOx6r45lrTJ+dwp0h5oV2x/v4U0L+ta02bSJ4E0ibNuXtRa84Bj0R0v1XSmsVQVhvebonduJtxqkvigTu/d/QhXSO+fnYppxmvQcAIoiKBzJ1Oa1Tr/8bbBAAtl1w4A2KNLosIdVTfUbDHAc1CxjyVispFK3TRVMvofjmN449VUEnY/AvtfViOgyo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVmvtF4y4l46yXIwgV7SvinwH46+8+ePDLtrHKzaUUQ=;
 b=peraqxRmu1Yy+K4pt6yYpD2t1BYBqphznLRzQKdWpX0Q63WUZZa6bBXK2F1/aBJ95aoMtnzWpAP/L17E5bnqZduPvE5K24/KasBQMPWSXQXnZWR3uOJ1Ot4ktpl34f8fZi4zAclKIs8r75CcqZ5lGYqLEOUSudn/SqWgS07TCpotNejz7s/lrVvsVm+gYiqOIhvwoIAZwEQhD2GDNo5Bp7dbvcFDDBn+EwtM7ssx2/BmbKfJPNxirCgPBSq+ZkPgpkcx+QZyPIjCoOE/UmL2D96fVfMK36i+evtHZPjxX6a0KkHyYLjcocYiL79ddp+SRD2nzHh9VDH5a78Nmf/Gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVmvtF4y4l46yXIwgV7SvinwH46+8+ePDLtrHKzaUUQ=;
 b=ywmdAMhQVylfl+cLSGMOGgcZYW/m+hbHLoKVnlvteaX16xleGCiJ1ZDInnYFg9sB+ezidjfEtFuWOa/2r1c5+WVO902/9imF9aHziQrI5W7cgotBOTvR10l91f1IiIMyhjKT+pm1mtPGIZemlZS5HYhKniuvQn9z5+BMSVYlTsUU01JYbrvwUG0NfwP/JkfLrQwSeBjmZ3dXD13hjGmZQFWxfWESIWDbsZCbiEw2tDNijM5gfXFRFPiVvFwXuqlKmme+QbGOcgPmJvSiuPaA8Df2QA6yXJCzVJy73RuW5yREsAY1LXB3PvS239NJekvV0XmwcgAKlg6i2OLTJSvQWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10026.eurprd08.prod.outlook.com (2603:10a6:20b:632::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 10:51:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 11/13] net/netcat: add netcat over tcp support
Date: Wed,  9 Oct 2024 13:50:52 +0300
Message-ID: <20241009105054.1879054-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10026:EE_
X-MS-Office365-Filtering-Correlation-Id: 00df7a27-baee-44d7-ef50-08dce8504e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2M3735hxxzM1F3sgo1HLKSi3VZDXU1eoRl/OH5tCcKO58F6ZZyTgDUoW6SWF?=
 =?us-ascii?Q?9OoO8O8y2xsk9qZfkpSWwbz26XdQiaJdXHczvNz2IPO9FS5wmpPQja0LHlBo?=
 =?us-ascii?Q?rvB3bXw2el1k14O1afo/redZQdmfS9s/A2TrOFSpNUO526tPOpTbBuKakh7z?=
 =?us-ascii?Q?dvQXajf9cf4Sff9ENAMMdyoiKw0Sld3wb3KxUhuoQ8iSuVDZ4egJ6KWpo+WU?=
 =?us-ascii?Q?+KeiLFfLGYFl4pUtu518AGSGho1aNyLcTdyotkl2bvJuPdltH4kh6JK30bbA?=
 =?us-ascii?Q?0Hkv45QeG9u5AggLiEseuDWFoUY3qCuq4yWlONQWOhlJhgThdGhGUKguj7XV?=
 =?us-ascii?Q?smdYMdkennfnh5eR3V4FUkbw6m7jebrYGmFWdUIyERDNRvouGJO4n2+9SDRL?=
 =?us-ascii?Q?0+gQrvURXVvyuIXrET5/Xeu/SrT9YshBOzdPGNv5LMR5OhEGQ0O581avHu4G?=
 =?us-ascii?Q?ndjeuChfTz1UbcQbGUU6U5NJT9k5hkQ3GAEq0Qh+1CztjFpvhWom+7NNQnE0?=
 =?us-ascii?Q?mDYyxwbsuVrniJMAcKG1xxLP5bwADKXuNAcHYHInBYf7fywJX2eqt6pJ+FO/?=
 =?us-ascii?Q?Co6F+uKxFFLkM6jIQTjTOmCE4FtSRMgsfjvXh/80E8MkwqIQj7GC/ogQu2BY?=
 =?us-ascii?Q?hT/+cKrpq5ZSLREZtw4O3LnyQIvaWwkvMTQeh8yM0thZt+MZeIzeCa8MyJ8D?=
 =?us-ascii?Q?LqY24Vy6NW+/QHitt/fxawTJ7W8a5TJOSmXXzq+7AJJP86ROPXSlIkxPMYWO?=
 =?us-ascii?Q?7qEXLk5853sv5vUYoZxfohLurjBsULQ32492LCefUx326O86cvFtMIGzf8ga?=
 =?us-ascii?Q?hchRNEzWBdPHXf2FQzqZx9zj/Z6Wi1fwPP0GOqUotVUUjyWp2O+JhF4+da0u?=
 =?us-ascii?Q?8tmxT82DYLq38zBBl60hESXXK7ONFPTWE4OnV6bc8XG9N7VTEtqptdhybRwK?=
 =?us-ascii?Q?XErfPxUjjBds0sVqmCjTME67mRWiAZmJUSpQ+25THvxtb9vDg8VzilUPIbDR?=
 =?us-ascii?Q?9EyrebvtkjrrqUSUv/CDAKQHjs33Sm0RxCd/k9L3tZIldhamqs4ERBhmxHWp?=
 =?us-ascii?Q?diZn1w2f4VR52golKQMax9uP3+OVN3x3zWY04ipwjGD7EZSSSU8Ktt6ksap9?=
 =?us-ascii?Q?VIGcrK0V949119yRID7nEZQUkx9NjYC2gmjDi08wqSkXKr2oZNBOKK8cLF5F?=
 =?us-ascii?Q?H2oH8Z9zxhcTcGBHrY4TJPXh2n3sCE5VrND/x+07QJpCN+88flqkBOAyXSYQ?=
 =?us-ascii?Q?PeAcP4yfnrkY5C3/2byTM/1Fut3SA6Lts/tdTiduIp9D5E9LMx8+Mq8AHzbQ?=
 =?us-ascii?Q?UHhOJvu9iJcpSrXgHDMnxltwN8IAwr/1QuQZf5WaLrnjk+ITKUnguNwwz1DM?=
 =?us-ascii?Q?Cp1Rdnc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+aP+PnB6QDvl1/RMTEsLljdHgNIsfvI6QB8FXKbSF9gQ6zdMEQZPmdcz5fSN?=
 =?us-ascii?Q?N2lpaH8CtDtZMaeAZZTban7mH7HiE3MWKtKqJNzxbokcBrOg9rUZxPLfe7q2?=
 =?us-ascii?Q?2iYhMv2ZkoPn11Trt68e6mMJNPfaVn10xxxmAq1Zi1pAIkyDL/gJgyj5NBdL?=
 =?us-ascii?Q?reyL0Ux0xhw2nqpMuTjgY/BrrQeefIwSXzuPBmRqvhXtybvt8iL26r6Pjh78?=
 =?us-ascii?Q?bEuHeC3uspOhieW+xACQlVkMNuuyYQdWlzdx6FCyBXgCSPvS4cvJeutAVEWM?=
 =?us-ascii?Q?C4pKa60vwo+ubHSKahoufI83KUG4StXvpn3wrMvKPQ61ImI3clMQrx50EZ+M?=
 =?us-ascii?Q?I8HUtLal0A2QnupDr2QYjlNzg6GUcRIF3ZEVfmIjZicdl1FAzSh0H1crl/h2?=
 =?us-ascii?Q?PjUL9y0XULfxRjn99X7DHnBRK7fjtWXSX5wsmsb3Y4h8z0poJHMWMxHESS4O?=
 =?us-ascii?Q?3oYh0DNshfwmL66V+gLFF+0r4Szkz+i7TwyJe2Wf9+Qj2JpIEVAhTc1drV4E?=
 =?us-ascii?Q?asDNbbVLYwdTwXlGRggelMY5JWm0uWsgQ9VUHX85EqVkTvaXUV2WqAsuVvm/?=
 =?us-ascii?Q?Tah55xarnTGE39JWZ7lZcy1Pp27EbxAnAnIKfYST+0MNEgW4yuiFFviNaZ1V?=
 =?us-ascii?Q?Nuc/3++E/fgIVCQFXbOiw+iw9zBwtkMH6p11ZoGOS/PYFNRwzKe2qZTCHPmp?=
 =?us-ascii?Q?l0/ZkcNtYecYovF2o74LKSRfmUil2U9ntTEpCRdqsQV65PcuRvGFTkCcvR7E?=
 =?us-ascii?Q?L8VezOG0fPFSIJHnxEW0cuq1xDpBW8D2DxY0ewV348Kg2GHw68Dmg2EWi7Ao?=
 =?us-ascii?Q?BzdIUI4vCd1A7UILU9cXd8lvoA5C5UFZ+BaIncuxmNv9hFx2wUaWsMW7flkY?=
 =?us-ascii?Q?sQMZ763kB8lcT1Bvg8boxC8VyFSX5KH5rMvm3WyBB4YN3v5AR4VEAqzx8qCd?=
 =?us-ascii?Q?ecbpT7/4GQkGtF+k2+7QQJ9n2wYgzKRq3fvhx6v2D2iSHp/r5ZpbO4L1+Baf?=
 =?us-ascii?Q?3Zn72j7xivsA1PBLLdSfRwi+R9u0bO0zwJonIMuY9it4XpwnVdIHjeIbCTAo?=
 =?us-ascii?Q?eZRuks+tFVSmxEZGnjmzRgcJsXr0KR0CxQz9tI+xuGDKoCcT4tp4qPbCqtyR?=
 =?us-ascii?Q?EAswCuvmL0xotz3PyKtX+PImjo9ofCVplLZT251aja7r4dAp4N6//Ixg7eNt?=
 =?us-ascii?Q?zne18diIpsIYumJ7HTRc0gqgYGktkSFjFnYT8+szJ+4PUwfC1jT5ZHNsLrYA?=
 =?us-ascii?Q?f6L8MKE8IZMPtegcbl/DIKOoodYUtsEVk0PVYRdS2UDscr/+tHrzcwTdVPqk?=
 =?us-ascii?Q?CCkqs/4bXcFqEz9LJdViPtGpNE3Wo67igHniaG8PnISeNSOxPHMaIZz9TBiv?=
 =?us-ascii?Q?56FU6+ncpelnaYCG/YAOns6NS4jggRw0e+vWXAl0Dc2iB2FmXazrAA3Gr4P0?=
 =?us-ascii?Q?Nk1gRGrDBy39VQnSfePa8pO58T0EVpC13hi2wE7AXkyxTFQBoGk8LhAD1qbY?=
 =?us-ascii?Q?Mxy2pCycnEBRS6de0Jx9tOJIUeVE3cmb4I+LNVZmpCnSiQhc/BUvtOh+AGL+?=
 =?us-ascii?Q?tDNsZze96vz/0Ci1cAHxtqaTkT7E8XJKaJmaL0SzXQZ2CfKvAMFhPqNJJdGU?=
 =?us-ascii?Q?tv+LLeG2Sn6xMDk8Qhc5Ylw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 00df7a27-baee-44d7-ef50-08dce8504e41
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:18.9191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaRo+yTXpVOMRShSVHRfepbx0uFtcmvSthQ7tjAJBI6mcrGOboqOGsG7JKN3CtrWpaZ92pXhWUh/IINvmB6aPLgfGztm116i9dPM3qifTRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10026
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

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
 include/net.h        |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 262 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index dd33266cec7..d142a376641 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2031,6 +2031,16 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
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
index 53ce2bc5d0c..79bb126dbd4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,29 @@ U_BOOT_CMD(
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
+	U_BOOT_SUBCMD_MKENT(load, 1, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +346,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
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
@@ -354,7 +378,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +390,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..0af6493788a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
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
index 64ab7ec740a..dac7b4859fb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index dde6009abd2..978fc1978b3 100644
--- a/net/net.c
+++ b/net/net.c
@@ -102,6 +102,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -571,6 +572,14 @@ restart:
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
index 00000000000..7a450dd6405
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,191 @@
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
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted",
+		       reading ? tcp->rx_packets : tcp->tx_packets);
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
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
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
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
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

