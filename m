Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD2DC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B59C48853F;
	Thu, 20 Jun 2024 15:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IbaleXwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3746588540; Thu, 20 Jun 2024 15:38:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B64884F9
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718890693; x=1719495493; i=xypron.glpk@gmx.de;
 bh=Ra2Jh0IMeWGrgylT6P9Ct1v3w7DtNa9gieG51AV9DiY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IbaleXwFqtPTZevFVdp18TwjqP3XBmcCd/vh8y9u/UolNen1e//riSo3ty8xIZTr
 bKeP0CZIBxosaOezT7O3CM9ZsA7Wtk1uJDtVqbUv8rlx7/lokmMa1NtRjWr8rKlKP
 Nd1/5eadzV01XPs2tIx/x/wNkhmU3clWge3trzaIIOCWKuT/mTPGRwPnHAEe+OueL
 fFDYfB5KIr13mWp1gc23dOPP5qVatyzBDI4RYHapfEzJUHhhGE3S/82KTLjEoXn1I
 rsk6tKtdzFllyiztPrDmX8tFunmWibR7oW65I4plsTEOXW5zZBnFlf2jM0FkiyvZH
 fLn7zZmlbL2DNu7aGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1rspUH00pA-00R5qW; Thu, 20
 Jun 2024 15:38:13 +0200
Message-ID: <d2526c98-8198-4b8b-ab10-20bda0151da1@gmx.de>
Date: Thu, 20 Jun 2024 15:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240620131937.1130446-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kAEWzJj7EXxmWPTvzLw0645+3c8NHIJXvkfMjaZEmqQiZmyYdd3
 bVrvMXy45SwmeKSTpYsAEMrkWRg/Bbl4Zw/7YwA/eZahQjDy0b9YGa3vzKLn4/czL3g3ANv
 efP0cDGd5WiVpwyCK4Cigt4GQ46jlG0Zodwv4+bKtTic3PpBYhO/llphkhVGlopAlk9pL8e
 lo/HqOdsDU48I6puWbXWg==
UI-OutboundReport: notjunk:1;M01:P0:3z8zksbDKiA=;KhihSdTwPR8z1F+zcj750OTghIm
 sXik11m56j+iHGZOhdWnXX0cRiXxiQ/Fc4Bl7W+7LPFmeM6TMUO4SiM06rFCzZ9ZsuHeCEYlI
 LXySBDMqvL46c5kwGtg79vfAT4MlIHZWycxzwhSAQYJ+sek4DvlWgPN5lNiCl3Hn4eRA5QoeA
 YuzqiQOIKLiTL3XvSygGa/LjDBgcBw4LOPjIHhED11kNBnuWrCkul79bpy/MQFmCo1ect4VIR
 shN17ATXxzRur3iE7sXtuRkF7i/F49JdGctmLHnqJ4Ttvero1J80LO7dPMXNQ/aerIKLkzoi8
 b7JBKO63gMZwro+z1gxk0S1bBC1u9umshJQlsep2Vpj6cioz/JpOfWRziXKQGEKvmAAlIB7fi
 /fGuGER2BmFg6E747qnkvnxlYw0UbKUTS1Z3KKVCizsSK+ROtBQymYXbU/4lYQ6Zruvq9Bx2L
 HWMkHojo/El3IDnsc9RZdyI9ZdTUhUdbhiX5jkS1QVMrZ0vjStDaNQ0274Itp2fge85Uzm66D
 +J6jcnf25caajoxFropR9bXCeEg7qRMneLwQCVIBEUb2sRz4RBD7+2ePrgfghyAENGLcNbeHd
 AFnH7VNGgMLMQ8FvlyoLl/fmihgKk6aubgsMe/sWzwiQIQzAnz7vmSWrrLAX5KgY/I3kotrMX
 SXq/rsu0737RsajIG8XGDOURNTeKCMSJj8F66qrqlro40fL1WKY826BxtPKrVtUF7KvpPLotQ
 Nj7Lepb3pwcEDkr1x/00nNHwAjqnY20ZSZYXuD84UokcA0h7eoaMDSSLqvZiLWfGNQSJ/QmMj
 7vtMDeCgZlwGJcm5bszODlXKf4Sev+3iwF8GjwW2NRN9Q=
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

On 20.06.24 15:19, Simon Glass wrote:
> The Python virtualenv tool sets up a few things in the envronment,

Nits

%s/envronment/environment/

> putting its path first in the PATH environment variable and setting up
> a sys.prefix different from the sys.base_prefix value.
>
> At present buildman puts the toolchain path first in PATH so that it can
> be found easily during the build. For sandbox this causes problems since
> /usr/bin/gcc (for example) results in '/usr/bin' being prepended to the
> PATH variable. As a result, the venv is partially disabled.

