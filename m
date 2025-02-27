Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7795C021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 01:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A1FD801FB;
	Thu, 27 Feb 2025 02:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQo3/ZKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8868A807EE; Thu, 27 Feb 2025 02:56:08 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB5A8006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 02:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-548430564d9so394144e87.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740621365; x=1741226165; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuFSxt7BLPAU1xjEGu23iy0jTgGyT1z7+sAQ7csm7uA=;
 b=LQo3/ZKo44lJ8HBaS5O1L2/gzuDo0ImAEwvVVUo58mY3S2PDgc1sA39KDE1I5vunKL
 HTagfvBidhYPyhsP+S6UDKiQuM3jLUxDribrrEtGoPKDKrHqUeeAKYN5e80xcw1t2p2C
 WUyLbXV5R09DbKndemPn0GzXnFQpv996DPRI92/11E6mdREmGXow/FTVqO5pRsxzwg71
 hIWBb+KCW/080HAO4S/htdTPy9FeQCDyQQ0qsHmrd1/0DVYJSmKvAt3mXJ4SegJAJSQl
 xm3EY44QxIYq8Hs3968jKCdknFfnpeDbOIhsq7xOelmi+jjn45sTZAuGTmLbDlL7zNqt
 iGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740621365; x=1741226165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuFSxt7BLPAU1xjEGu23iy0jTgGyT1z7+sAQ7csm7uA=;
 b=pAiQnaB4qsOFJ5NLVw4cxYRUP8eWiW8y3RjTI+him/wjaXbiDW/R1/qIXXJvXJRou7
 eT5eFM3rauENUJcja1U8Ruv80mON82lU+KOS99DWLhKOFaONsxcjF30oum36fb55L3Kx
 JnTt4lpTzrE0iLMGlhHTcxyWkL7wPzNaQSWeaz2CAAHO0JUAEktHgpoNNfTHEFHjlb1e
 gsm8v1I+XjSo60iNQcLz2/UdgoFw9Q6g+NKG2xMcdfCP5lSYwou+W1FyrtvW5VmljaC3
 pfT65XKu5qmT5tvzPIIgsMwD86yYEEwYRg3y14uOII8uYVXiVEivm6lVTvRcsnNR++FW
 J6HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWk5N0gxuxD0M05QWoDoRrSDmckHgbRJYUvQn9YGCQR/Oj3SOklG2mcKtw6UX16NHf9DO72Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yyref8sVCtZ2UEOWBRRpMoGZpAouIt/UG4idfBO6nIU/EMVSrBw
 FeBbBFLMXWjgxeimxxrLge+rEDG0zMprN5nootQyV2jBtH75T1WjsoqjQ/dE3q//hdNCdzHnbX+
 TIzZyo7U4tRA2u6hNvMLQX02+37k=
X-Gm-Gg: ASbGncuUxl39Cz7f+Q7l7hRsFAyfBNaZdLMfRnswZyq3IwahIvqdcT4GDwWvq8qCWLU
 KMspKrem+fiwBHcClQuyIE3FdCWxQndAY8PLBjEqckF/yUbhtWu+n0ZFulpSZT3A/fEjmN5XUiA
 emQU0seiLLyGA+T5y6Z9VLf6U4NZuVrLefGIAJBBo=
X-Google-Smtp-Source: AGHT+IGKlniHbAYpW7RFbHvURw4X8RItSftalnhnMjP83pyh5UjsIrNp7Qr20R/7xl+ZEAVm/XgZ4U50wfV3QtqezBA=
X-Received: by 2002:a05:6512:308a:b0:545:296e:ac28 with SMTP id
 2adb3069b0e04-54839144ee2mr12740093e87.24.1740621365241; Wed, 26 Feb 2025
 17:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
 <20250227005524.GP2640854@bill-the-cat>
 <CAOMZO5CMHA3QZKd_6uO_u3hj29KWe4dvYsY5SLaDNznbWegY6Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CMHA3QZKd_6uO_u3hj29KWe4dvYsY5SLaDNznbWegY6Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Feb 2025 22:55:53 -0300
X-Gm-Features: AQ5f1JoHcy3qURmnRA9sRh7JCbpnXhMfGx-BHPZRtbaYM2YowSw8Ht-8OsWKiyU
Message-ID: <CAOMZO5DDhB4OfpEOq7D9KeDCe1Q467Q1jg6rKq-vEX8yWo09_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
To: Tom Rini <trini@konsulko.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Ludwig Nussel <ludwig.nussel@siemens.com>
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

On Wed, Feb 26, 2025 at 10:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Wed, Feb 26, 2025 at 9:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>
> > But what part of things here is trying to call "sysboot" as a command?
>
> This is my first time using bootstd, and I am not familiar with it.
>
> I got a 'Unknown command 'sysboot' error as shown below:
>
> mmc1 is current device
> Scanning mmc 1:1...
> Found /boot/extlinux/extlinux.conf
> Unknown command 'sysboot' - try 'help'
> EXTLINUX FAILED: continuing...
> Loading Boot0000 'mmc 1' failed
> Loading Boot0001 'mmc 0' failed
> EFI boot manager: Cannot load any image
> u-boot=3D>
>
> That's the reason I added CONFIG_CMD_SYSBOOT=3Dy into the defconfig.
>
> If there is another way not to use sysboot, please let me know.

From cmd/Kconfig:

config CMD_SYSBOOT
bool "sysboot"
select PXE_UTILS
help
  Boot image via local extlinux.conf file

So it seems that selecting CMD_SYSBOOT is a requirement for booting
extlinux.conf.
