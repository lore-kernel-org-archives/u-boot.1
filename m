Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109C606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sf46tzG9;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Yd9S2cRW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53A03605F9;
	Tue, 27 Oct 2026 07:32:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kjzldepGoXy; Tue, 27 Oct 2026 07:32:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8244F606B3
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793086336;
	b=JdMJQLxLBK1Z+WHm6Mvd/H7qBDucnp4U8F3Jl1QQ/FeIzB7WMV3sCQUoX8iWXMUeMO3j
	 jRrx1SLldq8hwfno5LyI8i62IBP7L/8/zd6H6hln1DT+y8eU+o/izLu9XiVGfa7vzTLbx
	 FssQVPc7Zr4pBW1GXCH/B+ZnrJyNGd1OPVl5nXXqeq1VVh5jKRPVAZtUfo4kW+az1d90m
	 OiinPidzr8CRmIFT8wBNDFTz36lrWSv5vXDTphfJSy+wWwKGJ1/bciS0mMewId9dGC3Oq
	 aAaNS6oYiiS//z/XrionG6busn3Lbmph51rSJZv/kNkQ0FR0p3ziGV2/ZLFxgKVIRUw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793086336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JyKucCc04e35d4MHKKCTKeq5cAzdVl1zZkVpfW2cU2A=;
	b=Dap2uRTUebsG7a4dCTXZtgf/7PakNbYW2Q2A12ZftXb9esDK7UvERrREfvw8dJrbzoL/
	 3q2Insqs7bjy1/M9UWgWFsmauEePCt1pK5Jr8s/+btQK0a2xtQevlHCME5mBzTJVMHr1C
	 Cu3Ous6yHI3pnWXNFHHRurg+kqTDDEfxaeBtfdznA7NxITYq7BdKqyLH43hCfWQWRVa6f
	 xvCxY5FICrAMVkVzTEv5ZwxmlGfgH1dIu5PqPxrypSFIYWQBsxjA83gRG2ZSkrUKoMG/l
	 53+SeY+pdhiyYRQXNN5d1oQqo1zd0CvBihz2uC6MlcMZcdeqNrQ67YRs9XUS9eaWrcw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793086336;
	bh=JyKucCc04e35d4MHKKCTKeq5cAzdVl1zZkVpfW2cU2A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sf46tzG99gGAD/AcAsVIO8xlXVKXCBKI+7SeENBp44NLKQs2A/kX5ujiHEyMVwMBg
	 ng10FxsRPPxGLJPl9LwSXOmGFLBn4bw8Yq8O526MBqa8s3uTg+g9rSNym2WxzFa7Ym
	 ti/3dxcfneShMVXM/fJLBlEq+hvlg8UERUWgCCDFvxutLKeZ/QaUiX1oxLSS+wiADf
	 Ns7WB0SPYIGjdihpOSgWx58AKm31sSfuSxO3Yy28LZRu7OqyHmncW2qpPQhQk0S8Qk
	 EQA84Ul5BYULelczQEHsoHwu55ro2K1LsCl7OoESJiAOVG5JI9Y6XgP4Qkuu7fEn/r
	 /ACUq693JBfmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8244F606B3;
	Tue, 27 Oct 2026 07:32:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B214D72
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A388380C53
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbsW7zHGf-un for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:32:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 47B3F80B33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793086335;
 b=sTUFeIEH4xltgAkCSH/ktRjRpsQKlDjDKi+iFxpzBA3PmvbQZnpsGn5vvdoutnq56Wjb
 bIVK/706LSHjg3+lWo+8x27/RhWIqOwvWKzO24im/na3NLzhHiw7+zm7e99K8n+JEU0d9
 9nnQNPVCfYBCE6ZtWPKMVgm05xL4CZ9p8lbp5+em3mBff5C6rPzEegfRFUQmZafAjaQYf
 QRASuj5aYkLaBAaPH5R0OM0z5LUifrvTrmixMBYtenVuJE8CWb5SPdHEAFXNP2BqfYzXL
 tzX3OUYaSVruPrgHcyJdPBnnL5kYfH+yM74xZaU1vzT5/I0stpFvExQ9/UQWud7ONNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793086335;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=JyKucCc04e35d4MHKKCTKeq5cAzdVl1zZkVpfW2cU2A=;
 b=nRzXKBcWMQFE/BVXuqetfrmEwJ58cHEO2SzY9TE0I716mb5r9JpA/JQlpLb+nM2722al
 +/se0c/8JIP7m+wkqglBlA6EDW+fUUKHSnCLQIZ3BQgIIAKNNCsU3gkcGEw4ikHpG2CVw
 P+T2Ys75JTjbwuE+iHrlq+JoTiNQbb+QA+efon+92d4BUNLDrmjdLRLZxJr9MxhASg2PV
 zSq5bK0dJS2PsV57bRu8IwhHfDkLXKmUKlKpsZRK0laQufzF/BlEC/CyLIyx/+VA9FdM+
 5xKDZ4GNMtcDavzq3/pqgZrNy6UgjNwfaZ+GhsP5uZY52xWiVDbkqcVkplKvQesv9KA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Yd9S2cRW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Yd9S2cRW
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47B3F80B33
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:32:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE091840D8; Tue, 27 Oct 2026 08:32:08 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B232E83108
 for <u-boot@lists.denx.de>; Tue, 27 Oct 2026 08:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0Bkm96d9lesmnZaj7JJAj/WJwJLB9IaeHxsve8Y0zVXgcg0Ksex1K9ClQB0GL2lcJFN0+vlA4BLCnOsK/OW0scIhoc8ugcn4NdgHayfuzL1JrZdBW4xQXVua29CRVATt91mbQa4TwPXr7J2u052U2BuGbc7Rh5WbbAzrdw8nUOh84MuMa5Vp+mkRR5aMkfCnf2UMnVVgGJFvqkycnp6RuPPPEBY8aju980PU8u3Mw896XKnNYOwMeUXRjXP7cPJMFLqwbt10UVwU45LxGiYhcJ7oiLXtKJNdRup1+ZN3ByLrtv3mi9gt4YyDT7ucb4pA2a9ERlHeJI1nhXqeCWEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyKucCc04e35d4MHKKCTKeq5cAzdVl1zZkVpfW2cU2A=;
 b=VXPvM0kXqUiXEkx+WnFJIhHv/3s5X9J7ItMD5CcQBi+lHvvm+4hZg1YvzFXyPunOTNp0tynoY/JfzU2GYfZzXFFnEjUuuo3NCYDsA96E7Ty5sD85TckyIYAxxHdMr+SwsieGuEPtz5Hw9EjVJ6ncR7CGBq5zWDjF3T1tPyB32mtDFmwR7qGMHR/Ku9T9QqAyUffpy9MlREyUyI+bmTW3VRuvAAP1ojyhuHyTEKasGLLVlJ72pcep3bXH1AZVaXRouqP8/EaHzpis+pWyVdb1m1U1DrNsbOG5FfCagcwLQ+ARpN0tMSV6dYKG/iLtSOgkg7zIXwUyWszBDhTkwVlbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyKucCc04e35d4MHKKCTKeq5cAzdVl1zZkVpfW2cU2A=;
 b=Yd9S2cRWJt1au30nHevt7uTdfhXS5xZJ51n2jyN3SQhfot7QQvmPQXFz6pvqMpnsBge5+wF1OfYfXAgD1s6MUw+C1Bj0FB721U3zGqgj3e+oE0ow68b6EIygzEKMLO+Ts8/6E1oqDz7RsuvXfEJxXlO6dTwuL1AWt+vfey8ifw4DjqeJwTP+sWJbrCo149AAQgQLT99sKJ+QCWgNpiK7D8g5O7kpZSQv+U4MbcDiIqkCxPJ8CsFYz07DMAZAy8l0nxmVBozReHpWm4j0KOkw3cBgLHmU9mu4yaqasvQz0lK4HzL8O2D+zSbxhPsQAKBuEJFvzU26xPiRTH3vT6U8ZQ==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by LV5PR03MB8410.namprd03.prod.outlook.com (2603:10b6:408:35c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:31:58 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0522.013; Tue, 27 Oct 2026
 07:31:58 +0000
From: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Kathpalia, 
 Tanmay" <tanmay.kathpalia@altera.com>, "NG, TZE YEE" <tze.yee.ng@altera.com>, 
 "NG, BOON KHAI" <boon.khai.ng@altera.com>
Subject: RE: [PATCH v3 1/1] Add dedicated device tree and configuration
 support for Agilex5 Modular DevKit which uses an external GPIO expander for
 1.8V signaling control instead of the onboard GPIO used in the Premium DevKit
 variant.
Thread-Topic: [PATCH v3 1/1] Add dedicated device tree and configuration
 support for Agilex5 Modular DevKit which uses an external GPIO expander for
 1.8V signaling control instead of the onboard GPIO used in the Premium DevKit
 variant.
Thread-Index: AQHdS8cs+ZiuO4GPdkGGm04XGRPxObb8keuAgBSgc2A=
Date: Tue, 27 Oct 2026 07:31:58 +0000
Message-ID: <PH7PR03MB70633B6F1BAD35D309602F9BAD602@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20260924015013.3857-2-alif.zakuan.yuslaimi@altera.com>
 <de873ec2-f446-410d-8be8-1f427359bf0e@altera.com>
In-Reply-To: <de873ec2-f446-410d-8be8-1f427359bf0e@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-10-27T07:29:55.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|LV5PR03MB8410:EE_
x-ms-office365-filtering-correlation-id: bdc1e70b-ab92-4bf2-c27e-08df33fc623c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|3023799007|10067099003|56012099006|6133799003|22082099003|18002099003|55112099003|4143699003|11063799006|38070700021|261026140227099003;
x-microsoft-antispam-message-info: m+ySRBv6uy0lxuuZrxI7Vpxb9JoqfjPaU2gyXdP4pzKf6JX5BvcYrKVqA/NzhfgAd5aBmpRevd+3b1u68v0QaSXkZQq9B5jN5DSi82xE9z922MFbptSX8o6M93xiZdz2Q+2ltC7BQOO/q74qKqqFDB4vr1hKSq62fBTmJSHXW3/LkiQP4Nb36FiLGX8Kt3xZZ8RHL4OQY4VxGfgY2GNwFJEACCp3QVlrkpMmtDHaXb6zWgx+vxrGMErPbs62HQEN2xB52Kgn16UFMux+IaWNgVWsqSFScM7jgkLkK0rRhC0kz6t/lP7CpVMT9NV4Tr/Ww3PSU47HolPxbADJjSP+p+W7+a+bEVEBFIOTZo37Xex42Dy5o4OVK3La+TecroqhTM7sm3/4wHtjQ1QtxyrUt0BvZoYq0Zmw8Yi6ausC3VzDQXSXY/Zk6f6EVqSj3/Na1iLGkvGrT51wn+iCh68jYR4iarEuoFOnyfRjh/hCaN7k06HOaTXRhSZ7KzRNBzhpCJdijMRUf8KXag4Ml50JzmJYW0w/4T/eLzuNq0DMua3pdphRnkmphHfIrhRg6wwNe8sQCD8qlm+52KmtpYvV69BPDVdxbFbeQRAwHmEV7ovoB6jn8KX41weRGDy3Lz7g52Gm//aEcZF2FWPZ234teD+CS8TGdO/GfJsZ9KeejDBV61WEWBlmITaKoaP3km15A+aZto7GM44Y2sW+HhJu2KGuH2DUYutNYAZLbX3e+ac=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(3023799007)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(55112099003)(4143699003)(11063799006)(38070700021)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0pzZGN6SEljTHVQR25Wb0JjWEVCME9yQ1NJNUFQNEpiS0VvWURNNXdWS2ZL?=
 =?utf-8?B?aVdMdnVQZzBob1VXWmlYZXFYbktJSk40Y2hQeUFZTDNsQmkybzU2U0tNWW1s?=
 =?utf-8?B?bG9xY1M2b1d5NmE1ZlFTT0puMmtRRjcwcVZpb24za216Si92NGp5SldNTWti?=
 =?utf-8?B?L3k4WkFNZXNHaVZ6Qy9LbzE2TFc5TWVRd0N2VE1jTm93VktidEY5Y1V2RDdq?=
 =?utf-8?B?WXFidURoTm5zNjB4aHJvZUUxSWVjWkFuUERFaXJsTVFUMDdFVHhtM1hNai9O?=
 =?utf-8?B?ZnhTVU5FY2pXbHE2R2RwT3Z0OG1QUkQvaWt0VWpNZjVVeWlLM2RIR2FpbXZD?=
 =?utf-8?B?STZOVTM2bVprOXMrY3NFbzVPTGUwR1A4VWllNFRzWkdpYStodGtyU2VTS1dV?=
 =?utf-8?B?MWFJeXN2M3dPVEpFSWVQcVI0UlU4MkVjMUwwRVFvb1VCbXcyU3U5TkM5eXZn?=
 =?utf-8?B?dnlwTDR3all4MTB1T0ZsSXphOVlHMkJtTnBpREdvSElOcXVVVmRQdnRDdnJw?=
 =?utf-8?B?QWV2QzY1TW1tdUp2blFxL0hLbTViK1RTRE1vcUYweGdwc3VuRVJXamxFYUMz?=
 =?utf-8?B?amdndkZNV2RrR3F0Z2dCZFppMjZZZlpJNGJvMmQzTlhNdno5MmhFWXZMMGJC?=
 =?utf-8?B?LzJFRmdBa2YzOXFMeVZqbFZTV0Z1aC9HRkNPODVwOFhZTDRlOVFpR05adjJT?=
 =?utf-8?B?T0RYTFJYN1VNcjVWb0xqazdCOFRoZW5CRFdtNGRVaXlQYWdoTGpxRzluYVgx?=
 =?utf-8?B?NE9wU1l0dnd2S3JOWHgzVFo0NmJyanF0R0JSd05rc2xsZ3J3ZHJZVGFoaGdt?=
 =?utf-8?B?Q2JiZDBhWERURVAwQXBJVlVGODN1WG9pZDhHWXcvRktPbzJBR2Vxc1dPQ0gx?=
 =?utf-8?B?Z3M5QXpCTVVIWUxBbXZodWZDaU9QcXVTWnJjWVdSZTU3TnkvMTdrQ2VQMkRR?=
 =?utf-8?B?dHJtUTNHNWNjYTVhMjVUN2V0SDJ1dWF5SXM1bFJvM21MOWp2TG4wbzVxOERm?=
 =?utf-8?B?Z3g4UElVbjhUUWFPTjcvL2J4K2VwZEEzTXZtbWZ4d3hOTnlITjlZczEwTTNB?=
 =?utf-8?B?dGlGWTRFMG9tSmFESnNtdHZOOVpVeFRNM1o2MXJRSFp3ZS9qOEtMSjBnUTg1?=
 =?utf-8?B?bTVyWHFIQzRGUDVIN1VNdUhPS2FDQmFYdUtnamJINU1xZUZsYTBYQ1lDLzg0?=
 =?utf-8?B?T1lidTdNZW8rTjVBd0M0NStJUk9SWDRRWk9XVlUxT3BwdVpZTTdUcFZhZ29j?=
 =?utf-8?B?bjRpZHZYMGplK0piWm1CbGZhM0s2NjBvcCthMnFaZkYvems1dmFDVFYwVDVh?=
 =?utf-8?B?M1VlcktJWDFyYzJhdFR4TWVSVjExZE9mMzdBS0FpV0hGeU1pamo1Vnd0UXN0?=
 =?utf-8?B?VlYwWitHK0lWYklBQi85YlF4ZXVBTzNsM1dsTXNCaXVTaUxTTmU5L2U3T1lU?=
 =?utf-8?B?dUdUZkplWmhiNFJ4VVgzVW03d1E3MTd3WlJWUmhnTlFveVZmQVNuaWVyandD?=
 =?utf-8?B?emYwM2lhRFUzZzdOaUtwS0xjWXlDZURMZVZmd0dTYmQyMW0yai9Ha0xUcnA5?=
 =?utf-8?B?dUUxSjgvYTV3U3VDLzRKTEQzTXJ0OHUxbFVwQ1FDZXE5NmVVMEo0UkhRV0lG?=
 =?utf-8?B?empkcmFxanhVQXFKeFVhU3dTbDIwTVVwMEo2VmZvVVZ6SG5KNTN2dDdteS8w?=
 =?utf-8?B?U0o4ck9FOGMweGNIaEY4MXRUb0VJdnpzYXRNN3pqOThMbDVvOGxuS1Zrczdj?=
 =?utf-8?B?cHBVV1FxQlZiUjhTMTdveEVVU29OOGtkZTdwQzIrOUJlTmJlMkdQRmVPcXJU?=
 =?utf-8?B?UlJDUldyWDF3QUFaQVUyb3pWYmdZTElSSkwzV3ZUZHpWVTdneHhRLzZNUUxX?=
 =?utf-8?B?a0k0cjVyL2QvSTNScVRqMXVQR0FMcnIyTnE4MG5icEZQcFR1MElUaGVVTWhL?=
 =?utf-8?B?MXhaT3pSRzFEbVVmVURPUFVIMGhycDc0U01lSWI0Y3BNZWhRZ25adldySUxT?=
 =?utf-8?B?SnhaeU9SWnFaMnZ2M2ZHUjI5aVh1blZISE9mamlTUi8rQ1VVanJqbkVPS1Zl?=
 =?utf-8?B?MnA5MDFCK1p5VWFMM2thOWdGbTJPTGRMdmQ2VlZmaGVGSWZvZUNTWkZjK0FZ?=
 =?utf-8?B?YkNEeEpyeGxCVld4d2twWk1DelljWTJZRmpSU3dJSVFkMWsyVkRCdjNlOFoy?=
 =?utf-8?B?R2QzTDZTNWJaU1VPbHB0RkkzQURxd2NPK2dic2NsM0p0cTVORWRvOGR2K0FM?=
 =?utf-8?B?UnZmVWRiM0t5aDA2R2g3aURXOG5UN0VSUStVNmpIYzNDTjJvejgyQURZczl2?=
 =?utf-8?B?SWFsRzM5YnljUElpUFRyL1dLRGJSWFJjNjRUUStPZmR1eVdhZlkvOG90aTdN?=
 =?utf-8?Q?eKIdZXvw18176Vh0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc1e70b-ab92-4bf2-c27e-08df33fc623c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 07:31:58.2404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5eKO5tql7o94xjwo8VXReKrp+U8epezIwOhmgnNmgJHD67biHzmPwGyelVut61lisWmsyvtGLWCN6m87bSIBcnQFwyVMCXQ93EtcC6qztI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8410
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgVGllbiBGb25nLA0KDQoNCkFsdGVyYSBDb25maWRlbnRpYWwNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBhbHRl
cmEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTQsIDIwMjYgMTI6MzAgUE0NCj4g
VG86IFlVU0xBSU1JLCBBTElGIFpBS1VBTiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAYWx0ZXJhLmNv
bT47IHUtDQo+IGJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogTWFyZWsgVmFzdXQgPG1hcmV4QGRl
bnguZGU+OyBTaW1vbiBHb2xkc2NobWlkdA0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWls
LmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+Ow0KPiBLYXRocGFsaWEsIFRhbm1h
eSA8dGFubWF5LmthdGhwYWxpYUBhbHRlcmEuY29tPjsgTkcsIFRaRSBZRUUNCj4gPHR6ZS55ZWUu
bmdAYWx0ZXJhLmNvbT47IE5HLCBCT09OIEtIQUkgPGJvb24ua2hhaS5uZ0BhbHRlcmEuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMV0gQWRkIGRlZGljYXRlZCBkZXZpY2UgdHJlZSBh
bmQgY29uZmlndXJhdGlvbg0KPiBzdXBwb3J0IGZvciBBZ2lsZXg1IE1vZHVsYXIgRGV2S2l0IHdo
aWNoIHVzZXMgYW4gZXh0ZXJuYWwgR1BJTyBleHBhbmRlciBmb3INCj4gMS44ViBzaWduYWxpbmcg
Y29udHJvbCBpbnN0ZWFkIG9mIHRoZSBvbmJvYXJkIEdQSU8gdXNlZCBpbiB0aGUgUHJlbWl1bQ0K
PiBEZXZLaXQgdmFyaWFudC4NCj4NCj4gSGkgWXVzbGFpbWksDQo+DQo+IE9uIFdlZCwgMjMgU2Vw
IDIwMjYgMTg6NTA6MTMgLTA3MDAsIGFsaWYuemFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20NCj4g
d3JvdGU6DQo+DQo+ID4gRnJvbTogQWxpZiBaYWt1YW4gWXVzbGFpbWkgPGFsaWYuemFrdWFuLnl1
c2xhaW1pQGFsdGVyYS5jb20+DQo+ID4NCj4gPiBOZXcgZmlsZXMgYWRkZWQ6DQo+ID4gLSBzb2Nm
cGdhX2FnaWxleDVfc29jZGtfbW9kdWxhci5kdHM6IE1haW4gZGV2aWNlIHRyZWUgZm9yIG1vZHVs
YXINCj4gPiBib2FyZA0KPiA+IC0gc29jZnBnYV9hZ2lsZXg1X3NvY2RrX21vZHVsYXItdS1ib290
LmR0c2k6IFUtQm9vdCBzcGVjaWZpYyBhZGRpdGlvbnMNCj4gPiAtIGNvbmZpZ3Mvc29jZnBnYV9h
Z2lsZXg1X21vZHVsYXJfZGVmY29uZmlnOiBNb2R1bGFyIGJvYXJkDQo+ID4gY29uZmlndXJhdGlv
bg0KPiA+DQo+ID4gS2V5IGRpZmZlcmVuY2VzIGZyb20gUHJlbWl1bSBEZXZLaXQ6DQo+ID4gLSBV
c2VzIFBDQTk1MzUgR1BJTyBleHBhbmRlciAoSTJDIGFkZHJlc3MgMHgyNykgZm9yIHZvbHRhZ2Ug
c3dpdGNoaW5nDQo+ID4gLSBHUElPIGV4cGFuZGVyIHBpbiAxIGNvbnRyb2xzIHRoZSBsZXZlbCBz
aGlmdGVyIGZvciBTRCBJL08gdm9sdGFnZQ0KPiA+IC0gUmVxdWlyZXMgSTJDMyBhbmQgUENBOTUz
WCBkcml2ZXIgc3VwcG9ydCBpbiBTUEwgYW5kIG1haW4gVS1Cb290DQo+ID4gLSBTYW1lIFNEIHRp
bWluZyBjb25maWd1cmF0aW9ucyBidXQgZGlmZmVyZW50IEdQSU8gY29udHJvbCBtZWNoYW5pc20N
Cj4NCj4gUmVzcGluIHN1YmplY3QgdG8gbWF0Y2ggdGhlIHNlcmllcyB0aXRsZSwgZS5nLiAnYXJt
OiBkdHM6IHNvY2ZwZ2E6IEFkZA0KPiBBZ2lsZXg1IE1ESyBleHRlcm5hbCBHUElPIGV4cGFuZGVy
IHN1cHBvcnQnIChrZWVwIGJvYXJkIGRlbHRhIGRldGFpbCBpbiB0aGUNCj4gYm9keSkuDQo+DQo+
IExlYWQgd2l0aCB0aGUgaGFyZHdhcmUgZGVsdGEgKGV4dGVybmFsIGV4cGFuZGVyIHZzIG9uYm9h
cmQgR1BJTyksIHRoZW4NCj4gYnJpZWZseSBub3RlIFNQTCBJMkMvUENBOTUzWCBkZXBlbmRlbmN5
OyBkcm9wIHRoZSBmaWxlIGludmVudG9yeS4NCj4NCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
bi4gSSB3aWxsIHJlcGhyYXNlIHRoZSBjb21taXQgdGl0bGUgYW5kIG1lc3NhZ2UgZm9yIHY0IHN1
Ym1pc3Npb24NCg0KPiBJZiBjby1hdXRob3JzOiBhZGQgQ28tZGV2ZWxvcGVkLWJ5IGJlZm9yZSBl
YWNoIGFkZGl0aW9uYWwgU29CLiBJZiByZXZpZXdlcnMNCj4gb25seTogdXNlIFJldmlld2VkLWJ5
IGFuZCBrZWVwIGEgc2luZ2xlIGF1dGhvciBTb0IuDQo+DQoNClN1cmUsIEkgd2lsbCBhZGQgdGhl
aXIgbmFtZXMgYXMgY28tYXV0aG9ycyBmb3IgdjQuDQoNCj4gQWRkIEY6IGNvbmZpZ3Mvc29jZnBn
YV9hZ2lsZXg1X21vZHVsYXJfZGVmY29uZmlnIChjb25zaWRlciBhbHNvIGFkZGluZyB0aGUNCj4g
ZXhpc3RpbmcgZW1tY19kZWZjb25maWcgaW4gdGhlIHNhbWUgY2xlYW51cCkuDQo+DQoNCkN1cnJl
bnQgTUFJTlRBSU5FUlMgZmlsZSBhbHJlYWR5IGNvdmVycyB0aGUgbmV3IGZpbGUgcGF0aHMNCg0K
PiA+IGRpZmYgLS1naXQgYS9jb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9tb2R1bGFyX2RlZmNvbmZp
Zw0KPiA+IGIvY29uZmlncy9zb2NmcGdhX2FnaWxleDVfbW9kdWxhcl9kZWZjb25maWcNCj4gPiBA
QCAtMCwwICszLDQgQEANCj4gPiArQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9InNvY2ZwZ2Ff
YWdpbGV4NV9zb2Nka19tb2R1bGFyIg0KPiA+ICtDT05GSUdfU1BMX0RNX1JFR1VMQVRPUl9HUElP
PXkNCj4gPiArQ09ORklHX0RNX1JFR1VMQVRPUl9HUElPPXkNCj4gPiArQ09ORklHX1NQTF9TWVNf
STJDX0RXPXkNCj4NCj4gRHJvcCB0aGUgdHdvIFJFR1VMQVRPUl9HUElPIGxpbmVzOyBrZWVwIEky
Qy9QQ0E5NTNYIGFuZA0KPiBERUZBVUxUX0RFVklDRV9UUkVFIG92ZXJyaWRlcy4NCj4NCg0KTm90
ZWQsIHdpbGwgZHJvcCB0aGlzIGluIHY0DQoNCj4gWy4uLl0NCj4NCj4gQmVzdCByZWdhcmRzLA0K
PiBUaWVuIEZvbmcNCg0KVGhhbmtzLA0KQWxpZg0K
