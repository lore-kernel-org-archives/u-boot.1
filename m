Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757A8C25B75
	for <u-boot@archiver.kernel.org>; Sun, 26 May 2024 12:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2158800D;
	Sun, 26 May 2024 14:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YO7ZVIut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626768817B; Sun, 26 May 2024 14:19:02 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6198F87EBD
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 14:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jnhuang95@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-62a088f80f6so16489847b3.0
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716725938; x=1717330738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+7/yqqV4fvCMwT/nb7pNdFIuAIxY/5zMbVmiGBnrhhU=;
 b=YO7ZVIutUx6Swc8qQOI1pQpxSdkCrvW4R2bgGP5mCKJ2LaXWAOFXINIiZoVrt+BXoW
 7S7CUfsW66irFIIN9le5GJFy5Y+0AafyYGSbHrWxKsQCFgzY5SlcKsUcmU3QSWIg90R6
 /PF1WfBdGNwjuMKrPc3JpS8TQ4d9Ta/hQImeadZvUV+e2XvQe6Qnm/RnttBjcdH4EZ+O
 QAXrOyMNWDGTGURYtGWU2Ey8+16TcRCLaiytu70inMhG7wuML8Xi6E8Us89qUramIOED
 mApsQzSNc/xCPr9JHsInmMqC9LLMVzI4CXvs09NExEmwvjIb1c8Okry8zVcHD2Toq+1H
 P5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716725938; x=1717330738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+7/yqqV4fvCMwT/nb7pNdFIuAIxY/5zMbVmiGBnrhhU=;
 b=IN4dl67n7c0K+uVOyBLuVMRmK5yb00jde41Q68Op1bu0UJLXkwy9BENuy3MwSsjv6O
 DLeLcpfFslf7Ph/Kf6JQ9BrVRu66PsXB0s5BXhxwLOWh3hW2B+8iK4bFnEilbkmgIqZK
 yIRBztVxrTEI2NIFtU4n4DzysAX8KHil3/fkhlk6v5tmxGUTW87y86f5Gh0Gq8QNa9pa
 yalyJhsfYG59ubWN7GTJcivx5yBsZX5VvhVSO7sjzKW32/AKVOp4l8DmASdux2W4h7sL
 XE4nci+TgKFWWqr+xCxkl8eMWAQGnO27xWUsahcNpmFHYJq1CFJuNRszIkrInuDuRC8o
 zQyQ==
X-Gm-Message-State: AOJu0YwfVeW0m31xp+q+rFp5n1noFR5L+HdIIgtf23giAGG7vBd9rEov
 Zv+lo/RPGX1ESVo30zwSXfWh4RKrPBbplhwF9IcEqsuMj0nm9QcUx3RBuyDmZ3u1ZSkoVnx7Qhu
 QV23Cih42qzsAM5ETeytCTp9PaoQ=
X-Google-Smtp-Source: AGHT+IHOuAAv6EiQgMzalyTyA/WlNVzy889P156PVLrK+erFHJRqnQ6Z2m1nlwGAobUCant/lbfqYiE/ZIqDjCJ8i4I=
X-Received: by 2002:a05:690c:6e07:b0:622:f7df:aa0a with SMTP id
 00721157ae682-6283496bccemr68852227b3.22.1716725937912; Sun, 26 May 2024
 05:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-3-jnhuang95@gmail.com>
 <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com>
 <a9f890d4-555b-488f-85f8-8b22fdfd257b@linux.alibaba.com>
 <CANwerB1G8n57AfQ3CaH82CBPzQ8nvV=-Y5xRK6sVdnUZdj+SKw@mail.gmail.com>
In-Reply-To: <CANwerB1G8n57AfQ3CaH82CBPzQ8nvV=-Y5xRK6sVdnUZdj+SKw@mail.gmail.com>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Sun, 26 May 2024 20:18:50 +0800
Message-ID: <CAJfKizq3sof9dh=KSdoJBvgydSK7AUy3_ns6ms8pchyOrLE+0A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] lib/lz4: update LZ4 decompressor module
To: Jonathan Liu <net147@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, linux-erofs@lists.ozlabs.org, 
 xiang@kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Jonathan,

Could you please try the following patch ? It replaces all memcpy() calls
in lz4 with __builtin_memcpy().

