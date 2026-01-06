Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04D4C47BF4
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F6083F66;
	Tue,  6 Jan 2026 14:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="DNxlmtpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAB583F6A; Tue,  6 Jan 2026 14:57:24 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F27083F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/Qe2KCIiUDuKjDhpw4G8X9mjHTBEcHWrtwH+gw9keNp1dvK97F9HhATFBXbsHfyygRer0I+ZcaK4zX0Jy6rQn5BePr2zX2X4S4NBKZ4w1DsCogqiRqTCH7/LkB3E8jtmfsbaBAgIDP5nnXAe5xrID5MGRpVTP+dVWbMse2NoTeaqzTxzgoWvZvwGGmKOP2d5ngQ2MtCbt9cNMTgHDxOIleRZ/ZVxIGgnIMJeX9IgLEDP0tayDU2i+I3k8OVb7yoYBvbCVFzQ4i1UuAsZSdDSs7sOmI5tfRNbpXGKzZiez9qxX0YBTujhVRbaC+kK5adULtF8LefLsxLu4bj/mTS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0FfAG2HX23aQO27NgbSyFlswYcoe33BeGCYKj3LakM=;
 b=enxtn+t5Aq0k30ek9dnKe+zjjqQbC0Fb3PSBQdvNBbWHPZ4d4bQCNs8SApkHlhBqYoMLt5+PMR2IxAFqRL8JbsI0VcegHuJBIDnWJALGQWSCVMJkdnA87pJ0F89FPyiVfuxEhvBr4rmUfksp/ZX7MoZm9aw0ilLRRyaUC2NvlW9Zvgr0lElEIMw4m7PIgNrKyxMi5seWlkJ7hizCRwY6LjN76OyNsVQI2dXxRtxJZJqcmsA4SaKNjY5rznQvxp8FvG150v1rE00gYpaIaptqElHaRyA38x0t5oiDiPFlp5YUoVLmhr7lYFJyHFLCwwAFP+Rp9GMgrZFBhIAA5GhWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0FfAG2HX23aQO27NgbSyFlswYcoe33BeGCYKj3LakM=;
 b=DNxlmtptmmuEDqHKcMFZHjDljujc0m4q44TxFpF7reriFQhTmHDwegtQgJSqGA0WkbKRMd6YtLv3Jcn8wwrNqKDbvPVvcBEu3PA6VwfahKHjcFMA12izn6VXSTU/eL1GDa5hsFvnhX48tQWQ61oG6YIXpMaamQRabq9dPf2VmPpmf8ZqiOrd9Hi7CdxjnosEaOlWjfQicaDEfnK7lPL1SNSk6zaGLJbOcGzU6iC7XErrgK3OVJ5H9BLL2Uwx5G+iJEBrXZ6+H3imnUJ2KI7Eeij4MltBAJWhzI6xMAW1GpyjSoAHAs8r7LkoSi3A/aLR+n0BSYualjAafhnYAfmaeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 13:57:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 13:57:09 +0000
Message-ID: <c91fb323-bf43-44c8-81b9-abed42e15654@siemens.com>
Date: Tue, 6 Jan 2026 14:57:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add support for BeagleV-Fire
To: Jamie.Gibbons@microchip.com, u-boot@lists.denx.de
Cc: Valentina.FernandezAlanis@microchip.com,
 nobuhiro.iwamatsu.x90@mail.toshiba, trini@konsulko.com,
 Conor.Dooley@microchip.com, ziyao@disroot.org, Cyril.Jean@microchip.com,
 rick@andestech.com, ycliang@andestech.com, junhui.liu@pigmoral.tech
