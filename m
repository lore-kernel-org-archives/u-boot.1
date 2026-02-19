Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F114CE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858CF83CF2;
	Thu, 19 Feb 2026 14:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="As0wXO9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB5A83D0B; Thu, 19 Feb 2026 14:09:33 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4EB83CF2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-658b6757f7fso1736169a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506571; cv=none;
 d=google.com; s=arc-20240605;
 b=D3uwy4h2wL+AdMW2D8/0WEI5YYu5MofaNARe5WBq0CK0tXNBZqpQeh394D8s+Gqt0C
 E+fZ4YfeTyWJeVRfRHRlnir7iiOHCC5NTBMo8cU3kEI9Ykzv2gFb31eHDuP1tGy71Asi
 N/iY99jMdPrxfP+/VkI6xEaVQeff7qdWBp2uRkb4driXab5XKpUJYPgoU9t0t8gfncei
 DROlxZ0G5Pd+P9Awt9jdd3hY3J4HINdhsG8R4Yzr6N6TTZVDO5pg1J7n/y7NBwvE3107
 V3C5jGx3jYEu2Kt+pf8k0raCjfliE7s9RRSLI91vNRY++BWUqeIZmZZNU/B5QZtBpGkO
 gZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9R1MkmS8Yvnu7XzGbYHEmv2ZfASbsRSZYmchJy6MzOQ=;
 fh=A6DHhLgOw9Gg3gzFf01Yg4jtIsoc8pwDpxFL8shdrow=;
 b=Q1NbDwHda2UQnFkR6xw2fQ3f0rSbsw383/t8ptcFak5ynGTf6uiAr8+H4hgKf+EIzX
 u/BNS6f7RhURmP27Kl9r8ZDw9JCW/pE85A22QETRBLihqvW9MDMWQW7vGIsU58ERHScl
 qzi1A33PXz+4QAEBb5r9HVyPqsbE0iPAqArTKNbJMwF9ZxHUHsuK2cI6+ckj6wsX5MVI
 MUnbu7Djiaag77w5aOEBiraPefTH1vU/VO1UMt0ELoHLkil9EFIf6s9z63HStW0gXLNU
 CmxB9gi9dgexXMbGRL0xxbNP4DoOz3Zsh0XgeJJj9F0ozQqo1Jk6ivyCmfdCCaNVSkaE
 gTlg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506571; x=1772111371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9R1MkmS8Yvnu7XzGbYHEmv2ZfASbsRSZYmchJy6MzOQ=;
 b=As0wXO9maV+2FJ7HAXX38juP+ZJgRwst8pTxm6vkwayovLtHAXFStDKVFZ8PKxAC5w
 awsillv6Yevady6U1olZv3ELlbLZKwda2Q91DLIvNuBAhyazuc1Ory8NaDHdKZon0UKJ
 fYbCWldJFNaN2dIWuWJnnSijGTIFAilLBLGxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506571; x=1772111371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9R1MkmS8Yvnu7XzGbYHEmv2ZfASbsRSZYmchJy6MzOQ=;
 b=kfCspIIAsxsHZHQT9hhhkMWZMcwX2IkAqZCk8RuYeP9fvMSbyc65cG6CSrtgfealc+
 mAg6GlS9F+esFy61ODSidj8Z58ssnLh5dqDgR4bOZeqKsk0SXKwHu5Ur2YlImdBmr65n
 Y6bHc2/x1zs2KodSiUt2jFfZ0s/QTX2a7uGIvB3zKIWrhYXX7pZQ3bKTYYUQzKN5ZA6e
 2wuGK8bxyYsoHlXEDuBmQ+s77KI0dp/inZW4QxqwNWxSBwQtk2kTOiVHTcNYxK/0Q0o9
 6WOzr+iW+jIWEO96yAyVLKkSAHxX+l/bL/wUnqxQ6cbdpYY2DRMVz7si9lksoY3rOhTM
 hn5Q==
