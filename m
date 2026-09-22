Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30478C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 11:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BDD760760;
	Tue, 22 Sep 2026 11:32:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uG51qxOk7UVV; Tue, 22 Sep 2026 11:32:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6322605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076739;
	b=YZz4TRBL9XpjU3sUcBUPwjwY0tguqokw0GY+JR+wMd3P9NiJpHa43m8ul4JktSUbR+SM
	 TbQrylfIDhJ0BLpWehCWVQkkMI8OvrvHMhEnFeOw88bZXlj87Pcb2fUctIoMe3/2FpSs1
	 O++2OhpJlmuGsr9yOC1gbLBJXSLwmBYoU0zl1kqE366wlEz+jXHB/NzjqkF6ZEnxozlrb
	 pn6kcVsn978n1kC6igZjPiZmAZskdCUCDeU2AVHCi9zPRsgp5q2SwVVTVpOXGS2z/vssb
	 PWWjYtrXNxd/KAkjlDA7VNPcILmhi6VA64+XcwuOPEpGgmbhr6vxuPEt4JJfMjH1d0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790076739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YCdOTTvRI61q0XIhaGhDDiWW65X3+DtdLZzdRDPjhVw=;
	b=RWM8TCeikbcTxkd91MoyhdATH5imdSP+EjbZUcyvPpF2AYP9Ul4HNxrpsQhYIwyZ0hjV
	 7Ys1S6JEzcl6hB8b5eG6NWSpQ+OL9ddMaCBQyQ/XiG79dj2tRUX/9JoIfUUrjiZTGQFby
	 DfmmLDdYR/dV5y9XdiUBPH1xKFA7PAdDYl6hwA4mXLcQGwLidF2VrJIZwFMMqbQRjurSg
	 KRrO2XW+2/0CyeYFhBy99X7pA5SR4bUd/7XvL70sUkeBbCoMPcSJQ71vFgLb6REAkxZgT
	 xz5Pylw7m80AvmB70DvfigfhsT5b2V/8fXoqAgRYcf1yQv/FLHDO0wX7+Os/KwFQmpg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=C+UUPRWN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790076739;
	bh=YCdOTTvRI61q0XIhaGhDDiWW65X3+DtdLZzdRDPjhVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qduXKxeTU3UpMvLN1yOlrswaa2Wi2hZp2Kf+YhEEonzOM8uJn7QcEEy2miVQTeG7f
	 GVIICafQxMaFp1TT9k0oMejzfoAXxQtLBS7ENLaszF4phKUMrse0eWRJEOPAPbM/sC
	 semB11ftcu5raDIBjTUGFnWq4BZNwWoF6gA2tXP2VyUXR1pFPY4z8C8i9PMklnEtHR
	 C53dvaqbLbeyB/ut9/nSDIhcLP9l7Uw9oCW1YTuZvOJ945hyWHIpOCp9+zh8BEYcT9
	 at/pG0M9UwddIv3z5YSD1YaGGeEcgy8Sm7J1Epsa+S/iy7MejGo2kgAV/epGxwXrVD
	 JXsKp++RSqM5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6322605F1;
	Tue, 22 Sep 2026 11:32:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34A52194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 268E360662
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqypF5Fc0hEy for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2421A60656
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790058833;
 b=PaLc+P46ILmiNPQRQygpD6Dp4q+X1s9kdDeq0zjO/f/0EylMQa/oZA14MK+NLAdUKoWy
 5l6Y+myw0mQ/00F8luNpxSjxXsSJ4kHpJhCpsj6v++oBXAFNUx+bk1XIyIeci2gfv1Dml
 Mr92dynOS1tSVSjwMg2ZOM0rHALtH7kDTpfWUN501vzL7TJkQpCbuVyiv4xAhAhMBK4bq
 Eb29Pc9nUf9MfqWgKpMBUvWxsNHUnGWfRDo11JeIvPXjKHsXCJBBcS/761BPspj34STN2
 TFwOhrPgtT0o6pb5Jnp5HGT1HPA6FSoDqjxV5fScKwS2yhj/ixR9JAmqWAiFYJ563NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790058833;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
 MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=YCdOTTvRI61q0XIhaGhDDiWW65X3+DtdLZzdRDPjhVw=;
 b=lSscABgYHvac1bY2K/ewGqrx9us3OC6WtYg12HlrZNz11Oer7Y89DzFkfSpx7z0vxKn8
 78ZyWrgJSZEB3AjkoPYMI2Pg7don4l7Q462MdyYKSVua8PbYSOxt7WoYZGLKqNDmHer2E
 eBWjPrEW+IrfAIqXdheE9/PJHtV6vqwOXODwPTzJfEoMixLPzt9X4y41W1NVUjA1Ap2yV
 72cS9yTmzpDz1sywSes4e8ciogY7mYEkN2IUd3fi7IgvjjsUdXtNX0NjbkRfzT59b0jUe
 4z1+GA9nwuHVC3qQuDjSXHxMn0vNl50E5/YtAmV78t9T8xZqbiQOIToTTgfLNZBGRiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=C+UUPRWN; 
 arc=none smtp.remote-ip=178.251.229.89
