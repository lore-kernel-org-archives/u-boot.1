Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530E60A5BC2
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CsoJCtql;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=SwmfPFY6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00C78406CE;
	Mon,  2 Nov 2026 14:23:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id irY46DS0lMmk; Mon,  2 Nov 2026 14:23:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E78D406A5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793629402;
	b=Xe8G+d2V56bp790JTLNgcR8SWCvYcWRAi3lckkjY1N95RZOrfdpymNYpImC6vOJCDm8Q
	 h1xATegv/C4H0/LiCNXISshaPwLzbJ1+vuGn7ojVXbycAzOE0P1wulBvvM/+/NhLAzBCY
	 Q0I0L42QELwePlwQT9sX+AnGvgHwgmm88zkrC0jaD24xSwIduz+zVA6huefZvfKDY4KqD
	 c8yJ1BpqsvFxO1OXc5WWwtcmJbJ8WN2JIQ/3gs2ZKFinkn1YFR6YSUxF8OwjDnn2DOhIJ
	 lsDhOqVpD0ejSpBVvqBAmSx6ZMD9EEIOFkjyrlPgZN9zaySAVVcAVAGXjc1jgFaYExw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793629402;
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
	bh=LpocJcS1J8QO1oQDMUaqgSvcvfHW1V1hS8KqNuw+P0Q=;
	b=J6lHnB8gAzBkBCR20RerL+F1JUq5A9Dy4Nd4wmCPoql2Ok2306oiw2rGI3TPNCrpoQ8r
	 Gpad7TvIwRKEc+trIeclY1lo0oqc1fLxu51+B6BLlYvZ1+jnVBEBk9x6OWj0KW3BROdx+
	 FfH2Wwmxn5/JLj5VVUMphInb/qsHuD/S3NUGCkq8VE3j7zGcpqSVjFTr0pd0VkYXcZgFu
	 zWJxa8zNJlfaEOpDKdE6aexNSgRHAhz0i39NxFVkzmJtssbJapw6Gg1+9y8FxJ980k3a5
	 UO9K1i8JH9adMK1FKziwYxXA0YcF9FdmOErlMSFDyvMeEC4+lwjWNZUfUwTbOldDI2A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793629402;
	bh=LpocJcS1J8QO1oQDMUaqgSvcvfHW1V1hS8KqNuw+P0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CsoJCtql4LPmSNhejhs6SMyYQH6BIiLZtGgyj87e5Dz4otXCmNkU38Elx5B70r9le
	 AHz30nwioMq9XjYlr6RgNSBR/T3nX64XoU8IFDicmOQgXvBBwPjGNkPp4nyenrc16Q
	 iZ7mpS3iU9o5rWjLhZYY+eFfOxJvSbmAH8MapSMbfTq8lkdx9q+8FARpBzUxVUVf2k
	 gCsvZZvKMlDmtKCjC/1PMeKBab4JTruh8ebYqEbacd2lLhW1gd6YJfKZQY0I2u5PhJ
	 670vhToSTvLLf0TwL8nSWaW2tkZBJRVTgW92HVoim/5MTiiIusVXH0DtsjRX5cXXeo
	 XuAnD9eNmgljQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E78D406A5;
	Mon,  2 Nov 2026 14:23:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 985BE4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A29A400D7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:23:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdaDc-pFJeeS for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:23:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4FD78400D6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793629399;
 b=iYn1yEc0O/zcVKY/nka8tUcjd/KkL6OpircUe2h0GpS/LzdurSqQDUyq+eOq82oVQHQk
 BRNC0LJcUTLM3hg5xZ7MvN61sESPLxwp3wHdSxdNwSRTxogY3Hpg9ZNKyPrDz4OihfJOf
 /vns7LDCu7Ft+YiseYP82msO9N7/37KSmkN0WqPetj3Bw8Tx3BaUzLZiEMYdoNpeJ119C
 /AU77/0pP1F01YZW08uDf8UGhxJb+Ua57PRsjaiTvozJl0p/8kSFk8Ex6S0lhKc3NO4ra
 x5ES3HfVimV8RCyxEj47SrjLnNUXRHwjX3K9BaAZmJCwsgmiZSNjzqdtVOtVoiZjCrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793629399;
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
 bh=LpocJcS1J8QO1oQDMUaqgSvcvfHW1V1hS8KqNuw+P0Q=;
 b=mJZ0qtAmSYmUDXNebRXGHFnTh1J8PG2qb3JWoVfd+GdBhdwDzPmhHaZiwH2VV0Y8HWNq
 XJzC1sjkni3LyHzaB8aYNKA4g1ybCNasj3vxjxrcudxMqcZGwRK/gK8YiLxfKNd0tMEDs
 iC41TXDHNrww70/gmqKweLA0TZSHIXPKDZx8nfNvCtMqbyRnxDiGToSY+W6zsAb86tJMa
 veIc6NwYVB702y+3tBd4E6OIKX8q5Cgxw4zzVb74v58yGtjQK+nDKx4GjvuzylOLaHJ2e
 0tCUxHTiywHVPo6VlZ/9UThwffWf98BSo8dzfXf6Iy1SMJw+L9iuxNzMIBu+VAKWWLA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=SwmfPFY6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=SwmfPFY6
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FD78400D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7LaWzC36q0fjE/7dyBK4ZbeFu8VxS1euyqG1jVXnxGiD+GZiPqloal1MSXnbaDvMrRfsB5nf5erWVuOKkqzxUzjlxOirwd/XrMvrxBib+C+UZjDBeBxJZ4Z3yhhGywhd0fGDGHSvUHL5rWmtpATQrnl9snn0z09ivkpQPdxBWa1ZqW7Nzwf9qpNM6IRN1z8/fyvydJuHHsQamZ8PUAhmUM7L3i8MqAH3/scDzvyfDgGZK2VIVCaWe12Qx55cv+1kCZyfetYeGzoNB2GZJK52UiS9Pw6rcm8ERIQK+irfkPjB4ERhvP/FU8mX9tVZ52Z/mU4UbB7DAldF7kFtmfEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpocJcS1J8QO1oQDMUaqgSvcvfHW1V1hS8KqNuw+P0Q=;
 b=PPUHfI4KxsZH/28W8DFK9GmwYb7JLndq+RJFI+SArmTBCeoOv3ynGQCB+TXcOT2N1noctVwhJljdF/9u4P1ZJDjkYTmTKfhGRiKJDUf9pBW2s19arMqS5uz+71IwYeBIW7UiqRZATn/qKARFrTslAvPbB9u/d0Z8mJca/wS7TxKmnjsPgmTKeKKtIh4nkdlsdS5ZKXEPSLlyN5XfgHze62X4I/pA5Yh2Q3tCN+Uttdo0C5jieYQq1CoLNMDi81HvDaqoGsOVtSO8FIAefuCSU6VNTsJzarR+n67Otm+nB/Uc6jJUEk4/6C3069HHrlpraXyNAf0zp5LvhljomB2Hfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpocJcS1J8QO1oQDMUaqgSvcvfHW1V1hS8KqNuw+P0Q=;
 b=SwmfPFY6KN3Rid53eNANreuEAdIVJTghA4H1PPdFSiEHYNI9wko+t/vqnWbZPZDl7mLkwrtOrKJbAlAEI1hnfHxM37mZ81JAxDmTEdPiBOXLJBttN+M98djGTj2D1G5nddcorBtWUMY2ah0qLTXCkJfqiSfuOAhYhSbn1pRK4vooRnse6HKWT9QGr92r0+22OKDZ4se8WqdO3Ox8qTvdLm9UJXK37ucg2fwe0ZMTkfg92Gg2keDZGwGm4O2BhJq2h+INOin34SmBJ6Yw463rfzW76AV3NFT29MEupgFByWGzBvWMae7mkhlfyrzRN1qr5Qt5C0+0zQTnLmmYIK4Odg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by VI1PR10MB3551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 14:23:13 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 14:23:13 +0000
