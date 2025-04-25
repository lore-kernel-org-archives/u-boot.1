Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DF9C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 08:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5E181F0B;
	Fri, 25 Apr 2025 10:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KPTUzKRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1460081F0D; Fri, 25 Apr 2025 10:56:52 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9422981E72
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 10:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrGSGImFZ4aahPFgkhO3WTa2exNjQwoSylZ8IdMGOS60aHVzGumBfnOmX2MvsQpRER+jdD4z1ZFy1t5Tvh9JMtVi63vrUZkIQedQ5yTXykwT/5tDAykL/Q36XjplVIdnFg0mh9fM5SR2VTuxmQbOKXxfY/1hEPavBkTLck5W1vHorI4vIRS48+tF4mm83oEK+4t98aPgDRFHSTMt5cNjmYcgpABqKRQEodMhonT4C0TA2uE6KOKHWuFlC7s5Y40KEvPWBX+CJm0v7wLnxfhZno5uHZHXHgE2wEt/2A+6d0rm26LQIkyRMKjJhyZ1fY0jHLB7eTW1hUTxB9NhU912nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XjQCtAJfYi7TOdcf6bPr1XLTTHGHZBoOlDyb1jptPQ=;
 b=CHLMSZW9JElNJwPAr1gXXSbFI5ZRrM5EAqu+0iSu33WlBuT4Qq2ovBTW6X/2c81PHaLTP6DhtfccoKhSXHZjUmujGMGVdHNy9MWXXUsa4qKjIbibMlhnBjjWnU63HoFFm/nphWtFnc0JWAKslRzINNkaZtQ7B3CnEZQSdrECeP4D/+krXYM2564rOZdEcyJ8zAzhBTelahb4vyN94H/86Whv+Um9hyVQvoFaFhgGNWHGv93iO2fpOeQf+/5pIJ4RHTzFW/aNJtZi2vnbIPaYJLt2D3Y7VL4L3t18WdB4e1sy5JM2GMVzJhtpPhroZyRPdA4qFGK+d6HDey9cr+smoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XjQCtAJfYi7TOdcf6bPr1XLTTHGHZBoOlDyb1jptPQ=;
 b=KPTUzKRjLOsO/cl4+FVBtTJdq1OUecPj30YWieluqF45SbV2iGtnsPZXDYUp3P3TK6pFUCsPsrg3wtX+xFmc4NX08ZC/a/4XPlEoEtTTQObZNHzOae2WxtzfUo3YdXadu+c9RDjlUImcgghEFte0U0MHJDigMw+GBBSv7FGgL7Pp+wLBeD4VXZpX6W5GSxLNVeebykRdt7P5qElqzmvi8tDooOZt/RK5idxYQcdqXH/hWlXpp6TtuDf0XR/DnG9obKYeUeU8cKxgZ8sQ1BLu82DkwoT1Vig3WWHQv5ja8sbbDNp27aSWmjwM4/kN9UFO/dgfLTHRfHYGUg80CgNPCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DU2P195MB2423.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:49f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 08:56:45 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8655.033; Fri, 25 Apr 2025
 08:56:45 +0000
