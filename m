Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A085CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CCD040052;
	Wed, 14 Oct 2026 16:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUhL7McMAl1p; Wed, 14 Oct 2026 16:20:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4BE84076B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791994856;
	b=mK7lj41R/L9J3ByMgMMNm0BFRDmAt4uJ/LGr4l8IJTYk3SoxYarUKzj2lgNCNKVJJJ4S
	 WHz4aPONndEgEjnFMH6OloJehwd+go9z2Lt5hAoz7/aSZb0IlTRynoBAHRZDvuCVLi4At
	 SB1eGP9vUUZ5Q/kUI0H3vELTu+3U5aDO4XIfl0kakez7SnY8UaMwjZaMRDvcBNGFEViGy
	 LnrcBnT4nj/+64h7uLHl5TOhQNqNmGX0ultLN4E2hJotFE0qTBMeWA1LoeTJRVcAMJfdS
	 VE1qUtboKMvr0ozjTHodaCHYPMHD6ogMh2V43ZQ+h3Xvy/5CXM8k2PsIZA5a/AGxCXg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aglgaj3Y17zbjlLsGKodaCFd5t7Dn7IAblcT+NM6aE4=;
	b=Q6j2fy2oLa1I1qkYQjWN8j/upXosrwg+xNUCammGDv1LWQr9l6L/1+SS12a0J3UEIaHq
	 C42NBMdzF5m+DYKFacPcj4Ma7/KDvIAZVWK8kLxKi+0jY1YkpHrXUWcsNEsRNJLlF+kVd
	 ksYs7iI/ue+qZO+mTbcmlXCfl+pR1jJgr+DhRIowZLhab9mNunahdVUMgUp2Y56IOoPiS
	 0YpalcJsljQdvllEpKZnG8aNKcWnO6p3GQw51prI5sm0inYZV1Gjf8fEHVW/d7oBuKLg4
	 NKn24XDAvCScMblOMVA3kTgOOorzhAPqacUk9CRcP1DrtP/rBZYMBwfktqVnN4dR7SQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=binarly.io;
	dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256 header.s=google header.b=C0covTPc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994856;
	bh=aglgaj3Y17zbjlLsGKodaCFd5t7Dn7IAblcT+NM6aE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EO7S/WjTBCrCti8mKDjY5dDHLiAjCfD+Y7oIX2IkXmhWd030NVqhgVo+E5bJoYu2/
	 K1kEiMUT5pDcHRTlCzPHvUcsngo8dx+qgeSpSZBgWHP1xIwBm3JmmkOYpHNcJQfRbv
	 SqHqsE14foqXTrCUnqYyZ4zIDlRsZN6gCz+4lzQMUsMLfAxNY9GZ4rEcdnVPyhRsiQ
	 WrC9RzxPh/HRwuRs8pPA0bjnuDX8EZrXAcKI8mLvUzznSHxC0JBk7s6EY/6AtohxUR
	 bSVP7F+UA7e95ow43vbYMjZqNjDcIE38NzTjDypjrC6uUbLNP1l+7Lfcpim1TmXUMg
	 udqGkch74BfUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4BE84076B;
	Wed, 14 Oct 2026 16:20:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD69D769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF228406D4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53n7ecniTQy9 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B076406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791994628;
 b=pHGt/U+PAtEPX7ev515pYJngDtI6Hen8VHvj02uMEBU160N4t9qgfY2n4SzVjafHkKO4
 TwH4C3kEzj9n1YB7Yt7Wq4YaQ9kT8IMBpLd6DlOmHLgQsJk3a6/nhggFuguEB5avaZJjD
 E0SO9aicSAC+ZOXl7GkYdbuQbTlRfqlHwnJp4BwfyDe0Y3AD5TykoRMTd9r/RED/aWfTH
 wOL49cHILGjPhP7+Kok1vB6r9ZAVSGuck6QeVipR1w7x0xvCmjZ4Lh8bdN5NONOw4cr2J
 1iAi1LnO9NMD8uSrQmW3b4jPObO4106Tlv/eiiNRovY8zEEcm1e399xZ4MMbxDUhhhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994628;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=aglgaj3Y17zbjlLsGKodaCFd5t7Dn7IAblcT+NM6aE4=;
 b=CgZ8O/6Yc5G/EN+7ii7GJW/j4X9+QnK0kHgyDO4woJmEkeHwAgZAxbBONCT3age1p8ki
 wPqLTH7hn7cZ8VJ4ifqg/dyVQBC9/oy+IzipzImPZOypAJpTG0+EN7hICUdA2uH+qOfwh
 ChYx4gUBI+4vHXTTTZyif787hqhjBdd+oqBcpv7EA/IGHQik0z3U0ihS4fjmTcrhgfxBi
 EWF1Rbvz/ieLRWoVrGDtUm4JEzwDyx/2zz2w8ns9Qtltnz9BFfnhMwsv8M1jpOQvaYQmF
 BCLinFWln6WRLKX/Cwx8E421aAWT+ebJXoP5ksk/nZ4Dw2LtLTBLr4sqhdW2QDGintA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=binarly.io;
 dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=C0covTPc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=C0covTPc
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B076406C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:17:07 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6ddef424972so852629eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791994626; cv=none;
 d=google.com; s=arc-20260327;
 b=pGivyhHK+2X8A4ff55puKqkTPXcFZzHL5Qy8srs+nI5jTXJctCJvM6ybenifpVHOEO
 9N4v+oTG9fUgiVcNn5r4GcWDkIGnqSyDYeEkq57h6ySux6Kqn7H+yrixeY74XCsbi/2D
 R6ginJc8jAzMHrnfxBXqUjv3JMQlOJJ+r6Zx05ACCuy9ByBnkCE5fhR+VaLQitir18h3
 K1BCOfliLKUvxhmLEkdZsrmCcJ7d8yyZ9ORh2JcvemByTx3XWk3cqHOKfqfLVs3RtpIY
 DuKbpaT4dc88N8LAw5I9QPIlDGYhhoPqiPYrzYAE2XBy9c131pPDwToKTVcoYBsFyVps
 OjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aglgaj3Y17zbjlLsGKodaCFd5t7Dn7IAblcT+NM6aE4=;
 fh=MJRGjmfUzsq5bn6Oca7figrzk8E6TpfWbTl2pvsQAEk=;
 b=XNXHWEe5pyr3rKaHUR7nh7ArYcr6PsKak7pI3x0mnOJzHRKX+OVE1HIt9PLvpOTt8K
 Z01EGuH1p9vGfGwYtG1k6a/QKBoDrD8oT+gMj4fhlz1ffmbOZMW4TBHHUx0wvIU1od0d
 mQ0/4NO7otNa0+J6XCR0ZcB6CQX1rUzAAAskIGqbaKT5jsH+bkc2fssxyDVGu0gMGaG5
 F/uGgHfmNAItYJBQ+vbcV5IuUhLi8d85zQbxpaszcxssC9QUQEEGTQGMNSNRywlI6YuX
 XEKC1LhF+q6L0fFSZqfnF4rj4H5sb0QX/fD+Fv4sWgXf+ROdLvb67Gfve+3VCw0s3USe
 EJPw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1791994626; x=1792599426;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aglgaj3Y17zbjlLsGKodaCFd5t7Dn7IAblcT+NM6aE4=;
 b=C0covTPc/MhfumvYuvCyx6JhxN0PKvV6sElFGY2fiTVz5HXfvstmC02gAqTXfd9237
 Hwcj/7Vi9CDidx+E6OqqMvfaKcyDtodlgZ1wDg0sVZNiNWRqQdDVHqjyOLS6vSWmkWkm
 K/CtyCRIELqPwh93Il02MUcOADFZWOmQFhbsCBNOcNqeDsxFm221n/lE5RJ4MPFNuLyJ
 32YGnWypdT8GrzgpqQZv71YvfHKsWL0wjr4NXvTg+j6pLC9O1zH5ELZJd6abhoncVsRB
 o/i8Gay3oL/yTEW/8J6i347fqjTzKsZ4JCRwMQ4C5C/WNgiyVyzs0/CFyrnWd639Aw2O
 fJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994626; x=1792599426;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aglgaj3Y17zbjlLsGKodaCFd5t7Dn7IAblcT+NM6aE4=;
 b=HMLpGsWQrbzcpTjVkuDXyxil3AuVKO17wjz/oL6sRU6olF/NNpfcN/H1xpKhZmHm5C
 spECDIS4Luo822MYm+s0X0zRbwGGuwUA6aurpwX+zbZM41+SwMDs2SAEDf/7whTl2O4r
 Xe6CUsvqNq65tTJCMl5jUjD5Cr3kHIQn0glpGto1fhBK7zbLG03hxnQzdUIegsg1ihyh
 2cmANDgRqd7AmDidQDRcr4PkO2w7lwKbjPR/qQ4GQgq1LZqqtc0sGlFrqM+4bwRxpbKg
 1Y0eN7qfoahXj81rJjgYVV0HMtLGUKgN796j8oI9BL3dESospa8WEGGYH5lq9Ng89+lS
 b5vg==
