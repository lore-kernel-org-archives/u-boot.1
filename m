Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0460EC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 06:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BCC8850B;
	Thu, 23 May 2024 08:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="287ItTW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3611F8850B; Thu, 23 May 2024 08:41:38 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A580788522
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-420180b5897so15821845e9.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716446495; x=1717051295;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VE20XFEEQCMNLXoFwb/LM5ZlMbQ7QhtxzhPhu4CFzGs=;
 b=287ItTW8W71rNPBEaHVTIuJ5MP5zFkLv3zNr8fgaQt/r+I5mV5awLRDraQl80UksC7
 SHwp//k/G4a3ngtSQhSs/lk1MX48KDj90nKZ76oq5dyC24I/mx/pwYTVWjrdg9eoWK+3
 JgsIUIxfOQ+/PjAlAYyAYz/ukIZmCoyCDYb+hShTACZcW3A+Ip+syJfRekQOYHZfQ/q3
 XcAfY4jxZLcZWpQ8fwZ2iGr2G/kd1Kasplbp3yT+hPhHgI3KChYdVr2B6nxPpK0zQsgZ
 ifY3kSySDyEBsulukAhMKyqqz/LKf7d9kVY+zDvPlFEMuZwucrl6ih3JMlGBIkPzwDLx
 jJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716446495; x=1717051295;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VE20XFEEQCMNLXoFwb/LM5ZlMbQ7QhtxzhPhu4CFzGs=;
 b=UI1UXl9FpeLJOddc8s/MpT64VTgqE5x48T9ZQ52X7gQuRpeCaTteqj+PM1jLDXyGK7
 sTs3Nd/cZqHH06vGUChah5oLsSJFbrClZy1RRrYRcT2YRQ9HIT38YhOE2pjsc8y80028
 e5OhjHnhjTokc9KyVN/32Tr3dSbaJlEZFy0WyMgVbpJ+N9hSsW7o3sW53ZVSZrei7YHG
 FCPSgOT3kTWbKgngRUqLocZlZpFuteFyX+a3/WIWK0hWlqFpm5Da0Py8PcvrRdjhK0SL
 czvYpIyqbSdsh9WNsItGkHMbFjbAbzWBE0JDN87w3iEGP1MAT2J4Q4dUoLX31Tlm3krR
 EUHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiZ7IFQYeDoQLxmj2Xd+0h81fBeXOZleYlUTuc1wMNCePdFWTAOXpLElq5AWMGE7rvxTz2U3rFPjXHhtZchjXYUmUexw==
X-Gm-Message-State: AOJu0Yx2PuHlB8YGRslzVFU8hU6r12aY8pdaTtNN2RszIQRV8DBoYooi
 d8nDYHOcujGqglMS6Srro38OXjMg+ivMc9hdf5hsNd5IdU+bXrUaGchKCaOXUWY=
X-Google-Smtp-Source: AGHT+IEw1zi/xdjatXHBxkrlfWYoTUu/pkezsQeOw9XSKkzxThu3EV0Q9iCas3Ak9z3JgDfodQH0eg==
X-Received: by 2002:a05:600c:570d:b0:41c:5eb:4f8f with SMTP id
 5b1f17b1804b1-420fd2ffc8amr30017645e9.15.1716446494793; 
 Wed, 22 May 2024 23:41:34 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fadfbbsm15576395e9.40.2024.05.22.23.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 23:41:34 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, sjg@chromium.org,
 marek.vasut+renesas@mailbox.org, r.stratiienko@gmail.com,
 laurent.pinchart@ideasonboard.com, eajames@linux.ibm.com,
 paulerwan.rio@gmail.com, xypron.glpk@gmx.de, u-boot@lists.denx.de,
 igor.opaniuk@gmail.com
Subject: Re: [PATCH v2] abootimg: Add init_boot image support
In-Reply-To: <20240522212645.87250-1-r.stratiienko@gmail.com>
References: <20240522212645.87250-1-r.stratiienko@gmail.com>
Date: Thu, 23 May 2024 08:41:31 +0200
Message-ID: <87y181xc6c.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Roman,

Thank you for the patch.

On mer., mai 22, 2024 at 21:26, Roman Stratiienko <r.stratiienko@gmail.com> wrote:

> Quote from [1]:
>
> "For devices launching with Android 13, the generic ramdisk is removed
> from the boot image and placed in a separate init_boot image.
> This change leaves the boot image with only the GKI kernel."
>
> While at it, update wrong error handling message when vendor_boot
> cannot be loaded.
>
> [1]: https://source.android.com/docs/core/architecture/partitions/generic-boot
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Note: this patch still does not apply on master nor next:

$ ~/work/upstream/u-boot/ git show --pretty='%h ("%s")' HEAD --no-patch
a7f0154c4128 ("Prepare v2024.07-rc3")

$ ~/work/upstream/u-boot/ b4 shazam -s -l 20240522212645.87250-1-r.stratiienko@gmail.com

[...]

Total patches: 1
---
Applying: abootimg: Add init_boot image support
Patch failed at 0001 abootimg: Add init_boot image support
error: sha1 information is lacking or useless (cmd/abootimg.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"

- master: a7f0154c4128 ("Prepare v2024.07-rc3")
- next: 377e91c162ab ("Merge patch series "Clean-up patch set for MbedTLS integration"")

Looking further down below, we can see that this patch has the "abootimg
load" command, which is introduced in these series:
https://lore.kernel.org/r/20240519191856.2582174-1-r.stratiienko@gmail.com

Please consider rebasing on either master or next before sending.


> ---
>  boot/image-board.c | 13 ++++++++++---
>  cmd/abootimg.c     | 26 +++++++++++++++++++++-----
>  include/image.h    |  7 +++++++
>  3 files changed, 38 insertions(+), 8 deletions(-)

[...]

>
>  
>  static struct cmd_tbl cmd_abootimg_sub[] = {
> -	U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
> +	U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
>  	U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
>  	U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
>  	U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
> @@ -376,7 +392,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int flag, int argc,
>  U_BOOT_CMD(
>  	abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
>  	"manipulate Android Boot Image",
> -	"addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
> +	"addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_addr>]]\n"
>  	"    - set the address in RAM where boot image is located\n"
>  	"      ($loadaddr is used by default)\n"
>  	"abootimg dump dtb\n"

[...]
