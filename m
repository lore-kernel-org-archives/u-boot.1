Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75962CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1008004F;
	Tue,  4 Nov 2025 16:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="VjXtu92m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7A58144A; Tue,  4 Nov 2025 16:28:59 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33388003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ben.wolsieffer@hefring.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8b21fc25ae1so14981185a.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1762270135; x=1762874935;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CZ9KQRyPlO7FtxxmCFJt+A5uPgVabGFcupmhq2RAW7Q=;
 b=VjXtu92mQUEFzfnoScPkbgB3TF+m0uq1JdBFboRa3qg7Cp9oyO3TEYUVicrxOSomJB
 ABjAYbn3EzRjvZ+STfXJA9dkZv/gGIkeyQRGYKRzf7Nc4jsTYtmDmuwNyBbnlxf7Zytm
 uaE3Q69hDSDTSafuOV6FFDJ8etgoPuQmJlMVroFgyw6amqo+mimrUJFeoquzaopiYyNQ
 dywiRdTPL7TBVkfY3idhfQqG88HZUR1b/NivGlFLUgJ5eZdaasXi19FpBLjwtk9RODOl
 KmgXlWYDIaZuzmpRnvS0hAer9IfM8LyyOkJ+np6nJWJvfXUfFdNZPgG8HOYo9OHrgSt/
 rvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762270135; x=1762874935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ9KQRyPlO7FtxxmCFJt+A5uPgVabGFcupmhq2RAW7Q=;
 b=rFzLVc+OsOimgNT3SoplYZ37G0kd4LhonlwIb7c39fK1y9BiDScdW4XTQMi6h1Q3JU
 DKk0ZGrF7bMXRDXevtFP3HQTxgrZ0t0qy3BC+GLEZL2MKg9595A749xKHJviH8uw8PL7
 EKOUdihZcvxsz+ZLcYjtLzyIq3NCSStN+hlIfcPoTPtM0UawQ7I/NQLJ2funyGxchuQr
 g0bOr3gpE2GZkG8C8eEM9laSCDaPjaWeXGh6nhNkMRjz18oKvXfO/xYagXWZ7gv8Wlne
 eHV/Bu+4lVMsusH3zjppSXTjIe/Gqh6MxnA0SSiEHsuv7sTowudKQstV9+prk4+YJvyy
 5HDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMfMV7qa9zSl8SWItuHt6gPVC+bXwTq6PU7+jkLnpgMiNZcELmyqegyiWz/mIl/YMqcI5adsE=@lists.denx.de
X-Gm-Message-State: AOJu0YxlxDN9EyoZ8zCrWiQqEBH1CX4W5RcuHpxtxKemO9hcq18WEToG
 YpaoKsI/Jkuf/PzfEGE1/fVmiFflyczkA46d7igSv8dYDInZyvkao2ffLM82vhlbByUNUljPYgB
 lezIP
X-Gm-Gg: ASbGnctr2uO2/UjqzzS7Vr0zrrZJ680jHG348w2EkQq1gAN4tepxH0Vu5q2e4qoxFDQ
 goKMGqF1VME6ylcF2AhX5QROPsy1q+DZsRSjsoRPXx9WU43uRJb7xIiLseJ34EudllrZebew3Th
 nBu/Q3p0l4XTwvByUoRR0fyDe7S8xH5pC3AyQBzLd1XHpDOjBpfhOdATK9qekgW8SA/VOlZsUVp
 4c8o3d/eVbCuXf37BvMImV4doJbmx5nfHILERUpFw0ZSDnABMuWQ9ybdYnVyXWFVa2rflzNopaK
 JWUZpfb/eHhIvZ9rcdEktttavoAmVkUF+rDoz8Ej3AzxFXVo+FU6HTG64BN9dXwiNzuhAJQ7e0/
 shZLN3NWlFD+uVQDp16U+t3lnJ/p7UOFVSkydV9vOWQ4t1OsA+UeioIQE7gy+7rmO8NGoTFyBj7
 eWA/Hd3XD8+9YNiUN27wI=
X-Google-Smtp-Source: AGHT+IEmjOCgIaR3AC4bYCXDh6q9aEPXCI3szZV+/3Y7sR6bcUpmca/YS4cjgDQcNHaxILkXSz9Q3Q==
X-Received: by 2002:a05:620a:4555:b0:892:a186:6b4f with SMTP id
 af79cd13be357-8ab9b883919mr1991829085a.77.1762270134941; 
 Tue, 04 Nov 2025 07:28:54 -0800 (PST)
