Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084C3C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 17:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F97830D9;
	Thu, 29 May 2025 19:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p50SXap5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D279482B34; Thu, 29 May 2025 19:55:07 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEEB82B27
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 19:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6021e3daeabso607688eaf.3
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748541304; x=1749146104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3CzKw6wrn4A4NUuqsZPdLVREMFrN0l6H410F8GTWnYE=;
 b=p50SXap5nVJXiHn71jKYxTBb+S7wV5Dr+r7GqlITZ9Sj7etMB5NKINtdB4l8kbz32u
 OVx/OelmWLWyL4xL/E7MZOXy+6fknbPeXI+DKWmpdlS4yMqn/dYP2s6lcWI76QIJkUZU
 ljutR4ruNusQ+t2eqbJcPq7BFV7O7KogsCD8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541304; x=1749146104;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CzKw6wrn4A4NUuqsZPdLVREMFrN0l6H410F8GTWnYE=;
 b=V8FkwFxOj18vetGg1hifb6X4pn9lbrPSu8+FS4dJgx24HBNUtcXQYW06I7I2xTs4WL
 Zu9OBo3rCpIPIT69+HZlIlLv6C5IbnS5g83CIZXBkTXM1R8frYWWvkxg1Rn/U4dJZha2
 kzlTuiEKLwtWAVjLmYclJr4FMCiWi+vZP1f4c7W9Jx4lVFnvycQKZllWdwiUfdRCUfmb
 2Pv2hwSQL6vR3FjgNZVrPHYrf8O21ygRcxVVtb2rAAUPOMZOXTj/e3QqCmdZk37tWrsk
 MieTqzxdfkk07gQ/l3GNxT4i5/vKDjdxDOyLQKI/Qr3gukbQB8DpIe6VF9pJ5uCD3mQC
 j0Tg==
X-Gm-Message-State: AOJu0YyjXmmUVCe2LcsvGzIh6eYH5bHqiY5Tl3Q5EDrJPSsOpxKRu73M
 zgVZGzGn3vNcjyMwmKU83M0pSsMcgPYL81EYNFGp8WdrxrwW+DSbSJqw+Qv9LRx6a5B3AUEDZqe
 vF1raIqs=
X-Gm-Gg: ASbGncuo+iyz5Z3K+7VjG9YHP833AAR1H6lZmBVoFiryjsm97oez1you8tn6nUmWajX
 HozO0zSZq6/WPXBzQMawmQ5kIpUw6IF3KsTHXhX9F1E/aZCEb4hLVoiHCTKJp5b7I7HfHi0sfH/
 TuaVfuhH7Y/9qIW7v9plqQ717Rg/PLBIBdtfFzCYEWRNLckmuHL80WmtC/2XUKE8LX2Wh58VzqV
 EjfjT5XJ0SlCXHxfN9IBEMZRbKZ85Q9OraUbPlgOSSMaTPo5PYeOQGl+fXFzg7uSXm9589xiD/N
 v/DZq0/pZplwqxYXMBWAUNcARseT/Jq3BWJZ2Mt1mWjo4nARK1Wyya3dm64tPGWaKOJ56RQfNv2
 5jinqliUZPKQ=
X-Google-Smtp-Source: AGHT+IHwFOZd3LMwanMn3z0rnZggYbBr1ViOFB0QqLZDV+uZ31sj8Tw/FCOhSkgbQA7XRput4jKeuQ==
X-Received: by 2002:a05:6820:270f:b0:60b:d692:7c53 with SMTP id
 006d021491bc7-60c4d747a4cmr364311eaf.8.1748541304345; 
 Thu, 29 May 2025 10:55:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c42c16sm77455eaf.7.2025.05.29.10.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:55:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
Subject: Re: [PATCH v3 00/22] Remove <env.h> from <net.h>
Message-Id: <174854130310.3917659.4392131075268669372.b4-ty@konsulko.com>
Date: Thu, 29 May 2025 11:55:03 -0600
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

On Thu, 15 May 2025 17:31:29 -0600, Tom Rini wrote:

> Hey all,
> 
> This is a v3 of Simon's series[1] and depends on the series[2] I posted
> the other day that removes <env.h> from <command.h>. With this series
> done, I believe we've tackled all of the current cases of headers which
> include <env.h> without directly needing it. Much of this series is in
> fact Simon's v2 with the main differneces being:
> - Removing <env.h> from <net.h> at the end
> - Removing env_to_ip() given how little it's used rather than shuffling
>   around where it's declared and un-inline'ing it. For a rarely used
>   helper, this ends up being cleaner I think. Especially looking at some
>   of the users (which called env_get repeatedly). If there's strong
>   opinion here about using the other method[3] we can do that instead.
> - Setting aside for now how to handle CMD_ELF=y and NO_NET=y because
>   today it's actually fine as we unconditionally build lib/net_utils.c
>   where string_to_ip() is defined. I'm unsure if a further series is
>   warranted here or not. We rely on link-time optimization to keep code
>   readable too.
> 
> [...]

Applied to u-boot/next, thanks!

[01/22] net: Remove env_get_ip helper() function
        commit: 05f6f6e8c76c68a36125ec7a6af911ee9418bc99
[02/22] congatec: Include env.h to permit reading the environment
        commit: 67a7633e04d71c61018d857f27d18e05acc5b844
[03/22] dhelectronics: Include env.h to permit reading the environment
        commit: 09c9957e8808b6a3513450c802d43c9410a14368
[04/22] imx8ulp_evk: Include env.h to permit reading the environment
        commit: 84a1c99055166857efabe55277f01341404e8dda
[05/22] net: Include string.h in net-legacy.h
        commit: 0b9450989c195430521b01d97ba79a9b644119a6
[06/22] venice: Include env.h to permit reading the environment
        commit: 600145a8e10418d26f43045f9452610e39ce6f38
[07/22] phytec: Include env.h to permit reading the environment
        commit: b4135116116a318113968ce9f8f72c711d09dd28
[08/22] ronetix: Include env.h to permit reading the environment
        commit: 6e898e332b0e7e11ebeb83bdbfcd9e3e1600817a
[09/22] toradex: Include env.h to permit reading the environment
        commit: bcf10f16ea41cd690be59a88d8e7292881d01e56
[10/22] advantech: Include env.h in imx8qm_dmsse20_a1
        commit: 0f8a4a9c4427370c5f20b8ffcbd615fb9658921e
[11/22] tegra: Include env.h to permit reading the environment
        commit: 433e86abea7e8b570ee0ad89842ac806511d1b94
[12/22] synology: Include env.h to permit reading the environment
        commit: f24a197973ad0c5f473401b16a801794f2764678
[13/22] amlogic: Include env.h to permit reading the environment
        commit: 6d9d6ba71ab9391e5fb163634bfb1cc65987cdd4
[14/22] freescale: Include env.h to permit reading the environment
        commit: 2876ff79b257667438ae7a6132d5ce750ec501ac
[15/22] google: Include env.h to permit reading the environment
        commit: 98faae1617b44e53c475adf8552245691e1f05fb
[16/22] liebherr: Include env.h to permit reading the environment
        commit: ea9afef22d49a4ac12484e01fd459e225da790b7
[17/22] technexion: Include env.h to permit reading the environment
        commit: 7b612cfa757a44d1bdee6d087e24e2e5c9d8a868
[18/22] net: Include byteorder in net6.h
        commit: 22d4e22a3d2e8a95c37c0635701daaee8d5a5c6b
[19/22] net: Include env.h in pcap.c
        commit: 85b013e3f43ff4fa50ced6a23ba336813eaf9320
[20/22] net: dc2114x: Include env.h to permit reading the environment
        commit: 183d88cdfc19ea7bd56af69512f0d1425de73e77
[21/22] global: Avoid indirect inclusion of <env.h> from <net.h>
        commit: ae9ff5ae6f579f321a1b695c82453b67ec1bf6db
[22/22] include/net.h: Drop <env.h>
        commit: fe33175c073fe21945b39a4a8c27806cf0154bf3
-- 
Tom


