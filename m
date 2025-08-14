Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4DECA0ED1
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 04:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758DF838F8;
	Thu, 14 Aug 2025 06:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="f0rcMxKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B9F6837B6; Thu, 14 Aug 2025 05:18:21 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D18283816
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 05:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRUiZM6UTU7B7pF1osYaDqqtvS6JfKGfkBD3E5U/eOHUc9BZ/wkxSrfACCJMuOad4dT2dnNv67nqYVq9fGdkEio/STTJ/Mol41dNKr2o8g12hHScOP26gT6gNFF2LBlttXwzj8J9zaRTqACHteqNgR06qet3BCTIevMEemj31PsVP8heGNIHbQ7VGi+8AcdocejsZiNhzKSztlehKV9I5z2Hvy1SPIN4G39FctdPQWqUYQzHvczLxFQAhS+IZuwEV0ZtYGtIkDt0wRWK8Cac3Nyl/mI5JlGkR2VgEtTCtQCuJmVYnwqe9AJr1zCAwyFBubDwvWjQ+6ogH3CBUhkVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RUEq838nbLgsO1Z2AraewFJ24J75fiHRnB6//C+ViI=;
 b=nXJcQbOEtF5E1JRFiLysEDW+98ikz9zMlBLezRGvep16gnJnJSaOu1pvPGK8qCOb26gFo4uxnJrvJHxYHGJvksgPWltrc3wSKu9gJSRqL78iXm/MUEHqG253MlNrjiZVodbLqtg6NVKiyDcqtDP2YRqbAy0vxOe+us6OYEa8FzRTN0U0qVwhOUgvnH1jlD7Q6K2oq9/SXIx4a6xIswTsy36TnU/opRHfMwuTP5UHP+ynOnSrPbOebjO7iIosN8IVUjSNxRqMb7mxKpeN7RM5axWNXmJaWbnthMEzILtEW9asgQwXSag8LFuBUsAyf3KxJ3eWQEfgix0dwPIwydJ4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RUEq838nbLgsO1Z2AraewFJ24J75fiHRnB6//C+ViI=;
 b=f0rcMxKVuFEJHAKhX8kuepeSuz4NiLuuDItj5TMRHGFBxS64WFXRuTcxDkmUvX8+9Tnq6YRZCJRZgojyqCdcSyqOqKHLxuLrQzdmlqRyRQuoQjKY/9fF70DlP3u6KjbnLoW9NnXbc2jB2Y9P3Qu9AT2QV3e3X1B6ZRKdtyHh83CKUA+75p+QebILYA4AW2Sn0TsycupeR1sOU4R7Mp+Oyt/cRmGxLtC6SlR5Vccm/UBXIy9YS8hyFH7gUrq9uHza7CQXnzaOPwlC/3E0iHLj2E7lEJeFdK4guTLrp/94AXhJaPsHG5wtQgLfMXqmanNze1D1LF490TAXJoqRhf9T4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA0PR03MB5580.namprd03.prod.outlook.com (2603:10b6:806:b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 03:18:16 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9031.008; Thu, 14 Aug 2025
 03:18:16 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v2 3/3] configs: agilex5: Enable config SPL_SYS_DCACHE_OFF
