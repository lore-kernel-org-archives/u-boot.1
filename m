Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A4CC87FCF
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 04:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A3983D28;
	Sat,  9 Aug 2025 06:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T9RmcJ5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF294847EF; Sat,  9 Aug 2025 04:05:27 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D262847E7
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 04:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4fc9881edd1so577669137.3
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 19:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754705124; x=1755309924; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKi1sW/fJ33h+z5kT2ylGPErVt+Gyk5OnMQ9vcqdavk=;
 b=T9RmcJ5D+v6nMLj4li3jCfDc3V8dFSlGSMvjk0Wk2HMACwafjKJxZB11TeyBu9OVSy
 uU3iWQJoiF2DZ8InS7uvUm5lv9w+4eSMgCuTz+ZJxNqP+9Bx1GWj9Kke2ws0GSHvgCOD
 +xXR/kwO4CjyBRn0uWEJd90u0H8bbibz/N9HYAilnHr7qWb2jv1HnCvHtfjiz95WQmg6
 FMrjKNjH8lcFuwjspR2iMgu7sTcoCazciVx/yF8Jsk1GfIaNv39AzNs22oQbz5HmQAJM
 ftFj4b3ZUKz+LWyOTbFxUAMK/w6wJblZZYTOGVKV56dZmRlKIC+Q2SWblg9SaHyn3LC/
 Pf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754705124; x=1755309924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKi1sW/fJ33h+z5kT2ylGPErVt+Gyk5OnMQ9vcqdavk=;
 b=ojb7DqZKiFsK4N2VOYOFrj+uNu/kQ8IW0Kk/6De8/rPO57zpYHL/9/4yU7200BP9ZM
 g5lkFg7Ne0GSeyy+HcccY//EVy2oXxUotYCAUkm54YbsFo24mFzZ637NyuUN8yzShhFW
 JCKp7xx+A3gQtIhCZq3C7GUHPI52bHadKmmKwQIVbCCQQAbPzx883YRjYJ2gxCbSty0F
 Z8x2XFIZLtoVt8KhA+tqLc7OsdYfZg9zlqgKgMb9CfZbtNOdJhd5/ZVmMZZnv7b2d6Nn
 rBizazBjgM4G2/DRq85+KO76CU6FZgOxfNEJHlCPXEoi1mdCocpm78Yb0gQ4qVXMRw9X
 JIrQ==
X-Gm-Message-State: AOJu0Ywsj/Q9kBy2M5L+q/IuRWwBwv87vvd6ZhB2UBvVFAEZ4otwK2Hj
 5G0T2ZBiFUBAHs6y1TpJEnfnmi0gCOrVEU8PVjhVjFJ4SPI2PPphG31Pj8FlwlWok+tyL+UYpYy
 gsuWvZH3qa+oDu5+3fva1l8R4dhFGgLs=
X-Gm-Gg: ASbGncvj86A4z4vhx7WDCmBEqIuyIM4Q4Hzn7bUSpbbL8WOgvdAFJQ2KnO1q7HJOuUL
 +GZzCgxJsteilbks989AWtf7n+5bdmUqDJn+fcBHP4RPXhHWTaWnCxHz8ANkMh9JjpgHTyTa6HN
 jVH12RXXa9Tpt7hfc+dhEZViTWIIbUYUhJJ+e940ivLry8sBp9vCDuTGJwG60MkDd53esFlwh5+
 UaHWh+p
X-Google-Smtp-Source: AGHT+IH8E/uFf3vJgOswchSIWAJfqKAHJD8rJoB1ZEQVYlhxbkCl9aata2J9xdRtOV1Ly3BhTn8+cNl5J4Ua6eu4270=
X-Received: by 2002:a05:6102:5e97:b0:4da:fc9d:f0c with SMTP id
 ada2fe7eead31-5060d496b75mr2404218137.12.1754705124243; Fri, 08 Aug 2025
 19:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-6-aristo.chen@canonical.com>
 <a082bc0a8667f918a1ba80b677f9285527f479bf.camel@phytec.de>
In-Reply-To: <a082bc0a8667f918a1ba80b677f9285527f479bf.camel@phytec.de>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Sat, 9 Aug 2025 10:04:48 +0800
X-Gm-Features: Ac12FXwfTDX3hmUuwO3veSQnj9EJsOIyVvHq9lIhyNqtFHRznBAZMHGj8aIcGpo
Message-ID: <CAJwFiGLv8UzSHy9bgfcx=OXKPuveKXGmCkD6Hin_9OfUc_h9iQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] test: Add test case for FIT image load address
 overlap detection
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "sjg@chromium.org" <sjg@chromium.org>,
 "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, 
 "al.kochet@gmail.com" <al.kochet@gmail.com>, 
 "paul.henrys_ext@softathome.com" <paul.henrys_ext@softathome.com>,
 "bb@ti.com" <bb@ti.com>, Wadim Egorov <W.Egorov@phytec.de>, 
 "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>, 
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>,
 Daniel Schultz <D.Schultz@phytec.de>, 
 "d-gole@ti.com" <d-gole@ti.com>, "ravi@prevas.dk" <ravi@prevas.dk>, 
 "carlos.lopezr4096@gmail.com" <carlos.lopezr4096@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 09 Aug 2025 06:48:41 +0200
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

