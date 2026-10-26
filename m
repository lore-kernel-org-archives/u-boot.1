Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC8606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eMbH+wuM;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oAEAVZwR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E894480D92;
	Mon, 26 Oct 2026 07:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWM6af7lFBZQ; Mon, 26 Oct 2026 07:21:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2BE980D47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999265;
	b=XCEWwjo7GbqP+XeDsyPGGPbbmGxG+RGziq20L1XARunmP6b/WHKtOxKrOFNi55jujy0I
	 LxAhSnKojDmL3M7G5jGoHH2iINghHO7ZZ9midh0REnvdMkwmKjtXbJLQkXIRNC3ONw1lq
	 fWrIl2TF7lxKmjsy3C5652mu4C9d5gLdnB6YyHjHPLpkUHPATz6edRMhOGGdQSM/PO0Cl
	 Bs5hIwB4Mhdlvmq2m6jl34IgpU4HJxZExq1CkhNJpP9pnYakHyrA/BGs6SHEZ4o0JXPwO
	 PgbkGQD1TxJym8gsboiljDu9pOLJu9BCbsgYwqbBSo4W0EKBFYEQnWB06bl5mmMLcVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792999265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p0xypSM5uBPaGJ306ku9RsMgb2WHQrxwumI5fn1mO7U=;
	b=HHGMK/INDWzCXPbmi7mBRXIvQdJ/h2Fpn/VG8bmchc9hWmBTkOjKXfyMRkYVCvJfdUJ/
	 jCYvI29hAZgjOv5gEOIIlVjTg+OfLfcGZbiDibpT9Vd8FC+dfrxbxRcHcCCQU8k6Rc7BI
	 V93L+5+rFeN6vZvCODYkSkS5wIkZA9P8/GpE35eEDnZBf+8yhNDSQRtVGssN0RkAE+shQ
	 jzF5YTA0lc9Xu07Oe5ntMps8PgotlTCCNPeYfRPCc1sGLnjUXl6c+n9ukEevw8xE5sCK0
	 +y6ykkW9OXhjmn64z3wbFpEQfCY8fVi4y28fDdiz0b3Zm6GbnMhLZSx5AdbxhVlntkQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oAEAVZwR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792999265;
	bh=p0xypSM5uBPaGJ306ku9RsMgb2WHQrxwumI5fn1mO7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMbH+wuMMqyFE2PYu3Pce3w1xhrASLl9XSS+/r6LT/dh+DLzqtAEv8k57XpBdjJB/
	 Co49v7eo+1c2/38Jkod3DBjQcTmKNQQ8GYwew2Y+Vt/oBWYXF2SkpKeAeIjRsUnxic
	 fyAPectEmJgn5MdAOEHJXYLCWbD2E0QG7dzPgeUtPp9pBglAz9INGf4d6TeZYiS/+z
	 dKq3SU/njbiB072AtrQQ3/EKj57dOezH+Kx+04YJKgmAshpP/L1pxS9oFN6KOQ8uMj
	 WRktK1ckGYrSXnR9GnO4r6OO9QCx62w9zzK12qBUDwxHiAxOlcHLAZKL2xhhGlkJjC
	 gMxrSFIgmJbZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2BE980D47;
	Mon, 26 Oct 2026 07:21:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B9DE2C7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6193980D47
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JcohnBgWJ2PF for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:21:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F82F80D45
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999262;
 b=FC0lpGiHbfsfv3V6jck4reoMlvQeIlsgXbjjrEerTga376fYdpwfb9b53RKZyRcqYnv5
 QVNpqSE9XZ4luHNZ/Y/7XDakaup/frah5htIivd5byaPPEbA6rhIvsIm3vrL85rupOal7
 9fvAy7xy9BJEz+FkQ8RZFNyOdnwh9aE8JA/LDALxESmocAdvRW/XO4EZercxlZqkahLC7
 THd1jU7D7R3tUOV8+ECQvUkqvYbR5YTNCCaE5CBO8D6jLybrKWp17zMo8S55JiR9pTD3E
 D/7OenIyFS6fI/9BZ5idnrKmZplNZCEvfiNbkj0WDDO4OzyyqnqYWjeU8m37YxlbF4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792999262;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=p0xypSM5uBPaGJ306ku9RsMgb2WHQrxwumI5fn1mO7U=;
 b=HjVmwJWCr4Ti/Vd5t0hXAGIgsqCUnCmcFVH4ZDIq2XS58mGhIplAp6YpFDMjVyExUFXs
 gygQHt0I4O/Bw6Lcp6DngS1Ma5jrXTio2fwJtniv2eH+SyoE1mEzr7guLSLXhNMEpGvt8
 sUbS+LCe3ps14FHzdwOUFJ78bjkb9aLLBSHjpkCvBnE6nhirakMCT4zi02m7av2b5KmZU
 /nl44bqC5pciYst57fWN6nEu4U1VUgijPDjrkGUaGjIEpojqk74TCqQnz0eZ4wHW0ojMM
 1bwOjinAmoHpGwgj4pcPb8SCNFJKoMR1/Kg9Yd8DXs+iMvcI8INcl1DYtJWjF/zslyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oAEAVZwR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oAEAVZwR
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F82F80D45
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:00 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so3326786a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792999259; cv=none;
 d=google.com; s=arc-20260327;
 b=PPEaBwOELLikAPwUMwlJmUgJFk78db49q8G+ZAvWcEnWXQjrfGeJ5zENcxy+h6z3J1
 8DveT7nddzo9ehUgoSb3Fym+DC2ZGIwOp5pACJZRo+sCEmXZE9gPk/qy8kDVPwc+4F90
 6ZytMaWUUrp9yJtLrc43d1NKYmIfPSX388Cc+mJ5l531Fp8BeBtCX4TnFVqhxQX2XWsv
 8b9oc6y6PbLMhnneuVLknp4GLmbY3j4o0r37KLiV4wyzl88L/HhUzO839LN+g7BB8FuZ
 jKsvZ0UAzDyUp7p9Z6vFOdfAqJ2+We/N6gA9k0m41WakfuXGTTXJVrgDgbgntAlK1OeR
 Cm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p0xypSM5uBPaGJ306ku9RsMgb2WHQrxwumI5fn1mO7U=;
 fh=L4fwuwWEZh7x1PCcGGjBLTcEwOedL37rJmHwS97fYxU=;
 b=XamYmH6fo8NxYCJjk7iCwUSYT0QgTXlikI9q1rnkEwT4IHMPnz2sXr+d+8kyNVNwA0
 PgR099VqtjOf6F7G5eQY0pv5JGau/3cNLfM9n39rRMANlHU1nlpzMfrVfumPr7wWsVlP
 Of6THETP0WrekHTLeel+C3bHivEE3+Uq9aClTwBdHsdMmHbVxpjQfZB3bw+rIr5hUXVE
 oXpGH628vg4D6zohVCjGMmYVFvtGXraK0s5yrJ0KZXo7kQKKKkO4CdKixBCp6M9/orrA
 kECFQdtPIMCGR8zBef/LbbL2FSldr8wAd2JDwmhafxhYEZycnqNxvbCrrkxzzi5j1p1m
 cpcw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792999259; x=1793604059;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p0xypSM5uBPaGJ306ku9RsMgb2WHQrxwumI5fn1mO7U=;
 b=oAEAVZwR2UEEl2UR9gQXL3bmiAphh0IVFAnWg03sf/QZjO/xo5Ue4UtFVaI2tTMogo
 fRRILigMN0bz95eHsmi85UnnVzfDOxWE2S3j96FqGD0LyXVZ6fLO7RH3gSsCfQnnh8cj
 d6eE2O6LL7yqSXZNfidzFkjFDjO2jSPceUdsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792999259; x=1793604059;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p0xypSM5uBPaGJ306ku9RsMgb2WHQrxwumI5fn1mO7U=;
 b=xw8fGxOl1iOgZrPmRAXMMzxEo/uT31zTKibjgN5E87l+9Kgk5hdPCmIaprIdy6WkYl
 t6Mai9P7efLEDtDnjSu5z+DJJallUZXqhhq4KMxZ23A9Fkb3BcB9NbJPTJorP7oBzHGm
 OxvuSNxh65t3CYsJzybRbmLgYt/ZTPvbfYSo14gqNITzFm6EdIIt9D1oxewQ/HFNsvgh
 xlP6FMpahKLftx7p8QClfqPVw3RmMLs7L9ui6Lc+7cBwY+WZmz6pO8fIIchv7Xk79gd1
 YZ2L7E2hr4aucihSzTTkIjW4prSMvqOkAb1w4Stx3O41ZhKFbZyRnIyFstkXkCKoq6jA
 ZV2Q==
