Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89269C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 10:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1319885F1;
	Fri, 31 May 2024 12:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4pdd/aq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF841885AF; Fri, 31 May 2024 12:21:10 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4FE7885F1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 12:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnWC11Of17qR2xOrS7+4O35uEZq+pjz6ZzvKV4M92fT4aT07fbWxLFVMzlZLYf+K6Fj0osoAI4f4mT6yjmakYHTniRu6GnATFVOQERUPUHE85BPoWawrjw+339k0qcX4bJ2HjvdH7ia4rPSlerhId6JpH6T4N3bl8XDll/PqYaAv2LvK4qZS+ncsfHEKQQWVkoqnj8rzGFdzM0NLITeIvpRpGOyh4/0cxjn+ogIVmE6BYWtWhDKaJMguPTCZsJAZKysiOCIES07M96L1Q1l1KCPFj7wFPW5AaY1+1nBHeI2Lnch0rEwC9gUm6fHwPrNFcLSlfo7komYVzaqNZIna3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da900B5zLurZnQao8HqgZefTd46/4dRa301VmyFipfk=;
 b=R9AIlFjRxbyTaHjVC87cC+9Hs/iC7doNIDQL5XIF8Cm9q+rduWlKM+C8EFMIwvatoMBZP1NxC69tqvkCwnYL/Ho6SdVmzhMvG0sAXJ9xN2gKXPPv91ZkLxLgT2sSG55U/5z3QI99/rHRYr5lHUhIB1Zqfr9t6VnpuUgGn/NTTuagKqaST3F0T5bUmPW5Rlvo0q/lLihjns+KoJwiO4NGbpM0wl214e5bL7yiCiwdluhnJHyUOZB20HaBF3CkVviZpgwoBClldnYoyAfwE8fb+Ehwtfoz+w9SstadyiVVvCnsSVxpI7C9eT5HGxiJTiUHZpCgxMXAjCyWDMJ8juEoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da900B5zLurZnQao8HqgZefTd46/4dRa301VmyFipfk=;
 b=n4pdd/aqaJYTrX5C29efdi/Gk3LVNvXmFKAM/TuE7yhQtgf+e1K3AzJCPuP5N6iLUJHonfi9y1CgkjcrCsNO5bLM5MM0ix0lh6pCjS+zzQmizhGqFzc215E6JzIJj6ViT4UGGUWRXlT3uAMFHp4PCys+GPRG/YKSW9JAMRTTPdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 10:21:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Fri, 31 May 2024
 10:21:05 +0000
Message-ID: <b6ad13a2-3975-4b6a-992c-44599e64186e@amd.com>
Date: Fri, 31 May 2024 12:20:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Add option to load environment from outside of
 boot media
To: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "santoshsagar.algapally@amd.com" <santoshsagar.algapally@amd.com>,
 "vassilisamir@gmail.com" <vassilisamir@gmail.com>,
 "ashok.reddy.soma@amd.com" <ashok.reddy.soma@amd.com>,
 "LPolak@arri.de" <LPolak@arri.de>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sr@denx.de" <sr@denx.de>
