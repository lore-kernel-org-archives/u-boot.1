Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44758E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA6780381;
	Fri, 20 Dec 2024 03:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SRAgOFp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5568803D6; Fri, 20 Dec 2024 03:55:39 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D1B8039A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXYpirLY5vfGk5IBsFhkcmGQ4JcYmcABdG0CXu2P6GNyDHGk9T4gjzgt7lQnk8IJ0QI4meYPtPLDT8y1LWRFAvHBC01+VkdoHhet26UFChDrtLpu+4gDofb64GPj6z95uPJIPLFOCCMBxjQAUDz7DLjnJAY5uiJfs1dM7CRyzAxVgClCmzuPNIrN+CtQKbbEUNgCtTqEhIkl/fwDDo2MQqmNseUHu7HZBMAQv3oYv+T8dr1CpU7UBpVroLYa6U4U/nfojKnYn3J3a1daG9hl8pnYtInH744gjSY4iswayaAGupjci2PKOr1O3W7vttMtF4D4m/SANWwCnbDl6XZQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+SshC//O2KgQppU+e/3G5MR+J3uebQ5bSQk9mMigR4=;
 b=cso7KSkjH62C/dKzLXr2ijWYruuAv6bHSBRD4uc/x6p8BbQHzBcduHjrZsS2aQwCut9QmxxU7OnWMu9YxBKjKuOG82tu2ydC14+x5lS8KNTqr0SbhxOJynhJLqIFgdOhvljLNc5Jjad252ugYvisygPxlNmsz34WvVT5PmMU19PDisbwRFAFmnBaeI5qvwmFACK2kjsocNT47ScvKHLjO1HpxPNPkcoAQm/K0xD5WwBmociESHBBub2moe7jr+4DOO4HINLlQKSsT1runfJEHrBmA6uaCOGPgv9k1DVptmo48Wf5NNJQOul5p59pGfYA735iEXZa8RxBXOOJ36tCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+SshC//O2KgQppU+e/3G5MR+J3uebQ5bSQk9mMigR4=;
 b=SRAgOFp3UjLM+dATvONWqJZuF+5AWcr11zmzPferVZUmERL+aKoHKz37Bm7RSYmxZ6XNi94p2bGb5rwXFe92Y3x3nkmo90E0dXv/nU/ReavnQkE06lBBGkHdeZKyfYs8jg5oo3DwH4Sh410agx5ncf/lVebsnZA3k7INMJACp3gNnVNeQkLvOHDjH9bkSbfNi5UQZ4GOEVpxe4chPsqNYwAqEWaDWOYpRBMeE6izcqm1dZd0I3DT77qSO/Yj0utQDsO49siFOIuJb3AvTdoE+oo06ea1RoFLlf2NCADSYGNe4PAzf1afBcKEKnOmuGoa8FedHjuOkRxaM8Tlg+DsHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:36 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:06 +0800
