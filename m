Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982FED41C24
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 18:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02898389A;
	Thu, 11 Dec 2025 19:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aDlQG02Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 515F683642; Thu, 11 Dec 2025 19:15:57 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE9F8389A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 19:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64175dfc338so762146a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765476944; x=1766081744; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JMW6SUmf6h3z6Ql/l8TQg5wtiSa/FH7XXfmoZ8CH2Ko=;
 b=aDlQG02QWhy2yNLHrY2GNC/kqfIFeoUM5/F0EzwvqbPwg6RfuyLYhqA72zi8vRE2FC
 oDODW9LDiFiZoYUboHbvicAD8kkFAAjSu19qD2Us+KJjLpS5/37rp7dpZdbJqu9ZjQNh
 MUMifk+mw3xp6V/boNJMNDfL+zC9OX9ZkokFSNnc+Q6Q9GgoMnXeWo13KwQwygUxx8wo
 vHvmjVmGeD3+EKTf4WJiZjXVfnbOB+oKCL8DHIIdcSj5YZPkDlwZqglORaO98rnfythB
 OSLlhTtjalE5HkMFX6PiEWZ6Q9iAAzfUcSTgIvE0D08TfWjq9RwgKkbj7013IDORzjVK
 IfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476944; x=1766081744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMW6SUmf6h3z6Ql/l8TQg5wtiSa/FH7XXfmoZ8CH2Ko=;
 b=jgPrd9wRcSMH4w4sF7jGolRPteE2tTpZO2F1uaTeupWoVwVJHGhdHUWPXUS1W0wKDD
 9QCPNOuyKMn3L8kEzCO73pn0GHZiCt9IqDyQwOjxNDKYzmzD2WsFLtJitmp9TWfRq59D
 zrHzKL5x1fFr92ademOW2j5l1HwORt/6cFzclPki1OipS74Nbi/GPci1eEejs4xmVyEN
 nOFlC1T+CjbXHdDSiCeTghvRpRlfEprGZbpGCCG5rN4S91/lBAikKQXP7/cT29yCEuCR
 26s9atSSmjtOGYd35BIrbWrXDQBIksaqQWIWuP1keuwrD6nlxCObRp2IjmOzXb5mVvb6
 4m1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGmHF6x5W+wtWBFqYLMl7px0EQxZfkJEMFKD7zaV74qxtnBYluJKQd/1Dl3LpAcxp/KpU6m3o=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0BgljGBX21azP1znUaVN9VnOcqGEswjj/H36YehSMJ9CRazHw
 drPDWZaMZXwHK9RFl6oXYFYEU6Shz9e/aAJX055QZ5uvvdl2ZlhKUVoBbkOn6uqSZ3aH9t8f33C
 ZQ5SkYQDg3l5C9K0BWkbW87iVdo914k/KGA==
X-Gm-Gg: AY/fxX7vWQJBCmG8Z+q+ExFU+iyNUvxNYmRG3UeSRfH7e5TBErbEJTgRYy3hAzcB3hF
 qaVFq5n1R2rFmYKTfWABCRhaltzbg7X+Su9o0zSHDBxp1AZu+LFb/eSwQOIb6124F64Cps/6veW
 J7QndgjoSXiKUfE4BN/FzuZA8K8X6RQLEL17q+eMC0yj3M8w/fblc2ifMGaXBiqc4rJnmhNQmEm
 caOXbthj7OzTElTzdekjN1/SLeNW5yn2d6AwjYRMQkgcb360MQNIGVEOcE3H2/EoBzK2Qcz/Dua
 08lsAXle1WeMaXYDuRKTQtsYEytvc8hZKTzsCAhAhlylRXvUsA3vf6wx7oteV7ejZ/eInRLh49h
 tysDtA5UyIWKmD61xBnm0wXsyQ4C+ApAw8GCtp1ZZoTSxXKqtgdV6WeSfj1dEbi0f
