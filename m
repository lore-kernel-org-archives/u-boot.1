Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7FCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EDA84859;
	Mon, 25 May 2026 17:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DASLTleR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E0A848E7; Mon, 25 May 2026 17:31:48 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904F7846E1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-95cc8ac98bfso1915284241.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723104; cv=none;
 d=google.com; s=arc-20240605;
 b=EMMmdZPulfulLa4k8wneaZ24HFHFssslSQ6BJU5VUlYxDzekaOcpt03gp9bilVhLRB
 Xsa4/X6wO/lpTJ9eOaTlx/BiOCVc9wNBURoBTvFpmxnTjfQh76EJ5Mktt2XoYCdJzlm9
 q21XnN4Je/7R/BmNgtAOKmZ/6cxkMZfTNJRUEAFromb0iajkXNV3dwwxpqfFSiXs6dQj
 42zkoWKWsy4GbHrKpobAUtjMw2Tie40cmw5dy+TmYGlPCo6BpS/KR3LOSZHeibyIT2Bi
 Pny603ynLJVAnajp/e9fgDDBR74odm1Vh1JPNdHT3XcP0tgx75X157NgfKORfQfLvSUr
 pcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UeJmUqxj6zn4WbNGqCxk1oD2IeIMSZEYoR2AMkxvH0M=;
 fh=wxdiqBwH1xwqUy2fF0NtZXzAom3AE0pNqyFRvblFhH4=;
 b=fg9EwkZLQqiPNJI40/37O0yNvBDX420ErtvYa06J6+sqwfCPJdQkMHTf6PXXtDXqa/
 aibn/iINoerqZKGITfx+xDAtswBtTcdoJkBhXcShrO9IVyUsfpvtxnJvAlroEYRSBNO6
 9bp125/lqSpVvyjFA2jHJ6/X5DhIWHrHipMTONg4ejEjV2RfJwPcmjxvt6OaNWUYIvMh
 3cX9ndt0qTYJxFbWQlQQcLs5k0h+4SG7j5JSH97qCAOfX7F6/Rz1fajsKHkrUPXfacdp
 N8RTqg9WGmSOnWSCqGRtPBEv+H0RdGcEIjNT7cWXwnKOGG4dkbf89NdbwmsZSHPsgtzb
 Z2dw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779723104; x=1780327904; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeJmUqxj6zn4WbNGqCxk1oD2IeIMSZEYoR2AMkxvH0M=;
 b=DASLTleRnnGs/Q03LoQtioBRvKUBigpdr9KD8B5pAiu2Ge14jqbiPu0j76AFGnt7v0
 UB+wpGNZaff0zM5uHw99pMQM15+cLNKLdhpEUnK/0WhPXHNvXPVWxu1QVLpYptZjUPvE
 20ByHaW1h0iFYp71RilCUiZI3uvpX7yQ1IwaF2ZbLwAn3vxKLJ7SMdUiFZeWM3YcffyF
 PI/HVXCq74Z6AnNhw7HO0OLL0SJ5vrZEljCPKCjAg+C8t1F4DvztXQFVN0j2U8D65inX
 rs0pTZwtTr4GBttkVRPxEa9LNKlTc42ZCijKOqfoBIuitGfhWpD30n1bnxWsAiQD6f59
 mjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723104; x=1780327904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UeJmUqxj6zn4WbNGqCxk1oD2IeIMSZEYoR2AMkxvH0M=;
 b=R5lol4iHzq2Sj1cozxonH+CNPakK7pn75SLjynO6BkTNp8kas1ZT1w/qjSXNA3sGUX
 uXNsrzgxZrWkRc8KlAF+8Zqwy/W6CRM8gIv7HaZAZ65/Pu69Sa9FZb6OPWEZpEDqIa2W
 6X4vvwwybCcnoDQogVnC/c82gK+pjkTdnIJ4IiDjINsXyluyooIwv18b+eXB8Da0j1iU
 JKjVUsam0tsCfULfiH8eLXKidhLpzY2cjoXosbB5vXo+Kkx/KG1JXH9YnrLQIdaOFvbZ
 VQmiMU1l38BOqCPAkp+GIOxNJ+5Y4Nqgymu5RrtEzm8xaP2J0Xl+J9GixE+Afnj+8U4e
 8SpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Zk402p/6urw5XCWz7/Nb4NbeiVUI8Y+adSkoOCauk8+EEuD9GoFsFbDtjd1r93f13SxBft4U=@lists.denx.de
X-Gm-Message-State: AOJu0YwLuqC661Aefz64hHGpGNGvGdMmg99T59NAoNKbjatxMQfF9/7c
 ZRWwfwf2XxVgfctpxgEr5q593+aWR4rKOyS5PRpLGjGWzQ7JSWmbar+svJO/78feK9yJdc/pzmS
 iyGqP9HU3HaYynuS18nfoROxMbWezYmI=
X-Gm-Gg: Acq92OHCgkMJRmBUS4K78LRjF9rhnp7HkqElkYmkmyDCl3K76JFVhT8Me5GRA4Je2qz
 bMib4/F6TgDfLddDlkrS8wQ/Kn2gHFWvmeK1JmjgDWoJYk2sQa/utR41k6aw6dcIr8frppdkFOe
 2il8LkYOVSydoSDY8mJgUMyNBXDoHFoXnVapnMcBXivvFOTOYiJQLSOKuC9R3cLE8n5OE7PzMTo
 cWzRvYo/DApdqfULF8j/WwRDznIihpHw+qNqG6+b0PCKFKMecbxNrueG3nMGQVe7xh7gyaj2Ebt
 /jQ5W7rj
X-Received: by 2002:a05:6122:f84:b0:56b:8023:b89e with SMTP id
 71dfb90a1353d-5865fcf7d81mr8131895e0c.6.1779723104082; Mon, 25 May 2026
 08:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-8-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-8-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:31:32 -0400
X-Gm-Features: AVHnY4Jj5A2O-ZuNrWtulZ8nLmvhRJ-OWWiWcD_BNERpk5-mu5pyBZko2HnHTwM
Message-ID: <CAMDkj5yxkP1EKVtVS8xkBKPM+HMWD2=AJq3Ss+mQisAJsi2Mhw@mail.gmail.com>
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

Hi

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
