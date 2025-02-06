Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630C3C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 14:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CC080A29;
	Thu,  6 Feb 2025 15:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d/JIKLjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8058F80A29; Thu,  6 Feb 2025 15:23:25 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BA180944
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 15:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYFn9L6KVoBg5uURq5kvRsZm4ZmbIlK+dY1QfeTG5hZjSmrB5MZYFmaXbs8eBWA2zTJB6Jp+e7GJjZfcaHlvEAOSiSdcLYAPvT+1BNsoav/rgc7UjPRm6BNrZ883bhXV1mHiK6safCO2fY3F+Z3k/rxrY0+AJuncrWNWorYUf5FN/TVlgtGUrYZH/tBgHiNfvXPNYGNHguWA8+yNY6BvaU4ln7eQIy8K6REk4/I4aadhzGxdbTbqsVmVlXXOqYBl4t6Hrv8Eu/nSrnz6eII6FqerHoIncUsakp++aGaMuu8ojNykUW1izXUKWMzxCtFSACuSgZ6vai8OVfqmBkLMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tq6f+TTytea0jgpMmaCtW0zJ/SufLGPS+BfTWNzx78=;
 b=m4mRJFskTIUC1ob9MgIexSdXJzQrbYZMC9cV/c7q4tOC7zioThZqPvqFN/h4nIdAqNKOxLnCghiCuOrimnfOk+c+r4CIeiMlSvGHHQrkzMTFGexUQcPUVZirYjDjf7TjC1IuxTh/M+ZUZytkRJTI9iRenlVDkxJsR8w1HR/yUIi57d1MDghjb/LB5HSgJXFgu/vlqbYgcXhwupr3NgVa9+tRzOo+iXGzrvdB0t6UdadxgcOuZ53PsWUBc/3oKYuMRn9/NXvjhN4VcCgDSKJ7A9Iip8pgr26/uq54wlKGOqcr0FzpdhzfzXbv3LM+nkz8udIx7Tg3KiEvoD51dsqaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tq6f+TTytea0jgpMmaCtW0zJ/SufLGPS+BfTWNzx78=;
 b=d/JIKLjwH4/B8TX0x7Sn9EkLB0DQP1utJpbggRMc23yWhEre6i3gFs1+ElifvRIKu65U1IQGIZDKpfpxioYxixvoJfbx56Vs9TDGDkyHflLxJQ50rzxTpr5z61JkxMDLM4iGMUuXaTAkCWMqiAp2vT8ssEvXm2zjDqpC/rK27lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 14:23:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 14:23:17 +0000
