Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B094CCDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 09:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05951849D2;
	Tue, 23 Jun 2026 11:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Obzcu76W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E0A849EA; Tue, 23 Jun 2026 11:18:12 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA45D849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 11:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662bb8b1f93so5254809d50.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 02:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782206288; cv=none;
 d=google.com; s=arc-20240605;
 b=Q0/KMbjB4t8yu4zHZhXtqO2ZYHB6oN2pr+3l7FgZaEW2QMShrERIyUqJrmPNHiiwPo
 RXZ4q5cleMf//3AGRjl6a0MJ8oCwnUPeLZByy6NvFqxxb8cvwrdESinR5kPJcaWDSt/G
 9XcVxs5tjrpxuXKzEUU005ztLz4BKLlHBBJi6aAgVEx46pPkFlZ4m9h3n5YRJvIf9fKr
 fXV+GxeUpcD/yynsFZRO5PkDa42rVnmkiRwcp4Sn2ArfZa68FrrBCSKv7zhWpbTzUJxv
 QYaNn84AfO9AA0l4Cx9vOzGIYnxkEMTBNDhCj3X/7U+RDJ92CR8gGwcdlGZlnJ1GlxwC
 b+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zAC9XuRF2keGBCjm+9HQ7SZhUR6fvRwb489dpa4BKvY=;
 fh=RyaKFF9UHyhqBXx+cWLtjLpPfKgVh1jV96r0KBeD/jo=;
 b=OhMUZspECKVk6hesldFvvKFiZiUtXWcvzEUd8qp+lgrrq8z9h6Yiu/KaLJ3frNfE80
 uZyY/QCsF0y6wbvORUaRMdfigtU5Mu1VnqQ4l9R0724hFd6EBY/LsqFrvUxu09cvAt0G
 B/3XovPN3rsgnvpS748fWKmF6DMzmnBjnmelB1ycSoH1XP4MC6nWdHIUlR43ofujr/ye
 WnhkxajRy6Kg4GH6tSwqa8AZKxkzqVppfmfjegwXZY7fWXLrqB4qCVvO0HvHeQ+W+WuL
 H7fBoQac3dBG6FyQ/QlqnCNyhaRFb+BJOz8uLTkh6CxAu39rkh7Wb4vrTAtcApeKaj3N
 HJeA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782206288; x=1782811088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zAC9XuRF2keGBCjm+9HQ7SZhUR6fvRwb489dpa4BKvY=;
 b=Obzcu76WzrqWR/QRwA/1wur9lJ2uQQPMWJ1HPngrwAHUbm8ZRz+iWB4ZtscCKhHWPB
 uJOxGj79wi1c8DUExtPf5SmiwWxQZpfu8q0Qoq9zQE6vBqV7nlPwbScMVOY08L80hUWt
 nFECabLSbuVFEd1baFQtM6jHw7K3rLuPAbYjMpnCJfOQyw0KYDT8T+oizBLT7BlLPY1X
 pCbecPsFZkvUE3xNRYzHYhRetA0sHJBNCTJGuzl4okH/BMwP3XDBQsKQSU3eLwbtepFy
 XHpBuET4qBqSjBk9I3YqoARD/lPHgRt0KxQeJowfwBnlrR0/JsUJfO9ba7L25LOgyX0p
 mFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782206288; x=1782811088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAC9XuRF2keGBCjm+9HQ7SZhUR6fvRwb489dpa4BKvY=;
 b=Cc/l7HkGfDQ9tpFcHqTd3qp0sDzj0eCWprUKM9uNy7KXac23LeZ8udrsvgcsrIQ5DV
 z07qc977mqYtK3T6LBOzumoA5D/q5q7HqeLkJhzb/sfWl7YbQA0rMm1lbNBnwaL6237I
 IrMjJ/U2EDAfXuavntyLX7jRP+r8ZCS23XFB+SmNXi2GkQBk4RdZfAFHK3S9fhKafGhc
 KkuPzRAMQ6KNBtt17UHk7mZldOlB/T/IycQjFEPpaVpoUh+62Fp8tPGWVy6uassgOsP3
 smUJsJxKbHkQzW179hLnhU/pxDyHl2GawMGBz3dptqzqA4PJzegHEZbzMYzeaI1ThvWE
 5Xyg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp75v7QFGRyngi0Zf+DBWVBUKQxbn/TgqAhF6Z8HmAP0AM1Nx3+5jp+qurfpcNwZbJZfEFNLQQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg9yJ/gslxwC9qGT+RfgQ3g89jvkScjeIViwruBdHNMkLAwO3c
 V/5n1YFAIu0m880Wo13qwwKcFYmwKJHwYqMSY5tDQswo+vLzo/SShLpnprm4J5vr8+VFcnch1y9
 XVsf9IFtvJ85heEpI747GRnubSUGVh+CgYMfOrJuGxw==
