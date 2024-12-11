Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DB0E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696848033E;
	Wed, 11 Dec 2024 17:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="VX7ctlYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCCE80362; Wed, 11 Dec 2024 17:03:31 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB2B80323
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 11 Dec 2024 17:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd8DKt5d4T9ep4HM5SqG1jc1HXFGRSYv3rovn0cgRx7ggPU0FiG90x2UoxogWEH4gwNlSzI28NfkJmW0mr9wG9N+5CEjjbha11St0BEcW7Xlmr5D6LnvivIzqgxB6mtZXo2xoBY+HbHqMscWg1TOUUAi67hYXc1voS59T8SEAeTmjN/dl5gVlsPQ1oML7OgQg8/p/3IhxjtIyHmpRSsEjZ8bQmSxjGx7WlaZq1UUYCZET1xjwB/bleoiJzltsrCmDHL2+9XkIQESfmqND0Q0QSyvGT5iMzpgN3qR++27q+GPc9vltRnwTAEKaBc4+iaCJOmRTFFUTC5GNnokzYDEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJS1c9/FfVFzbYnQmndL4aNfM/CxpiG8QDtY+qeMRv8=;
 b=u2r6A2XSRq9/Wc0TJdmcvQMS+p70j1HFsTcceFdDvuU3DnD/i0/Ruduf0gT4Rc+K8K/UOlqdbmDeZ5Z/Mqk5FvslF+DhFwP1//qd+CY/K2TAwYtgVG5315PBylsIqi/sjo1oBe3DCAXzVgKYcCQyv8pVVC5aeBxVTEsRtf5R95pPiBKroZZi6Qwob46lxLAwGZ/xuPIsfLtopgl+MI1ktzVdtARpvJG6Q4DgF+k/oIGOB+CFEcM96n4yjSSKNBCWqxEsQyBKCfQDIxEYYlNCVzFsr5NN6ipsHUH+P6qPdpJrxHRcDrEWCEyygzAiC9hPGT2YML8yy1xz8VbTVIhBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJS1c9/FfVFzbYnQmndL4aNfM/CxpiG8QDtY+qeMRv8=;
 b=VX7ctlYGtyub+dOJH35KoLrsUpD3QL9Her0eEkcIMcqRYKrJQm+p4RXnj4S8L/IBwmZViV+yEK7h1q4PX3VmAiC+nPtPLUhv1v61PN65AvaTFJghOVXVmJCj5ZDJxaUOzLhSUiIwOhv8NWe+RsuqgK/L+V2mddLGRcQMITmSeOw6m5LnTNVbkF4SuCaf2hqPupWRxcnVKVhxg1RdpBLkHjnWs4l1b14T5sW5YrYxEdBJVcW7Vv2Rl8YWn2cMO6MVzvQqJOa/s9gj+hP+drIFtQZgQpeIiVT7A2M0xy4VOTvHtncZVFwSzf58OnhNB8x2TZyti79sqoRJMiG5NQVkgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR0P264MB4910.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 16:03:26 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:03:26 +0000
Message-ID: <0cc06147-0378-4428-9225-5a76027edaa3@softathome.com>
Date: Wed, 11 Dec 2024 17:03:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] lib: mbedtls: sha256: add support of key derivation
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-5-philippe.reynes@softathome.com>
 <CAEfUkUJ7OwWrFpzwMPsf0+iPcDht6iazKHDpStksDCAf3FR03w@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkUJ7OwWrFpzwMPsf0+iPcDht6iazKHDpStksDCAf3FR03w@mail.gmail.com>
