Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42FFC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE31188395;
	Thu,  6 Jun 2024 16:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jr7HrDrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614D1883CF; Thu,  6 Jun 2024 16:00:16 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C8F881CE
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzi8CGfTpom/aNVPJWth7UXx8uGz56vGD5ux8xpVk2cOcDNzOcE7nM/uJzxF6qoF9eCkBSuXvKdCTgi3akwt6PkW7YulIqqYGHiQ2X+oPxSrTELprefLm0knmFykCUrMVIvbPjq9XYerjTIZ9G9aMSqWMUGVo0HqQIax7wv6TOczDUhrIw53HfJ3VO1cVPwC9CpMu/cOtu6Prwi05Ldi8B3JRTjkUy1N2Juu529/zpMrJiwC4PLME9Vqi7uDq0/O++b9YoVp0Qavs0t9/bwlOVinvWwiwJd4pI6OO4hFIk2OPD2y/ghjQ1ymLljLPIDRxa6SrRHW8iYbyvsvCjmkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+IcrXoz7xtTpcNw/IFauSMKz2zHUsh2CJtbE57IRJw=;
 b=jIFyCLkXC9XKnNnCU0Qzk0qfR9gbZ7vFhwSr1drASvbSTKHOboDr4+0Z4h4Fqpzua2OviKVROo6eXETfQThgcujisoYcxYoneylORy9cUS/oo5R4dlTUOpYtM509KS48IAZiDn97Gj78qRoUWBa9jdD4kRxplhzTkRV29DF3mWwRoq48S7ydR4oZEjN8U/O1XtLbY7GyZPPurfjWBGtwrmr55cL6CAPh2ZtrUQuWT+MAQfFNrolYAuE4fUa8QJoKNuh42nuARqoL0BZEhwhesmUexd9rUcXMdh7G034dwOboIGLIyBj4XYnNp6ZHV2fjwryBE/Vn/31bIq/gxkbmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+IcrXoz7xtTpcNw/IFauSMKz2zHUsh2CJtbE57IRJw=;
 b=jr7HrDrs5ytNWO7DutTobEDmXmXJcIbwOqk6WN85aHCfbCfdREMbEcKFGjdYbmWSvO+TZoAjaOHTLiJvSSVxEvy9KdRAUCy0Vt/CsHbbaqlHhvMfOvn/OrfGIfVGFz9zpdsc+rmD8lPQ6d8egw+zaN7DhOrU7e7bj9Q3bL7HXI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 6 Jun
 2024 14:00:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:00:10 +0000
