Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE95CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB0224061B;
	Mon,  5 Oct 2026 11:46:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1IyKO1WDTowj; Mon,  5 Oct 2026 11:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 021C54060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200785;
	b=DK+H8nF3IfYSINJiQR53erwIyfTkeU7cC2UYGDPX9/ZzNZSj3rS6RGehvOfAoLCvrZUX
	 +poSm7mmCWpr5KRub8CeWdT586p8s8FRR+gRZNYKFOSs7Gvd/mt1m+PTY9ALNY1c6D5K0
	 H8zNEmp9tBXfyqmYssgKo49ntyDxI1cyHIFiFEaAfOdGRho53OLZy/MAKkd9IQPtrthG7
	 vyJ3ut0ttXPJ+rrxJ5kk6e9MPKYGHDZF+2l1jLMqP6iUBFnnwQHLEFka9Q1STWtzCoi7f
	 K5pkCqaEccwizRmIW/VZI/QwC8GQVwv3MyMyP3rzTIGw3Ob8IN/a0+h624Rddo/KVLw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RVN4cag+9BZifkJSRuPqTycgRbgLagaEPPJ9x06VqDo=;
	b=LOZ5yqIQil5S3QVXOiHVmQPchAMNKqZE+djyPqIaUL49/tg0LHKZLB2kJA4tcVNpl2Ui
	 vS599J2v1ZZg9UgycHlDmvNzl6rjJOjtlDMw9EhYH0biKGbPJuvXXCKCOBHIIJCejiteI
	 kSN2sIXEumptQdSsH5ZTaSLK47djag9Evt+2Iala8fScRUzdSHbqMtb2y0CNNUNvibtGm
	 Mi1HPNCyPNRTDnBKiHrg7TSUY9VAR7P54VwHl9tKyAgwutXJEmwffO4Dx9trcs9NR6yoq
	 rL3vGocDjqRXrC8v1uRH1eM/q2ek9jD8v//iqhp/if6dgaaN9kSci3ycM5syjkUBPPQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcJCnVOR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200785;
	bh=RVN4cag+9BZifkJSRuPqTycgRbgLagaEPPJ9x06VqDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MCagXVeu93znSsGIB8kx7eMVILS9s4szTXoXdEdQ9+vv9hitokSX/e9iriC1EBpOV
	 PIErZfyRvlBWcqlZ/gOMfJR+TqjFWYWFDmD08tG2RMlUmzH7F9d8QftuOUVOXJxCq4
	 gebNUBeZEb5vlyQ/IKaS2dUFPHRIUD5EG8Eyg1EuPf/9PL6+2PTJL0IdvDfRpDaM/K
	 NVtiI16yN8eob8EnkL0QyxXAv8TgyV1MJIxylSc5Fu70qJNGINJYO95849XudstByC
	 egBbWZOVLVX2rbxVyPn43fypfgyPOXzlAv7WitqGDhY8a4VgEEhIhQodgjn65EdKQ4
	 wPt8ohzWdAZdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 021C54060F;
	Mon,  5 Oct 2026 11:46:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70F8075
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 572ED40609
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FCjUWI-OwMxE for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:44:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 55B504060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200676;
 b=fVbj/AzGXqrIgR9h0kt8rw8n4tA/PYgUCXEqA0Wd6zoD2HuRZ0DerI3xv4fhKJBKpkq9
 DsKU5rIE23iLzbM+88E5ftSgigYokmh/NfAaTOZdqDAGYsB11Qv6nG2KD74SGVA9MeDH0
 1bIwk3OOx0NgUP56TqoMVR/nlAgmEtCnpd2OYla+4lewahMEi8Kq8WcVOorUmrkdK4qJv
 2IMit5vBUNWAO07xSvFNM5gQEOEUaDCVE3gqVfY5qVpKFaYMGsOZIYFDgcLFNwWoTHhPC
 6WWqA44nBZb248Ae+m9psl5Kb+BVsf1JiMYHBMdnAmk2WtUnxH7dBSkA56jQ7plraDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=RVN4cag+9BZifkJSRuPqTycgRbgLagaEPPJ9x06VqDo=;
 b=GZ8BAu3ZzeS+TgdhTusErelvaSKQqUkt35pSVAH3Af0q8tqH/epVESCj9gCJJlQmjN5U
 zNr8iWi8TxmgC2jA2/lEKIB+r0CBjXA6NXEsLyqKQazThOHCkp+rrRn7CsHnFzyE0l+N4
 Sw9zoZGZssan7g2Sq4YtPJfpbeXjw18wL2glo6COjAQQu1zBJGtZikXjoG8HI+wpFj9BC
 8APNkOdO74cVLGBT7KU5nF9ToohPNjCBuZYsvLNpl+aaALdmd8vN7lebp6WNXWJNa9ibw
 B9G38LtOjMv8e4aAwbiNtCqShkY5RyZDVrFL7mrwmYsnW8KxdH5ZLwp8iSAT1c/791Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RcJCnVOR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RcJCnVOR
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55B504060F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:35 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2a1f611461so113223566b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 04:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791200674; cv=none;
 d=google.com; s=arc-20260327;
 b=PxywKBDDsAh0r4xKb4X6MxpBtoJ0Kg50xk3RACoUEfBjCOdcrBn4VXUCFzMxBeAwgT
 akU2RS4ufzz24n8GYSant/gXdqdIcBMLxBzGya1gZEBglIX33OAYKJSSlJUBS5y0trhi
 9Lz+/K4Xnc4RaxvSaRKJdAqHsiJ1mtbqbOv3brj+wV8UrPEOQ0MBUg6VE3o1v3uNpxzF
 coJcAT7O6xrIrEDMTT0OPGhe2g3aEAmZU7YA89N8TJSSUrbRQOMmnhfLfrU4p88txldD
 JB7AA6NfpcyQVAVpmS8Pnf5Felf7oAvU1STUxPSt3KStGUkEsQ1UytY7AWxC3kgitfFr
 MGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RVN4cag+9BZifkJSRuPqTycgRbgLagaEPPJ9x06VqDo=;
 fh=/Ygtq+gZ2l8xiS0AFt46C3d3BXs/1/rjuIW1Iajcot4=;
 b=LSa2FD63KVKfDCQuuAX2mqFaxcJ9tZiaAvOB4kF4oGX5I4qZu58fifDV9e5uwpwPS2
 Hmxy1LaPUb/ft09yhNjOk2CSMrbfJS2kMEQfaVC5gHQHN8nvK/M0vFVnRdoZMkc8jSc5
 sysJWwm6P7Alw6zcmKHY+I1efEsyuAoxm6Flq6uhJwefFnwA5DB7Vu3kEKUpwwwWs2/V
 pIVXJ3pEwAoFyTuWQLC/PecfzrqTdKjxBpW3cw/JxHh6DH6KM5y1860mF/lyZ50R74nd
 KoXhVBd/gcjZU3D1CnkEa5JvW4m37fX/VrHhQkbGrn6TzG7xatjrjxB7Z2BHqVwxorHv
 dKdg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791200674; x=1791805474;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RVN4cag+9BZifkJSRuPqTycgRbgLagaEPPJ9x06VqDo=;
 b=RcJCnVORue78s3P99VcAbTJf7d/OpaK2dZsWaF/MBITfyKt5X/cTnvq2cRQDMdRmg7
 1iFXImLL7lvOt3O7cpC/u8skrnH/pYJH+y1XRPeh9M8bpvUdIuFHGEFb3GRmT+t5I5w7
 yE1W1XD0qxrAkqJ+D7OUrj90k4gdnI2+aRcLrFVzMpwiueIrFbwVAVhxMVbq2LzljL6D
 sZoIpLjYhABskayDQoWJp75JgqxacOQJkKz+tw+FcU+WAkSL0Q5kIS11GEgLcCU/SdqW
 mSbt/QyhwmMj60XQWBSYOkIbL36BZVPLANZJWXb7imSZp2LSKQfRfgMM3qxUcvc5dQrv
 0nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791200674; x=1791805474;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RVN4cag+9BZifkJSRuPqTycgRbgLagaEPPJ9x06VqDo=;
 b=1JsSQU9835wzAmpjc+kkABZ4hxAKEr50ELVBP6aQF/fmGLgWHqF1EaGOLjBNpJkVT4
 IJTEHZf41hP/TIk7kmMdo3mEjtQN3roXqnsepEsC0KJ6O+gaySPIzwWqqZWBB3PNIR+N
 EtCcCpAacK1RnxLRNh5whkKtBfsUFD9Da9avU4gvgWo1bCdv6SQlhWX5kW4u+kF9qRQv
 MkFp4UMILz7uyKf2sn8gAXDC26daXx3bOiLm8W3SFklkxdH0zOZMMMwTV1+m1kxZdkjW
 PCHcWdPh/PvL6pxkNQWf6P2rlN8wZg58nOoktdIMyhqf2VtWXBCUzkCn2ZZ4McC/9MgN
 umcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0HG3YGyhL5yA35r16UTKJ2MtOMbWswgNb9fvJJzOoIqs2qDt/fYtVSnkn5A5SJOn0DtDd+uA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mT28U/Vb5YiBorMjLJ2EeEW+wSUR8AptWvqUbf4eXnvbh+pI98
 cOrIHQHgY+x79LBCjLXL9h4m/qYPCWTMBjgLD8ZTHlvSS+0Zc9RaA0Kji/k+nxJ4pAh42wZjqni
 IYNkM2VcdzU4DqoPmMaeFvk7/OYr5RPY=
