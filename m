Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95A3E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2B7801FB;
	Tue, 17 Dec 2024 22:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Wo2TdqZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54958021D; Tue, 17 Dec 2024 22:38:34 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74E080107
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I86/cAxCvQn1cJOoE/awol/054eBHaLDNASiECuzAlajPAN2/Kea7WxEnyfxGRAWDtFNpAW3xyqhZ4sIkoy317YxRQprG8LMVrw5NhZcMoMO6bplPOzO4yGCj1Q16LkURuUgEQOP2C2DHd/9VTySb8L38k+be9uVo65layn6d/IlazH54dQebNwqwbUb8Mx0t5P6+04kXWQvxM6EbVrD3CGZqAWhC3QDcpcdwPHn35KSxkzLJw72hhpjacDJa/Uik8Vv///U/coKZraKo5RpJZuuev9UaJe292rMFDL72BQypj6qCqGtVMswIyQhqtDx+Mh48JJnNmZTbwNStdlIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5YghChQBYV2ynLbXRVxSxFgSBff2gt2r5SXvO/fWao=;
 b=sl4TvYcECuhoi3uAPyW+M6Gv8CI0yN2CuXR9s/W80afxjnxZFxomu+GCSTQoHRApyk1DlzpYdJgv7f0Fc9b7bzhVNlxqgMtPyMeHl+jsZ3FX0G9jiSZvHvzdg6QQItwSwBF3KiieazqZGm9kHBW/Qf1cgtUY11trxYvPCturtUlhFosXmQlxN5dHqnLQi+l6U6xu7zoGRmjfCc9XYKJPH3T22tT8JiQtbs9PxjISp2/ddNcOij1d3G0tnGWYoKwdUh9JEt6SQclUthzAhVItZ1YDCc/0BlDjKccsLTE6kOFrPZ4caU3V0aEDhOVmj+Vs4DnvE2xVlsI+3jiSHGd9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5YghChQBYV2ynLbXRVxSxFgSBff2gt2r5SXvO/fWao=;
 b=Wo2TdqZEyYFbyYrU01tU4XZN4AWcHLGUU0eOXjdYakX6/Nv7SGJuX3RZxzRbRUG3Dg5FYdBPM5vsIXfp0vbigDrFL6L1HguxXGnAqPpcnyQKrzElJyGva6+BKbYqJLWegVLH1Mke+kwlCXvr7DfnvFA1y9mNhy38ZniasGEid0VU7y8/7YspccAT3KgU0722r8NhJKuWug9G1kpJwxAQCJ2illZwzw/DeaVrT/YXMbJ72YpmCGosS31rhIMixLQI1s5b8t43MS4TaYX6nowX/0zx0Imf/F/gkk5aF/s1pBDDz5G9YNGvSRXw/+r4Ku5laXx3BWOKoLjdydaONKTRNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR1P264MB3445.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 21:38:30 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 21:38:30 +0000
Message-ID: <694d0094-ee37-4e70-a199-889065e662f9@softathome.com>
Date: Tue, 17 Dec 2024 22:38:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] test: lib: add test for sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
 <20241217083212.70330-7-philippe.reynes@softathome.com>
 <CAEfUkU+HdnKY9WQ0J0EgEqjtooFDhnPT0wGBu6=svxaEPzX-xw@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkU+HdnKY9WQ0J0EgEqjtooFDhnPT0wGBu6=svxaEPzX-xw@mail.gmail.com>
