Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB6FCD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF518876E;
	Tue,  3 Sep 2024 18:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KjoA9PyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD0088B59; Tue,  3 Sep 2024 18:59:39 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DF9886E5
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc8nib9gbM5yWdKoYqc9YMG1JwAG9I06qNBHnPfRSkgqkihWbxgT1E+hARWD5jY6E1R4bKNDPs1VbbC3qQbpy09PUDdQGqwUybpJdeItvtFYyMEGpGU8F329EoKOA+Pp+pRh1QZtayHxecFlJwUL9/DwXE67SRFqJA7FKWQUahvO/SElb2c/BdCWfrUiD7mBTfYtxGBC/4p02KHAIh0ib3qPRWmv0qw09P+sGSduDtF2QWF6uXe8F9BUWp4ER52znw9FEXV6WMiq7jTPusZ+qXLO6uyvo9+ZUVqac8qsU7RctEWjSxmwFOlZgYNK9hEGuafHguhJVw6F/sujpt5x/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5SACww5GPjyvI1UVwdwjC7atVv45UhO9YhMz2cmCNQ=;
 b=rk3D+fMqiWyxlv22YKIHuXfPoeYLik9BtDA24w3rfGQcWBoBnHNqYTVde4E00Ob07KpnBytjIuqpDcih4OWbRa4LczPITmvVcehjohbgNBkAOaLJPXOFlOXdm5G1M7VOqrLyiHRzpPG2HpwVy2bpKjjBoWMHqOT5z1TFoK7jotigfU4XChMw0LaDCDD8jcu7Od4NTZrRNhKgn8BQIyahdX8FOFc6/DknkpRRbtcnVnPpP1RJ6T6Kz00/iu9W2qjobIIfagwgCvOn9uyLa7XwHfAjnCzGv9aVrzj0ZsMqSE/FJG0xA/QEnwDdXbPZ79Qw3+Suh9wEdXPgpEeGVhHpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5SACww5GPjyvI1UVwdwjC7atVv45UhO9YhMz2cmCNQ=;
 b=KjoA9PyJDaVTH6Dph5m4uIHgKm6gKH2dtlyVfwLPgp1U9tYviFeJkqDkjICFqibTlDpbOFswxqWOs/xUp6x24yQ4Epp4GHvAO+VukO7tSfpRZn0GOaU1LJd1GeWqB92YQr3orgUHDo1eauMrr+D1hTYVTJC3m/OizGSGPTRtcSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 16:59:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:59:34 +0000
