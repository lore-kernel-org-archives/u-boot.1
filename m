Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C2CCA490
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 02:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B61481764;
	Sat, 17 Oct 2026 02:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhOMEbTUg2up; Sat, 17 Oct 2026 02:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D3E4814C8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792202898;
	b=Db5/mpuo6CLX/B8op4IldNe6a7ikoRga5AWYNW3woIp5RvR6xkS4xlLNMWo/FXA+mHjo
	 H6B9wkxq2fuZ0SbyHyrOzn+3+OO/XbtjaQvquZ63IqJDKbaNXN6rn4Gz6Quh1kU5SBs6w
	 XidgKKIoK2VdPsm0yUxlzZpmQ22yFnIvcanWIUJEhaEGFNViylkH3VQLE1gg8cPZyeHNn
	 jTiUTGqFQch5hArK1v2DrhItQoKoLKIPBB9UT1FTBzSY9KVO2CGClNwayP3NE1JX8zLes
	 B+qcgH1FK81xQZ8dGuEDIIS6sEv6KcwkexFYtdagvk3iaWz65utJhfrb1tS31iB8N2Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792202898;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
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
	bh=BdXlM318Jn0OmMNK+kzXZKhd05eIuwAX1QGcOf2e1no=;
	b=gQP7MdFSsm4uATM/agBPnkjUeuOtSDkLMeRi1IZ07cCb7iLZWIG6ngVl/G2UEAGkMX2o
	 l7ZvztwEtaCSk9w++9yERRc3ilG0hXLf8M2lLauVsi++Ws+S6tXTToqE+mZ4ExXzzifPt
	 ro3zbwZK4qEoCgyD0VYMWa91A4+bZLsfMmXcMFGsYHQq25uBJMSBj2a7SX9I7pyX5cE6p
	 KuE5T20K76iOF/euxazENmSoEjtfFZUQ2OrrNrn7Zr71vnDigRmkIrANR4BGBh9EVN77K
	 EShMDtRjg3v7zE6kIjgaz7WdE/veD0x8JlBD/0xGclkm9pwgck3efI63zPNxSfPNJ5w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792202898;
	bh=BdXlM318Jn0OmMNK+kzXZKhd05eIuwAX1QGcOf2e1no=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onoX1/JJNVI5K57rjpVBqiJwn9R8SbiP7c7QRyWpCHKaNvu6gSl93Avh9CPZBNuwC
	 pfZ1eAhJ6GmCAetK5nZ548/2T8IAqe+N45aGD++r7DWlqGTwocmliWwqV4U6U/UhbX
	 saFA2qLOxq9vhBj2YY6kRM9mNuvbd88x8sldMcww0Hv6oeixQ0IzRdU19oaDvhUwd/
	 60+zAnXdVUhGWmZ7MycsT4Yl1jNBwa+bRFdEjzb+P5shacpvl1pME0HtQ4dQG9oel/
	 8NugTDD994ozRuurvIqL9PouMWFyhAf8hpwXvIW5FHMwxTAbpktZh3WVJOlrjbfYUf
	 hQytwKzmlyV/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D3E4814C8;
	Sat, 17 Oct 2026 02:08:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18DD97AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F373140082
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MS8d_6J4SXlV for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 02:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7C3D240075
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792202895;
 b=Hohkza1s3pAYmnZA4B2Eu6QA320PFHbdxYd731IxHDIPnv/HhKifnMxKnXuny+cT8fGA
 /dz6mkB53Upg445C1ciy+ICODGiEYPJNwmv5i2r5rEfntpGLiZGjaGQg0u0c4fF4/wJ3h
 JnNnS6zHaV+tdm968vx+V6mN5CrT3keYAUAbl13fImGpF3SrB1vOVC7L9araRhIRKBHsO
 JyvmB18k9Rz07mLFncI0o6w4k86qHYK3AYPOcNGoZg/yy9LeBxRjHsRbYCEa0Yy71LqBI
 07MW0sJmtA1m2SpqUYk9nonFB9bA2tbWR3SeX6R31gsjdStZa59c5x/QZkatxgZqcCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792202895;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:
 x-ms-exchange-antispam-messagedata-1:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=BdXlM318Jn0OmMNK+kzXZKhd05eIuwAX1QGcOf2e1no=;
 b=l0Nl8HzMRxvIPZvYk9u5i7fQciWs8ADxiLRPlXXFW6m7AfKheRJn5i/JxoH2Vj2S6R2Q
 HC72cS9Rf9y5gK3s9ckkFXGYa5nrBCD8o+1rS+/oltSEU2xBcUSFSirI/UKiMvut7ArsJ
 YVRufB66ymlIXjgsgNpC0ZWZo2c03jpSUnJlEe+Nr72X7x45h8HG/tDEfAPlFuepfbagL
 MkbtQZJxnwYsIgPx/mxIpOt6wQjWMjQ+q+1QqWAvPOwPetfaTqym5THVuUOW+es9L/wjG
 FL1zKYvwWCn9S/riOsWAM8WZc5g0NUdAN+xWKGlzR7TqC2ozojA6oTYpt0jfDV47zpA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=leica-geosystems.com;
 dkim=pass header.d=leica-geosystems.com header.i=@leica-geosystems.com
 header.a=rsa-sha256 header.s=selector1 header.b="Ah6I/qhB"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=johannes.schneider@leica-geosystems.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=leica-geosystems.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=leica-geosystems.com header.i=@leica-geosystems.com
 header.a=rsa-sha256 header.s=selector1 header.b=Ah6I/qhB
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C3D240075
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mecvQ2iLpjV9ES4VWDjLgh/3Sxkyx51TDNzwZOwjcuXzhUCoHrjUvhuuQBap+bVlWrMYx6qX3wFAbqKyG3zNyBuD0fASBJ9r0RkNFqJjg/WSoj0DAxc6F+ii7mZZAu2PqOxN8VlGAsPLbzd1agPUfG3QvI8jDDzHpW0Qs/QgxXHlAIIspEGBOa6tUcC4dvVRT6g80QW2slnc7+fg3d01VkO+NtLzIAq/fVPlRmwlLFD9W1MpFX9kI+NU1qQpo5L3H9MZvf5fYWiWTugAJb3+lPKEgr0Q5wb+v5okv8WqhULUn/M1zuriptJUqu+RQgiI+RXyjUs3qXt9Ltjnl/4xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdXlM318Jn0OmMNK+kzXZKhd05eIuwAX1QGcOf2e1no=;
 b=K86Sk0Qq+vAE6FPD6VaNnc4gJCR+KUF1kjC/Nl6CUH05HJfjSdeAMWBOr3KD0lYlAt8SEJllKsFjEjFhalAB25lOP40ji3w9NHFdgKBnkxZysVpz/+i1URScC77KF9/NxB3yl4F9iXAJc1kXWicPqQUqCj3qaQNIy5OE7+juDm7KAIeGwuSPVq5ifMdQmzRoTh0EjR+tr5dRPspDm4NRuzSFnuC6kG951I8voq0nDWQnL0CHZqbsrc10TKnx5sznukj8F7zQR68wGvBuxyL77O+uwxHPuHDxKHm7qkRDeNv2f6qP3l1RwtSQT4U9ghbtRJYxGnB7XhfWL2xFSK/bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdXlM318Jn0OmMNK+kzXZKhd05eIuwAX1QGcOf2e1no=;
 b=Ah6I/qhBQABqgQQwWBOAu78MAqTXyHPWZb25tw6zqJmY2n9IRbxhIOEhz+58tQNZJVYRlsMpVVUqQjP9Ecj1jjDfXPIVLzVa2m+uTppH2fWrM/qTCprPCJ1BPt0nlLjf9g1D/NYSz8RtE2mHytztsDmwvMQ0tKBuucbn/qqoaAI=
