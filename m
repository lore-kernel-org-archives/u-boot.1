Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE2CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 10:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C91680FA1;
	Tue, 19 Aug 2025 12:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="Z3gUd8CD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9A8082998; Tue, 19 Aug 2025 12:59:16 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C45802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDC5RCGK02/DyrvLF7YeyDYWQTnSgNJihJQeDBSoQq8/4yUClSchOmMIRg3tDrGSdxP1gmW/R9LHbU6DB/oJoCO4YGTYpbVQZBO1hvMfCpnSuanrDWx0xmFGdcRUhJp62DksLXIIePXTRuQSVbYk5vF520KAunJWaYTcoTCgYeHtdDBOemcpH8GYy9Ujk+KD/BxEpw1YUU3S/adGwDjA8Tw8GuM6aqzbIY0mEt1rnQ8sb/hXqYftUo3FA79Mfn263WuvGDxMJK4dfzXyK08S1JG7v6w4SGGYZ0cNEaW/1D0ygs3DVmhB42g1qVc3yZxpCHwcPIjM2vhngghum7t7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nhNgJz0UL0qU5wBmvMWw0eYKdJYmm6FEcBeelMUKDY=;
 b=ukfMOabwloHnr/PVt1yxTdhJrN3vy3cOJLkD2zucghwLQL8GMNY7arhK4Ep8UPIgmOF4gpaTvsG7yZIbLgJT5+V1A67JOb59GvxzvtzSmdgtLBF7bgYjXnDeKajUPEmbuNKK8gpRdIbVas701wx7msXCC1rlQKMU8ZHT+0V63pdAVUV6Cs7n/kWxcqgANMibYVvZOxWFjoEwb0p8lqYXqBgalXXmOrta36bsnp8QyPyDC/IhYe77Kl3ifI1RJxuux+xzNfsZxf2ehA1UMGMy2pGfNEkdHAKrqBt54U6+rpwj7D24F8oslZS+PvzGqzaJpHznKJJnI4ReRYUGGtCRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nhNgJz0UL0qU5wBmvMWw0eYKdJYmm6FEcBeelMUKDY=;
 b=Z3gUd8CDCNoP9BUvrwKPzTg08L8Q+GFCJcqomVT6mWTTSGmPFwwFFaDdCYH27SP4GVUeHQicIrYxOvGGsscpiDbhBVJOzjj/9IqeBKo0vuwn8HMZpfFCiRXAN1YLcJ53h/a0gWQbItW1WVQFBIFr6/709iDywd+J0Qz+827fDXMipn8HUnD8UA/s8ejPsL13NMVQNjuBCc44UjIH932eaJy/w1B2W84hyJV62Q41OQyT24FoJBjtL9v6HiW9J9jAfXLmp+VjRpNUk6qTnLQDLiy8SE8gvAwluL8MAYuPSVvOX67/KMvdaKcTG6Du6Vg9EoC9HI1a27FSZpxOZJx+UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.20; Tue, 19 Aug
 2025 10:59:11 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 10:59:11 +0000
