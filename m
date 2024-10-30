Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3975ED5CCAF
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 14:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5A288E65;
	Wed, 30 Oct 2024 15:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="krrtr67l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dhVAZC7+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BB688E77; Wed, 30 Oct 2024 15:12:49 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A8A88E17
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XdpxB3JmLz9sl9;
 Wed, 30 Oct 2024 15:12:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730297566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BEj7Qbpcyt9cUZBHjoOobVEQSG+xLa4B1wowBfHWqe8=;
 b=krrtr67lnh7USIUJtM+oLwyxh1OFbUrjXhDxSOics0z813xlszusfVWPotUhshWcL9wQ9c
 RdT5nqKcIeqtnAHx0mMutdy34jnkwHptYa7kywhRHBCOJddCKYIjVmttJOQKR1fYOde9W5
 35Tq3djs1JNfK8qM1r6AIxLBoArYeXz4An5HoQgHbQK61cbgPkuez5/wpbOTWBSmGSlBDQ
 cUA5G3foY0gzS6XxUvNYXfesD1ZfeXVgG2SASUTkB420JvDymCkuCn7RFLi6FVRZNaP+bY
 8nniTki3PGdVa8012UkdCL560ero8YUdkPa2I50jNRC2LckkGNY4VMH6wqgzkg==
Message-ID: <b3a4cfdd-f503-465d-915a-1094e7146927@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730297564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BEj7Qbpcyt9cUZBHjoOobVEQSG+xLa4B1wowBfHWqe8=;
 b=dhVAZC7+rDzrFktXO7cw11AQgAfLaT/FlhpJyZTknK+riQZM7ELCYw6+CV5PdRBWYTolSJ
 ttyiAMuOMjDqFmoxdoSR7tl5N8VaGZ547/L74SNZUzD0vbO+gLbc9Q7/0KDg+R6nhFr5NZ
 fszewh0fivkfklmOxrNl6VMdeR2K/O1gTppGqZiAK+F/r9MV2N6Ln/6HEiccIcB/XQbkbI
 peQp2eqaVvlB3Ni+X1dZI1KcK1nyBNTXviXxHdoKQYeQPITALzArcbGqn9JynTq6TSgIud
 coerjHASnb8FLBhTKjppXr3NFEVcZ5tMMy/ZFdcMObngIEItyXcWqf3B/FNhRA==
Date: Wed, 30 Oct 2024 15:12:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1e98fe816c5662a518a
X-MBO-RS-META: 1hjxko88cqf11z65wset4xkt891ypajs
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

On 10/30/24 11:33 AM, Jagan Teki wrote:
> Hi Marek,

Hi,

> On Sun, Oct 27, 2024 at 1:48 AM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Remove undocumented nor->addr_width == 3 test. This was added in commit
>> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>> without any explanation in the commit message. Remove it.
>>
>> This also has a bad side-effect which breaks READ operation of every SPI NOR
>> which does not use addr_width == 3, e.g. s25fs512s does not work at all. This
>> is because if addr_width != 3, rem_bank_len is always 0, and if rem_bank_len
>> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read() returns
>> -EIO.
>>
>> Basic reproducer is as follows:
>> "
>> => sf probe ; sf read 0x50000000 0 0x10000
>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, total 64 MiB
>> device 0 offset 0x0, size 0x10000
>> SF: 65536 bytes @ 0x0 Read: ERROR -5
>> "
>>
>> Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Michael Walle <mwalle@kernel.org>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Pratyush Yadav <p.yadav@ti.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
> 
> Is this patch-set next version for 'previous' reverted series?
Yes, this is trying to fix the issues introduced by the stacked/parallel 
stuff in a less blunt manner than full revert.

Input from Tudor is probably more useful, since they do work on the 
kernel SPI NOR stuff and have better idea where that is going /wrt the 
stacked/parallel stuff too.
