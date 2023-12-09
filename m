Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F728C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 13:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D209B87655;
	Sat,  9 Dec 2023 14:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ics-com.20230601.gappssmtp.com header.i=@ics-com.20230601.gappssmtp.com header.b="AxEOAHAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96728757F; Sat,  9 Dec 2023 14:37:01 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BCA87078
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 14:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lpmeyer@ics.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1faea6773c9so2031107fac.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 05:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ics-com.20230601.gappssmtp.com; s=20230601; t=1702129016; x=1702733816;
 darn=lists.denx.de; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOeQafTGyuHit5RYldWUKKeEZs6sYeWTA4dPHxsIvMY=;
 b=AxEOAHAVzNkg4GRG0sbCAD7OxecrJb3LFH89//zd6G5VogWl3vHzoCcqjJltWVzkrW
 cGEx6YDw99T4vyLODcsTzQxPC0ggXyDTqxtPBIzfIqTgu949GYeeQrFvphwE6KOFCoxD
 VVOiCo+Ga3k0IFnkncGICGUwldYWuZENLlx48fazNFaUg/OURjDQ1MWrTEmCTpByFvi1
 Cyu89Kc6czKNnDEXNx5pkIlhvZTtTQZNSIyaruHN4i2m/pYBvUTqJMybMLGs+Vi6yy7O
 edIp6bUaMwsq3ieIjcC7TTgkPCPGvndmgcNCaxP76Rha7a7LgadZUuOKrwgUVG/omNfG
 7Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702129016; x=1702733816;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOeQafTGyuHit5RYldWUKKeEZs6sYeWTA4dPHxsIvMY=;
 b=wPmSgIsRIFv1dobgrLixpRKdGymL7Ui1lbyywKwwoNlcLoUVD7vOxpU4rzJGL54J5E
 7wMpdPkhihTNqlSgqUaoTsDcpnhioZwA1SQrmjSzVARTJ3qOIpndFCW9spGZIxQrbJ4o
 KtMDKoUjvgLCWFj6jYPS5o8KwjFgvAgg78HziNzhVStDLJT8ifzk6LGPR/Now4zW+B9n
 vSSZtX/nJNLqi0EsbAILLce2yUbCooCEhlYoxGpLeKWw+u6utczN1o66kampTpKScukx
 G2GAgHwGvu8BuWMz6O8B+M6oTTOrhtoAomCVS+1HPOPfaL/JyAc9Exd6XG/HtUchgKKi
 uNMg==
X-Gm-Message-State: AOJu0YwoMSkdp4XQKhZoNteAWZbWRlP6OYnLcq+KR+8eM1aqM2guj9jR
 f3ogHEmH8hjxGvdjHYA/5GKfCn3NoX+fhMthPLP8xFa5RDpmC0QG
X-Google-Smtp-Source: AGHT+IFzriPrK7cRcE/aJZXxFDtfJhWkyZcCm/I1cnYwmve2YomjfHj2unw7Bc6/SlpZRI2ms93+zD7bqdkVtRO3lMs=
X-Received: by 2002:a05:6870:d208:b0:1fb:75b:2fcb with SMTP id
 g8-20020a056870d20800b001fb075b2fcbmr2145822oac.98.1702129016521; Sat, 09 Dec
 2023 05:36:56 -0800 (PST)
MIME-Version: 1.0
References: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
 <CAOMZO5BzCRhNnseNq5RMP94GLt=1H9s742ywtm_LWOqTxaJcrg@mail.gmail.com>
 <CABqjNW-w3BRg0rqDXXYRMKY6-Ws3HsuxdUbx_pKAQ2hiuUrOaA@mail.gmail.com>
 <CAOMZO5DZ9WzWqeHQ_ApgCMW_jTxiGCPeB4s=Q921jTdkbZZytA@mail.gmail.com>
In-Reply-To: <CAOMZO5DZ9WzWqeHQ_ApgCMW_jTxiGCPeB4s=Q921jTdkbZZytA@mail.gmail.com>
From: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Date: Sat, 9 Dec 2023 10:36:40 -0300
Message-ID: <CABqjNW9GBhd7ojKuRum=ZV-W8gAQ1Cv8wdm6M8=iED+Zt2b7rg@mail.gmail.com>
Subject: Re: iMX6, CONFIG_IMX_HAB and fuse_read()
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 09 Dec 2023 14:58:01 +0100
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

Hi!

On Fri, Dec 8, 2023 at 11:44=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Fri, Dec 8, 2023 at 10:15=E2=80=AFPM Lisandro P=C3=A9rez Meyer <lpmeye=
r@ics.com> wrote:
>
> > I added IMX_HAB:
> >
> > ```
> > $ echo "CONFIG_IMX_HAB=3Dy" >> configs/apalis_imx6_defconfig
> > ```
>
> Please try like this:
>
> --- a/configs/apalis_imx6_defconfig
> +++ b/configs/apalis_imx6_defconfig
> @@ -21,7 +21,9 @@ CONFIG_OF_LIBFDT_OVERLAY=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D409600
>  CONFIG_SPL_MMC=3Dy
>  CONFIG_SPL_SERIAL=3Dy
> +CONFIG_SPL_DRIVERS_MISC=3Dy
>  CONFIG_SPL=3Dy
> +CONFIG_IMX_HAB=3Dy
>  CONFIG_CMD_HDMIDETECT=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x14200000
>  CONFIG_AHCI=3Dy

That made it! So the question is: is CONFIG_SPL_DRIVERS_MISC something
that should be pulled in automatically by CONFIG_IMX_HAB or by
something else?

--=20
Lisandro P=C3=A9rez Meyer
Embedded Platform Engineer
