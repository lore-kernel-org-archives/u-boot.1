Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44658C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 16:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D30F82D83;
	Wed, 18 Jun 2025 18:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="taxrGXuG";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="taxrGXuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E106D82E08; Wed, 18 Jun 2025 17:44:38 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B780082C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 17:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pieter.van.trappen@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwXx22lxa5fop+6F2x2C94XIsBx5iEG46jngVoOwhD71V8lOhz9Qj8OJzbuaKbavl8qjc4tAZmudnADsrADfU4VJXM9vkGywnoTKPPnupmq4Ujib21eiyvOiiZfBHNHWiJgDfSGA1jmXkiFhK+s/a5nO1MfeSGopVthYJp4myfFMcCMhJ0UbrvqL4W5k3skvX18Fd4q/gUvP9t5wak2uhzPfcfOzzieCnP7teAVR9y+FSdBOviwFoZ5S2Tli48ygV57zaGnMPvEBtuCdD6AqKRWviynDA7nEnoJZHYqe+ci/NFezV1zWQd4WegcW32m9WRhqp0yDO0PaniAHEmzDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA/iKeBAOjQbjSgNjngWZf3rHxLJM5QwI6ubTPiyNEk=;
 b=LpMwBjNKn+pwgwkAB0PRX6eIvZOjyNBjVNaW+wfUELVIFWoiRpEE4wSXvPx5hwSCiX492EvpYd0Zs39lxcCRYO2PCoBYIxQ/1nbFYESOhXlbHPKd5MudPfkOKlnVRjvVmnY84Q8Hgwlwi0cCdLF4IAVYhkD55lqngKZ6oLbaSG6n40N0uy7+UBgbc5ad7/4lcUKLF4NkKHoa5Oh6vh1pMZNmmmxM3FybNQ1t1slxUgJpKNwFf5v3FQtenuRFagPV16xB70EQ+1tK+w5PrNifkwDWv+7O5vgykxXDV5KsMmJVJJE0e7ReBHFwVyGH46eBICV9GHECW/Hhf6iIDAfd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.16.99) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA/iKeBAOjQbjSgNjngWZf3rHxLJM5QwI6ubTPiyNEk=;
 b=taxrGXuGpS8/ofl8WDQ0lzSUZz2tmAmx0fw54BySIlIJG8qN9FzruYuO4AMXRpdU8s2p5tQT9BjPrqUwx+XRcBqKMk+BSy/44Ihq/BW58T7wStgJzqRAt2bjXirTbcUC4WMLdBSAFI8XCRjpM+cOjgC7QTK3fSeraBPSk2if+Kw=
Received: from AS4P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::16)
 by ZR0P278MB0026.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 15:44:32 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::21) by AS4P250CA0028.outlook.office365.com
 (2603:10a6:20b:5e3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 15:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.16.99)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.16.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.16.99; helo=mx4.crn.activeguard.cloud; pr=C
Received: from mx4.crn.activeguard.cloud (51.107.16.99) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Wed, 18 Jun 2025 15:44:32 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=taxrGXuG
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17012050.outbound.protection.outlook.com
 [40.93.85.50])
 by mx4.crn.activeguard.cloud (Postfix) with ESMTPS id E7EC97FC5D;
 Wed, 18 Jun 2025 17:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA/iKeBAOjQbjSgNjngWZf3rHxLJM5QwI6ubTPiyNEk=;
 b=taxrGXuGpS8/ofl8WDQ0lzSUZz2tmAmx0fw54BySIlIJG8qN9FzruYuO4AMXRpdU8s2p5tQT9BjPrqUwx+XRcBqKMk+BSy/44Ihq/BW58T7wStgJzqRAt2bjXirTbcUC4WMLdBSAFI8XCRjpM+cOjgC7QTK3fSeraBPSk2if+Kw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZR1P278MB1690.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 15:44:30 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 15:44:30 +0000
Message-ID: <ef7de176-5beb-4a7f-9663-a2757b85b86c@cern.ch>
Date: Wed, 18 Jun 2025 17:44:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improve user feedback in case of FPGA bitstream load
 failure
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: vtpieter@gmail.com, u-boot@lists.denx.de
References: <20250617092333.335908-1-vtpieter@gmail.com>
 <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
 <20250618135728.GA6521@bill-the-cat>
