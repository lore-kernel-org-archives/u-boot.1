Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64258606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RrMrebVG;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Pw0UIH7Q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37E67606C4;
	Thu, 29 Oct 2026 18:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbu22h2BLCl0; Thu, 29 Oct 2026 18:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 692CB60710
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793297947;
	b=C7OSswsE8vD7SI4rgMrG4pfLpNZUuJM9RCho2Y7PWpnKfi8P5VaO0Yit3rbRAOyowpen
	 P4NHWB9UcY8LVe6ryoCkXaSft1XyavLjLXIDElc5OuxVsQX2IowpLlOFpuqwZIyPPm5i/
	 UP46Pkm4YQLqcdloR8TFcbP28REV2YgHVR6sBLfutvezEp3TZZYg3zNTPmbJpNSiRtGzJ
	 MpN+eKynR1wrcqs49xgZABZn3rN5h+qqS5L16cr6uSz2O3Pi3/fs6xoKqefm+vS1tnVJY
	 +o/sjm8ywLTeFner8AwkfvGRrjUGeMM23KWNaPREnM5bmKsPsZ54/VLjrkLLYhAIgNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793297947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JIkmppBKxIOi9gJIz5OM+ALU5rci7kYqELFztgkW508=;
	b=kaSM1MtEUjQfX4pRd7ZhXAZjtKH/zNGwEp1v4eBNNdYNnyMtWkiYdnY0pyrUVfX+1YrO
	 5w/xG41ntlqT9XeP7Rray1PUe7FsHPThGUpqrK9jrxQXY8jPB4XkZpvrekguzEl1mhwow
	 /th4D6yEtMLNTiLW0pzZ3FfYxMY6qFICRr3vG77pnTvmB3BmI8vxr/hQRpDNhPxNCeomj
	 QbHRVLQWR3z7gwvFJ0K00d1BZUvQrPRiwgdtap09cHVARkYHLyipSH7S8b5n47N7IUlD3
	 YNbeVba3lRbIA6rQBDk3xZmetMfjSWLKme8bZvLwT5D8DKV3kysLCP1ZATM8Iv0vDrQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Pw0UIH7Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793297947;
	bh=JIkmppBKxIOi9gJIz5OM+ALU5rci7kYqELFztgkW508=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrMrebVGW9bFR46NkPmL03gggdPRaYMx/CwqE/LzqW12LnWhfh7NcVRUCuMS4Wpte
	 gKOcPSD5zZh3VPP54LQ0iM4OwbRomhq/X0rwtFdBvTCOdoDHM0k8HQZemIMH2xBe5V
	 KlHjv79BeEMIDIX/qTScpyfF47S9HTkXaXGARcuplIzg05c6+MwZ30Cg8ix1s+8WyF
	 2AohE7CoX6VyRQ/oEjeGwjS0nGsT53r10HmAhmWABj+HOONxCkiepGT0cfpsotNnWx
	 o9ZLc56Ve1chY5erpvJLr0BeTHRRGmB0rNWxgD7rlpsfuiwvYjDJsY43VefpgU1MJf
	 4qrVxBS3ZrAhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 692CB60710;
	Thu, 29 Oct 2026 18:19:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F20DD2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7AAE60A5D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ft_sbk0dZSxH for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 18:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA9DD606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793297945;
 b=A5ngIJZP8X5K+j7QXnk2lwGLtBaylXTEc47eO9ANj8R3ApXHoz7ruVMii76hlI/nh+PV
 Var3/tePjEf4XwhTSlAyQs+PxMAiPzzF/vpt1O9aQ20NpjpFxFRq3duNlqSqFY9uW2OyX
 pf2W7dTK+kBENswBVinZr8YWP3J2yWNVY/42Q9w01F27GH4VNmDj70nsr5Y0m95gOnT8N
 HpzbQ1l6FpSnTZnxGA94gEjqlJ1lDOmrZjh+sQqdgLISmp/o3L2ZWCCd/zIWua2DwtwvH
 ab8sZXpwxEztJ2pWKd+w7ZRijG2BL15na3JRjaJpjWazFRQVmSVZvG8j6S24XGdqtcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793297945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=JIkmppBKxIOi9gJIz5OM+ALU5rci7kYqELFztgkW508=;
 b=DZdGbR033GbJs4X82iYMSBFFng72I0HHEVbAvS7Ox05DizcXxFFA5j13SJo6jwABU3ZM
 VL5KtN4vIlqtQzWzez19eXywX9xWh+1N/cY2pH8E+3Egn9kvrwWZuCwaHrMSss0FHPOqs
 KIQXIlgxFUepBT/MLWK/+tdeswha6hiwKw22oabP/01B/MlqWLGrfFRMkrhQ9kkTvPsf4
 eslq42sCZLpHq+earRuxbrnqn9zotPflCP4WuZBOxMQ+dSwI3Jh7h2VYysy8t8HksICne
 8vx+pWeArWogz0N6yi1GsnObQc5k62eYUYezA2TAYJ0esQLEEUekSbgJJtJYxlr7vWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Pw0UIH7Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Pw0UIH7Q
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA9DD606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:19:04 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-705cb6ceebaso1656794eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793297943; x=1793902743;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JIkmppBKxIOi9gJIz5OM+ALU5rci7kYqELFztgkW508=;
 b=Pw0UIH7QNgMrIh/RT3ghCq0+tMCITcDGnZlRf4ISrjZYOk9NYGD8uv1pneLs/QHbn5
 PFg9aps1DiOjsOcSKYkghgEZblxU26udLBjBF20zP6Z7Kz1Ahb1D7V5zp0D+PUInEWDF
 tPaE06OZ1KTYskqMd07IRYylWrN7laI+RxztM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793297943; x=1793902743;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JIkmppBKxIOi9gJIz5OM+ALU5rci7kYqELFztgkW508=;
 b=lVPRT+npQbKlZjuN+JzWj55U6agEzzwlekHTiw5+wT3qJjLdchUG8T1U3OtJsk+0ZL
 mCI3U8pb7q5E7ILJryEIGDIYVeZmAqtjCsFrRPJHGvbg81qj1X+P8xxmORWXuISkesld
 3vSogUKrc/ahMziUnklhxNWRpTgK8Fya2Io4tfkwtQgLkbsF9vsj6vZrgfaiTQwMtB/1
 FyBafTgh+20Gl1pMJREewrcHPChkExx+WiQ+sWgeA0t9dD7OB8lpOXtxlQt85mGs7Vj8
 WOI5MxQ7/xxnTXCdWfl68PeO6ZBtqmig6kNTpDiKXemIKvhvn3OiKBKZTREuOGv40dCG
 RjDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwH/fwBcDzBe+5sJUe90UfGfy0gbp3mPQJUcojihDnWgcCDWrAXnBG1qEznb3TXfGqd01A+5Yo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ/tSFf0/zLJ2mjmUbQE6qYsSp3IiGtLRhJYsGvc75n4iYlBk/g
 xaO3lmj1T13ACHuVq7vj/tvY4jIHD7YL5rkqC6iGFpbsauPrF5qCPLZErm+1yBb+/e8=
