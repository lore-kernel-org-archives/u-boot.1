Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D32C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC9CD80DD8;
	Wed, 22 Jul 2026 10:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhO1O4QQ2avv; Wed, 22 Jul 2026 10:52:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23EB380D3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717571;
	bh=NG7+CiIYAe9z3OgH+UN23MI8fDsqunJZGmyPftsSh3U=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=iwec1QxQgZt3BeVRZf2d4miZAfh9FAVJFZcj3cP5dtCzG6bOdWKTAgxu7EKEyzVE/
	 xkl8BhU/xhTTaFoObi4MDbdHXzcAMMV9PJX5OZZqPtUP93lbsM9gfuWMgCEIe+Kgej
	 KGMgz5/xZfFpaQ2+raS3TNUAJImiwZSPSAwKjWoT4jKr2ZrKStAASbU4RqNpOG2zk5
	 y/3UBE12R2KxhlujNKZSqQQGaZaoMhcPMj++Mq6F14KCURyAzw3/pqdowhxDnpZP7Z
	 PRw/qoKNcFMEGpCHpi1AEf9qThx7bNY0W0mJ62W1YzZ7bTN17D9QAmrGnKQkbI5NPK
	 IwXAwJLVRXq/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23EB380D3D;
	Wed, 22 Jul 2026 10:52:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CE5B390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0327040874
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azez4hdS42Fl for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:52:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1F8F840873
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F8F840873
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F8F840873
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krfR7Ei8xaIgGpeQIbMnzl0FsKYCUaYtLEqGv05XL83cOLb7E0/2dM3aQPj7Q8VVnRujG+fV+BvIXuw600k2PSmVBKP51Ds4eRXa+mTfzCdyH7TKThFWRlExgKQs5ifMnZbrq9wAgcrhKuoExzWjZJyjnxCfgL8teyag2G8xFCl/DKU3YNu3oHwLp1ENBcQVAiK7YccXio5IBjjcVldHHP3wzLzCDnqyV3Y5GBV2HJnooCIQBVtqbitjHXv4FX+/A2EtiXjDwp6yCR6uviP8aP2mq6vqHOiwonuxdJ96zowJLDqcbu0FrE2kQwN1UDLvTN3JxooNL8PW174wpDtUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG7+CiIYAe9z3OgH+UN23MI8fDsqunJZGmyPftsSh3U=;
 b=etfYu29VmEL4c7UPkRrAcbLGDBHuCZ+omp48izUZQ2p8a29FyGet0pOWohRBwVYR8OIJvAK4mzWubwZvyzuuAgjfCFUIgDvKFrk7HtKxo7mUBZRdH5zutfMUgUJBqX9r3nYfSYnCLKmeahezvoFxTYOrrBY1VOpRWB17Vjt4yfBLEIJkjIKQ+wcgPjPrS60befwVKzxKXC8Nw+FLSNxJeYx2f9OF97mpsfLS8vd58V1LWzzDbhDLeOFqzUnaFvoz7gR+P54EKSwvJhJEkMpScUmGUiEAdgjNd5H2MWnd/+vr6ruOFffyFsEb/sL4F4rPGw3whBKSkhjt2jA282cbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA2PR04MB10513.eurprd04.prod.outlook.com (2603:10a6:102:416::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:52:44 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 10:52:42 +0000
Message-ID: <1bedb50c-6f99-4f6f-946e-2dec47d20624@cherry.de>
Date: Wed, 22 Jul 2026 12:52:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mtd: spi-nor-ids: Add XMC XM25QH128C
To: Fabio Estevam <festevam@gmail.com>
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260722013642.1011666-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0020.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::9) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA2PR04MB10513:EE_
X-MS-Office365-Filtering-Correlation-Id: b3205174-f1a4-4273-4ac4-08dee7df5aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GieFg4q0JYQTQdOMP3MtrDcju/gD/gk/TmqG2B63tGJpLwQWVk4HPUkYCtICwZe8JB8aPPQajvN0eTm4qliWEbINRiHl8vR6nj2NIcJeyjzym8hvmy1Uyekz8rIQtm1UJJ1Nn/PUKTBMIbkwkFWn76XRFbb5hw2nt+0hmn4/RfpMzVa3Mn+c1yNJzuRBcJ8MkvA33OyHAw0YY049L6zBQOC97P04qeVgU62Sh6GIXuOzL/m23IuAZmugEtIzA+zdGSBMWXz3JwIYsKSsndIxqg+9geCfUQNDhBWr0EnPSYBUvns+ayZhrWiCtB4TkYWZWGZxPNxEaT/dZzvuAeYZGaJ47w6CktXC2VZQx4jtIfUd+u/Q1T3NkfHze4Uo4lLVmzp/KTH9ax7f+ryckzNQ9R4JFef0uqC8JRIGzz7FGohPJKS5IOBQSJmqj0v3rQSUDixUkJ+NgslR6CcdQPSBwahuMPmnvM0xKU6uEpY6GiHQKYCQILQ4rPiJB9cRO6BYjjzUNuBwwS6bnPNzZefb3UwitGdfpf20s5K0qTRF5C9BODx0GCdhDQ0RjF5ctvkzr9eB+9bp9CLG5yyS5JO4JjzYnASm41o8SbeAN/Ux1KtQYA3QKj5C13+CTKqSZb1dKtDbcypuMtbXfRmeODLREAYqj9dvbZkqtVu9oQ2iLHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNJaVFxeDcvbGtRemtMekdRcjJrOXlyTXNFUmNHU3BzaUdTZHFoR1NOWEs3?=
 =?utf-8?B?aGFjNGpWdFgrSmJiS25xU1hwUFVPZ04wTjFlWll1Mjh6aTNIOFFVc1FaQXRC?=
 =?utf-8?B?T3ZYNjczdkN2bVgzQTR4cGZZQ3BaVlU2YnN6bUM4QlQwWmkvMmFHVUdPc1Y1?=
 =?utf-8?B?N0V5b05UQlBvMC9oZGh3R2ZJTjBWTm9uM2Fib2JDeGVpU1JDWnNuLy9JK3Fa?=
 =?utf-8?B?QWFnSjBxZnlOdGtxaTY1YUcvcHE3YWxEdG5PSEpidFBiV0paMHdIOGRSdSsw?=
 =?utf-8?B?emJ1U2lWai9zdk9WaXRJQTFxSEU4YnlUQUx5ZXZGdzgzVi96QVRNbHIyK21z?=
 =?utf-8?B?Kyt6WXlzcFJaelJuaU5IZG9iV0owUHFsZVl0WnB3b2ZxcGJTcktpRzlkS0ox?=
 =?utf-8?B?T3N4NzhKRkdxK2JQKzlKbkV0WUZiMXdPNVRBczBabXQzRGdvUEE2MVN0R3Vh?=
 =?utf-8?B?MnQ1SVo4R0VMWG1kT0hIaEdEYkxwNDRuem0ydVU3dFlHWHo4WThmM1M4cGl2?=
 =?utf-8?B?T01DZGNERHNhTUhKYnk0TXRQVVhMLzZEenczMEk0VkRZK2VHa2FXMkN4QmRm?=
 =?utf-8?B?VXVlYUk2SnczVVltbStkWThNRlJJZFNEZkNKODdoOHAzNVVpQmRpb0lGQU5L?=
 =?utf-8?B?Y0VoU3FHTDNaN1Q3ZCtSWWJjcC9IMVZ1TklmQnVmRTk3c0oza0hxYUg1dElO?=
 =?utf-8?B?VkxHOGJPRjJROWFGNGREYWZOTTcvOG83bTA4bjd5OW1kTXhVVGYvR0M4ZFRB?=
 =?utf-8?B?ajBQTkVEQnAraVYzYzVEWnFCTFdIUndMdHpXOHBXc1RMdHhYdWNKTytCdFA4?=
 =?utf-8?B?a2orejVHWitvUHdqZkJpMjdxY2cxQjl1NGdENlVaODlJc2pJWVU4N0JpUmE5?=
 =?utf-8?B?a0NWNVB3cVhCcUozeHlmMU15QXlSSTN0NEtUai94dGxEbnlnSStsK1F0bWU2?=
 =?utf-8?B?M3h0RzRjb3JiQ3daUm1PLzJrOXI5cTFTc2tZZzJTdWdmRVl5eVdzK3NGVEs2?=
 =?utf-8?B?MSt1SDRVZEdPWDZTenh3alpraVJPQmNlVVBodFQwMW5RSmRINEZHbzlBMUlh?=
 =?utf-8?B?T05MTUxpVmdwei92SVNJR0hjMCtSV3Flb2xPeWJHVGhSYnR6TFZDQTRxdXBl?=
 =?utf-8?B?VjNBQnJoay9YWlRYRllnbkg4SjZCOS9aUys3ZGNDTTVIZk1SUlNhRlFrNHpJ?=
 =?utf-8?B?Q0pwQWpCWTIvWUdIcE81SHpTVVlyWTYrZzhDWTBtSkVOcEhTL0J2bUpncnBO?=
 =?utf-8?B?TVR1Um9ibllDSjF1Ry84NmR0Ri9pOFdBTmJXbEIxbnhrZEsxcHZrajM2bkdT?=
 =?utf-8?B?ZGFsNkpoaWtUeWFhM2toZkZDWGZ2RGg3cC9NbTBsSklabWV5TE1CSThmWmoy?=
 =?utf-8?B?L3ZEU3VnTHdIV0VlZGRVZFNtdWtiV2IybVNGalpoMU1qcllXUDNIaXNvS0sw?=
 =?utf-8?B?elZsaG55MVlPbGpReGhyR1JEMUhHazNwNUR1bjY4UFdKdXN3bDhwZ2orU1JW?=
 =?utf-8?B?b28rSkM4SlBXVkN2QzNpcTdYNjFQTDkyWkRYK1c4ZmpUMFhQRnJSaWIzcWRv?=
 =?utf-8?B?RG9LbStNNnBjNkZiZkxWNzNNVmYveFlVTlorUHdqVUFTYlJuUnlmYUZIRzVi?=
 =?utf-8?B?WUF1ZUJlaGxHeUhvQWtUQ3JqbDNRQXJCN3Q2TWtXMlFoMXFlV2w0bFhraFVl?=
 =?utf-8?B?WkVzV1ozZFFDQ1RkMjNkL3lhV1I1VGR0M2tYNHFicDh4SHVLMHRITGY3d2kz?=
 =?utf-8?B?QS9kVTdQMUJjNC82NGFsRENMM3BuMHNEcFRmNkFLeVlpNFY5cHRrN2ExM2gr?=
 =?utf-8?B?UlJPWWNRMERKTHM3cGkvYWJDQTN6cmg2RHg1b3o0YUNHc1RtOExycEZVL0pK?=
 =?utf-8?B?WHF5azNRc3VyQjMrVGVVZm0xc2t4dFJZaTN1bi8xZHNnbnpFaFQrTEk3ZHZF?=
 =?utf-8?B?V0xESmphcHd1RTQ2NzRXWWpHZitib3cyRXlITG1IelVGUVhyL1VTaGhwVWty?=
 =?utf-8?B?ZDBzUncySEpNeEcrZ3l3RTJiY0FEYzJzb2hHT2Y1cTV4a3duL29vNVQ5b2xj?=
 =?utf-8?B?OXR0WGRjYkZkSnJhZW8yTzZYdjBrNENEMHIvVllzVHVuZWpDZFErTTFZQlJP?=
 =?utf-8?B?NkZvS1BWeFVEbFhONGl3OFFuVERKVzErRXpxRm9LSE15aktPRDFrV2xpWlho?=
 =?utf-8?B?SmNwWGUyRTRmOXVNQW5GK2lRVWs0cGxaejROeGVYaEI5RnVNWm1mQjNwZjNp?=
 =?utf-8?B?Z3UrK0w0Y1dMM1g5QmFZSG4wR0FVaXoyU21rbTNKNnpHK0VOWXdUWStnaHV6?=
 =?utf-8?B?R1lMZXRDRnNsQkFVR1paZitRRWFQeHExYjRJV0o3ODNlQXJhamhvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b3205174-f1a4-4273-4ac4-08dee7df5aea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:52:42.6082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJphq42Tph20wo/QL9WgYPrF76oVhbojRn1whCg6ykFn4mBTBCBeaaxaklgXH25+Ou7Gx6slgOr88NHsYgambSnsf2e8UU1iTPaeh5UwYIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10513
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG7+CiIYAe9z3OgH+UN23MI8fDsqunJZGmyPftsSh3U=;
 b=WiDm3HhQ8OjE71P/PY89711s+xps1p9O02QErMp7IWD8lHOhzsd8bZA72rdAe9Ou/liDnt3BCsyTKsdmX2pMuKO1pn6GvxLU9rF8FsRHcM4RDjNzL9Aw5sGBKpUSo5Q6XAqtZa8OB3+FREkg8LsKPSh/ScaSvwNAi/ZU74gpw/U=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=WiDm3HhQ
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

+Cc SPI-NOR maintainer and reviewer

On 7/22/26 3:36 AM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.
> 
> This is a 128Mbit device using 64KiB sectors and supporting 4KiB
> erase, dual read and quad read, matching the other XM25QH128 variants.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - None.
> 
>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 31a2ba49a87c..90aa1025176c 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -673,6 +673,7 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },

