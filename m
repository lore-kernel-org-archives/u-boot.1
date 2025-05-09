Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A6DC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 22:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2379182958;
	Sat, 10 May 2025 00:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F6N8iSe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC4B82952; Sat, 10 May 2025 00:49:51 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4ECF8211F
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 00:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-60638c07cabso1493014eaf.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746830988; x=1747435788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eW3SecXqOV1VhLv9ChaAv39sxcDpEqguj5wUuuFa9M=;
 b=F6N8iSe86j8wS790jVFY2JIov7fhLQZ5ydGDUkcIDLZxd0WxXAt+lssRYRdCyJJPCP
 YOjvbpPqCWpWxF1lnpdyoZDCbZhhxXstwsSXGh1DRpAJq9ZE77GA4JIcLDruFAlH6XP3
 lZ8OlWNefEPQqULUVsiOcAFiQ1tjg5EtpJUSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746830988; x=1747435788;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eW3SecXqOV1VhLv9ChaAv39sxcDpEqguj5wUuuFa9M=;
 b=RGXRIIwF5j2CeDe+/g3WMnrUVbXhz7uE3KvlFKoBObXK2XiBNCQFIgeeDMomBV6Wrw
 oRzUb7d+x8zpphyUgZG7sq76aXxXM30Xvmdw8mhhk6Hmjsrb78k1E4jtU+0XJGJKaiZJ
 HSAkjq7ddtzjORsnm0nWWFLENcGWbqqOF6aN19mJj4GwZ3Rtuk9F9gtEeYWozOEwK/em
 1dN8S+YMTh1A2bIZKJjTeSc17dFsCxF85ADbn2Nj0lwycNTtfHuiwhdMFIH/xrt6gmpH
 hXMmtUFUxcX02yEfaqe3oc5+Mmw0ZQFesSa5U95ULbTVXw+vE4Ns8OngefNNxJbqlQn/
 agjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnPf2MLIfNfyZRs5TFMAHP0ebnopuReevFvNzAb487fuA1SG2nXnlEKWD+tnp8kLLQoLau3oo=@lists.denx.de
X-Gm-Message-State: AOJu0YwD4MiMHlBt6F2LZCMuviUJfPe+AnTYuBLuwXz7Zf/hEwoNSO4F
 mw1VPQe6P8+THvEjLLWVCGBsjT5n+PTCy78cFO3fV3S8QKEVqEcUBwhJRcbD6HXFJYKXrgkTOgE
 8
X-Gm-Gg: ASbGncu8CXGuFtJ7Sk12GEXnt24IEbWyA/GX6I4RHsNWSNZLJKE0JlMnsVubRwBPlBb
 41meDFyp9gCAV1CDFc6qLMVl6ktsj813jwBf1kfcgo06kEpAz0Dat00PNpXLE8CGgQnaASrDHk7
 cY6wPcKdy18iFpH1kW01KfV6aceUwJfrVQYNtzKUKvFwTw/bSlJkYKjCazBvSBquvRq+zlibphp
 q6QJ5KGAffibWhVQTz9M5f8NedWC6N/8OGdDeXjf/CVYtvOuuYDyhwsb16S/RZ/xpOvmMJuFvDr
 B3/GfMAmBmsl3VB3gcOBc6cQVxbnHBmhcW5IhE0sN6p6U1CHvB5YSXFdbsOjYs/wt8oe11TTtwo
 6ffYTK/YdBJbjYd4+7WN5YA==
X-Google-Smtp-Source: AGHT+IEY+4LKcZz5o4DL2l7VzaKEU/xKFHuEK3ltrpXApjTUhhqkuYUgTcCBv57nHQzjDGLOt1jTdg==
X-Received: by 2002:a05:6870:548c:b0:2cc:3586:294f with SMTP id
 586e51a60fabf-2dba4280684mr3392183fac.9.1746830988187; 
 Fri, 09 May 2025 15:49:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b82571sm801403fac.49.2025.05.09.15.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 15:49:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com, 
 Nikunj Kela <nikunj.kela@sima.ai>
Cc: boon.khai.ng@intel.com, tien.fong.chee@intel.com, u-boot@lists.denx.de
In-Reply-To: <20250222060734.1367838-1-nikunj.kela@sima.ai>
References: <20250222060734.1367838-1-nikunj.kela@sima.ai>
Subject: Re: [PATCH] net: dwc: xgmac: Allow DMA buffers above 4GB
Message-Id: <174683098657.770062.10589776327587862071.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 16:49:46 -0600
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

On Fri, 21 Feb 2025 22:07:34 -0800, Nikunj Kela wrote:

> Currently, Synopsis xgmac driver only works if DMA region is under 4GB.
> This change enables the DMA buffers allocations above 4GB memory
> regions.
> 
> 

Applied to u-boot/master, thanks!

[1/1] net: dwc: xgmac: Allow DMA buffers above 4GB
      commit: fff21d27a9d5d3d75bb63652156c24a5e240df48
-- 
Tom


