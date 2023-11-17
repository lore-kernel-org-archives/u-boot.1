Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABC0C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 09:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797AD86EE2;
	Fri, 17 Nov 2023 10:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="1p8bZB4M";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="K0qTBM/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA3286EB9; Fri, 17 Nov 2023 10:17:06 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB6286F84
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 10:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1700212621; x=1731748621;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wUWXKo85tRKy2ApAkoWcanF+i0VC1s0utYL2MMW4j/0=;
 b=1p8bZB4MuGj76OlnS8rdY5cM8/LMsdEUtaNzwUmIZNQJfePA0C0v2EiE
 Cb78WuCdHnjF5pZKb006E4O7oOt0fJyhF41ZxMuHptRAGl34dJW5zwz4l
 m7FnOILunaDTzx37OwMbLWjsagSfAoVoePZ3z5qEfB1/ZEw/KLqgCusvF
 /UHP3nUpqI+PJlmFkNEXA6PgN69JwC/NUgJKXxLbd9mHjf+8y0nf2S8EV
 qoYwf2Y6OnDn3lzuHxsh+/JTBUfSBYIiyp043MhHyc7TPZZbfRCCriSKG
 O3VxBPaOW9BaumPlRBe4NI7AzXQ8w9FVuC4pEXXWBocbLJc7LLonZJvhT Q==;
X-CSE-ConnectionGUID: coqHIatnQCmCULozlp65xA==
X-CSE-MsgGUID: 3zLZmJz6T4OL3eQH0OvrHg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="179010487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Nov 2023 02:16:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Nov 2023 02:15:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Nov 2023 02:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyri+/zjtnfEHnKrsI8fJryikGCLsZ2kMOew/1GIvZYXSXPWhFh2Xq1ZE+BDuGeFkOZv4r02f2Rf501QufiGRrLUXFo4UaqbX9g+pkT6tqwY4JP0yOw9WmTMCj8yhSTD1kTsbUGHJ5if+HI/7OxODReBEzYqHkCc/R1qtMtUfXDH+HXlXiY8IkHgfp21wPabtc1mVy2tqmdO3UumOQ7Cps8i60yhsPPV4DUUfvjCiRSkpRDSg7Ttv8zX+7n0PAaDxRczXXd9eN1gXJyMPeBXI72d4FTwiUUQNTQ/GX+6HSfW9rpyV3tlU5eUXCxWskZXKasFfM2UerZMxEVZ/X8Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUWXKo85tRKy2ApAkoWcanF+i0VC1s0utYL2MMW4j/0=;
 b=CMss3aHxRCe6kktm0qdT6r8Ilc4ZMo2lWuNSxSyxCbHPB8XnHOOI2QWCPkI3rZSi1rlj9iYocHyO8GynFl5PFB7fSyt3CbC2qyNfyMDTYSwjfP/DgS3zitCZAcXyZiVHG1HzqfGSpx5sH4mxzM3a+xMp/9LuCkyETr9F9eaiZFg7DbIXgo4hJ20JTgaFjexbBSC3OR7HFhp1trcS4JKoQQ85Vs+p7JNXEeT44V68UX/w9Htye6WJJcta1zAR+QpWcOwyOZDBUTtHbKqQgELTZsx2tjhUpPwpCgEdmh2wlsgD5mve7WutbYE+WcSOJ+NlTuZ3/DMIZGYoxsqdVo++kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUWXKo85tRKy2ApAkoWcanF+i0VC1s0utYL2MMW4j/0=;
 b=K0qTBM/hCRu/ruo4nZo9HV1c+A2+WDv8nD7/A+Uqnic6xiXw0ji198dHWxFVSxue1HOk8KbHYsTmGujwbHQ3ARHt/TwgLpmJ7ihPsR5vTQDzyKN6rJXDf+vENE0i7DZ84Ew2Gsh1fEQYXECzxE9fu3qREGpjPJryX0H7uPNJWu8gQuNpBIcIH0oQOQDtrHoqkxm2s+hyxtiqTkwjz9PJYlCrTwCEvpAxqvO++WlkCOb0B4Hi5hp5CcOqQf0oabOuDwEa8leNx34VvdCyQ+sxAw4eoKWp9U0fgVvgHAW3+VHQkQw3thXVBjOwvmNdcwzqfm6FV+8Zlflk7PLO1baaMA==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 09:15:44 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::a09d:2614:5fb0:a4b9]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::a09d:2614:5fb0:a4b9%3]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 09:15:44 +0000
