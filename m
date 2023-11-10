Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD0AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01C1877F5;
	Fri, 10 Nov 2023 10:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="fhMhfc2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649CD877E6; Fri, 10 Nov 2023 10:42:33 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B60877E6
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzE3mskHUvpuOqA7uQ1hJsSY70TcAfl5mnWpWpKy33comEd9ILC1rFR2nASsUjkgBNJOjmPNd5Zg0ZMcZ1H7yRu2Yp/qo0P7p24A4n96idOksgWvJ4YEDl+3tx2lfVDlIvWdGZF4GMkXflFn9UyHF/nBbu7eKdFZ9midm21dij0BkB2y2ScRmoLAxBVp/RWd3nEyVEvI+YhEtYeNURp51tjppt9A/O0lYpCsxgpDgG7xT1DxpzkIEQ66jJsBm6kjmRGCzhWq75NSSRFwDsgNbjl0EFiJk5DG6w3n7t0z6gKLuYw31K3ZiIOAGZmeBr1yNhHUknexo1v/93OcunLrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/6IisZYzEsHv/6XMaWUwjKgV1OSUurExGhu3NiRhis=;
 b=S9KKD2GkZfXlRhnyQI2rqFIFItrBtucFi4WWmTFGOLLzqjAAJrOR32T9ulECaiuQnkb7+pLSG2VNyu5jtsYWBznJKv1LZ1SaXt2WK1bJRyNGiSxBQQ4uj+Kb7AbWqXz4RtZH+R4zURUcm8K/IBRh0XxDhCi59uqKX+wmmWFCjQu3u5wq7DRcuiHxdpuWrI7peuOI9/NMLiwzQJYUrQRlI9h/UaXBP7h8w3g/buo8m4WGo87jh2cPCeZMYuVERiXQ7qAb1dU9kppkduYgtJ6UxhaZsZmlX5pthVAH2SPeajWRC7iLJP4Esu1ab44a3hgQsL37qxRE72nfuvbAbxbs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/6IisZYzEsHv/6XMaWUwjKgV1OSUurExGhu3NiRhis=;
 b=fhMhfc2iC9Dy3rx417EHxVK5vj4L/W3sq/1OonLCRucv7U7X2cd+t6wgGh7OztdEwa3SvlZTBQPFCj4aZzo9NX6vG/9d78g7AbsbGtpmhPASgO1/pUpPPwF0KQ0awQ58Ml2WZBsayFdnXD32XBCjeiTovLDYcGwoTKw7u8dnZ2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20)
 by AS8PR08MB7910.eurprd08.prod.outlook.com (2603:10a6:20b:50b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 09:42:29 +0000
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0]) by VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0%6]) with mapi id 15.20.6933.029; Fri, 10 Nov 2023
 09:42:29 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/5] test: spl: Remove usage of FAT32_SIGN