X-Gm-Gg: AYBFou33vx3VLu8/CfN6kBbE/LJ6j/WAuF+7usDz5SVOhrv77FyH5yE7iScU4CV5fWf
 DFBceciN/O8yiiaaRBqhHZpsSN7aY6YxgnrIUQVXlVS1KjhwKIiIQEY34Si3KQ2EajImNIy9YNw
 yNpIpBT/mldL0qN2g492/zDmbfXNu+JBoweWbXh+ivmSPxENDK2ISP4rBtpmqK3LjzZpAr0cde3
 /UXRSOHXKA3BFqCCSO+BFBTGyL06gLqbf+Ky9ouOoF6L/T2BGYzpwXOZ2QuqCQBus1COgertWRR
 CTBpwR3Z13bd+Xj2T9ZxsQDcAgkxc0Q3S0rG8UYDHOkkIjhQ4dUbvJv5
X-Received: by 2002:a17:907:6d1f:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c2e4a675949mr961125466b.0.1791200673465; Mon, 05 Oct 2026
 04:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
 <d4dd19c0-2243-4f31-8693-02a25bd4a6c5@kwiboo.se>
In-Reply-To: <d4dd19c0-2243-4f31-8693-02a25bd4a6c5@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 5 Oct 2026 13:44:22 +0200
X-Gm-Features: AclHuK9BxA6VDZlj1t9pk4loYNRkGJKUrqk4Qqz1eZ9M1Wa9MXKlSo7u8jrXkcc
Message-ID: <CAC928HYDGxPsRWz3SatjTP7-d4GPo5ie6EdRpijxF6GUKEVOGQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
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