Message-ID: <e591f95c-2209-4623-95bd-4de3f09e3ed3@phytec.de>
Date: Fri, 25 Apr 2025 11:56:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] power-domain: Enable uclass refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel.holland@sifive.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heiko Schocher <hs@denx.de>,
 Fabio Estevam <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0096.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::49) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DU2P195MB2423:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a9d5f5-21bb-4d4c-4da0-08dd83d71ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3laVjNSMTZDdjIxQ0l0OFkrRi9yemdGczF2UHFhckx0K2xyNU92WVp1VjVy?=
 =?utf-8?B?UVAraGNWVzF5UHlZVVZyK2t0SjkrR3RidlNxRVllMkc0UktteFFSQXFqZFNa?=
 =?utf-8?B?TCtid2MrYlBJVENucXFqTWNjejVJaTRPN0ZIWTdOMGJKL29rNTR2RlZxeW9N?=
 =?utf-8?B?US81SEJnZnpabE9zYlBnOFRaaU0wbVVoYUgxbkdGMnNjSytuZDZCY2d3ZW1v?=
 =?utf-8?B?T0hpRjdZQXJWazJyZ2l4VmVGWjg5a2ZURkhmM3I5d1ZaNjRvcDNqOFR6K2Yv?=
 =?utf-8?B?M0JpQ3c2VDZZZEx5cC9KUDkwRE5pdlZNR1ZjS2xBeUZXWThpMHUzdGsrVVoz?=
 =?utf-8?B?Q1BXUHFIbkQ4amh5VmZ0ZlBsMHhuYVRTenpHaFJFWmNPMG1xaDlXR0tRZFpM?=
 =?utf-8?B?c1RMdDhqZVFrSWNzR0RCNXV4Qm9sTERMSXAvR2RxWEN3bXNVUiszSjhhSkNX?=
 =?utf-8?B?eExDam1lMEVaNUJXc3pxdEJtbFIwVWpHQTJsZy9jWU9hOUIvcDJJUEVzZlVn?=
 =?utf-8?B?em8wQ2ljNlV3WU52RTJNN0E5czBpWWRFWmpuT296MGlhQWNsWHZuK0pJTUVO?=
 =?utf-8?B?VUM3b2pFc2FxNzFpNGprVllkc1BuVDYvdEJGbEhaSkpOazFFMUJWTDBRa0Ni?=
 =?utf-8?B?dlJKNzhhNmhnemYxNm5zVkFUVHVheVRpM3ZVSmpiaFdxVmpnSkVLVDJxcmVj?=
 =?utf-8?B?VHpLeHhkbE5RblFuTlJHUytlQlFQcmsyL3hiU2VZQ244MitxSVpOSmlKcHpn?=
 =?utf-8?B?elRtTk5pZFlReUU2d3BLZi9pYmlKZWVHN1JMVEkvL0xQdkh5MVpYcGhyZUsw?=
 =?utf-8?B?WHdBZXRWc3VBa1ZMbDBLN3lTOUcwbDRLWjJrWVFHcnpxNFplWkgrdTNkODV3?=
 =?utf-8?B?U0Rld21BWDFsS3VHaEJnNFVUaXNUZVpFb1Y2dmtSNHFHTk1zU2c3MUgwM2dW?=
 =?utf-8?B?U1ZyRWdZa0U0aUJQdjVXZzJhaUtGNklXRnJFRGFmaldMaU5aWkxjeDhXTDI5?=
 =?utf-8?B?dXg1bjRYb2pFWWhVMjFzSnRVOVBWTmZVR3ZJdHJjSFJKTC8wVEJoWlFQQU91?=
 =?utf-8?B?Z3VrS09ZOEEyM1VTZ2czeEN4RFQzdjNDaW5YSEVUOVloYzR3bUZWQzVPdXFi?=
 =?utf-8?B?cG41RkxlbE9jUW1BSzkrMDJSRllsYjBZY2xDQm9JOEFCcjBMZndpL3pObnYw?=
 =?utf-8?B?Y1NDYVpQQUF2QUxUK0w1enptMnI0Y1BDU2NkTVdCUWNyTE0wUkJWVTFVSy80?=
 =?utf-8?B?QUZOYVAzQllSL200ODFtS1J6Z2NEMS9lb0VXeGFHRkZIN0JQYVBiSnpzNHRD?=
 =?utf-8?B?Rzk2SzYyZFJLRVlkU2tINkttbm1iUitxOFJaZEk5bFkzUWJVL2ZycjZYb0Ru?=
 =?utf-8?B?dWVXV3IwVXhzNTU2VmsyRGNEeDRPMHVhaXpvNGRRRWpNRzR5VGVBSGVybU00?=
 =?utf-8?B?eU0wU0JVRUQ5MTEwdFI2cS9pR2QyNmZOdUc1UXlOSkRqemlaTHc3Ykw5UW9M?=
 =?utf-8?B?WTJPVmpVY3h0dTJuY1VCUU9kbllKbDMwRm9VVjZ4bGVhK1RWcWtVdUF4cTZC?=
 =?utf-8?B?TGszMDNWNVJSZ1Y4T3lZVk5kOEFPNUs0TXdKcGgxOUlPckR4akdvWWJkOE9h?=
 =?utf-8?B?VHVuQm13NTUxQWtqWTlNN1BKNWhlMUl2RzQ2S3l5aHdDTGVBTVJHUUZqa2Nt?=
 =?utf-8?B?aWxjYnBWaTgrM3BrVXVSOE01bk1WODF3Q0NDY3M1cTN5MWsrTUlBNHBON0wr?=
 =?utf-8?B?bGxTTFFGeVpUa1BvQVh6TVlPR2VZUkVBb2t5RUgxaktUTm1pa2xtcEpMNkZs?=
 =?utf-8?B?YmlOYnZHb2Z0L0wzeU1JeEV0ajlZd1hKdGFaVVlCeStrd3FPcWZLZXNJaEE2?=
 =?utf-8?B?b3kvbkpFY2FvY21oMVlwT1FMQlJPYk4rU1ZTLyt3TEdLWkd4TEtPbnV3ZUVj?=
 =?utf-8?Q?0jN7MgxV48Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnM4R2dNMTMzbVlMY1hwTVNNcUZkZHJCMmJuVnBBWWFJWkJ6RTBIN0E4b2Q1?=
 =?utf-8?B?N2NjeWFQRTFCTjRKK2RxQm92UERwZWFkbXo5QjZDYUo2R1BnNHJad1VETG85?=
 =?utf-8?B?K1U0Uk5CM3FlNGx0bG42d0pzM0RvV0gyUmpBc2J1U0VBVEpRYmZUUzJvVzVl?=
 =?utf-8?B?KzU3RW9oSFVYUGc1YUg5bGtnc3l1bkRDL2xwRk81L3c2b3lrdWhrSVpOdFZJ?=
 =?utf-8?B?cm5KRHI4ME9MRFZyb2VUU0tkSmM4RFhxMzdicENJdnF5Y3R3SEhlVTJBd2FN?=
 =?utf-8?B?b2NpVy8zNTBBZFA5dUxSNzdjVnJtRGlQTGxpcnhtZHVEcW53eG5ITXBCOFJi?=
 =?utf-8?B?SkhuWDRET0Y2cmFKOTdGanlSNldOUVZWUG5pZ1I0Nlh0QUoyMm9VTmNvY1Nu?=
 =?utf-8?B?cVZEWHNGYUVCamxtU1c3Y3dKRjF0TXlnSEIrMWl3M0lJUnF3a0F0UndMWXhy?=
 =?utf-8?B?OFdmSitrU2xLZ2RSSHRtNXZ1MWhlWWxHb3RUQTZXSk04ekdtcHkva0hHa1ZM?=
 =?utf-8?B?NXhOaGs1alR2VVRmZnN6dDQrYmZweGcxck1pRVBiaE5PMzVXNkRVWDVUUDNw?=
 =?utf-8?B?cUQ2OE5BdEg3NitkNlpkcUo1czk5dEtIbk1sTEcwRGYvcHVzWnJrT2kyNjBD?=
 =?utf-8?B?c2pUTVdmMk9TSHFIdFBFcHhXWkRGZ2UzcTVRb3IrQ1RaYm15dVhTZkU2Ykpr?=
 =?utf-8?B?YWV1MmlubUZIYmpkN3BreGVNbkN1RE8xZURCeWdGTlVwczZWcmQ4b3NnYmlB?=
 =?utf-8?B?L0tSaXg0TTN5V0xvcHhXSXNXSS9xb01MTkFqY2lxTEk5UmNuZk9wWTF2MFAw?=
 =?utf-8?B?SU9aVTMxMFJWZHFtOEJNZC9ycnliL2ZzZVFQQUk0RGdEZzVuY0RtUDQ3d2tZ?=
 =?utf-8?B?b0JReXlRZkNJczB3U2tLQmNyaFI4YThvWDk1N3lJaktaRmozbGxpMjI4ZitR?=
 =?utf-8?B?dWZmVVcydDgyUzg2VmJycHlsMytXNFhXd0ljZnYzL0F5c3lWY2R1a28xQWhs?=
 =?utf-8?B?SURXUm9hUHJid1E0bGZEdVFKMlE2RGlWbzEwcFZEa2gwcytYN241REZtcHVS?=
 =?utf-8?B?TWoyMURiY002dzNLcXpqUnJTNi9DZjVDdjROM3JiL3QzUkJ2azdJdHdJbGow?=
 =?utf-8?B?SnhTRGNJcDdHdjlXWXJhMjBtSVJSQ3NDcUpxcTBxcTd1S2xScWtmbndhVGVk?=
 =?utf-8?B?QWVvQmwxQlgzS1ROaWJ2K2JIWHpRd1VyaG9YalNtb3hoUHRtNkNMREtMSy83?=
 =?utf-8?B?VGl6d1JwQlRtbDkwVWs0aHZuaVJoM0o3TVM3S3hkVTNZT25JanFwdDhiZURT?=
 =?utf-8?B?SGtQelFiZG9iMjd2RzdBMU5xRExVb1kwSkRuZTlTTUFpY1Q1aUJYYjdCNG5v?=
 =?utf-8?B?Q3p1dGNrcktlQTJsWWxnNlA1aDBrVjBlbStYcS9ZckE4bkVnNVU3eFZGYXVE?=
 =?utf-8?B?TC9oS2NpM29zMGM2OHBnck90dmpUMG44OXEzNWtKOFRNSmx0Qi9yUEh2bWU0?=
 =?utf-8?B?ZWhwQzZEbjZyeGFDSWdUbjBDNm1zZEh6SmhvbWhNbU1ETnFGSzAvc280czNp?=
 =?utf-8?B?SkViQm1jYktBUzkwL1ZNWXcxTXF2QkhxeGtWMGVSK214anFEbzNYNEI4dDN4?=
 =?utf-8?B?M0RXaDB0VGFXUUxMeFg5eWp2d245QTFMdXZSMlZ4USsxQXd5NDVUcTIzalZN?=
 =?utf-8?B?aEZZVTVKdEZjaWZiUGFOdzFsN2dhZ0RwcHFiR21CVDlzL0dZcVNJR2tITXdD?=
 =?utf-8?B?SHQ0ZVlBdFVSc1RCUW5hbEVOSUZOTnV2Rit4c0ZLMWluNUVtQ01ZZFFUYXgx?=
 =?utf-8?B?eW5HamdEdXVLVkMzYXh1R3pXRGpVazhKQlNCZTdRTUlOaG05MTdpT2hMTU9n?=
 =?utf-8?B?QzhScWJIZXY1MUtRSG9OZnl6RFZ3WGlSV1BzQVRFNnlYaFpRUmlIbFhGTndC?=
 =?utf-8?B?bjVlZjh5TGd2OTlPam9sS2xqUzR3dXQ5SVVacDJ1RlpzdXY0OGE2elhKcC8v?=
 =?utf-8?B?aFBjb1NoOCt5Y3BJNGNWaUJtb3gyMzBpNU9HazJldTE2MjN5SFdFTnZTYk55?=
 =?utf-8?B?S2RXLzJLeTNiVUNXMUx1VGpNS3FWT1RVeEFhc0g2UmVkbmJRZmhlK20vU09C?=
 =?utf-8?Q?1sX9gSgr4ntgG/ZNf9aU50FnL?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a9d5f5-21bb-4d4c-4da0-08dd83d71ac5
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 08:56:45.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7kYXZUT0hXLrF2CLVIHneF0jlWon1MZ1i2Y6hyeBXG7VD4nnRKettwRDMzMizcn8Hqy768pklkB+TnMBw11Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2423
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