X-Gm-Message-State: AFq9FYLE5NxzrBOdwUngPq49FXbH0D8RSeFzJ0iiq5PcuNi7iYcP+/cS
 uwlf7SN6R6sG/e2E4LJq0ARAZ1f59eBycFises5pRQEJEak5kynZ/lOGpcDVZQmmW10xjxDUbt8
 EtNH6YDJA4rdvs2+1oEwg3j/On4WJ/SYtrHvXpVk9fg==
X-Gm-Gg: AYBFou3W1NCZvyzPB8vmskOBkTq7mPoPjKKGeOLqwp32srDWwaasNcDUI2cDWV7Eqsq
 Jjew2k7MYBQRF4jyshAaFWKWsoWOMXqaDTnCS62/NZDkUf7YaqLUgw6M4XMNy/8PQ3PjglapsIc
 xFBts3nt/9r9DtyHPahaeqP4VDvoKhX4pEWDR9y9dlYuXHhNFqZuiauVNU3tcZQc03YUXInBJyO
 ZsOD4g7RE2MPM7DpdGmrRir+FZPM2v1N8r1eYOQR8YJySnHwJVlTAQN+klcczBSIKwHixMl6qTi
 gu9eyTbPSek6lzwN8qV5GyHKOxEkRZxB2VM9EM1x+RBb5Ejksyr9xWK2wqgrN51wIg==
X-Received: by 2002:a05:6820:1992:b0:6d7:4942:85c1 with SMTP id
 006d021491bc7-6ef0d22d3c6mr13753754eaf.17.1791994626218; Wed, 14 Oct 2026
 09:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
 <20260902-b4-fit-ext-data-hardening-v4-3-a884a5de96ea__14255.2231832937$1788386356$gmane$org@binarly.io>
 <f9aa30050d6700625bcd0ca9c54bfe2ceabe3572.camel@ziswiler.com>
In-Reply-To: <f9aa30050d6700625bcd0ca9c54bfe2ceabe3572.camel@ziswiler.com>
From: Anton Ivanov <anton@binarly.io>
Date: Wed, 14 Oct 2026 17:16:54 +0100
X-Gm-Features: AclHuK9DCp4JCjZfA8s_1hYwu4xUCrRCQlMcfgEhjeLlEb-aCfWacasiNmjUb9o
Message-ID: <CAPWaX568qWb43s+F51_dt=C2-+hUEH2UkPJWK-rsf8vTJvC7-g@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v4 3/4] spl: fit: Harden external-data
 offset and size arithmetic
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla <francesco@valla.it>, 
 Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 Binarly Research <vr@binarly.io>
Content-Type: multipart/alternative; boundary="00000000000022adc5065dcf43b7"
X-Mailman-Approved-At: Wed, 14 Oct 2026 16:20:55 +0000
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

