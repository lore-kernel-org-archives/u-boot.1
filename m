Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14084C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E97482A0A;
	Tue, 13 May 2025 10:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kDvV+Od+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6FEE800C1; Tue, 13 May 2025 10:40:45 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E349980C83
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkTu+6KKHALCCYzcy32KyGr4XEls1JaT1XX6b2ZkrypQcmRN/3WOJ36fXwm/Q61rlFItcRGPArvK/CV2HppDtYby48UB4hYqqfEe4s6JvlEK3467LcTaU2gu9WRjk2/4k3YaCQVzQPlMy8aFoJhB6mb9D22m3nigPk9jeis0RIiswsC64vUHNIg6P6mBnJ7Ah5y9eCyXEQSrP+WP4zNqK5UgebyBAQGjBb17ceDM2V4o409+cCbukTukXerGUIJaiNRDTXrvo8el5i5DGWduuC9hpmXFKi5jucBI6G680lWK2gk7H6C1WrWImVli46DDrLYsoGEQ2+i6KqxHexHfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaWdT6u20SSeaJd6x2rJmrewBzeVNmSxCj1dvgUhX4o=;
 b=NWbW/PF+dbO8et3hBPja1J7EymMXpn7Z0jmabMdJ530gaAnCmF5uI0/9TQDLKXYaHGtj9cRkkPdR3FeOkoO4B+7GzMYU9BUMHfhFwNjJczrtt6c+IN0WySe6XM8GmTuFNOG/RuXqyrTWXsEFpk+XnyvZBg5Q1I3Sw1cOZPl6C4thW/Gi2aw4iTh3ptFBbHdmpZRPmRDmJhChszJM53VWv9n+DAPmhE/Y8EgVpq3WkGfyi1n9tSZ1slBjJh/8gsYZ423F6hrGfbpHBfNLU+n3KQrFm09+XgxBf3Toa/iNPV/uGVM/TDUqRfltO9rannVDbpoMCyrN4TuO9j6yHBG79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaWdT6u20SSeaJd6x2rJmrewBzeVNmSxCj1dvgUhX4o=;
 b=kDvV+Od+79o4ioBuHkgvp+BcVHe+SivAIcN1NMFD127p3an2UUYpRorLlMxd1BbYRaop6UDdQVJex2ysVwd98iNV3GZxqAp/6hpeEvvZ2H8Kv7kGAcecM4aR/Xb/VGNTqTtnD2ChHk1LthaKEP600We5+9JKykRuVrOPCHpsDGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:38 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:38 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 00/12] regex patches
