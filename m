Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4902ACD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E740846AE;
	Fri, 15 May 2026 16:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cP6xZt/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2F2846A5; Fri, 15 May 2026 16:11:00 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F0184706
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so201743066b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854258; cv=none;
 d=google.com; s=arc-20240605;
 b=UnKK7Kjwd9Dwpm8VXjt+V+S0J6D93D3w8QY/mqg9smjphJEyAECtLKzEfQMcNkqTc2
 08Zwu/uSMeIJQD/ezD0qcqZo+amtUe+iBCTUuRQAAp0jF8gRnSdgDgxLYeuxs76q9gdk
 Pez6GyhGiz4JfQLBS3BsgxKBBKSJbP1mP4YgbTonAfN63yhbvQ+W2Gv4ueUNSN1vkeFQ
 7+S39zOZrQ3wA9NX7lASejLg9rKn0KVOtHgta5KI9sz/FMcA+5npThBCKL6eT1VUoYl3
 ZHr1reTT1S4H+lP9X2/fSVkbf7kJf3J6ehNhP8s68dgr0JdyYtxfv/Mtb+jn6IhLWfB4
 UNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+OcEDNwM1kIuDkLVLqAtQw9i/m3OVS5A2rNaTTo2KCg=;
 fh=DFckRsv0qokwsicMGANTSyuTqOOhjVTjcJimUrc7cIQ=;
 b=DZ/uZxQvEpOCfYRRnYokPVlq0wPCL7zB3+AF0tBGVZmNKRmky1SEIeGFjtSpxtKYbV
 722ZHzLzMuO3ZGGBSmSnw/DHtLvGQ6Q84HR1iRWEsxYDwttYD3cpgsDkasgi8gGQUCkF
 gPv65boQHOnaTq5UNRoSv1yBcOoIc8+aeh+ekdASTQg5KUQ3SxWBig7d8vYo3lkgLByV
 82j66sSx53jjZelpReNlClNKiEqlcGI9tmd8OurhUsSPvKtZEcI6waASOkOKD/U4aT/5
 a2LSCnIwC1GcmS1b8yGnWPz/E0vJycactRJG17ewqCi7Q9/pt56HdBjo7Mn11xGraDoL
 Y2Yg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778854257; x=1779459057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+OcEDNwM1kIuDkLVLqAtQw9i/m3OVS5A2rNaTTo2KCg=;
 b=cP6xZt/dtuNhGHK+C3cTHutMJiCRYb+rki6KVRcbSHyeviGPj7SAoPgnmfgNBsHPJi
 91+EY2xzT0nAbNE4ymOzJx9vwkDELFPyWoyoRfIB9NlyWAACy5QL2D7QZDBpF1JlufPV
 Zt9vtB21AjDr4uDj9kPHWNnpvUgLQ5VdJz/es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854257; x=1779459057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OcEDNwM1kIuDkLVLqAtQw9i/m3OVS5A2rNaTTo2KCg=;
 b=Ww41Ug3y7f7kRfq9t+WZF91BmNH0MoLPuDDtxcAn6zz7/QupCe3KnTmAs0PoaoAxpJ
 b+JgmjSpip5g34uwqTeeA4b6T/lvkyvPNwsqf/h9cNUSOlb/vLwQ9x1zXFJ0b6DWaz2i
 sAOsiHUGmikKPmKElM7oBNj13ArbP2nq93GJQwy62mkKSf1c23qUGEz1hbhMvv2m7ouY
 HYWugWIw6ddosBm2p9vJLTmhYgBBeQt6GyhoseYd5J3ZVatGdvfP6uVmq0+C7r+uW3Kl
 B/iWmRM7XXEqiCoDHkQiimC7NMlSwgJO8+sRGeZmqk7ciMRwoc8QpKz37mE/LkJSf8ma
 ZGwQ==
X-Gm-Message-State: AOJu0Yz6lmAb3kFxkTdjmH6L36DyEw5ct+9xv6QG68u11oBh8WV4pamU
 9xYzqkTqv9zpjsawtHuU3tCKcQnUlCRcn/g21m2McweXhmz8g1Sb6NcLdZAD5ozIsEDF2Vty3zx
 57rAkGgrB1RUS9xT59akocYQVyAcSMXbrYn1TPBQ5
X-Gm-Gg: Acq92OHdUFFVmDUICDuLgyfk40nEeNuh/YiEDk5et3ORS9mETdUlZtztiIpo8B0JanF
 EYYvuh/czOhQKolZyWxaj0nt5iF+YZb6snTRg6639N5sCDTfOA1Qasoq1EVJH6idzT5pKyaOue0
 cLWFMWt+bd/U3pYStw+AcfTcnJGXS5uopXTvzFfz4zCH+Kzpf/KHQQHIwNSYlpuO+ixZJRsVMVt
 9vvJlzgc/RQR/dUtOZdfg1cdWXBa0CPc2QW8ip9WKr607NZ3Y2L49bbnFOkoQM/IA093S12YEsx
 4/qqiw==
