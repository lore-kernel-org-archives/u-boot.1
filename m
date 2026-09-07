Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6D7C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 03:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A01BD80BCA;
	Mon,  7 Sep 2026 03:48:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7roOnZkWfrM6; Mon,  7 Sep 2026 03:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EFCEA80AC4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788752901;
	b=RvlEkegqtUUmlry6JIJgUp35OWBdeVLbFXnhjtj8EibRXyeqsTvpywBruyRZkpxb5+hW
	 sOTeu3iKBtC+sQ8Y9vclwfr92idhb4vdoM+EDbk3k5PrSdDWU0h9Czvs48u4Oh4mZmziD
	 B6JLpcd6EK/DhnOP63kp3+Fs9d6u5TByMTe7kaffsROwbvnJmfCrZDrGBy37i7h2+okrS
	 qGuC8m1qXg/7aFxbIq2ne+0y7bHfk8DnVN8kA8237BHlilMW7064Wh4asK/GhjjRvDeQS
	 RU8VFwVmqOM2WM8b0uXnrP8x1eE3PY9tVGtdTaS8XkyNUF8L1qwPZMOcka/Qt2gOZ0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788752901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ztWEbJf2mROcLyvSWjSARB/xY9uzOZMR0k3/odKGhWs=;
	b=FgbBYgSWfZDuIojRqKIYs/TMJ+wk1/dVkrWPd8aOD0yvECNuLu7+qx+8pe4QUp31Dbm2
	 C5s9JIIR9PTUbQGIQfPMFVT+aUFc4Z8kzX+PCxgWkbzweWBzWZALVjU2NyoWZw0IQ07so
	 cttnPUPlJrltBlg3LNN/Av2GP7m0wZ5ij+vh0o0daAqyQq13JnWUfKg3YETHWP6w5RBYD
	 sgeHT839CuxH8g30o2VpMLjlaXfDWu3f91B1qquOndcLSYf2KGu1LM/ZFQUpCPVNOP4Yb
	 e+8sW1jDXgT7Qeg0wkQag5wXZwd1LGAC2LPkiBDRP1SAtqABstcSvvnEjTsE1rfpGEQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788752901;
	bh=ztWEbJf2mROcLyvSWjSARB/xY9uzOZMR0k3/odKGhWs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnxMg18gclLoiuq42l2T4fh6upmqHKfBo930w4zqxe8pdnhe8DLqX8zU7Mrljv04s
	 wmV23YpT/5NL59owAxDINBGAEqD2SDjjU9jTOtwIPngAK9Bz/XaRpcDoQKYSuY/Whp
	 2RAhXZYXUO4e/B5JGbHW1KpqRw+BKyqK3SUrYAvggQFCycnooCw169ENsb9vzOGfGB
	 U3eKqJuR9U4VAM4cSP+BpOnX5X6YJhhXjwf+K95t/zQYj6CrE51/Q3StGutu+eL1DS
	 gM8Tp/RNcJmAQ18X3NV5JC3UZzbHfJhh3EAtcomMRP5QGI01zI1shYHYFEQjDeeZVE
	 oQyikr5trpLIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFCEA80AC4;
	Mon,  7 Sep 2026 03:48:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3204990
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 03:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E06AE40580
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 03:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LnyJ7y3zMWhd for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 03:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B321040560
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788752898;
 b=L7fh9R73dQ/MbUgEE52k6evzyPjsK8wnNiJ9TzZo8FMPSYfxD8++N2Llidytxp6yF0fS
 LqU4iizo4lVsaDPcaErqBJbVwM5F0ePznCuY+wgIXkA+e7rn7Y2lE1J/2XN6JizK+kOUq
 aqqPeLh7dWK6ZQmDumLMTzKKQ8YKLK/a20ZVQxGOB1DKei0Fz7EZV5XBgeG4yztXgOo3/
 kUburgVCOuwa55a3r2Td6P6h5LLlht+PB+j65aOr15FVKWagNNwzBH7kfvTEgh89X8hxq
 Pjk8YmoFAD9qmgxyEkpC5ruygUZOJj0Zz1e4bgN75VGrwfic8x+WksjSozFaWyIZN3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788752898;
 h=X-Greylist:Received-SPF:X-UUID:DKIM-Signature:X-CID-P-RULE:
 X-CID-O-INFO:X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:
 X-UUID:Received:Received:Received:DKIM-Signature:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
 x-ld-processed:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-ID:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:Content-Type;
 bh=ztWEbJf2mROcLyvSWjSARB/xY9uzOZMR0k3/odKGhWs=;
 b=nf8Iijz++ZWe8NX3DsfH5Q+mDp4o/J0SzRrzEpb9w6GbIMSzHdKpJu8+jL5t9VmToER+
 w1TgOiKAUX9cLTeP7HqEzbRZcCI2rColoInQISiHfzBhoC0rjZstnvtiGI7S1s6TSHINc
 wNRqd+XaEF0MvT0Uwz/5DRpVqgXwicy3FL+eMJe7NCxDr05Jag9e+rdK/gNP8AeY0s9EU
 tesktWHWSFlrxg8zcSTLqBpR20LRqriGLk+DKDehGXAUl+YrMPawOtt1Ut8i/4GpvImg6
 PSDVShHf56o/ZkpPFQ3FrgTUFCtVmI6RsWpMipFFOEKaxtnywzsr1GW5CyUV1w1O9Iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=mediatek.com; 
 dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=HIPIuw50; 
 dkim=fail reason="signature verification failed"
 header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com
 header.b=B7DgH0gp; 
 arc=fail smtp.remote-ip=60.244.123.138
