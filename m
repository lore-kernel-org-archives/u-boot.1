Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD5FC3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 06:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B128070C;
	Fri,  2 May 2025 08:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ysWbhbXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CACD812BC; Fri,  2 May 2025 08:55:08 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EE08059D
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 08:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acec5b99052so271386066b.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746168904; x=1746773704; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nQUyYZwz5VA740zUPAHjltE3fXCfp3Mua5uvYw+RJs=;
 b=ysWbhbXZDYZMhwunY7eTJ2Rh6BS9NIzMHoMr0/Zq/0VzbtCMylnjla/vXsKDoDV+NH
 aluPWjLrNHruSLNF4LRgUE3yCbPRLdGc6McJEg0odzv309IGLbcHHyI/mfk6ZfxRo8nh
 JEaD6/TgGH+lt18KopYOgho0gAPiXSkoFp3Rh6h7H2w0LkKWR2kjBXhqpT39OTNXMDFX
 eN5LZ8Qrf1QGZRPohjyok9DhI0EwR1GZ5FlSa+MK0p6W72aInF40aJdhjUePhnuLTn79
 K867X4BBpUJVBZrYhALajphUQFWvcMKJiKWA5YSGvbYcMZ45yb+H4wAI3ZW4VAIAg/3q
 WDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746168904; x=1746773704;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0nQUyYZwz5VA740zUPAHjltE3fXCfp3Mua5uvYw+RJs=;
 b=rPG/A7EtH1m7B9xMKhLsiBU1yk/eEFJKBTb6nTUH80TUfgHpRL9MYKCMfD86VPPC0d
 A2fTCJRpI68+P4vhkNGBlpK9TONjQGik/vGUH/49MEeR/iZnVgc5eugc61OcqFey1Qzq
 rcll5mgEgsoDUBi35L1Hszz2q0bruiebI77Ki9Csd6mLAQ/Io/Wv4xAUAvXfkJZH/4/6
 YtWjsoKKiLZ28dxcqpQA2RQf5MtnuQ4o+V9wex+EK7ba6nDyH/HgD9M9NPCmNijUvgYq
 EA0OJCgrIkjAzm24jVLmuomr0y1P1oQo2zqGQDaNqD7UR6Ousd6RYgHe8lEkJCQ4qbsp
 7z6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0VkzLbG0qep2LTncgaCiOsysFuDCJk7du4/bftnMZVaJUjrVOZ7wSaXz0QDsq3+EtJhcCI0Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwwpFWmrpjnagPBmQwDzfILEOoOWuo+ezhDKQ063aQCaGGwUYE0
 QqKvjZvC6VXBCavBcFCxTuMJ9yxafMTbZOWxuik24QzzbzmIwhwu77rqLsTKibQ=
X-Gm-Gg: ASbGncvlH74WlkuTrUwXLD06/kj4Qg4UYAk/BTkUtXiOJ/qnUj/12Uf1pNaQLEzt3GA
 tzrGu2XOAjb6eWJtIiOsjaD+2ZR9+usNr6AJlmffYewPqkVjqxCYOf+70ycS1UZUlmRyYgqDDph
 HQwZYiUo5QWMOcF/4RTXzWTaQ12yA81JciXCnFavnVAAVv+eKHWimFDRhIJYAFqlF2fasF8sO5P
 KF5NTnAiPaPjuK5FQFtvbo07OHPPe1icoJ8q/QHPhEv/meIXMiCckPXhDPXsp0kW1U7N9y6r8Ip
 kZdrgRS1GJrQcUncCuUlgwEvk5lC3qke2VY9uqFr7J+wGmaj
X-Google-Smtp-Source: AGHT+IGqhuJ9ZkYEXtgRsTvVPBZ+PxYcc4wlAZYUehTiWsfufEiqo2QnsPLgcdk1dgdEAW+mxkzyUA==
X-Received: by 2002:a17:907:6eaa:b0:ac2:cdcb:6a85 with SMTP id
 a640c23a62f3a-ad17ad81d42mr172820166b.22.1746168904081; 
 Thu, 01 May 2025 23:55:04 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189508afdsm746166b.140.2025.05.01.23.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 23:55:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 09:55:02 +0300
Message-Id: <D9LH7RFN7GRM.ELSYN1G3Z1CX@linaro.org>
Subject: Re: [PATCH 3/5] lmb: staticise lmb_add_memory()
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Sughosh Ganu" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>
X-Mailer: aerc 0.20.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-4-sughosh.ganu@linaro.org>
In-Reply-To: <20250501120239.199829-4-sughosh.ganu@linaro.org>
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

On Thu May 1, 2025 at 3:02 PM EEST, Sughosh Ganu wrote:
> lmb_add_memory() is only called from the lmb module. Mark the function
> as static.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  include/lmb.h | 8 --------
>  lib/lmb.c     | 2 +-
>  2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index be723d9162a..73df4e07248 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -120,14 +120,6 @@ int lmb_allocate_mem(enum lmb_mem_type type, u64 ali=
gn, phys_addr_t *addr,
>   */
>  int lmb_init(void);
>
> -/**
> - * lmb_add_memory() - Add memory range for LMB allocations.
> - *
> - * Add the entire available memory range to the pool of memory that
> - * can be used by the LMB module for allocations.
> - */
> -void lmb_add_memory(void);
> -
>  long lmb_add(phys_addr_t base, phys_size_t size);
>
>  phys_size_t lmb_get_free_size(phys_addr_t addr);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index a21f9c72204..55aca306a90 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -605,7 +605,7 @@ static __maybe_unused void lmb_reserve_common_spl(voi=
d)
>  	}
>  }
>
> -void lmb_add_memory(void)
> +static void lmb_add_memory(void)
>  {
>  	int i;
>  	phys_addr_t bank_end;

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

