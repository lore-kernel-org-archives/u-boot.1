Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D24C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 11:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA4E84832;
	Thu,  2 Jul 2026 13:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TfpHdX/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C28784857; Thu,  2 Jul 2026 13:16:16 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C0B843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 13:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so1178557a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 04:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782990974; cv=none;
 d=google.com; s=arc-20260327;
 b=XcTDXalzurHyEKJPGVpkGSegQmmNfCWSU903kgerUF83dQMv+ZAzLaSbs8NtaqqMr8
 od1HSvsmLgbCEoPcdZaeVdW27w/ugKu6L6iQZALE+TNV1VFiMIo+mCFMzD5EGujLlj+9
 /abg21JSnt7PCx+Q6G74TP/AKwgV210sb7cZ2Ealgkb3ur0LZuQejBSo6KAgNKz1SwH9
 QBQq1XkvssXZO7RNGZ+8qP9csRwIz2TNemlYZD9SMFHE7KRNhv5NLbTxoP8EYo/K7Uoq
 AvFjScPCRbXywnkXTPmikOZ2zrX7RcU5bBwigbHO5hBiB6C2qsLcKIn9X/5njt+8UK8V
 1I+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jiqDtx+CK6Ifb8oFEvvAKIQNxCemBeIYot4QbFWaiN8=;
 fh=Xp5J/VfCD0qkvaCCCQEkAYzbOL7azc4qfGk27KxUsjo=;
 b=X8A7LYZUSkcTaAvnJ74o9/twg54K062gkIvQQAYcWuiiH+Lm+QBhWRye24EZXzhvUP
 ELfYONGjK3qhZXSnlRM+yUuSLQY8HmpZZ0VS6P8xpATEDjynfYiJPVZsofjfxU7j96ZG
 J12oaiz2m1+BE3EYWo1SFSefk4/tm2KdoUnWTDBqdlCOrb1ed7AOFRVlKPY4EzAIT8aI
 S+e69J/5bNXZpvaiXPRR9cRxzKmhQt0+uIb5oLurtAhsdFRVKLnULP83FbuHJRVzjyaF
 wa1JWYoGKxEpv0CtuNN8bQVHj05MwvVDJARaluw+pm/Ac3RUUrhu+fkJznnkLJKmIDI4
 33jA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782990974; x=1783595774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jiqDtx+CK6Ifb8oFEvvAKIQNxCemBeIYot4QbFWaiN8=;
 b=TfpHdX/TY8xQb/fTEZzm1MZiIMUs9mVj30fNeZpqcQEqE/wgnOehNxvrQ3MCa7kCrc
 pm0z6qurZaAXVvca+LGy8NLjhFqG1v+mQe6gHEFHtDpve0GvXplfSqOveATRbIoLYLTf
 2VlAviN0sa8QG53NuTLXLU9W1iBxAcxc03z9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782990974; x=1783595774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiqDtx+CK6Ifb8oFEvvAKIQNxCemBeIYot4QbFWaiN8=;
 b=K7Vm1bW5LULvETxqU4h0cFlbEbJofgjOjwZmE/uuQZTBk/noyC/5DxUzaQgUqrwaoc
 t8qoagSaUmbs+QxSkTAhHi2FeLZNGSEiDXa0N/CsKLYI4Exux9X1asatSOJPEBVQ2qwZ
 xX4hLrRk5VGmSN+4P+gInRYb0EBk0nnIRfwY4ARRU5PD4GECRjE02A0m4vEyH8n3Tmsu
 ioE8vOtH7kUDzP/4EGJM/q2zETCNCyKEQWX4bvJPD9ZugUIycCBkM8jh7Q9PAisIWR1o
 A5uzuKBAb0mks6Wj3I9eC5d+DCX/ZnhR29s6Nk4Q6XPU1tFyl+b0kIYlRwaJ2TBAzi1i
 11dA==
X-Gm-Message-State: AOJu0YygsjBRQ4wNWcjAGJQFCw4KggS5wu3mVSMt1lJwNn9N3ve5l/d9
 5Qq25ZiC2vPd5TAG904yeGaTTzaOzGpdH1BF3xu788iQrWiOE0FQCxzK3bmPfCa4CiI29t01o+Q
 nw/Xu1K9yTIm841WhF1zaRPVfVkWxjnyZh/xIX/t2wQdrliyI+ACnNu1t
X-Gm-Gg: AfdE7cnNSlDCrx8xsvLJ+FAn9HR/Ls40vzPFNiSGnpjEW+lWyKBWw52vb7ff2DQRVGx
 YGSJlc7tYFMz/9dtgN+/ysY61ZFhj4lY1TYDtIi69aFXQOHuC6Qbl7QZjtlhc/krFwfJvEB5U8w
 o9lebT39kQQgImO/af5Fqhjv2ytLQTwfCUd0XiMPJHqoAE2PKbl+lTSqm9L0Xe0JwyFEH4b3iXn
 yHL0yrtmw7Cw2esw1b/WyOlkt7uQITNiAiN+rxaA8hppdZbFrkbNQkynHcVLkvtnZc2QKsHSGQU
 2bXtAzm8
X-Received: by 2002:a05:6402:43ce:b0:698:3365:f950 with SMTP id
 4fb4d7f45d1cf-6989f376d62mr2330741a12.21.1782990974020; Thu, 02 Jul 2026
 04:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260630084112.13259-1-marex@nabladev.com>
 <20260630084112.13259-3-marex@nabladev.com>
In-Reply-To: <20260630084112.13259-3-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 12:16:02 +0100
X-Gm-Features: AVVi8CcGL_8u1T2ATKkitw0qslgBqu0oadFIFGjRQU-L-2vvVDhJJRHviiHUxJM
Message-ID: <CAFLszTifk+aaMhiDMypFnY-kOWwXwp0k2zyQohPR2xVH9aqB+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mn: Drop nxp,fspi-header-filename
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
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

On 2026-06-30T08:40:46, Marek Vasut <marex@nabladev.com> wrote:
> arm64: dts: imx8mn: Drop nxp,fspi-header-filename
>
> The FSPI header is now generated purely using binman, drop no longer
> supported nxp,fspi-header-filename property.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
>
> arch/arm/dts/imx8mn-u-boot.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
