Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C9FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D7B871CD;
	Tue, 21 Nov 2023 15:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k65FGCd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B883871CD; Tue, 21 Nov 2023 15:28:58 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02BF7875B8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W71crsrGfQmCSvPi5u0wuweT4C9xjSXfZJz1+YFRmTKV7/1IrfmswUOXmBXu+l9u362mQh6V0xvawjrVPuCfvfUmAaSXnYMIuwywG9bpwufuUvKqh5akAgPBfC+tl1U0VtAMsFjJg+BptSECPrVsLM8qnsrkmkwNMnaSLx4YpJDYFVS1cr5Y89k3Wz9EOidNgmyV4gLwjsoQGU6rOpanzQyC2P8NdlgoJHEvYbUzZ4+15lAHa1IS3Y8Djv9JAQpj+SzwT01Jv9ue0iOHkbfeZXCVPPjzgiS20sy/SlNyT+OS2eH7sHNyvYaeCFcUEGIVz0sscKxgHHnmQkyLnw6TSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl2z7vnjkXROnToafhdVgBoB2aW8Gcvjf7/zkPU/WXs=;
 b=PvME/FpmkAaYoI0BjADG87emZF8UHCA95bgP6pwfu+eYO8YE3lGPUJSEt1+nu4U5tWoPkr/sOXXx84L+fjV3ZaCq6FZ9UpjKcP9F2xm3KvNPfXMt7lSHi2RkJzDw6qFP/w72iUGpKCXP1bkdH9WfGZ1GRTqmKVyObK+Sgp/KM98KMln89zVRQl9X3fNSRXXxLh7cWsGGtmsFjE/pJRT5dtuO3CGLnmfrlj3oTzaToC/dgEhNJyD/JQ7hcdShd84NeUFcJaOzHefWhQK9c94TZVlk00u6zY2t5ivrFu8VvUBVrz0coxBDqyEABmh432Qey/J6jRKgy/c2acAvxDQMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl2z7vnjkXROnToafhdVgBoB2aW8Gcvjf7/zkPU/WXs=;
 b=k65FGCd7Yz9dNbnVG/w4hW0qhL4CCdCI7YC/BOPm8cSeFUDqTX29S/YW63Do1j6IDE+i58OR2qwvJcpszFKJLdSXqiV47TdNJ4frpf5xpdPxTz5fKSMPAUaXPTelpFTjWlOXKsAzivgojYV7py28D1zCIpsusmP6LNZOI9y618U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 14:28:53 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 14:28:52 +0000
