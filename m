Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2A2CEF17A
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 14:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DF388413;
	Tue,  8 Oct 2024 16:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="apQyUQuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED95788E88; Tue,  8 Oct 2024 16:16:39 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1019F82BA7
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 16:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5398e58ceebso4939937e87.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728396997; x=1729001797; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYgwVBdgRvnRYTNsz1j3bozFG6E8xy79T8gQeDYyn4U=;
 b=apQyUQuM9uxE/tynlwCitBWfz8+SaGAAZil9atJiOQ1C340fLByaXw0FQbCiQLisnO
 ljrahI9+r9fNL6Ya38J6jnMxuruYq3wJDiqaXw389SbkeRv3VNEJTxxkUjXT/NSAzW3x
 rqtd9+gUpR9oazNlLypDrq9RxCobiSJAHU/L89aOzLz3SY3B+ILuEpkEgqZF+pWLsGYM
 yVrmhvhukS06N53H5pxuQ+6rFYmrTbBkfhY8PpvIViSm7kunQCsFd58MIYd/1Wf799Fz
 j9hhbjIKiAuA1HxMIl9nOIMDbbXhMMReDdelJFG8M1Z4FcB7yCcv1Lg1IHmq1IWII/I8
 WxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396997; x=1729001797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYgwVBdgRvnRYTNsz1j3bozFG6E8xy79T8gQeDYyn4U=;
 b=flVg6OcMBIdZ+iVDrWm40HgP/9ABlDH2Aw4ThooFP5IA9zHH3GpTQg+yeyqnsdpP6x
 EHzVi8FUWbqRz6ufHN1mOw/DVAUTvnFcQyWOlsYCA3/Y6rVxnqEetzbvcLa9s/hJ28uo
 TGA12CP8mU45f83Try3y/WpPGL5jSa8i7bAKFjzJUejxYqYBSzONahDWDRjX2fNNGoHo
 nQCSjFGNOyUr7oH6MEspgCI/H/EebQPzDFWmfbVJzEpMOAI7WpuCTq6gRg/fwH4aakyq
 Eb7xi2e6NRYuCn7s3JLcSIbCwIeFuL9QvKU7cV0MZU+t2b/T1ba0vZbu1wE1NIJqGAr/
 8u2A==
X-Gm-Message-State: AOJu0YzarMzg+5INcS5e2WF6nxegLUl5kwAMqSCVtAZMjyf+Wavgk751
 5BGGdqZM4YW4K5et+IQExoXW6/wxt0jbgR33Q+12RRwkpwjVHFDXvsHEDHMQnPYt0j7SAnwj5fN
 FjV9s8U6vsH3FBBD4fKNrDMjVTqg=
X-Google-Smtp-Source: AGHT+IGiQ4Lz61D9taHPsklQRvXxBjyHmj7K0S8uJzhhgvZeqA17AcYlvjxpnV7ajKA0+Rsxf1QLjQzntuMc4BzvdTw=
X-Received: by 2002:a05:6512:2251:b0:539:8ee8:749e with SMTP id
 2adb3069b0e04-539bdac054bmr1042462e87.3.1728396996952; Tue, 08 Oct 2024
 07:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241007120002.25690-1-marex@denx.de>
In-Reply-To: <20241007120002.25690-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 8 Oct 2024 11:16:25 -0300
Message-ID: <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Marek,

On Mon, Oct 7, 2024 at 9:00=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Currently the enablement of OF_UPSTREAM results on the build system
> searching for DTs only in dts/upstream/ . There are platforms which
> use U-Boot specific DTBOs applied on top of U-Boot control DT during
> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>
> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled, build
> this target for arch/$(ARCH)/dtb to generate local U-Boot specific DTBOs.
>
> Adjust top level Makefile so binman would search for .dtb and .dtbo in
> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>

This one no longer applies against the current u-boot/master.

Please rebase and resubmit.
