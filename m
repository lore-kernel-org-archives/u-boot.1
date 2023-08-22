Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D32EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 503B3846DF;
	Tue, 22 Aug 2023 20:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="bEspAXCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091308646A; Tue, 22 Aug 2023 14:59:42 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264EE86466
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 54174120007;
 Tue, 22 Aug 2023 15:59:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 54174120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1692709178;
 bh=Tm4O3gYDN2gBFOpFkjlxh/Kooq/19YQHMS0shMKXFCA=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=bEspAXCwliJbnRMvhtKoYjI7YIxOIkQC+quSudPrVghpCv/ROXM7BHace3F6non1z
 MCAv2f8tQF67spMubXZXDNsLhhCN365K4ARDsJyJzEKPnf7hnu5EgTd97z6RrBs47J
 n0cEDW+bEkEKlXmhG8ttV+V91EFzaIbnQkjohhvnOeN+R0x2D/s7ju1RXD40A+n3i/
 lic3cOGcIjc1idPM1vHTWXI9esNW8NJXnWWyxaXMaulRHn0vxcv7ZuBuLI35DVRXc2
 fGB+pHOKXiG8uNwM5amg/F9iE6FGEs5pdx2CpkwAEc9wAjsFvxPeHB/Cegce9fh5pl
 btiB83VSzfHcA==
Received: from p-i-exch-sc-m02.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 22 Aug 2023 15:59:38 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 22 Aug 2023 15:59:36 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([::1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::80e5:bab:4999:4480%7]) with mapi id
 15.02.1118.030; Tue, 22 Aug 2023 15:59:36 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "sjg@google.com"
 <sjg@google.com>
CC: Simon Glass <sjg@google.com>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, "narmstrong@baylibre.com"
 <narmstrong@baylibre.com>, "u-boot-amlogic@groups.io"
 <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] drivers: firmware: introduce Meson Secure Monitor
 driver
Thread-Topic: [PATCH v1 1/2] drivers: firmware: introduce Meson Secure Monitor
 driver
Thread-Index: AQHZr/veBzbM8+x1pke90tnJ07p0Z6+sswYAgAEY2YCAAJTMgIAEH9KAgAC7hoCAAPWegIAAk6mAgAPQ/QCAAsMMgIA5NKwAgACmdACAAN1mgIAATOEA
Date: Tue, 22 Aug 2023 12:59:36 +0000
Message-ID: <20230822125932.jvem4lsr7crnybmi@cab-wsm-0029881.sigma.sbrf.ru>
References: <CAPnjgZ3Wfnc_rMJBVZTv_eikUu7vpPWsL1MQ_SruXySV9EZi3A@mail.gmail.com>
 <20230710083443.fuw74gbvwoha75ab@cab-wsm-0029881>
 <CAPnjgZ1aZsFBaX2eBh35CXVExaE90YJHQ98S+2XOWJrJ9pz37w@mail.gmail.com>
 <20230711102459.phpyem2ehlya7osz@cab-wsm-0029881.sigma.sbrf.ru>
 <CAPnjgZ2t2xf05PSgCbQr7MUvJrpQPcRs_Zoux804h4UmTrZRKw@mail.gmail.com>
 <ZLDdaIyXjp9yN5aW@laputa>
 <CAPnjgZ3oQ1qZtWFpezNfV-dZhbCrnqbi1+B=JKb1sfJP6xk-cA@mail.gmail.com>
 <6303961e-3edc-4356-905b-89820a52b227@linaro.org>
 <CAPnjgZ2GA7ktNi9HVJ1Mw=4nuqcQJALVBqHQr1_JtVmkzEVgdw@mail.gmail.com>
 <7a9f5cf0-d7b2-4477-8a56-a3aa7f764e2a@linaro.org>
In-Reply-To: <7a9f5cf0-d7b2-4477-8a56-a3aa7f764e2a@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D35E61DA3D16F4CAE204E6A4EAFBAF6@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179376 [Aug 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527
 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m02.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 cab-wsm-0029881.sigma.sbrf.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/08/22 09:22:00 #21674243
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 22 Aug 2023 20:18:51 +0200
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

Hi,

On Tue, Aug 22, 2023 at 10:24:23AM +0200, neil.armstrong@linaro.org wrote:
> On 21/08/2023 21:11, Simon Glass wrote:
> > Hi Neil,
> >=20
> > On Mon, 21 Aug 2023 at 03:16, neil.armstrong@linaro.org
> > <neil.armstrong@linaro.org> wrote:
> > >=20
> > > Hi,
> > >=20
> > > On 16/07/2023 01:40, Simon Glass wrote:
> > > > Hi,
> > > >=20
> > > > On Thu, 13 Jul 2023 at 23:30, AKASHI Takahiro
> > > > <takahiro.akashi@linaro.org> wrote:
> > > > >=20
> > > > > On Tue, Jul 11, 2023 at 01:13:29PM -0600, Simon Glass wrote:
> > > > > > +AKASHI Takahiro
> > > > >=20
> > > > > Me?
> > > >=20
> > > > Yes, I'm asking for your help to try to clean this stuff up.
> > >=20
> > > The thread is long and hard to answer directly, but as AKASHI
> > > said there's no point to add a SMC class since it's only the message
> > > passing instruction, and there's no point using remoteproc since the
> > > firmware runs on a separate secure state of the same CPU.
> > >=20
> > > And I don't see how we can actually define a finite set of ops becaus=
e
> > > none of the secure firmware interfaces has even similar functions.
> > >=20
> > > So a new UCLASS for each firmware interface should be added, not sure
> > > this is scalable or required since those firmwares are mainly SoC or
> > > vendor specific, except the PSCI or other ARM specific interfaces of =
course.
> > >=20
> > > So I think UCLASS_FIRMWARE is good enough since it avoids using UCLAS=
S_MISC,
> > > but it should be probably documented somewhere that the ops are imple=
mentation
> > > defined.
> >=20
> > Yes it needs docs...but what exactly is the 'firmware' uclass? I
> > assumed it was for loading firmware into a device, but it seems that
> > it is something else?
>=20
> Nop, it's based on the same "firmware" naming as Linux, which is an inter=
face
> with a system control firmware like PSCI, SCPI... not to interact with lo=
adable
> co-processors.
>=20
> Systems do have multiple interfaces implemented like PSCI, SCPI, OPTEE an=
d other
> vendor specific ones like Alexey is changing, all via the same instructio=
n call.
>=20
> >=20
> > Perhaps we should have a UCLASS_SVC (supervisor call) or something
> > like that, rather than continuing with firmware?

You propose to create UCLASS with an interface consisting of functions
of something like: ->smc_call(), ->hvc_call()? In this case, it seems
ARM specific.

Or UCLASS with only one callback, different for different archs, which
will call the hypervisor or something like that. In my understanding,=20
this add-on are redundant.

I still think UCLASS firmware is the best fit for my Secure Monitor
implementation at the moment.

>=20
> I have no opinion on that, I don't think the call type is significant her=
e.
>=20
> Neil
>=20
> >=20
> > [..]
> >=20
> > Regards,
> > Simon
>=20

--=20
Thank you,
Alexey=
