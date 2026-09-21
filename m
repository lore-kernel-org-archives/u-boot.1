Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0EBC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 15:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13D8D406C0;
	Mon, 21 Sep 2026 15:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUVLSbK_d_FK; Mon, 21 Sep 2026 15:28:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 34FCD40699
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790004485;
	b=UbQlPMZDcZ3yNab1bCQ2KCUphGFUhKIc6xgGt46CWopGDgguidoYLd16YQT6uZ86Qk/U
	 prZwVVHwk+gwLT5lRbZYLah4cdpgfg1ifCBo9gxFcO3U/fvxLNenO9/kMgjRi+rmSGY0s
	 k97ejJf1wYn/vrQGefw2fY4nPfz7dpDvUuqWEF/V3buisukhBN2cDbxm2sTpOF/JB5m7O
	 QrMBU5oyDAGAMH6aCAFfWd/Doy5iyhkgWv+jTcbbuV747qc6WpE8O87QpER5LgPg709CZ
	 8XT3WwE/Xak9vdZfsoi8e/wuWZT0abFG4LWW4mLtepW7izVeb2TZrSXgk8sBn7JcIMQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790004485;
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
	bh=IEZbRgHJHquumwavldHl4nI3r/1RM8kPgwSquR6oQ8o=;
	b=bd0hUmtl9CkzCVwwbV9I80x60C0kE+J3f8wLqhiVKMvrowMbWlA0+OmS/2QlsuCY6qcy
	 Zp8jZsStDSuX9XnzntQhCisA4c+6rm+vC/vO78xZj6dZBvUmG4X+8bdZfkXjxRaW2jqlj
	 E6yFjGuBqtqxiVbvWHGWwmmYVTF6sl1szmnj7isvoErXub4eO9WF/sBTJykkBcvJAsdGp
	 BZ2aqC9KTUm57rL3ZCpsSmjAilImB+RHpfDvFkQ/r8IbIznvqgY/7MHTTXi9g5Vx3qxyt
	 QcgNuxgZZsvsMKZ4Rf0YDh3yDOKYI3ee+aYqQdVgqCG1RitYAFDf1UAeMbL0baW8AeQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=DO9PNZ0r;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790004485;
	bh=IEZbRgHJHquumwavldHl4nI3r/1RM8kPgwSquR6oQ8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kadsrp81ITUCIsTq98CWNxklcT6dewQ8i33Zs127gEpdtxLNoZhArWdWjWwPcnKrY
	 wyNTXqG7sKIOaOBt/VVPM+hBpOCo4v3RdNIl8WtjDM9KNqjUOfuSy0jHqJBWgytDkT
	 IndtUMdzp+Mwa4oPLbR9XB63z8YmcFopNq3UrHg/egnqBtkPfmqyY4qgrWrNJeVL2x
	 1TJYmEVWWgt3LV0hWhU/HCBa4+TdPrh3w6zhHSOvxAnWDhDH9KpmavO4KeyVzVY8Yj
	 U/oI2fhFsxkNe8wFVLWb8nSj9sT3OOKg04W+sK/4PZW2NA7yKt2BuLE3wK/T9EWIoD
	 mSgfFwtQ2zhaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34FCD40699;
	Mon, 21 Sep 2026 15:28:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1182013D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03480406AB
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JztMyQTwPJnw for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 708AC40694
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790004482;
 b=U0+otN6zazRJUc+Z76HG0Qvxq6vqICZVSpJSV+XBAi8EHGsyDsirsVZ31k64vt1O8uwg
 vkXdIflLv7N7mBxQuZtsIJoX7y8sh1VyCUaaJ9Fc9gKU7wTiEsEfI8YJ3eCGng8VYF9u9
 nslN9/96u0XaIoch1Q1v/w0XZEwAIQvLhQWpII77AWvzjhBDdGm/IGj31cw7vQYsMIYn5
 48ecrelZjWMddX8SqGgrNvxgaTnk9Y5bIR5pXIjtpatN2ATIv5XCCo7zFobl/1/aNk8oF
 IivQ9nZ19Ex4Q6KrwasSSl9WVIGNBwdbHP88flGW3uRQarj9W+792PNf/DyJrK4vj+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790004482;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=IEZbRgHJHquumwavldHl4nI3r/1RM8kPgwSquR6oQ8o=;
 b=G/um/h5solwy0Hwgp4GdQLYxFLI5u59Ih6bl3+LN4pzBMaAdVQwBRnIrJtJuJxEzOMfR
 rsln3uafR/I4weGrlVFOygJFWuUM1iVSAa9T8r2n5wjQzr6qgZpvtfvXnuCJFiCRQiyY0
 qNBZSHdjh9qSdqiEae7MWRfVwYSp/Ln3WovqlYB+ZfpWhvpiSQ27jV5uGbHKktm//PuiJ
 rbeFX+6BSrEr3AHBGm5tWiud6O/C2mkp7tSAqBpzQYjRPZ6yFgwlwjHn4nJpEIeUgQzOG
 VR+tRuMln4e/1d6rar7qQV2bBbKfn9Xok0LZxbbxUvuC0B2XEKHfs5QeuRWvLg7sW+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=DO9PNZ0r; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=DO9PNZ0r
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 708AC40694
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6DSm0Bj4Ec7INCdzqgAP87eJxjtU02xFFzoRCl9C5PQw53pgn3vvdPa60rnUtM1qxFxOd9nZ41XS8gto3bAWGPxtADUe0/Kbl0TTasX7b4uodYFB9EOAzU8RAy09y3qQalxJKRYHDB3VCiR3j401KfFHsGa8+NwwQlM7bLctO6AijjGf7T/tSBnMa1OZ5zCbIoeDMTyC9A2wmLrl9IaYAC4wH5CTFLMyA2eU8NTC1Q7X3tROOuzEDLLcCzaTtNNPu1mh9Hp6JjplKnydhSZ0RWYuWzEW+qqN1Qjgif2mUO17ZlBXtpJ4RQo9iORDi1kF2wIYvpO0VA+r5hkoXJ4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEZbRgHJHquumwavldHl4nI3r/1RM8kPgwSquR6oQ8o=;
 b=H2KZpOVKJMHnPQDEfi8CJcSYq9G3mHKJCc61rW9PbrqU/R7LbR5mOkRmYjqIgfP/Miecge6ts08DPoSxziRvtMs/qxi016VHackTH8M36aXELCKPOP+elsUeovPO3dQ2i5hkzOh+q9sWzIuaPGc+KZGQU0+g/AVtltZgZtYtDLvkdP+yIGC+3iJvIb6j5Uytg/rFtDdDpxaotk5CcwraDHTUUYM2oDHKVT9kCHxSVZFUq2Sbcnvp/MRaJ9nq1VL2n5eE9juSZQFw2zHlEgPT0SKtJjq6xBl9HtnWuwBFf07YJlrl4VSyRmDj4pdlQhhPtKbgI9+gm5aNuGvC3sTeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEZbRgHJHquumwavldHl4nI3r/1RM8kPgwSquR6oQ8o=;
 b=DO9PNZ0rN0BSSnQK9b5FcW0YT/YRMqmQ5wXPHCcwllx9zrgIjEkrfip+4E4aEa1c1Q/zQItPZts35tMXKq+1zJXokq3KyXmfUv5Rr7lU0y5L4J8p68+qPyswJVWsaFT7Qr9/aYOUVMEjrUigrwV3Zp5gedPaZbS60SAGD6sW4is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MIWPR04MB132055.eurprd04.prod.outlook.com (2603:10a6:290:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:27:55 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:27:55 +0000
Message-ID: <57a4b7b0-2a4e-40c6-9680-de942d5fef65@cherry.de>
Date: Mon, 21 Sep 2026 17:27:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] spl: fit: Decompress any supported algorithm
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MIWPR04MB132055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eeab0cc-b0f4-409e-65ef-08df17f4e8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|11063799006|5023799004|4143699003|56012099006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: /2NB9h+GM70KFRUoDqQ8F8B9t+QEGS6/Jy3TSu+UxqbICpHc3D05b6tSfnU6wLAu8DIPBqUQag3UpNHNhjIkY3X5Q8PfQKfprSUYjlwSqa8zFjzw6nMfDfnaUxzryy/w8xkZmdfJHf2sJxHcszJnF5r6X2hb5tJr/9FyvnUmfeekawK7U1kUsorhbLV2q8IlA7mTj0fRQwwsn0NGTTDanUQzWPGfVNZYnKq/NPebv0SlWQZh1pI0jgicOKExNYG7sLzQ/O6fEQQATIKnvu3CEH8F6Cs2yCEIHvpaA+ZNmfvydBQS6NgYEHFB3UVa/MyBHLpqtl2v9t7OeE+EYqhwJHofjeeyob7k0f1yp4hQyRjQKlS4ibNw8WfEj5k3pN09+gTtka6S4v9p/E0mviRC4ZlOXfK4cN/lx0Bn9/Jj45yYx32yTNVxHQqdFWt2hk1ceWkrQvPmniMS3ix2MuGW6JTr1bGD0TJr9aFQsa1FTyO3Des5WaSoEUHFyXijTTtSmQGV+fYgvLbVhcQSJYVh4D1UCYAva+EMTbdJjoMgj1CTqo9x0R7pGCrxZ7BJzCdtCqxLAXnMZuc9oqyGmY74vL6X+axIepavLdqr1Ae/S/vuP7bj3QGyk50X9sQS7Ibj1PcCg3j1PV6bRNGDMB8mEWhbXVqv8wRAvN82LgUqjYiMAiKN2xBIunbYtuq0ybWFi6BSmtYzbYH1yvj5ceovsFD+W+VGe5URuZkRBw/5NO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEd6Y0hHS0tkRW5lenVuaUdwdFVsNUx6U3BjM1pQL0hwWW1hdmh5T0J6U0pQ?=
 =?utf-8?B?Q1F4TDEwSm9tTHBKMmJ5RDRUSmRsdTlPYUVpUHB3RkJpbUsxK0pMZDRDdTBj?=
 =?utf-8?B?VDhnckxiMnd3V2tRUXlRalZWRXUwWk94a0pBZTZWZmx6Nit1RDZ4NXhrSjVt?=
 =?utf-8?B?MDM1SzlKSEZYM0dGUlI3blp0cTFpTFBJdlZ5Z3lXa1loYWNodTRPRkhlSmp0?=
 =?utf-8?B?aFJYenFzelByNXVHZlkvL1NaL1RQdkFwOTlyK1NKcmNESVNyaWQxMUQvWkJL?=
 =?utf-8?B?WFUxanQrODAvTGRZR3djT3FBZTd5RjArcmRoMkNobUlURGV1ZytlaXV2clpi?=
 =?utf-8?B?Zk50Zk9rUjJ6OUg5YTF0TlZFWlZxWk4xMk0wMndWVmtXd3d6bmZaNElPanI0?=
 =?utf-8?B?bXEzMzAycTlldzdmaGZMS2RveTB5VnFsVk92YmdTWXM4WHpjd0pxVDFpMkEr?=
 =?utf-8?B?eHdSdFlxZHo3UFh0Zm1tYzBKMy9VQ09qNWtOcWxBeVZNc2pnQjFiWWU3OTNm?=
 =?utf-8?B?MktCYzlRUWFBVWZ3Zk1SeFNrZ3VGb3NiU1YxK2pWQTlZaS84aFZRaGxRLzUz?=
 =?utf-8?B?eG1RbnUrQS9pMko5eUhuVlE4UUdGVTRXYU8yMXdWNjY2OWl0KzNZaGUrdk5T?=
 =?utf-8?B?RStDR0pWbHN6OERBc2M1Y0wzbGlyMTF4QmpRZW1hWlJwN2llZDlXYSt5TlR3?=
 =?utf-8?B?U0dyMEZ6dGVqdnpWUVJ2L3N4N3lnc2VGSkVhdGt6ZjAreERSd29WamxxWito?=
 =?utf-8?B?S2tDQm9TQlpET3pPc2VPQThmTEYySGdXWmVieFNpbTY5RmRHZDJoaGZwbU9D?=
 =?utf-8?B?eE0xN0g4dGlGOWtGOWRIdktVVWZZcmQ5a0JuWUo4Z1VDY1NWVHRIbm13VDVp?=
 =?utf-8?B?bzlCVWd0RXREOXFlVlBmT0hxZUs1RVBwV0hsMzhsZVlLaXUybTBpcFJjaE42?=
 =?utf-8?B?QWRoNzhldGlaZ2FaY2N6YW82S0wvN0haNWdnUkNsQkF6ZzNNYlgzWWhsei8v?=
 =?utf-8?B?MnN5TjA2dU40QStaTkpJbUIvamxyZ0FDS0xrT1RXZHEvY1NXNFV3c25YQVpS?=
 =?utf-8?B?em5Ocit6V2o1QWM2K3BNRzNWdGIxdjZ6ZHNScG5uMEZuK09TQ2VsakVHZlJR?=
 =?utf-8?B?aHArZGlQMkNONXZNNzR2R2RDajFVSUlmTDZsQTlVTXgzU2NtTFZlekFUZ0U2?=
 =?utf-8?B?RjJ3dTVTc2NvWCt6eDFRVlRnN2laZ3d1ZUh3c0NWbWxYUHVqQ3h6QWdzUUpR?=
 =?utf-8?B?MG5BblpmMnpJNklMN1l6UndXN3JRQzlVUWpsWk1tZ2Z1Yk5JZVROakR3cXVr?=
 =?utf-8?B?RG9hQm53MlJ0RS9FVGNmVlJzelg5cG1WS3NkdURVZmRyY2lndG5Wc1BRSEVN?=
 =?utf-8?B?ZXhrVDVrRjEzWFhYbFNLeUJPdEcxZjdVWWNEOWliVkU2MUh2OTZiOThwa2FB?=
 =?utf-8?B?KzYxaTZtZGJLZDN4d2U5TXJzRGxYQ1hYM0tpKzFrL2FlTVBJam1wdVBQMHg4?=
 =?utf-8?B?ZTJCalU3d3Q0YmlKTmRnaVc3alNpRjNYalRTcUZnMk8yV2pzVW1hQzZjSXZB?=
 =?utf-8?B?eXVJT1d1YTlqTExWMk9TNVNyQmxsUjRjNUN0cVE2RS9YeGFodldCblovUXN2?=
 =?utf-8?B?K09KVzVSWXNqVW0vaXkyZGN6bXhpTXh5OWJudXBBc2pXVUdUS3R0US9ZNFV3?=
 =?utf-8?B?VnpmZlBDcmVZVkZ6eGhqNTZMWXJkd2NUU2JyVU00RDR6ajk4VUlLWVpoWHVO?=
 =?utf-8?B?ZTNPczlhckxTV0VLNmdubVhWSTUzQnRVS1d3T0Y5N3dFZ2U2NncveFNDNzFR?=
 =?utf-8?B?MmFBQkgwVlE0czVCd2NiYm1ZdnZjaFV4MStxN25xRVlRSld5UHNZK0wxeUZP?=
 =?utf-8?B?OWFZVWtsbVVKUlFGTlFLdUVFOTZ2STNyQ0hoYkNLTnVrRTlGOGtTUHh3K2JF?=
 =?utf-8?B?cWpOS29DWlR1cDFVSzNtZktrOHdEeWphbE1nbXlldGN6M1E5OVN2N3pYSmJr?=
 =?utf-8?B?RkRBTUNWSHZTWldhL25OK1ZDYlA3eURBd2NaTytWdU9PbnJiNnZjbkEwYTBv?=
 =?utf-8?B?TE1BL0toOGNTamUwSElPLzFwNWJpdXc1eGswUVlVVWVqMWpnWkFKK3FrNHVz?=
 =?utf-8?B?ZHBVQ2k2dlliaDhXZitLQm5BYXJPNUh2T2hmTEEzYnVjMks5OVJnWXpEUVZu?=
 =?utf-8?B?aTVPMFk4SUFoZmNzS09BclRZRzc3UVh3Ni9EZDZ0QkFJWDAyZzhPWkR1VHJR?=
 =?utf-8?B?bzFraVdvSkgza003cHdIRFdZRHJEN1ZYNDVCajlydnlBelJwblE4YWpqdWtK?=
 =?utf-8?B?NU5CN1RYdmNRWFhXNzQyT3o0RlZjQ1l4NlBXd29NQ3ZtdEhkN2VpZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeab0cc-b0f4-409e-65ef-08df17f4e8b1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:27:55.4807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWxwr5VJmGKUXrYYiqWRh/osgM6vLRLJxPOWO8bfdzXsY1buzMMNwgUvjtsl2T/bEFteE3Vv3bNoXYtezvyAyxg7UBGRFqfsaFHF/tJEkqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB132055
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 9/18/26 12:52 PM, Alexey Charkov wrote:
> load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
> with any of the other five algorithms image_decomp() implements is
> silently copied to its load address without decompression and jumped into,
> causing a hang with nothing on the console to aid debugging.
> 
> Call image_decomp() instead, which can handle all compression algorigthms
> enabled in the config, and will abort on an unknown one instead of trying
> to silently jump into it.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   common/spl/spl_fit.c | 27 +++++++++------------------
>   1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index e02c746af5d3..9a93487bf0b2 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -6,7 +6,6 @@
>   
>   #include <errno.h>
>   #include <fpga.h>
> -#include <gzip.h>
>   #include <image.h>
>   #include <log.h>
>   #include <memalign.h>
> @@ -260,7 +259,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>   	ulong load_addr;
>   	void *load_ptr;
>   	void *src;
> -	uint8_t image_comp = -1, type = -1;
> +	u8 image_comp = IH_COMP_NONE, type = IH_TYPE_INVALID;
>   	const void *data;
>   	const void *fit = ctx->fit;
>   	bool external_data = false;
> @@ -364,8 +363,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>   		}
>   		read_offset = fit_offset + aligned_offset;
>   
> -		if (spl_decompression_enabled() &&

You remove this function in the previous patch so the previous patch is 
breaking bisectability. I'm guessing you want to replace it in the 
previous patch with CONFIG_IS_ENABLED(DECOMPRESSION).

> -		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
> +		if (image_comp != IH_COMP_NONE)
>   			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
>   		else
>   			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
> @@ -429,25 +427,18 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>   	if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
>   		board_fit_image_post_process(fit, node, &src, &length);
>   
> -	load_ptr = map_sysmem(load_addr, length);
> -	if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) {
> -		size = length;
> -		if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
> -			puts("Uncompressing error\n");
> -			return -EIO;
> -		}
> -		length = size;
> -	} else if (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA) {
> -		size = CONFIG_SYS_BOOTM_LEN;
> -		ulong loadEnd;
> +	if (image_comp != IH_COMP_NONE) {
> +		ulong load_end;
>   
> -		if (image_decomp(IH_COMP_LZMA, CONFIG_SYS_LOAD_ADDR, 0, 0,
> -				 load_ptr, src, length, size, &loadEnd)) {
> +		load_ptr = map_sysmem(load_addr, max_size);
> +		if (image_decomp(image_comp, load_addr, (ulong)src, type,

Because type is only assigned when
           if (CONFIG_IS_ENABLED(FPGA) ||
               (CONFIG_IS_ENABLED(OS_BOOT) && 
CONFIG_IS_ENABLED(DECOMPRESSION)))

we may pass type=IH_TYPE_INVALID (as initialized at the top of the 
function) to that function. I know because I reverted patch 1 in this 
series to see what it would print and it printed Invalid Image instead 
of Standalone Program. I'm not sure this is an issue, but it's for sure 
a bit odd.

Cheers,
Quentin
