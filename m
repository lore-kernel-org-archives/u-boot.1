Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E1DF3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 16:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE61B84154;
	Sat, 11 Apr 2026 18:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ASrIxBs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CFD8416F; Sat, 11 Apr 2026 18:29:03 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7182483DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a871daa98fso19936595ad.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 09:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775924939; cv=none;
 d=google.com; s=arc-20240605;
 b=DIc1eHwzx8ob/eJOiVEwkEnsUZipQuNyMx8fmWxH3Onk4izWOIgI3CkN4HxEDYebqL
 yAy43qO0Tgu6IxI4cC5r7rb3PGboNm13+HHs1WmFiwu9BKY/CfMV8j2gWhacT9OvwQn8
 /nE3/Nx7OP8kcrdmOCZmhQICN+WeuN/S5Sctyns3QxMLbFkg8fU89BBbLh3IuZdEtEAu
 QEfv5tdHUmci9PaIfNWCdUv+MPyV/l18fy6z0KmqbqZukSK8xlL1zj6iaVHXFQa6rLtG
 i2/q+Lb90a/UBrt4Tl+fDBlcQ0YKq9BtQT14dtFNhH9vw4xCfgOM4WguzGReADzzAs9H
 acpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k/nmbm6JVzRS++F2190jGb9MqXHXbchef2D+kSN9Xxk=;
 fh=kI0ydHh3I9VudES9YPN+YmTUNcg1GAMjIdsyacz7lxc=;
 b=UtZTF96iEDV2ZeLqo/L+DLERkRlRn8FmBFyoHkt8bbG4nyA2NajZylDuIxjqVEK6AV
 oRNS54Y1KWYWU5vGjVEGEXjUZ1HxsJMZsRQNEcnCHdwp9+W8Jz2/woHIFnrCoYHmywtL
 X3FNCfUvzZPtujfE8pbVI2l7yPSj16aZcIOEeBjFnfyVAhvPty/VEcudAVq8T12qOMNx
 6oK1G2Y3u6txCzExjk3OZWpOjQfQ3D9/KuFg5ApE3SgRstVAlFdrM5fhNeCCz3SxQqD2
 ZpiTAqUYnDo2tC7mWMQFiHUfKNrMXyjeQyWtV6o1NO5D8WWFdNkQqbOLDzxtbPmxq09z
 aQnw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775924939; x=1776529739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/nmbm6JVzRS++F2190jGb9MqXHXbchef2D+kSN9Xxk=;
 b=ASrIxBs7x7Z0dgSJ0baiH2t9Tcz3ybkqDwDYlmi1gDD26pgzPiElE3ShVuBX22zh/h
 aI/TDOhyczzo8/b11othp0Aa8KYdgr0nbGagRblN6GvclkfiGXL5BG0zmbJicOLOE/av
 7B7Z/FlgFgAZM/3sOqRM5BKtuROX6Bc+xsIe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775924939; x=1776529739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/nmbm6JVzRS++F2190jGb9MqXHXbchef2D+kSN9Xxk=;
 b=T9OkS30SkfnIzp2LFZnNY3UZJX/MB2IT1SQ8ToreWLNw8Xk1T2RGkb8FilmnoLeBP/
 ZXeNNmJn6bCsYmYoKWI0zKdJXbPAfirNYRmJmZP+/LSRmrMswt10/jqZmYIG4w3DgjTu
 RDRsQzO5wBu6wm34E3LQ8GNtBybY7u463Xr9ttRlwl10dxYf7VM+BEkDoMvHJNBkte8L
 uURpfv/EBwsGGxD+yYctDWeqa0uQi2rkehJGqDzK0X0WGJ23v3zIdg/zSfcV3Yn24LyE
 XqncJ33VK4A29OvwSU7NmCWGUur5kK4yrk6cOjKYQfIAdLptCTJh54BrkwtGcM10AYZo
 OKIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j/1Zhb7lDxXZbwBrZ7RLFCrgUK5JNZUqdEAON96XS/qopCjt6mZNO/ttT3d88o1jUFSJG41M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3H7JSVrahXeAMNpHonNZKtzwJ75TXIarzBZDToCH7yTud+eHQ
 cHifSbszpbTBCxyj0mlQU7fQPCHms8swHhE+4TPUscuDOmfrFrJKfRld6B9wkPP+G3f/D4ByTMA
 eI0dr6qaVUTkk14mbOpqMZaWJ7SM3zKoaetmXjxPP
X-Gm-Gg: AeBDietm0ZyulYcT4bP1CRglN6GC8LyhckP2OY5wlf2snn56TkUYplMfzohuHgzL07n
 U2v6j6kn9a6MWGz0Id5LBMzQ7Va3eazvOrOkbn5Gl/gke8656XGZc80R++51/n5oz1tHhClYnHz
 LdwVCwfaa5FqBgfPbCp3TdyefaeB81n9/N86RmmBY1XsYnIhKgLsELGMyvyjRg/CS+hKu7YRhPb
 F8ME7v+S8TEyf+XOWoVFxxejxeWNJ5LZMr4FDSPaLXpwDy308aVRSJRCUv33X3gjDNr+Eam5M79
 OVZlwk9QtU2Kj1Vp
X-Received: by 2002:a17:903:2c04:b0:2b2:4fcc:2687 with SMTP id
 d9443c01a7336-2b2d5a49c8cmr73621835ad.31.1775924938864; Sat, 11 Apr 2026
 09:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-3-daniel@thingy.jp>
In-Reply-To: <20260408220928.3328551-3-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 10:28:36 -0600
X-Gm-Features: AQROBzCYb5Ny5X0_rs5BYrzFrPnckqeoQCQy0qpOlFw2vNwaV2PwwPu4p50t24U
Message-ID: <CAFLszTjdAcFbyELhAC6Si9_pSOH8ZqMWD_inrTH3w+VNEXt68A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] m68k: Fix writew(), writel(), readw(), readl()
 endianness for classic m68k
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de
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

On 2026-04-08T22:09:23, Daniel Palmer <daniel@thingy.jp> wrote:
> m68k: Fix writew(), writel(), readw(), readl() endianness for classic m68k
>
> In Linux these are meant to read a little-endian value and swap
> to the CPU endian.
>
> In u-boot for m68k this is currently broken and prevents
> virtio-mmio from functioning.
>
> This change is only for classic m68k. Coldfire has read big-endian,
> no swap for these in u-boot and Linux and existing drivers probably
> depend on this.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> arch/m68k/include/asm/io.h | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
