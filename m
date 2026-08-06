Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4BEC56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 17:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CA7440857;
	Thu,  6 Aug 2026 17:09:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgJDpI1wiFla; Thu,  6 Aug 2026 17:09:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1777340805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786036170;
	bh=BFXlMU6DOHYoLX9CITfQ0e6IcLqNb/Nm2uJTBWVSqmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LE0iDybHEWLc5fsF4HHYcw3yVdEL6to0gp3YUEUxSrsuohUoGor3lyyz99erKZQEf
	 sah582PoIfaDLQrmaURuVK0sr0czNObzBYqHBwKVOCi3yG2fJgdFTPhDCRnvaIvF1O
	 +WYw6rmiCcuqTwtQ0fI8N1TqEDhe3Xw/aUjE8ctsDE1aJL4JEiWuIZw9Akj3/Semdq
	 I7e2vLT1dO7bQcrcKKYOhlazyjKOrPwb/xW5sSvj4jUF80XyESvkldgQNolVB9Y+69
	 F3TLRrA5z/PQEbKML/epDXOuq/vU+fKYaCiCelYrizOBNYO+kaLJc1yuBEY9N/uJBL
	 SEDwSP2s8sjNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1777340805;
	Thu,  6 Aug 2026 17:09:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 762E1392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C1A540805
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xf5SIj-9CAEf for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 17:09:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4011C40473
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4011C40473
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4011C40473
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:09:27 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so4030635a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 10:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036165; cv=none;
 d=google.com; s=arc-20260327;
 b=WcNvkxq31/Dcvys0E9jL8xmZqs8RtHTIeDDqemfiF/d5o+fTUD+F3UsI9jd6RRIDAe
 6BRklmKcBsoAcWbMR7KNAgG4F5B92f8ucNXLKpYa54g1uYqMRNLcc0JVQdUBSkCh8S01
 K6AFNS64clvIy1f4vkMKEr9uy6UrXq25xmS27wWkqCIDIrOMdNcWv4fh41AqD5FQDyRF
 3zvvOxptKleuZfgJvgUSZDJnCnSc9JMOhVCcnEum90TErJvH9FTiB78NEVXL5Nh4J5S1
 UtlbWK+5G+J07t4SF86M2+cTh5nN4d08Uv1jh0aIIjn+qpGrUBtlGi5Yia06t5uoNGtm
 /uwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BFXlMU6DOHYoLX9CITfQ0e6IcLqNb/Nm2uJTBWVSqmw=;
 fh=Qe0Ic/EUO+9IWytden6r420E7DP3QB2PgHsA8AUFoEY=;
 b=OJrBLdNcbSpxlK/J6bHmYJU8puX+a7EnsmXXZSjt4Fn1lf4CTaQ1+pVa+GIVj9iUyc
 IDUvwUqbN7bn1/1T0jWLQOCFtTLRW8mE7q/XEtNItFJ85zZRtIG70TxqcHD1kwBWPNlx
 sbimEhNoSw32ZxjahjCaNBIo42FJwvJd/gqZU0RCs7NHMmJteF8ta9BrT2XjKdy7tSag
 qC4rqOlVZu4bZgzffOR8kIzwjksKLYvLLbLBBkaKJOjk8JWCOx5RnPjpRvlraWq6gbP1
 j+Hno5hM4LnCzK9e19YqHJQa9UdkGjLz8Sev7bG8He3Il1CUBsyUBZtD5Jfx8R2mj3HN
 mzvw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036165; x=1786640965;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BFXlMU6DOHYoLX9CITfQ0e6IcLqNb/Nm2uJTBWVSqmw=;
 b=cmgM0KZ/EWvpLmME9EMrMMpez5D5GZ2/sW2YzE5nSOaw2RyUscXwJsgnKgXklR4GQ8
 wQ5wFjf+RMoo7UboU5O2s3/iI4bocxsqiylietPwPyr8J3JnSfk9estz/A+c5QeWYoOq
 E7GMJZbbvasrZ6z46Ool8PUDAOyukx2yP1bfPwFgM8Vu5i4Sb4GGaiKNFW+CrWKahzAf
 hdJ6QAJV2lVqEQC19TvJPRO5f430PWrAg8M3bQwye7Pt4LtLYOwWMaI1qbzKmvCnxkfN
 1RjfpzkwW84piv8kwJO+e7t+ghb11yucSzcNiz5zq0KWsNvuIDOUbmQqafJvwTaEltZD
 CgTA==
X-Gm-Message-State: AOJu0Yz9dgwWnMGsMehcDZX84PZuGUFmOOYpl+EGE0Yojd24sFWjCQrO
 MdQyNj/8xsR9WcI7IgN3uBQTsZmHID0iSj+Ciqopk9jdSsr1l77VP57NqVCBCI0iqcF7VhBFixX
 q5qZryBixSuYbVyAkuXLBWJuk+A48VVKWL2oaHeGC
