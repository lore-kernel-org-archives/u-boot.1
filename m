Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB5606A33A
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gXosoPIH;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=WpA1M97a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05C5980F77;
	Wed, 25 Nov 2026 18:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OfPLlvLV50fy; Wed, 25 Nov 2026 18:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3BC380E8E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630422;
	b=afDGqhbH2bmGKr3LMWW8nrV+QiAvDyeSz3FtTmxKwyRkqJSnSdk6rsmo3+h/LLB8k3hH
	 Hv4fzVR98eF5o3Phe+UfJelxlSBCrHll/v5lpP1bxD+YNSlvIMCxcv/e+HqGvqxqHRkTN
	 fGg3sPd3ou/WnYowsaGzfe9bVeHZmrsdOsWA+NprsZUo1cb25YEk9WtFwL2xoADj1edWB
	 jxmWXlEdQ0p11vmLW+LWfOt0GrAKvfN0vUZwAcL3fFqhV34WwBbo2aQ94+moPFmDah9kT
	 ZsAg5Hwnp/Wwj/zvnC9RthQxO5MwoyaGrUfmGlyAcbgJ9eEdt76+FxkBxa/ZUvzuAlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630422;
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
	bh=yV33uNuJg2NyNbDt7YJlwyUnCDYP13pA075JaX1S9qc=;
	b=LpWR1kpc+dVl6/GIntuuW+9Al1vCUgJhjWss9oMC9ckA/+MHc815ZO2Wvokb9JA4Xcvj
	 /jFmu79MC3x/VfYEfi3iqjy7bmNmzfK1vdfU/d1Gya0P1zoEKMCG8VxCl4DlaLzvPqzix
	 gxQlRgBQhcwc3ms7xuRokb4DIRC5c7bYzsG6e6ZHolq2OUPpeZ6FStPRK2urdiopFpfH2
	 0oLJsE1jU0MhqJvxT1qYv6/gNTWe19fh2BfFlV3m+eo+2PR/mg5AZuJFpbK4HkpH+86Ss
	 hkDalsnoqD7MPzuyp5Y9zf96IQJd+7sICrH1NI4Df6HxmAjyRaXkmJqJIlxlbz45OPQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630422;
	bh=yV33uNuJg2NyNbDt7YJlwyUnCDYP13pA075JaX1S9qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXosoPIHBud6hJcXpcUqSfMozWAsoiPKVeSJcJmEr3hF5IjAtNp4R9OGGExvd39Th
	 YTBHNuX6uQkrRBCh0V0MPELlQ5K0nURRBvA1cQcXptPM46v4u3AQ10U5wQKnpVHUbM
	 FAdI4BNYS/rtgczQwzHajXNAlSUrFSVAbRzGvsM1zalJOI9TPy8XsDrl05ta9C4x8S
	 88T1x35KZ773M4tSDBGoPlkHozDxGo9ykHdi0ishxuYNijNjfH+eAN/eEelpgJf4ga
	 sG/9sASgTfu1eoXlIL/ZRkcN8zuFITlJPTyRsO8PjjPCRC5gGY9fYG062MWyfusFno
	 as9ZRt0wLGcPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3BC380E8E;
	Wed, 25 Nov 2026 18:13:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 398AB26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FE0A6066E
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZ7C_Lv6MHEj for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 55B17605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=WpA1M97a
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55B17605DA
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV33uNuJg2NyNbDt7YJlwyUnCDYP13pA075JaX1S9qc=;
 b=WpA1M97aXF//LFRZ0onHVj0fVruaks8IswXOsMr0Tf6fHLFCys8KyiZRiSuYrVvQgiZVoiKZNMNJuO5xVos4SDdtQ34OF2Pym5gW+HlR78Skfe3QEIoZyiAFq7BW6gv6MmQeDENmlri/jXSpWrMDwRkqPpGDhZ+o6fMS5PqHu6A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB451729.eurprd04.prod.outlook.com (2603:10a6:20b:798::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:39:27 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:39:27 +0000
Message-ID: <874b5588-bc5b-42ea-a5b4-097b5bd871b3@cherry.de>
Date: Wed, 25 Nov 2026 18:39:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/23] spl: fit: Stop reading the image type
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
 <20261020-spl-fit-compression-v3-2-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-2-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0086.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB451729:EE_