X-Gm-Gg: AfdE7cltVgTUantac/rdoKkil34X04lXehlKzL0qIGt2hi9W0DP0Uc23uT6GuloxhnB
 gHrxBrdMK3j8eKRqn0m/qRmtkbZMScIxphcXOl81YnfxtiA5GV3YW0J38gmy2pVGvcU7G7hf3XM
 AQuPiEEaJfOeXlMV9V0nB0uLlLbjs1TVWP2V8JRd0PWNdE5wiiLpNHeZW8TZEhjoJSEg+C6GjUE
 MvC4i7DFzgy/WyrVbvGyN7FouwoTquofAdGibxhqw5n2llCRkpEVNCHqipUWndCfjtii0ECaTT0
 U7UGSF8fSjX5FAIup9C6RQMnSpTbB29xUFL9CwXB0Wh29v0oyYOb45mM37IWfjp98nTQwEVLCYg
 Bb91baXZz7rXhdgvDGsc8IgZnpfMRudOpqmNHMIZoV832k+VEl3VUdpFDYRG9WIwiG7sqA0B7bd
 PAtC+O+97ZlCAHR1XlhUyh//gCSs0J360VoYLtFAIH2W43NI8OoEgWXX0xMpB2u3XDw8dPQHHfj
 +LwtCD/K+mxVSBICiRFUI1xeSu/M7+zYXIVShIHoMwet1I9PtRScJk45PyCzVF2e2duyEtNFatf
 Q2ALjVAzibNHJT9umJINixzP+FpvhvYZHxv7Q4ZI2KTMdQYhpSXHLRPwmWd1+tGr/Td6b9o=
X-Received: by 2002:a05:690e:4101:b0:65c:7129:5c66 with SMTP id
 956f58d0204a3-6635a305239mr1612148d50.41.1782206288463; Tue, 23 Jun 2026
 02:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260612113144.458665-2-casey.connolly@linaro.org>
 <CAC_iWj+C0u3fos0LJCn0_KP9gCNQdh3vA_CCzOsGDgncOuZx_w@mail.gmail.com>
In-Reply-To: <CAC_iWj+C0u3fos0LJCn0_KP9gCNQdh3vA_CCzOsGDgncOuZx_w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jun 2026 12:17:30 +0300
X-Gm-Features: AVVi8CcopMCRBrQd5C6fyx-MppnfSfXyy3zhjxbR2Bjn7_QvgywUdVTNrJTZX0M
Message-ID: <CAC_iWjKNGEvj6oZ7EFkGFT35Skf7552VJb6f-EMMQGZyR3er9A@mail.gmail.com>
Subject: Re: [PATCH] armv8: mmu: don't panic when unmapping a page which isn't
 mapped
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Tue, 23 Jun 2026 at 12:07, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 12 Jun 2026 at 14:32, Casey Connolly <casey.connolly@linaro.org> wrote:
> >
> > If a caller tries to unmap a single page which is already part of an
> > unmapped block, set_one_region() will panic since there isn't a valid
> > block or table to contain the page. Detect this case explicitly and
> > return since no action needs to be taken.
> >
> > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > ---
> > Depends on my previous series which fixes unmapping regions
> >
> > https://lore.kernel.org/u-boot/20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org/
> > ---
>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> >  arch/arm/cpu/armv8/cache_v8.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 6c85022556ad..472887b5d99b 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -1003,8 +1003,13 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> >         int levelshift = level2shift(level);
> >         u64 levelsize = 1ULL << levelshift;
> >         u64 *pte = find_pte(start, level);
> >
> > +       /* Trying to unmap a region which is part of an already unmapped block, nothing to do */
> > +       if (pte_type(pte) == PTE_TYPE_FAULT && attrs == PTE_TYPE_FAULT && size < levelsize) {
> > +               return size;
> > +       }

On a second thought, you should check the size of the region as well.
What if the user starts from an unmapped region with size X but
requests to unmap a size Y with Y > X?

Thanks
/Ilias
> > +
> >         /* Can we can just modify the current level block/page? */
> >         if (is_aligned(start, size, levelsize)) {
> >                 if (attrs == PTE_TYPE_FAULT) {
> >                         if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
> > --
> > 2.53.0
> >
