Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F74C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 11:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6519482C4C;
	Tue, 24 Jun 2025 13:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YLE6APTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBE682C84; Tue, 24 Jun 2025 13:13:10 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B8782C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 13:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-553cf020383so287275e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750763588; x=1751368388; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTC52La7qXCmWd+edluVLgKgspf4y2bASmuZD1WJgDg=;
 b=YLE6APTsg49w4MrLTLWRQpC+MNweZZ466kZVOpC0hpwxAmeUDoOObGXDQMJT0m9u29
 GrDBsR/2vNYa1C0nJwbhK3ERIu7opJIZv+DIU763tH+TEqSvf498fxz5r+uN72bwiB+6
 nWKdqRgFoVlTFtOHZZcmJ3a2N2AX/cNsyqNQv5vnLadlDt26K+6jlSKfB9Y+Bs0r3GRT
 3thFhAio8tcI3VFQW+0iZhGN5FMcwQ/cG3oVemlswltWgJfo2eECOWhJP2iBPPxfa4tz
 hJaAuah4c5RkijLrHGLfUS+7UrTnVPkxG75iDV497KXhkBBhGBoveCjvH6OH4gvzm3sz
 TlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750763588; x=1751368388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTC52La7qXCmWd+edluVLgKgspf4y2bASmuZD1WJgDg=;
 b=TSKVxKYAEEFdZHJ6cXyjXFsO8IA6K3Flt/FYGPNh+zT+yDL1P0dGVhnnmN9hwrggBN
 W4+DZYeN00n9vcXomU6s5Htd7oLx+7SUUhzs64zLbSlhv7g9uiUlMUwsBI/JCpvB9pXj
 0z9aUv1REAGSiyhvGKLsnZgcwmw2aXbvwsRekMNPuOXQC74nAosnStlfwj7nfXCJnel9
 Q8SlAJTCHMm0bs3nSOA605sXIIG8V388wFaKOrA5Fi9t0xEK1kGSecKRH/2E4QzG27lV
 +CV0vPqeweasC/cq20GCKYuHu5sRJSjyUiFk+ZGDRUE6+9VsDRkVua5Edk8ak2wqmTBe
 MpLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWbNwD7vXGUBXgvjRvEGqej/RGi5R5O12fCO9iLTKxXjTkTgBCgEzCDuJmImBZVeHPRrTw9Ds=@lists.denx.de
X-Gm-Message-State: AOJu0YwXxoCJHTQuGbIZdDNvyRRyhxfwyD7elxZCO4aBsQS9reU4gCZx
 yocNyOjFXmw0fTAQDSw3jLuQAKU2E6lf1se4vkPOJV5d4qr7zVlZABtLaQihGZ+eLX5rVfxbpW9
 XpVz34gaq9Nd/dZltfadg86m+Eqh/1sg=
X-Gm-Gg: ASbGncuhSVJrc/1SXPs7nllRwdZoHd3n8YyOoGjEtaDKXU72duTHqEAtSufOhm+xDof
 w+V0gdUrS6wZcVRxNxrTs8uTJysRo/2fXGFrTGmZA0+dLAy79PLUvo0v3co7A/O2iWD0qbC7UDU
 4oaxGqEa88Jxxs5JkfoRHiWqb2iCSn4bcA8T0i4CEGUEfRjg8BjyE0ZYuRUbUELCvFIbOpXHMr2
 6E=
X-Google-Smtp-Source: AGHT+IEwpxdZbLuJyUEnbBFzaHBz+oQrwNx3cKCk6PsRROifU+TkItErCA7fEVt5cSd31Tfu/E+GLkGDsKsw8nr6PyA=
X-Received: by 2002:a05:6512:6ca:b0:553:a77f:9c45 with SMTP id
 2adb3069b0e04-553e3bfba42mr4200800e87.39.1750763587717; Tue, 24 Jun 2025
 04:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Jun 2025 08:12:55 -0300
X-Gm-Features: AX0GCFvqc61ncjOD8Ar7pNVVY7kkfNRA9SBvm9S8nWT-J-XIlvRGOQTUihR-UHw
Message-ID: <CAOMZO5AwyMEPE++63O2FncxFVhg7qfmHG7VjDHHfx-pMx8gLFw@mail.gmail.com>
Subject: Re: [PATCH v2] tools: imx8image: Fix the value passed to dcd_skip of
 build_container()
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>
Cc: festevam@denx.de, peng.fan@nxp.com, hs@denx.de, alice.guo@nxp.com, 
 sbabic@nabladev.com, uboot-imx@nxp.com, eballetb@redhat.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alice,

On Tue, Jun 24, 2025 at 7:30=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> The value passed to dcd_skip of build_container() should be obtained by
> parsing .cfg file, and should not be fixed to false. For i.MX8QXP, dcd
> data needs to be skipped, in which case dcd_skip should be true.
>
> Fixes: 5f28a6599f01("tools: imx8image: add i.MX95 support")
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Thanks for the fix.

Reported-by: Enric Balletbo i Serra <eballetb@redhat.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

Tom, feel free to apply this one directly to u-boot/master.
