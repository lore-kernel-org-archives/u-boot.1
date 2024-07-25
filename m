Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1CAC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8D287C38;
	Fri, 26 Jul 2024 01:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HCYCM3sV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7023188395; Fri, 26 Jul 2024 01:32:16 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53EF086FB1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db16b2c1d2so278778b6e.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950333; x=1722555133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PHieUuoh3/nKQOVidzXbzngNHjb0ZU9sttw2iF9YuOY=;
 b=HCYCM3sVOM7uy97XoZ7C7s7nRs51DAYt2Et0sjw5QLVKloLt/EgRo6uebAHKpyM+Ti
 MRErf6ajMoBi91N4VAj1At+MOgQlPGZexurDzOOXkTNIyQ/ysVMkw0/JfrF3Xojjf7U8
 DJ24y7wR77uWiCfVmV2k+VvbqQ7nz+6fOC5b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950333; x=1722555133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PHieUuoh3/nKQOVidzXbzngNHjb0ZU9sttw2iF9YuOY=;
 b=Atvl+ILR+0UyTJvKTVRpIZipDY83Qz/uu7nEDIiHcnFDXZJb+dIAWt7185T+C4+SFw
 GYqOlYM4O3DwPcx3OWh/CFYHnUWdvhh53/ycBmp/2KmLSDqz7o5nwd8T6Ay6NJ90WwRN
 UhC1f9pDUHXVgQ+nCKYt4N8vfw75o6ZikHpTKNYrejx+oui2K7Dm2KEMzn64ZF5XTJSC
 DWa8XWXVM1ZWRz7ICZk89PmUwfQvRI1EeL4USrzEIkWCpFoOzT8A5vkQecXh70W+6XM6
 3iUlduGnyref2SNrkVVHQSPMsDxXpwaKbKzOIHVyWw2NkDoBaKnmIaEJqzmCiUdJ/u3K
 +Vug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRsWAUhDb6BD/ffaGW0AeaPaUpVVSaUNqFn1XJFGKdkaMyv92dLAAnBv7iKpmOs0JL5HqrG1fBmvp3cgKBUbba/RCpfA==
X-Gm-Message-State: AOJu0Yz7kttNyGpGuDAr8J1zLsEwgGZ10NI3Bd+72xUoqXjK4hPI0yjz
 pqb+x7zQA+nNIL81aHmCtxBjKPUv/S688yDZ6NxuCYOQsBBxJo9zTy5K89owywva+hfgpp4s10S
 FsegkzOBIJ23mI7fhDvO94iepV+tizZ3h0Gtk
X-Google-Smtp-Source: AGHT+IF1+2tC+O2W2YKLD8qibeuaHESgu5oaCOul4T/HyR/xeTrTDvvDHpxlEdg3MnQNAInkiRZxikg2CdBJ7ydG5ls=
X-Received: by 2002:a05:6358:5290:b0:1ac:62e5:7648 with SMTP id
 e5c5f4694b2df-1acfb969818mr449258855d.20.1721950332975; Thu, 25 Jul 2024
 16:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-3-sjg@chromium.org>
 <79d645ae-03d4-40a0-b685-fb6e7189b53b@gmx.de>
In-Reply-To: <79d645ae-03d4-40a0-b685-fb6e7189b53b@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:01 -0600
Message-ID: <CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com>
Subject: Re: [PATCH 2/6] efi: Convert device_path allocation to use malloc()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 25 Jul 2024 at 10:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.07.24 15:56, Simon Glass wrote:
> > Currently this calls efi_alloc() which reserves a page for each
> > allocation and this can overwrite memory that will be used for reading
> > images.
>
> We already agreed to integrate LMB and UEFI memory management to avoid
> this sort of problem.

Yes that series will be good in general, but I don't believe that will
fix either problem:

- Using LMB for tiny allocations doesn't really make any more sense
than allocating a 4KB page for each one.
- LMB cannot stop overwriting memory used by kern_addr_r, for example,
as mentioned in the other patch

>
> Please, have a look at chapter 10.5, "Device Path Utilities Protocol" of
> the UEFI specification.
>
> EFI_DEVICE_PATH_UTILITIES_PROTOCOL.DuplicateDevicePath() must return
> memory that an EFI application can release by calling
> EFI_BOOT_SERVICES.FreePool().
>
> Your patch does not comply to the specification.

Oh yes, I mistakenly changed the ordering of the patches before
sending...this one should go after the pool one.

Regards,
Simon
