Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E1CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 11:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192C480B9B;
	Thu, 21 Aug 2025 13:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMeqdEiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B965880EE5; Thu, 21 Aug 2025 13:29:10 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4D380548
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 13:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InC/bbUABdKNrWOmTeB1HGFr/VT7GTej2EHnOIRX4rJ0V0aQ0iaekEu/yd3PJRyDD26kPnERZvr83ghI5/O+iL/mMV3PXW1CYPkZNfy4mtFq3qsSUS+wGo1lrSNTROPZ0r2cN4h4sX48vnr/THoqlpfyQwtBJSfOtRwLESfmrmE9gFgPNR+NRG7Hz5L+dT+UzeErsnvF3n8B4XAQ6u77pKTTvQW+pVTc2GI9mOvSmtICgu/E9KYNs3eV1OcNaMBtRhbGazeE1oR80Q6bY5nNQf4D1N5w//0RaF88O0Gb8eNYtLwHnt/jfJQuXUKhv3dT1wSsNUMubAWTolDURPUKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwLddQdbKtc6/hrCyXU/bv9CpZ2c135jMjC1OTtVxHs=;
 b=vaZ0oD0PDBhXGvvc+vPlyRGFAiWKjXWtEytY/f5atzoBEHV/9xz2+eI3ksxtxm+G/AoaDY48gn1jIOD7wVBkoXLkJHQ+Dn5fv2P3veOxaUzn5WDlH5VWfRpuNcQWkOzQGI1hwI6htf9B838jWixJXpmBvIjUI5YieF3HYw4HkngCOtnNMGYVaUkSnpwX9+/Y7yhb8bfXH+LTR5JVfUIxPhitEp+BQjmjXk34vDM9yQuJ3aj/3lF7DkV5F/6xlszXtbBEI8aslebn5gZSEV9WTDhfXaCGLK0RHBL3IOg8NltgFnLDRuo74W9WDhDCDKJBL7v1SC3wjkcYCnuOv5z8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwLddQdbKtc6/hrCyXU/bv9CpZ2c135jMjC1OTtVxHs=;
 b=nMeqdEiBqzVUzJ/qqB3EUQ2MvxNAVTT1Ub3XQ9zCz5df5/xyslWcd2LKw3+9qmu5EfJT1mAtxquA/9Q/H9S8Z2gn9cCdbUzI7zF5KFUpf4kScsBHDu0AEx8sQOz5KBLYyaExd7NEla8hcnizuDL8JC212lGqfkSyjrdXXnHCiQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 21 Aug
 2025 11:29:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 11:29:01 +0000
