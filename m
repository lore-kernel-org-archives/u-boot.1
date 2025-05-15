Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62F1C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C4982B7C;
	Thu, 15 May 2025 13:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ChaUn7fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDD9082B97; Thu, 15 May 2025 13:57:36 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0ABF8006D
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/Mhlr6Q4PQEDkxVgS+yThF4necA98Sgj3Yzs5zGhHZRK2XeQ/nBN8SKTYMm75mHkV580G4696MKbYov1ZdyMO3FlkAmBs+W7L9agZ8qKAtAz14R1+77xRP8aTtdmDVM8AN/UNLc+AD3Fxi3oCgtjDI1/e3KaU0/T6ki28F3wooRjkfg4QtWMTYVd9m/MjPpYk8grVQtxrxJddqQLpOn2vEE78kTRr+gzJh/1mwR485dIk7+f4wbofJTacACRf2EZUYTzDt1Rdo1IA3T85vehzeMQpN7qtSAKtDSIkNbFxqSUwG0AgjL0RFWuUkBWfgOS4q5ieiskoLnaDFtu1+O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CtsgL+3GGDew68rQ0lCarBjvBXB/34TWXDTP14KiJs=;
 b=hbLxKstkD41xTmekBtMIkfkzQTSJblDvX9CuGZbkLRni0qILW/xYEgxj1EofB5lWY8MrQ0uuHyJ9kB1W2x2I39bGBPmvatnzVH7U0XzmnQ+T6vsV6sno3PODdktnYsyg5zPJOFk3p8Shmm0ntVXdJd5PMNzoleG1XkWYa8NDkAL7NAL5jTNbgKACQSnKr7yeOIAwOHxS6Op0ntL19lj4AIeDnbvYmm5Z/kE9tgviPXEk+i6qJppqItbQVGTqUpB2LCGWgqoDqqWbxPSy91QGKHakRfA+a1MgeaZsWnit4RtlPyp0j3CYUXDWklbEv9dUkxIi2PSj25XYJZR3/Pl6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CtsgL+3GGDew68rQ0lCarBjvBXB/34TWXDTP14KiJs=;
 b=ChaUn7fyxFJ8s3ygsxZAz3T1dIszpx1/9+MVIJQY3UKJEvAb22I1JoeKKHhLzDeUoFu8HHVmFzlsPdHtrT4U9fvO7QmDgVgX+m7GNjSSZctNB3/jaqDdl9UTTwo9RLEILOAEmJvQ8VCmJeHpOUKqiRWVRY37AIf9mg+THCLysyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 11:57:33 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 11:57:33 +0000
