Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874ACC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 22:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E3D82CF8;
	Fri, 20 Jun 2025 00:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aZ7X4kBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16828003E; Fri, 20 Jun 2025 00:27:05 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5761A82CBB
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 00:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40a7322f081so265189b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750372022; x=1750976822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kPOFpivB5sFnKtJKrJ+21vfOANFlYcNgAw9AqW5Hnf8=;
 b=aZ7X4kBPR00CMsDKKGG041UjdT3V1ZjDD0iMgml66n8V+8KPmuc/uVW4w8w4aqXIAq
 NKYFPlo6qHrkFF9orHHQI/GyY20BGBpMNYQiopeCehs8q7kkHthirE4SUbsolat8iwPt
 uAfHECOf+9hQxHtw7WW4gAOI8MjAnZiMkGp2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750372022; x=1750976822;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPOFpivB5sFnKtJKrJ+21vfOANFlYcNgAw9AqW5Hnf8=;
 b=HMqal2DBEUOxpEVh0sFeaa/aimxlgbaFYg9ZJyOzpbCMfef1LlusnCOVbNXjQQc+7N
 bFaAqm1liBOvuSo6ERIVAa2PzPv0ucULvWPXvCCmf6mhQM3V9+CTktXVQczjaeLucAVf
 eEhS6t56WSlnxfyrPIFgfcygk7XZz1HGlzcZSRTa3SyiV4j8EHWaQxdU0REv2zPGXIFV
 IzUSYrCj4JPDxsbw4nyd10Wx3k5LX/UTc4exmSgdujjF1k4ZvnipHZjtsFOCjRc8rY3l
 lXvyFAnNJUUztO7z00lGE1wwiquV+ii1ObizYayP3dXyL2bohHWGFLM7Ig2czAuO6Hh0
 ShpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMF/+eA0ArHAHq+E/9I6X+C+lXrrWeekF+Kd2fCYy/O3f9pXIkA35Ec+PqF9B+uPTzFfknct4=@lists.denx.de
X-Gm-Message-State: AOJu0YzaS5O0vEagKNt9dgQCtglwUbyKR9U4pGfGZ5i2Q9PVgQKzIGLE
 /H+WLVddf60k4fWpVZoL60BR2HxfBUUlxAMl7OnxF/P1/8tOHOcREmt3wyuPZzbhlgQ=
X-Gm-Gg: ASbGncs3A68819YdYTfij8B4B+quTfNAp4drzGLaBz1xSVBX/BjaqGoK9D3fRcRKe4A
 xJP+rmVORAgKSJW6v2eL+2IQUZezh2JlfLBNdWu+asDE2Up6DizLrxIV6SV3SdI8k8GrAE6Qc0Q
 eoDu7dg9hxrkfM6n9Q7NEyjr//ukN43UiC19S5NdHFmvICa87DtqAGu1fbYcSAyCVHZDfltvn2M
 AlkYXzOIqRhi5pzsEQdPoCT1ra+8TcLtCqwRddMjjGEYssc+RU8a1k9O8mquPBM/2WfoCQ/pt77
 M+5kGyupwVyNmwltHRGpg0Q0oQmT1HlaaWZSbVOUeX2TANJ5bLRgqQsi/AQZ7Rkh86O0WIx5YE/
 Z/ufOvMvxYqBz+k9QkkUfgw==
X-Google-Smtp-Source: AGHT+IEZ9IguKENnRXvxs89N1XJ8ULV0LXljSHpB2CT1XofcN5llvgJbU7Q4iqSFPXjdzOVeFPHZ7A==
X-Received: by 2002:a05:6808:220b:b0:406:7a21:1ae9 with SMTP id
 5614622812f47-40ac71607a7mr421995b6e.37.1750372022054; 
 Thu, 19 Jun 2025 15:27:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b68f256sm74804eaf.1.2025.06.19.15.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 15:27:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v5 0/3] common/spl fixes
Message-Id: <175037202057.2294222.9788976818959391184.b4-ty@konsulko.com>
Date: Thu, 19 Jun 2025 16:27:00 -0600
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

On Tue, 10 Jun 2025 12:56:29 +0300, Mikhail Kshevetskiy wrote:

> Changes v2:
>  * added more details to the patch descriptions.
> 
> Changes v3:
>  * fix commit 873112db9ce68c38984ff25808dde726f8dd5573
>    ("spl: Support selecting images based on phase in simple FIT")
>    instead of fixing loading of image with bad checksums
>  * add more comments about memory usage by board_spl_fit_buffer_addr().
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] common/spl: fix potential out of buffer access in spl_fit_get_image_name function
      commit: 3704b888a4cabac8daea20a4504d513bc47153ca
[2/3] common/spl: handle properly images with bad checksum
      commit: 3eb43c54fadba457f22e415a2821145164efe662
[3/3] common/spl: improve error handling in spl_fit
      commit: 8bb9c275c484206c0314014d8215770aaac4cefe
-- 
Tom


