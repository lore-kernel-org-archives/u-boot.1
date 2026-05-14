Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFAACD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 08:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FD080F0E;
	Thu, 14 May 2026 10:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBub0jDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B9028341A; Thu, 14 May 2026 10:41:58 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A698056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dea20cf21aso7013970a34.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 01:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778748115; cv=none;
 d=google.com; s=arc-20240605;
 b=Q56/z7u84avpuGNuD4p7TtgzwhRRdAJm8Ftg014Dns8hA6lm2V/CRGbChgibFwVaxR
 QzJlCcOmvStaW5mAKroyNtW402lAZWmGkWMLUSnWybk8W4T5TOwG46rfJzH88AXWCYSl
 29Q5U144lPo96jxBjwrOuXZIJz0DoB1eEwea7FEo/2xOsjQevet+P1379Wv2hkfo94E/
 1jDnHcE/SwUn8hNF6X+Qf5xI4shGV56j27sUmdnd2wBm+wQpTQGEhy0JVzBrXJBLf+C6
 COYHo/3G0Iaxd6n69YjOsCf2Xnn7lEwi/nmu2mp8x7zyvnynujbYP5WmruLRAUUA/slP
 bWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MkjI7Ns0gEyUpKjaRa+lieiFnMgl026znojr/fHbFiQ=;
 fh=ZzgklZcdm1tzzJg83NUV/yph4rlJAq9K42MXhIGvrGA=;
 b=coJZMr1bNW2PZpMIPcEiAEbYtjW8hDRZn30QCEGT+XQ1MIBiYKqSgIXVfroaPlxrYj
 iOaZbQvGjlv4yE5Kyv9D+yoqmi7Fpy8qMeW7YM3Qy3XJrSDnsbEXsOUmYBPjP1MI64B7
 xk5v2fi5sOuygAAb8yeRL96UKxcGYFzli/kr9xy0FPDDhJaFelbAhSmgim6y287R89hs
 VB6tvBMKxrOroKJB6zK4Xrfu2EvMbi0cnJo9dhJRoJyXsNEJF+cYdcCdcCxPmEsv/BNN
 W6YsgJ+eoFCfvkxJ7aPcDlYT29DfTAb/inlj6ombpkwUMeb6rrRapIElPbpvKuRU3AGp
 VMcQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778748115; x=1779352915; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkjI7Ns0gEyUpKjaRa+lieiFnMgl026znojr/fHbFiQ=;
 b=aBub0jDlDVoxbQzW4AW5nsRiE8QPNJ36XA4tjzfQWobS+tf+ffNhYV5sd1RYw9dvsB
 FwPLs4J3wAoN5TRF8B653jR0ioshhsSAvm9QnRk6d9mo/k9PJhFuQVno1reQxfLKN1JX
 wP36x5qWor8E8fX0jYDJXPLfVm0rPUTT+X89QN/Sp8EI5/9e4yVI/CZDpnE7svNfssiy
 213niIcX1xWrgJKCayWA9MvxngXi9rFAwkW+WFKNhZjb8rKEaAHqVI8RvECIrZsyhbVg
 xo0PG0XgY1Ldy+GAZ2EYJef0rJjmYQRkzt7sSohUYhTGgWFJ0ABZENDcmOTkzKZQ7JGN
 yRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778748115; x=1779352915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MkjI7Ns0gEyUpKjaRa+lieiFnMgl026znojr/fHbFiQ=;
 b=FFTZQw3X04O7oOZ3xbn1aNZW/D9X+Vo5b+Q6y462bZavI77iYahT9QVQXVSiidV9Nq
 O6S7DtEhsyOeteLpoZfCxA/xLd02H9DsqrXp17xZUSj7OS58Rxa+AXT1jORsEYeLpunN
 r18q55mVf/BVwP6aAlYiSHy/zwp/9cTgpi+ZRP3Bj/4HWn2W6QLQ6H/CUydzrw981gEE
 LzNeiblLv8cabywvWXm1SKOijYNbf86uakorBxGOYwkQWCRCTpWhSvc7AJgLcC0L/a0O
 48N5f1XZvpLaOJl9ZbhGIEYY1AnJuM2hucovMQaL+C0EbffgrbR5Rf8cXb76FKL77uOb
 9jIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mVL9pqZO9Sy1uzg25D4D/90fIRoJExCYrQ86P4MF47f4z1Bgzp2GIS29HCmx+T1uhg1l+FPg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj12/6L0d8OMpxwGtKP7U2lJ5OQVLwENBvPPZSq6DvmZGGbJN0
 ZyQwbTUJ/ZZIM2vRa7jrRD3yT0w+MvTkkfo9cbyqyOFXECM5Sj9/S7O+0YoCFOg8EXCZB5pgraX
 QJw1WJFcEQ7uO/MwnQzxBRqNB+WQixBc=
X-Gm-Gg: Acq92OF/k+2oSJHoPOqVlBFEt95VmhnY5bhO0ouHuRFApNsxh8EGySg4y0pEBfjThI4
 B7EK50rv/LqYRNnpmtpMRKo9bMjivSIUWngafYaLxiykN1IoAsIqagqZDr8fGXlVsuQJlK+wg7y
 Vzt7PXqUC/WFy+FYkPwdL71tOpK68TmeDWPK+czcnUHORvs/M9DxFFaDDvOM/7by1fRNKbDjInZ
 SBc3gxldCP7lifMjTAC7qjg47+73m+9f3tuVmhyGm6rqtJWus3wTekDPIagkahykB4pqWEQWUyh
 IvkvatIw
X-Received: by 2002:a05:6830:f95:b0:7d9:b58e:55f2 with SMTP id
 46e09a7af769-7e3da4e61ebmr4306429a34.24.1778748115030; Thu, 14 May 2026
 01:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
In-Reply-To: <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 14 May 2026 16:41:45 +0800
X-Gm-Features: AVHnY4JggkXbvTm963_8lXMebO1A_4Wc5uPH1XdP9UQqml3HDzUKcKxkkP44Z6k
Message-ID: <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, May 14, 2026 at 3:29=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> Hi Brian,
>
> Can you provide more context?

Hi Peter,

Not getting you sorry.
Context means?

Thanks,
Brian

>
> Peter
>
> On Thu, 14 May 2026 at 03:02, Sune Brian <briansune@gmail.com> wrote:
> >
> > Hi Tom,
> >
> > Sorry to bother you.
> >
> > I am curious that for me myself I had no issue to follow
> > the requirements [1] as long as all patches that are
> > passing the review stage do follow the rules in [1].
> > However based on most recent commits and reviews
> > most of those are not even close to what [1] mentioned.
> >
> > So at the end, reviewers in U-Boot just made their own
> > standard and requested contributors to follow?
> >
> > Rather the U-Boot itself should all follow the docs rules?
> >
> > [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#send=
ing-updated-patch-versions
> >
> > Thanks,
> > Brian
