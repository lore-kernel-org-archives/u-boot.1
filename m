Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68679C79FA3
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC1983E1B;
	Mon,  5 Jan 2026 17:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q0lahelQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508B083E2B; Mon,  5 Jan 2026 16:44:30 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6C583D6C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so70404b3a.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767627866; x=1768232666; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xb4IlEJ5gWereCtjW1Rai9noAapw6Gqc23IvyByF8/s=;
 b=Q0lahelQNTu2yoKmqbj5PeSj2AOydEw7CZgYu7jjXkdEsEUdHz7nEGtdcx0zhS0RKF
 eHJTdTbnDB63RTfIZA/fe1fsvGi3QpFcwnYRwRh47I6wLc6eTgboQ+PYjY9R6WNrgYoz
 9U2SDSwTfrI0uDKa5uPCPtQGagoBe9O59Gd/12UBKELqDvOXy2G/76N3i5sGV28Sxz6A
 7QDGB5SeT8wrsxHTI2hX0JDinSTKNia5OOd13RN5vTSTTFNtPpXe1iv6nMZO1huyHMLA
 GO+y/lfYrRsPaFD9HiPNxNaAe6TwiW55vz4IELAO2Ue4DePx3cNmlnLGT2uF1f0NqPHO
 aJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767627866; x=1768232666;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xb4IlEJ5gWereCtjW1Rai9noAapw6Gqc23IvyByF8/s=;
 b=RgbQSFhtmgEz8LfFP7gMBq1j+sXkBFXxDfITTc2JgrTiTiaVMFSbBIJkBpV2TX3030
 icc5vHLQrdxgC7mbrlpxVKtQoQCpB0ChO10cJHE24wZvAvJrsqeCcisiTBFPWgbQWft7
 857Y/Y+04oukUP6Msu8VqLlEUNBphJ7pGDul6NdG0+WESVL4SLOh808urjwRZT4nlaXH
 zGFJndnmmZCGq3jfwaKEgzJN2+4ZXNyCW03RN1gnepCpVsnAIVLGgw7NBTngINnF8Dlk
 BjGduUJQm6CC0nXENyhVrsDPYPoAFki99g4jfJZf5a757l42OvQlqxlnOrM9Hv4Nycb3
 VrNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJbgD45gd9EojIVhLyNOGuqTTyxZxVXthXlVkINLJnejHt4xKYyfl4JsXT6NaXJNT0XCJgwvA=@lists.denx.de
X-Gm-Message-State: AOJu0YxIaq8D0qVLJw+6tMM581xC0DmY97t5z6BC7iaycp4aW2NG6U3w
 JjDIRenunGAlNMEyLBkLJUxefaH0DRGho90z1QKxI6KWCnpl5fxM0DHn
X-Gm-Gg: AY/fxX7u5npQJmvVPR+VunbUupJWcoVMbvzOpMQV53KgEUzeogEznWmOT9md++R5/Xw
 IBZzJX0C8VmOD6Lw55tqvn74RHDkVxlIWdAKYL6n2f+KWX/kSzYPv0rb62Ijxsg9dz0MuKJ6S5s
 JqHThepXrEAtVm+sOvHSJ9LYxKWgwuL9Jl3ivDPFjuFKiwe+bMRci2yHnrOKN2CIj9bDv11pPZz
 lHjM3h45LhQMlXuN9ubyCTkc8tz3c+dZkxNqdh7G5FdFvOIItxg9sgLJE6Yf6YhKoDJQ/uHTw2c
 lwzn8RapGX4oWpTIIDvGRVoxMpmkaXp4cQUf1Cak35bIRVEEWt1KKA1SLY9lKQpmrScrBka+pcg
 05KsvRflBCf3wsOaEUhPzmmgvPLRvym6DwRYTXHdt/Xc6Mv+uVV30GmcSYgruXEi/8tBTDLRNd+
 u9vSjyfANGkTghThCa1sRVFV3b
X-Google-Smtp-Source: AGHT+IE1J35Bsw3JCWe01Nz0ZefbPvKA6o2vIKReBMpq9pMn5qqD9nVMjb6L7WLMu91jiLVDlu9N7w==
X-Received: by 2002:a05:6a00:44c8:b0:7e8:4587:e8cd with SMTP id
 d2e1a72fcca58-81885a195d7mr105349b3a.64.1767627865978; 
 Mon, 05 Jan 2026 07:44:25 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:404c:1ffa:1b31:6c49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8187994d444sm155269b3a.33.2026.01.05.07.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 07:44:25 -0800 (PST)
