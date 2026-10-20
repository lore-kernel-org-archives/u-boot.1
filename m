Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0C606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uN6HbnFq;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=UUcvqlFt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6930F60738;
	Tue, 20 Oct 2026 22:53:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aDD4sH-3JbHQ; Tue, 20 Oct 2026 22:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24F8A60754
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792536814;
	b=hx1NpyxFXzJdNda3MHruisDmf8aBR1J9lBfr7oGTBrqhyRemRPfGozey5Vqx/oVBz26V
	 HMMygVs+4FCTF71qfnGknuMqrnPeyADO3qE9p+T0B3ZKWBpC4gGF5xwp0ruJrEK/AixHh
	 gssvVb/McSHlTTTvje9bqWHqZm7rGjPLiFnueP1hdU4FvUA1FmlUG7pgNGsQeN/Dm69HP
	 CfyK0Bji7fqPzsPXAzs+C/zQP3gP5ZYM83AD2lDW1hZthCfgCST/le+kjoK9FoxJmbRkF
	 qBRjW7Tbcb75WRmhaXhfkJUzEGCJ8bqFtdy0VaJFttobvedb50yOHiyssD0jqBXBz8A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792536814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E+fiu3lh0hzMC6mbbSldnv3aNLe2NjY5R90PcD5BRLg=;
	b=X4gvIW4tUe6kisBgMhUm4sZojjOB2ScMnlNYJ2Npqcbzd9gzsIDYe9npX1KxBWGgDaD/
	 E3wYQ9q8znXQlAp01mF8z+T4qc7kvZg8FgLwg+KcHdf8bwr0jBUvo7KHHvrdeyde7ZZWr
	 fBJEX5XDHZdjuS8FRB2OBFWXZcYFKqQ2a9VZ9RxD7p9PvAd7m0ViL7095Ka5wrGd+OcY3
	 fzgMf1PrxRpbzIrJV8KYp+oUz3QQEIjTvfGrO057qf9LJZoGl2uZy+RKtxEow3va0cMVU
	 J1uJ5El1dUg/dU/z66RzqEqIY54z+1bmVYSNQn3ejLe/vH4uPSjbFk8hmbRqsLbhQ+w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792536814;
	bh=E+fiu3lh0hzMC6mbbSldnv3aNLe2NjY5R90PcD5BRLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uN6HbnFqCqXz5rfwYlNhSPy4YsotcSd2GYIgYLH8i6rsq2/NQFt4rJJpbAeg4e5mJ
	 ty6WW0Q7LN5cvNKHzxRtbssS0Y5CoDocRCqW/0SjMnsQiOjdfywdh6N0lebUrteF3G
	 WCCw8JL73uQKbV05AxqhtydEupGp4mY0r0bmlqWPNSSGebbP0dIIhMMuv54DTEwPOp
	 MFn0Wy/WdG1m4jQ++6cAjjmcnK7ziPo2rpCXTHpc2GciHdpzkakXibcM/0nACyZB3U
	 Jso5J67kdPrLii0PXuDlBa1Ev92sxXb6dCwKRN1KQF3ObYpUizQXpjEdEcF3WYz0Vo
	 Gt64fv0gHweRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24F8A60754;
	Tue, 20 Oct 2026 22:53:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB6F9769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C169B400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2dE_JXAINzQ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 22:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3FD1E400CB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792536811;
 b=LEZGoFs9W5TrWnwIuvKBBfE8kS7ZjnKyHSJzZL7oQbge7yLvcb03Ai35HV84SqTi6p22
 bwsFZ2nHsyifcgkwm/ja9i2szvPz41FhfJGg17/AQmqGJtcbrHYeMZ3ZoZg0ci2K3uiEC
 BpkfARdGWtZobbFJ3eeCjz2/i3fW/WzWhyZEDJ1WA3OfixVCIVEnoJTM3TFIHEQ4CCBTf
 Of7rPOUpohnAAXwjTb9AOnSPod1lCD+VpSHGbnXRtZUpJaRCZb0uwtX0jD4j1d2jwqcIP
 ZnmqluDA4oMnQ3cW9kPf8ZEuteFcgt7MpJGRQlqUPH+MNvHvt/Wi1vkHSIVtodS9gCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792536811;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=E+fiu3lh0hzMC6mbbSldnv3aNLe2NjY5R90PcD5BRLg=;
 b=TLlOz54q9rxFZOtiDWtv9VL16u5ajG7FC6qDgsLoE2adm8vE1m1Y0q+m6XcBWoCAMLyw
 zOVxSVy3gFT5BGmIbi7ZfxEdZcylYSBGQgM9nSaizjnMmPUlq6h37dm5b9+LkZ264AbgK
 T2GV1sg+0OhFYcNy+Ofxaa1zX1G9Jso4JmDIErr3CLXCTEnxQ9uSgtse/kQx9OeK/4pbm
 izhhdPWCFbHvUgsnhm7wZgLjSlUAcqAxPxzn550h6twz7kYaPxM9mv9v9yaKeVkhEgR2A
 tB3tTTKyo4fzaraSGfxAT5fQMSeeyn66shqv3bm7CREEmUgNhdLNmqE9W3s0E3mPAvQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=UUcvqlFt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=UUcvqlFt
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FD1E400CB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:53:30 +0000 (UTC)
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-676858d42f8so80928d50.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792536809; cv=none;
 d=google.com; s=arc-20260327;
 b=GQcqMZHMObyRilc3g7vFXF2pc2guxJ7XooDnJtA08fzVQrtL7D4ob5P0GgXYkODASG
 /sDgeycOFggIuXWt7rv8vFtL+4Jfqhg9BKHLubrQWG69m0KT0tnNNIwk9xiIpxNDXqfa
 sDZXa4veJxa+87M6osG16dmxh4UGaYg6sqpyf4oGJ9Mz1Fv1EBX9ho3DbkWC/+AfB9ti
 tvw9TI1Y+kgvohfcfTDDP6qfLl8fj8sdrT/NxQ+KWjnm9kIrwX/9l+0zbqGu20FTpOGe
 zyXw+Oh3FAx791XN/aft0EThrHwzUpy8fQfQEn28iBXsfpVtlVXfpg0E2p1KfIWTH0ZO
 bBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E+fiu3lh0hzMC6mbbSldnv3aNLe2NjY5R90PcD5BRLg=;
 fh=UQk5iqO7VJkS1+G504JXL15hfSD60gl8Nhexx9eKoSY=;
 b=O2UNiHIpkoSunXtGVgotEWD2jCc3wDm5l67PMgGyOzSGDQFM3oZ09T6oH9R1tt9vEH
 MM+2RAvaLHTW2IEFRCFgKSrw/QIVkdVk/Wwqq91eb5X7A4C1+onmmze4uGpIIr81n4l/
 vFU0tWJBf+7txJLPgtim9r1ZTGlywxYBSeeBdDcvWMawAVcwfRiQOy6z84CcW5prLLJB
 yvoIntMzz6Lwc8ii27VgGlPDk+uJAFU89+BzILo6AZl3MEM0Sn7Stame74pWreHWppMY
 uFTj8uQs036kOMtami07AvO8ep4Xi/dg0kq9IGYgLQPBf9tZ0Cl8hNU/n7jfn9ZEvGJE
 H1Cg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792536809; x=1793141609;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E+fiu3lh0hzMC6mbbSldnv3aNLe2NjY5R90PcD5BRLg=;
 b=UUcvqlFt1zuM2jdGzZg3zmA74OcT3dIyYQAMsnS5hkcqzY55V/9bYnTu2o9VKqcZHv
 Ak5gxDGujjOvJkKw9zrArJgvwTbHCBN4SAt5de1sz+v05JDnfaJndqzVtO9rcY4l0frt
 iUFqfZxJMMGg3pYcNVlDdNJzMKdrYV7Q0ZRhhirhpLKWwo4vFLBXaFC40RFnmznIkY3h
 H7z8E169KSl3ObWpBd0bZ9SDxcY4yoq4O6pVrBPzE1EpxQ0Ngj3oAuTRLNqD31Ga+BkT
 Yfu0ueLHy1oRjnU2sVTOYYmh+vlcJTYpOzUPaUDOvE5V3ExJa0gLTrzt0Elt4VQNyyu0
 OGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536809; x=1793141609;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E+fiu3lh0hzMC6mbbSldnv3aNLe2NjY5R90PcD5BRLg=;
 b=E6iXWF7rJB56JgWnP8altoTomJrYgrQlttymZ/g2BbbVesC9FjzJkOX2KaaCwdJ8fQ
 51HJIPFGP7cRnxDQdW9gVp+xSgAVkoxGfJltKUo+bUu87Di02V9eAxuc9banSu0MOyyS
 zIF5o3dTIJL3yk95132IRG2dmyF1HaoYB5zQSMqX8Ly4h30zdMck2EF/rCt+rAPfYr/a
 xMBUxRQhlgdmYv7QDju8dXKOqugvH0740VCLgb1FPK1kSpNttbX8/Za4dWbk0kTTj/R+
 SGX5330wuukUdWXjaZMAvJsxlmLZhvi7SkqrLLe5X85SO8MPAXbomMDqzGmGhwid/rVC
 TobQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByqun+lMTAra4hwEUcIgVMAdy9uximjY7mMhe+azvc4Jr5XN6Ihosh3HVQl6DvS2Iz7g742a4M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK0eG8EN0x3nOdvqwRtFIacU3rkUIEIsr4myd8fle4XhdpTu0FF
 Z4oqi84lebcqDajg61TZxfuc1ewb9sTkh70OIto2Kz7aZ8f8u8u6kCyDIKZMx9/Ac2ZAmsFsbXH
 m2LEN0yC4hqOuD/vcTQCtbLA2lIUSMr00fKmIFxQDLA==
