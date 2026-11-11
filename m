Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47200606A32A
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zy4o4SOy;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=nfziaGsK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C31A80B56;
	Wed, 11 Nov 2026 12:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUKwd6sTe_RR; Wed, 11 Nov 2026 12:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE3A6809B3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794400705;
	b=evjmIAwICBCoBN7tTMwoHpaK3RamCAXF+mhYlsxkYWC7UMh2T23lpsnj4TTDMYMJlrZi
	 bxfhITuG2cYpALetNne6++2H1Y5Sv9DC2ruVR74x7vx7bfSzslvPQQUZGsNzZnNdSEuax
	 5Z1v3zm33/aQ0qbjiNmRWCOk9Xp8CVjMfgLbSeiOj3A6uRZnkly4SsHa52OkuCMdvpFVE
	 +fXELabe8pH/22w1EPtOTZyZAEQYM4cUcRC2pxDZN3auq/0ezdfHqGD39l+VWUGOPYtIC
	 +eHJTdiKcdSjG//bQRNBrQZDgZD/hNcbHnqWoGAqOrIRvZ5uHG2MsXkcnU5DWtALOiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794400705;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8lXniSlpQDgrQ0P5YqKn0FqCW9SDt2WY7LNrYFLN1qQ=;
	b=UPWlI45lc4It2ckeN3yJZl6hVZ1Vyc1VVW8rqSq2echk8jokf6iG3yZjhj+qoqcvhmSG
	 5aUskUj4zKEvWptKgSIfIUg2nehEXfg2sD+bGPg6/hJ6YMrXvFFGrF/DEmLLiP7MYqv1j
	 o7S36vZPXavfNUM2aefEmvA/wdemt3CFQ3ybU0hdLYGTQq0ZXljgb4X+6dzNtsEJ2HYNp
	 pNvtyff/jG0SfmA3HtENuxizAkQ5pE9MkCci5NGDk59p1Xng7mAwUMOCif57dc1uAfL6u
	 FEUOP4eaZMbK1C8gDyMlConeiRrFIgzYW3sF7VnjGeNh6PcuALd8xqF2jdK8WdbHJHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794400705;
	bh=8lXniSlpQDgrQ0P5YqKn0FqCW9SDt2WY7LNrYFLN1qQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zy4o4SOycODuCT/LzCZueMVHXDM2zqCwRdbiCK6PhJoPholol3gBii5/DHmY8E4W4
	 aoqUGkQIs/GIr3QYkJmqxMChbrU/1OIXPe3C8hKYEdlIZ2E0CWYu/AZzqGXb59/X3I
	 CGoBQPQAMpErGHo2Ies/3QHsHdEAGsJeIQ/GiOkdp3h7ePx0P7FGaP76WijCOLsa9G
	 Ir3rFwojLhIMX6V3WG3XOKe3XdDgVSqhRwLF/+rnmTUer9xjC2JB6kqVK5NL+EpEq0
	 UxBjVm1LyGGPJhdYNl+ZhFgIlk3e94Zve/geNLY2Fyz2OzA3QOXxY5GrBy2T/z5P59
	 MzDxb0vH3FbZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE3A6809B3;
	Wed, 11 Nov 2026 12:38:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 342AE2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 255536067E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-smIC0Bg1ph for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB71B605F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=nfziaGsK
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB71B605F8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lXniSlpQDgrQ0P5YqKn0FqCW9SDt2WY7LNrYFLN1qQ=;
 b=nfziaGsKswWUbdD+fVAska+j31YMj49PMitiQOZCNLa8uvxifMS8XddJKSe0di+VUz1MLnwog5FzSpLrnXVQRc9FaaK+46fLE5B9RDhCD2z/2I4BnjYruaGNAZhtsYrCxAOQeNrjN/j/adbmKWBneU5orAzZ+IUT/AlvpYMcGnrF5SeMj0Glp/ffhcMYyhjxB/FtYAOT0wwyxcifD4orjBTMtj8n/xGpNTz2dYe1JtFpcK15y9H3PTJaI/BALJIWBwQ4Q4MlbO9zioBVpAAatFHClGIAMyJeLbO9POkjpmLMYvq/ij6fODwzcf1BDyMa8ufCfniVfiBtuoTFJrRM9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by PAXPR10MB5733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Wed, 11 Nov
 2026 12:38:13 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 12:38:13 +0000
Message-ID: <4ce05817-10e0-47cf-a252-51638f75f3d3@kontron.de>
Date: Wed, 11 Nov 2026 13:38:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] bootstd: rauc: Fixes, partition names and
 built-in boot command
To: Frieder Schrempf <frieder@fris.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|PAXPR10MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: b6871ab7-b573-40e8-d110-08df3ff0a6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|11063799006|56012099006|5023799004|261022105027099003|261028144727099003|261022075727099003|261009223027099003|261022115727099003|261026121527099003|261021121427099003|261026140227099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: nraH8UDN6CW2fuObhHiMj1WPH7Dgk+dG6xMmj+990QGB7ecwTTWlr/3BjRI7jNftkCbP/Qsvb8hf60IB/tQeYCXrnt8GHOPABlYJYVdIZU+Bj8t9kIUOFro+V4JWbQn9lrTR57SFG+2n2u+Vkb0TukHWZzgQVJzF+EsLhGUvZY9U2z5xRmBmm5u22KwJN306jc5BFi4vpsqlZwwJyumUbmIZLjPnUvwmIYiUJCG2SbiD4nX1lhfmNrfc6gMBDZphf9fMcZ8QxGM+aggKVW3tD1oMmBQ5Q9wcUeXQktlQNQ9grKvgpCaS6Er6y/wSEs9281eUziOZkjy8fsm1WyRJP2oXzRIg0LJtcU0igEAu9smF+TEg3qrS+cmGgfFTybsf3ECRjZK1FCwqbPr+kGyj14NI2qezMG7uDv0TLkJTBcpdNO03IVTO8GmiDgMnm5FrvuqVpCBReTD2fsNR+eclB7PyMdJikD1f/fcaUuyKP9LYTnB8r64T8vrtoZ57KFzq7XT/Kap/FqlCi1ZP3inXWJCHCXl22lJUzkBDWRKNFtkYXAqJ7alrtU9wXxpqSENZxM+iju79KfQZy+VwGd6TDnmWGe/LiJszkqvFVK5MNbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006)(5023799004)(261022105027099003)(261028144727099003)(261022075727099003)(261009223027099003)(261022115727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9IUUVCWFg2aXZRNzVmeGFFRVVzZ1hBcTBzNHV3OG1TSEIxeU5ZRTVQWGI3?=
 =?utf-8?B?SEFETytPcGU1UXdzWW9DTTFvWjJWSXdsQTRWbEJLbWJpc0ZGdGtVQmpaaVZZ?=
 =?utf-8?B?cjlHUXk1YTY4bERxc0d6RTFsdm1Uci9jZlI4R2kvK1JmcENxd3piYWVtTVpF?=
 =?utf-8?B?NTdROFZLMHNtOHRVMTNPMXdkM1J1anVTRFN5bzlYT3BMZDByQWRHbWhGTDBR?=
 =?utf-8?B?UGFSK0ZFcytEbStNa3dkSUxlWTROVDJ1SXk0Yk1qNStrQ0xSY2ZMUzFOMHl2?=
 =?utf-8?B?c0h4eGpjemRCUTJ0bXYzOUdQMkFxSGlacE02SGtEa2pPeWh0Z01XU2NXcjhZ?=
 =?utf-8?B?ZTdWQ0xlRHErMS9iQ0lURHAzd05NM3oyMElUSUZDTzJndHRyRmRnM0loUU10?=
 =?utf-8?B?K1FFcUEzaXhUallZUnhmWjF4eVp6RjMxYnpDcGJRd0pwREUxenlPalBwZ3pt?=
 =?utf-8?B?cmVjV3o1NHc4MlhvUVRSWmlibDYwbDJBNDY5WjBlQ0cxc2JQMXVyWWp2UkJ1?=
 =?utf-8?B?TUd5dVJNSmorbHlLejY4TzFxNVdxQW55NzhiNldPTDRFZmN1OEtxRzFDakZ5?=
 =?utf-8?B?UUVTQ0xrWW05VjVmbUVnaHZvRkVDR0d0RU12M0h3TlZuTUVlSHduVHgrbysz?=
 =?utf-8?B?SGJsNTF2VjN5T3lnY0RwemVZbVpaYlJiR3BOcFliSWYydnY5UFVUaEJrcU9S?=
 =?utf-8?B?RGJzV0JQeWdQYTFxa1VhOXN4SmoxUFVzdElxVlo3dEs3NVBoTXRySUJUeWt5?=
 =?utf-8?B?NEIrcUdBeGZmZE5tc0lUS1Z5OEVRc1VkYXMzUDNOQ3BSaURSZnlYV1JiV01G?=
 =?utf-8?B?eFVsM1BjOStsVnQvL25ESDVkZ2V6MjZwSCtnbXJJeXJybVhaOS8wVmRhRzlV?=
 =?utf-8?B?SzE5OUNVbGF6aGxkWkw5Y1dVL2lsbkkxQ0xEMHVnYTJZa0lHRFMxbVlXQ3Q0?=
 =?utf-8?B?UlVKRVpndk5xeEplM21La0FuaGVDdy9aRjc2N2J4NlpFVk5CMTVONEFMYm5I?=
 =?utf-8?B?YTdJdDRJSGwxR3VpMFFoSXQ4UTg3VHJ4N0grTUpsNk5FQTlRVVBFVGxzYWJW?=
 =?utf-8?B?WGxJZlQxZTYwUkRvNzRFSk1WTnpXVmdUYmpOdzl6bjZmUld3WDlhSkxNV2hs?=
 =?utf-8?B?QlNBOEF5endYM0o0Sm8rVTE4bW5acUpjbktXNnF0ZDB4NWJwUVZzRzJvOTRr?=
 =?utf-8?B?NytXelFFamQxVnJXMFpHcVlVS05NQVRRRDBzSU84QktEWDcvOWZteHkyTmhO?=
 =?utf-8?B?UzhVRzVGbTlNVk9TeCtxRXlCKzU1NTRHZzV3V0h1QzRZQVdkd3ZlbFdvdXVl?=
 =?utf-8?B?cHlWbWJ3OE5lMlVoc2cxOEpOWVNLMEhGTVVFaTJZZkRCUW5LZUtqQzJCSDFJ?=
 =?utf-8?B?UWtJdXBlYWE0d1F4bXluSFNBeTIyeXhBVWMwcEYxdW5iZ2JVZWF1UnJVZDRL?=
 =?utf-8?B?aUJ1YlRxTC9QVWVBRnlLOVRVaTd2TVZnTHJKS2FiVHEvbDhwMld3WW43ejcy?=
 =?utf-8?B?K0IzODNJOVF4NEhBQncwaEZWdFpKeW5MdEhEVnVCdVRCVTlzL1YvT0wrbDc5?=
 =?utf-8?B?aHVianNLUkxYWnRoazYzSndkWTdSQWNPWG8xN0gvQTF4cFNBOXU1R29HNGJq?=
 =?utf-8?B?ZVpXN1p1ZWp5N0c4TE03MmJKZmZUZEozdzQwWnFoSnY2TzRiODE0ZEVoSkpq?=
 =?utf-8?B?MUNxY3NDUGpOY2NEVGVHY0VLUTB3b21RaTlpUXJzMUpCcVM2ZFZVTy9MOWR6?=
 =?utf-8?B?emZjcUhCNW5aNm5ydnV1R1pKdkVBcG9UK2phaW9lQ1BmZE5RK21yWVpacFVK?=
 =?utf-8?B?a2YzTjFtNTYxZVZlMitrNHkrdTdSU1RrbExvSm9oYWlzbm9kejdxMTJPRHBq?=
 =?utf-8?B?YTZocURzV1dDQm9WdUVIUldubmZFMUhlZUxoZms5cDBYdFZEN3RYUGt6bU85?=
 =?utf-8?B?TldHU3hHOGtkRklIWUNnd1lTTTFOamZROHBwbUVVUWx5MjMraWs1a01iZmxE?=
 =?utf-8?B?aHhaM2o1SW5wQ05Odk0zYjQxMzlMZkY5WDdGUG1ubE9sZDc2QUEwOEJ1KzVQ?=
 =?utf-8?B?Yk01MGt2OUlHYlM5Z1hSMnFXdUVTY0NFa3hWTWZUYWQ3S0gwclJlUHVMYk11?=
 =?utf-8?B?SnZjSURsR0dqa1dIMTJzYVdWL2hQdldUVWVzSGxLN2hUd3p3ZVA2d08xSWVW?=
 =?utf-8?B?aVJLZUtpT3QzTUFWSDlRUUFJOHZJeDVRdUdqZ25QK08yRFIxdnc3SHJiNmZl?=
 =?utf-8?B?ekkxUld6cmVRRmgzcUNuSDJjVW5kV1gvN09MMzBDQjBTRVU5YjJzeXVXMFhK?=
 =?utf-8?B?bDRlYlM5c2J4eUdCYVdYNVUxYmQ2Z2gxRFVDWER2RXBMMk5CYnFOdXM0aWZh?=
 =?utf-8?Q?y1L0aqunNYNwK08g=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b6871ab7-b573-40e8-d110-08df3ff0a6ae
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:38:13.2220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hppcSzOlq9xBgva905A9rVZbBWbhWPWluEdOTpbvNfRaVRg1E4NjZuso+Yr8Uy+uRXV9hWikGHF/S/fWn9N1hvJAOW8OnfBZiruOhURnG1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5733
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 02.11.26 17:20, Frieder Schrempf wrote:
> This series fixes some issues in the RAUC bootmeth and adds two
> options to make it safer to use on real devices, together with tests.
> 
> Patches 1-4 fix bugs in bootmeth_rauc.c: an uninitialised pointer when
> a bootflow has no block device, a leak of the active slot name, a stack
> buffer overflow with long slot names in BOOT_ORDER, and a leak of the
> boot script when a boot attempt fails and is retried.
> 
> Patch 5 makes the RAUC test restore the bootdev order also if it fails.
> Before, a failing check left a static array in std->bootdev_order,
> which was then passed to free() and aborted sandbox. Patch 6 adds a
> test that boots the same RAUC bootflow twice.
> 
> Patch 7 makes the bootmeth set its BOOT_ORDER and BOOT_x_LEFT variables
> only for a device with a RAUC system, instead of for every MMC device it
> scans.
> 
> Patches 8 and 9 make the bootmeth safer to use on real devices, without
> changing anything for existing users:
> 
> - CONFIG_BOOTMETH_RAUC_PARTITIONS can give the partitions by their GPT
>   names instead of their numbers. The bootmeth then only claims a
>   device which has the partitions of all slots. With numbers, it claims
>   any MMC device whose partitions happen to fit the configured layout,
>   such as a standard distro installed to eMMC, and writes its variables
>   to the environment. This allows to use BOOTMETH_RAUC safely alongside
>   other bootmeths.
> 
> - The new option CONFIG_BOOTMETH_RAUC_BOOTCMD, empty by default, sets a
>   command built into U-Boot that boots the slot instead of running
>   boot.scr from the boot partition.
>   Nothing authenticates that partition, and signing the script is not
>   a reliable fix, as the environment must stay writable for the RAUC
>   variables and setting verify=no there skips all checks. With this
>   option, U-Boot executes nothing from the boot partition.
> 
> The bootmeth keeps both options in its platform data, which is set
> from Kconfig when it is bound. The tests in patches 11 and 12 change
> them at runtime, so sandbox_defconfig keeps the default configuration
> and all tests run on it. As partition names need GPT, patch 10 adds
> GPT support to DiskHelper in fs_helper.py for a second RAUC test image.
> 
> ---
> Changes in v2:
> - Patches 1, 5 and 10: Add Reviewed-by tag from Simon.
> - Patch 2: Look up the slot in find_active_slot() and return it
>   instead of a strdup() copy of its name (Simon). This also catches an
>   unknown slot in BOOT_ORDER before its BOOT_x_LEFT counter is
>   decremented.
> - Patch 3: Print an error for a too long slot name in
>   CONFIG_BOOTMETH_RAUC_BOOT_ORDER, document the 32-character limit and
>   pass on the return value of boot_left_name() (Simon). Rebase on the
>   changes in patch 2.
> - Patch 4: Reset the bootflow state before loading the script again
>   and move freeing the image list into bootflow_free_images() in
>   bootflow.c, used by bootflow_free() as well (Simon).
> - New patch 6: Test booting the same bootflow twice (Simon).
> - New patch 7: Set BOOT_ORDER and BOOT_x_LEFT only for a device with a
>   RAUC system (Simon).
> - Patch 8: Give the partition names in CONFIG_BOOTMETH_RAUC_PARTITIONS
>   instead of the new option CONFIG_BOOTMETH_RAUC_PART_NAMES (Bastien),
>   and only use a device which has the partitions of all slots (Simon).
>   Renamed from "Optionally check the partition names".
> - Patches 8 and 9: Keep the options in the platform data of the
>   bootmeth, set from Kconfig when it is bound, so that tests can change
>   them at runtime. The boot script code is now always built (Simon).
> - Patches 11 and 12: Set the options in the tests instead of
>   sandbox_defconfig, so that the default configuration is still tested,
>   and drop the #ifdefs. Keep the RAUC test image (mmc10) on MBR with a
>   boot script and use a second GPT image (mmc13) for partition names.
>   Also check matching names, a slot with missing partitions, that MBR
>   is rejected and that no variables are set for an unused device
>   (Simon). Patch 11 is renamed from "Test the RAUC partition name
>   check".
> - Link to v1: https://patch.msgid.link/20261029-main-v1-0-b5a878627107@kontron.de
> 
> ---
> Frieder Schrempf (12):
>       bootstd: rauc: Initialise desc in distro_rauc_scan_parts()
>       bootstd: rauc: Fix leak of the active slot name
>       bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
>       bootstd: rauc: Free the boot script of a failed boot attempt
>       test: boot: Restore the bootdev order if the RAUC test fails
>       test: boot: Test booting a RAUC bootflow twice
>       bootstd: rauc: Only set the RAUC variables for a RAUC device
>       bootstd: rauc: Optionally find the partitions by name
>       bootstd: rauc: Optionally boot with a built-in command
>       test: fs_helper: Support GPT in DiskHelper
>       test: boot: Test finding the RAUC partitions by name
>       test: boot: Test the RAUC built-in boot command

With the bootstd subsystem being orphaned now, is there any chance to
get at least the fixes (patch 1-5) upstream?

Thanks
Frieder
