Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E98D79741
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 05:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F8484535;
	Sat, 31 Jan 2026 06:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FoyOAuWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B5B8456B; Sat, 31 Jan 2026 06:52:54 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253B0844F1
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 06:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEYYyQhgSe/RaoVDTQprQkpzI/G+/smJnpGQljYp6HgrpB/kjgJkFk/eZHxgAdBeiXbNA/LyjF1IjCmk+itV0YZHUhcAMMuTcfRCkAl02+5j+SnSKsb15CMJv4VDzyY06zjfMJpTIR1yi+gNiZaUvabPH6wv/U18GnzhYpT9+xtAYnLp7I+UZSTwtOG146fLKEkmDCVyIGAFDBUoJw8lnCkNjpocFVGspB5mTWMw42PYxVGlUtgIUeP6sbkAIPk5y44MyR0Vx5uDrRSYBgm1ls2dzYcxZ1JX9qn1MN8cepP8RlcCkDAiCkEpX8oBMxnu1r21cS+QOWyJ4ThBxW+3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP3MZfmiMpNy5k1Q/sE7BxNUlfMS4PNfSrZu9Srn2Yc=;
 b=LXuW3d0hZd+T9+ilUv40twbPK6SQ4IEDXcOB61mr3e4YU53sI9GtgbRtzvYWNqyCWSL6HBaaCHT1kMKZsNwh4cHsBnwbfO71NJj91VXwgkPS1yskf+I9f3tRK3YDvUaBNkIK7bs7DDXM2bx5wH4BMLnQwxI72lZieSAkitiHg3QCbWUCBz4cJhN66cGduledZn3eMWZM5Fkz/q2lPsujr0A9UHYiqBaji+JUeYDEOh3TIVsi+pIC28IuhSX++FCyqC460xXPZxsMqH9z+CHQ4tzeiqJioZBV9nTwkh1+wQJiNzQulhM0JNC0vmrDgBK7xTN83eGKYYuabmdqEvuL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP3MZfmiMpNy5k1Q/sE7BxNUlfMS4PNfSrZu9Srn2Yc=;
 b=FoyOAuWGAFtOssNQbjqsIS6UcyujqvHJqaoWFJm8oBEJO+T6LPQ10zYXUSgSAgnXSeq52OUpaZv0DgFmvdnpLUpr1uQxhPiDNdkK/gIXCQq5va944KCscMvcO62CaLgpi1tNw5WYKHMUdzIGmWfQRKGfecMggt2c8yzHfiohmgLwFqaV0cwHzcMnuzcYTwejDv7zBiStB5tBjdT3HSSeI2uYN2mOD5sm+3OwrIHxcO+UwGGcIXXdhEKZgyMRX7t7fzsLyeHuROyyz+T01nchSH/LmwYx+KlrN6HM1cL/m7Jz8y1TCdv0H2oCS+eUtlBA4QfXaCdSpGh04EU2d0Znlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by VI0PR08MB11327.eurprd08.prod.outlook.com (2603:10a6:800:303::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Sat, 31 Jan
 2026 05:52:48 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Sat, 31 Jan 2026
 05:52:48 +0000
Message-ID: <4bb53678-6bb1-4cbd-9b84-d467058bcf5f@iopsys.eu>
Date: Sat, 31 Jan 2026 08:52:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mtd: mtdpart: fix partitions searching
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Kever Yang
 <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119223305.3022690-4-mikhail.kshevetskiy@iopsys.eu>
 <1f31b62c-6e54-4dc9-a5e0-1f9c4cc6f5e7@cherry.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <1f31b62c-6e54-4dc9-a5e0-1f9c4cc6f5e7@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::12) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|VI0PR08MB11327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9823dfa9-8dce-4bff-698b-08de608cf685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFRXeDdDKzJqMTFZZzBKb2E5d0ZFNWhSL2dENWxnenppNWd2UWptWXRrd0FB?=
 =?utf-8?B?T1hRSTJzUE5rVXpOUnY2Nkl6eFZaenVxZ1R2czFyWlpzY0kwWUxoTkpTdTJZ?=
 =?utf-8?B?WGtQL2tFeDQ5aWYzQVZ4MGpSZ05BUGdiZXdPOHhreG9CTDF5b0ZTdkcwcVQy?=
 =?utf-8?B?NEtLM2tjUjJ1WWVEd0JpQVNYc3dDWGt6Y2ZIYUdNb1o4OXgwelNJbkQ4Z1lL?=
 =?utf-8?B?ZlU4elNzT09sQitKQW1wKy82MHZGaDBHais3QTdmOS9vNExaVjduYnY5cTBM?=
 =?utf-8?B?dU1xbDJadjZCcEpmZFZtMEdYQWpHUDhIK1dSWkRKZUJRT0IyMmthRk5vVnJQ?=
 =?utf-8?B?THpPTzdIKzhmZkMrZnNaQ1VTN3NVTjNHNE1MUWUxWlVSeXZYZ0hKK01HM3RP?=
 =?utf-8?B?U0lxSVd5eEtxZ2ZPSzBlRGRCb3NuS1RBTlQrTDJOUmdFMkJLY2JDQjA2d3VW?=
 =?utf-8?B?VWdKTlpwRy9XcDgzeUhKVjVNVllWZUcvSDdxTFV6WCtpUzNia2VSdCt5T1lo?=
 =?utf-8?B?R3haV2svMlNWYysvOFhVVG9pY3hrUmRzeTZJbERiZWpQMmFaMVBUdDhWWlVp?=
 =?utf-8?B?aUUxVVgyakZHSXB2V1BTYzNxb1JiaWFua3lORmVrL3Y2N0FSd0ZWZW9GUXkr?=
 =?utf-8?B?WFJMaW5xUTZocGFITXpQVzFoSkk0SUQvTTN1YkdjdUplckFWUWoyNkZQdFZM?=
 =?utf-8?B?dFBnS2ViQkY0TnlKWUphN0l2ZEw3eWpQMHE3L1FVWGNyMDZZL1dvR2ZWWUtz?=
 =?utf-8?B?aDQ0VE5VM1F5b3VwcHRrYStaRnBUYTZVK0hDTk9HTHFtZGM1L2dIbnVrSVp2?=
 =?utf-8?B?UUVSL0FhZVNHNzhOYWx2TTBwM2hkMHpORU1sRXFoblBsWjB1TlpYZkN0SHA5?=
 =?utf-8?B?S2VET3UzelUzSHlKTTRGcWNNN1hRUkxiRE1pV2s3TVh0dUNHRGlPcFJOOUI3?=
 =?utf-8?B?TmxnZWZsaU5xZnBzcGp3enhoM0pIbUpZQ2kxRDhNaWpKeExxc3ZkRmF1ODNt?=
 =?utf-8?B?U0wwQzZocXk1NFl4VGRZTnZWOVZpL0tnMXk2KzRCalA1cGtJblIxLzc3bTRY?=
 =?utf-8?B?bGltQ2tDYVJCYlE1Lzd0ZXFqcktxcXNsYnRBUElYQ0E1MVIzOEsxVmF5UVZ0?=
 =?utf-8?B?MCt3NjhGaldReWJwa1pTRWNPUFlmMUxUWGJES3JIcHd1TUdaMFIyWW8ydG5m?=
 =?utf-8?B?UGMxWGZ1VHUxY04xdlE1S3pKeThSUWJIZUJ2ditkQXZxZElheEo0bnRiR2dv?=
 =?utf-8?B?amlyWVpZdjVleVhjUmxQVHM1aENXSzNNOWhUWlpMcDRPVHdHQmNPLy9LU3Ex?=
 =?utf-8?B?Skx3SXVDSk93YlcrNkJEckpmTW1aZVVEVk8zcXljbVJEWFVTOXN0MFpTNjFQ?=
 =?utf-8?B?dnZYckY2K1BuNEZLcUlTeDE3UzNGRFJWbGx5WUx5ODFLaVJWS2FSbkVMcEVT?=
 =?utf-8?B?aHBOcmhObVc5ZVBxR3QvRHRrcyt3azliUDlWdDhUWVdXR3pGc2t6VFk1VnFs?=
 =?utf-8?B?Vi9tUXZyK0FIS2puSjBRNkV5Yk11eXF1UDlxREVIZGxMeXUweUU4U2MrQ0JM?=
 =?utf-8?B?Q3pTRk5NdDhJUXdObG8vZXhtNEl1alJkQ1N4RVVUd2ltbUsvQ3pxdlM5dEZv?=
 =?utf-8?B?TTRZOEZJR3FlY091NzY4SVMvUmdZcHhLN3lDOWZsZnpqSm83NDNlVk02ZWl5?=
 =?utf-8?B?aWs4TnVVT3k1NUJmM05ZcTdtSkxVckZDdnVicmxiMkl6dFlqTFVIUUxvNU9Z?=
 =?utf-8?B?ckt3OGE2cVlUNXBMbTI3azdiakZMMFhaYmVVNVp4Um1WcVRadlZHaml5NXFo?=
 =?utf-8?B?aElQL0lvaDJaNlJ4U2hkdjR4YlF1RFBwSFNTbE1CVW84Q3l3dU9Db2R5V2Nv?=
 =?utf-8?B?dFFkWUNBTlZxQnFUUnVFK1BnRU5jcklXYU94M0VpYVFqR2NWSjRLL3ZFLzYy?=
 =?utf-8?B?RzhzbHNqSVU2N1lVUFNGUDJzUmZQVWx4RFVKa1lpUFlnTS9QWFZLYWgwdWth?=
 =?utf-8?B?UkN0dmttVEJMdEhyUk0rMmtoRHVUbCtJZHh3eWVQTE9tL1dvczU3eFc3SUda?=
 =?utf-8?B?ejNHVVVlcnFvdy8xOVdYOGRQeWQzUE0xaEE5M1hSb2Zqek4zcHpYQzEvZnFs?=
 =?utf-8?B?ZUlaaENTSVc2aE4yaGo2eTVuRmRyelIxVG9Ld2ZGVTQ3UytJdDNjT25yZXBY?=
 =?utf-8?Q?RjUb+idPCVcCefnW3dPhVNU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDg3ZWg5SHUrelhOQUZaRmhlVktJZkZFdnR0T0gzenNadHlFazMwbkt3ZFVQ?=
 =?utf-8?B?QUNkTlYvNGo4WUQwRWlIUVM5clBGNERramNIbm92RjU5OWVNM3hXWmJJZ1J4?=
 =?utf-8?B?NWNId1FoTGFDM2lPcVIzZjFJa3VUMGZOSEtTdURCa2xCN29ockdsbjVodVFU?=
 =?utf-8?B?cW9wS3Rid1lxd25DZk1CT0dSODhzQmFaTlRpSEwwUWFoT0ZZdTVaNTBuRWdu?=
 =?utf-8?B?aGdPNGZpQVRGaEIyVnRKREplTFozaDNvSDNJZDdsbzRiQVJ2ZnZhTW9iQ04x?=
 =?utf-8?B?U3N3cHpqYXArMkN0RFJoeElGSjQxSE9IRnhNa015QVFuNkJDNmdzV0JLNkNu?=
 =?utf-8?B?MGFYOWhQUmJFRTRhMDZrTENBVkJXSkdkVmMzTzZuSElzTUsvV0tGVHdTZHpI?=
 =?utf-8?B?L2UvY1A5Q1hrbFU5M0tLdkQrbU1zS01rWDFRVWxWNWRNQTg5OEpzZHl6YU40?=
 =?utf-8?B?RXhCR1JtUnVKMkpVaWZzeE9aT0JVUnNIeHh4aEJGQm9pT3lBWGhmRTFtZUpl?=
 =?utf-8?B?YXZRUTBQVklLZlltejMwV08xQkE0UnZIQUdQSmpwVU00eEQrZlBYQXAxRFpS?=
 =?utf-8?B?Zk9wVFczbEtueTRGZVo2dkJnV3VjS1huYUQyd2FhRDA3eUxWYkpsVHNBRUdI?=
 =?utf-8?B?TmpmOWdQTk94RTUrd0ZncEFiUzZ3elg3amhTWlJYcXRBaVJqbkZQYURMbERW?=
 =?utf-8?B?Rlo2YW9vTldpK0hXdGNudXlBcVBPZjVRMnFIR1JnSyt6REVSQzdyRzdtcFF1?=
 =?utf-8?B?RmI5S1RLVmFXdG5QcTg0cUF2WHdBQUpJNm9tZVVROU05amxkR2oxdGJZY0Y0?=
 =?utf-8?B?cFpCVklCU3IzQmhwc1MxU3gyaE9mbDU0dHppZTNWZ0k1L0VESCtDdGVWUzhQ?=
 =?utf-8?B?WUM1N2Y5V3J4U2RBaXhrMmp0OXZ4ckNWY3BXTU5iMnB0NVZTYzVJMTh5eWJa?=
 =?utf-8?B?b3V0bzMxTm43VjFPSGRGbGVSRngzRlVoRXd2VWw0UC9ieVVlUzhKUDlCUTh4?=
 =?utf-8?B?OE02eGxoaFE1QzU2MGl1Uk9sMThwTnFBUWpjempnRFhWejNCTGdmVmx6WHV6?=
 =?utf-8?B?WkpDUjF5WXBFMFpwN1hGa2MwYzlhaThSd2VHb2o2YUFOMENLdXJSVUFqOGxB?=
 =?utf-8?B?cVgzQmJsVEhkbnpFbTVSWlhBOS9MWjBWN0h0MDVtMUwrdnB5UWY2bk8vSDF2?=
 =?utf-8?B?TkZVM0s0TG9KV2dWSXFWdHJqeWZJTjJxdWtaUkpJOUpNUEdOTW9RTndpdUNC?=
 =?utf-8?B?R1ZFRFIyaFRxRXl1NVZrelFuSndmelNTMjBqSDlqUjdQMnpHYjN1WUN2WXpJ?=
 =?utf-8?B?aGtXMGlUV0FDbzRKeUFjQ0xQQ3k3bjladEZCTGJzU2Z1K3RtYmozQjN4WXpy?=
 =?utf-8?B?U21MWnRFcHg3RVVCbEtRczBMQjlrRWRoV2Y2MmdoakU3WnBJcVFIaFlzVmZr?=
 =?utf-8?B?R0tTdFVFZGJqTXc4UTZ4d1IyL2tac2YyWm9wQVZScEsvUmJMeW9tQW5iYVZo?=
 =?utf-8?B?MGVZY1o3Vk5sSjhiM2pHalpRd0Y4Wi90UXYzajBYVVR3NDBOY0RpTk5NYTZw?=
 =?utf-8?B?ZXQ1cG9ETFcxUXZxcGw5NnBqUXBlV2I4N1dDallvdmYvbW1NakpHdEM0VmpG?=
 =?utf-8?B?d1FrUndNRnBoRnRjbFMvVjVMeURxaWlCYW0vRXJZN1ZudUgrQjlRRFhpc0hI?=
 =?utf-8?B?RUlBTkRHK0VKRHcxN3daNG84STYxWmxSY0hHTXpHQVhud3l0K0NVRG9MZkpZ?=
 =?utf-8?B?TjNlZUM1Y0RDN2t6TVA1amRFNW9iQkZodHptaWRENW1lU1p4R2hmVG1WNkZO?=
 =?utf-8?B?VDNjakdFekVaWU9aMkJPdDFGY0hvRXh5LzdqU2NUcDQrOEpra0MzRFluS1FI?=
 =?utf-8?B?bnBHem5kSzNjSTcweEhNeDRPcXlRN0tHeE9pVXNnMURVeHJqTHpiSno0N0hr?=
 =?utf-8?B?WC8rdElZckhnTnVmS0ZBUTVhNE1pQ3ZvbXF4Z1RRcDNZdEFrWDA1clNxUk9h?=
 =?utf-8?B?RCtGQUJQVkxaaWZrdnprdnVPcFNvckNqV29kaGl2cUgrM3JhK0FaTis3cCtU?=
 =?utf-8?B?aGFrbFJkQ1p5QURVa1Fvc0lhYjhWV3hUaHJpU2lPQkp2RXYyTDB2aTBpRXlI?=
 =?utf-8?B?UnZEWnV1dFMzc2dRVHBoS3MxT0dVakYwdGFxQ0FtdzgrclQ2eTR1UGUyRnVM?=
 =?utf-8?B?QzMvTjlaTkliQjR3L0ZCcExZVUNxcFpGOE9yaTh0ZzZQVGhkeFA3NGczWkdT?=
 =?utf-8?B?MXo2bDlVY1FoQkJnV2xNL2lhWnlobmxMVzBteFlJV1Z0dGxHeTV3T0dMNlJR?=
 =?utf-8?B?OGcybkNFSGhBcTNNVi9wcjVBYVExRjFoMkVmWGZJU2J0OHB3cTVTK08rT3Bw?=
 =?utf-8?Q?nl3HHTI1RIIaZY+U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9823dfa9-8dce-4bff-698b-08de608cf685
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 05:52:48.1990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiMMyLSkkeE2T5NL5skndtxAqwY5GZOhYVo4gy8AweOZ8Yi5cm2JRxAJLVc4dQf0mIihsayUbbvdwCNi7CJmQlzSOndZpSI3l5qjOnJ0fqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11327
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