Message-ID: <92941db3-5cc9-40df-8da6-7ed41612f5ed@cherry.de>
Date: Thu, 15 May 2025 13:57:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com
References: <20250512115028.1783305-1-m-shah@ti.com>
 <20250512115028.1783305-2-m-shah@ti.com>
 <a3940636-92c2-4b7e-abe2-8357580c9f48@cherry.de>
 <f25f3091-43f1-45e0-b5b3-6c35989554cd@ti.com>
 <b95911a4-bb5e-4b36-ba6d-0f57dc0a06e3@cherry.de>
 <2eadc7f4-e314-4540-9740-9baf5dc9f61a@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <2eadc7f4-e314-4540-9740-9baf5dc9f61a@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4430df-4447-4320-e9e6-08dd93a7ad29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDMyUmVBYVpOaUpKVEdVWGtFTytlQjEway9lbk5TZXpYaExLYmxwQ0lYTDQy?=
 =?utf-8?B?M1lPa1lwaHdza1ZDdjNJdklGb1RIZ29Td0h3NDAvaEp2V1Bsb0JwbGNsSHh0?=
 =?utf-8?B?LzJhTlYwZm4wai90cVRjSmorWGdRNW5oWlVEcjY0cjRXbUhIWXRnalI5aFAr?=
 =?utf-8?B?QVN0bVM4aityVXlFRnBzMDBkQ0xoQzhJU0kwVDgrc3JPdjdNOS9BY1h5Tjkw?=
 =?utf-8?B?U09jU3VJRktjV2RjeHpUVnd5VGtGcXliQ05vbnU1K2hHSnE2QWUra2NBU01K?=
 =?utf-8?B?VU1rUWZIVmY3R29mVzRFYTZ2OFI0dllVUVZERklHcmhYc2RyZUF3UUwwMGFB?=
 =?utf-8?B?cTBGbWFIYzdWbS93b2tiekZJalBiMkdUZHJYKzFta2hSQksyRjBOVHVvMmVD?=
 =?utf-8?B?VDNLbG9CY2NkVklTMmxYSVRqWGh4SDhaSEVMNi95VHhvTk01NDFNUHkvalVG?=
 =?utf-8?B?SGk1czR2eW5wQWhqU3lzNE1aSVhITmdYSFBpYUs1N1VOV0ZMZEl5L2hRbWNC?=
 =?utf-8?B?S1VGNWFyUHlZRkp4Q0xzd24rbTF2My9HaDEycTMrbzdtWi8xMTJwLzVzaGlM?=
 =?utf-8?B?aEw2ZWozM2dMT3hPdFBRRncybTdUK3VWRWtBeCtDdW01OVNOak9ZaFJtRkpI?=
 =?utf-8?B?cXhROHVBVkVZbUNSNlg5bXFpL2I1MFNUUTkzT25xMXg2cDY3UHAvRlpJNjdE?=
 =?utf-8?B?cG1ITVBvN0h5c0g2TlJ0NVhIS1JmbE8vd1RZSmozTkVaNVVyZXBlK1YrWHFa?=
 =?utf-8?B?Ly9JU0lwaVh2VmlTSGFDcEdmMmc5UUxlcUp2UGRQQlZ4R1Z0UnFRdU5iNUdC?=
 =?utf-8?B?UlM3Rk40MXhxRXVqZGcxTnJVN3ZPWUEvNWFMK2RnNDZmL0lIODAxa1pOUW42?=
 =?utf-8?B?aUQyd1NCRDBYL05TL3hsWVpqUUw2UjZYY2NIRjBrWUgrR2pFU2RnSWIwZlRR?=
 =?utf-8?B?N1hLOFAybmVCRlZ5elRUMjlSdVovWmI4QjAwVlllRXA3L1pjYWhDUGdRSXZW?=
 =?utf-8?B?Y2Y1V1lxSmlRSzBYVVNNTi9tOFVBMlRYYnN5cmtMZzh3ODFoeDNtWk9LM3F0?=
 =?utf-8?B?TUxiUG1aSjJDMjhXa2dkQkg0aWdxOHZOUlZZaTU0TE5KZDJnRndlcTdlVXZa?=
 =?utf-8?B?MVJkVjlmOENSVWprU09LRUZ6QmhRMTQ3dUFDY0tIR1NFVUlkblBtak8yWnNK?=
 =?utf-8?B?TEdvdCs2ckFmYUNUc3RRZ05iZHpaY3pWTStWYjI1WmFxVjNNbGhpYzFVSk4w?=
 =?utf-8?B?Kzc5VEdwVm9pQ1FxbDEvd2tuT3ZsSHdjR05Rd1BLNmRKa0EzS29oNGprMEdE?=
 =?utf-8?B?d08xQkRBWnQrSks2RTltcE5URStrN1VQOTE2TVFQekdGRjA0aUt3eWNtcDJq?=
 =?utf-8?B?Q01xZE9ZRXhUazE0ME1RcWZrWkVLQ1VqQzhQamk1SEZoWVVwVHNxMEpWRE5l?=
 =?utf-8?B?WWJiTFNoZ0JVaGR3ZFNlSXk3TjlyRWJwZ2xZakE2OEtlQ1dSZ0p1MVJiRGdB?=
 =?utf-8?B?UUZ3b1Rqam5Sa2RaSkQ3VkZ1aUNIdDlYNmhMRjlMWjJERnNlaTVTQUdrZmlj?=
 =?utf-8?B?MnpwZjVZbk5JbTRleU9SbVFIeTZ4cHc3WDR0T29nS1UyT2pnUVp1TXlJdFhk?=
 =?utf-8?B?ZlQ0RW4wUFdJTFdEbmUzSWtVNDVvbkxYeHVkNUtxNy8rQ3lsK1Q2S2RIMHpZ?=
 =?utf-8?B?eWVjUkc1YzFiRkRmR0N4VDJrejBEMGtqUFMyY29KNFF3WXdNR2JrZlBFZ0oy?=
 =?utf-8?B?c3RhNHlQeHl0RDN6ZnBoNkh6dzlKSnVPRkJ4eXlvb3VEMDc0UCtUa1g5cmZp?=
 =?utf-8?B?RU9PN0YxRFIvbnJkMXZ2cVlzYzAvSXhzN1gyM1NuTU4yNUw1WDRBZCtUc1c3?=
 =?utf-8?B?U0htU1IxRkhBS0tMUnp6SDlpWVpQNmJ6N0pwUFJCUnBNOFVkcnpRbHV0TjZh?=
 =?utf-8?Q?6sK9KagoDdg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFR2Zmd2Q2Z3Tm16NHR4QytDUEN6T2pNamZ0VjdLcjhvSkRNYTlFM3RSTVI2?=
 =?utf-8?B?Z3BhN2VleDBTL3dmam82ZW9ISkFtZmJsWmdZNXR6bnlwcGxLc3V4UW9KS0w0?=
 =?utf-8?B?b3A1M013RjVUK2VVNWxLWmYwbkJpZGtaM01DTWcrU2k2N2hONHVZWUVVNGov?=
 =?utf-8?B?Zzl3ak5LL05hWDNEOXRlaWdjK0MzVWt3TXBXZDRHM0VrKzZGRWxNVCtCakEy?=
 =?utf-8?B?SmlXd01HZ0VET3VNR2tOSThBU3FvejR5MWwrV2RkVElWOWREbE5tbnMyMEJy?=
 =?utf-8?B?T2JIazlPdVYwQWxiZDZBK0orb1VGLzdSN0NodjByTEhMUEcxMmdlTG5EV1VR?=
 =?utf-8?B?MUJpdDVQT1dpMXBFNXdmVEUzVEU1R1N6M1hDS095TkRKeTZkS2MzSmx5alZE?=
 =?utf-8?B?a3ZISGY2b0hlRkI3aDV2Smt5YzV6OXR2alBSSU8xR0l6c0VkRjlPSE14bTI2?=
 =?utf-8?B?THdjSHhxcE9nUDlBcjVKbnUreUpVTDJOckdNeEpSNFdnMklaYUovT2d0c09x?=
 =?utf-8?B?RDRNNmZqTFdycjVrdGYrTFZZb2dHZUZNRVBjb3B1SGtwRkJSVFdMQ1RhaWQ1?=
 =?utf-8?B?YWdBRXYvNzFLRjIrMGJ6MnA2MTdydEZCdEVnckQwR29Ua3RySnFyNVJBWDU5?=
 =?utf-8?B?TnJvRzRkMU5Lc2JFVFduYml0b29salRuUTdnWGYvYVhBQXJ2ZlR2bkJiYWEz?=
 =?utf-8?B?bmp4ejBrWWZXTy8zMUFvcGREdmhZTmFvT29SVUIrUzdaY0svcDN1eEVVUUlw?=
 =?utf-8?B?TnV4VUtjQnBMUnZ6NXptamJYL0RBVmVwM1JzdWg2Tk9RdkM4K3czTlNFbCtH?=
 =?utf-8?B?TGc2OXRoSnZXYktyckRMQzdrOGNua2R3MFBJSm90bTNpK0tzai9KcitheVJo?=
 =?utf-8?B?ZSt2NWVoTTRIc1FUWjZ6VWhrOTdVc3cxbVJ4NTAzY3lydlVpbGtZY0JZZFVU?=
 =?utf-8?B?MUpaUHQwZ1drWlVwTFoxM3hJOTYwMEE3R2o4YVdZYmJuOWZ1WGlWdVhlY09q?=
 =?utf-8?B?SUpuTXdhTlR6b1dlY3FhclZpYVVYaXBIVTlwdHdDZVFKUmJpYUJKZ3VsbWhJ?=
 =?utf-8?B?QlZ5YnoxNkFyYmhNR3JTTTAySVlBblVPN3RvcHVveHFNaWk4RVJYYWVzMVcx?=
 =?utf-8?B?dkJtYVV3ZFJzY3hCYm9TNFF2dlRZbExXck5tQ2tPQks3emc5NTlCWGZEazNM?=
 =?utf-8?B?MHFSNXJ0b3BOVHFjd29FT1B0V01teWpscGhaTFViZU1PVitBUTJPbXFZMnpL?=
 =?utf-8?B?NnlBS2txaHQ0TnZpdzZ3eGcxaWlSSUl1SEhaTFZjc0J6elRTeWVuVjNGcWpW?=
 =?utf-8?B?RUN6SVRJOU1paGxGTndleVV2WVpqSlRHckNKSVh5ZXZYSVk4U0ROWmFyRS96?=
 =?utf-8?B?VEQ2OHkwcFVQWUxEVEtsUFBoUktSTnZaQlh2eTFKU2pBdk10TkRzMDhFZngr?=
 =?utf-8?B?Y0VLREZxS3cwSVc3OEVaN05ERUdqOFhsZ0NiVmNOb1pGd2ZPNGVBQ2tWUFZP?=
 =?utf-8?B?cTNycGF6L1dxb3ZDOGlkOHphRjc5YWVkSjlzb3Z6M2VMbk1BaFJjRDBic0Uv?=
 =?utf-8?B?c2YwUFM4TVFlYkdUSmNkNTdSZUZmR1o5ZzFmZndpdnBlK1VYbmR5TmNZeW1t?=
 =?utf-8?B?amVtZExrcWJPbVhXTldrMklkODd5NlB4eGJCRWlRR0lJZWw5aW1mNzRKeFdx?=
 =?utf-8?B?WHFwRDVRMmR3Ym04WDdDUDhpdnVUM1ZmWDJZS1MrRzg3T2R4amFiOTNvNzYr?=
 =?utf-8?B?c1BMQUdSeUxUSE9jeUdLUDJ4djRycm10NXo2cFRFNGdnald2dWV4aFpSeW9X?=
 =?utf-8?B?MVZzVnJFWXI2ZTdUbUkrNzhOZlB0MWhSOUxhcXBMOGpDdnZUNUs1MlNKZTVM?=
 =?utf-8?B?cjRRSklBdkxJT1IwUFBwR3ZvbjIwczROS0Zaa09KRGg2SXBVZnJhVFlCWHlu?=
 =?utf-8?B?cVRvOXA0ZUliMHdBT0VaNk5qcC9ueG5VWk41ZkY3SmFSUEg0eXJoNzJ2QU9X?=
 =?utf-8?B?NVFtbW9FeTVCanQzRE90aEZoOXoxM0tTZ0dzM3RZUHhjNDFIMHFnSVZ6MFJ6?=
 =?utf-8?B?U0pHZkJ2NVRiQm85WDdKdjc1S0p6NkZpWFFXckdNZFM2L0hyZkJJYTdCbXpI?=
 =?utf-8?B?TjdlRERPSEJ4NUFsdXRySi96NnYrNTFnT2NzVDZTc3NpOGJpcHZLTmdGSUF5?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4430df-4447-4320-e9e6-08dd93a7ad29
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:57:33.1749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vIdhDNV/EbkSbZ6rFjLhv7jeGXFaH0BWIAQjQtZekIDao9kqKApKNkahObsVxfZbXGdDNH+oOHuy6Bu4uNeq/njM3M4y+LROFeH7RrvyNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
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

