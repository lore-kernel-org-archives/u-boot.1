Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B95CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518E3848EB;
	Wed, 27 May 2026 03:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aXorYrFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7E28490E; Wed, 27 May 2026 03:17:16 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB4884869
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd22b2abaa4so1789024666b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844634; cv=none;
 d=google.com; s=arc-20240605;
 b=EYAeQoq78st5iYVG8ogmTBlsw+cBBv5xOiadxZFLhNlrCHXdmgYgj9oeeDRax4kTyF
 HRQQhwlra8vq7uy0Zf5CZKRHocMfejbLZ4UYc4jDccrWGrsqTcsh37FuoMH/6cXk4KGG
 EqC7s01YgwuAnBPSAckwEQPWiepEQ5N7MfXlnLLQ92N54ms495xD/5/2hOyDl1LZvYuS
 +V14t37r0ckekvgwogmIW3wV1SdFzSRhgnbW19B7H5AulvwaUtBYpjJD24sVgDTc6rZn
 YYGtONxgq0P5XvkF+9PrTrnILv+UiNIc8yvERTi7bkcK71N5H/gl1UGtbeHNpl/5n+Gq
 P2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6M+YXcYJ7tQ/keGTdNedaAlcbp9gX8uCfJq01IPdcp4=;
 fh=rf46CHX5iTEOLZcNA3PtjyssD/5IRnfr6pN5kFO7IXw=;
 b=MSOrS0ri7RwDUv2F8EuQCfukhGLGCoTSEn8z1rRnnRySTV2FVIpTtbdxtCo0tLupG+
 lhBK3BCIeO3KVkc/3OKtukzTFw9O9QX5XVjJ+hP89g5iESbTuU1iflBjAOwFW3Wbgyqb
 CmKJDW7YRlO3YHWg94NvIF1kgK5hfeB9E/Yk1DSGBd5cirqvXJyT5JiH7jxP3KLiVsq5
 u8tD5a2H/v4GYPSEMz7gSuRgrPfk6SCUOxtKCtt6tloZsPfzKys9124jm764u1ZQ7l1x
 0StGR2YjrM4h/ac8r2DuLxBR+fy7JNqHrXZV58MM10bB/3j39bf9P6FX3BHrdqoQ5H5H
 rExw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844634; x=1780449434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6M+YXcYJ7tQ/keGTdNedaAlcbp9gX8uCfJq01IPdcp4=;
 b=aXorYrFwDwYmSsMsUfj/BAngJ5EbTj8b0LU6bYFcsAIKLgL0g8Mco7LWmlivMyVHIk
 ujTa++58tSlvF9jkoWVtdE8kMgflF8a0gajBCuAgBfLkHrN1G+VtJAYfwCRhTqgSqiSr
 cC750KTPmjp+OXrNUWBJ12WAkBoU8jzBpPzx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844634; x=1780449434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6M+YXcYJ7tQ/keGTdNedaAlcbp9gX8uCfJq01IPdcp4=;
 b=PEhQlRCrTceiX/173Y+DmtWBUjYh0T8bg1thRGmIITTHZr/2Tyc7aIZAftkC0LZ1F7
 C3ctLAMoOTj6vQEhwUNNg0UzZO8hV70NPyCdUH7GZ29XkG8UTZUv5ZggT8j3gyTM9Htl
 C+1eu8412uSoSdbdaiOIotBgDAPuzKUAy1oqN5Bi7l4fmdVkzgsrVTfM0xv62BAhbjvd
 Qq+tFlKaHR4HIrHbBkHFihjBzRt/K1SlZplQNq/RGI0TSJjSGWGOd9k2v6pLu71GtR6j
 49wurX7MkJesHWk2H21VwG8iCIMZUPMxMqtxBSYIzDwTQ4NWtx/pzdlCRcYjvmvmWz/r
 sfIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YQQOqAN2Y/rvGt1ti9k/nYsKii7ekOcDKMCfM70QfGfbJrEVfo6KU7AVXBaVCH+yCr6v0g2c=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2Ns2K/nZinbu4Nl5CDGvm6Rxzhl0Ljus7ZhuDmJjMnMKAQFhb
 NRBgvlSalCVknXn/YH5a0Mg53jkeSFGiGqT3uoZ2kU7xA2E3gVsWFJydEQXYJbMbVi38NO64tse
 gKZ8SPATyGYrIe90BwZHWvn+PzEu32YZ6jiV9M+83
X-Gm-Gg: Acq92OFWGavzM6l72QGu4LvsVFSkdj0WzDkOH9AUuaCb3u7KortUlctdQnEgU8KGUlB
 97myGvT0jr1qGMzTUz7IEyg1iNoss4SIaT6iY1jpVBKjnnCuzEG+LlEkjwqs4xYgqz481f0Rfy2
 9UmC90kbGT5NsJp7qIhgxtK9vHhJRuuD4BaxfljU5kIhqcCvI5dagSzlCaHPm035QudBtbxR1ML
 lOnZJiXwL3EnowXbSqFUBAjYx85cRDsrlnK2wOovPMKXajtxAgvTCy87x2XxkU3z4U40Erk0AFz
 uedAhtX5C1oIPGIs
X-Received: by 2002:a17:907:1de4:b0:ba8:a21f:9c4e with SMTP id
 a640c23a62f3a-bdd25ce7e17mr1025554266b.11.1779844634528; Tue, 26 May 2026
 18:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
 <20260526124044.354578-7-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260526124044.354578-7-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:16:56 -0500
X-Gm-Features: AVHnY4KzsuNZYKQr0TggSfEMVa5grLZIMpbDX070vyyTN6JV9B6IhjulWw2Nu9c
Message-ID: <CAFLszTh9+njuf1K9UcwEJOB=+Rph18XbXGgAsDzA5VDq3E3d-g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] boards: tqma7: call tq-sysinfo setup
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
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

On 2026-05-26T12:40:39, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> boards: tqma7: call tq-sysinfo setup
>
> Probe TQ sysinfo drivers to print device info from eeprom during boot.
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> board/tq/tqma7/tqma7.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
