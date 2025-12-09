Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE5DD1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 13:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AB183935;
	Tue,  9 Dec 2025 14:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="XZtYs9Xj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E7883B81; Tue,  9 Dec 2025 10:56:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20a::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727AC8003E
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 10:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuCVwsjX+asvyGPOwRLWLpYkV0PAUsUUXDd06sl1eoAO7j/Q31sF+xwMcgxyFO+US/5BjsOQEcHTzF48BfX1y9wcca3ylzGCB96OCRGGagf0+1538AY7+pqQQsEXfnkEje2Nx2oFOxHIg9IK1z0rnUAq3x4urhW+32gGbRJxjC2H90/hgv50GzWyuCBntszVWTWnU7zZuum+ErL17MwfHBahaiLHTjZY1vMT1I7g4Tyoucnjmxr4p4WgcK4DaZNyLM+/prUWine7Mitceu1o83MBM+Lnj7RoScuoQpiwTOKrtv60Gq6r5F6N2oMptQbmeVjO10lVjQEcsF+Q7PGjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psBrEK/5D/WEXc//TVue2oKi+QR2zPcrYkMudilzKmM=;
 b=HwMwg05ffP6YIl1iCazELcNXxTN79s1jiufimUDLXGmDOmSo43qsTYV97WwLHRqmaw6wPj8bXc3wyYWxrNvI53awkfFLMEIPMgMAuEM8dZNMyCh0Xu0YzlrqZr8Qb5Cpg1MzUm5EB3yAe3FD9BCtiBoJ6nHYyIQoIsnQjvchUfGRdTEnwKZqhW2Bwdqj6nH7m4I/tO8xkITKpgpajDTdIF5mEfOWGjh91g5VNqEICBV+rI0Zkgj0xiHielctEV/5iNCzSmEq9jsOZFkW22I4nA8C2SbCL3mYVb4xSsmYn/UBc33AxJNQV4QcUzyRSNkRGTz+jp2oDHG5hfTsVbnqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psBrEK/5D/WEXc//TVue2oKi+QR2zPcrYkMudilzKmM=;
 b=XZtYs9XjcMSwEiIYopiPY4zscReTBAyhQSB9e+XDoRzHvT/Xdq4UiUcnrl/G3sL2MIvrKi83Bg9cmYsh8XXAa6XXTSJW7M9fSLBSkxYd75YMSXWZX/f2fAxxwZVCPDR25HxlGX3LRF61siqWzXvqZ52QoRgYepQyiZPVuBdpY5iw+OLIF3zU0PD0MKUV24NdWue+FExKYYKy1ONCqlbBJDacYJLqzTRkrg/WTDjvK/nyWh51wn0j8+FMYQuYbO2T1jFsmp2H0dtjyHQ9SwetT1D0qe/x3HAEwFLIc//p4Gdj6HaNznXNH92Ih0+UZyPBvDRiOekBT/ZMupdycrxPLQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PA4P194MB1069.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:c3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Tue, 9 Dec 2025 09:56:45 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9388.003; Tue, 9 Dec 2025
 09:56:43 +0000
