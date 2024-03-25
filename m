Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1DBC54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 08:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2F387D1E;
	Mon, 25 Mar 2024 09:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="ZyyIId89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8519787D1E; Mon, 25 Mar 2024 09:35:27 +0100 (CET)
Received: from ps82.spcmail.jp (ps82.spcmail.jp [35.74.107.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4C287D64
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 09:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml9+I9PYr5RX1f+S+b8WyNTuqK+IoAim14DO+tSB0HXgejERFepgBKF8ryQwLUJMAwr3vuLEE/c4E0SsPp7UGFxZ6ZyzBfroAAYT9ZpkT5bRYvvI32s7ia1EHJ7Nr8TTvO53iTzRswnEwLJJ1LRUMuwT9ZAIp7Nc3i0abijzodmO87vqZLAW1FSDpOmCejCKLMwm8+ZwlE/K1gGPRZUzVB1hSE4pU9HsBPhf9coFQ9/E1T7ydvvHfdb1R3A1GK7Bu69GpNXWZ3GCvUeBn4i7eyX924XOefF9tZk6yjxvuiLyiOlDI40SqQLE8bfRs5TvLV7Vg/H19xcJh8OALd/YBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLDJ1vurUF7ts6c3XRiIrooRDo8d7NTxyqTDuiohB+4=;
 b=X8eMhPteIWB+V6mKji4SBYAii768gQdS0RJCbOmZp/gDar/HYtHh2JT4wBXJmCgkTpQpy7xp5X0BCtyLpSt2RcYr6tNzvquXXF7tjtSgLZ+mu5TaNgQqTXLu95WUgePN8bOlINw0xI47vPoWyoXpMIjHK8z5u/kPRNUS+YdeivCBWoOjN+5ryGm6FSV+orbkVqtCEh45Bag4ih35G0iWDNsCaXnOXCoXqsTOqb5AHgy77OfORWGjA9UKt/ueUZ9TL01zYTDsJgCE1aSAJ84PfUqdfu0RYwLt3zD7u47ho15V8xdGuTgazRSLM/ZhZVo3WG4gkPOOVHRlDDEHZsjp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLDJ1vurUF7ts6c3XRiIrooRDo8d7NTxyqTDuiohB+4=;
 b=ZyyIId89+v+LK+sLMS5Ct4qxO8c5SDK59SUCxHuskthJ75gUwRvFPl4O8kVgF3ReAcVTa7Mbvqrs+FNnVLGZOI46mmenXgeQ3CUm1fJ4herzGxC4xRFXh1IBIpQK2d8MQeyS8/+JzyCkn1LilBWUaKJ7QaCnQkP1aZqKR9wQyZc=
Received: from TYCPR01MB8375.jpnprd01.prod.outlook.com (2603:1096:400:151::10)
 by TYCPR01MB10052.jpnprd01.prod.outlook.com (2603:1096:400:1e8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:35:08 +0000
Received: from TYCPR01MB8375.jpnprd01.prod.outlook.com
 ([fe80::35f7:2a4e:bfd4:b4f]) by TYCPR01MB8375.jpnprd01.prod.outlook.com
 ([fe80::35f7:2a4e:bfd4:b4f%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 08:35:08 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH v3 00/20] FWU: Add support for FWU metadata version 2
Thread-Topic: [PATCH v3 00/20] FWU: Add support for FWU metadata version 2
Thread-Index: AQHafEfUDdctN6t5P0CVx81YWgIUE7FIJQYw
Date: Mon, 25 Mar 2024 08:35:08 +0000
Message-ID: <TYCPR01MB8375F9C9980212AF72D23F4CE3362@TYCPR01MB8375.jpnprd01.prod.outlook.com>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8375:EE_|TYCPR01MB10052:EE_
x-ms-office365-filtering-correlation-id: d1c97c17-a29a-4e46-5fa0-08dc4ca67a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6JCWBLSmMORzrBpjGRHp7cj/oGnFn5ZGoKIMs7ggDsrvik4rD0ZMiNpQNizGu4J6AcaseF3Kz81YlL1BdywqtZtZ5MBdIwh2eqoQ/XXITSGnpcs3xrApvKYlSlltt4sDx6/ZuhUStxeVCyU65MTwojxS7fKAGc/5RRxvsHbxNc1TjCoTLlgxwq4Ui86DL/u7p0OAn9RzbLtxSvtPN6+OVtHrAz5JMCm/Z1zA6mebJ3uXA7Yf2ggvImSvuIj4ywVpFx8LZ059R1J0BK01EYhOrSebYc1HDRt6RxDnT3wz/ydSQyoiHwgDzhswqFkwyoIERR2NiFmBsHNdsvq8wyyNTuZAlRd4d7aLL07mTLvo3M1wavP3qwuSKysM8jFO1+8repLB35QFiFuMhPQlxvHq4o7KR7TeOlO6xaL4su9lILYQ0T/W+2inLF5Roewu84FDn5Yfdgv0EClZl/R6sxB9zDEtSy8ZAo4Lq3JHsEbupuyZBlt5Z1N+0nsT465HVwqdqoXP3XhDrz/DgrrZk/rCw6STlgQ1V94AfzdQgCWoNcTS82ttmKNHUXB87enC4vrMbenkz0ha6wv0phq9iFMkgbp4Yv9x9lPi4CoWiXQz88X6AjnDdILbJovHbhgZ5w+aS8YT/gjwN38ga2gOGMszenLE2vX6+7snJh9BGxRHLB+sknPkcgv9EsU07inHRSC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB8375.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(1580799018)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?anliRjMyb3pxQnl6ZXdwVnliemo4bEZGQVZTSFFhTUlwUDBIVk1NNW8w?=
 =?iso-2022-jp?B?a1pSek1WL3F4QkVRRVNjK0VPNEIxTTFIekVNSk1TUDdDTDZJbzJndEs1?=
 =?iso-2022-jp?B?K3hvaFMyYlBSaEFGbEJEV2tlMHdpWG9yQnYwdXpTQnVibVJZYlY2QlJT?=
 =?iso-2022-jp?B?N1doZW1idHVCeWRDeldnUmdzY0hHYnRoY2dPa2Y3S0RoSnI5WFZIZXQ3?=
 =?iso-2022-jp?B?elRhNUc3aHR2cWtDMkhZY1pvS01lM1piTlkzc0piRHl2SEVDVk9tZzZw?=
 =?iso-2022-jp?B?NHdLc0EzYnlpK3hmRGVNOGVHU0hZdFQxcHRiaFl0M1A3YmlZVmYwQWFT?=
 =?iso-2022-jp?B?cVQwRGVaRHNxYXdraFVGNnlkYW5Ncm5ZSjhLT3Ayb3VCWHRQRU5LTDE3?=
 =?iso-2022-jp?B?YjM4TFBHOVZrOWVla20vV0JCa1p1R09HbE4zZSsrK3FRbVc0S3VxSXlh?=
 =?iso-2022-jp?B?RUtlanZ4QXZ2cjU5alc5WW5rRnNyamtPSWZKQnhXVkMzZk9zTUJNaDhF?=
 =?iso-2022-jp?B?aThOcXBHN0NabE80a2x4STlqdldJR2J0aGYxM3hyRDhVYU5Pa0tCSTUv?=
 =?iso-2022-jp?B?S1ZaRFQ3Q0xiTUtrMmg2RHpsbFc3NTlQRjRGeDhvdUd5UTEvL0pSbmk2?=
 =?iso-2022-jp?B?TTdodlVuN2JCb3liMjdPMzVOYWlWUFZPTHZUYzhHcUo3djdTZFRkWlFQ?=
 =?iso-2022-jp?B?SUtTUGhYWmw1SnpzNmZQaVZjUHVnVTBCbVM4VlI4WWsyOVBtdHEzc0kr?=
 =?iso-2022-jp?B?Uk9SOC8xcHFXYWNiMUxHTEs3VFN4cDdIUTVKclN6dm1jczVDdncvQUNt?=
 =?iso-2022-jp?B?ZHRUK3pEYnQzQXNielNuUldDSzZTNjFSK1hvM3ZoTHVPWkxzMWRaZitq?=
 =?iso-2022-jp?B?clZxaDg2OVZuS0ZzT0xNdVRwSFZKcmxaUVk2NWZidmlvN2N6cVoyWHFX?=
 =?iso-2022-jp?B?ZU9EeVNvS1NsVCtGbllGR2FvdkgwM1A2ZWtEZ1lUc24wWGQ0eFRXejRv?=
 =?iso-2022-jp?B?VFlteXBOc21hcUNZMExhYkd5bnZyU1hKOTZMTFV6azhQZG13TnJEQ3Q5?=
 =?iso-2022-jp?B?OC94UGMwSWRGRFFybEc2M0FRTVVEUDNybHNXVnRubTk3TU1remZ3N2Zl?=
 =?iso-2022-jp?B?aDNPQnZtWE9SRjQvZWxMWUFEcjBrMWdUcE9HS1lxVFhHUHB1U3JXZmdT?=
 =?iso-2022-jp?B?czFudWsydzdCNXk4dmJPL2oxa1FmaCtMK2NSU1FhenZyVnR5eTk2V0Fu?=
 =?iso-2022-jp?B?WFBYL0NxVHNIZ2taUEhJcTNXdHFLU2VsbEJ0ckdHVDIvUDY4ZXRNRCtC?=
 =?iso-2022-jp?B?WUYyY2l4S3BXbkQzWTZwSEtKWmlEQWlnT3BnbDg0clZCODRWbDY2UXVw?=
 =?iso-2022-jp?B?QXZZRTJZNW9FSklzcGhYalE2VUtFNVZiWk40Z0ZkYlZXVkNtVG0rZUlE?=
 =?iso-2022-jp?B?ZkRNNFRoUTZURWVyRktBeEFLMVp4VE15L0V6Ynludld6UmQvcVYzSSt3?=
 =?iso-2022-jp?B?Uy9pT1Bwa0pObmViSjV0NWQyVEs3OGlkKzFUV1lyLzFETWs3eElJK3Q2?=
 =?iso-2022-jp?B?RTVHbWVJVUcvQ2U4MStESUhBTW1hejltdXlwbGZWRE5PbXBVVVIwUjBU?=
 =?iso-2022-jp?B?QnJXYVJQNUpPMlQzbG9FSXN3U3FPK2o2L2UwR2F6WVJLaWxLK1hnNDA3?=
 =?iso-2022-jp?B?Vkg1RHQyajFrQThZTlV6bTFBUEthM2ZTd21oclhsdFFGZjlCTFA0MHpv?=
 =?iso-2022-jp?B?a0EydzhYT2ZkTjBUSlJES0RFS3VMVlN1VjFvNkJ1eU5QM3VyR0ZRKzhS?=
 =?iso-2022-jp?B?WW5hQ2ppSkVXTmFrS3p5UE11Z3NrcW45bXJWV3J3QUdqZFRJdEVrY0h6?=
 =?iso-2022-jp?B?N1R1VnZZS2JONWR1VThuWDd1b2QzZGRXSUpmNVFDZEdTUVJSQ2JQa09n?=
 =?iso-2022-jp?B?LzlNbDN3TjdrU3d0dEh0cmdpM21WaTBQdUZYSmlkMHdEc2swNlpMUXVm?=
 =?iso-2022-jp?B?M2s5MnVpSzZ0M1ZSejQ5NGJWdm1hNnQwdE84SG1YZUV5R0lBUkw1cEow?=
 =?iso-2022-jp?B?dEYyVW42ZFo0akJsNnY0SUFpa0JYKzhXcUo1SDJZZmhibVgwT3YyWkpn?=
 =?iso-2022-jp?B?dnpBcTVwK3FIT0R3a2MyemxIeFFHNnR3bkMrbEhVTFhmV3JkZmdRR05F?=
 =?iso-2022-jp?B?aWpwRWpUb3daNEQ2YmpJVEVza3hTWDQ3N1JUbXg2aEl5ZG5iMFF5NlRx?=
 =?iso-2022-jp?B?YXFpSWRKQ3FtWHBORFhqcUtGdXpCazVILzJ0M1hGR0EvT0R1YnAwUjhq?=
 =?iso-2022-jp?B?ejFITExGWHZqRmhlRWdGMG1GNi9IWldOYkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DuKTLVPhK5/oFTihRuBps0v0+eC9FksP9RcqAyBZAaUWP7iKPdfUP0rWfy7m7u420IkCLIBy+RdmfeTJDyQBL1XuC4r9WQUB23UzL2HkEpIXrwisYebGwFuz8wB1GmtfFJuqZ6+i+Khic1XFyClfgFD0xVKadxl86ELgxweTUtb8Dpf6KlPTyNnGkUzOUu5s1MJzBLejy55IxDoEklyYPqo1mkheVJksV/bf8yuhsuRKtwRe0qfTc2+0eaozcplGUU822v/BedYlriwjc0+2JdSb57CfRAhwoCmi7b/HVyUD+T4V8ru5F43sl0WYAxzaPvuJDzYCHkBf+wQiNaCqclrue1XWuDs6YLIhtLjRdoX15uY5MoX5TfkP9MLPGk2gmmWU52YcnFvzqEtNwykxqybxxLFfZTlMcVMLLVYhWpgcDBY6BJIcpxfZg7Trvb/+pvTtg/vsznIgHFFSDOs8m6GlfAi1fbAe23MfmNVbwGDdtm/N2zjvTOTtAonS7SXwi+yFJZodQcJOAe3EoXDYBEOyCM74gi6CRoBBe03aalPOQSkog/vziObhGXgV1xjlr79GncMWjiX/gBJ0ziH3GofdotQ3gir9NkGpSy/4m2UOTZX6t/zSblp7HnKRM5J8LgJmo7s4Q+NFJx6g0PkGbiIZrAlPxQQNWUUNSP7daUrGhw6hd6VkjRZEnEFxjgWaY+TuPFDds9POZgY/iPCDdtaj2dKKv52jrXnHs2tpOW5JO1QqNr5cPrmcqAl99qZx
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8375.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c97c17-a29a-4e46-5fa0-08dc4ca67a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 08:35:08.2571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56aXjhxA5G9/kqUavNKWtShA3+NtJV3RJKeN0UIRjU1sQq4K1t9klL5wdcZbVqqUkL9wp/ODGQ6HG3bP1kq9GR3kQnKUfGofxUy0tlkEw10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10052
X-CC-Mail-RelayStamp: CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To: <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
Cc: <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <yann.gautier@st.com>, <etienne.carriere@foss.st.com>,
 <patrick.delaunay@foss.st.com>, <michal.simek@amd.com>, <monstr@monstr.eu>
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

Hi Sughosh,

> -----Original Message-----
> From: Sughosh Ganu <sughosh.ganu@linaro.org>
> Sent: Friday, March 22, 2024 7:57 PM
> To: u-boot@lists.denx.de
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Yann GAUTIER <yann.gautier@st.com>;
> Etienne Carriere <etienne.carriere@foss.st.com>; Patrick DELAUNAY - foss
> <patrick.delaunay@foss.st.com>; Michal Simek <michal.simek@amd.com>;
> Kojima, Masahisa/=1B$B>.Eg=1B(B =1B$B2m5W=1B(B <kojima.masahisa@socionext=
.com>; Michal
> Simek <monstr@monstr.eu>
> Subject: [PATCH v3 00/20] FWU: Add support for FWU metadata version 2
>=20
>=20
>=20
> The following patch series adds support for version 2 of the FWU
> metadata. The version 2 metadata structure is defined in the latest
> revision of the FWU specification [1].
>=20
> The earlier versions of these patches were migrating to a version 2
> only support in U-Boot, similar to TF-A. However, based on feedback
> from ST [2], this series has been updated to support both versions. A
> platform would still be needed to enable one of the two versions of
> metadata through a config symbol.
>=20
> TF-A has code which reads the FWU metadata and boots the platform from
> the active partition. TF-A has decided to migrate the FWU code to a
> version 2 only support. These changes have been merged in upstream
> TF-A.
>=20
> These changes have been tested on the ST DK2 board, which uses the GPT
> based partitioning scheme. Both V1 and V2 metadata versions have been
> tested on the DK2 board.
>=20
> These changes need to be tested on platforms with MTD partitioned
> storage devices.
>=20
> @Michal and @Kojima-san, please help in this testing.

I have tested this series on the Developerbox that implements the
MTD-based metadata access, multi bank update works fine.

Thanks,
Masahisa Kojima

>=20
> Note: The CI is breaking on some sandbox py tests, but the errors look
> unrelated. I will look into those issues, but the code review can
> proceed.
>=20
> [1] - https://developer.arm.com/documentation/den0118/latest/
> [2] - https://lists.denx.de/pipermail/u-boot/2024-February/546277.html
>=20
> Changes since V2:
> * New patch which retains support for V1 of metadata
> * Earlier patch was catering to v2 only support. These changes support
>   both versions of metadata.
> * Earlier patch was migrating to v2 only support. These changes
>   support both versions.
> * Support both metadata versions instead of only v2.
> * Added documentation changes.
> * Make changes to have the test work with v1 metadata.
> * Make changes to have the test work with updated logic in fwu code.
> * Changes to indicate support for both v1 and v2 instead of only v2.
> * Add config symbol for selecting either of the two metadata versions.
>=20
>=20
> Sughosh Ganu (20):
>   configs: fwu: remove FWU configs for metadata V2 support
>   tools: mkfwumdata: fix the size parameter to the fwrite call
>   drivers: fwu: add the size parameter to the metadata access API's
>   drivers: fwu: mtd: allocate buffer for image info dynamically
>   fwu: metadata: add support for version 2 of the structure
>   fwu: metadata: add a version agnostic structure
>   fwu: metadata: add functions for handling version specific metadata
>     fields
>   fwu: make changes to access version agnostic structure fields
>   capsule: fwu: transition the platform state on a successful update
>   fwu: add config symbols for enabling FWU metadata versions
>   fwu: mtd: remove unused argument from function call
>   fwu: mtd: get MTD partition specific info from driver
>   fwu: mtd: obtain image information from version agnostic structure
>   cmd: fwu: make changes for supporting FWU metadata version 2
>   tools: mkfwumdata: add support for metadata version 2
>   tools: mkfwumdata: add logic to append vendor data to the FWU metadata
>   test: fwu: make changes to the FWU metadata access test
>   doc: fwu: make changes to reflect support for FWU metadata v2
>   MAINTAINERS: add entry for FWU multi bank update feature
>   configs: fwu: re-enable FWU configs
>=20
>  MAINTAINERS                              |   8 +
>  cmd/fwu_mdata.c                          |  39 ++--
>  configs/corstone1000_defconfig           |   1 +
>  configs/sandbox64_defconfig              |   1 +
>  configs/synquacer_developerbox_defconfig |   2 +-
>  doc/board/socionext/developerbox.rst     |   7 +-
>  doc/develop/uefi/fwu_updates.rst         |  20 +-
>  doc/mkfwumdata.1                         |  16 +-
>  drivers/fwu-mdata/fwu-mdata-uclass.c     |  10 +-
>  drivers/fwu-mdata/gpt_blk.c              |  23 +-
>  drivers/fwu-mdata/raw_mtd.c              |  78 ++++---
>  include/fwu.h                            | 147 ++++++++++++-
>  include/fwu_mdata.h                      |  71 ++++++-
>  lib/efi_loader/efi_capsule.c             |  14 +-
>  lib/fwu_updates/Kconfig                  |  14 ++
>  lib/fwu_updates/Makefile                 |   2 +
>  lib/fwu_updates/fwu.c                    | 204 ++++++++++++------
>  lib/fwu_updates/fwu_mtd.c                |  34 +--
>  lib/fwu_updates/fwu_v1.c                 | 167 +++++++++++++++
>  lib/fwu_updates/fwu_v2.c                 | 260
> +++++++++++++++++++++++
>  test/dm/fwu_mdata.c                      |  16 +-
>  tools/mkfwumdata.c                       | 235
> ++++++++++++++++----
>  22 files changed, 1153 insertions(+), 216 deletions(-)
>  create mode 100644 lib/fwu_updates/fwu_v1.c
>  create mode 100644 lib/fwu_updates/fwu_v2.c
>=20
> --
> 2.34.1
>=20




