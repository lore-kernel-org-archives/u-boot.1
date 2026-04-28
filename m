Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87D9FF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 05:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA5B841F2;
	Tue, 28 Apr 2026 07:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EA7WV+/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A91FC8421D; Tue, 28 Apr 2026 07:16:56 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9105784106
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-42fdab683a9so3719350fac.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 22:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777353413; cv=none;
 d=google.com; s=arc-20240605;
 b=CG2fUbk2A/D89nYdraB26F+s2YB+c06/1mHZHwF5rZss2+bY/LoaMGZ3roZyCRxPha
 fqHRzbOUL0uCx737PmkGohbWA0dzqMD/Ct9yX2sVpKhJvtx6O1K00vgRITr1QhMZHEH7
 CqVyYQOTJ+g/1reLPEwGlRsPPD78kinlz7ldW9o74utu5ZGwJydBheeOB/5cammTXp8p
 NgQhZ6MFfbRsjOD7pgwH+dy6+KjlxDtSp7gPl0fYeaCPUD7bWflzHZwqvVjUKmpyvQkN
 vY71X3blvc+NuNSFnUH0oVuvjGB6amNyJD6++FAMF8qVOptHU1D65KnTQ08YA3sTsUh+
 f3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CHCxe+qoa6R+cO8Qyce4PxcS/aY4VoDfnkTUo1rPeYs=;
 fh=QMZdvVsxvWCHNNEpcAbJd4pzxODbhoOY9yjXiTqL0Z0=;
 b=hAqccQTbJ5DKmSQR8CPiBTLd/SvQdWI3uayiuJAvHI4k4JMeRTPqw65iqtQH9qJSCx
 tBNa0rMh9FvagCmtD1qcbwq18Ary5uaHau/IIoNbI0nBmR6UCzlxC3ZFZ/ln4Z21p+Xd
 hHZeB9fW6lWWmp0A0pgkoqdfVtC1s0YZq9cZZwCSjZGo1uLGO0PTgeuo3w7aeZkBRPFL
 bOQMV622oXdMkaJ2x/iQ7o+bPBXn/RL3l5XkYLh0PCfBm9NZrLsmxp6CDK/88XtrSDBq
 Z/rUze5cnXYf5qxACcQQTk4a1HgAjHj93QHeTlRryBylyt6b0BKfJtrZUaaSui2lw5RT
 o52Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777353413; x=1777958213; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHCxe+qoa6R+cO8Qyce4PxcS/aY4VoDfnkTUo1rPeYs=;
 b=EA7WV+/FpsyPhIQNWLEkO2vLXPPzrNZGUAWK8PJp6ow1rJNi+9kUEaW5MduiI35Uu1
 FtCwTSRunxc+euMNid6Yw+4MfQmo5aEavSRxFvsUDRGAs3jvfHY9nKkHuE5qSBWb525q
 P++4jBl2lN5B31KOsjnXZpcfXr0ytgx2YbuaHtpPAE4inI8AapAV1tbKX8yVd9O6QTXc
 vKaE+L/B3llqei1SOsBmXb0oJYfvrWZxZlHr9+nppJnrvnoUQLvWc/upIY4UsEIOu9j4
 XlFB0QMTMgRA45mklQtJPLkZ0+sgUuOPpQQPGywJn5f278NgPGn3qNJB5X7rlrNpWt+3
 Ds6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777353413; x=1777958213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CHCxe+qoa6R+cO8Qyce4PxcS/aY4VoDfnkTUo1rPeYs=;
 b=jsbp9iEhZ8WftOACOpVAJQnkTDGLnwE7cA+rzNeCXP3J1L0z/rr7kzJUzSM+rwFHKI
 EPhJthhcSDx5Z01iPLIIjj9eiCtTrKbl7Tg/Ko4eruYYY3aXYAY+KWSDmiPo8O0/LNK4
 v4QuAj94sIZ2stoTth8aWH1Ad8eRGq058GTaZCyY02mWW0hpm0h6UZBp4dSZ6W7PYDDj
 +wSh7a9zHriJoCx3zGBfgA/vx2byimeCaHG5Em1YwfRvyHcPpZWWGIodl5jUNBKL+UEE
 69Hp+lcU+Y6Cw1S7MFRaICNNkt8HjYiw1xxFJ0nHveKwb7HLUhEM3F1NowQTYojUIwJ5
 4qYw==
X-Gm-Message-State: AOJu0Yy7PBXfxMzNwweJcVoFwpC0cVfPYGXIN+6P3fwmlsP3OezKGPEr
 8AyP1TOQ9DaCFqBMOWg+OVsMhu15f42YTqrpXSmSUX1FEWVkV26rp55PZx/xN0h/MHQlaxWrv/E
 1Lx2yIYNiL9Ao+GR2zTpnEiRFt8tK83g=
X-Gm-Gg: AeBDieu5i8+wy319Vn9deRXZRfDJ4F3dFKlg0UzkOmkZQqOMho/yf0/p7PI++SjaTUJ
 nHLI6HPtmQgA1cheH4oGfyOGNLjE76DrCzMx0jhoQeZVbt1DN6QPl1k0JY1/dSNe7LRI1o8YB8N
 yWeDOJ9yaeQEMLf8PwqSQqAte6QFMOpVfYIa1jNgfj52Bdls5IryZNPKPjZhBKyro2NjHB00cmY
 RVhVfMur0/c9+CbJ4R8XuRMUfyqWLRglP8w2alPFvLXN8d9QtiktbS7w/fhNhAY5DeBCftz4ejg
 eWuZvOHm5pC6B3gbNaU=
X-Received: by 2002:a05:6871:eb08:b0:41c:ccd1:78b4 with SMTP id
 586e51a60fabf-433f38e339dmr795803fac.10.1777353413263; Mon, 27 Apr 2026
 22:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 28 Apr 2026 13:16:41 +0800
X-Gm-Features: AVHnY4J0NOsxrtB7Xw-aDXY1Szl9f23DXz-Gvo7DzWpH61DRaKQqnGuVjuOg-jk
Message-ID: <CAN7C2SCzZLTa3Qbz=kTsX4g=UXwTd-eVUFSudfF-CYaG410UOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>
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

On Tue, Apr 28, 2026 at 11:32=E2=80=AFAM <alif.zakuan.yuslaimi@altera.com> =
wrote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
> case.
>
> This implementation turns the caches on temporarily, then overwrites the
> whole RAM with zeroes, flushes the caches and turns them off again.
> This provides satisfactory performance.
>
> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
> Preparation for Gen5 uses the same memory initialization function as
> Arria10.
>
> New Kconfig is introduced to enable this implementation only on the defau=
lt
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---

For GEN5 cyclone V:
Custom board
512x16 DDR3 die x 3
ECC supported to max Cyclone V allowed
No boot issue on soft / hard reset

log:
U-Boot SPL 2026.07-rc1-dirty (Apr 28 2026 - 13:09:08 +0800)
DDRCAL: Scrubbing ECC RAM (2048 MiB).
DDRCAL: SDRAM-ECC initialized success with 1057 ms
Trying to boot from MMC1


U-Boot 2026.07-rc1-dirty (Apr 28 2026 - 13:09:08 +0800)

Tested-by: Brian Sune <briansune@gmail.com>

>  arch/arm/mach-socfpga/Kconfig      | 13 ++++-

>  arch/arm/mach-socfpga/spl_gen5.c   | 17 ++++++
>  drivers/ddr/altera/Makefile        |  4 +-

>  drivers/ddr/altera/sdram_gen5.c    | 41 ++++++++++++--
>  drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
