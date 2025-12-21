Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0CCD68BD5
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 04:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC5183885;
	Sun, 21 Dec 2025 05:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="Vnnr5gGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D399838BB; Sun, 21 Dec 2025 05:53:56 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0366F83700
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 05:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b713c7096f9so489257566b.3
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 20:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766292833; x=1766897633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ITTxkj5wp0oQ3rTfCYDz6SEB3TbTiV4AAf5bfkGPLAM=;
 b=Vnnr5gGg7ujImbeXW7WVljo2UIlXKCwpGDziRkLo3hOy2KwthfQfPRRZSvPp0KC7IG
 Z5jidkFKk90VbuOSpA9ZhvBu7YMN2BUVxUA0bpPnMZxbity/gi9DSc7VZZN3Aiwot8t1
 7BHyC6oTkqIXCfZIyWBv0n9mZQzCQrqIr5Mf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766292833; x=1766897633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITTxkj5wp0oQ3rTfCYDz6SEB3TbTiV4AAf5bfkGPLAM=;
 b=qZAy2UulQmdETnOWI0BkCIbKV9AvJUyKo9G7yacIa9ELh4kEv9SgzxH/CSRu/ow2hI
 Mci1kSX7osiDISpugPm/Jrc9JPki/vvE3QZw9wNWrKwH9zZWpwapFBfPFxZufMC9F7kU
 QPuO2n1rSwW96koYckfqXR3AsVvCKGIYBfBQqkVpk6NCgA0ByaaamZnsS6EeIaaMt1hG
 ANZr7x1rbxdAF4w5gEF7pW2dKlhmZDsJP+/6BFQI2/56dbyrDlWyrd9ALaPJD33tPSow
 ri3mRCuC22ejIKHZxR/SBGtUc5StZ4x5rw3DNnzZRZyPz0p5d8DITUrs9zyGJuYBvyr5
 EwDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdYaJ5jwzGLl4QLR12MeLQcbTDWAonzglN7Qo0Lo3EIkLdgvgbF310T4VNh9dN2BT766LAVJA=@lists.denx.de
X-Gm-Message-State: AOJu0YywbqJ3J6/qeRLxQuxZDuTEHXiw9ZPAcV6NcliBoYUro0nG1oKU
 UEouiI4+mqE5i9ErsXJhpguqXToCbWnaX3NwXweUOucztJkTqTUGx7lcMMLJtXIMC0rX4Co3PxZ
 DWaSU2yce7HOdTZFYSgpZ3NISGYaaYdGTUZ1Nx198g+XDOJWdZLVZ
X-Gm-Gg: AY/fxX760UoRnPy34/woJjhnNwbdUbnj4ik9ZJwqVN26BfSDJf2IH2ZYxhn8nGGT8r/
 ompfqmWAPODNhGUeSO04M1d1xA1T3O3eNl94qiYT8KSB5PIrMIHJgU87Wafiqnc/mmwJAjeYJuJ
 QWhgIqwLPU+0wuFdYimEQ9S6hgxHaNARXhiunKitbIDvTMYMsHxxvsrYEWlMP2XyUKVnGpqo2qI
 ecBikip+PrA/TPTKHWp6CYd72HWx3O4FC5tfR+MPZmCqJjdlv1TTdjhUu2+2cmxueKrFnjsVdtK
 ab58ONI=
X-Google-Smtp-Source: AGHT+IHXrbOyeVYDwafn9aAesBaGQcfPWD7FaY4ft9NAnOEy0noyh5R48mB88+ITx+7BdBUlO3a13whLo96C8C42V+0=
X-Received: by 2002:a17:907:e11a:b0:b80:4031:bb56 with SMTP id
 a640c23a62f3a-b804031c539mr407960366b.4.1766292833255; Sat, 20 Dec 2025
 20:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-3-visitorckw@gmail.com>
In-Reply-To: <20251218185252.957388-3-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 21 Dec 2025 13:53:40 +0900
X-Gm-Features: AQt7F2pgnTJSgwAD-qK06siTQpG7huyHzw86XUNTPA3XLEd1idOQtp0uKhKIp3k
Message-ID: <CAFr9PXmwBpQW60jZDFf+iqCaSbW4z25=OMN5XXBkBMH5AW-t_A@mail.gmail.com>
Subject: Re: [PATCH 2/3] m68k: Add support for M68040 CPU
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei

On Fri, 19 Dec 2025 at 04:06, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the Motorola 68040 architecture. Currently, m68k
> support in U-Boot is primarily focused on ColdFire (MCF5xxx) variants.
> Introduce the necessary infrastructure to support the classic M680x0
> series, specifically targeting the M68040 as emulated by QEMU.

For all of this: It really needs to be split into the bits for all
classic 68K and then the supplemental bits for 040 (basically the
cache stuff that you only have stubs for).
That way if your parts get merged I can rework my support for 000, 030
etc on top of that.

Cheers,

Daniel
