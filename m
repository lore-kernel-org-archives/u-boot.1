Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB45C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 13:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA08260799;
	Tue, 15 Sep 2026 13:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id khz-uPVV41w3; Tue, 15 Sep 2026 13:04:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F1C3F6077E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789477443;
	b=gmZ8Fiu84SlFs8FnWNipSUFG2RhFL34yW/ueR65IyG627Owi7uyrtl6OfOciApQ5rFHz
	 cWIWkZ3/j5odr8U/ylfeVURI2b8hS8c5LwyZNsX/dJNGuU3jFQsTZrDtWHpg3nDDzRmVu
	 G3RsK6JEFKblSQd+EY0ffttRQFlfLDbCRD2XfsT3L1ywygy4KC7eH6JthFZhSvG2k0X5q
	 pi40iA97KWRO4QlgAihoMUHJ+A05IvL9xm7jSxFqAY6yc90jQMgHLa440kN4C+mi5jAPK
	 aFK605hox633mESAYVhJ3UlS9ktAqz7fPTuM/aR8tODvvW0dhqLkg+hys4P4LBLEr3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789477443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
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
	bh=YPyMh2pki2AXvs3gtk0tU4eko6OL5uxdOq5NzppzwwU=;
	b=oZLGvi+ui1gdSgo7MxjPvvNcUq2/Ub6dOm9UL/2Z4DTAlJ46jTz2FCScsicJnnyz5AC2
	 QMWYdpaGpJnMhWmpvM2o3o/I55xfDGba/Cj0v+FhNnDDIi2NYs+R5xVOxiFv/lVvI4wP6
	 qpi4oa7NpMlgqdCNA7m3uneUmBfo0PtaWJL4Tq4XFVgRcMQNmXXfNLzDcegg5L4NOjlPY
	 jo0qW3UnA2MeEYisTYVcVMFz0ZazC7smXq8PX4YjwxmilvKUq5/7ZEevRRDaIvsHTcMTZ
	 ufHlAnAt+/ra/yy+3JxUoXul/AkDxji0UWoXk/nmOmT9AlRFekGBsHx1sacP3mZSapQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789477443;
	bh=YPyMh2pki2AXvs3gtk0tU4eko6OL5uxdOq5NzppzwwU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NAvPlAEwhs3CgaTlqqY//m3aDMk28jYvP7088HgdMk3DkmnPbvsq/2gLX9hguT9lt
	 QZLKQQSitHbdkbOZ9wq31qZ7cteyZjX9iOu2qc9IDBlCEIXp44J8XXE3RO9c4Jb19q
	 1Y6Qp+zm5E8lg/0GVGjARAxiN5M3zu1ZFcQklWEGBC7gy1jNAKXlEdCagiB585TLvM
	 CUjwDtqam+So3Bg4VMqf7mp28mV4Le5nz3UVPYyt87YNw/IkmIxVKNMUXH235MNDtj
	 eWoztvuFk0Wk0xhIF7b2ey2AInVuZgNTwveghRuGBb+kAXyYLdw2HHAWrGZ8PccKT3
	 mvN40XNuHYqrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1C3F6077E;
	Tue, 15 Sep 2026 13:04:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEADA224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D470F401DD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzdv7QaJYJyd for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 13:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4D3864009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789477440;
 b=LbWY81Q0rLEYs1jf9JjVXe5ZkIo17JG7R+okI+uS8heF3l+VKj1AhitKgu79woydB+WA
 gJ7xAQ6NBn3JUn0VVET4tAqwVyuZnclCjm8bdP8bsPZr5QzRtGPiH3+Y9CsKX597eYMWF
 Dm+tjYhGAQ5AY8fn1nVAfE0oyAeJkBh7F9F1zuX3/O6xJVnUbj8y96Tbe4nFd+DunQXmx
 so+SW8yk9Vf+idT6dA36NcbQBM/WRXsCjPTywbi/++UEiJdvvtvNcNj/vGvORosUhJTjV
 6eaAnloD3bk+2falTHCYgVLMQTlDD3qt2iljTGKYX9hnoTbNxM4CmlOm6KPgPgopj8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789477440;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=YPyMh2pki2AXvs3gtk0tU4eko6OL5uxdOq5NzppzwwU=;
 b=oY/HJBwdNIiP5IH/Z+TOvXrl7N2YlK/SMAbAuLwz/sM1PQKxSUs/BCLElOspJ+IYr+TK
 Wg2IYyrbzPvESLFbRwW5oVr4Ml+Kya2amvA79iQngaTaIUR2SM6dHUeFzO8MNULoCjwmb
 eiQvS0ASQvlW73Te4sZFVP30OVOdXybuhjUSyuw0V4HBYzzTC74Jy+3LpAIKUuylSB1vb
 ewVIGdt+P3CEs+07/A/WZFUQqHV9QwSgyfum1CUUayvHE03Rs2TflM0qMMeRcYyBtlXaY
 PvWOBuCQkj3sSSUrDp6RCC6niDhnkH04kx4WlxloYu7lTAZ0JQNZcp6ylG1S7ADWr3g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=phytec.de; 
 dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=eMQnaKJQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=l.anderweit@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=eMQnaKJQ
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D3864009D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWW7Juoxu4k/Vgg1GjzjIo5BW4dpKJZRdHdYkuONB3ZwUp0cg5NepQVN6lbcETLcVkrdBVKeoGZ61ncIegC3lPcdOv6/7SrYF/mCDGWSedhK2rqU/npi0nMaxEnPYKmcC4U94TJ/84wMs1PTMxAhurdef/n8QrtdgjwbAeAcnt+kEs+bLiOdM7uiqUYJIoaGk9um9+SA8HlITCke7LA2rQEuUyDLu+iXsGJgvmWNpMbxywP6IdJkRmXiTO3Xw0SAFXC5L3APqpNrIfd12zqnIqJPLG8uPALtxDjrqm47NxXxlvhnBVbVjswjd288vvIEysCYFbspkXIpnr6Nz2hAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPyMh2pki2AXvs3gtk0tU4eko6OL5uxdOq5NzppzwwU=;
 b=M9b3p86FWaDUN0eRoxQ6X9JEyD5h8UrJR+pnBrR9Ryj+8oqbdQfPrkg5a60YB5Kcrb0aJqXs5O4akL+L4feGm553JHALU3iQXAZ3Ba3ntNw1M1zhljCe2KWV0XAFcpReSWxumwqgpx20+U9Q8osOCs3QkyuZ7P4qhhf+9MoAgEC7YrMSNoVvA8PV7X/rGFjCJLYYBCfdBcafa1Ib/NOnh8yxNrUfuHvGHgAljhzaQrjbWuErpmMG8OOd3jcsBj7/qCdlJkDuPtrHcMVmHO1BjzV8XEZoPBwrg0ssQVxW2HwN31gtn/QvdM4fZ1S9gDRALd1MmZlOIHiraY1OHWRRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPyMh2pki2AXvs3gtk0tU4eko6OL5uxdOq5NzppzwwU=;
 b=eMQnaKJQl/ijxxUnKu/RgScm55PMInyDhFAZdG2BXOBUIDPSk04aXDyA/QLKoUI8/rwLrUfySlhv+jfwa2TK0ydSJE1nDT+m52Bc0JnHYVwIzMGHsJi1uKxZ8oSVO8Wg59QOsV7SUpvD9jrdLBCexWtlTqvYXmywOFKeC/K8+6KkGFEidlzeYy49IGZU2iHUVgCLVuXXPg8XE6KsDO1akeCcG3xeWqARMlSE3rH3wObmvm5DA19fxtugOIQUJt5TwX+dQSYP55j5mU7gvHx+zHq20NTwlLaSv8cty4BPce/dp8YI29uKwSRk0ezINtSJCPQ5YldlUDPgtwo6O1oLpA==
