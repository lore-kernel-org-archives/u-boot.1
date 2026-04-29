Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93247FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33744848A1;
	Wed, 29 Apr 2026 16:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d6gCyEZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B72E848B6; Wed, 29 Apr 2026 16:16:43 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130BE84882
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c01854477so988595766b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472200; cv=none;
 d=google.com; s=arc-20240605;
 b=iYd2FjSYGXtnUzKtfwCOZFzztFiwoI8mOCA4lQpyRsBSX1JcA0MuuU3bFvrEorjM6v
 nbDgHGUNnfbnTFiVlErcn696qKnR7jcMn9ec5+Nc7sV8rVc+NzYnr4r0jSAldIIv/rud
 0tqlFAs3LiSrUtBF95X2SHeX8lATAjf8drHO0Z6ZebNd4I45PIv3wk5nqwihi2TINtKF
 aE3K92OVfKOc8mhmaZBkpoEozpM9RDNHMFInG22UFtplMsRcKJbCxk+sEH/OSCEpBqdz
 enxnqy4Izd1ybXnJDM+GmO4GMatJyXwIBJrrf30x2r20qPcjy65lXRevhSbS4d+8AqXD
 hKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I3nbwo53eWIPs0g0HgdkpK6xB3T2C1iTzLgigPnkQoI=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=E4MtxdcB0EHVxF3S3ypxZMnv9NtdyCwYoOAW/xLGTH2s6lkIggdhFo9X6XlofAVAUA
 bFrbeTSHhWGEdNi2RcNc+8qO1qa5zK912UcFd06dd+Jwwtiitn/ShqiYd+OZWTOT/THc
 5w6NyiLEO8Sba1TOUjWIVCnamLW5q6zFuzq+78MHgtuOjr9CfoeJDqAMWcLoe/v3miIF
 6IKHiLTU4rDxmjDXalOcRo+A6YRtmnvXi7pYJqE5EaiJnycs4g79fFtEDpMaLxp6Y8CO
 txUdfq2dTkJqCZp81QrgxUY+RsGAEeOWhY67s5Fl1BOJ+up79bVH3ONClSjW3a9M8yHB
 SCmw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472200; x=1778077000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I3nbwo53eWIPs0g0HgdkpK6xB3T2C1iTzLgigPnkQoI=;
 b=d6gCyEZjDBJMpO1sofsMOaW0EmuJAOPYzyNn3+bU99EH5/8E6ZknYZJhpm2uzHx8ZB
 ysfMWWWwHcswW3xOyNSXG5E75Npvp6vUiJFIRD6dbjZUmEsneUNW7jV+voeg9Cx8cwGp
 MRXHTD3V4jscT1yStT/iYZ5Hz7Idl6WqW0MgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472200; x=1778077000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3nbwo53eWIPs0g0HgdkpK6xB3T2C1iTzLgigPnkQoI=;
 b=J+WTRvA0bkd8jM9W/VM/6iydw1Q4BYrCnBjwbwvtFltIP5ntVl9KZzUNKbluk5Tv5f
 XuRxXjCXWKryrjFsI+mvR84sb9Yh3Ej605muRexyQGGd/q1KfC7IjdiaTwkeQE02Jqp4
 1AHc7X/VhnMEsWK6COz6r9lXFBHLa5m5sFtOTA7pd6bGNP+ttWz71UFQteucg3DdSIKJ
 tsPGilS1ahcI5sIJtPUbe7DRkJbYZkPP11p/oA3PLF1Hwrd3FzAJSMMVQSWiGNJi6pqV
 lgxWjKvPTo+XKxBakiZzQX3vXwnbSzmlPOR0Fmi8CXCu0zcQz2ECZhWTM7Wr8gIQNVek
 Pkzw==
X-Gm-Message-State: AOJu0YziFtCeb8xru67jWpnLgMnYCqGm6pMokVKZUeBsVYxzswhKvxnv
 sTUUnYJBWAYOaYb7fwu0cv+zouPcA7EIK9Yl8HBLLaWCdBvZxfv3N3jsXlGo1LX9xm7LSJkbMVU
 9oSkIkjBLXUoBY3js6ADFWkYCV5bJ2rMl5csAxe9C
X-Gm-Gg: AeBDieuSGMXLMVJLfEj8BQCXwi7/w0QJj91S/lcvHeWNNHHwqG0RyyNNMqclvuPo4Gx
 nOmqAZg3Sjkb5RBDGSUsLvYdAc2hhwIg+/4PMIW50Vsx3HJ8YxnkJBwNOfiAllPRZonGHsioE1m
 5zXQzECAyvsMFCnJ/y/FWZNch83Nehb+ewosy2ezTsNn0c1mvp8QkRh0c8ni/gow1raMG81/zim
 8otuR2qdMP7fJq7bjwYM7c34u0Wt5WjLqstFr47Vd3CPRob97EwzUeNdMSoXhkqpWpgbWdY2eOy
 e/blvqZbEY0quYTd
X-Received: by 2002:a17:906:2092:b0:ba9:bb46:345c with SMTP id
 a640c23a62f3a-bb80520b3a0mr324387966b.45.1777472200238; Wed, 29 Apr 2026
 07:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <53cf194ead51b7d52dffe9013a8e192cb3effb15.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <53cf194ead51b7d52dffe9013a8e192cb3effb15.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:16:26 -0600
X-Gm-Features: AVHnY4LOFtmMzIxE5_8u-YzfnXjZPX2dhGBmQzYdWEQzSsul0bzfkCB6yAmgqUQ
Message-ID: <CAFLszTi5QJUZ5uKAc7W1nATXSc_yv_WHaFXhzcgrpF2bhupzRw@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and ramdisk_addr_r
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r
>
> Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r to the SC5xx boards.
> These variables are currently unused in the environment but will be
> used in the future once support for booti commands is added to the
> SC5xx boards.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezlite/sc573-ezlite.env         | 4 ++++
>  board/adi/sc584-ezkit/sc584-ezkit.env           | 4 ++++
>  board/adi/sc589-ezkit/sc589-ezkit.env           | 4 ++++
>  board/adi/sc589-mini/sc589-mini.env             | 4 ++++
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 4 ++++
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 4 ++++
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 4 ++++
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 4 ++++
>  8 files changed, 32 insertions(+)

> diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
> @@ -3,6 +3,10 @@
> +fdt_addr_r=CONFIG_SYS_LOAD_ADDR
> +kernel_addr_r=0x84008000
> +ramdisk_addr_r=0x85000000

fdt_addr_r resolves to the same address as loadaddr (which also
defaults to CONFIG_SYS_LOAD_ADDR and is what the existing FIT-based
boot scripts in adi_boot.env load to). When booti support lands,
loading a kernel image to ${loadaddr} and an FDT to ${fdt_addr_r}
would overwrite each other. How about picking a distinct value now so
the future booti patch doesn't have to touch every board file again?

> diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
> @@ -3,6 +3,10 @@
> +fdt_addr_r=CONFIG_SYS_LOAD_ADDR
> +kernel_addr_r=0x8A308000
> +ramdisk_addr_r=0x8A800000

Please use lower-case hex. The gap between kernel_addr_r and
ramdisk_addr_r here is only 0x4f8000 (~5 MiB), which is tight for a
typical ARM kernel. The other 32-bit boards in this patch leave ~16
MiB. Is that intentional?

Regards,
Simon