X-Greylist: delayed 556 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 22 Sep 2026 06:33:53 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=C+UUPRWN
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=lukma@nabladev.com; receiver=<UNKNOWN> 
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2421A60656
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:33:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 361C91048AC; Tue, 22 Sep 2026 08:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790058270;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YCdOTTvRI61q0XIhaGhDDiWW65X3+DtdLZzdRDPjhVw=;
 b=C+UUPRWNXX//LwYMZ6lkuixMl2K7aqjKeW0zWbC7L6QlUHCDRw71ZmBjiOGB4rZiAkhjeA
 Bn5Sy89Kntd1vguWVpzNI4CM3JKCMWw7JErw/ZiiBZAlHG2noycM/DKvdm4UKGNpfX0dgV
 zdQKww24IRFVOoJhdByBasuA2hFAAp1lRgxFCISv84bmoPW/BNJyFkYVrLI2zOQqHBIXyw
 1YDCCG5Lb1KVwFdh0Jkh8gGYGZdC9pTnC7Cvd445Gk7wEZeld1kO0Rm333Sq8PFdKFk6Xo
 6riXGz/U15Yux74E5a67m8DcCdcdtiDUBX02zLOBDQS9eqXmuT0xB0Et1YFUhQ==
Date: Tue, 22 Sep 2026 08:24:29 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Fix Lukasz email
Message-ID: <20260922082429.09a4341e@wsk>
In-Reply-To: <20260921220620.151189-1-marex@nabladev.com>
References: <20260921220620.151189-1-marex@nabladev.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 22 Sep 2026 11:32:17 +0000
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

Hi Marek,