X-Gm-Message-State: AFq9FYJmzQGDObyik1w6rwl0D4ODhodnNQWByB2maaa5uv3+0wJMoiPh
 9u82O7saFOd+XoFoVWVd+R1oZ3Dagd0jeRNMUvA3jg6T5cToebxuXbnwxVcLW6z4mrqchgecZla
 zNbf9bwRVqy+fCe6rD0C3M+Ha6CKgSu0Fg0UwvlyN
X-Gm-Gg: AYBFou2HB5yQoOTPNSe0Q28xylZDo3XW/HQxl0L+ZLtivNzInIiqwbaEhZFpX74NTEJ
 VuKVAG9RfErXIm1tFXc0Qml8tNoGaeOw4okAPAoxDFyyFMLCc9dHwDKCQDdIl+VnNZjuLGnhF2n
 LdFCyhSmL9050/iyALDrGwA9aexbwXD7j1XqNp+HrCf7VnTL1fHFejfCzghZkov+CqReDuTmfCy
 4o9ea0aDbC5ykp9KOXxwQAW4Bw6nsSNaD7XG6hbCM9VZmwmN8P3qORFql6UoiCnJEFOua8eL9AF
 XIuw35222zBsWd4pe/Y/mxSV0j4b0JHS2ogKQ9THzzKIO27Q5ULk46R59M7wmu64ddw/jgAsVn1
 OG9DV7WCq0AoiJGXvLtnJRDRL33ttMbPSZGs=
