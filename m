Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC29606A326
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bJYZ7V0G;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=cQQpVslc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4935540A07;
	Thu, 26 Nov 2026 15:32:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SsLYGZicRkV; Thu, 26 Nov 2026 15:32:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9845C409F0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795707151;
	b=PjNTgm1bm2XOCO2m5ZNMN4ELSdtq7seEwPSwxcjiYe1SEtga8DTR8Fh1N3+d0c+EkONQ
	 giEeNOJ+sauVaoXf0/xTH+L7mLe7H2iWuweKzFN13jd1yTx5i2AfR0tI28aCaiLg0CaeG
	 NYP/OeeHTyfZZ5/PSdb3Nm1zbaXA81wOfKXsWvpw0w6wQpMMAu+04Zm8QH3Ori7/DU206
	 6qjrchsmcqGUgNwXuPga4BLfF/0ztvmQJl2dipFn3E1IFogMOwX4gr8aW6b70Rslusg0e
	 WcHqiTe8CLKbO5DjULfLSGvf8e1qGAxZBpDlxDpg011Ynt3v2NLgXnynh3uEbOo1QUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795707151;
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
	bh=aCPs/hc2iLCn37snG+x5m3Sp8iXotcTKP+bDRP1TQbA=;
	b=Nnds6fpkkT5CdoiPOISbkiz+aYn7+US2NFOnxaDP2FKVPRYMnLZXL4POvkkrogs4a27W
	 X0NM277WtFtAkmHxAsUfOWdLMxiOH6+iQ+U7SzWLVca4GDXpprIVYQPfEch/5MfLwfSMO
	 6iO4Ie+JtHB6ypa1cQoZju/xQbLxkANO+nvOEktFv/+Z+Ab1nFaoTH/lRjvy03pvV2xNP
	 texDfiPwlxsPnY9T05a/M6P812p2tce0PmLwTSJx8MaKcQe8t/jkrUkspZqHevDUR83eT
	 sGMr1t8pO85qY2mqIW7NTS1bWtb1j/0cS3tqR0FYiefbijbuA+XoB0tRKOUGiG31sbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795707151;
	bh=aCPs/hc2iLCn37snG+x5m3Sp8iXotcTKP+bDRP1TQbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJYZ7V0GXo0nwenHT7Kpty5MhTrLI77aiw0YMdxfRx6GgUC9y57GO9bCzfr4Wj8gW
	 WvPa5gKE4rjqmBA+/DHNqTtZ60631Sr2p9xTt5u2WarheJUD+nnrMxBbrxpNGkVHdn
	 hLnW2A2RVpCTyay9DwDcewmzHDy1tl6lfd/sgFtdBjSUFXX1yEccO3PqrdGhWoyRCo
	 n+gu5eECpL4EVlP+KPQvBo75Zoi6s4tVb/bc0mr+rYEu+cHff29lp7+gl1PLORoO82
	 mSP96UM1QYDu04X24bMWnBlsHJ7NpjXw88DpyriFD8irY5MfolZmXyQLFD6FS+kyF7
	 s9GUYgfTXO1Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9845C409F0;
	Thu, 26 Nov 2026 15:32:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8863F22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E94240503
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ScMmfAcRnbY6 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:45:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1E0A7404A4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cQQpVslc
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E0A7404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCPs/hc2iLCn37snG+x5m3Sp8iXotcTKP+bDRP1TQbA=;
 b=cQQpVslcyNL5AOJ1UhgEAJvn+fOpwoJOYM7YNrgujWw2oSP62UQEIp7KSi389MdgZNF8ZvQjfBi9OTN5vsYmGxYOHcxqn4hPQpR7vhweAjM0FXzuHzPQ5W6sCsSfgTCnKT7/P98sE6oUZkKB8LneK8CchvgsyxpwPNo/u7jqvAc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB12654.eurprd04.prod.outlook.com (2603:10a6:150:36d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:45:24 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:45:24 +0000
Message-ID: <724d2d53-4c65-4f95-8dba-80371906421f@cherry.de>
Date: Thu, 26 Nov 2026 15:45:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/23] rockchip: Choose FIT payload compression via
 Kconfig
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
 <20261020-spl-fit-compression-v3-21-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-21-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0024.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB12654:EE_
