Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BB606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SRcCbRn+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7Y7jZU+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A1B1608A5;
	Thu, 12 Nov 2026 11:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4m_nzkrkcvqV; Thu, 12 Nov 2026 11:42:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9A21B60784
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794483753;
	b=jbOXqpYHoynv6j9OoOvnbqIxCaqU+PO9TdP/IAeEyyP1hZr4O8194W3QLsRptKNInPGq
	 zkoGYYn9s1kNPuVyPL6tM9GWqrf94DqUJZwmdjWALyx++sr7vVEHVYh6l5/SOKOzPf2Us
	 176JGhFP0M1e/iyDg/6+OK/YL7RVGMWrzujeCOKgiUGutH69YTnGtyyB1tAFuuWEUtj39
	 DEEy5JfVBaKsJHsi8VZqOuFjCTZAX1TXOlbm/9JRksTmYBsek/BrZPPTP2HfPfv7urZlL
	 lP1TH+clQBWCP+MANHyOlSkgDuDnnLiCHdBNC+Chb31IYgUPaFw07lR9W3URp3MLFew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794483753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7D554oWyq4aNLttjq+1Y0mUlJ3nKNCjCvvShJjqcPwc=;
	b=kC0knDxwPtIay5vwDDm4Wx8mWletYkxM0wH1XfWHu4YGbwVVmX147eaZLMvfGX9+DG1r
	 lnlSPGAsyIL0mMWYl/Zz+iaxCzKPMhVYUI1SBn4G2KK0E3N9fEzi/DijHqc73NAYoakI1
	 Vq+CXzm8PnDGo3y33XSDH/bNdfIhMaYFFwouhgGqIkgPuwJEwwv2aP4Kz0nVw9dttHUmu
	 boZJgOvlvI5VkgeNcr9Xw9MX4XFtyUNMupUUu5EZEsQKd/972Q/EkCTMtjf24wFQyq07A
	 H2nxYqUuB5EYe2MQ4xTrTCWg2Cpb8x0u5/OcyUYRaa6ytxmEUsnPIBEmjzIbBUnX/tg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794483753;
	bh=7D554oWyq4aNLttjq+1Y0mUlJ3nKNCjCvvShJjqcPwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SRcCbRn+vOqAN0wyjgxus/EndiJXJ6hXoT8w+X2nALLI3v1lK+XRf8oVPrzFEkbUj
	 9w8Af38t/Ty4933b1xqIo3BxiFCGMvrEZuXSWlxpx7g0VubWj0LzF0ow+BjWOSgOIy
	 NHWK1iJHYhiao5sOlLKnf6acDy1rgJMrNVBNdjQ0VoP2xV1kstrUzjJnKedVwrNcm8
	 PNC0PXrUMmDK4e3mvTNuqsBkpC4WCxbs7ZoXIWQdsIJru7eNnXCWvOtm9+IVKAG7rG
	 Gy/1rphOhH9t82gbmPZvjpZ2KTKlXrYuJJX3scvMrcaZ8sUkxnPDEegIZCGW7dsKcE
	 w2RLwslNA2JCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A21B60784;
	Thu, 12 Nov 2026 11:42:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C50A5235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA386403FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZFBQmtwi2Yv for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:42:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2B9D40042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=O7Y7jZU+
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2B9D40042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:42:30 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-91eda36322fso20173846d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794483749; x=1795088549;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7D554oWyq4aNLttjq+1Y0mUlJ3nKNCjCvvShJjqcPwc=;
 b=O7Y7jZU+sCTXH8MRqj/TI9Y8LXF2tva9XBGSOrp7dUqdMK2+Z8QylescGuKnnO5bou
 khpkTVHrzQ7xP+/hw7zCH7XSStEUJL9UCAbRpU+FjkA+//Vs+CigEmQQ4/QOp28lTDJR
 fHBKLXq30fLb56oqYORvcTh44Ng+Erw6tXO5b1h0EKc82LrD7f0EpNUXyaXCMLE2j4R4
 +I9iFdSGwpKM4Rx+IPwcJ+ftowMWuuWsifBpcv4fYYGm1gm6TXrZjk32VTc2IjfCEX05
 FcOoGRC14zWW+c8Dy7WNVxflVK5jpqEBxWRO7oS04d7bWHIYaQxIEWTTmBcmWJ5rAl6v
 7FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794483749; x=1795088549;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7D554oWyq4aNLttjq+1Y0mUlJ3nKNCjCvvShJjqcPwc=;
 b=08dLGDOkb4Ax3hnOYdgScdmk53k4grEUbxAMLSRcKdYIQoUSyH/SB/C1HyPSombZN4
 tXwhoZC6aHxG7K2Xpgg1q5BqvI7m/SOGDfAyIHlP3541YyfQH3J07h25N12YVbMMZ4Gz
 tgKPMJGH+dg3EGrfp806x75sPZeMhf5AJksHS9jfAdw0FjOHGmoWhqE2OlN1OS1H5/B3
 pPtk+V88ZlX3kxbfEKXHPmQjPFbTgLpBJUAPB1X3AUjHfkoD4I1ik0KMNYhISfWIkLqZ
 mLQjnkw2043EaM3Ek7UQ6AjWe3WMqT80NFhMaFsXpEWAh3NIdcNvH22It3PHHWtIiESt
 oBrA==
