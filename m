Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8727EC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87B58845A;
	Mon,  5 Aug 2024 15:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="LIVP578V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE00B888F8; Mon,  5 Aug 2024 15:43:09 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A205D88381
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 15:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxjjsY6CvAZXfC2DsJmW/eVdzUavr48tFmW1ypRK7HaRhZ8hn6DVuMsM/7IxDBEoWxyUNkLVi9NdfBIoGM1PmnUWIHXo/Mug5G2php5fFdvHCtG4yf2IiNJ1bJTZb+GI4F8y3uv+xAyyCIxPo283BTOl19CMSXrvtjxfjHD+hhOTP2hJPEdm3Ym4DhDp2MxUiOockt8iXV/od1JKP+rNfitw3DdboO/uX3iLpXAO8LPGpQPa2T9rjfPGwCUJ9yYzq1Mg7yctFKOHM49O2Fxa3fgbncjBxYPn+imQ/dZQHLh6AgVuINBLySgpU3WS1wS90tpZXdrQPkElOF6hQJKxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/kNwhRH/8SgB6TD7EMak/Al78arA0A0uCHkS7avTqs=;
 b=iyN2Qs7aHwSlKRDhh3vd/lqsn7F4aRgd4/rPoiH0cQsAGvla/WSBj1lq8dgwtZAPHJg6GRAgXcblpolUBJotOlTDvk6fHkHw5Y/uRVZHUpMOlRH1rD9A64hTXGc+14knknICvZF1omexZVasPjrAg0C1SbuoR9NwdBNy5Sz3vZ4JkhkYuiCaTR50pz311U92eCYvcb+QqcTo9M5nAxoB8/KJl0xY4tLLEJ61XfZ5RD3VIzPClJmEWNBmaGOvxhUK8jQ/8ByKUzNxQuD2h06dvs+HX5CgtsY8X2IAcmawDoNO8GTQuhoETuymlEpEnaF/LqhGN45+f3Hjqc/HT9LU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/kNwhRH/8SgB6TD7EMak/Al78arA0A0uCHkS7avTqs=;
 b=LIVP578V02iKdyZnlhADzXzMknd0xcO1wm35KWjWW/XWsu0irFIeh+5lPyU006m3nos4Vy8tzwCBewVSq5tSCzrf7N3N6yIDJNmE5bvCla3XMWJpTwuLJQ9lCMXDvxzk9iIKuwc6SKjqF8n1ecg7FlPnpsAejsZGZsVqALD7mZDF/NNwm0PABIFZmkRRJFEebvTE2B4pn94SZSdopDzVDCnnE+ckIpsVgHmVUvcwvue+WnNHTAgXcq4kbqgRSMUTmv6FSRT7GWHhFABuNhihBajj4ojv+l/HGyqYgHECK6qTa4QBIWqCjoCHmiFgFjTj37FtVTJ8qBKfIxokSz0f0A==
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::23)
 by PR0P264MB2518.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 13:43:05 +0000
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b56a:1956:b6b6:8102]) by PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b56a:1956:b6b6:8102%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 13:43:05 +0000
From: "Paul HENRYS (EXT)" <paul.henrys_ext@softathome.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Allow encrypting data in FIT with binman
Thread-Topic: Allow encrypting data in FIT with binman
Thread-Index: AQHay76rn0t4Dtonw0a2izHFTkIc5bIY4Xz9
Date: Mon, 5 Aug 2024 13:43:05 +0000
Message-ID: <PAZP264MB31194371697C07641932AAB4AABE2@PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM>
References: <CAFLszTjc9zvvLRAc__dNdvenFQfvr9mWvRHtsBPr1ffVi0js8w@mail.gmail.com>
In-Reply-To: <CAFLszTjc9zvvLRAc__dNdvenFQfvr9mWvRHtsBPr1ffVi0js8w@mail.gmail.com>
Accept-Language: en-BE, fr-FR, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_Enabled=True;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_SiteId=aa10e044-e405-4c10-8353-36b4d0cce511;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_SetDate=2024-08-05T13:43:05.234Z;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_Name=All Employees
 (unrestricted); MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_ContentBits=0;
 MSIP_Label_1925f328-931c-4d86-9b48-4db24b002721_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB3119:EE_|PR0P264MB2518:EE_
