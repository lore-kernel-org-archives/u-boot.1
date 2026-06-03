Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E843CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2893B8467E;
	Wed,  3 Jun 2026 17:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pWLeTBt/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pWLeTBt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE248469D; Wed,  3 Jun 2026 17:23:22 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA99839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 17:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rK23CuQ16tfyoRQVrWwnJeQKB/Il4M34vuwxvgLydKdjlNZpnTDdZqShf+jnzpajjwmZSmSnCPCEloHohh49g4BniHmrHsG86VVysWsvfPT9D/JhiVnQogggD54kaAa/9jR4msCqLx6mmH1mjkfEwbyk4K9dY0p4X6Idh+cBNet5hlFEu1NykPqtHqmIHP0VwD95sU1dAgsGBMT8TjoE3f43uo+vid0yykWT8xk4HOE3DpHUeaaOUkC47bve6L2VXauWVHab2Brf08aINlaeeTgFNt81PJN/M9W2UsnV4zxVliISgcjqYhZ4bYEiOVjmLw7UVx04eW7GfqCvTKP4ew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAXOWjQPJcJpgBs0RUrJjpbq0FsOL5IycHKih975Jqk=;
 b=lmq/rN9Dms+K6l5n31WnvqaZegaEmo2l0wYZzWWBGOfppNjQuHvoLb1E2xI27GCmnh9n338y0rl0V/QSG2Z+xShLCOKZSgXMBdG7xyyWQ6yrrOJ73kHy9GXYiNuByyknzj62onoM7gR6CSFkHs+VOZZ6JSNb91YoPRUNwfliTmG/zJEvIYdquXVKXbEMvkyUGLaJxKHmyDn7REQeBhWi05/6vLCCCBHLtLgFEvtExLrxr71A8RNDS8jdJ5PdNTqDle9SNvwSKDFipfpGeZOYcKBGn8RMouE1GliNR5tuT0o0XrvYZ4E2DQBZZFCfzevPX02bsbZMPErkD1M6MwuRRQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iopsys.eu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAXOWjQPJcJpgBs0RUrJjpbq0FsOL5IycHKih975Jqk=;
 b=pWLeTBt/s5m2ZcRAewkPW7Lusu4W0XpGs+Y81cjRzxaTDJ2KQ92WSpTbOB7dKxCDEadXrssbH+HKSUkfdNSdfKiWmaqjIgrJchsKJbxxBfv+S5xNDwn1fNfIeoaFXkEnTKrcCi8tNT1FTQshJtsnSOxrEoMaXfaiYbwHGuC2T9A=
