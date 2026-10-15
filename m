Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6106DCC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 279FD81102;
	Thu, 15 Oct 2026 08:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vzypd1JnUgr1; Thu, 15 Oct 2026 08:28:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 377B7810C5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792052884;
	b=cL8IkHH29lUueDRkQplcmFNUlT9WRCgOfK1Q677vC/9OnLJF0C/LYUbWBDc0clsTmgg4
	 z1TMOUgfXa6EJRHSY3oizNEJI9G+iTOxmOzuKyoepbgNM02aeklnAmlRFFvmtw5Hefr78
	 HzIx1H64NS2WwkSRJS3JqKcx8KWTvMRhaLnuc66FHvVakBZQAnSVCQAHa09yLM/DjEoHx
	 dWno+RL4y+YdxoBMkqovUcfZmqwXiLT9vDgdLTNwMx5zX1X1rTcS7laIpd9SHInF/qcEC
	 dBBZU4r++sEG31pu2bMWAs675BcyBmI/gZBhLtfiBe6arquE3IMasiTyBQ/N92DuGFQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MTK:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jojeXfAscuphyo/U63rA1tu+anY0FuSpAtTzhiE+/Co=;
	b=L9QkjsSVcW42bfUwI/hc/LcExoNCGeseHRNR0k91ZbCh5gJezV8NyIvT/6TNuTMLtqGi
	 lXh0kMmrGR2oxVuN2yIHN02WvV5oIArGBf/MpD5VwjSBKnJgr/bJTKGRotlUUoRgsRoiU
	 CnH1cVb9reAOwQrskFmXu01YYiOB4qPgCE/nNF0u+LK3eBotpQD27xrhrcJNP3ieWk6QJ
	 Rq6CncCAMP+YNA6G9h1m6mnrJ7ejELODcGORYjhKnElXMLwlhwnz9PubuvEWeRSt+fpR5
	 VuhT7gapVeJHNbiq/46FvizVoIWbdYd9LUu26qy+mqVuxeHHrCZOIrdP6ABhDUCpcKg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=WvBPt+N7;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=GXRxzliy;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052884;
	bh=jojeXfAscuphyo/U63rA1tu+anY0FuSpAtTzhiE+/Co=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0B7BNixu1BPEqTXebY3dnkkUglGEW7faktCbqRotg9Ji5nenXwAkKiFJEjNB4mu1b
	 P1vx7Cgn0LRqmo6zx2yZKMEUifx0yHHnTrNhRxXWhnJz/4J4xn+Yh9prJ3Kwen34px
	 Tt9dUizG9mf/tgjxLFm8i00X5pnzB06CNUSFRC+MYlp4DzTG14Nvs01pF1H9RLKbhe
	 bet+8gANXhw38JwedDsQudQXYPJyBu//r3XaoPOA/o5k8eJ8emxMSL4r87C8rDSUMY
	 XdCRIcri/OUBDM0EBlK5ksN/n7DaWKyDO3sxl/SkCy1LxkyaxyzHbcbuxnY3wg0Yut
	 Izcc8Vlul3S2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 377B7810C5;
	Thu, 15 Oct 2026 08:28:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48390255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E69181024
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fLbDhZ10bSiE for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 07:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6978A80E3B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792047726;
 b=Yvnf5D+20Um+jLPwYXsh/eM1ZASj/w3Z9dyUx0lyq256G8alznP4Shh21gqxLdpjmAeW
 0B/uLuLVNZ6rEOAncf8uzsYa4hkf/XO99JhFj11HQ41jf2BgD7/dtthVpDsmFQp15Wv4K
 23EZ2fMwpkWHgFqmt6WzTXULO0cSovo36ef1UtiVmNhUhY8iQs1wY0TeyymqOR7/vmnw/
 2QjD1P2gxtwMDUNX7rVUSS040An0MSfo353KHKOrmOqVGn8W6+3LTVjoxsOF/Idkfcou7
 n/OJvC7kXGlmSFCNo/3F5dHM9rWH1L2rtui1S6KlUstYzgttEjmf+YCGzuQ/bTLYiYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792047726;
 h=X-Greylist:Received-SPF:X-UUID:DKIM-Signature:X-CID-P-RULE:
 X-CID-O-INFO:X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:
 X-UUID:Received:Received:Received:DKIM-Signature:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MTK;
 bh=jojeXfAscuphyo/U63rA1tu+anY0FuSpAtTzhiE+/Co=;
 b=c7trYuTa6AWb+ok1h4zBCL9xIxNth480mwg7d82GkXsKSfRfD2Y3mqH44C2lOcfCl1//
 fihj8BhzCdQvs10LBDjp5GBrvo2CtqaVf8rtpi+jY59iW1hCQLv3GK8MlWnGM+JxY4/4P
 DEBfZvMQEAA/pKcEVc+aipekOre0h1S8FWOr7R3/e+0WZUBAmPBiFVHs4KRziVPMQfA+o
 OeO3NSaWvW36k48xU3Kk6uLeI8mW8fWkkJ9AgpLN+QDi0TOmRCLR4P7BOYuEZYqBOKAWq
 0SMSHgIpXGPl1v/dwTrctOMVFWwbtBHh+M+W4Sx8vwxnhYIdez8uQy/RP0i0GeDP99Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=mediatek.com;
 dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=WvBPt+N7; 
 dkim=pass header.d=mediateko365.onmicrosoft.com
 header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-mediateko365-onmicrosoft-com header.b=GXRxzliy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=60.244.123.138
