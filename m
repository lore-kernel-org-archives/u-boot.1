Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4621EC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091F9866D0;
	Thu, 24 Aug 2023 16:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="BHRvYv3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC56A8669E; Thu, 24 Aug 2023 16:41:42 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF628522C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso75950561fa.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692888099; x=1693492899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4l43naaW2CkYxyihQN1Upm7lUEJdZkFQERaTmtqb1s=;
 b=BHRvYv3FpM16QWrcaUnaAwn7KMIMHIVb3QT670dA5+WOyi3x1mRbtFU55HDR924ACc
 IpE91yCd+bZQVahqLG0/kls3bq7vPRYSLuAScRY3tH27h67166tMwI1jLpVn2pR+ar2t
 b9QCVL+lDutQYTeMPG16GnbZKWtlb1AE/Kqe3M/AzPl3y9xo1IkTiUXhtXL9QdefBZiP
 XQQVPI0wMZBhtYzKbfe0yoAD3N5LTOU+t4UXDEfID6CXZ5ArEks724RhbB3oo9FwHXLy
 HNvuNE8LN4tEM/sxR79POMS3BpWZM4AEyZ79/E2lHQkHy128s5fU9pF1DIzgJT9XO3Rj
 Ub8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888099; x=1693492899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4l43naaW2CkYxyihQN1Upm7lUEJdZkFQERaTmtqb1s=;
 b=YcUTdw1423GLaQa3Bf9Yn+r8X5A30GhLVKPcQEcDDcA5kWGOxR9yclIRnRVmcyB1Yi
 1fR0nM9eBudFU2SZCYI0lNvVisPGVzljyFSZCaeXA+lTQJA+cgD93CnXxhHghM93rbDk
 jrnvm6N2w2CmQzD9isXDDNwz9hPqSsa7TW1mk5Wg7NpLn2oF8ZQsikq6s9bVvcNSlEQi
 LPE/kfkzO5UEQw6putvgECrZ/t0O9aLAIyZbsAmj+3jH25SRAHmWI+lVnnAh0cUHkvJ6
 WaCo+1sQ1Qg6oYZXuwiIuiJl8Wh6Tedv3UZC8sHchTUoQNI6CICof3BdEB6I4CHXz/Ik
 cX0Q==
X-Gm-Message-State: AOJu0YxAW1xd8n1bBM1EgyFn/2iSf5w3/+/icFuaYTVslBLXBI4CMOgk
 JTkxac0c5p91o3SQjq1rc8zPPskkAwNYFGstr9lwoA==
X-Google-Smtp-Source: AGHT+IHDZzgOsD0eN58t8ctf/iWWJy1PHQb2x75/CfCpMAoOVMCMURFv204fU9vTyrbSIs2PMCmcs0CoPIEPr6AwMq8=
X-Received: by 2002:a05:6512:3e19:b0:4fe:181f:2736 with SMTP id
 i25-20020a0565123e1900b004fe181f2736mr15393316lfv.33.1692888098733; Thu, 24
 Aug 2023 07:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-16-clamor95@gmail.com>
 <CAPnjgZ3zyLjoX5-2zvC9X3Bz+h2KzODpq6X8kNAqR038qtaFVA@mail.gmail.com>
 <7AAC0372-D966-4D35-AA33-5EF03FD0DF2B@gmail.com>
In-Reply-To: <7AAC0372-D966-4D35-AA33-5EF03FD0DF2B@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 24 Aug 2023 08:41:26 -0600
Message-ID: <CAPnjgZ19f0X+juVEtkDbYZMN1qvLdvi9_-3kVtG+FrH9t20-6Q@mail.gmail.com>
Subject: Re: [PATCH v1 15/19] ARM: tegra: board2: add generic late init
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
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