X-ClientProxiedBy: PA7P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::19) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR0P264MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: ea88dae8-9046-4139-91e6-08dd19fd58ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBSMWZYWGkvVUJjTG1Jbzc4U3hLTXJJS0cwQzEvWTVtcUIxWmp6MVVHTmZ4?=
 =?utf-8?B?MWRSVmpMN2FGS3pqSDJiOTFYT0RUb0ZlRDRPRGhOS3Z2VG90emFma0tBNy9B?=
 =?utf-8?B?eU1OS1B5cit0SzBmVEZWQ2t6S0piNzZpRnArcTdGeHZZOU1rcUtFMHRsRUZN?=
 =?utf-8?B?bGdDWi9NRloxK3VUQU1IZW1CZDhRdmh0dTNWeDgyMDQ0aFFwR2wxZHNTMVpG?=
 =?utf-8?B?MkRQUnJQaGJ4NEUxQmswQ25YMHRSOGxMekQ2VTdDSW9ramwrNzhuenZLcWhs?=
 =?utf-8?B?Q1NBT2Y1Y2lqQU5VUysrRkNXN0hFMDFkS1h0a3M5YTZXbUkwbjF1MkpzNUpG?=
 =?utf-8?B?ZE1sdkg1WGxjUmdrbVZZdzRhS2NsbDdVSG5xR1pXRkJPRjVzU25JQ3pKdDBH?=
 =?utf-8?B?MW5HS1FVQW1DK2E4MHMrcldpaXoranErRlY5NCttZW16dTNyZXQwaEh4dDd5?=
 =?utf-8?B?ajRWbndYd05FQ2YxeDBPR1JRMTFXK21rWGo5UjNyZ05TRkN3cWh0ZG1rM0JB?=
 =?utf-8?B?bVkvMy9qWWt2NDdNT3o1UjJGcTBrbmplUFNrYkVFdllHZTFVa05jQXk2bjFK?=
 =?utf-8?B?dnkvb2J5R1Z5RWQzWDFqUEhENW55OXNzaG9CZTBqcW5pYTVYQ1hKTzRtdytj?=
 =?utf-8?B?MHcvVWQ1VkJqQjdvNzFKUU0rU0l4QzlpM01ZdmRyMlloemQrSlpCRXBEa0JG?=
 =?utf-8?B?SnVLQlJjMVJCVXpLQkZZcUFlSVBZK25uN1dSSU1FUGRMc2hNZCtNcHBSaFRw?=
 =?utf-8?B?QWhHSTJ5ckVzUG9IVDhiZjJXVndNU3pZYUFDbThTaTRwYVVmR21pRXVxNVFq?=
 =?utf-8?B?RU9tQSs0SUdEQnZLbnVybkZ1aHhyOGlSQnI3Skl1cEJoNis0U0VOVXZVWjM0?=
 =?utf-8?B?cmtWOFVhTy8wRnBMRzlCaWFMWTVaNGFEUWtZOU9YdEdqRjNQY2IyZXNGZE9H?=
 =?utf-8?B?RndhYytobE9OUk9nRWo3dlhqei83VHl0UjBSbU5vcDI2RkZkQnBISytFVHNz?=
 =?utf-8?B?SWF1Q1ZRSFRTMUx6Q2JkMUZNek9SL2FiRGU2Z1JaaCtVUnZaSTM4ZFdwdTJo?=
 =?utf-8?B?a1pLdG5rWFgrUnRFbkJpbjF1NHdnb3I5cWpBam9IQUl1enowN0puM1A5N2xO?=
 =?utf-8?B?RHZ0YkpjWHc5a3Fsb2ZNcDA1MndxcURmcGhnbVVsUlUzU0Y3bzFXS2pDY2c0?=
 =?utf-8?B?TlNqMkZkREhUMFA2bkhObUwzN0t5RkVVUDVsVXNWT0tkbVIxSFdkWGJPMzdB?=
 =?utf-8?B?TVlGTEVCQVBqakh2aTRuSlBLb2VTbEJ6eGNjKzhZbVRnWlJOZkFhVHZzd3My?=
 =?utf-8?B?VzI5cVZGL3I1aTNPZ3YrRHVaZDRQUDV1Q0dnMXY5V3lnZ24xQTFwMURhSmV6?=
 =?utf-8?B?THJTb0ZvdmZkK1c5NU9NMFJDRm96MG5rWlUzaDNQUS9QREJQWUxjRW13YkI2?=
 =?utf-8?B?TWNXWmxueTFhb1dFMHVjbnNXdGRXRFhyYXJLNm9RUWpHMG9yVWZhc0NsbW11?=
 =?utf-8?B?T2RNVDlYcUt5bkxKUUlKYVhJYkE0dTNxMW51NXNwQWs3aHl6K1Z5Y0EyQzNp?=
 =?utf-8?B?VjlyZkQxZ3VucWhNYVVLYzN0dmdraGd6TllqUDMzUmlQZkRKbnBsc0VCNER5?=
 =?utf-8?B?ei8yZHlRTzQ0SXVQeTE1V2xEbGZKcUs1Zmd4b1BkcVlDSm1iZnBrOUNBN01y?=
 =?utf-8?B?d21sV2JxTlYvNG9jbXpmTWErbDkxdzBJdTJtUG1ibmtCREg4TzYxcTBWekl1?=
 =?utf-8?B?Y25VTVY4endzam53emFwd094R0tBd09PLytuTmZyTGxDa3VRTzR3Vlc2S1Fs?=
 =?utf-8?B?eGovbFd2aXVFdENOenVEUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU44WGZrOS9SY1hreDRNV0J0Zmt2MjJYcUFRV1VEZFNYWnc2dFJ0TnVVQ3M5?=
 =?utf-8?B?N2YyU1FJdnN1Y2FINXc3Z0hQMnVtTjFkSVV0UFhjbHRtSCtNclU1T0UyY0Jx?=
 =?utf-8?B?blhlaWRUOUpTTnN1UkVjbDkzSWllVFVPRzRRQ2NHZlBmTTNZM09uZHNReVJH?=
 =?utf-8?B?bzIwbWFjNHJORThNenJhRHQxN1BNeG9tWENvQU13S09SS21BWGVQT1I3MXhj?=
 =?utf-8?B?RnV5elVWY1UvT3BwbXJxWVJRdlZDSS94WmF6dDRKRmV1ZXpPcngzRFlkam04?=
 =?utf-8?B?YWdVY3RDWVhjdElNWTA3empwd1FORnVma2NieEwxRlhEOUo1eVZYOHNiT1F2?=
 =?utf-8?B?LzV2RTdkZnh1VGtoZHBPQmJyRVl6T3RPV0ZmeDdvY09PQmlxNG0xSHdSN3Ft?=
 =?utf-8?B?Y0lRcDl5ZVBldHBUdHNWWVlBeHpzM1h1LytTcHhYamFIQU9FRjFaL0dOQ3hs?=
 =?utf-8?B?RWllMlVCM3pFWnZGSFlnMlBsMnBJcTF2b2VNaTVvMEtocGEzUWpIZjBnUDBO?=
 =?utf-8?B?VmlWSGRhUWZUZDdUaG1vY3Q3c3Y0T0UvYlFnWS9xSzRZUlM2eVh2TlpWMUtN?=
 =?utf-8?B?STVWM1hJTmZyclFZYS9rU0RoZStnU1RwU0FqRTRiKzU4ZHlsU1JkTTNjVHBL?=
 =?utf-8?B?N1A3cEl6SC84OGxJMHZLb0ZoUWE0QU9IVHU0SmN5QzMxMVNtTi9PTkQ2dkRP?=
 =?utf-8?B?MENiWHg5cWFaMERVQlc4cU4yMThSZG01QVprK0RhZGM4Rzd1UDFpc3NuK1U5?=
 =?utf-8?B?V0VoN055dHprUDFCV1lXUlZ2ekhUSXJYUkY2b2ZWcVR4c0NmYkM2ZG1RUmlS?=
 =?utf-8?B?d2FxT2o5VWMveHBGRHpUb1NEaVdpSUh5cXZLZm9FQWhubGxuS3F2cDl1RHNB?=
 =?utf-8?B?bXlldTZpVHcxeUV0b0t2ajVON1Fyamh0ekFVdWV1dXRJWUYwZEdmZmlRS1RX?=
 =?utf-8?B?cngwbW9NRW05TlFqbm5hVzFpcVZoOXhPRmswSGRuMW1JWGJSaFpVdTRJTHU5?=
 =?utf-8?B?VlgvRTlKSERLZE03aG9lWkltcTFZcVJ1c2F1TUp5OXJqMC9VRW5aSlVnaENR?=
 =?utf-8?B?Z3JJR29MK0pTczVjYXlmelhHTTNnNDZMdjdaYkZ6ZTM3d0FxUy80NlRNT0JB?=
 =?utf-8?B?WE5UWGlUU3R4bG9CUkdDTWp5WStaVkFIaUdUMkk5L0xtTlZkQXZHR3pPWXNT?=
 =?utf-8?B?TjdWZlJvOHRqNmtVcWp3NWtFWElDd3owR2VUQnRjcUtZbnJwNTdUWVBPQmRO?=
 =?utf-8?B?S2xaWUlhTkJ6QnZaVURhZEMxVmlmQlR6bkx6b0pNcVBpdlNCRzFTcVkwSGJY?=
 =?utf-8?B?OWtObzQ1UzI3UDdyWm5xdlMzMVd2V3FOS2FOdTZLbFd4OUU2TDFQTlJiNUlG?=
 =?utf-8?B?MFhDQjRVaHRWU0pXSkF1WDJjUFlmeGYrMGZJN3VYRXFldUI5dDBLMlNjbVhv?=
 =?utf-8?B?VkRKV0d6bmc1QkE4RVM1VVcyeHo0MU1XdW1UNXQ0ZTVzeithU2RsUmQ2NmRH?=
 =?utf-8?B?RnZoNFFmbzZEQ3VVdXdQUDBuVVJ6UWRDVHR6b3Npais2WWRRODJVN3BoWVNT?=
 =?utf-8?B?ZjhHdHVTeGtoRzZESmsvcmtuaCtScVdGSVhoam1ZQTVRdmd3Y0pmbDNTZ3lL?=
 =?utf-8?B?UjM0RzVHOGxsMFA0UlNXS2h1MU5rSEMxSnI5NHNXZ1Fjc1Z2MUJQUndnandw?=
 =?utf-8?B?dTAvZmNIa0FNaHpmazVUSlk1N2tuODZVUnJOVzk3MkpRY3JmR1Vpamxna3JM?=
 =?utf-8?B?bWZKeTdDeG9sZTZYUjZGRW5BU0x3ZDJROGMxWjhMUjVVdmFwaC9MejBkSktm?=
 =?utf-8?B?UnR4dUhFMGMwdzVkQjhXRlA5OG5BVjNWQUpPcldhZm1aSGdJREhRYmp2QWVp?=
 =?utf-8?B?a21WK085ZHR0YkNVTzB5My83YVdWNGRleFRSejNVN1pQbFNkOG1wVWFNS3hs?=
 =?utf-8?B?eTdSSHQ1c29naUFhZEdEcktjRENNdzIxRzkxUG4rc1lJc2wwYUI3aXFGMjVN?=
 =?utf-8?B?Vll3d0loQWxSaDJCRm9pQ2x4NWcyMlhMaHlMVzlVM0ttNnBEbXBNRTJ3NEha?=
 =?utf-8?B?eGlYaDU0RU1HVmNNWlFONGtoRUJUekxPclh0S1VRMEFycUpDQWRWVzZ0ZVNX?=
 =?utf-8?B?UUJvN2tTNXQ0dUp6eVlla1BtZ2NOOUpBWlhJcWg0ZzhRMnJUWmR2ZkEvdm5K?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea88dae8-9046-4139-91e6-08dd19fd58ee
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:03:26.7607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/e8J/X7BpxtXLjevmhFgWyeFhCHWJ80Y7/mKPHQVcKvUCvB+fjSPGHPMqhNU/3dM3RdtmGmxTMH1jC9ljI55PcLUB52OQTvDHU5sgLkqkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4910
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


