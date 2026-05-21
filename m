Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C27CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 16:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05412846A4;
	Thu, 21 May 2026 18:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h5sne02z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB24846E6; Thu, 21 May 2026 17:59:21 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8589846DE
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 17:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 76AF73F301
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779379158;
 bh=eM83SoWHwecBYAjBjhmUab2O6LaHj9+hi5oIiCWsybA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=h5sne02zGHRY+AE/tMOvooN+YcB/St3/HAWXMNlPStgmbL6uxu0qbtMXAdtUaJCls
 l4HmpCCgQzyCRGIB5VS1OxU3kjKdL4ulqJfxElNJJCG36Ed4pPMvcX9r8aloNBHnox
 apdOT/HYo9/srx/3aFnHXBvdHRWJgWJRJ3VSSsaiHPH96vh4FV99ufNxCj4/G5O21t
 1jS9hpt2uD2/D+Y4lWjPhdwgtPgMeBLZP9CcH6vzYD9N4k6nAWieHR3ag/gOijhFM1
 IQ9ctf57ZG8iVBtw1cPyI0ecemGq7/i/9jxvBf6ha6Fe6dmimQB5Wza/RY5PEk9OD6
 rniqr+H7v7t4zJCNCVFN+qEWIGLL09Qf1NUCjGRZ289DltIlmUjyvUGf3i3mtb3iKN
 Ydasv8Q4dDTks0TvGrZLSz54dl/9+ImE60n6XuFcAzHjhIIeX6UOZQOj4NrGiZ2wGO
 K+Jg4Mq0fsfMrPYxyjUaF4jbGj4SadmSt8Ub6WBsWMyqmUn3kKZaf00iejV4+CKc4w
 /r/TR6uIGcBJ/wcHJ9JxdEm5sKx/IgYACH4asGGmT5KyiCUi8/3tfSF49JI9LN0r23
 jmTFR3wuECkqSKa9d02+xJhKGJvBOrTugHmkqrwmH0+6Wfa6OyIbpeQm8CjMMDwfUF
 jgotWzp6l/7TAXNOgCZubl4g=
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bbfaa3ad205so659945166b.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 08:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779379158; cv=none;
 d=google.com; s=arc-20240605;
 b=WzteiTpmttzIHLEvebavJWgIwLivYpn98PrfRYLRGN2coQpSAgyJ6e2wgOpHwpvMOM
 I5YEFd6KRzVdmIwsh9MeMOSbFUsn6Ch3Z8hzd2qziBcbWXWbHPrZnHPbLJ0SFPVUJkpn
 kPFSmWQssONKX+0ZLon1EIZbz3nM9A435Ne+TmZwHtdo/Uk3CAXr1lMiOY9Per97HYY8
 T6g/AKPQlwv+N+vYaISP3MQBJyXYYj0gU3HGmKxOSUHve9zQeP9ZJQ4EtRJUrEb9pL66
 MH8j6jldJcgUDFIvUpuGdy2+1ZrN7CFYoaXAeRcBIET5nricofsAAr8xT8IWbvYxX9Tf
 LO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=eM83SoWHwecBYAjBjhmUab2O6LaHj9+hi5oIiCWsybA=;
 fh=4CkqUVR5hW1/aK0OnwDPaEKIOqOmO6vc7W1qr0xi7oM=;
 b=BZrFq5pBRQfcP82TAkMCMUEdLMRa8u+d0uIh75N+v6g+7pRU808CDXYQYRM7lq0Bsk
 jT7fE0Q7qwcVYxPW4vETjaCR5gkaDiknKbuabelayoO6m7O4kIwPMW540eIsyLhPPASC
 IDuSl0VlzvARKS3WV9MgNmnbO9AviNZH1VuRbMD6RYbycRbEzOKxEi5bK6a6jkOewMFV
 C2hIajhWVXdFzZ392Twdpmp/XMU6wxd46oN8MzbvTkUpDfUCzmgxXUxblSFgr68C2AmT
 1sQbfVGGkZQVY5mnBaRFqkEFLqD5HYvQ4kLCnHz4H2RKAUqo93PHbNkXwwVQG7zWmxT7
 Q5GQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779379158; x=1779983958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eM83SoWHwecBYAjBjhmUab2O6LaHj9+hi5oIiCWsybA=;
 b=DM4X3lDM+5v3ShwnRr1QbWsaGpQY+PUBivx2plB9Tj1GgHb0UfQ/Z82DP395b3LETV
 7/VLE4AbloGhxqUuALqkkQqddVxFjGIzclPaqGAYwZDTIVR3ZPfQY6Ao+Cr3tLszGFYd
 obF66X2TxcEpVV8pB7HBPXgWwrWoacpw5cw+hztZamY9ts7mSk77Hl6bs4w85fHPMTrm
 yNrDwe9SzpL8Z5FvIfck64EMDIEDfYweiOqw15YtSn0GVBPR7zgkEZt57WwjWSQDnrXM
 3ecfWRABcyDw/nAi2MjZ/oS0Ju0Cxr61HuRFrrCpBA/tC3he5KKSp4JYb5x0vxAV2ZE/
 k1jA==
