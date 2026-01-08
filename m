Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FEBD1D482
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1E784150;
	Thu,  8 Jan 2026 18:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQL/Qq48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44188415D; Thu,  8 Jan 2026 18:22:38 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F8A284144
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4ee1879e6d9so37574491cf.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767892955; x=1768497755; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvePl5g6ffb7HjB5k2c6LC0PvTiYJQUEcADTlytYky0=;
 b=RQL/Qq48dG5iUZnT0IjC9Y4Qk+Do86SYwadbsG9L24Jr4onehw9vZA4/h+0CgwsL5T
 2dpfCNLa1XgbzUIlSlLOJyCMN4qe63ke2FXrtD/Uz+d7+9YKIERIKACu5yZNnkc7XQ5M
 YDTY/FcVJrhwwKHmnYgTd7JlTBLuinw4q1WioYuVqbQwI5/68oTQoHE+vMYfPu/7feGw
 SD/YkR6oEd98X/kfYEDcDGAyg+dhWGLX6bsvi3VToZEbk2Rr7OvqtuuvEyD8AeBnCxxW
 mALneSUxNasn3QDkkbWAPfmwVHg2FhoFXa3/lMZD0p/3OgEfQpHdAllsCgxQJUas1vGD
 m9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767892955; x=1768497755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LvePl5g6ffb7HjB5k2c6LC0PvTiYJQUEcADTlytYky0=;
 b=sWcpx1EkuuHveqXlmE3lO8FfLrBRlaOnF7zFRY88D0lDUf6j0BHd7x7X853uN7YC3A
 6J92GiKHaM9uf/Tpq7yWkimH3YKiVbrDT7FxZZ4NFxKGpcpfTJWiKBtUnZIeli0LWz9R
 VcS6RtXr66/AKSiU4wy3eYlSjo4tRP5aKYzNcC4C/0/E/dq5anFqUK9CNIsCXDUQLVgH
 un2eymKUk/yntgzJlBCsmVlwzvZqHs5hlvHgcZMX8EsEibasD4CSSxele535tfaZ7TCR
 Qw3d2zu5dP/etWdYEmYiLgJXmUZF8stCHG815g2rD+FqP2T2RQtrnjd81vyJtF/1hl9Z
 yABA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQgKKEXgiZWS5T7w1vZ9v+tIbPwXXZC06VIQYdCDKouwVx/8qK0JXnU9vEQhs3NoNhMt5RRzQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwWRTBO0vOK5yitqKgn2RpwNUiJe57Sk/97S5dDyeV3Eu8gQHAe
 Cv2QJj2c7G0in1aLOqVk2k0+JJiAW8Z7fTtlhvLYMgOdJcRxFUZ8kxrsCNGK7qO8J2V9VVaGwD4
 6RhHQXGdSr75KUSdJfunOKNNo2v6AUGMmf22+Kh0=
X-Gm-Gg: AY/fxX4qxW4NMGSm4T1Pz84D9gBjW/CLplF5WvIBsJcKGLY8ez5renhOAvMecvUHW4M
 XTp5J+AdkLm94pU3T2LbUrIdeGrwL12ke46bMxKf2phGa9/kzegPR0ylHGrDwO0OE/DTAMigCZO
 6p70P9NOYVtRFeQ5ukiEbVopPJFalg4fJjZ19+iDoWJVXT8aA43xBP6wJjp8Ja9YFrV/ke9+uOM
 DBS/lqRPW5DmLNhVvwFnf7thNI5cYWOePLss2MzwXxniK8pw+mxc7scviCrkc9CbBgDn/9bnPmT
 fVNsMlSzp4LzfgLqVq+1+hVu3Ocw
X-Google-Smtp-Source: AGHT+IGbCxlk+/xMimXaRBWQw+ko+v25Yvlb7ngvQomfL0OKi8uH+mKxAjg7pXGXtaOllIJQRnrmHDLBDP1gzVTDxTs=
X-Received: by 2002:a05:622a:40ce:b0:4ee:4214:31ff with SMTP id
 d75a77b69052e-4ffb484b02fmr94769721cf.13.1767892954572; Thu, 08 Jan 2026
 09:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
 <20260106-rk3576-ufs-v3-3-bfe259fd6d17@gmail.com>
 <67576082-d8b0-419e-8365-0f6294fe0ffc@linaro.org>
 <CABjd4YwyVKDRDz16u+rbiorFmPSJtEi7VgKZABr7A+_p2qDA=w@mail.gmail.com>
 <f6cab27f-e115-49e4-8a3f-a01ceb8500f3@kwiboo.se>
