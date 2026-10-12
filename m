Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56AFCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 23:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C76080C0C;
	Mon, 12 Oct 2026 23:56:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YEh1nxtN8XS; Mon, 12 Oct 2026 23:56:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 992E380BF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791849391;
	b=LhLsMB0SymqEZKDmOWqK/f+1Q5lRodTp747WtMz2BGW6KQcT1hTqfA9UncUIAu2AieSz
	 ZwdbWKSu2Zz7C8wWBGvahWWJJahYM+fUDPlaYQwuZe+vxQvSOnmsekTpRroym0mqIUR7+
	 ZQ6c2cm9W8vAEFXSjGql1E76tqjqEgPYuFLf6sx4Tcbodkmst/dQkuJEFCTAt5grPHoFp
	 NZnENX2Qmpwar6oEc4bKwlcp32epFALAIJk/nc4MU69y7N/DSnS3mAvLw39bsniKtThPJ
	 OO2kWveN/tkOFvPhZ/4SPqJ8M3rdbOO4lctO+SXibU1Z5T9W4p1rMsByB7k9n5liDzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791849391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xZi6EsCfEFtpvuIzT639x5xa5bV+3n0SUqa14eIOxU0=;
	b=p/BxZYGxrk/WGiAxJNFBZSj6DqKZ5ZlETjvQVHhkNrlx2oflUHwU1U+LSPKfEKoZ4hRo
	 3kufmIzel33t4595nVKCGaxC+txoD3eHXiIegqics69eUuqtoKS53r8BH3D5XfnUzJyMa
	 Gy2ymqgqjN8naU2SvGKSpsUwXwzXhFEmaCb+2iaO2mzKihIxhjxj283wu39tn+tkd2vrj
	 koxQENr1u1j/7+Z0oHq82v5aMmfgoz6buxBruQ9eCdkPkHVW4R+ppafMxCqsEpp0pmjBP
	 YH+OZj2Atq/9oS56EDicUIC7U8semFHLdm9cuVhihN1zAQgqY9hFmnSjYhvh/MFW4nQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791849391;
	bh=xZi6EsCfEFtpvuIzT639x5xa5bV+3n0SUqa14eIOxU0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y8H5gAhbP1AegsJ18FJxqqLglcdI8l1704FQwciS9EoQI37xLK2g+B25INU17CcOk
	 R54xf3K6albl5xjutCo6j6+mJUjGNnny+LVVMjKs6/hv87snAYLhmyectz+lrgrxzV
	 Yh2ypy1z2Ki0yw7L+P3LkmHSvVPeqPTXcIrNxWtQL6atXNv9WopQ+E69ETAkQFfJ+2
	 YCh+ZEemiFcyUFJNbZ/jqVZVaKcTZeMADGcwpKm3WYkK8v5GNOU1tC2mg1DJs4eYND
	 v/aYaHQWDPkSnfIYm1jG1xUYfYaocj3Cb1hVo+oI8SD3Vn+fXRQtNWshW6QwtZJXTV
	 lsoGHFeifjSPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992E380BF3;
	Mon, 12 Oct 2026 23:56:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5AC7105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B034840567
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iEe64RsIc1p for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 23:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 107AF40557
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791849389;
 b=TiU/6jKmShCPgTIkIOqvk/H0mv8GamLyavzUPLhbjoA0KrtfPRoVIeoict5oreU+/1B5
 feXrsTYIgfiK6bbT/prsD0Uh7GuyGPpWikyd1Ct4Jmu8mEDhdpVWGlIDYyeXZ+LXcmukh
 s2lNgAvwLxQanNP0D9eFmWvZBoLdPyEQoTIxEENuyrSUT4aOK5UtminURfOBau+GB8qKN
 zBF0ZIlRTITDxPRaQ53l4Dmpk+b66LSVxJKPqu3sJRNFPSysivctUwX1BqTkSMKvAcw8J
 Rt7rvMqM0kFhavnWjxWhVvt2QEabk6A7Jno6YFNX55F0zwa07m/ysU0gL7OvbN4t6rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791849389;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=xZi6EsCfEFtpvuIzT639x5xa5bV+3n0SUqa14eIOxU0=;
 b=UJ8u0hpN7qmvu7EdZPiLc241HGdAWcBO+YFvyADJFgIY8OuxEK5lOoyx277fW8G0h5y1
 x2aJgvkv7ZGeXI/o2u1/NYLDNMJTE455F+mvgh26+esmSKEdHyYX/Plzz/zlWn0zJGiQF
 Ew/pRGEx08UxMwaTmt0FBiOpQtr8vAivjYoP0OX6bRL9WS2Fg75dICGDIeXonG2z4m8VS
 5OGAYCv9h4f/2Vc+WFccau7ySq4HOQhUjiGwZJfL5FVFm/SkZ8rOxumdGpUI5e2vyXQ2y
 UBfsud8SvQQjvWPZzBr2NDWvFYGWZjNijm5lhMV13Xh7s2kb9eJ5XIB4KoGA4PREMig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=ARm8Ac8G; 
 arc=none smtp.remote-ip=68.232.154.123
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 12 Oct 2026 23:56:29 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=ARm8Ac8G
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=73821bd0a=charles.perry@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 107AF40557
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791849389; x=1823385389;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=F3516FRYcexPe+mGQtrZNb8lBdq4DQYtbDD0290GczM=;
 b=ARm8Ac8GiYcdckh0vrQsYCp8TJH2fNAc3zQJ9+UqFsmfZSGWRACoUNiv
 MwNndKGkWuXxjXop6dDleU/9ml6NDWhYir6upzKDQ1acMwiAVZOJ6D+WW
 8tLdkhirIvbH2CcEeS5YGhUoIX85pbUE/QMNToRGrb3PtDmUrhvFsHoOg
 elXsd7zyKimWI9dmaM10nOR0V40CaBpTEGfspM9zLQmBr1IuI9I9tIg8i
 XuFFUC5s72F+gw7glGwj+lQGJCq0hh+JOObkYSv0APodrOiAlnuR/vJpA
 SJEYD5LylkxouLKCo/tFR22oBWnQsbq8GEHWxfe1PvAKT0PyomnUnrBkw g==;
