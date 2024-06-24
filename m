Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D4DC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 14:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 862DF8831F;
	Mon, 24 Jun 2024 16:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M+NpR6Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFE888373; Mon, 24 Jun 2024 16:56:16 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61B90876D3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 16:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso490922966b.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719240974; x=1719845774;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLbjGz6y4p7JwxxBWq7p8wZJhG+eSi7hWXfaPOejW+4=;
 b=M+NpR6Yc1dTu72o3yOzgq5azHGfI4JdHPL9dIDcXTr794ZcoPOWVA+M6l9KMYRhUtZ
 DuFW85ICpoTanLoDzC1sk8yQReO90RwQbpKg0rX7K8XUzgr8E7P+s/eFEUwSPwm5CBUa
 cse807CWK47DXtpOShj+wdplVTIh59fetLl8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719240974; x=1719845774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLbjGz6y4p7JwxxBWq7p8wZJhG+eSi7hWXfaPOejW+4=;
 b=Iq8PKl8TmRpmh67onJsKC/jIFUvHUp6cFwnnVfWqwcaS6CLQ3dyPyhv569t7llCl/E
 lvFmUQusdXwUPoiQ3NQLvG3PIJvz0snhMDwhmo74AEkuIJxCY+UERzIgy860btwZcc4z
 CyJwlG1ei6Bqh07rN3Twsx+UVLTgLG6+74AUTvCBRgCVEs3sWYEHuurKCUGlyExQvXsM
 OJAQSfAgCleUIYpDuLG0TpnoJmVWXWY50LRK5mPTCUJDIHGEMoHQ9PMKHGdnukZDgjaw
 T4IqlyCrzDpI98/t7bYknDfnIjk9OsowiEXtbYhqvpSxdt6sCgxjjXPHQsHYQvdwDePJ
 E+Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIz2blz8mgT8ZQBBJ1fiL0dDZEd+30xQE4eWWFPgkJJDZblN6QSaI9dV5V3cKMaCAbpo0dg8thc95Kr3bYXntLJSggkQ==
X-Gm-Message-State: AOJu0YwF899G6YJxNMdE66vZF3JELECeWJBW53BBOOboVU+6aUdqnNp2
 kbAVkVpgovHagSvlZGjlGUfxuK+06z2UYCNTaB5SE9o/RKMjo6766yH9Oukpt7JiQSoXpLdZ3z+
 CJNKopSoXxICQBNGopwdK/OTezekvF1sMQgULPw==
X-Google-Smtp-Source: AGHT+IFEDC+DfA+yGA5ui2loCfP/xCy3ni669osMyzK2hF+tfMpr8+sHEWRmI4ZRhAtthccdxVOzlWUWfw32HpXXN8Q=
X-Received: by 2002:a17:907:c816:b0:a6e:f594:a292 with SMTP id
 a640c23a62f3a-a7242e119dbmr414965766b.63.1719240973748; Mon, 24 Jun 2024
 07:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-20-sjg@chromium.org>
 <ZnkchlJmYdVCkQV+@toradex.com>
In-Reply-To: <ZnkchlJmYdVCkQV+@toradex.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 24 Jun 2024 16:56:02 +0200
Message-ID: <CAOf5uwkQDzOpj-XUojvfWD6tU2cOxZkv4OEvOK7eZJZcRHTjfg@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] CI: Allow running tests on sjg lab
To: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon

On Mon, Jun 24, 2024 at 2:52=E2=80=AFPM Andrejs Cainikovs
<andrejs.cainikovs@toradex.com> wrote:
>
> On Sun, Jun 23, 2024 at 02:32:13PM -0600, Simon Glass wrote:
> > Add a way to run tests on a real hardware lab. This is in the very earl=
y
> > experimental stages. There are only 23 boards and 3 of those are broken=
!
> > (bob, ff3399, samus). A fourth fails due to problems with the TPM tests=
.
> >
> > To try this, assuming you have gitlab access, set SJG_LAB=3D1, e.g.:
> >
> >    git push -o ci.variable=3D"SJG_LAB=3D1" dm HEAD:try
> >
> > This relies on the two previous series targeted at -next as well as the
> > bugfix series for -master
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Reviewed-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>

Do you have documentation on how to set it? We would like to do in our
company too

Michael

