Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956F1CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 442E740CAC;
	Fri,  2 Oct 2026 11:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wvC4ZQV63_Iq; Fri,  2 Oct 2026 11:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8ED2540CBE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790941287;
	b=qC91RhytpHty4YUSMM7x0SXaEoSnux187MFQurTmPrDMJFNg2BuwbLCSglnkatfg9qLB
	 aJ97z+Wibq5zSD4qecmgX6iI+SaR3OBHX7OF8pUupxW2o2m3IpjOzE8OQz40NsOLrI6yk
	 +UfSkDVr/ch1XHtQKtB5vTK7BckQpIp1HJh0+bYoY/eoIJYDe4BZY6n5/Ym+f8G/2Filr
	 49VWl4cvfbSY6h8R6Truw0mePWW4OqxuVgBXgBO5+VKPbh2DX8QAoxqLYPkN+kd/javy3
	 8OtotvwdmA7tSy4LwncFbPz7ySAFhq5zoL5EE0gawC++yN3Z17PVrEcEILI+nawlpFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790941287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ryJNlYB02LXRLUJcGnCbvtVRW2gV/AJIVYOsKZ9mMO8=;
	b=Nj+Soaml2jZjwjJ8xfi+sfe6kryVpUAllJ08zmScypVE+5rgakyUYXB5Y3mg+p29UdqD
	 6wW/VuGgl3g2qLsik1Z3AxQzFK0ObN+ERUyRD3HlsdGB6uDlppOVawOyz2/7i4MHoM7uS
	 sTbno0EeZ2/pACGI5tNobcAHEV7zuSsjhwvhwT+76/lXuFrUPIHHLt6j/Ae1s7ZQAQ3wD
	 qPzhvpabNuugRoUhwKoBjBshtM6Pm6JU9gAstZNsisAhkxd8vG/2+P+VgsjJpV5BA+B80
	 77CfMEy5/8Z5xuingCzBQnzkcOCc2AjWAWbu1+qlbQ5JsWM2s1yH70PzC6gKUQZ3IPA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790941287;
	bh=ryJNlYB02LXRLUJcGnCbvtVRW2gV/AJIVYOsKZ9mMO8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iCDl0k0U+y6FIwlI0/OukxAfoardHBiIqNoUQM9oprfb8OkPljBN47thb8MKeqhoa
	 CvNkBBdYCTEdchDDStb8ZtQbOP+Xtv9KF5z31+pigcu8sMXScxwEN/Zj0h3V5QnFA/
	 JBs0c3sBgfzpCqASHv9BFQXr7J+5AOyE4MJEZrZkFkraYCHnShEHmkGjgf9lCkG5jR
	 1Wr+aXV1ZJ2jjeNJQiKnrMp3oxfkYiHXlX2EADP+O7Rqb4Pw4F+5sth6O1Q2QilyKH
	 TzN1vpqrvVwqtdUxjmbkTaRwl5Y42xzddYZvomyqlCEKAi/CLBHytB/Wo1dZ0apG40
	 sSzj4au1aYwCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ED2540CBE;
	Fri,  2 Oct 2026 11:41:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADF772E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EF3640059
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4nU3sXkjX_8G for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CE57A4004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:d406::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790941285;
 b=l+ehDciWXPH97z3yExYbsZIWuuSlRQacY7JDN9HdV7L+T810+/R8dZCJQBmzB2miUxas
 ssa5TTgl7NrZ0kMA9GHHM7cQgK7Hih8wDOudSwQaPPixm2kMn7zzwBkzRPpcGEBeEl+zA
 wwJc56tGbkOAwKVx4Q0+pVZZ1mPZMHwPB16TguxkU7Rl3f3HTQVwej04WyOONK33GRcEC
 w29wsJ9GMWEarQEWFgobge0b+vXHlZWh4TTijNPm1GKPf/ak+xK1vOuj8aIaJt+vaq622
 D6htBetXoHWqgYS7BMYiM4+g3RqhTc7sEer5edv8d99RzhZuSF7PWF2jepjSwf/qt1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790941285;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
 x-microsoft-antispam-message-info:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:
 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ryJNlYB02LXRLUJcGnCbvtVRW2gV/AJIVYOsKZ9mMO8=;
 b=GhB+ZwLf6tIN1O99mNZPp8FRSTGyhyILFE3D58T/Bq9SaZwOwQstjDDcfhsXvLOXNHu6
 MZhbQI62vRBDL6k8F5VtF1dieRTSHG26wJoJvDSEnETzJ+eiBaN++CGv/tlIEdPuBNOa+
 WlRyvN3VJfqfXw2uJ7gEarN3q2QJGfkVj6vJaCpvcA+LzLkbz6O7SpF+U+5G297WsFWGT
 5xa2BUfxcN2RiY5Nn6jgtpezApY3JEH2wG9WVN3nuLRsueBEd8oep1J96DyBIzoe02LUt
 NDAVFAwOYkIhvSRgUTfAWyBR8SY5oOe/qi+dSyU2xtTcHsK/6NgqegxbXYAfjqlgZ4w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=outlook.com; 
 dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=gCaulblY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:d406::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:d406::;
 helo=os0p286cu011.outbound.protection.outlook.com;
 envelope-from=yangshiji66@outlook.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=gCaulblY
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE57A4004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbzjevkIxAc6xiXS/XttpZ7dkoTx12zPmFMsSEGgR97fDWOHOEkUzbp80bXxLSe9RvFruNmr7siI6gFnpjGlAMMgMiOHxzhFaLH6FU3bRSfkEshTEe+j5HzO2MBvO03S/Slb/yi4ITypJihrBlHgfv9LCq1OTCzc85XlWVjJMFpAlysHLQvB/pC2iF8cW0ED5i9De4OHWfpYBPojm0oezH9gl7uf6EZ3lOZzSWUyLb0ApWfEyYQJQU/PEtei28rEkHTPDlujNgjpxVjU5bm+gs93nAFj0dZJHxhhtP2fmmJsdJc0BDCJY62x8ioFlFP/QCrfLjL0OiptWSiCDrj4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryJNlYB02LXRLUJcGnCbvtVRW2gV/AJIVYOsKZ9mMO8=;
 b=oFEPyp0a7+OQ/vkaFBouREVH87w/U7DhJnBxzJS43M2aveiJGkGPqlRadItC6LohE6gO45XLUjk0Ihi+KtOF+s9ihrrmymD/p8gg/9Y3DQGDXIdbl/o5F0Vr4dVDh6La42FXKxURZJBt37rca9pdFjFLi+5RN+0J8uokMH3Z26/CkMhQKO6yDawngGkdiHPd4c7W3jvXOrfy8kAKdigyu2zcYbZVlJSmfSpme9vUUrNJxORd+n5Zpc4Ugo7kiAMDAYDAyzW3fzJwSYWT+SJriW9KxiK9wFYY1zlMOL5Yk9+AncwelWjsAotQq9cPwkNtzZRxY0CdsBJaMT3uumJY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryJNlYB02LXRLUJcGnCbvtVRW2gV/AJIVYOsKZ9mMO8=;
 b=gCaulblY/hOJWYs8fbiZqEc5vHURlJkiv1IMscqCYRs0OVw2lZHIaxoXe3k3t2aQIe9KI0T18YvMMFMvapLPyeIQQTt1+TKH8ohq5X4Tp3PgJ8ID2TZwjXpKr3GRvKOGbPwx4HQ7M2EA73vbpZTz72WCeIyAl1aqovqQGr5U9Km9kYKzq3XljKAjbAPV3bEON5PqeRpO4qxAU4ynWU8gMl9P85kHoRdRPRhb8HBphGI6Wy0AtAi0kPhI/qATy6Sg+AIIGa9lV2kVtnIwfVrDWVZ08K/F65A0+s3pEgeoOwEE9Q92aVcpYnNOSRwfm/7hcJLk2OnjIjvKbkh3D0+dug==
