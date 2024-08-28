Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06504C54FAA
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 14:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787B088883;
	Wed, 28 Aug 2024 16:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lCmzlID+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBDA88868; Wed, 28 Aug 2024 16:06:06 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D694188883
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 16:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53438aa64a4so7077343e87.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724853963; x=1725458763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2WZQT3AXcVKhPpQoXVPmoz/yd7VwysOAd22GPJxSIA=;
 b=lCmzlID+S24HA/Bx3Mva/mlhJuqM7D0aR4iQBNoa/ZLbu/3xcOR7iQs7mx4i6d3uAd
 GjRNbEWH/4MLe6ziYPxJGk4ttItptS6DSf8gV9RjkzpMokGnGZ2+Ycm1yxpJ0WmjMJ0O
 DhHYGQ0lEhDFxk4g+tUeDucHyeEbKbyelGyWhvNRayG5FDQUB2UbpwnMN2VylDEAATZN
 KI26rJ8k1M+af0wZsbOqVjZ73CmfczHgGr9YP0pRXnOiX60Ys8z6pOR5XGGdAYPrW+tO
 W5kK7n34ywipDQMD54FO2NOLjv5G1gjA+cGXmgIwGEIF1tS159GqS5qQClbspEi8WxZ8
 WqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724853963; x=1725458763;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2WZQT3AXcVKhPpQoXVPmoz/yd7VwysOAd22GPJxSIA=;
 b=BXMJEYLs5et4baW5L5TAXYZqHNnzRDE5WQXue7CWUCc8PeZgaQ656XksshAh/uYD9H
 pPcJv69pthVeD8VEZzG44ljv0gYVNJlBKjXvdLh6vwlCit9TZIdSCjY88s5YPpe1X9wL
 T2YXIcTsO6k6ss14PvpsVzxOQCj7OOyLsPHgUxLAQKsQ2nqruOnwibJ6xEwUaqYwxwdn
 7N5M7uDQprVkUK+kx4ZONKlneGRjdBaVP6QSlerc6ZTXf24Au2ub7CJ6hpk5n7/EdOKk
 exs6QgwIIaoiIA7Wx/22Owp9xdzhm/Q4sEJjMknbidcI6Dd7QL98ivjACKn/NvNN4u9H
 wX5Q==
X-Gm-Message-State: AOJu0YyDc19ntmtHB34rNn9T569U5JLL56xutPCryjVxxc/SfKn0Sjzm
 PbumxwlJVzbXgMlcudgAoaJnKitRdXtVFNw8RCghi7f0E6ryknqs1C2spVlAXVtCiEXiNFGQKN5
 B
X-Google-Smtp-Source: AGHT+IFAjEGV4kYgRkr8+xQrjb+sKKUHazckpraQydnuVwGqrTATptXuilR3EEaaSlfsZVLG7pXCjg==
X-Received: by 2002:a05:6512:39c2:b0:52c:e047:5c38 with SMTP id
 2adb3069b0e04-53438831da3mr11369770e87.15.1724853962169; 
 Wed, 28 Aug 2024 07:06:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639d458sm22620095e9.14.2024.08.28.07.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 07:06:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@sberdevices.ru, 
 oxffffaa@gmail.com
In-Reply-To: <20240826131710.29746-1-avkrasnov@salutedevices.com>
References: <20240826131710.29746-1-avkrasnov@salutedevices.com>
Subject: Re: [PATCH v3 0/3] Meson: R/W support for pages used by boot ROM
Message-Id: <172485396131.2557931.12598907666272642815.b4-ty@linaro.org>
Date: Wed, 28 Aug 2024 16:06:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Mon, 26 Aug 2024 16:17:07 +0300, Arseniy Krasnov wrote:
> Patchset is based on patchset for Linux (today merged to nand-next):
> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/
> 
> Here is description from it:
> 
>  >  Amlogic's boot ROM code needs that some pages on NAND must be written
>  >  in special "short" ECC mode with scrambling enabled. Such pages:
>  >  1) Contain some metadata about hardware.
>  >  2) Located with some interval starting from 0 offset, until some
>  >     specified offset. Interval and second offset are set in the
>  >     device tree.
>  >
>  >  This patchset adds R/W support for such pages. To enable it we can setup
>  >  it in dts:
>  >
>  >      nand-is-boot-medium;
>  >      amlogic,boot-pages = <1024>;
>  >      amlogic,boot-page-step = <128>;
>  >
>  >  It means that each 128th page in range 0 to 1024 pages will be accessed
>  >  in special mode ("short" ECC + scrambling). In practice this feature is
>  >  needed when we want to update first block of NAND - driver will enable
>  >  required mode by itself using value from device tree.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9905e77edaa9b4a43285e587317c600ffa7be7ca
[2/3] mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/33acfbf41819d06e13bcccf1ffdf7d01160f4b1e
[3/3] mtd: rawnand: meson: read/write access for boot ROM pages
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/35ff967a99e97b523732096628bdbc78758922f6

-- 
Neil