Received: from GVXPR06MB11003.eurprd06.prod.outlook.com
 (2603:10a6:150:31b::22) by PA1PR06MB9751.eurprd06.prod.outlook.com
 (2603:10a6:102:44f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Sat, 17 Oct
 2026 02:08:08 +0000
Received: from GVXPR06MB11003.eurprd06.prod.outlook.com
 ([fe80::441e:1079:fafd:23cc]) by GVXPR06MB11003.eurprd06.prod.outlook.com
 ([fe80::441e:1079:fafd:23cc%7]) with mapi id 15.21.0522.011; Sat, 17 Oct 2026
 02:08:07 +0000
From: SCHNEIDER Johannes <johannes.schneider@leica-geosystems.com>
To: Eddie Kovsky <ekovsky@redhat.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "quentin.schulz@cherry.de"
 <quentin.schulz@cherry.de>, "a.fatoum@pengutronix.de"
 <a.fatoum@pengutronix.de>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] rsa: load a pkcs11 token key through OSSL_STORE in the
 provider path
Thread-Topic: [PATCH] rsa: load a pkcs11 token key through OSSL_STORE in the
 provider path
Thread-Index: AQHdWVpVEZLsGGwYMEeVzVRH6WGUb7cA1f6AgAAuTMw=
Date: Sat, 17 Oct 2026 02:08:07 +0000
Message-ID: <GVXPR06MB1100302543CEAE102CEA05F2FBC9A2@GVXPR06MB11003.eurprd06.prod.outlook.com>
References: <20261011082714.1071089-1-johannes.schneider@leica-geosystems.com>
 <atKwQ1uR04NJSjNO@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
