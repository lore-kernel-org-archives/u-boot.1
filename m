Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2663EC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 05:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9291683675;
	Thu, 10 Jul 2025 07:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PgCeaodD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A9A8367E; Thu, 10 Jul 2025 07:19:48 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E12383653
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 07:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw+P3s7C0xi+SbC6ZSOK5uk8cOVvxYTCuoj7AkG/aX8WWrvW8+HeXbzlc86aAEudo/lDjHgMhBmOzXCcbdyNRgEWSfw3m4yB1Lcipf9xD0wbsYcUtIHnkz2PVc90e04bPERegqDyb9PKoM0YeXV4ZJz31khtLFQEKXCSL8DdY3TnYGnpkwzlfY5uOkv9ggnTQG6LwBANaanQQ0I/3LPfkMLGFCqyb1mQsAy5QwRtPH8Ywqo+DtPM6pLLmIETkGM7yj2Q1HP4jT4oROZPYwW6rMNIGgSnoB6T2dqNsPoZgQSOjgCKwArfepaKZObKRqKZAD4wovATO7EpRphA0qmntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjznxwIoNNjmC1ZLyYOzUU+awvOdV4QR1FAQR839cTk=;
 b=LsE96nf71tGBaF6O7fw8KN2kR6l4d3poKT2h2ovXW3ADfMSZEZGnUpc/v7WE1xjkKh9Wj1KSmYqvdpYh71HoTH0GwIKjqvJyCIiz/fo43KEiRN4JhRr6B0+4PdcB+0r4CTbyiWtNYq0X+0dQoDozHLHnqwbu4/Fnjaw0ydlWBNPU3CcM7Kn40+0aDbLRH08+CWrAX3voihhaTenS/2O8GvfCDslWwW3QLmaekcj6xY+2kNo2tMoXikBRf+m8hKEWvtMJBTy4qw4CdDsvq1RwHu9jeuqdmn5HfKKQM2hS4L6BQal1uPf8qrGXKKsietJbgCk2PNsIiq4WMAjETRhmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjznxwIoNNjmC1ZLyYOzUU+awvOdV4QR1FAQR839cTk=;
 b=PgCeaodDN2fiKeL9lyNObuyZ4iFhFxEG2VYBwKaVWoeB/ZGqmbPaJfLW/ANt7NwcdIHEfEBzO2Tp3X0xRh7EFXT6vUdI84u+i3/CSd7o1SYMC8/VqK6Ot0SH/Yqlx5IRmatyOEnCn2dE7MzX+X7pZ3t9SW1ha9lxxpfTQ6hxWEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 05:19:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 05:19:37 +0000
Message-ID: <55077dc2-fea6-4710-8b0b-da2a72ea6f74@amd.com>
Date: Thu, 10 Jul 2025 07:19:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] Improve user feedback in case of FPGA bitstream
 load failure