X-Received: by 2002:a17:907:d091:b0:bc6:bb4b:1726 with SMTP id
 a640c23a62f3a-bd51553a62cmr230181666b.22.1778854257563; Fri, 15 May 2026
 07:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777984225.git.michal.simek@amd.com>
 <2a5fee05be84fa1cb333f3ab3db732311da321cf.1777984225.git.michal.simek@amd.com>
 <CAFLszTgRUg5Dk82Gq9FVJ99cn+15Fw7RkwVsiRgZwH2tqHVS=w@mail.gmail.com>
 <25bffa37-8be9-406f-9433-483796431288@amd.com>
In-Reply-To: <25bffa37-8be9-406f-9433-483796431288@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:10:44 -0600
X-Gm-Features: AVHnY4IOzGeTp0rAzRnxbs8z1_t53WF_xw-3s3q_WZutbI2VVxUKmJhX65hQqNM
Message-ID: <CAFLszTjeXv+XFyUzdTN=Vz1L8yn3SgFotYfW+pmBTb2vhaPJMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] reset: Add reset_reset() and reset_reset_bulk() API
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com
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

Hi Michal,

On Wed, 13 May 2026 at 02:25, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 5/7/26 23:11, Simon Glass wrote:
> > Hi Michal,
> >
> > On 2026-05-05T12:30:28, Michal Simek <michal.simek@amd.com> wrote:
> >> reset: Add reset_reset() and reset_reset_bulk() API
> >>
> >> Add reset_reset() and reset_reset_bulk() functions to the reset
> >> controller API. These functions assert and then deassert reset signals
> >> in a single call, providing a convenient way to pulse/toggle a reset
> >> line.
> >>
> >> This mimics the Linux kernel's reset_control_reset() and
> >> reset_control_bulk_reset() APIs. The new functions are useful for
> >> drivers that need to cycle a reset line during initialization or
> >> error recovery but with also passing delay parameter.
> >>
> >> If a driver implements the rst_reset op, it will be called directly
> >> with the delay parameter. Otherwise, the reset core performs
> >> reset_assert(), optional udelay(), and reset_deassert() as fallback.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>
> >> drivers/reset/reset-uclass.c | 34 ++++++++++++++++++++++++++++++++++
> >>   include/reset-uclass.h       | 12 ++++++++++++
> >>   include/reset.h              | 41 +++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 87 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > optional nits / thoughts below
> >
> >> diff --git a/include/reset-uclass.h b/include/reset-uclass.h
> >> @@ -76,6 +76,18 @@ struct reset_ops {
> >> +     /**
> >> +      * rst_reset - Reset a HW module.
> >> +      *
> >> +      * This optional function triggers a reset pulse on the reset line,
> >> +      * asserting and then deasserting the reset signal. If not implemented,
> >> +      * the reset core will use rst_assert followed by rst_deassert.
> >> +      *
> >> +      * @reset_ctl:  The reset signal to pulse.
> >> +      * @delay_us:   Delay in microseconds between assert and deassert.
> >> +      * @return 0 if OK, or a negative error code.
> >> +      */
> >> +     int (*rst_reset)(struct reset_ctl *reset_ctl, ulong delay_us);
> >
> > Please document that the core inserts a udelay(delay_us) between
> > rst_assert and rst_deassert in the fallback path, and clarify whether
> > an rst_reset implementation must honour delay_us or may treat it as a
> > hint. Without that, authors don't really know what to do with the
> > value.
>
> ok. Will fix in v3.
>
>
> >> diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
> >> @@ -225,6 +226,39 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
> >> +int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
> >> +{
> >> +     int i, ret;
> >> +
> >> +     for (i = 0; i < bulk->count; i++) {
> >> +             ret = reset_reset(&bulk->resets[i], delay_us);
> >> +             if (ret < 0)
> >> +                     return ret;
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >
> > Just to check - pulsing each reset sequentially means the first
> > finishes its full assert/delay/deassert before the next starts
> > asserting. For the cadence_qspi case in 3/4, where multiple OSPI reset
> > lines are expected to be asserted together, the previous code did
> > assert_bulk() / udelay() / deassert_bulk() so all lines were held low
> > simultaneously. The new behaviour is different. Is that intentional,
> > and have you confirmed the cadence controller is happy with it?
>
> You are right that behavior has changed but it is aligned with what Linux kernel
> is doing.
> We are using only one reset line that's why not an issue for us. But it saves
> one firmware call (per reset line).
>
> int reset_control_bulk_reset(int num_rstcs,
>                               struct reset_control_bulk_data *rstcs)
> {
>          int ret, i;
>
>          for (i = 0; i < num_rstcs; i++) {
>                  ret = reset_control_reset(rstcs[i].rstc);
>                  if (ret)
>                          return ret;
>          }
>
>          return 0;
> }
> EXPORT_SYMBOL_GPL(reset_control_bulk_reset);
>
>
> If it is problematic we can go back to assert_bulk/delay/deassert_bulk in
> cadence driver.

Well if it matches Linux we should be OK.

Regards,
Simon
