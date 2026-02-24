Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B4F4BB7A
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 19:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D51083642;
	Tue, 24 Feb 2026 20:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="daAwvkc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E57383981; Tue, 24 Feb 2026 20:32:02 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C60F82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 20:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so1028952666b.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771961519; cv=none;
 d=google.com; s=arc-20240605;
 b=iIFfew+PMjs2qegbmp013uWijXoLJMgIzN1iCNL8x3yg0kKrMCQlJ+Q4ztl+IjZO1B
 TeUm1lg65O3b0BeETIICg6Smms6fzDEWrMCp/p1Vhyfj7nxWF5jRVaN8w4C2NVMFfKuZ
 XZHwIVFMsjq1L72LV/D+QnvEirnZEHxJkM9F2jQlhzUWHPp2rCHx6etLdcC1On3LkVbQ
 RspetkhTt4q/EHcrBES6AzJCRvsicqYo4eY/v+xg4b5E0iX2UFF9h0IJKEXAWDuqc/qy
 R9ctWrQ+llepPNmtDk2007DHwpd1DehPrxO97zZMVAw8zhmVl4NyUp7ywFGDKT4ovq+m
 Zvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=snW1AweIJvzhShHgR3CzM93sdEj0SY+8Rzi59/IESts=;
 fh=fDTss1FC6xfwKRwB6ZYnZrdJYyzRA1L+cZTeDxC1HfA=;
 b=JfN2b1ddacyBjyXTgOWdvgC7FLjsoSj5Oq3/o333DYr3GYGtmS6Zg17k900nZLVCDh
 UKxexTbZbjH4LMxd4BJl1waXIlV/SBWFiFpre/WX4BdYIGe66Pf+Gduah9rBrPDKBOx0
 6cySqwAlVSft6Gzgi6uRVH5DDoX73rx8cCXh2IHBbOebs4XcuiVd9siBfkW8JeQVdAXg
 y6s0XZQY8Z258pjEIEJ9UlXb2rpgD/PTsAqEtGPTZxXQ05Mklgw2iW7SRTatw7rrDxzX
 etE3y/nLQM/DrDW7sToY9eoB5hudFtBuZCQQ0l3TrNOhPdIZWskMoMERF1IOfCtclh7U
 ikMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771961519; x=1772566319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=snW1AweIJvzhShHgR3CzM93sdEj0SY+8Rzi59/IESts=;
 b=daAwvkc1HQYgusIqKEUWBg57/Bs3BnQTm8fwY/IbYGq8gWvZIvxlLHTW/oSRQwCIL3
 kjDBmoa7mplSqtqCR92vcB+ZkKxABd1JrwmnSLlKtzHR8JUbUN71DTDCSE86XR7HbAoE
 nTBBD6BmFosNTxU96nVt4egH5u1jxvNpbQvm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961519; x=1772566319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snW1AweIJvzhShHgR3CzM93sdEj0SY+8Rzi59/IESts=;
 b=rUTkoLn8Por4mNAh8wASuYTydZHMnKp57Rc4eZpU6FAmf/cuo3k+1bMzJR/aUPkx4R
 AW8QSPFuBR85gU2eaGCo3kWBWwALVv/9nX9tTPcyRGhdZl/lKynST8Z72m0PTuOOBFcG
 j2zzUe/5PaWIyfqMPd09Lgpg7VYJVyD44xQAIhDGNQq5Sq76QVtpRE0ZXqPDA53AmgoH
 AeB4GPHvxJCIsO6Fv6qaqXx/gd0JNLqUmX9QNZDPv8DJe8oaJDLLuMHMpcvtO1kleDjw
 1K3b/I6xBStFZ4WRZvqL0wbCYibl4AUEERQPefEbY+Ta9cxfJsZwgZYaRw/JuCykYbyK
 jsWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzvI4GQNw2Q3kX7eUe4nEjLqqzbGV8frdv6UDUYFjPNUbeE9UjvSWEbXOXSBHOGwAFmutXfT0=@lists.denx.de
X-Gm-Message-State: AOJu0YxoPBAgMPShzF8zYmk7+Vwkb5PHHDx42Av3PT4466RT+wTPsz3s
 EPDmk1lUInbJsLf/ndXB6iuDNmnry2y/t99OgdRjQb+PjAup5o/m26fjcrDKmR80ZrR6Fmfj+CB
 4/r8iTJvxGCuODniCsVHgwiByfgBUeucub7EY5psU
X-Gm-Gg: ATEYQzx7jeGxNX/wD+GDAdwMmQV+OaTFfuP09vQwDDiHkPKMwlPSUxEmDJi9i8qjwHM
 06i7qv9o6BYVvFNZfm6jRQ9P9rXJeKr6tQptQAFZMckEnkpg4z+F2XJP3OwZQplvm/c8DqsbKkG
 muUHNVda4r7lTYjIy1AV0C0UuAwb8E1xZnKb3aD0u9L/ujhlq5hJALiAfURTVAUxcFSQKlnjrVW
 Z8HxC4e4r/AVv80X7lAMTYARCxgLzBz5pf3TBnBhogGd45oJjUAkg/sXZw28p/k+5M2vJbjlkWm
 XjRIMQ==
X-Received: by 2002:a17:907:fdcb:b0:b72:58b6:b263 with SMTP id
 a640c23a62f3a-b9081bfe5b1mr701567966b.60.1771961519390; Tue, 24 Feb 2026
 11:31:59 -0800 (PST)
MIME-Version: 1.0
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
In-Reply-To: <20260224170908.GZ3233182@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Feb 2026 12:31:45 -0700
X-Gm-Features: AaiRm50JzamSiphR8D830SZbRV3zgBgPfnWQ80X619yok5PbnnbCmlG5bk15OAk
Message-ID: <CAFLszTgx6MZmmjoa0LtFCors9H6HE8gSzvVveF0DHC_sktr+NQ@mail.gmail.com>
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
To: Tom Rini <trini@konsulko.com>
Cc: Johannes Krottmayer <krotti83@proton.me>, u-boot@lists.denx.de
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

Hi,

On Tue, 24 Feb 2026 at 10:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 24, 2026 at 10:26:35AM +0000, Johannes Krottmayer wrote:
>
> > Hello,
> >
> > I'm tried to compile U-Boot for an QEMU AArch64 environment, but get
> > some error messages in SPL:
> >
> > --
> > Bloblist at 0 not found (err=-2)
> > alloc space exhausted ptr 400 limit 0
> > Bloblist at 0 not found (err=-2)
> >
> >
> > U-Boot 2026.01 (Feb 24 2026 - 10:22:15 +0100)
> > [...]
> > --
> >
> > Started the QEMU instance with the command line:
> > $ qemu-system-aarch64 -m 4G -machine virt -cpu cortex-a53 /
> > bios u-boot.bin
> > $
> >
> > Also the same errors when I use TF-A and OP-TEE with enabled
> > EL3 and EL2 in QEMU and "u-boot.bin" as BL33.
> >
> > Has somebody noticed the same issue?
> >
> > I used the configuration "qemu_arm64_defconfig".
>
> That's odd. We run it in CI, but as cortex-a57 not a53 with otherwise
> similar arguments. Running with TF-A/OP-TEE is also in CI, but more
> difficult to configure.

I can repeat this. I didn't dig into which memory-allocation fails.
Somehow it is not fatal, but likely should be.

Regards,
Simon