To: vtpieter@gmail.com, u-boot@lists.denx.de
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
References: <20250708152455.1214487-1-vtpieter@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250708152455.1214487-1-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c61bbb-5bd3-4195-99d9-08ddbf715d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVh5UTNIUEVXVm9oc2ZENjJyYXpkR2U4dzVENVkweFJIdW5hK1pJOU1Ba0Vr?=
 =?utf-8?B?NXN3bi91TW94VFNyQ2ROeCttTTVlZVlOa01JcDhVQkU4V3h3ZmhCTkw2RlBi?=
 =?utf-8?B?cFFTUVlSZ0l2S2NqRFptSEttNWhWSFpiTjlzRTVWUUUzTk5HZGVwYW8zM3ZU?=
 =?utf-8?B?KzBXWmJtZ2pNRHRkUlVhY0VOU1VHTDVtNEJDeWUwYVo1UklPZFRtdDBSQVQ1?=
 =?utf-8?B?bmdVMnZzWVhISGpKNE1hRWowZm5LcGdadSt5WGJUVnNyakczNDNkdGh1eFRl?=
 =?utf-8?B?bTlFL3lNT25IRkcrZDVXUy9QMGJXdmlzZlA3K0E3ell2NFNWYjFJMHBaaExY?=
 =?utf-8?B?cVlRajN0dkJ4VXpMTHM2ZlIrczVvbm05MzEzTGQ5M2FIa3djM1NabU5sUUVl?=
 =?utf-8?B?bkc4QVhFbXJac2VpUlBjY2lSK3dxSi9hZ254bERKOUlZZFVpTTU2MzhMWGtn?=
 =?utf-8?B?UzZHbnI3bGc3TmZIY3FUM2JzSGxDbDB4MnUrZk8wSTlQUzhIZ2sraGVsNGlj?=
 =?utf-8?B?bmlyUENhVktKeEw4Z2piOSsvRkFrZDllaEdWeitLV2IwSVF4NVdSUm9PdWpt?=
 =?utf-8?B?bmxUVTRpSmNpc0ZkUkRFR0NmK3RVOGRLeUdsVi9DUFBnWW1UZ0gyK3NGSExk?=
 =?utf-8?B?UldZbzVhM1FPVjZkTkhjOTlOdS84Snh6VWVUTGlEV0RHVTlEblkzWWw4cSs4?=
 =?utf-8?B?SUR5Qm8xRy9vM3g2UXlPbk5OYzF2OXR4MXc2RC85VThjRUF1TXpndDVsZ2V6?=
 =?utf-8?B?NjhsVUNwUnFJcVBpZThJYlNEWUZQUTFmLzZoSk9pMzdlR0xKREhBUzAxcVF4?=
 =?utf-8?B?UVpYWjg0QmZlaEpWb2dZSHVhQzFFQzZmTjZLclpyWUhZamhNZW9vMzZSUVAv?=
 =?utf-8?B?Wml0bFQxbTJISEJVekx5aWo5dXd6eW5waER3NlhrcldKeWJiL3RIeVVhUjBj?=
 =?utf-8?B?NXp5TGJMbjY1RXlycGxpWWZFSTJOa3VXWjNtOXJHb0lVUENvT3lyNzlXQVMz?=
 =?utf-8?B?NDQ5eUxRMDdtb0pKL2h1MWdQYnZhZVBQQm50OFNOZSttZW5HeHZZbHIvZ0Ry?=
 =?utf-8?B?OFBNQUxJVkNONmROQVNrREZvL09WRUVvZGxCWWx4Y2lnNjJuM1NCSlN2d3RM?=
 =?utf-8?B?alY4VElxaDBPSS9WUXJCSXBNVmNVb0xNMDl4QlJqSEdFR3ZFMXRlaWJKOCty?=
 =?utf-8?B?MUpKQ1AxRzlpYm93dldheFltZkExRURWcTIybTlyTkMvdjlZamgyRy9MY2JZ?=
 =?utf-8?B?NzUyRjNGZldTenIrN0ZvQWtJWjNDUmVyR0RUTjRldTZWb2xKY0pDWHpvKzlJ?=
 =?utf-8?B?a2svMGU0VGRLeFlWejFDOTExMXFQQ3NNdWlINVJOeWJCMk4yaHBsVk83OHJM?=
 =?utf-8?B?Tnc2VDVjUlgvd3BUNVoxRnFyZHJBbk1hcm9IbDRqQ3h3UXVkb082elY2RGp5?=
 =?utf-8?B?VEJia2U3U1VBaVZoRVJyRXN3QW1RTFp0cjVRSUJTbGFKT3dOaHc3SVRGK0h6?=
 =?utf-8?B?ZXJRS3h1OUhoVUVUakRtYmJyaU5sUGhxVCt4N09kUE9naUsrd2kzbHJmUGpm?=
 =?utf-8?B?L0h4cStkd2VDaThRdWMyTzBmb1YxdjRaK01ob2MyWmtPMDU5cHJZekduNkEr?=
 =?utf-8?B?YTVERU9tQzM4MHJpN3FkVmFXN29mcDBScWZtaGIvcnZyUHpXQmhvSFlQSGQ2?=
 =?utf-8?B?TUZSNVdCaXlyUldyY3VqbnR3eE1DK1k1eEVDYTh3VGN6YTJva3NWSUF1WHNM?=
 =?utf-8?B?blBhblJBa09hUjdkYTlXNUhpVXF0NGtHRWhGdHpqZGFkTG1JN2NFcWZtKzlj?=
 =?utf-8?B?NjVaL0c2RU1DaFdRVEt4Tm1kck92ZHZzcGZ4U0lvd3R5WlRSOFJOeVQxSzFY?=
 =?utf-8?B?QzhKa0VzR2pmNkJpdlM4b2xkMm14bTI0dFAxMnRDbTJVdEVpbE9hTkZzTlFD?=
 =?utf-8?Q?y3KXh4kMfmM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNtRmI2bjlEeUMvaEIrMHIreldHYllyT2pvM1Y2OHdtVmpzQ0VTSmJhN2xn?=
 =?utf-8?B?TEJEV2Z6WWxMVzhsU1pLKy9ia2VhMkMwL1g1a0trTFc0NG9YQVhQWXJUbUhs?=
 =?utf-8?B?RnFvanI5Um9TQnNSNUFTZ3hUYlpBektWVUdvYzdEWnZBOVlsT0t6MUdSWWt0?=
 =?utf-8?B?NVBRMGM3L0p2RGVPV25KRlA3TmJxTFprRUlCMUtjRVhLMllmaDBiaGFMRUtw?=
 =?utf-8?B?T1p6MndLc2xlTlk3cVBET2hjcnBDeG02UFZwTlRYTGtFRzNTbXhWM2VBMlJZ?=
 =?utf-8?B?ekthbVk4aUNTWnViazZQTHBSeWozVjRNRHFXWkNueElqdHp0WVRsZFkzeTRR?=
 =?utf-8?B?YVk4U2ZLcUgveWxHQUNZK2hkZUpIeFhSRmh0WlRob1o3ckVwVUJjdFpJSHd0?=
 =?utf-8?B?djUyaks3Y1E4ZnN4Yk9iSThDV3A2ZERFai94d014cUgwM2NPNWFpd2VaYURB?=
 =?utf-8?B?Rms5QW8vbmRpTFNJcjJpeFovVVE2c20vMVFSM1hFcStFdlRoUk9KV2RXalFL?=
 =?utf-8?B?eXRjd1phWVJTM09FNk1OVmxrbXdVZUgvVWVoZnZMQXJFM3lsaFl1eVJlVktM?=
 =?utf-8?B?QU5MNmJxTGc4ZEY2Q055MW04QWtSZXg3RG1MVEpEdkFYbTIvcWJFUVBjOGhh?=
 =?utf-8?B?bmcvd1BBY0VKd3pqTkJEOStabElHR2x1YnI1TGc0L3laR0hYVXdqdUFSaWdY?=
 =?utf-8?B?dVJaNnVtSlE5cXRMbG9mYkhtc0l5TytiMjFHd09VTTFQVGk3L2UyWHYxRHhU?=
 =?utf-8?B?cEUyMzNNS2d5UFhFd25IRWNPbXNoZEovUCttTlViaUxaN0JUVHlTeXlQV1gy?=
 =?utf-8?B?YzJCbEQ0bE5weFphYjI3VW1pS1lYUk5leU8zclpFV1lpTitKUkl1NTZraWR3?=
 =?utf-8?B?Z2NudEFpall0SHU5Ti8vTDFHZ0dFanhtT2RrZnZFaWNMcVZYQ2dtdUdEMDNx?=
 =?utf-8?B?YkhuS1BYWENkZWx5QTQ4cXlaRHdVTWpzZ25nc2NqRlFYcnZqeWc3amd3RXBZ?=
 =?utf-8?B?bXBqNjZKemZ4cWNnVHNISXZMVVNVVUFieEZLZEFzaHQzV3gxbnZTdjBBZDZF?=
 =?utf-8?B?NjAyRXBBeDB0SmxFMlYyeDdQbnZyRUhReGlBNUljbXI4Rm5TZG1NT0xlaFRZ?=
 =?utf-8?B?SWJmN1BhSmZweERJUEpEWW9IMlJZZTYreHZYZFg0d2pHeUgyVmRSTmhDSDdN?=
 =?utf-8?B?cmdtdkxaVEhpbFVSQ2lPRk5vZFJMZHZyMk9pQmRuN3dkUTJ3cjZkZDZJbTI2?=
 =?utf-8?B?c2NpdFFWYnhIRlFvN0VVNG1lU3ZNRzJ6L1NsN2grTzBOVHFnM2xTV2hoVUMz?=
 =?utf-8?B?bzVvK2tyUXk1c0hBYU5RV1JBTi96SVN5ZTNMM3N3d3dXdDJRa0tVNW5mOEEy?=
 =?utf-8?B?a3NlMTkzUlVneWFBUDhuVnZ2ZisrWHpWQ0d4YUVlK3ZENXNCbHlLcG1kNUwx?=
 =?utf-8?B?aERmYnRnY3IrK2txamVRK0E1cEZaS0d6STR1aUk4QjlEcGIvWUozZTExYVA2?=
 =?utf-8?B?YzV5ZlBLZ3RjMk5mNFROM3Z0NkZYZlc5MUJPRVlsSUYxT096ckJWOU8vV2NF?=
 =?utf-8?B?NGE3Qm0raGJVQW9zYlF1R1hyZ3hsUDdsZnJQVXB3TXB5WElzNEIzT01vMGk3?=
 =?utf-8?B?U1dsN3Y3OHdVS1N5ZU40eVczRkFuZ1FIbjFPd2Q0SWpsL2ZBb0R0N3FSRm9D?=
 =?utf-8?B?UlNaWE4zZVNmUnJiVjB3ejVLWmVLdGZaRkM5RmhFckkrSHZaOC9SWWl2Uk9a?=
 =?utf-8?B?R1E2SnZFNE1KSi8yZnpSbHpHZGExWTVsalE1cVlEcE9qcWUxc1Yrb0U2ZjRt?=
 =?utf-8?B?UmllTjFiY09TVWVrRWUwd3FTMWd2c1FxZnBlTHc4QnZMY0F1bVNkSnB0bjg0?=
 =?utf-8?B?dkxYWnlCUEJDeDRUb3d0UXhUNjN4aXpJN2M0VjNyU3VBWnJDd1V3L2ExbWYr?=
 =?utf-8?B?U0pFR1MrTG0rTlVEandaU1U1SnA0MzhuRys0TDBxbkIyNmg0ekYvVTJUbmp0?=
 =?utf-8?B?Z2hlUElpc3lRUkxEei9COVFGZXVwT0xEcTVhVFFMZWlMZ0ppcnN6a2VpSmwv?=
 =?utf-8?B?amt6RkdLMFlBa09oQ25iRzJzS0l1eGFSRjVMem52VG5oYmxDSzNoclNpQXlU?=
 =?utf-8?Q?a/0rieJZVMNmhJ2VzEmp/t1Mi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c61bbb-5bd3-4195-99d9-08ddbf715d7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 05:19:37.8504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enX0bGM6rfZxQqA5WmzU64JvSpi6CAAfZ1+Ety3WJT5y0D+JwWan36njcOQ85vrS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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



