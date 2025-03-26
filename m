Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5336BC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 16:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B126B81253;
	Wed, 26 Mar 2025 17:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6tWdlLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A1981951; Wed, 26 Mar 2025 17:31:16 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1E9810E8
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 17:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-394780e98easo4078098f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743006674; x=1743611474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JC/HPDa35fq3srdVlGJUqSCVNkMJmwwC7pBrmc4iuG0=;
 b=C6tWdlLV06Re7AvXLGcAGKr9G2Lobj/mQ1TK5WmeuwQJA/8UnZFXmcKRIc7fzBGv6n
 ukLu7gZ1UfcxAVjacWw1JhM9/EzQXbdUQjZQoTZYQJSTVugOkdQ1qQg5ipbOovr51yZR
 +wMDRz0xrWx4kj+PZi2MsaYRw1pw4ywZ2oox2Pf/05VDvmeo8LlsE05MdV+r9iea+Adh
 sJympRwCFLmWQfYwWp+9SaSoyif+Wgg7laZ5v97GAbmgtjqoVT7HAASSPyIlHRWE7YIe
 v3QcAa5Qhu16d8Fu1O7yoivi8Tv5Julw5g9+VeHoEc9BtkzTMF7ytK4MZH4av9MBH4ya
 ZQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743006674; x=1743611474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JC/HPDa35fq3srdVlGJUqSCVNkMJmwwC7pBrmc4iuG0=;
 b=JHn4ILMSGsuRfvR9o9PujAYABOghPYjswRHDrDHeDL7/V2sHqqSIIKTLhlbiT4XXGQ
 l/w7DIjLBcfyaoZmhQsbsj1+MwYLc84QBffNP4YiMvwQgV1eqy3tSZamGzz9Prs9iJfF
 PQQwdL74APlTH5h/tf6LUvRBpniSxRn7pQsyy0JfvIrehYviEGj95u8UAi+A7DqEApLr
 DWt13QhmriQwquNmgUgob99do0y67u+/8wl3w295jh9YtrwbI+6/8lG2kmtlXRDqOKFU
 ZSenKnUZshA6e649vBXOZv+m4lbitU1P8lM0DZp90nxHR6JGvNNIO+X1l1CAkAvGofAf
 8lBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzzRaTLdogkBAXEiLErQfkQoampBpEYyTrBbW8SV11GCoFbI+FN0gjHlGgfxFEWr4Ei2cAE+c=@lists.denx.de
X-Gm-Message-State: AOJu0YyldqPl/JtcyF2pfXBYdHkHEhjJGh5xTcAt68e8fBPSckiHx0F+
 /40iKd6yXd5uGQmUoJobkF+OHSJCpjMAV66WzllqxjYSdUF6ySmZYtT/Rq2q+Q76Uv7wXmjCzAq
 /dVxauP/6So1ctT1pCe2UqvT5rxE=
X-Gm-Gg: ASbGncuo2qy5cvRgoMmMe/ZXHcacRLYfw97+z37IBrq/HIktZk5rmBDp73INPCMH0d+
 +GH8o5vTiaSwiQrvlQ0hXYnFaVXjzpS4vbWox0hm28wUWkRWjVnXm54dVtYPpWh87T7gFbuxRBo
 7mB3zwrgUSgFHW8N6OSxlxB0rUOFU=
X-Google-Smtp-Source: AGHT+IEt2NqC+VeYu1Nu4bNAjHWjpwh002a7blEmenU/6gdsUbo6jHtuVVbGiEjUh9+VWOTt36uNRdnfK95hFSGsMu8=
X-Received: by 2002:a5d:6487:0:b0:390:e9ea:59a with SMTP id
 ffacd0b85a97d-39ad1740264mr57094f8f.5.1743006673406; Wed, 26 Mar 2025
 09:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 <20250326-ge-mainline-display-support-v5-1-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-1-ea4bc3fc9bca@bootlin.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 26 Mar 2025 18:31:02 +0200
X-Gm-Features: AQ5f1JoiyhZJpETRfNx3E6XlKY6QxG2g1ESQZ5zUeo5MJO3_fRx0jvQvjeXjkm4
Message-ID: <CAPVz0n0hZCXEEwrE=22SV_c-L9=7GfL1B=sCrY-6cddEQuTESg@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] core: ofnode: Fix a comment
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

=D1=81=D1=80, 26 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:01 Miqu=
el Raynal <miquel.raynal@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Naming between the parameter list, the prototype and the main comment do
> not match. Fix the comment which seems the be the one that is incorrect.
>
> Fixes: 9057077cf4e1 ("core: ofnode: add of_graph parsing helpers")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/core/ofnode_graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

If you will be rebasing it once more, adjust please commit title to
"core: ofnode_graph: ..." since this commit targets existing
ofnode_graph.c file. Thank you.

That is not mandatory if the rest of your patches are accepted.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