X-MS-Office365-Filtering-Correlation-Id: d725d5cf-ef50-4988-506b-08df4b1b0da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006|261102123227099003|261022115727099003|261021121427099003|261022075727099003|41080700001;
X-Microsoft-Antispam-Message-Info: EOwN/00GeOcOfIEu49GJDUS0Ywne6Dt3rzk7tDqAAQg2r3Q1O9AAtxmD1TE+WB5jbaJLiJvCQ7siW39BN5xmn0Ere2pzc40Zn21Zvf/jO9bqHZKJs0i8mZNaWN4PBGv7h4f0cM3x5jQF+Ga9NRH6Xtk1Af9C4SL3w1/ZZWt0fWEIwONYmo9KOSz2R1R701CXAJCHseV71uFCCHoDuMXej0peVx1uv8NGig4c1huyGB5b93ZVWgdhcSbswGkFF4mLQexEWak6L+q+wwzzUyW3k+t9Jt2RneoDdzdTcb3iSObJgc49EoL1tcHmepiL2qaKNtqLl3BcTVx/OeHE19wLMVCustGze1GrgFF2jdPkXa1LvmctAZOuXdmXrX0hR6Cuk5vI9TdX5ZGZfKzakuFpezCaSJ0W/rBWMohuWxvAimgDAxia3PjCI/cT0yf0k8sSfhh+pe2gid39vUFtBaOJw3FHoKCGOJIVq0Rxfuo9EjDrRqQZthFAilQ2j7Fb4KSZztpJn664SkS2MIGqPtilaXm490C8pg/QU8Q9b0Rn7ZW9omk9EGtJr+EDAHsJCiJSsVHjKC26tMvhsnmhS0iW/rvGB1WsHrW7cJNQERQrmOCuE88ZGBYK9sC4px0oJgpGFMmpTfvxz3/W9axGVMX5MbwJmbGpby79FTbLEtKhnvFvMn74drBcsmjKAWhcEAIIlo7uCdpQvf61QzPG8cRxPXGYAtG1M2ckn3P9Gj200RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261022115727099003)(261021121427099003)(261022075727099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlwaXVuc3Nrd1FTd1dYL1J5bHBFY2xkckNuOTN2T2l5QTBYeU9WUFhCSUdU?=
 =?utf-8?B?M08yVVFseUE4ZEdXQkE4SG9FWmt6U0o4RktYTXdoRHRvWFBqdWFpMzd2Rks2?=
 =?utf-8?B?RDU0MjRpdkc4MkJXdnpya1F3RGM3amNIdkxmVit6RDRYdDdnWFhQcWcrdDJv?=
 =?utf-8?B?L2xJYW5wTnBRRDBlWlpBaTk3M2V3S0lIUkxMdUxmUFV1Ykt3M3hQeDlKejJU?=
 =?utf-8?B?c3VsdU1yTGdGN1k1MzY5ZzAzU0ROb0ZHNU9aQ254b0dDT0FSNWcxRFVvbGlO?=
 =?utf-8?B?WDlUVDYrcWRUeTZaOVNsN1JURW9BVUJmSGVpaDJVNFVVbVZBYU4vUC91RXNF?=
 =?utf-8?B?RjRlbUVqOGRsMjJvamVsNkNacWd0ckZlY0xDODZIVy81Uzc5QzdWQ3pkQjZr?=
 =?utf-8?B?dnFIbmZZVUh4TW15MERBdDlEeFcvMVNtVUpnRzVleGx3blZXdGk3QW5iVWd4?=
 =?utf-8?B?MStBak5RT0pjTm1pUGw3TWRSRVdwdmNXcDJZZHB2KzJjTVJQYlVYRG9PaTkr?=
 =?utf-8?B?STlvZGYyVXF6U3V2cm1kdlNsWXhtRDhoaFdOeEU2dHRpV1J3eGx6OU5UMHZv?=
 =?utf-8?B?YzF4SHdqeEZrTHhjZmNvTmJndW5tOXQzQ2JCdmVlRnViVUYrWWpuNmViUllZ?=
 =?utf-8?B?T1Y2TzNlelA3dWRzS1lJUDhjbVdNbUcwd3pSYVpJL2RkU2pzU1JVL3U5ay9x?=
 =?utf-8?B?WVVJM1puZ0JrWHZTNW5QdkVrbXVUcFRyZnR1Q1p1eFU4THY5VjJmK1hDUnJP?=
 =?utf-8?B?SFJiMkUxQnhuWUVIOEY3cXgrK1l0UlR6R1BHT2ZWSzNHekRWV2VGWUpXMFpB?=
 =?utf-8?B?RHdndkhXMkZMOFhWbXFBMFh5ajhNeVVDdDdXLzExaFdwTmxMZ2xQdnBnZzVl?=
 =?utf-8?B?VHNuMFc4OXRCN3JMcUYvVlo2NXoxVC94czh6MzJNWUZHbXU4V25rQ0d3U0Nr?=
 =?utf-8?B?aGhmOWIxMXFrcTg1Yk55RkxMczJHNlFEOXJEbCtSbUgxMWF5K1BKTmtpcG50?=
 =?utf-8?B?WHIzdlh5cXJUcUdndENQZmxXQU9Yak03VHd6eFBjSC96TWdvWHZMVUlOenNu?=
 =?utf-8?B?aTdpZWF1S3hWUE1mVEFGUm9pdlZtNFZRUkNOaUs3SmhqTTNJVU5iQUIxeHhK?=
 =?utf-8?B?ang3a0F6VWk1UGdXMXlHWHJPZXhJVUNnTGxuWkpkaGI5cldQUE1BbzN6WDhW?=
 =?utf-8?B?cHJLVWorZm1FR0RneUt4bHJkd3VucnpubHhEZzY5TEhONDBEQ1REKzNPOVJo?=
 =?utf-8?B?TGcxWldWTFAzL0p1ektPVzNZQVE4M1hyNThCMm5DcXBsS2hpblI1M1JQT1Zh?=
 =?utf-8?B?aE55VkZPWW41QXpjdWpCblJKY0kxSHRPeXAyQ3ZZWmF1dVFpWXBWRkhOcWpE?=
 =?utf-8?B?Y01iL290VWM1U1BZMElSUHBYbjFUOVBqUmhCMHpVeVVKZkZlR3F0SzZpUDVk?=
 =?utf-8?B?bDlGdWx1bTdzbjNXRGtKdngzKzJ3bUtMR1A3SzhYTTFWZkZPN0JUY0xyaDd4?=
 =?utf-8?B?Y2xxVmhZQWpHQWxkN1V0QkxDUFgyZmQyUkNweDFiM29hZ0NLaEJmdE03bDRU?=
 =?utf-8?B?RjgvMmpnWkpKVWtKY1M1TFVPVkVUZmp6bHpWN3V3SWM5TjMvTzlNYmFmalVN?=
 =?utf-8?B?M3d5bjdaa284aFh5aFVuYVlkdmQ2V21GVXE5UUFqRFkzbFJZRkZVT3F1TEJ5?=
 =?utf-8?B?ZytpK1JnMWRwb2ZGeGdpSjRXZ0p6MjNxSktnVkwvcS9CbG1CdEVkYkNNNnNl?=
 =?utf-8?B?Q3p4MGFZK1N5Zjd1K0t3Z3Q2ZW9peG5ha2NJZWZHWlp0RW1WbXVNK09ERllz?=
 =?utf-8?B?VC9CeXN4QkpSbWFCSzBaUlVvL2tpK0xja25xaHpRNUptcmNjZ1lHSUcxQ3R4?=
 =?utf-8?B?UE1RbkxMYTlBVS9ock9tUEJucEJ1ekovMWZxYURqSjU2VldocHlsZk9tdnFS?=
 =?utf-8?B?aHBrVFpLTmwwdUpKVDhRY2YrNXV3d1gveDAxaVgyL0RucTZWV1JTREdiMHI0?=
 =?utf-8?B?eDRWR3R1b0JyUGhBRTNRRTY5NERzSC9TNkw4Y1ZhT2lYLzlFbFE2L3haOWd0?=
 =?utf-8?B?TEJsQjNBd0t6bHFzZnNMNnlmeTlhT3FDVHhHZ29ZZGhhTFZINTFkUFY1YS8z?=
 =?utf-8?B?UkRmWnhEMTY0Qm81TERHdkpDZzBPUnRtNTh0clJhY1lSOHNOZEsvcFV3cml4?=
 =?utf-8?B?N282alN3Q3NQWFkvZk9uT3FhRkFnVVhRdVpWQlFyUnNsdW54bUgxU0plTFpL?=
 =?utf-8?B?am5wTUpobGozbHBJRUVpU21wc1lZbTJZY1dMK1JsbVZRYUl0VHpmTi9lczhX?=
 =?utf-8?B?TTliV0Jsemw5WVhZRCtqbHVGVlJjRjVlbHRxM2JHdVU2Q3dsT0VpZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d725d5cf-ef50-4988-506b-08df4b1b0da7
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:39:27.6562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOaJhG1XM9Fm3B8GuFTy1saZiL7JZZA4teWv5lYqGzhO1wXfQqrfO2AlXKlAm0SCfPgwT735zWO9xCFYYE9NmsERYWwGkMCcVdB2lBQuyxw=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> load_simple_fit() reads an image's type with SPL_FPGA, or with
> SPL_OS_BOOT and a decompressor, only to print it in a debug message: the
> FPGA path checks the type string itself, and the decompression message
> no longer names the image in SPL. Yet it links uimage_type[] for it,
> around 0.6KB on arm32 and 1.2KB on arm64.
> 
> Drop it.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
