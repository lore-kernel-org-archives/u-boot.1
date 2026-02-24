Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15265EFB801
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 08:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5624583642;
	Tue, 24 Feb 2026 09:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="prZ0i+ek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA17183981; Tue, 24 Feb 2026 09:23:31 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDD580050
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBUQnWmjy4iG213oq0W1L805hO+xUn/8CBrYW3o+fgSBttN7CO545q4eYIMsQd+TaK2xHPeCHJsu531H/3LoXerEDwJITN1IDhtfSTwu9+EIKhiSb4I+gKgRt7scy1Krm3t6FVkXNAkO6ebyJ23MK2YHQNbzezKvsLY4Jt3Ls/5+pN1jJ+TvuMjLeElo5veIpnqocBBNhmZIUS+LkpCj4RAs9RR0/A8Elk5dKJmzwx48JoDxu5eA4/ePluHNxBjq/61hQ8f5uq52ooUV7NVHtZuo0zo/OrQG5YnNrmZrV7Fj7HAzcHiKK26jOn2i6vv7mYF9DWc1wHF8DqFn/oECEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bMIVqgiqE0VRjdM1GvEGacrFdJv4JyV3scykHhiUiA=;
 b=l2G2xMx0UpvvQNeyFxYodZ25Ddz5gKwI/Gq/EH/Vld+UJ0CgqcapFn74Qh8jmOvv17hI/lI/JcgGN/Js85/m8wRTrfAv+6ctnzeRuz3mbsLlTrUIfz+InxlWt8kic3OxzGUiTM2yrV3MM7Y3JNP2BuvWQzWQtHe/hspKEQues9We44vZYcmXgjWYQFCWlJMITiBeM2FsSPk531p8nsRpo4Ut6d2p9w4IlOwQekA58asIu1AFu+O1SAdoXp/+0vC5q+P4vKJldA9G02ZmavY2jJR/t2KLjwYqdwasyhWlcx1wCh9bfvjWH1REyLu50VLjd8mZnqiuKzBbRgTOFlvr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bMIVqgiqE0VRjdM1GvEGacrFdJv4JyV3scykHhiUiA=;
 b=prZ0i+ekOpQLMKBqeVupzDtfioBM0vvL8Gn3kLpol/5kuWtx88wgO7uAUvSHePbk37RICgqnfcfJJokD/fdIoWw8l7rTbeE3KD4oVnc6pTFhMbq9cbMc7uSn0klPl3Y0MncAiK96YrABAkRxgaHZMHIJAtdh02CspxXgbIx25kjmq2NE/ZsRVBOFIDgpr3g9RSYkuIrhuNAGVvJzrhPnX1j0w/ix922+I2Lpv18Ka9WImJ/ln6ofBiHs9seKIwUMeII2XTqQ6kMwU3pW8hn+17NkKQKOBP/EF4yGrcP19gdgYNi2t05+cAJGffMMZgyxDXk6Pfmknoyg2+7RCkibzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS2PR03MB8466.namprd03.prod.outlook.com (2603:10b6:8:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Tue, 24 Feb
 2026 08:23:26 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:23:26 +0000
Message-ID: <52a4859d-d6e0-4e20-b78b-34213c230bc5@altera.com>
Date: Tue, 24 Feb 2026 16:23:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: socfpga: Add call to
 socfpga_sdram_apply_static_cfg()
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
 <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
 <CAN7C2SCC9L30S2BNYUzRE1jRJeQ2H1d6fq_Hgsu7uPge_QgsYw@mail.gmail.com>
 <CAN7C2SAOLdokAaVcuMPWMTS4HsY-4d2dhnkwLadqsGS2qAsKaw@mail.gmail.com>
 <4b6327d1-681d-46a4-b672-6d53fbfa1e89@altera.com>
 <CAN7C2SCbyuBz4d8QmqGUNFBGjhGaSFyZD-J3GcYy9r3DGNSjvA@mail.gmail.com>
 <4d3e22e1-3f7f-4c19-a529-157eac6d0f61@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <4d3e22e1-3f7f-4c19-a529-157eac6d0f61@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS2PR03MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cd572d-3d31-4954-4a73-08de737dfae1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEh4aStlR1RuekQzRUcrTExNMTRxMnYxRCtXbUVlRGlqZ1dWVzl3OHpiVExk?=
 =?utf-8?B?Z2RRTm9WSStDMFlTZHpsZU5SZlhTc29UeHZzNWFNVU5oVFNmNHNOTk4zbTkv?=
 =?utf-8?B?QUxNK0pITWFkY0FCQ2lHaDd4UXV1LzRYQlNOZUY5cGxKOFdRNTV5ZkNEcndJ?=
 =?utf-8?B?ZzdqTTJkbjdDQm5YQjZ6bmFuaFJZK2kveCtrWEZ2bFF4dm85UkorY3R3MEwr?=
 =?utf-8?B?by9kMHpxbW40NkRpQVk3b1NFVGg1d2ptUFowZUNrMWxFRWFLSUFrZDBsRXBV?=
 =?utf-8?B?clJBRnlvWjlLQmhNRSt5WmE0cWlXUDlpVVViM2xqVzBWbDlKZFRkUWtKQU1r?=
 =?utf-8?B?eGpaMlh5cmxzaGlOQ051Mkt4cVEvYkRJN2p1TFI1Tjg5TnZaT3pIcGU1TjRt?=
 =?utf-8?B?WlFGWFdQd2F1OVlYeGlVdmxjbG5oN21pZ2R6M3RSeGJDMWxrQ1EvbVJ4UjBt?=
 =?utf-8?B?K2dJaEdNeWN5SkFnZzJVSFVOSkpObllKY21xUWxqeHR0L294eXRaWHdQazRI?=
 =?utf-8?B?dHJkclVKd1lCMndUNEY1ZTVmMEdxMDlKdndtRmxmMnBQa2M4NUZYUmZWZjlw?=
 =?utf-8?B?OTdKT2RycUZRVmFvWUIrOXp4T2tuekVBQWlmRkFOTjk3VGxpMDZROVNUbnNO?=
 =?utf-8?B?K0ROQkZlbjFGMmpEVVQ2MEhuSmNXcDQ0c3NCTXFHb25CRUU4ZWJIK0pIdCto?=
 =?utf-8?B?OVNkRWtyeHBPSDQ4dWxtM2kvTG9SU0hzQmczdlcyb3NOL2JCWWhQWnc0S2ti?=
 =?utf-8?B?dXRZQ2ZDSi9sbFducS9sNG9IR0hVVlFPeWVKdW5FNEZtMnJWVDIvUTd0STJI?=
 =?utf-8?B?UXNiNGVNRjh3Z3FjeVFydENjWDVHQ1BHK1hjbHhJdmoyUlB0azQ0Q3pYa01O?=
 =?utf-8?B?OFkrUlVxTnR4cCs3RG5JL0VUNjB6UTZuTE15aDFOMU4wNzdNMWdNWkw3bjBo?=
 =?utf-8?B?T3FVQk5ic3E3YzYvdUhuWGRmRnpSMHJ0TzQ4ZExtejUzNzM1ajM0Z0FJaHFC?=
 =?utf-8?B?WG5qVit4NWI4UGplWldnU2xiUmhKeWgrTitFOS96RmRvUXRJNEYvSk93R0pz?=
 =?utf-8?B?SUdjK3RuNXpQeGZHYmpIWjJwa3pkTHpid3ZXWXF2cWZVQWVVYXNQcU9sRDBp?=
 =?utf-8?B?Q2hOa0hPdUs3T0dvU2EwUFY1KzROazBSMGlqSXdqQjVmY2JaamwwWXYxczI3?=
 =?utf-8?B?Qk9WeFprZldMWWFuQlI4dStWRHBwN29WYlovcjV0eFUybHdScytETURxa0xT?=
 =?utf-8?B?VHA3NndYVWpBRTdIeFBMNUpIcldKVWNKYWNUT1d2eFpiYjZ1aWFya2FUelNu?=
 =?utf-8?B?RSs5dyt2dFZJQy9iU1pvZ1N4ZTkvand5aWErTW9ZZlhMR3ljUDU0aEdheEJh?=
 =?utf-8?B?cmVwZXpZQzhWQkhQaUthVHllWFFWTGN4Vmp5MkNrYUQyTHZBVFR2TjhNdmpx?=
 =?utf-8?B?VTBYVVlpemlZRm8vL3g1SWU0K0xRSjRCSTVHR2I4c3ZzMCt4VHRzdndoRzNl?=
 =?utf-8?B?N1d3dnAzYVNaOEkvOUgxcEgxT25DV3ZMdnVaTXdwZzY2TkJYTkFXT0k5NlJM?=
 =?utf-8?B?UFBkS3llaWZlZUxwbGFXUkV6eEN2TlpCSFBVNjA2NmJMaWdSbm01eFVpb2h2?=
 =?utf-8?B?UGk2cHNpVnl3YUhzcWU2aXlsL2l5dlhlR3dDOVlLa0dja280M3FsWUJ2ZytJ?=
 =?utf-8?B?OG9yNHV2WUJ0azNkVi9FRWZOUWJlSmJJM1VyZ1Vrb2lIMnppU3pmMUpLM0Y5?=
 =?utf-8?B?ZW56UTFNZW1SazRIaVE0WU1DTzlmbHA0bUloS3FZc2V4aGlBS1NSVXpmN0RX?=
 =?utf-8?B?VUlXc20xamtSTG1TVVYvQ29QcWRma1FGc1JsWWdENzVwMXdZRnJMK3VhVWVG?=
 =?utf-8?B?aXFPSnpGaVNIRTVDUWs1WnVIMTFnaXVIZ3QzRFYyZWZOY2tJUStHMmVyclJB?=
 =?utf-8?B?RFArZmt3ZTJPOVNvUWY2cmlIVXpvRnFsMFA3dW5HUC9mS090K050YUNLcWZt?=
 =?utf-8?B?cVhTMjQ5Z1pQeDJXVkVEYVk5a0d0Q0tOL2tURXFJTzBUOUdQRFRLRVUxSzZt?=
 =?utf-8?B?dVE5U1FQazdrNFBLeE9vblIzMjRIR2YyK0xDVkc4eEVJOUJKenA1VXFMNUZm?=
 =?utf-8?Q?+0lA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEM1VTFlakRjMStPdFVUNUYzd054UjlvejRyYXoxNERad3B6YlQyTEpDeVNC?=
 =?utf-8?B?c3Uwck05TUJ1VnB2aUdrV1k3N3RORFdOaU9LdEkzMG5sSFB6STQvVWJpSUxo?=
 =?utf-8?B?d1VmNFJiajVWWWpDYVo5ZVhIUHhWRUFWU3A1bkRCS1orbFI1MHlUeS8xZ0M5?=
 =?utf-8?B?UFNWSEVwNE1VYlJmczBCOExkTzhhd3gyYzZQd21tY0F4WGU1TnZqak9YTklM?=
 =?utf-8?B?SnhtZ3g5azFKZVVidENOUlo4Y1FpQTZnb3JlSm5EN2pZN05tMDd4TEhpaDNJ?=
 =?utf-8?B?NzZYMUNkeHgxYldnZ3FqeE9yS21nWlRXUVB2azNsdTI4dUxobnNaSXNkZnVF?=
 =?utf-8?B?TDBLcGEyYWg0VlZMS0x5bUlLR0dQZlZlelZraWtiUldpU3hralptQnRicUgw?=
 =?utf-8?B?eEt4Rm8rdkxVbEdwME81ditENUtOYnc1MTF1M29tQkxPVlhQLzI1eW03NWFK?=
 =?utf-8?B?ODVoTWJhOHdkKzBYMTBxWDdFODZpMjY0R0dYQVEzVkZpZ05oZVdiWHkxOEhD?=
 =?utf-8?B?TkVCVU5iSUhRNjJXWkdBTjRIZWJ2bHFvTk1WOHh1dVJmYmxBZ3lPY2NYRXBk?=
 =?utf-8?B?dnA0YVM3cmI5MzVlNmxzdW44cVY2TXhOakk1dzRESHMwMFMweDZUcE5mek1T?=
 =?utf-8?B?STFUMVg4MzNOMUhyZXJ1N3g2MmpNdlFHMlBSUGk0U3RoaFd2ZEx4VWw2VXBS?=
 =?utf-8?B?d1J6RXkrWndHam1PdlJEblRLbytmeXNnMTI2dXBOYVhCN0pObForZXJnMmZO?=
 =?utf-8?B?TXFDaTBtYzNEYk03TzVsZFY5dzdSQUZTTkRmamM5V1dGa0wrc1pPZ2J4YnVW?=
 =?utf-8?B?YXlHc1RGQ2lGd2NQMkVZdXRpeUszK0RhNnNFVm9yaS9SUFBpbGF2ZDkwbm5Z?=
 =?utf-8?B?SEQ4K0VhVllYM2k5QldZcFRyOGlJZzFsTC93a1E3NUpIQnZGOURKZENOTG1Y?=
 =?utf-8?B?clJ5WU02b2F0WUVUWW5TckEwa2N1UFlwTXp4QWlybVlaN1F3dU44QTVnSEVN?=
 =?utf-8?B?dk5JZHBUZXhrUUVWV1NacENYRWNqUTdWbE54NVQ5bDBSYmZzdm1iQjlHN1Vt?=
 =?utf-8?B?RVJUYjNHNzE0T2E3bzdlOUpVaDgxS3dtd1NqRm8rMU1TSnFTMVBwR3Y2MHZR?=
 =?utf-8?B?SzE4YlRxbWU1a2phejFMU0x6UXNiQ2tENGg2WVdPWWdoaHRoQjlUNjRVL2ty?=
 =?utf-8?B?T1gycTl0Ly9ZSUJRQklOQW52L2tVV3lBb1RpeXM4RTQvUElLYlVtRDNKMEtT?=
 =?utf-8?B?NytjQWZIOUJVWXB5Tld4b3REQ0hqY2dxZ0YwUjl6R1NncXBXdjRaUEtoVjRa?=
 =?utf-8?B?eFZpVkgyNzVZL2FmYUdyTHQ2L3B0UUdBRllDYTRtVEEyR3VnVk9vMlJlY3BS?=
 =?utf-8?B?NWlEdnVNM09CRHVDU0UyR3VDTHJWVm9SWXRUb3RGOFU5VFJ0QTllUk9vZnU2?=
 =?utf-8?B?ekhRVW1Jak9aak9ENHQ2Vjg4Wk9yRmRwVE1hUi9EZTR4SWFzS0lqNXN3Rkl3?=
 =?utf-8?B?VXUyUnpkSXZrK2c0SUZQaDIvYURLLy90U1VQU2xUVFV2Nm13dmV1RDdManRv?=
 =?utf-8?B?QjdsYVNWYVFnczMyblpFVE1kbVdGMllaY2RwTWdSV3gxM3hHZ0t5MVIyWk1X?=
 =?utf-8?B?YTBqYlFlWVZQblB2Z0RTMk8wNTBxM1RCUG1xaTRJM2w4TFlxTEo3TjF4ekJG?=
 =?utf-8?B?cnVDaE9mOFBqQlBkT1ZhNW42Rjh2R2t5enBvRFN1TXJydVR3YWVoZHRra2ZD?=
 =?utf-8?B?UWhFcUZGUFJMeEduTWUvTW1ieHk5QUtpT1hadXRiclNVSHBMaEppQlcyRjJN?=
 =?utf-8?B?TUJwZVJHaFJkaTFFOFU1ckNNVU1KTkhLSnNCdlIrT1RMRi9xZGNNcUN5K2ZH?=
 =?utf-8?B?SnpzdFk1Y1craVlabzNEcG9qUVNWOHAwQklzT0U0Ulk4VFN1ZDBSbkk4MzhD?=
 =?utf-8?B?Y05TcXVqOCtQNEVwN280ZzlVT0FTWjlOSjlDenNyQ1JmR081aFFOckltUmlR?=
 =?utf-8?B?M2RxbWJkVGhJQjJlTkxLRzkwaEtlN2V3MllrQ3dMWDAvWERZWVQ1eFk4Zngx?=
 =?utf-8?B?dzZsMEVjNkZleExSU2VoNWVKRGlPcktRODM3bEw1aTVpdmVVRnZDTjgwZFMy?=
 =?utf-8?B?NXRleVVIbzBVanZrWGtDendWUWhmelZmV0d5VG5ZbnlTNnYxZ1NQWW95L2ZN?=
 =?utf-8?B?bnpjTGViS1VRMlN2ZmtIZ2RwOWNDRXhVZnZDYURUakhRTlpNcklFbnFqTCt2?=
 =?utf-8?B?T3ByVkxhaGtPYzZpMjJGS05hOURMU3RYUXcyZHprN20wQ2dqQ3IwdnQzWGJt?=
 =?utf-8?B?cXNESnVSQ0ZsWExDeFRYUENJbGNpR0dZTERJd0xJT2gyZ3VITC9JRDhBKy95?=
 =?utf-8?Q?BjAyoi4MHqS7uouc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cd572d-3d31-4954-4a73-08de737dfae1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:23:25.7027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqwwmHSrsb5SuUbO+0rfYmzZoTeREAlQf1U0WTJAJBa3N+cKJSOIoseO3odh3lZESsOiix51xXgU4IicbAaIyjUQra9Wjnbe1PHTT3w6WbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8466
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

Hi Brian, Tien Fong,

On 24/2/2026 4:14 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> On 19/2/2026 10:21 am, Sune Brian wrote:
>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>
>> On Thu, Feb 19, 2026 at 8:18 AM Yuslaimi, Alif Zakuan
>> <alif.zakuan.yuslaimi@altera.com> wrote:
>>> On 13/2/2026 5:00 pm, Sune Brian wrote:
>>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>>
>>>> On Fri, Feb 13, 2026 at 4:44 PM Sune Brian<briansune@gmail.com> wrote:
>>>>> On Fri, Feb 13, 2026 at 3:18 PM Yuslaimi, Alif Zakuan
>>>>> <alif.zakuan.yuslaimi@altera.com> wrote:
>>>>>> Hi Brian,
>>>>>>
>>>>>> On 6/2/2026 11:09 pm, Sune Brian wrote:
>>>>>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>>>>>
>>>>>>> Hi Alif,
>>>>>>>
>>>>>>> Since 2025.05 to the latest master.
>>>>>>> I do not have any issue as you mentioned in this patch.
>>>>>>> Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
>>>>>>> I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
>>>>>>> that GEN5 Cyclone can support.
>>>>>>>
>>>>>>> Not too sure what is missing from first place?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Brian
>>>>>> Based on the CycloneV address map which can be found here -
>>>>>> https://www.intel.com/content/www/us/en/programmable/hps/cyclone- 
>>>>>> v/hps.html#sfo1411577374877.html.
>>>>>>
>>>>>> Bit 3 of staticcfg register has to be set to apply all the settings
>>>>>> loaded in SDR registers to the memory interface, in this case the patch
>>>>>> ensures the SDRAM controller applies the latest configuration after
>>>>>> disabling FPGA SDRAM access.
>>>>>>
>>>>>> This is a safety and correctness fix for re-initializing the memory
>>>>>> controller in the proper sequence during FPGA reconfiguration.
>>>>>>
>>>>> Hi Alif,
>>>>>
>>>>> Before I plan to undergo a test we got to understand why w/o this patch
>>>>> SDRAM2FPGA works properly w/o issue.
>>>>>
>>>>>> If you have the time, can you help to test this patch with your setup?
>>>>>> Although unlikely, we want to be sure that this patch will not break any
>>>>>> existing GEN5 boards out there.
>>>>> I might be wrong, I think static cfg has been done already?
>>>>> Does the code here if not wrongly understood already finished that static cfg?
>>>>>
>>>>> ---> Quote start
>>>>> void socfpga_sdram_apply_static_cfg(void)
>>>>> {
>>>>> const u32 applymask = 0x8;
>>>>> u32 val = readl(&sdr_ctrl->static_cfg) | applymask;
>>>>>
>>>>> /*
>>>>> * SDRAM staticcfg register specific:
>>>>> * When applying the register setting, the CPU must not access
>>>>> * SDRAM. Luckily for us, we can use i-cache here to help us
>>>>> * circumvent the SDRAM access issue. The idea is to make sure
>>>>> * that the code is in one full i-cache line by branching past
>>>>> * it and back. Once it is in the i-cache, we execute the core
>>>>> * of the code and apply the register settings.
>>>>> *
>>>>> * The code below uses 7 instructions, while the Cortex-A9 has
>>>>> * 32-byte cachelines, thus the limit is 8 instructions total.
>>>>> */
>>>>> asm volatile(".align 5 \n"
>>>>>        " b 2f \n"
>>>>>        "1: str %0, [%1] \n"
>>>>>        " dsb \n"
>>>>>        " isb \n"
>>>>>        " b 3f \n"
>>>>>        "2: b 1b \n"
>>>>>        "3: nop \n"
>>>>>       : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
>>>>> }
>>>>> Quote end<---
>>>>>
>>>> I forgot to quote the func call location:
>>>>
>>>> void do_bridge_reset(int enable, unsigned int mask)
>>>>
>>>> During boot users are supposed to use bridge enable to
>>>> control the needs of the HPS <-> SDRAM or H2F F2H LW etc.
>>>> When calls if I am not wrongly understand it will reset and
>>>> simply do that static cfg and simply do not require additional
>>>> calls.
>>>>
>>> Thanks for pointing this out, Brian.
>>>
>> Hi Alif,
>>
>> Pic by pic.
>>
>>> I understand that you saw potential redundancy in this patch's explicit
>>> re-application of the SDRAM static configuration, which may already be
>>> handled by the existing call to socfpga_sdram_apply_static_cfg() during
>>> bridge reset.
>> This is following the old boot flow to the latest and not having issues
>> under boot.scr with "bridge enable" and sub-bit bridge setup.
>>
>>> I would imagine your current flow works as the current code already
>>> applies SDRAM configuration changes at the correct time during boot or
>>> bridge reset. However, there are some cases or sequences where this
>>> apply step could be missed - such as during partial reconfiguration.
>> Not too understand this case even if you PR the bridge enable MUST
>> be done after the reconfiguration phase aka "bridge enable".
>> And PR itself has nothing to do with turning on F2H SDRAM the first time.
>> One is the FPGA manager and the other is the HPS register unless it auto
>> reset all bridge registers.
>> I can also reload full bit during boot again and again and boot to linux w/o
>> f2h issue.
>>
>>> This patch would then be needed as an extra safeguard in cases where SDR
>>> registers are updated manually or outside the typical bridge reset sequence.
>> If the user doesn't use f2h then turning on this bit for what purpose?
>> As "bridge
>> enable" under boot.scr have good control.
> 
> 
> NAK as the TRM’s staticcfg.applycfg (bit 3) applies SDRAM-controller 
> configuration to the memory interface (burst length membl, ECC/data 
> width, timings, etc.).
> 
> It does not gate fpgaportrst.portrstn. The claim “after write to any SDR 
> register” is too broad.
> 
> fpgaportrst.portrstn[13:0] is a live reset control for the FPGA ports.  
> Writing 0 stretches reset, writing 1 releases reset. Its effect is 
> immediate and independent of applycfg.
> 
> Thanks.
> 
> Best regards,
> 
> Tien Fong
>

Thank you both for your valuable inputs, we can proceed to drop this 
patch as it has been determined that the changes are not relevant - 
there is no need to apply staticcfg bit after controlling the reset for 
F2H bridge.

Best regards,
Alif

>
> 

