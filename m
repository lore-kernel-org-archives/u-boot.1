Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B043E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 05:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D06548021A;
	Wed, 18 Dec 2024 06:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NQWPSF/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46E78021D; Wed, 18 Dec 2024 06:08:43 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2335780214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI58dtm110584
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 23:08:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734498519;
 bh=C1wK17Bpm7iGgGdDUIIHcp365Ics4G07uhIznf1WLXk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=NQWPSF/SbRADk3gpau83r204hwZSkQ/CLpDA/3ysy03kq+P1mmBu4J+9VFp77Qd3n
 5Pjy1+8Qeg0p0owOgDDB8xjUy57qsT6rMNqlX49QbWGOIngcv/5/AbRMWLZA/ZyGQt
 gPCGJX/dHkxBpRE6dieHWNTgszcFhYdziYJeE+As=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI58dfP101811
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 23:08:39 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 23:08:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 23:08:38 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI58c3K017183;
 Tue, 17 Dec 2024 23:08:38 -0600
Date: Wed, 18 Dec 2024 10:38:37 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] drivers: firmware: ti_sci: Add DM_FLAG_PRE_RELOC to driver
Message-ID: <20241218050837.5fppn7j7s5vv5f5m@uda0497581>
References: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
 <20241217145300.GN1505244@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241217145300.GN1505244@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Tom,

On 08:53-20241217, Tom Rini wrote:
> On Tue, Dec 17, 2024 at 02:24:37PM +0530, Manorit Chawdhry wrote:
> 
> > Currently the driver relies on bootph flag to probe it during PRE_RELOC
> > stage but with the upcoming cleanup of v6.13, we don't have the bootph
> > property in the parent nodes anymore and ti_sci driver being one of the
> > parent nodes required during SPL stage would end up hampering the probe
> > model [0].
> > 
> > Add DM_FLAG_PRE_RELOC to ti_sci driver for mitigating this issue.
> 
> 
> Can you please expand on why with v6.13 we don't have the flag anymore?
> Thanks.

So the idea was that following series [0] would help us cleanup all the
parent node bootph-* tags as putting a bootph-* in child node implies
that it applies to parent nodes as well, though even if the parent node
gets packed after the following series, the parent node still don't get
probed as from my understanding, we need bootph-* tag to probe the
driver as well but the phase tag doesn't get propagated as such.

So while working in Linux, some comments related to this was raised [1]
and after confirming the behaviour with Simon [2], the cleanup was done
in Linux and meanwhile this way was found to probe the driver so that
even after cleaning up the parent bootph-* tags we can continue.

I don't think it's a hack also as this driver is required pre-relocation
and this is another way to probe it pre-relocation but the only thing is
that since the cleanup is done right now, we would kind of need it to be
booting in some platforms ( that were fully reliant on Linux DT and
don't have -u-boot override for this particular node with bootph-* )
before 6.13 DT gets synced up.

[0]: https://lore.kernel.org/u-boot/20231217163627.2339802-1-sjg@chromium.org/
[1]: https://lore.kernel.org/all/20240709084857.nf7c57mi6miajeau@uda0497581/#t
[2]: https://lore.kernel.org/u-boot/CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com/

Regards,
Manorit

> 
> -- 
> Tom
