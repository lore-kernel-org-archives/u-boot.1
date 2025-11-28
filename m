Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3365D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0F9844EB;
	Fri, 28 Nov 2025 12:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FWfcH75t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B7A844ED; Fri, 28 Nov 2025 12:01:06 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E70844DE
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6e9538945so1485808a34.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764327656; x=1764932456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WQVBTf7EfCl+fFRSn7egL4SD0N6fpDOrICkkcGnS0HY=;
 b=FWfcH75tH69vL4GiIGj1ujZdPm30/5d/NhgaSQ56TEyYwg6ct8uzMhxepga5rXAhF5
 W6zCozMBPamBcxcNNEcxs105C570T8J4mU8t/H6Y+7++8LMHboFymVQ851mMhkG+sjNc
 WooNCfuHE+ijGwTS8ZsrcgpGNec776a3j2OfAyC3e5Qh59ppalE9vf8KMgXDAAVRxRxP
 E+yR2ayN6gi7uohEhr5QLdIURnyGA+tvA0yE5wS7pd8CZwRxUvI8MRb4daReCM0oGnX5
 CN+/wZlGslKjSe+2M9RA3oNImWH+tqvlibDy9UVoF+RbS/tMMjoFtBmjMMz6AQvqRuBK
 ET9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764327656; x=1764932456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQVBTf7EfCl+fFRSn7egL4SD0N6fpDOrICkkcGnS0HY=;
 b=CZIKme/x+/Sg7rSATXrNLRkHV0yBk8c407QlDbkvm/l9hnOMmgc8oC5ZX1EgqNA9eO
 V1g+QamfJWHhX7nyfHv+o2sdc6pz+CS8kDgbTanEAaf0Saqll7l4zS8eBrbTUHTjquz7
 z6Edr//ASoUa/lyzdkessQF5C2fZMQ/Ee9eSb0WXFRc3/P8Ljr9406T7zI9Mf+7m2zn5
 J7RUEzvXtFGQue6WAXrBK5MUP0I9EFOh6wI3ctO6Gc0PxF4U/KHY6uF++GfjfDxrCaEK
 tS1Z4iBjw/ePOlXBrHUrd81hSa797y1Tvz/yGVTvsZ3JeFec4y6iECw6egVmhXaPxT6P
 hqvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyceJ6PMVKa8Cc0Wq3bcZFU51x7hBlnJ3yH0IsHd2UHPSu7EmfFEZf5RbnnTLdyofIsyPR2Nk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz1HBEw76yIahmrxGG+st33kq4EwSjjI/+XZ01X3uSlOs+Pxow
 xrk7h1x+2070PzQdfmyp2Tp9QepZDYpohonZlKzSu/8TO4nQOgzKUDyS/93xdZgUxeknBVVinJm
 MUbnXinfkGPUajxStavH1sY3+TFdMaKpw/m7hgoo=
X-Gm-Gg: ASbGncsjD0vWVUm+0SIVlQVArjKUO8OF5ITUSCDc18sd+wXShcUnR4nePSflhy5Rj0o
 v7tqvQQHE0UjOH6bjDBRjvR3957Co3oS1Z1Sy+k9bjR5YwWPgzanmjg7kIsA3xSr7eopIF2FE11
 EbjyT4iLrTWu4y9eFRmnKWCcO0bWkx0RjW/VhOlWgdYNOKyXQ668IgY6XojjA2yxxZxfvtPA/ML
 FIU98pZFUo1YIMHmAShCCi3qsbSCtRDZmyiQ0dvfk7e1CQUUNzA3dB3KP6iI1AiEiuOekM=
X-Google-Smtp-Source: AGHT+IFO0UnwGDyixJ8x91l9cCVNeBg6tsfgyjVBln3+lWIvidHJo1if7PVJNaREiy/aN8KomH/Wx7WmfV1w041QeGY=
X-Received: by 2002:a05:6830:3365:b0:7c5:38d2:fe1e with SMTP id
 46e09a7af769-7c78eafeffbmr10953640a34.11.1764327656335; Fri, 28 Nov 2025
 03:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20251127192136.168-1-briansune@gmail.com>
 <1d42f643-41a0-4a16-8269-5bad7bf8953e@siemens.com>
In-Reply-To: <1d42f643-41a0-4a16-8269-5bad7bf8953e@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 28 Nov 2025 19:00:44 +0800
X-Gm-Features: AWmQ_bm7z-rTPgy_f6VzBVxK7NjmMLJWE69bPA9Ib1mWjcM1zKg7iOzVaVd6QuI
Message-ID: <CAN7C2SBQOCtCPyJA5+HXd4CU14eNKxkj+GQPCpf+GRsXoAPN+g@mail.gmail.com>
Subject: Re: [PATCH v1] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
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

> Most bugs are device-independent. Those should be fixed separately, and
> I was even asked in the original series to split further. Let us iterate
> on that, I would say.

No, I disagree.
The terms device-independent had already been considered.
This is a complete patch for GEN5 C5 and A5 only.
Other than that will not be impacted.

Read the patch file carefully.
Or simply apply this patch to check what is the difference.

Thanks,
Brian
