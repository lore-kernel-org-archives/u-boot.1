Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77470C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF0E08748C;
	Fri, 17 Nov 2023 15:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="clf4xM9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E682586FF7; Fri, 17 Nov 2023 15:48:17 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D023387446
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c206572eedso402713a12.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700232492; x=1700837292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCwqz8t+CTHRshcQEkj8pzS/ALcSzu8/O4gJeesMF6Y=;
 b=clf4xM9nHmH8t4Sax40ur2rp8pquXi03r2q0MlUUIP1ILOoEV3+wveZBuLC0G803fI
 icU65bPH30BSDPxRxwdBp2cIP5Z69Dz5VDGcz/DvOKeprTcjLcJpbkA/JH11pNQt8X5P
 JAYshrsvZD/3//LHqYhj/Wi4Lfm0GOG2J8vZNdwMGdL62uvqTi3xzhfHINV9j1bvmzc9
 ffAw+Kmvokt4PBHMWP+9uBVmXc1+gn6QSBeeJgdYIfwlcNwuMJVIDhFUJzKpyxx7MSAZ
 CJAU3d/tIYeIC5/DqF9Pj57eLlQNZoP/aEe3+g0309ThmbeaK9KAcdReXCmgtzNK4klZ
 jI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700232492; x=1700837292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCwqz8t+CTHRshcQEkj8pzS/ALcSzu8/O4gJeesMF6Y=;
 b=WGzPSXW4ftTEjl20KZxFQvpeBIan2euXKD5+6p1h6vHX3xYyOjl5RAzgzH70vodw8h
 TJv3LNTr6kO7jEwiB30rofLXtlslrz0z95u4EbNy8mIXPKoWMWPeD8BHWFRnxTg3Yl4d
 nvDadPt1azHfc7d2+eqQ+qHa9XC6yAHO2akyQA9m5VWCEjsc9pFtCUQ0jJI6bvN7sMum
 Ncz4PwMStvbWyGkJri4NW5fKGvrj83oZNeB7hHnI1CmKmvbZDRRSMO71RCurVg8RU1rG
 hVC2ABMLALDBXmOKobdCVv78akoMznq9gGGYtO1aZ1LA8eu2myW6cJWOpxofvwljVvTa
 YB/A==
X-Gm-Message-State: AOJu0YwOlecj2pFTMNcTAx6TzkadwcNUd0WJkjL38L6eQtaDvuiDcdz5
 95nvvkjEaeHKYpDa9I35NGx7BCrobvDWFsq7+hg=
X-Google-Smtp-Source: AGHT+IHjZ/4AvoyzkuNaG2Klbbi8OMX9QygNjkN87fDlHdWM7wkHG6agZsRQXMxpwzHg4dTWAQdqnK2Ex/u+x4LqvwI=
X-Received: by 2002:a17:90b:4c04:b0:283:2652:3d08 with SMTP id
 na4-20020a17090b4c0400b0028326523d08mr22543916pjb.33.1700232491641; Fri, 17
 Nov 2023 06:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20231117013153.4299-1-aford173@gmail.com>
 <20231117144144.GG170968@bill-the-cat>
In-Reply-To: <20231117144144.GG170968@bill-the-cat>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 17 Nov 2023 08:48:00 -0600
Message-ID: <CAHCN7xKiEMTBnXmiVTtp6M3Zwb_vOxgmaQhS=VtA4760bnUELA@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx: imx8mp-beacon: Add support for 4GB Variant
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com, 
 festevam@gmail.com
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

On Fri, Nov 17, 2023 at 8:41=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Nov 16, 2023 at 07:31:53PM -0600, Adam Ford wrote:
>
> > A new variant of the i.MX8MP System-on-module from Beacon is
> > available which contains 4GB of RAM vs 6GB.  The memory
> > timings are slightly different, so a different config is necessary
> > to build the different timing file.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Might this be a case for using config fragments instead?

I didn't realize U-Boot was supporting that.  I'll submit a V2 with
the defconfig option removed.  Is there an example you can direct me
to that does this already?

thanks!

adam
> See doc/develop/board_best_practices.rst
>
> --
> Tom
