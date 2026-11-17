Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69853606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gJgLizcZ;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=TzKlOOLB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38B9281011;
	Tue, 17 Nov 2026 07:40:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2vP3N5pwxdnk; Tue, 17 Nov 2026 07:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C4A280F87
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794901232;
	b=bV/zuM3AEWfbjsYTwsR183VV7MIoP8m5MHg4hq18NYbcb2SudCpNhWLMFLYBKS1IuFCJ
	 9hATLHTRhsazP0HV37Wsy/Mdt/sNF9rerI+4lLvvhLuYzcIbrRXRObnEo/obQLuNZUDRC
	 vQR26LodgEstLlV4RA72igGsIbsZFF9WCQyvUdQcBrFhhDqxM/xzxvi8ETgSVaTylsNAO
	 PaddC4Zp/oUYVwvp5h1UN81KnVnuFOayaoGdDNrAKfl7BDwQUwPBAOVzSzzgP6Hgnmr9I
	 pKJlh5mhXytMem9TkC1abrGlors/ja4k84tPGdwiSKbpAQ3LHUr/31CdxwafQyaa57Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794901232;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=yVK1hBjtJ/VJMuqytdqJO7TVLeML9mNyKmjBOHoCuLI=;
	b=dBIcFX1XG2iY4eLdZD/r8Tekb7mvP0NdaaBRaxgnfqMNDx5Yw943njMhi9KoqAT+Utf2
	 s8qE3oPHawxs0c1c0+WxDQ4+dp5lqxjqLJJDIuu4olGb837dS2SmQ/3Vvhapl16daoFsI
	 qtpfqdk6BpoxdZsAUZTE4aZiQ2qxOdb39AYMkuew0/ME3aDQFTV1zFcLkPX9ItKpCsGJh
	 Qz0COaOABvbzowdaFnisbmB5B3MzFnYdU7BgNytgtJpAwv9BYWxaepKqGZOAgRQ7C+lHQ
	 cFK+u8gnJz+xPO70K49zoY+23hSKcUF6MZiA6/Tr2H7zLC9KNY23l6IDUFyZcx7XLgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794901232;
	bh=yVK1hBjtJ/VJMuqytdqJO7TVLeML9mNyKmjBOHoCuLI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gJgLizcZzgiclESn7kqQNUH/D8vux9/5i8f4Tx6sFxq4srZz5SkrAOwCbiDXJB8tj
	 yLTi58daIZ82RJjre5YBu6ksBL3hborRQPkGVFnZxQ6QQY9FAPd3/7A4ibgJvcRbD8
	 ELCQEOBEgfRpl2SK5Ihon+5TvJsMpsC8yxE/x5SfhyqrXUsL5GIonSSBWGYbvqwz5T
	 YsmI+o4DaeMq0eo5nlXi9RGZaDIPhpqSpBVAyHhjUHU89ivUMD4wSWrE7oY+pZ+qta
	 ySGWzpnnWT1cj3kuvwr8yx9ix1ctlrXrTAJR9F2vW59h0nhucahxhxjhxsPTWe/Fh+
	 bcI8jENhlUadA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C4A280F87;
	Tue, 17 Nov 2026 07:40:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B91F1A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F8E860825
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:40:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7Q6Sd3PxQSY for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 07:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF6A3605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=TzKlOOLB
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF6A3605F7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVK1hBjtJ/VJMuqytdqJO7TVLeML9mNyKmjBOHoCuLI=;
 b=TzKlOOLB6KQI1UujhiObzuU8Zka55o2XWBPnrKY4M2oLpAvB40AiBN6/yc1kSVUmprGvJYjC4tEj9a3OqrPviGZzcE8z3bvSGbX/bXQmKQmENKt0e4Ck6JDCWT4/xHh3sMcmvJAxSLq4dM1DuTCOSTA3VAi/6p2WUc8txOI8o+Kd73nhPbVLVSr/DpU9z8V4K9By5HUZrulU/8fYMd/oeYJcaHDhh7IrvMsXkY1vAXWXBZXFZfku4BDRIG/BlVXoQp5hmaESkPrcQW7RQCB4Jo9oCWy6ZHFyirJZu85cFuzIhfyXC6cY2KJVN1nElFXJwQ9XdKsg4PLPnGiyNr1ACw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by VE1PR08MB5792.eurprd08.prod.outlook.com (2603:10a6:800:1a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:40:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:40:25 +0000
Message-ID: <da4cd2a3-7174-4bf1-b5c1-fb738681413f@iopsys.eu>
Date: Tue, 17 Nov 2026 10:40:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] spi: spi-mem: Create a secondary read operation
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-4-mikhail.kshevetskiy@iopsys.eu>
 <589300bb-100c-4d23-b290-8a859f79c9f0@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <589300bb-100c-4d23-b290-8a859f79c9f0@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0057.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|VE1PR08MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 3384bd94-5718-48b8-2da5-08df447e0b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|921020|261022105027099003|261021121427099003|4143699003|5023799004|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261102123227099003|261009223027099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: nFD9Incad/b5tcK7KTOc+7Ww4F1HnbPsb0cR8aKZodtBtpt5RdCzzUBGcnD3/xqVSizMy5dLqO1sdF0bfPBsOT2ePMmxd8pnQjGA6ZuzPDB09KttjTHAUKqbPaCUTe7+UVXnRsuSemOyCV+vM//qF1El6/OIGeBcXB0H9KRCzTrJnc49+ydrgdaIJrI3h+BIL6mc5cQ9NO5XTIKwq2UUoaEFf26bJzDRuXpfOZzUEjckC4EXJWlwzNPu7L7bwew/TxOVORZMN9R+a4pTLUAMnusYh0+NTPoMkCuvsMxCbHPaIFc8KPxuzJJmy03W4St7DqGSEKItyJNlBcOW4yi53/7SnIXLY6bgBwXRcermAtIAjPdVsgZ+7z3XNAwbeLmoHHtkV/dAA60AVyihIfeMff703YxCqYcxG5H14v9EEROKLn2zQp/0o2XPvmVR3PGm3FBZdFztAVfbxxYmDYUNNh2KzOO99zbN5n3stjLr5wm+RXHdd2G3wRmbBecf+5Pb+Ym3N1MTVfzaLMyqG7Am1FyHGwGJgK6ZjqxEPQxmAY18ZCdz/mEpfIFi0ic8ZXmvXwubzu+i+QSGMqk5rjeYG7JHzrDVn8UDZuCi+TNC2QZM5hVWOdSTTFUvzhvv1t/USZvdcBe0m6qnLnU9EOwsiBVm8SWhnL9/CbFL/48JNloWZBiyb+RgJgEPyoH6FVpeSZ55MOtyrurR7/gQhdmXPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(921020)(261022105027099003)(261021121427099003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXNROWFkTHJIejFPV2ZIQUdvbXBwVnk4NmNjR0E3QTVmN21oKzcxRCtPWjlO?=
 =?utf-8?B?c3Mvb3BpWWlHTWU1TEZzMWJLNU4zSnZ3MlFzOE84YVBYbWNsd1krTEY0MkxR?=
 =?utf-8?B?OG1xQUFhR3NiZndXWkFmd3c4UHNCWkdTc3Q2UHB1QzROVmZXeklpZUhTZ2xk?=
 =?utf-8?B?RVpzcXR1a1NOMk5KV2hDOGdGcjlUNEd1dU1YMU5TUUNSY0tWMlRwYUE5Tnp2?=
 =?utf-8?B?NlZsSExoUUpudTg2czByN2dUQnorcUswSUphejRkQ294bnFPODFJRzJjQzg0?=
 =?utf-8?B?MjB5YStZY3g5bGpkSkVNUlh2RXp5UGNNWE96eDJVNFM5R3FMcTBralYxQ3F3?=
 =?utf-8?B?ZndrZ0xQMTNZRTYweEd6Lys5amRXMWd4VFZENk1PaUdpZU9jSm5pNHJTYTUv?=
 =?utf-8?B?TGxld2JXZUlybzAycjNtYVN3VXZtQ2hWUGp4aC83MkZGSHgwN2xyS2luWnd0?=
 =?utf-8?B?Z3NXL0pjNUhqK1lrWGQ5MTQvM0luNjRoS01uUG9pZDFxNnRyL2JvNklWaVg1?=
 =?utf-8?B?OEhGWGc3VURySmRxSXZJaTlQMGdVR3hZeTBMTXA3WStWbDdPYURGVFo5ZVI3?=
 =?utf-8?B?d3gyVXJicUE4dUtPZFpXNzFrdXB1cFBuVDV0TkkxdDNxWHZjMWJQejZFcXUx?=
 =?utf-8?B?cjBVTlFCV2FqQ2EwMEQzRThPc0VCWExrOU9sMXZXUzFxZy83M3JWT0lIR1FN?=
 =?utf-8?B?akpvSVRkZ1dxMXlDYU5Xdlg1eWVaRloxNDJkM1U5bS96bEtCZ3dZbXhQeWxk?=
 =?utf-8?B?UDZSODREUm8zRzFNOG1WQ3ZaMW9XUTk0QkJkdGNXVWwya0pjRFA3TmsvRlcx?=
 =?utf-8?B?RTU0QUxkWkxvRVYzc2xQbkkwNDJ2L01FRXV5Rm51OUtwNmVBM1BhelRWaVZ0?=
 =?utf-8?B?SUwzaUN4a1hrOTZ0SkNLaC8rRDZWeTdYSVZRT2lmbW9WTkVRaG15bHdqeWUy?=
 =?utf-8?B?S3Exc2U3a0lQV0J5aGt1OVZxUkMyQUtlTDFOc1hKYjE4RXp3bW9EdnhFZ2ZN?=
 =?utf-8?B?TEVmMWRTeVZvTFZvc1MrOUhHY3ZKLy95ZmR3ZkUvTXMza1dRTHFYTDdrUGw5?=
 =?utf-8?B?TjJpYUNobTBRWlg0d0FEV1IrQUk4Z29ReExQcEE2V3BUK0VEN29OdURuM1lQ?=
 =?utf-8?B?aE1ZTTliNHZaZENvT3Z2aHF3TXZuM3FKRjhQeGlwbFN6TXZ4UWtNMWxmVnBL?=
 =?utf-8?B?eDFnVnppUHdhQkkxT0Y0aEJ1cjBreml5eFlzbDVVbllQeE83Z1A3dVJWN01i?=
 =?utf-8?B?VFBWVlkvWGdNbzZtNFF1eFFkMk0yZzN2cHgzTUwvM0VnNFZnaHZUK2VCejZq?=
 =?utf-8?B?bXpqTnpoYTBqV3B2MHlpTVZCeEdqdXlSQ2JISHBieVJZODdDSG1PMDh4RHFS?=
 =?utf-8?B?S2dhN0lEc28xUFVIUyt0c0wwaUVHL2pucVNaU0RJOElUeVN5Y3M2Tjk0RlhH?=
 =?utf-8?B?ZDR4NnFDYUNqaEwvQ0NHVE9heDMwS0s2NFBaT2N5YWFIU0VBMWYvcVBRcmdm?=
 =?utf-8?B?MXd0U1dIdU9jTkQwcXJ4TFF2ZTF2MFRZeHNxL1BLTk0yajY2VWVEQmVBWTd5?=
 =?utf-8?B?ZHBPVkhTMGltTXJDeHJYMDhwaXdkeVhJaGVFQnBIUGprSUVFSkhCNmhQcnlw?=
 =?utf-8?B?WGJTZjVpVXIvVnk5WitWVGllZGxyajRNbFJPN2dwVmg3L0ZyNkRhb1Zpajdr?=
 =?utf-8?B?aWF3dHBUZ2wrWDNkN0dTUW0rZUxhOWRxMkM4dnVQODJEbHZOSjVYaHRHRlFs?=
 =?utf-8?B?dlNzY0h1Y0UydkZrZk04TTREc21ZRkZ1S0dWdS9RbVY0NTVZRnRpRDVkcHZa?=
 =?utf-8?B?TFRKd3Rlb2FmQzBZZllicjUzTzk4bHpwQ1EreTc1b0NTTFhHNlIzS3RuL0d6?=
 =?utf-8?B?ZGpqc2xMWmVmVmpEaHBvYmthamZmeGNaUkEwcDI4TFFQb1VvTElTU1ptWVQ2?=
 =?utf-8?B?ZW1MMG9nMVhTVTVvN1ppWm1DdlZtbkU2TWY4UWl2SmFBN3lhOTZGK2RyV0xm?=
 =?utf-8?B?UlNacE5OS3NZVnN4blZDWXdhUlQxRVJSWDlXRklobEFCRXkyNlBmMWxnckZH?=
 =?utf-8?B?QzdiaUZJdW01TDNGK0tZall0ZUFNQzk3dzltdHdWcUFqUGJMaURvelpsZTBa?=
 =?utf-8?B?QzUrNFByWlBpR1RQSHkrVGsyMEVLZTBDaExVdTFaYmR6L2RQcDhRU0xLbUdB?=
 =?utf-8?B?Sit3VFkvK1ZkcnAvd2pybzdFcTE1OG52d1JFZVVCTFJlL040Wi9KbnMvWitj?=
 =?utf-8?B?a25sS0tiM3F1aUthZjVjVjQ1QUhJYWVrWUVMVWRiUW5ZSUhzRmRUb3ZpMXRi?=
 =?utf-8?B?U25oQjlsUlBBWENpQ3pXVDVSUUN2TnkzWG4yVEkwSzFGajNiMXhqbmRMVHdn?=
 =?utf-8?Q?TsT/4JBClKEO7F1o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3384bd94-5718-48b8-2da5-08df447e0b14
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:40:25.3916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0Huu4Ka5ZGh5g9ETlsBR3C4m0XqdMv30ZWOOtKOZE+03NrhQNqOMqMfNIkoWndYbtT9pJWmwT5HNMWfpIDlwCmtU3Sbhbzi3w90HrmwYNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5792
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


