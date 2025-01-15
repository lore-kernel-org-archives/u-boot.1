Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E81FC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E60380040;
	Wed, 15 Jan 2025 11:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BOkD5Gyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B560B800C2; Wed, 15 Jan 2025 11:23:01 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D775080027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXqiMHopNvzQFcFsB3sbJOYBG7Es3f4fW+bB1LL6iUqm/OaKHYsmWXUuzxqGW5Z4GlYs2r+NXUcgVX3lpn1qIPISAsrXWcj1Qr89dwQCLbe5zrtKVoaDgwB+J2K2TwlmKWNgQ61jhvOtFbaHimWPEQ0qaFiVfAyOzkaSDC9LlgTiNS7QyFy5jLWEDZtA6yF9mvmcLV+SYaiDHpfKkvEdGC5kWhfF6zXPyHpT9LZs+NPlcCMbxea5sONR7Fcf7lOBFOtknsBFBhn35IguwNUQjQsPgFuGdvH6LqIKOzpW/pUlwqy31WtIfOVtP/sseaiio/RKz5MDOfVmG/FB/yjJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cruVrFyCrSIU+r2b2KfPWmpdAvVHHwUSHkiikfICMNI=;
 b=ZrhwHIMx5HjeF0xEIMe8Lu9FrxuIiPAJ/criOcYqN2cX7LEmlVumXy82odkEDDk1Wxi8N7KYC7yoHqesEkDFz6wNm0eXmjzXIKF8JmBWt7CeQNz38mYYnqnEJ7XIEfFiMBTaIZcHEeCT3PDm2+pCg+O7DNTEDhg3UyKi/gYV+BA/jPrRCIPbTtzjCJh/6jDcjd0IPaawsG8QgiqRKqC6PtYyuXaYtVAaUAckihj9axOZbYTnHwFBYxR/l4VmvfR2Vs6zwco0R1wswKaaN83GKNprV7gdEynyjSMeglAEY5cILIx29NGw9LnhrcwSdEJ1Z/7zEnH3aWriUiR4eQfNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cruVrFyCrSIU+r2b2KfPWmpdAvVHHwUSHkiikfICMNI=;
 b=BOkD5Gyy6Dl6L5N2Kailq5V2bMtgNvxFBFRkrSLR2gd0D1FMhiyD84ggYPh7nL+DgRbhG5WrKr4cOiWZuhzNBY5ftX5DINBOw5kuDeKO2/3Q5qhGoNWg7UkaOt3lmf21g2ckPMmRqmL6RxZ5HQgHyW+/W5Gxp95JJ3O3pCC7naQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:22:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 10:22:56 +0000
