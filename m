Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389BDCD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17EF84942;
	Mon,  1 Jun 2026 16:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bNyvIII/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4A384946; Mon,  1 Jun 2026 16:58:37 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5CE8493E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bec449d0af2so170621066b.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325915; cv=none;
 d=google.com; s=arc-20240605;
 b=jvENpawLtvkOmna1CrPA+9iQVab7ijhnzP/ruBRq0VyvdnyUMUV5ieounKvoBxp30r
 ws5uzq0rsif8bdujRV1q345Pv+INR+T0SgR05EYMcfa/W28iD7USdL/tbb4xOZQlKuRT
 er/nMCfPO3wNDtVdg93wgd9e41NRoy4Qpgvi9B6/PXEGY9x6hxFccQ2Jx7CfUE9qhJKt
 8OwNkos1IE3kDXXXOIItpsTX4NG5qSMsx2tulqB9te6nfH8xKZB6fpgAms8VZAlqhHXK
 TsjjL2yFydmMN9tpYjdAZeqdP7BdorBjXg8oKIkOhr2n5HS9PhUvAz8UbfYYvYdBuIt5
 qLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eSwflb93czsgQUDE+0K9Joy9L5DROLyJhFwZkMz2CMc=;
 fh=aCaOJZgkkxSl3kG1DMjk4JErljQ5rHgaDbhrsapChVo=;
 b=jsk4xaqvLAmJ5jvSYgAdqA9qod6iQ+DSEU9YtcfVKTfy1LmWLDL2gaky8bke1GOA9h
 g4wrVla++jsSriMMrfa1DgCA+sAayS+bT9UscUwf2cimlLXYVbpON3j/Soaog+liOPPg
 VetKj3PQl8VAI9Ak+qL+TmpaDKYh3PxSg6OTBQXcNQgVgYdvWg6p9aO6YRpba9yKzShl
 nXSNpSECYwSbxI9s69wpl1ioVdCMhKdkED8cBtXsfOabmX+sPMY26ZtOWX+cDNEWGcue
 UPIcLAmtgIw0S5FetJNX5mBEbRYe5R0CzrXqSmeDNE7aJ5Bg37Q5ZdDb8cSLNfmc9yKm
 77JA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325915; x=1780930715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eSwflb93czsgQUDE+0K9Joy9L5DROLyJhFwZkMz2CMc=;
 b=bNyvIII/nMEGj1lI2CG6O9Zc6eCQ4nFsfdtGQOZY4YH8oRbF8aC4jDV0ylYPeiYIMG
 EuBrb7Y9PeIN74ncvIlrCjRvXqxkKICa9lkCxl1ZID+vf8QiuJZQyiRnd+SfG3geY8I+
 BLAL0dn3t1IFHhC4/vKGMYb/+t5HncNYTRyW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325915; x=1780930715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSwflb93czsgQUDE+0K9Joy9L5DROLyJhFwZkMz2CMc=;
 b=nVeiBa0JYxdwm+QKlRl+NOs6ogpEHlJaDR55v67pq57rGno1nMnaU4lEkcBTdpDcLu
 HqjgQQo8BUpFVOV2s5ZAUAnbJRXqOWeQoTBGD9c1fmbSfOAoAUSCz34VSaS37k+FnDSE
 KxrD2TbTpi3dMzZGW/lODwwFvTHmOlasJn/WvHuLgHMR1j7s4ZEW6s8YQHXp8k4JXD7i
 19CUeAXUhMWuY/2jurl/b+t9ZRblc4iBjM1Ys+Ttkfp77+b3YDip8J22xJOqGfA/6o4L
 ySJh2TawV4q7Fyauzbe4tSptwJoltbAsFd4r81MC0YNKFKkGIIYFBMTV3wvPQlxvPF3u
 eL3g==
X-Gm-Message-State: AOJu0Yx5Uy+JJkdj6rWPVHgF12uj81N4CnoY5v5fM4C1IoV3tiMDywhC
 P2yAero+g+WLxnViy47dL6Fja4DYggukiBUw5w460vQb5DaKhCzjY3ez14dzqd1zrOgSvVorCyX
 smW4HZi+EPVb4sUxs1OBiFw2MqDw0Z51d2KsxWffn
X-Gm-Gg: Acq92OHKz47zbQF3HvwxkFibYXfMQYEDTUPeRwtrJzpmxMOzsEnfnyjfHGoPYcXtLt5
 vmtyHLOFy62LKZrLBrTV657bBLqcGa+E4VUahC4MDRl7BccoMiX2W8khB8ALcU0E1eqvdopEJYg
 TImjfIfwsbp2x3XSTt2gRLwMlituA1O5/haegYlqpdYaKb/exAZaTtQOmXVlH9uNs8eQqwEnFe7
 pZJKJ1IsJe1yAkggq2B5WUxmYW/UOsgw9i9ZzQVzwgDB4YfHfwI1okisvoFCKsqd1Ks9B8Oqdbi
 PLsq9Q9YRVAMxtDN
X-Received: by 2002:a17:907:970a:b0:beb:c3a7:9cd with SMTP id
 a640c23a62f3a-bebc3a70a4fmr499073566b.8.1780325914907; Mon, 01 Jun 2026
 07:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
 <20260526-devfdt-usb-v1-3-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-3-a4e22b23bfae@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:58:21 -0600
X-Gm-Features: AVHnY4JAoKW4ObitK-RcS0ljeAm9r35O-sFcH2kRX725QPBBBitxfe4e4vOsUTY
Message-ID: <CAFLszTgjZ2ZtoN6qiZOwpk=LseCmQdXnm6ROK4MKS+2wrErmKg@mail.gmail.com>
Subject: Re: [PATCH 3/6] usb: musb-new: Update phandle handling
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On 2026-05-26T09:09:56, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> usb: musb-new: Update phandle handling
>
> Switch to ofnode_parse_phandle() and add proper ofnode_valid() checks when
> resolving 'phys' and 'ti,ctrl_mod' references to avoid operating on invalid
> nodes.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/musb-new/ti-musb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> @@ -88,8 +88,14 @@ static int ti_musb_of_to_plat(struct udevice *dev)
> -     phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, 'phys', 0));
> -     ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, 'ti,ctrl_mod', 0));
> +     phys_node = ofnode_parse_phandle(node, 'phys', 0);
> +     if (!ofnode_valid(phys_node))
> +             return -EINVAL;
> +
> +     ctrl_mod_node = ofnode_parse_phandle(phys_node, 'ti,ctrl_mod', 0);
> +     if (!ofnode_valid(ctrl_mod_node))
> +             return -EINVAL;
> +

Not quite no functional change - previously a missing or invalid phys
/ ti,ctrl_mod left ctrl_mod_base pointing at ofnode_get_addr() on an
invalid node and probe carried on; now those cases return -EINVAL and
probe fails. That is the right behaviour, but please call it out in
the commit message.

Regards,
Simon
