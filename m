Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBACC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 11:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380E98484C;
	Thu,  2 Jul 2026 13:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kYLQI1Q7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1488490A; Thu,  2 Jul 2026 13:14:21 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986E1843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 13:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so3389207a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 04:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782990859; cv=none;
 d=google.com; s=arc-20260327;
 b=Yeu2l6u6sbdIyWfaBtXFINkva7gkNhl49ew7kZzyL+PWZw2Msiq9agr524Vu/aLb9k
 BP/Ha62baXxjdVyaePeVZRxUR/F5CblOF+EokTHUXlU675ARzKtQJTkHSSkY7xkpjGQE
 b5ioEkX4KiJSiS958zF2jRFL8ftuddL0pT9VbzySaTKGKEIdb1ROLwxk/Y3ZnaH6NNvR
 kfsGlyr4yFKQWiS450fhMq9UvJ7OrvQFkfxbCLIP1VHVdJKP8GRxIkSyQ4dwnkV6iJ+m
 tPnRQADIblXQUDo4qMv8u8bp+N+gmJ03D3cOLyIvDo2uDAqgKetVny7+WCn6Re05+BZf
 lPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ODWOGtgWaVoOy0LxVnghQj6cXQ68Q6UK/g0sH/eRei8=;
 fh=Xp5J/VfCD0qkvaCCCQEkAYzbOL7azc4qfGk27KxUsjo=;
 b=hdV5HPqBE93xO7FXY4UTwUUO35Uu1sU0MyzBHVE5ZvUvkR3fLidM9ruKE8NN71pP2q
 TzR02i4T59kxuEyD19s0yprC1XS3/p4bPOYhq8NqTxiORtknKVjnc6bdHfFsNY6JeMz1
 mu4cdKGL1W6llSkuByIpoIV3N4Xx3krF4kwWnmzH8TY3EodQb6xei/5Vq4vr+qN3ObWl
 8/TzGeOxRZ58l1tQkptxAWR0pf3tIV5rWGGVGCk/YwzD8pzx79M4vKzQWN7KPsxFvgMV
 JHgenRXn5qQ+l60blvSC8RSVVCL+5U72C9kSWG0Ow2PGmzgjYdzbSfc48cDQh4fXH/UZ
 Bong==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782990859; x=1783595659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ODWOGtgWaVoOy0LxVnghQj6cXQ68Q6UK/g0sH/eRei8=;
 b=kYLQI1Q7bOMe+3kWcK1Pzf0PG3LZreEkYIO76I1dyGtjt85eAI7iOuCDAdXzpW1PV5
 fS/BsfDxSC4BsBuPhRWoGa+9VrnytlNeZ34KfctRH2pkoXxbPEoiHYrknTphq7frAoLJ
 m14lB4zaBRcCGnl1G8YTS5rThPo2fVFaqAT0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782990859; x=1783595659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODWOGtgWaVoOy0LxVnghQj6cXQ68Q6UK/g0sH/eRei8=;
 b=IJz9+JGLILf3Wi0Cpz9mvKLaF41Sg+z8qeX8HNVzdjrHzDJbf3HFMwSgx/mlEsnjxf
 emp2R0u6eLyNqqL6r09D8OkcZksbXQB61Ux8VukPvd71extXNiJ14RGPusQlT4GLjIwp
 nqIryHiQL5E1D0LhB9ms2mbSM4BfwBRkunlOFFUHlICcoUv/mB2Q/yzT7Au66mvrm6JL
 uhNnEM7di928S5XtkEcdnXHNJ+2Hsen/rm8yu2Bt0R9mRoaoWouu8Td1WyanFDdZzjjk
 vqFxcdxzznltRM3gOCLLNgNJNb1VUWpLxw3hG4tb45qmRb326hcvOYpGzEPpZ5FDGADo
 ylOA==
X-Gm-Message-State: AOJu0Yy+W3U03kYRzIBWQSILHrYNAJhAbaogCZ0enJH5hMKaZYda8Hy1
 BN/DXSWLj6XWv/Se02CH5KGJLTeeq1513HlZv0Z4WaDD0w1uVtaVqH2xCRLprh+K3cQ3HpFTxWd
 MeJlQ9nWP+Mu78R0cY6XYZMjGmpjJZaBrU5icb42D
X-Gm-Gg: AfdE7cnQR+k5FvKtkJqAaGWShLdNcQyw4jOj396Axm62TezOaIOWbZQ6Q9ZDkmKOQiM
 uzVrSVgSWbz0zHfZ0Foa3YILW3h8w2G58DSmoXFzua34RN/eEgat9WWn22fyd2yvdWyFJNvCF4y
 C2s0O14FHr1MdZHNBtoD/WsxwUqtyOlyt+LJPjSgncz1U0oae/PdNiYmvp7UMxA1uNLn7r6GmnF
 7r/R6A8s8BEp6qcy6boCvDxC+wtoIIVu7eWe89FZUsqcg8D0cxWVzq6uaEOfWl36HKojdQk5tDN
 rmD94oae
X-Received: by 2002:a05:6402:b2d:b0:697:6463:8328 with SMTP id
 4fb4d7f45d1cf-698a2c6d7fbmr1549537a12.12.1782990859161; Thu, 02 Jul 2026
 04:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260630084112.13259-1-marex@nabladev.com>
 <20260630084112.13259-2-marex@nabladev.com>
In-Reply-To: <20260630084112.13259-2-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 12:14:01 +0100
X-Gm-Features: AVVi8CcWH3oP-xUzndcBfnTTX94XTyadiVhJlvTPqyGfz-iWgpmQSnedd1K0SB8
Message-ID: <CAFLszTgb-7ZNAQMT4aCa-NymQEx-z5o8T4Bx+YwFAHMnPJB5NQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mm: Drop nxp,fspi-header-filename
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
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

On 2026-06-30T08:40:46, Marek Vasut <marex@nabladev.com> wrote:
> arm64: dts: imx8mm: Drop nxp,fspi-header-filename
>
> The FSPI header is now generated purely using binman, drop no longer
> supported nxp,fspi-header-filename property.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
>
> arch/arm/dts/imx8mm-u-boot.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
