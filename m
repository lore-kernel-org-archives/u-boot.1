Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D2606A32C
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qt5bKwDf;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=U72QMJAH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA5B140654;
	Wed, 25 Nov 2026 18:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t7vrucgfjbZw; Wed, 25 Nov 2026 18:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F004440659
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630424;
	b=IyTOO7Lr4j1k9a/1nSEe4BpbH9fnroGYTzAzOijJxiWk/Ns+x29812FQSi+/3GQChOHI
	 CHq8egL5gin/J8EUWv6/B/qeXeyiIYF4uviW9k2JRAPY+CqdlNU6qZkmImJCAEwclp90Y
	 /8iKcXZMF0INfvzvIiM6S+Ct7EKxR2IIuQB4V2Vo5f5y5CpRXTzA4hp2ne8QkIlyU3tXH
	 feZbqvB22F5iTSlGtX1Yx7D1yugi3FW1xAva2E5qUbPNdhLQSNbgo/yjYxLOcLAFHv7DU
	 GO1+RdwSpZIQ+CNvtzEF7LuzYZ8smImaobU7NaEb/gqEdtm2gFf/9B9WmK9fnHEn3BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eCFKKLPTlPEMPWoFPiNhub68KfGsoeIspVs7mcLzU7A=;
	b=eg5GdFywOGujDLzbc6etS81Nrqd234vyG0qg6uM4e6GkOpLIgo2O2/Ip71Ulx3FHp8Gh
	 UvJ1rVx3xCKfxLLTtS9U3DhziQMBwRw3exaxaDpD8fa/2TU9eHKuH5wZSrjYOKxsidIMW
	 w/x4wEwNjr9/1eSaCCS3dKZ8r3rkonkJBiR7gOHsA+bNnAHEEcYj8ftAIkQbNCN9ozt9c
	 Lxqw7aKwhlDWsgwsvttC/+uLfaklolJWYifpEG9b5jY20cCw+PvMMnrukfokrEe0EcyZf
	 gYnFC46QBVIT5NMqhywgjjgr8AamoEshr3AyPGL2BoER0nBilVou94rfu5zfMMrG07w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630424;
	bh=eCFKKLPTlPEMPWoFPiNhub68KfGsoeIspVs7mcLzU7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qt5bKwDfdVRRCjNLapwvTl7JTy0muuD38AzKnp2IYQ0VevFBTiFNOY5aJwRYEgUT5
	 j8pTJwKzeTiCVb0MNWYFZ+fgOOevrhKpjiN01bT7ZCRwHFeg5zbqAeMWXeBAEwe6ED
	 ERDAACAaIEpOI79QqqJ5HLyRSev1UdNxF/vvZYtxS8VnqRNNwUKm6DwmIs24dq25xY
	 r3n1iMOdBFgUAlrVQr3ssoaWQHS1nSBam2JIDwt/xBsILwdfpONR0VIdZflUcLmIYJ
	 2vvqyJRNG+AmWBgznO05Cxz/ywz2oN/vw3XCIkppYqk2+2quotvwtleeN/MkT0bi8Q
	 HABivL/s5y+1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F004440659;
	Wed, 25 Nov 2026 18:13:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB83F26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD74840242
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 173tr9risLh8 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B28BC400CB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=U72QMJAH
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B28BC400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCFKKLPTlPEMPWoFPiNhub68KfGsoeIspVs7mcLzU7A=;
 b=U72QMJAH4Xoa2/o3sR92IzefyVV32PDcfewLsEPhNuTP4XtwU9/5QQ8Mtn0bxA1jyzQykVglKOUSLdYvzcppZUY0uHPJVQznxZQxjJEfXjXhHT8xECvgO87Bsp/p7fNg/hzJURRhnfOEXmH3RRbWCHrOEQFlyviOy9TZbnf+NTk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB451729.eurprd04.prod.outlook.com (2603:10a6:20b:798::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:43:13 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:43:13 +0000
Message-ID: <40c4d35f-d9e2-4ad9-8b59-4e0cb2659486@cherry.de>
Date: Wed, 25 Nov 2026 18:43:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/23] lib: Build xxhash in the SPL phase
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>,
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-3-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-3-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0034.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::47) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB451729:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e7b9e4-e274-41ff-b332-08df4b1b93f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|22082099003|18002099003|10067099003|5023799004|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info: 8AWJR0eHVIdx9dr0QaA6AhhtouVz1BG009rPwtQt0H3mq7IGaDildlN7dHRFNqkRjPa+MKIjiaYPGlm1RSn1ghbAQcDL94k4yxWSvXKkmwxILerbRfEi38yKCz3H4X1gISGa1fLwbI4bNrqFpKmxGivr9CC2NGbqVCetWdRn0XW51aNqvUP9IkI3rZ9qY1nsiLWm+KV09wKCruMILmE1Y97JQmftgpMlRJ0zRxS5Y+oGqnreWlWWtycCLxEvbCub8ohCjRGkiWP/sMBUNeLmfzHDc2AHYht+65VwPLngpAgGPN0EgwflawkGyxT88uXRhf/iMiDgY2dLStor9JYjD6ERNTZB1ohXaLkER0i9XretsfxEjK/pLAO/8Metd4UadPufydLBW6/9mqdItyTClzMIgsO6P277mdThjkuDzbVWE+5jfv3RGuxo833jJqPImUT7iyeGVJ2TcJ5JmcJuVraBaRjrrjdSBItigxJmBKL+7JKxBS//rQk/u0oWGYwtaptZt5yPVvmaE+UyCx/0gizpj9ALEVVwrwwSZ3Vt/GHO6+l3yTNjsuKIr/ixWBQxXHuh5u8XYpTsQ+bD1r3cLvJ5kt2CFnbWFADFc+bXQZifobHa4ptqNhrMWXwGXuztTTVFLh4ZC7aDVV8rmg15p7cWmHXK1RBb9wc9eEHAuewsN3imC17AVNS9izXI6s6S1XmAnFQPvSnCRXidfaPpgxYTYzxq4qcWNFsjlQLqMvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1IwMVpWRk1rL2xPQmVyQ0U2c1JmTTRxTHVZNlpLblUxUDNYUlJEQkp3YnpK?=
 =?utf-8?B?Vko1VDlsWi80NmtXWTJvb3UxZExaUEFIT0p5a2IzN3hHaEFvTE8yNTlpUm0x?=
 =?utf-8?B?ZVB0U042ZDMwa2VoNU5UVEoyOXZKOUZJUTVmaVpkSnNQUG9BN3g4RlpWNUp6?=
 =?utf-8?B?OE1WelNUZmNzczZOV3d3cnV6Sys2VGJ3SjBNZ0Zqc240WFdRTHFKcTFxOU9n?=
 =?utf-8?B?UCtHU2E5SmR5VnhFbXJXNVJ1U2xmN0pCYVB5WnlSMW1CRVcxUERmdmdSVzg0?=
 =?utf-8?B?MnFXdVdzN0o3VEh3cUk4TUdGcjRCRWI5Smg1TDhxWk1OSHFiOGsrbnhjZlkx?=
 =?utf-8?B?WGV6UVpSd0drNGlIa2pNb2E0NHdqWnBIVEhBb1BHVWUrZGgvUTFtUGMxV1Q2?=
 =?utf-8?B?ZlpRa3VjZ2tva0VuWjhYOFplRzFNRzJMMTBWbUVJZ3UxQkhmWnZLNHBaU0NZ?=
 =?utf-8?B?NlVmVzRBaS9BMEJrV1ZrelRqUld4YUxISmVpbEhGMHRUZGViSEVWMjcvSUxi?=
 =?utf-8?B?WmtKTUVvOERpQllITm9ZelpUSFROb0pyTjRhaVdrNG5MSFAzVUpMTHZkdDBy?=
 =?utf-8?B?WVFEd3pjL2llUS9Sek52SWpZUldYQXFXR3R6SlYwM3FJdGtnd2Z3a2swNzJS?=
 =?utf-8?B?bmVFM09XOEJscDNRSjlhNjFPV0RqdHJzbktTTjhGU2lVZlhlbTB3RE5jalZI?=
 =?utf-8?B?YTNkWUptMUNMRHp0OEljdWJYK2N0OUwwZGNKUnovTytCUHhWclRLR1JkSmZr?=
 =?utf-8?B?a3BKbzhuU1g0SFNka3U3eUIrSEhHb2RNajJ5US9jaWFqalFKUXZjMmJwcDdG?=
 =?utf-8?B?Z1ZKZFZSa041MTlLZWZJNTJDcGs0Z1RQNHA4emVIeHE1c0VVVDNpcHNyRjY2?=
 =?utf-8?B?aDlkTWw0aVVlUXJKeHdmd3VNVEpnK3lQVnp2dUtBVGZNTlhqSnllRmJqNUxH?=
 =?utf-8?B?Z3pjK2hQWThrSFg5Sk9TTkUrTHVOR0E5YmRNK1FTc0FuYjZKeTBQdUFTSS9Y?=
 =?utf-8?B?R3BSWGdzVXRlczE2U2w2OWszWkxXQzRaQ1FXelBsRnZ1LzlwZ3BJUlIvUlE5?=
 =?utf-8?B?VFlXL2VCV084d1F4cWJwTVNuYUNJS1doL3pqQXdkR0N0NXk2dnN5Mmt4RFZD?=
 =?utf-8?B?dGZyU05zOG1XcU5BL1JJRklhaG5WTWxVUnRUZVI1STI4UkU5dWVKTlNGdXhB?=
 =?utf-8?B?OWpOK1AxWjJSZ3NVQWRleGlMMW9PVXlUelBoeXdocmlaNS9NcVV1YnF4eUdP?=
 =?utf-8?B?bkZrb2xpK09DWk9IWXdtcVB1ZklmL1o0KzhsckZSTUEyd21QZ1ZBVklreUtw?=
 =?utf-8?B?bDJYbXNFSFJvSnhXenRibk51R2tLam02dVpmVmhjTlZXZ2gwL0RzbTJyOFFx?=
 =?utf-8?B?YmtraVo5MjBndFQrbCt2Ukh0RVI3dmx3Z1VEM2Q0TkNVOHZudEJRK1FJNTZi?=
 =?utf-8?B?NjhyUWVPWEFNYUt1R2JjQUJYNG9TUERzRHJ4ZXNNWUZZWjZ6R2VWcE8wcXFW?=
 =?utf-8?B?c1hHVWNYSW8vVTI1VE1EN3hMdWJ6ODhUQlVVSlFWQ0xma1U4aUg3N2pTZnRz?=
 =?utf-8?B?MjFqdEpqellZK0lzekFQSzdqVkFaWEFMWldjODdYdTZjd21RZGxCTnZzRXVk?=
 =?utf-8?B?VUx4MGtQZ1B1SklZUUIrMUI4Kys5eC9HNCtmM0JzWDYyK3RiZFdzdVV1Y1p0?=
 =?utf-8?B?RHZSOXBJelhyUzlnbmxtZ1lBMm8rUVd0WFVaY3F2YkdEdlR6akR1UHpPdXBX?=
 =?utf-8?B?OUNlNE1YUUFWenFZRVU5ZmtMYmx1WFlKcWo1M294bVlvUnVKNXBOa3ZFNDZX?=
 =?utf-8?B?OGU4OVhKcy8zb21LK0ZzeWJXdkgybFZ6dmRzd2I4MWJZUmZJSWt4bU5TVmR4?=
 =?utf-8?B?MUNlLzRLaVpKamVEYkZvM01PYlNuaEE5b1JOR2FDMUNQcHBORUdWL2dEREpy?=
 =?utf-8?B?MmtQRmd3RGhOakpMdlBabnhLVXZjakRpNWhCZExoUmVBeXhUVW03anh1TDVD?=
 =?utf-8?B?L0NRekNNV2RaTnRzS0ZhNSs4YWNST3dOaCsxMThCb005UENCOGpMZm5MUlFY?=
 =?utf-8?B?UGs5ekJ6blpiR2RzUkg0YjhOT1M5T2cvOTZRcGZHS1U1djQ2dmlIVGw1ZndP?=
 =?utf-8?B?dkN6NDd0QlRtRzAxZ2NBc3JyRDQvQUlBNWtUZGt2Z25yeS9XRGZoZlZNdVU3?=
 =?utf-8?B?SjlBa3hpeTFKZDFjWmNtS1Y4OWV6bkpwK2lidnA4UVRScFQ2M2ZWc1Y1MDFY?=
 =?utf-8?B?YnNKN3I5R011YjNzTlBqK2pmUlJmZkVFaTlYUGorU0E0dis2T0pVN2l1NzNr?=
 =?utf-8?B?dG84YlpQNjgrSHlUNStyUkkxWDdRb2NpcFp1NWlmei9hWERLYkNBQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e7b9e4-e274-41ff-b332-08df4b1b93f6
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:43:13.0887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf9A+FJU6DiZeOePXUJkrv0O/cUMl/SnpJsjawm1avH6/6l9U6TLiQlbGGat/RgPAFeU1pCwLGOaPLTJAyGWfm+1AFEBiYMqHX20VEY0rPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB451729
X-Mailman-Approved-At: Wed, 25 Nov 2026 18:13:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> SPL_ZSTD selects XXHASH, but xxhash.o is built from inside the
> ifndef CONFIG_XPL_BUILD block, so it never reaches an SPL link. zstd's
> decompressor calls xxh64_* from code that survives --gc-sections, so
> today the option only builds because nothing in SPL calls
> zstd_decompress() and the whole library is discarded. The first caller
> would fail to link.
> 
> Give xxhash its own phase symbol and build rule, the way the other
> compression libraries already have, and note in the SPL_ZSTD help how
> much heap the decompressor wants, since that is the other thing which
> may stop it from working.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
