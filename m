Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F9606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qweIy9bU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CMMxrU9C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA11E40A89;
	Sat, 31 Oct 2026 13:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id exJV5m8lFk9L; Sat, 31 Oct 2026 13:59:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D293540A72
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455191;
	b=n3AtTOhVApicqmwohqEHx8+dIsCmWwiZbERZde7bgCdAjLtw/E835Vq2VFVIWIBaJBSi
	 4c6jUdpYu9B9XsMdAiKy0Unc5lrIM9XP7GOZc218HD0tUpzCYwxuRx2694LZfTxbEPlLR
	 ELfZ5ImRvIPTl5s5hYw2i9cxXohw+WRgkZDZJS+1kX676VOWJX/Xzv+ddIb8xSCe5wDDg
	 ZdIFBsy3LbWlSyjP+yGssj4objvRJWmLRP4HnFnTFxxCoNQ0B4GMNykKVkOA3ewDIBzJk
	 9l4ZvWTzFJ5m0F+M2lODLGdX7dGMx3FGhhSfOJDzNcwaAnu2Hf+V5ZqtuFLRVXLl2yw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TYjLD8duH/kzryFwDK8Slo0MIdJUBgA1jVnoPpOkxEU=;
	b=lImOydCtiNsFhiMGX8lIlRS4KC1LWh/VuA8vH8OWGL7qxOmrfRoPH1PTi9OXc5pMr5Sr
	 EDLc4qUrHtZTBJohNtTfpC9P2nSmzLHvilpdEMF0RYHdX7YhmGoL+4uwyg3TuprL7iZk8
	 eV8bPQ6DvQae7/j5iu2abegWDMsQydWzWmFK0MrLb8GdB3FkBjs5rfKk7BtnplVo4jEFq
	 6D+DjqzPb+O0YJDgqOkXr9nEh8nvlUO/QiUmgqBl4m5Aq/okXaRRuEbP+7F9cVX0cp3fw
	 VEMDwOfVxcR8IfFfVh1GHAJMgy19PKIM1pqKhON/OsOEclT2wp/mUQxgCkocDoMkFeg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455191;
	bh=TYjLD8duH/kzryFwDK8Slo0MIdJUBgA1jVnoPpOkxEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qweIy9bUeeXMZBrokYSfKcb43qXU95CeMlN2GBDRcgd5e66JuNf4zCVBTWbqZW4Kg
	 RFd52IfyGFL8JIqirax5GlY7yWeuKihYj3tPvZ7gkqxExPa3rKYN8nzhfiGtB1elx6
	 yiD56cF9LYDYsN63HoZml4tYWbQoVxxg/Fss2mqbkdHDaJxv5MbSi/unpJiPf3wBMt
	 UrZz3jwbsp2QGe1b8OrazJU/o+n45E/icDoJoCB2l1L9HDa5wOyYk/vm4ZJDfDOc19
	 HfMrpC7S3CnxQaSixD/qbOA7q3ZkYZBPRsiCTsn5yygYY8NEmqGb+oP5isn+krexBd
	 HDy9QT33Yb8nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D293540A72;
	Sat, 31 Oct 2026 13:59:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A71902AC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 05:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C8DE60A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 05:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQZzhlHZKVbE for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 05:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8B9560A7E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793425227;
 b=nI9qGTSPkIzWvBVUj7e+h6+vpNg/qGhiIqZtUwXg3p38A82OdTQeqFhSeU54FVf3Uwun
 ObkBlqaYSvB3aUdtjXOKGwqjkXLUGc4WbbqjT2oviPZUwgP4SmxNiaBxsnSQ7ubqJFIN1
 w6ignGFjVJqZPlujW/XuZ9SYRATOgDF2xo17nfGIYiA2pBVOydID9oH4B4tbHeeiAvvFe
 +aqQeHazJvqQ4f4KiDjfQcEBzvewq+PZwvBpT2kZoveWgaY5Y6MDVj7/gBZf51DFqTF83
 hdiopIbX1DzAUEa6e/KbSq25CcApOdyHAjBiw2qW4YIBpWg0sFVZb56dVxXA0CPMpLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793425227;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=TYjLD8duH/kzryFwDK8Slo0MIdJUBgA1jVnoPpOkxEU=;
 b=ZKL1Dg/40kADwi9cpIlihwD9iojC6gGZIzHDcI5/A++rZJLufPyDj61VaiZ8WQFsx0+d
 lhvm2tT9ULpGrq3jTdQZ1b1S8iu6Lg0iG9TRaGaRKlrCN+ZT4ZbevllqrzlC5VqeDUeWZ
 sJQm8CLmsNYaYKGBACTF2hDGR8F+gyRZIUrtOm4ZxtGkHbffi55bCiLCYjOUVZVwP2mbg
 GtCBzzUjb/DIGFtTd4uH3eATpLbLzI5FrgdPROBPeMIBaDtuzTTDT9p3IbTs3dqEheDUP
 UxV8HFtzaQmuvDaxaquewTXSF1GCUYddmh9LE6JgrYvfoJFvEHMXDr4Xqxda+TCcaaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CMMxrU9C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CMMxrU9C
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8B9560A7E
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 05:40:26 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-675676afc3cso1454757d50.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 22:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793425225; cv=none;
 d=google.com; s=arc-20260327;
 b=BYFc2wfsLOgAULVOTW6JY5Uy40AO7kiBahUGq770moSJOAYh5cLfSS7eADctAAkmqo
 Bmmsg2rjlcbAr52/j0XdYW6B7fCVi0Uoi28xbtJF0DUyXFY2DD9P/IL5uRAo8V1d2evm
 UJeVKz/dGj3Anpd0WP9Y4Qj3Tb7V6XqxJYQbdMhFes0kEd0MYcx+AMXAudr0+MhMJ7PN
 qWvSq8BByWSnxn5R9VljKH7RpuCxyY9lfMso5lSf3ak2ushSuXkqrkXZm4NY57TP4tx2
 xebzwQeHPtGvzthvkq2OmlKA16y9eyualy5uEjyYsXs9d+BUIXl5HjmVje2848rczp2R
 VvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TYjLD8duH/kzryFwDK8Slo0MIdJUBgA1jVnoPpOkxEU=;
 fh=zUg+KdO3x/W1ixetcEdQcRpTYboUoOe2SubrUEwzSL4=;
 b=TTmagRqtcdP/5eg3KOEXkYVTBrwi1HLWQg+uHkYl0qz1ESfPYRr+1hScC2pCXN4xod
 WP2q9VjHQA6z4mW96sqkiluTL2K9WrDn9iwHxsc60bN4U8snq2gdFNh7aYGMmBMRiX5f
 VIOGNhuxNNeCJGKRLUTmJfCyvN8SMVVJ7zc5aqCyGlm+Yl2+7ZzfupAkePTieIxbOY3f
 /7ZyNGieIRmLnGWZPe4eHE9+mNGP7vj1UbkgsEcT3TMZkBAAdzEQpFJhBZjLpl77w3PZ
 jtwohWrbHCnPbq8NtUQrdSC7lP8fY7iVmi3LdSmkraDStBdAvGZ6/AoLC7eHREujJgDO
 BB/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793425225; x=1794030025;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TYjLD8duH/kzryFwDK8Slo0MIdJUBgA1jVnoPpOkxEU=;
 b=CMMxrU9C7skBV4oIoy0+dqiuekJ/xLgs6InlHnfNrwBhNxzx12JY0y1IKWZYW19fdi
 K8Ui3idBbuMA/pAshQ/Bo4kldULGprhtEXzvAaSI7wIvP8RHDaqoSoccS65LtvY6Lc1d
 XD3/RipCrsgvnbEQ0cfEUHPZExQ1PiM/nhK98a8rUtWvN4L5yCwjS7mUmOPyOHi0U15j
 hGtNd9D4jTFY3F/yWFuIhgqODubdv9x/ffTezW4eC+5zJ/43tLdAXXrJ+kTc+2qV1Kx2
 WeugRkF4L5j5GvbZXCDPqWnpk+yvzTYQqaSFCfftwGKgGAizNANcfvMhpoBk8ZSpLUSr
 l/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793425225; x=1794030025;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TYjLD8duH/kzryFwDK8Slo0MIdJUBgA1jVnoPpOkxEU=;
 b=1MzwZj2TKjxeuBp+hXzc373juHqA/bgd7fXKxUA/CV45GlOjeW+/5cserVui4nXeRT
 vNXWToXJwXzCEOFRfInIK+/QBUDJTEA/FaEdYkW9EFsb28nF2X3igp8FxbjQpQN6dT5S
 ix9s9bJJCjhNNf9FLr8zuxWsbBtf+0mN6rB7II5xKXrIeJ5sSkLP0MbUM4DSACnvgOzx
 dVP7zSDiog0Dk3dZmdejJc7UMTv7M+le/bIh7qN4qqgqNhPfEbnlbLNGVSUP+plrAb/H
 Sbjy6OA1L92zwZIXPArejjFZBY05AUZc2O12ix6P2aYJpL3+VhvZtHohFZ1WxBNHl3JW
 PYrg==
