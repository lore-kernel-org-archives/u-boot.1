Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20BCE9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E59283CD3;
	Thu, 19 Feb 2026 14:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JkB8D9Sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B5683D5D; Thu, 19 Feb 2026 14:11:32 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9788883936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65b9608a9adso1498784a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506684; cv=none;
 d=google.com; s=arc-20240605;
 b=Ev3NmUwYU4tl4ehV71SDKs7TfA5QcC/3/9YJz1MBcwqeTJ7+935Jxn2v9zODzwd5cI
 pkzsFcS82e01ONXPlyjespjq2Y8F6Bb6sNR3EeMjmLLFiMeVWtuuur5IltcC0EkuRgYs
 PLcDrv3FhyV8FM+X0yzYYGN4edMfIhClpEBUBULuoM9hVYGqBi/h87cyi3SEXSJ8WpdV
 ljPypV6wYXcbmcVec83zU9N9KSpuIY32VRoCRmoLM6+FnkzgnR6RoXZPfU1wstyVGjcA
 puXKTaI1djTdE8jric4esTk5s3LyynqGAudSZkRNcQubBVByQlq0RvlhE+5sEcMOzklq
 c/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I/rVbuR4ItP6HjAsu6JmKc9E6fZezyKp9RQClIQrZsE=;
 fh=0ALNrgGuMSAONUmbLKxKJZofitgEWc3Za7mn3DgLpZM=;
 b=GBDXJqSK3gArzr0TN2kt4cG6T32K87Xr8LZTjc4oHRHSv/MNLh3UXnJ2kuwuOJUPzV
 f95jwyc3GSpxt36rjARxMKhZ1CgspN+M8w+gH+Kt9N3z9BHY4kSxC+UmHNA9Og+H2VSC
 ui/n9ztnb42xQkRuItx4C0VBu/kqbvJfMMUZhP+6osH0aIzhfXVUtct9Zn5MtEXDxgKa
 KZla0sRcG5FrHhGJsYfYUpN7QiwSxQdWbyKv3uT0y3XUSaj78Y5ip4ZizdMvPIiRONm4
 6jdxQTSv5Z+a9qbQ/NQ0hA4KscIXJBX3tCK/3MVBWc2KTpEZBfcLUVG4TTzp1sTbWTfX
 hpDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506684; x=1772111484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I/rVbuR4ItP6HjAsu6JmKc9E6fZezyKp9RQClIQrZsE=;
 b=JkB8D9SwSzs00BawN9uTD+5qq+vYk0V3hcqsFKC9dyQejb4aH1BEP3NrkM3Unow/Qe
 NfDmquGIDxKPo2A+rsxBTDuty1vdEMpAQjPsf1HYnOTV38cMBGwyv2tAs/RxBHtYwspC
 dBQL3VEFYn0RHnsABfxEgdkY62dAbc6Msfj50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506684; x=1772111484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/rVbuR4ItP6HjAsu6JmKc9E6fZezyKp9RQClIQrZsE=;
 b=Q+5HvopF1IOvG82ut9ebUOuvwlQlhp3LR/FUYHk3pFjOgX2Tsaq6/aCAQgGs5Hn/Zj
 4H7lqrX1QPVFTS5z4Vv+C0M2Ry3D8quIMVF50mAjuL/HNg1h4Y6RPnc+gdzdA11UN6X3
 +X9QAtBAvQZMJVadRkQpXO+8fJ9s+DOFv9Uq7S4SGltP7eycJPwdpxBkjmGA4A2yYrEA
 vaWXsiUACLLFxF89OTlLVmk+2nZcbk/izBSlC34QVIaIK2SyyBrLzeisx2kOFn2xVzlL
 0QaJFP5PT6eSHb+3x8XOWn6OJaIgQR0LxDXUG/zHa98iB8gpgodNPNU2WAyNT30RZ1HZ
 QG5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4i+WPyWKijMgQbHTUmRkXI5whS6jnOkrvB0tOerWOqpndsZEylk1L80ETbkJPxfJINo9DBk4=@lists.denx.de
X-Gm-Message-State: AOJu0YyHqGMdgbgaT2ZvMJoj3mE5+USB7vp6aAR2gPzbR2Rgmjre0+i3
 UI9cY1W/Zvp6P/LGniHkmp/ewOUUJ+V+5lbqS8QdxzJqzrJAYpWu52DKuLo4QZyZuVfqj//Lou0
 +HQynBS3WBNQY3bT+tuxzqYCJSsHYjTl9IRCFz1Cc
