Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DF7E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 06:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA6E18007D;
	Fri, 20 Dec 2024 07:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RyeYCVPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6709880291; Fri, 20 Dec 2024 07:50:10 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE4C8006D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfOmKWHUSgTGtO3IADaxFl6zSQKnm/4G4asKHJLq01R4n7j8hjl9kSwSTBHNV+ea2x00nqPVfPyCcMbO1G6tNTdObF7BIrao9p3Ok2fk3ZcTHjI/exJAA5dMJ8Bmj8lMhDhkKwB1rEgxQj3cAcbntnDEApOIyjbQV/cFuMMJplitlUEpHN5CZqB0E95V3Lr8Q/iYF4bNXouZEikTshLSYqwsEjTuMwemMLbTE5/6RwbqKKZyYHDT256gLRZLdXVJHCWe7fH3f/YHNYZ/m8yEiIRxjNxSEoJqIJd1Sr7QmiyDK6QpBnDNUoL1Y45ekpv2q8JyCzOBY5pllEsrD+77Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F96H/Za8ePv5TTcxEaQdL0dgecVCr6LoFFxhLYxFCZA=;
 b=GObgm44uVit00XTl5u1CgzdcKFKHGO3+q9IedbpGLC1n9Cdvw4YhDO0IQLFhyKznCotVo3pda1B8rEP00mpPFc0Q6dbPH/4dPO3JFF73lOiNLmC+eQurlchBmM1xEiE50HF0ApWUUeycL0N3dHIDiv9+7y1bO7FqHZtzahJxgBlLAab0CfzjdIBRuj5cP2F1aIRYHw9aqX2ZagNvo3wPzjJoXKS18owSkjzRf9IlFqRAe37dOo9Dzyl49t+MJLOnBBA/MbZZwcadYHhjVd/TuFzAQGuBJz+nqB0jjVQ8VxmNDtSq+gE53Qa8jUryS3ikAn360rjKm4arl1h5BWAhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F96H/Za8ePv5TTcxEaQdL0dgecVCr6LoFFxhLYxFCZA=;
 b=RyeYCVPT3TQWORGIDhFTGmDZ1lJACGcwJjAVxnqK6YjNfGNEF6tncDdu/bFIEPSnNaIZfsCPqfeWLqn2GJHrSOo9xsA4dqkP3acR7LP9+1txVTkRgzr+BW85SM0R9cxVL4t1kVq0ygI/1Le6tKa+gu+sLROJMOP2gTfVlI+G01iW0Rf4f7RIbU5qyNPZ61Tgxo0d77O4UcMf/jJrJ2o5hrLj7Xhw2tY3IGeEpV2iYTs0VPsLDmswuXsxZbLBCvEXVgOItS1b2mo0XJacrQ8FGruA14Hvn/tdY01MPcAvFiTI+nsuxOxKBgKjylnNu42EMsgTYDIflpkzJ1jA8ua4Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1926.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 06:50:07 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 06:50:06 +0000
Message-ID: <bc196636-fc97-42e9-b8f6-9c861f4baaf6@phytec.de>
Date: Fri, 20 Dec 2024 13:49:59 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] ram: k3-ddrss: Remove 'ti,ecc-enable' support
To: Santhosh Kumar K <s-k6@ti.com>, trini@konsulko.com, nm@ti.com,
 vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, m-chawdhry@ti.com,
 vaishnav.a@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de, n-francis@ti.com
References: <20241213103129.332246-1-s-k6@ti.com>
 <20241213103129.332246-8-s-k6@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241213103129.332246-8-s-k6@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::26) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1926:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7bf48a-3699-4861-4b4e-08dd20c289f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0VBTFRtRFY1Q0lLM2hERTEySm42RjlnVWxLWndUWCtlWUNnWFFlK2VDc2Nh?=
 =?utf-8?B?VG9yZk05THozek9Tcis0aVl5SnhtNndFNnhpQVRkWVdqSm1JZ1NtdUxtVVVx?=
 =?utf-8?B?eEd5cG92RGpsTkQ2T2tpckJUcUFXNTZsbHh1OXhPck1tcXI3TFdWRUFZamhJ?=
 =?utf-8?B?OGlxS0NLSlQraWtEYldGZHVtYUVJUHVFVEZBeTdDUTVyaXBOR2RvZUR1cHZD?=
 =?utf-8?B?Q080cEE3dVlZUk5PRGZkWkVKOE5ZUDlPZVhSNDVDMEh6cDlBV1QyNmY5azZW?=
 =?utf-8?B?a0JsdmRJZjRmRGNOQzIwYTd6SkVKUnYrYmhBQ0tQNlpZWnNQdnc2U2hPZzZr?=
 =?utf-8?B?Ym5Pay9GdWpDc1BYV0g2YnNMSkh4RXd0NGY4cmNRa0RMNzZVQTB6UG5QbUdo?=
 =?utf-8?B?WmlHeC9kSzhtcU00Z3g1QVJJN0E3dmJHTDl1blN4TThRYXlSUkdENTNZeG5O?=
 =?utf-8?B?R2hvMU1ESEsxRVkxcEdwbTRsendRa1FRWmtEWXE5UFQ5SXRuanBwcEpyV1ZZ?=
 =?utf-8?B?T3BCcDZEVDlLNzJhamN4TldBQ3o2dWVlQjZlditUVU1rbC9ubXlKNGpjWEpv?=
 =?utf-8?B?ZUFENngrTHhnYlh1Sm9nd25CVzlpWXN5MFd5dUtTdHJpTDJTaURScElJQlNY?=
 =?utf-8?B?R0xjd1lid09oYi9RVTZjQjR5S0hlKzJ3UHMxVGp1c0M3ZzNGR2l5U0dXd0Zq?=
 =?utf-8?B?Kzl6QnJmUVNCZlBKL3JjTS9mZm9nOFY2bEJsNFBidkJ2SkIxSThEK3NvbnRQ?=
 =?utf-8?B?SUxKV0t1aXlWOUd6dFduNTh6YVBzaTMyZFQxL2wweS9BRWl0ajllU3YxaWhG?=
 =?utf-8?B?dnQ2RlZvakZ3WkROb0VhWGJhVUZvYzVaKzdRM2ZKakRGaVNWTVBEYXRCaktm?=
 =?utf-8?B?bHFsYnJxMHhJMm1IOXp6c1BTdWFNbDdZdjIyUkxic1djczcvYm9ocHkwMDRq?=
 =?utf-8?B?YnlvWFZEMTFzNVhkcldnbjNaUTlYbGYyWDR3RUlBTjFWNlJrbFd3aURNTGF3?=
 =?utf-8?B?UVFIVUlCZmdEWndta21EZXZ5UitSWWxVbHVIVm80cmFlUUVqQVNDYW5HNS9u?=
 =?utf-8?B?RmVwLzUwN0crVUNFMWFqbXlkVTIvZjRDdHR0TG9yZmtvSHo2eXFCam8yN3Ez?=
 =?utf-8?B?QXRMTmtTZ1pJUUJmY1drN2g2RE5GUFN2cTV1SzV1OVNZRVV4Z0gydzZ6OEZh?=
 =?utf-8?B?Q3VBbVFreDdHQlNqc0d1aXlRTVhqY3F2UFozMlA5MnVVOTZFRGFCRng1M25V?=
 =?utf-8?B?dlJWNHFOZmRxNnZQdnRZWW8vdERsem12WnBRM1VnU0RsU25qTmVJQWQxbVpT?=
 =?utf-8?B?NTAyQWdWZ3FnZDdLZFNIK3hrMXBaVVRIa1dFbWxnU1RoOU8rZ0EvZHFOcVNN?=
 =?utf-8?B?d1RocVo5QlRvVm5maXFteXFFVTBLNlkzVVFCOFFLQ1V0c3k5NmZlS2pSSk1H?=
 =?utf-8?B?dmlCQzQyeU5OVU5aQTB0dHozTXlXQmhNMHpXSXdsYXE5UUlYT0pIWFVLZjBZ?=
 =?utf-8?B?VWJoYnMxbS8rejAzc3A2Q2c3YmM4R2ExblRTNG45Rkk1SXRkMnVndldwZDFP?=
 =?utf-8?B?Zm5acktZTGxFM20ybEhGbzBhRTNqYys0UDJFTm1PUktRRE9iazJtd2w4M1Zw?=
 =?utf-8?B?K0Fqcm5Fa0h1TjZYK29jaHVDNjNQT3J6TTlVYSt5RUtncTIyUGlPUEZPS1VJ?=
 =?utf-8?B?dG40ZUdtaHRmaU1hQTAzWGpxY0NBWkNySjhVRWhSK3YxaEpwM0gxblorMFhu?=
 =?utf-8?B?NTJjZW81SkdxL2NNYWYyR3ZZMlpPdW9WdWJMSEk4VzI0TVVpaUwrSEFnRDRz?=
 =?utf-8?B?YWViSXNCRXJLM0lVZndJSXllTXJRUzVSQm9ZRDVCUFM1b1hPVlZtclZPMzlZ?=
 =?utf-8?Q?pidaIoZZsncxQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJQWjF4VHZJUmJKbDg2NVpWRVN5NnlDTHdyYnBEZm5xOTF5TFp6aTNUYitO?=
 =?utf-8?B?V1N2cmgwVzdmanNvTCtBRmxhSDFYdTNSTkJXcDN0ZElDSHRUcm5MQmdIVE03?=
 =?utf-8?B?bERHdE50WUFGUUgrNU4wR1FveDdMSVIrZ0IrN0UrZ1lmNG1SeTB5aEkvVXQw?=
 =?utf-8?B?Z1l2REdIRDRxWi9maFdLSzkwLzY0SWlLS21iMmZnVndKS2svZzdWK1k5Q3Nw?=
 =?utf-8?B?SVV4czlxMjNKcTBMRzBmcEJLSG5ZUW1MMHh2NU9YUkt1Rk9ycEsyaklvR1FR?=
 =?utf-8?B?MU1HK3pKeVcrb2s1ZVo2Qk9MSjdldU9FRE9ObEx0bE1RclRkZ2NEOXUzZlIx?=
 =?utf-8?B?bkJDejNITjd2Y3ZGSUh6VFN0QmVPWTh6b0FRV3FyT2NIK0pWVXZFcWE3andw?=
 =?utf-8?B?M3lHZzVBMXYzQWxmcmdTRnBxZVdIWmFCODgzOUx2N1J6MGlVL3NNTmtHWHhr?=
 =?utf-8?B?TGhwQ1lSUjljdmF5RzJ0MGhDWlJGNGUyNXAwTng3Z251MW5tbjIraFR6WjBF?=
 =?utf-8?B?RTlqM1JBZzZmajBUSWI1MFc0aHJGSmdrUHBxOE1INGI5d0M3VDJNSkhsQitU?=
 =?utf-8?B?REFWK0dLR2RqRmpFUGtTRzMxQTVBMkJ6dTFNcWRCSjdzYmNEMHNvMjlGSmlN?=
 =?utf-8?B?NHZaeVppVSt1UXdGS0ovSzRiZWR5RDRVMXhwU1JacW5oZnJEQWRrcmlBNDlq?=
 =?utf-8?B?ODV1c1B0MnFxN2JRSndxRDNkZVltaUpFcndjVXZGWEkzbXNaSndYQkdqbFVB?=
 =?utf-8?B?QXJEbk9QbFN0dXd4TzlzU1VSdUpHL2Z5d0RER05lM0c2R2NIbDBkSlJTVmFJ?=
 =?utf-8?B?MEpabUxBaFZVMkpERzY2d1hFL1N2bENvY1NsOTdYdE9TWFV0bDVNUnpYeVRX?=
 =?utf-8?B?dVR5UDZOYjZXTm1BV3N5WFRjTjNxNjI5Rlp6NWZsZVRNZ2NtajhxUDBMenpX?=
 =?utf-8?B?L3JzWU4yWlE0dnl2N0ZQOUF0WElqRUJuRGNGVE1KUVJBeVMrYmN0VHg2MXQ5?=
 =?utf-8?B?UVdkNncwMlZub2EvSk1TSGNvS3ZhVENmSDYyY3hnYWlTR3BkS1pFdDdiNXFU?=
 =?utf-8?B?UVg1OWtnR04wOXF1ckxUOG5sSDZGV3MvTGJabFArT1l2eUFzUU1TbCtrRDI0?=
 =?utf-8?B?MmF6Y2NiL3RmczF0aGtaQzFtZlBvdDhib0lieHEzbmI0UEtoV2N1M1hhUTZQ?=
 =?utf-8?B?a05pYlIwZ29WQzBmQ1dra3FBbDZnOFFWcGNIQVA0UGhDTVZFamU5Mi9JcUUz?=
 =?utf-8?B?cWxta1Zjamp2YUU1Rk5uQ2dmUlJ1YzFlb2hVcVN4c3ZBNjVxalZ1RlNTWTc0?=
 =?utf-8?B?eUYzOVNXaEV2b3JiQzRHN0doWm5EWUVjaWZqT2w3TS95MHNyK2ZpczhrajFz?=
 =?utf-8?B?TXZXb0hmbFJxOEtLVXovU0lqQW5ldTVTRWJhS0h1U08xK2p1Z2ovd05GVmJE?=
 =?utf-8?B?Q1dxdm0xK1hiZTBvWDJ2SkkzSk91VGN3WExiNWxKVElXb1R2d2xaMGEzayt4?=
 =?utf-8?B?UklvaFowdjZFV0tyZTVrbzh0R0dQR1dadG9rMzlxaTJ0N2NYdzI2c0xZYlNF?=
 =?utf-8?B?V25iVzEwMEhCZ1FOczJsblJNSS9PK1JqS0NaT0NuNDhSWHJ0OVJGdnNQd3o1?=
 =?utf-8?B?R3cwWlFJL29HVnRkMDBEVEFkcEY2R2dzRmdOaitndTl2SUFYM2pKcGJ3NjZs?=
 =?utf-8?B?ODNFZnFUbGRTQWxkVXJCd0p0emVlOFlvMzRtVHc5SE9lNmV1WG1nUENNa1BT?=
 =?utf-8?B?WEc4TWUxZGJIQmpCbmRWQm9lQ0tBT0pqSjYrQUNTU1kxMlBmc2lhQ2wrRXps?=
 =?utf-8?B?WmZlS2ZsZ0xXbTZ1YllwMmZkbDAzOTZHZjFsWjg5c3Z6OTU3ZEtBN3dhT0x5?=
 =?utf-8?B?TCtreFZyajc1VlJMcUoza25ad2FpZStJb05Sczh4UFFGZG0wdGpoTXhNU0hT?=
 =?utf-8?B?YjJBRjlxb0hKeWh0VFRtTkdjalhnNk5mdHg1WS9JaFR1OUNOblZEY0Y4Skc3?=
 =?utf-8?B?bFF4NHhqY1Q3Z0cxTFRNdkpNMDE0dDNNTkFTbjlJclhXdEhEOUJJbXZEeDQw?=
 =?utf-8?B?bU5JQU1tOFZycFl1amtLNmxkcERuWDlRRExWWUZoTDlNTkl5UjNmMk9NWlRq?=
 =?utf-8?Q?bCZOAfZNURs8I/VLaVOaaARuR?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7bf48a-3699-4861-4b4e-08dd20c289f3
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:50:06.9092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcrmpXfy6AMGrAQYuWJXLspxB9rs/WqFKkD9gfxTIwnB5/fiuvXFEAQ6GSQya706CM16mRiwQej5snOLVo9viQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1926
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

Am 13.12.24 um 17:31 schrieb Santhosh Kumar K:
> The functionality of enabling Inline ECC is now controlled by
> CONFIG_K3_INLINE_ECC. So, remove the support for 'ti,ecc-enable'
> property to avoid redundancy and to ensure the Inline ECC feature is
> mananged through build-time config.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index e4f9891bee20..05ea61bbfe9a 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -151,7 +151,6 @@ struct k3_ddrss_desc {
>   	lpddr4_privatedata pd;
>   	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
>   	u64 ecc_reserved_space;
> -	bool ti_ecc_enabled;
>   	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
>   	u64 ddr_bank_size[CONFIG_NR_DRAM_BANKS];
>   	u64 ddr_ram_size;
> @@ -408,8 +407,6 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
>   	if (ret)
>   		dev_err(dev, "ddr fhs cnt not populated %d\n", ret);
>   
> -	ddrss->ti_ecc_enabled = dev_read_bool(dev, "ti,ecc-enable");
> -
>   	return ret;
>   }
>   
> @@ -792,7 +789,7 @@ static int k3_ddrss_probe(struct udevice *dev)
>   
>   	k3_ddrss_ddr_bank_base_size_calc(ddrss);
>   
> -	if (ddrss->ti_ecc_enabled) {
> +	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
>   		if (!ddrss->ddrss_ss_cfg) {
>   			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
>   			       __func__);

