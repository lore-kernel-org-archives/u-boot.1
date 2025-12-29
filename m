Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CF9E92FCE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 18:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBED83EC0;
	Mon, 29 Dec 2025 19:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j8yllv6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208C583EAF; Mon, 29 Dec 2025 19:25:39 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C4583EAF
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 19:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-37cef3ccb82so66604461fa.2
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767032736; x=1767637536; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaDSAOb+EUS24oxLRDRo4g1XmrIJaIUBLUhp6LoKN4w=;
 b=j8yllv6USf1CMRdxvSxfq+tgrJecC46GphXhHjnCYjOaSaGqvnzbo+VxfDU1uQTZMw
 8MnoajLTM39u4L9r4O4aRN5ibn6zaKN1Gyg2MuB5C5hIMr95JSA252lD1VMrbTKf+T9E
 taWoNEzQ6ZaFJfk4RCih25XfSFPBQxxIJhreZXiZxP4Gyv0Fg/E+0Jhrx2lueCT5Jibh
 98GxbtlY5z/C6LXC6G+DSWmaXe4aoRr2JroD2aQQAaIcvluiWvr7hO0XRmYfe0qHBE5M
 XdCUHVkUcVrcJ5pAoCxWq7QwBsE5OtP7fvDcfK8nCOUOkowtKKs/XrQJrtmnAn0rcJ8v
 /rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767032736; x=1767637536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DaDSAOb+EUS24oxLRDRo4g1XmrIJaIUBLUhp6LoKN4w=;
 b=J0VRbgaYC2mZmH65sIDMHZv+gDv60EXOuUIionF1NMNzfMfhz9XfTlxRfaslJXZaCq
 75lsKSghpXXef1Nmp3yZIFHs9KEJvI9JP/ljfEKkq3dC8GctgX38IQEit0V2qB2h3sDE
 x/DhvGcBmAL40dqq3aT6AsfEI2VDjvS9b19f1qGUNoRsTWx1y7ELSLryHpmEfAAtjNYG
 LxoNk0tqz79HeFun6OxU5tmICqKI//wvf1ysUo06BoGCt4nrJgYzo2A2dJnWx8KlyV7x
 4WD3RRH7D0S3a08nUxJyK1DqWrUPFyvtJOQ+iQT+43GWo1OWN/1c8wXQtvPuiJthrrrL
 QvJQ==
X-Gm-Message-State: AOJu0YwPGVcik60ilymbweWV4AMN4il7rLfiD+DeajXgPLUDpksXADp3
 dR3LgSSMg/Rladyget63wwafw9snSqxpAq/R68/4uASFaSozT/uMaG0PFQ/QQfnZy4ia/rF61cq
 bVFFYK0FhITXdKZqVpvE9saGMXMXyKZU=
X-Gm-Gg: AY/fxX5saXDPXM7bdtwuoPejrlCMvXlVRwZ8e9s5wkArr8+D+0QE4IZgeFbKSGuEX4I
 rkSx+qKcp6WEBl7RjSu15/GGe1UNw4tucy/2a9CCS2wMidxbVZXhxw/wDHPUfUtvVhC4xkdIBYj
 Q+fql79LIxj2Tiw3o34G4z/X4+iArapxLIplm4/j+IBqC7oz9qxAi+Xg28m+o8exXaw54A3+4tc
 JtVQj8WjdtUWlUo7E/nm8GmdHcfwLBr/Q/eqwgmOL/tP9QR4b1kdLFCdTZXsh+MWsv2TnpP813P
 jP1+k39DVJQ0M/EeCi79B3+V
X-Google-Smtp-Source: AGHT+IEkn2kJXJf2oPWlWumFIY2Kn9kr/apgvcQLdcKtX4BGaEje4x8iPnK9Nac91OxMVFM+voLZypeHEvxgZ3+dPlU=
X-Received: by 2002:a05:651c:19a1:b0:381:1c1f:f370 with SMTP id
 38308e7fff4ca-381216e1575mr102764761fa.33.1767032736286; Mon, 29 Dec 2025
 10:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Dec 2025 15:25:25 -0300
X-Gm-Features: AQt7F2qwFeT2I1xMcLywqCG5zJLTjDblnOD9Wf1HxZs4Mjy6fs7ihDYikulXVmA
Message-ID: <CAOMZO5AsktQAmFBm_VbNUXpPnGqocJdOczp8CWW=bPxZV0+3kQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Updates the i.MX8ULP EVK board support
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Hai Pham <hai.pham.ud@renesas.com>, 
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Alice Guo <alice.guo@nxp.com>
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

On Mon, Dec 8, 2025 at 11:20=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:
>
> Changes for v2:
>  - Delete fdt_high and initrd_high from imx8ulp_evk.env.
>  - Remove arch/arm/dts/imx8ulp.dtsi and arch/arm/dts/imx8ulp-evk.dts.
>
> Changes for v3:
>  - Split v2 patch 1/2 into two separate patches: one for bootstd
>    enablement and one for env.

Applied to u-boot-imx/next, thanks.