X-Gm-Gg: AZuq6aKH/SdYsiXSKpeCEbuAqRSuUm/YZcHkkgY0gnf/Eu9P5UmN9EFbXH/3YsobmXb
 bc1fGnWw0/7p2JtjA9lKPBCj8QIFY0dha+Aqv8LkkmHJ03z+mblAJ9bJS+ELLEiSQbSnsyTXHVz
 SNbzHFN8h5c6IhcGWyhDZV+LjxJMh5BFOp1mzmycAulgV6mJGQv5+T/PZGXwGD0Tr6+Rs4STyLI
 ZOPNCiiNb8hBeDHE9KBK1/2L7lC7wLSDKRaA/zIVgWcYoYVO7aJSKFrtAKj0ij4uhrUdCC/n+JK
 YgVgPg==
X-Received: by 2002:a05:6402:27d3:b0:659:4a1f:c6a8 with SMTP id
 4fb4d7f45d1cf-65bc785cd09mr9429064a12.12.1771506683631; Thu, 19 Feb 2026
 05:11:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <3cb8b55fd4f96dc612b6a3453acecc0d37ca24a5.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <3cb8b55fd4f96dc612b6a3453acecc0d37ca24a5.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:23 -0700
X-Gm-Features: AaiRm53kDvQP8UAdwnuWIjGpODO0BDiWWV4-X8aEYG6sNjBI74A_ni5tbLpsH48
Message-ID: <CAFLszTikEfShvuir8bsVspZ836dxmceGrE7wNUP87eav4kL7dQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] boot: add image_loader on-demand loading
 abstraction
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:21, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Introduce struct image_loader, a small generic layer that lets callers
> read arbitrary byte ranges from a storage device and keeps a translation
> table of the regions that have already been loaded into RAM.
>
> The API consists of four functions:
>
>   image_loader_lookup()   - check whether a range is already mapped
>   image_loader_map()      - return a mapped pointer, reading on demand
>   image_loader_map_to()   - read into a caller-supplied address
>   image_loader_cleanup()  - release all backend resources

This is somewhat similar to blkmap, but in this case the block is 1.

How about calling it imagemap instead of image_loader? We have lots of
load_image and image_load stuff in the code base so image_loader would
be confusing.

>
> A read-callback (image_loader_read_fn) plus an opaque *priv pointer
> abstract the actual I/O so that block, MTD, and UBI back-ends can be
> added in follow-up patches without touching the core.
>
> Each backend provides a .cleanup callback which is invoked by
> image_loader_cleanup() to release held device references and free
> allocated memory. This ensures safe resource teardown between
> consecutive boot attempts.
>
> The translation table (struct image_loader_region[]) avoids redundant
> reads when the same region is requested more than once, and allows
> extending an existing mapping when a larger size is needed at the same
> offset. The table size is controlled by CONFIG_IMAGE_LOADER_MAX_REGIONS
> (default 16).
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig           |  20 +++++
>  boot/Makefile          |   2 +
>  boot/image-loader.c    | 163 +++++++++++++++++++++++++++++++++++++++++
>  include/image-loader.h | 141 +++++++++++++++++++++++++++++++++++
>  4 files changed, 326 insertions(+)
>  create mode 100644 boot/image-loader.c
>  create mode 100644 include/image-loader.h
>

Having looked through some of the patches, this should be a new
uclass, with a driver for each of the parent devices (block, mtd) that
you support.

In other words it should be a child of the media device, similar to
how UCLASS_BOOTDEV works.

See my notes in patch 2 as well.

I wonder if your tests could be added here or perhaps in the next
patch after this one?

> diff --git a/boot/Kconfig b/boot/Kconfig
> index e5db165424a..f6908e04a51 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1167,6 +1167,26 @@ config SYS_BOOT_RAMDISK_HIGH
>
>  endmenu                # Boot images
>
> +config IMAGE_LOADER
> +       bool "On-demand image loading from storage"
> +       help
> +         Provides a generic abstraction for reading image data from
> +         storage on demand. A translation table maps already-loaded
> +         regions to their RAM addresses, avoiding redundant reads.
> +
> +         Used by bootm when a storage device is specified instead of a
> +         RAM address.
> +
> +config IMAGE_LOADER_MAX_REGIONS
> +       int "Maximum number of mapped regions in image loader"
> +       default 16 if IMAGE_LOADER
> +       default 0
> +       help
> +         Maximum number of distinct image regions that can be mapped
> +         into RAM simultaneously. 16 is sufficient for typical FIT
> +         images (FDT structure + kernel + device tree + ramdisk +
> +         a few loadable sub-images).

It doesn't seem worth having a limit and this would render some images
unloadable. How about using an alist so you can handle any number?

Regards,
Simon