X-Greylist: delayed 163 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 07 Sep 2026 03:48:15 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=mediatek.com
 header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=HIPIuw50; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=mediateko365.onmicrosoft.com
 header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-mediateko365-onmicrosoft-com header.b=B7DgH0gp
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=macpaul.lin@mediatek.com;
 receiver=<UNKNOWN> 
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B321040560
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 03:48:15 +0000 (UTC)
X-UUID: f187c64aaa6e11f1b1788b6acf885367-20260907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ztWEbJf2mROcLyvSWjSARB/xY9uzOZMR0k3/odKGhWs=; 
 b=HIPIuw50Zf+ctY/Uvv72nHjFUBkuxfjLbhhkhtsGFlLY2QBFTIFhOtlvfCTC94/yqj9UtxyqDg0nN5YA0mjbOZo3gw14JLa2NZmioQ/4lD5HoGpwJpd2Kjfk756RwuK6VbBLpsYbDvaxOGcmuuV59JKyS1ulEAOdwqP+CnnA1bM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:f607b3ec-c3dc-43c4-b36a-32f2348323bb, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:a1da9723-5869-48e3-bf78-b0f483615649,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f187c64aaa6e11f1b1788b6acf885367-20260907
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1163893566; Mon, 07 Sep 2026 11:48:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 7 Sep 2026 11:48:08 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 7 Sep 2026 11:48:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY0AAyoqv/0IN1byhYJLumstWwgQGnJtt8R79E7EAF0CDLyRuTjgoZk5Ohfx0sXNlWraCn1bsChPl0degU1VrV/sMiqso/eJVigFkIcD7IO9t1Df149CbSln+2FJNShWv0KgJOuYO5Be6IddqLGU9jASrF9UZKP0xq66D9ecJt5RAUAcPhGVghZmHxumk5wVSNr2qv5CVHu2WFbpe0JB6S+bsKdd5yV02krAohTbEWS8yoD9oFrIDq5I+JPJTXjdHaeiXaGSX2nI8cl4UKiwnB8hcMj1xXOfOxr0BSdx2R0nF1LF8yfnupvvSoD1oYM7UN8ix5zX1rGs9ZGbY4lMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BrV9z0WmNLSEcztKJZLc2QxA58msGBM0bvEUDftwM4=;
 b=HmX779p6bVpmWkXR7jfgP6pjmFf6HZJmwJ8v+RykWeZCFgzaYwATSVwRZjwW5ke1rQ8c6fFzBwhf/GVEU+CAZraAj9l/D52cckVq1Nm1WOAJaP1xbaZainmABnPmd/jE/Voe9NwGTg5ESifxnrn+FgjUBAKtKpiy9t+8WXYub+6fV0+ptvhk/U3lB6vGlrwuqpxtlWWINWHTREO43mHm00hi7LWa8Q19dBV/ncGvXNMvMxWSSivTfQNg1pWoUJKK1VzCSxnWpqWqqoLXnt2lzDtrFZoJSkLJVV/EY3sk5+XZsHMLZ3gDgtNs1ShoufblaFMgo0mWWbc8QlsakKTSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BrV9z0WmNLSEcztKJZLc2QxA58msGBM0bvEUDftwM4=;
 b=B7DgH0gpMDrkHk8jjDsEWrqG+ZvZ+MACDmCq/x8L1o8qqujuabJu7SNZ++qwM8jwa+4cmKzh4bejwS4qLZSK2AaYPmnBJEzOhOT+Re8r+F+ViJM5OjHeqHgELulSFCznr6EYklT5AFIQy9lTqWyeYyF4dDu6ohOeB86R8FA0DTw=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB7713.apcprd03.prod.outlook.com (2603:1096:990:a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:48:02 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:48:02 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Carlo Caione <ccaione@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, Julien Stephan <jstephan@baylibre.com>, "Vitor
 Sato Eschholz" <vsatoes@baylibre.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "trini@konsulko.com"
 <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, Arnaud Ferraris
 <arnaud.ferraris@collabora.com>, =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?=
 <Ht.Lin@mediatek.com>, David Lechner <dlechner@baylibre.com>,
 "u-boot@0leil.net" <u-boot@0leil.net>, "jbx6244@gmail.com"
 <jbx6244@gmail.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "bastien.curutchet@bootlin.com"
 <bastien.curutchet@bootlin.com>, Suhrid Subramaniam
 <Suhrid.Subramaniam@mediatek.com>, "alchark@gmail.com" <alchark@gmail.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>
Subject: Re: [PATCH v6 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
Thread-Topic: [PATCH v6 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
Thread-Index: AQHdPhTAaelT4395K027Q0nq2lDQarbCezEA
Date: Mon, 7 Sep 2026 03:48:02 +0000
Message-ID: <8885a203e468ed863adcb8c9edc6adb9ff94f827.camel@mediatek.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB7713:EE_
x-ms-office365-filtering-correlation-id: 5efd8713-ceea-4063-4a0e-08df0c92d11b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: LNz3s4ssJPDUATFKcR4F5qCJfiixYAEW9A9DU0YAx5OWSN/Uo1qFsQGuz+MwlvpCuEZHhLYZtpITPp/vXIjFqMZmrJO1tHsTguBHyeopgJpQbSI83/ZsEWsVgJS/osakaoDj7O9GRj/SpxscpAnSGnOPDySp0tyOT//L4QiIRbavqqY33a4mYD3hUI+pMtoh6WgCmiT3zr1uSvog6Pd8RgfVhDrlxnLcFxSTeZG/g07KKKlwdqmx73DPTBTZxlXmU5hKbkmycjs6t1YCgtm7qAUA+8V9NWhJ2/fA0SClxVO/9MOrWBVDmhBfI7KPgi/BvyMURyymPHbcekp3ZLn6X7GrBs16p1rJBzwIl8/hdFnbkJw7wZYT3300AFoD45OLeImzVRiucq5Cpdp528hmwnQqoLWl/y65SDZBrzk83EhxQ2V5EaEbeP203d0rWnh4OAn9OZqESV42xCL2jEYt6r71POpnCxLY9DOmGbokyFVehhOGmj9ZypE1jbykXYT0i37HdJOqiPxh3iCRMAcE4UskN9VgmeJR4/XUJORFmCi9JEEggBn4xl5+4d7dImxUqHYrpi1zJo0Y34bjNWc3kwmfKr880gJ2iKjLg3Ek4Mar9GGadAvk3LObiJ/rbF55S+U86d6MTKKYlcLhExbrQ2Ii5fDU7u9tCZzEAo/527DdVyVcnA3OlNDXvOwVszhtN8LDXD1q7zJQtjupG5UyR6oT1ItpK5VD+MIT07bpyI4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHlWZVBSWFlGalJya29kVTNhZUZTTTNnVHRqRjQwdFFJbTlOejJTQldUbk5v?=
 =?utf-8?B?ZFJMYkNhYm4xYy9raHJhbWJOSFBpS2lTYlRyUS8ycnUwS0NhNHJVZk9maEUv?=
 =?utf-8?B?bHp4VXVBdUlESGpWaG8vSjB0cTZYWlA4WFdwY3BCaUZ6ald1bi9MaERQVmQr?=
 =?utf-8?B?Q3BxejlGVTRsMFpIN1RUTEY3bFlsZERjTzFIM2J5UUFDREFXS1RQUlIrZnpq?=
 =?utf-8?B?ZnZjQlF1K0hYMU1KQnRpU1hhTVpkaklQREVxZGR4Uk8vYWNQN3FEYytIdzZy?=
 =?utf-8?B?Q0dWb0lNd0RhRkpCa0xHUGJXV3VDZE92ZDdVVFMvdi94a2RoMmwzTDgyQ3FD?=
 =?utf-8?B?MXdZMjNYa0FrQUpwdCtTamR6bElZbGVQVzQwTnlBL00rblNzVktuWVY5QTFG?=
 =?utf-8?B?V2REOHREMGlLL3QrK3NRcEpUZ3ludFpmTzVjbURJQ3EybDA5WStQcXhsdVU0?=
 =?utf-8?B?Zmt5M2p2b3ZjUkwzcElxVVY5WFc0K2txcmgvMng5cEJSTDJaU2NDZUJSYmNC?=
 =?utf-8?B?QVpmQjRBa3JYZjBoVHJWMVhTRk1XdGU3S0Q5MVFvaWd5cFl5ODZqS2tPRC9a?=
 =?utf-8?B?cE9FWjhXYkpkRGFxSlkrQktEbXhoZDlFVzNteXVaWmMzOWNGYVE4eHdVc2JF?=
 =?utf-8?B?Rm41cDgrY0pwWC8zS0djcUpoWWM2ZFZFVjkyMzFzQTVFSnkwUzl4Q2R2ZHNl?=
 =?utf-8?B?S01GajBGTUVKOURBMUMxYk82bU9qaUZvZXBIYlc4MVZiMHdpMWVxWEFSMDBP?=
 =?utf-8?B?N2pUZlZWYmU0b29IS1JSdFJEYkxpS201ME5GZHB4cjNJd2ZqQzEyRm1lTkE5?=
 =?utf-8?B?OHNIVU9vZmVSeGZQdHpiTTZ6alV2eTZIVGpWL0JKVkV1WW55T3dVV1ZnUWlw?=
 =?utf-8?B?d25mOHhsY1UrOHdRbUtNVXExczNLU2owMGxJeFRNQ1BENUl2L3lheHE3NlNr?=
 =?utf-8?B?Wk1OZkZqRnZTeFUyOWhhcTZZeDljWFU5OC91RVB3ZElJendDdGllMzk5OUlP?=
 =?utf-8?B?N1gyWmhoM3BlMzlpeFQ4Qzk0SGJSNTRZOWZNRjhXOEFZbWlPa2Y2VlFlcnBu?=
 =?utf-8?B?a0JWVFA3NGZ0K0haSng2SS9hYkFLTTE5T3V4ZXVSbXBQaWxVY2NHU250ZFZZ?=
 =?utf-8?B?OFNLejQ1ODhNZzdVV3ZVeDRGeXFyNnRPUEh0ZFd3emYvMmtrSWgrdHJENi9n?=
 =?utf-8?B?MVdEd3dXNUkrc29vMU5aU1AxZXdPM1hQWFowOWpZd3A2UFRzbEsxWHNsSVlt?=
 =?utf-8?B?WkUrbWRFSVE2TVRMWnZJcXJWMUFpaTBUaU9CV2VnbFNGaHNneDdOQUVaY0VC?=
 =?utf-8?B?T1cwYlZjY0NkbHY2eWVrMTJpVkJOQ25HTHljQUp0T1hDejdwdlU4V2NMaHZv?=
 =?utf-8?B?Ly9hQm9ScUJtdVJGTU80UXU1N0Myd1lyNHYzbjhDbDlYMitHUjJZUmt4N1hp?=
 =?utf-8?B?T0YxWDBvaGNHakU0dVZFaWd3WXZYODRiZUhreVp2TGhCbWFEWGVxUEVvV0o5?=
 =?utf-8?B?UnFydFE5RklvanA1dmgvd3BVdG5zdGtsc0hmQlVaaVJBblZwbVFMeXhMckhi?=
 =?utf-8?B?ZmQyMk95bC8ycU43MnVrUnBXTjBxVHA5R05XMXZoK25RcHRnQzBUMFNSV3dW?=
 =?utf-8?B?ZVMrSDJja1lReFg0MmgrMmM5SVJVdUFaUnVKQXRrR2dodjltd0tCcEprZlJy?=
 =?utf-8?B?ZVdYK0lLZFZ2V2ZsUzFDYnlhbnJnWDZkMnd3U1NrRnpDTGtSNFhuOHFRd1pL?=
 =?utf-8?B?TmFGZ09BQ0JvemdudHpoamZqMVd3T3BjTmFaOVdNOFFkWUJoNHNTRU4xemlL?=
 =?utf-8?B?cks3N2pzaFpzRnhHeUFhamJJVUZtT25pb1NLeXBmOWJROUVjeWNCaS9xcEUw?=
 =?utf-8?B?YTNlcU1JaDRvQndwditDS0daWEc5WjhaQ05ja2pkMDVNK1EyRmpPRUt2TnBN?=
 =?utf-8?B?VUJ5THNwdGdqVzFHb0JCNG1tbUNnN25kRlZPS3VZRk00RjBYd0ZiV3dabmJK?=
 =?utf-8?B?OWUwSVhXbG5hWUZVbEtCYURVV1lRTEl2R0c4U1BvWTZIdnRyUlhjNXYyWVpS?=
 =?utf-8?B?OXJtVDZ1a2M3YmdvZHNENTlmVGZhcVVzWlA4bVZNRmlJd1VkU1RjYXVZQ2pH?=
 =?utf-8?B?Q1lDNjJrbmJsN1hvNDdDZmc4WGg5Z1B2Y0ViU3cxOHBvR3RBb1IwM0lXTmhY?=
 =?utf-8?B?SVN0eXgwQURoY3Y5OUVuUEp4TUNuWHlTMVZZdTJYMDZCRGNmOENEa1NPWmFD?=
 =?utf-8?B?d08xa1JEUnBhWEVJbFliMC9Ed3R4QklwKzlyNytjV3NIc1M2SmJnejRuN3VM?=
 =?utf-8?B?RFVQV01DK2V0d25pcDBuSUJYUzdITEtyc004RkZLV1k4M0p2dFpYU1ZieHV4?=
 =?utf-8?Q?H84nSy/CwoV6+Jog=3D?=
Content-ID: <17D86E870037B44AB6B6FAE3EA3B3E17@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I7p9jGECusqGDYgr3/81MKaR1ryrSlDoLjmqVlqZD5e2Hjq2iSzhU9qknJBSlqhJD3FvFzL+QRhgV7SLaT2r9RL6sHWUQWRaSPrrLDzcTtjeetnsKNErz/Nxz6+lYSARr0g7IETOUVmKEKFmchcgblD8j6olHh/4/DABnt8JA41OuNA6ON6FFzw3Kh9wt303wkpe3y/nG3DnCubL28Jke9IpBRoHn/cNoZaHdub9TwU3TN1xYTVM3fv9THYkcfgUoCItaJ+Y7grvXxHaqd4FINh34lMINQHuKTg15u6Xw/qxO5Fqvk2WwD/fcSL6gEwHN3xRdvoiHLz9mjIdCz2pKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efd8713-ceea-4063-4a0e-08df0c92d11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 03:48:02.2321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgqX8+n6UbKFXHmH9S/TFQycTOktkfIZiQxs6JEL9ZNwrBukXkR8unb4dUUZB4HAF5FvM2JT5v+GjcXd8hsGId8hJas7JMSjellsYRB8vdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7713
Content-Type: multipart/alternative;
 boundary="__=_Part_Boundary_001_1938672625.237811227"
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

--__=_Part_Boundary_001_1938672625.237811227
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T24gU3VuLCAyMDI2LTA5LTA2IGF0IDE3OjMwICswMjAwLCBDYXJsbyBDYWlvbmUgd3JvdGU6DQo+
IERvY3VtZW50IHRoZSBjb21tb24gR2VuaW8gNTEwIGFuZCBHZW5pbyA3MDAgZU1NQyBib290IGNo
YWluLA0KPiBib2FyZC1zcGVjaWZpYyBleHRlcm5hbCBmaXJtd2FyZSBwcmVyZXF1aXNpdGVzLCBi
aW5tYW4gYnVpbGQNCj4gaW52b2NhdGlvbg0KPiBhbmQgZ2VuZXJhdGVkIGltYWdlcy4NCj4gDQo+
IERlZmluZSB0aGUgYmluYXJ5IGxheW91dCBhbmQgZXhlY3V0aW9uLXN0YXRlIEFCSSBiZXR3ZWVu
IGFuIGV4dGVybmFsDQo+IEREUg0KPiBsb2FkZXIgYW5kIFNQTCB1c2luZyB0aGUgY29ycmVzcG9u
ZGluZyBLY29uZmlnIHN5bWJvbHMuIERpZmZlcmVudA0KPiBsb2FkZXINCj4gaW1wbGVtZW50YXRp
b25zIHJlbWFpbiBjb21wYXRpYmxlIHdoZW4gdGhleSBzYXRpc2Z5IHRoaXMgY29udHJhY3QuDQo+
IEFsc28NCj4gcmVxdWlyZSBmaXJtd2FyZSBoYW5kZWQgdG8gdGhlIFJBTSBTUEwgbG9hZGVyIHRv
IGJlIGEgZGlyZWN0bHkNCj4gcGFyc2VhYmxlDQo+IEZJVCByYXRoZXIgdGhhbiBhIGNvbXByZXNz
ZWQgRklUIGNvbnRhaW5lci4NCj4gDQo+IERlc2NyaWJlIEZJVCBzaWduaW5nLCBzdG9yYWdlIG1h
cHBpbmcgYW5kIGluc3RhbGxhdGlvbiB3aXRoIEdlbmlvDQo+IFRvb2xzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2FybG8gQ2Fpb25lIDxjY2Fpb25lQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKg
Ym9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCAxICsNCj4gwqBkb2MvYm9hcmQvbWVkaWF0ZWsvaW5kZXgucnN0wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAxICsNCj4gwqBkb2MvYm9hcmQvbWVkaWF0ZWsvbXQ4MTg4LWdlbmlvLWV2ay5y
c3QgfCAyNzQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAzIGZpbGVz
IGNoYW5nZWQsIDI3NiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvbWVk
aWF0ZWsvTUFJTlRBSU5FUlMgYi9ib2FyZC9tZWRpYXRlay9NQUlOVEFJTkVSUw0KPiBpbmRleCA1
N2JiMzA5NTMwNS4uYWE4NjJhNGUxZWEgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL21lZGlhdGVrL01B
SU5UQUlORVJTDQo+ICsrKyBiL2JvYXJkL21lZGlhdGVrL01BSU5UQUlORVJTDQo+IEBAIC0zMCw2
ICszMCw3IEBAIEY6CWFyY2gvYXJtL2R0cy9tdDgzOTAtZ2VuaW8tNzAwLWV2ay11LQ0KPiBib290
LmR0c2kNCj4gwqBGOgljb25maWdzL210ODE4OC5jb25maWcNCj4gwqBGOgljb25maWdzL210ODM3
MF9nZW5pb181MTBfZXZrX2RlZmNvbmZpZw0KPiDCoEY6CWNvbmZpZ3MvbXQ4MzkwX2dlbmlvXzcw
MF9ldmtfZGVmY29uZmlnDQo+ICtGOglkb2MvYm9hcmQvbWVkaWF0ZWsvbXQ4MTg4LWdlbmlvLWV2
ay5yc3QNCj4gwqANCj4gwqBNVDgxOTUvTVQ4Mzk1DQo+IMKgTToJTWFjcGF1bCBMaW4gPE1hY3Bh
dWwuTGluQG1lZGlhdGVrLmNvbT4NCj4gZGlmZiAtLWdpdCBhL2RvYy9ib2FyZC9tZWRpYXRlay9p
bmRleC5yc3QNCj4gYi9kb2MvYm9hcmQvbWVkaWF0ZWsvaW5kZXgucnN0DQo+IGluZGV4IGM1NWQ1
YWViNWM0Li43Y2ExYmQ5ZmRlMiAxMDA2NDQNCj4gLS0tIGEvZG9jL2JvYXJkL21lZGlhdGVrL2lu
ZGV4LnJzdA0KPiArKysgYi9kb2MvYm9hcmQvbWVkaWF0ZWsvaW5kZXgucnN0DQo+IEBAIC03LDMg
KzcsNCBAQCBNZWRpYXRlaw0KPiDCoMKgwqAgOm1heGRlcHRoOiAyDQo+IMKgDQo+IMKgwqDCoCBt
dDc2MjENCj4gK8KgwqAgbXQ4MTg4LWdlbmlvLWV2aw0KPiBkaWZmIC0tZ2l0IGEvZG9jL2JvYXJk
L21lZGlhdGVrL210ODE4OC1nZW5pby1ldmsucnN0DQo+IGIvZG9jL2JvYXJkL21lZGlhdGVrL210
ODE4OC1nZW5pby1ldmsucnN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAwLi45MGJkZDVjYzNjOA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RvYy9ib2FyZC9t
ZWRpYXRlay9tdDgxODgtZ2VuaW8tZXZrLnJzdA0KPiBAQCAtMCwwICsxLDI3NCBAQA0KPiArLi4g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKy4uIENvcHlyaWdo
dCAoQykgMjAyNiBCYXlMaWJyZSBTQVMNCj4gKw0KPiArTWVkaWFUZWsgR2VuaW8gNTEwIGFuZCBH
ZW5pbyA3MDAgRVZLcw0KPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gDQoNCltzbmlwLi4uXQ0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGlu
QG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg0K

--__=_Part_Boundary_001_1938672625.237811227
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+PGJvZHk+PHA+DQo8cHJlPg0KT24mIzMyO1N1biwmIzMyOzIwMjYtMDktMDYmIzMyO2F0
JiMzMjsxNzozMCYjMzI7KzAyMDAsJiMzMjtDYXJsbyYjMzI7Q2Fpb25lJiMzMjt3cm90ZToNCiZn
dDsmIzMyO0RvY3VtZW50JiMzMjt0aGUmIzMyO2NvbW1vbiYjMzI7R2VuaW8mIzMyOzUxMCYjMzI7
YW5kJiMzMjtHZW5pbyYjMzI7NzAwJiMzMjtlTU1DJiMzMjtib290JiMzMjtjaGFpbiwNCiZndDsm
IzMyO2JvYXJkLXNwZWNpZmljJiMzMjtleHRlcm5hbCYjMzI7ZmlybXdhcmUmIzMyO3ByZXJlcXVp
c2l0ZXMsJiMzMjtiaW5tYW4mIzMyO2J1aWxkDQomZ3Q7JiMzMjtpbnZvY2F0aW9uDQomZ3Q7JiMz
MjthbmQmIzMyO2dlbmVyYXRlZCYjMzI7aW1hZ2VzLg0KJmd0OyYjMzI7DQomZ3Q7JiMzMjtEZWZp
bmUmIzMyO3RoZSYjMzI7YmluYXJ5JiMzMjtsYXlvdXQmIzMyO2FuZCYjMzI7ZXhlY3V0aW9uLXN0
YXRlJiMzMjtBQkkmIzMyO2JldHdlZW4mIzMyO2FuJiMzMjtleHRlcm5hbA0KJmd0OyYjMzI7RERS
DQomZ3Q7JiMzMjtsb2FkZXImIzMyO2FuZCYjMzI7U1BMJiMzMjt1c2luZyYjMzI7dGhlJiMzMjtj
b3JyZXNwb25kaW5nJiMzMjtLY29uZmlnJiMzMjtzeW1ib2xzLiYjMzI7RGlmZmVyZW50DQomZ3Q7
JiMzMjtsb2FkZXINCiZndDsmIzMyO2ltcGxlbWVudGF0aW9ucyYjMzI7cmVtYWluJiMzMjtjb21w
YXRpYmxlJiMzMjt3aGVuJiMzMjt0aGV5JiMzMjtzYXRpc2Z5JiMzMjt0aGlzJiMzMjtjb250cmFj
dC4NCiZndDsmIzMyO0Fsc28NCiZndDsmIzMyO3JlcXVpcmUmIzMyO2Zpcm13YXJlJiMzMjtoYW5k
ZWQmIzMyO3RvJiMzMjt0aGUmIzMyO1JBTSYjMzI7U1BMJiMzMjtsb2FkZXImIzMyO3RvJiMzMjti
ZSYjMzI7YSYjMzI7ZGlyZWN0bHkNCiZndDsmIzMyO3BhcnNlYWJsZQ0KJmd0OyYjMzI7RklUJiMz
MjtyYXRoZXImIzMyO3RoYW4mIzMyO2EmIzMyO2NvbXByZXNzZWQmIzMyO0ZJVCYjMzI7Y29udGFp
bmVyLg0KJmd0OyYjMzI7DQomZ3Q7JiMzMjtEZXNjcmliZSYjMzI7RklUJiMzMjtzaWduaW5nLCYj
MzI7c3RvcmFnZSYjMzI7bWFwcGluZyYjMzI7YW5kJiMzMjtpbnN0YWxsYXRpb24mIzMyO3dpdGgm
IzMyO0dlbmlvDQomZ3Q7JiMzMjtUb29scy4NCiZndDsmIzMyOw0KJmd0OyYjMzI7U2lnbmVkLW9m
Zi1ieTomIzMyO0NhcmxvJiMzMjtDYWlvbmUmIzMyOyZsdDtjY2Fpb25lQGJheWxpYnJlLmNvbSZn
dDsNCiZndDsmIzMyOy0tLQ0KJmd0OyYjMzI7JiMxNjA7Ym9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5F
UlMmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsm
IzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzMyO3wmIzE2MDsmIzE2MDsmIzMyOzEmIzMyOysNCiZn
dDsmIzMyOyYjMTYwO2RvYy9ib2FyZC9tZWRpYXRlay9pbmRleC5yc3QmIzE2MDsmIzE2MDsmIzE2
MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzMyO3wm
IzE2MDsmIzE2MDsmIzMyOzEmIzMyOysNCiZndDsmIzMyOyYjMTYwO2RvYy9ib2FyZC9tZWRpYXRl
ay9tdDgxODgtZ2VuaW8tZXZrLnJzdCYjMzI7fCYjMzI7Mjc0DQomZ3Q7JiMzMjsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KJmd0OyYjMzI7JiMxNjA7MyYjMzI7ZmlsZXMmIzMyO2No
YW5nZWQsJiMzMjsyNzYmIzMyO2luc2VydGlvbnMoKykNCiZndDsmIzMyOw0KJmd0OyYjMzI7ZGlm
ZiYjMzI7LS1naXQmIzMyO2EvYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMmIzMyO2IvYm9hcmQv
bWVkaWF0ZWsvTUFJTlRBSU5FUlMNCiZndDsmIzMyO2luZGV4JiMzMjs1N2JiMzA5NTMwNS4uYWE4
NjJhNGUxZWEmIzMyOzEwMDY0NA0KJmd0OyYjMzI7LS0tJiMzMjthL2JvYXJkL21lZGlhdGVrL01B
SU5UQUlORVJTDQomZ3Q7JiMzMjsrKysmIzMyO2IvYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMN
CiZndDsmIzMyO0BAJiMzMjstMzAsNiYjMzI7KzMwLDcmIzMyO0BAJiMzMjtGOmFyY2gvYXJtL2R0
cy9tdDgzOTAtZ2VuaW8tNzAwLWV2ay11LQ0KJmd0OyYjMzI7Ym9vdC5kdHNpDQomZ3Q7JiMzMjsm
IzE2MDtGOmNvbmZpZ3MvbXQ4MTg4LmNvbmZpZw0KJmd0OyYjMzI7JiMxNjA7Rjpjb25maWdzL210
ODM3MF9nZW5pb181MTBfZXZrX2RlZmNvbmZpZw0KJmd0OyYjMzI7JiMxNjA7Rjpjb25maWdzL210
ODM5MF9nZW5pb183MDBfZXZrX2RlZmNvbmZpZw0KJmd0OyYjMzI7K0Y6ZG9jL2JvYXJkL21lZGlh
dGVrL210ODE4OC1nZW5pby1ldmsucnN0DQomZ3Q7JiMzMjsmIzE2MDsNCiZndDsmIzMyOyYjMTYw
O01UODE5NS9NVDgzOTUNCiZndDsmIzMyOyYjMTYwO006TWFjcGF1bCYjMzI7TGluJiMzMjsmbHQ7
TWFjcGF1bC5MaW5AbWVkaWF0ZWsuY29tJmd0Ow0KJmd0OyYjMzI7ZGlmZiYjMzI7LS1naXQmIzMy
O2EvZG9jL2JvYXJkL21lZGlhdGVrL2luZGV4LnJzdA0KJmd0OyYjMzI7Yi9kb2MvYm9hcmQvbWVk
aWF0ZWsvaW5kZXgucnN0DQomZ3Q7JiMzMjtpbmRleCYjMzI7YzU1ZDVhZWI1YzQuLjdjYTFiZDlm
ZGUyJiMzMjsxMDA2NDQNCiZndDsmIzMyOy0tLSYjMzI7YS9kb2MvYm9hcmQvbWVkaWF0ZWsvaW5k
ZXgucnN0DQomZ3Q7JiMzMjsrKysmIzMyO2IvZG9jL2JvYXJkL21lZGlhdGVrL2luZGV4LnJzdA0K
Jmd0OyYjMzI7QEAmIzMyOy03LDMmIzMyOys3LDQmIzMyO0BAJiMzMjtNZWRpYXRlaw0KJmd0OyYj
MzI7JiMxNjA7JiMxNjA7JiMxNjA7JiMzMjs6bWF4ZGVwdGg6JiMzMjsyDQomZ3Q7JiMzMjsmIzE2
MDsNCiZndDsmIzMyOyYjMTYwOyYjMTYwOyYjMTYwOyYjMzI7bXQ3NjIxDQomZ3Q7JiMzMjsrJiMx
NjA7JiMxNjA7JiMzMjttdDgxODgtZ2VuaW8tZXZrDQomZ3Q7JiMzMjtkaWZmJiMzMjstLWdpdCYj
MzI7YS9kb2MvYm9hcmQvbWVkaWF0ZWsvbXQ4MTg4LWdlbmlvLWV2ay5yc3QNCiZndDsmIzMyO2Iv
ZG9jL2JvYXJkL21lZGlhdGVrL210ODE4OC1nZW5pby1ldmsucnN0DQomZ3Q7JiMzMjtuZXcmIzMy
O2ZpbGUmIzMyO21vZGUmIzMyOzEwMDY0NA0KJmd0OyYjMzI7aW5kZXgmIzMyOzAwMDAwMDAwMDAw
Li45MGJkZDVjYzNjOA0KJmd0OyYjMzI7LS0tJiMzMjsvZGV2L251bGwNCiZndDsmIzMyOysrKyYj
MzI7Yi9kb2MvYm9hcmQvbWVkaWF0ZWsvbXQ4MTg4LWdlbmlvLWV2ay5yc3QNCiZndDsmIzMyO0BA
JiMzMjstMCwwJiMzMjsrMSwyNzQmIzMyO0BADQomZ3Q7JiMzMjsrLi4mIzMyO1NQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiYjMzI7R1BMLTIuMC1vci1sYXRlcg0KJmd0OyYjMzI7Ky4uJiMzMjtDb3B5
cmlnaHQmIzMyOyhDKSYjMzI7MjAyNiYjMzI7QmF5TGlicmUmIzMyO1NBUw0KJmd0OyYjMzI7Kw0K
Jmd0OyYjMzI7K01lZGlhVGVrJiMzMjtHZW5pbyYjMzI7NTEwJiMzMjthbmQmIzMyO0dlbmlvJiMz
Mjs3MDAmIzMyO0VWS3MNCiZndDsmIzMyOys9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KJmd0OyYjMzI7DQoNCltzbmlwLi4uXQ0KDQpSZXZpZXdlZC1ieTomIzMyO01hY3Bh
dWwmIzMyO0xpbiYjMzI7Jmx0O21hY3BhdWwubGluQG1lZGlhdGVrLmNvbSZndDsNCg0KVGhhbmtz
IQ0KTWFjcGF1bCYjMzI7TGluDQoNCg0KPC9wcmU+DQo8L3A+PC9ib2R5PjwvaHRtbD48IS0tdHlw
ZTp0ZXh0LS0+PCEtLXstLT48cHJlPioqKioqKioqKioqKiogTUVESUFURUsgQ29uZmlkZW50aWFs
aXR5IE5vdGljZQ0KICoqKioqKioqKioqKioqKioqKioqDQpUaGUgaW5mb3JtYXRpb24gY29udGFp
bmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkgDQphdHRhY2htZW50cykg
bWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVyd2lz
ZQ0KZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxlIGxhd3MuIEl0IGlzIGlu
dGVuZGVkIHRvIGJlIA0KY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQo
cykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIA0KZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0
YWluaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgDQphdHRhY2ht
ZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBh
bmQgbWF5IA0KYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVu
dCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZQ0KIA0KdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0
aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIA0KaW1tZWRpYXRl
bHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGll
cyBvZiANCnRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIg
c3lzdGVtLCBhbmQgZG8gbm90DQpkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0
byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo8L3ByZT48IS0tfS0tPg==

--__=_Part_Boundary_001_1938672625.237811227--

