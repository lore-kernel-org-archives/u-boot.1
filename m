Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743CBC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3234982F2B;
	Wed,  2 Jul 2025 09:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E79bB75z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795AB81FEE; Wed,  2 Jul 2025 09:40:17 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A098206E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yxli1gtMXMLY/8q1lC/gS8uKjg0bmyXp1blW+mmNf0K3hOz11qmqlCa736X8VbKMzqpPzmofTKgm0d4/TC4HUOZ8kJXGyJn1rZTagvNtS2qzB6WUnAFbpDZzd0x0JezPTdWwKN0VYxHl8pW86HQpZMH0Swrtgko5Npe/Dtz+0cR3MVWVVEm6eobs3qWaxQZq9aP4gqNxFwMz90gifFdiH8m/mi3cLnWEUiGQJwCCqh7/wa/LPa6tF/xZvpaYHnq2wHjnFVztaqTmw2C9qI6dq8iBbRoFC3/XP/Umc7XX2IoNe1ZcaKT6E8tF6PYQXWpbtzk2HYkjTTx75f6oiVVF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NCfTRtdJR3Z58XxfKzKg1RtH/sizk4fr+aSZD1RqEU=;
 b=bGgTaLq2BqRZH28UO1szqxuvXIO1xdYlIlqu5c9EIwMSxWKZ2mJgJaSbDN7kBG9hAkGX4S1WOiSuR9e8u/EqYxHrTIwLN/7j4GFs9opBw76/I31MXFrQ67843HPRWVGjZ0RJ2UsbFHRG8bVc7MPhcW3oRHwz5A8PpoVI1F26r1nhHTv/EdzEiZyQ3numwrUC3w9oX/eUKFVgIxFjodZjNp2KDPzBjwUDPGwmn9B/baeXRKrI8wl3oj25DapGuYCkPuBjJr7+sgyblmkYo7cDCrh+In03mW2PjkvzUYyNBDijfDkZP4Ypc6HaIcjBZqjZeqsvXa0HvILEKKBNdyAkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NCfTRtdJR3Z58XxfKzKg1RtH/sizk4fr+aSZD1RqEU=;
 b=E79bB75zxzBOwozFUDRXA1YXnjsHuXU8NZ/UxKBn0jeuAaOFcOztaRs3KUGPEBaWbXjJtigY6sh3lMzoM3oVA6HNwm6Zdo0Sm6lHQvHAap07JdTnwDXGWYWPI3xILNIwEzsMQKT4HQlwnsUDBJGtmFZlwJt5cvWNZB4x0amMBuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 07:40:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:40:12 +0000
