Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C13C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 13:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7C48897E;
	Mon, 26 Aug 2024 15:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iQBqw/sW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B13888981; Mon, 26 Aug 2024 15:40:23 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49642888F0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 15:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-201ee6b084bso35753325ad.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724679620; x=1725284420; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pbPxy4NZgYyNYou+7+/rc5xCCpLfQXp1DwVP0lSsESs=;
 b=iQBqw/sWfvICRcZ08YDESieC/o4vm0V4zzW7VtR0JIunsfbwQI32HJSbV+FUw1ZHkm
 r9v0zlsgnWXzX09jPJNlzqDr6ASEipkFbXPg15Asar6u9m2vU5oLPIC1NGxN0n6Maqcy
 rxH7HBVsJvA8uHqqgD5fEaBTtqz4JFWl4gxOYeKXhOgEhYwoZmK8vTmDHhA+t1lYo1ur
 P2wWA9+8Oth3b0EG3MjSB2PHWy0VrICpsnTSdgFGF8RYJCc4o4yaJj8dEB14cBscgH9l
 uIpHADPNtHy/j39taoKCHS9DR8BHW/nKKdlhRzZUklbyYg5lAS1L3GMMtGfoDeaNpWOf
 ho5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724679620; x=1725284420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbPxy4NZgYyNYou+7+/rc5xCCpLfQXp1DwVP0lSsESs=;
 b=RY/Fh/57UstCRhwZphSk3IA6SHQ63Hk3/gsKasSkPc+rC518FpDL8NQu9YjvM8VRzm
 sA01e5oekSnzYcbubzoDdtoggsSn0lZy71txwrZimczHbmzI5DEknY3EVA5uZzo5h+pu
 Must61Aq+tCOZ7KJoe2CdzkwmKDSLiHDmcOF3t1nyaXPq6drrvJTPcXltxVRDOv3lAJJ
 fNzzkXuTuGjb+tOg4xMGE/61YepBvl354M05gKPp28pDDWRUoB5H1oGdeK+D1IBAaO2f
 G1SGqXw4YRYB3vjA2p2sKp6S4TNVy9M8fPrIiTozGraFzNICU26QLHlCOKMmisNDxiVv
 IIrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUgEDv5dMqMEtO4b2NvZiZJSlYRAcSMG2lEfJ3YpAUbtKsjB37w40FdUCjU05Z7RO3nVtmtAM=@lists.denx.de
X-Gm-Message-State: AOJu0YzksaVppXeNStNglKFMJSj4bRnQ9a1zUq5cCZcyeC1nlZhkwgbS
 1PuFx40vAjG+zYrWoA8v1sYVsEsUCJrnM3ip+epQ52tZpCHIMLo78PnBZsGr+uBYhfJesc1bu1w
 mo/5/fByNqJAh//+8YIrhRAxs0g77jpZXRdKBhhX7/GnZOVx0ngc=
X-Google-Smtp-Source: AGHT+IHJuVltVrlry0+kpyAx+3ygYrEdrYpH3kik8UEdE5Jloqj06W0GPJlysuiF8q/ms/zxWXOIwR7jVntQ26FAk14=
X-Received: by 2002:a17:902:d482:b0:1fb:8aa9:e2a9 with SMTP id
 d9443c01a7336-2039e470157mr132447465ad.15.1724679619468; Mon, 26 Aug 2024
 06:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
 <20240809-b4-dynamic-uuid-v7-4-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-4-8c44ab1f06a5@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 16:39:43 +0300
Message-ID: <CAC_iWjJVu6e5TY93Hg9pG-eUK_1cCpV77Mf0hmdiXFtB=Z0RYA@mail.gmail.com>
Subject: Re: [PATCH v7 04/11] doc: uefi: document dynamic UUID generation
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 9 Aug 2024 at 03:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Document how platforms can generate GUIDs at runtime rather than
> maintaining a list of UUIDs per-board.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index d450b12bf801..b64009cc2256 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -448,8 +448,35 @@ the location of the firmware updates is not a very secure
>  practice. Getting this information from the firmware itself is more
>  secure, assuming the firmware has been verified by a previous stage
>  boot loader.
>
> +Dynamic Firmware Update GUIDs
> +*****************************
> +
> +The image_type_id contains a GUID value which is specific to the image
> +and board being updated, that is to say it should uniquely identify the
> +board model (and revision if relevant) and image pair. Traditionally,
> +these GUIDs are generated manually and hardcoded on a per-board basis,
> +however this scheme makes it difficult to scale up to support many
> +boards.
> +
> +To address this, v5 GUIDs can be used to generate board-specific GUIDs
> +at runtime, based on the board's devicetree root compatible
> +(e.g. "qcom,qrb5165-rb5").
> +
> +These strings are combined with the fw_image name to generate GUIDs for
> +each image. Support for dynamic UUIDs can be enabled by generating a new
> +namespace UUID and setting EFI_CAPSULE_NAMESPACE_GUID to it. Dynamic GUID
> +generation is only enabled if the image_type_id property is unset for your
> +firmware images, this is to avoid breaking existing boards with hardcoded
> +GUIDs.
> +
> +The mkeficapsule tool can be used to determine the GUIDs for a particular
> +board and image. It can be found in the tools directory.
> +
> +Firmware update images
> +**********************
> +
>  The firmware images structure defines the GUID values, image index
>  values and the name of the images that are to be updated through
>  the capsule update feature. These values are to be defined as part of
>  an array. These GUID values would be used by the Firmware Management
>
> --
> 2.46.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
