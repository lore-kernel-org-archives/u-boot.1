Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF95E9B24E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 10:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D645E83DEB;
	Tue, 24 Feb 2026 11:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zrfDYdOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E33083D3D; Tue, 24 Feb 2026 11:19:20 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311FC83DCB
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so350867d50.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 02:19:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771928357; cv=none;
 d=google.com; s=arc-20240605;
 b=Kxh7SNzVeZwABnM7VWs77bLPuaOU1NS4Od33FLwgZFupXPWESoCS7/cXmIgtEcx/Nu
 iDv+628+Nx7Z85+3NiAGs1PJT1jMGLJpoAXXcgS2TNh1WG8l8yvu8VxS3pe+mWEIpRTQ
 GTeeQtkU+w96Vyj/d9wHOsRsOzxLsX2nVKbTO7UH4xJMxGon9R47FvQG6pbvO044OGCX
 PXDi/01pU4kKxi/v/YVKkIBsIigQz7SUf2x/CIMrHh7OpHThl6nEM5cWJJpk5tzFUA9p
 BDSLi+xSo3eD76iAT8AuuHpXPIeJ9/y3a1f31mhkvzPgTksWqeJ2wFwTy637L/jtMh/Z
 vjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8u8WWX9VqVil+amVOJEX9fey6cEcgjLe99v7+fIxIIQ=;
 fh=I0PpYYilHVwKHTP5pg4x0g9OC+u3v+8grgCQbOTl3KE=;
 b=Zf1ZfCyk6DQ9QMFLxKL/xtiFlg0qsvbSNn4+dbGm1MKobOAeU8kgzypDqmO/BztRGI
 O0o+XiDdO6YCf/3O1R8GM+QUo1sc+P1/08rMhktaBqLL0pd/UTd7TUHCP5L3vwMo23xG
 7qQDP0VzZ5iKPReNl93B7xcRW99p+Y+rgMwS1XmdZfxSSF3I2Pl8iQJ6viBdPzJfYMUA
 2RGEs2xuZSG5nN6lWqyJv2WBWXoAibpnA75sL8YHyo7Ym7c9NF0HBLNWKDsbTziwrP7D
 hwpYHntdcPgeyXpZz53oSc81Lt4xZ9QbbLrOt/Nb9klNkhaYH42v/zI6dJ9ib7QfXGyN
 +/sw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771928357; x=1772533157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8u8WWX9VqVil+amVOJEX9fey6cEcgjLe99v7+fIxIIQ=;
 b=zrfDYdOlAy0oFBZ66Xjie10rkMhj1ji8gh7g42Y7ywofE2bPWtBQVlbAeasGVDWHRD
 EWgrqbgGxR7Mc5HRfHC0/sMPeJ2IAREkbdFaq5z0z5qvXTRX5+bNYoJuk/OmwmO0Y5+5
 GyEI2KwbOq3zDd6flAwx5lTKtKT6573Cos0/j24RonpFmpA/FL0PFQhFd5L4c7uATtEX
 8HHWCXMa+xP5GPo73gcqBzZDr4dENqHlgx8RATap6GDzrQD9UCZg+F/UT7+eTtbgc49A
 3U3vWy5oMBItFD7dsW6h7GAd7HVebrDjY+N7jxB+0stc4CQmyTHQTwo2HcR2Q9zk4G8p
 LGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771928357; x=1772533157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8u8WWX9VqVil+amVOJEX9fey6cEcgjLe99v7+fIxIIQ=;
 b=bYxCaMMl8ye9MkU2UVO6l0KvGKFtTh62pcg0Yqw3CQmOkkcJR5VY4M9kz5xbRcHn6c
 rqHx2bIWfu0/cUbeOAZ0RQZ6HZYyIm0ZXstJ8GZEBxq3JA3jCk3gOLv4qGXMeEx4Iz/U
 IUqxWU7On8kjVTUGfai6NSectuAH8uxQ1mz2Qivf7T0VNJbcIw07tofffK/sBNe5twSw
 MENLZ+okivcKU3hjlkwj2wj/PXh5TTd3Hec2Ruk0Webz3hpLxLouON3CsEC0CDZcd/aZ
 uo8uyovpPVP1XZmp+23f9IZc8TxrkvIOAEiwNsrezn/nVHt6y+AZWXatJNjkFRiz0f00
 k0iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmoCQ+pyRXalrOdYBWn/WL2sbsrV4q1TGKzaNRYBP3aSgwQCRb5Pm2EJTfRPArC/9xMK4M+mo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9A8YoaIIRivU0EeDf084W4o/hr0YVlJschUjOnAURImg5XGxj
 l6q/6SHRQhlxDeKpLOTyyC7ZjbKJFez6AXdjq8FwfLI/sGequI4OU8geqscU7x5ci+yGbgsZefq
 3gEhDMebTvzczvW3n1L6NQdz00t7zx3BWMYk46v3Ksw==