Hi Jonas,

Il giorno dom 4 ott 2026 alle ore 20:54 Jonas Karlman
<jonas@kwiboo.se> ha scritto:
>
> Hi Massimo,
>
> On 10/2/2026 6:36 PM, Massimo Pegorer wrote:
> > The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
> > guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
> > common/spl/Kconfig file where they are originally defined. Addition of
> > a second config statement without 'depends on' guard causes these two
> > options to be put in the configuration even when the guard is not
> > selected, which is unneeded and sounds wrong.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >  arch/arm/mach-rockchip/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > index 1a2e7847c9e..5ed774159be 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
> >       default y if ARM64
> >
> >  config SPL_BSS_START_ADDR
> > +     depends on SPL_HAS_BSS_LINKER_SECTION
>
> This change is causing make to prompt for SPL_BSS_MAX_SIZE when building
> e.g. tinker-s-rk3288_defconfig.
>
>   Maximum size in memory allocated to the SPL BSS (SPL_BSS_MAX_SIZE) [] (NEW)
>
> >       default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
> >       default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
> >       default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
> >
> >  config SPL_BSS_MAX_SIZE
> > +     depends on SPL_BSS_LIMIT
> >       default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
> >       default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
> >       default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
>
> Possible adding something like following?
>
>         default 0x8000 if !SPL_HAS_BSS_LINKER_SECTION

What about selecting SPL_BSS_MAX_SIZE default based on SPL_TEXT_BASE instead of
SPL_BSS_START_ADDR?

This seems to me more straightforward. As this configuration states, there are
cases where SPL_HAS_BSS_LINKER_SECTION (and thus SPL_BSS_START_ADDR) is not
needed, but SPL_BSS_MAX_SIZE is. Therefore, I would avoid a default definition
based on SPL_BSS_START_ADDR.

On the other hand, I've just noticed that the value is the same in the three
SPL_BSS_MAX_SIZE default statements, so it would probably be even clearer to
have something like (not tested yet):

config SPL_BSS_MAX_SIZE
    default 0x8000 if SPL_BSS_LIMIT

What do you think? Thanks for your revision.

Regards,
Massimo

>
> Regards,
> Jonas
