Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0367C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 784CD605D5;
	Thu, 20 Aug 2026 12:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZB7Dc44-2Iv; Thu, 20 Aug 2026 12:27:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787228855;
	bh=6Zo9scU4Urz8fBxJqu2P0F+bswvv3xGUMz7u+VgQf2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0zz862mN+VFQhvVEdiJiCGYyM5VkR8+uHasuAD0OF1Q8SWFsEM3BxNK0QigUlJrsd
	 jkavww4tUAtXZbQ0e6JzDXQwZ1QH8XCiEbg6DF3n5xbUlTDEd3VhRffyDyf8si6DjN
	 rd5/UMlcoZ/YQOqG5Ip+79d7KNGyRRaeKJsdTy4UwPUapm/9kr8wnJfHx30DWi2Z9G
	 vNOm+PYVX56sH3ZamBw8YYDI3zJ3Opz/Dj2mgF0mrIAh+vndPG7XD5Z8vg3x+cHamL
	 veNPav5jETFFysPp//eal0NUJR/lHIV5jm3RMCHM7JhMZoa7y+967aDJJ6pZpjXYoP
	 hOmHkazhn5gcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D76F360768;
	Thu, 20 Aug 2026 12:27:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 901803AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81DE860768
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PBjLJqWCwFe for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:27:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Hmv2zJMo
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE68A605D5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:27:32 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cab973140bso25788655ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228852; cv=none;
 d=google.com; s=arc-20260327;
 b=dXaT3Ga/ba2XNulG7RKJHIc16W4ovnbujlKpw6hYl08pvo+HWxWIX1IBnuS0MdIZ1g
 GPI79Ft4xK+/ZtRfPQJoGl5J80ct98ngw/ZZHz+QSVEa8YWjDpKnYZLphKL7KajiaC3i
 yCz4NcxzFsHkeDINbj433Jot8gNfqk0uhnE48hecokNyjXgoUqoY19/VQ+6d0MZKaIBC
 LuStTPl/FN2V8IbS+egjUcVrUyKxlcQT8eL79+7XuWQi4apOEb/t2F1egYL8mctWlDPO
 CP0nyBU+Gl/mmGPsu0if7tZ8/mWPPMmF4+F6IHT5HhNww2DjagB2MMF0Bx2o6BTRHDaQ
 MDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6Zo9scU4Urz8fBxJqu2P0F+bswvv3xGUMz7u+VgQf2U=;
 fh=jJd+A53wZa/5ndWf/3ks/y4k1FJV/jiggmBBRXKonMg=;
 b=GPUSNZy/3yIV8hRCGLbul5z5CUHg1Bz2R05GIZjr4Myj2SkjLt5jkVHmrNaxvOJ0Yp
 ESWwC06ky25+hYpZb7WzFIxmn7wFehE3Bayiz+Z2jFSEXPsTioC7mvee/LOugyqnEXOu
 uQEZ/3wgkQjCtK4UWWKxb5TV9+pv9eL40A40+NjBhPSCpCsPIG9vNFLBpnSUIjxwsLNN
 fCdBuCRVI+R00Id+kMMejtX7ObZWkYCzJmiJ+XFLXwqAGgOrOYWb7fS9WcguyZYTcK1I
 6LBLERQ2GLbu0H+bUtik6UGnRH4ysxjsg5QopFoZZuR4ATXsqJB/Z9yXl68Il3Umn8DS
 hpQA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787228852; x=1787833652;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6Zo9scU4Urz8fBxJqu2P0F+bswvv3xGUMz7u+VgQf2U=;
 b=Hmv2zJMoy6gYg6vjhEJ8nBpWkDNGm48bAoh2XNXODFgglyUgJ0UPZRbjzx1xrwyhmj
 NVrMc9MHzttd5UptIpogYfToZDztsdNc/uDoNSw11bNYTtuXMjXLxIEIJ91ibWOHz2gT
 65Y1UQ6c0IQ++IfweWhX++q0KKFAfttJdT/XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228852; x=1787833652;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6Zo9scU4Urz8fBxJqu2P0F+bswvv3xGUMz7u+VgQf2U=;
 b=sPDP7v2+ya2nuqDXqgFYIZPRmHUE3TqB8atC9K9TpOZP3kZVdHywb2r4wvlwpRgix/
 qw0YQZtxRFnA3o2mHROKTgWoxd1l7dqxHpwnpe5z0/VTbqMgyCmeoc9NRISkKpsBHMru
 W4nCLdTa9tFudi+pQsV3d54/u5k5K8WKdyQd1Qgwb0BWT2oDAzEHRf69wa1xCDpJfp9z
 MFz29ORNUOAl+ZUDSu9ydZAkIJd222jkmqDrxEFaxVOW0pvap42Ir6hwBrXXVcBsaDQ3
 cVa6hrxC8m1TPYaRL74WmibHJx88QcjqZv9nlt4sUqp6AT0rgFTmJVo7dwYEljOe2fTN
 09Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVvxKHIQtWNmcluPz+K6ZiywD1HQQBCH6IHl1uB6NAKo1waDTHC9g28ChyeLs+Nj06WHlNgHU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m/1NwVRy+sDp+wOS/srvuh+Q/RC6eLtS17CYnxlhgtoF0sDX7S
 5UjAxBiw+wpRW2XAgyXQ8f5LJ10dytbUB/I+nsWqQldjJ5oy/2Xl4G/F2Ic+JKkswZ/E+GC4cEF
 wiDSE6aoi/Q3EWUyQ6ShQrUImBULzlo7cbLnvlxDw2TETFnA0Q1A=
