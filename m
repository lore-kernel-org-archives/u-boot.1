Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A28BD16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DAB84315;
	Fri,  9 Jan 2026 12:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cEaPuF/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C193384326; Fri,  9 Jan 2026 12:33:37 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B898430A
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so44113165ad.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958414; x=1768563214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t3jKiohebtbOfO/mHZMOmmhYZUKVJ5twUs7KQUSse8c=;
 b=cEaPuF/zF/pwh6ft/839BR/J2TMCByYMVyw5A1F9Hfm8SWNmClkbQpjQ5S93YBH9O/
 AigTcdZNu10HuHn+5ndBay/Co7kNRRtZ7tTF9nveDd/KII9r8Pj0Ntq0TtDSNgGbR2vJ
 FaZFT7PrHSL1EYgKrQq2VK2Bwcwyt2ZrvoAxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958414; x=1768563214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3jKiohebtbOfO/mHZMOmmhYZUKVJ5twUs7KQUSse8c=;
 b=Ckcmclg3YB0Ux+7SZlPYCX/WbdkaQkFQm0rTDmxhBM47Wb4Ke0rNjSMqPb3xCOB6WH
 U3/OQql7m2RR9+zcsRHoGF38K7/FJigK1N7H05XHtxbYSs4QbUlE0JxBNkcHhrpCYoNY
 nbV33+epqntf51ETjcILBlE7tPHuqImZjBdYUAy+C8r8ymCAr5YcNglI/r3DQ5EEBHxm
 rGvOK19NbnxrSWwrvXXcID2t9md5ktlTjI5G2KOs9HaE0n+8iReTRngX8ObaqkZt7XYb
 yJAWelYI5Lm9+4k6U67vd6c8cUqGHkXsbuH63EYJy28zncCPKnNBUyCvRTeq1+nW5+j/
 fFmw==
X-Gm-Message-State: AOJu0Ywn0mDdttztDJVcsm6o8PRH1dAJotRnuIFkXaNxx6Wd7TWzVyjT
 htxXbvXfCNw8HAymDJT1MTDX4Pi+RMTJJqYAjNqW3whyqE/K1jMraAvLv7NWKr8/vAVHP0VW6n6
 uRe0g3TQx3exbLvYlQf2MV18zpw+VYmSITfqjpl6eAqF0gIbgvYM=
X-Gm-Gg: AY/fxX4iHI222MtocYg3oHZ5BwDTLiJT0u3ASvmKBXfGb5ChFNnlE3lrAuN+vBQYvai
 eHZpMUaVIvXW4Lh7KrUJAIpt9a8MFwS7W5Mf0eKdMfsiq73I8wNbxPyP/n3BODZdoqDEKdN8mu3
 /ImIqASxpnHYRPvQCjeaLpmNs5a85NfcJ9h3r2ZWj7BdA1spM+t6nOwnzKBsrVYSV3rc/5C3xfi
 wxTLI2cd5yIacAca+We/+p+ZdPqAXf2Q9zaxhCEriE2ie4YypQLB+LFuvnOYdUkr772USXaVH5l
 hCFq
X-Google-Smtp-Source: AGHT+IGkZqWBDM9jc2n6jJ7wELTgb/pRKd0jxSqnV2ginulhbiueWfJmkVDeH38zYTVIxvBe09drVE+qiz2z9L23XDk=
X-Received: by 2002:a17:902:cec4:b0:2a1:deb:c46c with SMTP id
 d9443c01a7336-2a3ee49a5fcmr92841235ad.44.1767958413775; Fri, 09 Jan 2026
 03:33:33 -0800 (PST)
MIME-Version: 1.0
References: <CAJs94EbyBnv=q6Gxp0WAhTRakxKm9xXgnriCVXQiycSem5qpCQ@mail.gmail.com>
In-Reply-To: <CAJs94EbyBnv=q6Gxp0WAhTRakxKm9xXgnriCVXQiycSem5qpCQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:32:00 -0700
X-Gm-Features: AQt7F2ppuKp0cFalh4Qz1pp-Xkc5Uc6N55C9wTrUwqlfsFHl1anXlEOFokNysbk
Message-ID: <CAFLszTgEMx7NZpTO0tTx72AMjZr_w=A787hhLT_YzHVTt=h7oA@mail.gmail.com>
Subject: Re: FDT overlay: lost in the documentation
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
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

Hi Matwey,

On Wed, 7 Jan 2026 at 06:00, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
> Hello
>
> I have a board with SPI where U-Boot image is located along with
> environment settings. The image is supplied with correct FDT, so no
> additional dtb files are required to boot Linux from MMC. I.e. fdtcontrol
> variable is set up by U-Boot. Then EFI is used to execute Grub2 which
> handles the rest.
>
> I've read
> https://docs.u-boot.org/en/latest/usage/fdt_overlays.html#manually-loading-and-applying-overlays
> but it describes mostly how to do the overlay loading manually. What I want
> to achieve is to automatically apply FDT overlay from a specific dtbo file
> located on MMC at each boot. What is the recommended way to do that? Will
> rewriting the bootcmd env with pretended commands work for me?

We should really be using FIT for this. It is designed for this
purpose and is a better solution than individual files.

Regards,
Simon
