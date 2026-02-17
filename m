Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1982FE6816F
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8112580325;
	Tue, 17 Feb 2026 12:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6mArIh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B4883AA9; Tue, 17 Feb 2026 12:07:05 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C948802C1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h16uuSGXnQVF/FBHb9/nCeVYLA7IieYmCIet6bQBBnLHtv5t8Bkm6WYoNE6pXsRZfuU1rQ80joUKOXjvBvlv2Hq9IuD3N743UI26+54YEpD6lYNjU4AfWGM9dlbUCAooYiou6Da3iu4iIH0GVeXx1zy/XfMIAbOoDXZ/C333shEyFduixMSQwDnyXXewbU804pbmN3/Qi3x2AHjNz0XR/gJ/UHPtQ8Ow15bcOyEI0BlH1GUE/AkPPfznmzcvG35DI/rQUFy7zYKXCQW8SG+HvSig3sWR5Ug+mAJBgxNmbFLvXmpXFy74t0HfbCvq3pj1Vt8zFO13MuDTUPgH7o93sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urEcQP/oF5fpBGOYqWXXNFbwuzrMH/T9egP8WDhidwU=;
 b=pWjvhwFuqrMoKARrPMy7ZFgG+lgFbrFOmPng5t4QiDKQKy4MfnYFgPGgZIqz89OihZhMrnGx0OdD4ogxebcse83r3bW9tXuZ4n2CNEbceT4BJdFqiLD4EAiKhuV3Imz0eE5J1BMwAnrz7ltxg4x80V3pd5/boPMFuAngCjcTawhgNnA9UlhdUUkytVuyamecC0lAV6DVLOwtCL8tysWaHl0dqc9/BswyUysvMbCb0/m7OfNMVki75RlfOXAqTCanm6Y10RT/1duXyhhdYZ0hCHEYV8mdhrUaRDdWPrfgYozGKDN9rMTu/c8yQTuPBRpohNPRT+0UFoDFfJfgGxvmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urEcQP/oF5fpBGOYqWXXNFbwuzrMH/T9egP8WDhidwU=;
 b=S6mArIh2v3jOrc0KpPBqAJptDD2KJ60tjrBan3eU4YPKxFNaLWJZi5oVydHaOdeJyL9e7Nza0iYo5I6aX3MMeqmAi75C480TSjbFvEPKXDfuVlb3nd7hnOe7nvTjGgcQ1OZ3JzpUI6p0+2PM+5f9E3gZFEf/tNiIbcMFib660cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:06:56 +0000
