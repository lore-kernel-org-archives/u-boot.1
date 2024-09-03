Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C130ACD3446
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154F188A0A;
	Tue,  3 Sep 2024 17:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SjAK/XKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCC588B4B; Tue,  3 Sep 2024 17:45:25 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E588641A
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d8815ef6d2so2716835a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725378322; x=1725983122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wK82s+2ghP0MWnDpxQby9aUp1W59ePnoNM5WPio3/ok=;
 b=SjAK/XKIF3Z6U+Z6jeAlW/ASy0zdCPTXq5puMGYTVqDdogCNsHq2Ub48wrYcbrzBGE
 YKqed/ALiH4D/KNqZubRaEZ3IKMMXriv1uhQopiwJeL5F54wE9Qz2K139alig2VxNubk
 AcMN7JNf4BRsNPmPcnGxMZXTggHb+4R4BEg3w/Y14vJU9GgXNoL00oT2ODHIBOFCGOki
 IgcbWUNyw4eN9kO82hMW95ukRvrmopsjw3lFyEQGwWV0IC+lmt+AqyLxEaQ2ran3QY6F
 y1tH6U9vah1m7zd6yPD/lbatrNMWkkk71+ck5u6SAcyQ77a8oshn7fKci2IfKz7+t2V+
 mcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725378322; x=1725983122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wK82s+2ghP0MWnDpxQby9aUp1W59ePnoNM5WPio3/ok=;
 b=jnj3WL9mx434hddlw9kUa7yamsfsAC6oYcyHgssbfAsjs82Ql+sepyedbLx9bUnUrd
 oe1y0DHjkDMzlrGhkwln04ECPnJSntmkMmssCHE7u0krC/qw1HFWfEMkoDrnzH9Z5WCU
 csQobqOHGLVIqes1QWnCSn1Pe2oLeBTgnJLw5AgJjTpAP6cL6Rks3gp3mTsD1ThG/Qpq
 uj0OO8A1XnfTYFG9izqOUts3ZPnBAIa9E597e9Hx148R9cCJLJjH3kp8S4D+mYZNtji/
 ZumoP1QlPX9J/E/6i6PJUvhPf/PpdWQcKYDqtoY7gw+I9M91SzXvXJQM+21AEgYtzaWw
 YLKQ==
X-Gm-Message-State: AOJu0YwzQcnZMHualh9DSVquJZsHu2Pi7PFVYYAP9xhH1bCZC170l3MD
 AJrd7M00/M6jlRBFxpEwFNJaAjvuKGRKQwgbFb0ObAhlUlUV/KQmJquxkZF+u8wMVvBUybNuSCM
 gaKhI0PSCgN7m3Wlrl5lv8pt92qsPPqtm/2REHw==
X-Google-Smtp-Source: AGHT+IFBjsOnNca0xtkDkBvsXjUruPNL8NlS6mWeK5+jHyLkwxXI02MQ8wUkwEO7202DRAGtdk9zUZuIzW9Nyd1aUSM=
X-Received: by 2002:a17:90a:fa42:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2d856382f44mr18373770a91.33.1725378321580; Tue, 03 Sep 2024
 08:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
In-Reply-To: <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 11:45:10 -0400
Message-ID: <CAEfUkULbQYYRwF3760_FEcy6BxZf2krnv+kdyDWuG1jAow6KUQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Thu, 29 Aug 2024 at 11:01, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Integrate common/hash.c on the hash shim layer so that hash APIs
> > from mbedtls can be leveraged by boot/image and efi_loader.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Use the original head files instead of creating new ones.
> > Changes in v3
> > - Add handle checkers for malloc.
> > Changes in v4
> > - None.
> > Changes in v5
> > - Add __maybe_unused to solve linker errors in some platforms.
> > - replace malloc with calloc.
> > Changes in v6
> > - None.
> >
> >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 146 insertions(+)
>
> I am not seeing the benefit of replacing U-Boot's hashing algorithms.
> They work well and don't change. Also it seems to be making the code a
> lot uglier, with an uncertain timeline for clean-up.
>
> The truth is that other MbedTLS modules e.g. x509, pkcs7 all depend on its
own digest library and there is no option for MbedTLS to depend on an
external
digest library.
Unless a refactoring in MbedTLS itself - I believe this is difficult for
the MbedTLS
project to adopt as it is aimed to be an all-in-one crypto solution.

Regards,
Raymond