X-Gm-Message-State: AOJu0YzWzja0J7Wtr3JjNcSpHExunCwdonF0FvCdciddcUZ6HaTAK4tg
 aTeSWIAslaTOyLopqHiHNYRNidNpa2Chtb30Ex6Mt5pMSnVJrX5hu/I0g4SWJp1S+HK5rMxWeKY
 3+4MIv49jg4ASbgzOOPwX70DHOqgBp2pzlxaqvVUAPkUoculcrvCtA+UednWclymsKQ1xd+hBzZ
 bLbUlgsC+9iNmb2OWGVpnszcqq20jFez0MqDg25zKPD2GfIQ==
X-Gm-Gg: Acq92OH40WHav/inc3trGnNZr8QwimN3iPK4I6CDM8WPWc4DwghByM4rsMEnKIBfMNe
 H1GrPBr9ftNRV1fKq9U7ZPzBbRQQmt3Qwn0mY9DzFH7lDTPKPK1agw72A+H+UrEKyKnpwUYadJ5
 7++HCVDnNXskLdTUd3FzJqK6KfTEStUfrMHzwt6KrkbijY4qAJdfTHsa87FFUp9tohMu5BfZmSe
 GO4HcfLuBL4qs7/
X-Received: by 2002:a17:907:3f1f:b0:bd1:f09f:f819 with SMTP id
 a640c23a62f3a-bdc0181e729mr174520566b.25.1779379157962; 
 Thu, 21 May 2026 08:59:17 -0700 (PDT)
X-Received: by 2002:a17:907:3f1f:b0:bd1:f09f:f819 with SMTP id
 a640c23a62f3a-bdc0181e729mr174519266b.25.1779379157494; Thu, 21 May 2026
 08:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <20260521023503.29315-2-aristo.chen@canonical.com>
 <ae7e69f3-2e94-44ee-b5ce-685f7f30b0b4@cherry.de>
In-Reply-To: <ae7e69f3-2e94-44ee-b5ce-685f7f30b0b4@cherry.de>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Thu, 21 May 2026 23:59:06 +0800
X-Gm-Features: AVHnY4LX9b0pmksevARcvbNJbrm7zqsyXrWQFgCZZOs24V4Hii4Y_rkJmy5UGAc
Message-ID: <CAA=k7=mBF2meTApjgwmkW1D+4sPiXvCjqbEeho3wJ53TDb+HgA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] test/py: cover get_basename crash on paths with
 dotted directories
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 21 May 2026 18:08:21 +0200
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

Hi Quentin,

