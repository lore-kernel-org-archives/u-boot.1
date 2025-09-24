Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AF3CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DD680819;
	Wed, 24 Sep 2025 17:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r38xEcy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC49B8323A; Wed, 24 Sep 2025 17:16:56 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B5B80819
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 17:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSvVqVJw4cvJJbGdoU6H7jiyLmfo1GPqybep7xu8MqC55FPDoIkgzq/akhZJTDMFv+mVKaoKY3RVnojWI6q4dSKioKff42v1R72YY1X7X9CPF2Qg9tKE39rlvFXckhiGH5hYf/9lR7i0buIMSUkibhCoK6SYhbKhjFDGmrh6+CUt6VebAWfbZfE2/x87OEtkpikUbceUGapO1HINquMTByQ2+NCZpmrOioRewURMWuIQLUeJyXGcB10qqVaSnAxKjLfwu2MjQjK4HEBTPSeGhQ/z3Qe6KNpltFFExDOwdFxvVhxT8HyZPIUUXjO7KcTU1VHV3tcrj2Nu5IeawKc8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1foU8FIMsD2LBky9qElqE+4Jo9Ib6jCfZmvn/82W5Yg=;
 b=K25lPbCL+4boqLKHQ0g68RxHClNV+XdAXKG9YHNtKpYXqXsbuCdEUvmoCO5/eGZcFl9uFf1lLKdQOxc8iP5l7WgZL2dNyO2U080Ts2JvxPjT7zptS+FPyR8MCoDvvPGvMs2iPUikNVwRh0uHdnDTBbQTzrS7s2v+wlgbyqDSjigymbTZHfVtInVT2OeaLFB3L+NJ1e55fP5f97sjyqXDijaANhIBQM3qr+64V6xeBr2QNprGl1c+ca8Mj67HG4sdb0G8xKLPP3Ol5C8DV0RyvJ3GH6uQfThoKcLHMjDA/r3SepkekRUeiCAoXhXZZZtlCAWfmUA7s83lusJ6jmD6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1foU8FIMsD2LBky9qElqE+4Jo9Ib6jCfZmvn/82W5Yg=;
 b=r38xEcy16Hz3tRFswD44hso74E3Vq1c+oMJ5fGGTQdGuzdx4Y79RYqO+MQOxB6vkLYZ8n5SiDU5ncZtiT7/ryO1RU4GUFjg6M+SziI1xhqWuUeTeIp/OJvv6L89CAR8T30DzPQEmkJm4t1mAeIWi0+rKFPkCkmsrI5JG5jItBhE3Hv4ZsC6MPj+vSFSlAI2i/izLj5bsaa5YViHJXPlhnRzhmPWZB4cbgPPUcLVH24l6gpBxDdrFspvqdYXh+AaHhjrHzfWksJZTJNAVxcVlUxBJ7pJ6KjHnSdviTAI1Dd4W3dieDPsauWvHkLGSDpO4ph0mbQA3eLel8dhJY7tw4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11819.eurprd04.prod.outlook.com (2603:10a6:800:2eb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 15:16:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 15:16:51 +0000
Date: Thu, 25 Sep 2025 00:28:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull mmc-power-next-2025-09-24 for next
Message-ID: <20250924162835.GA2186@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11819:EE_
X-MS-Office365-Filtering-Correlation-Id: cc446749-3ee7-431f-2d76-08ddfb7d6332
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jas49JLh+uh/JmbKPZrt25adiyckbbLuCfchGTHFvgl0ekyhC2c8/D+jjd7K?=
 =?us-ascii?Q?Aj1pcCwAFMrPptZ6VLYDVz6wUF4Ea/uovNOcF4c8SKISHSe04BOZ8G8/SDz6?=
 =?us-ascii?Q?St57q5byhhodrLdT8qAG1EX2P1d043xZJK7wk96miTB5rJKpKWWsQTp+1LlM?=
 =?us-ascii?Q?Mjex0kX9diYFecUbafnuI2NehguoQHrn6GWwN1+VfI1+BewNmH+h4Px+Ak3q?=
 =?us-ascii?Q?1avf4RTT2SiQrVsbRrPFjZpW1OSNvqXHD1wkF4WjxSCWCCcvepPbaot83sxq?=
 =?us-ascii?Q?dB/CkklbJRmagW8boYvgC28liE6A0inb9Az3bq8y1FSYkPbFzd3a56yKnJFh?=
 =?us-ascii?Q?mj/8+FmlCA582Mmr4jFLIfwyY3EyxOCCuA42U+n0jX/aIsaaEu/TtU0ojEzA?=
 =?us-ascii?Q?5QzDbwmdgzf+3tmhO0ZG0uCJaQdB8XclQwRubeems6BYgJgQfsB0fku36hoh?=
 =?us-ascii?Q?HeYwuGni9UuNhJNaxnb46GzqevJvowyO8BVfWciubRrV5E0TyQiaSA4kfUUw?=
 =?us-ascii?Q?lvJXs7DDWWigafnzsS9XKN7WcnvJ7JgGV/0hvEilivpRPCG9EW1EgJy9g87j?=
 =?us-ascii?Q?K30Le9zB1GyUxcSwnGrQnjhaqYBiYQLztth7EpUzDlArqpCSX+su34811d75?=
 =?us-ascii?Q?7Igaxl1TsU2LreRj7fE3oBIZpvsaNQaV5xRLE0ieIHD2uvc+UhW5Ny+eI7OX?=
 =?us-ascii?Q?thhsyTceMUCSjeVRwUQS78qjR+lo1YOhCmvg+q7EO+oWGmHLjzRmlSzvp6Ud?=
 =?us-ascii?Q?7DDzevM8xRChvxseh/gRSDM3NDHK4Yw1HWFp6M/1Q+S87hawE//Bjy+DUWrM?=
 =?us-ascii?Q?3TokfU/YgrfyVxbW+ngxT1qkS0rXd5oQ7Ea1c8a9acPxbJPbTsjiF4EA03LK?=
 =?us-ascii?Q?xj+Ali+hO/EQq7nyBT1eFAkCO//9EOrdYMRb3gSxWif163Oz3jvWyy3GlhVb?=
 =?us-ascii?Q?6M8DjPvpQACJDDL6sVi6b999OW+b3l/BRX0p7zMmbhsTKsRjT39CAkY96jIt?=
 =?us-ascii?Q?Cd4VMdmuwSGTzSQnF9TcfT3T+3Syo5JUH+UZXXkFW2Fo7epQHB8aDzXbX2SL?=
 =?us-ascii?Q?xxP1GXp0h1dryfkRK1ToG/agNAfAklilKjnhecF3cs+9FuPaaik0zADyubnb?=
 =?us-ascii?Q?VV/l1apQA9cMPSizlZfx7OPdSbAkfzj7rxAjUtfbVCLq9BhEMRywMuyYU1IN?=
 =?us-ascii?Q?4biOJP6sAin8Igja6qBDB78sgwL4FWOx1XCDVzHdR/8mCkeWAlgkz7b9Mo0d?=
 =?us-ascii?Q?OdRrDBFh3Fb1g2ccqS4hLI61TpKcbeZAVe0SulqazIrgx7Um9rIatOvczMJ4?=
 =?us-ascii?Q?zhM3Se54DUI8mbJRM3A0cMa9mkp/JXbv2fyHDqeGUJKWNEwFj723ONs1ljzQ?=
 =?us-ascii?Q?DwfrpnWZn+S5lo5NPbtDqPDpOGGy8snWN1FshZdoZoG80zi5V41tLydt8O+9?=
 =?us-ascii?Q?MyQoiACOISk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SbimaCaX3msd4hkcXkM64NVAoMtoQSTlaGimsiitj6Wi79CpoSExY44oZtO?=
 =?us-ascii?Q?SVKmiWq8WLRRLAOMu8Zgxo+ZW+LMf2bD6CHKzHMrffVqUfXipYY2nVf+KFb5?=
 =?us-ascii?Q?GlTZf8wHnwk/juW/8Pat4cXieqysMkNFh3S17UP8CUdS5wpeGMb69VPxz8AH?=
 =?us-ascii?Q?yu9d6uRcvXjAGJ8bW9xhQcbCVcSSxolRbSQ4ZEB3BGY5pFRGmRFaFyekGI/W?=
 =?us-ascii?Q?62ZAIgqBncbsNnPbW8/a/Ic9dDu3YsPbd+kJ210PSNAyJaWkReJmWvz5C2qx?=
 =?us-ascii?Q?sI3WdJV5Ttto0c8KeIY60g3uEjR73E4te9QYz9AbLeiJELVjgUlexM31A+Ez?=
 =?us-ascii?Q?Kvt+wAdyDciqz9gRfaTzHUrOXAYVMoBnJnLgQgTQCLuf14sBTVubrXxTN2E4?=
 =?us-ascii?Q?5+qPh1HDeNZpV09sJhfdBKP8Dpbl79NW0QtBmLr4pXRUBHl1087tvzhSooGN?=
 =?us-ascii?Q?flrlnSiV7lhU+EqVo98yabxCWQfOg9QuGe1BHwo6b+3FDEg8q4xDAOEiEjVA?=
 =?us-ascii?Q?HlZKkOLVhWQtY461HzRh32yggUpt1kJ9Iyx1X1+JutKNOaph+KjFktucYF0i?=
 =?us-ascii?Q?WzCMvw0t8q1eJMBzgxlYoPu0GXp2Li61xw8UVzl9FZZT0npWKz8OnQ5+m9T3?=
 =?us-ascii?Q?qFgNT4WJRY694ODT0f/RtoCu3InkTyfN1a8dnYMFfSvvLyOFM2xFewo98bXK?=
 =?us-ascii?Q?05kZq3rwL3t5eXJGTIJtpAi8QDPCHOBXRr9SbeoB4iTrJtx1BJ+3KdRm8pvj?=
 =?us-ascii?Q?DU4tTimnLpBQ2PapD+gTvPiSsPatBqrpr7qZ1YLsViI7+sWozxbERgR6Oa+F?=
 =?us-ascii?Q?B893S9LDmREhs40ogQSCDbWE8H6MqmWj+3X9V2wbro7HR1OkpsNaVfDqCULp?=
 =?us-ascii?Q?AEvxOgwqAlVoDUunzzVwXzDRXZ5AHtNim8qZrW84EyhwulqG3Pr0UrdTNHyS?=
 =?us-ascii?Q?hI21sbUj++XxJI3OurG5Mf7osgI6ddLrWzXqKmU8nD62c/nmDsw4MLk/GBpO?=
 =?us-ascii?Q?0RSN0r6vsZQU2Ci/pUu1nnsm1zhEGYd1tg7VJS+T5ivM8KieEL9j62NPDOnO?=
 =?us-ascii?Q?UpzmZ4elMBmxOwRQ7o/rXMTcfEOACH5UO/uNYjcJosAIP8tXteNY/bSIUL2+?=
 =?us-ascii?Q?TzkMYMxbtVYKNtT24P9OVpZq6yD/K/rtbK5OHKt6puQ3NqpqCUfiKUe6CriS?=
 =?us-ascii?Q?vizhARp/XPgIfeLXFH4yc35vL5wadysu/V6MU4tvb8sQN8XlpWQSbO9oHlWn?=
 =?us-ascii?Q?YopY/qjKuA7Qpp9hBlWsC0R7l/B1BflsSVSDsLy5gdS4jO5iZPK36xJJHV/6?=
 =?us-ascii?Q?HTNFf+/8dN2anpV3NpGsj6DIzVs6eVKpCOX8hU/U/LxD2TKgOG0MwVbrpOev?=
 =?us-ascii?Q?PIaDZ4B6QPL/ExO+f4wOosSgbNZCof3b/noashIGqQR5KI4USp2flxfWx+m/?=
 =?us-ascii?Q?7ncR4nFeN7AaW2pSn7Yon8B50T93hxGVZUdFmk3cE9Q4Ux8XoAenWLqz/6aR?=
 =?us-ascii?Q?ELFStF/2RxtU0QVHePR5QYYFfWwLvxKUwXIiuy2JLOBmS6cyo/cojQlzdI0c?=
 =?us-ascii?Q?4NJnYPOe3WHtsbxitntc9FOKRST8JGD0gS8kX9q/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc446749-3ee7-431f-2d76-08ddfb7d6332
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:16:51.2408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPeYsTiGkHrjrz3jjLdIfNE0hETaroorze7n+X8rUbIQ6w1+ctErcgEJtPcZV6NhdTzeeXZcOXU1gpzPLT+9DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11819
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:56 +0200
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

Hi Tom,

Please pull mmc-power-next-2025-09-24 for next

---------------------------------------------------
Correct error value check in regulator_list_autoset
Minor style fixes in mmc
---------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27712

Thanks,
Peng

The following changes since commit e482fdbbca935de32400054eb532de45b1cc01cb:

  Revert "Merge patch series "mkimage: Detect FIT image load address overlaps and fix related test/DTS issues"" (2025-09-24 07:50:44 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-power-next-2025-09-24

for you to fetch changes up to 3cabc6bf7e16c7e2a1156392c31e40f678cc7026:

  mmc: core: style fixes in mmc.c (2025-09-25 00:06:27 +0800)

----------------------------------------------------------------
Andrew Goodbody (1):
      power: regulator: Fix incorrect use of binary and

Bhimeswararao Matsa (1):
      mmc: core: style fixes in mmc.c

 drivers/mmc/mmc.c                          | 5 ++---
 drivers/power/regulator/regulator-uclass.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)
