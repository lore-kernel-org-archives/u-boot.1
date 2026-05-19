Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03256CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7383884707;
	Wed, 20 May 2026 00:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eeRHmnxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9431C8487C; Wed, 20 May 2026 00:55:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9618F847FD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIJdY+dqlypGkakmm9ln0LF6CdIxZNJtDxDYVyob82o3wFoYNLlPbs52zRr1mIWpp1hPvea2eJ7V4GjOO3iKu9hHagZQ/6F/7pTH5qfk/mAHz+9srLXdhkOU9aH/6MfM5Ysuul1/0PMemDrvfkJzeIQLSJnHnySoCP5+6p0I1ILpR8beHzIlOngbPftu5UCh1qyRufXL39RvXpVXp22mkJxM5l3SOH/gpoeJDq4LA6RIzIzi3zM8DHl6bTXt7cQ5UYCVtxLxn3EVXaxg6R5vpim1yWz3BbE8XoeffKF+Kv8mIqHbDk0tKf2XwGR+zAQ3rPD9b+uJkmIM3lfe/q6POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq2Ig4M/TyTPjpLazgcOcID0X0PaoOV+Dp8dGIZyFqg=;
 b=FX3aboD4F4EyGiIbu8URfZ1Ir/J5EW+vuwvP/YXWZ2LZ35BMGCO1g2sbPH6r4lJEO6OlceqlmoQXTm9tm1Q+Mgjd5zHUzbP9Qr/0IjIqr+Xa/n54I5ESXnO3ps5tYn3+zIgqaMlN4zixGrE9kpq2w1GiAB3KQ6sU4dYI020lYiJ03PXS7ZBdaLOr0pE2LnjN6psYlyi5qiHhHJAARXUz9qw6h5EWxAKqRgJwChv/v+yoawOhyPXaLGoKKEDZVdU+9pfQNxUT3EN0eALwDAd4Zuy6IQoVpVoZy26AWwIKGrHiPauXJOLhoAeSSGY1C5fdVbM7mf5CvfpBQrYEqHYvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq2Ig4M/TyTPjpLazgcOcID0X0PaoOV+Dp8dGIZyFqg=;
 b=eeRHmnxLNdYtwxuyYgV5N0cujNw2+pTFiXXviVaKneeXWO0Z8xzwcQK/3erDGYLshsr5I1AlqTYVbszYFJdlmyInykRlJkoEWla8n42LIz+qRJhgN8f5+fYmuNich/0f6neMLbCNivxJekJOLKUhjMkP2ypp0nGrMkTusgb3u58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM4PR10MB9424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 22:55:04 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 22:55:04 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/3] doc: develop: add section on embedding scripts inside
 control DTB
