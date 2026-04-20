Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D290EA71B7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCBF8422D;
	Mon, 20 Apr 2026 04:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QICU7bvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B218425F; Mon, 20 Apr 2026 04:52:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3617683FF5
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso403257366b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653547; cv=none;
 d=google.com; s=arc-20240605;
 b=dOIM0F5C4ByfAx9mkTufXNf4O8fyQxVAN3eKvazTPEs57mZhSL/SdzADSmlOU0Duw3
 hNqyo6dKKtiSeC3mP26XnycczUcVf8OCadln+s9MuCliVME+CH3v0JhWu9BSr65SBJNS
 XqnlqwRNwNx4DsSmiR7s4yJGztBOr+sRzW8s6f787hBk4RLhlCR82At/1FqNUas1Hema
 GfYjVxcBNjbdND7mn76S0FvLfmVfV7bI9CNLxREZNx35yhS2BZ1fE79W3uwelNcVkJw7
 GNFzZoebz0FcDPbhx5BZ8kkdJXV5SCvjsH6Dt8tq21SCthLFpz72qFw2DrOKl5oRIRKR
 j6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RS0aHo8vOxvq0ouX/FWjA3OxNJCFCKZANbgpqED+tE0=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=cCeCaTx6VjPX1u69jQQlwQi4PZwqmr7bel0T6rUDCNys3IEWqzpPBKHvL12WA2wNcd
 gI0g1pDiIr3WuEc9p2M9ptFRF6bgpQxHs6DvYXi2/T0Sdy/tfxMMnoL1ZCoqsmcJKb4o
 FU2ssoIfUjnYpkE2n5/idpGhJ5yZGYCQe7mWgWrIgZVRdxqS/scTR7Ln24J1XvvhU17h
 0Oojde582MzdLQi/FpQaL03uWKhvVuklBHMfBeUEhLljxIEau2J47nmULnXoOt10bHXa
 VNB5lW5H/5cLzbwd185hHB2yS/VUmlem9UucvBeGyGQxRsnGNEn7zLnja9krN9jTzfh3
 Pfmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653547; x=1777258347; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RS0aHo8vOxvq0ouX/FWjA3OxNJCFCKZANbgpqED+tE0=;
 b=QICU7bvZpHAlHKCEJXCf5vKB3yQor7wuuwTvGvlxaeVBTMeAg0YNmeLbb/2F8mi2eA
 M/inu0e2I4ZfwTgF6XRKu0qd0Qzpp2PhkB9lU8MgR1FLt3eycJnV7TLuSb6v3BMN/i8y
 LGUZq+VttJr2G5OBHb769vPLP97A702b9ic70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653547; x=1777258347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RS0aHo8vOxvq0ouX/FWjA3OxNJCFCKZANbgpqED+tE0=;
 b=Cw0oBVVI+jFOj9y9by2SuL7JF6Ov0po/nb7cC/8c6dY6zdHuLUFtbNt/ybFmCoJrS9
 bXfO5dLFvoU+SILNB6NKVUpoCZFaLh/tRX6JT5yu15lKZXJNj5Q9ee1Zz0i9mG50kyp4
 uS+QE6+IDoBxbkk1mgbR4x4Sgxc/rtlpLsPJGEJEvqRz19dEMsbqJGRDLkBIpwMSVb5o
 9XRVqnawEDMhcXLUUsef/YpRkSV3+ep1EljB+SxrUruQprI2erOu/tyKNDSRvb9uKbnR
 eka+RnhlubZm6wuF4J/75xt9BA3OL0yB1rK5Gvm/l/k+YUNJXYNVdnESrWTkvf7vnzG7
 qWLQ==
X-Gm-Message-State: AOJu0YyJzDEPXsFALox6XE/0/JCajAb81qxwS8B/hUEGwqPlPMhHPcbO
 UudqYwtRULKe9x48UsniXrynkGwVfwsWW2xFb8veqrvt0edc5GxENXCNo/zl2nopcJcRgH4dT9M
 H/AOYOxIAG/jLdCh4j9axajlH2T7fZW80lEmq6g9QF8QiYbsjzf9WP2hx
X-Gm-Gg: AeBDiesGNRbLffH505JHGHV/I+C0BJwpXMP/OtJh84MoVAMloj0w+FPLDcAytXmJqpF
 oTFNsM2U8e6pCfXWmbEpEGrnUrNK/cCxYGBM0D5D6LDSN8nqk7bN4sUu7WrnksF8vOohNVA7PMo
 a7X6v7ItGPnM2H/jerUboF+hdiVdagNHpR2vX5+fvBkRty9PEoc41/goqvmI8L7wUayrRMFiwFu
 AhaCosqqL3kcd54fZsl6PeTIRTqYcVUKMgVuahQYYxoIfXziOcXG/EvXcpwB7mOBpNBumNSmq2y
 IhYX8vI7wGQobFfdpIrJcHsVTonRsyc=
X-Received: by 2002:a17:907:d28:b0:ba7:8dd9:cede with SMTP id
 a640c23a62f3a-ba78dda21b5mr113634366b.13.1776653547422; Sun, 19 Apr 2026
 19:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <78daf6fd00f9f73f8fa9d3d2f86a9482b585035a.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <78daf6fd00f9f73f8fa9d3d2f86a9482b585035a.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:52:13 +1200
X-Gm-Features: AQROBzDI4xmfdLNR2mbYpYV3eknXHytiqtYJErfsk-UWjFbypo8QzxmJuH-qMd0
Message-ID: <CAFLszTg9j6kongPsrWrs_E9XQTxa6qKjdLmpO1wk5TgzdAAX_g@mail.gmail.com>
Subject: Re: [RESEND v4 06/14] mach-sc5xx: Remove preliminary binman support
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Remove preliminary binman support
>
> Remove preliminary binman support from all sc5xx ADSP boards.
> Full support was never added because it was unused.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/dts/sc5xx.dtsi     | 41 -----------------------------------------
>  arch/arm/mach-sc5xx/Kconfig | 33 ---------------------------------
>  2 files changed, 74 deletions(-)

> diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
> @@ -143,39 +143,6 @@ config SC5XX_LOADADDR
> -menu "Binman configuration"
> -config SC5XX_USE_BINMAN
> -     bool "Use binman for final image"

This leaves behind SC5XX_UBOOT_SPL_OFFSET, SC5XX_UBOOT_OFFSET,
SC5XX_FITIMAGE_OFFSET and SC5XX_ROOTFS_OFFSET should you remove them
as well?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
