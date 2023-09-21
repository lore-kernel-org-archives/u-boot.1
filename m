Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4663EE71093
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 16:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3725886484;
	Thu, 21 Sep 2023 18:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iCO7fMJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452AB8655E; Thu, 21 Sep 2023 18:22:50 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 038598644E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 18:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A0209B82133
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52835C611A4
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695313366;
 bh=J2f+cwahFBnNEGQSYdkxvMqfUGAXiM6UkpUW81SmvO0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=iCO7fMJO60YPCmp5Qo37cX8FdCzT1dATrExXoBa2VXvzIhVpVd+zVfFyFoVCSQQYj
 DmpdxMRo2Z28ZSzIW039LvEl1rOQxTGI/FzIOc3YKtRX1x/x32yX7jTcXmoHBm5Jxx
 JdlMXE0M/7Hv/j477ZAvolapCCMdAwBFBeDS3sq6m3jnoq5+xSJ4uv0nb6AnE0z7bn
 a4SAAnRqhQELtAv6wfWEtkTLLw+FnlbBP0gpUmt7wh4mMZsf3c4WHzkdrnvzlj7aUT
 22KNwW1Y2ogpS40FzR/YSKI53Z/2hVCmtSCjWfnj/hUA9sel4cIz0CclgptqerTyDT
 3j/y/npAR62Kw==
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-3adf06730c4so740684b6e.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 09:22:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YxYmvAmXZpcT2b9CUnQlUFmZlRKOOLV5RktYiMhHXIpfmZBbDwG
 wGfCgHUqHjI21wxmn6KkIn7Zg75v+PNdUzZPlCc=
X-Google-Smtp-Source: AGHT+IFAW72229lsy41NDIncsO6RDtdNdBNVIezUaJuVyiAFi0+bNfMoQN4VaJ2yCLXl/dO6J8Dp+kFI1OMlQmRKxqk=
X-Received: by 2002:a05:6871:20b:b0:1d6:564d:cfbd with SMTP id
 t11-20020a056871020b00b001d6564dcfbdmr7063347oad.14.1695313365692; Thu, 21
 Sep 2023 09:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
In-Reply-To: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Sep 2023 01:22:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKucgcJViKGts4GmwUxNZ2Wi-rpEqst4=ueBj66-QTeg@mail.gmail.com>
Message-ID: <CAK7LNAQKucgcJViKGts4GmwUxNZ2Wi-rpEqst4=ueBj66-QTeg@mail.gmail.com>
Subject: Re: Question about boot failure of AM64-SK
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>, srk@ti.com, s-vadapalli@ti.com,
 n-francis@ti.com, m-chawdhry@ti.com
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

On Fri, Sep 22, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Hi.
>
> I am seeing a boot failure on AM64-SK.
>
>
> I got the following error in SPL of the main core.
> Do you have any clue?



As a side-topic, I downloaded a prebuilt image
from https://www.ti.com/tool/SK-AM64

It failed too (but in a different way).

I flashed tisdk-debian-bookworm-am64xx-evm.wic
to a SD card by using the 'dd' command, then I got this:



U-Boot SPL 2023.04 (Jul 14 2023 - 08:10:06 +0000)
EEPROM not available at 0x50, trying to read at 0x51
k3_system_controller sysctrler: k3_sysctrler_start: Boot Notification
response failed. ret =3D -110
Firmware init failed on rproc (-110)

resetting ...
ti_sci system-controller@44043000: ti_sci_get_response: Message
receive failed. ret =3D -110
ti_sci system-controller@44043000: ti_sci_get_response: Message
receive failed. ret =3D -110
ti_sci system-controller@44043000: ti_sci_get_response: Message
receive failed. ret =3D -110
no sysreset
### ERROR ### Please RESET the board ###




Am I doing something wrong?






--=20
Best Regards
Masahiro Yamada
