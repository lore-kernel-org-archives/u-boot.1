Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FE3E81BC1
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 13:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0DDB839A5;
	Mon,  9 Feb 2026 14:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PyR8KrVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02D1883BC9; Mon,  9 Feb 2026 08:57:33 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01B48397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 08:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-948a2d37896so1555560241.0
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 23:57:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770623849; cv=none;
 d=google.com; s=arc-20240605;
 b=O88QzMYfi9rYQR/ZvBRMqOWm/i17naDV0UFyhbL/3pdqb3n+PjGyg0Fybtl3bXa04B
 Z16X4xscGLndaUCkq94uoyjI9jwzphKQSu6SsPXU7RaJ+wLdSOfkL/0Zk/dR3nN7Acbn
 Bctszi+Y5p/S+n13MxrCzOqOg9wNGu3/XRzBZdhliU6f+3RVn2kkWLziyV+fpAz+heZ/
 iBeJNI2G+0QD4TLpnFAkjb1WlSJhdytOgjmumJEKkm0xer2oXYbynTRiocdfTSxRXsaY
 q4gagBW7nkJVYuhBiqTvkqkNQUQp3K5BgprdCJIZCr7bvD2MRjaLECc6JBMePgUpTZYv
 2LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KAWBw6KCWjR47xVfWJV+yEh/ohbr2h6pnAz6KtJL5Ok=;
 fh=Or07DxhQ23weLS99TN4unRaPKIuhbjdNR818GhRG3ao=;
 b=A+5bTd+kvQAhPBIRftBPbPsIqNvE7i6HiVJXCX1GaGmowjwxDULeS0AAY/wo9CgWr4
 LG85kill7b/urDDExZdDiWj6eQllpq29pOY9KLnvjn+MFCd1PHHY4JYwdrNtaXHzfIYL
 SnpnrjwpbFY/G/2sLRwXjjbTccLWW1ylvjR7Za7IQzhIqz9V6td2ANBHEN2GgCeTywvw
 t1UplvKgo2LfEISCbbBxNCVIjCgFJB4r6nKl0+wxn6ga0UNVKUAJYPiecP3BIw/1zADN
 57s2qaq+3G2IfvQxHfutjeX/9dpurbI+y+bMoQq4Z1BqifHN7VWzTs2wt83z0PA4KbvP
 QM6g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770623849; x=1771228649; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAWBw6KCWjR47xVfWJV+yEh/ohbr2h6pnAz6KtJL5Ok=;
 b=PyR8KrVklYsuFaSNA782dyvAHbpCt4wZpPaQcbw4wKowCdNmYIyEU6Ak44Xz+KKNr/
 MtSpB86H7l++XKxaU3q42zPaoKYoK/BJdpFI5zRWzta2MBcWq6RJbHhY0VYt+meKoQtm
 NZR3JAFj1Nj8YLCz7XEPz5KHIH0yPlQtcKfwYok27Wcrth5ZOjNXxqZSj4ghj0lG5RFF
 JERQfvRuuZRe5xf92spMTfEX0wQxxBuE98pZH4R4K/hZJO/T+hb71Fk67VHhS8viHQNo
 ynFYpIuITd9Lvgct7agxNaRWG2WsZGOEIBsPx7IQtwsPeZhPecVJfVvhEZjyBkzqylAg
 kFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770623849; x=1771228649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KAWBw6KCWjR47xVfWJV+yEh/ohbr2h6pnAz6KtJL5Ok=;
 b=lDv20W38qcYSXPJwmEN2EyY1gie8IevmKOiOduh95iNLGhY8MIKBWPdOA3cnMuUaxh
 ObT7aoc9SHL2DnptigqzNjYUhSugRGvJMi8u0uPcvrXFjGTv630LEPqSY4vHuQLWoCDs
 k6RatXaKLnauSyAfPIkawGuxN0kx+rOrgeoYlicSiQxufvUPXTKCW/mkF9uuIowd7U4y
 6Zf4sDVjXP+KmzyLovHn16gmP26zblmsMRh/MSgPqVOCf9IZpC58Eum812sKFHSHGFSv
 K1kophCSsro3QSAJ1Ei209XL449Te4VmVTiFfodSyKyrHU26oaUiQMhxOXx/hrU70KaL
 vPhA==
