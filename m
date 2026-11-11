Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A10606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f8vSJKAL;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=JVO4nWd4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3206640AE6;
	Wed, 11 Nov 2026 11:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vKalHI1DYiXw; Wed, 11 Nov 2026 11:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 706C840AE7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394970;
	b=LnUAWbbY04cgd5dflqqU+1BXqGsLTNbspJh+ayxvi6cet+KVit0g9VKYBd3HSJ6lwlBW
	 3yuTE4HuT0kbcx3loTDzvELJyF3jjBFDaCViQyLZD9zAdYbxnVF38Ov5GXFU21sokugLJ
	 4glpa+bRR0FoANfM84LWtpptawYkRjYHeVxUcaCzDubq1R5ZYZkd/F5huy3T5ZlwUMjPM
	 pOA3MxpxFxp8SjIWKBnP2OvuHJIOgKUAD9a2Lkzl+uzPhy8BYkQC87G2G7HM8qBUTEpvM
	 CZ7MgIkmeOba53QP7fyP3lxyVMEVwa6S88SBDXl6u5xUiRmkoUe5aSTKnfqT1tbIgrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394970;
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
	bh=xeWGoxn/ZZP+jKmxAL7WRv1yP9zxzj1vdbm7lR+hu84=;
	b=rtnhuoeUrBuY9LaXYsIufglVzeN1CtuMpJvHDii4n2Ib9RIw0ks5UuDhpsrSgjX3Xqry
	 dmQd31odKD24dr6PxtldhGT5sTQRXNwgldkbhkNci00COy7uNv18e+pKoTXfslGhOHdsw
	 I6OZRej9C8bVivPbx2+wIw1qDMNWXym7gI7tmza15XOQukauaxkzrcEV25L5SYsn2ZeGY
	 V73j2GmO0pjANL1yvRXRnJuOluuL++gI6DPnUt5mXqGJRgJC7ocJWl7yOmFxuR8Th4uxW
	 Q2GoUteyPDI1/9F5Nc1wniTom7xaOhHSqDDchavLV9hmIjiA4YUZjDC2fRqZMoUxLzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=JVO4nWd4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794394970;
	bh=xeWGoxn/ZZP+jKmxAL7WRv1yP9zxzj1vdbm7lR+hu84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f8vSJKALx0HJOPjLpoOERqnHyKISMW5lirnMT9hAMaYe7SNPkyfgHZ1Hx7Y+jeeRD
	 vheAdRSTyyFPI8PqfMotTZug412NWamSoZKBTLcKmmYUbWOW4Oejqt1rB88zG86oql
	 Jzs150sgplFz9zpZ0rDaRwNcYQMYVV+/U4AEvAREeJm7LC2pvpHqGYeFTlErUVV+r2
	 O1l0uRL1OAs7MeE6LQfBzyNwNMF9VeA8MOu80u//o535H6UiluuZc1D0WTtgmJjnJs
	 Ze7e1fOfWHqiyLm6xwQu1sedmOK62GGAgYA+GmKPVhs7DYWEWqNludH/XYq60OdVnn
	 u+DzINbp6ZAKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 706C840AE7;
	Wed, 11 Nov 2026 11:02:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EEC9728C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4CF740AE7
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqcf7kdlilRf for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AE7340AE6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=JVO4nWd4
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AE7340AE6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeWGoxn/ZZP+jKmxAL7WRv1yP9zxzj1vdbm7lR+hu84=;
 b=JVO4nWd4M6eXkIpNgQ2JG/mo/1tS9oOn1LLrnbnO6DUoqFd3D8yppnKHjWgBsKz6iWyJkocIW0G/y08JMnB6HLkwzovQvhzNhRnLoAvjklhSdyt1gTEw5YJUMnsSUvpnlHg8S+oGU807E3yzuCinMy7bDgvSGetYmgxkPX4vMB4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by CPJPR04MB606764.eurprd04.prod.outlook.com (2603:10a6:380:20b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 11:02:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:02:39 +0000
Message-ID: <ff700b95-7e38-4003-b40c-bd43eecc1ace@cherry.de>
Date: Wed, 11 Nov 2026 12:02:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] binman: Factor out the compression bintool lookup
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@nabladev.com>, Wojciech Dubowik
 <Wojciech.Dubowik@mt.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>,
 Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-1-d7e290847543@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-1-d7e290847543@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|CPJPR04MB606764:EE_
