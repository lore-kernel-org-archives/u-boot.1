Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5088C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 14:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4D1889D4;
	Tue, 16 Jul 2024 16:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WoFmAHaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8AD8870C; Tue, 16 Jul 2024 16:25:27 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94265889A2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b5f90373d4so55195736d6.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721139924; x=1721744724; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJZP3LZ+KWoPWknTNVhOdoikvYryt7LTEvXJuCP67AE=;
 b=WoFmAHaH3JWspcj6nCJKtoGovdGrKanwan/9YRyjr3K2y5v37yEqVmPPdL7Fv/FUL0
 Jvytz6WpVSD4Gbz9n3MGlDq5VjDFOqeGwyRIOrEDaoj/RYgRz62xhYyPJ6xCl6BlcDe0
 g25D5MYgZdxo3n+MzONqIDZXeVCfiOGCRW69Jq6cNwUGEQYiCkXtsiJ7NJFPYSivou6O
 dc8oKIwCksQTAOTEpvLQPv4lLHTO3zewC9Hhf3zfi9S9MDWsOe8Q+r82G4u6fDEdnPqG
 FBOhlIX2CsM+YEEulfsI/CubnjazS2EMZGmJxMpL8sB9Mx23jBy8N6LjTq3/JO+1XTFU
 NrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721139924; x=1721744724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJZP3LZ+KWoPWknTNVhOdoikvYryt7LTEvXJuCP67AE=;
 b=Vr/S0GS3xBZHjPsJl4Nodz+SpDEl8d7gYEsc8CRuqyNKcp7UfiiekjT/lbnJuq8Igs
 w2zpXyyngWNbSFvka6GWgx66RW/80fXeJfq7ceOVAgCWrLQqpiFUdbhbnvvD1Luk1Fw4
 xBMtPVQBeH6KzaqrBSnmnPjnE9UDs1lWMCyWx5C09N87qy1rm7RN/Aci4DmOIaXkVxH8
 kRzJ+QwVrZFeDFtwFRrzDQw6zsDfpsoOxZuLoZvwnb3WtFP5lIzZnFMNyhlxMUmTKrcM
 Yoa748Q63RZx2oXKPY4b6PbJLIrNoo1SWGu5cdcLBekNMwwuFg/wxy6jMYlEFQuPCmno
 OSBA==
X-Gm-Message-State: AOJu0YwdYVcym8hiMrC2XpwyGIKHHLgJdm2e40Cpp6u+QaiGgq1LTuwk
 UilqYz1zLS4ELyWnn1ZEx3n1+nvLCYT4eF47Okz4/W5sNRhNK1Tp/qfRfW+QKriOFCjGr7sq2nY
 Gw/LFa6kEpy+fE86Bo4mStsEwInM=
X-Google-Smtp-Source: AGHT+IHpQBLFuY5aTiSYZ/J7boF9dpY4vZARlKf3jvtguUPepn+PVPp5IHgustyWyyQSa+Ire8R/JOkP9nZxLpgXyf0=
X-Received: by 2002:a05:6214:2462:b0:6b5:2bfa:edd5 with SMTP id
 6a1803df08f44-6b780fd9829mr34079506d6.17.1721139924423; Tue, 16 Jul 2024
 07:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240715193555.564528-1-trini@konsulko.com>
In-Reply-To: <20240715193555.564528-1-trini@konsulko.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 16 Jul 2024 09:24:57 -0500
Message-ID: <CAOCHtYjMyRksaLNUYv9kYJ9qVhcu+=9XBgc6us8bkCDp=JCiRw@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm: Remove omap4_panda board
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Vagrant Cascadian <vagrant@debian.org>
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

On Mon, Jul 15, 2024 at 2:36=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> This board has not been converted to CONFIG_DM_I2C by the deadline.
> Remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Robert Nelson <robertcnelson@gmail.com>

It has to be done, has not been converted, if any active real users
want to bring this back, it can be reverted.

This was also a fun board, as not every hardware revision had a
matching ID change, and ES changed to incompatible memory mid cycle..
Watching from a fair we learned a lot for future Beagle's..

Looking at the remaining armhf distros:

Buildroot; 2021.04
Arch Linux; 2017.07-1
Debian; 2024.01

CC'ing Vagrant Debian's u-boot maintainer..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
