Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59829CA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 12:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C703F81316;
	Thu,  1 Oct 2026 12:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EWrLU-Vfqgag; Thu,  1 Oct 2026 12:50:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E5AA8812EE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790859035;
	b=N42ghGVzJ69r6GluCqa4uAuKKqxGClV01wHsfa1YKVZdrsHUpKFUM7ZZiz8odrwrTP5d
	 NLa44i15CsD88OIwza+uImhLHPVekyUADPWJeGc+wMIleGDCfx5rPhHxAqjRFiVcVTiRZ
	 6kSscey9uUgMQ5WabiTuTH1fgljaNsEVZbREg29dgXH+Z/dWDSxgwTqiNSenqGfA1GZR3
	 1z/xjneyERlM2PKeGCYdOLT11X82OJx7ICLQd8Zbm3qgqjmvfCfDsVNIhlHdUYoyh3hMQ
	 6qJTEA/9ICnbw5h6msGGhXIXAh2roodl0ldY9YK5PSKMLOVUPXPhwJByPV6HjjaFS7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790859035;
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
	 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WjhfJUmX4stNhW2LD4LU9YGa/zK7z4hBA6jPVVp+Kuc=;
	b=TWT2qLdWpjYyb5abSK3W/1vQY7FytDHR5Ux8D+w362dowfi/0RybCywMCykrLWGXLotw
	 BaKmRwKmjEUKa1Xpt9tK2Wa824vajyeR47VL1o/6gBzzLkZIzxbHtac2Yvb6ciG0h9zqM
	 +kjDl+Ui3iGrALeUH7w1wX8DQKru2T44oFgwYl+O/kYeeFEvsr2/3rYajYBe87WSsKWLj
	 lKAHv+hPZvTxWarOL6Sf819cQemNcIeEcRQrL6ZAHvAu0Vm8iIaRV4lNJfOKGOFW0pmYP
	 663XfJJJdA2wWuu6GFKQcuhsmn0d592xkTQIisc4tkd3JSSgU2Xz60pT4z8JBqSRoNg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790859035;
	bh=WjhfJUmX4stNhW2LD4LU9YGa/zK7z4hBA6jPVVp+Kuc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MshHrJQwZ9Ql5EiIBcrdatn3FjmIRVER7YRDuU0RiN4Deo8xBkGubvotws9GuKxjT
	 /JK+SCzj6RojusEXz7GIYEve7quotZdbMWBPGlYPgsljuCGjAWfvNDTtX+YNTw6Ybc
	 srDxjTnpO+XychrK5i7AbZ0BgxisAz5s659+Gt/NOkpfDfl/bGg0bl0XU4XzeyJ8IW
	 PZxGxD/GT4Dtw14TsvSb+XtLfrOQ2EyagHNJdCpOi2XY2gZRus0EqGZ2AbXJhrNo9J
	 waPtUvoUIlUX5lsugeIYjZzDmqySLI1Szc66rj8IlbOcdQ+CctARrxEjR/MBNFtrbU
	 h6Rndh0+k42Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5AA8812EE;
	Thu,  1 Oct 2026 12:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9A8A263
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 05:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B713C60897
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 05:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t76BGeG-2ZQu for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 05:09:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7ACD56081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790831343;
 b=rOsnzHqJxBkyZJVYLTDnQ8AH16+P/voHJhaKN8mAEsud8i4+3ATj2jb56oJWa6ClaLhM
 FkLCP9vJ+Z4SoiA7mneHq8ohDgYvvfxy6MgyhVo+swDg6u7WfHG3zP2ZnV66Vsny/5cOp
 UtSXFQlzM87+JvuD5TlCTqf9MDrs+AUc5SqZS6foM7lcGtBtU0ualMFZjTbl6ZWc1So/2
 bdgptO1wRrfshcD2O9A6btO7Lgz4c8/i/yOkGkCFC7O6F1BH/CQmSe2qGGOOUs6gXzvxP
 7V0oEyPIoww0hZqT26D0TgqAHW8KTLG8DJ7Pouevzhw+6xMoNQ5oMPabkcS/Igq0YCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790831343;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:
 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=WjhfJUmX4stNhW2LD4LU9YGa/zK7z4hBA6jPVVp+Kuc=;
 b=G4imIekd2lBv59BisAg69bOcjxxxL59mnC7VBtYO8jJAFIhqas4uwJ3qPP2idfev5agz
 YtlWa5C62Z8suOqfrj4PRITbOb6BMRa8GN7VUWtDOdXop0p8wFe8bcdbUIoPEZBiZ29JQ
 gOeSoBpIwMTe7o3F0ZiZcEnaVmVPAZ1sE93IXruxqS/drMdpANKpkTlfZTIHaET96kyfO
 RUnK7rza879aQyldFAIjMhcOioqvuaHNccocpqQLQkipen0K7TeseJDamR8GCAcCudhxX
 a3K15h2R2hULZpPorzPhTQrynEbF0sMQiHuqH5/KZ73WT8aAPYYGZmfxmQkjrWbU0nA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=adlinktech.com; 
 dkim=pass header.d=adlinktech.com header.i=@adlinktech.com header.a=rsa-sha256
 header.s=selector2 header.b=JnRvSHx+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=dinesh.v@adlinktech.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=adlinktech.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=adlinktech.com header.i=@adlinktech.com
 header.a=rsa-sha256 header.s=selector2 header.b=JnRvSHx+
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7ACD56081D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 05:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veDL4vhqu3gyikeu9HWxK7c+zwLVty3uHWGo1YQmAry7WaARhiCH57BJlPC6TvE8x7Iop0rLUd5MVnuu8N3emI4XySGPMjvjPv/dGwDOAqLxuJMnPbgaWkmCs7pV94XGFfP89lNfhjQjNgBWkUNcVvyNil9nHqA2PUCkfoy9HqBqnX9vN6ngwXxtdtq5LrV6qzSZcOeMUIwrEyGfBps3hEaooVuOCcXSnx6VtWTM7QkxPvI5EgAfT2v4nQRBdOUoJLUjbNJWg0XfVEyYBXYe4ZUAbj+FLozLl5g7/XkOHZCOdRFo8WwHruMPBoGzQofPx2p6TpcuM5Jou1UYF9zgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=WjhfJUmX4stNhW2LD4LU9YGa/zK7z4hBA6jPVVp+Kuc=;
 b=kPFvCtAiBoyok2y+UxXkkchNCVoNZhv7dIpll5Pv/SPR3yuPsZs+3cVOvGERry4UY7mhPnhD3FmFvw8zW8QpZmnVO8DQNbEoYsUu0+TLbhWhndXLzYRJrI2bOMCQw2md68ii/S5nFxzKTF/78niHmcFh85Qw54g4502TZU3ttu2U0KzTrLd/U9GlZmw9Gd97bFJgF76YuXQ8axiIf2JeFwGwP4qFkxATYkk13I4pQQQTzhI0KKuPXL09Zzwab1KwSxwl+Hx8XSvKj07Wd0yCkUBhL9G41um6XdG6u/9A/n2HmscuK2YXB4E6VUNxAopCKzJ7E6GSHi1Zn1OVhxVi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adlinktech.com; dmarc=pass action=none
 header.from=adlinktech.com; dkim=pass header.d=adlinktech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adlinktech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjhfJUmX4stNhW2LD4LU9YGa/zK7z4hBA6jPVVp+Kuc=;
 b=JnRvSHx+nispOuk2SXFSBQHZLoqs8Q+rFJxBjfq71UhDP0EhBnUA6+t1xn4xCStLFHKtzO1dG6/MRek2VpyrbEo4vgUsiKdKffAUuDjQUYIL/CpoMcMh35pea92TQjtOJHBcGyzank6CnFDVi7/vmt1vGdGxK8e0lpu0VGOmYZg=
