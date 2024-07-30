Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1046FC3DA7F
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 09:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF10883A9;
	Tue, 30 Jul 2024 11:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="Do/2hi73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F44A88570; Tue, 30 Jul 2024 11:15:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA5C88009
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 11:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U0TE8t001910;
 Tue, 30 Jul 2024 02:15:03 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40pnp5hhx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 02:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjBbAQWaHMCDGs7Mx9zunO0WW0yhwOGkDRtXrcfTPc9sS5YvA3OK1jkOX6juQYGwgOefiM2J9bNQ4viq/uVbCCIzJsyQDl/xQAZiCJ3/wYT7b8aGqU01LGOAlgkIwBXSKNsy3Ed/BN0nOPva6n+3KtuCE0oIXqpGtLIz73MXRJ6m3Cp66toh/vnesxoUj9fsLhW+H2mEXYHFWDv69b/6PzrApmkBrIsZci++sQSrLHQMZDtGbeB/EmcaPhQuFBazg2T8TyunfAZiurrQorsZD2I6VcAIk0j3BzKbm2TfMDLKh8idZMZwFGVKe/NxGYM8Ty1qOSkj2hE5Bq9h6LWtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+pPQIxJR393+l9Lwrb6OSLyLyjn/XlA/WDQpZGMC14=;
 b=GgTx0LT3UfEjVAR/Zx7v5dtewj9pKmVgpxdQSmf1rVU3X0iXoHijrnmO+rT+8WpOWEVorSa1rvPskZWdndZObYgO2w/knGlmWaAAPXyt0e8WIpzIV0WtRrnv6BHnWTuc2VSNyWzzj46mbOm1m6wurEUJh96EII7i6b2TE7nje4NBFs0lR678KeI7P3SXBwZa1FLRatUiKYUiBa3YChSgYLc6+JX7vRDNWmz7HPdq3g/cEgiTIsWG+GIgYo0Mf/3dgEprIaUlz/AbdYODH3XVL6kQIsEYpb3Sa8A4d+0NHRYZCTKdnAkgdwLKewTezvcV2gPCCpmAhkrQqSj76mg8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+pPQIxJR393+l9Lwrb6OSLyLyjn/XlA/WDQpZGMC14=;
 b=Do/2hi73VM7WtKMbeEBgpuAVGlj7nJOkIgBYUcoVtHl883FGnniCj7krYV0QGCZTKscAM4vonAmkyLd5iHdJm6XrLeo6z26pBwk2XybCxQm7iXG+RzllhHypdPsjozXBUWe6YPxDy+EWJYD7g67owjIKMjNaVh7l+JT3LMTwnNU=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:14:59 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:14:59 +0000