In-Reply-To: <atKwQ1uR04NJSjNO@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR06MB11003:EE_|PA1PR06MB9751:EE_
x-ms-office365-filtering-correlation-id: eec3cc79-cf2a-4848-b7aa-08df2bf37c89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|4133799003|6133799003|22082099003|10067099003|18002099003|4143699003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: xAuTNX8Il1++SW4HT/J75LM7YW3dijM1m3q02SMwhnZAKHBkiqJ6+a1jVBkGgZgDrWZx4j2tqoacKdVfSAMdqERdQUrf33PT7A6dNqUL/GvegJqd2cRNMuZqM/pT8nZf8/ft1yAaliRvvqa065hDA4qNydgsyT50RNAf9+Bj53GuFLMFvRwd7foWwpTT56ybLyTTeIsdoAyvybSXACaR9d7eGoxXT8aTLF3QYXMOJBOhlZwIvCKjFkHcPc3I+2c5CT/Mt7acLOVOyUfDjWG3KSUC6+2PtxsbVVjAcO9em9sM7eHeh3vy3mgn2EZOa+ZiYnNHL4GRZkshAx6PfLJn9znRAuwthBER3lhViOv3K00ItuEW0QoG0FkdW+7VgcA/ZLlZdrrFOKtoFBHNyitTjVQuUFNOI/rOEXa8I9Vgfkws9OFPv+hAn8A67mQcoR4dcimH68Sc9drz6p+6wXJ+0iBKSXts9z2bPv4dG0OO9BHAyQEULLGtnCzc3D2rhooWoU4zMy4qTa0pcI4QhYyTrHSevDQ7M4FSddl8270fuuaPnx98Q94h3AuCYo3rb0x7Neb5PfV73y9lhJgDTFhkpNwTXVIs+oaot/kODHti85lahiKCyCMfSea/+uHZHiI+SGD7idSMVPXBXKqwTQJd6P3odHgMFgGHbTcIUc8d7lk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB11003.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(4133799003)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WQdlm4LnrnNGVCrF+QIh28q4zdZctp8+SSlp0aXzcHXe7fzCPSsDRB3dnX?=
 =?iso-8859-1?Q?zb6USUlXDmeF6TdrMywrPjTBrNhTmUYyQI8XYrvY4wL+YdtkY5gomNni6E?=
 =?iso-8859-1?Q?sc4i3oqmN8KDf7zt+a0gDScpgh50FE72fuBELbLrKKmTwY1j+ZQ/lGs4JU?=
 =?iso-8859-1?Q?Zbwy7xWTGNCzc5yNc6jUKkGs6SOt/8XfA0lMXY0atokzwKdr/Ua5FdA0nQ?=
 =?iso-8859-1?Q?Z2vBQIUl4A3d0E3oUzdCfLmjaT4E9pCnzFZGx0sdXRMov9wYuQ5K/M+TIn?=
 =?iso-8859-1?Q?y97Vidwa5UV8xd37jmWKsKlJG/Frz/GjXXSZdRHgKjHBjbxG2FdhuAYFdt?=
 =?iso-8859-1?Q?VXlMPUv7f4ci8bddxn/uoSXShvi1Go3dHSFWY5IrbiDovk/z79g9WsaTNH?=
 =?iso-8859-1?Q?BmBpCNUm6sIMd7ljakoiHHMdhnny8VC6hmKwtAbU5G9E1kuMnRM3bk/FTK?=
 =?iso-8859-1?Q?MQAQYNK23Hl/koscE9BhcJrJfYKyWRFLkxulUk2RJiZM4Z8jRxx9WEVzfT?=
 =?iso-8859-1?Q?aMVIRy3Cw91Z0/U/CyqIHYTk2cBVnsjQiBadj5yjQjbh3FZxqxD7Vej041?=
 =?iso-8859-1?Q?HMG4IHO8WmI7yS7253H7oQwokza1OxIT8gQ325YjpUD1+ZO5KA4thOI87t?=
 =?iso-8859-1?Q?uamARuE/qZRYUA1m+AdXWcFzlA9Z+s9G1FGP0DQsQNQ8mJ3YPd7wZOwXql?=
 =?iso-8859-1?Q?mkRsAIUE7E3beJHN71dvoGLYHJboPxNU7CuRM/Gy1TZwcGg/JBRf1sG2CG?=
 =?iso-8859-1?Q?nPrRyW/MEahK9EJ/zo8Fjf0zueiw0d7M/n/YDgBoXCdnPieRqZDzNYZDhL?=
 =?iso-8859-1?Q?PUPjrhybLiU3N4NoPKB4kWK4M+dqLAMTtUTHnDynzV9waXC0oo6R0IwRRR?=
 =?iso-8859-1?Q?8BjX2Y8Z2S2eQX57l60Gt3kB6w5eGe/IRxcHsKLwHtcZwk8gG7sVytmYIh?=
 =?iso-8859-1?Q?W8Zf0p6v2yU0EWss7kvrIvHfJh5rfHhmitxC6kejhMuLN1R5koGA8X/Ze4?=
 =?iso-8859-1?Q?rBTqTD0LfTFNiVr3mZrlWowy2XuBbbQOW6fAfjuWBBV9gdudWZOXMnOPoA?=
 =?iso-8859-1?Q?/4PT6AyraQ9FPWIdYfJ4h0YI36V6zr3RXcqCQju/haRnZRMqRoGfYkQyEQ?=
 =?iso-8859-1?Q?MM1vQKBTKiqyUuF2d2CKVvS5X84mdRxz+2ZN0s4EJXhukX8Z1b3PtFje27?=
 =?iso-8859-1?Q?QwMCtknAwpRL0qY6zdkTJrxDjl4d3uL3eewJgiHegEGAGHMOcKzlNRxMEk?=
 =?iso-8859-1?Q?a4KorbJ/YiaX3n3Y/8IoWD5nHJiI6wcC+g7F+5d8fqrzGyh9kgeSrVeymF?=
 =?iso-8859-1?Q?Y66F/h4/GmQLdLYRdCZB4r1MjO68Za9DJBn5DqbEHRfQnfnlzvNC0GK7jq?=
 =?iso-8859-1?Q?kn+EmSqUtsAouX120enFpXBt1JA8nrNbvPc/t7+kEBdL/5wGLPXMCWlNgk?=
 =?iso-8859-1?Q?lq3ZE54eqKwg5zrxjeoiVoq+LPphdP5uTCOMHU0NvdJ4g76apTnVByQEWo?=
 =?iso-8859-1?Q?uEHBq8h5HblpwEqSr1NjmdqeaHED8YBPNctE4FIcJIxG4Z5D3ydbec3fLX?=
 =?iso-8859-1?Q?VFSwvAZ8NTifTq36x9/a21IQOxmwMvQxtjxoLD+Lc+H7ezYFe6aQJkeo8P?=
 =?iso-8859-1?Q?HbEC9ypxOAAUR4zBXChuGfpgKmG1Fp8lnZ8Pr20NikZE6lXDiCXR2WvqTi?=
 =?iso-8859-1?Q?k/9UhxRoAwqZcUeBHU/fvV7wiGErt9HzrrOUlW/bqQzQKqKCokVQG/iG6D?=
 =?iso-8859-1?Q?PTG6Jo101B+igDtH7Txu/WIvdE1jF+t6RX1bhWpbVic8vzXfXTXrNkQwcU?=
 =?iso-8859-1?Q?FXNxfdfOvtnz9a4g7+lzWLvVF3KAkzXacZWa5Ld36pI/NPhSm52hpuM3KV?=
 =?iso-8859-1?Q?h0?=
