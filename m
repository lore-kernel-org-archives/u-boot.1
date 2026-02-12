Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19020EE3697
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 15:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733AD8388D;
	Thu, 12 Feb 2026 16:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="saI9CB1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6110B83AAB; Thu, 12 Feb 2026 16:31:00 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA56F83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 16:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B92Whhc3mE/t04bjBrb6v+Y4cGk/1Avq82eEGGppJvByHf6NODxIgh/kggO6SV3UVx4oa7Xz9odJNnfGaF1Vv59XduIixYVXPkbDPMAzRfGSoLKVpETzlQYm74CVap3/Legu0aAaI4Nmx2V+afdjrkvm4jnlxezgCNqhAqwXEqN6K8YrgOiijGTYC8rsQv5l4zaa1mCGPapL8JxW0f+KwjgqXBzn4MByuaRyt/T/gzdTGoCxsaoR5vYBN4y051EaLT/tb9dfz84NusUKop3i5nUR7sQE96+v1vweBlIxUcDfBvQ/bUf7PVLfKIFmTkjVcFdMFZcW4Tj8Qrof1w2zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU9sREJY8mVapbQWdFhnwyiTHwN8wX+J7BI3hQ5TuEM=;
 b=aiOZgBX+EZf2XR3K+W4MggFB9sKeZuyekNDj9SoqFG7W2amGh5ndg52XOnhAAV3+0c+Sns+6x4cVH/Brmdiuu9lku8qsoz+Md3wMhO5mDPe3oi7BArCav7G0c8wF2A5dceXCTcnkoGClJYSYlcOWK/HpLt8oqScxUyr06OR01f43eu3Ba7GWiN2vB4CIunn3omeuTw81qEbZOK08Smt63NbXm9mgNbrEUOHTl6t7yMPvfMOcwqgrBVE7yZRcqJYzcsZzukxfG/Hc6Gto0wnCnzL6OJlhllOCuhChBmk7B9Kjuy7BAd9jpQMl/CTz8A+fXSOKAM/c1dZJHi+UQmtp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU9sREJY8mVapbQWdFhnwyiTHwN8wX+J7BI3hQ5TuEM=;
 b=saI9CB1gpIszcrJdLFeRLyI2AfkPhXxxsuyxb275Pqxwk6rrEOWZ/KclP7lYtkf+h93ObLoqbChFmfoBWqYYkKxTfXkiSbCMxk/QscFuZPGGrcmievrkXPYAFNPl7CGje6tv/qMijN4L6gzGmnL8PVm2CX5CK2mZ/qIOrBTYKLM=
