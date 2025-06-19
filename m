Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A64C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 09:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F285882D06;
	Thu, 19 Jun 2025 11:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IvrWTnmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B230982B18; Thu, 19 Jun 2025 11:13:27 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C45D82B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdH+T4f37Ra1fgNgQhlxWGvEJZxU5or7kVNvkeWZcv5aH2S3bU27aqKpRWFMsMykh70JDYVFJq5jTCspdtCcTA7T9aDO7gE2wVy8IUrkt3zB5014LiE+T2HkivMSneRegYP63+XEioU45YAUK6Hq94UmbQ/VWZ0Gw+Bd8PUBofObWTYfN+VGE20IcsKlsuywG7c8typcdGNRsV72sjWChFvzGZuAphzCSEsU6eRcR3NW+/gyqpJiBg7SsA6U9UvsNO0VzeqQOwbV3mHG2s8S56LqDOJxKwn7t4MDWx2HmdVTLrre0VSmHH83bcvEGhBjCmhIo/5+gBR9uQQmkon3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YMc+QAMHEeRBACGC4mW8LnonImEi4050a/zwZl8kjM=;
 b=ChLyg2zkt/kEwduo5g/OyiG40rNs39NWIGuo8LZR0EMZj/fCxvRzM7FxmdPyHs+Z73UjPOJ0efEJMj8BnQROU1+eCyqHydH02zuNFeo5xQRdDXoTSKfq8TI4BmTcd9HHNf1wQ5ZB6/eGe/0Y0UfWFfMEdxT5vAruPM/wBf4z7zeoBZL/BskgB2hEchlz5biznJVZfCUGeLdd195tnjrmqXsPCeQ7S2rIcbFkDGBzgmg/KLh+wKKt2+4DU1T+Pqi/bowtpiDZEapzJh6+BWsaQtFQntise2vi8An6jsQsndZu1oHMAPqSvlzaOzjpjPSiSCiXD/efln+NqVulbPKXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YMc+QAMHEeRBACGC4mW8LnonImEi4050a/zwZl8kjM=;
 b=IvrWTnmXFx4HUqrxxezcADcz+hZu6c5m3rYgWo1f/Pq4dVQC9OsHJsRhchXscpP3nd0Zd7AxS0AlUdDzXNTeqBKQRSLANyP4enUEI7cVqO0HbCv7NP/+UPTu9HxOSQoGFOzqoxjn6kcsOX1LI8I+5bnU3lRCRnjnZQ5OU0IHoj0X8uYClUCBkrUGhtD7tql1bEGCKUaDSau7OExdhSmh/f8lnENltpTnwYNOC45NbIDFuiWHnmkKFVev1o88zwKQFOq4kelNPjxRbDp3AxuFQnxx82dF61v9Fm/BcZuJ5zm3RjwGGeJhMvVVtsVyfRGoFwRJxGkln3k0PoDfcuvJqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 09:13:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 09:13:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Jun 2025 18:23:38 +0800
