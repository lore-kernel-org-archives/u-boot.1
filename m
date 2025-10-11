Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D64CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 12:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E36283B8A;
	Sat, 11 Oct 2025 14:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVKTkYlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0513583B8B; Sat, 11 Oct 2025 14:03:54 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1042883B7F
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 14:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-637e74e9104so3863567a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760184231; x=1760789031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IaAzvL2xvKxVBIA6UGVhywcaMwS7oUIkFsgmUpKjuEc=;
 b=dVKTkYlJWQ33Tc8azHwdHvdAyEM7ppP6j3GtBH0OgXOUofCHBuSVpkzSZugFc0z0GD
 oFAILwnZxJrIIvnYWmFOJxHJgYrtGKPrVqq3OBlroCrfZu1TWzcF0/wnDsxAFdfzdL0Q
 V8yPrPiHN7nIbPrqWKE6H6A9pSqkCWVr22CNOQuakRHlR80lXPJhp0dDt9wnp5SD5ecJ
 Wca+kGBqzI3tMg56jR5U4lMVLsxqEc2m9Vuw3mqbCS9vo92PFJ4mQu2Fo16+VlpXiZGp
 uYV4/m9YNXELQouXrnYnH+Qa0WOO9ldmpSP18ntztpcpJGm5uAp449WmUilQ89gNwnKC
 3C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760184231; x=1760789031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IaAzvL2xvKxVBIA6UGVhywcaMwS7oUIkFsgmUpKjuEc=;
 b=BVnni+9vYKcwdQIXXNSz5skcy3iZVVD7vUquMpIAljeA/geUrtaEeqxj/YodtTlQZL
 CNtd5duZTMqSBSsy0BxQ/6JHgKeQP1vgjuClroCMz4gKM47tVDDLxaEqkvdlKUFodUis
 C/5uU8m4jTq1HviZt3FDZTS1kZnV+bouQfkkcif6YzbZvIrS46NqMU6dme6FJvex1vEW
 qPmT4wTsv1m8OyQ0e15Ru+NWwxc0DFqth4ljyLldrhQ2nOYugs1+wJf4yhiCVB5f+NjF
 B06GfkmeH18Wo1nYfHWK32DDGMuGqnt1n5jvJyS4qdYXP+fbkv6rB9B8wHwFZhCzOJev
 2MVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhggVPpgC/wV45Xy9LL76Q1Kuh3geQZyTL9FYuFSRS4RfWazwfwk91Yy2Z0eP8PHj67aRDHSk=@lists.denx.de
X-Gm-Message-State: AOJu0YxZbpHvN5xAhlXMU51OhlYOE3UZLTG2kNP8xaQOjX52+bv9Nx6D
 6UzYmZ9iOFZBQYQzsZJgoLHzd0bj3ef/NbIcoRjzpRPJHjIU7TP+d3ZQDeCmYY6aWT4uWd7B5Gy
 0tLD3LBfRTLNb/mFwtYOBkZSthBPBrFk=
X-Gm-Gg: ASbGncv+3e92bjGJcmgXyYmIRZPukHlsr2Toav/yBVWwLJwfslT4JaovPEg5d3gTLt8
 7u6sdUfz9MvpOFsrE+QpXG6eXHunKINlzAtapCyyr1G/ferwEe3mfe8j4Sd17VlHXw3kxf4bxPY
 hCQMITAtYeiw2hbafUH9/Ewtc6Soe3m20tsfNS6hZrPiGP8Em7marqCuLQX21GaBtYWlnF7Y5bQ
 ODvuaTux7/qxUCOGxhiPCS7/hJpG8qsEnsCF85G1X16NhJjjnApQgEJ7NaK5rjKOmeqvUaxsvXe
 4HAew9H6pJ61Oj9oYw==
X-Google-Smtp-Source: AGHT+IF63KTWzowD3wk/q8d1hgGA5gQmzAMPf62mywE3TC+Ag4KoRVXeErv2Y9o1mWNtgYfyWKhbj8x7TUsj5VVAqMI=
X-Received: by 2002:a05:6402:354c:b0:639:fb11:993d with SMTP id
 4fb4d7f45d1cf-639fb119c17mr8837065a12.32.1760184231190; Sat, 11 Oct 2025
 05:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
In-Reply-To: <20251010142835.GY298503@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 11 Oct 2025 13:03:39 +0100
X-Gm-Features: AS18NWApOMUtHvDAg7tP4BFWkW-fwZhyKgcr6w__VPN5rassT86div0MvXo3-hA
Message-ID: <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>
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

On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
>
> > Make it possible to disable CMD_PXE.
> > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
> > In extlinux_boot(), invoke pxe utils only when
> > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> >
> > This patch results in about 9K reduction in image size when
> > PXE boot is disabled.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  boot/Kconfig             |  3 +--
> >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> >  2 files changed, 11 insertions(+), 10 deletions(-)
>
> Is some part of the symbol logic here wrong? A challenge is that "PXE"
> is also where the logic to parse extlinux.conf style files came from,
> and I thought we had split those two out. And then there's this:
>
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 2993cd7f9ba..403ce4c3d46 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> >       select CMD_PART if PARTITIONS
> >       select CMD_DHCP if CMD_NET
> >       select CMD_PING if CMD_NET
> > -     select CMD_PXE if CMD_NET
> >       select CMD_BOOTI if ARM64
> >       select CMD_BOOTZ if ARM && !ARM64
> >       imply CMD_MII if NET
> > +     imply CMD_PXE if CMD_NET
>
> This is one of the things where defaults isn't supposed to be so easy to
> get out of. How many platforms are you wanting to then disable CMD_PXE
> on to save space?

PXE is generally being removed in a lot of cases as it's not
considered secure and now we have HTTP Boot there are other means of
doing network booting so I think we'll see more and more situations
where we want to disable PXE.

This is actually something I've been meaning to look at so it's
something I would love to see :)

Peter
