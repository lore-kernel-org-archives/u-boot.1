Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB38E6FE23
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 17:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19C88415E;
	Tue, 23 Dec 2025 18:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hOtZHQxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D2384164; Tue, 23 Dec 2025 18:43:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF60C84148
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 18:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766511781; x=1767116581; i=xypron.glpk@gmx.de;
 bh=AlwmIJcTx3iqcHBaRzxJ1FGTj7PYhmvh7n2dPIOQQJI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hOtZHQxAZlVkuj/vLQC1x42CTsIBT/epFZoV1vnajnHyuHvt93jCu0OhIJDEiMao
 dHUAzSivqOHJDlTcXlSpvVJ46dr4aIC4/HDrNXqBaJF1U0Kd5nPOnZSTpaPinVEj3
 omoqw2WuDT8X/Zlnu8YOdJQ6cvA9xag+0ZYBIjEeEYd1+L4v85PfWU96/w9HOjQB3
 TOS4b0HutwBjBn/f1/QncZvHi6S0KZ1r1Ghk/aeXWQ5ml+o8ljNqO549Tyfp00LWc
 vtwhqLS0GXfj3WmoZfJZm2gcxyux69G4OV+pCUUbcHXTKUN4kXf1meRnNxU+3lyH5
 lqqERGyr2mLCWKYTmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.125] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1vX0Tx0gxQ-007XPY; Tue, 23
 Dec 2025 18:43:01 +0100
Message-ID: <ac80d9cd-4890-4382-9ce6-2f237933d32c@gmx.de>
Date: Tue, 23 Dec 2025 18:43:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] env: Add single to redundant environment upgrade
 path
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <20251223143130.16266-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251223143130.16266-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:veRxDyZn58/RTewtTMng+2++MZH3e+Lx668x/vkpnewjfpI54mO
 oxHAxecrE06BdldNxtbRQz4Dix4P7/kKUAkNmO5cd/bGE+6iGveHeoTvIqTWrWVotAoTpHA
 Hvx8dWKyNa1cRLhMH+2lp3GcKAojMWLB5EBuvvQ67SlyJHhq6KdM9pS0T9Vfc7kg3eunRoA
 1vYjUB0yRtv0sqcE8IU3g==
UI-OutboundReport: notjunk:1;M01:P0:gXp+QMcTzp4=;sEw+a+NSguVnwHxr+TzQXEIBJL+
 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
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

On 12/23/25 15:31, Marek Vasut wrote:
> Add support for converting single-copy environment to redundant environm=
ent.
> In case CRC checks on both redundant environment copies fail, try one mo=
re
> CRC check on the primary environment copy and treat it as single environ=
ment.

Why would a CRC check suddenly succeed if it has failed before?

This needs some more explanation.

> If that check does pass, rewrite the single-copy environment into redund=
ant
> environment format, indicate the environment is valid, and import that a=
s
> usual primary copy of redundant environment. Follow up 'env save' will t=
hen
> store two environment copies and the system will continue to operate as
> regular redundant environment system.
>=20
> Add test which validates this upgrade path. The test starts with spi.bin
> which is pre-populated as single-copy environment and then upgrades that
> environment to dual-copy environment.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Gate the option behind ENV_REDUNDANT_UPGRADE
>      - Fix up mkenvimage path in env test
> ---
>   env/Kconfig               | 11 ++++++
>   env/common.c              | 31 +++++++++++++++-
>   test/py/tests/test_env.py | 74 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 115 insertions(+), 1 deletion(-)
>=20
> diff --git a/env/Kconfig b/env/Kconfig
> index 4430669964c..b312f9b5324 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -489,6 +489,17 @@ config ENV_REDUNDANT
>   	  which is used by env import/export commands which are independent o=
f
>   	  storing variables to redundant location on a non volatile device.
>  =20
> +config ENV_REDUNDANT_UPGRADE
> +	bool "Enable single-copy to redundant environment upgrade support"
> +	depends on ENV_REDUNDANT
> +	help
> +	  Normally, redundant environment is expected to always operate on
> +	  two copies of the environment. However, hardware that may have
> +	  originally shipped with single-copy environment can be upgraded

