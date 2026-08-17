Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E10EC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 20:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAC636089D;
	Mon, 17 Aug 2026 20:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cGmrqhOYaQsn; Mon, 17 Aug 2026 20:04:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B501160889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786997096;
	bh=aX9yHpmcKDD8Ql9S/6WWsjNQLM7Coh4GLdDHrLsIUgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O8vCAPhADEUWmCACfVkC/CG/uO1oLJDRGV6HndD1ksHzOg5ndNnRToEHmLUyYgXnA
	 SdyUgWmO4oS2gcLHflFb2e2hR9zsMVg07BhmFtKQCKOsrFjtAf88SArrevOiCg2VzG
	 zKksXuVOX1oZjP9QY/rVE5ejXatSgF95nZYCpLDuezC+dvh2LS3y0w+ZaKsWFntUkh
	 MehBfz3IVVDB15GSfjsryhLVJNbU3lfGvT5mOQQuuF1qF7VniFRVG0TSHSv76OVJa5
	 8zT8WqmH18bAComT/Eyl6FYRYMS2LKOZEFI8HuHOtF6BxN8ST+4HS64pvDg9Xotnmw
	 TfM00VldUGEpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B501160889;
	Mon, 17 Aug 2026 20:04:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 85D592EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77A788113E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:04:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cDo-SfTTb-dS for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 20:04:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A70768112F
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A70768112F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=em18Kp2P
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A70768112F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:04:54 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39c95395230so33971231fa.2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 13:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997092; cv=none;
 d=google.com; s=arc-20260327;
 b=NBb/+pGQ/LF2dpsfxIX9C5/Ad1jyHvXZRv0zeqggrWymXJC4Cb9/I0ThgYDBhWzCWk
 K5LWiN9n1xn08kCxcRPJMxog3L0vEpsB2ACqHrKSqGOxnsfs0NxX6lYOFuFF+ttk+UMe
 Pn0Cec11aVWQWKn7C46c9rBon6LHKWhNy14/t/rJ087jKaTnd91r66T/3VA4nUCjoSMv
 0sqWq8FiTpepD1e3r9cjx5ycMG8GS7w0l2VF44+HBsX271NhveWXNBF/C5vbA31LQrTk
 jDKVHqObSPEFOlAHbTRxYNVVJD5vUqdfiXCYEYb5ra7lEyuvwTxszq/VAcbxHho+4HLc
 rK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aX9yHpmcKDD8Ql9S/6WWsjNQLM7Coh4GLdDHrLsIUgA=;
 fh=m+9UsMM396cfnns2HdnU8pgOP8Z1VoAleRFoW4oLJmo=;
 b=B91XTooZbotuyBcEeLNs2D6IAYcxXOXBloicYeVsDyiEswnIkDE/htKIpwS9EGiUTr
 dKh2xRYusgLGdi9zcFYidgiErSremuFRLHEVz1kkz7fzkNEtab+Wq0kcLeaUOcdY/Psp
 /32r5KyC8aMRbBYGiSdmYkJFwYOKJVLS050wyw6+mAKra/xufx4e8kMppHpCW6xrvqfo
 2cKclhY972fZ+/C6KXUgIkreL/DDBFIB8mcdNpDEBFf+/JOea058doxY2gW/rm7ZySB9
 KHbWxmukYTHrZvEVcoOXoR4FlZSs5hgk+bTJiM4N6/lVZ5bbxlM9arhvEr8Tn+x93YHB
 C62A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786997092; x=1787601892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aX9yHpmcKDD8Ql9S/6WWsjNQLM7Coh4GLdDHrLsIUgA=;
 b=em18Kp2PKN20ubpHViTUhkecVGynu8Wg2auDv3JEaCU82T4GNqOQRiJZ/2UEQV8GiU
 Yl6g6b8v8sKlT5P18hRo1N4INnQ5NSpm710stKR9g3Z1KDE+Kw6aOlF0hr1RxETKULkf
 qHWym5V5SjjDaTWFQvJvTXSjKjKan1hWqVCUAFHql+mOoVpHo0qzmjpJYidx4ka7bqXy
 xOQa6NXRnduLK9e7pl6NF4jGGv2K5gXWZSY4bq+UH07YAXsh1RpISvjjg/FxHBavv9EP
 v3IahUVa1gxwjHuWQOAgSV2HSpMwzL28cQ/pvdrsnKYPB9J7NCqtOIefxZ6sKRTOuA0A
 fuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786997092; x=1787601892;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aX9yHpmcKDD8Ql9S/6WWsjNQLM7Coh4GLdDHrLsIUgA=;
 b=kX0GLkP/EI+VYU3/6qlyqakG8mHr4nJQT6ON++9Nrp7EcyXbj1rKQBXzS6Uum6j+Sz
 BGXWoQ/S8iDp5OEV7Ucp8yaI2KZyf512FCmBZpkaMqq2sZD9Yf4B9rbMDCqQ61tSFrEy
 jbgX0vBsuEm+fXKQTDTY7PS21G45u1cqdmyAxKPnop7HZli3rEVFEZsbuDd2seH8THx+
 +VoLLCtQAgZ5INcPyTJewZdPNWnpHHi99t9PJ6kYuKyf7Qohc4oh95974KHlS46Abd5u
 ItkZcIu2uMtIorDVVI3O8aRg5nPPVsjSq7LKH9nPSd5mOqQfuTF8HsZIwv+zSH7zJlaD
 QaXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoANvQkA9FeGHDTZV9R1PfQkCmleRCY/v2Xi9ln/ReiKyMr5FopB2PVHiojx63STIsINWqPxKw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyiFD+2zLKcQguRQx3jtN1dZyLUkXOHGuPAnYj2HYWCsNpWrfoN
 mnsHqzt+uJuTwdohpPanFYJKDnMPVPAkceB+QztPiU+cKm6mKCkJl6+nTvFuDUuVazHAhiwfCqD
 cDs9ziVWKDbEEGIXmNpPew385bpsxHSg=