Date: Tue, 13 May 2025 10:40:22 +0200
Message-ID: <20250513084034.654865-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: c14c26ff-de1b-49b1-a097-08dd91f9d5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9bcFwmS7O+Rt2lJuTb0bevBkkLCitZvCENjCJIYm1xnDpqTVfrBjCruq8coc?=
 =?us-ascii?Q?rCHRu3tUNE/7lFz9zd3UgMW8LyE3X8SIkmy2Psc6RLXIgpqDbKTMBCPq/MMm?=
 =?us-ascii?Q?ey7KJfaU59rSEs+RzuKwhzGq+AKjXhc2rEAty55kfrcJRKjmiKonCYlLMh31?=
 =?us-ascii?Q?97Q8FeIjV9ZfO/Rj+mnFD6Tch85WYajB2Sg2yyc2yPot/TUdHfimUlsmrT0f?=
 =?us-ascii?Q?rPQ5qDspo9VjKrDBcdH6ukIgn/HxzDMJ1Q22fRTU+hR8BJ587N/lFXYBJqXD?=
 =?us-ascii?Q?W8DfuRPmiPfQskj24BxNZe1KipWCzER/hz70kNx/IJz7Cdy04lSupN6d/Blf?=
 =?us-ascii?Q?E5uoLOZOPiYyAypVu//TfWxP2Tq2KKLiQwdd6Kl7cdi/5V6YwKt1w7tDEdCe?=
 =?us-ascii?Q?FeJB+xKClWSdpZBGXBLIuPEyn5o44nia7RVDmMjWntMZu4/9CeXaTDnIkRS/?=
 =?us-ascii?Q?kzOHJfLKXmPf49Mc3NkM81NV+hk8hSmIQjI9CR3SHzZW+GX8mJx55CEebU3K?=
 =?us-ascii?Q?qx2vThndsZyFmS/0Km0uI8QmqOM/WAKc5Jlz3TrQd5lFDGd1AcLmhfDNDXV2?=
 =?us-ascii?Q?ZgG7xdSWpLOhreB7BDaGWqZa9sC2XulkDdH3MlxCh9nPsAss0rNoAGrJZ9CH?=
 =?us-ascii?Q?39hPtLA7FBQjQolOie7XXV2M5Sr6gC79PKIiyZvgzvNjvG1pKSk9OmW3boJO?=
 =?us-ascii?Q?AG1pwi3+AlIRv0jbuCmHzwc6a/KqChurxMghY1PTgNelmzJN3bBBi/X3q7ln?=
 =?us-ascii?Q?D7BuygpAzr4+XiBO7Pa8i+DNYTyhplFqGdUO7AuH69izL2F9hONapSmOrRLe?=
 =?us-ascii?Q?vEtpApWAS2akoMWefMsGJEJSbmHv4CL+iiNkeOMeGKvaDGuaK9hTeFhgMDVi?=
 =?us-ascii?Q?wC6nEvmsxsn5g4/8CKIblPJl7TKIWEU4EGhiuYp9LuOrZdej9vCVYxZeLBLI?=
 =?us-ascii?Q?hup5UsGJWE2lXveBmGUVkjjfBvLfxy/aR2QlKcsx6ZgBX9uJMJYmuJR7i2ew?=
 =?us-ascii?Q?R2C8Vd0S/yt4jy6g3jgTQAssaQVrHaDmY27PLc8sWQ5pNUMzqBR3aktLbumg?=
 =?us-ascii?Q?ta2BebHwA7OtPIt/TX1T+Ec+S2Sr4YWxI0Ste4wHIbNJSBoknhbgeyoRKx5o?=
 =?us-ascii?Q?WKiozowOTLJa5wybpagFbHhEjT7CLORZ+OO1oCF5cHOMJP4PIxMjX9BVusMR?=
 =?us-ascii?Q?bE1JTVALBIBWPRA77f6zWal/aK5nAmTkdngMhw93cFfwQVeOM7J7O3aWeDkw?=
 =?us-ascii?Q?ZiQI71zH7BYdxMn4IWjcASh7Zhc+41d9ugR7uRequNbH1J19TfyAUhCBdfkf?=
 =?us-ascii?Q?1Y9Wb/ArjTZuBsq8DDTF774/pOJ7/GA+bShik8Q4RonZGrzgDbHEjh/4Xc2a?=
 =?us-ascii?Q?dI99fuLqwAzUDsPVX4yz4jDKXKWw9mS3t3osTPek+4ZVYofrvOGL+4aXYF4k?=
 =?us-ascii?Q?HGiL/bHy/NbfULbyj5d5fd5vpNHD0UTgNjhohcha5itj71XlzFughA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HuCyobZCqLChJ8hdXYDBIotzqlTJo6n90uxkkwfaaJyYYClFOnZ4sOROWIxI?=
 =?us-ascii?Q?t+P5Uldrrv6hVyP9KrtQfr2y57XXS+2cRp/f72OZVPfc2IloZdpoq+whtv54?=
 =?us-ascii?Q?J/8iS9WvuJwthFFvZlvUjRrBI70ScaWsCH4RgJSF6eJQ7aeH+k7soSJ0ioaa?=
 =?us-ascii?Q?X1XEBzPF1qFyydPTcjBeSd15CpHRE0kNY+yJ6Ynoty6J94yl6TSw4Lgg2yXk?=
 =?us-ascii?Q?lQjUEnmek7n/DvLREgzq9AQqsIMFc9CcuNFMnBu6xmczZsY5mGi+aAnL8je4?=
 =?us-ascii?Q?31zMR1qcOTKlzXigX6wkvIxBRwloINp6ztXl0UGxxb3pCmBXMNbp+VjEPz20?=
 =?us-ascii?Q?AebEpfWz5a1jQgNHmNIcDUkmQku6Mpof0kABC46pbVONNPe8i/zgPOKjoYDg?=
 =?us-ascii?Q?PHtChxD+BoLBSQrWbwPq0qcmmElHstwe7jhTVUhguN6M45xbMD6HfdZPvxXW?=
 =?us-ascii?Q?AKBeLsZaLmDwXVr3TpuA0rWxNEm9n1AJ5p8yG23UGi1DaVSwCYNSeFC1deiz?=
 =?us-ascii?Q?jdkrzxPJbk5hObnVRSRM9BQ3LzuuJ1arfCfF9AFOJGl+3ov4ob6xv2XC0q9i?=
 =?us-ascii?Q?DTbj6AVCAf7jMHvXA+we8NAnVqrfPDnQVpN0lkZRrOuUQJzVuAFVS1XTmYMj?=
 =?us-ascii?Q?mBRGVI20VEzmoA6lPufBQ3/uddrswNxNsdk8hXBO9vYEAunZM12SauyAHQt2?=
 =?us-ascii?Q?q1GNMmieD3ewa0da80nPKjFIVsmEtchoXHV+cs4RLIpcGr80cAYf4C5tywRS?=
 =?us-ascii?Q?eZ7tEOY+W4s4m9mSClQSFY0xnWBx5bxa7J+vMewrNxQKUrThqqnGPV6hCNAl?=
 =?us-ascii?Q?OPhHiFdmNojmViLh17jIP8u0gz9EbmPGUm4C5XCxR6N8Xh+H/+N73nhcq56N?=
 =?us-ascii?Q?i5pwxH9XcmeuHutqr7O7MihNXEc2H4OpBM/XV5kFBFxm+yfzud7hC8wTh2XH?=
 =?us-ascii?Q?mp54+Bu1MsRZC1kWe0BOO1qGDKHr7UzNiySYN9aerusMQjECRPYBUyolInXU?=
 =?us-ascii?Q?j2xb32JoRG6JkAtzXXZaj8++Phns4jDcrc5jLBmzZBUPvdLwQOVcdWVt9CT/?=
 =?us-ascii?Q?v+U2edMx7vAEqjLnp2G1Nqskugd7Qmtc/3Q9OoNwV9kJ5mARmZfHOFNqKKSO?=
 =?us-ascii?Q?/zeNV1XhrZay4NwF+UwcBjSgY/oanxorbYGCenWPYvpvoVTc7MDZ037pREO0?=
 =?us-ascii?Q?j2NDHyFM8Rh/vsSEDlnsZ8nJ1tv9bz34C0dS/6ZuOyOhn5ud0W6cvpaaS+ed?=
 =?us-ascii?Q?DwFCrLBOSL1kgZcqqWpF8qBtNjXC9mwoJx3z88gSFQXkkfqNsRXCgWXbl6ns?=
 =?us-ascii?Q?6/PYXTDkBqGBRGM7/gkQlIURacQz8pwhmHwLNyT+Hmr8z3OLf8je8mAZt6wz?=
 =?us-ascii?Q?jopuckxbhaVF64j/+fbJ9lAl2K1KVg4jL+o/VD2z50Ca6/4lfv6isNUYMHAx?=
 =?us-ascii?Q?Icj15PbLT+nsxq7ds0WYVBWsXLDlZogUnnF18WX89h2pgWc4M+fhODeynOMu?=
 =?us-ascii?Q?f8VuxkZxbIT1Fd4NvUDDtiRDnb9/FfIMAKOewlH1vhDX4PyX+9bBI0oFGmkc?=
 =?us-ascii?Q?WGqUmyTE0Hf3Pkq3T21TOFMoyNLDK2bq6oLIgE8g1NpRSqp9HY0z75symZMs?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c14c26ff-de1b-49b1-a097-08dd91f9d5e1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:37.9875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR4x70hsKFGln9FD1Y3/QG/3kBiIprwOb2A82vvyIV8/07zP1vXAbVqxO7hi4LBodWdSIN24KZgpsvbscETbjuOh8Rh55gHyv+xQLfq3WTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

