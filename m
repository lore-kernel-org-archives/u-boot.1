Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E960DCDE008
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388CB84704;
	Thu, 25 Jun 2026 12:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KDpHKr2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7393847C8; Thu, 25 Jun 2026 12:47:44 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F568460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c0868ca8738so437017466b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 03:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782384462; cv=none;
 d=google.com; s=arc-20260327;
 b=V3+BWOUcu9f5YhPTnOUlLXBVBhSFa57hLKeCffgpfEosgbk9cGburPMHb556Q7tHat
 I2UjA6LFVhsNu20NYiqEh25DRzny6Vp1gbaFLrkk/a+1t2f3vi7quhbOhUkj9q95CBwA
 EFETcyLSK6fwoY5OXXQEeWkkqHGDvHFAX7Z6KALzPL6OR9QNcIOc4If5O6aIUKkWuTNG
 LXpSwI3oKDzmM7gfMhRiXGxlJKa7FDAS+BoBC4F7TOYLHeCek81LquJVCNKExywjHWI8
 pMK1cFGouw2EFWjs/efbu+VI6rcD3QUn5X5oKAprLo86R/pTHKBDhWaPygjGOGjwUqox
 VGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/7PUgIrnQMvbEBYhOUmtByp+zt0pEX7oQJE1k2Iy/pk=;
 fh=Z4IRkRI+awWtra6wMtcpUwOl63onqKvhTWq8xqC/YGI=;
 b=mejhIuW4izom+yRXuXpHF/u3d32EAdaEoxb+6Vby/hQ5JWyEkC/OAiwFGK5+d8k1ah
 6lQ51uFac7i3JO4lKfnNKeqrlKtpEhs9rkFIergDMnpHOz0Z9Gy0+9Z2sWZA2is1qMtF
 Ei2RPrXXSeld9ufClFqTtaL7ewJyNanBBWh6iimOydm/ryqIHhXkQIG4h+YIzib/RQxn
 40H4AjnuVxlLj2AOKuxk7UUb03WMCTkBcxvgYS8Ge0Nn8L7nvMyYJeZJ0C5WTa62x9SD
 N2Z/G37xQ/fHWMmbC9PUNeAuNAd2XWTaBq9ToMhPWylpU4M4FyMTxG+8CfqEfLzvH76Z
 1XVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782384462; x=1782989262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/7PUgIrnQMvbEBYhOUmtByp+zt0pEX7oQJE1k2Iy/pk=;
 b=KDpHKr2rCqAy2GBpIPIJaLaIAsF8lCJEyQVv+vD6Ovr3Hfd1TWD82u91ke+Ko27L3n
 CwvgziMGxzqxbRaHqDxenwQ1PV8lM6At/znT4NzFsYSFPyHQnaBMe6hIB4PFbOmWVAyd
 RIyFUhE1cIigTfAaY4pSA8shNaRwkYkMLZcwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782384462; x=1782989262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7PUgIrnQMvbEBYhOUmtByp+zt0pEX7oQJE1k2Iy/pk=;
 b=LYzEUWCtoNmROubqqKQq/NSyOQxt6oUoVuDVgOcsIJOlLSp6E2+UXaldKBKIhIz6PD
 9I2V/IKf2Fpk25guJHu/6wxKrFVNPWUBHmM/fVlidJZVgImXRmrsdtAAFOud8zBNVDBy
 wdanzzGR6Mz1oueSOxwqP91waUkwADNbOW7lbr2+rSMUjBJSz3HbiIvqyPtm5ltfCTgH
 GtLRdVomdHh5W7iIRbGFLDxnWd7W7Vs16+HRehwmxPpUIbnpE7+9kVIM+alHbqjza9OP
 sH9+HHVDDH1TO2rECsGW/UeRHxsJGzWYOO4bdSJjYEBUNqISPSeMLB3+/ReKyBHG1T6i
 SygA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoauTA20HWxLggfXuywGQJ4bN8oJrrO2VPq68PoI72J5xhp0+cyKi91rVHIFLrAqo4MbkN0axA=@lists.denx.de
X-Gm-Message-State: AOJu0YyZXBJB+79YvycFPGg5U9Vyy/7Ya/COwwSkfiYWnG4SCKqOckqB
 c29pY0xoXyyOkO+f61gyqcwTUq8b9mCmHo9bxJWysuCqrhaPkBKDqhXxui+w81O3+cgg+6N8mN/
 wB430lQt0WxWE7/AB1pjgZx26UUhC3H275LG/vnn9
X-Gm-Gg: AfdE7cmHHqNFzS5NDzm1CxoLA7jrPdfUWTd+YdQ1cbyUtSxIx/ScVfFwfNyKFJuhM6z
 59MEtW+EwXPSM2Jm9fkTi1aXkuDPSHRuUaJUcPS2ASai2kdrYg04phyBdmxHYHzN5t6i4tl/gpe
 Gns6paEgnnBrtgzB0RVtz87L1MygdnlGhsWZaTh25gOR6eVSFDi2utkjm4AHWsl9J+QnWU8R5ND
 FVvxfSnT2vlE6bGZHiBLVq7GRNAUuxspur7UbvLJWEU9Vq74vDC8YWHK60HnEZRo+masgOVWPl1
 8mX5yQy8
X-Received: by 2002:a17:907:6d10:b0:c11:fa95:43de with SMTP id
 a640c23a62f3a-c1206175cfemr126338666b.46.1782384462300; Thu, 25 Jun 2026
 03:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-11-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-11-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 11:47:30 +0100
X-Gm-Features: AVVi8CcdKIBKDAUDHrLK4itmBIrrJhIGkZ9kT7I-pT6cgnZ5dVItnhjNnWBUiiY
Message-ID: <CAFLszTjkE4bN1ueJ+hQik3zoCinEUF_0S6BTch8KOLvMn+rOAw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] qfw: fix RSDP ext_checksum recomputation
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> qfw: fix RSDP ext_checksum recomputation
>
> table_compute_checksum() returns the value that makes the byte sum of
> the buffer zero. If the ext_checksum field already contains a non-zero
> value (as QEMU's firmware-provided RSDP does), adding that existing
> value into the sum produces an incorrect complement. Zero the field
> before calling table_compute_checksum() so the calculation starts from
> a clean state, matching the pattern used in acpi_write_rsdp().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> drivers/misc/qfw_acpi.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
