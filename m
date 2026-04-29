Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C73FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F033846D2;
	Wed, 29 Apr 2026 08:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1WFB1Ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1D8846D8; Wed, 29 Apr 2026 08:31:17 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE5D846C1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFT0nxhenTowfqRCMhBq7YfI7ShQLw1q3TjukEh3zOAfVQxW46RGsXVriRdOZAag6tBEajsbHxRJgOD3VWQ0b+jgSJ+Aa/AHWijoMuEZrzgS+jCHfhI4tyHl5yG6PUoi1ExDfXT308uxss24txQJvep3YqVKZ1+C5CZx3wNiYGWhKRJATLTdMk0N2/1p42HL+StzS1Uc06I2Gbqow+NaYbAlI2qN/tdADoCoKPRZKk3pLrFysbf4li5jl6ynn4ls0o5nydkiOc6nS6uw1/w1dHbA1nncajkYSIhATJdUcNcektQkhOld7g14r8CHkTB1Xu9ILb7USHJzYybQkHZNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjv/qIG3J88VFq9TJ+G4jDEsuxFRLLWzW3X1NTlOQIQ=;
 b=J1aUMFcWPMBSt5t2kjF4ymAVrmgfxHcvVcDclDum3iIOOtLKlGv3qVi/MOZ+P9sx4OV6ILJ9C0g/qQq1DsfglN9i2705EAMqsS/tBH/CbyOJwJObg9+0Yb8rivifYjWhC0IIBhUzy7Ox9OEYktO73yGcs+SgMbeIU3XISI/Rd6OWfs5x60pxC6jlwwpRpJQrXw7UTvZO23OLxq3BAMUfJ9OPgEabOnnUiTTLDxlFeQkpDrtPUaC1LNC/JW7DiBN4Oyrjxwmnrd3JGhGkq/yr3ACGK7ET1hKvsmn+AJvzMAVMu5sMhxFWCQEQdox4qvItE9V5jTwxO9aPfVgdFP+jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjv/qIG3J88VFq9TJ+G4jDEsuxFRLLWzW3X1NTlOQIQ=;
 b=q1WFB1Ay3AYkDjFRgCtd3m/ESubXOH1I9RtcNoCULFbFoV01yGOvm3FERMoABOb8Z24K7YjZls7gGmSRWm8IDDT6xuGbwK+7ANhg0o38cgyRD3PNxeL80fMOln6+RVsdQ12nr5hvuWzyA8O1RM18zvq1kuGdLmnfNVxGnIlwuDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 06:31:12 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 06:31:12 +0000