X-Greylist: delayed 964 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 07:02:04 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=mediatek.com
 header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=WvBPt+N7; 
 dkim=pass (1024-bit key,
 unprotected) header.d=mediateko365.onmicrosoft.com
 header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-mediateko365-onmicrosoft-com header.b=GXRxzliy
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=tim.kuo@mediatek.com;
 receiver=<UNKNOWN> 
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6978A80E3B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:02:03 +0000 (UTC)
X-UUID: 10a69b92c86411f1b1788b6acf885367-20261015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From;
 bh=jojeXfAscuphyo/U63rA1tu+anY0FuSpAtTzhiE+/Co=; 
 b=WvBPt+N7nb1EmugW5L75etn6TCPplEw39pA7r6gFRh3a1OMF9992NLaKfRX97GIGujg3vFb1PFc4rUAq3JIsh3Pazq7gyWb0lcOCuHn66rmdkpjYfJHO3M8u8Xe7xdfc6v+otN4GZOb9vMPg3uhf4jcGHxaaHf85rEXg3xU8Znc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:c3336f2d-25db-4d6c-84ce-321c2ecba7d0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:cd200cae-d7c1-4be4-8c89-403f451878ae,
 B
 ulkID:nil,BulkQuantity:0,SF:80|83|102|110|111|136|836|865|888|898,TC:-5,Co
 ntent:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 10a69b92c86411f1b1788b6acf885367-20261015
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <tim.kuo@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 754162640; Thu, 15 Oct 2026 14:45:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Oct 2026 14:45:51 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 15 Oct 2026 14:45:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moJxFxhf171Mgq2Mm8OGmOaqkaAG2CSxtJMHDc5X8yiMDhbuUc6H88YL/8DsPUfT2VNDOsjM5z6PMdSTqPtX4AjZzwIKvbZcPDoT8kxmBS+yKz+ZV/SpG1Ft9o5MV3HccuuG6nP0wxM3tr/XOKbvSF3uFfG+gDMSz25Os1JgQQoUQXRrRPYCmybm7VnmHHG7g8zFMCfkmfKzsb7mE+mizZ7vO0emcEvf+e69CK2TWAg8sBuyhj2K3muGUUxwD4urRaUUJG0gPy/EB5R1RlT9zY+RiyYDh8fGbG3RfULbsG2OHrlE09cjFOJACq34sHsQVbpuWxvdZZzo8hPX2F3grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jojeXfAscuphyo/U63rA1tu+anY0FuSpAtTzhiE+/Co=;
 b=Hc1RuKGZukMIlWfTmYowuzHNdZeBSZq11zQ8y/5ofl3g9wNoR+QB0w665OWUDxtRAqGW9+Mq8xCiXeD8XGqEW+1Qy3xQSemBR+XrxDw/1Z8+kt8TAMwUt8iKzW8qc916+HbE94hJdEWGLU+IZ5xKWXtdfe04M+D4wHjSIT9AJ8mT2HFaSkb93OI3uUqFr7q66O/WTXUjlfSeVSrIzFhA6DM1gkX2B16JEJW+iGaTHweCdYd9bT2YzavaVwiG5DNMDnPLUHVVnUZdyRuXGoeqt6K71P5yhzTIo6GCvr0Z+eAfEDN3x4ya7Exdbnh2jkTPH5MP3nZS08EkvVgM4RUqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jojeXfAscuphyo/U63rA1tu+anY0FuSpAtTzhiE+/Co=;
 b=GXRxzliyMzh6YRLnOwG1IHIENTKs3sQ1dYkgwuimnGtORptXGmOhiAWHH/cNhCp3RVfb+3x5BjeLsBrzDzuMvHfwo7/vRQXQUS9X7nCtqvLP85Ps6XSwMclw1WULi8R2cYAaK+qdYJgtwWdJAjblgShuqY7cgagZGYetoHh+2qs=
