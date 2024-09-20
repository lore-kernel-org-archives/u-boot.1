Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877ACCF58E6
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649BA88DA0;
	Fri, 20 Sep 2024 09:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="LJW2a/yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D88891A8; Fri, 20 Sep 2024 09:56:29 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBCC288D91
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6ddceaaa9f4so14047477b3.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726818986; x=1727423786; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1evfQMKfUncxfRrBPsDNTGUwLd9p9syJkCr4bulr3QM=;
 b=LJW2a/yfoswJYhGNxxK6rXnArB9xseaskvwDO59J6UxM2WXEqgXPArKXKOBkVMCb74
 5Q+EAobwaPG5DTS2XIxAhds5mE8rIbg4SwyWCHKX99cflYtknma2GzBdaYhEnwwb10zf
 nI91EE3b9nNWmT9vcuYau32CQPLJJ77ilgNqWw1+ndk/AVMJrmP2eARUNpJG1gA/EnTF
 CS7omNnwkcLLGmoBKk11ST9QW8HaBmi7VFLa6cVeYv100SSN2qT2j3WKuoVImfwuPbtx
 jnSOgsGwuXf+lcZ2KCaIeT3DCUxQGtNR4dveJ235lWcaBYbUW/6o7nk16h/Tp9MdNT3G
 2h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726818986; x=1727423786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1evfQMKfUncxfRrBPsDNTGUwLd9p9syJkCr4bulr3QM=;
 b=K2EjLGjdNADqYK2jtexNrhwn3/9Od3VtVR/Nxi+WT9d88nU5y9t9DQqpwNmbP3PaA/
 GQVAMgiiUDsLcrT3lCJxt11Yht3WcUCKZx/pMAz1I2oOasnQPghknW07BGfLvISykN8o
 ork5upC5s35yE2LBGWCVK/tR6rcE+97W+I09YjuJTXJkkLtxJkk5FcrRTWVBCKTJ6San
 Ns9ZCxXIxxUrtHp4i1TsgtVhdng5bZPe/wmwhYzZ+Por2wWimljXGi2U5J8nZdo9EgfI
 Rq0u+o9yEeYvrpqgumFfqY2i7i16KdEyII8Z1T2xEmChQtwglqglbdP7b/0Tjo97rAqa
 B4Kw==
X-Gm-Message-State: AOJu0YwvnxvoGuX1lblcZJrP9ADlt75QfRFUC4qdvnMcKvlB+fUmxw62
 lFRpMlWOYjUh1vyAxLYalmXX9WsAyIuVh0E6r2O7yCGOyl/A8DLHefBz6F3jJyo1hcwAP3kMq37
 vndHKaGsc7Mm/7vdPNkStXNMzZFfL+QM0xv8UaQ==
X-Google-Smtp-Source: AGHT+IFtGXCmvvlV4ukUjiNBz3vc+FOilUq1K1fsr+ZRPx37jSn5OuVpkhczpnmxRO+3yxBr1jf9Q1npEZYN19XeTbc=
X-Received: by 2002:a05:690c:2507:b0:647:7782:421a with SMTP id
 00721157ae682-6dfef019bb1mr12369517b3.45.1726818985821; Fri, 20 Sep 2024
 00:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-23-patrick.rudolph@9elements.com>
 <CAFLszTje9cRMsrQW9DsPZY1FTxZ8t=bU6z5mO_XxfEwTH6Pxpw@mail.gmail.com>
In-Reply-To: <CAFLszTje9cRMsrQW9DsPZY1FTxZ8t=bU6z5mO_XxfEwTH6Pxpw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Fri, 20 Sep 2024 09:56:15 +0200
Message-ID: <CALNFmy1aKyKA9QSA-Xgj2ji-4GL2JUYbuWD=nqW0i_eDrVyL_A@mail.gmail.com>
Subject: Re: [PATCH v4 22/35] drivers: misc: irq-uclass: Update
 irq_get_by_index
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Thu, Sep 19, 2024 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Support reading the "interrupts" property from the devicetree in case
> > the "interrupts-extended" property isn't found. As the "interrupts"
> > property is commonly used, this allows to parse all existing FDT and
> > makes irq_get_by_index() more useful.
> >
> > The "interrupts" property doesn't contain a phandle as "interrupts-exte=
nded"
> > does, so implement a new method to locate the interrupt-parent called
> > irq_get_interrupt_parent().
> >
> > TEST: Read the interrupts from the GIC node for ACPI MADT generation.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > ---
> >  arch/sandbox/dts/test.dts |  3 ++
> >  drivers/misc/irq-uclass.c | 66 ++++++++++++++++++++++++++++++++++++++-
> >  include/irq.h             | 14 +++++++++
> >  test/dm/irq.c             | 15 +++++++++
> >  4 files changed, 97 insertions(+), 1 deletion(-)
>
> Is this a new patch? I don't see a change log so I am wondering if I
> already reviewed it?
>
It's a new patch. I had to extend irq_get_by_index() as it is used to
parse the DT while
generating MADT subtables solely from DT.

> Regards,
> Simon