Message-ID: <df9dd2f0-ee51-4039-9bfd-658d94e447a3@amd.com>
Date: Tue, 3 Sep 2024 18:59:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] usb hub changes for 2025.01 next
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>
References: <cbf15d99-3869-4e14-813f-318ddfda9df0@amd.com>
 <20240903145602.GG2479150@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240903145602.GG2479150@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d235217-120a-409f-cdd7-08dccc39c924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS85RE1nanIwY1d4R3p0VE40MzBrV1VDT0pVa251RzBnNFNybnk3T1hGK1lj?=
 =?utf-8?B?dTQzdWg2T0V5UWFuc3JSdVhMNURXMHE2QXA4NWtoZHppemhMRXdrQnAwWW5w?=
 =?utf-8?B?QXVuRVlmYldBNkJSd2p3ZVV2elV0b1FTUHRvYWFGRkJCVzdLWjRsUDBVaWtY?=
 =?utf-8?B?c05oUjZKMDJ0UUpoYTliY1pLWUsrbGNxMTlNOWFoUENVWHFyandic3J2NXJF?=
 =?utf-8?B?bjZ2TGIvY09qVTlaM1Ava0o1MW1ZOG9hZjdOMHJOb2F0Z210dEkwTmxlUng4?=
 =?utf-8?B?MkM3TE5uZzRtZEFLU3FGYU5vTnJmT2pBS1dFMnpINWJZczEveXVZNTNLYVJG?=
 =?utf-8?B?bVh2RXJvangrd3VhS1V3bUNjMUllRkdHMnh6K1lIcXIxVU81WG9YcUVrdWRL?=
 =?utf-8?B?clhKYlRieU9CZW5xdTljemQvdElWQVd5bUlhZXVUa2dSQnJTY21za2Y2Nmxt?=
 =?utf-8?B?dWk1bzYrNGRrcXpXRkZlQkRKWDlBL0xtMURsU0RqWS81dVBhUnZvU24vdHJY?=
 =?utf-8?B?VE5qR3dnU1ZFd0FHdStkVlB1T0RSc2RFZDBRRGdDZmgzVTU1aEFWQzRZVTh5?=
 =?utf-8?B?d3BvYzNtMUVoZ1lqckdFMmNIZjg3VnJVOWdPQmxHSDFMd0VUMThTeVd2YmpD?=
 =?utf-8?B?V1JRVWpKZHVkK0svMEFqbmEwZS9kTkp1eTI2TW9lRnhiV1FnMUZ6TUQwOElR?=
 =?utf-8?B?cDFzRCttS0RJaHp3UVIrTHM4TlU5cGNJTUYyZm9yWGFyR2pUTVh0Q0l1Mmlp?=
 =?utf-8?B?dERQaEZESEsxVFIvMlJXeTlYQy9CY0tYWjRrWEs4SEVENXV2MzZ0ekNaTWp5?=
 =?utf-8?B?R2wyempqK1prZm9XMTBsK0lOdjIvRmxxTm51azBnYzhQLzcyQ1ZNZ2hKQ2J3?=
 =?utf-8?B?YVJtb2FOUDJpN0g4cGJaTDJHUlk1ZUU1SVdkKzNyYURldXpsdWFLN25QeUZk?=
 =?utf-8?B?UDB6cmhaMVRGWTZuL21kd2o2RHAyV1hmRjZ5Z3puSXZ3bHlINUUwcFpidHV5?=
 =?utf-8?B?ZlRFbUVFanNNZTkyOUpiS1NCQ0FoQUJUM3ROSU5MU2hYdnN1WHkyQjF0SzZs?=
 =?utf-8?B?NVE5cWhmT29kdVdyS1VtREVqRjZIaHBDUUJXUGNwNVRWWlV6VFJYeFdxWnRt?=
 =?utf-8?B?T0c0YnRBdDc5c2RrTXE4ZFRPeWhxcjJWU2ZhdEtBUGZ6VTgzU2R0ang0U1dF?=
 =?utf-8?B?UEpyUkwxUDcrVXRKSDRlSm9zZ21icHMzamJHWUs0bXd1ek83VS9mV0lUUTJZ?=
 =?utf-8?B?NVFSbm10K3FCeTIzZ0thR3p5c2g5djR6d3FTMnM5M3VCLzJOOUt3RHUvcDhX?=
 =?utf-8?B?dW9BZlRoQmpVWFZBUVdlRkdTUXFVbndHNmRaelFJclJIMklkVVJSR1dmQzlj?=
 =?utf-8?B?U3g3cFJNVldMamlNaGJwR3FVSzc5QjBiVTBqRTJ4bnBqMVU3c3JFT1VRMmha?=
 =?utf-8?B?VmVndGRxNDRHRC85bWFDakVXK2ltYU1VS045VGRuMWhLSEFlTkNjRVhoZFkv?=
 =?utf-8?B?Z0JOemdQem1aMGpwMitER2Y1NnhyaGFoZmRwbUVrSDZERmx6QlJFTzFQbWxW?=
 =?utf-8?B?bkRUbnAxWVhuRGQ1NkE0N0gwTHVocXYybFJnaVd2aWcyMUtFQjZIRFZ0QUti?=
 =?utf-8?B?SXF6L2lRMTN6YlNobS9HTDAreDUzWUVNUHNycy9lN2pWOC9WR0lCaVA0WUI3?=
 =?utf-8?B?dHBCb2tVSHozRGdZcUdxOFExYWhyTEN4S0hnZHdtOTRSNEwzUklaREdxdHVO?=
 =?utf-8?B?ZDUrVHJkOHVuL1lDRzNYejBkR1NCWURwUGxaaThiQTVXalpHeDZvZzZUdTcv?=
 =?utf-8?Q?ca9PzmtE11fTtcsmsmGrTKXgiPNGpKiraKBWc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFMvZGluWjhNYzlpOTJ2MVRhSWR2QzNJSmd1dC92RWR6amxOTElIV3RQYU45?=
 =?utf-8?B?dGtCZCtPOHRRc0YydTdIZ1M5VEZEek9UMHdrWkxKVEhnaURxZUJ0SVNYRUMy?=
 =?utf-8?B?WHVEcGxCelFDMXZ3TDdrMmd6T0MyZXdqSnYrZllIUVIxNHpyZjBwTVRnaUhU?=
 =?utf-8?B?TU9pTDl3N1VjZVBtU2xORUM1YlJsQnc0dGJRWStjZzBGWEllL3NLR0NQZnZ5?=
 =?utf-8?B?MkhLU2dHRm50b3ZSeVJza1VzQmpJUTB4bFkzekVNR09JSG13dTZJb3BMZ1Fr?=
 =?utf-8?B?NU9yWmN5SEkzT05RdkRFNS83QTd6amQwS0ZxMmVlRzVQTmZSaEZTbUJjSEor?=
 =?utf-8?B?b2lpUWNOQm4rTWFrRzlpR2N3MHBQZU9kM1JxU2lDTDBBcTNWNGJUTml4N3A0?=
 =?utf-8?B?VzljVUpNT0F3ZXREZUdzM3k0bVJ1Qk8weXdVM1NFalp3Mm9BN1M2Wi9FcmJq?=
 =?utf-8?B?UzROazZYZ3JzZ3hwcTdjR3BYYWRaOUdTVUdrNFhnR2d4b3pZTCsyaGhCbmsz?=
 =?utf-8?B?VlU1Mnk3ZDA5UnViWk9oNHprVWNzU2o0b0hVd0hqbWNsY0d0L3Q5aXovWHI1?=
 =?utf-8?B?c0NGQkhRVHk2cm1qSkRnbWt4Vm1GOTFqd1Yyb2hldkVHdnhRSVk5Z0YzQWpa?=
 =?utf-8?B?YXNvb1VMV3lzTytQUmNxcWx6cjRIUWlvSnZsRC9oaDE1NEJuM3FwTm80bDFo?=
 =?utf-8?B?NUExbGxTUVZyT201UmtDUkpqYkxuWnRRMytPSTBVUHpMRHpSMWFDTjNhYU1M?=
 =?utf-8?B?RHJWQTNvYklrRHhVU3RUUzU3ODIzanpiL2c1eW1hejNDK1FVUWhpSUc2Q09H?=
 =?utf-8?B?VDZDZXVpdVpqN3Rpdkc3ai93MkRmSzhWNVN0OTYwaytiT1RGYVBRTUFVWldR?=
 =?utf-8?B?NFlReDdWcEorR3NLb1NHUDEvUzVSbTc4TnkvNkU1aGc5dHVSSks0MzhXWksx?=
 =?utf-8?B?ZWhCVThrd3FOZW1ncUR3UTdJRHNqQ1hENFZhb3F0bnIxM2EzKzBNMitjZ2ZW?=
 =?utf-8?B?ODl2V3FCUXpKUFVQY3BXckFZVzY0SGwrTkpqaGxqSlJoZHdvODFnUURiZDF5?=
 =?utf-8?B?a3R4T1VtOE9nU3IxQWlOdEE2QzJKRnZNTzFiS0wzSVdDNGZkak5MbkFjbTcv?=
 =?utf-8?B?dFpRVHN6T2NBb01McFdYYmdHOFhpb1VHNVZtaEh1MmZwMnRqNEhwZVJ1SjJs?=
 =?utf-8?B?Q3ZIbFczYWJUOWU5a21EU0NGOXh1RVZEVXpsaFZRU3A1dzlGNm12TnRGMVRN?=
 =?utf-8?B?aVBjTk5OclM2TFJPakxHZ2Z5OTdHQWJRalE4ckt3RkdtWFVFZElsUEU2ZTVa?=
 =?utf-8?B?Q2U5dFhGSWVLUXJERDljbGhDVzRzTFhEOWNDYkVLTUV5aGMwS00rVVR4aWQy?=
 =?utf-8?B?c2Q5bTRmU1FSVWhTcDlZN0IvNndIMkJpd0swZnJyYlg4YUlSTDhBeGprNGZw?=
 =?utf-8?B?UGFsQytoTzJJTWEvM0dMMFdkNDg4OG00Rk16SnpiakcxdldaMndUV1ZKM2Yv?=
 =?utf-8?B?cjZDOFdicUZ4YytpT0RTUnBiRW9leHhkMmt6Q0M5NXRvbm5UZk1RTVJ1WldU?=
 =?utf-8?B?ZVhSVCs4TXdmMm4xUGlYR0R4bG9aZWhGc0ZUY0V2VTVpRU1yMXJCdGc4eXVF?=
 =?utf-8?B?U2kwK1lxUmJsZTRMckhqN1JURStGV2lMR2kzUFNwSDYrdTFjVFJwZ085eDgr?=
 =?utf-8?B?ckljRmJ2UnZFYVRqQ3VNbWRKSjFndWxQRGUyTUFjc3JxanpDRElOQkJFN21G?=
 =?utf-8?B?dEI5dGFUV0pLektoY1NjOXZMR1ZpNHVUbGVQVTNOZkYyb0phcFp4YU9uV2RN?=
 =?utf-8?B?U0FGRGZHdnd2cnFJSENvNmxxVUUxaC9wWlRXN3BuUnUwOXh1djg2VFIwUXda?=
 =?utf-8?B?VU0vTTFNNVVsTEJ6ZktySEFvN2JLM0gxOWFQQ0tEaS8wSmFoSjR4RTZwOFFI?=
 =?utf-8?B?ZUFaa2h5eEhrQUxaZEMvQ3M5emtsem42SDkvSTV2bFJMZy9hZVZ1ZUJYaVBw?=
 =?utf-8?B?a2src2Rwakdzdm93ZEdoNGJvTkpGRzZwWGlnQUpMVmJ1VFZUZnQ4S2VtRXQ4?=
 =?utf-8?B?QlZCanNjVTA1c1JIZ3UvNm1zRytVZVR2M1ZXZm9UcDN6Ty9udkVLY1ZPdjk3?=
 =?utf-8?Q?TM8GW37Tzgu+YJB4MvuJYeEJg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d235217-120a-409f-cdd7-08dccc39c924
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:59:34.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/KbdHDQ4FYcuPsBq7mGeZQVFmKsLXJpE0fh9PWGbEM8i4RL7S0L8A3e5Pa+IkqZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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



On 9/3/24 16:56, Tom Rini wrote:
> On Mon, Sep 02, 2024 at 11:53:46AM +0200, Michal Simek wrote:
> 
>> Hi,
>>
>> please pull these changes to your next branch. Changes have been sent for a
>> while and there was no reply to them.
>> Here is the thread.
>> https://lore.kernel.org/all/20240605100221.3571-1-venkatesh.abbarapu@amd.com/
>>
>> We are doing the same changes on Linux side and they should be merged soon
>> https://lore.kernel.org/all/1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com
>>
>> I also queue them to gitlab CI and can't see any issue.
> 
> I see that Marek has now had time to review the patches and so I'm not
> going to take this PR as there's been changes requested.

No issue. Good that we got comments.

Thanks,
Michal
