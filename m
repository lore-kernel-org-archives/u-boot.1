Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA485CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 12:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78828460E;
	Thu, 18 Jun 2026 14:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LkXHBm6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3837784874; Thu, 18 Jun 2026 12:05:16 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4885A8460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 12:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F0A83F844
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781777112;
 bh=6IzVGVl8yhTdpFWExYa+19YTlA+q7bzERrRd6pSxx+U=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=LkXHBm6y/3u3YzC6JNXeJLVNOGxV1w+vxM9qH2UPl8aHdZLOHgl82TxXyvDb1/5dR
 ZVNJLy3X61OIM3ByRJl+TMkj5TZ4s+/0Qx04heGq2CPjjLrYpak8/EzBxtrQGzPFSO
 iAb489sUO0xHhfIjVKjxbtiSHX9UMUt1tFkHDsKX1XjUl19F52+/rmcSl5fkkFPT0y
 MIiM6XHztK+yXDpXeAYs07TIAiiguwx6U12V6/MmsxBxtNnqoxXClMCBDohWAroKAD
 JP/ihsQxPqj+RHJbTuhCwSxWEigWYTpUSvM3izwl37h69fPjRjn2koV1Gnz6RBjipp
 Txu/nUs4Lu/gR7Bv4Rv5Y8n6BxRZQ9H6j3UX3+EvXUSRz+re9k0JD2r15UBjgJ0iMD
 YAFGHb3bFtQpcSqX+UJ4revC6ECFCCqjY1sC7vRwijYclSPMSCDKhCiuIKo+V/fAZr
 gRT7fCBrZGMVPqDIijtIjNx7uuh4rMme1ACFJfz1K16eq/ZYlJdX94IL0Wgq2Vpcfz
 45oNPFgRdEOtk9Gf1iVxksAxnTj1fCEJmhxcvRr5scAE99HUv4SyTCxCIiGO2Nw32z
 cONbE6gZ21NfXuvHlVKHVd1tf4ePciV+WHtfRoHTjK2HfG5jCnkM47ibUWAL51YshR
 LQ3C21m+g+ZDtItjRKnuceRQ=
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-695c0775f8aso643636a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781777112; cv=none;
 d=google.com; s=arc-20240605;
 b=X/6FjbXG4cGm482+IuWWDeFIg4DIxZjFUzIqskkOHyiQ/A7zDhmeFsBuTBFk5IsrFt
 v8IvBGiYbTjjaErO4+AobBVudOHrYRgPEnBdITFRbHMLpuMGj5pju0tBFM9Rrl1kouR+
 XyUhMG+gi/mZNlgU5Euo5elORRwFS5MXkbIEvxPwoN550A79V5oihWRVYDJ2LX3AZzD1
 xdHik6VTsWH/f5A0Tg8qmTBzvhVD0twFUT/MJtBe15C+pjasfpcIKdTzLyuOA8wgzOJb
 k0mKm7vJXzTyKtlgFgASOcUX3GjsuSS/Rp82DA7J/t+Rk/pCzKRkYq2X82Kq4OqNIkub
 9UTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=6IzVGVl8yhTdpFWExYa+19YTlA+q7bzERrRd6pSxx+U=;
 fh=WXaNV54bF9Uhi3fQuzHZccizLCM32VQJIM2GDk48r5o=;
 b=FPHxoSKRpEJKNCvA5N4GcMATQXr+MQAzEIKwHUF0prXfBfDVrk24hH8hDqOYodj30S
 wbvy7G/xBAIzk+9Z6NndQd4qqumzJrBWYq4ktXYwsuNnFbN0RGGsyFxz6co+CefpkpfQ
 WvFRAtquWLRzczJ6laSNr2ZB8hvn4FUY2q0IggjarJVBHdleGkfsT7KAbWDSoMfWsc0Q
 p32ut28inOcMAn38KuHV7KDMZ3oIY62mbEljN9V73thMznnItqA9elg4Jgsoer3+8mle
 /kT4e3VOc1mdU9QoVh5EIrFWUpd2Xq4M4eZIeqfSZ69fgSuJj7UlegKTJ55Hm3CjfzxP
 CoLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781777112; x=1782381912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6IzVGVl8yhTdpFWExYa+19YTlA+q7bzERrRd6pSxx+U=;
 b=A/uKJ87F39Hf25QOV7CMp1DT0MNMPzRG1utNwW2wCGHpLL6qfZozmFYkU2mGqt1SQJ
 gFFf2bvJ8xU0sL4hWucvasANE2RmVbbnQxJ4gSPmKTVB8gdMFTUDgidiEFdW1WKuLbSh
 gDKkEH/1M1xTDwvmKrKGnq5N5jUfjDrxwBMgpfSoLAtDC5N02eXQzwvHFmDptcpjZvIw
 62f/qqlPZcJt5M83SILqLXyV3lga3b1L/qIV8GmgpEoI7GXNIZxkzSxjSOeAlzGzay7C
 1y7/vjVP7Q/SHc4D5c9p7DQhPVf+7XyzemMjV7z9ap8nSgeWAzjF+CNEx5qS3S9KUhR7
 JMsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KdvYbtHXF20Bo+fGLdEuv5nLkGUk0JRMUcDLjFSVzko/WSKwxMnIHmV6NTWew47A/+bMaois=@lists.denx.de
