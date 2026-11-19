Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B0606A334
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CUNT3BoI;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bu67PUPv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B960813F1;
	Thu, 19 Nov 2026 15:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TspWYIxflc1X; Thu, 19 Nov 2026 15:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2524D81401
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103734;
	b=q1hpxlxWaIJMVAQPI+5m/TVcvP4sUaNz4lfJbQNeftNTBbi9rP5zyUNaYMms27j5AQBt
	 8mD4BG5FBlTlhoHI1vL/XrmpB4mwXA76T5AheDB++tPTgaoqbhzVcHpi8dLWTnLSMWQzF
	 Lt0jKNvQwhDgBjCEH1JMh507AOJWvgzwTw7hQZ09vcekYAQWhLrhj+jGfMFtLxXrZgqae
	 VZ+NzFWdaJgq/NbAcAuQ+3h9f5sGD7K4dhacg/eSL8EDmg6KPJM1ydFObxzw+z1PXdqmc
	 1S1kMR0Fz2u8b1JPqFsKwfCZ+eMdFXu1wV3HjIGOWDfjUT/pQB0e5OhWbb90UCjKtNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103734;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O8Tj8ispAci+IIgUDNgyIr4KA44c4IgO9rITC8DOdEY=;
	b=p7bSvvPBl3LRs+VaSCevMBcQDLxSPYTGg+qITLAlcKd16oh/TYm67Jgc/5RLkfOZiNUO
	 Fxp2oXEtfk703KKRIvopN4racf77FSdZQ42zNFt2iYiZFH4hCtFu1SP1u8UmVdUGgzQh+
	 BMapReKLhQ+1eDXtpHECIZxS/0tkijmL7zYu4UDsAod4IAch7hqz9sdpcqgoaELInaGTw
	 vxXvle6U2xCc2gaAf1Rsxh+wHPUm+f25B60cm0k1HxRJC2/cF6CV6MkOcZuWUXS7Ulbny
	 ZY461DMSYi9JhXIk6Jo4FeAA4L9u7oMHtj/DXCEDMxbkhxF4TXfpZ87Iwje6wa+g5XQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103734;
	bh=O8Tj8ispAci+IIgUDNgyIr4KA44c4IgO9rITC8DOdEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CUNT3BoIJogyLtCzZY1fxNVE4AYqsnmd6BBD7wEhFjHSjY/fxbaZ22m9dQmEzU+WO
	 83u+AggyLY6kLvEJDoc+inuDRieRYZbkELVpQzUQWiVTFPf2y2MpOCe4GHdFYO2V5/
	 ei99fpWOwpMUlfOWaQDGzMxZgU38/rXhhlkZRjam9/G4s33EDhAswwxjMuoLz1Qx0p
	 b1aOnooDec8ci13pmDBMQG2pUZGlPnImrzmNWBhQ6FyJO14Wzj34NlY5GjBwpb3R3B
	 jXP7A1nWYNYX8Ii6saaVuVCPJr2bYwayGiDrsE/USudkm+bRcxYMfUGNhwtTm/HW6J
	 hBHGJFWxeXl6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2524D81401;
	Thu, 19 Nov 2026 15:55:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4225A2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33A5B4057D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8GstAU2fCZq for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 31C2E40556
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bu67PUPv
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31C2E40556
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8Tj8ispAci+IIgUDNgyIr4KA44c4IgO9rITC8DOdEY=;
 b=bu67PUPvNTb/MiBWDJpggj9gAGMoSlOj5hTpML6I589xwlRItHuU1RI6Yy0MMIOPSi7YLBzIiiiJZPv2HOc5EgOM11H/Fpr0zSpZR51K4bJpo4fAxd7F9HdFBnU7BwXCiaGo7OsD6BubnnaXoIT8yDzjJQgHrkpqEW26vhsEAQg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA3PPFA975A5D55.eurprd04.prod.outlook.com (2603:10a6:108:1::ae)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:55:24 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:55:24 +0000
