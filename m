Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A9BCE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD6488E77;
	Thu, 24 Oct 2024 17:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="N9Abxrrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F66688E17; Thu, 24 Oct 2024 17:37:50 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6587188E88
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e290200a560so1190673276.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1729784265; x=1730389065; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXjAdAl+3TkcjhpeJvQQNtOiM979rMtIsz1Imc20Bww=;
 b=N9AbxrrvaZ5IvsMIO/gCkIbAqiG3LhOYsh6OcpoZ+YBGkK51gTHkxtnNuUysQQk1V7
 R44RhaU1VqEnrltKEKuhGyrJ/btugpFkBNLsA9ca6APIKNLbLRkVhBloZEP2ny3kVpHh
 PeoFafhtH5vugvtRevmCbNfbPUhoQSzzox8YCC+MPhjQScdUz9SKfA2dQYw2OOgpuWjq
 DAMbropBLT/4Rd8Es7cZLu+94d9nogGg6ndtFH2p60yl3yrL+8XcPjTmotdNrD6oGmhD
 4v819YTHv7ghcIRWqYgjhloVUan5dNphD4J1Z2/LjQeF690p7ez0tAxv75VpzKbhiKl9
 M0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729784265; x=1730389065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXjAdAl+3TkcjhpeJvQQNtOiM979rMtIsz1Imc20Bww=;
 b=SpMILZM1mMoqUgCVe6r2WIkOYQowS+mgaWKJz6aGhIUziTpJS3d1rNf0x6VAUYid8B
 6XwsTIv/rBcKwREiaXc4BoKqNu1ueseNAE3Q5q4YjtGW58Oyb15l6qamZ5Uw2sWqF8fk
 4CtXKbmw2qmlykVpZoqYF7ZA3/q/68R/SwjOcgTvxzEfEayfcIP/qU0u4N5Uenle+y5K
 wX9QjzFZGyig36+qxxj58m3ASe45t37OJaUPhY7g4W+Odn44x0WaCBFwR7M3z2Lk87Bk
 NB20s5ZZTgZQaoypPcHHonod4d35ecUaq4y4i1bH5KciMqUl9Da6xfLgAdjjzS3ux5qG
 KHRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa575h58OFaPzhS1Tk1kx0m7vPlnyt8+LtoJx2KVM/Q7BEeQModEfoPWpDn3w8Psx5hY74ASY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8BqlNjin5ZIHPTNakvwniJGUYvYKatJfYbq9NcVeadnbzfy5W
 cXF9CF5brhYIWIwMJt547TPr5SDlFBHbkkQ53yKl7u3CliTwNG3nvlKmKx110GaURG/E4UTU8RW
 e2x+JsgT4t+zyzKgq1UMqDRSplool7KXr8fipnA==
X-Google-Smtp-Source: AGHT+IHCGW5Hq4avfvCOudJbYFx+h3N4yf3wipiM8//wXAwVIY/VsxM84fX85t7lmSyQbx8a6cYd25pXx03llnY9/lA=
X-Received: by 2002:a05:6902:102b:b0:e28:f0e5:380b with SMTP id
 3f1490d57ef6-e2e3a607229mr6697474276.4.1729784264455; Thu, 24 Oct 2024
 08:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