Content-Language: en-US, fr
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
In-Reply-To: <20250618135728.GA6521@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: ZR0P278MB0759:EE_|ZR1P278MB1690:EE_|AM4PEPF00027A67:EE_|ZR0P278MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: c3075b2c-387d-4d6f-25d7-08ddae7f051b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?RE45cWM1b2pGNlo1alZicEtQcXd0S0RyaHNGSm9EejhNL05ZU3JiMzdlWTFl?=
 =?utf-8?B?YWd2ME1TaHp3YkFIa3JGRE53UldLeFJqNGdKRmIwZFhYNnVEV21ZSThjSUFZ?=
 =?utf-8?B?eldTVmtodVdRcTFyZERnd0Y4YmZVOUZKcExJWWx4MjdJWFY3UUNXVCtuNnpE?=
 =?utf-8?B?VnlZLy9HTGg3cFo3RHk5UG56czFZb2QrRFNRRjkwdTZ5bHdweUFMMk1qUkx3?=
 =?utf-8?B?cjJIc29EYVA3YTNZVDk2eDJaY25KUFNzTk5XLzRGcDFIUTk2OUVmSWV5Y005?=
 =?utf-8?B?YXh1Y01XdjU5STJWMDdKUk5vTzVKNHpZWW9Yb0ZTZjFtZW9YYzF3SXl2MWZ4?=
 =?utf-8?B?cjhhZnVDZ3pTdGl5WHJaT2J1QnRqUTNiRS90KzUxR2VUUGljNld2dFdzeGgv?=
 =?utf-8?B?bWZ6QUw0cURqOEE3TTY2Q0sydW1pNVJKejFyUEsyWWxva2MzREMzellKa2Jy?=
 =?utf-8?B?NDlicUpIMFJTMUUxaU5FUVp2Mko2S0k2RDAvYzN3NUc2ZDI5L1hYTzl1ZTNW?=
 =?utf-8?B?K3lzdk5BN0FiZ0V6dm9CNWRMcy9yamNJSVA3cTBEeFZLMVl5cnpRRk8rWDVJ?=
 =?utf-8?B?S1RmMDlYWFovUDlTQUFyaWlsUUIvVW9JbjA2T21YM1E0TjIzVFo2cWRMMkxh?=
 =?utf-8?B?dG5kTkxVSnFjQVRDWWJHNTFCRy9LeHY0MkZJd21vK1pOMVlZaE9XVkc0dFhw?=
 =?utf-8?B?RUwxbDVVLzhaU1F4NnJiMUlCaktXVnMyVVFvNllVMXp0Y25TZVRMeFMxRVFw?=
 =?utf-8?B?Q1VmUDlFQm1kSWxmR2I1ZlpkQ2dJMlZRb3BmTHZMQU5hTm5iNmJOSG9IVk5N?=
 =?utf-8?B?Y001WFMrc0EyYTNTY3FvSXZzNFhpSm8rUWV4MUt2eEhZZDJTV0NncGxEMlN4?=
 =?utf-8?B?N0wrVm82Qk1TRzRkQUZOL1RrNDhGTjF5aGFhaUp6aWFHOTRrRTlKNTJLRlNx?=
 =?utf-8?B?aDk5S3JtaHorVmlqOENtODJZbkloalpHdmVabFVXaGJZMCtMY3gyYXNuajBO?=
 =?utf-8?B?Z1ZPZjhWaUFPczJkQWtJZ2haeWRaUy9tTkZVRDY3ZmlSWDlQK1dEaTg4OFBk?=
 =?utf-8?B?clVpUmhsL0FTRTZqUmdMaFFZL3NOdW5WelhORzdWUCt3ZG5yNUFGT1pkejlk?=
 =?utf-8?B?d1IvMG5SR3RMUFhXTDdMenhOQUZ5UjFPbDRRcy8rc1ZEYTBsbDNYd3lTdk56?=
 =?utf-8?B?YWhXVTV3R1dwYndiQ1hZbjhNRXI4d3ZUeEVxaFl0M0xHRUZxNzRMelhGSVZ3?=
 =?utf-8?B?cEV6QkZTQ1FKV3Jhbk1xWjVrU1JvUGlyVnJVdmQvSUdndm5jb3JzUkRKaURJ?=
 =?utf-8?B?WncvekFxSzFrNDVpVEZNUGxnbWZqd2ExZW5VYmptOU5tTDl6VldiT1N2ck41?=
 =?utf-8?B?dzlubmFmVmpQYmFMNVREMXl4MjU1TW50UGV1MHRLZWNRdnlOU3oyQmlzejgy?=
 =?utf-8?B?NnVkaGNURlJCL2hLUkdjQVRTUm1xMzlGckdwaklEZ0RoYWxWTTF1UXMrREdE?=
 =?utf-8?B?UElXcTZsTlVyTURuOHp1SkxNWWFFcTJvMlRIQXpzTG9BUEI5WmZubnVhQzVO?=
 =?utf-8?B?Z0FMcWxMeFRWWWNnOWdsRDBxU1l6SEo2TmFxTXdwSlIxenJQUno2MU9IckYr?=
 =?utf-8?B?VGdQT2pqdy9yL20zOWZKV0I5UWJQVS9jajdOZHN0WjlsMlZQZlp6S2svN2pz?=
 =?utf-8?B?cDVHNDVNNGQzOXptMUhHN3JZN1FnUTV4c2tKZDZTbmJtS2pOZ3RLcDBjcUhw?=
 =?utf-8?B?djZYRmlTQUFDSS9CbjhDeG9kOE9YUElTQ1Z6eXFtd2liWVlaeUJkTzJSZk5a?=
 =?utf-8?B?cFRlNCtkL3pZVG8zT2ZpVVpGcnZUalVHUDkvc3ZuTDZHelJtdityZUYzNGNS?=
 =?utf-8?B?cCt6ZzV1dU9MR2dzNm5nQ21mZUpmeXB5TEV4UXNQVXB4NVY2d3hCRHBaUFph?=
 =?utf-8?Q?zKgya8j/Bwc=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1690
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0642d79e-7111-46eb-cb50-08ddae7f03c3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUVoVi9pN0cycHhUekxWTGt4ODBIeEZ0M003UkVyY1BLOWZuTU5BV2RvbHVS?=
 =?utf-8?B?ay9ZaEpLSkM5ZWRza3h3N0NSdXllcE52b3l3V3doQTdia0REUTFSUkljdmdC?=
 =?utf-8?B?cE1CajhxQUpWNjBtVURGcU9lWjRnYWRnV1JueVRmcE01dkdQcHdoNHNrdHc5?=
 =?utf-8?B?MGs3bVB4ZXc4c2VycHZ4bEFXcVRHNGphclZnVmt6TkcvUVhtY2dyMHlzcHgz?=
 =?utf-8?B?K3VyRUpVRWVEYWJuTkVlQWhSQ2U1MmY2MUtxelZHcWxZU3hWM3VHZ2JIaHBa?=
 =?utf-8?B?ZmdCNU80cGFNdWRLR2J0Qit5TElWVnkvd21xSytoL0NoRXJsZWZjdmtLVWc5?=
 =?utf-8?B?NS9ML2VRR1hROWN4YVF6VUJJYkhpeVJ3UGM0emxVYzJDKzU1Z3M3dkxVY1g4?=
 =?utf-8?B?eGNIdjRDYW85UkxnQnlkY2hIZmpLUEhkL1oxNTN2NVVscEUvL0ZJQ2VjOTcz?=
 =?utf-8?B?UGN5SkVSQ1A5cm03Nlg5SnBveUVPSXQ2MzhuRVo5dlYzMXJXa1E5cGhHWk0r?=
 =?utf-8?B?RDZpeXIzYU95Q2dabm95Zmg4QTdqTVIxSjBCd2M3M29sWWpDbWtRYi9Hcksz?=
 =?utf-8?B?MkZHcU02N1FjZkt6NWpnVW95NEF0U1grREJwYzI4UWxOZkdTVkNFKzdBUU1M?=
 =?utf-8?B?R091TmFNUXlSM2dSOUpFSllDTDZTei9Zb3VNVEhzdHlDWVdmNm5OWDUwenly?=
 =?utf-8?B?VlhRbThFbmRHWng5TXVBNkRGUkhmM01RQ0JZc2Z5UCtSOHF6aURqK0x0a0lZ?=
 =?utf-8?B?RGpTZnNQS3J0a3h0THVreVQyMmZFblpqYklZTGlpejN2QjcveFBEeU4veWs3?=
 =?utf-8?B?L2wxcFN2T1dkajlFWkdrb0YrTU4xT0hhOGdkb3NVNGhYS2Rwc0haTmlnL3BB?=
 =?utf-8?B?WUtLNnF0OWM1OE5YdkVZU0NEY0hybmtOOFpFbjJiVXJWTzloOXdqa3pKazhs?=
 =?utf-8?B?YXlnWS9uOFdnSm9LN1dheUV3d3R3NHBuUUZKK3R4Tk9TM0JHRjRHU1IzVWxD?=
 =?utf-8?B?Q2M2c0pSMk1WZmw1c0JqR1pjTUdKbU4vS25NMGMvRUx1TS8xVjVIbVZLUVZR?=
 =?utf-8?B?TjQ0ZE5RYzZlM29HTDh5MGpBTXp6QTc0aSt3bm1kM1hMOGhmZUhGVGJmbXhG?=
 =?utf-8?B?T3lrblluWUFaUU1RN1VxL283V1JuVFMzUE1OTmFtODhDWHgrYTVsYjBydHVJ?=
 =?utf-8?B?TVZXOTFIV3g0WDRRQWFPUFhvczRBa2ZXbVV0Qk5mMXlmZS8rR3IyVFRlR1lw?=
 =?utf-8?B?TTdYY1A1T05EVGtyNjdYODBUWUdaNTdRbTJBUExISVM2R1FuSWJsT2k2VDQy?=
 =?utf-8?B?QXBBVFJRdzJmYkE1YXlXcDlTcUdJQ3dRTGk1cktuT25KUndLcFlEZTFnWDlw?=
 =?utf-8?B?ZzBWNTZkb1BtZzRFc2d3THpXTm0rL1Bad2Z4aDUycTRhWjlHK0xJNFE0dEkx?=
 =?utf-8?B?cUpvVE4vMit0WjhsUEh1M3p0cGRkWFJwSTRLYmlneXZQZGJ5WUZDWXV6UlhT?=
 =?utf-8?B?Qi9qK3pZNlV6SlZIY295dzNvZk1zMmg4ZlEvWWY0bGdEcTJJSkY1Z1JORkRL?=
 =?utf-8?B?OHhGTG9ia3p1M21HcnA1UStqcUkyaDgrQjJuQVVRa0ttUzhLS3J5YWR4bWdI?=
 =?utf-8?B?YU4vR2RjWWVvY1RTeE81Mk9haWxSZFE5RVpPemJQUnFZZlZvOVdxN2FJTVl6?=
 =?utf-8?B?ZSsrMVFKYTNCQWprV2Vwb3pyaGRVR3Z5QjBvUTFZelZKOVhwRmFDU2QxZUYy?=
 =?utf-8?B?cjlYSzJwVFIwd1pQQVZQVXFyQmZzckpIanlEQjhuMGdyRFpGZ01mYTVLQ1hZ?=
 =?utf-8?B?L2FULzUvQkhLckN3YVFtSkNqd0xScW1oTHJ3QWllKzBWS05UZmdyRjBpZDU1?=
 =?utf-8?B?T05pUUY5bGFPZWQxS0ZSU2ptY1l2dGs2VXhKVzljZmhpZW9XdCtrQVhVQ0xI?=
 =?utf-8?B?U0hHaER1Y3JpcUFzeElFcHVYT0k4SktxaTQzRGJaeXNuZDRoT3o0UmdYZ2xj?=
 =?utf-8?B?ekxRWUtoVnpkdVZNRHJDWE04YmQ2Z01XZFc2WVFMcVdqenRQZmpYQmkyaU9v?=
 =?utf-8?Q?s1bcQN?=
