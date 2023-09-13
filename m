Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE5CEE0200
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 18:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD980869A0;
	Wed, 13 Sep 2023 20:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LPDwZay9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1491086487; Wed, 13 Sep 2023 20:43:08 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333788692B
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 20:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bfb1167277so1837981fa.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694630583; x=1695235383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAgQ99QW9WXKU1b9Q5SoVNEgXIR363NXT7Ic79/Pysk=;
 b=LPDwZay9dNcojQ5s9aODmP93sLSAxBWkOP5sF9Ce4OB1TRco0VRBmgvedyT5mCAdm+
 yuj6QNrzUN1v/xiVvZUXtCuD051MHkL7tY+Rz87IQTkdeUdgVNVFabigVJj++TsU+T5c
 g/TgtkRa7py0fowAYUgRqIWMLF3U553N5tI05qO8S8EJ+y8AIeCsBuBKoBh0eh7vrm29
 HoDaLQAGZNBX3BdpB1WHZXdZTxARxxhjd+2QVFJ4BvP2fN4YmJTPxx8le6t8SaNHqmtJ
 8nqQKPDUvUs3ZgzkdPnI9j5+DKKT0/y+dVVAc+rYTAE1o1LIHzqPki3SrFy5OUZLhxtN
 UcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694630583; x=1695235383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZAgQ99QW9WXKU1b9Q5SoVNEgXIR363NXT7Ic79/Pysk=;
 b=wBLLyImSPCE6CWPLLa7EYChf9TH8sn3+Imwzqxm+M7ebxqio0Hvzqp5uJU0yJP8tG8
 g7Lq8+OeUOhICSftUrkSwaLpb3BH3JAX6E8HKmQ0iyauEmpnmcXaKHnEnXjrAoKMiAAn
 9nO7dhWna3KAtwIjpJ6+sjyW8LcP8YFQvq/tEAgF1bZJLwbOW00pHUB17HNy8SSo603/
 aXcbHEKxqP1llxaOaTWWJgTBRWRDO69RxYaUlQfXXovE/YWcIOipQzwkiy2z0K+aaVgv
 ZsEaXx2RqTgamN80OvpVKol1j/ayWgGOFfEASRJNz49gbwvStRGHj2kRPkSncOrjDhKX
 I+SQ==
X-Gm-Message-State: AOJu0Yxo3tPuosIU1KDL03IXV292K98oPsVDYciuPBRxRnNyYAfpSxCc
 U0ZwYjVZz+mZwsToylsNSJTxZLcmIHvdFXSjBQOb4QVmqmE=
X-Google-Smtp-Source: AGHT+IG6tMUBdQ19XOperqsHNZxQUB23cnt/t525/X5vwq9dnFEAR/tFhutiSacoXjn1ZKyDeY/fskqdL4/erh7C4fU=
X-Received: by 2002:a2e:998b:0:b0:2b6:cb55:72bc with SMTP id
 w11-20020a2e998b000000b002b6cb5572bcmr3370680lji.1.1694630583024; Wed, 13 Sep
 2023 11:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230831024951.22599-1-twoerner@gmail.com>
 <20230831101511.GD8826@kitsune.suse.cz>
 <CAHUNapQxb=5sr3FPscBht_SAYh4++yvbMscwEnmQRJhw1TdO1g@mail.gmail.com>
 <20230913183252.GO305624@bill-the-cat>
In-Reply-To: <20230913183252.GO305624@bill-the-cat>
From: Trevor Woerner <twoerner@gmail.com>
Date: Wed, 13 Sep 2023 14:42:50 -0400
Message-ID: <CAHUNapSmNZj0KjLjYGGE7OJLdHM72S402GZ9ZJzu7o=uOY1x3Q@mail.gmail.com>
Subject: Re: [PATCH] am33xx: ignore return value from usb_ether_init()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, Sep 13, 2023 at 2:32=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Wed, Sep 13, 2023 at 08:50:49AM -0400, Trevor Woerner wrote:
>
> > Can this get added to the next release? I don't see it in -next.
>
> I was going to pick this up for v2024.01 (i.e. the next branch)
> soon'ish.
>

Awesome, thanks! :-)
