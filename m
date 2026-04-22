Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2271FF94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF64C842B7;
	Wed, 22 Apr 2026 03:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m6tiLbLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967BD805D7; Wed, 22 Apr 2026 03:16:33 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F321840D8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so41572765ad.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820590; cv=none;
 d=google.com; s=arc-20240605;
 b=XXTE7dtx14QnH8zHJ258R3sMCdJBIIn2f52O0aGiHyf00zDt8LqbCJbx0/xvzjn/K1
 pJArWKKYB5P42a2ejLKJHcYYXao2v8ZY6iX7VJmG2oJmnVK7e4YXKyhqJdbC2JWkzK9H
 rsXxWFsyb2Q+iakjvBPBDc2HaEBxwiVMK1lt14O0tVMlg5qUt8nyVtOz7ZnyMDEWF5iW
 EE8X4J8IZVQxiqagPmf71IE1mP3ssfGmCJ55LVTrAyIbBM0q9+qU889cDPcLItT8Tfd4
 mIcJ7Ga7UxDI+k7rEvtClgRmas+e/ikwVuUIKoyDWjRZXUW5mIATka91kNsSEaWmnAnW
 UGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r4hmwsMrDqG4KYkR4KqZxiaJAzB/esDLVuYe4Tw6LbI=;
 fh=T79q7iQaKgdBLSTuhvl3jRYD2v6g+8MB8Joags6q2NI=;
 b=FZvTmG/TgDMLgVEri6rhWtGmZr3/DXyao6Hh+jMitpe+jaz6gZ0AtZguETFUy8nlvj
 am4rIhqbKkD0J9EBmTFQVMfvnQe0Q8LUtdyFPKZpEMr53FcoDFVpO3YTWT/qlmZ1O6FZ
 kCuZRbZRMI/Jcuf9sQ1s+U24BN5fIHOmVDGH74v9Aq0Wm6D6ksQ7oca5siQafTMN3eqq
 q8UfUErcESUZyclQOgjxK8un+QtdAz+mVx8It7SCx6ktE8v7yes6JrSjYRbub4LQjuOZ
 JT8tHYeIupg4TvgL/5Dm4hOEDhrcQynxdSNBfi3Vi9/1Vf67TqMvCVENWtbWg79rvVnY
 VdWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820590; x=1777425390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r4hmwsMrDqG4KYkR4KqZxiaJAzB/esDLVuYe4Tw6LbI=;
 b=m6tiLbLfJlrLX5/83vUnhCoMAFykJ9Fk0MMAjpy40PcB/dfDfc4yy8U65CEXAHdrE0
 wJ0YaYaCS47vE0FLQk6CrMTjhw8ugFU97zU5XOxIoTH6G8m6z8oQP07LRTFeP7QxIQxM
 X4tNPH6bduugqMQvOQv0h3paK74IEkhavH6LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820590; x=1777425390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4hmwsMrDqG4KYkR4KqZxiaJAzB/esDLVuYe4Tw6LbI=;
 b=Ey4FWsnU8pUApe+VWSTSWDvUgz5RLn4msPX6hWhZEXm2m8w5SV95jYMpyGie3ys05g
 AaqY2GbvW/VBV9TVnakA6PL2nB+PAm6MTyNuqcWrlTHb+fFhv664qQOn17G6yAZM1Vl3
 Cf2lVUxKoH+JUOFoKF9mGvUMJ5+P3bD3T1+4+MgbnAopqRmsKNP70FMkg6r6kXIn81xQ
 kuJdp9WJCydeksy7hMIvax1sowahv+EhheWsJzN+PbpxZ6xSlNPvzPRYMsnbtli7RXbe
 liqRbaSJkUtefTRyYToVPJgKDw2itqJ8KlzkLihBchtQxbuoCy1Tveuv8Ll2bkrvK10E
 /exQ==
X-Gm-Message-State: AOJu0YzULia4DQYDAZVw+VBpwCTSLanbMoJzJYxG6LZbUa6xmwR2MBfV
 O+Ypdf1u+mcMcE0XqVD+Iflqw4eXR7zN8t3bQceg8noQh3cL3iLIH06AOEN+Smc+qAdG55ry5iz
 5AJ2B1exVLIqB494PZ+TvHBdG2zGNGH+RJkA2WooI
X-Gm-Gg: AeBDievm+0Eb4TeUJ7tJXw1Q0xyQxzLrYoTlzGiMB9RchVV4LT0YVNR90DigyY9IxyN
 UZxrq7EqAPLYm2i8Bnyj2wHfNqQEExKMX1ktvcMj+ocPmnrWZHhgePp1Y62ZfxN6cjCMEW0HzoV
 BpYGV9DfCk38UVBBZlXaDWkfKXJI2Bi2gNizvG8p78ABBEqZrw8E9POKlS8u/47LPZJr2TbO2Qg
 etxLFzJtfSG44zZqeyxhY7MGkOqDVmL5LCY2pf5E93qOE0rrWEfXOjzrkLA8zV1WRN0EBD+1kPu
 ow4T8OM/UQ6QGz5F9Lf8
X-Received: by 2002:a17:903:987:b0:2b2:3dd9:c5f5 with SMTP id
 d9443c01a7336-2b5fa0044d9mr238657635ad.36.1776820589688; Tue, 21 Apr 2026
 18:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:15:43 +1200
X-Gm-Features: AQROBzCdjj6qJciIbqMrhgO_Kcv0KpilbxP9DAB34SQQYP7TkNXVsZP9-cNklWo
Message-ID: <CAFLszTh=NVKYe2NS5t_kj2t9C+3oCfUqpY919fqEr9jyHgpN5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] usb: onboard-hub: fix compile issue with gpio.h
 import
To: matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> usb: onboard-hub: fix compile issue with gpio.h import
>
> This resolves the following compile error when compiling
> ten64_tfa_defconfig:
>
> In file included from ./arch/arm/include/asm/gpio.h:2,
>                  from common/usb_onboard_hub.c:10:
> ./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
>    17 |         ulong addr;
> ./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
>    18 |         ulong size;
> ./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
>    19 |         uint ngpios;
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>
> common/usb_onboard_hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
