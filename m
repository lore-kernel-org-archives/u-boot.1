Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C24ECA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 08:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FCF830F6;
	Mon, 18 Aug 2025 10:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="H0x4KQgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FACF831C2; Mon, 18 Aug 2025 10:22:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDB1830A0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 10:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko7fsaJe8TcyKRiO6Ht+8+t/rTj1RPy43j260EwQmsp4L2opW9MZKLOFC/Zk1qJmVda/zMjkwmWqloQyBA/i0jQYHFt32VypJzrZhEtxDvkpEgDWD4HZbles2B5trzSxhKaHbiG0AWtve9a5THpLrebkEwZvUBBFJik4j8hQ0D+iG2+cjyAq0L4jYupx0jZMT9ME59oFZeIelCIh8VEI8sq2zxjVnzEdDZdc6h7cCJDB4MLZoepERiYtV04E2OowOWMo5EtGFK2Kwm4nyic0qwaKpaB2v75/KvHlBWPYsktFWDKesRCU3BdA9SwHbcvb+cVmBLytP33+lYOdCU8Ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW45drvMJ8M+6Re/NcoG1x+njw+GymJHSnpGSibTNx4=;
 b=WGfVBXbQ3GYBGh+U2tikICJ+i0X7oz18T1CGsuRRyjmC2MJwITBjHtMHe0X0LoHWZJVfs7gs2Gx2+SCb21ZOVitsA8k+RVgU328b1DfVs+lcvZBzrfelxp4yo/JKG5nYRZX8DlRu2D0+vSj+/jk0sj+Ul6Wk8hBeVpX1zGbmdLH8haFzjAHDsBg+M2Sgt8u9wjWa9LM/cnofTflsBmfEHKFeEJcAlUp2gmoSOVTBV2khAYPITdSPjHJVaovzhd90AM/aHEVi8vXSAdwZgt7tu/ExZnURuMuh1RId+Ht5fMn0xNdFtwnGV3svMwTR9mhgAlfmD+q87ik19lU6kc69qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW45drvMJ8M+6Re/NcoG1x+njw+GymJHSnpGSibTNx4=;
 b=H0x4KQgKo+yWcSeqNI8G3LUISLJ3J2faE8IpEb/GZk9ncRHSPRnl1n+UO7QwcuMawU5DrAZfq1O3AlkgEl9A4mHgJjI/VU/Pm7M0HR6oNg3rbzvyWtk+/EHp9IBqNLVbxJDHiCfK0KToLV6qm1ypRqYioeQQ4ITAngQGeS9ssvxj6/cYjjPMnOx8GVF1PBpQz2+NRBLZir995HU+MrLBQBjapfyKabzuBZTWZdvWf8yv2IXRlh/9XYVNXkYc+By2HbnGovL1KDxP3GebtctIPyahkvtVWLdXZXDhBPrKz5LKBByWpQUrvnHucm8RiN5ApGg4mso/ADRUqzP3hkG9aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB5903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:22:28 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 08:22:28 +0000
