Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8492CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 10:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 116BD82E34;
	Thu, 23 Oct 2025 12:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VMgySBOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2951A832BC; Thu, 23 Oct 2025 12:46:20 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12511807C0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 12:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8rjbydoEmaW9zku/0JmVNpbghh1L+iD8nOQNpH6AjDm9WNlRo/xBRgyfBZ1SiM8WLfv6QJgrbwkI33B5JR00acNfXywGWc8SvoGoCZblyxjUysGMKB17Sy5OFf6pPKq9xv4zFpP8u60gPSsXIqNBCLW3YvsSpEemzII108ObyNHCslyEGT32rf6X0csBbpncpWp8N3m+f+pjoIKDqihG9pFf2GjQ53lTensEP/8JPAjBEgJs6cjFJqa4znENbU5UIRL47sfbC+53Bas4rWrhYHDu1JoR4X9OKqfy80nhgLp3yd7LO9G3g1xpOoCqcV7LuFi8Dh8gfkZ/lkkJZen3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR1zPlqk2jEe66k38rEdRrZE8MSD8dn57JD3G6kKq1Q=;
 b=QsnglpMnbQjlE/6Qi21dOs/uarj94mUYpUKqyIPCfNtPtU1Ln6FtZGKw4ufJS2cRPg5JsNuFb5TQfso5TLnOLncr30m3JFdB/X8amz8CnDmBJpt38Lr38UsFAcFhTqE1JeE7n1CkC8BW4vh4mb2tQiGguUdKOdzWNKDbZY4QRAia9iCejHpJfHc6PCthpN94zc2fdhQ26xzPUztOrav9IO4PITyMiZN3IMT4QSQBIVofBpnkqimEYuy7e1l585bwmixPwqvz01C7jCrqNpp5fz5oeSHQjTcc5p9H+q8fAeodm3FuYS3rz0azKcwOkFqN83muQGExcvEeCOaqSUfwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR1zPlqk2jEe66k38rEdRrZE8MSD8dn57JD3G6kKq1Q=;
 b=VMgySBOWy5fPOiOyjAuDVZnyPt8UEnJsH80ckShP7b9khekaJ56Uswau7bh447xHqjgD0TCT7mk8bAcaTw8BdDzUeb+knscILiYXumJgjhf+XA4eMiB3PfmOoM/pLp7F5hIbVaOc4/QiONPMl5moUfockLB8eYHSdZuC00IZ0JAESbFJZ19ky5dh0qzms9cl/1mEWkImfBgzlkUop7zipLaXxlxHPTKlCDBE+CHOtplKTL952tthIlSodipbzV9XUvbjTgcNhKqpreAt5EOsZZiI9fuOCRvwVAf7n3RDw85ym3c3wM0KiAys0rx0/T4sL9ftNFA8TEIKhlyucxjbAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH7PR03MB7062.namprd03.prod.outlook.com (2603:10b6:510:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 10:46:15 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 10:46:14 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: kauschluss@disroot.org,
	peng.fan@oss.nxp.com
Subject: Re: [PATCH 7/9] mmc: exynos_dw_mmc: add support for MMC HS200 and
 HS400 modes
Date: Thu, 23 Oct 2025 03:46:11 -0700
Message-ID: <20251023104611.2529-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH7PR03MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6f5584-13f1-40dc-b5e5-08de122162f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JZJAoTnuPVQ3NQq7jg8DINqVsTqD3qQpS7I3mDJsJCDtBe2CzzNXVV9PtijS?=
 =?us-ascii?Q?d2/s2asVq1VogzL1R5n5cRh1/7K0Z2wjzLuBQMdBe6QK4pm1rDrB6Oa7oJgy?=
 =?us-ascii?Q?C/TJ9X4yQIkJO+7asetouwytnTFQBn9fNAP1U0MS1dxB+nUoXx7FScMoQeRU?=
 =?us-ascii?Q?RSZEU3lQtnEu2uRJcBpviancok2KWMazR9gQXS/KJv9shpCV8l3J13pWILFd?=
 =?us-ascii?Q?fjeeF3q+UE+XNZRVhH8nyC+k6HtumY/m2OSWGeYIEwDHsC+6LdtMeBIavyeJ?=
 =?us-ascii?Q?cMaRBCzpQgxLL9361Wn2KjkFVIeaIhvKzObuxO9jXROERpchfe4oBT13yMzu?=
 =?us-ascii?Q?/mz3DzQ19G85pUAoA7zmO+YwhbaTNnbh30uPN/TRuGt1xXnkj6LyjAM3ZNXr?=
 =?us-ascii?Q?1LLvCUfhHtUKsVIOzNbq7NfSILV577qUKrA5kzJdbaiMoDU+XL7G0XnhceSU?=
 =?us-ascii?Q?tPTiN5iKLWn/5N53xBBLx8xB7CZg/L7YXCaAZhVRNmq3m18oR2B5RCXpIC5x?=
 =?us-ascii?Q?3xfrlFvIM6/MO8xgSFH28Bd98IZexbDoMQEYA67pXnfQW0ob8Pg9KU7BnYBB?=
 =?us-ascii?Q?9M20IQjCobGC2T1PF4N8eVZRXoKZSCp2lcQgpMq6qYZvdUDuIkkakA4s75qZ?=
 =?us-ascii?Q?Uud5HwGBfw1S9jhSaGjtL2SbOToUke5x5Xelk4E60eOzmQHNSv+YzTVNy7Wp?=
 =?us-ascii?Q?tYSjVpGYQG+KGlFe37uNFxzb2I+anQeDe7wg+BzjtJW8gG5WbaAJ9DyTRxJ2?=
 =?us-ascii?Q?yh0YgrdBFm7Z3h63S7uKSIY9JmztvfHtu92xKSV3tAzgtMqPIXd1aWFOJNBB?=
 =?us-ascii?Q?2PuCSVsXka/RLWSa/qgbVBBVzcDoRNJT9AhxbNfsz9g4JTeOygH9gHlqYftK?=
 =?us-ascii?Q?7e7RxjRujBK5clY/+9QXJSIrnyeiHmPPZhiHDdYVBzZkpQi73FXnkqoR4q1f?=
 =?us-ascii?Q?Uw3fAcdxdHhVQTMnQJkZ10jN+k+PC1MMN3HnZ7TLDgGgHq5aCr+Lm67cxMZg?=
 =?us-ascii?Q?sP8+29tuhg4JCnb4bEBw6exYTApDSMauusAB0zAXwPUopJkMw0X+C8rIqkL+?=
 =?us-ascii?Q?A5Wwfkc+yhid+br9aLFczdVmNc35lYfcGJUnAEvAIo1O3z8yKb1UYDNGLocE?=
 =?us-ascii?Q?2DnNd9MVvSztcyx8AstUszEel19yRBm9ylzFmPr69cObg/vKs0gnCSbnxqUJ?=
 =?us-ascii?Q?8fndZmBSd5+NwXcWxy7/X+0mlGbqoxg5HG3EIYjgP3ZfAo9IWFRG2KL5roYo?=
 =?us-ascii?Q?Ou7X9DXvYYkWF2sdyyjgaY3JE/mbILc9sUgspfMHFoXMUypLSvUmTMWVx7OC?=
 =?us-ascii?Q?FrdxS8UzPOf0ncdp2GS6F3yUqdFE4635TatSCpywdzh/QQt41OyhzvDyh0Ld?=
 =?us-ascii?Q?ainBSuIKEhARXcmr2QS0n9PcyCICPXsaL6l+7kiUeztAoungpSdDJRwvE3r7?=
 =?us-ascii?Q?VSFNDJJ7DNrHz2LC4/iPmM+/sK46+IL0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RmA5rddV8NlBt1WgOi7SRiCuZQQTXZA8g58R2yK4K5Xs/OEgPkO8gcY6km3t?=
 =?us-ascii?Q?ngHDi6jKwMkkwtEVZePBUWyCQweUPqk9i6ODWpV4c5RgU2/8B0R/1nxzTw50?=
 =?us-ascii?Q?BsESR2YW++ZBWy6JIVqi/bBU3IslPhMWqJm8Ixvkn4v5vSgOKWy7JYtZMYuZ?=
 =?us-ascii?Q?mhQ7FWwXI7MszxY9wPdsYkOAujDw9X7NvWTD7iod70n+/sCmSwtOafPJSRJ5?=
 =?us-ascii?Q?sVUbGyGjf3D331pt4OwCIsj1UACA5Lw4lThexzEG6ux0h6di/u5RXk7Skyng?=
 =?us-ascii?Q?Md90FEo/xjXvcslpMRSXbls433JnOBobBw+iDNDEePwr4nKW8xZ9TfbOD0sN?=
 =?us-ascii?Q?PT+/RYEhm8jSFpBpcxB8R3gIsL0Zkxson16K9pFmGtnvUtmckc7EUo4wLbK3?=
 =?us-ascii?Q?PdVthhLRcZijJDL09XzZesk/Wr4TDzOU2rlOZnYKn4FQkDch2CvFeil1uL2X?=
 =?us-ascii?Q?u2W9WqCr6g/OiDSmPE5B+/UmjS/uK6BfaDU7/QEV472TMY4m2YLYiXGjMmih?=
 =?us-ascii?Q?1lFg7O+J2pstoYUS3qUYwSR6G7ORwChwrGg5JPLYtBxM2ecgZbpBb28zJDfi?=
 =?us-ascii?Q?vUjWdADBUsZBgeJdwynDgsOsLMkKJ2rPPwWuFSZrleS1T3l+N1K7J0kqbtrS?=
 =?us-ascii?Q?x0YnQPe3HEbeweYOjVNySwIebtImOPyQS3RtTLu8AtgmKEbojwF4xaOqWEi3?=
 =?us-ascii?Q?77AoIXWw7oYfWhNL73mfV2zi0csjsULz9B5NiVPWQNPyBKrQhxCxfQzF4neh?=
 =?us-ascii?Q?fZTJ9t0QFNeA9jvrX8tRRoPkKF88L0/wIu2sdM1RVl/qLY2KafT2TRxGq/ad?=
 =?us-ascii?Q?VKPHMtY3/45Q9Oto3oUQb5QUpO0LYWMGBQx+KMxTdbmvLXkh5jn9B84fNzRI?=
 =?us-ascii?Q?zxloBYrRo63dtYZZH0ix2pK9ZZD/5LvxcFuAM/KsX4Ruy+onggUXq8LOEhYd?=
 =?us-ascii?Q?d50u0OBsLwmfhJ3mPYW0AxfYLDJw6NOqri2gM/SVEVzCoI5O8Q4jHgIQjeFi?=
 =?us-ascii?Q?tUvEPZvp3WDKfSXf5jJd9rBmDEioV6/x+FBGv1GHI6qvd8bEaMK8BSZRdBg0?=
 =?us-ascii?Q?sLkDbTCRvclWmV9/1mkKQEc9QOEM/537IN8F9qcih6n9TAYnzgw2RSV+vTUA?=
 =?us-ascii?Q?qD2DbiRhbB+/hKM742NWcb+EL7FV736/2tpcjIwwL3KDCK8vpgmtEmRAgxLO?=
 =?us-ascii?Q?mbynUr6OEAzF/AsexRwOUuesIDBrG71XIGtO2dlzyTGOh13WtZlcuSRA8maB?=
 =?us-ascii?Q?3gWek+BC0ThJK07ByZNIStnveX6PYTKUD9sP/hyzC0DFjgwnDg+RINothTUd?=
 =?us-ascii?Q?ZpvSalq3EGdWyPOaq41rwHatTr6f35WlsbZQTybnaSXAPzJdv0GUlmPhRrDZ?=
 =?us-ascii?Q?zpDfxJkxYITC2mrV6TSmShYRNxdh+uf5xBOZA7ZwG72xNbeH2yc9/z3Ht8fV?=
 =?us-ascii?Q?N0VtdDewS0NN461dGWOymA8Q/5cUyZMJW/LFUqvCt6tPHQr9w250QZJU2Zhd?=
 =?us-ascii?Q?q6rs7zqWq9EJyLtQo9OcLJbITJnnhHfj0oBhX2omrvcg2lXIY6eluaVSIeY+?=
 =?us-ascii?Q?ECydS0RANisHa6fN3tV7HUCNqrr6svQp7/n7Frkx9GdAme/LPhiV+fNDC4Bj?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6f5584-13f1-40dc-b5e5-08de122162f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 10:46:14.8923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoKoVj8HXjM0VchxLR3xJwCroiYHsFl3LHaWwQ0I/pENtzxwyFSVaYNWy+8KFUj6i/1OpWl16v61W4eVVCVes46GjWAtNk16mmuiAavJpBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7062
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

Subject: Re: [PATCH 7/9] mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes

Hi Kaustabh,

The tuning functionality should be made conditional under:

    #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)

This will ensure the code compiles cleanly on configurations where tuning
support is not enabled.

Best Regards,
Tanmay Kathpalia