Date: Fri, 10 Nov 2023 10:42:12 +0100
Message-Id: <20231110094216.50696-3-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
References: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To VE1PR08MB4959.eurprd08.prod.outlook.com
 (2603:10a6:803:110::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4959:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ad02e9-3b4a-4867-5313-08dbe1d15ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUtYAhIkhDv3Gmy8sUc2P7h37wUedhZWJRxf92kWb+7Pv4CegbulOsvw2eOb60Zw/U5nb3aszt2THtdNYLp1lhH3kZnBOxnlktFtHgP7UNE0baQMNaTr7b8lIGUBmHqpj4pbdhngMiK0mUYUO3YvUF1VI7mV8jp6bc9ZXqvkgBtwKlNLBzNqgdqOu9tDaE0cNIb5GiwqKF6jxixfbeRSCvP+a6cvaeuCsf6tAnkMgL2yrnWwYRKAoMMjfBH1Ov+Gj1OxIPSCT0+koWHUJWPmfewCjq/kXBmgxtBLSWEI8OShpH9oKlkR14wFLVcd/IhTG5a9PnPilIvhj0JZxYRn8CCqeQMT6Sg8GGb2zO7gaxagreiNZvqd4AGCeFHtkOojFqFrr/unQmmDGywOwBcqbR9SeF/am9gmRmTbeVbm43SOWtH5OnOGY82K7Y4vB9CGccOZjPrxaD+niDK43GF9oUootFtS9GJ4GvP8lUAYtyYXMsfXKZ7GmytigHED9ohkC1HIm3DNR1+VY378387anR+lcVB5AwfwVeNVpcJiqBw7iQfFIYYVHLtWRbCcLtthowfEIXKuzn3zyWMY6oG88BXLko+9erbqAzLKRcs55ZAGRiweEMxXgMZBn6Kn2jVs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB4959.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(26005)(2616005)(9686003)(1076003)(6486002)(478600001)(36756003)(54906003)(66556008)(66946007)(6916009)(316002)(66476007)(6506007)(38350700005)(6666004)(52116002)(8676002)(2906002)(4744005)(38100700002)(4326008)(8936002)(83380400001)(41300700001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SObqYtg74f5EtvHNA68jqQZnuPN8h8zMuKI/hUEzhonJ2PjCMTN4jMlyaEsL?=
 =?us-ascii?Q?FP5IIDOlkWi+h3Pm8INugARs9kY5ckVcrknglWdzAxnnv0kHA4jgMtipivY9?=
 =?us-ascii?Q?CbJgZ1rWyRZrG/s+3lkQdxm3MUhEW5QHsTRDStAwu6e8Y/KNqSsBO+OJCWEO?=
 =?us-ascii?Q?+CTs6uAjNgnbCoIe8dT2vAPt8DHL+ZNQdjRhaBHHsrxZFYRE/7PE3Y7lklw8?=
 =?us-ascii?Q?O/MV8rrKhebo6S/U1qMcEoizmzG6a0enIMybVm6H8m+d6aWS5mFg3qd+3sJ2?=
 =?us-ascii?Q?DDKG3qCJ02ri0enBZxBh9LyiAyNG16ZsJEo6x++iJYUM5NVLGhI2erHCjTbY?=
 =?us-ascii?Q?qM0XUyA4wgKNk8JbRcII8zpdxCS2dMUEVdP3/kjxCrqsTySq80o5Jy8GdMKq?=
 =?us-ascii?Q?vKBeJoTc0xQDQAv6xXA57608u7AfTWJysxz+GfBq/qDZgp12pMiBN9l0Zr26?=
 =?us-ascii?Q?tgHSlwLNm4cWQ8Ln8Wi5DsTGnJKFK1g69723cCxtNQiECHUHktcKmy7gefvg?=
 =?us-ascii?Q?ci5GnBvlkrxLpOIw67pLkee4UlUOXY1lmD/6vCAr01PhNuhIWm05IcFMq+gr?=
 =?us-ascii?Q?ly16ypXQGEXgURecoUfAWpc5C3eeqaM8kd7LSu9HWKq6c5U8g/KBaLtvaPQD?=
 =?us-ascii?Q?lceWt7ZZsqu+ITcEMCduUZylwbMTWGWhRNr8eL1J+hbatNmRmJiNp7UjXqHy?=
 =?us-ascii?Q?8jEryWZsnH5OoXe3Wf+Cttmm/laM5lzDVEuZ92W1udTnFSSOBADt15QPmwv3?=
 =?us-ascii?Q?oiut32X7rGdxkwOyrtkclLfW8n2qwmcqR0oqj/4ciXY5Wg/v+ASy27Fe0GMI?=
 =?us-ascii?Q?jUa8VrfBT93D41dMQbrweQ5NYcfKBy0arMtRi3j7eK/SnCgFuHR6D4lYGiWt?=
 =?us-ascii?Q?M5mVxI5wK1JMeyRCtbCzGv6RSK40Wacu4PFT4U3seg0lIgXzcX6RCqYp7pDO?=
 =?us-ascii?Q?oFy8uTlKmFijNh9+Vt9w2E8xhzkEbt+jeccCjkAxZ6/820dhUN01UL/8nRtl?=
 =?us-ascii?Q?RCgThdUlOqh+z9vlf/Sqvx4EHRw/C/iOMs4ng7PcUYlhwoixsErZFu0EORTl?=
 =?us-ascii?Q?PDhYA5l+1jAXoFFGUSyoKM7hUXRBjA8/6AqB/YCItlBSE2WInp5bMGiFmS+F?=
 =?us-ascii?Q?KMDux5c/JeQpWD680evG3MSF6pcCIo0GkXmnzAzMw0AeeXibiRIK8y45vP5M?=
 =?us-ascii?Q?TBEfkEzFFrNPlk5eMGERmQIpfs3x4SYHsSiHOFxp+koN3HHTzPojxDGVHP2o?=
 =?us-ascii?Q?1/iJ2Rs7wD116WbUQ7c/kCEpKU2ylZd1SpkLk0paRGhk7GossBtt+96DMocX?=
 =?us-ascii?Q?nbEe1b4K0h/6GvtmklRZyoASa0zdjE6UWwjD+ADIurXx2pkfHrJ3QbyAoCIs?=
 =?us-ascii?Q?yvK7wep9IKlgAtPjt96Xrtqo7qcX17NCpevxm4fRHS4JI5v5IAC9zfI+Qkxn?=
 =?us-ascii?Q?udqnhuqw3CwJkyb4JuGNPaqz1t1NwBRx0Gzx2mnHedtBnkL/BI3mHMtN1YUf?=
 =?us-ascii?Q?ij+ASEbS5DvgpcTpAvi5uqShoH1ab8emDOpaLlrlKbIaguaeoXBTF9ITL5aK?=
 =?us-ascii?Q?znQraaXvNRiWC9f0p6+V50OlIx4R/a/cjGm2Ua+dNaKLRg7rwJhIZ/KUF01f?=
 =?us-ascii?Q?iozRXZ4g76o/UipnUW1FvjKg65J1G8udehQmR8I89uAe?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ad02e9-3b4a-4867-5313-08dbe1d15ac5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4959.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:42:29.2321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytln3pkydd845OOGb9d5KV3OvXauPb+As1CeSB6hSJhO1CJmLK4G6OhzOscDxi/Amq2PP5bHui+kYsfhn29H/GlWRRqMmnnStKrOQZ2Tc2OjII5Ic9UOwtWZ0kYxtgoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>

FAT32_SIGN is removed in the following commits.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

Changes in v2:
- Move code change in test/image/spl_load_fs.c into separate commit

 test/image/spl_load_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 297ab08a82..90e640b5de 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -220,7 +220,7 @@ static size_t create_fat(void *dst, size_t size, const char *filename,
 	bs->root_cluster = cpu_to_le32(root_sector);
 
 	vi->ext_boot_sign = 0x29;
-	memcpy(vi->fs_type, FAT32_SIGN, sizeof(vi->fs_type));
+	memcpy(vi->fs_type, "FAT32   ", sizeof(vi->fs_type));
 
 	memcpy(dst + 0x1fe, "\x55\xAA", 2);
 
-- 
2.34.1

