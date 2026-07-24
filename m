Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D6C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 18:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44C1C60B9C;
	Fri, 24 Jul 2026 18:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNbv0m-BH1hV; Fri, 24 Jul 2026 18:08:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC4C260B99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784916527;
	bh=1rHSz6/EADzl5jeXqyugvXg97JQDF8h8IlH5BjglRWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZU770uTce1BU/gu5PQSohuqSZoS93EEh2dQ0fKg0cFbNN+zsBR1GDXW490R7fp9y5
	 LQ1VylJZRdIM5HyHpcDiGqo/zrUGfiPOvcyu/YWF6vlky11tSADAoAigJfmi0tTO9H
	 A3jy87/wVpaoY33lGmcKcVBgcCmiZ+Ex9FdtSkJGaMRiP5ZeCJ/sEnd8JDFMg2PaIB
	 cNbt7wjrBEAMB0U6S0UYUcsYC3AvUVuyEg8kgWvX5cCE4NH036jqIORaX2Lcv4IjGv
	 7/WAI57Plac6HZKHYBE8WXvFeoe9G4FFynoFUS7B5OdvMZbsRHSrLHp8r3IkTj2AEI
	 A3OEV3Jz/Xafw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC4C260B99;
	Fri, 24 Jul 2026 18:08:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF6293B1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 18:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0B2A400AF
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 18:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiOb3VGsTsYQ for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 18:08:43 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 65A1A40083
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65A1A40083
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65A1A40083
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 18:08:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A1C846A4; Fri, 24 Jul 2026 20:08:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D151800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 20:08:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmDXbpqGUhGax03X++0m+iIOqjXm1OBdK+Efpewl+bui88u74eOUa0kt8Tykp/M0CXJLVmlLSew3OBMwK13kdRY+YD/7ZtX3kVh4FZ5dX1DxRc2dZGvKWgwAwgNFuPaykSaADB6XgYAFsZvkHMxs5FqcmsalQ9XYuvAlZV8rbSmfNTf0ZNQY0XUQ/e2CW5n455vx+d6caxrUU19aJQAy46GJbz3kU0njTBZGEwJ47OlFZFv4ZKi8ZyenaKt9KgC2YpWTfI/r7K3VXDfxdJU5KZo4xR22eRz9vnBp4kFIxRi8gNMsZ4Ti8crR6pYn2X+TaDweItRQEfdseZUD4ATTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rHSz6/EADzl5jeXqyugvXg97JQDF8h8IlH5BjglRWQ=;
 b=g8LEF04WFvy1iRawGXWWA886MB3gxejE+Sv2brKeePELr2T38W1WwZ4Qh+MmNkVrpMHGxvnk500HXTngOlfXng9xZkGcleH8CScsCzO9+k1j9l3vcyniVvP4w9LK6YIsyDElwOSlcohArGyCSXTpVCIrnSxEychuUZcTjfuwQhPbobg9hfa+AED4ElQQeJoZQk1neNsBe8zVxrmqbFpDI6dMK7aRAj3KLLuKMN0fWepE+8MRuwaW0JhjO/RuEMQTM0e9JO1XqvF855ySrFwMJCa6u1Z185JxGyDG2nF8x3XyoNEF+TUkDUXQuCvJPbUjGwekQcz9hNRgYEOm15UWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 18:08:35 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 18:08:35 +0000
Message-ID: <f634dce5-0d15-431d-a4f7-68b2252332c4@cherry.de>
Date: Fri, 24 Jul 2026 20:08:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: rockchuip: rk3568: remove HS400 from device tree
To: Peter Taylor <me@et1.uk>, u-boot@lists.denx.de,
 Tianling Shen <cnsztl@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