X-Received: by 2002:a05:6402:1d4c:b0:6b1:e8e1:a3cd with SMTP id
 4fb4d7f45d1cf-6b44300fca7mr7009669a12.35.1792999258901; Mon, 26 Oct 2026
 00:20:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-5-hs@nabladev.com>
 <CAFLszThWnBLQVZvpDAdD_zD_xDPe0x8ed4peMXpfFF6a13=rrQ@mail.gmail.com>
 <2a7285ce-bc12-043e-8fe6-674d41d1f275@nabladev.com>
 <56382e4e-d25b-66bf-1463-5438588392a6@nabladev.com>
 <43fbdd27-1367-02f5-9190-566c626cb256@nabladev.com>
In-Reply-To: <43fbdd27-1367-02f5-9190-566c626cb256@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 07:20:46 +0000
X-Gm-Features: AclHuK_1wFZS2Wfzhrse_JptJSVSKcQ6TCVbOd6_79wJwk0kfIvZ90RSSe7edHc
Message-ID: <CAFLszTjxM4POd3xm6Cth4ARnycRauCKT-gaQBBDeD=5heTqVgw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] sandbox: spi: let a slave point at the emulation
 it needs
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Cole Munz <Munzzyy1@proton.me>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 "Bigler Stefan, Securiton, EES" <stefan.bigler@securiton.ch>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

