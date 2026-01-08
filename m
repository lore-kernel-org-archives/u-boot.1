Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C34CD1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C56841F2;
	Thu,  8 Jan 2026 18:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XYKg6jZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D7B8426E; Thu,  8 Jan 2026 18:42:46 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF0A84198
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso17835235ad.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894163; x=1768498963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0YXxN5DpJrj6kXtYkHQYjdChm8TR6oaxGcA4sIPujIM=;
 b=XYKg6jZlwrEtV0xu1/20+FHEQjmOAiaj6cMFnoZhc0f4s9oUuVIAYWyw+Mv7t2pyl0
 hvxk1ojd2n3vHF0DCBTTAav9a91qH/Wt3WmmzC9L+BSa0jcCr5dNIDZPDixbEa/Ngc9e
 osttZonAsle3XSlWsWoDGbj2wAVzfBhShTy1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894163; x=1768498963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YXxN5DpJrj6kXtYkHQYjdChm8TR6oaxGcA4sIPujIM=;
 b=rpPfrexafmCyW7rAa5bwMZmjnBwB72bqxXKiwIkkjINFxzyz8wPfoUx7CrGXXyGeT5
 d/OyMoCgudxii2exdL6l4xXPv3U2o8jp2x3o0tL/jz0AmX8icbme0e4f8snvhoKdjyUv
 f56rU5S87NDhfcGD+nIez5jmLqerixYQlXUZ/bVDGnc+BQI0XSjSpg16aYkfAJm1IoFJ
 EsuCWoV4fgl1gAopCvFfAKgGlfWfzyA1nYFtJaMQOXo6nmb3O3B7w6+N+4aRUbdOG8XA
 njS08AXQ39GsUOfzSvmKnhz1RhEqu6jRq1VQFuLzI9n0YAKwyuM9CnHBptAcUozNpsNL
 E58Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Muc93zDTQX7Kpb6rIEstx07skPeMCUnKNDDYCvi6e+fE1pdZqFi43qem3ULGE/iPN1OkazQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyaf8Cv2cu3n0OpYeRo043H5S3Vcnl6FQcND7Ym3UGxYCMNrJk9
 lxRUoYJK4Igprr5mWGyfl7CNhPoy2sqrnFkrKulPZtyUduR5p5ofrooYPjhBCQj+01QeQOKwLRS
 be0iWx5aPLoyigdrhROewXVzkNe+cJfUw6IPVRll3
X-Gm-Gg: AY/fxX6u79xHAYVi67dWEJPTlek678LICZwg3PN6b7+Erd+/B62Zbi9ofvcwhe4Tya8
 wVpisOp68lcSGsVOKvVw7dflebdkwrZi8PUIa7ts50v0Ts1vhoaP9EcOOKSlI1jVRPsL/IYa8Sb
 L4Mhk74pQELpm4U8W5J+okd9iBwnsXfn2jN8kWjN2djNPMnyb202xS63q/7+iiRZ7YiiZ/6dZLN
 ReJQQ8D/ToG5HfsjKT5PbfzbXwCUSRH5VBHUxuQN36T8NPYyp867RkDYhlTLsUaPQriZQ==
X-Google-Smtp-Source: AGHT+IEqie/BiXdm16oqvHJoVQ4im5brxMeUZOBi9dePcJoQqVGH9U80CPOv2cPE+kTI/Hp8ZjmCkWh722vHr7AdUOo=
X-Received: by 2002:a17:903:3508:b0:2a0:a33d:1385 with SMTP id
 d9443c01a7336-2a3e39d7c25mr103357065ad.17.1767894162632; Thu, 08 Jan 2026
 09:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20260108144753.1082965-1-sean.anderson@linux.dev>
In-Reply-To: <20260108144753.1082965-1-sean.anderson@linux.dev>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:42:25 -0700
X-Gm-Features: AQt7F2o06_qe-GYVm2hIFTTrG-3p_g-X68DleEw2SBSKdDntZhM4x7pR7NM8bmM
Message-ID: <CAFLszTjeEmpQBiVtQa7_1B=Bzbgqyr7tRR4Z2AOxfmq57necHw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Add power sequencing driver for PCI slots
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Sean,

On Thu, 8 Jan 2026 at 07:48, Sean Anderson <sean.anderson@linux.dev> wrote:
>
> Extend the PCI bridge driver to enable resources associated with PCI
> slots like clocks, power rails, and resets. This is modeled off of the
> PCI power control subsystem in Linux. The traditional compatible for PCI
> slots in U-Boot is pci-bridge, but Linux uses the more-systematic
> pciclass,0604 so add that as an option.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
> Changes in v2:
> - Return early if there's not PERST GPIO
> - Only mdelay if we need to
> - Use CONFIG_IS_ENABLED to set .probe directly
>
>  drivers/pci/Kconfig      |  8 ++++++
>  drivers/pci/pci-uclass.c | 55 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>

You should be able to add a test for this.

Regards,
Simon
