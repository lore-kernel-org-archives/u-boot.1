Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C95CC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 08:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D65E884FE;
	Wed,  3 Jul 2024 10:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="tg/UQ9K4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4365D88585; Wed,  3 Jul 2024 10:29:11 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230D7883F6
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 10:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUVjvPAvgDOEMEf7YnI+i9L5zbdG6rnWI5mhH+Ajbj0MUWnxqXXBQ0ekD/jHlHiHkU1TAV/ZOhkqqxHZdDFjt/QIxr8c+dVmwz0x1euhQGnZCrveHosCcjPo3dxjKEftHvgFUJJYvJd+dlRfKQxNfv94fLC4Z2U+q+Ok20MBRopmU9DlCSX2wgmMblW8UkXqyoLNqXkKYheynDItFoUkEntU2aADsGJUQDUY/P+RaMLQnZqSN0DyEsi8YHgOrNMb5is3BCxYlaqX8pIS4ed1pAC8Ymx3f/ME1Pu6x5povfXRmvBuvHaNQrYARXs668LqoycMVHJfSi7hHEJtAZlxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9QdiD99c4UgDKRJrGae5bbflzo4CYVCR1UXdqFSnIM=;
 b=Cc2bjy7bBlNK5nBiQAQw7awRsFupSzU3VofGd72ucHfjt5gJFbNTadgIkjX6W/ak8gtDA8aiYe+qODh3L5RKyhaUb2K5lxSzcndLpTkSThPb0nSvjgvP/mEnHlzS3kw+RQPJzpVGF14shHAGyhs7VG7Nzbm1ROKyEkmTKr4jIFEGaQ8IZXRmo0CstrDog8ykomjp3Bj1v7mDmj6xPkdNQ5sk0CVsS1iz+gh4qJub5qLYxZrADHfDwg1pcrYU6vxE256MTrxaUHBDgk835f8uK2TXpA3Pt/62YSrlZ/WxySrmfU8zYqFQPHZJzRMJE47GPmNbfdDUfRftiEAy2NHO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9QdiD99c4UgDKRJrGae5bbflzo4CYVCR1UXdqFSnIM=;
 b=tg/UQ9K4HkUupgNVT9Ho4gEKBQ76ljJpL21bn7o3De1XBtzCNPba192QrdjMgLMJ+Aot5f0IXSVey+nM18UGcu+y6zEBxbTjzWcBZ5MtKnJfzZceJbFYupfH1bc4wld/ax0KtZ8vafBqQbpMrMEu+fwWqZ+BqH2nVeMs49M7zp1dWet8ZDOEddgEmlu9DXGww4Cg0QjL1dQYlhITwlpMeEZkRACdHIjuG5OtfNJvcAucga9qOYX7+fuyC+z1C7WjNLZR6n9fpr/Z2MnqgDcxjcFuqXIRaV3tcf9Ef5ex5/C2ENkGkbKVlgTW0jUEbM5gDNnx8oTyMlkelQJpSlBMqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB8118.eurprd08.prod.outlook.com (2603:10a6:20b:58a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 08:29:06 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%2]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 08:29:06 +0000
Message-ID: <439e1da1-89b1-4bcb-ac43-3f8816c395de@weidmueller.com>
Date: Wed, 3 Jul 2024 10:29:05 +0200
User-Agent: Mozilla Thunderbird
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
Subject: Re: [PATCH 0/2] Import environment variables from FIT configuration
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>, Joshua Watt
 <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
 <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
 <6dc671c5-2f2e-4cd9-817b-5aa50e5a4232@weidmueller.com>
 <7687e15d-c601-4f91-b07f-a4f9d5114362@cherry.de>
 <4ae22738-3292-4c03-902e-4a7aa4b45cca@weidmueller.com>
 <fc0efc26-35ff-4e43-9a73-5e63391448d3@cherry.de>
