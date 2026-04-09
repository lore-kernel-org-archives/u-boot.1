Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00E810FC463
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 01:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F290E83CF5;
	Thu,  9 Apr 2026 03:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=telechips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mytelechips.onmicrosoft.com header.i=@mytelechips.onmicrosoft.com header.b="nOlBEgn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852E083D8A; Thu,  9 Apr 2026 03:24:02 +0200 (CEST)
Received: from SE2P216CU007.outbound.protection.outlook.com
 (mail-koreacentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B60583693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 03:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=telechips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mw.park@telechips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5kFpDwQbGXQrF3aevF9ZXklde7QexPJs/iCUw/MS3/cw0Q+3cTVS/e2GaKwMFcviRLPcpAUFiyeTY3QxD8/Q2ZsXh8Q2iOE5Zx9s0TWv8RVI+oAb5I5WK9wE+atITLt1C4dCuSfXt+Z5S0/AZPjs+RFgiJzbGKqYbFS/IYMhg2uFQLWlIbxyQKiTU2/ifYsgeRRMk+wznMuR4TE8qTvI2n+xETMK+KU5yTSReZL2089g9ZpVVFfcLQ7kTXijdbT0g+kQ8fWMfoR4ZW1trAAw6RExTiVC61DPJcEIoILkqc0xXnDT4job/gEA09FP+XbZ1VFxYS1P/BUjGJrLfbBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/qknywmTtDYFEQxRN3larVKG2FfxUGxm40phGpPPzw=;
 b=Ephz9fRpmOpo6IvraV+p327ZeRH2umFd0Niitc8jQ4wgh3c1JHcqG5a+B8uqcmgbgo8RLwGozxKXlr/oBeIiqcX1m989Rbt2vEmzbgBnAhmP9haWAPsclw0yKfyDJlIO0N855CkPE3CadGyJ4Ah9Y/3vdNZDF3LPXdAbClI9eTVhne69WlrDC80bwnpHUYwBVtBsHs6oxJyXko/JOwTil5p97O4sInC3N4fdxt7Mu6NPFbJIBK9Yuy4xYZccMYQ8g+I6Q/5e01VwsmhLoHk5ql6sjudO1y2VVj+NzS9mArAZ8dAMH9vRlTaSopgKDpKuSPtfoZpL39NO6y8lp0pelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=telechips.com; dmarc=pass action=none
 header.from=telechips.com; dkim=pass header.d=telechips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mytelechips.onmicrosoft.com; s=selector2-mytelechips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/qknywmTtDYFEQxRN3larVKG2FfxUGxm40phGpPPzw=;
 b=nOlBEgn3C3qdYXupKBOR6O4AO71EXp6AFSSkYV9sbNSGLnKrQwGtRHgecpcyDIeXBwRHq+WvvJCSyI6NT4kCWah6O9GoNLgS0qUpBqGwC47gFN4madzTLjHk6HTMms6X+KrPK5xxoVpDSTDjsBC5H6NsZI/5+XGUeDFZcAwDyyE=
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 SE2P216MB1473.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.21; Thu, 9 Apr 2026 01:23:55 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 01:23:55 +0000
From: =?ks_c_5601-1987?B?udq5zr/sIChNVyBQYXJrKQ==?= <mw.park@telechips.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: allow forward compatibility for EXT_CSD_REV
Thread-Topic: [PATCH] mmc: allow forward compatibility for EXT_CSD_REV
Thread-Index: AQHcvOJe6oDidGfESUyiWPsmGz0PR7XVbcuAgACXcA4=
Date: Thu, 9 Apr 2026 01:23:55 +0000
Message-ID: <SLXP216MB11482E8AAE8824D18A5BB303F0582@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
References: <SLXP216MB114822C04834C4F0A78869A6F056A@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
 <adaAlRvDAKs8mRWB@nxa18884-linux.ap.freescale.net>
In-Reply-To: <adaAlRvDAKs8mRWB@nxa18884-linux.ap.freescale.net>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Enabled=True;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SiteId=9ec49ece-9398-4634-9468-0ca88a890702;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SetDate=2026-04-09T01:23:54.844Z;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Name=General;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_ContentBits=1;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=telechips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB1148:EE_|SE2P216MB1473:EE_
x-ms-office365-filtering-correlation-id: c9b3cf7e-cf2a-44fc-643d-08de95d6aaab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|13003099007|56012099003|22082099003;
x-microsoft-antispam-message-info: 4oeeXLNOrrANv8wwbqw9IBwK3zzS515/15RLZ4EPpENP7fUvoA/SrF9ZT5RlCGZpyAwmPBOlT03tWxquWjg3KwBvrcTwzcYe16VPNqZew4dOZ6XxjHeiWbuEJjWh1bI3U2leXkQH8ifYyfgJHdVJFWGUOeQF8tVg1fLy+nebWYDKFNeROi9PztxryJ9dtvAq3/L5euw0LTiE1b/h5SQjxgc6ZISPW2D66tzR2m19lDtD6L+lmzyzcMTeT4gd3KtHCXWdhqPnTUSNH0clhdb97/UGSESIMwPCqWu6q86Xvci61qHDqHQ86HuOPoXUl0qkOBe7gj+DYFc65caiHzKJyEbFEwQ+543qFI9gu2bmc76E2aOArbOZ5IFJU/qoFcGkYwlbZO6qq/pCO/mkuiPwmuWLp5sQ7A66oCA55WGFn5x6HhCbQPMumyaXLfVPHNlp8sK0Y1xUKyaSsHNzpfg3r4DkimUytl24/x+vJ1aVFz724FCFe7FLekuHwQWEiDFYexBdcB1QkwAWv/wsSKXPni3AcjNrVV1ljd52OUYP60mxA+FVz36siSuj29Xa+t0AOBvXqU9Vv2cbDtrBov7rRpCEnyt+GBctAZ8yH0aH+D7c0YYJMQu/uMpG15ZQm4R5a9VcxA40I6+/YbmPyYWT+QrUucO+84aFkukWtgSXlkjE3R1McHp0hNthaBNDfEJoZaX4017Zab8/beBb/7ZpkOlEwxO4GO/1eVWXDrPWnkjTZ5I7kgsZBtkze0MZld3pNVsTWCBU736QpVpxl9LaT4dBwGY75hpfL3FzS195zhE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ko; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(13003099007)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?ks_c_5601-1987?B?NHJnc3M0NTdaRis0bW91VGVzU1JKZDNMK09XMVI5bDJCL2JnZGtZ?=
 =?ks_c_5601-1987?B?ODNFcGxlUHZRSE9DajVGN0s1VFZ5alE1NDVJSyt5ZFFlQmFEMytB?=
 =?ks_c_5601-1987?B?WktiaW5HZ2E1ZWNlN2Z0bnpLMVo4Rzh2U0FlQmZQczAxeEIrZ3FQ?=
 =?ks_c_5601-1987?B?MnI3UVVoZnRTd0MrQWwzRWFaa1FCb05NTmFOTEkvdUFKT2xZSWZu?=
 =?ks_c_5601-1987?B?ZFd0V28yMU8ya2RjOHFQS25tVU9KcWdwTGpsbnd3UWt4YkFKM1hu?=
 =?ks_c_5601-1987?B?QmIxK3dIN2RHanhoYzFjQXUzMW9lUitVcnFHWmF6S2RBQ2ZscjUy?=
 =?ks_c_5601-1987?B?alBYK0RMSGFQRWgxZGM4MmJXbnFpRllxUzVHRTVkMFhDVWFUeVY2?=
 =?ks_c_5601-1987?B?ZkJQRG9NUWRTUlo2UHNLS0UwQlRiOXdEK09aSC80RTZwL3BDeWlE?=
 =?ks_c_5601-1987?B?MzFSbk9WTDB2Ukd6d1Y4cEViaWY1REZFVW9WQThuK2w2enBEZXYy?=
 =?ks_c_5601-1987?B?cFhYRGlmbzdvQWpQemRsTmtxYkhWY0dicENUQWM4bU9vRzhEQnBt?=
 =?ks_c_5601-1987?B?TTM3YnJBL1BKZWtTQUpyRFlHMW1HaU1jeUNISWVDUmVLTUZ5Ujdl?=
 =?ks_c_5601-1987?B?ZDBobVgwVVdpRGVmai9NaG9tb1d0cmNCM0xXV3dWNmMzVktCZXBo?=
 =?ks_c_5601-1987?B?QWY3L1M2a05JZ3J1SGtYOE1ldXpkOFdnUm1XTUROSXo3a1JmcGpw?=
 =?ks_c_5601-1987?B?Q3c2TTJtWG9nS0hlcmtvek9RcmhuR0hZQnNFRWNuWlF0RmhJZFFM?=
 =?ks_c_5601-1987?B?ek5UT1FnVk5zbjY4OFdIOGM4MU40UWNqTGhscnEvQzRuWmpLYjRL?=
 =?ks_c_5601-1987?B?RUNqdm9zeGVHelJ4aWJXd01CV2NTL0tPM2MrcVNNRlNqQnZKbE9y?=
 =?ks_c_5601-1987?B?Z09LdnIxOFh2cDNjUjJ5U04reGJWWTMzMFpGaUhoQllQc0d3VzBy?=
 =?ks_c_5601-1987?B?WklaZmc5dUM1cWFNWjFYQUF6dTFBUDYrU0tZNkZEbWtrWTdHU3Jl?=
 =?ks_c_5601-1987?B?ckVMdDBmYys4aUNwNDJlZTdZckVSam5MbVpJOW9LMlZZYkpSR04x?=
 =?ks_c_5601-1987?B?dlhlVVNBanliZXFhdjIvellkODFHaTJXd0hFeTRURngrczZKSkx0?=
 =?ks_c_5601-1987?B?ZDBMQm1Ibk1kcFlGQ1Vta3lNMXNtZzlQMC81U2d3U2Z1cFF5b0Zl?=
 =?ks_c_5601-1987?B?Ti91UGJOQnlOZHExSlNXQzN1MHZlK3Fld3ZJamdINU1Gdm1vWWtx?=
 =?ks_c_5601-1987?B?RlhmYytPSnpRZlZRTzdMVmJNSllpSDNhNUVrOE5BNDRwRjdRWk9l?=
 =?ks_c_5601-1987?B?Z2xxSEVaRHpoYklPK1VLY3hvdHFOTFVHQXFjWG9OT2h2RWJWK2dq?=
 =?ks_c_5601-1987?B?VmNjNGEzWm05Uk5JQzRQNm5YZ3ZmTWhkaW00dE9aUzU1MXRWL2Zn?=
 =?ks_c_5601-1987?B?WCtZV24yb0c0ZldrZkFoYnY4SWJRWXZ5YTc3TGNrQU0zYVhqWS9h?=
 =?ks_c_5601-1987?B?KzRTWG14NHBjTVhpZmtLQkYwMjA3bDZzQmdET2s3WTl3NUlia0hp?=
 =?ks_c_5601-1987?B?QVRlRzFlYjFjZWRtRzlZclRDc3VHc2dEckY5STRyamVBalI0a2pZ?=
 =?ks_c_5601-1987?B?K3R3QjBzWlJxYnQrZVRWNjdHMUZVNUdmUkZEN2ZvR2RLY2kzdWtq?=
 =?ks_c_5601-1987?B?MTluTjR2QXhpTTh5ODB2ZFVIM1UwVHh0eXdPblU2cVplczVTNDZl?=
 =?ks_c_5601-1987?B?M2hReDQrbjc1UEE4bDFpVGYwcXEzcVZEcmkvMWdPSlRCV1NyYWlu?=
 =?ks_c_5601-1987?B?KzZEL285S3BhUlg3M29KUWtWN3RvQUR2WHptd3BKOG1vWXExbE9p?=
 =?ks_c_5601-1987?B?YktUbURRM2FVN2ZYL2hxR0prdUNYVVFmWDdncWVyR2RjOG5ubnpl?=
 =?ks_c_5601-1987?B?ZjNFL1BPbVFvVWtIbDBPZktVZFpQZ3hFZW80cFJwYkV0UHliUGpW?=
 =?ks_c_5601-1987?B?VG0xSWJya0JpbmZlNFZGVlBFU05zdU1RczAxdkZPNnRMMmZXQnNB?=
 =?ks_c_5601-1987?B?TmJiZ2RxSmRONU5lY0lhUHk3ZHlGa0hMMllKTDRIL3Q2Ynd0c1VU?=
 =?ks_c_5601-1987?B?djA3QXJzT1gwMjliTzhKOVVSWmQ2MFFSUG9PZWR0R1daWVNpZm85?=
 =?ks_c_5601-1987?B?NUNCU3AxSFV3MkpRdU81WWVrNzN3VHdDOVpGZXN1d2VrNWhCZkVR?=
 =?ks_c_5601-1987?B?VHp6a1EzU1ljQlhhTVV3eGdOdUlDdFZRR0ZlTGIrUmF0dTlNZXQ5?=
 =?ks_c_5601-1987?B?OCszUEJ5VzVBWnR4UXBnUlYzb3NYbnJYeVJ5VWhGR3hKbUpFdnRy?=
 =?ks_c_5601-1987?B?TFZmUk9XY0lwYVo4RnpnSDZBUzUvNmRHL0NYckZmOVY4QzV1RE1D?=
 =?ks_c_5601-1987?B?N2Joc2xBZWRGeFBDbXFYSlhvK0ROaWJqWERwcHNWKzJvQklLNlJq?=
 =?ks_c_5601-1987?B?Q3E2ajhVWUhtNDRjVVF3QkpEM05DUENqSEEvOHRtY0ljMCtwYkV6?=
 =?ks_c_5601-1987?B?WHR6V3VULzJPOTQxWUFnc1pqMFk4RVc2cVg2NXExQWJIa20ydGVL?=
 =?ks_c_5601-1987?B?QzlNMWxpcEwrbEx6cnYzRC9ubWZhZndhNDV3YStrUTIwZz09?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: telechips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b3cf7e-cf2a-44fc-643d-08de95d6aaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 01:23:55.1614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9ec49ece-9398-4634-9468-0ca88a890702
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLAaVqsyEGAJeqenBu89UzNAKrfKJvkhTamQTZoTffs3zvJ2iP4w1hpRSCCv2hU2UTgcKqxYDPbMBIdUjpuC9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1473
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

DQo+V291bGQgdGhpcyBwYXRjaCB3b3JrcyBmb3IgeW91Pw0KPmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3UtYm9vdC8yMDI2MDIyNTIxMTMzMi4xODk2MjUyLTEtaGFuLnh1QG54cC5jb20vDQoNCj5S
ZWdhcmRzLA0KPlBlbmcNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLg0KDQpJIHdvdWxk
IGxpa2UgdG8gY2xhcmlmeSB0aGF0IEkgaW5kZXBlbmRlbnRseSBkZXZlbG9wZWQgYW5kIHZlcmlm
aWVkIGEgc2ltaWxhciBhcHByb2FjaCB0byB0aGUgb25lIGluIHRoZSBsaW5rZWQgcGF0Y2guIEhv
d2V2ZXIsIG15IGFuYWx5c2lzIHNob3dzIHRoYXQgdGhlIGxpbmtlZCBwYXRjaCBpcyBwcmltYXJp
bHkgZm9jdXNlZCBvbiB2NS4xQiwgd2hpY2ggbWF5IGxlYWQgdG8gY29tcGF0aWJpbGl0eSBpc3N1
ZXMgd2l0aCBmdXR1cmUgZU1NQyB2ZXJzaW9ucy4NCg0KSSBiZWxpZXZlIG15IHByb3Bvc2VkIHBh
dGNoIHByb3ZpZGVzIGEgbW9yZSBnZW5lcmFsaXplZCBhbmQgZnV0dXJlLXByb29mIHNvbHV0aW9u
LCBlbnN1cmluZyBsb25nLXRlcm0gbWFpbnRlbmFuY2UgYW5kIHN0YWJpbGl0eSByZWdhcmRsZXNz
IG9mIHZlcnNpb24gdXBkYXRlcy4NCg0KUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMg
b24gdGhpcyBhcHByb2FjaC4NCg0KVGhhbmtzLA0KQmVzdCBSZWdhcmRzLA0KTVcgUGFyay4NCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KurizvSC757b3OiBQZW5n
IEZhbiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQq6uLO9ILOvwqU6IDIwMjaz4iA0v/kgOcDPILjx
v+TAzyC/wMD8IDE6MjENCrnetMIgu+e29zogudq5zr/sIChNVyBQYXJrKQ0KwvzBtjogdS1ib290
QGxpc3RzLmRlbnguZGU7IHBlbmcuZmFuQG54cC5jb207IGpoODAuY2h1bmdAc2Ftc3VuZy5jb20N
CsGmuPE6IFJlOiBbUEFUQ0hdIG1tYzogYWxsb3cgZm9yd2FyZCBjb21wYXRpYmlsaXR5IGZvciBF
WFRfQ1NEX1JFVg0KDQpDQVVUSU9OOiBUaGlzIGVtYWlsIHdhcyBzZW50IGZyb20gb3V0c2lkZSBv
ZiBURUxFQ0hJUFMuIFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc291cmNlIG9mIHRoaXMgZW1haWwgYW5kIGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KT24gVGh1LCBNYXIgMjYsIDIwMjYgYXQgMDU6NTU6MzJB
TSArMDAwMCwgPz8/Pz8/IChNVyBQYXJrKSB3cm90ZToNCj5BY2NvcmRpbmcgdG8gdGhlIEpFREVD
IFN0YW5kYXJkLCB0aGUgRVhUX0NTRCBmb3JtYXQgaXMgbWVhbnQgdG8gYmUNCj5mb3J3YXJkIGNv
bXBhdGlibGUuIEFzIGxvbmcgYXMgQ1NEX1NUUlVDVFVSRSBkb2VzIG5vdCBjaGFuZ2UsIGFsbA0K
PnZhbHVlcyBmb3IgRVhUX0NTRF9SRVYgYXJlIGF1dGhvcml6ZWQuDQo+DQo+Q3VycmVudGx5LCBp
ZiBhbiBlTU1DIGRldmljZSB3aXRoIGEgbmV3ZXIgRVhUX0NTRF9SRVYgKGUuZy4sIGVNTUMgNS4x
Qg0KPndpdGggRVhUX0NTRF9SRVY9OSkgaXMgdXNlZCwgVS1Cb290IGZhaWxzIHRvIGluaXRpYWxp
emUgaXQgYW5kIHJldHVybnMNCj4tRUlOVkFMIGJlY2F1c2UgdGhlIHJldmlzaW9uIGlzIGxhcmdl
ciB0aGFuIHRoZSBtbWNfdmVyc2lvbnMgYXJyYXkgc2l6ZS4NCj4NCj5GaXggdGhpcyBieSBmYWxs
aW5nIGJhY2sgdG8gdGhlIGxhdGVzdCBzdXBwb3J0ZWQgdmVyc2lvbiBpZiB0aGUNCj5FWFRfQ1NE
X1JFViBleGNlZWRzIHRoZSBrbm93biB2ZXJzaW9ucy4gVGhpcyBlbnN1cmVzIGZvcndhcmQNCj5j
b21wYXRpYmlsaXR5IHdpdGggZnV0dXJlIGVNTUMgc3BlY2lmaWNhdGlvbnMuDQo+DQo+U2lnbmVk
LW9mZi1ieTogTVcgUGFyayA8bXcucGFya0B0ZWxlY2hpcHMuY29tPg0KDQpXb3VsZCB0aGlzIHBh
dGNoIHdvcmtzIGZvciB5b3U/DQpodHRwczovL2xvcmUua2VybmVsLm9yZy91LWJvb3QvMjAyNjAy
MjUyMTEzMzIuMTg5NjI1Mi0xLWhhbi54dUBueHAuY29tLw0KDQpSZWdhcmRzLA0KUGVuZw0KVGhp
cyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHRvIGl0IG1heSBiZSBjb25maWRlbnRpYWwgYW5k
IGFyZSBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgdG8gd2hv
bSBpdCBpcyBhZGRyZXNzZWQuIEFueSB2aWV3cyBvciBvcGluaW9ucyBleHByZXNzZWQgYXJlIHNv
bGVseSB0aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBkbyBub3QgbmVjZXNzYXJpbHkgcmVwcmVzZW50
IHRob3NlIG9mIFRlbGVjaGlwcyBJbmMuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQgb2YgdGhpcyBlbWFpbCwgeW91IG11c3QgbmVpdGhlciB0YWtlIGFueSBhY3Rpb24gYmFz
ZWQgdXBvbiBpdHMgY29udGVudHMgbm9yIGNvcHkgb3Igc2hvdyBpdCB0byBhbnlvbmUuIFBsZWFz
ZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSBlbWFpbCBpZiB5b3UgaGF2ZSByZWNl
aXZlZCB0aGlzIGVtYWlsIGJ5IG1pc3Rha2UgYW5kIGRlbGV0ZSB0aGlzIGVtYWlsIGZyb20geW91
ciBzeXN0ZW0uIFBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5n
IHRoaXMgZW1haWwuDQo=