Message-ID: <8b08dbda-58a4-4d7a-b691-acd30460942c@cherry.de>
Date: Wed, 15 Jan 2025 11:22:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ARM: renesas: Simplify board Makefiles
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250112223528.179828-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0161.eurprd07.prod.outlook.com
 (2603:10a6:802:16::48) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 39749c39-64dd-4e9f-f1bc-08dd354e93be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkI1azQxUFF3cXAxSmNmRDFPeHk0azZIZk5rQ3pPWlNwNHJKWTdpWlduOE5N?=
 =?utf-8?B?LzNJVzJEcVJhV2p6N1VRQ00za0xmKy9LeDEwN3c3LzZHcGRoSEVaNVo5YjVs?=
 =?utf-8?B?ZVorRjVVZktkbll0S1FoeXNlV1A1SmlwUmZpOWc1SHJhc3U4cHNyMGJnbXhw?=
 =?utf-8?B?UHVDcUUyUVZObU4xVEZ1dmJTbnNGek1JRzlxcEVwNmF0a1BXWVo0TTBGSXZu?=
 =?utf-8?B?RHBiYlA2VFBuQThlTU1DbFZUcHBGdm4zdDZab2tmZjNzVkxSdlRiUnRaYkNq?=
 =?utf-8?B?K2hIK3ZpNVA0NGhQVG10Vm1nYTVGVXErNTQ1cE1rN3pEVnZiUUdPbGowcUJ5?=
 =?utf-8?B?eEk0WGNtQmhWTGx1cFMyWWR5Z3FGT24xWmhOV21KeFJXVTBhOTJic09naFZG?=
 =?utf-8?B?MUM5enhKb2RkVGsxbC80dkxBU0ZYZDJ6YVo4NWw3bDE1ZjI3QUVBemU1VzIz?=
 =?utf-8?B?L1FYZ05ETE8rU1ZtNyt1YnZRYktDanFMVTc0ZTJCNFdLblBMUTdmQ2RVNFlN?=
 =?utf-8?B?WWtpOHdxN2dpQ2MyZU1sK1dIVEtEaC9sYnhIRXlwaDNaM0REWUZOWUd5S2t4?=
 =?utf-8?B?blR5UENFTmFnYXFFTUJDTVpITDM3akQxN1JYRFI0ZjUyUE8veTJpd3dPZG1v?=
 =?utf-8?B?SzV6Zkxmc2pHZFdpVyt3QjFnYlB1Mk80dTJHVWhvL1BXNEdYR2RPMXpVcEVX?=
 =?utf-8?B?amQ4c2FnaFZTK09zbHgyNUg3Tk1mRVhBOHlwNUVxbVZZRWxLdWlxQ3FDQ0pI?=
 =?utf-8?B?NldkeEc2TTFhRnN4ZWZ2SXFkQitENFRDQ0FKR2hWQ0NzUithNVBBTy9sVWpP?=
 =?utf-8?B?WVhpdTZ6QnFKdnB5Y2s3Ynp6TmtzQkJuNG1yL0NHdjhvMkNMUkRPWDNKSWV2?=
 =?utf-8?B?NHhyUXM3dGwwRDZPMmF2UVNkTm5XeThQaTlnY2JmQ004MnNQcnE1N2V2K1d2?=
 =?utf-8?B?U3pMd3Y1ako5cjBuSEcxUnh3THdSQjFUM3hzaWZvd3pMQW55WG1EVk9weG9P?=
 =?utf-8?B?RkZLdFF0bG85UWN0ajhxa0oySitSQ2tZS3R3cU9ieWp3UnlKYTBMbFUwZlR6?=
 =?utf-8?B?NjVqN2pyWWsyTVZhV3ZGd0NpSSsyU3hYSjJmd3V2aVFnam9oT3lTU2dmWjVI?=
 =?utf-8?B?cHhPZ1N3WkJZT2VKY2l1RHhNZVNBK3BZQnlUN0pzdnN3Rk5NaDF1aDBMelBD?=
 =?utf-8?B?cTAwN0ZuTTZ0b3pPREp4cDRCZlFQcFkzWHJ6Ny90aGJHY3A0ZjJDZUtRSE8r?=
 =?utf-8?B?d0JCbUVGZlljNzBrWU1xMXVBd0MwQmllODIxNkVvRzc3Z0FSREJCcnF2d2x4?=
 =?utf-8?B?blRMV3hyUzYzeSs5QURzQ0poK2lvbGRtSDJlSkJzU1VXSGR2OU9vRlpldWxh?=
 =?utf-8?B?MjlHWTdpQXNUZUtXTjBpSXRJWFZvOWlnRUR6WnN4cWRFMWwxR1ZMdW9DYzFy?=
 =?utf-8?B?dU9vM1cxNC9JSkYreGlXRmpDbVJyWWJlWWVndnpEMi90WkJNVERrcjlDYWhp?=
 =?utf-8?B?azhQUXZ0emFlZ0E0bXFzVDlOS2FZS0NPZ053dHJwNXRXeit0S3dYQnpZRC9R?=
 =?utf-8?B?dGdOaDZ0SjVQK0U0bnhkYnUxSVlrWlRRTC9MUEpad043L2lQeUVnM2o0akpu?=
 =?utf-8?B?M1lhYm9nY3BMam41dlBJTnBHWStIMWI2MEE4NVBqMUtXTDczNm9JZW1udDQv?=
 =?utf-8?B?QVVXZlJjZm1BQ2hCS2QrUmQ3UHRNMkZTdFVBV21Ncit5azZGMVJOWHpZZ1Rp?=
 =?utf-8?B?bWRwRmF0d0NzN2xza3VxWkhQK09yY3M1TnNEWTBMNFhSNDN5V0JWcVpZdmoz?=
 =?utf-8?B?WHJYOWxuUjdIc0RGZmUyS21KWitzSGM3aHJNcCtxRnQyYXRGUlFBR0NpaUNh?=
 =?utf-8?Q?s8yunRXZ8rQhC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmlha0dqSFZxMDFrUGd5UkJFMDI0QjlGVE5CUU9neE8rOE41c21qTUQ0eVNH?=
 =?utf-8?B?Z2JJcTFFRGJwM0J0VC9hNVBxeWdXT1grRDZPdElCaXF0OGEvVm1PNW13ZzYx?=
 =?utf-8?B?Q3gyYjg1b05neWtQUlZ6QXJXdDl3WmhZM2wyS3JlYWxWUFFjdmhQL2o3Qndx?=
 =?utf-8?B?bURGa09SSUNOSnNIeWVzK3djekZqZFlXSTZJWFlGZ0VacFhEUUxEd1d5T0Zo?=
 =?utf-8?B?NjBsOWtPaEFacVhNTzBaR1BsZmZwbmhmTkxCZGxQZjZVUHlUV09tOUpPYkZj?=
 =?utf-8?B?NmFtb1VOdWJsbDMxWkhlNnVOVHY4WnloWVNnL1dPckZRQkRTMXM4anpUZ0pz?=
 =?utf-8?B?TWV6eCtsZVpRakltMjJpcFVkT1prR0hqWlZHYk1iM2JtMnIvbldJSm9pVXNL?=
 =?utf-8?B?dTBORUw5YzB0MUdLb21xTUwwOVVEdUJzMnBkTTRzQlpHaUFZZm93WmNLeXlh?=
 =?utf-8?B?c3NSd2RDVFNJb3QwMmUzZ2U1TlYvQWtZTk1tSEdkWmVDQmFONUhPNkhMck9B?=
 =?utf-8?B?dXBCek5jRWdDUUpVQW90cWNnVE9DcFpwd09tU3F6Nmt0ZzlPc3ZzdDJZdm4w?=
 =?utf-8?B?cFR1dDM3eEYzMThBVXpOL2VoVDM2emZvTjJ4VXg0YUcveEVOeXJmb0VWbXB0?=
 =?utf-8?B?b0g3TkdMMVhMbXFJSEtMSzkyVHVWYUp4L2ZTNVlEenJPVkxWM2NzL2tmZGNa?=
 =?utf-8?B?dEVqU0xPN3I5alFjTlc0ZFMxK21VVlZFV1JpQnN1K3liN0FjZk4vbFdkNHdS?=
 =?utf-8?B?SnU4ZmFPcDFnMzZNSGJhdW5ndlFEN2VnYnFMYythZFhjQkhHOCtmSlFoekVQ?=
 =?utf-8?B?N1ZKaVRkVzcxVjd3bVNneUM1aVdYdkNaOUtBZFhFZ2NOYVlFMXk5c3lkdnJW?=
 =?utf-8?B?UXJKYWc1NWNhSHhQd2hQeHFySW5mMk9uTGtpM2Q3aTBRa2NKRHNpanpZMlFC?=
 =?utf-8?B?ek5KTzc4S1F1V2tYYnhPOU1ZeXkwZCtaaERLTUVPL2cwc1A2UDdNdkh0eEU4?=
 =?utf-8?B?WUZqeHZzT2Z3bFExb1pGcG52NGxjUVF6SGJNek9FVis2RFNzNi9seHNZMWI3?=
 =?utf-8?B?RXFwWUZlekxtVmowNkhKanFtazRRN3J6TS9FUnM1TWdLNlJFTmpXYUhnUFJq?=
 =?utf-8?B?dHUrdzdWNHdoQU10VktodXliNXlERVMwa2VwckIwcEw4SFJIWGxPS3lzeFpO?=
 =?utf-8?B?aDdtZWdUdk5LT3I3RklkYzNQdkJKL0dtZTZVM3hET2M3RUpQc0Qzc3pmcmpp?=
 =?utf-8?B?SWMyNlBkcXE0MTRodjM3L1laY1pmV3JCZCtJMGROYU14aFBMRVh0NVZCUDBP?=
 =?utf-8?B?b2YrbTZpSlV4WWdvbzdIMktNbzJobEVCN2t6VUxsZ1g3WG53SmFJTDhGbHpy?=
 =?utf-8?B?R2o2bEg1ZS93cmJqK2pQV0N3M2Y2K3N1cUVpTUkvMUN1dHhtZEs0VmtCbG9K?=
 =?utf-8?B?dnFZWGJmQzN6RDVsV2g1MnJoazBvMFNseXBhOUI0N0RpZG5mL2xrcDVYem9Z?=
 =?utf-8?B?VHpEK2ZZeS9zNU82b1RaSHlodFJiUUlXQ1NtaVNheGdTQ1dyKzdmMHlIbEMv?=
 =?utf-8?B?MEF3dFo3VnlGOVU1MUJIQVlTSWdzWDdoRlN6TDdCQWc4aFB4bzc3RmtVV0h6?=
 =?utf-8?B?V2hWNytzWjJ6M0Z1NzI3YzRnUHRuekwwWWlRU3AySmI2QS9MbFJUZC9sTHc0?=
 =?utf-8?B?VHpsUitGY0R4WGJRQ1BVR1I0NkgyaVFBd3JQUXJPdDVYWVFIQTN4MGxQTUpR?=
 =?utf-8?B?SDlOak1uK1VHWkhPdC93UkFQeWMvaVZrRlhESVUwNjJhWHRqRHB5NVozbk5h?=
 =?utf-8?B?cmRaYVJSQ0djUmhlTHhoT0l5bk5EUURtM2VVODdXdlVyajdHSTFDTjlsaU9K?=
 =?utf-8?B?RFJrMktxaFlJUXdEQUUwd0ZyMk5yVFFWTjVHZkF6RmxsalRQRXUyTERNaHRW?=
 =?utf-8?B?WE5YdnFoOUJ2UTNLSlI3TFJ4QTBhSis1OG0xUGUraktMVlg1U1RhSkErUzB5?=
 =?utf-8?B?SmVBSXMvSmhuVkNHb3BEQzIycmdSbVpaVTVUSnprT2ltZlFmN0xqTnZnQk9N?=
 =?utf-8?B?UG50T0tYNmNVZ0hLWEJ5SjIrQXB2eHA5QXVyaVBWbUU4aU5Wc0w2YUZLZ1Jy?=
 =?utf-8?B?dkQ3YkVQc3h1SlB6OW8zVXE3TWNRZzFkNUNVU20zWE5IVVRGaU5FWWd6ZjVJ?=
 =?utf-8?Q?lRn/ODXUGY+jNrN2WTTITuw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39749c39-64dd-4e9f-f1bc-08dd354e93be
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:22:56.0590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ha0bQ5LRCzjIU7bJ68hqPyiPauawGuPbWbJ8tvWtWIm5s92Dl/MnbqkNnBhXcr0xxKHhIuolilMmlZHsgmuEMeDUwhF7IZhSdLAB1Pbesjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477
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

