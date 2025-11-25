Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E823CFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B8383F75;
	Tue, 25 Nov 2025 09:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vGykaS9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0268E83F70; Tue, 25 Nov 2025 09:13:37 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0151C83F86
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNIXdI03emZETinKErsj2SV/0HJjFwSAmtiN00XVvQlneXuK3IbY1Sznt1WrzfZdc89hqf7fHq+FD5p6DxIzR6zRSptedScBXHdexTlKSEcQeVQO0rfaFNwwkwXOqj9+EoWs1H9yXiMdofbFxv4nBhMZF2x/3ocv+z/6iVgrwMcB3AtHPwWNVVRNNmPOQyiXRwGrglM7RwnRvPUGjac/vdY42YGNEO2haiszA4RL8s7mgd13Y+tQh6q6uGlbFX8w4W1q1nb54roObZb80keDi/iGQY8Y9RPuh9vyKcU659ffPAT51zJRlsK4gWb+ijx7sgR4SFjOYui6BY6vGz11IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv0kzcBeyt3zOU/7SopvdQ2jbcVwkx6vSsK+BxgPwzQ=;
 b=EInoImdpOb0e5Gs5HfbX0V/jCQopyvKDOY45JypbZD1BvneBcq4jQCT0KvDETfid/w0LiEQgdFpOJP8W2+0Lu5lpi7G5M/vAo4JFkbD9PqA4qN392oDZl85+uHuHDUBzfKYGPGhpYEk2/vTA6Qnk1OvnDaakevvLg2BJIA0XgFocOPMkE8Ss7wJUu+lMU+Bn4xfhia0rKCyqHDt1HswaYn29Q8daLlL0ayEj2E0h9uJXPzLKLuObzIrDE7WGxW21Swpr1MP3oSXNujQ4CeFymv7d8RfeuRW4YbCtGaDw+SGIpu5pOEGapSsioSfGI+8X4rudaxXpKXT7PHf6fTOZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv0kzcBeyt3zOU/7SopvdQ2jbcVwkx6vSsK+BxgPwzQ=;
 b=vGykaS9NxBMb8y5XiAJzrzi45HfYzYgqTkrYqHW5GApDT2zxYB9hi7ystWgGSpxQ2iu3kU/hmh16PnmPcYjvL7A5TnXEg9clIxOUjEXp6UTbeHFWIMvoFJFpi+GO58dBuF/uCjXKSsxxUQwKvqDEDKaAspoq/kG5y9XlZcjGeKomH4vadQJt4CsPbYTf48+56YTwzqY82Tsa6Hn0m4fzukmFHaXHJkVxW4o5stoZSnLIU8l9obeYHZTOZe9mQ4Dm0RLv3hQe2AhDFyEX9BBXapHpDN3/Kv3DfZ8fHkszc8jc/ZXrQVqkCxn1x9w7SNd1XA7VFszKm7Bigh36l5UxWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:30 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:30 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
