Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E093AC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 18:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A108283E;
	Tue,  3 Jun 2025 20:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="otYpmryJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F176382AF6; Tue,  3 Jun 2025 20:00:39 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494BC822D7
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 20:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-312116d75a6so4947156a91.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 11:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748973636; x=1749578436; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/eH7fmDb7pO23S63bgCI2BxKOEvgmGMmJhIj1xAexs=;
 b=otYpmryJ1iUUPRUDEqFXo+pZJOqe9fBu68eLXSM0gw7VwPS0J0W04RnMrzGtfEIb4A
 sdCubn3kPbOZy4h2K8C+974l9Yjj9zfmgvG8lYVZfpSfHUakd102eQ4Q4LCRRVEQqZwQ
 vdrgT3qY29kvJWokcKa3M7c6F4x/jeUj6adDKQHU3+CY4JFEtxu9ff1UeSB63h3/8BzZ
 FBeZuQp0L2LJ1JfiUWnqrj9qriiQ19Zj/TrTMfxPblTYlwhxnrgbfM6FRZwZPKzbsXY2
 gjYWzJHX6oz3/h10efotmrBkBUd3kCgZEuLjr06M6Og0bqO5EdkBJ+4hAuEMrHVggNF2
 LPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748973636; x=1749578436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/eH7fmDb7pO23S63bgCI2BxKOEvgmGMmJhIj1xAexs=;
 b=h9NGxTTPa98EWwpJIrO6VfXGnf6F7rS4O1F3p+Q6lpsJC+BaJfqEIvPdfGkmEp6Mfv
 9+kdBqAhSYO7+ZZTmWFrckTMOCjjT7Pri/F6q2sAu3CIeaNyPKt3DgiyPlPeIRswl7vf
 mHEzZprM2ypmlWtm4yOzslbGmajddU9BqfX8cbud4TsDRNDCJMqaX34Virvcag7Z1paj
 +XRHtp3Z29OPzURAPGfMRfLIYmBI8+W5U5kmXvuckm2aPmafRXaaBZG5DXHzEqj0Hbyv
 5a37w+8WA3Gw7bIlqEsz3lk+LahOmmNLg5KkWq4aNujWrC9M2Q/n7UJXFwGN7zg/16Tb
 Yvkw==
X-Gm-Message-State: AOJu0YyEY7m0nAWVsWvwSZb/bPGl80Nul2HFlcWlVO6dSTjlRiiOLY27
 gfW1RDl5UKLBUbvdegzkr7IiSF+v8i6/ujpBtRc9vrNgxBmnqTfm/4GpOIGKWyufWtmnM1nTdng
 y+E7PVQUwvJmWTHKVzmaDiFxQF7gXo+AOM+24Wf5sNA==
X-Gm-Gg: ASbGncvugcuu41s//DiHXYu+4pywnEmJMLgPEExNUi/+xhTJ6KvVsSObbegSNLYVKq2
 0Qzuxf2bPnJnqg1PBXYpr6lteSxENF6IB3kl/9VyKYMzJ3UKQ5KeuS1ADyjmIPNjvrmBhAHKWS7
 rDsAAUcmGHnksyouXJKH7wIlmDuFqLPHbkXLdP1E9QmzTB
X-Google-Smtp-Source: AGHT+IG/LxSK8tLrfbpFKbIzf9cLk75iAOsHfAFpDxptV9+Z2oWw5L/AfgpqQ+pcbM+EMUOMdHRf3GYCQQhA085ZPPY=
X-Received: by 2002:a17:90b:1cce:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-3130cca814fmr73612a91.3.1748973635786; Tue, 03 Jun 2025
 11:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
In-Reply-To: <20250603154748.GG1382132@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Jun 2025 14:00:23 -0400
X-Gm-Features: AX0GCFuVt_9Gq3BZXY2eSLUAQVccqQP6MMlWCaXBcMvMOLQTGm1pViqO2vm394E
Message-ID: <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>, 
 Prasad Kummari <prasad.kummari@amd.com>
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

On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
>
> > This patch is to solve the sandbox building error:
> > $ make O=build-sandbox -s sandbox_defconfig
> > $ make O=build-sandbox -s -j2
> > /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
> > /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
> > collect2: error: ld returned 1 exit status
> > [...]
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  arch/sandbox/config.mk | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> OK, but how do you get this failure to start with? What host?
It failed when I started any sandbox unit test like:
./test/py/test.py --bd sandbox --build -k <any_test>
My local host: Ubuntu v20.04, x86_64

Regards,
Raymond

>
> --
> Tom
