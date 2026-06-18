Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68157CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFDE7849BB;
	Thu, 18 Jun 2026 15:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aLpqRbHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20788847C3; Thu, 18 Jun 2026 15:24:27 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C48849BB
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-695427c153fso1216885a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789064; cv=none;
 d=google.com; s=arc-20240605;
 b=jQxpUxZxGa30rcdJz25xVK0V0m0bye6hhpAS0nFpJL8D/aZ5gHyEnpNi0ns72C0KCU
 UWYH4S3gh5t1vPI5i5nRppCwqiPwxQMmlrCTQ++JJP8XR2k3Q2aKvwsRAcqN/R1zrjYe
 WugppLnpeQMdNkyJ2gUUo86Nz5VUXOzwtyA7G3FJRxzmqCQ+NB2iTAO/PuYSNeO/zxQY
 D/ByqfHL7OdZDcH5a2KBhjiqSPsCYcCCzFJ8WG6Dy3D5qi17XC8kaqAMQqg63FqRC6Cb
 oMfmMQODB7MZ+IE1AOlua9ry7Jg0q3ADD5gCPQoO+e0BzjlPRbuEeHvhSwgC7nxRXD9T
 aMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u8TiELQ/xkeH1cd+eEiguZ7nHuePbFZO81HEqTrMcOs=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=L0+gsWIjp3CErOX3WV2EvclWQsywO+uhaQinh/Onqp/2AkBmQzLGln0lSVXY1uGSLw
 CSCk665602DMx8w9i4hP/FvDa5S54yiTzfvnczl/pFSQFQ4cESonaYW3d9fHCzUsRyPH
 oleaUPsKAygpYszMIPUZyT2xhfDhXZUQVgc/xXXz2KVpjN5CL4RM7gebfP3SED8OC8IH
 riKzLGyPtduh2vPpVjPcLwwa8LZToE/Fwp3h4rtfe7xY7h9ogNdlp8ajyQEJGvAeGUZB
 Gjagz+JM0jYo0QIJpYkOQ6dFprXMtwOAcLORiEvdmLfA/UfNYI6Gc6hFnvEWCshhM5hs
 x8kQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781789064; x=1782393864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u8TiELQ/xkeH1cd+eEiguZ7nHuePbFZO81HEqTrMcOs=;
 b=aLpqRbHkcHJVt/KyrrUY59jFuTgLf0BB1k6R/UPLdURRJQ+941LzA2HEoq/d0Mo/G5
 cs61Ao6wg7sBk19ETGxHsESe19/NY4y5wcWYdm7ul9M/FU5qP/dW6Cg5nLmqpHGLy+eM
 cW0nHgUBjTO8dzXD9MO3tL0KGdXo0XoKA2k2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789064; x=1782393864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8TiELQ/xkeH1cd+eEiguZ7nHuePbFZO81HEqTrMcOs=;
 b=R82jJxp9O190XrMpzqgWdX4jbN/z6Z4vi7FCQqDv83lCYTCCCfNKirGKBtU9VwFWXN
 gMk3kCoDxn+cby5ZKAmuWJ02aJ5wcIa/s4AxUJx0IRZV68VtScnN4msN3U5f9pFeVtPO
 ScBpCDVIVLCtsDuCS6VUY6y2hjI/0INOZEk5Ejh8OI6dGBVa9bA6hqDdPViuuDuIbe7a
 5sd/wdIpQqaAxwyKv2NjSSbHSy+C9OzIpRu50qr8QbTd+jhVbeKf5VwGP7Oi6gwYgApq
 mj8y1uPOm5E2CRkJ55AFRPoC2iLHaU3lasg3bbJ0h1V/o+xjowC13kiJY28XVJdJQ1WR
 18TQ==
X-Gm-Message-State: AOJu0YxPHdRfqYw5onyyDGfJNIm7hh/ftTeCGQSs7ipQk6f2Qa9j7PBH
 FCkPQU0NiBhYZlynTBX1x2c84LlyDweNipNwRJbCOetADChDPvpyi9F/1UIbQKB2BxfOSCZtfGN
 qRvNMRkC8KEWsksK/zjFvZnV/pyvkycbnczKGxFfC4yg1icCvTqrwkg==
X-Gm-Gg: AfdE7clB+jsAqit+XMAY1AUzIk/NNxgz68xBAp2diU71wuGw7AbMTt3xRNKlDnmcFkL
 pDHbtmVdlWSr8ExuE4UJwx93aXMBn0pyxy2eTrERWIGAJu0UdPTlk+OcSYjroRV233JPSzV66/B
 bSBZyeZ/JNHk7QBUBk/7boDuFIQnbPSSL6ytog/VxLCq3+ctEgcBR8ze18kzfgA+CiANnppPNvH
 5H2ONM3O+2qFEi4Cq6LbBY/wBtl9/5B8ai6j2x73qKrn75f0PxIXgdiiNhjwLvrSceMyf2qGg==
X-Received: by 2002:a05:6402:a51b:10b0:678:a507:e837 with SMTP id
 4fb4d7f45d1cf-69546fe40cdmr3722010a12.1.1781789064599; Thu, 18 Jun 2026
 06:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260616063606.825688-1-dmukhin@ford.com>
 <20260616063606.825688-3-dmukhin@ford.com>
In-Reply-To: <20260616063606.825688-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 14:24:11 +0100
X-Gm-Features: AVVi8Ce5Q-688tlVPfSxMR81b0WIMuZ6n6wpPrSyiK-TWFC65TZi75X44JCNjk8
Message-ID: <CAFLszTjyLdmsHkBGrbXbQJAq49P9XwyL-8aZ+maZmySuvetaSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] bootdev: scan boot devices at each priority level
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On 2026-06-16T06:36:03, None <dmukhin@ford.com> wrote:
> bootdev: scan boot devices at each priority level
>
> Currently, default 'bootflow scan -lb' will stop booting the board if
> any of higher-priority bootdevs fail to be hunted even if there are
> bootdevs of lower priority.
>
> For example, if the board has both NVMe (priority 4) and USB MSD devices
> (priority 5), and if NVMe bootdev hunt fails (in the event of a bad NVMe
> firmware update), USB (which may be a recovery bootdev) is never hunted
> automatically, leaving the board at the U-Boot prompt (user intervention
> is needed, e.g. something like 'bootflow scan usb' to hunt USB).
>
> Fix bootdev_next_prio() to scan bootdevs at the lower priority level by
> not exiting the scan loop early.
>
> Keep the existing logging verbosity unchanged and rely on the failing
> subsystem to provide a suitable diagnostic message.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> boot/bootdev-uclass.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
