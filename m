Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9A3CFA756
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6F6889BD;
	Sat,  5 Oct 2024 18:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C17SfCo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFE2889BD; Sat,  5 Oct 2024 18:47:31 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A6F8897F
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fac6b3c220so42041611fa.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728146849; x=1728751649; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kc8vLHHmyLxk9MtHgruyX7LPn+tG15aLyVe5K+AplLo=;
 b=C17SfCo/QCV6ifMKuyrJ6DAItM04qYOWE8eOVVnnc4ahn/EGQnP8lAhwQ8D4wfxZ3Q
 j6w8Aaz46WG0h7AXwhdcvHNV4RjvvHQ/4ZKk6Mg0jOtvjNxD/opr62RapI37mB6Xm/1m
 h50GJ4TZFinBoTPUO/eVPzcnyCRN4aZg10kzqoQlwEWGlGdpYbczr2y0TtByrJTxYMa3
 mUyIjpGztT77KxRdfxsmEmuUj+J7r0yo982/KdrgY64xeKbDRahv4NPjz6Y9LAkUQ02c
 DGREos5wba2LhcXvgbg2w+Y1Opvbr1JYUn8jpsj8sp1lyPPymSahGg2lgsmjAGr1QU/I
 2frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146849; x=1728751649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kc8vLHHmyLxk9MtHgruyX7LPn+tG15aLyVe5K+AplLo=;
 b=dNbDHJEnbhv1/Quc/bSi2++5YpvwljpgOPwiZGkpYmMpyFDYkY9MEf1Qw6dMKCK5Bb
 6duOLun8keOGs/KDRAPbN6grcS+3/228DG6n3IMkxko76maAIESe6RPDNPFkAL38v6JR
 dfm1o4qgsm+pbnMfxHlz2/dSJ5peSf/IPeMNjUYtLyBwWMpusu1WSkbLKq+N6cy0nJZd
 nWvQ1S+lC/512th3HLtDxiuSEyyYwZidQvhiq1PBe/F4ckdWWaynRh6Of2/OPjO0g3yR
 k+3WQI+QvoHPBQT4G7poWmlqC+jDWj2gCQgb7g4Z90iCZK7LWkP8NjOo5aQAIVG3k65l
 FrvA==
X-Gm-Message-State: AOJu0YwdsPWUtXJ9pPhjXxY3V6/dZRhq4I1Df/ZcFP8d7by/P3l2o4HR
 Qix93wNyy6QFM2VS8Bprf9JhjrHojt/Ui0KOKRXbg0AcxG4kEA4a+vLwbBoKCkmhsEGAHHDkf0u
 a5AkWNOgIN14mDh6P7qMcyyVn5I4=
X-Google-Smtp-Source: AGHT+IEbQKyfr988ZxL1z8Ny8jdC6L1fNPClAi6kt0rcpvapF0/vLE8ipvKAhWr3J3zS3ceGOCoR7Yy3aLI4NTY19ug=
X-Received: by 2002:a05:651c:19ab:b0:2fa:c455:23c with SMTP id
 38308e7fff4ca-2faf3d79741mr43985631fa.42.1728146848612; Sat, 05 Oct 2024
 09:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240929013226.2750458-1-alice.guo@oss.nxp.com>
In-Reply-To: <20240929013226.2750458-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:47:17 -0300
Message-ID: <CAOMZO5DBt2+YEatfLO6QhYoSDQdLNdJhrGjVRXGHbqRb1BRS4w@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: adp5585: Add SPL config for ADP5585 driver
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, marek.vasut+renesas@mailbox.org, 
 clamor95@gmail.com, paul.barker.ct@bp.renesas.com, michal.simek@amd.com, 
 andre.przywara@arm.com, ye.li@nxp.com, jim.t90615@gmail.com, 
 billy_tsai@aspeedtech.com, kabel@kernel.org, caleb.connolly@linaro.org, 
 biju.das.jz@bp.renesas.com, sr@denx.de, piotr.wojtaszczyk@timesys.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

On Sat, Sep 28, 2024 at 10:33=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> So we can disable to build ADP5585 in SPL to save size
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes for v2:
>  - added my Signed-off-by

Applied to u-boot-imx/next, thanks.