Le 09/12/2024 à 17:28, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Mon, 9 Dec 2024 at 04:42, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of key derivation using the scheme hkdf.
>     This scheme is defined in rfc5869.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      include/u-boot/sha256.h |  7 +++++++
>      lib/mbedtls/sha256.c    | 22 ++++++++++++++++++++++
>      2 files changed, 29 insertions(+)
>
>     diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>     index 2f12275b703..5643efcb85c 100644
>     --- a/include/u-boot/sha256.h
>     +++ b/include/u-boot/sha256.h
>     @@ -49,4 +49,11 @@ void sha256_hmac(const unsigned char *key, int
>     keylen,
>                      const unsigned char *input, unsigned int ilen,
>                      unsigned char *output);
>
>     +#if defined(CONFIG_HKDF_MBEDTLS)
>     +int sha256_hkdf(const unsigned char *salt, int saltlen,
>     +               const unsigned char *ikm, int ikmlen,
>     +               const unsigned char *info, int infolen,
>     +               unsigned char *output, int outputlen);
>     +#endif
>     +
>
>
> I think this will be better:
> #if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
> int sha256_hkdf(const unsigned char *salt, int saltlen,
>                  const unsigned char *ikm, int ikmlen,
>                  const unsigned char *info, int infolen,
>                  unsigned char *output, int outputlen);
> #else
> static inline int sha256_hkdf(const unsigned char __always_unused *salt,
>                 int __always_unused saltlen,
>                 const unsigned char __always_unused *ikm,
>                 int __always_unused ikmlen,
>                 const unsigned char __always_unused *info,
>                 int __always_unused infolen,
>                 unsigned char __always_unused *output,
>                 int __always_unused outputlen) {
>         return -EOPNOTSUPP;
> }
> #endif


