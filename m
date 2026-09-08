Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A59EC79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 10:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AB72404C9;
	Tue,  8 Sep 2026 10:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NC1-F2NBsBmu; Tue,  8 Sep 2026 10:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E24440531
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788864968;
	b=OyvuP2UKmLlVjoG5NAq0E/qBaxpdnptjZCcoY25mGnQnRsHQiOI7fqotog90LlxDlcwf
	 d3yOIR6rO3rVoSuTBKDJ5zsmn5pzbrjXmw/yDrgzAZFQKmlNIC0dzM0QGv4SU4YEhg21S
	 SZ8exJuCRFypvIBNhl6sUPOnD13gZYdjf5Pm89tcsdp47HuvOMt1FQE0H+iunnE+73iZp
	 rVrTYmF9P46sawcn6QXn1Mjl2jFFx08Ly6CCGecbYggmQHyxkXt2xXIDOYw/FbZocjIa1
	 V31U8pIv7zT3hW8jX2UlgxXlUpjoP+GybPqyX850IFiTeAJM9zw7fJuqY1UpjxCjLmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788864968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=9OvAF7WJ0K3Z6e0QrM4JFyd7TefJVJXFfFdWok/NuKw=;
	b=C2YAKCczL5ouz4xtHchQ04YioPzBhrm/7Ggz24REGeAkiM+UgMjhqzThEDUFZi4VhZeX
	 ipe17KWWUo2Fc7fLEUD5GA/kfchEc8KxbUff/EjNJl4NCZk0g09ZQp2UN3dNTbFX3r6gu
	 7EJywZgBrt6xqiDL2DwtuYwOv6scofDNOFxn8XCrOBXMpZ8LJCQZ8w3flu1bj7ppL0PYn
	 e2rMnp9g1dr0j5LjS5rOg5r1Lj8+jyAeqR6HrMoY9G84Hspylg2cLXbJ4SL+7fuuvBzB6
	 UpmGaqdAkoa7VyKK2zMW/bftUdn7a8cIlOXwwYsbgZqqlfFHOSAh05DzI+yI1ifZoTg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ezLFSIGY;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788864968;
	bh=9OvAF7WJ0K3Z6e0QrM4JFyd7TefJVJXFfFdWok/NuKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qUX+6wzjSVbZ1Dhbrj+fsO6aBVd9K8HSvHLNJ1tkRBuqC1QLnRytS3C/JZymWiRyp
	 ZbzTYu6OhD8twOlKOE9uTWiAEQ2YJGNg8/tzpKcXDL2DenxGRR/1hcvjkzgymSNZ+w
	 gbnKwkJJzW7COEeXCLguJ6UW3InZy4G7hYDIWeGbeDDxFOi9MQIWHVboMKlIOScw9L
	 D/BO1g4oJsnxmZcZt9jsN4giaT/+Sricb2Wzwl9KcFhu1pr2/5S1JVrD75WN1Krpwx
	 Jf/y1AoHACGbFWtQY4TCPmiL94iUd6Chx3iH8+9xg+FrL8HmUZSHe9fxfYbdYzpuQc
	 nkOrTIp4KaxoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E24440531;
	Tue,  8 Sep 2026 10:56:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 93461372
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C46A40531
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:56:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Z9k80Ar02u7 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 10:56:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 703CC404C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788864965;
 b=JGUxYT3RRV2wEg+zXCcBv8B5yFWNY19jhqdqokyh0BYYRW6/p5vX0TY0OOVt4QCnqF9R
 dAO9eMwvcoeSopVdVhCeFpcW51sULEnTC4YDR5Wjnu8qxaZSY36cahLQVRo7bvsw4onbv
 V13Rans0pDXQ2TCmEH7Xf7KL9BDrFcdz8/v7cjwUEMY8DQAYGjUu828YQYZlloMTNMe2M
 ofXH5H8N9xPFDLrn4wes18Jtd7FGchpG9QvwLKAO52v6jWzsoGl6PT+wZ7ib/JHGkSZLf
 ppdddad1hy7xPbX7dE4+l4q7rYzn0MjjgzxQKyrOnv4gPiuh0kR+uNrYTlbAg3csa9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788864965;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=9OvAF7WJ0K3Z6e0QrM4JFyd7TefJVJXFfFdWok/NuKw=;
 b=BuogYd4Wm81B7GuiYOj+z3K4Q/0f1ber+QcbkJ7gpJLEX7df6nhcQVca6+/Wtd3ZqCe7
 3O5U6BxJQ1T8mVLMFfm1fSYlv2BDvvfifRHtER5GJHHC2UAeMdrYE1c71kMzxePMkTfoO
 HcV/ODxeTy3mCvpcn/6GKKg6TmHX/u3s1jLRfW0Vcbf7OO3W4/qg4JA2b8xRTpvJ11eJm
 D3Re7qCBVf6gZjbIdSRI7E9QiEJ17Ehv+zslKXRafhzmgmFDXZ12/JwoWvQLhtKmk5WCZ
 pAPdTjkD3RojDc6XhbQnQ4O3K4zagK7R4KahXXwpt1WWVGG52FWqtAoiZhBUkSPQ+7w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=ezLFSIGY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=ezLFSIGY
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 703CC404C9
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b418CE0EHuXLX9vTuRCNwa3WMBdbIloQ3cvt0tLtZ+ZGVqo+9euXO1/epFH1VM/99hYhWclAjAzr47+qSXirdpPEQSr0vSLnXo1VwQvLRcoOsYO6CXNTEaFhPI4G3tfc9PEVBf1rZxvOaeKvw+E+PhkM7RwdbE1Agn3sujQb6sUT28Vz2H9E0vTfJMFLysMqvI/Wzr3pFp6uZBB9dlJIlFkPxli5Lyln7naiwQq1XdX8LjaB7xqxrFHcOZnYR1kG8Ug+hXmEqTloy6xRsK8igDyBumacIfeQpRsMF2w5mYgCK6NeEGqF7621MgH+HlSc/5e/Jx4eb2Hkl+mxBzL/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OvAF7WJ0K3Z6e0QrM4JFyd7TefJVJXFfFdWok/NuKw=;
 b=QnPk5/E3XCh4irx08OEX7i3gWPLM+o+mzX875mZJ/ejPk0BnsmHbIfjcbCf7ciuQb8nX+/Sfcn2ly9gVQ0wwQ5exbGAd98hX6mPY5k4R5cPUQkqxvIVkovJhgjDR26weXk9iHsYbVcHQpfQZh1XknjrDUp/s4si434YgRlFkkRW83Thochu3J0hpTzLwqaLs/WkGNn+QgBgXZ+WSBgT+dtzGH1uSNvbhZgyb1XTerk4K/yCSXlpkgTAS7pzb32gZHlcxnOCuAlcZpIVYMfHYd+TRdeIGeIeC2kVoB6XMl8W/V/92Ts/fN30GSXyxdGbUQpwfGlaxLIVdZRVIfbbeRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OvAF7WJ0K3Z6e0QrM4JFyd7TefJVJXFfFdWok/NuKw=;
 b=ezLFSIGY2FzUiqxBBkbaB6D+/In+gNi0Ecupf2eEpCBoJbAHifvvgVXHM83BOWYsYB0GLG/rcwN8FajyjMsBgNOxv3GCd3/Ba1GOWn4SlErs7j7AVZpNgogY3ooCPIxNkcgxHwxIgDPvZG1/hXr/DjOLygkV7mxWiODtBe85ZmAb8oHZ9X44rJNped2MIR81CXHIEy/EWCvi/I2uj5uGb73KuUrvYFqdaHcfzH4IqL/5LdhgnlpKLTBd47CAX7kjsA+JGRATzOc7IrlOTS1tAu/c6ZCL28GoyjCKfA8yJz6TVXrqWTkzVnAA1IXSsp5KgEiwaDqSxOTUCzxlET4zaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:448::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:55:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:55:53 +0000