X-Forwarded-Encrypted: i=1;
 AL+hErHFCV1W690ntZxakzfxhDk0MZUMZySqrVzvv02azSMKKFgPvdXHklKnVzcF3ubmQRFoGLmz+08=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/FTnbLJN8T2qAvWH/esroV47QgC14TODQp69lAM4fWrRd6hY0j
 MBDzqAexMTlzJMPX4OgsdTC0IvmlwrLkqwGnjLZAE00SHpUPI2dSlDq7Jbe/JGNLXAlg5FQs3gT
 j+EfeRaPaCZ8LpKd0lrL30wvw9pqvPus=
X-Gm-Gg: AYBFou2acDrxO4di3a56OWtCz5AOqoltroW//O2wOFAd8i/l27dJMWuzoJDP6RMsVrE
 mrZ6VGdjgJm41ofouMGt97zvy34U7RxWQWX/RImNOBRFWpKF9BGKkWCcKQ1/6vHSaNL9VPuDQwj
 BsLUT70Iu/kL5A0SaiZie2macptSOhfZNuukmRd2zfNJXmL78FRhqm1odsrNR/UyoQt05GM13p5
 ICJZnQFgq7/I2Tt+5/tA27MeFZyeze/AvA9aAQxX9WGjCtIKyhluAjyhlCb08D/xEcdmN0FBjMQ
 l5vHrg7b+nUluyk6W1szwaVivgYp2KaM8mVjOY5VEQoJSD2vNkoBbqwJ42ucjV5wDTzA6c9UsKH
 FAF7OiYQQMmYjZi21E7x5obeBVllFZIZ/45BxIeCi9QaU8yg4fuSfl+WBk8g6ipWS7VfEQMfem1
 J/SGTzAtUw9HhuhnxbGBMJEw37HqoCor4gjV9AvlMc+OTZmEpvykw8lQcDCYePJxPaH8YQK5BkJ
 CIyd1ix4mFOgT8TZGWulXHp6KuAwUtX5OA=
X-Received: by 2002:ad4:5c83:0:b0:91e:fe5d:c977 with SMTP id
 6a1803df08f44-91f040e82e4mr91033216d6.9.1794483748869; Thu, 12 Nov 2026
 03:42:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111091728.3388905-1-pbrobinson@gmail.com>
 <20261111091728.3388905-2-pbrobinson@gmail.com>
 <3cdb390d-51fc-4a36-93ac-6f0ef0fb0648@cherry.de>
