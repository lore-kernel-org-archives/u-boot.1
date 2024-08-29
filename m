Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E34C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2497088C6A;
	Thu, 29 Aug 2024 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="irqJKOg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F166188C6A; Thu, 29 Aug 2024 17:01:16 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45E988C35
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf9ddfc2dcso3722096d6.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943673; x=1725548473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8GHVN1vxKWsN4cbTeXmfJ4taRpdQ5oweDrOjp9yqNOo=;
 b=irqJKOg6P349jYNp5oqCcjD1lh1sNbHHGx9+iXX9yw21/iydKMEOLqbIBoD8X/767t
 Chnr5wcl7O1GoUVfeJCaW6vV16EoJh7ZKy5uhf7hQNg//FZI0Fe8A7uHaMEOQQL6xq3z
 IGzfW77esuDry8QNQ7j8jSZfpdKbwgEdhmkZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943673; x=1725548473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8GHVN1vxKWsN4cbTeXmfJ4taRpdQ5oweDrOjp9yqNOo=;
 b=PFVNiVSEzfYvJhH2NJ57zrsNqUeVot+WWAz68D0Twpi90C8Uv7z6i4ECnLlt1jNz1y
 8gfIOvn4HjSicS2MWxIkZE1apUebXs8Ou9Smsswle++wx8elavA2WwxAfFKNuYWbNM7b
 qQBrsf+3IYzPZ0M2aH+vN1N6vP5tDoPvZvBOcVA0ZonGjGEdnOqcWwL5mf11lILRK9Oq
 IWYo9hxD6hHvO9UAQt2a6BOfrZxbi3mGwBfcpgbegF3ve25EJWemwZb5O8ORAvdb3i6V
 flvGCWFa0EKhiuHYV8Tw0j4rQIETywa5iT0v9TKwgs46YzGjFUZ2EW0iFTsM6EkaoE+O
 hABQ==
X-Gm-Message-State: AOJu0YznijocuTWFLjBKSZatfgcVk+cipojv44s29yyMzeFXCVh3TvEX
 jhBQcF980/AOPVrmeffRAsQZUp8n4b2BNcuPlxYFdLhg+RcTBjdhDBKgpSJg4LwhX/dyPkrncU1
 iPMIB2gELqStFjn4x8FdsWU/toxOGBsBkyav3DhOr2xuQrvY=
X-Google-Smtp-Source: AGHT+IEihBoVI0H6w4bgrPWv+YfK+0aXUd2uNrtLbSBgVf5HbCPEPNEy5YBxUWTeVSMoNN9m4Sx2v3bG1UNWeY3cb8s=
X-Received: by 2002:a05:6214:319b:b0:6bf:8186:be32 with SMTP id
 6a1803df08f44-6c33e683c43mr37866106d6.38.1724943673388; Thu, 29 Aug 2024
 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-9-sjg@chromium.org>
 <4ab84c7a-c129-41e9-aa1e-6e802fdd6f87@linaro.org>
In-Reply-To: <4ab84c7a-c129-41e9-aa1e-6e802fdd6f87@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:01:02 -0600
Message-ID: <CAFLszTgBY8iq5n8fTkTP3SB2u9wPAm4ePGRU0f6kvJNXgcVZQg@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] test: Introduce the concept of a role
To: neil.armstrong@linaro.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Neil,

On Thu, 29 Aug 2024 at 08:19, <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 29/08/2024 00:08, Simon Glass wrote:
> > In Labgrid there is the concept of a 'role', which is similar to the
> > U-Boot board ID in U-Boot's pytest subsystem.
> >
> > The role indicates both the target and information about the U-Boot
> > build to use. It can also provide any amount of other configuration.
> > The information is obtained using the 'labgrid-client query' operation.
> >
> > Make use of this in tests, so that only the role is required in gitlab
> > and other situations. The board type and other things can be queried
> > as needed.
> >
> > Use a new 'u-boot-test-getrole' script to obtain the requested
> > information.
> >
> > With this it is possible to run lab tests in gitlab with just a single
> > 'ROLE' variable for each board.
>
> Can't this be in the hook script ? I mean allmost no CI system have a 1:1
> usage of board_type & board_identity, but we use those fields and transform
> them accordingly.

