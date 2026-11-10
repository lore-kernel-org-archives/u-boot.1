Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F201606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zX/Lw3F+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IAh3CQYu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91A9F810E1;
	Tue, 10 Nov 2026 09:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncMyYfmD_FyA; Tue, 10 Nov 2026 09:11:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6B2E810D4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794301877;
	b=laP2NvTYtnspkMStGzMVTuvP6gQhUDjOTvbdA7P8ByuDTf0kotVPJNz1GyDhaVATg3IG
	 +4zK/CodOMMaTXHOVdJzbrr5onW1HZ6CxR7q8hEtc5X83JQ90h4af0DC/ncTYfO4V/Yzj
	 LyAsScorxtf8Ly626KkfP2rJtd8q9QwnIxCtYVkEM7exWnNnLWn9ETFMODVyUTsxq9aIR
	 8V+iLGuB9pKUYzoeBYloCthKVLatjpf4JSUTOGVEcuLVIIc17OL9ogN+FHM1+mUCIBig+
	 leb18bOEFEleVrpGUQKy2e3Mk0a16MdOgvNm2myQDiI7Mi1oT4aaujynnjNg/pSejtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794301877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qhdA1aiYcx6asSd/cDGDQTPFVV+QECem2gCdXH1bPjg=;
	b=MVeMZAWqxn8gMylB6R6fFrYM9LMajYq3lU4VlvH5Bp3nI7Jhgj3UhcXjNAwHT08fnVOd
	 FrFI156PWy0mK/8rQHk7jCQBEepdwm1kBSeA7oIsE9XtFm0cGKv9ZkMIqQir8k2E58W/l
	 ujD3W5WAoYNIfusiedJI+j1Qs1gqpmTOQB1s796A3tgwwb+PPBzXfssmc9ORVz45UreSY
	 E/1fEOP1Euk7oks6O+yp155GYFCrAZWiCL+RPdG/5cvxdTofkUp6HyX0CioavvckBcopB
	 9H/31+UgwZ3B6DEPToEKSxim/1p08jWim0SAuFFLRk7b34fXr1K7EBIApybGKBzh2yw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794301876;
	bh=qhdA1aiYcx6asSd/cDGDQTPFVV+QECem2gCdXH1bPjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zX/Lw3F+N/KfQrQ9U9iuxJZA4SDQvEbE4QsjHiEQixeNen0ehxP4J5uxrb45tKXqc
	 6dt5wzIXZegP9VRs6HbMU30Qmurwga1Gxhe5D+9+W8KxWT+UN62Ab5/rYVFKLzjpmz
	 SO7+dbXFM1AJxs02W4cy6wGLJ5QsfNVraxqGgTEK5WLdimKgl/OaahgBKoOauMClue
	 u8JEjGniGbC/XzQwTavM+gAdLt4KEI9Dd88l9V6GXegMmw3D9WuCBWIGa/EY3tsuSA
	 dwcDNMwFbM9T2ApJIQl5Iv2aJB1LYcrrpQTYLyVkBC2vg94BHm54ZfA3ACQ+R8OZYb
	 JpRXatDY9WkYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6B2E810D4;
	Tue, 10 Nov 2026 09:11:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CF462FE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10DD04032F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTovyQPI0XTh for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:11:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2E6E54008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=IAh3CQYu
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E6E54008A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:11:12 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-36dbde64409so3636704eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794301871; x=1794906671;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qhdA1aiYcx6asSd/cDGDQTPFVV+QECem2gCdXH1bPjg=;
 b=IAh3CQYu6DZCaSmuIJhUNK1qoOv1+5J+i2LoL3G1VCr8LUiJVLbp9dQN+GBz87Y2Hi
 P6sqvNfhz3gdpJ2qOj6sB9IQqklCX2UrvxHBYeNNip4F8SS9ex/xYIATBxQzQwJDcxK3
 76cLXKofO/pqFYjyBu2e0pYb2a5+hNgQw2/aeNwui50lQ4foXajgi8jEYkFmtj+IzxBS
 Ul7v2byjg2Jn7JtuGqEJZApQ2PHO5PpBaFXGXKF2ldJL8FFQ0LZMOtHrK0FQHx9N5vJc
 aQp5oxvitilhl/PZuBzUWFwuyKK79uRNW+NmFYKfe2U2dDqM8iKtQ/OsZ0pS7rsphA38
 RTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794301871; x=1794906671;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qhdA1aiYcx6asSd/cDGDQTPFVV+QECem2gCdXH1bPjg=;
 b=VSVpTax21G6fGySmo/XNWcNjsZjoKLvCwitkYTZK9muZRAg4eHFDL4DaAqOTD6rNDp
 YUK6TUaDGdF3z2FmcIR06eza6B8LsHein/qbn7I2DgB6DTcPQzg13h8eiywBWPP9wwEo
 Cnh8l/eMiAgX+gozck1NMpBLrCc68IUpfSZyDL84dZ9IJaEyfaLyQkovfwEeAiGX/D01
 3AtQcn3gu4lAUUClHoY/3HvC/Odu5/22Prw/RaAFNyGdG2ClqFq3Lb/YUsuSpCwaBD4P
 cfpH6GnwS83C4ziMQwdYV5aytj5sL2fYs1iF49qoraNLAYh76K/FsYvfekBXo9CbmPHR
 t5VQ==