If you want to remember a PATH, why don't you use a differnet variable
like U_BOOT_TOOLPATH to convey this information instead of manipulating
the PATH variable?

>
> The result is that sandbox builds within a venv ignore the venv, e.g.
> when looking for packages.
>
> Correct this by detecting the venv and adding the toolchain path after
> the venv path.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   tools/buildman/bsettings.py |  3 ++
>   tools/buildman/test.py      | 83 +++++++++++++++++++++++++++++++++++++
>   tools/buildman/toolchain.py | 31 ++++++++++++--
>   3 files changed, 113 insertions(+), 4 deletions(-)
>
> diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
> index e225ac2ca0f..1be1d45e0fa 100644
> --- a/tools/buildman/bsettings.py
> +++ b/tools/buildman/bsettings.py
> @@ -31,6 +31,9 @@ def setup(fname=3D''):
>   def add_file(data):
>       settings.readfp(io.StringIO(data))
>
> +def add_section(name):
> +    settings.add_section(name)
> +
>   def get_items(section):
>       """Get the items from a section of the config.
>
> diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> index f92add7a7c5..83219182fe0 100644
> --- a/tools/buildman/test.py
> +++ b/tools/buildman/test.py
> @@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
>           self.toolchains.Add('arm-linux-gcc', test=3DFalse)
>           self.toolchains.Add('sparc-linux-gcc', test=3DFalse)
>           self.toolchains.Add('powerpc-linux-gcc', test=3DFalse)
> +        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=3DFalse)
>           self.toolchains.Add('gcc', test=3DFalse)
>
>           # Avoid sending any output
> @@ -747,6 +748,88 @@ class TestBuild(unittest.TestCase):
>           self.assertEqual([
>               ['MARY=3D"mary"', 'Missing expected line: CONFIG_MARY=3D"m=
ary"']], result)
>
> +    def call_make_environment(self, tchn, full_path, in_env=3DNone):
> +        """Call Toolchain.MakeEnvironment() and process the result
> +
> +        Args:
> +            tchn (Toolchain): Toolchain to use
> +            full_path (bool): True to return the full path in CROSS_COM=
PILE
> +                rather than adding it to the PATH variable
> +            in_env (dict): Input environment to use, None to use curren=
t env
> +
> +        Returns:
> +            tuple:
> +                dict: Changes that MakeEnvironment has made to the envi=
ronment
> +                    key: Environment variable that was changed
> +                    value: New value (for PATH this only includes compo=
nents
> +                        which were added)
> +                str: Full value of the new PATH variable
> +        """
> +        env =3D tchn.MakeEnvironment(full_path, env=3Din_env)
> +
> +        # Get the original environment
> +        orig_env =3D dict(os.environb if in_env is None else in_env)
> +        orig_path =3D orig_env[b'PATH'].split(b':')
> +
> +        # Find new variables
> +        diff =3D dict((k, env[k]) for k in env if orig_env.get(k) !=3D =
env[k])
> +
> +        # Find new / different path components
> +        diff_path =3D None
> +        new_path =3D None
> +        if b'PATH' in diff:
> +            new_path =3D diff[b'PATH'].split(b':')
> +            diff_paths =3D [p for p in new_path if p not in orig_path]
> +            diff_path =3D b':'.join(p for p in new_path if p not in ori=
g_path)
> +            if diff_path:
> +                diff[b'PATH'] =3D diff_path
> +            else:
> +                del diff[b'PATH']
> +        return diff, new_path
> +
> +    def test_toolchain_env(self):
> +        """Test PATH and other environment settings for toolchains"""
> +        # Use a toolchain which has a path, so that full_path makes a d=
ifference
> +        tchn =3D self.toolchains.Select('aarch64')
> +
> +        # Normal cases
> +        diff =3D self.call_make_environment(tchn, full_path=3DFalse)[0]
> +        self.assertEqual(
> +            {b'CROSS_COMPILE': b'aarch64-linux-', b'LC_ALL': b'C',
> +             b'PATH': b'/path/to'}, diff)
> +
> +        diff =3D self.call_make_environment(tchn, full_path=3DTrue)[0]
> +        self.assertEqual(
> +            {b'CROSS_COMPILE': b'/path/to/aarch64-linux-', b'LC_ALL': b=
'C'},
> +            diff)
> +
> +        # When overriding the toolchain, only LC_ALL should be set
> +        tchn.override_toolchain =3D True
> +        diff =3D self.call_make_environment(tchn, full_path=3DTrue)[0]
> +        self.assertEqual({b'LC_ALL': b'C'}, diff)
> +
> +        # Test that virtualenv is handled correctly
> +        tchn.override_toolchain =3D False
> +        sys.prefix =3D '/some/venv'
> +        env =3D dict(os.environb)
> +        env[b'PATH'] =3D b'/some/venv/bin:other/things'
> +        tchn.path =3D '/my/path'
> +        diff, diff_path =3D self.call_make_environment(tchn, False, env=
)
> +
> +        self.assertIn(b'PATH', diff)
> +        self.assertEqual([b'/some/venv/bin', b'/my/path', b'other/thing=
s'],
> +                         diff_path)
> +        self.assertEqual(
> +            {b'CROSS_COMPILE': b'aarch64-linux-', b'LC_ALL': b'C',
> +             b'PATH': b'/my/path'}, diff)
> +
> +        # Handle a toolchain wrapper
> +        tchn.path =3D ''
> +        bsettings.add_section('toolchain-wrapper')
> +        bsettings.set_item('toolchain-wrapper', 'my-wrapper', 'fred')
> +        diff =3D self.call_make_environment(tchn, full_path=3DTrue)[0]
> +        self.assertEqual(
> +            {b'CROSS_COMPILE': b'fred aarch64-linux-', b'LC_ALL': b'C'}=
, diff)
>
>   if __name__ =3D=3D "__main__":
>       unittest.main()
> diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
> index 79c7c11a110..cd917d8b7eb 100644
> --- a/tools/buildman/toolchain.py
> +++ b/tools/buildman/toolchain.py
> @@ -172,13 +172,14 @@ class Toolchain:
>           else:
>               raise ValueError('Unknown arg to GetEnvArgs (%d)' % which)
>
> -    def MakeEnvironment(self, full_path):
> +    def MakeEnvironment(self, full_path, env=3DNone):
>           """Returns an environment for using the toolchain.
>
>           Thie takes the current environment and adds CROSS_COMPILE so t=
hat

