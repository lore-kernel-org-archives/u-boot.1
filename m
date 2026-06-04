Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21116CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 05:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB32848DF;
	Thu,  4 Jun 2026 07:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LwguNklp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC69848D1; Thu,  4 Jun 2026 05:40:57 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255718467E
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 05:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC6CC3F613
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 03:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780544454;
 bh=ebiJ7S5CLl0zQTvo9b92tkb0leso9pRD80lGqbQjYsY=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=LwguNklpHun6rSSIypGPc6M3y7WEmNl6dUWumzH6HJ+Y77Kub7AXPnU6SmcPBOlqj
 q4sybTHLfcZsEGn8h499CN94hGJidXayF0qqesk/5GtpJW1NAg6xfdLtE/Pzqwqlq9
 8K5/H1+ggxBgrr4yRhU4abupTG/ySn8JHvz6kJ1QHPurugxyS1605wlIf1bqksM3MP
 q0aN81/IV1WIXlurUeGvhPjX4U6/vOLtuvanuKxdAWulR4OrvuiMT9Iq3mVAteyII8
 nHwiWhaSI2HPgifCAoHVqxGej6Q1Z/y7xqYWx1cX3vc8SyuXAug63IaZa0DRXo24jR
 05N15vJMvU3rPB4UL7aaM8AnAibLqt1mFbQB0JWK6KMGI/IemnUhQ8k7JhHVLs+uAj
 o3ir1GnSy3G5zMZNovF9gTONosgGKpkN95qtTTBMFWLY5JssQ3OnU8CQdn6qWJFCbI
 f/YwxO4gtbz6Is9OerrlneQh/gbL7ALeyaFinqmdYoNaK7LaEDgabQz9OWbwo/wUCx
 CXLqOdSxa2c6yvgEASjEKz8atxL/COdt+sY4Bghu1CGmvzWL0KhKDfq2uMrgQ5arji
 CwYhzaAMGU2iQ4PPKRCLfKo0+759O364ztOR29/pKcrEkQkfAML7a4GvBrKI8+QP/1
 EAAGPpriT6cRqpjgCx1sbgA8=
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-67e32a60b39so336287a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 20:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780544454; cv=none;
 d=google.com; s=arc-20240605;
 b=d7v0HRGepjNfneeRC9ns1Q5+KNV/Tood6vXnxtNPRtiv1hZodYjVl5pgAx9zOi/emY
 ITcQov03PObQaD4+dke1z7W0S5/19qoafggq9ti2GaSJ8O87Z5fg7O8a9FWH4oYoclr/
 GlP5L3agDKiMczr541UI76lMwFqow3mgmFDbzDtOLBx8cO1dhLBA6ksx1/aR+TpY3py4
 96WluP+C6AL/xWoxQ4WPkL0IHQ62WEUUzXoZJaYZNldg+yfrzAvNAcYXbSGnIvVNk+M8
 VyEitCqttL18JgOFeCkbMaeYuccpzCT2E+zawpbZjSDw6190XgKbfdNi98ogdlWb5JSs
 AbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=ebiJ7S5CLl0zQTvo9b92tkb0leso9pRD80lGqbQjYsY=;
 fh=9r7S9p3VRn7IEaRdmSc0Ybs7HmGN7dtMxEobdXEs+bg=;
 b=hopUx7GaOPbEK+/3cS8CjRdZQe76Ca4/VxmHAOZRTkutIvHhZYSTcThNGheDMw+FFD
 LYDymuPNWDXpqNPCKe1PwxVVtAldhFYifB5JMPPWWUCjQkZSz1+Zh10n60hWYXOGifLv
 MzufS4QdhLRX9/kS1Stc19fAK6v/LfxoDjlsj+Qly4/nZ9m3jEtyTrez6Ghp7L1o8gv4
 h4XIx4XD7hCVJdMWHQ/X7Sb1yXSTZ+mSqRzR43w+bvbjTBudbjatFd6jVASIQFM8sfdF
 oc3vwtPbUAq70sCDaq1IfrlfyecEUW85bx+jZvSJfNcMI/VyicyL8Chh3R9TFdgSPjaa
 Uo6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780544454; x=1781149254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ebiJ7S5CLl0zQTvo9b92tkb0leso9pRD80lGqbQjYsY=;
 b=XV8sS4rGZJwp03heUogHQLVBXuIpi5elHvEJcoq1sd/EA4RycKgt6wJQp5OG8iug2r
 Z1sRZm3ivTVfMFLkSC6yLCW7MHWg5SrzvasfNzdn9NBsNJhd1f2e57nZtWEzvawJUdUF
 OJtUB8RImkdW/l+whioyvkWM7/70Ws5Ibq888TvOwDbc6KE0Hbv3sDaKsyRwFfGyturs
 /0wOPnmevr9ELFJlbF2m+fW152xBu18kHC1cNYDpoQQfmXFK+QED9CFre8Q59zDug+KW
 MprI95H30It2G8ZIYBhxohzN0H9j+YzRl3oJIjyuW1X1JzonjSUOHbu94Vbz8vYHcO6k
 i8jA==
