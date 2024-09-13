Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DACFFA372B
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 08:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D46D8884F;
	Fri, 13 Sep 2024 10:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ol3XHuyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F7488861; Fri, 13 Sep 2024 10:50:11 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E1A88835
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 10:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAs6p+zblxrFWIT1IBaMG9NYHMhhUzOMh6oW6q5+FL6rbNtgch4K4+SU/Gf/X1u7MY8JY6E9z/KdP8z2YDJDPRwA/sWlQbZVgnn5Z3YQiy1R5JcJKeU0GvlX8fxreAHx1COfeSsAy948loTL3DXCMkofMzQ1XAyI775kU3MbV7GqvQ1BXANhEtMhvijLGZtGrwt0MO5KMdW3b+Qa5DEECw9odNLr7LSgErpB46/gwI/dpCUGWxYNlFydorIdimk1NUT2AXbymCvVS/IpxE9bfXMLSyl/XIoxXTCXC+/BGl+0fTWoTPpQzsTQf+EmNX9+Wmesi5/ZqWFAZRgArzYBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDSLqysIDsJ1gShDd2LwYtUFyqJhZ7XMAJc/tBuZPpk=;
 b=SwdElqgaW16JeQs/iNUog6dup+gfItpcexP7h64tFrZfShLMqYBGfbpWHh2Hfo14KSnXRZ8ED+zwJbbflZ4FDL2hUGVar42ytjuLMPb8y6lYdBJ8RVEZA9kq5YRUF3FXMXT7oW06ZJTI05FKnQb4BJB7R2WTfgoRf38PGi6tNs3ux0YtkQnzLeGf7nBorLhv/R35v2VzSc/5vD2nxnw43MYiCsBPrtVJ+u+qms4li1CXYvWMzVL+r9aIhXSEhSUvQSVMTDzaKQoAePzw6R8jEiDbPkIWZt/dnD7K8rOnxKoHQaJtWhqXi+5dKHbLjH3CyzVRt6DcuIiLd5eshiuTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDSLqysIDsJ1gShDd2LwYtUFyqJhZ7XMAJc/tBuZPpk=;
 b=ol3XHuySI16VkLqnD5+ypco0TCPb7FLLy9Sa8zhDoC64OdPiHcpxVoQA+TpLy0il4KiVwuFseOURPMGfyJgmZUAjGL2GGZxDelYdplPMVejt1NnQ1rEIL6XwXId5gOXhLaKMSX4xMS/FQlEVGNpzOFjRf8R6LAZaif8K+9UJpdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 08:50:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 08:50:04 +0000
