Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53793E8B386
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1B183E1E;
	Wed,  4 Feb 2026 01:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VcQxEzny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A10583BC8; Wed,  4 Feb 2026 01:23:04 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2179A83BC7
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8871718b00so1065164166b.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164576; cv=none;
 d=google.com; s=arc-20240605;
 b=ZAZwrzRB1fto5B2nLsnr0O7bUJEpSoorb6Bf36OA7awQErqydAKFNArp4tonpNbMwP
 A+DY64Nq/0TXNhl0tAj0NveaC6wPrBvsOyfWewxQ7AWieBlFW5K3To2mmdyJJsbE97CQ
 Wn5rXi0Uu/yFHtXQkiJJle8vtL/Za68WNGoRnsywwpf+ZnFPuq+Mm4s77pl2kJE3iafu
 2kK1sWq70avezPEjvlwJRU/xA5T5oivyokZMWPIkUOHP7svJdJRISXkrfJaLXJbGr2f9
 u1szc7gpjQvd4QQbliW6SH3UvUACavjrykbeRk3F/dOkTuzBql/72tjyEVYiP/n20k9n
 8flQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QIjV7O75ZnCKyAOyzrDRIrb1pceZjknCn2Yc4nbx22g=;
 fh=awEc8UXt/77v45Pxvjy7Zef1GX5h67k4zGDCkxrh4kg=;
 b=G+/Qj9gtdUsWSLVxKVusvxFbcS3jcZC01/3H3y2wy00jzq8haXKNsst4DU5hFAb5fo
 B281B8lDBZdBHXyf611kq/l2KnUrH7strQNxqyjhd5UP9/b+OhBjvTFuHZnru5IANGL9
 8cve8Q6EsajBOPH4I1NP8YOPk7Xrk5bRgozgiJhtr2+tBpRfvNdAJBZT4r299yGYKwmA
 CEjBp6tRWXfhZCM3HgkFgS71PcspCbqGo0jAV7reGrqyV7PM8+QrQbkbqtMQ8TQHnrkR
 06RCUzUw3w8mEO48hfXgH9tH3E07t2HSAbwhusDffL8reahDpIUaB4T87Z6PSX9TCO4b
 yCPA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164576; x=1770769376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QIjV7O75ZnCKyAOyzrDRIrb1pceZjknCn2Yc4nbx22g=;
 b=VcQxEznys+c8Zmtv42AGTJBI+MGbG3dKys6CFYu11JjDopMynMCeXKQNLnOcOgxQD9
 yCJ2vmIbzs56PgTuc+XGFuiH90FLtN0fQjf4r7BFoSi84LrU3hE/zsQQ5RRCuU2MZL/m
 Js9JM2Ew9becX5HI/z/hOGEZmEBR/iZkrdOa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164576; x=1770769376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIjV7O75ZnCKyAOyzrDRIrb1pceZjknCn2Yc4nbx22g=;
 b=KwNkgAXI3wPu97FnZBiaTXJ8VqoRfXlsvjyN59QGLWh8dM4WxbSSXHY+qPH8D+duB0
 FDWzOLW4OHgGJPKl/qwVJN2SnRQa1jZEqGFv7WhheiJ8jnaEFDU6TBIsPnTX5FgHqGCh
 mOz0463UCK3nZ8XUpes9w0FeVRbTLPCTYTXWomJImn6LH9f6eHtLFkKL4qpangoKebaA
 lQlazxb2fr9eozwoJSgmP6RZGbtYB3mg2NVtwgK3+L073+DKlx9i5IGAwy8SJCm6d7LD
 lC2kQZkyQauCAjkb12iCA0DI3LFp3xbBsPX+EBANzopiVB47O5KIR9hGlZQi/FubsG1d
 qvXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV1x6Ia4LTSnZlJJtdgL7Mt+ptjUhxOlisRYwcWJZOEkH973gs08iwoIzooSSfdgzmT+6iQR4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywcula0NXbx1sPBmtfU/n3vT24JMQzMe5qVPACMJ9E5Q6DHAFup
 MDAJuxS2XtuARTfmxrkMRoekOLdWKpwS+mIlVb9mhctChKOwVrvGHkQ1rdEv/Fwo6w6l6Ifue6l
 rch41MQB74W0vCuUZNCEdBsce9CfOs7seT5YJBsuhD8meeWfMy6ERhA==
