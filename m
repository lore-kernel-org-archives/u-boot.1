Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89FCCD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E9138063E;
	Fri, 12 Jun 2026 20:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iZ5ukaGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B59847B0; Fri, 12 Jun 2026 20:22:51 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B62A38056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68d232e119dso2064376a12.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288569; cv=none;
 d=google.com; s=arc-20240605;
 b=MUPVyM5q2E58n7y2fIVTyxJpneBL0N9kptP//j33jDesDhS1emIybk0SreOwnNIrJ/
 1vvM1FLoWohmsYXR7b4uhewhpcFS5FYrIzOO6O7bfzD1P0VTTNEA8rFqgQVU8jNonQLi
 z5z0A+GigUryPjvc4CcrhLoebP6a+HGoOCamtoBkKGSztItc9Gw9YvsXe0XR8Fa8atON
 QV43MyJKvX5W4BrtZW7YvgMAVJPB145/WVFrif620GnHYDh49wfRCxnyu5F8VG+3rrz3
 bS97HmV6f+hzveu9dceFRviGmzp8EV8wGAn63h4GsIwQr36Jwmc/Vy8kz+6c5ljedI4F
 rczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1BfMw+6+R0l8UUdK/rhKsOF+lTJslCns4J0ddYaMZGA=;
 fh=/yxIBbzO/Kmcp64yaW7yO9rAjapGF+cUnbZ9ZV2Rdys=;
 b=jUwnkxTDq5ZmFA5/9/cwP6HFfhYX22ox/Xo64RG7aBgxiUcFe4UZVFAwLwdh8bYDuU
 PTXKZvLvaB744o4UibNDVlD5bUfqeIqGsNa26KkA5Sk+mD7Q44xPRpy2Y4LFvBHngsS6
 DE5KMDQd8oewrMbPjjGKTEZSOwxCn7OTaZ446md/y3uNMvXJwEGxwNE3qR+XXZ68ye9l
 RzWZz0nDwn8lEgv8XLlS+RPar96w5uMplJ7YSgT9ST+0fRB8HJhpOZAbO5T2EUP631uk
 yjZk5I7cTCxmQ1ZaoRV66a+0xWwBzlVdSOkpPbyJUXqtbqCG0ef6nhAM6bRbkT3DUDzZ
 tMnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288569; x=1781893369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1BfMw+6+R0l8UUdK/rhKsOF+lTJslCns4J0ddYaMZGA=;
 b=iZ5ukaGHpWGUSRMMh7hg6SrR/Jgr56hx1YM/5BbR3Tay8ZT1I/H141pnHPpaInByrW
 34VOMHu+e5inG8CgDmSraQbBkFQHYogYD3jivzhdTvhLi6bbHiLc1bD9xy/9IuUoADiF
 WeI0F4JdEVu0uhC8cXQzUpqd+Cibb910sZAto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288569; x=1781893369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BfMw+6+R0l8UUdK/rhKsOF+lTJslCns4J0ddYaMZGA=;
 b=CIb6dnSlDpmMv6OFQ1noi8CJTWITn32uV+MytK/cAGXts7hfvwfC2NMOYVKjdg6BGg
 92B+K9FFkhTjz7ROLS9WnaQURVQ2LvmjMdk2FQK+zbL01qnCwZAwy+V7fIx773vk6GAY
 7m8Vkt5esK32Wt6WZcqXKcpi4xRLfA/wsZeyoc1Lvk/1Jr8IODp9vTHtVnEZ1IA2G0Fk
 yz0gHCPsOHR2zVzSUl8HvmgUyJdepgr0D+vaiJ0dCA5Jv9zDL30N69vIZY8soeWI2QeD
 8KjLULKr2HXYZh5fiw6H9O1uYwvlfZbFY36vqKg/7ScccGqHoFCNfT4qFGJ5zaf6JF/m
 fwHA==
