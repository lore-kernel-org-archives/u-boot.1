Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631D5D3C54C
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 05:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA8888E6B;
	Fri, 18 Oct 2024 07:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQ77jByf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887BB89141; Fri, 18 Oct 2024 07:57:26 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCB282BA7
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8Kg31U6bls2WfLXtZ9lAqgDz1Jv7B2jLmUGmvvFo5Hh7LMo4ob1l4bt1ACdtWAvIqwxDLkFDanS2BHhf4w0LZARQjWZjDgEgYFldC1BrhNdJItfJ3doKJtRVMNOtxdl8eNjujsOnsveJUWIqnuqVpwhIrc6tc48IoYtkdZpN7n31Hb/YEDKULrn/bUfACx60VbqA05L2V9ztC21qFvis89RkFQSgpgFyHTj975nhC1oFlLMbIrVpGILZF0/c77jZKlijtT15SQQfqMuxpqBqKTLfyVtfr97lhW8q4zom84lAzFgC8BA3hKpXUSuDBd4BwvaUqJ6iUwOEJ5sgLo/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8akQRaFW/DHKJObc2t4wAp5/QPBDZxQK20u6u25HaQ=;
 b=B/+9Pa3dp4Fv8y2i/3gtcKg+UqJ475hixJitrjY1U5M9iWLONh86h0uTA6RRPbeyuiMChMREZcG8BC0BAwYropWdjehEr2OG4uZbM2b6riMIoaiQMSDoXSHMxfZRgds/d7Ez7YOeCslxFUCDj5xImarsmc3CFXieOPXnH56PDkCrOC+MGIfsEXbeXHzYgn/TLFegOQVpriQUjAwu4rWTMoh3qbCDH4Yd9FyD6vI7IsXdK80UEKSts9PS5OXxuPnXxymUk/KLfx6iYlVwSD6bqSfXCSoMRyN1TBOUPLBxcYatPH1eNs9W0nf9e4LtRUKsKMWuEWYavc7cSs3U3oy2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8akQRaFW/DHKJObc2t4wAp5/QPBDZxQK20u6u25HaQ=;
 b=cQ77jByfV3EXursHSIpALIz4yxIVaKi92/VAbyp0KhCszCMbwVnFrXb/kRa37wWLCB6XQSaLIRr2wH+MvJiyt3c5OBQtoo5sUWSLnGW3gyclE+SfWHi/Y3UJ54V3u0G2VSomFxhJOq8pfLvZQNqHzdJbkhIRm2hRELsvzuH3iSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 05:57:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 05:57:20 +0000