On 1/20/26 13:10, Quentin Schulz wrote:
> Hi Mikhail,
>
> On 1/19/26 11:33 PM, Mikhail Kshevetskiy wrote:
>> mtdpart internally enumerate partitions starting from zero, but
>> partition
>> driver API enumerate partitions starting from 1, so wrong partition will
>> be queried. This is wrong.
>>
>
> Are you sure this is the only place we need to fix that?
>
> Do mtd_parse_partitions, mtd_add_partition, mtd_del_partitions,
> add_mtd_partitions work as intended? They seem to also be using
> 0-starting indices... There's probably some mixing up between a device
> index (0-starting?) and a partition index (1-starting) I guess? 

Yes, I am pretty sure. 

The functions mtd_parse_partitions(), add_mtd_partitions()  and
mtd_free_parsed_partitions() are sused to parse mtd_parts string only
and not used in other places. They operates with temporary array,
removed by mtd_free_parsed_partitions() after the parsing was finished.
So no need to worry about them.

The functions mtd_add_partition() and mtd_del_partition() are linux only
defined. They are placed under

       #ifndef __UBOOT__
<https://elixir.bootlin.com/u-boot/v2026.01/C/ident/__UBOOT__>       #endif

condition, so does not compiles during U-Boot building.


>
> Would be nice if we could have some tests in test/ so that 1) we know
> it works as expected, 2) we avoid regressions in the future? 

Do you mean generic U_BOOT_PART_TYPE interface test or generic interface
test + special test for every available interface?

>
> Also in v2 you said not many devices do have both MTD_PARTITIONS and
> MTD_BLOCK enabled but I don't understand where MTD_BLOCK is required.
> Are we missing a symbol dependency somewhere? 
>
I think U_BOOT_PART_TYPE(mtd) interface should be conditionally compiled
if CONFIG_MTD_BLOCK is defined. As I can see this interface is needed
for commands like "part" and "read" , "write".

Without CONFIG_MTD_BLOCK we have

=> mtd list
List of MTD devices:
* spi-nand0
...
  - 0x000000000000-0x000010000000 : "spi-nand0"
      - 0x000000000000-0x000000100000 : "bl2"
      - 0x000000100000-0x000010000000 : "ubi"

so we have 2 MTD partitions: "bl2" and "ubi", but

=> part list mtd 0
=> read mtd 0#bl2 $loadaddr 0 2
** Bad device specification mtd 0#bl2 **
** Bad device specification mtd 0#bl2 **
Couldn't find partition mtd 0#bl2

means no MTD partition information can be used.

> Cheers,
> Quentin
