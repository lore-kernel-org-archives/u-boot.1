Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B66C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 14:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB22C406DF;
	Tue,  4 Aug 2026 14:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyN_nb4Pc2Wh; Tue,  4 Aug 2026 14:19:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0024B40689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785853188;
	bh=Ft7sQxWFQczDCyKC5sxGCMgK1WDDQKqXoVf4JxPq0AY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u6t/c4y7xJwRnC/wN2WS636hohB3jzlu/i8Dr9M6CS/HmLY8qsJeI4DzG/Jnxv/Bn
	 BvJs9zjrtjQdIK1G7u9INrf80s4R4cj/yJFyOQZdCyN1/RjqOWIHtbym/tHE3Tajpf
	 B23KeqNnVeVbaRJsUPHPCBiGhscEDpKxpeUXDwsRCCGABE/8T2v5BKCDgESxzNZAZU
	 f/BndXRUdMilIRXT8Ah5J64mS5wjQVbLc/FoKJMZDnjNY8vixmytTpEzNn+BnQeBUw
	 aARexa3B6LeIIb0JryxaBzHb6HSor4pV4n/EZTFG5rbnGOiXPuPH8+X6gZMP721HVi
	 8y12UZ+uJG9ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0024B40689;
	Tue,  4 Aug 2026 14:19:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94D032BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BD52808FC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0vwt9kg7CER for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:19:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8C33980897
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C33980897
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C33980897
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:19:45 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a0ddef4e35so3755578a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785853183; cv=none;
 d=google.com; s=arc-20260327;
 b=eV9pq5Um9t1jIgFfwco+/NcXsO44JoGfQ3bzVLALZciIBWrx32mX0L7ct8gfdBSrOW
 QxBk6JDmUxyQyq6lfN+dSC7HM4EfA2ofUxNgThBXNQjPa9NSGHy5vDeDhY22VJOmgx3g
 j5QE8ezE8rHH+w6oxtdp5JP72/dAc3dA3MTMK4e0BX2RDcUjUfJqdTe9AVTmBY7RNm3R
 JyQBI0U7rXKRKmWRQ2o/ezpYr6L0AS96tJ+DZSrPNL4VeMs/dgpLvZBhCAR8JZO6Ynyz
 LgvZUgVEjMiDeu3Oa8IFM+D1KS2ERu9P/MGgCw2rGYDXpTXUs8d2llrD2dgAR8j3Fddh
 tf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ft7sQxWFQczDCyKC5sxGCMgK1WDDQKqXoVf4JxPq0AY=;
 fh=AoNDlqHiLXFM3sirz/Mf6lJPiseuj3z/NCngJYk0cNM=;
 b=pAKaCzx5lPoGTd94U7etSkZIKJDv93RoZWXqkyCMReWFruXlfj9TODG3s2xBtGD0l6
 /ti1gTqhuJbAuyp2ZYyK693ijAJQzOMI7oQVrs23jGLu0MRtyNJoogJAdNxy7nNu8x0L
 iU/PzBW5yV2Q2R+RRDA+FTL2QUEWXO2jY4EiULht93m4aG3BoLQeozF0JVyGRiYjyDBh
 1GbcOft+8NW2Xg1AULbSknOhlL1qmgQJd/7Mhjuethy1VYeGv+Zfph+m/Dr+irhBhjuH
 sQ9qVR9YlQd1ET7vD58BSA3L+ZdtxD1XGna+vrLs22DlEU5WZnSCXfspQvn/TSZzhhfI
 i3Jw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785853183; x=1786457983;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ft7sQxWFQczDCyKC5sxGCMgK1WDDQKqXoVf4JxPq0AY=;
 b=lnI+emkbCN3NWP0Ltr9U/c5qMLXlZLLYIO2+1w3VhEGBtRo6NBBFQCxe9t8GNWiW2B
 RUQewxgKwK1YU6F4SqM0rey2PQbNEeWiw7yJJuTaRmZCeF4iR66cXbe3Uepwa14wM9yb
 x80v9aWsw2PXfzZwq9rkYwR/pDY9RPB6GMqrgy0gZ3D8ZRaYoMRyNmho4MgZNjuL8p0H
 9errO1tbt8/yO86LKrBk+z8+e8mZQ0UT1Kv90CvnkGbXwOH46bexYHHXZDnfMG/wBKfE
 xrhV1sinA7LagA15Fgx8xvMNvxFQsaJ5ptsLwwgpJL9bMPV1CRUNT5KePT+VukaVxzW7
 bd1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSOUFXjn/OD5NY3+sayZSK2EwJJBwEpKvSHNdoX9y/ErqliOMUDqx5XgksApRKuVSJFL5s5x8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzCBgRHqB4+l4XLQKHSPTPDXsEnbQhtq3Vnyg+J5Ux1ZevgLLMH
 tuN4xVnwcX91OJ4jECuassTcuQVkQQu1HUKlYz3GJBSsM1Wsfpngw8GB4LTCVxsvE/pJTA0xT8Z
 fve305kushlr+FmALj4nJ8ROWdCJ9sU3Qzx/y9Y0m
