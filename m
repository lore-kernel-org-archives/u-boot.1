Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32928CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 13:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9260F836D1;
	Tue,  4 Nov 2025 14:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2kxzRgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3106D8004F; Tue,  4 Nov 2025 11:40:43 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAFB28003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-8eafd5a7a23so3785283241.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762252839; x=1762857639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vhmlikf0wPsp0BkJ//k01a+njZHaVX0c/QBMjRJkIN4=;
 b=F2kxzRgNkLrTc1sMpEsw4w3PfgsZAyk67YlsYYhlHmcqbBsXo4fnC8AXUHxxY/GmJy
 /q/h3x/r6dQFMPyEL2G97qoh2gkLfSHsiGmfdVp5q7cLh8lUa/hynmogKKV6O/Nbf4rI
 wIdvK7Wf37VfZgL1Ltxo3E/09wWnt6qIwOPiPF7GJ9RH8nqToGJupPRBlIIJNR2glko3
 f7RKKWyuu4t4I4rCy4QL/r0jYseoMBrfRzVhSgeUtVVGFtfcX1lRaFlukVCTTw6nDUvN
 fOl/hG21c51jHRwGe2kjau7VFWFUv02tAUMqujlwH0MU0M594rizge302JnPdIWUTdPZ
 a0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762252839; x=1762857639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vhmlikf0wPsp0BkJ//k01a+njZHaVX0c/QBMjRJkIN4=;
 b=RFPUCpqemhVow65KUj6ZYwYptUqYijDXKhm+8v0l9z7RbwFIs6mBWjlnwqTPCOokp3
 0KxSU9FwtD85bqSlo8wkzWuwehuw2GMinu5lYgSAMo8xc9e9QDbk0oIfkvmoM9Qig58p
 /dz0Rtg+opAsmf8ibCbq2xyS527FVFelOWcJeL3+MB11TmD9houOLISLw4duw2VoeL9X
 n3D8PpHtYdKfT4MTxvd6s7cxBNX2KZlHb/DOgHKAeOrpAibUG191mcExUdvuSbexIC8b
 wb8nCufp/9zzwEkKNLIHLySMY4u16H7VAL4AraUrnpSC0Sejqcv9tAL/h6nP4zb3ymNa
 iQpA==
X-Gm-Message-State: AOJu0YwkHYLa7OXPY9L1fdaCDt0Uo18BOhdw9MZ1ebtMlLlUc+0Fx14t
 2ZZJBbyu5wZRjKLh/qVznzfFUTJbx8UlZpe0CUySjgHGBumodJnQQu+nJ08DPpxzLkj5n28+WgW
 rnm4BOuzb6UJ8UXuJs+Q6gHXY95HS1b8=
X-Gm-Gg: ASbGnctU2TLq6vcKn8DoiNNKrL76KJZS4vrKjGvop8FSJIhu4uuBBwR8oQzffHTB0oP
 ktxkrssmYtD9tVTfzaxttTk+hkqNR9cHlzoi5tPo6YVRP/WgbVLUlMu9lWaLcfg9QdHIqlvTM7P
 NKiL2ECWutlV8n9omUbFnnRlcyTRCIzY2V7NuTuSQotWp5q9tEokkxoN0TKOQ5nWvl0+HNXyYVS
 MzSpYwzB59DBpA9L+gUQpRKncdBfJCcW+AKGW+hpSyv+/9EHHH5sl7+uw+oYQ==
X-Google-Smtp-Source: AGHT+IGFxZYwQW3Iwj2J2Vpa5KAMKOVeU1xcZ33cGRWgS44cxjA4R7tyTXUKXB00wl/C4BW6Uu1tlr8Bew+Q+jczKMU=
X-Received: by 2002:a05:6102:2923:b0:5db:e2f8:cf35 with SMTP id
 ada2fe7eead31-5dbf7ac0e60mr993192137.3.1762252839355; Tue, 04 Nov 2025
 02:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
 <176192343323.290092.16053648607478981549.b4-ty@kernel.org>
 <87tszb2ts7.fsf@kernel.org>
In-Reply-To: <87tszb2ts7.fsf@kernel.org>
From: george chan <gchan9527@gmail.com>
Date: Tue, 4 Nov 2025 18:40:28 +0800
X-Gm-Features: AWmQ_bk0rMpOPCiVmfkk_uHff4RH-QpC9A-1VyhGUqZS6AxZrgfJZIQh60AJSdo
Message-ID: <CADgMGSssT8veYtjzwPTiyzLWcPZ0TWhAY_FzOV4KHOHRGjQYvw@mail.gmail.com>
Subject: Re: [PATCH] boot: bootmeth_android: Conditionally dependent on
 abootimg
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 04 Nov 2025 14:51:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

=E5=9C=A8 2025=E5=B9=B411=E6=9C=883=E6=97=A5=E9=80=B1=E4=B8=80 20:19=EF=BC=
=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=BC=
=9A

>
> Hi George,
> On Fri, Oct 31, 2025 at 16:10, Mattijs Korpershoek <
> mkorpershoek@kernel.org> wrote:
>
> > Hi,
> >
> > On Tue, 21 Oct 2025 00:36:33 +0800, George Chan wrote:
> >> If target u-boot img do not support androidboot v3 or greater,
> >> abootimg might not be necessary.
> >>
> >> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function
> `boot_android_normal':
> >>
> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_an=
droid_normal+0xd0):
> undefined reference to `set_avendor_bootimg_addr'
> >> aarch64-linux-gnu-ld.bfd:
> /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_an=
droid_normal+0xd8):
> undefined reference to `set_abootimg_addr'
> >> Segmentation fault (core dumped)
> >>
> >> [...]
> >
> > Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu
> (u-boot-dfu)
> >
> > [1/1] boot: bootmeth_android: Conditionally dependent on abootimg
> >
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b493b966439=
0e16f61a6409ec60676df7759c7b
>
> This patch causes CI to fail:
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/1283315
>
> """
> building current source for 1 boards (1 thread, 8 jobs per thread)
>    sandbox:  +   sandbox
> +cmd/abootimg.c:26:6: error: redefinition of 'set_abootimg_addr'
> +   26 | void set_abootimg_addr(ulong addr)
> +      |      ^
> +include/image.h:2042:13: note: previous definition is here
> + 2042 | void __weak set_abootimg_addr(ulong addr) {}
> +      |             ^
> """
>
> This can also be reproduced locally by building sandbox:
>
> $ make sandbox_defconfig
> $ make
>
>
> Can you have a look please? I will have to drop this from my branch
> until the build error is resolved.
>
> If you find a fix, please send a v2 of this patch with the fix included.
>
Thx for testing and report. I am sorry that not available for some time so
please drop this patch or find volunteer to follow this up.

Regards,
George


> Thanks
> Mattijs
>
> >
> > --
> > Mattijs
>
