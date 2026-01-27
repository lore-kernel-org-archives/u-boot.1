Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DA2D25920
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 03:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7483A83F50;
	Tue, 27 Jan 2026 04:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MlGHpHaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63ED883F61; Tue, 27 Jan 2026 04:00:48 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF4783BFE
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 04:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8707005183so797700166b.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 19:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769482845; cv=none;
 d=google.com; s=arc-20240605;
 b=H83zQMqvGmCqCRZCoef859FlNa/qSvR81IH5bXxVf86mxnovMBWo58OjCgan9cZjrU
 V3nVVERC1kGQ2Q8ygJ0NmvkOTWVTh8Dpvotk8ZbY2vnz6Kou34/FwviAWN9/aGFhaBFT
 j9x1o2tV0V9BUG1SgPG+4wPnWymzoWnYItyLtTEFuPJaJYqC9DxattdrNqPy7dzYG1RD
 MHbXgc0ODw+sr+fkwcb7IKnpQXhuCgfoKqM+pj+IW8NGJV4+SUj/0xcFj9PQzvvAxyDI
 JHX61Bi1fAfUDCUSLEsYDspNhuHClpNao8CPMBqsRkDyvhtU9TF9j8iJ7tR2vqgFyLvG
 rkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kU27gqQOXdmXDIofGCjLvReo12MoacduMBozi8v56VI=;
 fh=pNfUrt2L/mQU8z12JbVr4XvHoXo1ulEgn6Zw8p+06CY=;
 b=cepMIwmC/MKXzB4SNmmeQXqHfcU19frSzfnQ37pmW7gLOm8lD8PrR6ny1Kv3lP5Jc/
 aRstsTE+qmEvo3qRdjGhnwX/83AyCKN23got0j7kCz8QJ/eiNck55oIH84tFuJj36pp3
 xGFs+hjBKHdXkVvCio72vAeHbqGduiO9DO/SvS3ubeS4LYItzJKNtplkI0KWTssjPZVT
 Wv8BYuNiXXVatFBS/K/27xDynjQNpUTvO9ZQQTZK9eggRWJUrHov6RmadU4N4rkpy4zq
 G5wjRXIhvsxA5T+U28NxNcT1f+a2SGvJXsVN5AQ4h1XNOFNzCfR24q5HQRLWTWRHTMJk
 lzoQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1769482845; x=1770087645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kU27gqQOXdmXDIofGCjLvReo12MoacduMBozi8v56VI=;
 b=MlGHpHaTLI1muvh9LUPPMXeMItXInrNCK7JL0NhAeuFWvZgM93HytswWrVuNMYu+yz
 ONboJvqsNCXfHTttP4+DIdCFJeQW6bfLckj715gvHQ/0qA7MvouxEjPMm0d0ihAYGXoK
 w1Je2t8rPONXRVWfZoN7Nv6SlLFDnm6yxRa4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769482845; x=1770087645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kU27gqQOXdmXDIofGCjLvReo12MoacduMBozi8v56VI=;
 b=bnEUbROXPEAnHH3th6qYL/iEsrg9khrsGFvIYhEp2T6DhA6siEB1HchY2/NgIayoMh
 4I8pEsMAx9Y+XAu87vS1kMzo/Cpl1PabZXCcVgBZnwU8IuUxUwYF56kmu77WvVCS8sVC
 q9s54tgYPgzkS8alOQvu5EDSF0cTJMAMq02Xa9c2fJxtpYAC/GmxoaMGMw8x+VXzGWPX
 tm2esn2VKRydSJCofRILlq+y8VJ1FMT+UJFQmdPur2ss5yd4SwlXLQSS5NI40TFYG8UI
 zQSDu6pmzCT6gHKVsgeZ7UAW2Odz+pc5n/sdubeskbgGCsY8hk/ZoQm7WF9/Q2TLdzbF
 XoDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv14uZ3yqHq2nsPNxU303DI9Vztxbt3P4d3hzNm7b4OV6WoYMJ//thzEkWrwSVJnJD6rbSq7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxBQrklvUGNLgmc0isdpurxgMYtKDoW3OlpgPQZU4UWtDZ5XGT+
 vfcJiHrFnDWJS8uslsoFFkmVEk0P3vYqPvC+UAkfngOA0HAM7FVhUNgYvt+AnmFEe5BzN0BYhYf
 y+cBb4tm5vfmviBjtFDoIYm5phdYpBP7LoCVqDrcW91iN8wT3Aq1CdQ==
