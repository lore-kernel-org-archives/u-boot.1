Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783BDD2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 10:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61D683A3B;
	Tue, 20 Jan 2026 11:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PI2ih7Ky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D2183A3B; Tue, 20 Jan 2026 11:11:48 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA1783A2D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 11:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfshHMjazqBjBhJLm7ZsO4cR7eXAFzQxELt89AIHvRJXjIRwIGEWvr6LM7PnJvhBG4WJ7S19INPOCtlHyGrU3NiTXGDszlVRIKhnF2c6wozuGXcXSoW9JuI5zCseF+pfdzi5Tp6vVVd1EbcPN18vucZfxc4s9o+op8N62+thcl0NfIPLmcnykpA12zmzz65kViyZjMjn/FuHOtXBlrOLWspJUmPoXjp9p0Ev4f8PdUHDK60Jt8/pnXSvH4+fvd867tkLqAxzxJ0HJ2/cXe9P1VRVyeYZ/Ds5vBZaU+1mNpNKVEwy1QZSMORuxenR4ptY07cCNzhQsyO7dKrZsHRc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTjoWII2qG1kZDyGfLj7S3PZD2XqWbvkPuCvlvTZ0hk=;
 b=dI4JY7KA9ayyOmfB0H5ZhFusHPtuTy845FvYvbvSn2YCFFP9xSnS3s231iDs/6wMd+tFPaIAGEum+P8ppPzOYaqZZ+Y5Pc48Nuptd5Kha/rJYKSLpOHJEwtZu7aaABmeW+ZLzUd4qoPd+JoCZ6ex+nt8p0P4EYhkdZzeCtvyT6Vn8OujeWRtBLD4BfOG73i8AalpgM83oeKxE6pAVhVBGvy6DUaMr+W3my25ktKmaoUEbWlTe+7zlaWhedui3pKoeTtRiRQ5/vkmZHF8yHssFbOAOGF2JP4RcW4FVyicZ6JX3bkpbDQrHabXMlP9SXGeefD1iVcfp4dFctLGYrGn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTjoWII2qG1kZDyGfLj7S3PZD2XqWbvkPuCvlvTZ0hk=;
 b=PI2ih7KyvFd/MPA0LyKDWuGa+nEwqq4f7CgGw2EXRAR9bRcnQnzSTIlNvPkwwEtaHkMMiTCbZu0V+0rWTUCDsrE1ywyuxeoRDNU19zlxScn1IM5vbNfhTEKW0ZSQEglQhB98Q6PZitIPvGZNVf5s7AK8xzH9N1jhjP6YitrEmmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB8396.eurprd04.prod.outlook.com (2603:10a6:10:24a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 20 Jan
 2026 10:10:18 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 10:10:18 +0000
Message-ID: <1f31b62c-6e54-4dc9-a5e0-1f9c4cc6f5e7@cherry.de>
Date: Tue, 20 Jan 2026 11:10:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mtd: mtdpart: fix partitions searching
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Kever Yang
 <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119223305.3022690-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119223305.3022690-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: ae066939-5c20-4872-75d6-08de580c1cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uy95MENqQXJZRUtOWGt1bk5iSG5rbWxVcHBIdjBnTUdlRXByRTd0WEpFUjdM?=
 =?utf-8?B?MEFZVVAzZlpIMHQxNjBvdnRBbmpjeWp6R3IxK3ViK0M1YnN6bmpxQ2gzTmYw?=
 =?utf-8?B?dXRDMEFqSU9TanhmSmh0ZUh4bGtpMHJ1dVdRdkdrWjdGTUdlQ1VSUUdGV1JR?=
 =?utf-8?B?dVZnZi9RdThEbXQ5WGhDNVJUQVNFbWFYdk1oUVB2RmxUUW5VbEhvd0cwZFBM?=
 =?utf-8?B?SFNEWjBlYUNVc2NMdjZlWWVkQ2Q0Z1g1VkZJbFZ2aElkaldzT1QwNEF2MXhG?=
 =?utf-8?B?eStqaldzbGFkNU5IaGMyZFNCUEE5QXlIdlMwQmdUY0l5bytpS2o4aEpKc0pv?=
 =?utf-8?B?QXZKbGtZRWlBeE9FNTg4K2pHTmhUbFV3OWRjVkNEanJJeDQ5ZzJ6SnVLSnB2?=
 =?utf-8?B?TDVtVTB4bElscXVob2dqM2NFbEZsL3Z1ZjB6YzlhMGVON1hCZGlxWEpxczlE?=
 =?utf-8?B?QXNkQVB2WmNWUnhVYkY3OTlyM2tlM2lCUk5rSldPelBVL0ZTSzRYMThKcHRZ?=
 =?utf-8?B?ZEhpWkI3MzlOaEg0eU5lSUVuOFRHZ2ZwZHh4T0hqbzh2SHRZUUhCT3dDcElJ?=
 =?utf-8?B?Y3FIVXNVVHNCSXZYVzJLWmNRYlNzTUxSSGNodEVSWElTK0cwVm1hT3h3YzFK?=
 =?utf-8?B?OVpHczJXVmJodmdWR1VIWTcyWUNiL3FXVk55VXlFMm96dFJBT3ZBWmxWR25j?=
 =?utf-8?B?UytudWluYkFUc1N4aEdMNm5SRkllQVJ3bVAyajJxdFpld0c4c3p4VWY1bnZ4?=
 =?utf-8?B?SnVoY0lldVV2MXMybU1SaFByNGU3bXVuc1pMN1hUTklvdmhoZWF0WEQ0OCtR?=
 =?utf-8?B?MnRCaVUxWm94SjA1RVBPWW9DYW5WMDYrMVBZb3NrcEZCUDRtMlRNZ1pZc2tp?=
 =?utf-8?B?TnROVlJ4SG1oODlYeTBhbHljSXJ3d05BUXFraHRKZjArM2M3U0dOSHAwdXEr?=
 =?utf-8?B?ZzFjUDMrTHA3M2Z0SHh1TnhTMzU1ZkZZS3lGRFlRU25MZzFkalRNWllTRTF4?=
 =?utf-8?B?cmJSVUI0elcrUDdZS3I0dnRmQ01BamdRemM2QzBEMmFhZi9YUEZmdmF1a2tZ?=
 =?utf-8?B?c1ljb3JsdVp6aTY4YloyVjhxUG94WHhXTllaSStUazBUZWVXOVBrdE9hNUVm?=
 =?utf-8?B?MU4rQTZIMVVrRXdjWXdycm9mby9rNStuQlF4NUNsZ2xmQnNOb0E0eUhDWFdU?=
 =?utf-8?B?SUtRY2xxaS9PSFN4ejc0SHJkUGtlZkcyRmhiQW5oVWdMak1KUUp6Z0ZQK25G?=
 =?utf-8?B?Rkw5ZDUwdTM1Z3JacUZiRHl0MzRGc3ZRYS9FWHAvNzlwVk1uQmdVdmExRzRT?=
 =?utf-8?B?clhjbGlwU3RBS2N6eG5qNnh4clAvZjJ6NnZNdW5PNTdzMyt4S1BpcnQ1dTY1?=
 =?utf-8?B?L2ROUjFnbkpCSC9OVVIxTGQxcWRIS3ZCald6SStrbUF5UFRvTmxDYXd2a1Ft?=
 =?utf-8?B?Qll3TGEzSVVEaHlLZXY1a05TSFFmb1NFZnNLZlRNRWdUajNld3k4TStpZmtS?=
 =?utf-8?B?N2l6SmFLaStUWCt3eWFSb05QWDl5OTNnN2ZoZXkxSVVocjQzRVM2L05DeW4r?=
 =?utf-8?B?NkxwUkwyWDh6c0xIUVhac1hJVGJYTnBxRmFUSnpNVkRPajljN1Z5MU5vTjdM?=
 =?utf-8?B?T0VHZU1FUUVGQXZIRHRqeTV0eWhwazNYVG4yOC9SbWtINVovOGQyVkxicE1h?=
 =?utf-8?B?SzFMQk0zQ3NEd2Z2bmtodXFucXdXengyckZXQTUvMCtRNGQveGpjRXlsT2ZM?=
 =?utf-8?B?TkpLcnhlQkJtZlRqTGdYUUN2NFcvb1VteHd1TE1UZko4c1BHekg2V0UzWUxC?=
 =?utf-8?B?KzNRZW4vcXhxZEZKWFZwcDlER294YXVRWmFMbTNpU090R1F0ajcwM3ZDaXMx?=
 =?utf-8?B?aTNXV0hhakR3NlhwUDZrd1E3VlRuTUxZMG5tMWNGS09sajlMMktjVTNrZUd0?=
 =?utf-8?B?TnlHUkIyMW5rMHVmT3I3K1dwMk5hWkVyaU9GL0dVQkhWbytIZ2dMa0NoYjQz?=
 =?utf-8?B?VTJFY2tlU3l1czBMdUVYL0Q3Szk3ZDRST1lFTWx1WU5kZmdqcnhjYys5NkdK?=
 =?utf-8?B?MVZkQ3g1cjBPZUZKSzhHWjYrRCt6bmpYNUVPQUNRU3dlT1RycWFmbmcyU0ND?=
 =?utf-8?B?U2hXRytJNW8xUFNFaVUyK08wOVJheDFZNFJ4YWFuSzF4V0ZxcnpMUXVnQnBQ?=
 =?utf-8?B?V2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7416014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdtSk9MK3ZaR2N1b1FOaEd4dnEvWGxTYi9uU01wUFpHNVlIM09xVklyU0Mx?=
 =?utf-8?B?ZERLUlF3YzEzYXJkMFNZMW4yN2JKVGh5N0F2YTBpM2pJV2lMNU0xczF6bmg1?=
 =?utf-8?B?V016bTI0SStSUTZ4REVCZHJqMlRWeE8xT0xjWFpZSHlrT3hRSFJQUVAzczFl?=
 =?utf-8?B?T1pySks5TWFZclJjL3p6MC9QaXM3cW9iYUM0VUlaTWtsVmdmSkpwS0dFbk1o?=
 =?utf-8?B?TEUyNktDMEFsdzVxR2hWWDBnQXhCQVg5ZTZicllRWHh0UlVxT0FyVithNWdJ?=
 =?utf-8?B?VnRTWTFMd0QwditZQ093bHZuR3A2by9nWVpZNmU5b1FaZGVveDVya1hiV0Rj?=
 =?utf-8?B?cm9mZ0NXZWIydTJIMkJmaTFwUXZ1UmNjenFkeTNFMjhGT1l2Vjk3VC9IOXQv?=
 =?utf-8?B?WFBBNFRLYW5ZNWVQMUtxSlBIZnRJWnMvSnQvRmZCcENUQW5KMjlONXpWd3Vk?=
 =?utf-8?B?THVzS2xFZ21zQWM0YVdiVHhjak8zM3duek51MWFxUWt4a0huK0pRajQ0elZi?=
 =?utf-8?B?Q2ZSbzNFMnNxeWRrbHl4VjI0bDNrL21pV2o4QmtpMUZqaVFFcy8rTlV6VUhx?=
 =?utf-8?B?emRJMUY4c09aUExpVjNJOGQyWW54bFJoMUE4WXdML1JtM3hEUmFpc3BhZEpJ?=
 =?utf-8?B?UEJEVVUza3VNeFB6Y0NqOEYrVmltK1BmOS9zL1ZsVG1iekRaWEZQSUFpQ1Rm?=
 =?utf-8?B?MzFSbG1KN0lOL1dNNFl4eGVzejlEUWJVbFNxZ2I0Zkl0WkpJa2xia0ZYOWhJ?=
 =?utf-8?B?UHArVldlZXdyb0hLd1JQTnZkSVc1eVNadGkvbnlrL0s3bVJPTURMallLZWxS?=
 =?utf-8?B?TEFYVmpLdWIvQ0U0b3gwcnNBMGhFcHMybG5rNnlvZmJxM1J5aUtyV2h4TnBN?=
 =?utf-8?B?TU9tMGd1ME9IczdpYW84RnpUaVBzdmJaSjhFTUpUNDQ4ZHl1OWxXZWhrS2hm?=
 =?utf-8?B?UlJFOWJ0eFFjWkZYaHNDQmlxeUdvZExoV0NMbWkzTC9DcnBNR0FCcFBtN1k1?=
 =?utf-8?B?MWlHMFl3MnE4UXFicitKMVdCOFNFbTd0OEJPYnFxY0RsejIxOHZ4NUpkbHRB?=
 =?utf-8?B?VmFtRWNYVmFGOGgySE9CbU1LcWVCYlVIbnpMMC90cWNZc1hUdVEwSU5WdUtl?=
 =?utf-8?B?U2s2WGg1VW9vVGN5L1Z4QWRvclhwSk9TMm1BOTcxSkhQQzB2d3hxQmtJbWwy?=
 =?utf-8?B?QjFiUW51ZlFMa09EZk4xeGluTDlFVUxYMC94UkZ2UyszRXYxWWI2YzJUUVFF?=
 =?utf-8?B?VTNXbExOSDhRRW84cmJ5M3JyYlZtaHpZdVlQNEJ4YkJnR3RTZ3NNeXhYSitP?=
 =?utf-8?B?TlA5WnFtYUlyN05IeVhrUE1QcVoyUEVDQkMzTHhrZDl1Wms5dGo0RHBqby9x?=
 =?utf-8?B?VWVBSHdUUjB4OWd5amViamx6ZzRJNStRZytQY2FWdlMvMCtOUmV1QzIxaG9S?=
 =?utf-8?B?OXduVlNLUjdRclpES2JVZ2dLU1VlVVBKTVdPaVVGSEVPOUgzakhlanRpMnJs?=
 =?utf-8?B?c0IzTndhNW9IbVU3RDlRcjlaMTI4NzhMdXlkRi9mbTdjYThQNElOS0lhQVFH?=
 =?utf-8?B?c1laYWVzb3JIUzlNa0FVb0ozbE03eitXL2ROeU94ZzRsaGRoeTgrOXl3UGl6?=
 =?utf-8?B?R1F6NkZZWkRSMVphSkxQc3FRVW1mdXMwaWZkTzhSYVFtWFFZdkdDeTlIRm9l?=
 =?utf-8?B?bmo5bWZIbHFieXBtWmduYnNMUTNtZ3c1NjZUSkdiY3NydnRpdGtRNlM5UnZC?=
 =?utf-8?B?RkM4Z0pIN0VrQmxkUVBNSzgvWklyV3ozd3lMSHdxRFpTYkdyTXpzWVA5S0Q4?=
 =?utf-8?B?L3QwZ29tMkhnUGNNWEVDN3ZKbkl3N0pVdHFnSmFkN0xKWlB0NmlzcllYeU53?=
 =?utf-8?B?aDFqMDhYT3hxYVJ5SVlDb3JrSzAzT3RoeEltUWJVOENId01aTCtNQTNqdlBr?=
 =?utf-8?B?M0ExR2FwYVJMckgvQmZQdnNoelVLOVZ2KzJkL3Vqc2ZtOGFhVU94dlFFTFVR?=
 =?utf-8?B?bUVaY1J1cjRRWHExQktaRnY5aVB4aG0rTjlJVUl5cGtWb3dTM3VwSmc3cVpy?=
 =?utf-8?B?ZFQzcnJLaTJyTzREcmEvT0ZSZy9KL2EvQXkvb09iM3ZHaWcvb1drQldpcitB?=
 =?utf-8?B?S0VXVjhKQnI4cnE1Q0VsbjhTckJTaTNJT3crYzNwbTV3MEtGaXdtMVU0RjJa?=
 =?utf-8?B?dy9POEszLzBqbWdLU0N1OVdZOG5HejJKendScHpyZVJNQ0liUk16RGZRdjZz?=
 =?utf-8?B?WGFEaEN5NGo1UFlnSWpZRG9pdUdxcWpKQlVMU3RBZ0ZEakJTU3A3ektyb3h4?=
 =?utf-8?B?V1ltWGtLcVdYRm9KUU95TytXR2VBTUZYQ1pNZE9XY1pyRkR3U1p4Ym5aSVpE?=
 =?utf-8?Q?iujxYDS3rvNSJXkfuL3dMqKCT2TaWpXJji3l1?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ae066939-5c20-4872-75d6-08de580c1cbf
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 10:10:17.9809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFsqPhLE3Gc3pZi/SdjkkHu51aEdxllXPn4cIxgnexwmJqsRO6XLkS5DfiCoEXomGAM+GxxYTPbS/xuZNFCZLMr3xtTljsx+j5E2nvLP6Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8396
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

Hi Mikhail,

On 1/19/26 11:33 PM, Mikhail Kshevetskiy wrote:
> mtdpart internally enumerate partitions starting from zero, but partition
> driver API enumerate partitions starting from 1, so wrong partition will
> be queried. This is wrong.
> 

Are you sure this is the only place we need to fix that?

Do mtd_parse_partitions, mtd_add_partition, mtd_del_partitions, 
add_mtd_partitions work as intended? They seem to also be using 
0-starting indices... There's probably some mixing up between a device 
index (0-starting?) and a partition index (1-starting) I guess?

Would be nice if we could have some tests in test/ so that 1) we know it 
works as expected, 2) we avoid regressions in the future?

Also in v2 you said not many devices do have both MTD_PARTITIONS and 
MTD_BLOCK enabled but I don't understand where MTD_BLOCK is required. 
Are we missing a symbol dependency somewhere?

Cheers,
Quentin
