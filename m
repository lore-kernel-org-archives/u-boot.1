Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7699CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A571186E81;
	Fri, 13 Oct 2023 17:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fz9THo8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A97E86E47; Fri, 13 Oct 2023 17:15:10 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB14F86D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so357411266b.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697210105; x=1697814905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4o4LRx5Xo7FMk69fLoiF6fSvMHp2g/BRWGIjIKGtQ8M=;
 b=fz9THo8Fqh+7aydvdqTi96fWMnbIPExZGeaZgMgumQfgxOB3DOhKKXy9zgXi3AYvYW
 mO4EyQu4J1pdZ/ohgV0yoazFGkPKV8mGCKYB66Ni/7fOx+1f3CMc5zuguWMpDfDBTFg9
 smjbOQPn5HGaxJtiwPIQ1JCwHiuSE8BmKzj+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210105; x=1697814905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4o4LRx5Xo7FMk69fLoiF6fSvMHp2g/BRWGIjIKGtQ8M=;
 b=d9d9ySlUl9YyGsPM2wGt/w0HRuEXljthOOsWZmAqsIFIbQrS8OD/7hIwqsvDSGpZMu
 jT09UUGP5zWFkaqa/O0YRiC20aTeTME3Z/65hH+3pAU3/EQqsGybUtkiEgPLcUlTqsXR
 Oxo5GYtoVbuoSrfUdeaJ+qQkc27Xh866Vruu6Nn3MCaq0KTAMCDJPbmWRPXBDW5zNM2e
 2OdCBNdxSeAsJYcBhp3vgbwifE6g76GcUN+tmbLzglBImHXyOtsU7ytZz2pEy9RrAwD6
 +owX9NHCiSWtLjk44dCqWoV/WzM8ipUfAamyQgzhe+k6vTcqqvehOQiqa2I3fgsziCNc
 17KA==
X-Gm-Message-State: AOJu0YzzQwEdkcbr17BjwgCMU79BAqc/z2SkwYm+QIaLPgF8wcaVUVh1
 AJ1LzRO8/dBFlYml/Ne8cfTstrUO/NbXMz2Xrifqkw==
X-Google-Smtp-Source: AGHT+IGui0iNWxwoLkPp3fRLnv6Ua1gMag7EvBYo6N5yyuzVj6bkDxQlGF5Ap6oy/J6q72zl92L9gxXrBAau/goRzE8=
X-Received: by 2002:a17:907:7787:b0:9b2:6f52:586d with SMTP id
 ky7-20020a170907778700b009b26f52586dmr24394415ejc.50.1697210105188; Fri, 13
 Oct 2023 08:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <490f2c07-8aa9-3559-0b6e-04a45f98a671@gmail.com>
In-Reply-To: <490f2c07-8aa9-3559-0b6e-04a45f98a671@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 08:14:44 -0700
Message-ID: <CAPnjgZ1z+Lc6FUY+YSpB3n2eCOQkTBb_Ei0CsL_jQX-AvUSrTA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] rockchip: cmd: add rkmtd command
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 u-boot@lists.denx.de
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

On Thu, 12 Oct 2023 at 13:52, Johan Jonker <jbx6244@gmail.com> wrote:
>
> The command rkmtd creates a virtual block device to transfer
> Rockchip boot block data to and from NAND with block orientated
> tools like "ums" and "rockusb".
>
> It uses the Rockchip MTD driver to scan for boot blocks and copies
> data from the first block in a GPT formated virtual disk.
> Data must be written in U-boot "idbloader.img" format and start at
> partition "loader1" offset 64. The data header is parsed
> for length and offset. When the last sector is received
> it erases up to 5 erase blocks on NAND and writes bootblocks
> in a pattern depending on the NAND ID. Data is then verified.
> When a block turns out bad the block header is discarded.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> Changed V3:
>   Split driver from command
>   Split header
>   Restyle
> ---
>  cmd/Kconfig  |   8 ++
>  cmd/Makefile |   1 +
>  cmd/rkmtd.c  | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 cmd/rkmtd.c

Reviewed-by: Simon Glass <sjg@chromium.org>
