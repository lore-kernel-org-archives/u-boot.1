Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD72BD1038C
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 08:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED54840B0;
	Wed, 26 Nov 2025 09:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KXOSWJt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3942F840B0; Wed, 26 Nov 2025 09:19:29 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70BD84142
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFKU2wPcemFTqc6KYQJ6VwDpCh5bKNNhnyXVLihp31k560KjjSE9xnvAq2jexTp9SjYJDljNVp4LxK8s07LQOvv64eSV8hZmXjxaZnBd6kh2VjjlIf3m5VhNwjdhphYyJZn0jBCZTedTWeaChgvbaVQ/DjPo7akMTPYWSuVHAyMKPb76BJws+8lTezIvnMo32YkgEkGqOETsyRtV6GY5BN8U67okV6zdzSIT2WmeYVgPdnQC6wWUsG9LnhptB/I6jS6+v9KWPkzwDIMSMnwNWiTqgrBPYTJRNQc2vXnI5QMuHFbh793l1bO9JkDMBHC4cuy7zCYP1tmKLUyNrpVUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLiDaTtNYXcAPqEph/MdaATC5LIIapkz1lxeZgtqWG4=;
 b=ixAHHpXp+RcU8YLFSdoP/LHC6vILNkrJUC3Tk4POa/aPjGFSu5RB4epys6vRx0l1plbF1Oeu3zjrIRrw0SyKEv9XuiBNERVapwZranYzscAJx8zIO/MaUCjuDoehKzjGesACo34Mt+DxWQCc7oPYwJfMBNAan2vNS4WBBv6evudfUsUgJplB1zVGvJfYFWPwvvY1ERqki2f25MG2aDBvXiCXLats68xzrkY4ZZwsEK0DxmASaGGxLA7uiA+5sJqGtnh+SpasnLsAkaobAJBFwRiUImX8LfUtiIeq879lYJ5eBpuxVJvsTet/C/nn+qxGJrI2p7aaAmCj03HtlcRiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLiDaTtNYXcAPqEph/MdaATC5LIIapkz1lxeZgtqWG4=;
 b=KXOSWJt0HgWTnsda6KmxZqkbeMUIs3OEurK1+2ztrfFX9SE20/v4aRDwBqcOZyu6fj8g0mJH3mfNJoMkOcGBhaw4FTQvLxU9dV2tNRYwEcgJcOPaYQei++D4NBqv2W/Wudem5B2T3XGa9zjP73zOXp6bjMB3Wtm5z7K+kvca1Vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 26 Nov
 2025 08:19:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:19:22 +0000