Message-ID: <c2a3141b-ac07-4ee7-acfb-bc527b0aab8d@amd.com>
Date: Thu, 21 Aug 2025 13:28:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal2: Add usb_pgood_delay for versal2 boards
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250818045304.4058177-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250818045304.4058177-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ5PPFF6E64BC2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e0627b-d3d9-484b-3676-08dde0a5ed8c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUtoMmxtS2hoVGJCYUgxZnhqc08veVJkSDJTWm9zZlRnYytPTmdHSlFETGc0?=
 =?utf-8?B?eU53WVphTEl0L20zcERXdk9JTDVrU1gxYTYwajhrZm5sanV6VU95czBhN3pH?=
 =?utf-8?B?T3FmOXBPVWVhMVRKdTZUOC9EOHFhWXp4UEd2WkxpK2dQaEF5WnN1NFZ4bnVu?=
 =?utf-8?B?RXlMb3lITE0xSk9aRTFSN0hSSmpuZ1FjRkdHdFMwWVpzTzVpVVVhMytLWFov?=
 =?utf-8?B?L3JQZVB4RThtemNBR3pDcWpLVWgwSjJnNXE5UHdnUlBTcGJZTGpUMmd6NEVI?=
 =?utf-8?B?N2U1VC83RDhKaktvcHd5clpibVpqK1Y2czkxK0JidGJqSE9Rbjl6YUVxWUFZ?=
 =?utf-8?B?R2RBYzQzVU1xbFZCM3VKSTVLSTFzc21ScDhuWllPODg0Y0hGYlJEbXFOZmVj?=
 =?utf-8?B?R3JMaitWeTI5UnBHY3hoZTZ1Tk9UZVF0MjBPM2dYQ29QOTAvVlc4T01VbDZ6?=
 =?utf-8?B?c05SRmMrbWJyTXg1QlY3L3A2UWxUcW5acGdjSVB0Q2xwaEVucGwyTWdsRFdh?=
 =?utf-8?B?eWY2S1lhV3NONVkyOEFCTTdyQjR6NWdBMkFjdWRTNWdRbUltQkljSHhPVWpo?=
 =?utf-8?B?QmMza3hYd1pjQk9Bb3dPcnl3azRFNGRtUW9NRU13dlFpRTQyeXY4cC9XSUVi?=
 =?utf-8?B?ejE2Zk9LbFNrbnY5dHRtSU95Qm9MdDE3cEdZWVFVUUkzazlZSGVSMHpGQ2Zu?=
 =?utf-8?B?TVJ5bW81N2o1MTFjbkxiVGU5WExSejVSc3o1ck4vOUMvMmNOV2VPNFZ3YzZK?=
 =?utf-8?B?Zm9qdEpPQlVlakFyZXVEOE9JbklhVW56MVYrMlZ6T0FZQzhzR3dnY0ZTZTQx?=
 =?utf-8?B?VDdFU2doMzRoaElyYVVZVjRwcVlZaERhNldNd3AwajRqckE5Zmx5cG4zYXVN?=
 =?utf-8?B?L3F1bnBFZkdMVGpkOUxkZ3ViTmc0emxWOWxxTDNMalpIUEo4MGRZMm5HeVBn?=
 =?utf-8?B?TW1uTjg4VnR3WC8xb0xyVTI0MytqNS82dWdjb0xZdmtEdVVJc1hBaHlTcGhQ?=
 =?utf-8?B?MS9pQ3hzbmVlWXIrVldwc29EN3JhblNTOWVTek9GRE5OdkVqMEVvejF2Vi9K?=
 =?utf-8?B?eHZNQW1nNjNYUlpEeGdNQnZSOFZ3N3BWNWRVbnRHMGtkdGpBOTUzNW5ablhh?=
 =?utf-8?B?TitXK2ZUK0p3Vmw4bXl1clY3cmJtR0Fsa3ViVnkvdTIxYWloaDIzcUFCU0FS?=
 =?utf-8?B?MHdrYllObWo1Uzh2dzZTdUhjUFp4YmxXVmZCZUk3UlZ3QzcyWndjZGpzWG8r?=
 =?utf-8?B?RTROKzhIQ3NtQ2NmSGxGKzJDV1UreXl1dWhYekFBejdQdW9BMG5aOEcwNUdt?=
 =?utf-8?B?Tml1aU91M3JURk0weHRwaERyV2t5ang4Y01Wdm14NFZBTlk0SHFrQzc2Tk91?=
 =?utf-8?B?bmZHWWMyVEkyTDh1Q09IRDQ0SDRuYU1xWDBGNEUwN2FKZkVGS3J2SFZaZTN1?=
 =?utf-8?B?d2hsb3I2b1hidTJRZ2Z2bkF2T3BiTStMQVgrdHR4b1IzYmRmdlFDbjFGOU1r?=
 =?utf-8?B?RXpCMjIxZ3NYdzlVeVkwZ2JiSVlGWDFWM0lKOXpCUUZ3NTZxaVVzRHMvWlRt?=
 =?utf-8?B?MzhyckZOaEJLb1FzOEJQUTdtbk5PMUdMZXl2V3pmUy9BWmFmU3lrRGYySUVi?=
 =?utf-8?B?TVRITWhTWCtxdHY5Zlg3QlJZbVlYSXF2TzJ3dm14QUpUNnF5WVVMczUvVXJ2?=
 =?utf-8?B?NjdTeEhaamdUMUx3L2xkb3ptS3VEelNWMEVRTlhjczQ3NU1WWVpBWlhmVnhP?=
 =?utf-8?B?M0JDUVNrTWFKYXRVbUtKQXVWcm8wa2hSMzJrWkNYTXF1QjA3ZFNQTU1yWGVt?=
 =?utf-8?B?ejhsblcrMS9mcEh1S2hqeDVwZFZ0TkVOb3MxeTZObFNIR2RHSnM1dk5sREwv?=
 =?utf-8?B?YU9DcDR3d0dmRm0rYmFHM1VoVEVHMTB1TlFWZ2xTdUNWWjZyTG53NmZ2OUY1?=
 =?utf-8?Q?b3fYHQHp2/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2MrRjdyV3FvQU1KRDNNTDhrb08xeFRhd3BiMkIzOXJuNVlQaWZsVHVhcGVr?=
 =?utf-8?B?ajlPNkRqU3gxQUJFOERlOFdnVWhRc1JxWHpkcUNHVHVSV3kwbEZBY1pLZWdI?=
 =?utf-8?B?WTk5dlE2OFVkWWdvclRFVklxaHFkOGhiT0E5bHJ0RkNvUkF2TWtJU0gvd0tY?=
 =?utf-8?B?WjdWRm1FbHFhcDZtVFlmZmNKbS9PbzMyZTVwN1gwL0hFMTEySER0azcyZFhO?=
 =?utf-8?B?aElYZSs5R1Vmd0Z3OTdjd3JUaHpnQmtjUXQ5VjhoUjZpMGYzN1lzck9SMkgv?=
 =?utf-8?B?Q1h6d1JqcCs4NlJWUTNmczcwbW5yZWlRZmJYb1hwM21SUHdnbVMwYzFRZ2ox?=
 =?utf-8?B?dU5RSnB5N2w4d1FxYmhJMHRCdVhDcmFBRlRkMk1aVlFVYWxUNkFkYkVwME9W?=
 =?utf-8?B?anNEWEtHVVBVT09TUEhVbDZJOFV0NTM4eGRtS2p4NnliQkl0emQyYkx4Z2Iy?=
 =?utf-8?B?WC9VVU9nRnprVmhiRmRTd3hZeWdRZjdFa2ZsZVBZUDZlWk9OQ0YvZmhrZlk0?=
 =?utf-8?B?bXA5Tll4dmFLczJvOWFnNU1QcUZ0Q0ZYZi9GZGJVUmJObmVPMG1NakkrZ2RF?=
 =?utf-8?B?VmFvSzI5cW5BY1AxdUk0WW1hSlRFUzd0U2FnKzVIQWJSU3BWOThiNjg1THRM?=
 =?utf-8?B?RExwYlhjZU0zaFpycmVkTDFyZGVBWklmYlJ5amYwNU1iaUVVM3cyQlYzVW5Q?=
 =?utf-8?B?NHdsNzVMNVdwZk5DRHZWZjMyTUJoTnlVZmJKUmtBem53MVp3T3JHdkNaWEpm?=
 =?utf-8?B?TTFEczJvV3NuenliaHB5M3NrbUN2V3lZSDFJNUQ1Y1d2R1Q5STRlOG8vNzZO?=
 =?utf-8?B?YzFSUndLcmZGT2c0aHllN2JSOFhiSHhHVUZXcWprMmtic0lIRHNvWU5sZEJD?=
 =?utf-8?B?emdZaGw0MDdjUnozRGpMazFjbG41VHhTdkVDTm9ZUU1YcUljZkU2TDVlbzZQ?=
 =?utf-8?B?ZDN3cHZ0bWhGdVlvVVNaWlF3WkxIZHhtS3pqUEIxTm01dlFITS9ML21XVnVT?=
 =?utf-8?B?cWZxNUpacXZ1NkM1WHRHNEFTNU1GMjF4YnNWb0xHVmc4eXY4VjY4NkxTU2VH?=
 =?utf-8?B?MVd3RFpjSTlaZVRRNS82Q0s5QkdYb1RiZWZ6Q1dmaDBYVlFSRU1UbDNnVEFP?=
 =?utf-8?B?L1dJWFpqdVZ0NkVuMzdjMSsrTC94Zm1EdWVWdlRJbWhMM2E1NERHSDJDbE5T?=
 =?utf-8?B?RzVqSFNqVS9NRUVHNmpVamdFVjVTWHpQZWI5RnFHVElKdG8zaFJGMk1DZVdh?=
 =?utf-8?B?TW5qQWZHeTVrRTZzcU9YQXkveE83bTJoNWQrR0ZQMDFLWmkyN1V6aTFjeWEr?=
 =?utf-8?B?ZXFIUDhPVEJMa1RpZGlGdkZZbGtITVljVnBaOUp5cytXWWpWU0VNOHVzVlFq?=
 =?utf-8?B?MGVHQ05MSGhPdzhncENWSEVwY3FXYkEyZlRTdmtrRmdGTXpVb2VSRnhESDZk?=
 =?utf-8?B?b2hqcWlHdXBuZ2NtWmVOSitEUWgxWklYVWpWRFd5d0t6cVNNdWZpZ3gydmRu?=
 =?utf-8?B?bTM4bU1jTmdGMUVubTlSVkRZbDFlMTJ6clhPbHZEdnlmcXlwN3NpajZYRFZo?=
 =?utf-8?B?SUVRTXc4d1FvbzY0SEVZVmMyYnB2RVdQYWxSQko2ZmdtLy9OTnVDQkJYZTF3?=
 =?utf-8?B?MkcwL2o3Q28wUm0vSlE3cndvQWIzeE5qRWlDL1plSkczUE1ueUpSYURrV2VY?=
 =?utf-8?B?VG9rR2JaRHI3bTFGLzVRL3Z1WE9VWTRmVFJuRmxzbkR6U0F2ZkVJWURrRnZ5?=
 =?utf-8?B?MlNEOG9UaTJ3SS9aSWpqaExQdzE4TnNKV2dyNzliNjFSbmZlUXpDcUQzVlhO?=
 =?utf-8?B?azQxUVFlbVhVeXpERmhjSWVuVHU5elU5a1lPOHBGZVRGSFI1NVBpaCtFWWpu?=
 =?utf-8?B?Mmpvc1pCaUkyczVNcWU1OGlKRGpkOFBETUpBYm53R1JnR1FiOFJ4VXp4YzhF?=
 =?utf-8?B?UTFaU0JQbHVTK1JaMGhGN3V0aDJiVUVVTE4yUU5yTWdPd2RaWEZHS1FzUitp?=
 =?utf-8?B?SGtlcThic01DM1A0blJwdlp6RWdwQ1g3MGhjYm91TlA2TE1aREJ3eXhlcEpG?=
 =?utf-8?B?RXNqTm5UTlFpUjB1YkxYTlpJV0hjUFg1WnVXZ1JqaHVMY282djJPcFIvbElt?=
 =?utf-8?Q?f+hdf9PLMMLYasfMllmG2+rX7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e0627b-d3d9-484b-3676-08dde0a5ed8c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:29:01.6943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I/keJyroTdhLbkhY/K+KQJ7sTEekplJIq3C5Ig++3AwqEPPWzD7JHHIYaHnscja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF6E64BC2C
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



On 8/18/25 06:53, Venkatesh Yadav Abbarapu wrote:
> Add usb_pgood_delay to ensure proper detection of USB devices.
> Increase the USB power good delay for versal2 specific boards,
> as certain USB sticks may not be detected without it.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   include/configs/amd_versal2.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
> index 1ade6adfa0b..40dc9c5ad8a 100644
> --- a/include/configs/amd_versal2.h
> +++ b/include/configs/amd_versal2.h
> @@ -151,6 +151,7 @@
>   #ifndef CFG_EXTRA_ENV_SETTINGS
>   #define CFG_EXTRA_ENV_SETTINGS \
>   	ENV_MEM_LAYOUT_SETTINGS \
> +	"usb_pgood_delay=2000\0" \
>   	BOOTENV \
>   	BOOTENV_DEV_SHARED_XSPI \
>   	DFU_ALT_INFO

Applied.
M
