Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2D6C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F08A4812D3;
	Fri, 25 Sep 2026 13:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZIflf3AQkjI0; Fri, 25 Sep 2026 13:54:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 32B94812D6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344457;
	b=WUMKRnlZDVadiRNxkYjhH0Y4vnOlkyPh9sNIYnTzFtriySlGCQRMaJA6JO3J/Cmh45Cs
	 IlblgLeS6p6PclB/l5qu5ossgKI3FbxXSZWEnpyLP6iddCOxxWhhD7sQVFOj6bSJn3peb
	 GqQifw3Ji13Nb/zgUhvTvrJbTGn494qouuJt1f4xPeFPMdDJ4uWnL2ON/aALnqT4ZQOt/
	 L030aYAeXQE9E/HTVrrrFiLc32/y4JLXJdmJfUlvD2ow8sbOaYNxq6ujPtxpnv0EYXr24
	 SrloFgnxsRB8vkdQy5clkHclmcWZUNW/eKQLkWg4/HpewzERfHNJYGx5MLGoTbKIJNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=flc89TQcwuuRFgfl+51fGVIYxZe/kb9dm8tqyE4jsKo=;
	b=lQKCNgjOwY8PWDuOPtCvvXnisVXlD1/NoD2TrUS25wUbSe7VkzOVCHEhjuUboQyyd/98
	 2WFiqOloWkaj2rff2qQBYi1rKbvgSUOK9/89QuW+HHBEvv10V1S9m4Rbq20nTaaUcJcH1
	 yJAigI95yuUeMItf41A6ByIsYSbNRJRYB50soLeWkRQDrUYnVy8/Oq7YOmbLorBdEaI39
	 zM83RSo32DIlq2YMxexW/YYIjcBdMViW/lj+ekIuAZuJmcDxacszt4nBryUmWuzJTn/0J
	 D0cCBiioo6Q1TzOOjOoUPrQdu71lalFkC1T8uRpVzuGxnr9G4JdmnyVb3HjXLc/M7Ew==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=btEWHAI9;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344457;
	bh=flc89TQcwuuRFgfl+51fGVIYxZe/kb9dm8tqyE4jsKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=myPoVmp+ElFxP7f+DPilrmTNj/+bWp+iaVIeMb+u4HhxfMcsHzUTv81ESxEvuA+rJ
	 jOyiXlmWNR3fJEY1AvqSRfS0MCTZv/iW65qGS3dukYSpzKw+UtpICQYg3L4y04ttA6
	 hbH1+4JJqko66cIj/Cj0VI2fFnxemfijdyj7npVK5W7rSsVcpfZ23Hd+cb54fNPkiY
	 r8q9K0EXwH1BGwiu3LnPY+HLIyV7I+E/Q1G1RZlBfmMK5PtkRh+RONk9BLhE6DeRP3
	 LCz+YzFHdVg5KVHxoZMamn3/EX1iB01fi1DbY+gneSkrwawXDPS/NXS3xNL6ruwJH0
	 GSYwW8rLX5Ssg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32B94812D6;
	Fri, 25 Sep 2026 13:54:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A13B32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F947812D6
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmTJlSJJzbIl for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:54:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CB6C812D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344455;
 b=FRTG6MRxQBiUCldZWd/fmWeARBYA+GI0FQqmKIIqIx4vmratSgRtO1Zw/fYbqaNq8Ir8
 Ap3HxM00sAZ7LvSjVLPYpdKAmNsFq8onYevg7rvYNKCMl+E67niG2QWwWF/xri9s9UL8C
 02uq+NpVaaNjczt5iDiYmMqdvuK+fK+zblKGo27DMH6iz7fULl0aTctSH700JpYLirJtm
 VEXHaz9e6q8pM7QXon9bj89wkMfsNXAC0Gw/d9srhLo6mthIYyMHCP5c3rRtKK9CimLcj
 1CsKZpP9Hsjxl6v+uIxMyiXdqJL9bqFRyDaaAR1xSjmuGeKhqoLmDosVM+L2uO+g6Hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344455;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=flc89TQcwuuRFgfl+51fGVIYxZe/kb9dm8tqyE4jsKo=;
 b=JQOFuFqDu6BbLutc8OR24iwTJfTHNNPtfBwm0gdeh8yn3EBtz1jbbdJHoX8kmZmMAXxF
 ARw4VUcz8JSg0DX8M0NSOgpd3L8a9kPV1a48x4/x8HDnTouBBmt6kOHqaErw7pAbxZoCa
 cCiKwGXx/7/eQ3UKQ2is8NZ2XUkJJKZeSOAXXIkt1Jgby9gCccj9jhD7UmDTQNoUQyYSx
 cMS3IJiE4SEsStlSGByYUVL9RsIuLlzEw/k/UJ+VOg0May5fVUiJHHNlgPMMM58wOfKUF
 w1ryNXW4MJtG8Sizf2YEjt53bqgUhDQo8jWdrQgbsL1JtRRFLJ6Gf3eUt+FKNkBAMcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=btEWHAI9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=btEWHAI9
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CB6C812D3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3/HpTplp2+ZMNqWYQA5dsytXt4JPFBsbggO0WYw46VnoHKRfGa4JqklHIhUyLrlgJrDZ+Has+Da6JTdo9Aa1jBVbjnnSSrYbtSNld9A0Cu6CMtGEnZFRTmpPM0J2o0PZ97k9A7ukuePMd3I78abIa8sKqr0Gl76zeob7meoXG4PSn2ebhAvakwZFNm3GICSMuoZcNDpKdam/wYj124Y/S7UxBdZFkRT/nzaM7tzlQPpyRSih1TejfZhqsiGcEnnnx+PrvBcSFO3YvcxQFVxSebrmrV4DF54Jz5IwRpEmvt5lsMImFUSZp5MV8JbqkvIP/rANben1d2AtnWWCuz4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flc89TQcwuuRFgfl+51fGVIYxZe/kb9dm8tqyE4jsKo=;
 b=QWPJ3HcAzLcwEnPctEuHwFfR0PrPMhVNDo/qioGo0JxZb2YCcinfY50CvXE8JsqveFdRcUK2q0jI11oZT60Eqs1eh5+ZHU7LtilJVFHN+NoOrZMtOkesRBEjfET1a9430037hu69Mqts0AB5e/MZN/ZNeEHesZmEd8nOUm8cKgkIEgVzb+wGRgJ0sAmurqDmUyvLBEoojYaZD/0hY8MNc8r3AgQy8+dyVxtU2DNk3o6r87GEz6vVwABb4vEgrGe1GQRArXla30jT+dvSJmbaUM4KZlGcj+hf4JmR0l2mzIYrFg+U08kLujvkxJe4QcH4UYgwgMhE7SLV1Z89QmOmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flc89TQcwuuRFgfl+51fGVIYxZe/kb9dm8tqyE4jsKo=;
 b=btEWHAI9zYFsma0BLHZdMKmSGiiVGAODhtSwIwAw+8QeQYRff2IKc1aIO36kqEQf4aBRWH/6ZF1Jb7REr90JVgjtnE3MqcDboJeLuea4BLvI50t++tNXgJRr7+wuNxLvhue/sz9Z40bt0lYqN4K729dohCUETWYTTuLKPJxI2gU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 13:54:09 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:54:09 +0000