X-Gm-Gg: AZuq6aKyLIpzV4i66W7TUKeCI//E3h+Vt3m0/l98ovjzinn8em05WgoE8gZGI6jrf7a
 /U2mySGApU07GRiEQlBEe7DIZ7nb5jpmYPgFoPbHtNghaq7AY8VmIsB5vshqO60z/weKXOGl7xD
 RtTMR/xQ5/teUIYxjEh4mFljpKgaGnu1bmkkB3eHKfuObAY7bRCYa/F5QQ400r/Copasvp4CIgO
 fh/8/0Eg4734NfxF5GeXIlvy9IWXYZ6F0nE90cNlx1GgFE8pE+JonpTvVFTcWINSBbxjBDm
X-Received: by 2002:a17:906:9fc9:b0:b88:61c3:3701 with SMTP id
 a640c23a62f3a-b8e9f2ab90bmr79387966b.52.1770164576466; Tue, 03 Feb 2026
 16:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de>
 <aXDJ4PrbO2eL63B-@mt.com> <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
 <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
 <74ead874-927c-4ece-aafa-808cd054ef3a@cherry.de>
 <CAFLszTjH=Yv72oDucXJHyhGrEvtRLRq_7EO8nRd2B2K6TttiRw@mail.gmail.com>
 <aYGvNb33Eoozx4zk@mt.com>
In-Reply-To: <aYGvNb33Eoozx4zk@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:22:56 +1300
X-Gm-Features: AZwV_Qi_bQHiYE3LE-xNCuw_KoK-osHDXoJBt7TNOcqFT5mqswIRJwMrzYrwmdQ
Message-ID: <CAFLszThqvz7xvLFAN2f7az5qncP6xbTOf2A5JpFaVxV38i=M+A@mail.gmail.com>
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>, 
 u-boot@lists.denx.de, trini@konsulko.com
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

Hi Wojciech,

