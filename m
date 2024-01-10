Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46D4C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521F487AB7;
	Wed, 10 Jan 2024 10:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="A+dSeym+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45ADB87AAB; Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC568793F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIl9AJKBap80yCs+b5EkdcgbtPJNNlVFB/MRLc7atKE+20KBgqXOl/bTWvOHfXDKJ3dUWfh4ygYd56N8kqmPy+ygY60pyplx6xYcy3uNUlfVabMv24FsaV4ZMcu3btmOB1rs54P8BV8eiP/CYYf+MqPodSaY+if/HQzCclSrlVEoyss27Gbyjd0wrNi3Sb3H6V7Kkja3qZeEQto8cDZYqu7QFRf2116HUPX6s4LvRxHKU0Q9yiKQMRMdVkcjfRsmCj+muJm3vNRoS1TPZXHA8e0uCd5SQOdHrlLEopPw/nID5jP5jbCd0nBIVjWORVvZvN9tlKinRgcZECpHnc9m3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y09zQY4U+bsvrV0YqjqtvIRI4L24iUdfmgIWvmCNl0=;
 b=cmhavdW7381JrE0jHsfcdK3SvZA1wYskfnRkn3IlvZl4Ae0kAA6408wVrF1NCA16SX0DrJLBcS72jgRBPlhIEmIBZvIzeqUL7B5E2klZBAztqrRPWBQg3MNBlTcYa9/GFfknERjH2ww6GSdDPvb48nys+a9GfDwKrS4GQPBVjgAohRi0SMYADlgneu39MoBFp54CyT77jtyHf7DNRgC/28ItzwWbf8Z7Ftx2PnmeD/YocMXbogKLID+FVCs9+xN/1qj/CPyQXbt+3mpUoJtwe8fVFq0oYfefbgezV58i2HiJEWKxRta8g1E1rWQ9o1AoZ/N/hSi9uR66+OTCsi7GeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y09zQY4U+bsvrV0YqjqtvIRI4L24iUdfmgIWvmCNl0=;
 b=A+dSeym+XyN3HfpX0uQUxmicEGqMyPMsGNJNAs/gWaRJlBjtEvNMQw8dcRSqvApbO9aarLd0q/sU3vfZ64UYUmUK+QaByY5anT8widnBUdA4Q89BNxPOZfpbQvgQxhJbqoCHXU5fpdCWIr6HKD3+QWhU7TraAeGmjk4NRg+LyaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:48 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:48 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v3 02/11] linux: bitmap.h: add 'for_each_set_bitrange'
 iteration macro
