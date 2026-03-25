Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02083FEC11B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 10:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F5583A41;
	Wed, 25 Mar 2026 11:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y6G69Bsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47F083E16; Wed, 25 Mar 2026 11:29:49 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2381883A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 11:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ef161129bso32397d50.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 03:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774434585; cv=none;
 d=google.com; s=arc-20240605;
 b=jjsQBvXuCKScIcOSai/ZDYzJ+ld5PyYzzGbfPNwNsMfl8BB9xEx5RWw5KfbDoI5rY6
 CyDgwZmW0x/B26Bcz8lMDiZ2EfojqdtMTkj0LFT/Cm+T8cR0M+g0jIw+Xd+T4DKidtcc
 x+Bn17nN/HceNYPc9aHVSypmB3cNjGyWqLG3+gbUnGKoZyetiGMWC0WJpLZOYMALNDrN
 tS5MDb9Z4MAW3h+UwQbNEcxiQktllMYAUA+eq5P0eU9siUrobpzaQdVRnHeuZxx8BLYk
 DdsNP9FfGzR6mwTQa7SyCNHMc00v2zrHk/+2BUKiey2brol7Plbx1nOEiAP1TJJbusGU
 CVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eYy9Gu7vUVKI/1WpphIGN9Yv4Cy9EwOQpi/QikZwfYM=;
 fh=uTnDlP2K94mbxOZ1gyYlj7r43RkjiEvV8jqJR1IlN7E=;
 b=AaP4yD6XswwrYfdPsLBsm9g529uWq76PnAR3j7wYC8t9okfoKIMYLkBGSH5TXQ9NZy
 xcF5SrqM0nu1uGqcP9srZM1AcyJjc6eA3fSf3IbBfQ0yOKXZzXLxmezUNHFzbYxQ7t/H
 Ekvpr/ku22GoQS/lvRT8n9rU6bal0Hil+wRT5pDYGuSPs+KFB9CZzP5Z5V66ICpamURx
 l4IJpebvu2tA0lsip/XQG0AKyS/n4zpcJfwV0B/L4OZXVpfxp3jK0oyy+WNFazJxMQP/
 A9zcwDtf5S70UyTjV1jwNgSIWKDmqjOgTWeOHk9aNbpVeCncnSwrlSHWAnCVWx1d+hS8
 Bnbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774434585; x=1775039385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eYy9Gu7vUVKI/1WpphIGN9Yv4Cy9EwOQpi/QikZwfYM=;
 b=Y6G69BsvYzzWexOiOJtD5z7agMgmAysl5Xarjs2Bq2gDj/xdx4lsJi5X0C+1GrqF8W
 fVPQw0ZHmIZNnTPzy4/H/cAtdvDVsdt05L6PSgwuVuYS0iyLKCaVeopaJ9xZ4Cbj2WN0
 mjwcNy1C438GMOrJBX6gzHqjigpOVH8UoOtqx1xT+oXRQVJSnKEWg2TK6ABUiCPeSI5W
 byE6CVG0abmQNiJqhksFv6p+bgjJTFNf8kNjnHurp2yDdwOmhhK0+8lJMAzsXwGIZYBS
 wqij5roytDu5BkR0YUK3pmI0rGYyl3JjiCxNPAGhJ4cwJ/vKYLiDhsZ4cfQ3nGTUoIpI
 CGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774434585; x=1775039385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYy9Gu7vUVKI/1WpphIGN9Yv4Cy9EwOQpi/QikZwfYM=;
 b=X/vXXbw3ArgHYk750purWt/rtq4hklTBaKFyvZnw19OudTFwld2U/FCpvRO/TNQbGd
 LPEsTtpl8ndF1e/IGiSiUGwY/z7IX3An7h8OBRSPGyV1AWClKz1ABlKi8yp0um9MveaO
 TMNpfGhxbM5LiZz6vv1PeRYP+3zxrEy8Kh3qHww2aHLSRsg+/Jn65657+rTq3Ivo1k3z
 AUYlhOp1omTQpQ+8rK5nsWPI1S1ME9WQq/L/Zr0IzRXzscLRpzJ3K7HMCroXSebTAV9T
 E6W8LzrJoQ3Ja1GEsPutKi7sdr/4OKqfIT8eO1Are8M2PkjBGlXZ0v4FA2l2Pwt2EsB/
 vD7Q==
