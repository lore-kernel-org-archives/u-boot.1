Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C33C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 406FA80AD1;
	Tue,  4 Aug 2026 18:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOBgOzntcepg; Tue,  4 Aug 2026 18:13:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88D1880C6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867202;
	bh=2Qn8FsCy6qtCNQQ3HtETBH/+F6tgvl3fxd6bwd2i4z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDPIeDB+8h4j58deDEcEwqMNcD0DR61GRoQHI32fRe2eS1WUAQrr9x1gbz3NKy96O
	 O7YhQse6VXat56uz/00TfTVOo21kxg5d93/upr+AZ2D9npc1pBL9q3BRva+zzsT7Ru
	 7MaMhTbxDXik2BAQB4qKkltzASM3qSWi3/1THeEsvdU2S0ThmonfVIVWCj4zsxNEeW
	 oozLV4gYkd/QYcXrBWXP4jdKwedZysnxSAxJc4CzhtcQvkk0fiwadv1+wPsND0G7wG
	 Wia9OIcNNzMPKKv0z83jq8gK8TqVgyu4FwR6oUKWHXhhNjC1N6wqueJJRkIs7GYn6z
	 11nkwOcGo07Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88D1880C6E;
	Tue,  4 Aug 2026 18:13:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60A562BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4708A406FA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOYAtgJ2JJfe for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:10:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8C12040689
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C12040689
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C12040689
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:10:37 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so65571055ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852637; cv=none;
 d=google.com; s=arc-20260327;
 b=T+ZIwdMm/xcPggst+exQ8kY6tjGL/eKm0jwJR04EC1eUPxU5xHjySObYTeP3z+IvyW
 d8+EgQYqAnvKPupESwTnq50QYdwji2F1dfm12++mYZK09aFcX1/JMlYw5YBlC/IIs1F9
 yvURkpobShgUtKWg5wTGP6s9AVuDjAw0WqHxQvciK62Rvn32xoAXr3V/yEPcavO+5uzY
 FdzdSVL3efieDdx4Iw+vIhA/mIW6ZmV+PVUN363rfBk8JmuyAV+ikTzYI6KGugee6LMD
 MmFx0QVDk518QQz14nHIZ0CmGE3ERhBJeTKnTy70/Hnh68URZNrV3sS1TRFlrVn83J5f
 JDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2Qn8FsCy6qtCNQQ3HtETBH/+F6tgvl3fxd6bwd2i4z8=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=jAztmG2AlR2bxU4WlIJjcEdgMFL9Vv4fUkdXsArKbNJmmXrGjpTEtmwegKJ2hlw81T
 hzp5w0fGVYiesPyndB794JrHCq6jGjrEVp+JXYAs+mhW8kdYiWFPPwhTT1goWCEFVhQe
 ESo1uOeaQsg8Cl2iiJ8ac2EUqvfVU8BNNSe80NbwygRaAmqig+NRhgeXn4Dao8lNCZSz
 qhdOFc8KrpIWSZq9VWVBJWz2G+Fkc+OQzSVwNQ6s474bCl/a3LbixOCAZpVbD7N7pwiq
 bsCpFdUTqdW+RjwYNQGctJHRhlTn1gdGp/Zw7EKFv1eRUaStqm6hQfwCa3yPURy52Xso
 FnWg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852637; x=1786457437;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2Qn8FsCy6qtCNQQ3HtETBH/+F6tgvl3fxd6bwd2i4z8=;
 b=gVGOck4kEXYbTjUyhqlK5vPGgb+KF9E1avhCUbi/Pba4YZblu/Uj/l/2l31sQZJgCl
 iVo8ZIW1y1V0PRGzmsI9U4gYgGGVhLzS8wzUCjthI/fO6CA+77/JlNlgWGwXjSl5BB4T
 ZYJfyhULA3FQfYiNJRKeLGGLyVC31N39y7D1fo25PHg+v+DxpqOmR1VIj3wg4GKDRq86
 K58iShRBl7HMgdegrM2flZOUv8g1G0LsqDDKEp3LzG86a8rsyzNf0j8VgceSDAShx3L0
 INApzsbUl4KLqECNqA0CrVnggfqickCdfgwzhd1OBznc3wT17wcqLJgYuimf4U3mt5Lj
 UWzw==
X-Gm-Message-State: AOJu0Ywz+51uR4A96OVH5EheSe4cMkzjhfBzy8EFMCz7YuWQuvUJY4md
 Mrzk9AAVsPxYeykGFC98t5RYMp/27ng3mJZUrbc/pljgFR1mEVmQtN0xKh8F6UQODLhXefEdCaw
 h3hvR23WkjhQVkIUxCSXLPngGsSYMnZdk9dsmO4GABg==
