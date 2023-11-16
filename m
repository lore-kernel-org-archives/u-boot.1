Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A281C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A51D87478;
	Thu, 16 Nov 2023 17:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ptwm+LPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0CD87478; Thu, 16 Nov 2023 17:03:36 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D155F86F73
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9df8d0c2505so192791266b.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700150610; x=1700755410; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bNDVS5v9O8FPRNBWyOIHVPQV9nLfvWfvZU+5+Gb7guw=;
 b=Ptwm+LPkpDglGpwKG6uFcZB5zHZ8lMV1izWf8WckiNzK01jG7sWdRS+abkMnpdQcAH
 wl5nXCvTiu//Pjf1gao+hCyy5/EjyHSlu4mV7cj5XBc0XGeDD44RzEkl4huC3IO7JiBm
 nPWwPWG+5vgFsn0z42+LsjTC+/nIH/POOnwFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150610; x=1700755410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNDVS5v9O8FPRNBWyOIHVPQV9nLfvWfvZU+5+Gb7guw=;
 b=gtipHtC1MVqyu/8W7zT7m+udLnUUQOK2Hb+n0gcs6JUMklJFBIwaBrm6VhQAYpG7Au
 t7+Gx/KoaV9mDrD02YKvmA0IODKCx/5NlAwoE6DHrRmFUcDA9YGrvrllspaq73L2Zi4p
 nR+DvkY2qep4aTmSPqQZtiZ2Rq1e5J+7/EnVW6pmQe8iDDD6v4Z/2P8Ru/+WyOXdip8M
 o+zT6R95EUrJeYOiIx8M9en+CCsrVlUOoE5JLdD9kz0N/1jUFVr9cld9Az1hyrIzCsm5
 S/+cXUmYw+daIUHxAfpu2n5UsCk1FkGLDYcGS7Jtnd1Gz+yohCb564/KUx5+DFLM8bQ4
 htlg==
X-Gm-Message-State: AOJu0Ywj6Jldo3M7gndgl0NMFuKgm3So1EEdtVJUG6I5B5P5V8xMqDcf
 mTNS1Lphbpmc2YAsm4rWw1v+OxMlEZVQ0JS80EOvGg==
X-Google-Smtp-Source: AGHT+IGqxwXcDNtOmbdxwria2yFZt13PhebhkFdn4YP3Yd74Bv3Ky4YXPbYqR+/dXoA0Rrtdlgdn+iVSFrgGHfybKGA=
X-Received: by 2002:a17:906:29d6:b0:9dd:f238:a74f with SMTP id
 y22-20020a17090629d600b009ddf238a74fmr1845752eje.23.1700150609883; Thu, 16
 Nov 2023 08:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-2-n-francis@ti.com>
In-Reply-To: <20231115101024.3441093-2-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Nov 2023 09:03:09 -0700
Message-ID: <CAPnjgZ22W3EpWdw-t=B9CjGJkQcNm1hARi1efe91JCxhzoZUpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: k3-binman: Add support for FIT templates
To: Neha Malcom Francis <n-francis@ti.com>
Cc: marcel.ziswiler@toradex.com, u-boot@lists.denx.de, vigneshr@ti.com, 
 nm@ti.com, u-kumar1@ti.com, kamlesh@ti.com, m-chawdhry@ti.com, afd@ti.com, 
 mkorpershoek@baylibre.com
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

Hi Neha,

On Wed, 15 Nov 2023 at 03:10, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Add templates for FIT images used extensively across K3 boards with most
> of the code common. This includes the FIT portions of:
>         - tispl.bin
>         - u-boot.img
>         - sysfw.itb (in case of legacy boot flow)
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-binman.dtsi | 327 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 327 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

What is the DM binary?

Regards,
Simon
