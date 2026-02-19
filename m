Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C853E9A02C
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 00:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764EA83AA9;
	Thu, 19 Feb 2026 01:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f3E7UNcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDEE83AC5; Thu, 19 Feb 2026 01:58:07 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE2F83A47
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 01:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfmP3GkySQPWnBuJo6RcW9KdrgGobYG1HccjArPG/NERrrL/6RaCTKXi8KNOyUt7z8W7sqf7znOPl9GUCw9IEwm5HTTHz+aggf1Cp/HtbFzf5RFrpQEyQCvpvPmoO8IB6cKwnx95vyvGAzRl+nejCF3NJNA35npcOoXNU1h5uBxfEECTnzeJYw9IXEqoXhe+x2QSo6X/MEdAnZaZxWoAdCsk3d7YxCLOjXW+kTXu9tjW5EHBfpNDxsckaiyWVEcA6jT5zPWurIlaJoOhfDpepTVkJhuFZw32IEiV2X0OjYlTAo9dOb7GNyYzUQ4zyHt1cxLjozgUBK6Vx8xn2Ozr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS9kddC7FJsIW4useCB/ht6zGQe4a28Rcyj7WJ11gME=;
 b=F94I6ZX/ish4DI24RuJL3fwRyc7GlVylT6ImdcqOwHbA4sT4rapNU20hwzMWXBKNuO7uCbJxMIsyv4Bw+uzGBZmRBiRMynS5PlBG0puv41Axvscovn32LBwRrsaEipB6H6CJoa3QSquw5YRLLkDOQyYj/X7JeG9q5pCrO504NKMrnT2LXWi1But30Prb6M3gGz6ZwDActGCxx7vJENSQ3vK5Tbyu4nLOKPbU7KTohYG0p69QyHJYBBBjZ2ZBlu8XNlQhtfUrcYKe8eVRWG7VgzemMfqeeht+ePv6Oqm6w7RIhYbWQFLA8glRLryYmVseZ2nleHYTE41rAdzvh7MHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS9kddC7FJsIW4useCB/ht6zGQe4a28Rcyj7WJ11gME=;
 b=f3E7UNcXMhHN+EvjGDoflupj0oI1Skh3Bz1wh32fpGYoU+NgmJDBy/2DZc0oK7XTUQccdGAfC6traco07rfaYrXSSn56j4Y6Cym2d+mkeRewzhkgg2SvWp5DxfKdCLMOPC6CwiYLBscXsL4vokp1INPF0aPdCyKVbfk+ijg3Z5k=
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 BN0PR10MB4999.namprd10.prod.outlook.com (2603:10b6:408:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 00:58:00 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::64) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 00:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 00:58:00 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 18:57:59 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 18:57:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 18:57:59 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J0vxn31280906;
 Wed, 18 Feb 2026 18:57:59 -0600
Date: Wed, 18 Feb 2026 18:57:59 -0600
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>, Jonathan Humphreys <j-humphreys@ti.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Martyn Welch <martyn.welch@collabora.com>,
 Dhruva Gole <d-gole@ti.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: ti: am64,j721*: use correct fdt if eeprom
 detection fails
