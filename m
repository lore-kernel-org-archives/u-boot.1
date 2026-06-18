Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FCACD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 14:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D86847C3;
	Thu, 18 Jun 2026 16:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J7pgFBiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC25A847EF; Thu, 18 Jun 2026 16:33:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5C58460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 16:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68c76fb8009so1543006a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 07:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781793213; cv=none;
 d=google.com; s=arc-20240605;
 b=exXyCGvSU6N9bBkY1qwTQiPKlRcbnZUi3NKPzyBNomu0VrLAKDqR3emyJ77hr/HSIQ
 kv+ONHZjbF8Auhv0lRBGrPj7qbNsV3trhB1b/6AC1OZ5gPoHXdeyBy15zewBB/OOTVcg
 RSlOHM5vYqgTznejtR21IfBF6wtwraC/gZUjnRacsCzUf5lfh6gdW/9Hg9if1dG9vxnj
 ROJV0aphNPXxDLeLf9eKPd/9PcOs2dyuSVS4CMu8nQWGV//h1GYmMnYqopFIcz0de1sY
 8Cr3yGn4SSQ/CDhXeZ5954q0Z4/FuBDBtaZNRx3CAl0uYwzSPiEq/YXL4RF9Mukrdggq
 gzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=87JQo2RfUCJS5CxSu+D30MBR57ZOjfsR51cuyaFfnSM=;
 fh=1s68Dlc4BDLSzoI0mHfwsqmbhOFfBZDaoiDm9bUcfL4=;
 b=RfHWXorYz9c/xLQvP5oJV/VF3rGBhYJpF1qLPmGEC3w/zFv2bxIhesedYtiKEPYDvj
 7IQhWT4mRp+aB9+l93BMyyyE0lTR/1pSl0GIB3radnLaAlG3x/+YJ80hl2A9cx4AkBK6
 qhOE8b6mJDmKoDHhv1NRqwt9m0J5p8Py95zWsFAP0eWv8WR37V9ksoksVmiLdjLdoLWp
 FW8qrFwD3Fzkem0+GBgXC53j5JVyFdlKe/ybwACWm4k5f90I5rRzG0+oYZZrWdPZlVfF
 OJj7D8DG1zrItEbvPznAyS8+7SLSnRL2rsmcGWjwCwHI4CexbUbc1sUZIp6uXo/9lVdr
 b0zg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781793213; x=1782398013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=87JQo2RfUCJS5CxSu+D30MBR57ZOjfsR51cuyaFfnSM=;
 b=J7pgFBiLf86NRCzcoDVUzAcxwCK2QiO/HElm2/l7qEXHx5t0TXikMZGF7UJx0BqvKa
 00koCd++5i/h8DjpDzopPUF6ULUdIVoBA1LaXc6Y8v5DMiAfVFHNPx0Ar1G0YRu8u/a2
 lyNaCOry5wWDwg7/JtlebCWi5naTAazASxmiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781793213; x=1782398013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87JQo2RfUCJS5CxSu+D30MBR57ZOjfsR51cuyaFfnSM=;
 b=Ha+1OJk0nAiVQpx7oNHBegSbXB+d96WA2buZ27V1Jiz3d2nT/ASo8R0OWlS9LiQvvk
 /uHG/ap/M0YX8giTDwjr8kXUVXzhdYdEdtktjqjSu4yQgxnAt8akzKmT4aToPMVwL7Ge
 /+JbGQktRiXAxTBWg+SUnt8EuTIWZVafQ+vJS1iN4XOsXWlOB6jMkXjMZr/NyeOiUk+i
 +tz/caJMm89+QkoUsShlVgpH/oT4MqcUry1a1DUBdTIqCK8wkf+DO2BGnmi24N/Q8uDE
 qsBLAd0/By4iFDTp9rTvUh/BkwoKN4ou9yYBd/RPMFws8zDmEjxOMbPrjBcpgGxh8ToH
 baqQ==
X-Gm-Message-State: AOJu0YzGHQo/ihluQHqhg85+uoDd4SEtda7bmwlYb2M2Pkfka65HhTM8
 FYV/AoR6chpylQFB5AbQsWH0/GMD/1Tq/a70jqHET12Tq8wOTwCzLaiCCcCNqFBulT9VXF+yNHa
 Mv2yXz+xAmaCgBUkAOa2Nuha7ihtJ26C2toqf0m5F
X-Gm-Gg: AfdE7ckyhkQVoj56/TumuKtPEDVFkELeQJDN8zP9FGr43hwQI59PJOWHrPVIj3+MuPN
 d5MqtpY+7FZcUBxPw8aKag02pfWUaLxnKwQ4XFPtt9nwOV5dCPeZwe00/bRSEjl7u0dEnbeA0xb
 5O2EHI2efJl+veW1BYNzSLr8FckAxPfiqVW9OWiO3P1IKjgM52zgLRBiMrjHmzfqTD4qyQfybKZ
 L2r+BrD97rFHScCzI4pvTrbNDeQlXFVNDLFNN8vhDOuVyzMC87vx4msLLZvVM8Kk93HGvFlAw==
X-Received: by 2002:a05:6402:42ce:b0:68a:f2ac:4675 with SMTP id
 4fb4d7f45d1cf-6954757fd22mr5276388a12.7.1781793213510; Thu, 18 Jun 2026
 07:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
In-Reply-To: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 15:33:19 +0100
X-Gm-Features: AVVi8CefXiM95-YamS-ndtSA3E4k8eCNmyY3GCVAp0z_b-wt-gxWc8FJfTj8hUc
Message-ID: <CAFLszTjfxGAcU9xTy63ogmoW7U8J9dW8usKWnrvaRE393OmsKg@mail.gmail.com>
Subject: Re: [PATCH 1/4] bootm: fix flush_cache() with IH_TYPE_KERNEL_NOLOAD
To: nora.schiffer@ew.tq-group.com
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

On 2026-06-10T09:01:22, Nora Schiffer <nora.schiffer@ew.tq-group.com> wrote:
> bootm: fix flush_cache() with IH_TYPE_KERNEL_NOLOAD
>
> flush_start must be set after load has been assigned.
>
> Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
>
> boot/bootm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