--00000000000022adc5065dcf43b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Your commit reverted two patches related to the hardening of FIT external
data processing for SPL:
  [PATCH v4 3/4] spl: fit: Harden external-data offset and size arithmetic
  [PATCH v4 4/4] spl: fit: Bound external data like U-Boot proper

For this board, the binman FIT uses embedded data only, so the hardened
external-data code is never reached in `load_simple_fit()`. The only
path that is changed and runs from `spl_simple_fit_read()` is
`get_aligned_image_size()`, and with `bl_len=3D1` (SPL RAM boot), it
cannot fail. I tried to reproduce the issue on the emulated hardware,
but I couldn't make it hang as you described. I suspect there is a
layout issue with the hardware itself, so I would perform a debugging
using the device as the next step.

Thank you,
Anton


On Sat, Oct 10, 2026 at 8:55=E2=80=AFPM Marcel Ziswiler <marcel@ziswiler.co=
m> wrote:

> Hi Anton, et. al.
>
> On Wed, 2026-09-02 at 22:23 +0100, Anton Ivanov wrote:
> > The data-offset, data-position and data-size FIT properties are
> > excluded from the configuration signature, so they are attacker
> > controlled even when signature verification succeeds. The offset and
> > size arithmetic in load_simple_fit() can wrap on hostile values:
> >
> >  - adding the external-data base offset to data-offset can wrap past
> >    UINT32_MAX,
> >  - get_aligned_image_size() adds the block-alignment overhead and
> >    rounds up to the block length, which can wrap past ULONG_MAX,
> >  - adding the FIT's device offset to the aligned external-data offset
> >    can wrap past ULONG_MAX.
> >
> > Make get_aligned_image_size() return the aligned size through an out
> > parameter and fail with -EOVERFLOW when the computation would wrap,
> > check the two offset additions explicitly, and compare the
> > block-aligned size (the amount info->read() actually transfers)
> > against max_size before reading. Do the same for the FIT header read
> > in spl_simple_fit_read().
>
> I bisected this commit to regress on the LicheePi 4A in the sense that th=
e
> SPL is no longer able to
> load/execute OpenSBI/U-Boot proper:
>
> U-Boot SPL 2026.10 (Oct 10 2026 - 21:45:55 +0200)
> Trying to boot from RAM
> =3D> hangs
>
> My fix reverting this and a second patch [1] got accepted in meta-riscv,
> see:
>
> https://github.com/riscv/meta-riscv/pull/711
>
> Before I dig deeper, I would welcome any insight anybody could have.
> Thanks!
>
> Cheers
>
> Marcel
>
> [1] https://lore.kernel.org/all/20260421075439.16696-6-ravi@prevas.dk
>
> > Signed-off-by: Anton Ivanov <anton@binarly.io>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > ---
> > Changed since v3: the new diagnostics use log_debug() instead of
> > printf(), which compiles out in a non-debug SPL build.
> >
> > Code size, from buildman -S in the u-boot-gitlab-ci-runner container
> > (gcc 14.2.0). The 413 boards that build spl_fit.c cover seven
> > combinations of CONFIG_SPL_LOAD_BLOCK (BLK), CONFIG_SPL_FIT_SIGNATURE
> > (SIG) and bitness, one board each below. SPL only; U-Boot proper is
> > unchanged:
> >
> >   BLK SIG bit  board                      text  rodata  data    all
> >    y   n   32  am335x_evm                  +24     -49    -4    -29
> >    y   y   32  firefly-rk3288              +20     -49     0    -29
> >    n   n   32  am335x_evm_spiboot           +4     -49     0    -45
> >    n   y   32  evb-ast2600                  -8     -49     0    -57
> >    y   n   64  imx8mm_evk                  +16     -49     0    -33
> >    y   y   64  orangepi-5-ultra-rk3588     +28     -49     0    -21
> >    n   n   64  r8a779g0_whitehawk            0     -49     0    -49
> >
> > The rodata drop is the "FIT image too large" printf() this patch
> > removes.
> > ---
> >  common/spl/spl_fit.c  | 98
> +++++++++++++++++++++++++++++----------------------
> >  test/image/spl_load.c | 57 ++++++++++++++++++++++++++++++
> >  2 files changed, 112 insertions(+), 43 deletions(-)
> >
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index 9b16f91cc6f..65934674b6c 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -175,22 +175,32 @@ static int spl_fit_get_image_node(const struct
> spl_fit_info *ctx,
> >       return node;
> >  }
> >
> > -static int get_aligned_image_offset(struct spl_load_info *info, int
> offset)
> > +static u32 get_aligned_image_offset(struct spl_load_info *info, u32
> offset)
> >  {
> >       return ALIGN_DOWN(offset, spl_get_bl_len(info));
> >  }
> >
> > -static int get_aligned_image_overhead(struct spl_load_info *info, int
> offset)
> > +static u32 get_aligned_image_overhead(struct spl_load_info *info, u32
> offset)
> >  {
> >       return offset & (spl_get_bl_len(info) - 1);
> >  }
> >
> > -static int get_aligned_image_size(struct spl_load_info *info, int
> data_size,
> > -                               int offset)
> > +static int get_aligned_image_size(struct spl_load_info *info, ulong
> data_size,
> > +                               u32 offset, ulong *aligned_size)
> >  {
> > -     data_size =3D data_size + get_aligned_image_overhead(info, offset=
);
> > +     u32 overhead =3D get_aligned_image_overhead(info, offset);
> >
> > -     return ALIGN(data_size, spl_get_bl_len(info));
> > +     if (data_size > ULONG_MAX - overhead)
> > +             return -EOVERFLOW;
> > +     data_size +=3D overhead;
> > +
> > +     if (data_size > ULONG_MAX - (spl_get_bl_len(info) - 1))
> > +             return -EOVERFLOW;
> > +     data_size =3D ALIGN(data_size, spl_get_bl_len(info));
> > +
> > +     *aligned_size =3D data_size;
> > +
> > +     return 0;
> >  }
> >
> >  /**
> > @@ -223,17 +233,16 @@ static int load_simple_fit(struct spl_load_info
> *info, ulong fit_offset,
> >       ulong load_addr;
> >       void *load_ptr;
> >       void *src;
> > -     ulong overhead;
> >       uint8_t image_comp =3D -1, type =3D -1;
> >       const void *data;
> >       const void *fit =3D ctx->fit;
> >       bool external_data =3D false;
> > +     int ret;
> >
> >       log_debug("starting\n");
> >       if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &&
> >           xpl_get_phase(info) !=3D IH_PHASE_NONE) {
> >               enum image_phase_t phase;
> > -             int ret;
> >
> >               ret =3D fit_image_get_phase(fit, node, &phase);
> >               /* if the image is for any phase, let's use it */
> > @@ -273,13 +282,19 @@ static int load_simple_fit(struct spl_load_info
> *info, ulong fit_offset,
> >       if (!fit_image_get_data_position(fit, node, &offset)) {
> >               external_data =3D true;
> >       } else if (!fit_image_get_data_offset(fit, node, &offset)) {
> > -             log_debug("read offset %x =3D offset from fit %lx\n",
> > -                       offset, (ulong)offset + ctx->ext_data_offset);
> > +             /* The resulting offset cannot exceed UINT32_MAX */
> > +             if (ctx->ext_data_offset > UINT32_MAX - offset) {
> > +                     log_debug("Invalid external data offset: %u\n",
> offset);
> > +                     return -EINVAL;
> > +             }
> > +             log_debug("read offset %x =3D offset from fit %x\n", offs=
et,
> > +                       (u32)(offset + ctx->ext_data_offset));
> >               offset +=3D ctx->ext_data_offset;
> >               external_data =3D true;
> >       }
> >
> >       if (external_data) {
> > +             u32 aligned_offset;
> >               ulong read_offset;
> >               void *src_ptr;
> >
> > @@ -300,16 +315,26 @@ static int load_simple_fit(struct spl_load_info
> *info, ulong fit_offset,
> >                * controlled even after fit_config_verify() succeeds. Th=
e
> >                * image hash is only verified after the device read
> below, so
> >                * an oversized value has to be rejected here.
> > -              *
> > -              * Bail out before get_aligned_image_size() runs on a
> hostile
> > -              * len: that helper does its arithmetic in int and would
> > -              * invoke signed-integer overflow on a value close to or
> above
> > -              * INT_MAX. The block-aligned check further down is the
> > -              * mathematically binding one, since size is len rounded
> up to
> > -              * the device block length.
> >                */
> > -             if ((ulong)len > max_size)
> > -                     goto too_big;
> > +             ret =3D get_aligned_image_size(info, len, offset, &size);
> > +             if (ret) {
> > +                     log_debug("Invalid external data size: %u\n", len=
);
> > +                     return ret;
> > +             }
> > +
> > +             if (size > max_size) {
> > +                     log_debug("Image too large: aligned size %lu, max
> %lu (data-size %u)\n",
> > +                               size, max_size, len);
> > +                     return -EFBIG;
> > +             }
> > +
> > +             aligned_offset =3D get_aligned_image_offset(info, offset)=
;
> > +             if (aligned_offset > ULONG_MAX - fit_offset) {
> > +                     log_debug("Invalid aligned external data offset:
> %u\n",
> > +                               aligned_offset);
> > +                     return -EINVAL;
> > +             }
> > +             read_offset =3D fit_offset + aligned_offset;
> >
> >               if (spl_decompression_enabled() &&
> >                   (image_comp =3D=3D IH_COMP_GZIP || image_comp =3D=3D
> IH_COMP_LZMA))
> > @@ -318,19 +343,6 @@ static int load_simple_fit(struct spl_load_info
> *info, ulong fit_offset,
> >                       src_ptr =3D map_sysmem(ALIGN(load_addr,
> ARCH_DMA_MINALIGN), len);
> >               length =3D len;
> >
> > -             overhead =3D get_aligned_image_overhead(info, offset);
> > -             size =3D get_aligned_image_size(info, length, offset);
> > -             read_offset =3D fit_offset + get_aligned_image_offset(inf=
o,
> > -                                                         offset);
> > -
> > -             /*
> > -              * info->read() transfers the block-aligned size into the
> > -              * destination, so this is the bound that actually matter=
s;
> > -              * len was rejected above only to keep this computation
> safe.
> > -              */
> > -             if (size > max_size)
> > -                     goto too_big;
> > -
> >               log_debug("reading from offset %x / %lx size %lx to %p: "=
,
> >                         offset, read_offset, size, src_ptr);
> >
> > @@ -339,7 +351,7 @@ static int load_simple_fit(struct spl_load_info
> *info, ulong fit_offset,
> >
> >               debug("External data: dst=3D%p, offset=3D%x, size=3D%lx\n=
",
> >                     src_ptr, offset, (unsigned long)length);
> > -             src =3D src_ptr + overhead;
> > +             src =3D src_ptr + get_aligned_image_overhead(info, offset=
);
> >       } else {
> >               /* Embedded data */
> >               if (fit_image_get_emb_data(fit, node, &data, &length)) {
> > @@ -401,11 +413,6 @@ static int load_simple_fit(struct spl_load_info
> *info, ulong fit_offset,
> >       upl_add_image(fit, node, load_addr, length);
> >
> >       return 0;
> > -
> > -too_big:
> > -     printf("%s: FIT image too large (data-size %u, max %lu)\n",
> > -            __func__, (u32)len, max_size);
> > -     return -EFBIG;
> >  }
> >
> >  static bool os_takes_devicetree(uint8_t os)
> > @@ -737,8 +744,9 @@ static int spl_simple_fit_read(struct spl_fit_info
> *ctx,
> >                              struct spl_load_info *info, ulong offset,
> >                              const void *fit_header)
> >  {
> > -     unsigned long count, size;
> > +     unsigned long aligned_size, count, size;
> >       void *buf;
> > +     int ret;
> >
> >       /*
> >        * For FIT with external data, figure out where the external imag=
es
> > @@ -756,8 +764,12 @@ static int spl_simple_fit_read(struct spl_fit_info
> *ctx,
> >        * For FIT with data embedded, data is loaded as part of FIT imag=
e.
> >        * For FIT with external data, data is not loaded in this step.
> >        */
> > -     size =3D get_aligned_image_size(info, size, 0);
> > -     buf =3D board_spl_fit_buffer_addr(size, size, 1);
> > +     ret =3D get_aligned_image_size(info, size, 0, &aligned_size);
> > +     if (ret) {
> > +             log_debug("Invalid FIT size: %lu\n", size);
> > +             return ret;
> > +     }
> > +     buf =3D board_spl_fit_buffer_addr(aligned_size, aligned_size, 1);
> >       if (!buf) {
> >               /*
> >                * We assume that none of the board will ever use 0x0 as =
a
> > @@ -767,7 +779,7 @@ static int spl_simple_fit_read(struct spl_fit_info
> *ctx,
> >               return -EIO;
> >       }
> >
> > -     count =3D info->read(info, offset, size, buf);
> > +     count =3D info->read(info, offset, aligned_size, buf);
> >       if (!count) {
> >               /*
> >                * FIT could not be read. This means we should free the
> > @@ -800,7 +812,7 @@ static int spl_simple_fit_read(struct spl_fit_info
> *ctx,
> >
> >       ctx->fit =3D buf;
> >       debug("fit read offset %lx, size=3D%lu, dst=3D%p, count=3D%lu\n",
> > -           offset, size, buf, count);
> > +           offset, aligned_size, buf, count);
> >
> >       return 0;
> >  }
> > diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> > index 49bfce15c08..557362ba113 100644
> > --- a/test/image/spl_load.c
> > +++ b/test/image/spl_load.c
> > @@ -426,6 +426,63 @@ static int spl_test_fit_external_oversize(struct
> unit_test_state *uts)
> >  }
> >  SPL_TEST(spl_test_fit_external_oversize, 0);
> >
> > +/*
> > + * A data-offset which wraps past UINT32_MAX once the external-data ba=
se
> > + * offset is added must be rejected before it is used as a read offset=
.
> > + */
> > +static int spl_test_fit_data_offset_overflow(struct unit_test_state
> *uts)
> > +{
> > +     if (!image_supported(FIT_EXTERNAL))
> > +             return -EAGAIN;
> > +
> > +     return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0xffffffff, =
1,
> > +                               spl_test_read, 0, -EINVAL);
> > +}
> > +SPL_TEST(spl_test_fit_data_offset_overflow, 0);
> > +
> > +/*
> > + * A data-size whose block-aligned read size wraps past ULONG_MAX must
> be
> > + * rejected. Since data-size is a 32-bit property, the wrap is only
> reachable
> > + * when ulong is 32 bits wide, so skip the test on other targets.
> > + */
> > +static int spl_test_fit_data_size_overflow(struct unit_test_state *uts=
)
> > +{
> > +     if (!image_supported(FIT_EXTERNAL) || sizeof(ulong) !=3D 4)
> > +             return -EAGAIN;
> > +
> > +     return check_fit_ext_prop(uts, FIT_DATA_SIZE_PROP, 0xffffffff, 2,
> > +                               spl_test_read, 0, -EOVERFLOW);
> > +}
> > +SPL_TEST(spl_test_fit_data_size_overflow, 0);
> > +
> > +/* Device offset the reader pretends the FIT was loaded from */
> > +static ulong spl_test_fit_offset;
> > +
> > +static ulong spl_test_read_fit_offset(struct spl_load_info *load, ulon=
g
> sector,
> > +                                   ulong count, void *buf)
> > +{
> > +     return spl_test_read(load, sector - spl_test_fit_offset, count,
> buf);
> > +}
> > +
> > +/*
> > + * An aligned external-data offset which wraps past ULONG_MAX once the
> FIT's
> > + * offset on the device is added must be rejected before it is used as
> a read
> > + * offset.
> > + */
> > +static int spl_test_fit_read_offset_overflow(struct unit_test_state
> *uts)
> > +{
> > +     if (!image_supported(FIT_EXTERNAL))
> > +             return -EAGAIN;
> > +
> > +     /* So that ULONG_MAX - fit_offset < the aligned external-data
> offset */
> > +     spl_test_fit_offset =3D ULONG_MAX - 0xfff;
> > +
> > +     return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0x1000, 1,
> > +                               spl_test_read_fit_offset,
> spl_test_fit_offset,
> > +                               -EINVAL);
> > +}
> > +SPL_TEST(spl_test_fit_read_offset_overflow, 0);
> > +
> >  /*
> >   * LZMA is too complex to generate on the fly, so let's use some data =
I
> put in
> >   * the oven^H^H^H^H compressed earlier
>

--00000000000022adc5065dcf43b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Marcel,</div><div><br></div><div>Your commit =
reverted two patches related to the hardening of FIT external<br>data proce=
ssing for SPL:<br>=C2=A0 [PATCH v4 3/4] spl: fit: Harden external-data offs=
et and size arithmetic<br>=C2=A0 [PATCH v4 4/4] spl: fit: Bound external da=
ta like U-Boot proper<br><br>For this board, the binman FIT uses embedded d=
ata only, so the hardened<br>external-data code is never reached in `load_s=
imple_fit()`. The only<br>path that is changed and runs from `spl_simple_fi=
t_read()` is<br>`get_aligned_image_size()`, and with `bl_len=3D1` (SPL RAM =
boot), it<br>cannot fail. I tried to reproduce the issue on the emulated ha=
rdware,<br>but I couldn&#39;t make it hang as you described. I suspect ther=
e is a<br>layout issue with the hardware itself, so I would perform a debug=
ging<br>using the device as the next step.</div><div><br></div><div><div di=
r=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div=
 dir=3D"ltr"><div style=3D"color:rgb(34,34,34)">Thank you,</div><div style=
=3D"color:rgb(34,34,34)">Anton</div></div></div></div><br></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Sat, Oct 10, 2026 at 8:55=E2=80=AFPM Marcel Ziswiler &lt;<a href=3D=
"mailto:marcel@ziswiler.com">marcel@ziswiler.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi Anton, et. al.<br>
<br>
On Wed, 2026-09-02 at 22:23 +0100, Anton Ivanov wrote:<br>
&gt; The data-offset, data-position and data-size FIT properties are<br>
&gt; excluded from the configuration signature, so they are attacker<br>
&gt; controlled even when signature verification succeeds. The offset and<b=
r>
&gt; size arithmetic in load_simple_fit() can wrap on hostile values:<br>
&gt; <br>
&gt; =C2=A0- adding the external-data base offset to data-offset can wrap p=
ast<br>
&gt; =C2=A0=C2=A0 UINT32_MAX,<br>
&gt; =C2=A0- get_aligned_image_size() adds the block-alignment overhead and=
<br>
&gt; =C2=A0=C2=A0 rounds up to the block length, which can wrap past ULONG_=
MAX,<br>
&gt; =C2=A0- adding the FIT&#39;s device offset to the aligned external-dat=
a offset<br>
&gt; =C2=A0=C2=A0 can wrap past ULONG_MAX.<br>
&gt; <br>
&gt; Make get_aligned_image_size() return the aligned size through an out<b=
r>
&gt; parameter and fail with -EOVERFLOW when the computation would wrap,<br=
>
&gt; check the two offset additions explicitly, and compare the<br>
&gt; block-aligned size (the amount info-&gt;read() actually transfers)<br>
&gt; against max_size before reading. Do the same for the FIT header read<b=
r>
&gt; in spl_simple_fit_read().<br>
<br>
I bisected this commit to regress on the LicheePi 4A in the sense that the =
SPL is no longer able to<br>
load/execute OpenSBI/U-Boot proper:<br>
<br>
U-Boot SPL 2026.10 (Oct 10 2026 - 21:45:55 +0200)<br>
Trying to boot from RAM<br>
=3D&gt; hangs<br>
<br>
My fix reverting this and a second patch [1] got accepted in meta-riscv, se=
e:<br>
<br>
<a href=3D"https://github.com/riscv/meta-riscv/pull/711" rel=3D"noreferrer"=
 target=3D"_blank">https://github.com/riscv/meta-riscv/pull/711</a><br>
<br>
Before I dig deeper, I would welcome any insight anybody could have. Thanks=
!<br>
<br>
Cheers<br>
<br>
Marcel<br>
<br>
[1] <a href=3D"https://lore.kernel.org/all/20260421075439.16696-6-ravi@prev=
as.dk" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/all/202=
60421075439.16696-6-ravi@prevas.dk</a><br>
<br>
&gt; Signed-off-by: Anton Ivanov &lt;<a href=3D"mailto:anton@binarly.io" ta=
rget=3D"_blank">anton@binarly.io</a>&gt;<br>
&gt; Reviewed-by: Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" targe=
t=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; Changed since v3: the new diagnostics use log_debug() instead of<br>
&gt; printf(), which compiles out in a non-debug SPL build.<br>
&gt; <br>
&gt; Code size, from buildman -S in the u-boot-gitlab-ci-runner container<b=
r>
&gt; (gcc 14.2.0). The 413 boards that build spl_fit.c cover seven<br>
&gt; combinations of CONFIG_SPL_LOAD_BLOCK (BLK), CONFIG_SPL_FIT_SIGNATURE<=
br>
&gt; (SIG) and bitness, one board each below. SPL only; U-Boot proper is<br=
>
&gt; unchanged:<br>
&gt; <br>
&gt; =C2=A0 BLK SIG bit=C2=A0 board=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 text=C2=A0 rodata=C2=A0 data=C2=A0=C2=A0=C2=A0 all<br>
&gt; =C2=A0=C2=A0 y=C2=A0=C2=A0 n=C2=A0=C2=A0 32=C2=A0 am335x_evm=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +24=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0 -4=C2=
=A0=C2=A0=C2=A0 -29<br>
&gt; =C2=A0=C2=A0 y=C2=A0=C2=A0 y=C2=A0=C2=A0 32=C2=A0 firefly-rk3288=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2=
0=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 -=
29<br>
&gt; =C2=A0=C2=A0 n=C2=A0=C2=A0 n=C2=A0=C2=A0 32=C2=A0 am335x_evm_spiboot=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +4=C2=A0=C2=A0=
=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 -45<br>
&gt; =C2=A0=C2=A0 n=C2=A0=C2=A0 y=C2=A0=C2=A0 32=C2=A0 evb-ast2600=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -8=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 -57<br>
&gt; =C2=A0=C2=A0 y=C2=A0=C2=A0 n=C2=A0=C2=A0 64=C2=A0 imx8mm_evk=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +16=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 =
0=C2=A0=C2=A0=C2=A0 -33<br>
&gt; =C2=A0=C2=A0 y=C2=A0=C2=A0 y=C2=A0=C2=A0 64=C2=A0 orangepi-5-ultra-rk3=
588=C2=A0=C2=A0=C2=A0=C2=A0 +28=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 -21<br>
&gt; =C2=A0=C2=A0 n=C2=A0=C2=A0 n=C2=A0=C2=A0 64=C2=A0 r8a779g0_whitehawk=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 -49<br>
&gt; <br>
&gt; The rodata drop is the &quot;FIT image too large&quot; printf() this p=
atch<br>
&gt; removes.<br>
&gt; ---<br>
&gt; =C2=A0common/spl/spl_fit.c=C2=A0 | 98 +++++++++++++++++++++++++++++---=
-------------------<br>
&gt; =C2=A0test/image/spl_load.c | 57 ++++++++++++++++++++++++++++++<br>
&gt; =C2=A02 files changed, 112 insertions(+), 43 deletions(-)<br>
&gt; <br>
&gt; diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c<br>
&gt; index 9b16f91cc6f..65934674b6c 100644<br>
&gt; --- a/common/spl/spl_fit.c<br>
&gt; +++ b/common/spl/spl_fit.c<br>
&gt; @@ -175,22 +175,32 @@ static int spl_fit_get_image_node(const struct s=
pl_fit_info *ctx,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return node;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -static int get_aligned_image_offset(struct spl_load_info *info, int o=
ffset)<br>
&gt; +static u32 get_aligned_image_offset(struct spl_load_info *info, u32 o=
ffset)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return ALIGN_DOWN(offset, spl_get_bl_len(inf=
o));<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -static int get_aligned_image_overhead(struct spl_load_info *info, int=
 offset)<br>
&gt; +static u32 get_aligned_image_overhead(struct spl_load_info *info, u32=
 offset)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return offset &amp; (spl_get_bl_len(info) - =
1);<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -static int get_aligned_image_size(struct spl_load_info *info, int dat=
a_size,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 int offset)<br>
&gt; +static int get_aligned_image_size(struct spl_load_info *info, ulong d=
ata_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 u32 offset, ulong *aligned_size)<=
br>
&gt; =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0data_size =3D data_size + get_aligned_image_overh=
ead(info, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 overhead =3D get_aligned_image_overhead(info,=
 offset);<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return ALIGN(data_size, spl_get_bl_len(info));<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (data_size &gt; ULONG_MAX - overhead)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOVERFLOW;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0data_size +=3D overhead;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (data_size &gt; ULONG_MAX - (spl_get_bl_len(in=
fo) - 1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOVERFLOW;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0data_size =3D ALIGN(data_size, spl_get_bl_len(inf=
o));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*aligned_size =3D data_size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0/**<br>
&gt; @@ -223,17 +233,16 @@ static int load_simple_fit(struct spl_load_info =
*info, ulong fit_offset,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0ulong load_addr;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0void *load_ptr;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0void *src;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ulong overhead;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0uint8_t image_comp =3D -1, type =3D -1;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const void *data;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const void *fit =3D ctx-&gt;fit;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool external_data =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0log_debug(&quot;starting\n&quot;);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &amp;&am=
p;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 xpl_get_phase(info) !=3D =
IH_PHASE_NONE) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum image_phase=
_t phase;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D fit_imag=
e_get_phase(fit, node, &amp;phase);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if the image =
is for any phase, let&#39;s use it */<br>
&gt; @@ -273,13 +282,19 @@ static int load_simple_fit(struct spl_load_info =
*info, ulong fit_offset,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (!fit_image_get_data_position(fit, node, =
&amp;offset)) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0external_data =
=3D true;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0} else if (!fit_image_get_data_offset(fit, n=
ode, &amp;offset)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_debug(&quot;read =
offset %x =3D offset from fit %lx\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 offset, (ulong)offset + ctx-&gt;ext_data_offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The resulting offs=
et cannot exceed UINT32_MAX */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctx-&gt;ext_data_=
offset &gt; UINT32_MAX - offset) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0log_debug(&quot;Invalid external data offset: %u\n&quot;, offset);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_debug(&quot;read =
offset %x =3D offset from fit %x\n&quot;, offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 (u32)(offset + ctx-&gt;ext_data_offset));<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset +=3D ctx-=
&gt;ext_data_offset;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0external_data =
=3D true;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (external_data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 aligned_offset;<b=
r>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ulong read_offse=
t;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *src_ptr;<b=
r>
&gt; =C2=A0<br>
&gt; @@ -300,16 +315,26 @@ static int load_simple_fit(struct spl_load_info =
*info, ulong fit_offset,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * controlled ev=
en after fit_config_verify() succeeds. The<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * image hash is=
 only verified after the device read below, so<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * an oversized =
value has to be rejected here.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Bail out before ge=
t_aligned_image_size() runs on a hostile<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * len: that helper d=
oes its arithmetic in int and would<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * invoke signed-inte=
ger overflow on a value close to or above<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * INT_MAX. The block=
-aligned check further down is the<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * mathematically bin=
ding one, since size is len rounded up to<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the device block l=
ength.<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ulong)len &gt; m=
ax_size)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto too_big;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D get_aligned_i=
mage_size(info, len, offset, &amp;size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0log_debug(&quot;Invalid external data size: %u\n&quot;, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &gt; max_siz=
e) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0log_debug(&quot;Image too large: aligned size %lu, max %lu (data-siz=
e %u)\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 size, max_size, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EFBIG;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aligned_offset =3D ge=
t_aligned_image_offset(info, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (aligned_offset &g=
t; ULONG_MAX - fit_offset) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0log_debug(&quot;Invalid aligned external data offset: %u\n&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 aligned_offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_offset =3D fit_o=
ffset + aligned_offset;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spl_decompre=
ssion_enabled() &amp;&amp;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0 (image_comp =3D=3D IH_COMP_GZIP || image_comp =3D=3D IH_COMP_LZMA))<br>
&gt; @@ -318,19 +343,6 @@ static int load_simple_fit(struct spl_load_info *=
info, ulong fit_offset,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0src_ptr =3D map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), le=
n);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0length =3D len;<=
br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0overhead =3D get_alig=
ned_image_overhead(info, offset);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D get_aligned_=
image_size(info, length, offset);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_offset =3D fit_o=
ffset + get_aligned_image_offset(info,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 offset);<br=
>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * info-&gt;read() tr=
ansfers the block-aligned size into the<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * destination, so th=
is is the bound that actually matters;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * len was rejected a=
bove only to keep this computation safe.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &gt; max_siz=
e)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto too_big;<br>
&gt; -<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_debug(&quot;=
reading from offset %x / %lx size %lx to %p: &quot;,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0 offset, read_offset, size, src_ptr);<br>
&gt; =C2=A0<br>
&gt; @@ -339,7 +351,7 @@ static int load_simple_fit(struct spl_load_info *i=
nfo, ulong fit_offset,<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;Exte=
rnal data: dst=3D%p, offset=3D%x, size=3D%lx\n&quot;,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 src_ptr, offset, (unsigned long)length);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =3D src_ptr + ove=
rhead;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =3D src_ptr + get=
_aligned_image_overhead(info, offset);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Embedded data=
 */<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fit_image_ge=
t_emb_data(fit, node, &amp;data, &amp;length)) {<br>
&gt; @@ -401,11 +413,6 @@ static int load_simple_fit(struct spl_load_info *=
info, ulong fit_offset,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0upl_add_image(fit, node, load_addr, length);=
<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -<br>
&gt; -too_big:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0printf(&quot;%s: FIT image too large (data-size %=
u, max %lu)\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, (u=
32)len, max_size);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return -EFBIG;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0static bool os_takes_devicetree(uint8_t os)<br>
&gt; @@ -737,8 +744,9 @@ static int spl_simple_fit_read(struct spl_fit_info=
 *ctx,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spl_load_info *inf=
o, ulong offset,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *fit_header)<b=
r>
&gt; =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned long count, size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long aligned_size, count, size;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0void *buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 * For FIT with external data, figure out wh=
ere the external images<br>
&gt; @@ -756,8 +764,12 @@ static int spl_simple_fit_read(struct spl_fit_inf=
o *ctx,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 * For FIT with data embedded, data is loade=
d as part of FIT image.<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 * For FIT with external data, data is not l=
oaded in this step.<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0size =3D get_aligned_image_size(info, size, 0);<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0buf =3D board_spl_fit_buffer_addr(size, size, 1);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D get_aligned_image_size(info, size, 0, &am=
p;aligned_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_debug(&quot;Inval=
id FIT size: %lu\n&quot;, size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf =3D board_spl_fit_buffer_addr(aligned_size, a=
ligned_size, 1);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (!buf) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We assume tha=
t none of the board will ever use 0x0 as a<br>
&gt; @@ -767,7 +779,7 @@ static int spl_simple_fit_read(struct spl_fit_info=
 *ctx,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0count =3D info-&gt;read(info, offset, size, buf);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0count =3D info-&gt;read(info, offset, aligned_siz=
e, buf);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (!count) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * FIT could not=
 be read. This means we should free the<br>
&gt; @@ -800,7 +812,7 @@ static int spl_simple_fit_read(struct spl_fit_info=
 *ctx,<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0ctx-&gt;fit =3D buf;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0debug(&quot;fit read offset %lx, size=3D%lu,=
 dst=3D%p, count=3D%lu\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, size, buf,=
 count);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, aligned_si=
ze, buf, count);<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; =C2=A0}<br>
&gt; diff --git a/test/image/spl_load.c b/test/image/spl_load.c<br>
&gt; index 49bfce15c08..557362ba113 100644<br>
&gt; --- a/test/image/spl_load.c<br>
&gt; +++ b/test/image/spl_load.c<br>
&gt; @@ -426,6 +426,63 @@ static int spl_test_fit_external_oversize(struct =
unit_test_state *uts)<br>
&gt; =C2=A0}<br>
&gt; =C2=A0SPL_TEST(spl_test_fit_external_oversize, 0);<br>
&gt; =C2=A0<br>
&gt; +/*<br>
&gt; + * A data-offset which wraps past UINT32_MAX once the external-data b=
ase<br>
&gt; + * offset is added must be rejected before it is used as a read offse=
t.<br>
&gt; + */<br>
&gt; +static int spl_test_fit_data_offset_overflow(struct unit_test_state *=
uts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!image_supported(FIT_EXTERNAL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EAGAIN;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PR=
OP, 0xffffffff, 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 spl_test_read, 0, -EINVAL);<br>
&gt; +}<br>
&gt; +SPL_TEST(spl_test_fit_data_offset_overflow, 0);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * A data-size whose block-aligned read size wraps past ULONG_MAX mus=
t be<br>
&gt; + * rejected. Since data-size is a 32-bit property, the wrap is only r=
eachable<br>
&gt; + * when ulong is 32 bits wide, so skip the test on other targets.<br>
&gt; + */<br>
&gt; +static int spl_test_fit_data_size_overflow(struct unit_test_state *ut=
s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!image_supported(FIT_EXTERNAL) || sizeof(ulon=
g) !=3D 4)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EAGAIN;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return check_fit_ext_prop(uts, FIT_DATA_SIZE_PROP=
, 0xffffffff, 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 spl_test_read, 0, -EOVERFLOW);<br=
>
&gt; +}<br>
&gt; +SPL_TEST(spl_test_fit_data_size_overflow, 0);<br>
&gt; +<br>
&gt; +/* Device offset the reader pretends the FIT was loaded from */<br>
&gt; +static ulong spl_test_fit_offset;<br>
&gt; +<br>
&gt; +static ulong spl_test_read_fit_offset(struct spl_load_info *load, ulo=
ng sector,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ulong cou=
nt, void *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return spl_test_read(load, sector - spl_test_fit_=
offset, count, buf);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * An aligned external-data offset which wraps past ULONG_MAX once th=
e FIT&#39;s<br>
&gt; + * offset on the device is added must be rejected before it is used a=
s a read<br>
&gt; + * offset.<br>
&gt; + */<br>
&gt; +static int spl_test_fit_read_offset_overflow(struct unit_test_state *=
uts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!image_supported(FIT_EXTERNAL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EAGAIN;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* So that ULONG_MAX - fit_offset &lt; the aligne=
d external-data offset */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spl_test_fit_offset =3D ULONG_MAX - 0xfff;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PR=
OP, 0x1000, 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 spl_test_read_fit_offset, spl_tes=
t_fit_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 -EINVAL);<br>
&gt; +}<br>
&gt; +SPL_TEST(spl_test_fit_read_offset_overflow, 0);<br>
&gt; +<br>
&gt; =C2=A0/*<br>
&gt; =C2=A0 * LZMA is too complex to generate on the fly, so let&#39;s use =
some data I put in<br>
&gt; =C2=A0 * the oven^H^H^H^H compressed earlier<br>
</blockquote></div>

--00000000000022adc5065dcf43b7--
