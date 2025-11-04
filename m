Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0C5CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 23:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F4183957;
	Wed,  5 Nov 2025 00:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dc/3ppLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9EC8399B; Wed,  5 Nov 2025 00:30:54 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD5A583700
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 00:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d699610cso2306a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 15:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762299051; x=1762903851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D56gEv9ShmteiR93qFzX7ZxZHtTIFvwf8BYGYpNI5iM=;
 b=dc/3ppLuUDtPkJ8YObrSxFmEe+sKmJ0VBC6MumSjWcbq2nqPqmNtMY3xsKIzrRsIW+
 ZeSGkQVKUoM0AiG3sYceF0dJBt1KtANbLZY19oWLeDd/T24BZiGDEyu1tENSwukmFbtt
 F7rvUdXRks1GWgiimw4g4G7XkrKcpNFmnh+13eRebCWti0gflNbKEbIqa1hAteiuYrnf
 C/YxMBYrl8G44hNXdzzxbMRpaFQykGn8kO/7P0+S00j+uGdlrfuy6wpZ1JuUUQFdGPMB
 5FvJre8dnKY9DGCFGb4uk8VYk2ep8gBORxkJEKRfMrX+GoDC581eld8Gvv+oFx4jXRCm
 PvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762299051; x=1762903851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D56gEv9ShmteiR93qFzX7ZxZHtTIFvwf8BYGYpNI5iM=;
 b=WR0QE5eQ5weOLmeA7WtRUmL5J9aolPvObne2amRQL52nEUXnxHuvi6oftNw1BKGi01
 6Y+W666fifyEX6zwiHGLVWcjfrnKVdjnXcN0sDH4iZHtCoWbynJGFrxhAdwGhjdB6DjQ
 5+PC9ElMgqI7fT7mkwBdv+4EFZ1SdQU00YAKNaHsqQmPcS3BojYmReauWg2Qwo9Z5NjP
 SiwXuRCXNgn0fWEEF5VszfvJMbT/xCAa4KMjAeHcq/jC6s1J+k/rfXwN/Zs+t7pU6fdl
 h7iv7AEXdrd2YTyTx1PrKWZJ6g9G2OUlBZiVHQmHKEPEROIT6JRKV+vKqPXX9LAQgTWP
 Sf3Q==
X-Gm-Message-State: AOJu0YywTmjcJQda8WGfz2sGn3woma+XO5F7lKIN1+I2wwV9WShBCzw8
 42Wo5VFObc8XvTMwMLDupZG+P3RUqrm/qy+PYKXMVg7DNu66ne/IATIP/D21t+2KLP/c8Kztg6i
 Mw/2l1Po7Dcpsr8ya42ZMgZgFWamhBQDzlFk0kaU=
X-Gm-Gg: ASbGncvMJpGFQmuVjAVwy7Rd3dtPaO+WdBVmo4Y2eJWPI99tmBFmCcgKTd+3sA/gvQR
 ruy32zAARPe5iWgMyrZWVjGjvahArjAg7xtme1dW/vC1kJDFH85W1UPQp0EKWxAOKPbNd2n6YSC
 ZuIfHJWTxL/ZTjXf73GjznX8HV9W13pWyiv5qjrSXq4pKlQrFxMoC9ls8RQNAFKJ0LUA8sS1dZb
 hEvCMhLDrQcn+8QLUUPpfW1C1veozgfK80Zy00VJn/8qNUx9DDxW+Pt7kqf
X-Google-Smtp-Source: AGHT+IEIakA7JCIGfsTyahgjpwusMi9XTZJko5YMEtB+hx78GhdirJVdeiix/1jcHIyhOD6WphRF8ZsJWSIhYT8IpTw=
X-Received: by 2002:a05:6830:83b8:b0:7c1:bf6:991b with SMTP id
 46e09a7af769-7c6d13ce9e3mr872466a34.4.1762299051499; Tue, 04 Nov 2025
 15:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
 <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
 <20251104211832.GI6688@bill-the-cat>
 <CAN7C2SCLbo-9=QS8qURd=zwWyOYidAsCtb6E-CGbCmh7yrN9nA@mail.gmail.com>
 <20251104223753.GJ6688@bill-the-cat>
 <CAN7C2SDnm5cK-J=DocOk5hS8k_7565RB9yg5XNVu_kaNb3UjvA@mail.gmail.com>
 <20251104230745.GK6688@bill-the-cat>
In-Reply-To: <20251104230745.GK6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 5 Nov 2025 07:30:41 +0800
X-Gm-Features: AWmQ_bkR-HqOLitGIm9paUEMtd6rgi70TV64vulmmbC8NXRETv7ki5I5fzzwM5w
Message-ID: <CAN7C2SB43UpxPjNVHyzrXYjAedoWw=_s3ySTf6-DcqT5VSpsrQ@mail.gmail.com>
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> Well, doc/board/ti/, doc/board/nxp/ and doc/board/rockchip are all good
> examples of how different SoCs have provided a pretty good level of
> documentation, some of which includes various external blobs or tools to
> also use. That might be a good starting point for better documenting
> socfpga and then also including using this tool.

Sounds like you are having high expectation on this socfpga documentation
revolution.

Just do what I can. HAHA

Brian
