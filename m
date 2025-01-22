Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43365C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 21:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C5280137;
	Wed, 22 Jan 2025 22:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GmbWDwJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3FB3801FB; Wed, 22 Jan 2025 22:00:54 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62A918001F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-467a6ecaa54so2092571cf.0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737579651; x=1738184451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf+825DI/zxdLm8pANwrgyqYa2efZdfs1ZR/zvBsozg=;
 b=GmbWDwJY2Cj4S2+OHJXDAh4olJ5jAb6ZOMotO1wrTEvi5/sMZz4uuE7xScmumY/ujm
 Q/0M0Dq4L/dr4QyhXoN+6pgJ7DF/4fxWJUVZ8cUkdGnukhy2cZS+nfJX6MsB0lxrIctK
 0oqu6gET9SbJ3vhZcXqAejcXbjSXFi6nGTdt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737579651; x=1738184451;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lf+825DI/zxdLm8pANwrgyqYa2efZdfs1ZR/zvBsozg=;
 b=ANb77/78Hi/RCnLYLI9rq4Eg1Kq3fPBnpp3CurHpj9KkNWRZhCd4hhQ0NuJduXL/Y6
 sfB1KqZdPvx0+1X0HB1d4ZxJwVBVY3DfiU0TiUG4oQLwZodbSoakM3phtkMkbu6kXcwi
 Ryj5aCwJM5rL+bXgIrYVHD1URV5xhVwyCNcis2gVgE9Mnf0Na0pqWOIt9K9mmeyq6fqg
 Fo/8Wl6VTA5rnAhJoUC7BebN+S45ljLrz1EM3exOIUU0vzQZqS1j2JO9U6wTuRu729o0
 QqXhc1d99Z9dXN5A4JxKVuIGWfuYLINIGEJqSHNEtjMt/ErhRrZg+4xXF6G9PEZdutX3
 BWFg==
X-Gm-Message-State: AOJu0YyYfJ++2k+NshDU0y/HnU3xTkBw5sAz2AdDV4NSWRHuT8y8EJPH
 fci2T5eGT2Guv5jsYAEkAgT9PbMHUh4qrSGRa88TmxXJeXIRS6VFMpsRB6zGxSs=
X-Gm-Gg: ASbGncuJxJOw4HDpU2dVYwkZfhMIjChaSTj2D5WDwyy8Ihvehmgj/P/vB+9PdUUF+ET
 4FhV3T4kW2krF6Sp4/CFkFl8cIpiLGZkEbr6JghkI0sGmM27gaZ2yzv6DPWqrktfDItugxi4k2H
 +EBSjYGPxmFG/2vByLgL9sXohiXZDreh4y8EVgA6nlc9MBPZi+dWZ9rK61gtO1rKKkazqn2Ylsy
 qlJ3dLZ/S7Aqq9Fq4/5PAfDzebBHwGN49kNPMLgbuYLNUf0qwYZ/R5AYrR/oKWkSohI
X-Google-Smtp-Source: AGHT+IH0PxyF6PGTuJx99fVosKR+EO4/D1BbYbM6DE69FJ+9Q7JdM5Wg2hYKwbfCKn3D0+WXeGenVA==
X-Received: by 2002:ac8:4617:0:b0:46e:4de6:8a06 with SMTP id
 d75a77b69052e-46e4de68d6emr77109591cf.52.1737579651257; 
 Wed, 22 Jan 2025 13:00:51 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e10305328sm67560021cf.32.2025.01.22.13.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:00:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, Gary Bisson <bisson.gary@gmail.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Trevor Woerner <twoerner@gmail.com>
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
Subject: Re: [PATCH v2 00/22] vbe: Series part F
Message-Id: <173757964792.68186.163782884939541268.b4-ty@konsulko.com>
Date: Wed, 22 Jan 2025 15:00:47 -0600
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

On Wed, 15 Jan 2025 18:27:01 -0700, Simon Glass wrote:

> This includes various patches towards implementing the VBE abrec
> bootmeth in U-Boot. It mostly focuses on introducing a relocating
> SPL-loader so that VBE can run in the limited amount of SRAM available
> on many devices.
> 
> Another minor new feature is support in VBE for specifying the image
> phase when loading from a FIT. This allows a single FIT to include
> images for several boot phases, thus simplifying image-creation.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