References: <20251209114521.164647-1-jamie.gibbons@microchip.com>
 <8dc60721-bfd3-4421-9b47-956c18314fc3@siemens.com>
 <c238c6bc-137e-414e-87d9-862e8da20e55@siemens.com>
 <1c8aaf87825eb918020254d80203a902b735f609.camel@microchip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1c8aaf87825eb918020254d80203a902b735f609.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 070fadf3-9e88-4f03-90df-08de4d2b7c05
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU10UHlKazRpbExXcFJmL0MzOGdXbHo2enpaY28zYVRCa2NMWUNPMlluelFy?=
 =?utf-8?B?YkJJR3g4bEc3cEg3YW9wKzRCa0lQNVQ4N1ZPb3RMcis0cVpGdjczanUzOEpl?=
 =?utf-8?B?SjN0M0ZveXoxWHM0dXJRdHo1aUZLK0hzVVA0THFIVUhkdWUrSElmc0x4M2lp?=
 =?utf-8?B?VFFnZG1lZVF4TkdwNldNK3J6UzhVQ0E1dXpPanBidTdBa0RhQll4TWw5aDhI?=
 =?utf-8?B?Z3YzYWZPLzZXdmsvc21vUGhWZ0NpVTJUTjVNaXFZUGVmaEcxU1VVOFlzOXl3?=
 =?utf-8?B?K0lEZG9CVzlFaVRxUGo5WVJXQUFCNDhlMEJiTHRCUEYwTG95ZFNzTUxHeU1X?=
 =?utf-8?B?ZityNUR2Nzd0aU1LZ2F0ZHJsQWpOTEdReTY4WFJqdmJXR1ljUytaU1ZJeXR5?=
 =?utf-8?B?VFUxajM3RUI4Y1BNcFR1RzBPV1ZaYk0weVVrQlhUbVk5d0luM0V6czYzQ0tn?=
 =?utf-8?B?emhRcUdqczdEM3BwTmpuUG5GS1EzMmtHakFpMUFJczhkc0xiRGhWOEtPaGFG?=
 =?utf-8?B?dW5kQ1JpRTZaTE81VEdXcG1HYkhIdUp0RlJWWW5DNDE4ZUlLME5RSERwSWp2?=
 =?utf-8?B?TUF3c1VVQm5Uc3F3SjBaQVIvemRrUysvcmp4M2Q1ekM3Q3hZSEl5QWtpNUtz?=
 =?utf-8?B?M0FycWhQY3pvU3dxRGx3UHNpSkFJNU5TYkkxYnhJQkwzSEZLQXVScUhXeHpC?=
 =?utf-8?B?V3M1VnlGSmp6RmRMZ2JWMjNtaTBCTWlQYUg5YXBFbkVwdzhoR3E0UEs2emJJ?=
 =?utf-8?B?aU93NDh1N0dRZUM0WlE5T2pXcm1IK29uT2l4T2VZM2xyamFQRHRRMy96ODhx?=
 =?utf-8?B?eEpWSDJFVlhwUWZuN2hjaGYyQ3VUQ1FCK0ZYQnZwN1R3SHV0a1VkeFEzajNp?=
 =?utf-8?B?Yko1OHk2a25QMVBEYkI4d2ZQdGNzWlhSRVZXUDVsY2VqbjZRSkdWRjROckwr?=
 =?utf-8?B?Zmw3UTFBOWhjY24zc0RCdTNIOFF3bmxTN1JrQzZTUDBUYzRsVjFQcG5MNXVs?=
 =?utf-8?B?QXVEakw1dDh3OWVtejE0K21ZNmV1eTMveFpsZnZrN2FwaHZsb1owVlBhbHVo?=
 =?utf-8?B?bHMvU1hycm56ZFMxU1NTK0p4aXB2MUJNWjQzZmV0ZFBGRCtIOVkzTXFjdFdB?=
 =?utf-8?B?OFlpS0RoMWJRd3NUUU5OQkc3YmdSY0l5YU1WZ2kzeEZTUFFCR2dSa09jbG5M?=
 =?utf-8?B?enJLM3NiWUNYSUc4eU9PQkcvVUpqaG9wVU1XNWlIV2VKcThEcFRRTjRQazF6?=
 =?utf-8?B?NWxrcWwvWUlhYXYzVTVEZHlFUDJQSll1enBDanVSSFZEVGMxYW9kVFpSWXc4?=
 =?utf-8?B?QmVEOE5MczF0YUJ6WTIwTXpFNExNb0JIb1dvVlNDZHhkdjZHZDBRaXR5bFdo?=
 =?utf-8?B?TEVZNGdLeXg1T3J2clNCamMvdXhBbCthZVJ0TVpyaDA0V0Jqdkxqb1JyR3c1?=
 =?utf-8?B?NnhhVDh5cml3RTZsMThCZmdldUxacU9tTjVsNVpXU3R5V0VNdW1FTjdiZllY?=
 =?utf-8?B?SEVTUmNrZ1lWaUNLbkhNVHc2RHFDc0ovWWgxVUJyNTRVZFc0TjhjbnlEV1FY?=
 =?utf-8?B?VDFZMWpyRHZaSkZkOUlqOEtSVzVZWTFrMFlsQnhjbjdReTZldHNVQjFTaW80?=
 =?utf-8?B?cmhrNzlBbGJIY2IvZnZaQUJsMENnMWptdnh5S3h5dGloTDVBVXJvUlR4ZDIr?=
 =?utf-8?B?emU3Qy9MaUo2MVY0VEVhZktweFBGOXZ4dEEzblV2NWlCcXdPcVozZU5rdlc2?=
 =?utf-8?B?bWRzTHExTEMrUks1bkNTVXNHRkpPOUtBd1NKbzUyZWsxd0tWY3QrTVlsK3BT?=
 =?utf-8?B?L2RXc3BaTDQzcGxTRXBEZ1R1MnZlOGJnRHN4eEdhVEoyRXZyK1NTUlh4SHVG?=
 =?utf-8?B?RUFrazltckVWM1FPQkdKK21EUW5VUkdET3JMVTJWLzVBYmFVUDRDaTdwZWZK?=
 =?utf-8?B?dWRCc1k4WHZVMHNocHJ5ZmY4eVV2U280SzIwblJwK0V3YUtUOUl5MWJwZlhn?=
 =?utf-8?B?UmdzNkdDQWVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVLVThoSkc0c1UxQk1PMmtUOTltMnY2K2VsYkc1WktkR1Q1MWdmRTNGZTVi?=
 =?utf-8?B?Vit5bjZaNzNGWWNVQStWdEJBNDd5UWNrdTNLVzZtTkF1aEppYmg4N3BlTkx1?=
 =?utf-8?B?WmJkQXVlYzRrTVBEQmo5NjYveU1paWVkYmRJTFRYbjR3QlNSV0FtbmE5Q05P?=
 =?utf-8?B?MEZBSW44NWFFVmkwenJ6cnVERHNFZFZ6RUpIRjhWZnRxMU1XN3czRUZZQ1ds?=
 =?utf-8?B?aGlwZzNvTXhXRmpOMkpkaURYTTRMN2paS0U3NHBldmRGMW1XeWtSREkya3pa?=
 =?utf-8?B?WW8zMU9pS0lldm5HdVVXVkRUbVJPcnBWMGRXS1lJOW9RUHRHT2JZbTdGczFK?=
 =?utf-8?B?U2lDWHB3WUZPSnRNM2paWFFkWndYSGFhR2Naa01QNWVKeDhBMGpEeTNVTjd5?=
 =?utf-8?B?UFlRTldsZlR2ZGdtVy9oYjlKVWtmbi95MmtJZTQzdVY2NE10elFJSGFZVlJ0?=
 =?utf-8?B?WE4ycGN4YzN1dmZ3RndXQm1qcDZ3UENId0pPNGZDbmdKa1dKT2JWSTJVWHJx?=
 =?utf-8?B?MzRVVGRrdDE2bjA3cjkxbTc1bS9Yd2NTMzFUSHBuZFBRb3ZDZWxUZm1lTnky?=
 =?utf-8?B?VjEreGJzVEtsTEd3SCtlcVFDay9vaTBhd2F6ZGVkVWtOTDZXMlBhUytIWlJi?=
 =?utf-8?B?RnV3TWszOTlvQ09ucG9iMm9PajNRV2xtTTZpejJJN1NiTHNGUXBUUFpINU5a?=
 =?utf-8?B?bmJpQ3RwcnM3YzVQdU9OTGZqWnZXOEtsWExyVnN4MzRtMHE3MnRHZnFVV0tW?=
 =?utf-8?B?QWJhdjdEWnpMcHMvOHk4cmg3cm9TVEpRUUdOM05ZbmdXQndQSU9KeGdzaURZ?=
 =?utf-8?B?MEpDT2p5emRWbEw3ZHFua21JbUYxcUtSSTFFSjRGNFhFcDNyRmNWeExGcFd5?=
 =?utf-8?B?bTlPc1E0TGZBQU5lZGR4NVAxcENYaFhlM3BnVU9mdTViRG1ZRzhFZUZZTm5P?=
 =?utf-8?B?bGcrZ1dScU1ZWGwvVnZjR2swUFpGL2U5TVZqMkgyTklGQm51YjAxTlN3a2Y4?=
 =?utf-8?B?c2dDak11ZDdtbU54dStJRm5Pbi8ybFNGMjZTK0hyVnFmOEtVRWpUOU5Vbk5F?=
 =?utf-8?B?MjdjOW9IR0tkUkdCbVl4MWZOUkNVbktrZXVDbjdsR0N4T00wL2JmODdpa1Bm?=
 =?utf-8?B?Q292STZMTVBDakJRT1FSUW9IVm55RWhiS2ZHNlFpOW9LZHYzbkljMHZqZUFG?=
 =?utf-8?B?amNTR1NTVG1UeFFQeWZTd1NNVjd5cnEvcWxMS2VkWGp6R1F6RWFNUTlwck5p?=
 =?utf-8?B?dkhwU1ZzU3NDM2l2YzlPN1RVMUpwN3dsRWxDRERrY1NqNDNzWEFESVU2Nk1T?=
 =?utf-8?B?WVJpcTd2VlV2cUcrOTNHWG9PcEdBejdmSVowZFI5amJ0ejk0YVdVZmEyMjZm?=
 =?utf-8?B?aUlPYnRjbUlFMGNZTEhTa1Bnc1dtbGFuOW92dlhtUWsxSlN4UUxyQi92V2Ny?=
 =?utf-8?B?T0JLSklFcGhpd2VvNC8vUDYvcUpkMVhuVCt5a1U1d3I2UVRQZFdZdmQxbnEy?=
 =?utf-8?B?aWJ0OFV1eGtUN2NJY1Q4TGlIWnhIQklnb1RLZENTSUdYMlVqaHZtM2hUcm41?=
 =?utf-8?B?OXpTZk1qUmxFeE5UeGtGQU1xOEFqcjh0L2FMSFVXNVpyMlNsSm1RQWhZUndo?=
 =?utf-8?B?Nkc1RHR5ZlhoT1VQWVdST0t4eXpWd2hxa1U4VU1peWtwRERlYUtyS00xWi9m?=
 =?utf-8?B?NEp4QXhteUdFMmVqZXNzWkNNZkVuNW4vV3diRnZwQ0l5TGdqSERTUmJXKzJN?=
 =?utf-8?B?dnZjZENIL3dPZEVYclZZMkx4TjRZREVDRjhFdExZVEN2WU8rc094OWRlK1NF?=
 =?utf-8?B?TlEybFJqaldmN2dLcnowVVpnMUREeTJYZGFnOFdCb2NFQUswUlNsdkU5YjFz?=
 =?utf-8?B?WHVWMnVYckJXVWlEYS9MeXdvVWg5WVQvdFpmME8wNk9seHlBQkU0dzU1VjZT?=
 =?utf-8?B?cnNaandFME83bGU4bkdsZTNZNEx2RVFEUHpjb3RRcS9LcU9UcXlvMlJ2Uys1?=
 =?utf-8?B?VVA4cE1ZMUVFTE42L0YzNmNNVys1Z0E2Y1hYSGY1VVE0cUt3VVVnNS9MSENJ?=
 =?utf-8?B?ekZEbWJTVThYOVV6Mk9IUmplb2wzeWJxS3kwekExMHdMVm5qUXIzeVl2cUpY?=
 =?utf-8?B?eHhzR3dGeXZRZ2xVT0JGREFpM1RDOHRjSUEyVDQ1N2JjYUQ5Yk1JanUxWDZs?=
 =?utf-8?B?MlBycVdlSm1qOTdnb0F5Zm9nMkxoTGQ3YWx0VG5TUHIzL1l0U04vSEtQeFV4?=
 =?utf-8?B?SFFWSEc5bVJUZGt4RmhuSzVFT2VGcDEveDd0em5ubVppOXhiY1hTSE53clBm?=
 =?utf-8?B?Um4xZzRZUTBub2hzQXEvL0tyOXhGTk50Mlo1V080Y1FBQnFNSEJrZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070fadf3-9e88-4f03-90df-08de4d2b7c05
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:57:09.4123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQZcwqyyQNJaV2EocekyHgE4msyte23JF8NMAKM+kxx+jF4UxmGYBMW2UgtdNc+eS73932jrLEFCHbBJVgnnLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7386
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