Message-ID: <6166fb9c-a815-4a58-80e1-1d3ff34546f2@amd.com>
Date: Thu, 6 Jun 2024 16:00:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] configs: zynqmp_virt: Enable CMD_FUSE and
 ZYNQMP_EFUSE
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
 <20240604142741.425307-3-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604142741.425307-3-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0086.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: c97cdf1a-0df2-4fb9-b0f3-08dc8630fadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmJvbmlLTXM5VXkvcDFaWFpMam1TWUVVdStHNUREUmtrdENmNkJmSXJuZmsw?=
 =?utf-8?B?R2lZTnU3Q0g0QnRpVGEyNC9FREh5SWkzcmx2QzlBQzJOYXhrSVlFYWtOT2Jq?=
 =?utf-8?B?aTg2YVd1ei83NUNnakxNOFBJVnVsUUdOMTdoeFVXZTF3UVBIQzJQT0grUXBq?=
 =?utf-8?B?KzV6QVkzWkxEUFlDSmljUVI3M3RZQ3dGTXRBYnRVYTJGODdsaEdTMGQvL2NW?=
 =?utf-8?B?Z3M1NzFCcEJVNkY2cXhqMk1oZUtnc0VsNVNSTWdjUDZGUThhU2lrUUpCOEJJ?=
 =?utf-8?B?Rmh2V05LWFJ0WW9yQmZKdmUxdGFyLyt6eTlsd2ZFYnRESitjQXFoeE1pWXky?=
 =?utf-8?B?YUJ0QkF4YkJnY1BScGVYR0pzV1NSeFplYVE5N3JyTEJjTnpHV3ZkNmx2cVlZ?=
 =?utf-8?B?QUthR3NOck9PS01EVTZMSWFQck95S1pZSkl4cXdVeUMxWFpUTmZWQ3ZaYTBZ?=
 =?utf-8?B?aXVmVkF3Y1J0WUdoaDRUdThEV3FGdzFnRnJ6eHdLQnl6NlBLNnh6NEdUSDRu?=
 =?utf-8?B?OWo5Y0Rjdk83Yk8zN3pKWWFyK0hsSlpOTkVpZ1JwSEFDcmxrZTB1NnE4ZkQr?=
 =?utf-8?B?Qlk1Rnp3YVlDQXFrV1k2VkpTN1laSXBDS29tczBGYlJpQVhkMjVOSElpNVJ0?=
 =?utf-8?B?SnUvRElRMTk4UzZlelRGcVlkRXVoVEtzSmJuMmZMZVp6cmJSZHhNQmJ4VFp4?=
 =?utf-8?B?c3pOYUQxNDN0a3hyUnJKdGx6Q2gzYzcrL3pGOFJSOFNnN0hCbmtiSVUzaytX?=
 =?utf-8?B?OHhQWEVSSXppYmwrcE9PVWg2UjBNR3lab1RJTVg4YzVNWnFMR3B6aVU5Nkhs?=
 =?utf-8?B?WnZiSnFjY0NjV0cyMFF1UnErdUhGbzkxZ00zNGVtMTYwMHQ5L25HSHFXY0xR?=
 =?utf-8?B?NWRWRlJRT2tFY3hxV3M1WXhXUlBuOE5wTTVIcitaQ3RwUms2TWdtZ1R2TDRJ?=
 =?utf-8?B?bTliSjk1cmJlZzREYlk3SFVoei9YUjJWbnBoUzdMMDc4aEFsT2xsSFhNTW9q?=
 =?utf-8?B?eVEzZk5EUEVhRmJCL2dXSmVIc1gxV0tQcUxyRTBJQ1oza1g1NXpMdXk1YlJQ?=
 =?utf-8?B?VW1Hb05KVW5iN1diY05wVDl4UjJjK1lUUHRsR0ZKL25mM2h5ZlZVVW9tQnIx?=
 =?utf-8?B?WU5HWWdIeTlpVVNpMHFEUVVZc1FtRHdxTElrSHRiTjVtRmtjZVQwSGw3c1Rj?=
 =?utf-8?B?SmY3dmdmOUdndDQ3THF2VE5DVUF5ZjRNMG5jV2dOeHNaS2RxbUFWRkgwNjVO?=
 =?utf-8?B?b3dwK0Z0VndzcXZiMzVZRWQ4WmZPbTBjdGJkR0FhRnd6dWFSY0FZOXFhWE5O?=
 =?utf-8?B?MGpCRlFrZnpCUEZDY2ZDTTFUN3M4TE5RSVdmb293SWZ5T2Y1NkNoc2d6MENN?=
 =?utf-8?B?bXVnMGNxemo2NGs2RCtxQUZJazJIKzMrc3d6TEJaYm8rYlVEK3ZEVVpCdWM2?=
 =?utf-8?B?M08wOW44cHl1V2hESXR4L28zQk8zRkJWbm8rcVJHd1JjbHBwRlNERFlsWkps?=
 =?utf-8?B?R3owUTgyUUhPY3hDMENCTnh4N29VZGExbWdYUGY2VXZSWktiY1Rsd3pWazV6?=
 =?utf-8?B?a3pPWnduTFdKQTg3WnY0dWNSTU9kc3hlRDNnQ3F6aUhheEhIU2d6dE54UGIz?=
 =?utf-8?B?dXBnNFF6K1NuMXBibVNVQTZiUHpia25BaytUbG9Oam02OVV5ZGxVaG1BVnB3?=
 =?utf-8?B?bVFIcVBiSVJkalZHRzZSeGlEQ0J1UDNVYjYxNVI5ZTUyalZyekpLN1BiOVBP?=
 =?utf-8?Q?AJB7gjtN1Z36yrI1f0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mlc2VlF0TUM3SmxZR3JQTW9pZ0d5c0FHTkUyU0dpdWtHMDY5dDR2S0JCMnBi?=
 =?utf-8?B?RWQ0YmJseHBqdkZTYThxelFtWUxTTCs0Y0xBTHBPSncxU0o0ZVJoTkZNdEFS?=
 =?utf-8?B?dnlMWkVwUnlKYkJzZkRCRTVUbGhBZE1yZFE1VGl3TFU2eFB3aW9xeVh6dnVJ?=
 =?utf-8?B?NmszT28vL3FjVmkybkhJdytER29ZRk1FS1dZQ1JzbmVYVVBrSHdJTGRTTG5H?=
 =?utf-8?B?a01xZmNIL0VPS0cxd1hvdjlBTCtaTFJ2RDlHckI3NW9TNFIyckc1Yjd6SGVz?=
 =?utf-8?B?V2hZUUtkKzJRMmVnRTlSaGt6QU1uTWJLalFHYmxndEp1b1J5M1VJNWhRaTdh?=
 =?utf-8?B?eDV2VWcyTDJhR2JlSStKQUVnMnFpdWNwMGdQc2cxQjFhOGtCTDh2L1d3SS9a?=
 =?utf-8?B?VzRoODhib1pqeVBHNUJaa2trTVlESldYS3pkK2paWVRvZmlSSm1DKzZST01a?=
 =?utf-8?B?R1U4QlVzaTFDbGJ2VFZFeGZTdTJQZ3VxMUVzNUQrZ0ZRSjBSRTQxYlh6YWg2?=
 =?utf-8?B?R1JDUmxSbCtTTDZ3dWk3V2EzOHhYdzNnRHczM3NnSzkxSjg0RlNocDZaRTBS?=
 =?utf-8?B?ZTZQQWNraHh4b0IramU4V0k0azI2dHZSb3VmMHpnQWVrQ2U2VVNBcHdOR3dZ?=
 =?utf-8?B?ZThXVXZGekFrQ2lxaFFFZ1hmclBXc2NCaWRoQVFLQ0gyMk4vNDFOSklPT3Zx?=
 =?utf-8?B?WlY1ZmRRODNDaUYrTFl6Mmt5Zk5iYTJVM1pqdVdrVVdOb3g4bDdkQlNBaXdM?=
 =?utf-8?B?YmlWRFUvQmxuWWZwVzVva3BHN1NHR3ZGK1NXMHFCWDk3SFBCNUZwNWtGYVp3?=
 =?utf-8?B?dnhGQ3YyTGNxTzNHVGY3alZ3R0xRT3h2UThTVHJXRDJnMU9USkU5UlJoRmE2?=
 =?utf-8?B?NmgxNUtlWi9hZVlzdUVOdExIV1M0T0tUelpEbTVnM09kejlrN3IyQzZLWnIz?=
 =?utf-8?B?ZVAxemJTd3QyZTUycDFqZ3U1Ym5wbmR2bnFUQjhVMzY3bHk0NFB3WXZoTlAx?=
 =?utf-8?B?SHZnM1dGaGhqd3Z2dWFYVEV1MWhoZkJQVXErVkhIU0ZRMHZzanpBN1RzRmll?=
 =?utf-8?B?R2pVVWNhcnVCOW9PWHdFa3ZVbEVsK1FEMlFtR2FnbVc4b25QT1YyNDFkYzBU?=
 =?utf-8?B?cXdJaVVkWmNnMzJwYzQ2WUdDM3NQNnF1Q2huODdWSmhUQ3AxWUFYRmwxYnJ2?=
 =?utf-8?B?T0F3MWc2OXp5bGo2bmZ4eVRwYXJ3cTRaNWNKMEwwZlhMTXlUaDhSZ29DVFVP?=
 =?utf-8?B?Wk5MTFdSN0pIMFQ4c0crSThlWWd6SFBNc0pCNUcrNkY1dmxVejg3N2V1TW11?=
 =?utf-8?B?VTFIYXd1NU9taStzbzgvbkYvbGljN0xoV1JnQkVveE84QU1xbEZ2bDBjeUZO?=
 =?utf-8?B?Qytmd2ZEK2ZSTkFabXVTVUZzSDBSTnkvdU1CR3kxaFQzZkhXTmhoQ2YxSGc5?=
 =?utf-8?B?R1FrNjFuOWVSTHQzT1FsWE9vd1haSW9TdjNkN0JWYU9hcTBjN0N6SzBOWXlo?=
 =?utf-8?B?T3N0dmFNQ0hrN0Vkdnp5RC9RUFNBa0JoZDI0anlLRzgzRE5sbEwwclNFR2xz?=
 =?utf-8?B?UTBVZTdwRUNaN0ZNUE0yRUNXT3BRNjEvb1hraG5iQmk2OGJnMzFGTk01S0Fo?=
 =?utf-8?B?am16TVRranRYSVJjUWV3S1orMVYyL2lDYzBmOU1FdEpZZUVDalkyQ3JTMlB3?=
 =?utf-8?B?WTZ5MmVTRlZ4R0pYaXZya0hMN096SVRKR0pCdGJ3ay96ZituNm1zbFdVdzhx?=
 =?utf-8?B?eG1Md2F3dDB3TmJiOTZ4VVR1SDIvVmw0Y05ZYWU2VGQxTldIY1Awd3BuYWtO?=
 =?utf-8?B?VzhTMTVDT2E0azZ5SUVhUjladXp4YmgvdVdWK1BvNUUxSlZRWUp6N0hMU1p4?=
 =?utf-8?B?VU0xVVlJWTdEYldmTHY0VVRXbVM3RUxjZXhVSndQWUEra0FCTlNaanlRWmxC?=
 =?utf-8?B?VFhBeWsyd2llSlVaZUIwbTFBbnMxbFA1Q0I4RDlhVVZDalFjcGRXY3M5MUxt?=
 =?utf-8?B?czBJWHY1eXYyYzExTk9qd3J1WHlJRS8wRGozQVA4SU5nWkN5ZXYvK05ra2h6?=
 =?utf-8?B?WmJVQjBOcU5uQ0p6WmFIRXJHVExMcEppZU1CRVlmZUF3cGtiM1czR2FWTE1T?=
 =?utf-8?Q?ttBxoB0hSSpOYcZtXArHG+MfO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97cdf1a-0df2-4fb9-b0f3-08dc8630fadf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:00:10.7719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xGUiqFjQZz+PSW3+259PPuF6rgyQBHtyV3w9/ZtSeQw0rDOl2LmsDCPBkH4kcQp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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



On 6/4/24 16:27, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Enable CMD_FUSE and ZYNQMP_EFUSE in order to be able to write
> ZyqnMP eFuses from within the bootloader.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>   configs/xilinx_zynqmp_kria_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index ba42f0c7848..ac91dccbe64 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -65,6 +65,7 @@ CONFIG_CMD_DFU=y
>   CONFIG_CMD_FPGA_LOADBP=y
>   CONFIG_CMD_FPGA_LOADP=y
>   CONFIG_CMD_FPGA_LOAD_SECURE=y
> +CONFIG_CMD_FUSE=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_PWM=y
>   CONFIG_CMD_GPT=y
> @@ -147,6 +148,7 @@ CONFIG_I2C_MUX_PCA954x=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
> +CONFIG_ZYNQMP_EFUSE=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_IO_VOLTAGE=y

Feel free to merge it with Kria. No need for two patches.

M