Date: Tue, 25 Nov 2025 00:13:14 -0800
Message-ID: <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f80fc9f-f096-4b51-d24a-08de2bfa84a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tHVSi5oEjeI3428Y8KWS/rsnZ79hHbAlWAo2Vc2XZEUvcaWlXw6yxB7Ox/x1?=
 =?us-ascii?Q?ujRmAa4HwZ2YKu9bQn/nIXVp2teNTkCKC8/yBm8vVHNxjZ5K4BRAlvjyHuVH?=
 =?us-ascii?Q?Tmh7iXSFuGzLXJLHO6/3hJ2XNRuyMcZOhXs/ztJ7Q/kPVo/rALvVVFBBmRvx?=
 =?us-ascii?Q?LP6825wOdxrhE+2NC846zbRI1ogAmYBg3r2jocXSQYU40DBCEZO8wylQ/u6o?=
 =?us-ascii?Q?e7Ri/+frkBg27jCQheGnqvTFjFz2baj4M5krL7vrQwOzgDpZaFBH4s9EGa9I?=
 =?us-ascii?Q?rSm1sFv9RASJfhk8qQ4pl1oGu8/polGJj7X29GWt0LkpZfpEEUjyL0yAUM2M?=
 =?us-ascii?Q?V2GdtZqbqlkuE9nT6ptVvQjOI358/pAV7PKlycAxepnDLRCPkQN7o7QT35U7?=
 =?us-ascii?Q?uWPZ6VIEELNUTXqeUSxndri5nIW7Fb8JcjnerOPdYBUw4LzedgJdaxbayhQD?=
 =?us-ascii?Q?0o1qoO5a6TMCkr5StEMlOCUI+caKbBfEF1gpcUcqoggboYtrclnxisGObQ9m?=
 =?us-ascii?Q?RzIp4lCQ4wPwO4hlCvZ0KHD9JTHGKWyp/2WpU3yWAaRTzFmkk9oIsgAx+qtt?=
 =?us-ascii?Q?hX92ErzHwkpIdSJXXyhi+bfxbUOXRAyG1AwQbZELT816Tn5xnkYpr7b8A7mS?=
 =?us-ascii?Q?gioWP13TW5Rk/mXkznyGhclAEsSeBQmYGTYTbM7w9B7Hk6qxenSyyIUFRHzJ?=
 =?us-ascii?Q?Ri5E4bPY+QsIL55jumSPxjO6EtuBk/T2cG/rdyZjIvOwTCVieQUVCrWd6Bcs?=
 =?us-ascii?Q?vjie6Hz+wLK0O81anyqAg/wMxV5TnggCRM7nXRxwa7TO04F8XJGLNYdXYeSZ?=
 =?us-ascii?Q?otnKAiDZl2DamkB4DBWPLh/bVVjGWMkk+s9j/CpA+ZGhVmo30NFSbk28IkUj?=
 =?us-ascii?Q?H8QiLIEqRREUwEKRHfGMJBbRG5nkgQ9xQ1SyIIkupzEkbmxvLp8xW5aZCqoS?=
 =?us-ascii?Q?BfwY8v9DwGL4Bf0jsko0I6UxIL7rbqPxIaeTuJR9zkUBcsQmgzp41eesQsan?=
 =?us-ascii?Q?sMyp6SPKNUN+arqIvJ0wLIo+J6D0KRsfar2SCfdlfqgzbm5nEL2alIGUo6O5?=
 =?us-ascii?Q?taf82FOjGRyU1FU05SDDryzoqkzIdknndRSC7Dg1PXDiLRZNex0Rlvu+BILu?=
 =?us-ascii?Q?rVsgyBfPDZ3u2kGwogeDmtqyjImNkw0VrpGFflqRplnvIAa6c99iysA+Hs0J?=
 =?us-ascii?Q?FWnyWMAvWGH1U2JvPIZL8QUYTbaEmnlT3ZrX++kHsXD6Tgj4zmef3FT861TM?=
 =?us-ascii?Q?nIq4I0UnVCkY3qcDqZX929m/67ImdRRLYh0UZEjjPYXr03/QO0ELwWO/t9q4?=
 =?us-ascii?Q?6lQpUNIpNlLyfNijw8VTRCiYBjdHidIydAoOeRn2uGPY9KQiSgAXDJE3FXOl?=
 =?us-ascii?Q?yd1McpSMTMo3kge4dRxVdVIt13uKos3G2Ed3eFIMpBD0/P1F4jluAHeljl+N?=
 =?us-ascii?Q?MhJLljpjKkmYIrzpmOAwiJWkCAA4JXEZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IFlB5PN4fD9sVzVF0uzKz5Ys2ujH3H5UGfqJaU5562t4Qx+5fVoR1qsz8nv?=
 =?us-ascii?Q?i6gb0CQmeYDsH4O1apuaLTjmO/UFtf/z/wxleoFeIqLZkZ4IAlJrKtepIJ22?=
 =?us-ascii?Q?Z6mSHIhEawMzKqZezEbaQDqlGOl9WTAZSzpPzeUzrP3Ki8prusvRewfebeEA?=
 =?us-ascii?Q?iZ0r9p0rOcT3oYnsi0CMZQzja+7/DN0ZrUoKEw+X136I90Q0ZoeiLnLp2saw?=
 =?us-ascii?Q?JQqoGSxUxvEPaMj37+yp8uek+2iWa9lqkNfVoJ+3UM56jCC5tb6/olzz2ZFO?=
 =?us-ascii?Q?3nG8CtA+NH7y4mD7NCRU7HzKZTASoH6pWj02IvHK4HjyEFMds1jAuM3BzoaT?=
 =?us-ascii?Q?KEzt1BEpw2P0dqZ7McVLOLEmvgUiA9Ts8NrSJBNq8EPJhLa287KgchljTDfI?=
 =?us-ascii?Q?GSex1orTLDvK3yqJ4IaL13SR+myJIms6vgV+slTzo/LDDwSeMwuTK1ZgKUQo?=
 =?us-ascii?Q?IMNvzCs/wqLEVQFOrVv67+REbabkb6DXiUx8zhKC94MPGb0s/5OQHciGbj3z?=
 =?us-ascii?Q?9AdxI5pa6SnWf0G35ACaKvx4YG2fxnQMyDhxjN0FQY6wGxTpI3aqWKvAGyZw?=
 =?us-ascii?Q?zrx0y0uDd9IQCofoeMXDYDBs4E7fl0KVxtr9YBWEi8CszwpJptiaE26q32Yo?=
 =?us-ascii?Q?VdJhrccL5+coU+RTvxFjyGFMBX6D4RuwqXIET8qNrFiqMZKxn0fDRlC2bWxs?=
 =?us-ascii?Q?egSyWRX50PQLZEH+t5Yjjz0Yw9A0xtcBPwvu9cz6tSTY4d4hfnDMysuOG+3b?=
 =?us-ascii?Q?jmxG8o1DZqGNgw/QjLJyzoL4CS/yNLPBcy4kfuCvn/hyKIlkrhjlz70U6g/X?=
 =?us-ascii?Q?w4gKVgW+VzPsvj8AsTn03oKTcxTmK3bmDKRavY5eksoAhSC1qlrIIEggm2oV?=
 =?us-ascii?Q?rkPJV8XRwOWW0RboD6iYhEHy2lTYA6ImXiuBirwhJnCGHzVnMuv6dQRFWrWU?=
 =?us-ascii?Q?1VHDFnQ6+WIwQdQ6OFqwsuQP3+9yGOtqk7Vy0yeDSbOstQrt+EOpFzAldpdU?=
 =?us-ascii?Q?SCA0a7ALln3LVOZ46e5vC+zNd0ws5qpLNU2fgEt9+KEitBZLyZIro66tawev?=
 =?us-ascii?Q?kEDg3CJSRJFwXAMcmonhZCIaP0DVhtuEvJQwmYEUDP/GoC8Y20ArtubSooAD?=
 =?us-ascii?Q?xXXiK3ra3POaASYqbacCmRgzsJRN1AOZyUpWUjpVYTrOsiql4Uzm+B+MYPoB?=
 =?us-ascii?Q?9nt8atHZeOIoJP11KA1R8F4DJ6wKjqswRA5tmpJa1Q+w0cCPq/i/ILnqZnZY?=
 =?us-ascii?Q?OcTAKsZSFQyAsNYVq+EMjRTNM0vjh6jYT9lkT81TYnQEH9JvRkDM9xrjRQOB?=
 =?us-ascii?Q?99k+JDouGVDZDv4PLOAGmSPyw+SeafljHXjoqc32+cP2mSmLONKjQGTRdrsD?=
 =?us-ascii?Q?W4+AR4HnLFp59rZ3p1GD9AN6bYSZELnJau1DeIjjSG5NHrOkMCxdkyNgGsLj?=
 =?us-ascii?Q?oPp/qbsFWzG8bRKKOlsJHDE7sf0EhP3GRo+heZG9owi4jvqWra0H8bhabwbv?=
 =?us-ascii?Q?kd1yeS79BXhYWQeQS1El6MOeSYn7mCEVd2P7TL9VZdGCIJRVdk7fRyiM/ylZ?=
 =?us-ascii?Q?1Fm5GAqtvgJDZD7XIByH1LqtuIRH41rOQ3th7CtI00te1hw3nvvWs1Sd/+nh?=
 =?us-ascii?Q?h3X4Rb7TzKjhztiQVMbISPM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f80fc9f-f096-4b51-d24a-08de2bfa84a8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:30.1660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UurvlKu5jJR6qhjpECyh3omkQt3XxxIzsNmAOtoCrenUB4q7qeddiRer72xYbvSYAJaHLaEK62cW1aH820YJykbEWcoDWVUcvHolsolgVm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable support for FAT filesystem with SPL for CycloneV instead of raw
mode.

Recent changes breaks CycloneV MMC boot from raw mode, and so we are taking
this opportunity to migrate MMC boot mode to FAT as smaller OCRAM size is
required, as well as aligning MMC boot flow with our other devices.

Fixes: 2a00d73d081a1 ("spl: mmc: Try to clean up raw-mode options")

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_cyclone5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 2bec82b0625..2b2435a27bb 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
+CONFIG_SPL_FS_FAT=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -27,6 +28,7 @@ CONFIG_SPL_PAD_TO=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_MAXARGS=32
-- 
2.43.7