On Tue, 3 Feb 2026 at 21:18, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> On Tue, Jan 27, 2026 at 04:00:44PM +1300, Simon Glass wrote:
> Hi Simon,
> > Hi Quentin,
> >
> > On Tue, 27 Jan 2026 at 00:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 1/22/26 11:46 PM, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Thu, 22 Jan 2026 at 02:06, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > >>
> > > >> Hi Wojciech,
> > > >>
> > > >> On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
> > > >>> On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
> > > >>> Hello Quentin,
> > > >>>> Hi Wojciech,
> > > >>>>
> > > >>>> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> > > >> [...]
> > > >>>>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
> > > >>>>
> > > >>>> This is wrong, you'll be messing up with the environment of all tests being
> > > >>>> run in the same thread. You must use the "with
> > > >>>> unittest.mock.patch.dict('os.environ'," implementation I used in
> > > >>>> testFitSignPKCS11Simple.
> > > >>>
> > > >>> Well, I have done so in my V2 but has been commented as wrong by the
> > > >>> first reviewer. I will restore it back.
> > > >>>
> > > >>
> > > >> Indeed, I see Simon asked you to do this in v2 and I missed it. It isn't
> > > >> how we should be doing it.
> > > >>
> > > >> This is likely fine on its own because there's only one test that is now
> > > >> modifying os.environ's SOFTHSM2_CONF but this will be a problem next
> > > >> time a test wants to modify it. I actually hit this issue when
> > > >> developing the PKCS11 fit signing tests as I had two tests modifying the
> > > >> environment.
> > > >>
> > > >> The only trace of it left is the changelog in
> > > >> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/
> > > >>
> > > >> """
> > > >> - fixed issues due to modification of the environment in tests failing
> > > >>     other tests, by using unittest.mock.patch.dict() on os.environ as
> > > >>     suggested by the unittest.mock doc,
> > > >> """
> > > >>
> > > >> and you can check the diff between the v2 and v3 to check I used to
> > > >> modify the env directly but now mock it instead.
> > > >>
> > > >> Sorry for not catching this, should have answered to Simon in the v2.
> > > >
> > > > In practice we try to set values for various which are important, so
> > > > future tests should explicitly delete the var if needed. But I am OK
> > >
> > > This is not working. See this very simple example (too lazy to use
> > > threading.Lock so synchronization done via time.sleep instead):
> > >
> > > """
> > > #!/usr/bin/env python3
> > >
> > > import os
> > > import time
> > > import threading
> > >
> > >
> > > def thread_func(n):
> > >      if n == 1:
> > >          time.sleep(1)
> > >      print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
> > >      if n == 1:
> > >          time.sleep(1)
> > >      print(f'Thread {n} set environ var FOO to foo{n}')
> > >      os.environ['FOO'] = f'foo{n}'
> > >      if n == 0:
> > >          time.sleep(5)
> > >      print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
> > >      if n == 0:
> > >          print(f'Thread {n} removes environ var FOO')
> > >          del os.environ["FOO"]
> > >      else:
> > >          time.sleep(10)
> > >          print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
> > >
> > >
> > > threads = []
> > >
> > > os.environ["FOO"] = "foo"
> > >
> > > for i in range(0, 2):
> > >      t = threading.Thread(target=thread_func, args=(i,))
> > >      threads.append(t)
> > >
> > > for t in threads:
> > >      t.start()
> > >
> > > for t in threads:
> > >      t.join()
> > >
> > > """
> > >
> > > This results in:
> > >
> > > """
> > > Thread 0 read environ var FOO=foo
> > > Thread 0 set environ var FOO to foo0
> > > Thread 1 read environ var FOO=foo0
> > > Thread 1 set environ var FOO to foo1
> > > Thread 1 read environ var FOO=foo1
> > > Thread 0 read environ var FOO=foo1
> > > Thread 0 removes environ var FOO
> > > Thread 1 read environ var FOO=None
> > > """
> > >
> > > You see that modification made to os.environ in a different thread
> > > impacts the other threads. A test should definitely NOT modify anything
> > > for another test, especially not when it's already running.
> > >
> > > So now, I implemented mocking instead (like in my tests for PKCS11 in
> > > tools/binman/ftest.py) because I know it works.
> > >
> > > See:
> > >
> > > """
> > > #!/usr/bin/env python3
> > >
> > > import os
> > > import time
> > > import threading
> > > import unittest.mock
> > >
> > >
> > > def thread_func(n):
> > >      if n == 1:
> > >          time.sleep(1)
> > >      print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
> > >      if n == 1:
> > >          time.sleep(1)
> > >      with unittest.mock.patch.dict('os.environ',
> > >                                    {'FOO': f'foo{n}'}):
> > >          print(f'Thread {n} set environ var FOO to foo{n}')
> > >          if n == 0:
> > >              time.sleep(5)
> > >          print(f'Thread {n} read mocked environ var
> > > FOO={os.environ.get("FOO")}')
> > >          if n == 1:
> > >              time.sleep(6)
> > >      print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
> > >
> > >
> > > threads = []
> > >
> > > for i in range(0, 2):
> > >      t = threading.Thread(target=thread_func, args=(i,))
> > >      threads.append(t)
> > >
> > > for t in threads:
> > >      t.start()
> > >
> > > for t in threads:
> > >      t.join()
> > > """
> > >
> > > Lo and behold, it.... does NOT work???????
> > >
> > > I get:
> > >
> > > """
> > > Thread 0 read environ var FOO=None
> > > Thread 0 set environ var FOO to foo0
> > > Thread 1 read environ var FOO=foo0
> > > Thread 1 set environ var FOO to foo1
> > > Thread 1 read mocked environ var FOO=foo1
> > > Thread 0 read mocked environ var FOO=foo1
> > > Thread 0 read environ var FOO=None
> > > Thread 1 read environ var FOO=foo0
> > > """
> > >
> > > I've read that os.environ isn't thread-safe, due to setenv() in glibc
> > > not being thread-safe:
> > > https://sourceware.org/glibc/manual/latest/html_node/Environment-Access.html#Environment-Access-1
> > >
> > > """
> > > Modifications of environment variables are not allowed in multi-threaded
> > > programs.
> > > """
> > >
> > > I'm not sure if this applies to any other Python implementation than
> > > CPython? But that is likely the one that most people are using.
> > >
> > > So... In short, I'm at a loss, no clue how to fix this (if it is even
> > > fixable). The obvious answer is "spawn multiple processes instead of
> > > multiple threads" but I can guarantee you, you don't want to be going
> > > this route as multiprocessing is a lot of headaches in Python. We could
> > > have the Python thread spawn a subprocess which has a different
> > > environment if we wanted to (via the `env` command for example), but
> > > that means not using binman Python API, rather its CLI. We could have
> > > bintools accept an environment dict that needs to be passed via the
> > > `env` command or the `env` kwargs of subprocess.Popen().
> > >
> > > Headaches, headaches.
> >
> > I would argue that requiring a particular environment var for a test
> > is not a great idea. Better to pass an argument through the call stack
> > and have the external program run with a new environment containing
> > what is needed.
> Would it be ok to call softhsm utils with softhsm_conf like
> SOFTHSM2_CONF=... softhsm2-util? Then we don't have to mock environment.
> I would still have to set SOFTHSM install dir location with the env variable
> for mkeficapsule in binman generation. I guess it doesn't affect other
> tests as we don't need to change it.
>

So long as it works it seems fine to me.

Regards,
Simon
