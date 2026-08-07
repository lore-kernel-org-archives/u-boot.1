Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD72C5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 11:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 190A240434;
	Fri,  7 Aug 2026 11:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id locg_RFXXYJx; Fri,  7 Aug 2026 11:06:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5DE740382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786100782;
	bh=x0hJNVruKbINN6zzOLp/kJOK/5bR08k/12T2cUMcRnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XzLXZTuuJ5VqQsOifXfZQf5ctihvrcNkvadd+HOf0AzDim0e3BiAo3X/8FauHuvp+
	 AT0FKGhJQVNifldEwCC1eNoAyr3o9Z0EFMx9A6HUQbYcYHynZtFXZTLQQjmygaYC1Y
	 OFqG2uyNJZW/f+yT2BvkPBL0YDiTgrHGC9eR2vbl0kAQfVq+TqaxuxFkysYdPW/kZJ
	 sFIqvBpssdkmYePlBKqqrFlQnO9iBdlYaKAVLN5LRiNYbfdUeRT0mVl/ylrBFQmnw/
	 U0Tr/8fxhrHPgYQ+rrAzDwJUH7/ecN512WSCGNHV451jF0hJnNiJXy9IPLWlhkx7Ay
	 M57jQkURJrF0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5DE740382;
	Fri,  7 Aug 2026 11:06:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25238218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16DBB81230
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z4X3jiYlneSJ for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:06:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E1B4E8122D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1B4E8122D
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1B4E8122D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:06:18 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so5404520a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786100776; cv=none;
 d=google.com; s=arc-20260327;
 b=iVDdaNWp2t4KNaWlnJH89CCM2GiCKWruZ0BLxcyNtJeP5UrqOBrIdmo1AM9q4oZo1k
 pXbyA0dd3lcepVOaFt8mpyQ8yoPnHsGaWNvdJ8qpmXaZMEZxByIRZILR56d4Rd4MzyPS
 b1UHQiV17HkrwlbwOEMwVMHwOaSJ7nBY1S1UtOH/hPKTe8k98agXvzsssAt9IklqRotj
 uscYhdk4u99bl/zwyZh5bROtsp/cKhBtWbMpsluRpExnYtg38m4ZLwiST/9TPzfdXoWJ
 BDDMRbgkI3ieBSjzZNINZbSAz7x8UMenessyGf0GmEUdzY0vnBMq5gylV+MaSwk7fJbB
 p/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x0hJNVruKbINN6zzOLp/kJOK/5bR08k/12T2cUMcRnA=;
 fh=86U4k7/XnrUjye8w7TSQIonsUrR2TZrXW3DA5SCwUlE=;
 b=sw7BF984kk/dtKEkCMGVOzXva5Reu7pgEu43muTQLohxENIRbpUMJUsWcYQazC9C7D
 j/U6RByLdIjH+s28YiX48gj1RmznZm0FC0/fYOjVMlvCcQzvvtYNO8W3FwVhJTk8zg+C
 NuzZYckzgQTDC1rPlBc+g1cy1U2dPHCX6KOGOQ2yfLqcpNPvPkgwovTND5R2CNHDXKpw
 qwvy1NziBG3h/4Auls98DXCn4Fzva+1w7eH7y31IAMrhWKZeBCGH/NPE/svHDgzNIfbr
 T67J+fb6KfPgkHkZjIOzAyaMQT88TAyysuvuh/GGfE+9b593uMyqq3j37UbsKib/+bs/
 4erg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100776; x=1786705576;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x0hJNVruKbINN6zzOLp/kJOK/5bR08k/12T2cUMcRnA=;
 b=QtWeLA9nMsjtlykm1NPuZixmWeYI1Y/j8t4eq3p4Y0omLIgeSY4TBDcGQ59gEc+VgF
 4EDnRxw34qUxUQ6X4eQIJv+nq0S3tFdTxWhcrUf/ZI6VGeD8XNaG2mzkmaDm5QR2PAzi
 g11H6i2tayd9gro2AkI7Q/ZkOviC5lmCEeiFbrVbBo3rAmHFSg5MjMUJnitr8KrzUMz1
 Kb2mi330SGA+xTpOOFmXa7RaHCshumM/oZZyy9jdkX1IpWBYf0M9ib81BkNMhu7UBhfp
 PfImHv3y+8jD8iUZjTNveYYyRedqTcVdFrEJl6atQT8695ft5bo+knotuh+wK06aISiW
 2Rrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGrIJiAa+8ryeAmQ8Lj3xfUhI5OyQYAgc0wWzssqiYCgCuGPGH/+L49gp2AX0keUF+QEu1r4k=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyLABl4F7EY1aVi/cn5z27cXMqLnG5/t6Uu7geyil8PKLA/ZmUQ
 SC4f8WKcT8ZyDeX6BasU+z29gW29NsGzrZpjUe2WhtACm/BmnHQn9HQvbJsBpKUwKFHrZTGIKBb
 Q025Qe7XfKfINW7V05tT9fqsroCI4G0RScHOx679J8A==
