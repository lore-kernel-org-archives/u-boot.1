Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DA9E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3554283D8A;
	Thu, 19 Feb 2026 14:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="oooOcLHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1341083DBF; Thu, 19 Feb 2026 14:26:18 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4446B83CD3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsT9dURNVY8GetDguuM2KLf+cXZsRVfkbXCRAxxdt+MaS4QmiCrzoid314faVKxx7qT02AUygXLzORZoKTEir6Q8vi+RyW4ZZ9E2enWXPHyXSkQSdgCn+0vSaF+ZvHfyNwIYcAOqUtB0cmEZX7oW69X4LPG2EpQQWFpyZFb6Ew3xQZY8yVW0bNCmjXn+zmanmP9erwHdrjBHONuKfx1zb72Xq1pslJrp7y5ZBhkjLSRVMkpJcONqSTdrJrzvVrdeGP+hXvmd/1gj8TvgUa5l8rpk8aNcZZov7kTBaPwz7+BmqPIxKNJjFk/ccq52GsRsvRcHWDOhxdURvAh5c4EZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfm7p5zVfL3Y3RWy14N5SWlPmQGA7xHtSuKZJIpZVzo=;
 b=RgzE/HuRepjvwShHF9sfdPLU2dHTbwZ2KY+KrLk1wX+gLFF6NPFDWHHHkTELetzA713cajQ3vbL7dJ2x1rC6dGyZgiydFo+Sz1lcbmE0X5FeCmtHJ0j/rooz4cKamlQsXjl9RSd0f1qr3m7Qi77Ajub3Jm3wy8SuycHRyY/AnHWWru2GJU7lCUbdMFtSmzy2SfWxc7l8PZqZeYqj9QNaNIU31Uz57RYSgFkAhDK5obNbJq7MOQ4j2iy8oC3FkvSQMpPQj+pBVZGVODzUpyHwQCjTliXwTA5ZwJy+z3zj76WcWj6RzEX5cnrm8XpCtqXYOqU8cEixLAfls933WIzwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfm7p5zVfL3Y3RWy14N5SWlPmQGA7xHtSuKZJIpZVzo=;
 b=oooOcLHt65Gl4t8LN9d1AzS9Wt4WalsvvE9ujIJ7RPnHH6olaMWHFN/b8vQiJMOMh/b1qwlKA62HjPLKio3uQUDHoRFkcSoW9RtDlqNlPrtYi2jRdv8KF03K8UkatNzhymYYXGWoMIfJ/vRlgTGYyY1JiKcsMRFnw3OWbF2JzPXYmD97gqjk8KxHAMcxGfDjsB2gDweM5QIAMZmmWPDzNFsD36Wqb0id9C7MoeaZjgXkwC4wcNjul+vMco0cCseYb5m4oPCE6zAzGEwoejLCate+BwRg10thSCDUm2rl/qMDBN5XzREb3x2Gbo9TILb7aYbgICKJfh0rFTmhOob8XQ==
Received: from PAZP264CA0052.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::15)
 by PARP264MB5200.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 13:26:10 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc:cafe::3a) by PAZP264CA0052.outlook.office365.com
 (2603:10a6:102:1fc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1F37120449;
 Thu, 19 Feb 2026 14:26:10 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 7/9] configs: sandbox: enable the software ecdsa driver
