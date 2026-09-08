Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1937C79FAA
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 08:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58502808D2;
	Tue,  8 Sep 2026 08:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id etMp4aYg2rC2; Tue,  8 Sep 2026 08:38:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 519E88081C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788856704;
	b=rT1EDEQnrUL4y2d7JqNg2g95ZrFBbLaioqTXqu0OHSVEX540o8h8xROTOEGUdoE2DEFZ
	 SncvwXsB2F9cm7On9Qi5YCV5ZSPfIwx1kS8l6OzRpT5pyOA7pVKl6c1q6QmSwIvC0WM14
	 6ekaBM/RoP0kWT827mp1Mc96g99LrOSIDJabeOOX8+UO5aNM431xYRX5jEF87DXJKy7eY
	 ULP8JfrTj5l2xoiAZOWajie9Nz8OnDqeaXnPIc37OcvLMuS67MJfNsOSDl0867yBDyuZQ
	 +Vza08XvS+0mKRKoLmECxr/g+8pXL7HG5VKSCACMmV6HO1eaAiwQFtV+OQ/cHgnYfyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788856704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KvfMjU/rKGz0RYbCoEZ0kUeoVppM0/D/PcorhSYSRfU=;
	b=OQILBX21cz0eveq4dFtRffiezW7/mxQmx1XuIcU1SbN/d8Age+xEmRDy3OSwDG/D3iWB
	 0yXy0VLQPeBVTcfJSaFotDn1nUBa/0s3YZyWSjl0yjQJaMSDPLhZSXTZS6ZD9QFncXpdu
	 CZM5D39u7/GK/il9YbF7yUMci3rwBdRoPWAwM5xVKU77WDlMcplFTFvUCjyWuCo7qt4SV
	 5jglwUA15+Pa/ECULDIIUJ0/kot6ck5GywPpe0GoDVrvh26ES0h5O1HXU+0dA+rEbd94/
	 mDLR3QQuTBN4zvdRv9XFrs9TR11e+p9HmRdadELYvfX+jZKhlgodmbXuud7JAdY2Lvw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yelc6giX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788856704;
	bh=KvfMjU/rKGz0RYbCoEZ0kUeoVppM0/D/PcorhSYSRfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WjrPaZwI1ZqVwSEzHKKASAXclVJtlzRSHOyjY0Ph+wqK9q0xtgrB6y/Obbs2kKV+X
	 KpObYmd2eTqL800XSmKPYGb/PSpDVYCbD5mkd38YBYQA0zD8ICUYRuPloLNzpCGua3
	 D6Ce0IafOuEydFHg2ZChNAZhqwXT3sFjmEVuVMsce6H3vESbXMhsn6ikjPXiyX5P91
	 NHNplE2HRDOGdrQAucCkEZ5VH3zKkqv/uyjCdLhI3C2vSckSkdhtuR7fmHtTeH8Y4b
	 0KfUc1AYFvWzN5WaBYLNsa+yPrkPtbHUa3fqErvOx8OXBhkHu0ybQiY+Up3pERE17C
	 bSKURm1OYB5EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 519E88081C;
	Tue,  8 Sep 2026 08:38:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 694C7970
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 08:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EEE9808D2
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 08:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmQd9ClFs0yD for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 08:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E6F52808C8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788856702;
 b=ROcd3ADPucA3KZS/WxseXgh4IQtrkpdR5/TjQVXMVlRohoc9fCCV7s51/Q+HCg99w7gB
 CS5IXYhvlW757TpUYdWUxGgBML54zkx2NOnziSDZGHcmuljky9wfhGKX7Ax1VLZSlnqvh
 lqcT3T2DClXMeZfpD1JwC+jc4qyfTMJ9QcYTAb6SIPQwwi22WxqHcScUb9sLbRqi8EWK7
 gebx3gNdkweHYGymiO55aKOh3PsB4zQxB/TqFOAufHzxvrXx2098GoPhTkoYjs2fKJIAN
 4wyXajyc1BkiqcH1yBOOmze6Zl3i6xg8PCsJu+jddaZ/cA1LWmH4sJE6j6AZbAZBEMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788856702;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=KvfMjU/rKGz0RYbCoEZ0kUeoVppM0/D/PcorhSYSRfU=;
 b=mLcpJuE3+f76iFa7mWgpVqUSn9Wf9reHixKCS76hZXsc2FdxFot55ys6LnorVfc9AJSV
 9FVmBrqH5LMXmqQpK4Uj5mcI6sY+A7ksIbrUF9eJSqKofq4EtD2iiKbf7YOmlxipwQ2V0
 Yq6TFWE0W+RxZVuRGpx21WT31Ys/fVaRTgGXzl3Hp8yulxxdAVAqAjSOnM560ZeNw4hZk
 kD4N2U1FUSLospNiwyh2CV9vuWFwAjcM7/eQbGLrp3Uo6B05U7td8fsisqOchArdTqoiT
 LDfVK6IvFqQ0M0PoiVJEJTlAaMVQrtdyo51Wor4f05zOMy0CcwfHwwJo4Tr9xwZj9Ig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yelc6giX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yelc6giX
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6F52808C8
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 08:38:21 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-867a943b149so64917947b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 01:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788856700; cv=none;
 d=google.com; s=arc-20260327;
 b=eR5zduWC7Q7R1HEUu+5FMos3jdMYB4oqcpZqhwBoeDAfhHMnk/VdvVl5PuiaZLESe7
 xp/Kyh0eoAeOHDVuoNrrihgb2WUPvU8ro2hqPy+O/K3UYbJ0wFsHVA69ZakakkNE/FcY
 su+I+kzdwCO7OrZSTF6xUioQiBLIFvd3G5lgx1E9QM2e/0mgOEj48nJxQ/Heh6O47pzn
 i33JBvzK44+rPJ6U9ZRPWv8IQtom1n+djFRRPPIhEU6vTEXJ+uNL4EGc2dEbeQvl4Azf
 SZ78Bmrm2E4KpP6Fpz2IE7DtZfjF/S0kGwnRuumtmblm4uUqVqNX/lrXdWhOpSCDEyOV
 vdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KvfMjU/rKGz0RYbCoEZ0kUeoVppM0/D/PcorhSYSRfU=;
 fh=29c1nrkqZnbQeYBsMI6n2BOHI0D4qvssFPI4NAsSB2g=;
 b=ks3wmYNM6uFOngtwS5TWMGcVFw0aFAjqL24L1kvJEOAxN/7B9wJoNdb2GEZRUjkSNL
 Yl9VLzStZOvsj3UgrUfINwABWMoJXF99t9rMKlU8IRoGQ4v0i702qyC2bhwujQjDkajF
 vR8ft3KivLNdjjV+Q4oeCX3mdih5m/ppwc8x4S+2YB8swQNqpbLQzmkK1ybCXF15HHKn
 ACJEDF2fl2eHxLb+lTuAmuyt6/uNMHTgcVGlD0wd95/L2zaJNR0CSYzxTmRGkgbr2BRD
 o+Oa3b6uK3s9sqR1EnTNk/40TC2YR5rSymhsFIgVDp/yf447qYXYoRzLljhERU+vHmrf
 8G7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788856700; x=1789461500;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KvfMjU/rKGz0RYbCoEZ0kUeoVppM0/D/PcorhSYSRfU=;
 b=Yelc6giX7i2qcEePGUukR9mUbARqy5xqoDaVIJYE6qqQ+auKdn/4jkVlb604d9hPyT
 prAgrsmZqOVBTUsqpUzUl7IQUa+eQuvExAVdY9EDNJJhBEvvEgoaYaAoLZkAnS9uHDr2
 szUt2Z2C3eMUkuPoz5Qd0Z0bw0CYUCzQ66/Gj20yeVlAZkIn4qp4bHNFNjTK5+6UfL7y
 5KSYVxgLW0JUvV/u225Vt+qGmm4AIdcSBn7bTRP+Hja1LfwDHlxf28bg4XaaqMOJeByG
 BFk0UaMovAo5Tv2qpV6oA8liw+BcQtsfupMKq1Nj3Mg7hjBif5nBVJXinTrP2mDJQY6G
 jYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856700; x=1789461500;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KvfMjU/rKGz0RYbCoEZ0kUeoVppM0/D/PcorhSYSRfU=;
 b=W6ARin2X+eKJgRyK59CQaLTByZQMgutJ4Tc9VCVT29cwIQu5VDJCa7phx3lRTkqWBg
 PiUNhAxGJI1IlijBEOVGuF2cOLSKMyNvt5hQtkC+e5l1VDNOMZr6nbWM2t0ClBpA9RxB
 tJX29IVgwd96JiY33sCfc6ZLaCKEWZBNLYe3HyTHBoWHoHgdaDXY4PPYKlnSn5v54PAQ
 QUMYuxLBQ+Bz1r78eTanwbRR/dgDw9j8YYN3/TU/gHlZlfTg+0LIJymCrcu8CMF8IM9X
 /sPVIS9l4zVnAUe0ujkoMVISR4lDak1VJPIuEx2SzPdqFpq2QYe4QxBZucqcTafTrZM3
 XSaw==
