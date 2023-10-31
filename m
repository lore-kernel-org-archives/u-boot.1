Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C82BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DEF7874DD;
	Tue, 31 Oct 2023 06:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFzq6P4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ABC3874E7; Tue, 31 Oct 2023 06:16:02 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E03874BF
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507a0907896so7565422e87.2
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698729358; x=1699334158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h7mIa9H/dycs3lcJooePFJOfYkPNkBsvzxUdABJAALY=;
 b=SFzq6P4VBBq42Wc18rFYo5YsuvrqZ7VxOKbOfLYiKQgr/7v2K5Ot+xbq1Syo8PzTsJ
 7ZaJLSWjOYmJCdgOHg0PbhgcTI1MWS63T5xz1G+jCcZZHRJJND0QTwkK0neiMDKQLSL3
 aGepVXVjKF01bwvQEDjW/xu1KSWtcRuTdbEfxvWgiQ4MIcrpGZ2Gtm8EE/D2hHY3UOMi
 m1OiH4otbSwX+576sRWgn4pg8iP5ubG1fHE2LbeQvG+AowYf8+0gYhFQ229zZOmhHTFs
 9smrIv1OOLSXHk1tMUupc1WmdyNUuDh0dTrlG1kZyicUEt6CQS3fYhe3Utw3WKjoaIvg
 nkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698729358; x=1699334158;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h7mIa9H/dycs3lcJooePFJOfYkPNkBsvzxUdABJAALY=;
 b=bGBjQIs7KCFwPEEAXS/xkbGL6MlW447y/yjI5dWaioieRR7EYpRJ4XAXNrgkW17/La
 Zdp5BEBXRq20JxFChe7J7SmwV/vS2Z3Z2kdx7JZUKsSOcXiYN0X49kZSmyp/7p7ktk7i
 izDpOQGfOfE48WS2oYxLvxi4bFH/kEGm1SoiqIUWKIHLDLwyxPMXbQC8ItKT370VdDtB
 TMIpaOhBbKYpFRCtB5rcnAqbV5EQVDF+0KbG+QSvABN1/mkjlazhkdO04CWTLzF8VucV
 EqlHepWkReMMesSlbi9Ha5j6RSbyIlTncDCFJFIxcieS7ytM/0UXnsh86o7U0FzE4qZz
 BKbQ==
X-Gm-Message-State: AOJu0YwpJYWlEm/5Z2o2CY7XNdIedowVf05j1jTiHJCxDPiyNrG3xwWz
 fRNIEu5dKPARhhJyMByZKcE=
X-Google-Smtp-Source: AGHT+IGj4V2jk0hf29cfBsi0BwcZkV2IGnWIGSCRf3eDyCi/4exkUl01cB/kK15jLKdeP6JrRCSwzQ==
X-Received: by 2002:a05:6512:79:b0:507:b8e3:598f with SMTP id
 i25-20020a056512007900b00507b8e3598fmr8400394lfo.8.1698729358379; 
 Mon, 30 Oct 2023 22:15:58 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.28.155]) by smtp.gmail.com with ESMTPSA id
 w16-20020a056512099000b00507cf9b1751sm83747lft.182.2023.10.30.22.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 22:15:58 -0700 (PDT)
Date: Tue, 31 Oct 2023 07:15:57 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, 'Simon Glass' <sjg@chromium.org>
CC: 'Patrick Delaunay' <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: RE: [PATCH v2 2/2] power: pmic: fix regulators behaviour
User-Agent: K-9 Mail for Android
In-Reply-To: <000001da0bb8$a4780cf0$ed6826d0$@samsung.com>
References: <20230715183431.5318-1-clamor95@gmail.com>
 <20230715183431.5318-3-clamor95@gmail.com>
 <CAPnjgZ3_Q+nfW+qt1zmGFS2RLCeAzk6eMTEGsEBDdUU-gtzBZw@mail.gmail.com>
 <F441E992-C9A7-4873-8499-D36A477FD006@gmail.com>
 <CAPnjgZ0jBbwzQoi=n2kGGH87-y3r79sBHchr5kKe72M9DN1-Aw@mail.gmail.com>
 <539C9418-CF00-4D8C-8D4C-6461A6470E52@gmail.com>
 <CGME20230719010937epcas1p4be41151400ebea040e620a208be33636@epcas1p4.samsung.com>
 <CAPnjgZ08UbFUn538O8oA7D967ZTEFVZ+Kg7vfbAq7pKEbb4JvQ@mail.gmail.com>
 <000001da0bb8$a4780cf0$ed6826d0$@samsung.com>
Message-ID: <DD5A26FE-76FE-44F1-896E-7E281DC5CF46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



31 =D0=B6=D0=BE=D0=B2=D1=82=D0=BD=D1=8F 2023 =D1=80=2E 07:11:02 GMT+02:00,=
 Jaehoon Chung <jh80=2Echung@samsung=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>Hi,
>
>If will resend this patch according Simon's comment, I will check again=
=2E
>
>Best Regards,
>Jaehoon Chung
>
It will not be updated since it was split into 2 different bigger patchset=
s one of which was dropped as well=2E You have missed a 3 or 4 month of dis=
cussion=2E

>> -----Original Message-----
>> From: Simon Glass <sjg@chromium=2Eorg>
>> Sent: Wednesday, July 19, 2023 10:08 AM
>> To: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> Cc: Jaehoon Chung <jh80=2Echung@samsung=2Ecom>; Patrick Delaunay <patri=
ck=2Edelaunay@foss=2Est=2Ecom>; u-
>> boot@lists=2Edenx=2Ede
>> Subject: Re: [PATCH v2 2/2] power: pmic: fix regulators behaviour
>>=20
>> Hi Svyatoslav,
>>=20
>> On Sun, 16 Jul 2023 at 07:20, Svyatoslav Ryhel <clamor95@gmail=2Ecom> w=
rote:
>> >
>> >
>> >
>> > 16 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:08:10 GMT+03:00, =
Simon Glass <sjg@chromium=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2=
(-=D0=BB=D0=B0):
>> > >Hi Svyatoslav,
>> > >
>> > >On Sat, 15 Jul 2023 at 22:08, Svyatoslav Ryhel <clamor95@gmail=2Ecom=
> wrote:
>> > >>
>> > >>
>> > >>
>> > >> 16 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 02:40:37 GMT+03:0=
0, Simon Glass <sjg@chromium=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>> > >> >Hi Svyatoslav,
>> > >> >
>> > >> >On Sat, 15 Jul 2023 at 12:34, Svyatoslav Ryhel <clamor95@gmail=2E=
com> wrote:
>> > >> >>
>> > >> >> Currently device tree entries of regulators are completely
>> > >> >> ignored and regulators are probed only if they are called
>> > >> >> by the device which uses it=2E This results into two issues:
>> > >> >> regulators which must run under boot-on or always-on mode
>> > >> >> are ignored and not enabled; dts props like voltage are
>> > >> >> not applied to the regulator so the regulator may be enabled
>> > >> >> with random actual voltage, which may have unexpected
>> > >> >> consequences=2E
>> > >> >>
>> > >> >> This patch changes this behavior=2E Post-probe function is
>> > >> >> introduced which performs probing of each pmics child and if
>> > >> >> it is a regulator, regulator_autoset function is called, which
>> > >> >> handles always-on and boot-on regulators, but if none of those
>> > >> >> props are set, the regulator is disabled=2E
>> > >> >>
>> > >> >> Later disabled regulators can be re-enabled by devices which
>> > >> >> use them without issues=2E
>> > >> >>
>> > >> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > >> >> ---
>> > >> >>  drivers/power/pmic/pmic-uclass=2Ec | 18 ++++++++++++++++++
>> > >> >>  1 file changed, 18 insertions(+)
>> > >> >
>> > >> >Can you add a test for this to test/dm/pmic=2Ec ?
>> > >> >
>> > >>
>> > >> Sure, may you specify what I should add to tests/dm/pmic=2Ec? Whic=
h behavior is needed?
>> > >
>> > >Just for the change you are making=2E=2E=2Eyou should be able to che=
ck that
>> > >it sets the regulators if you make sure there are some autoset ones =
in
>> > >sandbox=2E
>> >
>> > Easier to tell then to do=2E I am basically interfering into device e=
stablishment process=2E If smth
>> goes wrong, any regulator related test should fail=2E At least my devic=
es refused to boot/gave
>> unexpected behavior while developing=2E I will look if I can find anyth=
ing meaningful=2E
>>=20
>> Something like this in test/dm/regulator=2Ec:
>>=20
>> struct udevice *pmic, *reg;
>>=20
>> // This should automatically probe the
>> ut_asserok(pmic_get("pmic@41"), &pmic);
>>=20
>> // Check that the regulators are probed and on
>> ut_assertok(regulator_get_by_devname("ldo2", &reg));
>> ut_assert(regulator_get_enable(reg));
>>=20
>> See test=2Edtsi and sandbox_pmic=2Edtsi for the DT nodes=2E You'll need=
 to
>> update ldo2 t too add the properties to cause an autoset=2E
>>=20
>> Regards,
>> Simon
>
>
