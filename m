Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BC2CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A3B84995;
	Thu, 18 Jun 2026 17:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mKornHQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F185849AE; Thu, 18 Jun 2026 17:21:24 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965CF847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-662d484ff3bso1332604d50.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781796079; cv=none;
 d=google.com; s=arc-20240605;
 b=fDELPk1bOHcKdDyyh/wttp11yRX8oiQ7XTygsTdR58MGr6zckhsyDGAvA/zNEXPHcf
 eHh0q/pVkBMfIo/0J34SQL9ron8zQVJmIF8NbkqUzsDl6vdkFyhFlZB9nINscsFG3q+S
 9lBKVaGNlGMdRz+yoWU5GprNUqlfwt30vy5bCk+f1tdhLCNw7iaOrHL9tBK1f/42hV/r
 V78q19Rfk71pVhc5xAhXQuMSvOCaNjZMmObjHdmRt15R3kZM8GLdmCk3puiggXUjZh+2
 fY9Meaq0qEtZocu8Pxl6l4b58IqLNbgzUYhrn7jmhPGhSLYBXU1NHnbm2znob3g4Ac9R
 uhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JPLpcS8wTaf60tiIHyCnAnBeQf3N+PausmlX+dx8L64=;
 fh=9HuxLRwJJD/na31yxbiiqmgcH2p73fFvDXRHz6tul2o=;
 b=XfzmmDWoyamZuz0gl2w9UOkvVWjSd4sgIPPN0YjQxAjr+o4VixJsznnhUsseHomjiX
 F6SJFLrwU2RFfHnQ1rqbfxLxQ9f0LFyTC0+0S4Pl1LwKL0X1xh0vcCNOekAU6Gul4Lep
 6Yx/ophdMGEtJOlt69lZLdLKczBce3EPnsmqwc3rsv11yeEWYgShjJSiz1WM2WOkJ8OM
 JCOyyIaS0HIFWPV5dqiGWRB8tJ1W/bxYrybNJuUGcsjnbQS/ZGTuPErttlS9bVR9vZct
 Xuidn1OSJPcefuGCfgEEYTdL4p0K8YXAVz7q+1MyByMlB6NGIbl8ozghKygA6V3C4jS1
 CyDw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781796079; x=1782400879; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JPLpcS8wTaf60tiIHyCnAnBeQf3N+PausmlX+dx8L64=;
 b=mKornHQkV6h8cmcx66PAt4uj2QpWM2rtYPJfcLkFhWpHzsn2iyQ7I9LSVntVRjweek
 zedNSUVBbueWtPB3RTxjDZSoFxyag/6bVNlFefZ9/KDVbRR472kk76H78BSKWBX3F3OE
 /W3J0rNu+eZktu/qk49Y8RV0Dt4cRjbFOvSKyBpvbunJE8VPyh2eEaLF3cpZZPiCgnx+
 VKpIK4G6RlEuz6WZAN7xvN87AgZ5YvX0CqGzGz67FwZnTaCe5A+uVrm81uX0Fr23gX1W
 Q9hZjmn80IdZmOf2ooQnaRuAEhdO4N0s+pcjdd9P+QhK3OhddWjp4L7dZ8z5FOCkSLOo
 Z2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796079; x=1782400879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPLpcS8wTaf60tiIHyCnAnBeQf3N+PausmlX+dx8L64=;
 b=m708zBnzmGdxAZeGigGghtOUyVfX2eVm2eGgVHrzjabzwB3I0U9Yh1QeICGPSrcXfO
 6Z6i76KHxz6sYin3KUwYfX2A9X4okitRrgsd+qbw6xh0dE6SZ+wt0SQ/BH6zvmKIYbl3
 dkpTBBKmvmCLPjKET9oHJBzdO9clHsSWeGD7cG/uLdlvnr13uHSgZZETj3R19NwtMSTJ
 mYruqB86bMzQw9qMG/jmpopldfYDSmsgcKkbu7iffSCpIRDuCLTdeWOLJnaxyt2NIThv
 mDmwQzy8aAjKgNilHRF9iOLKf53njrTiXz4EtHgeDy0LT/w7zD2Z8mwEhzKezWrtt0MD
 um0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+z3h4UA7UJNyBGl+UFwnS/25hIcRjRPPH//wRkwNg7oXx761JmTvOr3ca8Xwy1WpiPsgkotSk=@lists.denx.de
