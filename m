Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7D8C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 04:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A160480BE9;
	Mon,  7 Sep 2026 04:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3nydAAzsaHgJ; Mon,  7 Sep 2026 04:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A9CB80BD6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788753702;
	b=eIOMF7nOEvxr0qKji97APhL8uqZZIZZtZd1+Vfncq8EVunVePdwINMgKRmjp9LM0cIJ5
	 3r/tNJ9rV1BviZSmwcOIVgl0rgRGC+6XHNzG4qT6eqxpfQ3pA3gSRyiPBjQYnBOyujRIo
	 luYU1HDmcdDVzqlY1dLqSy5Z0jguljLG/HEltlz41w0eQeAb4pGZHsntB1Hqj/+J8TGs7
	 f96Q8QTmV2obbVIX0fMjp9VsPvfFLkc3UDc+g4nvG7OIA/4pM4OGdtneFOLUjto9jiers
	 pGpkuJ5yhXicas7pZ0ZNcixop+qxuOYfjkpAphUq9ALSJOjJ9BquJ8yfQP1/jGIR9GA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788753702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-UUID:
	 DKIM-Signature:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=2TyiFXDQmrGlhAOHPnPrs2oGJvvKJO+1FJxPnXrEwbU=;
	b=hHCnOx8xU65JSMZCpk13RoHXZ61YfBgYigG/rrUsRODe7ORKldDvNBYiv8SFav8PLIl+
	 Ltmhy2AqaepO2wLqbjLg43YGcYyUbPnFvjEvMes5sCMoIZcFP8SbNC/Z07wLGtP4A4ue8
	 D2FAbWaaHF6+SUSKzgMQokzAJnUAI57dm9IIW/cV+n4EZtEnIhsjIE6H0icn7JvgQDTO9
	 Jo8UJmuTuUNEED0afMX5bbfDkEsKif7ORc9+2j1LUroIZrRj5mlAJyi/d5mvLXgE4UDyv
	 zgdU4UsEvnOUL+mYuUUxKLPBOVo/vcwSlpld9IBXYdbpYDXTPoeUK392Gz0+MHdRrdA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788753702;
	bh=2TyiFXDQmrGlhAOHPnPrs2oGJvvKJO+1FJxPnXrEwbU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1DtIXny9y/UyA/g6THu9raOWBRY5f1RhTW2zibD0Xn9GKB0rlbwsfsZPLjdpl27tp
	 7rfBxtPmPWTCUA/CsY9Sr5W8ugUUjXTJK+k/xMg4hYrvynGVnIxtKlz/Yi2J0KfJxQ
	 m8K4DMBkWJREY72SYYkvCHxJ41o2e6FpaLGTZuKcmAvdU5HJHYoNH4JB/kE59YUwYT
	 XEzMLh0l6ls1hMikDdt7lir0Y5g/3Ihynxici6Dqv0qBD+vkVGgarH0kHDDc/oIUbx
	 kzGMm6neof46+4LuHnuCOgdS4QPXosNUAGV1IFCmRlwRZkfitxPlaOnnye1iykEri4
	 3kz3uT0CfE/5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A9CB80BD6;
	Mon,  7 Sep 2026 04:01:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 992DF2C7
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 04:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8ACB040587
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 04:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhwzcwkYRnUc for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 04:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82C6140580
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788753699;
 b=Pcw/24gOgdTYSTZFWwIvwnfWxfRpVhYb2LTczZZSMUu00A+On1QYQNd3GchqFQbuIn7d
 1usknqYZr04HACHffuqhtavKJqgJKa+CdRoHjiWEy12rMLHayKx3t8lzedQ2P8Kem/rSd
 /OFCj6kYPrJVUQASD5qrq7VRMsDXN0xi38qH9qpcoJOtpEhhPsJ0pc7olyOOiauZAsZvR
 ol/HsWG/fz/hAhVWXalCF4bt+yDje6elxhxTv6n4whYA8a8vUh9nnSOtKhK+JN1LYOdlx
 U/ZsxU6KxMSvCp+DBFSplhgHfhLQmnikGWqilYi0g4n3K+jiLfy6/9czNdTUi9LgQug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788753699;
 h=Received-SPF:X-UUID:DKIM-Signature:X-CID-CACHE:X-CID-P-RULE:
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
 bh=2TyiFXDQmrGlhAOHPnPrs2oGJvvKJO+1FJxPnXrEwbU=;
 b=IsQjxYpfM0zZ4kNAUTVsGguujVBiiHqvb7LhnAFebZ6xwMEvB/VzY7bQuW0fkOWzG8oY
 6kXVi2ofHromIcMh9nLAm1SCgsTsdeoCRs37tXXNfBa/BJDwp2PrKWWlyJ8p1KBz9csRV
 /xPoYrLoKsZ4PTAhP7hMKTiosU1kDYWgWjNwcPqa5FVO1reAR7DM0b4O+nezkQrfueJMf
 TEVLbdelMGMhcZss5LbeKNvC4x8GLv9c210Gp0hF83dxtN81wqb16CcBtYeBoOg21RYCf
 GkjT+KvwZnspLyETF36G/bzwuwCgde0quCAnPhZL6zNbanmc+nxx01cKakE2wP3KVUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=mediatek.com; 
 dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=ovhETEzy; 
 dkim=fail reason="signature verification failed"
 header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com
 header.b="lzQ+WmC/"; 
 arc=fail smtp.remote-ip=60.244.123.138
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=macpaul.lin@mediatek.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=mediatek.com
 header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=ovhETEzy; 
 dkim=fail reason="signature verification failed" (1024-bit key)
 header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com
 header.b=lzQ+WmC/
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82C6140580
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 04:01:34 +0000 (UTC)
X-UUID: 8fbcbf4caa6e11f1b1788b6acf885367-20260907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=2TyiFXDQmrGlhAOHPnPrs2oGJvvKJO+1FJxPnXrEwbU=; 
 b=ovhETEzyE5n+NzeG4+K7c2WF2zjLmJwAxJHbRvU4K25PG6nOsgn+ZKLHQfqs+A1STjGanIRmalF8MM4H3WHpwEB+kQE4Tn9aaiPnJi6QwC7L1UwkJAbSVE4uA0qzcHZj8R+PNhClt9hKBx4D1hq9cn6qqMjsbqyeXxBWSscpMEQ=;
