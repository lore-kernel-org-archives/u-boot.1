Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9187BC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1251587C08;
	Fri, 15 Dec 2023 15:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vTyZXoyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0914187BE7; Fri, 15 Dec 2023 15:22:43 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA9BC87C11
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3365705d38eso329219f8f.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 06:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702650129; x=1703254929;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D9K+lquOSea0b6fbJy1nxB3LtaJnnZkLVOQOzJ2Oxw4=;
 b=vTyZXoyR/gDf/gU4HTRcTu4ft4uaE6JQQEHeIld+rnpguZuYLWHiY4yKdo9yXwQOJ4
 Ead0B9f2gttz09abdjVN+V3v9V1R2k67j7snyeHZnMk0gim0O+doVotyoiHeZ5ayPnKM
 xpVTS2GpR7Cmz838D+nqcYhhCYR2Sds5m1zHwj2XNJCMluZGYNsAFOF1mbfzliqh+4N8
 Gp7/xty2vnEfRfdQSa+S48yR7B+by9+W3dRX0zK32UWJUXe3NTUnXMCesKPsSUVb/0Xp
 XuMtsTNKkNCSSOt4f7mjDgyLvhD9J2hElM3616qE2jXveMTtDYXz4kFsH9huyBr7nEzZ
 M+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702650129; x=1703254929;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9K+lquOSea0b6fbJy1nxB3LtaJnnZkLVOQOzJ2Oxw4=;
 b=klYga/lvZxiQCJQdbaVLqsKhr1doUiRrMH2gdc2Q7qBeGDsRoJ5kTAWfzrctCt+TBR
 vugVzG4XZCKb2f6ZSdlBzeVn5zsQYKQukkbZ3Sv41KzcKhCpV4+284XQXBaHuH5CsjvJ
 Ru6N0rCNC+4AqXZ15MR2/rTdgv4YjJ/i9ZjC9LM2jJKJYgpprBTJCyIZl7o0vTn7+J/Z
 zL3mRUjuopqjJ7Dwnoq4qJ9N7bKWHcvlddAGulLHZ0JhddiEXNBxpNvpccPF2nASLhyR
 9PFN26j26cfhx0QkSIFrQQtZIA3KZO4iNO+mhPDgqKQSHaLn0nNd3NDjs/wdEhTlvMid
 06+w==
X-Gm-Message-State: AOJu0Yzn0QfQfu/NqGNOTiPJ2lJn61yWR8+bDulvXvCAf1+v7TBmYJQM
 h+eJHKbYuyKZHKtkYenrxbHJYA==
X-Google-Smtp-Source: AGHT+IGekZeJRfnGI3Zj45Dsq+9HjuoIGnMHrkpSBZmjsEh7x8IO9wHktdXadDeDz626u5XlJV8vYQ==
X-Received: by 2002:a05:6000:12c2:b0:336:4b38:89b5 with SMTP id
 l2-20020a05600012c200b003364b3889b5mr987326wrx.203.1702650129346; 
 Fri, 15 Dec 2023 06:22:09 -0800 (PST)
Received: from localhost ([2a01:cb16:2072:bcf7:e952:c673:7cc0:1bd5])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a5d4889000000b0033609584b9dsm18814376wrq.74.2023.12.15.06.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 06:22:08 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2] clk: fix clk_get_rate() always return ulong
In-Reply-To: <87o7erv9p4.fsf@baylibre.com>
References: <87o7erv9p4.fsf@baylibre.com>
Date: Fri, 15 Dec 2023 15:22:06 +0100
Message-ID: <87zfybsfzl.fsf@baylibre.com>
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

On ven., d=C3=A9c. 15, 2023 at 15:09, Julien Masson <jmasson@baylibre.com> =
wrote:

> When we call clk_get_rate(), we expect to get clock rate value as
> ulong.
> In that case we should not use log_ret() macro since it use internally
> an int.
> Otherwise we may return an invalid/truncated clock rate value.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes in v2:
> - remove local var ret (fix warning)
> - Link to v1: https://lore.kernel.org/all/871qcj5frz.fsf@baylibre.com
> ---
>  drivers/clk/clk-uclass.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 3b5e3f9c86..3cbcb2d033 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -478,7 +478,6 @@ void clk_free(struct clk *clk)
>  ulong clk_get_rate(struct clk *clk)
>  {
>  	const struct clk_ops *ops;
> -	ulong ret;
>=20=20
>  	debug("%s(clk=3D%p)\n", __func__, clk);
>  	if (!clk_valid(clk))
> @@ -488,11 +487,7 @@ ulong clk_get_rate(struct clk *clk)
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
> 2.43.0