Received: from CWLP265CA0333.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::33)
 by AS8PR08MB7813.eurprd08.prod.outlook.com (2603:10a6:20b:52c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:23:12 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:401:57:cafe::c3) by CWLP265CA0333.outlook.office365.com
 (2603:10a6:401:57::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 15:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 15:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH6OGuNJAGEjIueEAE2WadBgGWvdCkrCuTJWW8bD5js+CJjGBXkYroGLeGh3xDEMcygwJ1F023Hk9HlEmlJo3y711h2X+ZXqRNAAQYVRkhK26R761KOMS0jx9DR4vMGZfhCXti3VHotZZt95fium0oVEd9ZM7+6Bbz0RdS8KQLxrdh2Pzc1ZkETOgvgtFbu67sOC29Ldcx55IbCvSkX+bG3etFXmQFCHjwOoOCSGppLuYIDJ/GxYPceCIV9gBPIW8cM97Wld8073oaLfdxwE6gKwz6Chz16CcO3lGJAOs71vnTJYSocmA5oB6X/nN8/xJeOLXXxlxSdqfc/yi91Ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAXOWjQPJcJpgBs0RUrJjpbq0FsOL5IycHKih975Jqk=;
 b=rVA8Io+MvI060/sLGRtv07eRoI/4ExOvok9+MuHg3A4l/zperXOvGkz1zivTP9QMrEwsjqWm2i7U9Ts7eESwHkF1LT5GSm3nL7oLqlZXH+2B+3di0d00ixvtrAMVJhWF6479svoWcfM/KO1gV2/4pq2RGtKeoHPY4YpskXyXM+phC+H2V2z+t73t5Dii1MM6iLbzUQhs/ti1zANqIYb/taSnHfCGM0uGzk5RIekJaozgvDVg1nYY6NwYrqm4eYL6yi/ZPk9ysuFNLP/NKmJk+Wzg/o7WI6MuI82WKwbwp5spKnxv3Qpj4aVhJOLVJNXTFbxzjaBFu7iqgWtAW/XvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAXOWjQPJcJpgBs0RUrJjpbq0FsOL5IycHKih975Jqk=;
 b=pWLeTBt/s5m2ZcRAewkPW7Lusu4W0XpGs+Y81cjRzxaTDJ2KQ92WSpTbOB7dKxCDEadXrssbH+HKSUkfdNSdfKiWmaqjIgrJchsKJbxxBfv+S5xNDwn1fNfIeoaFXkEnTKrcCi8tNT1FTQshJtsnSOxrEoMaXfaiYbwHGuC2T9A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22) by GVXPR08MB10517.eurprd08.prod.outlook.com
 (2603:10a6:150:156::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:22:09 +0000
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c]) by GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:22:09 +0000
Message-ID: <bd7a4f61-ad8a-4977-a509-c1efc7f46379@arm.com>
Date: Wed, 3 Jun 2026 17:22:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: airoha_eth: fix mt7531 mdio related
 initialization bug
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260601213546.2436900-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260601213546.2436900-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::17) To GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11741:EE_|GVXPR08MB10517:EE_|AMS0EPF0000019C:EE_|AS8PR08MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5642d2-a1eb-49a4-5844-08dec1840696
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: qqDBM6LTEBLaPOJSTHUv77EBPdE9LKMGyLrZm4VJ+OuvdakarM3/v6dzJVXCpAWaeyx4NIL/UWuNny8xH6ZWh/fNqqhfnEnNS0Ynr3ZeX4nPPCQvLXJAfRTU2ayle4nscBqpFNy4yii/CNj1oX8wjOWdj8R6iakABrhUx93QyKF5MDDFzG8pcmXLI0ikSPAijZDa3tBenEfpnXSohsdV+TsbW1v7s0+RZTOMBCaZhs6zefVdyRRyolqnW+/cm18j0ZR4hVLZGlqzZF+zD72Dh9sFLGTfXiUwTSlEpSQiOGDUdwsyUmlHY6/axw3maPi7d7cGWLKv82xd+uhUrFxtGmofSLTPT3l5z0rFosvFWmSZYDUlQYYNbniEXZ87dwJ8sDETKufDMoTghQ1bOAeFb20NDRmKSZWCo7hSB0wLEPMcBw0LSNboauRu/nPvPJDvhQWecHlhp1wf3xySeege/AF0b7GIatrDbTKhZcA6MMec4Hv5jhiWqOteDmyWePKODIlL0fhaFSmMsaG0HCObQ1+8/AHhkR6v4NgKE84lUkBIKAMytKzqTPbPwMGo/aKtXhiDJEI6u7QwInQlRRfDcWBMVaP4yHJ7RhC5kQHJiDrzP6IhRlnWX9AHGmtkzDLVIjkEcsBQABwArrWxeQT42zEbbvgjQ3IgScZWFScdoGaPkw5k9DA73CxcNPaOOi1R
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11741.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: pdE46w4h9qwcIZEjnamPDytTRsRdYCFGFemYMp8hzaCMCjZX5bkBRBgrzAEvA/07SBIdlRqU0wDySMLnv6s03esmzYtv9tF+jzi2CWhnvyywOrvhvHXjP46aXueiDHMv8NE0s37H3t1Id6P7zjD9wr1ttD88GdKwN8iUd2qAQHQiUtfujyAcqFg6jWY5SQ4svtNWZVjDRWrsONfjeMQAqGEz9jXKDccIM3QZCahaR5JQAk/rzqkPGk9PrxwoJenomzeteBktCiMrb3pOnPYNZFel1qFA0cjy4MOE3/fTVNji0TCyzkMpRRSi10jExvHt0kaEJsdIibYbggBLTGxNzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10517
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f70871e2-ac42-4732-aebe-08dec183e0d7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|14060799003|1800799024|35042699022|22082099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Lt9XX0UE5R0rc6odP1VgbpWlP0jc/ueGtXRs6rV9qbYWpPIXF8Gi8UZ/77GLRiNtLm43936++E5N0j1T/96+czZpwZrIXa+X/px35qeNhFezXnU+tPyQiAXCrzFzcrb0Yg+lCUgu+Z5K9FxsraBSh2jrLJZMKCTHlOvxmaIMpKP7qa3APvxMIgpNhwmPQcSLsz/jmBwCR6boxv41+2k9teV4syMpLBtLE/kmZXXRX6Bp4E80Ei5KnPzfdMaYa+w0u5p8oNWE1RMOc/ZJgTj8Ha6q/lCi1mGmHsxPZoQKNPHw1gKVn6GmPoAmgLPE1en9iA8QaAAm//CRh36HZJOh/4SRNrbiaxZSaGCAwa5skwdO0qpU7qYu5xuaXSHYoMbEjL95kP8pw39pO8SBzPHZefv7zPu6acrYVylemjSXvvLyflEDKjDUCF4Qcme7UGaaNrxAkH0I0FI7PiY6L69lu33MWQcQYMukImAAQ9NjeOpCafh3y2gMiANUc2kHW1WHuiCnPpXkaR0Orer1Bx4Ve0+5ssV+u2pq2RCbyrJKtGKQjOhjV6/UHTAkL+BklwgQWfxw7wI2SqHyfu0KKO5huJkisTh8PtpoiKZqqaLIPzhjGgwBBrX7xJ/ha2IjBsmuxaZltA2UYy/Q7chUBabpf2HDyjA8hdKaeRH8McGVkxZGf140qBFs51vSZ8ZyzP5+n65TvmXfqLVfcAZb0GpYAftYScWBSKSYP3AVUQJ0UqM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(14060799003)(1800799024)(35042699022)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9OW+0BRAbzBYwYOmK9vheFW8v77U8uiLjMKCxqVU6+FMC/qe4qXwTuKkx6zPDyi5trPNfKMBx2jyhQ2ugGV+v1hRy61SvvFKo0b94HNts8NH5EBBCIC88VfN9H5Ky6IHIvy8s2twxg1CjqjC9uF80mZuOHwI9Nspau01UHH/81tWBcb1sm7QaNvJlA/emMSde2fxzYsCJP8FWLC6HDOJAPolo77KnB8WO0UhXATHbOxCiZm66YQEkANBaJYL1reDsXIdJcOMdm0vbCncxzPyF1x9yRVj5i/vCbUE7enx0GjsLMohIy2PdK3Ib6P/1w4IhODYRzrvUrlt6PnInQzUrFfFhAnVLPBjgGBRUBVZB8FzF2p06ykxDLzKkOe0cyNB3Z0RbRN8LNu30FIY+7iZcmDneJ3PUx/IucincjxfIsHEz0VeHLsZOlkdS4Wv9N1b
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:23:12.2652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5642d2-a1eb-49a4-5844-08dec1840696
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7813
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Mikhail,

