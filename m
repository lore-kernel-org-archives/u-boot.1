Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707F4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 11:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D6C8757E;
	Tue, 31 Oct 2023 12:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qk/TI7Bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5986587CA0; Tue, 31 Oct 2023 12:46:10 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD5586579
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 12:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d134a019cso38316896d6.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698752766; x=1699357566; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7RyJr69Zjkg4/uGgk720yPGxk6Fi/nOg06RfMojBpdE=;
 b=Qk/TI7BxXd0ajJOay1meNJvQcIna5QWB3ulAr68lRnzuRpk+y2UOrVlcJfbyiElASv
 cbkaYrJat2TFMGtKwYo9ZswUnCzNDp2p+EcFYSrFiGaHS3bCGpMUhrS+WtXH1YpODvgZ
 tgCNiQOtrcuDfBNa7O8DkybzWzOspm4E64Pm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698752766; x=1699357566;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7RyJr69Zjkg4/uGgk720yPGxk6Fi/nOg06RfMojBpdE=;
 b=Q1VocmWV73XSB8ZPjZyLSc5E2lIaiHHG51KumPx6pQC0G3ZA45rJEnLFs5qU7WhEvF
 S5u+1KffwmXGsqKRRw9rqV57IC+8EIIh8d3nNryMIe/7S2w8pyO7SeNbURczoLgWMdjE
 goWrlxICIcNPO4FQJ+hPfPc3b633IOObcZZ0o8U6JH6aTNRGEM+/xCr7H8K3c+MVLv7X
 gil8afUth3RIQf8HQlVKvvHFSjyNuyHaiqDqyTOjUwpzLy0j77BGo4EkM9JeCMG0PJBr
 X6dWSbvs8q0qMZaK8ryAC547869Xp4wu8Hzy6cObwdnozZvbk44peP/ON+7YhOENFN1w
 zkyw==
X-Gm-Message-State: AOJu0YyVrIB1gwFWGxViPh1ZpEF53D505Cqb+l2gwskEu9MVpHNKcffg
 Oh4kKxYAAFKUvBWTKurdF+qwug==
X-Google-Smtp-Source: AGHT+IFTS994PF2eivbjl4D87zli4XLFKRYnso6wsgAbR5iJm+HvYpJK5Qak0c/vkJYa00RCMxjYZw==
X-Received: by 2002:ad4:5aa1:0:b0:66d:1b4c:e85e with SMTP id
 u1-20020ad45aa1000000b0066d1b4ce85emr15585877qvg.4.1698752766592; 
 Tue, 31 Oct 2023 04:46:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o5-20020a056214180500b0066d11743b3esm449095qvw.34.2023.10.31.04.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 04:46:06 -0700 (PDT)
Date: Tue, 31 Oct 2023 07:46:04 -0400
From: Tom Rini <trini@konsulko.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
Message-ID: <20231031114604.GG496310@bill-the-cat>
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
 <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
 <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk>
 <20231030161209.GU496310@bill-the-cat>
 <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
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

On Tue, Oct 31, 2023 at 04:03:18PM +0900, Masahiro Yamada wrote:
> On Tue, Oct 31, 2023 at 1:12 AM Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 30, 2023 at 03:35:34PM +0000, Russell King (Oracle) wrote:
> > > On Sun, Oct 29, 2023 at 05:46:12AM +1300, Simon Glass wrote:
> > > > Hi Masahiro,
> > > >
> > > > Sure, but that is a separate issue, isn't it? We already support
> > > > various boot targets in arm64 but not one that includes the DTs, so
> > > > far as I can see. The old arm 'uImage' target is pretty out-of-date
> > > > now.
> > >
> > > Does that mean it can be removed? ;)
> > >
> > > I've NAK'd FIT support on 32-bit Arm in the past, and I remain of the
> > > opinion that boot loader specific packaging of the kernel should not
> > > be in the kernel but should be external to it - even more so given the
> > > multi-platform nature of 32-bit Arm kernels.
> >
> > I'll point it out here rather than Simon. As part of
> > https://github.com/open-source-firmware FIT is a standard and not "boot
> > loader specific". And one of the points of a FIT image is that you can
> > easily support multi-platform kernels in a single file (without
> > optimizing things further, at a cost in tens of milliseconds on a Pi 3
> > anyhow) and with user-controlled security.
> >
> > --
> > Tom
> 
> 
> 
> It is a copy of the document in U-Boot.
> 
> The file was split into two, but the content is the same.
> 
> 
> [original in U-Boot]
> https://github.com/u-boot/u-boot/blob/v2023.10/doc/usage/fit/source_file_format.rst
> 
> 
> [flat-image-tree]
> https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/chapter1-introduction.rst
> https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/chapter2-source-file-format.rst

Yes, it would have been a bad idea to change a 15 year old format as
part of getting it included in some standards, and we'd also recently
cleaned it up to rST. Similar comments would I expect be true of turning
grub.cfg in to extlinux.conf and all of the organizations that has moved
along, and anything else that wasn't developed by committee at some
Standards organization.

-- 
Tom
