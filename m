Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF80CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A9B84D6D;
	Fri,  8 May 2026 18:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U4StF39e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D8A84D9A; Fri,  8 May 2026 18:59:51 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF7D84D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so361423766b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778259589; cv=none;
 d=google.com; s=arc-20240605;
 b=g16rj6eeoy2zZJ8iVuvKkgxlqAZuFKLIr9YMcJeiK1wI8WuqTX2jXvmAYYe7yTR7Wj
 Db9QxfSBQFhaKiVznyKR9P2hx+qvj274mG38m5wTFYjMMgzsbU5SFTNB4udtFmRGgANT
 +BvXsq1nvJsIu+mEeF3Pzz8UFHl7EOPSqRcHvDcy3Fe8w8mrm/8JzTtNB2cvaGwZPAM0
 wudhkNUmmxqjWIk2H8rXNQL/Bb2xgy0d7q6YGHpedMVLPVwm6JxSvJeTZs96tf/4gOVn
 wz4qHkPT/tKNkinZqGcba2JxHoN2/vQuOIvGdJZrVO0KtaZc7uulJPVPxA5WrIrSikHD
 Hw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K8o4/IEk3eWQvU6jgS/NHUOpi0Nb4tX8txlKqJup3dk=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=UeisjMuaKUeYaE4Hc+wix3vnFftY1fn84sqvRc0KeAxcsd2AndHmaxD+ZmgfvCJ+4d
 RJxg2W1Dp2Sk5CuhGOxXPkmW+j18RPsBo4H1vvQe95VdCLjn3dd4sbl010wMKHmQgZX4
 HwKIPQzNCnfIVZJjbSNqiQw/W2uYie+1J2vtv/7rmPdNJx9OQrRXAu/PNxM59iOr2Bmn
 HC7dNbJ+nnU70Bh8TxhrzOXEokZz5hJQBrXrxRs4Y/0tJVw0bK2G9BU1C31sU+vDQtkd
 nQ7pjljsYN5UVQ08H6uLEB4votge5TuTfc0AWXpOvf2Ov9Bi0Apsah8AtHFmi0Unmb19
 yU7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778259589; x=1778864389; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K8o4/IEk3eWQvU6jgS/NHUOpi0Nb4tX8txlKqJup3dk=;
 b=U4StF39euOIP5JgGtRs6YwYKx8b6UofQkKH55Ob8tSKGk54IUQwT8SKuOI4cvGHRZO
 9pEGGKMpIAGfZ2AONhLbIHduWPPCKKQ2e+LlmJNUSqcfhYjiCDIJ46NtdcoQpyezDnU4
 8OIczEfn3NdKoe0s0pY6pTe1ASbE7+JUJJeoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778259589; x=1778864389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8o4/IEk3eWQvU6jgS/NHUOpi0Nb4tX8txlKqJup3dk=;
 b=hRJgutVnokBWMCpHXgNfsRSwHqKz2S04clOeG2fwvJXoe+diweXtuIuX7k6PIWdJri
 k5mp9Plih0JsbU7TWfda0qXOVrwfn7ONc2f88CIfZ++imZPuR3a+8GklUFW51QwXgWBE
 YNvlLEy/X6C1MO6BCGTwpWZ3Rzkik65Ltp1gEN1uQHoO7HRaGRxyY3S/0E6w6QLRbdaa
 QPRIdMKaSeo607U55SrRW+3EHxY18KcMXU+wWWPVVdANKONNIohjvHUEkR/BqwkYssfn
 AEA7IbSDUo7giOTEfTq92CA4qsFIaCtbK8W71CpT0RpaEKNVlbBtY8VlfAdAxDziQkOj
 pmPg==
X-Gm-Message-State: AOJu0YyiuNi7g76NI1yOPjZm6xvHNfxAMGxbe3Kg43tip+oTV/XDbQWo
 gK8mwXOEXkXLbEhKEwpjezrcPTFTV/JEd66z3h+KxJF6VULpOswQ/fz6cfWXoJ6T+VOvTYvxMpz
 weFhD1MWBVp74hlBCB8pE7D/xyuCW+Osld7Wd7ui2
X-Gm-Gg: AeBDieux4pk3XWnAEfyyL7eLoqK4sUBDQfYrl4S0PRGfMjdwAtI5xD2fBxU3XY4RKXz
 sKkZ4/7O1NRtQ+88sHd2pgFN0+Eyja9QeTBgItFIyiodMjN2bLEXqal9IF32Av6ZI6kPQk8FMZr
 bdbRrGHXuBGJ4St0gNuaJ48Plmdyg/DIuYssj1bVjAl9C6ulej1EDeTkxt/MBILHotLINDxpnzx
 h05IczXXA0ZUuOIVkdylR/aNL4RQdiO03E326RO1LZivB0ik9JEMV3ZBwrlVOhyIa1AIp+7+064
 /wRX1g==
X-Received: by 2002:a17:907:7b96:b0:bab:9f73:3b5a with SMTP id
 a640c23a62f3a-bc56cb236bfmr857586966b.16.1778259588795; Fri, 08 May 2026
 09:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
 <20260507220725.209205-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220725.209205-3-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:59:35 -0600
X-Gm-Features: AVHnY4L1hKxse8DwT6gcD8Z0xWEu0r_BQX67cjeB4N75z9MWVLfZrHXDpKeSon0
Message-ID: <CAFLszThbW0CUojf7zpuy_eUS2PYOU41pVGRTujrvo8G19z1Xkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] misc: x86: Staticize and constify driver ops
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

Hi Marek,

On 2026-05-07T22:07:14, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> misc: x86: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/misc/qfw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
> @@ -152,7 +152,7 @@ UCLASS_DRIVER(qfw) = {
>       .per_device_auto        = sizeof(struct qfw_dev),
>  };
>
> -struct bootdev_ops qfw_bootdev_ops = {
> +static const struct bootdev_ops qfw_bootdev_ops = {
>       .get_bootflow   = qfw_get_bootflow,
>  };

How about calling this 'misc: qfw: Staticize and constify bootdev ops' ?

Regards,
Simon