In-Reply-To: <3cdb390d-51fc-4a36-93ac-6f0ef0fb0648@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Nov 2026 11:42:17 +0000
X-Gm-Features: AclHuK-kJ32P2FYvGUbz5wpyEQWcAU_1zkMgbb-KtJRy_eXxaOd_k8tuei7Sbm0
Message-ID: <CALeDE9McuQm8xbA-=qc4Ofp2qpZdGLoXfLtajZ5nBt5LoByDMw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Update maintainers and mailmap
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000681d15066012ced3"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000681d15066012ced3
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On Wed, 11 Nov 2026 at 10:07, Quentin Schulz <quentin.schulz@cherry.de>
wrote:

> Hi Peter,
>
> On 11/11/26 10:17 AM, Peter Robinson wrote:
> > With the departure of Simon update the MAINTAINERS file
> > to reflect the current situation of various subsystems.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >   .mailmap    |  3 ++-
> >   MAINTAINERS | 32 ++++++++++++++------------------
>
> Simon is also listed in many other MAINTAINERS files:
>

You are correct, I should have had my coffee first :)


> board/bluewater/gurnard/MAINTAINERS
> board/coreboot/coreboot/MAINTAINERS
> board/efi/efi-x86_app/MAINTAINERS
> board/firefly/firefly-rk3288/MAINTAINERS
> board/google/chromebook_coral/MAINTAINERS
> board/google/chromebook_link/MAINTAINERS
> board/google/chromebook_samus/MAINTAINERS
> board/google/chromebox_panther/MAINTAINERS
> board/google/gru/MAINTAINERS
> board/google/veyron/MAINTAINERS
> board/intel/minnowmax/MAINTAINERS
> board/radxa/rock2/MAINTAINERS
> board/samsung/smdk5250/MAINTAINERS
> board/sandbox/MAINTAINERS
>
> >   2 files changed, 16 insertions(+), 19 deletions(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index dffeed3238d..5632778fbf3 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -147,7 +147,8 @@ Sean Anderson <sean.anderson@linux.dev> <
> sean.anderson@seco.com>
> >   Shaohui Xie <Shaohui.Xie@freescale.com>
> >   Shravya Kumbham <shravya.kumbham@amd.com> <shravya.kumbham@xilinx.com>
> >   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> <
> shubhrajyoti.datta@xilinx.com>
> > -Simon Glass <sjg@chromium.org> <simon.glass@canonical.com>
> > +Simon Glass <noreply@example.com> <simon.glass@canonical.com>
> > +Simon Glass <noreply@example.com> <sjg@chromium.org>
> >   Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <
> siva.durga.paladugu@xilinx.com>
> >   Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <
> sivadur@xilinx.com>
> >   Srinivas Goud <srinivas.goud@amd.com> <srinivas.goud@xilinx.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9fc6614e519..0ee3ef000a8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -63,7 +63,7 @@ F:  net/9p/
> >   F:  test/py/tests/test_9p.py
> >
> >   ACPI
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> issue: I think this here isn't right
>
> Isn't it supposed to be:
>
> S: Orphan
>
> with no M: anymore?
>

Correct


> >   F:  board/emulation/configs/acpi.config
> >   F:  cmd/acpi.c
> > @@ -77,7 +77,7 @@ S:  Maintained
> >   F:  drivers/net/phy/airoha/
> >
> >   ALIST
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Ditto.
>
> >   F:  include/alist.h
> >   F:  lib/alist.c
> > @@ -820,7 +820,6 @@ S:        Maintained
> >   F:  drivers/spi/spi-aspeed-smc.c
> >
> >   BINMAN
> > -M:   Simon Glass <sjg@chromium.org>
> >   M:  Alper Nebi Yasak <alpernebiyasak@gmail.com>
>
> I believe Alper Nebi Yasak hasn't been active for years now, so we'll
> eventually need to reflect that here too, in a different patch though.
>

Yes, there's a much winder conversation to be had here in general that is
definitely a conversation for later.


> >   S:  Maintained
> >   F:  doc/develop/binman_tests.rst
> > @@ -836,7 +835,7 @@ F:        include/blkmap.h
> >   F:  test/dm/blkmap.c
> >
> >   BOOTSTD
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   F:  boot/bootdev*.c
> >   F:  boot/bootflow.c
> > @@ -870,7 +869,7 @@ F:        fs/btrfs/
> >   F:  include/btrfs.h
> >
> >   BUILDMAN
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   F:  tools/buildman/
> >
> > @@ -901,7 +900,6 @@ F:        drivers/clk/
> >   F:  drivers/clk/imx/
> >
> >   CPU
> > -M:   Simon Glass <sjg@chromium.org>
> >   M:  Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >   S:  Maintained
> >   F:  cmd/cpu.c
> > @@ -939,7 +937,7 @@ F:        include/linux/usb/ch9.h
> >   F:  include/linux/usb/gadget.h
> >
> >   DRIVER MODEL
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   T:  git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
> >   F:  drivers/core/
> > @@ -947,7 +945,6 @@ F:        include/dm/
> >   F:  test/dm/
> >
> >   EFI CLIENT
> > -M:   Simon Glass <sjg@chromium.org>
> >   M:  Heinrich Schuchardt <xypron.glpk@gmx.de>
> >   S:  Maintained
> >   W:
> https://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_efi.html
> > @@ -1005,7 +1002,7 @@ F:      tools/env*
> >   F:  tools/mkenvimage.c
> >
> >   ENVIRONMENT AS TEXT
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   F:  doc/usage/environment.rst
> >   F:  scripts/env2string.awk
> > @@ -1020,7 +1017,7 @@ F:      include/erofs.h
> >   F:  test/py/tests/test_fs/test_erofs.py
> >
> >   EVENTS
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   F:  cmd/event.c
> >   F:  common/event.c
> > @@ -1065,7 +1062,7 @@ F:      include/fpga.h
> >   F:  test/dm/fpga.c
> >
> >   FLATTENED DEVICE TREE
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   T:  git
> https://git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git
> >   F:  lib/fdtdec*
> > @@ -1169,7 +1166,7 @@ F:      doc/kwboot.1
> >   F:  tools/kwb*
> >
> >   LOGGING
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   T:  git https://git.u-boot-project.org/u-boot/u-boot.git
> >   F:  common/log*
> > @@ -1207,7 +1204,7 @@ S:      Maintained
> >   F:  lib/mbedtls/
> >
> >   MEMBUF
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   T:  git https://git.u-boot-project.org/u-boot/u-boot.git
> >   F:  include/membuf.h
> > @@ -1398,7 +1395,7 @@ F:      configs/o4-imx6ull-nano_defconfig
> >   F:  include/configs/o4-imx6ull-nano.h
> >
> >   PATMAN
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   F:  tools/patman/
> >
> > @@ -1567,7 +1564,7 @@ F:      cmd/rockusb.c
> >   F:  doc/README.rockusb
> >
> >   SANDBOX
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   F:  arch/sandbox/
> >   F:  configs/sandbox*
> > @@ -1821,7 +1818,7 @@ F:      common/spl/spl_ufs.c
> >   F:  drivers/ufs/
> >
> >   UPL
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> >   T:  git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
> >   F:  boot/upl*
> > @@ -1870,7 +1867,7 @@ S:      Maintained
> >   F:  test/lib/uuid.c
> >
> >   VBE
> > -M:   Simon Glass <sjg@chromium.org>
> > +M:   Orphan
> >   S:  Maintained
>
> Same issue as above.
>
> Cheers,
> Quentin
>

--000000000000681d15066012ced3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Quentin,</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 11 Nov =
2026 at 10:07, Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@cherry.d=
e">quentin.schulz@cherry.de</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi Peter,<br>
<br>
On 11/11/26 10:17 AM, Peter Robinson wrote:<br>
&gt; With the departure of Simon update the MAINTAINERS file<br>
&gt; to reflect the current situation of various subsystems.<br>
&gt; <br>
&gt; Signed-off-by: Peter Robinson &lt;<a href=3D"mailto:pbrobinson@gmail.c=
om" target=3D"_blank">pbrobinson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.mailmap=C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 =C2=A0MAINTAINERS | 32 ++++++++++++++------------------<br>
<br>
Simon is also listed in many other MAINTAINERS files:<br></blockquote><div>=
<br></div><div>You are correct, I should have had my coffee first :)</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
board/bluewater/gurnard/MAINTAINERS<br>
board/coreboot/coreboot/MAINTAINERS<br>
board/efi/efi-x86_app/MAINTAINERS<br>
board/firefly/firefly-rk3288/MAINTAINERS<br>
board/google/chromebook_coral/MAINTAINERS<br>
board/google/chromebook_link/MAINTAINERS<br>
board/google/chromebook_samus/MAINTAINERS<br>
board/google/chromebox_panther/MAINTAINERS<br>
board/google/gru/MAINTAINERS<br>
board/google/veyron/MAINTAINERS<br>
board/intel/minnowmax/MAINTAINERS<br>
board/radxa/rock2/MAINTAINERS<br>
board/samsung/smdk5250/MAINTAINERS<br>
board/sandbox/MAINTAINERS<br>
<br>
&gt;=C2=A0 =C2=A02 files changed, 16 insertions(+), 19 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.mailmap b/.mailmap<br>
&gt; index dffeed3238d..5632778fbf3 100644<br>
&gt; --- a/.mailmap<br>
&gt; +++ b/.mailmap<br>
&gt; @@ -147,7 +147,8 @@ Sean Anderson &lt;<a href=3D"mailto:sean.anderson@=
linux.dev" target=3D"_blank">sean.anderson@linux.dev</a>&gt; &lt;<a href=3D=
"mailto:sean.anderson@seco.com" target=3D"_blank">sean.anderson@seco.com</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0Shaohui Xie &lt;<a href=3D"mailto:Shaohui.Xie@freescale.co=
m" target=3D"_blank">Shaohui.Xie@freescale.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0Shravya Kumbham &lt;<a href=3D"mailto:shravya.kumbham@amd.=
com" target=3D"_blank">shravya.kumbham@amd.com</a>&gt; &lt;<a href=3D"mailt=
o:shravya.kumbham@xilinx.com" target=3D"_blank">shravya.kumbham@xilinx.com<=
/a>&gt;<br>
&gt;=C2=A0 =C2=A0Shubhrajyoti Datta &lt;<a href=3D"mailto:shubhrajyoti.datt=
a@amd.com" target=3D"_blank">shubhrajyoti.datta@amd.com</a>&gt; &lt;<a href=
=3D"mailto:shubhrajyoti.datta@xilinx.com" target=3D"_blank">shubhrajyoti.da=
tta@xilinx.com</a>&gt;<br>
&gt; -Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" target=3D"_blank"=
>sjg@chromium.org</a>&gt; &lt;<a href=3D"mailto:simon.glass@canonical.com" =
target=3D"_blank">simon.glass@canonical.com</a>&gt;<br>
&gt; +Simon Glass &lt;<a href=3D"mailto:noreply@example.com" target=3D"_bla=
nk">noreply@example.com</a>&gt; &lt;<a href=3D"mailto:simon.glass@canonical=
.com" target=3D"_blank">simon.glass@canonical.com</a>&gt;<br>
&gt; +Simon Glass &lt;<a href=3D"mailto:noreply@example.com" target=3D"_bla=
nk">noreply@example.com</a>&gt; &lt;<a href=3D"mailto:sjg@chromium.org" tar=
get=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0Siva Durga Prasad Paladugu &lt;<a href=3D"mailto:siva.durg=
a.prasad.paladugu@amd.com" target=3D"_blank">siva.durga.prasad.paladugu@amd=
.com</a>&gt; &lt;<a href=3D"mailto:siva.durga.paladugu@xilinx.com" target=
=3D"_blank">siva.durga.paladugu@xilinx.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0Siva Durga Prasad Paladugu &lt;<a href=3D"mailto:siva.durg=
a.prasad.paladugu@amd.com" target=3D"_blank">siva.durga.prasad.paladugu@amd=
.com</a>&gt; &lt;<a href=3D"mailto:sivadur@xilinx.com" target=3D"_blank">si=
vadur@xilinx.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0Srinivas Goud &lt;<a href=3D"mailto:srinivas.goud@amd.com"=
 target=3D"_blank">srinivas.goud@amd.com</a>&gt; &lt;<a href=3D"mailto:srin=
