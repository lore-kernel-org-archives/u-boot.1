Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA54EC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 07:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69E9480F47;
	Fri, 31 Jul 2026 07:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0aHu0BYpbmg; Fri, 31 Jul 2026 07:14:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A550D80EC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785482099;
	bh=sowwqNaemjInlLcOKI+yMME+t0nvPp/vZhsT3KkfGYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YbemW3nZxbUJ7FMjUqQv9DR3De7QriaY+08PKri1S1C8qXUgnQdUvuwXHl8BDBMxh
	 WgaweiyvMXoX9fTg45APHAq6Oy2YSuNSjyh/UzUW7O5XWq2GATBGpUHPNSB9YZgVCE
	 OqDr5XaHiOCHuKrlBRc8UxKWvqB8p5ArrLdc7SB8fFE1Y1fTSC/yWgrE3oN3aeP1mv
	 G8/rQGhFHf1+SGjksG6YdAVLctKUOwKdAmR8z220WaRQeX3csF2lvcyKn1kjapxpZk
	 rFSIVTD+mP6AKxACyPHzbiKaVkzaAIz8/hD9jsYh5tl0CuA/W6Zx+mPxFPm7WB1ioC
	 1R5kR2nZVwHVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A550D80EC4;
	Fri, 31 Jul 2026 07:14:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EAD1927B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0C3B607C0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:14:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SpdcTeUHWi2r for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 07:14:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 36C2B607DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36C2B607DE
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36C2B607DE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:14:55 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so78864566b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785482093; cv=none;
 d=google.com; s=arc-20260327;
 b=qiWWLMc7+J8RMZhbDPvpppvn+0rl59ce2Wte34Wm1YRG1twM2HmZfpsnlp8ms7C9mk
 Sz19w6O7LqTDJMVd6UCyNAcZwc8huW3iZuUDyW49AtbV7c4WOpaeQCoTSSLiDuDWE66y
 9+QRIONpub1WXB0RJ2UpN0lQWikcF7g/w2+qEefBhWraQgMDJOtjE32YNL1i39xFFAoO
 9xPOalLworjV1flH35Zd0gx8AG8s5XdEKwdpmpr3V7aLoJZgMKhcrkcwVQY9cSsCpkGr
 VacsqogIIiEZsOww1YOwU1uJsk1Y/aBwAlK5Nqt5Wymh7qGaci6gQpx39VfrjFZWTJvc
 MDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sowwqNaemjInlLcOKI+yMME+t0nvPp/vZhsT3KkfGYU=;
 fh=B+sNfGFY/KP+SMcFAJFwd//jdROIPj1rfj5QBs9emFA=;
 b=X3PU5I1XCOE4HAt6DXUgheTC57ZynIEI3HVz2+NVUb9VcEBu/oVs5zkpwLxlsQ4oKP
 W2aUtiUylgBFbAIEPvM0iZRgqZliitr37ShmS7iz0gr+PS/PUtzbWqa9Lis8AAtGBZYM
 pVpn3WSnKGQ31W8cKN8amA15qiy4ElGGNetmNP2ou3gfpoh303sK6V0xSVesOg7NZSy3
 iRPXHHZFV/tuMmMa36FRUvg8vD1VnAwtoyQqrXW8gxkyP7tN1H+Jekk3fJl6pmvos4vJ
 UwFRom9iU/voPGIlKUpfD4nqORLf/EciiVV40qzUOu0PP+Q7G13/1bND5/pjJWdXq17O
 kTEQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785482093; x=1786086893;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sowwqNaemjInlLcOKI+yMME+t0nvPp/vZhsT3KkfGYU=;
 b=noBe5vP1PmfKxZc76/tdF5Yi/3m9pkHWmnonIDlE6oHj+Hm3W41o7OFjXRQQeaIZ52
 QDiQvHcCdDPwUKRkyVjLPZnYYsFkVk5gKzAZBDnrpokwAjA2lG/5gE8hSIKkCLpF1313
 qrgc0R8TRCRC9N7aBNqWbzMckXbbikQymyM+oEWOfRmam3JTrRQ664ATIdkk41BKZTAe
 /lRFecIaIO4liDr8mQIm6kH0MOKGXPIWEl6Ry8KrPPJoEKrFzkPcM4oagOMnLa0gAcJ3
 31y5z2evz8pD5q0L6Kk5XGJHjFNxX3/OZSDicZisIjwySmRKWivKsz050N4bgBYd57va
 aQbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjQQ9QABf4sJrytb+mKidiqHM+yf3G3LOCE1qZkIwxGGPqnOlcpC894B+OPJEW3z6QnUdjqSI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxGuFk69CGtQW6tLLHlwIvMjQi/aueQk3Ro9Ewl8XZaJEcHN/fa
 2O1y0rtBl65bWA2JijUetL3+MdzN73vo5ctpBl+fAZVnu1GIgnnCWoDWtbuefbVlePmQfXtoGM0
 fuHYrew+vn0mO9jhaJjdI3XsijPFoanxFHF8eU9mnuw==
