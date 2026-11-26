Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16034606A32C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hosSWr13;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=AmJEi0Nh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F2FD60AA8;
	Thu, 26 Nov 2026 17:57:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PvxIKDiVciwm; Thu, 26 Nov 2026 17:57:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7995060A6E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795715874;
	b=gEm+M6zHZO4MYMcIyGblzhrOqldF5XlxilWSrow6sDO2sXoXITXp9NyORw9Rfqd8KIpH
	 iGSKokVRbHCT7dS0g4ApVk6RgQ81BbVjmh9QrtKQMMq1mlYZAOSQHyafsV21aRtafPdzM
	 a2sATtVwIJ2vokVxVO1fFfSieOHXb/W8pWcMH8mt7QGw3MX/bM04c1TCdH3Tw4oLyeeIj
	 9/gn+KiJImsWfbg9uIuF0abGtNmP/R/gvtYBBx/+em5wQIf6O5mZAK1eZCgJoxhCsgIho
	 KNoJyENsMkArccC9m4Y0Ng7s+I6HLlrujd1Nphz8Vsn9yL8KmmY0tzzO7uZzoVSbcGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795715874;
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
	bh=RAFZhwDc1YZgl4V0slo609CPHX/a6shDDT+euqWnX7g=;
	b=Bmm/wkv0rUDvvxPAvcPmT0yesA9PTaABTRcglgMZeASAQ0cMS7Y3+/NUZoobRI4V0Pg6
	 6sPmIPp2dE5q5/buvBoap3tmMQfpAoh2HvqMbCllvc+JUpE0j+N9DSxo1fhJWJ1Tk80NL
	 wb7aB3GTsXCmIzaj/1RMhE0FbHfcbo8HYO2vAScvdz65HMymjjc4XIg4JImEjC0+bBQWy
	 GZkRAiZarIGC2Um0fGqqCWUcXB5BCVGXo3uNRd84maFggyDti2j2NiF2RCK/lqpQ5cnkL
	 rAfbeJEbK8F0VswFWSVd407WfstS83FtNigUZtqcAa8axEPyECzn11bw2bA4GlZKXxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795715874;
	bh=RAFZhwDc1YZgl4V0slo609CPHX/a6shDDT+euqWnX7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hosSWr13AHPsTZn8mJndQLv9HiZpurh67sMdawMLVP+D9ZVQcgMPiCHVBKkyErJcW
	 6XdDC5VzhLZh55SGtepFOhlwtjQ765tCAGNFsrI6i9jXR43xf8nx7Eyx8OSJXXP2sN
	 sjfjywCF9v+RNAyedKV2h0jwMIQJYJe9xiWflQnbUe9v/j473AQcDc+QVcIRXeAZhT
	 qJsMU/43+U1TAT3ccSs2QHUD7z8vLny9frgrCj+PGKCggM60RaIuZZXczQUVnZIYd2
	 OeeDFHk8sC9UiFWiCS7+BSYn5RbzJkMwwKNohnTPJ8YtshNIFtqjJr4Tx4K4FL71ak
	 e/oRIqT05FLpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7995060A6E;
	Thu, 26 Nov 2026 17:57:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5979D22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F49640971
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJgHTpzD2sVR for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 17:57:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B47BB40929
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=AmJEi0Nh
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B47BB40929
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAFZhwDc1YZgl4V0slo609CPHX/a6shDDT+euqWnX7g=;
 b=AmJEi0NhEQ99He6MyIlfqnyyfHK5mZbhuSPydGHzTegnh7mIAfpafQQa9S1BlAYmU9ixISSiAISXl/ed4+jyhSL2sDnFHe9+o84hbYtuV70s2l4I/Un0AdFKUGGVVs3AljSFbOstlEM9p5oOURr39DjZqjqyYeK7zOsiD2yAzDc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB11474.eurprd04.prod.outlook.com (2603:10a6:10:5de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 17:57:44 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 17:57:44 +0000
Message-ID: <fc6bc1c3-bf73-404b-9985-9d777cfcc222@cherry.de>
Date: Thu, 26 Nov 2026 18:57:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ata: ahci: return the last LBA from emulated READ
 CAPACITY
To: ricardo@pardini.net, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <ehristev@kernel.org>, Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Julius Lehmann <lehmanju@devpi.de>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
 <20261109-rk3588-sata-fixes-v2027-01-v1-2-e54ca8e68f18@pardini.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261109-rk3588-sata-fixes-v2027-01-v1-2-e54ca8e68f18@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0059.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB11474:EE_
X-MS-Office365-Filtering-Correlation-Id: 642e4696-6838-4509-427d-08df4be6c59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|261102123227099003|261021121427099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: tRhifpBzxbrKnEKfyDHrQ/VdNSKoNeO1bVpbH9LM1QZNkpKHZzn3Bdyf2jHz7rt8zgcnkST3o+XxdZXOIuVadCyux9W4m/XI6F25fQq33ZybWmCSdjqP19cySuceyDzjNZTAz52sjF4W+B070ZmHhkSB0MW/EBvbeJK+q2WB9tDveNRkvE/tTwowfRiiXzfbHCrJVCGBaiZpuM2Z1wif55DW/lPwhXaZ8hBrEavWvAoGLn3kWJfSoYlY8k1TWXcEO97VS2/rAq2njwCYfz1R+FKEQb0oA9V+Apceq+Sz0IYjXcjOnUpdzEqJqEVnlCejtnKQMTquh5MLInHDiuf4dZmIqtUYL33fSMHCuHTagNJK8JTmkIwusoaq9QcqLyfFznL96qT9sT739EJcoPzVsyWbYNPLKWNiTG96QMgy86S7jci4LCGY+quglINnd9u4Yj/BN/2w7IkA+dNj0In7YtWwlCSzbd/1qTYikoFc0yo6RRD1AOBDO6sY9Xs2p1wOdH+7fwx0imNVyFjQggR61QfwGvn0V4+e4g+HNIymhFeJQH4PI3j2EsZbFIcJMpQGN9fJS8d4sBHyz6u1ojerCKZ4tUZnXEpMpip1mzPXqpCmBmnIZ3/UlrW4tnvC/2/8SFOFoSbppixYb2hPf3ni4PL79KYAd5y8GIR+ZbLk+c0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(261102123227099003)(261021121427099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0UwTWVZTVFzYmlqbTIvR1RKY3BIa05wcWtSb29lRDllNmQ2TDBUcmxWQjVw?=
 =?utf-8?B?UVdkM2ptWWEzeHdVUGhmMUM3RnhlSFRJb1grazdzMEV4U0RLNk1Qdm4xRGRX?=
 =?utf-8?B?L1p6VGhSNU1CMGg4Mi9tcXRpSkQrSmluMlZGbmFFUXppZEdpdVpLYXRKUkhj?=
 =?utf-8?B?aGJwOUorUnlEWjYrdFk3YmlRVWd4QU9JZm11OTgxY3RlbHUyNjhlTWFVSmIv?=
 =?utf-8?B?R2l1bzdlcjg5U3E1Y0NzeU9MVzdUWG9sdlJ5SkovaTVPazRtakFpN1gxVGM5?=
 =?utf-8?B?czZZbG52cHJobzJEcjkwU3RPcWhXT1VPRTlkejYxTTJNZmowRDN0ekFsT21l?=
 =?utf-8?B?c2dpUVo5STBJV3d1ZE42cFoydGx4NzJ1aTE2cUpNT1RqdGZHQlQ2eUZZck11?=
 =?utf-8?B?dXEwWTA0Tlp4ZmVZYWR0NnRxUVhWWklCdUlCUVpublhvUWVPa1g2WGI2bVo3?=
 =?utf-8?B?bUZ1SkN4aE13TXNSMXE0WktyZVpWeXkyTUpLY21yYU1OVG9FNHN3WjNadUN5?=
 =?utf-8?B?UTdpT2RyMFJMTEtNSmVCN2E2anVYdWRoS2VlalBnRkIyWVZvcWpjMmhpak9n?=
 =?utf-8?B?WkdpS1N4SmhBdnFySEFhWUlaMzV3NmdmKytRNkN2V3JsaVcxTlY4cjVCbjhH?=
 =?utf-8?B?TWZqeDdnMzYxTTNKanlRbjlzQ0VyT1k5bGdwdWMrbVVqbEoxbGhVMVBTVzBV?=
 =?utf-8?B?RTlwamZXdHZjVlR4OTZ0OUtueUtBYzYxei8yM0hLd3h2azlDWTJtc3kxc0E2?=
 =?utf-8?B?amNvOGZQRkdoYkJyZTZZU0RsVkl2RlhGYnl0cDZmaGdxZVR1amRhckg2WFZW?=
 =?utf-8?B?eFpiNEpGV1RsL0s4U1FLc0VoSk9ZR3ZzaHlWc0RmYlBwVDZxeUQvNXJIRkpR?=
 =?utf-8?B?Y3JwbUdxQnlzVThOZ0t5NWZ2OUQzNlJLTGNuYzlxdGdNenVUN3Q2NUxyRmtj?=
 =?utf-8?B?TnJBcG1yUFJhV2dGcWNJSnZrRGJIdkJIUnZmNldna1JNRVBjSHgvVUlNY2Jw?=
 =?utf-8?B?eFpmeEdUUWNLc3hNYWtuRk53UnlXamt3bElQSmpOYVdCQVJRL2RIMHJ4QWVU?=
 =?utf-8?B?Sm9QTEJHeGovTnZZRmxFcnkwdm00cksxUllUUUhhNEdoTFF1bjJaaXdFOHpV?=
 =?utf-8?B?SGVLTW9BSmZkRHhNWnhLclVZVThPakZSSi93b2l2M3FUYU5PMkQwczJUTkY5?=
 =?utf-8?B?TlhWUGZYTVRZSytZdStaTjR5MFltUDJFTGd3Rk9ZNUVId1dIYkhvYWxldW1j?=
 =?utf-8?B?OEc1aGVDaVpTcDZvREZxTkxQcG1iVlp3NjJuT2JHQS9zU3VXaldBejRsNDQ5?=
 =?utf-8?B?eFBsSU5JQkpEWHBVMDdKSTVIVENFRjFOQTJmVVJuamlaTDdMdUF2OU1sSitx?=
 =?utf-8?B?a0k5ZzBsY0dnQm5hYWlPZDNIcks3WEZXY0d0WEVZVzRzYjExamZocmxWQVk1?=
 =?utf-8?B?bjU3YmNWWi9wcGJ1bW5vMzFkNW9LS3N3Ym1tdE1zamFGSGZSMHpUaFZtd2tu?=
 =?utf-8?B?Wmx4eGlvbGYvL2tzMFk0ODViOEVLekxCS1BrYXkrMTNMM2xmK2UvT3hZeDNu?=
 =?utf-8?B?YmJBNWRYeTZDTWllYlhoZytyc1pDRjhONlc1eVhERDNxU0NneDViUVJUaFdG?=
 =?utf-8?B?dFJrVFhnTmhzRDJsTTdWaTBzTHpZOU5UbkZZam0rUmFHNVNCUGlWUlpxYlVm?=
 =?utf-8?B?YWhWcTdPd1ZYN1Vhbm1jSGtlcWhYd3hlaTNOdWc4L0NiOFZ0Rk5tbHdXKzN0?=
 =?utf-8?B?ZkhFbW94SEVtaFcydUduU2JtTmFkTzA1anhjc0ZPOVlhSGlhQm9vNjZKMXF6?=
 =?utf-8?B?YUkydDRiQnpNNXk0Q2s1aDY4Y3RGbTJvUDRueTBDOUR1QnlRcmtScFJkeE52?=
 =?utf-8?B?TW4vOTVzZUlpSTVPc3NPMVBlWDMxNGtUdTEvaVBySThEMnd5TTNuSHJnOURi?=
 =?utf-8?B?QTllV3U1WUVtbGVDbkovUUZlODlVclFwaWQvN3RXTDFnQzRycTZiRWdTSEpi?=
 =?utf-8?B?SjFuRm5PTkhINmVCem5uOGYzOWY2QzI2OGUzdWgyTEc0R2ZSNFpHcFFjVmVS?=
 =?utf-8?B?akMxQ2VJRmJNQ2wwemNheEJRRHpTRERvZFNmTGxVSTJINk5ZMHEyNmppR3lq?=
 =?utf-8?B?dFcyQ09kODVtcHBHK1krdEdKOVc2emlmU1ptK1RMaDNXeDR1Sm9vN09oNlpn?=
 =?utf-8?B?Zi9MVkN2bURrUG5iWG02ZjdpbFE3WXppanVRVTd1ZWxTeXpaL2s1UzJlaGhV?=
 =?utf-8?B?ZWZDc09JZFpqQ2ZFV0FUR0VxOE1TUVRoWXBQc1RaWUczbDZacGc3YWdrNmZ2?=
 =?utf-8?B?N1pCSGhaSm1lTVA3TFl6eHRTMUlMNzlId05LWXNvbTJRRWNOSXlJZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 642e4696-6838-4509-427d-08df4be6c59e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 17:57:44.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3tXOi18RpPa6rkqhcQcYMeYMYu+t2rq+phDGAmnRdwUNaJHDtY1NBw5AdM8SdwqvSzVsVKoPZ9g0vSU044ISWE23d9PYoW3VK3UWjadu0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11474
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ricardo,

On 11/9/26 3:57 AM, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
> 
> SCSI READ CAPACITY returns the address of the last block, and since
> commit 5f7c06bdc3c6 ("scsi: fix disk capacity too small by one sector")
> scsi_read_capacity() adds one to get the block count. The AHCI emulation
> returns the sector count instead, so AHCI disks are now reported one
> sector too large.
> 
> Reading that non-existent sector ends in a 10 s AHCI timeout. With
> "ums 0 scsi 0" this happens as soon as the host looks for the backup
> GPT, and UMS exits.
> 
> Return n_sectors - 1 from both handlers, keeping the READ CAPACITY (10)
> clamp.
> 
> Fixes: 5f7c06bdc3c6 ("scsi: fix disk capacity too small by one sector")
> Cc: Julius Lehmann <lehmanju@devpi.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
