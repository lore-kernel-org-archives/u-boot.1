Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C55E6748B
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 23:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B972838E6;
	Sun, 21 Dec 2025 00:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LUXO8RHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC18C803F5; Sat, 20 Dec 2025 17:43:16 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2478A80050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 17:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so2408611b3a.3
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 08:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766248992; x=1766853792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fP0i+T1XQPIzknxzdRTbv6Inn4iDZ/bRya9T9v+SE/c=;
 b=LUXO8RHGAo9tvd66OoPyQkPcnlxA1iH7hFxsyF5aega7MS81MolvEYCLLnxCMd0x/H
 EwgkAHoZV/I/7zKa8u2FCfx1pTc4PADW4TQ9abLk0HwAnNpjt5OORVqrF91GApjj7rld
 VKD6B3S6ivIRrVuiuspCS+pf5vVFolS2Co8xg+XnhSK/ecTu+PfDLQ0iGzjv9ZB3MIB+
 vpxgTynSfqvy6OacV1r4/yyY7DomXGk0GENmAF5Uc2mfmwGFG9afGl235qqdtn6wxnpO
 8x9ZlvFegMkZqUtsAoX0TClKFMw/axBRCqJofJqn4bpCdOyPn+015FFKgRyDvWXICl/4
 ux0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766248992; x=1766853792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fP0i+T1XQPIzknxzdRTbv6Inn4iDZ/bRya9T9v+SE/c=;
 b=R7WCbzai8dIx/oGmZvFCMfh0xLi5qmovNhHHfHhqn0kBDGg+AbJuSOezPlJKQ0uNzv
 f+32YZ2NqBIgPaaSfiI5tpBV5DQNYQ8/PWaBGz5YWp4ZSFGgkoZ1zBx72ElGVInUFPYM
 vPIDF06ekb6aWvdRlubM1HlSY+gDHFcUTSrb6hZXdLnTyJwlEudz4YtyojK7BKVeVl2y
 tm9El/0ZaEF5hPCnDG+mwF8n0WudxYpfpmeMLxT5abDHtAZlpTXb8+8Pe9bohJBY9D5k
 k21xOhEFSb5Y3Afo8LDXg/jcYQciFKZoyQvDO6QmOQ+JUThvOn03lbMu6s0B+cTrB9S5
 vJHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEAbOWvApZxvwdU//uUkT1BlwSefnCvD/lELe4U6L6IYveVIp65jRaWOyNwMj3+8Dd95TlusM=@lists.denx.de
X-Gm-Message-State: AOJu0YymTVo2DZAiAJbRBqhloqq1Qh8cKNLD08IucMlb1TuhniB/zBgZ
 9nadAMJHd1yyrQFNcmZCfILf+qVvSYhkKi0Oo8jdRFx0gsWVO105f5I7Zmvmlg==
X-Gm-Gg: AY/fxX6kH2IBzpUL+vGQdRJfFXJB5+fbfyv55PnpzpTfTr71dBUDIDszgAxdGiNrYM5
 qzjuDwXD4IRTkhcGsIdugKhqYBKDJMABB1VtGuD6uoy9CR4I6C7fOsBUz4vk5PI07a/wQ6JGzMf
 Z9X8akEIGBpKWr02r9V1c1HPQPDdKZMq7TH59TahZzvmF0oiuNRaGpYSyYu/mQ2xaeArF9tf0YN
 lRgw+CTbK0k6g4i1K+m/ZSu0oCJICwTnZFbl+rWRiWmF9igReMqFlS0ZJtrQXkAesyf8OnTz9Y+
 OS+4ii+RbNjgTWXVX4aUli+/mOLrYhwA/eXcLmu+lPA31xSH6l3I+2LsFQ46cr3CzZoJTpGOpAX
 +A364mWOJRTAXv4EKL/rFhIpd7t/0R8HKukYq9zxhcsO10emOLf9VY33WCetyGdez7tPFF0TkK4
 dVMbhERuj/3gVPiZR3+IeMjS0=
X-Google-Smtp-Source: AGHT+IGqgMWe59SWv1ppK0f4TeqpleK79CVHNpwW4Ohf8qzdm0PpgYeGdJVbxXLOZ9lpIXpeDf+bDQ==
X-Received: by 2002:a05:6300:218d:b0:36a:f61b:68e2 with SMTP id
 adf61e73a8af0-376aa6ec93cmr5991766637.78.1766248992528; 
 Sat, 20 Dec 2025 08:43:12 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:15e:4c73:9b28:3ab7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7bd602desm5368395a12.21.2025.12.20.08.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 08:43:12 -0800 (PST)
Date: Sun, 21 Dec 2025 00:43:08 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] m68k: Add support for M68040 CPU
Message-ID: <aUbSHO5Z1w86MG1e@google.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-3-visitorckw@gmail.com>
 <20251218190032.GL303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218190032.GL303283@bill-the-cat>
X-Mailman-Approved-At: Sun, 21 Dec 2025 00:43:30 +0100
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

Hi Tom,

On Thu, Dec 18, 2025 at 01:00:32PM -0600, Tom Rini wrote:
> On Thu, Dec 18, 2025 at 06:52:51PM +0000, Kuan-Wei Chiu wrote:
> > Add support for the Motorola 68040 architecture. Currently, m68k
> > support in U-Boot is primarily focused on ColdFire (MCF5xxx) variants.
> > Introduce the necessary infrastructure to support the classic M680x0
> > series, specifically targeting the M68040 as emulated by QEMU.
> > 
> > The implementation includes exception vectors, early startup code, and
> > minimal CPU initialization and relocation stubs. It also defines the
> > standard m68k boot information structure used for passing hardware
> > information to the operating system. To ensure compatibility, ColdFire-
> > specific library objects such as cache and interrupt handling are
> > excluded from the build when M68040 is selected.
> > 
> > Additionally, apply a specific workaround during the early memory
> > reservation stage. Use a manual loop to clear global data instead of
> > the standard memset() function, as utilizing memset() at this point was
> > observed to cause a hang on the QEMU platform.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> [snip]
> > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > index 8ade6f7b9d1..a41c375f6be 100644
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -56,6 +56,9 @@ config MCF5441x
> >          select DM_SERIAL
> >  	bool
> >  
> > +config M68040
> > +    bool
> > +
> 
> The file is unfortunately inconsistent about tabs vs spaces, but all the
> new options should be tab-indent only, and no extra blank lines added.

I'll fix this in v2.

BTW, do you think it would be helpful to add a check in checkpatch.pl
to warn about space indentation in Kconfig files?

Regards,
Kuan-Wei