Subject: [PATCH 4/5] imx93: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-sr-v1-4-631100a113a5@nxp.com>
References: <20250619-sr-v1-0-631100a113a5@nxp.com>
In-Reply-To: <20250619-sr-v1-0-631100a113a5@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: d55e760d-5090-4a9d-5d67-08ddaf118abc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3k0NlZ0dGdScGI0K0pORTNaSFVBVktHckhYSmE4dXdkZUpwRThJUFIvOVZh?=
 =?utf-8?B?OE1FRFltajdXVWNSdUI1anpabGdDTStUZFgxWE40NndXc2JxWGR3VkFyR3cx?=
 =?utf-8?B?SUlpWWIrNnVXVk9La3FDZ29NWG9BMkpOdDZKUjZIZU0xaE1aMDczYm05SEti?=
 =?utf-8?B?Q3JpNUMzUjdMbzBCZys3T0o3eTN4ai9ZSERzZml5Z29BVUwzVG55bk03ZHA1?=
 =?utf-8?B?QWxhZi9BenozdXVXZ1l5TVpDaUVjSkFXcGNydEFqOTkxVmRnWHlBaTVNT1VL?=
 =?utf-8?B?Vm0wbjI1VWFvckFLVXBkc1hIMnp2YzBIci96QWlXZ0xHNW9XaFlWMDIzZHhL?=
 =?utf-8?B?MXg2VUZwTEdIZTRlcTJueEVTYkszOWtmYnMySEE5YzF1MW1JeDNRTmdWRTBy?=
 =?utf-8?B?WmpBQm1RemY2SWtDRjRkTkk4YkhCKzF5ZlVkMEwrVGZ3TlJkbmNnd2ZRM0w3?=
 =?utf-8?B?bk9GQXNzTU9XMStIUVgvSS9TOGZoVDRyYi9QZmI5UHhTNXZOTnBkSVdzVUFN?=
 =?utf-8?B?dDhLTkkyVkN4YnlteENERklSMjZCUWo4U01kd0NaMUNLMWMyOW1lUUZrYzdk?=
 =?utf-8?B?ek5EQk5rSkpjVXQ5SmdWbEpjVVBIQ2hMd3EzN0FSSjQ1SHZKTldrUEJJMlZp?=
 =?utf-8?B?WDJUS0J2dDBzRE5zcGtVVlZXc2tEQUthN1QxaXZCV0JHWDFJQ0FNbU04clZD?=
 =?utf-8?B?eWRlYksvQzlESzlnQ1NVSU1NWVVIR2dROVZJSFNOZXV3U1pyNUQ5YVpxMWdp?=
 =?utf-8?B?SXhKd0EyWXR6SXpYVUZXOUd0cGdFRzBNcFZCNHAzWU9yc0JKWlk3UVpSY3Ja?=
 =?utf-8?B?VVVwL0FuSDFBWFkvcmp6Q0ZOYk9nNTNKRFhseERwZWt6cDFPVGlzSVNwNE5G?=
 =?utf-8?B?aTIyM1JJeGpNRHpjWThxZ2pBWC9VdzQvcmRvSXBQWVljaFhEMi9IQmwxZGc1?=
 =?utf-8?B?U3RKTi9tand4VGNJVG1tVzU4UnZ3UWs2RVhWeXZlUDJOTUVybUNON3VzVGh3?=
 =?utf-8?B?U3F4Y0hBNXVhQzlZQUlVUitIQVJKT0xzczFzN04vUnRaQld5K1I3dTl0L3Fs?=
 =?utf-8?B?Skt0UnliNkpCOWI1UENuN2pyNkRCTTA3c2hPR09oSlRtTzBVemU1cFJkdHNk?=
 =?utf-8?B?anh5RlpkREx1QW5YdFI2QW85SDZGZU5MNXBiR0o5VGxCMUYzc2dFSkJKSS9X?=
 =?utf-8?B?SFRxRk90YUFFQjFjeS9XczA4MlpHME1RWUVteGpJVTc0YTVOTGhUWmNuMVUr?=
 =?utf-8?B?eU5aM1Zwa0VRMXEvVjB4UDlsV3hsZEpOaXUvZ3Q4bTZ2K080bnBXVmg0Zjhx?=
 =?utf-8?B?ZzdZSlYrTitjZHZaZkZOdVl4bUhsSGJuMFcycnV3Rjc5cE5lNCtZU25mSmZI?=
 =?utf-8?B?WHZ1REhGUjZnalpjU1pxaUhxa1VPdGY3SjVtSXZveEtDR24wYlZSQ0N3aUx3?=
 =?utf-8?B?cGhlRkRmMWl1V3lYWlRYY2wxQ3FLZTc3K2VyenpaMS9ha2htVnA0NHNhU2tL?=
 =?utf-8?B?ZFhhTXpSZXp5aTZRbHFRU1hNOUVYY3pObkVSbG9FN2lKVVF3U0pWdHRCcDk0?=
 =?utf-8?B?eGRIbGhyLzFodDdjSFBiQUJrTlN1UmFmcS9uN1dYU0wrbW5VVjBnYWpyYk4z?=
 =?utf-8?B?NXZwWldnZk84dnYyOThiNDZ4R1VqK2hGazM4RHI3ZHBlU281MDNIRy94MTFJ?=
 =?utf-8?B?UGpuL2FxS0w1M2hHWjZoMmd1RFdkUG9hYU9KMEtkb3pmU2ZDTU1XMlVyT2Ra?=
 =?utf-8?B?OGFneDhseG02UTJuVVZHWW9jaUltRUdGK2tHUzJWWldXQ1FhNjVyYXk2R294?=
 =?utf-8?B?YXJSemZGMjIyY3NqVWdkcStuc0JYWTJlc3pCTmRmaWo1WHNPUE4wcW9GUSt4?=
 =?utf-8?B?QzU3MzlsNktsMHI5cGtkRWlha09nKzN5MzVSaTBBSDBtcDAyRE5mRUZVK3VF?=
 =?utf-8?B?c2xDQVlzaXYxWDhrMXNuckxFN3g1UjV4TVBZb3lZa1JlVFFjOGx4TTdDWVZD?=
 =?utf-8?B?WnNuRi9vdDhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHNiUm9QZXRkM21waVdtYWJtamlMRXN0TjVINXNqa2JGeUcxVEh4ajNXT3Zo?=
 =?utf-8?B?UG90eGluSURzUEpXREhubzdlckJDWWdCWkd5bGxCVS94WDhBMndxTUwrS3JW?=
 =?utf-8?B?ekhkQVBjQWNpRmYwdjJia2JZa3RjN3I3Wm1veHV1MC9zOUtMNEpyNVZwMkM4?=
 =?utf-8?B?UTJOR000ODR4NGExKzdtR3V3VjdlZ0dsV3BwMTdhUDh4bE50dC9UVjhpaFJz?=
 =?utf-8?B?ZnhIYVRwditCSzRjNENlbjIrV1dQYy94TWdkK1lxYjVHeDFpVjAyQitMSHZx?=
 =?utf-8?B?aEljVDJxMHduYzJ5cXlrcTV6enY4TFJEejFiR1ZvSm11K2RtQWFTd1F5NE9v?=
 =?utf-8?B?Z2RaeFA0SzEwM2x0d0x4NDR2c3hkTlBrbDVPcTJFdDZ3Rk5BcFdvb3I2ZVhT?=
 =?utf-8?B?TUhvOGowcGZ2cno1Ujk2SnNwQmtocHhsMitwR3VYSi9JbEtHNXA2YkhSZFBR?=
 =?utf-8?B?dDRpSFU1UnE1VlF1QXg4ZCtXVlg2R2tBQy9qcytoTUtxTWNWb0E0OSsvN2Ro?=
 =?utf-8?B?eXYrT2oxWDdkdHM2VTNJdDNZWjZOOUxGOEExUVhJZmdDOS9Nbk1YVDE4QVB6?=
 =?utf-8?B?K01WUWlJUkk0VUJvR0R2b0RrbGJGaWFHRnExcVBuY0JUbnBqUHVQS0FWbGJC?=
 =?utf-8?B?aHhMcGpUODI2K3Z1OVozMXMraTNlWHdKSmRjSW9tNHdoSWVZU3YwVGhYUEVK?=
 =?utf-8?B?bm54MXJVcjdRMVhQdUpyNUpIekdaZWM1ZWxPSXl3dUdOUHRSd3BqVDNNcFBZ?=
 =?utf-8?B?dDhudTczU1J4V3A3a2p4RFM3bjF2SHJ1QWxmZHhwMzRCam5lMGVBWDd6dUZl?=
 =?utf-8?B?ektrR2thd2svUGhkU3FoZlJOYkEzUDY4bmYrOUE2MElRR2VDRGVEMUQzTEFy?=
 =?utf-8?B?SjRicHVWQ2Y1dHdtby95dUhnckZBUXFrYUlPOWtTaEdOLzZ3OHhoRmI2ZUQr?=
 =?utf-8?B?ejNVbk9DOWdVUGJKa2JJS25yMWZGZzBHdXYra3JjOGlPRHMxbmJTVS9oZnM4?=
 =?utf-8?B?R2RxV2tnTWZaeWdpd1A3ams2SHJmb0VSRHN0NXowSG5mNDQ3TDdKaldnMS9I?=
 =?utf-8?B?TFlDZE1TS2hXVXpGV0tQeXR3Ris1eW5yeTJ0cXY2YTZNTVNUSU4zamNOTi93?=
 =?utf-8?B?S2YzQ1YrOWFEVFJIRkpsSG12NVd2cnpLWmtHaWx1WUszZHFRcnl4L0k2U2dk?=
 =?utf-8?B?L095RDM3eDByNzZWc3EvZHArNmdwSkIvdG8vRXlKc0ZvcVo1K0RrSjNFcDB1?=
 =?utf-8?B?a2xvUi93S1JwV3pXaTEydFFtcll0cGxnSkJZdTFDMXdaT0pUalV4cnVQVTlW?=
 =?utf-8?B?ZDJSSmplTzVhUS9JM0pVeVhSQzJhNkRZK3gzMlUvWW9vTzZMZGdSY3dHYStL?=
 =?utf-8?B?Ykg1c1JyTU1aWURxZUtmRkp1cVZUS3VPY1ZMYWk5emRWVGFaR3VCaXJydDJS?=
 =?utf-8?B?a1JIVFRlTE00eHZCM1JUNjloc1g4OXQ2SXR5enppU3F5cFB0bnUrY0h5SHdN?=
 =?utf-8?B?SDJ5Mmg5VEQ1aDQrRmIvYnE3ZDdXU1FmcGdWbnlnVVl2Y3hGNE0yVlZHa0hw?=
 =?utf-8?B?V3JOeXpaeHFybmR0WGg2dS9ueFo4QXhlNEdxaTZsWmdkZ0cyenB0UGY2aTdl?=
 =?utf-8?B?NWNjdWorUit1K00vSERHL0RqNkloTUgyajJGYWEvUjl2dzl5Y2xXZnNlVGg4?=
 =?utf-8?B?dnhsd0hCR0pPcTF3ODlvK3FGNjdIVXhoTzJwRGM1cTVoYzlsbkJQMk1SQTZ1?=
 =?utf-8?B?c2pHaFVOaUMxMnJzcHRZNVRCNGF0VVcvdUNxM0hYZmduUzJmaDM3azI0ZkNu?=
 =?utf-8?B?a0FoMmRvRXVKQW5zcW5DV1VJZGNVSzUrNEtQVDlQcTJEeDJwTEZmdXpKUUQ5?=
 =?utf-8?B?K0h0SWFYbEJlZzYxRzhDb0JWRDEwa2VWZWNmNTZnMUlNUGZuM3E5bTNMSEQr?=
 =?utf-8?B?VE4rdWlGNVFPUkJEODJsdjNFazVqUHpwcW9mRFYyZlZtOUcycU95cXErQXF5?=
 =?utf-8?B?U2w3T1E5aGpDZFVmSzFFQnVZYllvb1l4enUycHZXeThTY2JsNERCdjV5bXhu?=
 =?utf-8?B?SUo3L3k5MnhUOUdHSEI2eDBqRndPbDhCL1R4SHJ6c2Zyb1BzSTVjS1FCZjZz?=
 =?utf-8?Q?CBHwSJzbjvMlvze96sIHjmi5Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55e760d-5090-4a9d-5d67-08ddaf118abc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:13:23.5073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gpcruw/BmJ2WNn/lwWjd5Jv0JrJIskGpevieVrYiydHXmUfI56UQ2r8s4IArnvhwYLq6PlAiosFl9nKMbNZzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888
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