X-Gm-Gg: AYBFou2eZ20zozzVwVNWCDZwh05DYqJFoQ4m7C2fdqOquILGH0j7XcTIEMjHu2Su2wz
 6zE/WjQi73K6KWShe3lHM1nkZDHEG0WOmhI2IRcGo/Cbb5iXjHTXjLy+WaX7cjuoK1YNKSB7tXl
 WipwYhHHqjGgMuQVHitNxhYZMefWJZDI0lC54a8aTwqNTqUDIAkxHpLbsRSDI1aq8WF23/K3ZaA
 bbyqVvnf8XA/MiSspr0dVbqZoVfLHbw0gSeO2P9c6auNFLpLFaI/fdX9GhXOu5rbOa7icckJN10
 Yx9bDRytk4HByILvRCQIv677xvABeJ99ESJReggk3VgFWNsgxvEbHtun0pZWKA00+hkw2YiweOt
 8V+twJPvY+5fP4r3qop6FLWD+hdOLAQJ1IbFU079ncPq9VGauccNUOBgZZaT60GW5oNPU0fmzgB
 MrF4ajMX3dQGdxmpISR1kt2QC9VvV9QI2H/hhTJiyI4M+cqseWhCp5q1wFr6PtO4n9AbD5jV3z5
 qifVImNWbJRBWCECegc+Fpmie0UB5CB2hYQBUjM4xXP1MJULWizZyMHyw5i1QGhcWM/5JdIVZhu
 6RRly6W2kCBYQr1vl4I873pEKKCV+VGwmUlVf3RlwivJvJB7VJ+l8F7zIkoYcsxFTHA7s0UV1ed
 iqrdIhVYp6iEWkAdDJyPj/CamBGKlAZ7XXGVFolsyOVzUiVTMI59A+HPrx6GMc9EBmLeuWdumnc
 beCiD6S0bJurPJ/sze7sb+Ecj0F7YcFsU=
X-Received: by 2002:a05:6820:a284:20b0:713:da3b:8b41 with SMTP id
 006d021491bc7-714f249777bmr62871eaf.44.1793297943343; 
 Thu, 29 Oct 2026 11:19:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f2325sm172231a34.20.2026.10.29.11.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:19:02 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:19:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>, Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, u-kumar1@ti.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] arm: omap: Hardcode control_status register for
 OMAP54xx
Message-ID: <20261029181900.GH3011578@bill-the-cat>
References: <20261029173914.3771786-1-b-padhi@ti.com>
 <20261029174912.GE3011578@bill-the-cat>
 <9d74a34f-f720-45e8-9b64-76291f3fb842@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LFjFChGMOwnyGeR+"