X-Gm-Gg: AR+sD10Sah+gMxS3E2dbwB194iIR0edi5EVH+VDYW6CQW+hkTQk2UKSWPVi7vUdGvAC
 3eHKk/Cr9D+nO5u6vT1BbdGxy+t85KrjYqVzCDAIWmt8JtoNbenq2sJOkXTJPw8Ox0RugZs8Xpn
 9IvyhgONcsBv3x0my9siIh+Ja0lKKMh2Fi1nCimW9/DGLrmsGflLmqeSD1uMYA9GpJ+AMTfnvl+
 UkS0wyLtu8Wd7ElpVT1ZzdB6wBHvRD3wFvTpzqadd9p2/stx15dU4dfI1sC7kfhX9V0ISKAHPU/
 uSWzu3fgDqjZhvRokDpRjQchw0i8Gn901e4nzW9PhEU=
X-Received: by 2002:a17:903:3904:b0:2d6:3c22:993a with SMTP id
 d9443c01a7336-2d63c22a09fmr25686895ad.3.1787228851828; Thu, 20 Aug 2026
 05:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260817153144.1951036-1-vjardin@free.fr>
 <CALeDE9OTtd7Oy7sVKsdukfnwdrV3Sg5d1F34muBQgZdsOaMoKA@mail.gmail.com>
 <aoM6i7TKGcfAydpp@L30177.local>
 <CALeDE9OSFs=3WkKFh6tBa0VHdVAvKSL=-XktBQHwbTd-vefwiw@mail.gmail.com>
In-Reply-To: <CALeDE9OSFs=3WkKFh6tBa0VHdVAvKSL=-XktBQHwbTd-vefwiw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:27:13 -0600
X-Gm-Features: AcwNN1UP6JnZWT8UhL-0qp88V3r7MfP2r_g1pphQbxbGMGIiiTIFD7QcFxiuVSo
Message-ID: <CAFLszTjTHnG09rT146KbQq46z2u_nHy6GSwDoS_jcDNyUKO8pQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/23] board: nxp: add the Free Mobile Nodebox v3 CPU
 Module (LX2160A)
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org, 
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Peter,

On Thu, 20 Aug 2026 at 05:52, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Vincent,
>
> > > > This series adds the Free Mobile Nodebox v3 CPU Module, an NXP
> > > > LX2160A based board (16x Cortex-A72, DPAA2). U-Boot is the BL33
> > > > payload of TF-A: BL2 trains the DDR, BL31 hands over, and U-Boot
> > > > boots a FIT image (kernel + MC firmware + DPC/DPL) from a single
> > > > FlexSPI NOR. The module plugs onto several carrier boards (NBV30,
> > > > NBV32, etc.) that share one kernel image but differ in their device
> > > > tree and DPAA2 data path.
> > >
> > > Why just FIT and not UEFI?
> >
> > Because this layerscape platform shall not support UEFI by design.
>
> Really? I have a clearfog LX2 platform that boots and runs with UEFI
> just fine. Generally this is where the Linux ecosystem is going so for
> a new board going upstream I would expect it to at least be an option.

Generally this is where certain people are pushing Embedded Linux to
go, but that doesn't mean it makes any sense to do so. UEFI requires a
lot of extra code and complexity, 100K+ in U-Boot alone, not to
mention GRUB, etc. It doesn't support embedded things like FPGA
images. FIT is a good solution and as an industry we should be
innovating on that, not forcing UEFI everywhere. If you need OS
selection, Boot Loader Specification (with FIT) is a good option.

Note that I write this not as someone opposed to EFI protocols (which
I have expended a lot of effort implementing and reviewing). Horses
for courses.

[..]

Regards,
Simon
