Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C121EC5CFEE
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 15:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5330D60A74;
	Wed, 12 Aug 2026 15:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gt-wNxM3V2_A; Wed, 12 Aug 2026 15:22:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 896B1606C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786548139;
	bh=qeBmyimj8yDkYQPsoyaTy5e1oHEXoG3uAmFWe0qqrLI=;
	h=Date:To:References:Subject:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTCDqtDd3FMGyqZXvaCP3JcXjhvUhyDywnAZnLmkB+OvRLl7U45hGVI2JdjK63W2V
	 lFddtf67abokCjP8RouEFTFZl0bUijgBN3ypGbHGuVHcTlG2tGDayh7g1OvryYBlIa
	 DaLfm0UHJcdk6wac0dk96iiZbv5ZI131wNs8GKzoVuqQwEEd4XjoYNwOe5j56pYn+o
	 M7/B+3MnefJlTYfa/9862bT8hUg8kz+SmpKCCeyyphPxjY8vFWTJeQtZO8k/WGG9zY
	 KkKw3zPTXNKoRubnSG0932+tWYskt/p8ERxtSmu2JCeasY7My3wQwyuFxk8L3qXGvc
	 FidMYrRp4w94A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 896B1606C6;
	Wed, 12 Aug 2026 15:22:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4637D1AF
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CC8B60674
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d7vr_mh-OZEB for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 15:22:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 51F976061E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51F976061E
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51F976061E
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKMk7S+RDmG8EmQhyfTPrZ+FbLALVUWQOhVOYj92cKhd7TyFJ7ruvvc+luJuDni92JIOYa67gxdXjN+xcxsvH+G8uoFRTI/c6FnPHsvOaOq9BNDanC6pcbdmLegUwLgD4JZMJd/M47m3nRNtCOb9MiNf65vqj/jsDnAvWxI4XqjK+CYKlu6wcGhh5tYjnz+WfDnqEYjv9Nizc4meX5s6GUc1caLuuP43nb7TUQJFCKMiM2rc6XtWpJVFFGDnXIW4j5P+ju8aGBa692QH9bQ5tPYCYYGa5oMYnR/829Irf+wngD3fScAGT5N1pMCUcChU7TMvuL3rAgyKfrmt7CARRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeBmyimj8yDkYQPsoyaTy5e1oHEXoG3uAmFWe0qqrLI=;
 b=l/gvUsVnkgtkNJS7nT9DuDO6ChRWc5t9eKQfEHiGsL5C9Ew0YV4jfZCbR2kgl28L6I37l/3T5hnjjf3PAHz1zgbJpCXnEVfWOHMvVq/NqSEqjnP14a4qepsg26SxvJa6t17lTmHKpsShn/dmMUZweHagcVXZMsE6Ma5UpoOxKk9274A2YC8iJWGixOXEQOyNVAxIDzJojeguje3Bs1b5YmLZh/KJtBJTCQOE8G/CyAZLla6hNZ9UHnmMwTReqF4w388gf0cWNG7dRKMQ8qwFwKCDtxPuFbcpri9AnneLR/LTNELYu4N0h7NbiTyg36VsajYRFxaxP2EI52PgF5E3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 15:22:11 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 15:22:11 +0000
