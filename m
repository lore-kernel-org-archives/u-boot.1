Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7608AC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 03:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 234AA80D7C;
	Tue, 21 Jul 2026 03:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFCppuCcLUxN; Tue, 21 Jul 2026 03:36:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1E8680DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784604977;
	bh=59FF+/RWQ/UIs/26KjpBeYutiuxrZZr1CV0MIjor0Os=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PqrUDgZLXuHActUmCsJeS/Ukt9Sljs+Q8f55Wmxp91ZikkQ07OO8UwORs2OiVCRJf
	 utM9Jtd/5rJBuhmvwINwMY0JB9H+goBmrEPojQVwKuYd5aEp539vFcNoZTKkToXC4a
	 08l+kPdcHx7E3seCfyxjBtcOinBjKDQW2fqmqqJsohGBcxpRJ4RwRYHJXAM9x7B+UB
	 32MKOLnIW8NBSjVn2l+4m/baEsdes8Su9DJsxbu7fXU+VD9ucYq1aJUtvdfX8Jegn6
	 Eqb5q2J7obcmLfhJdPPdz1wXs+XC9SC+KpGnYzu41M3bM14QvjYRTv4J6i4CcrrXLR
	 r+Sh9tWYqFbTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1E8680DE6;
	Tue, 21 Jul 2026 03:36:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB359313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8A5C6078C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cz9yRiWkG6i for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 02:17:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=prasanth.padarthi10@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A86CD60718
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A86CD60718
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A86CD60718
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:17:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EEC846A5; Tue, 21 Jul 2026 04:17:02 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C1382991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 04:17:00 +0200 (CEST)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7ff05e5d009so128081337b3.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 19:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784600219; cv=none;
 d=google.com; s=arc-20260327;
 b=EHU4qivogf38QAvE5X0EoaRI6EiM6djo4SufNRvmC9yIw/oozAQZP0XO58OXeoYVH7
 fyICAsBAl8RUhGmmFjNYL4rarCGivXxy+96XP0CZRlZiSNu6kHo6YL72lzahCCO6n1th
 pG56vZO9piUZdtVUnTupc4z10ECX/UgOxOW2g4tyQzlOIZEDqBdeW2lJ+QeWswokChZ+
 /wXLf7jXmu1siVsCfnHIxLdGhYbQQlxsrSaXoe3aKi2d7ZmevkLWliN8n3R1not8v9nV
 Rkwi5ylORtsZzGO7sBat1oKovkg2alOmGXEBdz3p9Frz9sPnU2siXYRVW1rvoWJ08dUt
 U17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=59FF+/RWQ/UIs/26KjpBeYutiuxrZZr1CV0MIjor0Os=;
 fh=bDg2OS81l4ingJD/xvkwbp2ojJ3rSXUN64BY01XUFrQ=;
 b=RopSv/eD49PKuhCXGBZ5NN/YL9dwuqtDXgzfY8ryI8GPA5OGWoLdffeBHJV70gLyRv
 j+r87nLhWAQZszcffJyfrdIMk0QKf7EZ9OK58QnOMNvtKP6Bws6mJqvYBYOFF+UkaK2t
 T/liCn/5MKkgCSLW1IpKL4/ndaUcULIShXRVGK29G5l91ZwGrsmE7j9mhJQBCxj6uapo
 SHDZJ6kjrbbeWDhxMGOgbjJfCwe/iPtoWyne292+ik5cXPp6ci9HdQJODHxFmvlAFVwO
 Y6lviZFsPaooSzmrqFGIlnv8n3iekcBoNeets/jmr2lkkqGYF8RW37UnBHLMiu4C5NVr
 nGuw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784600219; x=1785205019;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=59FF+/RWQ/UIs/26KjpBeYutiuxrZZr1CV0MIjor0Os=;
 b=JEyZ+ly5Xb057xwlXZWwZHHLEb6JXTkxhTqOdbHXve6hYXHn9DVajxe7pyUklXE6X4
 UPyOT1JmuOBro/U2bAzhCRXd+HhEXbzNz7DJI7uSKXbRpvkQx0MELysQwhDnnJAyLhRO
 TO9NXIJwv8z8MjHBLXvf7GiRyAgLUGV9jX95Ob49kBn5M1ip5SjkEK1ZvHMjLm3LQdee
 kniEpJ61/oV5LBLiOL/2Bj6IaumkedTsZWn/thKpWDvPOgukEFAArMMTbOyRJ02RZ3h5
 jEMNHeWNiWeeoWx7tXzOmyGcJIvO9frRjRpewZAyj/e5LYasKAPmtO8h0n2JECLalDGd
 bEdw==
X-Gm-Message-State: AOJu0Yxtz5QE6AsniJwRQXpEjI0hxMCqILGagFAPoHaKnO46+pPS/1Ge
 ip8Cku1Wv9vtkG+XBhryXbxifKIPAU5BUui1oY00hD3XTjKD9F9sEwmimLk03qTFX8dF8nVqagw
 npeUYsKg7Gcqx1gZBuyID4EmzaVamTmg=