Message-ID: <37acffe6-ecce-4955-8c32-c5879881a927@cherry.de>
Date: Thu, 19 Nov 2026 16:55:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] binman: x509_cert: document PKCS#11 URI support in
 keyfile
To: Sergio Prado <sergio.prado@e-labworks.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com,
 xypron.glpk@gmx.de, jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-3-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260728113535.128601-3-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:802:2::36) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA3PPFA975A5D55:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7f080a-f80b-4bdb-7c9b-08df465585ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|1800799024|7416014|18002099003|17002099007|22082099003|6133799003|261009223027099003|3023799007|4143699003|11063799006|56012099006|5023799004|261026140227099003|261021130227099003|261021123027099003|261102123227099003|261028144727099003|261021121427099003|261021135927099003|261022075727099003|261022105027099003|261022115727099003|261022113327099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: XABE50vr7sSsRXvkmo3XD19hmoRsgZxF7D9CVS+tQXZIQZTh/6KL4cnxUpxl2Tc0jCXejzaIck2icX0Z+M/7/IVmSB3A2AgLQuJiMMWdAuU3bdgiw4JBJzAGvQcBtAGF4EV496buPbBmDYHGT/M/0h9J1upVnrJj1qBjBuKBpRQ8FBwleTfPn0SVJpaC2NFBC9EOg5+qhVxKURdUgaKYqAL1btFJCJ33AOVJCBTG8D1WkjU6kCqMWdvZsKvEz0r5IugrltKtRHRiWUGTz0HE874DOpne7JzMSghAc/9hP+04Yb1u+efh4qDTz2TWrEZKZr45qtlFNSzE9mHUrWb9rL7VsWMPeESBCRyQAdtNruxAk5nJT8A0xXRkN3KEw7Tb3JB5yA72SxYvAs4wFn2C29Q83h5dIo+xvezNENSH7onlkvZ1k173nnc5NrxG7fGALVcVS8+QrcvxTujlcDyKx23HAz+3PzLq8Rp5bl3zkPZRNyb8w2oCDGlFOc+qwkbyAypwBaXY8HGGC2U+d979667lnRaRsZ92OFW/WoCRRPFti3nR6C8ChB4zCJ1ZSG3a5LKpFqg01h1ORiF+9pF7yN/3umDqx2AACm+Fi+p2qeelz7crnsLSV8nh6qmphvTO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(17002099007)(22082099003)(6133799003)(261009223027099003)(3023799007)(4143699003)(11063799006)(56012099006)(5023799004)(261026140227099003)(261021130227099003)(261021123027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(10067099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3M1Z09WUnJsTktqSWtqcVRLVjZHdktIcWRidndLVkNMbUlNREg1TVlnL3dv?=
 =?utf-8?B?QndJeGx3a1M2bE9VbjVjOGl4YkMzVnMyR3cvU2JhYVE2WUJCcU1aODJCTmk2?=
 =?utf-8?B?Q1FLanJlR3hnRnNVU3NiN0RqMVZxS2Ixbi8xNW0yakV0Vk9id0pQUmZVOFkr?=
 =?utf-8?B?emdOQ3JYcjdBUXhCZ3NTVkhwWG1aSnFYRmNZM1BXeXp0dmVTT1lrTzZaZWdG?=
 =?utf-8?B?SVNQOE9OYVY1QmVMSmEySlNHZEg1YkZEa3V6STZmbk9kZzhsNzVTM1d0alpO?=
 =?utf-8?B?empmT3pCMXdVczdydW94amQyVFk5RnljSmt4VXlSNmpUaU84UmYvRHg4UWwy?=
 =?utf-8?B?TWtNKzJINFp0OE5Mc0lRVk13bldLTENlUmtpNWxuR2F5UjdmZUIvVi9Tbk5p?=
 =?utf-8?B?d2hBVGs4TW1ZK2tjR3pvSVBCSW1ralVNOUpRdHZ0eXN0UmwyWWZVMXo1TWZH?=
 =?utf-8?B?TUtPZFhUN3RGSnNHLzRlMFBTcDd0WEl0U21PcjZJSjhWODhVT0Yvdmw4QVdK?=
 =?utf-8?B?cWtIUXdNVnlma3hTNnZPYmFaNUkyM0tXVXYzVm91N3RvV1hSaGk1UjFObEhP?=
 =?utf-8?B?TXM1bFFuUTlUTnQ4UjFhd285aVM4Nm1qZUtRWW1MU2M5WHlDQUtYYWJoYVJZ?=
 =?utf-8?B?bjhaSmxiYUgxc1NucHl3QW45bWpFdGNUQlFra01YMUQ2VmZkNkxRcWYwUkpO?=
 =?utf-8?B?WUhXN2Z0Z0E5d2ZtZG5LZkQvTjFIbkpMMCtPMnZSaEZKeGdSQXF6Vm13YmpN?=
 =?utf-8?B?ZVVCcHBNbUQ5dVNBY2VYdFBrUE9nSnhMNW5Ja1N1cEJjak9tUUxHTlNoLzVU?=
 =?utf-8?B?SmhhUG1RdVdqS2F0VlJyOE1BNDNjbXhudmlkbkJhT2xQTVdTWWJtVE5YRUFm?=
 =?utf-8?B?WWFwNVJ1dVdCMUowa1hUK2pwK2pQSEp2WENjUDlOVHlWQmQ0KzMwSk16SUNY?=
 =?utf-8?B?OTF6UThlQmhucHJ1YW1yYTM3Y01HYk9iajJXSE4wNUhPZ1JBSWg4bGJpT3A0?=
 =?utf-8?B?ZWRwWGZ6ajMvcE05eFBLNjhOcEw4YXdIc1N3K2x0SHhIemQxeG5VK3BWT0Fs?=
 =?utf-8?B?TnM0eWdjaEF4UHh5alFrb29vVHV2b1M1MWg4cnAzRWdIMERPSW5scHQxTVlv?=
 =?utf-8?B?cjNSaVhHQ2hzVlo5UlY2TTNaSEs4TVkxVDZzTXhWMGo1MGs2TFB6bllISWVI?=
 =?utf-8?B?YXpkcDhWbHVtTnJJZ3gzS1FzeGpGdUdiMEI4R0dKUFlzUmNYWEFXSVVUSmdY?=
 =?utf-8?B?cE5uUnQ0aEE1bGtsT1Ewb0N2V2xINmVta2lrY3cyemlxWXVzRWxCRHJUcE9j?=
 =?utf-8?B?d0RhK3BsSHdKclNEOTZGYk8wN0dFSjJ0ZkErK2ZYT0I3YVh1YjZWQWlFWWhG?=
 =?utf-8?B?OWx0T0wrbUtKVms5anJURzNGMW9DWjZXWWVXZ1hXSDVrU0lvNnJqdWZhM0ZG?=
 =?utf-8?B?TlUxc0VZbXkxYlBhNnU3NHNCanJacHVxMnB5bzdBWGhqYVl0RzFIVW9MZUpz?=
 =?utf-8?B?b2R0ZzhDT01pUitrN2dzOVBnb3ZPcmRUbFJ0N2hzeGh6OG81U1VHeFc1RmVQ?=
 =?utf-8?B?dmxrSmgxKzlteEU1K3ZOaWREZmgycmR6R3hDZi9qYVJKbS9YU04wT2pmNW9z?=
 =?utf-8?B?R21lczZsbUVFVjJXdEtaa1oxenZDVDJBVXA4NE8zWlN2Q1g5NFkwSktEbHdP?=
 =?utf-8?B?U2Z5VU94ZlNqb1JHZXU2NW1QVXNSU1JzUW9IRmhLSnN5VC9vVngxbVpaMTdL?=
 =?utf-8?B?SytTSVNHVGRGQ3NTdm9RQVlIVGs0clE1SHZsMFQzdzBOWWVhQzJ4SG1WWXBk?=
 =?utf-8?B?dllCZVZ1OWRpUDFOVitSVW9jMlF4TWJPUGZtaDd3Rkd2NDEvYit4Z2xKN0Js?=
 =?utf-8?B?U3JSVWxnUFRaVVZiK3JtYkNzdmh4RWtzYW42K3A2c0VrOFVSbHhsVUErVWtj?=
 =?utf-8?B?dVYwSmNNUkRNTFErckpzbGlDL1dhOTYvYXJVV0liMW5ENE1zOTd6QmNGWmxG?=
 =?utf-8?B?NXlMTDA2a2pDNm0xY1pxNGpPcTBIN09ObEp2UzRidXdMWG95cldrR0plVUxK?=
 =?utf-8?B?OC9XOUV6dmpoYUFYTVpYUE5ZMzBpK0RHY1RMSS8xU1ZwT1o3K1R0R2djTS9F?=
 =?utf-8?B?Z1FGeE5MbGxaaEE4RlIzb0Q2K25ZelkxK3RKaitVY3hWMU9SNjAvTytiZkls?=
 =?utf-8?B?SkZRZHpMWkdrd05vTHV2eFFIcjVBTG5oSXRlYnhsanlGellkU3B5RzFZb2t2?=
 =?utf-8?B?ZnhpcEh0b0w0QjF1YVRYV1IrR2RaT1lidVRyWWNiZk55ZFVSNEhhYVVZc1lh?=
 =?utf-8?B?QWxmUFBobEZQYXRQMUppL0RBZEZ5SkZiQVhScWNZVm9ENVNSblA3dlk5dkZM?=
 =?utf-8?Q?ITkikkJvZxQHOC3hGVDdUcIunooyMtC4oOVQAsGdQV5gu?=
X-MS-Exchange-AntiSpam-MessageData-1: /DjtmhCiVjB/uogESAwRvlKUc4nVh1cLgQg=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7f080a-f80b-4bdb-7c9b-08df465585ad
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:55:24.1310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Flt643IqL/y2uBgbtTLkPTNiV+SDj0tq9LM1hlvemrfn/xB0wgyWSSBUdWRTjDTd6LeVTctFES8QfhHqVCV6vmgWOe54zQBKddQ3ZOtrC4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPFA975A5D55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sergio,

Apologies for the long delay, your series arrived when I was leaving for 
several weeks, and your ping reached my inbox while I was traveling for 
2 weeks without laptop access and it sat in the middle of the multiple 
thousands of unread mails I have since received...

On 7/28/26 1:35 PM, Sergio Prado wrote:
> The 'keyfile' entry argument of an x509 certificate entry is passed
> straight to 'openssl -key', which on OpenSSL 3.x resolves it through the
> STORE API. Any URI the STORE API understands therefore already works,
> including a PKCS#11 URI (RFC 7512) naming a key held in a hardware
> security module.
> 
> Nothing in binman had to change for that, but nothing said so either.
> Document the forms 'keyfile' accepts - a PEM key file on disk, a PKCS#11
> URI, or a PKCS#11 URI prefixed with 'org.openssl.engine:<engine>:' for
> setups which only have the older pkcs11 engine - along with the OpenSSL
> configuration they need and the two ways of supplying the token PIN for
> unattended signing.
> 
> PKCS#11 signing needs OpenSSL 3.x. The provider API and the
> 'org.openssl.engine:' STORE scheme both appeared in 3.0, and OpenSSL 4.0
> removed the ENGINE API altogether [1], so the engine form is specific to
> 3.x while the provider form is the one to build on. OpenSSL 1.x is not
> supported.
> 
> When a PIN is given both in openssl.cnf via pkcs11-module-token-pin and
> as a pin-value attribute in the URI, the URI wins. This was measured
> with SoftHSM2 and the pkcs11 provider on OpenSSL 3.4.1.
> 
> Add testX509CertPkcs11, which signs against a SoftHSM2 token with the
> PIN carried in the URI and skips cleanly when the OpenSSL pkcs11
> provider is not installed. Add testX509CertKeyfile too, which checks
> that the 'keyfile' property is read and that the entry argument
> overrides it; it uses an image description of its own rather than
> x509_cert.dts, so that the file naming a nonexistent key cannot trip up
> tests which just want a signed certificate.
> 
> [1] https://openssl-library.org/post/2025-12-18-remove-engines/
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>   tools/binman/binman.rst                       | 52 ++++++++++
>   tools/binman/etype/x509_cert.py               |  4 +-
>   tools/binman/ftest.py                         | 96 +++++++++++++++++++
>   tools/binman/test/fit/openssl_provider.conf   | 14 +++
>   .../test/security/x509_cert_keyfile.dts       | 25 +++++
>   5 files changed, 190 insertions(+), 1 deletion(-)
>   create mode 100644 tools/binman/test/fit/openssl_provider.conf
>   create mode 100644 tools/binman/test/security/x509_cert_keyfile.dts
> 
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 366491089ad9..86e15741fa35 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1543,6 +1543,58 @@ If you want to sign and replace a FIT container in place::
>   which will sign the FIT container with a private key and replace it immediately
>   inside your image.
>   
> +.. _`SigningX509Hsm`:
> +
> +Signing x509 certificates with a key stored in an HSM
> +-----------------------------------------------------
> +
> +x509 certificate entries (see :ref:`etype_x509_cert`) are signed with the key
> +named by their ``keyfile`` property or entry argument. Instead of a key file on
> +disk, ``keyfile`` accepts a PKCS#11 URI (RFC 7512) naming a key held in a
> +hardware security module, so that the private key never leaves the device::
> +
> +    keyfile = "pkcs11:token=mytoken;object=mykey;type=private";
> +
> +binman passes ``keyfile`` to ``openssl -key``, which resolves it through
> +OpenSSL's STORE API. Everything else - loading the pkcs11 provider or engine
> +and pointing it at the PKCS#11 module - is configured outside binman, in an
> +``openssl.cnf`` file selected either by the system default
> +(``/etc/ssl/openssl.cnf``) or by the ``OPENSSL_CONF`` environment variable.
> +
> +This requires OpenSSL 3.x; OpenSSL 1.x is not supported. Two forms of URI can
> +be used:
> +
> +1. Provider path (recommended). This needs the pkcs11 provider, e.g. the
> +   ``pkcs11-provider`` package on Debian and Ubuntu::
> +
> +       pkcs11:token=mytoken;object=mykey;type=private
> +

suggestion: move the requirement after the example

The phrasing is odd as it seems the code-block is related to how to 
install the package but is rather how to use the provider path.

I can suggest:

"""
1. Provider path (recommended)::

       pkcs11:token=mytoken;object=mykey;type=private

    This needs the pkcs11 provider, e.g. the ``pkcs11-provider`` package 
on Debian and Ubuntu.
"""

> +2. Engine path, for setups where only the older pkcs11 engine is available
> +   (e.g. ``libengine-pkcs11-openssl``). Prefixing the URI with
> +   ``org.openssl.engine:<engine>:`` routes it to the engine through the STORE
> +   API, so that no ``-engine`` / ``-keyform`` command-line flags are needed::
> +
> +       org.openssl.engine:pkcs11:pkcs11:token=mytoken;object=mykey;type=private
> +
> +   Note that OpenSSL 4.0 removed the ENGINE API altogether, so this form only
> +   works on OpenSSL 3.x. New setups should use the provider.
> +
> +Unattended signing needs the token PIN. This can be supplied in
> +``openssl.cnf``, under the section which activates the pkcs11 provider::
> +
> +    [pkcs11_provider]
> +    activate = 1
> +    pkcs11-module-token-pin = 1234
> +
> +or as a ``pin-value`` attribute in the URI itself::
> +
> +    keyfile = "pkcs11:token=mytoken;object=mykey;type=private?pin-value=1234";
> +
> +If both are given, the ``pin-value`` in the URI wins. Note that a PIN placed in
> +``keyfile`` ends up on the ``openssl`` command line, where it is visible via
> +``ps`` and may be recorded in build logs; keeping the PIN in ``openssl.cnf``
> +avoids that.
> +
>   .. _`BinmanLogging`:
>   
>   Logging
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index efa85f9553e7..6d7883af58ef 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -19,7 +19,9 @@ class Entry_x509_cert(Entry_collection):
>   
>       Properties / Entry arguments:
>           - content: List of phandles to entries to sign.
> -        - keyfile: Filename of the PEM key file used to sign the binary.
> +        - keyfile: Key used to sign the binary. This is either the filename of
> +            a PEM key file on disk, or a PKCS#11 URI naming a key stored in a
> +            hardware security module. See :ref:`SigningX509Hsm`.
>           - cert-ca: Common Name (CN) embedded in the certificate. Used when
>               generating a generic x509 certificate.
>           - cert-revision-int: Integer certificate revision number. Used when
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index bf98b268ac15..10373a2fa899 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -6905,6 +6905,102 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>           err = stderr.getvalue()
>           self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
>   
> +    def testX509CertKeyfile(self):
> +        """Test that the keyfile entry arg overrides the keyfile property"""
> +        # The keyfile property in this image description names a file which
> +        # does not exist, so signing fails when there is no entry arg
> +        with self.assertRaises(ValueError) as e:
> +            self._DoReadFileDtb('security/x509_cert_keyfile.dts')
> +        self.assertIn('keyfile-from-dts.key', str(e.exception))
> +
> +        # With the entry arg present, the key it names is used instead
> +        entry_args = {
> +            'keyfile': self.TestFile('security/key.key'),
> +        }
> +        data = self._DoReadFileDtb('security/x509_cert_keyfile.dts',
> +                                   entry_args=entry_args)[0]
> +        self.assertEqual(U_BOOT_DATA, data[-4:])

issue: too brittle

This depends on U_BOOT_DATA being 4B, which it is, but there's no 
guarantee it'll stay this way. Can you please replace -4 with 
-len(U_BOOT_DATA)? It also makes it explicit what kind of check we're 
doing here.

> +
> +    def _CheckPkcs11Provider(self):
> +        """Skip the current test if the OpenSSL pkcs11 provider is missing"""
> +        openssl = bintool.Bintool.create('openssl')
> +        self._CheckBintool(openssl)
> +
> +        # '-provider pkcs11' asks OpenSSL to load the named provider, so this
> +        # succeeds only when the provider module is installed, whatever
> +        # OPENSSL_CONF happens to point at
> +        result = openssl.run_cmd_result('list', '-providers', '-provider',
> +                                        'pkcs11', raise_on_error=False)

suggestion: make pkcs11 an argument to CheckPkcs11Provider

I've worked on a dummy provider and I think I could reuse this function 
if I was allowed to pass the name of the provider to the function? c.f. 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/ 
It's a (non-blocking) suggestion, I can very well adapt this later on 
when/if I need it.

> +        if result is None or result.return_code != 0:
> +            self.skipTest('OpenSSL pkcs11 provider not available')
> +
> +    def _SetupPkcs11Token(self, prefix, token, key_label, pin):
> +        """Set up a SoftHSM2 token holding the test signing key
> +
> +        Creates a SoftHSM2 configuration and token store private to the
> +        calling test, then imports the in-tree test key into a fresh token.
> +
> +        Args:
> +            prefix (str): Prefix for the temporary files to create
> +            token (str): Label of the token to create
> +            key_label (str): Label to give to the imported private key
> +            pin (str): User PIN to set on the token
> +
> +        Returns:
> +            dict: Environment variables which make both the token and the
> +                OpenSSL pkcs11 provider visible to openssl
> +        """
> +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> +        self._CheckBintool(softhsm2_util)
> +
> +        # Per-test SoftHSM2 token store, isolated from the host configuration
> +        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
> +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> +        with open(softhsm2_conf, 'a') as f:
> +            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
> +
> +        # Minimal in-tree openssl.cnf which activates the pkcs11 provider. It
> +        # relies on the provider module living in OpenSSL's MODULESDIR and on
> +        # softhsm2 being registered with p11-kit globally, both of which hold
> +        # when pkcs11-provider and softhsm2 are installed normally.
> +        env = {'SOFTHSM2_CONF': softhsm2_conf,
> +               'OPENSSL_CONF': self.TestFile('fit/openssl_provider.conf')}
> +
> +        # rsa2048.key is already a PKCS#8 PEM, which is what
> +        # 'softhsm2-util --import' requires
> +        private_key = self.TestFile('fit/rsa2048.key')
> +        with unittest.mock.patch.dict('os.environ', env):
> +            softhsm2_util.run_cmd('--init-token', '--free', '--label', token,
> +                                  '--pin', pin, '--so-pin', '000000')
> +            softhsm2_util.run_cmd('--import', private_key, '--token', token,
> +                                  '--label', key_label, '--id', '01',
> +                                  '--pin', pin)
> +        return env
> +

praise: nice factoring out!

question: should we delete the private key?

This should allow us to catch mistakes we could make in the future where 
the private key file is used instead of the pkcs11. It's also what we do 
with testFitSignPKCS11Simple and testFitSignPKCS11Object already. I'm 
not sure we can technically delete the key without side effects, as it's 
part of the input directory, but we could generate one randomly.

thought: reuse this for existing tests

We have a few tests (testFitSignPKCS11Simple and testFitSignPKCS11Object 
for example) with pkcs11 and softhsm2 that possibly could reuse this I 
believe. The main difference being that the aforementioned tests 
generate a key on the fly (and then delete it, so we know for sure 
everything has to go through the provider/engine for it to actually work).

> +    def testX509CertPkcs11(self):
> +        """Test X509 certificate signing with a key stored in an HSM"""
> +        self._CheckPkcs11Provider()
> +
> +        token = 'x509-test'
> +        key_label = 'testkey'
> +        pin = '1234'
> +        env = self._SetupPkcs11Token('testX509CertPkcs11.', token, key_label,
> +                                     pin)
> +
> +        # 'keyfile' is a PKCS#11 URI rather than a filesystem path. binman
> +        # passes it to 'openssl -key', which resolves it through the pkcs11
> +        # provider activated by OPENSSL_CONF. The PIN is carried by the URI
> +        # itself, so signing runs without any further configuration.
> +        entry_args = {
> +            'keyfile': (f'pkcs11:token={token};object={key_label};'
> +                        f'type=private?pin-value={pin}'),
> +        }
> +        with unittest.mock.patch.dict('os.environ', env):
> +            data = self._DoReadFileDtb('security/x509_cert.dts',
> +                                       entry_args=entry_args)[0]
> +        self.assertEqual(U_BOOT_DATA, data[-4:])
> +

issue: too brittle

This depends on U_BOOT_DATA being 4B, which it is, but there's no 
guarantee it'll stay this way. Can you please replace -4 with 
-len(U_BOOT_DATA)? It also makes it explicit what kind of check we're 
doing here.

question: did you forget to add a test for pkcs11 engine?

You said in the cover letter you tested it, so was wondering if there 
was a reason for not adding a test for it?

Cheers,
Quentin