ivas.goud@xilinx.com" target=3D"_blank">srinivas.goud@xilinx.com</a>&gt;<br=
>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 9fc6614e519..0ee3ef000a8 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -63,7 +63,7 @@ F:=C2=A0 net/9p/<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 test/py/tests/test_9p.py<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0ACPI<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
issue: I think this here isn&#39;t right<br>
<br>
Isn&#39;t it supposed to be:<br>
<br>
S: Orphan<br>
<br>
with no M: anymore?<br></blockquote><div><br></div><div>Correct</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0F:=C2=A0 board/emulation/configs/acpi.config<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 cmd/acpi.c<br>
&gt; @@ -77,7 +77,7 @@ S:=C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/net/phy/airoha/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0ALIST<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Ditto.<br>
<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 include/alist.h<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 lib/alist.c<br>
&gt; @@ -820,7 +820,6 @@ S:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/spi/spi-aspeed-smc.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0BINMAN<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0M:=C2=A0 Alper Nebi Yasak &lt;<a href=3D"mailto:alpernebiy=
asak@gmail.com" target=3D"_blank">alpernebiyasak@gmail.com</a>&gt;<br>
<br>
I believe Alper Nebi Yasak hasn&#39;t been active for years now, so we&#39;=
ll <br>
eventually need to reflect that here too, in a different patch though.<br><=
/blockquote><div><br></div><div>Yes, there&#39;s a much winder conversation=
 to be had here in general that is definitely a conversation for later.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 doc/develop/binman_tests.rst<br>
