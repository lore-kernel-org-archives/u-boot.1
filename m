Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27D8C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 05:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D66E888CC;
	Fri,  9 Aug 2024 07:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLcW+96W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115C9888E4; Fri,  9 Aug 2024 07:41:50 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701028789F
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 07:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9fxdstTbwoyE2UQYB3z1TEIaCwuCF3dN3v2eWWd85evWjt0+iGVI05RMrMx463q6KgfFC5/DVbAUHtYTod2Y/5GYpjnq/Px7MctMGkrb8WixlFbgJSqNMkcNwFp+6qKd5uojesaoHPnTNoEP1rFnHrFfGC/EbNeGDBdLEhqWlPsP/MnSm303oT9I7DpKf8UPGrrANx7P27ovCjV5tucyGMwLv83EmPmOH5YBMtCjTHhyBFHVpVeW6smy810uTX6OrOKI925tAna4YpXmnGCiMMjzsy8w8317JlJROJYcUIdwDt9yfpvjR2RHsSB5OjTRRA6ugjK9JI/GSbJxNSWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WatJIkgbIwIZb4tIytPCXgUOvG7iz+5SlmPiiBicCRo=;
 b=bnvglrV9PHgfGMwmVPLjha8DXW43NRjFPzCjBV2WRTjHiQuTwKqQQZsKf3ridKEJCuJlEswAcYrlYXJULIH5rLkpRLfHwbGQuPRoy+6VhsDViHvZ49DQQz9h+UzFFsDuGTcyVkmM7K/GNouy7kGtnJtaMiee11xrHNSQGStcEzIHXnxYADm0ngZQ8vmqsfupykvL9mGkvQFP7iFTGUmk3t67F9pqQpQKwG+udlC02KO9QMXkYF0Cg7fcv172t7hknwL/zsdCOhXMoExYYAV9ZKmN6VlZCWT7QkcAUbZfzWoblYHIQQcHMyxaiQlcHbQU0iMR849O5DtdUv0lt5I41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WatJIkgbIwIZb4tIytPCXgUOvG7iz+5SlmPiiBicCRo=;
 b=xLcW+96W4pSaU1rKcGkUp8FDwQtVOGWCe9IdX6bZwEsAo493EB/zGMCFGXMToUnT3pRH2BJ6kljimEoyNWqli8y5W5PkigiFwppY3qhXPOV4svhM7DYXhx7YHLT6pqesTrRm9hpCdJ7F6heyeFjrLX+3NxGeI+Vmx6SJxo352HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 05:41:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 05:41:35 +0000
