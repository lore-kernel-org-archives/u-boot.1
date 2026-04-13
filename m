Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C661EBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6EE684206;
	Mon, 13 Apr 2026 11:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="H04D7mH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0585684206; Mon, 13 Apr 2026 11:52:23 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0618583F75
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJJlrjkAmTsLRMo+fgELnxxylspHCphNF3pUCS0BwegJMVVD8263NfKSPBbg4KKpciDY+EU1MQPDwYSPpIfILyqfxSR0J504eBiqWnfqL9M9Av0PxPlLTURcP4Bm/EUFhtS3s73lzzK02ksDDYdqXCXDBK2FKQxYA80rmSNodlf+2IYh1HEN2Wxu8eaLAz3v94oravWHgSs0xYtnNOFPnblc9NzluSVpBEFUM5fV7oErU4HEUDmiN4rGeJNmTebQJcxdl7412KK4Bp32PkUCKiEA9ucTR95522NI9aJq7cqzl0dytc32DKH7PdQEUAwOAA3R7vSQCWEX07r2ltzpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTj4yzWmVdmPUtbtHG1hynPSkJJLtqmEo3MKRR4VEzE=;
 b=dB3b6f8q0kd9IFy9dqknMhv6Oh46lo3QF9NqQu7JXyhkLyIcfk6JXYdgyWsYzqaqiyW80dM35ITHsSMiuAkKOwL+WA8w7Y3pjgY5Ib5euihO+mPnqTYNUj92Y2/oHofpehfLYwNwgWrQtflaEw3l9yQ5aX4xpdrTkOEyqFrRyfBrFXQBHfenu1tc4fDfaP1Quw0Y3X4iW2ANGUVnzlDvhn3mCaX7/ECQsInFlMTd9FSUaT+cJnuv8a/03AFQa57FzwU8p9xQ8V1Vy43vhRDGliOYDJPeMYGsDPuTilRdIlinA9VEjMF3kEfPfjLsO9BygS0pMW17/KWEBLnwS4lOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTj4yzWmVdmPUtbtHG1hynPSkJJLtqmEo3MKRR4VEzE=;
 b=H04D7mH5lc1ANr3ZvM0jW/uTDw7sDJK9ec6DBHT7j3Z850Mi/+YoPce2gNJmJJxClTO39Js0ZMQxNfWxcLgsFlz6szq7J4R+flqNiblkxCxrseUQ0oRiXOCJh49O4yLq1rE8M1Hks1Xwl0hFwXf6tr24Ek9e7ZcmE2/At5HGOg0y+67Zmi2BttKx99Qae3LI8leNdCVHWQgsgRV2yoZkeikutspG0mIHxZ7wU+Wen+ndjaXAy/WhYm4otfewXOU9H1VkRTsMh7ksF6YdBf95VWsDjIdqA9Y3SJiDOEq1DCtht7HTfp+6qeXDIz/UaI1zC7kpyB3y8txgKur2Sbrl7Q==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB7820.namprd03.prod.outlook.com (2603:10b6:303:270::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:52:16 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 09:52:16 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, Michal
 Simek <michal.simek@amd.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, Teik Heng Chong
 <teik.heng.chong@intel.com>
Subject: Re: [PATCH] drivers: fpga: arria10: Clean up dead code
Thread-Topic: [PATCH] drivers: fpga: arria10: Clean up dead code
Thread-Index: AQHcphFA3hWWfcESL0my153a1spyh7XdCMyx
Date: Mon, 13 Apr 2026 09:52:15 +0000
Message-ID: <LV8PR03MB813790629F927F0CC7F17BD0A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260225044257.31225-1-dinesh.maniyam@altera.com>
In-Reply-To: <20260225044257.31225-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CO1PR03MB7820:EE_
x-ms-office365-filtering-correlation-id: 73c9946a-be75-4343-ff97-08de99425839
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info: uKZXPD9seKkqUrA3E8P2s+1NYFPaUco487cLh17bUp8RAZ1msIHKA0sCytd/ASA/jLrsCTpFhQY1/XhOu1Ny6fDYy34DsIZMT6Iec9AD7yvMYlW3dTJOB0p+Z6KwWX+z+CsRdgemJBQPqtbqXiTXYmEn5QeZJP2evaxNKPK9O4a0KWw7HhnRG67csoi6DisXQc6eZJaTTVhI6XgPIwSnJzBY4b0rLCFzppSWD1YM0Hon0FjqreMIs/GWd/DQmfXGgR7G8trmLADandRtcMhSdu+RA7SYmvBorUQPGIpb+qqunOLrah7XOoZefJBfpUdeExuPX9PPHt8HnY4gd1BstodUJnXxgVvkkiy3qdj0QKzYSNDkH7etssEvs2sY+JWowgeOTD+SaKzD0qfbz3OBZQGyMWr0b4m4h5vHXPZrWNzwWn9T2JvfqVYGVn7mtV4gNO3juEs8hA+m2n3HXdhXNgc0/VGqjofb05biuIcUHeuBjsQtqZNcNV3TLcS3aNv0FORwpCANHGlZnnh7QBMOVccpABfcps6ldi0SVPzMwPZy1JmUXjo6kBH4us53TCCvHxmIRdMnjJG9drr+CLjIzY7e1GaxTN6bpXue8hDmtgz360G9aPJQM4w/J1h4nNdvSK4bsshR25dREp4OVReQbYYJB4hXHLTro24dJLf6q1PhxjXZxcFpxmCsbA917qR0CZ5gTZEsRo5QfxuylD8BG9sr2QsFRUIoJHqt4cC6G3q2P3g8WUijsfC6Q5OEO/9q+q9EO2WKVYr5Rdf9rOPH5GwO/dn7eHO+QEmqS8fa0BQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?nzCsqwxL1u/Eb6UKJxVv8uGuwoyztfWHq7geI067kC5qkko8fPz9dZmr?=
 =?Windows-1252?Q?nzTz5E+KphM0g9wm1MGUVY8so24RvRE9eVRFsTdgod1Z0kQZivOn7wqB?=
 =?Windows-1252?Q?ehbGw1JzsX4l+lwkednTinmflwx7p20EuxpmMnj9P0pofVSQYiTbya1/?=
 =?Windows-1252?Q?rvKZlxu3hFQG9Z+VayVoqgs9S05NHrLi3KUMAp+etp23XvYoGzaOfWNP?=
 =?Windows-1252?Q?hQ1clzt4vIr1CFrOzejXxF976trUw3dVnrgaaSDFKsLy20BoMpjmg/zs?=
 =?Windows-1252?Q?UqyFpqqNdbZhS4bHxtucfH2ka+lRUjgI4CB+gvgJuU6XtHwv1Ui5L2f6?=
 =?Windows-1252?Q?XABOkONRp6cQRzozRflctv0EePFgxT4dZypKsLJMonsL00csNzo66f0s?=
 =?Windows-1252?Q?GaBDaTBQ41wQcxJGPaIIAjCKHbeAI5rA8jmCAy1nCEWWo+jizgfaeHYP?=
 =?Windows-1252?Q?qBtXVYhKYYb/XfcUsne+5A0jIUXnmRCz8gh43iIvXn/X/YzR49wCi+P2?=
 =?Windows-1252?Q?7vhsmPMfP/OiyRWv/1Nml2Z75SdAhida7yRxcLNAe4gTCMa6Ou0jHdMd?=
 =?Windows-1252?Q?x+y9tH2Rf401iA7ioXmbmolJaBJxzuRzuZgvl9w+tZ32fdS38yGLpUjC?=
 =?Windows-1252?Q?bVOeKIg37C3JOrnvLPVV33K00MV6K2DzM2ucDgaJSg5/CZ2sVSMppyaK?=
 =?Windows-1252?Q?adX/RSGXLGmfA0N1vjq952sGPOeAOQPCImt0tw6Fk36X68xVxbB6Mnmh?=
 =?Windows-1252?Q?gNMAWlnD1aDqP1eOB0bF3pQ+EmJBmav0DTBaRwetXB1im0ov2SzvOx6+?=
 =?Windows-1252?Q?wBcm4c/+yBxBnuZOQD8wzcr0FOk1CUv07HpKELzVACAfZ+yZe42xRWsE?=
 =?Windows-1252?Q?0abqkz8xKbD0Xjd47DCmTbLz+FJS+au0DOABtyuG/xk5AVs+NnOyE25S?=
 =?Windows-1252?Q?lvAu3vCLUtDJB0rpsVi6z+60VS97CmOmrAJozsdcHT23c2/6bAXDKdtd?=
 =?Windows-1252?Q?GzVsaVMM2f2BGP/yQ1KV1qjCoGfNnfMDXdZ+rBuT3q1P7Tlje5Rnc9Ra?=
 =?Windows-1252?Q?1/omnJtR7OPdxzVaDr0wNfhiasRIunSUFw9SAPEu6eun9KE32KWwXu0P?=
 =?Windows-1252?Q?WuELlWT/iPVOMga9cIaKaISpzbO1pxdddGeACgT9gG+DANLMWnAG4lQl?=
 =?Windows-1252?Q?ktr8yIdCh+D0viMfiUFmIgryZnmBtNQipuc7hhHvXmyfyBpJq3hSH4Vf?=
 =?Windows-1252?Q?AzpegoaP0hgOnY8yYA5FuuTuPvSk3v+YZuYQnOTC7fSLKAB2zDGc80sk?=
 =?Windows-1252?Q?JpnpQFFh0zOP0NMhJVmVE03wFmVMST7Su4xRcb5zRp1Bghgjx0KNoo3a?=
 =?Windows-1252?Q?sjFQPA7ueMQGBe/E5YT/eip9G5vezXojOeFi1DtSYiPkQas29dbhdofi?=
 =?Windows-1252?Q?EFOfLzfjOnwLUmaOz/OeZmgSpZDfp3tfgxG2ksCxI63hAlTs96Balg+K?=
 =?Windows-1252?Q?w49GOs1CrRPMQMTpeBRRnGpiDIui+gLQxklXJBXqqNq2hdw1cWE4q5vT?=
 =?Windows-1252?Q?z7I2Hd9kAsIHdOZwpUHg7FjnPkbDVPmNTE6g/nAAgfj3s0Y8M8QgFfM/?=
 =?Windows-1252?Q?6NbuGsdjqm6NGaVGHAU+GGjYWkCXoX7SDG23vywE5ag4tAIAlr6vF5/1?=
 =?Windows-1252?Q?U2cPE19gFmnf/ukX3JuTc5ThaWuXP2PlhGlI4xX9zHG49TUrNqtmqiqg?=
 =?Windows-1252?Q?iPHdLDcslfuPU1SRz4NAhyhsGfqvcOa0jsVWBRkh80EAxifFqazj7F2m?=
 =?Windows-1252?Q?rzGO4bxPywA0teI+WVazGWyua54/xQnMLApqKmY8F4LHowvF1qOg7YXN?=
 =?Windows-1252?Q?PUwBOXXzY3ORVA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c9946a-be75-4343-ff97-08de99425839
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 09:52:16.0083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdoHqHOvj1NlUVdWgCafZxhKtZ5y+eBIf6OlpSVOa4gaA5msqu6ifaTnjF1wJYZ74i7FRgZGJ02339ya4wNmI1Da3xUnsKH5m6+nyThubBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7820
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

Hi Dinesh,=0A=
=0A=
> From:=A0Maniyam, Dinesh <dinesh.maniyam@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 12:42 PM=0A=
> To:=A0u-boot@lists.denx.de <u-boot@lists.denx.de>=0A=
> Cc:=A0Marek Vasut <marex@denx.de>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Michal =
Simek=0A=
> <michal.simek@amd.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Hea,=
 Kok=0A=
> Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh <dinesh.maniyam@altera.=
com>;=0A=
> Ng, Boon Khai <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan=0A=
> <alif.zakuan.yuslaimi@altera.com>; Teik Heng Chong <teik.heng.chong@intel=
.com>=0A=
> Subject:=A0[PATCH] drivers: fpga: arria10: Clean up dead code=0A=
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>=0A=
> Remove the dead schedule() code.=0A=
=0A=
Please improve the commit message:=0A=
 =93Remove the dead schedule() code.=94 is accurate but could be improved:=
=0A=
Mention it is unreachable after break.=0A=
Optionally mention no functional change.=0A=
=0A=
Best regards,=0A=
Tien Fong=
