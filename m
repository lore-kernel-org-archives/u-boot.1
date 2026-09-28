Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70759CA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3708360710;
	Mon, 28 Sep 2026 17:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fX3_Z-dG09k2; Mon, 28 Sep 2026 17:05:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2EAA5606EA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615103;
	b=QJYcu6jnvtdvCEjNQNeluJImug+tKGjdCz1rvHxD7dOBl61chmOLP6o0tD0NrI8ZxvAv
	 ar3UjKsi/lVw9qpCu4Kt4hasWVOgzBkLDDQAXBnnFvxx9Z6hK0XsfabZnYWWTCAYqN03f
	 4bffR3UrvR4KKEFZ8R/9BbOZUkpamTmULIQB2frLy6kobRP400Ho46PJQ3p9OP69vMswX
	 2Zcy+eMj3uyRibza0T7LOfbdwZ5nYr2JJdEKjb58f4LNti0yHvXZ++SjnxiBPlAhH36rS
	 O2l1SOrf8ATvUolLV4qCWrNEeIyh0fBIIgPmGRxu4SkqPWuW48j1kDKiX4D0kJGP2ug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615103;
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
	bh=BlZeLOS972VKrpoO0Vm2YiScdIKkcH0ja4yx/9myhf0=;
	b=E89qwexzgfrECtL+L3vgm8v8AWpsxlrKtobrED3MpzbXxmUoxFZ8QT6XN0M2RpPDoNNs
	 w5Ewn2f5XOSl4IOnmVxNE6no0iJ4nbNCE+o5A+VOeMqCsiYNh6uEjv7m5TmRHVgBYEPJL
	 GJcYgOU3ZclTSBpd6PiSa/97MG7fniobSs7AOvHjKDOkrZ0yMFxJpr0fU+sWlncll5kac
	 bjXJ368X/oQoO5bd3BjVFTVaFVbtbYq4HSA7qQH58/Qd8nimLv+Bbjuf1+Vw3drXKqXlE
	 D2n9vFERT88wLex8TU+4Tw0fOg7cLjSNUlR72kwgVLtP7XHtOEfPX165kB8f8zwWtlw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615103;
	bh=BlZeLOS972VKrpoO0Vm2YiScdIKkcH0ja4yx/9myhf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oa+Ornj5Zmc9ELYOEI9CViW21g1Hivy1NTtb+VaL+aci4xN0tqplFkMT6D42He7Gd
	 fXZ4ejxYpAOZgfEQ3xQdx3PzWspEyPPCkpp3B6BCg41U8C7eqrA+Q1NTo1LQ/KhRnJ
	 EYOQMatEPJiqmVkbl5ur5tcrj53ejy3yK8IFQi+XhxOsDAW7uJbuDU/1G+0fxnTAHx
	 yviznfhbZXnWtPdl07Z+t7ZboUIHaTFjWpJUHSq9cBfT/plqK5yP/fdEz+ItqS1/5V
	 1NwGX6XRH3wt5AbwixYcpcf/ESVrPtbC4gaJnk8UI5P2v8gm8+mzI2rpU917fEJyan
	 Hf73Q6/soqH6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EAA5606EA;
	Mon, 28 Sep 2026 17:05:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42E3372
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33757400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wK__IIkGtoiU for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:53:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EC96C400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790610786;
 b=a9AkJoxNuIPASjpu43ZR4sYZGl3gSQ2Ii5iNoM4T7y00HxYvOAizcWkIeCSvZiaRuPX0
 XkFStT2JcsTM/TV0J8LTJIFdSgr3nw9veSnhI7Qr4/bPXesWu5+Q6VJq+vpfzkHQqDcLW
 aK/pvyyJ9RHz/aSPoBRN03TMqFtIFLy6Mf7MaGv2j8lyJWt/69+FL0j5LIJNARpx10OT5
 Sjynzz2T8+z15YuMuK3owtRaugmtFgzwmCaRq3On/KaDsJqCnGUDWf+JYD8wfaSJW9pg7
 Gzq+EzXksvOKLU4cmmhcRaqzWv1Qn0/LLIiM8WozVjrFlYBpFD0DIl9lCZBCIVuRJow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790610786;
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
 bh=BlZeLOS972VKrpoO0Vm2YiScdIKkcH0ja4yx/9myhf0=;
 b=B7M5xZ5qb47Tx7fGumHv2z8ieSDH1noY7YOdmHqFolGU7ZC7fUqQJAzwMRlhSFe7eMCp
 b+Q/bd3MbTcxooaxh8RDvrIcYGtcETUpU1d51XewpwZ9j0p8DJIeLmCxx08VL5hJ6PeOL
 dHOUcVFRSDSFoFrGBzB+wzpRN9dhste/zEBO3dZmm2qv3wtUiCEl8ftlftOBqfNR3kfm1
 AmzRKCWSSXyweLqeiO0KIWemqPBb+pQJt1wlETkq9jmwFLJn+EGPk01Ik06PKPj3d+kKu
 RPydijmq3qIs8p6fNhWMTQPsZG+7Xxw8y/UgPozJvSvJ/uKzxaCnw9XWJSvwEx2QKQg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=F5C3AbKT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=F5C3AbKT
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC96C400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL6/YVkY1U0IqPC6QsYbMsr9g4JyTl54oCgddmADCJ6ACxPxaf2phG2l1e/62pvi3VN5YPhv0mjmy8eSwl/4nouOCqCtZ//1xwwoqpDDpi89G/Uuq9qtYOgBzV6MAcQiZDHlfj1YWmtzo3LQ5uWZ550mLHzah9rXvJ1gW5f8Lhr6UrQZfKGsKNEQxtqVeu4qYDNXcfKAZY+VFFstvQ3+Pdo7UQi3pd/KOERxZdlHOevTV1NA+aXAgOW3hoz8QuK6ZgZEpJS27sEcjGZ5fA6xOI5Hf58e8dcx04bZ5Zau4hLhdHlhMP9EIblHNv6Mwekp5NBghBlfDTuJIJdD/X+hGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlZeLOS972VKrpoO0Vm2YiScdIKkcH0ja4yx/9myhf0=;
 b=zIlu8sw1e1VlTP4YhEfgJQXD0ElsFqCNtnsWxhxEa2I3TkFo84gTsA4IPBw43Xb+GyUWQDyO/yzoAeIL0+ulTP7kvqHwfbwVJ6I2dH0ht6mnslBDPyTGabfEBBQNMB+herQiaZtwl3/+mUI6n+0ePZBK5rZrszfSp4fvMfLfS7Qyrdv7jACEKnDlaomcMVMzCTy29dRnnj3ZbSLZiMvgnZXO6uIfKnpy3xUjQjkPb+Nz7KGZRC7GilIoEAYiDIZRiQgdVO+dPvQJmYYS03nAMrqN7TVAKcG9c4v3TMUhtRlmdax78+mIEGOommongQRrPhuY/pWhispkWx20H4IVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlZeLOS972VKrpoO0Vm2YiScdIKkcH0ja4yx/9myhf0=;
 b=F5C3AbKTwGfNIV1eEvunyLQvI9uIT/ulmU3I3OWk1RmWq6ijJPqsTbTf3hn9kIgfBMh5ES+w2LkS99pFU5pDvSoSs+fqQr1RrITmCOiYZV0xMhZkJH5jsshfpChcJ6qEPRMc5znwNsFZLISnoaFF5M+4JpzVpe4QrxOGGLR7GqU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7574.eurprd04.prod.outlook.com (2603:10a6:20b:299::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 15:52:57 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:52:57 +0000
Message-ID: <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
Date: Mon, 28 Sep 2026 17:52:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0214.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::35) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3a73f9-f8e7-44e0-bd4d-08df1d7890cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|3023799007|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /7FBTeqBUNgzL7I7Xjmizc9IajxdyVa10Hl/SvWOtR1DoJGsXl1p01FSA8MgbFcbdy6wjjiCjAdZ3DSDAloGVFJ64tIcFFW4xt3VfLuxox7hRHKvOmS5KRy3pfEsKjdap0dRlfx1mgB6X7T4j8x+VRbW1qUz1SVIWKBRbUAbECIaGglqOiFh0vkxh0cmsm8keqVroZpS0rEbDiy0FkiII+uhZceoquEN33V/YsG5TZaz3gviM9LeB5gfbm2o2P7TC6CnMg2j9ven2JMgQDWJIliVcJTCJoZ7/P3zOaHL9z5cNf5s9/Wzo0AE3lNMic+mgDoWXhsKMm5v8hLsqqKvL7sysQAmmJvq7OegEiD6bqjEq2BIetAmV+uxBAXUlXtAHQOlDlRMpZAux7WyYFyOXV8t6hQBTCmxWcapm8aa8ivtlxN7wYzgpTJFCPJNDWkVMZ7yNhBF0CrQ9NDkkCr5YmzqAtUpIvanirvW/PnZVFtph/SIdTYCGLUlqorkSg+sAMZCzbiZepaBNA0DwvmAXB5mrpb1X5LNsBOoLQ2i8EtMLJUH3xrYP0u/l2c+yz7g60Eh7s9cXmWmxsznOyBxz1Fpj0E7Hpqrj6Hw4SNabQzKG7sDlNKsLewmxwVdqIMpbDf0jrdJ8dbVAUsOHhZMepn/8iUhWc7+3/5Fu5bjSdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(3023799007)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXlYb3M2ejFjd3ZHTG5zTlFwdHhuTHNpSDRra2JtTnQ2SEpxTWVzTm41S1Jv?=
 =?utf-8?B?K0g0WUtjQ2FibzcyTVByemF1dnA0TXRNVW1va1FDOWpMc3J2ZDBVRjZUUjNp?=
 =?utf-8?B?WUdFU290cUhDekZDbnRETWNTRzAzRGcyaWhEZU1zU0w3TjZJSDhRRm5XTUxK?=
 =?utf-8?B?dmVsNDVpWEVjMVduYjJuUEUxT1RFSzRtOVlPcURZbEJkUzJOSVk4N2FmTFdU?=
 =?utf-8?B?bHBnWlhMS2FuS2srZndTbTlUUnRMeTVJblJqdzF3eUdWZm1XdXVqdEdvRzg2?=
 =?utf-8?B?eU5rb3M1bXVrbVpYdzBTcTFuc2tSTTlUWnY3L2trMS8rUjdCYnozdWRvRVNY?=
 =?utf-8?B?QlFWRVU2SG9qVEgyT1Z0NTRmVmNRWStWQ3QrYmt6dUpmS3FzMVRqa0ErdzBJ?=
 =?utf-8?B?ZDFXUEZkMWp6VVFWb3h4SE04em9BVUY2NWZMUVAwS0xPTHZDZkM5dklBQlNt?=
 =?utf-8?B?RVpRd1NSUUpUMTdkbjlpbjlleUI0ZUFqekJLYUo1c05hMTVhd0xXK3FpbUlv?=
 =?utf-8?B?Ym5zam16REtkYjdtaUFEYWl6RUJ2Qk82RjFjaHU5czVuYUIxM25RTkROMkF3?=
 =?utf-8?B?RE9mSTc3MUp2VnVmemwxS282TFpnRUt4SVFteE02NVJDbVpuTUQ4TTNqWVcz?=
 =?utf-8?B?blJnVnVnVm9uQXY2RUk2MXRMV21rVFlOSEhDSVdpQmpUR1ZLMFY1UXJHM2Nu?=
 =?utf-8?B?T0VOT0hUTktLb2dQbXVTaG5UZjBobDlFa0NnZnlJOXZsaGFBa3p5NXNKbmRq?=
 =?utf-8?B?L3MxM01uTDQxRk83Y3ZRa1pob2xrTlZ3dW1LN2ZWeHA0cFNRakw2QjVITnZ1?=
 =?utf-8?B?cXRlWW5JcHl4QlZ5ci9GRVdEcW5sL3pLeXhoc1FsVkNOQXByZFhDbk1mNXBm?=
 =?utf-8?B?a0dtdFFwbGl0YXN4M3lWVDh4K3JrMTlvYTZXQXVuZElZQVVhZms4RmE0RVRT?=
 =?utf-8?B?bTduZElFYmc2YmtJdCttWGFscy8rcm9jS0EwRzZVTjExK1RPbU1OdVZRWjJ3?=
 =?utf-8?B?eGNOWHNIYzhpM05uOVErRDhaUWVkOVdZc20yRUdzVGhadkdMR3ZZbGJETkJV?=
 =?utf-8?B?RjZEaThaZzY5OHl4OUZ0K1l0Rk03TGx1Si96eVV5QjFyck9CbHQ0Mndkcis5?=
 =?utf-8?B?VlFPNWQ4RFNwb1N2RTlOd1JmeE5iWjRYNUdUcHU0d1JDbGhYKzhkblR6MmJh?=
 =?utf-8?B?dkdwTUlFNXh6MHZDNkNDZVlVWGNXZ2NCT0JpNFk2eWRzSEZtS1VLZVRKZE5T?=
 =?utf-8?B?QmpzQ2pwSURZNUgrRG0vdUpXaE5kLzRMUzg3cFVFTVZmUkR2YmhjT0RqU0NF?=
 =?utf-8?B?SkErMVUzdWY2VnRCdk1zNWpSajdFYlJVKzB6enpPNzViZEl4QWZaQ3VjUWV6?=
 =?utf-8?B?NjFja3pOdCtwOHdDZS9LODJTNXJJSG1kL003Y0NqMHdUVG9uZmlGclpMYU1Y?=
 =?utf-8?B?VElzNW9waWRNcDVFYjB2K2UxQTBCVG5EcWQxdzZJTzZ4RlFrZmM3NHpoU0lZ?=
 =?utf-8?B?QWQ2LzVUcUVEeHF3eEJIZ1NsS1ZsVUNwYnA2WGhCSGZKNkZPSURZMUZWYWFI?=
 =?utf-8?B?dThyYzQ3ZkJXVlVRbUMvb3pkL0c4TE1iY3FJVmlMV3VpUDROQnZveFVPWnBI?=
 =?utf-8?B?T1NvdHdSL2tFOUhMNWVzalU2K3NLb1BLVExIWjNVeXhhV3BWaTZza3RmbkF4?=
 =?utf-8?B?THNGSHpXWjhheUhwb2pEcHRlbDdkNjQ1dzlRamZ6RFFvNU5qOGk1akorczUz?=
 =?utf-8?B?cnVsQytiSVBwblg3bW0vN0Zac21FOFVsd1FOVk9oY1VaOUx1d1ZIVUcrZHBT?=
 =?utf-8?B?UzdrMWpnQzNoazN0cmt4Q2lncUtpL1B2YWRTeW0wUGY0ZVRXb0I0aCs4bFRq?=
 =?utf-8?B?TmxPNEl2VkRPU2J2emlwTmdlbk54K2lvMjc5anBKeEwyT04yVnlWNmtyZDd0?=
 =?utf-8?B?MWtTYmR1cjBZNjRRVm44eUFqcVcwMVNweVAvdnk5cXdpOTVjWnR6bVpRL1Mw?=
 =?utf-8?B?UVpuT0NSa0R2cHpWKzdNYzhzS0s1emJLdGtSelJUdnRqRTdrWmZsNmkrV3Ay?=
 =?utf-8?B?R0IwblYvc2luR3VWVm85OS9yMHI4OEtMN0xMUHJRc1BTRmpaUW9VQkdsYXpi?=
 =?utf-8?B?QjRFYjdZZzFPL2lVSC9TMkdaclN3RGhlSHJObVUrdVhWSlVjdWNqMDNRTXV3?=
 =?utf-8?B?N2NPcUs1aGdXQTNQUXhud1FiNlpNTHlKZG43Q0xZMVhrdEdXSlhBM0hKRERW?=
 =?utf-8?B?RGlUMVFxQjZiU21aZnYvOWp6MjhEczdqOERWV0tUdVFyRWFKVkJqZGJxb1Vy?=
 =?utf-8?B?cTFqVTdtSHZaWE9HcWFYTXVpYks3c3A1bVRha1F6dnNnZGQ0QndhQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3a73f9-f8e7-44e0-bd4d-08df1d7890cc
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:52:57.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byRH6OXwBnQq6es+o/qevxFtCHIulvJjN2G+fjCMYTIPLzYLPUBbWVcBVRVlRdhXSBHvnR2Ln6c8Upu7aNf4UV7Felkq7ijmCimLbsEKXRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7574
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
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



