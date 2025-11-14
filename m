Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982E8CE7B03
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA54838CE;
	Fri, 14 Nov 2025 13:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ERxb3daw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CA9838E6; Fri, 14 Nov 2025 13:34:31 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DDA48382A
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o248xLmz6cLrVLCaTpZBHaDbUkjIO1+ft5DZPiCjufhM/9JtOTAiViymbKSJBoweiRWOMAWnaIDUko08YP9tkaPWnNEl/W0xnl+R5J29sTSThu+pC9YihMwKg+gb50gT6mGUpXpBrNj9A0abspNq8LMrHIjdxiD8vnAI2oEXPRDgjK3xrPbCpZ+3MbW0VMzQOZQa8UTnI7S+fA/tYaWe7hteWID2irZX5f+2Smk0A8h8M3AQfqFTGn6KsKkGZ0hMoEuhcO8HusvBSZGM4k/D2KHN4nnBX9LwfkPexH7zlCxoBCAqA2PKMS6fmVAmgPFwP6I9ptElayUOd34Z7njIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iee7PxTkcVTKDKCkBXaawK1BDPyKUdNUpUBzbH0wHl8=;
 b=mITG1nWgHmHjgxWJ810R4cPVsitOcPbGspb8GkO/W8E+GAivmG5b0KEDOK14dVkJ38hvAf62hFsZqmnkzBMGvxyEMbK/6dI0eN1+WJLy3G7UUdLBOLn+6d+o8wKZH1pLKBmNxGhzfCS74UxBE7T5H96qez8Vnx39DmtOu9MyJvq0vVJvcmjkSTbeUIjUtjyS70dI27l3sQ4GahwdY6FkWnm5zK7qknLctXkmMTnP5q/9EPLZBXWiyACOZ1sgYQdpKQ96fLxgRImbQDQ4o3eTWgq84k1aO4VlQLWmTGnjsGg9cGvUpn51iyyyMogyt2xEnASxBuoWr0G9ZoEM+dDbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iee7PxTkcVTKDKCkBXaawK1BDPyKUdNUpUBzbH0wHl8=;
 b=ERxb3dawP3UIs+f6gZF9WxO59JWCdpQo2O6C/hoYo0U/kd4PZtzwVem+pi4skUMwH21uJ7jeJMmWzLJ+1muMBuCkVWQrILcyKv7Btfbp1az5Mmo6RcjyimtJwXSDglPPitxvJ+MLqcyneaphK8XLYO9JnaP4aW1ZV7rLmiFH4i85ZVVlmrvhbtdgdwlozNpqEC8Ug95Z28pg2AN0sJ6JfopYnvieasysbbOGq8YOhN2gXjAJqoToheFPbWk5dC7uW22I1ZdNHTbn2FQmRcRrAcM7oPqjybxcmw5J73104pa1BEH9wKCmWd7S5cQW53a0tvx2IgmuHL2ZGKSQ/vfhSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH4PR03MB7604.namprd03.prod.outlook.com (2603:10b6:610:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 12:34:24 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 12:34:24 +0000
Message-ID: <562355e8-2aa2-484f-b260-3672689f5d17@altera.com>
Date: Fri, 14 Nov 2025 20:34:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for
 system manager in Agilex5
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-2-alif.zakuan.yuslaimi@intel.com>
 <DM8PR11MB559296B2DEB7CB7AA6253B7BD2C52@DM8PR11MB5592.namprd11.prod.outlook.com>
 <0c48f4de-0da8-4d95-8070-f4382ef344f8@siemens.com>
 <a35f16ba-5334-45c2-adb1-e0b6291cd004@altera.com>
 <77f4cc84-9272-4af3-8694-66f60c01d755@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <77f4cc84-9272-4af3-8694-66f60c01d755@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CH4PR03MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eaa3607-2fa6-4436-a2fb-08de237a2453
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVI3aWRzY3ptNWlDZzhNWWY4M1BsVEhUbkZlbEFVcTlleUFGTFpSSFhLb2pm?=
 =?utf-8?B?N1pJSGs1Tm92VDRBc0pMKzlmUW5LTkJ0Z3ExN3FtU2lpdWExbFRTTm5Ga3d2?=
 =?utf-8?B?bWUyTzBWNkVTdFJ0QjZkWVNaOGNTV0RKYjZ0bHNGR1lXWHZCZWFqZzlYck1h?=
 =?utf-8?B?dEZBaUwya2FMcDQwYi9OMjRTUDdqa0dMcTdmbEs0Q3ovU25Nd2ZydWUwaXkx?=
 =?utf-8?B?ejlIeU9RQTdhcW9VV1RkalhXS05waTU5VXBxbTZxU2p1ZHAxcktqQlhmNDZw?=
 =?utf-8?B?L29QaEN5bFRsdmVGbWZiNU1aK01IRzBWbXp0dUxMbVQ4MlQxcHpneWg2eS9j?=
 =?utf-8?B?QWluYzR1bzk3VW1Ld2dPcU1HK0NEUHZCa1Z4N1RkMGNpVGYraFlXRUduQ3RQ?=
 =?utf-8?B?ZlZZSllIcFowQy9PblRKbUNPSGQ5ZU5ZWkZMbXZWYTdsMStJMTRRcllMR01r?=
 =?utf-8?B?NGNkVlpvaGU1OWwxRWhWYkFYR25rSU5LdmdPWGp0dkpTcml6ajk3VWE3a2dM?=
 =?utf-8?B?NDFVRTRySFhKemRkeTlJL3NvTUxQY25PRXZDQmxCV0N4dmk4aDROLzUzQnJE?=
 =?utf-8?B?dEk5K3BzVFEvT1JFSEs3a0RUYlJMMldjT0IvNnpVTHN0WDRHQlB6N0ZDc3Ax?=
 =?utf-8?B?ajl5MFpjbGJTWjVqQ01xOVJacVFNRG4rR094cHNTbS9yeWhqbVM5cWlBdWZO?=
 =?utf-8?B?NE5mYXlFWENWL3QzaXQwZmpRNjhCT3BEQXNJZkpIQTBsTE1CV1NMUXhtS1d1?=
 =?utf-8?B?Sk1EU3ZvVTE2YndpeG9tdFgyajE0S0xTRHpwZzF0SFVaMDd0VURXYlZnSWpj?=
 =?utf-8?B?aXFIY0hFcjd4bWw4MWNJeEl3VW4vQ2o1c0xha1JWTFJ4QXljV3JpdC9RaGt4?=
 =?utf-8?B?WHp4dGtFZDRFNEJMMkV1V0hRd2JOSk1RZ3hBVnhHakphL0dUaklvc1Z5OHM0?=
 =?utf-8?B?T2REVG9oeEZPaWx6c3ZpV0xDVHR0aTRrdzJYWkNoMzdIL09pZzJtMkVTNTBl?=
 =?utf-8?B?cWpIU3dkcWhWd0FscUdBZzVwN2dwVTNsMUliUWwwRTBobGppcENldGZRV2Vy?=
 =?utf-8?B?dVdiY3hKUTAzdVozaEhlSTkzQThPa3M3eDl2cmxqVVNIVFBxNk5PS2NIWnJr?=
 =?utf-8?B?SnN5b1NvV2Y0QzV6S0VVU2dVZFZVYWNOTE9ZMjRGdWRoenZGRWk3T2xmOVlh?=
 =?utf-8?B?Vy9kYkpPZDIvSUJuMk44Rm41RVB6ajJvZ0JuZ2tRWkNaNnNPaGYxbVAzbUdT?=
 =?utf-8?B?WlBDUHJ2WDk3QyszQ0pPYWUzUWZLV3pTRitDMEgwcE12bFM1TDRVUG11Rm1G?=
 =?utf-8?B?NXNNeml6NGtVTzJLVTdFS296UG5EUzJGTUpVbmZ1Z0hJNXNqdXBxb2gvVWoy?=
 =?utf-8?B?NnVTUG1DL09MTzZxMk1xRUV4WTJySUVZQ1ZaMWQ2S3g1cGM5N09ycDhEa3Bq?=
 =?utf-8?B?MURFcE5Qa1h4a2dHNitmSzZDK3hXajl4N0ZOQXVwM1dLMGFUZ05TczRVM0VK?=
 =?utf-8?B?S0ZXVG83UThNYjVETnZBMStYSW9zV2E5VUFQeklMWC9zNFpNQVZ3Rjh1c0Mz?=
 =?utf-8?B?UUI0MEFTdCs2NUR4Q0xHNmhhd2xFTjFOMTkwZFhrV1I0bC96SVNHS3lyVHQv?=
 =?utf-8?B?cXZMaHB0c3gxMDdSRGpoWmZVRnBtbStudHZiRXVmTjIxZ20xYWZYb1dEOHRv?=
 =?utf-8?B?eXdPTEdHUDRPL1ZpOWlmWitPd0w1enhqTFpJc1M3V2swTTd5OFZRbUFkZEtF?=
 =?utf-8?B?Z0MvNjU1aUVUL1VHazZMOUFYWUZHZGxyczg1cGV6V0F6Rmxnb2FLZmQ4ZS9t?=
 =?utf-8?B?aTI0b3diZ2txNkRnYjZRUGFPNDRDRURINXA5Ry9wY20vNDBuU1BldTZuUnhQ?=
 =?utf-8?B?bmt0NEk1dCs0UCswTXBCb0xhc3orZ2R3V0NjVGhIUXIxRkhTWGJ2UnA4cUR5?=
 =?utf-8?Q?s9rSD1SreYSBVToiTfQ8IvVGu/LhuXm0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEptRjNveVBRRzV6dHFBSHpNaGJiSGFib1BIMU81TDNhNkpFelJabklxbTFr?=
 =?utf-8?B?NkhGdWQ3bWlOZVhBbDN0WE52M3hZbkM1RjJ3dW9lbDdUSnZ3RmIxcEZ1Rmk0?=
 =?utf-8?B?YlBLd0lDTFVKWVNZbm54My9BZndick1UbVZQcTMwTVM1TFdCV3JkWUoxcXFX?=
 =?utf-8?B?WGxjNnQ0WTViVDhwc2ROQXN5SENFOGRjbmNPdXBZYzl6bms4cDRzNzlZQ3k2?=
 =?utf-8?B?cW85WmJGcjNMdHZDRXVaL3Zma3MwNWNWZ1kycjIwTlNPaGdsNmQrUnVTYi9P?=
 =?utf-8?B?Zm9MaU9zT2RQNjlkZmhMQmJKdlRQdWxBaVdwemRHNWo3YXhmY3VkRkRmeWJ4?=
 =?utf-8?B?cGhpNUFJd0VEdisvbERXWGVjZk05M2lTZ3dGbmdOTXlkSUZ0YWlGdGpsK1Rl?=
 =?utf-8?B?SXoxSDgrRUFCampxZnFDY20vS1Z4WDlrTkJtWkI3K3ZGczF0TnBsNEFPMHMy?=
 =?utf-8?B?SnFZUnpLMTB3K0lEb2UvVXBaRFVJczlPM3h0MGdWZGZhUDFiZjFmVk1rRS9Y?=
 =?utf-8?B?RXpkL1JZdTYrS05xYWoxa3R4MDN1QlcrclBTOTA5YzdkYUk0azNHQ2tORFV6?=
 =?utf-8?B?WmxIZDRMcTNDY1RCK2NEV3IrVEgwMkI2ZnFkYk1ZckowanV6cmx5YTA3N1Vs?=
 =?utf-8?B?UkQrSmU2eGFWc2ZsQ2x5ME5ub1VBVUE1aVM3R1RqZ1ZzU2didHB0VzVJYjV4?=
 =?utf-8?B?SlhzcGp0cXQyN2k0b215SHA3aDZnSEc0OEw4V2lkcHlWK3RnTitWK3lmSUFw?=
 =?utf-8?B?TjBFM0RBcTN4WlpKUkhIcUpJY2RjZDE3RnF1NW8vd0g2cWlvNWxzd01GNzY5?=
 =?utf-8?B?elQ0b1IrTkVubFhSU1RBUHZjSE1Ca1FZRHNTUE1rVVRXZUVGd1RKdHhpTmxM?=
 =?utf-8?B?U3hidDlqNnZWLzljakNtQ3ljZHpuOFR5bFJMU1Iza2RocGRMMVFVZXB3OVh3?=
 =?utf-8?B?ZC9WdmdXdVlsUDY5cUpjZlVDdzJnMWRza1R4K1NtL1VvamR1bmdhQjdaQ0Vi?=
 =?utf-8?B?MWNCbllZT1JucjdLTWRwNmdqclpodDhzZ2VTdHFwOUZQVmE0QkRrT1pSS1d2?=
 =?utf-8?B?KzgvTytnNnRRK3ZDbGZldmFiSzRpVGkxd0M2dzFIb3g2Y2FlcG8zMUpCU2hO?=
 =?utf-8?B?STQvOHJYSUVFOTRVbjdKWHJJTXVDdXEzb1JhUGpXTjlNOS80alc3L09wanNQ?=
 =?utf-8?B?QnArUGFEQklGSS9UcStxYXFmRU43bDlQYTE0WDVEVG10WWN1VElzZEUrZElO?=
 =?utf-8?B?UU5Xc2RrVlVTTUVHTEtHMWdKTXVIclRtcU0vc3YrYjQ4aGFrcFZOYkhTMU55?=
 =?utf-8?B?K3pXWW1kSzh5NDZ0UDlSVXdsbzNLb0NiY0x2N0pFeHNBRUZXTGNlSmwyRGRi?=
 =?utf-8?B?UkR0WStNS0twS0RkUGtlbmtzendFZjJvSXZocG0wNEFjTXZUSzNnbmg3Wm1U?=
 =?utf-8?B?azV6UFNEbGVVL0ZHUHQ5a3ZNeE55Y3pXL2FIR21lbGNnaTJQYTVxRkVaUWVE?=
 =?utf-8?B?ZkFwRzVLYy9QZTIvWFlTRjFVSFVQWWZteGxKcWhYNGZIU0pPZmFDWHFYOTZn?=
 =?utf-8?B?cWc3YWI5YWZSWGZYZkN6Ylc0Q1NlaG5rMnF5QVNtRWJOYTVSc2p3K3FIODB1?=
 =?utf-8?B?RjhwVFgyZDZFcjB1bFVzNStQa0dNTkxJY29yWkN5MHZydXNpYVVvUVcrZ0d5?=
 =?utf-8?B?M0FhZFRRZWVhRysvT1ZnS0NVY1QyQ1pocG5TeSswT0Y0bnpVdGRCV3dBNERU?=
 =?utf-8?B?MC9PNmFFdDFsQ2tocTA5SmRSZHBnRTExMlBCaXovNE53TXlzVFRudEFqS2dH?=
 =?utf-8?B?OEhJMlpyNTBkV2xMVzkzeUFzbEZzV1g0cWppWWFQbDAzR0cwQXB0ejZNeUxt?=
 =?utf-8?B?bkxRbWU3Qi80YytlaDJCL3cxL3NVQ3BCb3lXYkVJMUhvOHJzOXhVTzFYbWVY?=
 =?utf-8?B?aG1GTjlsL0h1aEo1Nzc5M0k5STE0YkRIM1ovMjcrVzE3aFN5K2lEN0xuTVQr?=
 =?utf-8?B?bHFCdkJBNVRMYXRoVW5mZzVQRk5aY1RiU2ZHQkNNbXhkM2FiNFB0MHFyOWg0?=
 =?utf-8?B?eGsxaFc5dkZvMWYyVExKZS9KZDd5KytLU1hVc0xJZ082MmpCL3V5SVVSQzhF?=
 =?utf-8?B?VHAvK25qUFJWeEczaXhnRzhoTGFhb1NRNWRxTVBGc2FnNHJxQ2h5WWJXcUJX?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaa3607-2fa6-4436-a2fb-08de237a2453
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 12:34:23.9388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEYS9o44LkpvGp/mj1qTsg5OinNuz22BvyxuIh+Gi7r8hGTtWdjLYz846jA0hz29bj6Ll1FsQ0M0rQl9hNS+Z8HwULJ/CAqpNEHzRitMO2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7604
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

Hi Jan,

On 14/11/2025 8:04 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 14.11.25 12:15, Chee, Tien Fong wrote:
>> Hi,
>>
>> On 14/11/2025 6:54 pm, Jan Kiszka wrote:
>>> [CAUTION: This email is from outside your organization. Unless you
>>> trust the sender, do not click on links or open attachments as it may
>>> be a fraudulent email attempting to steal your information and/or
>>> compromise your computer.]
>>>
>>> On 19.02.25 07:37, Chee, Tien Fong wrote:
>>>> -----Original Message-----
>>>> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>
>>>> Sent: Tuesday, February 18, 2025 4:35 PM
>>>> To: u-boot@lists.denx.de
>>>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>>>> <simon.k.r.goldschmidt@gmail.com>; Tien Fong Chee
>>>> <tien.fong.chee@altera.com>; Alif Zakuan Yuslaimi
>>>> <alif.zakuan.yuslaimi@altera.com>; Tingting Meng
>>>> <tingting.meng@altera.com>; Boon Khai Ng <boon.khai.ng@altera.com>;
>>>> Kok Kiang Hea <kok.kiang.hea@altera.com>; Chee, Tien Fong
>>>> <tien.fong.chee@intel.com>
>>>> Subject: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model
>>>> for system manager in Agilex5
>>>>
>>>> From: Tien Fong Chee <tien.fong.chee@intel.com>
>>>>
>>>> Initial creation of new system manager driver.
>>>>
>>>> Add supports for the SOCFPGA System Manager Register block which
>>>> aggregates different peripheral function into one area.
>>>> On 64 bit ARM parts, the system manager only can be accessed during
>>>> EL3 mode, this driver model provide user the high level access to
>>>> system register and abstract user from low level access.
>>>>
>>>> The base address of system manager can be retrieved using DT
>>>> framework through the System Manager driver.
>>>>
>>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
>>>>
>>>> ---
>>>>
>>>> v1->v2
>>>> - Implement system manager driver to move towards DT probing
>>>> ---
>>>>    arch/arm/mach-socfpga/Makefile                |   3 +-
>>>>    arch/arm/mach-socfpga/altera-sysmgr.c         | 113 ++++++++++++++++
>>>>    .../mach-socfpga/include/mach/altera-sysmgr.h |  16 +++
>>>>    arch/arm/mach-socfpga/include/mach/misc.h     |   2 +
>>>>    .../include/mach/system_manager_soc64.h       | 128 ++++++++++++------
>>>>    arch/arm/mach-socfpga/misc.c                  |  18 ++-
>>>>    board/intel/agilex5-socdk/Makefile            |   7 +
>>>>    board/intel/agilex5-socdk/socfpga.c           |  12 ++
>>>>    configs/socfpga_agilex5_defconfig             |   1 +
>>>>    9 files changed, 250 insertions(+), 50 deletions(-)  create mode
>>>> 100644 arch/arm/mach-socfpga/altera-sysmgr.c
>>>>    create mode 100644 arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
>>>>    create mode 100644 board/intel/agilex5-socdk/Makefile
>>>>    create mode 100644 board/intel/agilex5-socdk/socfpga.c
>>>>
>>>> [...]
>>>>
>>>> Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>
>>>>
>>>> Best regards,
>>>> Tien Fong
>>> This very likely broke all targets except for the agilex5. It definitely
>>> broke the cyclone5.
>>>
>>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
>>> index 9d464307665..e0ed1b8e954 100644
>>> --- a/arch/arm/mach-socfpga/misc.c
>>> +++ b/arch/arm/mach-socfpga/misc.c
>>> @@ -248,6 +248,12 @@ void socfpga_get_managers_addr(void)
>>>           if (ret)
>>>                   hang();
>>>
>>> +#ifndef CONFIG_TARGET_SOCFPGA_AGILEX
>>> +       ret = socfpga_get_base_addr("altr,sys-mgr",
>>> &socfpga_sysmgr_base);
>>> +       if (ret)
>>> +               hang();
>>> +#endif
>>> +
>>>    #ifdef CONFIG_TARGET_SOCFPGA_AGILEX
>>>           ret = socfpga_get_base_addr("intel,agilex-clkmgr",
>>>                                       &socfpga_clkmgr_base);
>>>
>>> Arent't you testing for older designs anymore?
>>
>> You are correct , the patch as-is focuses on Agilex5 and does not fully
>> account for older platforms like Cyclone5. Our initial plan assumed
>> users would follow the Altera official release repo at https://
>> github.com/altera-fpga/u-boot-socfpga , where we are gradually migrating
>> platform devices, including Agilex, Agilex7M, and Agilex5 to the driver
>> model stage by stage.
> We never used downstream U-Boot, we rather invested into upstream
> contributions - quality and sustainability reasons. We do this rather
> consistently with our suppliers, BTW.
>
>> To clarify, as of today, the platform devices for Agilex, Agilex7M, and
>> Agilex5 have already been migrated to the driver model. Older platforms
>> like Cyclone5 still follow the previous non-driver model path.
>>
>> We are now aware that some users are still using mainline U-Boot. To
>> address this, we will update mainline to ensure that existing platforms,
>> including Cyclone5, continue to work as before while maintaining support
>> for the newly migrated Agilex platforms.
> You cannot simply break existing support in mainline just because there
> are some legacy vendor trees that still happen to work. If you confess
> that you don't care about it in mainline, I guess your feature
> contributions will be looked at differently here in the future.


We fully agree that upstream contributions are key for long-term quality 
and sustainability. That’s why our work focuses on mainline U-Boot, with 
staged driver model migrations for newer platforms. We always rebase 
from mainline when a stable version is released and provide official 
releases after testing all supported platforms and features, keeping our 
releases close to mainline while maintaining stability.

To be clear, we care about mainline, breaking existing support was never 
our intention. The focus on platforms was based on the assumption that 
most users follow the official Altera release repo.

We appreciate your feedback and will ensure all mainline contributions 
continue to support existing platforms while adding new features.


>
>> We appreciate your patience and will make sure mainline remains
>> functional for all currently supported platforms during this staged
>> migration.
> I have a first patch ready and will send it in a minute. It will not yet
> migrate to the driver model but it should unbreak all the non-agilex
> targets (I only have a cyclone5 to confirm that).
>
> There is in fact more broken when it comes to loading U-Boot proper from
> SD cards, but that's not your fault this time.


Thank you for providing the patch and for your patience. We will work to 
fix the breakage as quickly as possible.

Regards,

Tien Fong

