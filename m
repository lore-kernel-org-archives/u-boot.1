Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDFDC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 13:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 558DA881A1;
	Fri, 26 Apr 2024 15:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IhyR3PPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5BE881A1; Fri, 26 Apr 2024 15:38:27 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662028818C
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 15:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZtSTJyKa8RkivZGnTDgTKB0+dR7kRv7sgRdAzeG+3NFUhNbv/W6cflo8z+U4PnZqcLCUVSwFPOECmZafBIGVewkDgms0UatBoFMEPrIeXpptsNXsGTG+p8p5KnSUCN6HeyCdtrYXkuWmgaY+woUlQCiSEERdNNJKTXndgTbBAdHNRjqnowW7wo2W/5B22eTz9rO0zxWzro5GIvWiWl/3L4dL/RwFnHiT0AOwWL4fF+bAnvZEnmVS/hk7XHG1NVe6Y4MGilI8eEB65Fz0g1IrO3KtnHri7sMyKTo9SoXUSqAK/JNwtD0PkKFjkO/NbMs99cORkLAxTLLZkJLjBhs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LJlE4KxMvPNO4bmmVs4rR5YTq1vO9s+1bOnUQDIzqc=;
 b=ckmvSuqRgDE/k6E7reS4J8CSg6YNDTtH3TMex+Xe01XpDsAcziHGA4B0YPRHZr1MtAF5w41Wy3YMo0/337HqTCGeeDTsZLaCbcj7iTPqCUo4fxYJ1qaJrJHFomiQGlC4F/NINTwreBPhXAG+h2xf+rzdynY0wBPSeRtDZvOG2wB+2UzXiT+Lo4V2GgtMUnT0Yf2IvE44GS80JfpmWRVZIkpvr9V+AkCnLn53QShQypAKHXfshoCCyyZyMVJMBKUgAfX4kVQmDf+LVhV4AXpCVzyjYvqyAmn4HlexKeVVcrHT1IpPk4QU8Xx48vawv0x61ICZDYk/3bR97PF5nqdfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LJlE4KxMvPNO4bmmVs4rR5YTq1vO9s+1bOnUQDIzqc=;
 b=IhyR3PPh/xZrkjK4D9nBa/KWrd/DOj2/EGFni6L+9mXrnWzvA02ateule6+C3b5ZQFcvv/cucIpEe98vfm6Isto1Ox57Piq2j2C08sHYecNp8QojY39iKJL5wjBlAd6S/ZAHkSnvxPPOyaEd7hSIEudM3s2/KpzebyYP+DmM6zA=