Received: from DB8P195MB0536.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15f::21)
 by AM9P195MB1202.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:38b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 13:03:52 +0000
Received: from DB8P195MB0536.EURP195.PROD.OUTLOOK.COM
 ([fe80::4d7a:eec5:7465:2f90]) by DB8P195MB0536.EURP195.PROD.OUTLOOK.COM
 ([fe80::4d7a:eec5:7465:2f90%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:03:51 +0000
From: Leonard Anderweit <l.anderweit@phytec.de>
To: "ludwig.nussel@siemens.com" <ludwig.nussel@siemens.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "anshuld@ti.com" <anshuld@ti.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>, "sjg@chromium.org"
 <sjg@chromium.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v9 4/8] image-fit-sig: Optionally require signatures
Thread-Topic: [PATCH v9 4/8] image-fit-sig: Optionally require signatures
Thread-Index: AQHdRRFAgrvnWCJv00GdoAOIChNrTbbPmyyA
Date: Tue, 15 Sep 2026 13:03:51 +0000
Message-ID: <5b8121f3987581350bce23e171d8b32a1cc586bb.camel@phytec.de>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
 <20260915145217.v9.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260915145217.v9.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P195MB0536:EE_|AM9P195MB1202:EE_
x-ms-office365-filtering-correlation-id: b829bbf4-cd44-44c5-3b69-08df1329ca58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|3023799007|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 45qgMPKVmD+cx1+c0QdJf0saBoQ4vb+oigA7FntkWAobqV+DZtBAaDwlgpUx5RqQ1vgxoraR/sCzXIV17ho12azkAdPecTEgA1vx/ecxz+KohiMUiQJEkzEZjnTqBUh7zv6g+EDQTj/rC8u0N5e/RBgB5f0tgDcL3iOHbou7IEnp0Xb3mOE+2JlIXLEXa5MR9qcXzOlsqFhi7+9VkJ+x9EOP8dhb4ZxmRbCY+fkvK5+Hhb9Ko4BI+wNw0UhySiWlgu+D2vAFWT9GfGysEStDiNgupVV13CY/pPvEeyq575HuUebFwOjANw20ZFjE7moM37Vo5eaRgzecM2eG+qDkJWf/LA+psd8cutSKPb+pD2TCorUqAfrUacrXbp6QVjO4uyIeVoh0bpvZAAhhleuYiZrQqDjNDdA/RYum4okPDjsUfOCw5agmqhJ+t/IZVbb0/PdrDWxe+RuKurHQfkY/rrtcZUmGAG+kJJRFwks3UkuJBDiSG7oilBaFJR+aqyz3zlEgcKj5NXjbhrs1jA2TgBmg//UWB0coAlulSlWy3Ip7OlwA49r8RfEccrJrabQRaK6lRlRxvn2vyp8JcfqOg3G95qtB63NeTyUyiudxEDAWqws5L1cO3JuLOMyD+SIiLBbJcQYfW7NhwtH2lLkJza0nyBhM89bGuqPYPZb32wKQ/pObseJ5HRcjviTZ7jEVdNRzv5j4MaqFlO3edUNTj1p5FfxbqGwQt8nF4VxkphI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P195MB0536.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWg5QndRTjRnVVNSeFRMRXhZM0JRckRNZkFjRHIrUHRCUElZWHhIRlQ0b2ZW?=
 =?utf-8?B?cFBpYUtaVjRQRWlFakwwM3d0QWU5cXBmSFFaTmFrbCtNVVIvb2dmcnhUMTBa?=
 =?utf-8?B?VlUwV3BsVWdrTCtjMVFnUXNBay9MdkhzMW9ha1FvQmNBaDJ2SWNURVkrVi9T?=
 =?utf-8?B?NXMxeFdCVFJCbVdKckp1MGFiNE1iK3hydEtUaGZsTXpvbzVFbkVNa3psbm92?=
 =?utf-8?B?d2FTV0dHdU1IUzZTK1BwUEIxNEhhd0F1WS96KzR6cFF3akNNVWZwRlJLOFZT?=
 =?utf-8?B?TE1aMkxrRHFRbWNQanoxNVhFSE1vMFV3U2ZFamN2SVBNTUpDcWhxZ2RwRmo0?=
 =?utf-8?B?dzBnaWpONWZEMityWnJYMFdVUktWODVHb2JJVHQrWGphRWVyRElwMXVudlFq?=
 =?utf-8?B?TERMQzA4akZBZVZ6M0tvTE5FNlhYSC93cXZmdVkwUEhwMTF0dnBnZC9BM0dn?=
 =?utf-8?B?UzRDbkp3V0xmR01UZU9RMTJmbzBFK3ZRZmxMVE1id2lMTHF4cVRCdG9LNGZD?=
 =?utf-8?B?aFd5TVFPVllMNS9PUnE3dDQ4KzZEOVdaTVJYZ2w3SERicnZ0ejFFZlhBdUFZ?=
 =?utf-8?B?RGsrZThZWVZ4QVFrY1l5Z2RkQUZRRk5FYXBMd042N2dPbGI3MWtnNFcwVG94?=
 =?utf-8?B?OEhwelY3QmZwaURGRmI3enBHdmNqRWExQ2NmMnJyMEYrNHRnczFtL2xGdUJ4?=
 =?utf-8?B?Kzk0elRUY2FRNFlhM05ZMFU1TkUyOEFWQmg3MEhMUkFqM1lPYlJvWTJaYjBx?=
 =?utf-8?B?RDNWQXdabmN0UkF5R1F6MlNJR05qTmlmR2xBQXM0VTc1UnY1U2V4MzBqcmxZ?=
 =?utf-8?B?N1Zmc2lYZkxzVFh4aXRaa2JGMDFObGxFK3hPcUhwbW12bFcrSFE2UFRHcGor?=
 =?utf-8?B?ODhtTzdnYVV3VGp3TmtRbGg5YkJJOVVTbmJXV2NUakFoTFdyVTVJbkltVXJG?=
 =?utf-8?B?R3dHdm85b2p5b0pUNTJUbjJKdm02YmNuUmZMQUF6dDZoazJLYURtZHVpOW1N?=
 =?utf-8?B?SzlHb3pWRkc2OXhJQU1GckluU3NqakthenpqeVpYYnNybURvYTZvZk5UbHVQ?=
 =?utf-8?B?ZklBQkxwMjJQemFRZGJFY1BPZ0M0bkJOaEl5RjZ0N0EyU2hqYk1iM2RwSkoz?=
 =?utf-8?B?dlFwZU1Pb2NISXRyenN6Q2FFRG5VWDFBNU9qU1hnVm4zdkhrYnNPaVpTUHlP?=
 =?utf-8?B?RVNQL2hPc3FYY004bVE4VW1FeDNUUjRySGxJMGgveGxGUHRWU1pPbE4rMTJ2?=
 =?utf-8?B?dWFBSzZhY1JveTNCSHQybmhGdW1qTVNKVkRVWUQwVjZXY0hHMW5rWmZ1NHpw?=
 =?utf-8?B?STJWOTF4RkRSdlNZSS9xbXpTR0tOc2I3YmFwZXFZa2NyNjl1T1o0ZENDNE1z?=
 =?utf-8?B?dmgvTFNWbUxicW94TVkra3NDYUl5T052dTJQUGoycXlDd3FhNk1TZENwTXgv?=
 =?utf-8?B?djF6bnRndzM3cXphdGpxc2IzUG1Va0RkRTlNUEQ1aC9Ray9uSE51bGpheDJV?=
 =?utf-8?B?cHYraUgyS2ZpWlQ5eVlaR2JMSXFlU2JyR2RqendvRUhqNmhvcjRxc0o4RElk?=
 =?utf-8?B?SlRuYmNRSzhWMkphaFV4TGkwb2tMQ0NoaVN6WkpsV3N6NG5SYWl2ZmM1d3ZL?=
 =?utf-8?B?MFAwNUpjS3FwbzFHa053cC9JZHlDU1RNUVRESlA4emN2UXRndU9JdzFFcEEv?=
 =?utf-8?B?T1crTmlhNXVqRjRiOUxEOFFGclpzNnEwNXlxUDViaFg3b0xENHlEdnY3ZnBu?=
 =?utf-8?B?bndUbFVvTEJQeERQc2IyZmhaQTd0eW12eEFKMzdKN3hxZUU4WThuQTVwRTNY?=
 =?utf-8?B?UHJWUUgzY0V0Z3BJemJmRHY0b3ROL1ZrKzM4K3pQbmY5cUdSdnlBMmcwSTVi?=
 =?utf-8?B?eldpN3I2bU96OWFCaGNIN0hwTjVmbnlPMHMxcDZ4QTVmS1pvVnFRUFpoNUNo?=
 =?utf-8?B?RENmN011aXBvYXkyTE1HVVY1REF3VW1zcW5KMmlVemQ3bDRxbkhzTXI0WW5O?=
 =?utf-8?B?YjlnNnFuN2R0VThYY0h6bUtvU0I4WjZxeTB5TWtSSUlyckJ1RnUydm5nM3JG?=
 =?utf-8?B?bW1VbU82L3JkVkFnQTRzaEkwUmtpazF1OXJnbWJPTkJKcUZKTDJOUlRzeFJs?=
 =?utf-8?B?Q1oraStDNENvdDA1bmJUV2NmaDA5NEk4MkZETnFETXFnWnA1azJhTC95d0pX?=
 =?utf-8?B?MkRPRnBQUkNpdFVMb3JYRXVxaENGVVczYTRiUHZRS1pwcytIa2V6YzZUVTJS?=
 =?utf-8?B?UUdnRDIzaHNGaVRxVUVycHN1UE9zUTJaRytiMjVzWTRDa0hTK0RMRTg5cjZh?=
 =?utf-8?B?dlgzUDRRUENyU3p0RmFFSzl3bVV3SHRqTTdxTHVLMERPOWgrdEkxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E02049FB74F0D2428721C92E67997C6B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P195MB0536.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b829bbf4-cd44-44c5-3b69-08df1329ca58
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 13:03:51.8728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyKZhvOwaeZMsnAdbzxC6740GMVcxSxdCXU5tQxPoERP2myIcCU2gtmKwxhHaYhQEGm1YR1NehjFssK/UdPGiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1202
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

SGksDQoNCkFtIERpZW5zdGFnLCBkZW0gMTUuMDkuMjAyNiB1bSAxNDo1MiArMDIwMCBzY2hyaWVi
IEx1ZHdpZyBOdXNzZWw6DQo+IElmIFUtQm9vdCBpcyBidWlsdCB3aXRoIHNpZ25hdHVyZSB2ZXJp
ZmljYXRpb24gYnV0IG5vIGtleXMgYXJlDQo+IGluY2x1ZGVkIGluIHRoZSBkZXZpY2UgdHJlZSwg
dGhlIGJvb3Qgd291bGQgc3RpbGwgY29udGludWUuDQo+IEludHJvZHVjZSBGSVRfU0lHTkFUVVJF
X1JFUVVJUkVEIHRvIGF2b2lkIGEgZmFpbC1vcGVuIHNldHVwLg0KeW91IGFyZSBzdGlsbCB1c2lu
ZyB0aGUgb2xkIG5hbWUgb2YgdGhlIG5ldyBvcHRpb24gaGVyZS4NCg0KUmVnYXJkcywNCkxlb25h
cmQNCg0KPiBEZWZhdWx0cyB0byBvZmYgc28gZXhpc3Rpbmcgc2V0dXBzIGFyZSBub3QgYWZmZWN0
ZWQ7IGJvYXJkcyB3YW50aW5nDQo+IGZhaWwtY2xvc2VkIGJlaGF2aW91ciBtdXN0IGVuYWJsZSBp
dCBleHBsaWNpdGx5Lg0KPiANCj4gQ29uc2lzdGVudGx5IHVzZSBsb2dfZXJyIGZvciBlcnJvcnMg
aW4NCj4gZml0X2NvbmZpZ192ZXJpZnlfcmVxdWlyZWRfa2V5cygpDQo+IHdoaWxlIGF0IGl0DQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWR3aWcgTnVzc2VsIDxsdWR3aWcubnVzc2VsQHNpZW1lbnMu
Y29tPg0KPiBSZXZpZXdlZC1ieTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IC0t
LQ0KPiANCj4gQ2hhbmdlcyBpbiB2OToNCj4gLSByZXN0b3JlIGRlYnVnIG1lc3NhZ2UgaW5zdGVh
ZCBvZiBlcnJybw0KPiANCj4gQ2hhbmdlcyBpbiB2NzoNCj4gLSBtZW50aW9uIENPTkZJR19GSVRf
UkVRVUlSRV9DT05GSUdfU0lHUyBpbiBkb2N1bWVudGF0aW9uDQo+IA0KPiBDaGFuZ2VzIGluIHY0
Og0KPiAtIHJld29yZCBLY29uZmlnIGhlbHAgdGV4dA0KPiAtIHJlbmFtZSBvcHRpb24gdG8gRklU
X1JFUVVJUkVfQ09ORklHX1NJR1MNCj4gLSBpbnRyb2R1Y2UgU1BMX0ZJVF9SRVFVSVJFX0NPTkZJ
R19TSUdTDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIGNsYXJpZnkgZXJyb3IgbWVzc2FnZSB3
aGVuIG5vIGtleXMgd2VyZSBmb3VuZA0KPiAtIGNoYW5nZSBwcmludGZzIHRvIGxvZ19lcnINCj4g
LSByZXdvcmQgS2NvbmZpZw0KPiAtIGtlZXAgRklUX1NJR05BVFVSRV9SRVFVSVJFRCBvZmYgYnkg
ZGVmYXVsdA0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBpbnRyb2R1Y2UgRklUX1NJR05BVFVS
RV9SRVFVSVJFRA0KPiANCj4gwqBib290L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+IMKgYm9vdC9pbWFnZS1maXQtc2ln
LmPCoMKgwqDCoMKgwqDCoCB8IDE5ICsrKysrKysrKysrKystLS0tLS0NCj4gwqBkb2MvdXNhZ2Uv
Zml0L3NpZ25hdHVyZS5yc3QgfCAxMyArKysrKysrKysrLS0tDQo+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCA0NSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jv
b3QvS2NvbmZpZyBiL2Jvb3QvS2NvbmZpZw0KPiBpbmRleCBhZTZmMDlhNmVkZS4uYzM2YTQwMzA2
M2UgMTAwNjQ0DQo+IC0tLSBhL2Jvb3QvS2NvbmZpZw0KPiArKysgYi9ib290L0tjb25maWcNCj4g
QEAgLTEyNCw2ICsxMjQsMjMgQEAgY29uZmlnIEZJVF9TSUdOQVRVUkUNCj4gwqAJwqAgZm9ybWF0
IHN1cHBvcnQgaW4gdGhpcyBjYXNlLCBlbmFibGUgaXQgdXNpbmcNCj4gwqAJwqAgQ09ORklHX0xF
R0FDWV9JTUFHRV9GT1JNQVQuDQo+IMKgDQo+ICtjb25maWcgRklUX1JFUVVJUkVfQ09ORklHX1NJ
R1MNCj4gKwlib29sICJSZXF1aXJlIGNvbmZpZ3VyYXRpb24gc2lnbmF0dXJlIHZlcmlmaWNhdGlv
biBvZiBGSVQNCj4gdUltYWdlcyINCj4gKwlkZXBlbmRzIG9uIEZJVF9TSUdOQVRVUkUNCj4gKwlo
ZWxwDQo+ICsJwqAgVGhpcyBvcHRpb24gcmVxdWlyZXMgdGhhdCBGSVQgdUltYWdlcyBoYXZlIGNv
bmZpZ3VyYXRpb24NCj4gKwnCoCBub2RlcyB0aGF0IGFyZSBzaWduZWQgb3IgYm9vdCB3aWxsIGZh
aWwuDQo+ICsJwqAgVGhhdCBtZWFucyB0aGUgVS1Cb290IGRldmljZSB0cmVlIG11c3QgY29udGFp
biBhDQo+ICsJwqAgIi9zaWduYXR1cmUiIG5vZGUgYW5kIGF0IGxlYXN0IG9uZSBwdWJsaWMga2V5
IHdpdGgNCj4gKwnCoCByZXF1aXJlZD0iY29uZiIuDQo+ICsJwqAgQWxsIGNvbmZpZ3VyYXRpb24g
c2VjdGlvbnMgb2YgYSBGSVQgZmlsZSBtdXN0IGJlIHNpZ25lZA0KPiArCcKgIHVzaW5nIHRob3Nl
IGtleXMgYmFzZWQgb24gInJlcXVpcmVkLW1vZGUiIHBvbGljeS4NCj4gKwnCoCBUaGUgb3B0aW9u
IGlzIHVzZWZ1bCB0byBhdm9pZCBmYWlsLW9wZW4gc2l0dWF0aW9ucyBzbyBpdA0KPiArCcKgIGlz
IHJlY29tbWVuZGVkIHRvIGVuYWJsZS4gVGhlIG9wdGlvbiBjdXJyZW50bHkgZGVmYXVsdHMgdG8N
Cj4gKwnCoCBvZmYgdG8gYXZvaWQgYnJlYWtpbmcgZXhpc3Rpbmcgc2V0dXBzLiBLZWVwIGl0IG9m
ZiBpZiB5b3UNCj4gKwnCoCBuZWVkIHRvIHJldXNlIHRoZSBzYW1lIHUtYm9vdCBiaW5hcnkgaW4g
c2V0dXBzIHdpdGhvdXQNCj4gKwnCoCBrZXlzIG9yIHJlbHkgb24gaW1hZ2Ugbm9kZSBvbmx5IHNp
Z25hdHVyZXMuDQo+ICsNCj4gwqBjb25maWcgRklUX1NJR05BVFVSRV9NQVhfU0laRQ0KPiDCoAlo
ZXggIk1heCBzaXplIG9mIHNpZ25lZCBGSVQgc3RydWN0dXJlcyINCj4gwqAJZGVwZW5kcyBvbiBG
SVRfU0lHTkFUVVJFDQo+IEBAIC0yMjQsNiArMjQxLDExIEBAIGNvbmZpZyBTUExfRklUX1NJR05B
VFVSRV9NQVhfU0laRQ0KPiDCoAnCoCBkZXZpY2UgbWVtb3J5LiBBc3N1cmUgdGhpcyBzaXplIGRv
ZXMgbm90IGV4dGVuZCBwYXN0DQo+IGV4cGVjdGVkIHN0b3JhZ2UNCj4gwqAJwqAgc3BhY2UuDQo+
IMKgDQo+ICtjb25maWcgU1BMX0ZJVF9SRVFVSVJFX0NPTkZJR19TSUdTDQo+ICsJYm9vbCAiUmVx
dWlyZSBzaWduYXR1cmUgdmVyaWZpY2F0aW9uIG9mIEZJVCBmaXJtd2FyZSB3aXRoaW4NCj4gU1BM
Ig0KPiArCWRlcGVuZHMgb24gU1BMX0ZJVF9TSUdOQVRVUkUNCj4gKwlzZWxlY3QgRklUX1JFUVVJ
UkVfQ09ORklHX1NJR1MNCj4gKw0KPiDCoGNvbmZpZyBTUExfTE9BRF9GSVQNCj4gwqAJYm9vbCAi
RW5hYmxlIFNQTCBsb2FkaW5nIFUtQm9vdCBhcyBhIEZJVCAoYmFzaWMgZml0SW1hZ2UNCj4gZmVh
dHVyZXMpIg0KPiDCoAlkZXBlbmRzIG9uIFNQTA0KPiBkaWZmIC0tZ2l0IGEvYm9vdC9pbWFnZS1m
aXQtc2lnLmMgYi9ib290L2ltYWdlLWZpdC1zaWcuYw0KPiBpbmRleCA0MzNkZjIwMjgxZi4uMGUw
NDA4OWZkZTAgMTAwNjQ0DQo+IC0tLSBhL2Jvb3QvaW1hZ2UtZml0LXNpZy5jDQo+ICsrKyBiL2Jv
b3QvaW1hZ2UtZml0LXNpZy5jDQo+IEBAIC02MzIsNyArNjMyLDcgQEAgc3RhdGljIGludCBmaXRf
Y29uZmlnX3ZlcmlmeV9yZXF1aXJlZF9rZXlzKGNvbnN0DQo+IHZvaWQgKmZpdCwgaW50IGNvbmZf
bm9mZnNldCwNCj4gwqAJICogbmFtZSByb290IGJ1dCBkaWZmZXJlbnQgQCBzdWZmaXggdG8gYmUg
ZXF1YWwNCj4gwqAJICovDQo+IMKgCWlmIChzdHJjaHIobmFtZSwgJ0AnKSkgew0KPiAtCQlwcmlu
dGYoIkNvbmZpZ3VyYXRpb24gbm9kZSAnJXMnIGNvbnRhaW5zICdAJ1xuIiwNCj4gbmFtZSk7DQo+
ICsJCWxvZ19lcnIoIkNvbmZpZ3VyYXRpb24gbm9kZSAnJXMnIGNvbnRhaW5zICdAJ1xuIiwNCj4g
bmFtZSk7DQo+IMKgCQlyZXR1cm4gLUVQRVJNOw0KPiDCoAl9DQo+IMKgDQo+IEBAIC02NDEsNiAr
NjQxLDggQEAgc3RhdGljIGludCBmaXRfY29uZmlnX3ZlcmlmeV9yZXF1aXJlZF9rZXlzKGNvbnN0
DQo+IHZvaWQgKmZpdCwgaW50IGNvbmZfbm9mZnNldCwNCj4gwqAJaWYgKGtleV9ub2RlIDwgMCkg
ew0KPiDCoAkJZGVidWcoIiVzOiBObyBzaWduYXR1cmUgbm9kZSBmb3VuZDogJXNcbiIsIF9fZnVu
Y19fLA0KPiDCoAkJwqDCoMKgwqDCoCBmZHRfc3RyZXJyb3Ioa2V5X25vZGUpKTsNCj4gKwkJaWYg
KENPTkZJR19JU19FTkFCTEVEKEZJVF9SRVFVSVJFX0NPTkZJR19TSUdTKSkNCj4gKwkJCXJldHVy
biAtRVBFUk07DQo+IMKgCQlyZXR1cm4gMDsNCj4gwqAJfQ0KPiDCoA0KPiBAQCAtNjc0LDggKzY3
Niw4IEBAIHN0YXRpYyBpbnQgZml0X2NvbmZpZ192ZXJpZnlfcmVxdWlyZWRfa2V5cyhjb25zdA0K
PiB2b2lkICpmaXQsIGludCBjb25mX25vZmZzZXQsDQo+IMKgCQkJCQnCoMKgwqAgbm9mZnNldCk7
DQo+IMKgCQlpZiAocmV0KSB7DQo+IMKgCQkJaWYgKHJlcWRfcG9saWN5X2FsbCkgew0KPiAtCQkJ
CXByaW50ZigiRmFpbGVkIHRvIHZlcmlmeSByZXF1aXJlZA0KPiBzaWduYXR1cmUgJyVzJ1xuIiwN
Cj4gLQkJCQnCoMKgwqDCoMKgwqAgZml0X2dldF9uYW1lKGtleV9ibG9iLA0KPiBub2Zmc2V0LCBO
VUxMKSk7DQo+ICsJCQkJbG9nX2VycigiRmFpbGVkIHRvIHZlcmlmeSByZXF1aXJlZA0KPiBzaWdu
YXR1cmUgJyVzJ1xuIiwNCj4gKwkJCQkJZml0X2dldF9uYW1lKGtleV9ibG9iLA0KPiBub2Zmc2V0
LCBOVUxMKSk7DQo+IMKgCQkJCXJldHVybiByZXQ7DQo+IMKgCQkJfQ0KPiDCoAkJfSBlbHNlIHsN
Cj4gQEAgLTY4NSw5ICs2ODcsMTQgQEAgc3RhdGljIGludCBmaXRfY29uZmlnX3ZlcmlmeV9yZXF1
aXJlZF9rZXlzKGNvbnN0DQo+IHZvaWQgKmZpdCwgaW50IGNvbmZfbm9mZnNldCwNCj4gwqAJCX0N
Cj4gwqAJfQ0KPiDCoA0KPiAtCWlmIChyZXFkX3NpZ3MgJiYgIXZlcmlmaWVkKSB7DQo+IC0JCXBy
aW50ZigiRmFpbGVkIHRvIHZlcmlmeSAnYW55JyBvZiB0aGUgcmVxdWlyZWQNCj4gc2lnbmF0dXJl
KHMpXG4iKTsNCj4gLQkJcmV0dXJuIC1FUEVSTTsNCj4gKwlpZiAoIXZlcmlmaWVkKSB7DQo+ICsJ
CWlmIChyZXFkX3NpZ3MpIHsNCj4gKwkJCWxvZ19lcnIoIkZhaWxlZCB0byB2ZXJpZnkgJ2FueScg
b2YgdGhlDQo+IHJlcXVpcmVkIHNpZ25hdHVyZShzKVxuIik7DQo+ICsJCQlyZXR1cm4gLUVQRVJN
Ow0KPiArCQl9IGVsc2UgaWYNCj4gKENPTkZJR19JU19FTkFCTEVEKEZJVF9SRVFVSVJFX0NPTkZJ
R19TSUdTKSkgew0KPiArCQkJbG9nX2VycigiTm8gc3VpdGFibGUga2V5cyBmb3VuZCBmb3INCj4g
Y29uZmlndXJhdGlvbiB2ZXJpZmljYXRpb25cbiIpOw0KPiArCQkJcmV0dXJuIC1FUEVSTTsNCj4g
KwkJfQ0KPiDCoAl9DQo+IMKgDQo+IMKgCXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvZG9jL3Vz
YWdlL2ZpdC9zaWduYXR1cmUucnN0DQo+IGIvZG9jL3VzYWdlL2ZpdC9zaWduYXR1cmUucnN0DQo+
IGluZGV4IGRhMDhjYzc1YzNhLi43MzE1M2M5NzM2NyAxMDA2NDQNCj4gLS0tIGEvZG9jL3VzYWdl
L2ZpdC9zaWduYXR1cmUucnN0DQo+ICsrKyBiL2RvYy91c2FnZS9maXQvc2lnbmF0dXJlLnJzdA0K
PiBAQCAtNDIwLDExICs0MjAsMTQgQEAgYmVsb3cgZXhhbXBsZXM6Og0KPiDCoA0KPiDCoEVuYWJs
aW5nIEZJVCBWZXJpZmljYXRpb24NCj4gwqAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC1J
biBhZGRpdGlvbiB0byB0aGUgb3B0aW9ucyB0byBlbmFibGUgRklUIGl0c2VsZiwgdGhlIGZvbGxv
d2luZw0KPiBDT05GSUdzIG11c3QNCj4gLWJlIGVuYWJsZWQ6DQo+ICtJbiBhZGRpdGlvbiB0byB0
aGUgb3B0aW9ucyB0byBlbmFibGUgRklUIGl0c2VsZiwgdGhlIGZvbGxvd2luZw0KPiArc2V0dGlu
Z3MgY29uZmlndXJlIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gc3VwcG9ydDoNCj4gwqANCj4gwqBD
T05GSUdfRklUX1NJR05BVFVSRQ0KPiAtwqDCoMKgIGVuYWJsZSBzaWduaW5nIGFuZCB2ZXJpZmlj
YXRpb24gaW4gRklUcw0KPiArwqDCoMKgIHJlcXVpcmVkIHRvIGVuYWJsZSBzaWduaW5nIGFuZCB2
ZXJpZmljYXRpb24gaW4gRklUcw0KPiArDQo+ICtDT05GSUdfRklUX1JFUVVJUkVfQ09ORklHX1NJ
R1MNCj4gK8KgwqDCoCBtYWtlIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gbWFuZGF0b3J5DQo+IMKg
DQo+IMKgQ09ORklHX1JTQQ0KPiDCoMKgwqDCoCBlbmFibGUgUlNBIGFsZ29yaXRobSBmb3Igc2ln
bmluZw0KPiBAQCAtNDM2LDYgKzQzOSwxMCBAQCBXQVJOSU5HOiBXaGVuIHJlbHlpbmcgb24gc2ln
bmVkIEZJVCBpbWFnZXMgd2l0aA0KPiByZXF1aXJlZCBzaWduYXR1cmUgY2hlY2sNCj4gwqB0aGUg
bGVnYWN5IGltYWdlIGZvcm1hdCBpcyBkZWZhdWx0IGRpc2FibGVkIGJ5IG5vdCBkZWZpbmluZw0K
PiDCoENPTkZJR19MRUdBQ1lfSU1BR0VfRk9STUFUDQo+IMKgDQo+ICtXQVJOSU5HOiBDT05GSUdf
RklUX1JFUVVJUkVfQ09ORklHX1NJR1MgaXMgbm90IHNldCBieSBkZWZhdWx0IGZvcg0KPiArYmFj
a3dhcmRzIGNvbXBhdGliaWxpdHkuIEl0IGlzIHJlY29tbWVuZGVkIHRvIGJlIHR1cm5lZCBvbiB3
aGVuZXZlcg0KPiArY29uZmlndXJhdGlvbiBzaWduYXR1cmVzIGFyZSB1c2VkIHRvIGF2b2lkIGZh
aWwtb3BlbiBiZWhhdmlvcg0KPiArDQo+IMKgDQo+IMKgVGVzdGluZw0KPiDCoC0tLS0tLS0NCg0K
