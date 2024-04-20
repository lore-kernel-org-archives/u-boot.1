Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B34C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87899887C4;
	Sat, 20 Apr 2024 20:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mFtkXyOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2264887C4; Sat, 20 Apr 2024 20:36:14 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C427488791
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e825c89538so4220745ad.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638171; x=1714242971; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZCtvhjB85ST2SfiXdylDEUoFomyMy0UL9ZzT4Iw4OY=;
 b=mFtkXyOl+aFR3SpqTXDGALOZkpjLCceQPVhYAUWWODNNcs/gqYyNHOSMmtlDMylxZl
 i5R9pxleJlbnV2293ibJNjy17VjsRrFLVgbX5fqU+CPMP2uyH374s5Q+/IuYu8Mkz0Kx
 z9uvtvag36Qb5XNQuzeJttRZPKvyZfEbhj6tWa7f54hq1qQrqDWflnjhlwiDnp5GmkeE
 UGrv30bwaLGCeaDw1rNIwDrhosiU/9A6Jhe4h1YEUSGbxTcSYIHuTiSe0w40nSXzOP7O
 QO5SIHe+MpgZ2x5kstljrAIPWhWPJKV3ymHRlVJ7qEB4eEN/5q2rAQbMQ3uQDr/LqBCY
 EOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638171; x=1714242971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZCtvhjB85ST2SfiXdylDEUoFomyMy0UL9ZzT4Iw4OY=;
 b=vfBRsHzi71bap9jp7b0nGiWgcG7ItmtSQ1O1WIjqsWv+jYWE1cABfCfrkHTbyPzClN
 N3QTZysvPeS5+PFJoo+vyytMYcm2c+Xd9dNeCpIp3XYDTJSDiP/tPOM6unCctewmrSI1
 jyIQsUskvEzvGs55+WUyamLe8H8IwwFkRdACfFmtZ/zxkc7RnMojfKCtdLfMBu69yWr3
 AsvP2bhEsrofC/niL1Kmab5DpDj8AFW0QbwnEG/O9vGZ0cj6RN2vJKwafIRXIS7YFvLf
 dJ+XUq0ldxsvBXRcl7hjLEeDRx76CHJrsllW6yGRBa55+lPVT6g1VYehMYuKfEe/fQje
 m1Vw==
X-Gm-Message-State: AOJu0YyXnFAG8xeTTibTcyMrJ44sRdi0wlI5ma5BvouqgDbHTnm/ogT4
 lbN93LlovAOWq+TK0LWLM2CqfcgcQHj4C5IGG4311COZm50/TpaduL3+D3Nha1jy1ugC1aMVsdB
 m77hY1vyoPmBDYKRG3+yaHoH6/Qk=
X-Google-Smtp-Source: AGHT+IEjGmyVeuCp9Z3aZFy+6jqU88yyy0dN5AYuCs7/vrCR5nOT0aPGAp07Zy60+tM2+dWacZzHxst4d2g6iymClCs=
X-Received: by 2002:a17:902:b08e:b0:1e4:3299:2acf with SMTP id
 p14-20020a170902b08e00b001e432992acfmr6762278plr.3.1713638171336; Sat, 20 Apr
 2024 11:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240417200153.3748943-1-tharvey@gateworks.com>
In-Reply-To: <20240417200153.3748943-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Apr 2024 15:36:01 -0300
Message-ID: <CAOMZO5C=x-mjD_ybEFLd6_HoYDxMf6dHtBv5FLbHHAQhJ7gBhw@mail.gmail.com>
Subject: Re: [PATCH] board: gateworks: venice: fix dt adjustment for gw73xx
 baseboard for imx8mp
To: Tim Harvey <tharvey@gateworks.com>
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

On Wed, Apr 17, 2024 at 5:01=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> The GW73xx baseboard needs a PCI dt adjustment for revC/D based on a
> change of the PCIe switch. Make sure we are only doing this for a pci
> based ethernet to avoid causing a boot hang when the ethernet1 alias
> points to eqos or fec. To know this is a pcie device ensure the alias
> begins with the pcie controller.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
