Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8884CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD18483FEC;
	Mon, 11 May 2026 20:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="byPEbvKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AC883E81; Mon, 11 May 2026 20:10:58 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8757F83F14
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd24f466598so16344466b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778523056; cv=none;
 d=google.com; s=arc-20240605;
 b=Og5q05RswkEVk5XxmhoKh/DWjkHfTHFVal0b3+WrWcE23hdzxuuH5gZdpyLppkbBf4
 IQb0gy0tdsrBopfgFyN7b4QtCdlAMGwYzqmxBNvjWRU6RPbkjjJBowHxbnGfm2S6t21d
 1Obn2c83oZWY6kDLGE7u+lRrPFa+/JltAJiDjw9/ynehUHptv1lyvNH7d8GtNz7g3jlS
 Fz3lWC8EUikziAz9LpHqYo1fgBwUtjW+k9uQhE9w/K9c4Rhx6+zGG7URiYRlv2TdB1Jq
 bCoZmDHu+OL8D2jRaE26g9tAcCMd4NOqZ0l1VG3Qr6fjdptBHyywC4DLaX85QxRlEC0r
 Oi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vBt+cru+fyMMLXzPhhOldx3hK9KFcevTsBhx8mglMyo=;
 fh=lGcrtbD1PYLpLqC4pPnBjjQEkdTG8hK8idShVSln8L4=;
 b=BHtS8XHjeSyuI16QeHxfiL3yU5edCkKDGIb19PgIyLpA0oCnPQFqfM8xuy94NKcRMb
 C5kakoHMirikq948VhAJYeHBePITyYKoQDt+ynNooIW56yi2uEbt0YGQuKx+q0hs8PO9
 qVd6+501vLHH/evjJsxG2luLkZl/U3NhCs+hdNnSs2D5gSC9vkcuFJmVBU2DghBhZWRO
 bKNqYH+yEbqOoX/Zr1+LV2KJSvCSN7bWeLdNxD6JE0podV9cB78SjtcCnh/AYBLmT1sa
 Ftb30E+3ZPJvwo9TiSNT3O+MkmxJvphc2QTyTrDQqncUjlQxJkBHoQkqEiIl4K6OdW11
 hrWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778523056; x=1779127856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vBt+cru+fyMMLXzPhhOldx3hK9KFcevTsBhx8mglMyo=;
 b=byPEbvKnszZBc5S4D90Uh/Lgo8s4/39VTluWhT9o2d8s3ZqW3Ouqw8cUTAk8pq5ix/
 VFR/e4d0tbdaWftjroqsL4+KeyFxqIVbos0Bn/ZLPgpZdaM+9x501Q9MGmu3JqRIgtKi
 wMl/YwtWGgtotLtxaEQB4M22GRssk21tuW+VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523056; x=1779127856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBt+cru+fyMMLXzPhhOldx3hK9KFcevTsBhx8mglMyo=;
 b=fzA5u+2nA8p8OzyteKAfI1Rh+W4QGF5IGarl3VkJb1bByelJQorMuIESMb6TqATvV0
 F5wDoaKXUCDiRWMg/h6o2xDoxjX3hX2ONz79Oscywo2+9JM11KVr+HQ7sOJTiyTWcyLf
 92/EISHfq5svvf0S+u5i4NhhYxmmK3m9rUBOwZrm6il6uAuxgor4eK4njH7VlbBZhpe6
 2ym2lnHjq/MB7S3Hm/wpQZI+Z044lnywDehYza0Qnfv+Srblzxac2YE4zOZ8x/sYPbkP
 CV/Ckyz9SCzXT4Xd/wcljXGYbJeA8V/BCfYNvp3FU6Nuyl3mN9UEWm64EJGGOVOu6aNU
 kiEg==
X-Gm-Message-State: AOJu0YzNGIU1nsZjIkaT3+D+x1z9xvQxrA1XEcq3YzJTLSTIdG7HDgWJ
 t0/gzu6KLyTZsfkDt9ZcNolECt1I9EUT9L5SVOlobd/EsYEb9UH//ucmujMx5QjNz6OcSAFLVQ1
 jv9t1ssgOroLAiZ1vXbg9aokv3mhxRL17faotBJne
X-Gm-Gg: Acq92OFFvRs5dUiLBKxcQ4HY0uSjFJtasVeEYHH8xsxZSvx9eFzbDoPdfeXbPsEHMcT
 61oJowhuEnDd+ZeyLgtoUu1LOJDWIQp4XiJQvaAl1CxPFYPPU0wM0Lc19dryNutPaooeK85wpf3
 HwCx480Ent9OabZwjv5pvEwmZOI8D2tpbcY86xud6IZwpsNrHal9AIlnHQcc5NoN3kVfQecVGcC
 o1/QalRraHcbp8CxM2frBvy1zBAFaky0fWlswrXp/SRnnwKhcUvaxCRoJNPwmDRg1i7gin3Pjm4
 L9G1Iw==
X-Received: by 2002:a17:907:6d2a:b0:bcb:b88c:eb3f with SMTP id
 a640c23a62f3a-bcc13c96a1fmr575530066b.22.1778523055937; Mon, 11 May 2026
 11:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
 <20260507164225.59325-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164225.59325-3-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:10:40 -0600
X-Gm-Features: AVHnY4IWAWdPuKGkhhAzLYZYA-lZG7ArFLLlAgRJzZC6pAKo4N5758ay_SqjxoY
Message-ID: <CAFLszTiBtfSbaR_W3cYUAOZ1_4rA0pnZ2pw-oyxG3kHw4=mPoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ata: sata_mv: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
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

On 2026-05-07T16:42:06, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> ata: sata_mv: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
>
> drivers/ata/sata_mv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