From: Peng Fan <peng.fan@nxp.com>

Define image array and GUID
Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 21 +++++++++++++++++++++
 configs/imx93_11x11_evk_defconfig     | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index c9171df330e2ffe519807b5f04ec2b7bdadf84f9..d84d56be5e1f863d50cb1a832040acf009f011ff 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -4,6 +4,7 @@
  */
 
 #include <env.h>
+#include <efi_loader.h>
 #include <init.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -28,6 +29,26 @@ static iomux_v3_cfg_t const uart_pads[] = {
 	MX93_PAD_UART1_TXD__LPUART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \
+		 0x2a, 0x44, 0x8e, 0xda, 0x6f, 0x21)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX93-11X11-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=flash-bin raw 0 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 int board_early_init_f(void)
 {
 	imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads));
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 16596a89d60930a0bd906a955d218fa1b096513a..98f6bc2390ca1c42caf6af8b843d3dc94dc25856 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -26,6 +26,12 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
@@ -51,6 +57,7 @@ CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_CPU=y
 CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
@@ -60,9 +67,11 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
@@ -89,10 +98,12 @@ CONFIG_ADC=y
 CONFIG_ADC_IMX93=y
 CONFIG_SPL_CLK_IMX93=y
 CONFIG_CLK_IMX93=y
+CONFIG_DFU_MMC=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
@@ -122,9 +133,12 @@ CONFIG_FSL_LPUART=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
+CONFIG_SHA384=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
 CONFIG_UTHREAD=y

-- 
2.35.3

