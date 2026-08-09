Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EECC5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 003BD80C50;
	Sun,  9 Aug 2026 00:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O43P5l92WhBN; Sun,  9 Aug 2026 00:34:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 318FF80D88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235661;
	bh=+YAD5Km/LmnjX6ngonC+BU6WkfKmdLXDUwe81PxguS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Wi5uL5qraNza14xX6nRdJkLPcOg6TQLlMFkZNfP9Z+/XU9pxa05HRoDgISen7c2c
	 q/P+ykctyK368GSRM667pFgK6mg5rRBu2NqHL4ljZ9w/byoQSQvEaPmpY46JOok7se
	 fCjYPDogKX2OB+xQU0hEUNX8qa4ioVKbHCvHfVfxDtIqQyb3RHUl5K5Ro04NSeKBt/
	 OTAUYJKIQFKH6eKOWZkFCMX75KKFcBurDka9JeqGSLGAT2VROFWr6kzVAV+DRmBt5L
	 az8LxrwQUIydac0MTwComm6qiPCPs6UVybCKK2+/gO/NdsYaw3l25S7kgQkkliLD5d
	 r3XTZrX+cGq4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 318FF80D88;
	Sun,  9 Aug 2026 00:34:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 861A510E
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83D2680C97
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xS1aU3knHppI for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:34:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EA59080D6F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA59080D6F
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA59080D6F
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:17 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so626072a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235656; cv=none;
 d=google.com; s=arc-20260327;
 b=J4N2PWyFkQ84+ZpRSvzMoAKsJgEmV5+3HRQDXaRdPKQ4LJ/4qn2m2eKLD3D3d5CXsf
 vjTnis1ompvju55YdPnRzwzjRt/usQaLYvm8+lNjqQSO6W9UmJFOPUUKnHIrFJMH91yT
 X11C4TxFsWFhCUyR/Z+jxGJtEi3dx1JYLI7B25lhv3BIEFVT9l0IZdDaqdvPYzJuyO49
 mGg47sERNV12Y22zdIEoMXMQfOIJWlBR5sCPsE1VK6DebQb8D6+pdJmLzXh5fNR1dJS9
 XDR14LB4k5KlRu2IZzuTG1bv9yJ1gWSnk5X3obwJCn3q+84w+rWqiKKwJs4qp3Bu8GpV
 KVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+YAD5Km/LmnjX6ngonC+BU6WkfKmdLXDUwe81PxguS4=;
 fh=lMu/IoIlTfGI1wvkQqdTjRQJTv1loZZGdihE0p1XJi0=;
 b=qZcgZsFfQtV34c6qYfYv+4lAH8hEc0Ga9sr0+EqFPDGT5Jn5RpM/Z37f0t0L8yIiDR
 1xaVq/WMVqnHFfcoX7Eij0ltKrvrORw05llVM2xJR2gFJQEZRjC6WwPWXFNHH5eD3n6K
 vNaMGYHoJIhc/SHSkNWPu5eqxRkMP3co7VFdJsuyHkNykv5OmhicBmHvf3JItfZPTDZr
 YQ0G39DJ8qnXnoHTeszYd+i7EKuFcEsEOhaZPWI67hRQ4te1fvgMIzt47Twcl58iSxCJ
 OaVUYbBQJ0a6xJNmvRxBcTTAkWRvPJxTaWSjmI55Sg7dSUAzYUMOYvTe8oqbsHHl7tPw
 WIJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235656; x=1786840456;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+YAD5Km/LmnjX6ngonC+BU6WkfKmdLXDUwe81PxguS4=;
 b=jGf/OYIPqkapHnzPhEnSfDcpIx1jzH++K89aKikKb7uDHtK2hLNTU5H+JmMzGXvPV9
 /JzBaZBBVD+qW/dg66xdC7RYBBEhDZNMFkYeaiAdQrs+obs2/3tsuMdRjkGZlPvL6q9R
 bIKxVrImQKnutMbA1MrkAoxBDg8IqWqdQ1000IYdi/trZ/W+vN+64z3AW8BqjPI1VeM5
 87VevgO6nNbKUCPi0WK0eqTwg1RC0BMgfhq3JqKuhyvazJy5GIkeY9nykGt7HL6neWGu
 4ZNcRudPVy2hy+UKNHH2qcpkNMVnrEGFZlP40BGydXYOgWgn3gvfsIXKSqHfkdJkOD84
 1QHQ==
X-Gm-Message-State: AOJu0YxWddA0gprzk0+c8fNwR8wJe5uEDqOGgw1kgOroSEr0Qa2jWs95
 20UoIA8wdtn+eQdGwJzNgjqHv6IhsEk5u8QeSCnOsg6KcjdlLjfYemwRMZ11pPn0UPH7Hctq4Ul
 8W6C74LKHywMvjzm0hzkGbBWcJAkGa6gAxyp44yMN
X-Gm-Gg: AR+sD12+ym/P1+hsadwfQ4p8IlnNWagnnV+1Vqb5AK5e31idVm5uQw+c2vKzv83DR1U
 JO9U/3BmH7F2TQcAtjPHxy39YR7ZRvgsWYnr7yLNgC0cyBN+Qb8Xv26xQ2+7cs+mFUWwWJHNo/o
 ijyuSMDS79D43qSRgTRsFsl5Js6PxBThWXSr6cRdLZg1kTan+EzoQI1zkW6S62/AO/POfAZpgk0
 3fXBuFyCjArVwvDZoX4ebqrOb8fNj/7+DOSxDSMuDUb4GcyaFsmvrAIb4RFcXobLq3MtIYz62jp
 JVws+IlHeHuaVGgIUu/NFRRs/aGPSDBEdQRRq5qNiKw=
X-Received: by 2002:aa7:d514:0:b0:6a1:2400:baea with SMTP id
 4fb4d7f45d1cf-6a1b4b6e105mr6780897a12.10.1786235655886; Sat, 08 Aug 2026
 17:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <20260728-ccaione-upstream-ebbr-v2-1-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-1-4efb529140d6@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:34:00 -0600
X-Gm-Features: AUfX_mzYbv6ovea87LbzegNWRYUYFjaXMWoCpy1UqTQL05nLUvNMOrp6bmVH6hg
Message-ID: <CAFLszTiLNnSy7hEFesuL0DiMRSpZcm73by_889sBnFrrKaKmHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] efi_loader: bootmgr: preserve a passed devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235656; x=1786840456;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+YAD5Km/LmnjX6ngonC+BU6WkfKmdLXDUwe81PxguS4=;
 b=dZy4WQBRF/45iIatdjzz1R2+vhKyZtkXBdOTaxKUPGKmcr0g7HdSxsUMwUKSDMxJar
 zAEJ5dMw0Rt/dze/RqfkNpNZ03OGtD8/8J/FG2VKZI1goIUr6lYd0Y0I4fdtNeT5hAmQ
 gJ2hmNVBBMFcC82filkNkEa770H5uok3kAt4w=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dZy4WQBR
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

On 2026-07-28T13:20:42, Carlo Caione <ccaione@baylibre.com> wrote:
> efi_loader: bootmgr: preserve a passed devicetree
>
> An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
> the FDT referenced by the selected Boot#### load option. This makes an
> operator-supplied devicetree ineffective whenever the boot option carries
> one.
>
> Only consult the load-option FDT when no FDT was passed. Document the
> resulting precedence so the explicit call argument remains the
> highest-priority source.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/efi_loader/efi_bootmgr.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
