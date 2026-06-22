Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E910CDB471
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 08:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F44849BA;
	Mon, 22 Jun 2026 10:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CmGFGfYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498C4849BB; Mon, 22 Jun 2026 10:09:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EA9848BA
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 10:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80CC240235;
 Mon, 22 Jun 2026 08:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC38C1F000E9;
 Mon, 22 Jun 2026 08:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782115743;
 bh=COO7Sr/PsSwfO92nsaD0Qoi0QAobNWNYnTV+Q6NDUqY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=CmGFGfYtdQ9U4pZ2g4bf/8a010Gak/3xLeIxMArZujJJWeqDRamfdHgMsJwoXjEu2
 bsXZ1oAkngeLuArcUCaVn/Vd1XCwOlnnfAO3DVXzqJbvod+LJjY2U3xf1A8RN2Vo51
 xqjMUUU9Z0gYkfY80dOAQlC/lNeeHL1net/ooi+zC+nxM9JxsCuMeuFb6lqFN7TCMl
 xO+c4nbUXjmknh7yNk2LnhhXPDFnXMbQlvHk70p3jQHPemeGPruQ6l4mzrYdRmKp87
 06biqXRf4g1I/2Wji9w3CEaEt6lrDVpvAcm3UmdYsCR3KFDHKaG+bhUl7YJCTFeB2n
 JSylGs8L7oKfg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon
 Chung <jh80.chung@samsung.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marex@denx.de>, Martin Schwan <m.schwan@phytec.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Philip
 Molloy <philip.molloy@analog.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@riscstar.com>, Stefan
 Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, Yao Zi
 <me@ziyao.cc>
Subject: Re: [PATCH v2 00/11] Move test/py image creation into separate modules
In-Reply-To: <CAFLszTiW0Q0U4NVSpWvve3y0k4NT7_XrorQiE-T6arbiLoXnUQ@mail.gmail.com>
References: <20260523085455.750591-1-sjg@chromium.org>
 <87ik7tzcvs.fsf@kernel.org>
 <CAFLszTiW0Q0U4NVSpWvve3y0k4NT7_XrorQiE-T6arbiLoXnUQ@mail.gmail.com>
Date: Mon, 22 Jun 2026 10:09:00 +0200
Message-ID: <87y0g7f143.fsf@kernel.org>
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

On Thu, Jun 18, 2026 at 16:12, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Mon, 8 Jun 2026 at 09:53, Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Simon,
>>
>> Thank you for the series.
>>
>> On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:
>>
>> > test_ut.py has accumulated a setup_*_image() helper for each image that
>> > the bootflow tests want to boot. Each one is mostly shell script and
>> > partition layout, so the file is large and the test logic is hidden
>> > among image-creation details.
>> >
>> > Move each setup function to its own module under test/py/img/, with a
>> > shared common.py for mkdir_cond(), copy_partition() and the
>> > make_extlinux_disk() helper. Each patch moves one image at a time so
>> > reviewers can see the relocation cleanly. The modules are named after
>> > the bootmeth or feature they exercise rather than the distribution they
>> > are modelled on.
>> >
>> > While here, also redirect the generated disk images to the
>> > persistent-data directory instead of writing them under the source
>> > tree. The sandbox mmc, scsi and usb-flash drivers now look there first.
>> >
>> > Further improvements are planned, such as using the context manager
>> > when creating partitions.
>>
>> I've tested this on sandbox using:
>>
>> $ ./test/py/test.py --bd sandbox --build -k ut
>> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
>>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
> I appreciate you reviewing this - quite tedious work!

Happy to help :)

Please also see the individual commits for review remarks. I've found a
couple of things I had questions on.

Regards,
Mattijs

>
> Regards,
> Simon
