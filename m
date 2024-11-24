Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3275D10C10
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 16:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB068912A;
	Sun, 24 Nov 2024 17:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N4+V3EpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA39889560; Sun, 24 Nov 2024 17:35:48 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7623A89049
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 17:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D483C3FDB1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732466144;
 bh=dUxk0h8yL/iYluRLdRU+5ueBdK1kPE9qZUDrmTc+ORg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=N4+V3EpM8AzY7sjYvSeXDzbdA9/Rlps26xPDFxF8VJPZ/SiFCYvktem5SEtDlxlNk
 +sx4zxmWfH6+ohVbVWcD0xM5vtO66ygY9IvR6XJ6YGnChlHEikJviVUEccVE1xRAdJ
 gqN0MXxShVu8Z3b0PHiPAzHNAcpppUdQN46dtptKTWownSs8Kj6pG0eZzUioBs63Bm
 m+fYXnxNhb3LCxqy5KgNZhsJueW2VqiYeyvJt/KbrUv7aNw+6ZAZmHfnTwtykRL0Br
 0tBF7UyXgtxxFpLGpp06HUAhJtp2j++ORGtfo5m5jXEEoVfKeRFJ3KYRUu/Q9gt1Uu
 XVMF/IKYB+2+Q==
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e9b243dccdso3553329a91.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 08:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732466142; x=1733070942;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dUxk0h8yL/iYluRLdRU+5ueBdK1kPE9qZUDrmTc+ORg=;
 b=G9JEztFTJDCYVrksF9E3voUHDvWx6cykrj/NLqdPNnfoPKUicNntUzAdCVm2NNP9ds
 ZwhlcVWbAAM8P55T/mLNun3J++Sd/RVXC1FUu9+JVet8fSW3TIspgqQ8saEGW4UiaKH6
 CbyLQF2vr5kUDPhZZpqYhAO0iaGrimpZnG6EX/zfpWW4CUWAtLV6igJ9JnGvY5tqJiK0
 ERaUqgeDgXsN42x+fYuKeYuetVe7JoXEos9GMb+Y+CWteaKeT8jaFV1GlpzuNTsDr36F
 a1bNIXvxlwide4fSWfEyswazDPF2n2DH701xA9mlmKx9KfHlNBjEaCAMm58+o6tMfKbi
 ITaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX+gi2XsmwgnS2scx/vmPi8aidwYgNox3TwRqs/q5RSmadubjjSZ1yTpPFVMZxhMLHrsygf20=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0LDOFuTlJvKXWbO6zDVKnyGz/gQbFjlGowbuBQm8xXXHawHFA
 CIil/fCmjHh7nYB7/qlLivAOHnTuSuZsdKAfz7ixpS0514Uhrc4gAhUsCohDbaYcrUParji1D5b
 MW4tTH/zQ9vNBhvAxD1TsyTehebu4m+5CGrc4CHOMb6GI6YfQawbqxAVmhnpQ6FPCbafaCvs534
 gJLAil0Yhq9d8oUtDijxlemoBYyA2aLMFIsU5MEO4f1w==
X-Gm-Gg: ASbGncu2LKbrSlX/fY5B62SidHRoCLpI1vSGisEhM14dHJ3NkwZC/c1Q4yLW1f0y9SH
 g9Qh3huslmaJakcAPuPo3OKnlI+AF
X-Received: by 2002:a17:90b:1bd2:b0:2ea:4578:46cd with SMTP id
 98e67ed59e1d1-2eb0e527deemr11366016a91.21.1732466142660; 
 Sun, 24 Nov 2024 08:35:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwcJal/QIFueOt7kwBz/kuJVDnz13nUq3FW2RtC3udHBByFYSJ56xAv9VFq2QNO96SJJtWi0hTG8c1h8hT3w8=
X-Received: by 2002:a17:90b:1bd2:b0:2ea:4578:46cd with SMTP id
 98e67ed59e1d1-2eb0e527deemr11365994a91.21.1732466142328; Sun, 24 Nov 2024
 08:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-3-heinrich.schuchardt@canonical.com>
 <20241124161741.GD3600562@bill-the-cat>
In-Reply-To: <20241124161741.GD3600562@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sun, 24 Nov 2024 17:35:31 +0100
Message-ID: <CAM=mAOkN5BGL6OJG23kW3iE_rpOiri-p5pp66qnD-s3BVE1fkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] configs: sandbox_deconfig: remove
 CONFIG_AMIGA_PARTITION
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

Tom Rini <trini@konsulko.com> schrieb am So., 24. Nov. 2024, 17:17:

> On Sat, Nov 23, 2024 at 10:45:50PM +0100, Heinrich Schuchardt wrote:
>
> > We do not actually test the code.
> > Scanning for Amiga partitions of the sandbox is extremely slow,
> > especially on the partially implemented USB device.
> >
> > For build testing the other sandbox defconfigs are good enough.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >       new patch
> > ---
> >  configs/sandbox_defconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> > index 718e4a8283c..683888f238f 100644
> > --- a/configs/sandbox_defconfig
> > +++ b/configs/sandbox_defconfig
> > @@ -142,7 +142,6 @@ CONFIG_CMD_SQUASHFS=y
> >  CONFIG_CMD_MTDPARTS=y
> >  CONFIG_CMD_STACKPROTECTOR_TEST=y
> >  CONFIG_MAC_PARTITION=y
> > -CONFIG_AMIGA_PARTITION=y
> >  CONFIG_OF_CONTROL=y
> >  CONFIG_OF_LIVE=y
> >  CONFIG_ENV_IS_NOWHERE=y
>
> This means we don't do static analysis on the code anymore either, which
> isn't good, in theory. In specifics, this is fine since the code rarely
> changes. But I wonder instead if we're timing out too quickly now? Or if
> we should have but weren't timing out before, but that's now been fixed?
>

There are still enough other sandbox defconfigs which build with
AMIGA_PRTITION.

As we don't have any real boards using it, should the Amiga partition
support be removed?

Best regards

Heinrich


> --
> Tom
>
