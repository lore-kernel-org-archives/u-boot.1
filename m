Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945D5CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F74883A25;
	Sat, 11 Oct 2025 20:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NRtUtz5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB4183C2B; Sat, 11 Oct 2025 11:07:04 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59B383A8D
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd6cKBV0gOrJHBxtWP7n26+YVYtwoeXCTFTtk0JGfyPmx+mNLGYGoYW/vWEZpSF5NSMnu24E9RJjYJ7HWfHZ4piU4JsCceCxYFDVfKXL5UvzIrKZbLSusvvFGkokUSbMvkUYtRcvy5XBsbaX84foTgdUYIPSegz6AcwigEWHWBvWmxdoMwydabuwgosHDENSZg8gM+vSfC4ZK5/YGhFt4ypJ5AyGwBQecAtNUXrpqCwLbGH3lChVFscRymlz6FY6qNkFJeArVfUYXs3V2xoTT44VsnKycBVc3Xt5/DLa54BeFPiPD0N2nPZnXUAskelPx+CibMpcOOkUoZTCiq5bLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJbPYy8lnKBHXY4B/aNu6tRZLnXiV6Q7vW0Y26TSNQM=;
 b=m7oVzX536z2OmryX0kbgmM6nJhijLyiFD10TJGKUzAGNlbojANR2gWrtxT+I3zM7q0mjJi/4xm7luRdGQ++S3Tz7zKr7uNiMsOFew3Z+FaGVV/lzkT21dWftszn8HiWFCqOonw1ZCIEQZCaneE0eOThiHsI+uw7a8G2QPn5jCjgS/UopeioEZE5jXA43/nvJ+dVTehoK/kkdqvMyJ6cNWTzoQWex3dc/E/omLgT7WpQIPTtxqK6KrOSEL/QjMw8C9DN7jV4kUjt/noGrX/w8XovE+8fiDHDZyqvPjonlvcKTqy/RhQwVHuCihdfQ3u7083/+GFl0SD628As6CCYJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJbPYy8lnKBHXY4B/aNu6tRZLnXiV6Q7vW0Y26TSNQM=;
 b=NRtUtz5nBldZUF2qCvEybvuTwqZD0PmT5qdwb2KeJ7wbjsBOS/96lGQn83LYCmQaCUfQVoXywEgj/UkJr6MOsLixG0RA8/UfASh3U6XUodHovohoPMBiwQTtSe5lOwmlSPMyANdqZ69BKMw563+xv+N3WjrTMea3c883rdMfyoGMiL1MGgVWBRdvoyBOury7ZUMrUb+5OIDnkLWLV3YRV7jP+busFDWH6fkonVLh4jStvCPYqHJG+3qKUFqdoa5rxMq6qjPvGjnz83fP+t+J2qOp5JiuLfxPaxXAULygWD5R5sZl9fpMmvuCIsH66pDMhE4CTU2JE0PevCyMj2thGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:07:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:07:00 +0000
