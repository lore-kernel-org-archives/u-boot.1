Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D126CA9EC1
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 07:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E839381395;
	Sat, 10 Oct 2026 07:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gNi7ytDAoMK; Sat, 10 Oct 2026 07:00:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 14818813B7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791615649;
	b=gEDsUuPMzUVS2BNQPXRLyINeMN/Fkyvy3ZaRjPvQ7dJQqH7e4serFdHVagdb+7/2YOQ8
	 w7Hv4us5BFKURmjNooYwgbaoRx0Uhv7fA889IqaWo4xPllWRCDD7ZRvyPFFHiN6f5fyYY
	 ba+s8ZmYHRxGnNtEt4El7B/iQAt/klJntodUdlQat6vfLKtOeI/mzonFwoYmui32RUUer
	 8wsIIrI1hYuzZ0pyKCSjbC+qZTqfqRcYde6Cspn/7XiSOi0N6bofhquvUClgg8KRJl2il
	 WUbms7+NvFaZS0c9Q8pOsehLCf6GrvC2JFhZTDJuYSI7K+Aa3fsmcrMm9/dBxFvoBJQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791615649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l3B6rZhscb8jiabecyvZ/RrwMv+OZQKYOz7gdhVIPTU=;
	b=MezALNDTl3hn/rE5oRKIkrtQ9NdkPc37/iJpNM38Q3kQoGnYAnsjXm4DANQ+H7wq1VxQ
	 soYjSjj75WPl5tyKV0f2BssEt/MjisIYefuJx4UtO7TCk/6llcZb9/B3FeSAyHXNN81hh
	 6yDdjXKzHPosYfC5Za3/pLxTA7R1YqQvBKNb286I39o5h7/tWpI+eEWSrHa2HcpbsJncR
	 ljDEEMcIdydoCN9ut44VIP5HaLcgH67gxWK2wF5DTaCXXH5aWTtpeT4S4Qui+OOHaD1Gb
	 sDpep5f0d8mmMJ5sYxRcF+yHMDxaJAdwNRM5yhyFFc3sJayetHiyxztAoswIzhT5E8w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791615649;
	bh=l3B6rZhscb8jiabecyvZ/RrwMv+OZQKYOz7gdhVIPTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B6jGzT2ipv+QcTGvJPyV41sG2IQ7cQAiwlvvtwDgbcoMm2h1FkjjHKaExgXW+usa9
	 GxExFBr80iXo7gGmMiV2LJf8PMGUBI4nQuZ9fGZ8efPjo1/qwCkeGotwlWromFeSxB
	 9QHsf+a3T6dv7WSn35gtEtz8Fbhig97BFTFBlxtbChi2B2TajHTpO2tdXOMdgBaF1l
	 nxwMfTq3NuFKzH6SIeA+c9b5iE1XCc2KUFt5qYzV/jYFbDOmBjlmf1bCz8XMnzSAo9
	 bJmlxx5wLTD1RmKCFpVbVxnshT98SY5nQo0ZyEhJNzFOlZxyHIyiwHq9/lTBRlBvx0
	 lmyBXhwu0UGZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14818813B7;
	Sat, 10 Oct 2026 07:00:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AC98235
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C8AF40068
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rm2aIYg9qxt4 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 07:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DBE8840004
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791615646;
 b=Ur6R5gVfEJvYlbeuNSbZkgZ2fKNYiwGKDK9+eru9mtP78KzzLiQBn6CI6bv/kGbDbrSE
 7U8eVpNwiwJInnGAz1YuTAi+IHfEw6+xXQzHVOhThtBlTFAAf8F3PupLgfTudwdKjzuD6
 uIiYZKarxgb3kY1y5zfN5G4jHqqVNZiavYwBIBCl6z8jQygwEIQ1dLqG2tmtgqOHmI5Mf
 ssWjXik5uoa6AZsTOdFtDAb/uEGIgaJGYz6hFhvhRsVqOEZuiUisitGfsXibDL1GX+i7f
 vx+xB0Qf73T2/B7aor+x01M/6PykVA49KlytP0uua0o5biLXDQpgii8sKx8koK7subA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791615646;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=l3B6rZhscb8jiabecyvZ/RrwMv+OZQKYOz7gdhVIPTU=;
 b=bwUg/kYhWxd8ceILjz2HHforU5SSOK4HTsN29fFwgqlNgNzavWeQKdtBlUxz6H5YtPDh
 B3XE71qrxzw+LB2OU0ewQ43GWV/Aql+jHFylPbWRpyFGgqsER0t/Px7bGSO0M8cEcOMil
 a67xea1AOo7XkCMaHYSwXsb3GrguQxBwVlh9SGzwNx9qVvzjkEIz7lxGAgRsGlT07hAZS
 JQwHqopKFBayGA4sDIxmrVOEC/b8YRxTRMP39EeUMMqMAOfO8X7OnychmJHKmFHvDqs5P
 hkzacVAI6MwduyDsZngJJdhNOBEvsV+2vQrYO9XDYXOBidaQ6LYcBaLHz9ePUjIP0fw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k9x0g3At; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=k9x0g3At
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBE8840004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:00:45 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so479415a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 00:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791615643; cv=none;
 d=google.com; s=arc-20260327;
 b=f5ocNB7niC4FEsF/1JnpFvQ6nskWonjD+oaPaN6/PAWHy1Gng6whEPwliSg6mo86gF
 BL/Nu3hzF/2yn8/EefqeYjN2ZQkJUxjHEhmyAG6Mp7rGe3VJJAPd4G/ijq6Px4aEsz4x
 Rl73VVirIPpaY8bLMAUHpmxaSitmyTMyialTaYLAshuGph1kodIsTgLAEOjn1kfMBAEB
 LZ1REyS0E7UzgBljfEIj71lbMvj1qha+NE58xiLhO6zP8KWPkGcDa7jApOvbulc4cL5V
 a8d1XxBBIxn2kHq0ta3MqPjQTqW4iTft3SIGHip1jLgpPSAb2yBhL9gf9+W/nFGe6u9J
 vJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l3B6rZhscb8jiabecyvZ/RrwMv+OZQKYOz7gdhVIPTU=;
 fh=9FLOf6txrA/wi4CI6k6yNUcuOlXKrhZlinNEopf64n4=;
 b=hCCHl6D7pu5+ErVP1c/W0XIT/G6u97RHzNDi0WhlGkvG/URmWk9CZ3dLIlzUH13bKG
 RwCTRJja6tBjre6ZRcZkUxJ1XF1GzdbPP7XFCwMiCdyvoYtnUhJ1EdeLZwTQIY44snE6
 fAs/uvooVUbykUjYaBXS+UGlFonaW+2FXpneygxTRxFCN71z/BZAYA+Kao1gu7Ql4POd
 RjI4WoL+Ry3dgF89xJJZQO8aYdptdG45LseFX2okct7s9/gFulNmiP94KWVfoqQiuwf5
 pmwrM4o+L6Ym4EC2ZL1DyJidVrs6pikWqthV4X4/X8H1yFFO4vBJ8HvgZSnWsc/eTrIV
 pNSQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791615643; x=1792220443;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l3B6rZhscb8jiabecyvZ/RrwMv+OZQKYOz7gdhVIPTU=;
 b=k9x0g3AtZ7naiAJHOKbRw6wVPrN1RxHU4BzD5HyTXhPOxayiYetRIPSM7mTPSdrMlJ
 826fgotYQudI4NvwE2EC07qC3dI+uzr6UzJovKuN2hnLnQR9KQVK/Qj7PrpxeHcM64Nj
 X130X6Ng8Y2IdtUjklOL0SgLT/DmA+xmXGUJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791615643; x=1792220443;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l3B6rZhscb8jiabecyvZ/RrwMv+OZQKYOz7gdhVIPTU=;
 b=c2dcX53iwCvQzvu55dbs0ZSWuKDl3AFHf2DyRdfouniHk4vATbMoqh1JySdXeNFooQ
 ZAHftf8m19uzwV4iKPpxOiaE/dHJzO85fzmtYvigJaQI4jrh2YXMHlojY974WvfalaSc
 PJ4KIC7iYhftMYJya2AK8O7WWS3rTkzAv9/DQo442KmEOInNuxVZAK155t/YrCXflI55
 DVFuMfDdbpLy0H/JaL9VzgEOn2+akC/MhPxjr3WEqOXzFxkm+HKsJIArsGeoDxxxyUvt
 KUtOYk09dV/0BiYlBRYyhL0uR0+jPbFCM8dzR/lDHqV5rqvIeIaHwDotBVJGgKZwGELi
 pExQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNxdWZ8uvCPZQghDXHVhK+APv2PabROiSpOsJbGtHPDyce4vzhwZg7qY3IgXerym6AXNLGACU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIBjOH6TuWxJ1PkjdXgu78rWuDeE8Ch8GuktP//a73pUFXHoDoK
 CAPSYRbXEZBaR7PHNCIXPbmPTGwl+/4MC+KPOCTqHPxsyzn6USnmIPrdzJwkgehrbzSOZ+TO40l
 784sVz2ObXH5gxtsz8/mjGI4COQ/LPYEocZH+gJ4f
