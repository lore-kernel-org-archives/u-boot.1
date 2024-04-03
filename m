Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387FCD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 14:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A4F88125;
	Wed,  3 Apr 2024 16:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="A5vzz701";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D57F880D6; Wed,  3 Apr 2024 16:54:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D239880D6
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 16:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712156084; x=1712760884; i=xypron.glpk@gmx.de;
 bh=l19gvoc80c4Ht9jHiflRXIhBy41Egq/YfwcJvDh1ZWA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=A5vzz701RHrpxAI8OjPKNW6HIZk5GC+hzMlonEg2rxLCXIX4J98Sm/+y0LDPN4mP
 llFQhuNHTQiyxf6ubFf1hjFITGx7o9JnuwnjSwnXLrUwP9Ruls5p5W5nNuCXRkAKG
 aahGh3EXdpYHcwlMhjh6qQLdiEy7EHbQWtF3i+EnDXm2TuAEwdrbWadlqaDcXHPCk
 NkXyE+fCQXiRArXikGu5WI06l/tORnG7b1f23pC5h+3BXSIYU2qQTq8326djhaOaZ
 k+GGTZ6tQQ1L5BOYKirXAIJdVDEHLCx8K8toRL+aRCLjjcWMz5yXuiIwEXadYQ9SW
 OdC5NhKoH8SIFlVIBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1sbEeF3Ghg-00ppyU; Wed, 03
 Apr 2024 16:54:43 +0200
Message-ID: <e2262678-5a0b-4130-af8d-5e3b93b16aaa@gmx.de>
Date: Wed, 3 Apr 2024 16:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240327140628.106143-1-o451686892@gmail.com>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Masahisa Kojima <kojima.masahisa@socionext.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240327140628.106143-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FDpyuxJx5I4Ejvp23eRjTO2RMmfQtyE0sBTlQfYmdjOAALG0yxC
 uXMeBwtglccZ4nw7dKdO/Jf4+9NaWHD1yJ3kCOCHyWfPHOzmqexeIs5IwKDXMfPtklXy1r7
 Gzsag263MXoXS/Ughb933VQUaDP6FfVVPWEg7pl+IVuWQf6ia+oULHohAh6YQ9dUR2umbVQ
 8WB+KIW0NLw1iDvaFitJg==
UI-OutboundReport: notjunk:1;M01:P0:YgqOwh8dtDo=;qsJbCqKfhf7wpEpktgxFtn90BCm
 AUpKpYGVRcQ2U6FGFFuDjzN88p1y1mA4MxlWdA86NiEtUa6xLSGBdJXh54C7fu95jGyQOkt0u
 dPVdd+ontuqrt8YjQp2ezP9ju4mpwiEEs3/AhidsuEmvjZdMrjd3eFS3vs6ztOsQEwSy6rBnM
 6nMvxwt96Hj7U9XMG9xFepyCkOHDVpDZ++4GDqmU8QHILIGTwAxKDbm5F+opHtjgxiTkdoUWe
 7w4IiD1KAnEF8DhVWhcHot3phRk6Ap8iHueQOn6tdZVAxWBr4P7x197Vt8w/yXfARE5h6lNDP
 o8Euofqft578UIQ+oN/U2vBLseLKzuKG2EvhR+K+9Dhu0mmUcJg02FdbhWLfvlhJZnNRXSfch
 gUAnH/pCDbWmj7d+AM2yN6Bn98pZoJEYSAuOv2zLEE8uw6yR5xmfLWhe1vYclF50lfe/S5qvq
 yEJaj4wl0WOGzVK7K/mgXiV2FXFABDal5Qf/SQ4fY/AFcRW5aRNUCbHg08aV/puT75uOVD4uD
 V6Ynv/rcyW53rcreEZTEPo5PsWxEH5tyM13QK6jE+qKDiE+ex/8sJcC4FTPoLsHuBsHqntFPT
 uxbT3DVLI/ZlbNjsM+zgCxsjXmP+YJsPWfUFrd48XDwSXTP84jm7kpG5UqSkGWO4cR0tZVt0l
 VFND+t/8k86rwP5JqoJQo6/87XkpZNXsxhQUKqnqAArioIL25DLZfbqnXGOhux5HacibxUq3k
 PmtnmFnRxnyi6bcX2G6zHuRipxd4IqVSzQ1lEWP8AlSXx33YydP1if/EBC/nYLXPrlLRlBLwP
 xq76bEMDdLCof0+paeA7WMUAEuEBY4HkapO4xFiBB4ifo=
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

