Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FE7CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 02:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D9788D25;
	Fri, 30 Aug 2024 04:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FePbdZKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E68B1889B4; Fri, 30 Aug 2024 04:29:04 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B40188D3A
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 04:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f50f1d864fso14445011fa.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724984942; x=1725589742; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CT/3lQ42Z0LD8XL97GasMRoJPNcHNoFnLXUDLWzadk=;
 b=FePbdZKlixfi1tLDROhdNlADsxOjKCOUeBwC/xevToFISlHm1xC74fsRRkvLfdk810
 mckF9IdRkPLUy6x4/33hEzikqgyhADrcmn14Whh3Q2wI/et+68zyudZS7ftLe/qWawAX
 WSAm/2JCXbQnZDvz7V/C/zw+wTFVGBlnhElHEgwOyx1j83koQ7o8YEGyMFEEwk6mXySs
 srC2fD94GNxutW4fFhsYzlOZy5yHjDugcZzn29DW4z/eWWLxS64t1oBM2yUDIgOCAKwL
 JfZWcfsbTUc6/7vZRNLdiE5dtTSL4FSZNSt1bKSPKvZwajxwXyt9+9vvIvH7fQ+Bhtmf
 nAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724984942; x=1725589742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CT/3lQ42Z0LD8XL97GasMRoJPNcHNoFnLXUDLWzadk=;
 b=r5ltS+atctf0tVsuvO/3mw3JjWwtWZpaCstFnm76BUfEePCXgPf5C6X7fKY2l3BkLX
 wW/zUXIuLRuIMDgTu4X96CGzzu8AdU3prImh/JvO1CNmNxS/gxURBnL5HldakzGTcOSX
 H+1dvCaHMKKhLfXHPkQMWPTQdF98GSuKMVMiC8CzrjdUY1omLuV6D3c1lT52zFlm5OJW
 h4FgEK/cR7xXtoZIu/IATkJuhAUBnoH9pHVoeWlVmSfR2kykzfdwECa7DZJkIXntqSGp
 LaB/arPGvetQcSpTfUF1ZUBSRvkZ/xT9eZhh2jjCgy2zqSYEZpG694kvt4cNxbVo0uY7
 DElg==
X-Gm-Message-State: AOJu0Yxxl7lLfWcNDFFww62QWQHHQRazncvWYVf5gKthGm8BDjgyLeLI
 gepmKA/5cGxZ1pRJlMhpYbKv9L9hwm/xXdwpfXfiZJQnISB3X3l+8ES/pDoM12/EEv86ThEFQnh
 yV+CBaEDpt/JYFWudOUnDRipJYFE=
X-Google-Smtp-Source: AGHT+IEpx+nxp8k/zVJ1dg323CyK7NbDnAwW91bzn2voR+4bBTKXrOsmAm4xWvoCyceZ5JIBOICdKH/AR9uuW4nYsdc=
X-Received: by 2002:a2e:e19:0:b0:2f3:e2f0:f79 with SMTP id
 38308e7fff4ca-2f6105510e9mr27237591fa.38.1724984941177; 
 Thu, 29 Aug 2024 19:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240726120721.150484-1-fido_max@inbox.ru>
 <CANV2PTMxAOrVDGrD-QJWJjdJ=+1NV-9SNcbBZTsfMuDhqiJR=Q@mail.gmail.com>
 <049ecd76-8dc0-4506-9355-5f6e7ae94392@inbox.ru>
In-Reply-To: <049ecd76-8dc0-4506-9355-5f6e7ae94392@inbox.ru>
From: E Shattow <lucent@gmail.com>
Date: Thu, 29 Aug 2024 19:28:50 -0700
Message-ID: <CANV2PTO=5-rQ0kkMpRT1vaCG9L6rAdqJdQOw1nJocFk0LAA0+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: define find_{first,
 next}_zero_bit in asm/bitops.h
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: u-boot@lists.denx.de, rick@andestech.com, ycliang@andestech.com, 
 trini@konsulko.com
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

Series https://patchwork.ozlabs.org/project/uboot/list/?series=3D421417
Add Starfive JH7110 Cadence USB driver fails to compile anymore
without this patch.

With that,

Tested-by: E Shattow <lucent@gmail.com

On Sun, Jul 28, 2024 at 10:47=E2=80=AFPM Maxim Kochetkov <fido_max@inbox.ru=
> wrote:
>
> 27.07.2024 13:35, E Shattow wrote:
> > Is this a problem in Linux upstream? or specific to U-Boot, and is it
> > a regression?
> >
> > refrerence https://lore.kernel.org/u-boot/20240504183354.GL2568172@bill=
-the-cat/
> > and reference https://lore.kernel.org/u-boot/BJXPR01MB0855813DD38EF86CC=
A6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn/
> >
>
> It is very similar. But it comes from
>
> In file included from
> /home/maximus/git/yadro/ymp-build/u-boot/include/linux/usb/composite.h:26=
,
>                   from
> /home/maximus/git/yadro/ymp-build/u-boot/include/g_dnl.h:12,
>                   from
> /home/maximus/git/yadro/ymp-build/u-boot/cmd/fastboot.c:12:
> /home/maximus/git/yadro/ymp-build/u-boot/include/linux/bitmap.h: In
> function =E2=80=98bitmap_find_next_zero_area=E2=80=99:
> /home/maximus/git/yadro/ymp-build/u-boot/include/linux/bitmap.h:170:17:
> error: implicit declaration of function =E2=80=98find_next_zero_bit=E2=80=
=99; did you
> mean =E2=80=98find_next_bit=E2=80=99? [-Wimplicit-function-declaration]
>    170 |         index =3D find_next_zero_bit(map, size, start);
>        |                 ^~~~~~~~~~~~~~~~~~
>        |                 find_next_bit
>
> I've just tried v2024.07 and master.
>
> I tried to drop #include <linux/bitmap.h> from composite.h, but it fails
> on usb gadget compilation:
>
>    CC      drivers/usb/gadget/g_dnl.o
> In file included from
> /home/maximus/git/yadro/ymp-build/u-boot/drivers/usb/gadget/g_dnl.c:24:
> /home/maximus/git/yadro/ymp-build/u-boot/drivers/usb/gadget/composite.c:
> In function =E2=80=98reset_config=E2=80=99:
> /home/maximus/git/yadro/ymp-build/u-boot/drivers/usb/gadget/composite.c:3=
62:17:
> error: implicit declaration of function =E2=80=98bitmap_zero=E2=80=99
> [-Wimplicit-function-declaration]
>    362 |                 bitmap_zero(f->endpoints, 32);
>        |                 ^~~~~~~~~~~
>
>
>
>
