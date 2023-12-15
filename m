Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B369C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFF687BC7;
	Fri, 15 Dec 2023 14:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0MLgHQ3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C354487A81; Fri, 15 Dec 2023 14:35:04 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0CF87BDA
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3365b5d6f0eso31374f8f.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702647301; x=1703252101;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cx/GPDoCJ03gv+KDO8/Rrz7Eu/T175RaMUtkl9SU5xo=;
 b=0MLgHQ3zfVxBFb+ZuRnKQBlKwKu2cWEQyYOmpkZQcp0n3RDvcTKduosTvnJYxPlE8E
 sKa+KXGZh93UBTrUlArKD01a7B1Oz+irc+a2wAHLJj35YSVX8oJkhz03UEj11olmY9op
 n+3A3QKyg66Lspq6MusJosvQXvCXr8YkpYnaDi0icNyT0jn7HCKRYOF+zxV2Lzb+8bLR
 k+4RA6KQmQNgbejCRacn5s2Cp6ynExS28dBVmoCkXQRHH1+blvJchglnMPfv0Fv1ou4S
 s4nP166X/XAayvyc3JRJFt20DcnK1Rq+CkKDZHr6oOG3rP0jGlzsFIfNT5Lv1yvi2ExQ
 XZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702647301; x=1703252101;
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cx/GPDoCJ03gv+KDO8/Rrz7Eu/T175RaMUtkl9SU5xo=;
 b=Ad/58kAGjXce1ZwwhsfDyTBCY0TMlSrPlFeUvVNpn9eJzBCZSpVhA+iOyrWFJ9A99T
 +ShN6PlSXBCaDdaMbcGCsAxrCDKzoGBvdG+bGjhkFqzVbUdJgtmb/NhbLg59RHAheUda
 Qm9pzYrPe2aGb8NKSfuuKzT+dw/JlMQaoINmKrEwmNOBQ0n++5SsTsmy7yU2wsxAfce1
 X9UC69SyKyWPqwor0K0K7ONRp4uNyYcSw0lPNYw9jiV8NOTburH6/pvpJ2enSPKoJLo1
 JdvOPyWK77ioK8hf94HCruvu4lwRTsokW75lF84OKeqvOLMBRMso2WrNCMh74gh4bQR4
 uiPQ==
X-Gm-Message-State: AOJu0YxPS9AzJCdwuAa3RqO4jwM2tJ8v1DUjCFrLsJ7KjvRlM/AYyTDL
 AIPQP3nRYOuVbbMTMkBp1xqSbfO1Zj0/YQ9+kec=
X-Google-Smtp-Source: AGHT+IFcv7yaPQYQxUicMj2ax/Uxlk2h0Zor6pG7nZgfVM1n7eURSKD7JQTHpo5YtXsYD1LKCQCNuA==
X-Received: by 2002:a5d:6daa:0:b0:336:4aae:811f with SMTP id
 u10-20020a5d6daa000000b003364aae811fmr1956489wrs.118.1702647301136; 
 Fri, 15 Dec 2023 05:35:01 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31]) by smtp.gmail.com with ESMTPSA id
 di13-20020a0560000acd00b003364e67ed30sm2080663wrb.94.2023.12.15.05.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:35:00 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] clk: fix clk_get_rate() always return ulong
In-Reply-To: <871qcj5frz.fsf@baylibre.com>
Date: Fri, 15 Dec 2023 14:34:59 +0100
Message-ID: <87ttojvbb0.fsf@fedora.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Sorry for the noise but I miss a (obvious) warning:

drivers/clk/clk-uclass.c:474:8: warning: unused variable =E2=80=98ret=E2=80=
=99 [-Wunused-variable]
  474 |  ulong ret;
      |        ^~~

I will send a V2.

On Fri 15 Dec 2023 at 14:32, Julien Masson <jmasson@baylibre.com> wrote:

> When we call clk_get_rate(), we expect to get clock rate value as
> ulong.
> In that case we should not use log_ret() macro since it use internally
> an int.
> Otherwise we may return an invalid/truncated clock rate value.
>=20
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
>  drivers/clk/clk-uclass.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 3b5e3f9c86..41dcd14be5 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -488,11 +488,7 @@ ulong clk_get_rate(struct clk *clk)
>  	if (!ops->get_rate)
>  		return -ENOSYS;
>=20=20
> -	ret =3D ops->get_rate(clk);
> -	if (ret)
> -		return log_ret(ret);
> -
> -	return 0;
> +	return ops->get_rate(clk);
>  }
>=20=20
>  struct clk *clk_get_parent(struct clk *clk)
> --=20
> 2.41.0
>=20

--=20
Julien Masson