On Mon, 26 Oct 2026 at 05:11, Heiko Schocher <hs@nabladev.com> wrote:
>
> Hello Simon,
>
> On 13.10.26 08:11, Heiko Schocher wrote:
> > Hi Simon,
> >
> > On 13.10.26 03:22, Heiko Schocher wrote:
> >> Hello Simon,
> >>
> >> On 09.10.26 09:08, Simon Glass wrote:
> >>> Hi Heiko,
> >>>
> >>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> >>>> sandbox: spi: let a slave point at the emulation it needs
> >>>>
> >>>> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
> >>>> on the sandbox SPI bus, whatever that slave is, so a device of another
> >>>> kind cannot be emulated and cannot be tested.
> >>>>
> >>>> As with I2C and PCI, a slave can point to an emulation node via a
> >>>> sandbox,emul phandle. Its compatible selects the driver. Without the
> >>>> property, the flash emulator remains bound to the slave node as before.
> >>>>
> >>>> Rename sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul() while
> >>>> here. It is no longer specific to SPI NOR, and the old name would
> >>>> mislead every new caller.
> >>>>
> >>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> >>>>
> >>>> drivers/mtd/spi/sandbox.c | 65 ++++++++++++++++++++++++++++++++++++++---------
> >>>>   include/spi_flash.h       |  2 +-
> >>>>   test/dm/sf.c              |  4 +--
> >>>>   test/dm/spi.c             | 10 ++++----
> >>>>   4 files changed, 61 insertions(+), 20 deletions(-)
> >>>
> >>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> >>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
> >>>>   #ifdef CONFIG_SPI_FLASH
> >>>> -int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
> >>>> -                      struct udevice *bus, ofnode node, const char *spec)
> >>>> +/**
> >>>> + * sandbox_spi_emul_lookup() - bind the emulator standing in for a slave
> >>>
> >>> The generic part (following the sandbox,emul phandle) now lives in the
> >>> SPI NOR emulator, inside #ifdef CONFIG_SPI_FLASH, as does the only
> >>> non-weak sandbox_spi_get_emul(). So emulating an SRAM, or anything
> >>> else that is not flash, needs SPI_FLASH and SPI_FLASH_SANDBOX enabled.
> >>> Please can you move the phandle lookup and sandbox_spi_get_emul() into
> >>> drivers/spi/sandbox_spi.c, replacing the __weak version? The flash
> >>> emulator can then supply just the fallback for nodes with no
> >>> sandbox,emul property.
> >>
> >> I add this in a v3.
> >>
> >>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> >>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
> >>>> +     if (!ofnode_parse_phandle_with_args(node, "sandbox,emul", NULL, 0, 0,
> >>>> +                                         &args)) {
> >>>> +             ret = lists_bind_fdt(bus, args.node, emulp, NULL, false);
> >>>> +             if (ret)
> >>>> +                     printf("Cannot bind emulator from node '%s' (err=%d)\n",
> >>>> +                            ofnode_get_name(args.node), ret);
> >>>> +
> >>>> +             return ret;
> >>>> +     }
> >>>
> >>> lists_bind_fdt() returns 0 and sets *emulp to NULL when no driver
> >>> matches the compatible, e.g. with CONFIG_SPI_RAM_SANDBOX off. NULL is
> >>> then stored in state->spi[][].emul, sandbox_spi_get_emul() succeeds,
> >>> and sandbox_spi_xfer() gets -EINVAL from device_probe(NULL) with no
> >>> hint about the cause. sandbox_spi_unbind_emul() would also pass NULL
> >>> to device_remove(). Please check for a NULL device and return -ENOENT
> >>> with a message naming the node.
> >>
> >> I add this in v3.
> >>
> >>>
> >>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> >>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
> >>>> +static int sandbox_spi_emul_lookup(struct udevice *bus, ofnode node,
> >>>> +                                const char *spec, struct udevice **emulp)
> >>>
> >>> This binds a device rather than looking one up, so the name is
> >>> misleading. Also, I2C and PCI do not bind on demand: their emulators
> >>> are bound by the normal DT scan under an emulation parent node, then
> >>> found with uclass_get_device_by_phandle(..., "sandbox,emul", ...). If
> >>> SPI did the same, you could drop the lists_bind_fdt() call, and tests
> >>> would no longer need to unbind the emulator by hand before devices are
> >>> destroyed. Here the emulator node is a child of the slave, so it would
> >>> also be bound twice if the SRAM driver (or the MTD uclass) ever
> >>> scanned its children. What do you think?
> >>
> >> I take a look into it, but sounds correct.
> >
> > I think you are right about the shape.
> >
> > I will implement in v3 your other comments, and I think, that is a series
> > of its own about the sandbox SPI infrastructure, and none of it is about
> > the SRAM.
> >
> > I would send it after this one, with the SRAM as the second user, and drop
> > the manual unbind from the tests there, where the change can be seen for what
> > it is.
> >
> > If this is okay for you?

Yes that sounds good, sorry for the late reply.

>
> Gentle ping?
>
> I wait with v3 because Stefan was on holiday (added to cc), as Stefan can
> test v3. If all work fine, I can send v3 ... currently state is without your
> above comment...
>

[..]


Regards,
Simon
