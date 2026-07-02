Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7881C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDE384D02;
	Thu,  2 Jul 2026 11:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YVE70n0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A8F84CB6; Thu,  2 Jul 2026 10:12:35 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E9284C85
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so2275714a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782979953; cv=none;
 d=google.com; s=arc-20260327;
 b=LkNadlMKKHje8bGgDNh6xAVsTuaBEVWCk1ynDAkSpCj3f7nfn2je4Tz5eQQ5uk8TWZ
 qZD6s1Ir8XYLxbvw8g3Z24EGMgmjiicyYBzi3Lck0x9SSdRJ/5YTftfPF+M7IU0x61/x
 lTC4tUa6HGIm6wQUwv4gQgfNvxJlnqQGAJrwmpDNnLgIDILlWCSlGKsOvyLDr7stqIG1
 hwIE82DTWeGRjtwCuKD7LplxROM6s0KKcy8A6Yt5nGKszuI39GTgGffWV/ixtyBjXq43
 jyC4r9+NdD6zTqtC1OdQsYY62ucPW0LS3lVF8cWnb9KrWr6aI11cwLe1f+a+VpPUZINn
 DDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8IZBIMpx7RlE0oCzzay/4+1avvcBkUyksrDqiUXEBPc=;
 fh=4gcOTiEpv8ITrq6I1Q30t5cNqz1hoSEhkrzs/OOWtW4=;
 b=PZxO7G5ntURlb7uKgL5Zkq2KlpkEWz2NSEojlM62kRTpBd19BGYBvfhKro6NRIaY+o
 xsoCbQdea22IyflQ86T/0OyH4k+eFtbSa/qzcET+ETGr5qysfoB5GHrxwkiYfYS7YnoJ
 ZTYA06ayv2NHn9N9sTvFQ+EG/YWjUzHiLiG+1kEIsL2bTEkyPgZ4/PJvnWN/FI/OFW4Z
 VuBH1/F3ynM93buLhU5rMLT+2dxhApuu4zScru/ZReUXdTUiOTJbbZC7hK+VyWTuJ/26
 iLBfZqMI8PXKGsSLMD7CALCYXqp2N/FpIlfPACWcnGcyZu0fuA0OGz4lu/D2/y/PHLxa
 2b/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782979953; x=1783584753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8IZBIMpx7RlE0oCzzay/4+1avvcBkUyksrDqiUXEBPc=;
 b=YVE70n0nSGQIyv3wh5ZSvlwecDhGtk04wmDJs/RCuHtc9x/rsGJX6KTXSHkDNHLShu
 o5kzKnB8t9Jz7JAgBpIiTU4aOu3UrUyLVa73oSgVLMMJtWDLAXP4NZHFLeffBuEjD5PV
 PoUwNtjz0yjWMuWA8+a4SfRCeh7kumtA0+aPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782979953; x=1783584753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IZBIMpx7RlE0oCzzay/4+1avvcBkUyksrDqiUXEBPc=;
 b=TFB+u+pkS2tNlXR7lyROcwTRj8eiJUbqcoMwPjVngr+hnnWF8ZAog2W2nS1RtsSFq/
 6o/1ZOMX1JvD4gHdrgZQow1h1RjGvLNqgCx5blU7h9OVvy5R108VO+rqrevUll1COBDd
 RSsLRKjpezf/nHO3+/N6aljYfVl7ZKglSP3grAp5ncBYYvGhAPAFTyeUY3L/3WPgjLHB
 h1x90DoejVURrKrNv1FXMIV6dAlLl/r0yRri2E9j8FpSohCn+HiQsN4Qvffi7bFO4He0
 MmbQr+iL1NgQlq7qw3Eq+ZPyXlcbVNKV4wlJNWVQho69uaKnb4O6BsP8Y55CdDE4dWnB
 9a+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0KH5Pi9VZiX0bK/efuS+VGfpCHoT6mc8nKR92IGjDV4q6sNNp1ngI3gHaVfdnkddRqXFPycg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5ny9q+1wGckKCVnYU2Ph7+AkrOo9eAiH5d/JZTkn9DBxTZgX3
 YFz4mcJX812M/hFayZ2FefTm971x34aQDobeF72XYr1p8DaMh7uz0RZvPQ3liwIGcXxrpQJf/Zu
 zasiyMUYVUC/AJxLOjPX0QSnmlJ+a8JjgKCMg0CFv
X-Gm-Gg: AfdE7cnAED5rmKEef1CoHpNOpS0zd9c4N5VBdj3HfETeENf/KXGWWRnYJ/EEYRln0SM
 oroZeFVzbbUmEURAqp+GCRT5ub9BWtXqko0885Q3eJOEdE/cr5OuwBoG3eKJ7qvEOuAXBKFpa5g
 nRJA9bckyPdP4TEBaQTeaMTqF1Ve0oRv1+9JEq2wwZRMSQlOap+5fyf6uMOzXC0MwJqaFcGtWMf
 cXbaS1gSRAKyqVn23I28YxoEjNpeAzQKoMusxUhfQtd6Y8/Ny8DivXYfkU55yW5D1XZE8behg==
X-Received: by 2002:a05:6402:2794:b0:698:ac05:5b2f with SMTP id
 4fb4d7f45d1cf-698ac055e83mr888356a12.4.1782979952614; Thu, 02 Jul 2026
 01:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-9-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-9-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:12:17 +0100
X-Gm-Features: AVVi8CfqJBTGFBVieGepUoNieBtm-YK3Nqv_xmE6FjkkN1CeOeu88CCNVXB9F0o
Message-ID: <CAFLszTibPRo-pGAU4dkA=bbCQVD6STrXvp13ZHagrRPnXuSYSA@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] mach-snapdragon: spl: Update SMEM with boot
 details
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, marek.vasut+renesas@mailbox.org, 
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com, 
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com, n-francis@ti.com, 
 mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: spl: Update SMEM with boot details
>
> Update SMEM with the storage medium from which the system booted.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/spl.c | 73 +++++++++++++++++++++++++++++++++++++++++-
>  include/smem.h                 |  3 ++
>  2 files changed, 75 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
