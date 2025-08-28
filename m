Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E28CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 05:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8BA83236;
	Thu, 28 Aug 2025 07:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="As5/h3Ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D94831EA; Thu, 28 Aug 2025 07:51:43 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B02E831D3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 07:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+l/4k6gplS3kI9/01Caees2mAHwdgXmr13QY7SWSG03FoX0oRerY6D6wB4pGwJCi5saTkiokFxN1fK/8rvvKl0TFTi4BmEQ+9HazeJxxUiX33Y2vgO5VATWprr4VrjyjkFORICQ9FXVLbkkZdDs5o6rAX3cADvHbOHyT0Elu4ajUxZJAOqeluHfp/OanXcMxc8XNpP9yO4RElBVgYUV241uOqlYEPm5hP6H/aZY+r7Z7d6mt+K4SNnFAm1aPdDH4G4k5R272ImndD+R03l90oz1plM5Ck1ApjOjfsnKqdwN0h5xEMcUgdzQ5tME5vKNhpkVysYXU4E9oc2TxsTAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAEY7jgm/UP1663jGlwxLqGimCP3ma+oZf9N3LbvQwc=;
 b=Z9kJiJcWL21Sxw+jU8vBGsOCKqITRAm2jddZwe00jSMqojWPpPB3ZdvONpnZ/VoQL3w8H+xpNgGqj4sRY5TG3gkENi9Vm0JZg6lJTOAlmSyi8A12+X2kV83GihZ96ZkiT4kY6MrQ9jGEmeseJ5H5cfnnwqlMEY+zD/InK7bvVa7WobbDPcJzOBcI1cg3X/i2IWevZKkc5JoqbJa5ggRt23rQ78WlsfwEu9K8ASCw82AgDExKCgfvIod+/2IdjKKZ2lYvo9ISYJ9P28MjEL38poRuZ7UPccmhRyqkOILVeTrjnkgY8fLnKJDf7dVicIHG8KBsIF0k53igwFrBQerv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAEY7jgm/UP1663jGlwxLqGimCP3ma+oZf9N3LbvQwc=;
 b=As5/h3EeSTrLinVDe9rBvxkohn5cPiqYXUS9gHLqD/YgWubbnlNfJkspf7edTSaFNGsdP7wpJvT7q9dpcoQwJhKtF6c+d9cZePQeswDOG0fW6ZeexEx/WBM2DnCEfq9K/MDMWI461MLFR5WtT00LwHDUozB6yxuT6r6OvHiHHskxIN8/aTYLzuMoTLUL/pHPQeoWabqGKnMkTegolHwQtZH0+ZLvcdwFOU47HOjjdhMFokeX0y+AmoDfrKqJycm9eJvQJfsk/m/V/th6CLvqIhilVYfGnQpu5fk1lAqCryNNNEezKHCPFzDb2DYugGiFBM7EQBymTtITiT1i++fG6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA3PR03MB7304.namprd03.prod.outlook.com (2603:10b6:806:2fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Thu, 28 Aug
 2025 05:51:34 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 05:51:34 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 2/2] doc: misc: fs_loader: Add example serial flash config
