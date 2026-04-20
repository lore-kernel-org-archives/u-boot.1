Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDA9F5A8AA
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E650A84435;
	Mon, 20 Apr 2026 21:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eZW8qYvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD96884435; Mon, 20 Apr 2026 21:36:01 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD81784376
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ba5b107eaa2so419049266b.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713759; cv=none;
 d=google.com; s=arc-20240605;
 b=gH5bvy06vrjqAr0ifpIlmd/LMAyuBwz+xzpF5RFMrDrHetBZDfPN0BM/kx+K63ivUG
 ejEarF55e93AmSAAVz+A6OYcsKKH9LGYhBROai9e1DfCng5WOh8C5ktufLclCQzKmIjY
 BmiZB0nxsEnE0yUB9YxmMJuGCEhg1b+26lr92eNf8F9xvFn2EFRNu2+hS2uQZ0lQiUCH
 7rmsvDh+jDmj54Kw2CNjKbR/NnJ8ljd1Y/RxyPIxZuBTNcBfjtDhPwYYQbqUvn+sc1q4
 FwVIUkAkMZYuoSzJ1udKjTqQDDbe6AgQ/IJhBFwaKb28mBeJ44QFptr5uj+SdX7TRimw
 MJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3o6mumwAAUC9gTP2DOzlKAwmJf/H7bRnT6OycsWp/xQ=;
 fh=S+A4YzKCfD3UjIXSY+6PWjemUPsmCfihjKd3tkBpr6w=;
 b=BnRQwprwfS6Sg1UIfR9m5QVOrgbAwK0qEAVJwTOdxVJtzl+W/hLe2nvcOJ8ZlG5a5X
 JN+3FjJHWfJoXPoNB6lbSRdIiLJznu2unVZxT/8ej+ny30G0Deuy9FG69PsfWEYT8qAf
 S5pp+bLWUSs4enAqJ5E5tegBL1qEQE+Voi1Hd+bTUe5VUfHENFZhpt/lpHOj+GUcg4hO
 t4eHR01sgO7nG+oC7qUBx7Mh+eDln6F140csQ/gkegr4rSrLYDMLHIIaj6LPWplIs+bd
 Rsh3Pqck//EocTIJZgpr8/1fi4FIPbTm4caoBG7eyQGrpulEd0apIHHMKxW5Gq8nB3AT
 NCPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713759; x=1777318559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3o6mumwAAUC9gTP2DOzlKAwmJf/H7bRnT6OycsWp/xQ=;
 b=eZW8qYvF8Hqz2pE4grtefvEh1Jr+dWlvcLfI9+1QsOkOik3XNs0kXxvby42YWO5xHF
 28aO4PHNCJA08nznv6oAKy0B3YthbVG9I5kWrg7LWbYa1vptJWsPuQe5j5B5/sIyKGZ3
 g+/7yowSl5AkEPXh3efvO5+HrLp32gcfEWJ4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713759; x=1777318559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3o6mumwAAUC9gTP2DOzlKAwmJf/H7bRnT6OycsWp/xQ=;
 b=em+Lz7Plgg7q58xRYmPEkEIRCF7atDD3b8CRR16DtOUNzPWAi3LkZVs4TXyNrUJpcq
 kUe4DKzu6SQgyynaTOPLSlVC5yG5IbdbiEm3nXMdZ58/Fyi5K7ReRmT3ZC+RYTt8vUuJ
 oSXDS2UBLbDlqbKxtfGQyyCgLFYnBlgkK2ROxXUdndNP9QLlfHtDVCBy6DFVVOywwSS5
 LIiDxsUBJFz4fZPjk36IEOVn851vtLN98ou7CiiOj1jxODc3hBMLa1PI80r1DFVN3Z4G
 AOXimzhbHzdYI4NOi+Km8lb23gifLO4wORSWEw5eqYj5ouNuSm/0b3wSNQQ9QPsukBNl
 A7fA==
X-Gm-Message-State: AOJu0YzOcbCVJzXrvHfVHrxDBWCrpHgM4IZsKlKIo3vo9cPXkazINWIv
 zTdgJgcxKyJdg3eiFVpzkuKt4UMx2ZrXSwEt7xmuorXPU3N6xH4zAHqxOfju9wM4sIYpjFd5n7U
 EeqpTpKA/7DURwzoVKUnucVsbIpxVyUVjW/vsd98E
X-Gm-Gg: AeBDiesdU3uhzlsXza3RcBY6XN7rMKdOcFgkPdBxWneYLVBqkYm8pdCmoLnc+m5zbBB
 lsqJ+MHwDEvTM3PfxPFE/5ryy/4Uz5x/UC6+DThDor5YKrYuFLcvNC7iiNIPzZnC+FN7COYciXK
 eLujw55hHp3edRfjsPMNKFSgYhPBvc13qmQBSwqnt+bPB1b6ohfNzllspnThcqrbIvGgVUCrS0i
 OSh1twlDcwryz2JF6eepzOerkoB4hjQVLIXXzNsoN7435tzabmZIbnG/hrQGAnRjH+m4Q81QJug
 VW/WeSvg6CTpQWr7Py1e
X-Received: by 2002:a17:907:3f9b:b0:ba8:bcb3:e2d0 with SMTP id
 a640c23a62f3a-ba8bcb3eaabmr165398266b.0.1776713759225; Mon, 20 Apr 2026
 12:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260419173541.31592-1-ssrane_b23@ee.vjti.ac.in>
 <20260419173541.31592-3-ssrane_b23@ee.vjti.ac.in>
In-Reply-To: <20260419173541.31592-3-ssrane_b23@ee.vjti.ac.in>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:35:46 +1200
X-Gm-Features: AQROBzDPpPrXykRZqqbceN4HxpQMYyPJEusZj2m37996ksaKbT8J2Jby3pnNDEs
Message-ID: <CAFLszTgW5H=dg80kT1Dk=FB-EWgeV-AFinQEC7DsdawTO2ggPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] BeaglePlay: enable IT66121 HDMI bridge and video
 stack
To: ssrane_b23@ee.vjti.ac.in
Cc: u-boot@lists.denx.de, jd@denx.de, tl@denx.de, trini@konsulko.com, 
 sjg@chromium.org
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

On 2026-04-19T17:35:38, Shaurya Rane <ssrane_b23@ee.vjti.ac.in> wrote:
> BeaglePlay: enable IT66121 HDMI bridge and video stack
>
> Bring in DTS bootph-all tags for the DSS, I2C2, HDMI bridge and
> pinmux nodes, plus defconfig options for TIDSS, VIDEO_BRIDGE_ITE_IT66121,
> BMP and splash screen support.
>
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 42 ++++++++++++++++++++++++++++
>  configs/am62x_beagleplay_a53_defconfig       | 13 +++++++++
>  2 files changed, 55 insertions(+)

> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -322,3 +322,45 @@
> +&main_gpio0 {
> +     bootph-all;
> +};

Reviewed-by: Simon Glass <sjg@chromium.org>
