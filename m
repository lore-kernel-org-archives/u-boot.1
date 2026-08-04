Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF20C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A010A605FA;
	Tue,  4 Aug 2026 13:11:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCppzB-fH51e; Tue,  4 Aug 2026 13:11:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F75F6075E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849069;
	bh=hXTfn3jUYUE0AWc80Kdg/HoLV48lHWMpGvpOp8PzZFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u4XzjUKvFwzcaHrxcUaypQn37z9CAvlfVFIR0HcI2cHAA7XWMYipkrgq/YWrt8T8f
	 cyq10i3ziK/ItfWHcxCwwjm7ZWBnyJxLb5tmtXujf5zqg19Oz9CsnkGSfhJ1yHM40l
	 9kBrX29WhoY2FVugVY7jRn4mNa/r9x7i8ngksV693O3F1DuBIaj3VJ7rnrDcAEgsFf
	 lhYg22zY7jdmWZ5BBHtrxsUO2q+pB7NK6xkYSXg7luKZRyK7gi7sGp+MhKo1Ly11Tw
	 r4TEjwYUe58O2zBuN7bWwa3182ai/RRftd/ac1jIsSu41Bmc36nStDwc7c2bQCRPCd
	 zB8HWectz+zYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F75F6075E;
	Tue,  4 Aug 2026 13:11:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9354218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB3FB400DA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPVZPwPdOgAf for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:02:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A6F9B40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6F9B40071
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6F9B40071
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:38 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a18180so5750172a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848556; cv=none;
 d=google.com; s=arc-20260327;
 b=WOtHSuc2fvDnAH9ux91OE/ZiG8sTbn/WSEDp6bRI40qlyob/CKP84RyaVcnD6OfH2R
 /NHr8wgBISVKW3HZSOuZEgD+0ok1Czl/UK2bSR/uUvjjvkE4vUwH4yD8lSUMJvgHmpSQ
 CyBYbmTcMT8sJnVOHy9hgyYEyL9x9lX17fg2AN0eAbnHuf8mTD+HbpeT/zgvCNgDudG8
 EO+fJV1VWTdg8OADgN3rKcYxNqnbp6QdyF3rEcGwup0Loky7ef3qhHMLSX4HQoCeVwDc
 kR5a0BFUg9B5EfjHVN/zN/xItiX+kip1QpI/IG3KZhf5OV5ezzZysUqWosAPYqvminLo
 JbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hXTfn3jUYUE0AWc80Kdg/HoLV48lHWMpGvpOp8PzZFM=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=CTTWZolcM3CxSMXsVl6TMVoIuYyeoo3DmEhK5xOFHZOc6S8VOWW1Slvr8dtTJ/p8dq
 ZEiPP0pUi2aVEv3fDE+gknLzm52gLcpgGG1mlklPfH1iHpqJTK9Uu02lEyQO4CczV9I7
 inVcRyISq/GflKRBI2giz6C0gYIhn0plITXIw7QH+fqUgNk0brbGahf9pHtgPina1hvi
 QIWxdDUZAZbNTlYrxtqQbDVhbYHbITWsu5kGeiXi+EG9CGrh2e3kM54HFLukfpXGftDJ
 +C4Tbm1O/sM02jF6FLAR7naFipgXXyaQEK98w4JKYctllrkg+0LQRDrOp3mIO6uCbRIH
 5VeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848556; x=1786453356;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hXTfn3jUYUE0AWc80Kdg/HoLV48lHWMpGvpOp8PzZFM=;
 b=j5OdpCEMugRdv4tHgjSJSuEthqytk/wSfCkAMNt0NykKVOrzQUx0Yb/XS3ZxldJnDW
 NEKLT81rV+Ud8QtC1qaBJIv00U5lywT8vXgmJ9mgh5lUqZiNCu6BSbsWryI3R5fePBpK
 Q11mJwwB7BI5rb75xMKu5fnAjiwtXQGoV0gcwV+cmDFlruzF5dhLIGxo+slSxbTOgQW7
 oEVXVu2uzylBPeFgZLX420xO3Yyj1q79spHt2X+Nrrrv0cr+/Lll1qUL3oGQChhxrg77
 1ZPiPurSrMP4m3oOcIdv6PPVdRc7y1SvyEfHi8Qq2527jvVQ6BIc/OGRJ/9c3l1lxCuE
 aPrg==
X-Gm-Message-State: AOJu0YxMhiVg2ruY0a8MfPKI1hqkmRhHd6nqaagWKokM/G669StZwAKu
 xy5vih/TMNjtZgVgp8vLxGaTggn3uGKsXAwffrVTrzOUwaSRGWHXpPK1DOTrg0Q0JHltqc77Xr6
 nAOoBWqo0R5lRsHj8AqjDFk91A5Wrww7bhKD2Rt2B
X-Gm-Gg: AR+sD11jS/7D6E725UIu54Ig8bq1BkzeYEUqTVG/paajyodbvsXTgnWxe5csXCNqSR2
 /0oGpA/Tz/xOEmDVnfyVXkYcUExI348J9wACnMF7j0E8jJpJit05Ykm2kyg9YOf6xpWmHwMRrg3
 +LM91cy+4sVvrQaAvSD3RS3K667hzgl2muzeAy+Wxqs3L9Ymy3I7mB+EWrv++MDwLQfiFREr3iq
 aRoDoNFWxBt8lIBlUWoB9kNx/zSLaiI2fLNyXWtika7sAAtnEo4vGqLU4ydxLMtzKFqEhH79k6y
 on9VN3oxZE/YemPVF43wTPVg6T9qJHwDDIzNFdOfThc=
