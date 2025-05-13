Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA2AC3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 978CF82A8C;
	Tue, 13 May 2025 10:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KGljIKr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48178294C; Tue, 13 May 2025 10:40:47 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89B08091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/QZyGBlKpU7D+tebEkvuwPOYh3oeeap77xpRpRIPYvwXA4bCe0P+aXwLU5+WZrt/fpKBjwVN8s8Ks5DxZm6oHDIMiFNzaIgXTsL3X2nqmYanLjWmw8tBCOupWwLJdm9XCDdrejL15s4IoYa4m+1bLOod24cWNM+Qhhp4q7+MUGhC/BjPA6CYRNlVirjaT0cWE4jfiY6DJs2J0qpo45hngQLaqCN+2tQ6gAp+nJ+ZbNJEsVu9nqtfpN+yTEhC+NyRWfyrClt6ncN1OvcrguKPsbcJErMn4aRSt7+kXXRgPUBPV5NHIb4q/CkD0nfHPlS4aOwZpFLie8dYRBDHNGElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf9GyJ+XvL77JecwSL5dhWpfCIBZpeH5NXm6anH9nh0=;
 b=w39xm5nEznY27Roq9U6oQS3JYA5yim8YMGnEG8g0OGFEE/6dicTa5/k+NOXbSeKXL8SRGo1PBApauk3m+svFexnZP+3GUnboQDSpGzYn5pMX1IoYSi15ZHsSrq+vOpepLn/hIFMUCMPBqQJf4LE+120qpyvTFjLzD859D/RPh29hvOM5dQrINiMF8EmWLslu3Md5jWvum32yaMLWJ6Gky/5zsp+nQL9UVapcQRBepSArBx/Woww1DlJ5z+oSzurvs8kS8icqp0Z6d0YlEV27zfqlU4ByEndCO1vNNmu73BGmsSeia+jOmuLfs76mujtXpKyqr7ySWi6KhXeeAz+u5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf9GyJ+XvL77JecwSL5dhWpfCIBZpeH5NXm6anH9nh0=;
 b=KGljIKr44TL1IWP55tUHUwtRUoDiWjOnTVwqvVVJHPhleK7RqUPxpm7O1N0Zcnt0cfZjqjDnSitHW1YO+wKM6wVUz/a3Jr3mT3Xynh6JykRUCGA11MBeRuyEuAxJJP93c6aOrX77s9e6HWU5m11YrIo3uz3h1tTnfJXqfqiTlFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:44 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:44 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 05/12] test: slre: add more test cases
Date: Tue, 13 May 2025 10:40:27 +0200
Message-ID: <20250513084034.654865-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5154f6-6d84-4cc4-ca78-08dd91f9d998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TX1A/opXezCqFXevqmgK8eqAvrCCmOvEraP3QwbvhuRC5CX4f2ZDwIRZ3Zzz?=
 =?us-ascii?Q?5W1ib5hYHJHrHbn6aUaSGpJMI47beMucOKlDwPXXj/HIY0LUm3FV1QUXUYIG?=
 =?us-ascii?Q?yQ3+DAH6UnyAQHRJjF6i3TidcU+QU0xe96fK0WLiYgMo6VdRpraIRKDOkQx8?=
 =?us-ascii?Q?xJfRxT0QQBMCORUKir7Q3s76rYRTDmfdtlt4R/EbNVIep7oqvBLcfU0sRF9E?=
 =?us-ascii?Q?q3LQICB/btNXRdQZK+cgyyZH2kWr02p19ZzB8Our58MXFtX7Wv0yRqk6crCZ?=
 =?us-ascii?Q?n3ddinGvDogQgd4ZwKdd22SJdXtRY7Vu25FPhaFcVYoZDBX8CCHFerfo+Pa/?=
 =?us-ascii?Q?wl9hRdAk4/k9Lro2H44WMdcD8kg4mFsdUaktZe8+sQFSw+9QM0CkG8XRoLO3?=
 =?us-ascii?Q?ePLKH72sDCQZC32H3I6QlJAmRHhHljVEmja83uQdDnk6by/luJ52pA0MtAPb?=
 =?us-ascii?Q?nJjE9JyqcDPtAZZ4KXMFiqDo/z70vf7OiCulMwY+FPCVbFVuYHCWp92YW/fo?=
 =?us-ascii?Q?ny76cPNxnEkW8sNmledsyAIc+0Gl2KgPHllxUeIT6rRgW3pYUnSsx2Vi44/e?=
 =?us-ascii?Q?bKinpkMvn76zFW/TOwaIGghI9hWq6uBJbnRfaEzVbbBWkVDZcOXAKqAmv0nU?=
 =?us-ascii?Q?NO6EufiVbbhGF3Rf65tXbXjJzNWi7NueCr1hvTv0+TbGemY5ubTP0JN6RfRv?=
 =?us-ascii?Q?EdyfFKHIVub/6C70IdWwTy5AHt+0M0FuZ+oKmt72B7tCYlO8i70+dq9cjsUL?=
 =?us-ascii?Q?Z/ekZifezQq6kES+rA3qPBU9p+NEoo5buOSoMSQn3ZEBJ8cWtwf9elKDQCMN?=
 =?us-ascii?Q?YrFXDU998tD54T8DWxzk8AkeMV7hMHWU6xepBxOvoSRiRsoOld8YrwpZNy5I?=
 =?us-ascii?Q?JMYR7uoOcISLDRANpQD4qDqF+csI7+q7MM3du1yKGIT2H0F+lO/3aFQlPCBK?=
 =?us-ascii?Q?gNklcNAKPK1ViVc3b8IYnPp3QRtjSDep4hk7/SqT7Lkp/JNYE3wZEsX2PfyR?=
 =?us-ascii?Q?LNoCAZKvN/OVEVpirHfrxC8JKM5O89Xo9PmzduBWTV+sPb0ELzLr/6hlET9f?=
 =?us-ascii?Q?LzW5HUf223tvcgv+IPDykmZ1UDmCqlff1d1yZUBmFDoqlHjzSgCa5T4fqCDp?=
 =?us-ascii?Q?Kv0BElNiTeiy0WcOZzNajIDjerGV+Nf3jYkdJt8P5BsRILy81cKYcsSI15AX?=
 =?us-ascii?Q?Phe0sO8e2YM5fT3PdVvNRUxAAqBz/lssNwTpb8zRsOdYbWoAKAusbKsY+i8K?=
 =?us-ascii?Q?q4LR+czyYX1Fppim4+A+aKCz2pLNg8+e6w42K/axO85ktfUBDiRDizuRLH8J?=
 =?us-ascii?Q?3RyKabEG5Zeab8txMtJ08xA2tBnHVeeumW6/gdEVVXXR7WxFX/pbWAUM9Pvy?=
 =?us-ascii?Q?8nRWq6h3kSXYizq9zLtXlp6ITRhc7DJ8ZppFUb9g/ZHPYmTIHtCLmXkLqKlZ?=
 =?us-ascii?Q?TAyquzS89T5oP8z5/LQnAgic7IwB5Ia9/QzbgT7uqL7D6wbZM90vyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fgLxi7HVC8yIRbph09Y395CScmpcnkr88fhnjiA+eKU0cZqKTDMw7TTSGRRy?=
 =?us-ascii?Q?BwS4CU3lxg6USUmpKZYtKXTXG/YLnkoqT3DrojZRuJ724aLh1c+Yf9PqAXOv?=
 =?us-ascii?Q?muEoUA311IGfIisu1haCEc6Iq2BN0KfMCySxg9cqYo8Oscgxurmz8Ew7idxd?=
 =?us-ascii?Q?hz9svEToAsorwsEq3oam88g/X2toZ67seY0QvWvmB2QObylkaP9ggpkVd0pD?=
 =?us-ascii?Q?HrvFfS4HXQoFB9wHOU7K52Yg+1wrEvPV/QxzpZu2UTptDBzcvhmf82WEPG5/?=
 =?us-ascii?Q?PnEHnw8y19F/5YW6Juv31p5Ppl5wsTr24/2+Df6VaKGDKlDk2/gzKKTx9GjA?=
 =?us-ascii?Q?b82bXLq2Y/3dyrR6XLtXqFhtQT4ThYjyT7cRF+7BlqrUFMtiPmvKfTFA8iqO?=
 =?us-ascii?Q?Ti3OGYShLcbdxBdsWWZZ5P4wAd1LAnUVvMfOOTdVJ1nM58MqMV/PqeZguLgZ?=
 =?us-ascii?Q?vgewIkuWkC6UyTAFNsq1arF9MOT2vXJLpAg7x7umKFEi3BWVtYY+4bUXn5ze?=
 =?us-ascii?Q?OeUglz7hZbdJ2RLwfrgcn4zMvNGbGmEWz58T85ARtmto1jqtmYMcIhbLa9lT?=
 =?us-ascii?Q?XFfQD04t49SCVCQvRHQWtoRNYUEj6NDOoAEV6wQ66Z78M1GJYdztZxZjgh81?=
 =?us-ascii?Q?laFSWntOlId+/wc2EDwHFzm/wgKsySwXKKwOh6dJ7fL14XTfXimctsm2YHKP?=
 =?us-ascii?Q?B3pddKO2Lzw9vpKjIfSKZJ90zC8Vhh5wSHkL4iO2RvPGK1Rt6/a3VMXFGhvj?=
 =?us-ascii?Q?NGZRvJr/QO8Q0QqJ5PFYsDK9Tc+8OaY2Cz7Td2uwzkSpfLdn1MHXB6wgJ47s?=
 =?us-ascii?Q?qj7UGJ+t43zlPAKUGC8wRDJa+q6EiRl7Hi+lxxeZ2/iMxUg8SKCdTnqXmbg8?=
 =?us-ascii?Q?nSZnATmF7yYyljDe2YR4IC1EqLy480tqjtSIh6bfPsPiOE5xRB90aw0XutkX?=
 =?us-ascii?Q?QZHv+uTrHQiTzdkDOG1U6Jw20GY44Vf8G1j6KhbZRjeuLeN46gJ4WWOdJHez?=
 =?us-ascii?Q?sOkZNGKmrWwJdwhyK/8dSXVg1DQq3V8at9TCCTu1K7118J1YlDCK3PvIlu6k?=
 =?us-ascii?Q?omb+Bwj4WO0cpTfXWVrVZEka8dU+DTRcYgqEE3UOP7Z3gqyS7v8yK//UUmIr?=
 =?us-ascii?Q?n0gxIT1lI5E3LZUoNVoxzNHzUdV6QKPcPYsIBaQ+jr9lpdSM1wWTKtWM2R4H?=
 =?us-ascii?Q?SN3W3fo/Nl55rtwKdeCuqeDv1oxzArHb9KQmNx8WCFUD3QZOurpZXeo2wJH3?=
 =?us-ascii?Q?+O5NeAGpQCpW1+4CUftfkGUwvrkvMPsoFlXH8vh2a/eV+Ztq9TAxmCPXyiHl?=
 =?us-ascii?Q?jqjZbHcXmnHoR1HKafoH+kP8Ocy/ASTrjfmtO1uIRbC2OhSTpqrnM7gzLVu9?=
 =?us-ascii?Q?Wcb2mBB9ifiyVhGrHBIggfM8YpjQ/OcZmHG699r8E9ONBAOS8L7bUOd1TSf0?=
 =?us-ascii?Q?hd3HonZePdXv7eDjnTZaXt4CpQrZgrvQu1Wo8l8S3X7uzl4XeExXaisPRSPu?=
 =?us-ascii?Q?uYZXrigQCKZYLF2tSdBhm917CMI3BiK4SmeGsgCjga6/RSZ6xjTX42HMR1/9?=
 =?us-ascii?Q?hvTz8zID/giyDj0bJErr3ZO/a3yAZBgS0bNP7TKsNkU9HQc3pvao+QhCKIEP?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5154f6-6d84-4cc4-ca78-08dd91f9d998
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:44.1261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqhulPPvyMnW6qhDrKVczkmw3XJOfXvSXZgaXOYLi5MBYcTY1wZk9SXWP3UEQEoYXmRYKb5AdmCud40NyfetnSEqkKKOuZ2k1okjKX1E7PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

Add some tests for the "drop wrong anchored optimization". Without
the previous commit, the first, fifth and seventh of these would fail,
i.e. those:

	{ "xby", "^a|b", 1},
	{ "", "x*$", 1},
	{ "yy", "x*$", 1},

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index 51a50b269aa..b76d33475dd 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -15,6 +15,14 @@ static const struct re_test re_test[] = {
 	{ "x23", "^\\d+$", 0},
 	{ "banana", "^([bn]a)*$", 1},
 	{ "panama", "^([bn]a)*$", 0},
+	{ "xby", "^a|b", 1},
+	{ "xby", "b|^a", 1},
+	{ "xby", "b|c$", 1},
+	{ "xby", "c$|b", 1},
+	{ "", "x*$", 1},
+	{ "", "^x*$", 1},
+	{ "yy", "x*$", 1},
+	{ "yy", "^x*$", 0},
 	{}
 };
 
-- 
2.49.0

