Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98825CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 06:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D6FA813F1;
	Fri,  9 Oct 2026 06:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzKfdoA5u1Bg; Fri,  9 Oct 2026 06:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C5A581374
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528224;
	b=WkuhGlGn6MA0Z7FGz3fX4qyhRCgXPqEVAiba61JzJEik3lTU+WlLWrSz7MveMvwPc02A
	 3/M7s+jnw1kGxq0fzRGvz0XDe1oMH5qVwjSAlTX1NChJ6IGpWH7uZejoN5V370VCtw2ZA
	 0uBo4IjrreWfqMS2jpUoeGtbmI47Ggk8fX7mvU8jSkdv9w660scyI0PZ2Z6FilZSCFHte
	 8sn1gQA18EkBxnn3DyyKs4nevkIPPiXILf9VTni8CE8gjEUhhvjwFucyorF8VFvfU84dV
	 xC3CRCdt6C4YnVHt/e6Dx8TxdmWKSUhKpl3J9to3mMsxuq4Rb1kjIbAlmI6FAvcJEjA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791528224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lTw8K7jPoDeCcuTb7MAjc3HcwavMZdSA9nntPxlnqCM=;
	b=TIrO1ojCYWytwO3QReBa9SXBCxAz+cSNlbtAh61Rx+aB1XOWJaidQ60FEWnxtK41SO3z
	 ojjqEjV6jZhMAhEnfD4JQfJo7CMjJpPm2nlrf687Y323ywkwZCM+tXtmd0Y5WnPOU+PQt
	 keYDLmi+wB4scj2g1p6Jlbyf5BWS+HxXqEoPbt0GrWtxs5qDUJXEaA3Pw/niyRcgyBkNc
	 UC0Vn4kgowpMGq2kTat0OOrgfO8bHnDee0mK4RJtCO2M+a9qcvaeMNw7kA2ROU2b4ReB7
	 Yw6bKYViUCFZTPxY143GJIMORwSLDw3Aht279l4H8lmGgZoKSdpnPgw0UqIFSo8sFeA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791528224;
	bh=lTw8K7jPoDeCcuTb7MAjc3HcwavMZdSA9nntPxlnqCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T8UmRBz8TFnSxDL5vCnkwHnZAicFoaKbe61YO+Le2wkKE2TKvRYh3i8SuSCIpre15
	 gImqD1j8mEUwHniNztxGc770WaxJF9PY1UG8RNFhPFQFulHMp0eRXpC4xYiCVtXCGg
	 Uugy9vc6LdteQVP5achWsBqXoGKLzkFAXupo96bccbyJrrWXg/NI07J3mwdCx9UIph
	 Z/rOvErokjSVRM3shi45jg1B+mJ6Ut0RYNpKaVa1uXL0u8rBRgonR497sKXOYfM54Y
	 PxkI/QyMSD97zyIROKqCvmDp4m4ViqQ00xvkc/p/txQBkVf+gej+GBRst2HhKRmqTM
	 6Xhrqoe6cb3Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C5A581374;
	Fri,  9 Oct 2026 06:43:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA1F22E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFD53606C7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xyS0OOCZ0_Za for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 06:43:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9481C606B1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528222;
 b=EHI04Lxb+dbNg56lXVcZUJvHGqDqQNrqzAAIbZ+XJ6GwGGvGuuhAHmFl/JcSBP5h/vil
 zLCNxZIEcuYjjGx97UI4KJPBXwrbAGKlkz3dzDDg8oV6OKrc5OQyGQ7r9eEDJgcVzFElT
 jRvN4tMofiMwno9iw0s0gcNf2iHcvQRyqaoNS5A1wOg0XYSVIz2cTvSWnxqHz3P/dqDsa
 MW3nHEpaTBpFO+t6eKF9EyvJxXJY2Gjr2g7yY3AfNg6h67DuvNS7stUg3s/2Sv5VKZWQl
 hAtJJiXAuZuXY3WAyoSs+et4IssDRxN4xYOVSmsaP4uJqD/+x4ScBLzLl4lYXfsaAfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791528222;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=lTw8K7jPoDeCcuTb7MAjc3HcwavMZdSA9nntPxlnqCM=;
 b=gbXv9cW2MPOlhBmU4FdCHmta8dW+bOg8B2OX4/7QNvoZzoA6OMhVavgghV6Fo0FhFC0m
 NHy72RBU3KAO7xnKUiTh2UsBsUdGfxpvZfLGTWQXE5fawwiGzfPRKSs2IDU4KDI66IIJe
 PRQuqfZLdby/9IbVe+Xskiw7ZatgywGRRc8wSdO0C2NhPUWenNsjsg61CQeaJXyFCSOAA
 WGQq+dLZKvO4ORte+ocWMVhjbJhTh0MlkB0RMIB82ImAJfAFsvEVo7BFZi9AV5akk2kux
 owgPu12i0fHvscNfkZlDsgjEYLo0KlYYmIOpd4bv9DiL7/hqNQXiV9H7dRvWa9NqTGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LRsoyQ9P; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LRsoyQ9P
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9481C606B1
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:43:41 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso6882919a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 23:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791528219; cv=none;
 d=google.com; s=arc-20260327;
 b=AwygvaphQXkxHLYHYsLWw0geJPGlTkCBh9UufCdnv+CiaUsXfYfXIFLGvywukDQq2F
 +9VJvCYQMhsxNISCV8XkJggWOrNIEN1hfRfXGwOvdM8l/tYHOBpK/T9nkGyUY1uvh0PW
 BEFRcV1xRWLANZCv8NhCrUz5m+qD9HwVM1dKSwCDO5d/M3qO9HTK8b+WoPn3tm+bNnNP
 yB96Xz7DfJ7Goi6OufvbA8YzRdmQxZCQ9SOE8CGFWx1/LwchU7WJTbLvybxC2l0wC7cw
 254l7fhuv2p6oJPYB1CdwxkdajJeQBP47maiSdes3pDUOYM4Epyi7/kFJDTPMJjJjjoA
 WuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lTw8K7jPoDeCcuTb7MAjc3HcwavMZdSA9nntPxlnqCM=;
 fh=lMKfDiQdOodQC7HTzT1h5+BSfYMyTlZMhX8dJWE9Fkw=;
 b=lxONK6kuoP2AGJuSlxe2YtF110TtGG3+jkgyyIX6F4qLna2PgVYupoZwXEbcBAdGWX
 WpXDAtZO5clYJUe8NBJyQfdJU037vvoj0g2sy9zPvGmFUvyNQOEKJPz5XvXOLfZ1xBwj
 H7xsxqe9IXXRb7WeUI6MmXhUPfsaFN8lEOWRVd8Mhv+1qa0A8ahzPioOX6TfR/emAifY
 O33t5tlpDizAoRAYqUQT+UMCwHELSHB5u8WOzbT5xNIkG+CIH3y38CGSAe02UCAstLXJ
 gISbdZwszctjh4G04rxat1EL7iJaGuKCZVn90V7QdiKifzK3Ge1NwuupbJ45KAp6JIbk
 gsRg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791528219; x=1792133019;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lTw8K7jPoDeCcuTb7MAjc3HcwavMZdSA9nntPxlnqCM=;
 b=LRsoyQ9P8EQWf1bXc6FO3/topktO7qtf3EvVoxH14OyYa6LGRFX/PBCDdNorIhJf7X
 qB3nEvHk+bYn9Go9m6YSdxWY4ENXtClXbE+qn9HTit2d0wck3NdNcfe57dRRB6+wJujj
 3OR7nfH6ktny9QjrT7i/6hgtVvJatHLWr052s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791528219; x=1792133019;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lTw8K7jPoDeCcuTb7MAjc3HcwavMZdSA9nntPxlnqCM=;
 b=dR4abKnx26cDWTcV7+U3frfCBdN1VFtcZTaN6/u/P9G3jsnxEL8d8/IwlrUiPzNTyj
 Lfd17Oqh0JH1cyAiT9Wsl+FWbl5spjSuBlJkswYdMToQPd/efLYhElcbroz/iji7lKgj
 qy1U1c3GZ6LIxrT1o3zoP6ENGnWUfcJN0MUuWwpqIgxnbXR7RKz3S/Bgb8FHpyOD/rvK
 3+fzZ+GBW0w+EVnvq7jLZEqfKPj7nsOUzTQrFWFKptaJ6vvzDyBN4nkKvyiLILxC8lCE
 j6VkiKYK8HcxTy+56p0cVSNq9N8/EH5lDhlwc9TBbmpbGvGyS66wjCo0e/dJB9DK50yn
 D66w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt6pszgmbXb6RnC8EXhaE5IRwkA4FxhkZ3zYLwiQgSYHcgtqLmW4JobHnbGr29eidqy0fvYZU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSDIoln54f48795+TqhIvafZqDi2bcSJuyvSu39b2IYTzA+1QH
 cmHuB/uw8oNJkHui6MSx8eD1G4CUUL8QOBrbqH3R20KVRIHSplriwdXokqISX3gapVa1TbDeSW2
 BcREufzhSKokoAJh1dz4539k1uIm4kSFGw09ajk3V
