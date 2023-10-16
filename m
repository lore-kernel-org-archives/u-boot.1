Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492C7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 13:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE8E865A2;
	Mon, 16 Oct 2023 15:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFYnC+ib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A401A86B79; Mon, 16 Oct 2023 15:01:03 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 140E686335
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9ba72f6a1so9162465ad.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697461255; x=1698066055; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0OpOMZtFxIoXIxyiC6ioIAuyV8jN+uajZSUtPM/yPM=;
 b=kFYnC+ibCoXpHqo0y9qJZImZoyFPuM5p4aSC8N66WDAjYzzrv5F4zTMh69jd1APZNd
 rEzBvKfyw3TlWYQTXkRXK+G1zM/LkZqiBsP8+zOGsxMwpMwPRKI4X2oRQn6C124r2ImS
 GmDyZhb/aIaz+TbiSVBveElascEc/P5W56BJz075O5bqLJE/Pt8CcGBQ0mjxjMlETUc9
 sr5x7Ka8rcDvEj7jQkNJku6dgY7l7KRl2yjn4cuKS/fc80KcrlquPa0AYBfPROLGH4lJ
 6d9gAHKNmtT6u1QBoU0/7hOAHkM+M59JtjRCCBZ9USTiWKWyE1fKPeV0gW4JuOyUC+MN
 c3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697461255; x=1698066055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0OpOMZtFxIoXIxyiC6ioIAuyV8jN+uajZSUtPM/yPM=;
 b=VC6pZl5VzHaaLwaM+Q8h+GiL4aZRd5vvZQ59s9TxFc2VT9AZ8zsUX0anw9IEL00hUf
 5yCo9TSONfO5POPAEXreUn0fvuTQ2oe84EmF94ISxHARUjXvc5Q85ALQkiltKcJMNkSR
 8yU/u+jjLNI+dfpwTZB8r1OG7zKUJyLT9grrRxk3xsUTtnWPtwUceUmTgkZzvrZRO+Q2
 FHcCKuwO4//Mam1xDUEnv4i+vKPCJMTR0PiuqNaFzs2sXafslpj8BGQbP6deckXhugpk
 m4gTEoXu68+d2s9aurTEP0qSy7cgOeGXS0t6qjUa7+CPfvIyXPavgu29YVMIOZq4IyEN
 gm5A==
X-Gm-Message-State: AOJu0Yyw7Fqy/acU2jWZ4WVREZXTzhnOsCQmBtJlieZChKm3uOHYl+/5
 wbNLvbCTbMbfCxuV5KnbCzKCaSi/9viLUMazXZ4=
X-Google-Smtp-Source: AGHT+IFgQXXzvhgqyjWIOSXKsTl11qj1GJO0QPXUP2lCV16Ajk2ZFi9mP8DmEFduW5/SzdL8cUQImSnmRfUN6BRHCUE=
X-Received: by 2002:a17:90b:17c3:b0:27c:f653:37b2 with SMTP id
 me3-20020a17090b17c300b0027cf65337b2mr16190300pjb.1.1697461255107; Mon, 16
 Oct 2023 06:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJeqHvL8xNKOZ=WD3PVjQVGz_S-EU3qDRCV1LwY4auOWxTq1dQ@mail.gmail.com>
In-Reply-To: <CAJeqHvL8xNKOZ=WD3PVjQVGz_S-EU3qDRCV1LwY4auOWxTq1dQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Oct 2023 10:00:43 -0300
Message-ID: <CAOMZO5BmGMUJq1m=eq_7ckDDx2FSg7LtU8bC6BE_fFc88MJZSA@mail.gmail.com>
Subject: Re: failed to build u-boot mt7621_rfb_defconfig
To: Xiaobo Liu <cppcoffee@gmail.com>
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

Hi Xiaobo,

On Mon, Oct 16, 2023 at 8:49=E2=80=AFAM Xiaobo Liu <cppcoffee@gmail.com> wr=
ote:

> Image 'u-boot-spl-ddr' is missing external blobs and is non-functional:
> stage_bin
>
> /binman/u-boot-spl-ddr/stage_bin (mt7621_stage_sram.bin):
>    Missing blob
>
> Some images are invalid
> make: *** [Makefile:1115: .binman_stamp] Error 103
> ```
>
> Is there a step I'm missing that's causing this?

Yes, you need to provide mt7621_stage_sram.bin.

Please follow the instructions from doc/board/mediatek/mt7621.rst