X-Gm-Gg: AZuq6aJZjV6inmPs+N6sovUdvq2KNqD41l5p7i0hPhQrTR5CjPBPttBE51FAXzWraVj
 5D7uTaLKI3KC0WJ8FDTwP77wA4QQkw8RXc4cqh3VfijM7F0XQv7t1/zBS/S1e0lJUvUQoMaI9EW
 Vnx93eJG8D2FVFhNkcYIE57z8IPDcOnH6smjr4leV0+dRR7O3PI87xG2wImFYuDpWwD17xg3BKH
 ZB6P2RX0wvRr+B/HhiuYVHVDnYZXUlVqOBkKpM4HOve38JnByoQpS4xbGbyEgHnvKYxEdMB
X-Received: by 2002:a17:907:7b9f:b0:b87:965:9079 with SMTP id
 a640c23a62f3a-b8dab28ce10mr24188566b.3.1769482845231; Mon, 26 Jan 2026
 19:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de>
 <aXDJ4PrbO2eL63B-@mt.com> <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
 <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
 <74ead874-927c-4ece-aafa-808cd054ef3a@cherry.de>
In-Reply-To: <74ead874-927c-4ece-aafa-808cd054ef3a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Jan 2026 16:00:44 +1300
X-Gm-Features: AZwV_Qhg77O-IdKw3M0AwCJcp5g3ul4_UwvWB84kUN15OrIF0S5BvLmSKtMr8VQ
Message-ID: <CAFLszTjH=Yv72oDucXJHyhGrEvtRLRq_7EO8nRd2B2K6TttiRw@mail.gmail.com>
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <simon.glass@canonical.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
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

Hi Quentin,