X-Gm-Gg: AR+sD11RbYz1Vyav4OURDNzLz5nVBFhlH4MOY9Zo7IVEeF7wOtWA6lbJb1OPxhrsKK5
 kYyTbrjIg/wx2qUa1Z+KrA/mF9zgc71u0yA+bPsqhgp8bLHh2y88xRpuXJlzyeIJS4lg6QsXeU0
 tPyAHoZN/QJqdZWPBY8Ri1vLeMhuXC9HqEOh98OGNpvkQ8WqYk6NBkrszU1z3JJCDhZfwcPA9A+
 hqjJoDNTyreGKuPhrs4r7GSn+6F3t4xaHxXPiyd6z1Heb+1DcGfdQHs7qRBjl/kgyNY5Ai3W5wD
 H2FQxSEiiyIk/oMug+X2bgZaNpZA4GwEALlKBXyNvF2gNpy1tCkQk0U=
X-Received: by 2002:a05:6402:21db:b0:6a0:9b04:bf76 with SMTP id
 4fb4d7f45d1cf-6a0a7ca9b0cmr12163822a12.17.1785853183196; Tue, 04 Aug 2026
 07:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
 <CAFLszTjo5j7w+qzrruYZMXELu_3AP_Gt3wbneDiFP5-imPgNCw@mail.gmail.com>
 <anEvOBzdib3UrhUj@eberman-5690-nixos.corp.anduril.com>
In-Reply-To: <anEvOBzdib3UrhUj@eberman-5690-nixos.corp.anduril.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 08:19:29 -0600
X-Gm-Features: AUfX_my7dsTBr1Jfxmb6E5FEX_XfmdkUXoRHAAjeijSemhud_YGrJ_fBYrFxxis
Message-ID: <CAFLszTiF=SVQKu90fhHrk8hWfhsirwv=h0wB+mmfUNtvBpvb0A@mail.gmail.com>
Subject: Re: [PATCH 2/3] qemu-x86: Wire support for applying capsule updates
 to pflash
To: Elliot Berman <elliotjb+anduril@elliotjb.com>
Cc: elliotjb@elliotjb.com, u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785853183; x=1786457983;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ft7sQxWFQczDCyKC5sxGCMgK1WDDQKqXoVf4JxPq0AY=;
 b=hRex7Xf1eHrb/PlUBEp7MeLYY1PQA41UmT2rDfhRhC+cDN3jD2mnc/UZcfiC+alB5e
 1//e2Oty0YsZIpgACuiRriRsUdnMUX/FxuRSzT+4gJzeeDDK1D8Prm9Jo64n5lZGmXNG
 GJG8FNd64fj5vVZCoMf/wkESxGCR9eki887bE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hRex7Xf1
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

Hi Elliot,

On Mon, 3 Aug 2026 at 18:23, Elliot Berman
<elliotjb+anduril@elliotjb.com> wrote:
>
> On Mon, Aug 03, 2026 at 01:25:32PM -0600, Simon Glass wrote:
> > Hi Elliot,
> >
> > On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:
> > > qemu-x86: Wire support for applying capsule updates to pflash
> >
> > The other two patches use the 'x86: qemu:' / 'x86: emulation:' prefix
> > =E2=80=94 please make this one consistent (e.g., 'x86: qemu: Wire suppo=
rt for
> > capsule updates to pflash').
> >
> > >
> > > Following the flow used for qemu-arm64, probe the pflash MTD device
> > > and set dfu_alt_info/mtdparts for qemu-x86 and qemu-x86_64 so EFI
> > > capsule updates can target the u-boot pflash partition.
> > >
> > > Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
> > >
> > > board/emulation/common/Kconfig         |  2 ++
> > >  board/emulation/common/qemu_dfu.c      |  6 ++++--
> > >  board/emulation/common/qemu_mtdparts.c |  6 ++++--
> > >  board/emulation/qemu-x86/Kconfig       |  3 +++
> > >  board/emulation/qemu-x86/Makefile      |  3 +++
> > >  board/emulation/qemu-x86/qemu-x86.c    | 38 ++++++++++++++++++++++++=
++++++++++
> > >  6 files changed, 54 insertions(+), 4 deletions(-)
> >
> > > diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-=
x86/Kconfig
> > > @@ -24,5 +24,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
> > >       imply VIRTIO_NET
> > >       imply VIRTIO_BLK
> > >       imply CMD_SMBIOS
> > > +     imply SET_DFU_ALT_INFO
> > > +     imply SYS_MTDPARTS_RUNTIME
> >
> > These are only useful when EFI capsule updates are wanted. qemu-arm
> > gates them by putting them in a separate 'if TARGET_QEMU_ARM_64BIT &&
> > !TFABOOT' block that also sources common/Kconfig - please follow the
> > same pattern here.
> >
>
> I can't guard against EFI_HAVE_CAPSULE_SUPPORT or DFU since it causes
> dependency loop. I believe the config guard is set up because it isn't
> (wasn't?) clear how to set up capsule updates with TF-A? Is there a
> Kconfig symbol you had in mind for x86?

Hmmm, OK. Since this is qemu and we don't care about size, that's fine.

Regards,
Simon
