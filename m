Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B740D6ACC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB421897C3;
	Wed, 27 Nov 2024 13:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TUMj+LHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2E2897C5; Wed, 27 Nov 2024 13:08:36 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7328895F0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImBGkhHjhUfWZJDgyWjJZs3hS4WfpDNp3ltVaq8QAXr+LNxt9x+skbP6D126A9JTTd0Wi1eW5INSvGW+zGRjUPsfXtckS4yC3lgEg7vmtj4raJkPJGqYBSSZe7kCJGoaywkqcKMSysh+8atUF+FePcQbkBSeqB93Z01ge6hFjaGFMyLRrs1+CLqYIakjV3Q1lL0WbAE/fizrZ9PQswF6QfehcRS7yWv5Jzk8aIbuhMqaAJvcISNIkSOImYEu1MerIx0i9Jx+BxhIR131rJ2+swvwbM713V4AtRvlztbdGbJYZy7bbHLRgsbERaPRsZVpu7RpxobAb2ZFifg9bYrCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXGqZqP+ogo0iV5lPH0LdLPn69tuSKiomOI4O/KCbc4=;
 b=UpEJEPpKZFw4BfQ4aI9/GmU34S1O1VpltE8msxEb6Rq5JyxBGwlrIeUZZxJAyUPSZrNxb+3gp9yZK+/knA5Rdmr5Jy7KRoMxEOQbF1geBe4ZdgC5thj3ZwpV1HCxE7m+PGbsp5wSSOWIb69xBxjANL9CP3ffgvpwfzybdhT34yih4xwwj4TT9pbH2cjs2YMaVGnDS82/iZMkS54lIMPetFSAqnTEabFMp2yeZf+D+VPvlR3AayWzgLTLMp6D0mlPnZKJHzK2SxEA7cIYl/zze4SOnxNBNqPIHYEe4FF8MDdUVufq7vp6cauAnRr6wyYVS2gyhMF7t5ZUmuudBjYb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXGqZqP+ogo0iV5lPH0LdLPn69tuSKiomOI4O/KCbc4=;
 b=TUMj+LHmZtfPKjg73jzrpC/zn5qIIQB9BN3DsFc+pj01eqgKG86Z5XvJN9Juovvt7+Ce4oK72jYbL9ob9BGxdjSGP7Io6IM5KzeQ9h9/knosOaxRU+jg6eH8bQuB7EAEhG68ucr/jQw79xJSaCdOATvoqESR75VRv2eCiSF7VDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6947.eurprd04.prod.outlook.com (2603:10a6:208:18d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 12:08:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 12:08:31 +0000
Message-ID: <64ede47f-42e8-4205-b78e-35eb69352b0e@cherry.de>
Date: Wed, 27 Nov 2024 13:08:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/39] boot: pxe: Use bootm_...() functions where possible
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-14-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241119131844.4078144-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 465a35cb-0088-400e-0538-08dd0edc35c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nkw4QUpqZjVsTmwxVFhqNkllaDYzWmdOMTc5QXhXbHAxWUNYOG9vN1BLS0VR?=
 =?utf-8?B?M2dObHhLRHBTSmw1R3RyN3R2STJsWUhESUsrYWN2elpuWm9Zdyt4V1QvQ05J?=
 =?utf-8?B?WnN4UFo1aTZyYjB3bU4zSkxUMlpVZkVEUnAxZ1hoeVl3N3o2ZmFERFVMNm1J?=
 =?utf-8?B?NTBadHpxeWhEdVNSVVkydkZQU2J6SGtlTkhjbkpDZmlmTnl2b09SbTBhUXhX?=
 =?utf-8?B?MExqR3R0bzdBRUV6N052RDNiU1RtK24vaG5MRVdsNXZsSExvelFYOFp4SGNV?=
 =?utf-8?B?dTEySWNSYURZYmpnMFRQS09ENmdwa2FoVUphZlpSQTNFZnJIbjFSZEErTi9o?=
 =?utf-8?B?bEc1VEpMVCtmRHhaNVNoNkdmWnhIRXQ4WWREV2ZGWWVWTFZRNjh3OWppVG5a?=
 =?utf-8?B?QjhyNm9vVVI3SnlRWkR1MlZsejJmNmUwQVlaam16dGxlbVZmWmpQbGlJSzNS?=
 =?utf-8?B?dnJGRlowSDZzT0k4R3JQRzZvcUNsd3hxTkRsZnlubG5pLzFxZW50dm1RL1pC?=
 =?utf-8?B?OHZZZjE3YWcrcS8vUk02QUNxb09YbFhuUjB0aDJ2RFMrOW56V2hhUVdoNmhN?=
 =?utf-8?B?UU5BenYvUmsrYXNidXV4VmRpMXAzN29iVDkwNGtGOW9tOVhKcHhXWm5vdkpY?=
 =?utf-8?B?UWsrQ1gyOCtXUE1WUUhMUEUxM3ZHZmRSYWR0N1d4OEZHcTJLdmZCT2pDcHda?=
 =?utf-8?B?N1F1MjZRSkR5ZjdIR2ZicEN5d3pvTi9PcHZqamxKbjRNY0xMTXIxQjFHdkZD?=
 =?utf-8?B?SXd4cW9tUjZTRDZxbEZSa0RiTU1YaFNMNmV5ck9zQXlLdktnSnRkaDNlSVhq?=
 =?utf-8?B?QXJnNnRncW5uaTJTa2hlQmM2TVI0Vmc4K2RFK2RRMGZVbXBxaWdKZUtLMUsv?=
 =?utf-8?B?R0I2Z3JXcmlDZHpwRGFCb28waXBhbC90eWFhVFJIOUhLa1h1SWdRYmxvaUxC?=
 =?utf-8?B?T2JpNjRDZmRFUi9raE1CS1MxWTBTVk9Pb0ZpRXhsTDZ6Z21sQUNPajZFSTFm?=
 =?utf-8?B?c09MUFltcGg4cURieEUyUUE3R3NqR2t1SEJTU1lVaGNpTDhyS2U5YWZDY09Z?=
 =?utf-8?B?QmYvWFZOMUlKZFpiZkg5ZTdUMHBodmZxUnZLUzc1Mk91ZGNYejhpeStyc000?=
 =?utf-8?B?QzlCL2xPWkRCY0E1WmpzKzNOQ2FvcFRGaWY3dFM2WXZKayt0SXlHbkFjNTF2?=
 =?utf-8?B?d0Nxay9oWXpCMjRSbmJoR0QyUzFUK1FROG9jM01iRFNLNGh3ZU5IdWhwSTMx?=
 =?utf-8?B?cUhWQVd0Q3g5TFdLUXE0SXRvaUJqWFE5WHRQV21xR1RUR2t6QzRGdktVZk4x?=
 =?utf-8?B?aTd3cktkRTNReW1LUTlaSkJGdEVPc1BpdFdCTUlidVhZUEFnNmN1UURleTRm?=
 =?utf-8?B?bitaYk9lNkNFYjFuR0lzR2tkbG0xNDFwZXBWR3lhZWdmY0gzTDVmQXZDUUpk?=
 =?utf-8?B?UkpvU2llcUh4NXNXWFg1a0Y1aVBoTWdhQnJGUFVkYXc3bmNXc0xIcm5UUnpl?=
 =?utf-8?B?NFowUmtBdEFqdzFIdXZZZzU3VlVpQTFHS0k2ZFluRTUzekJNZXhIWUhHRnRS?=
 =?utf-8?B?V25CSDRlVWhWN2locEhVVkVtd1FybU1wSkFVZkt1MXJoN3Y1SmhXQ1JGelRt?=
 =?utf-8?B?eDkrTnhqN1BNWUxXSTZIS29Sbm5KSDJ2SUdmNHBXT1g0U1ROQjBYM29KWTBD?=
 =?utf-8?B?V1AzTlV2NlZTUFVzaVRCaXowZzdmdEtucmd0ZE5TaW1FUTJJNkFPNThSMld4?=
 =?utf-8?B?d3p5MzF5QjVaWXMwWEhTak92VnlGUFFJZ1F5WXJZZ0FnSG5xTUxUMHAyVWVB?=
 =?utf-8?B?Zks0Rlg0d2dxeWFvMjFvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdJN1I3RC9FbVd4WHlUQU9HajE0U04vQkxKcEpIMmVqM0F0aGd3ZjF1eVIw?=
 =?utf-8?B?eXl4ZHZWR0E5OUU3MzF5QWFFS2pudk1mSmlSWHhWdlJHK1hoK0xpTEM0Tm5I?=
 =?utf-8?B?bld0VGdCS3Jub2d5amM5RmJ0aFlOQ1hFSWptNmVOWTJzNFVHZWIzZ3dHaGRO?=
 =?utf-8?B?WnIxTGZlcjlxMzFQd0dXYU5vWUt2Z1hqQ1ZLaTM5ajdaazYrcHN3eFFkVnYw?=
 =?utf-8?B?MUpwTi9hVDlEZHk3cmdUUlJzazZkcmhFV1BXekZkdWNlcnRBdDhUV0hMc2RG?=
 =?utf-8?B?OXloQUxrOHVVMjVpdFJYUGMxeVlNUEZzMzJjK2RNRGlUTWJWQnE1T21mR2lL?=
 =?utf-8?B?bkNlcG4xdHo2N3BrclNKaU5UZVdLQmZPT203eEJ3Q0xjbVZ1Y285QmlJcTYw?=
 =?utf-8?B?UDR0OGg3NnJBaGxzUWwxNXczS3Z5RXhFYVNVS3FyNllWT1pjSUhvd2pSb0pj?=
 =?utf-8?B?RTMzaGdpZG9FUUR2RUFQMXVhbloweGhoRjBwZHZHRW9OSlhWSXRsTk9XRG1o?=
 =?utf-8?B?VjlnL0RQZmNRQVlPQ2RYdE5WenFSV3V4TWFBbEd6WTh0dCtYTUhHVXRkanNy?=
 =?utf-8?B?aWJaaVlLS3BTMmFUZTBhejZOOGluR3dFcE9KbHNQUm9HMXk2K3k4L2NnTVJC?=
 =?utf-8?B?aC9jeGpJS05KVFpTU0MySmE1dllkZ2VtRm5lR2N4eDVxUWpPdVMrOTA4b2h3?=
 =?utf-8?B?a016UmhqZ3RlekJQSktYSytLZHBRYThvblhKajVYQ01oTGIrcjdBdjNvQlJR?=
 =?utf-8?B?dXF0SlFWUi8yNzhramc5NFExWFVBOS9sRERrTWJiOThRNlBscjdZTzVGMGV4?=
 =?utf-8?B?aUNhYkNzYStielF0UC9YRTNab2s1ZmRaeUhpT3F5ZldVYnQ4bGVSamx6a0Js?=
 =?utf-8?B?TFlmamQzTDlyQXIxNFdzaDVBVHVJak9uUEYwUjdvdmwyOWRHbEwzSGNTRHZ6?=
 =?utf-8?B?d0x5T3dUZ3hVbW9PbmxPYnBkVkgxMDFOdXB2cEd0cXVOVGJNSzIvZGd4OVp4?=
 =?utf-8?B?T0lyaUhvU0gxWjRuVFJhU2h2VUJtbGltRTR5ajltNFRHWG85L0cvWVBaRkFM?=
 =?utf-8?B?Vm5MZGhpdnNub21MNU95NlVCT0Mva1k5UzUreTBaTGdZajcvRUNuZnNkRjUz?=
 =?utf-8?B?M2NHSkl2Q0szN1hiUi9BVjNGV05kdXpwQnlTdFpyUW8xVGVteXN4OVBpVWdX?=
 =?utf-8?B?L0RYcUhxWDhOZFcwQ1ZpZDJRY0FCdmdjWXE0Z1Z1TGN2d2xXYXFONEJBaUhq?=
 =?utf-8?B?ekdqVHBRdG9GNGUvd2QxR0tMNGV5V0FTVmxnVURsZVhRamJYbExHRWxISUVw?=
 =?utf-8?B?bmZibG0wZ01lSGFjeG1lK3RVZE5TRTQrQ3RJK3R0Njlndm5XU0tiRWVjUDRD?=
 =?utf-8?B?ZytiUFFGTDJ0blA2ZEgrT2d5cTZLbUNXNVBLN1VsakgzcGZScXBVTlZpQlJo?=
 =?utf-8?B?NnFMS3E5djdWWDBwNWhlRGM0cXFHVjJVUlJ0V0dMczQxTEN3UEhhY1NEVG1v?=
 =?utf-8?B?T3g1NldzRHFqV3dNZlVLa1ZMYmphZTJ3N0tpRDZBa094THA1MlpFMk9mLzc5?=
 =?utf-8?B?cS9LbnNJQzM4ZmhlTU8wRS84eTdmZ1c4cWNzcUhSSzBpUHltbUN2QlVvSTVz?=
 =?utf-8?B?M0hKTHVCaHpjS0tBeDhjeXA2MGZYRTdqOGVYcFdVV25aRnhra1RKenVEQ0hB?=
 =?utf-8?B?bG03b0NJRlZuNUtrYlBlR0QyZ0pocUxZTVEzVnIya1lpUTVTZWkzOGZTWVVG?=
 =?utf-8?B?Y0o3N2lUdjJhU1FvNkx6OVBqL3VoWWlYNmlMTW5POE5JOVdKYU0rV3diaE5P?=
 =?utf-8?B?bFVIQ1NIZlF2Z1ZGazBYa0xqOWUveTVqaldYSTVubE55R2Q1ak9zcVJnWEhl?=
 =?utf-8?B?YTBGcHN4NFJwU2szVVRjL2s3Y3BRMnpNZFZZc29CMENRTVQrbTV0eldkNG1x?=
 =?utf-8?B?eVEyNWlHR0crVEN3Q3hwUHZxaVd3eUw4cHhiKzNPek1oT2lOQ2dqQ3gwUzkv?=
 =?utf-8?B?aUpEcDZVS3NpZ0pkOUZBWjJzTGxpUDR1Q1Azdmc2Y0YxbEpuS014VlZCYnd3?=
 =?utf-8?B?NGNsOWdzZkpYd09ScW5VR1NuVkoxWnBHMHBDajR4QnVvaGJ2VnhIRjY1ZHI1?=
 =?utf-8?B?K0srL3dFWUdyK2lzTWNNZkRkRUJaYWd6VHl2YVV2SDhma0dnTkNaV1VZV3Yv?=
 =?utf-8?Q?HTYfJ/mLjbLiTowebhSzY74=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 465a35cb-0088-400e-0538-08dd0edc35c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:08:31.5485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ93l0OHYPbsgV15MbZDd3O+P4n9rw62+VuLFdrm1gv5vSSLZp+UKj9kS6/f734M0ppSnB4fdEJ0WTlpRU/XWTcJUgIO4odogsWL7wEWtwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6947
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