X-Gm-Message-State: AOJu0YyRKH+ypTcC42jDTu62/l+cVqLV9KzO/1KEVoQ0hCwRQjgbLcAD
 PS7uhm3at7mdxtmis0DUbmNcwaMo0hOIeSEm8Ed3ZpvnRwUSDUVMX5BI1UUgwzVExpCFFJsvgxV
 Lw0XL4fjwB8diLXEZolsagFm5yfzE7y5CN5a5aJfxKawlGHxjpCFEIDpVPxraxaXf82HE8b0bPz
 mW9eZa+FYBYaDAnnpyjbZ9AY4fdiU3HUbtOGYX2dD5ISGLSl8mK9Kgf/2H
X-Gm-Gg: AfdE7cl4NLVH4gggOTqAEDzpc6MqtKBA0ur6Jz32UNu4tb/4a9mEoXErjsmv1T6XFQU
 8No6t8haGfkdeGz7NIgMtL//At5VBZEAerkGla/UDc3DMAvOaRwApl9kwxibc9KcBsxUQfRJQ2K
 xCekY1c+VJn2ikJwP9XGFtwlLtaYS+k/u5cdsts07QoKKSm6vNd55MO1qQwGXCzljsXPml
X-Received: by 2002:a05:6402:2b93:b0:684:32ec:2332 with SMTP id
 4fb4d7f45d1cf-695473e5120mr3965945a12.2.1781777112087; 
 Thu, 18 Jun 2026 03:05:12 -0700 (PDT)
X-Received: by 2002:a05:6402:2b93:b0:684:32ec:2332 with SMTP id
 4fb4d7f45d1cf-695473e5120mr3965930a12.2.1781777111696; Thu, 18 Jun 2026
 03:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
 <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
 <20260610194840.GH382693@bill-the-cat>
 <be080a107555cdbad6828af2a36be013ec186477.camel@ew.tq-group.com>
In-Reply-To: <be080a107555cdbad6828af2a36be013ec186477.camel@ew.tq-group.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Thu, 18 Jun 2026 18:04:59 +0800
X-Gm-Features: AVVi8Cf_ohv_muqzDuNrkbdF8GwbtZ7sSWWbX4cabCIDZrAsceWU3wmaVc3T2s0
Message-ID: <CAA=k7=na+bmcMj5bw8rZF05eDOV0tfydzpSP_4BbDiEg_LhKjw@mail.gmail.com>
Subject: Re: [PATCH 2/4] bootm: use CONFIG_SYS_BOOTM_LEN for
 IH_TYPE_KERNEL_NOLOAD decompression buffer
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 18 Jun 2026 14:45:22 +0200
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

Hi Nora

On Thu, Jun 18, 2026 at 4:30=E2=80=AFPM Nora Schiffer
<nora.schiffer@ew.tq-group.com> wrote:
>
> On Wed, 2026-06-10 at 13:48 -0600, Tom Rini wrote:
> > On Wed, Jun 10, 2026 at 11:01:23AM +0200, Nora Schiffer wrote:
> >
> > > CONFIG_SYS_BOOTM_LEN is passed to image_decomp(), so the same should =
be
> > > used for the buffer allocation. Deriving a buffer size from the
> > > compressed size if not possible, as the compression ratio may be
> > > arbitrarily high for data with many repititions (for example ranges o=
f
> > > 0x00 or 0xff).
> > >
> > > Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> > > Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
>
>
> Hi Tom,
>
> I saw you applied a different fix for the same issue to master. I think u=
sing
> CONFIG_SYS_BOOTM_LEN is a better solution than trying to derive the buffe=
r size
> from the compressed size at all - isn't that pretty much what
> CONFIG_SYS_BOOTM_LEN is for?

Previously Simon also suggested using the CONFIG_SYS_BOOTM_LEN in this
thread(https://patchwork.ozlabs.org/project/uboot/patch/20260527150637.2850=
104-2-aristo.chen@canonical.com/).
It was considered a follow-up at the moment, so maybe rebase (and keep
the CONFIG_SYS_BOOTM_LEN) your patch on top of mine?

>
> Let me know how you want to proceed with this. If you want to keep the al=
ready
> applied fix, I'll rebase the rest of my series.
>
> Best,
> Nora
>
>
> >
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> https://www.tq-group.com/

Best regards,
Aristo
