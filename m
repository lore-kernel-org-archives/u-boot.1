Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE42FC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 14:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C9A889D9;
	Tue, 16 Jul 2024 16:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCUa7qPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24685889D9; Tue, 16 Jul 2024 16:20:42 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB13889A2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-79f323f084eso371602685a.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721139638; x=1721744438; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKNdAxSy2fDPzVNfUcE4qv5oE5KsDK4GSeJvo6e1byc=;
 b=CCUa7qPvo83ZIedUUbmP5WBV8Yhktn5xu2nUspKiCAN+oM1y4SVu2hE8RhXZEIqvrT
 0zDZja6bCgM7AknENgo2kHG2YN1TQdIX3GljGLW5EiWuHqzOluU7a5Wubbg1jpQMfeDP
 NWLJ7WgHY+SGbOvTsz75LWlbIIMZQhS/L1aiQXPeAFRKdQpM9LNAVCCgpsLHknnqUZr4
 +pnyvHsSDRMLGK2I/dKjRIx/b5DuuLrZhUZFnLyzcue+TmbJ5hpeED8HRIWrMPVgygH3
 x20GVy3+ghz2dAAdztF9Mb47xBU8S6gszQMn8561Eh/L4SrLmuqYKVBz8UmXkk0lBSNP
 xC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721139638; x=1721744438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKNdAxSy2fDPzVNfUcE4qv5oE5KsDK4GSeJvo6e1byc=;
 b=kXTYfkv2LjNZozqfpcKmHnymQ6na7PgHzLlK7lrNb3MsGbfAUIAz+vsr2VRVmZqDdg
 8MSE6Q11By7b4FYpQODyA+i4t7Z1+c6rFEC+mJdbGTv35pzKw0FztmW9H0l6n2ShHmzE
 tRIw55ZoNjbZAH5k9yVs94ofl6pb8O71Rn3nLDMMbyp2xWFiZU8KkoN/l8/iv0X9STqr
 PbY40E9Xd/4CqmMtsbfOUL5JB2VTw7f8UhWzopRSLfGC3ImDMKYFEiQkUB4vwMMQDf2z
 DbSVw+us+VKvgY10QTcG7kWHsrGmy3O5OQ/E5o23FncNwfYhWaZW0uIkxpi6s3TIXORn
 BXkw==
X-Gm-Message-State: AOJu0YwFhk8ok/2xgDxAm6EEQw9GFLE/BR4jrb2XddlTp+wvJCRxQodg
 S/Wgn6IcuO6YZ+hNkHATHUPMDjwikPVjvOGfxJaRV9nJV+ABlOdw+NGg8ZbLu5GR+8Moe5Sixui
 HlcoEv1wRvJrGzDA+DT6PL9Ox+bts43VR
X-Google-Smtp-Source: AGHT+IF/p6Zl+uwSOeEk+mZd8MKKor3AblXZR284tYjx7DwjQ31jf4mm9A85WEkCz04f+r0p+J4qchEkhlmJJC3koPQ=
X-Received: by 2002:ad4:5763:0:b0:6b5:dca9:6748 with SMTP id
 6a1803df08f44-6b77f511161mr28177846d6.26.1721139638444; Tue, 16 Jul 2024
 07:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240715193555.564528-1-trini@konsulko.com>
 <20240715193555.564528-5-trini@konsulko.com>
In-Reply-To: <20240715193555.564528-5-trini@konsulko.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 16 Jul 2024 09:20:12 -0500
Message-ID: <CAOCHtYj8rd7Q+7J5Ziv7AHwK11DMqS3BaiJfnXP8oq+WXZr4bg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm: Remove omap3_beagle board
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

Looking at the remaining armhf distros:

Buildroot; not in git tree
Arch Linux; 2016.11-1
Debian; 2024.01

CC'ing Vagrant Debian's u-boot maintainer..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
