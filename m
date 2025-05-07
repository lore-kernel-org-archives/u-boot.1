Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E12C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A5782162;
	Wed,  7 May 2025 14:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="gOb7kPqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE0882163; Wed,  7 May 2025 14:12:56 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3500981F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 14:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3Ea2BZedgVlFp6j2MegUPdyULhkWfnSzxe5sXiFl7jsgQdocV+4sLkqTwDRonFi5E227MbnRqYEYP57PDkKsbh1ZxmgHx0goNpao0GO2KwXY4VJv67zjC/tsCjCoWdrDbb6cWHDVXcNSaZnijOjeyHo32zgAKI87JJAkcc0imm7aiQfksmqLcnlDBIOnbEqyJXt2pWvcvOo9AjDiTGC7Gqf+7V+H6+EsKNmsMoU7YFSFD+YTH7s0geSIbfbmSYm5uLnXeMaGTuBoq4ePQmk0DuuHSpTQebneiFBY5+Zn6KUt3fEGLzVgvR0Fstr82KgCZpRo56xTUtPA9VTMQ9FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91huXmLIWRc6K2ROveUbpDpPVKZmUflxD2ZCjTqp4po=;
 b=aW7de8Irfb5N4ielt76A/BsxBtKi5ZSEZ6QNziB1PfGCpYPgQB5fuOY3XdQg735dA7Jjbp0FBNLllpsg8eGkLMhaExoGjZnxuFJK4ovWiTKUWRZjEW6jRAkHY75z6fF4vpCDujIhtm7KKtSAIrriAXAYJnP8meeVKiq5jgdajMJXD8U0GMTtzM6bM94fVj+sxBYbJOhJdKXXqNtPqjeKFOfEQ+cdzjN4Z4AVvi6GyaLNcik41ge1AYaDY9cIu9cnWxUkUQILYlg4ccm37XQo+VowjkLEz3XFp2ajo2LpV5f8JEx4YbWrKmCQVZ6amOwSCnUn9k3DJ3ihQJo3H22FEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91huXmLIWRc6K2ROveUbpDpPVKZmUflxD2ZCjTqp4po=;
 b=gOb7kPqBRMpCSSCbDB6fH0v8SGi/RhSEUIwyrMjrbkYqsD8bJFJjsoT4osm1/9lsL0RKmbsFDFwqWyYAK/ljQwb+zSNK2vFoLs3DPJ2afF2s3ZCHbVu0g650rrPV2xYEjkkTveE+QQw1a2eSHBT1JINro4IcH5mnvae3ei74fM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB6014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.38; Wed, 7 May
 2025 12:12:49 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:12:49 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
