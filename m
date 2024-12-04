Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC51E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 08:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BBD8916E;
	Wed,  4 Dec 2024 09:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X0dXY4Fb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADF889671; Wed,  4 Dec 2024 09:08:36 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15238890D8
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 09:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfUnkejGiEhcu0t8iT71j0YGISR+d2savHuKJmIjjI+MJ8nQdvntfkZnPq34rDL0dS81SAMOmQv/7mIGhmEkVAcYA53I78AnTBXqmyzjIm8tLVFNoUrzpUTWrEj0vG2SH1bKAPr722fjorUBhmithjV2qT25fPffDhNom+Kz9pYZCEYpsSKMYMl/pe/6FUFGWJnwmls30eEDkajeyrLYYkO2mNO5RUrVtPEPe2cmKPopcyypjyhwipCXk1OefR44Qg0qN4PA3NDCB4z70uflTpIiDSoJZmTxCM14PQcRFsZFT8SHflFfla/9cb7MesdDmlLanegSqgGX6oqRGsNUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAroGQfyfz2SNE/YT9y8f5PJHHWmu0P4B0k8JR4rA9g=;
 b=daColoCI6/+lvJtFhv8MWNjVo7YYa5nTm0zU68C/6FFon+TRTHTOcYeQPu1T5K5U91BPcz7TH7dC8Cktgi6f7ab+v9YjITm5AgRT0FTp87obDwnf3ejMgA2daiuPjP281fHy52WS0ghmQidF5/8sjkhgGrN2ONXtfoD8nHFPmX0xwx4N13K1b0cRCaVFs7Y64aw6cIxAk9KqBoxqVLrH5+2bcQ62tkaI+KB6kywpAQCvDIlRaATCzhopsPQFJ7UH88n+kY/IKKCFpB5QGYhKWt0Kx8jrUqVYQo627Kh3eylHH7qNMM6rJCJ1DiFF5vYmKTJ46OIKKfu6KZHjU2kbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAroGQfyfz2SNE/YT9y8f5PJHHWmu0P4B0k8JR4rA9g=;
 b=X0dXY4Fbef4rCodXssaiO/7egIcEHHsYnZVzYzKisWy1DI8/wv0mD2AIzH/lbprWJBJyXSoWeinLWlvMc0jNZLa9dGekj9cTn8frUuqDmeDdUhe8eDlP1vZctDMCpU3pMtuvx0lflaRGBog2puAx1SGlI/APXwIFk6PXo9Zzzj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 08:08:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 08:08:28 +0000
