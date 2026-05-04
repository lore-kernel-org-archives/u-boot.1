Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6686FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5175A84653;
	Mon,  4 May 2026 14:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nnnqs09s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A75184656; Mon,  4 May 2026 14:08:37 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EDA8464E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bc356898256so54056366b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896515; cv=none;
 d=google.com; s=arc-20240605;
 b=EB0te0JqslZ1L8SgZlpLcOYoeu66MhXwpRymwJjDc2EOqSyU9k4xySBg3zqhhebFzu
 g9ViEGghU2QEvg5ZAWmd7LSZqPnGIXOsUQ00Y15Myuf27vh/kymy2/xIslP8pc2lOa0Y
 qXAoPxjzABu6eKyrVuJEdDKFmg5rU0xfA63rkQhbmD43pmXRjVuIouIhmY/HFLfZ5MNL
 rnMypCb8+FeM7W22hc4FOuYuyBdDupfXbWEDmcUGys07TfS7A5tomWFYWEa+c8+joQTC
 g5M9WQWw6494Jia8NfMxsI/rfGGMALvuUEHlP4p6LbcMu4xqWzweW9VdToA96OGjlSNi
 TjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=asVWkE2Dwo0vesaM6/Y0NnoGPwfpZ8iFjkEWXIqDl8A=;
 fh=PvMd4X2mdXT08JWfisjv9stH8Lx5t+gM5zKif/Je664=;
 b=YgI8+50xdw7ohzYB7N9WCrI/3HEJ6b3oPrxAeJCRVqWfadxKQeIPDX4ZyeLug5/xGZ
 9UbOq/RY0gja5vtdDLauuNDvA1//doCPpapnOflMHFgego+RrnFHXIfaIfTtDV581keM
 KHMkTU9BpSDP0m3MZxfjRiwesvZWE5pNYQD7dX4tQiQUuiEqUAFGRl9LiSzNCxSekBde
 HFepmMKJ/GSfKQlfUX3Nr6J+7YvfZ62bjMCjOJDm6Q2ox5OuIN1kTOD1+2RU1WQQdMly
 vyv7bVS/SH71kKUkAIg2Cn3n+5JEaRiHXzaLj807Bbj/Qo28CAjrV2Pup4L/tFxzNMdg
 i5tA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896515; x=1778501315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=asVWkE2Dwo0vesaM6/Y0NnoGPwfpZ8iFjkEWXIqDl8A=;
 b=nnnqs09sehLoZ0cgBHMYhHx2vhqNk+MfntIAiEBToBo1rvmIzWbhygRQH/MK29r1iO
 jlrw8lc361AkImkwK5cHLTP150jAwQu6D27F/rWM6nFDgr8eyv8TfRGhD0qKbvjLHty7
 HUAy4vOFo3TtAoHEERuIfjkAEhaL3kPE1XDVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896515; x=1778501315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asVWkE2Dwo0vesaM6/Y0NnoGPwfpZ8iFjkEWXIqDl8A=;
 b=R/cPPUGFc7SulHJLhVOrKXQEAE34chQmy66DZaFK+ZYCUin+gjoxvWc7a1Tmlalmj4
 SCLYmruFdgQe3RZegcND+vkYn0Y5w+5Kj5kqX3BQ7zzHukkZKMTmF+0ZbEttnPTrZmYQ
 9B8loUBtJENlshmsj1FNUfysggEY2yigZH1cH3xvI1+KXXpAZxuLrL3+1O3GXba48Ddc
 SRlWpVIX20x8LyaR9Mxn+2/6UFt/5AhNlOBiCE02KDf4J9YMKcIjs8vEHbtu+R6F6aDW
 fzENKvEbbf+La5SCHkyIeplZfb9YIlpV28MJhQrqAH2QY6dqq4QRqApOru4f6K3tsXNW
 y67w==
X-Gm-Message-State: AOJu0YwowNzWsbw4ohH2gAD36zb1OdnlOQ4/GOagXNTQ4IMlSgT+RXUU
 je/tj3D5bb10Xh4DCMKT8U57NQIESGoBCLU1ox8ta7AVMSLOrLzWSwb2H8HLmR6udD8Dt7dbn1V
 8VkswjKpsDSKUhSKXNFGw5OZFiUbT6LIJCbN65WhQ
X-Gm-Gg: AeBDieskN690P1G2Uh2Ichvt9EuviWDjNYPjhx8INg4SrZoCUw5KQyfofxpqx32uBOY
 qg5OjUAfaSC52ltA/GockGgjSEo2HH/+8u7GUQwxC8LBcRbtq+7bSlptBMjzhQctvPjvzgzBePv
 Pcn2BmV8CvQdGsfH3DAaK+6gIhqy5LpiZgxABzrdiM2FPm9Dwv0r71X+E25UiPzc78J86Vn/DC8
 DxMyXWyxL/DnA7hjb3F0gylnmwrxGgyHHs1YqS8ZV4AFsciqOtzhMZSdkBbDBpOPvp0aPp8N0O5
 ckd5ui9gjs0JCZor
X-Received: by 2002:a17:907:198c:b0:bb8:fd88:f400 with SMTP id
 a640c23a62f3a-bbffb23906cmr449246166b.21.1777896515088; Mon, 04 May 2026
 05:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-1-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-1-dde63beeaab1@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:08:23 -0600
X-Gm-Features: AVHnY4JeC-mxjS0W0Q832zCckY5qTbp6Vkc2SlDb1krZvIdym8ZouMZAfhJHSXI
Message-ID: <CAFLszThmZc-63mY5Dh9y5dZqWJ5KsF5ergCtzbRfyuuo2AYaOA@mail.gmail.com>
Subject: Re: [PATCH 1/5] boot: fit: fix FIT verification in SPL
To: francesco@valla.it
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Michael Walle <mwalle@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
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

On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> boot: fit: fix FIT verification in SPL
>
> Align the behavior of fit_image_verify() called in SPL to the one in
> full U-Boot. In particular, this function is called when both
> CONFIG_SPL_LOAD_FIT_FULL and CONFIG_SPL_FIT_SIGNATURE are set (which can
> happen e.g. in case of secure falcon boot).
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
>
> boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
