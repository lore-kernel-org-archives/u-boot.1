Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BEBCFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6909D83F89;
	Tue, 25 Nov 2025 09:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="j2HlB/Tc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC8C83F9B; Tue, 25 Nov 2025 09:13:36 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BDAF83F75
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQ68izCbw8XDO/G1AmHR5Itu2PeYIB6DwX5YE1r5YY1+WcVa/l76Ugi3TB3iti4iYA3tDeVbOjrIOrHfNbwBBHNeRl8A61+q9PsbfShH9kcm47DAhS9gCoE7DcKyQ3Pmik7qC0KD8i2YYKNqx4dUSAyqApUQ8LhchntsKl2KslGS93S42AdAZ1W9v4oje1pGSgqWbaVgsso8I6JuoqEm5zIZI6pk1nDAQizLRSPwm8wzQBIDDrm3xouXiRZBCCi4lA1tWd3FrZoU82Bcfsmsfgu+blWqWKYkL7LvJy6efNH+BT8lFOfK4jC5p6e0sExPFq7BCnaah585N0aTwfeF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA7iQog1rGosXEFQGEPHJZjeQR8z9WLO0iPkV3Gek1A=;
 b=qBElbcGp9JCg1H2J4fHVhLNcNs2G7Plv24WgbrVljfX+SXK4vQPNPLYxl5zzQVljVOOPIlX8JNti/6ns6aEPXUZrgEoWvjQx1QordrB5V9EDLM2dNk/XJhUWmARzOIjGUNokEIV4vBdlg+Qk8RFxJeNCDnFDmQOIVDg5FaFZrbnK6JpW2wv6raZWjYH9xkOetcJPFW6J/k/LUTnKFg3MbhvGevx9Zcu6kcZDyfggpGvDep9Ha8SecQLMuy5YygONrLf7THOSWQkGjjljtum0cC735vH4HrOl/ISgObvB1heJTV9f8o0MQwwBLH481JrPCG1R107hpAHBNMxgWe/50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA7iQog1rGosXEFQGEPHJZjeQR8z9WLO0iPkV3Gek1A=;
 b=j2HlB/TcevbThhmwIWHrxtbukAj4cwWbgUEXx7Wtlz6SRoyX3ZoKk2J4iqE7OmecLaVJ00dhzj6pWGJF3Ze7c7yft+l6jGHk1EmTPenkE/YbJ6/O3ohctGy6HdIxWClf6MfSm2KwQAlqCvzqYCRReWyTbgTRCVmYRId9r93z1skjDusD1CTBda7UeS3bGasiODmh9ihHONQSOWOt6571S3lZRjod6ZooVx7kIlRO8miok9HOrXgmwKUzTzObcUqH3n5cCnXleLaOGG1EKya16evORUjaDPSPVFAWc2PAwQilv4Ek/IhKP2mcDRkGOWqJTE8l6f3Yn6tkPTB2Zfjh+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:29 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:29 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 3/8] configs: cyclone5: Enable random MAC address
