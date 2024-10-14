Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B45D1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D65D8918F;
	Mon, 14 Oct 2024 17:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NX6Tk9yR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0C58915B; Mon, 14 Oct 2024 17:51:02 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756D48918E
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e291f1d659aso2457614276.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921056; x=1729525856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v4uw47FISFjd4OvOESpKsAT491nHBFcqp30jeMURD60=;
 b=NX6Tk9yRtSrQA8eNnECnAf00Oy/eEjGMpNcVw1sQa9R1/LQTS4a1iKMTRZvLUKm2H0
 2pwgREdMjmCcIgHWSSL44+UHoZeI1tWzhm2r4fyEVf2V2InQqCGTig52K5Sgas8cVVwV
 suurrGMNKEUwnHe0KPpwRnL+QeCCU6C9h3kRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921056; x=1729525856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4uw47FISFjd4OvOESpKsAT491nHBFcqp30jeMURD60=;
 b=rbgfJN+Ry24XjOhGWUFKOQuTpK6mj/2rVcUUzdUtCutyi8qKFMKnzp+yNceHi8Za72
 sdjSG16kj/v3VoLaW0Z/hfgTM46hiMg8jnLEN5rZcbbRFadsvt1bTgNPKfVlytM1jskY
 u7r5ukb9GhlQjEhLka8kTieiY3RwwyQwFqWId8Ot4pHRsBM0tBNPlQNLmXygmcw6yAdu
 jVMqQxlpPqQF8dy9WdiVRZBfoVE6C3Uc77k3YrXls22QGUCBc7D3822d6QmjOk/2FCf7
 mXvVjAqBJppbiCGldAOiVb/r69J4kEaw9oUplhcShVu5Z0wI3ThMv2krYCiaU4qXwG4d
 5JdA==
X-Gm-Message-State: AOJu0YxxLsjpkWR5OGzDJcTYg6Yu/GMCidPXv0vp50y9EJ5z68wMlTXD
 4l1hRm/2VMMr7K2aALjDD9ACmn4ZLJRRomofXWg6naO2FnRj/+ChbpekNSI4J0m2XgghAmoAj+3
 sm8qYrimGt/0a1/ld97PHSEYeQjGcH/nII9koWK6zfIrbwRI=
X-Google-Smtp-Source: AGHT+IH1B39gfmFC4DNwOM2AMDHsDvPkZ7HfxNHMz58pzPbnIvjqRz5BwZUxHr9fkxCfGOW/TmmI4Q9nRWUhH+vhEr8=
X-Received: by 2002:a05:690c:6189:b0:6e3:1b52:d8d1 with SMTP id
 00721157ae682-6e364349ddcmr61403007b3.24.1728921056631; Mon, 14 Oct 2024
 08:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-9-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-9-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:45 -0600
Message-ID: <CAFLszTh09=GPY66eT4neeUtd7wxy7zMeUmq_-Ncwh2Cs_qsDPg@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] ti: k3: remove efi_add_known_memory() function
 definition
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The efi_add_known_memory() function for the TI K3 platforms is adding
> the EFI_CONVENTIONAL_MEMORY type. This memory is now being handled
> through the LMB module -- the lmb_add_memory() adds this memory to the
> memory map. Remove the definition of the now superfluous
> efi_add_known_memory() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V2: None
>
>  arch/arm/mach-k3/common.c | 11 -----------
>  1 file changed, 11 deletions(-)

I agree we should not have these calls sprinkled throughout U-Boot. In
fact let's make efi_add_memory_map() static at some point!

Reviewed-by: Simon Glass <sjg@chromium.org>