Received: from BL0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:207:3c::15)
 by DS0PR10MB8224.namprd10.prod.outlook.com (2603:10b6:8:1ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 15:30:55 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::97) by BL0PR02CA0002.outlook.office365.com
 (2603:10b6:207:3c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 15:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 15:30:54 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 09:30:54 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 09:30:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 09:30:53 -0600
Received: from [10.250.148.13] ([10.250.148.13])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CFUo5q3293863;
 Thu, 12 Feb 2026 09:30:51 -0600
Message-ID: <e8146b36-ac72-44cf-bcae-688d02636159@ti.com>
Date: Thu, 12 Feb 2026 21:00:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
To: Marek Vasut <marek.vasut@mailbox.org>
CC: <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
References: <20260204121245.2105523-1-s-vadapalli@ti.com>
 <4267b260-9479-44b4-bbeb-521738845be1@mailbox.org>
 <26f52e6f-d936-4180-8405-d30de803fc09@ti.com>
 <f503b515-3b9a-4dbe-bfdd-6ed02d2a02a2@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <f503b515-3b9a-4dbe-bfdd-6ed02d2a02a2@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS0PR10MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d55f463-9d05-4263-97b7-08de6a4bb676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTdnRUFHVWFsaTRDUlRFSWU5a0ZEK1JHRElna1gyQ0JjSU9odHRMamxXWHE0?=
 =?utf-8?B?ZHR5dDBvdklsdjFJa3grZCtCL1B0TDhWdTJRY2c5VkU3d1hzSXlUYXZUWlNU?=
 =?utf-8?B?aTFBa1FXQ0h1cWxOQklLWDBWbzYra09KQ1REUnJQNG1lNUF0SXg3UzFDVlhF?=
 =?utf-8?B?NXRXWXJ5QnBYcjVwSFR2UHd4aW8xcmNvWFN4N0xIZzdWT1hrZkxUQ2tRMUxs?=
 =?utf-8?B?REtncmJkYzdWQTVvN1JPMTZIRVd4b0hUWlMvZXc5RDRPMVI3bUJ1dURUdE9Q?=
 =?utf-8?B?dTdPQjRWSnFHT3pkbU1Xdm9CV1N3YlZqazI0WkRkNHBOcitpY3Znbnh2NWpF?=
 =?utf-8?B?MkpEdVkvdkNnU2RhM3o3YUpNdkQ1VWJGOUUrWkh6dFVpNW9lWGFVbHZVUDVk?=
 =?utf-8?B?dEpkZmlvU3VqcmVxZDNGRUg2K1hFSzY1YzJQMTUrZG5IS2NPVHppWGM2dFFJ?=
 =?utf-8?B?a3JtNE5HNDhwa2xlYjlCUTVUeUI4bWpKRHRCM1FNQUFjNEZaMS96V3hUOFov?=
 =?utf-8?B?bmhTUisraGJGWmlYVmZtSTMwanhNOElseXUrY3J2Qy9oTG9IQWY5OURYRy9W?=
 =?utf-8?B?MEkydEJkK20vK3YzWG9xYkQwQVZobHk5Y2JJczFqdFpmNitVVHlwOHJMUStk?=
 =?utf-8?B?MktzTTY3a1doeHJ0clJTVE1Bcll1MGJBUGlmT25IbDlRemxoR3l6WmxKSnpV?=
 =?utf-8?B?Y1FWMitidlNnRzNubG8zUDhUbGRJQUxTWERKWUdqY3BTR0dXcWJMa0xnMmI0?=
 =?utf-8?B?MHVNbnAzaklRUXA1ZHFSdTBab1pUYzVzbGZIL1VweW9nb3hOMCs5aHR6TVBT?=
 =?utf-8?B?TkVydkx2Q3c0emtCSFpvN1hZWW1MWklPVmM4cEd3VDF5NnBweWF6d0IxVWpJ?=
 =?utf-8?B?dE9HeG83dFV3dGh3dFBlVDVJWmtOYVZ2Zk02dFo4QlJ2TzlQNnJMa3p5cGdV?=
 =?utf-8?B?YnR3YkNaYTh5cUJUd3ppeWY5K2lWd1ByZzNjTFoxYU5EUmsvaEJRejdCd3FU?=
 =?utf-8?B?SzdBTEcwWHdZWEhRK1lUUGl0NnJCZWZ3TC91RGNjZUsvb2NUbElXNTRaNW41?=
 =?utf-8?B?aE5odkVNT0h6aFptejNtM1NScUEvS0owWDNSZnVHKytjTlo3V0tPZFVsRUEz?=
 =?utf-8?B?cWZ3clBjcXNIL1g4Nk9HcUJSeVBaZGxQZm1abjh3bTFXN0pnOVorOWRvblFm?=
 =?utf-8?B?cVRGK203WlF2am9wNnBlemt4d1o1S21QazR3NmlXRXZQU1VERWs2OUdFd0V6?=
 =?utf-8?B?MW9NeHZiNHkyTkdaUHpqWjRwcCtYdHNuMS81RlkxcXZnMXNiZkUxLzlTdEx6?=
 =?utf-8?B?OCtLZXRSYmgxdS9jRzlOUHhid1VHV2xmY2lQVWR1QXRsSC9YemtqTDJhMmlv?=
 =?utf-8?B?NFdYc25HUW40TzFkUkRDaWhweTRGL0tGRnFUb0c3elhBZFo3VGVlcmczZDBW?=
 =?utf-8?B?UDdKTnVoa0ZlWjMzemR1bnNhY0VMaUwxZEtab3ZaM2xZYS81b1RmT1BWc0gv?=
 =?utf-8?B?ZnpLUjllMUhqZWZXSk5DOUs3K1JKSWJEbFFJK2FZVlcvWVVIOEF1b2hyZldI?=
 =?utf-8?B?OUpDTXpjdmRaYjJiaWVQNExlMGJkeGp5WldKS2wzdHRtZjFMTEo0Y1FxZHpi?=
 =?utf-8?B?YzRza2RGQ3FpUG0vNlR0am90UzlYaFBEQmZHNkIzajdZVmV3SWFJUkdzOGNm?=
 =?utf-8?B?UmtmbUxBakQyZVN5UGVnMERQcldydGpZMGdGUjRmZ2xBSWx5aWFKSGpHbzdS?=
 =?utf-8?B?czZnK0dQaERMc29JaEVxS3JEa2ViNTFBdW9wZksxY3YxYzRmeVV0RXIzNGUv?=
 =?utf-8?B?U0FSN2sxbS9JTVlQSnB6eEU3NDU3VGFLWnl3bnJGRGxBWTFMSVJSWTN0VGNt?=
 =?utf-8?B?bW9ySFRMaXNES2w3MEt5U0R6Z0dOdUQxOXl5MEU0SVRQN2lmY3oyN0J4a21y?=
 =?utf-8?B?QTczclBuMmRrRzJZR3RoMmhaY0s3MmR2KzMwR0pDVTA5NlRWZnpuU1VKMmI1?=
 =?utf-8?B?NzlHZmVlaWJhZzFpZDVvL09RUzUraTBqOURVOStERG9LOUJ0dHNRbE9XUHdM?=
 =?utf-8?B?NUZtNHk3ZXZaa3UxdzFDdnFVWmlmQVdKWm5wR0w5SjRnVDVJb2tBNVl3ZkJm?=
 =?utf-8?B?b2NlUFhwSDlsVHR3WnNxc2JuSTVDTzE1L3VHOFNrZEFRQmxFeUN6T09hdklM?=
 =?utf-8?B?bTV2b0N4bVUyRVg1Qmg5bGVwSUNYdkxYTStWa1ZoVFliVjA4akxWUVhnOFdQ?=
 =?utf-8?B?ZmlxK1RRa0lZQ2xzQkYyV3lyTVJnPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DTsAKVBvuz6EL6Tun69CDWFKTA7ENCElHI3V3896t1oS9ieB9WZ/7Zlpnq15UchbxWSCj+TfyBHBuvk3bCQ9Q/WL3GgGLQpgDme3npMy19lqwQoAvAOj49YLbxEtPG+kE/BUm09nZtxRAgwLlXi9gx1th2mh8wFNSlUBUWasxgs5KIJCrsq+kb5xktHO4G60rD+LI+If5meVKPBVycd6tLCJ/cNPOQuaD03uEPb2/kcluGLJZJiN6aoZ/pjM4dYFzbrWvluqR6+uxXi2CI66s+6C5TBFqhWehvrICgUYhkJb9dkfgcC0Q1YGnYcgQCbbS6MDb2zKtR8z543N1EJf1VF0OhNJCEfsIbfxBStFGSlPgXzhIBMP9lPKVbpRZv6Ulq/t5gh9toMGNuVtrwAMMKsNCAOfH2Rpi3svILmQc/4L9L9NN5fOBJz9RBjTcEek
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:30:54.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d55f463-9d05-4263-97b7-08de6a4bb676
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8224
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

On 12/02/26 8:12 PM, Marek Vasut wrote:
> On 2/5/26 2:11 AM, Siddharth Vadapalli wrote:
> 
> [...]
> 
>>>> +static enum usb_dr_mode cdns3_get_otg_mode(ofnode node)
>>>> +{
>>>> +    struct cdns3 cdns, *cdnsp;
>>>> +    void __iomem *otg_regs;
>>>> +    fdt_addr_t otg_addr;
>>>> +    int otg_reg_index;
>>>> +    int vbus;
>>>> +
>>>> +    otg_reg_index = ofnode_stringlist_search(node, "reg-names", 
>>>> "otg");
>>>> +    if (otg_reg_index < 0)
>>>> +        return USB_DR_MODE_OTG;
>>> This is wrong, the function should return error and possibly mode via 
>>> function parameter , do not conflate return value and mode please .
>>
>> Regarding returning an error, the patch maintains status quo for the 
>> case where we are unable to read the USB OTG Status register. Please 
>> refer to the following diff in the patch:
>>
>>
>>      @@ -413,6 +462,10 @@ int cdns3_bind(struct udevice *parent)
>>           if (dr_mode == USB_DR_MODE_UNKNOWN)
>>               dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>>
>>      +    /* Use VBUS Valid to determine role */
>>      +    if (dr_mode == USB_DR_MODE_OTG)
>>      +        dr_mode = cdns3_get_otg_mode(node);
>>      +
>>           switch (dr_mode) {
>>       #if defined(CONFIG_SPL_USB_HOST) || \
>>           (!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
>>
>> Only if the 'dr_mode' is already 'OTG', the newly added function 
>> cdns3_get_otg_mode() is invoked. In case cdns3_get_otg_mode() cannot 
>> determine the mode (otg status register cannot be read), we return otg 
>> mode to maintain existing behavior, following which, the code will use 
>> the CONFIGS to determine the role.
>>
>> Returning an error will alter existing behavior rather than extending 
>> it for enhancing functionality.
>>
>> Regarding passing the mode via a function parameter, I could do so, 
>> but I followed the implementation of other functions such as
>>      usb_get_dr_mode()
>> which 'returns' the mode rather than using a function parameter to 
>> fill in the mode.
>>
>> Please let me know what you think.
> I think this patch is wrong, cdns3_get_otg_mode() should return an error

Ok, I will update it to return an error, but please note that it may 
alter existing behavior since the code is being introduced in the middle 
of cdns3_bind() and not at the end of it.

> code and also return mode via parameter. This:
> 
> static int cdns3_get_otg_mode(ofnode node, enum usb_dr_mode *mode)
> {
>     ...
>     if (error)
>        return -ESOMETHING;
>     ...
>     *mode = some mode
>     return 0;
> }
> 
> Do not conflate mode and error code, this leads to problems.

Ok. I will pass the mode as parameter to the function. Thank you for the 
clarification.

Regards,
Siddharth.

