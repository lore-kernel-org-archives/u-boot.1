Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9487ECC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 19:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B674B60B7B;
	Fri, 16 Oct 2026 19:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tkV2_x2b9l4H; Fri, 16 Oct 2026 19:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D187460AF9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792177964;
	b=L04OAhZTIQgqQiIz4u5qaDhzfXGEwVepmaLF37vjHfmOjHwR/EUPo6b1ap7TcWSRI7Ic
	 qNev77RjqnlcyDKh7HikUY35M6QQ707ax2eD7ytipUW6U9j0tmT2EezR3K7Hv8EDgW2oS
	 V1DdIIQ6GFFdCm1vyrz2Bfik+NeFVXvI4KL5PQHQZG4soCRd45FrV0vzWZfpy9FmY9Vf1
	 9QeGd0F6LT95RZQ4i7fnlyxU97udiY/QcOXrtVR6N9LtKO9dE+mm/KBOq3GXOKIaR7bKg
	 rO/03bxOJ62AZ1RaU0b0BkgxR5AGbc+4tcDZ0mzSkwaur46pG4pWtqFiDqlXrD/s7JQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792177964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Tsn2jv1+4AquEB3uWtdMKLN0WBHc2D4ArXEJyaTFbiE=;
	b=hPzHG07E7RZl0GFNNnGoiVEyQ+Kczn9nUM30sLN/kOOSqrIeDJJAKGh3rdwOvR5R3kUt
	 LN06UPYYVzGnZY9a5TKRaKD4huvzZ0y8HyQrASHiMm5us8lrE4wI6hoVMeL8lL9IsyZku
	 Ygou02rVF7CeZI72l7v0nVhZ6T3AnH+XYInr1ckc0z4PFQWqowVyGiWCzvZWqN5/z6yFc
	 x93l6t1RFBr4VwMXfBWd6YTh/h/NwFZXp7FEk0WuK+eoDQW4HA7WQ0a0hNu3fmcKnTSTZ
	 6iMG40cGzdeklyWHjfWekppePAY4YUMi+dMGT+oWgdf4OEAjd/fKZ9FBATPiEmQLXOQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792177963;
	bh=Tsn2jv1+4AquEB3uWtdMKLN0WBHc2D4ArXEJyaTFbiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l02klaOzrIdDOd3irhdQim3e3ZLK6Jjtt5NhrnSW/x6/M8qIAcxO5kc2/tLu1VUf8
	 p2wOCz2HXOG7+7Cjd3sxTHKud5ZYksgOAwjjJJ+mHXi3/NPfRWROi0X0TxiQlRw24u
	 vI0UP3W/9YSn5FK5hGTTrsiigZcSJbCnA+0rJ1+YHpXHOBHQnblv4de1cNJDDnh11k
	 QMscY4pG4nFPhVkol5J3lT2RBI0BVMBP2r9S6VbfPwqSPKg7I+82QRLznwm4IwiPMX
	 QjyW6oP95RP2obV57NSrz8qp9k/1mC5LNGk5qs6wKbEsdMXUoUwC5D6VfhAV3zIR0p
	 zHuxKWa3uA9Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D187460AF9;
	Fri, 16 Oct 2026 19:12:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 32520255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 18:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 242D440A16
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 18:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdJRILGe596m for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 18:39:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66E8340A12
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792175969;
 b=pEYy5DlWN3lFlUCDzoy7CgVj0IAkwHbyDDB5NRmkEGIEFZ49OOJJzxrUFl18jF0D3yA+
 bq6f2+Lavu+4VCwFGttsXgY36A6Nmf43cz7T9RudcBzYJizy6yAZQG0sbglpx3hZ9jBGN
 R/VWI4IIPDAPFsYlgNPfkDf5fGPLkNqJ/QyuV7MWvi9MUGuKguLi7k7Pni5qFect8KY/3
 lpyg+UM/y/Iu3aj0YTQHGlxMFltyw0Rv/ruri+LMBKYYqJGDYVxim7uzNXeLjhbgtavbv
 Z0SK9CAXqvzqPw58nNtL/WnxT19dAc3MR9xkbqMbfWQPKf2iMNKl7kN5GKmiNsbMu2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792175969;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Tsn2jv1+4AquEB3uWtdMKLN0WBHc2D4ArXEJyaTFbiE=;
 b=tUanVMreER7yCWmWPgAoJS/OtOasKQD695eQKUe2ouseSiHRYsNdW3ot3Y382WZXwovy
 DuV1ceLAjkaNXUlUp2fHPjkxEm73q4PYuxz52/BtgcczA9ZH5hEmH9wlrOnyDAd0jb00G
 aGPWbjpR/4Crp6qXCqfRUahYA/RVEZqVrxogNwgHGclMvwq2MLcShMWuShVDkwcxIRksR
 MNSIWCnVisrO8uWRMGUZ06Pma/095xSgXCNRDzFe5mTTbx2ZvoSKSDxVg22JYggHcD65m
 gRvE/rZvUJ18Zawbqta2ngbR8NOCYZrZsBoQFOy5w3z8+usniiTtDLMJw/19WXG169Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PjEQ7Nkw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PjEQ7Nkw
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66E8340A12
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 18:39:29 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e915887d9dso694205ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 11:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792175968; cv=none;
 d=google.com; s=arc-20260327;
 b=EnGOFIy4KNx90yrRnn+JE94kGarNgnvv13vbhaSYAOJ5LM49a71eDdepLpIwgTRoMG
 DUTY+tsZ06qaV4seiNAevluF6i4FskwMKQx2yotv0VDfaVfVuCBZgGKUe+QSfTPNmjXd
 dmyfbFrSewRfA/2bM+f1eJGgfZ7SOZ4yy5fsRBswfxwgKbPFOHF1jD23T2+s2HBsEVKm
 /NfqDJ+/5tKc/u+PyrhjGVHf6jdKvZUtuRVMNPgCYPU23STuSeAzSOhE8xwMJrD1N+Ma
 CUclZugddoYO7HXLV2qYj+QN1xiH5bM7RioII4H8S9usjyvTlDVIQXOtHLSTs1wg0Qrk
 jn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tsn2jv1+4AquEB3uWtdMKLN0WBHc2D4ArXEJyaTFbiE=;
 fh=eZ264k/TGzH+kcuy78BerazgD0H2t147tvBQmRVLa7U=;
 b=h5KG4Mmz3LMBHLdVB5pngeFgh8FfXV3e0aTILrHEVKCG/Bu5xLwSQ6KmM9QQhdIP1b
 Rej9nn0u7nKcrIEq7PM5neE51TFAqdZ23DifFdH1Zc55CK+FqVBavJ1TnlZFBeag3Bjs
 YrDBjqd65gcmiFpZqflZtfjtAEStJ4lsLMc/9lU48xRxhRkEYlXmBYxUGykcNKtPDLuQ
 cBeBg5ourJZqIXHh7ceS5iU5XZ1i+JhNQKTJ2hUyute/ZiVQoGMgRjQGIVPLVIeZu1e8
 g0bcGKO/2Zp9Izt3eO66EzR2Ne4jPkAlnVOxC0i7TyexSpC1H687sswOAujjuo7Bye8W
 ovUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792175968; x=1792780768;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tsn2jv1+4AquEB3uWtdMKLN0WBHc2D4ArXEJyaTFbiE=;
 b=PjEQ7NkwlkZWlw8ykOXE4YJgK5hzr/8gw9e5EFe/Iz5U7Yzm3lBGAmGPF9xeY5hTEE
 9o/SvlCnCBTHjPBQHDBshJNU/F9dHBZSbenfnsBqQDU0ghJerpBnRLOxG2imyZqX5Fiw
 xFDkzGk6MsZFcRfnzCWrxRK5Qvis55RIBIeKgAxHnPk+G0k9ti2xOwGLicraSrJU83c/
 1oqji4OAywtcn8P08cbDZYqqhmTkMF8h1IDEdvwiJ9+kEV3mddU4NfqzQIvmT6ApKgwN
 jhhuJXLL+WIVAq9Z+FFruxUN+LuQFgG6UI8N1qOAnaqUlNT4OXvD6AVv5K2xGe0Pavc+
 b8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175968; x=1792780768;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tsn2jv1+4AquEB3uWtdMKLN0WBHc2D4ArXEJyaTFbiE=;
 b=D84VH1uvMIX3HqatXVhkZEsmlGi1lVJc1YMUbYj8n3K/kbEIvbMRWdNAlkqySZey7H
 MHUNGJClZqxMN0z6wJ777vRygJoKFL0C1b8qz+tkZiqtYO7qy0FomaXlbCRAN3goMrrj
 exSObazrkJZDvi3J3XwBogYqa+T6yPHtmLRgIIIN4dpnOZq3fXmgc7j5DipA9ujSiJYE
 4XWoxu+bFpg5Q4dNJMc0FNwRJ6F37eICbOvaT4PZRVpEd3R6x7e6MEO5JgXMRrRJJwqg
 t6KDyk0oWodlpWvmTPGpuVWDMV4tOAveX1tCE1jyAkHWHtQ/p0rFiBMoJTAcGHP0RqUe
 UoNQ==