X-Gm-Gg: AR+sD13I0VVWFZx+kt1FDwIOqsDXHcUMc+FFrpF/WTT/1madKcRcaa0lYP2D7w3ekB2
 KFeXTpaCk5cu7LND5GzymFGXGiiequS6RJx5yzJMKPqARcQ4c005rK1AR/vJ/GbyaUyhSFTU3cI
 yVzpSCoAUe/yje2RON6kmZ5y/zk1zOu8clmnYCA/V+f7veC9blE/eyb/MCKIMx6b0RQkyrF/ADC
 jpQUyySbQhVYyGox8Mp/UlGfH8lyiwhcaNZIUjnWpwQpVzHd0KCuXZtTBu2jfp4GUYfqDd9PJ93
 utGmKfqG/kRU7POW8RKHUSpVWApuWmR+dcBhWaTyUTXwepikMCOvZU5exO3VcpaUtzDxT4Ee3Z7
 vtFm6p1dY2sY=
X-Received: by 2002:a17:902:d2cf:b0:2ce:93a3:c168 with SMTP id
 d9443c01a7336-2d0521a4f6emr139213175ad.7.1785852636757; Tue, 04 Aug 2026
 07:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-4-acb97c172993@flipper.net>
 <CAFLszTgVmR508j5h_ncKwUQT3T1_ZW=wCctrBut2+hf-qr13sw@mail.gmail.com>
In-Reply-To: <CAFLszTgVmR508j5h_ncKwUQT3T1_ZW=wCctrBut2+hf-qr13sw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:10:26 +0400
X-Gm-Features: AUfX_myBrdVaflsYrWtyGNAHU-mWhf09-PwQMUyyo_60yVJPslvJH-YHdMeVTmQ
Message-ID: <CAKTNdwFZfV=XL8FarjJq+A4Ubrh2N182NK_Ee+Ju3GCc015jog@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] binman: Add support for externally provided
 Linux kernel blob
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785852637; x=1786457437;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Qn8FsCy6qtCNQQ3HtETBH/+F6tgvl3fxd6bwd2i4z8=;
 b=zWoPfz+LmN7kVW+f8nckjo/S2bXXlW+KmIFTW8zVOMw7EUiZ+ygZfnE6Dwr4/Xj2zG
 ZjqJWxZ+fx4uVX0mJZlDlIW3SBFIx0b47rJOYAcDChkV25MFy0kaHcL0GYsY2iXezFmW
 f67sAtdUepF5CYtDsKynepWBfk3lW/8NpDR67M0uuACm2YTKpFtPFu64gvkhQr3KiEwl
 yDEaWVp3cYORB87gJRApzEANaKRtW4nR6xxOvlyp5hKg95/ododdxeQGPn7k8bgglY2E
 vGXnAWZ+4AbFJkIqHdoPMBDi3sUSJwkfYxfNNqwTIawNykxpuX/9c2xUC7lmGFJlAQCo
 TEEA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=zWoPfz+L
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

Hi Simon,

On Tue, Aug 4, 2026 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > binman: Add support for externally provided Linux kernel blob
> >
> > Add an simple named Linux kernel blob type to binman, activated by the
> > "LINUX_KERNEL" make variable. No processing is done on the passed blob.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > Makefile                           |  1 +
> >  tools/binman/etype/linux_kernel.py | 22 ++++++++++++++++++++++
> >  tools/binman/missing-blob-help     |  5 +++++
> >  3 files changed, 28 insertions(+)
>
> > diff --git a/tools/binman/etype/linux_kernel.py b/tools/binman/etype/li=
nux_kernel.py
> > @@ -0,0 +1,22 @@
> > +class Entry_linux_kernel(Entry_blob_named_by_arg):
> > +    """Linux kernel image blob
> > +
> > +    Properties / Entry arguments:
> > +        - linux-kernel-path: Filename of file to read into entry. This=
 is
> > +            typically an uncompressed ARM64 Image.
> > +
> > +    This entry allows binman FIT templates to consume a kernel provide=
d via
> > +    make variable, similar to how BL31 is passed to atf-bl31.
> > +    """
>
> Please drop the ARM64-specific wording - this etype has no arch
> dependency and can hold a zImage, Image.gz, vmlinux.bin etc. Something
> like 'This is typically a Linux kernel image such as Image, Image.gz
> or zImage' reads better and matches the style of atf_bl31.py, which
> just describes what the blob is rather than how the FIT template
> consumes it.

Fair enough, will reword, thanks!

> > diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob=
-help
> > @@ -32,6 +32,11 @@ If CONFIG_WDT_K3_RTI_LOAD_FW is enabled, a firmware =
image is needed for
> > +linux-kernel:
> > +A Linux kernel image is required to build a Falcon mode FIT image, whi=
ch
> > +lets SPL start the OS directly instead of U-Boot proper. Build with
> > +LINUX_KERNEL=3D/path/to/Image, or disable Falcon mode image generation=
.
>
> This ties the generic linux-kernel blob to Falcon mode, but the etype
> itself is not Falcon-specific - a user could reference it from any
> FIT. Please reword to describe the blob generically ('A Linux kernel
> image is needed by a FIT that embeds one =E2=80=A6') and then mention Fal=
con
> mode as the typical use case.

Sounds good, will reword.

Best regards,
Alexey