X-Received: by 2002:a05:6402:13c8:b0:6a1:209d:38a7 with SMTP id
 4fb4d7f45d1cf-6a1209d3a11mr3973913a12.1.1785848556409; Tue, 04 Aug 2026
 06:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-2-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-2-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:02:24 -0600
X-Gm-Features: AUfX_mwgN-8N8L7WJKldvDuJ-IVYSffpfODs8vQ6CVe5yC5zBt-IWuY5chbJpgs
Message-ID: <CAFLszTi+VGxUPz6K0pXt2D7JUmxOSm26OcJVFzriY-g8eyX24w@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] spl: atf: support Linux as BL33 with TFA
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
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
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848556; x=1786453356;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hXTfn3jUYUE0AWc80Kdg/HoLV48lHWMpGvpOp8PzZFM=;
 b=lX+RIuQzdZEnWgFW9Fk9YBieGxbgPPfAFUXyw6XqgBLJiXS/itFoVWy//EENTCGYE7
 Os3b3Co2C6xtynuWlgoTmVmbl8TjLYi7iXK+BeWza2FTCS4yl2YNrAaNArCRsX8LrY51
 2gOq+d5vwHPRP/mhHR1NL079QfHwtcawNVlFQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lX+RIuQz
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

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> spl: atf: support Linux as BL33 with TFA
>
> Modern SoCs such as Rockchip RK3576 need TFA to be running to provide
> firmware services to the OS.
>
> Enable the TFA boot flow to allow using Linux as BL33 (including its
> calling convention) to facilitate Falcon mode boot on such SoCs.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> common/spl/Kconfig   | 22 ++++++++++++++++++++--
>  common/spl/spl_atf.c | 49 +++++++++++++++++++++++++++++++++----------------
>  2 files changed, 53 insertions(+), 18 deletions(-)

>     Enable the TFA boot flow to allow using Linux as BL33 (including its
>     calling convention) to facilitate Falcon mode boot on such SoCs.

The commit message says 'including its calling convention', but the
diff drops read_mpidr() unconditionally - every existing SPL_ATF user
now gets the FDT address in x0 rather than the MPID. Please spell this
out and note why it is safe (i.e. U-Boot proper as BL33 does not
consume x0, and the previous MPID value was a vestige, as you
mentioned in the v2 changelog). Right now that context lives only in
the changelog below the '---', which does not land in git history.

> diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> @@ -87,8 +88,8 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
>       SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
>                      ATF_EP_NON_SECURE);
>
> -     /* BL33 expects to receive the primary CPU MPID (through x0) */
> -     bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
> +     /* Pass the FDT address in x0, per the TF-A BL33 / Linux boot protocol. */
> +     bl33_ep_info->args.arg0 = fdt_addr;

Just to check - for the U-Boot-as-BL33 case where CONFIG_OF_BOARD or
CONFIG_OF_SEPARATE is used and the FDT comes from elsewhere, does
anything in-tree currently rely on x0 being the MPID? A quick look of
the arm64 crt0 suggests not, but worth confirming across the SPL_ATF
users (Rockchip, TI K3, socfpga, meson etc.) rather than assuming.

> diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> @@ -189,7 +190,8 @@ static inline void raw_write_daif(unsigned int daif)
>  typedef void __noreturn (*atf_entry_t)(struct bl31_params *params, void *plat_params);
>
>  static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
> -                               ulong bl33_entry, ulong fdt_addr)
> +                               ulong bl33_entry, ulong fdt_addr,
> +                               ulong plat_param)

The two arguments now mean quite different things - fdt_addr is what
BL33 receives in x0 (and BL32 in arg3), plat_param is what BL31
receives as its second parameter. A short kernel-doc comment on
bl31_entry() spelling that out would help; the split is easy to miss
and the ATF_NO_PLATFORM_PARAM path now diverges the two values
silently.

> diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> @@ -253,10 +255,11 @@ ulong spl_fit_images_get_entry(void *blob, int node)
>
>  void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
>  {
> -     ulong  bl32_entry = 0;
> -     ulong  bl33_entry = CONFIG_TEXT_BASE;
> -     void *blob = spl_image->fdt_addr;
> +     bool falcon = CONFIG_IS_ENABLED(OS_BOOT) && spl_falcon_boot();
> +     void *blob = spl_image_fdt_addr(spl_image);

Switching to spl_image_fdt_addr() is a good change, but the helper
returns 0 when neither LOAD_FIT nor LOAD_FIT_FULL is enabled. If
somebody hits spl_invoke_atf() in that configuration we now pass
blob=0 as x0 to BL33 (which for Linux is fatal) rather than the
arbitrary junk the old code passed. Not a regression, but if that
combination is not supposed to reach here at all, a build-time or
runtime guard would be clearer than relying on the caller.

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> @@ -1230,22 +1230,40 @@ config SPL_BOOTZ
>  config SPL_BOOTI
>       bool "Allow booting an Image style Linux kernel from SPL"
>       depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
> -     default y if ARM64 || RISCV
> +     default y if (ARM64 || RISCV) && !SPL_ATF

Flipping the default based on SPL_ATF will silently disable SPL_BOOTI
on any future board that combines SPL_ATF + SPL_OS_BOOT + ARM64 and
relies on the old default. No in-tree defconfig hits that today, but
it is a bit of a trap. Would it be cleaner to leave the default alone
and rely on the code path in spl_invoke_atf() to route around BOOTI
when TF-A is in play? The help text already explains the option
remains selectable.

Regards,
Simon