Thanks for looking at this series.

I don't really understand this comment...can you expand a bit? The
role corresponds to the board_identity in test.py. If you are
suggesting that we should drop it, then that would mean we would not
be able to support one board with two different U-Boot builds.

>
> u-boot-test-getrole is labgrid only, all script receives board_type & board_identity,
> so why add some labgrind specific python here ?

Because with this integration, board_type is not needed*. Providing it
is redundant since it is 100% determined by the board_identify. Also,
some other things are needed, like where the build is, for interactive
use.

This integration is intended to support:

a) The existing use cases and labs (without modification to
U-Boot...the u-boot-test-hooks changes should not affect things)
b) Moving that lab to Labgrid without losing functionality
c) Interactive use (the ub-int and ub-pyt, etc. scripts)

Regards,
SImon

> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Add a few more comments
> > - Comment out the debugging, which might be useful later
> >
> >   test/py/conftest.py | 38 ++++++++++++++++++++++++++++++++++----
> >   1 file changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > index 6547c6922c6..03dfd8ab562 100644
> > --- a/test/py/conftest.py
> > +++ b/test/py/conftest.py
> > @@ -23,6 +23,7 @@ from pathlib import Path
> >   import pytest
> >   import re
> >   from _pytest.runner import runtestprotocol
> > +import subprocess
> >   import sys
> >
> >   # Globals: The HTML log file, and the connection to the U-Boot console.
> > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> >       parser.addoption('--gdbserver', default=None,
> >           help='Run sandbox under gdbserver. The argument is the channel '+
> >           'over which gdbserver should communicate, e.g. localhost:1234')
> > +    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
> >       parser.addoption('--no-prompt-wait', default=False, action='store_true',
> >           help="Assume that U-Boot is ready and don't wait for a prompt")
> >
> > @@ -130,12 +132,40 @@ def get_details(config):
> >               str: Build directory
> >               str: Source directory
> >       """
> > -    board_type = config.getoption('board_type')
> > -    board_identity = config.getoption('board_identity')
> > +    role = config.getoption('role')
> > +
> > +    # Get a few provided parameters
> >       build_dir = config.getoption('build_dir')
> > +    if role:
> > +        # When using a role, build_dir and build_dir_extra are normally not set,
> > +        # since they are picked up from Labgrid via the u-boot-test-getrole
> > +        # script
> > +        board_identity = role
> > +        cmd = ['u-boot-test-getrole', role, '--configure']
> > +        env = os.environ.copy()
> > +        if build_dir:
> > +            env['U_BOOT_BUILD_DIR'] = build_dir
> > +        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
> > +                              env=env)
> > +        if proc.returncode:
> > +            raise ValueError(proc.stderr)
> > +        # For debugging
> > +        # print('conftest: lab:', proc.stdout)
> > +        vals = {}
> > +        for line in proc.stdout.splitlines():
> > +            item, value = line.split(' ', maxsplit=1)
> > +            k = item.split(':')[-1]
> > +            vals[k] = value
> > +        # For debugging
> > +        # print('conftest: lab info:', vals)
> > +        board_type, default_build_dir, source_dir = (vals['board'],
> > +            vals['build_dir'], vals['source_dir'])
> > +    else:
> > +        board_type = config.getoption('board_type')
> > +        board_identity = config.getoption('board_identity')
> >
> > -    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > -    default_build_dir = source_dir + '/build-' + board_type
> > +        source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > +        default_build_dir = source_dir + '/build-' + board_type
> >       if not build_dir:
> >           build_dir = default_build_dir
> >
>

* If building is needed, then you don't need CROSS_COMPILE, BL31, TEE,
etc. either. All of that is handled within Labgrid configuration.