X-ClientProxiedBy: PR1P264CA0199.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::18) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR1P264MB3445:EE_
X-MS-Office365-Filtering-Correlation-Id: cd065f7c-af75-4fea-caaa-08dd1ee3263d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHBsUFJWS1pNeTI1emcyTkVLNndIV2hVY0I0WWp0ZmgrY3pwVnBSMHl2QWlJ?=
 =?utf-8?B?V3NuNGlySGRrdHY3MFBFcUtFZExqTjlPOUZDc3FGS0dyd2RKRmFIVkcwTlJw?=
 =?utf-8?B?N2RtWHNkQkVkdVNlNmlLZU9SY1ZaWU9HcTF2bzhSVExVV0w2VC9wR2hIbGxx?=
 =?utf-8?B?TFZGY09SRHZScVNyYzJDWmR3YlhXUjhPOUVZN1BwRjQ2OGp6dDBVdzZ6dWEz?=
 =?utf-8?B?RW92WFowM25XSGtUbE45TWN1TVhMRTE2N3hpaVREeTE1NFpuL2oza01iWUhw?=
 =?utf-8?B?ZEIrNnFQVmhvOFpSb3czNjFSTTJ2VWZmRnd0T0hTYVFjcjRuR1hMSXpWV3dZ?=
 =?utf-8?B?TE9ubFo1RHlyNGFZRlh1RUNPeHUyU1hUTmR0cnZaK1NSY05xdTROaEVaQWVa?=
 =?utf-8?B?eXFDUkZSZ2g1by9pSXJhMG5qMkhIdFpWNXZxd29DQzd4V2lrUk94Ulpqc1hN?=
 =?utf-8?B?OUpHREdpdGs4Q3daUGdQOHorN0dNTWtzVTRRNTh2U0VKT0Q2c2VEN0ZqYXRT?=
 =?utf-8?B?RHk3aThXUUttajhsa3QzcS8vME5oclVEaC9YT0RGcE9iWktLY2podmxZaG9r?=
 =?utf-8?B?bHUwUmN0aGdmbVFKQlZDZnVhc3BoR24rMkY2cmFxWU9uZmRUcG82cWpGZ3g3?=
 =?utf-8?B?M2twcUtXckg0WDErcmRYblVUbUloQjZJUlYzeXhlV0piN0FFcFpTRjE0MGpN?=
 =?utf-8?B?TE55cEE1anQyWHNkKzNBOG9LMDd3bkw5OTcrbHU0UW1obmV4S25obHhmTFN4?=
 =?utf-8?B?Tk9VWGhvRjRtdFBmUVZjeHNLTTYwQ0JMMkpNMDZ4QXJnM0FxKzhhSldmMjBm?=
 =?utf-8?B?VkVsOHFQWnpyMGdTeG5SZnh4UFlubFdlSENaTGEwQlJLYURxZkRmMEsxOGtZ?=
 =?utf-8?B?SjdlZW1rMHZCUlFYcHVSejFQcnAvVFIvZDVPd1hsMjEwRzRuWFdxYjB0Q0FV?=
 =?utf-8?B?UElPdFkvNS9VQngvUEZvWWI5ZGlvS00rbVM3SDMrM0RJenAvWkh1R1E3aVBV?=
 =?utf-8?B?aDUxa2FZQ0RzVHM4L3NvYkJaUHJrVHZJTHJsaWdkWDNUakJ3bHpsQ2RsWmFl?=
 =?utf-8?B?VDI0VnVJL2g3TWFGc1JTTDRURjduRVJWd2s1cUFTeWhESU9pRkIxTStuVmRl?=
 =?utf-8?B?WXh6ZEpsNHRUVysrQzRQMFN4cEQvdGRwN2xkSGNoUUxTOFdQbzRSU2p3WW9O?=
 =?utf-8?B?dk9xeFREZHhBYW9jaTYrR1hhZThlaTBtRE1SVWo3cWh6Z0p0eEtzMXd1a3pE?=
 =?utf-8?B?R2RXQTBoVVdtdUdHS01QNmJ1Ni9iL242K2VHQ3ZRMy9FcThRNU5leUdVc0Y5?=
 =?utf-8?B?MHVyaVdFQ1RPODQ2UDI2WjhGczVvLzJXRlBpd2ZTdkk5cnMxb3ZiQVZzYVh6?=
 =?utf-8?B?OWlrRWVKdjZkb3FkSFlVUjN2MFpOYXJvSHJTMXRObS9sQlZxZlBXQ2MwUlh6?=
 =?utf-8?B?VnRyYU5UaWVzOXd5TVU3K09DbDBRWE9KVWpUUEd1c0VhVithSGNEZEdITmpQ?=
 =?utf-8?B?TUhsenBmVDE4UEhQNFZob3NWOGZkakw2aENMVkhOc2lnb2ZkVlRhNWx3T21O?=
 =?utf-8?B?TjFVU3ZuTjN3UkgwQ0ZxdXhrU2JDWnpOdklLYkJvMHQ1anhKWnk4b0pqN09q?=
 =?utf-8?B?cHlsekExcnExRnlYM2VOSjBjRGs1T1FGbloxZXVUN3p3bzFPZStCZ29xNjIw?=
 =?utf-8?B?a3RDS1hUY0dpbGlLUTh1eURvaHQreTY0aGJuTTJQekZaWGt3bWxmMkc1b2pI?=
 =?utf-8?B?VnZORDNneThYNVdqRlk1b3BiVXN4MkZGaFNmOEQ1dExDYzd1Q21iKzh4UU1z?=
 =?utf-8?B?c0tCYVVGUmpIRlRYaitST2VTSHhVVjk2czkrMEZLK3k1MXFJcTk5dU9qVHlm?=
 =?utf-8?Q?PIjEnG/axA1ZQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1F5UzI4UVR5WnN0UmVQSERMcFRDT2d6WGpiTmxiRWhJZ2xUbE1leWZnYlZu?=
 =?utf-8?B?WldtamdlTEExN0l6WkJ1dW1QbmNIRXBOczFMbk1zSHlNZ3BzZ0ZlZkhHZkhZ?=
 =?utf-8?B?Tm9idlRsTGdzb1dubzgxZjFsQjJaN05QNUc3QnNXaG5iOFBsNWdNUlJNZXBn?=
 =?utf-8?B?NS9XZkJvQVdja24vcTYxR0U2a3N3T1I0Q0Rzc1o4dytGMVByL1dXQTNETXdW?=
 =?utf-8?B?LzhmNWcyZERHaFJZdlJ5Vmo0QmlpaWc1M0J1dnJ1NFBUR0dJNjFGTVViV2NP?=
 =?utf-8?B?bGJPRktqcGNQN2U3alJtY0NjbkdIMHUwQlVTZTg2aEhLeTRYQnhTUDQyRjZS?=
 =?utf-8?B?cHhSL0tQTjlxdEdGSFd4VEdiNGZlVlNVbkhlOTVnZlhsVmZVZkNaQmFtS3VD?=
 =?utf-8?B?OGhnSTF2bTFzaG1WcGlPUFo0V2h0d21qTGRKd3kwQ2Ftb3d0a0s5d2tPaUtD?=
 =?utf-8?B?UnB1akd2Tnl1SjIrdGhCMVc0c0xUZHNqYUxiM1J0NUxLQmE3R09GOGo0TGlZ?=
 =?utf-8?B?OGZPaFMxMEJrWEFQUEhUeTZBZFM4U0lSRGxMR003bkdCSlNoUEtSNndBSE5H?=
 =?utf-8?B?WVIrWkpNRWNWdzI1Q3RUWllvQU10Tk93czEreFhTNnkyeXpqQm1GdjRxK1JC?=
 =?utf-8?B?MjdhcTlNbGhCUzhad0xta1c5bFpydG9GVXlvekFSQnRZczREVHRNNjRIV1Mr?=
 =?utf-8?B?ZUMxR1dLTlJYZXBvQ1pvYWh3akllOG9hZ055L3E2UERwcnRjdHdyN1BqMTM2?=
 =?utf-8?B?eXhRSC9WaUVrRUZ1eWEwV0JFZUhGWGFpamlhbTdTeGlidnZhMFhVYlNObXBt?=
 =?utf-8?B?eENWZTFrQTV4SVNPbTh0Ujcrc29oQ3hCc2txdURyRlNhU2VXTVFBTnJ2WCts?=
 =?utf-8?B?Y3FhVVpVTXRMTDM2bHp0K0N3ZE84SnNGS0Q4WVQ5b0dTZUpRU2lCUDFIRGhG?=
 =?utf-8?B?WEF4Ly9pYi9NVVJsT215bmgydUpVS0FEUzNpOWhVaTZjSDUrdGM5R2tUcFdM?=
 =?utf-8?B?aDRJZEJ4VHZlWXR4ZUk2RnZwMkU1bDBnM0VzalNFQmdqUnFqb01mSEM4aW9K?=
 =?utf-8?B?bHZnMG5CclphSm5QQzREakhHclJEU3UrK3BVS0ZPay90M2F1YkptcGpzNHBS?=
 =?utf-8?B?SDBGN3RMKzgxMVJPbm04NTFnMlR0emRVbXFDM0hzZ0w4RDlOTTNRNmxSWTJ6?=
 =?utf-8?B?eTg1YlFiblVkdHkrYmNiSmJVdUJ0WElxczZmaEVNRXg3d1pTU0ladWp3NHRt?=
 =?utf-8?B?S2F4eDVqNGxJNXdVSzk4TU84UHV2ZTBtODd4VkJ2bjNKdmNFV3BzMjdYejBz?=
 =?utf-8?B?KzgzTUZTVUV2OUhaZlAvb2EwWDdlRVBZaStoTWZIdThiRUR2WmsvRmhVaGgz?=
 =?utf-8?B?Zmk4UWVnTkcxeUI3bit5K3hHRVkyUVlXOWxqWU5QYUhqenRPMlRaWnVYVTA1?=
 =?utf-8?B?RDJEZGllWE1jbFFkQXNkMkpvNWFIT0pyNXZMd3hjUmpMTUo3bzdrTGI2OUFF?=
 =?utf-8?B?ZndoNVo5VmFaQ1FkQVFBQW0vdXpvSk04Q1o2SVVDYmJaT0N0MElCdnREei9H?=
 =?utf-8?B?a2tXdDVVR001SnJ0c0hjblI5LzFRYXJ1QmVoN0twL1JtNmpWTFhodHl3dGZC?=
 =?utf-8?B?Z0xqT1ZPRExQMDNOdzFWUE84dHpXUGlqTXFEdkU3T0E0U2krTDVuSFNjcVA4?=
 =?utf-8?B?VDluMTlkTDUxbno3QkY4cXdXZTNBTlRqUVg1WVFRNTlLYlFYeEtWZFI5dEwz?=
 =?utf-8?B?VHQxakxhT0JDQ1dEakZyTW1YNGdpWGZYOUdUNVgzTG1JYjlrMGUvUXpOaUJR?=
 =?utf-8?B?anpNQlQrRlZ2QzZ4T2I4RGdtY3VRRnFxQThZZldnTE9LOHNwVVJwSmEyMmVB?=
 =?utf-8?B?WTllQ0NiR09xSE9GNHdoL24zSzNBR3g0NWlWUjRscUp1Y1FDOXBiQXBZMFdm?=
 =?utf-8?B?VXlydmNqbllqalRSWTkvdFBDN05mdXArNVJybG5KcUhSU3FFWWpPQXRld2pB?=
 =?utf-8?B?Y2xGM0p1SzkwQUx2WnVZQ0JSSHZkc2ZxMkQrY2ZoUFlvaGhhcWF0S0NvTTNm?=
 =?utf-8?B?UlovSU5QMi8xOFFQc2Jua2tUbytsMWJKd1VYZUt3NkJOaDlQbm5ocFB0L3FJ?=
 =?utf-8?B?c3RQR2hnZ1U0Ly9aVWx4RkNjc1VDb01YdkJkdFhRbExDQlFVbzBveCt5OGZW?=
 =?utf-8?B?QjJUN1NMdkNMNDVPMUptZ00vT2J0MWZxZVdCS3NJOVl3bEZZbEhuWXA5VmE4?=
 =?utf-8?Q?MRIJG20j1IJk2607vHYrqyP0y8dE4EPBbsWDv+lnog=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd065f7c-af75-4fea-caaa-08dd1ee3263d
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:38:30.5866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVCdeXMbulUkFxhHmHHiNYQ4WgUAkHPwmuEr0EvN9RJbIeYp1uZbFCiK+KGlFb7P9Rn4XeNQ/yrsc/3Kg2aSQ9Lr2YPsU/Bz/gTxj/aVE7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3445
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 17/12/2024 à 15:59, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Tue, 17 Dec 2024 at 03:32, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds a test for the function sha256_hmac
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      test/lib/Makefile           |   1 +
>      test/lib/test_sha256_hmac.c | 294
>     ++++++++++++++++++++++++++++++++++++
>      2 files changed, 295 insertions(+)
>      create mode 100644 test/lib/test_sha256_hmac.c
>
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index f516d001747..4c0abcba81a 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
>      obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>      obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>      obj-$(CONFIG_AES) += test_aes.o
>     +obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>      obj-$(CONFIG_GETOPT) += getopt.o
>      obj-$(CONFIG_CRC8) += test_crc8.o
>      obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>     diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
>     new file mode 100644
>     index 00000000000..ca072f97226
>     --- /dev/null
>     +++ b/test/lib/test_sha256_hmac.c
>     @@ -0,0 +1,294 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +/*
>     + * Copyright (c) 2024 Philippe Reynes
>     <philippe.reynes@softathome.com>
>     + *
>     + * Unit tests for sha256_hmac functions
>     + */
>     +
>     +#include <command.h>
>     +#include <test/lib.h>
>     +#include <test/test.h>
>     +#include <test/ut.h>
>     +#include <u-boot/sha256.h>
>     +
>     +struct test_sha256_hmac_s {
>     +       unsigned char *key;
>     +       int keylen;
>     +       unsigned char *input;
>     +       int ilen;
>     +       unsigned char *expected;
>     +       int elen;
>     +};
>
>
> Should be 'const unsigned char *' for all test data.


