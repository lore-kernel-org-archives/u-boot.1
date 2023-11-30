Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA80C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 13:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3574787650;
	Thu, 30 Nov 2023 14:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="PNVtfJ29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F8F087656; Thu, 30 Nov 2023 14:35:18 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C4C875C3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 14:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 8D9C36E;
 Thu, 30 Nov 2023 14:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1701351315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpVPyB0gTrM1v7dw6Nb38maaI87JHFnnJtRvB6PGpms=;
 b=PNVtfJ29/ucDBH+12umqaSSFbUxe3ASQb/AFudlCBXhndO4LgJTsi3qrCJ7HoKlnkSrd5g
 J6LiWqX8Xho9DiIqa9kZcsB4vnRvohLPMPXQHZoIVG5KDOq/HynnX+HLmpvWtCQoGnDuvg
 LhsxgnifAxOZtHarCEuz0natO3oViahkqfYREqbwCIgIrnMYeQ8NXQ5axz/IiPDVIFA64D
 JaEB1sDRBN6CaTIENZPxpSM7/GC+pHrkBfpSc+LuWadgeE+EV/GHWALxOfS/gCQVetlICi
 1oRp87ScFnssawkTMWMFmGWvCV4dqjjr75G3RSdaMF40JdbMUASGjAwRA5mn0w==
MIME-Version: 1.0
Date: Thu, 30 Nov 2023 14:35:15 +0100
From: Michael Walle <michael@walle.cc>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Simon Glass <sjg@chromium.org>, Alexey Romanov
 <avromanov@sberdevices.ru>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil
 M Jain <n-jain1@ti.com>, Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Sean Edmond
 <seanedmond@microsoft.com>, Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, Peter Robinson
 <pbrobinson@gmail.com>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1] cmd: mtd: OTP access support
In-Reply-To: <20231130112817.98827-1-avkrasnov@salutedevices.com>
References: <20231130112817.98827-1-avkrasnov@salutedevices.com>
Message-ID: <060f979ddfd1e257bbb3fe225d9af0c5@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

> +static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int argc,
> +			    char *const argv[])
> +{
..

> +	printf("Caution! OTP data bits can't be erased! Continue (y/n)?\n");

Please note, that with current SPI-NOR flashes this is not true and
there is usually some kind of erase command for the OTP bits. Only
the region lock is permanent and with that set, no more write or erase
is possible.

-michael