Message-ID: <c19cc11b-b907-4312-b1ea-de39999493df@amd.com>
Date: Fri, 25 Sep 2026 15:53:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Fix heap buffer overflow in
 board_name_decode()
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, padmarao.begari@amd.com, sriramsriram@linux.microsoft.com,
 Tom Rini <trini@konsulko.com>
References: <20260917110330.3152816-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260917110330.3152816-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: b413e805-e993-41e2-e17e-08df1b0c7929
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3jJw+YUTkIEyUWhd5NwaVX4Fn3UVuWDlza3i1tFuibkwaQCO+HsMskgNgYB5m8+6PEglaVTL3h+kqvbQGevxwVilYNv2A4pVA0wn6kOHwYxYv2ImP4H6SLZZ4t8rUkf9P8KhzqVzqjA7uVk7s99Z/pqiXwE0+ygwAWwn8Sr+8CijOl7TlozlbMYu2fyyt037RLMrj6T33/+ye1Zi2JMh0Boy1Ntbk8Lqa0zTi+kNLbqJrs7pBwlRj5e68BwujeaFaNAWCobdWDDrIZ+4fYJGp4aal6ocR+fwFRCN2gfqzX5SBhzfegyEUIuzP2l8dZHggYzVl8wKpDjvikf0bUQaaUcFSbkAa25tmAP4b4CKrrRhubzxbz7jDzJ81gGVU3SnbXzfuNL805NG1XpmVEXrSdorTfOzFEE8Q2PyesRZjO4YnVuhPmxa+k4eDluWlMnhOUEgY+rIVtCLoHSV/DUCVhdSAIf2P3NghfnKYg1hW0Nr+ZV+9m/umSwJZL43UdiI5i3EauE+5EVvx8b7Vi6ZcT0qy6WAee3R36MnPfSOee0b1oVELXpcneztlSs1zn2SMfkOFtgQpZGWbS8NvQfFBlku+vEfxWBYS6yIkWXphbQVdRd1TktL3sAoPBYSY+cJZ0Y0fLXDs4+UysncTXsB7YD/HAL0SoCQXXIn9n0b6DQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGY4cWhlbmNEUTRwSnYweVRLK0N2WDdwRUNxVEMzYWordW1RVnkwZkRUenZy?=
 =?utf-8?B?VGM0WStGUUZSVURJclJMaWdtQVVJWEVRVnZINmgvSmE5VnVacG0veW9tcU1U?=
 =?utf-8?B?WmVBcWlEU0xYL0ZyNTRSazVidjFEMUdaRzh4MjF6V1RGQjY1YytGSXJRUjhH?=
 =?utf-8?B?MXpXRGJGNjZaaDd3YW43VlFCeStqbFgxbGg3SEk4T3dHYkJ4bkVyck9jcHRt?=
 =?utf-8?B?aTlKd0VFczdYMWxCdjg4emJjelBtRHdIVm05NzgxV2xiYWQzZzg0SkZ1L3Rn?=
 =?utf-8?B?VGo3ZGdsY0hlYzJYWkwrRzN2dklXbmdCL0J2OHZjZHRnVkx3RW9SUzU4aC9k?=
 =?utf-8?B?N2pLQzlON1NWRXhwMGwzR1hHUGs2andBL3A3eXViaDlscndYTFpEMWVCK2o3?=
 =?utf-8?B?SGo0emd6em1JQjdRa2oxVzFYYU9pL2M1Z2JnYkw1SDhOYThwb1J6R0JyRXZi?=
 =?utf-8?B?RzluRUxGeXJzVWhlNjJMUHU5WUM1a2xQRmVlQ0wzWHFvS0NuRXZ0aS9ob216?=
 =?utf-8?B?MnJOcmpyT3p0QlMvWFZIYnNhc2VGakFFME03MGxqbW5RTHJoWnFIcmJJUDVD?=
 =?utf-8?B?SkNmcEN5TWdUbEx5SXpDbEhkODY5ejUwNk1UelAxbnpPOUpvZjZZVzZlMUky?=
 =?utf-8?B?RW1kdFRjdmxVeHZxVFcwN2lrR0xQTGpXSXAxV29Gem83dVB6M2lkWWlMSFVU?=
 =?utf-8?B?dlIzcVN2YTlOTklzdmNzVWlxT1NsVm1rMVFzcjZhMlZVeUdOUnIvQU1MaG1Z?=
 =?utf-8?B?b0RwWmtiNy9kSmJjUWxzakcxSTJ6dDVqNG1COGlVM2FHRDBJdmxCMDNjM1dQ?=
 =?utf-8?B?NjJzdGQ1WkZKSDIvK2ppQlFFb0FCazNGSWp4ZDdseklYZ2pJTWhIYXJxbXha?=
 =?utf-8?B?UFYwaHhPejZFWWh3T3doZkpoeVJJSlVLZVhJak9maEtoOWpxOXZFaTZieFE1?=
 =?utf-8?B?a1ZqenZpRHZDZHdCSGl6Y0hSdWswNGNsN1NncjduRlZac3dBMWJoNnpUeWE0?=
 =?utf-8?B?bjZXY2VUOWsxKy9Id2RzeFhQanA0b0JQOWVWclY2Rll4N1BZZXBnRG1pK2hs?=
 =?utf-8?B?T3BJUWlHN1N4QjR1QUd1RDFiRW9MWDR0Q2kvV3lZTXZ3QmNkWVFlMlQ3M29w?=
 =?utf-8?B?ei9rZzErMG9kTG1lUGV0ZzE3RDdzN3lacGd4b2Ntc1hERXBXTXF6cVRkYWRK?=
 =?utf-8?B?Q0tPVU1BSlgrVHZxcDYzMFlNYTZzam9kOGhZV0diTlNmY1JmN1ZaeHNhWUZj?=
 =?utf-8?B?N3NlR1ZSdFpwMTFZZjJmMjBzdW4vRkl1THY0dllKZlhWRGRKdzV2andvODNy?=
 =?utf-8?B?S2cvZzVCVkpkRGFjYWZjY0xvd0JFZUQrRzBxemVGRVRHdkI2cmo2QjhLWXor?=
 =?utf-8?B?KzZnWG11cmlxRW1OdkQ2dFdMdUd0cG8vcWJpLzRjVkt6VGY3ejlReU1GNUpa?=
 =?utf-8?B?M3ZYeVlVVGdPRzRFZXEvNFZLSG9QQkRiQnZtVDQrMXpQTml2MkUrSjBRdGE5?=
 =?utf-8?B?NU5mS1dJMUE5OFFJTGNiUFh6VTlJSVVlZjZ3K2Z6aVVwNjZkL1Y3WGM1NDdm?=
 =?utf-8?B?UFpRSTZTRTJWZ3g3VkN3VlB2aFI1eGwwS0RtTXJ6TUpFemFmNmNQZ3dqdjls?=
 =?utf-8?B?d1A0VVdsakcrQ1h6elJJY1luYkpLNFlZSUVhdi9NejBwaXBOVDAvZXhIaWdn?=
 =?utf-8?B?cUNzZ0Y0Uy9mYlRWNmxLUE5STHRHcmdEcGFvcHJ2aDlpS1pJdU1SZUl2VkVI?=
 =?utf-8?B?bVd4VlhJZWVFZlI3WEUxZ2NRa2pXOEY1bWc2Ni9WVGFPUHhUd0hwaUxRdjRh?=
 =?utf-8?B?UFlOS2svblVPMWVOQjJ4dmdUODdZRVF1OE0xVWFmZEQzYitsb0V2UXVsWFIy?=
 =?utf-8?B?Y2h3bjQybE9tMW9VTG4vMmUvZGVHK1N1VWRldHZzaUZwaHdZZEYyOG5tOWwv?=
 =?utf-8?B?Z2hka1JxNWJTeThJblVFU2J4OEliMWpQWTdjNEdvM1lOVjlEblNUTXdsRHQ0?=
 =?utf-8?B?amVaSUUvTkdzNGFKSVgrTVBzRFZQN1R5ZzZEWHYrWHpRNE9vS0pvd2tOcnB6?=
 =?utf-8?B?V0doYlhWN2ZSblFqUFZBbWUrTjVkV2pTTHd1dVdzVG10SmN0clVCYkhSNXhM?=
 =?utf-8?B?ZmVueHF3bkZ3bkVFajJpdCt1MnJwOXdsbVVGTStiTXJMc0hjck5LKzEramdh?=
 =?utf-8?B?N1hWV1RnZlpEYm9NcFFINDVzRjhIWklTR1h4cXF2Wjg1SDh4MHpOY0VyNXI3?=
 =?utf-8?B?N0FRZjNLdU03TERSdGhNMFg5OGVCTThJaUMxZSt0NFlBMkJkRDQ0OFc1b0lR?=
 =?utf-8?B?QTJkL3pPN1h1Ty9xK1kwcG50MW1NUlVCM1hZYUlrWmlrcDRTSTNtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b413e805-e993-41e2-e17e-08df1b0c7929
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:54:09.6909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgUJSxXxVgVq4joqcZ+2OxgZKiaHkYzwVc2+l0rIYxfoe0gWAGNpthIJXQQP52cn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 9/17/26 13:02, Pranav Tilak wrote:
> board_name_decode() builds the board name by repeatedly appending
> to a fixed MAX_NAME_LENGTH (50-byte) buffer with strcat(), and only
> checks for overflow once, after the entire loop over all detected
> nvmemX EEPROM devices has completed. If enough devices are present
> and their name/revision fields are long enough, strcat() can write
> past the end of the buffer before the overflow check is reached,
> resulting in heap memory corruption.
> 
> Fix this by using strlcat() instead, which bounds every write to
> the destination buffer size and prevents overrunning the allocation.
> Use its return value to detect truncation during board name
> construction instead of relying on a single length check after all
> EEPROM devices have been processed.
> 
> Fixes: 52ff1626cf4c ("xilinx: common: Enabling generic function for DT reselection")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   board/xilinx/common/board.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index f45b879736e..503d2da0d03 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -569,8 +569,9 @@ int __maybe_unused board_fit_config_name_match(const char *name)
>   
>   char * __maybe_unused __weak board_name_decode(void)
>   {
> -	char *board_local_name;
>   	struct xilinx_board_description *desc;
> +	char *board_local_name;
> +	size_t len = 0;
>   	int i, id;
>   
>   	board_local_name = calloc(1, MAX_NAME_LENGTH);
> @@ -590,39 +591,36 @@ char * __maybe_unused __weak board_name_decode(void)
>   
>   		/* The first string should be soc name */
>   		if (!id)
> -			strcat(board_local_name, CONFIG_SYS_BOARD);
> +			len = strlcat(board_local_name, CONFIG_SYS_BOARD, MAX_NAME_LENGTH);
>   
>   		/*
>   		 * For two purpose here:
>   		 * soc_name- eg: zynqmp-
>   		 * and between base board and CC eg: ..revA-sck...
>   		 */
> -		strcat(board_local_name, "-");
> +		len = strlcat(board_local_name, "-", MAX_NAME_LENGTH);
>   
>   		if (desc->name[0]) {
>   			/* For DT composition name needs to be lowercase */
>   			for (i = 0; i < sizeof(desc->name); i++)
>   				desc->name[i] = tolower(desc->name[i]);
>   
> -			strcat(board_local_name, desc->name);
> +			len = strlcat(board_local_name, desc->name, MAX_NAME_LENGTH);
>   		}
>   		if (desc->revision[0]) {
> -			strcat(board_local_name, "-rev");
> +			len = strlcat(board_local_name, "-rev", MAX_NAME_LENGTH);
>   
>   			/* And revision needs to be uppercase */
>   			for (i = 0; i < sizeof(desc->revision); i++)
>   				desc->revision[i] = toupper(desc->revision[i]);
>   
> -			strcat(board_local_name, desc->revision);
> +			len = strlcat(board_local_name, desc->revision, MAX_NAME_LENGTH);
>   		}
> -	}
>   
> -	/*
> -	 * Longer strings will end up with buffer overflow and potential
> -	 * attacks that's why check it
> -	 */
> -	if (strlen(board_local_name) >= MAX_NAME_LENGTH)
> -		panic("Board name can't be determined\n");
> +		/* Reject truncated board names. */
> +		if (len >= MAX_NAME_LENGTH)
> +			panic("Board name can't be determined\n");
> +	}
>   
>   	if (strlen(board_local_name))
>   		return board_local_name;

Applied.
M
