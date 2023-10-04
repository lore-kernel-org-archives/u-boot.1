Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3256E8FDC3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4612087229;
	Wed,  4 Oct 2023 04:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fbIi/+Bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47FE86E63; Wed,  4 Oct 2023 04:11:20 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3AA58702C
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so95030366b.0
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385475; x=1696990275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CSEoyWA25pivq8uq8HzfaVWnVmEjdD9Bf6pYqtMv3dU=;
 b=fbIi/+BbXk72y7kFnbYPAOvPK93lNqsLql0HAfUayEcNLEexXneloQA2SsD2nMnVY0
 b94nV0RA6yeo1MCvnPedTmsUUFFU4VvIOPydCTeobPgO5H8i7bhDDQCYGNPl6IgNE8Kh
 hKLgDVDiydzNewfqgrESc7A84nS96cpep+BQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385475; x=1696990275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CSEoyWA25pivq8uq8HzfaVWnVmEjdD9Bf6pYqtMv3dU=;
 b=huNuGor2eFSOy9A8oE2Fe7hbm0JsSogY/ykukWpB8RvJ1J61gRyBSgIDdc5bPpZM2N
 Vfrk6gDJfdEam5oWJYcHabwtPZdcH6/Zcj/FYORAkiFggb4dt7pjbODsZ9ncXqmp1dUv
 8CRFgko/8vKrHTR6Ojp2KWL6dmOI0dN6U2KHD6Nl7U8oqefW/ildSX1emnhIdlDerpy0
 WE7C+AawZ2UdKQs4UE7ETNxCn0p/7G4M/b3hcicynK+Xit0CIvsgRUPUaFePc10KqL7u
 P6sKne5DC7pfiFZwa0SYmAa6W0BWKQ2fxLcxl5YGQL4/WsQ6KwScKS32p1VDR86m2i5m
 jRQg==
X-Gm-Message-State: AOJu0YwTFFoN96K7QPtkZ3PsRJk+UQOKY6X7e9WOEreyGCAgx/OJU7Jj
 7sv89m6y0euPJaQldPSfCelrO8Yp2OT8MIsnDvTSsitAe42INcLRbD4=
X-Google-Smtp-Source: AGHT+IEb1bsfuz3ZYq6kpk+nx6xRXHO3u7gx6bCUwM9Eyg3PSmQ6411JPfkEE+gQnvSFvT5z2UkfeR4PBAOE0LzQJB4=
X-Received: by 2002:a17:906:8a5b:b0:9ad:8a9e:23ee with SMTP id
 gx27-20020a1709068a5b00b009ad8a9e23eemr779184ejc.13.1696385475522; Tue, 03
 Oct 2023 19:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231003005946.97653-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231003005946.97653-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:11:01 -0600
Message-ID: <CAPnjgZ1G2nyXdKp7KLxvZeN1bQbCYGWae_mHb59sRRBU+M0smQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sandbox: fix spl_board_init
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Mon, 2 Oct 2023 at 19:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> sandbox_spl_defconfig with CONFIG_SPL_UNIT_TEST=n fails to build.
>
>     in function `spl_board_init':
>     arch/sandbox/cpu/spl.c:134:(.text.spl_board_init+0x4a):
>     undefined reference to `ut_run_list'
>
> Add the missing configuration check.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/sandbox/cpu/spl.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
