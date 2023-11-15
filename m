Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D66C47072
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 03:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550B887154;
	Wed, 15 Nov 2023 04:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S68CPilL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE43F871E9; Wed, 15 Nov 2023 04:12:00 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CD487120
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso945466766b.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 19:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700017918; x=1700622718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XmTHeRlgJsIJDBeU1OSYA0yyYD9P44zBfZ0t1ciznlA=;
 b=S68CPilLisLFolR7D0ItIX7jtuZ6sIoBwIo/4IeE+uMBSvSBs+JiW/HyEsPv+gpivT
 bqWBldZVXCQQNX0bltOpn5telQM7Q1XLPd2XQwfJm3DUQEqWCC2p23Ry/R3S+CZJctwe
 old1jTStYvlE+4SRKuGi/YAvifUZ/H+V3p+cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700017918; x=1700622718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmTHeRlgJsIJDBeU1OSYA0yyYD9P44zBfZ0t1ciznlA=;
 b=olJgnLPaIXBdi7vhkRU4QdIKb6GIxkKIH3RYdTekXIQlvp9e7ciovkwj6t9ExoBhcv
 6xUQFUoJnE9HBSBFOzDBXub8yIOCINi7ZfLvWRr8Wv30SflmgT2A933HSO6Koru+On3D
 9gaKNBY9mr3Ukv687+IBmjH8zmp7Ng8rQ+L9l05hGoYs7IISOD74COh94b3Kwe4fMnhm
 Brsn2Ciew005OqIPDGSeKskVPR8ITI8TafJUMHLY9Sf0b77pFbE8ynzLda2YBew32Bkw
 hK30rb6hH7Y3V2wyY2dQGBdJHmWzFJ4t4yy+8EoATWYt5UUKZo7kIQ2gNSw8Ow6oR/Yy
 KSEA==
X-Gm-Message-State: AOJu0Yx4z+mSVy30b6ZoQXarhos56jyVytFLHXPVbwRF/GTIIr30JbkK
 YuqFAd/GB4yT4g2l0XNAemML9uwIbUOTXjoVijK/qQ==
X-Google-Smtp-Source: AGHT+IGjzd+Jv0pSx8mLagJp9rBciHDdSXOazbIFxSOtjROumL0HnKgP75/FziUdmrHRtLITyPl+NdW1A+wcBlOsFmk=
X-Received: by 2002:a17:906:178f:b0:9e5:29d9:4c84 with SMTP id
 t15-20020a170906178f00b009e529d94c84mr7091581eje.3.1700017918044; Tue, 14 Nov
 2023 19:11:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJZje+vf9Wj_C_OnWTVtjHxfdmoq6j+=01qn-8WojZ9HVsxuTg@mail.gmail.com>
In-Reply-To: <CAJZje+vf9Wj_C_OnWTVtjHxfdmoq6j+=01qn-8WojZ9HVsxuTg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 20:11:46 -0700
Message-ID: <CAPnjgZ1WXHvLqbunLOaCH8W7zQZ3sx6Pxt1pvy+k3Ps5Vu6XAw@mail.gmail.com>
Subject: Re: Booting an x86-64 BIOS Machine
To: Desone Burns <dburns@seegrid.com>
Cc: u-boot@lists.denx.de, Joseph Chafin <jchafin@seegrid.com>
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

Hi Desone,

On Tue, 14 Nov 2023 at 17:43, Desone Burns <dburns@seegrid.com> wrote:
>
> Hello,
>
> I have an application in which I need to boot an x86-64 machine with a
> legacy BIOS. I've read about the U-Boot executable, the SPL, and the
> TPL. I'm just having a bit of trouble figuring out which pieces are
> supposed to go where. Looking to Grub, I see there exists a minimal
> "boot.img" file, which gets installed into the MBR of the drive and
> subsequently bootstraps the rest of the sequence. My impression was
> that either the TPL or the SPL would play that same role, but even
> removing basically all options, the binary produced is still too large
> to fit in this 512 Byte area. Syslinux also works on my device, and
> the "mbr.bin" and "gptmbr.bin" files play the same role for that
> bootloader. How can I make optimizations to generate an image small
> enough to fit into the MBR of my device to allow BIOS to load the rest
> of the bootloader?

Normally U-Boot would go in the SPI flash. If you are wanting to put
U-Boot on a disk, then I suspect you need some code in the MBR to load
it into RAM.

Something like [1] perhaps?

For that case, I doubt you need TPL and SPL...we use those on newer
x86 machines, e.g. Apollo Lake - see [2]

Regards,
Simon

[1] https://thestarman.pcministry.com/asm/mbr/STDMBR.htm
[2] https://docs.u-boot.org/en/latest/board/google/chromebook_coral.html?highlight=coral
