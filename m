Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147CBCDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 01:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801AE86F27;
	Sat, 14 Oct 2023 02:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="imd1OpkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B93486F58; Sat, 14 Oct 2023 00:03:39 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973BB86F8D
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso411171466b.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234444; x=1697839244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w7RIC9NzUiHcTc1xv4kcudke5+khPOIlPxeqqd8zTbs=;
 b=imd1OpkDiouZ6jtL2AlEKyYVw7K6jKaEyiEYY9mjrZmF6X7DLN9DMiJ0G9ctXk47as
 xsjtD0LZUpuj2TNefpmDI681jMJB1zvPiplmrCMFah7xFFW0WxC5w5OX25QfHqYULa6d
 fr0iUgUFPSej274427OlPi/5DIaLllqNWLlQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234444; x=1697839244;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w7RIC9NzUiHcTc1xv4kcudke5+khPOIlPxeqqd8zTbs=;
 b=rMoUgm5iHlvIGYD4KZNxmfJOovXNEFA6dp10zaLk1E8pG9b8SQeNsKtxLRTZ4Tz2ux
 V7N+rwgIuSlpLjS+wcLzKSgyr+gULF7kTNtKb1uyvjWZTe14tIxkgLsY359/WEEYHMBx
 X4pk5Ar89UHRylJBN1TfBVdZOF6KSWZJIpMBUveKqnynOQxZ0uKloJxPneUDxgALDW7+
 Ul2IN7V63ZE9BBcGNxOUcVPFiKYl+1LmqXFy3hcR72/bxTERsQdpXdaS7kMwYUAB+83Q
 eIIsSrD94qW9zGu9HZiqaqq+PFLlXUiSmHySZ3Wl+TFP6arWZL3YOV9kSZIbIfo4NCk3
 2Iog==
X-Gm-Message-State: AOJu0YwHMbd7FVwj8j2kJXNVd3jICqhQPyCI2S3CKlp5tYVS/fjdWoBj
 diOWuWz6FKN39dznQH8tLZeNcY1XBS/qjNooxOZMWQ==
X-Google-Smtp-Source: AGHT+IFGt+Jc9GPLn1Et3yLJJDrVRvBpNZAnEaj8WlEI1NGNn4j9he9tuo6nutFrjDVlOHAKEqafov4m0eNkG0+QZhs=
X-Received: by 2002:a17:907:724b:b0:9a1:fcd7:b825 with SMTP id
 ds11-20020a170907724b00b009a1fcd7b825mr28198078ejc.71.1697234444408; Fri, 13
 Oct 2023 15:00:44 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:43 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0gxfvDP7+khfz5bWZaq6be4RXqcRxVkfLZ_1NvU7Cy4w@mail.gmail.com>
References: <CAPnjgZ0gxfvDP7+khfz5bWZaq6be4RXqcRxVkfLZ_1NvU7Cy4w@mail.gmail.com>
 <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <e704b87c2a636c5a5f11a4d1c693df065c0c2e92.1695817360.git.matthias.schiffer@ew.tq-group.com>
Date: Fri, 13 Oct 2023 15:00:43 -0700
X-Google-Sender-Auth: eqXzhRqGeC57CpH1B6ZIBTWGN0U
Message-ID: <CAPnjgZ26uefy=gzGXS-HF877HD0a0oNi8Vhf=SXtqTSQss__xg@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: single: fix compile warnings with PHYS_64BIT
 on 32bit
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
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

On Wed, 27 Sept 2023 at 06:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> pinctrl-single uses fdt_addr_t and phys_addr_t inconsistently, but both
> are wrong to be passed to readb() etc., which expect a pointer or
> pointer-sized integer. Change the driver to use
> dev_read_addr_size_index_ptr(), so we consistently deal with void*
> (except for the sandbox case and single_get_pin_muxing()).
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>
> Tested on x86 sandbox and TI AM62x. No new unit test failures in
> sandbox.
>
>  drivers/pinctrl/pinctrl-single.c | 33 +++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
