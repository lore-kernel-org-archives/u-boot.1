Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3718C3600C
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 05:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C451C82B17;
	Sun,  6 Apr 2025 07:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="r/Q5aLRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FD882B1F; Sun,  6 Apr 2025 07:15:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7137B810E8
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 07:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E2103F5A0
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 05:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743916502;
 bh=g6uZn/GnH6J3Jf0S6xm2A/akvYJnrtYTZxscOqsOBrg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=r/Q5aLRk5CFlup9JZFmqHSiTk0JNVV3Jd+ZkLTm5Lul3kDc5UAwcP4LB2IkMM3zdj
 ncaAqiVjXUGudC5s0vrg2xIBb4lFDZpU+TiozOg1w95694Ujy6T3vXuDoVWUU3Ld48
 ic0nrT5f5UbKX7E1xoI84U4OZyzdRR/TuhO9eUFe4khx8fcfz8KbmRYvo+6ztobRLQ
 A0Oj2aIjmk2J1cAcV15gEeU8QwrgIW74IuDC9ak8uCJ3WT75v4sjZweMZZ4K0at/U9
 lNT7ppe/j3wery/klFbZELU+UvGlLuj8F5NMJS1yLeLfT2OMkxBwRP8mkk/vN3fzve
 7x80NiCKKcQMQ==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff581215f7so2640205a91.3
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 22:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743916501; x=1744521301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g6uZn/GnH6J3Jf0S6xm2A/akvYJnrtYTZxscOqsOBrg=;
 b=TUqtHKoWr/wIVVj1W7mJgmB3ZgpCRqcOYz/hNFgbVxVE1VQsb7IoMSAxK1cn3LObAh
 M0rlubQ2fj4gAjjgS9h/YV6+vS6OX/mzm6LCpp6WeKlycXWmKdQjZfk7biNxn2U60NKv
 PbiNWzFc0MQq4X+HePAo7m5rkyionEtg0RQDG3vd9/a0JbosdbbucnpaOvuHRGg7wc1F
 V/auGJJofaGShgVAOIYFALmY8nhMZeMOelSumhteXswonZ7rLiFqSOaFzjXwbiB9qfSa
 DoMzXPb4Qlccxt/fVaBopSAUmBTqiqfjbIpK7ydGMuPRhKZbDP6fxEuuXKh8HllpqRbD
 EVeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURswAJhGjo+80xKcwXYYfTfAGhiqmaptR9idb0eYtlXw0dODCCfTpjK/NkC2NlyF+JkRr5cqY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywm9bqXGQE4rlzNsn9JWMcZ6/l0xsfRgitCVSw2CpPVuJhT55BN
 scG0yaFlVmFkjAwKE9Qs90qG/bN4nglkdAi7xEr2IkyY7aL3EcYeIi0PWqEtFcF8Jm8Osl5PaVF
 X0ocPOIYJNKOcFMWMOM7hCuQCYoIzVyMnlMDpLEd54tN0l8ipSFrEGV+ExdHpjJLk4zjncRuo0j
 7b/q7ao5D1JAzYWkcL48XVpK5UiqJTDZ3ZAZLbfU3nxw==
X-Gm-Gg: ASbGnctD/rtM3hpZzBisC900Sezp7HsQg0uPAx7TCsKQnLGlsf4F4UpZwKD3qzcVO29
 ZzNesh1GtFYMs4JRjs3iJKsv+FploSuT5v6zlPfs+4YdetMVGM1nYywc5c9ip85r1BBaQjkm4MO
 Hfh/GXpQiUjQsXyymo76gPpGpGd9+/Rg==
X-Received: by 2002:a17:90b:5490:b0:2ff:62b7:dcc0 with SMTP id
 98e67ed59e1d1-306a615b74dmr11231345a91.15.1743916500789; 
 Sat, 05 Apr 2025 22:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT4Zl5TFCG+EL1aTryu3Zs9EWUwUVK/YPaz2VzL0Zevke0UT2tGr8+cnj+b6AveTCr6kSn8b+Lv0Earjn7k08=
X-Received: by 2002:a17:90b:5490:b0:2ff:62b7:dcc0 with SMTP id
 98e67ed59e1d1-306a615b74dmr11231325a91.15.1743916500393; Sat, 05 Apr 2025
 22:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgp38yBXnSigfT-mEFU=rqyAKjp0WBQGgHP_N3vRxCq=Q@mail.gmail.com>
In-Reply-To: <CAFLszTgp38yBXnSigfT-mEFU=rqyAKjp0WBQGgHP_N3vRxCq=Q@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sun, 6 Apr 2025 07:14:49 +0200
X-Gm-Features: ATxdqUERCm8j6_RszrMBBIxpnpevA-599hxYiRHw8bZ6_-ZfV6iHB2_CEhSdBX0
Message-ID: <CAM=mAOnCdLWMUfU1DCdUu0RdM0-PXaW_2XrPT5UaKOCSNU4PaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michael Brown <mcb30@ipxe.org>,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Simon Glass <sjg@chromium.org> schrieb am Sa., 5. Apr. 2025, 22:46:

> Hi,
>
> On Sat, 5 Apr 2025 at 19:58, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > It has been reported that memory corruption can occurred because networ=
k
> > packages where received after EXIT_BOOT_SERVICES. See the thread
> > starting at [1].
> >
> > We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
> >
> > * Some network drivers don't call their own stop method when removed.
> > * Some network drivers don't have a remove method.
> > * Some devices have CONFIG_DM_DEVICE_REMOVE=3Dn.
>
> A few points:
> 1. Only three boards disable DM_DEVICE_REMOVE and enable EFI_LOADER;
> EFI_LOADER must depend on it or select it
>

Why does that option exist at all?
How would a driver live on when U-Boot is not around?

My two cents: That option should vanish as it is incompatible with the
driver model.

2. If devices don't enable DM_DEVICE_REMOVE we'll have similar
> problems with USB, etc.

3. The code in efi_boottime.c should be unified with
> announce_and_cleanup() since otherwise this will happen on the non-EFI
> path
>
> Please do at least (1) now, if this patch is targeted at the imminent
> release.


> Also, we need a fix in the affected network driver, although I suspect
> the reporter will do that.
>

You just sent patches for the network drivers.

Best regards

Heinrich


> Regards,
> Simon
>
>
>
>
> >
> > Let's call eth_halt() in EXIT_BOOT_SERVICES explicitly.
> >
> > [1]
> >
> https://lore.kernel.org/all/C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschu=
tter.com/
> >
> > Cc: Michael Brown <mcb30@ipxe.org>
> > Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_boottime.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c
> b/lib/efi_loader/efi_boottime.c
> > index 5164cb15986..eaa6464fa39 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -15,6 +15,7 @@
> >  #include <irq_func.h>
> >  #include <log.h>
> >  #include <malloc.h>
> > +#include <net-common.h>
> >  #include <pe.h>
> >  #include <time.h>
> >  #include <u-boot/crc.h>
> > @@ -2235,6 +2236,8 @@ static efi_status_t EFIAPI
> efi_exit_boot_services(efi_handle_t image_handle,
> >                 bootm_disable_interrupts();
> >                 if (IS_ENABLED(CONFIG_USB_DEVICE))
> >                         udc_disconnect();
> > +               if (IS_ENABLED(CONFIG_DM_ETH))
> > +                       eth_halt();
> >                 board_quiesce_devices();
> >                 dm_remove_devices_active();
> >         }
> > --
> > 2.48.1
> >
>
