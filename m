Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494DEFD8FD7
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630C783F14;
	Thu, 26 Feb 2026 17:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ayePjzEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7179783F2E; Thu, 26 Feb 2026 17:44:11 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B61383E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQhutqEdax0vS//FSHtWzHRyk+gE2q25mVAbxW2/5qDUTRvd2+02GbviyK+EJH/hp4OcBNiBKDHzqlf4hggjoUnxnQnbdnIfWcoBxD+D7QcSHtE9FxBfXv1wdVBXstSHXo7FCspvabWv2Gxwfa85cxiim9wJGDoc6JSHYXPF2T4eiWIqC7e3S1RlpjVVkOmtI4MJnekyu+DYcWYber7J+sgsEFLT/A0ydlpvmmMjnlL6yAyIkp6dFN9zt96qXG8A8VjCGmJ33KoQfou261lOilLSIiJT7KHO6bHq2S3tVVzCUZqLlqkVHyOO6nJpiGZZKFwqXsyRSCzTwlLrNPSaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy+TMalzHpQF8TSQPtQAQnbLr5Rw1hUF+W5PaZ/SBlo=;
 b=iESK3s/NM38vPw1xAAIRRDrKcQWhjlKDlivB1yZuYV66Lya78fHzRlFrgdcTR5J9JIMhMIxaQTwavVJ8T/b4rWKYQAtTAhYX0utOgrQv541yYRoyfIUsx++AgCt0m9IgbpUN5lUx5IkxzSKsYiAnYAIPBTUQWCxGMzDHDF+1yb1TnaqElZUnrFDSf30MzVVZQo8V3IUji5Pygd7h2RHQgyWq6r8bJGhPIdIaGmU08zrB17yga/z4dotoByz1fv6MiyZWZoGCNSafnlRCkQeOzmQRJGDz5DccjpaWTvwsip7uuV/QiJWHpoPiw+ZmmSMD+RjXFAXAoktyWWoRJkl1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy+TMalzHpQF8TSQPtQAQnbLr5Rw1hUF+W5PaZ/SBlo=;
 b=ayePjzEjFp0GhRACIyQHUokELlKGZ0a9sW/yDNsXUdoDoK9xNPuGeBwMi3p/OC479bY/L5kO+vfdphgzZhWpxAshLtOnmnwRAkSrobjJTPojMSaaovxGj+5EQMJuuuvmxWOvBd6uu9P0RH0hk11qiucRI4OKxy3okiD43vWyxf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 16:44:07 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 16:44:07 +0000