X-Gm-Message-State: AOJu0YwBNTNMSczJ43Ggwi9yNkjOw9fHMAwIdrhjyzUIIsSNJykBuEyR
 FdgURSsCTnr7POS8O/S2X6tmRZJ4F+/qnSvJdsrgGKbEZ/Xe7r5ZN0KSgZGMR+17TgwBRLmhY/i
 0y87YLRWKC4dsdNZnVjgvz2icnWrKo7mTiOapMikYBsB8+RA45PC2wj/NTjCKIYTmLxKDsk9tKA
 N+GghK8eChnBmAExahn458594qj0J39ppkaDrG0lCBYjGdFw==
X-Gm-Gg: Acq92OEzySZidu1FA7/Re6ahXuDFuDVxGSVmSz9u4Lk+uX0wbTZAKP8t2zjJ2EXPUYb
 wkLbX22aNm64ZJTuk3wbycTDKoGbb209MyVe809mu4zIRVkM1B6DpaAIYkksBwFmwgeWN47Gr+a
 /6v/A3HduZe/8ooP+weqAYuS2wpM74UhLU+JsQYePsCsJkmC3LlXA84FDR8RM1ZuK0uIrbR5q1S
 FlkOm1CDpVNKStkFg==
X-Received: by 2002:a05:6402:f1b:b0:68b:ca3c:6bbb with SMTP id
 4fb4d7f45d1cf-68f0f80d3f5mr595574a12.11.1780544454410; 
 Wed, 03 Jun 2026 20:40:54 -0700 (PDT)
X-Received: by 2002:a05:6402:f1b:b0:68b:ca3c:6bbb with SMTP id
 4fb4d7f45d1cf-68f0f80d3f5mr595571a12.11.1780544454093; Wed, 03 Jun 2026
 20:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260527150637.2850104-3-aristo.chen@canonical.com>
 <CAFLszTjP-BkQwa5REs61eac3A_0WKJ3fnMPWW72kJ17UcN42Uw@mail.gmail.com>
In-Reply-To: <CAFLszTjP-BkQwa5REs61eac3A_0WKJ3fnMPWW72kJ17UcN42Uw@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Thu, 4 Jun 2026 11:40:42 +0800
X-Gm-Features: AVHnY4KknrLfUP1ol_Yv3bX9njAM7rMSD6ilaY13PiRLl45OpR1MuCCwfjB_0EU
Message-ID: <CAA=k7=mWenNMakvFuD-C-w_8QkLs=eUjaJpFk7+Jz1Xd4LKBXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] test/py: test kernel_noload decompression buffer
 overflow
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:10:31 +0200
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

On Thu, Jun 4, 2026 at 12:52=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Aristo,
>
> On 2026-05-27T15:04:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> > test/py: test kernel_noload decompression buffer overflow
> >
> > Add sandbox tests that exercise the per-image decompression buffer that
> > bootm_load_os() allocates for a compressed kernel_noload image
> > (ALIGN(image_len * 4, SZ_1M)).
> >
> > The overflow test builds a FIT whose decompressed size far exceeds the
> > per-image buffer and asserts that 'bootm loados' rejects it with a
> > decompression error rather than overflowing.
> >
> > The boundary test builds a FIT whose decompressed size equals the
> > per-image buffer exactly and asserts that 'bootm loados' succeeds,
> > guarding against an off-by-one rejection at the buffer limit.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > test/py/tests/test_fit.py | 126 +++++++++++++++++++++++++++++++++++++++=
+++++++
> >  1 file changed, 126 insertions(+)
>
> You didn't pick up my review tag so I hope you don't mind a few more nits

Sure, I don't mind, I will fix them :)

>
> > diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
> > @@ -426,3 +456,99 @@ class TestFitImage:
> > +        ubman.run_command('bootm loados', wait_for_prompt=3DFalse)
> > +        matched =3D ubman.p.expect(['Image too large', ubman.prompt_co=
mpiled])
>
> Please use ubman.expect() rather than reaching into ubman.p directly
>
> > diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
> > @@ -117,6 +117,36 @@ host save hostfs 0 %(loadables1_addr)x %(loadables=
1_out)s %(loadables1_size)x
> > +# A minimal ITS for a compressed 'kernel_noload' kernel. bootm allocat=
es a
> > +# per-image decompression buffer for this image type, sized as a multi=
ple of
> > +# the compressed length; see the test_fit_kernel_noload_decomp_* tests=
.
> > +NOLOAD_ITS =3D '''
>
> The test could use a buildconfigspec('gzip')
>
> Regards,
> Simon

Regards,
Aristo
