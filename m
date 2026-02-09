Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE08E78D44
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 08:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A191283BC9;
	Mon,  9 Feb 2026 09:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="MZcEqDr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EAFB83BDD; Mon,  9 Feb 2026 09:39:04 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC43839A5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 09:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8C7181FCC4;
 Mon,  9 Feb 2026 09:38:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770626339;
 bh=ePA0lsNJ3FHkQ4enw+mIQHjXvA24+Y3GM+I4TRU7qLM=; h=From:To:Subject;
 b=MZcEqDr0Tvf1g9zK3XaBJfIi0Ffu02b+im+8kNywmNS+8cGTANiBy0C7xyK8IxgGA
 onsSW8fYazCp4kmI1zGuCQRKoilwKDXq5JGZJWOfyBEyYv2i4DFpNzSWilbaT/n8fV
 LxzfW2sEptbMDSJF6CgdXw+ydshavauD5xIbH51QYQLlF6jpxbwiIyQpTMLzngnIDr
 A6l6dTK6rrN4AZvYOiUZznyvvOeuM4EXCHLFbD07ThVebKMtdh2JUI84y8KMV0A4AZ
 VKsUjYknlq7K4GKV3/KLN/Gb4xOiPDX5bhZlCPLzvqEaFDUdQzkBjUlIv6Mm2M6Rxk
 LAyRBq/PxJuvw==
Date: Mon, 9 Feb 2026 09:38:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: u-boot@lists.denx.de, Suhaas Joshi <s-joshi@ti.com>, trini@konsulko.com,
 vigneshr@ti.com
Cc: n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de,
 w.egorov@phytec.de, ggiordano@phytec.com
Subject: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260209083855.GA9367@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7fa524,
everything was fine with b5213bbfdcb1.

Looking at the commits between the two revision, I would say that the
issue is with this series https://lore.kernel.org/all/20260127081652.506357-1-s-joshi@ti.com/

Suhaas: Can you help?

Failure::

U-Boot SPL 2026.04-rc1-0.0.0-devel+git.42b3ee7fa524 (Feb 08 2026 - 16:14:45 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
Failed to set clock rates for '/a53@0': -22
SPL initial stack usage: 13504 bytes
Trying to boot from MMC1
Authentication passed
Authentication passed
Authentication passed
Loading Environment from nowhere... OK
init_env from device 9 not supported!
Authentication passed
Authentication passed
Starting ATF on ARM64 core...
NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
U-Boot SPL 2026.04-rc1-0.0.0-devel+git.42b3ee7fa524 (Feb 08 2026 - 16:14:45 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')

## ... and after that just no logs at all.

Success::

U-Boot SPL 2026.04-rc1-0.0.0-devel+git.b5213bbfdcb1 (Feb 04 2026 - 16:41:48 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
Failed to set clock rates for '/a53@0': -61
SPL initial stack usage: 13504 bytes
Trying to boot from MMC1
Authentication passed
Authentication passed
Authentication passed
Loading Environment from nowhere... OK
init_env from device 9 not supported!
Authentication passed
Authentication passed
Starting ATF on ARM64 core...
NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
U-Boot SPL 2026.04-rc1-0.0.0-devel+git.b5213bbfdcb1 (Feb 04 2026 - 16:41:48 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
SPL initial stack usage: 2048 bytes
Trying to boot from MMC1
Authentication passed
Authentication passed
U-Boot 2026.04-rc1-0.0.0-devel+git.b5213bbfdcb1 (Feb 04 2026 - 16:41:48 +0000)
SoC:   AM62X SR1.0 HS-FS
Reset reason: POR
DRAM:  512 MiB
optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
Core:  160 devices, 35 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Model: Toradex 0071 Verdin AM62 Solo 512MB V1.2A
Serial#: 15412814
Carrier: Toradex Dahlia V1.1D, Serial# 11287147


Thanks,
Francesco

