Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8EDC2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5174A88578;
	Fri, 21 Jun 2024 01:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PGq0UE/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2337E8834D; Fri, 21 Jun 2024 01:05:49 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9194388571
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6fa11ac8695so818002a34.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924745; x=1719529545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKEmERM0Xl14veeKj5cDr0pv1hbWbnTqHlOZFMMNZZg=;
 b=PGq0UE/NtzLHpH26UtW8JLuVdRv7mzzny2zulObO1HoZmyYQ5+qM7vIYLef8HZ12eH
 q1eAc3osyj/XrzX8ibAJ6tY7wo7H7g/9kf1ukMnXzoA1LWHLhB//nRx4YK1tDfr+wbRY
 Fc8D2KwfpxvX30X+AWhWXPxGJxEPmjoFXbMAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924745; x=1719529545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKEmERM0Xl14veeKj5cDr0pv1hbWbnTqHlOZFMMNZZg=;
 b=Xl1ZIUsj6J2C6WGOp8yLeVzGWo2mZsnBaRWba337jEzZ5FLPXhjIVwUHPdx3SnKgjA
 c69enDJq4F0HkQ8u/X9iIdfpEPb6Nd7xi5eSn9jMAFRzm0NyqnfRxOUJM7ORV5kcPfeP
 ouJmi0tLFw5bp8w1BkyvvPYllr/FdBqSvH4AEc9jb3Pxf5WtQIA249nJkz7onheQgpeA
 cgQ4DIuxMZywhFsJwhSzRIuN7aA/8HTHz3XKjfyo2wLR8SEzan4tHTojzbzqQbeLNjAs
 YbZ1r9a+0JAKagaqsosDsmqLcmq48FN28PSl5MTKnBHqbn0PgthZQ7uebGSCrLqB59mI
 SbCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxtvG5vVmlX+Ae1RZtuMnDuavsdVD4wSnza8OR0rqE6IhxofaCdxZEIpfbOfeH6SPwv5kU/07y8wGFC8yhbuOzsjT1JA==
X-Gm-Message-State: AOJu0YzKhD5H9XHeeyUrZ7LG/OkDKiBLfkdorEoq8/i31sZ6IYJQBxQR
 gSUAd4+2ywXv3929JZJCA4J9qfjpKEcVaCansagI+yz439eBLZRvhO6FDJCvglZYrGliX5KpwE3
 4HqBySMjrpTll6bnEOj8ep6JjjS2mXs9yEaZWezs3WnNEuKQ=
X-Google-Smtp-Source: AGHT+IHojXo3eoNw/roI5MGbaDfvWHvMoVCeGViu3QHMvXjWiCiC5cUg9iVglt4VOY5zE5honQ4dN9s/NHGid0ke11g=
X-Received: by 2002:a9d:77c2:0:b0:6f9:a1fd:85c8 with SMTP id
 46e09a7af769-700735657femr7372740a34.2.1718924745281; Thu, 20 Jun 2024
 16:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
 <d2526c98-8198-4b8b-ab10-20bda0151da1@gmx.de>
In-Reply-To: <d2526c98-8198-4b8b-ab10-20bda0151da1@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Jun 2024 17:05:34 -0600
Message-ID: <CAFLszTjUy4OCM4bYh3CKM-F4U-in0eU3PV0e2jzHG1JRG4NxVQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Thu, 20 Jun 2024 at 07:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 20.06.24 15:19, Simon Glass wrote:
> > The Python virtualenv tool sets up a few things in the envronment,
>
> Nits
>
> %s/envronment/environment/
>
> > putting its path first in the PATH environment variable and setting up
> > a sys.prefix different from the sys.base_prefix value.
> >
> > At present buildman puts the toolchain path first in PATH so that it can
> > be found easily during the build. For sandbox this causes problems since
> > /usr/bin/gcc (for example) results in '/usr/bin' being prepended to the
> > PATH variable. As a result, the venv is partially disabled.
>
> If you want to remember a PATH, why don't you use a differnet variable
> like U_BOOT_TOOLPATH to convey this information instead of manipulating
> the PATH variable?

Remembering a path?

The goal here is to give buildman what it needs, i.e. the combination
of PATH changes (if needed) and CROSS_COMPILE that makes things work.

I am not proposing to change the mechanics of buildman, just deal with
this venv situation which I had not previously noticed.

