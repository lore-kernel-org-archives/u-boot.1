Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43681C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36734884AC;
	Fri, 21 Jun 2024 01:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7BtHAsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A3E87DB0; Fri, 21 Jun 2024 01:05:42 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871528846D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70024655285so794599a34.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924738; x=1719529538; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PbAlsDSrY8hiSI1smPdeuSzgzmitAAeOc+HAMb/zU9Q=;
 b=h7BtHAsg8avK+jIJ0iwChX7kyVfSudtPlaxs5ybiy19ZMhc5lulN/LH+PKlytkn/FW
 vFxYYO5ASlFALu7Jn2RcVQaXArSduYQd6x5VOqVmWkuJ+SGdOrQ7g+5SFz96qF9WCv4C
 njX6XRjTdp79e8cenUI67R7/qIlXyASebIUi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924738; x=1719529538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PbAlsDSrY8hiSI1smPdeuSzgzmitAAeOc+HAMb/zU9Q=;
 b=GWEviZb/7lT5zHBSmH3HvEVbvKKy3ydS/IdtT4OlrzVui1stLAXwO2MHl73V33R7iM
 TjAIntiHTBBaABvhzFBGGmpzOonMMN3i8tmWkKssmAyacF0RpxeQnh3qPn3K4GSIvwQh
 XQByMKrDn/G3a94QqMolyEZvC6DqXUhs9+jtd7i11I7Y9lAQIJeGebTHuyAGdst9t++p
 ro7NQ262MyLaz9ef02wTWDSMGf0Q5MTHnUvSmFdz3pMNkIotWD3OvXlNO3TdRqRkrron
 KrsrMcPBRgMaYXbP3seiWvJcIN6dRsM0nqRCYA9/wmfaTcM1sCrStg3bIeCrwrfPuram
 veOA==
X-Gm-Message-State: AOJu0Yy71nhKWITxp5+JeBFHEpW9XJu9ltzTma3aMjY3BxUMsHoyOUYM
 CzhNXnUT8//P5QbocZebDCVUNHP5aE1dQsDVQpHeun18H6gkC/QI9NzODnPaJbmyfS1a2kj8Wa1
 cEqTQKYru3EykDqV3XFgI/BPxI5vm177RUOwv
X-Google-Smtp-Source: AGHT+IEIUT+bYNrRfmrPXuFf1IAd+qxX918CpxaX0SlCADTv+w9Rm47paLaAIVvd3uet7LCCgz5dKDTUByFEC7JmYQY=
X-Received: by 2002:a9d:67d1:0:b0:6fb:fb0e:5160 with SMTP id
 46e09a7af769-70073564984mr7332305a34.7.1718924738227; Thu, 20 Jun 2024
 16:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFOYHZAzfyGHp3FEFLEiuGFS-XMrprEqANLSBqRkv2B_RHMpUA@mail.gmail.com>
In-Reply-To: <CAFOYHZAzfyGHp3FEFLEiuGFS-XMrprEqANLSBqRkv2B_RHMpUA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Jun 2024 17:05:27 -0600
Message-ID: <CAFLszTgvGWSjc+mDDXc-n37P8F8VPfVm66SrvMz04MY6VXwZSQ@mail.gmail.com>
Subject: Re: mkimage alignment of initrd with -T multi
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>
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

Hi Chris,

On Wed, 19 Jun 2024 at 23:16, Chris Packham <judge.packham@gmail.com> wrote:
>
> Hi U-Boot,
>
> I've been given a MIPS reference board with a fairly old vendor U-Boot
> on it. It does seem to support the  Mutli-File Image format but I'm
> running into an issue where the kernel expects the initrd on a page
> boundary.
>
> I'm using a command like the following to produce and image
>   cat board.dtb >> vmlinux.bin
>   gzip vmlinux.bin >vmlinux.gz
>   mkimage -C gzip -A mips -O linux -T multi -a 0x80100000 -e
> 0x80100000 -d vmlinux.gz:initrd.sqsh myboard.img
>
> I can mess about with padding vmlinux.gz after the gzip step but the
> process is a bit fragile and involves me guessing at some magic
> numbers that I think might be sizes of certain headers.
>
> Is there any way to convince mkimage to make sure the initrd is on an
> appropriately aligned boundary so I don't have to guess.

There is a -B flag which might help, if you can convert it to use FIT.
I am sure that it does, though.

Regards,
Simon