Date: Wed,  7 May 2025 14:12:42 +0200
Message-ID: <20250507121246.518691-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b12d152-17c1-44cc-58e7-08dd8d607bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SBx7sNO91pMmmqmMx+J0ff842gJ6xLnwweMsY8J7KkVgPI3yRmLLYAT3/qri?=
 =?us-ascii?Q?/fWTMpwQadPC/tYT6rw3snpyDNndb+WAuw13z8urYWgDrN7fPgXiyIc0B7ir?=
 =?us-ascii?Q?x8vx3l81zfKZ5AQZp71/kSHb+rNcPkPIgkQa6uvVnlnNWZH16DTO72UDjCfj?=
 =?us-ascii?Q?d+zu4s7nBQwaWbLtpn0Gd+vXW58ZAo/89/CMn5H4XeRZdGlEWRQV3OJpd9zv?=
 =?us-ascii?Q?4f9rvG85lpJ072Yf1G+UES/J2IcUvcYtF8Jx8J8GQQGcMuDKZanz6lkTyQc+?=
 =?us-ascii?Q?yBoX7r2VAVsZSAFzlDP4Guf6hZaUUtCJXYS+g/2cx7Ws7sb8Hmtwj7QBIwJD?=
 =?us-ascii?Q?HJ6GE1WUAtYl2vZvAvAf6E8B0zTKe2HjqT6Ch5W3sSlvyVCuGqlz3x1MmcoQ?=
 =?us-ascii?Q?K/ASDP9tazOXDdqEuPIskqebwT+0nolzpaLG5HERvgWzLzRDZ+JWUTLrt1w9?=
 =?us-ascii?Q?eTsTE142y7EKXn1Rd9ZvsY+sLhU4HrC23WkoFE/EinUt2fZ+cA3wVeIGRgWf?=
 =?us-ascii?Q?xYKsbO3wLynx2q4QPEAQ74+g4fclXXXUHHtpYG3ToNjrc9Snd1kG7vWo8Jxa?=
 =?us-ascii?Q?wrs4cg/TZq6i3aDfNUA0wJ5Pmq/gkFN7w3Z5rLCVhFpSqT9jpVipwanEq5T/?=
 =?us-ascii?Q?3csotjAljZpj09589+upweOo7v3Z6Dr2cbHz4UYzWi60tUyDD7iCpGLK9I86?=
 =?us-ascii?Q?13U9J864NddVvqZy5YC/pvWS8XWRlNgkST9evJOXhTcArQzoM+kOmEC/YYmd?=
 =?us-ascii?Q?botxmrlWf7fYeKaL6VZ05mQCeEQ4eXvGz6XQuSd3QWZe1DBX4eO+p+RMpOKU?=
 =?us-ascii?Q?GCwHKsrEeiN2C269wYGYHoC+ZRO1wN9L6rd3MAb5bqzVy9JCEQ1d1iy5e9lE?=
 =?us-ascii?Q?0B2dTaa19zu3dHzvOoKWZCSuUlHu2YaCvzEFEZNpQJVb7FFB2Oc8Sk67brR5?=
 =?us-ascii?Q?bHKPuZJ2DdYekLh6SmADK0Z8EyBBiCA6xUrW3E3Gx1SQM+teTLpXL1vrm1R+?=
 =?us-ascii?Q?wdeJaz0COqfkmpHC65Y6tR6xKQBZ+YxBMaVarfldA5bp2eXkvEm5ci1v35rE?=
 =?us-ascii?Q?J7/D+C0KGWlC82h6dgOd018gg45abeArYHo+GgjT55hnrtvPmuSbyDd4mZ9V?=
 =?us-ascii?Q?khlmJIBUL+h8eppwUnfM0EKpVTiI9hYCwBovD0EyaLHl34Wn6C5KNI2OO0xH?=
 =?us-ascii?Q?YopPAbAwHim0RXgci4OAtKeA2Or4U6eSJ/6w1o+X19okGBmCCy8HVIcwQpwe?=
 =?us-ascii?Q?rnzIoFjEjsscb8nPjzK+1JKDkU5sGZZiFzzEuaMW3y3q7IXcWrnj6pEcdAI+?=
 =?us-ascii?Q?b0Nc7XMWhFonB8gbPwcOrVdt7TIdMg6SyqT+jszo89zvlB99YZfVcb5k/4h2?=
 =?us-ascii?Q?y0PbnT5rQxSMJ2A6cQhKSShb3awJ6UnUGVSoRp+CcE2ItXujfTjPKs0ANk98?=
 =?us-ascii?Q?o+8X88BGPWOfCxk4xTSkxjpqM+Y3OxFy7Gt+BF4HMM9c6UzKFLBX0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IpGdpceYyUelUXtVzS9ccyJEkTfvPTRm3q9+xgKWNxjFXBVyaujEhkwpWDJc?=
 =?us-ascii?Q?9ZK/VmDpkKGAxMNNiBqgt9PmczllI/H5zSwYEKSh+41GEmRrj8JbTMzCiV4M?=
 =?us-ascii?Q?4fPprKSqXERtSrezHFpwenZ5FrkFpl6eU6rRpvXz0yvymPh0utP6OBJMrwm/?=
 =?us-ascii?Q?XXCUphpSc7s3ewouij/7K42TwRkn4LLSNjc0hIkrSOFi67vzkdAXKT97x7g1?=
 =?us-ascii?Q?JAKw0SNcnzBc8pajiCgunRc5n0U8Lubtj/1VWtaUYNJ1CQUpUqPbFbXXb03P?=
 =?us-ascii?Q?0wH0k7LNe+pZWGpVVkzNdSlMm+wV9DG28ON8FCSQGrEfPPw5gX2N7i1yQ9HM?=
 =?us-ascii?Q?8ud2DIwLzniPoyTc5RlCfR1ip4tN88K2kWXS/PEApGkz6v3qiB4g+J4U5QeU?=
 =?us-ascii?Q?vOVTlOAqTYi7pGQYK4VGPZRarD+WdVZbkltXsHLxeIRolX8jgQf+aAbH3Rqw?=
 =?us-ascii?Q?x4AgTW+IQzk/T+UovOcbP2HcNamX5bczMbaXqrwYVO/yn7jpa0+dDAxDcl6I?=
 =?us-ascii?Q?2dx949QKo5AeQH4eB5Cmt1ihp9n/HuX7uQel2x9VF/x59SHjrRETyaUleXrj?=
 =?us-ascii?Q?jgoLHv3mETApdkT+UfPcRWIz1nkRJ6/SsldEmM4CK5K8q7b2MdNQ2c4Why8c?=
 =?us-ascii?Q?34HIK0b2fvHpi0F1mhqrHwb/T/aBE+wyN+XiArdgGMSP8PinjCp/ET+iGGEn?=
 =?us-ascii?Q?XfIQkrWmwlypZ4cE9lholboJv+FIJNXWDp54SMBHpIXaTjiOjrsIQ0NTvQkA?=
 =?us-ascii?Q?mNOv5BKi4uDUyZcVv03w6PtSlRm1+az+xt0XnvjASRLMmwMyGApvWHJb8DKs?=
 =?us-ascii?Q?VZieGAvWKiTeGdbRKzWDdaksxPKe9NT5ncNEIb3Ve62e0kKIclMVz58+7tQJ?=
 =?us-ascii?Q?aurkytmgMnJnm2Af8QTEikO7Qa2Y1OV2Cq6XfBKKkSeBw/0mzuM3dnmdukkd?=
 =?us-ascii?Q?KXjFPwS7su3NvytknWLV+3sr6PnNHnh+B5njnMUj62zZSkUkR5lKjaQyMIVX?=
 =?us-ascii?Q?EDsHQX80dBlsKxZixPnIWXij/XTUHj3j3magbJ7sPG6e1qyHrDoanXb1voFu?=
 =?us-ascii?Q?LElPMeKJNR9LoEDptV8I8CNACJWj4lfLlyv6Jwomx3m0EreV6tOuTUyAQOgO?=
 =?us-ascii?Q?UAbbqAJzPIh7G/g4ilaVDdaI9DFE1vEhK9MHRuozyI4TQikmN0365cfzobaS?=
 =?us-ascii?Q?diQWkUqZ/y+u4coy2yIHU2ptquIxM02TT4/IX7B9FYTfzCg35YAlcX+T/XgE?=
 =?us-ascii?Q?rOvLvh1Hm3KLFNhLJ9RcrrTiZpzHXmYIHeWZUkZu90Dur8hdCssxUlCs+CWD?=
 =?us-ascii?Q?U45jh7jyip9DdhTT4In9/hwmW7aTyKsj0gnUn4UvPoevGborHC3jDT1SpNN6?=
 =?us-ascii?Q?XbiYJSLofrQnDPcgZzWpX7cKBj6wvcxvGYyIcofiEhGDO1vG2AOPLVtuj3lc?=
 =?us-ascii?Q?43KNRPSnwfdvnO0odHrydC1HfL1wQkGNA1oYwwJLLzeziHK27h7bPA/ZTjpB?=
 =?us-ascii?Q?HPgdCQICdJSdLgMYCp5EtwgD3yiBadDwUKPeo7T2hzxuRHMy5DnSNr7lgQzN?=
 =?us-ascii?Q?on625bUlv2JfhaQqonSiPAV9fmYXYnNgL1451L6DnYM6ctlh1ZdnBRaXAk+g?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b12d152-17c1-44cc-58e7-08dd8d607bb3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:12:49.2478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKLebWZeXwEORiTpV4wXRep8vTytWMwTltq4fXrGlnJ0h5y1kzggwSUUAp6A6UO/zzkpyVzdaParujZjHGQpN3QgcyaaZPh039a25cJtfEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6014
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