>
> >
> > The result is that sandbox builds within a venv ignore the venv, e.g.
> > when looking for packages.
> >
> > Correct this by detecting the venv and adding the toolchain path after
> > the venv path.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   tools/buildman/bsettings.py |  3 ++
> >   tools/buildman/test.py      | 83 +++++++++++++++++++++++++++++++++++++
> >   tools/buildman/toolchain.py | 31 ++++++++++++--
> >   3 files changed, 113 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
> > index e225ac2ca0f..1be1d45e0fa 100644
> > --- a/tools/buildman/bsettings.py
> > +++ b/tools/buildman/bsettings.py
> > @@ -31,6 +31,9 @@ def setup(fname=''):
> >   def add_file(data):
> >       settings.readfp(io.StringIO(data))
> >
> > +def add_section(name):
> > +    settings.add_section(name)
> > +
> >   def get_items(section):
> >       """Get the items from a section of the config.
> >
> > diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> > index f92add7a7c5..83219182fe0 100644
> > --- a/tools/buildman/test.py
> > +++ b/tools/buildman/test.py
> > @@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
> >           self.toolchains.Add('arm-linux-gcc', test=False)
> >           self.toolchains.Add('sparc-linux-gcc', test=False)
> >           self.toolchains.Add('powerpc-linux-gcc', test=False)
> > +        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=False)
> >           self.toolchains.Add('gcc', test=False)
> >
> >           # Avoid sending any output
> > @@ -747,6 +748,88 @@ class TestBuild(unittest.TestCase):
> >           self.assertEqual([
> >               ['MARY="mary"', 'Missing expected line: CONFIG_MARY="mary"']], result)
> >
> > +    def call_make_environment(self, tchn, full_path, in_env=None):
> > +        """Call Toolchain.MakeEnvironment() and process the result
> > +
> > +        Args:
> > +            tchn (Toolchain): Toolchain to use
> > +            full_path (bool): True to return the full path in CROSS_COMPILE
> > +                rather than adding it to the PATH variable
> > +            in_env (dict): Input environment to use, None to use current env
> > +
> > +        Returns:
> > +            tuple:
> > +                dict: Changes that MakeEnvironment has made to the environment
> > +                    key: Environment variable that was changed
> > +                    value: New value (for PATH this only includes components
> > +                        which were added)
> > +                str: Full value of the new PATH variable
> > +        """
> > +        env = tchn.MakeEnvironment(full_path, env=in_env)
> > +
> > +        # Get the original environment
> > +        orig_env = dict(os.environb if in_env is None else in_env)
> > +        orig_path = orig_env[b'PATH'].split(b':')
> > +
> > +        # Find new variables
> > +        diff = dict((k, env[k]) for k in env if orig_env.get(k) != env[k])
> > +
> > +        # Find new / different path components
> > +        diff_path = None
> > +        new_path = None
> > +        if b'PATH' in diff:
> > +            new_path = diff[b'PATH'].split(b':')
> > +            diff_paths = [p for p in new_path if p not in orig_path]
> > +            diff_path = b':'.join(p for p in new_path if p not in orig_path)
> > +            if diff_path:
> > +                diff[b'PATH'] = diff_path
> > +            else:
> > +                del diff[b'PATH']
> > +        return diff, new_path
> > +
> > +    def test_toolchain_env(self):
> > +        """Test PATH and other environment settings for toolchains"""
> > +        # Use a toolchain which has a path, so that full_path makes a difference
> > +        tchn = self.toolchains.Select('aarch64')
> > +
> > +        # Normal cases
> > +        diff = self.call_make_environment(tchn, full_path=False)[0]
> > +        self.assertEqual(
> > +            {b'CROSS_COMPILE': b'aarch64-linux-', b'LC_ALL': b'C',
> > +             b'PATH': b'/path/to'}, diff)
> > +
> > +        diff = self.call_make_environment(tchn, full_path=True)[0]
> > +        self.assertEqual(
> > +            {b'CROSS_COMPILE': b'/path/to/aarch64-linux-', b'LC_ALL': b'C'},
> > +            diff)
> > +
> > +        # When overriding the toolchain, only LC_ALL should be set
> > +        tchn.override_toolchain = True
> > +        diff = self.call_make_environment(tchn, full_path=True)[0]
> > +        self.assertEqual({b'LC_ALL': b'C'}, diff)
> > +
> > +        # Test that virtualenv is handled correctly
> > +        tchn.override_toolchain = False
> > +        sys.prefix = '/some/venv'
> > +        env = dict(os.environb)
> > +        env[b'PATH'] = b'/some/venv/bin:other/things'
> > +        tchn.path = '/my/path'
> > +        diff, diff_path = self.call_make_environment(tchn, False, env)
> > +
> > +        self.assertIn(b'PATH', diff)
> > +        self.assertEqual([b'/some/venv/bin', b'/my/path', b'other/things'],
> > +                         diff_path)
> > +        self.assertEqual(
> > +            {b'CROSS_COMPILE': b'aarch64-linux-', b'LC_ALL': b'C',
> > +             b'PATH': b'/my/path'}, diff)
> > +
> > +        # Handle a toolchain wrapper
> > +        tchn.path = ''
> > +        bsettings.add_section('toolchain-wrapper')
> > +        bsettings.set_item('toolchain-wrapper', 'my-wrapper', 'fred')
> > +        diff = self.call_make_environment(tchn, full_path=True)[0]
> > +        self.assertEqual(
> > +            {b'CROSS_COMPILE': b'fred aarch64-linux-', b'LC_ALL': b'C'}, diff)
> >
> >   if __name__ == "__main__":
> >       unittest.main()
> > diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
> > index 79c7c11a110..cd917d8b7eb 100644
> > --- a/tools/buildman/toolchain.py
> > +++ b/tools/buildman/toolchain.py
> > @@ -172,13 +172,14 @@ class Toolchain:
> >           else:
> >               raise ValueError('Unknown arg to GetEnvArgs (%d)' % which)
> >
> > -    def MakeEnvironment(self, full_path):
> > +    def MakeEnvironment(self, full_path, env=None):
> >           """Returns an environment for using the toolchain.
> >
> >           Thie takes the current environment and adds CROSS_COMPILE so that
>
> Maybe you could resolve these nits too:
>
> %s/Thie/This/
>
> >           the tool chain will operate correctly. This also disables localized
> >           output and possibly unicode encoded output of all build tools by
>
> %s/unicode/Unicode/