Message-ID: <553c766c-8351-432d-a04d-76c489ec19e0@amd.com>
Date: Fri, 18 Oct 2024 07:57:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
 <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
 <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
 <CAFLszTjt6rrHUzg=evPS5-FyvMrZ1DocwyVc9x1Pq2K9XMokCg@mail.gmail.com>
 <6e7f9046-2e7f-479a-80e1-59e7b20c48f7@amd.com>
 <20241017175455.GP4959@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241017175455.GP4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:803:14::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa7ba6d-79ed-4395-a18e-08dcef39ba4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDcxWGl1ZTFta1IxVGtCbDV1UkQ1S0ErSC80Y05kcVBvdGFGdGdpeDZoMk5V?=
 =?utf-8?B?aTgySW8xMkZhODF2cm5CVjVIbmdaTDlsQVM4ZlBaZmFtcmxPOHpYbi9oY1U0?=
 =?utf-8?B?SDhScUdMRmJwQk82anRhdlVnMDg4S3lkbmFVemN5VE02TW5TUmxyYjJOS1FZ?=
 =?utf-8?B?NlpBTzZFWk5uMTJ2UjFYT0lFNC9kUExBMzE1eUFQVWw1L0NIcGovYzRUVjIy?=
 =?utf-8?B?aTFBeEtaR0hxZ1RxcERmU3pwVlZlWU9zM2NvcmVPVisvSWNMVVhNR0pvK3FE?=
 =?utf-8?B?bnhPWk44bmlqdlpHRnFOU0E1MXB4T2RHMFFHcDBVU01DaVV0eXpjUFRRUnZm?=
 =?utf-8?B?OVhFL2cwaHIvdTBkbXhtWXZFTDVQQ3pHbThuN0tiWDVabE9qU2FmUE1BcGtx?=
 =?utf-8?B?NDZwMFVyWnAwZ3k2ZXJCellNaXZkZTV0citRcFlNNGl0ZXp1bU9qaW1YaTg4?=
 =?utf-8?B?dWxQQWxlN3czYlowbVo4OEhLbzFxb1ZJZ1dlKzE0QXZyalVyZjAzR0MrTkZt?=
 =?utf-8?B?SUphMm5HcThJRGxIcWtFaU5RNkdGS2ZoMGI2bWwremFUbHlSbGhoUG1HeGtx?=
 =?utf-8?B?RG9QeXhuSXU4TElQQUZuSFpWQkhZdUkwQnBsdXh1WWQyUGJUTEZsVDdhK0pH?=
 =?utf-8?B?RERldUxTbnhxVUhJV3l4UWZmR1dRajN1cjZlRnNpNWQ5M1RvbEJjNEdzTHBI?=
 =?utf-8?B?N2xGMzU1RCsvVkdLSTJsbkZwUStIaW53eXVWL2dydEphUDE3WUZ4MUdrV21X?=
 =?utf-8?B?TUtsNUtWVHEyOFRidzZNZ1ZFQTJVMVp5ZXkwQlNndStYN3VjWU15K2JNb0tS?=
 =?utf-8?B?K0RSWXpsSE9UMmVCZGJ6ZFVnNGEvb1R0bzlQeXA4SlNJWjhBYjljN2c5dUJp?=
 =?utf-8?B?UFhrWVRodlNPcUpJS2ZiMlNZdWtCTldDWTBDUzlLK29RV0pwKzRGa0hEbUV4?=
 =?utf-8?B?Sngra01wblh1bkNhWnBuUXlPVllUZURSMjZPOWdOb21URXpSZmxMVHJPR3Vz?=
 =?utf-8?B?aDRld0VqM2lVWDNLc1h1N3g3Mi9HV1VQTkg3em5yVTA0VWEvSzh1aWJMREdT?=
 =?utf-8?B?Qnk0MDFrUWk0Wnl5NVJCbE4xT0I5U3NvNXZKSWlFWW5ZUTZhQ054dWdGTzk0?=
 =?utf-8?B?Vi9pNjBWNFBBOWQ2ekZzN05DVGhKbHdFRHdJM0dVVEVlZ0VJK0R1eVpIb3dE?=
 =?utf-8?B?QUZEQ3p0dVVsSTZZSFZJUWhMd2t0LzZxczgzU251OUlScE11bzU2ay9xWWQz?=
 =?utf-8?B?eXl6WG96aHQ1cGlmZ3RqcHEreUNNS2d6eWdBLzNkTGl1SkRDempZdUZzL1dS?=
 =?utf-8?B?a3M0QVloRm9ZUzhNby9mbFlOR1NyQ3EvUmNzUnRWcXM0dWp1elJJbW9JYk1L?=
 =?utf-8?B?WVhGcGpoai9FSFRjdmU0K292ODRoT1NrQ0NqQ3RZU2xERW5RZlFLM2NQYjdT?=
 =?utf-8?B?aE5wMWorU2w2WlhLazFKQXcwK2lPNGRONTZ3RGNLQ1NIM1p2ZkU2amUxU3V1?=
 =?utf-8?B?UUFSUFpCMmRWc3VhZWdIWGdCend5ejcvcFhXSnpvMjIvZzBuWjZIdmtQZFlM?=
 =?utf-8?B?MHI3RUdWQVYvdEZ0eks3WTRlUWZGMDBlajRRZ2xjRjlqalRtcENqaldRM2lh?=
 =?utf-8?B?aWFrbmtRYmxEemsvcFVGMU1MMFhMT3NJRnRYTXZJZXYxV2RoaGVCN2lWTWgy?=
 =?utf-8?B?UDQwNDlhTjRmQmJ0VWo3R2RTaUNiT25TaGJ1cTN3bVNBSUtOT1oxNGxRaHp6?=
 =?utf-8?Q?WktHGUQKugtGyEmJhjW2iYAMVEt2DzcAlyXCdYA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTREdi9EZHM1Y2dwOVU1dk5jQi9jUUdKSGdwU1pDMTB1b21PYm9DRWVaYk1F?=
 =?utf-8?B?T2drbjd5Qlo3QWROZ3pEa1l6TXE4SHdwZVNGNDdLODc3TVhXWi9nMVVDTDZz?=
 =?utf-8?B?MWxkb2VJaWpYWm1yS1UrcXNjSnpRV0dTdG0xSkh3cjNDTHUxTHQ3OXRwTmxs?=
 =?utf-8?B?UUdmV1YwQ2E1QjlYRDkvdFE1RjQxVHYxQnV5Z1FHOGNnOEl0akFWY3UvMUpN?=
 =?utf-8?B?NmM2RXFtSjIxUmM3d1RVQlc4VWxqRlNPQWxHdGNFR1NXWnIvRFREalhCNWRs?=
 =?utf-8?B?NERWUStLbEpEaFp5YjBEa3l3RFlpRGJXVWNkWTlCb3VnY1NGOFV3d2FtR0Ur?=
 =?utf-8?B?WlovTmFQbUJwTkZncXZnL1VlV2ZqeDZpL1l5L1p5Z3VoMFNEbUZkSGExWjdN?=
 =?utf-8?B?VnJBME1JRysrV0xmb1B6T3I3bEpoZXdDMzNzNFQwTDRqTzJMK3NnSmVObEtS?=
 =?utf-8?B?ckF2cHBSdUtaNUlmem01WFFLd1hpdG5xeC9ZdkVjZnNlM2RGU3FvcUgzdXo2?=
 =?utf-8?B?NUg5cnBXRGdpZ0FSZzU2VlVXTHVXKzBSVDRjT0d5S2lTdnBIVlpRVlpEdThO?=
 =?utf-8?B?cE5wRHMwMC9Yckh0RWVFeHdjWnlUZzAvejcrdjg0ZW5ZZWY5cmV6RUowbDMy?=
 =?utf-8?B?Y2phKzhRWVdoL0JFWVl6MlM4eldCUlE0YjNnWjZLdllWUTlQMFdpUlJscEhY?=
 =?utf-8?B?S1hYdlpFVGlaMkZWd1FxUXNsK1RPVDUydFdQaUh0N1YxWHo1NVI2di90eFdY?=
 =?utf-8?B?NEp5WWw0cnJBelQydC9Pam9CSm40dEZudnBoUmhnVkFTSGFFVXNXN0ZWME9H?=
 =?utf-8?B?R3N6QkxvZjJ1VVlrT20yWGtZc2JvSm9RL2FxWGtPNjFxK2szZ3ozUUFmZGtq?=
 =?utf-8?B?R2JoWVI1bWdCZFNYc1AwMHN1OGZGWlVsUWpqdXBqMjk3QkNZZExCVW5hY2RN?=
 =?utf-8?B?QUhkM1hTZFpVaWQ4amVmK2R5S09MNm1xZmI3dWNia2ZNSmhWRWdHYWNudFJQ?=
 =?utf-8?B?ZExFditnMzZWWGRpTkljUTV0SFFEeDlPTEpLdTI4T2I2K25DR0EzM2dsZnRT?=
 =?utf-8?B?dmVjUjhhQStOK2orSHQxSHlLK1BZQXBCeGplbUk0djZyellyVWNZUExTeHFW?=
 =?utf-8?B?d2UvS0MrVXJ6V3JOVFNFMWVCZW8vTHd2QloxN3hSU3JWdUk1NHMxekxTZVhh?=
 =?utf-8?B?UTNtbTRoWWlzR3hsU2xycXpxekhMYlprTk04TFBkUEpaS2gya2M0Z3JDaUZJ?=
 =?utf-8?B?V0FuOVhKMUtwV05ZcE1FaUhwV01kODZmWXdYVXRPaU5KQm5vbVJtejFCZStm?=
 =?utf-8?B?a0ZiM09PMXdpQStYK01ZUjUxTUxlNUt3eUNWNlJqN0xyRjVKa2R3QmlVdVM4?=
 =?utf-8?B?ODJoYW05bFYyajYyQ3V5bkJCMzZRUGFEenBYcEdwZ0VnUmJBUlc5NnQ4d2NT?=
 =?utf-8?B?WStwdEk2RVJMZnF1M003L1A1M2pubmFQUVE1ZmFhNUZDRURVSzJVd3RiTmtH?=
 =?utf-8?B?UnV2Q2ZKRkZmZ3hoTXZxemJTN3NhVGlCTCsvb215bU5BcHlJT1lOZ3V3M1N4?=
 =?utf-8?B?d1h6TCt2cXlsWkNkWkNESlptS0V2VVdiTHZMOFNhODcyZFNYUkY5anppQzFG?=
 =?utf-8?B?eExtQ0ZNbjVCbm9pVWhEZVhNTzZXQnNVbDRjSjRwdUg5dDVNWWJhSEdlL0pH?=
 =?utf-8?B?bW14eDYreGFLdXJ6YldXMWplSmlJMElNcnJISjNRQmVFdTdnZFUxSW84VjEw?=
 =?utf-8?B?dmNTMmVCZ0lIWXpwSFRZaFBsTHdmYldqWkpva2RRNHNRQWlINm9qZHFiSWsx?=
 =?utf-8?B?Qk5NLzBHSXJ4UkZ4WDlNVWN0OU9TenQyZ0tYS3pMczlYYldMWkdDOXd3ano0?=
 =?utf-8?B?MXVHK2ZqY29uc1pBeWpLTStaNFZVRkdiQktreDQzTU04THdpcE83RXY1eDdC?=
 =?utf-8?B?RlpvTEpENVN6V1dkY2UybTFYSDZuL0lDTjN6Q1QwMHk5QlE2S3liNG91R0tD?=
 =?utf-8?B?NnorU3VYZm5sR2RRSGxqdEhoQ2JmSzVDSzM0bHkwUjU5bHZqeVJENDFaQlgy?=
 =?utf-8?B?NC9IeTR1bWVJTUg3ZWMzK29LcFFNNS9TQnlCSi9DOFo0ZyttWUtoSW5xR2tw?=
 =?utf-8?Q?YlPs+OUnixCFNMqk3aZwPWWEG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa7ba6d-79ed-4395-a18e-08dcef39ba4b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 05:57:19.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+1Jfz22IeQty4Frl46N9hpeV8jRY/Y6UjZh23JMGBWA/EWYlhGYIQYZs9Z1CMW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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



