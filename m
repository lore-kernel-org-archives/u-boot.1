Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30167CF34AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 12:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548A083D3C;
	Wed, 19 Nov 2025 13:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KKN+7nLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84D383D3C; Wed, 19 Nov 2025 13:52:34 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4C083952
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 13:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcO+r1zsuJM9ClijQs65dz8+W6P3BMCz+lbZ2/QRzQhlbGeeSeTX6R4xdSqe2YTI7O+/ZD37jRlnSiQMzSA53e6h1RIZ2uoC80RvZ2mxC8pA0l6R/uzTFaLYF5FtnYTUBeEgfizkEYVmN9juP+3lWSeHA7UHR514jwSCDK91wslZzxUK5G/YwWZE5ZRbYMGoCXGxC3/haF4X13J5ZRnY9UDOdL5pbezirFZNKvb8a3vC2D1kg1gcBfLjzz+H8HyxkvMKeboo//pCh59oEOJO/oqUkOEhriUPBehIxri5IBtWhRsI7iE7qijxnwVSTg60myJeSTdv0XjXlLeZbCzXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSpt34sn+sKvhrH5fsHl3r8JBmtz1gZ8PXTyDycQBXY=;
 b=R8p16whZH2M4PX3fyMVGJ07UoX4GooptB9T5tEgvZWpWNP6g/yvttEvpy6fAqv6324dNnH42z80O6lOsy6rSgy9OtisJg1bMAxnF+iSHXWfD3JamNorUaUX+pAM5FiOg/5iYONevVhz+JUX26CDKoHKg2JESu/JXlCKzyIrMYvp1/tUOSfzjiIBN9QrZNRHyJuGebrXfBni/sKmEvW2mAzcVTytICc0TsLCFlo3Dk5qS+jcV8wD5jLhcJXqhYLrwHld5HE2+MM0vUjpr4RtuiCoT1ruEE+8twtGC2xOm2hBWWm/5vNTFY8wukimRQEkDUwGLOONJXZ4vU2PjxqYLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSpt34sn+sKvhrH5fsHl3r8JBmtz1gZ8PXTyDycQBXY=;
 b=KKN+7nLKkLtntpvjwIqYPIvBoHnaVo9s4JpZE0krAV4bxIs7tDoYyqWWyr+ujRZye3DemYmh4JZulTjZaUi9eshf49eiYUCNpsNtpuqwamNG4M7pkN9d5dUdXbzSt27KutZcNSMx5u98MPZ+NpVqZZAPCf1EF+XJAanwHL2wfMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:52:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:52:28 +0000
