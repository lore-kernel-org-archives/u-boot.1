Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39F6C4452D
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 17:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 463F880D3C;
	Mon, 20 Jul 2026 17:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTSNxK4ebo-E; Mon, 20 Jul 2026 17:54:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A83A880D3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570044;
	bh=siKvv7909N2AeIoWLy4Kwxqksy2rps0UbEBF2NQv5N8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=OvoIMCr52wHzu+8R4cC/k7oCawGKwA4o6dg4ahP7YB3KCoNjVS+ykzGofLGNP8n+m
	 +1xkOrZCembnfamZwjCszkbSpc1z81pQk5kclrk0VwfdzLJSu6jAs+2ugc0bA5RrZm
	 BzAMmB/RJu1ogg/gYq9jWPAkUQcS84WrGINf556uLb97W9Clbuvg9hobBv2I/379ic
	 1NS5dzkDh6KC9hBSbSXt9a00Fm2FgLqlhC6aNGrov8BeVovsv/0ibc2r/zK/7IB31j
	 Cwe0W5Q0/nYKSglpMXoGBQh2VAn/6k0XNMfDrRn2hmrUAN14snCgKJTaXiP/Ezf0uO
	 f+NbcsFvzdO2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A83A880D3D;
	Mon, 20 Jul 2026 17:54:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CA14313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 17:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2B204060B
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 17:54:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkhvHuDMB46K for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 17:54:02 +0000 (UTC)
X-Greylist: delayed 512 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 17:54:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DE4F640620
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE4F640620
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE4F640620
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 17:54:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1916984659; Mon, 20 Jul 2026 19:45:25 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8BBF80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 19:45:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fgdo1AjUGQ1cRNK4lxJLSRZUsZaJBUIQEuBaEdvDPU9SUvwNjsyp0xzTQOGIvA93KBWRwud33o9XnVG763K+ye/YjtgLRB80z5gNqcDQAvdR2TQ8LEAq2FlfG8gpauBvfXfVLKTD9dHAQ2FWoZxpNKMUtJkhWnSGJo7hrGHG4NcMI0gij1fdWk6B5lwwu+j6q9KHWxNB7nw+q/sFuW32ABIZHtJ+kacwRFZ0ufIzkIhS3zoyHzZHDfTq90vqh4V9ChGLsHzjUUiU/olEKBznWAwyAEt+CuEEs72mnw6FDpUxMnlHJELAPxPvA6kM438kMLqYmMeJAgDsRolIYBHDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siKvv7909N2AeIoWLy4Kwxqksy2rps0UbEBF2NQv5N8=;
 b=W4yfU1JUfm24ReE27Ke0TUiu/LgAq63wuOySjYJ6qAFMow+XdzlK3iFC6ReO/BNsr1KgCtaC8OIyMZGjW7m5Gm8eDrPa2nBumBX64kVLtqgIngkhi2B7Zl/IMRtcHUboshLzom8zE09yPpFeRcual+VrMtuV3Oj1ZDxEaUW1N90ry22uFlUUzd2Azp/SgjOmIDQc1GHbWDKF12CQNgiJHH9IGN5BrnAE2mp/nsgZgMJIjSHFml6WNqbNwTc7PszR0Y7+12No8IpAUwuiJwsMLM97ouflgSQLpxElAVXYUZfM4ICJu7PCKDYwpfIcVDTnrqPpZN6+qU+Kr8fKn3vc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7955.eurprd04.prod.outlook.com (2603:10a6:20b:249::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Mon, 20 Jul
 2026 17:45:20 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 17:45:20 +0000
Message-ID: <366af775-b30a-4b24-bfc2-4b08459862ce@cherry.de>
Date: Mon, 20 Jul 2026 19:45:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: only build GPT capsule update helpers with
 PARTITION_TYPE_GUID
To: Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makrotopia.org>
Content-Language: en-US
In-Reply-To: <af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0266.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::39) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: b83ba187-a69a-4ebc-ed66-08dee686aaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mox4DPb0M/zwuPrkT3M9ht6SBWmL8bjznEj4hgxUSjGPq7HxFarBFXlRHM+jsEYGJMIyJJLb0vx2b1zjESkp/M+inic2a0oVjXRTOa5J0JGieOgusA6HuKNCgX0xY18H75Bzhvt3gpekl8k1iQsol40PBOPV6f6BFTWL2TJ/i26jcnY3mDb9kYj+AnnkOQJ3mGg6opppz/rUmeRyUP9lkYeXNGomuQd+Cu3jYGxX0HKgv8HkOWKP+AUXSrmfzcNvuzTVMTDa0jAzRLVf8DYbmLOrDsXpAbkUaN7j1ReP+xaCJ0kGXYlZylOwvTA5j5Pb+zr/cM/ZpUn3KN9p8kO33nWSh7Aa4wwzVNeOsqwhkmHoTvuoWvpbHIrVa/qgnK1i1QeBAp4/nZUNEZyK6JUFrlVjiN/IRec+7ZgcQkZnji3jgRuPt9ELRzsSNwlA/8HXNxmbN7g6byR02BkljAuefHQ+3DRzHojrvfIpxbraMavEGDaMRp2US2LuG4yEGr07W7qGzEyua+1d+/77qXJpBp9jiL++etSTGlmqx//mRXbJl3c+H9v1qttagaCecWWgTjUqkgc6V3M1kub79ZZ9k4LAoMJdR9wpV/go2GVqRW6CJp8P8nblu4I7mRepLP4X9OONtgDQTlLw7Q9VRC2d0og4YxJdA516UrQ1VuDPQZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitXOFQrQkUvWW5EMURKZmhsM0JiVEx5VExBRVB2MjNCTU10RVEyaUd0dUtp?=
 =?utf-8?B?U3VMMXJEblJTUkdGUjEvdE8yRjd0Znk0aFh0dUs5L3d3L0pWSE94c09Qd2xv?=
 =?utf-8?B?MUlmY2xaYS8zWmZTNU1DTjJEYXV2WCtwYXIwWnFhelNpc1NHR2pPTE5HaW5u?=
 =?utf-8?B?R2hUVEJEWW0zc2pyb1Z0dDBpMjhkZDFTQnFWZjg4V0pWNTJxUVJXek10RXFL?=
 =?utf-8?B?d2JPQUNVbWNvUDBWWXU0WUFDMGg3STdsMFFEUDRGMG91U2RpL0xWUmdodUVF?=
 =?utf-8?B?ZEhYajVjZjhTMTFsTDdwS0Q0cDdqd0dud1czZkh0dWVjaWFzNFR6U3RaNk9C?=
 =?utf-8?B?b29LN3AwQ3VyaXRDK0lYRi9PaDdCZEJNclVQSzhyZGtRc3U2Y2JxZXNGcC9q?=
 =?utf-8?B?Vm1Sek9PeXgrQVZSWmJ3RHVHTmwyVzl4RHdVZTVjcGwwTUJzdkRQSFN6N2Q4?=
 =?utf-8?B?WlBvYVVYS3p5OTdvSW1WS1BUcTl0M0xZV3drbTczRWMrMmppcklHNVlmSmxi?=
 =?utf-8?B?bTdHNWVzTGpOSFA1eXh1WXFCWGsxT2pLWEpBK3BxZjliVUo5bEEzeWNOUXNa?=
 =?utf-8?B?NEtkNzRIWjdmT1JOR3EwYm1OMHdXR0haSDFkWGlYT1kwZDRpYkNySi9aeGV3?=
 =?utf-8?B?UWpsRDMyTWRPdDR1eW1RQTFOcVNPN3RDc0Z4WHJxTjl5TnRpMlptVnhOY0V6?=
 =?utf-8?B?N0s5NEtpTVNidERqNzNCSlFPVUEzaXlHY3JXWkR0NW41MXZEZkxFRlphSWFs?=
 =?utf-8?B?Z2Zjc2x1cWQ1SFhienVkeCswZ3lGMGRSZ0lOMGJxN2xBL3E5MWVjeXo4RnRY?=
 =?utf-8?B?QlI1em1uOFd1WllUcUZiUGZ2ZVNRSFlOY3h4YWJDUlYvWWhLMjdEZHhIS1FG?=
 =?utf-8?B?c0J6bU1nWlB5RkZVQ3hQK3pHTkZybEtVaExuNWJwZDQ0bmVKbjZ2ajBvYVRZ?=
 =?utf-8?B?YjlRc2ZVWFM5aHZzbWVrN2FiTHJ0bXFySUhPc0Vsb1kxc21BcW40TWQ5RndE?=
 =?utf-8?B?a0lJVmd0RlJBSWJnNm5DUGVDSi9JaTRpR1BKQXI3V0xPMW9oazJRVC8yRnB2?=
 =?utf-8?B?MmgwbTlaRVJ1ZzlnOEtNQ2luUWV0QnprbXU5aThmbFVMYXlxNzdtZVhwOWFM?=
 =?utf-8?B?aHJLZWM3MjVsLzhtcFhKemIvM2VjN2t1bjVJZUk0cUF5ZERGbXlETC9TTk0v?=
 =?utf-8?B?V0svSHNUSTBOd28rcUpzRU1EbmZESkR3RUt6WC9jM2VkcUdSanhEZSs1b2gw?=
 =?utf-8?B?ak5LY1lMaVVUdmVwQ3pEVXo5amtOQUhsekhObFVMc3pBTXRNaHQ1dWM1c2tJ?=
 =?utf-8?B?eGNuc213bm13a2RtM1ZYK3hZTm1YNHBNaGNIQTUzTWkxaE96RndwaDRxT21r?=
 =?utf-8?B?d2cyeVRkRzJVQjVHRVR4cHBlN00rNmdOenBpVXlFSW5xVDg0R2RNYVI3QTlx?=
 =?utf-8?B?NEg4OWN4UWRMSy9UZ3UzUFF6dmdja21HWUNYVHgxNmxIM2YyOGVFTEgrbldO?=
 =?utf-8?B?S0pwNUdNK2M4eFBjSHBreTZ2dnVyUWtla3NvSkorS3lBS2YyR3hTWWZrNjlP?=
 =?utf-8?B?anYvTXBxU3FLK1k4Q3NDTit5WUhqbElmWmNWSm9tQXRQYnp3V1NNNjdvdjE0?=
 =?utf-8?B?eXZLTzRqVmllTFpNdFJOY0hDaERremxuUUlObDhwM1oyck11T0M5cktiaUFl?=
 =?utf-8?B?OWgvRXBjOE1WMjVYeVdUZm9yUCtPS2szNTRVR1VEM1lZTm9zYmxMZmphS24z?=
 =?utf-8?B?cXJWb1NFMzB3T00yWExCV0VGNHlJYXliRlZSM2dwUnRCZDJ6eHBCcW15VkZw?=
 =?utf-8?B?MlE3MW40TjBnNFkrNkRRdnhvSmhDRWQzb1VEM1l2Z0o2ZVFVeGJ6YThCcUZO?=
 =?utf-8?B?VVlOdUY2RkFiMjNmcDJ0MFdlTG5xSjdXQWxIQnQwaThxNkVNcDdqTTVzUFp2?=
 =?utf-8?B?d0pVRS96MVJpUWc4TFpRRzJ6YlIyK1ZzN2FyY2RUazh2WkQ1Q0dOZ2x3Tklq?=
 =?utf-8?B?L1hTeWl5WkxWN0dDZ3ZHY0lBYzFtenFpRmxzNTg5NkJWQlpZcVJWSFhpM3hs?=
 =?utf-8?B?Wkg0T2J0b0dscXh3a21XcnE3UDJvZ1pkb25KRStkdUpuK213Rm1Gei8vL2lq?=
 =?utf-8?B?RGJjZ1ZSaXRkTmdpWEQzQytlSGZJZldYZ05kZEhiaFlKZmdUb2wwT0NFalRC?=
 =?utf-8?B?QUpKdWI2WE16UVpBYzg5RjNkY1EyeGZlV04vUmlRNFh1QkphRldXaDh5RWNF?=
 =?utf-8?B?eVc0eWtiZGNHbVZhZWppQU54eXY2ZTh1Q0k3NUxLMXFUaTlFcXlCNXFtZDBM?=
 =?utf-8?B?amdUYTVOTWZ2SW1STVFSZm5CaUl5UGEycU9DZ2xad2ZvejArWnZMZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b83ba187-a69a-4ebc-ed66-08dee686aaec
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 17:45:20.2440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfK00EHxkbWqYuGuGLwxM/TeJavgdvqapcoCIpAYC+EWxMgTXGchTJxB00pfHxTP0i15JDYGjtDIMn0MTo+mczjJnJSybEiNq6PIJ8k0VeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7955
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siKvv7909N2AeIoWLy4Kwxqksy2rps0UbEBF2NQv5N8=;
 b=L5BHt0ZyTuX6SL2kFL0ofM1GqsScQgjNNuZQnLXae641I/6dCnPHouf7k+oauqODEWdlzJHuM7Hi+70KFYzW+FMA5etK99+M1UXjyG3ZCTBqrHauIzBEZ6F2IO/28fuVo6shrY8vhh07dKhFEaL+6XxVBKscPBPXOiSwEBD07Y4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=L5BHt0Zy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="L5BHt0Zy"; 
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Daniel,

On 7/19/26 3:52 AM, Daniel Golle wrote:
> The GPT-based capsule update helpers match updatable images by
> partition type GUID and fail to build if PARTITION_TYPE_GUID is not
> enabled:
> 
>    arch/arm/mach-rockchip/board.c:50:29: error: 'struct disk_partition'
>    has no member named 'type_guid'
> 
> Boards which keep their firmware on SPI-NOR use a static dfu_string
> instead of scanning GPT partitions and have no use for this code, so
> guard it accordingly.
> 

Fixes: bea9267d7e6d ("rockchip: capsule: Add functions for supporting 
capsule updates")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I'm thinking maybe we also need to change from 
IS_ENABLED(CONFIG_EFI_PARTITION) to CONFIG_IS_ENABLED(EFI_PARTITION), 
but that isn't required for this patch here.

Thanks!
Quentin