X-MS-Office365-Filtering-Correlation-Id: 051c6511-2909-4f08-88a3-08df4bcbe766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|4143699003|6133799003|261009223027099003|22082099003|18002099003|10067099003|11063799006|56012099006|261028144727099003|261026140227099003|261022115727099003|261021121427099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003|41080700001;
X-Microsoft-Antispam-Message-Info: dDUSstpdDeG5YL+R2iZtkwI7lojxu9Cld6gZYG3CkRktQXBD/bDCwna/rUghqI/vwOK31qAUe3q1E/E+26t3rAWEEgGFIjO3VOaiarTKsFo/8HuikhCI37RLrigYsr4JujVyvI/xr9HP7cppOXSVoFahh6zKdvzF3ATUDJlKyUp/ajB5BhS9S7hiDRB5lP4R7hZ0cK4U62uorUtTnlQsYdfyEn4v4N9VmTSdQM9StVhhy6rUM/pvc6GxPIZwxP/ACBX4AThuuz+u9N83doQ8F1KcqKWvq5JPeqkb3ZfIJvZ8+nkas/BJ8eQhkqtJUlnHIxeiQ3Db6AHrshH745X2CNKgPu34mOEoBOd5mrs+GsYeXTwdcZis3MwrBFp4wfdiKifA9tx7BHJZAPEgC/4p87UbXO4KJHdxwsUSYQI0hI6jEx82E9YevEo3o+ROZPNrwXChYzQDoiXVjN+5btpYrqgYzZpEmc69htVpqjNm0ac6TdivAxxz4A2kBt6qhWqGGgbRkq9lqDEtT8eL93KlWFY0LIjHGsDRyTQV1r9Y1dR0oroeluMJWmDa8YN3dRjyCeMmvcye704wIVmwarot+X/zYxpR0oOhhAWPBkeCvKJs0T6ZRESac32H3DBG5NAXK1AG9TY9oHzw1jBkhwjUdtcM/PUVApgB9BjmG7BYNEK0ht9jOjAmiOsqApmwxIyKsZN5q8rdGqBQbZpe2yapFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(4143699003)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261022115727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFUxVXJWc0ZCTGdnbHBMR2p0c1RlNFpKTjE2eGpEZ1p6Uzlhdmw5cFBxYXBN?=
 =?utf-8?B?N0dCODlzblB0L0g2OTF6cUZuNzlpei9pdmIvVnRZdUM5eUhNWFZEdDFmSjNJ?=
 =?utf-8?B?VXY2QWUzVnYvTzVvdnJwRkxHczlNNGd4Q1VOY1NmbmQ3eFgxc0VNb0VxYS9R?=
 =?utf-8?B?c2hRUFE1MkJKYzJKY08rdEcyd3pkbnFoYjdZanlkMzkwWk5odVQ2SVlxWlZB?=
 =?utf-8?B?bk02L2lPdXRZMnRBSWp1UThXd3VuZEN6ZG4xb2hRSHRqSUdLejhjREZsZTE5?=
 =?utf-8?B?MkwvcW1GaGhKVFRiRmt0TENQakF0VFRpb21NQVFJSkNXSkliWGxzM0I4YlJH?=
 =?utf-8?B?TlhpcUtESDVLbm1OSEZQY3JCbjRqYjJ0U2NaSGVuQk8ydzE2Uy8rSU1iangr?=
 =?utf-8?B?UlQxNTdGbVl0QlVOdC9waHhoMjRWTjY5OWFwWW9manVxZ29ndERiMERRM21W?=
 =?utf-8?B?MW9Hd0tCZFJpWCtPWjhHSlp4bThMbHk2ZkZ5b2RNZ3J0MndLNFRoVjlxdHVS?=
 =?utf-8?B?aVN0YUpTZEZoc0M2NFR5SDBFd091cElkQ3kwZFkxanFPTFNqUzRoZFFRZzVN?=
 =?utf-8?B?OTV4SWswblYydzBYV1N2U0x3UXo5cTFGOVY4bkw4ZjY1NUtjOVhHWm5UVnJa?=
 =?utf-8?B?aDNkeFE3c2NPdWNLZVZ0YXo5eGdIL3Z4N2dLSmpESHBGdXJRR0dTb1hPQ09o?=
 =?utf-8?B?eVFhNkdISzhjUjhpZUNBQXkrN0gzU1JrM1FBOW5QQVg1S1lGMUhsR0pObXQv?=
 =?utf-8?B?UWZzZjgvUHkzVGZ0NEZKSk9kWm5xLzJ2dFdqb2xKNCtLdjRUQVErSGUvSjJy?=
 =?utf-8?B?WnRsR2kvdHluSnlTbDJuUXh3c0M4V29pSXh3OUJrZHZQM1NqUFlCL3NzSmhL?=
 =?utf-8?B?TmZvcnpMTFFQbVF5RHN2NmVoTkJ4bWhlU3lyQ3dtcFh1M1l0Z0FxTzNmeGlW?=
 =?utf-8?B?d1IwSXJmWUMyaFR2bjA0c2c4eXZtV0NCR09tZGZPYnQvcGNsYVpDWDcwUXBi?=
 =?utf-8?B?SENDM1A2NzllR2lsNnRXZmRJYnBCRUhoSG13RnBweEswN1cxVlY4V2NaV3FK?=
 =?utf-8?B?OExBeVJIZzR5WjFxMFd3QWpwUkcycGJGUGRsU3RRSm5Pd1l2b0dDNXFUdFVr?=
 =?utf-8?B?WFdlQTl0SUpSV2llbVBSOVlvUmtZNDgreVVuQXlqSW9UREs2M1pleUNGdWdP?=
 =?utf-8?B?VGdMNDFSbGxhS0ZQdUJLK1J1TWdnbjkyTnY1M25oM2ZmR1ZPaDdYeGMxTGt3?=
 =?utf-8?B?K282bm0rdGQ3Tk1paE5zdHEyZDJ0QkZWMDU2N3c3MlhHTnJEcURFQ0tLRi9I?=
 =?utf-8?B?aUN1TU9OaE1UdXdlSkhDQXF6NG4yNUluUWkxa0tadnZoc1o1LzhoQWZ2ZlF0?=
 =?utf-8?B?ODdvOEhHWmkyT1Rnb3dSeVZNQWhHSExvZ1VLK1VXVVdWMHB1aWdUQ3EzbjRN?=
 =?utf-8?B?cCs3ZUlvTjdYaExLdExkMHY3NlRicWhiaWRVdkJZdkI0b0VxR1hFWVdMTWY5?=
 =?utf-8?B?WjZyZW1HWTBRYk8xTEpVcWR1a2xXVStsek9PRkJ4V0hFUE5nWWl2d09xTDFu?=
 =?utf-8?B?ckx0bm5qN2dBR05RTGdhbWFKTEl0ekc5djBQM2c4enlGd1U5bEloaE1HWG52?=
 =?utf-8?B?dGFPQUI1NXhqRnRKOFpOekhyVWM0NFF3Rm5YeUNGTDNIYVZLbzVFK0FubG1y?=
 =?utf-8?B?Z1VmNGkvWnUyRXZJNFlneEZnQUNrdlY4UnZVc0VyWk5HWFZIVlRNa3Q5bGd1?=
 =?utf-8?B?ekpvZkJ1cWlERnQ2MnZtVlErRWpRUHREaktiQ1BSanM0QWtQYU56TWZxR3VQ?=
 =?utf-8?B?cE1rVUtWNXBXSVhZbk8zby9XbXVrMHZzNWxKUlRrNWdQUGRtQmVkQ3g2Y3VJ?=
 =?utf-8?B?dVQ5c2JCaG5qNVBIT1VuSTdicitwdGppQmludy9kVTgxL2VVQ25abnRUVnQ0?=
 =?utf-8?B?alJvbnRBdnRxUjltRGJQUEc5NEtxR0xRVWt1a0YvckVQc0ZCNzE2SXk2dmxB?=
 =?utf-8?B?VmpPZ09qTjloMlJ2M0pSeWtzcTBmQ2QvMmVybWRKdm95bWVOMWRtMExFT2cv?=
 =?utf-8?B?M3pKaVBQR3NPdUpza2dLWUFYdyt5b290V2M5cjBrNnNSWTRmcExNSFd5alMz?=
 =?utf-8?B?ejczTmt6VmdyNGlIUjR4MnBSRGNycGZveWZTWEV6Y3ExZk1EcXhteXMrYklE?=
 =?utf-8?B?RUZmcXJwMCtjZlRrdzAvTG5yLy9mb2hsWkk2eUtFcU01YTE5aHdsTUN3OERp?=
 =?utf-8?B?SWNOQVpzTHJHb09GaDlQQjFtVDkzbGJoZjFOR2tXdkZ5WTNBSDExWjExOVhZ?=
 =?utf-8?B?S0YxK2ZyTENieXNTamUwYktxcHp4M1V1cGx1MldLcFlHbUdKUHVnQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 051c6511-2909-4f08-88a3-08df4bcbe766
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:45:24.4226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsHuW2aJAO50dIKU7fco2QI1QiSfeNZcKrN0j5nQR0VCct5vV87seAdFulgWk5516jFF4+CtMOlf+ZOw1x8gnGY065bsOdh/j1ffrmcQCtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12654
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
> The dtsi infers how to compress U-Boot proper from whichever SPL
> decompressor happens to be enabled, so there is no way to ask for one in
> particular, turning a decompressor on for something else silently
> changes the image, and the conditional has to be updated with every new
> algorithm.
> 
> Take the selection from the generic choice instead, which covers every
> algorithm SPL can unpack and carries a compression level. Declare the
> capability under the same condition the dtsi already uses to decide
> whether it emits a FIT at all.
> 
> This defaults to no compression rather than following whichever
> decompressor is enabled, which is a deliberate change: the setting is now
> asked for rather than inferred. No in-tree Rockchip defconfig enables
> SPL_GZIP or SPL_LZMA, so no board changes behaviour.
> 
> The level is not offered for lzma, whose tool has no such knob and is
> steered by its dictionary and context-bit settings instead.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/Kconfig                  |  1 +
>   arch/arm/dts/rockchip-u-boot.dtsi | 16 ++++++----------
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3e9f3b51031b..c689c88e0bb1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2128,6 +2128,7 @@ config ARCH_ROCKCHIP
>   	select DM
>   	select DM_USB_GADGET if USB_DWC3_GADGET
>   	select ENABLE_ARM_SOC_BOOT0_HOOK
> +	select HAVE_SPL_FIT_COMPRESSION if ARM64 || SPL_OPTEE_IMAGE

nitpick: add a comment here...

>   	select OF_CONTROL
>   	select SPL_DM if SPL
>   	select SYS_MALLOC_F
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 4ba6a87e78ab..a934729df3ad 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -11,14 +11,6 @@
>   #define FIT_ARCH		"arm"
>   #endif
>   
> -#if defined(CONFIG_SPL_GZIP)
> -#define FIT_UBOOT_COMP		"gzip"
> -#elif defined(CONFIG_SPL_LZMA)
> -#define FIT_UBOOT_COMP		"lzma"
> -#else
> -#define FIT_UBOOT_COMP		"none"
> -#endif
> -
>   /*
>    * SHA256 should be enabled in SPL when signature validation is involved,
>    * CRC32 should only be used for basic checksum validation of FIT images.
> @@ -61,11 +53,15 @@

... and right before the definition of HAS_FIT to explain they need to 
be kept in sync.

With that,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
