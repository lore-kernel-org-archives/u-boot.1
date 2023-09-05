Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E89BCA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 842088695F;
	Tue,  5 Sep 2023 20:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X+Z/lnJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF753865F4; Tue,  5 Sep 2023 20:16:39 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D8786989
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-500a398cda5so4887542e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693937796; x=1694542596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IIWowElZvP931yVoPv9EpujdqmkDVHpmsB0szY5db1k=;
 b=X+Z/lnJUo2u0ZNfs8bySQY2uiCvAgzMKgHAM1VZGg6yj/fy8X0yijFZm5RzNaSzUTS
 ouxiNj6aUiAcnRFoBX6P4uGZ0+Hk0ONaRsa0Y6YO9BRew9Bgb8biSEIBv8SHqO7P2KFr
 28JMf9ntmYrg0NIhElC3OfUfJjj9TLmIde+DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693937796; x=1694542596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IIWowElZvP931yVoPv9EpujdqmkDVHpmsB0szY5db1k=;
 b=Li4H+NRPJux0mZB1OksgSNH2/prahgOOia2N9jRVmjgFLID2Jq5yw1ivevRLtz1bkL
 2PJMrChSR1cXuVj/Pn8vRN8R4Wm9Y7GSbt1sIVBj/t/QdUThahPVpjzhqdOx9DKA0wEe
 8Ycn2JClMxI38ZEfzMOvNJScItY/D68DU3pYhr9a2SA9pADGNnD4ccDILMchpZA1PFHl
 ZBPu8KjS1bhjkfA2LP9oSO00kQJm/Egs4aJVXUvwwAdwb5rEnupow4FvBOk+e3hUE5OC
 Zmzfg+e4seiIWkdXV0uO7B8NT3hm7xfggQwFgHDAaowhyMoT0KiTLNQfbunOEtGPliQX
 E1DQ==
X-Gm-Message-State: AOJu0YxNIOLc4Ce7JB1KkeuuKEX/C8RxfSeBpFBQoj2tiFVbs/9RDzTx
 AmWTpfVzOy3owKAx4xd+Vrz8OFQtQjntjqX2o9zqYQ==
X-Google-Smtp-Source: AGHT+IGNCffm7tuJhH7lT01Z+2WI9I8iWSq0zMCBonNYDd5Af/fxKneNV1bB4uayktF9bLGpwhlnCSrpYOhu13S9DQw=
X-Received: by 2002:ac2:4e82:0:b0:500:92f1:c341 with SMTP id
 o2-20020ac24e82000000b0050092f1c341mr443058lfr.54.1693937795762; Tue, 05 Sep
 2023 11:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
 <c2b9e22b-e55a-03d3-1bac-f7801a8d60c4@kwiboo.se>
In-Reply-To: <c2b9e22b-e55a-03d3-1bac-f7801a8d60c4@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Sep 2023 12:16:19 -0600
Message-ID: <CAPnjgZ0isSOEBnPi4NWHwx=pm244kkYcavSMZAfrMa0wNDirwQ@mail.gmail.com>
Subject: Re: Binman how to build using Rockchip BL32 binary as OP-TEE
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On Mon, 4 Sept 2023 at 10:52, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Massimo,
>
> On 2023-09-04 17:05, Massimo Pegorer wrote:
> > Hi,
> >
> > Is there any way for binman to package FIT with U-Boot TF-A and
> > OP-TEE, using bl32 binary provided by Rockchip as TEE?
> >
> > I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
> > binman failed.
> >
> > In my poor understanding of Python code, it seems binman accepts only
> > ELF format or a binary format starting with optee_v1_header, but
> > binaries provided by Rockchip in rkbin repository do not have this
> > header.
>
> One way that I have used/tested before was to create a tee.elf version
> using something like:
>
> $ aarch64-linux-gnu-objcopy -B aarch64 -I binary -O elf64-littleaarch64
xxx_bl32_vX.YZ.bin bl32.o
> $ aarch64-linux-gnu-ld bl32.o -T tee.ld -o tee.elf
>
> tee.ld:
> ----
> ENTRY(_binary_bl32_bin_start);
>
> SECTIONS
> {
>         . = 0x08400000;
>         .data : {
>                 *(.data)
>         }
> }
> ----
>
> And then make with TEE=tee.elf, however keep in mind that U-Boot may not
> treat the memory region used by OP-TEE properly for aarch64.
>
> Regards,
> Jonas
>
> >
> > Thanks in advance for any hints!

Should we do something to support a 'flat' binary in the tee-os entry type?
For example, we could allow it if so long as a fixed load address is
provided? It might be a bit of a hack though.

Regards,
Simon
