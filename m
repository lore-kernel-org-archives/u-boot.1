Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86225EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D733F864A9;
	Tue, 22 Aug 2023 13:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sNK/gjPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23927864A8; Tue, 22 Aug 2023 13:45:07 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B4A8649B
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26fa19322b5so43678a91.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692704702; x=1693309502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZoHJqU4VqLzZiMBoZO/HOAwSv1Aq+wRFHYHrdcZHug=;
 b=sNK/gjPXx4lK2aPdgFonC4bHxCUSLsV6znudL/wU6WD200tie11i5NyrHv/cv5UN7N
 gYXgZJ63P3fLtCleviyh5GR8znNVvrDxcDQVXabDE6lgh/y/LJwFvq/La7QxrSd3Cvgy
 uStqid8wn97DP9waZD5MqHF189W1vTbfAo/2nxp9nvi7fDuj/GCBhgWhvFGF753GZJYq
 doAEnWSQ23mA09CR0q9myu2DIv6HP1mPVCxFKgxwQm8jaYA78EIydwrJ7BKhJfgk/kzH
 LqSw0VNWRIZFUyXCcruVcAdWrb/fDxi/acgir0sruQBavh4Z+HfjQXOmaLEwe2wPzDJi
 mgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692704702; x=1693309502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZoHJqU4VqLzZiMBoZO/HOAwSv1Aq+wRFHYHrdcZHug=;
 b=PNze97sAjzsJA2mKsOtm3HcwqDejXFyGLiG+LObScedQuRN2TJsW8Q2HSA4OSfIO+n
 KyEdZ+x5G5YfgqpSqp8J89kzfRm1Hreu9J/TY3YYA/lrWkgdG1R8Ia5fAF2g7z8Wqx5j
 70PTJ6ZtbVNXX5dCIMTU8sr6cODXPXjjt35mcF+l6Lu6lXlxcpLr7KCN2fTBEdYYxyyp
 vA9JEBApfNm6qdg4l9ooIoYeER52WNdgQdxfwfxks1qG4I3naDfMhkTSfdq4xUy9jbz4
 Jt66HfzWYq/XRgCJld1vZWWYDNgfvTHQlt02kv8I0V+Lnn7EdrBoXgkYTqVIZJGJkshT
 RjQQ==
X-Gm-Message-State: AOJu0Yy93UAu+KZcSvzcUl84oaHs/FLzwzsd+guLP0lZodCk97knSWPK
 c/5MbjzcySqz3fp6dZwilNRfLv11PFytbwwOD4g=
X-Google-Smtp-Source: AGHT+IHDXn14wZfsgHgOkEAzbbKI+mov1KN6VUzySwrgQwaBoCGbkKaakbmDeRurfCx+ijqARyLFe9HxBL4Bpwydsfk=
X-Received: by 2002:a17:90a:7524:b0:26b:27f6:9027 with SMTP id
 q33-20020a17090a752400b0026b27f69027mr8169686pjk.1.1692704702091; Tue, 22 Aug
 2023 04:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
In-Reply-To: <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Aug 2023 08:44:49 -0300
Message-ID: <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Rogan Dawes <rogan@dawes.za.net>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Rogan,

On Tue, Aug 22, 2023 at 6:42=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> wr=
ote:
>
> Hi Fabio,
>
> As far as I am aware, the U-boot source for the Wink hub has not been
> made available anywhere. That said, the RAM chip in use on the board

Was there a formal request for the U-Boot source code to Wink?

As per the GPL license, they have to share the U-Boot source code.

> is marked D9LPX, which apparently corresponds to the following item:
> https://media-www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/dram/ddr2/512mbddr2.pdf?rev=3D2c70f8a2b207452584b2bf040de8d771

There is a tool from NXP that helps with the i.MX28 DDR2 controller
initialization for a specific DDR model:

https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/=
9552/1/MX28_DDR2_register_programming_aid_v0.2.xlsx

The DDR initialization values obtained from this tool are then used in
U-Boot inside the 'mxs_dram_vals' array.

There is a common DDR configuration at
arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c.

Most likely, in your case, it will require a custom mxs_dram_vals
initialization, like it is done at board/liebherr/xea/spl_xea.c.

> I did try to change the iomux_cfg_t as suggested above, built using
> make mx28evk_defconfig && make u-boot.sb, and used mxsldr to try load
> it, to no avail. There was no output on the serial port at all, or any
> other suggestion that anything was running.

It has been a long time since I used the mxsldr tool.

When time permits, I can try to load a recent U-Boot over USB using
this tool on a imx28-evk.

Cheers