Hi Marek,

On 1/12/25 11:34 PM, Marek Vasut wrote:
> Introduce board/renesas/common/Makefile and remove the multiple
> duplicate copies of obj := ../common/*.o from board Makefiles.
> Let the build system include the common Makefile using the
> HAVE_VENDOR_COMMON_LIB and build the common objects that are
> shared by all the boards that way. No functional change intended.
> 

Thanks for highlighting this HAVE_VENDOR_COMMON_LIB mechanism, I'm now 
planning on migrating the Theobroma boards to that :) (I would need 
https://lore.kernel.org/u-boot/20250112223252.179123-1-marek.vasut+renesas@mailbox.org/ 
though :) ).

> Some of the remaining board files which include board specific
> settings have been updated to use obj-y += to avoid rewriting
> the board obj-y target and avoid dropping object files from the
> build.
> 
> Board Makefiles cannot be empty, else they do not generate built-in.o,
> move the CONFIG_XPL_BUILD ifdeffery from Makefiles into .c files to
> make sure there is always a built-in.o generated from the remaining
> minimal Makefiles. This will be further cleaned up in follow up patches.
> 

Unrelated, but I misread the commit log and was wondering whether this 
patch series would work without the additional patch from 
https://lore.kernel.org/u-boot/20250112223252.179123-1-marek.vasut+renesas@mailbox.org/ 
so wanted to build an Rcar defconfig to verify but I'm unable to build 
r8a779f0_spider_defconfig from master:

/usr/bin/aarch64-linux-gnu-ld: 
/usr/lib/gcc/aarch64-linux-gnu/14/libgcc.a(lse-init.o): in function 
`init_have_lse_atomics':
/builddir/build/BUILD/cross-gcc-14.2.1-build/gcc-14.2.1-20240912/aarch64-linux-gnu/aarch64-linux-gnu/libgcc/../../../gcc-14.2.1-20240912/libgcc/config/aarch64/lse-init.c:46:(.text.startup+0xc): 
undefined reference to `__getauxval'
/usr/bin/aarch64-linux-gnu-ld: 
/usr/lib/gcc/aarch64-linux-gnu/14/libgcc.a(__aarch64_have_sme.o): in 
function `sme_accessible':
/builddir/build/BUILD/cross-gcc-14.2.1-build/gcc-14.2.1-20240912/aarch64-linux-gnu/aarch64-linux-gnu/libgcc/../../../gcc-14.2.1-20240912/libgcc/config/aarch64/__aarch64_have_sme.c:49:(.text.startup+0xc): 
undefined reference to `__getauxval'
/usr/bin/aarch64-linux-gnu-ld: 
/usr/lib/gcc/aarch64-linux-gnu/14/libgcc.a(__arm_tpidr2_restore.o): in 
function `__arm_tpidr2_restore':
/builddir/build/BUILD/cross-gcc-14.2.1-build/gcc-14.2.1-20240912/aarch64-linux-gnu/aarch64-linux-gnu/libgcc/../../../gcc-14.2.1-20240912/libgcc/config/aarch64/__arm_tpidr2_restore.S:88:(.text+0x90): 
undefined reference to `abort'
/usr/bin/aarch64-linux-gnu-ld: 
/usr/lib/gcc/aarch64-linux-gnu/14/libgcc.a(__arm_tpidr2_save.o): in 
function `__libgcc_arm_tpidr2_save':
/builddir/build/BUILD/cross-gcc-14.2.1-build/gcc-14.2.1-20240912/aarch64-linux-gnu/aarch64-linux-gnu/libgcc/../../../gcc-14.2.1-20240912/libgcc/config/aarch64/__arm_tpidr2_save.S:95:(.text+0x9c): 
undefined reference to `abort'
collect2: fatal error: ld terminated with signal 11 [Segmentation 
fault], core dumped
compilation terminated.
make: *** [Makefile:1812: u-boot] Error 1
make: *** Deleting file 'u-boot'

so cannot check myself.

I'm running Fedora 41.

$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (GCC) 14.2.1 20240912 (Red Hat Cross 14.2.1-1)

> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   board/renesas/common/Makefile         | 45 +++++++++++++++++++++++++++
>   board/renesas/common/gen3-common.c    |  3 --
>   board/renesas/condor/Makefile         | 13 --------
>   board/renesas/draak/Makefile          |  6 +---
>   board/renesas/draak/draak.c           |  4 +++
>   board/renesas/eagle/Makefile          | 13 --------
>   board/renesas/ebisu/Makefile          | 13 --------
>   board/renesas/falcon/Makefile         | 13 --------
>   board/renesas/grayhawk/Makefile       |  9 ------
>   board/renesas/salvator-x/Makefile     |  6 +---
>   board/renesas/salvator-x/salvator-x.c |  4 +++
>   board/renesas/spider/Makefile         |  9 ------
>   board/renesas/ulcb/Makefile           |  6 +---
>   board/renesas/ulcb/cpld.c             |  4 +++
>   board/renesas/ulcb/ulcb.c             |  4 +++
>   board/renesas/v3hsk/Makefile          |  5 ---
>   board/renesas/v3hsk/cpld.c            |  4 +++
>   board/renesas/v3msk/Makefile          |  5 ---
>   board/renesas/v3msk/cpld.c            |  4 +++
>   board/renesas/whitehawk/Makefile      | 13 --------
>   20 files changed, 72 insertions(+), 111 deletions(-)
>   create mode 100644 board/renesas/common/Makefile
>   delete mode 100644 board/renesas/condor/Makefile
>   delete mode 100644 board/renesas/eagle/Makefile
>   delete mode 100644 board/renesas/ebisu/Makefile
>   delete mode 100644 board/renesas/falcon/Makefile
>   delete mode 100644 board/renesas/grayhawk/Makefile
>   delete mode 100644 board/renesas/spider/Makefile
>   delete mode 100644 board/renesas/whitehawk/Makefile
> 
> diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
> new file mode 100644
> index 00000000000..2072338ea05
> --- /dev/null
> +++ b/board/renesas/common/Makefile
> @@ -0,0 +1,45 @@
> +#
> +# board/renesas/whitehawk/Makefile
> +#
> +# Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +
> +# R-Car SoCs
> +ifndef CONFIG_RZG2L
> +

This is a bit out of context, can you explain why this suddenly is here?

> +# 32 bit SoCs
> +ifdef CONFIG_RCAR_GEN2
> +endif
> +

Not sure we need this noop?

Also this probably should rather be CONFIG_RCAR_32 instead?

> +# 64 bit SoCs
> +ifdef CONFIG_RCAR_64
> +ifndef CONFIG_XPL_BUILD
> +obj-y	+= common.o
> +endif
> +
> +ifdef CONFIG_RCAR_GEN3
> +ifdef CONFIG_XPL_BUILD
> +obj-y	+= gen3-spl.o
> +else
> +obj-y	+= gen3-common.o
> +ifdef CONFIG_R8A77970
> +obj-y	+= v3-common.o
> +endif
> +ifdef CONFIG_R8A77980
> +obj-y	+= v3-common.o
> +endif
> +endif
> +endif
> +
> +ifdef CONFIG_RCAR_GEN4
> +ifdef CONFIG_XPL_BUILD
> +obj-y	+= gen4-spl.o
> +else
> +obj-y	+= gen4-common.o
> +endif
> +endif
> +endif
> +
> +endif
> diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3-common.c
> index 549bec9e137..840ea6d7820 100644
> --- a/board/renesas/common/gen3-common.c
> +++ b/board/renesas/common/gen3-common.c
> @@ -17,8 +17,6 @@
>   #include <asm/arch/renesas.h>
>   #include <linux/libfdt.h>
>   
> -#ifdef CONFIG_RCAR_64
> -
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   /* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup. */
> @@ -182,4 +180,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	return 0;
>   }
>   #endif
> -#endif
> diff --git a/board/renesas/condor/Makefile b/board/renesas/condor/Makefile
> deleted file mode 100644
> index 3b1756b44cd..00000000000
> --- a/board/renesas/condor/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/condor/Makefile
> -#
> -# Copyright (C) 2019 Renesas Electronics Corporation
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/gen3-common.o ../common/common.o
> -endif
> diff --git a/board/renesas/draak/Makefile b/board/renesas/draak/Makefile
> index 6ce05bcd649..945cc2134e8 100644
> --- a/board/renesas/draak/Makefile
> +++ b/board/renesas/draak/Makefile
> @@ -6,8 +6,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= draak.o ../common/gen3-common.o ../common/common.o
> -endif
> +obj-y	+= draak.o
> diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
> index a51bf65674f..b742b8d6220 100644
> --- a/board/renesas/draak/draak.c
> +++ b/board/renesas/draak/draak.c
> @@ -6,6 +6,8 @@
>    * Copyright (C) 2017 Marek Vasut <marek.vasut+renesas@gmail.com>
>    */
>   
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +
>   #include <cpu_func.h>
>   #include <hang.h>
>   #include <init.h>
> @@ -65,3 +67,5 @@ int board_init(void)
>   
>   	return 0;
>   }
> +
> +#endif
> diff --git a/board/renesas/eagle/Makefile b/board/renesas/eagle/Makefile
> deleted file mode 100644
> index a5c18d81eef..00000000000
> --- a/board/renesas/eagle/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/eagle/Makefile
> -#
> -# Copyright (C) 2015 Renesas Electronics Corporation
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
> -endif
> diff --git a/board/renesas/ebisu/Makefile b/board/renesas/ebisu/Makefile
> deleted file mode 100644
> index 72130b76234..00000000000
> --- a/board/renesas/ebisu/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/ebisu/Makefile
> -#
> -# Copyright (C) 2018 Renesas Electronics Corporation
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/gen3-common.o ../common/common.o
> -endif
> diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
> deleted file mode 100644
> index 949953f6981..00000000000
> --- a/board/renesas/falcon/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/falcon/Makefile
> -#
> -# Copyright (C) 2020 Renesas Electronics Corp.
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/gen4-common.o ../common/common.o
> -endif
> diff --git a/board/renesas/grayhawk/Makefile b/board/renesas/grayhawk/Makefile
> deleted file mode 100644
> index a70bd3739f1..00000000000
> --- a/board/renesas/grayhawk/Makefile
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#
> -# board/renesas/grayhawk/Makefile
> -#
> -# Copyright (C) 2023 Renesas Electronics Corp.
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -obj-y	:= ../common/gen4-common.o ../common/common.o
> diff --git a/board/renesas/salvator-x/Makefile b/board/renesas/salvator-x/Makefile
> index fe53366829c..daea3e6838f 100644
> --- a/board/renesas/salvator-x/Makefile
> +++ b/board/renesas/salvator-x/Makefile
> @@ -6,8 +6,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= salvator-x.o ../common/gen3-common.o ../common/common.o
> -endif
> +obj-y	+= salvator-x.o
> diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
> index 2c8860bcee4..b6fb106ca5d 100644
> --- a/board/renesas/salvator-x/salvator-x.c
> +++ b/board/renesas/salvator-x/salvator-x.c
> @@ -7,6 +7,8 @@
>    * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>    */
>   
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +
>   #include <cpu_func.h>
>   #include <image.h>
>   #include <init.h>
> @@ -93,3 +95,5 @@ int board_fit_config_name_match(const char *name)
>   	return -1;
>   }
>   #endif
> +
> +#endif
> diff --git a/board/renesas/spider/Makefile b/board/renesas/spider/Makefile
> deleted file mode 100644
> index e0f403d5fcc..00000000000
> --- a/board/renesas/spider/Makefile
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#
> -# board/renesas/spider/Makefile
> -#
> -# Copyright (C) 2020 Renesas Electronics Corp.
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -obj-y	:= ../common/gen4-common.o ../common/common.o
> diff --git a/board/renesas/ulcb/Makefile b/board/renesas/ulcb/Makefile
> index 6b2aa8c29f6..4f608613c15 100644
> --- a/board/renesas/ulcb/Makefile
> +++ b/board/renesas/ulcb/Makefile
> @@ -6,8 +6,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ulcb.o cpld.o ../common/gen3-common.o ../common/common.o
> -endif
> +obj-y	+= ulcb.o cpld.o
> diff --git a/board/renesas/ulcb/cpld.c b/board/renesas/ulcb/cpld.c
> index e72e45e3fb4..6a708d86cc8 100644
> --- a/board/renesas/ulcb/cpld.c
> +++ b/board/renesas/ulcb/cpld.c
> @@ -6,6 +6,8 @@
>    * Copyright (C) 2017 Cogent Embedded, Inc.
>    */
>   
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +
>   #include <command.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> @@ -189,3 +191,5 @@ U_BOOT_DRIVER(sysreset_renesas_ulcb) = {
>   	.of_match	= renesas_ulcb_sysreset_ids,
>   	.priv_auto	= sizeof(struct renesas_ulcb_sysreset_priv),
>   };
> +
> +#endif
> diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
> index 64f01b123cb..e1445adbb69 100644
> --- a/board/renesas/ulcb/ulcb.c
> +++ b/board/renesas/ulcb/ulcb.c
> @@ -6,6 +6,8 @@
>    * Copyright (C) 2017 Renesas Electronics Corporation
>    */
>   
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +
>   #include <image.h>
>   #include <init.h>
>   #include <malloc.h>
> @@ -84,3 +86,5 @@ int board_fit_config_name_match(const char *name)
>   	return -1;
>   }
>   #endif
> +
> +#endif
> diff --git a/board/renesas/v3hsk/Makefile b/board/renesas/v3hsk/Makefile
> index 936047cb3d5..0091bc9cd5b 100644
> --- a/board/renesas/v3hsk/Makefile
> +++ b/board/renesas/v3hsk/Makefile
> @@ -7,9 +7,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
>   obj-$(CONFIG_SYSRESET)	+= cpld.o
> -endif
> diff --git a/board/renesas/v3hsk/cpld.c b/board/renesas/v3hsk/cpld.c
> index 1272aec7302..b82622f9c54 100644
> --- a/board/renesas/v3hsk/cpld.c
> +++ b/board/renesas/v3hsk/cpld.c
> @@ -7,6 +7,8 @@
>    *
>    */
>   
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> @@ -177,3 +179,5 @@ U_BOOT_DRIVER(sysreset_renesas_v3hsk) = {
>   	.probe		= renesas_v3hsk_sysreset_probe,
>   	.of_match	= renesas_v3hsk_sysreset_ids,
>   };
> +
> +#endif
> diff --git a/board/renesas/v3msk/Makefile b/board/renesas/v3msk/Makefile
> index 21eaddb6c28..fe8bf1ed1ae 100644
> --- a/board/renesas/v3msk/Makefile
> +++ b/board/renesas/v3msk/Makefile
> @@ -7,9 +7,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -ifdef CONFIG_XPL_BUILD
> -obj-y	:= ../common/gen3-spl.o
> -else
> -obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
>   obj-$(CONFIG_SYSRESET)	+= cpld.o
> -endif
> diff --git a/board/renesas/v3msk/cpld.c b/board/renesas/v3msk/cpld.c
> index 260755ac746..93f3bf391cd 100644
> --- a/board/renesas/v3msk/cpld.c
> +++ b/board/renesas/v3msk/cpld.c
> @@ -7,6 +7,8 @@
>    *
>    */
>   
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +
>   #include <asm/gpio.h>
>   #include <asm/io.h>
>   #include <dm.h>
> @@ -365,3 +367,5 @@ U_BOOT_DRIVER(sysreset_renesas_v3msk) = {
>   	.of_match	= renesas_v3msk_sysreset_ids,
>   	.priv_auto	= sizeof(struct renesas_v3msk_sysreset_priv),
>   };
> +
> +#endif
> diff --git a/board/renesas/whitehawk/Makefile b/board/renesas/whitehawk/Makefile
> deleted file mode 100644
> index f10eb82d221..00000000000
> --- a/board/renesas/whitehawk/Makefile
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# board/renesas/whitehawk/Makefile
> -#
> -# Copyright (C) 2021 Renesas Electronics Corp.
> -#
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -
> -ifdef CONFIG_SPL_BUILD
> -obj-y	:= ../common/gen4-spl.o
> -else
> -obj-y	:= ../common/gen4-common.o ../common/common.o
> -endif

This honestly was a bit difficult to review and felt like more than one 
change was made at once.

The #if !IS_ENABLED(CONFIG_XPL_BUILD) changes could have been made in a 
separate commit I believe.

In any case, makes sense to me:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Would have liked a link to 
https://lore.kernel.org/u-boot/20250112223252.179123-1-marek.vasut+renesas@mailbox.org/ 
to explain why the Makefile cannot be empty in the commit log, but fine 
like it is.

Thanks!
Quentin