On 06.01.26 12:55, Jamie.Gibbons@microchip.com wrote:
> Hi Jan,
> 
> Apologies for the delayed response, I was off over the Christmas. Thank
> you for your thorough review and for testing the patch on top of U-Boot
> next.
> On Tue, 2025-12-23 at 01:35 +0100, Jan Kiszka wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> On 20.12.25 15:56, Jan Kiszka wrote:
>>> On 09.12.25 12:45, Jamie Gibbons wrote:
>>>> Bring U-Boot support for the BeagleV-Fire by adding a defconfig
>>>> and
>>>> supporting board files etc.
>>>>
>>>> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
>>>> ---
>>>>  arch/riscv/Kconfig                       |   4 +
>>>>  board/beagle/beaglev_fire/Kconfig        |  39 ++++++++
>>>>  board/beagle/beaglev_fire/MAINTAINERS    |   7 ++
>>>>  board/beagle/beaglev_fire/Makefile       |   6 ++
>>>>  board/beagle/beaglev_fire/beaglev_fire.c | 117
>>>> +++++++++++++++++++++++
>>>>  configs/beaglev_fire_defconfig           |  29 ++++++
>>>>  include/configs/beaglev_fire.h           |  57 +++++++++++
>>>>  7 files changed, 259 insertions(+)
>>>>  create mode 100644 board/beagle/beaglev_fire/Kconfig
>>>>  create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
>>>>  create mode 100644 board/beagle/beaglev_fire/Makefile
>>>>  create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
>>>>  create mode 100644 configs/beaglev_fire_defconfig
>>>>  create mode 100644 include/configs/beaglev_fire.h
>>>>
>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>> index 265b5320777..dd98dee8eab 100644
>>>> --- a/arch/riscv/Kconfig
>>>> +++ b/arch/riscv/Kconfig
>>>> @@ -17,6 +17,9 @@ config TARGET_ANDES_VOYAGER
>>>>  config TARGET_BANANAPI_F3
>>>>      bool "Support BananaPi F3 Board"
>>>>
>>>> +config TARGET_BEAGLEBOARD_BEAGLEVFIRE
>>>> +    bool "Support BeagleBoard BeagleV-Fire Board (based on
>>>> Microchip MPFS)"
>>>> +
>>>>  config TARGET_K230_CANMV
>>>>      bool "Support K230 CanMV Board"
>>>>
>>>> @@ -106,6 +109,7 @@ config SPL_ZERO_MEM_BEFORE_USE
>>>>  source "board/andestech/ae350/Kconfig"
>>>>  source "board/andestech/voyager/Kconfig"
>>>>  source "board/aspeed/ibex_ast2700/Kconfig"
>>>> +source "board/beagle/beaglev_fire/Kconfig"
>>>>  source "board/canaan/k230_canmv/Kconfig"
>>>>  source "board/emulation/qemu-riscv/Kconfig"
>>>>  source "board/microchip/mpfs_generic/Kconfig"
>>>> diff --git a/board/beagle/beaglev_fire/Kconfig
>>>> b/board/beagle/beaglev_fire/Kconfig
>>>> new file mode 100644
>>>> index 00000000000..279d38b3aa9
>>>> --- /dev/null
>>>> +++ b/board/beagle/beaglev_fire/Kconfig
>>>> @@ -0,0 +1,39 @@
>>>> +if TARGET_BEAGLEBOARD_BEAGLEVFIRE
>>>> +
>>>> +config SYS_BOARD
>>>> +    default "beaglev_fire"
>>>> +
>>>> +config SYS_VENDOR
>>>> +    default "beagle"
>>>> +
>>>> +config SYS_CPU
>>>> +    default "mpfs"
>>>> +
>>>> +config SYS_CONFIG_NAME
>>>> +    default "beaglev_fire"
>>>> +
>>>> +config TEXT_BASE
>>>> +    default 0x80000000 if !RISCV_SMODE
>>>> +    default 0x80200000 if RISCV_SMODE
>>>> +
>>>> +config BOARD_SPECIFIC_OPTIONS # dummy
>>>> +    def_bool y
>>>> +    select MICROCHIP_MPFS
>>>> +    select BOARD_EARLY_INIT_F
>>>> +    select BOARD_LATE_INIT
>>>> +    imply SMP
>>>> +    imply CMD_DHCP
>>>> +    imply CMD_EXT2
>>>> +    imply CMD_EXT4
>>>> +    imply CMD_FAT
>>>> +    imply CMD_FS_GENERIC
>>>> +    imply CMD_NET
>>>> +    imply CMD_PING
>>>> +    imply CMD_MMC
>>>> +    imply DOS_PARTITION
>>>> +    imply EFI_PARTITION
>>>> +    imply IP_DYN
>>>> +    imply ISO_PARTITION
>>>> +    imply PHY_LIB
>>>> +    imply PHY_VITESSE
>>>> +endif
>>>> diff --git a/board/beagle/beaglev_fire/MAINTAINERS
>>>> b/board/beagle/beaglev_fire/MAINTAINERS
>>>> new file mode 100644
>>>> index 00000000000..a5dad93ee99
>>>> --- /dev/null
>>>> +++ b/board/beagle/beaglev_fire/MAINTAINERS
>>>> @@ -0,0 +1,7 @@
>>>> +BeagleBoard MPFS BeagleV-Fire
>>>> +M:  Cyril Jean <cyril.jean@microchip.com>
>>>> +M:  Jamie Gibbons <jamie.gibbons@microchip.com>
>>>> +S:  Maintained
>>>> +F:  board/beagle/beaglev_fire/
>>>> +F:  include/configs/beaglev_fire.h
>>>> +F:  configs/beaglev_fire_defconfig
>>>> \ No newline at end of file
>>>> diff --git a/board/beagle/beaglev_fire/Makefile
>>>> b/board/beagle/beaglev_fire/Makefile
>>>> new file mode 100644
>>>> index 00000000000..a4109a8aad4
>>>> --- /dev/null
>>>> +++ b/board/beagle/beaglev_fire/Makefile
>>>> @@ -0,0 +1,6 @@
>>>> +# SPDX-License-Identifier: GPL-2.0+
>>>> +#
>>>> +# Copyright (C) 2023 Microchip Technology Inc.
>>>> +#
>>>> +
>>>> +obj-y       += beaglev_fire.o
>>>> \ No newline at end of file
>>>> diff --git a/board/beagle/beaglev_fire/beaglev_fire.c
>>>> b/board/beagle/beaglev_fire/beaglev_fire.c
>>>> new file mode 100644
>>>> index 00000000000..b2f18c455b7
>>>> --- /dev/null
>>>> +++ b/board/beagle/beaglev_fire/beaglev_fire.c
>>>> @@ -0,0 +1,117 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (C) 2019-2023 Microchip Technology Inc.
>>>> + */
>>>> +
>>>> +#include <dm.h>
>>>> +#include <dm/devres.h>
>>>> +#include <env.h>
>>>> +#include <asm/global_data.h>
>>>> +#include <asm/io.h>
>>>> +#include <linux/compat.h>
>>>> +#include <mpfs-mailbox.h>
>>>> +
>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>> +
>>>> +#define MPFS_SYSREG_SOFT_RESET      ((unsigned int *)0x20002088)
>>>> +#define PERIPH_RESET_VALUE          0x800001e8u
>>>> +
>>>> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
>>>> +static unsigned char mac_addr[6];
>>>> +#endif
>>>> +
>>>> +int board_init(void)
>>>> +{
>>>> +    /* For now nothing to do here. */
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int board_early_init_f(void)
>>>> +{
>>>> +    unsigned int val;
>>>> +
>>>> +    /* Reset uart, mmc peripheral */
>>>> +    val = readl(MPFS_SYSREG_SOFT_RESET);
>>>> +    val = (val & ~(PERIPH_RESET_VALUE));
>>>> +    writel(val, MPFS_SYSREG_SOFT_RESET);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int board_late_init(void)
>>>> +{
>>>> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
>>>> +    u32 ret;
>>>> +    int node;
>>>> +    u8 device_serial_number[16] = {0};
>>>> +    void *blob = (void *)gd->fdt_blob;
>>>> +    struct udevice *dev;
>>>> +    struct mpfs_sys_serv *sys_serv_priv;
>>>> +
>>>> +    ret = uclass_get_device_by_name(UCLASS_MISC,
>>>> "syscontroller", &dev);
>>>> +    if (ret) {
>>>> +            debug("%s: system controller setup failed\n",
>>>> __func__);
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    sys_serv_priv = devm_kzalloc(dev, sizeof(*sys_serv_priv),
>>>> GFP_KERNEL);
>>>> +    if (!sys_serv_priv)
>>>> +            return -ENOMEM;
>>>> +
>>>> +    sys_serv_priv->dev = dev;
>>>> +
>>>> +    sys_serv_priv->sys_controller = mpfs_syscontroller_get(dev);
>>>> +    ret = IS_ERR(sys_serv_priv->sys_controller);
>>>> +    if (ret) {
>>>> +            debug("%s:  Failed to register system controller sub
>>>> device ret=%d\n", __func__, ret);
>>>> +            return -ENODEV;
>>>> +    }
>>>> +
>>>> +    ret = mpfs_syscontroller_read_sernum(sys_serv_priv,
>>>> device_serial_number);
>>>> +    if (ret) {
>>>> +            printf("Cannot read device serial number\n");
>>>> +            return -EINVAL;
>>>> +    }
>>>> +
>>>> +    /* Update MAC address with device serial number */
>>>> +    mac_addr[0] = 0x00;
>>>> +    mac_addr[1] = 0x04;
>>>> +    mac_addr[2] = 0xA3;
>>>> +    mac_addr[3] = device_serial_number[2];
>>>> +    mac_addr[4] = device_serial_number[1];
>>>> +    mac_addr[5] = device_serial_number[0];
>>>> +
>>>> +    node = fdt_path_offset(blob, "/soc/ethernet@20110000");
>>>> +    if (node >= 0) {
>>>> +            ret = fdt_setprop(blob, node, "local-mac-address",
>>>> mac_addr, 6);
>>>> +            if (ret) {
>>>> +                    printf("Error setting local-mac-address
>>>> property for ethernet@20110000\n");
>>>> +                    return -ENODEV;
>>>> +            }
>>>> +    }
>>>> +
>>>> +    mpfs_syscontroller_process_dtbo(sys_serv_priv);
>>>> +#endif
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int ft_board_setup(void *blob, struct bd_info *bd)
>>>> +{
>>>> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
>>>> +    u32 ret;
>>>> +    int node;
>>>> +
>>>> +    node = fdt_path_offset(blob, "/soc/ethernet@20110000");
>>>> +    if (node >= 0) {
>>>> +            ret = fdt_setprop(blob, node, "local-mac-address",
>>>> mac_addr, 6);
>>>> +            if (ret) {
>>>> +                    printf("Error setting local-mac-address
>>>> property for ethernet@20110000\n");
>>>> +                    return -ENODEV;
>>>> +            }
>>>> +    }
>>>> +#endif
>>>> +
>>>> +    return 0;
>>>> +}
>>>> \ No newline at end of file
>>>> diff --git a/configs/beaglev_fire_defconfig
>>>> b/configs/beaglev_fire_defconfig
>>>> new file mode 100644
>>>> index 00000000000..c476fb103c5
>>>> --- /dev/null
>>>> +++ b/configs/beaglev_fire_defconfig
>>>> @@ -0,0 +1,29 @@
>>>> +CONFIG_RISCV=y
>>>> +CONFIG_SYS_MALLOC_LEN=0x800000
>>>> +CONFIG_SYS_MALLOC_F_LEN=0x2000
>>>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>> +CONFIG_ENV_SIZE=0x2000
>>>> +CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-beaglev-fire"
>>>> +CONFIG_SYS_PROMPT="RISC-V # "
>>>> +CONFIG_OF_LIBFDT_OVERLAY=y
>>>> +CONFIG_SYS_LOAD_ADDR=0x80200000
>>>> +CONFIG_TARGET_BEAGLEBOARD_BEAGLEVFIRE=y
>>>> +CONFIG_ARCH_RV64I=y
>>>> +CONFIG_RISCV_SMODE=y
>>>> +CONFIG_FIT=y
>>>> +CONFIG_OF_BOARD_SETUP=y
>>>> +CONFIG_DISTRO_DEFAULTS=y
>>>> +CONFIG_DISPLAY_CPUINFO=y
>>>> +CONFIG_DISPLAY_BOARDINFO=y
>>>> +CONFIG_SYS_CBSIZE=256
>>>> +CONFIG_SYS_PBSIZE=282
>>>> +CONFIG_SYS_BOOTM_LEN=0x4000000
>>>> +CONFIG_OVERWRITE_ETHADDR_ONCE=y
>>>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>>> +CONFIG_BOOTP_SEND_HOSTNAME=y
>>>> +CONFIG_SYSRESET=y
>>>> +CONFIG_MPFS_GPIO=y
>>>> +CONFIG_CMD_GPIO=y
>>>> +CONFIG_DM_GPIO=y
>>>> +CONFIG_MMC_SPI=y
>>>
>>> I think you are missing CONFIG_OF_UPSTREAM=y. I applied this on top
>>> of
>>> next and only got things compiling after turning it manually on.
>>>
>>
>> And another issue: CONFIG_DEFAULT_FDT_FILE is missing, leaving
>> fdtfile
>> uninitialized which means that distro_boot is incomplete.
>>
> You are correct, both of these configs are missing from the defconfig.
> I am not quite sure how I managed to miss those in creation of this
> patch, thanks for catching that.
>>>> diff --git a/include/configs/beaglev_fire.h
>>>> b/include/configs/beaglev_fire.h
>>>> new file mode 100644
>>>> index 00000000000..e3ee0f02f2d
>>>> --- /dev/null
>>>> +++ b/include/configs/beaglev_fire.h
>>>> @@ -0,0 +1,57 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>> +/*
>>>> + * Copyright (C) 2023 Microchip Technology Inc.
>>>> + */
>>>> +
>>>> +#ifndef __CONFIG_H
>>>> +#define __CONFIG_H
>>>> +
>>>> +#include <linux/sizes.h>
>>>> +
>>>> +#define CFG_SYS_SDRAM_BASE       0x80000000
>>>> +
>>>> +/* Environment options */
>>>> +
>>>> +#if defined(CONFIG_CMD_DHCP)
>>>> +#define BOOT_TARGET_DEVICES_DHCP(func)      func(DHCP, dhcp, na)
>>>> +#else
>>>> +#define BOOT_TARGET_DEVICES_DHCP(func)
>>>> +#endif
>>>> +
>>>> +#if defined(CONFIG_CMD_MMC)
>>>> +#define BOOT_TARGET_DEVICES_MMC(func)       func(MMC, mmc, 0)
>>>> +#else
>>>> +#define BOOT_TARGET_DEVICES_MMC(func)
>>>> +#endif
>>>> +
>>>> +#define BOOT_TARGET_DEVICES(func) \
>>>> +    BOOT_TARGET_DEVICES_MMC(func)\
>>>> +    BOOT_TARGET_DEVICES_DHCP(func)
>>>> +
>>>> +#define BOOTENV_DESIGN_OVERLAYS \
>>>> +    "design_overlays=" \
>>>> +    "if test -n ${no_of_overlays}; then " \
>>>> +            "setenv inc 1; " \
>>>> +            "setenv idx 0; " \
>>>> +            "fdt resize ${dtbo_size}; " \
>>>> +            "while test $idx -ne ${no_of_overlays}; do " \
>>>> +                    "setenv dtbo_name dtbo_image${idx}; " \
>>>> +                    "setenv fdt_cmd \"fdt apply $\"$dtbo_name; "
>>>> \
>>>> +                    "run fdt_cmd; " \
>>>> +                    "setexpr idx $inc + $idx; " \
>>>> +            "done; " \
>>>> +    "fi;\0 " \
>>>> +
>>>> +#include <config_distro_bootcmd.h>
>>>> +
>>>> +#define CFG_EXTRA_ENV_SETTINGS \
>>>> +    "bootm_size=0x10000000\0" \
>>>> +    "kernel_addr_r=0x80200000\0" \
>>>> +    "fdt_addr_r=0x8a000000\0" \
>>>> +    "fdtoverlay_addr_r=0x8a080000\0" \
>>>> +    "ramdisk_addr_r=0x8aa00000\0" \
>>>> +    "scriptaddr=0x8e000000\0" \
>>>> +    BOOTENV_DESIGN_OVERLAYS \
>>>> +    BOOTENV \
>>>> +
>>>> +#endif /* __CONFIG_H */
>>>
>>> No luck with booting next(29ab19c2bead)+this yet, though. No output
>>> after
>>>
>>> [9.356454] Boot image set name: "PolarFire-SoC-HSS::U-Boot"
>>>
>>
>> This is probably some regression when using u-boot next.
>>
>>> Am I missing dependencies?
>>>
>>
>> I have now this queue on top of v2026.01-rc5:
>>
>> riscv: Add support for BeagleV-Fire
>> riscv: mpfs: move SoC level options to the CPU Kconfig
>> riscv: create a custom CPU implementation for PolarFire SoC
>>
>> With this (and the config fixes above), upstream U-Boot finally
>> starts.
> Apologies, I got ahead of myself. When I sent this patch the above two
> patches I sent had not yet been merged. They are now both merged to
> next & master.
> 
> Thanks again for your feedback and for sharing your working queue.
> Should you need me to send a v2 to add the missing two configs or have
> any other issues please let me know, however, with the addition of the
> two configs, this should now be good to go.

The 2 configs switches should go into the defconfig. So, if this patch
is not yet queued (which seems to be so), I would recommend sending v2
with those included.

BTW, our CIP Debian image with all bits glued together is staged at [1].
U-Boot build is described in [2].

Thanks,
Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/beaglev-fire?ref_type=heads
[2]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/c2522a186e52da32551d71d32cf5d5bd1a5077c3

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
