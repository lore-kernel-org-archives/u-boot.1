Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBD8CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 22:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1280E834AD;
	Sat, 13 Sep 2025 00:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b1etp/Bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D164C8349B; Sat, 13 Sep 2025 00:16:37 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983DD83443
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 00:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-745a415bf72so954188a34.2
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757715394; x=1758320194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ti/95eWWxeKzDeyJqk2mqJ3jVgdznCVAwicUsfPuHBI=;
 b=b1etp/Bzl0DYQ0DObjGlVD2Ubv4kKaxuJvaaonheFTx1561G/DE54F84jwPVmCuJdo
 lWSyfcbb7aTuA3ib0E/IUntyKCXvqslZZWakS+fJUyDRQc6crOKASWz150WXaoB15T3m
 hpOT0hDfPEKHh+4Fp0aFQewhUjUMtyemyHThc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757715394; x=1758320194;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ti/95eWWxeKzDeyJqk2mqJ3jVgdznCVAwicUsfPuHBI=;
 b=Z9MHUV4zSiZRgzVSJxkSfC9vLY17DwYpVFODkI6Q/M1/5j2ZoZBauxNFAREnMLpfyp
 atOHsBWoAFtpTHLcCaOr7IuXAHrtGR8ITsaLzVyKfxRjrpuq3SMbILwppB7i54O5UEtk
 vnqb0VpsDuvIYTAGkz076EtmQ/JmNKx/nHUz7IfBQJJdsHwQ/va5r9XgbjIxx6U1EKgq
 RGlSjx9obxFrRfdwmNB/gwMUMUkBDo0RpmGyd5AkfIZ8QfH9TdzVSnFxNVd3i18bp5/M
 RO1oQsmvTiGbHVrI77eFG6yMgWG3msPULJ04hu3vQHyt/l5L5v89wrUG33vbsIF2Gj2S
 t65A==
X-Gm-Message-State: AOJu0YxVyS2HImVElK/+Uo79GoGCFJ395q5WrvflDdPMWd28plOkB63j
 Sl4ZAmptAFQR7HC9eBLMT5xCQ+xPuGEfThyadmwCzVZP/HXgbJGx68rF8sCql6N5wno=
X-Gm-Gg: ASbGncv2TjyNHxMRVgO24ZOWSmMOGSSoEkqel1xWdNyaPq9bktkbwJTI1a0Y9Cr7fv4
 NpS4FPsONgKc6H87yEsWM1iW9Uo8382RdUC9eT09cDHfP5NfG5OoknrHvakyaAB1qBl0cWlPeNW
 pvN+lQfwrd2+f8rYBrAHGNCgaBVReiEBKGxOv4BfWXLpdKyqtfvxhNT/qN+U/bPF+yae1pRJkIS
 jC3C7k77W0FX1p6MRJ5LX+XwXfA+qMd8HSmRiKgwbjXOHRVXNW25TSt+zOzGrTCmv93OR2/TCD7
 XW9jFUmV2ifa4amTF51kxqN/VOWlrDUB8T9PV+XFz5YaY8u3nJubmZ18+MtNkFFI+icW348oolq
 U1zqW34bO8H5qnALKXEV8OjRHnq4inGjiDTF1yp0bdcVEkAapfbNFkuYT9yvJR88A9w==
X-Google-Smtp-Source: AGHT+IGzPMw03ZLe8nC7t3/JvNZOgVsRhBbWVDijyMfqbgzNAuzB/yxfO3pUcxkVEVDZgtg3O1nOkw==
X-Received: by 2002:a05:6830:6806:b0:746:d832:eb4d with SMTP id
 46e09a7af769-75352d9191dmr2390702a34.6.1757715394082; 
 Fri, 12 Sep 2025 15:16:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524b8a399fsm1268326a34.24.2025.09.12.15.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 15:16:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250902220159.448431-1-marek.vasut+renesas@mailbox.org>
References: <20250902220159.448431-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] mkimage: Add support for bundling TFA BL31 in mkimage
 -f auto
Message-Id: <175771539310.4138777.7079425540191113751.b4-ty@konsulko.com>
Date: Fri, 12 Sep 2025 16:16:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 03 Sep 2025 00:01:55 +0200, Marek Vasut wrote:

> Introduce two new parameters to be used with mkimage -f auto to bundle
> TFA BL31 image into fitImage, using auto-generated fitImage. Add -y to
> specify TFA BL31 file name and -Y to specify TFA BL31 load and entry
> point address. This is meant to be used with systems which boot all of
> TFA BL31, Linux and its DT from a single fitImage, all booted by U-Boot.
> 
> Example invocation:
> "
> $ mkimage -E -A arm64 -C none -e 0x50200000 -a 0x50200000 -f auto \
>           -d arch/arm64/boot/Image \
> 	  -b arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dtb \
> 	  -y ../tfa/build/rcar_gen4/release/bl31.bin -Y 0x46400000 \
> 	  /path/to/output/fitImage
> "
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mkimage: Add support for bundling TFA BL31 in mkimage -f auto
      commit: 6dfd14e1228e6e14462f377987bc896d6b7f1dd5
-- 
Tom


