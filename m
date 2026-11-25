Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C76606A33A
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i9BcYOrb;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=eMst1MaC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00F2780DF9;
	Wed, 25 Nov 2026 18:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRTC-jLUKioD; Wed, 25 Nov 2026 18:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42F0580CBD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630420;
	b=KVaMmhlg2lAl1z0ms9bRiszgEEeH+wyG+sx6Kf0vAXoLFghBOLc/RVrPdIBJNgZziWro
	 elPxR0mhpBKa9/+RxLnY4Zy5zN9M5Y5mO0P8XhpyGV/uXdpUGmnTbcXz5WRQPVMEJNytP
	 91jQmTJFGSgMtuhySbBqaWEqTfr992UUPGA47piJkM8Uak6WaGhxNi1qrWeTD0DZTL2um
	 R6fZlA5PuynNoLk5hJ9ZXDmjvl+/LoYEeBUCZIIOSwezUg5svVb4TPv5fQEBc/Udp8TD7
	 tSIESKbPAoH+7qIi5jXN7V/8206HiBhpGbymfuL8noPIdjE+RLiII3RAgJpDiJMOnAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630420;
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
	bh=zAPH2fjjy1HheF9JqBh0PaxS7n91LanLrejcUJUBW2I=;
	b=MZ0Ms3GG+0sQj+o1jpr3Wusipm6Z72ui98VaQwwk0NkRO3KLJGB9hRBSC9/7aAmFurce
	 CbTbUBRRArgs+eavD471Rv5vs0t+XmoV8TYLyqgXDX0ZOOuE18IW+WmS4/RHB5XYGKCpM
	 POJ2UmtuEChIYuJspTUevMEFn5u0P+Flw+Ebbx+50FN7iBXiDN/fHQdEoXANMRB3aEgFH
	 v6apQRhCyH6ESr4qWf29FaTub7oeJN5d9Km78ixv706Sf1MD4QhUnEHjP/ermDiMzXox6
	 A3slOpy9fiC1UhW6RI790lyVYgVpgkFjb0yDBQQLj46kDqUXcy7zcsLd0DUTXOakxmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630420;
	bh=zAPH2fjjy1HheF9JqBh0PaxS7n91LanLrejcUJUBW2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9BcYOrbWSBJ5cnp1zLpARCYkyyvOh6mt0jVsTKqi72Q/rhsZwhWpoSv1bxfVbcVr
	 qP/bscF77nSB9lS9BPRHvSe6G0/pKNJ6hPhPwDM+5VbaN0KH5+KsNENwwtgSg2DLAL
	 faaGBoY/DgStQ4gWiKm280YjDWXQKGx84xMEdee/PVoWR7eDg5vjBUK0e8FCMoyfX7
	 qu0i0U1tGCyOk8k7Vd0EGvB0dE8aWYP27WtBkA/alxadEzCBDD5Z4wlNRFIWFqHuGz
	 5LGh0w9HGVRGUMRXZ4eKv+QvTe7ckJhM4urBTj2TDsYbbhOrU9y305vP4ryjL55xUk
	 CcXgyRob/mCKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42F0580CBD;
	Wed, 25 Nov 2026 18:13:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92261325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8381260758
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCXeyvbZq8ZI for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A42360755
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=eMst1MaC
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A42360755
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAPH2fjjy1HheF9JqBh0PaxS7n91LanLrejcUJUBW2I=;
 b=eMst1MaCkU6bqw5yp7wx1Fuk0i6nI0qTuhvKBx80Ntlc86darzKBEn8wwK2Wz6x70+FQ6WDUUZFyn+P1HsfdrhZpN+sWrB5j+6dc7UizCIXEsY3vDmNu3V6iNtVzvcF4ELK8PzvShdrE04Hy7NHdQPi1VrQih/Epz5rDR/j8g08=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9327.eurprd04.prod.outlook.com (2603:10a6:102:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:35:01 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:35:01 +0000
Message-ID: <29e4e5ae-f845-4725-add5-5619054a6a21@cherry.de>
Date: Wed, 25 Nov 2026 18:34:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/23] boot: image: Keep the image-type table out of xPL
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
 <20261020-spl-fit-compression-v3-1-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-1-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7d680b-c352-413d-9323-08df4b1a6ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|3023799007|4143699003|11063799006|10067099003|56012099006|261102123227099003|261026121527099003|261021123027099003|261022115727099003|261022075727099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info: sooFvlSKZwnKqShooHkCbLVMUkvsiVWCJcdly3X6h1ewRutoZxyd6CqU8WGYjLHi5OtBsXol5VMabDIOMx3VK1ajFV58JWEu1YXJSU8qJa1CeJR1x58pTOwPbUvzTKFPzMisz3CiFo5w9p8oPO/cJg1juDjAyctmtpzeHhdFXIVbx8PQ1/ftFffxOyOwJVng7XX5bb9FNf7SwBzJsVuNoLvpKnTYjI4sdIleyGVyP4WgrlnLp42yH3oi5IZ4Lc/39UEOA1+qxDxUV/Apgl30Lcvsc3ejOULBVIr+u3RHHD+r6Ph1/+ZWNVDnpBfoUtltCgiK9Iq2/p302EaYRKj0XpHKiA/TAUINYetLu0USmwgPIYEWbu+MZp8OkH1jhbvTUaVXn9d+jLvr9S0VLf5wD2Mv0nJvdb64pMKiGmxcAaiJsHl7zoATEZCsVt85CzwKvGCEu3op4Z9UC1YDrN7sqCTu+HjJzbZ+5Cbgi76NqOye9hJfn7GSAHZAPmx70MOwZiSpt28O7QBZu8Pe7o4gIHOlVsLOVZR4nNwGBavSULiwYjxE4BPb04iuTvOCsDwyj5pNfVZyyIeYKnT8W7YPqqwWphmtEvyU8jEgTyHPZJFovvTvge1OfoKatLUrOtoZkUs+tGlmqu2QKeIaFUYruLAcnDpBl6E3v9NAQsX+pRudo4EQmQkYEsT7bBFo0j00IJvoLSHOom2wQ3k+sbh05w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261021123027099003)(261022115727099003)(261022075727099003)(261021121427099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpXOXdQZU9XQnVhekVRQmR3M01rMUR1ai9QQWowYVd4R1JmVk10U2cyMGNF?=
 =?utf-8?B?eUlVcUVZSjVlM280dFArR05jalE0cXp2UVNMb3dUN2R5cXJKNGFubHEwUFJZ?=
 =?utf-8?B?RzRqc2REaGhzQVNPbnFiSTJuS1hTNGRNWGxobzE3S3VpWVAvV04xM1Znb1Zy?=
 =?utf-8?B?ZjNqTElaSi9yMndIbUpCUGZTYjRQcjM2ZWNIMktGK3J0MmZlK0hxK0J3YlY4?=
 =?utf-8?B?TjR3U1BpYkJCK004Njk3MDhnVCsycUh5SHBYUktzUGd2N1d2ZU1Ybmc5K3Nx?=
 =?utf-8?B?OVV3Z3JuY1BJMHY5L2ZkbkxVR29Td1FQMHdqbVhFS1RkajdicTlESUdGMERL?=
 =?utf-8?B?MTlpY2VjVnplUzVLOHNpY2ZMRjdKenNSY0JyWmZmdmZ3ZVhCeDJRQyt5ZlVQ?=
 =?utf-8?B?ZDM2eVlvdXdBeWZ3WXFYVHBVbGF3QUxRMWxRdHFXaUpybDUyMVBqVGtab3ZM?=
 =?utf-8?B?RFViSktOTG9wN3VwNGJvL3FQWjhoQnp3NmM1ajV2T3dSelRCOVVYeHZoVFh5?=
 =?utf-8?B?WUUzclJoSjhISFMvVUZ4ZTdrbzBQZlFqNytXSm5sYkRidUNSek1VTXd1RXFN?=
 =?utf-8?B?WElVYWJrT2loR21ZdzFOV2dTT1dxSXdZdzZoSHhmS0J2bTlvTXlZMlRzdnhs?=
 =?utf-8?B?a0pYZlVuRk05TFFyNDBIN2FTZkY5d0pxdWVSK28ySUF3OHVaL1JEWVhSRmFl?=
 =?utf-8?B?YjlJMG50eTlLd2ZKenJINTE1VEFzWXJuNXlybmF5Rk54NHFLUFJVNlVpWEY3?=
 =?utf-8?B?NFAySHQ4OWF1MG1tR2VDMFRpTTFVT0JBdk5vVVl3RFhlR1dvRUdaQlorMlND?=
 =?utf-8?B?bTVVK3dMREhENnZRcXNzYnlIVVE1RHFOUmlOZC9ub3JISmgxQjhCa2hFWlZo?=
 =?utf-8?B?bmxVOFRCeTdEeWRWRWkyUjR2SHhkQUU0WUt1eDkzYmRwUUQxRyszcTNmQUor?=
 =?utf-8?B?YUp2cjVBdGdqNThtRnJ3K1BKdjlpZGpOcHpQeVdUaEZuYk1RMy9wZU9ON2or?=
 =?utf-8?B?VFkzNGIvMFBqN3RybHBRZmFiK0xEY3JaakNva2RRNGhuSjY4QVhzeE5iOWdE?=
 =?utf-8?B?QXJlcVJ3WDVLQXM5MDRoQjQwZnhvL3EwdmhFeURMTUorMU93T281ZVRPVFFz?=
 =?utf-8?B?STFDREVWYnp4K0dBUEZPN1I0K2htU05hY0ZTR1dxdFZrOHFCbm1yWnM1K2Qr?=
 =?utf-8?B?VmdKTmNFUG9rWW1RQk0xak9KcnhPMUVzeWF5bTVhd21jTU0xY0RncWprTU1a?=
 =?utf-8?B?amJNY0FwS3V4REJXWkRxM3kvc2p6Yk1Mam8xQ1hnS3NFTXNHZmd3TGhrMkFN?=
 =?utf-8?B?WW1OZ2xTWVlDWWVSMXgrMkFpcFVERDhySGpaMVo4Q0V5VGNtNzFiYzg1UE81?=
 =?utf-8?B?dUIzK3dhTTd4TGQ3S2xBTDJtV2UzWmZHNkZsOGliK0hrb0duL0MzV282QzNZ?=
 =?utf-8?B?Tjh2S1FFVzhkY08weTdnRFFIdW9RMlltT0s0SDlqNjdFS2lqdzRja2NmeGtn?=
 =?utf-8?B?Vy9BaVFBWmlGUkdCVWYxR293YlZyTkgzTU9BWlhJeCs5c3BpZ3pQSm05NlhD?=
 =?utf-8?B?Y1BSY2hibHpNV2tmdWFvR2dleDRpNUZqTm5ZNGpQUVlKMGEyUEJqbmwxaktQ?=
 =?utf-8?B?dXBLOFlsWnJKclFCbXgwcFlFeThIUDAweXIxQWFPMVJxN2JjU1VERWJIYUYz?=
 =?utf-8?B?aUlRTUdoZFNFMzBXMmhZbEk0dStMN3dKMDlRUnEwZWdWWWNXL3RzR1Fub1Ax?=
 =?utf-8?B?Q2FwTVRHWVlBOUJRMWczK1lucjkwZHlRczMvRy9mSWw2dktYRXNaRHcyNFJV?=
 =?utf-8?B?ZzZ4THhVbDlXNEpqcVBvS2NMUUpra24xRWR1bi82disrL25GbTJzUWFUTzk1?=
 =?utf-8?B?RFloSTlNQUwya2dYejh4QWR3RXlHQndhY0cvTnpOanhCSGh2Ym55enFmL0s4?=
 =?utf-8?B?d1o0RXZqRnlBZ0YzRjdHWkd3aUpLZGM0RHFvQzRXUjZJaTFheXRZQVo4N0R3?=
 =?utf-8?B?Q3F1bzJOSXY2ODNXRGwzVjdrR1VEZGVTaHpmenkraVQ4L0w2ZGpXZ2dQY0Jo?=
 =?utf-8?B?OWNpTWF5RzV2NWNyeTlzSUpIMXMrblNBM0Q5Y3FFV0tSb1pBbFlMUjBqUU5I?=
 =?utf-8?B?YUpZMGNqVTdJV2lQbDJXYldPKzVZL21YdDdPSzBNM2Z2T0UrdEVveG4xZTEw?=
 =?utf-8?B?NWpqNmZvR0dDUk1FejRyTjZVSHFONVlLdVNWRVRjaGo4YWRrVlJhYkpYVkVJ?=
 =?utf-8?B?Y3RkcE9jSFJWTmZlZ0QxN1RuTzRkSkVXWWUxREFFODgwY0xwRG9VRUFrMlVI?=
 =?utf-8?B?eVdNWFNyZVlKYlRySWFUVTQ3dWFGUDhSaWdDN29PLzhyYU9qQ2svZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7d680b-c352-413d-9323-08df4b1a6ecf
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:35:01.4673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNQbj7KZdE/t/Tlh8HWYQ2JnfLnL5cswjhd5YgX0wjsnH2KrqlsBA1BbazTI+ZdetwFBU0Epd74oOTS77+HBTjzIDW/yNBHbK5Fman08up4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9327
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> print_decomp_msg() names the image it is about to unpack, which drags
> uimage_type[] into any phase that links image_decomp(). That is 650 bytes
> in an arm32 SPL and 1266 in an arm64 one, spent on one line of progress
> output in a phase built for size.
> 
> Name it "image" there instead. U-Boot proper is unchanged.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   boot/image.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/image.c b/boot/image.c
> index 185d52ba492f..8a031aab0c1b 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -416,9 +416,14 @@ void image_print_contents(const void *ptr)
>   static void print_decomp_msg(int comp_type, int type, bool is_xip,
>   			     ulong load)
>   {
> -	const char *name = genimg_get_type_name(type);
> +	/*
> +	 * The image-type table costs up to about 1.2KB, which is a lot to spend
> +	 * on a progress message in a phase built for size.
> +	 */
> +	const char *name = IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
> +			   genimg_get_type_name(type);
>   

question (non-blocking): should this rather be moved to 
genimg_get_type_name()?

This is only fixing one caller of genimg_get_type_name()... Wouldn't it 
make more sense to do:

const char *genimg_get_type_name(uint8_t type)
{
         return IS_ENABLED(CONFIG_XPL_BUILD) ? "image" : 
(get_table_entry_name(uimage_type, "Unknown Image", type));
}

(not tested)?

There's probably also some space to be saved for other tables as well.

Cheers,
Quentin
