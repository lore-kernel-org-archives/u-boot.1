Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAB7CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 16:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F808836A6;
	Fri, 29 Aug 2025 18:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DHLDT62Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6629836D2; Fri, 29 Aug 2025 18:02:45 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F99983675
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 18:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkhfMP/XgMj2OFPZrpohOlkQjoFCbbiHNoDzCsR9etKbFr/LNIEjDudHCvmqbk4xQyLcfrVVwMktPuL7UzDX5pdTrlMSuITRvffjv/jFf9uMUuQxhEXyXjydxvly15uLaxfAG7FcAJR4XCcto+jcDz4R679mOGy8N8e6nwrJ7D4/Ti7fmPSE7X3XGVLh7ehnO/BZCujlpVSgBfprDosonx5g+KrJQrIAEXY/CQg3+/j8SexlJL6GSHYO8SLaFN1dR5Vuzj4GInt7xhCUzjVnpKOjrWWFzdRZ6neGQE05Xe40RHtbYkckCbfSYEhjQur9JylIR4oF+0HKwtwa3Tu7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Grr52Ij7JC2hRKODbenOmqcwTQxDl05IWExOJ8m9Sw=;
 b=DLhv+/YOihlWmnsGr2xfEg0rGzqAPIp7PpjtXJELsulf6aoibcHvViuNx+WFaC5aCpKu7nE2gTxqPZTcVnRk5TnyfVlY9Cg68BrrLWhhaMEBCHbqiPhSVTsymjqTgjkLKLrxMzmnWu6jyyBuxklsPqSaOcv5OewdoCfXhlDA2uIn8O/gq2p5GTYxosUAg0ZznNXfqkwkVCHvcPfqmtQSYYv1dEjRn+syXXppwtwa3BERCMKoIK+SW91PP3oMUe7jPBt0Wh9kpFh+JzZxdtcndc1uuiqQ9k6xq+G4AhyZJBev7pOx8OKUtDkVDBABJLdNMnqkxWnms3RbBqnzgGCDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Grr52Ij7JC2hRKODbenOmqcwTQxDl05IWExOJ8m9Sw=;
 b=DHLDT62ZeeIQxJ4d3RCFSB0uui2/pLaLsWzBxwDaCp3itNmXJ9ux5EUM18tcY2HDd4qjztSWo9KTv2tB+2FQNZuEbEgyibe8ua7V0dNMFRi+A9qIF/kz7/o2+ArHggPgDlz0gXoj7W68oEyMF9lNcw4x4e8eBxhnfIQCgrtusxy1n2k8NwgUA9AE1lfQc1BsPY7PamdiiCISvtQnS/QzAzybc/eIDYraovy6Z6M53ieH1VZR4yyO9nD5J8n97FoTqnhGAdXpNxns1AlZSoTTYHUOX5aGSd0ap6PExXNu7adYLv6U7qz/ox90oQm6WQDuFY4f5EMZw5lNWkyH5UfqgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA2PR03MB5932.namprd03.prod.outlook.com (2603:10b6:806:112::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Fri, 29 Aug
 2025 16:02:35 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Fri, 29 Aug 2025
 16:02:35 +0000
Message-ID: <d2bd3b27-2cfb-4650-ab58-504fbed30ff0@altera.com>
Date: Fri, 29 Aug 2025 21:32:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>
References: <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
 <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
 <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
 <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
 <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
 <c13ee750-2534-4cfa-ac6c-a6a51dec33b1@altera.com>
 <6935fd0b-8027-48a0-b9ec-076535d929b9@mailbox.org>
 <9879ace5-88e0-40be-8b49-4e3baee5c1ec@altera.com>
 <20250825135914.GR124814@bill-the-cat>
 <DS7PR03MB5542E8B85D8091B5C53A14D8BC3EA@DS7PR03MB5542.namprd03.prod.outlook.com>
 <e63533c9-2fd6-4eef-bbdc-324742a3c455@altera.com>
 <4c1c3b40-f1c9-417c-9888-006cec353180@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <4c1c3b40-f1c9-417c-9888-006cec353180@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::14) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA2PR03MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d2df49-3794-47df-a46b-08dde7157816
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVlEY2lUYlJsRlFlRWhYeXZOcEEwdjdadFZsS1ZyTUo5TDNGeW9SZldORWl1?=
 =?utf-8?B?ZkxyWk84ZW5PSUxLdU1CU3RXVXdtQTJicU02STE1MTdXbzZoUGgrNGZzdGpD?=
 =?utf-8?B?WXNncmpScWFQb3Z2azZZWHpyQm9wWG5mdGc1QVlhYzFDYXRvTWN0SElLK0x1?=
 =?utf-8?B?ajV1OGs4L0xRc29FWU96S1RBb1VKOWRwUURGU21UOVhOelc3am54OU5UcnNh?=
 =?utf-8?B?U1RVV2lhWDdCSXhva3Z4OUdiZ3RHRENjWGZHR09EMDA2MEZhajRUVmdSc2pM?=
 =?utf-8?B?VE5OWGJxVU5kenBKdXYyNTd4Z04xTnpDMXFhVDQrSXd1RUxJQkU1aGhGdkRC?=
 =?utf-8?B?ZmxYTjFiZHB6WWxvL1pyNlBsbVFpcWM1V0hBeVdPeWt4eDFzUUc4NDY1Zm01?=
 =?utf-8?B?YWFTTHBYNHpDa0ROQStUTnRKQmt2cW0wa3R4bHhLekZIRXg3VnBLeml3S283?=
 =?utf-8?B?WjA1cXQ1NGk1eXcyMGpMNjlvRC9XN2Rwd0paTldDamhTcTVXQWJrODJtcEhr?=
 =?utf-8?B?dDJ5bE9oNEdUZXpxa2g1eE9zU3gwYUpGaFo1RDdFUUF5TTZTRG9oRkpVdUhE?=
 =?utf-8?B?SEJkdWlDRkwyRUlDQ3RxUHBmUzVxWmI1aHNQVEQ3dzNZQ0t4aXVQNy91RHhi?=
 =?utf-8?B?QjJNK2JLMThVekQva0NUaCszWk93K0M4djFkM05TSXVlQ1J3d3N3SDgvSUZs?=
 =?utf-8?B?TWl6V05WMDhJUE1IS2ZZNWhGcncxbEFhbXZRMnNZN3dqNnRiZUtGTjZDVmk3?=
 =?utf-8?B?dVZRcEd3QlNlZE9POUptUkdISHB3blVxTExTdkc5UlJuVnBhZ0FYa1pZUGpX?=
 =?utf-8?B?YnBCZzVJdyt5cVBVdXZNbmZ4R2VZZ0RHRDdMelZLVW9SYVpEQmFEY2hURGtP?=
 =?utf-8?B?elBhQlVhRE5PNklBdkxpZDdJSkJnRFNVM0ZlNUMvd0RVQmsrNHdxRlZKM3ZK?=
 =?utf-8?B?NnYwOFdSZ3FlTFVSSTJLZzJSUXB6Y2I5UVRwYzRuNTd4ZnBOQmlXVTIzTmlq?=
 =?utf-8?B?K1Flbnc5VUlPMXhncDFmaDhCclI1Uk9YWVFrQjF6TEhaSng3WUVZTUhWUi8r?=
 =?utf-8?B?VndSMDNoM21xcXorMkhtMGpJZ0ZKUEZRZUI1aFBab3NxeXUyNHpNc2FlZ3da?=
 =?utf-8?B?bTlvWUIxME50QmxnNnRPb0RqN2E1MllWSnJLd0JkcUtCcFNjQ1pFMmNnamgz?=
 =?utf-8?B?OGxBTU0rMnBHU2xLSmVWVjhaa0NnTUd6SGxyRGl4QUoveWJ0c3VCOC9RaVJ0?=
 =?utf-8?B?Vjgwd25nbFU3dHJtNXZYMzlLVjFWejc4ZFNyZWhBME5jeFd2cEZocmpOcExT?=
 =?utf-8?B?Q0haUElEVHZ2aHZnYXNjcm8rdG1kQWxZcU5ZZ0JGZ1Nna1dqZElNRHNKc0tq?=
 =?utf-8?B?WURwWFdKRmN3YXRpMmZQL0FXc0dqVk9ORTMwR2dJQmtVaHJ1YUpFOWFMaTJG?=
 =?utf-8?B?WU0zNTVOSWdPUDAzOWYrVkJiVjhnTjZtUHVnaUJCdllFTEdxU1hZdzlLcDNx?=
 =?utf-8?B?VTlXUXl0UDM4bTlwbStyVzNUUlJBbHNLeTlaMXN2bVdraHRwaTNhNTc0UFM2?=
 =?utf-8?B?OWlBenErbVlrZHdncUsvcXdENytXRjNrTVIrTW5mSDhVNWxac0RKZThqN0M0?=
 =?utf-8?B?TytuTXRSUzJscFUyZGY1ekFNVTJXZ1FtQTRwRmg5ZmpGc2V6cmY2eVBhTzRq?=
 =?utf-8?B?ZUpxTzFhbk5jREtOejZMRTNoZlhNNWd6ay9wMXhrMy9NTUY0OUx0ZDNkWi9G?=
 =?utf-8?B?N1QwNnVTeFc5MXlQWkU2bXhibGhJQnVIdlBJaWxqbmZGR3FnbXhMMmJZeXkw?=
 =?utf-8?B?L0hRUzdFY2NGWE5XMmFkcU9YM2wwcy8xTmVpbzhUb1U2dTUyUzUxV1dqc3F2?=
 =?utf-8?B?SXFVZHkrWGdjQXZqU0Q0V3pjbkFHclFCd2tRQThRNDlWWnJyaVprL1VhSHNw?=
 =?utf-8?Q?BpxO+6cI7+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0ovb2hHMVFpVzlhQlRTTTRhQVFRcnNrZmtrK241QVhpOHBpVXNvYjIwWExI?=
 =?utf-8?B?NlRCcUU5Z0JmQW1tQzc4VWVSaUpVb281RzNaSEVWQzJTbXVOcVcxMXRicUxo?=
 =?utf-8?B?VmtzVXJLbzI1R3dab0dXV05HZVAwU1NhajlSYnJvK2dpc3BEVk5IUzhBOU9D?=
 =?utf-8?B?dTZ2dmdjS3RORDh5MjBsRHlSalREUG84WDJvelgvZzd2b0l4Y0s0aWhOeUVn?=
 =?utf-8?B?Y2tldWR2YjVENllHSEVBZHBZVC9PVHR6Zk5oNXQ2VlRLK1l6d1B0Mk96dlQ5?=
 =?utf-8?B?SUE1SHhsNkFMSDAycHFjQVZxMDA2dG0zWFJBTEF2TElaeE5PaFJZZW1rM2FF?=
 =?utf-8?B?SWYzNWZkNllmNjFaZk1OWENYM1VhZjFTcGVvYUcxQ0Yrc3VSbDhEanQ3Z0Vn?=
 =?utf-8?B?SHQvUVVEeG9rY2M0blRBcU52bFFDRytjdzNuMll4UzRBTlYwRXlpcitQYW5l?=
 =?utf-8?B?REdweWZkalFJYjlvbGkxb2V0MlpWWUdmSGJkNkJLNWlzZGx1SzVkMkVmU0NV?=
 =?utf-8?B?Ry9hWXp5SEpFRzMvaXlnbmRORjlhck5PRmczQUJzeU1EUit2QjRKU25KYU5L?=
 =?utf-8?B?WFh0U0JyZjRta0J0TGhwZk9HN3FmUkpQNUkzcHdsbWh1QjNJNnVFbHVHSjVD?=
 =?utf-8?B?UGZRRVB3L1ZwWE5sUGlxWEFoVGNYSjZHSkRFNkNQazBNS2NLTmw3d1BRV2dC?=
 =?utf-8?B?cFF0T0JhK1B1L3hKR1U5dGVnYjgyNHBWTmNKRUJ3aHlqYjhiVWZiUmV0TUo2?=
 =?utf-8?B?bVU0Nm9oaVhYbFNNYnZNaUo0TDgrc3ZEQWdnYmdKQURoVldJWFBOVTBmKzlp?=
 =?utf-8?B?aXJGNFZKV04rNDMrTEVCODI4ZlZmckFaOVRrbVdqV0w5NGVyQTk4YWovWkxO?=
 =?utf-8?B?SGJkMDZ1bzgvWjlWdVdpZTFTallIemkwK0hSNTZ1cHpWZThmcExBTWNmQXVS?=
 =?utf-8?B?QldZREZIMWlrTU1rbk55Z2dsQmZ5dVZNVEZnMWEzWVhKVEJ1b1pVNDB4Y2pQ?=
 =?utf-8?B?b0lJajVNd3VDL3crYjR2dnZsNE1GZitEL2lDdjlNb0tFTUJDdXkyb2VGOWdr?=
 =?utf-8?B?YWxoRHF6RnRnekRPYjVtdFJwbWtLdkd0cmRSYWxoeFVWblEreG9yYXYwODRT?=
 =?utf-8?B?b0x0ZDByZ1dtR3FkTHA2czI5N1lkZ3ROcHFGS2swakVDaThlYkRocWQ1UWxJ?=
 =?utf-8?B?dHFkRVcvTC9PUDZUdHE0VDFEZGg2eDZ0cno3b2ZVSUJ5ZjRRQ2Zhekg3cUgw?=
 =?utf-8?B?VE40RVVYRXdjd0NYZEVFYjYxcFVOdGw2bm8wbnVqZldQT25CVGdXY3NTWFBW?=
 =?utf-8?B?T2VMQWQzNkk3YTBoS1BjZE40OVFtWHk3UUJ5c0d2d2xZVWRSY2ViVmtFVGZL?=
 =?utf-8?B?bVptbmZZR1V0MkxUTyt0R04ydTlMVjM5YVJHWWVycVhWMWx2NFBvZzlnZTZo?=
 =?utf-8?B?RHlMQkUweHQzNUdscWdIdXZHM0xuREhGd0dxRnpXcUtnWVVMRVQ1Y2Y4T3Nv?=
 =?utf-8?B?eTV3RkpSeDhlZnI0VDg0VVhzY1pkNzNXL05qVkt6d3EweUxwR1c1Z0pmNHNL?=
 =?utf-8?B?b1hiRGh1LzVyZUUwZU56d1JUT3R0N0xMamIrS3VQQi9HbStOZnRwTDZ4OC9P?=
 =?utf-8?B?d3diUm5NYWhFL2h1UDQzcXVUQkNYemJldkE1ZlNaWEpoelZuMHBvbC9PVUs2?=
 =?utf-8?B?d0J0RmlKSHBjMG1LNWcrUSs0aXI3cGpTczNQRWFUKzlNYXYyQm5WY0ZnSWhj?=
 =?utf-8?B?dFpyZmdzazJ0eVUzMzZRMkNWa2Z3eTJiNnNjNUdLUmRXaVYxUWpyMmN0R3Uv?=
 =?utf-8?B?ZmVkUlV5Y0t4Y05QQkRwSDR1bUl0dHE5Vk43b1RKejlGaXV2WDYyS1BaNFNG?=
 =?utf-8?B?alJJczh6Z0tMUkhmdzFXbEVvRTM5TUxpMXFyV2RNd3JSL3ZaSDk0YjNrQnlG?=
 =?utf-8?B?Tncvc3RvRWFWR3NlKzVQN1ZxYzdTU2lGajZsbHpTVkErUUNRVTJMRWQ4cTRk?=
 =?utf-8?B?dlBteEpQazdkc3pxTVFtS3VpQWdWd2hFVmVFSmVSZ3Z2ancwYjZsaFJBMkll?=
 =?utf-8?B?TnNnb1JGRVdEcEdxMWIxYWkvb3RzOUFFL0JuV3ZTNWJLRkNiZ2VZdFFQMjgx?=
 =?utf-8?B?RTNaUkhhczR1VmMvMkcyUDBwbnY3V2tKMDErOER4OEpnNG9jamgvZkhyWHRX?=
 =?utf-8?Q?WeQC6dXUj86kBK6/yb9zAH0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d2df49-3794-47df-a46b-08dde7157816
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 16:02:35.5090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIB08XOdaV08AL7bL0RbmSzp7OESiFatzWgUvnM9mef93pZEc0qS8d86eC5YSxPIX2+rdChpYYlhSASc/133tCFt1C3LAZolUhILrJKxbOGSeGPqUFIBLIRA142NoNvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5932
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