On 27.03.24 15:06, Weizhao Ouyang wrote:
> According to UEFI v2.10 spec section 8.2.6, if a caller invokes the
> SetVariables() service, it will produce a digest from hash(VariableName,
> VendorGuid, Attributes, TimeStamp, DataNew_variable_content), then the
> firmware that implements the SetVariable() service will compare the
> digest with the result of applying the signer=E2=80=99s public key to th=
e
> signature. For EFI variable append write, efitools sign-efi-sig-list has
> an option "-a" to add EFI_VARIABLE_APPEND_WRITE attr, and u-boot will
> drop this attribute in efi_set_variable_int(). So if a caller uses
> "sign-efi-sig-list -a" to create the authenticated variable, this append
> write will fail in the u-boot due to "hash check failed".

Currently U-Boot does not allow to use EFI_VARIABLE_APPEND_WRITE for any
non-existent variable, signed or not. This does not match the EDK II
behavior.

There is a patch queued for this issue:

[PATCH v2] efi_loader: fix append write behavior to non-existent variable
https://lore.kernel.org/u-boot/20240402090950.3819705-1-kojima.masahisa@so=
cionext.com/

Could you, please, retest with that patch.

>
> This patch resumes writing the EFI_VARIABLE_APPEND_WRITE attr to ensure
> that the hash check is correct. And also update the "test_efi_secboot"
> test case to compliance with the change.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   lib/efi_loader/efi_variable.c                  |  3 +--
>   test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
>   test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
>   test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
>   4 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index 40f7a0fb10..f41aa8f9ad 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -259,7 +259,6 @@ efi_status_t efi_set_variable_int(const u16 *variabl=
e_name,
>   	/* check if a variable exists */
>   	var =3D efi_var_mem_find(vendor, variable_name, NULL);
>   	append =3D !!(attributes & EFI_VARIABLE_APPEND_WRITE);
> -	attributes &=3D ~(u32)EFI_VARIABLE_APPEND_WRITE;

According to the UEFI specification for GetVariable():

"The EFI_VARIABLE_APPEND_WRITE attribute will never be set in the
returned Attributes bitmask parameter."

We don't want to set EFI_VARIABLE_APPEND_WRITE in a variable when
calling efi_var_mem_ins().

>   	delete =3D !append && (!data_size || !attributes);
>
>   	/* check attributes */
> @@ -275,7 +274,7 @@ efi_status_t efi_set_variable_int(const u16 *variabl=
e_name,
>
>   		/* attributes won't be changed */
>   		if (!delete &&
> -		    ((ro_check && var->attr !=3D attributes) ||
> +		    ((ro_check && var->attr !=3D (attributes & ~(u32)EFI_VARIABLE_APP=
END_WRITE)) ||
>   		     (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY)

The (u32) conversions are superfluous.

Best regards

Heinrich

>   				    !=3D (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))) {
>   			return EFI_INVALID_PARAMETER;
> diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/=
test_efi_secboot/conftest.py
> index ff7ac7c810..0fa0747fc7 100644
> --- a/test/py/tests/test_efi_secboot/conftest.py
> +++ b/test/py/tests/test_efi_secboot/conftest.py
> @@ -64,6 +64,12 @@ def efi_boot_env(request, u_boot_config):
>           check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt db1.es=
l; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.esl db=
1.auth'
>                      % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
>                      shell=3DTrue)
> +        # db2 (APPEND_WRITE)
> +        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -=
subj /CN=3DTEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
> +                   % mnt_point, shell=3DTrue)
> +        check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2.esl=
; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
> +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
> +                   shell=3DTrue)
>           # dbx (TEST_dbx certificate)
>           check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 =
-subj /CN=3DTEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
>                      % mnt_point, shell=3DTrue)
> @@ -84,6 +90,10 @@ def efi_boot_env(request, u_boot_config):
>           check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db1.cr=
t dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK.key=
 dbx dbx_hash1.crl dbx_hash1.auth'