&gt; @@ -836,7 +835,7 @@ F:=C2=A0 =C2=A0 =C2=A0 =C2=A0 include/blkmap.h<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 test/dm/blkmap.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0BOOTSTD<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 boot/bootdev*.c<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 boot/bootflow.c<br>
&gt; @@ -870,7 +869,7 @@ F:=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs/btrfs/<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 include/btrfs.h<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0BUILDMAN<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 tools/buildman/<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -901,7 +900,6 @@ F:=C2=A0 =C2=A0 =C2=A0 =C2=A0 drivers/clk/<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/clk/imx/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0CPU<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0M:=C2=A0 Hou Zhiqiang &lt;<a href=3D"mailto:Zhiqiang.Hou@n=
xp.com" target=3D"_blank">Zhiqiang.Hou@nxp.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 cmd/cpu.c<br>
&gt; @@ -939,7 +937,7 @@ F:=C2=A0 =C2=A0 =C2=A0 =C2=A0 include/linux/usb/ch=
9.h<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 include/linux/usb/gadget.h<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0DRIVER MODEL<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0T:=C2=A0 git <a href=3D"https://git.u-boot-project.org/u-b=
oot/custodians/u-boot-dm.git" rel=3D"noreferrer" target=3D"_blank">https://=
git.u-boot-project.org/u-boot/custodians/u-boot-dm.git</a><br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/core/<br>
&gt; @@ -947,7 +945,6 @@ F:=C2=A0 =C2=A0 =C2=A0 =C2=A0 include/dm/<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 test/dm/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0EFI CLIENT<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0M:=C2=A0 Heinrich Schuchardt &lt;<a href=3D"mailto:xypron.=
glpk@gmx.de" target=3D"_blank">xypron.glpk@gmx.de</a>&gt;<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0W:=C2=A0 <a href=3D"https://docs.u-boot-project.org/en/lat=
est/develop/uefi/u-boot_on_efi.html" rel=3D"noreferrer" target=3D"_blank">h=
ttps://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_efi.html</a=
><br>
&gt; @@ -1005,7 +1002,7 @@ F:=C2=A0 =C2=A0 =C2=A0 tools/env*<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 tools/mkenvimage.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0ENVIRONMENT AS TEXT<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 doc/usage/environment.rst<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 scripts/env2string.awk<br>
&gt; @@ -1020,7 +1017,7 @@ F:=C2=A0 =C2=A0 =C2=A0 include/erofs.h<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 test/py/tests/test_fs/test_erofs.py<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0EVENTS<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 cmd/event.c<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 common/event.c<br>
&gt; @@ -1065,7 +1062,7 @@ F:=C2=A0 =C2=A0 =C2=A0 include/fpga.h<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 test/dm/fpga.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0FLATTENED DEVICE TREE<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0T:=C2=A0 git <a href=3D"https://git.u-boot-project.org/u-b=
oot/custodians/u-boot-fdt.git" rel=3D"noreferrer" target=3D"_blank">https:/=
/git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git</a><br>
&gt;=C2=A0 =C2=A0F:=C2=A0 lib/fdtdec*<br>
&gt; @@ -1169,7 +1166,7 @@ F:=C2=A0 =C2=A0 =C2=A0 doc/kwboot.1<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 tools/kwb*<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0LOGGING<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0T:=C2=A0 git <a href=3D"https://git.u-boot-project.org/u-b=
oot/u-boot.git" rel=3D"noreferrer" target=3D"_blank">https://git.u-boot-pro=
ject.org/u-boot/u-boot.git</a><br>
&gt;=C2=A0 =C2=A0F:=C2=A0 common/log*<br>
&gt; @@ -1207,7 +1204,7 @@ S:=C2=A0 =C2=A0 =C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 lib/mbedtls/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0MEMBUF<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0T:=C2=A0 git <a href=3D"https://git.u-boot-project.org/u-b=
oot/u-boot.git" rel=3D"noreferrer" target=3D"_blank">https://git.u-boot-pro=
ject.org/u-boot/u-boot.git</a><br>
&gt;=C2=A0 =C2=A0F:=C2=A0 include/membuf.h<br>
&gt; @@ -1398,7 +1395,7 @@ F:=C2=A0 =C2=A0 =C2=A0 configs/o4-imx6ull-nano_d=
efconfig<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 include/configs/o4-imx6ull-nano.h<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0PATMAN<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 tools/patman/<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1567,7 +1564,7 @@ F:=C2=A0 =C2=A0 =C2=A0 cmd/rockusb.c<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 doc/README.rockusb<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0SANDBOX<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 arch/sandbox/<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 configs/sandbox*<br>
&gt; @@ -1821,7 +1818,7 @@ F:=C2=A0 =C2=A0 =C2=A0 common/spl/spl_ufs.c<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 drivers/ufs/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0UPL<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
&gt;=C2=A0 =C2=A0T:=C2=A0 git <a href=3D"https://git.u-boot-project.org/u-b=
oot/custodians/u-boot-dm.git" rel=3D"noreferrer" target=3D"_blank">https://=
git.u-boot-project.org/u-boot/custodians/u-boot-dm.git</a><br>
&gt;=C2=A0 =C2=A0F:=C2=A0 boot/upl*<br>
&gt; @@ -1870,7 +1867,7 @@ S:=C2=A0 =C2=A0 =C2=A0 Maintained<br>
&gt;=C2=A0 =C2=A0F:=C2=A0 test/lib/uuid.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0VBE<br>
&gt; -M:=C2=A0 =C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" ta=
rget=3D"_blank">sjg@chromium.org</a>&gt;<br>
&gt; +M:=C2=A0 =C2=A0Orphan<br>
&gt;=C2=A0 =C2=A0S:=C2=A0 Maintained<br>
<br>
Same issue as above.<br>
<br>
Cheers,<br>
Quentin<br>
</blockquote></div></div>

--000000000000681d15066012ced3--
