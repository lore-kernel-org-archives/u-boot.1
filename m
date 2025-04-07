Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED574C36002
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 01:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D5282BCD;
	Mon,  7 Apr 2025 03:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I5GqnvuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4A482BDC; Mon,  7 Apr 2025 03:06:51 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03D082B9D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 03:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac289147833so626210566b.2
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 18:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743988008; x=1744592808; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbYCBdwK2iQhoYlZ3tAFTQusM86W+xXVcKRri+aRBYw=;
 b=I5GqnvuTW5lorkc7mPsldfdVIOp2RMCUY4eCXdc7bk67lOcZADCS44rX2DTBctLn5Q
 ZxxDYuPZW/ZlFc1HuKa8oiveboHgYo7De2eHQqZAnNuqZpj0QqCQVmA08bqSlSMnHPCI
 mA+oX6C2rOjWuP3DOPn8TAJVoIw1w7Nq9BHxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743988008; x=1744592808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbYCBdwK2iQhoYlZ3tAFTQusM86W+xXVcKRri+aRBYw=;
 b=e7aNttcj8bp/jX2sE7mwJ2HgA5DeLrOCoXgU8lGPQns+bG3EHaaYwUVwgBbSY8/Xv6
 VP1Tx9LPQgUDXisC/UWqhXmvFFPYDWqeugPberdGiwG3LVl5K8tlkCpm9Uz/43iAiUzr
 KU0CRN//gY2ZFVNyOvbU2tb8f2pf9LePAZkEHN3Hy12+LXrZtRYZock7p9pFLiS16bIC
 O4CYgNosgPLCZZx/wTpdEALWl7VEX1gV8hdlp0vHhQbmWRL4g1bdC0ePAJ7+bHHB2x/d
 cBSaveiuNlRjaIbuSvwHOCJ3hP99+f24LfnpBUsqVWPHe84F+dkI8DDmwntoiyySybxK
 80SQ==
X-Gm-Message-State: AOJu0Yz5S/V/JVc524mmh7JhnvEjD/Glwf2Crrt/Eka/EwDdYkXId7Lh
 d/NIWp8nh5NFgvLe3O2DbEYsaoXlCM2Tmz2720B09ZPYVgowEdFmSwGyn0okB7ICLOAG/l9s/5M
 XHw7f4e7g335i98ytEvVqN3I4QFv2XqOUD4kM
X-Gm-Gg: ASbGncuAc/2rXDhjE9VOpzhzqrL3p9P5lZZo76IEXJLxIdyxC+AsgQTc5YB+migLPYA
 vET7gI6L0gEyEfnlZC1Dl1eUhsdq+yNw+QLok32v/R0o8WrCaIYX9Vz8+e7GqOSyVqWJRN7cPx0
 bMOSsmWMWz7KPSgG82IQFWqbc/aYcqsMyGsGvIQJg=
X-Google-Smtp-Source: AGHT+IGEWiya2Mfnaj6OUbNWGzihsvauMw6PPqEVVoNIZkm4rEQmCx/fjOenQXETrKyM7iESYUdqGVzY0ZhlZUVgamQ=
X-Received: by 2002:a17:907:2d0b:b0:ac2:fd70:dd98 with SMTP id
 a640c23a62f3a-ac7d18a1f49mr840589766b.22.1743988008057; Sun, 06 Apr 2025
 18:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250405221308.498047-1-sjg@chromium.org>
 <20250405221308.498047-3-sjg@chromium.org>
 <6E95E440-67E4-4054-9662-871671684B7E@gmx.de>
In-Reply-To: <6E95E440-67E4-4054-9662-871671684B7E@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 13:06:36 +1200
X-Gm-Features: ATxdqUFqDHeHcuJWaOtz-vBHWUKwBNXd6cNUjxW4kZ7mx5bNArvRiYoMLNHg24A
Message-ID: <CAFLszTjbWpC75kwaYN_DCezkKgK5+BAOt9DUd6JhhXrK4kA0Ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: Move device-removal later in
 exit-boot-services
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org, 
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Sun, 6 Apr 2025 at 10:30, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:
>
> Am 6. April 2025 00:12:47 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >This removal should be the last thing done, so that U-Boot does no more
> >memory allocations afterwards. Move it and add a comment.
> >
> >Note that the TCG2 log is updated after this call, but I cannot see any
> >allocations there.
> >
> >Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
>
> This commit message fails to describe which problem has been observed and=
 you try to solve.
>
> A link to the original communication would be helpful.

OK I'll add those.

>
> Furthermore, please, rebase it on my patch adding eth_halt().
> <https://lore.kernel.org/u-boot/CAFLszTgp38yBXnSigfT-mEFU=3DrqyAKjp0WBQGg=
HP_N3vRxCq=3DQ@mail.gmail.com/T/#m1e55cc094f575797da3b4aed6b369544f8d6f8f4>

I see that has been applied to -master but I would like to target my
series for -next

I would rather that we fix the drivers that add your work-around, but
doing both is OK too.

Regards,
Simon

>
> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
> > 1 file changed, 13 insertions(+), 8 deletions(-)
> >
> >diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> >index ffe43accd1e..e525662f82f 100644
> >--- a/lib/efi_loader/efi_boottime.c
> >+++ b/lib/efi_loader/efi_boottime.c
> >@@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_services=
(efi_handle_t image_handle,
> >                       list_del(&evt->link);
> >       }
> >
> >-      if (!efi_st_keep_devices) {
> >-              bootm_disable_interrupts();
> >-              if (IS_ENABLED(CONFIG_USB_DEVICE))
> >-                      udc_disconnect();
> >-              board_quiesce_devices();
> >-              dm_remove_devices_active();
> >-      }
> >-
> >       /* Patch out unsupported runtime function */
> >       efi_runtime_detach();
> >
> >@@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_services=
(efi_handle_t image_handle,
> >       /* Give the payload some time to boot */
> >       efi_set_watchdog(0);
> >       schedule();
> >+
> >+      /*
> >+       * this should be the last thing done, to avoid memory allocation=
s
> >+       * between removing devices and the OS taking over
> >+       */
> >+      if (!efi_st_keep_devices) {
> >+              bootm_disable_interrupts();
> >+              if (IS_ENABLED(CONFIG_USB_DEVICE))
> >+                      udc_disconnect();
> >+              board_quiesce_devices();
> >+              dm_remove_devices_active();
> >+      }
> >+
> > out:
> >       if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
> >               if (ret !=3D EFI_SUCCESS)
>
