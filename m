Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59010606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zVLf0mTf;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=WMJHmQGK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D954F81053;
	Tue, 17 Nov 2026 02:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwQ2knbkFaEC; Tue, 17 Nov 2026 02:27:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E08A80E7D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794882460;
	b=QnL5GBxGQMIeYXaAf3u5YYPlqda/FOPGWTn41oHZ45cqRGqLdfOxy2GYTfTiNJASckL1
	 w8UPVHUh4RuVmlTynniuQ1nUhM6e4Boy02MYiv5P1Yf/WWgOM3lcsTqmpM5mrgibP+BO2
	 f+A2WVKcc7WY6IhFRF0F3Z2hTqCFbG8G5CyI/qSlI80R1uA0ABRVKu09sFUkUfM6IDrkY
	 qZ3SXlh/ma9mzG3zpudLE8RS58mwpod7Lrmo06s7jxh7hM0+zxb2BrV/RKOGoZKxIfKrK
	 GjTQYjs2HLSaRKyvttKeURD0uZOryyTohdYf2rTjinVSucecmFy3r0ziN678J/bJCgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794882460;
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
	bh=sf0sxDEm4g9fNk9NPiEv7tNJfoXNy6nSv/ZtkwBqQbI=;
	b=kT6W7/LUWf2K1pbfwW4Sh7j/j4PPZxCBxPuahk5GtZEPeUWcIk8IFD5xiFvf4xKP0fcb
	 DY4Ffy8n/IFRZ07xsuJvk7FVyVGap1XpQRvLCJWfNi5IDPGjF+lmlaia6j1w9TgMSTwKf
	 e22XUAx5QJBtwmUnbjRc5+Mpig3wIqc4dXNV7LfPWFyp3U+QTHnuY2IYhJpLBDAlPTpXC
	 9jNHeQbBL6KED/ML65NiEBoFy4lz9LmCp0HfuQr+QewMhW/rb2TyJDDxin05tFA2UkLPM
	 XWad4B7Q9ItGsMmAuXCwF5og1JbVZVCw6Muu99bqg4rQjXCrdVaPaxrr2NT5P8aR1wA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794882460;
	bh=sf0sxDEm4g9fNk9NPiEv7tNJfoXNy6nSv/ZtkwBqQbI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zVLf0mTfRuCvgWV71HtsqlSEwWE3HLpORz/u4gYqOxCT+J5fu//PzgONGbjdYhFJH
	 x8HcOaLUjCVg35qGVVt/wrHSpLXUO7CjdLfkIp0KspYeFveeCkFbJsdGcDKZkOmfIX
	 RX2BnBnN6oMnqFn1meWES3MAcZX0vdkmAfcTj53bw3txcM7ZF+8SCRKmxZf5HJKrQe
	 9uvxPv13SYfcX406/krN1AryvqdDAOmbaqD/6Wl+H19uTB8Iy84VW0G4lyd/6MOtAv
	 Vaz0c86q3Xs2jBCQAFPUzB5CMCuf47xtHI0mKRCesYaHMzBtIAHxUsAXBDIeHhG31u
	 HRiXGB+FCskZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E08A80E7D;
	Tue, 17 Nov 2026 02:27:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 019ED1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7CF140565
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ru1bdrJfg-E2 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 02:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A693E40742
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=WMJHmQGK
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A693E40742
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf0sxDEm4g9fNk9NPiEv7tNJfoXNy6nSv/ZtkwBqQbI=;
 b=WMJHmQGKCYQ7g0c6bV36MWIQg72k9Qqg3Z5J9dJWEV6c0FxoPF2AnxoZDVIPOrueubGcX0BP6YJEBcRfZXzXPwFHDwy8/0MksqQsfr9XHc4TJQoYAVslkrPhI0OVm8zyFIcEybROkyndKjeyGZ1FrrLfwn1kE0hhVawB4TK0vdidrxBKu+CGzTDQy1/9GDFIiVg2aJnZ5+A6tW5rjDQDesoXmc6a+hjTyqTeKTEmWuVMv7reQsFwweIkfVpRJrMSNzrmd3brarVujvIzENugEdScmoo+OtNsOiix6BndMmTON6MWapD01iNCMJ6tw9YGY6K0EVFaZ9pZZVheI5ef3w==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7514.namprd03.prod.outlook.com (2603:10b6:806:380::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 02:27:33 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 02:27:33 +0000
From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: Boon Khai Ng <boon.khai.ng@altera.com>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Lukasz Majewski <lukma@nabladev.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 01/20] clk: altera: Constify driver ops
Thread-Topic: [PATCH 01/20] clk: altera: Constify driver ops
Thread-Index: AQHddfDzkycMwNYvckuwqC0x97gQm7cxiGOA
Date: Tue, 17 Nov 2026 02:27:32 +0000
Message-ID: <PH7PR03MB7063CC325305C2B9A92A091EAD7B2@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-11-17T02:19:54.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|SA3PR03MB7514:EE_
x-ms-office365-filtering-correlation-id: c059b061-3a23-4d54-09d5-08df445255fc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|55112099003|11063799006|56012099006|10067099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261009223027099003|261021121427099003|261009221227099003|261102123227099003|38070700021|261026121527099003|261022105027099003;
x-microsoft-antispam-message-info: fInrkh16iExzGWiuXDWZNHCE7ohQlyApNAgvmu2IJehLCcd7L3iWCbY/thdVfGaoqUcJLRsbd+ZJlWfkjGluaGdMlc6WXz9bkCyc+gSyRuSjmIaA4kDgL1yNuVVJ/flEOxGuC+Zp7JjCl2XMBiKs2vE6KnYFEUy8kQdeTohMIWVQLoC6aBGrif1wzPSE+qJ4C+l5MFKlVxeY4tFFQ2//0KbRLnSD/mLTO+Zz74ovBiakwXButI3jrq7rz0fElueUp9gagU99iW7epq412tn73KZLKtUdRs1opl20R8oSvERrBJZECT2qX/FCOcEEo1iwKBjpzhmaX7gEXT8Rr2rMqLQOYIuDV0w8dGbC/zNi6BXZSFKgyzgHu/PSVGO94FO67w+F7Dvo6b2Ouj7Anb6xU+LDFeNd4xAQA5zGVxQb2cJVrSE0P8tPn4IaWuga/8YE740iqMDe7v67mYWj/WIxqPo8lLn9H1rcsOp6VkRGOvvkEHxo6+zPVEdAjNGkFGn4nW/a7+7IbHpqDWi8T04ZU3VmNz74ts7Q5I7KaMy9LH10/sV93VLGGoej1khcoefZHUZ2F5UItdkuf4q9D0zM8rNlzLKfa7rSloI/PqKHJcJbaaqteicouC6nvBot/KdIzL774Qz62XXVuVFYO/1MfS7vuprnyHAmCwGUZYmX8XlaamgfXJ/1K8qKreQUygVSWzKLRpPhgiCb44OVessavJ9Uroo2Z57ZpWFFWt0iwho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261009223027099003)(261021121427099003)(261009221227099003)(261102123227099003)(38070700021)(261026121527099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTNTb0toWTdpRVEvdmJjOXorZ3BROG1tcHVJcHhMenpYQWhWdXZMZXVKQWVT?=
 =?utf-8?B?UG1lOGJNLyt3dVpTRXd4aWRwYm9RYVhxalhFNDNvWCtiSDRxbTBSbXQ2N1JV?=
 =?utf-8?B?QVJJaW1MVkYvUjR1UnpQYXkwS0E1VHRtcTFpaWNLQkVVVWIycXFIcmxiYVg3?=
 =?utf-8?B?NGJpaE5abEVYY1FjRUYxUGVZdXFiZlF4alNKV012TnYxYStyTlRhSkNVUnpU?=
 =?utf-8?B?bjFHYXRjZjNDbEs3dFJJSVdVbkdpblNRamZBUlFHcVpaQlJhVWZScW1nUkxJ?=
 =?utf-8?B?MzJpVW9QcjhqcElONDVobXFFTk45eHJsQ3dqUmxSc09OMHpBZHVGNkxoVXhW?=
 =?utf-8?B?a1ZqVkhzOXpZU1VSWUtvSWpSejRYSC95RlhGamxaREJvdmVZTU53bTlwdUF1?=
 =?utf-8?B?M280YXd3M3FZbzN0Z2RtNHptUHV2K3d2TjFQWGFmV3k4LzdnakxBQ3lMWGZX?=
 =?utf-8?B?bnVUbW9ORGlYMmJydUs5WDZzZ1RsOXNQVkdyVkNPb3BhcHMyTHljeGV6aU8r?=
 =?utf-8?B?RFhGNjdNa2ExeElybk9IandyUTJwU2c0L0JaWVZwbXVzdHpvK3lqU1MyWGY2?=
 =?utf-8?B?QmVyem9uSWF1Tk1zWG84WEFPRkVwUHI3aldZUnhFTWswWFFWUzNWS0RRamJa?=
 =?utf-8?B?SElnQjlPV1FiWWRZVHdBRkJCenI5QzBSYmZENFZROHRuQWJHK3g0QkwzblZ2?=
 =?utf-8?B?eS96U2hsY0srQVVSQ1MyMC9zeFZ3aHEwUko1dHI3QUI4MTNHbnAyUzd1UHR3?=
 =?utf-8?B?SHFQVjlvbDdGNzdkWEI2YlVIVDVMN0I3eWpDYnlZcWRYM2pWZlZONEJOSUhh?=
 =?utf-8?B?N2pRWHFDTVNrSEFqZDBiQ0lDQkNRKzhXYUJiaStQSExNNThWQ2JlOXNMNE9X?=
 =?utf-8?B?cFhpSXJOQWp3QS9LVTZHdlJFU3pzZzExUXltRXNueU15VmhjbjRzWVhaa3Y5?=
 =?utf-8?B?RlhNODU1R0h2SXdvOFkweXhLNjZiN1U0OTV4YzNWcDFGcmMxME91cXJlSllZ?=
 =?utf-8?B?T0xocTliMGZMakZBc3F0MERGaHd6NHRDUmRQN0tRQkdKdjhWYk9ER1dQMks3?=
 =?utf-8?B?VkpEVEM2THF6ZmwrY1RHeTNzQU45MEhBY3lNTVlpZ01yUzQ5cWNXMXFhWkxk?=
 =?utf-8?B?dHNpaGlNVytEUU8rRjBBNVRucFJxOXdxUHN1ZHUwc1FscmRFMTM1dUF5Tjg1?=
 =?utf-8?B?czhYR204Zk4yS3pneVJ0VzFpQTdIMkpOemJxZGtJQU9sYVMvYm9UcW5Hd2lB?=
 =?utf-8?B?cDlPZzdsbnFVNUVITzloUnNJMWtLaHZ5cHJuZDg0NUxoR0RwdDhOWHU2Mzha?=
 =?utf-8?B?L0hNSU9HdFY0RG1OemZ5L1IzZFphVmNCeFh4SlQ0SlUvQWpSdWVYanpBRmFE?=
 =?utf-8?B?Q3FBbGVZdy9Id2FFc3RPZmM1b04wdW9aVU1zcStNYm00cDRtOGJrS1pOU0VS?=
 =?utf-8?B?a1JVY1RydHRPNHBnRjZWUTlWTGVtTmFDMzZKUTJZajd0V1YwaEVSRENkb3dV?=
 =?utf-8?B?R3B2WGZlL09NNXhYdndEaHp6T0kxbERFSlZkSFVUbmhYWnpUa1VYb3piaFUz?=
 =?utf-8?B?ekJTYjk0cC9WQ3k5VDhaaXI4MDhNVUVKakJYMTM5ckd5YUtEMUo4dUxjVjBz?=
 =?utf-8?B?bXA5c2huRXQ4OFZXTXZEbHN3RzFjelV5KzhDT053bE1wNmVDL0I2ZUt1RUdu?=
 =?utf-8?B?U1hGcmV6djlGcXpsRmJaMjVhVmZzR0NUNWZUTmZhbUtib3FnTTI0L1BOTzBD?=
 =?utf-8?B?Ui9FT0Y5Wk5PWkR6czlFdU5hOFluTTM3bGFBWWxWZ0xrdmJuSjJNM05iU3VY?=
 =?utf-8?B?dVFKNHFNcWFtZmVEQkZZdldpQWk5RHlmcG5PSEEyY3pxa2kyTlUzQ3d2cUZk?=
 =?utf-8?B?bHNrZFJxY2pSMmkrQU13aG13Z1R5QXdicTZwVXp2c0FXM3VlbFhXcE9zbFA1?=
 =?utf-8?B?Lzd1U1pyd05GSEpGdGhVM1BTU0FNazU3WlVGV1RiZWJicWVFRThDTWc3QjVB?=
 =?utf-8?B?STI0anpHTlVxY0kvL2xsYmgxVnhyTkZpajhkd3dmNUZnejI3MmFoWVhoZ1Zr?=
 =?utf-8?B?RFF6eWY0M3ZOU29kcHpPS2U2YUVLZFQzR2RmaUpLeEhubkoybklyT3JDOTFG?=
 =?utf-8?B?MFRrY29XNGF4OVVxelNGWG9qN1NmQzliR2N6SmxKM05DOXJUOVhwR1lUNmky?=
 =?utf-8?B?WUlJL2JPcmMxWUloTmtkTGNOOWVoNG5UUTlJUjlSNmtGeVRMZ3NMQ1RCLzZk?=
 =?utf-8?B?UVVBRWtidkhkV29qNUo3MUZUOWZZL1lRYWx2Sk0wNjhvWk5VUmovUmMwb3VX?=
 =?utf-8?B?OG8yVi9tMGUzV0Z5R0ZwL1hEcVlaZ0FackQrcHJTRlI2eGlZRVA4L3o5SUNi?=
 =?utf-8?Q?V0a4nRlBRFvNQfvM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c059b061-3a23-4d54-09d5-08df445255fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 02:27:32.9437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ev1VBuXfGODCQutqk4+sFuLo0UqQorrOOO/+ap33Wucj3V4njwdGUjySRz5c2GdX47Uoa0w+WqfImRT9AI1A38rC1AH4hMBWg3mbmxXRpLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7514
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGVsbG8gTWFyZWssDQoNCg0KQWx0ZXJhIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWls
Ym94Lm9yZz4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTcsIDIwMjYgMTozNSBBTQ0KPiBU
bzogdS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZw0KPiBDYzogTWFyZWsgVmFzdXQgPG1h
cmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBBbGlmIFpha3VhbiBZdXNsYWltaQ0KPiA8
YWxpZi56YWt1YW4ueXVzbGFpbWlAYWx0ZXJhLmNvbT47IEJvb24gS2hhaSBOZw0KPiA8Ym9vbi5r
aGFpLm5nQGFsdGVyYS5jb20+OyBEaW5lc2ggTWFuaXlhbQ0KPiA8ZGluZXNoLm1hbml5YW1AYWx0
ZXJhLmNvbT47IEx1a2FzeiBNYWpld3NraSA8bHVrbWFAbmFibGFkZXYuY29tPjsNCj4gUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+OyBTaW1vbiBHb2xkc2NobWlkdA0KPiA8c2ltb24uay5yLmdv
bGRzY2htaWR0QGdtYWlsLmNvbT47IFRpZW4gRm9uZyBDaGVlDQo+IDx0aWVuLmZvbmcuY2hlZUBh
bHRlcmEuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIDAxLzIwXSBjbGs6IGFsdGVyYTogQ29uc3RpZnkgZHJpdmVyIG9wcw0KPg0KPiBbQ0FVVElP
TjogVGhpcyBlbWFpbCBpcyBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uIFVubGVzcyB5
b3UgdHJ1c3QgdGhlDQo+IHNlbmRlciwgZG8gbm90IGNsaWNrIG9uIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgYXMgaXQgbWF5IGJlIGEgZnJhdWR1bGVudA0KPiBlbWFpbCBhdHRlbXB0aW5nIHRv
IHN0ZWFsIHlvdXIgaW5mb3JtYXRpb24gYW5kL29yIGNvbXByb21pc2UgeW91cg0KPiBjb21wdXRl
ci5dDQo+DQo+IFNldCB0aGUgb3BzIHN0cnVjdHVyZSBhcyBzdGF0aWMgY29uc3QuIFRoZSBzdHJ1
Y3R1cmUgaXMgbm90IGFjY2Vzc2libGUgZnJvbQ0KPiBvdXRzaWRlIG9mIHRoaXMgZHJpdmVyIGFu
ZCBpcyBub3QgZ29pbmcgdG8gYmUgbW9kaWZpZWQgYXQgcnVudGltZS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+DQo+IC0t
LQ0KPiBDYzogQWxpZiBaYWt1YW4gWXVzbGFpbWkgPGFsaWYuemFrdWFuLnl1c2xhaW1pQGFsdGVy
YS5jb20+DQo+IENjOiBCb29uIEtoYWkgTmcgPGJvb24ua2hhaS5uZ0BhbHRlcmEuY29tPg0KPiBD
YzogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20+DQo+IENjOiBMdWth
c3ogTWFqZXdza2kgPGx1a21hQG5hYmxhZGV2LmNvbT4NCj4gQ2M6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5nb2xkc2NobWlk
dEBnbWFpbC5jb20+DQo+IENjOiBUaWVuIEZvbmcgQ2hlZSA8dGllbi5mb25nLmNoZWVAYWx0ZXJh
LmNvbT4NCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IENjOiB1LWJvb3RA
bGlzdHMudS1ib290LXByb2plY3Qub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvYWx0ZXJhL2Ns
ay1hZ2lsZXguYyAgfCAyICstICBkcml2ZXJzL2Nsay9hbHRlcmEvY2xrLWFnaWxleDUuYyB8IDIg
Ky0NCj4gZHJpdmVycy9jbGsvYWx0ZXJhL2Nsay1hcnJpYTEwLmMgfCAyICstICBkcml2ZXJzL2Ns
ay9hbHRlcmEvY2xrLW1lbS1uNXguYyB8IDIgKy0NCj4gIGRyaXZlcnMvY2xrL2FsdGVyYS9jbGst
bjV4LmMgICAgIHwgMiArLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQoNCkxvb2tzIGdvb2QgdG8gbWUuDQoNCkhvd2V2ZXIsIGRyaXZlcnMvY2xr
L2FsdGVyYS9jbGstczEwLmMgc3RpbGwgaGFzIGEgbm9uLWNvbnN0IHNvY2ZwZ2FfY2xrX29wcyB0
YWJsZS4NCkNvdWxkIHlvdSBmb2xkIHRoZSBzYW1lIGNoYW5nZSBpbiBoZXJlIHNvIGRyaXZlcnMv
Y2xrL2FsdGVyYS8gaXMgY29uc2lzdGVudD8NClRoYW5rcy4NCg0KUmV2aWV3ZWQtYnk6IEFsaWYg
WmFrdWFuIFl1c2xhaW1pIDxhbGlmLnpha3Vhbi55dXNsYWltaUBhbHRlcmEuY29tPg0KDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hbHRlcmEvY2xrLWFnaWxleC5jIGIvZHJpdmVycy9j
bGsvYWx0ZXJhL2Nsay1hZ2lsZXguYyBpbmRleA0KPiA0MjZmNDAwMTU5Yy4uYjI5YTdlZTE0NWYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2FsdGVyYS9jbGstYWdpbGV4LmMNCj4gKysrIGIv
ZHJpdmVycy9jbGsvYWx0ZXJhL2Nsay1hZ2lsZXguYw0KPiBAQCAtNzg0LDcgKzc4NCw3IEBAIHN0
YXRpYyBpbnQgc29jZnBnYV9jbGtfb2ZfdG9fcGxhdChzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiAg
ICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPg0KPiAtc3RhdGljIHN0cnVjdCBjbGtfb3BzIHNvY2Zw
Z2FfY2xrX29wcyA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX29wcyBzb2NmcGdhX2Ns
a19vcHMgPSB7DQo+ICAgICAgICAgLmVuYWJsZSAgICAgICAgID0gc29jZnBnYV9jbGtfZW5hYmxl
LA0KPiAgICAgICAgIC5kaXNhYmxlICAgICAgICA9IHNvY2ZwZ2FfY2xrX2Rpc2FibGUsDQo+ICAg
ICAgICAgLmdldF9yYXRlICAgICAgID0gc29jZnBnYV9jbGtfZ2V0X3JhdGUsDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9hbHRlcmEvY2xrLWFnaWxleDUuYyBiL2RyaXZlcnMvY2xrL2FsdGVy
YS9jbGstYWdpbGV4NS5jDQo+IGluZGV4IDkyYjkxYTlkZmM4Li4zYTVhYzNhM2U4ZSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jbGsvYWx0ZXJhL2Nsay1hZ2lsZXg1LmMNCj4gKysrIGIvZHJpdmVy
cy9jbGsvYWx0ZXJhL2Nsay1hZ2lsZXg1LmMNCj4gQEAgLTczMyw3ICs3MzMsNyBAQCBzdGF0aWMg
aW50IHNvY2ZwZ2FfY2xrX29mX3RvX3BsYXQoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gICAgICAg
ICByZXR1cm4gMDsNCj4gIH0NCj4NCj4gLXN0YXRpYyBzdHJ1Y3QgY2xrX29wcyBzb2NmcGdhX2Ns
a19vcHMgPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMgc29jZnBnYV9jbGtfb3Bz
ID0gew0KPiAgICAgICAgIC5lbmFibGUgICAgICAgICA9IHNvY2ZwZ2FfY2xrX2VuYWJsZSwNCj4g
ICAgICAgICAuZ2V0X3JhdGUgICAgICAgPSBzb2NmcGdhX2Nsa19nZXRfcmF0ZSwNCj4gIH07DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hbHRlcmEvY2xrLWFycmlhMTAuYyBiL2RyaXZlcnMv
Y2xrL2FsdGVyYS9jbGstYXJyaWExMC5jDQo+IGluZGV4IDA4MWY4ZjJiN2FhLi5mYjQwOWQxMDk0
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvYWx0ZXJhL2Nsay1hcnJpYTEwLmMNCj4gKysr
IGIvZHJpdmVycy9jbGsvYWx0ZXJhL2Nsay1hcnJpYTEwLmMNCj4gQEAgLTE3MCw3ICsxNzAsNyBA
QCBzdGF0aWMgdWxvbmcgc29jZnBnYV9hMTBfY2xrX2dldF9yYXRlKHN0cnVjdCBjbGsgKmNsaykN
Cj4gICAgICAgICByZXR1cm4gcmF0ZTsNCj4gIH0NCj4NCj4gLXN0YXRpYyBzdHJ1Y3QgY2xrX29w
cyBzb2NmcGdhX2ExMF9jbGtfb3BzID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3Bz
IHNvY2ZwZ2FfYTEwX2Nsa19vcHMgPSB7DQo+ICAgICAgICAgLmVuYWJsZSAgICAgICAgID0gc29j
ZnBnYV9hMTBfY2xrX2VuYWJsZSwNCj4gICAgICAgICAuZGlzYWJsZSAgICAgICAgPSBzb2NmcGdh
X2ExMF9jbGtfZGlzYWJsZSwNCj4gICAgICAgICAuZ2V0X3JhdGUgICAgICAgPSBzb2NmcGdhX2Ex
MF9jbGtfZ2V0X3JhdGUsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hbHRlcmEvY2xrLW1l
bS1uNXguYyBiL2RyaXZlcnMvY2xrL2FsdGVyYS9jbGstbWVtLQ0KPiBuNXguYw0KPiBpbmRleCAx
NDllMzAxNmRkMy4uNTk1ZGFlYzlmN2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2FsdGVy
YS9jbGstbWVtLW41eC5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2FsdGVyYS9jbGstbWVtLW41eC5j
DQo+IEBAIC0xMTQsNyArMTE0LDcgQEAgc3RhdGljIGludCBzb2NmcGdhX21lbV9jbGtfb2ZfdG9f
cGxhdChzdHJ1Y3QgdWRldmljZQ0KPiAqZGV2KQ0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0K
Pg0KPiAtc3RhdGljIHN0cnVjdCBjbGtfb3BzIHNvY2ZwZ2FfbWVtX2Nsa19vcHMgPSB7DQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMgc29jZnBnYV9tZW1fY2xrX29wcyA9IHsNCj4gICAg
ICAgICAuZW5hYmxlICAgICAgICAgPSBzb2NmcGdhX21lbV9jbGtfZW5hYmxlDQo+ICB9Ow0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYWx0ZXJhL2Nsay1uNXguYyBiL2RyaXZlcnMvY2xr
L2FsdGVyYS9jbGstbjV4LmMgaW5kZXgNCj4gNmZkYzRlMTFiYWEuLjc0MmQzNjU5NjZlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9hbHRlcmEvY2xrLW41eC5jDQo+ICsrKyBiL2RyaXZlcnMv
Y2xrL2FsdGVyYS9jbGstbjV4LmMNCj4gQEAgLTU5Miw3ICs1OTIsNyBAQCBzdGF0aWMgaW50IHNv
Y2ZwZ2FfY2xrX29mX3RvX3BsYXQoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gICAgICAgICByZXR1
cm4gMDsNCj4gIH0NCj4NCj4gLXN0YXRpYyBzdHJ1Y3QgY2xrX29wcyBzb2NmcGdhX2Nsa19vcHMg
PSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMgc29jZnBnYV9jbGtfb3BzID0gew0K
PiAgICAgICAgIC5lbmFibGUgICAgICAgICA9IHNvY2ZwZ2FfY2xrX2VuYWJsZSwNCj4gICAgICAg
ICAuZGlzYWJsZSAgICAgICAgPSBzb2NmcGdhX2Nsa19kaXNhYmxlLA0KPiAgICAgICAgIC5nZXRf
cmF0ZSAgICAgICA9IHNvY2ZwZ2FfY2xrX2dldF9yYXRlLA0KPiAtLQ0KPiAyLjUzLjANCg0K
