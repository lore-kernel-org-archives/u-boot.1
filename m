Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9AEC3600D
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7893281DED;
	Mon, 24 Mar 2025 16:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NswWRFnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D2581F6B; Mon, 24 Mar 2025 09:40:45 +0100 (CET)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A23D1801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENdIb8hryIPdhqtzLRzYzgb92mJpco379S5p9vkwYnY6N+rK2ckW9km7kdwaGMTBokvyqC2erJjzsymjJnDAuLYs18yYHTUWZdfKZ+oXpyg7NuM6etIWTwr+bad6NDDRS7jNvgvaus1M3hIhsrWkakqnee0EzyYDShhx0NSoGV3HByDUqCKzE2/pPsGCATtWbvxBqZZZkiUxBPzRN1pKFRFs4IcMEFYkuNNs6E0ERI0AAU2eFIICEYJmin6DZH4Xgyj0CtYSU58N7UI0bsaJymlkCEITyjnQf1LyffcqEU8VgItygDTj/nTP950afUlsToK7pAdS37hkoPE1Rp7apQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHe1UNYlvk/2RwZZrYSPoUDbYvMc+sfZlRw1nYfuV7w=;
 b=QG0lVW3MQ9YO5jV4xj61zDNiZAom2q2p0UQN1m+oQMd1DZrawOmcuTxQR9/oYL4Cq1fSlZr5GV/aTRz4ebKOtFZ2RaZrkyHnE+D+amZ5ATzj5+9qa1h5Aui4oQXev57jTkzO9AkM1nnjZXZMjJPlviqsQ7Vu8g8iyvhmGQsKM1A2HbaTghAb6YbXzaBqqLExVFhu3VYvpQn+156qq44ZN6RlmhKfbBZvR9y9PH7adKbBsxOtPYO/VCyD5r7nbZ4gep3DCCi362Gksdtk8RiS7xHfpVDja7JXHazGGsYtEEIBLjDx4EQlBx437r6eTvjTZ6+o5r/6/uxVMQM6HG+BKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHe1UNYlvk/2RwZZrYSPoUDbYvMc+sfZlRw1nYfuV7w=;
 b=NswWRFnzNi7xEX/OmFL2k1gfQemDKYEAZGglqIlK1zOGcSKgrk92n9r2A/QZTzl0Cay31RKsPoSk8XTq3a8Zew5Q9KE3s4Dvb0JfiYQ68xMAXfABmhWG7hUydBi8sfuZdaqOhy6ttqUScbA2fe9tUhnZEReKMh8dKIg77SFOmw5Gkkq/MjDDup5KuVCM+rSlLZJDhghVpeZoYxo338m9+A4GhSofWprutf+OGIInddMdVoupwGJ9G2fJMV3XzIIO4TwsROBDmA4plsP4zWTB+kOZ1e5sqh2vGNJkqqmU2rtae/G/Pw52+dDDcAYsOzLWFJvzidKpOR0ZFBdp4Eoapg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:40:40 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:40:40 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 07/12] drivers: i3c: master: Enable probe i3c without
 slave device