X-Gm-Gg: AYBFou1UzaKrjy8EKqzpMU17o59/Ok8wTWZKjbGpVi/9qVrZPWvWsW3fEXITYzP/to3
 X5ClwW4Anp0LyXdZ8siYcBFp0lFICOOFWUseeYLY6dkA3GwwQnR3LJSxfKf00cAF5AOv5BIocP+
 b8lNN8DJ23QGGxSNF58bW+0fBKKKvdT71cKcrx9K/uCp5SgNX/+PPHc6NPHgNSksJTuTtBqg9NS
 lLAbyz+4sMDQEpBA3bOOIwd+gSckkBJ20u7uwGrXPe0TRQnC44wKWinpZe7XEX53m6H61yJ/UGL
 PVTTiizRmrtfFfS1g7ab6UZXhHc2/CJhLQmZHw45i6zWqzLEtlVrez0=
X-Received: by 2002:a05:6402:44da:b0:6af:8022:ffe4 with SMTP id
 4fb4d7f45d1cf-6b17c2b5870mr423251a12.38.1791528208831; Thu, 08 Oct 2026
 23:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-4-michael.haener@siemens.com>
 <CAC_iWjLO9LwkF6x9Eq3Rej27A20W_BZ-BXmL43OumemfG17SSA@mail.gmail.com>
