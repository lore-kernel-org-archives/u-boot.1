Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD571D12D5F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 13:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC73983F91;
	Wed,  3 Dec 2025 14:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/c7tH0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4418383F91; Wed,  3 Dec 2025 14:38:20 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4909B83F7F
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 14:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5957e017378so7829417e87.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 05:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764769097; x=1765373897; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJYH5Uja8w9hhajtFUpKycV4KQEpUQFCOSic0OIbXeE=;
 b=A/c7tH0DAk8Xva9vkSqLKlwxIqa7VgkA0fSvMddz/fqAn1VaeUgNDVOCvus4CdkNDO
 1pf7wzrHLHSZBfRFLD0sbZahtpagO4ts7o66d/U8+07N/LHxSPJGOEkZDBHQJ/2zWqfI
 TRpuA/rkRyqE+FgW2XfNoRqUVcXkU95RfnerPG9+RMtINm/uxId85Sp2ixIY0zVtW8Gq
 ZHbwcyc63nIxCM0wulYKNt2B9FX7GYFHlTgcFRxgz2zMqbMnWCIVoAnnoLQPyNMRelZa
 Coj/fbIogz1s5agMsM/KZgpsO5OV2B52+8kYahJcn4S4D8SkBSga4k9yQFUFR1chLzI7
 Z9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764769097; x=1765373897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AJYH5Uja8w9hhajtFUpKycV4KQEpUQFCOSic0OIbXeE=;
 b=dAhbLazMdLWKCOUzP2P5bHyhVxNPGmC+U3S2rsQV5UOMnVqRtXMLnV1WXJr6qWeYG/
 W6GboI/VSV8GsgHC5XqMntbUtnE5tSrnrnf/7/LQJ0bonSc7jbdvjhe1IAffDJMIFkcs
 vNna9AprohESjhAN9kOv7h24PE+Bm0VpKIiKwTCXOtxQ1bu61U6Me4gib/cWc04O3faH
 G9V611iokOxzadAwadmO1mwXV6vwqO3lCvH67CuotLmrua53EYLCQixv58bWKN6sML7F
 O2EqweWk4ywvuNBd1//eVz0/RLr26wuTV3BJuVEBApiNd81MngJW6Ie9cTJE4+Q8Yy6t
 Ef8w==
X-Gm-Message-State: AOJu0YzDDGd5Kogn6WvNaC48kEAzSOk7ApCphyhKjEhaaS/pBk6mVMxh
 sM162mC2z6xhiOcN3x7dm9dpHKBwnU3P5sPYwz8cmxC+ZFB6F/p973uKxUq5lXUtTnB9aeT8t1M
 G1aUI2Iu2Fr9hzcPewmsm8qgKpeP0cjQ=
X-Gm-Gg: ASbGnct1NzDO4VQ3W5ZQfXVoq3kKkfme/eLYQABUnGhdFExsWwCm0NFF+JFgP3B5qu/
 KxZcHocp7eHjXMLJdFUkWGqkC0o++b+rl0Gt05UgFzmlS6IboT3MjrldfGfXDoC61feJ4m9gOsE
 uUDzER6nBX32By7DhJblugoeEENv7Aiy+tKyCODtJ8RVYAONrXfcuSTYnqw8BgBOY1XCJeNocUS
 7ZdE0taMhJ3iPJeQFyA90bp3kSPIgdkfadt2FZvROl4RivntNUDGr4pf1qFPgNMZ3jj5cFDi9Ov
 afJNt9iSGq9fM7evAIJi/WYfWR0=
X-Google-Smtp-Source: AGHT+IHGyHI0u+Wwz7EZV91mhVVQY7Ri2Cyn0s7V4y9tcJQfaQBvpJgQ6DVhnujJ5md8plucGpSFvpM46Av/HLer9QQ=
X-Received: by 2002:a05:6512:114f:b0:595:9152:b93b with SMTP id
 2adb3069b0e04-597d3ea9286mr1027865e87.0.1764769097202; Wed, 03 Dec 2025
 05:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
 <20251203-topic-am33-evm-lcd-v2026-01-v2-1-262cf4f34eb5@baylibre.com>
In-Reply-To: <20251203-topic-am33-evm-lcd-v2026-01-v2-1-262cf4f34eb5@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Dec 2025 10:38:06 -0300
X-Gm-Features: AWmQ_blhAl5dPbvc0LC8d2MwCjNZAhsC_1FjIEcUxevFeEWbN76N1ienHNajEKo
Message-ID: <CAOMZO5Bnr369g+9T_a1EOHPfAG80WATHgkJ9VVWdHVSMCRKEqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] panel: Add missing comment for the timing argument
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sukrut Bellary <sbellary@baylibre.com>
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

On Wed, Dec 3, 2025 at 7:19=E2=80=AFAM Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:
>
> For completeness add it.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  include/panel.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/panel.h b/include/panel.h
> index ab417bc91ed1d23aadc64e861bb721418199fb0f..6c5e2c000fc79f271876daa17=
9455f16da5bc3af 100644
> --- a/include/panel.h
> +++ b/include/panel.h
> @@ -29,7 +29,7 @@ struct panel_ops {
>          * get_timings() - Get display timings from panel.
>          *
>          * @dev:        Panel device containing the display timings
> -        * @tim:        Place to put timings
> +        * @timining:   Pointer to the timing for storing

There is a typo here: @timing
