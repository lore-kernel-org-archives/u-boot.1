Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D206FE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41ED0871DA;
	Mon,  2 Oct 2023 03:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="drsCNYKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73950871CA; Mon,  2 Oct 2023 03:22:10 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543A6870F7
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso2173300866b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209724; x=1696814524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x0R3GF1YitnQcQkXLwW31brTe0F0KFkLfBg/7Jek1kk=;
 b=drsCNYKTdVR4Ga9fE6MOVyfOug8ceqicF+Ug5Og1bKzn71KhZUCa2XNaDKuPqX9wtC
 M3g/Q4/dynTDyAPsA3CT5TuUyn5sbh42EHzvGl56g/k1EFmbQniB91eBzGCE7N/sRpK3
 mZFlN31wx7TRZVlsxHj+fhzNVk0+Z2fomYzlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209724; x=1696814524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x0R3GF1YitnQcQkXLwW31brTe0F0KFkLfBg/7Jek1kk=;
 b=BgjfCK1zjMwLGezkLyd8mW79CJT/ByMxPWhdt0brjIgwnRrv2YsnN5S6Ap9VFqn9Zh
 F8hmVQ8hMsabcP0+ib0EZFpElWF1Q03fgjQwSu70cObran1Sx1NZngjjVHhm+YpueHkk
 UYG0fRi9pduY8beb4jgX1zV/sVcGzaPgxUqPSnjcjIz81dsszy8YERF571KJpRZmvlhi
 /D2wbvuOeMMY+aN+134hrG/lBepXGIwz1ceb7LAAmzM/IJJ0strlQNfHq6ahEPBIk4xM
 0RqiC90ECLN763piW0n0ji0JKnVWJtSXVCn8VSnk6n+lcJZwFoEUitaZI6KNZTrpUNex
 Rlcw==
X-Gm-Message-State: AOJu0YzcutHCCYBn3HqtletWbBf7UeC38bSSn1uoroVW5RgCT4H/Gyqq
 Rrhj1qqAECGaNszc9QL1OkwsQ4UxhlUuLQ2zq8VGqg==
X-Google-Smtp-Source: AGHT+IEWlaLwzLtu6u8mcE/DNS2ERYcijP0cjKK+D6QZF4LhfF2M/4CITJKLJsRueahs5sfCeHHcH1q4TcE8sFqQiqQ=
X-Received: by 2002:a17:906:214:b0:9ae:5fe1:eeff with SMTP id
 20-20020a170906021400b009ae5fe1eeffmr9366440ejd.71.1696209723711; Sun, 01 Oct
 2023 18:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-14-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-14-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:35 -0600
Message-ID: <CAPnjgZ1PLcCJ1sQW5830TXngwvmKmBs9WoBOAURGz7srFuVk-A@mail.gmail.com>
Subject: Re: [PATCH 13/15] dm: blk: Drop blk_{read,write}_devnum()
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, 26 Sept 2023 at 04:09, Bin Meng <bmeng@tinylab.org> wrote:
>
> blk_{read,write}_devnum() are no longer used by anywhere in the
> source tree. Drop them.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/block/blk-uclass.c | 29 -----------------------------
>  include/blk.h              | 26 --------------------------
>  2 files changed, 55 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
