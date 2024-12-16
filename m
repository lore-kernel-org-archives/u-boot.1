Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0532E77183
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 08:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3710380104;
	Mon, 16 Dec 2024 09:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VRAZeet9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743AD801BE; Mon, 16 Dec 2024 09:00:32 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAB38005B
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso4082605f8f.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734336030; x=1734940830;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=97pQlD+ezHqCdmlbNNhCMI0CzG01GeufrZgOPtifH4c=;
 b=VRAZeet9N6igJUCKT1fY+yS50nJswPJnFNkhp7OH+ALGIf6oscF9xJa5RF01+Pd4B6
 bM0EzFasvOgLrJc/S37Zgci/BOvQ1d0Ff2CjdYJxHDZZkPghvTP/kcZ0Wdk7ct/17rTn
 BXK5IRZLvfCIWfWX2FQBzToefRdREA0fhxL0cg/+tgHVILKKpaX/kjbEyGosLxurdS4P
 A6Ain1X7cb0g7BN/HPxKdIudLAay7Btu7G4SymzeCnIkHMu2BmgER+HdRp0Qx/u0xkVt
 kxOLkK2tIjNJ5CtqeHDH0jrS1VyN2FgSEPx/hrt/c/RargkLkc/fCj7PLLJc1YzVHx3g
 /3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734336030; x=1734940830;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97pQlD+ezHqCdmlbNNhCMI0CzG01GeufrZgOPtifH4c=;
 b=IOq/D9flHl1FqKRYRs8lrqgorKWS+7IVXf9R0IoUfcFYp+gluQMh5noSMw0epsdYni
 k8tnApn2tE932R2qm3chsXVs/qwTPKsaiZQfyEBLJJE7Ep4qf4zgYn/IvOA7+VVicfu7
 UeVhOFWPydzwAon0AYcuqcRQuAnRwmNBQsa6e0BpQkMo5MNwMdTcGCi/4QEgqjCqddb7
 Qm3w4Y5QaCY0eNG846yqZ3HzvbKbqZ+H9Ct2FNrmauC/FfygJDL3l22dHbIf0xO04FR6
 YU6DM3EIypZWoJiLUZzRJdzIAmMp5yfOY871PhkvJNjCwKeHS1fbh8TKPemMrIVgMBlj
 WbaQ==
X-Gm-Message-State: AOJu0YyM8oc/pdV8uCpufpNBSCLCrbJmHR/mgy6mzQwITX3YpPvGykem
 MMPKQ6FMHkw9vSGFeW95rjfvdTEfK+gE2t1nqVhN/GA2VupRhsf7tS3orQSUnZg=
X-Gm-Gg: ASbGncsMg/7ONrV40LLqIYlQq8izZ9DCheYxslrB1IzouQuBOeeNqpFbfjvJ8Chq0If
 nUbi/kLwo0UndRPGO7R4hVmqIuS8lbw93+9WhTbLUPGiMw6uOHXuAvfxJ1a53Goz5+lFhj8BQ+D
 raCqpW2Za4CkTiVm7zcih1KC9ux2GuS1IxbJ1M28Aie6ZZB3kxuCsYp9zHEEbJ+otqsnpsFWVhZ
 rVAu9LQKR2Xrn9t818fP7HackktjoB+ve7XNexSAgCsMdHFOxd+8xyoEwXGRYb8Bg==
X-Google-Smtp-Source: AGHT+IEvXLGA01ksFOqtRYFHH2IXag2EXqNDh5Ep/SMfWB6Utjddoq+R0n7MKs0jBqno1QaIhHHKzQ==
X-Received: by 2002:a05:6000:186e:b0:386:3903:86eb with SMTP id
 ffacd0b85a97d-38880ad9177mr8849997f8f.23.1734336029618; 
 Mon, 16 Dec 2024 00:00:29 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625550518sm132194235e9.5.2024.12.16.00.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 00:00:29 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nicolas Belin <nbelin@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Safae Ouajih <souajih@baylibre.com>, Ahmad
 Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH 2/4] boot: android: free newbootargs when done
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-2-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
 <20241211-fix-bootargs-concatenation-v1-2-c6752bcb9dde@baylibre.com>
Date: Mon, 16 Dec 2024 09:00:27 +0100
Message-ID: <87frmoxdk4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Nicolas,

Thank you for the patch.

On mer., d=C3=A9c. 11, 2024 at 14:53, Nicolas Belin <nbelin@baylibre.com> w=
rote:

> Free newbootargs when the concatenation is done and bootargs env
> is set.
>
> Fixes: 86f4695b ("image: Fix Android boot image support")
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 57158280b41c6552c82838e21384d925d5f7cde4..362a5c7435a3a8bcf7b674b96=
e31069a91a892b5 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -322,6 +322,7 @@ int android_image_get_kernel(const void *hdr,
>  	}
>=20=20
>  	env_set("bootargs", newbootargs);
> +	free(newbootargs);
>=20=20
>  	if (os_data) {
>  		if (image_get_magic(ihdr) =3D=3D IH_MAGIC) {
>
> --=20
> 2.34.1
