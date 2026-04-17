Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449B5F436B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702CE842D7;
	Fri, 17 Apr 2026 17:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FAXc4rZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886E7839D9; Fri, 17 Apr 2026 17:52:32 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6172884246
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so416602fac.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441149; x=1777045949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAeUim+NlG48NU+isjfBoJwrfWSZ09WvfQAnKySjb7Q=;
 b=FAXc4rZ49Wmr23LqwHU/21DJpP3yjSx+zMKpNF/+AqY0dis1qmcN5OrfL6SqSDW7PS
 /CM8bSpt/00H1/ynmz2L/werHVyAxxPO/EkMa/+wq0Id5U4UNfvgfkNipvASusswpoQM
 JOdK+ck+MbD4I80+JOpQXB6dcwgrlsjDCBuNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441149; x=1777045949;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XAeUim+NlG48NU+isjfBoJwrfWSZ09WvfQAnKySjb7Q=;
 b=oh5l0HKFuMd+AFCxJbW7KZBOMRF8fXvVm0jJlpL+8IbHl2CvmV+RA1FGISVc5GBWwI
 Lt4ZTDR5BOcbRFy00weKevK4CtopWZPhMn9XVAi03bUFc0mBajsD/g1JKkPlbqlJrixq
 cDY3PREgkcE0LWWgyhzLdkg/bYtYP2v3gnuNoXzbG+ZQ6kLdR7JlPBVZ4wg5JxdNZBR6
 Ho1Zy2ZIpFrMLTID13FEjxQUgzxKl9BBZlAadwDbhv3rRhFmpdgPQ91Wt8Wk7VfzQoVq
 L2xvkPX1FFFcu5E0pru4SVvdJpOy7YoDDk/zLyhG2r+aZQHMF/sab9YpgesEAGM+5J2I
 nHow==
X-Gm-Message-State: AOJu0YxDLH4UlSpmSzcUdYuY665MCSKizSDkcK0CUgKi5hQ+Wnr21dcu
 kripzFmQ42D29T8Btg+EKTg0B2qdQpkBeKD3HdDbrso/Y+TU4iNbmWMGVRarpjW+9Ps=
X-Gm-Gg: AeBDievde/ott8YmxmaKg4cGfNA87y/4ERZWJrSeTMFy2lAIXqZoWWbl2p4L8kFGy2s
 kNU8qv9Aw2ewZFZ5zmqXpQHr53pa5vK9Thb5/VhIUfCS6FWTVMJs4O8yoTs/0twOoSZgaGl3QXi
 ZImNOibEmP1lTlAU19cZVljnMVVzoLMPcrWV72NoTEgKzWQPvNTAn1RRLngUK9B4BBMFCxfeKqO
 29uyAznkfejEgruHkHC64rNvYvLxgDZ1P1SVHhII7OOj589+g9QPZDEL+Rzsfw24BkFxfSDT78p
 ny8+X8VUlgApOBONfIBSzwTGlRBdiyBZFgSwuIwsEeFdoHcz3aa2NtxiiuLxlTVpVS3AJxypWhd
 vetB3ywkci+CiJUIaVqwtGvuQ95LNuinq7TNZKklARJyHTN1x4Q1HbXqsIMjvkpvBTfpzRPQqe8
 6YcmPrZEXYgIsbvuCFz1NEGeca/yVPQms0A7jEUnqZMs2zSzUKL2Lk+ovI8gVgowV4QcN2aCmEr
 Fr65Iz0pfx9oVmpj73azxa9zc4+wODy1mMhkHpTEE844C2GUkAe2Z4P+XK+
X-Received: by 2002:a05:6870:15d6:b0:408:694d:ff27 with SMTP id
 586e51a60fabf-42adededf30mr1737057fac.34.1776441149038; 
 Fri, 17 Apr 2026 08:52:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chen Huei Lok <chen.huei.lok@altera.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Kok Kiang Hea <kok.kiang.hea@altera.com>
In-Reply-To: <20260209081007.5166-1-chen.huei.lok@altera.com>
References: <20260209081007.5166-1-chen.huei.lok@altera.com>
Subject: Re: [PATCH v1] spi: cadence_xspi: enable automatic platform data
 allocation
Message-Id: <177644114799.690930.3587338314067655756.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:27 -0600
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

On Mon, 09 Feb 2026 16:10:07 +0800, Chen Huei Lok wrote:

> Enable automatic allocation of platform data for the Cadence XSPI
> controller by setting .plat_auto.
> 
> Without this, dev_get_plat() may return invalid or uninitialized
> platform data when multiple XSPI controllers are present, leading
> to incorrect IOBASE/SDMABASE/AUXBASE values and causing SPI flash
> probe failures.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spi: cadence_xspi: enable automatic platform data allocation
      commit: 39d1a96d71f8a77d9ffd55474a317e5bc6bc230a
-- 
Tom


