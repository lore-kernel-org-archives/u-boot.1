Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417C6C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEF288813;
	Wed, 22 May 2024 08:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IfFLDy+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CA18881A; Wed, 22 May 2024 08:27:49 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45AD488488
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-420180b5838so28252205e9.2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 23:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716359266; x=1716964066; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GtGgani6icIDiRCFHBiBnlxxVoSuR4KgryUsRn77dS0=;
 b=IfFLDy+h9GLktis5vX9JiZ+CShCr0R/EL8zym9RkpZd+YIsC0krBoodvKXWWCUkxAV
 VUH3/TaK0GbdFkJXvOEcolJvA2v2loEuzn1e89SrldPI05cqSU578+p4l6EApZmS5q8E
 MfGTIGWfFYlhQw8NirDZ3Ye0M0ev0tvtI7HGIEUejN8nJ4bqLNO/vxEXzYoCjU1q/UfS
 CgidQLM4rbGrr88BjhjcvcL+6q5SHrkj7qjzQpX3KTkwo2p0z/LuCdnyoI6AG/sUmxN3
 QhctUO1Nlh7mC0U1TNvIQQZPKy2P0XL0av0+bzc9dQh817qmTH0AQNli16cL0Pb6p510
 u0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716359266; x=1716964066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtGgani6icIDiRCFHBiBnlxxVoSuR4KgryUsRn77dS0=;
 b=TvElHtQ3uCbh8cRLp4P8TjX9/WvQMmkzqSEzTiXHVGX4AJzFBZchBTeR869OaeR0pN
 bIM+y0CxZr5lEsgc1fK2aex/842TGzrRdYIrVFMzXOiEUaqs8Hp6KNSNoGWD040PP87p
 oGL1E9k70YQkRq0McvY40EgLNPgt0QY2LMKowrlcSGlKGAyVf9DnVARjUxu6MHUd64Z0
 fmldIs9vIPs4sbrP97XxTG6FU18t4JB1ggSrOJQsWWMRtq1G6BnMfIBvlysAKRYH/Imf
 Vmw8KzXtj9wVHCD7HndUbfCa6uaH9sUQVBYAyoVStRitjU8uIEq3Gh1bB8KYU+6SZCSL
 7KrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU+BO0Kfx6FG8UfQy75g+2ik3OZcev2BhR8/aUUBChlbb18gNBln2whZHh6LsQkiCN7me3ToLZB+I5PJJ3tdmvoKnfVQ==
X-Gm-Message-State: AOJu0YyF6OHzQgmfmI3YITgqvs6h7qyPZ9nKjYV8XyfNnw2qPcDQ4uLC
 iDypo2o3lLvU+r3pnhPNAav7oaxJWVJUuqW6kOB5ij8Zljt8OJ6HBIERggKTEEY=
X-Google-Smtp-Source: AGHT+IGgKp6fdtfEcnJXTrN4eRlpdSniao6zGvnzD4klaWjw30ZDSiSjLCmRQRDNhAR3+0S1QfRC/w==
X-Received: by 2002:a1c:4b06:0:b0:41c:13f6:1eec with SMTP id
 5b1f17b1804b1-420fd2d9cf5mr9913825e9.3.1716359266625; 
 Tue, 21 May 2024 23:27:46 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-352b66ba0c5sm13977633f8f.27.2024.05.21.23.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 23:27:46 -0700 (PDT)
Date: Wed, 22 May 2024 09:27:43 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC 09/14] efi_loader: do not install dtb if bootmgr fails
Message-ID: <Zk2QXzEAGeFOmg59@hera>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-10-heinrich.schuchardt@canonical.com>
 <Zk2N5-lqV1y7lZVv@hera>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk2N5-lqV1y7lZVv@hera>
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

On Wed, May 22, 2024 at 09:17:11AM +0300, Ilias Apalodimas wrote:
> On Fri, Apr 26, 2024 at 04:13:16PM +0200, Heinrich Schuchardt wrote:
> > If the UEFI boot manager fails there is no point in installing the
> > device-tree as a configuration table.
> >
> > Unload image if device-tree cannot be installed.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_bootmgr.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index c64cbe82402..d924810a94b 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -1209,15 +1209,21 @@ efi_status_t efi_bootmgr_run(void *fdt)
> >  		return CMD_RET_FAILURE;
> >  	}
> >
> > -	ret = efi_install_fdt(fdt);
> > -	if (ret != EFI_SUCCESS)
> > -		return ret;
> > -
> >  	ret = efi_bootmgr_load(&handle, &load_options);
> >  	if (ret != EFI_SUCCESS) {
> >  		log_notice("EFI boot manager: Cannot load any image\n");
> >  		return ret;
> >  	}
> >
> > +	ret = efi_install_fdt(fdt);
> > +	if (ret != EFI_SUCCESS) {
> > +		if (EFI_CALL(efi_unload_image(*handle)) == EFI_SUCCESS)

I missed this during the review. This should be efi_unload_image(handle)

With this fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> > +			free(load_options);
> > +		else
> > +			log_err("Unloading image failed\n");
> > +
> > +		return ret;
> > +	}
> > +
> >  	return do_bootefi_exec(handle, load_options);
> >  }
> > --
> > 2.43.0
> >
>
>