%s/with single-copy/with a single-copy/
%s/can be/that can be/

> +	  to redundant environment without loss of existing environment
> +	  content by correctly configuring the location of the redundant
> +	  environment copy and by enabling this option.

Why do we have to make this an option?
Shouldn't we always try to restore the environment?

> +
>   config ENV_FAT_INTERFACE
>   	string "Name of the block device for the environment"
>   	depends on ENV_IS_IN_FAT
> diff --git a/env/common.c b/env/common.c
> index 05e78d63874..b2adbe93dbe 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -473,14 +473,24 @@ int env_import(const char *buf, int check, int fla=
gs)
>   #ifdef CONFIG_ENV_REDUNDANT
>   static unsigned char env_flags;
>  =20
> +#define ENV_SINGLE_HEADER_SIZE	(sizeof(uint32_t))
> +#define ENV_SINGLE_SIZE		(CONFIG_ENV_SIZE - ENV_SINGLE_HEADER_SIZE)
> +
> +typedef struct {
> +	uint32_t	crc;			/* CRC32 over data bytes */
> +	unsigned char	data[ENV_SINGLE_SIZE];	/* Environment data */
> +} env_single_t;
> +
>   int env_check_redund(const char *buf1, int buf1_read_fail,
>   		     const char *buf2, int buf2_read_fail)
>   {
> -	int crc1_ok =3D 0, crc2_ok =3D 0;
> +	int crc1_ok =3D 0, crc2_ok =3D 0, i;
>   	env_t *tmp_env1, *tmp_env2;
> +	env_single_t *tmp_envs;
>  =20
>   	tmp_env1 =3D (env_t *)buf1;
>   	tmp_env2 =3D (env_t *)buf2;
> +	tmp_envs =3D (env_single_t *)buf1;
>  =20
>   	if (buf1_read_fail && buf2_read_fail) {
>   		puts("*** Error - No Valid Environment Area found\n");
> @@ -498,6 +508,25 @@ int env_check_redund(const char *buf1, int buf1_rea=
d_fail,
>   				tmp_env2->crc;
>  =20
>   	if (!crc1_ok && !crc2_ok) {

Do we really have a third location to copy from when both store 1 and=20
store 2 are defective? I would have expected that if a vendor provides a=
=20
single copy then exactly one of crc1_ok or crc2_ok is true and the other=
=20
is false.

Please, provide a documentation update explaining how this all works.

Best regards

Heinrich

> +		/*
> +		 * Upgrade single-copy environment to redundant environment.
> +		 * In case CRC checks on both environment copies fail, try
> +		 * one more CRC check on the primary environment copy and
> +		 * treat it as single-copy environment. If that check does
> +		 * pass, rewrite the single-copy environment into redundant
> +		 * environment format and indicate the environment is valid.
> +		 * The follow up calls will import the environment as if it
> +		 * was a redundant environment. Follow up 'env save' will
> +		 * then store two environment copies.
> +		 */
> +		if (CONFIG_IS_ENABLED(ENV_REDUNDANT_UPGRADE) && !buf1_read_fail &&
> +		    crc32(0, tmp_envs->data, ENV_SINGLE_SIZE) =3D=3D tmp_envs->crc) {
> +			for (i =3D ENV_SIZE - 1; i >=3D 0; i--)
> +				tmp_env1->data[i] =3D tmp_envs->data[i];
> +			tmp_env1->flags =3D 0;
> +			gd->env_valid =3D ENV_VALID;
> +			return 0;
> +		}
>   		gd->env_valid =3D ENV_INVALID;
>   		return -ENOMSG; /* needed for env_load() */
>   	} else if (crc1_ok && !crc2_ok) {
> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> index 48e31f19b3c..f8713a59ba9 100644
> --- a/test/py/tests/test_env.py
> +++ b/test/py/tests/test_env.py
> @@ -477,6 +477,22 @@ def mk_env_spi_flash(state_test_env):
>       utils.run_and_log(c, ['cp',  '-f', persistent, spi_flash_img])
>       return spi_flash_img
>  =20
> +def mk_env_spi_flash_single(state_test_env):
> +
> +    """Create an single-copy SPI NOR image with foo=3Dbar entry."""
> +    c =3D state_test_env.ubman
> +    filename =3D 'spi.bin'
> +    spi_flash_img =3D c.config.source_dir  + '/' + filename
> +
> +    try:
> +        mkenvimage =3D os.path.join(c.config.build_dir, 'tools/mkenvima=
ge')
> +        call('( echo foo=3Dbar | %s -s 8192 -p 0x00 - ; dd if=3D/dev/ze=
ro bs=3D2088960 count=3D1 2>/dev/null ) > %s' % ( mkenvimage , spi_flash_i=
mg ), shell=3DTrue)
> +    except CalledProcessError:
> +        call('rm -f %s' % spi_flash_img, shell=3DTrue)
> +        raise
> +
> +    return spi_flash_img
> +
>   @pytest.mark.boardspec('sandbox')
>   @pytest.mark.buildconfigspec('cmd_echo')
>   @pytest.mark.buildconfigspec('cmd_nvedit_info')
> @@ -574,6 +590,64 @@ def test_env_spi_flash(state_test_env):
>  =20
>       """Test ENV in SPI NOR on sandbox."""
>       c =3D state_test_env.ubman
> +    spi_flash_img =3D ''
> +    try:
> +        spi_flash_img =3D mk_env_spi_flash_single(state_test_env)
> +
> +        response =3D c.run_command('sf probe')
> +        assert 'SF: Detected m25p16 with page size 256 Bytes, erase siz=
e 64 KiB, total 2 MiB' in response
> +
> +        # force env location: SF
> +        response =3D c.run_command('env select SPIFlash')
> +        assert 'Select Environment on SPIFlash: OK' in response
> +
> +        response =3D c.run_command('env load')
> +        assert 'Loading Environment from SPIFlash... OK' in response
> +
> +        response =3D c.run_command('env print foo')
> +        assert 'foo=3Dbar' in response
> +
> +        response =3D c.run_command('env save')
> +        assert 'Saving Environment to SPIFlash' in response
> +
> +        response =3D c.run_command('env load')
> +        assert 'Loading Environment from SPIFlash... OK' in response
> +
> +        response =3D c.run_command('env print foo')
> +        assert 'foo=3Dbar' in response
> +
> +        response =3D c.run_command('env save')
> +        assert 'Saving Environment to SPIFlash' in response
> +
> +        response =3D c.run_command('env save')
> +        assert 'Saving Environment to SPIFlash' in response
> +
> +        response =3D c.run_command('env load')
> +        assert 'Loading Environment from SPIFlash... OK' in response
> +
> +        response =3D c.run_command('env print foo')
> +        assert 'foo=3Dbar' in response
> +
> +        # restore env location: NOWHERE (prio 0 in sandbox)
> +        response =3D c.run_command('env select nowhere')
> +        assert 'Select Environment on nowhere: OK' in response
> +
> +        response =3D c.run_command('env load')
> +        assert 'Loading Environment from nowhere... OK' in response
> +
> +        response =3D c.run_command('env info')
> +        assert 'env_valid =3D invalid' in response
> +        assert 'env_ready =3D true' in response
> +        assert 'env_use_default =3D true' in response
> +
> +        response =3D c.run_command('env info -p -d')
> +        assert 'Default environment is used' in response
> +        assert 'Environment cannot be persisted' in response
> +
> +    finally:
> +        if spi_flash_img:
> +            call('rm -f %s' % spi_flash_img, shell=3DTrue)
> +
>       spi_flash_img =3D ''
>       try:
>           spi_flash_img =3D mk_env_spi_flash(state_test_env)

