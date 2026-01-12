Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D9AD2505E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5068383CBD;
	Mon, 12 Jan 2026 10:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o7UhsEks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8ADF83D13; Mon, 12 Jan 2026 10:33:40 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8484983CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb+xE3EYn6+DCqm+zRUfrHRYCBw1qvz2kFzvk7JiL4FdN/ZC4ctQLInJCc72vpWIu7JH2MvCyRkbKt24Mz7ADEFc8ULwK/No1CNCXR37/Jh0Lnuafc6k6Bu+WdAxC8LH7KfdS7PB4S8TVh4wns5dE70+cvu64HaBOpZRWdRl86Kmuyf9W1DpNZMwaBEjB8RZa9em4BAKthPMakcN/ZhvzoWOAwcGF46VaAx13UMfq+hHLyfJn7KMsva3csk1fbI6gxYSS8HCFP/Fy8KTkNSK1LQGaVAiA5VqM0u5nt1huARs4SppU2Z7a2Gp4+dtW86ZiMuvwm5+OAINWOqMEgmCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMg6YcZ6EN5Ufb7hzBBrsJHD9EzRsLlii84+zd5oy8o=;
 b=s7pNMjj7nK+kSmifGD1AR2PK+YiNMNsmGS9eM2IaEe8Vdk1rJfaUwsQ/U/n//CtfVoTYLoP5pQ84fUU6O8dD2Ph/hu4NSr1KefTuGps67XV5wcSAcfhLHwkgyJj8qYqnB1bvuPqFJxjfVrK9Ng08FcaiCZgp9tI6w8I6Z9AWFAlgYx6a5xcvm2dhX/tgMx9p4VT8u2GuEEKb67C/JSMe+spMZ+VhZ3OclE/IaiT+Opv1iCpPnzN5roVzqsSpa4jd01lp+3kVQoAzxj20BacbKcELYs0nSnTWLcRVArsswaKHbAghw3QQvuMnKLpzJjFdq5B0M7bQtNbbMbaYuRUfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMg6YcZ6EN5Ufb7hzBBrsJHD9EzRsLlii84+zd5oy8o=;
 b=o7UhsEksLPgoPWRuoMjQASaBhPqdW6NtPZ3MbhzvLd3EO+ORey2yYssG6cIgvjRgJsdeM7wy3Q/WLYN6rcFCY/lL9rVBUa7Rw+T/3xTqOYWjVPWKtkH8/RXN0KVMgq/rd5ee8i/CUXmc3UFhpG/dOWpz2h7252j9q9Iy1yNR7D4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:33:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:33:35 +0000
Message-ID: <c6b7c743-5124-4ac7-9359-9a2614188f73@amd.com>
Date: Mon, 12 Jan 2026 10:33:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: xilinx-nwl: Avoid crashing if configuring when the
 link is down
