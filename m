Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCFFE92722
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 01:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB0F8398D;
	Sun, 28 Dec 2025 02:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="NXI/PEJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA4083990; Sun, 28 Dec 2025 02:29:15 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AC183981
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 02:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34cf1e31f85so6610357a91.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 17:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766885351; x=1767490151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yec+pHDSeoCTKV0S3MsYt88PvWeBr6fRveRKUVs8tKM=;
 b=NXI/PEJepoVlB1CYWXCoXg70WAzFIcBVt5wWZbqB8r9CEUepW7+jz/tD9cM0WjOQ3t
 NFlEysLHLdGEIIfKRroc2edKRqATqLsbb/oTj+8zqBz9Yxzj+QNXV5hN4WvbctR1fX2I
 uUZihQnWgZVjM72o7KZpCOf0HOSsntA+vmAcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766885351; x=1767490151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yec+pHDSeoCTKV0S3MsYt88PvWeBr6fRveRKUVs8tKM=;
 b=K7/QUaMUGHMFpMmDLiwZJU0T4Gj6UYqXtxhHKfhuCvGjmJeUOU7z950Xlj0fdz7/xH
 SxOWlLG71Q8HoSF/CIiFfkwJ/jjH1wIzDea1jWbfvMZIJjDbC5wiuhTbIfxHNLJXk00y
 E4ePZeULcY3/STfmTlFTfKKQpoT7dQuNLG/UYH4K3B0WL3P60CNWUbbr5g+usLGAutl4
 +g3cUF/YGwCZfrXaJw2gNEJdBm9VLMc0Bn2QL+QS7TpFW6/JTD1kjHGOmOvPFXXixTgw
 QLjTj6TTSIKFjmh+FJljsXFYtPlUh62Cb/NsWjhyw20/mefd6z+tyiE15dSYx1BHqPZM
 yODQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGldd9E+iXb1zNA8olTJDxthKjGpvmEjvm3oT8Q5l+5ob/eCzDquRjFabfNex3shGzGamazgk=@lists.denx.de
X-Gm-Message-State: AOJu0YzbwcAAUSjAE719n1VqCmxEhP0slBpmw9PTSYaZHENiYCXT4vY3
 i1dMxdO8s70jXvPSdYsad6d2y3ILv0kOJ/lzGK8jSeRWhKO0Xkp+MMx4r5fYVtLSbUvwSnf3WXZ
 OHdMsfQgeJItdC4oxbBbj8f+sdStsoR8GWPMYwKfYTw==
X-Gm-Gg: AY/fxX4L4rT9mFk669nbw9cXMWrRqRl6wuWwbLVLvYNKLTaT91vuiJ/fwB6zYeuPYe2
 mN7+3TrpDUtQ3pTwXiil/bE7uScG0UokOgn9bbYxRjno6fsI4qRndRpRgYMfTkDFqW9bkENF0m9
 emJAl75mtiDgL4JI1TMtHFhuU5RiTtSEODYEVykVHb/gQE63c7H0sMljGwRcfFkxL+YF38OMJYH
 p24SI0P9Yu9xadfhdSPrB30wbKty7//xIAGf+G+BRuYS3+gV/4eqqinPuSzeoW9/Q8vjcNa
X-Google-Smtp-Source: AGHT+IFp8ahy4HHmTwvPjm7N3IvHb0Z6mHGCfU646YQKeEMAviVsfJn4UYZYY1wF+/FGbX2IOCfowyU0zXRsSmLuK6M=
X-Received: by 2002:a17:90b:224a:b0:343:684c:f8ad with SMTP id
 98e67ed59e1d1-34e9211c3c1mr24925775a91.4.1766885350720; Sat, 27 Dec 2025
 17:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-3-visitorckw@gmail.com>
In-Reply-To: <20251226175400.1154417-3-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 28 Dec 2025 10:28:59 +0900
X-Gm-Features: AQt7F2p__fePfqoJJClc-Ga3jtIlmtuQTrgciZU1Xgy9trmS_tMThmS5iaHUtgU
Message-ID: <CAFr9PX=JzXVa-HTvV-Cbw3m+kvwYP_7RiG_jE8+WW+KKG59unw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] m68k: Add support for M68040 CPU
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kuan-Wei,

On Sat, 27 Dec 2025 at 02:54, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> diff --git a/arch/m68k/cpu/m680x0/cpu.c b/arch/m68k/cpu/m680x0/cpu.c
> new file mode 100644
> index 00000000000..15e0c30980a
> --- /dev/null
> +++ b/arch/m68k/cpu/m680x0/cpu.c

> +void m68k_virt_init_reserve(ulong base)
> +{

> +       /* FIXME: usage of memset() here caused a hang on QEMU m68k virt. */
> +       for (i = 0; i < sizeof(*gd_ptr); i++)
> +               p[i] = 0;

Connecting GDB and single stepping to work out where it is going would
be helpful.

> +void relocate_code(ulong sp, struct global_data *new_gd, ulong relocaddr)
> +{
> +       board_init_r(new_gd, relocaddr);
> +}

I have this working so at a later date we can copy/paste that code and
clean it up.

> +unsigned long timer_read_counter(void) { return 0; }

Since there is now a goldfish RTC driver upstream
(drivers/rtc/goldfish_rtc.c) we could take the timer part from my
version (https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c)
and supply a real timer to the board. Right now I think anything that
uses delays will get stuck constantly reading back 0?

> +void __udelay(unsigned long usec) {}

Or maybe delays just won't happen?

Cheers,

Daniel
