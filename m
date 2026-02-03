Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49041E87852
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 18:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5EAB83CF2;
	Tue,  3 Feb 2026 19:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ha/F8jX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A45E83C29; Tue,  3 Feb 2026 19:48:01 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB5E83CB5
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 19:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45c889aba0dso96026b6e.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770144478; x=1770749278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ATxReF1XKMb+f6no6xqYVZp9MzCe0JSPr1LfFAai68=;
 b=ha/F8jX64a6K6/id7cKH2vYdum7VMNXKgQXg4Kg3+mkpLXhfhEc1Lvta+g1XLX/s7q
 FnNnztMaFwMd0efQ9SaIB++yY1AkMOgcDNDbshZqmzuu0fgmUnQuy85a4L2kjZOtbA7U
 tYMMpbgkVdDN3Ud55rnaCVS0h+OvMVgLkeP2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144478; x=1770749278;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3ATxReF1XKMb+f6no6xqYVZp9MzCe0JSPr1LfFAai68=;
 b=cYoaFcg0kX0QexYRFfVxDQoayf1VolmjPViIs0XtCElGTfY9C/MecFadU30hU516Xj
 2HT6PQVq4pHy8MwzipP+9lG7c7m4Io/jyPIOU6ZBMNm3D5Eeaq4ljPo/zKPFukTDXRu5
 3RkZ31WchIDx8PkWlOaKk979baH/AXQswC+jtyVeEynUEHK4bFNTN9qpth6RSGrr27Au
 phwveyBzRt8acH3z1hhCfHIuNFfWHkrVsGLFQZNEZTCJ5Jrh7K1fZ5oMh8f6WjyLmwzR
 Cb+jptfNCdivk3FqxJmLTGTjGvgyZ8feeCuLeW4luwMO2AhhRrJpJLO/Wu5Ca0GKsVyd
 lJhQ==
X-Gm-Message-State: AOJu0YwuJGrYd8xq6Dpl2tmDn0WVsU4wZdYirnwaP59Q4YgBPmuml8WH
 qUszsCFXIzKJ5+LV/aCopHyolE1ZV1x48324X+reAWgGAtJncajWhRfzjPKJr4Vdx44UYaT9W+e
 rawntXMA=
X-Gm-Gg: AZuq6aKk0AUn/oXtbE4pGspH44GX1aKri5c7xSITihnr9E/fn2lxgRRwXimWK+xtOum
 Sjt2kPfuqwpXK6z9DeJVWPArckT7gKHS9VLEk/whWBUVomD4UpJHzu2E7rWdiFoOVx/QoSUrVum
 24qjy5Zx9RUOb2ph5uMJUb3xo5jQTIIj7VJAjfySRSIuV6H0lZAeui3lKeZm/M80hnlfYRl36Yi
 ExQBSqNDp/yVgil80W4uNAKXLTLZ05mOMXmXYPdfdrQid13HdAtwmte+d0h4QFOUjW/YVCxepMs
 HTH8IVXpsYTeIFyokXO46E5JBrmPUQaPpEg8nvgLZ/ggN9rMB24oRip59mGEAVP5g0HeuNqU8Rj
 wY95shCcqAj9JSbgB1luV/I1aB/yF+i7DF0FZjvIV6hVlV/w9ZBbW03VeD8EjAvbbu+jWkMp28Q
 LxLk2zFgeakNYwl4IR63XylMvyiDPc9mbsWlvyBD+8s10oagv2xcGK8DMQwPQ72jE3vG5P3sSVg
 Jg4/Gd44kAq6RsPNhV1QuOyJr3zzUy3lp4YbQ==
X-Received: by 2002:a05:6808:f8d:b0:45a:d023:90c7 with SMTP id
 5614622812f47-462c12c0d4emr1914678b6e.26.1770144478313; 
 Tue, 03 Feb 2026 10:47:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d67773ecsm55054b6e.11.2026.02.03.10.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:47:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260203080034.336758-1-sughosh.ganu@arm.com>
References: <20260203080034.336758-1-sughosh.ganu@arm.com>
Subject: Re: [PATCH] mailmap: Update email address for Sughosh
Message-Id: <177014447777.1468348.6597018461092892893.b4-ty@konsulko.com>
Date: Tue, 03 Feb 2026 12:47:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 03 Feb 2026 13:30:33 +0530, Sughosh Ganu wrote:

> My Linaro email address is no longer valid. Update entries in the
> MAINTAINERS file, and add a mapping in the mailmap file.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mailmap: Update email address for Sughosh
      commit: b3d5e06b4b1062b2966ac7fadd90ebec74fa5cac
-- 
Tom


