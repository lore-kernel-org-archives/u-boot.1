Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6270CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9040B84DD6;
	Fri,  8 May 2026 20:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D0uGzzl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4558784D02; Fri,  8 May 2026 20:48:08 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7073D84DD6
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso5386450a12.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778266085; cv=none;
 d=google.com; s=arc-20240605;
 b=PAWqGobv1Y+svfZ7CeS2Y3p3mnrRvrF4M543LHi0ZEK/sou32E1tBPYbJ/NIAh/7b7
 GHFY7K/THY1F/I4jKqHmMN1NNjCydbU7W4pzGk2W/ZfFkK15QwMNwEdHn3/MuPrFZZro
 ssvZEOB0sHqGc9Bi0KpiN+Y6P6WrIP5q0X8DYENAezxH4Gyp+vVzwnpQ+6I8JP24vymq
 hpSk83b2zhwkw8xMNMcXuas0hKKODGH++pEUDfZTjdSDadeqzheM2ZIXzMzG6lJv3q4J
 Tcy+NtTFh0UdZ7V8dgzq8vyqVe/qMTKGqKa1Yhrgdg7j2rlUvpqhPiFXJ/jOo87sDxl/
 15qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8Xpvj7HqzB0oA+0qdH8N3uNSqgnfG3sf1zlf5hyw18Q=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=cPvZ1r/XsvzYOfGm7V6xB+0JdEJmTAnHIhSMltv1CSFGY1GhqGgbjhwsnTe+WY8838
 8GMxENi6xEu5ZuDB1GdZXA6eSn9v0TogpWWlX0etP1v4eBQeiu0LzBTUDL0vQS/VDKLm
 td40cDbtsG0cUv1h5Ip0WvBd5HlE2+U0UTJ3FhQeL6DKTRzjzjJYdddLK4A+FUaKlmNd
 WNwgOJO0FKBJ1LaXWxs/s8Vb7WNpqTUCOoHM768D/ZDEsyqZGDa5woqww00UcIynFrBO
 C2HXxWAszYUiBv267L+eGF9BZ2xerwQOrurGo8ButILQ+xJUOkQMdJnTc/R4p+EMh7jH
 Hv2w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778266085; x=1778870885; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Xpvj7HqzB0oA+0qdH8N3uNSqgnfG3sf1zlf5hyw18Q=;
 b=D0uGzzl47AIWNdTxDv4/sJAzlg1rTzptEBc0DpNjlOvtNW2TKm6Kc+NQFMoppiaGxi
 CWYLath64g9FHLPukmCdwMHiO/PtZmXTTi7zZcqCxEGAXfg/5wwYsdfu53Bdcrd+HSFx
 H16s8Gk0MviMuQdfkMrcQ+B+/VKTpmE8HCciQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266085; x=1778870885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Xpvj7HqzB0oA+0qdH8N3uNSqgnfG3sf1zlf5hyw18Q=;
 b=SeVQs8w5FzLG5W4j/fWXEvOBnXh31ftzOQknkwrGi9bMxncIyhakBt3eGrgjDN3Jl+
 A6daBNmE8ulkytkJO7Lesifdjm7+IaKo1pBSfVM/wR2ya8qL7dSO3RUMxfQ7fhOJBpfT
 dfd/tSalUArXnslon3vkBVP6FbLZK/fvw82qOERufhw/GkXtIF38DRUnzJE5zHU8Jscv
 Ysl/Ic0HTGCGymQWjsq/uKSY9c59L2BcH8uOmiJITOaYdyB0Es34kharWuCkJGolQyxC
 FPQJuvI9C+bPpDnujE229333E7msVIoxeDBVGQgkAyetXbBZRgKeV8FCfJ3xMWIYULkV
 11BA==
X-Gm-Message-State: AOJu0YzQ0FKqdbvVjW3VYBhL0y2SumNkfT1CckUHCk4FScYDDp5VrJNS
 upWbKSBiglLp1dwWr+VyIAwPPhWIbew+pgUvksM2s87HYMxhKSQEHYYriJpizK3Z332zvrennKg
 t4CMee1rOxi2oPAJPURm6DZpNz+TfEFMIIXfW6Kdg1aFCKA8mApo=
X-Gm-Gg: AeBDiesBvDJ4alm7iwUGKRSwkwCDIBC8bZb+Ho9KwQpgGzQWzAji1zwCgMTaqfMG8Lz
 cC0AO3HGcfTXGM7EJVNNaEOPhD2YmxoC8NdBjJFuebzX++dqJNj6QLaXuIGMa3b2ZsiMG4gwUcD
 p9MQaL9ohNbFhwvQtNnEGs53zD4EFJ4UQUjjOfzj55dm4RRIkMhmVfG62dw3Mq5zI3b9/Yc+fQP
 Tb8936wjaREukBN2pK2r48cAc6VVJT7Lh7575/CPKRJ08E/mjkBcSXNHqB0jSpaIEvGzjwuBlsd
 4O33lNx1UwQe1Ltb
X-Received: by 2002:a17:907:1b29:b0:bc4:b981:d6eb with SMTP id
 a640c23a62f3a-bc85d3c2c6bmr437513866b.29.1778266084789; Fri, 08 May 2026
 11:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
 <20260507220725.209205-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220725.209205-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:47:53 -0600
X-Gm-Features: AVHnY4Kj73H3Ov59kVq6QiWc8FNCIcbDm0B-ebtaoALXZkaF357e5F3yRy2g8HU
Message-ID: <CAFLszTh4bEKqQdT_cCZwoD2jdrz1r4yvtyTNtE0QaDNPV+DZ2w@mail.gmail.com>
Subject: Re: [PATCH 2/3] misc: i2c: eeprom-emul: Staticize and constify driver
 ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-07T22:07:14, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> misc: i2c: eeprom-emul: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/misc/i2c_eeprom_emul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
