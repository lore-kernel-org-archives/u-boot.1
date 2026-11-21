Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97458606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=epVhTyvz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0/HK17j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 277C5606B0;
	Sat, 21 Nov 2026 09:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jx59GHPNQ9fj; Sat, 21 Nov 2026 09:58:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E8436065A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795255106;
	b=EZjJVElb0rlfEcj4Q5Wpi07sZlcV8aDvO9E57t2UVMDVHo89UBvgKgRGuro996ZlcDXQ
	 St/IPopwQmk8MZdpND1WgpXBASdpgaTI6BTDRyUqieDk3bP6REpuMz80rCNCAx5EDZRuk
	 jzuPnrRRSZr6ao3FJc+0zx+0Ev5PmJOr2vnu+70iNCyRmTfS6GaKUeKlqrI8gOQvj8THN
	 IN5bhb4wPOuFqNtI8fWqAjpHRF7EwmhoZjWz6UcEEztV3XA0YOAXWT07MVFNJJL0A4IKO
	 4asiVK7EfVnJlB+U0jRQ1ZJKFez3DtV5x4CvftydpeOv+0TfcUg01JnDb54ZLwJZIZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795255106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Bh4OrvXeILXAbC2g4ugrnsAkD/qSQB0CKVRv1Oi/TjY=;
	b=pbmIZR+XhmIoFmJzrAt2eYfJQvvjcX9x/TyfFaJKpGTNHOLDju6ItbDfs5Ege43/4/Vr
	 Pp4g/yBIw9Zd8aeimOFKzb/rSFSa6agREdiYw1KTf/zKG9SSPu9s+uejUHBBzL78/orzI
	 VJS6zo6XLH0Kn8Deh1R4JxcSMywxvvWREix1aiRv1sfIePb7sjQdq0nASbfe6NvYBb5MA
	 fymh1gWvYF4SELTUIjjZK2PY1nJSk7+3bQtPFhNE5+AhYx4VVhDtAjbTmcZ/jgipqtEVP
	 j1CLqsuyetpyKaj9ghMA3EzT90tAfvLGWvWwMvu2BtAb1GSQomhobAFmqxf8kjCwYZw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795255106;
	bh=Bh4OrvXeILXAbC2g4ugrnsAkD/qSQB0CKVRv1Oi/TjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=epVhTyvzbEv+DOmTXLiMhjTDZO3PZIwdy8007wU2WZ+9hN0UxPRSMHhIPcVpMpf/b
	 XGWtFdimV6K2D2aZzlv7gvcnBWDgk1SpAE2oB0zJ8bUnyK++dI/jaGZETtMqcdqXmd
	 SjDu0HUZRHmRFXoLf01RdBwB0qQXsaw2yrawDzsturTxpWVrcksmHfWzxcel+a8uSt
	 4r5AC82TjMjBgZrpfHdMf8vZi8IY5jntIOWpsono6u96rpTaCYu0YFDZvFwy6ca96F
	 MJ9x879OPvkFTZOvSgBh/w1RV29qsyGwc3dBL+mVoIjnGCcLrS2xk3z54y6INvqXCS
	 GqPBoE69J1JJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E8436065A;
	Sat, 21 Nov 2026 09:58:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 849441AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 09:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75CC880EF4
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 09:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FbPvglii3KIc for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 09:58:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FDE480EB3
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V0/HK17j
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FDE480EB3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 09:58:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC13360D89;
 Sat, 21 Nov 2026 09:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CC61F000C6;
 Sat, 21 Nov 2026 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795255100;
 bh=Bh4OrvXeILXAbC2g4ugrnsAkD/qSQB0CKVRv1Oi/TjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=V0/HK17j9CpJ1qdORYKSBrZP8qiKx43OZbI9sJLaHNZcQQ9STiAXUIfWG5aaixQBy
 ZYqcdxKoGnbdiGnsYUlOrtAWNzt85XVFsL7wgJralMhkIyHFL4t3UaLQhfw5OT+4Eg
 ixr7uEcrvZRjKSiuwJ5QhJRNmAq4140ZKpK7cajF9YhwNE1SwPkA4CaR+Jz0n4WUsg
 bVZWtauuOKLLUjBNlEwzTRVs6n3CMqMpfmJbnZV7SBzTv+o+JP4nffPErhnCSTqqT/
 FK4UPCyaJJkBsJRZKJKUs2f1vmys6D0u0PXkQkgnVrHGv5u0cLWpMcEtgkqqsPeyo+
 Oilh8Sw3e+cRw==
