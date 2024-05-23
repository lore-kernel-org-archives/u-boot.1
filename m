Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23988C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 07:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA83884EA;
	Thu, 23 May 2024 09:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mjasKzIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF3C884EC; Thu, 23 May 2024 09:16:31 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8244B884D5
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 09:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e73359b979so36693521fa.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716448589; x=1717053389;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GEhTaqxFAfbDC9U2l3kpIMWVNFw03xR90yUaqx7W4rc=;
 b=mjasKzIfjeS7P5bBcKBxiMzGn5hgQCp47Jq8kFU9KxThwG44vlE9E4fHP5La8W3kW9
 b52tmhWHYG2E/Xvcxv7NdojdaLvkamOYbkItFX8IAddi9/silXMCux2VTGSkVOS9WDRj
 lTEmsCB1GFQWcPPylj8vwXZ8VhjacznDHYvQrZhM+kqQpLdwvphpzlhVLOY96oAadhaP
 XOFBYVvVyy1zvArUE8jHSxvVx/oO3hPSCHO/Kg4vNmY8RZ2M4SO7I0rlSOrYfRKXhNSh
 27rtZMRzRnVaK9MLJZ79+RUeUwdkyqsHCF0cAAMtRDyfGgJruci0kbfIoQlXS1uMW5Ht
 uZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716448589; x=1717053389;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GEhTaqxFAfbDC9U2l3kpIMWVNFw03xR90yUaqx7W4rc=;
 b=V5wkpMnmNicrOPCqfxDU6Ss+iKKgYoJk1eWA3EpmIX4TxZm4wSUqCO8l524hfC4xS9
 rec7bQBPXePRVv5YNbMLkRPwIsz4aNr8MoXpHuHbjKENi4OyRmr1xjTMvx/y5cukTg7O
 hE5mMQbfN4iX1cM0RO9Kn4mWy57N4uW1q09azzzX42Zsfejwutxe7B6F0hqMPf9K/LLz
 f49Er3VYUlWwifbXzmDXzsLWNNJOlyNfMPf4XvZ82CgI0UQY2ZYlqAOEQBD0AiD2KgV/
 FPm5yWhmbt9j4HaIPc1tJkLbc3N0xLgc37oXlpKZAPNydEtnUBpzUxPjUlQQUvDOBOUm
 yC3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIYQ/5EFEkHhPD+fUqq7N3Ts1zwA0yR93oOqwrGxxcCwnr+FROMtSF1XwNVhHVWcbuGc7A2fW0o4QcOCfvchbrHQSJng==
X-Gm-Message-State: AOJu0YymB/5g/XdYkGkGhfv490A+SJ9Q4yhL2kpEMgRlgoiiWx5MPIY2
 2Lw2i3xhuGm+fC9fdrobSsOGkE6iwk11Ge1DeU3Rvotc5KLd9Nc6gLXH/h9e8mg=
X-Google-Smtp-Source: AGHT+IHBoALmsTza4JvWQRLHhznFjeSCMHWK1Oi+qsNVvtP9ITctSRTwj8qDzO51uOnoYpmZbg788w==
X-Received: by 2002:a2e:9e49:0:b0:2d4:50b2:62e9 with SMTP id
 38308e7fff4ca-2e9494bda09mr23693861fa.14.1716448588740; 
 Thu, 23 May 2024 00:16:28 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354faf3fa68sm571572f8f.116.2024.05.23.00.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:16:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, sjg@chromium.org,
 marek.vasut+renesas@mailbox.org, r.stratiienko@gmail.com,
 laurent.pinchart@ideasonboard.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, eajames@linux.ibm.com, paulerwan.rio@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] abootimg: Add init_boot image support
In-Reply-To: <20240523070606.91108-1-r.stratiienko@gmail.com>
References: <20240523070606.91108-1-r.stratiienko@gmail.com>
Date: Thu, 23 May 2024 09:16:25 +0200
Message-ID: <87v835xak6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Roman,

Thank you for the patch.

On jeu., mai 23, 2024 at 07:06, Roman Stratiienko <r.stratiienko@gmail.com> wrote:

> Quote from [1]:
>
> "For devices launching with Android 13, the generic ramdisk is removed
> from the boot image and placed in a separate init_boot image.
> This change leaves the boot image with only the GKI kernel."
>
> While at it, update wrong error handling message when vendor_boot
> cannot be loaded.
>
> [1]: https://source.android.com/docs/core/architecture/partitions/generic-boot
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

To confirm, v3 applies without any conflicts.

This series was initially assigned to Tom on patchwork, so it's up to
him to see when he wants to pick this up.

[...]