This started as a rather simple patch, 1/12, adding the ability to
more conveniently do regex matching in shell.

But with that, it became very easy to see what the slre library can
and especially what it cannot do, and that way I found both outright
bugs and a "wow, doesn't it support that syntax" gotcha. I couldn't
find any tests ('git grep slre -- test/' was empty), so I added a
small test suite and tweaked slre.c.

v2:

- Patch 12/12 was sent separately previously; now it's properly
  included here with Quentin's suggestions folded in.

- Patches 1-11 are unchanged from v1, other than including Simon's and
  Tom's R-bs.

Rasmus Villemoes (12):
  cmd: test: add support for =~ operator
  slre: add myself as maintainer
  test: slre: add tests for regex library
  slre: drop wrong "anchored" optimization
  test: slre: add more test cases
  test: slre: add some (negative) character class tests
  slre: refactor is_any_but()
  slre: fix matching of escape sequence used inside character class
  test: slre: add test cases for escape char in character class
  slre: implement support for ranges in character classes
  test: slre: add tests for character ranges
  doc: document test command

 MAINTAINERS               |   7 +++
 cmd/test.c                |  19 +++++++
 doc/usage/cmd/setexpr.rst |   5 +-
 doc/usage/cmd/test.rst    | 102 ++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |   1 +
 include/slre.h            |   1 -
 lib/slre.c                |  78 +++++++++++++++++++----------
 test/lib/Makefile         |   1 +
 test/lib/slre.c           |  58 ++++++++++++++++++++++
 9 files changed, 244 insertions(+), 28 deletions(-)
 create mode 100644 doc/usage/cmd/test.rst
 create mode 100644 test/lib/slre.c

-- 
2.49.0

