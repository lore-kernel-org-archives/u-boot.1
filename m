Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51E2D7309B
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 04:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2789C840F1;
	Fri,  3 Apr 2026 06:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YT7zBqzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62A983D8A; Thu,  2 Apr 2026 21:43:34 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A7480212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 21:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82ce09b61beso617886b3a.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775159011; x=1775763811; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YooiDk+MBi0fFonVp+HBxgIK6iDDTGbZY8IzDHoaVlc=;
 b=YT7zBqzu6iyasaTrMf2aznRJYnUPHgvnhlfYbig2upHMRUpRQJzBVGWINN6eG9JNyG
 ICAvJPW2Ljji3QXJdx1hRIfsOuxGrjdDk17CaT8jXDuu42Ct8VkCBJw/lqdJ56kr61pX
 7avqss54vJy07emmn97NBSQI4pBW7etXlM97ADuye5EIuKm3xvuGhlHZjNNcioOFyf4G
 xNKdvYIVyfi8m0hqNLvPIap7Keczb966K2qCWsP+Hr6+Sr+k8q/s0WJlznzG4hK3qPy2
 XSGIF3HgVUaYTuZs+BgiEuElqrRJS6hMu8dxuY65jBcDsnzG5YK0PM9wL3h1JK+Q6tpv
 fXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775159011; x=1775763811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YooiDk+MBi0fFonVp+HBxgIK6iDDTGbZY8IzDHoaVlc=;
 b=tDqJ3rmGlec7MAesvgsU1LnedBr9c9RTPuQg/e3Ldht0g4IBujpU9w+9y4f22DIFcZ
 0Pkgek1YBKp4mAGY+SQfU+/yGVlaJuDQ+i9uKszyuo0oo78f/VahC65/Dfvdm7U7ji6z
 PJFwxyz202dxwxudHZ87bDBNo9z/kmTNYYw13Xcxcg53Jfb1jlnnbuVGC4jtGWvyV0YU
 WITWIyBSLFxkL7NGoNCSzJHIhdgdfCXQBHXvNVnp7CmY+Aat0GGhf+XuZpgEQ2F41fAD
 c7fj4pSopa78WcXNV1cAVxEJdB5x9Cdy9AW3ZTT4eNq7MHXsovr7FMOSrjagI7WmhoU1
 QUew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7SLl4DQ4hVVbqeYcwuWr9ZJbvGHGmUlQLDhi28Rb5RhSiVLTQei+hfdemtOX97/DSamYRo0A=@lists.denx.de
X-Gm-Message-State: AOJu0YyJLMIPW2annomWYuI+Fq4qooC6LbbHXBtHAyp7M1n6aYHN2Dcw
 TU79GgsASjoB8dGaMCpx4pQhGUKhLR2975gdDcCkD1nwNcUca86quPVJZJyymA==
X-Gm-Gg: ATEYQzxvxYjgazR8bUYff+8NnXkzBdWmmneAFd8sRf30yvxj3+1wpaJy/QnZtqgYqR1
 kaMTtANRic1JOhHzu/GL9FDAlawq1h2g7T8ishQKAOzAszjRMfJCAMhy4mTOmad32Vx5y/aqx+S
 c9qFysjVb+5Ptc2iRZYrJHbkR9NjmarHLAMsjaGEDLipi/vX8caWNqiaF9qjx5hucrEWDvjBXqF
 BQnMZETX5nmVSf/95oGbQjvGdms1m7XUJkVqoodl+eF8FWe0IAqry0yCGxo7ikvCU6wAKJxaJ9k
 7wgJZcZiMQCR20md1sqQckn46t24QVNwVxfp2Wb3SFEzwCjkZkiDT6IudV72iovLeNnjB8pp5eI
 2d7V1lgW75XJ1+Jdt7DwvuOwFUhduTTQ34lgsDLiVpopG1VGO+n3MWBJoAZeGFeefV/99obwgC2
 U24lSBxP2e8bZVLqifA7DXb5lNOFQgvIa4DA==
X-Received: by 2002:a05:6a00:3316:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-82d0d74799bmr435031b3a.0.1775159010625; 
 Thu, 02 Apr 2026 12:43:30 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c706f7sm3899972b3a.47.2026.04.02.12.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 12:43:30 -0700 (PDT)
Date: Fri, 3 Apr 2026 03:43:27 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, laurent@vivier.eu,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH 2/3] virtio: mmio: endian *fixes* *HACK*
Message-ID: <ac7G35VDs5TV4GCP@google.com>
References: <20260310135940.1756141-1-daniel@thingy.jp>
 <20260310135940.1756141-3-daniel@thingy.jp>
 <CAFr9PXn3abM6DcbfJBBbokBtQ02XrfK66jVtjCGo8+_V-mtkzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXn3abM6DcbfJBBbokBtQ02XrfK66jVtjCGo8+_V-mtkzw@mail.gmail.com>
X-Mailman-Approved-At: Fri, 03 Apr 2026 06:52:30 +0200
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

On Sat, Mar 14, 2026 at 05:53:17PM +0900, Daniel Palmer wrote:
> Hi all,
> 
> On Tue, 10 Mar 2026 at 23:01, Daniel Palmer <daniel@thingy.jp> wrote:
> >
> > From: Daniel Palmer <daniel@0x0f.com>
> >
> > This is an attempt to *fix* virtio mmio on the QEMU m68k virt machine.
> > As far as I can tell all of the registers in the virtio mmio regions
> > should be little endian so after reading them they need to be converted
> > to big endian for the code to work on them? other parts of the code
> > are also doing endian conversion so I'm not sure.
> >
> > Or QEMU is incorrectly giving big endian register values?
> > ---
> 
> I have a patch for this in my Linux tree too so I sent that:
> https://lore.kernel.org/lkml/20260314030612.1949420-1-daniel@thingy.jp/T/#mab66837bb90c30916fd0fc066245bdeb9918e96c
> It would seem our versions of readl(), writel() etc are broken. For
> Linux the nommu versions are broken, for u-boot it seems they are all
> broken. By broken I mean they should be expecting a little endian
> value from the access and then converting to the CPU endian. (I think)
> 

Sorry for the late reply.

So it sounds like we have to fix all the broken readl/writel() in both
Linux and U-Boot first.

For U-Boot, I think we need the following fix? (totally untested yet)

diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
index 35ad4a1c044..0106a57a03e 100644
--- a/arch/m68k/include/asm/io.h
+++ b/arch/m68k/include/asm/io.h
@@ -31,10 +31,10 @@
 #define writew(b,addr)         ((*(volatile u16 *) (addr)) = (b))
 #define writel(b,addr)         ((*(volatile u32 *) (addr)) = (b))
 #else
-#define readw(addr)            in_be16((volatile u16 *)(addr))
-#define readl(addr)            in_be32((volatile u32 *)(addr))
-#define writew(b,addr)         out_be16((volatile u16 *)(addr),(b))
-#define writel(b,addr)         out_be32((volatile u32 *)(addr),(b))
+#define readw(addr)            in_le16((volatile u16 *)(addr))
+#define readl(addr)            in_le32((volatile u32 *)(addr))
+#define writew(b,addr)         out_le16((volatile u16 *)(addr),(b))
+#define writel(b,addr)         out_le32((volatile u32 *)(addr),(b))
 #endif

 /*


Regards,
Kuan-Wei
