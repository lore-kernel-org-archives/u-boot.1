Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F2CCD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E442D846A7;
	Mon,  8 Jun 2026 09:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kEyphqwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD498846E6; Mon,  8 Jun 2026 09:53:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DD88466E
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 414B1600AE;
 Mon,  8 Jun 2026 07:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C391F00893;
 Mon,  8 Jun 2026 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780905226;
 bh=bIVDqvTjltzi2wjmYQtBQmTELeWhOqiHRT62wEn05ik=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=kEyphqwFY3Ey1z02IbtQ3OFUcvwdQ0rfYU0Tu74IHicxV9fkTUP1PWi95dOyXsV/m
 9wIBCNSjrz5rF9oBTjsgoFUS1ySmgc4XbdQC7Ip8RVoKTOOoJpTvFr+MLmve3OnTaE
 h/bU/lDnnsJNBFC2qKIZS6cMZ6NkNoRFWnLVTP+f+S5iBwoGzcv74n8ru+zhAKQgs6
 nI2OEd/aq9jFZ0gTL4T/Z9e+cgfQ4G8VOc/8Jjf36Y0UsV+cNa3yVDt9rYhqPXvmh3
 8hpw83FSngndmjNfEM8dcrj1vB/xzv6yV3mFaNw3/VLsRaCOJ7GaMjauoY9aDSVU+e
 9RgLE/N/Yoauw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Jerome
 Forissier <jerome.forissier@arm.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut
 <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>, Martin Schwan
 <m.schwan@phytec.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Philip
 Molloy <philip.molloy@analog.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@riscstar.com>, Stefan
 Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, Yao Zi
 <me@ziyao.cc>
Subject: Re: [PATCH v2 00/11] Move test/py image creation into separate modules
In-Reply-To: <20260523085455.750591-1-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
Date: Mon, 08 Jun 2026 09:53:43 +0200
Message-ID: <87ik7tzcvs.fsf@kernel.org>
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

Hi Simon,

Thank you for the series.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> test_ut.py has accumulated a setup_*_image() helper for each image that
> the bootflow tests want to boot. Each one is mostly shell script and
> partition layout, so the file is large and the test logic is hidden
> among image-creation details.
>
> Move each setup function to its own module under test/py/img/, with a
> shared common.py for mkdir_cond(), copy_partition() and the
> make_extlinux_disk() helper. Each patch moves one image at a time so
> reviewers can see the relocation cleanly. The modules are named after
> the bootmeth or feature they exercise rather than the distribution they
> are modelled on.
>
> While here, also redirect the generated disk images to the
> persistent-data directory instead of writing them under the source
> tree. The sandbox mmc, scsi and usb-flash drivers now look there first.
>
> Further improvements are planned, such as using the context manager
> when creating partitions.

I've tested this on sandbox using:

$ ./test/py/test.py --bd sandbox --build -k ut
$ ./test/py/test.py --bd sandbox --build -k bootflow_android

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
