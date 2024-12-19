Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEECFE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 09:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED0A80241;
	Thu, 19 Dec 2024 10:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hO0yRF6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA0880283; Thu, 19 Dec 2024 10:51:20 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1548021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQAM0Iq5wWgZufZhtEtaA1CdMGw9zuTll6LaYC0uzqHQYJ70AYHvemgTJo3rCGdwTU1+0hC80iX1Sa0xGy3r0XAeD3N3GopogqsXv1u0bjfgrgCFeJEM00pxdcHUhqPGhT7qm2ME73ioPTyLiZSgrqry8cTTh7uULCAbvy1GfASy6tdq/qNbcXluWM9Q61OqTk4vr45DZdaIZkWkb5tBpfxj/VZu7lJocsD9/e0zCy232jrHVasselNDk9CU2U6bwLj7tgPrFgOSfEptDs6HjDPd57Ydx/eB3FP9xqkuTFzuR/5WsnF4PQ78pTjvJrBwcSAT0HGPcwYSl9hWQWCnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZARAXRYkq3u2d9suVaCPfhIr15LkZHmVVIzi2P53FH8=;
 b=rbaPBPfjyJXIljXPg4D24msbWggVA/YXHegX7nBdmFhR2hSGkzGFSgce4JWrJ3uHDXb3k8zkkAe5x7lsvEGH/UnZqQFd0NUzgfGDyoaTVFyAZFpIrLHXNA+SG4oKPfgSH2SGuQAHpN4jS9yvsAU/vzY7HnE9HB0nt4n2IDA+DNGJ5HpjrUtW4yLRDtA+F0YzswHAML7QCh9YvDYYkr4I9+zUMAsRJ0Fi+QxSJukH7DuXgY1rvOOii3u9+YEnjPdE4vKhYIz5flhriXQbGtVRezAFkdno8c5sHvteyF2qYzHynR1useiqJrPppgEB13+68eMCtUu1bmetqwOe+GqSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZARAXRYkq3u2d9suVaCPfhIr15LkZHmVVIzi2P53FH8=;
 b=hO0yRF6JUW8BVrwMui4jsdt2bpCH16/YKumVWEniaVYu+61CHa/JEb+2+Dh9+HSt0I0mAr7LhLMeyqBtsuWiWnEKylMwd6QEg/tTY4/zHRLtJKuV7YnHEYeCQ07NyQ2SUGaFgzmvgKwnghdOgGdWqIX05yJg6gkVKij5JVZkWwfuuJf81deBDdr1oyGlTdTFobVq+PP8bBQfvwSz+mSt7GfS3lyLLnFvXfccC3XFSSmWrBKqOTj9hNuug8DE7nscyYojbMUSAfuFk+fF1JrXypcvcW0K4pd/JJNTWyVo1sMEGyddJMvCEQX6IH59GmhkdGrtzkIsSiexKgS+zXuoyA==
Received: from MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::16)
 by PR0P264MB2742.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 09:51:16 +0000
