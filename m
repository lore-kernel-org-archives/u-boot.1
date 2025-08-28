Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D483CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECEA7831BB;
	Thu, 28 Aug 2025 08:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="b5Vpoo4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A048323A; Thu, 28 Aug 2025 08:24:30 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0F883106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2V6p+As3nRbji4plHpb1mCaTfcXROLSJZw9uqYr3AzpFX6AQTAWMDAM4R3gPw36N0ZYJnJ8AHYI/r8/QL5EHLsDP4OBmV6PQHoRNh72CLmN0HhBsk7FWLiZ25Dt8KFWNt5mOUzuTY+yVUkYvquJtOV6qcHZOUr5Phl1WJeDcHVucfzd6gA3uyoQxxlutve4B3xjrJJyfmZb3ckYMa51SMNRnSTOIxKibmI9l2BQI58odmbJFSsq91/AGQnkcnTcLPvnlFJeooOwk84omjV0TZ3lSRQVg556Mf4EpU/bfn2tM8GpoZN8hTyVd/kvdURyp9Jd2KG5wb7xVanHEICyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OUBGUQbTh9fUTwfD9ORByFTHFY5y0RLP9+o9HSfENs=;
 b=meKkcfpuQNA0iOk8O8is2x4V541w2+Amapn5dim4u9cBQdd9kCsbyUKDEa0baJHf5wda4nkxjftX4BRFJGb8XQ1CmHLRWvtxOh//mFJq5yMyPJWb5Je1Xf741wEpr9WLlr+Sl00/rqJ0zd/lhO9sLgl6abMo2LQR7KpU34uR52KFo951bttW5CuqomBNW71HVPrI00h9YeFxoTZbUZHzr+3sMPd8jYTuSotWR3i4fnwNAqWEM8rO4CzQ2JYN25QyDfQXMyOHE7KnH7raHjvqZE3D0/bYbdNy//a8Eqo5UfAMR7iQOYPHQpAcVU9ILVODO/vB7hF2jjogzcb+U3kDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OUBGUQbTh9fUTwfD9ORByFTHFY5y0RLP9+o9HSfENs=;
 b=b5Vpoo4Vfvu2lrFkWYjmrr1mxn0jh6bx0pA0DsWd6BRso7sWWfJVU4GAPfAfT/FUmzrBXl/F/YKFt/GSYfu2sZ5myGK6VFi1FgYOW5Z1W+us2U86GOox0vob5ee8P0PXRJxcANmd1riq2j6Gyb3foABj3kucrMR9ly9mL/AnjPrpCoT0MJpN2vXemKICx8p8fKLDl2qvB7DZyAD0BjoQnBFLHWcJuuuPhaAJD9L9lQkWQvQIYw8ewyHg+NvSuV7+cS3/Y61Jg2z0AY7YB8mxwdS6nkWXp6XOsUTCn4hyq0cRVSH3cp3ioTQRG6+TeSWMOZ6j+CejDlqhCIYJMtZAvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA2PR03MB5676.namprd03.prod.outlook.com (2603:10b6:806:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Thu, 28 Aug
 2025 06:24:25 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 06:24:25 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 0/4] Enable USB 3.1 for Agilex5 SoCFPGA