X-Gm-Message-State: AFq9FYJUEqnihpit4EsYE32X7XaKfrW9+BuEZMn0Cx5i9ft1DZW4ytsC
 qHX8gBRTcmYB45PDoAcyEmMx6MNgg53sN7ZiZIyew1IxpTAvThuhxO8Vez1wM9vaW2no5848jhA
 Hqtti/G2KA+K3vepE5vb9bD1/2EcLqzg=
X-Gm-Gg: AYBFou1GqkOFBWcjx+Kr8tfhu2t0dmXFzfmNaiLiwZVxOdG4AitbkLEziWkUDfS3OP9
 BmC14xE7HSqpdJb2QaipGOJoFtb/6tUIik8WYjUDKddYulRtFcoBNeW9u/PX3WOfG5Sgiq7uv6I
 1ZtHrXx4OlwB0IzRXlPIv0kGTe9CVaQ+GuNIRHzwCZNaC1Y2ng2egM3wI3N3BRzyS5bowmbkrTE
 8uwVoZAIgW/ZdEOGP+BjX2+zM8gfVx9JoAB5MoorD5OvOlrU49odr/TK0kP740CUNTD4W2WkQgx
 6rOYZUYJmYI3KZeH/gs6rxqSvLjT8Kl1cDslxsj39QgL1VxWiq+eNfls5xk=