Message-ID: <faafa443-e804-4506-ac4a-658c2b8cc339@amd.com>
Date: Wed, 19 Nov 2025 13:52:19 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] AMD/Xilinx changes for 2026-01-rc3
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0180.eurprd09.prod.outlook.com
 (2603:10a6:800:120::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e170c79-57d8-434e-ce88-08de276a7ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bys0M3dBODhLMVVOQ0ZDOW5XZm1nVTM1OVA0RlFJd1U0UUFHdkpXeExCSzJ2?=
 =?utf-8?B?OVZDY293NzZUVEpVVHRYWXVUM3Z4Ym9Ec1pmZCtJdFRwWWtwYUVMUGxPSzk5?=
 =?utf-8?B?bEVNaWxtdm1Sb2Y4S24weEs3c1AvQVlSRlVhY0RwUGcxM2F5TEVLQStpQW9G?=
 =?utf-8?B?cnhudmtvSXlRbW81K2lPU0w5eHBELzhsYVNhQUgvUVJSL291VW5QYXEwNXZk?=
 =?utf-8?B?VjBERy9LNU5PL2ZtNDRzMHcrc2dOZjAyK1orcE5wdXJmMk50Rmh2VGtPWlV5?=
 =?utf-8?B?VEJ1SlFObExtZGRiRlNrcjFvSkFvaWtPSzdwaGxWMHRDUkQ4bGIxSGI5YkEr?=
 =?utf-8?B?dnF6VjdyQnozem9TMmhqMXlHdi9vOFFNYXNYYytHeW84Qy9KYmlDTnR2UDEy?=
 =?utf-8?B?d0hVYWc2WFRKVU52d3YvbmhKUjVqcC9pZ2ErYWprN3F1UDJoL0NUdDY1VExV?=
 =?utf-8?B?YnN3Q0F1dW9XMG5GaUVDNE1XYitES2Y5bytPdnNNaEhCbkJJYkJCS2hmbFdx?=
 =?utf-8?B?ZjRCK21wK2trUXJHOTVLOVJIWGJRZ1Z5dTB0WmsxaFdrc0pLVjF2SktGZzFX?=
 =?utf-8?B?eGdsYTlIWXcxZXg0S01aTlhkSkhvenFIbU41T092d1BtdkVVQUVaTnA0ZUZB?=
 =?utf-8?B?WFBuckpyQmtDNHJiZGlwSlFUNFUzMEdjSHRlY1NPbXkzZzcyMnM5aFpYL3F3?=
 =?utf-8?B?MTRvc1FucnBQVUl5NkdMTW9JY21vejB2UE82YmlPQzhDQXk5eHlQU1ZaeTdF?=
 =?utf-8?B?Y3pvT29Icm4xdXZ5elNkWnpVR0luOTY4VWVxYkc0OFRrc3VvRThpOUNFS2x3?=
 =?utf-8?B?RHdqZ08vNmtYVDJRVlRaUklneDIzVk9VZTVjR0lETGgweklZU1FXVkxnNC9Y?=
 =?utf-8?B?ZHJDaE9FL0x0ZTFnd1RraC9naHc3YUtlYytZdzFUVTdaSm9SalRPUDcwYXNF?=
 =?utf-8?B?UHFKaHkxTUwvK0hUUkdiSmc1S1dnbEVnWUlXdjQ1TXI3UG5oRTBEOXpIbTcz?=
 =?utf-8?B?R1FQa1V0TG9nWEJRdTNCUm9DcW96ZjFVdkllTWw0UjZDaTJNc1BNcHp5M1Er?=
 =?utf-8?B?anpxU0RlY2x1V3BnLzUyejMrdTJkWXBqaXVVRkRCTUY0UlZYTk9BcWNVL1Np?=
 =?utf-8?B?L1JlaUN2bnJNUHp5L09rYVVMbVMyUXA0M0pUVTk5Z1ZyNHNGRkNNOUZrdXpK?=
 =?utf-8?B?MWl4UDVKZWh3V0ZvZVhrVlFJSmJlMlBHcHB2eGZJU0tzdURna2tzbExFaS9M?=
 =?utf-8?B?dDNUeG9kUDh6WmJoUndGRjQvbUJkbTRHdjBkUkQyckliRkpmZkx3dDd2cElG?=
 =?utf-8?B?aFU2NnJJSFpDQnphTGhOd3AxdnkwL0hQZ3M4c2lKTmc2OGhBczJ2Y051OTlT?=
 =?utf-8?B?b1c3Sm02VzJiTG5EcVhDc0FsbGpnTXpOWGg0cmhYNjNLdUtrTTNTM2tKTDFt?=
 =?utf-8?B?azlxRS9aQUw5MExESEhPaEhjWXhYbHNrd3c5WXgzeEtra2ZPcFYva1VtSllY?=
 =?utf-8?B?Q0gxcDVHL0pTaDJyeVdkRWsrQWhFb2lUWXdIQ1U3dXFYMUdXMmJONFFZYUpw?=
 =?utf-8?B?alo0REUrZTZxQUtaelFsMnBSOVRNL1h5ZTVRMWJCOXNDS1RnOXhCZGg0K3k3?=
 =?utf-8?B?Njh4Q0cwbXV6SWJKVldVVjlQQk1ScFNrUFl5REt3M2MzRVhsdDAvUVZVNzQ4?=
 =?utf-8?B?c1dDOURFVGtWa0tlaHkvV3Zyems3U0tROE4zZjYvUFlMd21Sdlo5dFVxSmhh?=
 =?utf-8?B?Y3ZITGMwTTRvbXIwN2VjcDNKM2ZXWHpHaGl2dk0zTnhNN1RhcXVwVWdwSWRC?=
 =?utf-8?B?ZUFkQ3VTelRuSlVrU3cvb0RtT08wVmRVRDNGS1Q4SkY4dkh3amZiQnRnWFFQ?=
 =?utf-8?B?bW5jeEp5aWhmb3k1NHZMWUsyZFRNTlM2Ny9lUnppdVZoeU5nVkFVZGpHMUVG?=
 =?utf-8?Q?t/TFo/Xlq8yRTLi98MGsIW5+uroOpnoA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JBS1dZODJaUDEvVjArcFYxUEd5TEFEZGJ0ZUd5M09pY1VlNG51U2x6S3p1?=
 =?utf-8?B?eU9WQU50L1ZUNmgvY004K1VlSHRHK001WktWekRqREd0VjR0eXpPaVdzUlJO?=
 =?utf-8?B?R0QyQVZqczhueHpBYkI3K2J5TU0vR2doREsvbEs0dE1LMWZFSlQ4SEVaTDM1?=
 =?utf-8?B?QjBzQWhhSFY5Rm8vQmxoYWVvYTFoV1lueko2VG9JNjZCL01ORzNvc1VYdUhO?=
 =?utf-8?B?TmlEUXFpbTlOTzhjd2Z1Ni95WEVuRGZTZmtZN0lWME5neEVRcGpLM2FLbi84?=
 =?utf-8?B?K24vbnkreUQ0SERLN0pyVHcwdDRRc1pteTNDRWIvNXlMT2VuQVBIT3B5SW5X?=
 =?utf-8?B?aXlnbG96M0RSZDJRQ3RLZmdnUUVyQitNaUw4NzIxVHVnaFg2UHhWaVVKY01i?=
 =?utf-8?B?NXRpWnRNYnhkZHlIak02bkVhTWRtNnJWRmxxWkw5RjVDQjdHamhPSWh5Rmtm?=
 =?utf-8?B?cWU1RVhZYThBM0RaWmxPUTlJY0tzc0VyYmlIK2pUZG5JdTVlMFRROVVnRFVp?=
 =?utf-8?B?WjhrcEh1VE1sdHNiTXBJM3lrT215Nm5rSkszcGNUWTBmMHlVd0VPNXd5eGJq?=
 =?utf-8?B?L21wZk9ZdENLbUM2NE8vNHBEOEJScFU5OXc1Z1hoUnJDa0ozMS9PUzh5SVpX?=
 =?utf-8?B?cThhWGh4MzByRy9zZlVyN0pEa0RnRE9uTlZ0eWxpeWFZV2RDSG0wOTZNRGUz?=
 =?utf-8?B?enJPaVFPMUIva3JHR3lrNzJTUDgwODZuYUUydUI1K0ZnVXoxWDE2bmMrS1pY?=
 =?utf-8?B?blBmYVg3WUF4L1U5YWZzZFM3TktueDRuVSt5WE51QXhNWUtrY1pFckt5MFZm?=
 =?utf-8?B?aFZVQkhsVzdmRSt2WmpaMnpqU3dQZ0R3OFpxRENhUC9YcW9zb0RsaE4zQUE0?=
 =?utf-8?B?Z3dVY1lzRllQZ3M2eVI0U2hPUzltR3g5TWt4eFZaTk9XWEh5dUY5a0p3L3FG?=
 =?utf-8?B?NGpjZmJsSTFRcFJ6VnNxZEUyTHZUTWsyRVFJMUFxYVMrQ0UwSTZvdWRJblBi?=
 =?utf-8?B?ZVBLU0U2ZXEvZVhXYTZMSk15eVhtOXN5NWJ3a1VzeUVqYkszaHJMOG1DM2Fn?=
 =?utf-8?B?OHBIS0lucTdLY0RUWDhFTXAwY0RocHd1WlhiS1o4Y0t3bFZsaks3cmJVcHdG?=
 =?utf-8?B?bDBxV2NUUTZXNERPUy9QRWZuQzNzYUFSQmdTY0srNCtaZFZBZjYvVFlIY1dO?=
 =?utf-8?B?aXkvSTFldklNMitIMEU5UTNZTm5YbDQ1UDlTUUhEZmVKSEJLTm5COGlGa3dx?=
 =?utf-8?B?STVFUlVweGxIMVU3NkgvUlBHOHRReVFWTUhBNDN6V1ZhZnZ0VFkwcUd3RUlV?=
 =?utf-8?B?eEhIMWhQRzV0endFa2swT1RpakRXeGRYR2x4UW5UMUtFSmhwYmFWNVBEMDVk?=
 =?utf-8?B?TGZRYUlQN2h3V2dTcXU4WHBoRzR4d1pFaUtyK0NZMlVvRCtOYXVmR0ZyaG45?=
 =?utf-8?B?Y0FpRmlSZXg5UXhxaWpCQm9xOGNpWWRZOE5WVEYxQ2w1ZkNZSmVQNFNnL0Ns?=
 =?utf-8?B?eTR2TEovZXdSWUovSWdYM0hwa1BFcUhnblNEOTROeC9JNzh3aTRDUnErWFZB?=
 =?utf-8?B?SlU1OTBoWFBIUUlDa0orN21Wd09RQ2VwQmZvdkErSzc5b0R0MmV1ZUtFaU9K?=
 =?utf-8?B?TjQ4cGRSYWdQU2NFMWxSekQyaWNQeVVUbmp4WXZBc0p0SVZaN1hDVkUxQTY3?=
 =?utf-8?B?SE40aVJPcnJuS3RKUFVVUnAzU01hK2NkK3BPNkc0Mk5JVEx5ZjNaMFhmU3A4?=
 =?utf-8?B?aE9oTzhRci9pSGNpQWRpNUw1aEp0OWhEWGJUdW5heXRoSjBHODBNc1JFMnFL?=
 =?utf-8?B?YUFZcTJuNE9mRVRNUWFkOGYzNjB0c2xlaTFIWWFVY3doZHIvajV6SnJFYUI3?=
 =?utf-8?B?ak9sQm5tbVhvdFdpcHlqeGFESWhLQjdJWWE1L0ZyTVppamFjclQ3bFhQUGFv?=
 =?utf-8?B?QjE0TGQ3NmZWNEpOS2tBZlUzcExsei9qVFNxQm9LZFMzUTNxd0RHZkQ4RGw0?=
 =?utf-8?B?YjdLMWlaUndDNnNiUUZOZHBMWUhScUVFU3h1aVA2MDRUa1d1cGRZanZrNFAy?=
 =?utf-8?B?dmtQeUZMTUpoYnd2cEZyL2dBYUY2V3Q4YTVtbTc0amlIc2dKNDQyeTl0WDNa?=
 =?utf-8?Q?mcW6zp+j2JCvPKvZj/BjOmc4M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e170c79-57d8-434e-ce88-08de276a7ee5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:52:28.4761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PByjhGaFsEHZs4SHv46R+U5BbeGV0l6nAL/eE6VaXulc/xHBiQAL/rBGI9MDwUW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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

Hi Tom,

please pull these two fixes to your tree. In CI docs part is failing but it has 
nothing to do with below patches.
https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/28413

Thanks,
Michal


The following changes since commit c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b:

   mailmap: Add entry for Sam Protsenko (2025-11-18 15:55:01 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.01-rc3

for you to fetch changes up to 2e86581d055bff8335d7e43d58617db16f11384f:

   net: axi_emac: Fix compilation warnings (2025-11-19 09:28:50 +0100)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.01-rc3

- Align brcp1 boot.bin location
- Fix MB-V compilation warning when AXI enet is enabled

----------------------------------------------------------------
Sai Varun Venkatapuram (1):
       net: axi_emac: Fix compilation warnings

Wolfgang Wallner (1):
       arm: dts: brcp1: Move SPL partition to offset 0x8000 in SPI flash

  arch/arm/dts/zynq-binman-brcp1.dtsi |  2 +-
  drivers/net/xilinx_axi_emac.c       | 16 ++++++++--------
  2 files changed, 9 insertions(+), 9 deletions(-)
