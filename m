Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5DDC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 11:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBBA82BDA;
	Sun, 25 May 2025 13:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CZkUhHhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A75082C75; Sun, 25 May 2025 13:31:13 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF5882B5B
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 13:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso2642079a12.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748172670; x=1748777470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9UW7hoBNVOcjmVLUT3EJGeSHvZ1Pa07wkyAW23sQrU=;
 b=CZkUhHhdt+j435rcq07LaID77ZNxSvTnQCIBuVg2bYYbXCTYvrkOcGnYZNSS1cFbSz
 Umu+OkNSxg5UkI+bknL4Zm7jM21qn6MyFeSBpn8jiq2jp85RUkEFDaI8FL3FyNlaffBd
 Sc87ulsWJsUMjsFxJNIPwCK+96cMXihuNZjIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748172670; x=1748777470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q9UW7hoBNVOcjmVLUT3EJGeSHvZ1Pa07wkyAW23sQrU=;
 b=RGsNmxgYJX+Ov3C+5tvUNcXW+isRDGqr3sT392uYqoGNehBxXxY6E9p6zo5++QH2FC
 Lk6bA+Mi0CoAmJ1dxayqFZ+vlK2R9UGC6/A5UxWiaxkQymO6w4PAGAfH0w+fcbW7B/oV
 af7kY6URswlvolbCR9fRivzaXWMHPyEYEJ0ZfU269sbfVAO9ZLfXK3DQB/j3M2WaFEio
 b9AjlE0XfJhdP/MZMc+0tQBujP+8e6ME5BCKCFN5ljw8kFHe5n2eYd3gJeOJ3gdLDNZe
 E7wPe9eSmRtlApyv0iGT9t/+2MKExg7SgDRg62kaMjRAviyw9B8TmW+T4Dz0lmTzU0Cf
 Ts0g==
X-Gm-Message-State: AOJu0YyNax1oZCLk6QYY2SFQjW9IIAX99rGNJsQD7gvrqbc+nBrJY0Y0
 rfG996f+JnfNW/qu08EpcT3L3SJIHmDL5ztIJwsDrgNHRqRQkl3VTjFcVItBzBhuV7K29vSlm5C
 T2LkmKeswfq0NqVi+aBOzHMHrGxsA+WLsDL0lSqG55bRgLPdLMmgXwbiEpx0=
X-Gm-Gg: ASbGncu+elodtaefcBn2b3XboY8M3IT4342FvqdmA0xrx2AWTSW8r2P+3XrCM/75QeA
 /jgOoJd9CTxsDVeVNvKQexaDno8PMKkF8n1csHKlwTXD4DS2NcNwOPkOB4CwTZXsncsALdFS/is
 W3X2J5+HeIY43CWp7VJhRDGUuDA8Bcfbs=
X-Google-Smtp-Source: AGHT+IGyJJer0FEjhnjdDcmcrPjnNs67rnMAkkNKAMOL6aVeHGdQj95u60oxNrUR7PQNWx6PBxCqNx4mUkaRR4BBgDo=
X-Received: by 2002:a05:6402:2346:b0:5fb:1fba:cd93 with SMTP id
 4fb4d7f45d1cf-602d8f5d702mr4306010a12.5.1748172670649; Sun, 25 May 2025
 04:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <618b6efd-71a7-4cdb-b7d9-05a1c2012744@gmx.de>
In-Reply-To: <618b6efd-71a7-4cdb-b7d9-05a1c2012744@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 12:30:59 +0100
X-Gm-Features: AX0GCFvw9TzLEJmCN7jVNZ1Ii_AXp_mGWIeYZMubv2iC-A10a5PLFAVvGPIR8tw
Message-ID: <CAFLszTivn_V1v9XidE1UHLiKQ36DuymOo2Kbj1=zaxixJfF+wg@mail.gmail.com>
Subject: Re: [BUG] buildman fails to build with --in-tree
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Sun, 25 May 2025 at 11:51, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Hello Simon,
>
> buildman has parameter -i, --in-tree. But building with it fails:
>
> $ tools/buildman/buildman -i -k qemu-riscv32_spl
> Building current source for 1 boards (1 thread, 8 jobs per thread)
>     riscv32:  +   qemu-riscv32_spl
> +make: *** No rule to make target 'qemu-riscv32_spl_defconfig'.  Stop.
>      0    0    1 /1              qemu-riscv32_spl
> Completed: 1 total built, 1 newly)

Yes, I can repeat this.

https://sjg.u-boot.org/u-boot/u-boot/-/issues/3

Regards,
Simon
