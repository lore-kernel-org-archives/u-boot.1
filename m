Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671EED3B7E2
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FE483BD2;
	Tue,  9 Dec 2025 03:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WqUfwDYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E6683BF1; Tue,  9 Dec 2025 03:20:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF9C83B7E
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8I/bcHh2HGozh6m9YSp6fDM4fHv2hFgZNmK7JjHajsG0mfWUAUscj59szLnN77bgGjIpp2cexNXf/MWNHYa15es1O3vIIDN/RDvLk5y/GMiYYwSDmQNEVXjO5/kZqL7jcAHNBzofTSdwFBowEzKjsPpqdpIqtRgAzS3Bf/3cUwKh0y4ZM/iANGVHfbEtAp/YT4IzqRnYUIHrHikRsls6R90QwTZSmgpAdbgsXHdI7jIV7SjPqAFFzYVzHQx1O01DEWMXQYbxWUxXhdLSo//GkZCD1ESpvv5NNuu7sZO8HfbKrRRa+Yn5iOiI0c+ytojcRiCCEZKcfpqFB9lnZHNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5AEnOogsp2FymPRWtnQL9sVjhbS0cGnNgskF+sV8DU=;
 b=gTqszTP1R0Ktg+vLc+c8H+Hfyw50DPUXPzWj45wNV0Q4spZBfXdyDLzl15rKd2fo3TTYEsU0jUE02QGY3u6ZhNIXT7jYwuZV5HU3eHBOcmJ+7VPLUjhaGUEqdZ+KT5tFUO+NMsWUB1KkCj4Tl82m4VcpKoypmEbXuO4NhcsfKp9z0ezEyIfJht++kmvXn8ZPAN8+kbe/+dmwp9JQAKgrleH6v7rFTZBL/WEONPbc22iAQNWuAba5RhK7lPhoChSU4EvD2dmAs1d/XCxmzJOXwauCYHcyCdnZDaNw4538lk4e5YMs1XR2Ef3RVfeTR2ZTbw00kTy9b+Z0zWDPZlQDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5AEnOogsp2FymPRWtnQL9sVjhbS0cGnNgskF+sV8DU=;
 b=WqUfwDYqxQ0VvBe2Zel7AvXn2JBbUr2GCTxV01M2s9eUL2t8ZcADsgSMkOUTmjEE7nvMf7FmbqWKhkJ4Ex1KjC4ilaD0Wgat3NhqMXLxpMLKcK2DFJoJQRbOEGTGZjF0K9SCLR5wNBJgnNaYA++eIxbqmAWc6Qo1FVKlcVFwu9TfmuUngvu3N4i1M8FJhrZaPZoUq3UK41C61/XkTL0ct1WkuK/w+b6jlMnQOtQlGRARz8bW1Fijora2TA1gWHWKUK9s/ekrsjqgJ1T+KVGg9Mg2ff5tnDEb9riw1CSUsoQV5ZISk3hTKhHZF+zv9tmxcdVwzpZTjZgJ3i2YmufIZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 02:20:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:20:31 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:19:18 +0800
Subject: [PATCH v3 2/3] imx8ulp_evk: Move environment variables to .env
 file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-imx8ulp-v1-2-c58c22834737@nxp.com>
