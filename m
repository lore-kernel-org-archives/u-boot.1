Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68299C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 01:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807B987763;
	Wed, 31 Jan 2024 02:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CwMK/Xry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7731487796; Wed, 31 Jan 2024 02:44:44 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D4787763
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 02:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cdbc4334edso2404686a12.3
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 17:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706665481; x=1707270281; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToFD6FK9+2r/Z0Iwjy7XDfHHQXO3BOoQEiNbACO4psU=;
 b=CwMK/Xryoqj9l/dC6Hc0NodRI46DyK7kEX2j9dN5lUaNe/QZofPXiN1MFVmkRmDxhr
 1+i9I5GAznOkeSUI+oUQxWnBg/otkgMFu8DfqJPwcqi38U1Do0pHm4WQblgpDH/D8fLC
 uNccEPUWbEUoc4yRcpcoKeXXLC8GfiPkGvRKuy5ph7ZLmberMEx6Zw1yB1Sexqg8xsfa
 HND93jqUjdTWJOutDbbQv2GFHNBcsWrGPdIU2mXM5nJOogmyVf+HzobPUBEROARdyhVr
 IF5MomYLHygfg3dg7uEi5IDe0SKaj//e7lC+Ytad4tXrxHad12EQA6ClTjiEp1ZAEJfT
 L21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706665481; x=1707270281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToFD6FK9+2r/Z0Iwjy7XDfHHQXO3BOoQEiNbACO4psU=;
 b=EYltTumlu6tmhgYVs5AiBJesjt3fCm6N6/NiaVfoBZoB8D8Vw4D/ocx7q/DGm13aE+
 /u2uYmEBz3QW5VbNVT3DuAz3RKNNy+hrSOP+z81PKPYMIEnDtJ+93Gm8rVqlsXjEH1k0
 Bekyb5L6/H2kWnbqvArOQuse0PGN9IKrviei9QkQyFzH1b28pquRPmMNnj5JPPh1fxKW
 wMtAoY7SpFSP6T2kD/t+OSkh5LIAoxo880Ig2CaucONYqRUxetv594DeS4MRbUj4uOjI
 xPXKpyBx+Tcp0VE9usRiKE7llB4nu2GqVvnyw8NG7rrP1/6oebb/WTztjFVP2QnUs443
 Uu+A==
X-Gm-Message-State: AOJu0YzeV4NJKQKyg5SWAu7ICwaYBYh5F6YkKeyzVEEYDNO+mz2vdzWH
 iIgRiuZKkLNQc9BOzoXhoF4QwxkbzNLRMkcZgMjJyIv1asviv0Aib8ImLVmr02yh/vPkOR31SsE
 V1HvXxwDuqQVSsZdajWHH2sA6qSk=
X-Google-Smtp-Source: AGHT+IFMJZ4M625RyMVUBO8xU0Baz5SJ99IVP9TpAGQjWESuDt77pTW89+VEZDYE3bRCHdpgx3ThT5TlnNCAcvrN6jg=
X-Received: by 2002:a05:6300:8085:b0:19c:9c9a:1b09 with SMTP id
 ap5-20020a056300808500b0019c9c9a1b09mr226424pzc.10.1706665480631; Tue, 30 Jan
 2024 17:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
 <CAOMZO5BJRDdD5a7JZ+ws7aqz0p0nmK_vXiq33=V3s5X_4m8+-Q@mail.gmail.com>
In-Reply-To: <CAOMZO5BJRDdD5a7JZ+ws7aqz0p0nmK_vXiq33=V3s5X_4m8+-Q@mail.gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Tue, 30 Jan 2024 20:44:04 -0500
Message-ID: <CAJFTR8Rn=y-vHfCktUjNjk8GqRgRaU2GJY0Qnfg6GmfEKd7pOg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Mon, Jan 29, 2024 at 8:34=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Sun, Jan 28, 2024 at 6:43=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.=
com> wrote:
>
> > +++ b/configs/imxrt1050-evk_fspi_defconfig
> > @@ -0,0 +1,100 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SYS_DCACHE_OFF=3Dy
>
> Out of curiosity: what are the problems if the D-Cache is turned on?

I don't remember this was asked when we submitted the original
imxrt1050-evk_defconfig

Thanks,
Jesse Taube
