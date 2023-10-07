Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E23E95A63
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 12:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E1E86CDB;
	Sat,  7 Oct 2023 14:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHk89QNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A09186D83; Sat,  7 Oct 2023 14:55:00 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A4E8477A
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 14:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27755cfa666so508264a91.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696683297; x=1697288097; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blSgt2SUqhzzA9cZFVMnnDjbchqNlFMVuJ+8AQFNsIc=;
 b=LHk89QNTMoCmVW/tumTEA3jt0A97Kxoz22dLqymqWJl4ZJ+Kcn99JBwE4LfTVD6Mpv
 ENQq9dhej5F0ZOe7q7nIXsX0+1Ny6NCOR+0PmiYkZC1OQuSdXwJxPTzScpDNd+MIfVTR
 lFgxPnldxijGQqCd9X30XXp/e+/Cskt5xVJ3sZp/mROfP4z1uI/p6rW+x5OinfRluOTH
 pODIeLfTyMGg2imz3hpTpF7W8sTmVVJnpxpI8fiV2M7mlWj4DP8giGzjPGq3xE40qMyM
 wwJk8ZU7CnJKSFx/CVmTFxuzY5nLnb/5hNGm9a0yf3PXupHQTZmpjXLDnQM/jt0zQA1d
 3oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696683297; x=1697288097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blSgt2SUqhzzA9cZFVMnnDjbchqNlFMVuJ+8AQFNsIc=;
 b=IiZUwyAYlIACKL5p+BkQ7VzMSoN7jWRPyit6vPa6+0kPsIfTB4vfI63Sj37D/JAY8w
 rZbvY0lYs43QreKW+DWX9OsxhuRppBFPFkpG6LBJHJgoCbu0JxuD1mkSJbexOPscnXyx
 b6vE69dziMbmaueDdPYO3vYj/L/M9BaAW5aLopuzg0YP1vk9u2pzNuPq0HOKX+Hgzycn
 G4SRITybsIwmacDltf1jvJW1jmZGOaPh5byItekxhmhe+X5pB4oAXAJcHlmZ5v1QCflz
 PAM1Gh6lYdREfsfQ4HhMBt8NpobWcfzXYK3BZ0m9aoHVaLMtX04yKWZua8yNNwXDU0Pf
 CoQQ==
X-Gm-Message-State: AOJu0YzXqPJbwTUG8XmThJDCulHPGY6rfpLd4aoCpvLKmViMREZQLCmj
 ZnueedfVx0//6kCgQ2WDNHWPr9293bKBqI5rYMY=
X-Google-Smtp-Source: AGHT+IHPM/EzWfE8xNIGsSrJ839zZu/gC7rVpo6llodHHosbmW9WlCJyailtUuo+9jg9Jm+fOnEasj/RxNW5bB6LfwY=
X-Received: by 2002:a17:90a:7b86:b0:26d:4312:17ec with SMTP id
 z6-20020a17090a7b8600b0026d431217ecmr9743258pjc.1.1696683296065; Sat, 07 Oct
 2023 05:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231004090810.28923-1-sebastien.szymanski@armadeus.com>
 <20231004090810.28923-2-sebastien.szymanski@armadeus.com>
In-Reply-To: <20231004090810.28923-2-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 09:54:44 -0300
Message-ID: <CAOMZO5DQxSH8SaPs1cdxOA3Qurpfu-LaVDwDKyLzUJGFQa0-kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: imx93-11x11-evk: add bootph-some-ram
 property
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Stefano Babic <sbabic@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

On Wed, Oct 4, 2023 at 6:09=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> i.MX93 11x11 EVK fails to boot:
>
> U-Boot SPL 2023.10-00558-g65b9b3462bec-dirty (Oct 03 2023 - 17:40:10 +020=
0)
> SOC: 0xa0009300
> LC: 0x40010
> M33 prepare ok
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> image offset 0x8000, pagesize 0x200, ivt offset 0x0
> Load image from 0x44400 by ROM_API
> NOTICE:  BL31: v2.8(release):android-13.0.0_2.0.0-0-ge4b2dbfa52f5
> NOTICE:  BL31: Built : 17:52:46, Sep 28 2023
>
> That's because commit 9e644284ab81 ("dm: core: Report
> bootph-pre-ram/sram node as pre-reloc after relocation"):
>
>         "[This] changes behavior of what nodes are bound in the U-Boot
>         proper pre-relocation phase. Change to bootph-all or add
>         bootph-some-ram prop to restore prior behavior."
>
> Fix this by adding bootph-some-ram prop as suggested by the commit
> above.
>
> Fixes: 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as pre-re=
loc after relocation")
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Yes, it is getting harder and harder to keep track of all these boot proper=
ties.

Thanks for fixing it:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
