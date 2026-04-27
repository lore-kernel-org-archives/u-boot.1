Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07973FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D658407E;
	Mon, 27 Apr 2026 17:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ewti25pS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63BD83AA9; Mon, 27 Apr 2026 17:42:13 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7B08407D
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479d68a9062so4426988b6e.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777304530; x=1777909330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2W+/rCbHjWgeDfmOLnEAqkCjwrfBbMfS5HTd07ZBIuw=;
 b=Ewti25pS3XXQlSRKPwAa74jQqS6qwSTaFLkzqplvJp/S/QfHqPJUJi0ktrKEc4L6N0
 Ay48kPYqT3ItyeCJapbDMTI4k+wVBdQs/1eNkZYgLiM4UMPC/T8SdtqSCMFWRRGr1s4y
 HZLGkRNVsQk/u2ukh0VQaUFYfV3QK0lMGfIO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304530; x=1777909330;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2W+/rCbHjWgeDfmOLnEAqkCjwrfBbMfS5HTd07ZBIuw=;
 b=D3b3G2woOSxWHKlW7+d1QO5fC1RIaWwhCeOIVBQ70ons4HbYi34qCzIFROQNoSkOSX
 78T8j9nha8I03+n8OpM7o3Z4tJ48oJ+u33zSA87PXJbOuHtYKDng55PkzkKTeMKIioVL
 85y6xKiejt61/UnhpocmqD/pB2WYDqAX3pZtBOIWUx+3X0O48C9tiZGYr/REU7FVzhQ0
 YZgoD8VY2xWJHG7S72+KLDP0zGo0XSIRbI8mjLiyzrg6MMhAL8FRBkmG/w2G9o5To4DB
 l4XD6vUQC+KkqtGYZM8qgmJwiCY2QpKWNpPH4MlaS/hGIy92y11HMAIlp43UVRV0bfnT
 tIFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r+0Pfsu7u/dUiHzGDPMvdgXWeoi8dXq0kZ/clASsI0eKaheTC3lBacy3Qc6rAm+Bodq5Z3Xw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4Jl3n7YN8oGvvkxjOJSrRd/CP3NvObrfDsXf2mtrrR3zQeOih
 WVGVjBSEFLwzDDGbUVju/2eW8HjWXMBkJVTFsAGRAFlIJJZgTVUwviTNMGcklP0pxbs=
X-Gm-Gg: AeBDiett/U0P09m/J/J+1NI9SlnqyHjEaoV4wpUs1LpQ6IxIB3jWO7uGKxXmLWcijZd
 XJeNTLHpXSbjKK8gmww/vmklQHGzv2D8HJBv2Bc1RqnszttUuAGv8al5TuhhbJ/dGrVavnzYDkd
 c5Jbzq9SxbjIwFfuCmq5jPHIneAZm+TamZhaqeKJgW2l5UUuIYX8o4kcoKIk5ar80iFyeh1phfC
 yYzRiF4YTeO8qiNA1LbMvWgXYuoSDAEfrAb/C5NAXgsZfcau7NXldWeTR8ZovkHmj4QR4u2jkan
 UuW/F5kC15h4AZ1MRc0q43PCk/Mlk1HmznglREIcy4DuT4HcqkTmIRGfWJiWEflXUbiMkeu9DPd
 AO+8fZ68qqjauJhvd8Gl9xjLwPbsapeAP2sPiLxpV4jsvwBdex267gr2JttQKVvyjP2fU+RwSud
 XJa2rkSwR7Zh5zCxKeBHzSoyW3S5/dm9xWJ+xsXsuVj5uKIXuZkeINb1D5YXN2w5vx2pVMaGD8F
 FTXgowH3nOO3FqTFk9QqdaWqlJvhf7/HVYxIfBKoIrFTYLY495uDgW5tqvN
X-Received: by 2002:a05:6808:1791:b0:47b:beb4:6c82 with SMTP id
 5614622812f47-47bbeb4ad6fmr10844804b6e.16.1777304530569; 
 Mon, 27 Apr 2026 08:42:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c1c8cd7c2sm824896b6e.2.2026.04.27.08.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:42:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <41f5a6a9-6a0b-4df4-abd3-aee0a7297ba6@linaro.org>
References: <41f5a6a9-6a0b-4df4-abd3-aee0a7297ba6@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20260427
Message-Id: <177730452980.3468459.13288390272488234397.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 09:42:09 -0600
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

On Mon, 27 Apr 2026 09:53:54 +0200, Neil Armstrong wrote:

> Here's a short set of Amlogic changes, first fixing MMC init when switched
> to Linux 7.0 DT, and adding support for EFI capsule on disk on Libre Computer
> boards.
> 
> Thanks,
> Neil
> 
> The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