Am 25.04.25 um 09:49 schrieb Miquel Raynal:
> On one side we have a power domain uclass which is mostly clueless about
> the topology of the power domains it manages.
> 
> On the other side we have SoCs which are getting more and more complex,
> ie. with several layers of power domains. Sometimes (eg. on TI K3
> platforms) all power domains are defined by a single device tree node
> and the "subdomains" are referenced using an identification
> cell (#power-domain-cells = <1 or more>). Sometimes however (eg. on NXP
> i.MX8 SoCs), the description uses many device tree nodes.
> 
> When a power domain is referenced several times, it is likely that the
> power_domain_on() function will be called several times in a row, which
> in some cases may lead to glitches or even breakages. This situation is
> problematic on i.MX8MP and only with proper reference counting we can
> safely support the video pipeline.
> 
> There was a first attempt to bring refcount support to the power domain
> uclass, but it miserably failed because of the details mentioned
> above:
> https://lore.kernel.org/u-boot/20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com/
> 
> So here is a new version of it, which takes into consideration:
> - the fact that a single power domain udev can target several power
> domain IDs (referred as "subdomains")
> - the fact that some platforms might count on a uneven count of on/off
> calls to work, and "fixing" this may break the platforms.
> 
> So refcounting is an opt-in parameter, it is a matter of filling the
> platform (public part of a per-uclass structure) subdomains number with
> the number of subdomains this device nodes features (one per
> power_domain->id) in the probe function of the power domain driver.
> 
> This series shows how it can be done by enabling refcounting on i.MX8MP.
> 
> Samuel, Neha, Wadim, Heiko, could you please confirm it works on your
> side?

Booting works for me on the phycore-am62x.