In-Reply-To: <CAC_iWjLO9LwkF6x9Eq3Rej27A20W_BZ-BXmL43OumemfG17SSA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 07:43:15 +0100
X-Gm-Features: AclHuK9b1hqrg2sX2V4C5TQpaOb1uUJ5IWwtCWskCpNuxDKcYf2a3gkHcX7QYU0
Message-ID: <CAFLszTjAaX-HKexye-V0AVhQwFQ_uBnxRG8JkhyxkmCBTKH+0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michael Haener <michael.haener@siemens.com>,
 u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
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

Hi Ilias,

On Thu, 8 Oct 2026 at 11:14, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 6 Oct 2026 at 18:52, Michael Haener <michael.haener@siemens.com> wrote:
> >
> > The Kria boards start the TPM with a 'tpm autostart' call in the board
> > environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup from
> > the environment, so the TPM is started even when the preboot script is
> > changed or skipped.
> >
> > The TPM is now started before preboot, so the TPM reset hints for some
> > carrier card revisions are printed after the startup. Boards which still
> > have the old environment saved run 'tpm autostart' a second time, which
> > is harmless.
> >
> > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > ---
> Simon there's also configs/chromebook_coral_defconfig that call the
> startup. Do we need to change that as well?

Tom isn't running the tests on my lab, as I understand it, so I don't
think it matters.

This does make me think that there is one other change that this
series makes: lab tests cannot avoid the TPM config (as they can
autoboot), which means that setting this optoin will likely break lab
TPM tests, or at least make some of their tests into nops. We can
worry about this latest, if problems come up.

>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> > Changes in v3:
> > - New patch
> >
> >  board/xilinx/zynqmp/zynqmp_kria.env  | 4 +---
> >  configs/xilinx_zynqmp_kria_defconfig | 1 +
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> > index 89f48c03586..ed6c1d7ad6f 100644
> > --- a/board/xilinx/zynqmp/zynqmp_kria.env
> > +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> > @@ -66,7 +66,6 @@ bootmenu_delay=5
> >  # Enabling PM nodes for uart0 and can0
> >  kd240_setup=zynqmp pmufw node 33; zynqmp pmufw node 47
> >
> > -tpm_setup=tpm autostart;
> >  tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
> >  tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${card1_rev} = Z -o ${card1_rev} = 1; then run tpm_reset; fi
> >  tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
> > @@ -76,5 +75,4 @@ rtc dev 0; \
> >  zynqmp mmio_write 0xFFCA0010 0xfff 0; \
> >  if test ${card1_name} = SCK-KV-G; then run tpm_kv260; fi;\
> >  if test ${card1_name} = SCK-KR-G; then run tpm_reset; fi;\
> > -if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
> > -run tpm_setup
> > +if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi
> > diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> > index 2eb4fe4e8bf..2f9d6ccf98f 100644
> > --- a/configs/xilinx_zynqmp_kria_defconfig
> > +++ b/configs/xilinx_zynqmp_kria_defconfig
> > @@ -222,5 +222,6 @@ CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
> >  CONFIG_PANIC_HANG=y
> >  CONFIG_MBEDTLS_LIB=y
> >  CONFIG_TPM=y
> > +CONFIG_TPM_AUTOSTART=y
> >  CONFIG_SPL_GZIP=y
> >  CONFIG_TOOLS_MKFWUMDATA=y
> > --
> > 2.55.0
> >

Regards,
Simon