Message-ID: <eae14602-7809-882f-1935-a271a49ee585@marvell.com>
Date: Tue, 30 Jul 2024 02:14:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: U-Boot-Denx <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, kmpark@infradead.org
From: Ravi Minnikanti <rminnikanti@marvell.com>
Subject: [PATCH] ubifs: mount fails after power cycle
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|BY3PR18MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d74fb7b-c8cb-49ac-3103-08dcb07815dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akllbHVFa21OTldrSXUxMnFxcktVTUU2MXM5WTN4WCt2TnBvREpLLzArcTNa?=
 =?utf-8?B?MEVaNWkrbGkzcmxSeVhqdE9pdEZTSnBFMnVaamtCY1ZKNWFOdEs3U29Mc0lP?=
 =?utf-8?B?bEROSUVMSTZhTm9pVmZQbWFPL2VoYlhjT0cyaGsyek5QWlFvQnIrd3VvcE5U?=
 =?utf-8?B?Y2pNc0NmT1JWQWszdUE2aWUzUHZHYi8reklENDg4blROSVA0YWNlUVFDNHVE?=
 =?utf-8?B?eENkRWhKNlNhazRhWGU1M2hkYXFtbWd0K1hxTUpucFdHK1g4STB0ZU1QWXJq?=
 =?utf-8?B?b0o3SHNnRUtpK0xpc2xkcUJ4R0xTQUVQa1VhSzRBN1E0RDU2THR3N21YNnI4?=
 =?utf-8?B?cVBhRTNDOXFJVm16ZHk0c0ZSeDQvbncwS0tMekJUWkdUbzRFamVPQWt2RHFL?=
 =?utf-8?B?T0VMRGlNWmxPZzE1WE96ditocUkvQTJnVWg4ZTVjcjRhYnNUQjBuR2x4STN1?=
 =?utf-8?B?VnRmMHU4SzU3V1V2czhqaFZob21aQkZZRzQwcEV4a0ppeWw4aFp2Q2RFRlRX?=
 =?utf-8?B?eG9ETHFBTmUvR1M3Q3hUSTRJUDljOElieHYzK1RKcVQ0cytkUU5wN2xhYUU3?=
 =?utf-8?B?V3pmR0JuWGljdnhWdUdRSkt4WUhibFVydHBaMCtjeENRYXcyaEJ0b05INk5S?=
 =?utf-8?B?eFV0dkcxR0NLWmFZOG5mblFpYThGNFBLSmxBNXFvai9WbnhVd3ZzQzluUjBT?=
 =?utf-8?B?ZDVsK0lyUkZ2S3pJamlWRFNyWDlUVlltVzYxR1M5R2xoQkQ1T1lhNjNONjNE?=
 =?utf-8?B?Nmt1YUtZZGNBb2M2WEc1WjRIR3R4RGdFV3NoejE1TS9hd25VYnFFaXdPV25B?=
 =?utf-8?B?ajBVV3QveXZ5ZS82TVpvaWxsaXZ0RHU3TjJ5Sm9hMWVZUmZ3OUNtSWI4NUF5?=
 =?utf-8?B?L0hYcHFUMkJRNkh5RUo3R04yRHh5SkJWNW9ZRHl2a25xeGJhZEVVdCswcW84?=
 =?utf-8?B?S0gxeDRza1RGOHp3OHZvY01QSThSa1BWVU5LTW83US9GQkVLUFRMZ3pwKzA2?=
 =?utf-8?B?SWIycHo4ZTJBMTVDbzYyM0NWck0xV0RrQmNxNnpvdkJYNjdGMnh6ZG02MlVq?=
 =?utf-8?B?SjY2T3lZUSs1V0pCYktXR2dsbGQydHJPcUsyM1lhOU12d3JKY2FiSFcwQlIx?=
 =?utf-8?B?L0JHM3VrWnNrU3JlKzJVZTlBTENTSStCVlY4alJEQWh5T05YYjM5eW5IUXBr?=
 =?utf-8?B?cmFHK3E3NjF6TEdzS09SbldISkVmZjNZVjAzckxVRmNHZ3VUZ2d0OVkrWGdm?=
 =?utf-8?B?VkFUOXFseXV3UTRiME9Ibm5nQlYyTVYyU2JVSUMyd2RabHU5Y29hb3hKTTFM?=
 =?utf-8?B?VExJZk0xSDRMYngyaVpFblRRSlIxYU9qVzlKUDRhVVBZTjdGZ1ViYm9QOG9j?=
 =?utf-8?B?ZW9KOXRiMFZUM2Fic1lkMUtIN0xwMU1ha0dyV08wYkRCYmQ0OTBwK3g1czdS?=
 =?utf-8?B?ZkRYWk9MUXlYVHhJNXNlSHZ5Q253ckVGYzRoamh5L1MyN25qOFF6aHNEL0Rw?=
 =?utf-8?B?WDY5ZjhiNFM2L05Cb3Z5eG5SRktlRUo5UENlZUpwdnZsYjU0YlVEZ2djSGp0?=
 =?utf-8?B?U1pWS011N2pvNW5KcDRoZi9QM2N2Ky8wZkhDeG1aWmpxYWdGdzlZSlNaMTN6?=
 =?utf-8?B?dlhxVDVJZSt1YWlRVHlpWUNpK1FtbzZPcWR6Q00xWlVzKytIZWlad3FCamtr?=
 =?utf-8?B?SXZHd1NHcDJLZ01JMDZUanV6WnRDNzBOa1ZoLy95engvQWlXakNKblV0eCs0?=
 =?utf-8?B?WTB1c1RZZngwZnZvaHJzY2tRVTBIK0ttaHRVRXB2TSs1bWE2bW9lRkdUT3VG?=
 =?utf-8?B?c1FOa1dZdlVMM2NTRXVXQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M28zdzR3MFFrNjdhUDAzclIzWDVpTzlVVnVhdnJUaWluWnRNQjlEVnorWEJO?=
 =?utf-8?B?aEVHQTNhSjFqYTZRU0FMWjlKT1ZwTDIrZG1GcitYUkRxTEUrZ2VkTjYzcXkz?=
 =?utf-8?B?aGxaT1FnQ0piY1V5MzYzcTR1N04yb0pDcTNaTUhTSXRPZXZ0eTBrb1ptWHh4?=
 =?utf-8?B?bTFwbDlyQ0xxcFNJOXdWYy9Uck9CU1VIYkRFbXdPbFRkbURscHFZRVpGZTFI?=
 =?utf-8?B?TDVwU3NPbEQwc2UyN09OcDhZMFlaT0FrV25jMXJodFNodVA0ejJja3o3VzBn?=
 =?utf-8?B?NUUwWWk0Qzl4UHBVZU91RGNpRzVJdkw4VUhodXVTTHRTeFJxdFcxM0pQYjNC?=
 =?utf-8?B?VnVnV2w3djhRYmhhcVh2TGhEaTVQQzhSR3dqSFIwckJvQkpKVDdLU0drb0lS?=
 =?utf-8?B?SjhnenV6Q2JlbjJNZkx2ZFRVOVdUQ1hJdUJWd0hWckF6STl0U2duR1pRN0Zx?=
 =?utf-8?B?NlkydWdJQ0RoaVE0dU1mUkdWYXM4WnA1SEY1NEM2U2ZYV3FPWFpTYVFKTFpV?=
 =?utf-8?B?aWVOdUF5ZllCRStUR0g0RVo0d093cnJROVpDcmtIaGZZSzBSeHI3V05CVHNU?=
 =?utf-8?B?S3VDbDdya3FaZ1V1eEZlNVBjdGJlRENMOFR0YXBaOG5QWWlOTjFEcVpqWGpv?=
 =?utf-8?B?Y3NDYy9qVzgwWHBwbDN2WjJRK3JtR3VFVjA2VE0rdElVRGJTVVhDaGxCNUpl?=
 =?utf-8?B?Vy96R3c0dytOS3ZVdDliWHF6ZUY1eEpsUVlqQkhHeWFCV0pFbUk1ZEFsb2xD?=
 =?utf-8?B?aFZDUXlMUW5RVlVvQmF0M1hWUk1rSjMxL2pOQXU1YlFvLzUxcVZtWXpTQ1Ew?=
 =?utf-8?B?YVlYMGs4Ymg0bG0xWThFK0JBT3R4OGJieUljSVNpZHoxdXBpUzJWcGp1dzB4?=
 =?utf-8?B?TjlIWmkxL1hSOEFubHJsM1ZuTVZ1bHNuUWtJSnEvRE1NMUtXeEEzUU1NZEhU?=
 =?utf-8?B?UGUrT24xcTdwZmRYc01idjlqejNGWHU3Um1XVTNjOHRlbzRDR0poQ251YjI4?=
 =?utf-8?B?RnBSN0lRWkRlSHFHR2dtU2kzQzVxK0JhVFpBM2JveVd3QUhaQzYvaElBdE9p?=
 =?utf-8?B?U1p3THl6NmNacUFHeUhhN0luSlNlclpGbWd2anVVREtCNlo2emEvdGJlQ2po?=
 =?utf-8?B?NUk2WlhnUUtGUTZ0WFl3YzBhUmoxQU8yaWhtSStRSDRmV01iMUtyMXM1K3FQ?=
 =?utf-8?B?REpaYXFVVmt4YTFrd3g0bmRVbUkxTElIN2ViTUwrMERYU1VEb2pkRGZvakZG?=
 =?utf-8?B?UTN4V3ZnMjkrbHljamdNQmdvdFEzQ2J2T2VsOTJOcFFrTUpESGQyNmkxaW1j?=
 =?utf-8?B?V2VwU1lRRWNQcDlCejZBVTJZVER6MTA1bHN6U3dDMzBsZ0lsdUcrcFZNTXFX?=
 =?utf-8?B?Qkh2Mkd1Zm14NWJXUGVad2I1a2JrT2k4OE1IVE1XL08rVDR5OUlQcHhuQndv?=
 =?utf-8?B?eUJVcVBWUU1oeURsRlFqRkJvaTRScUI2ci9lQ1pYbS9sN2NvR0dWRWZSWkJD?=
 =?utf-8?B?aFlBN0pvVTNocm9UTEJXemtxZzBHTkozYUpnWnRSQjJVRXp5Ti9mWDZjY3Vw?=
 =?utf-8?B?UmxzQ0U2OXRZSTZ3TUVsUTN2anY1b2RxWHFvME1Sd0JJWXA0NkNEdHVQZUZQ?=
 =?utf-8?B?L016WU05STRvSmxBNjRJNzd3b21pSW9XZjJqUUVUWDk4RTJyUnN0VmZuYjI5?=
 =?utf-8?B?NXFqaDdUZzliVTZ6UnhYbWF5RU1WTGdoSDJqTCs3SXBJQzBvek9YWXdkWHlY?=
 =?utf-8?B?V2F2TE8yZE9VY3hZVHBMdXcxeUR0VWI2OEV1WUVPdzRmYVRtdGhIMWZUWTAy?=
 =?utf-8?B?NzR1UFI3WTZxcWtYbEhSZXk1Q0lWL21SMVJPTnY1SEhLM252OS9VcXhFdHhm?=
 =?utf-8?B?eTdYSEhaU3FsOUpTd2xyRGdoaEt6TGtYUWN1bmFTUnppc3pmM21ycTNzWGZE?=
 =?utf-8?B?WVZrZVBEV1hOVENBTStneEpNaWowaE52M1FuaWk5a2hrZENtYUNHeHc5NTFF?=
 =?utf-8?B?VGdvOVBMcG96NGdhN3MxRHpYUjNtSmg5Qk9PSWlYNStFN0NiQUNmREVOUFYz?=
 =?utf-8?B?ZTR2ZmtzbDJBaTdWeFR0bGorSU9UelFsTDBEV2xldnVDL0poOEsvNlBjUHJZ?=
 =?utf-8?B?NXRibGc0M1JJQlR4aXZnVXRYa0N0V3RDTXkrREJJdFFFTlhzOENXYy9kdmFH?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d74fb7b-c8cb-49ac-3103-08dcb07815dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:14:59.0181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTix8Oyg6UvktfZc+SXvNbWLsQN89kAIWHGMDCTs1M6PdMVBkBxdfu1g4SgTJJqisFx0blnwFXxzImsOsQc8YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4707