Message-ID: <ca3f42ea-cb4c-4c7d-9077-2bdd1b521d9f@amd.com>
Date: Wed, 26 Nov 2025 09:19:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Retry FRU EEPROM read on timeout
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <9556d204c351d2dc40176a31dab11f789fd1cc7f.1763542221.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <9556d204c351d2dc40176a31dab11f789fd1cc7f.1763542221.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: c4de992f-0ea3-4684-170a-08de2cc4810d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlBkbTVTcVlBNGlQb3RNdUZNT0R6TEZoTCs3NCtCZmtaY1dNU0ZSQitjckVl?=
 =?utf-8?B?OGNLWU81Y29HejFHZnVKV3Y3dlBVTFQ3L3lWZVN2c3FkbC9GWlJOWkRpUzM1?=
 =?utf-8?B?ZWZIbmhwMHdzU3hxWHZNcjdsbEV3RjJKWWNtWFRCcDFVeTdJWm1OK1ZKZHpj?=
 =?utf-8?B?UEdUTDZEb1N0dEJSQkZubjl6aDFkTXlPUk9yMkErWmNUdkJhaXlEN3B3MTZB?=
 =?utf-8?B?Qk4rcmdvcEZPTHJUVGpuSFd1QTlyL01hWk9IdGUrNW85bEEyWC9EaElYQTNz?=
 =?utf-8?B?OFpOWDZiS0Ntd01UNG5ZUnlkRHJYOEw2bnE5Ukcxem1sQ3lGcWR0Q3B1WERC?=
 =?utf-8?B?LzhLZlVNVnQxNGQ1QzZ4dmlQTzcvR1dsRHR6b29kU2x2M3pkeVN0ZlowdC9X?=
 =?utf-8?B?TUp6QnlaaGFkZ0FvdXNwMSswVWsxb0NYZFhURlRmNkppdlk3MVpTeVJDbEow?=
 =?utf-8?B?N3lZWTFKS0JzcnpGNi9EK3B6RG5HRVVvWGpNdEU2MHFENXNwSlpBQW03bG9R?=
 =?utf-8?B?RUpaLzUwcElqa3hNYWExOEVxWUZOS2tZNFIrSmtzckt4Q2tSYkJNc21KSk95?=
 =?utf-8?B?ajVSRlBtRk5QS1BkbUpyS3c2R1VCRExrTjROUDByQm9XcmFwZkhTRU1HNkZD?=
 =?utf-8?B?eExXaHZjVDBEQkxvRUZBZGRZS3NYSWoyUmNjakVibm83cXREZDVEc2tMOVY3?=
 =?utf-8?B?TmNITkpIck50NVhmQWxYcXBTVERrRVBUSHluWVRRZW9US2p5N2ZWVkZkTFRW?=
 =?utf-8?B?NkdqcHpWek5hL3p6UmFnWnhyRzl0cnVMQ1NGOTE1MXY3OTI4YlVjVWVnbEt3?=
 =?utf-8?B?d3dxZDhFcWF1a1ZxYmppT2JLYSt2UHRHVk5FakJOU3ZUQi9tWTRoNXptQmJk?=
 =?utf-8?B?MWltdVUxT3EwcVdCU3VvTkpRelV2Sm5MVU03bjlBcUR6S1VLSGE2YU1vbHJk?=
 =?utf-8?B?eGIyS0dWS1I2dW5LM1BEMDdrMEttNkV3QzFIc1NvNkE0QUY0YlJodkNYaEJS?=
 =?utf-8?B?d0lWU1laSXJtY3FlUlRzdmc1SzlOT3VLV2E2Z1NJM3ZUMHo5U01FNGJERG9H?=
 =?utf-8?B?dzZUb0phOEt1UFkxaGJhQ2J4Vll4K0k3Z1RPTHJGUjlXSjVTN3ZIeS9oWHFJ?=
 =?utf-8?B?ZkNYZm9EWTNFenRyWXFMNFJrZHZqMm1JYmtQTmhzSmQya0VJN1ByNjN3UzFE?=
 =?utf-8?B?Wit6MnBHUWRBaklUd2NKVzZTMjNnc3g5U2JyalFQVmplQUZ0OXVtQUhCMFUy?=
 =?utf-8?B?blZRN3l4RVNkV0htTkVUVmxHVitsaHU3MDNCK3VRY2UxaUszdFFNYnNaWlhy?=
 =?utf-8?B?UDk5OU50NU9kT0lER00rb2pKRENmYzFkNEhLRlpSMmRzK0xsUnRjUFB3clhY?=
 =?utf-8?B?ZmZIWmhEQmdNZ1RmbjNZVXVWWC9DOEJkSEw0b0duUk5BaWQ2ZkoxaEIzZkNU?=
 =?utf-8?B?dGtsaGtkNzhmaElkSmxoVWcySk92YXNHdlpzMGxvM2VRYUhac1JvSUE4SHJj?=
 =?utf-8?B?K3ZySUgrSnNFTmlncVhLMTZuYlRqV3B1WlFqUnVLUU5aZU1oSE5zb0UyUDNL?=
 =?utf-8?B?TGQySDdQOGlyTE9waU5RSHlMUWphakhoTjV1LzYxZENRTDYxV0hqUjdmeDkr?=
 =?utf-8?B?d2owNWVRKzE0WnRwd2tkR21jZjlWc25nSHY4QzNMQWtjRnFXYnFxMU1DeXZV?=
 =?utf-8?B?aFJPby9mSm1rbThwL2F1SUlNVWl5dThlQ3p6RVVVSng4ZEM1c3FwVGhJL0gx?=
 =?utf-8?B?Vkw1dmdUdlhNamcyVmJTdmJtWHF5bHI5OW1SU0Z1RmdhSnZjdURZbTRHZUVl?=
 =?utf-8?B?UWlUOVhsWXlKbWZpa09lN0p6RktNTWdJWjVvUURITjhiclZlbUhyUWRPSzJ4?=
 =?utf-8?B?eDk0QVBZVDczb2lpeWdFeFluYjdQT0pKKzZhc003Z1kySEVVM0VQNmFwbDJt?=
 =?utf-8?Q?ODRFInhwSMFFYDnCRPL+zyhnD3c4luv9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFXYWZWSHBXSGExdkVxa2RXZkpWSjZSVGhXRkN3d2laSHQwaDNKMllmUzBO?=
 =?utf-8?B?Q3JlQnhNWFI2eDVWRmJKUVdhM2N3OUdFTXh5Rk5zWml4cXZGS3p6RldOTElV?=
 =?utf-8?B?YmdJUVd6eHRxMHFFcThhZ240bmxiUk5SQnY3U0ZXM3FDeW4xWTkxMHZwZXB5?=
 =?utf-8?B?aWxLSC91M0UwQVBmenpFY0x6Ym94ZEZWWlVJakpvZFY2UytYNmZSaFBnTk03?=
 =?utf-8?B?VThvczJnQ0ZHVHUwVHFuZXEyVU5zZ0hWT0lWT2FpQTIxenNhWVlRU3U3TXFE?=
 =?utf-8?B?cWx5MjRzYnF3VU0zK0RwSnFhczJqaW94bTZJZm5XclhDU2pYZGF6Z1BwYS8v?=
 =?utf-8?B?Qlh1TjFDM05WVVNvbHB0d1RYZnhUM0dab1pSSmp2RUZOOWg5ZC9zYWJycmc3?=
 =?utf-8?B?R3RRVkxVR1BpeFB0TEI2enZiaUpmOUNjY01ncGZWZ0FFOVp3ckF3NEFwQmJq?=
 =?utf-8?B?RW1Wc3ZPUVAzY3ZrVnYzRDNRT3ZsRE9HM1NLZWhHZnJsMU9zNUdUK0phYkRN?=
 =?utf-8?B?V1R6OWFsTmJ4MlQzaDBtYllVU0RHVDZRdzZTQ3FHeEFiSG1wTGwzU0g1bWZZ?=
 =?utf-8?B?L3MwZG9RT1lwODB1TnpPOVlGQVhVUXducmtvTDZMN2JpRXdna1MyaXFkbnRk?=
 =?utf-8?B?UkNTd0ZDUE1FUzE3T3Y3bGhnYTNoaWRjbE5TK3RvbkhzcnRvTnhBQjBZbVJk?=
 =?utf-8?B?d1VvUWlQbkZFRjB1RUQySHExN0ZseFhmVVI2QVptVTZ3OFNtck5QRFVjRzB5?=
 =?utf-8?B?aVFUaUhHcllzZjBNN0ZTRzAyTzc5ckVhQzQ5c0cvaExLVmRGQXRHV2tyNjE1?=
 =?utf-8?B?bVQrMnJtU1BKUlBwbkkwVTJEcTZUbFcxUXkzaG1UV2VKeDQvNFNmR3l1QzU4?=
 =?utf-8?B?WVFNY2NVQ3hleUZaeGJuN1RqRXFjNE5WL3hYY2JKRHQyNFJqVytNQXBHZ0RT?=
 =?utf-8?B?UkJ4aVg2ZTZYM3hsZ0w5ZEJRZHpXRitrc25qMmMrOTcyRXkzOExkOXdKcEs0?=
 =?utf-8?B?aTd4aVVJeU5uMkpVU2t5cjZYMEo3MEZxVG5LSEtxMVl1SmdSTElwOHZQTHp0?=
 =?utf-8?B?SHVHdjB2RDBsNVlwaStOYitSUDFMempVMkRxWnBqa1JENDcyZHI4dy85c2FE?=
 =?utf-8?B?YmlWdmVrOHFIbWhKSzl6bURUTnpGVk9mWStBUzJ4Ymg0T0hGSFF2ZWNwMTUz?=
 =?utf-8?B?ZGlyaU1QZnhHRGtoL1V6dkVLVkdoNWg3SVBlWDVJTE5nVXRrZk5Cais3Y2gw?=
 =?utf-8?B?WnRWczRUdCtoOTJJc3BHTWpTc3d6aFUzczBmVHdRTElrM1p0WHJ3S3VFNUo0?=
 =?utf-8?B?MTBPMS9HeWNtYkI2VGUwdVdBL2JFeFQ0MU5NancyZm5DSWJQeHYvVm04bEc0?=
 =?utf-8?B?TXUyaVlJVFZBL1B3SE5sWWVzZmdtb0lFMld2NEkzS25rb0xXZ3BzNnF2VHFZ?=
 =?utf-8?B?aWdJcDFnWDZ2V0pBUEcxdk5WcnlRd1JtQkNYNm1UbURmR0k5Vk02UFRvOVJI?=
 =?utf-8?B?WnRER1hYNmhueHh3Z05HaE0rRDJLL3c5bWd0YkJhKzFvQ3NwVXlaVXB3NVFE?=
 =?utf-8?B?d3NtZ3oxTUYwalhnODJ2Y2RCWTlDdEw3UDE1WEVCa1p2VHlBQmpJN0k2NlJ2?=
 =?utf-8?B?VFl5MFlGVzJXMS8xUVdwRWF3UTBBc1p4WUdGQnpNSzZpYW9WTmkya1RSUGxQ?=
 =?utf-8?B?WGJBdFRlT241cy9ZWVlYdG92eXo1MjByekszaDA4My9Rbkg4aFF4UDdtOCtq?=
 =?utf-8?B?dzdtM21uTVp1TURJSDZVMjZ0VEJEOG1RUy9JM3FJR1JPSkpvUU9PK2hMUzhz?=
 =?utf-8?B?UUxwbWhMTHBvMkZNSm1sTFdSQU5YbitCMk1NSGNtbkVaSG9kOHRYL2RYb25y?=
 =?utf-8?B?TVdCZ2hxejh5UENseHNsR2NlZUFTbk42b2oyM3d5Smw0WXArblY2YTI4dFNr?=
 =?utf-8?B?bFBBYVg1TVpsZ3ZSNDF1ZFE1REtPMUU2ME02STBoV3I2SnRXNmhSamhoYlBW?=
 =?utf-8?B?bDZtaWxsMnd5TlhJV3dsSjg5Q2dTd2dITkMwTUpGVmFMRTlrMnJQcTlEM3FP?=
 =?utf-8?B?OU52N2U0SytqYkhEa09Ca25CUkNzVVFPSGZ3NTJvSzROT0liYmlBR1A5ZmFj?=
 =?utf-8?Q?bRXSQG5NU2yNHZHaKqkHFaAEc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4de992f-0ea3-4684-170a-08de2cc4810d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:19:22.4540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfyaGWOwQpErM2j0L/V946N53sXMF+VnNTiQjUOwxuTMlG/ut5nJ+iiSXqJFIDx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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