Message-ID: <9236f53b-d17e-4078-b4bf-adbedaf4c2b3@kontron.de>
Date: Mon, 2 Nov 2026 15:23:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] bootstd: rauc: Free the boot script of a failed
 boot attempt
To: Simon Glass <sjg@chromium.org>, frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-4-b5a878627107@kontron.de>
 <CAFLszThLc6_KXTyM7WV9KFC+iazCcLJzLqtZAsnR_bH3-hA-4g@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAFLszThLc6_KXTyM7WV9KFC+iazCcLJzLqtZAsnR_bH3-hA-4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|VI1PR10MB3551:EE_
X-MS-Office365-Filtering-Correlation-Id: 85505bc7-d1b1-4c61-9efc-08df38ecd409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261026121527099003|261021121427099003|261022115727099003|261022075727099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: qQjOJcL7AV4sGaFEe8dch5uynjQNdWSYlLW/o//dP6rQiDuT0NVzi0kw2GZ4R5Nj9zwPriGuJ2PMeC2rpfyQdBb0CyXALixGC10SNcAYuK2rK8aeDE2YQzsMKUjXv5X+/57ZzRS5qsyZ3mrAtCeK1EgGd6mxfovJz7n7rAukpBpTyRjb5ZAnlo3cAgD6b7xnUq+sTLRI8uFn57JIyr89uBbTQ7Vi+lRzR/Wlw28Fj2x8mgoNi6H1TmMU7eVI2zjbDgNzy6KMvtHc5Gh+r+rcBp59LPrzvVFuYLVwKTb4XOuyYJ7521nDXJ+p4GB8A6YmmDqMWZ/4Hto3zH4fLLrEakjcxDK7S79NZi5+BF4zHsWeAOwnteWdiXrNiSwx76u9eub10GzNS9IHvRYhbN6AdmU6GGGbULpEGWtMt4GJVBxOsvE11LklEGdK1xB6xwrgGxzr1HJUExUOGbJ83srjRLxx/9r3VHxyhS3yfzMMzdLM6pnpror1Ys5c3Oyc0jdSsNptKMfLO1Y54Vm6gPidHYq1TPehZZZYBpeZ5VKkuGfB28Ll4jUSBoJqaDCMgpJ2mHmjz0fnhfMTaVd+I7v2Fpn7ZYj129/Y9LM6kEE5M8zF+iUORmcHOqnohM49chHzxjxvyhnYcfwteYKlSNTb3RDlwvtmNlL72eykFlj8ebw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261021121427099003)(261022115727099003)(261022075727099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5sQm04T2ZaempyM3dGY3pPcVVHZVdLTTcwa0dOU3ZWN0RSV3Q5WU1SODZX?=
 =?utf-8?B?T1RWMEk3MFBLY0dSTjJLOVl6NENnelMyWDhrYUpUYUN6UE5iM21zMEozY1dP?=
 =?utf-8?B?V3VHTFpjcnRTTzVNZ005N2JyWnhVMW9ac0xNY3JHbjdPZzNCVXJScldpNFFC?=
 =?utf-8?B?NGtreHI5L1gvNm9KQWhCaVZpa2w3ZmxpRUZMc2VXbzhlc0RFT0NrbFhwTmV6?=
 =?utf-8?B?MG5NaDYva1NYaHQ5cnRieTRPaWNxcFNQV0dIVmZZbndiVGpUVjNUenJVMDht?=
 =?utf-8?B?bzB1UXkxRUNGOEJGbjQ0dTRRMU5zVm1BcjEwdndya3pvTUhzT2piKzBqL0ph?=
 =?utf-8?B?K3VCcXJwUGV6Mzljd3lQdG00T1NKZWFNcXRocnMyQ0FFWmNVOFY4UjRNN3Rn?=
 =?utf-8?B?b3k3NTZQYkw5Q3FrS2V2NU5YVStqcllZcTI4SHlBbG80RjlnOWMyRUI3WVBE?=
 =?utf-8?B?THpqN0h6cHdjNW9RYnV4RTlScGROV0RpdC81Z0hBVlhOazZjU2o1clh5QmZk?=
 =?utf-8?B?cUpEZmg3SVAwa1lMa1dDY1ZQd0dxdG1qOEpvQlF0d0d2YWZqeDhuTXpQMjhC?=
 =?utf-8?B?dDlKZmdSaGw0STRzeHFrM2o4VW9Mck1RODVNYkJ1RWxoa0kwMVR0eE5JeTZS?=
 =?utf-8?B?NjZKWW9iYkNEaWFBYjJZNDRXWU90bkJBL1FNbnBLcCtvMUlPZ1NBYk1mQmNK?=
 =?utf-8?B?d3F5bHJGNzdPWk1uaE93MTU1V0NWRHNHN0IxWmJ1dTNiRmZPS2lvRitQMFlH?=
 =?utf-8?B?RHU4Wlpoam5LeXpGN0hGZHVzTkhIcFMwd0Z2OTBaemZ2L1JCNFExc040MEZr?=
 =?utf-8?B?TEZ1d21wWUo5OVV2R3NsUDdkSkJEZVN1NHJrbjVGLzlMZlgvZTJIZmNTeUg3?=
 =?utf-8?B?cFhESjhVUWc5cko3MDdtckkyZFA2ZGE2bDFZQkh5K1E3NnJHY3RWOEtEK2Zl?=
 =?utf-8?B?VEdJd2ltdHpia0w4dFBvMVJ5dmtrOE94SGpwam5JWkg1aWRBOVduQkd5YUZq?=
 =?utf-8?B?QWtFV0gzZm43OHFQNk1GWEdTY3c3TGhjTXR1VlB6am5PY05jWWdQN2NDK3V6?=
 =?utf-8?B?YURnRitDNm9QUHBTVE1vaGFNY241RjhaN0NoSE5XaDEvQ1RLUWEyNTQ0TnJH?=
 =?utf-8?B?d3hxVGY5ZW00aGdwNzUzSGw1WWhRRXVDL3BCMnUwNTcrRG9mZUQzSlE5dFRU?=
 =?utf-8?B?VGlkTzZneVI1c3dIUlh6MXFiNXoxUEpsWllZVlE0QkxYdGpTaUYzQ3Z2RGdj?=
 =?utf-8?B?U29DcG45TW1TODdpTk5LSU1hQTgxTm9PZ1JVZmhrN21GOUUwdCtMTkRBc0JK?=
 =?utf-8?B?ZW4xVFBraDZadVE2bEtvT2pBa1NzVDNVWFpGaWxlQklXZUkvZGx1a2FnUDMr?=
 =?utf-8?B?eHVkSXgzUFpBd1h1WmVGdHhtcEwzamtQcm95RXF6K2dxV1NJcEhGbnhvL2NQ?=
 =?utf-8?B?WlBhcE4yWDcvR1ZlT2k4K1d3ZWlqMGw3eFM1RXpOUGNWTGN4bFpuYm50cjk3?=
 =?utf-8?B?RVNTdWdYK0NKSHVsQUpvSDR1VFdPRk4wcEZUVlcxWnpJYjY2alpjcmd0MjNT?=
 =?utf-8?B?V2o0cnEzOVptN3VkU3JpeXlxQVhiVTZJMUg4Ny95THlBOWtJamVZTUlmaUtz?=
 =?utf-8?B?VzZTMkluQjJQY2o1YnR3ZEpnbE0rYm1nbHpFNzU5UGZiT21xelRMeTFFelRX?=
 =?utf-8?B?aWVIeEZFVjMvbHpodkVwUVdkeVcwNGszZmVDdURtRlVsMW4wZGdCZzZiUkxk?=
 =?utf-8?B?WjBuOFF0anZYenBEVXV6K2xITUtxRlR3Y3I5ZzdjYmc1ZGh6dVlsVVpXTTRT?=
 =?utf-8?B?RDZWaXloczR3Z0d1cTVYRzNWVlhlVmlaZXF2cUVKQzZ2bXB1TEhFRHJNcHdS?=
 =?utf-8?B?ZEdmd3VqaTAyQWY3TVQyTE15MUpjTnhjSkx5QlB5aStjWE1CYXBKU1NJWUZP?=
 =?utf-8?B?UUgveDVGS0hPeGUzeGN6amhVMGwvUkM5Z1ROTzZLeG5tQ2IxOGM4UU1QRnFB?=
 =?utf-8?B?VGNDUDc4Wm9QNzBBclF5dE92NFE2VklYU21oOU1DRzM0OUdIYzJqUWFlcWd6?=
 =?utf-8?B?TWdlSTFuazJyNGM0WjAyaVR1bFduMWhQVmFhWjNudEZEUDBwT1RFRVpzVDFn?=
 =?utf-8?B?M3dnZWlsdENJRDRaemNzZnhrdS9TZkR0enQxdmN1MmxvaTEwUW1vMHplS0tL?=
 =?utf-8?B?a1Ztemh0eHViUk1ORFFTYVFUSzVGSlNaTmNYc3pOVDdUNElDVlZuWkpuVURK?=
 =?utf-8?B?N2xtMzMyaVdKVXFhd2xqOTZRbmdNR0Q2RExJVTNCdTJhckN1bzdETkFSdWtF?=
 =?utf-8?B?WG50Q2g0SXNIQkNkQUNzUzN2bWUwYWxqZlM3Tk42czFCMnozdlJrcDBsaUxv?=
 =?utf-8?Q?u2lW63h4hp4SWoac=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85505bc7-d1b1-4c61-9efc-08df38ecd409
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:23:13.2439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G9sb8kqZb9grMPPtFKUSfWAKo+QJcMO+x5qbJys4zy3OIxNp910Vko1xxLRIM0vGd7ZjmizohyPeKqGqq+Sc0AujJcahgkgstka6FVq75Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3551
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