References: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB9PR04MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc6eb97-19ec-478c-4322-08de36c9869a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHk1VzhJRTFIZlhxWURHQXJ6TmhQbFVsQ3ByaE4reEVJQ1pIYTBUbVRyZmU2?=
 =?utf-8?B?dlROQjgxU1NjYmdpQXp0NUIrM3hjdzVlUnhZSFJJMG5CTkdSdXU2eVd0dU5S?=
 =?utf-8?B?T3c1Y0dESWhSSG5jRlptcFRYNm9MajBIU1hadUZidnJncTlIbHpreUk2VW4r?=
 =?utf-8?B?VFNVbzhuRmRmOFFST1ByVnh0MlpqSW9uS0Vmb0V0ZCthOEhkelRxWEcrZGFj?=
 =?utf-8?B?WHNhc3B2YmZIS0hNOXJWTVRGM3ppc0pEak9ncmhSeFJrVTNwR3BCV3hvbFpY?=
 =?utf-8?B?cVcxTnp2bXpMdFhVMHFiaWIzbTZBbXJBblNyNW9IR0FYWnFrRzRrY0JSYVFa?=
 =?utf-8?B?N2I4NGxJejdLdE05NmpjRUhVOWZtQ2FnWHRMNUFRZ0hvZmwyWHpmdW9sQkpY?=
 =?utf-8?B?QkhuamVZdnpSU3h5bENUcHByNGh5WmMvTWdJL3d4N2NPNFFkdFU2VmpwQXVN?=
 =?utf-8?B?UDFwbGlZMUpRU3NoNlV1L3ZWNTdSb3lnL3ZJay96OGlaem1UMWUxQnQ2U2l2?=
 =?utf-8?B?dC9hTFFNWWsvaE9lMWhWWnZMNm9XSEZGSTFBcjU4Uzd1MWhnUHpKVUtGa3JQ?=
 =?utf-8?B?YkJ4YXZTckFub25uUTc1OGd0UzdKYVZkUnpzT04rL0xOamxIRWg5Qmc2YStr?=
 =?utf-8?B?N01aeDRCMlU3U3MwM3BCZUV1cUVjVnVxKzNQT2JKWldiSkprN2MvRDlLUXVm?=
 =?utf-8?B?YUFJeHRRVExGMkQ3RFBEQW12MzdxeHcyS0x2VnIrc1pjcVRSWko2NjZ4N2pI?=
 =?utf-8?B?M0I0ZUdxeGx0cCs1aExGN1pMUW9teVNmUjhQbFJ3RFNiSWN2MEs0c1dFbDFZ?=
 =?utf-8?B?RzMvd1Q1L3hNZnN1TnNZeVp0REhYVXJQSEowNUNyVmw3d0ZRYUs5RVV0L1Ey?=
 =?utf-8?B?YlVzM3lPS0htMmZ5dW9SZUFmL05RWVZkbW94cGVEWTVUd0Y4Ym9HcTRpY1Bt?=
 =?utf-8?B?ckRZaDB2c1EwMnAyM1IvaVZsOWlzcFhBSHRlR21YMXZhQ1hCOW4zWnY0ZTNQ?=
 =?utf-8?B?Q2d2UHMrMHQ4VFhUZXBnUzJtVmdQOUJqU0lORlp6dGE3Mnc0YVUwWjlzb3lo?=
 =?utf-8?B?UFZaZ1dwTjl5U3hGODJKYUF2R3Zjc1J5TGh2M1lrNU9CWktQR1pUVG83SUZ6?=
 =?utf-8?B?YmU0Vnhod0VaV084Q1c1NGRiNlhxNzU1VXhhNlpCeGtMbURyZ3ozaU1OQW5N?=
 =?utf-8?B?YWNHMnVmSC93b0RMSmE0d1FFTE5FT2lMbldjYlFhekowT1NtajVpenpNTE1E?=
 =?utf-8?B?YWtTY2RhdU1iWXhpT0ZOeGI0Tk4yWmZ5NU13OXlZWlVmTTJ6U2JtZ1VRaW4x?=
 =?utf-8?B?UkJuS0E3SGRzNzhMZjZ4NllFZHQ4d09PQ3R2QjBORDBJTXdYd2FzVXc5Q1BB?=
 =?utf-8?B?K2E3bU5ieW5LYjF4d3Q4dWtJQkNyUzNycm9yTmhPRWhiZ1FRTDNtSW52L0ti?=
 =?utf-8?B?bVNsT1kzSzFUS2FXZm9KSmJhNll1clJvVCtRdXhLTzZQQ0M1d3U4SVlwWVNs?=
 =?utf-8?B?c24zc3lJRGZIZzhrNFVBd2Z1V1ltajFVR2pDQWJFdGJsRXd3L3JNb2QzeHZh?=
 =?utf-8?B?akd1QWNrc1I1OEs0WlhCbHVXcjNOQlJGZDhaNk1KQUF1K0hJbTE0bkdxRGsz?=
 =?utf-8?B?OHNpdHdoYjQ3ZXRKSTlmZXRpRVVrNmI3Tnl3L2dxNGtQZVBUbE1ZUUE4bW40?=
 =?utf-8?B?NEdsT3NNdEV0WFE3VDBQc1FRL3pkL1RXZjB2UHYxWURJdXJkU1hWNEtHL3FN?=
 =?utf-8?B?cEl6UmQ0YUNPK0srU21jM1FSZVVjZ0hQVzF5RTVNcWZWQkdldGJUbHhJa2hY?=
 =?utf-8?B?WlJpYVh4VmczSVF6S01OcjBGZHFZNzZuNnlIZ1I4YVlZN1lDQzhVaVd0MnlS?=
 =?utf-8?B?NDUyR1Mrd1JGVUVDRHB6Q00vUFQ2ZU90TUVhTTFPKzZ1a2x0TU1ZTUFtS01z?=
 =?utf-8?B?ZFgxcXhYOWdqNm52dktZc2F1cXNRRjVheFZzQnowbjVVdjRxd1ovZ29Eakhi?=
 =?utf-8?B?TjR0OCtjRDdpbkRNc1BJenFSaS8rZGxORCtLMzYrNDN5YzJJeGtBVHgyeGlK?=
 =?utf-8?Q?t5QMfA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXNvdVRRSHQvSG9vZlBidUc5aWRzei9qdjVBNEtpWEhmRzhkZXJ6ZHlrTEN1?=
 =?utf-8?B?Uk96RDZxanhmSEV5blRkcmladVlsbTRIWVkvL1V4THpLaVZJM0dYb0psa2RZ?=
 =?utf-8?B?SkZXdm4yaEErQXg0OUU5Z1NOZ2JBM1Nsbm8wNDl1SDIxSXVGWFZ1NGtDZGlH?=
 =?utf-8?B?Ly9McHc3S3d0RWpINFZ0SngrQW12cmVid1Q4RzhXVElCTzFoa3Z2clJ4cEpq?=
 =?utf-8?B?Mm52ZWhyNGxzSytadGVyVzU1bzFqM3oyenFRc2ZqV1VUaEg2NnR6NmJQUFU2?=
 =?utf-8?B?M0ZHYlFLUm1WdkZwbjQxTU9oUG5VclpHODdFdUdQMXZiK3pqVFB2RVFsZ1lN?=
 =?utf-8?B?N0krNjBPd0xoL0xjVXNJMDJUbHRNQTFlZnB3ellKdy9oZmpVbTRmRHZSQmNZ?=
 =?utf-8?B?S00xczBWLzNTZ1h2NVZIY3pvUkNEZlI4Mm5HMDVaRjdqcHhjSW9lRVA4Z2lz?=
 =?utf-8?B?Q3RnOFAxcnVLOEJabCtudlczWnRBUW9vTjdEZ3JWVURwaHk5VFF4U0xCSzBa?=
 =?utf-8?B?UUN5QWpMRytIeUVEM1JLOS9xMFlkeXZTYzZTSmpNRzlyc0hpOEwrakN2N2Rm?=
 =?utf-8?B?V25jOUNueUY4NnhBNENLNzZ4alJUemVjb2pFU3Y2c2VDTTl5Lzg2NlJtS1dF?=
 =?utf-8?B?cDdtSzFUdmIzcnBYNUZyWnprRkJHWlNhZFRTQ01NN3AxSzdEbDM1UmljUGk1?=
 =?utf-8?B?TGc3RUJIS1prSEMxRGNLaFY2dDdTbkc0WHkxTnEvQ0tHKzRraXllSTlnOFFC?=
 =?utf-8?B?dnFzSUxXVGx0MGoyUHVUbkJXMVJLR3RCRTY5UE1sOU9HT0ZOUjFyMVczT2xV?=
 =?utf-8?B?NkJsRVBZTjZ2RXozUzRoajBMNlUrZ1RYTnlhMXA0b2UvTnkrQjJualhBZFBj?=
 =?utf-8?B?V2ZYQlRYejZ5WVhjZ0JXUGNRRmpqaGRlYXJERHUyMnNaY0lpZWlXMmxBNDZR?=
 =?utf-8?B?N0ovTGFMR1pBOXVYVWtRSlNvYjM2ZEtzZjU2WVN5WlZ0WDRRUC80MmQ5REZ1?=
 =?utf-8?B?RUF4TnFyalRIelc5eE9NWktpMENLNkIwR3Z6ZHo0TU5SMjEzd0NzdE8rK0FP?=
 =?utf-8?B?UHMyRGpGNXBPeEhOVEhmQkUyT2R6WEN5K3E4ZERvc1BSZHN4Z3g5QTN0OW1q?=
 =?utf-8?B?cFl6djFPcjhTZW1oc25uTm5Qd1ZPek91d0dnMy9ZZXJoUk96WXZaU2JNcTg0?=
 =?utf-8?B?Y3A5VXY2Tml2b0pkSVZBOTY0VG04QUZmZ00vKzF2NjluZ21UalJQMXBMcHgx?=
 =?utf-8?B?NjhvazExZUlhdjJMKzl2dDlDc1cyMFlZTUZxaUhiTHVEdUxveVkwQ2E0YTVN?=
 =?utf-8?B?ekloNW93NWxwNjQrdXdLZjJmbFBaWFlzbThJMERFZlo2azltdG1SNzdPQUVG?=
 =?utf-8?B?YUNnTVo1YVpvdHVCbWJFRlIwWmcyRFQvcnl2RkFmSlhLejIvaFRYZWJ4b3Jw?=
 =?utf-8?B?N3RPQlVzRzZHUWdqWTZyaEhIb2VpQ3ZmTEtRd3RRMDQ5L016TDVxd0lDNVlj?=
 =?utf-8?B?OG54b0tkVmE0SVJURlJua2haMEpzejBKaXhhc2xiZFpReWxqc01TbW1TKyts?=
 =?utf-8?B?VkwzZGI4UGs5anhVZElBbWdEUlBMdHN0QmNqT2plL0lDbmpocmpjZlE2VENU?=
 =?utf-8?B?a2JZOEpVT1Q2akdQN2pGcXg1VVF4YzhrTmpSMFVkSWNnRFJWT0prVWV4OGhO?=
 =?utf-8?B?RUVlZTlocm1ZWTRlcWl6YmhWMnVxK3I2MmVXbUFGbm8zNXFMQXk1anlDR1py?=
 =?utf-8?B?VXBIVUxpb1lpN0R5NHh0bXZKVkdzRVV4SitDOUlNREdPSWk5aXhjTmpoQ3E2?=
 =?utf-8?B?R1NwYVBXRGxZRGxIaldyUEp2Ri9DK0ZTRlVZaTFXS2FOLzlNRkZmMFAwV2xj?=
 =?utf-8?B?QTVpSlF5YW5FT1NMa1hYQ3hMQmtkUHJYeG5rOGt6TGpMblFMbFRXYm5GUEZk?=
 =?utf-8?B?azZEK1JvRUg1QTFCeThIenBFSk8vNExxZE9QT09IK1dkOXB1Y2lnOWdCdEZ0?=
 =?utf-8?B?NlJtVHFRcDRicDR4Q05tREVEWVZOMTBNRWtGZ1VXczRyaDMzTWdCZDJQTlNp?=
 =?utf-8?B?Y002UVhoelNJRWRMbzlDVDNXb092VnpDM284VmJyYUc4QXFEbHBROWZMRFF6?=
 =?utf-8?Q?CDSxU5V+vRQ/J1Gsojo5NQO78?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc6eb97-19ec-478c-4322-08de36c9869a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:20:30.9714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYrbv7c+7L1EwfPxPo9a4zu70L3yKNcgyjpwXldoGp8iEkqv2eU1u1FIFveGdCnUnRDWQMDtyVeeHtpyyL0lBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331
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