Maybe you could resolve these nits too:

%s/Thie/This/

>           the tool chain will operate correctly. This also disables loca=
lized
>           output and possibly unicode encoded output of all build tools =
by

%s/unicode/Unicode/

Best regards

Heinrich

> -        adding LC_ALL=3DC.
> +        adding LC_ALL=3DC. For the case where full_path is False, it pr=
epends
> +        the toolchain to PATH
>
>           Note that os.environb is used to obtain the environment, since=
 in some
>           cases the environment many contain non-ASCII characters and we=
 see
> @@ -187,15 +188,21 @@ class Toolchain:
>             UnicodeEncodeError: 'utf-8' codec can't encode characters in=
 position
>                569-570: surrogates not allowed
>
> +        When running inside a Python venv, care is taken not to put the
> +        toolchain path before the venv path, so that builds initiated b=
y
> +        buildman will still respect the venv.
> +
>           Args:
>               full_path: Return the full path in CROSS_COMPILE and don't=
 set
>                   PATH
> +            env (dict of bytes): Original environment, used for testing
>           Returns:
>               Dict containing the (bytes) environment to use. This is ba=
sed on the
>               current environment, with changes as needed to CROSS_COMPI=
LE, PATH
>               and LC_ALL.
>           """
> -        env =3D dict(os.environb)
> +        env =3D dict(env or os.environb)
> +
>           wrapper =3D self.GetWrapper()
>
>           if self.override_toolchain:
> @@ -206,7 +213,23 @@ class Toolchain:
>                   wrapper + os.path.join(self.path, self.cross))
>           else:
>               env[b'CROSS_COMPILE'] =3D tools.to_bytes(wrapper + self.cr=
oss)
> -            env[b'PATH'] =3D tools.to_bytes(self.path) + b':' + env[b'P=
ATH']
> +
> +            # Detect a Python virtualenv and avoid defeating it
> +            if sys.prefix !=3D sys.base_prefix:
> +                paths =3D env[b'PATH'].split(b':')
> +                new_paths =3D []
> +                to_insert =3D tools.to_bytes(self.path)
> +                insert_after =3D tools.to_bytes(sys.prefix)
> +                for path in paths:
> +                    new_paths.append(path)
> +                    if to_insert and path.startswith(insert_after):
> +                        new_paths.append(to_insert)
> +                        to_insert =3D None
> +                if to_insert:
> +                    new_paths.append(to_insert)
> +                env[b'PATH'] =3D b':'.join(new_paths)
> +            else:
> +                env[b'PATH'] =3D tools.to_bytes(self.path) + b':' + env=
[b'PATH']
>
>           env[b'LC_ALL'] =3D b'C'
>