X-Gm-Message-State: AFuF++kseHVspsk7kb9VK/rxJlwJE0lvxRym/86vbJf2/gIj5ItdnkbD
 QOfibD1ghOJ0y86aUgu1aHzL474NHIV+OjqOX/1TbuvVP5/nso88P5IQq4HKLh9jjwzlb3Nd42b
 IahbCQciUXCei3YRFAv2uKvIm5jmim9D9I/UJ87zg5A==
X-Gm-Gg: AYBFou0Mbwzz5m9HV+9CN3c8hXqjBFtouI4gE+MDsq1fZVzoEexkjfvJsaWKKMbHpCv
 1D8mnI6fmo4i9VW4CmXR4ULar+zoE6dW4xzoPdswRJjAbBN/bIArmh9ogr4G1C4z4Tc39p+xcsC
 uuzuYEiXyCQDeV7DxtZ5gzdgDoNwD7es2565Spw1BEWcsYweOxEcQANeiAuDKY35T9lcjGvGTJM
 WPvkWs8OL1yWErxRC8//chTjYzqYtWnwRY0QChhNMwCFHcwdCJDRWo5tm5PMz4MiBuTlj9aJVpL
 mpuw4itUV5Skl2tYslhEI2xUy8AMULokaSDFh8x/Y2T7z80po4hJPuf2ZHOOfcaun+NR84DKzI1
 Bw3IA1+jOKoJ5eVSJJBx7x9sEvlboRMVFXCDCZV7ZI1j2TLkMauolRsDttSoulFU3UTAp72+6I6
 7vGcGUJc8JRnsEkgn4OE51km++gX+gFssmTHK/AqqR0StljRaobNPxMUEBvMzwX5ZVP6chbwwZU
 VdhEv878tDKFvSFplCAcEbog1+MwOByt82+m8COoYm/l8UZG8XLV8IgyppvFDU0JpUd2Qvzowld
 4FYBIa04qCryybxpRF6p2ibSBtRhNLcDEWfWvNFP0GycsT2xh3OPmahlFoTBu0SvkaAtLnQ30C7
 6BRG/vA4QCPUHZOpw89a3caOeE3aV7NDRgZwXs3ogctW6