X-Proofpoint-GUID: 0PYUXA277lohK4M0910g2dHIxUYoz4sv
X-Proofpoint-ORIG-GUID: 0PYUXA277lohK4M0910g2dHIxUYoz4sv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01
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


When kernel uses file system encryption, fscrypt on UBIFS v5,
after a hard power cycle UBIFS journal replay fails which results in mount failure.

Failure logs:
UBIFS: recovery needed
UBIFS error (pid 0): ubifs_validate_entry: bad directory entry node
UBIFS error (pid 0): replay_bud: bad node is at LEB 890:24576
UBIFS error (pid 0): ubifs_mount: Error reading superblock on volume 'ubi0:rootfs' errno=-22!

This change is ported from kernel:
commit id: 304790c038bc4af4f19774705409db27eafb09fc

Kernel commit description:
    Kernel commit description:
    ubifs: Relax checks in ubifs_validate_entry()

    With encrypted filenames we store raw binary data, doing
    string tests is no longer possible.

~

Change-Id: I487ae4d172e228e72ac31d158d668f209142bce0
Signed-off-by: rminnikanti <rminnikanti@marvell.com>
---
 fs/ubifs/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index aa7f281ef6..b6e03b76d4 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -451,7 +451,7 @@ int ubifs_validate_entry(struct ubifs_info *c,
 	if (le32_to_cpu(dent->ch.len) != nlen + UBIFS_DENT_NODE_SZ + 1 ||
 	    dent->type >= UBIFS_ITYPES_CNT ||
 	    nlen > UBIFS_MAX_NLEN || dent->name[nlen] != 0 ||
-	    strnlen(dent->name, nlen) != nlen ||
+	    (key_type == UBIFS_XENT_KEY && strnlen(dent->name, nlen) != nlen) ||
 	    le64_to_cpu(dent->inum) > MAX_INUM) {
 		ubifs_err(c, "bad %s node", key_type == UBIFS_DENT_KEY ?
 			  "directory entry" : "extended attribute entry");
-- 
2.25.1

Thanks,
Ravi
