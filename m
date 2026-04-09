Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8487A10FC456
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 00:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74E983CF5;
	Thu,  9 Apr 2026 02:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NOLwJ7HK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF2783D8A; Thu,  9 Apr 2026 02:52:04 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C6D83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 02:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a2c9c5ff87so343898e87.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 17:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775695921; cv=none;
 d=google.com; s=arc-20240605;
 b=QfWHl6Mphy0MUFnL6F1XZK7RQDTq6VrEKQfqvTvgp+OrZ9/F2g06htmkHQF9XOtYso
 esz1rztpE4k/4vjPG8txebQWROixw9c8S+QqtPIfoe/rIb1sAWb7YYywd62VDhfN4uO7
 B7wiB8Ywvtqss/fEJcJietvZLSGP704VlYmWl/dawTXMIF+I5HHuQllfsprj8Za4j0jz
 eMM4aCithmXmfBlv3zdbAqHLYJX973rAOaXqLrHGsrA8jEzgixU8z7twU2l+7odh+Rr2
 g2JLpjD4GKYRKC41DwwMC3g+ckx0p173eggpJS04D/aeymQWX4cVu46PgWP5mzk0xudt
 kKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zp0mHgxX12qO9yHNAR38s2PzauQ4vPmRrUC37waFoP8=;
 fh=aZQv7wjJL/I4FRoPevH+XzyN0/LB1o5az9nc/yo40iU=;
 b=ks83/5Y4qDYGMltS/6fgwjICMZn4CO9i1g8lpSd+ymx2KfTcbjfI4KrVzb3RoHgP6G
 rsFRRBC5lAasc/Yd1FqTy4pWk5eVGz7zwwMRTWSca1/biyQerV6idnzhScHUwXbzA6Lf
 atcX3KoWZd7ZUcwaMEmO4QqALl8HacQEsC49rN2ZzAr7lRk4eu17iqXt44IueGZRxsks
 KDoLxfbDNI4LqmXgMtlMZob4GkDj37IG6OW5JEsR+qwG8e/xQI9bS6rxZlY9/DD5cw7u
 lWTOWRMFQBwmh+5XDHmDYnchg1TpO+qf0BYBlG0rdxjPPvmGZGqeJ06s6QXEi1N3C6NI
 wlMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775695921; x=1776300721; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zp0mHgxX12qO9yHNAR38s2PzauQ4vPmRrUC37waFoP8=;
 b=NOLwJ7HKqQl/KAOw2MpASzeTHAPkeFXbMs/rT3WlEIP6aN1RR5s/pKVi4ozgpUrN7O
 MXfb/xn7FULaLU+oKKvNVcRM/uAlWMji9fStcgwJ1c292IYCRUEAzPn3aisbEyHy5CfZ
 tKfQqTktDBP5zt542scJuQs4vIAlWLtyxGfSyP40t7pnuI8OUD7qYir9A+2Zk7kcuBB6
 wSA+KOG+n3hvPqcRqvmkDhfUJ4sddhc3L1TJdUdJXfcbvbtPJKNaIViMLX7qkJrythlh
 O8IyJ47CxT5SSSGUaR73E88cx+MDEr6uaK8wX+OTMW3gJOgeFQyyX4tZ8FWVDg1bgFLI
 vSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775695921; x=1776300721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zp0mHgxX12qO9yHNAR38s2PzauQ4vPmRrUC37waFoP8=;
 b=PRvskJuwIDvjlXV0XqTntoJWPULbrtN20BwwGjqQzPsW6d6zL1bHQYBtKD9Eock6le
 oNUm4aUkESO6XtOAHDgmdMdxPP3A2QKSadek07zFVt7dXT6ON+SRzxEbIlBPjdVB64jb
 O5zZgbckQuzg91/L/aQWJjRg9hELODQd0KOv8AvqkTFKrPfEBnbZ/aew5xC4pquBze0i
 L8bXtTN7/PzmuqMcjn+Y9UmO1AwOYcfH8eWYt6UFUbxR1IL0t3g5nUubAeT9iTVsKOM6
 FQHKiTZRvwX5pk2gL8dIHLTc1qv12HheqUU5WeaDNl7XIrNf9vT1jAPvX9Cuq9yPG3MQ
 PbYA==
X-Gm-Message-State: AOJu0YzRWEtLO+aKcQiksTPdb1sQs2Xfxg6ET9XU/rBPsobIg2nHcO/D
 UymqIGloOA2O1N89v8v5ZyW8uViXWgsjKyNNOtbaI5fd7qya+hY0k0qLceSAEVO8zTcT3vSPiTb
 gdjKhQDuwwIvRtB/+vzqm1ix5Ovj5koB2WHGN
X-Gm-Gg: AeBDieuuugZSrYF1b+hxkr0ckFJ75NISY2k5OXWL6YvaphKUQDtTZUMW7EnAV1xlIve
 E1Qha8/iwFOyDjJMOVQhCxMaQl7rr/PybqLcMoJMELRfiwS2UfHD4ng1xWfPQB/12P3iWnR0cJd
 4KGmd9fRM9PfAW6dBmyWBgLnr06FrKyRzMU42b66OETclh5a54yWl3sVCW+Zv8CPo/mte6nFBPN
 8ZrkxHZbKSUY3LHNuHM0w0BZ98aD+MWo8mDDAn8qeNUI3zlecFex8r3KQPiLLmwEk5zESglEMdc
 /ZxuigujUvL2wPeNI0HuIsjP3xvbw4Prgad9trJy4fMBt6wzdndWUDURATjNJqxEZiw/ZcMe
X-Received: by 2002:a05:6512:3091:b0:5a2:9bef:4fb0 with SMTP id
 2adb3069b0e04-5a337557028mr9062519e87.11.1775695920615; Wed, 08 Apr 2026
 17:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
 <20260409-ten64-add-usb5744-v1-5-2094496f72c8@traverse.com.au>
In-Reply-To: <20260409-ten64-add-usb5744-v1-5-2094496f72c8@traverse.com.au>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Apr 2026 21:51:48 -0300
X-Gm-Features: AQROBzC97fT-Uk_M12DE_pERgH5AKdKlXaTKkY-gKhFQNUJdkak6EDjLr5z13Yo
Message-ID: <CAOMZO5CWk2pC+RPxTf4rHTUirmC_VmyvAqp3r==ydO_-UNLEBA@mail.gmail.com>
Subject: Re: [PATCH 5/5] configs: ten64: switch to OF_UPSTREAM
To: Mathew McBride <matt@traverse.com.au>
Cc: u-boot@lists.denx.de
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

On Wed, Apr 8, 2026 at 9:26=E2=80=AFPM Mathew McBride <matt@traverse.com.au=
> wrote:

> -CONFIG_DEFAULT_DEVICE_TREE=3D"fsl-ls1088a-ten64"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"freescale/fsl-ls1088a-ten64"

You should also remove the local U-Boot copy of fsl-ls1088a-ten64.dts.
