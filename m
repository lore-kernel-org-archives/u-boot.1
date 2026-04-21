Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D68F94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1916183AC5;
	Wed, 22 Apr 2026 00:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SxG+2ig9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B321D83AC5; Wed, 22 Apr 2026 00:48:56 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E451C842FC
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso169257166b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811733; cv=none;
 d=google.com; s=arc-20240605;
 b=es+koEYQZ77v+X37usXF/AvdZ9am7TcrkbGWPxUvK36yF2eDtmdThKY1mYQsBY0Ntu
 BPIDtj4TOxQ+RYM1zdKgOPoLuk5tHwNM87cAQKqbB7+YmgwOsTW5F+fnMNLdba8PKEdQ
 F9fTRNqtkCue3JOnxbPBBCsxryoE6dbbUnz30ya1QshQzT6pqJhGEBAz3qQLaisc3y/5
 28VmaOI7Ko6Jey1elKlx+4jrNFxX+Oed1l75xhmd8T0wn2h5fMcLbX8q3J9GxIRWeVoi
 1ZrrxC3v4mNvxHxQx0NH9mzjChQ+lt+R1q7gDvjyjPnJT2eNwV5GTtWpVLTB9rESJcdt
 zMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kvWKAbGk2NEMKFfkfXNG8PlpuqwkUGnybDNlrXRWis0=;
 fh=Iu3q8pU/HxKUxgIX3o2NhCmX5QQC75oOn2rrUk5yUdU=;
 b=P72pzlYb0l7OiZo0A4Nzl5o3CQ4UY+OUQN0ZtNKJxUXfpye44UHwQM77uSm8s5cOM2
 yWeOGBM/mb5L+kLV+nPrET2MbJWVtUrz1dVc0KGZz5Vwd1+yq9COYZR72FnTqaDZYtYh
 x83x2LqLJXG9KF0u5qa79wzsQGI6Dp2CSC9/AKYvNyXF7V81wd3jdNTWGg1H+deASS3t
 FBpyfGeAwhqAyWHEVn2OjjsBvBVg2EpFoautxHo3tgA5jfLWWN7BPVOlr4XAb2WBc7I6
 jZvv825MRLalaxMD1S2nEaXTXR44m9E6DiAM3vnZz3j1hxvToWHkrCcCFxSj0yEjtv83
 xu+w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811733; x=1777416533; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvWKAbGk2NEMKFfkfXNG8PlpuqwkUGnybDNlrXRWis0=;
 b=SxG+2ig9gSHkQt9DB82dT37qvN7H0BHveUrgmgD6xMC8Ig6/kq9Ms62eIzl7bLdW5F
 KssM9Q1U413LyM5SoyUiwcnFXDh7/4bjtRHEheAhzBb5pnG7kQW/p0ZsOAgEdYr9UjzI
 OPYYKtLYs+Z/ED2VCnrG7XkBCvv36lS94EVmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811733; x=1777416533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kvWKAbGk2NEMKFfkfXNG8PlpuqwkUGnybDNlrXRWis0=;
 b=izGmO1dg96F7D8zC3LJN2V5I/pcVLM7yrmjm1x/zHpm98oUZPPVQFtwxXioYY5HIaI
 CDz/72p0J082yZh8aEaR06LFaT1kZ51q7ACAecLYDyR8Xhc0OFUQPxinor2RkaJGFvTq
 kWECAPOyhCJ/7nKPiESMQkYXteuZHNDU9HZJNyUf2vgd+2gHkmWDyb6FxkQLeQhjPEm0
 /BKXsC9bFoJZEgtG3CZDqJhnoGnJl74TcGF2j5pl0o+XSe5mL6Dno4tW11jNBG8nmVlh
 PZJjD7mYZ4MloU6rqiBYa5qt5FU5Jp2Znam9AyvXgoRQRqK2PZn8UAMwQScse2bIIpCZ
 BfsA==
X-Gm-Message-State: AOJu0Yx6j7SN6CSlWOKUe651Bbd4xPDt5DYxIq/OsaoSyK5Y6EQsh8Ws
 370AbnimodMAOvfAousdGQ94uy8ZIDpsy46Z/1MJOh+yMfD7fXFsw0I0STeer//tM9ZgVMo11jr
 jS1zvIxTxhWZlCcvfYdmKsaHQRsByItXaZH3dOYl5lJ/TPMVPTE8ywQ==
X-Gm-Gg: AeBDiesRw18HCvkQK9cD0TwkMoeIG28NBQai8HIcbb5nqguPUDg1Afk/g9Wy8QCees6
 GoXpRysS8Ug0PuHX+NwPaqRv6OuxPowbPI9UicGDajG5EPsOq6NO0Gz3Fs6A6RzmqjyihdZCNed
 /wjDhh42yNjLxJuQYUp23eDYJDC5/hX1FkMLdpy6uFpXLK4apjJlIcMpgFt8JKna9TF5/tXMecj
 iSaPSMIOTjGb6xflAL/MrVvVhb4cyvwV/E0UraSVKCEl839g0jkqskxbBnfCjN4ELELg0avZ5k1
 2KV7vZEKyrrGa4kzGOwE
X-Received: by 2002:a17:907:c30a:b0:b9b:7bf8:800b with SMTP id
 a640c23a62f3a-ba41afe998emr941114566b.40.1776811733267; Tue, 21 Apr 2026
 15:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:48:36 +1200
X-Gm-Features: AQROBzC6W9Vc-RueIov-Kg00zDfhHVouMOFz02JiKxFS13ZzD98ja3DAOQ0UONA
Message-ID: <CAFLszTibdFVBG+jVpJjFsbWocu=WgABas8r8cdB1RAuXAX_8cQ@mail.gmail.com>
Subject: Re: [0/4] acpi: handle duplicate tables in acpi dump
To: heinrich.schuchardt@canonical.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On 2026-04-20T22:08:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

> @index: 1-based index number to find

The header comment says 1-based, but the implementation is 0-based =E2=80=
=94
the function returns when index reaches 0, and all callers pass 0 for
the first table. Please can you fix this to say '@index: 0-based index
number to find'?

> Update all callers to pass index 1.

Should say 'pass index 0'.

> ACPI tables like SSDT may have multiple indexs.

Typo: 'indexs' should be 'indices'.

Regards,
Simon
