Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BA9C30658
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540F28852D;
	Tue, 25 Jun 2024 14:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RPOs3kJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C28B88496; Tue, 25 Jun 2024 14:38:23 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC2E88548
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b4febddfd3so25414336d6.1
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719319100; x=1719923900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XeEtBw0Bs9UhwSMn0ShrsHQrW+RrSDnlEEhHCJgAWSA=;
 b=RPOs3kJr94rXqQsGMrmZUc7Au/BPPmRbCZy7Gow6HXAIpEaikqo+xJLYi+PRRUYn02
 WgfUR7n0rZ9Z7DsblYealM8n5WM57HOOT2N9kqMwVLjDdqZIAHGTf/jbIkhX0JlIXCTw
 XB93+9pd4JFfwaIfJxz/vd138qF404VpnAsEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319100; x=1719923900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XeEtBw0Bs9UhwSMn0ShrsHQrW+RrSDnlEEhHCJgAWSA=;
 b=ljp04qFrOY6eXPw7tbymRMy0+R5GjEy4MOO2tboCFwT4LfEZBxJHIO8/Ij9FaWDUQ1
 Ase5RmVidjajEV1/64aBml6BERzLYz0sCkbPXyIZMZg3QtnmaqDXe9S/aKXGz4ci01tP
 WlknMjqZCO873xNsSQ2KhyDJC5QQdW+5lH5mUGX6vp1QCdxcpynrrfvaaHZJ7krB08TT
 /BTRPJAcDfHaDpqPasMo+CSoOUrRVAdY2KkYDZPZzTKO1ac4SI4Kd8Z69mnAxuZbEIzJ
 E/mfvGudo73FdVk70hYmxa5/rr4+/4rSpF98Bo3l/v8WdluV0Eo1Il6EbjQfNCieWOga
 qT4A==
X-Gm-Message-State: AOJu0YyVF+rEuBgA7xdYn7WRYrwtfNDPJ4/roe5K/qh7v6wHRJXzZlzr
 gPhxK83j9XLr+0bVvK6iaiXhhFoqbH3z9vCJ8ODpj3+uFPgTR3kAPRHP1lXvERnP/IlcIU8XywC
 5Zf1JJdVBxUGraYAO/giPpM8q4xuqHjjSkCoXtdc3+Ldl1ew97g==
X-Google-Smtp-Source: AGHT+IEjyPr+X1qFckyVFGQYyKf3M3fzMsto1V8k3y4fi+sNWdqXtUJ75FLVZqo5ZA49kWRF4PiPeyv8lTvhSTNSlPI=
X-Received: by 2002:a05:6214:719:b0:6b5:58e8:8f0c with SMTP id
 6a1803df08f44-6b558e890cfmr37783476d6.7.1719319099345; Tue, 25 Jun 2024
 05:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
 <20240624181303.GH38804@bill-the-cat>
In-Reply-To: <20240624181303.GH38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:38:08 +0100
Message-ID: <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
>
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
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > index 6547c6922c6..5de8d7b0e23 100644
> > --- a/test/py/conftest.py
> > +++ b/test/py/conftest.py
> > @@ -23,6 +23,7 @@ from pathlib import Path
> >  import pytest
> >  import re
> >  from _pytest.runner import runtestprotocol
> > +import subprocess
> >  import sys
> >
> >  # Globals: The HTML log file, and the connection to the U-Boot console.
> > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> >      parser.addoption('--gdbserver', default=None,
> >          help='Run sandbox under gdbserver. The argument is the channel '+
> >          'over which gdbserver should communicate, e.g. localhost:1234')
> > +    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
> >      parser.addoption('--no-prompt-wait', default=False, action='store_true',
> >          help="Assume that U-Boot is ready and don't wait for a prompt")
> >
> > @@ -130,12 +132,33 @@ def get_details(config):
> >              str: Build directory
> >              str: Source directory
> >      """
> > -    board_type = config.getoption('board_type')
> > -    board_identity = config.getoption('board_identity')
> > +    role = config.getoption('role')
> >      build_dir = config.getoption('build_dir')
> > +    if role:
> > +        board_identity = role
> > +        cmd = ['u-boot-test-getrole', role, '--configure']
> > +        env = os.environ.copy()
> > +        if build_dir:
> > +            env['U_BOOT_BUILD_DIR'] = build_dir
> > +        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
> > +                              env=env)
> > +        if proc.returncode:
> > +            raise ValueError(proc.stderr)
> > +        print('conftest: lab:', proc.stdout)
> > +        vals = {}
> > +        for line in proc.stdout.splitlines():
> > +            item, value = line.split(' ', maxsplit=1)
> > +            k = item.split(':')[-1]
> > +            vals[k] = value
> > +        print('conftest: lab info:', vals)
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
> >      if not build_dir:
> >          build_dir = default_build_dir
>
> I'm a little confused here. Why can't we construct "role" from
> board_type+board_identity and then we have the board
> conf.${board_type}_${board_identity} file set whatever needs setting to
> be "labgrid" ?

The role is equivalent to the board identity, not the combination of
the U-Boot board type and the board identity. I went this way to avoid
having to type long and complicated roles when connecting to boards.
It is similar to how things work today, except that the board type is
implied by the 'role'.

For boards which have multiple identities (e.g. can support two
different board types), Labgrid handles acquiring and releasing the
shares resources, to avoid any problems.

Regards,
Simon