X-Gm-Message-State: AFq9FYK9/r8ePcwkWp+fSPsH5rwJHyXpCGvz1ApvMPzedpPhsJo7T6Vi
 BNinnJ3jVhjZiUY3RgWIBaGRe0IY3ai7ttD8otgpE+Bfdt00JqTKbH/VzTvSBryayqHwWEpxCCW
 b/HcxFwcL4WtmsqTQ2gMVWt6QwtPkQhI=
X-Gm-Gg: AYBFou3KUQHg8g9t5yOR/d6gp0LL9P0G1Gel8yBMGfaBOO5QMy2tUVn0svb+oPM2OJd
 FCFkbiCchEwpIdlWUFWQCk1z5CpdAO5b+S7BAc9ntQMb1lyZQM0TiCJUJqeleopdy8UqNSoJMot
 oXZYqdRVLoVxF12AAx5yTDs4IkwWPZD7QhntYu/pP6FlGoqx1Owwxadt80+su4ETpeB3MJ96Vb7
 PisUokv6NjvGpwvR7FO+JmrOkHFysT2x2Y6a+yQxJrRk2AiDqyvzSFnuiGQqrwYGVP/UnY21RRz
 1rSvDEjHbJa1WsvuzDa4gmhfxJVBNZurDFq1t6zn3CUhHka1wb9mhggLiI6U286iYXr3pWXk+r2
 rJFltd+mHU8AFKhQBIAbMlS/ulkgyKoEDFYQ4gwUqTk0QSwUCSe6MV3uVCqalCNUpSUmPFErJKO
 viyryZwHrrFIPh4R1g
X-Received: by 2002:a53:e942:0:b0:679:a2c3:b2d8 with SMTP id
 956f58d0204a3-67ba5004114mr2321347d50.39.1793425225181; Fri, 30 Oct 2026
 22:40:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <0a36eb46-539f-8e47-02db-5dfe91a9bab2@nabladev.com>
 <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
 <b11efa7b-e027-76d4-8f13-0efac5fdf315@nabladev.com>
In-Reply-To: <b11efa7b-e027-76d4-8f13-0efac5fdf315@nabladev.com>
From: =?UTF-8?B?R2nDoHUgTmd1eeG7hW4gQW5o?= <nguyenanhgiau1008@gmail.com>
Date: Sat, 31 Oct 2026 12:39:49 +0700
X-Gm-Features: AclHuK-CM2yrRcagT8Gs9FDGaugBBPwYySHpuTG6OjYq4wGV_SRhhryoBl1HZXc
Message-ID: <CAKXvu5idFkXmNGROUpdk=6VH-1n2-cU4wKJhgfGcO-4vo+yUww@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com
Content-Type: multipart/alternative; boundary="0000000000007a7064065f1c59ae"
X-Mailman-Approved-At: Sat, 31 Oct 2026 13:59:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007a7064065f1c59ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Heiko,

Thank you for the review and the Reviewed-by tag!

Regarding your questions:
1. "maybe bcm2835_get_mmc_clock() can use above function?"
Yes, `bcm2835_get_mmc_clock()` could definitely be refactored to use the
new `bcm2835_get_clock_rate()` function to reduce duplication.
To keep this I2C driver patch focused, I can submit a separate minor
cleanup patch for the MMC part later on.

2. "if i2c part does not also need such a bcm2835_power_on_module() call"
For the I2C controller on BCM2835/BCM2711, the power domain is typically
managed by the VideoCore firmware by default.
Querying the clock rate and setting up the registers are sufficient to get
it working properly in U-Boot without needing an explicit power-on call.

I have fixed the alphabetical sorting in `driver/i2c/Makefile` (I
previously placed it in the wrong spot, my apologies!)
and added the Linux commit ID in the commit message.

I will send out the v3 path shortly.

Best regards,
Giau Nguyen
--------------------------------------------------------
Phone: (+84) 387 915 996 <+84%20387%20915%20996>


On Fri, Oct 30, 2026 at 3:59=E2=80=AFPM Heiko Schocher <hs@nabladev.com> wr=
ote:

