Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF7CFD88F3
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 04:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A310D83F98;
	Wed, 11 Mar 2026 05:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ait/T3td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8543F83F9A; Wed, 11 Mar 2026 05:08:24 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2FE083F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 05:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-829b8b6c4d0so3508151b3a.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773202100; x=1773806900; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v9kuwBIddabm8F0jgiUWTr5DgX75WqVsqbTu4vY+9VM=;
 b=ait/T3tdsy68ECE0vupNnmZuYwri2ggpiCYEadcVEbr72yckAq02cbekBZCrZ2+2BJ
 zTXkb9kyudxI3rHcnBt2rLO23U5g030b/D2zCAbLdGZE6ygjxpEfhPgRI1qfmANcLrfn
 x+hQL9OmEnIjEoCRbYJoStjtMLEJSEjtLDkcYR3h7IcX1hFQNzHWMrthNo6Jug3WP575
 Az2ybYB4QKvLcvp+z2mRe9SCag7VS1kzcUwiO/7Ua5aC6w9spCO3T+8XUOE80I4qTEPG
 y6ZETmT5KsDEfvDZlrBRVB8SPAUSn2uLp4yJ2sFjLzX7dHnZusiT169PxjIyl+cG5oHX
 pyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202100; x=1773806900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9kuwBIddabm8F0jgiUWTr5DgX75WqVsqbTu4vY+9VM=;
 b=rlAJO8PCeI6+8GGokPZl8l4j8E96vS7V80wiablVwdG7dXZA4oj5gQZD/GIFng0pXz
 vr5A785ew7Kql0FzBKPIAE889bKzXEF01D1VttGGXcB8mKXexqmx2p3JLncIWkMgfS+x
 zDV/TGBZRB5G2xBupasmxMZp/jUfB6QjGa6lCNHG+8Ll3F/jQBXYbZ9QFLrA8K+/+y3G
 +Au6DZ2DsaavSHe/YeaC0O9oEy03E1RVnlKS5O/PItbi0jylOKKKcHHIX8yhADkTo7u5
 9TLFnS801JZr2pNA0HkXev41ila5Ki4h+UdY37vkr0H606QfG8Ec3q22gepuRmjMzJiQ
 dUAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+aLxgR6DD7Rt4N4l5bsL3LuZBPWsIhowzWOHCVzxlOGgq4TihUBhybWZqGB7ddZ37M9wwzC0=@lists.denx.de
X-Gm-Message-State: AOJu0YyPNXheZgomGAmCoKQjoD/3S+r3SlFWkLqf+YBEMtExsKjwOBG8
 TXucG5MZwbf48MrfbIn0l0ozh1oaJFwZq5Lxl85uDdPFQoscZxs4nM1YF0JncRKA
X-Gm-Gg: ATEYQzxQj95lpvtYO2McnSe1HhyojV4jaLM0PQ4B2qHbAte6CvlogqhI52IpkPgYLOq
 2jgPG5h09TiIszggDiHnZdLa8WzV1vZnTFtV79gvy7+LdYZ1UJkWIwssU2RE4SnC0473CbC0yL9
 wGkRyu5evKI7Ahu5cd+0QadbQWQIuBxWuMtc5c75hgtoFRcl9dH0aS31QSV+EBlvNhLA9M7cmIq
 YOLNZtMM1Ix2k0ZkZA9WVvFj2HfxsXiPg5nkPjcFZs9FcGU24fwjlXYYIuTgMkOIXuq5xkxcZ5A
 BSwSnI+e4ij6dHsD9sS64Zz2eZl/+TDWTNyOCf3OIE+ja+MtY+FLIdbSrd3G6d4MkYKpWMpdiFH
 m5tPvMGhNWD/e2I3SqHDf+tl2U4lpQKgLVD7yoSUVBc6mW7sjKd06pHVpwmjYNOYMqNbMddY/Em
 k+zkmX8uUDdrSj106hFROGVxvZoZgFTTA=
X-Received: by 2002:a05:6a21:38c:b0:398:8db5:4131 with SMTP id
 adf61e73a8af0-398c5e5a1a3mr988115637.9.1773202100298; 
 Tue, 10 Mar 2026 21:08:20 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:a723:406:553a:9d2e])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf92f7esm674900a12.22.2026.03.10.21.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:19 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:08:16 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Palmer <daniel@0x0f.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] serial: goldfish: Add debug uart support
Message-ID: <abDqsJq_4rPLu9lm@google.com>
References: <20260309105110.672832-1-daniel@0x0f.com>
 <aa-1OYXTCbsYImgr@google.com>
 <20260310162534.GK1388590@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310162534.GK1388590@bill-the-cat>
X-Mailman-Approved-At: Wed, 11 Mar 2026 05:27:13 +0100
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

On Tue, Mar 10, 2026 at 10:25:34AM -0600, Tom Rini wrote:
> On Tue, Mar 10, 2026 at 02:07:53PM +0800, Kuan-Wei Chiu wrote:
> > On Mon, Mar 09, 2026 at 07:51:08PM +0900, Daniel Palmer wrote:
> > > Add debug support for the goldfish tty so it can be used for
> > > early debugging. This will be really useful when adding support
> > > for relocation to the m68k qemu virt machine.
> > > 
> > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > ---
> > >  drivers/serial/Kconfig           |  8 ++++++++
> > >  drivers/serial/serial_goldfish.c | 18 ++++++++++++++++++
> > >  2 files changed, 26 insertions(+)
> > 
> > For the series:
> > 
> > Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > 
> > Hi Tom,
> > Would you take this patchset directly, or would you prefer a pull
> > request?
> 
> I will apply this to next directly, after it's been posted for about 2
> weeks to allow for other reviews.

Sure. Thanks!
I just wanted to clarify who would be picking it up after the review
period, so it doesn't fall through the cracks.

Regards,
Kuan-Wei
