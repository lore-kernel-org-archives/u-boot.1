Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8D4C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 09:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20ABC8777F;
	Mon,  5 Feb 2024 10:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="F5T0pdyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49FC8877CB; Mon,  5 Feb 2024 10:59:02 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC70687730
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 10:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuWERLqOn+PyatLdcsrUCHt59WGUTJAxMeYbXDRKINtWYHimD8aDFTC8NLtVNZKSziugdIcbpObLItbKoO883AX9PGJB/4G19jUGuvQ1ka+DCE2jbFfrs/67aNM4woeDwB4ztONDN95V23oHTwxqrLcvo7b9GBe5ow9POTX+28e6xmSroYgz2aL+fcod3wuOfSEVLMnmJ4zTJkKdElI8+wrBg2ERnyYhdF0nt2loQK503dLhcBzMStFUbFV9EewXEIhxrzgxXioJ0SJtwqTWtsZVA0EQDotvdd5aaovtm5L7JYtvdid8dcYfkApWnddocWKxk7DbEj6hTTSO16Sy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfrJmfMwbHIwGn5LXx4X2u4TzQJrZMBsacaQ6lOFQDc=;
 b=E0EF2OyGsnjNaQLhCfPERrg0wVS3HxLEw+m/BrnNTOLT0eKhks+BgwzDTVDNlkJxSZecoVhs7ywwSmlVSAs24y+mxTs2vZP/RXsC7VOpJ+Q2wrQCpw1cH2h9VBwcYofhat3dDgUo1W0wyFZEIyfkoe6a6vY521XSRallzRokWczwVneCnTm6tD2sfYw4YqJwCteCdXsjlaLBLgtz2pvvQK4LTclck5duUXWXlfe8ZX2bIb3hUO6HBVi2ehjYkcxw+1qfUDP60a0WXMuguaohzr2B9R9M3aeVk1K/FLA9oFucnnD6QTI+bFv228Zw8UfBxDI65qyzPdj3/slREHhI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfrJmfMwbHIwGn5LXx4X2u4TzQJrZMBsacaQ6lOFQDc=;
 b=F5T0pdyf2aTavdeYqcKItz7wSShQ2/WFIiTXWOgP0UgzuqL4hER2mE0prYXEXKOAPY4xLF8gGKtnMYlcxasXhrxNUuNaNi1Yi3XmKiwQ2eSXSigdppxXQsKerarzetwcKtYJGNaTl3haD2VkAyHav6ByubgIqPzKwZG/AQN3hE6JpAbLjvWVfq9+Vb8V3LzU0GhicbiMdpyB/7Q9JIE6Kx5Rwu9IPxSuaRtdC7+o1FCPrDcfPy9gc6FKFwB7b8CnxmUiVq5hEc+RVZplnUfkupTFZfXDDItDkIkL03b7Se0U/d823whjUiNiaAXsIyGZ4pDKKhlmt9qyI+2NRhfwbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8733.eurprd04.prod.outlook.com (2603:10a6:102:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:58:57 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 09:58:57 +0000
Message-ID: <db14c4e0-7857-4e20-8b02-3fbd7aa1eb36@theobroma-systems.com>
Date: Mon, 5 Feb 2024 10:58:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] rockchip: rk3399: simplify logic for getting SPL
 boot medium DT node
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: heiko@sntech.de, u-boot@lists.denx.de, jonas@kwiboo.se
References: <20240118-rk3588-spl-boot-dev-v5-0-a8df3e50f486@theobroma-systems.com>
 <20240118-rk3588-spl-boot-dev-v5-1-a8df3e50f486@theobroma-systems.com>
 <71f45740-0ff4-445a-a941-69c079dae421@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <71f45740-0ff4-445a-a941-69c079dae421@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ca7b1b-4624-4cfc-64c2-08dc2631118a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdVCzpvAo5t7tIPzZJ8kaGZFYuyWwXPA72KtE2yzt3hX373gL4Oc2Vs2emtVB/5O2xBQO9R8tEz+WboeBVxd3xgFs+aF7cnLhNOjneuct6eItEhlZJKF2ml3tmbxR0QZh05oJJWTRVeLHj4owRFh3pzv4RWnYKcFutDUgTn41G0c8uyU2ffvqo9etutajPl/T7YbeH6NdmVKtMxWP1Ef+TNOHjWL61I38T9opAZGhYW38qT9CqLm25LYAD6NqgH0JzeNm5xLqVXh2siRQagoGpQGuU4eZf/jTnq5eST7R/G0BhlLtthAIhG7UpcUID7V0B7hf0Y8mZ20jGDhrjJi0d9sNYQt7VqgwQG/Hv6SkQ2/Wsq3BVL0cWoP78Ce8JCQx5OxSgUAW9TvXsXKux935F6JWaTPMrFz/5npUOHZA4Jws1xehx015vCaHJ943SNf9GW2fkUgXet96DWhnrZUjSBhetJAnZMNQR+CUIKZW6pKCve7jo2UB+gxx3fKtrv2CazDRdMlhvGAdQ/GnZ9jevrWJ34QcRv/SArkyFuoHiY5sPlZtQ3m2vZXFFwVGuDDNHupL6dNg2hNrYjJHvXnsQv5cDOopPl2GwLodDx/vODBrt/9/bb1uWVSLOtK6Dbu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(39850400004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(41300700001)(83380400001)(966005)(6486002)(26005)(2616005)(6512007)(38100700002)(478600001)(53546011)(6506007)(4326008)(8676002)(8936002)(36756003)(66556008)(66946007)(31696002)(5660300002)(86362001)(4744005)(2906002)(110136005)(66476007)(44832011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVFOXgrSEhteXhySzNacmFlYWRjK0lqMHljUkxma20zcGxaMXkyYlhFVERW?=
 =?utf-8?B?cTFKUUZNS1JLeFZlemtVeHFyUlRienVSVlZycFluU0F1VjQ3WUZCbG5hZEht?=
 =?utf-8?B?K1FQRDdjay9hdTkzNGJobE1SdFlCL0ZMWWx3Y2NWNHZhcU1qb3JyYUFJSTha?=
 =?utf-8?B?YWtIQyt3bk44Ny9kWGRNbGpSd0hBUTJtWWxZTEFPWWFWMHpvTTJtRXJzNGp5?=
 =?utf-8?B?U0xtcWU3UGsycXd1UHAxMFI2d3VoM054VVZ3RTdhbThHM053QUFrUnZza1dM?=
 =?utf-8?B?dlVvRnJnWXlXNUVtcTRia2F1Q1lYcUlkdlRUbEEwSFBXNU8rZ0ZORDNzQVNs?=
 =?utf-8?B?enVEUHl0cTZXM3FWTXNhQTBTdEs5UUJkdWx2VGRqcDdsL0pqUm54OUtmVDNm?=
 =?utf-8?B?QlNhVk5YMkJUOVJjUTU2dUN6aE16VmdQbTBVUXJKZzVIMXc1Q3BDN2hROWpu?=
 =?utf-8?B?bDVDNHppblEyZVN2bC9keHB2UU5hRUhuNkYraENJMkxFbzhtRXh6T1NjaDgv?=
 =?utf-8?B?dXJ4N1RHNjlTazZ3R1NtaTF6b2FKQkNCRUZwWGM0RjdrS3JobVNqN3haOHhw?=
 =?utf-8?B?WXV3ekF5Q3VpTzREWWpWbDM3UDlpdlN0aXpTZkNuWHhrODJHSW8rWHZvQnhV?=
 =?utf-8?B?VS9raXc1bEd2SlA4UXl3MVVoMFA2cTRsUmYxMXErSmtueGg2a0ZkWGhVbWFr?=
 =?utf-8?B?RDJaTUc3dDlLc0VCRS9QMkdRb0xEWUZFN3JMeXFiV3hkZHZldDJWYklkRDRS?=
 =?utf-8?B?NDJKa0I1R25RakxnWGYyWVVlRkExelBoVHd5T2w5UmEzMWhvMzhMT2I0RVhT?=
 =?utf-8?B?NWZTMmtDL0pmUmJUc3REOTdZRE94Rk4yaGhDVU1lZ1FzWDBZQmhqWCtYYXRB?=
 =?utf-8?B?N0kzY2hXQmlhK0RkUnRnbjVBaGFnbEc3L09GTmhWVUxHMHluTG0xY1NlZG9Y?=
 =?utf-8?B?TnRibFlRU1hEWmNxWTZxWWpISDk5bktOdm1pSWIzd1U0YUhrWEFVQzdCUUpP?=
 =?utf-8?B?ejlKanAvc3ZRaENhRDNwNGJPLzczSldIa3pNd0lKUjl2a3Y1UmRqR2pOMXh1?=
 =?utf-8?B?ejNUU0RwL2xBZ0ZJZjVrUFFFdU9ERGZpRUxaYXlERm9XUjYvcUxKNGhFU2VS?=
 =?utf-8?B?RktmbEsyMTZoZW92U0NHSGQwL2MycEZ4Y3o4ZzZ4d3lJRUQ4SGpUbVpQOG9s?=
 =?utf-8?B?Z1lNekRGZU9tdXVsMDhvT0NWSjk1SGZKM28vejR2NG1nbWQwd3FDWFl1SE8z?=
 =?utf-8?B?NHdxMU1tQ1J5M1VlMjcwWXJmeU9VQ2VvTEErRmZHSzBzdTNIZkpHbXZSR2N6?=
 =?utf-8?B?WU9wZnFDN2d1QUFVTHc3YkhiT2RWRDdSSzFDNXl5Q285cTVYbURYb3cxY2dB?=
 =?utf-8?B?czdaWW1CUXVzbU9iZVU4R1BSQUNYdG5pMDJKaDNLYnNveHRDRnZOSTgwTDFm?=
 =?utf-8?B?enJHaS9RQThNMFQxSGYxaWV2aDIrUEVZZlJzZ0VDVG9VMTc3ZWdYUEpzZ3kr?=
 =?utf-8?B?ZTNqRUVjZmdKZ3o1bDBQMGtHS3l2aU1oU1Z1VFJGcStRUTE1V2VuMk9EbDRi?=
 =?utf-8?B?alo1bVRSRUdVMXVnT0FVd3VUZGphYjMyM09TN3NrOU5HcVNnUjI0cGRoQU04?=
 =?utf-8?B?c21HMnFLTURkY0kwV3BEelNlWFhkWHc1ZDBQa0dEMFNmdjhuc2FlcFZUUE9l?=
 =?utf-8?B?VkFocDNSei9KY2dNZm42MW9id1Z4YU5FRDUyRkVvQy9QYXBWTys3VkVtZmpZ?=
 =?utf-8?B?WDVZclEzY1JObTNQaVFmN20yMlVRcDlUTlFLRUJmLzY4NVZpWUJFZDQ5VXNJ?=
 =?utf-8?B?dURRZjE1cEFjUm5nYWNpdytuOTFWcVV1NThWTE05bjQ2RkFlNHpHOW0zZ1lw?=
 =?utf-8?B?ZG5FaGNBWTRvb1pYZlhWc0VUZkpIMkJrTG80cmVzMDlYRjA5L3c1bkh5aXNp?=
 =?utf-8?B?ZVRvUEFKSS9CbWt4S0xFN0xKK3RBQi9acmZneXZ0bFd3M0k4NjFXQXVnVEMw?=
 =?utf-8?B?eTFOTUlhblljTldmekVlQnI2amxCdEVsUmE1U1I4NXdoTTVqMFFXTnY0UHNw?=
 =?utf-8?B?dDVOYlZkUm9YWnRDemduUmJrbnYzbnFOUDZUQld6TXRmektBc1kwdWN2M28v?=
 =?utf-8?B?L0c4cGgwVmYyZnAzZjRZL3p3QUdtTmNEVnA2ZnJWaXNKc29YV2lVcnhtNnB0?=
 =?utf-8?Q?2xHPlhWXdrT/eBP8XndkMo4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ca7b1b-4624-4cfc-64c2-08dc2631118a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:58:57.1053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBVxPeVgZjvOt8xzgKEwigqvedi30d+2zUNmWZJVBTydZHeSr3qwQ7PgJ8rryivI2ykG1tnibnlZNsRTN5/rjrPwlPl0aMuWtmoeRxdegJheGfKKINk/L3BfzRwHeUfN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8733
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

Hi Kever,

On 2/4/24 11:45, Kever Yang wrote:
> Hi  Quentin,
> 
>      Could you help to rebase and send this patch again?
> 
>      I can't see the version v5 on patchwork.
> 

This is already merged:

https://source.denx.de/u-boot/u-boot/-/commit/543f24dffcf1a85faf95228c0d0ba2dee097939f

So not sure to understand the request? What do you want me to do?

Cheers,
Quentin