Message-ID: <647a1ce4-66c1-42f4-8841-69828cd665d2@cherry.de>
Date: Thu, 26 Feb 2026 17:44:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] binman: test: Capture output from tests with warnings
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225225040.2568118-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5339ede6-3e8c-4a58-6bc5-08de75564220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: yZpZ3oqSCRNHZnmXjqfTv9KVPZcYOIDmyfeuzWAAEWswMwYR2MClFcyssf4fTV7M2eLd86fYlTkHoF7JTHPys2z8shgpwscCiPVqdUkpEem1R3fd5liGFFkdCxt7gtLhwdb26ZH7EABtah8B9klwNKmi5HzTMTBwJZ54pnnGQaGRj2VZiB/EoJ0AztgoDo80sG64VEiveTcjBUeT0bzt6xJqh3tHYKEb3SwIvdRgtRSv1VzPgAgKB6f8fXw93hEMbV80HH1YM8p21D/eXx1nQD+Mc6/iKdbvN3NtwywU4Fi7UkiNWZGqVBPc2EOls67Vu+VoRCmeDDHQbfBzzCYnZLFYA9sEM1lfwA/wqInpenfNJ3/iXgKR1mAFyivRqpvavF94Ja6+e2qUll3SrGscUQ4XEO8hGxFsGofNJroe5HP/pyTjIBubV4lnPA6N6wBIU8EHW72RQUHj0If7+cVxE7IHF48jEwPBitCsdeD3RDMKn4WA1JnKNv+sjCewSKVlaTbxL2ZhJnyqI5a2gafqGGf0WY9FIUqeIOdxmZ/UJRRMqqn7wO+ENnUDRYVxzINFWje8fDHvahyYlowFlH6X/Jvx9g3XLrC7sDt6h2TSRG18KmNMxFlFSkGvji+CeQAzYCNXqs8x17TNWJZr31IGtgIax1+Dh2HqQjHc4fKOVgXnqRBO9fHwuPqr26nz8KpKuNGMrwIecvyXGr7OwUS2/EMmZMI7CyzZkr8S90Y7rdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUpwQzRDYjQvNUcrSWpJODNaZUN6Y25GQ2xwMmVOeG1OZjZtWWh6Z0VPVEMy?=
 =?utf-8?B?VG9scWNjMXhFWWI5R0FOTmVIMGpyOHAzNXdLMDR1c3k1aElLS3dub0phbHM2?=
 =?utf-8?B?Y1RDSkxlckgwQ1EraXgzRndqTVZkek5qSmE4bHY4ZWw1Nm5xU2RwWHIrMThu?=
 =?utf-8?B?b0tzWWJKS3Q1WkVhbitmaEx1OEdmaWE5ZEFqeEh2WG1RVkZ1NmgvMzdBS29C?=
 =?utf-8?B?WkI2NHZKcU5KU0I4S2JDcUdyNVhBQnNORlJHS21LZUY4eWVYeXpQSEtRVnRC?=
 =?utf-8?B?dW9zSldjNWF3YUVpMVV4bzgxZmJGNTF0K3BZRWJvK2RkTk0yendlZGVXQmE5?=
 =?utf-8?B?MDNSOGlOWWw1T1VpakR0akxOKzdBOG9ieVVIS09QK2pFQWJFQ3RFdWJBdTRo?=
 =?utf-8?B?OGZBdkJaTXZyMkRNcVJLSGVvWHRNc1NKWFB1WERObUNnU25RRkFGUjNBQ0VZ?=
 =?utf-8?B?UEZudkdzTDNKc1dDZ3VxMUVTOTRudktGRDBCcWVpcHUwUUZkcFdvcTMxK25l?=
 =?utf-8?B?UGhyM0NRTElYMUxBanhKVjNLbUVRS1lxVTdHdWZONkZVS0l5dzQzdGgxWEJq?=
 =?utf-8?B?dnljSlpZNUgyVHJxd20wOEpVQW5Hd0l4Y29ORzZoTTlWcTJwK2Z0WlZuUGha?=
 =?utf-8?B?cjVudzd1VnNseDZsK2lGdStTbDhYSkIrdFoycHc2TC9wZE0rdXJ2a2IvVjlU?=
 =?utf-8?B?Z0U4Zk44R2ZlaU9JMzczcVlYN3ZBUWdFd3RDRktBVmhWZWlOV21aZGhIZ3lI?=
 =?utf-8?B?TExLMWFaTmdDcGg3OEt6WndaaE5ZejZ2LzZwL3ByU0tlcjgvYzZSZTdwdWhT?=
 =?utf-8?B?cnZOeUV2K1h2KzgxeFJHUmsrQm1laEp0bnVuT1Vwc2JuME9xc0pEaG94OHRa?=
 =?utf-8?B?TTFXMWg5dE0xV1BpSzJJdzFtbEQ3QzQrdTMvTktIZ21KM1Z0QmwzR1pTOU5O?=
 =?utf-8?B?d25iNEJscFlFcVFkSEhROWpuaGJtUzRyL2ZaK1NsdWRHbHBPZVlidnNTV0Fj?=
 =?utf-8?B?RHI4b0QydWtNcEE2WGpsMk9HbWtxRkN0TWw0RlhkRlJYSXhOclQxd0dFY3Yw?=
 =?utf-8?B?WTh1RUZWRG80N3hycXgvUU5kY3JIWW5McXM0UVNIeDBJMTFSZWtNZmNiN2JY?=
 =?utf-8?B?R2FlWXRVV2lSVHMxaDZuaGFDUzJmQzdKUnJtOEFhR1lVWG1PRlhaczM2K1pq?=
 =?utf-8?B?Q3RmWjZDbXNqTjUvT2RFQnZqSFZ6RFFxaW5hb0g2VzJaL3l1QldnL3NJS3JZ?=
 =?utf-8?B?ampSTDdjREgrOUd5dHpmaUM5ZTQxTFBWeUErRGl0ZGJtTGVoNi9oNWJuc2p3?=
 =?utf-8?B?YjZPU3JTMVBXZHNXdU9LRGMyYitqWU9kdHFpOVpCMnVjM3ZkTG9nTm41OWIv?=
 =?utf-8?B?VXk0UGhFL0pudDdubjlXZVhaa1lLNGJXNDFFMzI4L0xCVS9tVGVJWG5PS0Jo?=
 =?utf-8?B?anBaajBiZjc3WDBPdmowbzZEcHRIZndTMlJ3akU3RzdvQXVWYWxZY0ZZL3hW?=
 =?utf-8?B?eWxlV2tFSk9RdGxiaGs1Q0FaQ0gxSi9tSDFFNWs3cGp1OXVqOXdla3d5R1Vm?=
 =?utf-8?B?QzhnWXFuNVVOUDRpeWxpTUcvcSt1WWM0WWg0VEF6OElLd0dxZmYrMWtWcWtH?=
 =?utf-8?B?T01HaXh0c0NmL1lDNDk1N0FWOVBHbVZRZGtaM1VZUzlaSmFqRFBha1BJaVpm?=
 =?utf-8?B?aXVKZXVmbHAxVlp6a0JXR1cyYXJSbW5WRzYzMVVRUEFueElKTGliSE90djMr?=
 =?utf-8?B?dzBMYllsUnQwcndoeWVTcTh1ekpNdngrRTd0bVdDcFdienJzU2hONmQyQlBk?=
 =?utf-8?B?UWlkVUloMVFtd0lXVFowc1lBN0lQVWovV0dsR1ZrZW1WeGI5VXVLRVZ4L3o1?=
 =?utf-8?B?WVR0eE9PNndjUWc4Vk1ZNjd3NXhZbkN4Y3B4bG0zU29YVjg0WjNPZE5UOUgv?=
 =?utf-8?B?cEs2ZjlmdGVJUitiNFpRQ2lSaGs4aVpqeVhNUHZxOE1xOTZSMGh0VDlNdXB1?=
 =?utf-8?B?TndKWHRlTnpyMGpRaXpCNWNOSHNvVXZPZFg3aml1b0dZdzFRNUMyb1FPeUM0?=
 =?utf-8?B?cGw3TU9CWUEwcGdSeG9SVnpSc01zRzR4UlR0d1AyK1NyVkhweVJ0QTB4c0sx?=
 =?utf-8?B?SyttZkZTbjdaVFFqWUl5Wk1LLzA1bjE2MDlOczAwQ0l2cmN3a3hjazVKUHNU?=
 =?utf-8?B?SDYvZTVDUC9KSzVNUTVWb2hRRmpyUTFIWVFlS01aNU5OdGVnT05xTThLMFFS?=
 =?utf-8?B?N3F6TXhGV2xEV09sbGs5aGRXdytQa0hSUDVlSzYxZ0RtdlZxQ3BOdWIvSW1N?=
 =?utf-8?B?VDVzb1pMclRwZWVIVVJxTWVPa25xYjB5T1FSbE9HV1hobUg1dmw4dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5339ede6-3e8c-4a58-6bc5-08de75564220
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:44:07.1371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXgkwDHAv7fIziVgRfPxUxXnRd7yM1Xnl2Iq+JIf3HY9asJljV3tZATVqdP0KIyDHlQryvAWEdqujVifoNkNTaFhyebiew5a/qI0T0+N4cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8989
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

Hi Simon,

On 2/25/26 11:50 PM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Tests are supposed to run silently and capture any output produced.
> 

Fair enough. But how about making _DoTestFile() and other various 
function calls actually eat stdout/stderr by default such that test 
implementers don't have to remember doing that?

We can always return stderr, stdout to the caller of _DoTestFile() if we 
wanted to be able to parse the output.

What do you think?

> Fix testRemoveTemplate() so that the message about the missing openssl
> is captured, along with the invalid-images message.
> 
> Fix testNxpImx9Image() as well, since it is expected that container.img
> and bl31.bin are missing.
> 

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