OK

>
> Best regards
>
> Heinrich
>
> > -        adding LC_ALL=C.
> > +        adding LC_ALL=C. For the case where full_path is False, it prepends
> > +        the toolchain to PATH
> >
> >           Note that os.environb is used to obtain the environment, since in some
> >           cases the environment many contain non-ASCII characters and we see
> > @@ -187,15 +188,21 @@ class Toolchain:
> >             UnicodeEncodeError: 'utf-8' codec can't encode characters in position
> >                569-570: surrogates not allowed
> >
> > +        When running inside a Python venv, care is taken not to put the
> > +        toolchain path before the venv path, so that builds initiated by
> > +        buildman will still respect the venv.
> > +
> >           Args:
> >               full_path: Return the full path in CROSS_COMPILE and don't set
> >                   PATH
> > +            env (dict of bytes): Original environment, used for testing
> >           Returns:
> >               Dict containing the (bytes) environment to use. This is based on the
> >               current environment, with changes as needed to CROSS_COMPILE, PATH
> >               and LC_ALL.
> >           """
> > -        env = dict(os.environb)
> > +        env = dict(env or os.environb)
> > +
> >           wrapper = self.GetWrapper()
> >
> >           if self.override_toolchain:
> > @@ -206,7 +213,23 @@ class Toolchain:
> >                   wrapper + os.path.join(self.path, self.cross))
> >           else:
> >               env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
> > -            env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
> > +
> > +            # Detect a Python virtualenv and avoid defeating it
> > +            if sys.prefix != sys.base_prefix:
> > +                paths = env[b'PATH'].split(b':')
> > +                new_paths = []
> > +                to_insert = tools.to_bytes(self.path)
> > +                insert_after = tools.to_bytes(sys.prefix)
> > +                for path in paths:
> > +                    new_paths.append(path)
> > +                    if to_insert and path.startswith(insert_after):
> > +                        new_paths.append(to_insert)
> > +                        to_insert = None
> > +                if to_insert:
> > +                    new_paths.append(to_insert)
> > +                env[b'PATH'] = b':'.join(new_paths)
> > +            else:
> > +                env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
> >
> >           env[b'LC_ALL'] = b'C'
> >
>

Regards,
Simon
