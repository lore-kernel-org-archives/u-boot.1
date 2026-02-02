Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650A8E73141
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 07:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663B583CEE;
	Mon,  2 Feb 2026 08:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZIzIy5eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8EC83D5D; Mon,  2 Feb 2026 08:57:58 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B9683C51
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 08:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 547BC60008;
 Mon,  2 Feb 2026 07:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61251C19421;
 Mon,  2 Feb 2026 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770019073;
 bh=Xqk64kk3/OELhWBQ0hN1gJWWsSt4+ohbVhOY1qG1E68=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ZIzIy5egcxsSStnXaKqkHdSzTad3hprFAM0VD0+HHSIA54aNRIvBDY4k8OFU7cAae
 IVNlUwDDKvvE1TGV4Ro/76Koqgg4QafviZSGFc5zwRlJdx5je8B7Vblgv2d/fmC4L+
 tTID9cmO4hv1OUdeuO/zth9FOtfHAgO4O/hM4yvvnBKF2wBZuuhDCuoXqgVAgaLzpr
 Ph6A1GKEM//NGlYDY6qpq22OPR59vz0l/HqyLBnbtPMr6oHLlPib3m/HiAMNNr1VAM
 3tz70pcWct9T39NByxXYfDHD9JcEmNI6Y9Iu0cnfSuevaNRB7cv/oBfH2QoXIZ/zWz
 IWhCnqgwVUmpw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de, Sam
 Protsenko <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH RESEND 0/2] Support for Samsung Exynos 7870 USB PHY
 device in driver
In-Reply-To: <DG3J6PCL3WLX.872U6GFC8HCW@disroot.org>
References: <20260103-phy-usb-exynos7870-v1-0-08f3e9814b86@disroot.org>
 <DG3J6PCL3WLX.872U6GFC8HCW@disroot.org>
Date: Mon, 02 Feb 2026 08:57:50 +0100
Message-ID: <874inzmvb5.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Kaustabh,

On Sun, Feb 01, 2026 at 15:21, "Kaustabh Chakraborty" <kauschluss@disroot.org> wrote:

> On 2026-01-03 18:22 +05:30, Kaustabh Chakraborty wrote:
>> This patch series aims to add support for the USB PHY in Exynos 7870
>> devices. This can be accomodated in the existing driver, the patches
>> implements the ability of multiple devices to be driven by the same
>> driver.
>>
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>
> Hi, are there any updates regarding these patches? Any movements?

According to ./scripts/get_maintainer.pl, Sam is the maintainer for this:

$ ./scripts/get_maintainer.pl  drivers/phy/phy-exynos-usbdrd.c
Sam Protsenko <semen.protsenko@linaro.org> (maintainer:ARM SAMSUNG EXYNOS850 SOC,commit_signer:1/1=100%,authored:1/1=100%,added_lines:386/386=100%)

However, it seems the series is assigned to Marek (USB Maintainer) on patchwork:
https://patchwork.ozlabs.org/project/uboot/cover/20260103-phy-usb-exynos7870-v1-0-08f3e9814b86@disroot.org/

Since Marek is not part of this mail-thread, it's very probable that he
missed this.

Marek/Sam, who is picking this up?

Do you want me to take it in through u-boot-dfu ?

>
>> ---
>> Kaustabh Chakraborty (2):
>>       phy: samsung: add enum for variants based on SoCs
>>       phy: samsung: add support for exynos7870 USB PHY
>>
>>  drivers/phy/phy-exynos-usbdrd.c | 271 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 261 insertions(+), 10 deletions(-)
>> ---
>> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
>> change-id: 20251014-phy-usb-exynos7870-c2f2ac44fd65
>>
>> Best regards,
