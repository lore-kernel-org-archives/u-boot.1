Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4AFE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 23:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C1689500;
	Mon,  9 Dec 2024 00:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jq+2YxCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F159589570; Mon,  9 Dec 2024 00:07:06 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3C789500
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 00:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa6413fc7c5so290918966b.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 15:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733699224; x=1734304024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A5W5RKF8kMjEbLBuasFTlXfo50DPH+1BLc+Ir7F2GNs=;
 b=jq+2YxCmEZXGVWCBXOz9pUjtCPD8U/cPEj16rwO+KNX2pqlPzf+CRgTdYjDqrC+UM9
 NOO3THpV7hzj+uWIIaJtMO62xhBYSbshNdgpYIxOdFrNfBWR/csYVnq0zXuMB7JQ0VHb
 fmIMygk0PDPale2Fypa0+ZIonQVcApXiRPJyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733699224; x=1734304024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A5W5RKF8kMjEbLBuasFTlXfo50DPH+1BLc+Ir7F2GNs=;
 b=CQw5q70kXX7Y4hLuIfw4xEuxMduhRDVjstxdqX78Vq8ZbzgO38Reg7pskfBZ/0Ix8o
 JHQWAqIkr+jO/O1yR5xqACCeJWz0JEF7/6Uc/C5SsFSA3PYKGGniwo8/qbuCixFCd1Gp
 GUAL3aKzy78EvVjnTFtcToNrtE5q7MSUZzU5BxIMERYLwjU5VWaodtZhwP/C8tLaxop6
 KVAJQ74UD/ofewTz22eHsT7trk+Zz2mCkGRNDTXFYLEK2vgG65tuuMJyCfqX8AqgKLtM
 sVePDY11+uq+ZGGGGE98ufThKt2RGL7UM0hUxBT7fVrBPgWcxcyfguWJc+sPBCPEgukq
 GdsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaqHYPNEWUAn2KJbWWsrgRULOrSKYrWpfTPp0ixh43/zT9YWlOBoNAZbt9d81+eoax7ciMXEY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7WxKj5zfx4KGtwEujqCSk9HIEjvGPwuWhi8NCX6IrdDovKBIf
 DSj+ohZfA9TkxVi/CwdDFDfPZxyBM7VqS1H0RamoHIGLn14LhsnfCFVF3Yrax940zSTHCMK/i0p
 dCksFqivxn/V9bkognRGYwuppbJVgsy3dgGgV
X-Gm-Gg: ASbGncu77Ni6sDKBY+12sxlX+l/fR3k8vfF05E99tOMHyub0PH11kd69cT4nLafUnwn
 1G4ZhXacik5Ko4kv/vLyiSGZpL4gEEg==
X-Google-Smtp-Source: AGHT+IEP8GueUIxShXxJqL5omptPO/aKz+xt+pzzZpqGfNkfWFLEAmzR0xG1EqmNOlWzXuWclHNiMKWM8xHp6z2ldxk=
X-Received: by 2002:a05:6402:4005:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d3be680ec5mr29794320a12.13.1733699224429; Sun, 08 Dec 2024
 15:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-2-mjg59@srcf.ucam.org>
 <e1592ca0-03aa-4f83-848a-70c8979a9b2a@gmx.de> <Z0N+kmEb9eYr8oBZ@srcf.ucam.org>
 <1BE9D668-50C2-4042-A144-3ADCFA9ED0DC@gmx.de>
In-Reply-To: <1BE9D668-50C2-4042-A144-3ADCFA9ED0DC@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Dec 2024 16:06:51 -0700
Message-ID: <CAFLszTj3EFSbDNnPosmvuYo6vLJ4ryf+c9xVqcTAwRf04oFz7w@mail.gmail.com>
Subject: Re: [PATCH 01/10] Add EFI handover support to bootm
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On Sun, 24 Nov 2024 at 13:04, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 24. November 2024 20:29:22 MEZ schrieb Matthew Garrett <mjg59@srcf.ucam.org>:
> >On Sun, Nov 24, 2024 at 03:43:12PM +0100, Heinrich Schuchardt wrote:
> >> > +  /* That failed, so try allocating anywhere there's enough room */
> >> > +  status = boot->allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_LOADER_DATA, pages, &addr);
> >> > +  if (status == EFI_SUCCESS) {
> >> > +          /* Make sure bootm knows where we loaded the image */
> >> > +          os->load = addr;
> >> > +          return;
> >> > +  }
> >>
> >> Why don't you simply call LoadImage()?
> >
> >With secure boot that requires that the kernel image have a trusted
> >signature, whereas we're relying on a signed FIT.
>
>
> Please, provide an answer describing your problem and why LoadImage() implemented in U-Boot's efi_load_image() won't work.

efi_load_image() is in the EFI_LOADER. This is the EFI app.

Regards,
Simon