Date: Mon, 24 Mar 2025 16:36:59 +0800
Message-Id: <20250324083704.26259-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: d114d3d7-d3e4-457d-6b64-08dd6aaf8ecb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q9DCToR4ogaDH/b4sDKJum6IiT0UIkLayzHIY8SMKTlakoxRWBVk8yygaxq4?=
 =?us-ascii?Q?kO6ANfGq0PCJ7BKtdM5d93PbtB/4BIw/6x8lM8r7rseeIHG2TZiTnFt0OgXb?=
 =?us-ascii?Q?ju+QAsm75TvmUcxN2uGCSBB9dffLpfnf82YMyLYJt8IScGNkyE230Gs8y1+t?=
 =?us-ascii?Q?PtwKSCjuPQ+HTLrZFF9PtHIPlpHCNBqX308z3pOBUPNB+bXgKtEzI8uDEB5G?=
 =?us-ascii?Q?9EAQiePN4Iv7+f9zDbuimBso+yF0XBnuOi7Zs+q+Ur+BoLYqPejNdo487GYu?=
 =?us-ascii?Q?SNBn4U30dc9ELgTfPwl+Q1icwH3SKzIO8nkSECS8Lb7V+c67KO8KpfhegJSE?=
 =?us-ascii?Q?pCGgI/MHjJSz3DNWPZY1OOrzLGmxjVOcHdVQss8xtfwotyCeIgjlIodgLMKr?=
 =?us-ascii?Q?FFhlDZW0QPrDQ9qa2A4SASWz75Yu/r52ieVU3WTtFS9sOy8oZufgbygyjc7Y?=
 =?us-ascii?Q?nPsaGqDCPwoLGtg07T6Wq8XMMNFoM4j53ttsEXapif/3Q82cSeu3GXurEpf6?=
 =?us-ascii?Q?t+r4EtjGuiRHm9uUlKkc8C5YWSaiveL/YqqZmvZlhaX6FqCD/r1A+E/g21Oq?=
 =?us-ascii?Q?LQfmCiuvT7hbBX+yPS1ezwoJFdUb01svC71Et1mB8QN7fMivDJzIj0Ahm/8G?=
 =?us-ascii?Q?myAH4sAakcQ4lqCYypRMVZmiHrPCP/LgT2mTHQGPo+/ayT5YVqGGrEkx9OtD?=
 =?us-ascii?Q?axbQ0Ba3/hKcJtJz3kiQfBw8H4igdroo5226Zb6NlQvs4/Z/bD2o89sdD32w?=
 =?us-ascii?Q?yY9aE7KSHrmrdPvxCI0+Z/v1x90laggG45leUU1Cma5ckru3raCWqNvupPkb?=
 =?us-ascii?Q?9OOjClfpX6nsf+m7b74kF8PLCmGw6sNWItXfVADrsve/u9L5O/6Bz+0rdZWs?=
 =?us-ascii?Q?Eis3NGFvdijZlT+LpoG5vrr0c46i88w/+Wc7Bo6OxIaluICU0HiWlpteAfxU?=
 =?us-ascii?Q?9wHnSx0fg1wKs8LTsKzLDap4+FNiaZgfOTELx4xyYX46LeySuTKxx9fjKMFg?=
 =?us-ascii?Q?1hHwLN2DTOGYYtNDT/KbJilLWgB0+B48h1M+vECxYMeZNnfGoLzMvmwCPuOk?=
 =?us-ascii?Q?N2VzzewpnzPtm6swGCrHJYAVUb/UXFFH6QRUIDVm7ZUMjZd2U9h5QUGuhdnH?=
 =?us-ascii?Q?hig14ynJRtT1A9rEbyhEvvUqj5NkblhXQzq1AlEyd4OR61NqWDl0duFAaz9c?=
 =?us-ascii?Q?0Rtf8WacfHCPr06y9NL948Rq2isVlboJueM94rfO77YY6RlgH38RqXl/8V55?=
 =?us-ascii?Q?RlIORM7EKmEAy+kMTa8aQQrmBr50oTDaVmyse0NdoNxed5s9NKb16/NT6GJi?=
 =?us-ascii?Q?z7HQO8feILQrePHqkwsl0YyhRfDjJL626dflqO9W9lTiFkZk+JxAwWCrHB0g?=
 =?us-ascii?Q?XPetLXSLhBel5QpMZFm+SUda3UvW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZpAc3cLqaDScXpGaf2BEELU/+6DwKgj3LFQyiCguNilM2/ZLmI4J7ecGK9cj?=
 =?us-ascii?Q?vvjx1gRze8p1bNkZtFVtYQAd/NKHXi4CWFRsBqDvigjkkTby0O0k8EoCK3TA?=
 =?us-ascii?Q?q/I251gqsbWzvBQ7Bwb7+UlO4/fPlGPsqjWPTcPyDpjTM1Ynf1y8x0Qznk2Y?=
 =?us-ascii?Q?XMcX2c7w1yKR1Sjjt/Z2axVzLSPOkMeP6YOLhHEAxQKvmnSeV44vaB0A4mb4?=
 =?us-ascii?Q?Wb8SyVgTan5jaKWJ3JMuFxvGnAFlBiAj7cyotvS85gOUuy/2vhym7nE4Ept7?=
 =?us-ascii?Q?KEgOxQn1aK0APe+N3yv3z9eoOTH0mKksQTXpgPu9Oxk88JSnESgct4AUh3rl?=
 =?us-ascii?Q?ax/4EIIqj1wuljYTJbAt0bLHtkg4OjYdSOg8KNnHM5OK3oPzNafaRK9qcETY?=
 =?us-ascii?Q?q0qN59gRroHHn7gpqj2ekr/kLylnvJyoIb93LKPcnkqw0/85lXAoMDramEq5?=
 =?us-ascii?Q?DDROljkSw3ZcR0FqAVO9p+6k/5VRdkS7WeQpJTrTcxVLOhtUChZDRkiKdn6f?=
 =?us-ascii?Q?tSHRQkJcpJUpREvpIoOjyWyj4nFhi+0VARtOYmtp3EMgt7fRK9RqsPmjXGb/?=
 =?us-ascii?Q?cuREc9Ut18WSZ/fuIn0OrYsHw6n3Hvh2tVIIznr6Tx3sASdMPSP9mPPPK3jb?=
 =?us-ascii?Q?0o3DpF3CLj1VE9jXVoPeen5ym29th63UFHAx/947S3QKWqnuEX1m3BI0/5/K?=
 =?us-ascii?Q?5w1YAUu7g2V775Ul2SrUy6wqBPoNyLK/w8RjR1stTQpF/Srx7hL/tN96+/Ab?=
 =?us-ascii?Q?7QdZuwn3FXJHiKN6CMEdXwyOKRTMfayA68+iHVgfL7jCbPaxMfMPBgdmvdGJ?=
 =?us-ascii?Q?I51ix6SeThGRp2frM/2+slw/YIQIy6fqvXb0wPPkWkJxosiU1sM6hub2MsnJ?=
 =?us-ascii?Q?pJwuFEGkhssTSus+OeLZeAg+HVUhsho/KdUqjS8kCPm0sHmH9pAZLLHfxJSD?=
 =?us-ascii?Q?jWg10ttsfu855iW3s03Iw6VOI9ayHmBPKaYw+m+oiv8csgvfTcakp0R/t9Fv?=
 =?us-ascii?Q?ZWPUhNfSVgx4TugLuzHI5eqeW6IwjO2aTq3ic3wny3vhGaOKnKNMNOE0doiR?=
 =?us-ascii?Q?ncqg+BkMG9O4UGfz/EqV3BT9JUJLxOh2cqRVGWV7CoEserM2sYuJuQnZvWXC?=
 =?us-ascii?Q?+BPtRYwXE5fg9lu6lETi7OZ4OEyuEOg8lJ7NMIysDWKmtQ/Be1xXaw0cyrGf?=
 =?us-ascii?Q?+pQkcVj1C5sEzyemu4XNYeky3mg3MPZH0jaWUgP/ogxXgQfWZ03EVOQN9+Hz?=
 =?us-ascii?Q?n81uDuQ7vDWbny5A3b6LlzcZrnKszMA5a/lqlfBxPF4XooOY41OZtZJ2OwnF?=
 =?us-ascii?Q?CiPg1+RDNL3XUhr9CdoHX8P1hUMk6HhR2nwFkVgu5u7+XblCeXbIkbpgzABb?=
 =?us-ascii?Q?GiNdDWZjn6yLqseJBoS/U4hv2W+dNkpbts76eO1uv3pBQIwNh7MeSKGdMik3?=
 =?us-ascii?Q?UJ5WznUlOxotyroGdHqHSLmTo0/aXfzLowNTWcqI2yO+k3sGPGqAgRDJbHjL?=
 =?us-ascii?Q?67RFbZYpADezX6Nw2C5554N/XBohdMX28QzeP6dugvRBwlD75OxIob+U2amG?=
 =?us-ascii?Q?DZ8lHQ1HH1j5fbud75aAymC5hu2i3mwQFPx5PrCraYJnDBhcZwWGemAgLmx/?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d114d3d7-d3e4-457d-6b64-08dd6aaf8ecb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:40:40.6686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hICOWasKJeuOAnuO3q5eNkj7VBfHQAowtHwQIf24Uiywys/7sTkddUB6u+uogBrNJ2Gia17Y5qtu9s2lHpm49tzqBAs9u5iZ6Xmu9gKocnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Picked linux i3c driver upstraming patch to fix the issue to
probe for i3c controller without slave device attached.
With this fix, the ret check will be on command error and will success
without slave device attached.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index a4f2de1302d..6df6410bb12 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -454,6 +454,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
@@ -509,6 +512,9 @@ static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.26.2