x-ms-exchange-antispam-messagedata-1: eDHGhhQhHAOMLdb8Qw6ImmQCBcbqQboNSfLlYZ8By62t2FfMHOx5U/cS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB11003.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec3cc79-cf2a-4848-b7aa-08df2bf37c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 02:08:07.6070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljIGdg/TaVhseUj97JuQyW5cvbPzJfoTprV90y7nJusDbl7CRGTr5LADGMARe+IgI4rgEXyhNKr0u7KzqAuR09bXMCvWbFd3ENVwqudYCPezfjtXGa9LjnMzPXdFSGeQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9751
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

Hoi


> On 10/11/26, Johannes Schneider wrote:
> > The OpenSSL Provider API support routes FIT signing-key loading through
> > OSSL_STORE on OpenSSL >=3D 3 (USE_PKCS11_PROVIDER), but only for key fi=
les:
> > rsa_pem_get_priv_key() fopen()s the path before OSSL_STORE_open(), so a=
 pkcs11:
> > token URI fails with -ENOENT. The legacy engine path that handled token=
s is
> > compiled out on OpenSSL >=3D 3, so FIT signing with a token key silentl=
y produces
> > an unsigned FIT (a configuration signature node with no value or
> > hashed-strings).
> >
> > Load a pkcs11: key URI in the provider path directly through OSSL_STORE=
 and the