X-CSE-ConnectionGUID: 6QBl+9x+SDmEuWZ6E9sk8A==
X-CSE-MsgGUID: lnSCtvMrTv2fFmzB6EUyEQ==
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; d="scan'208";a="65207950"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 16:55:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 12 Oct 2026 16:55:24 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 12 Oct 2026 16:55:21 -0700
Date: Mon, 12 Oct 2026 19:55:05 -0400
From: Charles Perry <charles.perry@microchip.com>
To: Michal Simek <monstr@monstr.eu>
CC: Charles Perry <charles.perry@microchip.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, "Paul
 Walmsley" <pjw@kernel.org>, Rahul Pathak <rahul@summations.net>, Anup Patel
 <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, "Heinrich
 Schuchardt" <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
Message-ID: <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
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

On Mon, Oct 12, 2026 at 11:47:51AM +0200, Michal Simek wrote:
> Hi, +Paul

Hello Michal,

> 
> first of all do not use mailing list on denx.de.

Ok, I sent this series at around the time U-Boot changed to
u-boot@lists.u-boot-project.org. Sorry for that.

> 
> On 9/2/26 16:17, Charles Perry wrote:
> > Hello,
> > 
> > This series adds support for RISC-V Platform Management Interface (RPMI) to
> > U-Boot. RPMI is an OS-agnostic protocol for communication between an
> > Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
> > goals and purpose of RPMI are similar to ARM's SCMI.
> I have raised my concern at riscv minisummit at LPC and also talked to Paul
> (riscv kernel maintainer) that this is not the right way to go. We already
> have SCMI and there is no reason to introduce RPMI when it is said it is
> serving the same purpose.

Cool! Thanks for bringing this topic to LPC!

That being said, I don't understand why we can't have both SCMI and RPMI.
For sure its more code to maintain, but there are other things at play than
just the functionnality. We discussed this in v2 [1], the points of
contention were:

 * Anup said that the main blocker for him is that the SCMI spec is not
   community driven while RPMI is.
 * Conor mentionned that for SCMI to be usable on Risc-V, OpenSBI needs to
   accept SCMI related patches.
 * I pointed out that SCP-firmware doesn't receive any upstream
   contribution [2] while librpmi does. Features of newer SCMI specs like
   reparenting clocks are not available in upstream SCP-firmware
 * It was also mentionned that there is already a clock driver available in
   upstream Linux [3] and a power-domain driver has approved recently [4].
   So RPMI already has some traction.

> 
> R is for risc-v. It means it is not cpu neutral platform management
> interface as was positioned. It has less features then scmi. We have risc-v
> in programmable logic and scmi server for platform management which service
> ARM cores too. There is only SMC transport layer which is ARM specific. The
> rest is completely soc neutral.

I understand that you are building heterogenous systems and that having
only one protocol to support will solve lots of problems for you, but that
doesn't mean we have to roll back all the progress that was made so far
for RPMI.

My suggestion is that we stick to what we have in RPMI for the protocols
that overlaps with SCMI and have a ratified spec as of now which are:
  * clocks
  * power domains
  * voltages
  * performance domains
  * system shutdown/suspend

There's however protocols in SCMI that have no RPMI counterpart ratified.
Those are:
 * Reset domain
 * Pin control (There's an open PR for this [5])
 * Sensor management
 * Telemetry (A PR was closed for this last month [6])

And for these protocols, you should be able to make suggestions and steer
the RPMI spec so that it looks more like SCMI so that we can reuse existing
drivers in Linux, U-Boot, zephyr, etc.

[1]: https://lore.kernel.org/all/20260708215200.1331416-1-charles.perry@microchip.com/
[2]: https://gitlab.arm.com/firmware/SCP-firmware/-/commit/f76402dfefc7557b97aac6226c0b1302e2dc5e12
[3]: https://elixir.bootlin.com/linux/v7.2.9/source/drivers/clk/clk-rpmi.c
[4]: https://lore.kernel.org/all/20260903092347.620060-1-joshua.yeong@starfivetech.com/
[5]: https://github.com/riscv-non-isa/riscv-rpmi/pull/163
[6]: https://github.com/riscv-non-isa/riscv-rpmi/pull/162

Thanks,
Charles

> 
> I don't know history around it but make no sense to me to introduce it at all.
> 
> Thanks,
> Michal
