Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF23C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 06:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4530682BA4;
	Wed, 16 Apr 2025 08:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="U+INOGrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B16A82C8D; Wed, 16 Apr 2025 08:12:17 +0200 (CEST)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F81382B44
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 08:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqoYyS1lWjX1VM9ihvCRWaUqCmEMUEJl1g1MxY8no4TVePOpvKpsdYd0CYPhMf+3GnAMCTVQ01x2a4eXska/8LcH2Dfrun/Mw9TyiqiPsBEsKlDQld1YyyE7XykG5P914bUrnALTvdHlPfTLZGLTKlfpuRSvhY9ncTa/33Lt2/S3K+Z/lcgPVwS8WZuK/RzMFDrbnT+mCkKV1MB5gM3jDcxmPreAVwbIyMfFxF+0qWagKsMh4ROtPN3PjY7FRUxT/sbKen8U/m7JdN12QIYcSdxl6qKjiWniqk3JJTSfvttAxBJ5lukVFKZWRlSP7rtXDJavQfg5m8KTGCOEl9nMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPQd7QqiFV2Nl46eJZEPbZDoN9m0lr5AVfSET/3EMJA=;
 b=UW6yiFX2pxySUsaCsGX2LZlFiv5FatjSxaLniGTK6xSHFvYR0r75oaQj816LIRBkydru7YtBIsdLtahniqhEcuFSS3UaEnrS5mChuowM3zvlOfDskC9qp7Mx8Gcd+V2dq5EupogSvpN2/KEZElnam/gq1iJNR9Xq01rTA+9LlRL+zEpMwNwPnwGziB3SKUb3mXHDRYRPHBDtyZSubwIIVrd0lwM//k8zm5t/9FjsClYWhoRqGnjj19OmjOZa+wy4P9hgwNCXj9S8xh+LVDk/rO8ivpwkDkGFF0nXhtPu7g0xlxOV6Ywxn/UdHZ463p9QiXqkvTtWELlDs8gwbq2R8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPQd7QqiFV2Nl46eJZEPbZDoN9m0lr5AVfSET/3EMJA=;
 b=U+INOGrVdqmNB9gKuiRTiG9CFTM9o/lvzt/FDFhFliqjdL7Xnoh6o0PS5n+TeqRvpu6DHMVXNgyDk1uOAGP4Qt8vmEZm20oE2s0a/X5V4IcsBMJBqOk/ZpTmd+A13be57YeLfuco12ZkjbnawGbGzX568Q+vVnkYj/LZ3HXJuVQV5GRrEI9BpeC1ibamyXFBEguulZt7/otjsFItr8BBMMHM2MBvzX2Tja4vq8dmrNS3gA19xMVG9q1E6XNkUCSkKsaXWyjYPStLAQn/vW/uT7vTsFY+Hu90zIiy6AhaybLYLIM5SE5xhdyHDC+k6r/4EtzLOjAP74KG6mMEzvk99g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3873.namprd03.prod.outlook.com (2603:10b6:408:2c::15)
 by DM6PR03MB4953.namprd03.prod.outlook.com (2603:10b6:5:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 06:12:12 +0000
Received: from BN7PR03MB3873.namprd03.prod.outlook.com
 ([fe80::92d6:74fb:1062:bd9d]) by BN7PR03MB3873.namprd03.prod.outlook.com
 ([fe80::92d6:74fb:1062:bd9d%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:12:11 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH v1] configs: agilex5: Restore fixed bloblist
Date: Tue, 15 Apr 2025 23:12:05 -0700
Message-Id: <20250416061205.5168-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:907:1::36) To BN7PR03MB3873.namprd03.prod.outlook.com
 (2603:10b6:408:2c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3873:EE_|DM6PR03MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0cbfaa-9baf-4b44-21c9-08dd7cada030
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k4VT0YstA7DoiuYjH4u1Ai7Rgr8MedQsnW8XG70t6ZOaRbMXrNiBPyVx/6le?=
 =?us-ascii?Q?tmDJu76DOBwkIW/9LmhxfueCcLvdpWBwsDenw+QQOOgD+t1+QYzu5rIDZ978?=
 =?us-ascii?Q?vnvTUZI5YD5tal7/Hljgf1aCDsCRPD9jBHIkirxXxrC6sjdVA4yEO/F8/E1J?=
 =?us-ascii?Q?7eMRZ7De2c6+0oct1NFl88ioNuToVniquXhcTkp8UL/+Nkx0FpADM9e9w/Q6?=
 =?us-ascii?Q?oNA6CqWkbc/CZe+FCcRkvx9LtwmTQp609tMV2iY4MLgUv4T0Q5ySZKzj0m1M?=
 =?us-ascii?Q?8MxUNbesGut7CfnteXXqq0rFeSYRXkIU6n+vTx+pE/f4k5+rCRujFzAmcEWS?=
 =?us-ascii?Q?r/F8Ckh10DlOO+HKTtFS8ggdchBmZGIiZZMC96xQGoKop0oKKA7vC4yIBzph?=
 =?us-ascii?Q?dBUscWgslX+6IA9MuFY9YbHXwNqlI6FV2RofcT6psY5nhEFcMcBlmcjeLSag?=
 =?us-ascii?Q?UhzE2Ob5a3II/h6l0tYupXmZGI0czlChbg8i6idxZNrMQaJaZF6f5OgmvTf7?=
 =?us-ascii?Q?Qtw3DgBvx/SFRJQwTouKdsQ9x9F0MlmM2mRxB+3EVZepLXUdTk5eWK0vt6+a?=
 =?us-ascii?Q?Gy6aeUMeYt/TutQdJwDixzfThtLtdhrHh6SFT4VVlXU/J3vHZDk5Qk3q4T+u?=
 =?us-ascii?Q?imbCOJ92JNh1ciZXy90VEDjtr+t2lghDEoDkVFOA0J+EDZC6sINQz3ToCDo0?=
 =?us-ascii?Q?TYBI7PHz73UfOQhRHUUQS75FOaVElC4DXzIv6Pcmy6NfRdeqrQX7CCtXvDwL?=
 =?us-ascii?Q?xtoVN5SU9DUTr96FcCEevBtU6MFTicIG+jD1VSmepDzpwAS7TGerMuK3ogkV?=
 =?us-ascii?Q?k5ep0NUAEOAqx/MH9VnA2fvNC9qFvyukrotbuXB9xCs01mpMvq4Q71u/MJwn?=
 =?us-ascii?Q?XjuYKOYQFNZznbWiLbUqMcKdreTfdY0Rgo/bFsGFt8C88vg7LSzJh8V0pWLh?=
 =?us-ascii?Q?43DxOpj5mHkpcX6+YNeYZLX6zi7s2z75zJ9NSkwvE0MkHfdsz/UlUPFCE9R0?=
 =?us-ascii?Q?Cdx7bFtoY3F28h/TzaVoUD43ffIhAKiXI4QcFtBTLdGSBIDmmozNLq5+zaEZ?=
 =?us-ascii?Q?SYWDKF7daM55wwSNnoBEDWEseG20rm9R9Bf1Q6XimgeJrRM7lkiJItd64ZLw?=
 =?us-ascii?Q?tYw/PxlVcW58BZkMfbhYWpXsXIzc6VJZh8Mj9lu3z4qpLKDWmJNfAzUi7y/L?=
 =?us-ascii?Q?MDjEOAXXDhJtLJ1JO+IuPlz/h43ZmOnNUx6tQQhmpdTgdQG5NkJl5X74J2QD?=
 =?us-ascii?Q?w0E/RWx90uCEgPI6aHd+zkW0oaEeoMrNeeB4Za2xJa29I4wi568gjsQYQoZ7?=
 =?us-ascii?Q?LnTccLp38GskZFkSL4mI5FeR5qWjFfX7sUEBjsmGg93JhpH8ttdBkx8/leBY?=
 =?us-ascii?Q?poMN1qYFZlSF1spPj1jrpWDZpJTVEOEAAGtJox77FDoW5Wfk1vhSGI7gjEaZ?=
 =?us-ascii?Q?3hIDv8v8/DE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3873.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5KjBWzaaZlsSm3S1oUQNAqGlTM17X1z5oKlnzG4dhYDzi11T4YLYfanfyqZ?=
 =?us-ascii?Q?aQwd871XjS5eum7y5lQlDDy/vUnjViolTzaaD5LL+xYHlV/OC+65euappavv?=
 =?us-ascii?Q?5OaeDTa/C2OG2vHjXjFioGPnOTnr3hKm39CoOTrn017inec7XqsNlcGOsgLP?=
 =?us-ascii?Q?Beev8RPpx6vPWcxaRgry1uljSjE+CaSP/jau2SPbQFEgDejbUWxFRLzuLoqK?=
 =?us-ascii?Q?fAzYT99sdldo0hzBxagvfmahe+716vxqpJqvqJH4MmqHCOZMNxpWVidxp5xF?=
 =?us-ascii?Q?r8vmuryCUiD7bHVy2UZW8PokUQKu31lDunpfL4OvSIvdvpPcDYo6vUCqaqor?=
 =?us-ascii?Q?ASKqWz1J4+RgDX+du4klSuxIIpGZkoIPDMnHkvuBIm3R51UC7Au/Q3H3FXaK?=
 =?us-ascii?Q?Sjwuk/DUzUaymAwWIdkGbLJyIGlaMKTLd5zAk+AT8XNdnAIVy6PbT3wp2wT6?=
 =?us-ascii?Q?bJgRf2uUyO96BjYx5r5MqIvXdaa4qQWBo0qUV00W/Kcm3U/jQFnVeXcvUocV?=
 =?us-ascii?Q?A5G1+STFTxLmItfmBCxwopQEqWoJtXKRwKPAO3VPWARZkexI6rJZ22nLdxpO?=
 =?us-ascii?Q?yXIVE4UdNVgHnjIye01C+pMXAP+TgYIlRV0uKaqhuzYRGDd4nqr104CziMts?=
 =?us-ascii?Q?gGVJq9jF0NBSIikCZJr8mWEJng+zRmKAwAW1sH6M8bRJhHKqPt5JF9+JnhDL?=
 =?us-ascii?Q?eGTMOjO87vSudNsKVVucHBKTyWOONy5OJp40BNTvBdvH972359fWO0BrG9Ij?=
 =?us-ascii?Q?NrDsfExa5FsHAvJ+5efLkK8STYjABvJ/Fs7ik7RtZxpYGcaL45++MVXzPLvO?=
 =?us-ascii?Q?loNH0k9JvvSiMFR5J/55h5hQYn3PFmppzxuWywUvH5z5sDwIleAnc+o4AeI6?=
 =?us-ascii?Q?tw/z6EjO4sworE8HvJe3jiGiGQSnLlO6OC03LvfJKUfX17tK0VE3sxVX9ae+?=
 =?us-ascii?Q?JoaEWgKPgD0Bc9BDzC4UwHyKsedTvVVMVGia2SMKan3JBRsuvia1cXEso6Qt?=
 =?us-ascii?Q?6AF8QAiZlGUVjRo6pudWXYk7X7EfXWg2txsTxNU27Dhkm+TsGItMBeN3P0pM?=
 =?us-ascii?Q?S+uf8weaQ8pRaqyVQpCYB9GqadiLp6WJCKuthZl4b3/SJrukHWQnHh2lG/nG?=
 =?us-ascii?Q?45EUSDo5Dsqunscwr7vBqPdLpphiLp5mcNj84aPzGEle74XV/CV6W4BgD47c?=
 =?us-ascii?Q?FqEQv6M7BqSwpx+u354NqQ8nGha8cpFuY26uhuZEbZ80s85pl5maGJEi2J6S?=
 =?us-ascii?Q?55AGARH/MhtLATFCtO0MlvPff4XbeEimj6ks/CwINvv0k/2oTCBiiY2v8hEo?=
 =?us-ascii?Q?uWrfUgVExunO/a6rZjZr3yY49jg7yMCmxSn0bCUX9Ixa/GNE0N8yMUKWeJnl?=
 =?us-ascii?Q?nhTvRYrG/OKURSvxesb5ke5ycrr1+MQRaTS3+iFGhQvHq5v3tHF7ceNSu3MG?=
 =?us-ascii?Q?WmBxwRRSBHLvAzQ1RAurENgMR8QqI9lW2PwEF7p87vuZaRIuB6C2pRJnxVB2?=
 =?us-ascii?Q?WaMC71kYR50+l8/i/WbnLDuRlvW9KEY4pJ2hTyL/Z1oSFz8gJW/Wq+9Kw7Tl?=
 =?us-ascii?Q?nfeonUwDAuDnxf+4I7R/Ze8N+U6r+NCG4HGefmFOfY4SmnBbF29KPax/h7Mq?=
 =?us-ascii?Q?yzHdaj6yZnMytZv/fAQ3dIw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0cbfaa-9baf-4b44-21c9-08dd7cada030
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3873.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:12:11.7458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcIewmsHdglu1IcRINVSMa3B3zBtSmt9X56DgrBvCDf/XBkwYBA8Hye8uto6kAc2dvfDrqux1lpWWFic554zbEfuvlqAgSyxzMqv25Enfkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4953
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

From: Tingting Meng <tingting.meng@altera.com>

CONFIG_BLOBLIST_FIXED and CONFIG_BLOBLIST_ADDR options were
unintentionally removed during recent external updates to the defconfig.
This patch restores the missing entries to ensure proper board
functionality. No new features are introduced.

Fixes: d6a53f523afe ("spl: Add an SPL_HAVE_INIT_STACK option")

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 configs/socfpga_agilex5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 77112664e8a..ad0625a59fa 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -157,6 +157,8 @@ CONFIG_WDT=y
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
+CONFIG_BLOBLIST_ADDR=0x7e000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_BLOBLIST_ADDR=0x72000
 CONFIG_HANDOFF=y
-- 
2.25.1

