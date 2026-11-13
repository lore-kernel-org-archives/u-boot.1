Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC6606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZV9FALV3;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=frZ1Imn3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF8924090E;
	Fri, 13 Nov 2026 21:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2oucyaQx_Ucp; Fri, 13 Nov 2026 21:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3477340927
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794605820;
	b=LpU9+t6npQUKvzY7GOG0l7UGpYvP3NxXrehn/9gHABCnZzWKy872h0bN7vFI9c9taFRH
	 HSaFOsab5tTFltKJZO30hF14gRL1hoRiW76hwEUe52+dyxEUEfrj6zEm8ri1Un4owKAB6
	 fgMi6io3naqsUR8L1oXgMaDJWHnjnf8S0KiS1dgFA7u+XXo9YpwYhUZJFGKZ0jRK+RkN1
	 Ynd49vxHHorb0X2+zWI5damed+iWin0jeHq0COxpSif9xvR0tgQiEjPNnR8bOf2OtIHme
	 WjmMWAE1OkD499HCihXIcr2wTWFaHMkJNTs1QXhqJGCBgBnWZ33+MrozkkQBOMmADLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VEdsyQ2IYweAigK11PFs2OfjBMKUjX9j5yNqNHWyZrk=;
	b=B5T3/qyGHOwS+kEgT5nIMI8arOgqi+pbSfno60ja81AGp7x9ZzR++YWSaKfqQPvAbfd/
	 KNdn2hpk/U0amKCTliF04v06M0lQ5ZdZnS1wPNaSpo9y4bb5llDHkwgnEpSjTDmqGrUOa
	 K5FNaDzq6XPJbS80afKqADEM9jYzSJBsJwyADrB3vnRUUnAKQNurIav6o71naNtm3PZYV
	 ZT/c0mdKo/gmW+TuJAIshv6FiQQvIqFhny7tY0yW1o2QeZeIIid25MuNGlWZV9l2w34K5
	 6/oOkINjs7O2XUT2BvXxcRm9pyBPQ231urOdXB8tI0zi6o97vcuSJ2GloiOrA9rQv3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794605820;
	bh=VEdsyQ2IYweAigK11PFs2OfjBMKUjX9j5yNqNHWyZrk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZV9FALV3EX7h45NCgGyKa/jdvIVf/jTayqqqqq2uZY9Uh/BNYPfu80p1chSn+BnQn
	 gExthWUoaGtezfqacLGDgUppteSP90BEft6OELvbHkJ236Vh/EX3iXxw6lwnGB2bau
	 4V02OkjffmFLnJnJecuiPlB13LAAaLmvlEtlkYp07jwl03tTs7ggIDgIVkIZaa1d67
	 tGngUDXgdyPElnCq6s9pwUyEDoW7hQ7tF6OidoE6L+smAVeMzVfqQ2Q8mVr5XGXja7
	 3YaX2tReF76Dgyx8d0Kf0sr/Z8G1NN/9jYAWoHRjCwRFjBAMXdhP4kLpD4O1IPFLEq
	 D8puEGtQU3b9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3477340927;
	Fri, 13 Nov 2026 21:37:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9622A260
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 21:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8079C8113A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 21:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lKdTi9spV7IA for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 21:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A8C1581022
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=frZ1Imn3
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8C1581022
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 21:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794605826; x=1826141826;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nhceubyHRgsk0EGKnkybCe3Oxvlp1vbDe86UYXgsyBk=;
 b=frZ1Imn3foVIo4wFL04KBcVHbthZfqj2h/nYYuyjmjrFmwA9zvqfMB+7
 Ges8pwghuHmn//GIpLLRvTUZtoz2RB0QD7jJ00JOrgdP4Y5GYjN5sDsbj
 WWFaNXeuOc7Xx+w1N5P8iflOO3yzwUXzrkmCBI8NHoRbHwgLJKPlDIbzg
 aAHp3VabaBaKcHxL5UWvMhTzL/D/pKH1ezNznInN+Y80GkKwcd30Z8E8m
 ykYy4P6Y0a9xyovPYkwhISJRoREBbnuk+57/FU8zL7JActCjr2xcba44k
 /cspvkj7nq7QjOmZikqfunfBuvZwP1MDfJSk4mCVAqqejo0pMU0rNbmTy w==;
X-CSE-ConnectionGUID: PvhUIK7mR6G+Y5CeO9CZfg==
X-CSE-MsgGUID: iBKQRQUSTnq4cQGCF/bGWg==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="66489132"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 14:37:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 13 Nov 2026 14:36:54 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 14:36:51 -0700
Date: Fri, 13 Nov 2026 16:36:49 -0500
From: Charles Perry <charles.perry@microchip.com>
To: Tom Rini <trini@konsulko.com>
CC: Charles Perry <charles.perry@microchip.com>,
 <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>, Rahul Pathak
 <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Rick Chen <rick@andestech.com>, "Leo Yu-Chi
 Liang" <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>, "Conor
 Dooley" <conor@kernel.org>, Peng Fan <peng.fan@oss.nxp.com>, "Subrahmanya
 Lingappa" <subrahmanya.lingappa@oss.qualcomm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/8] Add support for RPMI to U-Boot
Message-ID: <aveC8cmCelxC0Hvi@MON-LT-C78453.mchp-main.com>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113194911.GP554944@bill-the-cat>
 <avdtFdcuCvG6YE7f@MON-LT-C78453.mchp-main.com>
 <20261113202447.GQ554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261113202447.GQ554944@bill-the-cat>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 02:24:47PM -0600, Tom Rini wrote:
> On Fri, Nov 13, 2026 at 03:03:33PM -0500, Charles Perry wrote:
> > > 
> > > Once QEMU is updated, do you plan to update / add more tests, so that we
> > > can run those tests, and presumably have more comprehensive testing, in
> > > CI? Thanks.
> > 
> > That might not be possible because I need a special patch on top of
> > Subrahmanya's series to add the clock service and some phony clocks. This
> > clock service isn't going to be upstreamed to QEMU because it's somewhat
> > useless outside of testing.
> > 
> > For CI testing, the path forward would be the sandbox mode that I added.
> > The only drawback to this sandbox mode is that it will NOT test the transport
> > layers, only the services.
> > 
> > QEMU is nice because it does test both transport layers and the services
> > themselves with librpmi and OpenSBI (but I need the special clock patch,
> > and we also need to build OpenSBI).
> > 
> > I'm open to any suggestions that would improve testing and CI.
> 
> If you take a look at tools/docker/Dockerfile you can see how we build
> QEMU (and some other tooling) today, for CI needs. A question I have now
> is, is there value in U-Boot testing the transport layer, or not?
> 

Ok, thanks. I'll look into that.

For sure testing the transport layer will have some benefit. I think the
plan should be to have a QEMU test that checks if the firmware driver can
probe successfully. There are a few messages sent between the U-Boot driver
and librpmi/OpenSBI on probe. That would gives us some confidence that the
transport layer works.

We could even test the poweroff/reset commands since this is in
Subrahmanya's upstream patchset. Although that would only test the M-mode
(shared memory) driver as for S-mode poweroff/reset uses standard SBI ecalls
and not the MPXY ecalls.

And then for testing all the services implemented on top of the transport
layer, the sandbox mode (not QEMU) would be the way to go.

-- 
Thanks,
Charles