X-Gm-Gg: AR+sD13uwpPegfwaILZpVqL2dOAc5vQ+rp+CpjXyloFJ8WFPa6/tOErpuWmgVXmV5l4
 k2gkbWOdEFwPv074FmU00H7kdN3lrEkYqePAtnReebkcWDJ0gwteFJ4b8uE7wGBZ4pvp2b5Ndcl
 LGP+Fp9bCZgWdrlPN6BvMj0rDHKlOecVAspX622mkpqfN9ClCYduF6MlzP63lYfm5T2sQijCidS
 ClOC39GLAt0fTizeNOTKOEvi1u8eslQBZgsAYzXQfgUNJAomOducJPPM022kKJLE/897Ey1qD2s
 6VZSd1BDxFmK7dWsFbUsZGleEZLJsfVxy9B6gwC5b52OTzak6+J92tanIAdL/rwyjMNtBPR/PXJ
 jjBHMi+rZX8zGyy2n8Km2wOKAeATsP/PvdR3rv70=
X-Received: by 2002:a17:907:c8c8:b0:c1c:2ee9:5e6d with SMTP id
 a640c23a62f3a-c1fd23c5a64mr41029366b.17.1785482092983; Fri, 31 Jul 2026
 00:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-ccaione-upstream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com>
In-Reply-To: <20260724-ccaione-upstream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 31 Jul 2026 09:14:40 +0200
X-Gm-Features: AUfX_mwpB_QtxDdUHKM0S3wn_Ju1xOJ6Qn7HMJoIdkCmPz1msCjX3AjU-tZyVPs
Message-ID: <CAEHHSvb-6EZT3QptoLd_hYaB9NfQLM5fJr7LwZaZ4NsyKzN68Q@mail.gmail.com>
Subject: Re: [PATCH] arm: mediatek: use phase-aware PSCI reset on MT8188
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785482093; x=1786086893;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sowwqNaemjInlLcOKI+yMME+t0nvPp/vZhsT3KkfGYU=;
 b=RwL+kAeOc9wYBFgvn32HRiAUrP50p3z6/KLmNEGsITaKOlkP0mDeV1jfhCu6lm2m9T
 iH6tdw14JTgybFZ1dIfRK9sFC/hih++CVlhhLQcQJ7NrfgG7+Vw/ItBnSTsk18S3kwnT
 QdZEjM/j+d1nQvo+yW6EmkMRT6k2iInOtYXGSQ6sDnz0LdzT4k9RPthkofbDRJ0zgJFD
 UQXAdxTT2FP68FxNvpNjWqv+6BGZLPcoPAG7OU3kES1fPkfkIsoxQ2E/uQSFPZ3//uNl
 1WoZu238Ztxtr8RJJ0EF/mg9AelCYcP4YebO4NfvYWbCk30idljj2PBLAB29MpTXRJGj
 RCfQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RwL+kAeO
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

Le ven. 24 juil. 2026 =C3=A0 10:45, Carlo Caione <ccaione@baylibre.com> a =
=C3=A9crit :
>
> MT8188 reset_cpu() checks the U-Boot proper PSCI symbol even when the
> function is built for SPL. A standalone SPL download agent runs before
> BL31, so fastboot acknowledges a reboot request and then stalls while
> attempting an unavailable PSCI system reset.
>
> Use the phase-aware configuration check so SPL falls back to the
> watchdog reset provider. U-Boot proper continues to use PSCI as before.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/mach-mediatek/mt8188/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediate=
k/mt8188/init.c
> index 1108bc19373..b2cdec8c218 100644
> --- a/arch/arm/mach-mediatek/mt8188/init.c
> +++ b/arch/arm/mach-mediatek/mt8188/init.c
> @@ -33,7 +33,7 @@ void reset_cpu(void)
>  {
>         struct udevice *wdt;
>
> -       if (IS_ENABLED(CONFIG_PSCI_RESET)) {
> +       if (CONFIG_IS_ENABLED(PSCI_RESET)) {
>                 psci_system_reset();
>         } else {
>                 uclass_first_device(UCLASS_WDT, &wdt);
>
> ---
> base-commit: d0c49353a648e135f269a2953dc9326505ba87de
> change-id: 20260724-ccaione-upstream-mt8188-spl-reset-8aaee719823d
>
> Best regards,
> --
> Carlo Caione <ccaione@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
