Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBD2C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 06:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC2988976;
	Fri, 14 Jun 2024 08:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IvVJrccE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF5D87DD3; Fri, 14 Jun 2024 08:04:42 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C878897E
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 08:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E64bMS075287;
 Fri, 14 Jun 2024 01:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718345077;
 bh=SyzuxRi3Fb0rDizoYlYr+2qqTnTitkxEtm7JnfKtZH4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IvVJrccExQw5GxMC1H5fp7frmafb20WPMkn2mWFKJr/zQNTfdIV35+7Y5YyLbbeRG
 RXuRXl7ANr/8FdMud8c6idZGhu6v0DerLLcaW9zWSuO2f1gITy5EM4PNzN4wVQcIEn
 nBjjZRY8Esfgmf3F9GcgqDTydyal/uUgJGdr0MXA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E64bhj019984
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 01:04:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 01:04:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 01:04:36 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E64aYE011361;
 Fri, 14 Jun 2024 01:04:36 -0500
Date: Fri, 14 Jun 2024 11:34:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vibhore Vardhan
 <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Nishant Menon
 <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Judith Mendez <jm@ti.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
Message-ID: <20240614060435.ema3wczc7r7tgetu@dhruva>
References: <20240613080604.3828083-1-d-gole@ti.com>
 <CAOCHtYjAFE0sbyYRXnbsv9EohNfH99vsuVYiZbi2Ami_xdoxWw@mail.gmail.com>
 <CAOCHtYi7vjHeCcUzgDBkayGx9W3gR6MT==8ASf+7524pu21Vbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCHtYi7vjHeCcUzgDBkayGx9W3gR6MT==8ASf+7524pu21Vbw@mail.gmail.com>
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

Robert,

On Jun 13, 2024 at 16:51:24 -0500, Robert Nelson wrote:
> On Thu, Jun 13, 2024 at 4:47 PM Robert Nelson <robertcnelson@gmail.com> wrote:
> >
> > On Thu, Jun 13, 2024 at 3:06 AM Dhruva Gole <d-gole@ti.com> wrote:
> > >
> > > The Kernel Image and DTB files are supposed to be picked from the rootfs
> > > of the SD Card, this fails in legacy boot flow because bootpart is set
> > > to 1:1. Fix it.
> >
> > and where is that rule defined?
> >
> > Production boards ship with Kernel Image and DTB's in the 1st fat partition..
> 
> Besides, u-boot should scan for extlinux.conf on "any" partition.

I can see where you come from, and I agree on the above points when it
comes to stdboot.
However when a user wishes to use legacy boot, and in the case there
isn't extlinux.conf in such a case u-boot will rely on information in
the env file (please correct me if my understanding is wrong).

The env file says:
bootdir=/boot

Thus u-boot ends up looking for Image and dtb in /boot/Image under BOOT
partition, and ultimately fails, because the /boot/Image path is
generally found inside the root partition ie. 1:2

The idea of this patch is to keep support for such legacy boot alive, if
you feel there's another way to do this feel free to suggest.

--
Dhruva
