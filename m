Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE31FC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 18:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F9180EC0;
	Fri, 21 Feb 2025 19:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="faIxP5Fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF7C080F5C; Fri, 21 Feb 2025 19:55:42 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6408E807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 19:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so2166281276.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740164139; x=1740768939; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8hk3OP9Yn+hGYKjhrhamZrrmL7qmNQ0rF0qdym6t1cU=;
 b=faIxP5Fa9Z4FaNkFGJLjfx3eQz2Ns+83jDKYuEPNjjD7G63b/vH33An3IChbMpG0DB
 hj1obRA5gOp2XCZmikuWKFL5kTny6ZEnfrtMaWS79+cRg6WJAlLke6PgIN3Jp23e6aD6
 V949Sna0XOJ9tcR3ZHc3urWpXNXK2Ez9bI0e1Cph1NKBH2BMvGfGdA3KeU8mqQtvj1KH
 zw+G6B0cTzeVa+gCyPi8V2MioFicJ1rIwiEYD7n63gzSJk/lhKOxdjE6Jyz6+l077CR3
 6IgMjNkGKeV8OmhUwLe/RLrUHbmTXDw2qe3+CFSH+0NzDct9cqXiWWYcL5ygLOBk3weh
 hj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740164139; x=1740768939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8hk3OP9Yn+hGYKjhrhamZrrmL7qmNQ0rF0qdym6t1cU=;
 b=WSpWXsYIPkGYGmQRgsp03Sm/Am2088BbPKBd46RYVPK/j0mmjUAuCBI+7YpZNT9foO
 in5TSIXUxEhpulVdtuOIliEd1sWiKrhsvOzeuOLGlQJU6tceARtQRU54RRiTfPfXiJGU
 CJZ7KaDvNBawj0MH9XvL+TR3Alu1ZVNzTJtgLiiGi37pAoXkQSHBqHmp/NbYU1du4QDi
 hEvtrex4faHe27u8qbGYxHZyIAuTqYXP0OA+Dvr9iyU/8e6yXD9rpGOhu4rcSEVhBKuM
 bqiAM04Bzc+gGiXIrUV6tM7m3TaBlmOhVzvniZe3ZrFtz9vacwtPciF1RvvSQ49dICwP
 WHBw==
X-Gm-Message-State: AOJu0YzAxNXpX1qtQRPtjQr1drH56tjx0FLGt76KXUqPFnzpqTCw03h8
 WmZ40PvC/ZyedNVUUBjXnuU3XftxTmWHc7AT6aV3rb50JerlP83scCfFJsh9OwM47rGCR+Er1Y8
 nbVo64uPoeA1G7RoXfK0TkdTwZMSW5zbcd4nXdA==
X-Gm-Gg: ASbGncstNe53cuCwp4FLTqZuwBvsOW6gh9jpauQUpoDmhcp/f4uvvxwn026bUhe56TU
 DnxU4BLXrnY4DNJYeonDKgx7HAZTuthwmnOKvWjIv8rTUAxDQjyehSx2HAvumgxBgh5ZSDa4X9/
 HtWn2yvLSI
X-Google-Smtp-Source: AGHT+IF6E/ASIjo4qlUyNU6fH0OHeSPiNfswP6VJFzAHR5DQV4LSs2K8BhZYw1nCmiyUrWzfpA8wEnXbJroK4oDr7cY=
X-Received: by 2002:a05:6902:1543:b0:e5d:e04f:f299 with SMTP id
 3f1490d57ef6-e5e246a15dcmr3732548276.48.1740164139236; Fri, 21 Feb 2025
 10:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
 <20250203105912.196654-6-sughosh.ganu@linaro.org>
In-Reply-To: <20250203105912.196654-6-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Feb 2025 20:55:03 +0200
X-Gm-Features: AWEUYZlXrsh9aKlABY1EsdCksb_mPJKjaF6HYv9hbX0oXoijDpbkY4w1wAUnnMc
Message-ID: <CAC_iWj+a-hcvS=u_Gtk39UyjSPuMgWoao982TzN+wb5uKnS=hg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] blkmap: add pmem nodes for blkmap memory mapped
 slices
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

Hi Sughosh

This generally looks ok, but I don't love the idea of unconditionally
preserving all slices regardless of their usage.
Basically, if a user doesn't unmap that slice it will end in kernel
memory. My fear is that someone will forget device sensitive data in a
blkmap....

On Mon, 3 Feb 2025 at 12:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI HTTP boot puts the ISO installer image at some location in
> memory which needs to be added to the devicetree as persistent
> memory (pmem) node. The OS installer then gets information about the
> presence of this ISO image through the pmem node and proceeds with the
> installation.
>
> In U-Boot, this ISO image gets mounted as a blkmap device, with a
> memory mapped slice. Add a helper function which iterates through all
> such memory mapped blkmap slices, and calls the FDT fixup function to
> add the pmem node. Invoke this helper function as part of the DT fixup
> which happens before booting the OS.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V3:
> * Move the definition of the helper function to the efi_helper.c
> * Remove the region of the blkmap mem map device from the EFI memory
>   map along with adding the pmem node
>

[...]

> @@ -680,3 +683,52 @@ out:
>
>         return ret;
>  }
> +
> +static int add_blkmap_pmem_nodes(void *fdt, struct blkmap *bm)
> +{
> +       int ret;
> +       u32 size;
> +       ulong addr;
> +       efi_status_t status;
> +       struct blkmap_mem *bmm;
> +       struct blkmap_slice *bms;
> +       struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
> +
> +       list_for_each_entry(bms, &bm->slices, node) {
> +               if (bms->type != BLKMAP_SLICE_MEM)
> +                       continue;

Can we convert the 'type' to 'preserve' and teach
blkmap_create_ramdisk() to pass that flag?
This way we can unconditionally pass it from EFI HTTP installers, and
let the command line users decide if they want to preserve it.


> +
> +               bmm = container_of(bms, struct blkmap_mem, slice);
> +
> +               addr = (ulong)(uintptr_t)bmm->addr;
> +               size = (u32)bms->blkcnt << bd->log2blksz;
> +
> +               ret = fdt_fixup_pmem_region(fdt, addr, size);
> +               if (ret)
> +                       return ret;
> +
> +               status = efi_remove_memory_map(addr, size,
> +                                              EFI_CONVENTIONAL_MEMORY);
> +               if (status != EFI_SUCCESS)
> +                       return -1;
> +       }
> +
> +       return 0;
> +}
> +


Thanks
/Ilias
