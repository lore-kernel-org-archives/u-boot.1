Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D7BC7115D
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 10:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C2C82CBB;
	Fri, 20 Jun 2025 12:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="soINMwbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7612A82CF4; Fri, 20 Jun 2025 12:53:40 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC6D80E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 12:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so11900875e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750416817; x=1751021617; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JagsejbD9yBFCvgrpOCTNkhxZwJtbbKIaAuP8Sz+lmg=;
 b=soINMwbLUHocHvnJWsb6TrcF4nwL5ybvjrF4A9gwbjavimeOUPy3cPGm/7a/hxVvBA
 yzpP2FWxBiZxzLqYa66zDpXDb01BRFtmHrGKTl1EhpoMTNhOiH0ytpXmKuWM7rNldn8V
 yR9dj2VqAzvm/yv+IZT/Epk6Z082zkl7zE2TshhU8bPEktvDq2e2k/pfj/pf6KhQsaUd
 /646Qs7y0MBMoIHxhbGPKMAqouja3/LSjEYcC0/RBx/aMo7D+Ejkrv6TEIZyNQdFOV/H
 iizCF5DFehQ9NzrR47ZiqbwMGV3WOSM85qUyh4X1MeeA26RyFtTXmKwRMe1HWh3LOrpc
 Fosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750416817; x=1751021617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JagsejbD9yBFCvgrpOCTNkhxZwJtbbKIaAuP8Sz+lmg=;
 b=S4aE+oEjfBKNzuhq5ItVGEsccvY21XNDP5gn7TpkdmmZHp2unGzSoLojqCcVZ9SS5V
 Hmfsd9/aED8oo91dSqbXDOKthcs9sNpdNM1k9AozvAwCHnnas2Ji8NCqXDxHDqoUTC1D
 6m4jjrkYWMZ4GtBEEw2z69BkHYqRMj8bL7iePnteXD3kREk5W3FERflBFipOh+MiCWFa
 cnelSZGpWS9BZ/ZKzJOos9+v32SPLA6nu4m78MkG9IGKLPZGucS7BGUhqzmPocf5+7US
 IDB5HKokIE7e1AKtpQSOC/U5/w7B9VHOQVOidrZFRqA5k+r6JMjQJjziI362vzceVj49
 LmUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdry6H/qLQdZeJcyUBPlE6Y/R1QKthfzTKaHh7V71+ysLqZFOFAXq/PDxMulUiH8ZOCxP9K+0=@lists.denx.de
X-Gm-Message-State: AOJu0YwlVk89SN7mVpdoSyeX7lsZK9hdUgNTTjVDtkcaKskPKjbmH9o4
 M0lnNJNd96cGNZ5iiXlOftVDl1eWtCQU45iY3Sk3lVapdRsN0lOIvS75HJpzERb4hco=
X-Gm-Gg: ASbGncuzRudvqVdE015vDgff3RmeIjCh+KfZvm/JTEsYqWsNkYyBW1MYNsCzv62oywZ
 CYijiEkBLQzMQkmtaWOzQWdu+cFDymDz/EIUZPDy7jBsQ+RNrJmvSu5Vi3OmFdqAAblchiy/asp
 a/dCSCa0L8JRjpZ85z99WhzJuTtjJETvqMkI8vJuPPXI0ufhUJed7ulqqpr5C2/Qnaig5dcVjV8
 lWsB+sqC4A4vKFmqw0dSOv9YQ+cHzPE1jcml/OOrif/FDsgqRcZRMw56ezgdwbhx+uYgCrcfT1l
 h/OIXUfYx0ChisN0xCRZt398kCwtcBaL0edeX2imT6etd4O8Mtay8XGeIkg/EzIn3+5PY5KygKn
 pFwVqq4lGFf+xhU92+6/mIAtFs+G6p7l0DqoDP8XX/ujTa/OIwNMa
