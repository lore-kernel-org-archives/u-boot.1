Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB04CF9C6F
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 13:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39246881C1;
	Tue, 24 Sep 2024 15:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5zZSxcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6CD884D2; Tue, 24 Sep 2024 08:26:13 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A7188001
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5dfad5a9c21so2572627eaf.0
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727159170; x=1727763970; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s9W2evCJAzUT+WGZEXeoT8EL64Ay/AOcpLEmtamULp4=;
 b=J5zZSxcKExm+ZNUBRFvKAvCM6OmBct+wmM2fHzTNf2r4F7MtChh5ZtOUYsZCA83E81
 bWuvb2gUp++j1BvcT2VAjtGjvpcXmjUp6+NUfmlXLZntRkCU+JkQCF1wElbkDb2z3INb
 MZUb522MfugnYNFPFnYqSUJutJhvxDfFIWzVzHQMHiW1Gmz0XHfbtQwia1xcW2OkKUrd
 /70jwiw0M/7d4dOHD9rkZnbQKvRa7EFiSc0j/dMk14ZVo1e+sfx1pu6jM80t434Y4j3F
 FQoNrWht70OzMR5m3Kun6pRW4Vn9hnbTD/boexUxOJgJ/C7y0o8THp3FT1eBfdBakAzs
 5vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727159170; x=1727763970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9W2evCJAzUT+WGZEXeoT8EL64Ay/AOcpLEmtamULp4=;
 b=BCCYsaOW4i2tDRCdMMwDJoQ7W8ZY3OAuhbn6HcaKY19RjB3GJxmdZBYY9Tpf1gahqC
 MRr88fSnKHEa+6LQRcghpP2JcWdaClepl+DnHv+XuLrKZEsrSwO+7GgQ15omcGCvpqTa
 b3U1QFmAi5wWykEj6Ngq6fWTcVBoF4Ae6OV6q7d+4Tazfq9sh68ECh/1Sz93DA4Yphi+
 BIkMyamENFiWEjPLNuQQYqVXwQVfHPykPq0/vGHlm47tGmwp3nis03sfaSpv+mKq78H0
 mMU6wDpbThOkb9FD6j520RIK8CB+3ok9jAnZ/iC3gKQSIpXDxFGiyNBQa4sMVs79ZzT3
 Mznw==
X-Gm-Message-State: AOJu0YxYr9TtyGtFsQ299JGIQ92O4u3xYx8POT0K4EDnHx8zfRp5l1eL
 k3qJQzuOnCxlbXBVqZySuCWIh6I9z7q/EXcCppeLepEMGokWz9FTLslU/SPTtz7rn9WP9+nump8
 5Rqf5v15JdeHQQ/Og3/D71zlk8Xk=
X-Google-Smtp-Source: AGHT+IE+dvhpioo573gHhkNk54mRUFHcZ8ozgz7JPfYrG+9HkgsYDL1ABqSQX6qrX2B6eiBrioG8McntMdiJ3gDm9Ng=
X-Received: by 2002:a05:6870:390f:b0:270:1498:6a36 with SMTP id
 586e51a60fabf-2803a7b83f9mr9822170fac.29.1727159170422; Mon, 23 Sep 2024
 23:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
In-Reply-To: <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
From: Martin Stolpe <martinstolpe@gmail.com>
Date: Tue, 24 Sep 2024 08:26:00 +0200
Message-ID: <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: u-boot@lists.denx.de, Devarsh Thakkar <devarsht@ti.com>, 
 Francois Berder <fberder@outlook.fr>, Matthias Brugger <mbrugger@suse.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Tue, 24 Sep 2024 15:07:58 +0200
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

Hi,

Am Fr., 20. Sept. 2024 um 10:10 Uhr schrieb Ivan T. Ivanov <iivanov@suse.de
>:

> Hi,
>
> On 09-20 08:32, Martin Stolpe wrote:
> >
> > When the CONFIG_VIDEO option is set to disabled for Raspberry Pi devices
> > the build will fail with the following error message:
> > "undefined reference to `fdt_simplefb_enable_and_mem_rsv'."
> >
> > Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>
> > ---
> >
> >  board/raspberrypi/rpi/rpi.c | 2 +-
> >  boot/fdt_simplefb.c         | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index ab5ea85cf9..bc49708f85 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -572,7 +572,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> >       node = fdt_node_offset_by_compatible(blob, -1,
> "simple-framebuffer");
> >       if (node < 0)
> >               fdt_simplefb_add_node(blob);
> > -     else
> > +     else if (IS_ENABLED(CONFIG_VIDEO))
> >               fdt_simplefb_enable_and_mem_rsv(blob);
>
> I think there is one more user of this function which end of same
> situation stm32mp1.
>

Would it make sense to replace the config option CONFIG_FDT_SIMPLEFB with
CONFIG_VIDEO? CONFIG_FDT_SIMPLEFB is only used in the Raspberry Pi default
configurations but in no other board configuration and I don't see it being
used in the code besides in stm32mp1.c.

Regards
Martin