> Update Lukasz email and .mailmap entry.
>=20
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  .mailmap                            | 2 +-
>  MAINTAINERS                         | 4 ++--
>  board/k+p/kp_imx53/MAINTAINERS      | 2 +-
>  board/k+p/kp_imx6q_tpc/MAINTAINERS  | 2 +-
>  board/liebherr/btt/MAINTAINERS      | 2 +-
>  board/liebherr/display5/MAINTAINERS | 2 +-
>  board/liebherr/mccmon6/MAINTAINERS  | 2 +-
>  board/liebherr/xea/MAINTAINERS      | 2 +-
>  board/samsung/smdk5420/MAINTAINERS  | 2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 6ff7f051606..863a7dda856 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -86,7 +86,7 @@ Kalyani Akula <kalyani.akula@amd.com>
> <kalyani.akula@xilinx.com> Klaus Goger <klaus.goger@cherry.de>
> <klaus.goger@theobroma-systems.com> Linus Walleij <linusw@kernel.org>
> <linus.walleij@linaro.org> Love Kumar <love.kumar@amd.com>
> <love.kumar@xilinx.com> -Lukasz Majewski <lukma@denx.de>
> +Lukasz Majewski <lukma@nabladev.com> <lukma@denx.de>
>  Marek Beh=C3=BAn <kabel@kernel.org> <marek.behun@nic.cz>
>  Marek Beh=C3=BAn <kabel@kernel.org> Marek Behun <marek.behun@nic.cz>
>  Marek Vasut <marek.vasut+renesas@mailbox.org>
> <marek.vasut+renesas@gmail.com> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb4209bdea6..55c394536ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -958,7 +958,7 @@ F:	drivers/mtd/cfi_flash.c
>  F:	drivers/mtd/jedec_flash.c
> =20
>  CLOCK
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  T:	git
> https://git.u-boot-project.org/u-boot/custodians/u-boot-clk.git
> F:	drivers/clk/ @@ -985,7 +985,7 @@ F:	dts/upstream/
>  N:	OF_UPSTREAM
> =20
>  DFU
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>  S:	Maintained
>  T:	git
> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git diff
> --git a/board/k+p/kp_imx53/MAINTAINERS
> b/board/k+p/kp_imx53/MAINTAINERS index daf861160a4..3f35fa9fb6b
> 100644 --- a/board/k+p/kp_imx53/MAINTAINERS +++
> b/board/k+p/kp_imx53/MAINTAINERS @@ -1,5 +1,5 @@
>  KP_IMX53_HSC BOARD
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  F:	board/k\+p/kp_imx53/
>  F:	board/k\+p/bootscripts/tpcboot.cmd
> diff --git a/board/k+p/kp_imx6q_tpc/MAINTAINERS
> b/board/k+p/kp_imx6q_tpc/MAINTAINERS index e54f4604c38..9f3c93baa72
> 100644 --- a/board/k+p/kp_imx6q_tpc/MAINTAINERS
> +++ b/board/k+p/kp_imx6q_tpc/MAINTAINERS
> @@ -1,5 +1,5 @@
>  KP_IMX6Q_TPC BOARD
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  F:	board/k\+p/kp_imx6q_tpc/
>  F:	board/k\+p/bootscripts/tpcboot.cmd
> diff --git a/board/liebherr/btt/MAINTAINERS
> b/board/liebherr/btt/MAINTAINERS index b4afed5aaeb..a4916996ed7 100644
> --- a/board/liebherr/btt/MAINTAINERS
> +++ b/board/liebherr/btt/MAINTAINERS
> @@ -1,5 +1,5 @@
>  BTT BOARD
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  F:	board/liebherr/btt/
>  F:	include/configs/btt.h
> diff --git a/board/liebherr/display5/MAINTAINERS
> b/board/liebherr/display5/MAINTAINERS index 52178318b59..40c02852b85
> 100644 --- a/board/liebherr/display5/MAINTAINERS
> +++ b/board/liebherr/display5/MAINTAINERS
> @@ -1,5 +1,5 @@
>  DISPLAY5 BOARD
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  F:	board/liebherr/display5/
>  F:	include/configs/display5.h
> diff --git a/board/liebherr/mccmon6/MAINTAINERS
> b/board/liebherr/mccmon6/MAINTAINERS index c9c718305f3..ce3f6374547
> 100644 --- a/board/liebherr/mccmon6/MAINTAINERS
> +++ b/board/liebherr/mccmon6/MAINTAINERS
> @@ -1,5 +1,5 @@
>  MCCMON6 BOARD
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  F:	board/liebherr/mccmon6/
>  F:	include/configs/mccmon6.h
> diff --git a/board/liebherr/xea/MAINTAINERS
> b/board/liebherr/xea/MAINTAINERS index 12b5dae2aaf..79020c9fae1 100644
> --- a/board/liebherr/xea/MAINTAINERS
> +++ b/board/liebherr/xea/MAINTAINERS
> @@ -1,5 +1,5 @@
>  XEA BOARD
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  F:	board/liebherr/xea/
>  F:	include/configs/xea.h
> diff --git a/board/samsung/smdk5420/MAINTAINERS
> b/board/samsung/smdk5420/MAINTAINERS index 217ff71e32a..cb852c60b9c
> 100644 --- a/board/samsung/smdk5420/MAINTAINERS
> +++ b/board/samsung/smdk5420/MAINTAINERS
> @@ -11,7 +11,7 @@ F:	configs/peach-pi_defconfig
> =20
>  ODROID-XU3 BOARD
>  M:	Jaehoon Chung <jh80.chung@samsung.com>
> -M:	Lukasz Majewski <lukma@denx.de>
> +M:	Lukasz Majewski <lukma@nabladev.com>
>  S:	Maintained
>  F:	board/samsung/smdk5420/
>  F:	include/configs/odroid_xu3.h

Thanks, Marek :-) I had no time to fix it before.

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic
