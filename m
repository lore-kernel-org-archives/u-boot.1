Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AC6CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 22:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1342D84932;
	Sat,  6 Jun 2026 00:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MIdGlDEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF4A84944; Sat,  6 Jun 2026 00:07:20 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2882A848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c1653ea0cso3373334a12.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697237; cv=none;
 d=google.com; s=arc-20240605;
 b=Wgctl6ygLxVBKdhctGgWAwSmcaGgl1vl2MAVYHXKDe+AlQje5UoBrCYlUOdsEOzBJ6
 n/5LmJhcV0Fze2VYkNQCYSS0db0PaK5S0ns4LI7KySeHwd5iqJVzEDe+bDrhjrPxoOf4
 1+jRP/rb+EMgG+M0pD6kS+8qBdiVVwXUAOk2xiMWex0s57SUQxHo9AfuxUSXe4wQu51H
 8RMQTfr6SV1O1ezrFd7frClj/E33dsIFqLbUwM7t2uByXwz1ZmeCzCrW+UKrwpZTfNkM
 NOojsf/886DxtqAniFz7ZBX75cJ+Rd4wpar9D4jfCe6Adajc8e5PmF81SKRH0KBKag01
 lL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EeGxiHx7lKJfFZnn5siEZ74bVYfekTtfcH7HNVzi/uQ=;
 fh=0FOPMLHAzJg9G4W4+xF3vZMIljgl4S6tYZjcGVjwOAg=;
 b=I27t0WJ4Y+BdTG1AUVJzGmYAnWBVO8uyDJ8J5O/fqL8ovtPFrXHKVBdOljUqpZ9djw
 LIzJpDXhZoMS7Nq6mLi4tJq405Vqm4AHKgN/NkR16KFE1ZtFuhfxMYeH1FVos+1i4LBk
 fLIb7NHpmv/e9X5QxSflqHkF2jh2ey7AAWrtbsBC55qW3Gv2eHv1qRIWU7PZEJ4mamk7
 +6AhwbDOz7rc/bXK0CYcbzxeDbwpuKBBEn2cHw5x7vnRYWyf0W35DJzcZ1TDXQKNYFOw
 JT3D5PE8y4OpEG4yCoJP2b0OzGTYeN/2XhxFHdmnRtrvMMu/NATgx6W/csajQP4SK72t
 HFsQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697237; x=1781302037; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EeGxiHx7lKJfFZnn5siEZ74bVYfekTtfcH7HNVzi/uQ=;
 b=MIdGlDEc5Xwr6oSlANbVGsfJ0hd64PFSs82ysig7KhvxOLZD7so4Jyr5p9CklretoL
 8vGlfUxRwwbtXQ3X04Z65f6fOwR9xrzBOtNhN08xVku65alunp4EkJ0Gao1LKbvUCuMK
 lOMq4kjRV1WEfaPSC7TIgN0T6Pby+N534WiIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697237; x=1781302037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeGxiHx7lKJfFZnn5siEZ74bVYfekTtfcH7HNVzi/uQ=;
 b=RyezlGloA12P8p5cNVDpNcRoD/7pQP9Ka51O+yIo0xrGE/RPDieU7vgbbNftqvQLPW
 lEzbfMRxG6zBxL2oidjuvqkdVxBj6g06ljYAVMi7kglo0J4l/uC1tMxgYQ7a50N+HucO
 87fgFAytijgdLzgOlKox+d//mP+1ttzgXkSVywD48O5SQn3UJ7l55+bYH+Kc5uTT727J
 0DIVt9aHTxCytw5+XI5oQ4nRLlIUQbRAvPeKgNA4gMfVj4NI13slcQHvPxbyFRh6mx4a
 p229VrEJblNQcKm4qc6StYfYH+aWIzw3JThcWbnWOeuySvZUVnEC3n6mPVvLBYRi9uHl
 pm5w==
X-Gm-Message-State: AOJu0YwMQzSbLbyfGUaguJ918QEKD8QCSGfvc1M80knE4txhEwxuyIFc
 WVtFPnvJHnTlyLnOdeqXuga3X7j5Wb7Zv3ypoS9xxJPCRHyy0dnsXih3fUOlItcLZYfAkTMzqXr
 ObyRoHm62OcHxo2pIRvn8p4oObDf0lNJ5OUSpjAP3
X-Gm-Gg: Acq92OExoOAgIob90dCKUI3eAcXnY9edvYcJMhlO1s7AMTah9+cxuCCK4RnBoBh9zxd
 AETTqBlER2J4+HNqIQqpc0h/E91yublhV1u4p8/t8IcXIFDIYmHs5nSZXIe9cjhcBBf+nsFzK1H
 dlxAqsRJBC9SSZj/MEBHyrLbuKs3hwUjDJC8MzKdEP0+p1ikq/fFf99H2LvoAMDAfLuryPaLLdf
 0D7ri0C+hrBEoQYNxGOkB8ro0UtfD32UCjyxsM5eip57tKnkL+gsZEF7tyL8e21JT0x67F6nfqG
 mfbnZim+KicNcS6J3Xal38hNxHg=
X-Received: by 2002:a05:6402:4014:b0:689:c099:ef99 with SMTP id
 4fb4d7f45d1cf-68fa51526fcmr2702074a12.22.1780697237605; Fri, 05 Jun 2026
 15:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
 <20260602-devfdt-usb-v2-2-a587ab36b906@nxp.com>
In-Reply-To: <20260602-devfdt-usb-v2-2-a587ab36b906@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:07:04 -0600
X-Gm-Features: AVVi8CdsLvxzEa7paJob4ShRoEfkbz7B0H8dXWU9cCRvbIiWggMGpzgwXC54_ko
Message-ID: <CAFLszTiLgk8fei4OiZ-X8C3Qh7CcP3bST-5Nq-jbQVhM5RZxjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] usb: musb-new: Use ofnode and dev APIs
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
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

On 2026-06-02T11:21:39, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> usb: musb-new: Use ofnode and dev APIs
>
> Convert the TI MUSB driver from legacy FDT interfaces to ofnode and dev
> APIs to support both live device tree and flat DT backends.
>
> In ti_musb_get_usb_index(), replace fdt_get_path()/fdt_get_alias()
> based string comparison with ofnode_get_aliases_node()/ofnode_equal()
> to match USB alias by ofnode identity rather than path strings.
>
> In ti_musb_of_to_plat(), replace devfdt_get_addr_index_ptr() with
> dev_read_addr_index_ptr() and add a NULL check on the result. Convert
> four fdtdec_get_int() calls reading 'mentor,multipoint', 'mentor,num-eps',
> 'mentor,ram-bits', and 'mentor,power' properties to dev_read_s32_default().
>
> Remove DECLARE_GLOBAL_DATA_PTR and the asm/global_data.h include as
> gd->fdt_blob is no longer referenced.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/usb/musb-new/ti-musb.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> @@ -51,29 +48,25 @@ static void ti_musb_set_phy_power(struct udevice *dev, u8 on)
>               i++;
> -     } while (alias_path);
> +     } while (1);
>
>       return -ENOENT;
>  }

The trailing return -ENOENT is now unreachable. Please drop it, or
restructure as for (i = 0; ; i++) so the intent is clearer. Some
toolchains warn on unreachable code.

Regards,
Simon
