Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAAEC48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 08:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3CBA8803E;
	Thu, 22 Feb 2024 09:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIF6hjzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D2287E6F; Thu, 22 Feb 2024 09:06:13 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BC78805F
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 09:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blemouzy.ml@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d180d6bd32so87234851fa.1
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 00:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708589160; x=1709193960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PayTRtb8NIGUSdnIv7GWKasq4itRkqCoWUPu7GvUFlw=;
 b=PIF6hjzRrmKZxnMEbu1ETFDQ2RWl3Ldm1fnxyruAnQiOh7putNZzS/LDpi4H7RqfAx
 68YQiHTm6twoM8J9rZ6D5fN93+4OubIaQTIIf8umAxOKwzvE99bvIT17LGcU4As6eu42
 gAssd1mrVUm9HpZPbgDA22mrkMepqgNw7Ki50V3JrpYRhtmpMXmjPb97s/AXO6/t8Kma
 I+sxvHDGHPm6Uw5usnhu8j47GM6m1sgNeTOBUNeUpBUwPbZbtchCJiKxpU/hP/wqDwRZ
 78K4hNRx81euFfY8oMtFOYSdxvphcsPX1bzJRh9nle+NTp4ABCM4XJlgbzZgwRK4PQR5
 v+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708589160; x=1709193960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PayTRtb8NIGUSdnIv7GWKasq4itRkqCoWUPu7GvUFlw=;
 b=j75xBv/hNPVm8G9fhb2HpNYoABVrbWkbkvquhK0luagFGX1oJhJ8gjMjROyfiFuiFE
 /ikspNI/TWMxRIaCRSVhIS53UNwTTGEHvhLV/80ne4CTxcuUeuZzDZvKKxQgwdzoAhvT
 BvST5ZDVb3mz3Rnt1IeorFYP8BXvKZAxonQ2VXVCB/1M4LFv40bfR//GTTLGTizOSB8P
 7Fr6JRIHzj3uwQQgvGiI7XB6GXzZEKUystO8U/hsm+wQqcfnpRi2mBb1yKSqIxA47WLo
 8pzrzCHYy6A8nqLftWIz6d738TV8VHajB83m7Q0qk1g716HUBrk0VoyoBEiAC2Mvznqx
 YGCg==
X-Gm-Message-State: AOJu0Yze9iOwNlQxmiKa8ibyy7nLE8xE/YPdIl9c0BIPGjs5nirF+EBt
 EBplVntMc598W4ISW6Op9qSgRmZPsfUo2aBdm00e78v41Y5pQJpZ
X-Google-Smtp-Source: AGHT+IGtj5wMbuKNPeCzkmfW0x1DUgjauUHRN5JXWMB5tQdOjpfKlYrCjAFDa/UUCABzSmcn6g8OYg==
X-Received: by 2002:a05:651c:9:b0:2d2:555f:b4ae with SMTP id
 n9-20020a05651c000900b002d2555fb4aemr2447806lja.51.1708589159357; 
 Thu, 22 Feb 2024 00:05:59 -0800 (PST)
Received: from localhost (82-65-95-55.subs.proxad.net. [82.65.95.55])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a5d66c5000000b0033af3a43e91sm19326932wrw.46.2024.02.22.00.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 00:05:59 -0800 (PST)
Date: Thu, 22 Feb 2024 09:05:56 +0100
From: Benjamin Lemouzy <blemouzy.ml@gmail.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de
Subject: Re: HABv4 with SPL and u-boot-dtb.img on i.MX6
Message-ID: <20240222090556.00001ea3@gmail.com>
In-Reply-To: <92a814a0-aaa5-47db-ab8f-7e799ab3e82d@seco.com>
References: <20240220105049.00000d3c@gmail.com>
 <92a814a0-aaa5-47db-ab8f-7e799ab3e82d@seco.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 20 Feb 2024 11:29:53 -0500
Sean Anderson <sean.anderson@seco.com> wrote:

> On 2/20/24 04:50, Benjamin Lemouzy wrote:
> > Using fdtdump shows that crc32 is used as hash algorithm for FIT image which is a super weak one.
> > I tried to pass another algo (sha256) using mkimage -o option but that doesn't work.
> >
> >   ./tools/mkimage -f auto -A arm -T firmware -C none -O u-boot -a 0x17800000 -e 0x17800000 -p 0x0 -n "U-Boot 2024.04-rc2-00025-g9e00b6993f-dirty for mx6sabresd board" -E -b arch/arm/dts/imx6q-sabresd.dtb -b arch/arm/dts/imx6qp-sabresd.dtb -b arch/arm/dts/imx6dl-sabresd.dtb -d u-boot-nodtb.bin -o sha256 u-boot-dtb.img
> >
> > Is there any way to change U-Boot FIT image hash?  
> 
> I believe these options are only used for signed FIT images (e.g. for
> verified boot [1]). Since you are using an external signing process,
> they have no effect. I suggest creating your FIT manually (e.g. -f
> u-boot.its instead of -f auto). You should be able to specify the hashes
> manually that way.

Using "fdtdump -s u-boot-dtb.img" output as reference to create a u-boot.its file, I now have a u-boot.itb file with sha256 hashes.

> > I also try to use image format and force the HAB to verify the whole u-boot-dtb.img file by patching the FIT image size:
> >
> >     image_size=$(stat -tc %s u-boot-dtb.img)
> >     printf "00000004: %08x" "$image_size" | xxd -r - u-boot-dtb.img
> >
> > SPL starts, authentication looks fine but the boot fails.
> > Is there any chance to make it work or is it insane to try to use this format?  
> 
> I have always just used verified boot for U-Boot and the kernel, and
> only used vendor-specific stuff for SPL.

That indeed a good idea but CONFIG_SPL_FIT_SIGNATURE and CONFIG_SPL_DM (as dependency) take a lot of space and SPL overflows i.MX6 OCRAM.

I finally succeed to make U-Boot check with HAB work using the new u-boot.itb image with the following signature format:

            ------- +-----------------------------+ <-- *load_address
                ^   |                             |
                |   |                             |
                |   |          Image data         |
         Signed |   |                             |
          Data  |   |                             |
                |   +-----------------------------+
                |   |    Padding Next Boundary    |
                |   +-----------------------------+ <-- *ivt
                v   |     Image Vector Table      |
            ------- +-----------------------------+ <-- *csf
                    |                             |
                    | Command Sequence File (CSF) |
                    |                             |
                    +-----------------------------+
                    |     Padding (optional)      |
                    +-----------------------------+

I don't really understand what u-boot-dtb.img file is but it doesn't work with U-Boot CONFIG_IMX_HAB.

Thanks for help!

Benjamin
