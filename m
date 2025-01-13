Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5881C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57016805DA;
	Mon, 13 Jan 2025 20:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FJMyFWLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2F280619; Mon, 13 Jan 2025 20:05:03 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DC1F801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 368553F370
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736795096;
 bh=gLU1M2y0ODphu6OvlcEDBEtiYIYt2OWRxOWuR6Wrm8k=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=FJMyFWLXjeeJ5H48H4hE3rQDyIV8jN7VAvuIldjrvrnMceGmRes4OzTg+jiCoYgNA
 MqeVLV5KHCy6lEZow95ZRHuYxQxFfF53XQiNbvhpvtx7At4PG5+CeBus0DxPxZs5pI
 D6ChvMPNq+J0NHNPDFazcS/tpocArQX/Np8UPFIJMjdUr66bFRAGpnRwrJyDHoYYEP
 1XFyTqelLgG2z0Tr6bKEwfaqhgXkpZTGdEdp1Xgf9nsVoQYExZCY/rMdWt9arY0O/u
 hNRXQIaGRgBe94TgmQAYTzjzfROg8tPfLA4xgEqNlFsXhjWaknIGW/Yb98+j0Osujt
 Qrni4fnLbo1zg==
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef7fbd99a6so7993943a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736795094; x=1737399894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLU1M2y0ODphu6OvlcEDBEtiYIYt2OWRxOWuR6Wrm8k=;
 b=ThLYWUJTs/Fjy34/tBl5UDaEhFtQO3rqOdUnV3Y9XsKBC3mmb9TnxCapHqYujOyJYd
 vA9oFh9BjNNni29fCcoKhp0/ncGs/+CsJJ8vZsHhLzMYP9BCH4Mq+pBb3uQqwyyMI9h0
 uxHJXMxazIwSWKUq3DxU/4PbpcPJDkyFdUdXM9VVpUqVifM5dkOeik5z56HJJdIMia4o
 A07eLzQB/QB19AcS7eYuKsw0PGGjVjwz9kFES+8mH99+vDPKqloI+i1DYcNOuJ4A0lvw
 HhJPHzrATfsTrC2WmbMYQWHrky8a+VBPMIt3Zi7VqGsnn+4/GjK6krbxqkcRroDNbHil
 uX7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeIhfMsKC62Nk92dnuoZQNSp5OBn22vNX3v4nQQQxdJc0BieXGyuf6GcvPZU4FTHdNXQECnAc=@lists.denx.de
X-Gm-Message-State: AOJu0YzhP9AZLKjxkW4e6BWXMmq/ju1YvTLm9PvEk7hxGvm/z5+xuSTw
 GCEKgrydolwsaTYfGAtqXpO2gWKy+Dhq/tF2XVRpsSr0Cbv6cbYbO0xSM5/iCaNCr44za+00/qz
 tzuXNAkBn1I5zudBGvOBSn2pJEWXdBFrbeqKpOUUln2g/nAEmINXea1WL5b66t61Yb1Vu+y0fb4
 8AGTKKBY7/+zPDw9caCcfWFCQAKAQ+akhmuEzjmxzUBw==
X-Gm-Gg: ASbGncvibyXiyeEfay7sPE5kzyxLLPkQGoPQKrIFmSbFOFjI1805wie9ZheHHn3l3kn
 /V2pmp4FMGknMz1Tnts4mmv8SSYQOkMLeSuw=
X-Received: by 2002:a17:90b:534b:b0:2ee:b66d:6576 with SMTP id
 98e67ed59e1d1-2f548f448d2mr30724076a91.30.1736795093936; 
 Mon, 13 Jan 2025 11:04:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtW45VNOWAJTxcPmR3hNDkNmGFPTFESiBygNUvK95VSCQNDvu3yzMBVsjic+bybXkCeJxOYWB1tKol8MgzTBI=
X-Received: by 2002:a17:90b:534b:b0:2ee:b66d:6576 with SMTP id
 98e67ed59e1d1-2f548f448d2mr30724015a91.30.1736795093410; Mon, 13 Jan 2025
 11:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
 <20250113015108.GT3476@bill-the-cat>
 <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
In-Reply-To: <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Mon, 13 Jan 2025 20:04:41 +0100
X-Gm-Features: AbW1kvbOyKWc4auHKqclYXVRJIbwpmMxqhIIm-3mWg5lwZ-6NoZ2bKz5SAXR_uM
Message-ID: <CAM=mAOkhgPq41RXKpiDViGYmmDVpDAe_sastXvtMp_Bqyad-bQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
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

Simon Glass <sjg@chromium.org> schrieb am Mo., 13. Jan. 2025, 20:02:

> Hi,
>
> On Sun, 12 Jan 2025 at 18:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt wrote:
> > > Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:46:
> > >
> > > > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:
> > > >
> > > > > The bootmenu command can display
> > > > >
> > > > > * menu entries defined by environment variables
> > > > > * menu entries defined by UEFI boot options
> > > > >
> > > > > Not in all cases showing the UEFI boot options is desired.
> > > > > Provide a new parameter '-e' to select the display of UEFI boot
> options.
> > > > >
> > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Signed-off-by: Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com>
> > > >
> > > > Very strangely, this leads to the EFI selftest "Executing 'random
> number
> > > > generator'" test failing on Pi 4, where was was passing previously
> (and
> > > > Pi 4 has an RNG, unlike Pi 3), and this is
> > >
> > > Do you have a link to the log?
> >
> > Here's the failing part:
> > Setting up 'random number generator'
> > ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' succeeded
> > ESC[0;37;40mESC[1;34;40m
> > Executing 'random number generator'
> > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
> > ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol not
> > available
> > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
> > ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generator'
> > failed
> > ESC[0;37;40mESC[1;34;40m
>
> This might help make the log more intelligible.
>
>
> https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.4191404-37-sjg@chromium.org/


No clue which problem you have to read the log.

Best regards

Heinrich


>
> Regards,
> Simon
>
