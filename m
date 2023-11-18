Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7528C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B9086FED;
	Sat, 18 Nov 2023 18:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LDy5VafI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABA987239; Sat, 18 Nov 2023 18:11:53 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36E886DEE
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so2841060276.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=llRSWFbwiX6hurVQDEB44sahMZUgF5rVh+tZmSwV244=;
 b=LDy5VafIPDDkJ2CFZcO3GPoQS6NXPe01beAUlV9VOqIQbkGG38AC8qCTH6OPmH2UuU
 MjOLvxaFmzE4DqxeaAU+yLhpjKF/eZqL0GNDtaRezP1jfuhuQ7iXRnFpYGRgBkVJrLB9
 LFQl8rm0GfYF2XLv6HB2PHmmsOUw0tPHXFpTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llRSWFbwiX6hurVQDEB44sahMZUgF5rVh+tZmSwV244=;
 b=S5/e4CE9vljy0mQ5iLOEQ3T7Tq2wlWthjj80fGvFMshZn/H5hioCUMo6463P3XbF4F
 +KO1bzT78QMyEQGWg5rAlffcC7TN4/iDqsL1YjeDdmwJnPoLRw9BdpuchYqDtGrgKGrf
 KSADdm8UZ7tV1lEERfH9IIGDXPmSZOZD0SgaJ7oJXcZz8bPSTB9oUI2f6075wl7WR9x2
 1YQzBIUWfPe80r0pvtOklfcqcfbsA91SpBTNumloj87OL2lIozExJYvPsT9zw63bLUZU
 rssQav3eO7SxbBg+h40sPdRoJxg90lIGs/c54GNI8yWwD1UXuMclU7aU5BbDrJAa70ej
 znng==
X-Gm-Message-State: AOJu0Yx2hFvNBaE3vcYSot4WHnNzJL6YM9OZl9r3rIInvslfdk9PbFqQ
 oKd+VaZeUA449qEAySZj6ieTWg47E3qHCTFurr099/2dQWY5MS7PsqA=
X-Google-Smtp-Source: AGHT+IFUHCzKfDmf6ZIm2Ds095uDfRiosXBtt0WW2eV84+nw/Abe3cmYgRydrK2daonMi2E2aVoAAT6+AFMyAHsTPe0=
X-Received: by 2002:a25:fa09:0:b0:da0:54f7:11cf with SMTP id
 b9-20020a25fa09000000b00da054f711cfmr1921846ybe.49.1700327504821; Sat, 18 Nov
 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-5-trini@konsulko.com>
In-Reply-To: <20231117225313.2144665-5-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:09:59 -0700
Message-ID: <CAPnjgZ0rn3GZ7F+UBWQfzuc=3Ov02_YujJTyo+OngWm8JnbtXw@mail.gmail.com>
Subject: Re: [PATCH 5/5] global: Drop common.h inclusion
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, 17 Nov 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
>
> In order to make it easier to move on to dropping common.h from code
> directly, remove common.h inclusion from the rest of the header file
> which had been including it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  board/BuR/common/br_resetc.h                   | 1 -
>  board/CZ.NIC/turris_mox/mox_sp.h               | 2 --
>  board/freescale/common/vsc3316_3308.h          | 1 -
>  board/ti/ks2_evm/mux-k2g.h                     | 1 -
>  board/tq/tqma6/tqma6_bb.h                      | 2 --
>  board/xilinx/zynqmp/xil_io.h                   | 1 -
>  disk/part_amiga.h                              | 1 -
>  drivers/bios_emulator/include/x86emu.h         | 1 -
>  drivers/crypto/fsl/jobdesc.h                   | 1 -
>  drivers/crypto/fsl/rsa_caam.h                  | 2 --
>  drivers/ddr/altera/sdram_soc64.h               | 1 -
>  drivers/ddr/marvell/a38x/ddr_ml_wrapper.h      | 1 -
>  drivers/net/fm/fm.h                            | 1 -
>  drivers/net/fsl-mc/dpio/qbman_private.h        | 1 -
>  drivers/net/fsl-mc/dpio/qbman_sys.h            | 1 +
>  drivers/net/mscc_eswitch/mscc_mac_table.c      | 1 +
>  drivers/net/mscc_eswitch/mscc_mac_table.h      | 2 --
>  drivers/net/mscc_eswitch/mscc_xfer.c           | 1 +
>  drivers/net/mscc_eswitch/mscc_xfer.h           | 2 --
>  drivers/pci/pcie_layerscape_fixup_common.h     | 2 --
>  drivers/pci_endpoint/pcie-cadence.h            | 1 -
>  drivers/pinctrl/mtmips/pinctrl-mtmips-common.h | 2 --
>  drivers/usb/gadget/bcm_udc_otg.h               | 2 --
>  fs/btrfs/ctree.h                               | 1 -
>  fs/yaffs2/ydirectenv.h                         | 1 -
>  lib/libavb/avb_sysdeps.h                       | 4 +++-
>  lib/zlib/zlib.h                                | 1 -
>  net/arp.h                                      | 2 --
>  net/link_local.h                               | 5 +----
>  net/net_rand.h                                 | 1 -
>  net/ping.h                                     | 1 -
>  31 files changed, 7 insertions(+), 40 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