X-Gm-Gg: AR+sD13il7guc+lauD8Dzp5Otdh4W2SHdf2oOtjLu0TTMJYvVdFWH4qtCtje0Eg84Pu
 W4B81f7g1cKemGquP9evAIKr7SdddUCGV8xz58ggG+kSP5+RISHrEKjYoguNZ1/puHbznzTOrAN
 ciwFAmCK9SdlN5dIAIkSJkw2HOxJ8uWZJYqkMXJqXq7eiUc+6Q4xTfgFWHuv1wnCEsfB9v/6oES
 xgXxA0HVYzi0QbBPncbqN4YKa7BLp0h6yLvB545j/klp0SrD+RA1xiqq46NbKmweXVwyOMxJtYm
 IVkHDDab0iubaYORotXdHVA+OJkPF4eH295uHHQ2Pbw=
X-Received: by 2002:a05:6402:1f8d:b0:6a0:927e:39e2 with SMTP id
 4fb4d7f45d1cf-6a14f0c5762mr9076204a12.5.1786036165071; Thu, 06 Aug 2026
 10:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260805203113.46567-1-smoser@brickies.net>
In-Reply-To: <20260805203113.46567-1-smoser@brickies.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 11:09:12 -0600
X-Gm-Features: AUfX_mx5hrrjekqq6wjm0U8lHRFBlivb_PCTyRJaEw_bebobkL-d5xW9uqYq2JY
Message-ID: <CAFLszTh93y-zky7whGWp9+pbV3KeSOeHvL0WnDKouqEMR8hD1Q@mail.gmail.com>
Subject: Re: [PATCH] dm: pci: fix uninitialized fdt_pci_addr fall-through in
 pci_get_devfn
To: smoser@brickies.net
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Dustin Kirkland <kirkland@chainguard.dev>, 
 Dustin Kirkland <dustin.kirkland@chainguard.dev>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786036165; x=1786640965;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BFXlMU6DOHYoLX9CITfQ0e6IcLqNb/Nm2uJTBWVSqmw=;
 b=ohi4k/LJOx7JB46HdtqbBEpSF2/wuKx7iyPQ9XF/zoBS09TUSfAiM1tzC0k0Wz2Ld2
 Edwy/bfLirfI6IczV6PjvBj7JjA+VGbEyLQsv+Cf4wZANZxA9YxzVjyfZoQTkO6UucNn
 fQcvRLbLbolngf/9oy2qkvHrDTbBtYfv1qOuI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ohi4k/LJ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Dustin,

On 2026-08-05T20:31:13, Scott Moser <smoser@brickies.net> wrote:
> dm: pci: fix uninitialized fdt_pci_addr fall-through in pci_get_devfn

Thanks for tracking this down.

>
> pci_get_devfn() reads addr.phys_hi and returns the low bits of it as the
> requested devfn even on the -ENOENT branch, where ofnode_read_pci_addr()
> has NOT written *addr. The C standard leaves that read undefined; in
> practice the returned value depends on the compilers stack layout and on
> -ftrivial-auto-var-init. That value ends up in pplat->devfn (set by
> pci_uclass_child_post_bind()) and is later compared for equality in
> pci_bus_find_devfn() during PCI enumeration, so an under-determined
> value produces an under-determined driver-binding outcome.
>
> Concretely, this fires on Raspberry Pi 5 (BCM2712) with vendor U-Boot
> v2026.07 when the tree is compiled with GCC -ftrivial-auto-var-init=zero.
> In that build addr.phys_hi is zeroed rather than left as stack junk, so
> pci_get_devfn() returns 0 for every DT-declared non-PCI child of a PCI
> bus. The Pi 5 device tree includes one such child under the second root
> complex -- the rp1 simple-bus node representing the on-SoC RP1 south
> bridge as seen from the OS side. Under zero-init:
>
>   * pci_uclass_child_post_bind(rp1) sets pplat->devfn = 0
> [...]
>
> drivers/core/util.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

>     Reported-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
>     Fixes: b52142004fbd ("pci: Add pci_get_devfn() to extract devfn from the fdt_pci_addr")
>     Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
>     Investigated-by: Claude Opus 4.7 <noreply@anthropic.com>
>     Co-authored-by: Claude Opus 4.7 <noreply@anthropic.com>

This is a good find!

Please drop Reported-by when the reporter is also the Signed-off-by -
also U-Boot doesn't accept AI contributions, so probably best to just
remove those tags. Also not that useful to mention a vendor tree - we
mostly just worry about mainline here.

> diff --git a/drivers/core/util.c b/drivers/core/util.c
> @@ -20,10 +20,8 @@ int pci_get_devfn(struct udevice *dev)
>       /* Extract the devfn from fdt_pci_addr */
>       ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFIG,
>                                  "reg", &addr, NULL);
> -     if (ret) {
> -             if (ret != -ENOENT)
> -                     return -EINVAL;
> -     }
> +     if (ret)
> +             return -EINVAL;
>
>       return addr.phys_hi & 0xff00;
>  }

The fix is right, but the kerneldoc in include/dm/pci.h still says:

    Return: devfn in bits 15...8 if found (pci_dev_t format), or -ENODEV if not
        found

Since this patch makes the error path observable, please either update
that comment to match (-EINVAL on any lookup failure) or return
-ENODEV for the ret == -ENOENT case so the documented contract holds.
I'd lean towards -ENODEV for the not-present case and -EINVAL only for
a malformed reg - that also reads more naturally at the callers in
arch/x86/cpu/apollolake/{pmc,hostbridge}.c and intel_common/p2sb.c,
which only test < 0. What do you think?

Regards,
Simon

[1] https://lore.kernel.org/u-boot/20251113133038.GF6688@bill-the-cat/
