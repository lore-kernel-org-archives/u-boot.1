Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83B4D41D4A
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C902389536;
	Wed, 13 Nov 2024 14:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a/XHEueG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5372889536; Wed, 13 Nov 2024 14:39:44 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56CE288FC8
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9e71401844so868830366b.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731505182; x=1732109982; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R5BzLwYKIxRlnv5tPOin7Iu/BDNIOFMwnaL7ibzVL4g=;
 b=a/XHEueGl5dihhWf0iWcBBUEeY+jcMBh5GiaE6lE1WrCwSG6oJah//JA4YRVxdnMYO
 VCLut1T+wYaYRM8xQio04NRNwMu4zn6gFiRBDhuokdgHS2dvl8APDY0+vhRRIXdUCAhl
 5iMGpxqviS/v3akfRR22KY7eAV7z38Zy3JOnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731505182; x=1732109982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5BzLwYKIxRlnv5tPOin7Iu/BDNIOFMwnaL7ibzVL4g=;
 b=b55FgA8WtzHeJIQc0fXcRweouh4lAY06jJP5RH67BXmF+yTxlg8FARDJSCphX7pLir
 I7Y6i/fAzOW2B0StfFmTRn9g3KmQTFg4sllvYtCTT1FkwZfYEwHBcO8sXsHW9lvL7dt/
 vOiCP2QP9hQL2EiERsEZ/89lGKbJnqr7rnAHD9l2CLCOxH18aYy1cH1QUcwMM/E2Cf0d
 IrIY/MCTyUPrlUKCNqyoAebstk4Gk8dAz2/0RVf8hKxIaLeYzkOE9NnxleaKmG6UHby+
 F53b25etaoYUmPfyyoyqlSNnBFbQO5ednegWPZfoWadh96sPu5TQ7ttpgPhW6m7tglr9
 kihQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlQJS2hhIkUQucuBkopgEnsGuJ5buH5R8DAqXSP9WR4TUdEAEc+rh3xwP8QapJbvL/UiEuejc=@lists.denx.de
X-Gm-Message-State: AOJu0YyN0g9Pyas4K6XEpke11UxZ6dlXBa6HapGvPX4Q5Pfwc9A44gBx
 /frCpA71AcTsTrPpcnERiBOZyyY0C7CQiCpku0USDz7YNaN6l9EeB2fsjdGAey9OYiSBnoqRMiH
 jW3lTUN73XBqWUwCDqso1k317qLwIjHEBvc9o
X-Google-Smtp-Source: AGHT+IGg9MCoXzc+FvJkj7EgDoIugmgFFbt8EUZbqpZroxFYXyNpGVBPyuczvefBklB8hqEq31EyJLucaq1CWheWE9Y=
X-Received: by 2002:a17:907:846:b0:a9e:447b:6f76 with SMTP id
 a640c23a62f3a-aa1f8076ac9mr262121966b.31.1731505181666; Wed, 13 Nov 2024
 05:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <20241110083017.367565-5-ilias.apalodimas@linaro.org>
 <CAFLszThNpU2cNNvU4uT2vkgFKJr7ss=j_UYfXTFXA_b4=LnurA@mail.gmail.com>
 <CAC_iWjKFxtBxEqkkXSOhcRqN4fRRgMcsmFRVYeNZOnR4zERrQQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKFxtBxEqkkXSOhcRqN4fRRgMcsmFRVYeNZOnR4zERrQQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 06:39:28 -0700
Message-ID: <CAFLszTjou7yq-psYT3jBU7L8g81+bWUqc9Xj007zqfpfpnP9gg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] net: lwip: Enable https:// support for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, Anton.Antonov@arm.com, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
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

HI Ilias,

On Mon, 11 Nov 2024 at 07:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Thanks Simon,
>
> On Mon, 11 Nov 2024 at 15:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > On Sun, 10 Nov 2024 at 01:32, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > With the recent changes of lwip & mbedTLS we can now download from
> > > https:// urls instead of just http://.
> > > Adjust our wget lwip version parsing to support both URLs.
> > > While at it adjust the default TCP window for QEMU since https seems to
> > > require at least 16384
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >  cmd/Kconfig      | 19 +++++++++++
> > >  net/lwip/Kconfig |  2 +-
> > >  net/lwip/wget.c  | 86 +++++++++++++++++++++++++++++++++++++++++++-----
> > >  3 files changed, 97 insertions(+), 10 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Some nits / questions
> >
> > I am not sure what mbedtls_hardware_poll() is,
>
> It's an entropy collector used by mbedTLS to ensure the platform has
> enough entropy.
> It's required if your platform doesn't support standards like the
> /dev/urandom or Windows CryptoAPI.
>
> > but if @len is too
> > short, would it be acceptable to return an error? How many bytes is it
> > requesting in the https case?
>
> If you don't return enough entropy https:// will fail and mbedTLS &
> lwIP will print an error. I think we currently use 128 and the default
> for mbedTLS is 32.

OK, then the code is quite strange to me. It seems like it should
check that 'len' is large enough.

But what does 'len' actually mean? Its arguments are not described in
mbedtls. Shouldn't you just pass it on to the dm_rng_read() function?
Why call it with only 8 bytes? It might be more bytes than is
requested (and larger than the buffer), or fewer. It seems that your
function is written with knowledge of the internals of mbedtls.

BTW mbedtls_hardware_poll() is a strange name as it actually reads
random data, so I think it should be renamed.

>
> >
> > uclass_first_device() if you want the first device, not uclass_get_device(...0)
>
> Sure
>

Regards,
SImon