Message-ID: <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
Date: Wed, 12 Aug 2026 17:22:10 +0200
User-Agent: Mozilla Thunderbird
To: u-boot@lists.u-boot-project.org, dmanlfc@gmail.com
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
Content-Language: en-US
Cc: Chris Morgan <macromorgan@hotmail.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::15) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 06751887-f768-4219-7ee4-08def8857b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|11063799006|5023799004|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: +M5TYPgdoCzInRwWw7oVldU9zwlIzB/9NbjcePiR+8SP6fxDtUO/u5rvMSUNj24DgG4wubGoBye1Iul0mos3ITe0VuZ1whfdCSZRksGO/5RBnbcHTopSbegoDHmY3vCyiAi03yKA3adX3aVaTfRS7SNilf67e7t6GPW74rurLtNkjAMQAzCaj5Tze6a5RiQd0JWHboQss1p0VXgOrap9/5Ub0lmfRxHLwdfUThjRdrOw1mSDFxaI8Dbyz+JoADafb6z+U9MaPDDymvnA4wSoxdxHlJgK3Ofxh2iyLppON69Y4fKVbE0xD2CBKR+VPTOqa7k2efP3nygz3B7JDOYnSJXgX2e1ZBtmkWOpFHRLaAOaf3Qx2+W8aGH2ZcxJ/ZSx1ZkrGnDbbidf13/fClkCFasvTZLhWRKyZ5WbBwgLJItn4cUdDFlWA2+FKAz3joAn4+wmww2yo/3+zSnDRDmN9FmgV1DtTJ4ruT2/OwNSZsTH5TQEFUzUX4j/g78mamxdaFkGxTwsndpycDClwfb67m4GR0e9GbIO4cEuToiDyS9KFvfMYcbWXz3Cv4GJgs0W0RIVf23nqgXTndxLbejybjPtS3puMWrxYunpKWJbZTyBmleAhpedK5KC9KP9SyBSPmw40nMVScfEf+IIIWIAAkV8jjHRNsp7e4Bdx40y8Yo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5FdnBETVF1WHRROEhGaDFEZ09abXpiTVpZa0RjNG4yd3prMUlPd1kxdEdQ?=
 =?utf-8?B?dkZkN3FvNkVSY0xMOU5veFhUUkxWT2FxKzB3MlhSS0J1WEFGTHFLaVNoMzVI?=
 =?utf-8?B?YmxNbUEwSVNOM0RGeDdER3hLcUlrQmJlZC9XTHVRS0I4SVcxYmF3QUY5M0s2?=
 =?utf-8?B?Z2E1WEFPOUdMcUtabGczUXBuV3MrQzVOT01xcUhEY1NkWjlrYTA1SmdEU0s4?=
 =?utf-8?B?SjV5L29wSTlUOTRwdGVGSXZLTzZXMFZCMktrRzhyV0FONkxCODd6TUxGTEIv?=
 =?utf-8?B?YzNORGJ0S0ZRcERXQi9wS1p2M0cxVnBsN3RpM21HY3ZKZTM0RTQ0OHlIbU0v?=
 =?utf-8?B?VEduTXBsSUdzQjZ0REh1RTFXbXJGNmFJNVp3cEhKL2N0ODVTMGRVbTl1Nkdm?=
 =?utf-8?B?N1FjUFZFeEhzZWtGbWI1UlYyZWMyeGxxSXlKZ3VMODFjZDlNUWhjUks2NVpZ?=
 =?utf-8?B?MkZ6b1piV3A0ZmMrSFVmY1VCSHV5ZHM5RFVBaXRJR3ZxV3BPZGdpSzBQUFU2?=
 =?utf-8?B?dlpNQ2J4eHZ0Y0lVZmQ1WTZEb0tGNVptMllEcTlSdkhadjdnK211dGFzbzdj?=
 =?utf-8?B?ZVZvR2RIUXBxeFp5TVcvYXk5ejJWbW44VTlYV0VkZWUwZytBb0RqSkNQaGVV?=
 =?utf-8?B?OE1ham1DengwaWRPdHZaL3o5NE8xTzZUMjBpdUx1T1c4NVhucnUyUEZuOXli?=
 =?utf-8?B?T2J3NnJkNmIrNFpyUE8wYnoySnJwR2ZkT1QyaHlLa211bFZEVUU0aTVaQ0tm?=
 =?utf-8?B?NExnSVBkVXI1ZUx1RFpZS3pjS3FwellKWnFnOW1vWGMwN010eFhmbW9rL2NJ?=
 =?utf-8?B?YTJLSjhudGVtMVlsSUl2MTJCdjU0UTdSUWYyckNqakl4a2VZTnNERFplS0hL?=
 =?utf-8?B?S2dKbnJoVEtvRkN5N0NWWlh5MEE4Z2VzbGFyNExMODl6VEhHVkRrL3I0dTZG?=
 =?utf-8?B?UmxoS3ozTmdqSW1HZXVlSkU2SlZCMlU1NmdkK1JxQTVTU3BsNXpWaUk4eTdl?=
 =?utf-8?B?emJlbktTRFJyL001NGpySnNGNDJiOGxUN1F1Z3lEZG44eFQ2WGF1dk9ZZTFP?=
 =?utf-8?B?Q2dWUGRRbmgvTzRuTG41OW5oWjFSdmVHTmVLeW81QmRrWHMvOExuQ242K3Nq?=
 =?utf-8?B?eCtYRHEwcWNwVERIeVdESzR4YmMvclBGZGE4ZEhPL0hLWVYxZWpnYnB2aVJo?=
 =?utf-8?B?K2o1RldYRVhKSWlvazhtMU9BRndsM0FERzgvWFNjRWZhUURRY1ZVQlRibzN2?=
 =?utf-8?B?MGk2YytWMkpNSldzNXIwRzVkYzNsYkRzdG9xQzhoOFpqbDJSaklSMkkxQUdX?=
 =?utf-8?B?TEEyMVRIZFJZbm5ZUk1aY1RGSHNkbjdjYUlFS2ZiVzExUEI4M1YvUXB6TVc5?=
 =?utf-8?B?T0hIamNNekZGUFlrVmNjeFNzUHN1ZW5nTEJEYURlOEc2czZUYU8yVEFFMmpR?=
 =?utf-8?B?ekxGM2o4WURzRlVEZzRNeEhBWDNDelZMKzhpNXdnL1FsQTdOK2hSN2VMQTBF?=
 =?utf-8?B?Z1pMRDhjYS9hVTFsYndJNWZpTm9OWDdLMUkxY3l1SFBhKzNaMHBlN3F3VVYv?=
 =?utf-8?B?bmJiV1BncVRhTGNhakhVQ3hoRTlvcWd0alUrR3VHbmdNT2cvNGJSUWYzdkoy?=
 =?utf-8?B?SGVnWU9Ld0dxekp1TC8yYXJ2QlFwZXZWQVV2V2w1SkVWOGk2Q2NTdW9BWlhu?=
 =?utf-8?B?KzBIOTN3b05sQVFsaGlKSTZ6aysrZnpzaDlWQjdRd3hmM3BscmwxdTJJM0tO?=
 =?utf-8?B?cnMxMHF1UDRoUVRLTlFWcWRob2FjVWNFcGNFQjZsQVhYNU9aek1jeFRZMEQx?=
 =?utf-8?B?K05ZVXk2ZEViNGlSb3Jaa2dwQUNZbFZGYlF6VXZiUGRiTkxRdGpFUlM3ZE1l?=
 =?utf-8?B?Vmh3VU1LaXpxcnpyaURWcGE4RlVTdTcyeXlDQStBYmtjT1lyOUhnSjVQY2xC?=
 =?utf-8?B?cHpyUzFDVGJUOTVpTlJtUVJQK1hoU293R2xTZ1QzdlNKWUVtNjlJakNHMWxE?=
 =?utf-8?B?Q0phaEN4NnNWd0lsa0swRWFqUXpXdnNGcXpMM1J0QmZoOStlNWtiQkMyWUlV?=
 =?utf-8?B?TXBRc1QwL0RBRzN4b1ZETUtwVnNrSGtFenk4QlErL2V1SU05ODQ1bHhxRCsr?=
 =?utf-8?B?VHFMa0VuZzV1WC9qV3htdVU0VzF5b2I1R2l5UU1laWpHN0UrWStxRXQyaDB6?=
 =?utf-8?B?NktqR2VaNEwzbk93STdGbzc5RmdNS2ZYelcwM2czdGRocjF6eW5uTVZwSkVr?=
 =?utf-8?B?SWpVa2gyYXBUZTF6L0h1T3ZadlRGVUlpRkVkY3BxZGdXejNYS1ZDeDFiMnJR?=
 =?utf-8?B?NFZJaGVDR3UwT2JyVFVmdENmdm9ZMmhNcjVKellrSkpNVm96d1FORGJVdVdo?=
 =?utf-8?Q?HqpA2XL055iB/DenimeNGOlqZ22sPuasr8a/OOa/ZBJCP?=