Yannic Moog <Y.Moog@phytec.de> =E6=96=BC 2025=E5=B9=B47=E6=9C=8831=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Am Dienstag, dem 29.07.2025 um 12:48 +0000 schrieb Aristo Chen:
> > Add a new test case to verify that mkimage properly detects and reports
> > memory region overlaps in FIT image configurations.
> >
> > The test creates a FIT image with kernel and FDT components that have
> > the same load address (0x40000), which should trigger the overlap
> > detection logic and cause mkimage to fail with an appropriate error
> > message.
> >
> > Test verifies:
> > - mkimage returns non-zero exit code when overlap is detected
> > - Error message contains "Error: Overlap detected:"
> > - Error message identifies the specific overlapping components
> >   (kernel@1 and fdt@1)
> >
> > This test ensures the overlap detection feature works correctly and
> > prevents deployment of FIT images with conflicting memory layouts
> > that could cause runtime failures.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >  test/py/tests/test_fit_mkimage_validate.py | 65 ++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/test/py/tests/test_fit_mkimage_validate.py
> > b/test/py/tests/test_fit_mkimage_validate.py
> > index ef974c8c762..51f7f64b257 100644
> > --- a/test/py/tests/test_fit_mkimage_validate.py
> > +++ b/test/py/tests/test_fit_mkimage_validate.py
> > @@ -101,3 +101,68 @@ def test_fit_invalid_default_config(ubman):
> >
> >      assert result.returncode !=3D 0, "mkimage should fail due to missi=
ng
> > default config"
> >      assert re.search(r"Default configuration '.*' not found under
> > /configurations", result.stderr)
> > +
> > +def test_fit_load_addr_overlap(ubman):
> > +    """Test that mkimage fails when load address overlap"""
> > +
> > +    its_fname =3D fit_util.make_fname(ubman, "invalid.its")
> > +    itb_fname =3D fit_util.make_fname(ubman, "invalid.itb")
> > +    kernel =3D fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
> > +    fdt =3D fit_util.make_dtb(ubman, '''
> > +/dts-v1/;
> > +/ {
> > +    model =3D "Test FDT";
> > +    compatible =3D "test";
> > +};
> > +''', 'test')
> > +
> > +    # Write ITS with an invalid reference to a nonexistent default con=
fig
> > +    its_text =3D '''
> > +/dts-v1/;
> > +
> > +/ {
> > +    images {
> > +        kernel@1 {
> > +            description =3D "Test Kernel";
> > +            data =3D /incbin/("kernel.bin");
> > +            type =3D "kernel";
> > +            arch =3D "sandbox";
> > +            os =3D "linux";
> > +            compression =3D "none";
> > +            load =3D <0x40000>;
> > +            entry =3D <0x40000>;
> > +        };
> > +        fdt@1 {
> > +            description =3D "Test FDT";
> > +            data =3D /incbin/("test.dtb");
> > +            type =3D "flat_dt";
> > +            arch =3D "sandbox";
> > +            os =3D "linux";
> > +            compression =3D "none";
> > +            load =3D <0x40000>;
> > +            entry =3D <0x40000>;
> > +        };
> > +    };
> > +
> > +    configurations {
> > +        default =3D "conf@1";
> > +        conf@1 {
> > +            kernel =3D "kernel@1";
> > +            fdt =3D "fdt@1";
> > +        };
> > +    };
> > +};
> > +'''
>
> Why do you create the dts here?
> I think it is best to stay consistent: create a dts file and use existing
> _DoReadFileDtb and the like for the test.
If I understand correctly, _DoReadFileDtb is defined in
tools/binman/ftest.py, and is only for binman related test.
Also I found that in test/py/tests/test_fit.py, it also defined a dts
file in itself, what is the best practice to create dts file?

>
> Yannic
>
> > +
> > +    with open(its_fname, 'w') as f:
> > +        f.write(its_text)
> > +
> > +    mkimage =3D os.path.join(ubman.config.build_dir, 'tools/mkimage')
> > +    cmd =3D [mkimage, '-f', its_fname, itb_fname]
> > +
> > +    result =3D subprocess.run(cmd, capture_output=3DTrue, text=3DTrue)
> > +
> > +    assert result.returncode !=3D 0, "mkimage should fail due to memor=
y
> > overlap"
> > +    assert "Error: Overlap detected:" in result.stderr
> > +    # Check that it identifies the specific overlapping components
> > +    assert "kernel@1" in result.stderr and "fdt@1" in result.stderr
