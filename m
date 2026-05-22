Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BFCCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 09:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22523843B6;
	Fri, 22 May 2026 11:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AnaNuC6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E3A841D7; Fri, 22 May 2026 11:37:53 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C1D846CF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iii1+rV544W1pfvEQ7t0Ea4sXy17+Lp5e9Soi9cfwUKZ5WR3x6T5NP6pqe2Z8QSj21c7EKkQDm0TOoAVOhCylZ/taqRQSwi/FjIQUbZ3GrHbRLzgErZ55eEA0NHAh5vmk4iDqMMj0wajd5+5NsklXPigr0rcSYl+/7aCa/AY8mmBel/zo1HQ8xaD47wJSByFlXa9GBLDBwLH7veqAXtmBHJuU6usAVi+zqSUW/Gldtluk2CzHzmt/S5XPLY97AJaEKIyaLfyQjBz5K3bF37heguVNHRG2kJQsppttsyOZ84Qjs3xGpYTLa1nk4zKd0ilvFYp84MUySFbZOBbesK3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHAdrICigOlRpQqjgzLj+eX77DCMZ+lcVKAorj7fOc8=;
 b=DdSZ68psPtBdWiptCFf++g97McDfuK4fFQPKhgCKuBwRC/h86KWuAdHkOtrHe+i1gsZ6wxAcSejeCL0/iYygTjQy8EWCsO+MWxpq+bKc40hm2PRFrt/iO/LGus0ctrutGCDXNJI9Hm8mRcwwDIZ4qLCQg9MRd8B2MQFlsidezd5StAzxLpwfjwKmLXHEcZHbaXdHlUG3E4gF0KB8TARdQYF7Pi3CRIIC1/+sjTn1HBxZy0qb/MEmRRXsy60t/wxw4x+VorgovjoaTKrkBH9VdDLxXOTbmQwqFSUfySqpG/slLUw0P7/UtmK9FShrhYADkJXVx4lb0dHuMAsDG7XfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHAdrICigOlRpQqjgzLj+eX77DCMZ+lcVKAorj7fOc8=;
 b=AnaNuC6ZV6F9g2gIj2yC29s0HbHAO+rb1ixLm8UPk2ilvrbUqSX7chCbGOMyVl0fZfrmBLc72JIKuLqwhB8RqXR1B+dEi/xLnuF91/ywbBrIze7IZbI3M98X8kSpTYgQC5aLND+KZCZHh6630SNPBmkhEM/AMKZ1udXFPrvrwpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB11737.eurprd04.prod.outlook.com (2603:10a6:150:2d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:37:46 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:37:46 +0000
Message-ID: <94e5d471-fc5f-4065-a057-fcc66f07e34e@cherry.de>
Date: Fri, 22 May 2026 11:37:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace Altera/SoCFPGA/Agilex with N:
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20260521201724.43978-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260521201724.43978-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB11737:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bd6d81-c787-4d55-a876-08deb7e5c7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: QBEwPRaZhTQldsw/PXE6D9GsoNLT1nMFlHaLOZQqgJpj+BEFuW/0cJW/7yPcB9c/V/UiFvzIFB3KFk8Nv3AZV4eqsZ4tH9xB+cl7fbRvZC7Ed+6qRMd4muSkhYU7MiPsyqtGB6zndRvbTxjvwtEsjJMro7YgruhwLVRLLEJrBvqdXHC9ms/osQJxdxQzKflEZicvCZk7GN7a9n7QT4ccEUthsqW/3nSQQ1TrDAQW+UUZsonlAH9DL3OBzRidatedTZt4fJGkrtnirLHQvJz1Xjw0sBp2MTSrVpija0TuWjAdNa5MX6EFuizaEeFCWSkN0egOfxzfLnjIffV+NfRIaSiQVZ3XLfT7+2yYJfeTpGXMEEr6WlbX66+3X9wlqDbUMnvKQ6k/3l2y6vItDmTm+q9P8eEMLfeIqKWPPW3XCjGY0sM7P88N8dBwEsVRPOOaZ37MROO8uQdMQbv+xe5rv79I8xxDaCzgSPF1XsrSO0PzLNr7qA05y/lDBH+SJN0PdeHMXvnPaLgWrENCZRXce47ne8DogSKpegOOQPMbXnUA3hB80+t+hmVs/rm+nhwdDmvDm5Mya7aKi2B3Ikk5/Us28Xh5fykadc4TdAFFNRyA3hRuQrKlbIny2Z/OXmf6Kg3TdfP1GB/XZjn4MRbI959/blSqXB7g0jezsJvoANMW0stf+M6gDRMv9ekmBh0F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZaMUwzWnYyVmx2ekVkaDk0amxVeE15aGF1SW1oWDhiSVdVSUdFeDNLSURi?=
 =?utf-8?B?Q0hLLzVCVHdEdEoybTVqMEVVenB6cldMYkwwam5aclhLdjdDMkVmQXlPNGhP?=
 =?utf-8?B?NUhzVy9xcWJTODJYZVJxZXpFMmM1NEFveFB0Z0dWMnRab3lQVmlRZU5lNXRx?=
 =?utf-8?B?azI0dXk3aEpkMG8zUlBkT0wyZXlXK0JsRjJIa09tcWxDeDRkVXZRYjRYeFdF?=
 =?utf-8?B?MzFMclJ0Q1lIUWJtZ0hNY3MzU3JNVThEN2d0WmkrMGNEdUpSd051STlwcFQ0?=
 =?utf-8?B?a2I1QnhYck9aeDBmZjYwUkdMbmo1SmVDQWpaVHZheFZ6WURwUzlUalluYTRz?=
 =?utf-8?B?UElNYlFTVUR5cGJ2aFFXbHFwVXhEZlRhajlRVnI3bUtXY2NEWUNPcFBjb3FP?=
 =?utf-8?B?MENMOVFpUlZnTzV5bmpNQjN6UVJUYmRGYXFpVm1laHhPWTFBWTRwWjJWUkRH?=
 =?utf-8?B?RHpBMjlDckxMTkdxRHRnWWhXWkFvUkplM09Ld0orSm9wSzE3WGpBNkVqeHF2?=
 =?utf-8?B?RjdMK3p4ViswbWs0dVkwL1AvV08zTktsYUUzS1FIMkVrbHhKeW1OSUFnOTRp?=
 =?utf-8?B?ajJvMk1NTVlrK1lZQitVdmpnMUNCTTFsUEl2LzViQngrdDFIeXI4NnBPdEwz?=
 =?utf-8?B?ZVlkSzdyTG4yd1NKVFdnSHc1SkpyNFVDU2IrS1VxTDRSU3JiVTA5Rmpqa2wv?=
 =?utf-8?B?TE9lbThIc251Q2p4Y0JmeTlwcTR5aUhRWm05UjZiOXFXVkVtN0tYZ0VnOGVa?=
 =?utf-8?B?dVFyMjYzdytoOWNycjBLa3VXWDhzNTJvWE15YU5zWi9LQXhBck1DMFcwdElX?=
 =?utf-8?B?TjNEUnU2a3dZbjdoNGRnNkNDRVVWVjhYNzJJK3owRlpOV0tRaDBTcTU2eVpr?=
 =?utf-8?B?UzdZanZHNDJzY0NSQm1NeHMzRk1nVlFaSkcrMmtrZ2k1OFZ6dEdBcDZZMXlu?=
 =?utf-8?B?RjdqR2I4OHBodmxSTC9haTQybG4weWthNzgwU1pSb0ZVUittVFdDREthM0ZO?=
 =?utf-8?B?SkR3Q0diUThDTXBjQURPM3graUI5elNtelVvcHFBQy9CUGQzaXFIc3N0MUNQ?=
 =?utf-8?B?cmlRUHpjbzA1UExudyt4bVVlSUUzNUhLZTJsbmtpYmppZ1E5OGFCdzVUQnZr?=
 =?utf-8?B?cTZnVHVQTGZwdmdVZ2RXUndkL2oxcHA5amhvMGxzeXVlcCtJMVAzbHFBMlZ5?=
 =?utf-8?B?S3BDUEppTDNOOXRwRTh2THVsc21QY2JQdkFSMGJhNWRWZnRucjUxYng5bUp4?=
 =?utf-8?B?NGs0NnZCVDdCb21EUE1UTHJFNmRVOXVOQUUxYXEyR1ZRWTVYUFRJb3Y0cklk?=
 =?utf-8?B?ZktZYTRtVkhzYUdZNEhiWUV2Z1pWUXBxMER5VEVPZEZ3a25jMjhtdUZMZm1O?=
 =?utf-8?B?Z2FxcUQrNmlXS1hUZS8yZUZ2OEM2dFBKbWhQajQwN1FUanNUZG1UTkNtY2o5?=
 =?utf-8?B?RGNxd2VrNFJraGUxZkRxdUt2NTJtQTRIVnQzaHVSRDhBLzNSK3F2WFlnOU1z?=
 =?utf-8?B?djJURWNPR3dGWUlCZk96U2xyTDVXWHhPSW9hZEF5U3c2dXNwMzlrT3AvOWVH?=
 =?utf-8?B?NE1UK1B1d3BpekZvam9aOE16VC94L1NvSWo2VUNyRURNUXdIdzRRaXpoNElq?=
 =?utf-8?B?Rm45QmVTZER6Qi94Tmp3ekpVSkVKZy9vZHJISDhxckNrWisvQTFhQ3pWKzdB?=
 =?utf-8?B?am55UE5wLzZKZTZObUVZVm5ONXRLcjRpSWZjQW1PMW5ZckVwZnpBb3RBd2l4?=
 =?utf-8?B?RW1XVktTbjUzOGlva2p6VE1vdVFucFNyL2FBaDBKVW9jMUhJT0t6NWU2ODgv?=
 =?utf-8?B?bEJxQU80cllhVUtYSkpsOE9UbzdWVkwyYS92ZlJ5bDhKckpJMk1nSktCY2RT?=
 =?utf-8?B?WkdaUGdUSTBCSHEyTkZVMjZvNE9IUlVtQUJKYkJ0S2p3d2QyZ2pTTTd6Qzla?=
 =?utf-8?B?QlZYcUdJMmNkN21JTVR4NWZQQmc1QzZFREVYajZ3MmZWK0IyMGlWSFhxTkhR?=
 =?utf-8?B?ejE1MThndXRIT0Ruby9Xc0FRdzU2S0E4eENVdGNWM0UyWWd4YXNTWVBIUXg3?=
 =?utf-8?B?NFRFMnkwOGF1cnlLTTNWa0U4K1ZLdHRldUFJOFhmai9aMEVZeTg1Szc1RWo0?=
 =?utf-8?B?WG9TNnV4a1l3dm1EOUdpc1UwRmhZUHlFbWdQYzQ4aUUwYmFGRWZXamxvd0pi?=
 =?utf-8?B?WnFFWmcweVUzYU9GcWQ3YjFYTFhtUXFzY1RKUWVrUy9IRzF2QkpoZUZ6bzZS?=
 =?utf-8?B?NnNtamM2MzRjNjgvUzN5TC9FYVVWd3pabnZIbHlPZE40ZE1tU2Y5MGxXSU9F?=
 =?utf-8?B?S1pnb09lc2hxaVN5bGlRSzV5RTBaSVE3NENFMk5aaXFjQjBGUEZ0Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bd6d81-c787-4d55-a876-08deb7e5c7d3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:37:46.2962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUcYPe4hux7NGxjEXzpSd4UOdO7DXbAvT8Tlca7SPaiWYhtFbt5DML2FO9GsYPORJQ6jkROuM41lvnrD5yMnhsFOxYeCr1H796Phwfyg+zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11737
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

Hi Marek,

On 5/21/26 10:17 PM, Marek Vasut wrote:
> Use N: to match on all altera/socfpga/agilex files, drop
> the large list of entries which represent the same set of
> relevant files and miss a few in the process.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
