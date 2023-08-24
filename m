Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCADC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 11:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9BC8658C;
	Thu, 24 Aug 2023 13:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kcrSP1Fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6683B8657C; Thu, 24 Aug 2023 13:51:54 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9208658C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 13:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-26f381afc15so595877a91.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692877910; x=1693482710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrJtopPy/e62K7LG5JtZcjS2lte78NT4Riz4TOeQFYk=;
 b=kcrSP1FjIH2HRlhzLJ7zMcdt3ktrTDymAoRZCGIbv982D0+OnHpr3nJdPKQyy/muXs
 Qb81jZ9M8lNsdDKwykcnOQte8YW/mcHRWzfPZ0w57RD2MOt1cutLlKLYVaRWXX9ZZ5nu
 RrefqgIwTtVR5INCrlYeYlWcjeV+hnBUBMHzYLF0f7FrJihDx7ppmCbhGdiKEbfhdeoZ
 IFNNvT8LN4zW4XwaSz8sTnLZIpf/IQ9XdVqdEdzg/+4jp4gbHy5FnGjd3cqiNrh3HolR
 4Ll3CjBvRG1AYQ4llwvyxg6/0c+MWQyCFg014ntX7NVOwuIbu85nHLjzaiNsnVnzNoiE
 2tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692877910; x=1693482710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TrJtopPy/e62K7LG5JtZcjS2lte78NT4Riz4TOeQFYk=;
 b=ZtcQUnDbAqz0Q0SzLRWFOXiaJ/1dijyPdn2Fy8EMRrvg9uG7pZxHsvojPITjVimrD4
 cDvn9ulmAU3TG6La9ttT2Erz4K8EakOK8B/6JbBe0ZpP/z5eyNNmFMPN4jmk/JeBoMyu
 38m+koCtPuh1o/Pw3kB+FIt+LRkmp3cLaFU+mtqoCcvT33nZfw4YygO8Os1XSJzU7BZx
 0PFeKVxQ5bDOHfRL9n0LO4bc+30QTDAQLeXiwQOuo2mxIo2WD/RL+0xrxg25ERlcEqiZ
 xxCmEtsfTS3PM5Nfdo5fs9lrEfxQkAI4it0DzNhS6vZsCNp5TMtvisU10vlXwdkcMkxX
 GvyQ==
X-Gm-Message-State: AOJu0Yx3t256LCyMUVSTdH9fhYx2WeSzioa6OhgRwskMUULg7h0g2B04
 z8lBnd4wGLVeQIDGmGORIrauxFQZ01PF5X6+Cb4=
X-Google-Smtp-Source: AGHT+IEog/abqVIfoWI9hXofw9EPoCvqzMQTKyW47YFsJzNc8DHhzSoDyxbtVEKJt0vLsc8cid2QN1K1AYrC9TWp0xo=
X-Received: by 2002:a17:90a:2d8b:b0:26d:414d:a98a with SMTP id
 p11-20020a17090a2d8b00b0026d414da98amr13960272pjd.1.1692877909851; Thu, 24
 Aug 2023 04:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230822221726.8355-1-marcel@ziswiler.com>
In-Reply-To: <20230822221726.8355-1-marcel@ziswiler.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Aug 2023 08:51:37 -0300
Message-ID: <CAOMZO5CTwWXyspD+FksURKmJLD7H3YbWcrC7zb=MB2RJGJhcOw@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: verdin-imx8mm: enable usb sdp spl
 recovery support
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

Hi Marcel,

On Tue, Aug 22, 2023 at 7:17=E2=80=AFPM Marcel Ziswiler <marcel@ziswiler.co=
m> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Enable USB SDP SPL aka serial downloader recovery mode support.
>
> While at it also enable fastboot support which may be used to
> subsequently load further stages like a Toradex Easy Installer FIT
> image.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Yes, this is helpful:

Reviewed-by: Fabio Estevam <festevam@denx.de>
