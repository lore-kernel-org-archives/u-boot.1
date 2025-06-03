Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC1EC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 23:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B37B82BD6;
	Wed,  4 Jun 2025 01:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nVdYYVKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D840582B37; Wed,  4 Jun 2025 01:19:19 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB7C80F9C
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 01:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-407a3c10d03so2644934b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748992756; x=1749597556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVWKAr7f7OQkErU2rMjtqhwi6Od/YG+j/9fqgxCdg6o=;
 b=nVdYYVKeypxeFarSnleEFifpF2TjUoviAh9v3sMdvN0Kp6/N6NMwQuSBIUxL5x2Doj
 0I9gGDmhqXzl8pmjLyiupsAapzVqR30HadJoemf/QcbpSPWRkrwZ+7fjeQ+sOWAqCiHU
 Y+UjiDRzBvmqLoQZ+bGLsBqWjmuPhNvi3TVNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748992756; x=1749597556;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVWKAr7f7OQkErU2rMjtqhwi6Od/YG+j/9fqgxCdg6o=;
 b=IDHY76VG+Vx2TXFujDu9BQ+vlN06pwj84y2dCFO2zpINcz0FC5VhgtF/ONMU8RHifT
 h1h3BQZ60VHIZ68J4BCi875iOzD9M0WX+8vHMkDDX8InzF21iT16rlfES0uXGeO+OY5W
 je31uFB1WsXUovCzONJeyJ0Qdc8T4shrEkR9sOX3DeBSKNBDSVxEd8z0rHUn7jSR8tmE
 TR43Y/5cMJrk+hOyj+Rl1jpvKxNu/tDvbLxP5S7ESXhPxL5M+hA/AG12mcP+ECNwkxkv
 XAaZirE8G0wxLOO5qUC1lhVMq85Tj7JqJnM4iIK4T4tGalwxgF/plYocDRDTppQ5OnMj
 CgXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoIYu+NtyDiVm7hw0eSy4nYxU95n0yKzojAM8tFo/SGpBtgqv2XPJsONauFkNCOQoxtpkhzzg=@lists.denx.de
X-Gm-Message-State: AOJu0YxVcCfw4FZZW8PhQbQj3LrAdEVymnAvXMQ2G52u0pPNh72LS/uI
 RjHnnvYjcUyq9B9S06JLFMBi/UMoBAwci+PwiKV6EP5w6vRjc73amwZlijR9rpAD5rrRgPp0FwO
 +QU7Vk2U=
X-Gm-Gg: ASbGnctX+aL4kMB1owRXVjstn/ou/53TNJPZV/SrR8yrbzM400qzVOZQDTAdNB/gNdF
 GEd3EaFlVYHc2+tchxpQxWHOmvNgyR0qdVonuH8bjK5yI9V1RljW6CkWSO5PU0qkol4tzI7Sf+B
 q/KZh9TvQnSyg+yo6Qvld6dCg1R+2dI2DDibMyXn3HYeZa+l+hJhqZ+ggxOgCnJ8CLauXulV5La
 2oh0nz0TI9XSawikgVhBZLrRvWgxrPg8Dj59hUbeUDf3O3C0BdI7TcDS838H9iUVSOBU6uIkxuH
 7rkvCByLGVtPrz+sP7/LzGjyUjVsx1989ZTdRLzsdGVIvPy+qZ8NicSIZRAGUm9aMAYG4sVEoyS
 CbFtsQdxA7Zo=
X-Google-Smtp-Source: AGHT+IHZuFq66LCAwZdCQscouJqLNqJglWFaaNFiCb7E8V27246d1YG/qw94FuE/cevv8F9vSrUAaw==
X-Received: by 2002:a05:6808:6a82:b0:406:73d3:f03c with SMTP id
 5614622812f47-408f0f681famr887047b6e.17.1748992756560; 
 Tue, 03 Jun 2025 16:19:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1db4asm1990941b6e.12.2025.06.03.16.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 16:19:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20250519084630.376452-1-ivitro@gmail.com>
References: <20250519084630.376452-1-ivitro@gmail.com>
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: add new pid4 support
Message-Id: <174899275494.1527530.11913436194326513212.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 17:19:14 -0600
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

On Mon, 19 May 2025 09:46:30 +0100, Vitor Soares wrote:

> Add the new PID4 to the ConfigBlock handling:
>  - 0098 Aquila iMX95 Hexa 16GB WB IT
>  - 0099 Verdin AM62P Quad 2GB WB IT
>  - 0201 SMARC iMX95 Hexa 8GB IT
>  - 0202 SMARC iMX95 Hexa 4GB WB IT
>  - 0203 SMARC iMX95 Hexa 4GB ET
>  - 0204 SMARC iMX95 Hexa 2GB WB IT
>  - 0205 SMARC iMX95 Hexa 2GB ET
>  - 0206 SMARC iMX8M Plus Quad 4GB IT
>  - 0207 SMARC iMX8M Plus Quad 2GB WB IT
>  - 0208 SMARC iMX8M Plus Quad 2GB IT
>  - 0209 SMARC iMX8M Plus Quadlite 1GB WB ET
>  - 0210 SMARC iMX8M Plus Quadlite 1GB ET
>  - 0211 Aquila AM69 Octa 32GB IT
>  - 0212 Aquila AM69 Octa 16GB WB IT
>  - 0213 Aquila AM69 Octa 16GB IT
>  - 0214 Aquila AM69 Octa 8GB WB IT
>  - 0215 Aquila AM69 Octa 8GB IT
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] toradex: tdx-cfg-block: add new pid4 support
      commit: 4c9340716522250c7e22d4d9405e0a728c5bb092
-- 
Tom


