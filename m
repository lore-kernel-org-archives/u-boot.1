Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F4FC83F17
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB4F836E7;
	Fri, 11 Jul 2025 04:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZdF8xxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89F783744; Fri, 11 Jul 2025 04:23:13 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40735836D1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-558fa0b2c99so1303022e87.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752200590; x=1752805390; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+Rtrs9Dh1L6t23vvMWW66d8hzKBjLOB25TnPhN1qTg=;
 b=EZdF8xxne8P3bQf32Brz1Wbne9W1HvuOtbo9bM6pfu7ljtROzdjKdktN6574FkTvR0
 jAnIg7wken+6woPx3HgY4n3JY3wlYWw92goR9uZ7qzuOYfemLzhJLBYrAVlo8u2RHT13
 Ug3c9s1/sA9NgTG/ZDWVYdiRnDmknIBXLN5+y0znv+13TB1M18ZjvI5VAFYMcsAzKJ4v
 gtBHZTN/8PPbJKoFDcLoObBRJPQM2uJwF8e9lFzQs7ZmU/ZMy7MiXQZLtSqzyGr7Ha6Z
 PiN3EsAVNTFYJ1TZdn8eY9dL4+gnz8rmJ0YGE8u3TSB7BMP+bO7qZXUz17ywozB2ORDv
 RMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752200590; x=1752805390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+Rtrs9Dh1L6t23vvMWW66d8hzKBjLOB25TnPhN1qTg=;
 b=nbabQf2nwY3wEr4aIdYCy2yxbvMUAoxrfkyNDB98eQskRFaDEzL3WIHijaSCT63pg/
 hRcAB3ywqCkYdPqoc5lK3JYwoevP3Md8RzSmy/F6HkJ7Cii2njAhD+4RWa2f74yCF8gy
 SHuBpIqcZuR5t/6hTi2xMPmplXX6GpclYPwwDsQw3iwpHUJpYFokIEFZsHIx0zIB5HPv
 uakRMUujK9BMGtDCfgZcFHf+hw/+SL4/a/3k6lvicQjN+PRtRg4IYrd9e/qt7JypRMp3
 Z/ZQCp9KG/fGY+xPhXs72DdOU1xW3g+ZWoQ5lf9JzBS+wTUqJJPtbBDYzzbWcYR0COmW
 zNdA==
X-Gm-Message-State: AOJu0YwU8wORrsqke0iYUYd2+bpnnsNaySTDhrVslBD4att/mND8fPeu
 TPh70lhKlsgdxLQKz89vZ7r+K89acSn3kAfM23jQq46a+/AiLUMZw2oCMQbgP5Eq2cYLSyo4f07
 NCobNZTTvr+bFHyLE3uwiHQPFRqGQb14=
X-Gm-Gg: ASbGncu15e8ddZ0JYlf0rsQ7W60ZQzMq11aizyK4YUZoLHp5N3/wrx4cCLOE7mcVATV
 T744MJEiPoh4WlnN/mCneqwcxvUt2GLt69SHudRMvlnaxkFI8/E/VkEqu/Op2Ws5nnMWCY2kcby
 xsWsd/GuTypghRTp3bOkD7G6BZf+SJewBr4pGIXMm1dKDA71c+XplI261SgW57R/fwGiSMlczmU
 11q8SzH/ZYaasnQIwKy/6MY/Tm04JHsu1Ol06c=
X-Google-Smtp-Source: AGHT+IECn6gAAw2yiHAi/zkDe//4311QLM37GdcukHNWEQQoS0aDz/B54jbj8dPvGnNURmYDXKdOZ0vgFQuRkdsK+SY=
X-Received: by 2002:a05:6512:e95:b0:553:2e90:98b4 with SMTP id
 2adb3069b0e04-55a057f0eb4mr232204e87.17.1752200590115; Thu, 10 Jul 2025
 19:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250704214600.3418869-1-trini@konsulko.com>
In-Reply-To: <20250704214600.3418869-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 23:22:58 -0300
X-Gm-Features: Ac12FXyG-AYLO3ebJql1mGM7UUG_bfyhnbv_XynP3jHq8VTWB9fIN1dpx_pTY5A
Message-ID: <CAOMZO5B0JWgKuFEbZDETRsGQVq3aJW_L2tpC6pUQgF2dVdWc9A@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: Remove the rest of i.MX31 support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
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

On Fri, Jul 4, 2025 at 6:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> With the removal of the last i.MX31 platform we can remove the rest of
> the underlying architecture code as well.
>
> Fixes: f247354708ec ("arm: Remove mx31pdk board")
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied, thanks.