Message-ID: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 9 Dec 2025 10:56:40 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0248.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::14) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <e164ef41-efc1-4fdf-b5ed-e86fe9d4f8c4@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PA4P194MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 608efe71-2091-48e8-8b27-08de370941de
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0WzusccMzPyPe6gR5xzcBZFFPD49HVF+HqavBXB76gHHtVoVW9sRDD31cCgAxLD6IEnOaLazxBI/xMGB+KqbibYX891ydQxfjQsbl+L5LK4HNRxV8M3nnxFsh+I/FEeLpAIQvOYQlniPzAAJaUIpbGJB7ml+udKdNG5NukLznpflV/YzCNiIOHWrBK7a1AQsI2/7Ulms/8wMmeJz8yLHTWaI4R/QVWjyFiB7KRAdPOrUDNbltAf6uRwEf/7UfQcaj/6VqMtqvC0xA8IIg0lB/7YqNxPjFu7geCZn5IIAoMs5sePu1uuB0DtvYDkw6iFqQdmNwEUiLa8844w2XDMHrbHi8u3huWCKUyWxQN7MNzbd6vPhV/IN4kVzorinGXqhnD497Fdm15g+9UmYkpqcGwGduVvZu2yP+LK04bGdVs1YAu4hqgxO6ojF7DVttsu1b6wpOEV0PR+FQtz5YOcXr/FdspqNPhVf89ZQrpdpSOM7UWsi4fme/qlptF4xD4FeJ212q1gafkL76qSgdhXn5Cg/zKumVO54Y6ZzJRSHqajIcHmTwiDLNNfTuycgbOPUyaAzvX3vULRsFAW0broz6GMiU3M1l3tmmaAuRqDnih6K2W8a/zyEROiC0KT8UMQbSCi98BJHQ2L4NlEscgDDt5vDinsGfEr4/LmTnFm/z7W8Nrx3jpYbvRkjTGw7S/f8HL2+L7B315WZyjeFzVQQroqeHmNin7Ge4m6lMMh6Ix9Y=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|15080799012|6090799003|21061999006|5062599005|8060799015|23021999003|19110799012|41001999006|461199028|53005399003|40105399003|3412199025|440099028|11031999003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGUxeEN3Y3pIN0RmY0ZDYnU2elJYa21Uc2JUWXA4bytVeHh4K3ZNR0RyQ2RQ?=
 =?utf-8?B?cFBxUzdUZUUzMUl2VU1pbzhTU1FRMitqbjBVNG9RamRZMjg2bTVlSFpvb1RI?=
 =?utf-8?B?RHlaVTRScS9LSTd3S09zVVZRcjk3K0JSalRkN2JscmVVTlFtM0t5OWdwZ0Nt?=
 =?utf-8?B?VDdQY0tXZXkxNmlaMkkwWWpDSmw5OUlEbVJ6bzZiTnBFdEJmb0p2ckNUVEFU?=
 =?utf-8?B?cHJzK0FtKzNyZEJsaG9UVkxjajVDQ3hJVTg2K09TdUlNMEpQUDRiV0IyQWVq?=
 =?utf-8?B?RmVaSWJDMG9yTkZEeUZuVmlVUWplUTIrMzBQZzBWTHdITjZRMWpqQUQ1SHZS?=
 =?utf-8?B?UGtzdTZnNnpUbFNOVkZpcFJXRU50SXV1VVFCWEpndTJOOFY2aFA5QWdtN3Rs?=
 =?utf-8?B?eTMyMkRkTE1xZUlLMm1OYlFUYytqRE9zNWdzQ1B1V0ZwcmZhUDNZaUVYeXBy?=
 =?utf-8?B?aXJuN3VmNkJYK0RHS1VyQ0xqaDkwSVRnYXcrTnlBYlhuMXVjWHdSdTBvRXVn?=
 =?utf-8?B?YlQzbmFuZjRxQ1ArTTRFSzFjcUQ0Rm01dnZnbHphdnRuQlREMDRPWFlndnY3?=
 =?utf-8?B?MGVhR2l5WW5KOW5KNFNJWUZDS3BZK0R2ZlVHb1lxVDBnVmFMZ3N3MUFJTndL?=
 =?utf-8?B?UXRDcitrQTBXMWlMZVBZekhLN0w3VUg5azVxd2xQUkdNWGpKb0RqajZhRjRv?=
 =?utf-8?B?VFlPc3hGMHNBZlRlZW5KUkJCUGJWbUhubTE1SHkwMFVvbVFFUVRveGhLM0VG?=
 =?utf-8?B?dWNHRHpseCtHUlJkU21PSkNvdXFnQkFQdk1nZGZjMms4UE1wOTB6cFhZWmhT?=
 =?utf-8?B?b2RoVUhZQ2pXcjlndFdtYlJvOW1TTHNrclVCRExxREZvVmJhZnpZenR2MGhj?=
 =?utf-8?B?VzlRM2lZdDcyZk5LUXZzcHVydWtoSnE1U0NwbXhFOTRqc28rdzJEbzJ0VTF2?=
 =?utf-8?B?dmRIMm1pNjdSYTBCR2xmYUZMaHk4UWFXVFp0OHJuaXJpUE94R2I3a3c0VGw5?=
 =?utf-8?B?cjBmREovSHFIclM0QTFVWmcwWkZjYTYzTnlWbTlOa2k5bmVDWFhUT0FKTU81?=
 =?utf-8?B?WHFjNjBhS01sZXk0MUlHN1c3OWMvVkUwb21uSC9mc0JuTWF4N1dnRFJnMkVY?=
 =?utf-8?B?MHB4emxQOUE3V0FTS2xoblBwV0RteFZ1RmQrd2phM3FxWTlzV2RDQ0JacE9r?=
 =?utf-8?B?UHJRS0JrWUs0RTFBa0NDamR3czl4Q2MwQkVKYjk5QmhYbHVzOWNuTk56VFAr?=
 =?utf-8?B?bGs0cjJDMHdQUXIxNkdNdmNoTnhCeVdqTS9rU29DbWo4UmZGa0hHcHloMGpn?=
 =?utf-8?B?K3NzMTB2Q0wrU1drN2o1NUllMUpwZVMrYkpsa21mdnhycjV3ZW8yNVNjSVl3?=
 =?utf-8?B?bVNoWHk2VDF5bURGNDhtT3RweVMwNTVIRVlvQ3NVZG9QdjhXZ3RyQ21odmJm?=
 =?utf-8?B?S2ZiWjdLYmFBTGJtUnBQbFlaUWpzWE9IV2VBWi85OHdCNWdpUE5odWJLTjFn?=
 =?utf-8?B?Y0o5T0xXVy93d3dhNEJGVzdHbFZLUHFKM3B6cm1pVFl2azdGd09qV3FxSVg2?=
 =?utf-8?B?UzdLMndNa21COG03bkpsbkxPZU9MNzZZcGl4aWNuYkZOblhMRE83anI3UWR5?=
 =?utf-8?B?Q0RYZDNPKzFWQmpjRHVZdXpYbTNsbHZRK3YzZlZia1RrbnJ2UlpnYy9YMDVW?=
 =?utf-8?B?dkw0Q2FyK09FdUZYaUZnNjlYL01uajBKNGtncHhyMTM0a2hnb1lqWlhOancr?=
 =?utf-8?B?N1dhVndFdkZzcDlXUnR5N05qVkUzSmZ6WkZJWjlCM2laNEZSWlNnYk5ZU3kr?=
 =?utf-8?Q?CAaqTD7vTO3n9WJOuiZ2N9RNiq5QqlI1HXhHI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vlp6KzdIRm9pUENiN0J1Uytua3NFUTRkQU1vV0tocUlhenZDKzZhL2pRa3NW?=
 =?utf-8?B?NjBnMG1BT0RNNHRyVHJ0TkxKLzQ4a0hKdzh0R1hXVC9kQU5CRXRPN3NjanRi?=
 =?utf-8?B?aldSQmhjNWtOVTluZHFyRTFZMlI0ZU9rOG1Ld0M0ZWFHY0xNZGRpN2tZVUlJ?=
 =?utf-8?B?a01nYnBhbXY5OWFsMVE0QWdBL3JLSG1VY3B6NGNUNjFMZnFrQStxRlVjWnJ0?=
 =?utf-8?B?TlUzZHg0Z1lTUUkzR2ZHODh1NytYWlpIbHJMVXFkRzBhMFVxTUh3QXk5YnFs?=
 =?utf-8?B?U2lVN3pHVVN1WFhJQmFBV2VIRndnTFBzU2t0MGl0amVqUC9QMjRDR1BXdXR4?=
 =?utf-8?B?eE9EZERSN3BGVnNRZjlibFF1WUhKS0d0dnM0elhtMGM5YkZSZjI5MGtSeXFH?=
 =?utf-8?B?YzFwU0Fha3N1TEYrME5CTjlEK0xqMUl2R3BMMkF3WXJ3YURrVkNjWGF3S3VZ?=
 =?utf-8?B?eWttVmRBcnVGcE1hS1NiVWVaS3JlOFNJRlBiVjhTMUNvNmJTdmJUcnNSRkw3?=
 =?utf-8?B?UE5MeEw5aklWQUlNVWV2OEZ5Q0N5SC9RUUY0QkduUTVnaEFrcVJtUUtneDJY?=
 =?utf-8?B?UC92d0pyRHhSekxpVlgyVHJhamNzMDE0Z1lsS2dNWGZmWUE2VkZoSFRZeDBm?=
 =?utf-8?B?cmN5TkxhVFhkU1Qwdmg2SHYvUmN4ZmcxOFd0bG1Sek5ORUplMjhqbmUxbHNl?=
 =?utf-8?B?aWFYdXU1cE9lem1NUFhlbUdYVGgzcGs1MWxyU1k1cHNCZ2lpVEtYdndjSm1Z?=
 =?utf-8?B?Z2Nyb1R6MHVhT0lZQmRPNk1XcjhTQnFFWWphSmoxWEpoVml6L3JiY1B6U1Ji?=
 =?utf-8?B?UmdiWE10cUJ2bUJobEs0bEhEUXFMWXNTaWJueXQ3UUhCcGFuSlVIUHJBMWNt?=
 =?utf-8?B?YWpRdEVwRWJlTHRqbzFVMmdkbWlpMjkvTTVTaWxxUGNXWng4YUVIQjJZeHoy?=
 =?utf-8?B?RTdmVDJDRzBCMFFLcE9QYmcveUFFaTBudHFEQkUwa2gwczBaZXVGZlB3SWc5?=
 =?utf-8?B?Ymp1S1dYajhxZEJPcWFDQjhkZ2REaDhFYm9KYjAyc1dtOEp3N2daTlFCSXE2?=
 =?utf-8?B?a3BwMkttREpQY1hGZ0h1Rk16cjlRaGdYcTIwdnYrMzFBUWR0UGpUWVViNzhG?=
 =?utf-8?B?bTdOaDRLdWl0Z1N2ZVdmYWNuOWZSek5jc2JhdVFqZjFBVDVHZVFQNUNYVmR2?=
 =?utf-8?B?Rm92VEJuc29mL2w5aGs2V2pXNHVHSFVObWtDeUpPalJHd05GS1B5QWZVQk1S?=
 =?utf-8?B?c2dJNDcwNlFiRExBNXJtcmRoTFM3TU8vMHJWbkZFM0N2WkpEeEk1aGxsU1Ro?=
 =?utf-8?B?NEYwSFlreERFUW9mckhpZlhnYnJZZUpaenlibW9lMTZSOFVGQnRGNzl2eXd0?=
 =?utf-8?B?NTd2aXVNcC9TSnZoc1c1aysvcExkb3BFY1ZKbjhnVDNXeEpGZGVRbk5zd2RD?=
 =?utf-8?B?S1loVGFENytJdmlZRjNDZ3VhNHJpdlRFazVmVVJxK2NOVmEzd2h6eW5XRkpt?=
 =?utf-8?B?RUpSOUlDZzAwRkhYOXNycDh6U2t5aU9hZE9QYTcyejBORUVzcnQ1WDZuUDJo?=
 =?utf-8?B?MnUxMWErUjZTTk9qbmVaN0piVHRtMGU4NC9EV01laXB4MU1LbDZYNnJtU29U?=
 =?utf-8?Q?lx1CgY8TodYsbeemlRfLsCXt4ruFpnRWH5oHx2BJBzg8=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 608efe71-2091-48e8-8b27-08de370941de
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:56:43.7531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P194MB1069
X-Mailman-Approved-At: Tue, 09 Dec 2025 14:28:18 +0100
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

Free buf if spi_flash_read_dm fails.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/mtd/spi/sf_bootdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
index 017a74a3016..720faf51a1f 100644
--- a/drivers/mtd/spi/sf_bootdev.c
+++ b/drivers/mtd/spi/sf_bootdev.c
@@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
 
 	ret = spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
 				size, buf);
-	if (ret)
+	if (ret) {
+		free(buf);
 		return log_msg_ret("cmd", -EINVAL);
+	}
 	bflow->state = BOOTFLOWST_MEDIA;
 
 	ret = bootmeth_set_bootflow(bflow->method, bflow, buf, size);
-- 
2.43.0

