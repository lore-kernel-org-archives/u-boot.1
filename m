Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBA8C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 13:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295A2820DE;
	Thu,  3 Apr 2025 15:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pl0amCZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CDD8820DE; Thu,  3 Apr 2025 15:30:03 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB3682054
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 15:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-601ad30bc0cso1156602eaf.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743686999; x=1744291799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6O43nolVoIUj5Epk1BGNLsQD5dUAyhi/IhTVpeZv2ho=;
 b=pl0amCZKjcBGeUXEUEkXTN2CDKnfAmECaW2YRxOxKIJf3kzdDI9Yq11nuuFIzAYqUl
 K8BrwnvlhV32f47J1Y0Akvf9MayYmxs4ec6MbBN70FC7BKqKlA2L1ecBYX37MW3aJWY4
 NsKS8JnUwfLZlSEo0a620onZYu9BczjGBC0rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743686999; x=1744291799;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6O43nolVoIUj5Epk1BGNLsQD5dUAyhi/IhTVpeZv2ho=;
 b=rKtLh3DAe/pDpBHJxlajYEu9CA3AsGiusbtGw4WKt2r941fMcQocGN/PolLCu8IUrz
 mPPKiMtBQBIvo8oISNPUgejiqGPK5pwg+n6euNukemCTaRMgNciVxZo87FMDmO961hFA
 i5tA6mzPJpCnFiLSPqzgGDAyaGr1jgAQi5+zFmrbhJK/Tc56M7T7STSUZnT3464SB9Xl
 gGm9JHYhmLEzU0mKifeTL4Jm+BSMTBmpiWs25nIuxL5j5V+WmDbqDhMMyXvsRlGmDchu
 EjDRYDaTjzDd5flwfXc+/4ZwX8LeSbfWzHifsrb+7JGbMwkLfd2Zhs+tYmZbhiCWCw18
 0QzA==
X-Gm-Message-State: AOJu0YxpjBAzT/KYcO1k78G9X3MIAeIhj5Hsu29QEdN2CIQ2CY6xUVDT
 4HN4kpgdmUXGrj6THz/4W5+eAlDOhCWHaCZw1k7wiZnwRQe5+XWNdms2QBSuzcl5h+f0+gmu8Yr
 0
X-Gm-Gg: ASbGncubI6ACLAgrD+jm+WdEVRdAqzNUf7HO1pEOIsV3+ElToWwgJnKMOQHMXIyzQrA
 7hucq5Zk2ZeEwq7sr8yfSGDgo3wSMmTG08I5R2mYj9KiC9emsjYKrnIYEacgfqzv7gSgXbL/f3Q
 WLcLITm7EJeIzz+iB2eh9AnxMZlU6zajH+reOsreO5TrU4oBjdguVZDH8Xf3MwnzqX8TNxzbxiK
 KNPbSlrC1v0XA3FzgvKu7LA1aAyJP2UUsthumsPHt5ZwBVFyBUcc2Jn25CuprtJd4LYpOA9rXy1
 LHcJhIRsT9PQdNHeRELwgQHB551UJZUAlE9uiw1ujhMoH+9c1BKES/KS6SwTltiGLAiKnqBZv6N
 Dd2WX
X-Google-Smtp-Source: AGHT+IHHjFQeP4nV95TeFHTwiX4VeAV9mr2LYAEE4TtfjDLPiCZzNo+dZO4pTM2js/EoEodh0SP+oA==
X-Received: by 2002:a05:6870:3b17:b0:2a7:8b78:e902 with SMTP id
 586e51a60fabf-2cc7a645baamr1950143fac.7.1743686999260; 
 Thu, 03 Apr 2025 06:29:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc8454682fsm251260fac.5.2025.04.03.06.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 06:29:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Baruch Siach <baruch@tkos.co.il>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hiago De Franco <hiago.franco@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20250317031418.223019-1-marex@denx.de>
References: <20250317031418.223019-1-marex@denx.de>
Subject: Re: [PATCH v3 00/11] fs: exfat: Add exfat port based on exfat-fuse
Message-Id: <174368699767.1441234.13274947427515474012.b4-ty@konsulko.com>
Date: Thu, 03 Apr 2025 07:29:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 17 Mar 2025 04:12:39 +0100, Marek Vasut wrote:

> Import exfat-fuse libexfat, add U-Boot filesystem layer porting glue
> code and wire exfat support into generic filesystem support code. This
> adds exfat support to U-Boot.
> 
> Fill in generic filesystem interface for mkdir and rm commands.
> Make filesystem tests test the generic interface as well as exfat,
> to make sure this code does not fall apart.
> 
> [...]

Applied to u-boot/next, thanks!

[01/11] cmd: fs: Add generic mkdir implementation
        commit: 52227015c54c1177d0b29fd2857201ecf99a4f65
[02/11] cmd: fs: Add generic rm implementation
        commit: fa4c9826e222136b9257247bbbb64408437d1906
[03/11] test_fs: Allow testing FS_GENERIC
        commit: 6592425c6d7e4e010f3de88bc8ced7163e4f12e2
[04/11] linux: Add generic struct stat {}
        commit: be96ac51ec68fe669c33b1d0ffe5c1aed06afebe
[05/11] fs: Add generic fs_devread() implementation
        commit: 9e0e0ff2601d76b0f9b6fed40c55967b1256c427
[06/11] fs: exfat: Import libexfat from fuse-exfat
        commit: 88c1acd3579aa2ccc7d5c2cdd5f9a48e74ec7e8e
[07/11] fs: exfat: Add U-Boot porting layer
        commit: b86a651b646c0c676ab2746344edb2d7e5d81e98
[08/11] fs: exfat: Fix conversion overflow errors
        commit: 74eb84686f9600d5aeed001f913c1e8c91b1a4ca
[09/11] fs: exfat: Demote filesystem detection failure message to debug()
        commit: 2375f713a219f03c36a0deb0bac90f0b2c2d2162
[10/11] configs: sandbox: Enable exfat support
        commit: 99b976712b70ec6ddef239f4a00142fb014b0c77
[11/11] test_fs: Add exfat tests
        commit: 8d0cc62a60b5b92a010f75fd61d9eb9cb8299567
-- 
Tom


