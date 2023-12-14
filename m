Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBEAC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 15:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AECA87A31;
	Thu, 14 Dec 2023 16:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB5987AA0; Thu, 14 Dec 2023 16:53:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 80718877F5
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 16:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57B90C15;
 Thu, 14 Dec 2023 07:54:36 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.4.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BCAF3F5A1;
 Thu, 14 Dec 2023 07:53:49 -0800 (PST)
Date: Thu, 14 Dec 2023 15:53:46 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Cc: sjg@chromium.org, Drew.Reed@arm.com, u-boot@lists.denx.de, nd@arm.com
Subject: Adding EFI runtime support to the Arm's FF-A bus
Message-ID: <20231214155346.GB295924@e130802.arm.com>
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

Hi guys,

I'd like to ask for advice regarding adding EFI RT support to the Arm's FF-A bus
in U-Boot.

The objective is to enable the FF-A messaging APIs in EFI RT to be used for
comms with the secure world. This will help getting/setting EFI variables
through FF-A.

The existing FF-A APIs in U-Boot call the DM APIs (which are not available at RT).

Two possible solutions:

1/ having the entire U-Boot in RT space (as Simon stated in this discussion[1])

2/ Create an RT variant for the FF-A APIs needed.
      These RT variant don't call the DM APIs
      (e.g: ffa_mm_communicate_runtime, ffa_sync_send_receive_runtime, ...)

What do you recommend please ?

[1]: https://lore.kernel.org/all/CAPnjgZ21qLnSFcCJ9rPQXEfQf-NjMBF3kYUDBBOc6WUQXQtDEA@mail.gmail.com/

Cheers,
Abdellatif