Message-ID: <e607e512-4443-4f2b-b67e-fb42ec496e96@cherry.de>
Date: Thu, 6 Feb 2025 15:23:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: mkimage: Print image information for all
 embedded images
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-3-jonas@kwiboo.se>
 <6827e64d-a7a5-4dfb-9a90-800aa1bd40be@cherry.de>
 <5caa2b45-ce86-44f2-aced-ff6df88f1635@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5caa2b45-ce86-44f2-aced-ff6df88f1635@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0117.eurprd09.prod.outlook.com
 (2603:10a6:803:78::40) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: a5338f26-a742-439c-e3b5-08dd46b9cc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0Vic3plZ1dDVSsvVzVadVJ1bmhwaXVlb3RONDZpejFNS2NGd0pseVp2Nlhv?=
 =?utf-8?B?c29Xd2RDK2xuUzNueDd6T01pL3F5a3BiQXYrL3dHSnl6RjlPUU1FR2h2djYz?=
 =?utf-8?B?R05XT3hnTzMyNUFaUXJNNzlmK1MyNytab1NyREtHaHBxUlMvdzl6R1FCdlBI?=
 =?utf-8?B?YWdsWW5ITVpsM3FQaTFwNTVERnZFR0NqaXBrZ0JDWCtNWXFycFo4azV4aTgv?=
 =?utf-8?B?N1o0eUU4VXIwMDdKK2RZMnhmRmI5MUxHc0JxWkZXV0lxTFNqTzJUL1dBbENs?=
 =?utf-8?B?dXFwVTlsQ2ZLTFZ4UVMyS3NMNWJ1LzczREVpY0l2bExaUmhmOTJFWFVUMnFh?=
 =?utf-8?B?Sk1wR0JLRjV1cUsxQmZpOERqelZRMFp4dDdxcHRqSDZQT3UvTlZCZVdTZU5D?=
 =?utf-8?B?TEt4T3RySDB1aGVmZVdCZzBxaXYzYXl5MU9pODVHZ25nNkFnemhWWFgydDZV?=
 =?utf-8?B?SDVuQjlZMlFkUlhoSnVhbG4vS01EMUJWc2ZuN2lVRWZaajkvZzAzSXBIeWl1?=
 =?utf-8?B?Wmppa1g4M2d0blV4ZFNpOXZNL1p4UWNtWGZabjNjNGZRY3pNNkFGanBGVnlH?=
 =?utf-8?B?VjJxTlAwNTMzNkpzcW9zSFY0Y245T1dTc3BFK2JJSjhNdS82R3JWVWNyVUVK?=
 =?utf-8?B?a1dYNkt0WVU2alpSWVA0dTJiZmMvenRFcTZNMFhVbVpjeDhFUzhGZnJZNWZX?=
 =?utf-8?B?bWExSU1NN01wbmtIWlRsN0owa2FCRVhwUCtxdWFpcDE0dk1OR0JQOVVRaTJU?=
 =?utf-8?B?NWZwWTR0SVp2UmlaT3JxdWhGV2c1TUdQNVRGZzk2S20yRlU4V0lFa3dXREJW?=
 =?utf-8?B?TDYrZmN6VUNLUFpkZkxoM1FacEtkLzkxU05SVVpxTXJHbHR6aHNTRVR4NmtG?=
 =?utf-8?B?K2dHUnIrdlZPblZVMzZEYlcvWklGV2xwWVlLTWpSUUZpVnZKaTlEWGRMdEU0?=
 =?utf-8?B?OFNUSGNMa1ArYnc2NngyRnpJRjBDb29jQ1RuVGJoeThDVU5UOTN0enhHU1BH?=
 =?utf-8?B?aUM4NC9tZFQ1dVJTTmNUQTFsWVZsZ2ZvMUlTT1o3MUJUT2dxUlJ6a1pqTTZZ?=
 =?utf-8?B?b3cwYjl1REJkdEd1Mmk5eC9ZTjJqL05WMjg0alVVSjhBcStsVU10VVEyM2ty?=
 =?utf-8?B?ZDd4YVBzU2puazIyYTA0bzRGMVk4ekg4bzRPVXJtQkJJWldJZkM4ZTh6Ui9a?=
 =?utf-8?B?dzFIVHZyK05aYzFqNks1N21Ocng3WGRWblhxeWZhK2FyeVpyUy9JVDllZkpO?=
 =?utf-8?B?T1orQ2NKTHBweFFuNk4rSE5zczI0cVNFaDVZaFJUYjIrZy9vSldpUnRjK3J5?=
 =?utf-8?B?T21tcnRDQ3ZaSW1YcFYxU0twUU84cGs5V3BXZ0tndGtpTDloUXRpdWFlMHdZ?=
 =?utf-8?B?b1NrRU5QWjROTkxGbVJyek1zRGZMOUdTUVF2Z2tlcy9IQlpWQks0Z21SQnJD?=
 =?utf-8?B?S1UyYUV6RitrTzNlODJHOTlmNHNjQ0tzVm1YWkVMK2pMZ1lnREFQaWhTOXlW?=
 =?utf-8?B?OG1RbTFvWnhUUlN3NkppQUJ2OUQ4d0d5QXJlc2I0NGV6RXNDL2hBWkh2eG1O?=
 =?utf-8?B?TkF2eE1ncDdHV1V2U0JSVlZhUDNOaFJUd3QyRmhBc3FXcEJUVXh3ZFFrOEh6?=
 =?utf-8?B?Zm5tUytpQlJSUXZVMkFlZzlIQTI3RGF1Q1VHbGxyWWlZaFQzQ0dreWFpWUdq?=
 =?utf-8?B?eDN4ekJNSHlKSVZRbEE4enBVNk4wNUltYUVMME40WTR6cy94dVltN2dUWFFO?=
 =?utf-8?B?bDdSZ0tQM2h4VlpyT1dFM29aUzJ3alU5TWFhNFNXU3hWNW1KWC94bG04SE1s?=
 =?utf-8?B?UkF1R1RRdkxYUWtLcEFxNjJNQVRDSDhPQmVIbGFSa0ZzSUhFMUpsU2lkTDNE?=
 =?utf-8?Q?A3XAPXRA7RD8+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZQZHYvZCtoUVZKdzhaMWN2dDlRblhNM2syajl4aWNibnJrWkttRVVUSG9W?=
 =?utf-8?B?dUp6USsrdVlycGthMkZOZmwxNGk4dDJLNGVkSjNldXV2Y3lzMWh4a015M0VN?=
 =?utf-8?B?VERVaXBtMUNuNWNxVFFYemFQWldsdVl4VGNHZHFGc0x4dzhxUUUrVUxjdkZK?=
 =?utf-8?B?UWdXM2ovb05UamZGcEJSK2paUXBWdExOeWd6K0dBNmhPSHlkWXVoRjBVbFRC?=
 =?utf-8?B?YXhBTHBDSEVmMjVOWENZaXlqZHp5RlZ4K205VmZRYmZoTzZXOWVTcVVSbUZV?=
 =?utf-8?B?NWNuZDd2eHNsZTFZNmY3UlpOUUpWOHJ3TXJXSHZqeVcramU0OWUrWnBXYkdk?=
 =?utf-8?B?Slhrd2VacDlhcFdpZG1LdEMwamw1ODNCeUV6YXJKN3JWTWxHS0ltNmFkYzV1?=
 =?utf-8?B?R0NZQ2p1RFdVVlZZN2FLK1JneFYxU3lVSk9wTzh1MEt6eUFlbDVUYVJsT3BM?=
 =?utf-8?B?OWV3cEhYbEpUak10RjN5WHFwWU80L1ZPSjE3MXNNNHpNQzhzZXFlTXhxYUpq?=
 =?utf-8?B?cDVTZWZuZXRKQURrUHZzd2FSQkwyZm9UbmdITGNDUm5LSVVYcnhZQnVRQUlq?=
 =?utf-8?B?MmQrT2pyUUFGeHpSMENoOFpqUEoxcFdMR2N0ZW53eFlKb2M5Uk1aTk5CK2VZ?=
 =?utf-8?B?emw2OVpSb1QzdUVGanJndGNGRXVkQUg1ejVsMmxxeWZ6Q2gzU1dRajQ2Yjlo?=
 =?utf-8?B?NzNJck94ZW9nUVVuVXUzQVpMUUhpcFBBMGdlNlNVM2JVTmtHNnJTNk4xZnl0?=
 =?utf-8?B?MFVPZFIxQllhVFplcWhsVEFCcWxHUHQxN0JEQStDMUxxTDdDM3Y1d3pLalBE?=
 =?utf-8?B?anFqWTRUcUFhTGQrVENhc2c4YWc0dUpOcWxUcVdFakx4VHk3NEpXdkVzTVZO?=
 =?utf-8?B?OUllb2d2V1pOYklCOSswWkVRZ25lbUk2c3FzQ2l3QTVwdHZmZ0RnL2l2cm5u?=
 =?utf-8?B?Umo0d0pLeFU3TGpveWJXSEV4S01kc2JBSGNacnFBS3RZUGpvQTdlUXdRaCsv?=
 =?utf-8?B?alpzSkJ4bHVhbEx0QWcreDMyUCtaS01udFRYK1B4MHFIZUlTNHZHK2RGTXVY?=
 =?utf-8?B?VHVVcVNVSkZiNXVMT21EeHByTjZZdCtEWTdqOWd5eTlrTGVqZGpxZy82T0Y3?=
 =?utf-8?B?M1lENFpVbFVZSk5pbjVVWnVUSEdKTHJVYlBERjhVaTloT1E1TldPZUpzaWNt?=
 =?utf-8?B?dEJaTEFva2Z3UUxwZU11ZkUxNTlsNmFwZHFlUmxvcVloOGZ3NERVdlNqdnhV?=
 =?utf-8?B?RXJNbHVKc1N0Rk1nOGQ2NTRTNWJkeHhDanBtZHpPbEIyM01yTk9yczQ5N0pK?=
 =?utf-8?B?aWNvUmlZRU1ETGREZ3dTNnJzNXBUaklwSExDSndtYzkzcGNBbmRQb2hJL1lt?=
 =?utf-8?B?R0ZmYUZDYUdQYjRzSHF5Z2ExbWpnWVFFcFhlMk5ka0VpUXg2NHphK0tHNkhR?=
 =?utf-8?B?U0RUaWhaVmNBL09iTHRxY3A4N0JnUmNrVmd2MEZWMUxQck5lc1NFMDkzL2ZC?=
 =?utf-8?B?emlhVnJkWElrbDB1RGNKcUlMeUJkMTFDR1NYZXRXWjJURG4wYzZNSmM5Rk9w?=
 =?utf-8?B?Mm5CVFp5bTF2ajZBL3FDQXltUDByM0U1K01oSTdVVmFpWkVKbjczV3FFTFhl?=
 =?utf-8?B?cGM2WnNGdmNPZVRjdjlsa1czRm4yenRQUHMwYzNqV2h6TTF4VHhwRVFEeFI1?=
 =?utf-8?B?bTN2ZWJ5YklqU2VkcFBpcDBDR2wxemI3YWpLNUw3ZWtvWThzM0RPMTBFNFl5?=
 =?utf-8?B?L3FjOGNpbEwwUDBJNlFYcjlnUklvbDNkY05yck8yY1hDZHRvM0RXR3ozSFNV?=
 =?utf-8?B?TkdoNHpKRWt4YjZld1IzK3F1MTJBNDV1NUFnR3dvdWpDVWNKSEJJbW9zODRC?=
 =?utf-8?B?dG12M09CVGlHazJBb3h5ZFhFN0F2L2FHT0xVN1JjVnk3Z1l2L0UrcFg0c2Qy?=
 =?utf-8?B?NUN0MmVvUlNFWkNhRWlLTEg2Yzg2ZHo4MTYxR3pJRk9lSzErQ1R1ZXcwdm9i?=
 =?utf-8?B?K1FXQzFkZjVtdjFIVEd4cmxqd1dyYTFleE1JK3huZVZ6bmNlc2RlT0ZlZmEr?=
 =?utf-8?B?U1BXbXRHN1MvQkFQSERTWGx2QkZnRTRYVDhiR05DK3Z2SXN6Qk5JZW5qYSth?=
 =?utf-8?B?M00rT2ZtdEtHSmh1WXRTVkZoa3loOFlIRmhXa3ZxRnAxeWd4dVdjQWFNUkhI?=
 =?utf-8?Q?x1l/Z9khrmULdFvB6XyIcpo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a5338f26-a742-439c-e3b5-08dd46b9cc71
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:23:17.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: job/AdVb2LOIg371mNcqBKGbhdSkOyNwfdqaulqLrRIwj2cWLrfET+Xglfbk+0Bw6HFjlpOaIWpyI0YrVYWG7TJwmSGnVRQo4y97rCChgUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001
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

