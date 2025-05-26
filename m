Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7362C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 16:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F70682E67;
	Mon, 26 May 2025 18:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="afrw01ZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB8C682E8C; Mon, 26 May 2025 18:15:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5720182AB9
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 18:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad5740dd20eso371803766b.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748276122; x=1748880922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p9MQX/JE4/jcbi+P93PJNLDkumGbznPakdGPiw4FcWg=;
 b=afrw01ZMtRNhMYY5IbM9KygxgSAmsplkOq2Ja8A1Mqb0bc0pb3VaSgOom+i8qI4u7D
 EsA2gMvqu6wfAap4Pj4PWQ43qBcsCn0rjwwo/aUX7WPB70JgWun+7QbnpY4FXxirk+Pn
 YC74LxloIH6IglCCSt/2NeGmeNxPWwy2XG2cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748276122; x=1748880922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p9MQX/JE4/jcbi+P93PJNLDkumGbznPakdGPiw4FcWg=;
 b=X1IztRz2tHxR/tbJB7ntGRDDa9lm/BkkYuEek5bx5qmY7cx0Fc8MnSnaziH5QjlNlu
 KOoPfjBuV2qXmqiyB0HTe8u4yDsP5saCmGLKuHqkH+LRb7gW0w3jWRjbbYLRvU0mIXvj
 i3QURiOQQ5/dcq5+BQER4Yx3Jf+bpwxc4PWe7bjfnI+Huwt4cEPl9pAaZ6chzC3Wwfad
 iprXXsSTqR5ocG8MN/JCjxZruIqDR2eHqU24pNc1LAYqrnWe9PbYUdLNmJJkn336iuCG
 uzuZuxNaX/Nk8ab5UAv1xKWF/FoiNi/KfbVfZqa/sHRk/CrPRq7bLJakxcHNWOXcItKO
 gzFQ==
X-Gm-Message-State: AOJu0YyoEjB/IJibrmPJ3qDPNLQ0RvussBPm9HH9O356B/h1kpJ7iOh2
 eORrc+RgRNHKzjOR6ap40MySeTDtoIwOhc8xJBheT3rYWj3Z7nnHqsekJOXQMA3s4236doQ07Gd
 cMlgCLIrrk0DPAHxnNhtvAW1/ZVvKrd8FRu/q2lPZ
X-Gm-Gg: ASbGncullcsVcT52JZqyUg3/u7XoWvhrhkk+eCfaLbJbbFcU5L9yj+Lduf2+zxp8pcc
 BjtoRmyxFCY3ekfVqOVAo3f9en3HKyU/qus/dvIKqTQj0M3Inq9RQUw3SwOAYY2bIqJ3YsjsN0p
 lSL7pJmNLVJ4BZF/ieTXGnEG/Simr+jSM=
X-Google-Smtp-Source: AGHT+IH6TIm4fAKSgQobaBKycdbBapkhuyd+mGKcU6eSleoPTQ1+EF/8zNohHmxKZu3Xx9g/4S3fvK/Den3xN9bDt2A=
X-Received: by 2002:a17:907:3faa:b0:ad2:23fb:5a03 with SMTP id
 a640c23a62f3a-ad85b0a7e23mr835709366b.7.1748276121737; Mon, 26 May 2025
 09:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250524130642.902486-1-sjg@chromium.org>
 <20250524070636.v3.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
 <DA5ZROS80I01.25NCAU84JM742@linaro.org>
In-Reply-To: <DA5ZROS80I01.25NCAU84JM742@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 May 2025 17:15:10 +0100
X-Gm-Features: AX0GCFsepeFuxIGJyQ462t9_REEQp02WIvrN3AcdnF1LhsLlmqNozciHgJKYPQU
Message-ID: <CAFLszTiKwGq3GCbcCxfGWS-F60kS4aPja5p3e128MZ5wyPz5ug@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] tpm: Convert sandbox-focussed tests to C
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>
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

Hi Ilias,

On Mon, 26 May 2025 at 10:40, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Sat May 24, 2025 at 4:06 PM EEST, Simon Glass wrote:
> > Some of the Python tests are a pain because they don't reset the TPM
> > state before each test. Driver model tests do this, so convert the
> > tests to C.
> >
> > This means that these tests won't run on real hardware, but we have
> > tests which do TPM init, so there is still enough coverage.
> >
>
> What's needed to run DM tests on real hardware?
>
> We have full coverage. The auto start command, which is not removed from the
> python tests, will run the selftest command so I think overall this is ok.

Yes, auto-start is good enough for most cases, so long as we are not
testing 'tpm init' or requiring a clean tpm state.  The
test_tpm2_pcr_read() test expects that the TPM has been reset. We
handle this at present by resetting the board after (before?) the
tests run.

For sandbox, I would like (with future work) the test system to do
that reset, in state_reset_for_test() so that we don't need to reset
U-Boot. That is how other sandbox tests work.

Of course, there are various things that are not reset in that
function, nor in test_pre/post_run(). But that's the direction I'd
like to head.

>
> > Rename and update the Python tpm_init test to use 'tpm autostart',
> > since this deals with starting up ready for the tests below.
>
> may 'since this fully initializes the TPM and performs the self tests'?
>
> Other than that it looks good to me.
> I can rewrite the commit message on my PR to Tom if you don't want to send a v4.

Yes please.

>
> With the changes above
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Thanks
> /Ilias
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Use 'check' instead of 'test' when naming test helpers
> > - Add missing tpm_self_test_full() call
> >
> > Changes in v2:
> > - Keep test_tpm2_continue_self_test()
> >
> >  test/dm/tpm.c              | 77 +++++++++++++++++++++++++++++++++++++-
> >  test/py/tests/test_tpm2.py | 38 +------------------
> >  2 files changed, 76 insertions(+), 39 deletions(-)
> >

Regards,
Simon
