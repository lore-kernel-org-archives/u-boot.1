Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD55E674B5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 13:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5252183DEB;
	Mon, 22 Dec 2025 14:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f44jqNR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69B383E83; Mon, 22 Dec 2025 09:44:48 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A80183BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso38305465ad.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766393085; x=1766997885; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n4DHxWsodQqF/bQFklIOTjW6waOE3GQv8u3YcOHbG04=;
 b=f44jqNR1Uimv3fplaLioB2Guqmu+7yfxuFS0AGDzSE5vrrP3KcjM2/9mneJaJmUzDN
 Py5GQ4Nx62ymPJD4QE0KoqqEUmpnQCwYtXEtMZ1n2b1et+8UDnNenLqk6PuZRjQM3j+k
 g+jmOu/jx6EPK5329ehHv5bK7OL6N+ACRZdxz11sgWIbXtN61NSIBS88qkh9PqNygdjg
 UjfG0vMgXFxk+Mb8V7+yq9oPIisuJ01koca3FwFc4hx+MnbecSrsUJOwgxxULbUNzRb0
 7LN+mT63eeOcG3G0KYJw6OYHrAPY0mTFiiQ9gmpTx2bJ3iWVIICjUYyYh4YwkMcLuZKS
 c/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766393085; x=1766997885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4DHxWsodQqF/bQFklIOTjW6waOE3GQv8u3YcOHbG04=;
 b=AV5Fk5PP9PkmGmx6NWcC7S/GCnIJKTNM8CqQRmUqyhNJUiqSOxODWPGsCq3P0i+Wad
 64tTZRBtRICgk45uDNIrGl3fV/zla9TepdZu5LUjsVOvrDe3dBrRlqf4CmgWKMCqkTys
 HtpyW3uV2YOV3K2v/0ZclfijV76uCMvUc1MY9HrTV3pVweNrYZj7tsYohKB58KXa3qnY
 UZsEkM2FyGlQ9Yr1Dpdh1B1MXwqn/NYAbhWGuuoHFR+LynayGHIjsVNu3JaCmO+lsOsr
 QZAvrZiFBdNvqEVVBnvMZEm1mIxl+vBugyD+U+NJPmx96baQt0JodQZPfmgX84OUsGOB
 5apQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm7Xa4BjQlFrwqyY2EqhCQ1AadS+V79OlV87JmAVPS951ZyAcvvU9cJ2sVxMVLORt6cnql6R0=@lists.denx.de
X-Gm-Message-State: AOJu0YxQIEnvLRuGm3vXBQI8syW5hRBPk4aWpV9Ee+oLv9Rc3v3miXUX
 jOsmFiV72qyoFYzdqJciDT6Xyvu3jnrK+kYZHN14eBZ3ZghGqXBy2+l1
X-Gm-Gg: AY/fxX6Y0jeFXjeeOJIgNC5gt7rQVCQjXzWweGTr1/rF47Yiujiyzb08KBwlIN4GCc1
 i3t4eGk17nN1nBlxMDXS/cBa9P568SEUHeVr2DT30xe3jtf5nvefmxz7Wtv2jm+7grev7mB9xzh
 C18m8+snmOK1H3PHv9MoOcj2Gh/djh2vlIcebmW7XncI8D8ZqqnvPBdNMZVimBPiPECIwuota0s
 m7g2A8XMvPeH7l28d/Wm2Wma5tu7fUvH6LElyu1O3g12D9hQ+DqPF52f5PSzbTCvOKz286cxtm/
 cD2h7JfQ1g1xiqUPE3ncDF1fa9CvuAtLOvfYBIRbML74k6SpV2KbIdp+iy9noAWvwODS3nxvLgS
 NZdUdeIUJGoi3iSNHs/Q6SiUNBwSxeGSG5ZGP25CjslE7J90LIvcp/ehhsCGpKcNLQjFVkm7KH2
 rRMWZZvdnuzQbsjU2j58i1k8XcU3kPYw==
X-Google-Smtp-Source: AGHT+IE5Q9+FxKIN91PJt/xrq7ObhFUSauQhaC96UsqBGcK5PpqwCdBuUTu7jQBw4ymz9hVO9UGIdQ==
X-Received: by 2002:a17:902:c40b:b0:2a0:de4f:c99 with SMTP id
 d9443c01a7336-2a2f22030e7mr79342545ad.9.1766393084586; 
 Mon, 22 Dec 2025 00:44:44 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:c4df:6c40:67fe:ebe3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66465sm91984815ad.15.2025.12.22.00.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:44:44 -0800 (PST)
Date: Mon, 22 Dec 2025 16:44:41 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: Tom Rini <trini@konsulko.com>, alison.wang@nxp.com,
 angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] m68k: Add support for QEMU virt machine
Message-ID: <aUkE-dvbDyZA_Ewy@google.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218190059.GM303283@bill-the-cat>
 <CAFr9PXkk3eOYDZbjTvZPgT8Cv+Wd-+hiEA+hPZVOVD0BJZ378A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkk3eOYDZbjTvZPgT8Cv+Wd-+hiEA+hPZVOVD0BJZ378A@mail.gmail.com>
X-Mailman-Approved-At: Mon, 22 Dec 2025 14:55:13 +0100
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

Hi Daniel,

On Sun, Dec 21, 2025 at 01:15:18PM +0900, Daniel Palmer wrote:
> Hi Tom, Kuan-Wei,
> 
> On Fri, 19 Dec 2025 at 04:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 06:52:49PM +0000, Kuan-Wei Chiu wrote:
> > > Add support for the QEMU 'virt' machine on the m68k architecture. The
> > > QEMU virt machine models a generic system based on the Motorola 68040
> > > CPU and utilizes Goldfish virtual peripherals.
> 
> > Well this is neat.
> 
> I have had a messy version[0] of this that runs on 68000, 68030 and
> 68040 real hardware and virt for years..
> I thought no one would want it so never sent it.
> 
> I have devicetree for 000 and code to create bootinfo so that linux
> can boot on 020+ machines.
> Gist of probably the oldest cpu that can run the latest u-boot[1]
> 
> Can we work on this together to reduce duplication?
> 
> 0 - https://github.com/fifteenhex/u-boot/tree/mc68000
> 1 - https://gist.github.com/fifteenhex/eed03b250b6a0113ab08b69be0375aa1

Wow, this is fantastic! I wasn't aware that you had already done so
much work on this. I would love to collaborate.

However, I noticed that your branch contains over 100+ commits with a
diff exceeding 15k+ lines. Attempting to integrate such a massive
amount of code directly into this v2 series would be extremely
difficult and likely overwhelming for the review process.

My current goal with this patch series is to establish a minimal
baseline support for m68k in U-Boot (targeting QEMU 040 first). I think
the best approach would be to get this foundational series merged first
to serve as a minimal base, and I am more than willing to make
adjustments in this series to facilitate the future integration of your
work (000/030 support, Linux bootinfo handling, etc.) incrementally.

What do you think?

Regards,
Kuan-Wei
