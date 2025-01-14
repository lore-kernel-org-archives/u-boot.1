Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7193C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF20806E8;
	Tue, 14 Jan 2025 14:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bd7MA1Ip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B51380657; Tue, 14 Jan 2025 14:15:14 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9005C8022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso1056342766b.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736860512; x=1737465312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cPdrxToXg97SXfGCs6oWNtzUiTdufb6t/MBkbcy3uz4=;
 b=bd7MA1IpVos+hmPenoiZgJhsGunt4lcnXqAWXyN+7KABVro0x3LmEDnUrrrWv93TDk
 f/XdvqQmQLUpVbwMnJjmMibUgYze3LJvWW7hwvRLnCdh2bEKj6FN1oPqt+cX5aefelK9
 GGs5+DdrNz0Hh1ZELj3gNTPtrvMq4CdtC6+nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860512; x=1737465312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cPdrxToXg97SXfGCs6oWNtzUiTdufb6t/MBkbcy3uz4=;
 b=PZwMsevzuwJGeo1IAckKRRGup+o3begcc/49auLHn3rTBJvPQBfTK5ScG+XvsE7Rkd
 ykHjslG+isaFdfNprV9aIN0ROhBYZoqK0X2ncI7fxqzswt4zVLtPFteEJSnE8zBF4G0Q
 9D/8DZhY7oe/HKzSeY2CM2krXflM6GzzaKV0godOyTo3HqzzmilbS9ozsYsKMaW3aINQ
 wY+LRajMY7HvIB+7yE43ZqTzsRKsc2wqOAYDKUIgCLjKZdviXhgndEpmABQDjWftHXWI
 YEpz473Nw/bCMn49ZzHV635TiNwwhK3ySNpRBLr3roxE40BgMxDAzcC/XUbHsJx+t/GV
 34NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViHQ+Lh+v+mP8M04CQTqgXj+18iR71PLLMoukyPnnAQYzWJMu6SG0umxjyS4yScfI9pEZ8Vls=@lists.denx.de
X-Gm-Message-State: AOJu0YwqtjWTLa/Fg0GGHY+ZlMsXHCWy0sdEvT0Sxn1kUhwTMRGTE1HH
 yGYpY/sqFgoBtOSE9faBy2BgQDqyzRfkJHtukXML7qwPhkHbM4lsTYyuxl+I1fjT7LvsI64rK+4
 DfKz6VXC+IG28KN4MxgUIvxVKY9DZL9SeGaUU
X-Gm-Gg: ASbGncvqygCtfGJFhiBOnki8feQZeU/zX9STG/u0ND+zS23q0IhVDIN6rmnr8Yyddh9
 CmJndBXzue+lr8kIVB69IH/xcOtR+NCxVMLtrUfY=
X-Google-Smtp-Source: AGHT+IF4NCsqmGWIHuQL7xsDvECrBiqbnB28BoADt09wN5X4bHWAokXRgqYXZ6gU/oq09tmV3JEwNU1lzVy4F5Fl7b0=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id
 a640c23a62f3a-ab2ab5f6f1cmr2193031166b.32.1736860512050; Tue, 14 Jan 2025
 05:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
 <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 06:14:59 -0700
X-Gm-Features: AbW1kvamAW8CpLyC5JXsLCQbL8b0C7FqC1xhXyk_jGk4bREdXnev3n33WpuKK_Y
Message-ID: <CAFLszTgdcz_0AgU51USW0PPQJ_O1tO42d7LQEpNCRajTK3FeBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] common: fdt: hand over original fdt bootargs into
 board chosen handler
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>,
 u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com
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

Hi Dmitry,

On Thu, 19 Dec 2024 at 14:42, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> Sometimes, it is necessary to provide an additional bootargs string to
> the kernel command line.
>
> We have a real scenario where one U-Boot blob needs to boot several
> kernel images: the vendor-patched kernel image and the latest upstream
> kernel image. The Amlogic (Meson architecture) tty driver has different
> tty suffixes in these kernels: the vendor uses 'ttySx', while the
> upstream implementation uses 'ttyAMLx'. The initial console setup is
> provided to the kernel using the kernel command line (bootargs). For the
> vendor kernel, we should use 'console=ttyS0,115200', while for the
> upstream kernel, it must be 'console=ttyAML0,115200'. This means we have
> to use different command line strings depending on the kernel version.
>
> To resolve this issue, we cannot use the CMDLINE_EXTEND kernel
> configuration because it is considered legacy and is not supported for
> the arm64 architecture. CMDLINE_EXTEND is outdated primarily because we
> can provide additional command line strings through the
> 'chosen/bootargs' FDT node. However, U-Boot uses this node to inject the
> U-Boot bootargs environment variable content, which results in U-Boot
> silently overriding all data in the 'chosen/bootargs' node. While we do
> have the board_fdt_chosen_bootargs() board hook to address such issues,
> this function lacks any FDT context, such as the original value of the
> 'chosen/bootargs' node.
>
> This patch introduces a read-only (RO) fdt_property argument to
> board_fdt_chosen_bootargs() to share the original 'chosen/bootargs' data
> with the board code. Consequently, the board developer can decide how to
> handle this information for their board setup: whether to drop it or
> merge it with the bootargs environment.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/fdt_support.c    | 5 +++--
>  include/fdt_support.h | 4 +++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>

You could look at 'bootflow cmdline' which allows changing individual
parts of the bootargs. It uses library functions which can do
insertion and deletion, etc.

Another longer-term point to make is that there is the concept of 'OS
requests' in VBE. So long as the kernel is packaged in a FIT we could
have an OS-Request property indicating the serial port that it needs.

Anyway, my comments are just some thoughts on how to solve this more generally.

Regards,
Simon
