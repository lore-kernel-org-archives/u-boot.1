Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81346C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 20:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C114E407C1;
	Mon, 27 Jul 2026 20:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tlx6G0tmkJJl; Mon, 27 Jul 2026 20:53:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65902407AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785185627;
	bh=+UR60HBrBR0ZuWDMelRUdGTB8KmmMjZQnVUCWj9k/LE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g0kpZa+y8xADGyPhQEgv93WiJyXY8lr6w06kaSBnRP2IJ2lWPSa0fB4EOol6C7HLP
	 mjnC7D4273p6Xn4Jwx6ww/7O9aT6cb3VeteerQSbDjizJSitkmeXnl8BVLlX+1U6yc
	 fB4ex0D4RVYXq6L14+HMpjD0QeC3GQTthLWNazKJtDtsP/h5gjjkHDC1kW6k6XRwji
	 OVvTNt9QYwcrWG6o7Wn8wIwgoDbgiRxWKwVP1hBZsDW9Yv8AE/ZGKK4C3PrQilvWpL
	 JIOdXvmd8cpo62Y/3uzxHz+chDjk64mECTBYOU0j/6o3f1rfLZLSQLq4Ofg3G5XH1q
	 GlN9e2ZJa5nIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65902407AF;
	Mon, 27 Jul 2026 20:53:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EE59357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E07CB60769
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mn7ZLEQnZqu2 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 20:53:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 87E36605E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87E36605E1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87E36605E1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:53:44 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4798782991; Mon, 27 Jul 2026 22:53:42 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BCD82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 22:53:39 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69fe3cd5ee6so3016342a12.2
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 13:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785185619; cv=none;
 d=google.com; s=arc-20260327;
 b=hCPW3eGQrj9RHF6VIukTem4uMZcN6BHmEeOr5zTfhCMLkbzW6XQLY0kpomz8qcpHkh
 i3e2L+HBk7Nqavv/2auqfVqqYq8t84aWoFy64J918PQtShoZzKL1r4WYBX/lTNWPIUwy
 MUbXYT+zO3E45rz4P/ynryn+8EyMFT7HBj/SMJOptdQj6dCQnjLSTLzP/d2QaF0N/EXK
 NMBO2D1J/tv1iBwaIkiO8pANWS0rZ6DJQAV5jcwqA95Ma+nW71XZYz4AgUtf6tdVv7Fs
 RrnssQwZdwxEBgkYyd+pgcSptJH0DOp7faTb3PoKf1LO7Ug9SKtrU5UpkZQ+3azSlVXa
 Df+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+UR60HBrBR0ZuWDMelRUdGTB8KmmMjZQnVUCWj9k/LE=;
 fh=gxVxvnmuIiFlvCTejdJRH19Ue1/pdsae4OpqU+qvUWc=;
 b=AIDiU6ou+NGG5/yP0eeOY/M7XU1ta/9JjOkKdPXBfzekG+TdoMwDGQI0z3/2IVCyI7
 hilCs0j4RkdXzNyJJgjKY1oF8xfOXdHKfGWRqF/edLHlzbiWO93k8CyOReZ9AdObmH0s
 BqZgmj8C3pDQiY1q7ntL8VwA/PfRaG39yaYFvU93wmD3xGd4ke96N/8uI5qkwf3yyMnB
 HBjMHD9bIxSqpbrj17sXPlOTqqM05Oumy1745DhyAA9vliIUt4L+L113zCUzWRSRWfiL
 x7JYGezeVY/F8OADu3zeu2AOK9/xLuCEJMsnE7jLCnzVy64KtsUGiRKjU0+mDj7/rJK6
 SlHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785185619; x=1785790419;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+UR60HBrBR0ZuWDMelRUdGTB8KmmMjZQnVUCWj9k/LE=;
 b=AmaOY23vXOjcHTJIS9hTJ1m2+XbeE+GVZKtUrPSrpXtjUACDNtBOO9gTLRpQwz5gUw
 66UlVYZUPmtOXMj24uk1kiOP914i0ubltyTBsJedeklRi1SYNhiPvCyy9zlxcmnFohRL
 p9TcBFQ4o+OOhVPikU4IdthVbgG1eDyMBw4m2LbW8Oz5KzYbxjE0zxmU4485+kCCI7Oo
 6roG5u/wy26jsbAxfjhR7ZrXylCNF9mL2rilFlj1Lj/gid7ob7aVHcriyLMCbLE3zB1X
 L3v2I1Af9yD/Mm8gIY/R21264aKYfATCBEiRfQ5R+TMJL7UI7j+PDeD1KkozxY6jGiDS
 IjKg==
