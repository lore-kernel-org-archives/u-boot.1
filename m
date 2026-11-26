Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F3606A32D
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0moC/X5E;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=mI2MkiYj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E263260AD7;
	Thu, 26 Nov 2026 13:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 277h7uhXYzIX; Thu, 26 Nov 2026 13:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 045F460A92
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700044;
	b=kEIR23gxSwOyerkds9sTsgkBCIau/7fuxomlOI0bTo+m5Sb4is0rk60u5KpyAQ06Ky9a
	 L4FIDbXVgVLLe6NBqf0pOAKlRvTWbs/+r1FcWjrnD1FgOloT2Ok1yAog+6N7QUqSUghSG
	 lmw8jEjk1tA3AY2OziPpRl5Lxoeh/eu2Mo8WyySyyOSTo3uQXKSmbpnwso5UgVGKae3BM
	 jDGfZttVpKW3HbD6AcSB4y1Oln0d6vDlY3PN89gQ+Dab+JOsSUl7vCqeSt+H3MZayQmda
	 ufXOZe9eLSsbeR20xYva+Y7XbooPt4FSRG0B3jazoGgGXK7oyJ2fCQykn0dfzrDueRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:Cc:From:In-Reply-To:Content-Type:
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
	bh=Sa+zNw8NaK9qGALTHD50lc4fqsH8ADPg500BHBop7SM=;
	b=DeF7BZbOS4skcr6e3Tbp/dz0uDmHWrNBAdwe++1BY+/yNVuhVbEmJtj8Mkjsac1fYwTZ
	 oiNdN1sQnnIacQmOHq4vYXSHSsvz0dLb8H5hwAf4pU3tXZ9poydDn4dmwzziGkHaOEnAe
	 pfCKloQAOyGRP4R8oRD2sK5xragCWoAjAQdffgmcms8g5pMJtNfyqIlYQfXGmHyQx/Edo
	 ThiDnnYJyneA+HD6s5RdecoWavhw8aD324o02dUbxlmaUoIeZ1qDGjBNoFTSFcYSefY99
	 RjkqSYqhpgdc811Yywdz/hxhk2ZSe610zInPWjVDMo7pwWWQDl9l5ovwYucHsdGSmCQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700044;
	bh=Sa+zNw8NaK9qGALTHD50lc4fqsH8ADPg500BHBop7SM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0moC/X5EhnWr40clFrCl7bxXYKsCysbsSXXt+Ao3ITFS4yS+jLOmqHsNz/mKb314A
	 Uk6Yq/GYxTtXJElYEJzaVnzPAc6Ogo8Z3t6c3QL9usx4nCyAbpED+lCz94UUbwmuny
	 K1ZmTi98EJR1ejfuaWLl13VVj1OO3GVNmNWTWaxQQK5EyfD0r73RhVX7RpDcsNRlao
	 oceqUSKXrYtqX4yH0DLJ8j8uoFwxESLFin9zcQDkc9lm00uOFMd+22dh6cdQ5Svsj1
	 2UMo58fYC6S0S3auLzXxCl25C24meVAIQz6qRLO/frQs38xV0Nv34KWIl63OJ1GJgQ
	 mqmt1xCr0J2nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 045F460A92;
	Thu, 26 Nov 2026 13:34:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B82D1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2162E809DD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OVKXtdMSlD6C for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:58:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C681280A4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=mI2MkiYj
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C681280A4A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa+zNw8NaK9qGALTHD50lc4fqsH8ADPg500BHBop7SM=;
 b=mI2MkiYjW7uVE5Uyy4trLXy6dAePDeyAzyWzT0bnew+2W8R8w/L38Eil0o3G/Xyc8r1UqoS4phcpDecHgK2N3wnGZDtZZ1fji+94LgqXPlltPiAk41/F3kec5KB1jzmSrDj/SFZcD4YFZTg0UL3p5DK6ruTF5BvLnfSre43gbxzMDhKfMndOxmadD+eGJUBdTGDin5BDVdST2UNr2aF+ZdUihLNtsqzKVwePkQcKepsRZzQI5F3MnXtQcsB6mf6WeCaIiHWnibPZEnx3F3PJX14/rycQoxEXn9TxhWvMBp6ECnthSf2ickJyqVwI2x5vfNnB56fBs5kN8yKIGXCy+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DU4PR10MB8482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 07:58:19 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 07:58:19 +0000