Received: from OSZPR01MB8140.jpnprd01.prod.outlook.com (2603:1096:604:1a5::10)
 by TYCPR01MB10228.jpnprd01.prod.outlook.com (2603:1096:400:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:41:19 +0000
Received: from OSZPR01MB8140.jpnprd01.prod.outlook.com
 ([fe80::91ec:49f5:d743:6d5b]) by OSZPR01MB8140.jpnprd01.prod.outlook.com
 ([fe80::91ec:49f5:d743:6d5b%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:41:19 +0000
From: =?gb2312?B?0e4gysC7+Q==?= <yangshiji66@outlook.com>
To: Weijie Gao <weijie.gao@mediatek.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH,RESEND] env: mtd: fix unbalanced put_mtd_device()
Thread-Topic: [PATCH,RESEND] env: mtd: fix unbalanced put_mtd_device()
Thread-Index: AQHdIJp1mDZ8zShPK0Gz2ox6Dbcf6rbqg/9P
Date: Fri, 2 Oct 2026 11:41:19 +0000
Message-ID: <OSZPR01MB8140D4A0EBEC73725E0DFA7FBC892@OSZPR01MB8140.jpnprd01.prod.outlook.com>
References: <20260731031227.82743-1-weijie.gao@mediatek.com>
In-Reply-To: <20260731031227.82743-1-weijie.gao@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8140:EE_|TYCPR01MB10228:EE_
x-ms-office365-filtering-correlation-id: fb36ab4b-ed85-4eee-94ec-08df207a1365
x-microsoft-antispam: BCL:0;
 ARA:14566002|51005399006|22091999003|8062599012|8060799015|19110799012|31061999003|4140399003|24121999003|25010399006|41001999006|24021099003|15080799012|40105399003|12091999003|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?gb2312?B?eFV5NGZETXZJQlVnOXYxemlIUlBrcXRkZllITUpHbUpmVEFoQzZKNlZIeG9O?=
 =?gb2312?B?aEQ1Z0FyTVVlNkFZVnc0OEk2MHVZMDRiOGtHUE9rWC90K2FCaExUbjJtaGI3?=
 =?gb2312?B?OEFDcW9Sc1hGTTJ0a0dUaFFPRnZBczV5V1BMNkhURndEd3pLcHNIKzBndzdV?=
 =?gb2312?B?RFd1MTYwcDJZY0xEK1h6VEVia29nTC9xZ3hzME5yQlJjZmRic1hjL3pPQzd4?=
 =?gb2312?B?ejZrenJrQU9weklrNmEvRSs1a2MyRkNKeUlyUFVCcU84SC9Ed0pSa3AzdTdn?=
 =?gb2312?B?N2hFODFjSFA3THZ0WEVXVFJFOVBzUTdyRUJTQmQ5OFEzaEJZUGpBcHQrU0la?=
 =?gb2312?B?ZnVwVnVtNmVrcWxMQXVEaG94aXVMZ3hROGQ3TXlseGJUaVhMQkl5OG9OZGdD?=
 =?gb2312?B?UTMzTnZkMDJESnhYTjMxUG5MaU4yZ2J0ZHNEcEdjWk1iQ1cvcm53Slp2TnNh?=
 =?gb2312?B?SGJ6TWdLdVN2NS9QczFqaGVYV0ZaZ1NFQTBibCs5bko2T1dPNlA2Z28vS0tm?=
 =?gb2312?B?cmx6cTQ0dEc5WitmOWo4UWtJd0c1cExpckJLcEZhQzNwQVF3RngwTHJtODd2?=
 =?gb2312?B?SGp3QnpwSm1PbEM4VEN0eXlIckhMUU9pY1Qxc3NHdnhKSVEvM1hnOVdHUFpS?=
 =?gb2312?B?Wld5cEU2ZVBVVDlOLzdnbEsra3NTejBBcTdSU3dTNGFPeTdPY0JXSGhqcm8z?=
 =?gb2312?B?WFpBZEJQQUVRQ2k5T3hKY1U5VUpPVWFOQnJZK1NreGJLRTluZzB0OWtJd0hS?=
 =?gb2312?B?VHBwY1BYRE5aUUJkYmFhcWRKb0U2eisvWXdwOUo4K1hoSGYrS1MyYThlWDZI?=
 =?gb2312?B?U211N1hTTEJNbkRLN2gxeUNwbnFsWjRlNFQyanp5M0d6THJ5cnBBRk90cGR4?=
 =?gb2312?B?V091ZS9GM0J0d04rZjRHclI0dm9QMVVkb2kxWWV5aXZsRzFUZW9Ldm9hT2NU?=
 =?gb2312?B?cVU4M2FHYndhOSthT2g0WWQ2K2hCdkl1My9NcS9TRDdxY3h1RGhVMnBkSGxP?=
 =?gb2312?B?aGZ5aW9QS1FZbTVUdzVGVERkejQwTzdmeWtVaFJjNmEzY1RzNDUwTk1DM2s3?=
 =?gb2312?B?eTV5YnF3QXYxODh1OGpjdWk1WEdFcllQS1k0aER6dFQvRGR4eFhuTm0xU1pT?=
 =?gb2312?B?TWR3WGQ0K0pueW05TDFXZ21Tcm1vT05UN0diUG1QcjVMTG5TaFFOZDZna1RV?=
 =?gb2312?B?VlJ4U3Y5dU94K1pIcXBXWCtoYXpCTjdOLzhHMDF4dktqSExXTzNhakp6ZFlY?=
 =?gb2312?B?T1prelJ2eHdpN1hrcCtCZkRGVElETjNFdG5JLzcwL1JiMGtTZmN1VUZlUEVt?=
 =?gb2312?B?RGh1S2NGR3pVVkd1TXU5dDFjZGMvVDJyNSt6emcvUnlCc05hWTFBU0pZeDNT?=
 =?gb2312?B?RGZhYi9XQUFqSG1USDJSK3RHTFhGRzlYZGxxanNHbEdpOWQ3STk3WjgzZkkw?=
 =?gb2312?Q?NQpJvQvw?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cmFDUlBtdmVndkEyRDhxRExKSUZzMU8yZmpKc2F2UStpQ2wvdWxyWlJlcTRo?=
 =?gb2312?B?RkpQenpTU2RLWU5mbjJuNG5lWTZrcGJEc2pLVWZGQnpXZnVVQzBScHlnTFpx?=
 =?gb2312?B?aHV3UFAvQWc2UVVRRldmcXIyNkJrTGN5ZHZFN3ZlZ0tFQlhITk5lZFRrQmpE?=
 =?gb2312?B?NGZ1dnRBa1BnU3NkTlFWR2twMXRpNzdqR1JQMFdlOGtEYzBXeVkxMmpyRHJr?=
 =?gb2312?B?U1lnOTU3UjBkUUFTZFdrQnkySldXN2UxZGp0ZkFUQkdzeTZlVm16eUNaNEJL?=
 =?gb2312?B?SVl3cVcrWjZyVmI3c2FER0I4U1YrNE5qSjJsWm9pRVA1QUJVeStWMzc0SmZM?=
 =?gb2312?B?M0ZxZEprSlR1OS9IUGJkdlc3Z0RWOUJtWFIzb3BQOWVjUmdjVHdBSmM1cVMy?=
 =?gb2312?B?ZTZlc25WU0ZnMXJhUVRiL05GTERsSEtyVkZzRnR2SWFic280VlQxcnZGV0l2?=
 =?gb2312?B?b1MvVnB1TTZiSWRXWFp0RDEyUzhudElSNUltbmRTaUx4THVYREJZNHdIS0I1?=
 =?gb2312?B?QStJQXNWK1RUdHQ5ZXlmUVlsZ3ZBdVI5cTRrazBLbEFxbkhmVWxyOXgyVGEx?=
 =?gb2312?B?MEZkemN2UFdKZG5pKzZQWHVQV3FMeWFLODJGWTNFVFJyUlJQUzZJNkJFK1Z0?=
 =?gb2312?B?MlNHU3NwbXpmWGh3RDQ3RTdVNTFUa2RLaHlMM3pDcStJd0R4MWFEUTFoZ3hG?=
 =?gb2312?B?R0hJMnZOZG5TS3JtbjJyNDR6RWxybE9Ea091bWNDV00wTXIyRThOUnlHTlRq?=
 =?gb2312?B?S0NOZWJhMXpIZnYxdWl5ZWZ2WUV4RkE4MW1qaEYzeklJTXB2dDh2V3M0cnBT?=
 =?gb2312?B?emNreTI0aURmd204bm9UT2JCb1VjbksycnpyWGNCRFdXMnI1SkJCVHlpbnR0?=
 =?gb2312?B?S1BadTRoNzF3amNMSEZHYXlhTmFUV1hqbzhsaTdVV1VnT1JnVzVXZi9YMDVK?=
 =?gb2312?B?elJBcWdweER1YVcvenVFeFhWTFpUaFR5cm5lcUJnTEhZTERoZ1JpZjE2dzRn?=
 =?gb2312?B?ZjU5VXh6dy9KVmxoQi9vUFVUNEJ5aFVoOXR5TVdFdSs4M2xuVm5PRHhRUExN?=
 =?gb2312?B?dXFwckFXVlBNczg2aTdTeEdmNWUzVUJRblFSSCtXVGRNYkJYT3RmK05HbStE?=
 =?gb2312?B?N1VzMFhoNFk0M2dXRnNHbWpSWFBFc3hNNVgwRG1MMjJmUjVmRmVJeGV5ajJL?=
 =?gb2312?B?KzBqZEpESUFWWjBVSjFQSDVTUjdWUmg1N2NERFhEWXFuZ0owUE5JWXZQdDA4?=
 =?gb2312?B?RFZGR2EyaWNtaHBLQjBtK2ZtZlJaYnowdzdzaEdjYStRZWFuYVRuazRORDZG?=
 =?gb2312?B?RWJld3RNeG4xMDZEYnYyTDduRXdUakRXeU0yV3kvYW8vUHpOKzhPTDBIckQ3?=
 =?gb2312?B?Nk0xY1ova0hGOFF0Z0ZTaGxBMFJCaExWd0FENHcreUVTYVNya002Rzh1eHRQ?=
 =?gb2312?B?Ukdwb216cEVWQ2ZlcTRsUVA5STdueVZXSmJQQWRmckY1d3M1Yng5UzRrSmRK?=
 =?gb2312?B?d3JaT2ttMXZUazJJdml1R0J2K1pNQUlHS3pSSkh4UlVNTklIY1FaRWlBalAz?=
 =?gb2312?B?Z2wrbUZoVnp0dHpFRXBQM01KVC9ZcWg0RWdNN2RhK3RxWWZmSmRNM0plcHpa?=
 =?gb2312?B?WGxKN1pBYVQxdTVtQUgxSGVUK2xWL3h5T2d6Zk9WR2MxTFNMcmtkenNVeG01?=
 =?gb2312?B?UUdYSjRtaGNLTlRNKzdjSldIeFRyd0I4b3Y5VHRYSGhvY0d3a04yZVg1Y0gx?=
 =?gb2312?B?R2JwQXJqZmZ5b21YREtxYVhXeDJqZHd3OTBUSmJhUjZTY3U0MjF4cnRERkNB?=
 =?gb2312?B?WitReEV5TUs1UTJOWkVUTi93L3Fwa3hKUW5OUXFtcVlpZXlaZE1IM2tRc1dS?=
 =?gb2312?B?VWdVaWxBdW1BZ3RTejFoeU9vM2VYS0hpRDBZNlpGOWhERWc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8140.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fb36ab4b-ed85-4eee-94ec-08df207a1365
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 11:41:19.3040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10228
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

T24gRnJpLCAzMSBKdWwgMjAyNiAxMToxMjoyNyArMDgwMCwgV2VpamllIEdhbyB3cm90ZToKCj4g
SW4gZW52X210ZF9sb2FkKCksIHB1dF9tdGRfZGV2aWNlKG10ZF9lbnYpIHNob3VsZCBvbmx5IGJl
IGNhbGxlZCBhZnRlcgo+IHNldHVwX210ZF9kZXZpY2UoJm10ZF9lbnYpIHJldHVybmVkIHN1Y2Nl
c3MuIEZhaWxpbmcgdG8gZG8gc28gd2lsbCB0cmlnZ2VyCj4gQlVHX09OKG10ZC0+dXNlY291bnQg
PCAwKSBjcmFzaCBpbiBfX3B1dF9tdGRfZGV2aWNlKCkuCj4gCj4gQWRkaW5nIGFuIGVhcmx5IGVy
cm9yIG91dCBwYXRoIGZvciBzZXR1cF9tdGRfZGV2aWNlKCkgdG8gc2tpcAo+IHB1dF9tdGRfZGV2
aWNlKCkgd2lsbCBzb2x2ZSB0aGlzIGlzc3VlLgo+IAo+IEZpeGVzOiAzOWFlOTU0YjA0ZWYgKCJl
bnY6IG10ZDogYWRkIHRoZSBtaXNzaW5nIHB1dF9tdGRfZGV2aWNlKCkiKQo+IFJldmlld2VkLUJ5
OiBNaWNoYWVsIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBXZWlqaWUgR2FvIDx3ZWlqaWUuZ2FvQG1lZGlhdGVrLmNvbT4KPiAtLS0KPiAg
ZW52L210ZC5jIHwgMyArKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9lbnYvbXRkLmMgYi9lbnYvbXRkLmMKPiBpbmRl
eCBiMjZlZTgwOTg1YS4uNjdkMjA3MjcyZDggMTAwNjQ0Cj4gLS0tIGEvZW52L210ZC5jCj4gKysr
IGIvZW52L210ZC5jCj4gQEAgLTE1Nyw3ICsxNTcsNyBAQCBzdGF0aWMgaW50IGVudl9tdGRfbG9h
ZCh2b2lkKQo+ICAKPiAgICAgICAgICByZXQgPSBzZXR1cF9tdGRfZGV2aWNlKCZtdGRfZW52KTsK
PiAgICAgICAgICBpZiAocmV0KQo+IC0gICAgICAgICAgICAgICBnb3RvIG91dDsKPiArICAgICAg
ICAgICAgICAgZ290byBlYXJseV9vdXQ7Cj4gIAo+ICAgICAgICAgIHNlY3Rfc2l6ZSA9IG10ZF9l
bnYtPmVyYXNlc2l6ZTsKPiAgCj4gQEAgLTE5Miw2ICsxOTIsNyBAQCBzdGF0aWMgaW50IGVudl9t
dGRfbG9hZCh2b2lkKQo+ICBvdXQ6Cj4gICAgICAgICAgcHV0X210ZF9kZXZpY2UobXRkX2Vudik7
Cj4gIAo+ICtlYXJseV9vdXQ6Cj4gICAgICAgICAgZnJlZShidWYpOwo+ICAKPiAgICAgICAgICBy
ZXR1cm4gcmV0Owo+IC0tCj4gMi40NS4yCgpSZXZpZXdlZC1CeTogU2hpamkgWWFuZyA8eWFuZ3No
aWppNjZAb3V0bG9vay5jb20+Cg==