In-Reply-To: <fc0efc26-35ff-4e43-9a73-5e63391448d3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bedaec-22b5-4695-71f9-08dc9b3a3439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnhZVElaZW0vZWxRdFNUdUZPWFRnSTgvYndEbk44amF2SktMQ2hETmE3bGpS?=
 =?utf-8?B?UVZzeHJITi85ZytFVjVMZERNS0hSU0l0QmJaUnRWOHhmVVp6MFBuMWFKTWN3?=
 =?utf-8?B?NDFqWjB0RGsrMTNhOTlVaW9kVWdDOWhiTjZvNzVuNTBIbG52di9HRGZNZXR5?=
 =?utf-8?B?TXVkZ0xhWmNkekpwTFA4Q0lxVEdvSVNLZmhUcjdLa0FVMElzMU80dG9wNzVS?=
 =?utf-8?B?MVNIZDQ4ZXk3dFh2TXdXRzljTkpSajcycUduaVF2UlFzVkZqeDhIRnZJMGpk?=
 =?utf-8?B?QTJjK1lIV1pWWWQya3FJdExnOG04Z3IrMUkvRjNJVmlDSmM4TEptOERmUFov?=
 =?utf-8?B?QzYranl0U0R4ZHJOZGwzcmFnalNHalFYeTJiemVza0NjQlRCSHZFUzl5MVlE?=
 =?utf-8?B?dEdnYjRwWXgyT0VmWGhTNmZWaGRVcjJtNDNOd0lMbEpnWnVIY2ZVbU1vYUI5?=
 =?utf-8?B?bTZwdVduU0xVTm0vekZacGpMQVlvblBZeE5wMDFicGxhRzYvdk15VEVvQzZ1?=
 =?utf-8?B?ZGJmTWpqWmVlTG1vM0dHKy9IUk15NVdSSlMrYjU4YUxIOHRoakYrRHpMTlh0?=
 =?utf-8?B?L1NnMXU2eTh0a2pWY0dOWWJtWjNJQk1ZdktSVTBuSjVWeDFjb3pQVmdKdGIy?=
 =?utf-8?B?TVBkODM4OTFoM05XeHE0c1l5WVBmNEtJUHE1QWJSeFNyTnRzTUFNY2xhamNV?=
 =?utf-8?B?em5RcitVeU9jT3VrcmJkSUNUcno0NVVBQjNwRjdEb0tkVDdPNkRDK3ZWSWRn?=
 =?utf-8?B?Yjk4Z0QwWHJKL1ZMa1RoQWQxWUJRdGFiTVl1UGRQZURxT3k4Q0NOclJnR0tL?=
 =?utf-8?B?WURXWUFwYWFQVHMrMGVSdjBaUW1RQkc5QnJETE5KbFJGN0NkR2pBdHZpZ25r?=
 =?utf-8?B?U1N3ZEpza3NZYXlEK3RGZlFySVErWGlxbzJSeEQwZFhkOGJ4dExtMDkyTVBz?=
 =?utf-8?B?c05hdEZ5RHM4SEQxbllFbnc0NW9CNTA2cHJHeTBQZGxBR2FZK0t5R3J5U0dv?=
 =?utf-8?B?blRvRHZXTFJab0JUZnNIR0NjWFVVeUxmMnJ6U3ZVSTRhcGZpclR6bzFOVDZw?=
 =?utf-8?B?b3ZmaUZKZXpWa2E2azk5ZmVObHduUDkvQ09mL01CSC9uVHhzSUwzc1g5WHdx?=
 =?utf-8?B?SDU0YS8rWWd6c0dYT0pPazhtZmhQOC8rbFhvM3dSYzBLbXZqRXZOdmlmUEoz?=
 =?utf-8?B?VlBXb2Q4em8xQ00wdzdCa2lxT0MyUk1wdW9yc0R1LytRSGhiQVZtUTgyV21L?=
 =?utf-8?B?RVp4SEIxcVJMV1ByRjJYSmcxYTZGbHNTUkl2U3JmWGdjdVZqcUZ1Ym9md2pa?=
 =?utf-8?B?VjJIWXpoMmhyWjRlelJTUTJRNW4rZzZTSzM1dm1VZVlFZkNsY0JFeW5vTEU5?=
 =?utf-8?B?dStaY2FPL3RSZFFkWmdqOU5tclhaMDVtS0N5VERGdm1KVlRrMkNRZFVXbkV3?=
 =?utf-8?B?czRQNVNuaUxuazBYR0RYSkhHRGlHazVXNG5YaVkxcWwxUjVMallQU1dTeXdr?=
 =?utf-8?B?cDRpa0lYYmc2TSswYk1pTUpJbVo5Y1VYblZqZzNHQTZ4L1NFQ3BIYzFoZmx1?=
 =?utf-8?B?dHdwVU5FN3dTVVkxTFIzK1NLMEVocm9ZSkduaUJuRzlIcTVhSnMrYnF3MU1G?=
 =?utf-8?B?ZE1zTnI3Q0oxUkt3MS9GbWpSVEhMVXVlcm9LY0tjb1R1TjJuV1Q0OFgxejZ6?=
 =?utf-8?B?dlNoSHNJQ0x0SzFOck5md0paNlhYUHlHVXQvN2YrcWhHeHBoT2tRLzVNRE92?=
 =?utf-8?B?M3NDYlZSVWtiemdPQTdKYUsyNi9aTWRVNWFoR0xsNlZCSGRsMjRtYlJIemox?=
 =?utf-8?B?WlJSbFNMLzZidUttRU9zUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNEWDBBMjd4SDdya3JlM0d6dmxiZGtCY2tseGtEVUU5UVNOekJxS08xbGZL?=
 =?utf-8?B?OVlmQVl1Z0hQbno0RVRvejVtRkVYM0dhR0xuRmxacDVZYjRwTjZoTmZKRlBs?=
 =?utf-8?B?aVYzWG93MHNvL3JkWDU3bkt0WCtjSEhLV0wyQjFlOEVRLy92RXVCUCtnbk9v?=
 =?utf-8?B?cWM2RDRCcjZ4aGVOb3JRL1BZQ25HNHd2bFIvMnBuSzRuN0YrNnRtdmYvWFFW?=
 =?utf-8?B?RzdvVnRaQmQvYU5DQ01hU2xEejBaSHF4N1UralRDanFWR1pIa3N2OVNrSXEz?=
 =?utf-8?B?RU11WS8zZHg0YmYrSzBUalAvOXdSc2xKa1p1T2tVMk5OQzBZMWZhTVVKZVh3?=
 =?utf-8?B?a1ovR2RDa3AvYU1lL3BQNmMwYXcweUo1WCs3OHRsVThTTWdFN3JGOUhPeVdJ?=
 =?utf-8?B?L0dURTQvQkx3Ykx5NHZFUE5PNkRMdGFSSmo2ZUI5MWJ5MzNseHIweEgvZFlZ?=
 =?utf-8?B?VzlMaG54ellRbmh4Q2FldmxXM2tMNWRaemR1YW5SNDBqbFJZUVVrVHJIcitr?=
 =?utf-8?B?QmZwQnZCYWN2cGJJemNaR2lnQStKRHBObWMrbTUzTTJ3WGlXVEVJOWlpZHhO?=
 =?utf-8?B?YmluRXVIeExjb0tWMGVzd2JHdEtLcnFvbm9DNEhrUXludDRHcnR5Nlk0ZGRy?=
 =?utf-8?B?QTZubmE5bmk1T0k4NG9EbzlpM0lZZVkrRUtoM0gwKzFSSE1QTEZVN3loMSts?=
 =?utf-8?B?cXNwL2pCOXZzbVcrdTlxVmRJTUNxaXM4SzRMSHlrZVdoRWN0ZElLeWJkaGFu?=
 =?utf-8?B?U05pRFZSZXlqV2xGY25nS0hDMlVwVzg3K21XTnRaa29xYm5SbUkyS2YyTS9L?=
 =?utf-8?B?MFluQ0xRRDFheFRPblpteXpxb2JKd2xDYS9JZG5qYnhvRWdPYS9Oc1FqdU1P?=
 =?utf-8?B?ZnZsdHJLM1dLdis1RGtSMVNQWGF2ZjlMTmZzR2IyUTMzakFoc1c5V3lxVFQy?=
 =?utf-8?B?TXlZQlBRa0ZVYmFDbkxNcTM0Q2FGenBXaXVyOVNrMnVyM3Y0NE5xakgvY3Br?=
 =?utf-8?B?MkMvcVdsbm5YVTd2aVZoUklaK0NRb2ZaVndIcGFPZ2dZRklQY3RqNU9NUjJF?=
 =?utf-8?B?eU85eVI0UWF3VlJ5NzhTWkg5OS96dEVPd1hjV2lkdmlBRENVaDdzZVhBcjN5?=
 =?utf-8?B?Tm9meENJYlkrRTVFQjEvQy9USmJHc3NWaHkwWjZNS2RuOHYyMGpldW5IR2RC?=
 =?utf-8?B?a0NTOHRObTJZSVllUVB2dHk3VGNiWGZrbGZIUWNxa0cwZDU4ZWF1SkxKQ1Q4?=
 =?utf-8?B?clBscmxkZEszclVwdzRDT0JGQ1pUQ0MzNU1ZMXYxeVBJUUR1U20yb2Jqc2ph?=
 =?utf-8?B?bmcvdHdZTVlUZmUrRWJZOERwYW9EbEdxRUw0Nzc2ZHR1eG5JZWFnblRxZzIx?=
 =?utf-8?B?MzhHMjlXdVQyb3UzdWZSMGpnZi8xZEVic3JoMEpXUGJaMEJROTRwOFdPa0ZM?=
 =?utf-8?B?NFgwUU5xUkdrb3daQmxydWs3MDAwRC9mNVFocHhUcUUrM1A5WFNSUWNISDZW?=
 =?utf-8?B?YU1tb0kvenNKUXduQ2R3REJ1ZFAyWnF5UlRmT2R2dmYydVk5SzBOckJmRHc4?=
 =?utf-8?B?eXBQRTQ4UnlmdkpleU1DV1JNbnYzUTliZGJPblpRQzJMSlZPWGJkTlRjRmRs?=
 =?utf-8?B?aWpvdnM0MmRKUmExZmY0QWV0QmpOWkZyUXFwK0w3cks2VEk2TVpaWGFOeExz?=
 =?utf-8?B?VEpmdjREY3VtZGo1cWpsWGFnRU9mY2hoMFhUa1hQSmttQm0yVFo2RC9JWjNY?=
 =?utf-8?B?KzZjR3pIc0tNRGVLOUhJQXY3ckg5bnR2b1VOb1lFbTFGMGZQOHBxK1ZSQytv?=
 =?utf-8?B?c1ZZMzZTTUNFcGdQRkpFL2JmYktuN2JER2hIUWR4M3V6S1JoM2xTamxGTkRY?=
 =?utf-8?B?U3BpZlltdGl0dzJqd2NsRGlFZnpySUc2cUdTekFnSjQvL3p0eDZCb2xFU2hi?=
 =?utf-8?B?MmNwWlhPODkxREZvN1FMa2NPbmpFcU81bTUvOVVJeVBlcTZBdnZZZ2RGNG9o?=
 =?utf-8?B?M0ZMTENPVkpvN3kzWmVITXArZUtwZS9lY09tZjNHVlN0dWVKVGpTdjhsSEpp?=
 =?utf-8?B?ZzRhbnp2N25DQzJ1VzcxYzB3WlpIUy9sbExPb1hhcTZ5ZFE1YW5PMmFodmFw?=
 =?utf-8?B?WHBtZ081dXFqWmZlNkJabWZMbVVaV1pTQkFWREdYRm1BNjErU0ZSa0tKck0z?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bedaec-22b5-4695-71f9-08dc9b3a3439
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 08:29:06.7231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFbjzEfx8XymYdspWOql7B/zcGR8JzsVM+HVhOYoaZ6yHBgn6F4Ddsb9XKm34EAep9AwiVOLk94DHFzEcwmBYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8118
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

