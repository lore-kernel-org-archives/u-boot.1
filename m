Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AED1CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C7A06062D;
	Mon, 12 Oct 2026 07:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6KlhV1uETvGM; Mon, 12 Oct 2026 07:49:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C63360602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791382;
	b=SJUI0ICY6Bqww3NEwZ4Y5/9IY3+DxtyCdHHfQqBxCRHxjDtxuqYDqJJw9VH9n4rTYS3s
	 rR28sEMwBPdD5vtNYYa+neXi8WZpcXADEgjIuHnZHxZSEsWBM6qr6GVaPTrTVPMfZEvAW
	 BcOPZ8sLJPD8uFal9fIzMYFfL0ryqLEp1eHZke+aIUBBEzAZQto3ZxwdvHJwEYUhA5xT7
	 0wcvk27hragTHIWgAZWT4wY4XNlwAj9CqSqO2NSuKPmKkDQBx5fBk2Q3Bryk6jNZrH+4P
	 uFQSph+QdKITvf7mHDkXr+GCJCXO6cCWYyQ2pDA14csxSzlJDK/kbPUmrYISpwKUtJQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=u0kh3yqOCC/FkWmNlOT40AczkB6qFBF3xQ+04abWP9M=;
	b=U41DqH6YxPGR46aQ2HMsMvoWEKKmW/wI3ZiMGrS+MumhJawtTZh4BsfATwISU7xdyPMZ
	 GYtbdp6+keSWd1vIJDxvT0OK4nmOOXfAu+qyEeWoPyfhuwb1XYSz6PvFVXR+3PDrFDDUV
	 4NO+R+9/rT/qq/BwMCbegUni2XvKojVDJ6TmqXL6vVsafwdZ+NsxfqeqY4mIxsao+ZFhL
	 jtaWNdkHqRxZBIPbPTZ36AAS2v7xZAq4+sc82Qp3yPcq2hare1zWMDEfqA2hrF8EbkT92
	 gAHCuP9htZowCRG+p9Wm8wS+/1DomVIUdJr4rK9anMYfFne8HBWwwgwBQxkuv03skEA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791382;
	bh=u0kh3yqOCC/FkWmNlOT40AczkB6qFBF3xQ+04abWP9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mA0JZus0F2vyxfGoeZVRTzX0qB48pfz2nmobsGvUzfEcyteyBhI2dxaG9KRcFKIal
	 EQ5csIB3uEwC+5OKsK8Dl4VTMy85BLSztDgENX4aIRc0W9ReytXWkQGsGuFjgoOqSj
	 cxNpImr8FXGY5cfpy/V19Kznm5eOEeeasrDiBHasUU39evVA96W+OvD9u34LQNpHEq
	 Hfeg7wy8AHYIPy0k7G/rd3tQoJwzcaH1Sx7CZ+mIrst8eBUeDRnO220psPtaoqcwLI
	 E3gKMCmtQV0Qy7lUQeigrtR66V8sl6aXiFJZ6THAb2sOgII/7T/peiHdVyV+mDXMNC
	 gzGShwcssDjlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C63360602;
	Mon, 12 Oct 2026 07:49:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 30FD02E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D82B54002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:49:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id srfRfCIXpKdN for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EAD7640024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791377;
 b=FgxYA1ADVtG/5viN8gzZzCfM14tGhx0KendayAqXQmN23z097e/tqLldJHQar7OOSGRv
 nbQyj9HucFmE9UBGDBK5LGoues3WU9timAIZBN25ixLNpyY0YCiElpusPfqN598ZcxxdJ
 91QhvsNBkgDZt856ZbjqxFyr5p2poVAr2u1LXBY19yAE0OdgkxxhpeMY96xvb5PW94IJs
 VurBNvQ38eQ6evg8UnoxI3ZIrsELbTERlrSzgftCjkz8eorFHcKiZDRWVrvCd4Strx+Mn
 yjxcmMB1HTfxHXxdOmrAWBREcg13eYQyxhsE2wN+SwEbWLdRYTwzP9ev16OktWc8QVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791377;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=u0kh3yqOCC/FkWmNlOT40AczkB6qFBF3xQ+04abWP9M=;
 b=F1zDfoaIe2BG8l880elNx1bD/bZB4VG5zjBrc/OgTJiB+5lXHetQBHT1vAr8RH9/H92p
 ncqQPDvGhmVWmGupYRQFAFRMpOz3eRhQtgIJHqwCftbFBlX3SUUEIQCcxeMr7Z89fdXHe
 UWFjsTTRJPYQcnSrGVJW+1V+7qYUVouRNNK7Zn6ajlRPrU2U6R6l1tY+7n3VsIzUsCL8p
 cP5HnUMj3/inT92t5cieLYF/8FljFm3vgQc6JfsSKjv6SZdZMj4DJTd9ULdT0U5ZbDlBR
 OoTRHuT6i6YhkVztDUGSuFCNfnce3N6hJTbOwUD5BCLBnkB1YTAx5LNaMwS1V9V6jcg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KsrrPlqL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KsrrPlqL
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EAD7640024
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:49:36 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso3393631a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 00:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791791374; cv=none;
 d=google.com; s=arc-20260327;
 b=hh10eiXOgknRHsQJgSAhORlDPAvWhAJvmL2hF+1kJHA5ARfKexNcITiJ8XJsNFe/aI
 pZ/0rEfZv1ocnTVFNhmqFDUJih8/cJQB6QwivegEYAuuaJ8nn3xuILT/f8hT2aJ6Pfo1
 lwRjgEcKWxX4mSsJPONHt7swehqbhGelaio6fEdrYoKKXjcN6UrccC7YN+JlHMdE4LPA
 p673Xqcw8sdpmSex4ef0Py9YKeeie77lWHLTavSMJ7z0wX2rCzRPUI1syplNxAf15u5R
 OGKmKnbh4ehCiPXfwpG/cc+A8rk81mkCokCTGhxX5YItOyNiO0B7WbsOUWKAQN2lBMzL
 NvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u0kh3yqOCC/FkWmNlOT40AczkB6qFBF3xQ+04abWP9M=;
 fh=NTxYOwEb8nVKeQZmcMc1SJC9KFy7mKxydJV6Ccpnnto=;
 b=rij1U7NRJS/caar21msz5OFPa66Fd7CmhURejJvg7osNPrXxBdr2Pdr+FR4SW0l7gF
 SRz5DGv7tUGFh3MRc+xVqaMZnyhpunoVAuwjVF3sTzpN9QeH/Ga7n2alOsZI0HYuqYiy
 6HvTcaGPriD9nm37hJLM/b02DR5TedO66r+Y4erqWXwmsrKA1gGZh8NmgFDCSbZqDfRU
 pm0JTI2z21ewuA9cRZy/H3/PsbqH/dUTkHkFr5p9U/DxL6KAdKBf8GqHG257ysQVYAF3
 hEs165nwHRmCcu3S+My16resldaOxPjin07BzvoK9QDXA4OCzQrG3VQDmrYNIsRmz23q
 pVVQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791791374; x=1792396174;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u0kh3yqOCC/FkWmNlOT40AczkB6qFBF3xQ+04abWP9M=;
 b=KsrrPlqLmzRZC8rY9bZogyAUYkb/7auZmD0rcKcebgZJkPeGE168FVkc7zct5kGKzo
 uYaDp2/b+vMwYryI0XK/XB/ARyltcNiEY0w9Q6c8+b4P11ronAoDKMVMpvTD5YouEA4g
 edYJ6tkyIAOcOHjXXz0D2rjGUccCSz9cSS+Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791791374; x=1792396174;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u0kh3yqOCC/FkWmNlOT40AczkB6qFBF3xQ+04abWP9M=;
 b=kbkNkl3wn7KIjTLzNVyF5rDvcaGwiD97PLpt8OO6vJOOw6w1poMIkN1i0iNmc3lI1w
 IT5TKXX9dXVnjroHXwfDQoeTwF/K8POU9OizkfpLAAm52wqM5NbJ7BpVzKc+VBQUALN0
 jycP6tJp7jrAPuO12JGu2JLArz8T6Gr0sxdaMD8i1TUKQr/OshmzeIB9d6raVADhoI4E
 AiMfDkZouOXplrPbW868Mq/DRLTGVZTRnUaFscFeLkN6zoIK0pzkGDPVnH1TqGi8sP0g
 VuBeL5PJGNFwoOX+iTDFvYTsIKr3vEKEngzCrmiDOg+OWRd+L+zcX4Pb14zWyXRiRWVa
 mDAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhjVcDbmW/7Vf0bbptVYCPCIjcmwy3ct5CaVh9JfLHBWCpHXaSe7CrKFNe5kHxHQ6wBBCr5yA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ3nN/D9mKuUwpXR4xjVd3LkR2DL+lOuOKulTJmO5ece3Z6yDjp
 kHQih1zWnS7iqSHAji5kt+2vW+Jdlw8+qPwWlynHbqZcE1iGeKChkWg7AjK2J5gWR4tUAZ1bssd
 08J2RQ7hIgtLcAB+rDgbmX+D828dUEejKgIvWz26G
