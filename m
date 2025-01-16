Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF69C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1409180214;
	Thu, 16 Jan 2025 14:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="gDKgvlR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE2080214; Thu, 16 Jan 2025 14:21:15 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C25E801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id D08FA120010;
 Thu, 16 Jan 2025 16:21:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D08FA120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1737033672;
 bh=0YN865S1gVoCJFSljwYFmoje/8Aj+0Q1gGGIXVnlH8A=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=gDKgvlR7WPlrhOSCcfYgNgw4zZLh1cMsfm/0QHryhv7zFi3V0Dq+/PwcUSG2xlbbC
 cixlngIfo0KwYDKpDz+BilxBlgWuvdod4QVAKh73pqZzmwgAsBYiWUk1fIMrZHl0pj
 VpDyOGJ+omzALstW3Dni+YimlkAcGw0oi1jMygMwN6A/dLx3XETEODcMq80c1tQheV
 /MlrK3U4Q/eMvCVdLme3upGPmeORBn30euxIMO/up9crnzg/aNSHRKk/qa1IU8Rgud
 FYKdQ8VLSziYC8ag/f6S+LQ0uyON81HOhH49rik4875DaMUaky4Tlcx4v4claZ/Fjw
 GnIwB4ck7GybA==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 16:21:12 +0300 (MSK)
Date: Thu, 16 Jan 2025 16:21:11 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, Caleb
 Connolly <caleb.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Sam Protsenko <semen.protsenko@linaro.org>, Devarsh
 Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH 3/3] common: fdt: hand over original fdt bootargs into
 board chosen handler
Message-ID: <cdxxtoagmwcrc53l6n3hdtt2ohsk6nvv5ar4mkpcqgny7z7hys@ymyqw7t36gsn>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
 <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
 <CAFLszTgdcz_0AgU51USW0PPQJ_O1tO42d7LQEpNCRajTK3FeBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTgdcz_0AgU51USW0PPQJ_O1tO42d7LQEpNCRajTK3FeBQ@mail.gmail.com>
User-Agent: NeoMutt/20241212
X-Originating-IP: [172.28.162.51]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190375 [Jan 16 2025]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/01/16 10:48:00 #27040539
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hello Simon,

On Tue, Jan 14, 2025 at 06:14:59AM -0700, Simon Glass wrote:
> Hi Dmitry,
> 
> On Thu, 19 Dec 2024 at 14:42, Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> >
> > Sometimes, it is necessary to provide an additional bootargs string to
> > the kernel command line.
> >
> > We have a real scenario where one U-Boot blob needs to boot several
> > kernel images: the vendor-patched kernel image and the latest upstream
> > kernel image. The Amlogic (Meson architecture) tty driver has different
> > tty suffixes in these kernels: the vendor uses 'ttySx', while the
> > upstream implementation uses 'ttyAMLx'. The initial console setup is
> > provided to the kernel using the kernel command line (bootargs). For the
> > vendor kernel, we should use 'console=ttyS0,115200', while for the
> > upstream kernel, it must be 'console=ttyAML0,115200'. This means we have
> > to use different command line strings depending on the kernel version.
> >
> > To resolve this issue, we cannot use the CMDLINE_EXTEND kernel
> > configuration because it is considered legacy and is not supported for
> > the arm64 architecture. CMDLINE_EXTEND is outdated primarily because we
> > can provide additional command line strings through the
> > 'chosen/bootargs' FDT node. However, U-Boot uses this node to inject the
> > U-Boot bootargs environment variable content, which results in U-Boot
> > silently overriding all data in the 'chosen/bootargs' node. While we do
> > have the board_fdt_chosen_bootargs() board hook to address such issues,
> > this function lacks any FDT context, such as the original value of the
> > 'chosen/bootargs' node.
> >
> > This patch introduces a read-only (RO) fdt_property argument to
> > board_fdt_chosen_bootargs() to share the original 'chosen/bootargs' data
> > with the board code. Consequently, the board developer can decide how to
> > handle this information for their board setup: whether to drop it or
> > merge it with the bootargs environment.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  boot/fdt_support.c    | 5 +++--
> >  include/fdt_support.h | 4 +++-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> 
> You could look at 'bootflow cmdline' which allows changing individual
> parts of the bootargs. It uses library functions which can do
> insertion and deletion, etc.
> 
> Another longer-term point to make is that there is the concept of 'OS
> requests' in VBE. So long as the kernel is packaged in a FIT we could
> have an OS-Request property indicating the serial port that it needs.
> 
> Anyway, my comments are just some thoughts on how to solve this more generally.

Hmm, I wasn't aware of the OS-Request in VBE. I'll delve deeper into VBE
and the 'bootflow cmdline' for our internal board bootflow cases.
Thank you so much for the suggestion!

-- 
Thank you,
Dmitry
