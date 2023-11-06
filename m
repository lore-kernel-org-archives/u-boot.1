Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F08C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D68886F9F;
	Mon,  6 Nov 2023 12:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGZqzFcY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB33F86FB7; Mon,  6 Nov 2023 12:46:35 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1120586F68
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-543923af573so7484361a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699271193; x=1699875993; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GEWZJZXXrRKYBYdYQCeLPmGSook+GgNz4YF2RCiGRjA=;
 b=MGZqzFcY7rcmaGoYbSJr9JTNC5k3QIYdTPlxqg97QxhSz+dYxL44jWNtbzjBfwu0Uv
 k5oCpZxTKVbn5eHwFB2ARAfS+lWYBbxydS0buPpM7pRPjP3Heh+VFOrWAT0OUhbpvset
 vpbDNYSn1vWzXeI3vKG8CRB3ordmQ4fP27pQqXrQoAVyepU3aLNkeIBNc+nna8HOkBZt
 JQ8cPo/Andq24+HcJ/vsVA4mW1F3wxVdOZ1aF8aL0NhCsAzRVgBcWISQNTgwNJYQWxSk
 caLCtwtVzP8CxQ7O3utd+Av2iouKKOi6popiOkHzo+7CtdSS1CpzBsI+Lz3KnTm1Z4fG
 PRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271193; x=1699875993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEWZJZXXrRKYBYdYQCeLPmGSook+GgNz4YF2RCiGRjA=;
 b=I/PFnyDepZi+LLWHlYvvdto1ZoiDww/5454GzucGlFB4r/7uwiDt2hxx7U8+Q+dql5
 79PzfA1x3a9T8mRGDlrMfERTxKysPmKx2axQ1IAsTZlUFtKxPPKbcgdiuKmoc+6HKFeV
 FyTYYxZn3NtXuPGfw+V86lnW004nekn+LQxTt8n+C1IuF66KO1y19vLzvFTSmd5NGpGc
 98d0SSudZkH1fX2BpDLXdaYYXmD5n6doFsq/ITc1+ikMG2CaQFNVoGuXwb1YXVrU3PMK
 TzRwgVqcju7uy/jWbQ1VcafjXl8u4o0wXwna9pkVUa94Qq4MpNgfIKohx83ceuqP4RyE
 pWnA==
X-Gm-Message-State: AOJu0Yzpiq/ZngTRJfp6xi7Q+IVh1ZqAsrJIz6yL8+FuQ1Vv6hE8UuAb
 0HA0y+iXelfsOWHhoc8ZKz7AHbyUvJXMCRb+gYo=
X-Google-Smtp-Source: AGHT+IHJc9frpgFdX2q4RJMymNxT8i68N40wF6RVQORmSql+MzFdbxtCOGyB+CJsLinnrzf2iYva9gjQx/bVDhYzYWA=
X-Received: by 2002:a50:d696:0:b0:543:5f3:c92 with SMTP id
 r22-20020a50d696000000b0054305f30c92mr18855825edi.36.1699271193500; 
 Mon, 06 Nov 2023 03:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20231106083229.256322-1-clamor95@gmail.com>
In-Reply-To: <20231106083229.256322-1-clamor95@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 6 Nov 2023 11:46:22 +0000
Message-ID: <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

> Since the proposed PMIC patches have been accepted, I see the need
> to convert boards which I maintain to use DM drivers instead of board hacks.
>
> Svyatoslav Ryhel (5):
>   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
>   board: endeavoru: convert HTC One X to use DM PMIC

Is there a reason why the two above devices don't appear to have their
.dts files in the upstream kernel?

>   board: transformer-t30: convert ASUS Transformers to use DM PMIC
>   board: grouper: convert ASUS Google Nexus 7 (2012) to use DM PMIC
>   ARM: dts: tegra30: enable USB PHY node on some devices
>
>  arch/arm/dts/tegra30-asus-grouper-common.dtsi |   7 +
>  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
>  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
>  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
>  arch/arm/dts/tegra30-asus-p1801-t.dts         |  17 ++
>  arch/arm/dts/tegra30-asus-tf600t.dts          |  15 ++
>  arch/arm/dts/tegra30-asus-transformer.dtsi    |   9 +
>  arch/arm/dts/tegra30-htc-endeavoru.dts        |   8 +
>  arch/arm/dts/tegra30-lg-x3.dtsi               |   9 +
>  board/asus/grouper/Kconfig                    |   8 -
>  board/asus/grouper/Makefile                   |   4 +-
>  .../asus/grouper/configs/grouper_E1565.config |   6 +-
>  .../asus/grouper/configs/grouper_PM269.config |   6 +-
>  board/asus/grouper/configs/tilapia.config     |   6 +-
>  board/asus/grouper/grouper-spl-max.c          |   2 +-
>  board/asus/grouper/grouper-spl-ti.c           |   2 +-
>  board/asus/grouper/grouper.c                  | 154 +-----------------
>  board/asus/transformer-t30/Kconfig            |  10 --
>  .../transformer-t30/configs/tf600t.config     |   2 +-
>  .../transformer-t30/transformer-t30-spl.c     |   2 +-
>  board/asus/transformer-t30/transformer-t30.c  | 121 +-------------
>  board/htc/endeavoru/endeavoru-spl.c           |   2 +-
>  board/htc/endeavoru/endeavoru.c               |  72 +-------
>  board/lg/x3-t30/x3-t30-spl.c                  |   2 +-
>  board/lg/x3-t30/x3-t30.c                      |  97 +----------
>  configs/endeavoru_defconfig                   |   4 +
>  configs/grouper_common_defconfig              |   1 +
>  configs/transformer_t30_defconfig             |   5 +
>  configs/x3_t30_defconfig                      |   4 +
>  29 files changed, 128 insertions(+), 450 deletions(-)
>
> --
> 2.40.1
>