Message-ID: <23f7722b-589d-4359-aef2-180305c838c0@amd.com>
Date: Tue, 21 Nov 2023 15:28:42 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 1/2] xilinx: zynq: Generate dfu for SPI only when enabled
To: u-boot@lists.denx.de, git@xilinx.com
References: <3ea0572dbda8f21270c00a77528eb6ec954c7c40.1699866313.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3ea0572dbda8f21270c00a77528eb6ec954c7c40.1699866313.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0222.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::43) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b4332c-fa36-43a6-8446-08dbea9e2f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoV3YLuG2jXmiZVBOeLwEzwR42bAG3I8TEDs6e/uYf0bXCYb1Cwc3cLVxqP63T6WnMwjf/3V4qDGvTiEQ7VhzJiGRtvDHxricTPURpcDN6ffy1LeQPCy4SIjta5V37To1+Yu1VUK1miDOfaLK5Btq8YEGrgtvseUHxqfJybuCDXPHU2RL87cffLccYRMhdsnbFypNxb/RSTISpHAx2gqLDI4CdSgUYePeWOIob9jSGkB2mmJTlA76VvF4qG0j6cJIRcwcEdGoGTtZGYVsBo+2jGmBBKa2hxLLQj7OjMLhHdSVgYguz0JecqiW5puFT/UZEpOjYUZTwpj6t622jqinCX1beW6qmSub50hn6sI5us4Z99ypYtiQE0i8EaZUxFi1iQ0z7Oe5i9CtCzqua/UMqqBDYcv3AjQZNzwChcRX5YqeQYKX4szjb2coe+mKNCDCE5zsLUrBT10wO0OtlRhgx/ZwMs/msaX2kAjgUl0rVbTIKFVbANgqPSPEH6npQEpnOfoXiq1pENXtQMTPOIpGImxl6hOaPxG3LMEilOpMrih5ByvIuACnvh4YI+xILprhiTo0RRWKsRQGWmf4kUimzUOfm0Txs5birkFhkkMRjdU+N2Hb+pAvwqLcY00ZGeBoMbEXsZqHsIkSN0ATp/3Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(31696002)(31686004)(6666004)(6486002)(6506007)(66476007)(66556008)(66946007)(316002)(36756003)(6512007)(53546011)(26005)(83380400001)(2906002)(44832011)(478600001)(41300700001)(5660300002)(8936002)(38100700002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFyYmVxL2V6QmtveGM4VzVaR1I5cjdWc05DODlyZ1F2RTR0ZlFsSGlaZ2NR?=
 =?utf-8?B?emd5cHZzOXlqSjR6eVd6NnhINndxMUhweFlIblFhR0lFbGxyZ016L3h6TjBk?=
 =?utf-8?B?bWozRGRWS2txR1RudloxU2NSa1UzK3NpMzVYeGE0VEpnNEJVbXF1Q1NQakhh?=
 =?utf-8?B?N0dDa0czU0hJNHF2MTQ3SFFUYjFDRnY3MVFBSHpaa0NvYTBxcUwvd1lEclNx?=
 =?utf-8?B?RmtPWkQ0WGlQcE0vNkI4RWt3VHJGdDNndVpQU3FVK1ZqNjJtV0Zpd2pqU05v?=
 =?utf-8?B?TE5taURnRFY2UWRSeU1Dd1phVkVXYW5vMERwTkdra05LdWdRaWo4cExLT25Y?=
 =?utf-8?B?YUJvR1BBRGo1TEUrMEhrZGJoSXgyZmVLK0Fqck9BMXlIT0ZTd3JMYm9JU2Vm?=
 =?utf-8?B?bWU1NlAxTUd0QWc5UmpNTldWdUVaWExHRkVBelZIZEordDZJTXRnOHBLUHNE?=
 =?utf-8?B?ejZvcDNmclVDZUtLVWU3Y2dudWtOZ1JFYzNYSjZIbG44MjVTeEFPNERCK09U?=
 =?utf-8?B?M2cwVFhsTlFMcDJiQzBYZW5yWkR3L2JoWWM2Y3BUS0syVXh3OFFjTlg4MVRw?=
 =?utf-8?B?cnNLZ1drdmcwZjlJUUozcEN4dUR5UzdBU1hkaGVtK29pQ2RKWFp4T3RQZ3o2?=
 =?utf-8?B?cHpQQlZqYXA2OU1LWlJOMEdjdVlHRjdESGRtUC9vNlRBRHo0N005YVRRamdX?=
 =?utf-8?B?dmUvczhlUzVCd3RiQzJhUFFKRWV0eko1eXNTb3NBN2JaYmlyQm9DQ0k3cks0?=
 =?utf-8?B?ME1JTVBJL2VndEZITmMrOUM5dlRTTGdTTHF6QUVycUh4WGlJQXJOdTIxUkQr?=
 =?utf-8?B?WGRUV3c4eUdOL1NSaFN0VE5aSUVJZzhiZ1R2RnlJWk5tTTRjanN0c3pmb1Ur?=
 =?utf-8?B?Rm9GYU5QUE5RZXFnWXJWSW1tTEJBOWhScDdiYkRxNmNYcExsSkYwMDFSTDgv?=
 =?utf-8?B?YkNKVkdxQWJINUVLR2RLQkxKall3YUhFdTdFa3BnbW5MZyt0OVhkRU9zYVR5?=
 =?utf-8?B?YlF0TUVCTCtLcDNmdWFMUmJUKzcvS3JNdjExRXJIN25sNDQ5Q1dCcTgwOXRv?=
 =?utf-8?B?TTQ0VlM0cndQbXhOTWhvYWorZ05DY2phQWp2NE9QQ0dRWmREejE0WDV1ekND?=
 =?utf-8?B?VWo2TjdFdzg4WU9rNk42VWVqdlFHbDM2K01NMjJjazRUV1pYSE9ES1ZpMEVY?=
 =?utf-8?B?VHRVOXE3VUZJU1JkRmZreEVVNlZFU3dCREp5bm1qR1Jlc3g2dSsxTzFoM2RR?=
 =?utf-8?B?TzNQWEZNWnlyanFFNmJ3WHNHWWFDUWtvWG03WVJoc0JTbTA4RmRyRWxsaURi?=
 =?utf-8?B?VHhOMmdpV1ZmYXpaSHRLUjhMaGxXTnVEUXVOWmNST1N5UWJFdTNWTUJvQ1VQ?=
 =?utf-8?B?TUh6WjVPVTNtWmZYTnQ2clRnUWhVdDNBZ1ZESStxN1VqY1V5M2t5ODNVbFQw?=
 =?utf-8?B?ZVdoaXh2eUFBM1RNVWFSRFo4Z2gySVd6VDhHTThFQjJvc1dGY1F1bWUyQVVu?=
 =?utf-8?B?UUZwWXE5VkR0ZzdDZGMvdjd3WFIzY0pseFltaFNNcTZPb1JnenVsd2VvZHdt?=
 =?utf-8?B?OWFJSWhZVEEyQnkxazJnTkF3STQyMFQzVVoxbnBEbURreGNwckdYQ1VValFQ?=
 =?utf-8?B?eWFEdEdvMjZENUJYNlVDNFo0eWJIODM2d1FGZGxMbTJ5UHVvSTE4clFBVUVv?=
 =?utf-8?B?TFVFRk8rYkZhNjF6em1pVFVJeDlDd2pUL3Voa1duM3V0NldnQThCN2E3eGhr?=
 =?utf-8?B?RDc4N2RZR05weEN2TDRvVkpKZm5HcHA3cEgwdHZyMXRyYkdZODVtSENNZHIx?=
 =?utf-8?B?SmtvcU9FYk9qRE1zM0Z0bkgrcFJ5WkRmSnZOOExESWRud1RPaHNNcWR0RHNE?=
 =?utf-8?B?djBzaEQ2MXlZRVJ6R2RaNGtURG91T21nOEFURmc3aTEyQzlVMkdqZHdEbHhB?=
 =?utf-8?B?Y1l4bmF6K1d2SFVXdWU2WG1HeXUyUHRIaTFVcXNDSTUyaENOL2Z2dGZteTBn?=
 =?utf-8?B?bGtpNHg5RFVnM3N2OTljWnA5U3pJWkpWTGtkVUZxUjBMU3Z0a0dzclhkaU1i?=
 =?utf-8?B?eml6d0loeVJ4cHRYYy96NW8rK0s3UDg3cFp1TGdUMEhOWnBSaXVydG02ekEr?=
 =?utf-8?Q?lnZmef/KR1YqkefPGvKlylMKp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b4332c-fa36-43a6-8446-08dbea9e2f76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 14:28:52.7763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvx/JTFV89bgPGoTNX7RHl+ymjc2+amw2chl+qICn4GizJ2/WyVP6MjWqrbqi9+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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



On 11/13/23 10:05, Michal Simek wrote:
> Bitmain S9 board is not enabling SPI that's why CONFIG_SYS_SPI_U_BOOT_OFFS
> symbol is not present which ends in build failure when EFI/DFU
> infrastructure is enabled.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynq/board.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index 3b6581e30462..6c365910011d 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -184,6 +184,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   			 "mmc 0=boot.bin fat 0 1;"
>   			 "%s fat 0 1", CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
>   		break;
> +#if defined(CONFIG_SPL_SPI_LOAD)
>   	case ZYNQ_BM_QSPI:
>   		snprintf(buf, DFU_ALT_BUF_LEN,
>   			 "sf 0:0=boot.bin raw 0 0x1500000;"
> @@ -191,6 +192,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   			 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
>   			 CONFIG_SYS_SPI_U_BOOT_OFFS);
>   		break;
> +#endif
>   	default:
>   		return;
>   	}

Applied.
M