From: <Mihai.Sain@microchip.com>
To: <eugen.hristev@collabora.com>, <trini@konsulko.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <Nicolas.Ferre@microchip.com>,
 <Aubin.Constans@microchip.com>, <Cristian.Birsan@microchip.com>
Subject: RE: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Thread-Topic: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Thread-Index: AQHaGM15VLY9m08JAUuYOfvayNOlxrB+OYxQ
Date: Fri, 17 Nov 2023 09:15:44 +0000
Message-ID: <PH8PR11MB68049E01B9388C294E9DD10582B7A@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20231105022742.632175-1-seanga2@gmail.com>
 <20231116184702.GA344953@bill-the-cat>
 <4906942a-8140-4264-afaa-3072f2eaed98@collabora.com>
In-Reply-To: <4906942a-8140-4264-afaa-3072f2eaed98@collabora.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CH3PR11MB8518:EE_
x-ms-office365-filtering-correlation-id: 9ab08887-1a44-428f-b5e6-08dbe74dc76f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lbDk56/orMQRLCP7T0WTpkKOy/dH7w3SsdEyp7NlsykPu7+EYI3RMoK82yN566PCIxg2GEk0V15rnX+uN1/+LH4s/13elhZZJMLVZc+ONlMyY+TPRdpl9jC1RTA/sxWWDaIRLwsB0OMEOJ/FkuBXpLqC/4QeG/4ybhoYuiDlNQXkNBbC+8DvZeN9A9TWcYaQRGLTGcISjGxpn7gw9f1ZyAhaiAFaeCRt3ksvuGDv87Nh4RejhOAzTEH491y9e8MpxT9YNLEbFPKtDzWNzR74k/lnngpqIoXuO2LPo/vJTWCnk6zkz1Z8AiRGfVcwi++WB0lIXOnd1X6Sd2oMvVkckNhqCwqH7hurn7iv006wM/NXFtwOHB7omI4XcXb9t/e4LEZfaD6ZQzW1JfY7co9v19KKLCH0JmWRkeZ2nYKCS7UlkzIfxhObQSjA7HhrfWeD7LXsumH4rd04vDCWOwy+23ptYhWQLtOUneqPkgZk7/Hf5ylvMqsM/+ZBWeP/aAn+tR4v4DcE6hNhC+139tTw+kxijAf7i1LUqk0wO0KRjhTTwusY9bIxQMRY9kM9qFzPkzxRJ9KBbLVqjYf5CTbr/YMoBBoO5mzsESqx1dV0+KgowmT51MfAUx6abeCtGqld
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(316002)(4326008)(52536014)(8676002)(8936002)(7696005)(6506007)(26005)(41300700001)(64756008)(54906003)(110136005)(107886003)(66476007)(66446008)(66556008)(76116006)(55016003)(38100700002)(83380400001)(66946007)(122000001)(9686003)(53546011)(38070700009)(5660300002)(71200400001)(478600001)(33656002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHpQc3Q4b2tKWFB1cTRDRm96Z0cxQ0hQb0JWdnEvanhUVG1xR05wV3Z1TDdn?=
 =?utf-8?B?UCtmTDhmTm1wTE4rbkpPTG9BcTBBN3NGRE9BTENXdHhXZlhSVzV1cEJjZ3pz?=
 =?utf-8?B?UGN5SmZ3YzN6QVZDR01pdlg3RjdaTHpOZ0RxcDVXbENCRVNQdVMxL082K3F4?=
 =?utf-8?B?MUY3SXR3QzNsVUJ3VXRkV3Y5aEFPQWpvUGZrSEdzN0hLR203MXFyT0RXMDh4?=
 =?utf-8?B?anV1V1U2SGk2TTNMNUU4aVEzd3dPV2VYanAvdWd0UnROZkRES2cvV3MyaGdN?=
 =?utf-8?B?d09mQlVKUHpxdG1vSDNJeFBZV1FQOW1CSjdZR3hKQS9aaktDYVd2QXl1RlR1?=
 =?utf-8?B?QnlMV1B4TUUwZjRpOC9ERytVVm5WTlNWVTJjYzVNMll6ekdiUGI3UWVhRm9s?=
 =?utf-8?B?TzVadTRaazZ1emVUNE1Kckxad2pKN2NzdXJkelNUV2paeGtoSGRBNW9mZi9j?=
 =?utf-8?B?V3FmQTZiVXNDM2Vkb0Q2eS9kR1Y0ajhrUzhTd2xFcTlVTHA1T1NCYWpYVlE3?=
 =?utf-8?B?SDhXaXM5amFET0cvajdWSnJFcUhTVHB0RnZuRm96T3huSGJhRUt0VXpTNUF6?=
 =?utf-8?B?Y3crejFid1NuWUZBYS9XZHUzVU1xUENxTTZWL09HS01ja25ERG5DQ1FMK3Bq?=
 =?utf-8?B?bVlVZFVtSFRiajExVG9MRWhMT2l6QlVUbUcyS0N4K09SemJBVytVL3puVGxV?=
 =?utf-8?B?V24yQnhmZ3pLQ1hwN1ZBRjdWM2s0akFPNjQ1empFUURyUzlUZUsxTjhtUVVW?=
 =?utf-8?B?cFBIR1JNekxieE1McWprUEd3VHNFL211dHNvZ1RKQmc1Z0UyQ0N6UC9kNGtP?=
 =?utf-8?B?QkQ4SmloK1l0MUhjaW1YSEVOZW9KSFoxZG5RSkQ4bGJxTXZKYWdTUkZPeGlo?=
 =?utf-8?B?Rmk3b3VjbjhaWXkybklEdXYxWmxkWHJPa2RjNENlcERqUFhONkhFVEcwSEx0?=
 =?utf-8?B?eFhzNFcvbGhqcXgyZDVYL0ZRczY1QzI4QlpXcnE1eWk5ODZhcXdrelkxWFlW?=
 =?utf-8?B?QUc3VGEyaWhRMHR2ZDl5TzBQT3lsVXAxRzFDM2YvU09uczVJK1g0cUhmVUZt?=
 =?utf-8?B?Kzc0Wm54SXZWVkxsMzBkRmFKSktDTXllSXVuVDI0ZWR0UHVkSXRsL0k5dXh6?=
 =?utf-8?B?d2d6VElRa25xakpLb09acVBtUE1Ed2RsdXNYZDhQc1k3Wkpia09vdGZuVSt6?=
 =?utf-8?B?QkE0WXN2RERiTGFYOTh4WEFOMFM0UHBmWEdqR2diN2dUanhCLzNZUGE1TjJ4?=
 =?utf-8?B?VGNxT3UxTEZJOGp4SEhIVE9UQ3ZjbWV5QS94Z2JEdDArYThyRnI4aisyM0N2?=
 =?utf-8?B?TWlZTVZYR2VYQjU5M3FrY1ZNUjFwRUVEalVMMWd0Yy94VTU2bkdTSDczdWVT?=
 =?utf-8?B?QUlENG5MWXV1RXJDclJsRmFxb1I2K0ttYlY1Qkx1TGE5NmZRaVlrQkZIN1Fn?=
 =?utf-8?B?UlpaT2l0S2JGMHpPSTFDVWs3c1ZUQ2svdGhKZWtrcEhReXZNVmtxY2IyNFoz?=
 =?utf-8?B?Qk9zWFB1NWN1eW52RlF1OVk2L01XSm9IQ3h3ZVFhTmZad0lrNXRqVXlSU2Vw?=
 =?utf-8?B?Y256ekVtMTN5K1RuZUFuZVF2cjYrZWNHOWlNd1FvaUdSeTU1SkZ1dmJCSng4?=
 =?utf-8?B?ZU9UMldLbzRXaWVVM3luemhVSGlGbHFVOEZjZldKampzRC9yN0VYZ2hQcHJZ?=
 =?utf-8?B?aHlDSStMUVRCSUVCTTVtK2xYQldRcklqNjRuMU0rREdkWTJ5dzVEMTRLOVV1?=
 =?utf-8?B?Tnl4NTJBRm91RldEdXdwaXFqQnZDNTBQZTBQT0JxRy94K0JTZzJzSzBGbHhM?=
 =?utf-8?B?d3RoOE5uTENKOW1VSUs2Y3REcFAvZk1jb0N6Y0dVQ1NRZE5KZnM0RXNPek1u?=
 =?utf-8?B?Vmw0SHhnOVZkWVpFWXphQ09XRi85QktxVXFkdzc1bHpXSHUyNHJhR0R6bTRl?=
 =?utf-8?B?QVhsdlRDMGJIYzNoZ0hWM1VIUExORTFxM3dWVHpyemdNRi9RR1RtYTFlTWZi?=
 =?utf-8?B?c0kzSHJCdW1ER0U3cmI0U0s0NWtqRzlSNndzeUhUT0htcEFFYVpQMUUyWklK?=
 =?utf-8?B?V1A1TVZwcGhnVnd1R3FpdE11NEtvdFd0dldEYjRESXM1UExyZmpmdlVlVVRP?=
 =?utf-8?Q?+EIX36YhVB23XdB5LJuNXlV19?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab08887-1a44-428f-b5e6-08dbe74dc76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 09:15:44.7291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qusZZyAx3YCQO/E/ZUF9HWakWJ9gHy210dNuIQlj8w+Pg26KD7G4qme66LZbUzdLrMVmvsDE3go6LI6t1dfxwj61blE3Pd8QgzYsCgxoQmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
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

SGkgRXVnZW4sDQoNCkkgYnVpbHQgbmV3IGJpbmFyaWVzIHdpdGggQ09ORklHX1NZU19USFVNQl9C
VUlMRD15IGZvciBzYW05eDYwX2N1cmlvc2l0eSwgc2FtYTVkMjlfY3VyaW9zaXR5LCBzYW1hN2c1
ZWsgYW5kIG5ldyBzYW05eDc1X2N1cmlvc2l0eSBib2FyZC4NCkkgdXNlZCB0aGUgbGF0ZXN0IHUt
Ym9vdC9tYXN0ZXIgYnJhbmNoIGZvciB0aGlzIHRlc3QuDQpJIG5vdGljZWQgdGhhdCB0aGUgZmls
ZSBzaXplIG9mIHRoZSBiaW5hcmllcyBoYXZlIGJlZWQgcmVkdWNlZCB3aXRoIGFwcm94IDE1MEtp
QiBkdWUgdG8gQ09ORklHX1NZU19USFVNQl9CVUlMRD15Lg0KQWZ0ZXIgZmxhc2hpbmcgdGhlIG5l
dyBiaW5hcmllcyBvbiB0aGVzZSBib2FyZHMgSSBjYW4gY29uZmlybSB0aGF0IG9uIGFsbCBib2Fy
ZHMgdGhlIGxpbnV4IGtlcm5lbCB3YXMgYm9vdGVkIHByb3Blcmx5IGZyb20gbW1jLCBxc3BpLWZs
YXNoLCBuYW5kLWZsYXNoIGFuZCB1c2IuDQpJIHRlc3RlZCB1c2luZyBib290bSBhbmQgYm9vdHog
Y29tbWFuZHMuDQoNCkJlc3QgcmVnYXJkcywNCk1paGFpIFNhaW4NCg0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0K
T24gMTEvMTYvMjMgMjA6NDcsIFRvbSBSaW5pIHdyb3RlOg0KPiBPbiBTYXQsIE5vdiAwNCwgMjAy
MyBhdCAxMDoyNzo0MlBNIC0wNDAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPg0KPj4gU2V2ZXJh
bCBBVDkxIGJvYXJkcyBhcmUgcXVpdGUgY2xvc2UgdG8gdGhlaXIgU1BMIHNpemUgbGltaXQuIEZv
ciANCj4+IGV4YW1wbGUsIHNhbWE1ZDI3X3dsc29tMV9la19tbWMgaXMganVzdCAxNzMgYnl0ZXMg
c2hvcnQgb2YgaXRzIGxpbWl0IA0KPj4gYW5kIGRvZXNuJ3QgZXZlbiBmaXQgd2l0aCBvbGRlciBH
Q0NzLg0KPj4NCj4+IEFsbCBBVDkxIHByb2Nlc3NvcnMgc2hvdWxkIGhhdmUgdGh1bWIgc3VwcG9y
dC4gRW5hYmxlIA0KPj4gU1lTX1RIVU1CX0JVSUxELiBUaGlzIHNocmlua3MgU1BMIGJ5IGFyb3Vu
ZCAzMCUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VhbiBBbmRlcnNvbiA8c2VhbmdhMkBnbWFp
bC5jb20+DQo+PiAtLS0NCj4+IFRoaXMgaGFzIGJlZW4gQlVJTEQgVEVTVEVEIE9OTFkhDQo+DQo+
IFdlIGluIHR1cm4gbmVlZCB0aGlzIGZvciBTZWFuJ3Mgb3RoZXIgY2xlYW51cCBzZXJpZXMgdG8g
Z28gaW4uIElzIHRoaXMgDQo+IE9LPyBXb3VsZCBpdCBiZSBzYWZlciBpZiBpdCB3YXMgb25seSBm
b3IgQ1BVX1Y3QSA/IEkgZG8gaGF2ZSANCj4gcmVjb2xsZWN0aW9ucyBvZiB0aHVtYiBiZWluZyBz
b21ldGltZXMgYnVnZ3kgcHJpb3IgdG8gdjdhIGNvcmVzLiBUaGFua3MhDQo+DQoNCkhpIFRvbSwN
Cg0KSSB3b3VsZCBsaWtlIHRoaXMgdG8gYmUgdGVzdGVkIG9uIGEgZmV3IGJvYXJkcyBhdCBsZWFz
dC4gVGhlcmUgYXJlIGJvYXJkcyB3aXRoIENvcnRleCBBNSwgQTcgYW5kIEFSTTkyNiB3aGljaCBh
cmUgaW1wb3J0YW50LCBvbmUgb2YgZWFjaCBvZiB0aGVtIGFuZCBib290aW5nIExpbnV4IHNob3Vs
ZCBiZSBlbm91Z2ggSSB0aGluay4NCk5pY29sYXMsIEF1YmluID8gSSByZW1lbWJlciB5b3UgZ3V5
cyBoYXZlIGFsc28gYSBDSSB0b29sIHRoYXQgaXMgZmFpcmx5IGVhc3kgdG8gdXNlIGlmIHlvdSBq
dXN0IHB1c2ggYSBicmFuY2gvY29tbWl0Lg0KDQorIE1paGFpIGFzIHdlbGwuDQoNCkV1Z2VuDQo=
