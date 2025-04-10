Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B966C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F57183A28;
	Thu, 10 Apr 2025 09:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgxNub2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0D44839DD; Thu, 10 Apr 2025 09:48:26 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A08583A1A
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STmPWfLJU5RXLgwcC4x4oNhjZpQSs7JCRuhqj/0ETOqWALYY82N4e0pmY9lkHG/p4TFQfZYZmwhcqq7BNZ4WGbfitgg9t/sOMlwgyfLwdOByTKzgE2Yrs7HkNyUi3VsZ/UygUdtJCLT4Z+mv5lfROKx5LikRth272ROXo6n/KAG7Kiew7Rw9ft9j5dtjHqYzYrGx9d5ZlKwkLSeulqXJsEioj8SI4gaFRILZfsvpx2EyXX5cXXmFe/ukAtYIdacQF4Md2EGgLfTmMSCVCwiACv9xLdE2Q39scI4rw7BBxAP1XIFSFAnylBF+S6s4/z8TZp29qrtIpNNLPQD0aV/EhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j9sHOHAIBDDlAatiA2oWtB/TWqg5454qEI/DlP+CtI=;
 b=l/b+QmUuFRZymq/i+fGzsfxpvFORcui+SmWHwbgirXH2hCb6TVJ5gNXcVMEoKhhg+aJQgAHsXlIh/1mohoJAzBARNqB17vGKxdfKF/3gU3gnvFoLDcA3x9ztcY9SDLzAF0V6ih+u7QlOFfzD4+J1XD2etbom/uA9ff2FMglpYgNJRjg1GoRiWBE0sAwhX0K62XFb+PJdu5iRLB9k+AwosKvhExvM/R+VUWDWdoruSG0mDYkKird/AEcyDs2BKDWTDgJ0wh3+ch2ra0Mw/N3MtQXnLd/yQJldH5zQzkBSagxzcRkBptgvNPNN6NOL2kc0XtG262Q2PeQW7LkvSWn0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j9sHOHAIBDDlAatiA2oWtB/TWqg5454qEI/DlP+CtI=;
 b=fgxNub2+VxSTkxy9NDRVAH3+6lnqgyXP9rwxTPgx6TO+RA/r4X4ghY9eqTlA510TrK0zmnQ6PjfNbCQ5UYEmbO6l14v0ygCZr65o68xmtgHlKN2RmBqun8zDuwhs9J1Ynwn7pgK1eUusiEuJATK3mr3fKQKqxhWpSQToqBWpP1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 07:48:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8606.035; Thu, 10 Apr 2025
 07:48:20 +0000