Message-ID: <09a518d9-3d50-4a01-94c3-10369fd31a95@siemens.com>
Date: Tue, 8 Sep 2026 12:55:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] tee: optee: Add support for enumerating services
 that only need RPMB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <1794934500e5580309f4a8cb064bd035cb9b23d4.1787514446.git.jan.kiszka@siemens.com>
 <DL9R83CX8TMM.196CDRKC99BU2@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DL9R83CX8TMM.196CDRKC99BU2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d59d50-0c28-429e-fa3a-08df0d97c0ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: znIiD26w49Cig5h1FpFyKTzdLfAkNnBISl3iEMOEHJoS10OIUSgKkU8PKjoxFR/GzWAo+Css4nMSRKnzUtbbDCHkzpIfsAsYKjEufpjz/D9FRV0G+AYIRn/K58JCqyu99hxBodvWXZeEkBArqlcdPeC2/JVPlpEolEEroLQfB6Ru4NC85W1DxuE3X0infgBq2cmnU99ubWBEA0hT61X1YxjZ11DM/rIp0sSzWqD1EGArltsEFjmoIxP6lFM1ZLzFUPWH1nirwtiE7GWDcg9xm9jdS9cgfEUnhgWH5xNb4ZpGPb3DSl4iARQvnyuVPY/Dr1aeEnWs4cTOVYB8tNm6EroxqyjICrdsdqu8S0P+APmdJ8XQVMO1MSQJHBE7e1stZCKIUs7AXlvTUnY4Z+/9BFiCxe0dgSiT/niFTgfoXa5krd3DWotpFUzSqW85UNUPi2MtzbTUKtMK8Y7pj/MYQQ2MpydEV4j4leTzbO7x77MuQNWca6Ouj5KFuk+UNVL7rCPDelmK++VKbtu4i/aJq9nie+e3EO1bebibgti86yhLS2WluvQX8lR4Rl4ZBTfz/7wybaxTzFUHqxgI5LNMyT4+koe7netNmO/6ahNWdZQr1sYiCYJG9rFGfhmpl3IlPXtjrhwkplTUlwilpd4wmWskhTRF0ytZALyJcm7Iv1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENVNjZGd251RHlOL2RLb0J3ZXFROGl6NjRVYzRwMXA3YkYyK3pYaHNKbUNR?=
 =?utf-8?B?emVIMjg1Q2VKVW9GYm8zK2U0U2d5L3FxQ2NsTjF2TUtMYXhKZlNKRVhRUURD?=
 =?utf-8?B?VUZUTEpabkFwM05LSzlUZUdaRXZuQktCZGlkMFpCNHdKN1NIVEZ5UzlvTU1K?=
 =?utf-8?B?SEgvOXJ4SlFKSVBHR2pEYnYwVTM3d1FOTUh3S1ZhV1ArT25KU055dnM3bHB3?=
 =?utf-8?B?N0JMclplRVB1SW5CWmJ0dURMOSttWERud09uTE9GaWtkVkxqenhYVVRBRkhR?=
 =?utf-8?B?M1VxL2JzS2o1MUM1TDYxZ0tXYlRKdkRwZHZyekFwMjFhd2pUYnFEUGc3SUE5?=
 =?utf-8?B?NnZiRnROcG5Ga1dtMXlWN2xPbzkrUzI5Q2loTzgwdUtpN0JNWnh2dnNOWTNy?=
 =?utf-8?B?VTk0c3huY3lTc3VjbGhMUzFKcXZpb285Z29YQmxpa0RkUEFYd0ppTVJSZldi?=
 =?utf-8?B?dSs0YkV5N2RFdG1pU3VGUUpMN0NQNTE0Ump4T1dnM2VaTmdOTEIyOW11bitG?=
 =?utf-8?B?ckFwNExyK1lHN1MyUnFwUGVYcUUwSFJoSEpPRk45S0MwR2RLc3ZxYmlCQnEz?=
 =?utf-8?B?SExyZHpLQXRZSnZVL3JpeCtmVXR6NVZEdHlkdDYvRlh6eit1Smh4RlhiRkdi?=
 =?utf-8?B?bHcrTXpSM2s4aWdFSElSYkN2UmdXT0JWZ1ZZeENnQU1sek5iQUgyeDJjUGtC?=
 =?utf-8?B?bjA2K0dyTXowVDBnbWJBL2RnV1ZucXcvS2tyS29MUVNtcnhZcTFTb29hNllM?=
 =?utf-8?B?VlQ2TDF1MGswTjhhU0gxRGM5bXE5SFRqdGp2c1c0SjRIK1A2S0JmSUZvdlVa?=
 =?utf-8?B?THhST1NIcUp2UTlqY21HVTdUU1VPRDlaVlV0RlhQWVlVN3ZQN0w2WFRFSi9y?=
 =?utf-8?B?cjQxRXRkdlZMaDg2b3dqVERrSU9VVnNaa2lJSWZXY0k3ZVFHSHVhOXprUi93?=
 =?utf-8?B?UDFXQjBSc004Mm9JcTIxcFk3VUwxbnV5bnNialZKeWtsYlpXQzFHWWY2ckhu?=
 =?utf-8?B?ODg1emp3V0dRbWVUTkllYkZDelpuOVhvenZDQ2VIbnFBdEVYUkxtTGJSc1J2?=
 =?utf-8?B?OXk4SXNpQzhNWm1YUjZBTERTdWROWS92QlRwY0h6UjRFSUIvZEV0NHFDdXdB?=
 =?utf-8?B?Qi9UR3NaWnJ6Nk5aa3orbHdvM1dNenZzcEdRcVJwcnF2dXYyQ3NWSkN2N0Y1?=
 =?utf-8?B?NHYrTklpY1FDSml2T1owTmdQb3BFcUp3OFBObmUxSHdjWFV6TVB6a2oyNERF?=
 =?utf-8?B?aEMrY1krZU01djVmZ0NIb1pMQTJ0ZmRJTEhOdDlFWjJaWjJhVzB4STNmWTVN?=
 =?utf-8?B?MDVyeVYyNUN1RHk1RU9LUWVhd0M4SDI3R0FWUGphcXVpWndMZklBckhLTjdT?=
 =?utf-8?B?NGhLTnpKRDNrNDdyNXhXSEtGS0ZHV1JsL2Z4cytpQm1qcUw3VTVJc0dtRUl3?=
 =?utf-8?B?b3lrRGlmN21qQzZpS1UyRVFzbUxvK0JQUlJoS0l2aWdRYWVaME9wTCt2bmpB?=
 =?utf-8?B?MWJiTVI0Y1hZU1Y3djIya3k5M0VlelhNZGQxaW1BY0UvVnkybXd0eVY0bkhF?=
 =?utf-8?B?ZzNnZlc1Tm9kdHJlek1DWDI3ZjlzZW00cXFhcklqZHVidHhZbkxPYXJVVFRz?=
 =?utf-8?B?Mm9nTTVTbXRyNHpTT3MzV0lsVE4yL2dmSFR5YVA4N2tsWHpNcllyOGFmSWQr?=
 =?utf-8?B?bCs3dktwS1NOcDVuM2JERjBxSU4vSXhvOUQvYkZDM1RsM2xJQzkyRzQvTG82?=
 =?utf-8?B?YjIvamQ2amFJNFphNnczdjZMN2Y3cHZ3NXVkOUowblR2QVRyMEVUV3o5L01L?=
 =?utf-8?B?SGVUYjVLU2pDRGwxMmk4NWtOL3NXTGlBWVhVV0x1ZkNyWU1xcmV1cC9TRkw1?=
 =?utf-8?B?T0FOc3hYdTc2MkYxb3M3TkFIb2p2ampLU2tYTnU3THlNWU5OeDdVdEVBV2lH?=
 =?utf-8?B?Y3ZlcC9TdmxvbVhPQ0c2SkdXUENSRVJXWGdQUmt3cmRaYW1MWnhOb1QxVVc3?=
 =?utf-8?B?aytRWGlTenNsVFBsN2F0VTMxOU9NaHBpKzgvTXhOaCtaM0pLcnQwSnF3NERv?=
 =?utf-8?B?UlRpd0FpU0lEMk1Xd3FjeUFwZFM1Snh5MEVianZNYTE3bnFKa1d5R1g1MHhI?=
 =?utf-8?B?WFF2R0dGcW05dGVpQ1JrVnBGTXdqakRHOFQzZ05CcG0rSkUvNVgwUE9UR0Zl?=
 =?utf-8?B?L1pvTkwvUmxyRUVIcG1TYW92Q3RmKzNjV1pjeDZFenk3cXVUMS9VMzRtV0lr?=
 =?utf-8?B?YXRGdGJPSytnVzN2eFVxSml0TUVTZlBaVGxxcVdvV0NKYTJydndRbDY1OFR0?=
 =?utf-8?B?TDBGODBuM3pjazZsckRHeklZTEsxdkJoUmhvekZHMGQzYzNoQURSeTR3eCtn?=
 =?utf-8?Q?305/Ml92Ar+KcTak=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d59d50-0c28-429e-fa3a-08df0d97c0ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:55:53.9068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9A8e1V/fhbHL1UQ/iKgbbuesycj7T7Bz/y8vkojG5Rp7UFePYgz760ZUMIu44jjkqUF6oBB8lDpqhaySk9wXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7263
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

