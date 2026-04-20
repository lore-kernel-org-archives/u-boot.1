Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F59F588C1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8512B843D0;
	Mon, 20 Apr 2026 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="QMALVH4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9239D84315; Mon, 20 Apr 2026 14:00:48 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708FC8430F
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximilian.brune@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so542229766b.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 05:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776686446; cv=none;
 d=google.com; s=arc-20240605;
 b=kvg9inAwGB/u51dyuxMjtriMLEy20p8V+Gjn0zBwNDry7ibbyNB8bLT2/Cxh2FLRmy
 yfqzSM4ET196ugIzg083ty4pYdQld4sOJAT+AsI1mOZVYQRf1gNX9OB4p9tldEwHBQzx
 twPV6CHvGu2Tps0LZkj89lKMokZaLqlp2J86Jt/omnF/FnMPVcsou+yqDl+UjtBxgabS
 2IeyxZL6SGFT/NBGdj1dfQDhwlquV/HQelybjMJ8QWzKy5QgoVPv9iv3CoHnSTR0Rdl0
 bUcCm36JJA8umVsuiF7cRWsp1GQcp+xKbeRnDAn3cXodFYbmbZXGGppkEnVKya7H49t8
 +THQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+5HBIQRIriXlvOVBZ5WKfK8gWmBttM9F4dnYRh3wPSo=;
 fh=dMdFMX2UbykiLaAWC9wn0drogMMZYE9vcx/dXwZQY4k=;
 b=k334YzYoCgu+M2b4bnbNrlafvWhRUjgfchioYnU9FAtNQrpcRsToCMFBkOO4Z3NiF9
 tw1RekwWxlweJsCcjdSz7OGApDYnVSwfrHkB9H4WANQ6cEM6ELKRrVC78q+/qNT7fgtW
 lysVwiak4vZP/m8G0nQM+gbDwCyeK411jMGEu1t7RFP5hlDu4GZaPPr85s6CnqE3EBID
 Bh/ig9UcBB0aSlzpr1H7bPLgxMtnmcWxuhUZtQ1AOwPtcdJYPSQ/d0Cc6JfuDsUPoKLn
 7KAo8xsHmNgS8+oZqwWtwQJe6U7f4p69ovDSYVtHaAkQ3ovUZNHmqsYkr9eoofUkVcpu
 p/7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1776686446; x=1777291246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+5HBIQRIriXlvOVBZ5WKfK8gWmBttM9F4dnYRh3wPSo=;
 b=QMALVH4naDml9DTwTVgsMkQd8Ew0tjo/w6sf8X2gSiQSd1XGWchN28dYFhXsq9cs2K
 9GZ2MedcNSo/GmIhllKaNVvYgrT/UFFfeYGg1v2ys3jKDeWHBC++mU0ZV5MPzNlPNJP4
 CAx783CTRmskMgo25D2o1GxqR/BMZ+OZkVotIxs/yat6K5CCB16oducUW55CVhRyi46e
 scilGqmP0r8cyH3CNplIWoG0ttGjktcbCgN0OnF17QjD1OOUXm8tzDYGF17ivOGhf/F/
 rBOvTySLHeWqNujirIL2MbDvFcgAHAKsgUivk8YP3oUUNJ+/6awx+gY59541E4FVlnlW
 iDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776686446; x=1777291246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5HBIQRIriXlvOVBZ5WKfK8gWmBttM9F4dnYRh3wPSo=;
 b=Iz9e0CsGuQaOboPbkB3cWEwBWVCY533xd5vBK23EBDzLlm2xGyi09AwkyOGTgx38bG
 NBSk6Fc+MTGAY0h7LFEoer7T43+kqoZpbbKAjpzVx++lpbblDH+QC3Jd0fmgYsWnJhBe
 1zEBESxURq5QaK/+opUH7eMZg8e/xelwUA16v7t7nbIJU4VegZIteQyDSzNhbuUuON+P
 3fqClsMhk1nWk4nE8dE0oBpa2sCo+FUMkHnJYmaIqGxrrAnDeeR+oSaMPDeDP3U70gqO
 88oL8W9T7Q6R/qnU+Lu0ah2TFIrIkQAnDYPb08g7UL2c2cwVcv0+jnQ2uOpWT8Dd3dXe
 jg8A==
X-Gm-Message-State: AOJu0Yy0D7siM9lQKRVMdyjjtBAc44pV2DuqAIMMKNQ/0sjIPNn8zHvQ
 29+STqHAaF9dTg/JurWKbsrfwuQY05PdI1G0zznkYvb/u3l1w5Rk2pAMDI6P4c7FAyuTjKYlFaB
 VZztUABOsfonKAkWZ7fHZlpcztrFCKZYuTQvkCl1E0A==