Date: Thu, 14 Aug 2025 11:17:41 +0800
Message-Id: <20250814031741.4887-4-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250814031741.4887-1-boon.khai.ng@altera.com>
References: <20250814031741.4887-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA0PR03MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a87bc7-7f27-487a-5243-08dddae135e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ljsSdmpYDr1LrN9ubHJyF72IuBRpiHGy0adEhP16Xt1ZcQbX8CvPvDdMG2KC?=
 =?us-ascii?Q?3BAWqmtfxReTwl7b3cVBlsYYKQrvoYnT07LiMvaM+H2eQcipa7qfOWAOjeKf?=
 =?us-ascii?Q?PFV3zgl1qV1MgPzITwfFcVOjR1RJ2BG31QwGGxrb/HN/N/f671mEQmKA9ZYM?=
 =?us-ascii?Q?txJ1ip8LVCnvJ/404LqqcGPO893ralQaPS0JHBfgsn8LRsG+fnKkDiinrtKm?=
 =?us-ascii?Q?fe/RHCMvXL1mp0gGm2ZITKP5Se22adyq9Om2V2+j+8Dg4EbolPnrfmsoE1Bt?=
 =?us-ascii?Q?KZs4ERbfTm2l45CgxnR1+z77kZ1hDxKSw+9aazWoWYNvQG+64Dgfrjcu44uk?=
 =?us-ascii?Q?VY8IOlyFGojeqM6PpM3D/kSLfPaVgTgkUtFBX5bDZD/3+ltIcRSVGtLOU/Ql?=
 =?us-ascii?Q?RMwB5dHZ2Xmg1kHdPmFWP8EYH2NFu4K60LIrruf6ju3cH6UZTSOG/3vQuYbM?=
 =?us-ascii?Q?cuakenr/UkkgQ9AWM9i3t5mECzIjH0atSnTK9VQ/6DCg7Ex13ixGWjSaQ41h?=
 =?us-ascii?Q?/nP3yJOsGkLetV3dHaWE7Go+g73kv27Jid6rKcAtcyuOR08urWrU4UfZ4unh?=
 =?us-ascii?Q?wQEqh65+ng9OZ//q6BytMb4pz2Z8RHfC56Igs7xI53ZGyUxOOvYmFyJLf+LE?=
 =?us-ascii?Q?5wtGgV5H7YKQ7YAuQ6pyv8zaOnr/BaWFftsipAPpP3wdCbs1GcoLzCesb5of?=
 =?us-ascii?Q?y+AiIUPaYHZvq8xbn45ZKRywkYXtCmDhb2KRQIWb8tGZnnHpK4qyw8pp7yxo?=
 =?us-ascii?Q?6lPJE5esBOW0ubOJqkAiQsP+39mWN/he+JPlPUcM8Rd+YhAOEwqTF+VqrW4P?=
 =?us-ascii?Q?CDD57t6VLx3B5YsLaH7ajAXEraXEh8WabDt8L68xEbYZt1Lf3PlT4fY0mfzL?=
 =?us-ascii?Q?gJNqsFNmoSu7SPxlF9CI2MWpsr7K/X7R6JAjHWmvWrFLFJKIRWXbIC7tjE2L?=
 =?us-ascii?Q?VBTpxYuk5ACy3X1hGaIPPJUc8QvkuVRYPhiI39pmfmmY5+i385Oq2FzJdMxQ?=
 =?us-ascii?Q?ob21/ZUwOmx2ybfQ1uxVK+0RD8pEU7Ugmj0ZFcldbsNO6sXAPrJUGrWyrcHR?=
 =?us-ascii?Q?cDfAPhz/FgzajwXHYe5fGjweqHhx8KPVVdnNfvXQVGeSEJ30TD/KEjvLNLOT?=
 =?us-ascii?Q?Y35iKa53oOn9yLRab54sfsA59Bzq1lJLqwbtXk74saICn6PDm4wVzMlKkNhU?=
 =?us-ascii?Q?nppcXLTcIDTCj/PdHjxzpQ9KFb8xCUop1i+9xlop5eY4VTVpH9mDrJ77y9jO?=
 =?us-ascii?Q?iJzzbsOnvG88plEhlocRw6TFmi6QmC574d+fRCJ2x4pTa6fIvwIFVDX5wlfu?=
 =?us-ascii?Q?V4Z+D6vjB0YtInhf/6ywDlAMj/WKlHuJ+Tr/PRQ9uyGm4N1kKK0C81gBoA32?=
 =?us-ascii?Q?aJm/iXalsYlikiDebX5eVjz3t4WucsrpjPglFy15FWYB42/xcM/+LhNRKC9f?=
 =?us-ascii?Q?jK4RnE6ymis=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMA4Qut/wIEH0fCDIefiKMp+NT6PmTCM9kOIogL6Ybc2cnicUP3OgRsxgZBI?=
 =?us-ascii?Q?F1YgOVbjW74/JhrrXZZypK+TjsJvrxqcedcxnKz94dkeFk+KOw0YE4hn0H+o?=
 =?us-ascii?Q?U5Mv0IGk9f2d4nhW3kvXUGgjPYaPK+seYRGaI206mGE+ZS75tzeoADA5QFkj?=
 =?us-ascii?Q?EQnlxkuvnxRoFPCCiAY/IjoFvRsKA8Lvy2bwLxDHSIJR6LXD4nNZhknO0CHu?=
 =?us-ascii?Q?kYzq/36+oc+9rNJ2FLCuirXG1hUlfeUcJHuYJAvv1kltnN9+2+WvSnW3ZjGq?=
 =?us-ascii?Q?T8dS2oumhdQNnPra8ooCw79XMwvBLHaEPhTgrHKdGcDyHu0eL0d2Mctxz/I+?=
 =?us-ascii?Q?Z1BZyBJRyiApctvhps9HJqL7UiP761uMLW95Zar7YhoE56vP6re94Hb0jFjE?=
 =?us-ascii?Q?UEB3AEmjuFcYKfUg/JD1Dc0HshwhPfVG2QPMk+CZfegZ+3vK0m5NRW71QM/s?=
 =?us-ascii?Q?5CHj0PypHT1EFG7LjmmFz4CD+1MFIhh8e3OXMyqcEYozsOz4KoQE6RuGcO5+?=
 =?us-ascii?Q?U/uEUuNDfEOAyoeXN65SnVKolfUFVmpSZddfgVn2vX3DjnGCSuXiubuSGb2w?=
 =?us-ascii?Q?WpLEMGHrAoM0vgKfUsAosFRXH3cBzrqUhCfkbXZ15UeBSy7BhZleh4Uj8NuC?=
 =?us-ascii?Q?F0D5eW/O9LgPFBR+svnFnIvUn6b0WDg0WlMWc8k6BPV1OqujWJcKtKrtxYGT?=
 =?us-ascii?Q?p9nZhGIrkz9HVX+MFFtKrhkoeRIyBRBaZLxSsJ8KQ2y1b8pqt518Nkp7NYSg?=
 =?us-ascii?Q?lVpM3JxVL6/lidMZGXhoaAYT73ilzb1UqEmjdwDO7s/MPHU7JvuRgVPByzYI?=
 =?us-ascii?Q?Xcii7WRBbSnbbHyesVm4zuJu6kBXdfPpNqrUr8K9p+O4rdYs4j81c/kVn/gL?=
 =?us-ascii?Q?LSrE/AfCgIYlF7U9XWZEuDW340bjxs8SmfZsZ28guNYAQ3Ou9cDxinGHDR/X?=
 =?us-ascii?Q?biGSX5JiLBII6eLFNuN8nl433poDY5S5XFbO4imc1/A91kOp1Sx6tZHp3tMZ?=
 =?us-ascii?Q?EXsqAJFz5vAQwJsctIyxjnFb6FmJWeDeqwbIsGrvXvKj2j7vjfy6jrJjt8GC?=
 =?us-ascii?Q?NbZT/eHtpV1iXwhwmeTvX4OA1p0KtN9/ZGwVHbLbcowWe71gjPSJQubu/2W3?=
 =?us-ascii?Q?BiL14uIAlcSTlBo9/cHWr0JB0+TfNXCWLS9OSrTG8AFjcL819KebNAajIpei?=
 =?us-ascii?Q?P/pqgE4ZzG+D3Ir3Sy4yqwSqNu9Uo2LH1iaWYLWbOUfYFAypiYxdOwt/wHZj?=
 =?us-ascii?Q?29LZ7prvaPi1XYJK+ZvXgfNvSbMZv2IevLYScEKvL71Swe8X7kBMbAp9I60W?=
 =?us-ascii?Q?1M9a09m6yADk0IXlxhORVgQRzT/rXnHCaDUo65dOwIvkPsdCI2vM8CTzSuU5?=
 =?us-ascii?Q?MPKLe0682PARqReKy7WVxn1ZIv7/SSQffD0vtLBf3kXwWaWTPuVJc0NLZUuv?=
 =?us-ascii?Q?irXvKx5JRlQw41zjT+QJupbe5QODLUufuGeBOlvJOcU0B1mCCOZWV8k9j0/B?=
 =?us-ascii?Q?sQf5TmTX2QwUOVh0QvYrWBjpX6sxyqgwRUJxvyvzjDkudrI+341Q/pYyvU0y?=
 =?us-ascii?Q?7+205RzOElonC2CTEM0zFZ9/m6Uf25aQvetqJThj?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a87bc7-7f27-487a-5243-08dddae135e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 03:18:16.6863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXNqlVrZwk1RxpOQwjSVRs1x3vbjDrUqkcPQlLBBAlYKLmKFDhXQAmXL+nqu8jWmTs9DBrkbJBhFIDDCnwprtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5580
X-Mailman-Approved-At: Thu, 14 Aug 2025 06:34:12 +0200
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

Add SPL_SYS_DCACHE_OFF to Agilex5 defconfig to disable data cache for SPL

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 33a6221979a..8c31dcfea11 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -45,6 +45,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xbfa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_SPL_MTD=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.35.3

