Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B456C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 02:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D81B87536;
	Sat,  9 Dec 2023 03:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+ahcN2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EACA8757F; Sat,  9 Dec 2023 03:44:39 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5A4874B7
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 03:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d1cb7651a9so5853345ad.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 18:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702089875; x=1702694675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bZxkUvNrDX+Ow+/O4wOVKFJ1dqm6YkiwsZGIQA/7CQ=;
 b=W+ahcN2e+0gW4AA02zum8Z0pc/e+EZEMhvL9G8sDvriPJ3QpcCdfSaD4B7J2ld044O
 upB29vXoEpcmCZin6hGrlPBASq7RcQGooKIKPh6xfsi9ayNe4LdQSXDZ8m84yVeDl0gQ
 gAH58fLiDugjzdnxXdoxpIOlg8ud1g5DlAD9YX7dZcY5Ig9Zz00asOilwu08jaass+Dd
 UeKe4APmnl7FUTeXkOv0Y4EYHQuzCgHal/WvzKgehmAUdXq38iPeBLPqr4Qm4jvmCBSv
 ve2+/HKyJFVmVMj7duTtYlLi8sQpfIVPjy2Lb8VpO9IH+e/OXzLYcTs3EG84v3UN//OW
 lVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702089875; x=1702694675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bZxkUvNrDX+Ow+/O4wOVKFJ1dqm6YkiwsZGIQA/7CQ=;
 b=xDYlF4KwDFQi2iKWZcuIvW2HpUYM982C7nyAnsK9GIns2/OjvQKChU7NdEnT444Z4G
 MriU3sz/UwT8FqsymWMoyREGPQBzapUozN6ISYC/3QBBTylCpQMMsdvVKl+goMHFlvK4
 ph0tL80fm4rzqp+DpXjzNeUbATLiHj2Iym8TvkueZ4mqatXYcyJH1Ghv3mOqMjaPSRQB
 uqniy2CGRovxjbbVmzYMmqVgjThkcsTg+p1YsQSp705VLCLpnl2BCvTU2mEInALYlvBe
 YkaHzaBwfM402Xtv5g3+JX2a7nj+cXFjT8QcTA0mB1ETwBh9jsKfX1lphsMXBZkRsYnr
 c2ZA==
X-Gm-Message-State: AOJu0YwRrlH7ltnIb7V80TlQEDq+Rjl8hpkOGCCFuK2B3FJS7LTMRzAM
 UdY+z+1kAD6slculcHayrCt0STFiLnzSsgCDO90gNMMdtlM=
X-Google-Smtp-Source: AGHT+IH6re4LvD/iEEn6NF1HH5RA5HlU/s6N0fAiWmMkDagOUlhHdgJcS97XwLqeBYo+74F7DfSxS7YS93yJk3PYX9A=
X-Received: by 2002:a17:903:32cb:b0:1cf:ce83:3b5d with SMTP id
 i11-20020a17090332cb00b001cfce833b5dmr1952277plr.6.1702089875260; Fri, 08 Dec
 2023 18:44:35 -0800 (PST)
MIME-Version: 1.0
References: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
 <CAOMZO5BzCRhNnseNq5RMP94GLt=1H9s742ywtm_LWOqTxaJcrg@mail.gmail.com>
 <CABqjNW-w3BRg0rqDXXYRMKY6-Ws3HsuxdUbx_pKAQ2hiuUrOaA@mail.gmail.com>
In-Reply-To: <CABqjNW-w3BRg0rqDXXYRMKY6-Ws3HsuxdUbx_pKAQ2hiuUrOaA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Dec 2023 23:44:23 -0300
Message-ID: <CAOMZO5DZ9WzWqeHQ_ApgCMW_jTxiGCPeB4s=Q921jTdkbZZytA@mail.gmail.com>
Subject: Re: iMX6, CONFIG_IMX_HAB and fuse_read()
To: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
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

On Fri, Dec 8, 2023 at 10:15=E2=80=AFPM Lisandro P=C3=A9rez Meyer <lpmeyer@=
ics.com> wrote:

> I added IMX_HAB:
>
> ```
> $ echo "CONFIG_IMX_HAB=3Dy" >> configs/apalis_imx6_defconfig
> ```

Please try like this:

--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -21,7 +21,9 @@ CONFIG_OF_LIBFDT_OVERLAY=3Dy
 CONFIG_SYS_MONITOR_LEN=3D409600
 CONFIG_SPL_MMC=3Dy
 CONFIG_SPL_SERIAL=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_SPL=3Dy
+CONFIG_IMX_HAB=3Dy
 CONFIG_CMD_HDMIDETECT=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x14200000
 CONFIG_AHCI=3Dy