> Hello Giau,
>
> On 28.10.26 12:30, Giau Nguyen wrote:
> > Mainline U-Boot currently lacks an I2C controller driver for the
> > Broadcom BCM2711 SoC (Raspberry Pi 4).
> >
> > This commit adds a new DM-compliant I2C driver for Broadcom
> > BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.
>
> May you add here the linux commit ID which was the base for this port?
>
> >
> > The driver dynamically queries the actual VPU core clock rate from
> > the VideoCore firmware via mailbox property messages to calculate
> > the CDIV clock divider, ensuring accurate I2C timing and baud rates
> > on BCM2711.
> >
> > Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
> >
> > Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> > ---
> > v2:
> >   - Clarified commit message: U-Boot mainline currently lacks BCM2711
> I2C driver.
> >   - Fixed line endings and code formatting per checkpatch.pl.
> >   - Converted register offsets to 'struct bcm2835_i2c_regs' abstraction=
.
> >   - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard
> readl/writel.
> >   - Moved mailbox clock querying to bcm2835_get_clock_rate() in
> mach-bcm283x.
> >   - Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
> >   - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
> >   - Removed 'Assisted by AI' tag.
> >
> >   MAINTAINERS                              |   1 +
> >   arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
> >   arch/arm/mach-bcm283x/msg.c              |  22 ++
>
> For this parts, it would be nice to get some comment from Peter or
> Matthias,
> just some dummy question below.
>
> >   configs/rpi_4_defconfig                  |   4 +
> >   drivers/i2c/Kconfig                      |  10 +
> >   drivers/i2c/Makefile                     |   1 +
> >   drivers/i2c/i2c-bcm2835.c                | 370 ++++++++++++++++++++++=
+
> >   7 files changed, 417 insertions(+)
> >   create mode 100644 drivers/i2c/i2c-bcm2835.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d273603ac64..53bf76964de 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -277,6 +277,7 @@ S:        Maintained
> >   F:  arch/arm/mach-bcm283x/
> >   F:  board/raspberrypi/
> >   F:  drivers/gpio/bcm2835_gpio.c
> > +F:   drivers/i2c/i2c-bcm2835.c
> >   F:  drivers/mmc/bcm2835_sdhci.c
> >   F:  drivers/mmc/bcm2835_sdhost.c
> >   F:  drivers/serial/serial_bcm283x_mu.c
> > diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h
> b/arch/arm/mach-bcm283x/include/mach/msg.h
> > index e54da86e353..d6adec07ae2 100644
> > --- a/arch/arm/mach-bcm283x/include/mach/msg.h
> > +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
> > @@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);
> >    */
> >   int bcm2835_get_mmc_clock(u32 clock_id);
> >
> > +/**
> > + * bcm2835_get_clock_rate() - get the current rate of a clock
> > + *
> > + * @clock_id: ID of clock to get frequency for
> (BCM2835_MBOX_CLOCK_ID_...)
> > + * @rate: Returns the clock rate in Hz
> > + * Return: 0 if OK, -EIO or -EINVAL on error
> > + */
> > +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
> > +
> >   /**
> >    * bcm2835_set_sdhost_clock() - determine if firmware controls sdhost
> cdiv
> >    *
> > diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> > index 05e1a02e80f..b8917662b31 100644
> > --- a/arch/arm/mach-bcm283x/msg.c
> > +++ b/arch/arm/mach-bcm283x/msg.c
> > @@ -116,6 +116,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
> >       return clock_rate;
> >   }
> >
> > +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
> > +{
> > +     ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
> > +     int ret;
> > +
> > +     BCM2835_MBOX_INIT_HDR(msg_clk);
> > +     BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
> > +     msg_clk->get_clock_rate.body.req.clock_id =3D clock_id;
> > +
> > +     ret =3D bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN,
> &msg_clk->hdr);
> > +     if (ret) {
> > +             printf("bcm2835: Could not query clock rate for %u\n",
> clock_id);
> > +             return -EIO;
> > +     }
> > +
> > +     *rate =3D msg_clk->get_clock_rate.body.resp.rate_hz;
> > +     if (!*rate)
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
>
> maybe bcm2835_get_mmc_clock() can use above function?
>
> And for me the question raises, if i2c part does not also need such a
> bcm2835_power_on_module() call as it is in bcm2835_get_mmc_clock() ?
>
> But I have no glue about this SoC...
>
> >   int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32 *rate_2)
> >   {
> >       ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_sdhost_clock,
> msg_sdhost_clk, 1);
> > diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> > index 850f8c7d1c6..b6f97d8635b 100644
> > --- a/configs/rpi_4_defconfig
> > +++ b/configs/rpi_4_defconfig
> > @@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT=3D"U-Boot> "
> >   CONFIG_CMD_NVEDIT_EFI=3Dy
> >   CONFIG_CMD_DFU=3Dy
> >   CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_I2C=3Dy
> >   CONFIG_CMD_MMC=3Dy
> >   CONFIG_CMD_PCI=3Dy
> >   CONFIG_CMD_USB=3Dy
> > @@ -37,6 +38,9 @@ CONFIG_DM_DMA=3Dy
> >   CONFIG_DFU_MMC=3Dy
> >   CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x100000
> >   CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x200000
> > +CONFIG_I2C=3Dy
> > +CONFIG_DM_I2C=3Dy
> > +CONFIG_SYS_I2C_BCM2835=3Dy
> >   CONFIG_BCM2835_GPIO=3Dy
> >   CONFIG_MMC_SDHCI=3Dy
> >   CONFIG_MMC_SDHCI_SDMA=3Dy
> > diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> > index 0b5225fd3f5..191083c9184 100644
> > --- a/drivers/i2c/Kconfig
> > +++ b/drivers/i2c/Kconfig
> > @@ -171,6 +171,16 @@ config SYS_I2C_AT91
> >         i2c-gpio driver unless your system can cope with this limitatio=
n.
> >         Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
> >
> > +config SYS_I2C_BCM2835
> > +     bool "BCM2835 I2C controller"
> > +     depends on DM_I2C
> > +     help
> > +       Enable support for the Broadcom BCM2835/BCM2711 I2C controller.
> > +       This driver provides standard I2C support for Raspberry Pi
> > +       devices, including the newer Raspberry Pi 4. It dynamically
> > +       calculates the clock divider based on the VPU core clock
> > +       queried via the firmware mailbox.
> > +
> >   config SYS_I2C_IPROC
> >       bool "Broadcom I2C driver"
> >       depends on DM_I2C
> > diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> > index 79e6a298808..41378a71d1d 100644
> > --- a/drivers/i2c/Makefile
> > +++ b/drivers/i2c/Makefile
> > @@ -54,6 +54,7 @@ obj-$(CONFIG_SYS_I2C_SUN6I_P2WI) +=3D sun6i_p2wi.o
> >   obj-$(CONFIG_SYS_I2C_SUN8I_RSB) +=3D sun8i_rsb.o
> >   obj-$(CONFIG_SYS_I2C_SYNQUACER) +=3D synquacer_i2c.o
> >   obj-$(CONFIG_SYS_I2C_TEGRA) +=3D tegra_i2c.o
> > +obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o
>
> For me this look not in alphabetical order... may I was unclear,
> the CONFIG symbols are sorted, not the filenames, sorry.
>
>
> >   obj-$(CONFIG_SYS_I2C_UNIPHIER) +=3D i2c-uniphier.o
> >   obj-$(CONFIG_SYS_I2C_UNIPHIER_F) +=3D i2c-uniphier-f.o
> >   obj-$(CONFIG_SYS_I2C_VERSATILE) +=3D i2c-versatile.o
> > diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> > new file mode 100644
> > index 00000000000..e6abb076bdb
> > --- /dev/null
> > +++ b/drivers/i2c/i2c-bcm2835.c
> > @@ -0,0 +1,370 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * BCM2835 I2C controller driver
> > + * (C) Copyright 2026
> > + *
> > + * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> > + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
> > + */
> > +
> > +#include <log.h>
> > +#include <asm/io.h>
> > +#include <asm/arch/mbox.h>
> > +#include <asm/arch/msg.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <i2c.h>
> > +#include <time.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +
> > +#define BCM2835_I2C_C_READ   BIT(0)
> > +#define BCM2835_I2C_C_CLEAR  BIT(4) /* bits 4 and 5 both clear */
> > +#define BCM2835_I2C_C_ST     BIT(7)
> > +#define BCM2835_I2C_C_INTD   BIT(8)
> > +#define BCM2835_I2C_C_INTT   BIT(9)
> > +#define BCM2835_I2C_C_INTR   BIT(10)
> > +#define BCM2835_I2C_C_I2CEN  BIT(15)
> > +
> > +#define BCM2835_I2C_S_TA     BIT(0)
> > +#define BCM2835_I2C_S_DONE   BIT(1)
> > +#define BCM2835_I2C_S_TXW    BIT(2)
> > +#define BCM2835_I2C_S_RXR    BIT(3)
> > +#define BCM2835_I2C_S_TXD    BIT(4)
> > +#define BCM2835_I2C_S_RXD    BIT(5)
> > +#define BCM2835_I2C_S_TXE    BIT(6)
> > +#define BCM2835_I2C_S_RXF    BIT(7)
> > +#define BCM2835_I2C_S_ERR    BIT(8)
> > +#define BCM2835_I2C_S_CLKT   BIT(9)
> > +#define BCM2835_I2C_S_LEN    BIT(10) /* Fake bit for SW error reportin=
g
> */
> > +
> > +#define BCM2835_I2C_FEDL_SHIFT       16
> > +#define BCM2835_I2C_REDL_SHIFT       0
> > +
> > +#define BCM2835_I2C_CDIV_MIN 0x0002
> > +#define BCM2835_I2C_CDIV_MAX 0xFFFE
> > +
> > +#define BCM2835_I2C_CLKT_TOUT_MS 35
> > +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
> > +
> > +struct bcm2835_i2c_regs {
> > +     u32 c;
> > +     u32 s;
> > +     u32 dlen;
> > +     u32 a;
> > +     u32 fifo;
> > +     u32 div;
> > +     u32 del;
> > +     u32 clkt;
> > +};
> > +
> > +struct bcm2835_i2c_priv {
> > +     struct bcm2835_i2c_regs __iomem *regs;
> > +     ulong input_rate;
> > +     size_t msg_buf_remaining;
> > +     u8 *msg_buf;
> > +     struct i2c_msg *curr_msg;
> > +     int msg_err;
> > +     int num_msgs;
> > +};
> > +
> > +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
> > +{
> > +     struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +
> > +     while (i2c_dev->msg_buf_remaining) {
> > +             if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
> > +                     break;
> > +
> > +             writel(*i2c_dev->msg_buf, &regs->fifo);
> > +             i2c_dev->msg_buf++;
> > +             i2c_dev->msg_buf_remaining--;
> > +     }
> > +}
> > +
> > +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
> > +{
> > +     struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +
> > +     while (i2c_dev->msg_buf_remaining) {
> > +             if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
> > +                     break;
> > +
> > +             *i2c_dev->msg_buf =3D readl(&regs->fifo);
> > +             i2c_dev->msg_buf++;
> > +             i2c_dev->msg_buf_remaining--;
> > +     }
> > +}
> > +
> > +static int bcm2835_i2c_calc_divider(unsigned long rate,
> > +                                 unsigned long parent_rate)
> > +{
> > +     int divider =3D DIV_ROUND_UP(parent_rate, rate);
> > +
> > +     /*
> > +      * Per the datasheet, the register is always interpreted as an ev=
en
> > +      * number, by rounding down. In other words, the LSB is ignored.
> So,
> > +      * if the LSB is set, increment the divider to avoid any issue.
> > +      */
> > +     if (divider & 1)
> > +             divider++;
> > +
> > +     if (divider < BCM2835_I2C_CDIV_MIN ||
> > +         divider > BCM2835_I2C_CDIV_MAX)
> > +             return -EINVAL;
> > +
> > +     return divider;
> > +}
> > +
> > +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate=
)
> > +{
> > +     struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(bus);
> > +     struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +     ulong parent_rate =3D i2c_dev->input_rate;
> > +     u32 redl, fedl;
> > +     u32 clk_tout;
> > +     int divider;
> > +
> > +     if (!rate || !parent_rate)
> > +             return -EINVAL;
> > +
> > +     divider =3D bcm2835_i2c_calc_divider(rate, parent_rate);
> > +     if (divider < 0)
> > +             return divider;
> > +
> > +     writel(divider, &regs->div);
> > +
> > +     /*
> > +      * Number of core clocks to wait after falling edge before
> > +      * outputting the next data bit. Note that both FEDL and REDL
> > +      * can't be greater than CDIV/2.
> > +      */
> > +     fedl =3D max_t(u32, divider / 16, 1);
> > +
> > +     /*
> > +      * Number of core clocks to wait after rising edge before
> > +      * sampling the next incoming data bit.
> > +      */
> > +     redl =3D max_t(u32, divider / 4, 1);
> > +
> > +     writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
> > +            (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
> > +
> > +     /*
> > +      * Set the clock stretch timeout.
> > +      */
> > +     if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
> > +             clk_tout =3D 0xffff;
> > +     else
> > +             clk_tout =3D BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
> > +
> > +     writel(clk_tout, &regs->clkt);
> > +
> > +     return 0;
> > +}
> > +
> > +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_de=
v)
> > +{
> > +     struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +     u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> > +     struct i2c_msg *msg =3D i2c_dev->curr_msg;
> > +     bool last_msg =3D (i2c_dev->num_msgs =3D=3D 1);
> > +
> > +     if (!i2c_dev->num_msgs)
> > +             return;
> > +
> > +     i2c_dev->num_msgs--;
> > +     i2c_dev->msg_buf =3D msg->buf;
> > +     i2c_dev->msg_buf_remaining =3D msg->len;
> > +
> > +     if (msg->flags & I2C_M_RD)
> > +             c |=3D BCM2835_I2C_C_READ;
> > +     else
> > +             c |=3D BCM2835_I2C_C_INTT;
> > +
> > +     if (last_msg)
> > +             c |=3D BCM2835_I2C_C_INTD;
> > +
> > +     writel(msg->addr, &regs->a);
> > +     writel(msg->len, &regs->dlen);
> > +     writel(c, &regs->c);
> > +}
> > +
> > +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv
> *i2c_dev)
> > +{
> > +     i2c_dev->curr_msg =3D NULL;
> > +     i2c_dev->num_msgs =3D 0;
> > +     i2c_dev->msg_buf =3D NULL;
> > +     i2c_dev->msg_buf_remaining =3D 0;
> > +}
> > +
> > +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs,
> int count)
> > +{
> > +     struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(dev);
> > +     struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> > +     bool ignore_nak =3D false;
> > +     bool done =3D false;
> > +     ulong start;
> > +     int i;
> > +     u32 val, err;
> > +     int ret =3D 0;
> > +
> > +     if (!msgs || count <=3D 0)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             if (msgs[i].flags & I2C_M_TEN)
> > +                     return -EOPNOTSUPP;
> > +             if (msgs[i].flags & I2C_M_RD) {
> > +                     if (i < count - 1) {
> > +                             dev_err(dev, "read message must be
> last\n");
> > +                             return -EOPNOTSUPP;
> > +                     }
> > +             }
> > +             if (msgs[i].len > 0xffff)
> > +                     return -EINVAL;
> > +             if (msgs[i].flags & I2C_M_IGNORE_NAK)
> > +                     ignore_nak =3D true;
> > +     }
> > +
> > +     /* Clear stale status and FIFO state before starting a new
> transaction. */
> > +     writel(BCM2835_I2C_C_CLEAR, &regs->c);
> > +     writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DON=
E,
> > +            &regs->s);
> > +
> > +     i2c_dev->curr_msg =3D msgs;
> > +     i2c_dev->num_msgs =3D count;
> > +     i2c_dev->msg_err =3D 0;
> > +
> > +     bcm2835_i2c_start_transfer(i2c_dev);
> > +     start =3D get_timer(0);
> > +     while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
> > +             val =3D readl(&regs->s);
> > +
> > +             err =3D val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
> > +             if (err && !(val & BCM2835_I2C_S_TA))
> > +                     i2c_dev->msg_err =3D err;
> > +
> > +             if (val & BCM2835_I2C_S_DONE) {
> > +                     if (!i2c_dev->curr_msg) {
> > +                             dev_err(dev, "unexpected completion
> status\n");
> > +                     } else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
> > +                             bcm2835_drain_rxfifo(i2c_dev);
> > +                             val =3D readl(&regs->s);
> > +                     }
> > +
> > +                     if ((val & BCM2835_I2C_S_RXD) ||
> > +                         i2c_dev->msg_buf_remaining)
> > +                             i2c_dev->msg_err =3D BCM2835_I2C_S_LEN;
> > +                     done =3D true;
> > +                     break;
> > +             }
> > +
> > +             if (val & BCM2835_I2C_S_TXW) {
> > +                     if (!i2c_dev->msg_buf_remaining) {
> > +                             i2c_dev->msg_err =3D val | BCM2835_I2C_S_=
LEN;
> > +                             break;
> > +                     }
> > +
> > +                     bcm2835_fill_txfifo(i2c_dev);
> > +
> > +                     if (i2c_dev->num_msgs > 0 &&
> !i2c_dev->msg_buf_remaining) {
> > +                             i2c_dev->curr_msg++;
> > +                             bcm2835_i2c_start_transfer(i2c_dev);
> > +                     }
> > +             }
> > +
> > +             if (val & BCM2835_I2C_S_RXR) {
> > +                     if (!i2c_dev->msg_buf_remaining) {
> > +                             i2c_dev->msg_err =3D val | BCM2835_I2C_S_=
LEN;
> > +                             break;
> > +                     }
> > +
> > +                     bcm2835_drain_rxfifo(i2c_dev);
> > +             }
> > +             udelay(1);
> > +     }
> > +
> > +     if (!done) {
> > +             val =3D readl(&regs->s);
> > +             dev_err(dev, "transfer timeout: status=3D%08x
> remaining=3D%zu\n",
> > +                     val, i2c_dev->msg_buf_remaining);
> > +             ret =3D -ETIMEDOUT;
> > +     }
> > +
> > +     /* Always abort/reset the controller and clear W1C status bits. *=
/
> > +     writel(BCM2835_I2C_C_CLEAR, &regs->c);
> > +     writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DON=
E,
> > +            &regs->s);
> > +
> > +     bcm2835_i2c_finish_transfer(i2c_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (ignore_nak)
> > +             i2c_dev->msg_err &=3D ~BCM2835_I2C_S_ERR;
> > +
> > +     if (!i2c_dev->msg_err)
> > +             return 0;
> > +
> > +     if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
> > +             return -EREMOTEIO;
> > +
> > +     return -EIO;
> > +}
> > +
> > +static const struct dm_i2c_ops bcm2835_i2c_ops =3D {
> > +     .xfer          =3D bcm2835_i2c_xfer,
> > +     .set_bus_speed =3D bcm2835_i2c_set_rate,
> > +};
> > +
> > +static const struct udevice_id bcm2835_i2c_ids[] =3D {
> > +     {.compatible =3D "brcm,bcm2711-i2c"},
> > +     {.compatible =3D "brcm,bcm2835-i2c"},
> > +     {}
> > +};
> > +
> > +static int bcm2835_i2c_probe(struct udevice *bus)
> > +{
> > +     struct bcm2835_i2c_priv *priv =3D dev_get_priv(bus);
> > +     struct bcm2835_i2c_regs __iomem *regs;
> > +     unsigned int bus_clk_rate;
> > +     int ret;
> > +
> > +     priv->regs =3D dev_read_addr_ptr(bus);
> > +     if (!priv->regs) {
> > +             printf("bcm2835_i2c: cannot get base address\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     regs =3D priv->regs;
> > +
> > +     ret =3D bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE,
> &priv->input_rate);
> > +     if (ret)
> > +             return ret;
> > +
> > +     bus_clk_rate =3D dev_read_u32_default(bus, "clock-frequency",
> > +                                         I2C_SPEED_STANDARD_RATE);
> > +     ret =3D bcm2835_i2c_set_rate(bus, bus_clk_rate);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* clear FIFO + status */
> > +     writel(BCM2835_I2C_C_CLEAR, &regs->c);
> > +     writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DON=
E,
> > +            &regs->s);
> > +
> > +     return 0;
> > +}
> > +
> > +U_BOOT_DRIVER(bcm2835_i2c) =3D {
> > +     .name       =3D "bcm2835_i2c",
> > +     .id         =3D UCLASS_I2C,
> > +     .of_match   =3D bcm2835_i2c_ids,
> > +     .probe      =3D bcm2835_i2c_probe,
> > +     .priv_auto  =3D sizeof(struct bcm2835_i2c_priv),
> > +     .ops        =3D &bcm2835_i2c_ops,
> > +};
> >
>
> The i2c driver part looks good to me now, thanks!
>
> If my nitpick is in, you can add my:
>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>
> bye,
> Heiko
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596 <+49%20821%2045592596>
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
>