>                      % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
>                      shell=3DTrue)
> +        # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WRITE)
> +        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2.crt=
 dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_hash2=
.crl dbx_hash2.auth'
> +                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
> +                   shell=3DTrue)
>           # dbx_db (with TEST_db certificate)
>           check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.=
crt -k KEK.key dbx db.esl dbx_db.auth'
>                      % (mnt_point, EFITOOLS_PATH),
> diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py/te=
sts/test_efi_secboot/test_authvar.py
> index f99b8270a6..d5aeb65048 100644
> --- a/test/py/tests/test_efi_secboot/test_authvar.py
> +++ b/test/py/tests/test_efi_secboot/test_authvar.py
> @@ -183,7 +183,7 @@ class TestEfiAuthVar(object):
>               assert 'db:' in ''.join(output)
>
>               output =3D u_boot_console.run_command_list([
> -                'fatload host 0:1 4000000 db1.auth',
> +                'fatload host 0:1 4000000 db2.auth',
>                   'setenv -e -nv -bs -rt -a -i 4000000:$filesize db'])
>               assert 'Failed to set EFI variable' in ''.join(output)
>
> @@ -197,7 +197,7 @@ class TestEfiAuthVar(object):
>           with u_boot_console.log.section('Test Case 3c'):
>               # Test Case 3c, update with correct signature
>               output =3D u_boot_console.run_command_list([
> -                'fatload host 0:1 4000000 db1.auth',
> +                'fatload host 0:1 4000000 db2.auth',
>                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'=
,
>                   'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67=
656f db'])
>               assert 'Failed to set EFI variable' not in ''.join(output)
> diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tes=
ts/test_efi_secboot/test_signed.py
> index 2f862a259a..34719ad1f2 100644
> --- a/test/py/tests/test_efi_secboot/test_signed.py
> +++ b/test/py/tests/test_efi_secboot/test_signed.py
> @@ -177,7 +177,7 @@ class TestEfiSignedImage(object):
>           with u_boot_console.log.section('Test Case 5b'):
>               # Test Case 5b, authenticated if both signatures are verif=
ied
>               output =3D u_boot_console.run_command_list([
> -                'fatload host 0:1 4000000 db1.auth',
> +                'fatload host 0:1 4000000 db2.auth',
>                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'=
])
>               assert 'Failed to set EFI variable' not in ''.join(output)
>               output =3D u_boot_console.run_command_list([
> @@ -201,7 +201,7 @@ class TestEfiSignedImage(object):
>           with u_boot_console.log.section('Test Case 5d'):
>               # Test Case 5d, rejected if both of signatures are revoked
>               output =3D u_boot_console.run_command_list([
> -                'fatload host 0:1 4000000 dbx_hash1.auth',
> +                'fatload host 0:1 4000000 dbx_hash2.auth',
>                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize dbx=
'])
>               assert 'Failed to set EFI variable' not in ''.join(output)
>               output =3D u_boot_console.run_command_list([
> @@ -223,7 +223,7 @@ class TestEfiSignedImage(object):
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
>                   'fatload host 0:1 4000000 PK.auth',
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
> -                'fatload host 0:1 4000000 db1.auth',
> +                'fatload host 0:1 4000000 db2.auth',
>                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'=
,
>                   'fatload host 0:1 4000000 dbx_hash1.auth',
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
> @@ -300,7 +300,7 @@ class TestEfiSignedImage(object):
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
>                   'fatload host 0:1 4000000 PK.auth',
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
> -                'fatload host 0:1 4000000 db1.auth',
> +                'fatload host 0:1 4000000 db2.auth',
>                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'=
,
>                   'fatload host 0:1 4000000 dbx_hash384.auth',
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
> @@ -323,7 +323,7 @@ class TestEfiSignedImage(object):
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
>                   'fatload host 0:1 4000000 PK.auth',
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
> -                'fatload host 0:1 4000000 db1.auth',
> +                'fatload host 0:1 4000000 db2.auth',
>                   'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'=
,
>                   'fatload host 0:1 4000000 dbx_hash512.auth',
>                   'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])

