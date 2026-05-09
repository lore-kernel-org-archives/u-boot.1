Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91025CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1753F84D9A;
	Sat,  9 May 2026 17:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YScvC9yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5FA84D9C; Sat,  9 May 2026 17:31:19 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F0B84D3A
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bc1f3a393c0so448500566b.0
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 08:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778340677; cv=none;
 d=google.com; s=arc-20240605;
 b=DpyqFY0i9p+UqEK44MCQVrZ91UZwI2+Hgd3hu4ZY4ZcC6EuAtgHL3yP07OOimgnmFQ
 4qHlg7L4o0+lwW4+c5MF6763A1GLsEbEol8npp8eTdKuDGB3WSp8K4UXt2W6bgfUxf7E
 8MIVgcSe6tGG6e2xKKtq7cWBZf3BSQzk+PRcfN3AQ8nF7IdxUqgrW4ypzXhHeyIjnJC6
 IiM+sZEfNfYgXhwpH5T4CrK907T2GBFjH42+f7w99TAkurrwKhX/OsLerPidaTwcBit5
 LDSH3HjJ5vGxgTzDZVZtfJVLmkWlOzZCI/WV2Y0/+ICf9IfttuT6YeWxo7JoIrqP7pE7
 8GKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N1Bd2Jw+uqD+IEbMjouox+TiLA9vmc3HIDXWpzvGMYs=;
 fh=6wCUckz1Cl13uteIbGhI/eyCsGuD3KsbtouwIU3UeGY=;
 b=A2V+tGMK7TYMZ4YvzDcGEwolN2YZfTYctYSOatAqwE2TIelHx5rACeq3HTa0KcGu7P
 I4qo+EKFsIOM6afT0Tjg6i1wb39nZ0AYRf9i5lmLmx1mzk+VLBzPINoj3AYPaYPDY/Av
 EWKBmruLNwlq3GtIEmeJxo2I3DPqhxxx10jI+CUCAQYcnPez0hty9qJtMRlSYFFk+06p
 49uD0LfleZkeH4oi4c4QzqabKOtsGg5zfzVEQbqzdhCX/j2wsa7vrv69m2/gl5Ob/4cS
 5ZHyd5efVDP3FNTR8zMe7BInmgoCKWXnPef56hhMO6LzkbfeAm380sr8iOi6RkYbbDNb
 qwSQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778340677; x=1778945477; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N1Bd2Jw+uqD+IEbMjouox+TiLA9vmc3HIDXWpzvGMYs=;
 b=YScvC9yyftMc+HYhFjuioXqf1O2upC+dnwaeLvWeRnza3yEs7KiHT9utye/7jWujl/
 gKOexocwQtTST2ThvjcUqeN6bWsGE9zW3SajH9SxOgZIC2bfeoKA3Jv2iiXn6dgF4GKW
 JUSpmvneCkFxDXYkIv+6hvf1CRjRvwL4DPsjNMH+KDROkXmCwGgg0VSv+rjV1B0S/8+w
 +DLY2RCn/26NSAraMq3MPjU1QD4tQOs2CnIo3qZkR+8gfU7IG0icJT/f4+PECEgaU2QU
 0d1+1N0KBpFNdz7dfurYCto4cKMhPDpQqV1xtfNBxerJegp6QPiy4nJkIs3wKDD5wr5A
 PThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778340677; x=1778945477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1Bd2Jw+uqD+IEbMjouox+TiLA9vmc3HIDXWpzvGMYs=;
 b=rIKs+vGeUuUeD/Un6FMqg8g3n+S2bFumBNFeALc7hu2DZLW4w+B+0OrhVFCFSoa5lL
 3lBmwQo0UzxwDJmbJvCqq1Z8ttk5F8jf68nlK4xAX2BbdXH3PyjyCegwnpHxBcGZXVzH
 W7PJaHdpZ8N4u0ZOwCpBCc5l/1KAc9P1wziO1jK99oDJyEcMg9U+9MUAhcSq53He3Skp
 JRcS8irloYz2895f1a0vSkv/VItf0VMHjYGNWyPF++nTwrSIqTNRri+ycl2VSybgKGw7
 8Ig5H6OBtylEqCEZJarULecCz0fG7E9P5FnTBP0RZTDkIqViQ+o2RaSJzPTjAmlfMQFj
 FJMQ==