X-Google-Smtp-Source: AGHT+IFs9pb36avUopqb9UmhJvSSjNUqgOBIv34HMg8O2753CiJJYL7suLMfUNc7KM+CztcS8O2IkO18TtWWsEjEffE=
X-Received: by 2002:a05:6402:50ca:b0:647:54a1:4c67 with SMTP id
 4fb4d7f45d1cf-6496cb85593mr6105094a12.7.1765476944197; Thu, 11 Dec 2025
 10:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20251202182403.GF303283@bill-the-cat>
 <20251202212119.GM303283@bill-the-cat>
 <CAFLszTiQZRY5qqT7kjUwCZdiHgdvZBJN4OPg25S5R_fE65h9bA@mail.gmail.com>
In-Reply-To: <CAFLszTiQZRY5qqT7kjUwCZdiHgdvZBJN4OPg25S5R_fE65h9bA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 11 Dec 2025 18:15:33 +0000
X-Gm-Features: AQt7F2rGrMQVYHp5yvyDkYWdMpPQ4mRU9LS3Y4BCH_4Q7hmTsGa3qhQrQJ63mpE
Message-ID: <CALeDE9OQvhXoRiX7rfLafhBWYYSUbaUHZdmAJcvL9xP=+m8Nsg@mail.gmail.com>
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
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

On Thu, 11 Dec 2025 at 13:36, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 2 Dec 2025 at 14:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 02, 2025 at 12:24:03PM -0600, Tom Rini wrote:
> >
> > > Hey all,
> > >
> > > I am wondering if at this point in time, anyone still builds our host
> > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> > > Windows, natively.
> > >
> > > I ask for two reasons. The first of which is that a reason we still have
> > > to support Azure (despite its slowness) for CI is it's where we have
> > > macOS and Windows hosts. But at this point in time there's so many ways
> > > to have Linux userspace running on Windows or macOS that I don't know
> > > that there's any value to these builds.
> > >
> > > The second reason is more macOS specific and is that with:
> > >
> > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> > > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > Date:   Thu Nov 13 12:54:51 2025 +0100
> > >
> > >     boot: Assure FDT is always at 8-byte aligned address
> > >
> > >     The fitImage may contain FDT at 4-byte aligned address, because alignment
> > >     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> > >     8-byte aligned address. Make sure that the DTs embedded in fitImages are
> > >     always used from 8-byte aligned addresses. In case the DT is decompressed,
> > >     make sure the target buffer is 8-byte aligned. In case the DT is only
> > >     loaded, make sure the target buffer is 8-byte aligned too.
> > >
> > >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > >
> > > Which does things we must do, we now don't build on macOS. Why? As best
> > > I can tell (and for a general purpose OS, is a good call), memalign(..)
> > > doesn't exist and you need to use posix_memalign, a not drop-in
> > > replacement. We could spend some time reworking the code here for that,
> > > but for now I've instead gone with this workaround so that CI can
> > > continue:
> > > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.com/
> > >
> > > But longer term, unless people say they need and use these tools, I'm
> > > inclined to remove them from CI and remove this workaround, for the
> > > v2026.04 release.
> >
> > We have solved this specific problem without a large work-around.
> > However, the more general question remains. Does anyone use these tools
> > on Windows / macOS?
>
> There are a lot of Mac users, at least.

Where do you get that data? Are they a lot of Mac users building
natively on MacOS or in Linux on Mac.

MacOS 26 adds support for native containers running Linux, I think
that this is likely the better way for us to support those tools on
Mac.

> For Windows, mkimage is used by the EDK2 people (Universal Payload).
> It might be some years before they switch to Linux. Even if Microsoft
> decides to switch out their kernel, I suspect the 'power shell' will
> still remain.

How is mkimage used by EDK2 and in what way is it used on Windows, can
you provide a link to documentation?

Windows has WSL2, which has been around longer than the Mac equivalent.

Can you explain the value that native build support brings over
supporting Linux in those subsystems on those OSes?

Peter
