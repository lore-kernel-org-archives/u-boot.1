Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51939F46122
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C742584148;
	Mon, 23 Mar 2026 15:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="Gec7DXJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F187C8416F; Mon, 23 Mar 2026 15:03:09 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F438408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79853c0f5b9so23445727b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774274586; cv=none;
 d=google.com; s=arc-20240605;
 b=Z7VDxEm9HMeb0Zce5304wkTZlRegMeMxqjykD1rljur/Z0sOMPREMHpwEaHux83uKd
 0U8tJdhkw98hysikEU36jhLdGEL7OuaKP5UVGzBDKR+s6EeO3pMB9ug00X9b6bvVZfCp
 R8zafoyeo3gmOvwz1OzxX7Gs0fM60gWrEetirdvI35H+aLHpdSqPJ54EY3u/JO+miP40
 qQJyKKb6rqchBFJhhDHsMZUhQiN2XevMy2hDKpwJ687SGlYlNkxYo4zyOjz2tPA33K0K
 67Lg0dbzkfGlsydaR1uWpghQpDMgqwzV/4uXdCpBzbkAEmLjZvOET4aDbuuI80UnrsF6
 oc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3xHFyldq0w9NLc3JFImHj0ZiKD8jOgtMC8eeSfyFb6k=;
 fh=0RofvVD5ScPUZKyHkrBmUJ3VMwn7/P5q7i+NnZPJJpA=;
 b=JdZga7C6Qwq0sCPbVy7TRLPcKRYiu87K4E/ryoUbJ0nZAit4GqiSD3ILy6oA5zfYcm
 0uWM/00Amcu1jQBJJfSg3vLb+YIUVaT9TugLixpyTyYpyCMH+EIwiav66YhlIq21xF1c
 lNw6ijZRShfjdQgzf98G2jh9MmD6IYLt50Lo1R8sT1TyRX1bVl79UqePOHpHHiDAbcgP
 qOLYeQvIqP5gN02gywIAaRoANtTaimWqc9RQDG8SRZBo54H3nQ0DMAsAWbDimmz1LIOc
 v4DPja+uZ7G6TrD2sjjp3vi+U2r0sfuROtW2C/fOauaXjzBEeuASfdYHdZFvBWO9Uws5
 t6tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1774274586; x=1774879386;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xHFyldq0w9NLc3JFImHj0ZiKD8jOgtMC8eeSfyFb6k=;
 b=Gec7DXJl//vtF6p/SEXtr0xutUP0P4gE93sktCG/1RJzU5jY1aITq5u18iKpYXB8ql
 GjVsHj+wo03UovNFBiBJ2AQ7O1efABchD0Ln9KXDL1aRz/uh8dM+Mktf9pJOtvPVsi0B
 rXAdB3EL1y3uWdUsPD8HQCIBLS47z1p0j2LRFdCdkDDQfbe/aWH2YIjqJuWzTQpVCRCv
 Tf+mL67fOztNOUBsQsnLMhkQUb0f/cQkfPpz9Xa5YjakKVPJl0Y1r9ycVCVp77SZqLpp
 MCkdd/zsqdQHOCS24Vgs3Qr7dTrIc+bX3DcpHAtXrMU9YWBdf7qIV4U2WYmDvzy7MSQi
 tLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774274586; x=1774879386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3xHFyldq0w9NLc3JFImHj0ZiKD8jOgtMC8eeSfyFb6k=;
 b=mvJA/ugRv8FBoypT6nu3dUmu9w0Fs+Ek50jLGmDzA7oLCB2sAhLwzywhssb4icZjOw
 wNVKQz0sswXbwNGDSQ4EzZct4oEEJHv5t6kDG6BhF39vSPtup81ElP80zZ2rIAk+cICI
 y5SlvIavBUgZrDHD+fISG4HryZmK2pqcvkzcM1uR5d2prjW2K4pkqA2D+mDLaWv6I+w6
 RaeiyJgneWqMLkkInwBzd6BJ7DS0uHZcpxcI74voQFGpMb/ROQoqYUkFrvt4oAttsf8S
 dm1oqSSG4raepv4N8ELyrEafgquDFj/HbRpeQ42IKav+IdWXD38E0cz2igkH19tuYNfr
 +lmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXybENo0p0ejaYw2jSdFtvAfZrbHNUfbTFVms+mNojdfSabYMJUbZ5Rwz9PI2q+UuFIMYMj3gg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyweqlk1RiTMGloGhbtQFGPHkrfEffQ8hfc3KH9+YowWowFwSr7
 8d87N2y+o4eM2+qP3Kd/FzUl1FWIjpsnyOi7obZTASNVu6mRFO7XIWA16V75HXPuhjZgOdJpdks
 nYIPiujgTYgIcPlqZPHNaoHq1kKI2SzpDDm/TVnEh
X-Gm-Gg: ATEYQzxwKZt+TeAnsRiy7ZJlZ+X1uOVcw428HHnPupkAWjRs0+dRsH0eTOUxm26cFhr
 ShWZOL0rufY5CTe1Q+i8ObM0Px79+PFN+XTnTocuIn1uSIXAz1ddpwNsGCih0UXkuYleL9DrJ8l
 55K8xdyGS+jK/ElCbXtnD8xIjQuDBWI/9BOyiNPVr17OnyFdGiYcqpzdTadHoIo5X6o9JZgy21l
 6BmUlvoqYHHc+Yjcsf+to/WoGHAuNcpM9pRxxokt20O4opdFi993x7JV14moSg0ULSD2cyQzBUl
 48sGBUQ1
X-Received: by 2002:a05:690c:d8e:b0:79a:bde3:703a with SMTP id
 00721157ae682-79abde38a1dmr15265377b3.0.1774274586336; Mon, 23 Mar 2026
 07:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260225063559.47481-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225063559.47481-1-heinrich.schuchardt@canonical.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 23 Mar 2026 15:02:55 +0100
X-Gm-Features: AaiRm50uda5x-rOZD6SGQ5MpQzBgaV1LOhUedgSCkB3Sr76q3zWut-EGbvQV2lQ
Message-ID: <CAHTX3dKh0w2HsNdAhhX31F=epeoF7sjBs5+TXkMr083B7u5R5Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] board/BuR/zynq: don't select non-existent
 SPL_BINMAN_FDT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 u-boot@lists.denx.de
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

st 25. 2. 2026 v 7:36 odes=C3=ADlatel Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> napsal:
>
> Symbol CONFIG_SPL_BINMAN_FDT does not exist.
> Don't select it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/BuR/zynq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/board/BuR/zynq/Kconfig b/board/BuR/zynq/Kconfig
> index b450a21bd98..c7010fb26b3 100644
> --- a/board/BuR/zynq/Kconfig
> +++ b/board/BuR/zynq/Kconfig
> @@ -7,7 +7,6 @@ config TARGET_ZYNQ_BR
>         bool "Support BR Zynq builds"
>         depends on SYS_VENDOR =3D "BuR"
>         select BINMAN
> -       select SPL_BINMAN_FDT
>
>  endif
>
> --
> 2.51.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
