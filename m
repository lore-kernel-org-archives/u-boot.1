Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968F606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=icK0pajB;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=IEcGBy8o
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F2C080D32;
	Mon, 23 Nov 2026 02:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cjwhkb3FSh7W; Mon, 23 Nov 2026 02:01:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DF1280D2B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795399263;
	b=G5YqA/tIuUlXlDu1snZuyYusupsWLIW9hjulIv1TvQ+7rsW4OZn7I3MjAe9TxOLr4BQI
	 g96M7CjxBsnYOTZr0shsx+EqgUzn1b5PKwEUFgei/Pj3sZPt8MqCZt+JUX8futeOuI979
	 iYDHue+3kpp4ErtkOv72iIlKLfyCP5jzuegXhWQEK3TQEbbfl+3Azq0QFs+xy5N0YLWEV
	 WwXxx54dk9z0bV8qjfw6tKm+oLz0J3D7B5ZEtpiF5R1JaJuKSYsa71f/y69aKXyNDGUCE
	 NG+Sv772aaAjZi6Efs/eji3LW4xpy+Y7IeyT/KTmi795YGJQpkSUU3/FDKC6eVxnwVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795399263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b5S+GrZF+6yldEQz04M9IcZcE53OcjMe9peorVgS7aE=;
	b=LcBevqBh9Z/qqA6+cfcKTRN6aT/nSYGVpEqCzSWiDCWGUVGQKUWf2BySFgrSYz7bEQPh
	 ZcYMDlCGSjdT6QUJa00ZHoaGTz6K01PKB312/brQzAko43WO+EiSAaVR9+GKjPAZ2sxBT
	 nrLzy0vkIGuAkj1JFaLipY6MfutVm6TRKvuD4uPNG3FzzICyphdB7Hk5Ix6VKOuq62X35
	 A3WKV+6JkVM4wZrcRY1kPeFz7gFwLymURe6UWl+j8S8kqyT+GpA70tcEnW7CAvPfaN6zg
	 MHA+N3DfUc1zquyScJIcON5giJ9CjL9/pTPVzQVFLqKm9TESZrTgkPE4Q6BUTcxRWHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795399263;
	bh=b5S+GrZF+6yldEQz04M9IcZcE53OcjMe9peorVgS7aE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=icK0pajB1/PFK7WAiXs5BOPpOVjW/4kOkOYIeq+FcAOmF/zT7Z95zA1bjr+qX+Tn8
	 x8JL58DBtFsTP6Jp4rgEILVSrZ34f8kfNYpRGL27aCHQRyiYsXknq6Ds1BlJHFOOV8
	 kxfp6pBCTA61wHA2FvX4KRHFL0axqoGgBAYyh40dH0mOTfAjHBl8QVpZPxowYSgmXD
	 3KSZemivXlKtx9hjPjZ//h5EMSjaZ5h197xNzqOGZgP8dTjcMJcZ5XYP+VQjzFTwbY
	 5zn4E0H5Pe197Koyo2fN6vV9qu6fPAbJx7cL9wxTa88fXSw42FPdPIYGgQzgtd23jM
	 DcVEfRdlRjbrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DF1280D2B;
	Mon, 23 Nov 2026 02:01:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 300C9371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B3E060606
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nl6CBmJpeY0a for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 02:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0EA8D60602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=IEcGBy8o
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EA8D60602
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5S+GrZF+6yldEQz04M9IcZcE53OcjMe9peorVgS7aE=;
 b=IEcGBy8oFPq3NJMEOvOirdhA2PZN4GlxnSny0QpoFrBnqU6l20eegZj4sIhaoHwhEP+h+cKMT0C8GKlPISBVHB4WdsjItdwvTdE2JC7+NZR8PEWjQbQelzIiAdQ9IK8t7V6Y6mSBidxQnl7jKj4LBuaTIP6GjHkofQq5JnwmZzOP87BF4ly7skoqMf7T6zC76vva2q2y5RseAX7yvojAxM7RAd/lYw0i7ENxEoq6ljP3cLCBa0csRpQM5jz0tDp4+n+I/CKVpjQQlt5PHeBfhSMYusWcEEayiyFSVRFeTtiG3hEXySUsAUyJzArTBnCPSb3ClkTHTcRObb5efb6Fgg==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB6644.namprd03.prod.outlook.com (2603:10b6:806:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:00:51 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:00:50 +0000
From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.u-boot-project.org>
CC: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>
Subject: RE: [resend 2/2] cmd: i3c: drop unused includes and skip empty device
 slots
Thread-Topic: [resend 2/2] cmd: i3c: drop unused includes and skip empty
 device slots
Thread-Index: AQHdbZ2LNhGXBboUj0S5CqQI5LC9KbcomHiAgBJpKmA=
Date: Mon, 23 Nov 2026 02:00:50 +0000
Message-ID: <PH7PR03MB70636D96CF9FA51899D3A55EAD452@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
 <20261106031830.13625-3-alif.zakuan.yuslaimi@altera.com>
 <1850e1c9-e11a-9681-112e-1b6bf7a2b551@nabladev.com>
In-Reply-To: <1850e1c9-e11a-9681-112e-1b6bf7a2b551@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-11-23T02:00:37.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|SA1PR03MB6644:EE_
x-ms-office365-filtering-correlation-id: 0d5fb628-6a5d-4452-5486-08df4905994b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|55112099003|4143699003|56012099006|10067099003|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: UOnDk2JODIp/M3uGsnZq4FDhhQ3P1QY7dkf11Tndpy441P/XFSIT8BDorBwHPd1XJdsIGtMwhNSs+4ZScOtCc5gX92QFj7N7wK8tGwSZeuEfLKJhoejvq8t+Yt9V+X3kc6DVaTmGtK43DwabnZVAxlfU7fjVVIhaLrOCh1T41HQo15/8hJhya7MSHNoseJx1ezcdgJnuCoemhnar5Tdh7AK13EM3j9+AVwbXESRjgCILXR4yp2BYHkUSB2losaQX2xA8hIEgXaCEDMCRGlWjZYMZHubGJGEMwncG0EsVpXM9au3gWTheQhxmpx3RJI1dfsd+aMxVh/jO9umQV+o2kJ745mNBU+ZKeq7HLsPqMuEUpnTHsvIDZ5ovmFbW+do0WEas8sBHf4EgHw3HjbjO5mEru45PjtGDptk9dCWswuocvN0O2vWkZYOxzY8L2bFlwdNNs4D+Wuis5ba1reIg7P9Vb4KrUhr89f6DKQrqmDDllalScUMpeHvm3I44Sd5WZlepsMSoaWs3wjnBtSzsHVrYfqf5OFz6KSDY/tBg/34W01jW+hx2yLPJPQQ08FaRFlwEdkrkDYo14cfykyd22du+JBaIxWEq3PqJPxcsSGybsr4rCDYNtIbR6gc89vqUBZQRNO9oR4Y4/RS1hINxAJHNps4yxWZXnAKb1YWtcqHpPnMAbkvpr6xWdR1qpkZgsb9mkbhfaLg/Z4FZYDy6mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(55112099003)(4143699003)(56012099006)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTlCdm1PY1M0SWpRT0plbXF2TFgzeER2QzA4Y3grTXBhZjBnMFhhQjJjVUpE?=
 =?utf-8?B?emcxdlJMdFhsSG9pYUlHSC8rUzFmWUNDMFZoWjBSNXBkdWhrbTU2V1ZYR3Js?=
 =?utf-8?B?QVNRSDNiVUQzQ1ljKzd3SDdOK3Y4OENrcG9BUmN2UlREWVFVNGtPY3ZjMFJ0?=
 =?utf-8?B?VUNNL0k2NTFxNHcrNnFxVWJNSWVUMEV4M3Nud1c1QXBrUlU3VXJ0YU5uazZE?=
 =?utf-8?B?NlFKM0hLV2M4bzY5RUJCb3A0dGNTKzJLTVZDaWUybHJWL1ZjN3dEWWQzS3Zl?=
 =?utf-8?B?WEZTaWZBUEFzYk9JMnNrM0VDRTNGaEdnZG45VStvUE1qa2J5L3plekJsRVVx?=
 =?utf-8?B?WkxUaHJCOFdycURrbWhqbVhPcHYyNmJCK01SYVRSNjZScHliZlFINk9XL2xR?=
 =?utf-8?B?eTJHRTYvN2QyQ0V3S3BhZmQrTSsvdEJRbjFuWFdndGpDSEFQZlluRTF5YVVi?=
 =?utf-8?B?alF2U1NEaHVjQ2IrRll6dGxxelZUbEVrd3FQSTJrWTBqdU5TTlJQRll0WWJt?=
 =?utf-8?B?Tkl0dFNmMTJUbFV5bzRoRHV0aFdycTRZTUxsMm14WmlIOFY0UjE4OFRnYUc2?=
 =?utf-8?B?OGJtWFlvdnhxaXliaWt1Z25PbWZ1U3A4WDhNRXQ2a3Z3L1gydXFqVmxTbEpC?=
 =?utf-8?B?N21MN0JJd1cyTmRYRHA3R3B3RUdKcVErTS85Z2lwNkVENkNxN2tCZHlmeWRo?=
 =?utf-8?B?THIxcUxyc1FVdVNIOXhSenVjaWhTc29vQ2lJekJoT3pSczJWbUM5RnZYa0Vl?=
 =?utf-8?B?TXZPSkZTNHFwV2MwbUk5RkZpTER0VmViUkhWcjlKdDVLUW5YVE5idGVoM29C?=
 =?utf-8?B?ZWI2UEJqYU02d1lVcEFNTnhkU3hkZnEwUU1aWUNWcGUyVGgvbC8zSUJwaFlU?=
 =?utf-8?B?bEtnM1I5NzhNYnRjTmM0eDI3NGhkNmtvSU5PUmUyeDRTOUM0S3RKY1l2M01v?=
 =?utf-8?B?d3ZoNVBtVEtWbUs2UzFoMytTMkpEMjRPU3BsRTVKL3dXT3VsRm5BcjVtQmRu?=
 =?utf-8?B?a25wZS9vcEZJMTNoaHhCWWRaUUtOMVFQOEwzb0p2TFJLL0lhVStHYTltcTVW?=
 =?utf-8?B?Z3F0YmdrblJyWnJ1UklYbFY3WTgzZHFtbk1IOUFibXlGeVZzN0ovdXZpdGM5?=
 =?utf-8?B?ZVYvVWJISElsU3B2MkNHeXk1dXdQRk9sN0JUdDIwMGRBOWlkRzhtZm4zbzVt?=
 =?utf-8?B?dDhVMlA3Um15WHY4QWt1MG9KY3pJSTVTbzlCQXcyRjR4OFpialh1Zmt4MSsx?=
 =?utf-8?B?ZmxNd3l5UG1maVhPWDBjdWpzRzBDMVJCaDJ4dzFSWnYxYmhicy9FOHhnbWZv?=
 =?utf-8?B?K3E0TWcwMEl4amFBQVJURDRFSFFUUGJ5UW1PblBoY2FMczU1WjB2RkVGUkJS?=
 =?utf-8?B?NndDRlJadCtLUjNxc2xmUWRqc0RCSFMzOGxrVHhsOUdCOUZOeU92a25aNElQ?=
 =?utf-8?B?V0JSNnJHaDlSMVQ5OEpuSTZaWWdvU0JuUjFRMWFCS2F6aXdLbnR6aHZBeExw?=
 =?utf-8?B?dXlDWkdxcXRFYXlvNUNTSndPbExoTXB4Qk5EMkh4RmpvYnBQV2Y2QmlsYkFI?=
 =?utf-8?B?aTlBSEFWbzdkdW9LaEc1SzhWclJBOTJKazdTaDhtVHlCNXoxVFFxNjlVWkJy?=
 =?utf-8?B?RU00ZkpOUVFyaGxIdm44K3BxRkhEajBaYW41WlhhQUhVclJMOHFMRytJYXdp?=
 =?utf-8?B?SEtBZExxVTRmNEQ1MUdFcnFhYWNJOGFYWlJTS3czQnI1VXVqanRTSnROeC9T?=
 =?utf-8?B?a1IxTmZBbi9WRzBVUDdrb0F0ZTArTHo4c0llOXlwWkx0dzlseURSWENIejYw?=
 =?utf-8?B?UjJCcFFTcE12SWJwc09rT1Q0dzI5Um15NWFaZ2tXbFdPTzdnZ2g4REMzU3BW?=
 =?utf-8?B?eTZaKzBIS0pXQlpuSFZaQzFONWpYcWMrZGVtTnQ1bktPOTRUenFrZmVKZWUv?=
 =?utf-8?B?UUdMaU9HZGYxMGZwR0ozd0pMaFZIZWF1Zlkwb01lMmlsRnh2TjIzUld4UGhD?=
 =?utf-8?B?N2JRWGxUUGdUU3pUMndaUGhJK0g0ZWZBOCtUM0RSRmRDdU4zK21KaExYdkc5?=
 =?utf-8?B?aXZrRE1valJKRFZJSThqUU1jaDhBZG52UXpVNGxyRXJDa053OUJvUVhKaVZp?=
 =?utf-8?B?QS9pTFlTeFV3RVcwVDFoakV6NkxCZFpKVEpGTzdyOFQ2dUZJK25CcmtGUWdE?=
 =?utf-8?B?YWw1ZS9FYWd2VEM4TmtUczAwUGtyRWFweTdSNzV6a0Q4eGNLVTVNSXFQUmtO?=
 =?utf-8?B?ZHVoY0ZmaWkxMkQzV1pGV0V5d1dKOTdEdUdxRnpwY1p1eTR2RmRsa2R6b00r?=
 =?utf-8?B?YkdCQm02dVc0MElXSE1yK1p0RUJRMGJsZWdGTlpPSkZyUzZtWWdwNzNhN2Qr?=
 =?utf-8?Q?0uelFgYhAjqHa/js=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5fb628-6a5d-4452-5486-08df4905994b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:00:50.4361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJZC+u12qC/3+qXFbF55fSl679R97svQomnYRHscha2CdMuczhfJHrMn/3vGYBeITxColZNdO4U6ZGtjHw+OlH7c7OCHlUPKIGQMkMV37fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6644
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSGVpa28sDQoNCg0KQWx0ZXJhIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBIZWlrbyBTY2hvY2hlciA8aHNAbmFibGFkZXYuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIE5vdmVtYmVyIDExLCAyMDI2IDQ6NTIgUE0NCj4gVG86IEFsaWYgWmFrdWFu
IFl1c2xhaW1pIDxhbGlmLnpha3Vhbi55dXNsYWltaUBhbHRlcmEuY29tPjsgVS1Cb290IE1haWxp
bmcNCj4gTGlzdCA8dS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZz4NCj4gQ2M6IERpbmVz
aCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5p
QGtvbnN1bGtvLmNvbT47IFByYW5hdiBUaWxhayA8cHJhbmF2LnZpbmF5dGlsYWtAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtyZXNlbmQgMi8yXSBjbWQ6IGkzYzogZHJvcCB1bnVzZWQgaW5jbHVk
ZXMgYW5kIHNraXAgZW1wdHkNCj4gZGV2aWNlIHNsb3RzDQo+DQo+IFtDQVVUSU9OOiBUaGlzIGVt
YWlsIGlzIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4gVW5sZXNzIHlvdSB0cnVzdCB0
aGUNCj4gc2VuZGVyLCBkbyBub3QgY2xpY2sgb24gbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyBh
cyBpdCBtYXkgYmUgYSBmcmF1ZHVsZW50DQo+IGVtYWlsIGF0dGVtcHRpbmcgdG8gc3RlYWwgeW91
ciBpbmZvcm1hdGlvbiBhbmQvb3IgY29tcHJvbWlzZSB5b3VyDQo+IGNvbXB1dGVyLl0NCj4NCj4g
SGVsbG8gQWxpZiwNCj4NCj4gT24gMDYuMTEuMjYgMDQ6MTgsIGFsaWYuemFrdWFuLnl1c2xhaW1p
QGFsdGVyYS5jb20gd3JvdGU6DQo+ID4gRnJvbTogQWxpZiBaYWt1YW4gWXVzbGFpbWkgPGFsaWYu
emFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+DQo+ID4NCj4gPiBSZW1vdmUgaGVhZGVycyB0aGF0
IHRoZSBjb21tYW5kIGRvZXMgbm90IHVzZSwgYW5kIHNraXAgTlVMTCBpM2NkZXYNCj4gPiBlbnRy
aWVzIHdoZW4gbGlzdGluZyBkZXZpY2VzIHNvIGEgZGV0YWNoZWQgREFUIHNsb3QgY2Fubm90IGZh
dWx0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpZiBaYWt1YW4gWXVzbGFpbWkgPGFsaWYu
emFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+DQo+ID4gLS0tDQo+ID4gICBjbWQvaTNjLmMgfCAx
OCArKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQ0KPg0KPiBSZXZpZXdlZC1ieTogSGVpa28gU2Nob2NoZXIgPGhz
QG5hYmxhZGV2LmNvbT4NCj4NCj4gQERpbmVzaDogVGhlIHBhdGNoIGlzIGFwcGxpZWQgdG8gbWUg
aW4gcGF0Y2h3b3JrLCBjYW4gSSBtb3ZlIGl0IHRvIHlvdT8NCj4gKFBsZWFzZSBzZW5kIG1lIHlv
dXIgcGF0Y2h3b3JrIHVzZXJuYW1lLCB0aGFua3MhKQ0KPg0KPiBieWUsDQo+IEhlaWtvDQo+IC0t
DQo+IE5hYmxhIFNvZnR3YXJlIEVuZ2luZWVyaW5nDQo+IEhSQiA0MDUyMiBBdWdzYnVyZw0KPiBQ
aG9uZTogKzQ5IDgyMSA0NTU5MjU5Ng0KPiBFLU1haWw6IG9mZmljZUBuYWJsYWRldi5jb20NCj4g
R2VzY2jDpGZ0c2bDvGhyZXIgOiBTdGVmYW5vIEJhYmljDQoNCkRpbmVzaCBoYXMgYWxyZWFkeSBs
ZWZ0IEFsdGVyYSBhbmQgaGlzIEFsdGVyYSBlLW1haWwgaXMgbm8gbG9uZ2VyIHZhbGlkLiBBcmUg
eW91IGFibGUgdG8gaGVscCB0byBwdWxsIHRoaXMgaW4/DQoNClRoYW5rcywNCkFsaWYNCg==