diff --git a/lib/lz4.c b/lib/lz4.c
index d365dc727c..2afe31c1c3 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -34,6 +34,8 @@
 #include <asm/unaligned.h>
 #include <u-boot/lz4.h>

+#define LZ4_memcpy(dst, src, size) __builtin_memcpy(dst, src, size)
+
 #define FORCE_INLINE inline __attribute__((always_inline))

 static FORCE_INLINE u16 LZ4_readLE16(const void *src)
@@ -215,7 +217,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
    && likely((endOnInput ? ip < shortiend : 1) &
      (op <= shortoend))) {
  /* Copy the literals */
- memcpy(op, ip, endOnInput ? 16 : 8);
+ LZ4_memcpy(op, ip, endOnInput ? 16 : 8);
  op += length; ip += length;

  /*
@@ -234,9 +236,9 @@ static FORCE_INLINE int LZ4_decompress_generic(
     (offset >= 8) &&
     (dict == withPrefix64k || match >= lowPrefix)) {
  /* Copy the match. */
- memcpy(op + 0, match + 0, 8);
- memcpy(op + 8, match + 8, 8);
- memcpy(op + 16, match + 16, 2);
+ LZ4_memcpy(op + 0, match + 0, 8);
+ LZ4_memcpy(op + 8, match + 8, 8);
+ LZ4_memcpy(op + 16, match + 16, 2);
  op += length + MINMATCH;
  /* Both stages worked, load the next token. */
  continue;
@@ -416,7 +418,7 @@ _copy_match:
  size_t const copySize = (size_t)(lowPrefix - match);
  size_t const restSize = length - copySize;

- memcpy(op, dictEnd - copySize, copySize);
+ LZ4_memcpy(op, dictEnd - copySize, copySize);
  op += copySize;
  if (restSize > (size_t)(op - lowPrefix)) {
  /* overlap copy */
@@ -426,7 +428,7 @@ _copy_match:
  while (op < endOfMatch)
  *op++ = *copyFrom++;
  } else {
- memcpy(op, lowPrefix, restSize);
+ LZ4_memcpy(op, lowPrefix, restSize);
  op += restSize;
  }
  }
@@ -452,7 +454,7 @@ _copy_match:
  while (op < copyEnd)
  *op++ = *match++;
  } else {
- memcpy(op, match, mlen);
+ LZ4_memcpy(op, match, mlen);
  }
  op = copyEnd;
  if (op == oend)
@@ -466,7 +468,7 @@ _copy_match:
  op[2] = match[2];
  op[3] = match[3];
  match += inc32table[offset];