X-Gm-Gg: AR+sD12OW87dXqmUzG/2CYqC6ftr2Ctx7pqStuB8vF3qQedAFhV/hW8o+Cv0Vq1ldpo
 uBN2dgfgl+EZbLBEaTsPTxUOahdAP0Qq38iNppXNfFMNtjuHRQxaSe5pmtaBb5QDHK9vJfoBkFW
 gYQCWU9yA15LQlSC7QhuumKM3qccXQQdYIhRQeJ/CY4Mwpox5kKZK2XCWTAsN9OnTOJHXA1tfYB
 KxV0qA/F27gk6Efj5b+aLxjo2SMaZh5DgjoCxDu3LN32l0vL1r6JRF8qh0+eSYwwIwQmjzqvm6D
 bvIHi3QfcIKeq5V16G/eGQorTPbB3WJ2Nn5vGpNorRXae7CHFct6x0eAjiLjPJpuY3f9ttbuHlj
 pDF9vLJ+sre787SlmAXQNIjQaklG0ePH7jPvoVSkBIVXIyl1jN6sBfDb8/QYFGEk=
X-Received: by 2002:a17:907:d24:b0:c16:3074:657f with SMTP id
 a640c23a62f3a-c2039c563b8mr1134612666b.9.1786100775618; Fri, 07 Aug 2026
 04:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
 <20260731-serial-mtk-clock-fixes-v2-2-022110a9ec3e@baylibre.com>
In-Reply-To: <20260731-serial-mtk-clock-fixes-v2-2-022110a9ec3e@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 13:06:05 +0200
X-Gm-Features: AUfX_myhu0wtEDXHmACZ2SHihnOUW__fPO-0fUql94Y2tuwPxDeUQQKajVTgolU
Message-ID: <CAEHHSva1mtgsRZ2-OAZ7qBP0wfHBVsvUECtRu6-n15aY2OEwOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: mtk: guard clk ops on clk.dev
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786100776; x=1786705576;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x0hJNVruKbINN6zzOLp/kJOK/5bR08k/12T2cUMcRnA=;
 b=nIrMdhoCR4QCfoGVsmwx1TiAgxRUYK2s0nUy1lMjeJIbMI8jVcK/3Y4Sch9xZt7VYZ
 0JTLLiAQFxmLNT8ozElHJGhP1uMFe9jWd5JaD88YBZanwgQEyUJGGDXXyiIsQK6rT0K7
 Iqdq+mYziOoap44uZrRh0caup0ylsF5olGI9LwxAjINiz/JH5JszlvPrJGxjPHr8dVkx
 ASXcaxXAKuWwRKIL/yH2nfHFie3umJEFFwok3p1AvmeKWpI610upWKr+uy8YYYuVcC1D
 Ia9vXT/p80C542MIpij62Ho94QnMEKqv3MKwU7Gr6SO9y3wrLT5yrqNLkXqRZcnSKtJ2
 gMfA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nIrMdhoC
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le ven. 31 juil. 2026 =C3=A0 21:39, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
>
> Check that priv->clk has been populated before trying to use it in the
> MediaTek serial driver.
>
> The clock is optional and may not be populated in all cases (in which
> case it is expected that there was a fixed clock rate provided.)
>
> Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clo=
ck souce")
> Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/serial/serial_mtk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
> index 28e87f485a2..fff2f639cf6 100644
> --- a/drivers/serial/serial_mtk.c
> +++ b/drivers/serial/serial_mtk.c
> @@ -215,9 +215,13 @@ static int mtk_serial_setbrg(struct udevice *dev, in=
t baudrate)
>         struct mtk_serial_priv *priv =3D dev_get_priv(dev);
>         ulong clk_rate;
>
> -       clk_rate =3D clk_get_rate(&priv->clk);
> -       if (IS_ERR_VALUE(clk_rate) || clk_rate =3D=3D 0)
> +       if (priv->clk.dev) {

What about using  clk_valid() ?

> +               clk_rate =3D clk_get_rate(&priv->clk);
> +               if (IS_ERR_VALUE(clk_rate) || clk_rate =3D=3D 0)
> +                       return -EINVAL;
> +       } else {
>                 clk_rate =3D priv->fixed_clk_rate;
> +       }
>
>         _mtk_serial_setbrg(priv, baudrate, clk_rate);
>
> @@ -255,7 +259,8 @@ static int mtk_serial_probe(struct udevice *dev)
>         writel(UART_MCRVAL, &priv->regs->mcr);
>         writel(UART_FCRVAL, &priv->regs->fcr);
>
> -       clk_enable(&priv->clk);
> +       if (priv->clk.dev)
> +               clk_enable(&priv->clk);

Same here,  clk_valid()?
Also, this change is purely cosmetic, since clk_enable() already call
clk_valid()

>         if (priv->clk_bus.dev)
>                 clk_enable(&priv->clk_bus);
>
>
> --
> 2.43.0
>