Message-ID: <92fd2c06-8b50-487b-8f42-2e620dd607ed@amd.com>
Date: Wed, 29 Apr 2026 08:31:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260428140433.GQ41863@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260428140433.GQ41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: b8030a48-cab8-432c-1256-08dea5b8e843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: I0o507I/4xOcDIMYzzvJaRk3YSczDcX61OCFevow3lLDJq2etEhHO8Eg+1bZk9Abt/4oCWBvWJ8f1bV4haqwH80pvx055U3ig8S2LTK1ssskbJzfEbECM0nLktI1eGEOFKVoWvYvDQ/Tf3D1PcYCCjwqYoEPe4h11eoFfVbd0AKeiFOam7oDovcMnq3fWRzWAVI7ZeC6BGudyYzxHISaOLGcgQv9BIKhm9D9He1352aIvkv0EC/WgUMPSi1R63dkimbhdzC7CVZQjt36vQhJxAsF7iwSf/ZmTU7yzWxIXSNWYrQ2sZMHeUfEJ372ZW88H5qASKE36TDI0m4EGkL2Retgs6wjKoausWfYe6JbI+ZxbFnW4oC8MTwKe0Sm9AlNxbUqEpF6+bPo8cIjFt7wQ4xoT0P1IQILT7k0UNDIcaZQHkXoQeJzpcIg8JRAXUxW1t9tWzGyAz5wyWXO2V9djx1r6V2uFwvzCj8rDeVtecxvCXu66f9xCQS6e4dPV4XQl3Dpuxynu9z59uGUR/ftbt6vh7yb55/AwJenp2Pm6ZTEvQpBwbzqGhCXVSU2xrifp/P2L6JQWGRj0M/I9NvropUC8B6fH0+t1qfXW6O9UbF7ZdOVC2s2couX67QYbqVlq3pEiqQkcFl6L67uE00dGW/gsCWg85VJwdXKtO9KCMNi3JZaBvCo0SRh4B/kxiQ186Bu239Otyu919LJ85w5tj53t9XFVWoPCwnn/bj7iyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzV6clpMSStHb2VOV1hySVIxMXR0UUhIQmZ4RGdGS1hXNDIwbldKZ2FRaVlX?=
 =?utf-8?B?NFRJYXMzV3FJRnhLbnV0RlZ3UjF3TEJqdWNnR201NzhHQkFIYTBWM2FDRTli?=
 =?utf-8?B?MXdBdDQzSmk5YUxpUGFnUFVFNnc3NmQvMFZIZDlzVXJ4U3dqN3g3RHVUZmdP?=
 =?utf-8?B?SkVBMUJmZFVDN3AyWENOYURRUXRpU1J3YjR1Q2dScFZrOHhwTVJJTFk3blgv?=
 =?utf-8?B?VjJ3bVpKRldTUEF3NENEaXlXQ1FzdkpJTUpMYzJ3bGtpNDBjVlBkN3BiNTRW?=
 =?utf-8?B?dDh4RHRWM2VBRlNtNTk2a042Z0xsTWF6L3VlbEMrZmhQZ1UrQjVCNXJSeldR?=
 =?utf-8?B?Q296YStIc3dpUkg2RTB1SENBRTNaQkNoKzNpcmgwQmc4ZHlrU3RCdWhTcnBm?=
 =?utf-8?B?WnpBakxrdzI2THVwd0NqRlloTmZOR1FlajhralRTWjBtcHFwamh4NUFHUGw5?=
 =?utf-8?B?M3JZQkUrUWtua1dWTitzam9rMlI5aldvNE4wbis5SDUrdDBOZkhDU2RBWllk?=
 =?utf-8?B?K3B4TkFOUDBQSlpINTEyWUI1YmhzZ0pZd091bW5rbFBObnp5OWNUNjJScGdJ?=
 =?utf-8?B?ajlKME5kbUQ0aER3VjVyeHlnV3o4YW9aSzlya0dTZ2h1Q2hnVklxcFhDdHFO?=
 =?utf-8?B?SzZOYzJqUHAxdnJscTdqcXdVN2xKUlZBWWZmcmE0V3dMQldkMVEraE92V0x1?=
 =?utf-8?B?TEJWUTVvVklaL2plR2Rqd05LK09EY3VSdGpDWFpBcWR3SUUyWGtHM1lQQ1F0?=
 =?utf-8?B?OGRVT3lsWjg2Zk5qWm9sb0U5L3dwRkI4U3dzZWpMa2VTOTMvWnRjMGpZSDVh?=
 =?utf-8?B?SHNJdTE2VU93ZWUvRTMrMWNvdWZDUGhrZ0pONWNBMXhrMkxEcFpkcGhGTHdI?=
 =?utf-8?B?cDBHOG1CWm9BTUxtRHRQT3BWR0NLQUlhQWRJT0NhdjFrazVNK3N5QmJDSkhW?=
 =?utf-8?B?bk1yZWVJeGJvNFNnaXg0TEljSWR3d1VGM2ErVU1BVVp2dmxzY2s1RW1YY0o0?=
 =?utf-8?B?Ukh6UTNUNk85aWpWcVZxZWpERTdleU9KbTgyWlA2ZndFNEEwUkhneXBLTFR1?=
 =?utf-8?B?bkswSjlzbktDVDNRcUtURm5LR00xdFZJY2ZWbEt3NGFhQ24rTUVublJOdTAr?=
 =?utf-8?B?a0VUdVphY3JwZlJTQWZXSFdEejhaRWtJYUlpM21zU2pFODNFNDhMTnJ1dVlM?=
 =?utf-8?B?RUpXY3hDUzJtdFVnUW5JMlRIdlpOUTEyV3kyYmRCNEZ0RDdudjI0cVNFV1Na?=
 =?utf-8?B?YzhjenZsR0NCSllhSS9qWXY2VHBENzNkaHN0L3gzYi9waEowNnU3blo2eXVj?=
 =?utf-8?B?TkVOc0ZWMFhmOTZKZHFPSGhHaU9ickYwai9RbXRlSTlyRjBrb3RJelp0NVpj?=
 =?utf-8?B?QkQxVzc0czZDcjcxQmNXTDFZR1d2RDMzMjMxQytGOUZmeklaMmQrOEpzZG1z?=
 =?utf-8?B?dDRMZWIxYmJMZzZ3c0dmNC9GUXFaME1BbTg3dWlQNy96c2s0SzhuVm1YaURv?=
 =?utf-8?B?NlhyWUNWOVhyR0thTUV4OEpVWXB6bmN6akVQUGNtZWMrNnF5aVlmQ0lnM3hi?=
 =?utf-8?B?am9mM3MrOGU4ckpHZkl2YjNvUUZiQTFlZUZOY1VPRXNZN0tZYWp0TldkVm1O?=
 =?utf-8?B?RmU1b1VzZ1dxdzhqc3A2UGtHNEJ4dEVvTEZuRElBWjNBYTd5WVNJZEJiaFRM?=
 =?utf-8?B?RHFnSlZxdXlyQnQ0M2tZYUVNTXZ4NkRsLzV3dGJOenNUNW1EOTdKUWdZNEhG?=
 =?utf-8?B?eGRsYWhDV243Q3cvQTZzdHFLaGxrRUJaSGxUeXVsS3RyOUtNRGdpUzVZVkNs?=
 =?utf-8?B?V1RCWjA5NWNqQ3p6aEZHd1VzOHRDK2RMaFJPQUl3OFRKa0ErdlJnRkR5M2pM?=
 =?utf-8?B?cUVpQnFLZWhFRy93amRVTkZMaHVnV2dxYzV5VG5JOXdRYVFHMDArbXNtN0tX?=
 =?utf-8?B?eTVTR09sV0QyaTFuV2plSjhlQ3JOU2tvUDVUYWk3TVpacDdvaHJyNFZ3SjJY?=
 =?utf-8?B?eTk0Rlk0Q0VwN0NxRHZKMDBSQjYzSGtXMG40dUZxS3pWcHRKSW1yVTEzaWI4?=
 =?utf-8?B?UFdVU0EybnVZSXhUT3kvY2I4OXRlUmxqdWk4bzNCUXlVUDJhUXpvaGJFWGg4?=
 =?utf-8?B?aWU4QitidGozV0hDREg5SUdhRHVpTjYyenFsbEVrdVRabmt5Ni9USE5KdjF4?=
 =?utf-8?B?U2hFSTBHTUJLbXpDR3ZqcVdWM0J5UVB6Tnd5SmZjaGpZRUJ2aGVTcm9RRUFD?=
 =?utf-8?B?KzBmckhVUFJHNTR1NGhKMU1NUDFETVBFMU5ySCtTQTdMcTcwbUoyWGptNzBj?=
 =?utf-8?B?bUx3enJIZE9FTUc2NXhNNS9PeWwyTGtrQ21HL0RwRFhBVEttOE9rUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8030a48-cab8-432c-1256-08dea5b8e843
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:31:12.3773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 944YW/YteA23UrVLGnWN2k3TgUUm4SwcbvZlhBz2N4GEu74cruMRJ69fSTK1bMzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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



