Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39EEC3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 21:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFF8886E7;
	Thu, 11 Jul 2024 23:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C2788B8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C97886B6; Thu, 11 Jul 2024 23:27:58 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0233A88621
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 23:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-25e31d0a753so720146fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720733275; x=1721338075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixlMC1wTLrVyPN+YjLCF9mVi59RGrPDXru4ZziqDyc8=;
 b=C2788B8AYEG9sMlXLJAawss2uR+SX+vEz40trGwunT1taRATGnVsEx2Fx6kMg1L9l+
 fyQdcY8ebXajZzR37JuGV/uuPwgWrG+0hfUkwZGv23ZNL66rmweKhWh46uTg5kg3W/eW
 kT1QyHz/HaPRX9YzR/nxQz69H34L9SE1g9Y0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733275; x=1721338075;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixlMC1wTLrVyPN+YjLCF9mVi59RGrPDXru4ZziqDyc8=;
 b=jHFiRQryf7slLEz6rPF8S0XS+tV6MiKjtZlyD/zOGshVJ8SXFNCLFPbBPMRR+Azdv9
 AgKOgoy2IIR3b38qqF+W1P4aT0OsUeAwKVCmMubAf3N3Ef1TXJ5ISl2UE7D9d6rwB6Om
 +6ljTuEGjmwX+soJ462xdNsS1eRvoKDiVPBCnRa70Yy9N4jN90TztrpLgN3eBkvKhZ9x
 nLTPGL2dljSmlcdc4iOsEx9c8XxLDbE6PW0o8Js2Ir/IN045qPoaMHQOrts1OlRh/LF2
 00NCy1lNGOSmW6sX3huSz5IdnTy2m39Yo3bvHQhDGQkR+oMqyDgoL6yBdcpaMuZE2afh
 6lPg==
X-Gm-Message-State: AOJu0YxkYD8auXOfMdtETDq6GuvZAe175sAFov6FycyNFxIRZm/4qu23
 xsVHo2y0yvUbzVQ8fHqQDX4XReJgMRwh3SleXwTDmDU9LZQUDx2Q6DvL1m5v4yE=
X-Google-Smtp-Source: AGHT+IEFySdpJ9qOSQweZWs01rzKLrpI9DV+48dWFOdnKCMMDmPeOBgfV9Qag+fW6lnYeAFt4VaWXw==
X-Received: by 2002:a05:6870:6587:b0:25e:1061:6541 with SMTP id
 586e51a60fabf-25eae75e8f4mr8220624fac.7.1720733274695; 
 Thu, 11 Jul 2024 14:27:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa29478bsm1824155fac.46.2024.07.11.14.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 14:27:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20240628231707.195389-1-javier@dowhile0.org>
References: <20240628231707.195389-1-javier@dowhile0.org>
Subject: Re: [PATCH] omap3: igep0x00: Switch to the I2C driver model
Message-Id: <172073327356.2744109.13150721086730732199.b4-ty@konsulko.com>
Date: Thu, 11 Jul 2024 15:27:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 29 Jun 2024 01:17:04 +0200, Javier Martinez Canillas wrote:

> When building with the igep00x0_defconfig, the following warning is shown:
> 
>   $ make -j $(nproc)
>   ...
>     LD      spl/u-boot-spl
>     OBJCOPY spl/u-boot-spl-nodtb.bin
>     SYM     spl/u-boot-spl.sym
>     CAT     spl/u-boot-spl-dtb.bin
>     COPY    spl/u-boot-spl.bin
>     MKIMAGE MLO
>   ===================== WARNING ======================
>   This board does not use CONFIG_DM_I2C (Driver Model
>   for I2C drivers). Please update the board to use
>   CONFIG_DM_I2C before the v2022.04 release. Failure to
>   update by the deadline may result in board removal.
>   See doc/develop/driver-model/migration.rst for more info.
>   ====================================================
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