Received: from BL0PR05MB5475.namprd05.prod.outlook.com (2603:10b6:208:64::12)
 by BY3PR05MB8324.namprd05.prod.outlook.com (2603:10b6:a03:3c3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 05:06:51 +0000
Received: from BL0PR05MB5475.namprd05.prod.outlook.com
 ([fe80::d8da:8882:8f98:51a5]) by BL0PR05MB5475.namprd05.prod.outlook.com
 ([fe80::d8da:8882:8f98:51a5%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 05:06:51 +0000
From: Dinesh V <Dinesh.v@adlinktech.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Stefano Babic
 <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Alice Guo <alice.guo@nxp.com>, Primoz Fiser
 <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, Simona Toaca
 <simona.toaca@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 2/4] arm: dts: imx95: Add ADLINK LEC-iMX95 device tree
Thread-Topic: [PATCH 2/4] arm: dts: imx95: Add ADLINK LEC-iMX95 device tree
Thread-Index: AQHdTxxy1ylNcH1yHkGQj8ZAMuk9Ibbl1SgAgAJRHWc=
Date: Thu, 1 Oct 2026 05:06:51 +0000
Message-ID: <BL0PR05MB54756FA9CA2C8BA4C445BA2FEF8A2@BL0PR05MB5475.namprd05.prod.outlook.com>
References: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
 <20260928-lec-imx95-v1-v1-2-9e0c9b94ccbe@adlinktech.com>
 <CAOMZO5DXTiN0t1imDLA5zWb=q2XN0X5C9rJHTrUvHjuWrA5Wgw@mail.gmail.com>
In-Reply-To: <CAOMZO5DXTiN0t1imDLA5zWb=q2XN0X5C9rJHTrUvHjuWrA5Wgw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adlinktech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5475:EE_|BY3PR05MB8324:EE_
x-ms-office365-filtering-correlation-id: 4b985fe1-47e2-4996-67f9-08df1f79cd9a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|31052699007|39142699007|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|55112099003|22082099003|8096899003|38070700021;
x-microsoft-antispam-message-info: 5kGIbf/szeyfu+iRl+INQ6T9YBFEN1v4eAkLd6H1i3y5baGB5JkIvKBVyiEjM4FzWf1zvEydNpbg9eP3DETmRieEZ/fprH9pM9215nboPQW8gSwtZ7gq7PAilKVtRetkv+ouHee961Jg3HoAbu7Qtf5i+BZPtdkxb+zTfd33cOwshWBANOouj3ZfKCd/phtvSOow8yi2U2TIsw+81Y1ydEWnOQvgWoGMD8/jInC0clA+xH9fosmj8uTXiRgAdoDVKR9jhjYMnmlkkoqarJ7aEAHLZc7LGdrzZdM6c6N5JZ8H/XtfqdfrygBSVJ24jE+vEmSoDNhm3XRSxelvccRSJ0C7RsG9bZAhFPCkVHtTd3V172/mMiFQVRA7Fmh3F8yeqZpwReIASJpDdPwrqYq/xWb4wtDf+OInKAVB1Z+7v2CR5LXKP0kIjPwVBqsDlOq3/U1rrdRmTaFjPDGgDsUMv9aQnifuPYjb9NKJBvLJCuFDIiZCPC1L8EpVNyItclcJ6ahPqTiLDvvMfmD9+CPzrrssNErTw7n/+AQKVVRNetag+RiLzx2f1vxBef0yV13diKKICz0Egj9KjNx2faG/Es3AiLu+YtSqkR159mDOZLRzuqAethEMKJPIqvgAgdXP9ud3EajE0SMZNucP9NRZ6cqODatL1YG0TGN/Uh7u3mpngDA3T6lMy6TH1q0/RaU9Ii618p9Mu5lTCRoYfDusXnCTSDhByd4450fbWW8IZEY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5475.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(31052699007)(39142699007)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(55112099003)(22082099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTZpSnk0eFkrVzh0WStzTEhya3h1QldmM2RzME5CN05Pa3dxVUd5enE2emF4?=
 =?utf-8?B?bXhKOUUxdHl0M21CQmgvLzhrNzNKTjhvQjg0Y25kakZWM0V5WjRvTk5pRmdr?=
 =?utf-8?B?WURYTVY4NXY1dllOS3NWSHdqSVQxVXR1QnM2NSs2b1JHWXdBbklTWHZiL0s3?=
 =?utf-8?B?djJwMzFydUVYUzZUM3Y4TVNVWjNWd1haNjlsTFpnZ1ByRG5UWWMxWVBqNE01?=
 =?utf-8?B?anRoTUNTMm90SHhFSnRuK3p1TUVLeTZySmVGK0tnaVBlWm9jQ2w4K3VTNkJu?=
 =?utf-8?B?RHl4cFF6M1YyT3NRWjB2YVBYNEUzTTI0dE1zdFMvcVNNRy85U3l5TGpNL3ZE?=
 =?utf-8?B?TzhNaXpPSXd5YnJnWVZRMkpXK0VaaW81YlVMTWxDRTM4dmpjdUIySzh1WnhB?=
 =?utf-8?B?c1ZlRmpvKzAzZnJGTTVvUi9sajZRVmpDRms2WU1PZHczdTNYWmJMMWh1dHZP?=
 =?utf-8?B?M2pmUlMra0VZSVFTczRQRlBUeEpKeHN2c2tjeXlwYWt5c28zWnRVcTMrUW5G?=
 =?utf-8?B?dGN4R0NCdTVRWkhWdzI3VHJEY3dCUmduUU5CcjJDWUI4OEEyaEIvVXZMbGQr?=
 =?utf-8?B?cEt1aWZJL0dBNHlrM3I3VTFhd21wUHFrdGR2RWhCRlYvLzVQS2orSmN5MVZX?=
 =?utf-8?B?TFQ2SVhEcjRVMnRxb2tFVTFzR0J3T0tsbTBoLzUxb1BoSGRueVRMY3d6eEhB?=
 =?utf-8?B?OWhYak13S0VvdWhGV3NNa1pJMWNScm1GeUpWVVNXV3ZEekRtam1HWXZLOGM3?=
 =?utf-8?B?ekNDMUthRXNwSTd3WHA5RVdvUzJFQVQvYW1JRXJJRUZKTkttbXJydFlKc0Nl?=
 =?utf-8?B?LzBZZkx3TDI1cWZRN2YrQllQR0VkaDhCNk5zdEpRSlBpcVVHb0ZYUXp4dzZY?=
 =?utf-8?B?bXpTSVZJQnVObDlteUVSWG9jUzhRME1yWCtjL2M4S1RDeG4xVFcyVk1BUnpQ?=
 =?utf-8?B?c1hhK0xBTEJWaElndWdmWjQ3enBoN1A4VjlBdUJuNzE0VnZ6VHFQZmRRL2R6?=
 =?utf-8?B?RGRuQ2pZUVd4bmdRNGtqVGJRaHZBbGxSMHpXczBwZ0g2SjF0RW1jQk1vQVN1?=
 =?utf-8?B?YWV2YkRuYlgrTXU3eU9nREFpaUR1cUduVVV1Y1hhME1pNjFoaTlOMnpKdDBa?=
 =?utf-8?B?cmZQeEJaR3RHREs2RVBqSXZVaDJJRDFMMkk0eHNpM3haNStDVmEyWlBIVzlI?=
 =?utf-8?B?dmNsd3BWWEU1OExtSUZTYTNER1VpWEowYW80VjNDT2QvTy9FVitsR3RveFNq?=
 =?utf-8?B?eXlyajNPRVF0dkU3QXVvVENvUzhvSEtzOENaYXp3TFg3L0tjTGUxOTJEK3BT?=
 =?utf-8?B?VDVoTTduNStoVmthK01JdHl6RGhEeE81Q1NLMTNJZ2dCSldQZGdWZXg0dWdV?=
 =?utf-8?B?ZExUdUF1a3JNb2hObndGdFFMSFcvaGpjeVBpWXdmTDBjRVF3V1U2ajh6Vlp0?=
 =?utf-8?B?YmxMSWJOZ29Ya0I4VFJoMGFrcTdDeEFZa09ZUS85TEJiM2lUZlRsTmJjQ2o1?=
 =?utf-8?B?S21GdUhScmh0T1hnSmJXSHlsT01sRGt3cnIxdUNmS2xVbFFoOStzQ0N5YU5z?=
 =?utf-8?B?VGpUTmZjNzJhVTlzR05LQXBldTBSWkpGWFA5Mlg2Q3h3N1hnOUp3MU1sNi8w?=
 =?utf-8?B?ZHVxTklTZnJTNzQ1dURvbFNZb3l4bHg1dHpzZEhzOUlkaS8vbDJ5RjI2VFNB?=
 =?utf-8?B?MEhDSXhSdUlXZHdScktPVDVrY2Vna2ppYUp0N1g2S2MvemhMTk4rK1Y3QW5y?=
 =?utf-8?B?OTdrMGpNQi9jdXNHZ0RCZEs4Tk1uZ01ERTkwZDlxeCt4L011ZmpmODFTU2VO?=
 =?utf-8?B?aDkxM0pHTEpEckU3Um52dENmSmczTjRXQ2craEw5bGZMZXJ6Q0dRT3p3VWhh?=
 =?utf-8?B?NGhhaXcyT3FnQUZRWjdsTjQwbTlCM1E3dWtob0M0V3hhUkpCbmlWL3hZODhG?=
 =?utf-8?B?OUYvS01wWEtQemRjbFpyeUZKTXE5ZWFuR1RlbEhuTDg5YlI2WnBPakdzZzRY?=
 =?utf-8?B?ZUNKS09KNkErcFovcmpKZEM2dXE5NFBwOXZYbDU0MndkNG05T3lHNmtXeHRy?=
 =?utf-8?B?TXBvQ0xncDJaWXczcy9mb1ZsL1ZPUzVFUzBwRjAwbFFCK2tzRzRsa092b25j?=
 =?utf-8?B?b3dmVXVzOG5DUVp5ek1jSnNVVFR0cWNXcnZPWGFkQXNLaWNCVG5GaFV3QUhE?=
 =?utf-8?B?NktsU0IzUXdGbUhiRldXN0taQzU3blVLQ0lxWnNJM1hyN010R3hTVkliZ08w?=
 =?utf-8?B?QlQ1WWl5STRCQk45M043L3ZKWnZXMUF5ckhMY1BIOXVWbExhZmFSbUVycXVl?=
 =?utf-8?B?RXkrU0hBTmI0Q0h1ZHA3NXM4VmcremdQSmhSYXNMV0JCZkZ4ZzcxUT09?=
Content-Type: multipart/alternative;
 boundary="_000_BL0PR05MB54756FA9CA2C8BA4C445BA2FEF8A2BL0PR05MB5475namp_"
MIME-Version: 1.0
X-OriginatorOrg: adlinktech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5475.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b985fe1-47e2-4996-67f9-08df1f79cd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 05:06:51.0504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c7b546b-78e1-414f-8297-48bb0f8ca053
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52Vt0jJaYH3lb5dKF6cUMl6+MNPrI1Pxxs/EEXHmmPikkkeCqgTqx2NqSESCB3e3q7HgHiNRW2RLk86o9GKKBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8324
X-Mailman-Approved-At: Thu, 01 Oct 2026 12:50:33 +0000
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

--_000_BL0PR05MB54756FA9CA2C8BA4C445BA2FEF8A2BL0PR05MB5475namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgRmFiaW8sDQoNCg0KQWRkIHRoZSBkZXZpY2UgdHJlZSBkZXNjcmlwdGlvbiBmb3IgdGhlIEFE
TElOSyBMRUMtaU1YOTUNClNNQVJDIG1vZHVsZSBhbmQgaXRzIFUtQm9vdC1zcGVjaWZpYyBjb25m
aWd1cmF0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBEaW5lc2gga3VtYXIgdiA8ZGluZXNoLnZAYWRs
aW5rdGVjaC5jb20+DQotLS0NCmFyY2gvYXJtL2R0cy9sZWMtaW14OTUtdS1ib290LmR0c2kgfCA3
MyArKysrKysNCmFyY2gvYXJtL2R0cy9sZWMtaW14OTUuZHRzIHwgMjE2ICsrKysrKysrKysrKysr
Kw0KYXJjaC9hcm0vZHRzL2xlYy1pbXg5NS5kdHNpIHwgNTI0ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gRmlyc3QsIHlvdSBuZWVkIHRvIHN1Ym1pdCB0aGUgYm9hcmQg
ZGV2aWNldHJlZSB0byBMaW51eCB1cHN0cmVhbSBzbw0KPiB0aGF0IGl0IGNhbiBiZSByZXZpZXdl
ZCB0aGVyZS4NCisjaW5jbHVkZSAiaW14OTUtdS1ib290LmR0c2kiDQorDQorJmxwdWFydDEgew0K
KyBib290cGgtcHJlLXJhbTsNCj4gVGhlc2UgJ2Jvb3RwaCcgcHJvcGVydGllcyBzaG91bGQgYWxz
byBiZSBwYXJ0IG9mIHRoZSB1cHN0cmVhbSBMaW51eCBkZXZpY2V0cmVlLg0KDQpVbmRlcnN0b29k
LiBJIHdpbGwgZmlyc3Qgc3VibWl0IHRoZSBMRUMtaU1YOTUgYm9hcmQgZGV2aWNlIHRyZWUgdG8g
TGludXggdXBzdHJlYW0sIGluY2x1ZGluZyB0aGUgcmVxdWlyZWQgYm9vdHBoLSogcHJvcGVydGll
cywgYW5kIHRoZW4gdXBkYXRlIHRoZSBVLUJvb3QgZGV2aWNlIHRyZWUgYWNjb3JkaW5nbHkuDQoN
ClJlZ2FyZHMsDQpEaW5lc2gga3VtYXIgdg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KRnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KU2VudDogMjkg
U2VwdGVtYmVyIDIwMjYgMjM6MTENClRvOiBEaW5lc2ggViA8RGluZXNoLnZAYWRsaW5rdGVjaC5j
b20+DQpDYzogTlhQIGkuTVggVS1Cb290IFRlYW0gPHVib290LWlteEBueHAuY29tPjsgVGFubWF5
IEthdGhwYWxpYSA8dGFubWF5LmthdGhwYWxpYUBhbHRlcmEuY29tPjsgdS1ib290QGxpc3RzLnUt
Ym9vdC1wcm9qZWN0Lm9yZyA8dS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZz47IFRvbSBS
aW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBJbGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2Rp
bWFzQGxpbmFyby5vcmc+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAbmFibGFkZXYuY29tPjsgUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBKYWVob29uIENodW5nIDxqaDgwLmNodW5nQHNhbXN1
bmcuY29tPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47IFByaW1veiBGaXNlciA8cHJp
bW96LmZpc2VyQG5vcmlrLmNvbT47IEpvaGFuIEpvbmtlciA8amJ4NjI0NEBnbWFpbC5jb20+OyBT
aW1vbmEgVG9hY2EgPHNpbW9uYS50b2FjYUBueHAuY29tPjsgRnJhbmNlc2NvIERvbGNpbmkgPGZy
YW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzRdIGFy
bTogZHRzOiBpbXg5NTogQWRkIEFETElOSyBMRUMtaU1YOTUgZGV2aWNlIHRyZWUNCg0K4pqg77iP
IENhdXRpb246IFRoaXMgbWVzc2FnZSB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgQURMSU5LLiBQ
bGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBy
ZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLiBJZiB5b3Ug
aGF2ZSBhbnkgcXVlc3Rpb25zLCBwbGVhc2UgZmVlbCBmcmVlIHRvIGNvbnRhY3QgdGhlIElUIEhl
bHBkZXNrIChpdC5oZWxwZGVza0BhZGxpbmt0ZWNoLmNvbTxtYWlsdG86aXQuaGVscGRlc2tAYWRs
aW5rdGVjaC5jb20+KS4NCg0KSGkgRGluZXNoLA0KDQpPbiBNb24sIFNlcCAyOCwgMjAyNiBhdCA0
OjM54oCvQU0gRGluZXNoIGt1bWFyIHYgdmlhIEI0IFJlbGF5DQo8ZGV2bnVsbCtkaW5lc2gudi5h
ZGxpbmt0ZWNoLmNvbUBrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4gRnJvbTogRGluZXNoIGt1bWFy
IHYgPGRpbmVzaC52QGFkbGlua3RlY2guY29tPg0KPg0KPiBBZGQgdGhlIGRldmljZSB0cmVlIGRl
c2NyaXB0aW9uIGZvciB0aGUgQURMSU5LIExFQy1pTVg5NQ0KPiBTTUFSQyBtb2R1bGUgYW5kIGl0
cyBVLUJvb3Qtc3BlY2lmaWMgY29uZmlndXJhdGlvbi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGlu
ZXNoIGt1bWFyIHYgPGRpbmVzaC52QGFkbGlua3RlY2guY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJt
L2R0cy9sZWMtaW14OTUtdS1ib290LmR0c2kgfCAgNzMgKysrKysrDQo+ICBhcmNoL2FybS9kdHMv
bGVjLWlteDk1LmR0cyAgICAgICAgIHwgMjE2ICsrKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm0v
ZHRzL2xlYy1pbXg5NS5kdHNpICAgICAgICB8IDUyNCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQoNCkZpcnN0LCB5b3UgbmVlZCB0byBzdWJtaXQgdGhlIGJvYXJkIGRldmlj
ZXRyZWUgdG8gTGludXggdXBzdHJlYW0gc28NCnRoYXQgaXQgY2FuIGJlIHJldmlld2VkIHRoZXJl
Lg0KDQo+ICsjaW5jbHVkZSAiaW14OTUtdS1ib290LmR0c2kiDQo+ICsNCj4gKyZscHVhcnQxIHsN
Cj4gKyAgICAgICBib290cGgtcHJlLXJhbTsNCg0KVGhlc2UgJ2Jvb3RwaCcgcHJvcGVydGllcyBz
aG91bGQgYWxzbyBiZSBwYXJ0IG9mIHRoZSB1cHN0cmVhbSBMaW51eCBkZXZpY2V0cmVlLg0K

--_000_BL0PR05MB54756FA9CA2C8BA4C445BA2FEF8A2BL0PR05MB5475namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
IiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01T
Rm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAx
MnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQpIaSBGYWJpbyw8L2Rpdj4NCjxkaXYgY2xhc3M9
ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRl
ZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJp
ZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8YnI+DQo8L2Rpdj4N
CjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBB
cHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGlj
YSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8
YnI+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJwYWRkaW5nLWxlZnQ6IDEwcHg7IGJvcmRl
ci1sZWZ0OiAzcHggc29saWQgcmdiKDIwMCwgMjAwLCAyMDApOyI+DQo8ZGl2IHN0eWxlPSJmb250
LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwg
Q2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiBy
Z2IoMCwgMCwgMCk7Ij4NCkFkZCB0aGUgZGV2aWNlIHRyZWUgZGVzY3JpcHRpb24gZm9yIHRoZSBB
RExJTksgTEVDLWlNWDk1PC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFw
dG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNh
LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NClNN
QVJDIG1vZHVsZSBhbmQgaXRzIFUtQm9vdC1zcGVjaWZpYyBjb25maWd1cmF0aW9uLjwvZGl2Pg0K
PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9z
X01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXpl
OiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8YnI+DQo8L2Rpdj4NCjxkaXYgc3R5bGU9
ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2
aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29s
b3I6IHJnYigwLCAwLCAwKTsiPg0KU2lnbmVkLW9mZi1ieTogRGluZXNoIGt1bWFyIHYgJmx0O2Rp
bmVzaC52QGFkbGlua3RlY2guY29tJmd0OzwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6
IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmks
IEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAs
IDApOyI+DQotLS08L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3Nf
RW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNh
bnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KYXJjaC9h
cm0vZHRzL2xlYy1pbXg5NS11LWJvb3QuZHRzaSB8IDczICsrKysrKzwvZGl2Pg0KPGRpdiBzdHls
ZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNl
cnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBj
b2xvcjogcmdiKDAsIDAsIDApOyI+DQphcmNoL2FybS9kdHMvbGVjLWlteDk1LmR0cyB8IDIxNiAr
KysrKysrKysrKysrKys8L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0
b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2Es
IHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KYXJj
aC9hcm0vZHRzL2xlYy1pbXg5NS5kdHNpIHwgNTI0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKys8L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1By
b29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9z
X01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXpl
OiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQomZ3Q7IEZpcnN0LCB5b3UgbmVlZCB0byBz
dWJtaXQgdGhlIGJvYXJkIGRldmljZXRyZWUgdG8gTGludXggdXBzdHJlYW0gc288L2Rpdj4NCjxk
aXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRv
c19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwg
c2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQomZ3Q7
IHRoYXQgaXQgY2FuIGJlIHJldmlld2VkIHRoZXJlLjwvZGl2Pg0KPGJsb2NrcXVvdGUgc3R5bGU9
InBhZGRpbmctbGVmdDogMTBweDsgYm9yZGVyLWxlZnQ6IDNweCBzb2xpZCByZ2IoMjAwLCAyMDAs
IDIwMCk7Ij4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRG
b250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7
IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KKyNpbmNsdWRlICZxdW90
O2lteDk1LXUtYm9vdC5kdHNpJnF1b3Q7PC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTog
QXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwg
SGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwg
MCk7Ij4NCis8L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1i
ZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMt
c2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KKyZhbXA7bHB1
YXJ0MSB7PC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVk
ZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNl
cmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NCisgYm9vdHBoLXBy
ZS1yYW07PC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiIg
c3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0Zv
bnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJw
dDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KJmd0OyBUaGVzZSAnYm9vdHBoJyBwcm9wZXJ0aWVz
IHNob3VsZCBhbHNvIGJlIHBhcnQgb2YgdGhlIHVwc3RyZWFtIExpbnV4IGRldmljZXRyZWUuPC9k
aXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwg
QXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250
LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBz
dHlsZT0ibWFyZ2luLXRvcDogMWVtOyBtYXJnaW4tYm90dG9tOiAxZW07IGZvbnQtZmFtaWx5OiBB
cHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBI
ZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAw
KTsiIGNsYXNzPSJlbGVtZW50VG9Qcm9vZiI+DQpVbmRlcnN0b29kLiBJIHdpbGwgZmlyc3Qgc3Vi
bWl0IHRoZSBMRUMtaU1YOTUgYm9hcmQgZGV2aWNlIHRyZWUgdG8gTGludXggdXBzdHJlYW0sIGlu
Y2x1ZGluZyB0aGUgcmVxdWlyZWQNCjxjb2RlPmJvb3RwaC0qPC9jb2RlPiBwcm9wZXJ0aWVzLCBh
bmQgdGhlbiB1cGRhdGUgdGhlIFUtQm9vdCBkZXZpY2UgdHJlZSBhY2NvcmRpbmdseS48L2Rpdj4N
CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRv
c19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6
ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNz
PSJlbGVtZW50VG9Qcm9vZiIgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRk
ZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2Vy
aWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KUmVnYXJkcyw8L2Rp
dj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9z
LCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+
DQpEaW5lc2gga3VtYXIgdjwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBB
cHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGlj
YSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8
YnI+DQo8L2Rpdj4NCjxociBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyB3aWR0aDogOTgl
OyI+DQo8ZGl2IGlkPSJkaXZScGx5RndkTXNnIj4NCjxkaXYgc3R5bGU9ImRpcmVjdGlvbjogbHRy
OyBmb250LWZhbWlseTogQ2FsaWJyaSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMXB0OyBjb2xv
cjogcmdiKDAsIDAsIDApOyI+DQo8Yj5Gcm9tOjwvYj4gRmFiaW8gRXN0ZXZhbSAmbHQ7ZmVzdGV2
YW1AZ21haWwuY29tJmd0Ozxicj4NCjxiPlNlbnQ6PC9iPiAyOSBTZXB0ZW1iZXIgMjAyNiAyMzox
MTxicj4NCjxiPlRvOjwvYj4gRGluZXNoIFYgJmx0O0RpbmVzaC52QGFkbGlua3RlY2guY29tJmd0
Ozxicj4NCjxiPkNjOjwvYj4gTlhQIGkuTVggVS1Cb290IFRlYW0gJmx0O3Vib290LWlteEBueHAu
Y29tJmd0OzsgVGFubWF5IEthdGhwYWxpYSAmbHQ7dGFubWF5LmthdGhwYWxpYUBhbHRlcmEuY29t
Jmd0OzsgdS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZyAmbHQ7dS1ib290QGxpc3RzLnUt
Ym9vdC1wcm9qZWN0Lm9yZyZndDs7IFRvbSBSaW5pICZsdDt0cmluaUBrb25zdWxrby5jb20mZ3Q7
OyBJbGlhcyBBcGFsb2RpbWFzICZsdDtpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmcmZ3Q7OyBT
dGVmYW5vIEJhYmljDQogJmx0O3NiYWJpY0BuYWJsYWRldi5jb20mZ3Q7OyBQZW5nIEZhbiAmbHQ7
cGVuZy5mYW5AbnhwLmNvbSZndDs7IEphZWhvb24gQ2h1bmcgJmx0O2poODAuY2h1bmdAc2Ftc3Vu
Zy5jb20mZ3Q7OyBBbGljZSBHdW8gJmx0O2FsaWNlLmd1b0BueHAuY29tJmd0OzsgUHJpbW96IEZp
c2VyICZsdDtwcmltb3ouZmlzZXJAbm9yaWsuY29tJmd0OzsgSm9oYW4gSm9ua2VyICZsdDtqYng2
MjQ0QGdtYWlsLmNvbSZndDs7IFNpbW9uYSBUb2FjYSAmbHQ7c2ltb25hLnRvYWNhQG54cC5jb20m
Z3Q7OyBGcmFuY2VzY28gRG9sY2luaSAmbHQ7ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20m
Z3Q7PGJyPg0KPGI+U3ViamVjdDo8L2I+IFJlOiBbUEFUQ0ggMi80XSBhcm06IGR0czogaW14OTU6
IEFkZCBBRExJTksgTEVDLWlNWDk1IGRldmljZSB0cmVlPC9kaXY+DQo8ZGl2IHN0eWxlPSJkaXJl
Y3Rpb246IGx0cjsiPiZuYnNwOzwvZGl2Pg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LXNpemU6
IDExcHQ7Ij7imqDvuI8gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIHdhcyBzZW50IGZyb20gb3V0c2lk
ZSBvZiBBRExJTksuIFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuIElmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMsIHBsZWFzZSBmZWVsIGZyZWUgdG8gY29u
dGFjdCB0aGUgSVQNCiBIZWxwZGVzayAoaXQuaGVscGRlc2tAYWRsaW5rdGVjaC5jb20mbHQ7bWFp
bHRvOml0LmhlbHBkZXNrQGFkbGlua3RlY2guY29tJmd0OykuPGJyPg0KPGJyPg0KSGkgRGluZXNo
LDxicj4NCjxicj4NCk9uIE1vbiwgU2VwIDI4LCAyMDI2IGF0IDQ6MznigK9BTSBEaW5lc2gga3Vt
YXIgdiB2aWEgQjQgUmVsYXk8YnI+DQombHQ7ZGV2bnVsbCtkaW5lc2gudi5hZGxpbmt0ZWNoLmNv
bUBrZXJuZWwub3JnJmd0OyB3cm90ZTo8YnI+DQomZ3Q7PGJyPg0KJmd0OyBGcm9tOiBEaW5lc2gg
a3VtYXIgdiAmbHQ7ZGluZXNoLnZAYWRsaW5rdGVjaC5jb20mZ3Q7PGJyPg0KJmd0Ozxicj4NCiZn
dDsgQWRkIHRoZSBkZXZpY2UgdHJlZSBkZXNjcmlwdGlvbiBmb3IgdGhlIEFETElOSyBMRUMtaU1Y
OTU8YnI+DQomZ3Q7IFNNQVJDIG1vZHVsZSBhbmQgaXRzIFUtQm9vdC1zcGVjaWZpYyBjb25maWd1
cmF0aW9uLjxicj4NCiZndDs8YnI+DQomZ3Q7IFNpZ25lZC1vZmYtYnk6IERpbmVzaCBrdW1hciB2
ICZsdDtkaW5lc2gudkBhZGxpbmt0ZWNoLmNvbSZndDs8YnI+DQomZ3Q7IC0tLTxicj4NCiZndDsm
bmJzcDsgYXJjaC9hcm0vZHRzL2xlYy1pbXg5NS11LWJvb3QuZHRzaSB8Jm5ic3A7IDczICsrKysr
Kzxicj4NCiZndDsmbmJzcDsgYXJjaC9hcm0vZHRzL2xlYy1pbXg5NS5kdHMmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCAyMTYgKysrKysrKysrKysrKysr
PGJyPg0KJmd0OyZuYnNwOyBhcmNoL2FybS9kdHMvbGVjLWlteDk1LmR0c2kmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCA1MjQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKzxicj4NCjxicj4NCkZpcnN0LCB5b3UgbmVlZCB0byBzdWJtaXQgdGhl
IGJvYXJkIGRldmljZXRyZWUgdG8gTGludXggdXBzdHJlYW0gc288YnI+DQp0aGF0IGl0IGNhbiBi
ZSByZXZpZXdlZCB0aGVyZS48YnI+DQo8YnI+DQomZ3Q7ICsjaW5jbHVkZSAmcXVvdDtpbXg5NS11
LWJvb3QuZHRzaSZxdW90Ozxicj4NCiZndDsgKzxicj4NCiZndDsgKyZhbXA7bHB1YXJ0MSB7PGJy
Pg0KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGJvb3RwaC1wcmUt
cmFtOzxicj4NCjxicj4NClRoZXNlICdib290cGgnIHByb3BlcnRpZXMgc2hvdWxkIGFsc28gYmUg
cGFydCBvZiB0aGUgdXBzdHJlYW0gTGludXggZGV2aWNldHJlZS48L2Rpdj4NCjwvYm9keT4NCjwv
aHRtbD4NCg==

--_000_BL0PR05MB54756FA9CA2C8BA4C445BA2FEF8A2BL0PR05MB5475namp_--