Message-ID: <cc13116a-fb7c-40bb-807f-ff80324f71de@amd.com>
Date: Wed, 2 Jul 2025 09:40:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: fpga: intel_sdm_mb: Check SIP SMC status in
 send_bitstream()
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250701044311.3670-1-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250701044311.3670-1-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0232.eurprd07.prod.outlook.com
 (2603:10a6:802:58::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 26999bff-aec0-41f5-01fb-08ddb93baddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3hmOE5yQTUrcUlTYmsycWZOU29sejdvUXR6RXdvLzZSYkM5MHR5eWppTkh5?=
 =?utf-8?B?a1MxWjNrZUZDZTQ3Y25vOEVTZGhkb3F1bnFNK2xwSW1rL1lZZmlPR0FhZkhG?=
 =?utf-8?B?RGx2OUxnb2ltY1ovSFFvc1VDSzlmTG1jaFRKVmRXYmtjVlJhcnFmQjdOeURv?=
 =?utf-8?B?L1crQmlGNi9jT2hQanZ4NjliKzZwRHp5OVBjbUxHdnczRndGVEVTL2VnZENh?=
 =?utf-8?B?Um9DMGh4STZKcG91OFBjbFRlZGUwcVQ5cjVLU1l4UlY0MWFWWW1PRExjTEsr?=
 =?utf-8?B?dlRaSzBMV0syT1pHZEZpMFJWUzM5bTU4dWZZTys1dE9nQTJzQmJJUDhudzN4?=
 =?utf-8?B?Z280TzRocVNyaXlrclF2bWRia203Y0VKdWw4eGNSVmw2YTJadHdxM014SXVp?=
 =?utf-8?B?Ujk5Rjh2YUdRcldiY1lYc3BoRlRBTXA0Rjl0YVo5WVFaTTg5RklzSThwNjBX?=
 =?utf-8?B?ZGlnOEZkUG1UL2ovblUyTW4xRHdRQXdWUGdHUTJIa1hZdHUzMjIyMTdoOXJV?=
 =?utf-8?B?TU91UlZGNWZTbVloN1luQ1QvUEZBemlvb0hEbHJkNGpXK2FoMFlLQjVUUk9w?=
 =?utf-8?B?RFNsTHliMEk4bngyMzY4QSs2SEw4cFZaQ2kxSVFRSXQxSUtSUjBIQzZKbUtk?=
 =?utf-8?B?TkRXZmlzV0hEcm1xcXJOZXdKMG1sUWl1US8yL3h3MUtsUHYvQWFsczJUNDJt?=
 =?utf-8?B?T1hNbFZGZ1dTMzBiSkxYSHNyM2ZINmlHNGFUOVl5cnVjbUhZcnFSSFZhWEhG?=
 =?utf-8?B?MkxTY242cjFvdVdEOEZCNDJMZERibHVGaHZ6c1ZmY2FhelhxanIzZ1J3NVdy?=
 =?utf-8?B?WnVoTUZZQTFrYnZ6NFF1TldNdmJ6YmlOYVpoVlZrRER1UE8wZXVMUkhwdXNE?=
 =?utf-8?B?dGo1QTUvbDREZm03V1dKU1FoY1ZHZHd4UE50dXpuZEhOTmJlRUlvRHZXeUJX?=
 =?utf-8?B?Tnh1a2N4dE0rVGdVNzZHOTF6TWVVaTVHdEdudFVHNWo0R0pUNjZBMk53Y1BW?=
 =?utf-8?B?SUdNVmYxaTNjUHZuZmpNTFRvZWRqU1VvUkhyY3J5Y3c2Q3VUL0xDcDlsT2pl?=
 =?utf-8?B?QitqWk9hOW1IVkg4V3R1MW1KYVU4MHhMc1NpZHVrMmNSM085RndMUVkvY0E5?=
 =?utf-8?B?RmpYWFlpQ0ZnOUZIcDJ1Q2RRSkdjVjl0MFhUM1VUdHFjRkY2MUtGTnpOcXcr?=
 =?utf-8?B?dzJWMTZuWjdqa3hoRm1GbFVYMkl2eHdkSExXY1RZc0xwUThxR296Mnc5MFZN?=
 =?utf-8?B?dHRTWFBBNDBSUE9aNWF4YXVXaHlWblZSek94Wk1TVWN5STBwcVZHV05DNzVv?=
 =?utf-8?B?ayswVTlmQTA5MTlLZjJ0NFRnU084bS9zNFpSS3A3QWZqTkdKUUpOU25OOEhq?=
 =?utf-8?B?TVExeXJRaUI5cFBkTkU0K0NPUDQ2Ni92d084SVd0MjZReW96a0NUU2J5NHd1?=
 =?utf-8?B?VTlwSk1qZC9NQ1NVRXF2MUhiYkdwZHZvQVlPQkh1dnNaN2t4dXV0bm9KZmtS?=
 =?utf-8?B?NmhYK1RMdzRWc0VWRVhVSVBsMWRiWVpxSlN3ZXFZOWEyU29adFNEMEhGbmI3?=
 =?utf-8?B?UVpiVmpEQkNEL1Z4WVRXOUpqdGdmOFpyS01qOEFCa3YzS0FGT2Iyc2xlODlB?=
 =?utf-8?B?RjlqMzRSY1V5VTNRZkMyMFV0NEY2c2o4ckFncEt1b0s2ZGUxMFdrenQrTFha?=
 =?utf-8?B?czdZVU1USTNMS1BKRDFVUmdFcG01bHpCM1N5OEJEaUxmVkhqZHJBdStkY1lW?=
 =?utf-8?B?REZQNWtPMEZlRHU3WXI1VE5NTE9kaUJWVWRXc0F4eFh3biszek11MVQ0Ui9J?=
 =?utf-8?B?UlNjYUZMNEl1VDFIV0RlN0FZRE5zeHFoVVpHNkFhcFpySGV3c1pGUEdrQ3RO?=
 =?utf-8?B?YWVYTVM3QUhMR2Z0RzMrTStTMzJzanVJL29mT25tUlZudzdxb3FzVmNlOVhE?=
 =?utf-8?Q?/CGvfveN+ZQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RtWWRHRFg2cXVKVGNpNklwZEd2MEltK0xqMFhoa2dkbG91UW1MMW4xaWIr?=
 =?utf-8?B?Vzl3c0c5OXdRa0J6M0lvQ2Y4a0hmVnc3VEtjTnBDTHNKNVdyWTNQSktLZDdu?=
 =?utf-8?B?UDFpTEdoTGRkNHZvdzRNaG03VFgxRWtxZGFHb1RSZlFPajJ0K3pOWDlkUVds?=
 =?utf-8?B?aXJRTU04b0NuRTlqdWZMSkl2YmtBWkhwTWR6NU9ZR2VVNHZTN0hucDB6K01u?=
 =?utf-8?B?cU56VDQvMUdEelFjUCt3R29nL3JHZXNGbFVzUVhBMTBzTWhNMWZmTkhvZVhU?=
 =?utf-8?B?NTJ1N3JvS2QxVTVuK1RIbjhBRlN2aU5nRW1qNFJQVStQclpJYkF3RWxBVVBZ?=
 =?utf-8?B?SEVlbUsyK05RTHhqaStxRUlJNDUyUEZ2NzE5VGs1ZnRSQys0TndHbXRTcUZ2?=
 =?utf-8?B?S0ZvMzZvTkZzdDB2d28vNVZVN0V1b2xsaVZMcEZUMFlCcXBtcGpIYklQanJi?=
 =?utf-8?B?Y1Bzc3dKYVNRVk5KWVRuVXV3ZnJhR0J3ekJUcVloanNDZ3ZldFlYZjFNV3NY?=
 =?utf-8?B?ZjV3V3BLQjlpTkJSa1p3a0tlYWFWSTNjdVU0MHJsaXFGS2NxVEYrODNhRW5j?=
 =?utf-8?B?aHA3UGRaUHp1WndMTHpOK3ZHVXNDVk96QURhWlg0cEJkR3hrdHNzbkVoVnd6?=
 =?utf-8?B?ems2OHJBWHBtbEF5UjRxZjMwWUpaNzVTTGx1VFdOVC9jdDljTVJyTFZlbWVj?=
 =?utf-8?B?dTRJUnk0TWY2ZFJqRkJqbFNkanFEVjUxbEpJTXhaT2ZVUlpXbWlNYzQ5WTll?=
 =?utf-8?B?dXdud1NEZi9GV3lpbERBRk45d0FFWFhSL3hhNDR6OGdERVdXcFRGUXp1d0VK?=
 =?utf-8?B?b3hUbmQxdmc3VUtFVkJaWm42RysrbjJPZ2VWZFpJNEtnc2x3OGZidlNoL3pI?=
 =?utf-8?B?NzExVG8zR0hBb1BPMlZZbndQRTljbU8vUXh2VHJCRnpmajAzVHg3VkdtUXUr?=
 =?utf-8?B?S1ZTTGRUSU1ZS3VTcWZJd1RvSlBpUHE1SDB5V0hLazFGN2pWU2ZXSkZ3MnRG?=
 =?utf-8?B?TjFrQzZRZTkvdEQwa3JXSUVXNEphSHhNSGNnNFN5K3E2TnoweldXaVBpeEQ0?=
 =?utf-8?B?L2hDM2d6L1FvYnBFWGdoRGtQSFhmUmZiYTRFdDV6RzdXQUZaZndTMUFuUkpT?=
 =?utf-8?B?Z2I1U3lyR1R0OWRoc1lXdk53a2Nsd01ZYnIySk92R3oyOGNlRlpwOEpMWkp0?=
 =?utf-8?B?UkMzUG5qWml1cXdiNTdKQlJwUVorRTRMQ04xY093KzVqK05zRVFUeWNhUDRX?=
 =?utf-8?B?a1RGTHYvSUoxU2t1NUtBZndLaDgybUhrN0JqS3VLcldubU04L01zb1ovbFJS?=
 =?utf-8?B?Nzg3NlBBdzFtWHpZQk0yYWFlTEFwOXNYYU4xTXhGa1F6SmxaT3pPbnFKZDYz?=
 =?utf-8?B?dXE2ZGVkNTE2Nk5iSDY5eEtlNktCQkprc3BmZlZKb3ZyZ21JU0phemVhUlJp?=
 =?utf-8?B?Mk5SdmlrdmtSQlZzbFZZNjV1SWNpMVNTR2VFdEJyd29pRXlZZHJOYitxMFVR?=
 =?utf-8?B?a3R5RzFuWHM3TWVGYm83VkVFOTNkWHRtcVlYK01qK29VTzBhS2hCNTkyNmI4?=
 =?utf-8?B?UTZNcFk2TlZxNDh3ZVBVakZJWXBGQkpqeHU3QUFySEhobVQ4Sld1VExDSHNU?=
 =?utf-8?B?ZU9GL3I5UG5mUjh3NWNqeDJ2R2dnVDdHczJPRmpYRzVXTDh3MjgzMnJ0UEJG?=
 =?utf-8?B?c2toZjFLVU5jTlhhbzdEcnkrcTRLQXI2aGxERGR4QlY5QkF0L1hjQXQrdjFl?=
 =?utf-8?B?TDdYZ3lTYlhwWnBIZE9EdnlrdjR3RnZJZVVoUDU1b1FhWExJaWY3Y0FQdlNz?=
 =?utf-8?B?N1RXUDBUbnh5YkszVmhkR2REaUNBb21yZHVNUkdyTzJqTUxIZUxBQk5qY1lj?=
 =?utf-8?B?aEV0b0drUzZ3amR4QlVNM2hOMXgvYUQ2UCsxVlNxVytOZlFNZWFjV01zelh1?=
 =?utf-8?B?bWoxNm9ZQ2UwYWpYSkxKV2NkSUVvWW56aFRzbnBkWE96YnJHdGdQT1lObytR?=
 =?utf-8?B?dXEyOUpWTXd2bzNQSWhVMFc2SFMzS3QrcmlrSEY2ODZrUFpySlFGd0h0UHVL?=
 =?utf-8?B?djA5b1ZHa2YzLzdqazFmd2MvRWFYVHRScUZiNis3M2phZW1MakxoR0FDKzhY?=
 =?utf-8?Q?3Bj/MkBj8CTqYjX3h1DVj8svg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26999bff-aec0-41f5-01fb-08ddb93baddc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:40:12.8363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw5lNLDfRIwqFgE/jbNH+myyWAqmGaAJL2CpxNemYMKawgnLdqJ4RRbm1AMnnVxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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



On 7/1/25 06:43, Naresh Kumar Ravulapalli wrote:
> While sending bitstream via SIP SMC, busy status received does not
> correspond to error, instead it means transfer is accepted but SDM
> doesn't have any more free buffer space. Hence, data transmission
> is continued when busy status is received.
> 
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
> ---
>   drivers/fpga/intel_sdm_mb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
> index a2f3b160a73..5f4aae47d6d 100644
> --- a/drivers/fpga/intel_sdm_mb.c
> +++ b/drivers/fpga/intel_sdm_mb.c
> @@ -687,7 +687,8 @@ static int send_bitstream(const void *rbf_data, size_t rbf_size)
>   			debug("wr_ret = %d, rbf_data = %p, buf_size = %08lx\n",
>   			      wr_ret, rbf_data, buf_size);
>   
> -			if (wr_ret)
> +			if (wr_ret != INTEL_SIP_SMC_STATUS_OK &&
> +			    wr_ret != INTEL_SIP_SMC_STATUS_BUSY)
>   				continue;
>   
>   			rbf_size -= buf_size;

Applied.
M
