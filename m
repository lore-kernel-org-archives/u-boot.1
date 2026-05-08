Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4F7CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7152E84DD6;
	Fri,  8 May 2026 20:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gb4gMuXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5A384DDA; Fri,  8 May 2026 20:05:23 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C330F84DC3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bc188a20e0aso309181666b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263520; cv=none;
 d=google.com; s=arc-20240605;
 b=FdxdIvgZ17lLN06MkUMMg7Z5aU8S+i5QfCOSEcS99m6efkGDhhdd5a1U2fyaf16sqV
 9mUNjKkifdWFpIoHD27mcdqmvReMHJXevnIOaKSkxgDTEkxaHwdJP0ZwE14DnsmrniyR
 JYDRZo6yzhbnUrjR+sGTuFCXYborvLuO7NCN3oGqJuegj6Xj6bvtyjM7Dm+Wha0zm8bd
 FiUxM9OnBnOAgGUV6h6fq9d8/u8wVdVx3WpNu9lUl88d5Rd/P9gZP5l+LQoI8tPNB3nG
 VKYrJVbNoYt5++0FUXHl0kEpeQ6SqEUYeazyaF7sxTnJrGk7mi7O3cU8XoWXrklZP8wk
 hGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ut+/34DiveYB3DPdD5r0EHXSEWi2n9jvJWbo94AYoA8=;
 fh=Haw9auYRizrTzdwgvcYXgQOKqkQSoPyvIuf+JkUjTrc=;
 b=hjUF9LpbJcB0XlzlvsuBcL7XfSsCuox3Z2mIWGHHHMvyHPpjrEmRRZnnKA+y46Ib0/
 jm371Q11xoVfrbGm9PJIw+8Sb/wHi3RIJxG8MP7nt9KsZ3YxUhnXK96GVNYxyyFNuvuD
 YUK9CQgp2/KlLBWS2WhSDngTi4xhQSfZ1z9+2vUxzHwc7iry4IeAyCsu00tN5WahEY2a
 RzhUrBwcwBejD6Gf6M7jjvJbA2RiE/oV3YVaJHUYC5WZ2QbqmxWmeWP8lolMGG4bPmmJ
 94l6OzDYq31Kk5fI3aOLR1556P4iWYPARyRRQRROOhtYOmudhJNdSEbPyy2gT3APwMu8
 E41g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778263520; x=1778868320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ut+/34DiveYB3DPdD5r0EHXSEWi2n9jvJWbo94AYoA8=;
 b=Gb4gMuXH0nySEF/0Qj5zRoBjChqb7uSvE8mX68z500OXVYzAy1vNSH7R8VjsD/A785
 2X66rjRhhFeNAWladfKRxS+tQfsGFAb6d/UDSGJAhoaOpNBXsBGHAUcs4oIA+Njxc9Lb
 gO9/WliX965noQtDCtApcnFDaXfcRqzOwL9iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263520; x=1778868320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ut+/34DiveYB3DPdD5r0EHXSEWi2n9jvJWbo94AYoA8=;
 b=Yo0krWqkeA+pAdNwxZ6WONJzrZhs5X7EQrnVTY8fKhiqs2bEL29N1OaPwqtWPEd/pz
 faTqPBYtwA3Mpul+AV4WQu35iXaxbvoqCQXgUpH9LCSkLLBWMuW2lIfxa7BiMubB31Jr
 BVPCHtbUJZKI9TlVsDz/CA1lY9Qkhs6mpzoZ1u8WsTS7+n+THKReEesG4d5i68StKJy5
 pAnsk7B7qmQ4E1esrkjdVgtyAzKeQi7YM3ZDWj1S94d/Ebb8+MCifeLEu2Q51KesDNA6
 Fic9lX6Ig8BpHmOMkRSyHjjjyzMarpgyf+0oVAI62S/EuLBxHbXTyRCtiov/Xma389uf
 0GEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+24ZIdStFmXdGiLo2NFGitoh/V8y31ZusgHfKdZdHW+W3uDQYJLf1ZMjVNxSFmDFS0z2BVvaY=@lists.denx.de
X-Gm-Message-State: AOJu0YwLCG6ToW2FbxnIlptVd1TPCkT+IcUG3LLxjJ9UAWWtVzoL8Ktg
 M19gte2Fek/LwpwGm/dN8ANxpJpcFydSPIL3iW5+A0la+vqqduNcEq3eh/KRVXyAOqAgK+VRJAq
 /dR3yYxUgzh9q1lM0R/9PqkXS+R5BMdiRqrJbUfjAMITNiFmYnVQ=
X-Gm-Gg: Acq92OFvDCQnZdqi//KBScZQM+JtrzFgQzwaTI6IYLwXPMr2Zg5nZosffABt2FbrCwG
 wgiGnFZUDRVqTtJ337PaD7gEDjpH1GCqiq5yLrMSbTeJLgB4483IIfjXJqWlmFI3UKAKCAQpHWG
 0lX4V6oCVuHxJ5CnHHRv+NWuEtjtjuZ/RCRAXVMIYDFGvOVKHNahjzuyXP1MbKGGGbnfe09cANx
 TZ/rhwE4zOEwOtuC50YTyqha5Zi9f1GuswGgAcvUY4W+B+a2COjDuUXlCj8YsPdwk8AVn7oB6JW
 6LKDJg==
X-Received: by 2002:a17:907:3c83:b0:bc3:c753:b03b with SMTP id
 a640c23a62f3a-bc56ae2a7damr833876166b.3.1778263519915; Fri, 08 May 2026
 11:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-7-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-7-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:05:06 -0600
X-Gm-Features: AVHnY4J3U9kcTS8BJlKeblGNGGbIjlN3iYofdIgf5-yOUERSgzxqm8v0iwS9VwA
Message-ID: <CAFLszThRxKgrG2cqq1KpxrgVBdTw_xsX7Gr2BKMRvH_3EYmM-Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] boards: tqma7: integrate sysinfo_tq_eeprom driver
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Alexander,

On 2026-05-08T08:48:28, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> boards: tqma7: integrate sysinfo_tq_eeprom driver
>
> Probe the TQ-Eeprom sysinfo driver during boot to print its contents.
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 7 +++++++
>  board/tq/tqma7/tqma7.c               | 4 ++++
>  2 files changed, 11 insertions(+)

> diff --git a/board/tq/tqma7/tqma7.c b/board/tq/tqma7/tqma7.c
> @@ -14,9 +14,11 @@
> +#include <dm/uclass.h>

Reviewed-by: Simon Glass <sjg@chromium.org>

Nothing in this file uses uclass directly and you should normally be
able to use <dm.h> to get this header.

Regards,
Simon
