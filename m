Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072EBC54E68
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8645E87F6F;
	Mon, 18 Mar 2024 00:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MzcyfWBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0443387FC8; Mon, 18 Mar 2024 00:54:25 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F17487F3F
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29d51cdde7eso1262491a91.0
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719660; x=1711324460; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlDjW5ZRGxArk3uzT1uKUKbgIGh9oMVDETbOEmSmVKU=;
 b=MzcyfWBsryfEug7nmr3aqCoxVVBP+hdxPIf2tw/etBNiEPMKRgzLqY82W465RY3EfZ
 fznPoyir6LZRHbC6EsXEyxLlaOxfxLX+2kaXPJNiWcAIWbKAwQuH5XL7t+oY7WurMepO
 9yR/Rh1PE1z6YXCFWIIe5cxdKRgWagWzKyrHqCn3ihyirTLdPX9Df44sI2z6F/aruvKJ
 JZ8K7Ca2PIwYiGQvihdVrgWnHsdvUYvACDVLMifshy2/jV+r7DYtB4VCF04eYosA7QaR
 bc/VylnZb1gLIB4zgVcwq7yQjEA8T9shVU25S3+JU390DTftDzkYCh0zb46HEg/qrljm
 9AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719660; x=1711324460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlDjW5ZRGxArk3uzT1uKUKbgIGh9oMVDETbOEmSmVKU=;
 b=HUcsi+Fz9wPR4qQHzzR8s8jXde8DHQodZzCZBMBFTyx1h5VJU2A6v11fRcOHenHJHT
 /szbcBUm87FZljDNdxV64NbLFKO2++Mn2PM51tZwq2RuSAda8FwmkekmbEp3SrI4J82I
 GqB0lMGWd1A/q+uTLXn7A525fZ7M4xoVoFZf1zyJZA/NKx8oDE9fkBfDLpHWqY7gY2Cy
 FcRYOEQZj91Sz19pZXxrPLH2a/CubW5BxKu7k2Ee7dZ408pcQfVTffinOlWX5hEXspzu
 SQBfHCkNlIxJF30jt6kEy4koC4Lj4XV99TI/48jzywBaCbClsWjA1uFX3xRa1/NWe0Mm
 sPxA==
X-Gm-Message-State: AOJu0Yy5A5OlNYwpEZigovR4YX2FkeCBY1UvU4IjLwO+TfJBW/j6ciaj
 7jEXJh0Pe7+WdEB14+lOVF9H0dvIbBG7AnkjY6NNs0CvDcIsgbOfzXVxoBvvONO9fdbyAAXDirl
 g4CbrCsJEgSp98CWV82P7INCIC0A=
X-Google-Smtp-Source: AGHT+IFAb/nINnWZeFmEYnxeNsSdv6h56ZSjsXZ1EUVveai4tyT0UUbbc/v8f5Y6ZCJvJ/ruiXAocMTd4AOUJ6Hod7w=
X-Received: by 2002:a17:90a:8a97:b0:296:db75:c240 with SMTP id
 x23-20020a17090a8a9700b00296db75c240mr9339296pjn.1.1710719660085; Sun, 17 Mar
 2024 16:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240312190543.3544532-1-tharvey@gateworks.com>
 <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
In-Reply-To: <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:54:08 -0300
Message-ID: <CAOMZO5DqoLauuu7b8DQ_zctbfd+fmRuYTsUcw9YjLznxxpMbVg@mail.gmail.com>
Subject: Re: [PATCH] imx8m*_venice: move venice to OF_UPSTREAM
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Tue, Mar 12, 2024 at 10:16=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Tim,
>
> On Tue, Mar 12, 2024 at 4:05=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > Move to imx8m{m,n,p}-venice to OF_UPSTREAM:
> >  - replace the non-upstream generic imx8m{m,n,p}-venice dt with one of =
the
> >    dt's from the OF_LIST
> >  - handle the fact that dtbs now have a 'freescale/' prefix
> >  - imply OF_UPSTREAM
> >  - remove rudundant files from arch/arm/dts leaving only the
> >    *-u-boot.dtsi files
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ...
> >  33 files changed, 13 insertions(+), 10658 deletions(-)
>
> This diff looks great :-)
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied for u-boot-imx/next, thanks.