On 7/8/25 17:24, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> The main motivation for this patch series is to make the `fpga *`
> commands' return message more explicit because simply returning the
> command usage without indicating the root cause is not helpful.
> 
> In addition, the sandbox_defconfig was amended to facilitate compiling
> fpga-based sources and various style, compiler errors and warnings
> have been fixed.
> 
> v5:
>   * add new patch 5/6 to fix Wstrict-prototypes error, reported by clang
>   * revert sprintf format to original in patch 1/6 zynqpl.c
>   * remove Kconfig new dependency in patch 2/6, fixed upstream already
> 
> v4: https://lore.kernel.org/u-boot/20250705205710.792370-1-vtpieter@gmail.com/
>   * make better use of prefixes in commit subjects
>   * change patches' order to ensure no commit introduces compiler
>   warnings or errors i.e. defconfig is now patch 5/5
>   * add new patch 4/5 to remove compiler Werror=unused-function
>   * add an additional Kconfig dependency to patch 2/5
> 
> v3: https://lore.kernel.org/all/20250626093519.115655-1-vtpieter@gmail.com/
>   * enable FPGA configs in sandbox_defconfig instead of new one
> 
> v2: https://lore.kernel.org/all/20250626093519.115655-1-vtpieter@gmail.com/
>   * use log_* instead of puts() which is now preferred
>   * harmonize user feedback format; remove useless strings
>   * add a sandbox_fpga_defconfig; amend fpga Kconfig
>   * fix various compiler errors and warnings
> 
> v1: https://lore.kernel.org/all/20250626093519.115655-1-vtpieter@gmail.com/
> 
> 
> Pieter Van Trappen (6):
>    cmd: fpga: improve user feedback in case of bitstream load failure
>    drivers: fpga: add Kconfig dependency
>    drivers: fpga: correct compiler errors and warnings
>    drivers: fpga: cleanup printf usage
>    drivers: fpga: fix function declaration without a prototype
>    configs: enable FPGA commands and drivers at sandbox_defconfig
> 
>   cmd/fpga.c                | 101 ++++++++++++++---------------
>   configs/sandbox_defconfig |  20 ++++++
>   drivers/fpga/ACEX1K.c     |   1 +
>   drivers/fpga/Kconfig      |   1 +
>   drivers/fpga/fpga.c       | 103 ++++++++++++-----------------
>   drivers/fpga/ivm_core.c   |  13 ++--
>   drivers/fpga/lattice.c    |   4 +-
>   drivers/fpga/spartan2.c   |   1 +
>   drivers/fpga/stratixII.c  | 132 ++++++++++++++++++--------------------
>   drivers/fpga/stratixv.c   |   2 +-
>   drivers/fpga/versalpl.c   |   1 -
>   drivers/fpga/virtex2.c    |   2 +
>   drivers/fpga/xilinx.c     |   2 +-
>   drivers/fpga/zynqmppl.c   |   4 +-
>   drivers/fpga/zynqpl.c     |   4 +-
>   include/fpga.h            |   2 +-
>   include/stratixII.h       |   6 +-
>   17 files changed, 198 insertions(+), 201 deletions(-)
> 
> 
> base-commit: 1323b480a6fc053475901a90bdaece2ddcc47310
> prerequisite-patch-id: d13ffa9f16b79939ca26d5334d15c077c11427af
> prerequisite-patch-id: cf4d9931473e7f673dad6a4e7c23fc3fe4678408
> prerequisite-patch-id: e6885654262d1a9ddbb8d33e988be9c7c04a95cf

Applied.
M