Date: Wed, 27 Aug 2025 22:51:19 -0700
Message-Id: <20250828055119.25815-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250828055119.25815-1-nareshkumar.ravulapalli@altera.com>
References: <20250828055119.25815-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA3PR03MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 253f16e3-3d25-40c1-7e7c-08dde5f6f1e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?StJ1nQzwbgsHOiK+IxhUFWyrYGRusJgN3q0EBuOEFWe0Keuepw8VfJHs/IRD?=
 =?us-ascii?Q?hcjBG669VW9J0JySuQnYYMe3Eipq6fawX3v3l3VPBrKf5/KbdpyFzS8gt72K?=
 =?us-ascii?Q?JA2n7WTsou5ycnb5+76VtNo0tIzH7vhs05nUooBaP23rOt+Ri2L2Y/vKcRZO?=
 =?us-ascii?Q?2WcYXLpxW2kwiSuCe8P4a/Uqoibj5z80EEebAtqQHYkXcgSU+tAO3CvFSkcx?=
 =?us-ascii?Q?LIuLKd+N9uFSMj00nBN8aXLyJtn737R9HPNIe/DMf7kjwM0ASXljkxqXQNrk?=
 =?us-ascii?Q?dffe/Wmsj11C0bURf0Z+IU8vA+fduyeuhTD+qe1NhDASKDZT6jP28nLdPVbD?=
 =?us-ascii?Q?kb7+bx4JCsctiZmYJ3oL3VqUL1gt2xWSHpaLXl40SiQqmqdKXCOMY1Cox3Xe?=
 =?us-ascii?Q?aqFkQoU800w6ud4jP3Zz27YvURhK5vSurDQGiC2pnHXCU2Gfw1LDGucJYGU8?=
 =?us-ascii?Q?3+HD8c9GC4RfFZxvQUM5tMCuv0r1x7gxU70MCo88XaflojWzU7BlvkcLsvwG?=
 =?us-ascii?Q?CfdYZBtFbkTQnjtynV5Q2vnzb3UCFuDhaRAHUBT/aukCe5OzmuWi/d4Qq3Gr?=
 =?us-ascii?Q?jPvYp4+ffpSNhngh1Vk/bmR4l5ZxbZ+cgtN2hE8vAeZiRMt5xTt6x8KMqtdc?=
 =?us-ascii?Q?yd7ZcOkGZZ2lwornxzW54nU/eQkCQ/x3XndoUaIlj4+SJGu2D6ItsboU0Lnv?=
 =?us-ascii?Q?PZX8Lt+PLm6aeJgNZmc14LfbDVgVJYfcRoUUFZYi19Pguepjzw2mAD1K3Wxy?=
 =?us-ascii?Q?GB7YVXVqV+TKZ84CsmkoLsWi2iplnry48gfi/aCisP6bz22XLJq9R5Qh9VTD?=
 =?us-ascii?Q?V3lIP8i/liWg2qPHBVDVyv8S8uRYIJfwesAOeNnGpcVArnhbw3hgLN3SiWas?=
 =?us-ascii?Q?INRUntKiSP8AP1lzvbFTWjK0IqDs0/LjjzhcHjhdX1oUvpm8djpMs6njzhM2?=
 =?us-ascii?Q?n4mpsMKe3F4nhIlwK43aMlzFcjF1hb/SaeHZxyBkaKGFASmVO8fD2znxLgk9?=
 =?us-ascii?Q?3AwomNJZVB32mpfm1E2R3mJOPm6LDyyQtAGh0sHTL1f9kyeIboGE+s+C/H+K?=
 =?us-ascii?Q?37EjjzopbC1CIjHrYqxT6I2gyAcCo2fwA1w2CmEEi8ultr9KbBAb86/cn22t?=
 =?us-ascii?Q?qTJklUWOM+Wx9I0kUm5pwZ71Z9E4/gvYke1eR4oTf+PQ+eeKLImk1S9mo7TT?=
 =?us-ascii?Q?LgRW6gi+llEz4sO01MoGHP00s4Fvq8RCpKhl5HM4A+BOIm6bwgr1GZeCZ4zH?=
 =?us-ascii?Q?pXq7LvWiukcM71KvN1MihFRgto2qq+4QZ36P7Ga5og3voDMn9dEfjQD3vDjS?=
 =?us-ascii?Q?fwz8TqldA2w9lq9TVPHb08duSUncPLqbMj4U/hIZIp+QzzckyM5/0jJLJq2I?=
 =?us-ascii?Q?8N51g8IpI2P4bwkm0PjHHIwq6xS5vQ6J16KMM+lXIN7bCENN7LQMUgA9PygV?=
 =?us-ascii?Q?37nsYREQA4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V3pK3u2x4JNCYyxhgdMldlmigLaQm1qLQKOd9791aRdUf9poVjVp6lM136s4?=
 =?us-ascii?Q?UvpBWKy5gCVm4JCo+WJBzaPMaGRwbfRQeuI7YEQEp6iqaXLXR4V3rVlh7l7X?=
 =?us-ascii?Q?YWIgz3/rotnTtNx12CgGTmXOcaACgbzJ8pGlEbKvfXcJElXQQDLM4Iaju/aw?=
 =?us-ascii?Q?mVwhpNbQb2hW6e5lKlkBj9JTI4pRJUgwV9cev/Q8jk8IQMNKhz9qrbQqzxZq?=
 =?us-ascii?Q?04OMPf/19cFjT0hzMNptrh7xw1S0AP730YjeKAihoH+7ggNvXJXTFoL193LT?=
 =?us-ascii?Q?667n0YBf6FlwwA9iuOnxUkzRHh2mkjpsBojC2MyoA6QEzEORfs0VAoi8PNvm?=
 =?us-ascii?Q?Rxd7k6GKcgwJYv5wTvYR6jZw1iSy+hndL2PVK1Gs+3Syu7QijTYrXN8Bhs/S?=
 =?us-ascii?Q?ff4IchlAPNNG4bynS8fmbcD/sN30/3KRuKARYKJyS3T0Z7eDkPCsdpuzlEY0?=
 =?us-ascii?Q?V+5jb8rghEPNtOYsRJn+Sg1w2RMTtV2EHnobIqCmCa8vgQYaBDcDYsI/qXy1?=
 =?us-ascii?Q?4dLL+DzRcdl+fgohuiC8Zg9g3X+xsctqXTHb6XPdNEvfp6OQN8yW9kA/x3CL?=
 =?us-ascii?Q?YgXTNgpb/N6AHAiNVu4j8yh/HBUPoCOjhxjyrMkKM2cu9+bvd39ZF0VxLI4C?=
 =?us-ascii?Q?n5g/9Wj6PeQ3Ho1zs0Tr9mZI8JX0WxJ/tv958VFyd/duPOcsFKoLHtCk0cX+?=
 =?us-ascii?Q?EmRHpRC2Jv8p4f990MENU2ysw9/CH8RzAR45UKaDFKQyNuo9Rk5fheq7w2pO?=
 =?us-ascii?Q?7OR1UlXewmVe3TZbmFXYvmyd4fQi8hTIkbzWe5qOWkiYtu0ZPVYjMkUWC8yz?=
 =?us-ascii?Q?whwMH2NE/W+iC7zDqev2blE7HH1fh5++DHSCU+f5qxczGUwwq9cvhbBTCEi4?=
 =?us-ascii?Q?X0N3Wv/YyDUxn+i5RBuGZuLzILvXXB5zWp/vi+ViB1XAsSwNnWe5hih2qXga?=
 =?us-ascii?Q?3dyDu8L+9xq2EsNxwwj/iwv5O/7uLI11+BYfxRIdgi/fdRXSk7uDKi2w+mas?=
 =?us-ascii?Q?YL3uJIpg3NBpulalP7IhwQOv6HEy/ITedHM2fHvDQIcdpMhhJEOz6/WXwzZt?=
 =?us-ascii?Q?yLDKwHbsO7XHk2gT6bKEV+r27W7qfJlyWFIqbNAkS68J7ICJW6GSVG8fH1QA?=
 =?us-ascii?Q?zj1GNEbHC3DcyVDC3566N6/ook6TUgObYRBeAw0CMN9G0uLuAGiuBtSdW+Ff?=
 =?us-ascii?Q?ac6cU11a1+esIIVImAWXSRVpssN/fJRUFUIR8yloSbziMNN81WBsM1odSeSb?=
 =?us-ascii?Q?eZ+EQ2Ss3VvcGijSEmrHraBSWQqRVNs1xgVwmDePFpCCtcC3+k64rXIfGPZA?=
 =?us-ascii?Q?0ZumsqvucNF5iiQor+4tTB6frDc9Rn0rSIVUG5cRAAbfpcmI1P+zrndH61p+?=
 =?us-ascii?Q?r/YEctEXkF1sOipGnwHMLH1uQagllbT04mcC8qSGzsLqv64NqWrsvT/TDTLD?=
 =?us-ascii?Q?i3In/Axh2kG5rn8Ax5opdfetgugalvFfHNWZY5gtbw4bQEk6cxMcCWMh/C2j?=
 =?us-ascii?Q?6kaIXLw0LmnxxzvZokCTp7IK4PLYp12DBXNzOp1JcgJkT8IkmB8QxkyQfB1W?=
 =?us-ascii?Q?IL5wM7CXEiPlDLN4LecS9S+GhX0Mg1XuG8tpUYDh3bCiVC3NRz3lpw+e8uqZ?=
 =?us-ascii?Q?DlU6Hc/SQ4Qv+YMRSqKRL20=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253f16e3-3d25-40c1-7e7c-08dde5f6f1e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 05:51:34.1645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8iW5BEaU2nGcNRlIAUqFESMx/o/IikDP6wW723sNyLQKCN+S5A4uinPnNwUzPnZD0I4wMz2CyHrYUF+0ImXzlONArUu72x/o7UKolcx7abSeHe2Jq9TTWyLhNEs1wBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7304
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

Add additional example storage device and partition search
for qspi in device tree source.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 doc/device-tree-bindings/misc/fs_loader.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
index 542be4b25a0..488a670c20c 100644
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ b/doc/device-tree-bindings/misc/fs_loader.txt
@@ -12,6 +12,10 @@ Required properties:
 	   required for ubi and mounting.
 - ubivol: which volume of ubi the image loading from, this property is required
 	  for ubi and mounting.
+- sfconfig: serial flash configuration which should only contain "bus number"
+	    and "chip selection". Note that using this configuration selects
+	    RAW data partition as default which doesn't have built-in data
+	    integrity support.
 
 Example of storage device and partition search set for mmc, usb, sata and
 ubi in device tree source as shown in below:
@@ -46,3 +50,10 @@ ubi in device tree source as shown in below:
 		mtdpart = "UBI",
 		ubivol = "ubi0";
 	};
+
+	Example for qspi:
+	fs_loader4: fs-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		sfconfig = <0 0>;
+	};
-- 
2.35.3

