Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8DDC47BE8
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 10:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972E783981;
	Tue,  6 Jan 2026 11:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QpAVUzsQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41043839A5; Tue,  6 Jan 2026 11:52:40 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8014183936
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 11:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p65TA6KDupTXfhRHSRXXDfQbrIhYFTE+P3MpARhszl9EF9NR4n45kG8tV2UbphVfJ2ZbZu37EjjkULV+rxTJLteputxnGZ+WY4Hhj1HPWl4AV+jCCbQyAjdJnkHKwAt/RGyWy43wB9h+ZlJQows8zeVXjOkmUpoGSmy+HbIm2yD4VD0U2L6pwq20+bFzSmEechLwwVQdLqfbd2OZXNOOUrFTC6KnMtP5oNTzhF/VwO/43ZJzdjwqZFh2VWWJX6ZAK9Am6JZHUnFooRmx2YnUOuTuff832EO1FgEashdmg7obpskCnJR4lyu4IrJ/cN7QY5eMFljjY42MDABPZBzOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIjuxzuaUUhHQdLbDdrWYuB0UoE+IOimuWYVlOShZiA=;
 b=mHdwr00ggM5PUeIkqbEsVpuoiNQRprYbMy9jYMBzydWcNbk4dVtOnpHFsmKDsoW88CINsxqLBnQV/e3gHaLN6rG9oDwq/YJIMt8d86FA9hvAj/6tqFqhd9oJgnazWMmMatmsTjNlEC6tG1Esb+HdObPU16PmquN+m12V+xMasEbtG78ZHEs+u/Fh1v/XYv+Tb9JnUj2wuwXa1ETy34NL3YWQNBi2JESvKm0443JhaCE4SuUynuFcceOT2vDKhqVHv3vxYkqNHHxauCZrKRMmXDkYqGo81sBICyxuaKorB4yeCggkABKlXndA1mGwIEmaogrxvQnlNCwXe6QF4LYdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIjuxzuaUUhHQdLbDdrWYuB0UoE+IOimuWYVlOShZiA=;
 b=QpAVUzsQsFx2VtoJ6xx3S25Ba4xyAmvL2F3QMBpryMu+uaLOI43xuNvjSM+YiWOs+9WYthoNSkh1tB4URTWz/WLRJDd6TqdL4f0Dft577FRI++74otHycGx0YogG5lNSLzki2QLTR52G9lfmOLLj4wnoHcqUoS2aR4AZ3tvXT88=
Received: from SJ0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:33a::33)
 by SA1PR10MB6661.namprd10.prod.outlook.com (2603:10b6:806:2b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:52:34 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::20) by SJ0PR03CA0028.outlook.office365.com
 (2603:10b6:a03:33a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:52:33 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 04:52:28 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 04:52:28 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 04:52:28 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 606AqPGv2894779;
 Tue, 6 Jan 2026 04:52:25 -0600
Message-ID: <eb2f3762-13b5-421e-b7e7-7f1fef6419a7@ti.com>
Date: Tue, 6 Jan 2026 16:22:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] binman: openssl: Add boot and load extensions to
 x509 cert