X-Gm-Message-State: AOJu0Ywss0C49Fl2QgcX9aQpHzoq2IqTGYCC7q1/TiWlsdPar1F8sXDb
 ZUOTJHVIshdCRN1W8RJzFyVkRFUtMjKSdA7oAbrDgIZJw5GdDNujG8UAhbxFOAULT03KP3WHmBM
 YQ1pPf6CpJ5bXm/9+WfICZjpZd/iwxV0=
X-Gm-Gg: Acq92OEdJ9ZvGz0mxn7YFLGm8ckqRowKmISF59ZuGBJkGE9LFWWgxUYWsxMSUUoagrI
 CfUQt1k86RhtpbqBkE/N8dTdQtQOuLGMDNDbWTfBpZv6MkIKQEwuorF6B+axMPnY8eHtLkDJUk4
 Eegs7N4mGaCx4rpKRft30Yvi6AW9z2jnBc5UOkhgK6TyPc7Nd2Wb3wzSEVbP+2vbcu+qGQfqpDz
 jRppe+mT/WMzoX++bO0bOcha+9VJGrIybON8MRPNoLz3rpwVvlIUhzStgybgGGo4SLw4YZw8w9D
 xmXfRLhPcdMm1IM+ULLTFXWn91kMuDgqOgB3yYyiyG1XZKAyd6FYN0BRqEIDqUc6OYD3x7L00S6
 /oj1lBXrY7ON5e/fm+p0X4vm2vQYS90gwt0Mim86NpkfnpbOYHzsz1N12bbpgtHC79AhCVSRSu4
 /cc8C6mTw0hxg=
X-Received: by 2002:a17:907:2d26:b0:bca:548e:32b2 with SMTP id
 a640c23a62f3a-bcc12668e7dmr119792166b.11.1778340677201; Sat, 09 May 2026
 08:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
In-Reply-To: <20260508154108.336B968BEB@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 9 May 2026 16:31:04 +0100
X-Gm-Features: AVHnY4Jt-ovxuRxsneubXD6uHYplr8wjrGZIO_S8jhQUYFkEKbjlNC-_K844tec
Message-ID: <CALeDE9NoGeAM_-_GbkybA_3HqNiJwvy-nfgSntG2-EeSd-VxMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix NVMe, not only on Raspberry Pi 5
To: Torsten Duwe <duwe@lst.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Andrea della Porta <andrea.porta@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
 Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
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

On Fri, 8 May 2026 at 16:41, Torsten Duwe <duwe@lst.de> wrote:
>
> Hi all,
>
> This simple quick fix has now turned into a small series. It contains
> the required changes to translate inbound access addresses, with the
> handling of dynamically found devices going into its own patch, content
> as suggested by Neil. While at it, I also added the NVMe enablement for
> raspberries. It might already work on RPi4 setups (to be tested). RPi5
> OTOH will require the other series to enable PCIe on the bcm2712.
>
> Changes from the single patch:
>   - the ternary in the macro is gone, explanation updated accordingly
>   - instead, device_get_dma_constraints is enhanced to try harder
>   - Raspberry Pi NVMe config added

This overall works for me, with the minor nit on patch 3, I tested it
on a RPi400 booted from USB, a CM4 with NVME and a couple of RPi5 with
NVME drives. I'd like to get Neil's review on it too.

> Torsten Duwe (3):
>   Skip parent device nodes without a DT reference when looking for
>     dma-ranges
>   Fix missing address translation for PCIe inbound access
>   rpi: enable NVMe
>
>  configs/rpi_arm64_defconfig |  1 +
>  drivers/core/device.c       | 14 +++++++++++++-
>  drivers/nvme/nvme.c         | 34 +++++++++++++++++++++-------------
>  3 files changed, 35 insertions(+), 14 deletions(-)
>
> --
> 2.54.0
>
