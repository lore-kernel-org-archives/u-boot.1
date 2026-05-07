Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAA7CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F7C84B5D;
	Thu,  7 May 2026 18:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UlSCwl7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1643484B58; Thu,  7 May 2026 18:43:54 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AA284B5D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bc177ebda91so202987366b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 09:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172230; cv=none;
 d=google.com; s=arc-20240605;
 b=i/Ovt0VYQAIX2NEeMUN2SfPW+AgYjmseUtqTw0M0WXX9uS62G/Gd4m0iNNCpwNTlQc
 PoR1ke7vDXPXD73dCOBEfehhiPGw6cu2romfBX8cLeruRv7iV8/jHUUxJy7E8GtoPWjw
 hSsI+OO8TopTm2y+HNPlXAKarTX36sEuT/7LIeAPdr6qUYzZV+E8+9mq/GC2PI0w4Tuy
 acm8TIG2odjQw9yhFCJ5j2SGUYthZGddzZ+elDTBEZvtYz8iCkvcYPHW/yB3pIZ+TocL
 otkoeGRcwURk6l3nKtxHZFtd0zkx7mV21u6ldud8KBtZz3FdSJy3u+YoK8VheJ0IZ9Eo
 DBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=clj7Zg472xF/KjO86KsqhsQQS/McoOFilRgNxW6R4u4=;
 fh=LKdTK89Fij2rv9SJBhCBmnALtuMrTj8clfr8JZ1v4nE=;
 b=IdcOx1907UuzsmKmEdQjqlhA2u706czB5L+/zf8sAYhntZI25aB6oyAWJtxmz7ts33
 xMU7CqmqHa6veWEiDYBy8CstbdCV1A2uL9QR4i5qlz/4R9TN2Idm5lUxcxghc8zYxMPQ
 vceikpWy3sRBVac6d9YcvxFR8XWmVboph2Da8uwDnmnzarFm8PlxonS4/N1k/PRC1q5x
 9Z2g8difOZ7jJFbVyOL4zX+1DccDUuZrISONLMXdO0RK5o94RkpKkmZkrRte0Y9vGgwR
 bXgbwxFYFuFjfzEEc/XHH4QuLFzts134oGTGIDKdQTf2EYAydklMRRs2j3NPjrhexaPq
 e3FA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778172230; x=1778777030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=clj7Zg472xF/KjO86KsqhsQQS/McoOFilRgNxW6R4u4=;
 b=UlSCwl7BMBki49mvFl4rBs8/RbYcHSchrFWa/mPJmqKCapeHmvioBotsRSWB1ZaJNS
 UJmMmn8bLMHpyYBUOcVH3J4zrV3TzXjdOEbWZc791xRsdznQDGnjEIXzLSjuEGzrSNwF
 dlzwtgp+QF+H2gRGzlUc03plrVnLLLEiwNIqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172230; x=1778777030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clj7Zg472xF/KjO86KsqhsQQS/McoOFilRgNxW6R4u4=;
 b=bHgk55K9ukXLH1zR7npsuawFEq/ELzcvGtS++8GGV2SjM3ygSAJn8a4EUYKFr3xmL/
 +HZnUMkMyG9aLAGh+uW+4oSxSG6fteNg+eo3vXovOcz9Lq928TiDqBfjOXQ2QQDKcagw
 +llc2OVYeRtSePbnPPBk9iJJn4fKdFmCp0ATjwrE/juqNEdgjvKcJ1pa5J2wH7UNwkuA
 MrYOl5s+u7zsx3xXMUEPIVKjKtQdwOCRLogLyU3WWcx+TD68AqRm8SLUDa3bjncPCYUj
 NFguYPdouvW0gOUpel4vuGkMhbR+ztJ68bHlFih6p8BMM1iF05ZFldbAkR6U4uttm9ab
 x4uQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AHFdvhw0yagxvRX4Aw/pzs3Lk9TGUjKAhmHHSPW+/KpM7hhw/GH+F1JEM9Z8c+/zvrtwDJug=@lists.denx.de
X-Gm-Message-State: AOJu0YxHyoPKv4PDkyUD0j33CGKfN5yCEo7c0siwL8W0Po0iSQeIaXz0
 OSZg2PxZlXpXEPm6o+WqaCQXw+WVFgsZk/iVMOCuEcV6xJ4GGtX7cFyd1KhdXKRvwjMnS3BLxS1
 yUJK2UufBAw4xBxOPw/1s9RDxYyL3qaGzEeO6Ng24
