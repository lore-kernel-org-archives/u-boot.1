Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD1FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0C68439E;
	Sat, 25 Apr 2026 18:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TAZUg7js";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E3584329; Sat, 25 Apr 2026 18:31:30 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D5E8439F
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82f4a53ae20so6448812b3a.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777134686; x=1777739486; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SMcxqBjyhekbhHagpqRggnK/yLP41lq4pOLt1vuc5gI=;
 b=TAZUg7jsCA4dZ51HLc0jFOD3QAvbhUvBb4WITNtSfbiNkraMq4H7NIUTNYyYiNDRIt
 Ha15idwKflhJm8A9aEdg1z38VQWtD1fIhlaK/xGrYux3PfPUUDJlYOc1HOr0wgzv8yJO
 DBiRJMRjVLF74zKeFOAr6AucEDW0UTOmAAmeS04z08JYneP9sC2NJ1rs76bN9NjulnPk
 LtY+zmOqtjy2hNjDNkb5etoyKX4sOl/Ks0lOgL3XdXVfCfKKIM1IzI35gCIOsTIW/lf3
 HLGu1lyO/UDsqcAYvMvlgucZ37HByQ+k3Dz74g0Z8rbCiMXjIdz9VVQpyzG3tvfxUkX0
 0S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777134686; x=1777739486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMcxqBjyhekbhHagpqRggnK/yLP41lq4pOLt1vuc5gI=;
 b=JQoCnbFF/0t9PW192XlvBs7jyVQewvuU7YQXV3SJM9XCASGwOpuWN6vPtR+Pd6kCat
 8KkJ35fApRbyDWOnKuwIMUnAqzzyT5prPBmGfSREAh3Xmkj8sndjm+t9i7Iv07adyRXA
 R/rBrfxoTkvUowuypCJqVbGaqte2WiMkkP1n/qOMvMQXrxQy2a8MLAJuX4bg2mbcj1qi
 nOhcP48gGyhQpnbEleG95iPHDRl3JyeikCnz6pKzey/fuSewuKw3U4TOm6pcMdtgnFyL
 4uosBqahdrCDDHFhrvKIK1mQ9wTYBRURUGe2/+6nBZ4VL8V6b4KOk3RwPKH0qGu7Nzz6
 6ztQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tQ3GLXWX7s4u78NvTFf8CYJ3y+L8U74yxQyOgDT9dnBRjaY0tnNKZ0jO+xYQiCHE8wSFaKhU=@lists.denx.de
X-Gm-Message-State: AOJu0YyU9ikaU3u7GQH5MuGQMqGkuxGRXl6mYVHerExvhe+K+hlxVxSL
 8t1kj9HLgtX55lcYcm7JSCYMpSb+FMom+J3IByESzpLS+kN90jU4KTtN
X-Gm-Gg: AeBDieuQ7lpUCukakltUGFJS9uArXBhfdrteznq7fsv4HuFUdSsUQNvXoPCeo+ypzNW
 O2Ml8mYcTM6N52+GUpPX22tIn3uA0OdUi/oPG/tgkjQNPOeykZzWDMEcSQb0NKB/832qYVvcevo
 iibVLuuwsLbozrKIxt/oP7RwkCibteWluomv0XdycyUFGxd7B6U9daGjuHko3yyzUy64FN+UR8D
 7f9etjxiuLz5KI0a5/XFkhiox9YioDTJPKnC3zcpIU+k/Bb0uSYeYdeOCyn9JbdCb1sjsMJhDYn
 pzIZD8dWMD2zlZtJawUcZ1e6V8N7zijBxX5U7hMUP0rcYSV9LOTv0PHVXUm0OxDATwZ2TqY8jq4
 pa7pZZzFjnsxGJZTMtwVX9RZsbKjVXCZ6dmEe8vWN6beX6x6WOo4gLvgeEUhxo5FeXk0yelHylB
 ZuMjGKBQ8tOn2iqFC4xMtCnkhI0rwdCCVqin/4tITmeCMJk4k3DeqJjuYOTey8Wn6836+Peo/6V
 Lg=
X-Received: by 2002:a05:6a00:950c:b0:82c:d986:e917 with SMTP id
 d2e1a72fcca58-82f8c852df6mr38834463b3a.22.1777134685760; 
 Sat, 25 Apr 2026 09:31:25 -0700 (PDT)
Received: from google.com (61-230-36-6.dynamic-ip.hinet.net. [61.230.36.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec037e1sm32059737b3a.54.2026.04.25.09.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 09:31:25 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:31:22 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH 4/9] board: stmark2: remove old garbage
Message-ID: <aezsWmRecpa6fS48@google.com>
References: <20260416121431.20852-1-angelo@kernel-space.org>
 <20260416121431.20852-4-angelo@kernel-space.org>
 <aezrOFUXtdXpxJHu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aezrOFUXtdXpxJHu@google.com>
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

On Sun, Apr 26, 2026 at 12:26:32AM +0800, Kuan-Wei Chiu wrote:
> Hi Angelo,
> 
> On Thu, Apr 16, 2026 at 02:14:26PM +0200, Angelo Dureghello wrote:
> > Remove old erroneous garbage.
> > 
> > Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> > ---
> >  include/configs/stmark2.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/configs/stmark2.h b/include/configs/stmark2.h
> > index a7afbb3be1f..c1096398359 100644
> > --- a/include/configs/stmark2.h
> > +++ b/include/configs/stmark2.h
> > @@ -18,7 +18,6 @@
> >  		"load mmc 0:1 ${loadaddr_ramfs} uRamfs\0"	\
> >  	"kern_size=0x700000\0"					\
> >  	"loadaddr=0x42000000\0"					\
> > -		"-(rootfs)\0"					\
> 
> Since this line was introduced in patch 3, would it be possible to fold
> this change into that one?
> 
Please disregard my previous comment.
I misread the diff.

Regards,
Kuan-Wei