On 01/06/2026 23:35, Mikhail Kshevetskiy wrote:
> Private data isn't ready during bind time. The call of dev_get_priv()
> function will return NULL. Thus we can't save mdio device pointer and
> use it later during probe.
> 
> To solve an issue, we will move the mdio initialization to the probe
> function.
> 
> Fixes: 96d9e7c46425 ("net: airoha: use mt7531 mdio for GDM1")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
> 
> Changes v2:
>  * small refactoring
> 
> ---
>  drivers/net/airoha_eth.c | 51 ++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
> index 84ee9b2ad76..0a1bcb87104 100644
> --- a/drivers/net/airoha_eth.c
> +++ b/drivers/net/airoha_eth.c
> @@ -365,6 +365,8 @@ static const char * const en7581_xsi_rsts_names[] = {
>  	"xfp-mac",
>  };
>  
> +static struct udevice *airoha_switch_mdio_init(struct udevice *dev);

I think this forward declaration is best avoided by moving the function up
in the file.

Thanks,
-- 
Jerome

> +
>  static u32 airoha_rr(void __iomem *base, u32 offset)
>  {
>  	return readl(base + offset);
> @@ -850,6 +852,7 @@ static int airoha_eth_probe(struct udevice *dev)
>  	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
>  	struct airoha_eth *eth = dev_get_priv(dev);
>  	struct regmap *scu_regmap;
> +	struct udevice *mdio_dev;
>  	ofnode node;
>  	int i, ret;
>  
> @@ -908,10 +911,9 @@ static int airoha_eth_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (eth->switch_mdio_dev) {
> -		if (!device_probe(eth->switch_mdio_dev))
> -			debug("Warning: failed to probe airoha switch mdio\n");
> -	}
> +	mdio_dev = airoha_switch_mdio_init(dev);
> +	if (!IS_ERR_OR_NULL(mdio_dev))
> +		eth->switch_mdio_dev = mdio_dev;
>  
>  	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>  		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
> @@ -1202,39 +1204,52 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
>  
>  static int airoha_eth_bind(struct udevice *dev)
>  {
> -	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
> -	struct airoha_eth *eth = dev_get_priv(dev);
> -	ofnode switch_node, mdio_node;
> -	int ret;
> -
>  	/*
>  	 * Force Probe as we set the Main ETH driver as misc
>  	 * to register multiple eth port for each GDM
>  	 */
>  	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>  
> +	return 0;
> +}
> +
> +static struct udevice *airoha_switch_mdio_init(struct udevice *dev)
> +{
> +	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
> +	ofnode switch_node, mdio_node;
> +	struct udevice *mdio_dev;
> +	int ret;
> +
>  	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
> -		return 0;
> +		return NULL;
>  
>  	switch_node = ofnode_by_compatible(ofnode_null(),
>  					   data->switch_compatible);
>  	if (!ofnode_valid(switch_node)) {
> -		debug("Warning: missing switch node\n");
> -		return 0;
> +		debug("Warning: missing airoha switch node\n");
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	mdio_node = ofnode_find_subnode(switch_node, "mdio");
>  	if (!ofnode_valid(mdio_node)) {
> -		debug("Warning: missing mdio node\n");
> -		return 0;
> +		debug("Warning: missing airoha switch mdio subnode\n");
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
> -					 mdio_node, &eth->switch_mdio_dev);
> -	if (ret)
> -		debug("Warning: failed to bind mdio controller\n");
> +					 mdio_node, &mdio_dev);
> +	if (ret) {
> +		debug("Warning: failed to bind airoha switch mdio\n");
> +		return ERR_PTR(ret);
> +	}
>  
> -	return 0;
> +	ret = device_probe(mdio_dev);
> +	if (ret) {
> +		debug("Warning: failed to probe airoha switch mdio\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	return mdio_dev;
>  }
>  
>  static const struct airoha_eth_soc_data en7523_data = {