X-Gm-Gg: AR+sD13H3isQLnR0rYx3r0jT7wNdlhR/F+KiPZhAKh2sc/EYX1QZtz8t27bAP0kJ4VZ
 TRFCfCfd5bCJJVSnvnM1eJ3jOZ+W6DLx8Ouoa+WA4lBIIpRw3++zAkrEUw6lQQv9MTsjneF4m5r
 0sNF7NPbnirJC1KufYiC+n6EwRwqgDVaHFpO3uCmOzjioCvrgTqcNUu798TmcpRn0Ox/8AFaTJw
 R0nPa0Fjlup1Sz0mDpoyW7tFMrGqfp3Nuo5rbSjFYnVKvqibyhd1Zoa2VQgYV+evWItizpwh/eG
 Al04iw9UiO5sD0I45ZC9wTsXmumz3pxQxeGkWh3o3iU5R6VBkNHno5aCdpXPHfTR92TOx9wPTqL
 VR5xccUSlzoDskY1YeZTQkC45HXBpzQQ8Bg==
X-Received: by 2002:a05:651c:b13:b0:3a1:277a:c2a2 with SMTP id
 38308e7fff4ca-3a1324b3d1cmr22471091fa.21.1786997092002; Mon, 17 Aug 2026
 13:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260817134559.GB10907@carbon.k.g>
In-Reply-To: <20260817134559.GB10907@carbon.k.g>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Aug 2026 17:04:39 -0300
X-Gm-Features: AcwNN1U85q_eNhktq3ABKMo6YaMV24ZXuhPaWwcL8qg4_ln_axAJBnSAdSdD-R8
Message-ID: <CAOMZO5BDTBrM-FHoH4WkSHj0qGFUKzPX1tkqymvMJB5EHd6p7w@mail.gmail.com>
Subject: Re: prep work for submitting Draeger imx6-ralated patches
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 sbabic@nabladev.com, uboot-imx@nxp.com, ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Petko,

On Mon, Aug 17, 2026 at 10:46=E2=80=AFAM Petko Manolov
<petko.manolov@konsulko.com> wrote:
>
>         Hello guys,
>
> I am tasked with submitting the patches Draeger (Dr=C3=A4ger) applied to =
u-boot for
> their imx6-based product line.  I've already spoken to Tom Rini about how=
 to
> approach the upstreaming them, but would like to get your opinion as imx6
> maintainers.
....

>  arch/arm/Kconfig                                   |     1 +
>  arch/arm/dts/Makefile                              |     5 +-
>  arch/arm/dts/imx6dl-draeger-m48.dts                |    23 +
>  arch/arm/dts/imx6q-draeger-m48.dts                 |    23 +
>  arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi       |    20 +
>  arch/arm/dts/imx6qdl-draeger-m48.dtsi              |   354 +
>  arch/arm/dts/imx6qp-draeger-m48.dts                |    87 +

I suggest you start by upstreaming the DTS files.

Then try to add minimal U-Boot support for the board that allows booting Li=
nux.