Received: from SN7PR12MB6931.namprd12.prod.outlook.com
 ([fe80::f6fd:4b02:a116:fcaf]) by SN7PR12MB6931.namprd12.prod.outlook.com
 ([fe80::f6fd:4b02:a116:fcaf%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 11:06:56 +0000
Message-ID: <bdc7163d-c3f2-482e-9abf-79b6b49f454e@amd.com>
Date: Tue, 17 Feb 2026 12:06:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Initialize Xilinx glue registers
From: Michal Simek <michal.simek@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Love Kumar <love.kumar@amd.com>
References: <20260106221728.738219-1-sean.anderson@linux.dev>
 <8265ad50-83d1-40fa-943d-b6e64d9b7812@amd.com>
 <8dad4173-4b2b-4ba7-8e73-838182570bc1@mailbox.org>
 <ce3b1b60-4c05-4255-9a46-e32751a269a9@linux.dev>
 <5f5e5b53-bbbc-459f-a7bb-b0598aaf6383@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <5f5e5b53-bbbc-459f-a7bb-b0598aaf6383@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0070.eurprd02.prod.outlook.com
 (2603:10a6:802:14::41) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6931:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 14664c27-ebf0-4e2d-397f-08de6e14a984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGtTRHJlT2Zmd3hqNDNGVVMzaXBFYVVHb1ZUSkY2REZuTGhMdFhHc1NpU29w?=
 =?utf-8?B?cmpIZlp1YlBzNU12UUVGOWczOSt0ZXl3WFJoQ1ZVam1PU3ZMZTRWcVVGTEdB?=
 =?utf-8?B?VktlVTRlT0ljb2l6Y3NsU01FcFhMOXhKSStLTGo1USsreGlBc0dQNkNjbk9K?=
 =?utf-8?B?bitwVjVyRC9KZGlBQ0hkYzMvL1pQVHkwMEl1MGlBbjFuN1lJS2JJbURwSEtK?=
 =?utf-8?B?UHNDckRZQ2ROOHQrV2NVMTVQWFB5ZjV4cHBvU1p3MGFFaWxaL3pDemVTTVh5?=
 =?utf-8?B?eEp5cXZvNk9VaXBTK3d2dm5FNld6alAxWms4anlyUHovSDVDb29oQkZrR1Y4?=
 =?utf-8?B?RzlmTWEzQzBUbU5jYjYyc2NNRmVLcjZ5YythOTl6ZVVxdEZGZDd1bHlqMStH?=
 =?utf-8?B?ZEdCbS9JTnhIYjNRd3loeUo3c1plV1FQVHI0R0U2b2tUVXJvaXZ3QXpndEMy?=
 =?utf-8?B?NDl5ZnVhSzBlMEFzei9NRjhJbENkYStiSVluUk9jUkpPclUzVmVYMTc2b0R0?=
 =?utf-8?B?NmJ6TmhoVXk0eTBtT3VUYjhUbFc4WUFNSXk4T3I1ZGhSd1U4T0daMjczUWVH?=
 =?utf-8?B?YU1MNW0yOW9ucTVKa0Fkek4zbWNEOG9GWGVEWlV6bU4xYlpUTk1sSXNOZGV5?=
 =?utf-8?B?eEJWM0diTkRvRlN5c3FiRE5ScFQyOUs3UXVHelNsMThGcXZrWm52MWxhL0ZQ?=
 =?utf-8?B?QjJkaFN3NC9xOXpqcW85UUhhME1sY2dLdS9nbTVwZFJMcW83RFplOTROb1Vn?=
 =?utf-8?B?SkMwRzBLSUxXbzh2empuRDU1THV2dHI5T094cVRLMHpyOXd1aVU3YVh1ZGp6?=
 =?utf-8?B?ays2UkpoU2VKOFFtemdiUkxoU2EyWnBxajhiMW9jcnUxdGtIQm9mS2I5ak1F?=
 =?utf-8?B?NWIvMWJDNzJwSGVHa2JTMmtyTDhJQ2RUVHRFTlRUNjFianhOdzk4U1NtckZy?=
 =?utf-8?B?Rkx3bmcrcEVwSU14ckcyNTlOVnVEUXFMSmNoYnV2ZENpVllSRVVFYTJtaC9p?=
 =?utf-8?B?Y1c0azhqYm1zQ2VVdWppaGFmWml0VVZkYU9nekhNeTdsQ25oRnA0YTllNjVC?=
 =?utf-8?B?WUZtNm9kSGVISHd6NlhqQWg2UjBRNitpUkFja1ZtZzR3ZDM3aHE0MFBKYzRE?=
 =?utf-8?B?cytLcUtSam4vS1l1NFdWa2locy9Bem44Q1JtM2xZZEJLTHNvLzdrdGM2TnZt?=
 =?utf-8?B?QVRTYXZXcGt0ZE9UTGt5ZHZST3ZhZkxjZDVSeEt0OFhnb2lkNWRzU2lKTEdl?=
 =?utf-8?B?N0pRMkpQR1J5NzRuL2YrRjB0WExFR0l5YUN6L0R5b0VobXNQa1lySXJydGxv?=
 =?utf-8?B?Z0c3R2dQaElLSU1SVHhNZjFNTzBGK0VpaWJxc2NoRnlTMWVjK1JOOG1qS1Q3?=
 =?utf-8?B?Y0pHZWczREZ5WXhmRWpkVzljTXpnVGtZN0EwT1Q1RTR5YnVTVWdtbHpKZEIw?=
 =?utf-8?B?QVZFY2hzV05hQjdjcTcyTkQrN2Jqa3lKQWZzYWxtNFVaU1p3b3FTMDBxYjky?=
 =?utf-8?B?c24yNkc5ZGF6cVBnaFpTTncrK21XZTFJeGczdXA1UlZhaTIvZmpHSmZ1MExt?=
 =?utf-8?B?WmU0bUgwaUx6RlU4ZnhhSjVKMkxvV2hTNStUVlBNY0d5L1pxMkZqcXFiWXhK?=
 =?utf-8?B?N2FnRGdzS0lvRWhleUZVY1h4YjhZUXR4Y0JBQkNIZlIyUFRkNHlpS29GRHNC?=
 =?utf-8?B?Zm5zMHZZZ3RjOWJ4RWJuVEF3TTh3UTkxUHFwUEM1T29Id2NXMTd2eXlmNTFX?=
 =?utf-8?B?V0tBb2NpWlFhVzlpR0laY1JzSlhReVNPbkdCeW0wWnNBTlFNQTBwR1pndjlx?=
 =?utf-8?B?U2pQSk1TTkppUEhTZXdVeVBZb1ZqSVMwMGsxbkgwOVFFT29PQmpLUGQzcG5R?=
 =?utf-8?B?dW8vbkV6RFpMckc2WVVLaXdqUWlVeS9FMkx4dUFXMVFlbGxSSTZmSlN4dlhI?=
 =?utf-8?B?cktTV3FibzNaZ3JoK05LZis3MTd5VGkxeWhqUnU2YWRWNDZId2dXZGpOVEFu?=
 =?utf-8?B?dENlQlB6TzNydUV5Vk5kb3lYK2ZiNExPdUxYZGJSMnZtS3FkaU9UZ2o0QTZj?=
 =?utf-8?B?MGgybWdnd1pPbzJ3czVhYmNibExoVU9XNkpjVWhHa2kzYW5ZNzVPK1F6Q2xX?=
 =?utf-8?Q?XYBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6931.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjRFY3RtYW5oNnR1dnBxWHJveDdXZFpjc0hrOWxWNVM4UHpVZmVCMjBxWUFq?=
 =?utf-8?B?K3p6V2xCVkx1V3NGKzE2U0w1UDJ2MTFTVmc0c2d6c2pJRzNOeTROdmllWWlt?=
 =?utf-8?B?ZE5oZDBYNk5nMDhSVTBRMUNDZVVBZmUzY2phV1ZIazhIWGcvK0NsU3p0MXdo?=
 =?utf-8?B?ZStBenJRWkJZdVhKY0k0NTlhbEtxRlpHQVhua3djT0dJNElhVktzVStKR2kr?=
 =?utf-8?B?WVN3WEhDS2xtVEZ6RlZ3NmNrbGdaRzNTRld2N0lNdXpTSktidWZJZkozQStJ?=
 =?utf-8?B?RWZVMjlod0hxK0hnbmlyWTNKUWVYeXNPYlVOR24xVUpWTW1mM09ZRUFjeTBB?=
 =?utf-8?B?TXNhOU4rNHcyYnlqSHdBK3NicW1rNmZXV1hXTDhTcEQ3OE1oOUxNdmVVcEQv?=
 =?utf-8?B?ekw3VVhtdGlaSUFCbVVqSzREeGRQMXRScjlOTGJtRlNHeG85YzZ2dTZiV3hY?=
 =?utf-8?B?eHRPZkNzQUJveWRId1pKVEhIMU5hUTI0ODFoVDhvT0lPNG5INGp4Zm95K3VP?=
 =?utf-8?B?LzlHUjFwK2NMbm5hMXV2OTY4dzRyQzg4enJTeDJLL2RiRk9CWDZNclJOcUxu?=
 =?utf-8?B?c0tSS3Y4RVlNS2ZHOUw2UlpvdGdtby96WG5ZMUszVnprdVVzeVg2TWU0WlBZ?=
 =?utf-8?B?SUU4cGFqK1c1dnFNT2t0Q3RiMVQzN3ZOYmRDQXc1UGJXRXJPRGhXSE4vZUVu?=
 =?utf-8?B?TEhsSHdOL05rNElnSmRqVmc1MWVLOFNCbUI2ZW9pTHVSbStSVTYyWE14SUkw?=
 =?utf-8?B?dllvLzM1bkhxR1lMNHVUU2p0TGVRcXgyRkxSZFBaOHlJbGFNTjZTSjFRbmNO?=
 =?utf-8?B?empybFhxdHYxS1lFT2ZzVWw2SERYdUpDTW5keTZGcHlPMENBV00yZ1dzYVFo?=
 =?utf-8?B?RWZzbmQrZGNacEowRnBTT2Z3cnI3UEpoV1cyQnRmT0NPMnUxNkxOdzVIc0JQ?=
 =?utf-8?B?c2REMC9jU2NJY0xBS3NudklSTHVUMGs1WngwMVpoTEVKOFB1b013SWQ1OXNy?=
 =?utf-8?B?Yzg0bmFsTlVjUnZWeUtMdWZML2FZVGxSek5wZ1BiOUlPWFlOZEM2NEZwVklk?=
 =?utf-8?B?Uy9UTTBYL2d1TktLY0wweGFEWHBUVjJrdHVFRWI0djhZTmJrdnVWMGNucVVu?=
 =?utf-8?B?YlcyQzBSNlFuN05jdThQcTRoeHhWTFJyNFdsM1hOQVF4eVo5TDh4dkpybkgx?=
 =?utf-8?B?MTNoRnlhNWxpOTVZaEttMlVzanozamZUQlVvb291QVN5bitnSDFBQzZwTlN5?=
 =?utf-8?B?c283NjZiMitlMEQ3TDAwaVQ0bk5JaW1SL3htSnVTZTl5V0pKWjhqTUZDcjFH?=
 =?utf-8?B?MmNLd3ZVVDd6NnRpNXB6bWdURWtaaW0zUDlMb2dEOW4xbER2Z2ExQktBeGhk?=
 =?utf-8?B?ejNMa1VqSW8xSHJSMGtWTmtvMnh6QzZxYnNNSHB3UEcyYXN5dXczUXkyWmRh?=
 =?utf-8?B?bHdHRzdmVFIwamR3dEpYMktCMVhhS2RpRTB2SDVKY2JoMXF5ejhXUzNhVWFF?=
 =?utf-8?B?UVlXSkQ5aVVZM1hGaFEyM1ZMa2x1dmVxR1g0dWdjd09uZHNNRFRJRXcvU1BE?=
 =?utf-8?B?VC85RFRLTkw3bUhoQ21ZaklxU3pBT1J4Tk9GSWNhUlRpM1JTQVlFdHhVc0FQ?=
 =?utf-8?B?eUp1a2dYWlBSb2dUOEFCSmV0S1BzT3dKRkpPUGY5ZHJCT2RnVUM5ajUwcy9J?=
 =?utf-8?B?UUtqc0M1Y3paSytkL2RlcHFqb093ZTdlTTZleFZGb1lwN2c1cVhMOURCbk9l?=
 =?utf-8?B?OFowR09vUVM0Z3lXaWRia3FQVndxWG5KLzFkaUt5cFFMLzIvdmtyaGRsdWly?=
 =?utf-8?B?NDZEMFNFaGhXQkNQYU9rMTB3T1VhVFJtUWUwMTJBWG80TmtVeGlMZEpiMXYx?=
 =?utf-8?B?YkpsR1Q4dUQrY2VXcHA2eHNkOFJuNDRGNno1U0lBQ3FOYUJUY3dDb2ovcmxy?=
 =?utf-8?B?UzE3aEh0NDFWM2IyQTl3dzFnMGI5SkIwTysvbUFZYzVWMzVYM0h2dE1sclNB?=
 =?utf-8?B?dlpKTlFjeTMvNXVxUjVrQ2l0eExQNGd6OEUzaXo3c1VoZXZPRytJZ3pWT0kr?=
 =?utf-8?B?SXFLVXlvYnhPMVR3RHF2R0lINFZiNDhMUXFoQWovZVlvT2M1S3NHd1p4MmJL?=
 =?utf-8?B?aDZlNDBraldBd2NSS1lzTStDNHA5dzkwbVZnS0E5UW1XSWJCVlpvS2V2REV5?=
 =?utf-8?B?eFU2TVMyemNDTXBlVXQ2OGtTbWk5TWlrTzlsRTRiZFcrM3pPc3pHMmxmNUV3?=
 =?utf-8?B?UkozS1JMQWJSelhhNUk3TTl3WlJpWUE1MWd5MVRGUlBjMWNRREpBaklEdlla?=
 =?utf-8?Q?9ySsDB9zeHWnbpwNCD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14664c27-ebf0-4e2d-397f-08de6e14a984
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:06:56.6290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKZmxkBgcbiSAefjYFR1gga6Z839KF+3OLnqU5Lpbq00GsTcAWDVqJOFCGrGT+F/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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



On 1/29/26 11:13, Michal Simek wrote:
> 
> 
> On 1/16/26 17:14, Sean Anderson wrote:
>> On 1/16/26 09:07, Marek Vasut wrote:
>>> On 1/16/26 9:19 AM, Michal Simek wrote:
>>>>
>>>>
>>>> On 1/6/26 23:17, Sean Anderson wrote:
>>>>> These registers may have been initialized by SPL/FSBL, but program them
>>>>> in case they have not. If they are left at their default values, the
>>>>> controller will never exit reset.
>>>>>
>>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>>>
>>>>> ---
>>>>>
>>>>>    drivers/usb/dwc3/dwc3-generic.c | 32 ++++++++++++++++++++++++++------
>>>>>    drivers/usb/dwc3/dwc3-generic.h |  2 ++
>>>>>    2 files changed, 28 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3- 
>>>>> generic.c
>>>>> index c09014aec60..ce896db9532 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>> @@ -501,6 +501,27 @@ struct dwc3_glue_ops rk_ops = {
>>>>>        .glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
>>>>>    };
>>>>> +void dwc3_xlnx_glue_configure(struct udevice *dev, int index,
>>>>> +                  enum usb_dr_mode mode)
>>>>> +{
>>>>> +/* USB glue registers */
>>>>> +#define USB3_FPD_PIPE_CLK    0x7c
>>>>> +#define USB3_FPD_POWER_PRSNT    0x80
>>>>> +    struct dwc3_glue_data *glue = dev_get_plat(dev);
>>>>> +    void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
>>>>> +
>>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>>> +        writel(0, base + USB3_FPD_PIPE_CLK);
>>>>> +        writel(1, base + USB3_FPD_POWER_PRSNT);
>>>>> +    } else {
>>>>> +        writel(1, base + USB3_FPD_PIPE_CLK);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +struct dwc3_glue_ops xlnx_ops = {
>>>>> +    .glue_configure = dwc3_xlnx_glue_configure,
>>>>> +};
>>>>> +
>>>>>    static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>>>>    {
>>>>>        const char *name = ofnode_get_name(node);
>>>>> @@ -621,11 +642,10 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>>        struct udevice *child = NULL;
>>>>>        int index = 0;
>>>>>        int ret;
>>>>> -    struct phy phy;
>>>>> -    ret = generic_phy_get_by_name(dev, "usb3-phy", &phy);
>>>>> +    ret = generic_phy_get_by_name(dev, "usb3-phy", &glue->phy);
>>>>>        if (!ret) {
>>>>> -        ret = generic_phy_init(&phy);
>>>>> +        ret = generic_phy_init(&glue->phy);
>>>>>            if (ret)
>>>>>                return ret;
>>>>>        } else if (ret != -ENOENT && ret != -ENODATA) {
>>>>> @@ -643,8 +663,8 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>>        if (ret)
>>>>>            return ret;
>>>>> -    if (generic_phy_valid(&phy)) {
>>>>> -        ret = generic_phy_power_on(&phy);
>>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>>> +        ret = generic_phy_power_on(&glue->phy);
>>>>>            if (ret)
>>>>>                return ret;
>>>>>        }
>>>>> @@ -690,7 +710,7 @@ int dwc3_glue_remove(struct udevice *dev)
>>>>>    }
>>>>>    static const struct udevice_id dwc3_glue_ids[] = {
>>>>> -    { .compatible = "xlnx,zynqmp-dwc3" },
>>>>> +    { .compatible = "xlnx,zynqmp-dwc3", .data = (ulong)&xlnx_ops },
>>>>>        { .compatible = "xlnx,versal-dwc3" },
>>>>>        { .compatible = "ti,keystone-dwc3"},
>>>>>        { .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3- 
>>>>> generic.h
>>>>> index 40902c8923f..13f6391cae8 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-generic.h
>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.h
>>>>> @@ -10,12 +10,14 @@
>>>>>    #define __DRIVERS_USB_DWC3_GENERIC_H
>>>>>    #include <clk.h>
>>>>> +#include <generic-phy.h>
>>>>>    #include <reset.h>
>>>>>    #include <dwc3-uboot.h>
>>>>>    struct dwc3_glue_data {
>>>>>        struct clk_bulk        clks;
>>>>>        struct reset_ctl_bulk    resets;
>>>>> +    struct phy phy;
>>>>>        fdt_addr_t regs;
>>>>>        fdt_size_t size;
>>>>>    };
>>>>
>>>> I will let Marek to handle this. From my perspective we should take Jerome's 
>>>> patchset to update usb stack and then add this on the top.
>>> Since this fixes a real bug and is isolated to xilinx platform, it would be 
>>> good if xilinx at least provided feedback on this patch.
>>>
>>> +CC Ilias
>>
>> It's not a bug fix (hence no fixes tag). See [1,2] for details.
>>
> 
> Please hold on this patch. I got information that we see some issues on one 
> board when this patch is applied.
> We will get back to you.

ok. No problem from our side.

M