Date: Wed, 27 Aug 2025 23:24:14 -0700
Message-Id: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA2PR03MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 214d0a11-06a9-42fb-1c24-08dde5fb88a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+I+ht7ZgKWIyXEkEGnHJ7XRfT58NAGTSacf3mn6XOgLK0ZrapPBCBbttd4Pp?=
 =?us-ascii?Q?royWLK3c7gjW9TpKnrN+TSqmRusZcrMAJx73TAC00+zpBAvHxgrIJjRpZvW5?=
 =?us-ascii?Q?Ai5qBz+zbr4MrZ61MDPD9Cn1MZIEURYORT23Ir2+I9z6pXqcRwQ9SgsHR/X1?=
 =?us-ascii?Q?eaoCFm7EzSbl2KPcbsC/fEns0PpN8t6ItqD2CFRiyqwFn3vkk71ebfIRr9kv?=
 =?us-ascii?Q?gw4bS168y6XwKTO/nk16qOJr0YpH/ks+0qBdQ/LFHx2pGXv8aqXp9EdsPDJY?=
 =?us-ascii?Q?YqiDowrGwkZaIy0jNmIaBqTsPAKZH7cNN1Gqs+7UWaDCYbpCMZ0/pWskrlkx?=
 =?us-ascii?Q?lVr6+BkEtrcpns0Z3e2HHfUyqV8C0wEWfjYOO1P0j1Ra8LVG1O1dIjsgcuoM?=
 =?us-ascii?Q?OtvPwpMon6u610EZRHIf2rQjK16XFAJMCGubOfOjp28nMaMEqqS+6DcBCsMa?=
 =?us-ascii?Q?8lB29MSwHlpiB7hH7pzwv2u0Y02s2Y9DUtoVdiK9EJmz9IXessMB8x4sNx9w?=
 =?us-ascii?Q?e7U9HGsXnx7WHtw1zRKFk0bH9cNK52+UJj8theo/GnKO6/KyYVOOPuRteLzR?=
 =?us-ascii?Q?rSj5WAMoY2YSoprCiXyWOGebJpfPcZQShMhImPnpBk3HGKTHNWVeydAZE97X?=
 =?us-ascii?Q?6Bpy9CfPACJptmfCj+SmNnN2gzUbS2mUdsjFd+H0aAy2OOt7eI2pBiAQ7Wy1?=
 =?us-ascii?Q?Si4TsfQod3eXvIZTOcPSezdriISdaCgQCz5b1NWmEsnXJnxJNxSxM2+AfY/r?=
 =?us-ascii?Q?7XhTqP1nEnvIq1X0XxAKK3RQ3TjW32qtQ5yhH3KI9fnMx4sxQYVRjSU/IeBX?=
 =?us-ascii?Q?c8yqOY9RZIlQoY3Qu8xrQDq3dTQgxGcsa2hsRjTJ6fkobPGhBod8aDCmjWGq?=
 =?us-ascii?Q?Ltpnqz6Z7WKIxQxCDUgygAmalsiW/nIE9okoWcwW4bzGWwntGhnTGToKNJp/?=
 =?us-ascii?Q?CRIsdV+R5jEi8ajgSIUK9MBAyqDs0TavnT3mQ2OdkOcShmFIkuSPbRyyqXBP?=
 =?us-ascii?Q?xbRBygfL0RN3xq9Fakadg7N0umb2NyLB6kniKylYCmYaCfAhvFXkdjc/jUk7?=
 =?us-ascii?Q?cyawCAjUO9ZjaW856WaqGJfNwuaMkLjVZWxlcSFunYQ85Ud4nCq7HKdlsqOJ?=
 =?us-ascii?Q?OD97b+DDHlAnzYv9F7mCsxEgA3BH6iwzcn8M7mD/j5ORJGczM/YY1Fs/U2Q2?=
 =?us-ascii?Q?WmudiGRtkbDHe2+PLkteZtfjWZtDh+2gAW9dzl0EaOgFjiPBnL9cc+9xSet/?=
 =?us-ascii?Q?GOSWjJX4CebS/pY9LXcEpojmNIYscxO02ARVlc48UjlNzzMWVJy1xMI5WE9e?=
 =?us-ascii?Q?4PAbhtuSwB7SxjmuJJf8Hsv2Zc/WHMOBz/r0UFO8hUCJrMgAF0NVkAPr0v+A?=
 =?us-ascii?Q?L85qLEAHrF8tS8rFVrLHapkXc96VuWGox/8g/VblOMy8ouD9LW7rusmr9HlV?=
 =?us-ascii?Q?wqNwKE6+Aek=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vib+9TlFoHjmR7aEN15YoueakgkjxVcY+SUB1QD566gfmlXF0yug0Yo4v3el?=
 =?us-ascii?Q?ZvlM6gJNjrYnYdAtAB4CanfChn7wA0l/KtM8SAe0suy0Fo7N6K30hs6kZJ59?=
 =?us-ascii?Q?ZYWTTrTlR21VMMWW10c3UcNuxX+gb6QRhKbH2i923yUDF4madAOqZMaTgUPO?=
 =?us-ascii?Q?+etAFW0R3DTIL2Q9Jw1vsPT+iN6P6x8+as9WyQeAU/MSgTBE2Yx+yJtFHMhO?=
 =?us-ascii?Q?8SYXkCCospQSBr6C9yzRhfbp+neNDvWEaFmBAIF5CdFwRcJNmrqcwuLSRzc0?=
 =?us-ascii?Q?CeuJX6lpSamhp9hsKDxV+jAlW68qkUBw73OeCzx4XE0zYMcFmOnfpV6QZVB8?=
 =?us-ascii?Q?lypb2yEyXcbiCjoAffoPuhBOwbDPYX8WuPox3ij30bX/nYBtkgmQLT7TQ3Ix?=
 =?us-ascii?Q?cTPiMgROdpiqcyJs3PiFw8eDu2G/P8XjeH1U7oKiTKCpgEfl+Os9hVD6EAdn?=
 =?us-ascii?Q?ukox5b9L9UGIiemjcnb+JfHDRa+T9vq/RLo3SFzP860yxuJRk/CYoN9mfOKg?=
 =?us-ascii?Q?q/49brKUj+3S8tKK/ARqr8c0//r4IWH+AvmSxlp+XDMmDMX+IZOkefJDAJJM?=
 =?us-ascii?Q?tzKOOtxJ2TGSV/NB1RVdS4+4weQfluqlZyDbn5A9sF4DFHL9fd+v2vsDQJFD?=
 =?us-ascii?Q?bStZHDfkMM/bCPXOVnxSw5KSLy7J37owPehRA0mZymdtYQUFx/pPWi8UhZxo?=
 =?us-ascii?Q?QODbrQUiTYeU4TABP/TcB5RlZXx7M8hSYOVCBWQt1yY2srBS+G5VZrpPICb/?=
 =?us-ascii?Q?c9VF4JT0IeMJVGLgrQVBUvzPyTgvIbY/VjvGdhvK2Pp15mh46+zsYbC8ckCa?=
 =?us-ascii?Q?Rd8sZzdbtgc+bhqzBv/QQu8T2duqc8ByzYJ638gmrFcr9hfnBgs9AlY3f3/p?=
 =?us-ascii?Q?fVVoAIXQpeGg6xLZ00kq52fWQiFTK00Ln0CPhGtp7UBBAHcrwALiMi8DHV9i?=
 =?us-ascii?Q?n3dbdWk7rGXTFVmFolfa5nhol2FXPlVDUTECiEaCiJBRfPRGuxX3bLHlONNN?=
 =?us-ascii?Q?/iBCvm5hCe5dd2MzGsndDuzsVaNiBUzJvEF9au33xgHVWRzNctokSwgdYCki?=
 =?us-ascii?Q?TmMbcn5oktEx96Ji6cNvXQTdcUHMkb8q4ldfY5EgvW9DQlvEuSPGmat6A56j?=
 =?us-ascii?Q?sLY7eC3zjQ3DE6BpUdJYR/xaOFMLMPSS17mF71kCwaoFYgNy9HZlvinj/bRO?=
 =?us-ascii?Q?RZ75j3QSmKGOdQm2sycZHqud4DlT+7XL7hssDRKuH8D7gv+5Mkagom2P5eVo?=
 =?us-ascii?Q?BCuirKDDeprD0Q2jH08pEes1SPy9XTL66fx7Hx/iXS1iA/lYAm3fKDzD4VLw?=
 =?us-ascii?Q?QBtG1UO36HzWqHJa8xsT2XmF3M715hRzzJNJBSY3peSGo2XdRNon+nN8yvfk?=
 =?us-ascii?Q?tpjhtazVtWBL8i62iPF4hn1GiZcH+8qmw1BIpVBJ5nyviKRGN5KpzbRwMcwD?=
 =?us-ascii?Q?VkutFnHoiFtKoncf02lTIWdLTxJV2hpLsmjHLKOAX5lqMMx/ehuxm2EsjkUe?=
 =?us-ascii?Q?9F315MirXjPEU2toZpaHf0GsE5gMxT8X3WKy/7nHYl4cv2B20KIsD7lgKlJ1?=
 =?us-ascii?Q?Kqd/TexLXA74BImOTXXrJTlIrk5fZpMTluZBrXpydc5fqYJrlSpIubYvk6Yc?=
 =?us-ascii?Q?qSRNbwKmiDnJRRTvybReIyY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214d0a11-06a9-42fb-1c24-08dde5fb88a7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:24:25.1875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2wn61FSuCqQ6WdWuLjfSkgnByCe7qNYIhmjXEwcISJT+Ij9FilixafDEijTabvMM5sC4SjJLxZ4XBFGt/NakCMNSJ3kZhzu91BXlZxB/HhnXjU06Qg/mSYWDbKSE2yC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5676
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

Required configurations for USB 3.1 are enabled for Agilex5
boards. Testing has been successfully carried out on Agilex5
devkits.

Changes in v2:
- Addressed minor comment regarding modifying a comment

Naresh Kumar Ravulapalli (4):
  arch: arm: dts: Enable USB3.1 for Agilex5
  configs: Enable USB DWC3 host drivers for Agilex5
  configs: Increase USB Hub debounce timeout in Agilex5
  arch: arm: socfpga: Configure USB3 System Manager registers

 arch/arm/dts/socfpga_agilex5_socdk.dts        |  5 ++++
 .../include/mach/system_manager_soc64.h       | 12 +++++++++
 arch/arm/mach-socfpga/system_manager_soc64.c  | 26 ++++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  3 +++
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.35.3