X-Gm-Message-State: AOJu0Yz2l9ZPi+5zhW2JWMM9pgNWkZwaQ16ff6rPI7GVTuOsM7CD8QPZ
 jKPIEaSTp5RGkJhX0qmbslA7QXX52LxuTAEvyyW7u71cDbd5bxlodFlqY5vqDU3CsZSkmTctru5
 re8/wGlCJCR8L+W31E3L7Mur5A10IHwlfKyDU3NiH
X-Gm-Gg: Acq92OHz84u5eeAVThTYBzOKzhwtrEAZPAFfIEjaziYPR1wB4owgXKWdEHuVLjjdsSJ
 r2Y1skOxiujzYdlBhKLtplnMr4ANFGh+NL86gZ3JgxXneZPZLQHuffXgNUB+LUrCLxBIy+ylb6X
 FSjuO40JKgjlUXyHsplyN9tk/5rY11rn96tWfq0jD6WT5Iw8D8LWnE847EC8KFS+trfkqLF+WGV
 JkwfgYIBz6/aW6I2Lp5zXPqjUlBLndw4Ygg6B1K1E4gQbojFWjdu1FjoDl7XHmA77h0gMuYPQ+E
 9vJFAEdTkWyv8zP8
X-Received: by 2002:a05:6402:1d4e:b0:687:325e:7489 with SMTP id
 4fb4d7f45d1cf-69378a5dd21mr2022992a12.16.1781288569202; Fri, 12 Jun 2026
 11:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260526020917.8438-1-aristo.chen@canonical.com>
 <20260526020917.8438-2-aristo.chen@canonical.com>
In-Reply-To: <20260526020917.8438-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:22:36 -0600
X-Gm-Features: AVVi8CfW6JhT1-FHY5myb9Pg-gsOasl7q4lIYu1pAiqWNlBCLb9TsYlV0IS6r_s
Message-ID: <CAFLszThhZPJv+WbMWPcMEydZKkQsfU0TzNM=syLBgAkN9SQ=0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fdt_support: bound serialN alias length before
 copying to stack
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Richard Weinberger <richard@nod.at>,
 Adriana Nicolae <adriana@arista.com>
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

Hi Aristo,

On 2026-05-26T02:09:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> fdt_support: validate dma-ranges length in fdt_get_dma_range
>
> fdt_get_dma_range() fetches the dma-ranges property with fdt_getprop()
> and checks only that the length is non-zero before reading one full
> entry from it. The entry size depends on na, pna and ns cells returned
> by count_cells, which come from the parent buses in the devicetree.
> A dma-ranges property shorter than (na + pna + ns) * sizeof(u32) bytes
> causes fdt_read_number() and fdt_translate_dma_address() to read past
> the end of the property within the FDT blob, an out-of-bounds read of
> attacker-influenced data when the OS devicetree is not signature
> verified.
>
> Reject the property when its length is smaller than one full entry and
> return -EINVAL, matching the existing failure paths in this function.
> Use debug() rather than printf() for the rejection text so that
> production builds do not pay any .text or .rodata growth for the new
> diagnostic.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/fdt_support.c | 7 +++++++
>  1 file changed, 7 insertions(+)

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> @@ -1640,6 +1640,13 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
> +     if (len < (int)((na + pna + ns) * sizeof(*ranges))) {
> +             debug("%s: dma-ranges too short for %s\n", __func__,
> +                   fdt_get_name(blob, node, NULL));
> +             ret = -EINVAL;
> +             goto out;
> +     }

The bound looks correct: fdt_read_number() consumes na cells, the
translation reads pna cells from ranges + na and the size read covers
ns cells, so one full entry is na + pna + ns cells.

As a follow-up, dm_test_dma_ranges in test/dm/read.c already exercises
dev_get_dma_range() and the -ENOENT path. Adding a node with a
truncated dma-ranges to the sandbox DT and checking for -EINVAL would
cover the new path. What do you think?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