To: Sean Anderson <sean.anderson@linux.dev>,
 Stefan Roese <stefan.roese@mailbox.org>, u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <20260106220853.731358-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260106220853.731358-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1c12a2-0425-4a8e-953b-08de51bda8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2R1dlpVTTkwcnI3SElWWG82MHFOQU9xa2ZzVUtUUHZLOHArbmZIdDVza3Rq?=
 =?utf-8?B?TERjZDQ1NFByZzlVQlM2Vml3dTFHSDVMcGhoRUtoNE1COW81WG9SWjRFd2FL?=
 =?utf-8?B?R09QZkZia2RyeVZZdlZGS3c3VG5ja3prN24rMzBsc05XQXZWTmRyN0pzZXRa?=
 =?utf-8?B?cmJZNFhjakQyeHRPZU1zWWNuOFZBS3E0Y0xxL0VDTjYyMHJWeElNbzIvTXJL?=
 =?utf-8?B?ck0vMWpDS29kdCtSMnd2OXdDMVZyT29QbTQzUGVpeFEycGduV2xkVkpHcUJO?=
 =?utf-8?B?dmV6K083YU5oSkMySkZYc2tmVnBIbDh3TGMxUEo0SENGUlJRYlh3UFJWdjkv?=
 =?utf-8?B?eGhBOFNVSzJBZWRqdUpORmNYdkVEVXNCOWZwTklNZkN1ZnNtVktDbEpyd1dr?=
 =?utf-8?B?MjVWMDZvb3hGaFJIanc5U2JSc3pKeCsvb0NzVzd1YzY1VVcrekR6aGNBWEEv?=
 =?utf-8?B?eHdEWkQxQkdNUXdwSWF3KzNjbGVaSGNDYTZ1YmM5enBQMlBWcVUvVUFrL2N3?=
 =?utf-8?B?a085c2R0N3cwKzlzR05WL3dxcDRLczJaUklJcFJLVUUvQ3VpQnpSWWN6N20x?=
 =?utf-8?B?SDVxTUN5Z1p0S21QandkZVByWDBueCtOdUJLM1htend3T1BUYndJK3UxN0VD?=
 =?utf-8?B?Q2xJeE5iOUpIMEsxeW1jSFlVYWp3VzlWSDVvR0pVNWhKSUpQMTd5NHAwaklt?=
 =?utf-8?B?OWYzM3dnaUUrTzZPeC9pUTZkaGJzdk1Ma1NVT1Mrc0tsM0hQYVdPbmdhVmlm?=
 =?utf-8?B?Q0swaDBJYnBCc2tKWUpGMlNVRE0yMDFzZzZLK3FHMlJiNHJFRTkxZUorKy9n?=
 =?utf-8?B?MklMd2dJVGhiNWZqQTc1a093NjZOSW01VnpzYmtWc2UwVjhJVjBHNVI2eTJ1?=
 =?utf-8?B?RUViZXI0SWtHVnloWkNnK09rMlRNSmp0c0V2VmpOT2hJRDd6MjZHY09ZRG9E?=
 =?utf-8?B?UGJaMzNmRWUxTEJoOExEVnllMERGTndrSnVZYUhnaUxWTUNtdHVZUWZhTmY1?=
 =?utf-8?B?Vjc2L0wyRllkMUtId3lLOGFmcy83NnZYYldBdnlEVE1XQU9GbFRFSnJqRHhO?=
 =?utf-8?B?Q2NycExzYVFiaXh0WUJyTjNaWnVncUROdWV6WHU5UUVuRjZIRnlObjVuV09k?=
 =?utf-8?B?VjhJUmZNNFpJWFdUYnNpRGNSWitGbGE5UmI3bmk1VG9OUVY2aFhHbDNVa092?=
 =?utf-8?B?dWZpU1FORTFNam03RWVvcWgwQTRwS0x6U0lrRm41a3V5YmZXMEFhdlJST3hI?=
 =?utf-8?B?V2E1Kzg5cjNjMXdtUzVGcFloQ0w2MVpuclR2MUYwblFuQ28wQkN5UzczT3Zx?=
 =?utf-8?B?dzc0bWJSUXRMdDlkVXZYWWh2UWFBbkd0WGE1WHhRRy9mRXFtVnA5eDczdVFT?=
 =?utf-8?B?WlRMT05zZDVZYS8yRllqalRUV0JwUzNSUGxFVVNQdXo4eVRzek1uVEpYNnd1?=
 =?utf-8?B?dFpFME9kZWJaWVRTekwrRU1aeWRraVZha0RwS2dCRzE5eWMzOGk0aDVHaHBH?=
 =?utf-8?B?ZGZRYXZCc1Zyem0wY1V1OUJLTDFVRi9LNEJKRUt0R0J5VCs1UFNnUlNSOXdH?=
 =?utf-8?B?V3RVekprWm5mNUM0RHNGMHIrVzQzVjZobXJIaVZseUZoOWErQ01acGZrODBC?=
 =?utf-8?B?SktoVVdpM3NybnBidXUyOG5xWTRUZXVHTTQwcDBseFcvWHRVdHVPTjQxTUQr?=
 =?utf-8?B?eVlHMFZIUUh0QlB2QzcyUjRYWUs5SjRudEhrUnUySTVweTVtdnYxRmoyMThN?=
 =?utf-8?B?RFVxa3JidWx1NGZLbk42R0V1eDJOeXRJNWlQUGVKcUhkbzEvZHlNYnhDY0Fu?=
 =?utf-8?B?b2xETHJsb09nZW5oSFhYcEVoU2EzbDBSNHpuVVNxajhzNG1NT0Y0NkxtUU5Y?=
 =?utf-8?B?WFdXSmpzYzExU1NROG5mek9DbTY5V3ZYV1BrZitxeWpGVVRHbG1WVGVNc0Zx?=
 =?utf-8?Q?67IHXkBmKua6v4Ln0rTYNg71f41jM2H9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFjcDR5bm9paVBEcUtkTy8raXlQb1QzVUZTUEhOUGJHMHd6NFVBRGUxUk9j?=
 =?utf-8?B?UFR0ajlrRk1PZkwyUmZNYWUwQk5KUXhpd3RESWdPRXFONDV6S1lweDVnVHpn?=
 =?utf-8?B?SWN0djZsWEt5U3d6K1lQTEZiQzdndU9UU3I5L1hQL09uOGJ5UEpmckszUkZy?=
 =?utf-8?B?M1RlZXBsWGYwZElDcHpjUnlDY1YwUGFLaWlkdDcybUorZ3h0SHFUUmx1azFl?=
 =?utf-8?B?NTZPYXg1Y1dzTHZIS3M4dmo0Y21zY08xMVNMUTFITzhlTHluc3ZkU1JiNENL?=
 =?utf-8?B?Z1ZhMCtheG4vVFEwYXNmRHdXekJhYURrQnhYSFN1TnZWZUpXb1ErZDdJSjNy?=
 =?utf-8?B?RXdySFo4dkhwdG8rYk1jZXJURkhNWXF5R21EYUxDeUpmTXUzcFk3Sm1ORG1r?=
 =?utf-8?B?Sm83M1ZRaE5hdytXQlVFY2UyRURLdGg0Z2NoVVpNajZocE1DRVJJaTAzbkhh?=
 =?utf-8?B?WEw0T011L0RsZzJFOTU0Y0tlWDNFVmw0djgwYWhkK04xUXRlZVlMYmhIcWtG?=
 =?utf-8?B?QkZsTDJSOEY2ZHFxeTBtQmtiOUIvdHBsc09wM0JPQTFVU1BrUmU2TVRDUldM?=
 =?utf-8?B?SC9OVVp2Z3ZSZG12MTJIdXpFVkR6clZTYjFVSzBaT2ZMMkhpQUs2OTJVL2w0?=
 =?utf-8?B?QmorVzlyenR5emFVcjd5NHZGdXZ1VEV2SWFXU3B1MTBKUExRYmErUkVRUG1K?=
 =?utf-8?B?RTlqeW1hRWZFRWx6N1MzVjFBRmhBaEJWVjdqYkxwanV0R0J3RUNQQzJob1pX?=
 =?utf-8?B?TjJTdHV2UjJmSGhIenk2VXRrcVMxVUNybExZL3hCdCtGVmdtVTlPZTg0VURW?=
 =?utf-8?B?aTltY3NiVlVocW9CSngxTlJTU1hTWVpFWDdnTU5ZNHRIRGpJZCtYQ09Makh1?=
 =?utf-8?B?MjNBbXE5blNmSVlON210MmMxUXRUbmdJT2tEQm9MSk5DY0piaDhBdFhnZlNY?=
 =?utf-8?B?ZlVTU0VsYW5wM1lsL0x5MWN3SjhQeU5CdDBXODljcFd3WEswb002alFkZGlI?=
 =?utf-8?B?N0RBNFY5S3R5dWRXY29hc0xPTTRKZjA4YlNTV2xDWW0xa1haRlN2eklpU2xI?=
 =?utf-8?B?YjQ1OGxUVmxsNnUwV1d4WWhJa2srTGJ0OGdFU2ZrekNpdmZCUGNNdE80bHdD?=
 =?utf-8?B?eFBsL3dRWjIzaWw5TTF2dWFOUjBrckJqeGdyUnJYKytWTHJHVXVBOWJtZ0Nz?=
 =?utf-8?B?U3l3NVBjcERxOVJSZG1xWEdyazVMVnI2U3ppeG9mVXY4Si9aSjhhcGVkRnZG?=
 =?utf-8?B?KzdveE5sbGxPRFNTS0JYZEdoVmlUbkVRSU1Eem9FY3pwbGdlZmJ1bU9FK0lq?=
 =?utf-8?B?NGNCL3g5VjJMOWtrempMckhXL0E2UG1YNFo4Z3BZTW00d1BmWmpLUzQwWEVZ?=
 =?utf-8?B?dUpkcG1BeXlXU0xEeUNKWkYyVVUvY0pHOGtvdE4rMnJYV3BaeVJUd2pSVzBD?=
 =?utf-8?B?YTkyQUg4dXhKQ2hST3U0ZFoxa05RU2tJZHM0Vm1KaHMwWFE5MUUweWFyNjlu?=
 =?utf-8?B?Y0JNWk52dTY1QzVUTTdTUDZSSTlsSjRsVElvcVpDZCs5T1VpQjlkekhBMjJR?=
 =?utf-8?B?OUhESDFDTGtuSUJVTmVSTlJ6WE9qeHh4dDM1YVcvQU1JS3ZhNnpEeG4rOEV5?=
 =?utf-8?B?cWlTY3B1cE5xZUY4QS80M2hrZ29zcGhuNW04aGVIMkFhWGRiaUp4YmI3OG1K?=
 =?utf-8?B?Ykc0Y2E5V3NPRjcwUGJlMEowaHdWSGg5eXgyR0tNMitlb1BseWJDZGlOMEE0?=
 =?utf-8?B?ZVZsVlV0UW4vTm5lZVN0akk3MlFNVXJWY1dIeCs1T003Nis0KzdBeit2aDUz?=
 =?utf-8?B?LzgrNjBFaDhVMEF2VlpaR1ZxRWZBYml6bUsrNGNUVTRBOFB4bzNrT1huMyt1?=
 =?utf-8?B?TS9SMklLQlIvcmx5WU1Oam1NQ2dxZmpyeFlnNldDdHVCTzZiTndjeThZSzlN?=
 =?utf-8?B?OURaWDcvcVVFbE5jMDVaUjVLMTFMNUVXdHFNT2h0THNtZTlDdFFFK1o3Vm1C?=
 =?utf-8?B?cjdzMHVRUkZZcE82WUpQdE96a2lRaTNGckVYUjN3VHlFYlY5NHprbThwbDdQ?=
 =?utf-8?B?RG1DYmVWZVNYMmxIYVBPRG9JUzRaS0QxN2xqOExmNnFCRUhZbFNhZllWWFhu?=
 =?utf-8?B?eENHb3JuK1l0UzhXbEdlRkE3VndWc2FROW0rMTh5SnBvSjJFRFpnRXIxTTZp?=
 =?utf-8?B?NFYxRGlIeU5ZT1ZTUmFFc2p4akNMRDlKR09qS3p3a3ZYZnBnWi80OFExd3JR?=
 =?utf-8?B?VGRwc3RIOVdTdGw3eUxwS3U1djBXL1AxekNYNzBzSFprVEtLOE41NFJzVHVX?=
 =?utf-8?B?ekpRQTM3NjVjc1E5VGo3c01VcEdnTDlxREJEaFJ0OUYzTk9RS3k3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1c12a2-0425-4a8e-953b-08de51bda8a1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:33:35.3597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPhkXy7hDEv2p7clOIkvsjN/i/VQwMxISd0WLZolV0EBeynGk4GqfSAo5igltW5k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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