Hi Marek

On 28-Aug-25 9:08 PM, Marek Vasut wrote:
> 
> On 8/25/25 7:44 PM, Ravulapalli, Naresh Kumar wrote:
>>
>>
>> On 25-Aug-25 11:08 PM, Tom wrote:
>>>
>>> Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition
>>> loading support
>>>
>>> On Mon, Aug 25, 2025 at 01:14:59PM +0530, Ravulapalli, Naresh Kumar
>>> wrote:
>>>> Hi Marek
>>>>
>>>> On 21-Aug-25 5:33 PM, Marek Vasut wrote:
>>>>>
>>>>> On 8/21/25 12:26 PM, Ravulapalli, Naresh Kumar wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> How big is the file ? crc32 is weak . Why not use e.g. fitImage
>>>>>>> for this ?
>>>>>>>
>>>>>>> If this raw loading should be available to users, it should come
>>>>>>> with a BIG WARNING about data integrity.
>>>>>>
>>>>>> User can use CRC32 and if they require SHA256/512, they can use
>>>>>> that as well or any other algorithm as desired.
>>>>>>
>>>>>> RAW partition support is helpful for flash constraint devices
>>>>>> especially in a use case where we need to store data as RAW during
>>>>>> run-time and if data integrity is required, user has the
>>>>>> flexibility to choose respective algorithms like CRC/SHA etc. The
>>>>>> whole objective of this patch is to provide that flexibility to the
>>>>>> user.
>>>>>>
>>>>>> I don't think we need the BIG WARNING, as RAW data by definition
>>>>>> will not have any built-in integrity features and users should
>>>>>> exercise caution if data integrity is required. It is mentioned in
>>>>>> the enum definition that choosing "DATA_RAW" flag will store data
>>>>>> as RAW.
>>>>>
>>>>> It is not a good idea to use RAW data in the first place, because it
>>>>> gives the user false sense of safety, but in reality it can lead to
>>>>> silent data corruption. Hence, please add big warning.
>>>>>
>>>>> Also, how big are your payloads ? You did not answer that question .
>>>>
>>>> Is adding "log_warning()" be sufficient, like "log_warning("%s: Chosen
>>>> RAW data type DOESN'T have built-in data integrity support\n",
>>>> __func__);" ?
>>>>
>>>> Our typical payloads are of 3 KB size.
>>>
>>> I feel like documenting a reminder about this in the option help text
>>> should be enough.
>>>
>>
>> Thanks Tom, will add the help text in fs_loader.txt in addition to the
>> log_warning() and the same being explicitly stated during enum 
>> definition.
> Kconfig help text should be updated. log_warning() is unnecessary.

Sure, I will modify the patch.

Kind Regards
Naresh