From: Alice Guo <alice.guo@nxp.com>

Add board-specific environment variables to imx8ulp_evk.env for better
maintainability. Define bsp_bootcmd in the environment to resolve the
runtime error: "bsp_bootcmd" not defined.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 board/freescale/imx8ulp_evk/imx8ulp_evk.env | 97 +++++++++++++++++++++++++++++
 configs/imx8ulp_evk_defconfig               |  2 +-
 include/configs/imx8ulp_evk.h               | 14 -----
 3 files changed, 98 insertions(+), 15 deletions(-)

diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.env b/board/freescale/imx8ulp_evk/imx8ulp_evk.env
new file mode 100644
index 00000000000..52d7f447029
--- /dev/null
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.env
@@ -0,0 +1,97 @@
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
+sec_boot=no
+#endif
+
+jh_clk=
+jh_mmcboot=setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused mem=896MB; run loadimage; \
+	   run mmcboot
+jh_netboot=setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused mem=896MB; run netboot
+
+initrd_addr=0x83800000
+scriptaddr=0x83500000
+splashimage=0x90000000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+fdtoverlay_addr_r=0x83040000
+fdt_addr_r=0x83000000
+fdt_addr=0x83000000
+cntr_addr=0x98000000
+emmc_dev=0
+sd_dev=2
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+image=Image
+cntr_file=os_cntr_signed.bin
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+console=ttyLP1,115200 earlycon
+bootm_size=0x10000000
+boot_fit=no
+mmcroot=/dev/mmcblk0p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} console=${console} root=${mmcroot}
+netargs=setenv bootargs ${jh_clk} console=${console}
+        root=/dev/nfs
+        ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+bootscript=echo Running bootscript from mmc ...; source
+auth_os=booti ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r}
+mmcboot=echo Booting from mmc ...;
+        run mmcargs;
+        if test ${sec_boot} = yes; then
+                run auth_os;
+        else
+            if test ${boot_fit} = yes || test ${boot_fit} = try; then
+                bootm ${loadaddr};
+            else
+                if run loadfdt loadimage; then
+                    run boot_os;
+                else
+                    echo WARN: Cannot load the fdt and image;
+                fi;
+            fi;
+        fi;
+netboot=echo Booting from net ...;
+        run netargs;
+        if test ${ip_dyn} = yes; then
+            setenv get_cmd dhcp;
+        else
+            setenv get_cmd tftp;
+        fi;
+        if test ${sec_boot} = yes; then
+            ${get_cmd} ${cntr_addr} ${cntr_file};
+            run auth_os;
+        else
+            ${get_cmd} ${loadaddr} ${image};
+            if test ${boot_fit} = yes || test ${boot_fit} = try; then
+                bootm ${loadaddr};
+            else
+                if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+                    run boot_os;
+                else
+                    echo WARN: Cannot load the DT;
+                fi;
+            fi;
+        fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+            mmc dev ${mmcdev}; if mmc rescan; then
+            if run loadbootscript; then
+                run bootscript;
+            else
+                if test ${sec_boot} = yes; then
+                    if run loadcntr; then
+                        run mmcboot;
+                    else run netboot;
+                    fi;
+                else
+                    if run loadimage; then
+                        run mmcboot;
+                    else run netboot;
+                    fi;
+                fi;
+            fi;
+        fi;
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index 8617cf32f2b..baca0b41099 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -29,7 +29,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=0
 CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk"
+CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index eb006c5d4a5..edfd6f70815 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -21,20 +21,6 @@
 #define CFG_FEC_MXC_PHYADDR		1
 #endif
 
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttyLP1,115200 earlycon\0" \
-	"fdt_addr_r=0x83000000\0"			\
-	"boot_fit=no\0" \
-	"fdtfile=imx8ulp-evk.dtb\0" \
-	"initrd_addr=0x83800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk2p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x80000000

-- 
2.43.0

