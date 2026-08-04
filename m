Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880E3C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22523404F5;
	Tue,  4 Aug 2026 18:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8U_A1FsO_kq; Tue,  4 Aug 2026 18:13:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43AD040518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867200;
	bh=jQ5qso7wnYtHyDVUZ4cHJfPsknqcCH7Ho5kRyNmEejE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iLZ6RvKHfMOLnzl5QIIQGhetrWo0uQFX/m8KbAVzKiPnT+4Dwob7QpXyOlHHNkRMl
	 +qWnBhU+dleLOoIfV+Kg4HAIVeyLT2hRvxDoyyqKLjL0RLsG1cb7TpPhOLRvPtNjgc
	 L9L1uQg4DYV5wmxZ9MJVOfYbVLazOJfcS8fr8nKwjLvOq5i/gOCTpmZqj/dC1B7TN6
	 4dAMll0GwtDncPLxwYsn4kB6+v2JOSSp1juoN3xr6HLJlUh0bvgRwR4woezH+oXACY
	 LNw4NRdvBbG+gFGsx65mC3L1Ku5N5T8dhi0rQWmvMYj9Xi+UlnwJH/lNewGVwJK9+g
	 cpbmsKsaWU3gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43AD040518;
	Tue,  4 Aug 2026 18:13:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6C6C2AA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D54D80BED
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:01:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8VYFJcxo_8b3 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:01:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 65D86809BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65D86809BF
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65D86809BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:01:27 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so746124066b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852085; cv=none;
 d=google.com; s=arc-20260327;
 b=llw2/KYnSM+1gqRiEGjLkFizyTGpKNjnrIJINFwlcqAqblhjSpM5H0BfLFNs4QOvI0
 uVyP3rv82avjHww4+hFDTlh33OXa1uPSXSAJbRvHej1iV5JBnLFXAwd/Zy7r9Sd7ysnu
 31oE1KHb2lWlGNcX367nTtNu3UykHlm9uTIivXVlgMHTaCT4Job432dHbCHatGBkeEg4
 y6GGn5wKL/RQ9ZqwSjZhbY0VLsnba7N2SRsCubfiDFwbWZe6cK7P4DKucZaLw4opffuP
 NfLk3SiDlK427R7CFrReTLRAWDz0Sjd1O1tXKT2WPIotbCa0RomlOOTE25lnA4QsHTTf
 2k3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jQ5qso7wnYtHyDVUZ4cHJfPsknqcCH7Ho5kRyNmEejE=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=JkfpJ5wt9x/WEWgs3+DdTzDKaS8yDt4em5cE9XplbMpfEEvcd7tzdASsIqNHlzci/y
 ek+MG1LciZ91FMrf+ZDRbtl0gKzFa/eQqesyH4IzPmCDkhLSuvk0FmZX7ujTVg0Su6+R
 gOwSlFFuyrmhIapjEMDlY9PpwwlZsA86is2qXiulP/wp5XfhfBUZWqOkhNAlDvTPRgtH
 XNx7iuSIf4zo8ZjaD5e2CjAZI8626BMdrq3MjNU7v/KZVFL3MlhDEcWQABu5oQdQu78i
 UL9BUDakG7JMRwbWlyB+Y+EnmbK1hZr1KQOr0qAryQ/35PTNRnpNEPZ/Vv3PG8/dWsRq
 /eGg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852085; x=1786456885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jQ5qso7wnYtHyDVUZ4cHJfPsknqcCH7Ho5kRyNmEejE=;
 b=SLLvSEKNYLqC3GSVsz77C4Ma/SeoeLyzAQaC4UDlJUQUdpoVJOZnRFbyFI01Cu0TCe
 7ZP+9bXOrOiEydMZWRZxcTglrYy2Xq1Ur3CI6XzYKnRVMxWLan7u+KEInofTdr8UJTW2
 z8QS4vXXlpIcpKCWetQvC5TE8NxWOV8b1cuTq9Yu5yBpHoNfS5U5SBPgSmxiyUuDJvFy
 AAQPxXshxLhauPVM3+P8EgRhW4+F4xylXoSld6QEU3oOxW3hU76bOvk3aA9FHIIG4q6c
 r5ExB0kuILbvhpWmKrepLGaDQUNk9cS7t7VWJzfx4Bd++QiTaSlIBE091NT0XVOmH1qP
 /FcA==
X-Gm-Message-State: AOJu0YzjMEU+FKEncthK9aFNG6rcCCBeZOMwQ1Q7gpTTe9y8FweOY/RK
 js3e0uUY+09PKDf9TQer9Y4eyO5xfmCP0+9mmWBtByJXgoCT9a1cyEpk9WeB2pcfIzEvnGV+gia
 7oGLbE3DA6aTpmovUA3/ZmpFq4zf32GKmirOnmw9Azg==
X-Gm-Gg: AR+sD13X5fwR+fDhifu8VyeIrc0vRIAgy2YbUnGL1Yy9cD2jOD6NOEE0WrzNgpfC/GF
 rNfHNOBA2Ql/ya3eDflckj6kN9TVKSnw5pRHQcGx8I+1DQIP+0qh7eFdzrGQ3LC7+1MjJuBvMAJ
 E+PH7ZxEByt9pIGDAoNrFthh6tPOkqLDSCdH4NR+Gi2aWbpxPkBuNK1NK3u9wtjfT9upi192Bx8
 dgxX3vU4yTCUHAWy5kg7DrWn2WLod/Kt7T/R1P3e/sOFoC8tSBH/I75BsaWScO3aaB/lhydxTPy
 ZYgxvU5Qyyhe+wVdFXNIBaISUu5ks5h3DlgzxNzLjQDX9xXEs9lHvL3Pxz/ChtbMj3daBjHqh0J
 1vKMRZ+de81cuEpRxZHeA0z8=
X-Received: by 2002:a17:907:b041:20b0:c1f:9a2f:15ca with SMTP id
 a640c23a62f3a-c1fe823e434mr890818366b.29.1785852084744; Tue, 04 Aug 2026
 07:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-2-acb97c172993@flipper.net>
 <CAFLszTi+VGxUPz6K0pXt2D7JUmxOSm26OcJVFzriY-g8eyX24w@mail.gmail.com>
In-Reply-To: <CAFLszTi+VGxUPz6K0pXt2D7JUmxOSm26OcJVFzriY-g8eyX24w@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:01:16 +0400
X-Gm-Features: AUfX_mwmRC881yoI-QL-UkrQVYIYd_UnyMEACiR1q4o0MV3kQfL41WLDXg8kMUw
Message-ID: <CAKTNdwFz-0eBZypfv_rkR9MvrNHUg3VV+ErGjjrFkVFHEj+FEA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] spl: atf: support Linux as BL33 with TFA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785852085; x=1786456885;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jQ5qso7wnYtHyDVUZ4cHJfPsknqcCH7Ho5kRyNmEejE=;
 b=71jCrZVrQr50xVqcWV10+Z3etxrcCEr+mGXJIXY/sNDHkDerORDDVLm0hC2L520MCd
 YoM/tej58V6Mstr1dAuTilzOMs1XuRCpk+B3QBx2zfVt5NKKX3c+meEujboMJan3dZTD
 VGuuCbh0QjOaNZGZwJMeEeRmlwQUw7JaYCCtBp3Yf6z9RaNY+lTSA93cP3ejiNNbgm2L
 ZS00b7DyfI5kQ51K9suzxkTQLbr848CmFLvpwEj5S2gdhglALp6g0x4zWemjziasYgfc
 wKl9srlDwYIbp9mJp/TCM0y4s4Nxja9ftHK3mFV+IP5yrHMGJTzUKRp2vi1UKVpVteZ4
 MhuA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=71jCrZVr
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On Tue, Aug 4, 2026 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > spl: atf: support Linux as BL33 with TFA
> >
> > Modern SoCs such as Rockchip RK3576 need TFA to be running to provide
> > firmware services to the OS.
> >
> > Enable the TFA boot flow to allow using Linux as BL33 (including its
> > calling convention) to facilitate Falcon mode boot on such SoCs.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > common/spl/Kconfig   | 22 ++++++++++++++++++++--
> >  common/spl/spl_atf.c | 49 +++++++++++++++++++++++++++++++++-----------=
-----
> >  2 files changed, 53 insertions(+), 18 deletions(-)
>
> >     Enable the TFA boot flow to allow using Linux as BL33 (including it=
s
> >     calling convention) to facilitate Falcon mode boot on such SoCs.
>
> The commit message says 'including its calling convention', but the
> diff drops read_mpidr() unconditionally - every existing SPL_ATF user
> now gets the FDT address in x0 rather than the MPID. Please spell this
> out and note why it is safe (i.e. U-Boot proper as BL33 does not
> consume x0, and the previous MPID value was a vestige, as you
> mentioned in the v2 changelog). Right now that context lives only in
> the changelog below the '---', which does not land in git history.

Will do, thanks.

> > diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> > @@ -87,8 +88,8 @@ struct bl31_params *bl2_plat_get_bl31_params_default(=
ulong bl32_entry,
> >       SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
> >                      ATF_EP_NON_SECURE);
> >
> > -     /* BL33 expects to receive the primary CPU MPID (through x0) */
> > -     bl33_ep_info->args.arg0 =3D 0xffff & read_mpidr();
> > +     /* Pass the FDT address in x0, per the TF-A BL33 / Linux boot pro=
tocol. */
> > +     bl33_ep_info->args.arg0 =3D fdt_addr;
>
> Just to check - for the U-Boot-as-BL33 case where CONFIG_OF_BOARD or
> CONFIG_OF_SEPARATE is used and the FDT comes from elsewhere, does
> anything in-tree currently rely on x0 being the MPID? A quick look of
> the arm64 crt0 suggests not, but worth confirming across the SPL_ATF
> users (Rockchip, TI K3, socfpga, meson etc.) rather than assuming.

Nope, I went through both the mainline U-Boot codebase and TF-A -
nothing expects MPID there. TF-A stores whatever it received and puts
it back before handing over to the next stage. In U-Boot proper it's
just saved in save_boot_params, and can be claimed by either
CONFIG_BLOBLIST (which expects it to be an FDT pointer, not MPIDR) or
SAVE_PREV_BL_FDT_ADDR (same).

Per-platform overrides never mention MPIDR either - only DTB pointers.

The comment and the code was added in the initial commit bcc1726a7bdd
("spl: add support to booting with ATF") by Kever Yang back in 2017
and was never really propagated anywhere in the tree.

> > diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> > @@ -189,7 +190,8 @@ static inline void raw_write_daif(unsigned int daif=
)
> >  typedef void __noreturn (*atf_entry_t)(struct bl31_params *params, voi=
d *plat_params);
> >
> >  static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
> > -                               ulong bl33_entry, ulong fdt_addr)
> > +                               ulong bl33_entry, ulong fdt_addr,
> > +                               ulong plat_param)
>
> The two arguments now mean quite different things - fdt_addr is what
> BL33 receives in x0 (and BL32 in arg3), plat_param is what BL31
> receives as its second parameter. A short kernel-doc comment on
> bl31_entry() spelling that out would help; the split is easy to miss
> and the ATF_NO_PLATFORM_PARAM path now diverges the two values
> silently.

Will do, thanks.

> > diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> > @@ -253,10 +255,11 @@ ulong spl_fit_images_get_entry(void *blob, int no=
de)
> >
> >  void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
> >  {
> > -     ulong  bl32_entry =3D 0;
> > -     ulong  bl33_entry =3D CONFIG_TEXT_BASE;
> > -     void *blob =3D spl_image->fdt_addr;
> > +     bool falcon =3D CONFIG_IS_ENABLED(OS_BOOT) && spl_falcon_boot();
> > +     void *blob =3D spl_image_fdt_addr(spl_image);
>
> Switching to spl_image_fdt_addr() is a good change, but the helper
> returns 0 when neither LOAD_FIT nor LOAD_FIT_FULL is enabled. If
> somebody hits spl_invoke_atf() in that configuration we now pass
> blob=3D0 as x0 to BL33 (which for Linux is fatal) rather than the
> arbitrary junk the old code passed. Not a regression, but if that
> combination is not supposed to reach here at all, a build-time or
> runtime guard would be clearer than relying on the caller.

Indeed, will add an error path for the zero case here.

> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > @@ -1230,22 +1230,40 @@ config SPL_BOOTZ
> >  config SPL_BOOTI
> >       bool "Allow booting an Image style Linux kernel from SPL"
> >       depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
> > -     default y if ARM64 || RISCV
> > +     default y if (ARM64 || RISCV) && !SPL_ATF
>
> Flipping the default based on SPL_ATF will silently disable SPL_BOOTI
> on any future board that combines SPL_ATF + SPL_OS_BOOT + ARM64 and
> relies on the old default. No in-tree defconfig hits that today, but
> it is a bit of a trap. Would it be cleaner to leave the default alone
> and rely on the code path in spl_invoke_atf() to route around BOOTI
> when TF-A is in play? The help text already explains the option
> remains selectable.

Hmm, adding a future board but relying on a default which will have
predated the addition of the said board sounds weird, doesn't it? :)

I'm not sure I see a clean way to route around BOOTI from within
spl_invoke_atf(), given that BOOTI just jumps to the kernel image
without starting the firmware first. It might kind-of-boot, but it
will result in degraded functionality, so I thought removing a footgun
from being enabled by default made more sense. It's not needed in the
FIT (TF-A+Linux) flow either, so removing a "default y" from Kconfig
is a one-liner which saves [num_boards] lines of defconfig noise
disabling it in every board individually.

Best regards,
Alexey