Message-ID: <7b167416-41d2-4ab9-9786-bd9a98358922@kontron.de>
Date: Tue, 19 Aug 2025 12:59:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/21] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
 <d4e3714d-d687-427d-8136-5388694603ec@kontron.de>
 <8b7bcbd2-4c66-4e2d-b169-c79eb7081f2b@iopsys.eu>
 <d2f236a3-b3dc-4949-bd3b-4020a4ba108d@kontron.de>
 <d7db7457-12e4-4dd8-84a5-581095833add@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <d7db7457-12e4-4dd8-84a5-581095833add@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3163:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fee9c8-c4fc-4ab2-fc71-08dddf0f6dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVhBck1uRDhQSm14S1VoblEwRGd0NTdYVEZPL2oxc0FpY0VOMnJMNXU4RitZ?=
 =?utf-8?B?eXYzOFJGaStESlBnZWd4alNVWUJvYmRpY0F3SHJIcmJyYXBjeG45TlVpZHhT?=
 =?utf-8?B?eXBSTHp2U3p5VmY4aTlNcVAxeWs5ekJuelFwb1RvcURKVklpZFJVSk8yeFVm?=
 =?utf-8?B?VHFNRVRGTUcxblRoSlhodGEvSDVkSE0wSHIxR2Y2RjlHb1AyWmh5ZElGYnRv?=
 =?utf-8?B?TWFDQWdHdkMxTHk0bEdxQ1BJbmx5UDJGeEo2MDlQRUd5RHFtdmtSVW1RM0JM?=
 =?utf-8?B?S2pGZ3hWZk1od21ZZE92K0JWQXR4bDNHK3lzRHk0QmlqaGNFTlFrUHlwM3dw?=
 =?utf-8?B?VnVocGduZGRKd3pLWmcraDkrWCtWWEo0Z3BBVUV0NXA2dVB2ZGRjTzNjZ01B?=
 =?utf-8?B?N2JZbXVydkdOOFR0TmMrbCtNWEtNN2hXdUNwSkxnVE1Kb0xkaklDRjF6T09W?=
 =?utf-8?B?SzkwQUZKMWR3M1hNaGFhc2xGUlNhQ3c0N2RwY1ExS01zUGNzRVlSQ29WUGMr?=
 =?utf-8?B?bFJQMG1xUUtWbEo1VUxIekZUQnk4NnlYdy8rV3YvdzMwTCs2M0cvNzI3dGhi?=
 =?utf-8?B?S0t6MnIyNmpUNEdWb2xFc0Ira0lWMTdmQnR4RG5tVEIyc2I4RkNGRzJPWDVq?=
 =?utf-8?B?Z3dtYWJkOTZCQWdpb2JqTW4rd205SWxrWDhiNUUvOVJVMTRaYVdIS3dqQ2I4?=
 =?utf-8?B?NTZZQzk5dmVtSkhPWFUzK0I2ZFE2V2x5S1Q3ZnhDZGxpOGhRQUU3SHhsTEhh?=
 =?utf-8?B?L05OdERxUE1FSXd6V1FhR3JoN0ltajVNNHM5ZWdhTUdVc3BzNFlLcy84OU5U?=
 =?utf-8?B?UlBjZmc2Ty80dnNpSWI1elhFVHhWRWdUYit4VnpDWXAxUWIwejhpY0FzaTlJ?=
 =?utf-8?B?YUxqeGlSWWN6WG5XWWQva2Z4L2xKRzU5Y0JjcEUvWHZJdFg2dHZHZWoyWHBF?=
 =?utf-8?B?Qm1yUHZyckFsVVo3MkFqVzM2RlRlRVdMVlJGTE5HQ2RibnpQdHlpdlNjbU9N?=
 =?utf-8?B?M3ZFQi9SZWhVYTlROVFpb0laVmduZW1ZNlpQUXA1c0VnSUNqdHpQK2RkNDlh?=
 =?utf-8?B?SjBJSnN6R1pLbmZpMjltNVdxMW02M2YwRzdhRnhtdm9xVUJnYWtsbHZaMVRT?=
 =?utf-8?B?UDhHWnBFdmVVUFBQSzBVN3VNWkd6K1JSYmV0WnZ5dTFEZm8ybXNCTHJJQ2Ir?=
 =?utf-8?B?cFdjWXRmNFh0QU1xU09iMFBUSS91SGt6N1dRSTdsZEd0Z1R1ZVJHWGQ0VitW?=
 =?utf-8?B?RmpjWE9Bb1dXcTRzMGNHaGxaS3FVbFdhZlJzam9YZktTNGczRjRKNkFXcVY1?=
 =?utf-8?B?OFV3R2paRk5QN0ZrZGVxMXFMSmM1UVdjczJGeUs5SGppM0FBMnI5SzFvU252?=
 =?utf-8?B?dVBzTHEwVWxpUk9HaGNGVUpoYzE0ZXZKb3Z1WWpHS25oTjB0Ykp2T2hvaExx?=
 =?utf-8?B?TnNlWHV6dkhTTC9rMGFUT2RMNlJ1RFhCV0M2L3pMWU9YUW1CMDBZU0hkME9N?=
 =?utf-8?B?WHpVK0VtakRuT2hMYzdTcHpHY3dpTW9nQXRXZlh2ZWxrT3NzTmF1T0NZdHR5?=
 =?utf-8?B?NmhHNk1zampLNUxZVThzTWRISXJ3eFBFeEwzYlRvcmgyaHZKY0E5TWJZNVVr?=
 =?utf-8?B?a1hONGpXYUhPTFhJbHFjemgwYW8xVEFRd3p4Ym5KNG1hTDVVdlkxS011ZkdY?=
 =?utf-8?B?TjVVZ0Qwc2RuTGpzZHp2Yjh4ZGd6YXVLRktaRTJCVG9nRlNaWHFqOWNGMFFy?=
 =?utf-8?B?NktBM1B3ZFRoaGw3MnBEeGtPQnVPdGR3TVNudldQRWxPS3JpaTdJS0toVUNo?=
 =?utf-8?B?a3VuSGlxanFYVzd1OGhUMFl6MEtCTTlwMDVsTmhza3dyd2piYys4WmtxRFh5?=
 =?utf-8?B?Q2E1bS90ZFU5SmRESk1Wdm9ScFVOcHRmR0I0MmIzNjdjalJIcXR1cVRmK0ha?=
 =?utf-8?B?Q1pibnY1QVlvemRnV08zMlRCY2NPdEdWS3l5aE8xMzMrVHV1U2ViSVFRV0Zv?=
 =?utf-8?B?eFFwOTRud1BnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ByKzFsL3FSTlpEYjA3M2llaVFqV21ZL2cwekRKRUJyNGRVakFtRW05UVlt?=
 =?utf-8?B?RVAwcER2cXZpMWtqOUpFUjF3QmJoMzFyU3pwSkFGSGhqVWRMR3hPRzV4aW8z?=
 =?utf-8?B?VUpLRU9PUE0zY1FsNEJZL0wxOGZFWDBqSThuT2FNVmVnT0IvSCtWQWtRUytu?=
 =?utf-8?B?YVhnMTlRa1E2Ym92RGRqQ3hwUjhycWhWSVJiaU9QbGkvU20wS1ZDVlhQT0E2?=
 =?utf-8?B?SVpuTDl5aSsvQXBLTTJ4eWxSekkwTEFwVkJpeGVtTmRLZG5DaDdQdDdJdWxu?=
 =?utf-8?B?NGtxSitRR0xQRHFBazliY0V1ME9Odm5SNXB5eEJ6SlpVY2xGQWNkcjZPWFVC?=
 =?utf-8?B?cm5DaW56NEtyK0R0a0VUTVF1bW1Pek9CQzh3WFI5TTIxa0ZuTDJud1ZaUkJz?=
 =?utf-8?B?elRNSk00WVJMbld5b2FESEU0R3Jxak5oZHMrMDNNYjVHR2drN0F5ZnBoR0NZ?=
 =?utf-8?B?NlRVbHBrNE0yYm40ODVkRHc5TWI1UVRnVExSV1dYZkJ4UUNncVBTV0lmdG1p?=
 =?utf-8?B?Q1k0dmhGT2hsK09IdDZlK2w0eE5zcjVEZmJneGEwN2llNElzVkxoeHA0QTRZ?=
 =?utf-8?B?OTE1Y21aTXE5RHpJb1ZPTjZseDlteDhmcE50VFV0MkViYXpYczJSRVBoSnVa?=
 =?utf-8?B?NWEvOTB1cWdhRExQYlRxSDVMdDMrd3RQbnAxR1ozc254Q1ErY3FiVzcrWXIy?=
 =?utf-8?B?QStncHgzZjVQOVhTbHdZN3JiVEZGbnZPRWxTWG9zWEdubi8zMjZsZUNSZmw3?=
 =?utf-8?B?VVhnNlFNSWZsQnQ1akMrOEZvTjZlVWhoSmdiK0NQZk5vN25zQ3NmLzVMYzFM?=
 =?utf-8?B?M0R2WVVvZkpsdkkyclBCQTZwOVZSL25rUUF4aTJWYU55Ukw2VEVlb2hCeGZW?=
 =?utf-8?B?ZVJTZ012MkZMay9wYnB6WVp1QzBJMEUybUtJNXNDaHYxcjNWUjVRRlFiZFNL?=
 =?utf-8?B?ZWx2Q0d0Yit0elJrSUlBR1NPRTFhS2lnbUpzb3pRYmR3V1dBZGU3WGprcGty?=
 =?utf-8?B?SWpzcXVUU1g2dkE1ck9jaWxLQThXOVNBYzBlU3RzZTdMU2I4YnhOTEhudUg3?=
 =?utf-8?B?SjVmaXlsL0U1akw5NE05S3FVampUMWlWaHRlQjN1MWRFeGt3dzFKY0ZIZ1pZ?=
 =?utf-8?B?cFVuUDhFaFlBOWRFckptdDU3MXRzb0lDcExDQzN5ZU1yMFdzL29ybGV5Zk8w?=
 =?utf-8?B?ZEJhL0JuWVNvN3NIaGhHVXN3VXhLUi8ySTN6b2hGTy9SdkFsaGtDR28yQ2ps?=
 =?utf-8?B?YlJGTUZCakEyU3ZvMkJuTWFic1NzZkFCM0xScXoxelRiQi9mOGo1Y205Y2dC?=
 =?utf-8?B?eE9GdEFSdUZrWTZYclVpdGNsRms5b1M0eTN4Rkt4WnJINmg3SEZnc1JNMUhX?=
 =?utf-8?B?aS9jNWFDWkVUbGdoMldhTnZSUXZ5Y05pWmErd1IxQloxVnZHWUlsYWNycWY0?=
 =?utf-8?B?b3o1YkxLMTdRcDFwdU5BdkJOdFpJUkZ6VC9kT2dWcTlPbXZaK3U5YVdFY3dn?=
 =?utf-8?B?ZCtQeU13YzUzV3JhVWIrcUN5bmRyM2QvbVZKeGluOC92MkJoYm9MZTJFN0NI?=
 =?utf-8?B?ZU1xRk92OTQ3OE5rRUQ5WTdiTmEyNFdoaE51K1o0OHpLNW5Zb01nV3Z0T2hF?=
 =?utf-8?B?bU9udDkxV1JwQW1QRStvL2daZlIzRWVxVWF1ZzRIeUR5a0RENW9jSGpyZVor?=
 =?utf-8?B?N1JWWlQ4SU05WmNEYjJ5TkRIei9CYm44T09hMVhabGxLbTd4NXRCTTJzdU5X?=
 =?utf-8?B?R3Z0MEpzMkc0WkV0QXdYUDdPcFlyRTFudEtsanM3Zm8zWE1yc2ZROWQ2TVQx?=
 =?utf-8?B?ajdkUG5JbWp3Qnl3a2I3aTVENmxYZEFCcDJZZmRKNi9mRmxBMG9RdlVVTDJG?=
 =?utf-8?B?VHorK201NERDempnazRnV1JlRGQvbllDbm5kc3hPNkNkYUJlMkRiN0M3b0Ez?=
 =?utf-8?B?ZXhzSGJsM2F5ZmRKM1h4U3IzcWwxRHZUS3kzUGNPdjRMZmY4Qnc0S0JrYVhD?=
 =?utf-8?B?eWFUc2lhekJnZG9QZnJORktqMWhPQUZsZk93Z3lDODBOdTBxTDF1K2NpYVhN?=
 =?utf-8?B?TnJnSHovUmtmLzRjeVlQaUVOSmErTEszbERVMVprMEE0Y2IrN3hMVEczZXNQ?=
 =?utf-8?B?S3JFVCtLZlZsSm0rdytHTmZ4azFhVVVrS2R6NW5MQkpQbjBQWW1vVlFGR2FW?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fee9c8-c4fc-4ab2-fc71-08dddf0f6dcc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:59:11.7333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGUq943lmx8yHWua3ysu263/3hGxRbq1keHZfEG2e2n+E6qrlinWp++oD4SHy2wiNK2fmBYqeNU3rcVIQnMITmIRE75FLElbE65I4RiYYMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3163
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