Hi Jonas,

On 2/5/25 8:36 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-02-05 16:57, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/29/25 11:36 PM, Jonas Karlman wrote:
[...]
>>> --- a/tools/rkcommon.c
>>> +++ b/tools/rkcommon.c
>>> @@ -331,8 +331,6 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>>    	uint8_t *image_ptr = NULL;
>>>    	int i;
>>>    
>>> -	printf("Image Type:   Rockchip %s boot image\n",
>>> -		rkcommon_get_spl_hdr(params));
>>
>> Not sure this change is related? It's also not replaced by anything if
>> I'm not mistaken, hence why I'm wondering why it's in this patch.
> 
> Following was meant as a replacement for this, in rkcommon_print_header_v2():
> 
>    printf("Rockchip Boot Image (v2)\n");
> 
> The old printf() was incorrectly done at set_header, not in print_header,
> that is called after set_header or when you try to "mkimage -l <file>".
> 

Ah, I see, thanks.

So this is a bugfix because it doesn't show with mkimage -l, separate 
commit then.

>>
>>>    	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
>>>    	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
>>>    	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
>>> @@ -486,6 +484,29 @@ int rkcommon_verify_header(unsigned char *buf, int size,
>>>    	return -ENOENT;
>>>    }
>>>    
>>> +static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
>>> +{
>>> +	uint32_t val;
>>> +	int i;
>>> +
>>> +	printf("Rockchip Boot Image (v2)\n");
>>> +
>>> +	for (i = 0; i < le16_to_cpu(hdr->num_images); i++) {
>>> +		printf("Image %u: %u @ 0x%x\n",
>>> +		       le32_to_cpu(hdr->images[i].counter),
>>> +		       le16_to_cpu(hdr->images[i].size) * RK_BLK_SIZE,
>>> +		       le16_to_cpu(hdr->images[i].offset) * RK_BLK_SIZE);
>>> +
>>> +		val = le32_to_cpu(hdr->images[i].address);
>>> +		if (val != 0xFFFFFFFF)
>>
>> Can you explain why this value is explicitly excluded? I know this is
>> the 4GiB boundary but why does it matter?
> 
> It is used as the default value, unknown why, see:
> 
>    @address:	load address (default as 0xFFFFFFFF)
> 
> Can probably add a code comment here as well.
> 

Or maybe a constant to highlight the relation between both. Though one 
would need to give it an appropriate name... Here comes the most 
difficult part of SW development.

[...]

>>> @@ -521,15 +541,16 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>>    		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
>>>    			    init_size;
>>>    
>>> -		printf("Image Type:   Rockchip %s (%s) boot image\n",
>>> -		       spl_info->spl_hdr,
>>> +		printf("Rockchip %s (%s) Boot Image\n", spl_info->spl_hdr,
>>>    		       (image_type == IH_TYPE_RKSD) ? "SD/MMC" : "SPI");
>>
>> Please keep "Image Type:" this is what's used for other SoC vendors
>> also, I assume some tooling could be parsing it.
> 
> Sure, will restore the "Image Type:" prefix here and for "Rockchip Boot
> Image (v2)" above. Should probably also adjust "tools: mkimage: Add
> Amlogic Boot Image type" [1] to do the same.
> 

Could even have another callback e.g. get_image_type() which returns a 
const char* to print after "Image Type: " and move that to 
tools/mkimage.c to have consistent behavior for that part. Probably 
over-engineering this though :) (I think we'd need to update imagetool too).

Cheers,
Quentin