x-ms-office365-filtering-correlation-id: 69cd16de-b7b2-48dd-045e-08dcb55488c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hzZeY8oe022CmQeU8XRbZDuBDe62ANLbh9Tc5jGuwX1uNi4shX1xeUfgDC?=
 =?iso-8859-1?Q?RmLOZWA/yS4qclqc3eZlA/5OH/mOvJWu/FR8+Vypv6h7k2tiGJ409+nZLX?=
 =?iso-8859-1?Q?lC+JxAZxvYNxjtEBSEe6w/bvrZxX38CfChq5tGks7dbuFNjvhBw4DyXKK8?=
 =?iso-8859-1?Q?XWbib4DHfRCZGqILwsCKQstZZQ6uVyIfacbGnnI6cXQF1qqkdSOYud5LHF?=
 =?iso-8859-1?Q?yxSMIZ9YfdNM3ncqRAOoPJ8y05AVe6Zug0ZOjMq/jaiMZatcK2hJUUkRCX?=
 =?iso-8859-1?Q?z9+E5F8yQY32MhJOk/kl+7+Asx80dwCCcLDYrS5g1NchCfbme6gE30T56Y?=
 =?iso-8859-1?Q?iepDQ44ng3dpd4r7OILpVIbY36KZcUCT+Jn6fHhsUYiP6PYPP4ZI7rBzwd?=
 =?iso-8859-1?Q?vrMw8HTtFb3ZO5jSM5/XaBjULFJ8V6fId/CYCTwcu7d3860LKO1rvddsnG?=
 =?iso-8859-1?Q?DJxumA2jWDyO3hZ0FnXseduRRNj9NnO/lRBYh1sXtQUS543wEIv5w9BkJu?=
 =?iso-8859-1?Q?RwK6YbPjO0/TFDbiScYo+3bulN+UHH0x/F4aIhU6UWXZRxRTwe2zwCrgtg?=
 =?iso-8859-1?Q?GNi+EVl7f/TxN8jndcgqny9TZMTlpTtCduHRuLZk2W6CgAg8X00flqg6Rd?=
 =?iso-8859-1?Q?2hYTsJTV6vz4D2GlPBSONpL14bsxVqchH26OXFF2Zyjv5JOMbuLlnzQG1Q?=
 =?iso-8859-1?Q?vv4oOrCZBAv/Fx42C23U8E7f3oRSpcHsEb6lZ8zBvtylxsdaAR0Bquocwx?=
 =?iso-8859-1?Q?gX5uHoLZhjcLK6RKSJZFhyWVaU/y+RA4IW0PFajQkeOY/egZTV/mX3HcQi?=
 =?iso-8859-1?Q?K67bNeLQQGAtDs9cc8fvmg85DKa7kQ0oPCS2kCzwNQbi5nYXNObybG2nBS?=
 =?iso-8859-1?Q?+/RYnbr87PHNcPaX70ISW2lBW2MgdtsniB1t84NcvkWr3dCY6uwkOOqSkv?=
 =?iso-8859-1?Q?QhHL8gdJz6zDvAbBtt5j1SE0luCFYFxo/EbI1B9Wk7iMvoD8PijNyoyhb+?=
 =?iso-8859-1?Q?NmTGKsu06DWFtU0kGzDNzOPobhDcWrvOD/m54SYoVtYkoskgKMKpwjs5Lp?=
 =?iso-8859-1?Q?djlgTkO0KrFR9C4RnTwrlN42EKn7TsnbcEDKKpUnk/9XXRfqK58GWqTdCc?=
 =?iso-8859-1?Q?wAtwex8cClp6SIlHaNSCU+MMN/knh44qqShiDjJmZxv13zJQjCIk076C9V?=
 =?iso-8859-1?Q?QgF/s2K7ZsGNFyzYkVW96lDs+grlf+gsm+JBIZgwb1C453UPn4zIa3jG2I?=
 =?iso-8859-1?Q?HlspihkLL+JhZp0iSHjPmTcZAJ84EiOqUkgdD7i8ypA5Tqp5HMhks1V+yn?=
 =?iso-8859-1?Q?en8BRXYktst+OWQwxZr21ncj1+Kitatob6XGR7nhdTTbuM6It+OrfEO5wb?=
 =?iso-8859-1?Q?ZDK5zlfoNUVDLn8Nz1Xp/tL3CoaxUmWRn/dQbOkog7MKlCLklT4Do=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V6fVLkzxakTRkUVGuD+zfAb03IKzhDjH/eeZw0UfbnYNKKClecIZnyvNBH?=
 =?iso-8859-1?Q?HyrmLxnrl81JovKteaWfCwbLcpPF1rU09QR0n+V7IeFy9dFwtRvMvlaxlq?=
 =?iso-8859-1?Q?+gjawM0NSkSckBZqbP+F9jYrfVzfJAbqLhqzqn12yNQ3zZARY7vrGD1kjF?=
 =?iso-8859-1?Q?TbZpphMVJVXzjU3UUsdHpgNypnkaTt+pyyxwHG6BovpDNg/a3aVVijBohF?=
 =?iso-8859-1?Q?L59/pQTVrKcHqNHlQX914qMSYYl42wzNQNawIj/avCMFfmwfdLEAE6L3LL?=
 =?iso-8859-1?Q?lR6VympCKMvuMzzsGkvKWtKCewitJJ6Ze8euBbxLjR8V/W9KmLwnwSUjWs?=
 =?iso-8859-1?Q?ILibJHgNi+Gt3v9JJBMA3b+mBZopIjUnVb4/fYC0X42/1Hh7BELuA++T19?=
 =?iso-8859-1?Q?33JFpg5dwFiigp0Qho0sKclY8mpzd7MfTYcE5SAwmsxSBYwAt+VZfYmKYU?=
 =?iso-8859-1?Q?hEEXtlWNcJdxCljyF9hgG1wkxq3GFkeEQbC/lo78pJ8oh9tz4XrvnjG2ou?=
 =?iso-8859-1?Q?ZudAj37o6UY+7WtCWeKv4nrdGXer0xu1FyYk30bqxY7DsjI5MpKBMrfKnN?=
 =?iso-8859-1?Q?kutxdaRzMJyvl5bP757nHdJXAccUgC5TlURjIjNrsccDJhoN0q2ziZ11hN?=
 =?iso-8859-1?Q?Ix+nvZV664GdoaWCAIf5+J6NamUulIatVjHVwS/Mq5uQ4OuMEPmAyy+p/N?=
 =?iso-8859-1?Q?Z4m86h64LCTfYLtbHY3sKxXZybiLxgV+1EqvZE9BJ/t4MPp+5As5A1jcHz?=
 =?iso-8859-1?Q?i/f3Ygbryk2rBv7zi2BHhSE0m0LByJIiQdzLEhCh/y8wON6uWIV+b4oVzR?=
 =?iso-8859-1?Q?AeUD9tw7fXZ7SNrNLRGoWpre5xuXH+LjDJ2vEkWTjvrzPy9iGOLOwF0PhR?=
 =?iso-8859-1?Q?+PBWR1mROyl5oX1BxQTWYI+PEnYBrC1TGDMVuYFNwsE4eLAPzeVeSXykNy?=
 =?iso-8859-1?Q?rbaMV08aIqeUKcOXnobdiqbvSmTWOeWZELFyskRbQcFgdxrMTfzW8qPI04?=
 =?iso-8859-1?Q?nshYZ0TM8LIjB7mVTD3qqx1WAwkmv2g0z4WeWVYQpGymi1k/bTAyCMWifg?=
 =?iso-8859-1?Q?hYUL5SquLT6SDGgYxkvhhMs4/w8zcGiC28Q/75G9c3yPqEMN/NvX+qy3dt?=
 =?iso-8859-1?Q?x+RCcTPe3HNLOU1jjATGS95zKXNqLfMt7SEgNM2OV8Ma6Gt118NSvAqu1I?=
 =?iso-8859-1?Q?8+YWOtkOX/3dABfP6LIDoduQGKgXEZvrDbt/HJVYeu4yMCCDyS+CVkRZM5?=
 =?iso-8859-1?Q?Kv1M6B5dohsc15/XDsuhb5BqWmP+EQkVlw7NRb5QUbfFB/YNWFtXUWkWZC?=
 =?iso-8859-1?Q?5Ejf7JvMrl2Yaj3vw8z06G7G7Gs158CYiTzvHWtk3SMvvyswZoEIglimZ/?=
 =?iso-8859-1?Q?eEn5IgNJ/vMrEdza9Pas7JPrpKEvavxdUSmi4zSTuFJVoIPf4QZ77Ieegl?=
 =?iso-8859-1?Q?K4CD7qsY4lvN+Uxtk/WNC+P+eJvRpPJy93u6v1HUmISIm94N2EbiV3NQOz?=
 =?iso-8859-1?Q?9waT6Azur8MnHGJH5KhoRXBAfFzMVbMpq1gaN3A8XHPNmU7UDbfltEJz1U?=
 =?iso-8859-1?Q?EOIW8C6u/4Ge7HCwz1H4ZfzCOD0MhPvFRotN+96nLis5qQbmAi87AH6FPk?=
 =?iso-8859-1?Q?YrBvNDGFzylry1kzFcKaS+ceJYEgclSqqeTgqHKW3Ulw4dxVaLUaxIYA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cd16de-b7b2-48dd-045e-08dcb55488c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 13:43:05.5744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+0qFTTaTupARL9HRAgVfB+6pYVPD7zj/0KeTDpiduUbTIiRWLjYBFl3ZnofFTQhT2Rzs2vnmgTV0U05eLOHfjVDoc6Y4WNU8AWJO1wcZwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2518
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