X-Gm-Gg: AYBFou26slLzqDldMO2jMvD0vfdeT/LOpKhvA68VjDQVQ57D+LEz1aOX+FFKS+6jGQ2
 K0l5q+yJD2clW9nsVqVdJzIGMlOHLIinqHTav8+DmXmd+vXkEYXxlVEgtjrYesCYDLMt1y0UByS
 15ffTTLIfiGISz3Q+pTduNwIIZ9xj3cWseqKX6ILwGT02MLm4v+ZO7F3+qBbHz1p48FXn/Uo5+W
 SRgQE1xS90hvWIA55aFcToCdV7cvy2tCy95Amt6PFEDXqGssLTODyMiX/+5JfnCQFmyqFS0Hpfi
 ON7jm/PK0B4t8Xv+0ue4xFDkfeSwUJLVea2U8szgRBvbN2Q0tpCNiHDSYFNZoOyCIFrxtMhU+zL
 Sd42VfEf4UPb2gDylyb8Akz2M/KCEtKshWOwAUE4adBp19iHcaInnkeH3jJm9a2DBeDeDBQP3VO
 UgKOXJIcTzPAsOVNMOWFCNLGO++ogMJTwQT6Mk6fwAyqfssg==
X-Received: by 2002:a53:a94d:0:b0:677:af43:e258 with SMTP id
 956f58d0204a3-67a0e55311bmr161940d50.117.1792536809095; Tue, 20 Oct 2026
 15:53:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
 <CAEev2e9WvQD3ZJNU91-UH1p5KBw1zXZgqhJuBC+6y+Q9HvwrwQ@mail.gmail.com>
