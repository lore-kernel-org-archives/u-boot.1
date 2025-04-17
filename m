Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9C8C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 17:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E17D82EC6;
	Thu, 17 Apr 2025 19:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BUmCpe0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DB583091; Thu, 17 Apr 2025 19:06:46 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30AE083091
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 19:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-601a891ab8fso624620eaf.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744909603; x=1745514403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7XvHlLD1U1yeDrXJvGn9KVxoBnJ3Tww2Ih/uFOuw94=;
 b=BUmCpe0ZY5GMz2VAVvmMPRFTvOvC/RqGRJtTZ8OuXllA/utH4536tMUXKeE/5jvIey
 cOhjTmGdxFc2cf503z+Nqnb+zwPb91vMuAzM/FukAzUYXfl5CyOEFufczCn4erTjuOep
 TLwLZZL8fiK9Eq/FcDwLVmptXOJztha9rnA+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744909603; x=1745514403;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7XvHlLD1U1yeDrXJvGn9KVxoBnJ3Tww2Ih/uFOuw94=;
 b=QgWxk3j11PZprf1cDAdsnd4NYyhXQHc+PqRShiDMoX1TdBtzUiqPjDLViEcL9013oA
 jHjdDWv2eZiBSxNSdXUtDEqgGgv/bQc0IOVVY7qgirZanQAm1X+q3mFFk523QDtwit2S
 vNc2FVnyx/rgC5xR3pZPSZLkPcE58hJvi+pxtRJR7JZVYmFB8mjwViv7q09XLcUhlR/T
 2/d8eiEUvqMuupSJfYyn/UZwJmmsUghkVUbYvvT1CyIl11HpNNQkVIEiyvcREECsKO4z
 Zi1i8w0LTznsWue0+jRq/ZF8xKiI3xlcm90g0QI90SId7SkeyYYo9GUr79VPBHEElcY0
 U8ng==
X-Gm-Message-State: AOJu0YyPk5HCh7NO+l9C2D1WaFJSvuJF8E6amY2NLGAZscYmtPDRUyfz
 2KW6fFtu+lQMASnkrGiisAEVCvTs4hJ8wULslQUMrFhAtxOUC8nuyp1Y8/kBevo=
X-Gm-Gg: ASbGnctn5Ra4DjwCZJHYEzCIxuJYfdUpbzEawvZqmGcf6bPJ7bOr0l11WQp17WpLBcC
 WflOlUOdihB0J7od+b2UBigDaYefbYs7cLO5K6+Jwt1vp+7723M/7Ll3u/mjLeYpvYJYW8Bipli
 KR5I7KyvMhz6OF4CadDtTfKH0XnP+OCWIVr3rgJ4ZSA8mV18MSXjiiW8v+TEd8SAVDu+qzV0ZOB
 6Dr+urycglmZ58yDJCBxLiiILKdL+Saz884zbrt+wNuoCsHNyA2zC7pEI4Fdl/l+IxYIljOyk9V
 FPgshISmogQEPCd7pe/w2D3E5VbqMxGtVL9JC3gjpDH4x3EjB5RDxOJ0x7C9fiYwtw25G27eWF/
 M
X-Google-Smtp-Source: AGHT+IF9q8kPYWkKGP10nm6n0Mj1Jbs+6OTHxz7bv1wYH/CHxRd6mqgCd0YK2bPgOeGtMtItMiu8lA==
X-Received: by 2002:a05:6820:1c82:b0:603:f809:ce19 with SMTP id
 006d021491bc7-605ff161e48mr369251eaf.3.1744909602819; 
 Thu, 17 Apr 2025 10:06:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff6aacf5sm28411eaf.39.2025.04.17.10.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 10:06:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <ab80d61e-5a76-4d8f-9ed1-7e6ab443292b@monstr.eu>
References: <ab80d61e-5a76-4d8f-9ed1-7e6ab443292b@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes
Message-Id: <174490960142.2996754.1714537977474546341.b4-ty@konsulko.com>
Date: Thu, 17 Apr 2025 11:06:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 17 Apr 2025 12:17:30 +0200, Michal Simek wrote:

> please pull these patches to your tree. The biggest LOCs are around BuR Zynq
> boards. The rest are just small updates especially in connection to new Versal
> Gen 2 SoC and extending it's support.
> 
> Thanks,
> Michal
> 
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