On 9/28/26 4:03 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Mon, Sep 28, 2026 at 5:26 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
>>> When a generated FIT is used to boot Linux directly, bypassing U-Boot
>>> proper (Falcon mode), there is no runtime code to discover the kernel
>>> command line and (optional) initrd location and include them in a FDT.
>>>
>>> To facilitate easier preparation of a ready-to-boot FIT, add support for
>>> pre-patching the FDTs in a FIT with a preconfigured /chosen node including
>>> the bootargs and initrd location.
>>>
>>
>> This sounds wrong to me. Why should we hardcode those at build time? We
>> already do DT fixups in U-Boot proper *at runtime*, so we should
>> probably do the same in xPL when booting in Falcon mode instead of
>> hardcoding stuff. Since you're aware of this, I'm guessing you decided
>> against, but you don't tell us why. I'm a bit worried going with the
>> suggested implementation means we'll eventually have a binman node
>> property for each DT node/property we want to write/override.
> 
> The "regular" Falcon way of doing things (i.e. the one not involving
> TF-A) has so far been: "capture what U-Boot patches into the args to
> be passed to the kernel, package it into a fixed binary, and boot only
> that". No runtime fixups. So I more or less followed that pattern, but
> tried to make it a bit more accessible by eliminating the "capture
> something at runtime and save it somehow somewhere" step, which I find
> unnecessarily painful.
> 
> Maybe runtime fixups could be brought into xPL, but they are
> excruciatingly slow, whereas speed is the main reason for wanting
> Falcon mode boot in the first place. Right now with Falcon mode on
> RK3576 I'm getting 2.5 seconds from applying power to _userspace_
> (i.e. full graphical UI drawn on the screen), whereas the best I could
> get with U-Boot is just over 3s to its boot menu, much of that time
> spent going over the flat devicetree before relocation in O(n^2)
> passes. And those 3s are after stripping the massive pinctrl node with
> hundreds of its always-present children from the pre-relocation DT,
> which alone saves ~0.4s.
> 