> > pkcs11 provider: skip the fopen, append ";type=3Dprivate" if absent. Th=
e PIN
> > travels in the URI (pin-value=3D); MKIMAGE_SIGN_PIN is unaffected.
> >
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.=
com>
> > ---
> > Follow-up to Eddie Kovsky's "rsa: Add support for OpenSSL Provider API"
> > (https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@redhat.c=
om).
> >
> > How we use it: our build signs production FIT images with an RSA key ke=
pt on a
> > PKCS#11 token, so the private key never lands on the build host or in C=
I
> > artifacts. mkimage gets the key as a "pkcs11:...;type=3Dprivate" URI; t=
he
> > provider path today handles file keys only, so with the engine gone on
> > OpenSSL >=3D 3 a token-backed FIT silently comes out unsigned -- this c=
loses that
> > gap.
> >
>
> Hi Johannes
>
> Thank you for sharing this. I really like this approach. I had been
> looking at refactoring the duplicate pkcs11 URI parsing code and then
> making it available on the existing non-engine path before I did a v5,
> but this is a much simpler solution.
>

glad to hear :-)

>
> I still have some testing to finish. Can I include your work in my v5
> (preserving authorship of course).
>

by all means yes, go ahead - you're probably deeper into that topic than i =
am

>
> Or would you like to send this
> separately after the Provider support is ready?
>

since i was pondering/worried about how to upstream this, after Quentins
response - that pointed out i shouldn't just base it on another series and =
that
i missed that it the previous v4 was already sent into another rework round=
. :-S

> Eddie
>
>
> > --- a/lib/rsa/rsa-sign.c
> > +++ b/lib/rsa/rsa-sign.c
> > @@ -237,6 +237,49 @@
> >               return -EINVAL;
> >
> >       *evpp =3D NULL;
> > +
> > +#ifdef USE_PKCS11_PROVIDER
> > +     /* A pkcs11: token URI is not a file: load it via OSSL_STORE + th=
e pkcs11 provider instead of fopen (PIN in the URI, pin-value=3D). */
> > +     if (keydir && !strncmp(keydir, "pkcs11:", 7)) {
> > +             char uri[1200];
> > +             OSSL_STORE_CTX *p11_store;
> > +             EVP_PKEY *p11_key =3D NULL;
> > +
> > +             if (strstr(keydir, "type=3D"))
> > +                     snprintf(uri, sizeof(uri), "%s", keydir);
> > +             else
> > +                     snprintf(uri, sizeof(uri), "%s;type=3Dprivate", k=
eydir);
> > +
> > +             if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> > +                     ERR(1, "OSSL_PROVIDER_try_load(default)");
> > +             if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> > +                     ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> > +
> > +             p11_store =3D OSSL_STORE_open(uri, NULL, NULL, NULL, NULL=
);
> > +             ERR(!p11_store, "OSSL_STORE_open(%s)", uri);
> > +             while (!OSSL_STORE_eof(p11_store)) {
> > +                     OSSL_STORE_INFO *info =3D OSSL_STORE_load(p11_sto=
re);
> > +
> > +                     if (!info) {
> > +                             if (OSSL_STORE_error(p11_store))
> > +                                     break;
> > +                             continue;
> > +                     }
> > +                     if (OSSL_STORE_INFO_get_type(info) =3D=3D OSSL_ST=
ORE_INFO_PKEY)
> > +                             p11_key =3D OSSL_STORE_INFO_get1_PKEY(inf=
o);
> > +                     OSSL_STORE_INFO_free(info);
> > +                     if (p11_key)
> > +                             break;
> > +             }
> > +             OSSL_STORE_close(p11_store);
> > +             if (!p11_key) {
> > +                     fprintf(stderr, "No private key found at '%s'\n",=
 uri);
> > +                     return -EPROTO;
> > +             }
> > +             *evpp =3D p11_key;
> > +             return 0;
> > +     }
> > +#endif
> >       if (keydir && name)
> >               snprintf(path, sizeof(path), "%s/%s.key", keydir, name);
> >       else if (keyfile)
> >
>