Message-ID: <599f01a0-c2f4-48e4-8a15-6b5325be74c9@kontron.de>
Date: Thu, 26 Nov 2026 08:58:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] spi: spi-mem: Create a secondary read operation
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, u-boot@lists.u-boot-project.org
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Aleksei Sviridkin <f@lex.la>,
 Zunyi Hu <roberhu001@163.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Mark Brown <broonie@kernel.org>,
 Yuho Choi <oss.patchbox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Cooper Huang <cooper_huang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Cole Munz <Munzzyy1@proton.me>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261117224236.3150882-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DU4PR10MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a5c4e0-daee-45c6-56ff-08df4b930927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261022105027099003|11063799006|56012099006|10067099003|4143699003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: onTnZorgqKkt22GIePFhfa2PtCn9lGES/8EeLNqM7oYO0RGcwSbSehDJUk5Vg44FgOcDfkMJmMEjCy6U5yZ7fU3fbOPcaSqS8jOSOpuoZzg76vZEswJ4sLw1+Hye6l9y91AvdXnAESyByf+688BdmawD30ZP4AtpFKm7Z8DMAOJ7TTER+Z+VAEC9DSUkNaJQ+p3W1a3LRjQgyaJgAd5JE2NZmyNcC7Ollt4MVRnSyALaR/qjUglmcyXbEsCdYw3eyXM07D+PxaMOs8Ivtgw6UNOfWDa7LUWBP17J0YxFAiqFwr/kPLOjU534ODsWZn9Ka4VBCRe/hY+XmGBw0Kb/NV53G0HUFHbP/AzK1SNjFb8T9VoTn0DfKcdl4eolJOe0D2uD+ZCfK6LdkeA1R+fPPN3umbSgwOJ2ajRzS1FhJh2Eb7O+94Ym33+hSgQugu2y2Ik8trcik8S4YjuDBFMzhkURuXNgzmhBbHTAcG5kreZUEAiMuuDpz46IIidtt26bNmUtzmE/BtREJ84jRnX7M1kluLJw2Zah+NvSK+uuHNAJR8xmF0zeRl8K8l0ZBjSGOtlJRNVn02R9HwpykuxDUX5eKhzDlYIHDLVQMCSfetTAAx4V3tSziSpwNLG2NOoLDLX8Hoeuev7GO/bH3mrvZcuurmRHFJmAqDuGwRt7mPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261022105027099003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9kSGNrV1JnVDJrMi83QTdWbFBiL2Y3azRnZUlCWXNFWFdyajNNREdPeSty?=
 =?utf-8?B?bFIyV1lHM2dsQ0VaL2hSSG4ycFp5dzBVMTJjUXNFT3pKVzBUY1dFRFdQdTdZ?=
 =?utf-8?B?enZ2d0lFcVp1SW9FUmd5Y3VoMERZK0hIZWVwZlJiZWp5aWVHcTRZdUdrSGd2?=
 =?utf-8?B?OGZlWHpiVXYvTnRQQ1E4ak1CYXV2RWJmT2tWRDlSK3JoM3hGdWtGRFUyQkdN?=
 =?utf-8?B?K3JlS3I0SGVqdlVEM0Q4SlpiVE5VY3d3OXlBL0d0OFFINkpoQVFpM1VQdEtx?=
 =?utf-8?B?QmRGSVVBVEV0OHlJZ3NjLzQ2OGJvUmRTNTErcStpOTJlTlA4V2I4UVhIR0t0?=
 =?utf-8?B?TTNFV29ZeW00TGNsdlo0empIYkt5dHlldnAyeWcybGtoQ2lzR3lmYVlBcElR?=
 =?utf-8?B?bmp3ODVMN0dhWWFrNldzUkFDTTNrc0ZvOSszVUp4eGNHamRsSkpoSG5HajJ2?=
 =?utf-8?B?dVRaYVUwTEIwYWw4dDNTTlhTN0JLWEZ0OHRrZmJuK3JXV1NMZzZZeXF6OWdT?=
 =?utf-8?B?TngwNFptRk9XNUtHSEVtbHFlbTBJbTJ6aGwwWUE3QytkMVl4UVE2cjN1NC8w?=
 =?utf-8?B?UVlXNWRpdnFkbHEzRjNGRXBlNlZJUEc5S3l2L2Y3K0pHT3o4bFNmdFFkeXFy?=
 =?utf-8?B?eDZpamZtMVJpYkl4ZzVYNlRDUDRSWE1Na2Q5cTd3dXl1YTduR1B3dVErcW5W?=
 =?utf-8?B?U0lMVnJOOXZxa2s4SlBhYXB3NHNxK2l6UStVTGlEN25NSGw0bExjYkluNGU3?=
 =?utf-8?B?UnVtQXFQcXZTcFRsUmpmVGRKUW5Va2ZCK25VVTZoa3MzZ1hoUDk1cUZnaDlz?=
 =?utf-8?B?VGFuWEVGMzJnQjdxUC8wMjRsNDhpRGtqeEptMlJxU0EydmIySWVrcHVSNkYw?=
 =?utf-8?B?M3RZRUhjaUNzcUV2NUxQYmFWV1hOQXhoRFB5QXVyMFM4ZUR5TUxoQm1MY1Ji?=
 =?utf-8?B?c1hQU215eldoSjQ2Y0pJMWFNc0ZxSGE5REhLamFlWUM0SWZlclNWc3NCK1d2?=
 =?utf-8?B?VllSTnpMZCtxREp4RDl5TzJjdGtvS3dxV0pKOWJ1V0w4VWo4c0ZKVWNnY3Zk?=
 =?utf-8?B?TURBdXlMdmNPYlIrVzl0WlZ1SnBrbTF2NWgvamlKN0YrYllWTkZwek04aFBz?=
 =?utf-8?B?blkrUGVLMytOajJWaXJ3NmFLY2hnSGlINC80OVVoeXdJVDlJNnNzbkdheVRo?=
 =?utf-8?B?aUpkeFV3SDhJRjhWajNoR1pheUtBQTlpMXdleEorODJtaEZQME1DWi9yVVVz?=
 =?utf-8?B?ZUhaSmxzc1loQWVYTllvNnllK1FramcrRzhjckhlNHhHeWVlRjdkUnY0OVNO?=
 =?utf-8?B?cnBUbk80bkFZS29QOWdua1FwWkVZcHRJaXo4MnFQM1BoWUZJUTdUam1yYm1m?=
 =?utf-8?B?WUhYMHA1SzJOdktmdEVQS2ZkNXhDRzE2TlNxYXIwYlpHRmN2OXQvc2tVMmZh?=
 =?utf-8?B?MlV6eVBmZlhFT1lWOGYraEtScDgxdjU3cUhLT083c0s0MVk3dXV5L1BQaTBt?=
 =?utf-8?B?NXlkZjFtZTgwOVlMUEVUaUFubm15QTMvQVNvcEpta0hwazVqSnErSThIZjBk?=
 =?utf-8?B?V21IcWFNa2VwUHA2V0lkKzEwV3FnWmZQdjRTeXVJV2dNNnA0bktiamJOcGZi?=
 =?utf-8?B?U0FmaDFFb3YvZ3A0ZXNlZ1BMQnRqbVBlbDdsVzBqbVRMcHU3eGNjYWZMdlNt?=
 =?utf-8?B?cUhlK2ZCYXd0akVDM3dWU09aekZMMWdPYWt5NnNTaEdnTjRxenZOZ2JpU251?=
 =?utf-8?B?anVSZ1Nud213ODlJVFN2Q0lTREM3TldQTEFuUzhYb3hHVEk2Rld2RlBMRjBa?=
 =?utf-8?B?NUMxb3A0MXpvVll6ZGFWZmxwWXRQMzNsazFERlRTMlk0RGc5alE0c2dmTVFE?=
 =?utf-8?B?a1dmUHVvZWVWMXVsYnRaTkwyU002cnBrQk91TUN4NmNhNnFVak5DVTNOMnAz?=
 =?utf-8?B?dDFPRFJjYUZPWDM0Q2NldVZKUGF5bFlsR3ZpYk0wNHA1MDVXeFdxSGV3M0dK?=
 =?utf-8?B?UVJhb2RTY2VnNDI0UCtTdGRGdEpsbnN5NGNOM09PSi8rYlRQU3NjWUNkeGZi?=
 =?utf-8?B?amtnQ1NaaTFOYkpFeW5JK21BV08rOWhwalZXbEs2R3JUa25mTFZSSFEraGVT?=
 =?utf-8?B?c3MxUUtqNUhzcHJ2Y202V2dxVGsvZmNuSlhqUkJIQ0VzYXJkNVBlb1VlMW9S?=
 =?utf-8?B?Zk9EdDJjN3dxTHRjWmpBaFVpZU5tVlNFZ1psaHVEVDFiRllVU0hpeDdRN3JF?=
 =?utf-8?B?d1dyN1JsUkxneEh5R3A5M2hqMWsrTUJGVEl6VTFpUGJKVkp2K0xqMFFPNUU3?=
 =?utf-8?B?aElRRkQyWkR6MDczY1plNmZFMXhsWFlmQ3ZsWU1NRUpXazVLcFpjUmdVaEZ4?=
 =?utf-8?Q?dsd8u8GX8oOnb8is=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a5c4e0-daee-45c6-56ff-08df4b930927
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:58:19.7001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TDDVaYGoAySJS9OSGzM17gbbgUQKMM8ztl5Vvb7H9oGYM2sPkURpfYAqXERCmvE6AORUgCcZLXlTRMT05QiZ7fiCrce6HNcPINwpk5PfTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8482
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
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

On 17.11.26 23:42, Mikhail Kshevetskiy wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> In some situations, direct mappings may need to use different
> operation templates.
> 
> For instance, when enabling continuous reads, Winbond SPI NANDs no
> longer expect address cycles because they would be ignoring them
> otherwise. Hence, right after the command opcode, they start counting
> dummy cycles, followed by the data cycles as usual.
> 
> This breaks the assumptions of "reads from cache" always being done
> identically once the best variant has been picked up, across the
> lifetime of the system.
> 
> In order to support this feature, we must give direct mapping more than
> a single operation template to use, in order to switch to using
> secondary operations upon request by the upper layer.
> 
> Create the concept of optional secondary operation template, which may
> or may not be fulfilled by the SPI NAND and SPI NOR cores. If the
> underlying SPI controller does not leverage any kind of direct mapping
> acceleration, the feature has no impact and can be freely
> used. Otherwise, the controller driver needs to opt-in for using this
> feature, if supported.
> 
> The condition checked to know whether a secondary operation has been
> provided or not is to look for a non zero opcode to limit the creation
> of extra variables. In practice, the opcode 0x00 exist, but is not
> related to any cache related operation.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> [Linux commit: 6f96f2fa152518d93ffeedbea781db50aef7f7dc]
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