X-Received: by 2002:a05:690c:a599:b0:873:5bd1:98c7 with SMTP id
 00721157ae682-8735bd1a096mr54377927b3.57.1788856699959; Tue, 08 Sep 2026
 01:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 11:37:43 +0300
X-Gm-Features: AcwNN1WN65qqLJ8bcj7pJozF5OeUECJUnLWtTdtBMXGj63Bvls3I8LKLCyExbmA
Message-ID: <CAC_iWjKrYxidFNW9MWuKT2DKynD4OSirA-jprGQ=NJYUxPGFkQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000027d2f5065af4a8c3"
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

--00000000000027d2f5065af4a8c3
Content-Type: text/plain; charset="UTF-8"

Hi Carlo,

On Thu, 3 Sept 2026 at 16:10, Carlo Caione <ccaione@baylibre.com> wrote:

> SystemReady DeviceTree can boot through the UEFI boot manager without
> going through the per-device EFI bootmeth. Use firmware_fdt_stage() here
> as well so both EFI launch paths install the same firmware-owned
> devicetree.
>
> Keep the firmware-FDT size in an ulong separate from the EFI allocation
> size and retain the FIT filename for diagnostics. The precedence is an
> explicitly passed FDT, firmware-owned FDT, Boot#### load-option FDT, then
> distro/ESP FDT. A configured source fails closed, and assembly failures
> are reported as EFI_DEVICE_ERROR.
>
> Route load-option errors through the common cleanup path while adding it.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  lib/efi_loader/efi_bootmgr.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 6b5dad21b06..4049ebbc0dd 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -14,8 +14,10 @@
>  #include <efi.h>
>  #include <efi_device_path.h>
>  #include <env.h>
> +#include <firmware_fdt.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <mapmem.h>
>  #include <net.h>
>  #include <part.h>
>  #include <efi_loader.h>
> @@ -1296,7 +1298,8 @@ out:
>   *
>   * Invoke the EFI boot manager and execute a binary according to its boot
>   * options. The devicetree precedence, from highest to lowest, is an FDT
> - * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.
> + * passed in @fdt, a configured firmware-owned FDT, the Boot####
> load-option
> + * FDT, then the distro/ESP FDT.
>   *
>   * Return:     status code
>   */
> @@ -1306,7 +1309,9 @@ efi_status_t efi_bootmgr_run(void *fdt)
>         void *load_options;
>         efi_status_t ret;
>         void *fdt_lo = NULL, *fdt_distro = NULL;
> +       char *fw_fdt_fname = NULL;
>         efi_uintn_t fdt_size;
> +       ulong fw_fdt_size;
>
>         /* Initialize EFI drivers */
>         ret = efi_init_obj_list();
> @@ -1320,13 +1325,30 @@ efi_status_t efi_bootmgr_run(void *fdt)
>         }
>
>         if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> +               if (!fdt) {
> +                       ulong fdt_addr = env_get_hex("fdt_addr_r", 0);
> +                       int err;
>
+
>

Any reason we are doing the _hex variant instead of env_get? Don't we want
to bail out if the env variable isnt defined instead of picking 0x0 ?

+                       err = firmware_fdt_stage(fdt_addr, &fw_fdt_size,
> +                                                &fw_fdt_fname);
> +                       if (!err) {
> +                               fdt = map_sysmem(fdt_addr, fw_fdt_size);
> +                       } else if (err != -ENOENT) {
> +                               log_err("Failed to load firmware
> devicetree '%s' (err %d)\n",
> +                                       fw_fdt_fname ? fw_fdt_fname :
> "fdt.itb", err);
> +                               ret = EFI_DEVICE_ERROR;
> +                               goto out;
> +                       }
> +               }
> +
>                 if (!fdt) {
>                         ret = load_fdt_from_load_option(&fdt_lo);
>                         if (ret != EFI_SUCCESS)
> -                               return ret;
> +                               goto out;
>                         if (fdt_lo)
>                                 fdt = fdt_lo;
>                 }
> +
>                 if (!fdt) {
>                         efi_load_distro_fdt(handle, &fdt_distro,
> &fdt_size);
>                         fdt = fdt_distro;
> @@ -1339,11 +1361,14 @@ efi_status_t efi_bootmgr_run(void *fdt)
>          */
>         ret = efi_install_fdt(fdt);
>
> +out:
>         if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> +               /* efi_install_fdt() has copied the devicetree */
>                 free(fdt_lo);
>                 if (fdt_distro)
>                         efi_free_pages((uintptr_t)fdt_distro,
>                                        efi_size_in_pages(fdt_size));
> +               free(fw_fdt_fname);
>         }
>
>         if (ret != EFI_SUCCESS) {
>
> --
> 2.55.0
>
>
Cheers
/Ilias

--00000000000027d2f5065af4a8c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif">Hi Carlo,=C2=A0</div></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, 3 Sept 2026 at 16:10, Carlo Caione &lt;<a href=3D"mailto:ccaione@baylibr=
e.com">ccaione@baylibre.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">SystemReady DeviceTree can boot through the UEFI=
 boot manager without<br>
going through the per-device EFI bootmeth. Use firmware_fdt_stage() here<br=
>
as well so both EFI launch paths install the same firmware-owned<br>
devicetree.<br>
<br>
Keep the firmware-FDT size in an ulong separate from the EFI allocation<br>
size and retain the FIT filename for diagnostics. The precedence is an<br>
explicitly passed FDT, firmware-owned FDT, Boot#### load-option FDT, then<b=
r>
distro/ESP FDT. A configured source fails closed, and assembly failures<br>
are reported as EFI_DEVICE_ERROR.<br>
<br>
Route load-option errors through the common cleanup path while adding it.<b=
r>
<br>
Signed-off-by: Carlo Caione &lt;<a href=3D"mailto:ccaione@baylibre.com" tar=
get=3D"_blank">ccaione@baylibre.com</a>&gt;<br>
---<br>
=C2=A0lib/efi_loader/efi_bootmgr.c | 29 +++++++++++++++++++++++++++--<br>
=C2=A01 file changed, 27 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c<br=
>
index 6b5dad21b06..4049ebbc0dd 100644<br>
--- a/lib/efi_loader/efi_bootmgr.c<br>
+++ b/lib/efi_loader/efi_bootmgr.c<br>
@@ -14,8 +14,10 @@<br>
=C2=A0#include &lt;efi.h&gt;<br>
=C2=A0#include &lt;efi_device_path.h&gt;<br>
=C2=A0#include &lt;env.h&gt;<br>
+#include &lt;firmware_fdt.h&gt;<br>
=C2=A0#include &lt;log.h&gt;<br>
=C2=A0#include &lt;malloc.h&gt;<br>
+#include &lt;mapmem.h&gt;<br>
=C2=A0#include &lt;net.h&gt;<br>
=C2=A0#include &lt;part.h&gt;<br>
=C2=A0#include &lt;efi_loader.h&gt;<br>
@@ -1296,7 +1298,8 @@ out:<br>
=C2=A0 *<br>
=C2=A0 * Invoke the EFI boot manager and execute a binary according to its =
boot<br>
=C2=A0 * options. The devicetree precedence, from highest to lowest, is an =
FDT<br>
- * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.<=
br>
+ * passed in @fdt, a configured firmware-owned FDT, the Boot#### load-opti=
on<br>
+ * FDT, then the distro/ESP FDT.<br>
=C2=A0 *<br>
=C2=A0 * Return:=C2=A0 =C2=A0 =C2=A0status code<br>
=C2=A0 */<br>
@@ -1306,7 +1309,9 @@ efi_status_t efi_bootmgr_run(void *fdt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *load_options;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 efi_status_t ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *fdt_lo =3D NULL, *fdt_distro =3D NULL;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *fw_fdt_fname =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 efi_uintn_t fdt_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong fw_fdt_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Initialize EFI drivers */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D efi_init_obj_list();<br>
@@ -1320,13 +1325,30 @@ efi_status_t efi_bootmgr_run(void *fdt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fdt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ulong fdt_addr =3D env_get_hex(&quot;fdt_addr_r&quot;, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int err;<br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">+<br></blockquote><div><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:arial,sans-serif">Any reason we are doing the _hex varia=
nt instead of env_get? Don&#39;t we want to bail out if the env variable is=
nt defined instead of picking 0x0 ?</div><div class=3D"gmail_default" style=
=3D"font-family:arial,sans-serif"><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D firmware_fdt_stage(fdt_addr, &amp;fw_fdt_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;fw_fdt_fname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fdt =3D map_sysmem(fdt_addr, fw_fdt_s=
ize);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else if (err !=3D -ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_err(&quot;Failed to load firmware=
 devicetree &#39;%s&#39; (err %d)\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw_fdt_fn=
ame ? fw_fdt_fname : &quot;fdt.itb&quot;, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EFI_DEVICE_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fdt) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D load_fdt_from_load_option(&amp;fdt_lo);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ret !=3D EFI_SUCCESS)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (fdt_lo)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt =3D fdt_lo;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fdt) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 efi_load_distro_fdt(handle, &amp;fdt_distro, &amp;fdt_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fdt =3D fdt_distro;<br>
@@ -1339,11 +1361,14 @@ efi_status_t efi_bootmgr_run(void *fdt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D efi_install_fdt(fdt);<br>
<br>
+out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* efi_install_fdt(=
) has copied the devicetree */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(fdt_lo);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fdt_distro)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 efi_free_pages((uintptr_t)fdt_distro,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0efi_size_=
in_pages(fdt_size));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(fw_fdt_fname);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D EFI_SUCCESS) {<br>
<br>
-- <br>
2.55.0<br>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
family:arial,sans-serif">Cheers</div><div class=3D"gmail_default" style=3D"=
font-family:arial,sans-serif">/Ilias</div></div></div>

--00000000000027d2f5065af4a8c3--