In-Reply-To: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 24 Oct 2024 08:37:33 -0700
Message-ID: <CAJ+vNU2vZM5B=BhNtsOHU-jGpSsAvR7Sfi91QCFRrOCMYX_Q5g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] imx8(m): add optee node to binman FIT image
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Manuel Traut <manut@mecka.net>, Benjamin Hahn <b.hahn@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Thu, Oct 24, 2024 at 12:04=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wro=
te:
>
> There have been attempts to get op-tee node integrated upstream in the
> past [1][2]. The challenge is on how to handle the load and entry
> addresses where the op-tee image should be loaded to.
> Different SoC families and architectures have different RAM base
> addresses. Further the final addresses can vary from board to board
> (e.g. depending on populated RAM size).
> As a result, I propose to solve the issue via device tree where the
> optee node itself is defined the same as in previous solutions.
> The difference in this approach is to omit the 'load' and 'entry'
> properties from the node definition in the <soc>-u-boot.dtsi.
> These must be defined in the <board>-u-boot.dtsi.
>
> This solution avoids the route via kconfig while still allowing each
> board to individually define the op-tee load address.
> This is possible as tee-os node has the 'optional' property.
> There is no need to keep parts in #ifdefs when no optee integration is
> desired or possible
>
> I included usage for PHYTEC boards for examples (with documentation).
>
> There is one caveat however:
> The series in its current form would break all other imx8m{m,n,p}
> boards. This is due to the fact that they do not define entry and load
> addr for the tee entry.
> During runtime, spl_load_simple_fit fails for the OP-TEE node (no load
> addr).
>
> [...]
> Can't load tee: No load address and no buffer
> spl_load_simple_fit: can't load image loadables index 1 (ret =3D -105)
> mmc_load_image_raw_sector: mmc block read error
> SPL: failed to boot from all boot devices
>
> [3] suggests (Any absent entries are dropped immediately) that
> using this proposed solution should work and is allowed. However [4] on
> the other hand clearly states that the entry does not get removed (which
> is the case), rather its data set to 0.
>
> To me the question now is on how to move forward.
> - Is my proposed solution undesired in the sense that I try to use a
>   mechanism that current U-Boot/binman is not designed for?
> - Should load_simple_fit check and discard optional entries right away
>   before doing any other processing?
> - Should binman be changed so that optional entries do in fact get
>   removed instead of being zeroed?
>
> I am asking for help regarding the questions above since that is not my
> area of expertise.
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.39218=
91-1-tharvey@gateworks.com/
> [2] https://patchwork.ozlabs.org/project/uboot/patch/ZeHDVr-Bzm935-5N@mec=
ka.net/
> [3] https://docs.u-boot.org/en/latest/develop/package/binman.html#optiona=
l-entries
> [4] https://docs.u-boot.org/en/latest/develop/package/binman.html#image-d=
escription-format
> see optional: description in [4]
>
> ---
> Yannic Moog (6):
>       arm: dts: imx8m: add fit optee node
>       arm: dts: imx8mp-phyboard-pollux: add optee load address
>       arm: dts: imx8mm-phygate-tauri-l: add optee load address
>       arm: dts: imx8mm-phyboard-polis: add optee load address
>       doc: phytec: imx8mp: add OP-TEE documentation
>       doc: phytec: imx8mm: add OP-TEE integration instructions
>
>  arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi |  5 +++++
>  arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi    |  5 +++++
>  arch/arm/dts/imx8mm-u-boot.dtsi                    | 15 ++++++++++++-
>  arch/arm/dts/imx8mn-u-boot.dtsi                    | 15 ++++++++++++-
>  .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi |  5 +++++
>  arch/arm/dts/imx8mp-u-boot.dtsi                    | 15 ++++++++++++-
>  doc/board/phytec/imx8mm-phygate-tauri-l.rst        | 26 ++++++++++++++++=
+++++-
>  doc/board/phytec/phycore-imx8mm.rst                | 25 ++++++++++++++++=
++++-
>  doc/board/phytec/phycore-imx8mp.rst                | 26 ++++++++++++++++=
+++++-
>  9 files changed, 131 insertions(+), 6 deletions(-)
> ---
> base-commit: fd3f2e3f0edc1f87be4c5a39a0c81037d551c069
> change-id: 20240903-phytec_imx8m_optee-8674ef012a36
>
> Best regards,
> --
> Yannic Moog <y.moog@phytec.de>
>

Hi Yannic,

Thanks for looking at this - there is a need for a solution for easier
integration of a TEE.

What is wrong with adding the address via Kconfig? My attempt [1]
failed due to something in CI that I just didn't know how to fix or
have the time to look into.

Best Regards,

Tim
[1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.3921891=
-1-tharvey@gateworks.com/