To: Simon Glass <sjg@chromium.org>
CC: <trini@konsulko.com>, <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>,
 <hnagalla@ti.com>, <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-8-b-padhi@ti.com>
 <CAFLszTi73RSFM4d2fzvndyw9mOq4D-gqQ2Gp-YGcYdp5gu-s1g@mail.gmail.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <CAFLszTi73RSFM4d2fzvndyw9mOq4D-gqQ2Gp-YGcYdp5gu-s1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA1PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 839b9aa3-a06e-4049-f70f-08de4d11b21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a21QVUoyaDJzQzhxUjFhUHg5Sk9YQkxGYzdrMFIzUzVuNFQ5bzVWcEJvQ3Q2?=
 =?utf-8?B?UnlZS3dodXdteTROU1MySERtSThLYWdmUXFrSkZtSElQSnhqcGo0eFlrQlJZ?=
 =?utf-8?B?Q2VZNFIyZFMzQ1YwRnBKVWx1NEFKUW1WY21Icks5QXdRQWVGMmIvNDU4eGVm?=
 =?utf-8?B?czBFWnZ5dC9EZkRYbElsSDg3bFFkci9KL1Fkd2sxRXFRUWVQczdGOW9NdjNy?=
 =?utf-8?B?QnY1U3ZPQ3QzdGFmMm5lOUs1bURTamJtWGtTTDZUdVdybWh2eWJlYlNZLzM0?=
 =?utf-8?B?UUZWc2thNmlNQ3c5cHRVWFhsNmdJQnVHYkZueGdxNTJJTmg4K0k1OFFmYWRj?=
 =?utf-8?B?K0plL3J5MFZnVW9Sa2dvYmtMeWZBTFNFZE1OYTZwWDlpSGx6cU1zQ1k0WCtM?=
 =?utf-8?B?Yjl0dWsrSllQWWVkYVVpMDcvZnlvbmpBNmpYUHBGb2c2S3VGamxRaVl2NkRD?=
 =?utf-8?B?TkxydUFwQk5CZCsyY1lKT3NCN3kwMnpMemRmdEhtMlFkaURCaTF5NmhQd3Jh?=
 =?utf-8?B?cDFzeFVuNmZzRGNqUVlZbzh5NGZUVlJGaXFoT1dHbmRIRmUvZ2MxMkQrWm4y?=
 =?utf-8?B?YlJHaU5EM1U3clRXTU4xOEV3bDBXL3ZueHVydnZyZk0zTmRtcDA0bDljM01N?=
 =?utf-8?B?bnBNYlhjcHZleVRqVjZ3V0RLYW4yd2F2WFV0MHhkWlBsN1ZlWmhlZEYxeEV0?=
 =?utf-8?B?emdWdmhVdXkyVExpTE1mL1JoSnBIMFZoUlZ3UEpHTTRmY08zZVZubGtpdFd5?=
 =?utf-8?B?VHl3OXYxU0NpMGFaS1JseS9CSUF2NzhtYTdsQ3ZjOVVNZUNaWXJtdXVwdkFF?=
 =?utf-8?B?L243SVcrbTZ3RWsrWUpMaTdoQ0tuYkg1cmhXU25TUkw1cjJvc2x1NE00TnM1?=
 =?utf-8?B?YXF1OFpISWlXck8vL0x4VUFFMGt0a3FVcmZJL0prS2RTeEUzL0FTYUQzU1dR?=
 =?utf-8?B?QUxub0dVTkMrc29HOGFTRUV6WFhRTUx1VSs1eXhVL1RKWE9qZjFzUTFUV2Fy?=
 =?utf-8?B?N210VFlIS25MdHhrc2k4QUV5MkpmMEpCQW4wNEVjdVVIZ285M1k0QUxxUGNk?=
 =?utf-8?B?bndZUUpwMkd6dkF1cVRvYlZ1dWpaUkdCbS8ybi9rNDAydlQzeG8weks0ZTBW?=
 =?utf-8?B?b0EyYVBBMmFDKzRwRDU0Q2FqZGdoTStEaGg1Uzk2cFVkN1dPWW4ranpxNnRX?=
 =?utf-8?B?OWZWQzM5Z0pja0JXcTlHL28zZUR0KzR1cjBZVXdGcXFlbHY4K1hOSE1KQ21E?=
 =?utf-8?B?M2R3ZC95RFFhSVU3MjJKQVpsMzNpZUFZVStHY1RzcmVaR1kvbHN1NlJNcmRo?=
 =?utf-8?B?eHVTM3A5VitRVlZNN0JrMUp4emdkVjJDbXp2MzdWMnZhb0grT0t4VFN1VkVw?=
 =?utf-8?B?UGJwYjFSd2hXbDVQMFltWVljQkhXYTBodFpXc3o2MFQxOVBpUkJSbTd2bWxE?=
 =?utf-8?B?ck1hZmJCWlJLR2lNNlVTTWNLNi9DdzhKbUVkWS85NUlxblRGeUtvaDhFZFZJ?=
 =?utf-8?B?QnNtNCtKbnZWZXUxZnl4RXg1NW16c244bGttVks4ckVBaWNRRVcrTUhoUm4z?=
 =?utf-8?B?eVh5QTh5bHhmWTZpcTZiUGI3Z2R4bDAzWEliU3ZqaUlMb1M5WFdsbWJxUHBD?=
 =?utf-8?B?TiszaGt4Y1ZCeUpoa0dpWjZEOWwyU1VndWtmM1B3RkoyZjVjN09PYnFmN2ls?=
 =?utf-8?B?R3Q2RDQzTi9tMUE0NjNTMXZkQ2ZJazE3M0VPcGJSKzRyN3pOR3pyZmhNMTVF?=
 =?utf-8?B?bnhXVTdZaVRiRFQ1Z2M0SFpneW8wRHRuSVhTT2k5ZzBLemhLTnYraDUyQ2lr?=
 =?utf-8?B?M2w4QkZoMVR6eVhJT0dHeDVVTFFBVEt5UVMrZFBNem5NZ2dMRlRGUTdFUnpT?=
 =?utf-8?B?Qk4rN1VaWEJ4RG1iL0JsZ1V1YXovc0dFRnlpQ3JiamlWUGljSnZGREtpakM5?=
 =?utf-8?B?VnVPM0FQeldRbTYxQlQvaUtQQUlNOTNjZUppdHdEN2N0TTNpRkE3TkdlOFg1?=
 =?utf-8?B?Q1VWOHdreG1IdUhLQmxsTEh2QVgvVzZVbGE5Q1gwRzlLV1JmMUM5VERJYkts?=
 =?utf-8?B?dWY5bUx3ZzFwRmNUZmZCOXZHWSt1bnhtZEFwdEdaRU0vSlZMeUJVY0dvcndp?=
 =?utf-8?Q?pJPA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:52:33.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839b9aa3-a06e-4049-f70f-08de4d11b21e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6661
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

