Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231DFC25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 05:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE1587B65;
	Fri, 27 Oct 2023 07:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J3sA19gD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35099876A4; Fri, 27 Oct 2023 07:04:39 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A04F876AA
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 07:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so2552054a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698383077; x=1698987877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1AeMzUP3ziw5AUvBhqs4NasmSfE3HO5S6IG7gj0noA=;
 b=J3sA19gDMW2P6eCBgofEQy7sl8at8RUjemOmDUkWuYRd0o80QGE2A4p4mD0+E1INxZ
 p+vZvMZdFC5KT5fO0c/NJEfB8Htiyk7ZVSfDnBDOhFhMYrtFMzkN2o2b6e4nw5iVxPpi
 OVPTVmegw9n2Qt96ukyjJrMPa+pLtH9mR6a4mbt2niNjAiQkb8a96wV6Uz2Tgjl84M11
 8YvdXip7zvvlZuWQvd+DGsj/9FLq9J9/McWTuO+za31XhnBJ/4+tbxHRYzoYkx2xr2QC
 rRTe+LffobhBXDO08M3mgUDpOzR/9Ju9/6RFDNilWGSNwaezI/L/C2Mua+9B8LzFCmFQ
 2tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698383077; x=1698987877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1AeMzUP3ziw5AUvBhqs4NasmSfE3HO5S6IG7gj0noA=;
 b=QS3BBdZejbqebpqABmeUZ7se9b+U5ZoSCEZpaGYnbhEL52cVFKjD9qPLMSXmnW6jpK
 QEO82XPFwl+/u5VALDs4iZYLjiyFqnkw1kWEJMIGUkBtZzcWK9W55EyTIuU8SON6yzDS
 8jb4fvrF522mKZhv33Vqr3KPpt01ZYHr8uY5xBt43lpKwQSQahry5Qaq1U0q2wq9e4GQ
 BaZ11yZP7HkaFg0uJxfs7Yywpsfhhi8ZVyaDOfSw41Nv997UHIqiRiWpu++b4qkamdjJ
 Ub7bozxi7jm0EZYZLEiF3lg67aYKBNFATAbmofyOe3Xo/9fcrUzz/+2o+nYZaSPvSVMD
 eaUQ==
X-Gm-Message-State: AOJu0YzCjMalc4pyGBEcd5Pec5KCmXxCeMiTHEdNj447wF9+ogjd8ASR
 S77a5VN7LfG4V1+yKxjl1DkDwZFX7D4VV4xKM+4=
X-Google-Smtp-Source: AGHT+IGLVrtjgHqHQC+AHlsA0hj1yHjNKMm5qE3f010pK+0x37tCbNU087rLqDQELWh5ACsWKBEk9jEqTMDeaqV9BmU=
X-Received: by 2002:aa7:c982:0:b0:53d:a727:3846 with SMTP id
 c2-20020aa7c982000000b0053da7273846mr1380210edt.20.1698383076658; Thu, 26 Oct
 2023 22:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231027004430.442136-1-judge.packham@gmail.com>
 <20231027005422.GQ496310@bill-the-cat>
In-Reply-To: <20231027005422.GQ496310@bill-the-cat>
From: Chris Packham <judge.packham@gmail.com>
Date: Fri, 27 Oct 2023 18:04:25 +1300
Message-ID: <CAFOYHZC3Qz59H6DNr1nidf9zuc-7VdOJu4GySkUhDLaDqpLCVA@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: AC5: Use finer grained memory map
To: Tom Rini <trini@konsulko.com>
Cc: u-boot <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
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

Hi Tom,

On Fri, 27 Oct 2023, 1:54 pm Tom Rini, <trini@konsulko.com> wrote:

> On Fri, Oct 27, 2023 at 01:44:11PM +1300, Chris Packham wrote:
>
> > The ATF implementation for AC5/AC5X ends up with bl31 living in some
> > internal SRAM. This is in the middle of the large MMIO region that we
> > were using. Adjust this to be finer grained blocks based on the address
> > map from the AC5X Family Control and Management Subsystem Functional
> > Datasheet.
> >
> > Signed-off-by: Chris Packham <judge.packham@gmail.com>
>
> Does this mean we don't need to revert that other patch, or is this
> unrelated? Thanks.
>

Unrelated. Just something I found along the way.

I had hope it would fix the hang but with or without this change the HAFDBS
support causes issues for me.


>