X-Gm-Message-State: AOJu0YyrdQNGARBwJ0jOhalpveWpCDLrNVvn5a+3wNsEavB/8SokFs5T
 eYASqHURHdPyVdJ0vbwUo/7WGZWMU5uEGOq+3BWH4BiwUqU07FNUP9tWGyUeC5cjrN3HbWAR4NM
 EH0ScEcL5K8IgZAmO44j7cIjOmez76TKEzQQgZwaAow==
X-Gm-Gg: AfdE7ckund98h5JXVhQI1aAbAs+kGAmR8kycBXjROzOD5UvS0l47yCPjUtGXNKcdoXy
 oaaq8D73CxW3XfoXfLR/LfdZkLqXeFtY3OmoKul3JH9oUxK9O8CDfQwQ648FlmDvguMLJtcIt7x
 +NH6Or0NVH+rDaYEzCjioGjW1DXjxU7DMTBFS/KPSDeVs5CDCJX8/2RJkQaoQHXf5pqej2FLA/E
 DAeU72HE1YKApsL9KA6dDmb8mZHMd1UDaEIR3rI3/rrU08FGXG2lVNDo+zXMGnqJx5TpOdX1ouw
 egBVa6IOnNsqnY98v40ogRZe35slUTXFHS+X7MeexwmMthq0HpRzkhbSO2/Na8Y66ucAiXeke55
 w+JneUR9G8H9TAeajCYtEP1KQKQzVxGHLxsF0ESNNRYWtLe/EQjh89hcBxpx71MHq9LR4CYRNiO
 Cs3CsFT4OoQhBKan0XtOdbizxzqfSxIoRHizdLwFrEIhWCC1C6Cj2kCAnkcbhLCq237mNutaQDf
 uHRbXmZLwAA1T5vMBm4SWAwIeM6T+uii1L11RkKEQCjOFVZxmrH6oPAefuZ3SuTZrBAKPDmAG0n
 5dibE8go54iAz2xJpY/44TmTF2UXw4AydiBaRkIujFiGNcCcbFhJS69GnyNxKQN6/BtDkB2bpE9
 Vp1rJlIQ=
X-Received: by 2002:a05:690e:43c2:b0:660:7ced:55cb with SMTP id
 956f58d0204a3-662fc6799fbmr47700d50.1.1781796079026; Thu, 18 Jun 2026
 08:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
In-Reply-To: <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Jun 2026 18:20:43 +0300
X-Gm-Features: AVVi8CfONbMeEooVzDA09It4InysTP4uycGumb79W4l2VCiKG3zQ1FeCkqBHfCk
Message-ID: <CAC_iWj+5u3P3r2jfeXXT=n13uAnStE+vAPxPWS0F2SwjSZP7rw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: add missing EFI_EXIT in
 efi_disconnect_controller
To: Simon Glass <sjg@chromium.org>
Cc: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Vincent,


On Thu, 18 Jun 2026 at 18:19, Simon Glass <sjg@chromium.org> wrote:

> Hi Vincent,
>
> On Thu, 18 Jun 2026 at 16:09, Vincent Stehl=C3=A9 <vincent.stehle@arm.com=
>
> wrote:
> >
> > Make sure to call EFI_EXIT() in efi_disconnect_controller(), when
> returning
> > after having called EFI_ENTRY().
> >
> > This is inspired by a barebox fix. [1]
>
> Hmm, does Barebox support EFI_LOADER now? I wish we could bring these
> projects back together :-)
>
> >
> > Link:
> https://git.pengutronix.de/cgit/barebox/commit/?id=3D080db65e39a877b000ba=
af843c997a69821dfe69
> [1]
> > Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole
> child")
> > Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  lib/efi_loader/efi_boottime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c
> b/lib/efi_loader/efi_boottime.c
> > index de57823bd44..b6966652d97 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
> >                                       &number_of_children,
> >                                       &child_handle_buffer);
> >         if (r !=3D EFI_SUCCESS)
> > -               return r;
> > +               return EFI_EXIT(r);
>

Any reason we can just goto out;

Thanks
/Ilias

> >         sole_child =3D (number_of_children =3D=3D 1);
> >
> >         if (child_handle) {
> > --
> > 2.53.0
> >
>
> Regards,
> Simon
>
