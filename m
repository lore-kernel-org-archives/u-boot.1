Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC15FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 18:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99DE83693;
	Mon, 27 Apr 2026 20:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5IWFEQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0F183BC4; Mon, 27 Apr 2026 20:42:42 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFCB8805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 20:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso116573635e9.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777315359; x=1777920159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPV7fprTQh9aTMAxXFg5RQYUMMzl0w2zWPCaS0HekcA=;
 b=I5IWFEQXqGTUpzxAFjqhXzu2OdnWm5QB4sF6SSDJGOPD1+sll33UI/MH6diUx0XZQ/
 UdzpelOq77IBdqYbynIDt4/ZzLNlRyGYC12OKCeXRCZi3BrnYJGs8E+NEI3NfQWEtUH7
 NbK7li1YDPm4/QbKXV22aTPRuQAm+/Im88iAwOk2NZo4uIMsxnrArWTz3OAdWsQfxiji
 3i2mvlsAG5RPsdeJM8ofC/DPz2pRdgtZo5p4cGrDE3QlBnEwHJQ5wdyC0Yq6btHpc8T+
 /9WVunqFQkV8iD8QNSp1y+bh9S6yD/BOMSTOLDGdM5wDoZOPBjtBK5lDGrOyC1aDsy3i
 /3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315359; x=1777920159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TPV7fprTQh9aTMAxXFg5RQYUMMzl0w2zWPCaS0HekcA=;
 b=OHc19z2OPDH0lmvnIBU/7IWtW4xq2QUtlW3kpcAEYlRkQII/Jc53bdpNsaLtoLwyuG
 YstaDDZpi64n+c61kJ9oxzf54F6uQsL9jmbPuiGMjG/6YPW/xqEoxHD9lug5A0d+kqFz
 XmrH9VtQSPzQ0hmkMc6qShDlTAoaDir/ImRDZoRxaL9MC77Z+mSqiVgDP4KBK/UvJj0x
 dh3z0yPExxeVWGz5FBLmq/K4u2FjhWH398Z0SpY+Z9QW/hPbZLJY7Vt3JlvvLDPefEWY
 YTVsijqHVTiBZyNM3I9KxCegigg7ngl2b92Pc9vlQG30EGbU8+PXRgusCsXoFUZKswWI
 d1Jg==
X-Gm-Message-State: AOJu0YxAk337jMwr57LjG1OuHqqftP7GxyJ9WM+PYomcAMsv6lRZSVOv
 RmHEVcO8oCqOZ0BHP8B+6qZ6GjL1vr/lnPSu7c2fG4S+IttHY7o39RLJhJAQO3/d
X-Gm-Gg: AeBDievcYAFYBoPwl1c7qcvVjM04sLf7CE5AA/1Y6EVE/8/8K26WCKDilJMCms9GGsO
 6JYCf54Y0mxI1O3bTmOUf+UmNoi441Fbnc+y7cVjVzNR0TiDI5aC5KItux0L4Fu0mQdnK4Exhn6
 0IuG3vqoj5D/U2bfKtEyR5j8U8yz6CZfZ7mDOtNDdIea7+crXyzgA1zwy2dQBM2oliPRZtA+8ln
 1jf0xTzhoU7PrCf9wYDmy7U1uMpxDKX8dkp8ayI9i3p6zBCi67Grs5Epdq7l/mDztFveioDGelL
 rm9/KquMz2haSLIEFRud5FmEa2HgvX5L3wmeiZ0ppMijoeOxjHOzPggsNGEktp8IjzZoYR7xYri
 FaFs4E2I5Xyp15fxEWCXxW6EgCSn3XZDqoSno5pepYkerjHXnRqkFohRP7bDtbiFEQbOItJh3n4
 oy4ibazpASBiUMl6zmNyXlIbS+pfCtUS+MfMfXl2igPXE2+S3xlvhNrhs=
X-Received: by 2002:a05:600d:6444:20b0:48a:525b:e157 with SMTP id
 5b1f17b1804b1-48a76f5ec2amr5679405e9.13.1777315359104; 
 Mon, 27 Apr 2026 11:42:39 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463ff5a1acsm248347f8f.33.2026.04.27.11.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:42:38 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Philippe Simons <simons.philippe@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: Re: [PATCH v3 2/2] sunxi: H616: dram: drop default TPR6 Kconfig value
Date: Mon, 27 Apr 2026 20:42:34 +0200
Message-ID: <X2fVg_noReChueXn-ZVndg@gmail.com>
In-Reply-To: <20260427135819.2577234-3-andre.przywara@arm.com>
References: <20260427135819.2577234-1-andre.przywara@arm.com>
 <20260427135819.2577234-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 27. april 2026 ob 15:58:19 Srednjeevropski poletni =C4=8Das=
 je Andre Przywara napisal(a):
> CONFIG_DRAM_SUNXI_TPR6 is the only DRAM config parameter that has a
> non-zero default value. Since we need to provide a value for all the
> other parameters anyway, avoiding TPR6 makes no real difference.
> To make matters worse, TPR6 is a compound value covering multiple DRAM
> types, but also spans over three SoCs, which makes it hard to find one
> good default value.
>=20
> Drop the default from Kconfig, and put some explicit values in the
> defconfigs for the few boards that were relying on the default so far.
> The value is taken from one BSP, only the lower byte matters anyway for
> those boards, all using DDR3 DRAM.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


