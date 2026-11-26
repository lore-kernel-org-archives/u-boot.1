Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432EB606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KJnXB653;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=fA1Jyi/s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D93DE40977;
	Thu, 26 Nov 2026 15:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZpiTnbqy2iid; Thu, 26 Nov 2026 15:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BA8E4095D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795707148;
	b=puvpbRiAA0/niy4Gup0qAc7ZvZLGN4Ii95WcTbnEHxBR0xXqqcAKAFPpp/2juuezkxIw
	 cEh8DeilZR08KGeSMhR/ZVP2DlmGJxb10IIByBBN4yo/a3GYr7xnLAeCCFKY7TD+9uLGf
	 21qm6yfVWvnPdMVOJoZ51lHCUnYC3yzEwJGlWfOAVeAZqPz0rjujjMsyEhAy6FbON42gf
	 0hjHdak45RXmLl9XH9ewpGVU/qunmGdxCULTKTtYpSJ1NOjodufbKs4H3jKxovp6PWFz5
	 A+zNVucSnAjVBKhJ08+cRVOp8gm3K0FYDkZc5IEU2JWpR64uMnc6dzjQmxCF1x6gw7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795707148;
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
	bh=Vl6Qum7mFC9xvXYPK1ptKafxONW5Q5j5dP5oOZpRrXw=;
	b=aqgYqSJzRD2DwCAadDam1kuTse9jFQxDknZmXpWZ/8pe7Hz1GoDdDli4sHgh6+F7YSnm
	 qihnSaU8JCuioP40EQiETSJBdsK9OLcjqK8vlXh46f9Sw7VokPxzMJGlHkdIxKas4+9Ri
	 3rEr/zgqcXlqkTyJOBfrx0V+xqhc52UA6Nj8S7/OxnNefZAbErWSIUNV6EsNBRutul+7z
	 8M6a3UwIT+XsfHBEkCdEEBLmD2v4dsy+DJuKsql1LkxsX2wrNEvbdpy6Aw7VV+lpolqZK
	 0U2u01FizeADACzs4Y/l5X6PdvmGvx5O+f6Aw1w9jVgGfhAqfbAaG8c1InKtOYh3DhA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795707148;
	bh=Vl6Qum7mFC9xvXYPK1ptKafxONW5Q5j5dP5oOZpRrXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJnXB6537T0OGyrEuC5U8O2NaFGBsxgvQKX1oRgw9qwEQ6Mn7KQJOrctl2bA3P3ry
	 wAaSKE/bHT0X3XjHlhQobZ93XOUvcckNf/rurNobvJgYIyFDnyWoEMr9KY3F2arYg8
	 LPDYxPGeb2GtjJOdP1eGTANnyfwykBQRtsigyioxr3LDhQRZQ11dLcnk6cMe5m2lnd
	 SbhjzLFi/ae9Ytut7F3BZzcMho4puSwkyGwAAg5arGUn4Nb+AoC5W+/UFokypRh2dh
	 zXgDprIMaAzLE/UoFSQ0aefubNJTi6KactUOw/EBDoQjAg7dyIgO4hdUGpYsMBfq1B
	 ihYabc3XCbP4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BA8E4095D;
	Thu, 26 Nov 2026 15:32:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3B5D10B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A47FD404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5llopz7iQrR for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A85BE40111
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
 header.s=selector1 header.b=fA1Jyi/s
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A85BE40111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl6Qum7mFC9xvXYPK1ptKafxONW5Q5j5dP5oOZpRrXw=;
 b=fA1Jyi/sXBaM8kAbVkVax+XUJgiq7uj/d8i6LkWrK+bmBjadYenkA5ZH5PfvW7FJklgOQKPGOKeR72IAeCxigvW8R+Z4zvNxDZG/BcB+MHXOX0dPSLKbjAc8vmRbSCKRWGEiWLvXgVrV0xuYxar5IG/aB8F4q5yCAUf4Z7j3CKc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA2PR04MB10214.eurprd04.prod.outlook.com (2603:10a6:102:404::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:18:09 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:18:09 +0000
Message-ID: <60f878fc-9614-4f0b-9ba4-0041a944a577@cherry.de>
Date: Thu, 26 Nov 2026 15:18:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/23] binman: Allow choosing the compression level
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
 <20261020-spl-fit-compression-v3-18-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-18-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000014B.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::89a) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA2PR04MB10214:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a27a3b1-610d-493c-e0da-08df4bc818c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|6133799003|17002099007|261009223027099003|22082099003|18002099003|3023799007|10067099003|11063799006|5023799004|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261022115727099003|261022105027099003|261021121427099003|261021123027099003|41080700001;