Received: from SA9PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:21::32)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:38:22 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::eb) by SA9PR13CA0027.outlook.office365.com
 (2603:10b6:806:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.16 via Frontend
 Transport; Fri, 26 Apr 2024 13:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 13:38:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:38:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Martyn Welch
 <martyn.welch@collabora.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Peter Robinson <pbrobinson@gmail.com>, "Simon
 Glass" <sjg@chromium.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/3] lib: smbios: Extend driver with using sysinfo driver
Date: Fri, 26 Apr 2024 15:38:10 +0200
Message-ID: <cover.1714138688.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YbcW0qfkLr7/qdkTxVz3xnpzaXrAWvw1jAP0ZtjCqI8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTtdS4hmSdblz/PEeNYtzea9eN804/7rs8W8UvK8TYpq
 CyK3yvZEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbyKYFhrpSpQxfvo2xDw7NV
 3TtX7pONOnZBnWGerufs5dulgjRPvTf63+1159/62Xc/AgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: eae255a0-b3ef-471d-2d8d-08dc65f623f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZchJmrnArAMfyzonNkLHE3WGcKddrGHA/G/Fgq4q/vjNRYEKmVq66dyJxocR?=
 =?us-ascii?Q?0KxTdKP6NykAoYySJTLDNT0LmDLikhgeh01VKOG/Xf7aVgdQWqRXEFKana4Q?=
 =?us-ascii?Q?5RP+giEm4o0EICT2JS3FlCg1OlDrMcGbZ6X6micPeEXzExPWRsk0KoMu/ND1?=
 =?us-ascii?Q?nHchfcfxISf5KyemWp2f9yxhaoaJS+WyTil1u3hIZfasZ6LUEKQjiTAoQnKZ?=
 =?us-ascii?Q?YqoU3faCgXNs2TIzUamR5wKJq5opEofV8N+TRFC7OdSeejNlomWYLedbTefP?=
 =?us-ascii?Q?VRA/9kqYKribsYrzXfsqkWwJ6ZSb0l1rxbC22CpZOZfUZpw50AFMboDXZ/9M?=
 =?us-ascii?Q?z84xzWrChajcVnraj7bcWrYmlH4f2Y/Lrfj3CI/IPzOdS1VTsQJQKRSa4q8O?=
 =?us-ascii?Q?PpOdICNBiFTZq/xWUaybP7JTO/Pt4PIB0Hwy/B/jVnDYg0mxQ1wpk0SxeQlY?=
 =?us-ascii?Q?VTyMN7Af7SafuKm0tSZCxOyB9yjcmcevYuZgNFON7YRLX8AF5F8qgrNR9wzh?=
 =?us-ascii?Q?OlJ4QH271guHaceIH01rYozX/KeYfktg6WGIZRkRfu206+VTPa9zNtyr5y9P?=
 =?us-ascii?Q?Zq5Y7Rq23tlv6CFnfT3SKvj7DNAb5qreMTeDHuU9ENYY8Ra8jd38qbtDNk0k?=
 =?us-ascii?Q?CgwCdYTg+Aviqddgp1BTuQ5A6rsIWLjGinceLna0ejICcW72aSssTaljLNtj?=
 =?us-ascii?Q?OQNd5c2numxMooJ+fOuoUZ+7M+KIvZ6s70r9M1ZIgKdac/AaHvReoDVII289?=
 =?us-ascii?Q?VP+CTlcYl1l5XW/YOamm8ah/p2NdRzhrpXQUK8cAKUHxPDyqnrk4rwTVvEaa?=
 =?us-ascii?Q?JsXFzFcMBHbrHumt1LCE1hhZ0dh0cuZ1jwCBJy3CnGUf5/w6hX4kaId/oqol?=
 =?us-ascii?Q?76ikankNuKzwno9nzbUSSXLZwilWxUqEWr2Mqzvi3O/WMtUPyGWRHTeN/iu7?=
 =?us-ascii?Q?jEKMyrWLJwP430c1yZlVqq1upgB2DzZwRULV/3WmH9suitSzEC8KEOVASKQi?=
 =?us-ascii?Q?Jv2BT+v342Ck99UzxtOe/VZtNgFHCv0Sl2gpxKcJ7NhjzW3t+IjMy3slKoLt?=
 =?us-ascii?Q?a7m9HsitAPARueJtBYqRHwv1g8SF7hSGrLHfAUmZZgW4wK2rAkY+YYWKmXQu?=
 =?us-ascii?Q?Wv6HA3SHGZbrzdk642F9OfGtq5M4Njd1BO7o1TGhyzqrosC7zdObcMrCq7zp?=
 =?us-ascii?Q?C2anbHIxWIhuY/Vpm3TR2gL5M7plaYZDMutyljd4igEN9D40FQUIlVv5qu/n?=
 =?us-ascii?Q?3ksFXjWpkycFevsJVBFNUPrvExuQvzg6N62qHIjYx8bJzQh48SDfa+l7bSDa?=
 =?us-ascii?Q?Q3ILGbI3fShyMg7YRweaW2l4gGi/l5P6bGJiGahD/YGoc852KFVJc8Tu8Y9o?=
 =?us-ascii?Q?mH/T12cvMccBCBLKgGfxTgovslIn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:38:21.8304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae255a0-b3ef-471d-2d8d-08dc65f623f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
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

Hi,

currently only DT way is supported and it is added directly to lib/smbios.c
but I think DT and env is only one way how information can be found that's
why this series is improving handling with using sysinfo driver which can
be platform specific.
At the end of day DT should be taken from smbios.c and put to sysinfo DT
driver instead of implementing it directly in this generic file.

Thanks,
Michal


Michal Simek (3):
  xilinx: Enable SMBIOS command
  lib: smbios: Let detect the system via sysinfo
  lib: smbios: Detect system properties via SYSINFO IDs

 configs/xilinx_versal_net_virt_defconfig |  1 +
 configs/xilinx_versal_virt_defconfig     |  1 +
 configs/xilinx_zynqmp_kria_defconfig     |  1 +
 configs/xilinx_zynqmp_virt_defconfig     |  1 +
 include/sysinfo.h                        |  9 +++++
 lib/smbios.c                             | 42 +++++++++++++++++++-----
 6 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.44.0