Message-ID: <2c1c0e32-b185-48cf-8b94-83cd5ec137cc@kontron.de>
Date: Mon, 18 Aug 2025 10:22:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/21] mtd: spinand: Sync core code and device support
 with Linux 6.10
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-11-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250813234314.3945708-11-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: d129bf33-f314-4b2c-e97e-08ddde305e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0I0a2JQdDhjbTNmZmRlRTlRTHFzZjBlNUtsd3RXTVZQQ0F4a0xRb3lYWm1h?=
 =?utf-8?B?YTRYNmxBbzZ6elZrZWNMeUxWTTcvNEk1VVprRWdtTC9LeHlkVjVGT29OaEM2?=
 =?utf-8?B?b0ZNVGFhSlE5UXJTeXBBNkJOcmN5cXRBN2lWRXF3aVBvbVlLUWJHb1RXTzlV?=
 =?utf-8?B?OFowSjcxcWFqR1BJVnMraHB2ajBkSlpoRFR2UThlUVpoSE9menNuRTN1czNk?=
 =?utf-8?B?MXQzSHRuQXRoMVYwYTdiREtmRVRmL2lvYmFtNUFMWmxicUlsTEdPYjVaV1Vv?=
 =?utf-8?B?RnRQckhLMDFxdUhmanBkVkdHL3NMZ2xvMkVENjJrcWg2NG9TN1B0QU52UExx?=
 =?utf-8?B?ZUF2bFFRQzRRdkUrN1cwdjVjWFRBWnM1d1E4Tk1xM1NTSjdVRjRCdENPbnVC?=
 =?utf-8?B?N3hSTUhyL0pyR0dNbmZlVE45YUc1bmVhOFdoZXJlMUZ4VVlIK2psYUhqWGRW?=
 =?utf-8?B?MC9NV1EyS2IvRFhZdmhpNGw4UW1iTCtlK0pIMlEveEhPT3Y5S2ZBek9SOUxm?=
 =?utf-8?B?SXk1aERkYS9FMVZYcWVuZEpKTTVjeHhmeHU4eHM5SGRQZENrZHdsZElKYlNv?=
 =?utf-8?B?VVdNc3lJc21sc3dsUmFhSzh1T3pxSmdkb2dFZ3drMUJEQ2pnakJmcHFhaHhz?=
 =?utf-8?B?S25RQXlNT05BSStNYjk2ZkQ5b2xQVDFsK2dPeTlGNDZnYlQrN2pvbkpUNXc4?=
 =?utf-8?B?bVh1c04wZWZ3SDVyREZtWEkva0syK3MwTjdtQ0J3VjlBaHBlbWM3c25jOE5q?=
 =?utf-8?B?bTBxV2FnNzBYUVpFTDZldmxCeWl0NHJWQnNMaTFKZDhNWVM5aTg1alZPN0Ju?=
 =?utf-8?B?ZG1KVzdEQkNVWXM2aDNVcDRlNXZaMVNhcmNOTzdIZ0NLMzROTXc1dGsxaWVB?=
 =?utf-8?B?M3BONldISnlXQURHR3NFNVY3bU9leDJ5a3JJY2NsTHFpWExCa0x3cVJobUJu?=
 =?utf-8?B?Y0ExclgyUDZhREUyN2ZLc0lrTzdvaTZoTUxPTVVvK1F4WkNIYzV6N1ZnS0NM?=
 =?utf-8?B?VG1KN1djdXhHSXJ2MERzejB3QzA0MkIwK0hBZlZrRjdKMWJwSnlmaGE4Wnlr?=
 =?utf-8?B?cDlwOVdWNklHdlI5VEl2MmkyMEdDaGJoQ1FMd0ZxNzhZVi91cWVmRVg0Q2FL?=
 =?utf-8?B?ZjY3L2E2dXdQcC9zakNnUHhndVY0NExwYUt0aTVFdC9GV3Y5U0trRE85R3RP?=
 =?utf-8?B?R3FzVktsNXFNaTlKU2xJbnJVVW9CN05sdUYvWmNldnVZR3ptZFd4UVBVMUJJ?=
 =?utf-8?B?YkVSSUFoSjd0MHZSMUc0dlJsM3V0S01xTDFjM0liWW45b25JZnF1dXB2aDV5?=
 =?utf-8?B?aGgyUGZOWlVwUUhneFB3US93Y25Pc0VkRUxOUHJvZEZUMHFyQmc1b1ZLMlND?=
 =?utf-8?B?b3l3djcxL1lVZWhZVVkwV2Z1R3V4UFVkM2x2SWlzNUZJNm4rUnVLMHg4Tjhh?=
 =?utf-8?B?L1NWeGpSRGdlc1Z6TFdKVm8yZ2V3cWp1Nm5zaVFVUXpyVEh6OXh1cXc3b3pj?=
 =?utf-8?B?VHUyblNUWldyVm5GaER2cnVLU2lpcmJ4SjF1eGhLeFM4YTJXU2lmTHNoUGtU?=
 =?utf-8?B?N0I2V2JZWm8xS3ZUYWgwSlNpTmdDZDNxdjFROElZSnprd0JCMC9TeFozZFox?=
 =?utf-8?B?MXFHQWpvR3NLNGxZcDZLWVk2TEQ4cHRkZHN2d1Q1OGJXWkpvcjNudjVhUkh5?=
 =?utf-8?B?b202QkN5TnlFdzZia1pqZXVwMFhuRWNOa3VUQ1NYS3BXa0xCVmhxSjNvcUF4?=
 =?utf-8?B?eXBNUlhFbDczbTU0SWk1UHdZRW16VE50R01XaHB2UVgydmtlT0pndk90czQ4?=
 =?utf-8?B?OC9jSDR1b2FSbmpZRXpTNTUrZGJrSlQrY2lCYjNSUmVDZ0R2ZUdOQnVoVDVZ?=
 =?utf-8?B?OUVsREkvUDd6c2dhZU0ydkUzTFZFYkY3KzhkUUkyYkZNYlJpSzl2L25rdjll?=
 =?utf-8?B?Tm9RaXc3RDU5enZFd0wyeEpOaWhNVWZBTHZZeTdiSFhTQ0dBSFV2Ty85TlhW?=
 =?utf-8?B?Mk9IRjFqdVhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhibEZNZVBaVlNHMnJkTnVUS1RjbUM4M3NENm43S2sycUFQWTFIaXo4QTQr?=
 =?utf-8?B?YitvRmFKVWpsSFdySklzUVhVblBmWGpacDFlZ0d0ZUovQk4vVjlaTkJ4c3da?=
 =?utf-8?B?SjNjYjFBbkhZeFBhQW5oWXRoOUU2WU1GbDVnQkJVRklhQkxSTkw4Rm12S2ow?=
 =?utf-8?B?VUluczM0KzN0Y2FmckdIT21CNlVaRmlWZk5CWkkvTmRlNGtUVEJxZGl0ZmE1?=
 =?utf-8?B?UDlqV2JoNXR6YkM1dFd0TW05MXJ0SmZUS2pENWZ0U3VjOFR6WElkaTBpZ0o1?=
 =?utf-8?B?Vjh3dGovN1ZDQUViYjB1QlkyMHFkSjdONlZVRXVUdVVvU0U4WkxwU1FMbmlu?=
 =?utf-8?B?YXZXVkpSSEwvSVZxQkVHakJLWkI3aUkrS0kzUGlFTXozUmVSbW1MNU1FSjRG?=
 =?utf-8?B?a3NzRjFpeGJSL1MrMzVMUTI4OFRhRGpLdGdqT01PWmZ6Y3A4OGtqQlVpVXpC?=
 =?utf-8?B?Z2ViRHpyY2Z3cGhmeXNiSDlKVDJ4MURsaGhldUpWMTJLU3JONCsySnZhWTA3?=
 =?utf-8?B?Y0txV0wyaFlUNkhydmhmajZNUmlIM0NnMmpqQ3FQNXlZa2dHMGJnSVB4VXBs?=
 =?utf-8?B?bElQaC9ZalVPc1Fqem1jNnVIQjlGcnlYWEl6aDc3Nmg3TEp4WVFPM3RSNC9E?=
 =?utf-8?B?c2hWbTZTcHEzb3dITkJQZEJPaXBhN1ZJN09ZTW1VRStMckZzcENNQ09ESWFp?=
 =?utf-8?B?aFdRa241YlBwTkpIQWNyYjZpaStxdloydlRXcDRJU2daNUFNa05sOXhWUmNY?=
 =?utf-8?B?RVNXR01VanRDMnRmY1p6UGdSdGZHVnphWlNRS0Q4UGtUanFUU293R0JuYWVZ?=
 =?utf-8?B?Nit4cUxIRmJ2ZWRhdlFWTHZRRHZqWnc2QlFNTmtkREYrRlc0aFVWUExoMFBR?=
 =?utf-8?B?akZGMEJSUkJkVnZ4MkRNN1ZFczZmWmJIUUJiOWlSREMzMTA5UTRNQktvRmdI?=
 =?utf-8?B?TkFBLzNEbkRSbGpuOXZTZC9sU1Awa05QRmtIM3Vjc204RTc2cSs0NFc2bzd5?=
 =?utf-8?B?S2xHbzduTkFIMERNMDlTc21XVHFmR1JOSzBGZUxyOStSVFFmUnVjek51S2RW?=
 =?utf-8?B?RjA1Z3U3TXEyeTJzVDJIazQ4aWVad3JmeUZxWUlwL2tSQXNOT0lDRGNDSmlr?=
 =?utf-8?B?V1ViTERxdzBub3BoU1NUU2gzT2p3TFZxSlE5KzFCUnpjSnVFTmN3eWNRTGhp?=
 =?utf-8?B?VEZMb0tZNUc2eUN4ckpDaDVHbWFhRUgxdElpUXhuRVdoYVpWNDNOUHRHTzRF?=
 =?utf-8?B?aEFMN3FpanRYTHJsTk8rUU9aN1J4RGZ0K3NyZDFZR3h0ODluY01zQTRoRFNo?=
 =?utf-8?B?ZDJLcG1JQ0pBc09DcmMrYlhIekxBcHlwNmxjWncvSkg1SXphZFI2OWtzTGpj?=
 =?utf-8?B?NnM0M09md0t3MHRmS3lTU1R2YVdHZG9xWDJSaGRXUTQzS2J2cUloYm55RHRn?=
 =?utf-8?B?a0tkZTJwaFRlem1rMTJOblV0dDRtUDA0ZHloemY2SW01VDVuZldtazZ4Q0l0?=
 =?utf-8?B?MXZ0RERWKzNrWFdBT2V0YksyTGhYNEYzSEJtV1VYV29PY2g3amZKaXVsSUhu?=
 =?utf-8?B?SGJZUElEQ3hUYUJiamVvWUkvemFjZzI5M1BLa3ZVTXc2dWtKeUkzU2t3amlF?=
 =?utf-8?B?OU5PNEhMWUdablQrVk9hQUhXQU1VZUtHaHczM0ZWMnJIMGcvNXF5UnNBSEVp?=
 =?utf-8?B?TXBQVmoxMEhCOTdlU3RFQUZNMDdsTGtZWTlaNFpzNU5qSnhkVkU2SGlZbEtQ?=
 =?utf-8?B?WDBIb0Q1WmRzN1dFUFhEdE0zN2dsSG02dWFoUHJKa3MrNGZZV1VIdzVoUFlD?=
 =?utf-8?B?WThQYTA3anVLbEpudko1bTBrc0p1WDR4WmVzQ1BZVDlqY2ZnNmErQVR1UlRz?=
 =?utf-8?B?Tms3YlZCbzRsTCtyb0NCeUtaUnB2c0E4WXJwZkxxWWxndEFqNjNZVUNoZGdt?=
 =?utf-8?B?QkQyMlRjUXZ3c1k1THVxUzVDelVzb2dZaU1JYWNEMG5hcXFNMHlGRlRITmZj?=
 =?utf-8?B?OUoyTm1KUE9HKytXRzBMenR5NDBmYzdDbStJcnVOU3RwTHY2b29BTCtsOUJG?=
 =?utf-8?B?dnV4bXNvemgzaDdxeFNaalcyZ0p2L2F0MXBsNGszUC9rRUhHM3hDK2dhOXha?=
 =?utf-8?B?bXZBcHppcE5jaEw1SjRoYWRXZ0w2dWJ1Q1VtTXZzWTlibHJ0MGRNWTIySGsr?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d129bf33-f314-4b2c-e97e-08ddde305e73
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:22:28.3715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgmBHDQcZd5GLkEHf8jVO042oGRA4kQwoTs+6nXcjzcJcgrYITmBO3BrvgfO53B+ccidwOSuGwdsCo4ZNhuGmkvULFjfwREVUQ4LeuZ7lI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5903
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

Am 14.08.25 um 01:43 schrieb Mikhail Kshevetskiy:
> This makes the U-Boot SPI NAND driver almost the same as in Linux 6.10.
> The only major difference is support of ECC engines. The Linux driver
> supports different ECC engines while U-Boot uses on-die ECC only.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