On 1/6/26 23:08, Sean Anderson wrote:
> The ECAM will return a slave error if we access non-root devices while
> the link is down. Add a check for this like Linux does so we don't
> crash.
> 
> Fixes: 2f5ad77cfea ("PCI: zynqmp: Add ZynqMP NWL PCIe root port driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/pci/pcie-xilinx-nwl.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie-xilinx-nwl.c b/drivers/pci/pcie-xilinx-nwl.c
> index e03ab3be912..ab597c83e47 100644
> --- a/drivers/pci/pcie-xilinx-nwl.c
> +++ b/drivers/pci/pcie-xilinx-nwl.c
> @@ -135,6 +135,13 @@ struct nwl_pcie {
>   	u32 ecam_value;
>   };
>   
> +static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
> +{
> +	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
> +		return true;
> +	return false;
> +}
> +
>   static int nwl_pcie_config_address(const struct udevice *bus,
>   				   pci_dev_t bdf, uint offset,
>   				   void **paddress)
> @@ -142,6 +149,9 @@ static int nwl_pcie_config_address(const struct udevice *bus,
>   	struct nwl_pcie *pcie = dev_get_priv(bus);
>   	void *addr;
>   
> +	if (PCI_BUS(bdf) != dev_seq(bus) && !nwl_pcie_link_up(pcie))
> +		return -EIO;
> +
>   	addr = pcie->ecam_base;
>   	addr += PCIE_ECAM_OFFSET(PCI_BUS(bdf) - dev_seq(bus),
>   				 PCI_DEV(bdf), PCI_FUNC(bdf), offset);
> @@ -181,13 +191,6 @@ static inline void nwl_bridge_writel(struct nwl_pcie *pcie, u32 val, u32 off)
>   	writel(val, pcie->breg_base + off);
>   }
>   
> -static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
> -{
> -	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
> -		return true;
> -	return false;
> -}
> -
>   static bool nwl_phy_link_up(struct nwl_pcie *pcie)
>   {
>   	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PHY_RDY_LINKUP_BIT)

Applied.
M
