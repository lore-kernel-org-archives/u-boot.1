Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320A8CE79AC
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 04:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27DE786BE8;
	Wed, 20 Sep 2023 06:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PxxIkQ85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5697086B34; Wed, 20 Sep 2023 06:40:08 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C378486BE8
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 06:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38K4dqg4001215;
 Tue, 19 Sep 2023 23:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695184792;
 bh=uU/2hIlia75A3YcF6peBZVkaHu2B9J3PikrZeIjo7Qw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PxxIkQ85wHLoH+da16GqVbF/Zy25tfr/Ns052+ypB2KFnqvzCiOghUpaOpUcahBvz
 OBeZC5BF2Go6GiHLUo6MEY4ET60xcDLoHHFBOgF4TZuHLT8krnYCPGv+EeOvHaDlhx
 8UjxQgjgu5fp08aPkMsYF2BKMqcPsvuj9Iu9c8uM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38K4dqJM058724
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 23:39:52 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 23:39:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 23:39:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38K4dodS038365;
 Tue, 19 Sep 2023 23:39:51 -0500
Date: Wed, 20 Sep 2023 10:09:50 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Konstantin Ryabitsev <konstantin.ryabitsev@linux.dev>
CC: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, Reid Tonking
 <reidt@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>, Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH] J721S2 DTS Sync from v6.6-rc1 to u-boot
Message-ID: <20230920043950.vkrat7eyihjlszr7@ula0497581>
References: <20230919112053.g2dwnssl7s7hqjo5@ula0497581>
 <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
 <20230919111314.aumeucsnla6bk6zn@librarian>
 <3cf2e853b134779ae0f3809321cc6289ceda1802@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cf2e853b134779ae0f3809321cc6289ceda1802@linux.dev>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Konstantin,

On 17:26-20230919, Konstantin Ryabitsev wrote:
> September 19, 2023 at 7:20 AM, "Manorit Chawdhry" <m-chawdhry@ti.com> wrote:
> > Am not sure either.. I had been using b4 for all the patches and I still
> > see that my next revision queued by b4 also has the same problem. Not
> > exactly sure what went wrong with b4 but would be careful next time.
> > Thanks for pointing it out.
> 
> I'm curious how this happened as well.
> Can you please send me the output of:
> 
> b4 prep --version
> b4 prep --show-info (while in the branch that caused this problem)
> 

I believe it had been my mistake, there is a bug in b4 that I had been
trying to fix locally but forgot to cover all the cases for that. I
believe that caused it to break. The bug is basically that when you
apply patch prefix, the prefix actually wasn't behaving like a prefix [0].

I have re-spinned my local fix but if possible, please let me know if
there are any mistakes that you see in the current patch as well [1]. If
possible, I would like to upstream the fix as well as am not sure where
I can reach out to for this. Thanks for reaching out.

[0]: https://github.com/mricon/b4/issues/3
[1]: https://github.com/manorit2001/b4/commit/463b32ab67696daec743ba7d85e8dc4da4edb2f1

Regards,
Manorit

> -K
