Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05F51112241
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB4383CE3;
	Thu,  2 Apr 2026 01:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ThttCO/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC8484020; Thu,  2 Apr 2026 01:25:22 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBCB839DF
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66c24b42efbso477000a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775085920; cv=none;
 d=google.com; s=arc-20240605;
 b=eJHKtCUFSBNVUyw53Agh6KiHSb6blZiaOaku04u1cx1gsJULvEIj3eK9RY9JsAlik/
 I+DKMlmiv6wwOVCkBEi99RZk1qFQY4m5hwstZ9Ciy1cxBCyBMrvpU+fkbUfoxksu8OSm
 frd4EIwAjv+o6VurS0iJ9GFCDG5PvK9Jo/xq95RYQ0rQzY2WxidoYb3e5P+skae3x4wT
 Ya6f2PS28s436hPPyW6nkOsp8N62495lOpY18pjnfASGGoEG4elbPs5OebY+XwX/SpHY
 9N+56qo5GeTWx6LMFCSdbVxHp7/9DlDVZRRguHVPkT7UA9gohzgDKYic5GXpNd27NOiy
 8pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2TX2vLTRp4XLREjjy8FsfJYMp1MhoXK32V/fqauTvCo=;
 fh=i3GqeO5ZnV6sAGepUdA4T2IyAaFXEPjTFzVpinmyJ3Y=;
 b=Nj9elVJ4bnCVQQ4F9rdyB1VQFeoYdTHgMjghgkr4NDOaCjIlKYleaPp47Hl4mCQZ4O
 WVhlOOuwLdOumAdowwVeU3MHb6LJ8ayX7cu/+A8bo4QtG0PKuWnbLby+uJ4SGTWDCh+y
 QeLBdXy4WOWbRUmSbBu/Vb/JBp7wL03MluV7BwQozDu5txb/ndIA2QfUD4KW8cKvUUJB
 3duDyfiXgrV0M8NzzIW02IiRE0rZP+gcX0jciWj2MCeDqHgCq2SAXCXAJg7oLJLheske
 U4imdvpA0mXaI95hpzn9EBdgJULq317Q2Qe09xGqZoAW3PE+Gw1I5SqBcogHWMLIB6tz
 sFJw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775085920; x=1775690720; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2TX2vLTRp4XLREjjy8FsfJYMp1MhoXK32V/fqauTvCo=;
 b=ThttCO/iEKDhNz2LYFEsXMT2eFpg3W2b7DTgdzhAcMw+ccWPwN+nkJhYD806MDa0w7
 KBNBx4p0YndmKMgUHyivsNwhHpHOFBtjrgHmBdZSe+FKzf5s2khCGw2vZ5oOOYn7MRHV
 bwzq4iwX4LrghtVbGKWCYFNAQT7PnT47hYTWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775085920; x=1775690720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TX2vLTRp4XLREjjy8FsfJYMp1MhoXK32V/fqauTvCo=;
 b=Ak1n1DWQ3d77dahs6Nt6mhNHQPCWLzp63hI3lprz1NYdIBh4jmw7QWSOZs4SnmDGIT
 /CFfmMR5fWOVf3wLV2UMTab0DaPxSr3PzFFds8jUeOBLhvQoGREMNCgqkh5+Nqe37Ztz
 n+DuOnX629O4n5V0Fkdw6qj319HT2tiyYpL7Gtz1H7L3ZdtrBVZXenFYDeBJdTpSt0tC
 uptcpDMryMB+ITAV0x127Xedoa5t7+Nl+rMa52GIO08bT0xGH/kDS1EKSEXrVy7QXBMi
 GfCwhITJ+wUtWIcHzv9W32AzX9JuXEhJCAljXAm7Afp/jW3m5+cXBEkAqiSLKboCXpyX
 wR3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlvNP4S6W1teuSO0hYZftp/KEyWiJZ1nrz7J5bIXh7uuS0qBF0Aq8uLJGiqsSZx6PyAMNbPvY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1EILEUQzspxzTQL7VnJBuDZEzxkkd3crXfZzV27AxrqDBbkF9
 I1LS2Nvr5Oztuj+sAc0pxn2EFds0AfkgQcRM2xYuYRhxIiFzOKT4Fnxq2DkgssIny80kLW+nvYC
 4arVygiqroHLckMeVSOZW57nxs4VQNwEsWATBih6Q
