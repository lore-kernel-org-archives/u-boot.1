Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ED8C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819A083A95;
	Thu, 10 Apr 2025 10:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U2zQ9z46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411DA83A98; Thu, 10 Apr 2025 10:48:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B3983A6B
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BE1C15C433A;
 Thu, 10 Apr 2025 08:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12DCC4CEE3;
 Thu, 10 Apr 2025 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744274903;
 bh=RUrIhTIe1mlYS5AD+cR+yDtp1aQ7vmJQjnTf64qf40k=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=U2zQ9z46ZM6+4p++BLxIzifiasiOQvSuAWKDHuCVRHCL7Ote+H0quAMYPj+wfuKiN
 tCZizowBcUoYdgqjGyK1r+mOjoWBB7V+oRkRDvOAwsCfuEXYgyKNCq8aVAtWv/BXbg
 E6Z/RZCauU+P/ZIU6OyXEE732/Jsy3cTsvcp7EFU+M/rYqZ+WRieZZje0eTjErmldy
 aCo2FOZr4H165uKyRXhCYc5Djjvk6a8w5OwJBIJD+BpSgQdfQcWtY+wA+YbLRagveR
 RqoGr/u5Qqca5czyl8LTrd7oYWijJN6Mg12ACO5V/xouAZYlUeQbnsjzotaF/Kck/u
 m+t4Wkhn0YMWw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
In-Reply-To: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
Subject: Re: [PATCH 0/4] usb: gadget: f_mass_storage: Fix crashes on low
 memory devices
Message-Id: <174427489953.286125.3867443054091743825.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 10:48:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
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

Hi,

On Fri, 28 Mar 2025 09:15:40 +0100, Mattijs Korpershoek wrote:
> Zixun has reported an odd problem in [1].
> 
> He encountered a data abort on the 2nd "ums 0 mmc 0" command with
> sam9x60-curiosity board:
> 
> U-Boot> ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
> CTRL+C - Operation aborted
> U-Boot> ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
> data abort
> pc : [<27f93428>]          lr : [<27ef7e80>]
> reloc pc : [<23f16428>]    lr : [<23e7ae80>]
> sp : 27ef4cf0  ip : a5200000     fp : 23f6915c
> r10: deadbeef  r9 : 27ef7e80     r8 : 27f7d2a0
> r7 : a5200000  r6 : 00000000     r5 : 00000000  r4 : 27f01668
> r3 : 00000000  r2 : 00000000     r1 : 27fe1d88  r0 : 27f01668
> Flags: nzCV  IRQs off  FIQs off  Mode SVC_32 (T)
> Code: 45ac d017 68c5 4667 (60fd) 60af
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[0/4] usb: gadget: f_mass_storage: Fix crashes on low memory devices
      (no commit info)
[1/4] usb: gadget: f_mass_storage: Remove kref structure use
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a4317be9dbe9428f6209cb5595bfc57eb990b023
[2/4] usb: gadget: f_mass_storage: Drop invalid kfree() in fsg_common_release()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/47fd46db943a55a7e0232e27224d216b774d7575
[3/4] usb: gadget: f_mass_storage: Fix NULL dereference in fsg_add()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6c9eaec55ae634bac02e0cf70eb78c879d008a5c
[4/4] usb: gadget: f_mass_storage: Fix memory leak of fsg buffers
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c76a7090f6480affbe3946fcd0dcc6df9bfe05b3

--
Mattijs
