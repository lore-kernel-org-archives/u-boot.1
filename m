Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC2CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74ADF8490A;
	Mon, 25 May 2026 17:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SDv53Adg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DCB784912; Mon, 25 May 2026 17:32:29 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA6E84859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-63124a80693so3657148137.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723145; cv=none;
 d=google.com; s=arc-20240605;
 b=LSGhxDHb58mGgZHnjt44NtiO8cJFMnGUfbldUjAuBfUJoaS6E7RAM5pmCRAUGL61O1
 +LGjiu+cR9kcTenlOLcwJmutGY4cbFwW3qUqBJ9PZLDvzVSfJ5W6YHMsw4b/k2+Nv3ce
 1CNAEkFBIb9FwX18dNxIdlIONxgNJ6vQY/YiuIcU4IzHhM0A+mh9umf+tDoYTqIdLJSj
 WuWRrQ2b8mcz1VRWzPKvwdEH8XzjIIk61SbQa5ADRsJ+PLWhh37e8QtiOHlkhCh0oKOi
 3GWGx/vBILZLUo0TtzeAL/OPNjV3JHdTB1hkh44zu3LyMDu9JaT1Nto5SbM185i0cMpz
 LPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aOdGMiJIHkL4ZNoORcOfcHoQYvp0gZhMg7f9kNUtmoQ=;
 fh=YFitDpUTmt7FSznbMB37XZKSnTLpahHsmQUufXhEoT0=;
 b=OH/q5UhOfFMppt6W6bnseaDvvChBemQnkPqaVadkRBuXKZpxi4IW+jgLTNqSgH5jRw
 9+4WohWeUfJKjybi7VFLLlOuZ2pdFMDEtUf/7vSm2ZbYaMXH1M7XxgtfloQ8+jGiIATU
 6AV8wkb5fxfSIyOkNYyXHsDtKKQ6A6sJqaqiXny0fJAJpmSzL+jtos5ky5yLYHYv9/mh
 Jw3dplAO5KJ8ka6WOHKJKVTv4Yy/XEeiSvNp2dJOwOLVtnQJfiTk1CCinXoSmSKkGkuk
 OV3mx59pFBdqQq/NAdue5Uon1yCz03YE+uXuvlj7fV+lsK2Twl6ji4meYJDytkvEPr/r
 G0LA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779723145; x=1780327945; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOdGMiJIHkL4ZNoORcOfcHoQYvp0gZhMg7f9kNUtmoQ=;
 b=SDv53AdgUppAoDCEaTVoBOibafegSNl52xnW3zQOO7KsiTp3mNHPyu2yW/DKJaxS1v
 iqcYfRQMBMHyeBObe/3wAzi4wG1TLPw2utb35ErD3PYXdFbMF4DMTacEQIlUcDiy0jL+
 jGPF7aOhnwsRZMBmId6htouCytMvRhzkRABLSiw5UPCHe5GFKQEBt8ayMSb74m2OGY5H
 bXUEMylUDtviKF5LAX2iXQeHZafFoWxcjeFQGxADUuqnq4l/OCeGGsIxJ9sMWjHwG9ML
 k9UTvwaE/KD7dtIayhT6TYNR4iN39AALjZMzF25Q0RV27Y0yjb4nq7VFG0QfNiXKUm3s
 242Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723145; x=1780327945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aOdGMiJIHkL4ZNoORcOfcHoQYvp0gZhMg7f9kNUtmoQ=;
 b=qbn+4mZHlML1bIiqhmIjpQmgvUr5zIhjF0VeUZzVbAWJHlOp711qT9sa3XyZKKSgFW
 phsoKLPLs2RDNmxpLh0o7gJsJzwHSxSXNzzM7mOJ+XknoVJBNK2s22jTu2GXRut9IroY
 fVPtecL+iCrKCOcBny5Lfu5yqSzCD1UMIUHD4ZNnsOsJASFZWAU2l2Pbh4CpZT1lhROp
 CV8IYF07BdwppE2A/uTqgmsImo5s2rViAB0olToiqD7foKnThlSY8HDZ9gEwYNYJzQU1
 X2ryk4KyF9uLv2byD11HL1wKW4fqkMJcUuAQkvDXlqFxi1BIPLsoWVOecVnIVsPIQPdS
 q5Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+7dqFVnN5nCIgyUw8sCy8FlMxbh7fo0CWhJRrFII+4vxVhr7u7NE4NKtnT1oYKg42Wh1c/AA=@lists.denx.de