X-Google-Smtp-Source: AGHT+IGRS4UKELwbrWqFPxKwU2umXwtAEpE5mfxC19v4pdrHO2ucfLrisGIXm6NOCERbTUUmksltPQ==
X-Received: by 2002:a05:600c:468e:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-453653c748amr23261375e9.0.1750416817120; 
 Fri, 20 Jun 2025 03:53:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453647082a2sm21424125e9.37.2025.06.20.03.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 03:53:34 -0700 (PDT)
Message-ID: <47e2ae8a-19b1-4841-bdde-e2994d1a7f70@linaro.org>
Date: Fri, 20 Jun 2025 12:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
To: Tony Dinh <mibodhi@gmail.com>, Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tony,

On 6/19/25 22:37, Tony Dinh wrote:
> Hi Jerome,
> 
> While fixing some ext4 file system problems on 2025.07-rc4, I ran into
> a problem booting a few Kirkwood boards. kwboot loaded the u-boot
> image,
> and then u-boot execution was frozen without anything going to the
> serial console. I did a bisect and found the commit that caused it.
> 
> https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02b8a75c1940
> 
> When I tried to reverse this commit, I had a build error like this
> "{standard input}:24246: Error: selected processor does not support
> `mrc p15,1,r3,c15,c1,0' in Thumb mode"
> 
> Currently, the only way to boot Kirkwood boards is to disable either
> CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
> 
> I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
> know if I can help with testing to troubleshoot this regression.
> 
> All the best,
> Tony

The problem seems to be that some arm32 instructions are inlined
inside thumb code and that's not allowed on this CPU without some
interworking instruction (bx, blx etc.). For example, consider
board_init_r(), is is mainly 16-bit instructions (Thumb):

006186a0 <board_init_r>:
board_init_r():
/home/jerome/work/u-boot/common/board_r.c:799
  6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
  6186a2:       b0ab            sub     sp, #172        @ 0xac
get_gd():
/home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
  6186a4:       464a            mov     r2, r9
...

but then suddenly:

/home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
  619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
writefr_extra_feature_reg():
/home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
  619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
                ^^^^^^^^
                32-bit arm instruction

I would expect some call to a *_from_thumb() veneer, such as in:

006009dc <do_bootm_qnxelf>:
[...]
/home/jerome/work/u-boot/boot/bootm_os.c:379
  600a02:       9501            str     r5, [sp, #4]
/home/jerome/work/u-boot/boot/bootm_os.c:384
  600a04:       f04a fc7c       bl      64b300 <__dcache_status_from_thumb>


0064b130 <__dcache_enable_from_thumb>:
__dcache_enable_from_thumb():
  64b130:       4778            bx      pc
  64b132:       e7fd            b.n     64b130 <__dcache_enable_from_thumb>
  64b134:       e59fc000        ldr     ip, [pc]        @ 64b13c <__dcache_enable_from_thumb+0xc>
  64b138:       e08cf00f        add     pc, ip, pc
  64b13c:       fffffb28        .word   0xfffffb28

We may need to move the inline functions with mrc/mcr to a .S file,
making sure it's built with -marm on CPUs that do not support Thumb2.
Then hopefully the proper interworking sequence would be inserted by the
linker as is the case when Thumb is calling into object files resulting
from .c files built with -marm (for example: arch/arm/mach-kirkwood/cpu.c
which has CFLAGS_cpu.o := -marm).

In the meantime, could you try the following patch?

diff --git a/common/Makefile b/common/Makefile
index 35991562a12..a509675335a 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -19,6 +19,8 @@ obj-y += version.o
 # # boards
 obj-y += board_f.o
 obj-y += board_r.o
+CFLAGS_board_f.o += -marm
+CFLAGS_board_r.o += -marm
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o

I think it should resolve the issue, but is does also increase the
size of the binary (+4 KiB). So the .S solution would definitely be
better if it works IMO. I'll try to propose something ASAP, will
likely be on Monday, feel free to give it a try by yourself though :)

Thanks,
-- 
Jerome
