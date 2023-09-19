Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C0ECE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 21:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B724686B28;
	Tue, 19 Sep 2023 23:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="oCEY0DXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C91086B22; Tue, 19 Sep 2023 19:26:42 +0200 (CEST)
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com
 [IPv6:2001:41d0:203:375::de])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C8986479
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=konstantin.ryabitsev@linux.dev
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1695144398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWjKF4/Vm40N6J8JKdHprjM1TtAEp/nNBu7lzV7m8hE=;
 b=oCEY0DXxCeoTDVj3S489mFPWipSYMD7yCQjfWnyEnVg3swc2rOuITpMhD91Rtyp2pAR1cf
 Gpu5wO+Tb1JQ2I8kYZWprdv1/hoO+8WSFGYqtZmOGXhOunHHNIFgj9h5TAw2zU6VZX0wCY
 2VubUkf72lXBx0/IjV4//IqdRkQ6pBA=
Date: Tue, 19 Sep 2023 17:26:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <3cf2e853b134779ae0f3809321cc6289ceda1802@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] J721S2 DTS Sync from v6.6-rc1 to u-boot
To: "Manorit Chawdhry" <m-chawdhry@ti.com>, "Nishanth Menon" <nm@ti.com>
Cc: "Tom Rini" <trini@konsulko.com>, u-boot@lists.denx.de, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Neha Malcom Francis" <n-francis@ti.com>,
 "Udit Kumar" <u-kumar1@ti.com>, "Reid Tonking" <reidt@ti.com>, "Apurva Nandan"
 <a-nandan@ti.com>, "Andrew Davis" <afd@ti.com>, "Nikhil M Jain"
 <n-jain1@ti.com>
In-Reply-To: <20230919112053.g2dwnssl7s7hqjo5@ula0497581>
References: <20230919112053.g2dwnssl7s7hqjo5@ula0497581>
 <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
 <20230919111314.aumeucsnla6bk6zn@librarian>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 19 Sep 2023 23:43:53 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

September 19, 2023 at 7:20 AM, "Manorit Chawdhry" <m-chawdhry@ti.com> wro=
te:
> Am not sure either.. I had been using b4 for all the patches and I stil=
l
> see that my next revision queued by b4 also has the same problem. Not
> exactly sure what went wrong with b4 but would be careful next time.
> Thanks for pointing it out.

I'm curious how this happened as well.
Can you please send me the output of:

b4 prep --version
b4 prep --show-info (while in the branch that caused this problem)

-K
