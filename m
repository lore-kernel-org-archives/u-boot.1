Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A54C83033
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 01:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E3D81FEE;
	Tue,  1 Jul 2025 03:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ezN/DVcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0A681FFC; Tue,  1 Jul 2025 03:44:25 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC748006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-553bcba4ff8so3002952e87.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751334259; x=1751939059; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEXzP+Em6voarnn7d5cgtoyNndZjzz2P/saXzMBqj1U=;
 b=ezN/DVcqePtkkcdeumRp5XiFv17cB6sb2W7q3Qjqn4b9VUiRdhuYO1p3ZuFYmUaOvP
 8I+GVSmPvsHk72R/J2c8hdpaQatyCl//v0qtZrbJq/0NlBSxFdK+wr4liL233W01SilJ
 CJSbXLAJQd2jHnOqeC4niiO6213+kpBalwPrFyTQFIz73r1t6WhKWrckcSdzBUYsdqI5
 0exxnD261DjsGH/StIbnSeVhHqwbMyXX8j5hBbmv2X2B9cN9MQmW2iyl8LJ/+gTL6a5E
 7s5g63Cvss3GajfwJo3ilGhjVuuDDPE5sVBHLdhyIgoJp6ox49+fCvwXoU9n6y1Bfzey
 OUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751334259; x=1751939059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEXzP+Em6voarnn7d5cgtoyNndZjzz2P/saXzMBqj1U=;
 b=sR4LFP6NrcUFLVml+wuLoR4XBjBjD6th/j0mAV9YWpqYxx7a3S6Zc8WBnKS6kdF0tO
 BG1Pro8yBcPNFXb1ORd6oiaeLwYv6MEfDG7PpUvSGP4I5btlRharR2lxGzAsF2EuIJhe
 1VmIWjupYEvCOBbXja1dRd4aVEVz9Mjk4d/mjPkIcaABHVlczHt8ckLnea2EhH/u8YTU
 W/DPTvbP+dgfxXPJuOCTBMPt8BRH0GMrS2ZffpDcAfTlv3e3RHDqY81NgvY3O04Bn/+z
 LznkIfqGpCWdVwTHwJoZmAI/3NO6yR1t5sKGL2DoGYaOaRD6cqGhnNQWaKILr6Cpr78a
 3Iyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGCYWaX/5j4hspUr8bIWwXfkRTs9qZKaZ3yMO+mcz5KBPUz0AbTnoQDcGqLHCmJK+H8vzSVEI=@lists.denx.de
X-Gm-Message-State: AOJu0YwFgC8SIgz51YfNRsWyIScovY++xBHLvWLJOJnjOYtrMcL0QB8q
 LDrtE50cJ+u6gyBlXYGWeaAkX4YThOPZqY9bPXeqGPoqeT2wmo1j0U4PiuKNUFzobwKcnf+Ossd
 muzI/+vC+sPGzke8aoM1h4hi+4S6h8Vo=
X-Gm-Gg: ASbGncsiDuaF0cuPUGvSkcCDYLre1CRSOA21xHpzgoheRNXotJKi93JV7sNOribPyFK
 sgiU4FCx9HsqF2CLGfufxQcuhrPVYMxkA5TWmKoNLLgFuQQhE87BDqv6tKIap2mWdWM+rY6tmCS
 QNIxfgyrVxQ2KLwCmBANF7kBHshZwFVmmrFvAiyrT8rf1HJ46p3ce2AaV1BtPvPL7bQAz3UAJyD
 vQ=
X-Google-Smtp-Source: AGHT+IGJytgZyVi/p0AScVEFgo5gHHX9oO1bKPmvyTb57FKUxXQI9bSl9xRx1P3xohJ/MPNT/sfQ6XLE1xGVlDW4roI=
X-Received: by 2002:a05:6512:12d1:b0:553:2e27:6769 with SMTP id
 2adb3069b0e04-5550b82a76cmr4050213e87.7.1751334259448; Mon, 30 Jun 2025
 18:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250625144130.1704509-1-lukma@denx.de>
In-Reply-To: <20250625144130.1704509-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 30 Jun 2025 22:44:08 -0300
X-Gm-Features: Ac12FXx1DESPnP_3dPKGeTzPnVwgQLldUKBl1uaBt-95p4oBwI2dHS1nGbJ3SI4
Message-ID: <CAOMZO5B_L=CwP=YL6feXtyYsRDci1MXaCJWgkczS2vKk4FF=Yg@mail.gmail.com>
Subject: Re: [PATCH] dts: pcm052: bk4: Use proper compatible for QSPI SPI-NOR
 memory
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 albert.aribaud@3adev.fr, u-boot@lists.denx.de
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

On Wed, Jun 25, 2025 at 11:42=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
>
> In the contemporary U-Boot the "spi-flash" compatible is used only when
> CONFIG_$(PHASE_)SPI_FLASH_TINY is defined so spi-nor-tiny.c is compiled.
>
> As vf610 devices are not using SPL at all, the SPI_FLASH_TINY is not
> defined and no QSPI flash child nodes are considered as valid ones.
>
> The result is that the 'sf probe' command fails and SPI NOR memory is not
> accessible on e.g. BK4 device.
>
> The fix is to use proper compatible - in this case "jedec,spi-nor".
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

Applied to u-boot-imx/next, thanks.
