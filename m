Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4B5E6B277
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 13:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81D18928C;
	Fri,  1 Nov 2024 14:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iNTJActJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDFF88D9A; Fri,  1 Nov 2024 14:10:01 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E307988A4C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnBsJNLCSNTD3FheTMwVPePRmPVSnC0nJz6XRcU2+ulBxq2EN9+gtt2bCm4y31k6Oax2Wnkgct3CTPUZa/IBQbO1z6cyfqkJjzLsRjvuSBM3PCbVvvYpiKbdFmPd8gQjezNYfEVJC2xZ3XxOU+TMFui/sbvIMxkn+oQQWHzpd8mNSxuGTjy8leGimEA5Qc6riDzQY1sKgculMrGjvIyNs+jgIwEjcxjL35xFYqb3gMGN+DN24CIRJggoo58wHwtj9Bj7ahcCcOTASWnwwl7GR/ljI/IkEvJ89tVABMJ4AJrJROzrspOvLV6Mg+jWNcj3wrBHwLGiZbIQEUx4USXpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skrOoeDbq0ERuPGgMjgZ+B/nbC5HqzepnYGymXcDPfY=;
 b=umXxGYhFC5xxeM4Y/SXMGNmL8j7t6rRKLZG/YgGFvAQjI8rzB01i6xrHs3W/4ceDnCkOAiVnuXeyVdHd9dmlzdyHryhu5xdIDR5OXtWJRA9KgWT86YZdACwaTUWElOV5TYonJNT1w5mwkGBiz56vwPXwyDozCQ4Rl9sYUGptDdFMG3lfGhgKrq986lpthfjmZfk8zbgHlgkEYXKYH/4hcxFav37GipQjdTRJmdRHaQmhAMU1itEYyHSzXVVLvlBUyEBlgD3WjgzntDVPFvjaLT37UF6fO3W3XEhL3tVQS1XVhiXIUOfooadoqiU4FBWjNfHiBmqlCgCAj931QKOkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skrOoeDbq0ERuPGgMjgZ+B/nbC5HqzepnYGymXcDPfY=;
 b=iNTJActJLiWrgt5R6kwlX4V5OnR1CWKHg1a1Zfhpejj10ELiEdhGia9rPaJGxP4HuNDeFjkmUohXnPUsOEjMKFNSWFT0AgVN+4Qp+rFtWk0DMoy33dp6MurEUuAMLF/tmiC8FfsnLvHadowYcgODFqS6470VuICVnBAiMGHKuu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 13:09:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.035; Fri, 1 Nov 2024
 13:09:54 +0000
Message-ID: <178d29b0-d82c-4b18-a3ed-3d46dcc02446@amd.com>
Date: Fri, 1 Nov 2024 14:09:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
From: Michal Simek <michal.simek@amd.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com,
 Charlie Johnston <charlie.johnston@loftorbital.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
 <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
 <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 57835df7-76a9-43bb-15ff-08dcfa7679e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlFWWHBLQk9GZzFJbllZRUJJcld5aDdKZHJRMmRpTnZ5R2ZacEtzSTJ0UnZ2?=
 =?utf-8?B?OW4wbXF0L21Bck94YUJKZjFXSVB0YUFSbWprZmJBN3FOZFRaUWM2Z1NEQ0Rv?=
 =?utf-8?B?V0E5Kzl4Nis0em5nVlNSNmtOTkx1U2NlTStLNEp1RVVwbTFmTEdBMHBpY0Fa?=
 =?utf-8?B?S1hxaVpleHUrZHpZajdKK1psZ01UWG83aTV4Ryt3cWhsTG5EY2I2TldwMDR4?=
 =?utf-8?B?RG8ybDFzSmQzQndMamRlR0d0S3IxVGk2c2p1NTFyYzJ1OFpKdFNybkZ3MHNn?=
 =?utf-8?B?bDBLdTNTMFU3dEdLZFdZV1Y3cENMN2JFKzJqRmhSMHNtUU15SU95Rmc4cTVw?=
 =?utf-8?B?SHRLVHgxcGIwbkdZWDhSaDk0NGp0NXhUZlRkUEd3N0pwTmF5c1BaSjlCcmpE?=
 =?utf-8?B?ZVQ5aDZqaWdRbCtmSnBKQ3RmcmE4ckRxTy9DR05UWlJCNVhLdDRheHNNazNL?=
 =?utf-8?B?YTdrTERyWXU2MTZvcTI2VXcxaUh2V3liYy95bFRJMWdJdUJjeFlwanU1cFZ5?=
 =?utf-8?B?TUNJUzU0REJadzBBTVY0ZTY1RnVJUGZxTDhUNnJIdnZMR2lxU016Skt0cS8r?=
 =?utf-8?B?aXlDVTZIditIL0xZbTAwalV6Q3pTUnR4K0FOV2FLRjBRZTVJM0NrOVhZSFAr?=
 =?utf-8?B?Y0JhdG9QL0xMRHB3OUUrbUtnc29JMTJQM3lSMTRuY1dHY3hNUjFMWm1tSmp6?=
 =?utf-8?B?ZEpxcDBvby9kTDVjczE2MUdwT2k3SlQ1Y1cyRDFGNGF4dnZxNTREdUtUK1dy?=
 =?utf-8?B?Y3J6QVEzd2VrTUdtakppUnNwVWVOY3FmNTFNQ1ExUy8zYzhGMlVZdUVVN2hB?=
 =?utf-8?B?ckpZaWo0SXkxQWRSbWFOc1V6TXZmYUxlOU9qUWVHQ1VBcWNyMUtjVUtPOFNo?=
 =?utf-8?B?MGI2cDZxT2kwc3phUmVGSmlRdDhsUkdTVDlDTnY1SUxZcTl0MlNZdHRQeThM?=
 =?utf-8?B?Y3NnamV3REVaMkVWY1NRZDZnRzFMczNWL3JRSC8zVm1mRm02S216Tkt0NkVC?=
 =?utf-8?B?cjlubjVYRHRQRkFyZHUrKzJXQitBeE1IS0svOGFZdlNUWjBFTzFBL0UralU4?=
 =?utf-8?B?OFpwZE1xOS9BWHdDaWpQY01WUWY4WitkaDAzL0ZKUGUycHo5TkRWL0h4cjA1?=
 =?utf-8?B?VktlbkhHUGptQVRnZmMwWVhtVUw3TE9NR0ZBTmpYSkEvWDdSMVRaU1o0aWpM?=
 =?utf-8?B?N3V3U21zSEJJclBjZ1YzMDRnbkV5S1dRVDFJV0N6OTRpaFIyZEFkWGhkbmM4?=
 =?utf-8?B?TFZTS3BLUUUxVUorWXh6VTdBZkVMcVhiVlEvSlFZaE1iazJEeDBXcnpTODN1?=
 =?utf-8?B?b0VjMU16bStOcC81S2ZqTWxmUHNQMHZSQmRHZndRcy93dVFtck9pNW1xeHVC?=
 =?utf-8?B?bGFWbFdMWW8xOUo0N05TL2xzVkx4c3NhOElLMHBTRUI1dHlCdzRyYm1FM2Iz?=
 =?utf-8?B?Tk96QVNSZENwNHJlRDFhUzBtNjJ0VnZac2FsK1dsZG9MWXRzVVczNEFwZHo2?=
 =?utf-8?B?UUVSMHlsdlZQTWZOSHJYbU9pak1PeFNESjhDbTdhZk12V2xnUE1LVThMdUNj?=
 =?utf-8?B?UG1jeFJVMXBhbkFTNFBQMXhMam56NDlERlh6YjA5RlFzMk1KQWFMQjZ4MEhz?=
 =?utf-8?B?UitxOExLU2g2ZDJWUjNtQkFHcXphNDZ0MGU2UHRKSTNhVzNNT3UvZUZWcHJC?=
 =?utf-8?B?RTVqQWN5TXQwRDZKNHpKRWVtQ1B6Z2NWNFREbFlCR1N3TGZVZmVTMEZPMS9X?=
 =?utf-8?Q?2sCY64W3OcGhWr2ZleZWB1A17ty5Zoiljrse2qy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2tWSUZiMU9mVGc2MmsyTFJRT1o0aWVYemI5NEtpTnRldjdlZnROYytVUlhK?=
 =?utf-8?B?bTltSG5SZnFnazlDYkVEMkhmQkVaTU04K2JScWxsbE1XWEJUdHVSelh6d1pV?=
 =?utf-8?B?Z1lrNFBnUDZObERPTllDNzI2SkVqU3Y3MGNybE1YbStPUEcveld2RWdydXJz?=
 =?utf-8?B?SDI2SThwTm9ielEyTlkxbGI0SmR6UTNRdWh4Z3RKajBnY0pWVENVZjU3b0RY?=
 =?utf-8?B?QktxcWFmN0F1Mk1GRGVKMTFoVlA2MFM0SGdXV0wxOURGTFg3b0xSWk5jME1w?=
 =?utf-8?B?SzFUb2dXdHFYR2ZYV29ZWE1STmN3QmhVZVFyRHB0WDVGY1FzWGdFSTNZV2sz?=
 =?utf-8?B?OFFQNktHeWJrcnZzZXhEUXpMTHhta2dtWmNIdzRqR1kxNVpHMlRpYkZ0czhx?=
 =?utf-8?B?UHJOUjhyd3dZZHhBRTl0KzRsaU96bHpnMjEzUndUWWxQeForZ2l0TWo1OGNP?=
 =?utf-8?B?L3krcTVYLzN5a3dLd3ZaaFd5THh2alY3dS9yMGNSaEFHSUZMTzdXZHhuaXlM?=
 =?utf-8?B?L3B3NWlGd1BVaUhDUEdNRlF2ai9RR0RiT01zWmp1UlBYYjRJbm1paXFTbUpO?=
 =?utf-8?B?alQxMkpjVnMxVVRKWk9JRk5ZS3FmSHErQzM0Z2pZaWNsNUtxdDhJVEE2cFlB?=
 =?utf-8?B?MnUvSGpHMnBuZEFxKzZ6LzRxcUxNTnY0ZDJYa3B6NWdVM3cvK2wvT3hkVHU2?=
 =?utf-8?B?RGwrK0FhVW4xcVB4Z28yQ3hjNXYzeE5rdlpFQklkdjEvaFJ2ckhxY2VlU1hl?=
 =?utf-8?B?QTNiK3ZsM2cxYlpROUZTcDZmTkFxbUY3YURzZ0gvY0FQQ1IxQkx3V3VNNXhz?=
 =?utf-8?B?d2xHQU9iN2JkWWlZenVZYmwyekdwcUJmc1gvbTI1V0xRMUlNbjl2Y1VFelND?=
 =?utf-8?B?dEsxeTVuVlNVdVJ3eVprSTBOVTZ3WGs2MWJPVnVVMzJtVS94YzgzUHNieWpS?=
 =?utf-8?B?RFgwZi9CVUFGb0FUWlBoWVFiQWpRUUpZTnF5MlFQcEo5S1lVOXRoOW5uRzNM?=
 =?utf-8?B?blI2VlBzWXhSczlkV1MvRUhLWCtaWjdpQUVIcXREZU9NRXNvOUlPeEpKUG1X?=
 =?utf-8?B?SUdVUEQ0YVhZdkxoNWJITlMvTmRNVUF3KzkzTE5TaHNKdmtkeU91L00yTHVw?=
 =?utf-8?B?RTg3NmhMck9Mc3l1SDBuV3ZxSmw2VW1mMHdHUnpybTc2S0xWclRnVDh6R0Fj?=
 =?utf-8?B?Y054WC9vM2JWZEJuTWhQeHZTWWx6aWxyOW9zbEZWU3hWSEkxVXdlVXdQQUxI?=
 =?utf-8?B?ME5Bc1lPdE41V21KZlQxNGZSODN0THVrbGt6OWh1cWd5aVVnWWdhdFN4UXZN?=
 =?utf-8?B?UTk1WGkxMjRweVRFMGZxeGhSMGYrSzBpV3ptNHdBN1lGTlkvTGlYcVo3WCt4?=
 =?utf-8?B?cWU2amVYL29CRWtPcE5yaDlPbXpPb3d4Ykx5ZjQvTU51VEdObFNVVHBsY0R5?=
 =?utf-8?B?Zk9OTjNITHh4LzRQcnU1QklsVGlLQTlGenlIajNnU0VNSXF2Tjg2MWozczBF?=
 =?utf-8?B?d2tpbUdEQWFRTlBzdHdyMVJtQlZFckE3WlFiUDA1a2hHS0pneHNOUWg0WjZ0?=
 =?utf-8?B?cW5SYUFUNlpacG5tVEF4SGMrTHJaaUhCcHEzb1M2V29SRzhWc3lSUXZiZ2Z5?=
 =?utf-8?B?bmtNeG4wcTllMGpQckVHS2lTRDIrUExkQW0yYU5YK2UyeGMvN3NFUVdKN1U1?=
 =?utf-8?B?Q3FHZW52c1pJN3dXYnZVa3BWSDBFeGJVYjdqZm9KbGNFNlhkdXJMZnNBenpO?=
 =?utf-8?B?QW1HQTZCdURVMlVMK3hDTG54RjlrMWdoZ1Jackh2akRJa255SXZ6cDVwWFla?=
 =?utf-8?B?SDlDRGY0OUhXTkxpODk0VHhpbzZIdk80TDhvYXhsTVNFdHo0Mzk3TVVtVGJP?=
 =?utf-8?B?dHJVeFhST2EwcVJac1pXcVJQaG0zeEV0cWJoOUUydTZBL2hsRFVhQVZKQy9w?=
 =?utf-8?B?bDM2QTFpYVl1Slg3SHgzUVdxMUZvSnQrZExENWQ4RlQyUGthOThuamVkSHk1?=
 =?utf-8?B?WitiVnVzUjREREJxMDJ2bHhtbHF1Umg1ZGU0TGxHLzFhclBpTSszbmRLYUFS?=
 =?utf-8?B?bkNwTkNjME9yVnEyZk1UZzRFTkw1NDErS0V6d2xXS0I5SmtnMTg3V25tbU5n?=
 =?utf-8?Q?Jyegx8ESzBrd0wX4jBSkmmuVy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57835df7-76a9-43bb-15ff-08dcfa7679e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:09:54.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11zwJ6WUmM7zo2su4gtcZzFVCCXD0HSl0erSBQd5I5PMOHAk+g5FYK8xlhew8ysV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

On 11/1/24 09:27, Michal Simek wrote:
> 
> 
> On 10/31/24 19:03, Simon Glass wrote:
>> Hi Michal,
>>
>> On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrote:
>>>
>>> There is necessary to do some steps to compose boot images. These steps
>>> were in scripts in layers for a while. That's why introduce description via
>>> binman to simplify wiring and remove all scripting around.
>>> This should make sure that everybody is up2date with the latest versions.
>>>
>>> The first step is to create fit image with DTBs with descriptions in
>>> configuration node which is written as regular expression to match all SOM
>>> versions.
>>> Description is there for k24 and k26 in spite of low level psu_init
>>> configuration is different. The reason is that it goes to u-boot.itb image
>>> which is the same for k24 and k26.
>>> u-boot.itb is another image which is generated. It is normally generated
>>> via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
>>> be deprecated.
>>> FIT image by purpose is using 64bit addresses to have default option to
>>> move images to high DDR (above 4GB). TF-A and TEE are optional components
>>> but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
>>> by some configurations too.
>>>
>>> 3rd generated image is boot.bin with updated user field which contains
>>> version number. This image can be used with updated Image Selector
>>> which supports A/B update mechanisms with rollback protection.
>>>
>>> 4th image is image.bin which binary file which contains boot.bin and
>>> u-boot.itb together and can be programmed via origin Image Selector.
>>> This image can be also used for creating one capsule which contains both
>>> boot images (in SPL boot flow).
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> Currently I have this for testing purpose only to find missing bits and
>>> pieces in binman for cases I want to support.
>>>
>>> This patch depends on
>>> https://lore.kernel.org/r/ 
>>> fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
>>>
>>> ---
>>>   arch/arm/dts/Makefile                |   1 +
>>>   arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
>>>   arch/arm/mach-zynqmp/Kconfig         |  17 ++
>>>   configs/xilinx_zynqmp_kria_defconfig |   2 +
>>>   4 files changed, 244 insertions(+)
>>>   create mode 100644 arch/arm/dts/zynqmp-som-binman.dts
>>
>> I'm pleased to see this. My only suggestion is to use '/bits/ 64'
>> instead of the macros, for 64-bit values.
> 
> When I was playing with it some time ago it didn't work but it works now that's 
> why no issue with it.

One more thing on this one. I pretty much dislike that images are generated to 
u-boot root folder. Isn't there a way that they will be written to separate 
folder (deploy for example)?

Thanks,
Michal