Received: from MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9439:f4c7:f69c:c2e]) by MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9439:f4c7:f69c:c2e%7]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 09:51:16 +0000
From: "Paul HENRYS (EXT)" <paul.henrys_ext@softathome.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "paul.henrysd+nodisclaimer@gmail.com" <paul.henrysd+nodisclaimer@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH v4 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
Thread-Topic: [PATCH v4 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
Thread-Index: AQHbUbAd9rqZFOILwEiTISPovlUyrLLtUbqk
Date: Thu, 19 Dec 2024 09:51:16 +0000
Message-ID: <MRZP264MB3114A97D471EA723D4D7A0B3AA062@MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM>
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
 <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
 <20241219005119.GA3555833@bill-the-cat>
In-Reply-To: <20241219005119.GA3555833@bill-the-cat>
Accept-Language: en-BE, fr-FR, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_Enabled=True;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_SiteId=aa10e044-e405-4c10-8353-36b4d0cce511;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_SetDate=2024-12-19T09:51:16.114Z;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_Name=All Employees
 (unrestricted); MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_ContentBits=0;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB3114:EE_|PR0P264MB2742:EE_
x-ms-office365-filtering-correlation-id: 3dc09fbc-f271-46f4-7589-08dd2012ae92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Pt1DJBXp4Yg7thjEFYLbkX0O9+6YC8+aMp6rw9Jup0Zu4EGUt904iZV+LH?=
 =?iso-8859-1?Q?B/nevlME86KfPYXt3M4vdDuM1sMF7uca2Jz8djztT2jE3/dAcdszzMhri4?=
 =?iso-8859-1?Q?2ccqOlOAP2f57m50LHHLVatCHoGUC73V9gcITcMngHdd+F7PO8i5r2dZmo?=
 =?iso-8859-1?Q?fcqP2k1102PrrVfDQ43BwObO/4Jvv+bYqMGgOHzTEODhRzBaMyH4xUhFHn?=
 =?iso-8859-1?Q?A1/9xNl+HuU6zDn3EojT4N8TBcs66H0sLwoAVE36IV5fhH8vwlMGI1LC5c?=
 =?iso-8859-1?Q?DLPFdUut/fVup+UABDk6mCB4quTKjs+L5gmAv+YiN3IAzeZxMJQw56MhwQ?=
 =?iso-8859-1?Q?ZL6m1e2vfk1aOh9pgFeBRqkg4wZ3irqNG7wIfH2SKiO4TKC6FNag/aQ1L4?=
 =?iso-8859-1?Q?AC3ipW6qdzOQxG41s7tyFCMLEvKE2z1nQVWJL1Is4EvV2HSuJPKk2SDLEU?=
 =?iso-8859-1?Q?6nzXuhjPuHQmzo9dDnzBRzqcDztv+PbU+kyOozU+3KWjccCS9o/1l6ptzw?=
 =?iso-8859-1?Q?IAa1+COV4FC73IMaZ9PtCQbaYBStigrWl47fdzGlTK5HyVN9Y8o2c8iqgU?=
 =?iso-8859-1?Q?8g+b046lMDnv0u/FuA/pFJQ3QQw1BufpXhW7aKXPkEPyvDBnYu2N+lDmfI?=
 =?iso-8859-1?Q?3Pklf/Pyvy1QtqxwG9fCEQNMBp9CpR3y93UBeBVuHowy6YkMX7CGiJZXUn?=
 =?iso-8859-1?Q?IdlNmeKfQYDA7gueR8yuOp5a56vZRuTzQFQ1LIyNtzU8ERDV4aPSGUWQH3?=
 =?iso-8859-1?Q?eUUYWi/HFsNx9F1CIxU0DvWVEb++WXQt0jYa4f7CRpbX88NJcDhwXSxpSF?=
 =?iso-8859-1?Q?AGs4+/LumXny+f9mDMKQnk4fwgxy+nFnCspjHZLiiw2hnRjRVdRtpGGAyn?=
 =?iso-8859-1?Q?an1RS1Fen0av02geTXs8BrY1f9yAE2onlxzbUEl3kIuiOKgwD1QQWrca0e?=
 =?iso-8859-1?Q?7piKFys9ZdP8BNvNqdY2nYZFk2UFtYRwM7YMPzkLhi7KDKr5Imw0gDZoIC?=
 =?iso-8859-1?Q?Fk3w2mh6Ry/RtPoeT5gkkrytevB4wg1e09dmhitgf0qARGjzR/z0mbDwNJ?=
 =?iso-8859-1?Q?G5G8faQlIAzMPMuAWzoBclHctpTcwxDFJLzdeKA5Dr0QwjT73a0HwIlKIF?=
 =?iso-8859-1?Q?3/nN31xkM6qtboel7b/3jf3H4oaqIuY5/7NsG/vMt1oNKQOtq1OMyeglMN?=
 =?iso-8859-1?Q?KUJk1tJe5iKrsneHfRFvAip8R4aAF3ad6H1nIWMCZzCzgdARi7HBq4wzC5?=
 =?iso-8859-1?Q?xwC6uzawtJVCgo2fPhT50xpPqY1nTs24edWMyqETobtQEaei/HewK5GP6n?=
 =?iso-8859-1?Q?Itziq5NSTRBP16BfUCt2zj+nS44eoA0zeLrYLTXnMOcgb3BBswVJbo+jB4?=
 =?iso-8859-1?Q?hCtrmJr/bKjV86RQuSCw85q7A7g+O5QLLdyilOvD770CP2+7sr/kMs5F5P?=
 =?iso-8859-1?Q?ooQhNAgqRewhbvK7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c2zAEhdpsik9WrzOmm9notBMhqMBAohEPRXPBcocXCYYABUOY7aCDRU0wi?=
 =?iso-8859-1?Q?+lIIiHs7Opvbn4IFjKsZQ0/AGAumF46Je2roE3+Bdl7WY1CfiQhccO3w0z?=
 =?iso-8859-1?Q?/tMijPg6/T+ECgq95RtjRM4v+RghM1HxRO5DytZHJ3+Ruts53GgFt7J8xW?=
 =?iso-8859-1?Q?3b5Z9iA4aXfqxuUjKagzWt4MFYdjpN33FwXZDu5zrXqOt/K+zGZsCo/XA6?=
 =?iso-8859-1?Q?RmhaxqrUucmkRN3xyh20N6o4wJlg6kkEu6Si0whT/+NaZc4D+yjTD53VUJ?=
 =?iso-8859-1?Q?kQI44+ztHjehLzcg8CjJff1H5nWiA0763jnUkMXAlvkq31dbsK1J8loKYZ?=
 =?iso-8859-1?Q?b6BXGJ4aa1xaEbdOZVr7iDkF0RI45rr736y3gvjrFiywOaEDWbx43ncbfd?=
 =?iso-8859-1?Q?bm0eOam2cA+5YG1qHrkO3v+EcUQD9394QgYO4F42rQbqwpWeCLNX5+BQT3?=
 =?iso-8859-1?Q?E2MAw2PPKTOiUkgfUvbGmiWKlxQdV8ntkY66Ikd/AgvRDxKQURfsRcibqI?=
 =?iso-8859-1?Q?LgPO85dvn08y3VbE6hOaAad7L4qGmdhm+J00HGuxU2+3ZC864KaaNCVpHf?=
 =?iso-8859-1?Q?zJaR8bpOtxVOBQaFJVM6UbsJJeffeuL70Y0uaiZlK45tJVbv3IPf+tiOJi?=
 =?iso-8859-1?Q?Rp6n2iWhsqCNnIvZHntVtLwpDk7+wU4dauG84+MnoXxsHQi8uAJFQIv9u2?=
 =?iso-8859-1?Q?DbEtpkuCqnpgn+IWN4G95FlqDNWhHxbF9DRpEv7zDWzRc6WHZdYJVv0Glb?=
 =?iso-8859-1?Q?aDUZfdQTfjHfpyuxiozgY1Ma4gDW/fDnRpvKO4MLUgGqoqpd8cb9rocsOT?=
 =?iso-8859-1?Q?YjHWjPOXHmzkyNdX9vmFIiVMhbsbHgimfxOgluxeUOYLUwE3jhHQEuce4S?=
 =?iso-8859-1?Q?AGr9C8RnU/EdfydoY4WvL1XgTBLesMojZULI7ONNpBa7vUloCqsHkZUzlK?=
 =?iso-8859-1?Q?aRPAH2TyhMt0KPiht8DhlPImyX/pakV7kSKf05l1VYcj8D1TBxxGhtrmEO?=
 =?iso-8859-1?Q?n0McdtkxtjiF9Q0hQFbTErDhd3qY4Vid/cQOsy4ixKl8NNGFqmhB7mBIaM?=
 =?iso-8859-1?Q?+sLl5JR0/z5np4XFqfR5Y8jUKGuDwk+/1t5k7Z0rKnZGVD/kf2gDP0k+zL?=
 =?iso-8859-1?Q?ijcg34QiJlHJdACZlqxK9mwCpbySYcmBCQZzwpJSYcvcwX3y5NoDYxHf6j?=
 =?iso-8859-1?Q?JV8cpF5VOk/AcPikfEGbao56WlkFK82mINm5EI5vhF8nPOpny3jOyrx0+k?=
 =?iso-8859-1?Q?gqXNZe0lTfJyAuOMIF3W5dGCSfpCXHVd62DOQsiCLi9jhUDfQlufHgJqFv?=
 =?iso-8859-1?Q?xLIoYiWMXVv90EJVg+KxQyFYF1QreFVsVUfQQ5Q0SVJVrnuZSNLX1mah+A?=
 =?iso-8859-1?Q?M8WfSM2fUWmU17kpJQPj4Rg4yp+vEDqFQpAYC+OhzCwzCAwfw+93BLrXTd?=
 =?iso-8859-1?Q?9qYQZ+SCHxInq26zOzmQVT1tYnFUYHOysO8TIsmByjGajHODBfdfZR2tUY?=
 =?iso-8859-1?Q?PFAnosjWmUAqClnCusdtpCRkA5JI55JvMOiMb/Pkmy828UKle7eqcqQkur?=
 =?iso-8859-1?Q?Wf86QqSRpje8y3c+rMtBrVl+8LhEjNi6b8pPvUiBR76bKXty4F2A9jeQ/K?=
 =?iso-8859-1?Q?44UlBgamdxP+2Qg11zZCqsuA6zxbqplOuyT3y0cvHQOqdWFtA1t8S4ww?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc09fbc-f271-46f4-7589-08dd2012ae92
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 09:51:16.6259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/LNOtONfAIohCJpozUHuAfa7xWuK7X83MH2XQr5VMOxBb3gzySfyfxhE9ln4HfqO2w116JA9dDHIw8YQltk5bhy/l7AK0M/SxhC30QiWKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2742
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

Hello Tom,=0A=
=0A=
The issue comes from the key that is reported missing (or zero size):=0A=
=0A=
ValueError: Error 1 running 'mkimage -t -k /tmp/binmant.nvd038o5/keys -F /t=
mp/binman.is3n51x5/fit.fit': File /tmp/binmant.nvd038o5/keys/aes256.bin don=
't have the expected size (size=3D0, expected=3D32)=0A=
=0A=
The issue is that the "binary" file fails to be provided in patchwork. I se=
nd the following mail about this on 05/08/24:=0A=
=0A=
> Hi Simon,=0A=
> =0A=
> Sorry for the late reply as I missed your message blocked in quarantine.=
=0A=
> It looks like when I push a patch with binary data, patchworks does not s=
eem to get it right. Nonetheless, using git send-email, a copy is also sent=
 to me and I do get the patch right.=0A=
> I put you in CC this time so you should also have received a copy of the =
patches. Could you take a look you get the patch "[v2,3/3] tools: binman: A=
dd tests for FIT with data encrypted by mkimage" with the binary data?=0A=
> =0A=
> The end of the patch with the binary data should be as such:=0A=
> =0A=
> diff --git a/tools/binman/test/aes256.bin b/tools/binman/test/aes256.bin =
                                                                           =
                      =0A=
> new file mode 100644                                                     =
                                                                           =
                      =0A=
> index 0000000000000000000000000000000000000000..09b8bf6254ada5c084039f329=
16bc7d30233bb2c                                                            =
                      =0A=
> GIT binary patch                                                         =
                                                                           =
                      =0A=
> literal 32                                                               =
                                                                           =
                      =0A=
> ncmXpsGBz<aGq<obNK8sjNli=3D7$jr*l$<50zC@d;2DJ=3Ds4pC}7U                  =
                                                                           =
                          =0A=
