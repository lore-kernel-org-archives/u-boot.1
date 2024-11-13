Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387C9D462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E66388B0A;
	Wed, 13 Nov 2024 16:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=initse.com header.i=@initse.com header.b="Q8PwwaSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A237489001; Wed, 13 Nov 2024 15:17:02 +0100 (CET)
Received: from mx0.init-ka.de (mx0.init-ka.de [85.115.11.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A9489390
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=akoch@initse.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=initse.com; i=@initse.com; q=dns/txt; s=mail;
 t=1731507420; x=1763043420;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=d7x37ci9kBpwM4pq2rmhCLPapwShQcjL1Jd1Q0t8YHA=;
 b=Q8PwwaSqqEQy1srnecmXBo5KSzkqQ3vk7OUc0AST2vc7EyGf3P7zcT++
 gFGoQckCwdr52Tt3tuYzsLEaMsZr2chGPUNYQ6Vnu2BA/6mn+G8Bje3+I
 alT7RLpw3QeqBeOWgUnwT6F5WINZbzg4xMx1ZfDw6CwIQ3MjSgeljxtt5 Q=;
X-CSE-ConnectionGUID: CsqyeHmuSYqQGyFUQmA75Q==
X-CSE-MsgGUID: CcOOJRFISUiTROfUDAqVZg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2AcAABPszRn/xpkFaxaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAJgTgEAQEBCwGDPoIDlimSKotrFIFqDwEBAQEBAQEBAQgBRAQBAYUHA?=
 =?us-ascii?q?oo/JzYHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEBBQEBAQEBAQYEAYEhhTVHD?=
 =?us-ascii?q?IZbAQQBJ1cLAgEIDTkxJQIEhVYjsQqBATMaAmWEe9k4gW2BSAGBaYZiAYYhh?=
 =?us-ascii?q?D9CgUlEgRWCeTE+hCoZhkQEgRCBMYE+gml2JYgKgQ2Df4lmgwGIEVJ7HANZI?=
 =?us-ascii?q?REBVRMXCwcFgSkhLAOBe1d/gTmBUQFCgRaBR0qDPIFeBTdJgkppSzoCDQI2g?=
 =?us-ascii?q?iQkWYJPhRqBC4NihGaCUR1AAwttPTUUGwakcF+BRIEThQPAe4QkoVozl2kDk?=
 =?us-ascii?q?mGYdyKjP4UYAgQCBAUCF4FuB4IHMxoIGxWDI1EXAtgogTMCBwsBAQMJhkiIf?=
 =?us-ascii?q?AGBHAEB?=
IronPort-Data: A9a23:Z6ymoavYpOpNGUsU2oHbIAYvo+fnVOtcMUV32f8akzHdYApBsoF/q
 tZmKT3VMvfeYDbzc9wgad6ypBkCv8fcx4VnSQRp/Cs8RXwT9ZOVVN+UB3mrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliOfVAOO6ULOZUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtOg06/gEk35qir4WpD5gZWic1j5TcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJEAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi8vy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0YAwoo5K7W9yG
 fMwAysUfx2jgv+N8auCZfhCu/0mBZa2BdZK0p1g5Wmx4fcOWordRajQ6MJDmjY2h9wLHv+YY
 8MfAdZtRE2fOVsVYxFOUMp4xrnAanrXKlW0rHqcpq0840DSyg1ty7WrO93QEjCPbZkNxRrF9
 zuel4j/KjoRE/u98xSkyU+tutXokx7XcZssJrLto5aGh3XWnAT/EiY+SB6xpv6lokq/QM5Eb
 UAZ/DpooaVayaCwZoCiBVvi+Tjd5kZaAYQ4//AG1TxhA5H8u26xblXohBYcNLTKaOdeqeQW6
 2K0
IronPort-HdrOrdr: A9a23:CuCbOqDZQkf0Lc3lHemW55DYdb4zR+YMi2TDsHoBKiC9E/b5qy
 nKpp8mPHDP5gr5NEtOpTniAsW9qBHnhPxICOAqVN/JMTUO3lHYSb2KhrGC/9SPIVyYysdtkY
 tmbqhiGJnRIDFB/KDHCdCDYrId/OU=
X-Talos-CUID: 9a23:YVzOpm4QZFFuMzUV6tss31UNC80Fd2Dm/W7pDF6WNF9sYeLIcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AqC+51Axl2YOb03hOa+04la4NMt+aqI+lL2cvq7s?=
 =?us-ascii?q?ngPSFCRZXNQqxpS2JcIByfw=3D=3D?=
Received: from unknown (HELO srvnereus.init-ka.lan) ([172.21.100.26])
 by gateway13.init-ka.lan with ESMTP; 13 Nov 2024 15:14:19 +0100
X-AuditID: ac15641a-b01ff700000029e4-7f-6734b457ec52
Received: from srvkamail01.init-ka.lan (Unknown_Domain [172.22.3.254])
 by srvnereus.init-ka.lan (INIT-Mailsystem) with SMTP id FC.2D.10724.754B4376;
 Wed, 13 Nov 2024 15:14:47 +0100 (CET)
Received: from srvkamail01.init-ka.lan (172.22.3.254) by
 srvkamail01.init-ka.lan (172.22.3.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 15:14:18 +0100
Received: from srvkamail01.init-ka.lan ([fe80::d3a9:1958:3669:69bf]) by
 srvkamail01.init-ka.lan ([fe80::d3a9:1958:3669:69bf%9]) with mapi id
 15.02.1544.011; Wed, 13 Nov 2024 15:14:18 +0100
From: Alexander Koch <akoch@initse.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Using secondary UART for board initialization
Thread-Topic: Using secondary UART for board initialization
Thread-Index: AQHbNQi5BSmqYxJZaUG6ehz3/p41q7K1MdGA
Date: Wed, 13 Nov 2024 14:14:18 +0000
Message-ID: <7f91804460ae277aa080daea86b5dd95979c543f.camel@initse.com>
References: <7f6a7ced1e4b64c4f14bf35ca294ed5435776452.camel@initse.com>
In-Reply-To: <7f6a7ced1e4b64c4f14bf35ca294ed5435776452.camel@initse.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.1 
x-originating-ip: [85.115.11.137]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <92ACBEFF7EA6E0428CB6FE488D540971@init-ka.lan>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8b8Tzd8i0m6wYxuaYu3ezvZHRg9zt7Z
 wRjAGMVlk5Kak1mWWqRvl8CV8f3KGdaC+/wVSx8uZ2tgXMbTxcjJISFgIjFx+3HGLkYuDiGB
 PYwSt6ZehnI+MEo8XXSNHcI5wCjRebKbDaSFTUBdYsHJncwgtoiAocTf3btZQGxhASuJ7fPv
 sUDErSWauy4yQthGEnc2rQKzWQRUJc4duQ5WwyvgLtGx6BvYTCEge/KbhewgNqeAh8Ths7/B
 bEYBWYkNG86D7WIWEJe49WQ+E8TZAhJL9kDEJQREJV4+/scKYosC1bc8fc0KEVeU+LnjNQtE
 r77E6oYDbBC2lUTP3W5WCFtbYtnC18wQ9whKnJz5hGUCo/gsJOtmIWmfhaR9FpL2WUjaFzCy
 rmLkLC4qy0stSi0t3sQIiiPRFKkdjLcnWR5iFOBgVOLhvbnSJF2INbGsuDL3EKMEB7OSCO8p
 Z+N0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryvVewChATSE0tSs1NTC1KLYLJMHJxSDYxd3K/O
 vNjDfaftXf26Rp0ojnO7G9PEf1x4PX9OsnJCz4FZHr/2SQqeT9fs+1rIvHhG/YkPy2pfaB5q
 UDP3vvf8StIJVp/JMdb7stgnt5fIx0o95uB18y1w8JKcq7vfd8Fe763XCgqqd2XNuOtStu5Y
 h4L3ySMT7B7NvD/5u82ylpfrtvOkVukrsRRnJBpqMRcVJwIAm/EFpp8CAAA=
X-Mailman-Approved-At: Wed, 13 Nov 2024 16:14:32 +0100
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

> All `serial_putc()`-like functions that I could find are either static to=
 the
> actual driver and thus not accessible from `board_init()` or do not accep=
t a
> `struct udevice *` as a parameter and seem to work on the main U-Boot ser=
ial
> console device only.

Reading other board code I think I have found a supposed-to-be-working sequ=
ence
of calls:

(simplified code)

    struct udevice *dev =3D uclass_get_device_by_name(UCLASS_SERIAL,
                              "serial@30860000", &dev);
    struct dm_serial_ops *ops =3D serial_get_ops(dev);
    ops->setbrg(dev, 115200);
    ops->putc(dev, 'f');

Unfortunately this yields a CPU reset:

    "Error" handler, esr 0xbf000002
    elr: 00000000402605f0 lr : 00000000402610f8 (reloc)
    elr: 00000000bff865f0 lr : 00000000bff870f8
    x0 : 000000000000006d x1 : 000000000000081a
    x2 : 00000000bffabf00 x3 : 00000000bdf1c630
    x4 : 00000000bdf1cf20 x5 : 00000000bdf21804
    x6 : 000000000000000f x7 : 00000000bdf1cf50
    x8 : 00000000bdf1ce80 x9 : 00000000ffffffd0
    x10: 0000000000000002 x11: 00000000ffffffff
    x12: 00000000bdf1d080 x13: 0000000000004884
    x14: 0000000000000000 x15: 00000000bdf1c6a8
    x16: 0000000040234dc4 x17: 000000000000aa80
    x18: 00000000bdf25d80 x19: 00000000bdf1cf20
    x20: 00000000bdf1c670 x21: 00000000ffffffc8
    x22: 00000000bdf1ce8a x23: 00000000bdf1cf20
    x24: 00000000bdf1c670 x25: 000000000000081a
    x26: 00000000bff9c000 x27: 00000000bffabf00
    x28: 0000000000000000 x29: 00000000bdf1c560
   =20
    Code: d00000ba 91263340 f90037e0 39400360 (350001a0)
    Resetting CPU ...

I traced this down to a writel() call to the UART TXD register in the seria=
l
driver (`mxc_serial_putc()` in 'serial_mxc.c').

The documentation for `uclass_get_device_by_name()` says the device is 'pro=
bed
to activate it ready for use' so I think this is not an initialization issu=
e.

Any ideas what I might be missing there?


Best regards,

Alex