Date: Wed, 10 Jan 2024 10:10:28 +0100
Message-Id: <20240110091037.392520-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e3e09a-796c-40d8-d3b2-08dc11bc08c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PCy6otouYs1BkrbARz5y0TlRbjBxUB/bf+OJVAcyf77GFl15NjDcagAAq6b6UHQNKtDxtdt56KCaJxM+YGYEuiPLVKEUoQH7K8PW+Va4iW6L9mTCtLp+69pXMNbJneOasxNCmwBvr1Z4nMT2pJg2J/RwwMr8qGyOajCMp3oUVkPsgAqPFDubhBiqF9Jn1ddn8cq7YJoaZsqMxuS90+2z2njla5ebjQ4OMqtaj5J+uEtG+rrKtNkEpiTYl654ZTsabawhaMlCnckfJFeKMn1QezXrR/Ck0wQWqiMeBipkFNDFbOOdqS+3iGF5dIfXb7EnPIgXqX1lFTQmZsDh9XbITneFTpQluWZLHi/PWjoDYhDucE26tq/9FKpDthkPtxUESXRJ9xH1wFei3lnr9hoidLFEwzrNFels29ya9OOu0x/PDV3CdNXmBNnT47XTTXap0C4KGRpPHhxs4KfKtGQZQ90ZzwI1SvLyd318sIq/EK+nXQtUMT0qVaZNSNtKFvQ8V0zCd6R0iLOzsef3t87YyG2NNMblJ35LlEBNjfFLWJW+JXE+L5dhW0DY9/S/obEepODXdXZ31XMOW6G25wQ+AKMtxVYNw0BYvF3MrGg4C7xL3DPi8K4qhZ6RvR0j+Bc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(107886003)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CR4IIpKu/xHFYaWTkrqsBxL+AIWSVsgM43wo7rej+yq3hHBiEYWk6VlKaQxs?=
 =?us-ascii?Q?/eHj7lC+MAvRA9tX5gfNvzxHGA2cqXkNUAkeGwyGreNqonrMSlB+UXh/qRT+?=
 =?us-ascii?Q?04e4mcsdP3t3FkSqz3ZrIuI8DKV6aRPl8vd8qAH0v0PydaTMeF47PwglJtnn?=
 =?us-ascii?Q?Wy0flP8ZeYwz1sK1g6exiKSoMj3B7NspyZ720jJuLfDsgN0Tvej/FAr49eQe?=
 =?us-ascii?Q?v5a8zvXJXx2b8X4wbmoANr4eLNorzup8D85cfygE1wN0C2pTxQhauPZw2K4+?=
 =?us-ascii?Q?j+pM8L7pnR8AJWxjgKjMcLGn5TWsiRMYD2QGiGsAH/uEVhXOwuL9t7vmM9G0?=
 =?us-ascii?Q?pz2zjIDX+4K0JhjmVNqRM7ip2EHPh8C93vv7zSltXvZos4kF+O0473X9i3WD?=
 =?us-ascii?Q?m/YwR2h9bsJTBjkzwn0Gz9Hk8xv1dQDhM1+fKo4/MIbucV5/bqMSWuLVKHhD?=
 =?us-ascii?Q?hW2IXp6Bh1IJuW1xDfUkKINNdGeN5Q3dX4b9imvZBi8cvTCVT2YmizPDZnPd?=
 =?us-ascii?Q?Z4wxqL8Z1D6gJqWAZN/jBnHvcSc+XqCLEC/PyHByj6V5YQ59iHyWoxIEr3zC?=
 =?us-ascii?Q?2CNl0oQe6zhPrj9aqiDNEMTOPpovxs1jE0YqLJpgaw3m5iuCzuGSNfBguNpm?=
 =?us-ascii?Q?KhtuyJiawQU27+ryT3Fs+FeSJshsz6Tk4uqneRsxgYYGlH4HCFLl3hlXGbny?=
 =?us-ascii?Q?zt5Mcu7oPjXj3JD1k39Ed63wHHJoJQk5kN6LkoAj/ucP1FTTjhMoDtjzhVVk?=
 =?us-ascii?Q?J4CvhhDmRea+Z2fly9C3U74L919ojLud8E6hOtdcNO6ajGNQhzwtp7ZaTiZ2?=
 =?us-ascii?Q?vzc47QFvdyOT4040wbH3mZUAyV+QVkIlzTj8Z6dGySY1CslftGCY/32tsAH1?=
 =?us-ascii?Q?p9Nqofufp4ZZ6gabcodR5OqwdRQyCOOqdk3SXKS0mK1Vsu45j4d2501F7LGJ?=
 =?us-ascii?Q?hUd1VLuGD/1LcIq9F//wjJtUqBG90NQJiAZr5hxLNNMFPFbi8aCTVvnHjUbt?=
 =?us-ascii?Q?LWKBaAdZABIiV7lJFPFQd0YJHoAvEtPC54Zgo/0/Ze1vb71urZBSy/+nle1/?=
 =?us-ascii?Q?fqEHSXcpGtU0a2HCI6WUvt0/b6CNID+gPIuG6xRyFQfKgcR/QfNr0LtTLLAJ?=
 =?us-ascii?Q?v0yH0onOU46Vi2wpa/8k441Z24iU4JGYAeIDLEBYROrGLyM27iuv6onROzk7?=
 =?us-ascii?Q?ZA94/9p+KDefmdug/0itj5jiopg4Aw0tA7A+sO4ykvc93U4UEMnNsKTMTWV/?=
 =?us-ascii?Q?nv8fAdMk0IF6oc+vy9K9ynIM8yEa/KJ+v1moAz6pdyy6hiNnQPH4U9w9yKHB?=
 =?us-ascii?Q?roH2zWuM2Wp13b/lsgfLhU3LUuS8dEByHvB61x93ZALVQR9CxADo6+qtJ61H?=
 =?us-ascii?Q?sq2O64WSQRKBMiKRcoEj/jZCz2sjy2FqWpAKygTq2GQvUdn/iyvtAzWbrS05?=
 =?us-ascii?Q?kZkAbd2HLn/+0++tmmeeXmagaQRZlSzmYRVCPhiEbcwfOjf6VUZUfHIH8d2k?=
 =?us-ascii?Q?SKYSFdh8uK4VxZUkp6VDJtQ63bzSthiqRWycmqKvM+BU7Vn3X8G45oB4q9JB?=
 =?us-ascii?Q?WyeSziw2ZU8JT6xW7KG/6LTHuaq+bNJHvK4/Yf2bAtLwrI9caHhyy74t1Jlo?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e3e09a-796c-40d8-d3b2-08dc11bc08c6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:47.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCdmn1InofoSiZ2A7FvOf4YvYGWsBgm0Wbw+nmYNSsdujBPTeeHGrxblJLEgwqKCuGlwKMvay0GOiDxNykzXaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add 'for_each_set_bitrange' (from Linux kernel) in order to iterate
over each set bitrange of a bitmap. This becomes handy if one wants
to generate a cpu list i.e. for isolcpu or nohz_full.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/linux/bitmap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f..9714533078 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -159,6 +159,13 @@ static inline unsigned long find_first_bit(const unsigned long *addr, unsigned l
 	     (bit) < (size);					\
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_bitrange(b, e, addr, size)			\
+	for ((b) = 0;						\
+	     (b) = find_next_bit((addr), (size), b),		\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1),	\
+	     (b) < (size);					\
+	     (b) = (e) + 1)
+
 static inline unsigned long
 bitmap_find_next_zero_area(unsigned long *map,
 			   unsigned long size,
-- 
2.30.2

