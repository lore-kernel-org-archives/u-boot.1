Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20D2EA3F13
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 07:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77708341A;
	Tue, 10 Feb 2026 08:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="U4m2swT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4B583CBD; Tue, 10 Feb 2026 08:45:15 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D571A8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n00IKP+8YqZ0vYFGno6ID/Bo1uyqils2sMb/z8OVeRzBqpJe+Hf9VEckoHtQLd+40AQeToJewUG+a/YAYPcsQd3gVZZGnq8RzjfPdFN/kJuH/Yq1zY/aaL26SK4gRtFmcoQsHOB+IodPpYcwkup1TNKXPzKV/iN2rNe+qZ9timwlmqriloZICIGG6EYTa8doIpPaGJMxr8krz1Tt6S9CLGGASreLG5gN883vZE11HPD5nzx7W3Ng7Ye3DT96zpfZ8A2Ke87qcgq+LN22pdVY89bkuIdV3nTf73yGVWCTycVOaePuZpgKFXd7nz9BMiQXn38eAdznSMGlZnUFFIx3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSexDqVFuXDu2ddjwQKY7nzMMLSTxcAWxv+tN/Dezak=;
 b=flIDHKfRDcI/9HEAk0MWNPYUM9QcKyMVxOjAK3GccPjuAAfeBiqpJjobR9exnH9XFJWVI6nV/cXgRcESytJvuo0hj6bfRxG2/zT5BrHNxlbROw/lbtCVBj7GmibYPTiJR32v3irmx3GZpOkBTb3t4t54Cy/PSDhehCdJsmQf4kVBuF8R6l7yko7iS2a2CGWqB188c3ApiPAcjKoqIXOXW7R5MONERvXjXoUXgt8Id5EBNLa80YxkiKVjiFIywSNSPxKkSOoQXnoc0DD3yB69ZqAeozUWC9JtELnsGNFap3qumgn9Uo0V3hEaXLW4LuUPBcSjIWu/+RPmhMz4BtEEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSexDqVFuXDu2ddjwQKY7nzMMLSTxcAWxv+tN/Dezak=;
 b=U4m2swT9AKWcGhxhT1v8reZr5Jd2WwTNc4KMwVgdF2tZNW+VjvmTVJC3IeZbMTsp10JFCltjEmhNGApw8YNBOcuL1tqCA61IVLhQa1p7uzQfgad1Yw0ewxmXItzsagp4KJHUprui+vAWdIE7DnQO3hd6yIK8O5tLCHxA5zHkELwVgBQZ5RFmE1YVOgj2XXLD9qOQqnjUZeqTlE5GNAKfJ2225FX/Ifq1zus9uowx/PWbhlg24agvE7nYwFzYjp+uCr4KwW3+yc7JavKT61uQYImQhRZ6QA2gP6zOidtahBR2Fs7AVyQg76TLhMfLOWu9nK9Ah8yEBGQA5COpYdfRHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB6424.namprd03.prod.outlook.com (2603:10b6:a03:397::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 07:45:09 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 07:45:08 +0000
Message-ID: <cd3cab90-5700-4871-9675-56c1c50b7315@altera.com>
Date: Tue, 10 Feb 2026 15:45:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: agilex: restore Multi-DTB support for NAND
 boot
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260203075557.3895-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260203075557.3895-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ0PR03MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b2c52a-2d4a-4dc6-fc3a-08de68785041
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFlGeURLYllUUHVYb3I1MTQ2RXlBL2FwckU3RGFpUkx3T3lDM3FQbEJFeUpH?=
 =?utf-8?B?WmdlMXdybmo3cWlpcGxLQkU3K0drdml4cWhOMStMMjFwV25kYWV0VmxYNjZu?=
 =?utf-8?B?R2FQTXZuYmRpeDhiamdDRXM5VG5FcU1jRWFlZnhpTUZ1K3piOThhN0JGYkFq?=
 =?utf-8?B?YXhCK2hjcUlIS2xDUTVtQUx2cmhRRjk1T054YjVDQjVFWHJXL05RN0tvRjFD?=
 =?utf-8?B?czJoKy9zV3hRTHJuWFNncHJ4SG5meEhWbHZmTysrbFJIWncvK3hkcCthdXln?=
 =?utf-8?B?VC9EZ0gwVW1jV1k4NlJYZzdGZkJBdE9VSXNwY1RPMEVQcHNkWm5ZbEdCZWJY?=
 =?utf-8?B?TFhpcEJtKzNTZmVQRG40VDRBM0VPNVFIbXJ0ZGpYZDNvaGZDcThuNnBTVnQw?=
 =?utf-8?B?TXp1S3Y2cWEzTnREdzlmZVZnY004WkVhWGJ2aGdjZ0YwamU1VDhNYThMaHVv?=
 =?utf-8?B?TlBKSS9LRnN5VE15N1gyNDFZYzRzRlZSMXRCUWlRR29sU1RvbzFDeStXeWVj?=
 =?utf-8?B?RXNNSjBuTTZ4aVhNcFpNN3FGTFNtMm1MdWRTZlFZL3RWcFZuK09ma0hrcFR4?=
 =?utf-8?B?b2tYYnZES1JzMVhKUDdjSlROd0trbGdFYzhLeFdDSHk5RnJPUjhFT1QrVTdV?=
 =?utf-8?B?ZzliSkJhTzJCdTdkR1NocmZ0WjV2ZUR5bkF5Q3hhYlVGMEl1ZWxwZlZkcnR5?=
 =?utf-8?B?TzhJYzQ1RG1mZmJJK3NERG1CZHBwR2FocnFQY3RwSGtTTFdLT1A1MzNnT3JF?=
 =?utf-8?B?RDF6WVVoamlsbS9zOXc5YitlUkMyaHlQMzhNR29HYSt3bFJVTXdEMDF6ZWp3?=
 =?utf-8?B?QzdDY2drMW8rYjJBejNXS01LdnZUZ0d5dEh6TFVIelBtTjJKMk5GYnkycnky?=
 =?utf-8?B?N21IYkhjeVRZTFBvSHVvam5HWTN2S3FYZU85c2loMXpjL2JSQ3FIei9WdmFY?=
 =?utf-8?B?VzA3MzQ2N2tqVW93bFdzMGh2NHVPb1lFUXZJUGpSTFZjMndxZXZYSXgzZ0tT?=
 =?utf-8?B?cEdxd0d5ZmxjM3NIb1loQ0VyTXp0a0FpNDluczQwOEdsb0VlWGg5VkVBVzdG?=
 =?utf-8?B?TTgzbEQvU1NJcmZRQWFUc3YwdFNrZDBoVmtIVlp6a2t6dnNQYjJYRGlqa1gy?=
 =?utf-8?B?elhYQ3NBbkZQNjMrWDV0S0d5a1NQZlp2a2VmTjk5M2JaS2drYXN0SERTbUt3?=
 =?utf-8?B?M0NDUjJhQWM0QVhhUzV5NWV5QzhQbFBkYzN4eWFVc1N6WTJzZFFRbGRmUEkx?=
 =?utf-8?B?eXdhaXY4SDVGbHh0WVpLTzRod3dMdnBYWE5vVDc0cFV5TUh3TllCOUlheGZJ?=
 =?utf-8?B?dURFRGNjbXI3RkxqVUdSZlY3aUhZbnk1QnBCenl4RGtYcGg2b0pGSWpUOXVn?=
 =?utf-8?B?ZzRTZm1XQnFreWE2OFo1bmhsdFc5ZXJzMjRJbjVrU0xoTXlJdTBHeXVBclBZ?=
 =?utf-8?B?SDlvaDhjTHU3MkhIVGdNUkhlbGpBdzhrQlFSQ2h5VUcvWFloSWlJS0o4cUlh?=
 =?utf-8?B?bjVlTGMzYlQ0czlNL3I1OW1semVQOUhYZCtEcFB1bTRBdythakdWR3Jvb09J?=
 =?utf-8?B?MktNN2pDWWppV2VWNnBwbnJVcStWT2taV3lOdXRnR0lMTC9IcEpCWVBJd0I3?=
 =?utf-8?B?TlNZN0pqZ3JNeW9uUkh1Z2dvUTg1N2c3RWdYSFQ5RHdPZ2o3OVgwRjgrM0hN?=
 =?utf-8?B?S0hpOEtkbklPRmY2aTE2ZHBWUFdXOFJTa2JiV2Z2WmRzVjNQSFVjMGdWTU92?=
 =?utf-8?B?L2YveVljbzRnNWlPY0t1TFJaaVpsdk4yS1BFMlA5WGYvN0ZCWGNXVUFQb1No?=
 =?utf-8?B?RmVJMTU3OEVBVUg2czJYZDIvelhIWVVZUGQxdUt3Yi8wQURKRXFkMW1HQm9Z?=
 =?utf-8?B?VmVSVUxVZ21LSW5FeFpoRGNyazZNY3hmM0pwd2NNVW9XZFNlSGpQVWQyQW5F?=
 =?utf-8?B?b0VwWHEvMUR3K1B6cGRJSEFwNVllZ1lMd2NuLzlJdllSUjlSS3JRUnQwcElL?=
 =?utf-8?B?bUc3K1FyVVlGd2dqT1RxeUJYZC9HcjJWV0VhVUFzVVZwbXEzWjcwVjVyMGd4?=
 =?utf-8?B?YmFnMFdiZTBwZi95STNLakIzdGhLUkozb2syUGMyYzB0dm1qQ3ptQ3d2d2NX?=
 =?utf-8?Q?Vnng=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZRMkJVVTZqRURzekVieFBzV3ZRNXRvUFB3cytoaDhnVDI4QTg3Q3QzYlMx?=
 =?utf-8?B?dldGYVlDU1lEMzlqSnRHc3JYYVhZMzVqYmFjb1VReXl3am5nSE52RFU2YUFD?=
 =?utf-8?B?K1pQYjFaaTJlUER5dVFjTlM2K1BMRlR0SXpsZVdDaU05T1JPVGVoTnh5SUNp?=
 =?utf-8?B?MSsycmxJNUZabFBSYmw0UzhtS1dIeSttNkFPUjVnSEMzWTRLc3l1VTk1cS96?=
 =?utf-8?B?Z09tTFpGZ1BBM0R6cXc3UkF0dUVDTmQycEoybTc4VUt5aTQycnRIUWZ3M0ZZ?=
 =?utf-8?B?R3A4NUM0d2I1M3BRb3dZQkV6T1haMkJxbVNLOWszNzhpUWJSUlJQT1oxRVl4?=
 =?utf-8?B?ZUNRV0NtTndBaE4vRVFYNDduV2RsRS9WZXdiSlIzMnQ5YVBKQXZRdjl6N0g5?=
 =?utf-8?B?cFdLVmlpWU9tZDRLVW9mdko2alNCaTQ4TlVMODNsMm5oR3hXV2RKWEpTY3ph?=
 =?utf-8?B?NXAzTHdCZFFEWWtLT2V4R3NpRi9KeFV6a2tJTTkwbnI1UVM1YkRkdUZoZDlK?=
 =?utf-8?B?cnFuYllTRFRWWGNWQ3o2Z1BGOUdLK2hGdjhjVi9kQTd5LzE3VEJRamFmNmtN?=
 =?utf-8?B?SkpPUHRoSGE0RWtlTmRBcXMwcnoxNktaekY3MHd6ZDNjRjFET2VmY3ZiUzE4?=
 =?utf-8?B?STBGLzlYbFNVSVV2eCsrSi92TmkraStHdHVFQ0JiWXlqZzBFanRSVHdqZzZ2?=
 =?utf-8?B?OXpURjdRUlNWTDMzN0YvWFQ1a3JRcEdRL3BsYWRMb3cyKzU0QXBOZ25XcDRx?=
 =?utf-8?B?YTlUMnVCc0ZRN1hGSFRYcnR3TStKTGFMVmpaUStyNnhvYlc3ZGJmVlJlU2Jj?=
 =?utf-8?B?bGRZOGlobWt0bnd6K05xeWdOb0gwaWkzM3VBblk0Ky9ubDJ6d25uNXNHczJH?=
 =?utf-8?B?ZTBieW96dHJSa1lHcnI5RGJSS2JPNnZjclRXa2tvUlI5SUtqS3lHU3o0NTFQ?=
 =?utf-8?B?M2M2d2hPNXRFMytCZ2VBbkRiOW5UbHJxa2V0M1ZhL2RPU09XZnlIYTNTTTdI?=
 =?utf-8?B?UzhzdkFrZVlDb3ZOSy84MnZOaWIrSnpIUGZMRXZ5NWFZajdWaFlteTBTNjZ4?=
 =?utf-8?B?cE5TN1REYVRTZzRxRlJSZFFOZGI4Y1BKMzJlMHdMdWMzcEs4SnBXOEIrTzlh?=
 =?utf-8?B?RGQvRmNnMjgvMDdJeVc3Rk1qbEloRTd1Zm4wTFBmTDk5VWIxeGF6SVhaZUg2?=
 =?utf-8?B?YXBmREZ6OGQ5dkxhdHpaRzFHUUNTaVpleUZkTk5ZRzRkVW8vUFdSN09YL1hL?=
 =?utf-8?B?ZGRsNzZWclc5bGJOUE04UGdoWHhPcjhqVzQ2TUlNeDlzSURnRVNNQ2JqOS9q?=
 =?utf-8?B?V0lleW1rb3ZRQTRoK1lLYkFJbEJtN29hSHhIam8rcUE3YTNPVUFpdGVSUjZ6?=
 =?utf-8?B?NW0vUmRYcERDRTZCYTBPY2ZtZncvcGc4U3lEOUs4WDB1Tm5rc1FNVHVxY1lh?=
 =?utf-8?B?NHFPU2RCWnZDOGJJZDhLT08wRUx4cGpXWTZTcDFSME9uZksxQVlZUisvaWdu?=
 =?utf-8?B?S3RlWlkwSEZtMGw5Sko5TmUydkpDZEhRM1hrLzI0b0loalYzckpTcE1TL0VN?=
 =?utf-8?B?TjRhK1oxSjJ4OS9yUnBqYUtKYlRpT3lEdjRLdjhDaTY0enhlSStaZ2RUaCtp?=
 =?utf-8?B?cG5WSVlaSlZwZytSRExnZXlWaGxOU1J2bTcrL0hYY2xRdSsrNGFUaThoQ0gv?=
 =?utf-8?B?VEk1cFRybHp4L3FualpmUnJOak04UGpVRFdaYXhxM2IrYzU4YUNFL3NVQWxs?=
 =?utf-8?B?RFd2amovRlJaeCs3OXNQQnBNWGZieldVMXQ3UC81VnZWVjZXQnQyUWRhMzZM?=
 =?utf-8?B?M0pnM1I5ZVJCTzV3QzBjY1NPbEt5MVNSSXRRSkFPY05KVXp2c0puOWNnbjE3?=
 =?utf-8?B?RGo4N1E1SGVwL2YxODlPWXRLSjBRMnFxeWFoRE8xVEFGRnc4YWxFTTFjSnRt?=
 =?utf-8?B?dGtFSmExRXJtbWYvS1lBaTdLZ29KZ0tMWWROQm9MbHB6dEVGS3hDa1VKMXE5?=
 =?utf-8?B?K1JoOUdNcGJQV0t5ZFhKVjhJaFNZa3htN3ZoMElSNDllQUtySkNrRXd4MHFi?=
 =?utf-8?B?aWtzeE9VV0hNemZEVnNwenNGNlQ0Y1dBcFZyS3BvenU2Tm5CeVBXMDA0TkZ0?=
 =?utf-8?B?dFlRbHRNdndid2syVWJ4K1pkNS9VeW80OEhEeWJsUGNFOHJMUHgwc3IvdDFT?=
 =?utf-8?B?Zlc5Ti82VUc0NUk0elhyTUhrMXRCM3QzMURDaThHUzhnSkJjZGpwSDAyQ3g3?=
 =?utf-8?B?ckYzTU4weGtjalF5SFBqYlhaeHV4NmcwZE03M2R0VTk2Vkh3VmJ3Wmw2OVZV?=
 =?utf-8?B?OHNielFWd3cyUWh5M09HNmp4azlob05lNENhQlVsV2JuZyt6OWVOZDJQUE42?=
 =?utf-8?Q?CvLM7kEjiCILuUc0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b2c52a-2d4a-4dc6-fc3a-08de68785041
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:45:08.8974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5EkYmTLGkaVC82eGL3+1apKMG3DKY309zcb59MgcMSwKt1W1G9r+h4h3HJOGpE9/vqZmyPio0iq0TGiJLex3MJvx6LmpiZo0sAwqNlMWpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6424
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


On 3/2/2026 3:55 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
>  From v2025.10 onward, Agilex platforms use the upstream Linux device
> tree sources instead of local copies.
> To continue using a single defconfig while supporting NAND boot,
> restore Multi-DTB support and update the DT paths to the upstream
> intel directory.
>
> NAND boot is configured to use FDT-1, while other boot flows
> continue to use the default device tree.
> No functional change is intended for non-NAND boot paths.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 38 +++++++++++++++++++
>   configs/socfpga_agilex_defconfig              |  2 +-
>   2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> index 6f2fe7bf746..37a3b14ed33 100644
> --- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> @@ -181,3 +181,41 @@
>   		};
>   	};
>   };
> +
> +#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
> +&fdt_0_blob {
> +	filename = "dts/upstream/src/arm64/intel/socfpga_agilex_socdk.dtb";
> +};
> +
> +&images {
> +	fdt-1 {
> +		description = "socfpga_socdk_nand";
> +		type = "flat_dt";
> +		compression = "none";
> +		fdt_1_blob: blob-ext {
> +			filename = "dts/upstream/src/arm64/intel/socfpga_agilex_socdk_nand.dtb";
> +		};
> +		hash {
> +			algo = "crc32";
> +		};
> +	};
> +};
> +
> +&board_config {
> +	board-1 {
> +		description = "board_1";
> +		firmware = "atf";
> +		loadables = "uboot";
> +		fdt = "fdt-1";
> +		signature {
> +			algo = "crc32";
> +			key-name-hint = "dev";
> +			sign-images = "atf", "uboot", "fdt-1";
> +		};
> +	};
> +};
> +
> +&binman {
> +	/delete-node/ kernel;
> +};
> +#endif
> diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
> index eb99392f0ea..b2c7b30d546 100644
> --- a/configs/socfpga_agilex_defconfig
> +++ b/configs/socfpga_agilex_defconfig
> @@ -58,7 +58,7 @@ CONFIG_CMD_CACHE=y
>   CONFIG_CMD_SMC=y
>   CONFIG_CMD_UBI=y
>   CONFIG_OF_UPSTREAM=y
> -CONFIG_OF_LIST=""
> +CONFIG_OF_LIST="intel/socfpga_agilex_socdk intel/socfpga_agilex_socdk_nand"
>   CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_UBI=y
>   CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>


Best regards,
Tien Fong