Hi Simon,

On 06/01/26 05:00, Simon Glass wrote:
> Hi Beleswar,
>
> On Wed, 31 Dec 2025 at 10:37, Beleswar Padhi <b-padhi@ti.com> wrote:
>> The boot and load extensions in the x509 certificate are required for
>> requesting the secure entity (TIFS) to boot a core. These fields are
>> defined in the binman node for each core that must be booted by TIFS
>> and must be included when generating the signed certificate.
>>
>> Add support to parse the boot and load extension properties from the
>> binman node and populate them into the certificate. If any of the
>> mandatory properties for an extension are missing, that respective
>> extension section is NOT added to the certificate.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> v3: Changelog:
>> 1. New patch. Add support to sign HSM firmware here in U-Boot.
>>
>>  tools/binman/btool/openssl.py   | 49 ++++++++++++++++++++++++++++++---
>>  tools/binman/etype/ti_secure.py | 18 ++++++++++++
>>  tools/binman/etype/x509_cert.py |  4 ++-
>>  3 files changed, 66 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
>> index b26f087c447..35898aa488b 100644
>> --- a/tools/binman/btool/openssl.py
>> +++ b/tools/binman/btool/openssl.py
>> @@ -82,7 +82,8 @@ imageSize              = INTEGER:{len(indata)}
>>          return self.run_cmd(*args)
>>
>>      def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
>> -                  config_fname, req_dist_name_dict, firewall_cert_data):
>> +                  config_fname, req_dist_name_dict, firewall_cert_data,
>> +                  boot_ext_data, load_ext_data):
>>          """Create a certificate to be booted by system firmware
>>
>>          Args:
>> @@ -101,12 +102,52 @@ imageSize              = INTEGER:{len(indata)}
>>                  extended certificate
>>                - certificate (str): Extended firewall certificate with
>>                  the information for the firewall configurations.
>> +            boot_ext_data (dict):
>> +              - proc_id (int): The processor ID of core being booted
>> +              - flags_set (int): The config flags to set for core being booted
>> +              - flags_clr (int): The config flags to clear for core being booted
>> +              - reset_vector (int): The location of reset vector for core being
>> +                booted
>> +            load_ext_data (dict):
>> +              - dest_addr (int): The address to which image has to be copied
>> +              - auth_type (int): Contains the host ID for core being booted and
>> +                how the image is to be copied
>>
>>          Returns:
>>              str: Tool output
>>          """
>>          indata = tools.read_file(input_fname)
>>          hashval = hashlib.sha512(indata).hexdigest()
>> +
>> +        if boot_ext_data is not None:
>> +            boot_ext = f'''
>> +[ sysfw_boot_seq ]
>> +bootCore = INTEGER:{boot_ext_data['proc_id']}
>> +bootCoreOpts_set = INTEGER:{boot_ext_data['flags_set']}
>> +bootCoreOpts_clr = INTEGER:{boot_ext_data['flags_clr']}
>> +resetVec = FORMAT:HEX,OCT:{boot_ext_data['reset_vector']:08x}
>> +# Reserved for future use
>> +flagsValid = FORMAT:HEX,OCT:00000000
>> +rsvd1 = INTEGER:0x00
>> +rsdv2 = INTEGER:0x00
>> +rsdv3 = INTEGER:0x00
>> +'''
>> +        else:
>> +            boot_ext = ""
>> +
>> +        if load_ext_data is not None:
>> +            load_ext = f'''
>> +[ sysfw_image_load ]
>> +destAddr = FORMAT:HEX,OCT:{load_ext_data['dest_addr']:08x}
>> +authInPlace = INTEGER:{load_ext_data['auth_type']}
>> +'''
>> +        else:
>> +            load_ext = f'''
>> +[ sysfw_image_load ]
>> +destAddr = FORMAT:HEX,OCT:00000000
>> +authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
>> +'''
>> +
>>          with open(config_fname, 'w', encoding='utf-8') as outf:
>>              print(f'''[ req ]
>>  distinguished_name     = req_distinguished_name
>> @@ -138,9 +179,9 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
>>  shaValue               = FORMAT:HEX,OCT:{hashval}
>>  imageSize              = INTEGER:{len(indata)}
>>
>> -[ sysfw_image_load ]
>> -destAddr = FORMAT:HEX,OCT:00000000
>> -authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
>> +{boot_ext}
>> +
>> +{load_ext}
>>
>>  [ firewall ]
>>  numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
>> diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
>> index f6caa0286d9..bc44b684892 100644
>> --- a/tools/binman/etype/ti_secure.py
>> +++ b/tools/binman/etype/ti_secure.py
>> @@ -116,6 +116,7 @@ class Entry_ti_secure(Entry_x509_cert):
>>          if auth_in_place:
>>              self.firewall_cert_data['auth_in_place'] = auth_in_place
>>              self.ReadFirewallNode()
>> +        self.ReadLoadableCoreNode()
>>          self.sha = fdt_util.GetInt(self._node, 'sha', 512)
>>          self.req_dist_name = {'C': 'US',
>>                  'ST': 'TX',
>> @@ -126,6 +127,23 @@ class Entry_ti_secure(Entry_x509_cert):
>>                  'emailAddress': 'support@ti.com'}
>>          self.debug = fdt_util.GetBool(self._node, 'debug', False)
>>
>> +    def ReadLoadableCoreNode(self):
>> +        boot_ext_props = ['proc_id', 'flags_set', 'flags_clr', 'reset_vector']
>> +        load_ext_props = ['dest_addr', 'auth_type']
>> +
>> +        self.boot_ext = self.ReadDictFromList(boot_ext_props)
>> +        self.load_ext = self.ReadDictFromList(load_ext_props)
>> +
>> +    def ReadDictFromList(self, props):
>> +        props_dict = dict.fromkeys(props)
>> +        for prop in props:
>> +            val = fdt_util.GetInt(self._node, prop)
>> +            if val is None:
>> +                return None
>> +            else:
>> +                props_dict[prop] = val
>> +        return props_dict
>> +
> It looks like you are adding new code but without a test. Please can
> you run 'binman test -T' and ensure you cover all lines.


Thanks for pointing out. I will add a test for the same in v4.

Thanks,
Beleswar

>
>>      def ReadFirewallNode(self):
>>          self.firewall_cert_data['certificate'] = ""
>>          self.firewall_cert_data['num_firewalls'] = 0
>> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
>> index b6e8b0b4fb0..b6028f6be84 100644
>> --- a/tools/binman/etype/x509_cert.py
>> +++ b/tools/binman/etype/x509_cert.py
>> @@ -102,7 +102,9 @@ class Entry_x509_cert(Entry_collection):
>>                  config_fname=config_fname,
>>                  sw_rev=self.sw_rev,
>>                  req_dist_name_dict=self.req_dist_name,
>> -                firewall_cert_data=self.firewall_cert_data)
>> +                firewall_cert_data=self.firewall_cert_data,
>> +                boot_ext_data=self.boot_ext,
>> +                load_ext_data=self.load_ext)
>>          elif type == 'rom':
>>              stdout = self.openssl.x509_cert_rom(
>>                  cert_fname=output_fname,
>> --
>> 2.34.1
>>
> Regards,
> Simon