References: <976d57fe9080e9068421bec882ade85faaa3e30f.camel@cern.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <976d57fe9080e9068421bec882ade85faaa3e30f.camel@cern.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 57229559-9456-4974-41b8-08dc815b60fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXdHR251MXVGL1BmQ0FacWNCcmE2ZW5vVks1aDdiNGZJZFBhOTdPd1QzQXU4?=
 =?utf-8?B?VWNiUllmMG1xSjJLQU9DU2xZYnNrV0NtZkJIMHBwZWwvczBoYVR5RGg0NU9C?=
 =?utf-8?B?VHhQeVdhR3BvdW5GYTVUdG1nQ1UrU3YzVGpLdHZQN2poTzY5SkxJQk1aSHRh?=
 =?utf-8?B?M3JwWjJLL0h2Z0s5bGZkdzVBTXJqK0hwY0JZWE11NiszVHQ4S1F3cDB0QkNS?=
 =?utf-8?B?ZUF0ZTNFWXdXSkxPa215Y3ZEMEJYUEhMd0hudW1KY2hLRUpzc0oyWUxGb2Ra?=
 =?utf-8?B?d1FrM3NoRmROcEFDTmlPaEMyblJ6WmRUTEI4NFdPVU1MREd0TnJ6MmZOOGJZ?=
 =?utf-8?B?UVRsb1JxWXlLSGdxU1dFbmhtOXZXd0g0ZGRhVDBOK0pmU01YbXF6ZlZCaVdT?=
 =?utf-8?B?R1hWVmVNRHh4L0Z6M29SSVp1TDFvaXhJQ2psUlhYbmFkZDdXTmM3emJydUpI?=
 =?utf-8?B?MWk2L09Yb0xiUU0zUHlsQ1dHNnhhN21SQlAwaStOYW03cWpRc3hXOU5JM3M1?=
 =?utf-8?B?L3MxSVRXUWtLTG9sZ1hRbmdRa0JWMmY4TnpwM2FyeHR0czhHK3FqSkZqUlVP?=
 =?utf-8?B?NERhbm9NbGk2YmFEUGJ2dDNLQ0lUSE4rY2NFejlSOE1DV0RieDlNOG5xSFQr?=
 =?utf-8?B?Um9Ea2szTVl3aTViZTFYZFVIY1poWldHRUNuaTJjMEtWMzh4VGY3QUJnbWM1?=
 =?utf-8?B?MUNZYjYrM1d0VnE1OGg1OVErR2FTMUhSeWd3NVAvb0RxWGxRSlh6UUhDNEFy?=
 =?utf-8?B?R1Bxbk5teklrY045bVNHUVJTclA1UXJLL0xGT0t0NDUyajF2a2FLWUV2bjNw?=
 =?utf-8?B?dXpRN0FlZ0hYb2JuME0zaHZxTW42aWk5ek55QTRjWmVOeEdjMU02cDVIbWdT?=
 =?utf-8?B?Vmk1UlY1bGQvVnhGTnBjZ2MxN3VoRFh3S3Y3UVkxaTdGNmQwc04vT2RMc0M2?=
 =?utf-8?B?MERxWHQ2eFlQdDU0bzMxMTErQWhoZU9sZklaaEhpNmJ0OHRtQ3k3dE1Zd2Fh?=
 =?utf-8?B?dmlDM0d0MGZqaTJxdU1MaWZPUXJkOVdnKzFaNTFsVVJvdVh6L0sxK0QwNVp6?=
 =?utf-8?B?WEVJbUgrOXFWWm5DSjZ0SUp1ditoaWc2WTd2TmZWLzNMZTZkSUVVUzB1RlhR?=
 =?utf-8?B?c2t4MytkdkVhczJhU3I5aGNsMC9CWnI0TmZOdXcrNXZXOU9RcHRmOVFHV3Q5?=
 =?utf-8?B?VDNWVmo3bUNaL2F2VUNydy9WamVEQ09jeHYvS2prY2Z2VFFoNEJrUEIzQVNt?=
 =?utf-8?B?M1hHU1RLUmpJNlpJTmpuWDRBdjJ3djhBZGcwYS9XODZ3d3JXendxMmswaytS?=
 =?utf-8?B?TmhHakt2c3dveVVlZmZ0aGhBN3hncStaODgrOFlUTHhwczdPWVVWaFlTSVlB?=
 =?utf-8?B?KzZDSmNzb3d6cTY2aWhiY1hjclorcWdGQUc1aG8zL0FWMmFSMUl3alJTYWRs?=
 =?utf-8?B?WUpjSGFvVlpmMjJEampVK3NnVzkzMGR6NXpjcDQzQnViNm96M1FIV1ZyRGJt?=
 =?utf-8?B?d2JOQ3lWV01mR0dhWWN2eW9SWUxwREVWNUpmQkFMWGRsTFpCeXoxRFNqU20x?=
 =?utf-8?B?TGJscXQwWXJCdnVOSWRvdTliZjR2MTJsTjN0dnpXSFZwOUZENDRuMmx2TWRx?=
 =?utf-8?B?UVhFNGpwWW9aWkpRbDk2eXh2WFpyVzZLZjNJQVB0cyt0bHF1L1h1dXZ6aDIv?=
 =?utf-8?B?UFFXbDBCU25QYWVxOXpHR1VpUjh6RjVSdGw0RWtIUGZKSFFEQ2pxV2N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG41blc3cUNzK1dOSktsQlVHZndGVnRCN1Fic2Q4WmVncGdvQ3duVmk2QWNl?=
 =?utf-8?B?WElEa21UY1hWYU93bVpNYWJDQTBhZDNxd0MyS2RrQThKTXBERlRrRTJ5aHds?=
 =?utf-8?B?SzUrWUt4Uko4RE1iSlZpUU9BbHFQRzFOQlhEdWNiVGt2RHdkdm90d0pRVUdM?=
 =?utf-8?B?S3V3Lzcrd0FCQ2xtbHRiQzVLR3hDK2JtMXpZb3oxMUpOQzJLZ1dXMHRrRDFS?=
 =?utf-8?B?NkhuUzQ4UWlLWmIzb2FaakhURXpBNXFCT051bnIrdHZzY3IrREQ2aXY5RHYx?=
 =?utf-8?B?ZllxR0l5SzVJOEY4YTJzRXVtNndlK2VXSzd6bGdidmZ5VWVJb0RnN2dldTBp?=
 =?utf-8?B?ZjFQNVNvWDBIMCtFQkEycTlyVTdYSWM4Tml5eXRRMjhxVWVsZFhwMTY5RVdR?=
 =?utf-8?B?Z280d0c2N2xyZTYxUVQ2N3p0QWlCcmUwRDVGaXNYNFNZYkt1clNMWHZhVCtQ?=
 =?utf-8?B?ZXdUR2hoVXVqS2JvbmYxeVVFQ25KUXJwTWxibUtqdEJzRFp0VW10WHByMEd3?=
 =?utf-8?B?T0djMFZ4dmJqSVBvbmFGY0pNaE5RL0JCOHVpdHY2T2VEKzFxWE84NXZZMHRE?=
 =?utf-8?B?emFRUzBMTXN3SHVnZkE1YmllQWp2b1FJdlNFdk9GN2lnL0JUVTU3ODRGMzFW?=
 =?utf-8?B?SjlOQ3BuQkpaWnRFNm5nWGVVaHhEekF5YlRRR09XNVBUZExKK1ZXU2ZBVDdK?=
 =?utf-8?B?d2IvUjhwbUZRQ1ZyTVorUno2UXRMaFdlMG1TR0NhY1ZNdTNTQ3lRcWNhRE5y?=
 =?utf-8?B?dlBwRE9iMDI2cDFRNE4xWTVnOHYvN0dvNjJ4eWZKbEhwTGJuYTVQWkhxOTI2?=
 =?utf-8?B?QTlOZVQzZTZ2dm9EaURqcHJSaDBOWU0yVmtieGU0ZnM3MEFHdjQxWlppMkcx?=
 =?utf-8?B?MllFT2cvdGN3WTZITmZEelZmQ2lBZEFHR2dBQ2RsRHJYOVcxREk4RUZwSEdx?=
 =?utf-8?B?NTVZMTdieStWV3plUTFsRjVEb0xINjlqekQxME41bnBZTVVNVElxR200bFIw?=
 =?utf-8?B?dE05KzhndWRrUXpJUTZuUzFnOFgra0FDOEhMaWY0cFZWdTlNejdGQmZVQWxJ?=
 =?utf-8?B?Vzd1cEthSlJFa3M3UzVrU1I0UFJhZHZZOCtpMkhKbEttVHFZQnJHOVZTcEYv?=
 =?utf-8?B?b1FQU01DckxPZ29PSmRsT29MVlVCamVsQmhBSmUxQmRRbERwTHNDSlcrdE1K?=
 =?utf-8?B?SXk2QzZObldOZTR1dDlYazZXb3BxWXNTZGZRV0liUlkwYU9aVFppZjE2TkJm?=
 =?utf-8?B?ZXZjd3dKcWIrQUkwTnZBSndXYVk3ZU1DV244dWxldzJKNVNYM1ZFSm5veXo1?=
 =?utf-8?B?QjdvN3R6QmVKZ1pmcTVydkl0RXhSNXYrdXpFa3BrQmdzQXVIMEFYdlcvcXN4?=
 =?utf-8?B?UDRzS0UweElCdEVPU3UwWFR6ZkRpNnpScGNQUDRZSmtJNUVOdG5XWXJLdUN4?=
 =?utf-8?B?c0VKMDkxbGFabTlwOS9YR0VkQ1dNR21ONXI3MU1tTFFiZ08wcGIwRHh0NEdp?=
 =?utf-8?B?SDZTY0NqZXEyc0d4U0dDRE9kd2FRM1VNWEhNaGdVMzNVdGwyZjNHWTFUcEVt?=
 =?utf-8?B?aWxNOWhoL3gxblZRRGloWWI5K2d5WE4yZEpKYmJ4eW5FVXo5L1lHYTNzbXBt?=
 =?utf-8?B?amdrNlRxQjFYMHM0N3l1dHpNeTVndmlwOWluWjF5bDJpQ0xtOVdFRXViS0Zq?=
 =?utf-8?B?REJpeGRLdTM0VlhLaVpmYUxMS2xkUmdWY2JQRHJnQ2oxWTh1MFlXNWpSVTdl?=
 =?utf-8?B?ZlNwTUtFQ1RtNG5MWXZPdzBuYU9vZUJra252ZUZPdk1GWTdrRzNPZ0pXUFlP?=
 =?utf-8?B?TEExbjFHcmpaMldaYzZXaUJmbFU1N2YxRUxJUlRlVUx6ZHA1Szh4a0VKZUkv?=
 =?utf-8?B?ZHd4bzUzRWZ0Mk5FaHVaTjFXYmpuT1hyajJ3SEljSzdNNUUyTWtKa0ZPRDRx?=
 =?utf-8?B?dGE3WE5vR2U3eWJxL0k3alJ0T0pKd3NDSzR2QTVnVFk4dXlyRUdwM3NIMzRn?=
 =?utf-8?B?YnJiM2xpMFJWUUhZRE14VHJPeXl4ZUs5WFhsUXBRNGl6d3NlRHlLSWFIMTJZ?=
 =?utf-8?B?azdKbzJHOHRpWG5CTUx4aSsyZlVybFYrd2YrZDg2dDNRWjV1QlFmaHcwcm5w?=
 =?utf-8?Q?hRgR29/R4JtkQKBK1K4QZcyKf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57229559-9456-4974-41b8-08dc815b60fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:21:05.1381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw+xZkff6xxskwsZb76onLgm5t4UhWHH3ivtjXbVVhREJREHA9iGOI1iCx9E4bS5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
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



On 5/31/24 12:09, Vasileios Amoiridis wrote:
> Currently, if the environment is not in the current boot media, the
> env_get_location() is returning ENVL_UNKNOWN or ENVL_NOWHERE which
> is not true (i.e booting from FLASH with environment in eMMC). This
> commit adds an extra check to find the environment in the other
> supported boot media, keeping the same priority as of now.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

This is v2 right? Please label it like that with also change log.

M
