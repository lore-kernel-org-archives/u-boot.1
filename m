Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B680C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C72288EEB;
	Mon, 16 Sep 2024 17:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F9gUZSdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8961388ED9; Mon, 16 Sep 2024 17:41:36 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6347A87DC7
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a9c3a4e809so316638985a.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501292; x=1727106092; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UD0LyiDwxju/GX0u4ElVAJ/9aIhwrpfl8zDCEnggOb4=;
 b=F9gUZSdd5PAjjrwJbt4usazZ2Ez1R7xio/+7Ak6pb5Wcj5BQs0c6UaKv+gztNf8/dK
 OaA/OL8IKbAs1qyDF98piK8s+rvjdzr3R3KiHflCrv5YxCbBX2u+GSO8eEtJZFDtCTh0
 JFNaOMDDDl0cKNesNKev9mP3vY2KmyfVFdz6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501292; x=1727106092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UD0LyiDwxju/GX0u4ElVAJ/9aIhwrpfl8zDCEnggOb4=;
 b=qQ2OQUgt8TWG7YJFylWMpfK40fbYZP7pI+mZkpEdz5dseWGoztqxNPhskHsmjWmWrk
 P3ycHCs+51V41ceI/1GUvMQIFbhAWEtPRV8Pe9c/YYlC9RfVw7WPKaI+HUgNMIgdzCpa
 +qGZmUlCyOWltd1GiBtd3/AsVCi75ji9ABYTDk01xhpL/LgkqC/TmzYPDTVweu+XjGws
 mQxCyz2wRcMsDaTXs7T7M4IWvE7tw+sRQwbWGzlBg5104+7ToGnjnhh0kdByOKPWhatt
 bsfDpRcqVyNNmfQDp5NCupOI8jw94plVZNVrEIgiIso3WxGF/N0uuAQyaClk8vCCutu9
 iyfQ==
X-Gm-Message-State: AOJu0YzGnoSSmfesSagt08QS369OxrHunNfgQ4fdysECuYFWT1mEApuu
 2LP6fO7FO7eSdEm/bVyclMJIQKmmc7a02TCPsUnQY/eaAzlB7CN1IlBpc53e5HSEbTzGEQIo0zK
 jsN3WILJkYD3V6wDISBgea1cB+dxcYqrNAoIw
X-Google-Smtp-Source: AGHT+IGPEwUoQ9WWbFS8dEcNdcUnY4d9P4LGm5tr83ZyUVCI+aQdfOeuk/HKmgqIpR2YVITCmtjbJozyDabb5i0eeIg=
X-Received: by 2002:a0c:fbcf:0:b0:6c5:8125:d7c2 with SMTP id
 6a1803df08f44-6c58125e162mr147413046d6.26.1726501292174; Mon, 16 Sep 2024
 08:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-21-patrick.rudolph@9elements.com>
 <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
 <CALNFmy3cDCTzppfr5y=sAjKn0eBKsHPq9LD4zGg0KC9HT3qNMA@mail.gmail.com>
In-Reply-To: <CALNFmy3cDCTzppfr5y=sAjKn0eBKsHPq9LD4zGg0KC9HT3qNMA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:41:15 +0200
Message-ID: <CAFLszTj+S-d64cx0O1SqPjq_OTePr5Z4Cq-Z92xRqs7_rbWStQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Thu, 12 Sept 2024 at 00:31, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Fill the MADT table in the GIC driver and armv8 CPU driver to
> > > drop SoC specific code. While the GIC only needs devicetree
> > > data, the CPU driver needs additional information stored in
> > > the cpu_plat struct.
> > >
> > > While on it update the only board making use of the existing
> > > drivers and writing ACPI MADT in mainboard code.
> > >
> > > TEST: Booted on QEMU sbsa using driver model generated MADT.
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > ---
> > >  arch/arm/lib/acpi_table.c |  1 +
> > >  arch/arm/lib/gic-v3-its.c | 89 +++++++++++++++++++++++++++++++++++++=
+-
> > >  drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
> > >  include/cpu.h             | 27 +++++++++++-
> > >  4 files changed, 141 insertions(+), 3 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Are the GIC values available by probing, or are they just 'known', and
> > dependent on the compatible string?
> Sorry I don't get that question.
>
> The "arm_gic_v3_its" and "arm_gic_v3" driver uses existing DT
> properties and should work with all existing boards.
>
> The madt_gicc entries are board specific. Besides the mpidr all of
> them can be 0.
> Those entries currently do not have matching DT properties in the CPU
> node that could be used.
> Some of those entries are present in the GIC node, but there's no
> direct association between CPU nodes and GIC nodes.

If they are board-specific then they should depend on the board
compatible-string, assuming they cannot be read from the devicetree.
The properties should be set in the driver, though.

This might be the sort of situation where the GIC binding leaves out
stuff and Linux fills it in from internal data? Or perhaps Linux just
doesn't care about these features of the GIC?

Regards,
Simon
