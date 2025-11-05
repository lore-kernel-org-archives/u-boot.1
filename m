Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B623CCF9E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA54B83981;
	Wed,  5 Nov 2025 01:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k0vfImtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121C4839C6; Wed,  5 Nov 2025 01:42:45 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029A683968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7866dcf50b1so28937267b3.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303362; x=1762908162; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBE9tAe3CFhE8TCGNh6t7O3Z0DHflaGhYNCTJscenD0=;
 b=k0vfImtxjhCAZpX/NaZzke5b+ypdid2D+RI89GP/IvqjYCipO4aR63KNyf2uFZqaKm
 etZgajFezwJ+IfpWkt0xW5GVyRwQbHMmYHk2th04zWahGTZiZlntE5ZPGBWS+ytK6i9u
 QR2Eg2SqQmR2onA2vsfYkoMY7y24+NZ0UFg84yBHdwoEoVtUxTibyuk+N/67z8TYoPnN
 pkB4407fBZISrLr7KLBDAKs021kS5XUYKBGAHqxm4SDoWH/u70pJCzWsux5N0SgSEB5o
 zkjlCkdCu7VfwgQDqJH6bzW/+sW5h318F9guf37UVEtCSrCHvttHM2E2+CxjRY9fO4B/
 EGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303362; x=1762908162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBE9tAe3CFhE8TCGNh6t7O3Z0DHflaGhYNCTJscenD0=;
 b=Ynq22Q864b++k8Zb/mNlxWiQRoCL548lE/jO8wtblEo99QANZEU5L8TSbZAR273dO9
 HUnuXDuoP72SH2QCRBjC7VVTt0z3jv98OprrfIC7xTqdpfyShgh7ru86kpldOPIJ0pO8
 sUpiOhrQvw6hJUiH1F9jUzJklY+rhho9htCOs6oaJS9pZifHegNplAcpLtMmBOFbroYS
 aoxA4GUTPFNMP9yGmZIpg9QfDo5FGP3+/kNS9ieYv0OF/OxS3Cj/BuM0oWnldWdoQy9E
 UhO+FuN9wYuojpvkrQ8XMFTyDPIYlgs4eKgL+sr/s2bM7FPuHEdXY7R9ejcAjVor7UPe
 z0MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlV3KXvjjhJFzPzzfFQqLh9aYyR9/XfwET44WDRjZ8i46JdTghwEZr2QmDSj2lXTL9jg0LTC0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5Hf2cBRSX5y2+blx6CNPh07ciROtlynORblv3LeLbR0l70R3c
 DPBH1VMla6VB4DKzFUgtbgKpOqgHqu2RJeJm6/7hCBde4upOjDJ+SzlmrasY2CcGgR5b9P++7E2
 H2QjWNnrz5MvL0qQFp72RzZU1smWMDYA=
X-Gm-Gg: ASbGncuoGWugMLv5s8XdMiUt5c0mS9uvHCWZH8x5pitMQckje576QQ70CXs1ocgyywQ
 jmI/zIb1gSx0tKw+b0zA1ZwIqQMjTcuzO6IQwQSkofjgImGwbJy60DVK/YgcFY+wHyjdmMHvhtO
 oLHxMcXMFjsNb1dYiPwHn0JwOXWgNMfylBHtKGrOnljcjMi3O/6FJch19V/6EUPFwsj5uN/D2C1
 H83haVnUAvwQde0DxXjY7GAmjjuy+BEiQQBDV2U7PSNhbVQRn9smbaD+dHz
X-Google-Smtp-Source: AGHT+IGL5rXeAeyL270Esb3erPXGlHB+LVB6WJdPouLsmiD08qmGBaF27uZoTyJxKSXukhw3ghkmZsPrZuY9kcKHrOg=
X-Received: by 2002:a05:690e:2452:b0:63f:baef:c4f with SMTP id
 956f58d0204a3-63fd35ab898mr1049907d50.63.1762303361777; Tue, 04 Nov 2025
 16:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20251105000751.91889-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105000751.91889-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:42:30 +0800
X-Gm-Features: AWmQ_blwmQah053lNiNvMbdC8NgAum2ziuvU8kWmiMyoBD5sBXsoQSB9vDjHGGQ
Message-ID: <CAEUhbmX2YW+Vi75WOJEKeVAQKNgy0L3k6GXkyubMM=Q_PLkp0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: typos 'requird', 'current'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marex@denx.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de
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

On Wed, Nov 5, 2025 at 8:33=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/requird/required/
> %s/current XHCI/currently XHCI/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/usb/host/usb-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