On Thu, May 21, 2026 at 5:10=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Aristo,
>
> On 5/21/26 4:35 AM, Aristo Chen wrote:
> > Add a parametrized regression test for the fix in the previous commit.
> > The test invokes mkimage in auto-FIT mode (-f auto) with a -b argument
> > whose directory component contains a '.' and whose leaf either lacks an
> > extension or is a plain identifier. Before the fix these inputs caused
> > get_basename() to compute a negative length and segfault inside memcpy.
> > The test asserts that mkimage exits successfully and that the fdt
> > sub-image description matches the expected stripped basename, covering
> > "./mydt", "./sub.d/leaf", and "./a.b/c". A control input of "./mydt.dtb=
"
> > is also exercised to confirm normal extension stripping still works.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >   test/py/tests/test_fit_mkimage_validate.py | 55 +++++++++++++++++++++=
+
> >   1 file changed, 55 insertions(+)
> >
> > diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests=
/test_fit_mkimage_validate.py
> > index 170b2a8cbbb..0a1cc5963a6 100644
> > --- a/test/py/tests/test_fit_mkimage_validate.py
> > +++ b/test/py/tests/test_fit_mkimage_validate.py
> > @@ -103,3 +103,58 @@ def test_fit_invalid_default_config(ubman):
> >
> >       assert result.returncode !=3D 0, "mkimage should fail due to miss=
ing default config"
> >       assert re.search(r"Default configuration '.*' not found under /co=
nfigurations", result.stderr)
> > +
> > +@pytest.mark.boardspec('sandbox')
> > +@pytest.mark.requiredtool('dtc')
> > +@pytest.mark.parametrize('dtb_relpath,expected_desc', [
> > +    # Crash triggers: last '.' precedes last '/', or leaf has no exten=
sion.
> > +    ('./mydt',       'mydt'),
> > +    ('./sub.d/leaf', 'leaf'),
> > +    ('./a.b/c',      'c'),
> > +    # Control case: extension lives in the leaf, no dotted directory.
> > +    ('./mydt.dtb',   'mydt'),
> > +])
> > +def test_fit_auto_basename_dotted_directory(ubman, dtb_relpath, expect=
ed_desc):
> > +    """Regression test: mkimage -f auto must not crash when a -b path =
has a
> > +    '.' in its directory portion.
> > +
> > +    Before the fix, get_basename() in tools/fit_image.c searched the w=
hole
> > +    path for both the last '/' and the last '.'. When the '.' fell bef=
ore
> > +    the '/', the computed length went negative and was passed unchange=
d to
> > +    memcpy(), which segfaulted. This test exercises three crashing pat=
hs
> > +    plus one control input.
> > +    """
> > +    build_dir =3D ubman.config.build_dir
> > +    kernel =3D fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
> > +    itb_fname =3D fit_util.make_fname(ubman, 'auto_basename.itb')
> > +
> > +    # Materialize the dtb at the requested relative path inside build_=
dir.
> > +    dtb_abs =3D os.path.join(build_dir, dtb_relpath)
> > +    os.makedirs(os.path.dirname(dtb_abs), exist_ok=3DTrue)
> > +    with open(dtb_abs, 'wb') as f:
> > +        f.write(b'dummy')
> > +
> > +    mkimage =3D os.path.join(build_dir, 'tools/mkimage')
> > +    cmd =3D [mkimage, '-f', 'auto',
> > +           '-A', 'arm', '-O', 'linux', '-T', 'kernel', '-C', 'none',
> > +           '-a', '0x80000000', '-e', '0x80000000', '-n', 'test',
> > +           '-d', kernel,
> > +           '-b', dtb_relpath,
> > +           itb_fname]
> > +    # Run with cwd=3Dbuild_dir so the relative path resolves the same =
way
> > +    # the bug originally reproduced.
> > +    result =3D subprocess.run(cmd, capture_output=3DTrue, text=3DTrue,
> > +                            cwd=3Dbuild_dir)
>
> Considering we set cwd to build_dir, can't we simply use ./tools/mkimage
> instead of prepending build_dir to it? It's unclear to me if it's an
> absolute path, but I'm assuming it is otherwise the test wouldn't run.
>
> > +
> > +    assert result.returncode =3D=3D 0, (
> > +        f"mkimage crashed or failed on -b {dtb_relpath!r}: "
> > +        f"rc=3D{result.returncode}\nstdout:\n{result.stdout}\n"
> > +        f"stderr:\n{result.stderr}"
> > +    )
> > +    # The fdt sub-image description is set from get_basename(); confir=
m it
> > +    # matches the expected stripped basename.
> > +    assert re.search(rf"Image 1 \(fdt-1\)\s+Description:\s+{re.escape(=
expected_desc)}\b",
> > +                     result.stdout), (
> > +        f"Expected fdt-1 description {expected_desc!r} in mkimage outp=
ut, "
> > +        f"got:\n{result.stdout}"
> > +    )
>
> I can't help but wonder if we shouldn't make this less dependent on
> mkimage's console output (and thus requiring a regex). FIT data
> structure is simply a device tree so why not parse it to look for the
> description property of the /images/fdt-1 node?
>
> What do you think?

Thanks for the feedback! That makes sense to me, and I will prepare a v2

>
> Looks good to me otherwise.
>
> Cheers,
> Quentin

Best regards,
Aristo