Date: Wed, 20 May 2026 00:54:57 +0200
Message-ID: <20260519225458.5587-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519225458.5587-1-ravi@prevas.dk>
References: <20260519225458.5587-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0001.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM4PR10MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4c67c7-c514-45b9-a957-08deb5f9aa5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|11063799006|56012099003|22082099003|38350700014|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: GZcDa+vbguKz7m+Kdp5WHSNj5qLLhC/370+rvdw1BBKDgNXq6yJIbqONEcQDfG+te9zs/5V+DzgT9iunV9MQtXVSLbHB+4ueGRbL1Yg4It3mA1V5Ky2GWkuQqcc3upd0Fg1peL20eWVY5ZvLdvpbOcUJHabFfqclHyf6v8TEt3VCZnBMihvIf9Wds8PCR7G1gSdp5HejFIV/HTiwNfmQK5VbyxVD29yFidwrt47XEIxdQxjWwLiDEUVwFW5nHKlC1KcAvGfFhXYQykIHDp3wF5Nd2rp6H/bkxXJm+7OuKwSS3qQqFq9B+ns3Qk6o1V8PreImDb5e1WCIuZzwjKZhgbYS2+ogeVw2h5OGJWvBlD53vmkS5F3EXyYbI9kfgR+w70GsbpCP33RQA6jaPU7OewPerY3Qz9r3p/DhGn/KUrpn7rr/KPrb/2Hn6slqkOSDMN2jKE22tefcqMWmyZEYygKr47cqDA7OgEqFwlbRMos6toWaFlCcRAJ8l6nj50xACeEs4lTdphReRMDuDhkO0L5uqSM5TT5s2mjMGG8nhnDID/ky09VDS2IT4MksypIaDS9ELTobtwJy+n0TE3bOYiQW1zviM2x9XQqRfQcoTmiqbxhRkL9EIxRqpJXnzpb8vh9FdaZ4EKqkI8r2EzHdrVc681rgC3uEm8K5nrp1IS3jxlvxmIkIOrVcyAnP6DZ0yPoUBkEM7/RJTdQggOEOUZ5h+yDxhisgvv8VtLArAzGtIXnrNqO5kNR0ayoP03YP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(11063799006)(56012099003)(22082099003)(38350700014)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EzqsVpK+fceinxFXNqwisEGIBoNo5unc4Q2r421oKucgRGa0SFE6L53bUYZg?=
 =?us-ascii?Q?FvMFu9pMvjpvbe5I1ltgaYA53BD/XSTsXGIsuGaygDSRsSXP42LUcS+x83hL?=
 =?us-ascii?Q?uui3bYbIJMooWxr9/BHlenh0ABMpAow5GCwEo4kk3om+cyPMIsFkMBIwhV7g?=
 =?us-ascii?Q?kQ9PLxbBP79MKRL//45NHlVpAdKvHHO6rwfYU7evX6w+hJib5GDRfC6PI/DS?=
 =?us-ascii?Q?8oVqQIuRq9CYd7i7FLycCt2fR6tnmhuMqMNV1cTx3oOgZ3/JI3ZT1gZ9SsT/?=
 =?us-ascii?Q?/QVAkj6mHF0z6XFw6yy8DYCibpBlDmXzd7zYqiDa1wPL57U4U73T/9jaH4tQ?=
 =?us-ascii?Q?i0dv3s1lx9YDGYkJRWBNDVwUpU0O82Ia9+MoniWeKmIFfY/PEpr+StJykA5P?=
 =?us-ascii?Q?CBc+paiPPpIccsq8v4IjEQNTwMgQCZ7VJkGYbJ/YlTXX37MK8nahEQV+xK21?=
 =?us-ascii?Q?/bkeaz6LUytIniyL1jJ8ZV14FUKJfpy584sefdlEpK7P65PqwsHyO8ZzSSqS?=
 =?us-ascii?Q?2DX0pLKP5d4ffD7Qk+wBa7RaprH7SQUbCid/9DOEuMcq5RcGDox3zrNz3hTD?=
 =?us-ascii?Q?z7hoC8jDsbXk7z2O1t/tKEbSPi7uB7lsy2/LjGRaTHahZpXrzviBXKbdBacb?=
 =?us-ascii?Q?dnxdIfDogK7Z+nZpiezTZwH+7/w1CprXzglQkklW0woChr/B64/7BvnXW/Zw?=
 =?us-ascii?Q?oZaENru0wfHzxmcaKKmhuDIA4lFFHIeCX04DJTh9K1cbJ4zSd19ZCSShdYzn?=
 =?us-ascii?Q?Qm/5yGDh+j5xE0ldNQHJRG8JQ5u1dLFc9LoAauulMXZ5LiNX23/aUEgldp4X?=
 =?us-ascii?Q?VK9Wawlf1ErCz69LBy22FwmdHRQbVINLfjgOk6CZ2YEI5I06J5fIPf/aPoDh?=
 =?us-ascii?Q?S7TOdUTENLgRFMKJX7M3R6XqI40g6pCVsAb5JL9QvwWvTGMuN8Y6orgTm/eG?=
 =?us-ascii?Q?XpvsG6YKKwxjk7Il+tvt9cskd4ft5f5fmPtGY0tx9yR/kcrNB0LDuTGxFGA1?=
 =?us-ascii?Q?gxFwWWMVEN4SggO22f8110OJ0bSQFT6oBnEzZwsWopNUI/lrntNyk+FJmb0+?=
 =?us-ascii?Q?L/XQvAKOc03tmyDOIzBVcNNcjF76zA9ll00ylevV5M/PR3XjkIi/YC22QamB?=
 =?us-ascii?Q?JnGSax8wbRb1mala9mEmf8KB6LPnvO1GeerVAKN/iumwTX1eCfURfQkVO/L9?=
 =?us-ascii?Q?otL/QQ2D/GI9u5jLFkqL0geMt9C7JL/d75/biV7ohp4FTZtV/E7aR4zJE5Fi?=
 =?us-ascii?Q?H3LM2KfGpJjz2NFO6QqbcQL9Juam+8Z0JWUQG8e0134fnhumsCU0zzQlMfYw?=
 =?us-ascii?Q?TbkPM5k8lNWDuWnhqINT35pZjHtq6DqoXjy3/XdnKZx4O9XNIPw0IhsRhzm6?=
 =?us-ascii?Q?/KnupZ3yhqoVOa6rVz4wbh1uozCsGtkU5ZIu6KwjPmCrncDBN1VfUoiXCD7c?=
 =?us-ascii?Q?ubITH4wGBFikJO9NEVFIxGHHrGRzhx8SPpSngH5XKFMBhCuP49WG/rFpTKye?=
 =?us-ascii?Q?rzbnKozary7D1IiMA8y9V3Ra4roEIvJd8DRG+HWUjkTo1KMY07vMq0sdY6E6?=
 =?us-ascii?Q?M89W+tm5IX5ZN8FkoyD+laoLUYy4o+zkjWblXAU+Dz2vVMlQ4fv7FXjm2ANz?=
 =?us-ascii?Q?dgl8X41K1YbW7ykHsApQuXhRmDkgFhJ8PvgMP7Bn4sHScQn27xGckt+1yfqO?=
 =?us-ascii?Q?YjNP/ec2Hp7rI61pZH0ItkiQ075fs5/fXOirtEIsaJGvwedSXiJHmtQOk0tf?=
 =?us-ascii?Q?SyZ1rcjOkefjvvTzE78wsGaZA3V/2Z8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4c67c7-c514-45b9-a957-08deb5f9aa5d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:55:04.3849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLP930mOAveWyNLcmSaiB5OFPOUFC2W2xpuuYrR6g8NAVx8CBmYaiNAwvIhUQwhoecoD4wBuTll2zi3ODpLyvWKPaP7EZDMmUBy+waBaAVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9424
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

