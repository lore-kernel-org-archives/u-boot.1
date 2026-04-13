Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6633FF34C52
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF2C18420C;
	Mon, 13 Apr 2026 15:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dvaw1RmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1EA984223; Mon, 13 Apr 2026 15:36:07 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5CD884236
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82ce2e2880cso2909486b3a.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776087363; cv=none;
 d=google.com; s=arc-20240605;
 b=ju3waesmnrDSGQ0oyewHrTCLD64nny+ui9BWbJeUXEb5ITc3usVvjpZ/EOwVrG8Dsu
 AEhnZUqatuVl+Ig23sX44E+Fh1GIOni4C0J1OjSeX5oXat/eQYoOtOYMEnIPTfurXOG7
 RqteAB+D+B2hCW6J471WLG33r0et1WYHDNExt0z4kqeNlasVQUmCeNvFr2XrQn2i+hR8
 +pV/YNI1oLTsSyZrXbQ1p1YAgoMOGkjWZAvU/O/8/eONBwtuGHa9Lc0sE+pLqhal6OVV
 fEZ9x2lkXk77vx890OO0ZYGFf3LGIGGF5uRaF4kR6ziXrg7VZvKfTPkz/Ki/YR0qgk+4
 OfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JyjyfGigv+6V2LL9ep5+aFn3VtFjjjltMMltL9LxGiM=;
 fh=dovlkk77bLQv3eQLiZLFZZfIE3qYRQyLX9eBpoiPgJg=;
 b=RNelXc+nFu5AG4e7bZIJEqpGD4BWPuQyRrg8pjQm7FWHkhCoPkEtvuyZly/atam4TQ
 MnwIYI8UaE2c/GpX7clWFNlcmuYnr03puIRZ4NPqQ8L1C3BRJPjKk/Ex63TAG5y1+hNb
 m+n9B9PDi2clTggiUca84R671H4dLTrB3bJyY6J9y5l5KaqXhMP5RhWkjbjiKILimg6d
 ja3pGJ2gB+MvKx/XsEpVbqa41BlEGvjFYf/jgRvSU6Bojd7pzA7GL2urOu1XYSwxckp9
 7dFaCYJUSeYRJKQjQ4LFU0AHnQrKt6TtlvfzO9YrlBPakpaBhsKfMGTkHuukguZrY0nN
 y+Pg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776087363; x=1776692163; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JyjyfGigv+6V2LL9ep5+aFn3VtFjjjltMMltL9LxGiM=;
 b=dvaw1RmW+Yaxk/Uv5krT/gTcMfqYAoP7RGAIVRpmv3zX5/B8zrWPMqCcnTMamYfzGz
 ObOb1a9htq0bMGB45Jqv/vPzljVYgmTz1saAGpprfPs3sAMKvsXCMkjJP+hi8uAlcTf/
 xeW0JFuSIkLatxbniyBzoxcstg461Jq4T5OKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087363; x=1776692163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JyjyfGigv+6V2LL9ep5+aFn3VtFjjjltMMltL9LxGiM=;
 b=a5JgK+HyjKGaSoxoiieRXzSlzIK+VHAgbrCKuhzdXtYG+Of6rKwnNtcuAqqrm3JKII
 /+tME6ZYNKr/tIFHiPFglGFqzqRT6qdzBYBxj5Xupn+v0wL0pxctQVHHmwEE6IcL0gR+
 Q+MDZ0pb3BWRZaRPBFv++Wt/HVel+jxHA7ij1/5/z1gb4eM/o+rEFMFTgz+jQa4CwmWi
 36ySM47QOotN1hkq/ICw/NUZUFpiJ5FTCKCT8h7DisP+B/ji5Qcziz4RZViNchEbPm5k
 43BJnFKn5RNE9pVw3tSIqzQJSam8LKIet29ncBd29jv+/J6jzujx3qgYcpA7YJZBknKS
 YDYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9h4ylVMNEdUF4+WbKrKvyBpNHVVVlFKqQ4zq8bNkAKPKgSfDy6epSqIrQCN6JVcD5nzdBuI2U=@lists.denx.de
