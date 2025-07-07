Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF72C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F89C8303B;
	Tue, 15 Jul 2025 08:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D0Wayrb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578CE8277D; Tue, 15 Jul 2025 08:41:01 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6804C8303B
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrSzf7mK998lJaWJvGmwID4EBVkS/CLMIAnTjgJX7E3R60M0JbRMfGL1F7SAdqcPG1hxlYJS6SHgIuG6asRJB9VDkCtTl8Q8BxyHp5katE8tq1Hv0CP/P5Nut0q/Wot0bSgbTI91IYsFafmtwytcZnehQTt+o7wu3A8gMyFAFT9Y2lNho95bgw4qmYiMb3Vjhabrf3t0dxASyPLMLgi+Usad/CRBzaLgcW/GUyAUhMaQpV01AZIj3DqW0H6pdPedXjqzVAguCQMvfL1bsCea3OJiW5JP/yMsed0oNFoaahWR5egS5oNpQvhnvQtWf4Hw0DopJKc1KgTWxG2XrLuZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr4spESgWND16O/6xkgBly5uR5FOwcGDnflZtu/UNrA=;
 b=ZvdUBoHzqE3ft+A75dFiqHtxJ9pE2lC7ZtyF27y75tvjhSkDWNxtMDeKm17evjcj46dsi/9T/Q1lHna2nkvG9vpNxm1+2ZQqDq6pRg6f1Dgh6tXMIsX13V+r2FLYTR0/bhEy8zMZl6UHitkRV2+rQYsd5dP2ZCevNm172vQxkt53//Pk7V/nWdnDTHnvrzJLU/aKndnHjMmDZqr2I9rY38aMNjp8+Ndf/QKPkPmBTcJ3izIHo/iMR7IFVBD5QfX3t+cM8g7zBlb0bSBgTRJCrao01JY5Rw9eUtJVwCAFa2hHVn6iLkt9Rz/JsXbJPmIB1X8G6ODZSEzvv3FeFMf2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr4spESgWND16O/6xkgBly5uR5FOwcGDnflZtu/UNrA=;
 b=D0Wayrb/UCUgcNmk9DpDe6PmvYjBBWP9Z4AjEqIOVDRX1AKQfNo0IpT1pDWu/oj5G1jJCMBlqAYC7UetHkbORZw+2xIz5CI99U1Kqup0p9sllljmIsxqo1i/m9elalHPFdMf9eP4ZMLbaIHfrnX+Bmfpti1eHhKl+OUdAt7RQtR1mWW98hcKg311Yq6g1cZtPHkqAK/VWuHPcB95+Yf5SRhAwRTBnNLarNpepCsfco8EzcuLYcRsHX1aZgECAeQhuvB70X9cB7muAJZq/it/N83x7YyxVw5I+8r6YG2N++YZGjqKHfTjKfooBOyQxST+Snkf7sAzkyji0f0fSA+q4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:40:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:40:56 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 08 Jul 2025 04:42:53 +0800