X-Microsoft-Antispam-Message-Info: dS4dUmplRpIQl4bm6Rv20gC78nTAvBTeONSdT1Pb8GPHFYPjpALHKe7Eqdv02IBpsOtBS6W+yW9NqzoCSn9qVOIKzLuXg6qTXEL8gbhJryyJwv8wxKxT5rmXDhu9DCpZ1jAYFm6uNpSKkkbYZ99501koSnDWkr95/F3BtKBm6eVuJCgp12I1K7YQntKnPTESOeus0CVnZTZ+1wK1/GFjWz/jegnPDy/FGNYMTizbjC1/bMbOBTXUleBg+Bytd2gRx9aItz/FvdfAX7nVuDXrWQxeIwgNPjcZIHNBKTRCe5qUDDA1TzqXDmC6f+bTiHWdp3pcjG5zaVzoQ2UYmoT1/Gfd39e7yjU3BvrJiLcIp9WWJ8CSd6vC+wtDUgynXcKwBaxKY1jWGecw0WkV+ZX5FY52kqsClESFQy9rq8UpkSWGBSAYzllas5kA+gEAexAEJM+UaF4yRh/R8g0VHZzns0d3b0ODboyWaiz1dp4hhTOzCeeKurx6GBlOC2V1owkfbj8gmdabT6W8ksNcQ1Rznv1aMl//uzF0kV4e379ZppZKZ8ehSfLEajtCXUDD9+Z3gBto1+JSKbPy5gZyBUfv9CEIogUZIW19WNWt7/3nIQqO9c9WhqsN2C3dqX3+2Z+r6K6vylgQmRMAn25ExfuYzjZhSWrC2A0qeIqbEXgFv9ZKDoZVvSWb+CcGOcWEwq4HyBu/d1tNyj+ye4BMP+Zs6Nyg9IAMq/BPwJWN0Bh8HCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(6133799003)(17002099007)(261009223027099003)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022115727099003)(261022105027099003)(261021121427099003)(261021123027099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TndUVTA1aGFteVdwWS9rQ2lpdWdOUzlSVndEaXgrNTRLZTdZL2tnN0E5S0Z1?=
 =?utf-8?B?SmM0dExUNGsxQnl0emd4TzR1UEdkNDlNSC9DdEJXWDBybVJpM3ZCRUtsK1Ru?=
 =?utf-8?B?bzE4Vm5wdU9FMWRZQjRqbG11NW0vVEhnckhWV1B2dU5EWmxlcy9IcCtuODJk?=
 =?utf-8?B?UDEzc2Z5ZUxaL3hkQk9xQ0Y4VWFZTUhOVU0zcHk5S2I2YXVoK2QvTHJWZVor?=
 =?utf-8?B?RFFoSFNaQ0o1ZlJyRE9CZTRveWQveFBDRElYNDRRZUEzWGRIMkYzSXY1L1Fx?=
 =?utf-8?B?WlZORnZJN2RlSlgwekVBclFVWXJDbnlKTWlQNVVmK0JSOTFoZXI1encvUERa?=
 =?utf-8?B?TExKbjJKZWh4RCt3bkVOSHhDNlYxZUZLZmI5TjZjWWI2NHlxYU4yUjQ0alY4?=
 =?utf-8?B?cG0vL0NVMFA5QnpGdk9ONkF1YWlHNkd1KzZPNWJUWDVjZWRVeHppMEI0Qk1t?=
 =?utf-8?B?SlZLL0R4cTZPUzMyckN3YzhzMkc1d2p1WS9saklXMlBETERPeGZMS2ZXcFZB?=
 =?utf-8?B?b3RDdjNrZkJQWkdQNXhvM0JQVW5wdFRlcktxcEwxamFRZnp2SWM5b0EwL0FG?=
 =?utf-8?B?cDdXM0tqemNzOXlYZ1o4a3VCM3VCeDVPeHpxSmVlM1dHV1hKbXhlTnU2YUho?=
 =?utf-8?B?WHY3TnFTTGZtQkVqK1dETEhCWlhTWjJHU2R1RUxhcVdOazhLS2lkM2FPU0M2?=
 =?utf-8?B?NG1rcktLRWhScG55VjdNOXRCT3hHd28wdEpjTC9Wem1SUEVGZDFpMFJWU0lE?=
 =?utf-8?B?TkxMM0NROU9BV092dnVhQVNPbnk1dkJzbXNQeFFRQVpvaUlUR3BOZ1k2b3VV?=
 =?utf-8?B?TVZCSlczbXExU2p4S3F2SVNrVk1UQm1UR1FOUzcyUlN4Y3FXdDB6aDAvUVNk?=
 =?utf-8?B?Q1lKRXRtNmh0anIvc3FxaENKVmdhQUh1WFRnTWZGYWF6OTJOTmtoY2FaYzlj?=
 =?utf-8?B?b3ZxSVZBQUJrblFJUmlrVTltSFVhbnBvUWZoQjJTdytBUUVoWDBGTlZ1VHhE?=
 =?utf-8?B?K3ZpU0p4MWFZd2g0V1ZFeHdPcjBoM1VVaERWQkVKSHlyYzFuY3hSREZUSVNG?=
 =?utf-8?B?eDJucGtYa1RmODNjeVZ4K2ROcFZNOGtra2huVVRGYzJqN3JaaG9aazNhemgz?=
 =?utf-8?B?VlhXaFRzbVRMdHlPMDBHNDNWY1NIZytNYzZSRGFYTHUwenJ1Q2lGb1M0Zk5x?=
 =?utf-8?B?VkxFRmpUUVFYREViK1lJN0ZpTGJwSWdUcEtzZzR5UUtVSCtRc1ZFTGkvZkZU?=
 =?utf-8?B?OWozVEVVY0RRMDIrOEgwcC9kSkcvMTVIYitZdithWmk0OW5qVko5eEJrVWhm?=
 =?utf-8?B?eXd3MWEzcEdUaWkrKytZTG1NWTIvUnJLZzB4Y3cvcVJLK2JMYU9pbDdEYzYr?=
 =?utf-8?B?WitQZVJ5bFZuY25ZUkFSOTZ2MTRGV1NkS0plL3JIV3JJTnhHbkhFeXBDYWJh?=
 =?utf-8?B?T05pd3VkYTN2ekdVMjZjR2FTNzVGZlFqR20vUzcvSVk0eEZjRUVpblhtY3d3?=
 =?utf-8?B?RmUwY1VQTlU1bXBRNmg1L1ptYlYrYjh5TDM3ZlBmRVhZQWJBQysycFlIdFdX?=
 =?utf-8?B?ZWkxSWREOGMwczhhbWZLVU8zMUZTTW0wc05lVjFCQ09NRkFtbzdSeXRmWE1m?=
 =?utf-8?B?VE5sN0VGSG91M3VVU0VVbEY4UXp1dTgzMy9oa3N1VVhsbmxLU2ZDbm9pOFBJ?=
 =?utf-8?B?R3J6Ry9sdlIwTm92WmZLcDgxQnQva1FYQ3lWZ0dBbjZLMUIvbnBUb1BoN0dq?=
 =?utf-8?B?MFB4aVhjZEE5d3VKQWsvSXBqTXNIRTdLY3dHNFowQ1lnMnNOMUU3OGhSMk5u?=
 =?utf-8?B?bHdqa2dLRm1EVm85cHk4d1Fsc0YyOUlFUWJneWUwQlBIdURUUzd4dFBXUFUw?=
 =?utf-8?B?K1hoSlBMTDNLSnFuM0NCVnhQY0VlQ0ZNUjVFMGZoL2l5U2pQalRkdjZKMmVO?=
 =?utf-8?B?SUhkcjlZT2pNeEJ2OTg3YTljZlNsUUdjZjNNcTJSb0ltNE13Um8wbHhPRWxL?=
 =?utf-8?B?aEdScEFZay80WTFkOExrYnU1RDN0NlZVcGVJckl3OElCV2dkREFjNUw3Z3NE?=
 =?utf-8?B?c2o2NzFielVqR0FFNXFjcFBwa1RkaHZvWnRHeDhKa3g1eStwelUxT3piV05x?=
 =?utf-8?B?d0EyVWdKZ0E3TUwvenlQTjN6REFCbEhNMVhXNXlBNjIvUTUzS1lKKzJRV0VO?=
 =?utf-8?B?eGluVnNTWEdaUGtBN1lrN05CcGVKc2hBbitrVCtJNUN5Qk52N2lrZHlURnBV?=
 =?utf-8?B?a2U5T2hDV1cyalRab2N0dnFScWFxT0lzMlpVQ0dpUFk1bFRKV3MzTXIraW1t?=
 =?utf-8?B?anNMK1NHMjJMQzEzNU1sRE45S0xsWEgxMEs1dXM0WmxKbk11Wnordz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a27a3b1-610d-493c-e0da-08df4bc818c0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:18:09.2031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1MWHtgOHq/W3qTnsU0BNlT/C3z0IiirV5M5Dz03YbIWT0Otn9uuBELHnhbVSdwL3L36/Ba07wBzWeGBpHDrhR2op+U/os2zRQNA3fEZg7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10214
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:41 PM, Alexey Charkov wrote:
> Every compression algorithm binman drives has a level, and the best one
> to use depends on what the image is for: a payload sent over USB wants
> the smallest it can get, one read from fast storage would rather not
> wait for it. Today only the tool's own default is reachable.
> 
> Add a 'compress-level' property, passed through as -<level>, which is how
> all compressors want it except lzma: the LZMA SDK tool has no such option,
> and is controlled by the -lc/-lp/-pb values binman already passes.
> 
> Have each tool declare the levels it takes, and reject anything outside
> them with the node's path, whether or not the tool is installed. The tools
> do not reliably refuse a bad level themselves: gzip, bzip2, xz and lzop
> read -12 as -1 -2 and quietly compress at level 2, and a typo or a
> leftover level after switching algorithms would otherwise just produce a
> larger image with nothing to say why.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   tools/binman/binman.rst                            | 21 ++++++
>   tools/binman/bintool.py                            | 20 +++++-
>   tools/binman/btool/btool_gzip.py                   |  2 +-
>   tools/binman/btool/bzip2.py                        |  3 +-
>   tools/binman/btool/lz4.py                          |  9 ++-
>   tools/binman/btool/lzma_alone.py                   |  5 +-
>   tools/binman/btool/lzop.py                         |  2 +-
>   tools/binman/btool/xz.py                           |  3 +-
>   tools/binman/btool/zstd.py                         |  3 +-
>   tools/binman/entry.py                              | 18 ++++-
>   tools/binman/etype/blob.py                         |  5 ++
>   tools/binman/ftest.py                              | 81 ++++++++++++++++++++++
>   tools/binman/test/entry/compress_level.dts         | 12 ++++
>   tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++
>   tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++
>   .../test/entry/compress_level_no_compress.dts      | 11 +++
>   tools/binman/test/entry/compress_level_range.dts   | 12 ++++
>   tools/binman/test/entry/compress_level_zero.dts    | 12 ++++
>   18 files changed, 230 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 3a860421a697..c661f31a7d8d 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -711,6 +711,11 @@ compress:
>       Sets the compression algorithm to use (for blobs only). See the entry
>       documentation for details.
>   
> +compress-level:
> +    Sets how hard the compression algorithm should try, as the level number
> +    the tool itself uses. Requires 'compress'. See the entry documentation
> +    for details.
> +
>   missing-msg:
>       Sets the tag of the message to show if this entry is missing. This is
>       used for external blobs. When they are missing it is helpful to show
> @@ -1182,6 +1187,22 @@ The entry will then contain the compressed data, using the 'lz4' compression
>   algorithm. Currently this is the only one that is supported. The uncompressed
>   size is written to the node in an 'uncomp-size' property, if -u is used.
>   
> +Where an algorithm offers a choice of how hard to try, 'compress-level' passes
> +one through::
> +
> +    blob {
> +        filename = "datafile";
> +        compress = "zstd";
> +        compress-level = <19>;
> +    };
> +
> +The number is the tool's own level, so its meaning follows that tool. Binman
> +accepts 1 to 9 for gzip, bzip2, lzo and xz, 1 to 12 for lz4 and 1 to 19 for
> +zstd, and reports anything else as an error rather than leave the tool to
> +reinterpret it. Leaving the property out uses the level binman has always used:
> +the tool's own default, except for lz4, which gets 5. It cannot be used with
> +'lzma', whose LZMA SDK tool has no such option.
> +
>   Compression is also supported for sections. In that case the entire section is
>   compressed in one block, including all its contents. This means that accessing
>   an entry from the section requires decompressing the entire section. Also, the
> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> index 4cf8d5b165bf..096cfc5c5fa4 100644
> --- a/tools/binman/bintool.py
> +++ b/tools/binman/bintool.py
> @@ -59,6 +59,10 @@ class Bintool:
>       # Flag to run 'apt-get update -y' once on first use of apt_install()
>       apt_updated = False
>   
> +    # Highest level a compression tool accepts, from 1 up, or None if it has
> +    # no notion of one
> +    max_level = None
> +
>       def __init__(self, name, desc, version_regex=None, version_args='-V'):
>           self.name = name
>           self.desc = desc
> @@ -542,12 +546,16 @@ class BintoolPacker(Bintool):
>               property if none
>           version_regex: Regular expressions to extract the version from tool
>               version output,  '(v[0-9.]+)' if none
> +        max_level: Highest compression level the tool accepts as -<level>,
> +            or None if it takes none
>       """
>       def __init__(self, name, compression=None, compress_args=None,
>                    decompress_args=None, fetch_package=None,
> -                 version_regex=r'(v[0-9.]+)', version_args='-V'):
> +                 version_regex=r'(v[0-9.]+)', version_args='-V',
> +                 max_level=None):
>           desc = '%s compression' % (compression if compression else name)
>           super().__init__(name, desc, version_regex, version_args)
> +        self.max_level = max_level

nitpick: not sure it's necessarily a good idea to have a max_level 
argument in the __init__

We can simply set self.max_level after super.__init__() has been called, 
if it needs to be anything but None.

>           if compress_args is None:
>               compress_args = ['--compress']
>           self.compress_args = compress_args
> @@ -558,11 +566,14 @@ class BintoolPacker(Bintool):
>               fetch_package = name
>           self.fetch_package = fetch_package
>   
> -    def compress(self, indata):
> +    def compress(self, indata, level=None):
>           """Compress data
>   
>           Args:
>               indata (bytes): Data to compress
> +            level (int): Compression level to use, from 1 to max_level, or
> +                None for the tool's own default. Every packer tool spells
> +                this as -<level>.
>   
>           Returns:
>               bytes: Compressed data
> @@ -570,7 +581,10 @@ class BintoolPacker(Bintool):
>           with tempfile.NamedTemporaryFile(prefix='comp.tmp',
>                                            dir=tools.get_output_dir()) as tmp:
>               tools.write_file(tmp.name, indata)
> -            args = self.compress_args + ['--stdout', tmp.name]
> +            args = self.compress_args[:]
> +            if level is not None:
> +                args.append(f'-{level}')
> +            args += ['--stdout', tmp.name]
>               return self.run_cmd(*args, binary=True)
>   
>       def decompress(self, indata):
> diff --git a/tools/binman/btool/btool_gzip.py b/tools/binman/btool/btool_gzip.py
> index 0d75028120fe..de628b168c6d 100644
> --- a/tools/binman/btool/btool_gzip.py
> +++ b/tools/binman/btool/btool_gzip.py
> @@ -28,4 +28,4 @@ class Bintoolgzip(bintool.BintoolPacker):
>       """
>       def __init__(self, name):
>           super().__init__(name, compress_args=[],
> -                         version_regex=r'gzip ([0-9.]+)')
> +                         version_regex=r'gzip ([0-9.]+)', max_level=9)
> diff --git a/tools/binman/btool/bzip2.py b/tools/binman/btool/bzip2.py
> index c3897d63acb5..9cc30dcba19b 100644
> --- a/tools/binman/btool/bzip2.py
> +++ b/tools/binman/btool/bzip2.py
> @@ -27,4 +27,5 @@ class Bintoolbzip2(bintool.BintoolPacker):
>           man bzip2
>       """
>       def __init__(self, name):
> -        super().__init__(name, version_regex=r'bzip2.*Version ([0-9.]+)', version_args='--help')
> +        super().__init__(name, version_regex=r'bzip2.*Version ([0-9.]+)', version_args='--help',
> +                         max_level=9)
> diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
> index fd520d13a566..609a4724c92b 100644
> --- a/tools/binman/btool/lz4.py
> +++ b/tools/binman/btool/lz4.py
> @@ -77,20 +77,25 @@ class Bintoollz4(bintool.Bintool):
>       """
>       def __init__(self, name):
>           super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*),.*')
> +        self.max_level = 12

issue: inconsistent

I know it is because Bintoollz4 is not a bintool.BintoolPacker, but the 
answer is to migrate it to BintoolPacker, not make it more special.

The -c argument of lz4 is --stdout (at least on 1.10.0 from Fedora 45), 
so it works fine with BintoolPacker, you just need to pass the 
appropriate compress_args, decompress_args and fetch_package to 
super.__init__() and you could remove the compress(), decompress() and 
fetch() overcharged methods in Bintoollz4. In a separate patch please, 
then you can use the same mechanism for the max_level as other 
BintoolPacker and be consistent.

>   
> -    def compress(self, indata):
> +    def compress(self, indata, level=None):
>           """Compress data with lz4
>   
>           Args:
>               indata (bytes): Data to compress
> +            level (int): Compression level (1 to 12), or None for the level
> +                5 binman has always used here
>   
>           Returns:
>               bytes: Compressed data
>           """
> +        if level is None:
> +            level = 5

nitpick: just set level=5 in the args

Do not pass a second argument when calling compress() if you want to use 
the default level?

>           with tempfile.NamedTemporaryFile(prefix='comp.tmp',
>                                            dir=tools.get_output_dir()) as tmp:
>               tools.write_file(tmp.name, indata)
> -            args = ['--no-frame-crc', '-B4', '-5', '-c', tmp.name]
> +            args = ['--no-frame-crc', '-B4', f'-{level}', '-c', tmp.name]
>               return self.run_cmd(*args, binary=True)
>   
>       def decompress(self, indata):
> diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
> index 1fda2f68c7b4..b5630dc618a1 100644
> --- a/tools/binman/btool/lzma_alone.py
> +++ b/tools/binman/btool/lzma_alone.py
> @@ -55,11 +55,14 @@ class Bintoollzma_alone(bintool.Bintool):
>       def __init__(self, name):
>           super().__init__(name, 'lzma_alone compression')
>   
> -    def compress(self, indata):
> +    def compress(self, indata, level=None):
>           """Compress data with lzma_alone
>   
>           Args:
>               indata (bytes): Data to compress
> +            level (int): Unused: the LZMA SDK tool has no -<level> option,
> +                and is steered by the -lc/-lp/-pb/-d values below instead.
> +                With max_level left at None, Entry rejects a level anyway.