X-Gm-Message-State: AOJu0YzSwrD2N/ra9NMk/RfarLgqh3FvHV6EYosHOvIB+7YNPI3nHne5
 izrYThnxwYk7lLVO4cq/CkOVlNA72ZR3MASYJhKRYcLTTQYIkSGTVah1nRS1xa1/BfpSYmF3lYo
 KAtPuZ3QbwQzwmZd95BFgGOBtY6nq+yc=
X-Gm-Gg: AZuq6aLA3ed4M5pCsSHJR+7I7SbMftkZGQiD5KRtHkcXQX5E2VeV8rSeB9NACaQswpe
 +nvM1PZnZUbmADw18VyUztx6RqUVw8Z6cfn7ozIT3wneXn23nHHOd/e/8biFiN4EuUBMrSsZCmF
 RXnK3/NjiK2T2iMRkvq0J2x9V4JBsaSkvRMPH4mDJuYYN3sADvEqLJioK/Pf7Q5IQprZDs9rfCG
 iduzth3jWWVoZywKvJ+VEmXprwC0IMRObjj3gbg9G+1Eds5PfVMxkdCygD2S4rZRr4UetfnbqTl
 /c7HLgB2yDatV+DAt91pyfqqD78ONNPMHD6f+ovxMSq4ynl8IdB381up
X-Received: by 2002:a05:6102:1629:b0:5f5:3619:8bd1 with SMTP id
 ada2fe7eead31-5fae8befdeemr3061778137.25.1770623849304; Sun, 08 Feb 2026
 23:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20260208223715.3721340-1-james.hilliard1@gmail.com>
 <d462a246-86ce-42d2-befa-d1b93b74e99a@mailbox.org>
In-Reply-To: <d462a246-86ce-42d2-befa-d1b93b74e99a@mailbox.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 9 Feb 2026 00:57:18 -0700
X-Gm-Features: AZwV_QijK3sFbQvFwwuLYz3U7ArMS5GJLSjpiF3KuizW9UZCXdOy9li-vWD5VQc
Message-ID: <CADvTj4qZoDVV-7PQorFk9vmMaLzxYTsyoqnjcO3JYRaPLLM6=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] image: fit: Apply overlays on a writable FDT copy
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Feb 2026 14:27:24 +0100
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

On Sun, Feb 8, 2026 at 4:19=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.org=
> wrote:
>
> On 2/8/26 11:37 PM, James Hilliard wrote:
> > boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
> > before applying overlays. That uses the bootm memory map and can
> > overlap with the FIT buffer when the FIT is loaded into RAM, corrupting
> > data needed to load the kernel and ramdisk.
> >
> > Allocate a writable copy of the base FDT with memalign() and
> > fdt_open_into(), grow it as needed for each overlay, and apply the
> > overlays to this buffer. Also check fdt_pack() errors and free the
> > temporary overlay copy after each application.
> >
> > Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT node")
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> This code is starting to be super-convoluted. Can you please have a look
> at [1] and see if that can be somehow extended to cover this ? I think
> it should trim the complexity, but it likely needs a bit more work.

Hmm, that kinda looks like it's solving a different issue? At least I'm
not really seeing an obvious way an alignment refactor like that
would help with this issue with a bad relocation corrupting the FIT
buffer.

I agree the code here is a bit convoluted, so maybe I'm missing the
relation between the fdt alignment and the relocation location issues.

>
> Thank you
>
> [1]
> https://lore.kernel.org/u-boot/9e498de5-d114-485e-840e-1395e153edc3@mailb=
ox.org/
>