X-MS-Exchange-AntiSpam-MessageData-1: 9FEovIsQcy+ZRg==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 06751887-f768-4219-7ee4-08def8857b19
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:22:11.4552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59ZDgDZx+vq0vN5m+PlV6UrZqN5ERl0MDIKgC1rGX+ORVTuJA9HkvFaROUfhYMDggRFCyXt6tapxHyG/9wZoLoy+oTMXrNBNztpB+HJzYys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeBmyimj8yDkYQPsoyaTy5e1oHEXoG3uAmFWe0qqrLI=;
 b=RgT57zKEuP1Fv/LC2rLZit9Sn0XL5kB8KTGtQLE5ZsOCWBG3x557sxZ/O9CR9NA3wB1nmMNuG779BmZI2otTgiq9zUMQrU96eCZvfcQTP7zN0cMqRWrrto0SBJYC4yvBTr9BgeTw+kDpJxbkvNX+eb3qYPakU3R6/2owXUMFsfk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=RgT57zKE
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

+Cc Chris who maintains this board and may be able to help.

I somehow didn't receive this mail in my inbox, here's my attempt at 
quoting text from a mail I didn't receive (and it's also not available 
on lore.kernel.org...).

 > Hello,
 >
 > I am experiencing a total boot failure on the GameForce Ace handheld
 > console (Rockchip RK3588S) when trying to run mainline U-Boot
 > v2026.07.
 > The device fails to initialize or display any output during the
 > initial handshake.
 > Unfortunately, due to the tightly integrated form factor of this
 > handheld device, it is exceptionally difficult to break open the
 > casing and wire up a UART serial console to capture early boot logs.
 > The target operating system (Batocera Linux) environment is running
 > the mainline Linux 7.1.5 kernel.
 > Given the complete lack of visible console output, I wanted to check:
 >
 > 1. Has the GameForce Ace board target been actively tested with the
 > v2026.07 release?
 > 2. Are there any specific or updated build instructions, BL31/TPL/SPL
 > combinations, or proprietary Rockchip firmware binary requirements
 > (rkbin) needed for this release that may differ from previous
 > versions?
 >
 > For reference, the build configuration used was: gameforce-ace-> 
rk3588s_defconfig
 > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.21.bin /
 > rk3588_bl31_v1.54.elf
 > Compiler: GCC 14.3
 > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
 >
 > Any guidance on known regressions regarding this target, or
 > recommendations on how to isolate the stage where it hangs without a
 > hardware UART, would be greatly appreciated.
 >

If you have a known working version of U-Boot, maybe start a bisect with 
that commit as good and 2026.07 as bad to isolate a commit that broke 
the board.

Cheers,
Quentin