On 11/19/24 2:18 PM, Simon Glass wrote:
> Rather than building a command line for each operation, use the
> functions provided by the bootm API.
> 
> Make sure that the bootm functions are available if pxe_utils is used.
> 
> Since SYS_BOOTM_LEN is not present for the tools-only build, adjust the
> code to handle that.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   boot/Makefile    |  2 +-
>   boot/pxe_utils.c | 43 ++++++++++++++++++++-----------------------
>   2 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/boot/Makefile b/boot/Makefile
> index 43def7c33d7..9ccdc2dc8f4 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
>   obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
>   obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
>   
> -obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
> +obj-$(CONFIG_PXE_UTILS) += bootm.o pxe_utils.o
>   
>   endif
>   
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 66f82d3fbc1..2517999d408 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -7,6 +7,7 @@
>   #define LOG_CATEGORY	LOGC_BOOT
>   
>   #include <bootflow.h>
> +#include <bootm.h>
>   #include <command.h>
>   #include <dm.h>
>   #include <env.h>
> @@ -461,7 +462,7 @@ skip_overlay:
>    * Scenario 4: fdt blob is not available.
>    */
>   static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
> -			     char *kernel_addr, char **fdt_argp)
> +			     char *kernel_addr, const char **fdt_argp)
>   {
>   	/* For FIT, the label can be identical to kernel one */
>   	if (label->fdt && !strcmp(label->kernel_label, label->fdt)) {
> @@ -584,72 +585,66 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
>   			  char *kernel_addr, char *initrd_addr_str,
>   			  char *initrd_filesize, char *initrd_str)
>   {
> -	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
>   	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
> +	struct bootm_info bmi;
>   	ulong kernel_addr_r;
> -	int bootm_argc = 2;
>   	int zboot_argc = 3;
>   	void *buf;
>   	int ret;
>   
> -	bootm_argv[3] = env_get("fdt_addr_r");
> +	bootm_init(&bmi);
>   
> -	ret = label_process_fdt(ctx, label, kernel_addr, &bootm_argv[3]);
> +	bmi.conf_fdt = env_get("fdt_addr_r");
> +
> +	ret = label_process_fdt(ctx, label, kernel_addr, &bmi.conf_fdt);
>   	if (ret)
>   		return ret;
>   
> -	bootm_argv[1] = kernel_addr;
> +	bmi.addr_img = kernel_addr;
>   	zboot_argv[1] = kernel_addr;
>   
>   	if (initrd_addr_str) {
> -		bootm_argv[2] = initrd_str;
> -		bootm_argc = 3;
> +		bmi.conf_ramdisk = initrd_str;
>   
>   		zboot_argv[3] = initrd_addr_str;
>   		zboot_argv[4] = initrd_filesize;
>   		zboot_argc = 5;
>   	}
>   
> -	if (!bootm_argv[3]) {
> +	if (!bmi.conf_fdt) {
>   		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
>   			if (strcmp("-", label->fdt))
> -				bootm_argv[3] = env_get("fdt_addr");
> +				bmi.conf_fdt = env_get("fdt_addr");
>   		} else {
> -			bootm_argv[3] = env_get("fdt_addr");
> +			bmi.conf_fdt = env_get("fdt_addr");
>   		}
>   	}
>   
>   	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
>   	buf = map_sysmem(kernel_addr_r, 0);
>   
> -	if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
> +	if (!bmi.conf_fdt && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
>   		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
>   			if (strcmp("-", label->fdt))
> -				bootm_argv[3] = env_get("fdtcontroladdr");
> +				bmi.conf_fdt = env_get("fdtcontroladdr");
>   		} else {
> -			bootm_argv[3] = env_get("fdtcontroladdr");
> +			bmi.conf_fdt = env_get("fdtcontroladdr");
>   		}

Unrelated remark:

This could be shortened to

if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) || strcmp("-", label->fdt))
     bmi.conf_fdt = env_get("fdtcontroladdr");

Same for a few lines above.

>   	}
>   
> -	if (bootm_argv[3]) {
> -		if (!bootm_argv[2])
> -			bootm_argv[2] = "-";
> -		bootm_argc = 4;
> -	}
> -
>   	/* Try bootm for legacy and FIT format image */
>   	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
>   	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
>   		log_debug("using bootm\n");
> -		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> +		ret = bootm_run(&bmi);
>   	/* Try booting an AArch64 Linux kernel image */
>   	} else if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
>   		log_debug("using booti\n");
> -		do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> +		ret = booti_run(&bmi);
>   	/* Try booting a Image */
>   	} else if (IS_ENABLED(CONFIG_CMD_BOOTZ)) {
>   		log_debug("using bootz\n");
> -		do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> +		ret = bootz_run(&bmi);
>   	/* Try booting an x86_64 Linux kernel image */
>   	} else if (IS_ENABLED(CONFIG_CMD_ZBOOT)) {
>   		log_debug("using zboot\n");
> @@ -657,6 +652,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
>   	}
>   
>   	unmap_sysmem(buf);
> +	if (ret)
> +		return ret;
>   
>   	return 0;

simply

return ret;

?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