X-Gm-Gg: AYBFou04LScHYil4w6WirTXBbty1bGmRNJN2uc/LTntnP4YsYTtZGqDIVN/905YEe47
 ja4wBV1LmRJ00dTrJEDLfsbzJSLxzElg6B7iJMx/8L90Lcf5J69LrASw7M+ZGkQAZD8UNZCnIbv
 ti/UeLeX7tuy6T4FIVR4h15F6j21VgyKMIyUlnIE7aJdfXWRsZeNyxSDf0zGRWACJy5/mB7QE5v
 LTqURT/o2EDMm7/2bd4J7cXcthPc37AGdhEF8PDTEmSrE2d4zGkq5T6aumeGQG9yilSZZhq4UhH
 0PjOLjCRMvSO3BWyY5DmfPwDzu0a1dp0z0GNtkNV8lA2qC5jlZw5YI4k
X-Received: by 2002:aa7:cf95:0:b0:6b1:d345:2f88 with SMTP id
 4fb4d7f45d1cf-6b1d345311dmr391944a12.10.1791791374215; Mon, 12 Oct 2026
 00:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-4-michael.haener@siemens.com>
 <CAC_iWjLO9LwkF6x9Eq3Rej27A20W_BZ-BXmL43OumemfG17SSA@mail.gmail.com>
 <CAFLszTjAaX-HKexye-V0AVhQwFQ_uBnxRG8JkhyxkmCBTKH+0Q@mail.gmail.com>
 <20261009153309.GC769217@bill-the-cat>