--0000000000007a7064065f1c59ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello=C2=A0Heiko,</div><div><br></div><div>Thank you =
for the review and the Reviewed-by tag!</div><div><br></div><div>Regarding =
your questions:</div><div>1. &quot;maybe bcm2835_get_mmc_clock() can use ab=
ove function?&quot;</div><div>Yes, `bcm2835_get_mmc_clock()` could definite=
ly be refactored to use the new `bcm2835_get_clock_rate()` function to redu=
ce duplication.</div><div>To keep this I2C driver patch focused, I can subm=
it a separate minor cleanup patch for the MMC part later on.</div><div><br>=
</div><div>2. &quot;if i2c part does not also need such a bcm2835_power_on_=
module() call&quot;</div><div>For the I2C controller on BCM2835/BCM2711, th=
e power domain is typically managed by the VideoCore firmware by default.</=
div><div>Querying the clock rate and setting up the registers are sufficien=
t=C2=A0to get it working properly in U-Boot without needing an explicit pow=
er-on call.</div><div><br></div><div>I have fixed the alphabetical sorting =
in `driver/i2c/Makefile` (I previously placed it in the wrong spot, my apol=
ogies!)=C2=A0</div><div>and added the Linux commit ID <span style=3D"border=
-style:none;background:none">in</span> the commit message.</div><div><br></=
div><div>I will send out the v3 <span style=3D"border-style:none;background=
:none"><span class=3D"G8OMXb ng" style=3D"border-style:none;background:none=
">path</span></span> shortly.</div><div><br></div><div>Best regards,</div><=
div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sign=
ature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">=
<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div>Giau Nguyen</div><div>--------------------------------------=
------------------</div><div>Phone: <a href=3D"tel:+84%20387%20915%20996" v=
alue=3D"+84387915996" target=3D"_blank">(+84) 387 915 996</a><br></div></di=
v></div></div></div></div></div></div></div></div></div></div><br></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, O=
ct 30, 2026 at 3:59=E2=80=AFPM Heiko Schocher &lt;<a href=3D"mailto:hs@nabl=
adev.com" target=3D"_blank">hs@nabladev.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hello Giau,<br>
<br>
On 28.10.26 12:30, Giau Nguyen wrote:<br>
&gt; Mainline U-Boot currently lacks an I2C controller driver for the<br>
&gt; Broadcom BCM2711 SoC (Raspberry Pi 4).<br>
&gt; <br>
&gt; This commit adds a new DM-compliant I2C driver for Broadcom<br>
&gt; BCM2835/BCM2711 SoCs based on the Linux kernel&#39;s i2c-bcm2835.c.<br=
>
<br>
May you add here the linux commit ID which was the base for this port?<br>
<br>
&gt; <br>
&gt; The driver dynamically queries the actual VPU core clock rate from<br>
&gt; the VideoCore firmware via mailbox property messages to calculate<br>
&gt; the CDIV clock divider, ensuring accurate I2C timing and baud rates<br=
>
&gt; on BCM2711.<br>
&gt; <br>
&gt; Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.<br>
&gt; <br>
&gt; Signed-off-by: Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@gma=
il.com" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; v2:<br>
&gt;=C2=A0 =C2=A0- Clarified commit message: U-Boot mainline currently lack=
s BCM2711 I2C driver.<br>
&gt;=C2=A0 =C2=A0- Fixed line endings and code formatting per <a href=3D"ht=
tp://checkpatch.pl" rel=3D"noreferrer" target=3D"_blank">checkpatch.pl</a>.=
<br>
&gt;=C2=A0 =C2=A0- Converted register offsets to &#39;struct bcm2835_i2c_re=
gs&#39; abstraction.<br>
&gt;=C2=A0 =C2=A0- Removed &#39;bcm2835_i2c_readl/writel&#39; wrappers in f=
avor of standard readl/writel.<br>
&gt;=C2=A0 =C2=A0- Moved mailbox clock querying to bcm2835_get_clock_rate()=
 in mach-bcm283x.<br>