Message-ID: <bca32b70-0f59-43aa-9ddc-12d0caefacd3@amd.com>
Date: Thu, 10 Apr 2025 09:48:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: fwu: Dump custom fields from mdata structure
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 git@xilinx.com
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1254c3c538facb1a124865aede861f399cf524df.1742552744.git.michal.simek@amd.com>
 <c13c5226-60cf-4860-bdff-62eb9bae09f4@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c13c5226-60cf-4860-bdff-62eb9bae09f4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: b39667e9-138b-4c50-e735-08dd78040ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K05kdXoyeVM5WmpoRS9oVytaUitQMmZvblBkeVNCTE5MekErU2JybDNJc1Jr?=
 =?utf-8?B?Q2xCZ0dyYlY0bjVLY2RtaENOeUZPZU8zejl6dk9PRUdMN3k0V2xCTjAzWURD?=
 =?utf-8?B?bkVSMHludmZ1M29hbDZ2M3RmM1JaTS9ma3A1ZUxJK0wwNFVxa0ZHYXhCNlJG?=
 =?utf-8?B?cm9FK1hvazQ0VnVrSFJBSHZhc2pGL0FHREFWYVRrN3BYT3NDclc5NTEwNGhS?=
 =?utf-8?B?MWdzWUQzajhPR3hPYTJRV25pejdLTit4VE53NmNzSTc1OXIwQzUrVlpJK1ll?=
 =?utf-8?B?cHRpeHVGWG5XeGhzUzVLdEt6b3Z2dWMwMExJM0JyaDZDY09GTnF2SU1JUTFE?=
 =?utf-8?B?cE9xQUNhQ3BnUzNvaWV4ZVdqcmlGZkJxc2cvVFNhY0xseFA1akFEQ0VIbHpC?=
 =?utf-8?B?eDMvSEJjYmJIdkxqblBnMHBsQmtVcTg1U3Y2OERzb1JzNlRaTnllK1lCYnBV?=
 =?utf-8?B?RXhvMGpJZVYycGNzSDhwaHpVYjlzN29FQk1uVVlyYm9oMUVITloyekt6dkdz?=
 =?utf-8?B?aG41d0NTY2pTWG92UUdVc3FHZEk3S2lSNUpjNThrbHhUdzBqUy91cko2bUNR?=
 =?utf-8?B?MHI5WGJpUFpDUG5iMzJYRHh1Q0xCbi9uUDM5S2JlckRwSWM2RTJUNnpiTnd1?=
 =?utf-8?B?eEY3eGJFZHo0MlJNNm5mRWwrOXZxU0JVSkFqVlJNZnVpK2dmT2lYeWlsT3I4?=
 =?utf-8?B?dmtDYzc3ajNEc1dwWjB2RmNVM3pqd2g2eC9FdmZDZEVoQUZ1ZEl5ck9PN0xx?=
 =?utf-8?B?QTZ1MWJxa0FkWDZzV3R2N2hTaUtld25kZkhuZktYUFRNSXI4VHA3bmJrQ09s?=
 =?utf-8?B?Q0xZREkzb2VOVVFMYTE3d2t4dXVpbjRNcXRITFpyQm9tdmtkcExMRXFQYkhD?=
 =?utf-8?B?UXMyS0dNNVpaRjdJaFBnMFBlQUZGcVpMcmRVRUJsb0Z1TC9rUlh2ZWVjVHN2?=
 =?utf-8?B?REFLakJTTTNqNklTRlJHRGdhelhwMUdJeXNPazE4dUs5cGxPSit0U3krMk5W?=
 =?utf-8?B?bktGNGsyQWJsdnVwcG5LRTlMcXFzUnVpTUJjeFUxVVhxTUZHNW5OQ3RkaDJz?=
 =?utf-8?B?N1g1b3U2dzNXRFVlTmZuV0IyUHBBazZoSWNTeDJuZnM1UktmQVZZZEpDMCt2?=
 =?utf-8?B?bnZSWERwbDlJTTR0MSs1dWFoMDlxaStaN21oTllmQWY2MzZtS2lGS1V0S1VC?=
 =?utf-8?B?dUZ2bWh4Tk1adXFhRXQwNis4aE9Gc3ozRWtXQ29tRlB2TDVJcm1EN1FiYXo4?=
 =?utf-8?B?bkN2RzVwbmx2QWFkM0NYMDJVSGNSdVNWcEIyWXRISENUU1JpaFRMd0ZSK3hY?=
 =?utf-8?B?djEzSEpydWZQc25JRHExSUNONG5UY3EyK0dYaFRtR25XNEp3dzFRVCt3REFI?=
 =?utf-8?B?bE9xbGE1Y2djTW9BQ1ljUkxKYmlzeFl5dDAzakRTcVFQdm1Xa28wcGlERHpu?=
 =?utf-8?B?aGgyUjhBeTcveTByZVJma0pZTk9HRmE3MndsR2VtYnJVRnZVWnZDNFMzeFhM?=
 =?utf-8?B?c1VDdVhSKzAzRklEQUdpaEJTSkROMFRaemRhSEVNRy9GTTFRV0RZYVZLN0Iz?=
 =?utf-8?B?Q3BpcEFpM2VPWEFaN1A3ODdVc2Q1L0Q3N1RlVytoc1Y2UjVVbm1ya3paVGl4?=
 =?utf-8?B?Z1NVVnB2VE1heXJiM0xBMm1tUW4vRFZRa1JGdnRTQ3A0MStQbWVhYmFlS0gw?=
 =?utf-8?B?eEJRR09FeHlYYVNWMVFHbkFiaGVIa0gwYlZremlKMklSN3ZnMEllQVpxSW41?=
 =?utf-8?B?RzVuMGJjNFl3TnNMcjREN3pqbnRaYmhGaE5BMWYrSHdoeUtFZjQ4VFNxT0hQ?=
 =?utf-8?Q?hCcGqd0VvLtoz0nRR0Ukp4t1Xv14LE6hZon78=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5CcmI4YTNtR1N2cGtrVGoxTUFaWGVYazlMaXFJK1ZNcWE0SnlrdEVXSmEy?=
 =?utf-8?B?azcvU3I2TlRVTkZIUERzZU5CZGR0UXdhdFhoRDRxaFMvb2ZDb0VBNGRFQWVE?=
 =?utf-8?B?RjV6dGMvS3pGd3BlTFZjcU5ZUHlpZlIzWklOam9BUjRtMkxablVBOGI0Qzdj?=
 =?utf-8?B?VG81cTRvY2U0aEhiVk9HaXpybGxxY3pLWVlmTmZGTFdwcks0MVVuZDBYKzVU?=
 =?utf-8?B?UjVCUWlHTnhoMHpXU1UwQlNxd2k1L0FYVDg3d09HTW1MbE43Qmo4ZysycUxV?=
 =?utf-8?B?OGxtZ0IzNDJ2OENMeXRLUXg3cE0zcnUwVWllSHpIOXlnUEZxeUxLanhtTTcz?=
 =?utf-8?B?TlVNMERRZzZQay82dGthbHY0eFdJM1NoTUl4ZWYzN0FjdXR0ajhVMWg4RERk?=
 =?utf-8?B?UDlkUGhZMm1BNnpWYVlWWXRQajB0ejRvclp0aERDUmRHZndIMFByMWtnWmJ6?=
 =?utf-8?B?UEZLYmNFMklJakhuc2lQY1lkMjFFWFRlZUZDNGE3M2cxMkorVjlJanozMGlm?=
 =?utf-8?B?bmloUnA2ekRzdE1KbnM3WTIrSVBNSThreEpQaCthQ3N0MTZnNVkvZjFaMndU?=
 =?utf-8?B?ejFhcGdwSCtFdG5FRE5PajRNNFpwVEt4ZWFOSVV5ejgwaGNoZk5CWnlzR1Qv?=
 =?utf-8?B?VDFRNm5NOU16bmxVVjRpZFh4TXFkYmdRWUhOS0o1M1NwR1JMaVlSc0NYZmpr?=
 =?utf-8?B?dEMzR2hXdGM3d1JFdHRBV1l0dTRCbi9rend2U3Jub2xreUlDWFcxMk1wcTVq?=
 =?utf-8?B?cGJPYm1LOWd3cXA0ZXlqUXVqMkpvdTYvV2w2ODc5K0dsSGVVTVRMS3lUVkp3?=
 =?utf-8?B?akFFUEFPVFl6bUYvelpEMWthNVdDRWFEOVdBZUFoV0V0UDBxOVNkYjJjT2Z5?=
 =?utf-8?B?ZDdxRmxrWmxkakF5d0FWemtqYldaMGh2MW1GMkhHTXRjTm1vTzdmcVNCMjBW?=
 =?utf-8?B?MkdWdTAzcUxqa2F6NlVsM3NtbmQ3RXhWTWowT1czQXE1dzgzdGpvb2NnalNj?=
 =?utf-8?B?ZFJoWGFJL1l0ZXVmcm8vUS9WbjhpN2E3YkgxSGNGbmRjczhwZHdSNGxHRHEz?=
 =?utf-8?B?RENIV3k1TlZkT2pTQm45Qi9pa2Fvc1dSN1J2Vnh4NXdYSUpHaVFXNmd3bUk1?=
 =?utf-8?B?SDk2ZnBVL3VWNDhOanNRR2I2dzNsS0xCY3JRUjFnOE5rSzRtdGVNODZLZ3JN?=
 =?utf-8?B?OS9jQzFMQlVKdzdDOW43Q3dIVjBFNmJOYUpUVWJZSnZIWndTN0NJeWh5akZh?=
 =?utf-8?B?UmFzbUNUdlFpaGJmUk90N1p3SFJNQ0gyLzZYODMwQkxkL0tNNHk5SDdnemNF?=
 =?utf-8?B?MGZ3YTM2MnVINkF1dlQ3UlhFMGJFL0Y4TWNpTEVSd2hURnpVQ0ZCUWM3L3N4?=
 =?utf-8?B?WkdIZTRRaW1tQjZMZVpTYlJqZmllWlI5Q2YwamNTYTMwdmdQQnYxcWJuS0h0?=
 =?utf-8?B?eFlBUzI4dUtZSVZKRlBTdmZOU0ZndW9ROVU4aTlvdVE5UkpWY2NlSDFIQ3J3?=
 =?utf-8?B?WVR1OEsyVmVoSDBoSDRuUzRrZ3ppN1ZPWC9xRWlrTy91azVhci9HbFNZemVt?=
 =?utf-8?B?eWVGZmhQR3cyYmRnWEJxMXB6bE1ITWJkaEJpSEFKbGpYR2lwYjQveDlUWmI1?=
 =?utf-8?B?bWtNVHAvUEpTTllMUGZlYWdDcjA0UGNEc2FsS3BFTHY1d0ZWMmV3bDNrbG9B?=
 =?utf-8?B?MnJHdGMxWEF1bTgwcDhOcGRmQUlMVGRDOTJFWmRHT1pYbm5xc3BkbWNYNkNa?=
 =?utf-8?B?ZzRoak9YNGpxTm9ESFJIVUpHTHdaQnZpcXJrbHdMODN3UU1FQlpBYituOEhC?=
 =?utf-8?B?MGcwZEVWWTBDNzgvK1doa3hYdVNJUEw4TjZWRjJNM0NlMGpETG5qd2dBMmVC?=
 =?utf-8?B?WUo2L1JPYnNLT2ZCU0FIVWRTMkhmRENKYzZkSkNYSDk2WXNRQXZveFZIMGwx?=
 =?utf-8?B?NUV6b2RCRXkxRmlab0E0M25EcUVwOTMxSmFqalRGOWR3TnZqWWdpVnJZTXNs?=
 =?utf-8?B?b2lFNUh5NTh1K05xczNqWi85Vm5KWThsVTRrVTdkOU9oVGJsL0RQRUJjUVZj?=
 =?utf-8?B?K3ZvR05pNUFtVGNGLzJ2eGZkQVZTK3FRbGV1ZXdDYk9DbWdUSDczL0Z4UHZU?=
 =?utf-8?Q?q8piISqu5A9crRPP7OyTVyatm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39667e9-138b-4c50-e735-08dd78040ff9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:48:20.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3xhrqEhzglwupk9FuwFuzQ322+g0BLcUL3yRxB79nLYYvPgvIDVp/7EIyFD8d91
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
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