>                                                                          =
                                                                           =
                      =0A=
> literal 0                                                                =
                                                                           =
                      =0A=
> HcmV?d00001=0A=
> =0A=
> =0A=
> FYI, I also added the requested changes.=0A=
> =0A=
> Best regards,=0A=
> Paul=0A=
=0A=
Best regards,=0A=
Paul=0A=
=0A=
________________________________________=0A=
From:=A0Tom Rini=0A=
Sent:=A0Thursday, December 19, 2024 01:51=0A=
To:=A0Paul HENRYS (EXT)=0A=
Cc:=A0u-boot@lists.denx.de; paul.henrysd+nodisclaimer@gmail.com; sjg@chromi=
um.org; al.kochet@gmail.com=0A=
Subject:=A0Re: [PATCH v4 3/3] tools: binman: Add tests for FIT with data en=
crypted by mkimage=0A=
=0A=
=0A=
On Mon, Nov 25, 2024 at 06:47:17PM +0100, Paul HENRYS wrote:=0A=
=0A=
=0A=
=0A=
> Test the property 'fit,encrypt' to encrypt FIT data.=0A=
=0A=
>=0A=
=0A=
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>=0A=
=0A=
> Reviewed-by: Simon Glass <sjg@chromium.org>=0A=
=0A=
> ---=0A=
=0A=
> Changes for v4:=0A=
=0A=
> - Update the tests to use 'fit,encrypt'=0A=
=0A=
>=0A=
=0A=
>=A0 tools/binman/ftest.py=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 45 +++++++++++++++=0A=
=0A=
>=A0 tools/binman/test/343_fit_encrypt_data.dts=A0=A0=A0 |=A0 53 ++++++++++=
++++++++=0A=
=0A=
>=A0 .../test/344_fit_encrypt_data_no_key.dts=A0=A0=A0=A0=A0 |=A0 53 ++++++=
++++++++++++=0A=
=0A=
>=A0 tools/binman/test/aes256.bin=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | Bin 0 -> 32 bytes=0A=
=0A=
>=A0 4 files changed, 151 insertions(+)=0A=
=0A=
>=A0 create mode 100644 tools/binman/test/343_fit_encrypt_data.dts=0A=
=0A=
>=A0 create mode 100644 tools/binman/test/344_fit_encrypt_data_no_key.dts=
=0A=
=0A=
>=A0 create mode 100644 tools/binman/test/aes256.bin=0A=
=0A=
=0A=
=0A=
This fails in CI:=0A=
=0A=
https://source.denx.de/u-boot/u-boot/-/jobs/980030=0A=
=0A=
or=0A=
=0A=
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10169&view=3Dl=
ogs&j=3Dc59aff74-743b-5f08-f408-4a608a489153&t=3Df2ea3536-b291-5a39-ad92-02=
20c9b8101a&l=3D300=0A=
=0A=
Please see https://docs.u-boot.org/en/latest/develop/ci_testing.html=A0for=
=0A=
=0A=
how to trigger Azure yourself to resolve these, thanks!=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
Tom=0A=
=0A=