X-Gm-Gg: AYBFou3s9VBgYYUO1cY8kfo3bkSRBSA5MzajT4JoR3HLYL6RqjQWf5twwLALrrqMW2/
 CZuJ7EZNpQTYjxoCN+OzEYp7eVrbpSHvzz5o4QeSl9RYf7Prf12+AE1Jb15FcBkzl/quOrNYmk4
 YCV+ZBEmrhL1QMTdpBNK1ajoz1TqFHSJTNBK1azgqeH9u3FlB3viPSyn7M/BVYgJcAgEfAewBux
 HX3erFPve0uPihB/b5SlkvC3wjd8Goz0tLPHrd1POnA+ipcXo1XKTDg9Ono2FXR7Jz84Y613XGf
 dblhKnh9bc/wEtBKvCXxRtg30tY+T7D8Yz+Hxc/tFGzVj+HAGHatDd+aYEYlAocz7CI=
X-Received: by 2002:a05:6402:320b:b0:6ac:6fd3:1e97 with SMTP id
 4fb4d7f45d1cf-6b17c2beccbmr3591020a12.35.1791615643207; Sat, 10 Oct 2026
 00:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgA9u0EYDMqKR0C49jY8e2RcL4BKOg+dqh=V_Dp3LAnDQ@mail.gmail.com>
 <05f0e99c-591f-432d-80a8-0ef30d06dbd0@canonical.com>
