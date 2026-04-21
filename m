Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C5F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 20:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30200805D7;
	Tue, 21 Apr 2026 22:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m3v3CYQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEEB83936; Tue, 21 Apr 2026 22:38:29 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B3680433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 22:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so854995266b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776803907; cv=none;
 d=google.com; s=arc-20240605;
 b=WwZh4p54vofSaLaKiYHNrkMWUASOTIZU0/+rRvmIC3FW9TbB6noidUBrbdV5mXn4W/
 ezbWQbpqWQ15xkz71SqUzHSOjUzcxZuww+l1/Fn8j8N6OgZdaMyzQcsSHvQSKeBOIFvS
 0p4n/OWRh695H0dNYsKMNn02kFxfLNGh+Z4/gfe32BDAuuFGMuMgp2lZWM+5u40pR2p1
 3YPBfmSXu+N+df7M7jI6JTeEWN2p0zQCxrBESrM5ZAL7UP3DHCEAvbFdh9RsqUqciltc
 5CpVJbS1OTOpfMDI5gkyRXXuTwXulIiS1IjcOnbQYWOtW4pcBezdjJXcyi6CWgrRbW/3
 N9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=he0UDEPFleRq6/YsR6XW3GGjwwbzsNa/m8GVyaqOYqQ=;
 fh=dTKml7WN6aqNs03KB5O50wyJZJYQ14V86zvRebLIsG8=;
 b=frsLyqlfMopFY1lRMoc0DmPklBUBFuu6eSS3OEA2a2FjbsusD2uSIS6CAk4tnjzuSk
 J2cP6EYP7AXKDJE9shcycYGN3i1E4bFxJ7q59MvCniqiOrHZOk/iBC6Gw4yBEIyWHr1l
 VSupb+pK4VIIov+Bf/6zCf5RrRSFYrnFafKZBl60A3WvCyeYu9uZqO52m4CFQNaWeFrJ
 v28SDvYCLwPI9Ln4ewkcggdAGVtQkPjR9K8SI26LIw1cgGd8D/U/2q12t4QKCo6DBjOg
 rAi0F71jqV9BDlhSkMDGBW8brsbOEkvySkg724lZLOWvoGnaDNSFJepGQOTUTmAigINQ
 l7zQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776803907; x=1777408707; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=he0UDEPFleRq6/YsR6XW3GGjwwbzsNa/m8GVyaqOYqQ=;
 b=m3v3CYQXoRfOor0fCmrkv8YoPhb78Ue8PbE3qA+IxyghNSigzOU7rxALnDA6Pzt6EI
 PBRL1r6Sv9NbW84PXH/hyKAufhYcnUk2/HOpj2lV6H+yeYkKx7EBktoAw/g6LD0NZ62a
 /u1PlTnQ0Pq/JkstLO/8sDo3EQ/GpyxD3NdV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776803907; x=1777408707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=he0UDEPFleRq6/YsR6XW3GGjwwbzsNa/m8GVyaqOYqQ=;
 b=G4yoWqufNPNJ6J6CBeI/5oj332SbiHDT/UQP/tQYMv7bX5YtKAtRHv5tsTZ6hQryOR
 eHfWjf2n612tDOAagG8fIFANqz5qj4NBj7Z2/16S1p5TGsd4hBZA7Yb8wCbfqNj/cKzf
 DpeYXEW5BDNiFQJ6k2R8YyYBMaYvT8IdmlIWAi7v5ySeFu6lQqdagAEZ7c7mIpMLMlI/
 FROmSZDKkKuf+f3fKqy7DKMsCqgeb70QUysxV6ppTcPh7362STQpFDRL6FKdWW/Cocoi
 R0nllNFx2CEwzmFo9eW6oHiT1QVL40qP4iyXcZHPDr1LfZ5TMJSSCoPQHuZ0b6mGioF+
 plvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9z/ppxZPBNZptNimGMaVw9taMKuDWg815u0QsrtVkOE56CPP8PnPq/EYqm4ZyhyTAWsSDx+gw=@lists.denx.de
X-Gm-Message-State: AOJu0YyNhZQt1FAuzObv1Ydky7fL0nxVWHkV50rx6Y8lZpBi3XDU2PfM
 qlVtZbVngtyr0fxsPcTzZnkKmPYlvG4qq1Q7bUV5icw66KhcqUV6BRiVswsVMadsDumtvQsng2I
 SFYUWd88V9yHrIx5bNwa4QEdtnQ/JOU5WK7tUj+5x
X-Gm-Gg: AeBDiesxT58fqqkb1sTfluas0SutF43Fjrowql39MngaQzRVJp09aqKgTeROsJy/ije
 ooHKmg9KPccxPYprObs7F75MTA/UZz7CeatuiX6iWPSrfF2JrL8Zrh+o2MCOIy//dtzEfzAtdH3
 GAwwV4rZK9nMmKY9ZuD2bt3FOTvTFhpPlqmaOpCPp2TLKE2yjEEphMFiCr0gEPHexXK6BVcFM7/
 EqimYtDnISdoi6z6nB5wZq9kUNLUb6tHq5fcFVuNvyF+BMb5L/2dH+cAyzJPkr8ULU7vTCZQj7k
 /VqQ76yyWZUc4PKtAaEqx8fKIWIYW0Q=
X-Received: by 2002:a17:906:f5a6:b0:ba5:5399:6100 with SMTP id
 a640c23a62f3a-ba5539966c3mr761239866b.41.1776803907058; Tue, 21 Apr 2026
 13:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260420192520.1444749-1-rs@ti.com>
 <20260420192520.1444749-2-rs@ti.com>
In-Reply-To: <20260420192520.1444749-2-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 08:38:13 +1200
X-Gm-Features: AQROBzA8PbQKgY4MumxnBrIbd5g592KAUI3D1Yn9ekFOkGY2sxFQhQlt2QNQU6w
Message-ID: <CAFLszTj5fvO+gp+whFzAx8SdwOLM5OcZ3ZZ-8ngfBznKJx01Hw@mail.gmail.com>
Subject: Re: [PATCHv4 1/6] lmb: allocation flags macro documentation
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
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

On 2026-04-20T19:25:18, Randolph Sapp <rs@ti.com> wrote:
> lmb: allocation flags macro documentation
>
> Update the allocation flags inline documentation to follow the kernel
> object like macro documentation specification.
>
> Use active voice for the short descriptions.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> include/lmb.h | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
