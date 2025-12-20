Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F58E668BB
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 23:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB468389A;
	Sun, 21 Dec 2025 00:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcowPmTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2236D803F5; Sat, 20 Dec 2025 17:40:10 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B377B80050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 17:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a09d981507so19267345ad.1
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 08:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766248800; x=1766853600; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aOqqpr6LZgsvSHvsSa3tailzu8qHHsoRbsAcNOWKaZI=;
 b=YcowPmTNKzC0/+ddP9wi9Bw7YuG8CYfVqgkZUi/1/kyzQmu3BVEDzrgNmicjp/Yzur
 n+P/T5SEvw9+PN+pb5/1k3AeVQgKRFbRvQaJcmZs5f2DNn4eQNqDbXeuO687/4Ruhzdg
 NBn8PNNqEa1fRvJBm1YywDm2R8CgYiI16mC5rFeXISDs1AvkFTPLDPCAokMPoqCZfdPS
 Ox+qrbv13EedUts7YqEOG/rtLqJRYvSSzndEOgvBCXOsk/m7B5LgIOmezCJJ9fEyBYhs
 VWuuEiyzE+ylSLVOF5UnqPZFR9YEYcvY5gr3b/cbTtAB8g9GD11QtKga25dhfnFkG02r
 7GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766248800; x=1766853600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOqqpr6LZgsvSHvsSa3tailzu8qHHsoRbsAcNOWKaZI=;
 b=p11rKrSX3w0BU1GTjNPZ/vSqA7XEQHG24DWLT/jXeWokyl4EccUvf/EZBlyfdSXlXl
 VGVfVsuqa/mlVaPOzf+he8RdBWFyc6tk3T7BOXwDZifZInvvzA/qsurihDH2IIu+9z11
 OqnfAoNqs+Sd3isnzV5jHFBbxa2ltN+HnsiRSqHCSMQPHrEoY2Zh40X9/10IjRWWgjDT
 DPmE2eiya+tCXJOuhUX3cZAw7N6hQDyfEm76d9u0e8V19fTMviJoCTXS+k83SvYLRjZc
 +s6nuLo2qALAiMDCV5MDkMUjro8zGZ98Hv0eArL8WakspgQLfVsM/r/ZbJOm/isIwEpW
 oQyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5vL2AaNe3+D7IjF1Vjxw8SgU4YMfb2vguZ9povN0f/dJtUUbd1teb/ummTLK9vJosAVrbdAE=@lists.denx.de
X-Gm-Message-State: AOJu0YzqHwbuSX/wbyzFEqHL0WdE1ngIBEOXkvrT2V8WSB2q6ikb0mF7
 pSyJ0UotxCyNowc8dIcGe0tFrcZDVj5WXOIm6uPsidl8jik/orgj/xZw
X-Gm-Gg: AY/fxX70anwSpRUxrVU9CZ6LZLKL8dEQj3MJ7hJuj7oEmYTcejF4lkaIDLYjUDgAlAn
 A9bjxcQjPrEAqoXSvCHLBoF9p/Vk9sK2mkFsBA/i8pCmf7SRWT5RE3Jj7O3Uv30i8A+HmeSvEgo
 aAG1/o8fPr0OZNHxU0rLmDoKOgrY0SqjaDhOaAQrHs6gzpG1/ZD26uUam92LHGvobuqlFopTCGT
 wXkdp40pA2vcUgGONgKrbOBp+q2fSeCQeexMv9rMnvwzef4P7WTNUuaiwBmQLjDOIZg7Oo1G8Ti
 1UkVDKqXfcIsL1CCH6rdB7vA4hEhM/rcX0NJ8hAlWaD71mPPxRQ3GyjGts8q0ZSEG0dG/K4dJZd
 J2Of1JXRzMtWbj7GjFbwheragGKTRwjoeW+WPIs8c8jBWtvijhlS163TLYLy9B5yqck9plxL6Pm
 PZ97SIYH+rBAM0+nYgAo/ciXs=
X-Google-Smtp-Source: AGHT+IFbZ1x8AlyaGfe4Q24/LSKOTFb/mSY9f7uWzJIKHhf5larvBfVMVCSQcbPPL4mE5YNmuDoF6g==
X-Received: by 2002:a17:903:32c5:b0:2a0:97ea:b1bd with SMTP id
 d9443c01a7336-2a2ca8f6621mr106805785ad.0.1766248799765; 
 Sat, 20 Dec 2025 08:39:59 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:15e:4c73:9b28:3ab7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66629sm54639905ad.14.2025.12.20.08.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 08:39:59 -0800 (PST)
Date: Sun, 21 Dec 2025 00:39:56 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] m68k: Add support for QEMU virt machine
Message-ID: <aUbRXMCDXyuhQu_A@google.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218190059.GM303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218190059.GM303283@bill-the-cat>
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

On Thu, Dec 18, 2025 at 01:00:59PM -0600, Tom Rini wrote:
> On Thu, Dec 18, 2025 at 06:52:49PM +0000, Kuan-Wei Chiu wrote:
> > Add support for the QEMU 'virt' machine on the m68k architecture. The
> > QEMU virt machine models a generic system based on the Motorola 68040
> > CPU and utilizes Goldfish virtual peripherals.
> > 
> > Currently, U-Boot's m68k architecture support focuses on ColdFire
> > variants. Expand this to include the classic M680x0 architecture,
> > implementing the necessary exception vectors, startup code, and a
> > bootinfo parser compatible with the QEMU interface. A driver for the
> > Goldfish TTY is also added to enable serial console output.
> > 
> > The implementation has been verified on QEMU targeting the M68040 CPU,
> > confirming successful hardware initialization and boot to the U-Boot
> > command shell.
> > 
> > Kuan-Wei Chiu (3):
> >   serial: Add Goldfish TTY driver
> >   m68k: Add support for M68040 CPU
> >   board: Add QEMU m68k virt board support
> 
> Well this is neat. The next step for v2 is to update both .gitlab-ci.yml
> and .azure-pipeslines.yml to run this target in the QEMU sections by
> where we already test another m68k platform via QEMU.

Thanks for pointing this out. :)
I'll take a look at those CI files.
I'm not sure how to verify the CI config changes locally, but I'll try.

Regards,
Kuan-Wei