Hi Quentin,

On 02.07.2024 15:05, Quentin Schulz wrote:
> Hi Lukas,
> 
> On 7/2/24 2:58 PM, Lukas Funke wrote:
>> Hi Quentin,
>>
>> On 02.07.2024 13:37, Quentin Schulz wrote:
>>> Hi Lukas,
>>>
>>> On 7/2/24 1:01 PM, Lukas Funke wrote:
>>>> Hi Quentin,
>>>>
>>>> On 02.07.2024 11:16, Quentin Schulz wrote:
>>>>> Hi Lukas,
>>>>>
>>>>> On 7/2/24 8:48 AM, lukas.funke-oss@weidmueller.com wrote:
>>>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>>>
>>>>>>
>>>>>> This series enables U-Boot to import environment variables from the
>>>>>> selectd FIT configuration. One use-case is that the overall build 
>>>>>> process
>>>>>> enriches the FIT configuration node with dm-verity information which
>>>>>> should be injected into the kernel commandline. U-Boot will then read
>>>>>> these (possibly signed) environment variables and put them into the
>>>>>> actual Kernel commandline using variable replacement
>>>>>> (see CONFIG_BOOTARGS_SUBST).
>>>>>>
>>>>>> Example:
>>>>>>
>>>>>> Config:
>>>>>> CONFIG_BOOTARGS_SUBST=y
>>>>>> CONFIG_ENV_IMPORT_FIT_CONF=y
>>>>>>
>>>>>> FIT:
>>>>>>      configurations {
>>>>>>          default = "conf-1";
>>>>>>              conf-1 {
>>>>>>                  kernel = "kernel-1";
>>>>>>                  fdt = "fdt-1";
>>>>>>                  env,dm-verity-args = "dm-mod.create=...";
>>>>>>                  env,bar = "someothervalue";
>>>>>>              };
>>>>>>      };
>>>>>>
>>>>>> U-Boot cmdline:
>>>>>> => env set bootargs="rootfstype=squashfs root=/dev/xyz 
>>>>>> ${dm-verity-args} ro"
>>>>>> => boot
>>>>>>
>>>>>> Kernel cmdline:
>>>>>> Kernel command line: rootfstype=squashfs ... dm-mod.create= ...
>>>>>>
>>>>>>
>>>>>
>>>>> I think FIT supports storing U-Boot scripts and running those via 
>>>>> `source` command (usually the file extension is .scr).
>>>>>
>>>>> I do not know if there's support for automatically loading this 
>>>>> .scr as part of a config node though, but if there isn't I guess 
>>>>> it'd make more sense to support this case than to come up with yet 
>>>>> another implementation?
>>>>>
>>>>> What do you think?
>>>>
>>>> I wasn't aware of this, thanks for pointing it out!
>>>>
>>>> This patch was mainly inspired by the dm-vertiy use-case which 
>>>> requires just env-variables and no (complex) scripts.
>>>>
>>>> There is currently no mechanism to source/run such scripts 
>>>> automatically.
>>>>
>>>> How would you distinguish between scripts that should run 
>>>> automatically und scripts which are sourced by a specific 
>>>> board/shell-script implementation? I guess there are good reasons to 
>>>> not run such scripts 
>>>
>>> Scripts in conf would be automatically run? Scripts not in conf needs 
>>> to be executed via `source` command for example?
>>>
>>> Not sure what to do if you want a script linked to a conf but not run 
>>> automatically though (and what would be the use-case?). I guess you 
>>> could have a script automatically run (so in conf node) that sets a 
>>> variable to know where to look for the other script that isn't 
>>> automatically executed?
>>
>> Sounds like yet another level of indirection. Not sure if this a good 
>> or a bad thing, but makes things definitely more complicated.
>>
> 
> Yes, but this isn't an indirection the project has to support. We 
> currently support scripts that are in the images node to source. We 
> would need to support automatically running the script if it's in a conf 
> node and that'd be it.
> 
> To be clear, I am not blocking this (and I don't have any veto power 
> anyway :) ), just wanted to raise that something else already exists and 
> could be extended to fit your usecase.

Thanks for the clarification, I appreciate your input.

Yeah, I guess it works somehow using the current 'source'-cmd approach. 
Yocto even supports the integration of a U-Boot environment into the 
kernel FIT-image. However, I think the integration for some dm-vertiy 
env variables is quite cumbersome using this approach. I'd rather prefer 
to have the variables directly in the fit-configuration since they have 
no script character. But this might just be personal preference.

> 
> Cheers,
> Quentin