Subject: [PATCH v2 08/17] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-8-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=1122;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=HRRzAfMPwiG7DveKXwQ+yoWXXYk1m3p+yIzjFi+h25Y=;
 b=nCLeOsCQzqcXppreraKM4/JEPH5BJugX6I6oiX0KRXiIb134VxxXm11gggsO+ZLfjH92PKnTB
 5tLTVyUg+kJDCpLVlOoW7XjVD8+mlhRzDdNJYlVr13kjR08b8lWeYj/
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2a4964-fa39-4f0d-4a77-08dd20a1c772
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFY1K3REcE0vcnBHbXdYTlBRQ29oQUp5ZFczVkNVSC9XNE5PcnNVTGZPSjF2?=
 =?utf-8?B?R0Z3VFE0K0Q3TVF4WDEyQ05ma0VPd1VFWGE2K0NSSXNMekR1R0ZOeGxJc0ds?=
 =?utf-8?B?MlcrRVh4YUZQNDdBeVpkZ0NXMGluVWJNbmsrUys2Qk1rVXhnSnp2V2ZhanM1?=
 =?utf-8?B?VEttNnI1UDhzRHJYaVRRZWhoZ0RBekh3b3c5UUZuOHhaWjRmcDRFVW1oK0VL?=
 =?utf-8?B?TGNuUHl1ZDhpWVIvVGk1NGo5S0F3M2xtOTlSNnVGZ01rQ29ydWtVdTdZdW51?=
 =?utf-8?B?UnM2bzc5ZE5sWFpoZ0h2eWFaU05Kam1RSURIZGpSM1BuNXI3a3VmWlZoZ2Q2?=
 =?utf-8?B?U2tLS3doOUV3M3pKV3FUWnppZjk3VzJlRmg2Z0xiTzlLVWZpRmRzZUlSMnBp?=
 =?utf-8?B?MWNiTVhJK3pLZFRhZmI1cjJRb0didlhSMTRRVTRESVhNUFhramtxWHdBT3ln?=
 =?utf-8?B?UlVJc3prZnZyS3lGZGgyaFNvbXpjVmhUVmt4UzFmZDBXdjh0RGl2WldGZzU4?=
 =?utf-8?B?cFZ1SXJiK2JFRkJyMnpGbUhUU3dvTEZ5V1RmTHRhVVhVZEJLalpPNy91THJo?=
 =?utf-8?B?QmN6RmNCYmlUMysyQzQyZDlrNWpMbXlZSWRQVGxaVGNCVFJMTTBKS3RCQXpV?=
 =?utf-8?B?UWduSTRsZlV5NmlMeHlJckVaelYrS0tyUFlPZmthZTVvOEI3RWNEUERoUWFD?=
 =?utf-8?B?SEhacDN4cEhHcUpYVVRQbG9BVWgwWVFTZEgxZE43UndqcjU0SkpwRGRvaWln?=
 =?utf-8?B?V1JKejVwU0NTWEtUdkxQZkQ3ZEpFbzFSWHdPK25rRGF5VTRuTVM0U1BYd0Iw?=
 =?utf-8?B?My80dkdONCtjeDN3Y2sxY2hORldvTm54Y2llMitJSzFzQ0JVSmtiNkhGeXhG?=
 =?utf-8?B?TCtMbWFhUE1RVHFBaWtDUVZGdTgwbHdnY3hWczNZNlR0emFUWlhOL2xpeHpk?=
 =?utf-8?B?eWhJd2VXWjV2dkdkdHMzL0x1SzZOTzhGT09LY1pXRTZjLzJhZ3Bxb0FyZlJ0?=
 =?utf-8?B?TUErOVk0OGZOSkZMcS90SGlGVS82bk91ZUtZMy9CWnI4aVRXSGhrNWh1UG9O?=
 =?utf-8?B?bDNKMXRmYzFIUnZNbEFHcFRVN1lRUFJtZlhBeVNQa0ltR2dEZUU5d3NlQ3hY?=
 =?utf-8?B?UThrU001NnlsQ1dPTm9DdEdsRmRXZW16L1lnS3RxN3BHY2c0WXBNd014dlJZ?=
 =?utf-8?B?RlB4aGNqQnB0Uncxa0pET2puWmxNZHVrRGZRbFZMTmJBUDYvMkthYUlldEJO?=
 =?utf-8?B?Uk5BOUV4ZzVEZlc4Mno2L0JQQ2EzcFBaeFhjS3dGaHFGYTJHZXVIYzFDTVV3?=
 =?utf-8?B?K0tnTzRYZFZXcDdrT1VRVjhRTG9nSnUwcmFXYU4zdzUzY0g5eittbkRQdWpS?=
 =?utf-8?B?Tmd3Z2lPemtHTXV1R0Q3cmRrK0I2bUhPZmdRY0k5TjZkRXR2Um4wd3htY29U?=
 =?utf-8?B?MEFVcVNJc2dMMlBhNk1GTlErYTZjNUVadFE0UW9IbGlzeUM0dWV5cEJ1Mmti?=
 =?utf-8?B?ZE1SeU44aG5CK3NYbDVOTXRQTVRkL2o3Yk1ZOE40T0JYcFdMVEVRT0thV1FQ?=
 =?utf-8?B?ZERKSjlYWGdFU1FBYnN5emYwUjBOSGtaeWpabTdUamtPWlh1aFNXMnQ1eHhO?=
 =?utf-8?B?ZDBqbE5TZ0FLUFpReTBUMVhBQnUvdk0rcGdiTjVEdzZTbys1VnRlYm1XdjB6?=
 =?utf-8?B?T25sMGtHNFpyellWVFRvdW1nOXpKUHhSMXFOWWd3UEF5MG15REJyNk5uVlhp?=
 =?utf-8?B?S0srM2hKMDhCcXpxNjh4SUtNR0Y1SkJCVjlnRnVNS0E4djEwR2ExbFNhcGtW?=
 =?utf-8?B?WmtHTmptcGFTNnJqc0ZBazJRYk95cFNGRVFrYlQvVHdoSk9JTnE5UUdub08x?=
 =?utf-8?B?dXljNW56TVllbnZ0d2xxWTRpVDZOSzJFdlpsWkk1ZmtIdFBGZk1SZ3JiTEZR?=
 =?utf-8?Q?5dW/DIdShWcyd95A/8Uw+lmgi0tGxCWW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0M5VWxRV3laSDBCbm9pYVhSL3NqanROU25acTVscVB0aGJ1Z2lNU1BwMWNP?=
 =?utf-8?B?Wk4zLy8xbUl2MzJZSGU1eEVpUHR3TStkMEZtaC9nTHZiSXhreDRKTEQrSTJq?=
 =?utf-8?B?Zjk4MklNcWs0SkMzS3B2aXJwSnBOcklKVWhvdUVOWmhTblIxNll1OTNTK1Rn?=
 =?utf-8?B?djJVYXpyVjdIb0dJaWxtOXpPdGJneHVRSjIyOTM1UnJhMHdxNVYvYnFvRFJ3?=
 =?utf-8?B?cHRoRFJjRWdnUlRDL3RuWDlBZDNBSjFlL1ZQSjI4czlqTENiOFVEKzhhd29t?=
 =?utf-8?B?ZENzZktXaS9vL2p6MlRKVFAyN1BBdmtmNWJ3L2U4Y3JxNU1pYldsMWQ2cnU2?=
 =?utf-8?B?UDhjWk5OTHBLd0V1MHpRMG9uUERnVjV1Y0VPRUtvU3BwWjNzaWpvYlEvTkhN?=
 =?utf-8?B?SHhwVDZGL2pqcHgvcFZIQmFBeDFLMUNKaThWMSt5UkJZYmZVZW45MmN6M2FY?=
 =?utf-8?B?cVlTNVcwbnVkcmduaTdoZTNVc2d3OFQ2dW91WjRNZDRMTUttZ0ZVczd1T2h2?=
 =?utf-8?B?NE9jSm40bUFXeUMvTXFzcG53RFFBK01KNG5kSVM5Z3EyTmVKak9sVVFLT0Fh?=
 =?utf-8?B?SFJLek1kWTQvbGhOb25yT2ZLc0NiVHRGTjRIZi9TU1UyMVhBemhRbEJQUUcz?=
 =?utf-8?B?dnRZblVvSTBUMzR5N3UrRkZBaEFtYmNIT3VsQ0V1enZyejk2am10UVRiOUJW?=
 =?utf-8?B?bDNIak1sWWQ4TnFpcnJjd0hQR1JwcndXckZETm9UL1N0bFU4cjdvTTM2UnBW?=
 =?utf-8?B?WWlrRkgvUUpBZldMbm9aYVMyNTl2SkpxT2d4NmEwY2ZtRzRGSjE5dkZoQ2J0?=
 =?utf-8?B?d01Uc0lhVlFaQm5MbEtmYkJKOXRNRDZPaVFBai92SU5sRFBMRXhyYXdoZUF5?=
 =?utf-8?B?Tm9kajFtSStxdWYrK2tzU0pSaEZUdGdlQzFPalNDZ2NFOFUrVHcwRmo5bEc0?=
 =?utf-8?B?YXFZdkErMkpDbGZEbjAwYmduM1NhMDdlUSt6SjUrcFhIZWMzMnMyOGZEV0g1?=
 =?utf-8?B?QmZhUFpLT2dIODErRmw1Njc0dEgzMzFhMjFsTUtjNjJIVXh4aXgxbkl2emN0?=
 =?utf-8?B?bWlrTnlENzF5MlZUY25Fa2Z0anNSWUNVbVNlRmdEY0pMdlE4cFBVUVdXMmtL?=
 =?utf-8?B?ZjUvY3ZyTlByVTVrN3FrNUUvUFkyaWZzRkt6NmhUSnNrcnVlY2N4SEVlTWVH?=
 =?utf-8?B?UWVPclVQNUlGYjhSUDBEdEJpd2p0bm1ubjQydnNpQzloc1N0LzZiK1VCelF2?=
 =?utf-8?B?Z3J1WWhaTUhmZkRKY3hqVCtwUStzQndHR2o3WEZZcCt2aW16Um9PUHk1amI1?=
 =?utf-8?B?YTc4N2ZCdDEySkxUdVEyZk96RU1uSEVpaWJaNTdNci9MMFhoYWZpVXpwd3pl?=
 =?utf-8?B?czlNdUJ5ZTVQT1AwYncweWY1UmwydlRoS1BhTWx0V1RlTUZzZG9Ud1VybVhB?=
 =?utf-8?B?c245VUtiWEhVRTlJVTFsYjE0NDNuYnVicEcxOTVHdjI3ZzA1Q0tSUzJ6TWYz?=
 =?utf-8?B?MHRGZE9yL3p6aEg2M2pFU0djOXR3SWV1TDFTV1JkODVOVEtCNS9DcS90SWph?=
 =?utf-8?B?T1RXVTRUdkVzREYwTENveWV5Y2dubno2VWZPMHhMa2RtSkdlR2J6WXRIS1Ru?=
 =?utf-8?B?dFgxOHZNei9iWWJQdXQvUVFQN3FSZGwzUW1SZlFzS0ZkdkJOam5UN2kybFR4?=
 =?utf-8?B?SmlKQStCRU52MU9rQkRTUDRITm1kdmlPUlFib3NRanBYemgwMm5Qb3J5TTh5?=
 =?utf-8?B?MndMbVVRNGIxdVUxaFozRjZYbUFNSGRTNVIyS1YwUWZjeTF6YTlxN2NiRGJN?=
 =?utf-8?B?K0hNUUViS3c2V0FjMmpiQlFhTmZJbHpYUXl6UnAyT2l4N2hEQUxEU1RUcEdv?=
 =?utf-8?B?aVRkVDlZVlFBNGVxNGJ6RzY1dkthalNRbHFsalZHbjhITXhVbDk1bThhK2RU?=
 =?utf-8?B?bjJRTlNITHhPaWtRMzdZQzdER2w4bmFvRzV3U3gyY3FTemhNVWRMcGdjZXRu?=
 =?utf-8?B?QnUyVHZMQTBrOVg1VVZGS29NeG15bzBVeEdYa2RKZ2V6YjVQY3MwUU5xSWpE?=
 =?utf-8?B?SS8wbENtcVV1Z3gzWjFnRG9QZkFSYlBadHRjWU9iVVFLamNXQzR1NHNjZmpt?=
 =?utf-8?Q?hD7oNkOLh+HeL/p41SIsKxM8f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2a4964-fa39-4f0d-4a77-08dd20a1c772
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:36.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfnB2SGXDcGOvbp9ufeiAq74jYQEZCraqO4XJ51cUVz68/nlx6CzDJtIwcpmAYPptCCEeGEuoriOYyspPhrVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side. Currently, set it to 4 is enough for i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/scmi_protocols.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 9607433c3276f9aa18044c414a5bde3143726cf4..3c55d228cb641bc6c0e5ca7ac885efe84b41c66d 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
  * @status:		SCMI command status
  * @num_protocols:	Number of SCMI protocols in @protocol
  * @protocols:		Array of packed SCMI protocol ID's
+ *
+ * The number of elements of @protocols is specified by callee-side. Currently,
+ * set it to 4 is enough for i.MX95.
  */
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[4];
 };
 
 /**

-- 
2.34.1