Hi Simon,

Sorry for the late reply as I missed your message blocked in quarantine.
It looks like when I push a patch with binary data, patchworks does not see=
m to get it right. Nonetheless, using git send-email, a copy is also sent t=
o me and I do get the patch right.
I put you in CC this time so you should also have received a copy of the pa=
tches. Could you take a look you get the patch "[v2,3/3] tools: binman: Add=
 tests for FIT with data encrypted by mkimage" with the binary data?

The end of the patch with the binary data should be as such:

diff --git a/tools/binman/test/aes256.bin b/tools/binman/test/aes256.bin
new file mode 100644
index 0000000000000000000000000000000000000000..09b8bf6254ada5c084039f32916=
bc7d30233bb2c
GIT binary patch
literal 32
ncmXpsGBz<aGq<obNK8sjNli=3D7$jr*l$<50zC@d;2DJ=3Ds4pC}7U

literal 0
HcmV?d00001


FYI, I also added the requested changes.

Best regards,
Paul

________________________________________
From: Simon Glass <sjg@chromium.org>
Sent: Monday, 1 July 2024 15:57
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul HENRYS (EXT) <paul.henrys_ext@softathome.com>
Subject: Re: Allow encrypting data in FIT with binman


This Mail comes from Outside of SoftAtHome: Do not answer, click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.

Hi Paul,

Unfortunately I did not receive the email with your patch but I see it
in patchwork here:

https://patchwork.ozlabs.org/bundle/sjg/dm/?series=3D408037

I get this error:

binman test testSimpleFitEncryptedData
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Ru=
nning binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
E
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: testSimpleFitEncryptedData (binman.ftest.TestFunctional)
Test an image with a FIT containing data to be encrypted
----------------------------------------------------------------------
ValueError: Error 1 running 'mkimage -t -k tools/binman/test -F
/tmp/binman.s_qv4_fc/fit.fit': File tools/binman/test/aes256.bin don't
have the expected size (size=3D0, expected=3D32)
mkimage Can't add hashes to FIT blob: -1
Error: Bad parameters for FIT image type
Usage: mkimage [-T type] -l image
...

The aes.bin file seems to be empty for me. Can you please check the patch?

Thank you for doing a proper test.  Can you also please update the
docs for Entry_fit to cover your new property, and regenerate
entries.rst ?

Note that there is a tools.readfile() helper which can read a binary/text f=
ile.

Regards,
Simon