Message-ID: <c0138c5e-4cbb-4b89-a48c-0b0f7dc3784a@amd.com>
Date: Wed, 4 Dec 2024 09:08:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: onboard-hub: Update the bind function based on
 peer-hub property
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, patrice.chotard@foss.st.com
Cc: marex@denx.de, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241204072520.213949-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241204072520.213949-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0275.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad8fd8b-91be-420c-5b15-08dd143ad589
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXZheW1rWG8vb0JRUTJnazBVTDZKcGNUZFpmY0JpRHdwQmJYeXY1NWJDUGE0?=
 =?utf-8?B?ak1RdWFGRlYydDNZVVkxdUI2RG5IK1dUSGhVT3IyZVJncVFxSVk4WnJybmgv?=
 =?utf-8?B?YW9PK0VsczR5ZWFSS2puRjcrNGJ6ek1LcWZaRU8zZ2NUYUVCNmNzSlVSTFF3?=
 =?utf-8?B?eVBPREtrcUFsTldMaXRYWVZjTEZ0OTJTQVIreFZVcm9mYlI2eUE5T211SDFK?=
 =?utf-8?B?VEFmWm5TcVA5eHlQQ2pFelBRc0RGUVliN2lueXRGRVRlaDdadGpUSmdFZEV5?=
 =?utf-8?B?ZzdkN1pkVnlWVDBSZlQzOXVpdDhGSkhVKzJaQU5idTBTRHRsaUVQYWxVOEkr?=
 =?utf-8?B?VWNUbm41Q0gwd2hhNEt1bURZSDlSRHhROEc1bDk5dUl3UmFDTXVnMndYdUx2?=
 =?utf-8?B?NmNpck9OYkc3bmlBdFhuZkl1U1BMOGlQRmdqZFh4YjNxakxoSmx3QTE3elQv?=
 =?utf-8?B?aTg4a05PMDEwRWNKcEZsUDZoY3VLRnRjeDMzQWd0V2pJRHFsWUxZVkRURm5H?=
 =?utf-8?B?Sk04RHJvK0VQSi94WEYwQkU3NGEzR1RTZVRqTHdVS2UrSFl5OGNTcFJzajJS?=
 =?utf-8?B?YzJablVYTVpmR0VaRVl6dVZjL3pubnFFY01uYkNwcUJQMXRNdU5oUkd6UEMx?=
 =?utf-8?B?UnVIYmVUc1Z0MjNHWDBBN1dMcFZYVHd4YzZXS3VFY1hLMkdPdGJjUzVtNEtI?=
 =?utf-8?B?MTdzN0VuNjd0VGUrSkZkSDRQL0hhMU5UK2ZXNWNLd1FCMzgxR3V0bHUxR2xW?=
 =?utf-8?B?RjVQTmNwM3NQZXM1Rk5IZE9GL2c4UlhlQmtMdXVTVS9Mc29HYW1ZRCtGNTdz?=
 =?utf-8?B?eDVNQmJRNGMwTC9PRW9DVG1ia2tOWUJaTDBteTdXUzBPZHEyWXlXZ1BsQkVu?=
 =?utf-8?B?SVkxT2gyYVoxdzhxQ2JhTGcxVkhtZW8zVGJzSGFrVHdyT0QyS0lGRFFYb0VX?=
 =?utf-8?B?NHltQ3dkUHlkTW9yb3d3Y2R6anExcjlvM05Yc2s1Ri9NdWxFSEhvWlRiUTdj?=
 =?utf-8?B?MXJwbTdPeVE4S0QrMVRCQm5lOFZJUnFhMjJpTHpCQ0NneEJibXB3cGhCNnRS?=
 =?utf-8?B?cVFkTWQyN3Foby9IZUNzYjg3U05sdmVjWlhRUysrcStJdmZoNE91RXY1VU0z?=
 =?utf-8?B?TTQ5OXVINU0zT0tPYktnZW1UVWFEQjVmS0tBWjdDUDI2YmVhWS9XakpJYVRJ?=
 =?utf-8?B?KzlxVGs4cDcrR3ZBdjRhMURTNkJFcGlQOTh5VExzbjZ2N3czWXZzTkhHRi9p?=
 =?utf-8?B?akZZek1iaE5SZmhGUEt5SkZKU3c3OUJQV245eEN2UThqNFdJVnVLZzQrUkxn?=
 =?utf-8?B?eFhLemZ2WitHZTZjRGpLek14U3FYbGhtODNrRDE3UTgrU2xaOFF2NXM3djJP?=
 =?utf-8?B?Z1pjM1NLZjZFQlZvSUNzdVZwSU9sS3FFWTNoVW4wWkRtUU04d1FTeitZbnFW?=
 =?utf-8?B?SmJ6RmhWZGdEYnVSVUZ6aEpFeDRhVW9HNDh2cnlIQUF6WHg3RWc1UHEyNXM0?=
 =?utf-8?B?bUFDaHRJOFVRakhrcGpiVjRDaTlrclB1ZU1BRWVGYXp6bHZWV0lmNk5BdWhZ?=
 =?utf-8?B?ZXFMZ0RXMmtJVGU1UVFvU1hUeVJJSTIvemNzNEFrSmREWTZ2U01ZTHdoS2pj?=
 =?utf-8?B?cFFQL05SVFFuK3RqdGl6bXEvMVMxZmE4bDd3Nm4rQWlhRHcwTGt3dXlxR3V4?=
 =?utf-8?B?WFVWY01JajNERmJsVkxWVmVrRnVZWWdxV2Jvc3RrWlRCTlN0M2ZMVHA2R3Ns?=
 =?utf-8?B?a1JEdVRoTGxOVDUxSm03OUxrNGhkeTJadmJzMEh3cEF1ZWEwQnhKRFU0UWFI?=
 =?utf-8?B?NHpjV056ZW93NjBqRHVPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJYVlM5OURyWVliQUJMbmEwWlg4RkUwNDdZbEdNTmdEWVpBeHlFNDlQR3Vz?=
 =?utf-8?B?TS9ld044eS9IcVQwMEFZMmQ4eUlBdEtEL0daMi9QZGNwalhxT2FvRHY0NGF1?=
 =?utf-8?B?OFovSDZwZ2djZ2Q2OWdCVFNjMm9kaUFxZzlkUk5DM203aFhtcDVLTUt3UHlB?=
 =?utf-8?B?QnNhUmU4ZHBSOVZ6K0FjcFJGZHZHQjlGVEpidXExVldEa2R0ZWh2SS8raHhY?=
 =?utf-8?B?cjRYMmNNVjIyQ3kvTncrVEhYSkQyZnBJbENkcFU5aHNGdC9OYmRUbksyaGJs?=
 =?utf-8?B?VExJYWk5TmpuNkMwNEMyK1gyL3hIYll4S05zYTFnR3pVeVpOT2NJY3RkZzFl?=
 =?utf-8?B?Q1grWXJpcGQzenl4bDZEVzVXWG1rekVMTHZXY0RKeEorQ1h5Qk9Ob2VySWIy?=
 =?utf-8?B?eXRmRUxkMlNJdVJ0TEorUktTQUt5S21sZ2g2OGtJTnZzcWU4NkNjUHUxM3ph?=
 =?utf-8?B?bjl3aGxvMHFIa05kYnM3UlkybGxDd05IM0VvY2VBVmdnWS8rVW9jb0Mycnp1?=
 =?utf-8?B?UnNWdi9ZSmJDTkxMaUg2TXNrZGZGRWFzQkxzSlBaczBmeDdCUXdNUFNSNTR4?=
 =?utf-8?B?dHo5SytxampvdnN3czNEWi8xVVRaZ1hUK1V0WDR5UU1IbTlqTTVRRlV0VTli?=
 =?utf-8?B?SHZpdHAwdGFoUkJrcE05Z2tsU1VPRy83NjJybzUzMG54Lzh3R2MxRGphblRZ?=
 =?utf-8?B?cTlHUnFBTkJUUitXNk8wRWpsMjkwdzFqdlpxSzJzeXZ3LzIycFhEcUF2TVdI?=
 =?utf-8?B?eFZBcmovTHdiTkpBSUZSdWM5ZCtBcW13VnI3L1NqTmpMSEFSNHlaZXZITW5C?=
 =?utf-8?B?U1pxY2w0S3huYis1NVZsemZKYW8vbWpZMnJhaHRJVmNiMmVhMldFeGFNUXdx?=
 =?utf-8?B?M1M5ZTNVUnF1dVVQdnlxV21qQ3ZGTjdkYndET1RvcWdvdXE1d1BBQnJkMXdN?=
 =?utf-8?B?YmlaVk5zaDJ2UEl4QXZOUDZaVWluRnRGRFBja1Q3K2czZytESEQzM1k4UFFj?=
 =?utf-8?B?REJsSzZBSUtvNFhwUFFUajBvWExidS9CV2d3bDVxY0ZiMkNON2pXZndhdFRB?=
 =?utf-8?B?WkdtTE1TQ2JjZG1PZGVIWmNvdEM2K3RjaUJkZU5LTG15UzFQeFlmSVduZkM5?=
 =?utf-8?B?enQrZk9Eb2dDcXQ4TkxvWlllcjkxWGR3OU4xc0JmbTVTVTBST3B4WFByUk53?=
 =?utf-8?B?OTBxdkpZTEZJZTFmcDI0bkUvaEo2V3EzaE8vaHg3WU0zODcvWUd5OU9ydlM4?=
 =?utf-8?B?MFpvd0RNYkU5TThRRWZKTmRXcjVjTWZnUXBHdFQ5ZFVjTHpLTjVxcU9qZW4v?=
 =?utf-8?B?U0taT0xlTkZEeUZXUnZVT1p0MzZkN3ZabGFIUnhKakxmamhyUjhQYW5SL1Rj?=
 =?utf-8?B?V0N2YmRSMVlsM1pZU2NTKzFzQjVPaFJNcnVHclQ4TGJYMFpRcCtpVXllRCs4?=
 =?utf-8?B?RnFuR0wyVUN5NjdXWnFqWHE3RVQwUWkvUC80NHhZM21wSE9hTUpmbW41dEht?=
 =?utf-8?B?L29DdS9yaldNZnZsWFB1aHRpdVZrSU5MZ1o1amNvQXBnNmNWOGhCQXBwZ3h2?=
 =?utf-8?B?anY4R09BZnkvNW5sWDMzekpMazlpcmNmM2FxZSsxWWhQTnMyTE9aWC9kcWF3?=
 =?utf-8?B?OEtaOCtXNW9IV3NyZXRvU3k0K2pKV2pmbTdlamxqQ01WcnkveFErSTJoZVZv?=
 =?utf-8?B?MWRyQXQrN0tYcFUwcit4NG9Ib2h1dmtFRUVHV0x4V0E3OEQ3b2dSTHc0WC8r?=
 =?utf-8?B?SDV6Tjg0VTR1Nndybi8veFNtczdEazV5WWJ4WmkwWHBzeDBCbjZwWWMwelFi?=
 =?utf-8?B?QjdCQU1TNjBNVTQ5UzNwR1AyQU50T2Nza2N1NFE5enJEQXVsMnJVaGlHdXZZ?=
 =?utf-8?B?Zk9MUVdYK3N1Yk5qcEZHWlMwTEZwOWV4Z3p4RmR4VWxTVmtwcFlaVG1rWU1S?=
 =?utf-8?B?T1h1b3FldVo1dk40aU55V2d6RXR3aHUvT01rY2IzTGF2d3MvZEx0ZkVHaHhh?=
 =?utf-8?B?dks4eVBLcDhQMGZIRGRzV0ROSTJLNnliK0tYK0MwT1A5alN2UVBaeWNUWnRx?=
 =?utf-8?B?eTF1K0tFMTR5ZDFLR1h3SXFBcFVWVHhpdlUzbXJnMVlkTUFhcHdpcnc4Q2t4?=
 =?utf-8?Q?baayqRb32Jlije8mWPzsH0D0o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad8fd8b-91be-420c-5b15-08dd143ad589
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:08:28.2154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL+RMvnPFoEDSIBdPxXi468T2bmG5ULUKlDaKlhLgqeLl3yjt2p3FpGeB8AdlReJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
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



On 12/4/24 08:25, Venkatesh Yadav Abbarapu wrote:
> As the "peer-hub" property is optional, don't error out just
> skip the bind function.
> 
> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Removed the peer_hub variable and used the return value.
> Changes in v3:
> - Removed the else condition.
> ---
>   common/usb_onboard_hub.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6f28036e09..7fe62b043e 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -183,7 +183,12 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>   	int ret, off;
>   
>   	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
> -	if (ret)  {
> +	if (ret == -ENOENT) {
> +		dev_dbg(dev, "peer-hub property not present\n");
> +		return 0;
> +	}
> +
> +	if (ret) {
>   		dev_err(dev, "peer-hub not specified\n");
>   		return ret;
>   	}

Looks good to me.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