&gt;=C2=A0 =C2=A0- Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.<br>
&gt;=C2=A0 =C2=A0- Sorted drivers/i2c/Kconfig and Makefile alphabetically.<=
br>
&gt;=C2=A0 =C2=A0- Removed &#39;Assisted by AI&#39; tag.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
&gt;=C2=A0 =C2=A0arch/arm/mach-bcm283x/include/mach/msg.h |=C2=A0 =C2=A09 +=
<br>
&gt;=C2=A0 =C2=A0arch/arm/mach-bcm283x/msg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 22 ++<br>
<br>
For this parts, it would be nice to get some comment from Peter or Matthias=
,<br>
just some dummy question below.<br>
<br>
&gt;=C2=A0 =C2=A0configs/rpi_4_defconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0drivers/i2c/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 =C2=A0drivers/i2c/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0drivers/i2c/i2c-bcm2835.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 370 +++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A07 files changed, 417 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 drivers/i2c/i2c-bcm2835.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index d273603ac64..53bf76964de 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -277,6 +277,7 @@ S:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 arch/arm/mach-bcm283x/<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 board/raspberrypi/<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/gpio/bcm2835_gpio.c<br>
&gt; +F:=C2=A0 =C2=A0drivers/i2c/i2c-bcm2835.c<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/mmc/bcm2835_sdhci.c<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/mmc/bcm2835_sdhost.c<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/serial/serial_bcm283x_mu.c<br>
&gt; diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-=
bcm283x/include/mach/msg.h<br>
&gt; index e54da86e353..d6adec07ae2 100644<br>
&gt; --- a/arch/arm/mach-bcm283x/include/mach/msg.h<br>
&gt; +++ b/arch/arm/mach-bcm283x/include/mach/msg.h<br>
&gt; @@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0int bcm2835_get_mmc_clock(u32 clock_id);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * bcm2835_get_clock_rate() - get the current rate of a clock<br>
&gt; + *<br>
&gt; + * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID=
_...)<br>
&gt; + * @rate: Returns the clock rate in Hz<br>
&gt; + * Return: 0 if OK, -EIO or -EINVAL on error<br>
&gt; + */<br>
&gt; +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * bcm2835_set_sdhost_clock() - determine if firmware cont=
rols sdhost cdiv<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c=
<br>
&gt; index 05e1a02e80f..b8917662b31 100644<br>
&gt; --- a/arch/arm/mach-bcm283x/msg.c<br>
&gt; +++ b/arch/arm/mach-bcm283x/msg.c<br>
&gt; @@ -116,6 +116,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return clock_rate;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rat=
e, msg_clk, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BCM2835_MBOX_INIT_HDR(msg_clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BCM2835_MBOX_INIT_TAG(&amp;msg_clk-&gt;get_clock_=
rate, GET_CLOCK_RATE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg_clk-&gt;get_clock_rate.body.req.clock_id =3D =
clock_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_=
CHAN, &amp;msg_clk-&gt;hdr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;bcm2835:=
 Could not query clock rate for %u\n&quot;, clock_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*rate =3D msg_clk-&gt;get_clock_rate.body.resp.ra=
te_hz;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!*rate)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
<br>
maybe bcm2835_get_mmc_clock() can use above function?<br>
<br>
And for me the question raises, if i2c part does not also need such a<br>
bcm2835_power_on_module() call as it is in bcm2835_get_mmc_clock() ?<br>
<br>
But I have no glue about this SoC...<br>
<br>
&gt;=C2=A0 =C2=A0int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32=
 *rate_2)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_sdho=