Received: from KL1PR03MB7285.apcprd03.prod.outlook.com (2603:1096:820:e2::12)
 by TYUPR03MB7066.apcprd03.prod.outlook.com (2603:1096:400:35a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:45:49 +0000
Received: from KL1PR03MB7285.apcprd03.prod.outlook.com
 ([fe80::ba5c:7633:34e2:ef9a]) by KL1PR03MB7285.apcprd03.prod.outlook.com
 ([fe80::ba5c:7633:34e2:ef9a%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:45:48 +0000
From: =?utf-8?B?VGltIEt1byAo6YOt5bu356yZKQ==?= <Tim.Kuo@mediatek.com>
To: Heiko Schocher <hs@nabladev.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
 =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?= <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH] mtd: spinand: consume an mtd index only on successful
 probe
Thread-Topic: [PATCH] mtd: spinand: consume an mtd index only on successful
 probe
Thread-Index: AQHdXHDP7WwR5r+lIkyxnuSf7ECC8Q==
Date: Thu, 15 Oct 2026 06:45:47 +0000
Message-ID: a769eb356045db102762e265b0d40b1eb1219ddc.camel@mediatek.com
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7285:EE_|TYUPR03MB7066:EE_
x-ms-office365-filtering-correlation-id: 467f093b-52c4-4955-7a09-08df2a87f214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|11063799006|261009223027099003|10067099003|18002099003|3023799007;
x-microsoft-antispam-message-info: dAiCECynT1wx/DZeFVUwPB1f3ZdMo/L8WJVZ64T0cFR2/KhCc2/Zt3uoK+SjyI+yPJ1zR9jcpk2ohQq2Zbh6vXL0Dgyw2EDqJqL/fC+TmG34KBDcnlnX+Fgm8B9t4UkvE8xiBSJrY6IezYL3uewekIAQDS8kH7iY2x7szIYiYEOdBYkjo4lSjN6/9f1VcDLjQzxsMNGhv4h9gwe/lNV+r+/CfQgg+VVfi8KpAoCFN4aIZygzCBGDv8LLIYptgJ0n5LHM5SHZ2PuIVkY2Vp4wdVReBaIoz0pA87TjylYUHcUnEzapygdUMywoh+uoYztdXOBRo8cEBNJLSpJypwuO0aFathFyd44sLhsouo4fY+qasSA7+Ig2XHmOjSKfAqs7TtntVD/kpBFDRSd0gDMC00oWinjk/rJQJxGqXvO0eIbLZsP13zKoS/8v7pvn0EmnIDczfjUB2jpvz1h3bkHZv0ya/tDd7KHK1v3AwDvmGNpZrDJYFLVsCV2q3dy+ZtzSQWqSXUfJ5Fllpm9vWQwvVc/7mM9bT0c8EKFvrsCn361AfFm+Hjrrbut40Gu2LR4IiW8FhDhCSCqnTJqBmRrnpJCOdN7BfF8fhv65cpT2BhcIXlC7AGac61sb0SRkgF0W8+9ErMbExNtIFFMvY6alJqDAlcnnHQ3JlUjOP+tkKPDes3Ze7/b4tuX2a7m6OHefeJ4/Q9ZIF4tyVuf4rap7hXdKdXx539ER0vVAeD9IhAo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB7285.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGRVK3FMVGxFZEx5QVJHMnlJMTNzM1M0dVhYaTYzYTdqMXRGT2w1UkNFSCt3?=
 =?utf-8?B?QjZCUUF2TWc5Q1AzWWNHVjFNSVVibmkrdXBuNTRGKzV4YkZCNExXTjl6ZlFh?=
 =?utf-8?B?MVlWYWhodW96RnU4RFM1cyt3YTdiSXJsQll3eEwxbEFlUFE1ZG5RNll3NGg3?=
 =?utf-8?B?WTlyeFJOR1BJUDZpenNRZ2tReHdUWksrVk1YbzV0ellHaC9ianhFTkZUa0F1?=
 =?utf-8?B?Q2VzTE41OTV2QitVcU5zbDZBdXpCNGptOS9aYTdRd2REcC82UDNtM05qR3pp?=
 =?utf-8?B?eG1HQTErTGxXaU0wVlR4RVBzMGg3b3dHSDF0UFU4bkhFeDFHb3ZxOTJQb0Fx?=
 =?utf-8?B?ODIrQVErbG43OVRya01LQnlUd1FIdlJ3RlhPK1RKUHFPVm10N1lhTk80ekhq?=
 =?utf-8?B?RzlYNXRHaHp1eVk0dWY1QVlNS1FZVStuUTZ1aXZrU1NJSjBsRDM4N3RmMStO?=
 =?utf-8?B?dTAxUmYzdTZMU1JBV25wN1hCK0QwV1QwZ1FKYVllUkZRZkZUSllDWmIzQm5j?=
 =?utf-8?B?OFFzWW1aWERzRk9HWkVyeVNOcHQvZjRjOGhBRmwvY1hLbkVvQlJiWTc2OWxt?=
 =?utf-8?B?a3Bqd0FFQTRzM1VPT3AwVE1vWkR5L2JLYTI2cmtENDYwclJUVG5SYUFHbXV4?=
 =?utf-8?B?bHJHQmJDNGxhWmR6WGlsdWs5c0VJZ21YM1JzV2tqaHBFN0tkMDFvUTQ5NUxq?=
 =?utf-8?B?VUJ6Vmt2eE1DRDhwSTgwdElsTjRSS0dSR05BeXhSSjdiVG5tSFRjOFpkNFZm?=
 =?utf-8?B?ZUFSemFOZzY1WXVCSGJVL1FGaGdlQ3JCSFJVT3I4KzVZb0F1UVZZS0dwNmQz?=
 =?utf-8?B?TVR6NlhoL05naDVwcG1ma0VnZElWa1djNi9ndzJjY0I3azIyLzRwTlo2VE1i?=
 =?utf-8?B?VmQzN01vU3FBb0Z3bTJ4N1p5ZzN4TlREaVZSMUkvRGwxVldhdzFyQUJ6MlJB?=
 =?utf-8?B?T0RKNzZwdFROZHRpd213d3p6VUMrYWJKeFE4bld1RENrRVhSRkNGM0lJTE1Z?=
 =?utf-8?B?TVF6bk5rbG1nSHEwTG9zTHdmb2VLSHdMVjVXQ2creUJ5UElMcUpZQnFmcEph?=
 =?utf-8?B?aWhuS2FoYkN3bUdxT3lFMDJZWm9DNWExVnRKdGkzSlhxbDZLSGZpUEFjczc3?=
 =?utf-8?B?YW55Z1d2WVJLYnVPclk0WlhxdHhHSzhOb1o4V1pnS2F4MXhhalJHYlpMWCtJ?=
 =?utf-8?B?T0FMSmIrVE5QTmU1TGE1UzFaYlNJRGFJT0RwOGpiSDNhbmpZNzhWRTZhTGlq?=
 =?utf-8?B?bEZ3WXJXa0hXVkVHRHVnM0xUNDUzTktpZjhxcm81TUF6YSt4d2NHemRMVGhv?=
 =?utf-8?B?SnlPaFpGZ0tTakpRSjVwSkV0eEcwdGxiOTJDeHErWWpFM2x2bG02VXdzczBy?=
 =?utf-8?B?VFNXS0ZsbmZGZGpqT0h0K3NneW5rSEtMbEtkTHNVek5hbGhKcTVXV0VnQjVD?=
 =?utf-8?B?c1owQTNHdnZGM282WnNJQ0hoUTQ5VzROTUxQK1VHRHlWalIxM25ZWlhuL2lL?=
 =?utf-8?B?MUhXQUYvd0pib1FkWFBNOFZiMHYxY09BTWx2L0VSam51a25tQkhYVFpHMzJY?=
 =?utf-8?B?QUNPd1VSZHdqbzZuczFaL3VtWTkrdEJIYk1ybkJoQkdyMjVnYi8rL2lEa3Uz?=
 =?utf-8?B?ZlhTQWtoc0YxMUhsSEs4UTYzK3F3UlIwYkF3R1ZaVW5Zb0VXcS9wazFFRm0x?=
 =?utf-8?B?akRkQitPQ3NrT1ZVcWFaUnBNRzJkRk5ibWh6N3JxOHJYNTcrWUpzNm0xS29I?=
 =?utf-8?B?bHlQcVJza1BjT29BZ0hhdHZ2WTQxenljd0o4eFEzcE5pNVJVdENaYm9Gd3c0?=
 =?utf-8?B?WGhINTA1Mk0xRUtaV0FWN1g1M1NZVHl1dU1kS2NlcXEwN1dtaG1pUnlZd3RE?=
 =?utf-8?B?UDFkOTdxRjJTdTRsR3BlWjI3b216ZVdWN25pSUF4eVVlTCt3V3M5ejBYSGJR?=
 =?utf-8?B?b0lJSjhUMHlzU0FDT21YK2RXQXpPU0R5cVJMNWg2R0FNbGs2VnBwWlZHRk5N?=
 =?utf-8?B?RU5Kb0RXOHIzbTlzNndrcmNYMjN2MTRFZDVKLzRlNHVEa2h5eW9FVWtkRzNG?=
 =?utf-8?B?UkhVbGViK0RIcGw2SUxscHRuQ3ZtZFBIYXlERDRVSmpha0ZEbm1tWE5McEtt?=
 =?utf-8?B?MktTSDRYSVFka3JQRVhIYkg2OUxzL1ZkT1JaYmFFQ2JjYXBFREVwc0RXaWFU?=
 =?utf-8?B?UnA2Z0c3Z3hUWXR3UkhRcVlteXA1ay9iZkxMalhkc0pYc3drRWZJNWNBYVVl?=
 =?utf-8?B?ZldtT3lsRTBPTjJ4aS9OVndBSFMxVFFNZ3pta25jcWhkQ1JuMUsxMWp5OEpC?=
 =?utf-8?Q?hq4ymfb9YIimYW0E6A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a2sGSsieDyhk3AAROZHj3/jnzm0RbwIGjSeBzssbKS3/ZPUD/3LaNUTMBryYz4k7Jrxx8HYa6BCFXHNKP+nwpIxe6nO8GB4IWv+NiZNTJHGs9BoK9ZPZRqisEdugUjdmExn7ZpZatlsYhoryIr/ToUGUequWO41ZVRC9AeDMHBEn+/RO0d97L17ya/u87hwK+ALtKPXzP8CqLosPu1yJm2QTX9O07p2pahhYOol9XIMzcrmLqIuhjHZp1uXyvpqti47QJvcMYAfHhLwDIo5SyfyFGPAyyxxfbt20lFkinBWonkC3UbrZyIx9DPMJ5IwWY7DIBlQnrO4whil54TNNwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7285.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467f093b-52c4-4955-7a09-08df2a87f214
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:45:48.0224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dd/bBfQEDExsDU5OzpuDW0Yxk3gyWS16misFvIJ2JnG4RNmm5NObXzeNSIJgR2FnYNHhJZT+zOFkIeWCtRmatg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7066
X-MTK: N
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:27:54 +0000
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

T24gV2VkLCAyMDI2LTA5LTE2IGF0IDA3OjAzICswMjAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToK
PiBIZWxsbyBUaW0sCj4gCj4gZHJvcHBlZCB1LWJvb3RAbGlzdHMuZGVueC5kZcKgYW5kIGFkZGVk
Cj4gdS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZwo+IAo+IFBsZWFzZSB1c3QgdGhlIG5l
dyBsaXN0IGZvciBmdXJ0aGVyIHBhdGNoZXMsIHRoYW5rcyEKPiAKPiBPbiAxNC4wOS4yNiAwNToz
MiwgVGltIEt1byB3cm90ZToKPiA+IEZyb206IFRpbSBLdW8gPFRpbS5rdW9AbWVkaWF0ZWsuY29t
Pgo+ID4gCj4gPiBzcGlfbmFuZF9pZHggbnVtYmVycyB0aGUgInNwaS1uYW5kTiIgTVREIG5hbWVz
IGFuZCB3YXMgaW5jcmVtZW50ZWQKPiA+IGluc2lkZQo+ID4gdGhlIHNwcmludGYoKSBiZWZvcmUg
Y2hpcCBoYWQgYmVlbiBpbml0aWFsaXplZCBhbmQgcmVnaXN0ZXJlZC4KPiA+IElmIHNwaW5hbmRf
aW5pdCgpIG9yIGFkZF9tdGRfZGV2aWNlKCkgc3Vic2VxdWVudGx5IGZhaWxzLCB0aGUgaW5kZXgK
PiA+IGlzCj4gPiBjb25zdW1lZCBhbnl3YXkgYW5kIHRoZSBudW1iZXJpbmcgZ2V0cyBhIGhvbGU6
IG9uIGEgYm9hcmQgd2hlcmUgdGhlCj4gPiBmaXJzdAo+ID4gU1BJIE5BTkQgZmFpbHMgdG8gcHJv
YmUsIHRoZSBzZWNvbmQgb25lIGNvbWVzIHVwIGFzICJzcGktbmFuZDEiIGFuZAo+ID4gbm8KPiA+
ICJzcGktbmFuZDAiIGV4aXN0cyBhdCBhbGwuCj4gPiAKPiA+IFRoaXMgcGF0Y2ggd2lsbCBwYXNz
IHRoZSBjdXJyZW50IHZhbHVlIHRvIHNwcmludGYoKSBhbmQgaW5jcmVtZW50Cj4gPiBvbmx5Cj4g
PiBhZnRlciBhZGRfbXRkX2RldmljZSgpIGhhcyBzdWNjZWVkZWQsIHNvIHNwaV9uYW5kX2lkeCBj
b3VudHMgdGhlCj4gPiBTUEkKPiA+IE5BTkQgZGV2aWNlcyBhY3R1YWxseSByZWdpc3RlcmVkIGFu
ZCB0aGUgbmFtZXMgc3RheSBjb250aWd1b3VzCj4gPiBzdGFydGluZwo+ID4gYXQgc3BpLW5hbmQw
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaW0gS3VvIDxUaW0ua3VvQG1lZGlhdGVrLmNvbT4K
PiA+IC0tLQo+ID4gwqAgZHJpdmVycy9tdGQvbmFuZC9zcGkvY29yZS5jIHwgMyArKy0KPiA+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYwo+ID4gYi9kcml2ZXJzL210
ZC9uYW5kL3NwaS9jb3JlLmMKPiA+IGluZGV4IDE0YWY0MjY0NjEyLi4xZmE2NjlmM2RlZiAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYwo+ID4gKysrIGIvZHJpdmVy
cy9tdGQvbmFuZC9zcGkvY29yZS5jCj4gPiBAQCAtMTY5MSw3ICsxNjkxLDcgQEAgc3RhdGljIGlu
dCBzcGluYW5kX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpCj4gPiDCoMKgCW10ZC0+bmFtZSA9
IG1hbGxvYygyMCk7Cj4gPiDCoMKgCWlmICghbXRkLT5uYW1lKQo+ID4gwqDCoAkJcmV0dXJuIC1F
Tk9NRU07Cj4gPiAtCXNwcmludGYobXRkLT5uYW1lLCAic3BpLW5hbmQlZCIsIHNwaV9uYW5kX2lk
eCsrKTsKPiA+ICsJc3ByaW50ZihtdGQtPm5hbWUsICJzcGktbmFuZCVkIiwgc3BpX25hbmRfaWR4
KTsKPiA+IMKgwqAJc3BpbmFuZC0+c2xhdmUgPSBzbGF2ZTsKPiA+IMKgwqAJc3BpbmFuZF9zZXRf
b2Zub2RlKHNwaW5hbmQsIGRldl9vZm5vZGUoZGV2KSk7Cj4gPiDCoCAjZW5kaWYKPiA+IEBAIC0x
NzA5LDYgKzE3MDksNyBAQCBzdGF0aWMgaW50IHNwaW5hbmRfcHJvYmUoc3RydWN0IHVkZXZpY2Ug
KmRldikKPiA+IMKgwqAJCWdvdG8gZXJyX3NwaW5hbmRfY2xlYW51cDsKPiA+IMKgIAo+ID4gwqDC
oAlwbGF0LT5tdGQgPSBtdGQ7Cj4gPiArCXNwaV9uYW5kX2lkeCsrOwo+ID4gwqAgCj4gPiDCoMKg
CXJldHVybiAwOwo+ID4gwqAgCj4gPiAKPiAKPiBSZXZpZXdlZC1ieTogSGVpa28gU2Nob2NoZXIg
PGhzQG5hYmxhZGV2LmNvbT4KPiAKPiBieWUsCj4gSGVpa28KCkhpIGFsbCwKClRoaXMgaXMganVz
dCBhIGdlbnRsZSBwaW5nLgpBbnkgZnVydGhlciBjb21tZW50cy9yZXZpZXdzIGFyZSBhcHByZWNp
YXRlZC4KSXMgdGhpcyBwYXRjaCBhYmxlIHRvIGJlIG1lcmdlZD8KCkJScywKVGltIEt1bwo=
