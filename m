Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F52ECD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD6D6846B0;
	Mon, 15 Jun 2026 10:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="UfsT3oZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9747684704; Mon, 15 Jun 2026 10:11:34 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A75D83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3ftomb7KlGRWilAGrARr6LtY8vy1bRrUYB1C20L5tK4WCwMkZ9/Wv0QcMNDq0N0UYVTc6T9AIX6HtfExeXFy0JQFCz3R+IKNtThOBSQyaGOBSKzU7K6R+0diI9vrVO+A4mFeYTHd4GgqOu6QROEXbMg9u9VVaSWZ/5x2bEA7yuccl7WmCbQNJeSi9Uv3HPkVsR3CQhKSochOYUIi/VJF6xKs+ft1ZTmIonbtmfrfVTrOj4h7No4JOfP+9LkZWK+BTjT9DuVUzyt3itXvqlIHTqeETQAkTeFYtoG1ss5MZHG0qiGdcaMFOD21vJ62UlPU92iLmXkGTG2pUJp7LyPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC0c443xKDK+3ZChQiUcR/6PgwvtLyHr3lqukIV+uc4=;
 b=RAq09PlD4PU0Giwyv2qGyN2A/f0fEIYw0u1NLLqIWfEt2bu01NbtRDszqSDDziB53RbTqLj7yMKG8IF0WkBGsrw7iv9woeopvaHg8XzwAk3MRilHJCM8Ln3SPR90KYm30sz5+hfTNfk65X62mIq+C4nVc6tmBJ2zY4kIoNAgPZJ2nCSV4Qs2si8CRtlVgcBN6YdYe7Dls+OHT4LzuxA0qBWBAOE7CDCWWKcnZjydbawfWBTZtfzBFDn1qee7ECVKSniEK3do88FHEjyBCsKgmIoyPeEGQg4HipMlTDUt34+14p+qjOcQ1KWXaAAcPRvNBIV1zVL1aLmz95krk6WOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC0c443xKDK+3ZChQiUcR/6PgwvtLyHr3lqukIV+uc4=;
 b=UfsT3oZ0HmJRD9TOT6R9jnpNiUgNgyvQ7e1zNmpVZfhK4zwSeqDUC2rIejfY09r5t/SKiTpq9vz5n6WtzmRW6kASUV1CIT3MBIUMms6YsMSmaI8zXmP7AiOXYJoDp+ZlY1UisU0WSTzu91SAvkjG2ZPghv9PB8Wolv85JFxNfk9VeXInhaLmUH+C2XOfOqSGBIya7NHB60XZZtFzPemRYBnTF5dsPJPvHJLO9ay4eWMgpYttqTQbv0zIfEjCyVeACbcx3J7E2hUoc8uCtRXq7OUtPeAc8YXopxUMtMvTFMk74mlRaDONHVDZIDCamGaWggXt46qJhe4FrmlSehFrqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by FRWPR10MB9461.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:11:29 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:11:29 +0000
Message-ID: <89986fa6-c9f6-47dd-931c-03391d0b8f10@siemens.com>
Date: Mon, 15 Jun 2026 10:11:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <500e420f-ccad-4b61-b7f9-e4cb3ed8ac86@siemens.com>
 <CAC_iWjJO6ZK8RCmq4Cu1Z+pr-61m9idDVr2D+cSo0+ceBUviQw@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjJO6ZK8RCmq4Cu1Z+pr-61m9idDVr2D+cSo0+ceBUviQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0304.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::9) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|FRWPR10MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: af4c9e17-78e5-4fd6-0aab-08decab5b3cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 8fbUp1Y7TyQIh+PksUTW/repl5cFUUuF+5hMRjS2n/EWMtS0u0DiUn3k5PKXUHr3JahIiUK6RGLTxUl9Pp9b3nQuSgmP0B+qGpGeBh4kxrxVyFIVfC2FRxfp1vUvjTUqsNI1MWsJJPZ6X93QQn08bPI89AsPa3kqDC5guiXENX4rICd9pHbZKAG7OURecvfMMWuv2BDx99d1sei8ZRQYDIMe/HRLW/qR8xqPLnYRC/5Pv52L1XUZ2HMmaJv5TngQGh2Z0d7HL6TYxsdlTN4CUuBCsaB4WdD5G4MYetiX/p1D0+RaGtY7E1+hSApEcjePInE4jdTC9GFxPOJqLYjVBdeEWhZfAgdtkBoRsxWAGyYxo11m7u4MofLkPVwPzXd9tsEAfyqTgESa8K6BCqbzkVc3wm7PLV1Dd/SDZv3eyWNjCCP+f3OqURViSju5ZTY7YCuhiPiNFJ1nTDeFHUVAFU1wmmRdjNbKhANq1iIUCubh5kbkBtdFQSkYwW88DwgvHm6mCkAixQtsf2WPG5VUI7OKDd555OjwyOQ9qpjCEgKTnI7f84mKs2Fgdyz+6pDoUfCSy59K3r/Zk0ZQnUkpjAvaFHwVTplikVs+zBGM5T1xQsxiWiyJjT6Z5n+EUuf2jrHHxDh9IR7OL9O0PguFYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEp3K3V1akloM09qbGhDcnZHNUh5V1JEcHdsV05wY01rU3NFd2xHZE8vTVo2?=
 =?utf-8?B?ZHQvaFFLSkNzTmNIajk2RmxrVS9QOGM5TlV4WjVNYlNVVS9yZEhMWFFyM1NY?=
 =?utf-8?B?OHNmZEdjQ2JabXNLMHdsR01pakVXQ3J4Z3VpZ3M4VFFzMjVQSHRZdllWSDM5?=
 =?utf-8?B?MGhaWnFPN2VRZXg1RDVYOEg4b2VSdVpaWmFXa0IvM2Z5djJON0Z6clhtbHhR?=
 =?utf-8?B?UHVpck9GcUhwMkdhdFdISG4rUzBFaVBybGJSeDBTeWo3SEJpaFlGOENnR044?=
 =?utf-8?B?a0kxY0NrS2I4SEpZZXRNT0M1QkVjeG13VTV6L2p3c2hjeFppdVJMNjU5eUk2?=
 =?utf-8?B?cVUvei9ydTlBeXdUUW1kSmpnRXM2dGFweExmL05mRmR0aDRSZTVCNGFVcG9v?=
 =?utf-8?B?NFNRdG9DQVgxb1pxZlVZVVFqY2h5N09mUnFTOUpNMmhTNnRMd2p6L0MyVmNV?=
 =?utf-8?B?azdJZ3ROLzJUaE4rdTl6Z2hJUTVTR0xwRlJtcEdxNktqcFp0NmtYNDNUTE41?=
 =?utf-8?B?U2Y3cGRYZVpGV09IM3BUdEdtQ2grQlZaZVNqb3BhT2ZVRGNnVjN3NjJCVXZ2?=
 =?utf-8?B?MkhUMlVaaTd6Qk5XSlJvTUlMUjluemk4ZHFmekQrYmlZdGV0MjJIU1JrNDJn?=
 =?utf-8?B?VGpQMjZkV21teXhrNkkzQkdiRm41U01sZkR2ZXR0Z2RkQmIwZDFjbVU1VCt0?=
 =?utf-8?B?aE41L3BsTHVHeVBVVklweXBhdlMwcUQ5RUpINExkSDZLMFZaK1VMZ2NYZXZI?=
 =?utf-8?B?TXdQb0lML2MxeWo1b1dHaTAvektWdTZIN1ZEenpxNFBLa0hXVis2cTIrZjFm?=
 =?utf-8?B?eGY2V3FCZk5QMUdVeGVia3BEb05HZjFEZVozYks5bmtCakF1bExiU0RPbXZY?=
 =?utf-8?B?aUdXb1JnKzFsYlYzc0krQm03Q2VocDlxblVlSGZ6SEhrWHZpdHA2SitwQ21o?=
 =?utf-8?B?WW16cmI4bVhNV1ZIUmNDMmhnQVBkSVFMemJteG9vRjdsekcrVnZmV0JmWlhu?=
 =?utf-8?B?WmpQSjJDLy9rSURWMS81Nk1HdVVubDdYRzBOeGlGNlZoYUUzc0NYMVlyWEhV?=
 =?utf-8?B?bTQ5YW9DWGx6eGpibFZWajVUR3NRMDdZZXBVczh2blM1M0lINVFRWm5JdVMx?=
 =?utf-8?B?N1I5Q0lQY1JVNWc0ejcvTDh4V1dsQlZxRE9LaFdPRTVhcmcxVWN4bTFyOTZx?=
 =?utf-8?B?U21weHFpVkhYRFllY0VoVXEwYnV4a3lzRU0wSmxXSk52RE1lMEZobml1RWg3?=
 =?utf-8?B?bUZyTzlCVEpjMmNlVThrcUJaU21qMzBtOHNZRUFzZVJpdnBOb0ttdzBuQzhx?=
 =?utf-8?B?Q2dzS1RZYWFBeFFFZk84emNLMkIzNjZ6dWlKQi84ZDh0V0JFblJmS1IwUFRN?=
 =?utf-8?B?Q003NE56MkEzenIyNW9NZG50WlUrdElYN3pjSHpYbHFmWjRtU3ZSWERhYjk2?=
 =?utf-8?B?cTJpZ2xpVjRNbDV3T3lFU3FuQVNNM1VnUmZIWm1CbXNhd1FqZGZvVnZnbFJh?=
 =?utf-8?B?R2ZHQnpqdXp1UjBMRytyL1hFNVdjVWg1ZkpZYVJxelZIaGlKd2c0cmU2MC9x?=
 =?utf-8?B?cjRkTzgrN2dXSDBJS3huUGdNQUgvSlVvY2FaWDQvaFE4U0dtc3F0RnZMd0Zj?=
 =?utf-8?B?eVBqSFBmajdpL2pNUGtyenFlY1Z3aGJtNnFiY3JsQkRoOXZoNGRqeC84MERu?=
 =?utf-8?B?eHo0MkwrczRPL3lMRnAyS1NPMmxTaWIvZzVlbWNrcjZGR0VzOFBHeU1INDQ3?=
 =?utf-8?B?ZU5XSUFXMXdQbnBVZzhHTzltZkFXNSt3UnlSM2krbHhubmlONTJZRFBZUkpj?=
 =?utf-8?B?bWhadmp6TER4bk5kTnY0azJYMkNDeGZzUVd2S3loUWViRDRKRGFjWW5MT3J5?=
 =?utf-8?B?RnYwZ3BMWGVqQ3ZoTXdxY21tcDVqbUQybC8xTjcxVmlJVHFLeVJSWnMxbnBr?=
 =?utf-8?B?UDRpMVBkeHpqLzRFQ1FSOHdZWmdNSXJscUdEY25vMVh2b01iNmdRVFZhL3gy?=
 =?utf-8?B?Wk1lYWJCZkJ5WkNKQkVOS3JaU0EwMkFXNEVWNTFRY3pHZHJTUTFGZTBCK3lO?=
 =?utf-8?B?NWwreGhFL1FtWHlJdk1wQmRSQ1FCZk84aDRoNFhoV3ZudlZXeXFWeTREekZv?=
 =?utf-8?B?R1hkRlUxeTB2ME1rNmVOMVROekxOblJZb1ExTm1Fc0l0MVpGU2pmSy9oVmZV?=
 =?utf-8?B?TVdtbFdmNEpKUEFqMDB2SFFyeGw5b2QvMjU2TWg3aFN4RTJ3VGhMNkpVMklv?=
 =?utf-8?B?VGhvVzFBTy9RQWlKVFFGQ2hKMlRTcmdFYlZzejhRblVhS2tFQ1huU3VjcXAv?=
 =?utf-8?B?cnRMbmJSczAyejN5YVo4SEd3bXptWkFZd29jemFaL3pPM2lsbnNsQUxYQlZw?=
 =?utf-8?Q?GGiNRJoWhW5nBqcc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4c9e17-78e5-4fd6-0aab-08decab5b3cc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:11:29.0542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwYs/KxUhGpLEhdFSpmU02C6QV5xcMyrO7O4lJn1PdUD2FOZczLp/RVnDnPpNhJxxJzJjz5T5Ukz934I+tCts3YOdPMv4jwdu/aWmVOmIcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9461
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

On 6/11/26 20:13, Ilias Apalodimas wrote:
> On Thu, 11 Jun 2026 at 19:21, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>
>> On 6/11/26 11:57, Ilias Apalodimas wrote:
>>> The CI [0] fails with this attached. You can run it in github by
>>> opening a PR before v3. Also can you update the description and add
>>> the use case you mention in the cover letter?
>>
>> Done. The hardware tests are still pending but I've fixed the qemu
>> failures: [...]
>>
>> Is it advisable to file a pr in general before submitting patches?
> 
> Yea, it makes reviewers life easier. I will run the CI regardless, but
> it saves new versions just because the CI failed.

Ok. It also makes my life as contributor easier as I don't want to 
bother human reviewers with issues the machine can find.

> That being said, I had a lot more feedback in v2 than the one that you
> just fixed in v3. Have a look at the comments and let me know if you
> need anything else

Hmm, indeed. Sorry for that. I'm not sure how I managed to miss them. 
Will take a look.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