On 31.10.26 15:06, Simon Glass wrote:
> Hi Frieder,
> 
> On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
>> bootstd: rauc: Free the boot script of a failed boot attempt
>>
>> The RAUC bootmeth loads the boot script when booting, not when reading
>> the bootflow. If the boot fails, the bootflow keeps its private data and
>> can be booted again, for example with another 'bootflow boot'. Each
>> attempt then loads the script into a new buffer and adds another image
>> to the bootflow, but the previous buffer, image list entry and subdir
>> are never freed. 'bootstd images' lists one more copy of boot.scr after
>> every attempt.
>>
>> Free what a previous attempt loaded before loading the script again,
>> in the same way as bootflow_free(). Also check the strdup() of the
>> subdir.
>>
>> Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
>> Assisted-by: LLM
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>>  boot/bootmeth_rauc.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
> 
>> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
>> @@ -305,6 +306,15 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
>> +	/* Drop the boot script of a previous, failed boot attempt */
>> +	free(bflow->buf);
>> +	bflow->buf = NULL;
>> +	free(bflow->subdir);
>> +	bflow->subdir = NULL;
>> +	alist_for_each(img, &bflow->images)
>> +		free(img->fname);
>> +	alist_empty(&bflow->images);
> 
> The search loop below only runs while bflow->state != BOOTFLOWST_FILE,
> so this reset only works if the previous attempt got as far as a
> successful bootmeth_alloc_file(). If bootmeth_try_file() succeeds but
> bootmeth_alloc_file() then fails with -E2BIG (or fs_read_alloc()
> fails), the state stays at BOOTFLOWST_FILE. On the next attempt the
> loop is skipped and bootmeth_alloc_file() is called with the stale
> fname and size from the previous slot, even though bootmeth_setup_fs()
> now points at a different partition. Please can you also put the state
> back to BOOTFLOWST_READY here?

Yes, I will fix this in v2.

> 
> The image-freeing duplicates bootflow_free(), so should be in a helper
> in bootflow.c which both can call. That would also fix the commit
> message's claim to do this 'in the same way as bootflow_free()', which
> is not quite true: bootflow_free() only frees buf when
> BOOTFLOWF_STATIC_BUF is clear (although that flag is never set on this
> path).

Ok, sure.

> 
> A test which boots the same bootflow twice and checks the image count
> would be good, perhaps as a follow-up.
I will have a look, if I can add a test for this in v2.

Thanks!