X-Gm-Message-State: AOJu0YzFUjXN6JXigfhaep4T4YRLoYix9Cf2SGpmrZ7Snn+cixqALucc
 28ua/3eqQCLaKBUFIHxIvGz8SWpFGOCyhScx516gp2ASS39hn9GdibcUK6P3eHt8AelJv9tvT1n
 eZSAk5463X8ppBJnf9yfvzFREtW6lqhE=
X-Gm-Gg: Acq92OFHzUfX/aG2TB5DBPfPsLyngnmYd1avcqxZ8Is3+d106vCRaDwY+F37QWbKehi
 2wedTDpir2N+aUykwMX/ge+DqPC60gMkHkXQkpP37dIps4e5SjGQkHLFTP+Rw7uL+DsmKmr1rsz
 NCUGDt/VVrICez6tjR2Kpty2UNjr7FJ0QYXWD6XnJkvrhlDQmmwmkNoVdLJZr2W33b3Nlf4r6f7
 O1U3EU5Q5vCt8mqGdoXi8S/cMaCTTNjAmR9JQPSge93b2UAjdglW2IZcaPSVs98LIbj9asOcvpC
 qn5CU5lH
X-Received: by 2002:a67:e718:0:b0:634:6e2b:beb2 with SMTP id
 ada2fe7eead31-67c80d682d6mr6432018137.25.1779723145055; Mon, 25 May 2026
 08:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-8-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-8-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:32:13 -0400
X-Gm-Features: AVHnY4LwkHlRMWmKliyTRZU7YiYnOTjlSYo4FqCfc27LekFof45BGnElzChePFI
Message-ID: <CAMDkj5xPhfqsfm7shOsJf7ewuLyHvGwg-HQb9Es6NBAoUzo6Mw@mail.gmail.com>
Subject: Re: [PATCH v6 07/15] test: py: vboot: prepare integration test for
 ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

Hi Philippe,

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> The vboot tests only consider rsa algo for signature.
> To prepare the integration of ecdsa test, the signature
> algo is now explicit.
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
> v3:
> - no change
> v4:
> - no change
> v5:
> - no change
> v6:
> - no change
>
>  test/py/tests/test_fit_ecdsa.py               |  2 +-
>  test/py/tests/test_vboot.py                   | 99 ++++++++++---------
>  ....its =3D> sign-configs-sha1-rsa2048-pss.its} |  0
>  ...sha1.its =3D> sign-configs-sha1-rsa2048.its} |  0
>  ... sign-configs-sha256-rsa2048-pss-prod.its} |  0
>  ...ts =3D> sign-configs-sha256-rsa2048-pss.its} |  0
>  ...56.its =3D> sign-configs-sha256-rsa2048.its} |  0
>  ...84.its =3D> sign-configs-sha384-rsa3072.its} |  0
>  ...s.its =3D> sign-images-sha1-rsa2048-pss.its} |  0
>  ...-sha1.its =3D> sign-images-sha1-rsa2048.its} |  0
>  ...its =3D> sign-images-sha256-rsa2048-pss.its} |  0
>  ...256.its =3D> sign-images-sha256-rsa2048.its} |  0
>  ...384.its =3D> sign-images-sha384-rsa3072.its} |  0
>  13 files changed, 51 insertions(+), 50 deletions(-)
>  rename test/py/tests/vboot/{sign-configs-sha1-pss.its =3D> sign-configs-=
sha1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha1.its =3D> sign-configs-sha1=
-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its =3D> sign-c=
onfigs-sha256-rsa2048-pss-prod.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256-pss.its =3D> sign-config=
s-sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256.its =3D> sign-configs-sh=
a256-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha384.its =3D> sign-configs-sh=
a384-rsa3072.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1-pss.its =3D> sign-images-sh=
a1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1.its =3D> sign-images-sha1-r=
sa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha256-pss.its =3D> sign-images-=
sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha256.its =3D> sign-images-sha2=
56-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha384.its =3D> sign-images-sha3=
84-rsa3072.its} (100%)
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecd=
sa.py
> index 3e816d68eb6..e59390374af 100644
> --- a/test/py/tests/test_fit_ecdsa.py
> +++ b/test/py/tests/test_fit_ecdsa.py
> @@ -102,7 +102,7 @@ def test_fit_ecdsa(ubman):
>      with open(key_file, 'w') as f:
>          f.write(key.export_key(format=3D'PEM'))
>
> -    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256.its', te=
mpdir)
> +    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256-rsa2048.=
its', tempdir)
>
>      fit =3D SignableFitImage(ubman, fit_file)
>      nodes =3D fit.find_signable_image_nodes()
> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 55518bed07e..496d314c649 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -84,21 +84,21 @@ def make_fit(its, ubman, mkimage, dtc_args, datadir, =
fit):
>  # Only run the full suite on a few combinations, since it doesn't add an=
y more
>  # test coverage.
>  TESTDATA_IN =3D [
> -    ['sha1-basic', 'sha1', '', None, False, True, False, False],
> -    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False, False, False, False=
],
> -    ['sha1-pss', 'sha1', '-pss', None, False, False, False, False],
> -    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False, False, Fals=
e, False],
> -    ['sha256-basic', 'sha256', '', None, False, False, False, False],
> -    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False, False, False, F=
alse],
> -    ['sha256-pss', 'sha256', '-pss', None, False, False, False, False],
> -    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False, False, =
False, False],
> -    ['sha256-pss-required', 'sha256', '-pss', None, True, False, False, =
False],
> -    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', True,=
 True, False, False],