In-Reply-To: <20261009153309.GC769217@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 08:49:22 +0100
X-Gm-Features: AclHuK-sXJl3iOr-BZ8_EuHKiZUOE7lykZLtZCo0SkeguEo3ZwJ-53JL0V-ZnpU
Message-ID: <CAFLszTgENYuyctyZudYrSrWg_COet1xmkXELrT9Vt7J_ifx=Aw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michael Haener <michael.haener@siemens.com>, u-boot@lists.u-boot-project.org, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Fri, 9 Oct 2026 at 16:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 09, 2026 at 07:43:15AM +0100, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Thu, 8 Oct 2026 at 11:14, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Tue, 6 Oct 2026 at 18:52, Michael Haener <michael.haener@siemens.com> wrote:
> > > >
> > > > The Kria boards start the TPM with a 'tpm autostart' call in the board
> > > > environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup from
> > > > the environment, so the TPM is started even when the preboot script is
> > > > changed or skipped.
> > > >
> > > > The TPM is now started before preboot, so the TPM reset hints for some
> > > > carrier card revisions are printed after the startup. Boards which still
> > > > have the old environment saved run 'tpm autostart' a second time, which
> > > > is harmless.
> > > >
> > > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > > > ---
> > > Simon there's also configs/chromebook_coral_defconfig that call the
> > > startup. Do we need to change that as well?
> >
> > Tom isn't running the tests on my lab, as I understand it, so I don't
> > think it matters.
>
> Setting aside that none of your hardware is part of the project
> currently, we don't intentionally break platforms, so I believe the
> question is if the option needs to be enabled or not, for general
> functionality.

How do you mean, 'none of your hardware is part of the project'? Do
you just mean that you don't run the tests on my lab? Anyway, we can
tidy this up later if / when it causes a problem.

Regards,
Simon
