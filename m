Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF493FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917E984255;
	Sat, 25 Apr 2026 18:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZESVgbLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8146D84376; Sat, 25 Apr 2026 18:26:39 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579FF84255
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b458ca2296so55264555ad.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777134396; x=1777739196; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2q0wQgD6idkHesbZhFPTtv3SbZ/Lz5zwtb0AKbH9DU=;
 b=ZESVgbLCCyUg23Dci2ZoEt4jlIVR689Qy7/ItF43NVezcDaJFIX0f835DEvXApsLda
 AJ4V5b4lJwrBwm59uX5ZU5np7UYNnQGVOZPMv8LhRhQ2en0JkIgHsKgLduiHR7MP6P0w
 4K/h3aX0g0vMJIucN7RGdYudLvJPGpaN1Zif23x6lcq3vD6Y1l91lLzcEZkUxDbarIAu
 ZZ3Bi07DYB6/lOG3zsR5Ix+zQylQE4/gtSyYT4ji8RNo0Hj3mvECh9GzND3Zlv+MBaix
 FnZZ6jvhRmQwujb4Nuf62OvgbBr3fNew7PCQu8Dk20BrO43PfLWXopRO34pPosmQEfM1
 hCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777134396; x=1777739196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2q0wQgD6idkHesbZhFPTtv3SbZ/Lz5zwtb0AKbH9DU=;
 b=XP5gW7XA8wROPbDfx3+pg6MgEAgratsdZeTvugTqM98R9mUEfIbSja98uKZ6n4M9Ee
 7NpziGkD2v1scUehaLs5KEUTOEzDqmXkJDymgpHY/Ak8HuXAlkA1yzsmnC21mj7kMgkx
 LPRJStpE+jHB++Bg6oYCp/J/mTbsgUy0lb0GqRS5xrz2Jqiuat9yp996IHd25vYfdKaH
 ddKNYR08oT+AlUaZTdAZmM9SkpPSophkmeXOMVcaAhd1j/99yrNYhptJmwXmtm215Ikr
 uNey0DlYplAucZ9VxYaYXuWCStkw15lIBwS4ey6vIORDLEaaLp+hHzKnb1IBhIBHVSAu
 lFug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cQeCV5Dt/x66knd3GHDo0u5hJqqo98+TTTLdY1piRbE/k+OtGL1T5cg4pKMBo7GbOA1PruXg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfn395IxGBDpbCfPr8XIRnK3cxjtTXJtL6xBmB733hGDi3S0Kc
 55qmyJD3pSN9WmuXTrgpuT2XMAXDpgsSC34+Iq7kDNnikxMnc8RzCaLW
X-Gm-Gg: AeBDietaonDjG09lQ11H0YYUkreoYi35t1rmSmqQ5vgPq6NsAJvBAdkTWDuX+xyJlcQ
 Vzj/A9DxpjUoycP5XMYPH0Z6zb9q3FacNFJLYx3uHjkGhQXtZi+RyOI1OAFGTyTIW4t8MGDqFq+
 d9c43uA5GqZdlkE+QFkTEd8D7tx9gH7C3ttY2tEd+cS94Xdu2xO2poNOPrAA8njEXP9uYffEa//
 7BLZ+7gFcDKzDKsu9AUVfsTaSMrU2AxfPH+RjIIY39BtXAYZhgnUM3Ryoe94AjK/bJ2nJXSEtmA
 ZxcC1FWZjtRUacygjl9+uivPwZ4+I3adbvOCi0wYzNnyyLOdUHRyah1Y/aYAyhBDFyqD1x7xLGA
 ygoT7MYoBuZGDDLYrAxKq00JNdozyQZs4e2KB99hpONY/E7hnZ5xqcRwog5w1r4HRHKhFHJ80ov
 n+H03krP8ZWXgMd9Y+xV61Xf6l7FnQ/SaM5WTt4MfhoNthkdMA6JnuUs44dDfbXWQ6tS9CgXabD
 L8=
X-Received: by 2002:a17:903:2ecc:b0:2b4:6022:bf8c with SMTP id
 d9443c01a7336-2b5f9f52984mr404001825ad.22.1777134395683; 
 Sat, 25 Apr 2026 09:26:35 -0700 (PDT)
Received: from google.com (61-230-36-6.dynamic-ip.hinet.net. [61.230.36.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b7bdd9c00csm58260565ad.50.2026.04.25.09.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 09:26:35 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:26:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH 4/9] board: stmark2: remove old garbage
Message-ID: <aezrOFUXtdXpxJHu@google.com>
References: <20260416121431.20852-1-angelo@kernel-space.org>
 <20260416121431.20852-4-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416121431.20852-4-angelo@kernel-space.org>
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

Hi Angelo,

On Thu, Apr 16, 2026 at 02:14:26PM +0200, Angelo Dureghello wrote:
> Remove old erroneous garbage.
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  include/configs/stmark2.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/configs/stmark2.h b/include/configs/stmark2.h
> index a7afbb3be1f..c1096398359 100644
> --- a/include/configs/stmark2.h
> +++ b/include/configs/stmark2.h
> @@ -18,7 +18,6 @@
>  		"load mmc 0:1 ${loadaddr_ramfs} uRamfs\0"	\
>  	"kern_size=0x700000\0"					\
>  	"loadaddr=0x42000000\0"					\
> -		"-(rootfs)\0"					\

Since this line was introduced in patch 3, would it be possible to fold
this change into that one?

Regards,
Kuan-Wei

>  	"loadaddr_ramfs=0x43000000\0"				\
>  	"update_uboot=loady ${loadaddr}; "			\
>  		"sf probe 0:1 50000000; "			\
> -- 
> 2.53.0
> 