On 4/8/25 16:14, Heinrich Schuchardt wrote:
> On 21.03.25 11:25, Michal Simek wrote:
>> The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
>> data to the FWU metadata") added support for adding vendor data to mdata
>> structure but it is not visible anywhere that's why extend fwu command to
>> dump it.
>>
>> Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - Extend print message
>> - Cover hexdump dependencies
>>
>> RFC:
>> https://lore.kernel.org/ 
>> r/75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com
>>
>> ---
>>   cmd/Kconfig     |  1 +
>>   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 642cc1116e87..1f8aa2521a8e 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -185,6 +185,7 @@ config CMD_UFETCH
>>   config CMD_FWU_METADATA
>>       bool "fwu metadata read"
>>       depends on FWU_MULTI_BANK_UPDATE
>> +    imply HEXDUMP if FWU_MDATA_V2
>>       help
>>         Command to read the metadata and dump it's contents
>>
>> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
>> index 9c048d69a131..5b5a2e4d1cda 100644
>> --- a/cmd/fwu_mdata.c
>> +++ b/cmd/fwu_mdata.c
>> @@ -7,6 +7,7 @@
>>   #include <dm.h>
>>   #include <fwu.h>
>>   #include <fwu_mdata.h>
>> +#include <hexdump.h>
>>   #include <log.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>> @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
>>                      img_info->accepted == 0x1 ? "yes" : "no");
>>           }
>>       }
>> +
>> +    if (data->version == 2) {
> 
> Should this be >= 2 ? Or do we intend to drop custom field support in
> future?
> 
>> +        struct fwu_mdata *mdata = data->fwu_mdata;
>> +        struct fwu_fw_store_desc *desc;
>> +        void *end;
>> +        u32 diff;
>> +
>> +        /*
>> +         * fwu_mdata defines only header that's why taking it as array
>> +         * which exactly point to image description location
>> +         */
>> +        desc = (struct fwu_fw_store_desc *)&mdata[1];
>> +
>> +        /* Number of entries is taken from for loop - variable i */
>> +        end = &desc->img_entry[i];
>> +        debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
>> +
>> +        diff = data->metadata_size - ((void *)end - (void *)mdata);
>> +        if (diff) {
>> +            printf("Custom fields covered by CRC len: 0x%x\n", diff);
> 
> The print label is a bit hard to understand. Do you mean:
> 
> "Length of custom fields in bytes: 0x%x\n"

That's long description of len. But we need to know what actually is shown which 
is that custom fields convered by CRC.

> 
> Wouldn't print_hex_dump_bytes() already provide an address column
> conveying that information?

Length information is visible via hexdump and no issue to remove it from print 
above.

Thanks,
Michal

