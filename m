Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5898BFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8558466F;
	Mon,  4 May 2026 14:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ewFgkHWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC548467F; Mon,  4 May 2026 14:27:50 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0166F8466F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso574043166b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897668; cv=none;
 d=google.com; s=arc-20240605;
 b=VV2oj0pzL+zJgevO3ZO301gWMRp3jQl9CB0CdqLQd0OINPDBwwtA55f/fB/6ySzwl2
 Rb31qtaorWG+G9garxwuruFvarXNXq6IU9Cfn94Fth2w8Va2BaljMzKJxe1vBn9dXmPm
 WrG6n9Ej74h6Im+9rXRwerWxt7/NP4s6PL7QTbfTGIXGS4/JSCB6Fw9ZaRM0HbYhT7bR
 KAdKHuqfDMAnYkRix+Lsc9Ph1hKMuTFKba4EeVWlT1Z+Ct8tA3qzmC5/J8MBKieD14hc
 5ADjHSMVG11/JjssWzz2jxjy3tb43dVgHYd0fkx9vT97/3DCOXwyVJc5gMpMGHd1GTaP
 aIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gTLdJnpwr61y42cL74CtGfTRTFZq/rWPcJGL1ynPJDY=;
 fh=pCo84Ld/Lls5A+seuHpViQR2DqbA6QvisXP4P/lOPxc=;
 b=IuOwNitvcF9Uv30My9Uaix84rmg5F9T7uKSiEu5ORGKfpmeg5ocmRrXr4aP0Kr4Dfk
 op5dcmBJWyirFBRGHhzoivhug80R6C0NuegY7DclPyXo/5yPRXWMCu0IQTyOt8PaiXYs
 wXkr+BkhhxaAx43WZQ1ihcJDBq37AmBxEIZrWyzmNH9tc/40BZCP6G+q2h7NLpJYfLup
 +l/d5BE4Ovvx1A/OHh4HaZF3pzv0uvNLhVpYE5qf5Rg9jZNzIT4P8dCdtiu1kpftF9O/
 3+9szZ2mEa4t7WgA/tRXC2/OJ3iwGmvGi7blk1KQ/GC/Kv9aKU+PiA/Rn/TolaFdzvZ4
 vEIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897668; x=1778502468; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gTLdJnpwr61y42cL74CtGfTRTFZq/rWPcJGL1ynPJDY=;
 b=ewFgkHWxFI8ILfBZ06RW5hNMxNZN9sjQTVDtdSlrJYAR6eutXib+ZjxHVeVbbQPvuw
 v32Ahvppbu/6Gm0z7t8pbE9OalpkboiAdIQfomegMC9OerWiU8/ZOxrecMLogoI1fIsq
 /VNbAqkdbspZvSdfZuJ5nz1ySpbS6+rppd4Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897668; x=1778502468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTLdJnpwr61y42cL74CtGfTRTFZq/rWPcJGL1ynPJDY=;
 b=WQfJBFmwSkzITs6T6OtDvBy0Q8IlwyWEFVL2Hc23HgMRLHpn5NjOHTK0vmiwGGs503
 dMs3l2eDu1m28lBCwcLAsgbvcoCZp09WaZQvGpqPPyhF2laMe6qC9nRbFyN5oCQYP/qq
 ssiptBaYj5gXxJB1dOnZ4Ja+ISLXatYHi/aFL2kC87I+FdK8qoW0oOnFo+slBKBHisPV
 zHiLGXXxAoKNaiKc5mhn9klf6HXEubRpYCvpzEnbura+1kUwhD0EqisNzV8sbLAE9ASw
 v43wnfNS3KrSACGQcDpDe7Q15yYseKM6mVhpCYXi4c7750Dht7z8lzQKNISFqhizjKdQ
 hclw==
X-Gm-Message-State: AOJu0YwmXNnJjmFXLcGLasMEheiHPPiplwUjmeK/E1OwTeOlWXMUuLra
 uCicN9qGrmMR82W97IHNm4m6zPIeWj/bF8rJPTB5+B1jC8pZey7CWR1F20hqNe3N2oge/wNIXD+
 FscblaASOoFhbyPMKm/d7pkd8wXEvlSbzRG/MoxKl/ZOaDqrr9v4=
X-Gm-Gg: AeBDietmJPfj+kL+FkoDgB2uw+IbMwHvUuooe5WD77YQJp2cDhLEX0Rtgxd8iSdclsl
 WE9TFBSINj0yTQTf0cDLgxFxGTcRLsMXOdc3ZenXFAgEjzlmr/gKkAIjXB3SEHRzu7ACBBWIrTq
 3LejH/ViGcSBWIzr7rUyL6PpPEtgSjtnIlxpCd4t7JyzVRTnga18zCW5TIb8z2kR5yAr7V0c2fD
 ArSBcmuP/Di+DljVm+u5xBTbVqerYC95gmBzCXsW4m6324TkVDuY7m8NOtpjitj54UM0y5fM2xx
 gzbr72ntt85RKLjSwIz4f0SW2tQ=
X-Received: by 2002:a17:906:f595:b0:b9c:4fa:9141 with SMTP id
 a640c23a62f3a-bbff8dc777amr504343166b.9.1777897668308; Mon, 04 May 2026
 05:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114250.791663-1-ludwig.nussel@siemens.com>
 <20260429134142.1.20756bff4397b8b9e5cd57e4be96a99118b7c1ba@changeid>
In-Reply-To: <20260429134142.1.20756bff4397b8b9e5cd57e4be96a99118b7c1ba@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:27:32 -0600
X-Gm-Features: AVHnY4Las_gFJ31UH9ISuRHXoCcABMTvEMWZezZ0KZiZbk9lnNhBxCf3CXDK3RU
Message-ID: <CAFLszTisBeG-FsQLTCJEw9VOYsS0sQUV4bwAmaJ3BcGp3k5RjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] test: include mapmem.h explicitly
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-04-29T11:41:40, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> test: include mapmem.h explicitly
>
> The file uses map_to_sysmem() from mapmem.h but relies on implicit
> includes which may not work in all circumstances
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> test/boot/measurement.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