X-Gm-Gg: AeBDieuOJPx3o0454h8baJr6D+9EIp96lAKaAX2RFaqwaUcatX3WAxULgXUs9bO/0jv
 byR3WB2sB2Re8nJXRo0lVgK640eLsu6ZpkiToaPZHIKSo1OfiqHeThwzpx/352czjxBIxkQvOhn
 OnNh2CDhnqDoYSKwfaJ7p9mt2ZXPjFssLgqfX9XjOIUP1rnm/W2tLB21BPE6Y5yGDZhIiqeY2Sc
 IkN8Y4y+heGP1NLWE3OXUjX6rxb57J8DKkvI7t6PiT35/JN5GGvXEdP518Y/nfbPt7aWz7TlYhz
 gaK9NH9F2fXr77F9/w==
X-Received: by 2002:a17:907:3da9:b0:ba3:3091:e56c with SMTP id
 a640c23a62f3a-ba41c1b68eemr585111166b.14.1776686445380; Mon, 20 Apr 2026
 05:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260416161305.24118-1-maximilian.brune@9elements.com>
 <CAFLszThRDZ_6T09au1uzMO8pcHMDLGZGkF7hBzGtgRjRjC9s3Q@mail.gmail.com>
In-Reply-To: <CAFLszThRDZ_6T09au1uzMO8pcHMDLGZGkF7hBzGtgRjRjC9s3Q@mail.gmail.com>
From: Maximilian Brune <maximilian.brune@9elements.com>
Date: Mon, 20 Apr 2026 12:00:34 +0000
X-Gm-Features: AQROBzBfWG2AyiIi9pF9SAaVpsvc1YDqHMmCaih78rMJHy_gQzL44qflsqyYePM
Message-ID: <CAGrcQaRB-jjHNFdJHnn3pUN=kfM_rZmrf8_tijvy-wKXChFb4Q@mail.gmail.com>
Subject: Re: [PATCH] pci: correct PCI device enumeration to include all
 functions on device 0
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, andrew.goodbody@linaro.org, 
 george.mccollister@konsulko.com
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:39 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

> Right, PCI_MASK_BUS() returns both device and function bits, so it
> skipps any bdf where either device > 0 or function > 0. Using
> PCI_DEV() extracts only the device number, matching the intent in
> only_one_child().

I will add this to the commit message. It is a helpful hint for the reader.

> BTW, the TEST= format is non-standard for U-Boot - you could reword to
prose or omit it.

I will reword it.

> I notice the mention of AMD - have you tried booting on a coreboot +
OpenSIL platform?

No AMD/crater is based on V2000A SOC which in turn only has a FSP
implementation (as far as I know).
I myself have never tried booting an OpenSIL platform with coreboot+u-boot.

Am Mo., 20. Apr. 2026 um 04:30 Uhr schrieb Simon Glass <sjg@chromium.org>:

> Hi Maximilian,
>
> On 2026-04-16T16:13:05, Maximilian Brune <maximilian.brune@9elements.com>
> wrote:
> > pci: correct PCI device enumeration to include all functions on device 0
> >
> > Currently the implementation does not just skip all devices beside
> > device 0, it also skips all functions (besides 0) on device 0. This
> > broke basically all AMD platforms, since they have a lot of internal SOC
> > devices behind on these functions.
> >
> > This was detected, because the XHCI controller and therefore the USB
> > devices were not found by u-boot on AMD/crater platform.
> >
> > Fix it by checking all functions on device 0 (Linux does the same).
> >
> > TEST=build u-boot as coreboot payload and run it on a recent x86 AMD
> > platform. Devices like the XHCI controller are now found again.
> >
> > drivers/pci/pci-uclass.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> > diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> > @@ -927,7 +927,7 @@ int pci_bind_bus_devices(struct udevice *bus)
>
> Right, PCI_MASK_BUS() returns both device and function bits, so it
> skipps any bdf where either device > 0 or function > 0. Using
> PCI_DEV() extracts only the device number, matching the intent in
> only_one_child().
>
> Fixes: fbde868ba4aa ("pci: skip unnecessary PCIe scanning")
>
> BTW, the TEST= format is non-standard for U-Boot - you could reword to
> prose or omit it.
>
> I notice the mention of AMD - have you tried booting on a coreboot +
> OpenSIL platform?
>
> Regards,
> Simon
>
