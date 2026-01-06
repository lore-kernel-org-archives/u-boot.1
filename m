Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B134CEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 23:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B05B83C62;
	Wed,  7 Jan 2026 00:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jc2lM1z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F313784005; Wed,  7 Jan 2026 00:17:24 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77DF83B03
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 00:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3ed15120e55so1030454fac.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767741441; x=1768346241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utHM551UmGZaWY7icYtkMpl/oMpJatuGk1MgVO+2lyA=;
 b=jc2lM1z8VJR5R/fxERdCPm0/xn7+6miU9w55EPLPn6HvaryVKsgmdjmarUYIiXts/c
 o/Iz1cVbIdkf82HMusOwcp+heqRkdiV7UI9hNIE4anSoXM+QPuuIzb5vfyJHa3wzVAZH
 lSSanN4X3GL0khA56MK4veQxd1Jm5MRHywNQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767741441; x=1768346241;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=utHM551UmGZaWY7icYtkMpl/oMpJatuGk1MgVO+2lyA=;
 b=qe64HVyddYU/AjwUZrsdgRHeoKU2PIKM4SbYNCae7wtMjmqrt4a0fKwfniTQa2ElAt
 08amOQhA/10OujPW+QPgP0+nyxXFFN7z0se9RdWhKAbroonwaXwUEzon1wDhGGJHTaGw
 fCVlOmYo9k6HWynfW3whntA6THEkM0ObKQ9E1KiKpNK4lNbuctG7rnsvIjmKl9+ZSASc
 NsMsDRXGsgniOu3tW/KlIT7469GfGYl2lw5XH1iB9d3a6ol9QkC5nS1TMWUsf7Uwifwr
 uxcqIIrFKa1fXVKO0kpuYApdlJ6etR8RcBBijfNuPY3idveG3hAl0Pvuqr90rzZhThpn
 r5aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2+eFkz4T34CCRqgQ8GVzNCIv8zDxsc8TB/vcIwlhMDywBu1/bzQ0ktDLUF2jfuTzGqmLYI/4=@lists.denx.de
X-Gm-Message-State: AOJu0YyaFmVDOV2lNBTqnbzt9mqArHoNltDL8sfoeaRUniy9NVUXTLcK
 poDDopizdo2WiUdYMurj3M5qkDnvEYceXBoX0sR4unR3AjB+wvFyZ01C4Xz3dX0lzQ8=
X-Gm-Gg: AY/fxX6Jbe9D9LszNnRVl8b0FTIg/mxz6nhlza9wrYH0ZZmpo2Pv8hoCUuiJ2yHzyaN
 xyhQF230hVUFg18qCCOnZdUPHAZpjiG7bjkutvbLM7uJ/MQSlUVwn1fQMy9WX1yKGr82LLq9kgw
 tIfUsYYkfRDAfuqWyaisUhashUK34DzfdlDd0uPq62bONoRXi8jRY/VcZyPiBA5URzGa73V2UGZ
 M3vFLZOGzaGRYzJwDwsDyV+Cc/G619TRqJj8hajL9TIG5zVX/SpX6+iPw4g/IpTM4NJ6OeI5WAP
 bEcTzYUpMkIha9WgLOD8fVwvPSugmOV5WagmcB+9DWJjV/6ichiB+jGjIzlXLqqdn7E8PSW/snf
 IBiuOm6+/f+WsvEPfByRQg8LXqPqI5VoEtOisJSpDFasXSRY8yirWXdNnPuJSIgG4OupINtaYQL
 hsVxHdZ46a84hJNE/ORrAuQIljQ5/yhzXp8NmtQnSlc5tRRuOmRy4QWGjEPt8xdgXL3YrupP6LY
 aqcGJc73I0gSFwAH0WQ6q2H+idLThjf9T8r9g==
X-Google-Smtp-Source: AGHT+IGbiML59SZjIjMiOQ/3XEyV3u5n43sJmVBEtxcLXCo4EO4tHG5YYPAthWY0GTmqWz++5WoM8A==
X-Received: by 2002:a05:6870:1b05:b0:3d9:2fe2:f5c8 with SMTP id
 586e51a60fabf-3ffc0b68c5fmr350875fac.32.1767741441420; 
 Tue, 06 Jan 2026 15:17:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4de40bfsm2059380fac.5.2026.01.06.15.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 15:17:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260105-mtk-fix-build-after-kconfig-change-v1-1-7185a081f7c0@baylibre.com>
References: <20260105-mtk-fix-build-after-kconfig-change-v1-1-7185a081f7c0@baylibre.com>
Subject: Re: [PATCH] scripts/Makefile.autoconf: use abs_srctree for
 out-of-tree symlink
Message-Id: <176774144044.3783364.16500800828711827756.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 17:17:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 05 Jan 2026 14:35:04 -0600, David Lechner wrote:

> Replace usage of $(srctree) with $(abs_srctree) when creating a symlink
> to include/asm/arch in out of tree builds.
> 
> When building_out_of_srctree is true, $(srctree) is just "..", so the
> created symlink was broken, for example:
> 
>     build-mt8365_evk/include/asm/arch -> ../arch/arm/include/asm/arch-mediatek
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] scripts/Makefile.autoconf: use abs_srctree for out-of-tree symlink
      commit: 726d11289f2776098b6fcd99b413b590782a556d
-- 
Tom