Content-Disposition: inline
In-Reply-To: <9d74a34f-f720-45e8-9b64-76291f3fb842@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--LFjFChGMOwnyGeR+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 01:07:08PM -0500, Andrew Davis wrote:
> On 10/29/26 12:49 PM, Tom Rini wrote:
> > On Thu, Oct 29, 2026 at 11:09:14PM +0530, Beleswar Padhi wrote:
> >=20
> > > Currently, the control status register address is obtained from the
> > > ctrl global pointer. ctrl points to a fixed SRAM scratch slot
> > > (OMAP_SRAM_SCRATCH_SYS_CTRL), which holds (*ctrl) pointing to the
> > > omap5_ctrl/dra7xx_ctrl struct at DDR address 0x8086XXXX in the
> > > pre-relocation U-Boot image.
> > >=20
> > > Since the SRAM slot is outside the U-Boot image, (*ctrl) is not updat=
ed
> > > during relocation and becomes stale. The kernel section from the
> > > fitImage is loaded to address 0x80008000. So, a larger kernel image
> > > (~8.4 MB) overwrites the value at the address (0x8086XXXX) pointed by
> > > the (*ctrl) pointer. This corrupts the (*ctrl)->control_status value
> > > and CPU goes into a data abort when it tries to access the data at
> > > addr=3D(*ctrl)->control_status
> > >=20
> > > Before relocation:
> > >    +-------------+     +--------------+     +--------------------+
> > >    | ctrl        | --> | *ctrl        | --> | **ctrl             |
> > >    | .data       |     | SRAM scratch |     | .rodata            |
> > >    | 0x8088XXXX  |     | 0x4037BC20   |     | 0x8086XXXX         |
> > >    +-------------+     +--------------+     +--------------------+
> > >=20
> > > After relocation:
> > >    +-------------+     +--------------+     +--------------------+
> > >    | ctrl        | --> | *ctrl        | --> | **ctrl             |
> > >    | .data       |     | SRAM scratch |     | old .rodata        |
> > >    | relocated   |     | 0x4037BC20   |     | 0x8086XXXX (stale) |
> > >    |             |     | (unchanged)  |     |                    |
> > >    +-------------+     +--------------+     +--------------------+
> >=20
> > So this brings up a similar question as v1. It's never going to be safe
> > for SRAM to be pointing at some pre-relocation address in DDR. That's a
> > problem, full stop. Going to the patch:
> >=20
> > [snip]
> > > diff --git a/arch/arm/mach-omap2/sysinfo-common.c b/arch/arm/mach-oma=
p2/sysinfo-common.c
> > > index 49bc3a634fb..1b7bca3ee37 100644
> > > --- a/arch/arm/mach-omap2/sysinfo-common.c
> > > +++ b/arch/arm/mach-omap2/sysinfo-common.c
> > > @@ -22,6 +22,9 @@ u32 get_device_type(void)
> > >   	 */
> > >   	return (readl(OMAP34XX_CTRL_BASE + 0x2f0) & DEVICE_TYPE_MASK) >>
> > >   		DEVICE_TYPE_SHIFT;
> > > +#elif defined(CONFIG_OMAP54XX)
> > > +	return (readl(OMAP54XX_CTRL_BASE + 0x134) & DEVICE_TYPE_MASK) >>
> > > +		DEVICE_TYPE_SHIFT;
> > >   #else
> > >   	return (readl((*ctrl)->control_status) & DEVICE_TYPE_MASK) >>
> > >   		DEVICE_TYPE_SHIFT;
> >=20
> > There's not enough context to see what chips are in that final "else"
> > clause, but they're all likely in a fragile and breakable state, and
> > that needs to be fixed. Is there still a reason we're shadowing that
> > information anymore, rather than always reading it? And, while we're in
> > here, what other fragile things do we have SRAM pointing to
> > pre-relocation-DRAM in? Thanks!
> >=20
>=20
> I had tried to root cause this sometime previously, it starts here[0]
> where we have different ctrl register layouts based on the device/revision
> and we call hw_data_init() early to setup these pointers to the right
> layout early. This part is probably fine and saves doing the lookup
> every time we do a register access.
>=20
> The issue is then that we use this double pointer with one layer
> being stored in an SRAM scrachpad area. My best guess (this is
> code from ~2013 so I don't have full history) is that this was
> done so the pointers would survive SPL->U-Boot and not need looked
> up again. That part is the issue, the sane thing to do would be to
> just re-fetch these tables, which AM43xx does do[2] which seems to
> be why it doesn't seem to need this work around. And the commit
> that adds that for AM43xx[2] seems to confirm it was done for this
> reason.
>=20
> Best solution IMHO would be to get rid of the odd double pointers
> and just make sure the now single pointer ctrl tables are initialized
> at the start of both boot stages.

Sounds like a good plan to me, Beleswar can you take care of that?
Thanks.

--=20
Tom

--LFjFChGMOwnyGeR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauOOFAAKCRAr4qD1Cr/k
CliiAP4g8zLTFA8lea9tqNR6PmYp30lQrSK8eO3y8KYZq6nF7gEAq/ki8YuSPKRc
VtM0nqULk9QJa8NW88e/GCR47CJQ3A0=
=byq5
-----END PGP SIGNATURE-----

--LFjFChGMOwnyGeR+--
