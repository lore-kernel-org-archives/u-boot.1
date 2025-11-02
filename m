Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB73CCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D3483956;
	Sun,  2 Nov 2025 20:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O1o0jBgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D368394A; Sun,  2 Nov 2025 20:54:46 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3519C838AE
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-634cef434beso8983659a12.1
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113284; x=1762718084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iw2ZRcZrPAGfdkV5oIuqaAQpJ2IbDVxNb6m911peGIk=;
 b=O1o0jBgCFTVMS3o2B0lk3ZDj7B5nzLXCOrUE+vyCoVZLrPYI1xdm3tHp68IHCaiQoo
 aPkaBOVMKefASmr+wC0ZKGFpPt/tQxGVDgKTlZppGlWhaQAguyHTKDG1JUbtO8H0I0TO
 FKVNxyYxEsnDwLrHA4JDnRG+FBHZ0f/iaxo+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113284; x=1762718084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iw2ZRcZrPAGfdkV5oIuqaAQpJ2IbDVxNb6m911peGIk=;
 b=UBba4SiLfMWbtHoiwv/GTP5mYfGo5koDyDDUXPQP4vlz/tc8nzRDOtwy+yIcKMn8zV
 MCQlRdwucAG2HUXUuRSSDh8At631KFe9iUiHV6+CUCoGgGdmojIwesMM87g4MhDulHv6
 lzswrVb0vcsPvWHvqkVZZNZu2NaoDY87/mdOgXyrWdtB9NawXmFDKnwpAJqz/bHuHkmy
 HZA2SHD7QZF/eTgelxKypPzZDk1bPN+HH3DrCSzesnHgAkiGOvTY7ILmoLZGElm7DLuL
 QauVFTFjnPy8BoCeHWIvdZXI6ZpURfDQHu9tNHUWHJ/wwr18901UltgrN9i9+Gt9tawO
 z4ow==
X-Gm-Message-State: AOJu0Yy//nIWgH/6RVGN8H/ZAKvT2XFLY04FtGyeXjlX32KNG10iZ3iz
 yZW7rL6aT4GKjwaUagO9VfaSR/uFI0z7Xe1zpdsKQdGbkYdBi0jrKhwjtOkWjqM92HL7J3tBKT5
 rmpVKWdrEEfIrRb0FdL+uWO4L8M0Nb3GgBEHyIO3g
X-Gm-Gg: ASbGncu5nIf87d/HS/EkpfJoQOvgp9PBfw3dmhoth60WS1X/ibJTT5OPLQDwkiXYzXT
 vMbRoCO9W5ComHvMB4LquMZ9Z3XY42/cfNCRx88bZ7aR1iXw3vHVan1qfiydOV0TnG7z7bttJ2G
 GwujJX/56sapRMa5yfL/OuZdLgBlqjECHcsGVWwmzrQSZK5sxhP5vpLX9DabzWMzKL2C8MCN1ca
 qpUvZc+Y9K6APnDcnCgHKg7lkHWSJ+RIiHTp94gx51E6uhnlf9NmRyPMsLaIDrRWUrvyhyK
X-Google-Smtp-Source: AGHT+IGUoCkmRgUeLsZyX1HXeGLDW+fUVusjnjOQ1HZQLWEkvzMZj07hkZuX7mX5UgRIsnHWWCemYPHy0+4sfuzsAfQ=
X-Received: by 2002:a17:907:1b1b:b0:b4d:71e9:1662 with SMTP id
 a640c23a62f3a-b70521d47e7mr1478393066b.30.1762113283708; Sun, 02 Nov 2025
 11:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
In-Reply-To: <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:54:02 +0100
X-Gm-Features: AWmQ_bmDE7p64Au5vb578p5mZ8DndlXTbCq_aZ-Njfa1ykJlBxgRIORI6gCjnMA
Message-ID: <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "Bajjuri, Praneeth" <praneeth@ti.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Kory,

On Fri, 31 Oct 2025 at 17:36, Kory Maincent (TI.com) <
kory.maincent@bootlin.com> wrote:
>
> Commit d0ba0ca45a49 ("distro_bootcmd: Set distro_bootpart_uuid for block
> devices") added support for the distro_boot_part_uuid environment variable
> to allow using PARTUUID in the kernel command line.
>
> However, the way it was written only supports the case where the boot
files
> and the rootfs are located in the same partition. There are many cases
> where the boot partition and rootfs partition are separate.
>
> Add a customizable find_distro_rootpart command to allow each board to
> define its own logic for locating the rootfs partition. This provides
> flexibility for boards with custom partition layouts while maintaining
> backward compatibility for the default case where boot and rootfs share
> the same partition.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  doc/develop/distro.rst          | 11 +++++++++++
>  include/config_distro_bootcmd.h | 10 +++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
>

How about moving to standard boot and look at this there?

Regards,
Simon