issue: information not helpful to the user

Just say it's unused, the rest is not interesting information to the 
reader, except if they want to add support for levels. Have this info in 
the commit log if you really want to, otherwise remove.

>   
>           Returns:
>               bytes: Compressed data
> diff --git a/tools/binman/btool/lzop.py b/tools/binman/btool/lzop.py
> index f6903b4db75e..8760f843ecaa 100644
> --- a/tools/binman/btool/lzop.py
> +++ b/tools/binman/btool/lzop.py
> @@ -27,4 +27,4 @@ class Bintoollzop(bintool.BintoolPacker):
>           man lzop
>       """
>       def __init__(self, name):
> -        super().__init__(name, 'lzo', compress_args=[])
> +        super().__init__(name, 'lzo', compress_args=[], max_level=9)
> diff --git a/tools/binman/btool/xz.py b/tools/binman/btool/xz.py
> index e2b413d18bda..23b90180f7e1 100644
> --- a/tools/binman/btool/xz.py
> +++ b/tools/binman/btool/xz.py
> @@ -28,4 +28,5 @@ class Bintoolxz(bintool.BintoolPacker):
>       """
>       def __init__(self, name):
>           super().__init__(name, fetch_package='xz-utils',
> -                         version_regex=r'xz \(XZ Utils\) ([0-9.]+)')
> +                         version_regex=r'xz \(XZ Utils\) ([0-9.]+)',
> +                         max_level=9)
> diff --git a/tools/binman/btool/zstd.py b/tools/binman/btool/zstd.py
> index 299bd371269e..aac16172b5c3 100644
> --- a/tools/binman/btool/zstd.py
> +++ b/tools/binman/btool/zstd.py
> @@ -27,4 +27,5 @@ class Bintoolzstd(bintool.BintoolPacker):
>           man zstd
>       """
>       def __init__(self, name):
> -        super().__init__(name)
> +        # Levels past 19 need --ultra, which binman does not pass
> +        super().__init__(name, max_level=19)
> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> index 9b39c7118892..bd1f4dfc5a1b 100644
> --- a/tools/binman/entry.py
> +++ b/tools/binman/entry.py
> @@ -143,6 +143,7 @@ class Entry(object):
>           self.image_pos = None
>           self.extend_size = False
>           self.compress = 'none'
> +        self.compress_level = None
>           self.missing = False
>           self.faked = False
>           self.external = False
> @@ -325,6 +326,9 @@ class Entry(object):
>   
>           # This is only supported by blobs and sections at present
>           self.compress = fdt_util.GetString(self._node, 'compress', 'none')
> +        self.compress_level = fdt_util.GetInt(self._node, 'compress-level')
> +        if self.compress_level is not None and self.compress == 'none':
> +            self.Raise("'compress-level' requires 'compress'")
>           self.offset_from_elf = fdt_util.GetPhandleNameOffset(self._node,
>                                                                'offset-from-elf')
>   
> @@ -1222,7 +1226,7 @@ features to produce new behaviours.
>           if self.compress != 'none':
>               self.uncomp_size = len(indata)
>               if self.comp_bintool.is_present():
> -                data = self.comp_bintool.compress(indata)
> +                data = self.comp_bintool.compress(indata, self.compress_level)

when you want to use the default compress_level, without passing one as 
suggested above, you can use kwargs instead:

kwargs = {}
if self.compress_level is not None:
     kwargs["level"] = self.compress_level
data = self.comp_bintool.compress(indata, **kwargs)

>                   uniq = self.GetUniqueName()
>                   fname = tools.get_output_filename(f'comp.{uniq}')
>                   tools.write_file(fname, data)
> @@ -1293,7 +1297,8 @@ features to produce new behaviours.
>               btools (dict of Bintool):
>   
>           Raise:
> -            ValueError if compression algorithm is not supported
> +            ValueError if compression algorithm is not supported, or does not
> +                support the compression level asked for

nitpick: simplify wording

or does not support the requested compression level

>           """
>           algo = self.compress
>           if algo != 'none':
> @@ -1304,6 +1309,15 @@ features to produce new behaviours.
>               name = names.get(self.compress, self.compress)
>               self.comp_bintool = self.AddBintool(btools, name)
>   
> +            # Check here, so that it is reported even if the tool is missing
> +            level = self.compress_level
> +            max_level = self.comp_bintool.max_level
> +            if level is not None and max_level is None:
> +                self.Raise(f"'compress-level' is not supported by '{algo}'")
> +            if level is not None and not 1 <= level <= max_level:
> +                self.Raise(f"'compress-level' must be 1 to {max_level} "
> +                           f"for '{algo}'")
> +
>       @classmethod
>       def AddBintool(self, tools, name):
>           """Add a new bintool to the tools used by this etype
> diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
> index acd9ae34074e..111c31d4ba55 100644
> --- a/tools/binman/etype/blob.py
> +++ b/tools/binman/etype/blob.py
> @@ -22,6 +22,11 @@ class Entry_blob(Entry):
>           - compress: Compression algorithm to use:
>               none: No compression
>               lz4: Use lz4 compression (via 'lz4' command-line utility)
> +        - compress-level: How hard to compress, as the level number the
> +            compression tool itself uses (e.g. 1 to 9 for gzip). Requires
> +            'compress' and an algorithm which has levels, so not 'lzma'.

nitpick: replace "and an" with "with an"

> +            Without it, binman uses the tool's default, except for lz4, for
> +            which it has always passed level 5 instead
>   
>       This entry reads data from a file and places it in the entry. The
>       default filename is often specified specified by the subclass. See for
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 8caf275d4664..0c45c7207e44 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -2168,6 +2168,87 @@ class TestFunctional(unittest.TestCase):
>           bintool = self.comp_bintools['lz4']
>           return bintool.decompress(data)
>   
> +    def _ReadFileRecordingArgs(self, name, fname):
> +        """Build an image, recording the arguments a bintool is run with
> +
> +        Args:
> +            name (str): Name of the bintool to record
> +            fname (str): Device tree source filename to build
> +
> +        Returns:
> +            tuple:
> +                bytes: Image data
> +                list of tuple: Arguments of each run of that bintool
> +        """
> +        original = bintool.Bintool.run_cmd
> +        calls = []
> +
> +        def recording_run_cmd(self_tool, *args, binary=False):
> +            if self_tool.name == name:
> +                calls.append(args)
> +            return original(self_tool, *args, binary=binary)
> +
> +        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
> +                                        new=recording_run_cmd):
> +            data = self._DoReadFile(fname, use_real_dtb=True)
> +        return data, calls
> +

suggestion (non-blocking; not-tested): use Mock.wraps instead of 
handcoded logic

with unittest.mock.patch('bintool.Bintool', 'run_cmd', 
wraps=bintool.Bintool.run_cmd) as mock:
     data = self._DoReadFile....

return data, mock

and that should allos you to use all the Mock.assert*() functions which 
are the usual way to check stuff, instead of going the handmade way.

> +    def testCompressLevel(self):
> +        """Test that a compression level reaches the tool and round-trips"""

issue: rename to highlight this is lz4-specific

ALl the other supported compression algorithms' behavior are consistent 
so we can say it's generic, but this one is lz4-specific (due to the 
default level of 5).

Cheers,
Quentin