Subject: [PATCH v2 1/4] arm: imx: Update ELE get_info structure for i.MX94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imx95b0-v1-1-01759e9c855f@oss.nxp.com>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
In-Reply-To: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: cbef472a-d27a-4fac-3d79-08ddc36a8d34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkdLUC9FV3NIZlZJaFEvQjFxZ3ZGRnJCdThOZ3ZLTXJHdE5sYno0Z0l5TGRk?=
 =?utf-8?B?OGhYNFk3NmdWaG91ZTdHWVdWMFJYM0JXQ3E2cTNuRmRocS9GSDJnZlEwNjRT?=
 =?utf-8?B?NlpVOVJKUXJJQnhRdWszUnN1WGZ5aHJLMnFTU2dXUXRJMVYwamNvbkFBK0NV?=
 =?utf-8?B?RUpOZzFINGZRaUVaeUloTHNvR2x0bFJYMGFIaFZ4MHdoVzlKMDNKTnVuZWE3?=
 =?utf-8?B?UDBqV1pIc09qTnA2ZmdpYmxGempXZk05c3RpUEdKWTN3a3p3M0NBVXB2cVRk?=
 =?utf-8?B?UzFNZWhneVBnUnpzZEd3blVhVEpMM0xudnhRN0hUaUd6d2tUVS9WaWhBTlJ2?=
 =?utf-8?B?eWQ4eWtYdU9xNzNRSWk0dFhIWHBHbW5jeGtCdURlckpBWkNmWitiZW9TNE1H?=
 =?utf-8?B?cmVtaDVjWFB5bHNSS0ZSOGxJU1RTMkJ6QVVNZjdWeWZmelNJSEx5ODZERkp0?=
 =?utf-8?B?QTNOM2JIYzY2ZFRsNmZ5RXQyYU1SUmlFcENJeDhYZmhOcFhaQWg4eitoTlVW?=
 =?utf-8?B?ZW9CbVIwYWZidWFISnVuUXdGTUVQZk1rcFpIdGtRenZxcmNqaGFJSUxIMG80?=
 =?utf-8?B?aGJFeWVJdGh6S3I5cDVZWWtXVy9zZ2hFUGM2L2tZRzUyalNoOXAvOFFsaTU5?=
 =?utf-8?B?VERzZFZJT2hLR2p1Um9rUm02QkJGZ2NjOUJZaEw1cjAyK3VvamI0M3gvNjB0?=
 =?utf-8?B?NjNPNHF6Tkpka05mMlNPVzhXVXRRUFQ3d29kSE5WUE1OVHE0M25XcFgvMm9X?=
 =?utf-8?B?N2Nqai9KRVc0WEFhb01Kb1NRVmNZWEYwNmcvVktGR2N1Q2xRRVlOYWdhMHRr?=
 =?utf-8?B?R1VnR1I1S1NXU0MvNXhIWU9RN0k5K0EwZ0xyRVc5MEpaVGR3a0hwSDFBOHRV?=
 =?utf-8?B?ZDN2SXh0YTAyQmozWUI0TUE0ZktCMTZvVkVtWHEvM0xWMDJKSS9yYzY3eGx2?=
 =?utf-8?B?c2MyYXdBZ2R5dkVtT0RZajFKK3lnODZUMW5CSWVFaWJnYWVqamUrMWhpc3Yv?=
 =?utf-8?B?RzQrWG9PUmpwK2NhWUlMbWdLQWM2eG5UYms3bnRSeTNBY3NWQ2ZXWUtQUThR?=
 =?utf-8?B?TGs5ZXRNamt0VVdCSHErcnhMcGlkcW40VXNEUXZYL05pMmh3bDU2OFgwcmhh?=
 =?utf-8?B?UVdWNGM0cWFwQktHN2tPRndhcVl1VTM4a1hJQmdRL21RQ1ArNXlPOVpsZzlD?=
 =?utf-8?B?RmhoMmFOc3o5TlNyY25LNUZpbFB3eEtmUEVvYWlRRTdud2kwUkpaN3B0TGtp?=
 =?utf-8?B?MU1wZG9kWVA5UVZvUTY0czUyVHVodzBubkQvYzB1MGRSbTRBMEFadVREQjh5?=
 =?utf-8?B?WWljRXE0ZUxLSXVIdVVyZ3FWeVJIT2xOTUZKc2ZTTlZpSmlRdkhGVVplb3ZC?=
 =?utf-8?B?ME0rRGZ3U3A1aTlrSGhodE1JTHhMcGRMMmY4b3RrR1pVZVA4NzJDQzh2aVN6?=
 =?utf-8?B?cVl0NFBKRDZEQmRmVFBxRERzcmNQQzlXSS85ZTRnVnJBaWhiQmNyK3dqYUlj?=
 =?utf-8?B?Z21pMUF6YXJRNXFhcHM4dVV3NGZtVEhINXpxSERIbWxTUTNYdEVzclErVmFL?=
 =?utf-8?B?c29FLzFQc2UxQk5vZUROUS9XRDFjQnczTlNvUGZpeGltWnNOa2ZSd2t0alZX?=
 =?utf-8?B?RWpNcFRaUUNaWXFIMTlsWDBJcVg0MjhOTTFmSnoyZzQ0ZG5RMkZvTjlHTy84?=
 =?utf-8?B?TXZMaEQ0UTJVaUdSa3FrV3lzdzhHdnR3cVpQaEVid1ZqaDQ0cW43TlZtMnBq?=
 =?utf-8?B?c3JjWEFyMEF0THIxRGF2Zk9nU3MxSFJ1ZDZPb1c2RmdhdEluOXJLSHdDZ2c4?=
 =?utf-8?B?bXNVTGVPM05pWGZXUkxvR3JKQTQxdWVUaWd1SXZLcUpPQ1M4QjlQYmZRWkY2?=
 =?utf-8?B?QnIxOUpQR3JCaXZSMktKaUo0N2syZU5FQnkyZjVQeWdmTEZiVUVrOUVEQVRz?=
 =?utf-8?B?bi9oblpENGF4YW40dkR4VGJ5TzBKQ1ljd2FHRi9IM3VhV0N1RkNFdFpMQmpU?=
 =?utf-8?B?cDFMejNwUDBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk40ZEFlWGtKWUNIbXJPTmpDUTh6YWUyZG5hUHAyamJtRWdmSHVrQXd2SCtC?=
 =?utf-8?B?Wi9aTnNRSWd1OVRwZll2SW00eVNUeW1ST25XaUFrcjh5ck9kSXo3SWhCY1Ro?=
 =?utf-8?B?TFkzeWxKenJPSERUaFFBWVdPUWRkYk00Zzcwb2tBcjRVeGR3VW9HUG5ieTBo?=
 =?utf-8?B?RzZ1cHdsUEM3TFQwWjc5SUVySkNSa3kzZ3RRaXNMaHZlaGM4UlZqbEVQS0VM?=
 =?utf-8?B?Q1Y5Z0I5dGpBZkUvUkxmZlJGYjRQVkpvSnFmeXJBUW5ZR0dEVGJUU2cwUkFF?=
 =?utf-8?B?WTJ3aTNleCt1N2JYWXZHbG5BRklsTlVXTnpYdHJ1NlhXUDRwdWNCWWxOMExn?=
 =?utf-8?B?TVVTYnNEaTAvWFVzWnMwQnZOZUFIb0cxdjFYWFYwNDk0dkxjOVIxOGEvcUln?=
 =?utf-8?B?OEZDVnlqUENITHlXYVAvSzk2YnloOG9RSTJyekV0VWFDcVhLeEptQnNmTVF6?=
 =?utf-8?B?ZXZNQXorY29GV3g2bER1OWY2VVF6NkRpaTJYRm5SRUNvYWJIMTg2NXhsdDRJ?=
 =?utf-8?B?NGFZSGtHdWZhN2l5UzhmVGxXM0JvZVhMUjBlU2xZK0dySktGdjJ5bStYZTVN?=
 =?utf-8?B?a1o0dUR6Nm4vTWluUE1vSEZ5TWxmY3V0TUx2M000N09UQUpJSklNN3FwNGFl?=
 =?utf-8?B?L2MzRTgzSEdNSHBydVpPck10eEdSVm9vYm1nSSt2bW9WdSsxTnVURjJOVGhm?=
 =?utf-8?B?emtkalMyNlNyWGQ1WGRTZk53eW01V0FZV0dUclByZ2tCeUdUMDJ4cDU5OHov?=
 =?utf-8?B?ZlZsbmFDT0tyd3Nra0FQTVFnOFdxTkE0M20zWUtVRGVPWk1mUy94ZDVWemtH?=
 =?utf-8?B?aFZVTGY5WUM3NlpabHZ1L0lPcWd4YnhIWUJDeDZZQTFzNkxPd0NGUk9vYjEw?=
 =?utf-8?B?bWliVDFORFdXOGY0dU84STA4UnY0NmV2T2I1OVp6cmRwT0luM1g1cm4rU05r?=
 =?utf-8?B?Mk81OWxlU3locUJ1WDRWUVozS0hSRk1xY2kwblFmdk9KdVRXc2MwNlVMSE1Q?=
 =?utf-8?B?YjhyNWFkOU9rQ3ZuSW05YkJTRWVQb3pzbFkvRDcyaWlXaW1ORUMxbjRGQXFW?=
 =?utf-8?B?YmlrS2pNTGdDTjlzS1FHQzBmbC9FemVGampUY3FzbHdYSTYrT29NRXJVUVVI?=
 =?utf-8?B?QWJLYStFU3FrL0diMGVTQ3l6TlpYeFA3NkljM2dRbFdCVmdZd0I5SGx5b0gz?=
 =?utf-8?B?K3l6VTlrVXd0NVlxYm1EZXZlUzM3c1UvWjVSUGFzL3AwQWRtS21oaEM0djda?=
 =?utf-8?B?UFdFa1ZaZ1BNN3I1MWZFMm1qRHhxNXhXQlB2V2NGUitIUmpCaWVXTHhJbmVr?=
 =?utf-8?B?WCtmZ1dGVlpqaWlIVWpxeDdlbzU2clBTRjd6K0NZeFVnTmdzT3BkZ3c5cjRO?=
 =?utf-8?B?VzF5VzA4Sm5FTURJNTJoS2ZqYVM0aHUybHc2ZzdyeWlzQTYyK0g4R1N5aTZC?=
 =?utf-8?B?ZUV0N05wZk5UeTNEdXhLeWVnR0Z2SG1JdjliZUp1QmdFNitRaFFzWjgwWExV?=
 =?utf-8?B?eEJMWGRlc3QvbzkrZEs0dXZRMmpvWWkrWm5PQ0UrdE9pUUNXVDlFR2RFUDJx?=
 =?utf-8?B?bjhtRGdXMHAzdkN5NHM4Z2pCbkdLd09VOGtNazFwV2o0QUZuRWFVdmxlN0t1?=
 =?utf-8?B?UlM1akFKRDlINkNRZzdVU3pZWFB1R0JiTVVhQTNVQlVWVTVTemp5LzNOMmtX?=
 =?utf-8?B?THpKODl2WGRMZFhVb05kLzcyWk1TbWk2NHpvOHB0U1YvNmxCa28yUlJIcm5L?=
 =?utf-8?B?QnhIb0JoaStmdGdFNXZ6YlFpZXRRRDF3cC80NWt0c3htTEduNU1jM3M5SXFM?=
 =?utf-8?B?b1h0YlIvMUtQK0lzbnl5VDFHbGJCNEQvbURncDF2TS93cndodG9WbWxzMzBj?=
 =?utf-8?B?MytwQS9SY2x3SmhTM2I2a1hPNy9mQXIrMk9rYmxsN01pazg2V2pHTXdkS1lJ?=
 =?utf-8?B?THN6emRYbU1MT0szaDdUZi9tMHZEOHhJZEhSRXlndmMzeXdYeGIxM1kxd2lZ?=
 =?utf-8?B?dXFIUE9LZ2hvd0JYM2NVeXZEU0xQWEhST09PaTh0Y0V1RU1SaFJrSm1GZlo5?=
 =?utf-8?B?T0U0MkdZV3k5QiszcVhjMXpLTmN3cUp6clhXSHhNNXd0RDJGUVdTUzFRWXVN?=
 =?utf-8?Q?Z0S8RaTj43tiPayE1d5RIDTdV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbef472a-d27a-4fac-3d79-08ddc36a8d34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:40:56.1251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcKzEmcJaRirLhrg/pKhbH2xjC3N06CU449knnIn7u9x0a5av+raY2Aun7MO5/PR6At49hK7q7L77SkSzVwotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370
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

Since i.MX94, the ELE get_info structure is updated to add
OEM PQC SRK hash, so update it.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 19d12696a1e..64b243dcaaa 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -134,6 +134,8 @@ struct ele_get_info_data {
 	u32 sha_fw[8];
 	u32 oem_srkh[16];
 	u32 state;
+	u32 oem_pqc_srkh[16];
+	u32 reserved[8];
 };
 
 int ele_release_rdc(u8 core_id, u8 xrdc, u32 *response);

-- 
2.43.0