Message-ID: <c7f54460-ef37-4648-b868-8c7258ee3865@amd.com>
Date: Fri, 13 Sep 2024 10:49:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: sf: prevent overwriting the reserved memory
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20240913073251.2286529-2-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240913073251.2286529-2-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e072e8-6795-4595-6fa6-08dcd3d10f8d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0JHaU9tTU11dVl3ZC9sLzU1djVyMHk1Zmh2bjJuZzFmdU9manJjTTAvNTNE?=
 =?utf-8?B?bGFCdy9iVlZUbmd3TVFrMjFPU3BqS1lPYzdjMDliRmNYN0pZMGVsOERoRDZL?=
 =?utf-8?B?dGg1MXJxK0t6R3JwTUlkcXFrQlFmTEIxdkd5UjE5Mk4xVGZEcS9IZFRKMFBY?=
 =?utf-8?B?YTNBNGxXRkdJVmJOOEIzZFIyL0hkdWd4QTZTNkVCbGdWWlQzYlVWUW1uLytp?=
 =?utf-8?B?aGZyNTUwTmFCMWNjRHd2Y3psa0puMk4wTW0vVTlSUUJUcjN5aXlFdy9UQjho?=
 =?utf-8?B?NEFFaHJRV1FPU1JZeHd0dXV3NlNzN28xbktNM25uRjZPRVBoL3BjZnFKRGxx?=
 =?utf-8?B?NHY4YW96OTFzdUcrSkhkak80WWtuc3JyUGVPV3ZkRmJqNmQvUFFHNFNsSWgv?=
 =?utf-8?B?WEdzWjJ3K2RIeXN2Q0tUTWRGZWJHSnRncDBDTW9HKzNlcTZmWllFdXdCM25q?=
 =?utf-8?B?UW5ibk9aZTdWeXRoOEplUElWUERPN1JWR2pVMVFZb2F3QXVkR2lUUGpldFJw?=
 =?utf-8?B?UEJ5Z2FLQ1ZpQ0o3YXo0MW56cFpCalpBMUtwVEE2SytraHQrb1ZHRTllSVJL?=
 =?utf-8?B?di9ZRjIrVm5GbG1QN3Fjb3lhL3RKS1NrNVNQZ0lBWHRyMFNpSGh4TUkzK0ZL?=
 =?utf-8?B?TzdveTdvK2o1T001ZStpUlIwZzg3ZXV1NnN3UWkzQTZucENhSER5WUFyUlhD?=
 =?utf-8?B?bzRuWU1HZFE5bW8rMTBBcVhoUzZOM2I4UlJ4M1kzYVNYZWVnaEt2R0w4MGxw?=
 =?utf-8?B?RlU2YzdWWFdLVHM3eWhRRVpINFg3Sjh1ZGoxVm9uTDBiY21XaUd3b2w4RkVl?=
 =?utf-8?B?ZVRSTjYvbitOYUJXVjNCQndqWkVlNE9hbXE2Umd0VHp0ajJONjJqOXlNYnBZ?=
 =?utf-8?B?V1dtUWR2NHJVdCtwWmQrVlNPNmtSNWVtOEN1TkhFL2VkUEU0NmVjU3VtVzR2?=
 =?utf-8?B?MHpScG13ZS9BbTFhZ1pkVXJrS0Y2WkNrd1VvdUZ6bXE4NG9lZHdQZU5MZldT?=
 =?utf-8?B?cDBIYjFHdFFLV2pRdTdFRlRwN2RUWnZqenBzQTVHamV1ek9HdFRnemlWMzNl?=
 =?utf-8?B?OHRqTUFoelVZRHIxTlBmYjZRTC9uS3NhMTQ1cmJUWkkvMzBJc0RRWkJ5cTdE?=
 =?utf-8?B?TFZra3RLdVVKaUNBZGlCWlZHZDl2Y1h0YnRGRzhBUExIQlh1RnR0MmJ0MURo?=
 =?utf-8?B?V25CKytxb2NCRG1VVWZTRXQ2VlUyUFJ2ZEx0MFpZNW5KcmlEUnlkUDdDbm9G?=
 =?utf-8?B?OEcwT0MyQzViTlJGK3hHMVVSankraU5nTWJETCtqcjBBNFpFTUczdTNPVUNu?=
 =?utf-8?B?VlF1SDVaaHhWdlUvOVFrdUpJanc1WnJCRkp2RlpOaVpkc0JTcmtxVTB1UlRR?=
 =?utf-8?B?RDAyYzY4Z3J6S0o1Rk4wZlFjUFVNWGdTZDZqMDVweTF4UTd6NG03WVVkclB0?=
 =?utf-8?B?RnVXVVAxSXZtOXA0MXRsbUxWaWJYSy82OEVtZXNiTHlUd2h5OW9kdHZ3enE3?=
 =?utf-8?B?MHU5NytGTXhzamFRdFdjUjU1cVJtNytMbXNxRDVqY211b2JEUzVDWmQxV0Js?=
 =?utf-8?B?eDRSa29yZkFWd0duRXJISldkckRNRWtTZnJERTZ4N3B6ZEJDYVFWeUJ1YzJ6?=
 =?utf-8?B?TjJRbG14R3dMV1RQSjNVNlo5dFBhai9DVW9JQ2hpQ05MT0hIdWhBVWdubTZF?=
 =?utf-8?B?Q0ZoUEVmSG5sd1BZbHNrUEhCQ2I0QWNtNWMxVjJUTEQ1cmp2b0NnelFIWHpi?=
 =?utf-8?B?Wm1mc2JMR1lucThldE44YUxLb1M3RnpBWC9uWVdzVjc4OERtTE90SjkxbE42?=
 =?utf-8?B?TmcyNklNOTZUdWhOa2NGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkszTWtzKzJQZVIrK0x5aE5sMFZFdGZJMlVjZDgwMjZ5WDBxemZBcWZqMW9C?=
 =?utf-8?B?YmRFNEZ2Tk1ZNFJQQklNaGU1bXUwSTRRSjdkbkVpMythbHpkYWFFclVGellm?=
 =?utf-8?B?a0lhSVExS2FaVTV4OG9VY1hXTER3RVVOUUhQaSs1SDRpQllOZHZkd1lOZEd1?=
 =?utf-8?B?QXJ6SHU2M1E5S3JVb29QcWY5VXd1cjZGNWowZ1p4bXhsL0RYVzBIUUljY1du?=
 =?utf-8?B?Q0phenJ6TWZvMm9Eczk5N3R4TXdvSDhKOHNyRFVmSy8yd09obU9aVlZqQlJy?=
 =?utf-8?B?OTRHK3dzTzBGdS9iaDh5SzB3UkxFN2ZoblBrbkE1Z3hHNDVoU21aNERUUTl1?=
 =?utf-8?B?azBDM3Vwb1k2SGI5NVV1cG9rbnFrZFN5R3VYdkcwQTJFbm5LajRNWkdKdlUw?=
 =?utf-8?B?TFhyU0hQZ2pwWHJ1SE4wbVhYWG5UcnN1SzBIQjJTOXdQU1lIZHZtU01YWE5V?=
 =?utf-8?B?ZWVTYXluOExqNVhRV2ZuUWFSeWRkNkhPSWtzNGlRL1BGZTQvYjh0L21JazVx?=
 =?utf-8?B?OGxxaFhkZWR1SnhnV0pNcWYvYVNFNStIdGZSd1pNUTBNeWxSSVgxQWN1cC92?=
 =?utf-8?B?L0dKZ0xEUmg5RkxuUzlVYWtoTGhLU1VSMlc4MllBK3laM2NnckcrRzJLb1J1?=
 =?utf-8?B?NDRueEk5cnhJWmpldUN1QlFEYnZUcnZDeHZhaXRLU0U2c2RMdG5MZUpPOGZE?=
 =?utf-8?B?amkvQTBPNDZ1ODdIUnh5a1BnNVAyc2NTeFV3YXI1cTllRHhwUmZIdmJ5My9I?=
 =?utf-8?B?a0xXa2dZQ2MvNU1FWkRhVkI2cjN3TFRUQ0ZPUWM3MjIrWUN5ZmZYbFZsUm5m?=
 =?utf-8?B?bk1qQUZsL0Z2SWEySmg5Q2ZiTmVDRDE5em1YOUpNY0hobDMyQ3Y0UkRwditZ?=
 =?utf-8?B?SnpkeUtyK3A3YmFvRFprS09ocHN0UFY1MkhjWXVaK3krdHh4d1pMQS9rQ1hp?=
 =?utf-8?B?OUdGSzBKcGZramVUUWU2d0pqTzF0TlFGNzFCS2dTS2ZpQ1hPVWQyc1JwdUlE?=
 =?utf-8?B?Y1RQQlhzNWU1bEdkdDVFSHFvTjBzckk3UjgybzVTR0pKbExSQS9lNG5XSWIx?=
 =?utf-8?B?ZkUzVHZTeDBQdkgzRlJpazArZngwV3dHUndwajBubG5FOWJEbC9wWXZBaTdP?=
 =?utf-8?B?bldyWlVHYk9GZzJ1UWxJTllFWHBUbUlVdVFXOTFmV24wWG85OUQ1M3lyai84?=
 =?utf-8?B?eE9OcUM3aUZRQi9qR1lXVHBiQnNNbHBXQlM5RFdXYTRMbE9leCs4TVQvSklo?=
 =?utf-8?B?YWhSNlhDbEc3UDYzTFFBNEp2eEl5MU5EVmRnNXI1aUhqSUlNY2xVZ2o5NDJm?=
 =?utf-8?B?OTVnV29vNFJ4VTF6dFE1Q1QrYUNJK2JYN0IzU01xSXluNGp3eERXMFRST3RF?=
 =?utf-8?B?b2d5akFOSUoyMGZBNTlLMFZlOHBHaUN3eXY2cVhBcW1mNFR1UG1TL0NwQjVs?=
 =?utf-8?B?Sm9GaXZwYVlidll0bVRCNUxjZDRyV1dvTnltWklFWVJiZzVId3Zvd25ITjR6?=
 =?utf-8?B?VGFGSFoxMWRZd1FvREJMRXpLM2RWeWdncmNhOE9lVmlRRnlWMWhPOWZSRCtQ?=
 =?utf-8?B?NkoyU2dubEtVVGYvTXRoaTJiVTRNK2IyV3QrZGpXaTdkQkh0L3JONGx0cHdW?=
 =?utf-8?B?ekN2VnY3dkVNbUE3cnRqTjNMY09PTGtKU2RBZlZhTFlPOU9ZM21UemtRZG9S?=
 =?utf-8?B?b3lpRUlBb0wxb2V3RkdiRC96ZXpnTTFCQkMrOHdudjhPem8veDZrQzgxaVhB?=
 =?utf-8?B?b01xbnRXZkc3MnNDZXN3ejZ6SmsrR2VkQWV1R1lDOFUrQ0Y3VEJCV0g4MnFZ?=
 =?utf-8?B?WkdiZCtHVmFWdDBIQ29xenVBSS9BcjdKQzdKb3Y1Ym52Mk5aQSt1emFCZmJZ?=
 =?utf-8?B?ZVdVSDlmejRteFZZZzVVV2lUKzJJak1DQmJSSGMyUk1MT0ZFdld6N2RjRWFI?=
 =?utf-8?B?dnRIbDZIY0RDUjB5WjlvbUdUWkJERVN0UGpUclJBUDNmUHNVS1JhUnZqcWpI?=
 =?utf-8?B?UHJYRW03SWVpSEcwUG4zTEdGdUFSUkRBcTE0TkJtd2NweFJkWjBVa2VhSEF1?=
 =?utf-8?B?Zzc3K3k2QWV2cWZkdTY2bTgyZEo3VHIwZE9MSVFid1lkT3ZFYWRyaVlKck1u?=
 =?utf-8?Q?ZaslzXXM5qLSsTYBeTnW3bYLx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e072e8-6795-4595-6fa6-08dcd3d10f8d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 08:50:04.4692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYOqD7hKVpUK3PEZ9ltkWFKiamE92v2t8KEoekw24sMOmoiAZnyGoGJviLBzTad1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
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



