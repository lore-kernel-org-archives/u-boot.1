Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C932CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87C0841C2;
	Mon,  8 Jun 2026 15:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jdRbgl4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C183846B1; Mon,  8 Jun 2026 15:27:02 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241BA801A9
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68d23396ed3so7548674a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925219; cv=none;
 d=google.com; s=arc-20240605;
 b=F2q7n1QSy5xYnAKAhA2SwVCz0O3dEcpbaoGSvWLoZvdtWxUfm9iSXdFFww+VMqW1s1
 2VCKYnM3kxUr6NrQRk+c5ayIN9bsGvWVWc9fiHRbkHlZ8uynowYhGUUMqjqA3xmT43DI
 qt/IMKtMYhFrIEApsIT4/QenXsxcCbqCL6E8gDl1pRHI26MFiysqeqwoXb4/46/apgfP
 rdDSihbFjNjHkFeSyPL8lTGK/msmwKKanjEIyYgxa2wMcpsMjVxT9cOjuZY6V4ewfTk6
 R0v4GdDWT/10A5z5b0n+npc4YVf/fEB4KtqoW11ETQIDHHZTEncN86H16BQVZ2jgGpgB
 Bjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W9p37w2N3tXzYCufYppxHVNYwmB3dSVyvZGuagJdYHE=;
 fh=YZolmOeJXv1AvcAlQo8zWS/TRqGhfcFxSHYiNH3Ya4U=;
 b=dIbwcQ1eRlvhfxXZONMXhX2hu8UmeOaQ+c/4us3IRgO0UTDhlKSy3xzS/IGVh8FbXY
 wqECr+JslHHlvyKtDRPs2Z5mmLWvYm6VkH+7oyc/e5ifKPaXGQ7uxKiU9A7Sa9o+9/Nl
 8FseHO2OofsL4YxKpG5Ib+IXrEJYTfixtLnkBRJMsWlLxOptcvwKMsucMPbxXq2jqWsG
 j0GWeK0JZoZnEXtzSNu0ZXqAhRKUJr2PVbwh5BNftrwesemqjmWRPADxYLjJjuR6cxYe
 EJFo5xpZjF9WcC402wxR6DmV/q9uyeMLEQIV6YRn8Y4nHh97NI8UPputjzKK8xF+XLYl
 FXCQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925219; x=1781530019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W9p37w2N3tXzYCufYppxHVNYwmB3dSVyvZGuagJdYHE=;
 b=jdRbgl4OG+/u13AYDhMUG2Cj1WYDKI9YPSskMrNb+FGoY79TbHwIkwYwAk19lLAz56
 cyaUza8/DDxgq3i06p9Q0Wz8Ct69/lPsijYld47x9d4NFWs9BhJLI/kBRFjNKzDquviU
 2Vbe2Z8U307L4to1qomwHqB3gzAsmJcrDOfkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925219; x=1781530019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9p37w2N3tXzYCufYppxHVNYwmB3dSVyvZGuagJdYHE=;
 b=nb3lqJbbu2pxloG7zkCgReEqJ88fUiq9EfZFLMtXuewH/8/eJ/Ak5Ac60SdOIrXj7V
 VdLbInS771QghbAJvlZ71BcYSST864JD5z7eOmdylhcPzSYMmYcXtdEhqqG3dhHZhZPX
 3lKpQyiRhQxzFklX0yJBPwKRISAJlqMavfNz4Jkiw/Ow24J31UbnWMtBC4JaM5aidL0U
 KiZVPrq+C7JTcjI1194hZUB/R9JzGuM+/Z35/JDJn38rtr4BAVLhnhVby8diQmXrY3T0
 eILTz33tiLntzt7PwQSNnzLKJzTzgx3bn/pJVp4V7TjFkbDp2SthgkTdi4yWXGUIo669
 k+FA==
X-Gm-Message-State: AOJu0YztbscZncW6KWsXAS/hTQ6rDHNPcmOwB20svJT+sQA3wU48ckyL
 oItXec3KFqX/gUjEuFuFE5vkJ8SA/XzW74BhxvNgBDDFxBRrnoEM8R4O2HqwzPKTNLeUff9Mt5g
 U/lnI2oT6iLFdMtCi+WDb0H6o83V97QyLh7AuU8JywQQxa5jROk0GbA==
X-Gm-Gg: Acq92OGzj9ILWT8xkvnZvmwb0Hsw2u1Wx7F6jS7eJRRjBP8FZ8CR2Bn4gXRF/iwZ2PV
 ABimUYqBS+5MRso4ffeRqkT7c5G677DFF8iLmqXwFzkvjK7aHfSyACHm0Xv6erIbRltcZHSt74v
 k3/YuuwQUMhPxNeSHNVO/hJDBaZt169VetP38xtDA94mOARBDF0CKbl8s3B5MmkWtnQQgXHq4uT
 056TapPlLuDGVJ4FqEIvOBmop0Gkh1dEazGtnV1WAAJqb1zQlTtpCTaxJokoLGztlKR3emVSWXy
 TBcYkHopdYPnslUC
X-Received: by 2002:a05:6402:2708:b0:68b:d97:f449 with SMTP id
 4fb4d7f45d1cf-68fa503b4d2mr7418250a12.15.1780925219581; Mon, 08 Jun 2026
 06:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-2-b8203682507f@samcday.com>
 <CAFLszTgqnEt_b65DZU0zNa81V-njA+ACaDQ7E4t72k6dwD0tkA@mail.gmail.com>
In-Reply-To: <CAFLszTgqnEt_b65DZU0zNa81V-njA+ACaDQ7E4t72k6dwD0tkA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:26:45 -0600
X-Gm-Features: AVVi8CecTRsM4o3QybO4_7hmf0f4X-E4qmymMmgBbg2vqwHP2ruesh6zNDqHe2M
Message-ID: <CAFLszTiyTYDy0bPKxuQwEBDeQwhVF8NApZOSqKz_8e7-Sso7RA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] .gitignore: ignore binman-generated blobs
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Bryan Brattlof <bb@ti.com>, Yannic Moog <y.moog@phytec.de>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
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

On Mon, 8 Jun 2026 at 07:25, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sam,
>
> On 2026-06-07T23:37:09, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
> > .gitignore: ignore binman-generated blobs
> >
> > The new android_boot etype is causing these /comp*u-boot-nodtb artifacts
> > to be generated, which aren't currently picked up by any ignore rules.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> >
> > .gitignore | 1 +
> >  1 file changed, 1 insertion(+)
>
> > diff --git a/.gitignore b/.gitignore
> > @@ -84,6 +84,7 @@ fit-dtb.blob*
> >  /test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
> >  /test/fdt_overlay/test-fdt-overlay.dtbo.S
> >  capsule_esl_file
> > +/comp.*.u-boot-nodtb
>
> Hmmm yes binman drops intermediate files into the build dir...it would
> be nice to have it write these into a subdirectory. One day we should
> try to use a subdir instead, cleaning it up at the end. This is a
> completely separate issue though.
>
> Also worth mentioning in the commit message that this only affects
> in-tree builds. BTW I almost never do in-tree builds.

Reviewed-by: Simon Glass <sjg@chromium.org>