In-Reply-To: <05f0e99c-591f-432d-80a8-0ef30d06dbd0@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 Oct 2026 08:00:31 +0100
X-Gm-Features: AclHuK8tO1BbVT2_3Wb5pMWQ3Z8xSRmaBoZ06mK9GcpjIeVlJmBDZqgjBALzIgw
Message-ID: <CAFLszTi1GMa=_ACDpD1CAkwLbj--TgB9T-bDdS6HvaqJWuiRLA@mail.gmail.com>
Subject: Re: [PATCH 0/3] sysreset: provide sysreset driver for qemu-x86(_64)
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Sat, 10 Oct 2026 at 06:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/9/26 09:26, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On 2026-10-07T19:09:05, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >
> >> Currently we only support reset but not poweroff on x86 QEMU.
> >
> > I agree with where you and Bin ended up: keep the existing x86_reset
> > driver so efi_reset_system() keeps working. But I think we can go
> > further and avoid a new driver entirely. The existing driver already
> > handles SYSRESET_POWER_OFF: pch_sysreset_power_off() asks the PCH for
> > its PM-block layout with PCH_REQ_PMBASE_INFO and writes SLP_TYP_S5 /
> > SLP_EN itself. The QEMU devicetrees already have PCH nodes
> > ('intel,pch7' on i440fx, 'intel,pch9' on q35), but neither pch7.c nor
> > pch9.c implements that ioctl, so the request fails today. If those
> > drivers (or QEMU-specific variants) returned the PM base and offsets,
> > poweroff would work through the existing path. That needs no new
> > driver, compatible strings, undocumented 'intel,*' properties, DT
> > nodes or 'imply SYSRESET_X86 if !QEMU' change, and the EFI reset path
> > stays as it is.
> >
> > What do you think?
> >
> > Since this is a user-visible feature, please can you also update
> > doc/board/emulation/qemu-x86.rst to say that poweroff is supported?
> > Please also add a test if possible, e.g. a pytest that runs poweroff
> > on qemu-x86 in CI.
> >
> > Regards,
> > Simon
>
> Using the pch7 or pch9 drivers would make sense.
>
> Where would the following have to be done?
>
> /* Map the target ACPI base window using DM PCI config write */
> dm_pci_write_config32(pci_bridge_dev, plat->pmbase_reg,
>                        plat->pmbase_val);
>
> /* Enable the hardware bridge routing decoder switch via DM */
> dm_pci_write_config8(pci_bridge_dev, plat->pcicnt_reg,
>                       plat->pcicnt_val);
>
> In misc_init_r()?
> This function is implemented in arch/x86/cpu/x86_64/misc.c and does nothi=
ng.
> But shouldn't it be board specific?

