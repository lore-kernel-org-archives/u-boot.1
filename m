Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6079C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 16:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4850C870E6;
	Mon, 30 Oct 2023 17:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jc5kAkJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAFA870E7; Mon, 30 Oct 2023 17:12:17 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600418701E
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 17:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b2e22a4004so3266974b6e.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698682332; x=1699287132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oodQJECNA1emt+ZSe7GuNR9wIJ3mag7w16SqLJjZ1IU=;
 b=jc5kAkJ87Lh8T09difIx/wldchInNlsEYCPFdUEFSAsbka5fU4Z3zAiuB4mSeXYpWS
 wPrbmK8ZbR9323fbRsMxgWSI0G7pcdOD0r8z+ZUFg6yJG0rNAKR+cIvMkMnJP3rU7pWW
 tBYU8kqNZKimX/Kp+hggh8dK6j40ifM0FTS4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698682332; x=1699287132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oodQJECNA1emt+ZSe7GuNR9wIJ3mag7w16SqLJjZ1IU=;
 b=upyd0C1epAd83cppM7PX6mED44nIWnH6b8fi+mt0Irim4RnI/uOFA8+f+avY3ZIshJ
 ICNEZY7ktLmGb3UMNWqciaYXbKb2W9sVr9r6Xu2hMO72vErWRZmyX4zaJo+JgM6163ji
 s9KVHwCSbjflMsqHjjzY4UMl23L3msRS9YaTg3uuBCxm1KhQG56u/Icyjv/pexLkjFSi
 JKy7TAgRq2qqtkt4196D2a+XBJAlS2POHWerZWpMEJdftlyqPNMFTqufPKGCDGXJD+ri
 Emb6bFp1XKOFC4JEyPJd75NboMRbG6ORMs3dTaJRBcsLG091tquf9Nzk7VKhf9rB6qMr
 Znog==
X-Gm-Message-State: AOJu0YwtCJ4VRogglrjqixcgFtJbthSBK1ktfon8zv3rgruzC8x+Fuhe
 aHpNlhE22aBtOiVsACtbNnyqjg==
X-Google-Smtp-Source: AGHT+IHoT9T9j+/Dof6wA/G/+AhrgWHz86krrYzaeW+fuocGkn8AxQnmYdn2G2hIALD+1WZYwAlU5Q==
X-Received: by 2002:aca:1816:0:b0:3ae:5743:533a with SMTP id
 h22-20020aca1816000000b003ae5743533amr10434767oih.47.1698682331961; 
 Mon, 30 Oct 2023 09:12:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 h19-20020a05620a401300b007778503ebf4sm3427889qko.16.2023.10.30.09.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:12:11 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:12:09 -0400
From: Tom Rini <trini@konsulko.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Simon Glass <sjg@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
Message-ID: <20231030161209.GU496310@bill-the-cat>
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
 <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
 <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk>
X-Clacks-Overhead: GNU Terry Pratchett
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

On Mon, Oct 30, 2023 at 03:35:34PM +0000, Russell King (Oracle) wrote:
> On Sun, Oct 29, 2023 at 05:46:12AM +1300, Simon Glass wrote:
> > Hi Masahiro,
> > 
> > Sure, but that is a separate issue, isn't it? We already support
> > various boot targets in arm64 but not one that includes the DTs, so
> > far as I can see. The old arm 'uImage' target is pretty out-of-date
> > now.
> 
> Does that mean it can be removed? ;)
> 
> I've NAK'd FIT support on 32-bit Arm in the past, and I remain of the
> opinion that boot loader specific packaging of the kernel should not
> be in the kernel but should be external to it - even more so given the
> multi-platform nature of 32-bit Arm kernels.

I'll point it out here rather than Simon. As part of
https://github.com/open-source-firmware FIT is a standard and not "boot
loader specific". And one of the points of a FIT image is that you can
easily support multi-platform kernels in a single file (without
optimizing things further, at a cost in tens of milliseconds on a Pi 3
anyhow) and with user-controlled security.

-- 
Tom