> > ---
> >
> > Changes in v3:
> > - Split out most patches into two new series and update cover letter
> >
> > Changes in v2:
> > - Avoid running a docker image for skipped lab tests
> >
> >  .gitlab-ci.yml | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 165f765a833..75c18a0f2f7 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -17,6 +17,7 @@ stages:
> >    - testsuites
> >    - test.py
> >    - world build
> > +  - sjg-lab
> >
> >  .buildman_and_testpy_template: &buildman_and_testpy_dfn
> >    stage: test.py
> > @@ -482,3 +483,155 @@ coreboot test.py:
> >      TEST_PY_TEST_SPEC: "not sleep"
> >      TEST_PY_ID: "--id qemu"
> >    <<: *buildman_and_testpy_dfn
> > +
> > +.lab_template: &lab_dfn
> > +  stage: sjg-lab
> > +  rules:
> > +    - if: $SJG_LAB =3D=3D "1"
> > +      when: always
> > +    - when: manual
> > +  tags: [ 'lab' ]
> > +  script:
> > +    - if [[ -z "${SJG_LAB}" ]]; then
> > +        exit 0;
> > +      fi
> > +    # Environment:
> > +    #   SRC  - source tree
> > +    #   OUT  - output directory for builds
> > +    - export SRC=3D"$(pwd)"
> > +    - export OUT=3D"${SRC}/build/${BOARD}"
> > +    - export PATH=3D$PATH:~/bin
> > +    - export PATH=3D$PATH:/vid/software/devel/ubtest/u-boot-test-hooks=
/bin
> > +
> > +    # Load it on the device
> > +    - ret=3D0
> > +    - echo "role ${ROLE}"
> > +    - export strategy=3D"-s uboot -e off"
> > +    # export verbose=3D"-v"
> > +    - ${SRC}/test/py/test.py --role ${ROLE} --build-dir "${OUT}"
> > +        --capture=3Dtee-sys -k "not bootstd"|| ret=3D$?
> > +    - U_BOOT_BOARD_IDENTITY=3D"${ROLE}" u-boot-test-release || true
> > +    - if [[ $ret -ne 0 ]]; then
> > +        exit $ret;
> > +      fi
> > +  artifacts:
> > +    when: always
> > +    paths:
> > +      - "build/${BOARD}/test-log.html"
> > +      - "build/${BOARD}/multiplexed_log.css"
> > +    expire_in: 1 week
> > +
> > +rpi3:
> > +  variables:
> > +    ROLE: rpi3
> > +  <<: *lab_dfn
> > +
> > +opi_pc:
> > +  variables:
> > +    ROLE: opi_pc
> > +  <<: *lab_dfn
> > +
> > +pcduino3_nano:
> > +  variables:
> > +    ROLE: pcduino3_nano
> > +  <<: *lab_dfn
> > +
> > +samus:
> > +  variables:
> > +    ROLE: samus
> > +  <<: *lab_dfn
> > +
> > +link:
> > +  variables:
> > +    ROLE: link
> > +  <<: *lab_dfn
> > +
> > +jerry:
> > +  variables:
> > +    ROLE: jerry
> > +  <<: *lab_dfn
> > +
> > +minnowmax:
> > +  variables:
> > +    ROLE: minnowmax
> > +  <<: *lab_dfn
> > +
> > +opi_pc2:
> > +  variables:
> > +    ROLE: opi_pc2
> > +  <<: *lab_dfn
> > +
> > +bpi:
> > +  variables:
> > +    ROLE: bpi
> > +  <<: *lab_dfn
> > +
> > +rpi2:
> > +  variables:
> > +    ROLE: rpi2
> > +  <<: *lab_dfn
> > +
> > +bob:
> > +  variables:
> > +    ROLE: bob
> > +  <<: *lab_dfn
> > +
> > +ff3399:
> > +  variables:
> > +    ROLE: ff3399
> > +  <<: *lab_dfn
> > +
> > +coral:
> > +  variables:
> > +    ROLE: coral
> > +  <<: *lab_dfn
> > +
> > +rpi3z:
> > +  variables:
> > +    ROLE: rpi3z
> > +  <<: *lab_dfn
> > +
> > +bbb:
> > +  variables:
> > +    ROLE: bbb
> > +  <<: *lab_dfn
> > +
> > +kevin:
> > +  variables:
> > +    ROLE: kevin
> > +  <<: *lab_dfn
> > +
> > +pine64:
> > +  variables:
> > +    ROLE: pine64
> > +  <<: *lab_dfn
> > +
> > +c4:
> > +  variables:
> > +    ROLE: c4
> > +  <<: *lab_dfn
> > +
> > +rpi4:
> > +  variables:
> > +    ROLE: rpi4
> > +  <<: *lab_dfn
> > +
> > +rpi0:
> > +  variables:
> > +    ROLE: rpi0
> > +  <<: *lab_dfn
> > +
> > +snow:
> > +  variables:
> > +    ROLE: snow
> > +  <<: *lab_dfn
> > +
> > +pcduino3:
> > +  variables:
> > +    ROLE: pcduino3
> > +  <<: *lab_dfn
> > +
> > +nyan-big:
> > +  variables:
> > +    ROLE: nyan-big
> > +  <<: *lab_dfn
> > --
> > 2.34.1
> >
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