X-Gm-Message-State: APuU4Z9bZnUFgd4e3JBq6gk08eE20VdvNcksfw3bKEaveVVXycUN9hXR
 je71ORiLhryygMEDnS4A6NYskJPyl1THvDelyQxtPokeqFKK8gYCGiri+ihM2gKAcgv/uFv+S5b
 l/vjsY57wEdpFuvNZxxsj74z90oQsYvE=
X-Gm-Gg: AYBFou2Sqb5tds7sN3Q31IoC6F9WMhseSPr7pZVMv+9D/+/35hdKLcC1ha8hLXk8stc
 ubZVeG/CF2ujWvPe/2oEzMJIj66TrlefGFbok+wIKDSVpN881lXfUYRWd8ZJ4EJdG+kvj3VOI7c
 nThHtcw12IBoY7C1En4lSqTcnpfvvmXtbHdji76UIN64k3Zgu9ke+Pwh3n186r1PFoeg6AzWtw5
 obUAgzxN/6FssCJ1HTGf4f63seYfft/ohVX6aJBVHUqrgRhCRzPtRh9yI9lSPMCI2nMW2bQablq
 //tbVx9lFhK3+QwtaWdyfn8HKj6W7MrrWposzz+ml/+7oZNL+hcYZIMBF9RsbQvYXYmYb6lQgLe
 BTY9nZzptmK0UtLegmk7h8GFURvV3J4rG22ngSYFfo3+HBg9btaxBOQ6Rw+SE8C8u7MmjbYwCH3
 ULCCRz0Prye9McSgCWSwab4hqIm/KBog==
X-Received: by 2002:a05:7300:e9d3:20b0:351:7e5d:2de9 with SMTP id
 5a478bee46e88-3751c82b607mr3073541eec.1.1794301871005; Tue, 10 Nov 2026
 01:11:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-wdt-tegra20-v1-1-d04bbc5829e4@gmail.com>
In-Reply-To: <20261109-wdt-tegra20-v1-1-d04bbc5829e4@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Nov 2026 11:10:59 +0200
X-Gm-Features: AclHuK_w79HV1OGffizAjKkEoSuzWfX2rSYW28bSwgOnF3IgoHs8LbU1R0mt6qE
Message-ID: <CAPVz0n0GOS9ZUdLJHJS1+Lr7oD9xqiAe5PJNsoec5KFY8ituFw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: tegra: support Tegra20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 23:02=
 Artur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The timer driver binds tegra_wdt to Tegra20's timer node as well, but the
> driver programs timer 5 and watchdog 0, which only exist on Tegra30 and
> later. On Tegra20 they lie past the end of the timer block, so starting t=
he
> watchdog writes to unrelated registers.
>
> Tegra20 has no watchdog block. Instead, the clock and reset controller ca=
n
> reset the system when the interrupt of timer 1 or 2 fires while the previ=
ous
> one is still pending, enabled through the WDT bits of RST_SOURCE. Use tim=
er
> 1 for it (U-Boot itself only uses the microsecond counter): run it period=
ic
> with half of the timeout as period. Clearing the interrupt alone doesn't
> restart the period, which would leave between half and all of the timeout
> after a ping, so a ping also rewrites the timer setting, read back from
> the timer, to restart it.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
> Add watchdog support for Tegra20. This makes it possible to recover
> from hangs in U-Boot or early during Linux boot.
>
> Linux doesn't handle a running Tegra20 watchdog yet. Its timer driver
> takes over TIMER1 for CPU0's clock event device, which can reset the
> system early during boot.
>
> There is also a Tegra20 quirk that affects any watchdog reset while
> Linux runs: the watchdog resets the system through the clock and reset
> controller, which doesn't reset the PMC, so the power partitions keep
> their state. Linux powers the VDE partition off when its PMC driver
> registers it, and whenever the VDE is idle. If the watchdog fires while
> the partition is off, the boot ROM hangs and the device stays dead
> until it is powered off. Linux already works around the same hang for
> reboots (commit 8f0c714ad9be ("media: staging: tegra-vde: Turn ON power
> domain on shutdown") and commit 510f276df2b9 ("mfd: tps6586x: Register
> restart handler")). The Linux patches that will follow stop the
> watchdog before the VDE partition is powered off.
>
> For these reasons I haven't enabled the watchdog in any defconfig.
>
> checkpatch suggests IS_ENABLED() instead of the #if blocks. They select
> whole functions and a struct member, as a U-Boot binary supports a
> single SoC generation and the two variants share no register layout.
> I'm happy to restructure it with IS_ENABLED() if preferred.
>
> The patch was developed with the help of Claude Code. I have reviewed
> it and tested it on an ASUS TF101 (Tegra20). Tegra30 and later are
> untested, but their code path is unchanged.
> ---
>  drivers/watchdog/tegra_wdt.c | 102 +++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 97 insertions(+), 5 deletions(-)
>

Looks like you are implementing a fairly different stuff then existing
driver. You can create a separate driver and make it specific for
tegra20 and exclusive with tegra_wdt (preserving the driver name) and
just adjusting timer binding.

If you have any questions, do not hesitate to ask and please cc me
into your linux kernel patchset. I have tegra20 device with issues in
poweroff/reset.