> -    ['sha384-basic', 'sha384', '', None, False, False, False, False],
> -    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False, False, False, F=
alse],
> -    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', False, False, True=
, False],
> -    ['sha256-global-sign', 'sha256', '', '', False, False, False, True],
> -    ['sha256-global-sign-pss', 'sha256', '-pss', '', False, False, False=
, True],
> +    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, Fal=
se],
> +    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, =
False, False],
> +    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, =
False],
> +    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False,=
 False, False, False],
> +    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False=
, False],
> +    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, Fal=
se, False, False],
> +    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, Fal=
se, False],
> +    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', Fa=
lse, False, False, False],
> +    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, Fa=
lse, False, False],
> +    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x1=
0000', True, True, False, False],
> +    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False=
, False],
> +    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, Fal=
se, False, False],
> +    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, =
True, False],
> +    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, F=
alse, True],
> +    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, =
False, False, True],
>  ]
>
>  # Mark all but the first test as slow, so they are not run with '-k not =
slow'
> @@ -111,9 +111,9 @@ TESTDATA +=3D [pytest.param(*v, marks=3Dpytest.mark.s=
low) for v in TESTDATA_IN[1:]]
>  @pytest.mark.requiredtool('fdtget')
>  @pytest.mark.requiredtool('fdtput')
>  @pytest.mark.requiredtool('openssl')
> -@pytest.mark.parametrize("name,sha_algo,padding,sign_options,required,fu=
ll_test,algo_arg,global_sign",
> +@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,re=
quired,full_test,algo_arg,global_sign",
>                           TESTDATA)
> -def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, r=
equired,
>                 full_test, algo_arg, global_sign):
>      """Test verified boot signing with mkimage and verification with 'bo=
otm'.
>
> @@ -287,7 +287,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>          utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%=
s.key '
>                            '-out %s%s.crt' % (tmpdir, name, tmpdir, name)=
)
>
> -    def test_with_algo(sha_algo, padding, sign_options):
> +    def test_with_algo(sha_algo, sig_algo, padding, sign_options):
>          """Test verified boot with the given hash algorithm.
>
>          This is the main part of the test code. The same procedure is fo=
llowed
> @@ -308,7 +308,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>
>          # Build the FIT, but don't sign anything yet
>          ubman.log.action('%s: Test FIT with signed images' % sha_algo)
> -        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mk=
image, dtc_args, datadir, fit)
> +        make_fit('sign-images-%s%s%s.its' % (sha_algo, sig_algo, padding=
), ubman, mkimage, dtc_args, datadir, fit)
>          run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else =
'dev-', True)
>
>          # Sign images with our dev keys
> @@ -319,7 +319,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>          dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
>
>          ubman.log.action('%s: Test FIT with signed configuration' % sha_=
algo)
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if a=
lgo_arg else sha_algo), True)
>
>          # Sign images with our dev keys
> @@ -383,7 +383,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>              run_bootm(sha_algo, 'evil clone', 'Bad Data Hash', False, ef=
it)
>
>          # Create a new properly signed fit and replace header bytes
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit(sha_algo, sign_options)
>          bcfg =3D ubman.config.buildconfig
>          max_size =3D int(bcfg.get('config_fit_signature_max_size', 0x100=
00000), 0)
> @@ -415,7 +415,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>              ubman, [fit_check_sign, '-f', fit, '-k', dtb],
>              1, 'Failed to verify required signature')
>
> -    def test_required_key(sha_algo, padding, sign_options):
> +    def test_required_key(sha_algo, sig_algo, padding, sign_options):
>          """Test verified boot with the given hash algorithm.
>
>          This function tests if U-Boot rejects an image when a required k=
ey isn't
> @@ -437,12 +437,12 @@ def test_vboot(ubman, name, sha_algo, padding, sign=
_options, required,
>
>          # Build the FIT with prod key (keys required) and sign it. This =
puts the
>          # signature into sandbox-u-boot.dtb, marked 'required'
> -        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), ubm=
an, mkimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s-prod.its' % (sha_algo, sig_algo, p=
adding), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit(sha_algo, sign_options)
>
>          # Build the FIT with dev key (keys NOT required). This adds the
>          # signature into sandbox-u-boot.dtb, NOT marked 'required'.
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit_norequire(sha_algo, sign_options)
>
>          # So now sandbox-u-boot.dtb two signatures, for the prod and dev=
 keys.
> @@ -454,7 +454,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>
>          # Build the FIT with dev key (keys required) and sign it. This p=
uts the
>          # signature into sandbox-u-boot.dtb, marked 'required'.
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit(sha_algo, sign_options)
>
>          # Set the required-mode policy to "any".
> @@ -534,8 +534,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>      dtb =3D '%ssandbox-u-boot.dtb' % tmpdir
>      sig_node =3D '/configurations/conf-1/signature'
>
> -    create_rsa_pair('dev')
> -    create_rsa_pair('prod')
> +    if sig_algo =3D=3D "-rsa2048" or sig_algo =3D=3D "-rsa3072" or sig_a=
lgo =3D=3D "":
> +        create_rsa_pair('dev')
> +        create_rsa_pair('prod')
>
>      # Create a number kernel image with zeroes
>      with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
> @@ -554,9 +555,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>          if global_sign:
>              test_global_sign(sha_algo, padding, sign_options)
>          elif required:
> -            test_required_key(sha_algo, padding, sign_options)
> +            test_required_key(sha_algo, sig_algo, padding, sign_options)
>          else:
> -            test_with_algo(sha_algo, padding, sign_options)
> +            test_with_algo(sha_algo, sig_algo, padding, sign_options)
>      finally:
>          # Go back to the original U-Boot with the correct dtb.
>          ubman.config.dtb =3D old_dtb
> @@ -564,21 +565,21 @@ def test_vboot(ubman, name, sha_algo, padding, sign=
_options, required,
>
>
>  TESTDATA_IN =3D [
> -    ['sha1-basic', 'sha1', '', None, False],
> -    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
> -    ['sha1-pss', 'sha1', '-pss', None, False],
> -    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False],
> -    ['sha256-basic', 'sha256', '', None, False],
> -    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False],
> -    ['sha256-pss', 'sha256', '-pss', None, False],
> -    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False],
> -    ['sha256-pss-required', 'sha256', '-pss', None, False],
> -    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', False=
],
> -    ['sha384-basic', 'sha384', '', None, False],
> -    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False],
> -    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', True],
> -    ['sha256-global-sign', 'sha256', '', '', False],
> -    ['sha256-global-sign-pss', 'sha256', '-pss', '', False],
> +    ['sha1-basic', 'sha1', '-rsa2048', '', None, False],
> +    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False],
> +    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False],
> +    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False]=
,
> +    ['sha256-basic', 'sha256', '-rsa2048', '', None, False],
> +    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False],
> +    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False],
> +    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', Fa=
lse],
> +    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, False],
> +    ['sha256-pss-pad-required', 'sha256', '-rsa2048' , '-pss', '-E -p 0x=
10000', False],
> +    ['sha384-basic', 'sha384', '-rsa3072', '', None, False],
> +    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False],
> +    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', True],
> +    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False],
> +    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False],
>  ]
>
>  # Mark all but the first test as slow, so they are not run with '-k not =
slow'
> @@ -589,8 +590,8 @@ TESTDATA +=3D [pytest.param(*v, marks=3Dpytest.mark.s=
low) for v in TESTDATA_IN[1:]]
>  @pytest.mark.buildconfigspec('fit_signature')
>  @pytest.mark.requiredtool('dtc')
>  @pytest.mark.requiredtool('openssl')
> -@pytest.mark.parametrize("name,sha_algo,padding,sign_options,algo_arg", =
TESTDATA)
> -def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, al=
go_arg):
> +@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,al=
go_arg", TESTDATA)
> +def test_fdt_add_pubkey(ubman, name, sha_algo, sig_algo, padding, sign_o=
ptions, algo_arg):
>      """Test fdt_add_pubkey utility with bunch of different algo options.=
"""
>
>      def sign_fit(sha_algo, options):
> @@ -609,7 +610,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, paddin=
g, sign_options, algo_arg):
>          ubman.log.action('%s: Sign images' % sha_algo)
>          utils.run_and_log(ubman, args)
>
> -    def test_add_pubkey(sha_algo, padding, sign_options):
> +    def test_add_pubkey(sha_algo, sig_algo, padding, sign_options):
>          """Test fdt_add_pubkey utility with given hash algorithm and pad=
ding.
>
>          This function tests if fdt_add_pubkey utility may add public key=
s into dtb.
> @@ -632,7 +633,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, paddin=
g, sign_options, algo_arg):
>                              'rsa3072' if sha_algo =3D=3D 'sha384' else '=
rsa2048'),
>                             '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb]=
)
>
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>
>          # Sign images with our dev keys
>          sign_fit(sha_algo, sign_options)
> @@ -654,4 +655,4 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, paddin=
g, sign_options, algo_arg):
>
>      # keys created in test_vboot test
>
> -    test_add_pubkey(sha_algo, padding, sign_options)
> +    test_add_pubkey(sha_algo, sig_algo, padding, sign_options)
> diff --git a/test/py/tests/vboot/sign-configs-sha1-pss.its b/test/py/test=
s/vboot/sign-configs-sha1-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha1-pss.its
> rename to test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-configs-sha1.its b/test/py/tests/vb=
oot/sign-configs-sha1-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha1.its
> rename to test/py/tests/vboot/sign-configs-sha1-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its b/test/=
py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha256-pss-prod.its
> rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
> diff --git a/test/py/tests/vboot/sign-configs-sha256-pss.its b/test/py/te=
sts/vboot/sign-configs-sha256-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha256-pss.its
> rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-configs-sha256.its b/test/py/tests/=
vboot/sign-configs-sha256-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha256.its
> rename to test/py/tests/vboot/sign-configs-sha256-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-configs-sha384.its b/test/py/tests/=
vboot/sign-configs-sha384-rsa3072.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha384.its
> rename to test/py/tests/vboot/sign-configs-sha384-rsa3072.its
> diff --git a/test/py/tests/vboot/sign-images-sha1-pss.its b/test/py/tests=
/vboot/sign-images-sha1-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha1-pss.its
> rename to test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-images-sha1.its b/test/py/tests/vbo=
ot/sign-images-sha1-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha1.its
> rename to test/py/tests/vboot/sign-images-sha1-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-images-sha256-pss.its b/test/py/tes=
ts/vboot/sign-images-sha256-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha256-pss.its
> rename to test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-images-sha256.its b/test/py/tests/v=
boot/sign-images-sha256-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha256.its
> rename to test/py/tests/vboot/sign-images-sha256-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-images-sha384.its b/test/py/tests/v=
boot/sign-images-sha384-rsa3072.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha384.its
> rename to test/py/tests/vboot/sign-images-sha384-rsa3072.its
> --
> 2.43.0
>
