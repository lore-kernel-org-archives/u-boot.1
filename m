Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E31C36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 10:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAFD82012;
	Tue,  1 Apr 2025 12:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ErMb/XoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D4B82040; Tue,  1 Apr 2025 12:50:12 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CBB2801FB
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso1186300f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743504609; x=1744109409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YqzEG6kNglYcgm/IPXlngbozcrOV/+mdoVVWvGajFLI=;
 b=ErMb/XoTCgxJ99l/QhPZ2TKcfLvbgZ6JvOg7z8hUlA5MzjI8c7y4f7/SzWLzhBI0wS
 qz9Mlp05jBvpljSqzqkT2s7IAnmdPdqvXVGi+VGAQdYCQEdZhz+kQgXbxT0wZSYtDCcr
 dTNk73D23BKP7J4sw7L/H6tMj8PQzM5Ubhcwi3rcbHZcjvlIAEj0laJx6mhneW+fch35
 bnHdCrz0jUtkr1ZqNmCuwRMXvdhH0BKyrXldFkL4bzVmdltS3xtlt3D8l5Fdp9oH90PN
 xsJFdF9RAG9Yh7Q1MgP2evTlbhRlmuFkETbYHDvxxRYvxZNVib7fLxpAFNoz/C56cwXN
 Vf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743504609; x=1744109409;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqzEG6kNglYcgm/IPXlngbozcrOV/+mdoVVWvGajFLI=;
 b=nkWzPxbK7OIF8+giJZvKNm7nlFQNlsa0bQhFFpG37BWowxNGqBULq0Ka9TYpafIMnH
 MlIGDYrGkCt5l+yeGzLZ8/ALLSdAyqdch1NRWcBXVXWE3GIcI8enXddPUFZza4IEffxH
 3BqayV4LBSlG1Ohgs4PrZtUJZBI+2M/n46l4RrDrDh3qUwPvDqZ8TTwNDF7bKkSNcDmN
 AM7UUg/1SgcHThEG6Iu5GhVmxrsPb4kuMoSiEL14klEKz0nmMr8vZoQQ/w0UobTNPUiV
 TL33d60BC3C9qXogVL2G/HWvA6QpHu2USA7RP5VgxotKEUJ0Gy5RJ/kCRwgMJefgUkYF
 u7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCZsM7GIHMfqekWX489wT9gKINLFpNbKK+NXSzzez9CIPOnUZfxNSYc9Aeecl713+YEUtMjGM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx52/iaqmFjPB2+NDrVbpL+8Mn2m3rhTfSvkBpa6PoLYRJZLOYk
 /xBJxLCMA2mPp5MM3L1oJUQaibwQP1VOjUY2j/2NoRa/xujitjAS
X-Gm-Gg: ASbGnctp3fLWl+gUbE5r39VVJ2SUARV5ARU+sKLoIsJzPWIbIol3V6t5rkQ8lJJvaM/
 WKngf4zkbXbipRqT2xCA64Q6KakAxJihAjYDfuzxZp1Ul7vAyrzLO9/yFnAhFCAS1Lj8X+Au4qh
 Z+/8i4f/AGGXDXAJ8OI16bbVDt19+DOIiY6y0PZR/zTHDTvMVJSW1c02oXw4v9IeNSMUt5INqwI
 oZO1g+rjTx4V7Wob9xCo4178w5SM/pePFWu6bUGCsUtDry0m1vR5/KmhQCOAVsZc1+a52yLVFSi
 EDBDy20c9yqsct7rsWTll45MbGCj/ujPq4S+kKbUzwdIo42xJyv/WU/+KI5xC0fZgaXSTT7qr48
 XHMeHq+Xijww=
X-Google-Smtp-Source: AGHT+IGhBrnSQcZ3cbjW5aywFAcwebH4gCWRyWKAKB++dDorIsv1mRlBHDkizB8vHNSseXFpo5sNeQ==
X-Received: by 2002:a05:6000:40cf:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-39c121188b9mr8186559f8f.39.1743504609334; 
 Tue, 01 Apr 2025 03:50:09 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b65873bsm13631236f8f.8.2025.04.01.03.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 03:50:08 -0700 (PDT)
Message-ID: <67ebc4e0.5d0a0220.aebab.03cf@mx.google.com>
X-Google-Original-Message-ID: <Z-vE3tfTLVXPEwd_@Ansuel-XPS.>
Date: Tue, 1 Apr 2025 12:50:06 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/6] airoha: Add initial support AN7581
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <522de79f-276c-446b-bb71-f407e26ecdf3@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522de79f-276c-446b-bb71-f407e26ecdf3@iopsys.eu>
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

On Tue, Apr 01, 2025 at 12:45:21PM +0200, Andreas Gnau wrote:
> On 2025-03-14 19:59, Christian Marangi wrote:
> > This little series adds initial support for Airoha AN7581 SoC.
> 
> Very nice. Will you (or someone else) upstream or at least open-source ATF
> parts as well, similar to how Mediatek does it?

It's planned. I have the source and I have permission to opesource it
(there are lots of .o file but whatever)

It needs lots of love tho as they modified ATF fork A LOT. I'm giving
priority on U-Boot currently.

-- 
	Ansuel
