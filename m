Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B00C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 21:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2954287FF0;
	Thu, 20 Jun 2024 23:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AeRjGfBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C83831A1; Thu, 20 Jun 2024 23:35:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A2588440
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 23:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45KLZdSq075801;
 Thu, 20 Jun 2024 16:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718919339;
 bh=SfW40SXqMt3xZbMEHXVjImVTLT/7Td/laNCuTjnMzGY=;
 h=Date:From:To:CC:Subject;
 b=AeRjGfBJo/na8fXqRV3TeW+QV0YuQkHBM49CA/18Eb57pMgI2tHJD2CokFoaBCxDR
 W9qOgAx28SWiuY3tjYqD+S7jyMKAuHsEOaLT6WplZF63cFqovQfhqxBbFQG393+9jI
 QBFeaOSDurrVl1shmDH0RHV1a8jOBtG6oDLe2Cb0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45KLZdXW096990
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Jun 2024 16:35:39 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jun 2024 16:35:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jun 2024 16:35:39 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45KLZdDC069292;
 Thu, 20 Jun 2024 16:35:39 -0500
Date: Thu, 20 Jun 2024 16:35:39 -0500
From: Nishanth Menon <nm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, Enric Balletbo i Serra <eballetb@redhat.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Josh Boyer <jwboyer@redhat.com>
Subject: Request for hosting a boot-firmware repository in u-boot git (denx
 and GitHub)
Message-ID: <20240620213539.ftmjhphypssxp5n4@desolate>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hi Team,

We have briefly discussed this topic on IRC[1]. I would like to
propose a new boot-firmware repository similar to the Linux-firmware
repository under the aegis of u-boot hosting.

In addition to TI, it looks like some NXP[2] and Rockchip[3]
platforms seem to require additional closed-source/open-source
binaries to have a complete bootable image. Distribution rights and
locations of these binaries are challenging, and there needs to be a
standard for how and where they are hosted for end users.

Further, looking ahead to future architectures:
* IP firmware: More and more IP vendors are embedding their own
  "specialized controllers" and require firmware for the operation
  (similar to Rockchip's DDR controller, I guess),
* boot stage firmware: Additional stages of the boot process involve
  vendor intermediate firmware, such as power configuration.
* Security enclave binaries: While I see a few folks trying to have an
  open-source s/w architecture, many PKA and PQC systems still require
  prop binaries for IP reasons.

NOTE: I am not judging any company(including TI) for reasons why some
firmware is proprietary, but I hate to have the end users and other
system (distro) maintainers have to deal with hell trying to make the
life of end users easy to live with.

In the case of TI's K3 architecture devices, we have two binary blobs
that are critical for the boot process.

1. TIFS Firmware / DMSC firmware[4]—This is the security enclave
  firmware. It is often encrypted, and sources are not public (due to
  various business/regulatory reasons).
2. DM Firmware[5] - There is a source in public in some cases and
  binary only in others - essentially limited function binary to be
  put up in the device management uC. In cases where the source is
  available, the build procedure is, in my personal opinion, pretty
  arcane, and even though in theory it is practical, in practice, not
  friendly - efforts are going to simplify it, even probably integrate
  it with a more opensource ecosystem, but that is talking "look at the
  tea leaves" stuff.
3. Low Power Management (LPM) binaries: tifs stub: another encrypted
  binary that gives the tifs system context restore logic before
  retrieving tifs firmware and a corresponding DM restoration binary.

All told, this is not unlike the situation that necessitated the
creation of a Linux firmware repository.

Options that I see:

1. Let the status quo be - SoC vendors maintain random locations and
  random rules to maintain boot firmware.
2. Ask Linux-firmware to host the binaries in a single canonical
  location
3. Host a boot-firmware repository - u-boot repo may be the more
  logical location.

* (1) isn't the correct answer.

* (2) Though I haven't seen any policy from the Linux-firmware
  community mandating anything of the form, the binaries we are talking
  of may not belong to Linux-firmware as they aren't strictly speaking
  something Linux kernel will load (since the bootloader has that
  responsibility), and in some cases may not even directly talk to
  (security enclave or DDR firmware stuff). I am adding Josh to this
  mail to see if he has any opinions on the topic (but keeping
  from cross posting on linux-firmware list, unless folks feel it is
  OK).

On (3):
Proposal:

* Create a boot firmware repository in Denx and/or GitHub (if
  financials are a hurdle, I hope we can solve it as a community).
* Limit binaries only to those consumed part of the u-boot scope.

* Limit binaries only to those that do not have an opensource project
  (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
  source or are binary only in nature (subject to licensing terms below)
* Limit binaries to some pre-established size to prevent repository
  explosion - say, 512Kib?
* Follow the same rules of integration and licensing guidelines as
  Linux-firmware[6].
* Similar rules as Linux-firmware guidelines of ABI backward and
  forward compatibility.
* Set a workflow update flow and a compatibility requirements document

If we agree to have boot firmware under the stewardship of u-boot, we
should also set other rules, which is excellent to discuss.

Thoughts?

[1] https://libera.irclog.whitequark.org/u-boot/2024-06-13#36498796;
[2] https://docs.nxp.com/bundle/AN14093/page/topics/build_the_u-boot.html
[3] https://bbs.t-firefly.com/forum.php?mod=viewthread&tid=2236
[4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-sysfw?h=ti-linux-firmware
[5] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-dm?h=ti-linux-firmware
[6] https://docs.kernel.org/next/driver-api/firmware/firmware-usage-guidelines.html
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