Message-ID: <560fd4ac-63be-474a-89c5-00e365a0c70e@amd.com>
Date: Fri, 9 Aug 2024 07:41:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com,
 venkatesh.abbarapu@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com, Simon Glass <sjg@chromium.org>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <20240807211221.GK1626301@bill-the-cat>
 <e62e3c69-e9c4-4a0a-bf65-c21082ce7e27@amd.com>
 <CADg8p95DQvRAXdon_Hx+mYst-u9HTfprQ=6jwgSQThWX=GDSZg@mail.gmail.com>
 <6e5c61cc-5d90-4d2d-bcb2-d854bdb0db1f@amd.com>
 <20240808154658.GN1626301@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240808154658.GN1626301@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0060.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e071807-04f5-4b17-bc9b-08dcb835ee76
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2VNekpieElMOXZmVVJ3b0dRdTh4Sm5DMm91VUMrUWNJWlFzcGtuNDRKNWxW?=
 =?utf-8?B?S3ZGUnorM0NjRml6cWtiblRVNlNOQWdFSTNId09xd0ZVTXlOekVXTE1UQTdo?=
 =?utf-8?B?TGJrU1YvdGk3bzRTaE5JeVZ5MEFhMVA0OG12WmZQWUNJcEQvSjVuTW5tMkZV?=
 =?utf-8?B?cllYTjRNZ1RzcEIzcTU3ZStveTM2U2NUMlBWMnpBOVVuTmI3UVp2VUlRZHVB?=
 =?utf-8?B?VnUzcnExZWloQ2I2LzhMSGYzNDFUbWVZMlZjaXBUcFRGMTVVTWplREtyZVh0?=
 =?utf-8?B?MUEvbXRNWjB6WW1hT25XK096RnJhY25lSzRjRFkwOWtrclI5dVR2dXlhaUtq?=
 =?utf-8?B?ZEhBOWdGT2dxR3UxeUNqaytlTzVEQ0wzdkdMYitwTGJ2UjdseHlxRUFpZXlE?=
 =?utf-8?B?Qm9qK0tuWUNZY1hXc2E5YlkzZmNtemhJZWhKdURPZE5Zd21Ud1htZythekNJ?=
 =?utf-8?B?dStQRmsyMWkwR2c2bXV1K3ZNa3lhSkhqYjVsbGo1TTlhckpZV0hJRHV2cUIr?=
 =?utf-8?B?UkpxNEp6TWxrZGMvaVNVOEJMRmhkRVZ0cmVyay9ZTEEvU1FRaEovbTh2eUND?=
 =?utf-8?B?eGg4N0k1aEJaN3NnNXJTTmFCWDBEaVhaMGRKeW9TR2JLalZDQnhGOHRNOHpa?=
 =?utf-8?B?Z0tUelBIeHQwTnJQWFUrS0RqamkxTS9lYUJLUkJJTDZzcXR4L1Q5cVErU1lI?=
 =?utf-8?B?SW1WYXo0ZEV5bS9IVnk5WjdjeW5BT0VKUkdKUmJMbDE2bG03T2FXWFg3bWdW?=
 =?utf-8?B?bTJNTjhPNDZUOHB6bTJ6TUlGaXZaNS9vaG9SUWtpWFV1a29IcXQ0Y3Y4UWRT?=
 =?utf-8?B?ZUNCU0RhMEtqNVZQVlBtOEJ6SCtiUHU2TjhOQmlmZjQ1U0twSSs3TmRlZUNy?=
 =?utf-8?B?ai9HbkZWT25zYlo3L2c1YW01eUlUOEpCL3hlWmxGcWxnQlNzNm1PdDdBc0Y1?=
 =?utf-8?B?Z2trNGI0ZW4yenVCc1RMUkkySERNbjJpOWRlUCtOQWoxSkQzM3d2V3VVZ0xD?=
 =?utf-8?B?Yy9UbjRaSStQSWJLdHczWmRJc3BIRjRka1pjd0NnWEYrNEdlVTRjNjExVG5Y?=
 =?utf-8?B?T0tzSDBHRWwxKy9rWjdjbi9qN1VJdDlVL3NSVVg1Rm9ON3ROR2pOSTZjVHVa?=
 =?utf-8?B?U3dtNGk2WDdPeE4zZ2QrbmFZa0ttSzFXUjFVWEVBejhyc25NdGpEYUVJSHFN?=
 =?utf-8?B?elBBNFRuNDUwSXdUeFZUWGJlWERzakxBWHVCL2I3UUxTWUdVbkFGbnZPK2tk?=
 =?utf-8?B?MTZpU0o4NUloYTVseDZMM3NPSGZ1RGp3bHE3dUNQQ29PRkhORUhXaUJRYzlH?=
 =?utf-8?B?R2RDQk1kQ2l0ODkweElGVmNCclRTb1MzRkhNRG9iTjdSRzV2eFZkV2tOZ0VY?=
 =?utf-8?B?ckt3aUFUYTNHRUg0ZVhUQVB5cFRBaFp2b2hWUlF0N2xHVnlSOUxLeFU3WnFV?=
 =?utf-8?B?ZXI2YW9GUWI5ZTFUak0xUG5tYjB1UUdhRkhsaGdtcGRMVjlSQUVDczNTcmYy?=
 =?utf-8?B?djJTckJEZzZiN1cwcjJlVDZYZ1BzakhrVGRST1VIL1g0b2tsWHFxVkcvT2xV?=
 =?utf-8?B?UWJRcjFWRDVQalMvVW5vRGxic2Vsbjd5UitxUjdqeUZiU05TOFFSVVRjclgw?=
 =?utf-8?B?WU1yZ0U3Yk01azVwUkFKdVFQLy91ZlNTeGt5YW9mUG5WcGlCMnVyY0MxQTRK?=
 =?utf-8?B?QjlIeXU5MG16bnJNcVJpSDlqRXpEdHdJNmQzSW85MFFpZVVHdkpNQXVCdUN2?=
 =?utf-8?B?L3hHc2tidkNzQW1ydlJEY2VIcXcvbFBhUTYxSGNWVzRTVlhmY3crQ0pHRzlE?=
 =?utf-8?B?bjM2aW44cFlOM0JkKzN4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckRSU1F6aUtxWVpzUUNtOHpLUm4zUEJsNmZFREtvQWVNdGFBelNXdDF0Vnlk?=
 =?utf-8?B?L2NUNmM1Skx1Y1kvV2E3YlFKSko0L0Jrb1NGSi9LazVjNGJUZ0xCS25TTG9a?=
 =?utf-8?B?UlpuVk1DOWVvOEtqemQ1ZzVDRURMcmhhblNUNDh1UFlCTUEvbEtLQzk3NktF?=
 =?utf-8?B?c3E1cWhKOTdabEJKREpHa04rMUorMUFJclFGOXo0cmcrdFk5S3JZaDhQYkpk?=
 =?utf-8?B?SU9vWTFvcGJpKzh6SU1jSzZ1bjE3Rll1bGR0VFN1eUpaQ29EWFZHZ2FqdEZK?=
 =?utf-8?B?bW5vdWk1bzNpeHN0SUQwd3VmVHVsQUxIdTgxMjFHcnkyUlpVeDlnY1RwZjVN?=
 =?utf-8?B?Qk5LaE5DcW5kc0N1SUxvUDdxVWFPNUFNeWgwaVgwUExXd2I2d2VoYUlqMXN0?=
 =?utf-8?B?VGNxOURCeVVGU2MyWDdKa2NLRXhwK00ybExNd2UxeVgrMEEweTNlcEZsMmpj?=
 =?utf-8?B?TGY1dTN4RFcvUTVHU21ZbFJuR1diNG5kSHlPem9Pb3hWbWR3NUVkZUFOLzlI?=
 =?utf-8?B?b1I3WXNoZnlDSjN1aHRqa3RseFZIVUJkUVE0ZmJacE9tRnJBK205RExuRzRV?=
 =?utf-8?B?RDF5bVBGcEpvUUVLeGJWdHhkNjc5UjBjVUx6RnowVFZNRzlBMG44STFZRGY4?=
 =?utf-8?B?TEhRN05JOHB3OTFBL2pJcFR4a3I4MXJuUExSTHlObXBDVm1tb214dVE1aFJ4?=
 =?utf-8?B?Y3RNTUtGTEkvaVFMWjZ1RTR2SnlmN2dOcVZWYytNZEc5RFBTcTJML2IrblNE?=
 =?utf-8?B?U3Z3THJHdGl0Nk9LdlpLTjJqbFRGclVBbFNhbGdEWm1nelQzWUdXNWZHN2lT?=
 =?utf-8?B?MXFGdXVxTlQ2a3NGdmlXMmkzMlhqeTUwbC9aWGlqVGptV1k2VkYzc1AreFE4?=
 =?utf-8?B?THl1ZWdQT1J4cUkyaE43a2ZwMlFQa00yRXgrMWQ2aE5kZ2crb3JaSjV0ZTRu?=
 =?utf-8?B?cmlKWmVPWUp5VHNkeXBwbVQzc1U3TzJ6aC9mOG1oWlErWFZqOUV3cUoxV2pj?=
 =?utf-8?B?VzNKeDUxQlh6TFNtc3V0YzRONlVRclFEQUlhMzNUcnY3bXBtZ3FlVXkzQlBC?=
 =?utf-8?B?dGZPOGxtY2NEOHhqdUdpcHFWZmwzalNzdVJqS3VVblV5c0wxQmNKSDNtaERk?=
 =?utf-8?B?UHFXZzZpSUZGbVJkWWZxait6S3ZJQzNJN0pCNFF4cG02YzhVMFlXK3hiV1VB?=
 =?utf-8?B?VWlEY3lYQ3VUR0k1eE0yWWJPMGZnNmZLaWZGL0hUMjdnbTZYWS9mTkVSb3Bh?=
 =?utf-8?B?S1lvS080dVpzNHJMaVlDQWtYYzVwZzVKeHZhTW1LeTIxM3puam8zcDlFNUc0?=
 =?utf-8?B?amt1TUdEbk9iN09pMXlUS3cwOWRITGgwVWo1RHAwUG9IS0hKa2ErZHpQZkFS?=
 =?utf-8?B?WUZnVTVabEUzOVJpdGdxM3ZjenplcjMreWkzcjgrREFLSXljZ2NyWHdvKzk1?=
 =?utf-8?B?cjh3RDYvdnk4VDJNWmFDNkNsWTZpRUVHSC9ScVRKNGZpbkF6SmxYOTdqUEd0?=
 =?utf-8?B?dmx4OFVraGVUZzhESlh2UVZ5d1pKZnRXblJqajQ3eG4wUjVlK21OOEozank2?=
 =?utf-8?B?S084dVRHZWtaOVFjeW9xc2lPWTJjckRrdWpMNzUyNUozRTZ2MGg4RnA4MDBZ?=
 =?utf-8?B?TTdIRkc2dGFJc29KMS9vNW5jNzNta2ljOGlJQW5mckVydEQrS2xkYmhBNFla?=
 =?utf-8?B?b3ozWG1oUklJeDYxaVhZSG5KZlljc0JOMVBGWExIL2E5Z2NyRkZtd1J5aHpl?=
 =?utf-8?B?L3QrNk1oMC82NVhZaXJKTU9kckgyNFFHOC9aRHhxNTdheXlySU5RVElsWUtE?=
 =?utf-8?B?MDZyWkxua0pPTTJ5aDBFL0tVNWRmZXRIMXZ4Qk9vTkt1aHVxdlJRczVzSWhS?=
 =?utf-8?B?azFRTEJtbURJVUhJZW5waXppWUZrK3FUVnpnZ1EzRWtuV3hPYmE2UTVISCtk?=
 =?utf-8?B?M256Ny9hT3ZWMHoxQWlIbFE2RE9SYmsyM2U3N1JBREttSis2T280NmdIVWxK?=
 =?utf-8?B?aGgzZzl6UDNma1dyeTZ2WmF3dFErbkZIZ0ZxRlpDK2kvZnFqWmFlYVhFQkpN?=
 =?utf-8?B?SUlId21ZS3BZQ21HM0x1QmV1YUhYRGtqY2lTQlgwQjJweW1PVXNRM0RQKzR6?=
 =?utf-8?Q?wmCV9PTS37zFRQ2buBf1+jyHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e071807-04f5-4b17-bc9b-08dcb835ee76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:41:35.5556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlzdHnSdVdSefZEzikraRHR7aJJI3uxn4HzN37ZkTyFM4ddAc4y5CjKPLVtlEor8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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