From: Alice Guo <alice.guo@nxp.com>
Date: Sat, 11 Oct 2025 17:05:40 +0800
Subject: [PATCH v2 01/10] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-1-3331e2dc3a35@oss.nxp.com>
References: <20251011-imx943-v1-0-3331e2dc3a35@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-3331e2dc3a35@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb872d5-b35d-42fa-e922-08de08a5893f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmpTeWNrMVhNR2wwU3ZHb2NpYTcydjBGR3l0WTBoMHJ1ZFRnaUx3ajhxU1ZC?=
 =?utf-8?B?Z2RMRXNKc2lwN3NtUGJTRFJTM0VFOE9sbTJINDN3N1FhcHBycHJBNnVWSE02?=
 =?utf-8?B?TG1PU3pxVG9laktFMi9ydlQ2VStKS2c2NWphbWxBd0FHTytRMk44dVFRU2RF?=
 =?utf-8?B?SGVwMU1wMWlmQ0dFQzFuSkY3eXlTWm8wa1RZUDZsdWQzb21XRkdFSk1DenJh?=
 =?utf-8?B?aXNqYlV5M2o4b01jYWtzeFBUaWxhNlNiRkdGYTlvcjRWS25hNE5kUlAwbi9V?=
 =?utf-8?B?cnBsN0UwZXpQelpxbWtvQXhUc2Z3RVIzWjhPWXRQTTM4Nm96czh2aEYzQm96?=
 =?utf-8?B?Z3NqN1dhWTFwMUk0TTFhQWRMZlR0bmN5amRGV0xBRGgwQzA5V05ZSnFPcHdE?=
 =?utf-8?B?MFpieExyY1BpNGY4N3ovb2Rod0pLVVJOSGY4ZnNmNm03amNqUUZaODVIbk44?=
 =?utf-8?B?N1RWQmcyUnpCMWlwd2ppZnRPbTdnT1NVaE5DQWZOQ3puL3c3NC96S3l1aHgy?=
 =?utf-8?B?Y3N4dDRMeEx1Vi91T1dGN1VITDlSdFFRRVpLL3R4ZmlUeEEvalNkTTc4dTBi?=
 =?utf-8?B?UGtnc1hqc3FYQnU2YUhqNitSOFlMcklZRC80QVIrYmQrN2VVRzY1V00rakFZ?=
 =?utf-8?B?eDBWT0hzL1F5REg3Q0c3QXhsZmlOYTFtUWt2cTljcWNHUEN1azdibkpOV1d4?=
 =?utf-8?B?NzdsQ2pNcVZJek9xeGlVRjRSKzRGRXNSU293KzBlMmJFUHdXc01SdWREN3lS?=
 =?utf-8?B?Uy9JcGd6ajZnRVFHQzVWcTkyam1SY1VFTCtuWDlLRGk1LzNlWStNTTA4ZkMw?=
 =?utf-8?B?NG1XU0RSemhZbWFObitvSXlNbnZyeE9jU3Z1MlorNnhhK1MvWUIyNWdYMjY0?=
 =?utf-8?B?ejJBRjJSeHRIQ2FnckdqcENFaXpkWkVmS3RvWGhaMys3RTd4c29LbE93WExJ?=
 =?utf-8?B?SUhNTktDQk5YVnJOSVo3OFRtNC82bktKRUdwKzVLMVBweEVQT2N5UW5UOGVE?=
 =?utf-8?B?NkdhSGxwMzhRVitocm94T0pPN1VpUzlqS1RJZmg5Nkk2WXIvSDB4dStYN3Z2?=
 =?utf-8?B?WUR2WWt3R1ZieG1hK0lXMVh6RGMybGxvclVISERoM0VmNWVsdnY3MENPV25L?=
 =?utf-8?B?RHc2YXh2Wlh2UjBxTEcwSmNUQlBNblVOc2JNVklmSlB4Z2QzUDdFNFJxR0th?=
 =?utf-8?B?b2c0cjJ1MWxCaUFmaDlQQmZQQVgzVmlQVjBIRGMvWWFtNENQK3ErSzZPQVIv?=
 =?utf-8?B?NGdTK1JYaFJuTWNzM2RTaWkxc2Y2WWx1QVpTdWN1S0p0K0lRNFRXWEJRSXJ1?=
 =?utf-8?B?V3I0V2dxUFBJVmhpN3hIdnRjUTlSdmhsWXZONDd5ZE1LQXlXb3JLcW1ZUndL?=
 =?utf-8?B?cVVSNkZvZnROWEl4WmhNNWJrL0tObTJqQlhhS1kwL2pOSUpxUm5YYmljeXoy?=
 =?utf-8?B?WHRyNWFyMmJ5RzZzajJTSVdwb0xxTk1Ed0VYYVpXZ1Fuc0ZyaDdBSVZpckpM?=
 =?utf-8?B?ajkyVEJYOWprcHorQVE3d2hlVzd0bGZYd1Y3R0RKMzRZd2g1M3grc0d6djhi?=
 =?utf-8?B?MkwyTm1VZ1ZSRUs4Y0NmSlg3UXl4YWNTRUp2VC8zSzhqcm4rMGxzTGxzWUtR?=
 =?utf-8?B?RHRGazlkdUpjZkFGN2p3R2daRU03L2ZJeXJDc1FVYkllMnlTQlhQanltRW1U?=
 =?utf-8?B?clpaL0Nic1pselNVbytZQTVQU2Nnc21lTGxBN2w3UHdGQ3ZqWjNiRlYvNlpw?=
 =?utf-8?B?cEdkU3NyWDdDNHh1WGU5M1NzVUJmNUNzUHgvNHFPREg0cjE1WFQxZUtHTmQ2?=
 =?utf-8?B?a2ZwVTZzbmVZd2x0UG92Tlg4elFGMm55U2Y3Nm9mS0w0dGl5d1g5eWpSVktC?=
 =?utf-8?B?M2QrWWhGMHdobngxQlB4NzM1elBJbElyZXNhVkcxSWo2bW0xbkg0TnNnREox?=
 =?utf-8?B?WFN2VzFsaDMwdVBWV1pld0o3Mk94RHFZOHBkY1l0OW1GaHhaNEdOR291ZFRF?=
 =?utf-8?B?WUZmY0FOejUrVHJPMUpuVzVEYWg5ejlRRUovbzBIYUVpckdpSGFKLzk1RTdl?=
 =?utf-8?Q?i15s4M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVtakdvT1Nld0I2SlZadnRzd0cyNzBCTTdvUmV3aHZ6UGhzYk9BcklxeURT?=
 =?utf-8?B?eDh5WGY1N0VGelgrcXFFMDgrNm5LUTI2anNibml0YkdqMWRoN00yZ0hKS1Fs?=
 =?utf-8?B?K3FSWEF0YWhhMTIyQTFFRXVKcnFEVDUzMjJxN1dPcWZ1VWFVWDFpQ0x6Z29k?=
 =?utf-8?B?WnhINUZqZEJMNUc3Tk5XR2E1bWNpaHVETHM2dno1d2VFSUdDc0lkcm9kV0ha?=
 =?utf-8?B?aGsycnU3VFhpbTVpdXFTYkM0SjJidE43SFJwTUorK0M4QmRuRFI1SWh6N1J5?=
 =?utf-8?B?YUVEWDJTeXZCNDFYWWNmL21mdW5NaTdHZWJnNERJaWZBRWZxdGVZS3paOGtq?=
 =?utf-8?B?b0JUcUhjYUJuOVpmRkZZMCs0UTN1RDdoSlNoeFZWeTNWYmgyRFBPdi9PSVRl?=
 =?utf-8?B?YnVtdUZOMnA4NWRpWmVHQ01Dd3dHdndnMGVlcmI5WURjNTVlVHZ5K205eGlR?=
 =?utf-8?B?dzZRQTNGVGwxd3ZpcUR5SC85VlliUG5aelVEd3pXZGp0NHlydWJhVms5ekdT?=
 =?utf-8?B?RUJEQWVCazVneGQ2TytsejV0OXk1VmJlNW1jY1JVWkt0bEJrRVhBTjJ6aU5z?=
 =?utf-8?B?d0V5NVc5L09kTjgwN2JUSm9OSFVZMm10SDhkZENrTkxqRE5YeVVRNXlKWUJh?=
 =?utf-8?B?eGdZeW1jUDhsL3RLS0VoZXRJUXlEZGR2ckhvbzNETWZNK09tanA5U0tpN2pB?=
 =?utf-8?B?UjhPYW5odTQvdUZmVFBRVnFSaWxFdTEwRW9EbG1IV2hyTFRuMTJpNmRTUVZI?=
 =?utf-8?B?bVRVWHdVMTVRdVpyUUN2RDd6dndaOTViVVgxZi9IMnVCZ3FWY01ScUZTSW9U?=
 =?utf-8?B?NmRQd1RvbWZJNkpPY3QvZnRiZXB0K3FOY3ducTkvZHNIaGdtV0NmUHdGSk1P?=
 =?utf-8?B?V0lyTktQbFI4MXp2RmsvR3IyRmRQb0JFdzZqYlQ1V0ZOMDFDWHJwdUpMeVgr?=
 =?utf-8?B?aGhNYm5RQjJzbzNRSmE3UzcxamthVlNyQkN1UERlWVhnZXU0RTkwN1VvQUtB?=
 =?utf-8?B?SGgrWG1mOE5ZbEJMdVFXbDYrZXYzRWdDaDZ4OEZNWXE2VzY1dWxMMW9IME9k?=
 =?utf-8?B?Q0pZUlNDeUNDV3ZjZnhhSmlXblZ6YzJPY0lMUmVFV1NpZHRtcTRia1p6NCtq?=
 =?utf-8?B?aDhSRXFKcW8wcmNXcndBbVBqb3hSZ0xGdVFSQ0d0WWl6Z3hRbkwvTG5TMS9I?=
 =?utf-8?B?M1MrZEl4TkQxdkNVVUFBbVQrRVhTN0JFWnpoY1hQbXFQbHlVWFZueXEzcWUv?=
 =?utf-8?B?NlZ5VC93ZFkvNkwyUHdNQys3TUF5em51OVRZWEFnYTcyZTRERXNSbnZwUGhL?=
 =?utf-8?B?c010WlBmZVhMcVhIMGRHaEY5Zll6ZU5MOHQwUXBva1UwY0FNejYxYlFpNFVm?=
 =?utf-8?B?WHg0RURRS2xkRGNjN291VmFlU2xrOFhqUHdaNXFrRXp6VnVvS3l2cHlLNlQ5?=
 =?utf-8?B?bjNLY2dac3pXellucU5FTDhJcjdqS0hEbzZUbUhWZGpCWll1SnFrOFZxYk50?=
 =?utf-8?B?cWgvMW1jWHpPd0lIMHNwWFdhSHIwelhMKzZWbTRIZkpQVWxmSWVRZk1qUDZh?=
 =?utf-8?B?WFhnbzNCOEdGTjVNMU96cmRSS1VkQzJidk9FUk9GMUkvTnh5ckRZdUprN2VN?=
 =?utf-8?B?NWdvR2IvMWlBUU1TbHArTUJUR3h0dTU3TnhwYlJGOUVKS2NDaXVsM0NVOUFO?=
 =?utf-8?B?RSs1YWdhWFo5SGxjeVZaQnNtL2pzK2wxV2hHYks0b3hUdWlTNzA4S1J3ZGQ4?=
 =?utf-8?B?L1ZpS0xQZ0pLMmRsbHF3aGVYQmUzb0RTV1FFa3RzTXRMVUxhbFEyaXZPVDhs?=
 =?utf-8?B?aGtxWVBoM0tiNGUwQmNqWHlLci9iK2NQU3FVcjJENlBRQklpeE1BaWUxVmZQ?=
 =?utf-8?B?VUptcGIzWHppblVLNTdoaDZFR3YxTWFxdC94SVFMazc5NVhLMXRFdEkwMGM1?=
 =?utf-8?B?YjFYbVNHSU9sNFZ3eUk1WENRNTZ2M1dKaDJQYmRRb0JmbExhTWNkRHdQcHVi?=
 =?utf-8?B?alliTmJuTEZONnI3WTUyNGlubzhWQXF5UThtdFRpL0s2bUh6V1h6SnFhQWdW?=
 =?utf-8?B?UmQwaHEvazZHbHJCVGExVzVhYjhDbjgyL0ZkbWcyOXFhYnBHV2V3azFMM2NO?=
 =?utf-8?Q?JsUVGS7EldXoTlbEImturSzDX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb872d5-b35d-42fa-e922-08de08a5893f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:07:00.0067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYK42yrfOfV5g298GKZKaSNjLLkioPXkA9mj7yIEnx4062nbZ+eXzkqyPQetTGvrbQ2EUNjimPxiJQIRPnkMRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
i.MX95, the condition check is updated to use IMX9.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2cf687fc4f3..427b62e934b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,10 +210,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
+	depends on ARCH_MX7 || IMX8M || IMX9
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93 || IMX95
-	select NOP_PHY if IMX8M || IMX93 || IMX95
+	select PHY if IMX8M || IMX9
+	select NOP_PHY if IMX8M || IMX9
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

-- 
2.43.0