References: <9f135129-b2e2-4030-8a72-8c5facf71f27@et1.uk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9f135129-b2e2-4030-8a72-8c5facf71f27@et1.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0119.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM0PR04MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 946cc9c9-9733-4653-24d8-08dee9ae9459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info: gbRms3qJGsrdw1H/Kp4Upvv5YKYIHUndLFxv0X2n1slVRhaLDv6mOS2EV7G7c60UG62GQRtQMUuFuqojlH4b4t8BHuHSjvAA5g48Ntt2ahP8pxPagTLvBBRJEKjjxKbROPhUYh9fIh0uw/sNotPSH4cZfiSLAnk/BTMX3YRzc3AE8lOctqxq2efNuf+qX6Ajn0f/e8b8T2I2NX9/Sg5bUUo/+dYE7WlfRLHBthTgmydJ+gWGnDVpWQESuLlWbbea3PTGONF7wuS8p8wdYurgHtNXIc+/CVoHuMBS4/WdY2E9+5G1XFpkLba1EzTD8xbNI8V3lgqJLJdkHa1IMfxEBV+KYHz5zeGt7GTXyrVdzikGG6gRzEixASV1IvM8gqhV6kRHdbibE11P6pKunGI2Yb8xw3jwIXpEmHbK3U3LgAXDZEiWSlz0+yv4BT7m/u/qU8l+dEl5WADer+W7FvTUVBJ+yIUZEcmGPKRFR28ICjUd8gAPAnL0ApSGVKVxRLOKakP4gF8Cr2qCYGVEnqkMgJbeZoo748pYadFW39DUjQfd1iQPp/YU2/UHZ+6FNApHClk4dbIhNY0tkPQvxxGc46CFqqIX5G8im6YLgd0qyeMqI5ek+GvFFjqD9Vok8LiR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejI0ZU5LL3NyTHhKQWplcHZjQzRqeTVjb0xSeVV4NzN6RkNrZEw2YjRrSlN6?=
 =?utf-8?B?cXd2RjNCVHJFZzUwbkRGbERlWEJ2ODYxMzBKVlVBODR4d1J3aWt6WXZTbytn?=
 =?utf-8?B?NndMOE9QMWZRMmM0UWRKd0gxbUYxaG1lNEliUFFzS04vUUZic1IyakFmSGF1?=
 =?utf-8?B?Nlord2Q5dUF5L3FyZERGT2ZqQnpVOG1CZFlkVnlLZE9wY3VIUit6Q3hOZDdQ?=
 =?utf-8?B?UmlmMFpNRG5udDVubWNISVFaR0J2NnBRM09MT21ad1FlOUIzbkFHTmcvQmlH?=
 =?utf-8?B?TFhUTXIvcitGNUpTSVBlWk5GSXYweUV6eS83a2pSMGFTaEdtd21pZ1JLSERY?=
 =?utf-8?B?WG81N2Rtb2JiK051d004eVVqZEdxRCtLOGlMZkJIS0xFNElaYUFKT2M2MmNX?=
 =?utf-8?B?QnlxUTdDZEFhbWtiWVdWRHk2akNlSVB0SXkwMkNqS08wMEJENmFVbG1zTDMr?=
 =?utf-8?B?aFhwSEJtVW4wR295bkNLQWZyYmNhN3Y0c25hV3BFRnE5RGllWnlGK1ZsUWN6?=
 =?utf-8?B?RHgwbGZlUEJoQnZ6QTFFempNVUlsSFhLZm85Um9EZ3A4UVpocHRFUTZacFhP?=
 =?utf-8?B?ZThQMzlEY0QxSU95V0tWdVEwTEFqNmtRNjM3dWJ2MzFqUFB0aW0vTlVOQ3Av?=
 =?utf-8?B?S1dUdmlJVmxKZ2hkclRmUU9WcXVzK1o5WTJabW5BbGFjR2J0a2E0bjFwRGhU?=
 =?utf-8?B?ZEFUZUJEeHhLNWhkcnVSbDdia083UWxlaW0rb05EQlBaT0dJVlRET0pkcXZK?=
 =?utf-8?B?M0l3cXcxQk56VEZYU3pDcEJNZ1VjdTN2cUs5Skg1UkJ1SzV1SmVYMFhNVmt1?=
 =?utf-8?B?eUVSZGZ5QXdwb2N4Zk1OYjY0WC9ITDFESUlqdFhvSk1tOWRlSVQ5STRTRHc1?=
 =?utf-8?B?V0U1cXZDR080eklyWDMxWUViN2p2OG9iRzk2N0E1a0RYSUQwMnh6Sm1lbzc4?=
 =?utf-8?B?RFdEOEpScjU2YkI4QnAwYnlzbVFjc3dUTDNtSnduT1VDbm9uaVVJYkpKcDFj?=
 =?utf-8?B?UUMvOGR1OVByaDAvdXp1YjBZQ1l1ZE5hTTdySVd1a1JWcmlHMzRHWW9mUTZs?=
 =?utf-8?B?WTVOb21zY1E5TjdPakdwU05hTk90c2F2VmhFNzlEMU54T1c3ckg5VDN3eUIz?=
 =?utf-8?B?djFuRlB6ZkpGVTROaHBDaGxWb3dFcW04aEd2UzUvei8vQ01rR3Jhb29MVDho?=
 =?utf-8?B?ZnlpNXRnK0NjR21uYWZGeHl0WkVvaTJZY3hPczFUalZVMDR0Qi94ellMSFlx?=
 =?utf-8?B?WU01UDRaN20xdFNJaUFRdDdhVzhlK04wRm90WFpCSmptSmdyN1J3VFJnb1NE?=
 =?utf-8?B?VC82cWdEcnRXWVNwbkhhZmtuNVpuSVcyc01aaDhoLzBqb2diTzhIdkpJZUdI?=
 =?utf-8?B?ejY3U1lPVDJmNlVWWlppVlJzTS82dFZrZldBZjAzTnJRdmpURkI2TFVmRW5t?=
 =?utf-8?B?VXBzai92d0ZEVDhVZEJDRE41cWQrNjZhc2JmMnhhODM0YmEzejhsQUFKR1BJ?=
 =?utf-8?B?dDBoa2FGL1FQbnZNeDRURGgxYjFDaWJFZFFrS3RKaUNTOWNITGZFa3A1Mk1T?=
 =?utf-8?B?dUUzQ0R6N2RwMkQ3SUZLMVFCQlBkeWRuMENGdHhZSGsvclZnajZwUCtKcU9H?=
 =?utf-8?B?TEpucEtrSmhRNGx3YjcyaE5TelVQaHppWEdTMiszY3dVSktKZ3I3K0dYNnVT?=
 =?utf-8?B?NHd5cThOWDFtcXNWeldFbkdJb3pqNXBqbzFYWXVWY3hDc3huTzF2VzhjSnpj?=
 =?utf-8?B?SU9pMHlaVTRqTFhYUFM2Sng3WXJvWGwyVjlmYThieEQvdzZudXB5dXZjd1gy?=
 =?utf-8?B?d3M1aExkbHBMVVJXa2kySHNYaXRiSzQzK1d3bU8vbGVwN25OallPQ2xFcS96?=
 =?utf-8?B?bGxmaksvTG1COU5TL0kzVlR6KzkrUm9qQzlseUNOR3RIUG8wZ2FnajZodGJO?=
 =?utf-8?B?ZmtXbjhVN0ljclFtUHNHaXo0NWdWRU1MUTFUb2RURGJnckFhYVdhNFdkNzgw?=
 =?utf-8?B?Q3c5VFhuR3JZMGVYM2ZzWW9UeWhxaGpnbUl6SlNIZ2RoVGl1QitVQ0ZnUllS?=
 =?utf-8?B?cm5WcEJaR09FTXpYSFZrazNhUFdSOEtrbGNBVmJmNEtBR0FkM2pqNERrcElz?=
 =?utf-8?B?RTVYK1BLTXR2TTNJbW14Y2w0RGU5d09GMUQ5OEU4RExxVEI2bkdYYk5Xa3cr?=
 =?utf-8?B?SEQ5RExnb0NGWFNQU21RcVVsWEFlWmI1eU9QRTdiV1dVRHFmN3lFWXN0a203?=
 =?utf-8?B?b29GZmlGd0loYVRIcXNpOXFVazNOdG0rS0tKRTY5OE1zOXZEbjY2d243Z2hv?=
 =?utf-8?B?WUFJSUljQTNjcDhjcWxFcm50dE5vNUtEQzVYRHNnQVNVRDdITXUxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 946cc9c9-9733-4653-24d8-08dee9ae9459
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 18:08:35.6803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6SxJ7tvdLRyBSqyg8uHeiUb17cCKpb11eL8oUy/PtYBpTgZwhUZUey61dZcPh0Qgzi0t1CPJ3VbzjCbAQCyFS60NRxLuHxjey3rL1VkXOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rHSz6/EADzl5jeXqyugvXg97JQDF8h8IlH5BjglRWQ=;
 b=fpgzneR/LTgMis4tp2bbG9gP4H/prsiycZMSgrQqWgJn3aBHR9kQIQG6kQxlvR+J/9KgwRlm/5oX634pkSl/MG1fYY+7YLcKSoC2du2E5JIsv5bENF9eFhVDw64Rhm5OCse5VsQXKsDk/OUa8SCK2q473owDdVA1KwDNXTXp/78=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=fpgzneR/
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="fpgzneR/"; 
 dkim-atps=neutral
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

Hi Peter,

On 7/24/26 7:09 PM, Peter Taylor wrote:
> [You don't often get email from me@et1.uk. Learn why this is important 
> at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fixes bug when trying to change MMC partition table on linux.
> 
>  From the linux-mmc mailing list [1]:
> 
> On 22/07/2026 03:54, Shawn Lin wrote:
>> The RK3566/RK3568 SoCs only claim to support HS200.
> 
> Removing the unsupported HS400 lines from the dts fixes the
> issue inside linux.
> 
> [1]:
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Flore.kernel.org%2Flinux-mmc%2Fb01a6658-e575-42e6-9520- 
> e8bb55d0329e%40rock- 
> chips.com%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C93fac56f7f5d473701ce08dee9ae0fc9%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639205131301445509%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C60000%7C%7C%7C&sdata=3CtLjHYHiAJ4%2Bz0hDQd9ppih5Dme6sENTfMwlYwDtw4%3D&reserved=0
> 

A similar patch is on its way to the main branch already, see 
https://lists.u-boot-project.org/pipermail/u-boot/2026-July/626105.html 
and 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/f079d8059da9eae96c1a4738e2f42c2679d9e09f

Cheers,
Quentin