X-Forefront-Antispam-Report: CIP:51.107.16.99; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx4.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:44:32.5385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3075b2c-387d-4d6f-25d7-08ddae7f051b
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.107.16.99];
 Helo=[mx4.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0026
X-Mailman-Approved-At: Wed, 18 Jun 2025 18:03:24 +0200
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

On 18/06/2025 15:57, Tom Rini wrote:
> On Wed, Jun 18, 2025 at 09:15:54AM +0200, Michal Simek wrote:
>>
>>
>> On 6/17/25 11:23, vtpieter@gmail.com wrote:
>>> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>>
>>> In fpga.c, change debug() calls to puts() for important user
>>> feedback. In zynqpl.c, change 'up to' to 'above' which corrects this
>>> confusing or wrong statement.
>>>
>>> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>> ---
>>>    cmd/fpga.c            | 20 ++++++++++----------
>>>    drivers/fpga/zynqpl.c |  2 +-
>>>    2 files changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/cmd/fpga.c b/cmd/fpga.c
>>> index 9dc7b63db5d..2c2a63524de 100644
>>> --- a/cmd/fpga.c
>>> +++ b/cmd/fpga.c
>>> @@ -43,7 +43,7 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>>>    	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
>>>    	if (argc != cmdtp->maxargs) {
>>> -		debug("fpga: incorrect parameters passed\n");
>>> +		puts("fpga: incorrect parameters passed\n");
>>
>> I think all of these should be moved to log_err that you should be able to
>> control verbosity.
>>
>> Tom: I think this is where you want to go right?
> 
> Sounds right, thanks.
> 

Right I will amend accordingly in a v2.

I'm trying to compile now that it's more than some tweaks and I notice 
many (fixable) errors in the drivers/fpga files such as missing time.h 
includes, spotted by gcc 14.2 (x86_64). I'm on the next branch.

Is this due to my gcc being too recent or is something else going on? I 
don't mind patching these in case that's welcomed; let me know.

Thanks, Pieter
