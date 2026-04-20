Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96EAEA71B7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216DA83B99;
	Mon, 20 Apr 2026 04:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dG0TKFjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE9A83693; Mon, 20 Apr 2026 04:57:15 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D07FA83B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso18290945ad.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653830; cv=none;
 d=google.com; s=arc-20240605;
 b=Tgj4yegK8KPm5e5sdPevlygGxEdhCf4rkSibYww0qiK+oqN64RvsHxq7VBMJsCFDG5
 zaZCuA+VJ5+2PLyCYejelyzlf7IPK6wD4QiXzvFCnGMQdq3m/Lrp4YWX/xBptbaWDeEw
 rgh20Wn9d3j93s9FEtqAJn7Dvt3HilbO1kyFpL5DSiomKPUDJbOZNImgfb+2YXtzIW3p
 QaPkJgoMWo5VbhRf+nBeJcj3h4afuAx6yDcfKR+pbwzWNZxjJNAsspKi3E1cSeLsnEm5
 9FhFQv03aEIRno5v8VeNf5joFF+tD4DJx24oE+HC7MwcQeEEduuf+qLfufG9aoFciJW3
 hMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w8ivSMRHL9mck0Q4QosOaNgjF5ccqvJtqIp7XWKXxDY=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=P2J73c8J3HUNGLAuhc9qRKgbkRWMwiKeOmcxaLzreOjuwY9fu4aXq7yOboYqNgV58K
 icRPgtDVd94qd+744MGHmYgRyiSxnixDL2M+5AUKqrLLxhKwAlfBx/xocWiEYs6LuLq4
 EbarHXKCpzaf0hl6ITkXAISLyQxQOI5ukiYxMK47iVugTm217kHFYypi4FlIYWY0Nqbb
 Y73D//AIe5vV2PsQ9ooB/+ZNTV6KKs6B8my8Zf/lQ9fGa/OLpWmzA5cEPHzQ+XfF3wKY
 FLotAy59sPb4QtS7vVDfDMIAoxrS7/0THfrRtow7MBku2lKlBcJEgAzAByMf/kCoD1qP
 O1eQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653830; x=1777258630; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w8ivSMRHL9mck0Q4QosOaNgjF5ccqvJtqIp7XWKXxDY=;
 b=dG0TKFjtSkGbaXOfqLBqT/B/phb8+GV/2zFTh+pjd/l/XvCA4kbqDXofoiTH1g20+M
 RPJ2uFY1q0v0jjQDnPS8Sxo4egxO0tZb140zK/GN727BpKoQlWpXL7uJn1XHB2KjwPk+
 zyz1Lv35Au413eYDF0LaVfknoL3L67qTFz1gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653830; x=1777258630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8ivSMRHL9mck0Q4QosOaNgjF5ccqvJtqIp7XWKXxDY=;
 b=UWRb8ZpqaiMDaXJHghgGUK95uzMb81jxojyaTpuasp0Mfg21270HTKAxPdUef9LLp3
 QfsoQUsO0Xscu3zs5YjBBov+FaDfjja7kOVjfVxwuKqejejIIHv+rCr+IlQr/bpyVNzT
 m92O2YE2J4KOYZKLKUHnTV0p8EK0EBLZP0DxmOgEAhVEhimyRdz7XSrLeAe2Cx40GxKV
 Au1Lqs/RGhvFIww6mlUUH2oOuDKtZ13jDeCHw+J4fvczIMPHLbDXjXwWFO7+PjGwCLr1
 H176nzZ4ebZRMfSfLMn9Cc4WKk+HKUywJOjP9UoU2d8WQjyLUOkx552EKPqAFWrat0ap
 PQrA==
X-Gm-Message-State: AOJu0YzmM5s0I+6WWdvV/oLBC5UiIPcD/6rWeSRoz0/20ha3qzOhP3H3
 1zaIm0dvIuZEgJ+xdSD7fs4PoapUmf1pBLzZbD8ZwZgZ2WJiWmCirBIBvQ1QrIyrah0e49hSmY6
 JJ7LKxorkf1mlLlz+rr8EUzbIHMTrst5SkmoOWidB
X-Gm-Gg: AeBDieuEn1e/E7KA+mmLByWNCkw4a9nEY6h1eqcUfCezkzdC1ebfEAC06hRO5eGPUJZ
 pGrdjjeZeBR7S4a090Te1nHV/r2iKH0WP0T9Bu5fL6hgJvXMM/SBBZ6aPT4Kl1QkX4NxwVXJogv
 4KGCnlkxlJiyd6sNge+ysB0ZwRoqWowzyOQPPHSaf9nZRjfFD4Rit/ddcR+XmkteN/QEuHkc/Q0
 4C5Ag320qjGlSyWJxZVFYc471eGuHsmnEiNeSVB1pJHslyo6F6ntaITmTFwgsMBPKfCaZ6EcYmq
 QOoVBxpzVBHpijWpfx8Y
X-Received: by 2002:a17:902:f545:b0:2b4:61cc:37a8 with SMTP id
 d9443c01a7336-2b5f9eceb9amr128460585ad.17.1776653830161; Sun, 19 Apr 2026
 19:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <c75ab7b2f97d54a5d6f5b236b5134e9edaf5ea34.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <c75ab7b2f97d54a5d6f5b236b5134e9edaf5ea34.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:56:51 +1200
X-Gm-Features: AQROBzB_YAxqt3ywoZxq2NCH-51tOTqzWHi--Vy_RYo3JUTfNVp-otO96mzRSko
Message-ID: <CAFLszTjvAjCWpxis+9dO6y8fhxOu5qmitfkqsGHz8kx7COZL=w@mail.gmail.com>
Subject: Re: [RESEND v4 10/14] mach-sc5xx: Update SPI bootargs for ubifs
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Update SPI bootargs for ubifs
>
> Update the bootargs used in SPI/OSPI bootmode
> to reflect change from jffs to ubifs for the
> SPI's filesystem.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezlite/sc573-ezlite.env         | 1 -
>  board/adi/sc584-ezkit/sc584-ezkit.env           | 1 -
>  board/adi/sc589-ezkit/sc589-ezkit.env           | 1 -
>  board/adi/sc589-mini/sc589-mini.env             | 1 -
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 1 -
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 1 -
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 1 -
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 1 -
>  include/env/adi/adi_boot.env                    | 5 ++---
>  9 files changed, 2 insertions(+), 11 deletions(-)

> diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
> @@ -3,7 +3,6 @@
> -jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2

The commit message could also mention removing jffs2file from all
board .env files

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
