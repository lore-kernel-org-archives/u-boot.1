Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E88CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F0084711;
	Mon, 11 May 2026 09:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMjKjMON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BD284715; Mon, 11 May 2026 09:17:54 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEED846C1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8PYnbmA+FkHrPQKdzHJ4sN4knc6sQB9g8pTb5fkxikUb03k7wTtdby5Cz8uoCwpjkKJoAaOB4hUCTD+5PkXiII/B5TrXnA2rZFELpg/n5OnHUhdAgLIN+/lnFp62k7j2Wvux/JgcH6oJTyRjB7KYhZbufL25LZFxryv9aQqlXcdt1+JeGPtML7jZ+Lq6qPl/6bxltleYgxM2BrINB4J1J11dFM/U+IYVZ1kzaGhfbeszzEnqFvjUOaNOxU9MEaFgGK3nhftJkh9cv/B2UDk4wu3qkBs9XtTIJfQczZT33dpkjE403TsfY/g63K5d1IncZkKJfTbZXPjDFnAqvNJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jPsNEXzGgs0KdI1H3V1pp0YDTzsYjN5uPtu0ZlKvxM=;
 b=HQ2q2vB9PGuKLZiFlfrJDAa5IN7BQRQ+6LnUC87lkQu89yzsb7DF5OWbMGGodGsQUtUhwneAIniOAERAqSffu1ujhblUxIFeQf6TGVPeiGyx2fdT4TN5YfpnRexp/eM5JLI6/dwnyxHd2j6J7QpC61M1H9rOdGR8AlTtQXwgXhOXHTPzml0oKi0JYSsJw4u6LpXkmnigQb6NurTu+eZd1Z/fabGydQvYWjGSgkrjjEqpkkmGSqy/2mMcJSloRfy318FVffSdHhmqCSDVES8ECT/vCxhDkCLM2RkST8JBBp53osGeTxGX6orIcfZgwsy4S2YAfVZwF5euF11FOqnd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jPsNEXzGgs0KdI1H3V1pp0YDTzsYjN5uPtu0ZlKvxM=;
 b=EMjKjMONW6/KxUVFdWq4JSjalzasDSN2kAxufYoKg05F//WWQ80uhAMgvD8tairwM30G0PCrYWOJ04JZGIA7eWwLFgW+ierhB+fNQVlmsN22/IOcPbr8IeXiQtWC25j/9EGkSuSk7sQRtBMmEfmG6x3U2f6LYdADx76punytOD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:17:47 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:17:47 +0000