Hi Moteen,

On 5/15/25 11:01 AM, Moteen Shah wrote:
> Hey Quentin,
> 
> On 14/05/25 21:42, Quentin Schulz wrote:
>> Hi Moteen,
>>
>> On 5/14/25 8:05 AM, Moteen Shah wrote:
>>> Hey Quentin,
>>> Thanks for the review.
>>>
>>> On 13/05/25 16:10, Quentin Schulz wrote:
>>>> Hi Moteen,
>>>>
>>>> On 5/12/25 1:50 PM, Moteen Shah wrote:
>>>>> Add a function to scan through all the nodes in the device-tree
>>>>> for bootph-* property. If found, propagate it to all of its parent
>>>>
>>>> It's not scanning for bootph-* properties. It's scanning for two 
>>>> specific bootph properties, so try to update the commit log and 
>>>> comments so it's not misleading.
>>>>
>>>
>>> I will update the commit message in the revision.
>>>
>>>> The commit log is lacking information as to why we need to do this, 
>>>> what this helps with and why this is specific to bootph-all and 
>>>> bootph-some-ram.
>>>
>>>  > Why this is specific to bootph-all and bootph-some-ram
>>>
>>> The other ones are handled by fdtgrep as those are for the SPL stage.
>>>
>>
>> Yup, the issue is that the non-proper stages do not actually read the 
>> bootph nodes as they are stripped by fdtgrep. The DTB for the stage is 
>> of everything relevant to the stage, without the bootph nodes. This is 
>> done to save precious space (instead of having a full DTB with 
>> appropriate bootph nodes, we only keep the bootph nodes and we strip 
>> the bootph properties from them as they are now implied). However, the 
>> proper stage (and specifically the pre-relocation part of the proper 
>> stage) uses the full DTB, with bootph properties. So we need to 
>> propagate them so that pre-relocation works as expected since it'll 
>> check whether bootph-all/bootph-some-ram property is part of the node 
>> before probing the device.
>>
>> [...]
>>
>>>>> +    Args:
>>>>> +        node (fdt.Node): Node to propagate the property to
>>>>
>>>> Specify that all its parents (recursively) will have this property 
>>>> propagated to.
>>>
>>> It is iterative not recursive. How about: "Node and all its parent 
>>> nodes above it to propagate the property to iteratively"
>>>
>>
>> Mmmm, true, I had in mind that recursive also works for defining 
>> "parent of parent" and "parent of parent of parent", etc, but it 
>> really seems the term is specific to recursion, which we don't use here.
>>
>> Can suggest something like:
>>
>> Node to propagate the property to. Its parents (and their parents, and 
>> so on until the root node) are also propagated the property.
>>
>> [...]
>>
>>>>> +    changed = False
>>>>> +    for prop in bootph_prop:
>>>>> +        if prop in node.props:
>>>>> +            changed |= propagate_bootph(node.parent, prop)
>>>>> +
>>>>> +    for subnode in node.subnodes:
>>>>> +        changed |= scan_and_prop_bootph(subnode)
>>>>> +    return changed
>>>>> +
>>>>
>>>> I have a gut feeling this is suboptimal, though simple and easy to 
>>>> maintain.
>>>> We currently go up to the root node for each and every found bootph- 
>>>> {all,some-ram} property. We could simply divide this by half (or 
>>>> more if there are more properties to propagate in the future) by 
>>>> passing the props to propagate instead of just one. We can keep 
>>>> track of which node has propagated the property already and, for its 
>>>> children, stop the propagation at that level instead of going up to 
>>>> the root node all the time. I'm not sure typical Device Trees are 
>>>> deep enough for us to care about that kind of optimization for now, 
>>>> especially since it'll be running at build time only?
>>>>
>>>
>>>  > passing the props to propagate instead of just one
>>>
>>> Since we are only concerned with the post SPL stage with this patch 
>>> since the SPL stages are handled by fdtgrep, I am not sure if adding 
>>> this optimization would result in gains assuming that bootph-all is 
>>> the superset of all bootph-* properties(this patch concerns only with 
>>> some- ram and all) and adding anything with bootph-all in the same 
>>> node will be redundant?
>>>
>>
>> Something like: (not tested)
>>
>> def propagate_bootph(node, props):
>>     changed = False
>>     while node:
>>         to_write = props - set(node.props)
>>         for prop in to_write:
>>             node.AddEmptyProp(prop, 0)
>>             changed = True
>>         node = node.parent
>>     return changed
>>
>> def scan_and_prop_bootph(node):
>>     bootph_prop = {'bootph-all', 'bootph-some-ram'}
>>
>>     changed = False
>>     to_propagate = bootph_prop & set(node.props)
>>     if to_propagate:
>>         changed |= propagate_bootph(node.parent, to_propagate)
>> [...]
> 
> Thanks for the pseudo code, question on this again, can a node have 
> bootph-all and bootph-some-ram together which we would require to 
> propagate together. In my understanding having both of these property in 
> the same node present will be a redundancy, and searching in current 
> tree as well, I found no such examples of both the properties being used 
> in the same node. If in future we are planning to add more bootph* 
> properties in the proper stage(pre-relocation) this change does makes 

By definition, bootph-all covers all stages so must cover 
bootph-some-ram. It doesn't make sense to have both bootph-some-ram and 
bootph-all, but I guess it could happen. That could also be another 
optimization, only look for bootph-some-ram if bootph-all wasn't found, 
otherwise simply propagate bootph-all and skip propagating 
bootph-some-ram for this node.

> sense. Let me know if I should add this in my next revision.
> 

I think your implementation is fine albeit *maybe* not optimized. But 
this is a host tool and I don't think that small optimization is going 
to matter. So up to you, whatever you are more comfortable with!

Cheers,
Quentin