Hi Tom,

On 8/8/24 17:46, Tom Rini wrote:
> On Thu, Aug 08, 2024 at 01:18:44PM +0200, Michal Simek wrote:
>>
>>
>> On 8/8/24 08:22, Sughosh Ganu wrote:
>>> On Thu, 8 Aug 2024 at 11:05, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/7/24 23:12, Tom Rini wrote:
>>>>> On Tue, Aug 06, 2024 at 05:37:00PM +0530, Prasad Kummari wrote:
>>>>>
>>>>>> Added LMB API to prevent SF command from overwriting reserved
>>>>>> memory areas. The current SPI code does not use LMB APIs for
>>>>>> loading data into memory addresses. To resolve this, LMB APIs
>>>>>> were added to check the load address of an SF command and ensure it
>>>>>> does not overwrite reserved memory addresses. Similar checks are
>>>>>> used in TFTP, serial load, and boot code to prevent overwriting
>>>>>> reserved memory.
>>>>>>
>>>>>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>>>>>
>>>>> This is a much more generic issue that should be looked in to with the
>>>>> LMB rewrite that Sughosh is working on.
>>>>
>>>> yes. And is it going to be the part of his series?
>>>> I expect that if he accepts this will be done on the top of it and there is
>>>> likely no reason to wait.
>>>
>>> This change would be needed, but in a different form. The patch, since
>>> based on the current master branch, is assuming a local lmb memory
>>> map. My series is doing away with that, and so we will no longer have
>>> the lmb_init_and_reserve() API, for example. I would suggest that the
>>> patch be put out either on top of my patches, or ideally, once the lmb
>>> patches get merged.
>>
>> I care that we can't overwrite reserved memory by any of load commands.
>> Better to be fixed earlier rather than later but up to Tom to decide.
>>  From my perspective this is incorrect behavior which is fixing issue and
>> likely this can go to 2024.10 version.
>> Your LMB series is likely going to target 2025.01.
> 
> So, from my point of view, this is a longstanding issue that I get why
> people are concerned, but I think it's missing a bigger point. For
> network loads, OK, no one needs physical access to do something
> malicious, so yes, it's important we check there every time. For
> filesystem loads? There's far far too many production devices using SD
> cards, so yes, a malicious actor needs physical access, but not much.
> For flash (SPI or NAND), at that point why doesn't the malicious actor
> just use "mw" instead? The device is in their position if they're able
> to hook up probes/etc.
> 
> So my current thought process is that yes, fixing SPI and NAND and all
> of the other forms of reading (outside of "cp") need to be fixed, as a
> follow-up series to what Sughosh is doing. And then reminding people
> that CMD_MEMORY is dangerous and perhaps think about splitting mw/etc
> out from "cmp/base/loop" so that CMD_MEMORY can be disabled for boards
> that want a more secure feel.

Pretty much new Kconfig option for production system should disable it.

> 
> I'm open to being convinced I'm wrong and this is a serious problem to
> address now, not later, however.

I have no problem with it if all of these go to 2025.01 version.

Thanks,
Michal





