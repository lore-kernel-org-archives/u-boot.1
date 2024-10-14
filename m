Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3DACFC500
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B402D88F6C;
	Mon, 14 Oct 2024 09:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GsTEDuts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D71A88FEC; Mon, 14 Oct 2024 09:10:48 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6914889C3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431291b27f1so14537015e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728889845; x=1729494645; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kc/WpUPRtz4XBALNS2VkyH5vjybfQNk1bhihMja3vVU=;
 b=GsTEDutsisVFdHEbhdDLrTYMTWTn7cdzWdyrHQyJ5Pdn1sq11iWn/47jnJAZTO62pM
 i/p+PYNEjj5oiLdFLEp6SGnP6YdreLF7j+gXk3gZ3vLA9fLQVeNM0gZ3CUv+zo/cdTL3
 0hfPv1QDZT39k2t5xMSQ37C+nyQHbl/NzwvMA+yZz0d8pCCObcdKle2MsXvYpoHbxcJk
 icr7xKk4gaCdG1wD0QLN/VepJppai4ho6jDgvb2k6hL1jIKuxNYHbtUPnhgfZzIA9L46
 P2iDzxfXeuuZFew1C1O4g5Ueb5MpR821KGodv69Vbz+8gQPCM+AHJMS94RDlGQgRQQSK
 T/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728889845; x=1729494645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kc/WpUPRtz4XBALNS2VkyH5vjybfQNk1bhihMja3vVU=;
 b=Yoldz0gV5KsJqNx9nUEOqvmdjceHmEn7vupRXBSoKDXoWjoTiXiBdhW3jzExQVCuHm
 yM/uT52Oazpzrct0aNPEiHH01Z0V3H+kuP7GpAd+Cqi2QvlY5+rqAYDZiMMmSobEYdSv
 hGCKPJGrPaRlDTFwsMI4ZWGKM+1v8bqW2O20YwRX8JyvN8cK6KF70tdRY/iqpqXFw7uP
 9oI7+jLusGom5xX9OJ7laZ7QgMascE/Qqy/rmt4bi5x+jch+w1riZFd/aaL5xm9yKpY/
 i8OCKupN8DUnEpfVBZ9iy7jOj4fvwR82PNf/2tDJUJkDUxHP8CmvuRLgLox7dP1V5q8K
 q9oQ==
X-Gm-Message-State: AOJu0YxLLUpxxS0czikghAi8kmKVq4L4cC8onqiy1DDUgKD1vawFeiUE
 pcxinD4eVHdIzUUs0WH6wYZcSAWNvJkaNL7/chaJYG+6wYYS9FnXiQqhHy4faFW78cOzKbZxxkF
 aSVGk8/eEVZCPrKtng2uxazpDtLkypQ==
X-Google-Smtp-Source: AGHT+IE6KKUmtnPFpXmOiixHoF/Np1L7XXJLmdbL9YHSbpV8nKesXoOuEYRWzm2hh9dmT9Azc2IpPm2gvqb8mROawG8=
X-Received: by 2002:a05:600c:1c1d:b0:42c:d084:ed7e with SMTP id
 5b1f17b1804b1-4311deaea1amr79682145e9.4.1728889845058; Mon, 14 Oct 2024
 00:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241013155604.87584-1-clamor95@gmail.com>
 <20241013215444.GA53053@bill-the-cat>
In-Reply-To: <20241013215444.GA53053@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 14 Oct 2024 10:10:33 +0300
Message-ID: <CAPVz0n1=sRB+7rT_BQaLRbhtu9SM5vShOZLQxEUbBmbvzS4ptg@mail.gmail.com>
Subject: Re: Please pull u-boot-tegra staging
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

=D0=BF=D0=BD, 14 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 00:5=
4 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Oct 13, 2024 at 06:55:58PM +0300, Svyatoslav Ryhel wrote:
>
> > Dear Tom,
> >
> > The following changes since commit 93b9cd792089e536f2bfa85d9903fd479820=
9f76:
> >
> >   mtd: simplify CONFIG_DM_SPI_FLASH dependencies (2024-10-09 14:52:44 -=
0600)
> >
> > are available in the Git repository at:
> >
> >   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> >
> > for you to fetch changes up to 711fcd3bdad52ba058e8ca3cf1673bf1b8299be2=
:
> >
> >   video: panel: add Sharp LQ101R1SX01 MIPI DSI panel driver (2024-10-13=
 17:33:46 +0300)
> >
>
> Please note that I made a few fixes before pushing this out. One of
> these was a merge problem,
This is actually an odd incident since I have rebased all commits onto
u-boot/master (same day I asked for pull, 2 hours earlier). No issues
occurred while rebasing.

> but another set were whitespace problems
> checkpatch.pl noted
This refers to migration of bootscripts to text env. Last time I
worked with bootscripts they were quite sensitive to whitespaces and
broke easily so I assumed that checkpatch mistreated those as errors.
Seems that checkpatch was well adjusted to check env as well. Sorry,
this will not happen again.

> and the finally a small mistake of mis-naming the
> apalis-tk1 env file (which is a - and not _ like the rest of the
> platforms from the vendor).
Thanks for spotting this out, I must have automatically used _

>
> Applied to u-boot/master, thanks!
>
> --
> Tom

Thank you very much and sorry for discomforts.

Best regards,
Svyatoslav R.