X-Gm-Message-State: AOJu0YzLfF1dTYPgzB2Dg9kWNRVKTgQLhOLYpevLDTMe3MKtdG5VsMiE
 wG2hCsYIR3auvgziKIvCHoITjgN/4LpWs83XacWPCYifvadze7r3IllvZBWy2hd9VMDLvR1bTra
 ZHnwnVXbAaOWT4ApyIHGcKTt4fMOM/0Bm0NclvPzX
X-Gm-Gg: AeBDieu13fVHxfETcqI0/Vfzl+EXmzw7yKZ5d53dnA9Bu1JufWbompnZ6LzwlhLW/FZ
 Z15rFCxgB0Ulq8PMVwqbFhq4mV6gldgjPPPX5fVQulFFURcg3N8QKsBdcW4BAIf/PJl5pzTgmvn
 BbDmjZy1D5y02OizMJYXbVAgXW3532MVFezCW+fA/0Vc9oSj5CaLQOW0WFVIRS0StzMm77n2nyy
 NQZoXkPaOJQd/dcFLmGLnC3tHUu76YSvOUXyNsM04T9ipIwhgqdpFV2dKe6Kaj2C8qw4QIdGape
 ORxcuA==
X-Received: by 2002:a05:6a00:4088:b0:82c:68f6:a18 with SMTP id
 d2e1a72fcca58-82f0c29fe5cmr13335790b3a.34.1776087363420; Mon, 13 Apr 2026
 06:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
 <4D95B3CE-66CD-45E0-9DB8-2CDD45622920@gmx.de>
 <CAFLszThvYf0=ebaGqprxy7unbVomC+tu-5uQM2auEZeiNCZpmA@mail.gmail.com>
 <CAD+NunbVCgmyUdfd4WX+i8iZZ4FZy5bwBRdrvsH4B6us9gqwfQ@mail.gmail.com>
In-Reply-To: <CAD+NunbVCgmyUdfd4WX+i8iZZ4FZy5bwBRdrvsH4B6us9gqwfQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 07:35:31 -0600
X-Gm-Features: AQROBzAyvxBDj2ctcfB5Y4EtrkbQEfqsYXHQ5aA8JmUDt750LENMDEJzoWHJiTE
Message-ID: <CAFLszTh6+tKdfSWNzKAfyCb67a0U+m7A3YEaOhS3HXZHcPBvyQ@mail.gmail.com>
Subject: Re: [PATCH v2] arch/x86/lib: implement cmdline configuration property
To: Guillaume Ranquet <ranquet.guillaume@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Guillaume Ranquet <granquet@missingno.tech>
Content-Type: text/plain; charset="UTF-8"
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

Hi Guillaume,

On Mon, 13 Apr 2026 at 04:48, Guillaume Ranquet
<ranquet.guillaume@gmail.com> wrote:
>
> On Sun, 12 Apr 2026 13:37, Simon Glass <sjg@chromium.org> wrote:
> >Hi,
> >
> >On Sat, 11 Apr 2026 at 05:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> Am 3. April 2026 16:28:23 MESZ schrieb Guillaume Ranquet <ranquet.guillaume@gmail.com>:
> >> >Implement the cmdline configuration property as described in the spec
> >> >[1]
> >>
> >>
> >> I can't see in the spec that the command line property is x86 specific. Why would you try to implement it in arch/x86?
> >>
> >
> >This is a little tricky though. It could perhaps be handled in
> >bootm_process_cmdline_env() by setting bootargs. Both legacy bootm and
> >bootstd (via the on_bootargs callback) would then pick it up without
> >any arch-specific code. But I haven't tried it. Commands like
> >'bootflow cmdline set' need to continue to operate as now.
> >
> >Regards,
> >Simon
> >
>
> Indeed, I've looked at implementing this in a generic way but it
> requires a bit of massaging to get things working.
>
> I was also under the impression that no one in their right mind would
> use the command line property if they had access to a device tree?
>
> Tell me if you think I should propose a generic implementation?

I'm happy with what you have for now, so I'll leave this to Heinrich.

Regards,
Simon