On Tue, 27 Jan 2026 at 00:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 1/22/26 11:46 PM, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 22 Jan 2026 at 02:06, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Wojciech,
> >>
> >> On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
> >>> On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
> >>> Hello Quentin,
> >>>> Hi Wojciech,
> >>>>
> >>>> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> >> [...]
> >>>>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
> >>>>
> >>>> This is wrong, you'll be messing up with the environment of all tests being
> >>>> run in the same thread. You must use the "with
> >>>> unittest.mock.patch.dict('os.environ'," implementation I used in
> >>>> testFitSignPKCS11Simple.
> >>>
> >>> Well, I have done so in my V2 but has been commented as wrong by the
> >>> first reviewer. I will restore it back.
> >>>
> >>
> >> Indeed, I see Simon asked you to do this in v2 and I missed it. It isn't
> >> how we should be doing it.
> >>
> >> This is likely fine on its own because there's only one test that is now
> >> modifying os.environ's SOFTHSM2_CONF but this will be a problem next
> >> time a test wants to modify it. I actually hit this issue when
> >> developing the PKCS11 fit signing tests as I had two tests modifying the
> >> environment.
> >>
> >> The only trace of it left is the changelog in
> >> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/
> >>
> >> """
> >> - fixed issues due to modification of the environment in tests failing
> >>     other tests, by using unittest.mock.patch.dict() on os.environ as
> >>     suggested by the unittest.mock doc,
> >> """
> >>
> >> and you can check the diff between the v2 and v3 to check I used to
> >> modify the env directly but now mock it instead.
> >>
> >> Sorry for not catching this, should have answered to Simon in the v2.
> >
> > In practice we try to set values for various which are important, so
> > future tests should explicitly delete the var if needed. But I am OK
>
> This is not working. See this very simple example (too lazy to use
> threading.Lock so synchronization done via time.sleep instead):
>
> """
> #!/usr/bin/env python3
>
> import os
> import time
> import threading
>
>
> def thread_func(n):
>      if n == 1:
>          time.sleep(1)
>      print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
>      if n == 1:
>          time.sleep(1)
>      print(f'Thread {n} set environ var FOO to foo{n}')
>      os.environ['FOO'] = f'foo{n}'
>      if n == 0:
>          time.sleep(5)
>      print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
>      if n == 0:
>          print(f'Thread {n} removes environ var FOO')
>          del os.environ["FOO"]
>      else:
>          time.sleep(10)
>          print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>
>
> threads = []
>
> os.environ["FOO"] = "foo"
>
> for i in range(0, 2):
>      t = threading.Thread(target=thread_func, args=(i,))
>      threads.append(t)
>
> for t in threads:
>      t.start()
>
> for t in threads:
>      t.join()
>
> """
>
> This results in:
>
> """
> Thread 0 read environ var FOO=foo
> Thread 0 set environ var FOO to foo0
> Thread 1 read environ var FOO=foo0
> Thread 1 set environ var FOO to foo1
> Thread 1 read environ var FOO=foo1
> Thread 0 read environ var FOO=foo1
> Thread 0 removes environ var FOO
> Thread 1 read environ var FOO=None
> """
>
> You see that modification made to os.environ in a different thread
> impacts the other threads. A test should definitely NOT modify anything
> for another test, especially not when it's already running.
>
> So now, I implemented mocking instead (like in my tests for PKCS11 in
> tools/binman/ftest.py) because I know it works.
>
> See:
>
> """
> #!/usr/bin/env python3
>
> import os
> import time
> import threading
> import unittest.mock
>
>
> def thread_func(n):
>      if n == 1:
>          time.sleep(1)
>      print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>      if n == 1:
>          time.sleep(1)
>      with unittest.mock.patch.dict('os.environ',
>                                    {'FOO': f'foo{n}'}):
>          print(f'Thread {n} set environ var FOO to foo{n}')
>          if n == 0:
>              time.sleep(5)
>          print(f'Thread {n} read mocked environ var
> FOO={os.environ.get("FOO")}')
>          if n == 1:
>              time.sleep(6)
>      print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>
>
> threads = []
>
> for i in range(0, 2):
>      t = threading.Thread(target=thread_func, args=(i,))
>      threads.append(t)
>
> for t in threads:
>      t.start()
>
> for t in threads:
>      t.join()
> """
>
> Lo and behold, it.... does NOT work???????
>
> I get:
>
> """
> Thread 0 read environ var FOO=None
> Thread 0 set environ var FOO to foo0
> Thread 1 read environ var FOO=foo0
> Thread 1 set environ var FOO to foo1
> Thread 1 read mocked environ var FOO=foo1
> Thread 0 read mocked environ var FOO=foo1
> Thread 0 read environ var FOO=None
> Thread 1 read environ var FOO=foo0
> """
>
> I've read that os.environ isn't thread-safe, due to setenv() in glibc
> not being thread-safe:
> https://sourceware.org/glibc/manual/latest/html_node/Environment-Access.html#Environment-Access-1
>
> """
> Modifications of environment variables are not allowed in multi-threaded
> programs.
> """
>
> I'm not sure if this applies to any other Python implementation than
> CPython? But that is likely the one that most people are using.
>
> So... In short, I'm at a loss, no clue how to fix this (if it is even
> fixable). The obvious answer is "spawn multiple processes instead of
> multiple threads" but I can guarantee you, you don't want to be going
> this route as multiprocessing is a lot of headaches in Python. We could
> have the Python thread spawn a subprocess which has a different
> environment if we wanted to (via the `env` command for example), but
> that means not using binman Python API, rather its CLI. We could have
> bintools accept an environment dict that needs to be passed via the
> `env` command or the `env` kwargs of subprocess.Popen().
>
> Headaches, headaches.

I would argue that requiring a particular environment var for a test
is not a great idea. Better to pass an argument through the call stack
and have the external program run with a new environment containing
what is needed.

Regards,
Simon