X-Gm-Message-State: AOJu0YzOV/J+Mofleq0yc08QMJHPH6M9Og4gWmhV25zfWPFyNGOI+hoF
 QQGclynv24mQZC3Dp2HYysOnctlYJKoeyFIfSSEjqiatx8rul8QvODIyQ8fVtsUqGGRM2bA/jdK
 GT577IXZrrugA0dlZg+EyGlbaDGJx+Xz9Brq5luMA7AayHF+x/as=
X-Gm-Gg: AZuq6aK2A8UMdm68gpqjOc0nD88coZ/2C5JmHJra4zU1DxssJvSnR4Pd6k6bv/v5PY1
 IJFbL67FFFzVi6wVZ6RKUkmwgdYvciJBhJIwy1iqrmnNjcy/yZ5KItcZLtRIE6Uey/tHcktlsYT
 i6T6XbFqW9MsPBlwoj7L/XHxTB8HsxhNoWxuBGGcVvp2Oozc2D8rfqU53QwZeXcBLW6D7hJm2p8
 gxxxDYV/CFiUIvrW1++yiuLyk9J52tax+91vUjuEMkVWYrHdIhVGJ5SdbVyyrynBSndyRZIRgKf
 bJ62/OrS2q2J/NJA
X-Received: by 2002:a05:6402:4406:b0:659:31cd:bc91 with SMTP id
 4fb4d7f45d1cf-65e4f24f18dmr1211260a12.6.1771506570799; Thu, 19 Feb 2026
 05:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20260218-wip-bootmeth-rauc-tests-v3-1-64aeea6d1032@phytec.de>
In-Reply-To: <20260218-wip-bootmeth-rauc-tests-v3-1-64aeea6d1032@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:18 -0700
X-Gm-Features: AaiRm509INoEBtxoeMHkxxyY2ceQfnSRFjxrF2nWMrIdm4xKYYH005rZpYu2IyY
Message-ID: <CAFLszTgYZ9WgtJ1K8WPRLMfQw3QkKyS4=XjSTMNL+p_-U0Nvpg@mail.gmail.com>
Subject: Re: [PATCH v3] test: boot: Add test for bootmeth_rauc
To: Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Andreas Pretzsch <apr@cn-eng.de>
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

On Wed, 18 Feb 2026 at 06:35, Martin Schwan <m.schwan@phytec.de> wrote:
>
> Add a simple unit test for testing the RAUC bootmethod. Provide only the
> very basic tests for now, running a scan and list, to verify correct
> detection of the RAUC bootmethod. More advanced boot tests of this
> bootmethod can be added in a separate patch.
>
> This requires another mmc image (mmc9) to contain the following
> partitions:
>
> 1. boot A: contains a dummy boot.scr
> 2. root A: contains an empty root filesystem
> 3. boot B: contains a dummy boot.scr
> 4. root B: contains an empty root filesystem
>
> The bootmeth_rauc scans all four partitions for existence and expects a
> boot script in each boot partition.
>
> Also add BOOTMETH_RAUC as a dependency on sandbox so that we can test
> this with:
>
> $ ./test/py/test.py -B sandbox --build -k test_ut # build the mmc9.img
> $ ./test/py/test.py -B sandbox --build -k bootflow_rauc
>
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> ---
> Changes in v3:
> - Use ext4 filesystem for rootfs instead of fat32
> - Explicitly create an empty directory for the root filesystem, instead
>   of passing "None". This fixes a usage error when calling "mcopy".
> - Rebase onto current master
> - Link to v2: https://lore.kernel.org/r/20251009-wip-bootmeth-rauc-tests-v2-1-08fbd3738e0a@phytec.de
>
> Changes in v2:
> - Use mk_fs() instead of calling fallocate/mkfs/mcopy individually for
>   the boot and root partitions in mmc9.img
> - Link to v1: https://lore.kernel.org/r/20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de
> ---
>  arch/sandbox/dts/test.dts |  8 +++++++
>  configs/sandbox_defconfig |  1 +
>  test/boot/bootflow.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py  | 47 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 113 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Thanks for doing this.
