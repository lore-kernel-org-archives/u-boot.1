Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9FEC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 19:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B77A84D3C;
	Thu, 16 Jul 2026 21:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kiUk8Amn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5144A84D55; Thu, 16 Jul 2026 21:56:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF2C84BBF
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 21:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784231765; x=1784836565; i=xypron.glpk@gmx.de;
 bh=Zijs3K4z4s4KBkW6YwSpLm1R+yGa2nZo3wCg9ayodqI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kiUk8AmnMkZwwNucMZRqX49wHCTfcvi3aiyGqMatENy2nrHz7UHpusfK/70XEerp
 K8ARPrspk81yBtDwhsNiBX7EfoTLKoXCK+pyyB6+eixgvn3mQk2AfhxSH741sJpWF
 aa5ITrTq1+kyf2aJMzKBORxCZWS4X7Hk3ahPSYP9Fcae4Ew/OMiazsbPOdzpt9Xn9
 8BvetaoHq7wpS/L61wYyE9ifgRrXTmHoYEmEnWJctm2WPq2K0pajwUuaIW/KrgQW0
 v3miCiNu4LIkF0ZwEty5Gjlvss/EyVIov7m75L1Q6uDp2nunRmX5uUncstWWE77q0
 609ylRGMnLrjPWDtwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdefJ-1xJVtE1t2n-00cwom; Thu, 16
 Jul 2026 21:56:05 +0200
Message-ID: <3e8d019c-a535-401a-9a7b-a012f3deca45@gmx.de>
Date: Thu, 16 Jul 2026 21:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] test: check default GUID selection of signature
 database variables
To: Aristo Chen <aristo.chen@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260714094902.438079-1-aristo.chen@canonical.com>
 <20260714094902.438079-3-aristo.chen@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260714094902.438079-3-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVDafi1Cjy4fAWRSkDVxNJkhM5V98eWP/iTIstlJ//X7FLIPaMO
 kUp7rYEdvcsSY6dn3uzfCryfFURj9yUqWAtY4Yk10G+yFVFxH31sZ8IHMHDRShSoJmEZad8
 oFexKnFB2bajk8OCJMC88P0MyA279U5uCOu6GRBNzSc9mtiXpgE7CvF9fgOMoxZva6rPPlG
 kJVk635sBuHHURXCPGw6g==
UI-OutboundReport: notjunk:1;M01:P0:CGAOPsLonl0=;IMplpLLuogoNrKMEaQhzZHnND5Y
 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
 ub/KrErrc1geYpTdmrtdsB3PSo39qY7ydQ==
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

On 7/14/26 11:49, Aristo Chen wrote:
> The name to GUID mapping that "env set -e" applies when no -guid
> option is given was not covered by any test, which is how the wrong
> default GUID for "dbr" went unnoticed until the previous commit.
>=20
> Add a test case that enrolls each of db, dbx, dbt and dbr in setup
> mode without an explicit -guid option and checks that every variable
> is created under the image security database GUID and not under the
> global variable GUID. This is also the first coverage of dbt and dbr
> anywhere under test/. The enrollment happens in setup mode because
> once secure boot is enabled, efi_variable_authenticate() only accepts
> writes to PK, KEK, db and dbx.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   test/py/tests/test_efi_secboot/conftest.py    |  8 +++++
>   .../py/tests/test_efi_secboot/test_authvar.py | 30 +++++++++++++++++++
>   2 files changed, 38 insertions(+)
>=20
> diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/=
test_efi_secboot/conftest.py
> index 76b8f9fa0a3..0755497d46d 100644
> --- a/test/py/tests/test_efi_secboot/conftest.py
> +++ b/test/py/tests/test_efi_secboot/conftest.py
> @@ -96,6 +96,14 @@ def efi_boot_env(request, ubman):
>           check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.=
crt -k KEK.key dbx db.esl dbx_db.auth'
>                      % (mnt_point, EFITOOLS_PATH),
>                      shell=3DTrue)
> +        # dbt (with TEST_db certificate)
> +        check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.c=
rt -k KEK.key dbt db.esl dbt.auth'
> +                   % (mnt_point, EFITOOLS_PATH),
> +                   shell=3DTrue)
> +        # dbr (with TEST_db certificate)
> +        check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.c=
rt -k KEK.key dbr db.esl dbr.auth'
> +                   % (mnt_point, EFITOOLS_PATH),
> +                   shell=3DTrue)
>  =20
>           # Copy image
>           check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
> diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py/te=
sts/test_efi_secboot/test_authvar.py
> index 7b45f8fb814..45350b19b06 100644
> --- a/test/py/tests/test_efi_secboot/test_authvar.py
> +++ b/test/py/tests/test_efi_secboot/test_authvar.py
> @@ -279,3 +279,33 @@ class TestEfiAuthVar(object):
>               output =3D ubman.run_command(
>                   'printenv -e SetupMode')
>               assert '00000000: 01' in output
> +
> +    def test_efi_var_auth6(self, ubman, efi_boot_env):
> +        """
> +        Test Case 6 - Default GUID of signature database variables
> +        """
> +        ubman.restart_uboot()
> +        disk_img =3D efi_boot_env
> +        with ubman.log.section('Test Case 6a'):
> +            # Test Case 6a, install signature database variables in set=
up
> +            # mode without -guid
> +            output =3D ubman.run_command_list([
> +                'host bind 0 %s' % disk_img,
> +                'printenv -e SetupMode'])
> +            assert '00000000: 01' in ''.join(output)
> +
> +            for var in ('db', 'dbx', 'dbt', 'dbr'):

Thank you Aristo for updating the test.

Should we check the GUID of PK and KEK too?

Best regards

Heinrich

> +                output =3D ubman.run_command_list([
> +                    'fatload host 0:1 4000000 %s.auth' % var,
> +                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize %s'=
 % var,
> +                    'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00=
e67656f %s' % var])
> +                assert 'Failed to set EFI variable' not in ''.join(outp=
ut)
> +                assert '%s:' % var in ''.join(output)
> +
> +        with ubman.log.section('Test Case 6b'):
> +            # Test Case 6b, variables must not exist under the global
> +            # variable GUID
> +            for var in ('db', 'dbx', 'dbt', 'dbr'):
> +                output =3D ubman.run_command(
> +                    'printenv -e -n -guid 8be4df61-93ca-11d2-aa0d-00e09=
8032b8c %s' % var)
> +                assert '\"%s\" not defined' % var in output

