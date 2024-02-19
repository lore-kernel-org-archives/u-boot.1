Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F22C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 694CD87F36;
	Mon, 19 Feb 2024 14:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kji0S8VU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A2487F51; Mon, 19 Feb 2024 14:12:51 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3335E87F4F
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 14:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-299a9d382ccso229908a91.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 05:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708348345; x=1708953145; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMmBW0aDFDWalea+rcr3BZ5RjJzt7xB6VHoHEnGLBsc=;
 b=kji0S8VUBceUnsV4t6q05M2XiKI/PgyCRwC6D1+KWqe4SYia/scLii2qgDBSIkAgyw
 uGFvltUqHYpA6HthKNRLzdAKozzCKwyjPr39+fQoTjq3MV0xZgng1s1r9sdcDe4+66R7
 Yw/MfTaST2idXYHAFSo3WsTkAXTdCwfa1RekcB+/h9GYrxZU1RcxGdNU2XX/dCVmzNgT
 W3vbZ/YmrVumMoUaS7aM7k4o56aAhjiMHno/5DPKdFLKoq2XpS2ex2/e4IqADrwq7LC5
 fAzUixsX6o8oKlRK9o0SCczqbVtxBCt59kivIJoZxMA1SSRY6rgNI03+vk6R0pCy8ns3
 dY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708348345; x=1708953145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMmBW0aDFDWalea+rcr3BZ5RjJzt7xB6VHoHEnGLBsc=;
 b=l1I+gB7vyObf0C6EuF6Boq7Nk4bUGgM3UKqpMZK/vDUkuqc6+uGS6Sf+it4JwCmxzV
 lYgFV5J6H/IB1I+PvRl/VR2QXLPzY+XimDFC5cLjoGKbNWWQEB40AfjccfHo0WRoXg1X
 t6zOZRTfRkD+4v+mF6U+aayLASwKBUIALDd36XedG/FKIJL+EIb2cUVRZcy4Xm9r9MJT
 PqK5oQLxjoSKVID8Jjz/H0iYwfqJsiVAcrIH4jnbeyGJ4F02hMRwLITxc0fI33eSuDFE
 U1AZ1+75peZWNHDmGolhNMcuoJ6w4Mg3WkaeOGEFphFOH0DaZrmpU1NO2P8QAnI/Ltvj
 EZgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOD2/mf8l6j+NjFnqebOM8DeiJgQU08pEoJ9wsimne2h9p7l9rg3Ez05hziMxMUErckEwyeMmS3c0yMr9xZhrFo3BGWA==
X-Gm-Message-State: AOJu0YxHtF1tu5qB0AqLz01VyMhinZYf+/0KawcshGcPUSASRRi3bbDg
 vKqij3OVi1C7nVtIadgamivVYV52MBBA4EtkGs/RbLrI541EW+1EDx3F3oKyw3361WtIJRAlAY5
 bxv0sI1V2z9lkaH3lKpk6S7AJN8c=
X-Google-Smtp-Source: AGHT+IH+xlxg3rvGRGLKGMKWqvvGdZ0CQj4Hc5apDhTcJ5e6dpJwjAby2A1lVKRhr5u5/2CuQSyO6SM5+LdhIaamYXE=
X-Received: by 2002:a17:90a:985:b0:299:3258:fdfb with SMTP id
 5-20020a17090a098500b002993258fdfbmr7476617pjo.4.1708348345370; Mon, 19 Feb
 2024 05:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20240215140043.220680-1-frieder@fris.de>
In-Reply-To: <20240215140043.220680-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 10:12:15 -0300
Message-ID: <CAOMZO5CoNWVK0_Zz6UDfx58tuhTkp7MyhCUEC5YyKZWzkfD8_w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
To: Frieder Schrempf <frieder@fris.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Vignesh R <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Andre Przywara <andre.przywara@arm.com>, Bruce Suen <bruce_suen@163.com>, 
 Godfrey Mwangi <godmwan@microsoft.com>, Jim Liu <jim.t90615@gmail.com>, 
 Jit Loon Lim <jit.loon.lim@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Neal Frager <neal.frager@amd.com>, Nishanth Menon <nm@ti.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

On Thu, Feb 15, 2024 at 11:00=E2=80=AFAM Frieder Schrempf <frieder@fris.de>=
 wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The datasheet can be found here:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B_Ver.E.pdf
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied all, thanks.