That part already exists. qemu_chipset_init() in
arch/x86/cpu/qemu/qemu.c programs PMBASE to CONFIG_ACPI_PM1_BASE
(0xe400) for both i440fx and q35

But looking at it a bit more, pch7 and pch9 are shared with real x86
boards whose PM blocks are elsewhere. On i440fx the pch7 node is also
the PIIX3 ISA bridge at 00:01.0, while the PM registers are on
00:01.3. QEMU uses none of the pch7/pch9 ops, so I think a small
UCLASS_PCH driver in arch/x86/cpu/qemu/ would be better - match a
=E2=80=9Cqemu,pch=E2=80=9D compatible and implement only PCH_REQ_PMBASE_INF=
O,
returning CONFIG_ACPI_PM1_BASE with PM1_STS at 0 and PM1_CNT at 4.
With the x86 code we tried to make it general so the same operations
could work on different hardware (particularly SPI flash).

BTW Claude took at look at the code and found two bugs in
pch_sysreset_power_off(): It uses inl()/outl() on PM1_CNT. QEMU only
accepts 8/16-bit access to PM1_STS and PM1_CNT, which are 2-byte
registers in the ACPI spec, so the write is silently dropped.
inw()/outw() works on both QEMU and Intel hardware.
=E2=80=98reg32 |=3D SLP_TYP_S5=E2=80=99 sets bits 0-2 rather than SLP_TYP (=
bits 10-12),
so SLP_TYP stays 0. QEMU powers off only for SLP_TYP 0 (its _S5 is {0,
0, 0, 0}) and ignores 7, so fixing the shift alone would break QEMU. I
suggest adding a slp_typ_s5 field to struct pch_pmbase_info:
SLP_TYP_S5 for broadwell/ivybridge and 0 for QEMU.

With those changes, plus CONFIG_CMD_POWEROFF and
CONFIG_SYSRESET_CMD_POWEROFF, =E2=80=98poweroff=E2=80=99 exits QEMU on both=
 -M pc and
-M q35 -- I have a rough prototype if it helps. Also note that
efi_reset_system() in sysreset_x86.c still has a TODO for
EFI_RESET_SHUTDOWN

Also whatever you do, please update doc/board/emulation/qemu-x86.rst
and ideally add a pytest which checks that QEMU exits.

Regards,
Simon