Add a section that explains how one can embed scripts in the control
DTB and run them from the U-Boot shell, the advantages of doing that
compared to using a separately built FIT image, and the configuration
knob that must be turned on to allow this to work.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/develop/devicetree/control.rst | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 634114af59a..7d6117d5c4b 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -232,6 +232,64 @@ outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfig
 option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
+Scripts embedded in control DTB
+-------------------------------
+
+The `DEVICE_TREE_INCLUDES` option can also be used to make the control
+DTB serve double duty as a FIT image. By including a `scripts.dtsi`
+file containing something like::
+
+  / {
+	images {
+		default = "boot";
+		boot {
+			description = "Bootscript";
+			data = /incbin/("boot.sh");
+			type = "script";
+			compression = "none";
+		};
+		factory-reset {
+			description = "Script for performing factory reset";
+			data = /incbin/("factory-reset.sh");
+			type = "script";
+			compression = "none";
+		};
+	};
+  };
+
+one can call those scripts using the `source` command in the U-Boot shell::
+
+  source ${fdtcontroladdr}:boot
+
+or just ``source ${fdtcontroladdr}`` for invoking the default.
+
+Since one does not need to separately build a "real" FIT image
+containing those scripts, this simplifies both the build process and
+the boot logic, as the latter does not need to first load the FIT
+image from storage.
+
+Another advantage is that when the bootloader and boot script must be
+updated together, it is easier to achieve a guaranteed atomic update
+when the boot script is embedded inside the U-Boot binary, instead of
+stored separately.
+
+For the above to work, one must enable the `CONTROL_DTB_AS_FIT` config
+option, which will (when the address passed to the `source` command is
+the address of U-Boot's control DTB) elide certain sanity checks that
+are normally done: With the above `.dtsi` snippet, the control DTB
+does not quite become a "real" FIT image - it lacks `timestamp` and
+`description` properties, but more importantly, FIT images cannot
+contain nodes with `@` in their names (unit addresses) anywhere, and
+the control DTB obviously does have such nodes.
+
+This is not a security problem, as the control DTB is necessarily
+trusted. In any secure boot setup where the bootloader is verified,
+that mechanism must also include verification of the control DTB. So
+in fact, since the scripts embedded this way are then also
+automatically verified, it simplifies implementation of secure
+boot. When using a separate FIT image, one must build it with
+appropriate signatures, just as when building a FIT image containing a
+kernel/dtb/initramfs.
 
 Devicetree bindings schema checks
 ---------------------------------
-- 
2.54.0