Are they always present, even with /omit-if-no-ref/ instruction? Or 
maybe you're building the device trees with -@? Trying to figure out if 
somehow we have a bug in dtc (or in our scripts making use of it).

Don't we have FDT and DM in SPL anyway as that's how we probe drivers in 
that stage (not counting the few SPL-only boards we have)?

I don't have anything better to suggest, I'm just really worried about 
the potential ballooning of properties we need to mirror in binman.

>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>    tools/binman/entry.py     |   8 ++++
>>>    tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 111 insertions(+)
>>>
>>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
>>> index ce7ef28e94b1..e0dea8bf3a49 100644
>>> --- a/tools/binman/entry.py
>>> +++ b/tools/binman/entry.py
>>> @@ -636,6 +636,14 @@ class Entry(object):
>>>            self.Detail('GetData: size %s' % to_hex_size(self.data))
>>>            return self.data
>>>
>>> +    def GetNode(self):
>>> +        """Get the devicetree node which describes this entry
>>> +
>>> +        Returns:
>>> +            Node: Node for this entry
>>> +        """
>>> +        return self._node
>>> +
>>>        def GetPaddedData(self, data=None):
>>>            """Get the data for an entry including any padding
>>>
>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>>> index 32caa03a7e16..750ff5b47ed5 100644
>>> --- a/tools/binman/etype/fit.py
>>> +++ b/tools/binman/etype/fit.py
>>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
>>>
>>>        See :ref:`fdtgrep_filter` for more information.
>>>
>>> +    Patching /chosen into the generated device trees
>>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +    When the OS is booted directly from this FIT (e.g. Falcon mode) U-Boot
>>> +    proper never runs, so its usual runtime /chosen fixups do not happen. Two
>>> +    optional properties on the `@fdt-SEQ` node make binman patch each generated
>>> +    device tree at build time:
>>> +
>>> +    fit,bootargs
>>> +        A string written to /chosen/bootargs of every generated device tree
>>> +        (any existing value is overwritten). Typically set to `CONFIG_BOOTARGS`
>>> +        via the preprocessed devicetree source.
>>> +
>>> +    fit,initrd
>>> +        The image name of a loadable (e.g. "ramdisk") to use as the initramfs.
>>> +        Its `load` address and packed size are written to
>>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the width of
>>> +        the device tree's root #address-cells) and reserved in the FDT
>>> +        memory-reservation map, mirroring fdt_initrd(). If the referenced image
>>> +        is absent or empty (e.g. an optional initramfs that was not supplied)
>>> +        the initrd properties are omitted.
>>> +
>>
>> This sounds wrong, why would the FDT image node need to know about which
>> ramdisk may be used? Shouldn't we rather have a ramdisk property in a
>> configuration node, and then patch the FDT based on that information?
> 
> Falcon mode boot where these are useful is for a fixed-configuration
> boot flow anyway, where one wouldn't have a way to select among

How do you plan on doing A/B with Falcon boot? How do you know from 
which partition the kernel you booted originated so you don't upgrade on 
the currently booted partition? There must be some way for U-Boot SPL to 
tell the kernel at runtime where it came from?

> several ramdisks to go with the kernel image. So putting this
> information directly where the user (i.e. the kernel) will find it
> cuts out intermediate steps, which in turn improves speed and reduces
> complexity.

You already have:

fit,firmware = "atf-1", "kernel", "ramdisk";
fdt = "fdt-SEQ";

in the configuration node. So simply have binman derive from 
fit,firmware which node is included of type "ramdisk" and fixup the 
device trees in fdt-SEQ based on that info? Less user-prone IMO.

Cheers,
Quentin
