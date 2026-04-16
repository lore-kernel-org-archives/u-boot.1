Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE1F8A151
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B448841C2;
	Thu, 16 Apr 2026 11:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AotcgM6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D92A84214; Thu, 16 Apr 2026 11:27:12 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05738407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so35508535ad.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776331628; x=1776936428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7VkwvnUY3XkB9NDipbpUxwUoXmJoBz2JajOAgbgZ60Q=;
 b=AotcgM6hQAhGl8Q1iAhZ16XbrPxBNTWDcMfG+gSBGr/A1k2xKm/x+17rZJ9d5PFxS2
 tWoPEZLXkb2NCsWWez00EZVUT0JwA6fl3bVYHCd8ZNptWkUP7HfRezez7dzgWrwjpz8Y
 3NfFZZ5yoPYspB8fyPa3KY2ZMapwpaPbrVn1icCKjDW92S/8i0VPMjz0Bbnnmu8sQUdT
 dOxBDHFg2ZPosTfxDIXxccoKixygXQTdYWgpYDmoHGrPENOrQymaOEb+2SbobrQ2V6XD
 6cqcEopBepsf4AgubUfb/KwwuJDgOww6Rrfu8JCZOp4l7N7GgT7FBIxuXzANhYZ6j99s
 PbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331628; x=1776936428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VkwvnUY3XkB9NDipbpUxwUoXmJoBz2JajOAgbgZ60Q=;
 b=c98sutckPAeTDksP2NoeAt/sKOk1Sn7wOj98ukqm7K7tnLkopWefa9wCGPcM8JeSFJ
 ZjJidaEZAl7jJoRp6pckpNkwy0XjqhQnEJweQSNNYvflbLqz5/3BWet6hrpUMZM2awX+
 g9HK1F3l5y1YZUv8gQONB90NjYqnO5OQ2kOoD5seMhPeMz4zlXQIyI+nb5YeAF5CCMtJ
 9+KbczyT0g6xscZQE1PzM5FW7U/s+iv+puS9RqcM12MxB54vv/RlK5ogvc+nrgD6Z12X
 E+M6sh2AzWaGDRQDmKnym39j6CMdJSXHbgs9YNhk+yuM5zkxuKWp80UKve5v3f0YcOkw
 WAGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kHErpezw9Jnlrk0NzigdpqQHt0BdDYzUubLMPQ0J46gtSKkjgeKdGPzW/EvA4LbLVtT2F5rc=@lists.denx.de
X-Gm-Message-State: AOJu0YyEkCeNp+hgDDHivvgWAgH1We1j4ESoXrI4Cx0GMIwiHaUC6fQl
 jvB3mvBd/4Fw/ej8RJeAaYV912lDtHhYPEjMGm4Rv85gwp9wrBqTmLxwcPrV8Q==
X-Gm-Gg: AeBDiev1cnPFH4rlVr2wKv+mxfkMDbYtCtTt5DqhuhOJwrGlyQc/1y758K2CS33pdRc
 /trqJkkJta32UabgnZ+Fz+XyJRpFuX0cmDhCUOAlOtUdEilYr+RMHjBjFcurp6m+5S1gcmPUDm9
 MWA03oHI8UF/mI2BdTA2OIADMQy42vKWQeEYR5fGI24Af/O2+0YWzp5Pw3YRMTL9VN4uxTy0r3p
 9twoiCJkd7Kpml36Rdl/UUlBaqLTP3GIWh+ly2MRaKapYaEOotjgxDaeZDf4CsXkVcQbt8cBCKu
 GD7+1KvNsgF35e7GCgh2HhNEAZd+eFEfnI3iUO0zWVnPFAw2i/vN85nQS8KphTnmkWiy+JdU71R
 fv98BwuItXUtoenHZFdmrVdww1zKHZ58fF2aGWJne6zHX7BWUQ+cfDTv8WkMYwzB4yfNllt+JY+
 mU8Jc4+Szp9E1C0Pr/e9LW7axe04yKfb4=
X-Received: by 2002:a17:902:ab85:b0:2ae:6092:8d93 with SMTP id
 d9443c01a7336-2b2d5a348e5mr178886885ad.28.1776331628312; 
 Thu, 16 Apr 2026 02:27:08 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:6c74:6a92:c2eb:e814])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4780efa9fsm46504275ad.12.2026.04.16.02.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:27:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:27:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 4/6] virtio: cmd: Depend on VIRTIO_BLK
Message-ID: <aeCraTEweq9R0isP@google.com>
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-5-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413092240.3719260-5-daniel@thingy.jp>
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

On Mon, Apr 13, 2026 at 06:22:38PM +0900, Daniel Palmer wrote:
> The virtio command is calling virtio blk functions but currently
> depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
> causes the final link to fail.
> 
> Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
> on just CONFIG_VIRTIO_BLK
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  cmd/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 7bbeaad04ff4..7c86164ddb20 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1863,8 +1863,8 @@ config CMD_PVBLOCK
>  
>  config CMD_VIRTIO
>  	bool "virtio"
> -	depends on VIRTIO
> -	default y if VIRTIO
> +	depends on VIRTIO_BLK
> +	default y if VIRTIO_BLK
>  	help
>  	  VirtIO block device support
>  
> -- 
> 2.51.0
> 
