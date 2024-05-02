Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6DEC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 02:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08ED588C26;
	Thu,  2 May 2024 04:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="cebIEZB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406B788C1A; Thu,  2 May 2024 04:39:18 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FC188B72
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 04:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-61e0c1ec7e2so3858437b3.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714617554; x=1715222354;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X5qqWfA78jS83dHKyUQuAKF9KmJ6Q//qYyu4EC+Nc/o=;
 b=cebIEZB8bu/aHMUigHA6pzAAHjA0mVI/cWadjpKOIySscWanTyt6MXuWhJyLBL5Ga7
 ZDSco52RgQJWqWRCZSTC+GzLwO5U7xe8KJdgA5LKmrto/DZaVdO3+oH0444zNBPAudPp
 CeDaVC8RbcaiulFfY5AR71KH7ODiwrA+eYMz+xZ3TrVVOztlM8A33TaCdd4k3cDEnIpE
 MsZscXZg0pFh5YOwVDmyXs08zr9YV07Vyc9AImOlmJjlQU+QPm28sofkHilZn4p9YG6S
 RBiuivv2NPY1n6L0MfnlpuWnSJKkrT5HKFQAvgTL0s96GUt71SdX5hxARdomOCGpVmtS
 xesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714617554; x=1715222354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5qqWfA78jS83dHKyUQuAKF9KmJ6Q//qYyu4EC+Nc/o=;
 b=lP6ZXgSCIWdQp/+pltMxjUi1iAteyebmOTEvos5jRo36psscowjML2+vwz7PK0grYM
 nPVpyP77F43EnNSvrLjgm5n7rZpE640evfqIOQatLRt+0Eh7KVKs4X7Ur5HQ+JyM8hWh
 hUlKRMNNU92f7Z7nkZBxlLft4DudbsnuZNuqLH4dishRbKvXYVXiBNefBWDPz3XCOara
 vu75GM+ZNUh/ECBzOcy+AtO+GBWHVBlJtjOBGYVHvtOMQXJHguUVt78eRA72LxQVuJk4
 2jQs/Y2RifNlN5FJLGbY044LeroTHoB0WaFed6i1HBkU0nARPJZr4LkwGsPENzHLGhJ8
 piSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVth/umGHbE9jAy7OIWoaYuke7KmmKFfJnxykcXqkiHR+3M8DYLiHc7dBMeZHPgtX5Xt/sufJ8N866aCuD7md6d0663vw==
X-Gm-Message-State: AOJu0Ywzp4AJzESN8NMDZ4lvR0esYI6+hEgtiKJKhwaZz7LU/dI5+btS
 9j+auw1W+5h2MO0z1Z04OWYYE0/nKtTdvA1qoERQU8BJvnlUrvWOM9+j8NyIPNZdQsEf9fzQlWC
 +iNkZabbCULZquRtJVo99xEWCmfZogmWwOl3B
X-Google-Smtp-Source: AGHT+IHwZNjQZOvlZ9J0zCLik4263bEeVOykKsrgsdbL9yc09hwdwddv5XRiJgCFPgAlSPn9WL80l3BUjRb4U/ciZQQ=
X-Received: by 2002:a05:690c:338b:b0:614:74f6:df18 with SMTP id
 fl11-20020a05690c338b00b0061474f6df18mr1022802ywb.26.1714617554303; Wed, 01
 May 2024 19:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
 <86wmode1pi.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86wmode1pi.fsf@udb0321960.dhcp.ti.com>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Wed, 1 May 2024 22:38:38 -0400
Message-ID: <CAAjXUar_8wmFiUmo_nGhquwb4iiUmRXWASkg1W9Vga4hrQW-Nw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Correct ADMA_DESC_LEN to 12
To: Jon Humphreys <j-humphreys@ti.com>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Thanks for fixing this for me.

> Confusion probably originates from Linux commit 685e444bbaa0
> ("mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode"), but
> the latter "V4 mode" was never ported to U-Boot.

I have one of the rare platforms that does not support 64-bit ADMA2 V3
so we also submitted 5359cd1135 ("mmc: Support 32-bit only ADMA on
64-bit platforms") to support that, but if we saw hardware that
required v4 descriptors or someone insisted on it, we'd need to add
another Kconfig for it. Do you think we should port the rest of the v4
support? What about mirroring the kernel's dynamic behavior by
checking the combination of capabilities and control registers to
figure out which mode to use rather than hardcoding it?


--
Greg Malysa
Timesys Corporation