X-Gm-Message-State: AOJu0Yx+EwhLRNu1Ypeovv6EJj+VJ57us4f8BGpUw1TfDzulA3dZyZtk
 0vA6H5XEzDG01W987xQ43GXBOXOiUU7ninQd339SRL9cM5IsIfMlTrS3nhFs2FstkGXpA1fiXiH
 fKqfBhvWItq8aZcSUMIKjYnEu7I7TerioP4Mxj72n
X-Gm-Gg: AR+sD13zVeBCt6nlzP/rmgxG4+Jmlv15cmFweOOJC/ZDeEmNKzL0M08CWXUxEv+cSGU
 4+rD0IKmvwlKYiik2VeBUZnL3N9pPpedw2lUzzJxXMd7c38EMnVOA7xSiXmwVzIbLtMaHf/qHMo
 TxK7Q4mivNN+NBQ5GZRE4g2HvbCDU/Q+eaBouBNJzI8Up+L7vyIAJOAWQQpfCJILsDQ0PUeLe3+
 3iqV1Loq25zzJzkpr6Q6lDTkxdO5pDcAQHGv/J88CokjOBJE9MwPQlG2+34J2hWiXxkh/o=
X-Received: by 2002:a05:6402:e03:b0:69a:a81d:d454 with SMTP id
 4fb4d7f45d1cf-69fc11078e9mr3978737a12.7.1785185618835; Mon, 27 Jul 2026
 13:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260705104231.3846672-1-sjg@chromium.org>
 <20260705104231.3846672-5-sjg@chromium.org>
 <CAFLszTgC1SF3rS37GDXu6k1=6mcQTfSEA9UhrRX8nsqCdyLnxA@mail.gmail.com>
 <al5_HaKU8CpvqSei@ashevche-desk.local>
In-Reply-To: <al5_HaKU8CpvqSei@ashevche-desk.local>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 27 Jul 2026 14:53:27 -0600
X-Gm-Features: AUfX_mxJy0lU14yzhaB1shbuzu35kirjMsqeCEfEW1sbE-hvV61Vh3gTLiiKSrk
Message-ID: <CAFLszTi7rg7Hgn4FCSVmVZkszhjsUvDp-8SU+0Q8OzfxRwvr_w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] CI: Add an sjg-lab job for the Intel Edison
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785185619; x=1785790419; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+UR60HBrBR0ZuWDMelRUdGTB8KmmMjZQnVUCWj9k/LE=;
 b=DwRZB9SzwvAoS+HFpwB1/NaiCkGqWNKeBosmc4ZVB44IgoL5Wc6co0xw26NN0rCxnF
 dRLY0H5qx3sCoWZnm75gaCZcevEsmS1OJfZU0Jzrblt1GzlP4STLuErG1iDB3WmJEJJ+
 gRgG3HZ0OoiJncWDjKpc5jztSMQmR+ZqKdzjo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DwRZB9Sz
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="DwRZB9Sz";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Andy,

On Mon, 20 Jul 2026 at 14:03, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:14:01AM -0600, Simon Glass wrote:
> > On Sun, 5 Jul 2026 at 04:42, Simon Glass <sjg@chromium.org> wrote:
>
>
> > > +# Intel Edison (Merrifield/Tangier); U-Boot sent over DFU into eMMC u-boot0
> > > +edison:
> > > +  variables:
> > > +    ROLE: edison
> > > +  <<: *sjg_lab_dfn
> >
> > Unfortunately somehow the board seems to have died - does not appear
> > on USB anymore...perhaps it doesn't like all the cycling in the lab?
>
> Do you have external power supply connected?
> It might be this:
> https://edison-fw.github.io/edison-wiki/edison-fixup

Thanks for the pointer...I do see the board power up though ("Ready to
receive application") so that should mean that power is OK? I don't
have external power, just relying on USB power (which I can turn on
and off for this port).

I basically see this at present:

$ ub-int edison
Building U-Boot in current dir for edison
Bootstrapping U-Boot from dir /tmp/b/edison
USB resource not available; retrying reset with longer delays
Recovering Edison via the xfstk BootROM downloader

XFSTK Downloader Solo 0.0.0
Copyright (c) 2015 Intel Corporation
Build date and time: May  2 2020 10:22:27

Intel SoC Device Detection Failed: Attempt #0
Intel SoC Device Detection Failed: Attempt #1
Intel SoC Device Detection Failed: Attempt #2
Intel SoC Device Detection Failed: Attempt #3
Intel SoC Device Detection Failed: Attempt #4
Intel SoC Device Detection Failed: Attempt #5
Intel SoC Device Detection Failed: Attempt #6
Intel SoC Device Detection Failed: Attempt #7
Intel SoC Device Detection Failed: Attempt #8
Intel SoC Device Detection Failed: Attempt #9

I suppose something could have happened to the relays or cables...

Regards,
Simon