Date: Sat, 21 Nov 2026 09:58:17 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v2] clk: spacemit: k3: reduce clock tree for SPL build
Message-ID: <20261121095817-GKA203137@kernel.org>
References: <20261103-01-k3-clock-spl-support-v2-1-09a0b28e902f@kernel.org>
 <20261121030534-GKB156439@kernel.org>
 <530bc058-178e-4181-920c-b5319e48ada2@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <530bc058-178e-4181-920c-b5319e48ada2@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow, 

On 00:03 Sat 21 Nov     , E Shattow wrote:
> On 11/20/26 19:05, Yixun Lan wrote:
> > Hi All,
> > 
> > 
> > On 11:07 Tue 03 Nov     , Yixun Lan wrote:
> >> Due to SPL image running in a memory space constraint SRAM environment,
> >> so reduce the whole clock tree a bit to make it fit for final runtime
> >> requirement, only a subset clock tree is registered, which includes UART,
> >> SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC ancestors; while the
> >> full clock tree is retained in non-SPL build.
> >>
> > I'd like to drop or postpone this patch for now, the goal was trying
> > to reduce the code size of clock driver especially for SPL phase which
> > both target for persistent NOR flash storage and run-time memory consumption
> >  space.. but tested on actual board found, there is enough space.. so
> > leave it as is for now
> > 
> 
> For persistent NOR flash storage support the FSL SPI driver needs
> updated in u-boot from mainline Linux. There's some lesser improvements
> to it in u-boot now that probably need discussed and sent to Linux as well.
> 
I'm not aware there is specific SPI changes needed for SPI NOR flash..

> > 
> >> Where surviving SPL CCU definitions reference parent clocks outside
> >> that subset tree, it will use "clock-dummy" as name of clock parent to
> >> ensure the framework still successfully resolves the parent clock lookup.
> >>
> > For above using "clock-dummy" clock, will send a separate patch for it,
> > so will fix the unresolved clock tree warning..
> > 
> >> Signed-off-by: Yixun Lan <dlan@kernel.org>
> >> ---
> >> Changes in v2:
> >> - add gpio clock
> >> - fix tswi8 clock
> >> - enable sdh0 clock
> >> - Link to v1: https://patch.msgid.link/20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org
> >> ---
> >>  drivers/clk/spacemit/clk-k3.c | 209 ++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 190 insertions(+), 19 deletions(-)
> >>
> > 
> > ...
> > 
> 
> FYI not including clock tree reduction or parent dummy clock
No need above patches, so that's fine

> substitution, for what I understand the "bsp-spi" reduced vendor SPL
> build I document at:
> 
> https://lore.kernel.org/u-boot/20261029003327.1890979-1-e@freeshell.de/
> 
> ...fails to detect SPI NOR flash when K3 SoC has ran in BootROM SPL
> Loader "UART" mode;   It is successful when ran in BootROM SPL Loader
> "USB" (fastboot compatible) mode. There is some peripheral setup done by
> the BootROM code in one or the other that persists through and should be
> considered when testing. I would guess that re-sync of the source code
> in u-boot for FSL SPI driver from mainline Linux, and port of the
> SpacemiT K1/K3 specific FSL SPI glue code, would be a next step to
> getting working SPI flash from within u-boot main app u-boot.itb
> 
Could you check if below patch will fix your problem? which I've just
sent out
https://patch.msgid.link/20261120-05-fsl-qspi-clock-v1-1-bacea4ebd54b@kernel.org

> What SPL build are you using for testing?
> 
I have some local patches those not have significant changes, and about
to send them out soon..

-- 
Yixun Lan (dlan)