X-Gm-Gg: ATEYQzyGQXTbYQMHHxxuURLCdVxQfRwTxKYxCwlEjXQnYQga1vUPVShuv9rXOXx5PM4
 pIQC8J/nmtG86l6SBhxdzdf1KIAl8lEO3eS9zpKzzmga3L1md0ivTOMN8L8j2zBQsIsoa09OBEr
 R8Lzq6H9hbdnVueHReWxOkRRdp9mejvOeKFd2ZaIYMT+JrSZx2GPqv8Xcxi4Od2cicq+F2lc1DQ
 x6WyMZ23XwV+qFH/kisgmPjmryd/skwvn+FFkAXAhU5eEuptjD87XrKi0edhVbhyyFBSONSE1pj
 2sIBuA==
X-Received: by 2002:a17:907:e118:b0:b97:1d24:bfd1 with SMTP id
 a640c23a62f3a-b9c138e19e0mr274384166b.13.1775085919995; Wed, 01 Apr 2026
 16:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260331075338.2391-1-ansuelsmth@gmail.com>
 <20260331075338.2391-4-ansuelsmth@gmail.com>
In-Reply-To: <20260331075338.2391-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 19:25:05 -0400
X-Gm-Features: AQROBzAy2O3RKlIoqP5zQKTVsmwmfEW4xQ35Ipv6C2wz0GplcnvK-G526Z0rCUc
Message-ID: <CAFLszTgfAF_xWPZYiw2Q_sK4m67WjnUuk=aUsA_gtwkt7ctadQ@mail.gmail.com>
Subject: Re: [v4,
 3/5] misc: fw_loader: implement generic get_fw_loader_from_node()
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen <justin@tidylabs.net>,
 Harsha Vardhan V M <h-vm@ti.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-03-31T07:53:19, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement generic get_fw_loader_from_node()
> misc: fw_loader: implement generic get_fw_loader_from_node()
>
> Implement a generic function to get a FW loader dev from a node.
>
> There is currently only get_fs_loader() but that is limited to chosen
> node and is limited only to FS loader.
>
> Introduce get_fw_loader_from_node() that will parse the
> "firmware-loader" from a specified node and will loop over all the
> available FW loader until one is found (as it will be probed by the
> dedicated compatible)
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> @@ -90,6 +91,45 @@ int generic_fw_loader_probe(struct udevice *dev)
> +static int fw_loaders[] = {

This should be const.

> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> @@ -90,6 +91,45 @@ int generic_fw_loader_probe(struct udevice *dev)
> +int get_fw_loader_from_node(ofnode node, struct udevice **dev)
> +{
> +     int i, ret;
> +
> +     node = ofnode_parse_phandle(node, "firmware-loader", 0);
> +     if (!ofnode_valid(node))
> +             return -ENODEV;
> +
> +     /*
> +      * Loop over all the available FW loaders and stop when
> +      * found one.
> +      */
> +     for (i = 0; i < ARRAY_SIZE(fw_loaders); i++) {
> +             ret = uclass_get_device_by_ofnode(fw_loaders[i],
> +                                               node, dev);
> +             if (!ret)
> +                     return 0;
> +     }
> +
> +     return -ENODEV;
> +}

Hmm, looping over uclasses is not the right approach here.
uclass_get_device_by_ofnode() will find the device if it exists in the
specified uclass, so if a device with the given ofnode exists, it can
only be in one uclass. Looping seem unnecessary and a bit odd...

How about using device_find_global_by_ofnode() to find the device
regardless of uclass, then probe it with device_probe() if found?

Regards,
Simon