In-Reply-To: <CAEev2e9WvQD3ZJNU91-UH1p5KBw1zXZgqhJuBC+6y+Q9HvwrwQ@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 20 Oct 2026 17:53:18 -0500
X-Gm-Features: AclHuK-vxqYyGPecHxktUsXgpOELnu3IAUPCS6-016lXo8eC9bLxB7Npdz-6oQ0
Message-ID: <CAEev2e87Wn=pE1uqFTpi1EVBiyHq=vLPFmvBTOv7Nzrdji0CNA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Add RISC-V IOMMU driver
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yao Zi,

On Tue, Sep 22, 2026 at 1:37=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> Hi,
>
> On Tue, Aug 25, 2026 at 11:43=E2=80=AFAM Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> > specification. This driver sets up the IOMMU in bare mode so that
> > peripherals requiring DMA in U-Boot can function.
> >
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> > Changes in v2:
> > - Changed DDTP read timeout to 3s from 10s
> > - Link to v1: https://patch.msgid.link/20260803-riscv_iommu-v1-1-793cfa=
421ab2@oss.tenstorrent.com
> > ---
> > Hi,
> >
> > This is a pre-requisite for U-Boot on Tenstorrent Atlantis. On this
> > platform, the IOMMU comes up in Off mode at boot, so this is needed for
> > SD and NVME boot to work in U-Boot.
> > ---
> >  MAINTAINERS                 |  1 +
> >  drivers/iommu/Kconfig       |  8 +++++
> >  drivers/iommu/Makefile      |  1 +
> >  drivers/iommu/riscv_iommu.c | 82 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 92 insertions(+)
>
> Gentle ping on this.

Gentle ping on this series.