On Wed, 23 Aug 2023 at 23:41, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
>
>
> 24 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 02:57:34 GMT+03:00, =
Simon Glass <sjg@google.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> >Hi Svyatoslav,
> >
> >On Tue, 22 Aug 2023 at 05:25, Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:
> >>
> >> Board specific late init allows vendors to set up different device
> >> or board specific env variables (like serial number, platform name).
> >> In case this information is missing, u-boot will lack info regards
> >> serial or platform.
> >>
> >> To avoid this prior nvidia_board_late_init internal generic function
> >> is called which fills required data. In this case platform name is
> >> obtained from get_chip and serialno is filled with SoC id.
> >>
> >> Though SoC id is not dedicated to be devices serial but it fits well
> >> in case of restriction of data about device and since SoC is basically
> >> a main chip of the device.
> >>
> >> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Transform=
ers
> >> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  arch/arm/mach-tegra/board2.c | 43 +++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 43 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2=
.c
> >> index 981768bb0e..ee69cb657a 100644
> >> --- a/arch/arm/mach-tegra/board2.c
> >> +++ b/arch/arm/mach-tegra/board2.c
> >> @@ -26,6 +26,10 @@
> >>  #include <asm/arch-tegra/gpu.h>
> >>  #include <asm/arch-tegra/usb.h>
> >>  #include <asm/arch-tegra/xusb-padctl.h>
> >> +#ifndef CONFIG_TEGRA186
> >> +#include <asm/arch-tegra/fuse.h>
> >> +#include <asm/arch/gp_padctrl.h>
> >> +#endif
> >>  #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
> >>  #include <asm/arch/clock.h>
> >>  #endif
> >> @@ -256,6 +260,37 @@ int board_early_init_f(void)
> >>  }
> >>  #endif /* EARLY_INIT */
> >>
> >> +#ifndef CONFIG_TEGRA186
> >> +static void nvidia_board_late_init_generic(void)
> >> +{
> >> +       char serialno_str[17];
> >> +
> >> +       /* Set chip id as serialno */
> >> +       sprintf(serialno_str, "%016llx", tegra_chip_uid());
> >> +       env_set("serial#", serialno_str);
> >> +
> >> +       switch (tegra_get_chip()) {
> >> +       case CHIPID_TEGRA20:
> >> +               env_set("platform", "Tegra 2 T20");
> >> +               break;
> >> +       case CHIPID_TEGRA30:
> >> +               env_set("platform", "Tegra 3 T30");
> >> +               break;
> >> +       case CHIPID_TEGRA114:
> >> +               env_set("platform", "Tegra 4 T114");
> >> +               break;
> >> +       case CHIPID_TEGRA124:
> >> +               env_set("platform", "Tegra K1 T124");
> >> +               break;
> >> +       case CHIPID_TEGRA210:
> >> +               env_set("platform", "Tegra X1 T210");
> >> +               break;
> >> +       default:
> >> +               return;
> >> +       }
> >> +}
> >> +#endif
> >> +
> >>  int board_late_init(void)
> >>  {
> >>  #if defined(CONFIG_TEGRA_SUPPORT_NON_SECURE)
> >> @@ -268,6 +303,14 @@ int board_late_init(void)
> >>  #endif
> >>         start_cpu_fan();
> >>         cboot_late_init();
> >> +
> >> +       /*
> >> +        * Perform generic env setup in case
> >> +        * vendor does not provide it.
> >> +        */
> >> +#ifndef CONFIG_TEGRA186
> >> +       nvidia_board_late_init_generic();
> >> +#endif
> >>         nvidia_board_late_init();
> >>
> >>         return 0;
> >> --
> >> 2.39.2
> >>
> >
> >This would be better done with events. I just sent a series that
> >converts board_late_init() to use events [1] and with that you can add
> >as many 'spy' functions as you like [2].
>
> This is definitely a nice suggestion, but I would rather dedicate this co=
nvertion a separate patchset since it will affect multiple files and functi=
ons across all mach-terga.

OK I look forward to it!

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> Best regards,
> Svyatoslav R.
>
> >Regards,
> >Simon
> >
> >[1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D369742
> >[2] https://u-boot.readthedocs.io/en/latest/develop/event.html