X-Gm-Message-State: AOJu0YypxYbXL0KDfSeIJna1CmsiNSRnpG7uESQvQewVO7Tou7TvZe5U
 iHpXA/p76HhyZswZVIumiQpN37NTsA0+l2byg857xvL9cSuSgWXGAIGyMjrWOQnvmFRfn9DQh4i
 Me9wQ2UGWUXsv5kcsfeLyaeH3S0YxgWi+FMTc2IktfA==
X-Gm-Gg: ATEYQzwFQMW8W9Y0uThrMbE7G97UZ0S4XMj7NeOcMP+w/9znH+rKHk5oos9DGkgI9o2
 /KxgVnJcIKApIV+OljvXuDWeePCedOtm/9Yj7P0y91ZNvxqZhBulqzLaa0n6S0XD8apfX5qbISB
 0KnuNHO+mkc+NrSodztkeMiGeMs9IogMx1i7SQiC+8wC5KoVCL7vEn5kolhMp0GZCEL9fWhO1D6
 mpzDit1+vDvBg4Sc7ZdV6/M0fTiKIbPrfqBDFKi4UuDGQmgxFnC3pFJLMXpU0VIlAakrB+xo1G1
 9ehTEpDmTT6jNrj27aKhB6br5zLsEPJZ9qUANDVZb9FGhyaSYw6/QLKXghVwi7GHhs9VXH705SJ
 RvzGeIDC/4RNPksh8KEKuUrNN7SrsIDWcB4QYOtNzh/Vr8lFfupcaEWWK+93WbLWdFrU5YO8y0Z
 C9zd6hrG1/hMkjik7BmS6U24/E5C9KJt9DNm4ddQEVSCEyaBMiIkqWtXtiJlcr/PPiJNZ28GYsD
 C57AEtMC3gLUKrScsp89MYeF5wyr1W8gWTDg3+Mk5EOi8vBdnOw6i+JpYnUv3CeM+z6mdbNGkDc
 7eH8ocx31eXNGqR5u1Ag7vtVyGSk59FhGoez4QJHDJ+5VfNyMijOlg==
X-Received: by 2002:a05:690e:4005:b0:64c:f871:6524 with SMTP id
 956f58d0204a3-64ee616f34fmr2490056d50.81.1774434584825; Wed, 25 Mar 2026
 03:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260325010716.280005-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260325010716.280005-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Mar 2026 12:29:08 +0200
X-Gm-Features: AaiRm52uL6U3CkevVyzAp7LM4cQ6ALNSecjUq_73YuryqBnicuQ8k95f6eiEj_M
Message-ID: <CAC_iWj+d4-ZVNOtyM_z5YiPYyisL+gpbObmchVLiW+2OnssG-A@mail.gmail.com>
Subject: Re: [PATCH] net: bootp: Drop unused code
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 25 Mar 2026 at 03:07, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> This code is surely unused and there are not even commented out
> references to the function name. Drop the code.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  net/bootp.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/net/bootp.c b/net/bootp.c
> index 1d905a01a47..8976936b184 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -87,23 +87,6 @@ static u8 dhcp_option_overload;
>  #define OVERLOAD_SNAME 2
>  static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>                         unsigned src, unsigned len);
> -
> -/* For Debug */
> -#if 0
> -static char *dhcpmsg2str(int type)
> -{
> -       switch (type) {
> -       case 1:  return "DHCPDISCOVER"; break;
> -       case 2:  return "DHCPOFFER";    break;
> -       case 3:  return "DHCPREQUEST";  break;
> -       case 4:  return "DHCPDECLINE";  break;
> -       case 5:  return "DHCPACK";      break;
> -       case 6:  return "DHCPNACK";     break;
> -       case 7:  return "DHCPRELEASE";  break;
> -       default: return "UNKNOWN/INVALID MSG TYPE"; break;
> -       }
> -}
> -#endif
>  #endif
>
>  static void bootp_add_id(ulong id)
> --
> 2.53.0
>
