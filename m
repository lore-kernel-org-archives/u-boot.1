Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF84FD462CF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAEB895AD;
	Wed, 13 Nov 2024 17:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bYdCKHMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66DBC895A3; Wed, 13 Nov 2024 17:04:06 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3024788DFA
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso628910566b.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731513843; x=1732118643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bb5b9VQqkJ/l/yz3mqefkY4PduUJrXpgcAKGRRXbKTs=;
 b=bYdCKHMFfazeRrg/RdFkAkQC0IB6juADQ7/Ksv9cHB7LOpmYaURyH7oHCtT/3B3ryW
 15S8EHY0o5A0hfW9XItkReozaqAtIVIaQNpCvQ9/3iLye9w9uz7280UHFsKwPUNXkbgJ
 vLE7U0mLh1Bzz0Zh9VZpowCa2Hj2Pme2WeJBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731513843; x=1732118643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bb5b9VQqkJ/l/yz3mqefkY4PduUJrXpgcAKGRRXbKTs=;
 b=GDMH9l90uIatw80YnzZGhZujGACQqwp+OC7pgyLc1QWNg2MJ3FUmrUZkMn2vKi4WH6
 KRROT0kGn6SPUhfnz5ekWWoqvz72IvOJ4raDQTcW5siJlW5k+QNBfrd142yqi11qqbGk
 XD2jZQNF+eMbGz4HMChO/m0umcWuvi14WknRDKvuITBP/23ltdnKJy2iTIzvRvqVFeCn
 cm5kNIsFvCo9X0R+WRZTKlkhfzkqkc9v5AtYuseIPjmuLEonCjiOtBQjVTUorskd6PEm
 DGNHR55hiSc51P8g89i6NleV2+OJWWBouuf70vcxi4Z7tSsXumFEe2ji+wMApXEd2DXU
 wEAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZNBfODkxvOB6Laoh+nJC0DSSOtymqa05buCl99EJvlb8USH2mkph/6KIzPWkLHUh2bG145yA=@lists.denx.de
X-Gm-Message-State: AOJu0YwPoJbq5P/kGVpaMff6TSuagT8tpZ0nBMNZpVb85PJo+Chme1EO
 M/THiyLb7PlFccNPm2AyntrQq4NtqLSxo2fu1P/sx3wKQwi+AjpUprujOAeGMwIXXDQcQ+Ns5PC
 DJECHuyNgWd33vICEBirhaFHT6ImcghylOLBe
X-Google-Smtp-Source: AGHT+IFO+XHpye0glQzumQ/MSeKBLnBDWyYP/8TuTh0a1fc7PgopBGp8k9bvfdTH0sUGLinS5ignTmnk/Gsdydfswu8=
X-Received: by 2002:a17:907:31c2:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-aa1f810644amr321797566b.38.1731513843191; Wed, 13 Nov 2024
 08:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <20241110083017.367565-5-ilias.apalodimas@linaro.org>
 <CAFLszThNpU2cNNvU4uT2vkgFKJr7ss=j_UYfXTFXA_b4=LnurA@mail.gmail.com>
 <CAC_iWjKFxtBxEqkkXSOhcRqN4fRRgMcsmFRVYeNZOnR4zERrQQ@mail.gmail.com>
 <CAFLszTjou7yq-psYT3jBU7L8g81+bWUqc9Xj007zqfpfpnP9gg@mail.gmail.com>
 <CAC_iWjJdK6D+inVSMqJ941yvpDvK4j5XufvA1Fije3aqZvm=1g@mail.gmail.com>
 <CAFLszTiG9AMPs7q9QJgD5bP4=QwXVxQrOJqpWARamkPXS8p4wg@mail.gmail.com>
 <CAC_iWjL6BDhRHTYWW25N2v8Aw_MbwTzc+FAX1c6akGKypLKFEA@mail.gmail.com>