Date: Thu, 19 Feb 2026 14:25:50 +0100
Message-ID: <20260219132552.1499698-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PARP264MB5200:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c4e01b67-3b7c-48a2-1726-08de6fba7244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XH34pP7gaUwjqjVs/8vMxoKQk+gz5McwFkVPKegAgJV/XcRa025n9tMQ/tyc?=
 =?us-ascii?Q?e7we6PpaHSwaTDMrou6cW2ld/x49BRy9roFuUYHclFMO19JprluU9aBs25Ox?=
 =?us-ascii?Q?UhtOin2PuLDeqdx5CZPf463Q24qp+5Na944uCz2luHxMCDszfupq/UyTep/1?=
 =?us-ascii?Q?iLPiGAKPvIN0OJMRnxPyWLKsu3wNjExUdLZeAIifN1D9u5JYzC+aSBKFs9a9?=
 =?us-ascii?Q?BzehaMjTU8DlhZSQ8L+bEs/Kg3lBkTgAL7x1XsaCPrj5ifMe5ThV6HBUC1T0?=
 =?us-ascii?Q?wSOkk3xkgbxP4+sGamo9yWGW18aASUSGjPLZDydkM3f03/vU8oFv1bLBd8Wz?=
 =?us-ascii?Q?Qafce0TuchuMITykiwdtPcKFHaeghQ34H5ovy5K8a3EfD331OmgtnXYQWgyi?=
 =?us-ascii?Q?TqYrt+IJhzfvPz22HzSOS3IP7uR9ZnLgjAkky7vd3bkJl8fXHiD1WwixiS9T?=
 =?us-ascii?Q?eDYfja+Pk0akrM5qusfS/+S3Q+Ab3Usfjje+9oj1Z7MI3fhIDOa4A+olULvf?=
 =?us-ascii?Q?U6e4nSWGuBuTXmrufWkhih0e3QwZCz4dTTgodCld1nfa2WsQV6hN9SkV4YUc?=
 =?us-ascii?Q?P5v/RuBbkuq6jND/bRXAVHBiTW5Fpd/nue28iEDC1fyBnowqgOGNDd6Zh07H?=
 =?us-ascii?Q?WEz02f6mrTKv9z4QTHKZBu3kRJbjwMltsvKXOLIrrPDvWKfgTb31hrjS1V1l?=
 =?us-ascii?Q?WjxFrXIrvqD8FhAtIk+LLV8woler6FG1Edtjy1GxGSeu7P4NkvBqeWC0z1+K?=
 =?us-ascii?Q?T1tO6XFHMqdwHkkDUFBZ0S8ZCXr5qfskwgGUmxdZqm3eKftaHgAw0F/6Y/JC?=
 =?us-ascii?Q?kd+ED/6Tdiiqiqolt54lc+WSu8bCpw835FvF1rToksli3QTQ4i1/WNqVet+h?=
 =?us-ascii?Q?wreKLpQJBy3wzbW1WpMW5/gF2xR4eAXk7r9SQZg4Ly8wLzT81Pgn4dl8L4VN?=
 =?us-ascii?Q?HnHRkLCFwWVGiO5oKe0AFZWiUu7cZFCJfK2OOqx90NUMLDEd4oplHRd63d6U?=
 =?us-ascii?Q?cdQtVKMDDvseo0uiKgyjOPPlGlWtrEd8Tovg7A0gasRn+5AghF2MI+xeKos6?=
 =?us-ascii?Q?X4cneCcSoiMyHC6N5UN6Ci8ON5krrU/jjBkf1x4gnb9jJNuVaVGGflNF0Cm4?=
 =?us-ascii?Q?/Y7ycye72CtV2xEWyxX9hmpTm/z249+AfwL5QshgtsbnAR/crJpyQl09jfcI?=
 =?us-ascii?Q?ywpCVdwW7xQhlx4fPKcKolQ0ngh3DLZTn8qcYai72eCwSYvuY1y/FF06zXi/?=
 =?us-ascii?Q?RdEUnMnC6Bxw5bgEUinLQpLa4skxaYEajDexkwH15UHuhWeOYRqACS3t0bWD?=
 =?us-ascii?Q?/L70pHmuo61NPCXCnESGNMeckY7WnTWaRMeGY79HACYb/8iAn4GZYnIjNHw0?=
 =?us-ascii?Q?yGEUqs49YMYRgM+ZVTyglrW5MsRMyxyRvVOBVisyZdVu2LSCgciScsCh7Ho4?=
 =?us-ascii?Q?Hm8q/PVcClQxBM8BdWuJclE0kmsYr0uRhYc1CBYzLriFnkw/BiFMZM02dGco?=
 =?us-ascii?Q?YUMYTmssRj/c0k8/kln3/CVWZ5wNi+omtTqWEyD8SCdsTg1gk3/SUHOo62fT?=
 =?us-ascii?Q?xtNgQy/PB8efGyCP4smKUD9o8lOtIE6oxFtC2Iy2ghIMKfUVRXZZOsM8MK5O?=
 =?us-ascii?Q?htFKy2LuOn7NIxOPGbevmvOckPBFRgrREp27ZgHlsyh/pmCqc3AxPpisggGj?=
 =?us-ascii?Q?hc59Fw=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q60dpkPM12B5SYNDuADlH8HDt9MdEUnk4Iy3NLR2nfE+6483WfZA7HGf418MEcozfubbpEqQLu5Pek2RvR2V1Bk4KgHC3ofQ4fGYMsgPf5TnCbBC4PefODn52/1nVVvQn6dH4f+qZE2QPN/d8MlW+iTNbO352h4Wy3Bkh1/bLd4l4v9qwwkqjcWX7taa4H/2pf0qBT0T2m0wNECoE4FB/nsZX0wWVCBV7zlWncwK32zBBYUPvnd4UvcmegcbOMLLU2sRq/fwRlAEqwaqvph6Vei6s68RcYN5upXEXkmMLEVvx7qej1vfhSkWDgaIZC2WufjlDb/B7P5SHBaJOfi1OEso7Qn/5p2t/YPCEXXYvYGU8LmSPuSxvAA6jAgADrlSbwOS120NFLv6QwctEzSk/4sCDcv4L//lQNpCZO4Vedthk6NoRmTyFvGQP2vcWGCm
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:10.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e01b67-3b7c-48a2-1726-08de6fba7244
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5200
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

This commit enables the software ecdsa driver so
ecdsa may by used to check fit signature.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version

 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 4ee7ffa8bc3..2804b530211 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -398,3 +398,4 @@ CONFIG_UTHREAD=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+CONFIG_ECDSA_SW=y
-- 
2.43.0

