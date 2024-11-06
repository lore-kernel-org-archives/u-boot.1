Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6BDD44D62
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD049891F4;
	Wed,  6 Nov 2024 14:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MD3B1fXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516CB891EB; Wed,  6 Nov 2024 14:40:02 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6400E88BBE
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso59095265e9.2
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730900400; x=1731505200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wUoDwOh+j8+Z1UR77W4LylAGTEPytOuG10CvqLbOZZU=;
 b=MD3B1fXPJi1gC5rrS3a7RWVwdpAfVbeH0J/JHf32x0pwafiz4HhJ4guFdtOR9fyELe
 wWCFkEGng+yAlO+HhW12UGw4VCZtOyjkbLcV9757dtMBUIxI/WZyRSJ799Ej35KdnVne
 atiqdHe63dCJEQAtRxEj1BMJTOUzMsKYpIHQCKwaCkOnaVNnRTbmfmufIe56U9mDs9b2
 spy5BNkiBcUySP39w0YYaz3qVdQeT8SBB4oh+d5im6G0Ru140eMPgsZIAJzW83izpraR
 sPfANKUMkEJzSvCvjiim7H/zP8EOveGEeNXrSUC0lR76gUm3ouY6dlWxP/VxBFYbCpXQ
 SEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900400; x=1731505200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUoDwOh+j8+Z1UR77W4LylAGTEPytOuG10CvqLbOZZU=;
 b=qDNuM4bfOIqgGpc5L/ZABR9B46Md8Sj5BMOPcgV4AdvH4y8pm6OK9HGA9Fe/UD9fpr
 8GUY5abKmi15XEZUEWMG2iifWNr1YyA7Pa0L06NKsDE6/eKMbdIencxOPsuKZE4z07su
 Y+mw3Iy/ntNm0vMVBI411bKmX9qEApuPfFZ1JYapqVgNIiWviIjGm3i0NrSSW6YYzgpf
 V4CjXFVFzyyYcyMZ3zy8RDDz4Tfi0VOIdw5r+M84pQkuUlvo7vNCYSsLlmWudoS/E3Vs
 Q/lSeIKw2pDrAEniHQkxRQsdJI4Le5mzMg4DngPw5Kuqry5ZDJO5+XiGLZzc/AVGTWgt
 c+5g==
X-Gm-Message-State: AOJu0YwCuBBz6MD+XaZIVrrQ8KYO/JkLSo9OXAncgDD+YJgH0KmejxLv
 DICkzdDqmgycay6PB9mFyODnz1hG41hOw6zCFvLgkP1POUaU0ZbW8QcblPxRqow=
X-Google-Smtp-Source: AGHT+IHiZsVfRDJVJtFMb12tmCiF+i8iDxdlkXGecXko8bb2Hs3bs5R0oKpSX0gQerqp3DWh8lYuow==
X-Received: by 2002:a05:600c:3054:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-4328327ec3cmr147715845e9.23.1730900399926; 
 Wed, 06 Nov 2024 05:39:59 -0800 (PST)
Received: from localhost ([89.101.241.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b60e9sm22924995e9.14.2024.11.06.05.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:39:59 -0800 (PST)
Date: Wed, 6 Nov 2024 16:39:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/2] Select CONFIG_64BIT for sandbox64 and x86_64
Message-ID: <728d2b3c-555b-4a25-8c2f-348bbb2bd13a@suswa.mountain>
References: <20241106124215.677519-1-andrew.goodbody@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106124215.677519-1-andrew.goodbody@linaro.org>
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

Thanks, Andrew!

regards,
dan carpenter