Message-ID: <299032f2-1af2-4c39-98a6-0bb74c8111a6@amd.com>
Date: Mon, 11 May 2026 09:17:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] zynqmp: Enable USB gadget download and remove
 hardcoded USB ethernet init
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20260430093427.1852145-1-pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260430093427.1852145-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f430714-f45d-4986-6fed-08deaf2d673a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: o0Ij5ysAmoqP8r+JUO3jdSeP1zIMLp9NS8llxd2tkPi9RdUX1Uh1oY6VZybbwiL58KEfop0xy/I4VNNzApZamOqGOY0xRWtARX1r9YIeaij2Sar4jAwJJvANd6YZIfdEWr38YDe7KvD9e44Wl5yAPxfDjd2sM/JTVUEq3knCTErAvLEZPwcZHJ7EOJlTVUQ9tHRwOIVlZOSiAQZ+ezUwDYbmUmdfITfaCNBNXZlVkv6Z3uoxusPTJum+By1j7wO4Siai92sZ1XIB5CjcEs/GMaJEUSOxePcMbMSV8FjV1ylh6QC/cBJivaIj7j6L8djK1BU+qZYCIGcTI9EtOa3FW6C/7DozESe1s706KcjCYxmwDUDE+mRvySohDKI33mQOS9TD0L0GEdMhUyODd+f2SETwMnIV2LCh5EIXyRmyPtZhGwjunT3cYRqAHP+nexvNNR963po5Po61l+aVVhtUUDIp1w9rnFHXd7HjCSX0bhhIeu8ULnvsykcJ8V7EzhNGsK6NiuEpeaXe56g5fDqpDSCCY39iy6lkeTmGnpJxV77OSv5eVjJ2Eu2/2XYfIW+8D1i5ISCWHUTIUTk4xGNbXIZCcs6iUgTpU8kwUBh0/JsT2CHTpu8awMwQ3LZet46ovHcLkzSqUc/88GnRHFK3sCC5Z4nMOG+Ha94X4ObX2andRxycvl4Q+KacsIp6KM65
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFoMEQrZzlXNmswVkZxZmRNL212bENadmlnWCs4RWVDVGpPdUtQQ3FpU2xn?=
 =?utf-8?B?eWtkOW1GSng4d1FaS3lKcFZxMWhBSjRqNW5pbFY2YUxDUVNZS0FLbGRTcTF3?=
 =?utf-8?B?RU5DNlhTU0dNbnN0MCswMXVsbWx3VjJDYWVUNWVwYmRGTmVKM1RtTXJRaGcy?=
 =?utf-8?B?T29kb1FlMXZNbFZMMW0vd2M4cFRFL3lKbDRtUDlHNlowdG1rMVVsR3phSEtI?=
 =?utf-8?B?VmorTzdTanFocXo5RE9JdGxTdW5VaTVMbEl2dmx2UldrZ2EwVzZqSm44V0Jm?=
 =?utf-8?B?TUtESnh6TTM2TzEycEVEWkQyaTdNNUE2MzY3NzVqVFlNbWNtMVpSS0ZpQjJm?=
 =?utf-8?B?ZnhCRVhKM0h0cFJkUHRKaiszMk1yQ2xBL3Qvek9lUC8xbVRTWThsaGN5M1hR?=
 =?utf-8?B?clBJb2RPWjdVUzFHODZvU2ZoclhMWExZV3hlb2FkZEtiYXp5OEQ1M0tJSXVC?=
 =?utf-8?B?bWhEdUFkRjZnMC91dkFIQVZqaEk0UkNLbE1EcjRPRDltYlZSTFc0bHpHeHVm?=
 =?utf-8?B?WVlXVlJYS05tekx0c2ppMDZvbGFTcTUwOHBOcUdjU3NpQW11SkFmWmNUd254?=
 =?utf-8?B?ZnRZbHIvSHQydjNEMW9FOHAxZXhBTFZuaWs1eWtEdmJzc2loQ04vanR4dVJZ?=
 =?utf-8?B?T0tUeE96dDMwdmVYRzg1MnJaT0RxRzVPeEVqb1VkdXRjSGpnNFJxN090UEda?=
 =?utf-8?B?Y1dYeWlRWitweGx0QkJpKy9UZDdkSTNqREUyd2JoVWsvOFUwQ2ljNHpVWWtu?=
 =?utf-8?B?Qms2eFdxdVZST3paS2UzU1R6UkU5RmI2ZElFQ2h0VElzU0N3VGpwWmllT2Qx?=
 =?utf-8?B?LzFsRHBzN3MzZ2V5WEhSU1lXQTRwVU9xbk92NDkxNGZMYStSeW9pWkdFNnk2?=
 =?utf-8?B?OEpvNTFwY0krSVBDalFPR3BuZG9iaE9OdTVBMUEwZWsyRjNmT0llMDRyUjRB?=
 =?utf-8?B?cFF5NGx4YTFvbm93cnVkK0NTRExxQ1RkcDBOOW5uRVkvREpab0hQY05uWFVp?=
 =?utf-8?B?ZHVFbWp1RnpiaS9ROGdqbWdaS0xsY3R0TXBkdVpNNUJaRk5RbDJSZm1YLzZW?=
 =?utf-8?B?RVZSeExRdEkvWHZIUGd2SEwwZ3EzcEtla2VicW9YMGp0NHVDcUNXRWE0L0ZH?=
 =?utf-8?B?R1JCS0RBcUFtQkpTWUphOVlsZHM3VDNhMXJoYk9uV255SzREakNvc29GNi94?=
 =?utf-8?B?QTA5OFN0Q3ozd2hiSkVMOEZSWXpZWHJsYWJ5UXFITXBoYysveUtFQXE4RmxI?=
 =?utf-8?B?R0VvUGRwWGZiY1N6MjhYS2tyUFdLMGFsZHFmZGhhbHRKVW9tcFBPTDVGWHVp?=
 =?utf-8?B?aWxaU3RTcnNCLytjQ3hhZ0g1VWs2dlJjQUJqOUxrUHZPQU94bXpmWnRaNkdl?=
 =?utf-8?B?bUw5cThGSlczaGUxdkh0Q2NnNlZrUmswbzhUbDFacXZqOHBaVVBMZDZxc29E?=
 =?utf-8?B?NlhIT2Q4Y3RUMGxtSVJzbXduVm5ZTllvRU95d3cvaWhhcFpHV3ZpTlpzRjBk?=
 =?utf-8?B?aXE1cXhrTUMzYXNBTFBpT2JQeUd1WDdPeXUvZHB0eVVua1pCVFZmWE1TTEdw?=
 =?utf-8?B?OTVUL3lpeVNOZ3FzM25FS2Yxa3pmb0FyYW5NN3Z0d2dsUiticVpyRDFRLzFa?=
 =?utf-8?B?ZVdTcDNpbXRxcEJsWnJCQzhtZzFhVzZVdzlINnRpN2tXbUgzSTlxd3FJS3Z3?=
 =?utf-8?B?UmhOVlhYb2xyZHFxMS9CQnVCajZOTEZ3VHZFMFgxT3czN0JmOTJCbUUwekU2?=
 =?utf-8?B?VlRKcndIQ3BlUWQ0YThXV20yWENCcENaZU1rSmFqSmM5dkVIVmk1aFJnSWhM?=
 =?utf-8?B?TGRWbWs5OUY5c05MQlFqNjhjdCszL3pFa040UC9jajF0SWR3TitlSXF2ZHMw?=
 =?utf-8?B?ZmdxZmNoblJISjZHNGRTTlh2YzhQSnNKb2EwQWtWNzhRbzJqbng0d0IrdTM0?=
 =?utf-8?B?aFVUTVlmeWc1dzlMZXorQUVER2NJOWpneS92dnFwQ3VmcHg3cHZNdzFyaDdY?=
 =?utf-8?B?TFM1UEFObHZ1ZE1QaGpsM0FJaFhDb09peENUbkZPZ2JLUDIzS1ZvQ1NZUHNO?=
 =?utf-8?B?a1RNdWFQall1aTI1SmVVMmNaSFdYbDlOajBya05GR2N3eHhpU0N6OUdXUTJD?=
 =?utf-8?B?SDNyeXczdzcxMHBJWUtpUUtmcXljNFRMS0NFYkhGNDVZaElxNlpzZmJEcU5p?=
 =?utf-8?B?V3UzNzFIenY5VUttNFBHQVdjSVBLQXNMVjF2elRucjJWVFppdHF2TVM4elBN?=
 =?utf-8?B?NFg4V3R3dmRCOFBmM1JSVFhOSDZuKys2eVV2U05uUFlrcGxTeitGVFdwcWQv?=
 =?utf-8?B?bkxDUXFNOGZjVitSL3N5UjJ4SlJoZWluRDJOUHZMa0lsbEZ0bXFBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f430714-f45d-4986-6fed-08deaf2d673a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:17:47.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLHugsoQHKhmH6GihJXOqWB/Xd/wvB4NWM8d4TaNAfug0eNzz1Z7tIbpI7ONblcn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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



On 4/30/26 11:34, Pranav Sanwal wrote:
> This series makes changes to the ZynqMP USB gadget
> configuration to enable USB gadget functionalities.
> 
> Pranav Sanwal (2):
>    configs: zynqmp: Enable USB gadget download support
>    board: zynqmp: Remove hardcoded USB ethernet initialization
> 
>   board/xilinx/zynqmp/zynqmp.c         | 4 ----
>   configs/xilinx_zynqmp_virt_defconfig | 1 +
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 

Applied.
M