Received: from dell-xps-15-9500 ([2601:18c:8002:3d40:7967:4a6b:db27:675b])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f808df99sm202983785a.47.2025.11.04.07.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 07:28:54 -0800 (PST)
Date: Tue, 4 Nov 2025 10:28:52 -0500
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi: video: fix mode info in payload mode
Message-ID: <aQobtJxSN-XhUCVV@dell-xps-15-9500>
References: <20251027205627.3742502-1-ben.wolsieffer@hefring.com>
 <ec2afdd5-028a-4ca7-85db-3c2e366a12c5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2afdd5-028a-4ca7-85db-3c2e366a12c5@gmx.de>
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

On Tue, Nov 04, 2025 at 10:34:51AM +0100, Heinrich Schuchardt wrote:
> On 10/27/25 21:56, Ben Wolsieffer wrote:
> > Currently, the EFI framebuffer is non-functional in payload mode. It
> > always reports: "No video mode configured in EFI!"
> 
> Hello Ben,
> 
> thanks for reporting the issue that you experience.
> 
> How can it be reproduced?

Hello Heinrich,

Thanks for taking a look at my patch!

To reproduce the bug, build efi-x86_payload64_defconfig, then run U-Boot
as an EFI payload in QEMU or another emulator. Observe that there is no
vidconsole output and "No video mode configured in EFI!" appears on the
serial console.

> 
> > 
> > This is caused by a copy-paste error that replaced
> > "struct efi_entry_gopmode" with "struct efi_gop_mode".
> > 
> > Fix the type and add a cast to avoid a warning because the "info" field
> > is declared as an anonymous struct rather than
> > "struct efi_gop_mode_info" (see the comment in efi.h).
> > 
> > Fixes: 88753816cf54 ("efi: video: Move payload code into a function")
> > Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> > ---
> >   drivers/video/efi.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/efi.c b/drivers/video/efi.c
> > index 78d123fad4be..60df4334f1ed 100644
> > --- a/drivers/video/efi.c
> > +++ b/drivers/video/efi.c
> > @@ -104,7 +104,7 @@ static int get_mode_info(struct vesa_mode_info *vesa, u64 *fbp,
> >   static int get_mode_from_entry(struct vesa_mode_info *vesa, u64 *fbp,
> >   			       struct efi_gop_mode_info **infop)
> >   {
> > -	struct efi_gop_mode *mode;
> > +	struct efi_entry_gopmode *mode;
> >   	int size;
> >   	int ret;
> > @@ -117,7 +117,7 @@ static int get_mode_from_entry(struct vesa_mode_info *vesa, u64 *fbp,
> >   	*fbp = mode->fb_base;
> >   	vesa->x_resolution = mode->info->width;
> >   	vesa->y_resolution = mode->info->height;
> > -	*infop = mode->info;
> > +	*infop = (struct efi_gop_mode_info *)mode->info;
> 
> The definition of struct efi_entry_gopmode should be corrected instead of
> adding this conversion.

Ok, and thanks for your patch that does this.

> 
> The logic in save_vesa_mode() which calls get_mode_from_entry() is
> completely broken:
> 
> The element info is an array. Without considering which mode is set up you
> will not know which entry of the array should be used. To get information
> about the current mode, use QueryMode(), please.

In payload mode, the EFI video driver is initialized after
ExitBootServices(). Therefore, QueryMode() cannot be used there.
Instead, struct efi_entry_gopmode is used to pass information from the
EFI stub (before ExitBootServices()) to U-Boot proper. Therefore,
handling multiple modes and selecting the current one needs to be done
in the stub and only one mode will ever be passed in struct
efi_entry_gopmode. I believe 'info' is only declared as an flexible
array to allow easy access to the struct efi_gop_mode_info placed
immediately after it by add_entry_addr().

I believe the logic in get_mode_from_entry() is correct (with my patch).
On the other hand, get_mode_info() (used in EFI app mode) and the EFI
stub possibly need to use QueryMode() rather than relying on the current
mode being populated in struct efi_gop returned by LocateProtocol().
EDK2 populates the current mode there, but I can't find anything in the
EFI spec defining this, so U-Boot probably shouldn't rely on it. I
consider this a separate issue from the bug my patch fixes though.

> 
> Best regards
> 
> Heinrich
> 
> >   	return 0;
> >   }
> 