X-MS-Office365-Filtering-Correlation-Id: b2950f20-c821-4667-7ee6-08df3fe34d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|261022105027099003|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: pE5hnaEciui09OEbf8rHga863HbJjRFXhamobn9rI8Jc5iftj0UFI+5XiYueh/xI+FG8hkw2dQspnvX9xrbyXiTnG2Jl6mRCW6rZjtVOGkm1GDg9nmUiJwRoV4Ic6PXm5m3m1pyh6GnKCI137gdlYfi2l28tQHhMr7Xjma1nSzIGca2F/4v2/h50kLU0YzCq4i8FXxyW8nVDyuOAljRZkRauRv5iuCcJWzhULpYrV61geuYgi68yzD4qNk9PwSiAPcFk5Diirx5WAyXpvJigQ6JkIHKVi06CJ/YY8NFPu8ICOh3SsvXOt/newfhUWSePWxBGCrtyfnyY1NQiFJpgItc+gPj5K5N+uvc03fGNxA+C426FnKcGJkXdvjaQMGJxfH/5MvZUttr/4J6OHv5YdIq+h8Waqk7bBF9IyqrREce6hGSju8MaSjtcpKoQSABWxVPUot2rqdUVm9pJ+COUWfCWSEIQYON89Uusu+Lheb5WQ/2jAW98jKaOzwAHdsVMJ3Kq07JrGpcDjIwoaPqHpQguWc4MqlQNuRUAvkEZMNKpwrS7JUuiLt7GOPB3LQ93wF1UCT1R3nf+A9955DI1FgDQcjcH449o8eHh64u17ekhaAFDQxqxhJ6Nn3iVf5u/iBBfCtii1NFul0sWK+SvAfD5HZhpix8QE/tEkIA3O9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnN3MEFpRi8xNDBUaUVwb0UvT0J0ckppaXJLNk9jYjRTYndMTXYzTTQyQ1F5?=
 =?utf-8?B?WU9vMXBON0FyZHVoRkdMOHJvUmJOOVhnZWJ2VmovdjBPUGRINzVnVSszaytr?=
 =?utf-8?B?b29Dd0t6WFJXMXNKVk82Z2hJYTYxR205TVpFTkhVZUwxckJaY0dHbHdCMXpB?=
 =?utf-8?B?c3dGMjY3L1RaU2dnajdvbWM1a3oyalVOQ2ZtOHlvMUpqNzJYRk5UL1drSkQx?=
 =?utf-8?B?MUpkTGNNblMveUdXTC9ESURjSEMxTGc4dk9QMXczdUd2WlVSRWtZcE9sc3My?=
 =?utf-8?B?MksrOC8zSGJSUFJkbGZtdEhwNDlkam1ydTRTeGtVMG1kYkRxK085YUg1dDdZ?=
 =?utf-8?B?NkFZQzdCa1BEVkxqRG4yZXFrSTZZbTlUMTFQLzRrbnpobU9IVWJJaS83d1Yw?=
 =?utf-8?B?NWVoM1hPWEdEUnF4UHZnZnpqYnlsdDR6cDFvS1ovTXVKZFBsQkNtcXBBVzdY?=
 =?utf-8?B?WHIxOENqKzcxVFVoSzcrRTlhNks0SWFwK3p0L3JFVHdQenRWWFQwMEg2bXRh?=
 =?utf-8?B?dWp1MzVyRHF6K3E4SUtpTUh4KytXR3dhbUYwNnZTaEFQTTBNVjl0aTZleGtp?=
 =?utf-8?B?b0RuaTRPZlN1R3g4SjUwdEx1VmQydmdGWlNXWFBDSXJ1a00xdUZyeEY1SGk5?=
 =?utf-8?B?RXdvc3lsYjdESGpGY0wvMk15MjU3ckplY04xeEV2RUN6emZ3WnY2UjdiQzB3?=
 =?utf-8?B?WU0rTElNZDhSazgrL1kyUEFHaVUxQVJLZjN5K04yejdyZjUzNzBiZWpBcmdh?=
 =?utf-8?B?N2NQdldrWmNzdUZubDRqT0lUbXA5ei94TkVLa2VnV1NaU2tQRzVTU1BHTWxR?=
 =?utf-8?B?dmxjRG1kUFplbVJkMCthWmVNYkRya2xnRFRDOXYramJoQjhxTzI5N1NOTVl3?=
 =?utf-8?B?Z3NVT1FITzFGOXYzR1JKbFRQbGpZckdrRW5xajJwODB0dHk5OWxra1dUSWFl?=
 =?utf-8?B?b3VZQjB0MDM3b3RjaUJpeXFyNTRpZ1R3WHJ6MnA3WlkyUW1JOUJUUjc0My9U?=
 =?utf-8?B?NGgya3NQaWpGV2QyeGRJYzVEQWVFM2swUmlUbER5VVRCOWFGVmZPSU5laUlV?=
 =?utf-8?B?VGZjUFV2STJyUkQ1NjdwcFlzYTRDYklJWm9lMzB6dWN2K1hGTUphNWFFUlYy?=
 =?utf-8?B?Q2lvZ294OHduNThhTFJhSUNvbXpjNW4rbWZCOVVNSjUvbEhLWmJ6emxNVjdF?=
 =?utf-8?B?N1dPOWQzdEJSREM5TGVaYjR6Z0M5TG9MR3pQOXlKa2lGeGFOTlJWNTFaNGFz?=
 =?utf-8?B?OU9Bd2pOQS9oOENISWozYnBmNUlBRUc4Q2ZwRyt4QUEyaWxTOWNhcUtxZFRL?=
 =?utf-8?B?M1dUTGNkcFR2Q2FQakFVK2hxQVN5dW9MRW1kZG1nOHdVMnBWVUkvYVlIZzRL?=
 =?utf-8?B?SlJGKzJud0JmVWlleWx2UE1XK2xyU25HQlZPb0E4emVRdFFuMCtvdi8xc01W?=
 =?utf-8?B?c2dRQmRTOGRENmhRdTlJa0ZPYkV4aXFNNFc0WjNMTlBUeS9mVnhjUjg1eExS?=
 =?utf-8?B?TldkOTUwNzV2LzMzZ1phN2Z4U0NFeVJ0enVTRDZ4YzgyUVhhK2dRTDJXdFdu?=
 =?utf-8?B?TVc0ZlpudmlkV01qOFNESzhnQ2VrWjkzRjJ4UE8xOExjMnBlMXgwWk15VXcy?=
 =?utf-8?B?Tkl4Szkza2ZqWDBQSExMUGZjbllrUy83UXdiT3pDQm50YktKdjNOQmNkMlIr?=
 =?utf-8?B?S3lUQnV2WGR0d2ZwRWxlMGd3cmJvbjl1MW1mZnVHU1BRQWh5amFCRmFLNlFq?=
 =?utf-8?B?c1FnVFFTOUVKVjhqVXBwS25IbXhyNjkwR3ZMNHNFaU51Mkw5UHVHQ1BQWGNz?=
 =?utf-8?B?UDFMVGwwMFZXeTV0RGNlaG5VR0had2p1M20zT1UvZWw3Q0owZXo4NlAyS3F4?=
 =?utf-8?B?dkZYTVpVT0I5M3FENEx0NnYzVEMwaFBOc0JRMDdGYXVIYnZDVDlBMStGdVh4?=
 =?utf-8?B?ZmlKYzhVRWwzQmJxTUxHY2xid2xqNEJ6Sm51ZjR1MnFhakl1WFBCbVF2N3d6?=
 =?utf-8?B?K1ZzbHpDT1hLN205aCtOVnFicUJ5ZTArWHpnRGJ2V29ReTNqdnVoMlNLc1pD?=
 =?utf-8?B?THpza04zS1dQVVZjR2NWRnhVL2dCbVhJaUdFTlpFU0Zqa2RTVWF5dDh5NzFH?=
 =?utf-8?B?NVV5ckd2YmJoaER1SXd3WWtYRlhCREc1bGN3ajJhZ3g0YWNLUTdqczVTYThq?=
 =?utf-8?B?cXM4bEhteDhrOUVpNnF6NmwyN05UQ3ZkbUdlbTRwZjRXc0FSbXZIRjVCTTY3?=
 =?utf-8?B?SU9SZXFVS0NYVDJrU3lIQldGbmc0TVIvOUdHaGhwbzZwR1BmdkRkamtIa095?=
 =?utf-8?B?M2FSenpMTTRLNHJ1OGhHdDdmMElNL0JFOW1pejQydmNrbUxKKys5UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b2950f20-c821-4667-7ee6-08df3fe34d0a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:02:39.4662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTKSGOkr+6Od3fV37G5w+7Fyq2OVUpyAzKGCCmCMFmAiqFRabZfcQstgBFgq2k4oAzTLy9jStFemkWHeCCjWBoKQovkF9J7iNmM3gQ0nH8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPJPR04MB606764
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