- memcpy(op + 4, match, 4);
+ LZ4_memcpy(op + 4, match, 4);
  match -= dec64table[offset];
  } else {
  LZ4_copy8(op, match);
diff --git a/lib/lz4_wrapper.c b/lib/lz4_wrapper.c
index 4d48e7b0e8..e09c8d7057 100644
--- a/lib/lz4_wrapper.c
+++ b/lib/lz4_wrapper.c
@@ -80,7 +80,7 @@ int ulz4fn(const void *src, size_t srcn, void *dst,
size_t *dstn)

  if (block_header & LZ4F_BLOCKUNCOMPRESSED_FLAG) {
  size_t size = min((ptrdiff_t)block_size, (ptrdiff_t)(end - out));
- memcpy(out, in, size);
+ LZ4_memcpy(out, in, size);
  out += size;
  if (size < block_size) {
  ret = -ENOBUFS; /* output overrun */


Thanks,

Jianan
On 2024/5/26 16:06, Jonathan Liu wrote:

Hi Gao,

On Sat, 25 May 2024 at 02:52, Gao Xiang <hsiangkao@linux.alibaba.com>
<hsiangkao@linux.alibaba.com> wrote:

Hi,

On 2024/5/24 22:26, Jonathan Liu wrote:

Hi Jianan,

On Sat, 26 Feb 2022 at 18:05, Huang Jianan <jnhuang95@gmail.com>
<jnhuang95@gmail.com> wrote:

Update the LZ4 compression module based on LZ4 v1.8.3 in order to
use the newest LZ4_decompress_safe_partial() which can now decode
exactly the nb of bytes requested.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com> <jnhuang95@gmail.com>

I noticed after this commit LZ4 decompression is slower.
ulz4fn function call takes 1.209670 seconds with this commit.
After reverting this commit, the ulz4fn function call takes 0.587032 seconds.

I am decompressing a LZ4 compressed kernel (compressed with lz4 v1.9.4
using -9 option for maximum compression) on RK3399.

Any ideas why it is slower with this commit and how the performance
regression can be fixed?

Just the quick glance, I think the issue may be due to memcpy/memmove
since it seems the main difference between these two codebases
(I'm not sure which LZ4 version the old codebase was based on) and
the new version mainly relies on memcpy/memmove instead of its own
versions.


Would you mind to check the assembly how memcpy/memset is generated
on your platform?

Here is the assembly (-mcpu=cortex-a72.cortex-a53 -march=armv8-a+crc+crypto):
000000000028220c <memset>:
#if !CONFIG_IS_ENABLED(TINY_MEMSET)
        unsigned long cl = 0;
        int i;

        /* do it one word at a time (32 bits or 64 bits) while possible */
        if ( ((ulong)s & (sizeof(*sl) - 1)) == 0) {
  28220c:       f2400803        ands    x3, x0, #0x7
  282210:       540002c1        b.ne    282268 <memset+0x5c>  // b.any
                for (i = 0; i < sizeof(*sl); i++) {
                        cl <<= 8;
                        cl |= c & 0xff;
  282214:       92401c26        and     x6, x1, #0xff
        unsigned long cl = 0;
  282218:       d2800004        mov     x4, #0x0                        // #0
  28221c:       52800105        mov     w5, #0x8                        // #8
                        cl |= c & 0xff;
  282220:       aa0420c4        orr     x4, x6, x4, lsl #8
                for (i = 0; i < sizeof(*sl); i++) {
  282224:       710004a5        subs    w5, w5, #0x1
  282228:       54ffffc1        b.ne    282220 <memset+0x14>  // b.any
                }
                while (count >= sizeof(*sl)) {
  28222c:       cb030045        sub     x5, x2, x3
  282230:       f1001cbf        cmp     x5, #0x7
  282234:       54000148        b.hi    28225c <memset+0x50>  // b.pmore
  282238:       d343fc43        lsr     x3, x2, #3
  28223c:       928000e4        mov     x4, #0xfffffffffffffff8         // #-8
  282240:       9b047c63        mul     x3, x3, x4
  282244:       8b030042        add     x2, x2, x3
  282248:       cb030003        sub     x3, x0, x3
        unsigned long *sl = (unsigned long *) s;
  28224c:       d2800004        mov     x4, #0x0                        // #0
                        count -= sizeof(*sl);
                }
        }
#endif  /* fill 8 bits at a time */
        s8 = (char *)sl;
        while (count--)
  282250:       eb04005f        cmp     x2, x4
  282254:       540000e1        b.ne    282270 <memset+0x64>  // b.any
                *s8++ = c;

        return s;
}
  282258:       d65f03c0        ret
                        *sl++ = cl;
  28225c:       f8236804        str     x4, [x0, x3]
                        count -= sizeof(*sl);
  282260:       91002063        add     x3, x3, #0x8
  282264:       17fffff2        b       28222c <memset+0x20>
        unsigned long *sl = (unsigned long *) s;
  282268:       aa0003e3        mov     x3, x0
  28226c:       17fffff8        b       28224c <memset+0x40>
                *s8++ = c;
  282270:       38246861        strb    w1, [x3, x4]
  282274:       91000484        add     x4, x4, #0x1
  282278:       17fffff6        b       282250 <memset+0x44>

000000000028227c <memcpy>:
__used void * memcpy(void *dest, const void *src, size_t count)
{
        unsigned long *dl = (unsigned long *)dest, *sl = (unsigned long *)src;
        char *d8, *s8;

        if (src == dest)
  28227c:       eb01001f        cmp     x0, x1
  282280:       54000100        b.eq    2822a0 <memcpy+0x24>  // b.none
                return dest;

        /* while all data is aligned (common case), copy a word at a time */
        if ( (((ulong)dest | (ulong)src) & (sizeof(*dl) - 1)) == 0) {
  282284:       aa010003        orr     x3, x0, x1
  282288:       f2400863        ands    x3, x3, #0x7
  28228c:       54000120        b.eq    2822b0 <memcpy+0x34>  // b.none
  282290:       aa0003e4        mov     x4, x0
  282294:       d2800003        mov     x3, #0x0                        // #0
                }
        }
        /* copy the reset one byte at a time */
        d8 = (char *)dl;
        s8 = (char *)sl;
        while (count--)
  282298:       eb03005f        cmp     x2, x3
  28229c:       540001e1        b.ne    2822d8 <memcpy+0x5c>  // b.any
                *d8++ = *s8++;

        return dest;
}
  2822a0:       d65f03c0        ret
                        *dl++ = *sl++;
  2822a4:       f8636824        ldr     x4, [x1, x3]
  2822a8:       f8236804        str     x4, [x0, x3]
                        count -= sizeof(*dl);
  2822ac:       91002063        add     x3, x3, #0x8
                while (count >= sizeof(*dl)) {
  2822b0:       cb030044        sub     x4, x2, x3
  2822b4:       f1001c9f        cmp     x4, #0x7
  2822b8:       54ffff68        b.hi    2822a4 <memcpy+0x28>  // b.pmore
  2822bc:       d343fc43        lsr     x3, x2, #3
  2822c0:       928000e4        mov     x4, #0xfffffffffffffff8         // #-8
  2822c4:       9b047c63        mul     x3, x3, x4
  2822c8:       8b030042        add     x2, x2, x3
  2822cc:       cb030004        sub     x4, x0, x3
  2822d0:       cb030021        sub     x1, x1, x3
  2822d4:       17fffff0        b       282294 <memcpy+0x18>
                *d8++ = *s8++;
  2822d8:       38636825        ldrb    w5, [x1, x3]
  2822dc:       38236885        strb    w5, [x4, x3]
  2822e0:       91000463        add     x3, x3, #0x1
  2822e4:       17ffffed        b       282298 <memcpy+0x1c>


I tried enabling CONFIG_USE_ARCH_MEMCPY=y, CONFIG_USE_ARCH_MEMSET=y in
the .config (but leaving it disabled in SPL/TPL) and it results in
Synchronous Abort:
U-Boot SPL 2024.04 (Apr 02 2024 - 10:58:58 +0000)
Trying to boot from MMC1
NOTICE:  BL31: v1.3(release):8f40012ab
NOTICE:  BL31: Built : 14:20:53, Feb 16 2023
NOTICE:  BL31: Rockchip release version: v1.1
INFO:    GICv3 with legacy support detected. ARM GICV3 driver initialized in EL3
INFO:    Using opteed sec cpu_context!
INFO:    boot cpu mask: 0
INFO:    plat_rockchip_pmu_init(1203): pd status 3e
INFO:    BL31: Initializing runtime services
WARNING: No OPTEE provided by BL2 boot loader, Booting device without
OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
ERROR:   Error initializing runtime service opteed_fast
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x200000
INFO:    SPSR = 0x3c9
"Synchronous Abort" handler, esr 0x96000021, far 0x2957e1
elr: 000000000020233c lr : 000000000026a388
x0 : 00000000002fbf38 x1 : 00000000002957e1
x2 : 0000000000000008 x3 : 0000000000000065
x4 : 00000000002957e9 x5 : 00000000002fbf40
x6 : 0000000000000065 x7 : 0000000000000003
x8 : 00000000002c7960 x9 : 000000000000ffd0
x10: 00000000002fbc5c x11: 00000000000132e8
x12: 00000000002fbce8 x13: 00000000002c7960
x14: 00000000002c7960 x15: 0000000000000000
x16: 0000000000000000 x17: 0000000000000000
x18: 00000000002fbe30 x19: 0000000000000007
x20: 00000000002957d8 x21: 0000000000000009
x22: 000000000029d189 x23: 0000000000000020
x24: 00000000002fbf38 x25: 00000000002957e7
x26: 00000000002957b2 x27: 0000000000007fff
x28: 0000000000000000 x29: 00000000002fbcc0

Code: a9001c06 a93f34ac d65f03c0 361800c2 (f9400026)
Resetting CPU ...

resetting ...


Thanks,
Gao Xiang

Regards,
Jonathan