Date: Tue, 25 Nov 2025 00:13:11 -0800
Message-ID: <20251125081316.17329-4-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 481f3519-4610-427b-0f9e-08de2bfa840e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WVUjPL22DrrfthE52VjV8oAQLuNdGX3eQXa3TgGr8RhtG5vIuo/UJjt5pZTD?=
 =?us-ascii?Q?eCtfv+tdIi0K6dzyHubbgTFbnvvsbG1HF6F8hMOqDhffPGAF4wItJBwWKXA8?=
 =?us-ascii?Q?90c7AiBqEXZLHEeUn0eS72RWXkO9/r3WNkelkPKFCBO5X8Yt+ApNF46L/cNM?=
 =?us-ascii?Q?+Sqs9iMJ17jT/xiE+X9GchP17mZd2p23BHdYQLSjOzwxdnKLK6s8KtoWTrCo?=
 =?us-ascii?Q?OsO50myCG/GccDaCyMJy5wNypwjJaSZ2fSrJVvDiB99jMrx3Dm8WRE7VyVDo?=
 =?us-ascii?Q?k5pmjwWI25VOl7FxUXZGjIIkLGjk6UiKOYMMAj6ffwJWDbpFda3dRrJfbaPz?=
 =?us-ascii?Q?/pwgJNNrd01EuddUuFOPrE8oHs8zXZLjnpZBJ9mMoyDPiSF3gZcg7/C/OXq1?=
 =?us-ascii?Q?dkkwXIDGlP6/KptNHbi3COX73u1gAI0t8kLKF0tmyE1DU1Um88FZox7C5Pk8?=
 =?us-ascii?Q?lZoHbnNFSzqhxjHO7/tp+ncz3S9DAXzYV6mZXaSqmWyP4U6Qy13QRZ33P+pH?=
 =?us-ascii?Q?BAaEgOlkso5F5fLWCszqU9mzPylyV/uZx1W7U71j91MNpOa8Zoe2L16MDbjZ?=
 =?us-ascii?Q?SpdDDXeydG/qGhH2IkM8UxF1f5faEM0Mw03UZsOeQy3wDz8OpaUsGHEbnIYZ?=
 =?us-ascii?Q?DuKZ0EznodoVCWf4y/fJN4ZK7+rcR8aojb3UirLzGQyilhxGxn0yScQrD+1T?=
 =?us-ascii?Q?l2Ar//6BBoQcKwabBbbuJPTEdiBgHRE3Lmq33f2fCZ+C94saw7+jBcbKKoOu?=
 =?us-ascii?Q?RE5GKN3tFPbkYLFrGDywg0s2SeauQlSQd/jBNsjvCqj+l8ziAL6NVqFc4msJ?=
 =?us-ascii?Q?r+xgtgXx/CQVagLUqHoEguwPvOUpnDZaDJVI1x4257TYFjOujImcw3OanEj6?=
 =?us-ascii?Q?i0+pZxGN8euO+YBZmU/FwIOEVQ2xLFsu+KhkDzhjEtONSRdwEsRGd9aUaCmd?=
 =?us-ascii?Q?7VVUOMarYcK/hF8afsN6LyQJ37dzkNyEXApLZhM+RQWvSOQQTHRoS/+yrk2z?=
 =?us-ascii?Q?Fn8wyEARBcCxvVZvxER8IxEBRjFVaHJQF/eD4iQY1YlZ37mAXgbqwietJMfR?=
 =?us-ascii?Q?vXqqAYcUurVRxp7hS2gmHuYKp7X7xrSOYuraDkvM/1Zmj59ibJr+Iky7E/Rr?=
 =?us-ascii?Q?erZs+ud2hMDB3Oy1lti6jewOAB1d7rqhXNCno+sCWi/ZDurzNPKDoyanD8gk?=
 =?us-ascii?Q?MjInFFJYYKFeDsbF7hEgqp/O22BvdvhNPfKadrKLdFvnduNo3Y+zLvBaC1Bl?=
 =?us-ascii?Q?aNeJXwk/opJuolIJghWFe5hGMZFnVfuV6n7/9DCR9PjD24AQz3JUAcAv6rde?=
 =?us-ascii?Q?ghTZr5cB9W1z7/rDisr6Kluyj0U3gSb+LP08pnUnJgbHQ1XKTP/dMLsAx3lY?=
 =?us-ascii?Q?v0Vc6FS3s3YiRm7N5d23v0+BehQXZN/sTTg+8NpuAw4W86Jtt+OQxZfDuPUm?=
 =?us-ascii?Q?R6ohgiirHLe6X5jsLAHYu81KrP+jd5CH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Py5R202H8Jxk79hkpc66v1zX4ypoBo96R++qHSZO0xq75JDcJfwlZVQasX/o?=
 =?us-ascii?Q?xSAw2tfW6535QGtzFxsvbadao77bC76/b2AWmmt0EUGsqzTvqW4HhssNuiHA?=
 =?us-ascii?Q?fNFOEykUrhP8B3JCLSEhGPEUiFXjaps6knSqu1HbvELQRYjFDbxlmcyeRQjp?=
 =?us-ascii?Q?23bTuxNkJBk8Pzi1nCkjvLqehwBlwY2EhzRvyU+mH5zaoJ/wzSo2PwmWx9pk?=
 =?us-ascii?Q?89OuE9kUd0IWJsvwXPQcSzf4i14TCIa/i7DLEvAYfv9wuGbC2ia3CEO/wdbk?=
 =?us-ascii?Q?8t7VKbJoYIVw0uZfSR3LfI3fTSO0vk7d5kl7lUEFg3NwDDRyCjRS7Q18hf9j?=
 =?us-ascii?Q?pbzNI++BJCPRZgCczV0KU1MSoQE09UwYQ6oa6SjsNG59w+Q5ZH96SM+RtRNv?=
 =?us-ascii?Q?gI+Z7KILuhuWrwGo+ldfjgR1tN2P8PAJkmKcLucgaWmMgJb4FkqpR4kl7M2N?=
 =?us-ascii?Q?Mzgi6ISvMVd+OfOYJsAYGseiuBGutdUY2h+iZ+6KXQDwU8pIoqxuy4t1If0w?=
 =?us-ascii?Q?AYM8ZmC8eBhDDsoPsoS44SLB43o1drXWv2vz5xTMiQaNZrPng/usE3X7qJzl?=
 =?us-ascii?Q?jx5SCF+TXYjXXxjQJJHVZ8gRhtJ+a8HBlYXOVGEjLX3oYmWDj4xpTuLzsE0Z?=
 =?us-ascii?Q?vRlVyTJo4L2lZFpl/v/iD63R/blO90nwx7EVQj4cZZoi3KfVHDSATm+1PCAW?=
 =?us-ascii?Q?Dbg1cqtP26RUay+6yaYK95xTj86xe0GBijxhzDWZKuJQQ3oPeIgsP2QzeLmg?=
 =?us-ascii?Q?oFmNoc7SxMtQ07oym04GnPqT5KCza6NxaKzAOENhNRaOdm4nvv8KkB8nLBrP?=
 =?us-ascii?Q?/e3a1DTMG8I+JGf1Ohh6ZglTfa5txR6uVCSdSD1qeo8pZraeNCNUJi+esb+I?=
 =?us-ascii?Q?AwlHt2Qrltib0E9KKac6Z1BBoemVviobTGmfzA2bliWwcYe1ySkOMagP6h+4?=
 =?us-ascii?Q?WgU3GwGkC2sZqZ4pIs0vC+biQSZowei2i2ubDrRTE1w3G2iuHirLxddJ30lj?=
 =?us-ascii?Q?lUqqF8iEsxKM+QU5PDc8RcytLhIDdTvazM6v9vuF+BzEbUMD0s8xQ59isxdO?=
 =?us-ascii?Q?Ej339G/mRLrw7WMdr4+4+bpNGHVLzjpbRoDB/FxjiN9VinS1U16U9XoprrIN?=
 =?us-ascii?Q?QzPr3pyN9X5TusUvyP0PwrQg8aUWXyEsFIzhTvsDcKLr6ySD50Tm0ZnP3HlG?=
 =?us-ascii?Q?ppqlSdbkMmHqrrgeJ/gWR5TLGJSOFYM4kDdWeLmkHwmgyQ+tH67cr4hNENVH?=
 =?us-ascii?Q?nTeEhNGYmU0FwaoYUccnQ+2rkyC4s1owv5bE79OI+iOvxocoCpSk37sSZwoY?=
 =?us-ascii?Q?QsfHBu4CkpbMJmNdBhBlrM/PHwwkKWkNbO2Uj4nFKGE+dmEa5vxuQQ5HEmF9?=
 =?us-ascii?Q?pMuQVUxOCuxWS4fV1b4eEcTz0rp7GwWF5CkXaxOgDltPanIs8+88h0KY1zX8?=
 =?us-ascii?Q?Fk4y+s+1Pv/yRVohSgNwGrfeeaO8n0p5HdBgJpXfnpU8gEF9XrFSGNOZWzfp?=
 =?us-ascii?Q?ZEtN+KiVSk7+Vlv55C9Xl7NNWilsV7hUSRwDNcfflJLUQ44fIScsUNWlwj6/?=
 =?us-ascii?Q?ihzwmcABd2bNsu3e+5FsaxMCkMZhDeFZYcFROP5KsU23DEugZLqx5w3byaKJ?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481f3519-4610-427b-0f9e-08de2bfa840e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:29.1626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa1NGhP6BfzAwyIrgbydW9BZeS3lPtvUHzmUI7yrTIj7zRUiF3Jrq2413V1jX4NKhMHJK9e7nUOXTrIKkOZIECVuXYIAz6XsRDdHy8PwwM8=
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

Allow random MAC address assigned for ethernet initialization in CycloneV

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_cyclone5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 4a6f9b336cb..2bec82b0625 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -66,6 +66,8 @@ CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MII=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_RESET=y
 CONFIG_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_DESIGNWARE_SPI=y
-- 
2.43.7