On 10/7/26 10:56, Frieder Schrempf wrote:
> On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
>> From: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> In some situations, direct mappings may need to use different
>> operation templates.
>>
>> For instance, when enabling continuous reads, Winbond SPI NANDs no
>> longer expect address cycles because they would be ignoring them
>> otherwise. Hence, right after the command opcode, they start counting
>> dummy cycles, followed by the data cycles as usual.
>>
>> This breaks the assumptions of "reads from cache" always being done
>> identically once the best variant has been picked up, across the
>> lifetime of the system.
>>
>> In order to support this feature, we must give direct mapping more than
>> a single operation template to use, in order to switch to using
>> secondary operations upon request by the upper layer.
>>
>> Create the concept of optional secondary operation template, which may
>> or may not be fulfilled by the SPI NAND and SPI NOR cores. If the
>> underlying SPI controller does not leverage any kind of direct mapping
>> acceleration, the feature has no impact and can be freely
>> used. Otherwise, the controller driver needs to opt-in for using this
>> feature, if supported.
>>
>> The condition checked to know whether a secondary operation has been
>> provided or not is to look for a non zero opcode to limit the creation
>> of extra variables. In practice, the opcode 0x00 exist, but is not
>> related to any cache related operation.
>>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> [Linux commit: 6f96f2fa152518d93ffeedbea781db50aef7f7dc]
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/spi/spi-mem.c | 17 +++++++++++++++++
>>  include/spi-mem.h     |  5 +++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 351ca725524..ae393ca48bc 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -639,6 +639,23 @@ spi_mem_dirmap_create(struct spi_slave *slave,
>>  	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
>>  		return ERR_PTR(-EINVAL);
>>  
>> +	/* Apply similar constraints to the secondary template */
>> +	if (info->secondary_op_tmpl.cmd.opcode) {
>> +		if (!info->secondary_op_tmpl.addr.nbytes ||
>> +		    info->secondary_op_tmpl.addr.nbytes > 8)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		if (info->secondary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		if (!spi_mem_supports_op(desc->slave, &info->secondary_op_tmpl))
> You are accessing desc here where it is still uninitialized.
will be fixed in v2
>
>> +			return ERR_PTR(-EOPNOTSUPP);
>> +
>> +		if (ops->mem_ops && ops->mem_ops->dirmap_create &&
>> +		    !spi_mem_controller_is_capable(ops, secondary_op_tmpl))
>> +			return ERR_PTR(-EOPNOTSUPP);
>> +	}
>> +
>>  	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
>>  	if (!desc)
>>  		return ERR_PTR(-ENOMEM);
>> diff --git a/include/spi-mem.h b/include/spi-mem.h
>> index 81166492da2..08d854b1e52 100644
>> --- a/include/spi-mem.h
>> +++ b/include/spi-mem.h
>> @@ -201,6 +201,8 @@ struct spi_mem_op {
>>   * struct spi_mem_dirmap_info - Direct mapping information
>>   * @op_tmpl: operation template that should be used by the direct mapping when
>>   *	     the memory device is accessed
>> + * @secondary_op_tmpl: secondary template, may be used as an alternative to the
>> + *                     primary template (decided by the upper layer)
>>   * @offset: absolute offset this direct mapping is pointing to
>>   * @length: length in byte of this direct mapping
>>   *
>> @@ -213,6 +215,7 @@ struct spi_mem_op {
>>  struct spi_mem_dirmap_info {
>>  	struct spi_mem_op *op_tmpl;
>>  	struct spi_mem_op primary_op_tmpl;
>> +	struct spi_mem_op secondary_op_tmpl;
>>  	u64 offset;
>>  	u64 length;
>>  };
>> @@ -338,11 +341,13 @@ struct spi_controller_mem_ops {
>>   * @ecc: Supports operations with error correction
>>   * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
>>   *          Octal DTR
>> + * @secondary_op_tmpl: Supports leveraging a secondary memory operation template
>>   */
>>  struct spi_controller_mem_caps {
>>  	bool dtr;
>>  	bool ecc;
>>  	bool swap16;
>> +	bool secondary_op_tmpl;
>>  };
>>  
>>  #define spi_mem_controller_is_capable(spi_ops, cap)	\
