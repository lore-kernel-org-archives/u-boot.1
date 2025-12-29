Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE954D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4035183B6C;
	Mon, 29 Dec 2025 02:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="YJVqNH1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6129183BFE; Mon, 29 Dec 2025 02:43:10 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DF983B48
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 02:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34f0bc64a27so871217a91.1
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 17:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766972585; x=1767577385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0ibrk0qGNX9HB0+fiBPtlfKiJvpD6UxkBCY0j35hJwM=;
 b=YJVqNH1CshHBXNqftaVgQm1feJp+1BA/CFmz2gNshwy91k+6WzeFOHXT18KlN4srvK
 /uY4r+zCtw+wgWykQbMhQvTdbtJvpJLDsx14scdcOM0uWSQsq+QzsONu2di3S1Ot7i43
 MUoLYj0rpouwXqyjPEn/2MH5aqot7jipm2uEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766972585; x=1767577385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ibrk0qGNX9HB0+fiBPtlfKiJvpD6UxkBCY0j35hJwM=;
 b=jo9fjH+fIuTlpuGoKsYyIXboPv1BD9n30Zu0YXU0tVFIiNC8c07QeDs3YZPr/UaGY9
 qXLt9HrnlPG/qyOyexYQq+JTVYYkw6utU+wQClPAGeLyrmwg1aIXLaPeentIHsNnkw5N
 wB8TozmwkHdJsgaTD0ODnHj0Z0GVz+KhcGwfjRRuyYvMZ3tR9VFLPv2gqgK4gDwyELw+
 HXdX1u3NUPWPhNhB1SyWGTLRq1YVBIt4Vvfcp6a/PWA3rkHpZCJFgg63KNyW9mk6v05P
 X1ThPdkeapQibjFNK20JqsE1yDDpoUb4snQ4GtZdSE57XJednrMZ/UceWnX2VHLZvG4P
 Mc3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5pfkFOT5hASUsRmDBFhKIrrlIVM3rChmpfmcS36WKvK7VW/PbGjnEGS7qj8uYK1i9uOvhOi0=@lists.denx.de
X-Gm-Message-State: AOJu0YxbSOhn0f498ctZ9xM8kaUpZpj7kfn3BiZYjCujm+X+Qn17KaD9
 xG7NUNqa7ffnNyGmYI9r+GirGEeMdRgT8vZ7C0aDN15f66tmwlTBPGpY3ZNgCbMac3OR7Zbrvu6
 llfj4sLQLygpIgevaE3Eef9jypuG+djemNKMANQF1LQ==
X-Gm-Gg: AY/fxX4Rw0EJwHR2hWN04r0ivLN1gwmpZF/Cb9xTMgqY5qdw9b9vebuZYzSlLjF9Zwd
 UUN4w+HX/EYFtY8Q7uNqeEi1FU1xVfZG8qoE628rqp0mu2zBm/6PEdbIcQdgGX3IQcvlCvNopzQ
 QlbISn6msHiV3porgkV3h4kNu1P/L/1SU+V98vTVXz5HP+W/pL2qtu/b+nFDTNYoXjJU8rQI2pl
 e9Fe3aOqdxYxr70VCnWAFJJF25Ut1dqIs39c8ZInhpUYrYfvogKoj1mZtWH5uBYTWRNJW37
X-Google-Smtp-Source: AGHT+IEVADFglOUr8Y6HtvrwqV4KrWodsHWcoOWxjkDfaGj5iHDEq2ogbQPP1mKxN3O8/Erq/uH51vnWwoxAGWY6yFE=
X-Received: by 2002:a17:90b:4c07:b0:34c:fe57:278c with SMTP id
 98e67ed59e1d1-34e921f7e5amr24326045a91.34.1766972584963; Sun, 28 Dec 2025
 17:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-4-visitorckw@gmail.com>
 <CAFr9PXnZPOw3V9vwxtpvkVFfjOt10ZmfSjY6yMLcFnGW15bvZQ@mail.gmail.com>
 <aVGBVwgr8528wTcn@google.com>
In-Reply-To: <aVGBVwgr8528wTcn@google.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 29 Dec 2025 10:42:54 +0900
X-Gm-Features: AQt7F2r-k1ngpEUETLF516BKJOtQaQ8qHTl85KVpxLW4veyOYLgt___PT01oP-A
Message-ID: <CAFr9PXkk_eVwFG4SA1BCB_S+kUoJHPSdsOJZK5bXB+=_an91Mw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] board: Add QEMU m68k virt board support
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

On Mon, 29 Dec 2025 at 04:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > One thing I found when I did the bootinfo parsing in my version is if
> > I corrupted (during relocation etc) the bootinfo this type of loop
> > would often get stuck forever.
> > I'm not sure what the technical limit of the number of bootinfo
> > entries is but bounding this to something reasonable feels like a good
> > idea.
>
> In that scenario, I assume the correct error handling would be to add a
> loop limit and trigger a panic() if exceeded?

Yeah I think so, if you didn't find the last bootinfo entry within
some reasonable bounds everything is probably broken and you shouldn't
continue.
I think for most real machines (Amiga etc) there aren't many entries
but for the virt machine maybe there is an entry per virtio mmio
device so there might actually be a lot of them there.

Cheers,

Daniel
