Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8466C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF0782C2B;
	Wed, 30 Apr 2025 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NWoqseEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1518E82C57; Wed, 30 Apr 2025 19:03:48 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9A382C03
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3f6dccdcadaso91039b6e.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032624; x=1746637424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TN5KeYjGglswIjLfnQiFj91BobdIjB5Vqj1bxlGKqDM=;
 b=NWoqseErBAMs8Pt7UMLZtbyXVTX6eTUyCaXq510iGSLYyh9/g1byu8Z1xMCQyVaq/f
 FHldxqgh1lzFWIqT1mpzBXiSNcGz0OYNhBVsHwpNncNYHWaosxtXraldJ3yIN6hdLoxO
 R4pEWPcHi66lz0CbdbTvPjxMxTXsFrxKN3r6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032624; x=1746637424;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TN5KeYjGglswIjLfnQiFj91BobdIjB5Vqj1bxlGKqDM=;
 b=MIznXAmFr7bz90qrdpzMHFitqAbKeNizZajrRadLLU/3MaNBzJ0F+czgVYFFpB/XYX
 xeSYRySRDL3ME0sAwjmyW34cYYrw2k75gli4e1eswutWFolznXG6kycePGA1yeVLBP+f
 wmH62uAj1bEwN4wcp1EfAwlrbUfXPURHBVRfg7a5Vi76RZw47+aHX292xjA+TQvcaYBy
 ohwX2LAWotdRiIpGVnjJAxM3bumhaV4UhEeF/hdzoR1EHSengbxax7lKKtF6IyIP3lQ9
 PkhON+38h2YUqmdIccDiVA6OIZnmlpZmKLiaEurrNAzcELZYJ9VVMDw5u0igHpgll85N
 IpWQ==
X-Gm-Message-State: AOJu0Yycr26AiECJd5VIE4oC/RR2+N8DdVceV+Rq5N+kfHOEytoQ+ML3
 V8grd/JWA6HtomlDOKuoAn/d4BpQ6vowgvX9SxUYvS2UDkZ+HVXrmwoRVYnuygYTOcdoyTtsOYs
 nM0c=
X-Gm-Gg: ASbGnct/9D2IlM3yQXn8fSFnE1LzA99aF0JprpBRVeHXubnXaR2h3AgD94zVmfqnvs6
 V27SpJ/ecelsoKATJdjGbrTF312wAV7wFd6RiYE0pDRoKlBgojvwlkN+AWu+W0KcGJ86iP0xlc4
 P0Ozoygi8bI/9ggdlyPl5oL6C+A3dv1AwRHyNpCvdMfJnQGMj+Vus7E54PkVJGByeWQkMVxNEvS
 fRYLzPKuizxfbX3RK6dl1P7rUjt80lKYIehZFYzcBMHs6V1DM42gdRUmF96IBLE58muACD5I3G8
 hHb1U3eg6ApAYH1bzrMGrAAfHXCqxbClZA48QgDN4SkWZnLVzVx5Rjy7/IHR1pjozZ12JCIupHT
 M
X-Google-Smtp-Source: AGHT+IEbJWGSWvWpOP9E/34qCxDVqWFYvA5QtZuavqfWg5lxXZWfXvpl/eGoKD9YEofhHvXZDqy3yg==
X-Received: by 2002:a05:6808:6a8b:b0:403:1d83:ed9d with SMTP id
 5614622812f47-4031d83eeacmr1697739b6e.19.1746032624422; 
 Wed, 30 Apr 2025 10:03:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402e1c102c8sm456111b6e.16.2025.04.30.10.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:03:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Cc: Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
In-Reply-To: <20250307093826.10882-1-nareshkumar.ravulapalli@altera.com>
References: <20250307093826.10882-1-nareshkumar.ravulapalli@altera.com>
Subject: Re: [PATCH] drivers: spi: Fix data loss issue in QSPI
Message-Id: <174603262364.1760506.11530069645890674665.b4-ty@konsulko.com>
Date: Wed, 30 Apr 2025 11:03:43 -0600
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

On Fri, 07 Mar 2025 01:38:26 -0800, Naresh Kumar Ravulapalli wrote:

> QSPI driver performs chip select operation before every read/write
> access. During this operation, driver needs to enable and disable
> the QSPI controller. This may cause data loss if there is inadvertent
> halting of any ongoing read/write operation. To avoid this scenario,
> waiting for the QSPI status to be idle before next read/write
> operation is implemented.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] drivers: spi: Fix data loss issue in QSPI
      commit: c0ed43c2a934dadc4066e3a1e62e4db43b2fbc20
-- 
Tom