Am 19.08.25 um 12:47 schrieb Mikhail Kshevetskiy:
> 
> On 19.08.2025 13:42, Frieder Schrempf wrote:
>> Am 19.08.25 um 12:34 schrieb Mikhail Kshevetskiy:
>>> On 19.08.2025 10:26, Frieder Schrempf wrote:
>>>> Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
>>>>> From: Gabor Juhos <j4g8y7@gmail.com>
>>>>>
>>>>> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
>>>>> logic") the spinand_write_page() function ignores the errors returned
>>>>> by spinand_wait(). Change the code to propagate those up to the stack
>>>>> as it was done before the offending change.
>>>>>
>>>>> This is a port of linux commit
>>>>> 091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")
>>>>>
>>>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
>>>> This seems to be a fix for a change that was introduced in patch 10 of
>>>> this series. We should avoid introducing regressions and fixing them in
>>>> a later patch to preserve bisectability.
>>> Hm, this a bit contradict with removing fixes for continuous mode. In
>>> linux, continuous mode makes some flashes (mostly macronix) almost
>>> unusable on some platforms.
>> Sorry, I don't understand how this is related to the continuous mode
>> fixes. I'm just asking to squash patch 19 of this series into patch 10
>> so the changes of patch 19 are included in patch 10 in order to make
>> this a single consistent change.
> you write: We should avoid introducing regressions and fixing them in a
> later patch to preserve bisectability.
> Continuous mode introduce regressions (see:
> https://lkml.org/lkml/2025/8/14/349). My patches fixes this regressions,

Thanks, now I got it. By syncing with the current mainline Linux, we
also introduce the same regressions that are currently existing in
Linux, yes.

But that's a different topic than introducing a regression in the
patchset and fixing it later in the same patchset.

The first problem should IMHO be solved like this:

1. Fix regresssions in Linux
2. Port fixes to U-Boot

If we want to avoid introducing the regressions from Linux, we should
delay the merging of this patchset until the Kernel is fixed.