On 11/19/25 09:50, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Wrap the dm_i2c_read() call is used for FRU EEPROM reads in a
> retry loop, attempting up to EEPROM_FRU_READ_RETRY times if a
> -ETIMEDOUT error is returned. The loop exits immediately on
> success or any error other than -ETIMEDOUT. This improves
> robustness against transient I2C timeouts during FRU detection
> and decoding.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/common/board.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 26facb6daeab..4735b6ab58d6 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -70,6 +70,8 @@ struct efi_capsule_update_info update_info = {
>   #define EEPROM_HDR_ETH_ALEN		ETH_ALEN
>   #define EEPROM_HDR_UUID_LEN		16
>   
> +#define EEPROM_FRU_READ_RETRY		5
> +
>   struct xilinx_board_description {
>   	u32 header;
>   	char manufacturer[EEPROM_HDR_MANUFACTURER_LEN + 1];
> @@ -207,8 +209,14 @@ static int xilinx_read_eeprom_fru(struct udevice *dev, char *name,
>   	debug("%s: I2C EEPROM read pass data at %p\n", __func__,
>   	      fru_content);
>   
> -	ret = dm_i2c_read(dev, 0, (uchar *)fru_content,
> -			  eeprom_size);
> +	i = 0;
> +	do {
> +		ret = dm_i2c_read(dev, 0, (uchar *)fru_content,
> +				  eeprom_size);
> +		if (!ret)
> +			break;
> +	} while (++i < EEPROM_FRU_READ_RETRY && ret == -ETIMEDOUT);
> +
>   	if (ret) {
>   		debug("%s: I2C EEPROM read failed\n", __func__);
>   		goto end;

Applied.
M
