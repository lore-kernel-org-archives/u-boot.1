Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340BECD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 15:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B0983FEC;
	Fri, 12 Jun 2026 17:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="AkG/V0Hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29688467A; Fri, 12 Jun 2026 17:10:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 788C6839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEA792C27;
 Fri, 12 Jun 2026 08:10:00 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.80.120])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A453F915;
 Fri, 12 Jun 2026 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781277005; bh=SeyFwQkTjnuR74OvnU/FB45M8qeAXX7rWbmPfL8d77Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AkG/V0HpRLDX+cwCDNz1wrSUkjl3k9vqVRd21pQphIZ2SWYl+vJhk7qzRS6YEqtcQ
 cUKWUqNmWnMxz1QSvNQc/cTuThpKTi3ZRM+hxMDlBbeqQsZZavySuKWZq1Sd4iy1Jj
 bME656ceLcJFvzSHV6mXA9SbNvfiVbrO6zVqJnqU=
Date: Fri, 12 Jun 2026 16:09:54 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Devaraj.Ranganna@arm.com, HarsimranSingh.Tungal@arm.com
Subject: Re: [PATCH v5 00/24] Introduce Firmware Update Support for Arm PSA
Message-ID: <aiwhQpDGvi5IqcvX@e130802.arm.com>
References: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
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

Hi all,

We are resuming work on adding PSA firmware update support to U-Boot.
The patch series is currently at v5, and we plan to continue iterating on it
based on the feedback received so far.

Going forward, Harsimran will be taking over this work and will be handling
future revisions of the series.

Thanks to everyone who has reviewed and commented on the patches so far.

Best regards,
Abdellatif
