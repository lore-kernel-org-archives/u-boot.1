Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81E0CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B012689050;
	Wed,  9 Oct 2024 03:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HEX+1/dN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D92589050; Wed,  9 Oct 2024 03:52:38 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D3289051
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e029efecdso2405983b3a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438754; x=1729043554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JWbpDB3skCs57SErP1Yl6fF9Pbp9QqrsLiqGJF99D84=;
 b=HEX+1/dNGbj39nYfVmMWRTYJ8FINTySIWhbo1jj6AntfvD1Oc7JdgNLQunT2vxaq4F
 gVRjJtR4odHt8lXEtsLhRO3szGUWv85kFgtOJpGuHkHRHWXwGE3pc262xUMhy1Dim4zs
 qdomo9TQHwBBQZYpt1IBCPSOxYa4/JRMlJbOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438754; x=1729043554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWbpDB3skCs57SErP1Yl6fF9Pbp9QqrsLiqGJF99D84=;
 b=Isp1hpCtTK0u0q47fdsxVWwgJ7LUa+iN5AZ99U3X+OV2cOSNzZNN3W0M7z4BlWzWJs
 1+RXGSYaYG0yPFOQb7JYsPisEPNfV2DA2krj84QPvUSZxd4ht8V8IncrnK/nsUGqgRds
 q7QRsSl1gh0jOXJrJlKlDMDLZaAItnuhJ7gNuQiOnEcUPewXnB3uxFS++KUUOXfVAccl
 uojM2S07cBTvu79Oc/hfcoQfVrMb8VWPp3FUaG/i/w/+aHpkGqCaJbl4WEJ/HhYY7j0q
 2SgAK7PgJ91mcxtWE42suhYVy2chw15wz7r/awDwtEYivxxUCSL/NhZZ7OaPa240sp+Q
 bmjg==
X-Gm-Message-State: AOJu0YxtRFRkYpDBCwaq2i3cbEcv/tg5yuT29VrBJZSttCIcogRdlLjY
 qD9oskMO3H8RHJGmNtHLXSkG8Sc01tGHF7dCsf2/n6FzLq1LfrW4kmE7ZePeOgUZ5W4YP3SBC49
 ac0G+IdEHo1PbDiffaJWkhrKsQZx9i/Ce83GC
X-Google-Smtp-Source: AGHT+IGuAZTQVqvqaYqyXQ0SfO+FadIlpQD0No51XwJfnzF/23ZRf1wrwjoz7/38rRu2wdfKCErO0/MFl9xc8W5iMvQ=
X-Received: by 2002:a05:6a00:198b:b0:71e:135a:ae5d with SMTP id
 d2e1a72fcca58-71e1db7555emr1272845b3a.10.1728438754292; Tue, 08 Oct 2024
 18:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-13-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-13-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:49 -0600
Message-ID: <CAFLszThTeCffi1HoiSQtvjOvNTYo0yf7ZyzV1txAyzUTt9D4OA@mail.gmail.com>
Subject: Re: [PATCH 12/13] boot: cedit: include u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
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

On Thu, 3 Oct 2024 at 15:30, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> This TU currently relies on getting a declaration of schedule()
> through some nested include. Include the proper header directly.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  boot/cedit.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>



> diff --git a/boot/cedit.c b/boot/cedit.c
> index c29a2be14ce..ff0efda3a7b 100644
> --- a/boot/cedit.c
> +++ b/boot/cedit.c
> @@ -20,6 +20,7 @@
>  #include <video.h>
>  #include <linux/delay.h>
>  #include "scene_internal.h"
> +#include <u-boot/schedule.h>
>
>  enum {
>         CMOS_MAX_BITS   = 2048,
> --
> 2.46.2
>