X-CID-CACHE: Type:Local,Time:202609071145+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:6835ae24-9145-44cd-8eae-d677e7957814, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:b73990f2-6b5d-4016-ba8d-9f799a78b7e4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8fbcbf4caa6e11f1b1788b6acf885367-20260907
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2123981972; Mon, 07 Sep 2026 11:45:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 7 Sep 2026 11:45:24 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 7 Sep 2026 11:45:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEEagY9qy1mLKmfAgexw3WZSofX5M+WhQV79QNZeOsfQsl6R3+40fAnnncv6r8xSQcxOmtIaQlVkUTePxjfnkDhVMEPjsnoHmhh4mDR2qk5vuigG3mQvzIPhtS/VSzaVsupGvaTaxujOhp+yW/w8qKkwOuZL0iOLAdBtqjqm/R/E1ZsOBiiUsewGWMHYo1bJcoxDu0bEP8M3ffSUdimHCnINEJfMRWOMjnxmCJ1SbF0OGs/lyotIbE1cFxVvkYjz/ekkx0PRLNzHniSBFYQ8EHbnDWv4UymfeDjUh8p/xmOboXx5hH0pmKoykKNDmgzceNuylx1EsfBfug9JKluyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwkaonMW6ADwrfWuoYIy+1Stt/BTZcHkV7DlJGFgSr8=;
 b=vPGis6iWqdn3kccUbj8nIr/dIjKzCl3K5vOVyNeS25z7RBuk6MgaRzS+ApigEjtpSx/7f97elKV+j4DGS9SGyTC2ZwtfchnDVRwYuVTJukpDgbm58L7Y+g8lHPLGzYEelPtik1toYNHFknU4q5wazOehYRC6vyv8S4uf6tKw0cHQv8Ec8IQ7Ip2MUPoDSA4JaXDrpn2JSy0kXnbsQN74nyaN05C+7g46b54amhlgFy2RMbY26SqEwvi4yIT6Gr2FR501yG1wReoDgDXJISZuBtjBmRCw3jRKzjdHdoM9IOCDw7oxxLmzTUfmV4BGl8Md29jKH+WrxjRYqjFWWEwppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwkaonMW6ADwrfWuoYIy+1Stt/BTZcHkV7DlJGFgSr8=;
 b=lzQ+WmC/pd4GN07x3EDPWzW1a1CZkn0aWhc4CucOt678o2LwQzWqbuWvjx3UYCecvQ8rySJN8Z1X02CP9Fah5cagFpfUQ6f43ZT8CNjCSHm2M7q6R8xW9R8JE/lFod+Cfim8QJUDrPV+MiWOyPlaX+jAyCcEFavIq4jwEqiPZW4=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB7713.apcprd03.prod.outlook.com (2603:1096:990:a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:45:19 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:45:19 +0000
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
Subject: Re: [PATCH v6 2/6] configs: mt8188: enable eMMC FIT boot from SPL
Thread-Topic: [PATCH v6 2/6] configs: mt8188: enable eMMC FIT boot from SPL
Thread-Index: AQHdPhS3pjv61TEU/kupjrVDAPaDm7bCem6A
Date: Mon, 7 Sep 2026 03:45:19 +0000
Message-ID: <c2562155eeddb00ddf922d627fda5e50ee67a68c.camel@mediatek.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-2-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-2-4d4a11d5741d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB7713:EE_
x-ms-office365-filtering-correlation-id: 4e1aab72-8edb-4411-b093-08df0c926fe5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|38070700021|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: BPz53QoriQqYNrfaxQtrUYdMNIPwXDrr7ASYxjurIdfh4l2j1gY5ScQdLO4uONyBJMULkpinV4eqjfoOzBSLUPGShuY3qdNAqXEXdy8oPv7nd3FjzJICg76KnE1AiNWYj5gfmyMBhXgNoWcze1SOQEgZFH2+oJwYPj9HPz4xeySRLnCM5EvTG81ykWF6OW4DgToiSH5BcmgH13jO8IctqK0fMDfUpTp+E9KYmUC8nB7pNP4j53aVuivWM6/SqLr+ILaW7hNHujsF1CKWAHR+oBlnK+vAFD4P2D1AZ3v8hOUIBhfd8g9VQQRI9jvcj1P+MydA4oVQ68JcqwWXMAKhFuaQ18VjPHINluWaXeCLL+IUG3vV52NFSCKNpY4P1BwO678jPUhfWtgacZ+WaOqCy7ChagpIGvdKH6L8y3Z+D9z52WTX7cwXO+5nQLF5AtSiwtKygopzSksi3FE/Au4T3M0qg7u7TYkiBMYxt4FjMJ4dQu22uMhLYOKQBn6Vgo7YNppeEoKWk6ldRP4pv9XB7PnSr+hKq1964+66dJM2ABybjBzrwWTqxaGsZwIhRW0SA9qbssltJsep8/bNbq3tJf7phMceFupK9Zy6JVRbLyztaeJVsFhQ9rwGTV/T/L9o3h11j6WuDXQvGdJEuk3PNzhntOlPWjP2gKqrfom6pSdJQQgzCapcqHhWJoop1g1yqgXF1aMLJ97Jlk/byWZ8hFI2LHSDtCRjOsKqesb/A2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(38070700021)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T01mcUpMbXFMMTV2TlExZ3hLRVhwK2xoZGNtMG5QbVpXY0Qyb0hJRW81WWxQ?=
 =?utf-8?B?N0tWR1NCTWN3cUo0REJkK3BUdlVuU0RiUS9sNUY1WnR3L0lMY2ZqS1V5dDdZ?=
 =?utf-8?B?by84OEV5d3VtTExRUXh5V1lyZjkvOEloU3JhTTh4NkdJUi9IQkVRMHoyNk14?=
 =?utf-8?B?aTJTRVBSQVlqVnhmdW1CUmxQOHl2NzREWVhEbFd5YnlUUlM1REhnYjU3RS9F?=
 =?utf-8?B?NEd1dXZXY3k1K3dQV3U1MTgvbkZsdXB3WVMraWZIb2NPZzhFNWM2d0p4M25U?=
 =?utf-8?B?Sm4yelFwU05GK0Z1WmFHWHREOTFOelFPY1NCOTlFbEV4WFFoQ2NoRkptclY1?=
 =?utf-8?B?MEhTY3JCUSszS09IdDBHSjVxUXplTzB5dU90WUV4WC84b3JTRi9yaWpHYWF0?=
 =?utf-8?B?VC9hU1JVMkd6NTFuMWF2L09TQ0NEUExBTFN6RVJNMnNaZDdYNDdEanpXcEtL?=
 =?utf-8?B?UlFyMTNpbzgxMTNGYzRZSDVpMGgwTTJxTlRxS2Z6dk1ac25SQytEdUhMUmRH?=
 =?utf-8?B?VHRDcnF1REhURGFqYjJHZ3NmV2VOTG5PNDdlSjhMRCtFTlEzSE5uVUxhTGh1?=
 =?utf-8?B?aXJaYjlCK2MybmhZY1NzTnJId1Zkamd6THFhVCttcXpoeGJjc21nbUY0Lzcy?=
 =?utf-8?B?emxzSng3c0xMNDgraCt6Z1FMTFBrejliVHJKYlh4NjN5akIxYXhMc213U1h6?=
 =?utf-8?B?U1NUa1VhSnF4YUxKZlMrME5TT0hrdkdmNkVBWldUalJkenJ4V3kxRTBmSmt5?=
 =?utf-8?B?SDJ1Y2ZZb0tQSGRZa2tyNE54ZEZRRDViTzhnRDdaZ2Y0cTU3ek5QRXV0K0Na?=
 =?utf-8?B?RHlzb0FBSWlXdVl0YW1vZXMwOEpKTlF5Q2FXd09jYWhNSlMwY2I2QXprRnRZ?=
 =?utf-8?B?Q1hZRTJJMG9OT2R4M1BqTWpZVVhmY3ZJN0EvK0MzWk1FWXI1dFM5WVV3dFh1?=
 =?utf-8?B?K2NERDdYdWNqd3d2K3c4ZE5SRFFLVzgrc1k4T3E1UHdYT1RBQzN5ZzFhRlNm?=
 =?utf-8?B?bGtjQUtGQ01BRDdxbzBOa05nK3BMUXlvT0hKWFpUTU40YTVseUtqUkxsc3RM?=
 =?utf-8?B?Um5UR0JIeDY4bXp6MzhpU3ZON1J6dXRNTUUwcldaWHV4czdIRzlzZG1MN1VD?=
 =?utf-8?B?Z1pUQ1ZPZng5YVNGSS94dnBVMW0zcGViYjBrK2JLbDRVUUdwU0hGWlZ6VHlz?=
 =?utf-8?B?V0p6bS9mb1cxRTVFaEVXbGZoc003dHdPSENQdDc3K1c2MVhhTEpKQVhiUUtJ?=
 =?utf-8?B?SUxaNlM2cmlpbUo3UmkxeXdhM3ptYW4yeWdxZGlKeEJMVWFrWnNTMG16bVBr?=
 =?utf-8?B?eUpaTXpvc0FYaml6OVhRZmV5WVJOcXlQenl6OFc1bi9LMDcxY3l0T1RERmN4?=
 =?utf-8?B?bkR2bUMvZWRKNnNPQlNySlp4Mk5CaG10TmJjb0M1V3VqMkdkUGJkekZ3REVw?=
 =?utf-8?B?b3FNcnVtOXl6eFhNQ3ZPblVWWENUUHZ0QUtCOGpQM1ZCQTZkdnRKa3Y1eGZN?=
 =?utf-8?B?OTZtM2VKUzZnZFJ6ZUdJeWFQMDJkZWNPT0w2NDAybVNjMGxsZFhtNnhYUEkz?=
 =?utf-8?B?bXJiVGtFM254WnRwdnh6a0hacGpzQkFsLzV2aVIwNENlcmQxci9vd0p6RGNO?=
 =?utf-8?B?MFU1eFNWcFBKK29KamNHQVRsZkd5MVk1cDYvSTFvWEtpTHNsTlRSYWMvWEJQ?=
 =?utf-8?B?RkU5bWpsbWFXNFg2akF5MkhKK2hoQWk2MjFzU2p2RXM2SHVjVyt4Um5qdzlU?=
 =?utf-8?B?ZHZjMDEvVmpaQlE5V2kyS3R5dUxhZWFsSmQzamZoWUlweFlCVVhkcEdPaE1X?=
 =?utf-8?B?NFlYVUZBdmhiNytVc1JtWlpqSjFLaEJlcWxpVkFMTDBhNTFxZ2ZiVHlOQmtW?=
 =?utf-8?B?dzA0a05UMnJyQ1dyWURZZERVd3lyd3NiMUUwN3pERjVkNWRIKzB0T0tWL3BS?=
 =?utf-8?B?bDAzMC8vbnUrRG9UaUxyYXNRSWpTRjdmYXNuVEsxY2RidkxEaGxJc3RrMzdl?=
 =?utf-8?B?d1YreWYrdUpuNW9DT3VTSTd5M3hZOE12ZFM4VGZBZWV1Vk0vdlNUWklVYWlk?=
 =?utf-8?B?WWxkMU1SQzc1ZWFRM0R0RWxycC85bjBxc3VGS25aUU5HME1vSTlLV3d2SHRy?=
 =?utf-8?B?MklmN3hhT0ZoWi9jQUlLZjEwNEI4d3BuOE9Cc0k4UjhlN2V1WWJhYUwvYS9u?=
 =?utf-8?B?eDRrNmpZZWMvdGpYRFIvd1l1ZGJsN1hTUDMvbGxWSUdGcWQ2bUZobjlnLzVG?=
 =?utf-8?B?MjdrckgvR1ArTlpscE92QVY1dk5sblFNeWU0V2hQK1NkVWRPRC9Gd1VWUXBU?=
 =?utf-8?B?bDRCTFdYVFFNRDlUSFh0MG45ZHRhNFFFOFJZS3B6OEZMQ0tRWHdxQ3Q4VVV1?=
 =?utf-8?Q?AWhC0lUbca/oWre4=3D?=
Content-ID: <5CB1AACCA9A14E4E96B3E510B2A146C8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DDmmJEdwdtW5/rYeF7UGTGXykOdtBjhQcl4wgk8XxHHlld6gAAD1QMtPTjmjl4tuoQCjvfge7aqJgYy6E4geYHyWZsgKHl2YXxy088unILj6Oic/+mkVX/vqTFTzTH1ZTlpcCmT3eEymCU4HKBrsuqI6JAC6IxOtY6N2NNCnWX9uiLrLw0nkbxKcj3Y/fxrm8bqYocrGkVASy0BRe7i5HfWING0hSVgWD0T78vIcHcl+/rELShivt9xvby4YFv8A0h/7uanb0FK0t+qI4jA3G3arA4WWPbQZrMK10bOC34MsQ+4FsNO9OWGu1O1fep4e5owDWSWAR6AWD5uZUfCKuw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1aab72-8edb-4411-b093-08df0c926fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 03:45:19.1815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oXMxpYfStNT02ySb/krPgdBpezPjqqax3AuEAt/TREX53/g03WhiCmUguJ1YLnAH4v2XIN0+aLdgBWVgedZCYvZvEVAAzqiHs5o/E7bd5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7713
Content-Type: multipart/alternative;
 boundary="__=_Part_Boundary_006_789911253.992645912"
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

--__=_Part_Boundary_006_789911253.992645912
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T24gU3VuLCAyMDI2LTA5LTA2IGF0IDE3OjMwICswMjAwLCBDYXJsbyBDYWlvbmUgd3JvdGU6DQo+
IEVuYWJsZSB0aGUgc2hhcmVkIEdlbmlvIDUxMC83MDAgU1BMIHBhdGggZW50ZXJlZCBieSB0aGUg
ZXh0ZXJuYWwgRERSDQo+IGxvYWRlci4gS2VlcCBCU1MgYWZ0ZXIgdGhlIGRvd25zdHJlYW0gU1BM
IHJlc2VydmF0aW9uLCBsZWF2aW5nIGENCj4gMHhjODAwDQo+IGd1YXJkIGFmdGVyIHRoZSBjb3B5
IHdpbmRvdyBhbmQgc3BhY2UgZm9yIHRoZSBpbml0aWFsIHN0YWNrIGFuZCBlYXJseQ0KPiBhbGxv
Y2F0aW9ucy4gVXNlIGFuIDggTWlCIGhlYXAgZm9yIGxvYWRpbmcgdGhlIGZpcm13YXJlIEZJVC4N
Cj4gDQo+IExvYWQgQkwzMSwgT1AtVEVFIGFuZCBVLUJvb3QgZnJvbSBlTU1DIHBhcnRpdGlvbiAx
IHVzaW5nIGdlbmVyaWMgU1BMDQo+IHN1cHBvcnQuIFRoZSBNZWRpYVRlayBCTDMxIHN0YWxscyB3
aGVuIGdpdmVuIGEgcnVudGltZSBkZXZpY2V0cmVlIGFzDQo+IGl0cw0KPiBwbGF0Zm9ybSBwYXJh
bWV0ZXIsIHNvIHBhc3MgTlVMTCB0aGVyZSB3aGlsZSByZXRhaW5pbmcgdGhlIHN0YW5kYXJkDQo+
IGZpcm13YXJlIGVudHJ5LXBvaW50IHBhcmFtZXRlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBW
aXRvciBTYXRvIEVzY2hob2x6IDx2c2F0b2VzQGJheWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJheWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQ2FybG8gQ2Fpb25lIDxjY2Fpb25lQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgY29uZmln
cy9tdDgxODguY29uZmlnIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9j
b25maWdzL210ODE4OC5jb25maWcgYi9jb25maWdzL210ODE4OC5jb25maWcNCj4gaW5kZXggMjll
MmIzZGI4NzguLmE3YTU5OTQwNjQ2IDEwMDY0NA0KPiAtLS0gYS9jb25maWdzL210ODE4OC5jb25m
aWcNCj4gKysrIGIvY29uZmlncy9tdDgxODguY29uZmlnDQo+IEBAIC0yOCwzICsyOCwzNiBAQCBD
T05GSUdfTVRLX1NFUklBTD15DQo+IMKgQ09ORklHX1dEVD15DQo+IMKgQ09ORklHX1dEVF9NVEs9
eQ0KPiDCoCMgQ09ORklHX1JBTkRPTV9VVUlEIGlzIG5vdCBzZXQNCj4gK0NPTkZJR19TUEw9eQ0K
PiArIyBGaXhlZCBkZXN0aW5hdGlvbiBhbmQgY29weSB3aW5kb3cgb2YgdGhlIGV4dGVybmFsIERE
UiBsb2FkZXIuDQo+ICtDT05GSUdfU1BMX1RFWFRfQkFTRT0weDQwMDAwMDAwDQo+ICtDT05GSUdf
U1BMX01BWF9TSVpFPTB4YWYwMDANCj4gK0NPTkZJR19TUExfU0VQQVJBVEVfQlNTPXkNCj4gK0NP
TkZJR19TUExfSEFTX0JTU19MSU5LRVJfU0VDVElPTj15DQo+ICsjIFByZXNlcnZlIHRoZSBkb3du
c3RyZWFtIHJlc2VydmF0aW9uLCB3aXRoIGEgMHhjODAwLWJ5dGUgZ3VhcmQNCj4gYWZ0ZXIgU1BM
Lg0KPiArQ09ORklHX1NQTF9CU1NfU1RBUlRfQUREUj0weDQwMGJiODAwDQo+ICtDT05GSUdfU1BM
X0JTU19MSU1JVD15DQo+ICtDT05GSUdfU1BMX0JTU19NQVhfU0laRT0weDEwMDAwDQo+ICsjIExl
YXZlIDQ0OCBLaUIgYWJvdmUgdGhlIEJTUyBsaW1pdCBmb3IgdGhlIHN0YWNrLCBnbG9iYWwgZGF0
YSBhbmQNCj4gZWFybHkgaGVhcC4NCj4gK0NPTkZJR19TWVNfSU5JVF9TUF9CU1NfT0ZGU0VUPTB4
ODAwMDANCj4gK0NPTkZJR19TUExfU1lTX01BTExPQz15DQo+ICtDT05GSUdfU1BMX0hBU19DVVNU
T01fTUFMTE9DX1NUQVJUPXkNCj4gKyMgS2VlcCB0aGUgaGVhcCBzZXBhcmF0ZSBmcm9tIHRoZSBs
b2FkZWQgZmlybXdhcmUgYW5kIGl0cyByZXNlcnZlZA0KPiBtZW1vcnkuDQo+ICtDT05GSUdfU1BM
X0NVU1RPTV9TWVNfTUFMTE9DX0FERFI9MHg1YzAwMDAwMA0KPiArQ09ORklHX1NQTF9TWVNfTUFM
TE9DX1NJWkU9MHg4MDAwMDANCj4gK0NPTkZJR19TUExfU1lTQ09OPXkNCj4gK0NPTkZJR19TUExf
Q0xLPXkNCj4gK0NPTkZJR19TUExfU0VSSUFMPXkNCj4gKyMgQ09ORklHX1NQTF9VU0VfVElOWV9Q
UklOVEYgaXMgbm90IHNldA0KPiArQ09ORklHX1NQTF9QSU5DVFJMPXkNCj4gK0NPTkZJR19TUExf
UElOQ09ORj15DQo+ICtDT05GSUdfU1BMX1dBVENIRE9HPXkNCj4gK0NPTkZJR19TUExfTU1DPXkN
Cj4gK0NPTkZJR19TUExfTElCRElTS19TVVBQT1JUPXkNCj4gK0NPTkZJR19TUExfRUZJX1BBUlRJ
VElPTj15DQo+ICtDT05GSUdfU1BMX1NZU19NTUNTRF9SQVdfTU9ERT15DQo+ICtDT05GSUdfU1lT
X01NQ1NEX1JBV19NT0RFX1VfQk9PVF9VU0VfUEFSVElUSU9OPXkNCj4gK0NPTkZJR19TWVNfTU1D
U0RfUkFXX01PREVfVV9CT09UX1BBUlRJVElPTj0xDQo+ICtDT05GSUdfU1BMX0xPQURfRklUPXkN
Cj4gK0NPTkZJR19TUExfQVRGPXkNCj4gK0NPTkZJR19TUExfQVRGX05PX1BMQVRGT1JNX1BBUkFN
PXkNCj4gDQo+IA0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRl
ay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=

--__=_Part_Boundary_006_789911253.992645912
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+PGJvZHk+PHA+DQo8cHJlPg0KT24mIzMyO1N1biwmIzMyOzIwMjYtMDktMDYmIzMyO2F0
JiMzMjsxNzozMCYjMzI7KzAyMDAsJiMzMjtDYXJsbyYjMzI7Q2Fpb25lJiMzMjt3cm90ZToNCiZn
dDsmIzMyO0VuYWJsZSYjMzI7dGhlJiMzMjtzaGFyZWQmIzMyO0dlbmlvJiMzMjs1MTAvNzAwJiMz
MjtTUEwmIzMyO3BhdGgmIzMyO2VudGVyZWQmIzMyO2J5JiMzMjt0aGUmIzMyO2V4dGVybmFsJiMz
MjtERFINCiZndDsmIzMyO2xvYWRlci4mIzMyO0tlZXAmIzMyO0JTUyYjMzI7YWZ0ZXImIzMyO3Ro
ZSYjMzI7ZG93bnN0cmVhbSYjMzI7U1BMJiMzMjtyZXNlcnZhdGlvbiwmIzMyO2xlYXZpbmcmIzMy
O2ENCiZndDsmIzMyOzB4YzgwMA0KJmd0OyYjMzI7Z3VhcmQmIzMyO2FmdGVyJiMzMjt0aGUmIzMy
O2NvcHkmIzMyO3dpbmRvdyYjMzI7YW5kJiMzMjtzcGFjZSYjMzI7Zm9yJiMzMjt0aGUmIzMyO2lu
aXRpYWwmIzMyO3N0YWNrJiMzMjthbmQmIzMyO2Vhcmx5DQomZ3Q7JiMzMjthbGxvY2F0aW9ucy4m
IzMyO1VzZSYjMzI7YW4mIzMyOzgmIzMyO01pQiYjMzI7aGVhcCYjMzI7Zm9yJiMzMjtsb2FkaW5n
JiMzMjt0aGUmIzMyO2Zpcm13YXJlJiMzMjtGSVQuDQomZ3Q7JiMzMjsNCiZndDsmIzMyO0xvYWQm
IzMyO0JMMzEsJiMzMjtPUC1URUUmIzMyO2FuZCYjMzI7VS1Cb290JiMzMjtmcm9tJiMzMjtlTU1D
JiMzMjtwYXJ0aXRpb24mIzMyOzEmIzMyO3VzaW5nJiMzMjtnZW5lcmljJiMzMjtTUEwNCiZndDsm
IzMyO3N1cHBvcnQuJiMzMjtUaGUmIzMyO01lZGlhVGVrJiMzMjtCTDMxJiMzMjtzdGFsbHMmIzMy
O3doZW4mIzMyO2dpdmVuJiMzMjthJiMzMjtydW50aW1lJiMzMjtkZXZpY2V0cmVlJiMzMjthcw0K
Jmd0OyYjMzI7aXRzDQomZ3Q7JiMzMjtwbGF0Zm9ybSYjMzI7cGFyYW1ldGVyLCYjMzI7c28mIzMy
O3Bhc3MmIzMyO05VTEwmIzMyO3RoZXJlJiMzMjt3aGlsZSYjMzI7cmV0YWluaW5nJiMzMjt0aGUm
IzMyO3N0YW5kYXJkDQomZ3Q7JiMzMjtmaXJtd2FyZSYjMzI7ZW50cnktcG9pbnQmIzMyO3BhcmFt
ZXRlcnMuDQomZ3Q7JiMzMjsNCiZndDsmIzMyO1NpZ25lZC1vZmYtYnk6JiMzMjtWaXRvciYjMzI7
U2F0byYjMzI7RXNjaGhvbHomIzMyOyZsdDt2c2F0b2VzQGJheWxpYnJlLmNvbSZndDsNCiZndDsm
IzMyO1NpZ25lZC1vZmYtYnk6JiMzMjtKdWxpZW4mIzMyO1N0ZXBoYW4mIzMyOyZsdDtqc3RlcGhh
bkBiYXlsaWJyZS5jb20mZ3Q7DQomZ3Q7JiMzMjtTaWduZWQtb2ZmLWJ5OiYjMzI7Q2FybG8mIzMy
O0NhaW9uZSYjMzI7Jmx0O2NjYWlvbmVAYmF5bGlicmUuY29tJmd0Ow0KJmd0OyYjMzI7LS0tDQom
Z3Q7JiMzMjsmIzE2MDtjb25maWdzL210ODE4OC5jb25maWcmIzMyO3wmIzMyOzMzJiMzMjsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiZndDsmIzMyOyYjMTYwOzEmIzMyO2ZpbGUm
IzMyO2NoYW5nZWQsJiMzMjszMyYjMzI7aW5zZXJ0aW9ucygrKQ0KJmd0OyYjMzI7DQomZ3Q7JiMz
MjtkaWZmJiMzMjstLWdpdCYjMzI7YS9jb25maWdzL210ODE4OC5jb25maWcmIzMyO2IvY29uZmln
cy9tdDgxODguY29uZmlnDQomZ3Q7JiMzMjtpbmRleCYjMzI7MjllMmIzZGI4NzguLmE3YTU5OTQw
NjQ2JiMzMjsxMDA2NDQNCiZndDsmIzMyOy0tLSYjMzI7YS9jb25maWdzL210ODE4OC5jb25maWcN
CiZndDsmIzMyOysrKyYjMzI7Yi9jb25maWdzL210ODE4OC5jb25maWcNCiZndDsmIzMyO0BAJiMz
MjstMjgsMyYjMzI7KzI4LDM2JiMzMjtAQCYjMzI7Q09ORklHX01US19TRVJJQUw9eQ0KJmd0OyYj
MzI7JiMxNjA7Q09ORklHX1dEVD15DQomZ3Q7JiMzMjsmIzE2MDtDT05GSUdfV0RUX01USz15DQom
Z3Q7JiMzMjsmIzE2MDsjJiMzMjtDT05GSUdfUkFORE9NX1VVSUQmIzMyO2lzJiMzMjtub3QmIzMy
O3NldA0KJmd0OyYjMzI7K0NPTkZJR19TUEw9eQ0KJmd0OyYjMzI7KyMmIzMyO0ZpeGVkJiMzMjtk
ZXN0aW5hdGlvbiYjMzI7YW5kJiMzMjtjb3B5JiMzMjt3aW5kb3cmIzMyO29mJiMzMjt0aGUmIzMy
O2V4dGVybmFsJiMzMjtERFImIzMyO2xvYWRlci4NCiZndDsmIzMyOytDT05GSUdfU1BMX1RFWFRf
QkFTRT0weDQwMDAwMDAwDQomZ3Q7JiMzMjsrQ09ORklHX1NQTF9NQVhfU0laRT0weGFmMDAwDQom
Z3Q7JiMzMjsrQ09ORklHX1NQTF9TRVBBUkFURV9CU1M9eQ0KJmd0OyYjMzI7K0NPTkZJR19TUExf
SEFTX0JTU19MSU5LRVJfU0VDVElPTj15DQomZ3Q7JiMzMjsrIyYjMzI7UHJlc2VydmUmIzMyO3Ro
ZSYjMzI7ZG93bnN0cmVhbSYjMzI7cmVzZXJ2YXRpb24sJiMzMjt3aXRoJiMzMjthJiMzMjsweGM4
MDAtYnl0ZSYjMzI7Z3VhcmQNCiZndDsmIzMyO2FmdGVyJiMzMjtTUEwuDQomZ3Q7JiMzMjsrQ09O
RklHX1NQTF9CU1NfU1RBUlRfQUREUj0weDQwMGJiODAwDQomZ3Q7JiMzMjsrQ09ORklHX1NQTF9C
U1NfTElNSVQ9eQ0KJmd0OyYjMzI7K0NPTkZJR19TUExfQlNTX01BWF9TSVpFPTB4MTAwMDANCiZn
dDsmIzMyOysjJiMzMjtMZWF2ZSYjMzI7NDQ4JiMzMjtLaUImIzMyO2Fib3ZlJiMzMjt0aGUmIzMy
O0JTUyYjMzI7bGltaXQmIzMyO2ZvciYjMzI7dGhlJiMzMjtzdGFjaywmIzMyO2dsb2JhbCYjMzI7
ZGF0YSYjMzI7YW5kDQomZ3Q7JiMzMjtlYXJseSYjMzI7aGVhcC4NCiZndDsmIzMyOytDT05GSUdf
U1lTX0lOSVRfU1BfQlNTX09GRlNFVD0weDgwMDAwDQomZ3Q7JiMzMjsrQ09ORklHX1NQTF9TWVNf
TUFMTE9DPXkNCiZndDsmIzMyOytDT05GSUdfU1BMX0hBU19DVVNUT01fTUFMTE9DX1NUQVJUPXkN
CiZndDsmIzMyOysjJiMzMjtLZWVwJiMzMjt0aGUmIzMyO2hlYXAmIzMyO3NlcGFyYXRlJiMzMjtm
cm9tJiMzMjt0aGUmIzMyO2xvYWRlZCYjMzI7ZmlybXdhcmUmIzMyO2FuZCYjMzI7aXRzJiMzMjty
ZXNlcnZlZA0KJmd0OyYjMzI7bWVtb3J5Lg0KJmd0OyYjMzI7K0NPTkZJR19TUExfQ1VTVE9NX1NZ
U19NQUxMT0NfQUREUj0weDVjMDAwMDAwDQomZ3Q7JiMzMjsrQ09ORklHX1NQTF9TWVNfTUFMTE9D
X1NJWkU9MHg4MDAwMDANCiZndDsmIzMyOytDT05GSUdfU1BMX1NZU0NPTj15DQomZ3Q7JiMzMjsr
Q09ORklHX1NQTF9DTEs9eQ0KJmd0OyYjMzI7K0NPTkZJR19TUExfU0VSSUFMPXkNCiZndDsmIzMy
OysjJiMzMjtDT05GSUdfU1BMX1VTRV9USU5ZX1BSSU5URiYjMzI7aXMmIzMyO25vdCYjMzI7c2V0
DQomZ3Q7JiMzMjsrQ09ORklHX1NQTF9QSU5DVFJMPXkNCiZndDsmIzMyOytDT05GSUdfU1BMX1BJ
TkNPTkY9eQ0KJmd0OyYjMzI7K0NPTkZJR19TUExfV0FUQ0hET0c9eQ0KJmd0OyYjMzI7K0NPTkZJ
R19TUExfTU1DPXkNCiZndDsmIzMyOytDT05GSUdfU1BMX0xJQkRJU0tfU1VQUE9SVD15DQomZ3Q7
JiMzMjsrQ09ORklHX1NQTF9FRklfUEFSVElUSU9OPXkNCiZndDsmIzMyOytDT05GSUdfU1BMX1NZ
U19NTUNTRF9SQVdfTU9ERT15DQomZ3Q7JiMzMjsrQ09ORklHX1NZU19NTUNTRF9SQVdfTU9ERV9V
X0JPT1RfVVNFX1BBUlRJVElPTj15DQomZ3Q7JiMzMjsrQ09ORklHX1NZU19NTUNTRF9SQVdfTU9E
RV9VX0JPT1RfUEFSVElUSU9OPTENCiZndDsmIzMyOytDT05GSUdfU1BMX0xPQURfRklUPXkNCiZn
dDsmIzMyOytDT05GSUdfU1BMX0FURj15DQomZ3Q7JiMzMjsrQ09ORklHX1NQTF9BVEZfTk9fUExB
VEZPUk1fUEFSQU09eQ0KJmd0OyYjMzI7DQomZ3Q7JiMzMjsNClJldmlld2VkLWJ5OiYjMzI7TWFj
cGF1bCYjMzI7TGluJiMzMjsmbHQ7bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tJmd0Ow0KDQpUaGFu
a3MhDQpNYWNwYXVsJiMzMjtMaW4NCg0KPC9wcmU+DQo8L3A+PC9ib2R5PjwvaHRtbD48IS0tdHlw
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

--__=_Part_Boundary_006_789911253.992645912--

