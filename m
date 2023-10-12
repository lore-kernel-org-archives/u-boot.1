Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A732CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D6E86EF2;
	Thu, 12 Oct 2023 05:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B/FgJTJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 956EE86E95; Thu, 12 Oct 2023 05:44:37 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD25086E77
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7ac4c3666so6821207b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tepgIczzaLcAauWcE8gSKHbwMCDhRsgM0t8/FHRSlBs=;
 b=B/FgJTJ6Ft7PN8vDsAbqpOabotiF4pISUH3gZhtPr73TxfQdiwwcCoW02XN+yeU9o4
 BEK3DvK1LpvVmiBgOCQdXE0hPqNR//GMyfnkMwz9AKDEndD3vhar5r4QFQ15oP8Ge3Oo
 gUd+fklWG9wfmLyBJAyx5WJDrwOtm4e+DHGuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tepgIczzaLcAauWcE8gSKHbwMCDhRsgM0t8/FHRSlBs=;
 b=Bg1d84nxPGPr4Q7QgcRKv71JmL7ruoQwPv+xFePpr6kHPSt0ooUr/u1v2/WNF7ley1
 LU6RAaOsJNNZRSdczjchcFwrIG03LeWoIAGQAJdGuedIa4KF4hNdhlJQPBGawE8k+DJe
 4dtNodABdIMVrfIyRSwH22/jXmR3QDmbWjuvOurUnFyvXSsQmegKl13W0z5FssdIYPsD
 pGd51VRcQMlVAtoIY/X2qY+uO+1K95zmQgchJepJ/7YsW96nZXqUshn1mKqVRkB611DF
 vacQboRf21RVM0PwKvf69jwNQfNWVQTkEJ3fxRNC9eaOqASODjiSe8DfUtc1U9XzOwXB
 kVlg==
X-Gm-Message-State: AOJu0YwEokgsynSw2UjDiqlW/UDoGQtGlbXfys5/KgExmpvMjiNYfOj1
 srdF0uXXE+U88TO7YJXIRH73TE+PUCLQsNJ78UdMiBymbtcHJ3d6lB8=
X-Google-Smtp-Source: AGHT+IGkBSHBWMUcLgyIykmJ2+UgeCPQnP9AP4nd6QjSZxs8S5yQMwBpkKBhbHP790x22jmnM3j5auJ8YWM7j8sxYCE=
X-Received: by 2002:a81:6d93:0:b0:59e:9fbc:a16c with SMTP id
 i141-20020a816d93000000b0059e9fbca16cmr24807196ywc.35.1697082263678; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-13-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-13-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:05 -0700
Message-ID: <CAPnjgZ02=mHqDX6abcv6bEVMfZyH7afL5zo2CGZnpV9J9Rf50g@mail.gmail.com>
Subject: Re: [PATCH 12/26] fs: Compile in sandbox filesystem in SPL if it is
 enabled
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> fs.c thinks that the sandbox filesystem is available if SANDBOX is enabled,
> but it is not in SPL. Compile it in SPL to avoid linker errors.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  fs/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
