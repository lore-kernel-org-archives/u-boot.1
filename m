Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4421FCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FBE846D0;
	Fri, 15 May 2026 16:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vl4lH9tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC24846D0; Fri, 15 May 2026 16:38:37 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8168A846C3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67cac5ece75so15318469a12.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855915; cv=none;
 d=google.com; s=arc-20240605;
 b=gKfxrIwyP0Q0MVjAZblP/6h3KNmetILuguS96t2Om+2uMUcdFQgajaIVj1hiYKt0MH
 E0faL4kE1gQ2J5d/gVSxpTw480e4dvPi2LcZqIti5jPsDTFAZYEcHW0mVAwTMGzLb/im
 aQm8f1vFdJVMHmk8LdInHbCQM3O+HRWo1g8AJtOlvFji+7WI5ZEaUqoTle0Os+LFHVZj
 dV546SauMx/uwUXmFNs9q3e7ODonhScYNJ9gRoB2FsfqQWwDxOeJJXuQp/6ys200s+8E
 ssaxiIZS8oRDO877/GSSGCM0EVt8XpSgx/YImIs06RvxTOz+V+klZV1ZNDyaKHiB+UYl
 mohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BG9fQkF7S7HP7yR9KekYeeIPtX746x1QAqAOjJliXC4=;
 fh=ptnZVLIx/ripSCihXerYr4Wiy+rRrgXhfjDyZHf7bbA=;
 b=ezvvrwc5xiOziDNnu9Qfl/PIoxD+EPY2u/Dv/5AvJQLoMIr3RmytJKnPlT5iJH/baT
 9TApm8QpTVaNF59o1TF2OshpszqQFJrOgkJPixWZx2i4H7Pd7oo7bgkK3R+Y8cUtySM1
 643ulgrnzSASnm1Upq9yZj3fqH0U3DuK4OoGOV7JYnWVqopKvFn8UXHmWXaHDcNKV3Wr
 igfFNuPOf4J9i0xA8xIQpOOLMIXxAG8s50iZS3OSxOeBoqcUbKDQSdmjPk89AtJKxSNO
 dJtW9jWfepklFN0dV+gujJ68HX1rpS0ZLjODpMHgmeV3rFTivdjLiW/2QS6h+l1yMIgN
 wTMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778855915; x=1779460715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BG9fQkF7S7HP7yR9KekYeeIPtX746x1QAqAOjJliXC4=;
 b=Vl4lH9twFSUgW6fUSjztbklvpGMz42Rc8Of4ch4zR5uT7ayenucpnMN1rEgLha2bCa
 HkmRdcEG7ENkPGyfT41wC4usGqoBtsylU9aZrIX8hlI2R6TNynWLWdchAdM/PS4ynjtc
 HyZyvwKZTbj0218g89OgkFBJ3AinQjpVZ9zN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855915; x=1779460715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BG9fQkF7S7HP7yR9KekYeeIPtX746x1QAqAOjJliXC4=;
 b=kIykMeO1a3bPywkfZ9STMwWURwnW9G95RsPCWeCgvP9Xa1RAPMqGHwALmsKtbQcjC3
 u3e9CZlhrQioZ8fn4R51e0bhKGLa5DmLBa03MWXUyyv3IuDt1IFbs6JQdMpfgA6TDAoc
 h3nNACpsmT3mA5eo+FdEr4p+JEUulYddOkxy08+E8LrzAazDNrLwhApFB2xI4WGWApJH
 y/3QxEC3QM8bOrtYhXJAMOfTersMvxgSH/t4RsNw4rTPnASClxINOZ6nkQybgezyFC5+
 bez96dc+Vz3gEd35PfZ5MtW1I419ocJi98q8icReCfllg229Q8Xd/M83WDL2p5Apqttz
 ZsNw==
X-Gm-Message-State: AOJu0Yw+g+9iXqxj+FCv2CTx62K8k37xR+0Ci7kFPmpYnadN6o2lhEpw
 uFyAuPBVC/UuuEhYgrV0g3h8qAVRsElsQRVF8ZG/JJdg6Lm5SKpbu+68WK2Ln1jByYAHIfCwdOB
 v9BKwxGXaUakJX8OPZvHtouY2bs34khLGA7AHK11g
X-Gm-Gg: Acq92OGJrG5p0cO5j9AZ7eL9kO/yYfbXiHyv26IV8XYwsBEgKvEIinIwP3QRbjEKgUT
 SjRTFOtAub/MjGAs3MQzAO1ZD+4l65U1d7HxKUd/oHVlHSdZ51pmrjcuSHr6pqVjoUmKRSRJMVq
 An3rsg3GrNI9K38AWdpiW9bej/tUPf/UVwigRvMmsb1uLiWTro/eGYeMKOJly+fQF6ATbN2Zi1M
 cTA3xPGv4DmYMxh9H/Bl68gSPzB841v1Mlv7cuhn76A4e1D0P0KcP/RmNxE9x3DfKT7OnwL1NeS
 WwEEXWNyeegid6+0
X-Received: by 2002:a17:907:c248:b0:ba7:500c:ea16 with SMTP id
 a640c23a62f3a-bd51785d8d4mr249453066b.13.1778855914866; Fri, 15 May 2026
 07:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
In-Reply-To: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:38:23 -0600
X-Gm-Features: AVHnY4L-PY2Je7rzhRWlRECnbRnHnhxMsdpavpbFfJA4QpIlUi7UhB76iIpWNAs
Message-ID: <CAFLszTgim-OW-j43X3wNSZ5JoduRBwuwyKCHfVD9mHDoq2SxEg@mail.gmail.com>
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
To: ricardo.salveti@oss.qualcomm.com
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, casey.connolly@linaro.org, 
 sumit.garg@kernel.org
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

On 2026-05-14T20:57:59, Ricardo Salveti
<ricardo.salveti@oss.qualcomm.com> wrote:
> board/qualcomm: use bootflow for default boot
>
> The Qualcomm default environment currently boots only with
> 'bootefi bootmgr'. This bypasses the standard boot flow used to
> discover extlinux and script boot entries, which are commonly used
> for FIT-based Linux boots.
>
> Switch do_boot to 'bootflow scan -lb' so bootstd handles boot method
> selection. This keeps EFI support available through the EFI boot
> methods while also enabling extlinux/boot.scr based bootflows by
> default.
>
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
>
> board/qualcomm/default.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