Ok, I have added a const for all data.


>     +
>     +/*
>     + * data comes from:
>     + * https://datatracker.ietf.org/doc/html/rfc4231
>     <https://datatracker.ietf.org/doc/html/rfc4231>
>     + */
>     +static unsigned char key_test1[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
>     +
>     +static unsigned char input_test1[] = {
>     +       0x48, 0x69, 0x20, 0x54, 0x68, 0x65, 0x72, 0x65 };
>     +
>     +static unsigned char expected_test1[] = {
>     +       0xb0, 0x34, 0x4c, 0x61, 0xd8, 0xdb, 0x38, 0x53,
>     +       0x5c, 0xa8, 0xaf, 0xce, 0xaf, 0x0b, 0xf1, 0x2b,
>     +       0x88, 0x1d, 0xc2, 0x00, 0xc9, 0x83, 0x3d, 0xa7,
>     +       0x26, 0xe9, 0x37, 0x6c, 0x2e, 0x32, 0xcf, 0xf7 };
>     +
>     +static unsigned char key_test2[] = { 0x4a, 0x65, 0x66, 0x65 };
>     +
>     +static unsigned char input_test2[] = {
>     +       0x77, 0x68, 0x61, 0x74, 0x20, 0x64, 0x6f, 0x20,
>     +       0x79, 0x61, 0x20, 0x77, 0x61, 0x6e, 0x74, 0x20,
>     +       0x66, 0x6f, 0x72, 0x20, 0x6e, 0x6f, 0x74, 0x68,
>     +       0x69, 0x6e, 0x67, 0x3f };
>     +
>     +static unsigned char expected_test2[] = {
>     +       0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
>     +       0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
>     +       0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
>     +       0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 };
>     +
>     +static unsigned char key_test3[] = {
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa };
>     +
>     +static unsigned char input_test3[] = {
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd };
>     +
>     +static unsigned char expected_test3[] = {
>     +       0x77, 0x3e, 0xa9, 0x1e, 0x36, 0x80, 0x0e, 0x46,
>     +       0x85, 0x4d, 0xb8, 0xeb, 0xd0, 0x91, 0x81, 0xa7,
>     +       0x29, 0x59, 0x09, 0x8b, 0x3e, 0xf8, 0xc1, 0x22,
>     +       0xd9, 0x63, 0x55, 0x14, 0xce, 0xd5, 0x65, 0xfe };
>     +
>     +static unsigned char key_test4[] = {
>     +       0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
>     +       0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
>     +       0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
>     +       0x19,
>     +};
>     +
>     +static unsigned char input_test4[] = {
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd,
>     +};
>     +
>     +static unsigned char expected_test4[] = {
>     +       0x82, 0x55, 0x8a, 0x38, 0x9a, 0x44, 0x3c, 0x0e,
>     +       0xa4, 0xcc, 0x81, 0x98, 0x99, 0xf2, 0x08, 0x3a,
>     +       0x85, 0xf0, 0xfa, 0xa3, 0xe5, 0x78, 0xf8, 0x07,
>     +       0x7a, 0x2e, 0x3f, 0xf4, 0x67, 0x29, 0x66, 0x5b,
>     +};
>     +
>     +static unsigned char key_test5[] = {
>     +       0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
>     +       0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
>     +       0x0c, 0x0c, 0x0c, 0x0c,
>     +};
>     +
>     +static unsigned char input_test5[] = {
>     +       0x54, 0x65, 0x73, 0x74, 0x20, 0x57, 0x69, 0x74,
>     +       0x68, 0x20, 0x54, 0x72, 0x75, 0x6e, 0x63, 0x61,
>     +       0x74, 0x69, 0x6f, 0x6e,
>     +};
>     +
>     +static unsigned char expected_test5[] = {
>     +       0xa3, 0xb6, 0x16, 0x74, 0x73, 0x10, 0x0e, 0xe0,
>     +       0x6e, 0x0c, 0x79, 0x6c, 0x29, 0x55, 0x55, 0x2b,
>     +};
>     +
>     +static unsigned char key_test6[] = {
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa };
>     +
>     +static unsigned char input_test6[] = {
>     +       0x54, 0x65, 0x73, 0x74, 0x20, 0x55, 0x73, 0x69,
>     +       0x6e, 0x67, 0x20, 0x4c, 0x61, 0x72, 0x67, 0x65,
>     +       0x72, 0x20, 0x54, 0x68, 0x61, 0x6e, 0x20, 0x42,
>     +       0x6c, 0x6f, 0x63, 0x6b, 0x2d, 0x53, 0x69, 0x7a,
>     +       0x65, 0x20, 0x4b, 0x65, 0x79, 0x20, 0x2d, 0x20,
>     +       0x48, 0x61, 0x73, 0x68, 0x20, 0x4b, 0x65, 0x79,
>     +       0x20, 0x46, 0x69, 0x72, 0x73, 0x74 };
>     +
>     +static unsigned char expected_test6[] = {
>     +       0x60, 0xe4, 0x31, 0x59, 0x1e, 0xe0, 0xb6, 0x7f,
>     +       0x0d, 0x8a, 0x26, 0xaa, 0xcb, 0xf5, 0xb7, 0x7f,
>     +       0x8e, 0x0b, 0xc6, 0x21, 0x37, 0x28, 0xc5, 0x14,
>     +       0x05, 0x46, 0x04, 0x0f, 0x0e, 0xe3, 0x7f, 0x54 };
>     +
>     +static unsigned char key_test7[] = {
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa,
>     +};
>     +
>     +static unsigned char input_test7[] = {
>     +       0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20,
>     +       0x61, 0x20, 0x74, 0x65, 0x73, 0x74, 0x20, 0x75,
>     +       0x73, 0x69, 0x6e, 0x67, 0x20, 0x61, 0x20, 0x6c,
>     +       0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74, 0x68,
>     +       0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63, 0x6b,
>     +       0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x6b, 0x65,
>     +       0x79, 0x20, 0x61, 0x6e, 0x64, 0x20, 0x61, 0x20,
>     +       0x6c, 0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74,
>     +       0x68, 0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63,
>     +       0x6b, 0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x64,
>     +       0x61, 0x74, 0x61, 0x2e, 0x20, 0x54, 0x68, 0x65,
>     +       0x20, 0x6b, 0x65, 0x79, 0x20, 0x6e, 0x65, 0x65,
>     +       0x64, 0x73, 0x20, 0x74, 0x6f, 0x20, 0x62, 0x65,
>     +       0x20, 0x68, 0x61, 0x73, 0x68, 0x65, 0x64, 0x20,
>     +       0x62, 0x65, 0x66, 0x6f, 0x72, 0x65, 0x20, 0x62,
>     +       0x65, 0x69, 0x6e, 0x67, 0x20, 0x75, 0x73, 0x65,
>     +       0x64, 0x20, 0x62, 0x79, 0x20, 0x74, 0x68, 0x65,
>     +       0x20, 0x48, 0x4d, 0x41, 0x43, 0x20, 0x61, 0x6c,
>     +       0x67, 0x6f, 0x72, 0x69, 0x74, 0x68, 0x6d, 0x2e,
>     +};
>     +
>     +static unsigned char expected_test7[] = {
>     +       0x9b, 0x09, 0xff, 0xa7, 0x1b, 0x94, 0x2f, 0xcb,
>     +       0x27, 0x63, 0x5f, 0xbc, 0xd5, 0xb0, 0xe9, 0x44,
>     +       0xbf, 0xdc, 0x63, 0x64, 0x4f, 0x07, 0x13, 0x93,
>     +       0x8a, 0x7f, 0x51, 0x53, 0x5c, 0x3a, 0x35, 0xe2,
>     +};
>     +
>     +static struct test_sha256_hmac_s test_sha256_hmac[] = {
>     +       {
>     +               .key = key_test1,
>     +               .keylen = sizeof(key_test1),
>     +               .input = input_test1,
>     +               .ilen = sizeof(input_test1),
>     +               .expected = expected_test1,
>     +               .elen = sizeof(expected_test1),
>     +       },
>     +       {
>     +               .key = key_test2,
>     +               .keylen = sizeof(key_test2),
>     +               .input = input_test2,
>     +               .ilen = sizeof(input_test2),
>     +               .expected = expected_test2,
>     +               .elen = sizeof(expected_test2),
>     +       },
>     +       {
>     +               .key = key_test3,
>     +               .keylen = sizeof(key_test3),
>     +               .input = input_test3,
>     +               .ilen = sizeof(input_test3),
>     +               .expected = expected_test3,
>     +               .elen = sizeof(expected_test3),
>     +       },
>     +       {
>     +               .key = key_test4,
>     +               .keylen = sizeof(key_test4),
>     +               .input = input_test4,
>     +               .ilen = sizeof(input_test4),
>     +               .expected = expected_test4,
>     +               .elen = sizeof(expected_test4),
>     +       },
>     +       {
>     +               .key = key_test5,
>     +               .keylen = sizeof(key_test5),
>     +               .input = input_test5,
>     +               .ilen = sizeof(input_test5),
>     +               .expected = expected_test5,
>     +               .elen = sizeof(expected_test5),
>     +       },
>     +       {
>     +               .key = key_test6,
>     +               .keylen = sizeof(key_test6),
>     +               .input = input_test6,
>     +               .ilen = sizeof(input_test6),
>     +               .expected = expected_test6,
>     +               .elen = sizeof(expected_test6),
>     +       },
>     +       {
>     +               .key = key_test7,
>     +               .keylen = sizeof(key_test7),
>     +               .input = input_test7,
>     +               .ilen = sizeof(input_test7),
>     +               .expected = expected_test7,
>     +               .elen = sizeof(expected_test7),
>     +       },
>     +};
>     +
>     +static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                    unsigned char *key, int keylen,
>     +                                    unsigned char *input, int ilen,
>     +                                    unsigned char *expected, int
>     elen)
>     +{
>     +       unsigned char output[SHA256_SUM_LEN];
>     +       int ret;
>     +
>     +       ut_assert(elen <= sizeof(output));
>     +       ret = sha256_hmac(key, keylen, input, ilen, output);
>     +       ut_assert(!ret);
>     +       ut_asserteq_mem(expected, output, elen);
>     +
>     +       return 0;
>     +}
>     +
>     +static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                   struct test_sha256_hmac_s *test)
>     +{
>     +       return _lib_test_sha256_hmac_run(uts, test->key, test->keylen,
>     +                                        test->input, test->ilen,
>     + test->expected, test->elen);
>     +}
>     +
>     +static int lib_test_sha256_hmac(struct unit_test_state *uts)
>     +{
>     +       int i, ret = 0;
>     +
>     +       for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
>     +               ret = lib_test_sha256_hmac_run(uts,
>     &test_sha256_hmac[i]);
>     +               if (ret)
>     +                       return ret;
>     +       }
>     +
>     +       return 0;
>     +}
>     +
>     +LIB_TEST(lib_test_sha256_hmac, 0);
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond


Regards,

Philippe