Message-ID: <20260219005759.an2sqbi6danlx7xg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260203-eeprom_fdt_detection_refactor-v1-1-276eecbbe398@ti.com>
 <20260203141322.kkqgyp4jtdfomz3e@bryanbrattlof.com>
 <DG7R1O5LCYFC.1KC2KEH9FBYV4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DG7R1O5LCYFC.1KC2KEH9FBYV4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|BN0PR10MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: df2e4c0a-2c19-43b5-5440-08de6f51ed9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1dKNVpQc24zbitDR1BibFZ2dHpnWE0vLzRxWDBSb0ZtZW90TVBWM3FnRHl2?=
 =?utf-8?B?VlJqeStJcmcxK0l5N2Y2V3VsK01Qa3E5bGVuajZ3dzN4RXR1K2tUSmRSTnhG?=
 =?utf-8?B?TktRbEh1UWorS1YvVEVCSUVzRmFRSnArN0ZaS3ZMaVlremhGY2N4N1Q3dzVn?=
 =?utf-8?B?Q2YyN1cyTlc3d2xVYW9pUVVlN0luZEp0QzhkdjYySzlzaXZOa2Z5djRMMVpu?=
 =?utf-8?B?Ymo2MSs2ZHRxanNzZTViU0R4SFd5QktCcW9odDNrWnNmTHllTUNFTTJ6VXB3?=
 =?utf-8?B?WmIwVnRmSHdHUER3aUE3VCtQUWdkZWNpNGhQenVyNFNZTjlTSTBYaUI0YW5M?=
 =?utf-8?B?MFFZUStZeDc0ZFVqZkMyUWlxZ0RzRmhyTnRXeWQ3aUNRRGtaZUg4cVd6a0d6?=
 =?utf-8?B?TXN2MTUzcUlaaXdKeFlrcGgyR0pnZVlHWmFIeDkzVHA2aDBvY29TblZoLzVT?=
 =?utf-8?B?eWorVmhnL2k3QjkxOUd4SGN0NmpNY1ZLcmFyS1VwbkZVUEQ0Zlo5amZMZkcy?=
 =?utf-8?B?c3E1RkRVRUx4MHhIM0lvd0NTODlHdS83UU1HK3haQWNRTlp1NGUrcmM2OTRh?=
 =?utf-8?B?QjU2cWxHaVhEczVGMVJmYldtV2xMRU1hYWE0T2M5aElGcEE0YVNJRGtvdk1Y?=
 =?utf-8?B?VDlRTUNmaHRCWUdGNnplTkkxbFRxL1RUczFpWjFRbXNUUFVJTGR4Z3gxSUNw?=
 =?utf-8?B?RndETmpkTkljQ3R4bGpYTHdaUGpmaG5ndnZrWXRaRHN4YXVubStkSk5RWHNZ?=
 =?utf-8?B?VGp2dS9kMzZwaGN2REZySjkxSGdZM3UwemVIeVh3TWwyTG9RQnE3YmJHeElG?=
 =?utf-8?B?dXZnZTFueTZhRG9ZNXBaVDhqYjd6TUNZQ2ovclR6ZDIrTnJkSDFndStjWTQ3?=
 =?utf-8?B?alIvQ2V0T3FXRUJYdlpkb3BtVHhCMld6aTFnR205MTVzZWI1WlF1TTNwUWpB?=
 =?utf-8?B?T3RxaWtVbmcxVE5xd1ZQYVoyOWxlS25DNzVtYlkyUTlvM29GR1JiaHRqUFlp?=
 =?utf-8?B?MXJUK3A1TncraEwzVW9qNmpNOGpsRW9OQXNxUFpTNXZ3aDZaZW5kZ3RIMHBQ?=
 =?utf-8?B?L2h5YzRGdlpIMWR3V0N0WXV3aU1pdVJ3aEdoclVBSUs2L2ZVd0JhWHFrMG5o?=
 =?utf-8?B?elF0M0R1TUd2RG40UkJ2Y0dJQitGUjhsZjFJVW5GQUZpL1JWaSt5U2NqSGgr?=
 =?utf-8?B?d0hmZW9lVGgzeHdVam1LTnRWRU50a1g4eHczMTQ1SldUZ0oyRGF5QzZTYUxE?=
 =?utf-8?B?SjdveHZjWVdWVFlOUUFleEdleHo1aW1CT0c4WS9NRE1mQ2tmZlNwTmNTa0RP?=
 =?utf-8?B?MklkRFlzejE3OEhtRUNIQlBmUUtKNy9PaTJldVhzSll6QVdxWmVSMEo3cndm?=
 =?utf-8?B?TW1vbFJjcTZYV3ExR1FRemQ5L1RPaVZYNE5UQ3JqbFhzd2dSbC9VNEVvbFZk?=
 =?utf-8?B?NEwzWC9BSk9rYUNvcTliOThBSkpnd2hKQnlDVytZM1czd2hmdU1VNWdyM2Q4?=
 =?utf-8?B?dGVPYWJSMS9HWkk5dWsvekIrdFlEOG9kREViZ2VZVVNnTlZudXZ0aytkeDg4?=
 =?utf-8?B?bk9xN1lDTE5sV2NibHlmOVpGWE1wZGpkeFhuTWhwQm53RjFsMk85MnEwUmRD?=
 =?utf-8?B?SkJRdVpWWE1VekVKWEZJdWFsaHc3ODRpL0pLS1Y3bWJBSi9CWTB4elJsSkFN?=
 =?utf-8?B?dEsvTzUzUllPb2hDOEVyUnJFMDdKZE1TM0hUZmZSRXhWd3BKTk5sZ3RFZ3JD?=
 =?utf-8?B?YVVOREJlU0V5cjRlNk11SFVQMnM1aDdWZnpqOTFVQVQ1SVBOYnA3ZlhRc09K?=
 =?utf-8?B?dmVZbHBrSHl4b0Y0cEZZZ2tjMWxHbk5JcWhFcFppS3NGL1pkbnVPbU9QeVdq?=
 =?utf-8?B?YnJRUDRWMUdwUmtNdTdsM1JLVzRwUWMzbEVIYUdhZ0Y1a3YxSEJrZ0htelU4?=
 =?utf-8?B?VjlkM1lpNmZtYTlTNnVDNXlSdTB1RCtEc29lVXk3UVlWQmZHLzFEcENBMDlS?=
 =?utf-8?B?eTlmWm0xYVpSVTRkZTJKdEw2eFB0RjQxbmwrZzhQRHRDdXNvTitnM2IzQ1k1?=
 =?utf-8?B?RkFxcDJNVUY0VFA4aTF5NE1aK1JxNmxuL29DdXZ0MHJLcExGTmFZenpsdDhY?=
 =?utf-8?B?aG5QNzFXaWdtdGVDVlQxOFRFaTdva2x3RGhXSzd5MldqNnFWT1RUd3dBQlBp?=
 =?utf-8?B?c1hZb1FJV3BYOUlQWEU5YjQ5ZkdzekZGVGxnb3g1NERKbjRvZkhQRmJCOGhz?=
 =?utf-8?B?SWd1b09EWHBQM3c2aTBnaUIwR1pnPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OHe56lcssvbsVOti6ODFQ87NL1/3Y891Hax7nsquIxP1RYM/NbZTEFMtgPdMf9jNyBZ9HpYgpt1quNbjQ+4NoQFekHqVDhnzo+ZuC79qrrtv7LvgQLKws/f9J/VoqqBqiFtL4I57O6YaqfrZT1C3k+P/7Wb+GRG7ZLF7BCCF0tt+2yg2mQQe5c0MJiToevn9Ef7tFbDerLPk8jOZGbUfYHbRr19OlVMSnFqZ57FABH6VjZUtrWpZP26Zc4145ZNKztgHck3Lu9WktZW2wMabUMPmztVu28+x3a8EKOPk/lBa6V2e2Py7HDYp5ME6ntmmRnJ90VUba9bXT4behdCjYAbgSLOHADJILr1Z0GtLlCGwqMF0+l0GCeSDsrf+80ggnz06ZjlefWEdvTvAQ8RP8DvDCsaxywaZgG+akQwd29hsG3bK5oK8MiJWWY1hXBjL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 00:58:00.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2e4c0a-2c19-43b5-5440-08de6f51ed9c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4999
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

On February  6, 2026 thus sayeth Anshul Dalal:
> On Tue Feb 3, 2026 at 7:43 PM IST, Bryan Brattlof wrote:
> > On February  3, 2026 thus sayeth Anshul Dalal:
> >> We currently provide default board names for each board in their
> >> respective evm.c file. However for custom boards, this behaviour
> >> overwrites the default DT as set in the defconfig
> >> (CONFIG_DEFAULT_FDT_FILE or CONFIG_DEFAULT_DEVICE_TREE).
> >
> > Are people using the TI_I2C_BOARD_DETECT logic on their custom boards?
> 
> Users are expected to not use TI_I2C_BOARD_DETECT for custom boards but
> the correct behaviour should be to fallback to what's configured in the
> .config regardless.

Ah OK so people using our reference board's env but using their own 
custom DT. Yeah I can see how that would be useful.

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