I have done this change in the v4


>      #endif /* _SHA256_H */
>     diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
>     index 1b9fc1a8503..6e9659d31bb 100644
>     --- a/lib/mbedtls/sha256.c
>     +++ b/lib/mbedtls/sha256.c
>     @@ -11,6 +11,11 @@
>      #include <string.h>
>      #include <u-boot/sha256.h>
>
>     +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
>     +#include <mbedtls/md.h>
>     +#include <mbedtls/hkdf.h>
>     +#endif
>     +
>      const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>             0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>             0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
>     @@ -98,3 +103,20 @@ void sha256_hmac(const unsigned char *key, int
>     keylen,
>             memset(tmpbuf, 0, sizeof(tmpbuf));
>             memset(&ctx, 0, sizeof(sha256_context));
>      }
>     +
>     +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
>     +int sha256_hkdf(const unsigned char *salt, int saltlen,
>     +               const unsigned char *ikm, int ikmlen,
>     +               const unsigned char *info, int infolen,
>     +               unsigned char *output, int outputlen)
>     +{
>     +       const mbedtls_md_info_t *md;
>     +
>     +       md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
>     +
>     +       return mbedtls_hkdf(md, salt, saltlen,
>     +                           ikm, ikmlen,
>     +                           info, infolen,
>     +                           output, outputlen);
>     +}
>     +#endif
>     -- 
>     2.25.1
>
Regards,
Philippe