On 10/17/24 19:54, Tom Rini wrote:
> On Wed, Oct 16, 2024 at 07:59:59AM +0200, Michal Simek wrote:
>> Hi Simon,
>>
>> On 10/15/24 14:48, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Thu, 10 Oct 2024 at 07:03, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/9/24 23:14, Simon Glass wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 10/9/24 03:55, Simon Glass wrote:
>>>>>>> Hi Michal,
>>>>>>>
>>>>>>> On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>> Adding binman node with target images description can be unwanted feature
>>>>>>>> but as of today there is no way to disable it.
>>>>>>>> Also on size constrained systems it is not useful to add binman description
>>>>>>>> to DTB.
>>>>>>>> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
>>>>>>>> target from DTB for binman itself.
>>>>>>>>
>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>      Makefile    |  2 +-
>>>>>>>>      lib/Kconfig | 10 ++++++++++
>>>>>>>>      2 files changed, 11 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>
>>>>>>> Doesn't this defeat one of the purposes of Binman, i.e. to document
>>>>>>> images? We do want the .dts to include the image description. What
>>>>>>> sort of problem is this causing?
>>>>>>
>>>>>> We have two boot flows.
>>>>>> The first one (default one) is using Xilinx FSBL for SOM initialization with fit
>>>>>> image (DTBS) + u-boot.elf + tfa.
>>>>>>
>>>>>> The second one is using U-Boot SPL instead of FSBL. This flow is used by
>>>>>> buildroot for example.
>>>>>>
>>>>>> In perfect world I should describe both of these flows. I sent description for
>>>>>> the second as RFC here.
>>>>>> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
>>>>>
>>>>> OK I'll take a look.
>>>>>
>>>>>>
>>>>>> but it is also reasonable to describe the first flow but I really don't want
>>>>>> both descriptions ends up in the target image.
>>>>>
>>>>> Why not? Knowing what is in the firmware is one of the goals of Binman.
>>>>
>>>> If this is single binary composition with clear layout then likely fine.
>>>> In our case where we target evaluation boards which can boot out of different
>>>> boot devices it will be more confusing.
>>>> For these I want to generated all images also for testing purpose not only
>>>> images which you will burn to qspi.
>>>>
>>>>>>
>>>>>> The second part is if you look at RFC and how fit-dtb.blob is composed. It is
>>>>>> one DTB + DTBS which are composed from overlays.
>>>>>>
>>>>>> xilinx_zynqmp_kria_defconfig has
>>>>>> CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
>>>>>>
>>>>>> That's why binman node should go to this DTB but because other images are
>>>>>> composed with overlays binman node is spread to all DTBs inside FIT image.
>>>>>>
>>>>>> It means one binman description is in fit-dtb.blob 14 times which is far from
>>>>>> ideal.
>>>>>
>>>>> Yes, but I think what you are saying is that U-Boot doesn't need the
>>>>> description, so you don't need it to appear in the dtbs in the FIT. Is
>>>>> that right?
>>>>
>>>> Yes.
>>>> I know that there is a code around it but as of now I don't want to use any of
>>>> this feature.
>>>>
>>>>> If so, then I think we should add a way to remove it, in Binman,
>>>>> perhaps with a property in the top-level binman image.
>>>>
>>>> Works for me but keep in your mind that for SOM this should be removed from all
>>>> combinations and for me it is easier not to add that description there instead
>>>> of adding it and removing it.
>>>
>>> OK, I think you are saying that the description is repeated in each
>>> .dtb since each is built by U-Boot's build system and then they are
>>> added to the FIT.
>>
>> yep
>>
>>>
>>> But what is to stop people from not bothering to fill in the binman
>>> description in U-Boot? I worry that vendors will have instructions
>>> like 'build U-Boot with the in-tree devicetree, which has no binman
>>> node, but pass this option to use this other file (not in mainline,
>>> just our special vendor branch), just for Binman's use',
>>>
>>> Where do you plan to keep this other file?
>>
>> In u-boot repo of course. And all configurations which makes sense.
>> And pretty much if vendors wants to hide it they can no matter of this patch.
>> I understand your concern but vendors can do it today.
> 
> Will resolving this let us finally remove SPL_FIT_GENERATOR as well?

Yes, that's the plan. I have that patch prepared but we need to resolve this first.

Thanks,
Michal