X-Gm-Gg: AeBDiesMjDM8J7gvV5Gm09EiptLnodRSkc32tLIiRUKSH9/7rDHbPyJsredF6ADUGHc
 +NSavkDfLu0ZcDkWvoQuPyZT5ryTFXlIAtFQ96SLoh6HUuRouA6pnDET7VcKE8eK3oB33zxdeMm
 VCJgcVv3JodFsruu2CktaBZGp16yLWal89Dalrz0iKc9FLTyyaMOJB35ZO31T8920/4AvgjfZI3
 B8vCfukC1b+w9+pnZq4+8tosmkSWwDX4207rhRlpPGD9FYPXP7tcgxe4ua3eC8DXs9hrxjvvFXi
 F8Z8ks5d/PYImuG/
X-Received: by 2002:a17:907:ea7:b0:ba6:8f34:b419 with SMTP id
 a640c23a62f3a-bc56ae27aa7mr516129966b.13.1778172230205; Thu, 07 May 2026
 09:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
 <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
 <CAFLszThW0u0SrntCfXFi083petNmszVmSjNgXFc87a38tHyx1Q@mail.gmail.com>
 <610b19bb-3282-4062-a3f5-3071c69dbedb@cherry.de>
In-Reply-To: <610b19bb-3282-4062-a3f5-3071c69dbedb@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 10:43:35 -0600
X-Gm-Features: AVHnY4JrBDpLTUHUq-P2RFll6vsR3-oKZGSQi0vUE_c4NpTVN10KF9aznwrpdQ4
Message-ID: <CAFLszTgjvZnwsLBQicn4=g_wia3JP8EWs1H8o=pUe6L9kcC9JQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de,
 trini@konsulko.com, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, Wojciech.Dubowik@mt.com
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

On Thu, 7 May 2026 at 07:19, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/1/26 4:10 AM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 27 Apr 2026 at 03:48, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Sergio,
> >>
> >> On 4/23/26 5:45 PM, Sergio Prado wrote:
> >>> [You don't often get email from sergio.prado@e-labworks.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> Add an optional extra_env dict parameter to run_cmd() and
> >>> run_cmd_result(). When provided, the key/value pairs are merged into
> >>> the subprocess environment for that invocation only, leaving the parent
> >>> process environment unchanged.
> >>>
> >>> This might be needed by bintools that must inject environment variables
> >>> into specific tool calls without polluting the global environment.
> >>>
> >>
> >> Yeah, I'm not convinced this is useful.
> >>
> >> We would need to propagate this new variable to whatever calls those
> >> methods as well. And it quickly balloons.
> >>
> >> Just mock the environment with
> >>
> >> with unittest.mock.patch.dict('os.environ', {'MYVAR': 'myval'}): like in
> >> testFitSignPKCS11Object for example?
> >
> > While we can mock the environment, it becomes confusing as the mocks
> > pile up. The code path in the test effectively differs from the actual
> > code path, since the mock is overriding something that it assumes the
> > underlying code does, so any changes can cause strange errors.
> >
>
> Sorry, I don't understand what you meant here, can you rephrase?

Basically mocks are fragile since they assume certain behaviour of the
implementation. Change that and the mocks break in confusing ways.

My understanding of the justification for NOT passing the env argument
is that it is annoying to do that plumbing. But I would rather do that
plumbing. Perhaps not stated, but one of Binman's design goals is to
try to have callers pass in their requirements rather than relying on
state or sideways data (although there is plenty of that even so :-)

>
> > The normal approach with binman tests is to pass through the settings
> > they want. See for example _DoTestFile()
> >
> > If you look through the tests, there is almost no mocking despite the
> > large amount of functionality provided by Binman.
> >
>
> How many of those features are actually dependent on environment variables?
>
> Here, configuring OpenSSL, SOFTHSM2, and OpenSSL providers, we clearly
> are in the same scenario as when doing FIT signing with OpenSSL engines.
>
> >>
> >> I'm also very skeptical of the need for binman to *set* environment
> >> variables to setup openssl.
> >>
> >> Look at what's been done for testFitSignPKCS11Object, we externally
> >> configure openssl and softhsm so that binman doesn't have to know about
> >> it. This avoids having to play smart and adding a bunch of new
> >> variables. Is it possible to implement something like that for the x509
> >> certificates? For FIT, we do use fit,engine,
> >> fit,engine-keydir/key-name-hint with mkimage to (possibly) use pkcs11,
> >> custom openssl engines, etc..
> >>
> >> Also, I don't think we should decide for the user whether they are
> >> forced to use a provider or an engine based on the presence of the
> >> provider? just let them configure openssl to use the one they want
> >> externally?
> >
> > Fair enough. I wonder how the tests deal with something which is
> > externally configured, though?
> >
>
> You set the OPENSSL_CONF, OPENSSL_ENGINES and SOFTHSM2_CONF environment
> variables to point at files that are generated for the tests. See the
> various unittest.mock.patch.dict('os.environ',) in tools/binman/ftest.py
> and tools/binman/test/fit/openssl.conf as well as
> tools/binman/test/fit/softhsm2.conf.

Right, so the tests determine / set up the environment and then test
accordingly. That's fine. I'd just like to avoid mocks here.

Regards,
Simon
