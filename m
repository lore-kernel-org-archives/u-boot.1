Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93959606A326
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jQVtcMji;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=fuhsx9F3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B5A4811ED;
	Thu, 26 Nov 2026 15:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_nuM_8amKcS; Thu, 26 Nov 2026 15:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C529811EA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795707157;
	b=lCo0zpl369AiGt11MEUFnyS2tUFqSG53so6TSvyUz/zHMx5OS163Iiy5yE+SikC/YGgU
	 yLnZwHS3D0x0At4nDhQJWq9hPLDzQFWwTfSMgLJdrg+EtjSzZijPkRD6iQtOBSPjp7vFO
	 3S3v34lKzHS3urdhw2R+p6SQRgHcQCSXvjdB+fLLW0jjQIIrYlhb/SLrrAbNmYNiI9r+N
	 Nn+TxzEhWKxCnC/+NlqU+tHkp5inZlw9NrgdD3krFQbJwkvWkE1vBulceRF+s+99E8TPh
	 31sQE8ghObHY5HCkVcrvxKc484yaVBx2BUg9iQ7rI+OXbTfirAaDfOYyIfE+bG8q4Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795707157;
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
	bh=ox9wg6wl5NlZh0wJyRPlIg4fE9lGeOZ+D+vS0QcgNzE=;
	b=gsK5t2Tdov/78riSxogk7/BhOSZGkZ7gEDhCbdF48FvktpW0u6JxMCTKhJNl2XNvZHVW
	 DUdChlyRikWlCSIaJ7PSDzxLFNfo6raqqST2Sr58EpFUMHkAuUOi15VIcskhbTG0LtyTp
	 MvE88uZjv+1TFiNAhwEC4+NZIWazIYfmY9vyUa4+c+toWLj8w7qawyb0ZF0/8zQYn7Rv7
	 tf95rGMd+Q28uj/AfEiTEz8GXUbJiRGAYGcIupPnD4rXfAG9aDqjpW768ixFapHQM37cW
	 xp5CO5Kd1HXBTZJh7MGiAcHmY2QcUCWtzn7QODoEpePcOPYaUcpZ5IytHFQdW+IeHVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795707157;
	bh=ox9wg6wl5NlZh0wJyRPlIg4fE9lGeOZ+D+vS0QcgNzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jQVtcMjiBKFXgxDr2jZruQy2DCyb8MKxC+revQwvkapAt0/WeWqBaNT/xI3G7iMLz
	 3Ik66hicwOJz0CFmRRSPHQEj+OOOKdm3HDHrwiMci0OBzju7fvRt6fPXx7hRvhihSp
	 pxIzozP4LQjWK0VawA6D9DlcQw0TvBiczN8hu2jbUM0IxmFM3uX3UnukL23wrZ1EKX
	 rLJnvFK21g37hqCE/ALoaSkOCaYDab0/BYMjk50nNLa9TmELGOpSVXEt5Sy4L06ChU
	 A9d1wo8DlomkorOpgLHjsMorRimQ8/su9Xq6PfpeaV+2Af8Kgor/VDdPXAPjguyO/7
	 Q7nFqT35Zbjpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C529811EA;
	Thu, 26 Nov 2026 15:32:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4B2D32D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6D89409E3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LA7lzmKzUj0r for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 15:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65D0C409DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=fuhsx9F3
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65D0C409DA
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox9wg6wl5NlZh0wJyRPlIg4fE9lGeOZ+D+vS0QcgNzE=;
 b=fuhsx9F3UphUBk24w9Tv1BOE2vnFnomT9eWxWRcZxJXYFs37oGC6e9y8kP6dDih6sOreXVsvu1QO80Awh1KDsbsA7aSGeGqwAA4WT6qcv1r9uRhuNz6tYtEgGUPxLgm8Pm3OdV8jFWqtcb8AWn8boEmgbcLVhPYgcUNWJZtJu2g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 15:07:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:07:58 +0000