In-Reply-To: <CAC_iWjL6BDhRHTYWW25N2v8Aw_MbwTzc+FAX1c6akGKypLKFEA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 09:03:51 -0700
Message-ID: <CAFLszTiPNMEGFPsbsuagcVooPDb_eawafnb=7hWGaDmNYbrqyg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] net: lwip: Enable https:// support for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Anton Antonov <Anton.Antonov@arm.com>, 
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
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Wed, 13 Nov 2024 at 08:11, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:
>
> On Wed, 13 Nov 2024 at 17:09, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 13 Nov 2024 at 07:46, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Wed, 13 Nov 2024 at 15:39, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > HI Ilias,
> > > >
> > > > On Mon, 11 Nov 2024 at 07:20, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Thanks Simon,
> > > > >
> > > > > On Mon, 11 Nov 2024 at 15:03, Simon Glass <sjg@chromium.org>
wrote:
> > > > > >
> > > > > > On Sun, 10 Nov 2024 at 01:32, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > With the recent changes of lwip & mbedTLS we can now download
from
> > > > > > > https:// urls instead of just http://.
> > > > > > > Adjust our wget lwip version parsing to support both URLs.
> > > > > > > While at it adjust the default TCP window for QEMU since
https seems to
> > > > > > > require at least 16384
> > > > > > >
> > > > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > ---
> > > > > > >  cmd/Kconfig      | 19 +++++++++++
> > > > > > >  net/lwip/Kconfig |  2 +-
> > > > > > >  net/lwip/wget.c  | 86
+++++++++++++++++++++++++++++++++++++++++++-----
> > > > > > >  3 files changed, 97 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > Some nits / questions
> > > > > >
> > > > > > I am not sure what mbedtls_hardware_poll() is,
> > > > >
> > > > > It's an entropy collector used by mbedTLS to ensure the platform
has
> > > > > enough entropy.
> > > > > It's required if your platform doesn't support standards like the
> > > > > /dev/urandom or Windows CryptoAPI.
> > > > >
> > > > > > but if @len is too
> > > > > > short, would it be acceptable to return an error? How many
bytes is it
> > > > > > requesting in the https case?
> > > > >
> > > > > If you don't return enough entropy https:// will fail and mbedTLS
&
> > > > > lwIP will print an error. I think we currently use 128 and the
default
> > > > > for mbedTLS is 32.
> > > >
> > > > OK, then the code is quite strange to me. It seems like it should
> > > > check that 'len' is large enough.
> > > >
> > > > But what does 'len' actually mean? Its arguments are not described
in
> > > > mbedtls. Shouldn't you just pass it on to the dm_rng_read()
function?
> > >
> > > The entry point is mbedtls_entropy_func(). mbedtls then calls
> > > entropy_gather_internal() which asks for some bytes of entropy and is
> > > controlled by a config option (and defaults to 128 for the config we
> > > use in U-Boot -- MBEDTLS_ENTROPY_MAX_GATHER). len is actually
> > > MBEDTLS_ENTROPY_MAX_GATHER.
> > >
> > > > Why call it with only 8 bytes? It might be more bytes than is
> > > > requested (and larger than the buffer), or fewer.
> > >
> > > It doesn't matter because we copy back the correct amount of
> > > bytes(what the caller requested). If it's less mbedTLS calls that
> > > function until it gathers all requested entropy.
> > >
> > > > It seems that your
> > > > function is written with knowledge of the internals of mbedtls.
> > >
> > > Ofc it is. It's a function needed by mbedTLS -- not U-Boot, it
> > > requires internal knowledge of it (and is probably part of the ABI,
> > > but I'll have to check that).
> > >
> > > What happens in the TLS case is that 64b are required. We either make
> > > 8 calls of 8b or make a single call with MBEDTLS_ENTROPY_MAX_GATHER.
> > >
> > >  I could rewrite it as
> > >         uclass_first_device(UCLASS_RNG, &dev);
> > >         if (!dev) {
> > >                 log_err("Failed to get an rng device\n");
> > >                 return ret;
> > >         }
> > >
> > >         rng = malloc(len);
> > >         if (!rng)
> > >                 return -ENOMEM;
> > >
> > >         ret = dm_rng_read(dev, rng, len);
> > >         if (ret) {
> > >                 free(rng);
> > >                 return ret;
> > >         }
> > >
> > >         memcpy(output, rng, len);
> > >         *olen = len;
> > >         free(rng);
> > >
> > > It does the same thing but gets 128b in one go. I don't have a strong
> > > opinion on that. Let me know what you prefer
> > > The tradeoff seems pretty straightforward. you either gather
> > > potentially more entropy than required and call that function once, or
> > > you gather exactly what's required on 8b steps -- but call that
> > > function multiple times.
> > >
> > > >
> > > > BTW mbedtls_hardware_poll() is a strange name as it actually reads
> > > > random data, so I think it should be renamed.
> > >
> > > I don't think that can't change as you would break all projects using
> > > it, but you can try sending a patch.
> >
> > I am wondering why we can't just do:
> >
> > ret = dm_rng_read(dev, rng, len);
> > if (ret)
> >    return ret;
> >
> > *olen = len;
>
> I am not sure I am following. Do that were?

Oh, I had that wrong, so very confusing, sorry. Something like this:

+int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
+                         size_t *olen)
+{
+       struct udevice *dev;
+       int ret;
+
+       ret = uclass_get_device(UCLASS_RNG, 0, &dev);
+       if (ret) {
+               log_err("Failed to get an rng: %d\n", ret);
+               return ret;
+       }
+       ret = dm_rng_read(dev, output, len);
+       if (ret)
+               return ret;
+
+       *olen = len;
+
+       return 0;
+}

Regards,
Simon
