Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC37CEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 05:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111A9864A1;
	Wed, 23 Aug 2023 07:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gC8+QR+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B892864A4; Wed, 23 Aug 2023 07:30:37 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21048640B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 27E6F3FA7E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692768634;
 bh=MZtAmaqC11l0R6l/SBBqRMkGGPvPGAVl4q9Ee9+d4oc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=gC8+QR+yJPcPESiNg+LWrz9YXvy+9eaZD+UF/FrzVEW4g6fzkruo2aB4R31Za5zXk
 h+abY6i8FYFpa2am0PqcMLDNynnujEUf5LT0yxe+nmUarAehoyxywGQoYw+pQMZWSs
 rQFpmrcq7GQ4PRT0DGg2sgTV4tMn83mdIdTm6vA+JE7TMBd464zA44zz8MeQoB3i/z
 NNq3tPmm6wnt6BTPAmY/JXEZXeNVJDvzr47xFeCkkMRW781hTx6uPC76tkK5f4hSJC
 JvGHXBOtJuLgPK3Tlqu4RQqpk0o2C6dafNhrcYn3r3LQCr3HjSHOUfb8XE9eDoyYuN
 1v6JEXhB9fJ4A==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe216798e9so35062795e9.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 22:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692768633; x=1693373433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MZtAmaqC11l0R6l/SBBqRMkGGPvPGAVl4q9Ee9+d4oc=;
 b=W5YOEWz42NQ2fEv1qy/rFOO2hkkK4PHeKhmTQX548MF0XrrE4mdgxCk7IK83SK5Z+q
 cJ/xc9BAygCc093si79gGWyOVmsEbpFGGvKjkIQmRWYmeFPuKPEfDJTY4MXYOoYYoSzK
 /tOqC+EdoVXvyitEiS7jFZQXNjmxvSD2phjiN2nKB4KdJSqZUG2wRYoLeGTurtaQp8mS
 /ajhvTKXTvMYTznB1VZ2gEqEVHeB5drf3hXmDKreVcMzt8Wi/rQe48FoCGo2b7qp/xQ+
 A422/UeMGA9G4jE/z+aT2hW1585yyQqWoww/4DncVnf+qFS7XBPEbHK36H9aNy1+8j95
 DHcQ==
X-Gm-Message-State: AOJu0YyYRimrdoIF2naUfgykDR+oBqXXB0eZ7LS4obgRi0xzGMeRO9/4
 XKBzTOO18JDBtNToW2jDv0Sr2ONI7MKpeGnoprgENk0wMcen4I92Hd5t8nVZ2H5SGgb9Vf8c4TB
 hzeM5aY4onZsW2C/poZ7NQFU7rwMA3gg=
X-Received: by 2002:a7b:c7d6:0:b0:3fe:46ea:62c6 with SMTP id
 z22-20020a7bc7d6000000b003fe46ea62c6mr9046448wmk.21.1692768633708; 
 Tue, 22 Aug 2023 22:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0M0iqVtRrvilfEM31yrfV/8lHhfI0Zx+KqZoUyLeOW133w2PBfZBXZNLem1Q5ih1Tckfqig==
X-Received: by 2002:a7b:c7d6:0:b0:3fe:46ea:62c6 with SMTP id
 z22-20020a7bc7d6000000b003fe46ea62c6mr9046439wmk.21.1692768633391; 
 Tue, 22 Aug 2023 22:30:33 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b003fbe791a0e8sm17732271wmm.0.2023.08.22.22.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 22:30:33 -0700 (PDT)
Message-ID: <1edd9a34-c0ff-8647-210d-1530bf13e4c5@canonical.com>
Date: Wed, 23 Aug 2023 07:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/13] doc: board: ti: am64x: Fix build step numbering
Content-Language: en-US, de-DE
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neha Malcom Francis <n-francis@ti.com>, vigneshr@ti.com
References: <20230822164107.2272231-1-nm@ti.com>
 <20230822164107.2272231-10-nm@ti.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230822164107.2272231-10-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/22/23 18:41, Nishanth Menon wrote:
> Fix up build step numbering.
> 
> Fixes: 4bf49bade124 ("doc: board: ti: am64: Add boot flow diagram")
> Signed-off-by: Nishanth Menon<nm@ti.com>

This patch is only applicable to the next branch (2024.01).

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