X-Received: by 2002:a17:903:2f88:b0:2e9:95c0:7c50 with SMTP id
 d9443c01a7336-2e9a6d358dcmr7224285ad.71.1792175968210; Fri, 16 Oct 2026
 11:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261016091608.121842-1-pmazzini@gmail.com>
 <40856b24-1767-4fda-89af-11c51d3ec816@arm.com>
In-Reply-To: <40856b24-1767-4fda-89af-11c51d3ec816@arm.com>
From: Pablo Mazzini <pmazzini@gmail.com>
Date: Fri, 16 Oct 2026 19:38:59 +0100
X-Gm-Features: AclHuK97fQdsxo-LLtpVqDB2-wEBQEN3N0WwKDkjlh95fLPNrUGFWQ5krSDQ2YM
Message-ID: <CAAxh=jsqP4UwMFt02n-dsdf7FGTg18NjmHyVVk+McQ+LQBXSTQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] sunxi: add the Allwinner B288 and the PocketBook Verse
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 16 Oct 2026 19:12:41 +0000
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

Hi Andre,

Thanks for having a look. I'll reorder the patches and move the DT
bits to dts/upstream for v2, once there's more feedback.

Pablo

On Fri, Oct 16, 2026 at 6:28=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi Pablo,
>
> On 10/16/26 11:16, Pablo Mazzini wrote:
> > The Allwinner B288 (sun8iw10p1) is a dual Cortex-A7 SoC used in e-book
> > readers. This series adds SPL and U-Boot support for it, and one board:
> > the PocketBook Verse (PB629).
>  > > The DT is still under review for Linux. Until it reaches
> > dts/upstream, the last patch carries a copy in arch/arm/dts.
>
> Thanks for sending this, much appreciated. I had a coarse look over
> this, and this looks fine on the first glance.
> As you said, this is somewhat blocked on the DT merge on the Linux side,
> which will probably not happen this year anymore (v7.5-rc1 would be the
> earliest).
> But meanwhile, in preparation for that, could you please reorder the
> patches, so you enable the devices first (clocks, pinctrl, mmc), then
> DRAM, then the general support patch, with the defconfig on top.
>
> For the DT parts: please try to emulate the future situation, so put the
> files in the directories where they would end up eventually. You can try
> to take the Linux DT binding patch (for clock and reset), and just
> change the paths in there to point to the respective dts/upstream
> directories. This is what would happen anyway, look for those
> cherry-picks and upstream references in the dts/upstream git log.
> And the patch(es) wouldn't be taken as such anyway, but they provide a
> test base and reference for other people, until the DT lands.
>
> There is no need to send a new version now, just wait until you receive
> some review or other comments.
>
> Cheers,
> Andre
>
> >
> > Tested on a PB629.
> >
> > Pablo Mazzini (7):
> >    sunxi: add support for the Allwinner B288
> >    sunxi: dram: support the Allwinner B288
> >    dt-bindings: clock: add the Allwinner B288 CCU
> >    clk: sunxi: add the Allwinner B288 gates and resets
> >    pinctrl: sunxi: add the Allwinner B288 PIO
> >    mmc: sunxi: B288 mmc0/mmc1 run off PLL_PERIPH0 2x
> >    sunxi: add the PocketBook Verse
> >
> >   arch/arm/cpu/armv7/sunxi/psci.c              |   9 +-
> >   arch/arm/dts/Makefile                        |   2 +
> >   arch/arm/dts/sun8i-b288-pocketbook-verse.dts | 114 ++++++++
> >   arch/arm/dts/sun8i-b288.dtsi                 | 292 ++++++++++++++++++=
+
> >   arch/arm/include/asm/arch-sunxi/cpu.h        |   1 +
> >   arch/arm/include/asm/arch-sunxi/cpu_sun4i.h  |  16 +-
> >   arch/arm/mach-sunxi/Kconfig                  |  14 +
> >   arch/arm/mach-sunxi/board.c                  |   4 +
> >   arch/arm/mach-sunxi/clock_sun6i.c            |   1 +
> >   arch/arm/mach-sunxi/cpu_info.c               |   2 +
> >   arch/arm/mach-sunxi/dram_sunxi_dw.c          |  97 +++++-
> >   board/sunxi/MAINTAINERS                      |   6 +
> >   configs/pocketbook_verse_defconfig           |  10 +
> >   drivers/clk/sunxi/Kconfig                    |   7 +
> >   drivers/clk/sunxi/Makefile                   |   1 +
> >   drivers/clk/sunxi/clk_b288.c                 | 101 +++++++
> >   drivers/clk/sunxi/clk_sunxi.c                |   5 +
> >   drivers/mmc/sunxi_mmc.c                      |   7 +
> >   drivers/pinctrl/sunxi/Kconfig                |   5 +
> >   drivers/pinctrl/sunxi/pinctrl-sunxi.c        |  22 ++
> >   include/dt-bindings/clock/sun8i-b288-ccu.h   |  82 ++++++
> >   include/dt-bindings/reset/sun8i-b288-ccu.h   |  45 +++
> >   include/sunxi_gpio.h                         |   1 +
> >   23 files changed, 827 insertions(+), 17 deletions(-)
> >   create mode 100644 arch/arm/dts/sun8i-b288-pocketbook-verse.dts
> >   create mode 100644 arch/arm/dts/sun8i-b288.dtsi
> >   create mode 100644 configs/pocketbook_verse_defconfig
> >   create mode 100644 drivers/clk/sunxi/clk_b288.c
> >   create mode 100644 include/dt-bindings/clock/sun8i-b288-ccu.h
> >   create mode 100644 include/dt-bindings/reset/sun8i-b288-ccu.h
> >
> >
> > base-commit: 65a7532545336e4b73e049a69436e255da7df961
>
