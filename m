Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50633E674B2
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 13:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0D583E88;
	Mon, 22 Dec 2025 14:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kImsY2fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 553F683E70; Mon, 22 Dec 2025 10:04:01 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E7D83B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so46751315ad.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 01:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766394237; x=1766999037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M+vTvYgXElUumICRwAasux8z3olpSz5DRn0/4qVoVBQ=;
 b=kImsY2fpEpJZdOz/o774yq1eUcLDBh8DA4IioVC1Id3Hy0Xd1RBJ8CANveDCiouXUY
 7SWYm5tR4SVmzWGMosGKkWUVTzZcRb5FEUHJaWi5a6+zgkkIyxZ8922c4xoqNxgNIzE3
 qTY4vj09cRJ/SBDO3xjxeZfDJTETSRoHrtzCkzex3jVidGjkB/QvuAHSq/q+AYhmQ4j3
 y2WU3KNP9Xd6WcbN/S6qehQJVtD6T0M2brnMr4mNd6uaWuY0JGqa7GBFkWvwlk98vyB7
 yewHRn01GG428b3zZy+m1oy6IKNTuZsTiAvYsuBhLvxfo/QmGOx47lP+rgpS+ga9IZuG
 bEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766394237; x=1766999037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+vTvYgXElUumICRwAasux8z3olpSz5DRn0/4qVoVBQ=;
 b=um5a38d70io2Cu4beEe8ip2zw0EdncLI+sHwWT3f+qf/yiqLB4cgMu+JhP+TNIasnX
 aj/9vPbJvffMSvhKK/LjuXb6p4ISQWCwB92ClaQarbl3vuEXbd34vcZ/ZUvpmBHlAI0S
 rOb8zOSSHi3FeZv3FZMhOomb4uyLSYGxmrImMgKGg8UbU64yQSzqMApUxPmtJuYBcDER
 Mz0Nn3vZ68G3o8MFN4qVeL9E/m9cdQFt6rYYI3+5IXuADIZnBTgAUKdl8SX0Sh1vVOTd
 UDbSKtOKn/2h+qY+MiIhiRfanuiVwrLs5TsOd76Ko4LYzdFr3D1dbjqP0oodf0mYZHfp
 GG8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrPzOhtFBytu3BN9Mv10as6+T0bfw+Yiuq1YUMTg6o4Mevg/URq9WFzFFSwRywgIEx3RYcaxY=@lists.denx.de
X-Gm-Message-State: AOJu0YzgoSuHSk86RnnXpbOyA9/1fVeWmfiYGFQ6NkK7aL/EqugbpQ3s
 2VFDUbGjYz2IblN41z11ZtIbgxuSzoevS7TkqPfxiBCFcKmdweu8OWxalqKBEw==
X-Gm-Gg: AY/fxX7rvAAo92b81FTKxGUW5dmCFXIQH2LoxR6UdLdWCSYMvo1qzwL54Bp+6pYeS6R
 vFg8FxVvd4sYmakMAhQVq2Z9sLoGEHFsR/9NWl/zPi+IpreP+qDIC6fbsNapWoc0j5+ipGIkH4A
 wrFX8RIkbvtmpwX2ofDG7MKu6OpeOHH8siHXB/oRzs/ASfoyPD/Khg+ruzfMzs402hUxLi+26Q4
 3nN1Kl22KsGuUU7QEA3sCjkhPf7WSmIFkT3ig1pzULpd92i5MT3nWdimknDvzv647Is51EkSuwA
 WIIFFWPxtIQKV37JkxOsJqJAO1RaavhHMA+CMkDcH3ODHo+ujvVr12uzCy2zZdl62L6soAj79/s
 SRgvFL4XfZHzWEcok/tGaaX1XjU8k+DMgxHRx91QKJFYHtnNmmsU4mEFLVWe6yO0+k2NHZ8wxRE
 zXbQlzCn/Wn1ypG0xhwKI=
X-Google-Smtp-Source: AGHT+IG5/fkHcaTwIE7lyAlZ3aalWSel7LIIh6Rk6G5HIyDIT/K9vsyRhVKHqkVysXYXFwwRatLs3g==
X-Received: by 2002:a17:902:ecd2:b0:2a2:f2a5:4136 with SMTP id
 d9443c01a7336-2a2f2a54320mr102646705ad.22.1766394237490; 
 Mon, 22 Dec 2025 01:03:57 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:c4df:6c40:67fe:ebe3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d869sm91913305ad.53.2025.12.22.01.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 01:03:57 -0800 (PST)
Date: Mon, 22 Dec 2025 17:03:54 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] board: Add QEMU m68k virt board support
Message-ID: <aUkJenUcKCUMgzCS@google.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-4-visitorckw@gmail.com>
 <CAFr9PXk5x5RczuE95A64EVu+i_DwWd2hUdU2Wv1dUrwfppJwtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXk5x5RczuE95A64EVu+i_DwWd2hUdU2Wv1dUrwfppJwtA@mail.gmail.com>
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

On Sun, Dec 21, 2025 at 01:37:24PM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Fri, 19 Dec 2025 at 04:06, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add support for the QEMU 'virt' machine on the m68k architecture. This
> > board emulates a generic machine based on the Motorola 68040 CPU
> > equipped with Goldfish virtual peripherals.
> 
> Since I already have this setup working and able to boot linux I will
> add some input:
> - The virt machine can use any supported CPU type, even 000 without
> mmu, you should really handle that.

You're right. Regarding the support for other 680x0 CPUs, would you
prefer to see them included in v2, or would you think that it is better
to integrate them incrementally after this baseline series is merged?

> - m68k linux for mmu machines uses "bootinfo" that is a structure
> after the kernel image that the bootloader prepares so linux can work
> out what CPU etc is present. QEMU does this as well but it will be
> after the u-boot image now, so to boot linux you must save it before
> it gets destroyed and when the kernel is loaded copy it to after the
> kernel. I use ELF images to boot linux. I have a hack in bootelf to
> put the bootinfo in place just before jumping to the entry point.
> - Since QEMU gives you the bootinfo and you need to parse it to work
> out how much to save either way you should use it to detect the
> selected CPU in u-boot. If the code is built for 000 it will run on
> anything and just needs to handle the differences in the caches. In my
> setup I fixup the cpu compatible string in u-boot's devicetree and
> then use that to work out what cache function to call for the current
> CPU.

Currently, I only parse the bootinfo to retrieve the RAM size and
haven't looked into the specific requirements for booting Linux yet.

If full Linux boot support isn't a blocker for this initial series,
could you advise on any specific structural adjustments I should make
now to facilitate that integration later?

> 
> Glad to see I'm not alone in messing around with this. :)

Same here! Glad to know I'm not the only one. :)

Regards,
Kuan-Wei