st_clock, msg_sdhost_clk, 1);<br>
&gt; diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig<br>
&gt; index 850f8c7d1c6..b6f97d8635b 100644<br>
&gt; --- a/configs/rpi_4_defconfig<br>
&gt; +++ b/configs/rpi_4_defconfig<br>
&gt; @@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT=3D&quot;U-Boot&gt; &quot;<br>
&gt;=C2=A0 =C2=A0CONFIG_CMD_NVEDIT_EFI=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_CMD_DFU=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_CMD_GPIO=3Dy<br>
&gt; +CONFIG_CMD_I2C=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_CMD_MMC=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_CMD_PCI=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_CMD_USB=3Dy<br>
&gt; @@ -37,6 +38,9 @@ CONFIG_DM_DMA=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_DFU_MMC=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x100000<br>
&gt;=C2=A0 =C2=A0CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x200000<br>
&gt; +CONFIG_I2C=3Dy<br>
&gt; +CONFIG_DM_I2C=3Dy<br>
&gt; +CONFIG_SYS_I2C_BCM2835=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_BCM2835_GPIO=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_MMC_SDHCI=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_MMC_SDHCI_SDMA=3Dy<br>
&gt; diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig<br>
&gt; index 0b5225fd3f5..191083c9184 100644<br>
&gt; --- a/drivers/i2c/Kconfig<br>
&gt; +++ b/drivers/i2c/Kconfig<br>
&gt; @@ -171,6 +171,16 @@ config SYS_I2C_AT91<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c-gpio driver unless your system ca=
n cope with this limitation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Binding info: doc/device-tree-binding=
s/i2c/i2c-at91.txt<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config SYS_I2C_BCM2835<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;BCM2835 I2C controller&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on DM_I2C<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Enable support for the Broadcom BCM2835/BC=
M2711 I2C controller.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0This driver provides standard I2C support =
for Raspberry Pi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0devices, including the newer Raspberry Pi =
4. It dynamically<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0calculates the clock divider based on the =
VPU core clock<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0queried via the firmware mailbox.<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config SYS_I2C_IPROC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Broadcom I2C driver&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on DM_I2C<br>
&gt; diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile<br>
&gt; index 79e6a298808..41378a71d1d 100644<br>
&gt; --- a/drivers/i2c/Makefile<br>
&gt; +++ b/drivers/i2c/Makefile<br>
&gt; @@ -54,6 +54,7 @@ obj-$(CONFIG_SYS_I2C_SUN6I_P2WI) +=3D sun6i_p2wi.o<b=
r>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_SYS_I2C_SUN8I_RSB) +=3D sun8i_rsb.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_SYS_I2C_SYNQUACER) +=3D synquacer_i2c.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_SYS_I2C_TEGRA) +=3D tegra_i2c.o<br>
&gt; +obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o<br>
<br>
For me this look not in alphabetical order... may I was unclear,<br>
the CONFIG symbols are sorted, not the filenames, sorry.<br>
<br>
<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_SYS_I2C_UNIPHIER) +=3D i2c-uniphier.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_SYS_I2C_UNIPHIER_F) +=3D i2c-uniphier-f.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_SYS_I2C_VERSATILE) +=3D i2c-versatile.o<br>
&gt; diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..e6abb076bdb<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/i2c/i2c-bcm2835.c<br>
&gt; @@ -0,0 +1,370 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +/*<br>
&gt; + * BCM2835 I2C controller driver<br>
&gt; + * (C) Copyright 2026<br>
&gt; + *<br>
&gt; + * Author: Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@gmail.=
com" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt;<br>
&gt; + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;log.h&gt;<br>
&gt; +#include &lt;asm/io.h&gt;<br>
&gt; +#include &lt;asm/arch/mbox.h&gt;<br>
&gt; +#include &lt;asm/arch/msg.h&gt;<br>
&gt; +#include &lt;dm.h&gt;<br>
&gt; +#include &lt;dm/device_compat.h&gt;<br>
&gt; +#include &lt;i2c.h&gt;<br>
&gt; +#include &lt;time.h&gt;<br>
&gt; +#include &lt;linux/bitops.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/types.h&gt;<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_C_READ=C2=A0 =C2=A0BIT(0)<br>
&gt; +#define BCM2835_I2C_C_CLEAR=C2=A0 BIT(4) /* bits 4 and 5 both clear *=
/<br>
&gt; +#define BCM2835_I2C_C_ST=C2=A0 =C2=A0 =C2=A0BIT(7)<br>
&gt; +#define BCM2835_I2C_C_INTD=C2=A0 =C2=A0BIT(8)<br>
&gt; +#define BCM2835_I2C_C_INTT=C2=A0 =C2=A0BIT(9)<br>
&gt; +#define BCM2835_I2C_C_INTR=C2=A0 =C2=A0BIT(10)<br>
&gt; +#define BCM2835_I2C_C_I2CEN=C2=A0 BIT(15)<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_S_TA=C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +#define BCM2835_I2C_S_DONE=C2=A0 =C2=A0BIT(1)<br>
&gt; +#define BCM2835_I2C_S_TXW=C2=A0 =C2=A0 BIT(2)<br>
&gt; +#define BCM2835_I2C_S_RXR=C2=A0 =C2=A0 BIT(3)<br>
&gt; +#define BCM2835_I2C_S_TXD=C2=A0 =C2=A0 BIT(4)<br>
&gt; +#define BCM2835_I2C_S_RXD=C2=A0 =C2=A0 BIT(5)<br>
&gt; +#define BCM2835_I2C_S_TXE=C2=A0 =C2=A0 BIT(6)<br>
&gt; +#define BCM2835_I2C_S_RXF=C2=A0 =C2=A0 BIT(7)<br>
&gt; +#define BCM2835_I2C_S_ERR=C2=A0 =C2=A0 BIT(8)<br>
&gt; +#define BCM2835_I2C_S_CLKT=C2=A0 =C2=A0BIT(9)<br>
&gt; +#define BCM2835_I2C_S_LEN=C2=A0 =C2=A0 BIT(10) /* Fake bit for SW err=
or reporting */<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_FEDL_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
&gt; +#define BCM2835_I2C_REDL_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_CDIV_MIN 0x0002<br>
&gt; +#define BCM2835_I2C_CDIV_MAX 0xFFFE<br>
&gt; +<br>
&gt; +#define BCM2835_I2C_CLKT_TOUT_MS 35<br>
&gt; +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000<br>
&gt; +<br>
&gt; +struct bcm2835_i2c_regs {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 s;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 dlen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 a;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 fifo;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 div;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 del;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 clkt;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct bcm2835_i2c_priv {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ulong input_rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0size_t msg_buf_remaining;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 *msg_buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_msg *curr_msg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int msg_err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int num_msgs;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev=
-&gt;regs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (i2c_dev-&gt;msg_buf_remaining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(readl(&amp;regs=
-&gt;s) &amp; BCM2835_I2C_S_TXD))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(*i2c_dev-&gt;m=
sg_buf, &amp;regs-&gt;fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf++=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_r=
emaining--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev=
-&gt;regs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (i2c_dev-&gt;msg_buf_remaining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(readl(&amp;regs=
-&gt;s) &amp; BCM2835_I2C_S_RXD))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*i2c_dev-&gt;msg_buf =
=3D readl(&amp;regs-&gt;fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf++=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_r=
emaining--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_calc_divider(unsigned long rate,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long parent_rate)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int divider =3D DIV_ROUND_UP(parent_rate, rate);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Per the datasheet, the register is always inte=
rpreted as an even<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * number, by rounding down. In other words, the =
LSB is ignored. So,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * if the LSB is set, increment the divider to av=
oid any issue.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (divider &amp; 1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divider++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (divider &lt; BCM2835_I2C_CDIV_MIN ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divider &gt; BCM2835_I2C_CDIV_MAX)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return divider;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rat=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv=
(bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev=
-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ulong parent_rate =3D i2c_dev-&gt;input_rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 redl, fedl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 clk_tout;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int divider;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!rate || !parent_rate)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0divider =3D bcm2835_i2c_calc_divider(rate, parent=
_rate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (divider &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return divider;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(divider, &amp;regs-&gt;div);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Number of core clocks to wait after falling ed=
ge before<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * outputting the next data bit. Note that both F=
EDL and REDL<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * can&#39;t be greater than CDIV/2.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fedl =3D max_t(u32, divider / 16, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Number of core clocks to wait after rising edg=
e before<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * sampling the next incoming data bit.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0redl =3D max_t(u32, divider / 4, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel((fedl &lt;&lt; BCM2835_I2C_FEDL_SHIFT) |<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (redl &lt;&lt; BCM2835_I2C_=
REDL_SHIFT), &amp;regs-&gt;del);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Set the clock stretch timeout.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (rate &gt; 0xffff * 1000 / BCM2835_I2C_CLKT_TO=
UT_MS)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_tout =3D 0xffff;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_tout =3D BCM2835_=
I2C_CLKT_TOUT_MS * rate / 1000;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(clk_tout, &amp;regs-&gt;clkt);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_d=
ev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev=
-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_msg *msg =3D i2c_dev-&gt;curr_msg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool last_msg =3D (i2c_dev-&gt;num_msgs =3D=3D 1)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!i2c_dev-&gt;num_msgs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf =3D msg-&gt;buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining =3D msg-&gt;len;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (msg-&gt;flags &amp; I2C_M_RD)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835_I2C_C_=
READ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835_I2C_C_=
INTT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (last_msg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835_I2C_C_=
INTD;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(msg-&gt;addr, &amp;regs-&gt;a);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(msg-&gt;len, &amp;regs-&gt;dlen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(c, &amp;regs-&gt;c);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_=
dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs=
, int count)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv=
(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev=
-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool ignore_nak =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool done =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ulong start;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val, err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!msgs || count &lt;=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].flags &am=
p; I2C_M_TEN)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EOPNOTSUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].flags &am=
p; I2C_M_RD) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (i &lt; count - 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;read message must be =
last\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].len &gt; =
0xffff)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].flags &am=
p; I2C_M_IGNORE_NAK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ignore_nak =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Clear stale status and FIFO state before start=
ing a new transaction. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | B=
CM2835_I2C_S_DONE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg =3D msgs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs =3D count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm2835_i2c_start_transfer(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0start =3D get_timer(0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (get_timer(start) &lt; BCM2835_I2C_XFER_TIM=
EOUT_MS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(&amp;re=
gs-&gt;s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D val &amp; (BC=
M2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &amp;&amp; !(=
val &amp; BCM2835_I2C_S_TA))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0i2c_dev-&gt;msg_err =3D err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BCM2835=
_I2C_S_DONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!i2c_dev-&gt;curr_msg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;unexpected completion=
 status\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else if (i2c_dev-&gt;curr_msg-&gt;flags &amp; I2C_M_RD) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_drain_rxfifo(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(&amp;regs-&gt;s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if ((val &amp; BCM2835_I2C_S_RXD) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D BCM2835_I2C_S_LE=
N;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0done =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BCM2835=
_I2C_S_TXW) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!i2c_dev-&gt;msg_buf_remaining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D val | BCM2835_I2=
C_S_LEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bcm2835_fill_txfifo(i2c_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (i2c_dev-&gt;num_msgs &gt; 0 &amp;&amp; !i2c_dev-&gt;msg_buf_rema=
ining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_i2c_start_transfer(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BCM2835=
_I2C_S_RXR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!i2c_dev-&gt;msg_buf_remaining) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D val | BCM2835_I2=
C_S_LEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bcm2835_drain_rxfifo(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!done) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(&amp;re=
gs-&gt;s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;tr=
ansfer timeout: status=3D%08x remaining=3D%zu\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0val, i2c_dev-&gt;msg_buf_remaining);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ETIMEDOUT;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Always abort/reset the controller and clear W1=
C status bits. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | B=
CM2835_I2C_S_DONE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm2835_i2c_finish_transfer(i2c_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ignore_nak)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err &=
amp;=3D ~BCM2835_I2C_S_ERR;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!i2c_dev-&gt;msg_err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (i2c_dev-&gt;msg_err &amp; BCM2835_I2C_S_ERR)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EREMOTEIO;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dm_i2c_ops bcm2835_i2c_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.xfer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D bcm28=
35_i2c_xfer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_bus_speed =3D bcm2835_i2c_set_rate,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct udevice_id bcm2835_i2c_ids[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{.compatible =3D &quot;brcm,bcm2711-i2c&quot;},<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0{.compatible =3D &quot;brcm,bcm2835-i2c&quot;},<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0{}<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int bcm2835_i2c_probe(struct udevice *bus)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *priv =3D dev_get_priv(bu=
s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int bus_clk_rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;regs =3D dev_read_addr_ptr(bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!priv-&gt;regs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;bcm2835_=
i2c: cannot get base address\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regs =3D priv-&gt;regs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK=
_ID_CORE, &amp;priv-&gt;input_rate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bus_clk_rate =3D dev_read_u32_default(bus, &quot;=
clock-frequency&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0I2C_SPEED_STANDARD_RATE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_i2c_set_rate(bus, bus_clk_rate);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* clear FIFO + status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | B=
CM2835_I2C_S_DONE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +U_BOOT_DRIVER(bcm2835_i2c) =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;bcm2835=
_i2c&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D UCLASS_I=
2C,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.of_match=C2=A0 =C2=A0=3D bcm2835_i2c_ids,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =3D bcm2835_i2c_probe,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.priv_auto=C2=A0 =3D sizeof(struct bcm2835_i2c_pr=
iv),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.ops=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;bcm2835_=
i2c_ops,<br>
&gt; +};<br>
&gt; <br>
<br>
The i2c driver part looks good to me now, thanks!<br>
<br>
If my nitpick is in, you can add my:<br>
<br>
Reviewed-by: Heiko Schocher &lt;<a href=3D"mailto:hs@nabladev.com" target=
=3D"_blank">hs@nabladev.com</a>&gt;<br>
<br>
bye,<br>
Heiko<br>
-- <br>
Nabla Software Engineering<br>
HRB 40522 Augsburg<br>
Phone: <a href=3D"tel:+49%20821%2045592596" value=3D"+4982145592596" target=
=3D"_blank">+49 821 45592596</a><br>
E-Mail: <a href=3D"mailto:office@nabladev.com" target=3D"_blank">office@nab=
ladev.com</a><br>
Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic<br>
</blockquote></div>

--0000000000007a7064065f1c59ae--