On 08.09.26 09:25, Ilias Apalodimas wrote:
> [...]
> 
> On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
>> +
>>  /**
>>   * struct optee_private - OP-TEE driver private data
>>   * @rpmb_mmc:		mmc device for the RPMB partition
>> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
>> index bacced6af6c..f7312d7171c 100644
>> --- a/drivers/tee/optee/rpmb.c
>> +++ b/drivers/tee/optee/rpmb.c
>> @@ -191,3 +191,22 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>>  {
>>  	release_mmc(dev_get_priv(dev));
>>  }
>> +
>> +void optee_rpmb_available(void)
>> +{
>> +	struct udevice *dev;
>> +	struct uclass *uc;
>> +	u32 tee_sess;
>> +
>> +	uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
>> +		if (strcmp(dev->driver->name, "optee") != 0)
>> +			continue;
>> +
>> +		if (optee_open_enum_session(dev, &tee_sess) != 0)
>> +			continue;
>> +
>> +		optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> 
> Will this work if devices are bound but not probed? IOW do we need a device_active() check?
> 

You mean the theoretical case that MMC is probed before optee? Unlikely
right now but still valid. Let me add that.

Jan

>> +
>> +		tee_close_session(dev, tee_sess);
>> +	}
>> +}
>> diff --git a/include/tee/optee.h b/include/tee/optee.h
>> index d1194493780..755533b2c0b 100644
>> --- a/include/tee/optee.h
>> +++ b/include/tee/optee.h
>> @@ -74,4 +74,10 @@ static inline bool is_optee_smc_api(void)
>>  }
>>  #endif
>>
>> +#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
>> +void optee_rpmb_available(void);
>> +#else
>> +static inline void optee_rpmb_available(void) {}
>> +#endif
>> +
>>  #endif /* _OPTEE_H */
> 
> Thanks
> /Ilias

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