On 9/13/24 09:32, Prasad Kummari wrote:
> Added LMB API to prevent SF command from overwriting reserved
> memory areas. The current SPI code does not use LMB APIs for
> loading data into memory addresses. To resolve this, LMB APIs
> were added to check the load address of an SF command and ensure it
> does not overwrite reserved memory addresses. Similar checks are
> used in TFTP, serial load, and boot code to prevent overwriting
> reserved memory.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
> Changes in V4:
> - Removed do_spi_read_lmb_check().
> - Added the lmb_read_check() function in lmb.c, making it reusable for
>    NAND, MMC, etc.
> - Addressed review comments.
> 
> Changes in V3:
> - Removed lmb_init_and_reserve() as part of latest LMB series.
> - Error message moved to one place.
> - lmb_alloc_addr() is not required because the given memory address is
>    being checked to ensure it is free or not.
> 
> Changes in V2:
> - Rebased the code changes on top of the next branch.
> 
> UT:
> Tested on Versal NET board.
> 
> relocaddr   = 0x000000007febc000
> 
> Versal NET> sf read 0x000000007febc000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> Versal NET> sf write 0x000000007febc000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> 
> Versal NET> fdt print /reserved-memory
> reserved-memory {
> 	ranges;
> 	#size-cells = <0x00000002>;
> 	#address-cells = <0x00000002>;
> 	tf-a {
> 		reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
> 		no-map;
> 	};
> };
> Versal NET> sf read 0x70000000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> Versal NET> sf write 0x70000000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> Versal NET> sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;sf
> write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;sf read
> 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x01000000
> SF: 16777216 bytes @ 0x0 Erased: OK
> device 0 offset 0x0, size 0x1000000
> SF: 16777216 bytes @ 0x0 Written: OK
> device 0 offset 0x0, size 0x1000000
> SF: 16777216 bytes @ 0x0 Read: OK
> Total of 16777216 byte(s) were the same
> 
>   cmd/sf.c      | 8 ++++++++
>   include/lmb.h | 5 +++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/cmd/sf.c b/cmd/sf.c
> index f43a2e08b3..08e364e191 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -10,6 +10,7 @@
>   #include <div64.h>
>   #include <dm.h>
>   #include <log.h>
> +#include <lmb.h>
>   #include <malloc.h>
>   #include <mapmem.h>
>   #include <spi.h>
> @@ -317,6 +318,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
>   			strncmp(argv[0], "write", 5) == 0) {
>   		int read;
>   
> +		if (CONFIG_IS_ENABLED(LMB)) {
> +			if (lmb_read_check(addr, len)) {
> +				printf("ERROR: trying to overwrite reserved memory...\n");
> +				return CMD_RET_FAILURE;
> +			}
> +		}
> +
>   		read = strncmp(argv[0], "read", 4) == 0;
>   		if (read)
>   			ret = spi_flash_read(flash, offset, len, buf);
> diff --git a/include/lmb.h b/include/lmb.h
> index fc2daaa7bf..aee2f9fcda 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -111,6 +111,11 @@ struct lmb *lmb_get(void);
>   int lmb_push(struct lmb *store);
>   void lmb_pop(struct lmb *store);
>   
> +static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
> +{
> +	return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
> +}
> +
>   #endif /* __KERNEL__ */
>   
>   #endif /* _LINUX_LMB_H */


It is coming based on discussion with Sughosh in v3 that's why

Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Thanks,
Michal