X-Gm-Gg: AR+sD100zMa31ILzsPRgmr2PnyXXPGGWAUtYvbz4WGL9x1D+/hvah4zM8gFzwWQEtCR
 oun647lmFMQupo5S7SqO/p7DPni5ICASyopemn7o1iAfImbxnjFrfqItBen0Kzs408CfZzCXWWR
 6I8kKgLA64988bpFGIM97+4JDWoU2TafXeVWZu/HkdNQhLhPJbA0k1H7RXUxj/RwF0ceeF2mIyr
 839U1XPjL/W3gBosYQoxjwtZcvOGYZzHhQVWckDHR7yo84ldPQLBAPJTySZikKV
X-Received: by 2002:a05:690c:2605:b0:81e:6f0d:8e05 with SMTP id
 00721157ae682-81ef280191emr53352527b3.43.1784600219009; Mon, 20 Jul 2026
 19:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260719121752.88393-1-prasanth.padarthi10@gmail.com>
 <20260719121752.88393-2-prasanth.padarthi10@gmail.com>
 <20260720193052.GI749385@bill-the-cat>
In-Reply-To: <20260720193052.GI749385@bill-the-cat>
Date: Tue, 21 Jul 2026 07:46:47 +0530
X-Gm-Features: AUfX_mzjLy4a8U_wsTCYLqom92I4s5wRR0EZ1XQes5BX9rB9IoE36AvD_S0_AhE
Message-ID: <CAMFFDGjzvd0vv=tOEFwV+FgVvuNvP+gnn=abSJ0nRyk42qoR1g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] arm: aspeed: Add ASRock Rack B650D4U BMC
 support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ryan_chen@aspeedtech.com, 
 chiawei_wang@aspeedtech.com, BMC-SW@aspeedtech.com, joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 21 Jul 2026 03:36:14 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784600219; x=1785205019; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=59FF+/RWQ/UIs/26KjpBeYutiuxrZZr1CV0MIjor0Os=;
 b=Hj+KcOes/gLVKEJ8AMmwt8yu/KAXKNntMC1zdbTnSN2v+pEePQYxGhAjpPxpxtlxNi
 E49zJFDurRpCxE8noIvVMvoofufF6nIuFWEfsmoOQlPuYF9S4NQ67LSlQ3s8K5mRf7/U
 z0L6HinZMb3xbAh+lIv9ao7lFVP3t8br+nUFotFIAdsyotPQNQGz1cyrwxepfGZ0kHKl
 2XbMoUoWsFR688FQ8a+yxP4T/TO49Iyob6wq4W3yTTp7SGHJPipewSto4QYNLk6FOQDm
 7DhT8PrnKiZlPkGVxN9sNZ6o2p2oTx6GLqrezjPc4KDRyszKYkujohU4FWd82hsG0jUJ
 2Qiw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Hj+KcOes
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prasanth.padarthi10@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hj+KcOes"; 
 dkim-atps=neutral
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
From: Prasanth via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Prasanth <prasanth.padarthi10@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

Thanks for the review.

Yes, the B650D4U currently uses the existing evb_ast2600 target as a
build variant. I will move the B650D4U maintainer entry from the
top-level MAINTAINERS file to board/aspeed/evb_ast2600/MAINTAINERS in
the next revision.

The board device tree has also been submitted to the Linux kernel as:

[PATCH v3 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

It has not been accepted yet. I am currently addressing review
feedback concerning the RGMII delay configuration, SPI flash layout,
and node ordering, together with hardware validation on the board.

I will keep the next U-Boot revision aligned with the corrected Linux
device tree and retain only U-Boot-specific properties in the
U-Boot-specific DTS include.

Thanks,
Prasanth

On Tue, Jul 21, 2026 at 1:00=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Jul 19, 2026 at 05:47:52PM +0530, Prasanth Kumar Padarthi wrote:
>
> > Add U-Boot support for the AST2600 BMC on the ASRock Rack B650D4U.
> >
> > Describe the 512 MiB DRAM, UART5 console, watchdog, 64 MiB SPI
> > NOR, RTL8211F-connected MAC0 and RMII/NCSI-connected MAC2.
> >
> > Use the existing AST2600 EVB target infrastructure and a
> > board-specific defconfig.
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> > ---
> >  MAINTAINERS                      |   6 ++
> >  arch/arm/dts/ast2600-b650d4u.dts |  74 ++++++++++++++++++++
> >  configs/b650d4u_defconfig        | 115 +++++++++++++++++++++++++++++++
> >  3 files changed, 195 insertions(+)
> >  create mode 100644 arch/arm/dts/ast2600-b650d4u.dts
> >  create mode 100644 configs/b650d4u_defconfig
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d4b527560aa..52aefd17217 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -213,6 +213,12 @@ F:       drivers/reset/reset-ast2500.c
> >  F:   drivers/watchdog/ast_wdt.c
> >  N:   aspeed
> >
> > +ASROCK RACK B650D4U BMC
> > +M:   Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> > +S:   Maintained
> > +F:   arch/arm/dts/ast2600-b650d4u.dts
> > +F:   configs/b650d4u_defconfig
>
> This should be in board/aspeed/evb_ast2600/MAINTAINERS since it's just a
> build variant. And is the device tree itself being submitted upstream to
> the linux kernel? Thanks!
>
> --
> Tom
