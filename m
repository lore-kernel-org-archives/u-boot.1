Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E712CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 21:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C578841F2;
	Thu,  9 Oct 2025 23:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hlE4neMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB02284209; Thu,  9 Oct 2025 23:29:25 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7811C84202
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 23:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3b15f0027d9so794098fac.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760045362; x=1760650162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yofQz3/O/G3//2iUYtA1UYamLNCxu9k1qm6empyggCk=;
 b=hlE4neMyDtfqiWQckAzGhnKAVqscOHhQg6qH/IjpulpEmzohzooemvplUMDixXA7Gr
 KKv/R/ROz/1ZKLDPYU5AA6r7pVrDtyd361AYdawfLLSq8ippszei1RRCMdEhJ/Dda7Ni
 V68NphZF9+t9VferaP4wWCaPNU7W+dxMlRChI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045362; x=1760650162;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yofQz3/O/G3//2iUYtA1UYamLNCxu9k1qm6empyggCk=;
 b=P9/JOpJwM5eRl7OceOmLAb0fly9jBW7F8//wdspS320izZ/+LctYtWGJHSX4pIsc07
 EUFCC9DbFBg06TcHUNCAjLC50ATqIoGy7FeN6r1U9RYBmRD2rKWuF3uZHiuNXTwMR9ZL
 7Gpf8Uzb3aA0YyVoIMjsS4xXrWauywILDG8r3D3U8yQO3KmIeIJmqjdTD+c7J2EHAK6K
 NXJt7jUXun/ibgcU81LF7s0EPMRPI/zlINdNFwIxJ/+Td3+9J3iAOxGMxDqzRna6G25r
 U126fqns4MppeAhL/VbODpV/LKMUvI49Qo7J9ZVtMtDO15gGFNv0C9RwAhVy4Gf+Bici
 OiCQ==
X-Gm-Message-State: AOJu0YwEw5mJB9mikZEHBvxctj6CSXecfLj68eBGz/0kdzwEFQmOu8w4
 fqF743lMXSX1IxZUDOpD7t8miNISn9BJnUm1xsg27EBQR8+RANohEoJhRlqOzaBLaxHTwslkHBW
 qlKCPzsM=
X-Gm-Gg: ASbGncs+fhodZ6Ew7uW6VRGMM6bXsUTCRk2uDvHsVPcKOm0XKuAF0x0w2ADhKV3vrHq
 tKTLkFgST69+VtIRh2aUFgfdyNEJZtFiUHf47UIMMKkfvRBcIKaGGR24iwfX0suYB2wpbf+vCLS
 d6YkzSOwdMQHsnLP8NggDnSDfFgEKrQFtCSSSGCHRoH6mZNZ36Q5G/LfSa796iebUzXMrI1z0+s
 s2Apuxj53NiyLcNjJODcTQg1ay3/lksz45TlobT3DkDzAdyY+8CHfKAm6y0VOEjU1HbvQqRqaul
 0loG09YMVttBGN9YRUg6quw5qfhkoxmCKhqbNCGk/+Sc/oFDRRw8idpPgVRKiDrSC8/jKwsM+n3
 OqHojYjfV02tGZe7UVX86JCfXC6vurzNay3WyqEVu/9FFAG+onYW5XI8DfZy9fk2nqSRSZ350bN
 c+bRSZAQpX
X-Google-Smtp-Source: AGHT+IGSgS83ypZ0Hly+2R8RoR9+r7rMwhPqQunWzQCGPzNflHuYl/Mx1vbC6Wd3rZ1qTjA2UxPxbw==
X-Received: by 2002:a05:6870:26d:b0:367:c392:9f2c with SMTP id
 586e51a60fabf-3c0f6af5dd6mr5014188fac.16.1760045362121; 
 Thu, 09 Oct 2025 14:29:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8cc4d3f55sm76479fac.3.2025.10.09.14.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 14:29:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
Subject: Re: [PATCH 00/10] firmware: scmi: various update
Message-Id: <176004536091.1002224.14676119717082278442.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 15:29:20 -0600
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

On Sat, 27 Sep 2025 00:06:13 +0800, Peng Fan (OSS) wrote:

> Misc update on firmware scmi:
>  - Typo fix
>  - Use io helpers
>  - Use PAGE_SIZE for arm64
>  - Add IN_USE error code
>  - Add more error info
>  - Support scmi max rx timeout in mailbox
>  - Add myself as scmi maintainer, AKASHI contributed most code, but
>    seems he is not invovled in the developement anymore, I volunteer to
>    help here.
> 
> [...]

Applied to u-boot/master, thanks!

[01/10] firmware: scmi: Typo fix
        commit: 92fe41caadfd01b6c31df12195b8a9b59ad4f4f5
[02/10] firmware: scmi: smt: Use io helpers
        commit: 8c48bae4f5783a1da95177e7d5d85c00e2ada0c3
[03/10] firmware: scmi: smt: Dump more info
        commit: 23e2b769220be4d3e35167492ef2cd915f647888
[04/10] firmware: scmi: Add error code IN_USE
        commit: eb7469eb1a32a02d024da254d34912c3fe741c7f
[05/10] firmware: scmi: use PAGE_SIZE alignment for ARM64
        commit: b2ae10970d40a26e955d6f763cda77948d8b4f7e
[06/10] firmware: scmi: mailbox: Update timeout to 30ms
        commit: f116ec5b9105ffa4792bfced12aab822e492ff5f
[07/10] firmware: scmi: mailbox: Support arm,max_rx_timeout_ms
        commit: 5e9fb0e5835ace9f9f7c6eceb3dd4cabc17487d4
[08/10] clk: scmi: Replace log_debug with dev_dbg
        commit: 0d71bc3a1bf82ad60fa4fb1b4441acde633249f1
[09/10] cmd: scmi: Add pin control protocol name
        commit: 5ea37da298777ce6fe53b51bd32e3e0614c61bbc
[10/10] MAINTAINERS: Add an entry for SCMI
        commit: 7828597f5430431281071b60289e46afed74ef94
-- 
Tom


