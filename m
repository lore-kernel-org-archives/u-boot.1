Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC86BCD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D73F846BD;
	Fri, 22 May 2026 08:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=telechips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mytelechips.onmicrosoft.com header.i=@mytelechips.onmicrosoft.com header.b="KRm2XAQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED49B846CF; Fri, 22 May 2026 08:19:57 +0200 (CEST)
Received: from SLXP216CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7E48460E
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=telechips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mw.park@telechips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHafgK+Wv5PGErJSoMuCMHty+ZnOXXkn1XjufWt1sI2pKcDi2Qv/RUkQupPky5K62Hi+f8czuLcIRMBgaGzMuNvEOIpiHHmAS3nBR3XkxXeaMv5ue7aF3+hs2NEEsHHcHVlVVnQJFOGo+5GpvnibDefsqOdu82Bw5h080fB/4+bJyJyq5Mh7MsaWnGXiagDDmNN6ATLkSqsIUDDd54/WDfMBUGxlmpmA6Xk99lObxAirSEfRvVfpT6DoUyn6/V5DWi9A1rtqQ3nBWJ/sW9ndoOxCUGwcBcqMCpUbdkf6gUFRL82aG6VjVo+xfSwqdfGDlOaUx7yl++f4wTsQo5sjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fydt9kz+qJgytwKWo5IFuMsflYxP/1jPa4q6fAF+1c=;
 b=i2/SPNoEKADUvDyr9cw2P833yHai2B2/kw2T6hWFapMVPNN1nG17iSoUAxG9qKK+5Kz9sEdF7qfEfh/8F4fYG3g+x4u8bBglImDCsFEeQO3K2c10V+YmsQ4W5BVZdtHMVrgBRU8gfag7fidR6lrA+aJDB17OwivToOnnjOsUTcshMkTSC6xGyeynPyMcVvN9uiALOBRrMPoptYeLZa4suQ5z22jDj231gwAbO3gjq1m6nZvUOnFOtAejCC84RmkeVmK+aw5uktduaCNus4J+hYqK2F0lReIZvMsEO20ibhGhXpYsC5cFZJKcygho6MmRNmhT1v2ApUbN39+ik7xZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=telechips.com; dmarc=pass action=none
 header.from=telechips.com; dkim=pass header.d=telechips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mytelechips.onmicrosoft.com; s=selector2-mytelechips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fydt9kz+qJgytwKWo5IFuMsflYxP/1jPa4q6fAF+1c=;
 b=KRm2XAQYQlD+yCiF8iJy4caiS2eb/SuFMcdmiRScpR21QwF7f/51q0kMFmtJUZyYSUF2rduSFte6BXkVHmDFK0e0gC8R+Un3XBgvIoqCC2oYHXVRrSOSVCrIqupxlXWQpodhgkBW9LbwJXME1X8eGWyfC/eg+gNmliw4zSQhaOY=
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PU4P216MB1896.KORP216.PROD.OUTLOOK.COM (2603:1096:301:108::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 06:19:47 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:19:47 +0000
From: =?ks_c_5601-1987?B?udq5zr/sIChNVyBQYXJrKQ==?= <mw.park@telechips.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: allow forward compatibility for EXT_CSD_REV
Thread-Topic: [PATCH] mmc: allow forward compatibility for EXT_CSD_REV
Thread-Index: AQHcvOJe6oDidGfESUyiWPsmGz0PR7XVbcuAgACXcA6AQ+bZNg==
Date: Fri, 22 May 2026 06:19:47 +0000
Message-ID: <SLXP216MB11485E82715D668D14B40475F00F2@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
References: <SLXP216MB114822C04834C4F0A78869A6F056A@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
 <adaAlRvDAKs8mRWB@nxa18884-linux.ap.freescale.net>
 <SLXP216MB11482E8AAE8824D18A5BB303F0582@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SLXP216MB11482E8AAE8824D18A5BB303F0582@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Enabled=True;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SiteId=9ec49ece-9398-4634-9468-0ca88a890702;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SetDate=2026-05-22T06:19:46.985Z;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Name=General;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_ContentBits=1;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=telechips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB1148:EE_|PU4P216MB1896:EE_
x-ms-office365-filtering-correlation-id: f3737353-af36-433a-a308-08deb7ca1f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|4143699003|11063799006|22082099003|18002099003|56012099003|13003099007;
x-microsoft-antispam-message-info: EYJIjWf7b2wFbs9UEV8iNnUIMg8ze9kCK27oxe7J+nTYNNwRy2Qlb3jnf997GJ3sDX3pPGXwWQL9rF1/fInfYHc2tF1faVPv1o6P3CTYvv4/rE2t/hykHKDDoZzzHhmP1mBU63cGKLApDXn5NgFAn9Yc1AcBQH++nr/EX2AE7+gLBHi3pZyEO7KJ8UmRk6mHvu/xew+4kr/GHEXC83EelCYIaAmLLLz/rqSK+5/B8D9KnRMUrC4e9tYoaXNt4cqSq+QLcLocLH2mOgIEHOZEl0FXjARKQ3k38woSU275sQ2pSsGPdoHh3LNOZSVw4nLgtGrNpOXiXZFmeuEwW0ycVz4C9IjHBhLwy28rK+4OsrtzOXDMx4j710BsYbnCZDxzd8EL9sfzdEylKXhw2sbUREKa0R6gn2wzSJamUysSdLFo7AJqO88Wkm973kwlH4N0coK+tBhNMJlrvs4kTT+LTgqGSX4Y0B+DnV0Xhu8PUmhg1vA9im0HuWNtApnd0TN+lEMvJSJIfhm3binGvoO6DuV1ltjIXSMljqJkXtkDAhPzgLSC6v2s+pRoGMfpe5C2oajn1IO4AiiPp3SEzJF2E3D629vRwzg9i/tH2MnQhEz33zwx7AIBla0Yd8eQojvBzyFnAui3TD7yGNgK5r2l+p98GMxvUfvleSiiNJTEt96sju2ShRE8KJx27WxW8GdsC7UY7/r9T2gNxBK2Qfm5bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ko; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?ks_c_5601-1987?B?Uy80WU8vUHBZckJHeDZzUGFWakFRUnRXRytkM2cyZkExcHV1RXly?=
 =?ks_c_5601-1987?B?YzhXYVpKN0E4NmlVQnR1Y2phOU1EL2Y0aVVzdUJBSlhiclJEcXdQ?=
 =?ks_c_5601-1987?B?aXFQRmdra3Q5dFVPamJENTk5aWNxSXFpQVdPRk9DWUZYeVpyMVFZ?=
 =?ks_c_5601-1987?B?U0V5L1J5S3FvSUFVS3hybUdQNFBFQWNzTWkwVDdkQUhnUXh3aUxM?=
 =?ks_c_5601-1987?B?Z2JjUzRPTVRKMWY5S1dXemRYQkI3QUQ2OE5NSVNxQXVhUHJMWjZL?=
 =?ks_c_5601-1987?B?L1dvMjFySlBJMXVlWUJqTEQwNmRZZnFFV1haS1k4bVlqbXk4RDFY?=
 =?ks_c_5601-1987?B?V0gzWjV1ZmlIbU5CUTlGa3JFaENqNDZkNFhDc2g3UFZSMnlTditR?=
 =?ks_c_5601-1987?B?ZGY1SmNvelN6Y2Ewb3VPcEpMUTdocktFME5STTlxenZsVmJlNmhY?=
 =?ks_c_5601-1987?B?eCs4dHVoVmRuN2VxeWU0YmlqVS9tZys3a3hNOVE4TmZVOTRNakdX?=
 =?ks_c_5601-1987?B?SmJ4WnRvYzMvUEMzK2d4Yk82U051azdWS3dQajVMQ0VmaFc5ejh0?=
 =?ks_c_5601-1987?B?K2JhYW9QcGYydHNQbUtjRERPYVFGWXovWjlxZmhETmVXUVdGTk9C?=
 =?ks_c_5601-1987?B?aDhMLytoLzFMTEZ2RCtLY3FLNUFkMWhDbXpkL2xIUkxhcWVNeEFy?=
 =?ks_c_5601-1987?B?NmUyVExpTXRzZjZqN0QxVXNycmZITHNrTDYyQUc3UjZVMWR6YmNO?=
 =?ks_c_5601-1987?B?MDdzdlVXOHlRUFlGeEJiajE0S05TdDFYQ1BYbVlDVkhJaS9HV3d5?=
 =?ks_c_5601-1987?B?SkRaU2R0ZkNLNTlMOWFCZTBNK3c5L1N3UlNPR0NOOGNsdEFXYlg3?=
 =?ks_c_5601-1987?B?TjNnQ1AwcVc0VXpsZ2k5d0d1UVQrWGczeW4zNFJHNEFyNUdrWXZO?=
 =?ks_c_5601-1987?B?RHBvbVltaVp6WlRNV1h1OWNxcjR3MVkyaFVzaENHWldUVndnSWhU?=
 =?ks_c_5601-1987?B?N1J3bklXKzcva3FsT25qMkl6bVBtZjFYbnBwZFNPVHJ6SmxxRzZz?=
 =?ks_c_5601-1987?B?RlNlWDBybDd3WWlJUCsrWWRFWjV6d3NmaGIxSFlsYXBidW1Rc2hP?=
 =?ks_c_5601-1987?B?Tm9mY2dpVWdORnFydWhtSlFzbml6RGk5VWpuQXZxZWJNT2luNVdK?=
 =?ks_c_5601-1987?B?V1dzbTJtdno5QVoweU51M3p2eEdxT2Z3bFlsYll2OUZybklUTXFN?=
 =?ks_c_5601-1987?B?a1F5TU14OXBiRWVFUUJERlVyZnVhLzJtbDdHWjFXMXF2YkFVZk9P?=
 =?ks_c_5601-1987?B?NU5kNXBsc3p2N0EyUGNiUUh1bzNXZVZ6bVcvcUgvWDZrNk42dkJ5?=
 =?ks_c_5601-1987?B?SjdpYVlaRGhHTHBPS1lNTmtndm00MDRhUHBoOURaTWJUajY1WVZv?=
 =?ks_c_5601-1987?B?OXZhOE9XelpHUTEvS0M0NUtUblRuenpzblMwWVlIT0dScElQVUx6?=
 =?ks_c_5601-1987?B?MW1vdFRCTmlkNTZ6Yml1WXB4cXhvenVaY2xjN2lZTXlNKy9pQU9F?=
 =?ks_c_5601-1987?B?RzFTdmlSV09XT0RVa1ZBTVhDdFVYakRvN00wRnpKVDU3Q3RXVG82?=
 =?ks_c_5601-1987?B?a2VLZ2hJZGJsbVlDbjRZTlpLQ0VxZTV3RWRPTXliekJYc0x3Zndw?=
 =?ks_c_5601-1987?B?a1R4ckhpYVA2a2ZnQ0MvNmNJai8vZWRKQThCdnV0cW5nTXd3aGpN?=
 =?ks_c_5601-1987?B?QmxuRlozMEx4WlhCR0pKZFpxcXpwYVgreS9jYS94QUsxbEVlTlA4?=
 =?ks_c_5601-1987?B?bk1CRStjNWthS1Jqa0U2WGJTaGZaZVRRUDlZbHg0WDdOb09zWW80?=
 =?ks_c_5601-1987?B?M3VkejZDREtWcERFNWdoNk1MSEt0cXlTK2FYdjdjc2hOd0xTMTNy?=
 =?ks_c_5601-1987?B?Q2xjSEFUK0N0MTJsUTlhUzIxcDB6TmgvbVFRdS9UZ3RKTmZaNUFK?=
 =?ks_c_5601-1987?B?SHpXdDd2K0pDY0lTNUhENkhyakxoaFhwK2JIaE9XU3dTVFhLU3Fr?=
 =?ks_c_5601-1987?B?Z1ViNkNpSUJsZC9CNlhoVVI1TVZrblJWNXd4RjFOYUFtczFhQTIv?=
 =?ks_c_5601-1987?B?T3h0L0JZSXhHeFlPNkhXUWUzSUo4Q1c3VnVBNkNHRnZjZ2Z5UlFC?=
 =?ks_c_5601-1987?B?M1dVb1pJamFrejJTVCt5WlU1TDRYODA0Q1Qxc2t2MGhMWXpGTjhF?=
 =?ks_c_5601-1987?B?RVkweWlkbzJla21xc0pjWlRzdzVpakR5cFdOZXJISjNCbVlqRXFm?=
 =?ks_c_5601-1987?B?QURYSmRmTG1xdXZEdUcxUHhvUHhoM0M2MFZSME5iWmZDaWY2ajVy?=
 =?ks_c_5601-1987?B?cVRQQ0Y5M0k0NG5uRTdLalp2Rk1FWHRsZWV2SzRMSmg0RzN4dVgr?=
 =?ks_c_5601-1987?B?cXJRWWxUWm1CMFdUb0pqZ2gxSWphUVJiQzFoRUxMWkNJcFMvZTBz?=
 =?ks_c_5601-1987?B?WlJUT3ZIam9kTHZkQm5PTER0dll1eWpvdnBLc2FvNWtvSCtvMFYy?=
 =?ks_c_5601-1987?B?WXBLMzk1S0VMV0xZczZBKzQ4WlRPZUo2RWcxNnUwNkdLOUtMNXZ0?=
 =?ks_c_5601-1987?B?YlhjdnhLVGNwdFMxcm9pN3pkVWo2L0Mxa01YQzl0ZE1LUE4velRO?=
 =?ks_c_5601-1987?Q?fGo2W2uZ35LV?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: telechips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f3737353-af36-433a-a308-08deb7ca1f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:19:47.3679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9ec49ece-9398-4634-9468-0ca88a890702
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tv4jdgZ0H2v4zuMzb5j8LnM6w53+gXjTAM8UKgR1jtpBD/Bw0nU9sVWscL56IUOgI76uzEjKYOGAnrjkfqvl7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1896
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

SGksDQoNCkkganVzdCB3YW50ZWQgdG8gZ2VudGx5IGZvbGxvdyB1cCBvbiB0aGlzIHBhdGNoLg0K
Q291bGQgeW91IHBsZWFzZSB0YWtlIGFub3RoZXIgbG9vayB3aGVuIHlvdSBoYXZlIHRpbWU/DQoN
ClRoYW5rcywNCkJlc3QgUmVnYXJkcywNCk1XIFBhcmsuDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCrq4s70gu+e29zogudq5zr/sIChNVyBQYXJrKSA8bXcucGFy
a0B0ZWxlY2hpcHMuY29tPg0KurizvSCzr8KlOiAyMDI2s+IgNL/5IDnAzyC48b/kwM8gv8DA/CAx
MDoyMw0Kud60wiC757b3OiBQZW5nIEZhbg0KwvzBtjogdS1ib290QGxpc3RzLmRlbnguZGU7IHBl
bmcuZmFuQG54cC5jb207IGpoODAuY2h1bmdAc2Ftc3VuZy5jb20NCsGmuPE6IFJlOiBbUEFUQ0hd
IG1tYzogYWxsb3cgZm9yd2FyZCBjb21wYXRpYmlsaXR5IGZvciBFWFRfQ1NEX1JFVg0KDQoNCj5X
b3VsZCB0aGlzIHBhdGNoIHdvcmtzIGZvciB5b3U/DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
dS1ib290LzIwMjYwMjI1MjExMzMyLjE4OTYyNTItMS1oYW4ueHVAbnhwLmNvbS8NCg0KPlJlZ2Fy
ZHMsDQo+UGVuZw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suDQoNCkkgd291bGQgbGlr
ZSB0byBjbGFyaWZ5IHRoYXQgSSBpbmRlcGVuZGVudGx5IGRldmVsb3BlZCBhbmQgdmVyaWZpZWQg
YSBzaW1pbGFyIGFwcHJvYWNoIHRvIHRoZSBvbmUgaW4gdGhlIGxpbmtlZCBwYXRjaC4gSG93ZXZl
ciwgbXkgYW5hbHlzaXMgc2hvd3MgdGhhdCB0aGUgbGlua2VkIHBhdGNoIGlzIHByaW1hcmlseSBm
b2N1c2VkIG9uIHY1LjFCLCB3aGljaCBtYXkgbGVhZCB0byBjb21wYXRpYmlsaXR5IGlzc3VlcyB3
aXRoIGZ1dHVyZSBlTU1DIHZlcnNpb25zLg0KDQpJIGJlbGlldmUgbXkgcHJvcG9zZWQgcGF0Y2gg
cHJvdmlkZXMgYSBtb3JlIGdlbmVyYWxpemVkIGFuZCBmdXR1cmUtcHJvb2Ygc29sdXRpb24sIGVu
c3VyaW5nIGxvbmctdGVybSBtYWludGVuYW5jZSBhbmQgc3RhYmlsaXR5IHJlZ2FyZGxlc3Mgb2Yg
dmVyc2lvbiB1cGRhdGVzLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0
aGlzIGFwcHJvYWNoLg0KDQpUaGFua3MsDQpCZXN0IFJlZ2FyZHMsDQpNVyBQYXJrLg0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq6uLO9ILvntvc6IFBlbmcgRmFu
IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCrq4s70gs6/CpTogMjAyNrPiIDS/+SA5wM8guPG/5MDP
IL/AwPwgMToyMQ0Kud60wiC757b3OiC52rnOv+wgKE1XIFBhcmspDQrC/MG2OiB1LWJvb3RAbGlz
dHMuZGVueC5kZTsgcGVuZy5mYW5AbnhwLmNvbTsgamg4MC5jaHVuZ0BzYW1zdW5nLmNvbQ0Kwaa4
8TogUmU6IFtQQVRDSF0gbW1jOiBhbGxvdyBmb3J3YXJkIGNvbXBhdGliaWxpdHkgZm9yIEVYVF9D
U0RfUkVWDQoNCkNBVVRJT046IFRoaXMgZW1haWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIFRF
TEVDSElQUy4gUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UgcmVjb2duaXplIHRoZSBzb3VyY2Ugb2YgdGhpcyBlbWFpbCBhbmQga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KDQpPbiBUaHUsIE1hciAyNiwgMjAyNiBhdCAwNTo1NTozMkFNICsw
MDAwLCA/Pz8/Pz8gKE1XIFBhcmspIHdyb3RlOg0KPkFjY29yZGluZyB0byB0aGUgSkVERUMgU3Rh
bmRhcmQsIHRoZSBFWFRfQ1NEIGZvcm1hdCBpcyBtZWFudCB0byBiZQ0KPmZvcndhcmQgY29tcGF0
aWJsZS4gQXMgbG9uZyBhcyBDU0RfU1RSVUNUVVJFIGRvZXMgbm90IGNoYW5nZSwgYWxsDQo+dmFs
dWVzIGZvciBFWFRfQ1NEX1JFViBhcmUgYXV0aG9yaXplZC4NCj4NCj5DdXJyZW50bHksIGlmIGFu
IGVNTUMgZGV2aWNlIHdpdGggYSBuZXdlciBFWFRfQ1NEX1JFViAoZS5nLiwgZU1NQyA1LjFCDQo+
d2l0aCBFWFRfQ1NEX1JFVj05KSBpcyB1c2VkLCBVLUJvb3QgZmFpbHMgdG8gaW5pdGlhbGl6ZSBp
dCBhbmQgcmV0dXJucw0KPi1FSU5WQUwgYmVjYXVzZSB0aGUgcmV2aXNpb24gaXMgbGFyZ2VyIHRo
YW4gdGhlIG1tY192ZXJzaW9ucyBhcnJheSBzaXplLg0KPg0KPkZpeCB0aGlzIGJ5IGZhbGxpbmcg
YmFjayB0byB0aGUgbGF0ZXN0IHN1cHBvcnRlZCB2ZXJzaW9uIGlmIHRoZQ0KPkVYVF9DU0RfUkVW
IGV4Y2VlZHMgdGhlIGtub3duIHZlcnNpb25zLiBUaGlzIGVuc3VyZXMgZm9yd2FyZA0KPmNvbXBh
dGliaWxpdHkgd2l0aCBmdXR1cmUgZU1NQyBzcGVjaWZpY2F0aW9ucy4NCj4NCj5TaWduZWQtb2Zm
LWJ5OiBNVyBQYXJrIDxtdy5wYXJrQHRlbGVjaGlwcy5jb20+DQoNCldvdWxkIHRoaXMgcGF0Y2gg
d29ya3MgZm9yIHlvdT8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3UtYm9vdC8yMDI2MDIyNTIx
MTMzMi4xODk2MjUyLTEtaGFuLnh1QG54cC5jb20vDQoNClJlZ2FyZHMsDQpQZW5nDQpUaGlzIGVt
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgdG8gaXQgbWF5IGJlIGNvbmZpZGVudGlhbCBhbmQgYXJl
IGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCB0byB3aG9tIGl0
IGlzIGFkZHJlc3NlZC4gQW55IHZpZXdzIG9yIG9waW5pb25zIGV4cHJlc3NlZCBhcmUgc29sZWx5
IHRob3NlIG9mIHRoZSBhdXRob3IgYW5kIGRvIG5vdCBuZWNlc3NhcmlseSByZXByZXNlbnQgdGhv
c2Ugb2YgVGVsZWNoaXBzIEluYy4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCBvZiB0aGlzIGVtYWlsLCB5b3UgbXVzdCBuZWl0aGVyIHRha2UgYW55IGFjdGlvbiBiYXNlZCB1
cG9uIGl0cyBjb250ZW50cyBub3IgY29weSBvciBzaG93IGl0IHRvIGFueW9uZS4gUGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGVtYWlsIGlmIHlvdSBoYXZlIHJlY2VpdmVk
IHRoaXMgZW1haWwgYnkgbWlzdGFrZSBhbmQgZGVsZXRlIHRoaXMgZW1haWwgZnJvbSB5b3VyIHN5
c3RlbS4gUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhp
cyBlbWFpbC4NCg==