Date: Mon, 5 Jan 2026 23:44:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, alison.wang@nxp.com, angelo@kernel-space.org
Subject: Re: [PATCH v4 1/6] serial: Add Goldfish TTY driver
Message-ID: <aVvcVYKV9HVG_hFW@google.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-2-visitorckw@gmail.com>
 <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
 <855488fb-4ae9-4468-aa2e-68575ce4dc8e@canonical.com>
 <aVg9HhznRcwPLMeo@google.com> <20260102215125.GH6124@bill-the-cat>
 <aVhRVhPLF7Sx6vY1@google.com> <20260105144304.GL6124@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105144304.GL6124@bill-the-cat>
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:42 +0100
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

On Mon, Jan 05, 2026 at 08:43:04AM -0600, Tom Rini wrote:
> On Sat, Jan 03, 2026 at 07:14:30AM +0800, Kuan-Wei Chiu wrote:
> 
> > Hi Tom,
> > 
> > On Fri, Jan 02, 2026 at 03:51:25PM -0600, Tom Rini wrote:
> > > On Sat, Jan 03, 2026 at 05:48:14AM +0800, Kuan-Wei Chiu wrote:
> > > > Hi Heinrich,
> > > > 
> > > > On Fri, Jan 02, 2026 at 09:40:39AM +0100, Heinrich Schuchardt wrote:
> > > > > On 1/2/26 09:29, Heinrich Schuchardt wrote:
> > > > > > On 1/1/26 18:54, Kuan-Wei Chiu wrote:
> > > > > > > Add support for the Google Goldfish TTY serial device. This virtual
> > > > > > > device is commonly used in QEMU virtual machines (such as the m68k
> > > > > > > virt machine) and Android emulators.
> > > > > > > 
> > > > > > > The driver implements basic console output and input polling using the
> > > > > > > Goldfish MMIO interface.
> > > > > > > 
> > > > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > > Reviewed-by: Yao Zi <me@ziyao.cc>
> > > > > > > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > > > > > 
> > > > > > Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > 
> > > > Thanks for the review.
> > > > 
> > > > > > 
> > > > > > > ---
> > > > > > > Changes in v4:
> > > > > > > - Support DT probing with platform data as a fallback.
> > > > > > > 
> > > > > > >   MAINTAINERS                      |   6 ++
> > > > > > >   drivers/serial/Kconfig           |   8 +++
> > > > > > >   drivers/serial/Makefile          |   1 +
> > > > > > >   drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
> > > > > > >   include/goldfish_tty.h           |  18 +++++
> > > > > > >   5 files changed, 142 insertions(+)
> > > > > > >   create mode 100644 drivers/serial/serial_goldfish.c
> > > > > > >   create mode 100644 include/goldfish_tty.h
> > > > > > > 
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index 6ce0bbce13d..da4a6e4d518 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -1259,6 +1259,12 @@ S:    Maintained
> > > > > > >   F:    drivers/misc/gsc.c
> > > > > > >   F:    include/gsc.h
> > > > > > > +GOLDFISH SERIAL DRIVER
> > > > > > > +M:    Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > > +S:    Maintained
> > > > > > > +F:    drivers/serial/serial_goldfish.c
> > > > > > > +F:    include/goldfish_tty.h
> > > > > > > +
> > > > > 
> > > > > Applying: serial: Add Goldfish TTY driver
> > > > > Patch failed at 0001 serial: Add Goldfish TTY driver
> > > > > error: patch failed: MAINTAINERS:1259
> > > > > error: MAINTAINERS: patch does not apply
> > > > > 
> > > > > Should a respin of the series be needed, please, check that the series
> > > > > applies to origin/next before sending.
> > > > 
> > > > To make sure I base the next version on the correct tree, should I base
> > > > it on the ColdFire tree's next branch:
> > > > 
> > > > https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
> > > > 
> > > > Or the main U-Boot repository's next branch:
> > > > 
> > > > https://source.denx.de/u-boot/u-boot.git
> > > 
> > > The main U-Boot tree. Custodian trees are not always up to date (and
> > 
> > Thanks for the clarification.
> > I will base v5 on the main U-Boot tree's next branch.
> > 
> > > with the renewed interest in m68k, I was going to ask if someone else
> > > would like to step up as co-maintainer as part of all of this, Angelo
> > > might like some help).
> > 
> > TBH, being relatively new to the U-Boot community, I'm not sure if I
> > have gained enough trust or shown enough knowledge of the m68k code and
> > development workflow just yet.
> > 
> > However, if help is needed, I'm happy to help review and test
> > m68k-related patches.
> 
> I understand, and yes, starting with reviewing things is fine. But this
> is also the most activity m68k has gotten in a decade or so, so I do
> believe you to be on the forefront of how the code is :)

Thanks for the kind words.

In that case, I'll append a patch to the end of the v5 series to add
myself to the m68k entry in MAINTAINERS (after Angelo), so I will be
notified of m68k patches to help with review and testing.

Regards,
Kuan-Wei