While looking through list.h, I saw that the regular list_* helpers
(and one of the hlist_* ones) still contain the prefetch() that was
removed in linux 14 years ago. It doesn't do anything, but makes the
macros harder to read, so get rid of it, and the fallback, no-op
definition that they relied on. That requires removing a few uses
outside list.h as well.

checkpatch warns about some whitespace issues in list.h, but as I've
copied whole kerneldoc+#define blocks directly from the linux kernel,
I think it's better to just accept that so that we don't introduce
needless diffs. The "macro argument reuse" arguments should also be
ignored, as e.g. the "member" arguments are obviously always just bare
identifiers, and the "pos" arguments must be assigned to multiple
times.

Rasmus Villemoes (4):
  linux/list.h: drop use of prefetch()
  treewide: drop no-op prefetch() calls
  mips: drop unused prefetch code and logic
  linux/list.h: drop fallback definition of prefetch()

 arch/mips/include/asm/processor.h |  16 -----
 drivers/net/mvpp2.c               |   1 -
 drivers/net/octeontx/nicvf_main.c |   2 -
 drivers/usb/gadget/at91_udc.c     |   1 -
 drivers/usb/musb-new/musb_core.c  |   2 -
 include/linux/list.h              | 104 +++++++++++++++++-------------
 6 files changed, 59 insertions(+), 67 deletions(-)

-- 
2.49.0