Message-ID: <30ee871d-a50c-4d7a-82d4-ed5a424f7b6b@cherry.de>
Date: Thu, 26 Nov 2026 16:07:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/23] doc: spl: Describe compressing the U-Boot payload
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
 <20261020-spl-fit-compression-v3-23-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-23-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:803:50::42) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: b02579a1-892e-4160-a37c-08df4bcf0e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|4143699003|261009223027099003|22082099003|18002099003|3023799007|261022115727099003|11063799006|56012099006|5023799004|10067099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261026140227099003|41080700001;
X-Microsoft-Antispam-Message-Info: b+oZen6Q4E4M9rxqrg353psbk42F3hEk536s1gWlYXLjTCZc4gIuPpSFWvmW93fnYvwHHaniQCuXs7Gjan65prnxeSdVAlsAcqz12V4Jtx2D+6KQT4YAwrfIuh+w0BBe3qZFRrfQMXMmZGxSM9DaHCFYqMTra6fYoV3iv6/oxpJDIkAwG7JT1DDpgtngP2GiMe5moMI1u3m/fHDdkQ1Hnp+BiperVmgt/tFYs/qETN7zkn2wtnNx6uah66WWgU6uGvxcSAGi02iL9KxJmArCcgGI30hyUtHT/k2cY45/P2BfXuG2zdzMwwfR7NNh1HIPyLkWP6eHSuKVgWhUhsP045KvmUpJTzuu1yihAYxHG8Z0gn3kX98gZ1HgSHFwDlKRqXcARea4EgSdOkNe9LtExOhRXo09z7D0Tpd94eNQ7hiSqbiOqzjIrWrbKQqnTYvkSsKCgDKWPFQ41X+SjOFwOBBC9nvkAtzNu8ueNnjxU30YqAmrLegTVmrtq3+Jdy6JAjSHGyNsesuhslzW99tjUvKt4MUbkyKK8sQgE1+s6FOIoIEBm/Wkq9i20bq5smLguvNgiu0TBLo68bgzeNxxscXMXzV8yWOhBtYFbowAIEAOrSYJWlSaZA42N6Lq+zfgfd4dP3D8aquwXlHqEpvUxdfCTOpjiJ+TaLwKUUCGj4WKbM6teteD67Y594V1R3XlQHYEC/YDVPaSOdISMOTtP4wzXougzejuRKlv1k4+B1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(4143699003)(261009223027099003)(22082099003)(18002099003)(3023799007)(261022115727099003)(11063799006)(56012099006)(5023799004)(10067099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261026140227099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjM4R0J0SldUNUNrOWdNc0c0N0hxUTRmcVpvQ1FIc2tVWjZUMFNqTFZmQ3o2?=
 =?utf-8?B?MyszMmRUMUZyb2RPQ1VNVXRReXV6MFpLT2lnRWhnc3B4ak45ODBUWFNLUHlU?=
 =?utf-8?B?ZlZKa2h4YS8vNCtwZDArVWR5Umx4VmJFYkJpNTRvUmorcXY3dGhYRXJrMFFL?=
 =?utf-8?B?NGlaK25BRFVXdTdSdUR2TlVCU29lOXZkN1FnUmMwbG15RzNHVnlYSWxvMVpj?=
 =?utf-8?B?Q2xlNElvMWhhNDgrRzR3SU1ublA1Nnh1RUwrOCs5bWt1dWorKzFxbnFpZ01w?=
 =?utf-8?B?OHkzYUw2b3ZPOHRLb3NQQTMvakxiNHJUMXVaZmxKdGJHQzlWd3lMNGRSNzNL?=
 =?utf-8?B?Tld0NWVYTVJsOXkrV1I0M0IvNVZtVTVSUDJlY2FOdU0vSHhXSG95ZHNzRE1T?=
 =?utf-8?B?SkxETFlVenpkbE80NDJLVktrWHA4RnRtVlFvbk1MRmcyTkNIQi9uYzhTbjYx?=
 =?utf-8?B?U0dSQ3FQTlU0UHBXcUxpUkU2aEhGWXRRV0F1UXRvWC9jb0t2QXJpemVSeXNF?=
 =?utf-8?B?TmNYZDRqRVN4TEhjRWhzcWhyWXR1R1RGYk5KNUJGemhRNVdrQkYxOXVyRnpn?=
 =?utf-8?B?S0ZQdWpsbXpvWUE2N3lZN3BPTlYzTWJRK1l3QXlSQUJUYzR1Y1FMNkpVU1BF?=
 =?utf-8?B?c1hyQ0ZiZ01ZWFgyQ0hsMjFmNlhUL00rczF5M3U0UFBVMGxDeS9HekxpQ2dZ?=
 =?utf-8?B?akdPWXlVSFBabG1aV282U2tZQ3lwSUJOUzVoM21TdCtRZWp0NXhMOVlqSkRt?=
 =?utf-8?B?aGJKb0U4Nk4rVTlmZ0F4ZnBTWDZlZXQxK2NXT1JoSnErRXNGeHdzbXdrV1Nj?=
 =?utf-8?B?TjlRcExwQXRwYWI0a1k4dXJjbzVEZ3JIbmlFWGdGQ3JCVGxGaWVZdTdvdXda?=
 =?utf-8?B?eVZkRURyRjl5U3pxNkNjeXUxTEFJY1JleVhpcWQyaGZZbG5PNzhmQ0JzaytC?=
 =?utf-8?B?ZkE1Z1FHOUdoVWE1NWtKdWJLQnFQQ3loenBEeDhsNnJIbkxrUnZYV05JbVlM?=
 =?utf-8?B?UmZHMXNpSHFYR3pTZWx6RmszV09xS3RWcTh1K2J3TmhkQ1F5TEo5TkVib3NV?=
 =?utf-8?B?VTIxZFhrRDMvMEwxTFJoaGpVMWZOdFBFbTlRWVJmQjREWEZxNHg5WXhmQitV?=
 =?utf-8?B?dHp3OUlNZU9QeHZEWnZodENEV3JNM0RpZGJHNUNwOWdCV1diUTNuS2JsUmwx?=
 =?utf-8?B?Y3BsZmw2ak9DYnN4Vy9abWEzbXNvNHZiQ0VadlhoUUl5YlVkYUgzZ3c3TE5p?=
 =?utf-8?B?cjJEdHNtMW5pV0xjN3gzUUVaUUxsQkkzb0F5WHh0QW1yRGY4YUdiOEhzbWV5?=
 =?utf-8?B?L1g0TmJ4amJ0TjRuLzhMQ0FyWFpCQ2pkVzUvdzBpaFRzRktHMDh2QnFhNC8y?=
 =?utf-8?B?UUZTdkNUbFVrZmxZNWNROFZ1SExRUHhGdXRSU1JBYlRIR2Z6R3puU3VTejJ2?=
 =?utf-8?B?amMxVjlnUFNtR3g1d0U2VGNQQ0pWVVFwbnZCYXk0YW80UGZHV3VMQkFiR25K?=
 =?utf-8?B?SkUycEMxMnEzbUZMNzVKUVM2Q0NNNFFkZ081VWtqZ0x0TmJKcTFNNkZzQWxF?=
 =?utf-8?B?VDFiNFkzSW84RTBQL3hqdEpFNnFaSk4zWnYrRmlVbC82K1pTU2RqWTVUTmJ2?=
 =?utf-8?B?ZDBnMm40bTQycmVQb1lNS0JSd0tPMXFpMm1IOWx3UEdsYUwrRUxJZUdzejQy?=
 =?utf-8?B?K0wycUtBazZjNlZsMEhHb2VZNGEveUxuSW5aL3NneDF6V1VndWlZZHhmL2dF?=
 =?utf-8?B?RHdkN1Rrb1VORVFYelJZdnFrVXhlVEI2bkdlcHNrdCtiTkdvbFZsSU55Ykho?=
 =?utf-8?B?czJqRk50b08xUDM3MUdDd1lBb2hqTUY2Y25BSTdEWUtCVzZGVUVVSkFWbmdv?=
 =?utf-8?B?TDFRVjQ3RUVnaGZmTW0yallKTHB5U1JmVWhUeVpnKzNGNkVXZkx1T1FkeFBo?=
 =?utf-8?B?ajdlYmpOZXFRbVgwZ1lSbDgxVG91d2tNQTVwWUZub3VGTktFYzZYcTdJdHpw?=
 =?utf-8?B?a2ZrNlJ3YkJ3TkNSUnh4Z0cxMHhJTkNTSGVsbFkrWTlGR2pWdU5zZFhCK0xF?=
 =?utf-8?B?WkJBN09FWVc4N2NiSlZGSDdEMmsyV2hCMzhvZE9tY0VOSEIraDBJWWpXNmJ4?=
 =?utf-8?B?QWttSGxNZlFnOVk1ejNrTm94M24wL3RVWm93TzlmOEtVMmdXSnZneEp1VzdV?=
 =?utf-8?B?dHMwV0pIZjZGZUFyVkxSYnhBYUx1RE5scVlWaWw4UkJpTWsraHdEZkhTbUh6?=
 =?utf-8?B?TWo4RU1saGs3TXYzaTVBU1dNRlhSU0ZETDEvRzM2ci94SjN1VmxSc2t6dEJV?=
 =?utf-8?B?ZnlvQVA4Ujg1K2NQRXpMSjI0cERkSmJwOGNrcEJyajB3SUlQSTNFdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b02579a1-892e-4160-a37c-08df4bcf0e52
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:07:58.1729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oObx+euqoW1Vpi4ZqTgyUCM2vIvvfvvwoqG7Vun5tCbfUBgsF65heVPXKBsjBSuRtM0xSGKWIjyzSrkvUEB7aCG1frBZiaUD1Y8FPXWmtF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
X-Mailman-Approved-At: Thu, 26 Nov 2026 15:32:26 +0000
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

Thanks for sending patches for the docs!

On 10/20/26 6:41 PM, Alexey Charkov wrote:
> Kconfig help has room for what a symbol does, not for the reasoning behind
> reaching for it. Describe the trade-off compression makes, what separates
> the algorithms, and the addressing constraint that decides whether it works
> on a given board at all, so the help text can stay to the point.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   doc/develop/spl.rst | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
> 
> diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
> index 08b51172014b..88a325ed6ae3 100644
> --- a/doc/develop/spl.rst
> +++ b/doc/develop/spl.rst
> @@ -151,6 +151,80 @@ NOTE: U-Boot migrated to a new schema for the u-boot,dm-* tags in 2023. Please
>   update to use the new bootph-* tags as described in the
>   doc/device-tree-bindings/bootph.yaml binding file.
>   
> +Compressing the U-Boot payload
> +------------------------------
> +
> +Where SPL loads U-Boot proper from a FIT, that payload may be stored
> +compressed. SPL unpacks it on the way to its load address, so the image on
> +the boot medium gets smaller at the cost of a decompression step.
> +
> +CONFIG_SPL_FIT_UBOOT_COMP names the algorithm, and
> +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL how hard to compress, numbered the way the
> +chosen algorithm's own tool numbers it. A level of 0 passes none, leaving the
> +choice to binman, which uses the tool's own default except for lz4, where it
> +passes 5. Both are only offered on platforms

issue: please remove details on level

It's already in too many places, including the symbol's help text. I'm 
sure we'll forget to update it somewhere and the docs is definitely a 
place where it's unlikely to ever be updated again.

> +which select CONFIG_HAVE_SPL_FIT_COMPRESSION, declaring that whatever builds
> +their FIT honours them: binman for every in-tree user today, though nothing
> +in the mechanism requires that. Elsewhere the choice is hidden and
> +CONFIG_SPL_FIT_UBOOT_COMP reads "none", so an image description may reference
> +it unconditionally.
> +

suggestion (non-blocking): reword to simplify

What matters is that the symbols are only accessible when 
CONFIG_HAVE_SPL_FIT_COMPRESSION is enabled, which is an invisible 
symbol. SoC or board vendors may enable it once they validate that 
CONFIG_SPL_FIT_UBOOT_COMP and CONFIG_SPL_FIT_UBOOT_COMP_LEVEL are taken 
into account for the compression of U-Boot proper in the FIT image. The 
fact it applies to binman doesn't matter, it isn't necessarily 
binman-specific.

> +Whether compression is worth it
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Compressing always buys room on the boot medium. Whether it also buys boot

issue: mixing boot and storage medium

s/boot/storage/. You can boot from one medium but load the FIT from 
another (the Theobroma boards support that for example).

> +time depends on how fast that medium reads against how fast the SoC unpacks:
> +the image is read quicker, and then has to be decompressed. On a slow medium

suggestion (non-blocking): add "smaller"

"the smaller compressed image is read quicker" to really highlight why 
it is read quicker.

> +the read dominates and compression wins; on a fast one it can easily lose.
> +Both numbers are board-specific, so measure them rather than assuming either
> +way.
> +
> +The algorithms differ mostly in where they sit on that trade-off:
> +
> +* `gzip`: a middling ratio, quick to unpack, and its decompressor needs less
> +  of the SPL heap than zstd does, for its state and possibly a 32 kB window.
> +* `lzma`: the best ratio on offer, and by far the slowest to unpack. It
> +  takes no compression level; its tool is steered by dictionary size and
> +  context bits instead.
> +* `lzo`: a poor ratio in exchange for fast decompression.
> +* `lz4`: the fastest to unpack and the worst ratio, suiting a fast boot
> +  medium.
> +* `zstd`: close to the lzma ratio for a fraction of the time, but its
> +  decompressor needs the most SPL heap: a workspace on the order of 100 kB.
> +  Kconfig cannot check that the heap is large enough, as it may come from
> +  CONFIG_SPL_SYS_MALLOC_F_LEN, CONFIG_SPL_SYS_MALLOC_SIZE or
> +  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN depending on the board, so check it
> +  before enabling zstd. A heap too small for it is reported as a failure to
> +  allocate the workspace.
> +
> +Decompression speed is also sensitive to the build: a decompressor compiled
> +to avoid unaligned loads, as xPL code often must be, can run several times
> +slower than the same code without that restriction.
> +
> +Where the compressed data is staged
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +With external data, the usual layout for a FIT which SPL loads, SPL reads the

suggestion (non-blocking): hint at how one knows

Is there a way to know if the data in a given FIT is storing data 
externally? I know how to generate it, with fit,external-offset in 
binman and mkimage -E otherwise, which we could also mention.

> +compressed payload into CONFIG_SYS_LOAD_ADDR and decompresses from there to
> +the load address the FIT gives for the image. With embedded data, it
> +decompresses straight out of the FIT where it was loaded, so the same applies
> +to the FIT's own location instead.
> +
> +Either way, the input must not reach into the output: the decompressed image
> +is normally the larger of the two, so the output can overrun input yet to be
> +read, and decompression then fails or, with an algorithm which keeps no
> +checksum of its output, produces a corrupt image without noticing. The image's

question: didn't you fix this in patch 8?

I thought we now checked that input and output do not overlap even after 
decompressing?

> +hash only covers the compressed data, so SPL checks the layout itself and
> +refuses to load the image, naming both addresses: before decompressing,
> +against as much of the output as the input is long, and after, against the
> +whole of it. This is conservative, as input sitting just above the output can
> +survive if the output grows by less than the gap between them, but no layout
> +is meant to rely on that.
> +

issue: please reword to make this easier to read and understand

What's the important piece of information here for the user? If 
addresses are too close to one another, the compressed and uncompressed 
data will overlap and will be corrupted. SPL checks for that and rejects 
overlapping memory areas. The user needs to adjust them (typically via 
CONFIG_SYS_LOAD_ADDR and CONFIG_TEXT_BASE) so they don't overlap 
anymore. That should be it no?

Cheers,
Quentin