In-Reply-To: <f6cab27f-e115-49e4-8a3f-a01ceb8500f3@kwiboo.se>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 8 Jan 2026 21:22:23 +0400
X-Gm-Features: AQt7F2q-zT_P5JTvQjxtpPtKRaNOW6gZCLyZvcJe0qAfwf5v-bJSmTEJC9jicKI
Message-ID: <CABjd4Yz0wx17xEbMbu-dmMb2_qOBRuarLrYCQx8CJLiOAk+aSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ufs: rockchip: Enable SDRAM-only DMA quirk
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Thu, Jan 8, 2026 at 5:41=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Hi Alexey,
>
> On 1/6/2026 7:26 PM, Alexey Charkov wrote:
> > On Tue, Jan 6, 2026 at 6:09=E2=80=AFPM Neil Armstrong <neil.armstrong@l=
inaro.org> wrote:
> >>
> >> On 1/6/26 14:57, Alexey Charkov wrote:
> >>> Rockchip RK3576 can boot fully from UFS, but as part of the boot
> >>> process the SPL needs to place part of the ATF code into PMU SRAM,
> >>> which is outside the SDRAM range that the UFSHC can access.
> >>>
> >>> Enable a quirk to force bounce operation for this case.
> >>>
> >>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >>> ---
> >>>   drivers/ufs/Kconfig        | 1 +
> >>>   drivers/ufs/ufs-rockchip.c | 1 +
> >>>   2 files changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> >>> index 6c75bb2a0790..2543b5d47c04 100644
> >>> --- a/drivers/ufs/Kconfig
> >>> +++ b/drivers/ufs/Kconfig
> >>> @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
> >>>   config UFS_ROCKCHIP
> >>>       bool "Rockchip specific hooks to UFS controller platform driver=
"
> >>>       depends on UFS
> >>> +     select BOUNCE_BUFFER
> >>>       help
> >>>         This selects the Rockchip specific additions to UFSHCD platfo=
rm driver.
> >>>
> >>> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> >>> index 0384244387da..699460fc4d15 100644
> >>> --- a/drivers/ufs/ufs-rockchip.c
> >>> +++ b/drivers/ufs/ufs-rockchip.c
> >>> @@ -153,6 +153,7 @@ static int ufs_rockchip_common_init(struct ufs_hb=
a *hba)
> >>>               return err;
> >>>       }
> >>>
> >>> +     hba->quirks |=3D UFSHCD_QUIRK_DMA_SDRAM_ONLY;
> >>
> >> So you really want to enable this quirk for non-SPL builds aswell ?
> >
> > Well I haven't run into any similar issues with the main U-boot, so I
> > don't have a strong opinion about keeping it in place there.
> >
> > However:
> > 1. Having the quirk enabled doesn't cause all transfers to go via the
> > bounce buffer. Only those for which the provided destination buffer
> > happens to be outside SDRAM (which must be extremely rare if at all
> > possible under U-boot, given that it hasn't caused issues for anyone)
> > 2. If it turns out that there are indeed cases when the UFSHC needs to
> > read or write something outside SDRAM while operating under U-boot (I
> > can't think of a reason now, but then I couldn't think about that ATF
> > to PMU SRAM thing either, until I ran into it and spent more than half
> > a day debugging) then I'd rather spend a couple of CPU cycles on a
> > memmove than end up with a hard lock up, a cryptic error message and a
> > dump of UFSHC status registers
> > 3. It's one line less code this way :)
> >
> > Happy to add something like "if (xpl_phase() =3D=3D PHASE_SPL)" though,=
 if
> > that sounds better to everyone.
>
> You should most likely be able to drop this quirk workaround with the
> "rockchip: rk3576: Fix DMA transfer of TF-A to PMU_SRAM" series [1][2]
> that I just sent out.
>
> Please try if that also solves the DMA transfer from UFS to PMU SRAM
> issue, it did for eMMC, SD-card and SPI flash.
>
> [1] https://patchwork.ozlabs.org/cover/2181298/
> [2] https://lore.kernel.org/r/20260108133234.4001390-1-jonas@kwiboo.se/

This is brilliant - works like a charm on UFS without any quirks!
Thanks a lot, I'll re-roll my patch series without the quirks portion
and mark a dependency on your series in b4 metadata.

Best regards,
Alexey
