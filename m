Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C5CCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2102484DC5;
	Fri,  8 May 2026 19:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TJnLbecO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBC184DCA; Fri,  8 May 2026 19:56:04 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59DD284DC4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1000772a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778262960; cv=none;
 d=google.com; s=arc-20240605;
 b=KQBV5NKljAGgA6BFoFuEk7fEjv9VuA3Jpjsi1KD/m8gHTeGl4942YS+J/QwZCw92R8
 KdIDB2+dhYGsVchBV3de4AXBQOBTbdkkrSeDEw0Bqh4OhjG43trfhEe2XIb0CQQAhVvQ
 YEA7KqzSQsdvz8UyNf2TKrNVndqkd5P9wals0MeOaCXeeNOuCaBSS6tHRdKd8EZPxSHU
 3UPBw4+5puIGwHL/SskrnilmRncfjdiIdMUL4MdllC66cB3DH8HrC7DBIVJitxjQ+VuB
 9luH9V8fPX9NNuvdT8KQd/SPiXO0V1Eaw/dDJ319VyXfok7FvSEzguvMMDAYinAcVgfO
 A7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+Fo5RJskm0HH+jZ8Z+Duv1EiX7H+1IYQEFxceuQEUv0=;
 fh=/NS05QKCvzVUGVRPCX4PirYPzzh0e/X4lz3IkwNJRCU=;
 b=XbKMEpq0SH95c0VowoKb/o+9yctVjrEVzNV3icV0QHIlRcC6c+ACLlLTzmmXkd4WxA
 UMHcKfL1LWn/NDbZsyb/vid8KG3MDfZr1eUSThuU2RU25zv5yWQOZarkcXLkLTstJ9e/
 6iVcRjfyEaLIzHrOH+g+k3tUcypvq6vG7W584VkhlqLsPUMCd/aRbgDpIPh6OCfLOR4P
 MAG8E4oz59tN2S4vsJZLUXzsPv9iUh2Sdbx9/7rBxi54Wy50jOsNsS+H30+TWaQC/rOQ
 1wucXQTJPn30rgvmZ6j/zeLnW8lQqNNqbH9kwkQcFvPAgInN0Y1Hai4v+5rVQfOO05PZ
 P5iA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778262960; x=1778867760; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Fo5RJskm0HH+jZ8Z+Duv1EiX7H+1IYQEFxceuQEUv0=;
 b=TJnLbecOGHHpqpftG3k4VKMPr9Zb1JPeIC2d4a1L7wCAz+GPJ0/pv7xps3mg4wgm7h
 gJQI9UdsBSqMDwMewPEaUshzg73pSwqMYu4V/e5+l/p/kJL6yO1eOBhk7nVUoPEmbsHs
 dbUdrtB4NQk+JUmmXxnT0UUCXAJ2kCgWVHulY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262960; x=1778867760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Fo5RJskm0HH+jZ8Z+Duv1EiX7H+1IYQEFxceuQEUv0=;
 b=LuanUrBgA/gsXTomw3oZxretjeEUcJriE6fawvn8M2RSgHbEyw9iNxL218VFgLbn5a
 ou95vRVyROl1pu6kWiCu4pAuOF49ClFwpBX19dYFzxD+23Fri5qkjFSmzD5V75w6Bobt
 UXCVX5UlsTCIwueIPqzFKdV8pCIl20zSDeROaXiQ2Ynx2BgStKlxQTt/PAXyexeVdHJf
 jrm0DlxgQFuInW7eEhAON01YE0W4jH3e9UfdE326Br84KLWb3MnPhokIZBlU5zFb4Nbj
 egh+7Z+GXCi3pALpY6oaqKa68JD8K9PVkyH880A2q6dzUAIePzvl6nlQKHMM5GLhGWo9
 FCFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MHPwtatC41M/zL3Ch914yT5Xd5olNSu2FqYPx2fq83FKEkftmUAXz2ywYWnCe0fSFGLof7cE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzges8r/h4obkaOXOrTamJImzgzQQnY/2siGY/zuf5QRpZE9tpO
 +l91I5MKK4C80APMAnb0JvUdBDsz2KKN46OOEFGzaaKgbz93oyAHJ9yTPqiH5Cv/Y4T4A4lcEEC
 15WSJB9PRILu24oV2G9xJY3r3FIEVI/EdCBVFQcaf
X-Gm-Gg: AeBDieu1QyqlyL7xqMpkM5gDFb5WSO+UmZqhoRRSysMRKP69U5imf/SeJ152RExS5iO
 bfERf8f3CBAjA4qk+4TmdWfUf+rgGNkTw79SgAEhVBZheG0gYAVUH4uuSthovuRzOuSlp/gOoLY
 DjMGYvUcw4l/QHROut4/q2NBzvYgG8kiG/VoEASxinJBGqA+znYifsxitOnZfareqgY6wqfbzq5
 X/Jk92pmEeGmPEjIZgwzrhP8UEda7d4RSBD2atxW0/b4hvl8cEOjBOSlQrgL2ej+ITFqDhULMV9
 /NTnWA==
X-Received: by 2002:a05:6a20:2587:b0:398:8204:8d83 with SMTP id
 adf61e73a8af0-3aa5a458797mr14711845637.5.1778262960246; Fri, 08 May 2026
 10:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-2-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-2-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 11:55:40 -0600
X-Gm-Features: AVHnY4KINf5l5PACOTbK0XBTaoisMpOHskEvYdsdWyOmsuxmw0PRkNxC_14rDyo
Message-ID: <CAFLszThYgiarRTxZ_h58Nmk1uFDkUWJw0hk_yPqGsBuQ=_9EFQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] sysinfo: uclass: use sysinfo_priv size for
 per_device_auto
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
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

On 2026-05-08T08:48:28, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: uclass: use sysinfo_priv size for per_device_auto
>
> Reference the struct itself for the size as it is more robust,
> even if it contains just a bool at the moment.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> drivers/sysinfo/sysinfo-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