On 4/28/26 16:04, Tom Rini wrote:
> Here's the latest report.
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Apr 27, 2026, 5:41 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
> 
>     - *New Defects Found:* 9
>     - 77 defect(s), reported by Coverity Scan earlier, were marked fixed in
>     the recent build analyzed by Coverity Scan.
>     - *Defects Shown:* Showing 9 of 9 defect(s)
> 
> Defect Details
> 
> 
> ** CID 645841:       Incorrect expression  (BAD_COMPARE)
> /common/bloblist.c: 303           in bloblist_apply_blobs()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645841:         Incorrect expression  (BAD_COMPARE)
> /common/bloblist.c: 303             in bloblist_apply_blobs()
> 297     				log_err("Failed to apply blob with tag %d\n",
> 298     					tag);
> 299     				return ret;
> 300     			}
> 301
> 302     			rec = rec_from_blob(blob - dat_off);
>>>>      CID 645841:         Incorrect expression  (BAD_COMPARE)
>>>>      Comparing pointer "rec" against "NULL" using anything besides "==" or "!=" is likely to be incorrect.
> 303     			if (rec <= 0) {
> 304     				log_err("Blob corrupted\n");
> 305     				return -ENOENT;
> 306     			}
> 307
> 308     			/* Mark applied blob record as void */
> 

I sent a patch for this one.


> ** CID 645839:       Error handling issues  (CHECKED_RETURN)
> /lib/fdtdec.c: 1785           in fdtdec_apply_bloblist_dtos()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645839:         Error handling issues  (CHECKED_RETURN)
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
>>>>      CID 645839:         Error handling issues  (CHECKED_RETURN)
>>>>      Calling "fdt_pack" without checking return value (as is done elsewhere 5 out of 6 times).
> 1785     	fdt_pack(live_fdt);
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 

And this one.

M
