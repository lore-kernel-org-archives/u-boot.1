Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B48EE6FE23
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 17:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B828C84158;
	Tue, 23 Dec 2025 18:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Fzw2f+Qa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23F88415D; Tue, 23 Dec 2025 18:32:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9973884148
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 18:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766511169; x=1767115969; i=xypron.glpk@gmx.de;
 bh=WnwAEHZ0R0jHUhq0i3cdTZ1FhzusuNY13sh9bOAEHhw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Fzw2f+QaVWIZaMkyTqZvOMIejlAiYrNKmy0pSgwE1CbYgJS9tq9Lz560c5z+YsXw
 JBrVNEGd6F+C9vATbau1+YQ+rzLNM3LqE1XT6WRRctRgMSMJH6m4r72ahEXCN8H7n
 VP+15WPo/DBKYLWQ+fpaQAO48fPEcQ6nBp9RZik21fjaI8/QpV5bXeO+J+Kcb77US
 F9AZmzPV4TkKMmfngDv88jazm3ude1+AGGZGRN0xg5E+S9w0QM7kmak8KQXHcC3CQ
 2XjBJ8N5kUCCN+0x0nJgeIwNbMk8ExUUFObovxBIN02lY2bYFX7gmeeoUtfr3dXC3
 4EbnU1grZHw7ffz3YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.125] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1vEW6K0WaH-00PsnB; Tue, 23
 Dec 2025 18:32:49 +0100
Message-ID: <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
Date: Tue, 23 Dec 2025 18:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] test: env: Add test for environment storage in SPI
 NOR
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WqVZvgmql1kN5oB76pxZ9HNMQ98Lo9Ec7I9lPGAa+XODLEATRo2
 1I0jtPXrjkznmqGjk3++aZytdRpdJrr0z6170OENXQYT74bLOjb6/pTNUqmuOPYrmvt3VmK
 E2tRS8+78+rU+YzZ/R9OWrCnVx3dlJB8Tjpea4etBMmhXkTkZBMnL15mp+h7+vz7yqfGFxF
 KS9QZ2aClyVr5xtc46vjQ==
UI-OutboundReport: notjunk:1;M01:P0:n+s1Wc5y0HA=;gaPAxYMjFy5kaDlkMRFyJic4fBs
 +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
 A4aq1f8w=
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
> Add test for environment stored in SPI NOR. The test works in a very
> similar way to the current test for environment stored in ext4 FS,
> except it generates spi.bin file backing the SPI NOR.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: No change
> ---
>   test/py/tests/test_env.py | 99 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
>=20
> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> index 383e26c03b0..48e31f19b3c 100644
> --- a/test/py/tests/test_env.py
> +++ b/test/py/tests/test_env.py
> @@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
>       utils.run_and_log(c, ['cp',  '-f', persistent, fs_img])
>       return fs_img
>  =20
> +def mk_env_spi_flash(state_test_env):

Thank you for adding the test.

Unfortunately pylint doesn't like your code. Please have a look.

W0621: Redefining name 'state_test_env' from outer scope (line 95)=20
(redefined-outer-name)

> +
> +    """Create an empty SPI NOR image."""
> +    c =3D state_test_env.ubman
> +    filename =3D 'spi.bin'
> +    persistent =3D c.config.persistent_data_dir + '/' + filename
> +    spi_flash_img =3D c.config.source_dir  + '/' + filename
> +
> +    if os.path.exists(persistent):
> +        c.log.action('SPI NOR image file ' + persistent + ' already exi=
sts')
> +    else:
> +        try:
> +            utils.run_and_log(c, 'dd if=3D/dev/zero of=3D%s bs=3D1M cou=
nt=3D2' % persistent)

C0209: Formatting a regular string which could be an f-string=20
(consider-using-f-string)

> +        except CalledProcessError:
> +            call('rm -f %s' % persistent, shell=3DTrue)

C0209: Formatting a regular string which could be an f-string=20
(consider-using-f-string)

Except for the pylint issues the patch looks good to me.

Best regards

Heinrich

> +            raise
> +
> +    utils.run_and_log(c, ['cp',  '-f', persistent, spi_flash_img])
> +    return spi_flash_img
> +
>   @pytest.mark.boardspec('sandbox')
>   @pytest.mark.buildconfigspec('cmd_echo')
>   @pytest.mark.buildconfigspec('cmd_nvedit_info')
> @@ -544,6 +564,85 @@ def test_env_ext4(state_test_env):
>           if fs_img:
>               call('rm -f %s' % fs_img, shell=3DTrue)
>  =20
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('cmd_echo')
> +@pytest.mark.buildconfigspec('cmd_nvedit_info')
> +@pytest.mark.buildconfigspec('cmd_nvedit_load')
> +@pytest.mark.buildconfigspec('cmd_nvedit_select')
> +@pytest.mark.buildconfigspec('env_is_in_spi_flash')
> +def test_env_spi_flash(state_test_env):
> +
> +    """Test ENV in SPI NOR on sandbox."""
> +    c =3D state_test_env.ubman
> +    spi_flash_img =3D ''
> +    try:
> +        spi_flash_img =3D mk_env_spi_flash(state_test_env)
> +
> +        # force env location: SF
> +        response =3D c.run_command('env select SPIFlash')
> +        assert 'Select Environment on SPIFlash: OK' in response
> +
> +        response =3D c.run_command('env save')
> +        assert 'Saving Environment to SPIFlash' in response
> +
> +        response =3D c.run_command('env load')
> +        assert 'Loading Environment from SPIFlash... OK' in response
> +
> +        response =3D c.run_command('env info')
> +        assert 'env_valid =3D valid' in response
> +        assert 'env_ready =3D true' in response
> +        assert 'env_use_default =3D false' in response
> +
> +        response =3D c.run_command('env info -p -d')
> +        assert 'Environment was loaded from persistent storage' in resp=
onse
> +        assert 'Environment can be persisted' in response
> +
> +        response =3D c.run_command('env info -d -q')
> +        assert response =3D=3D ""
> +        response =3D c.run_command('echo $?')
> +        assert response =3D=3D "1"
> +
> +        response =3D c.run_command('env info -p -q')
> +        assert response =3D=3D ""
> +        response =3D c.run_command('echo $?')
> +        assert response =3D=3D "0"
> +
> +        response =3D c.run_command('env erase')
> +        assert 'OK' in response
> +
> +        response =3D c.run_command('env load')
> +        assert 'Loading Environment from SPIFlash... ' in response
> +        assert 'bad CRC, using default environment' in response
> +
> +        response =3D c.run_command('env info')
> +        assert 'env_valid =3D invalid' in response
> +        assert 'env_ready =3D true' in response
> +        assert 'env_use_default =3D true' in response
> +
> +        response =3D c.run_command('env info -p -d')
> +        assert 'Default environment is used' in response
> +        assert 'Environment can be persisted' in response
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
>   def test_env_text(ubman):
>       """Test the script that converts the environment to a text file"""
>  =20