Hi Petr,

On 10/17/26 9:39 AM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Move the compression-algorithm-to-bintool mapping out of
> Entry.AddBintools() into get_comp_bintool_name() so that
> it can be shared with other etypes.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   tools/binman/entry.py | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> index 9b39c711889..5eef1d57be9 100644
> --- a/tools/binman/entry.py
> +++ b/tools/binman/entry.py
> @@ -1297,12 +1297,27 @@ features to produce new behaviours.
>           """
>           algo = self.compress
>           if algo != 'none':
> -            algos = ['bzip2', 'gzip', 'lz4', 'lzma', 'lzo', 'xz', 'zstd']
> -            if algo not in algos:
> -                raise ValueError("Unknown algorithm '%s'" % algo)
> -            names = {'lzma': 'lzma_alone', 'lzo': 'lzop'}
> -            name = names.get(self.compress, self.compress)
> -            self.comp_bintool = self.AddBintool(btools, name)
> +            self.comp_bintool = self.AddBintool(
> +                btools, self.get_comp_bintool_name(algo))
> +
> +    @staticmethod
> +    def get_comp_bintool_name(algo):
> +        """Get the name of the bintool which handles a compression algorithm
> +
> +        Args:
> +            algo (str): Compression algorithm, e.g. 'gzip'
> +
> +        Returns:
> +            str: Name of bintool
> +
> +        Raises:
> +            ValueError: if the algorithm is not supported
> +        """
> +        algos = ['bzip2', 'gzip', 'lz4', 'lzma', 'lzo', 'xz', 'zstd']
> +        if algo not in algos:
> +            raise ValueError("Unknown algorithm '%s'" % algo)
> +        names = {'lzma': 'lzma_alone', 'lzo': 'lzop'}
> +        return names.get(algo, algo)

I can't help but think this is the wrong way to handle that. Why should 
Entry deal with Bintool stuff?

I'm thinking this is best handled by at the very least a static method 
in Bintool instead.

In a future patch, I think it would also make sense to not have this 
hardcoded in Bintool class at all and have every BintoolPacker report 
which algorithms they handle so we don't have to keep a list of 
supported algorithms outside of the one class it matters, the one 
supporting the algorithm.

Cheers,
Quentin