X-Gm-Gg: ATEYQzzUgaBuPwRK6mImCtuucTxtWVSGzihYGPgMkg1iEi3OJUqJgOgsUiRMsTZ34bg
 7Fc+AbgrOAImqWE3KgnEuAl6QVHk+qWZbK0+5C19DNpEzCunqnaWoYlb1SkiXKOUwb6MjlDpZS6
 fV1PgUJ5E1Ny8G5b2rdY3uDJnYLqutQKY767aNmTlJYMtY7YBY4geTwskyrIEwXGcII79R6NhWD
 efTt+4MgRp4wGRCT3wFO6yG68j6h0EPl6dLb1MY9STvP3Vk4OYMYr2C2EzbrcKIoUe0gcs3Gplo
 Qh5ZZad3dJfixJpJZPESBG/prHtek54E0gTGoGahj0/eW9BAhZvoIEZ1b9LeKQT8dlkZvsgpm0t
 usCXtR3XwE30g4u8ZOr8q1x/CuaHU1en0M+aA8e3iO7f9cwPRAuyMmQdoiU/WdoL8Pf66zaT/py
 5Th6dBXFp2ATu8I1KDDcBUMHkX9QFG9hHywVO7CV9Z/aRiTxEYGMsNCx2W5mCPABJV/sHM/1s5S
 dd5vxdZO67QgqUfbw/R9IwiyZG9t9Voav/rpyTP6T5uq3romTCvzfOwfQGORCcHfOb6rHl29Lit
 f9HHjISz06y2KiQYdyncHxTu3EXzrPvY43db2uaA3fFZMWq/Q69f6sg=
X-Received: by 2002:a05:690e:142:b0:649:97d9:cf1f with SMTP id
 956f58d0204a3-64c78e3f750mr7902638d50.44.1771928356810; Tue, 24 Feb 2026
 02:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20260110195610.42068-1-kettenis@openbsd.org>
 <87ldgjw3wo.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87ldgjw3wo.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Feb 2026 12:18:41 +0200
X-Gm-Features: AaiRm52pkNteEFj6yviuX-o-cYyy6CJCQA7apedyU2spQs_Rupq2-SzefUPgt-o
Message-ID: <CAC_iWjLug4gazu2rcm6Ag-ec2Kczc2WUwBXq1bssQX0m5bvcFw@mail.gmail.com>
Subject: Re: [PATCH] arm: armv8: Flush TLB before enabling MMU
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 trini@konsulko.com, 
 anshuld@ti.com, d-gole@ti.com, casey.connolly@linaro.org
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

On Mon, 23 Feb 2026 at 23:23, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > Hi Mark,
>
> Hi Ilias,
>
> Sorry for the late reply.  I was a bit busy the last weeks...
>
> > On Sat, 10 Jan 2026 at 21:56, Mark Kettenis <kettenis@openbsd.org> wrote:
> > >
> > > Commit 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on
> > > dcache_enable") broke Apple Silicon machines in certain scenarios.
> > > If the MMU is currently not enabled we need to flush the TLB
> > > before we enable it to prevent stale TLB entries from becoming
> > > active again.  So move the __asm_invalidate_tlb_all() back
> > > immediately before the mmu_setup() call.
> > >
> > > Fixes: 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on dcache_enable")
> > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > ---
> >
> > Should we keep the check here or mayber move it in mmu_setup()?
>
> It would make sense to move it to mmu_setup(), but I went for a
> partial revert as there is an alternative implementation of
> mmu_setup() in cpu/armv8/fsl-layerscape/cpu.c and I couldn't test that
> code.
>
> Hope this can still make the next release.

Ok that's unfortunate. Let's get it in now since it's a fix

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> > Thanks
> > /Ilias
> >
> > >  arch/arm/cpu/armv8/cache_v8.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > > index 0309da6d397..39479df7b21 100644
> > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > @@ -878,15 +878,16 @@ void flush_dcache_range(unsigned long start, unsigned long stop)
> > >  void dcache_enable(void)
> > >  {
> > >         /* The data cache is not active unless the mmu is enabled */
> > > -       if (!mmu_status())
> > > +       if (!mmu_status()) {
> > > +               __asm_invalidate_tlb_all();
> > >                 mmu_setup();
> > > +       }
> > >
> > >         /* Set up page tables only once (it is done also by mmu_setup()) */
> > >         if (!gd->arch.tlb_fillptr)
> > >                 setup_all_pgtables();
> > >
> > >         invalidate_dcache_all();
> > > -       __asm_invalidate_tlb_all();
> > >         set_sctlr(get_sctlr() | CR_C);
> > >  }
