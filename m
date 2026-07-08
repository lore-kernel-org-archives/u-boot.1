Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A991C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 05:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A0E84118;
	Wed,  8 Jul 2026 07:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="pX3Q+VgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17418497A; Wed,  8 Jul 2026 07:12:58 +0200 (CEST)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0615838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 07:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202603021246; t=1783487576;
 bh=V26ItsQgR5Mn2tAzjuTvXwNY9CSlMIulFPMpqlpyFc0=;
 h=Date:From:To:Cc:Subject:From;
 b=pX3Q+VgZ6vHlI8slobfmD5bxqnJ2OnByBLnjQfwaD9MmQsYYDp+Tv8OwChOKejUyG
 ESt1E6ymsT1dawBHTJslOEIP4jtVKlgpCaXqbjF6mxPO4ohuTdGYyrz/oq7mXk9AcW
 MKD8XgI/X7B3T5V80+/5MMo4Iuc9FdjdBXOB65AdapbMcFOshSaEYdT+oLAPgENmbI
 er0R/kWeyEm1g7jYCn9gYlMSyc9ZGVWHqfk4f9yuE1kcuojYoOmWJc09NruqM/BdZE
 h591zrloPhpglbipwfxIodFuE8n73awBDdgN3mqB6eS0H7o3qcsVzzQO8Z8MONOv6u
 3iazfsmFBrQSg==
Received: from ipc1.ka-ro (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id 4B6EA7720158;
 Wed,  8 Jul 2026 07:12:56 +0200 (CEST)
Date: Wed, 8 Jul 2026 07:12:55 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: u-boot@lists.denx.de
Cc: Petr =?UTF-8?B?QmVuZcWh?= <petr.benes@ysoft.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Subject: Regression in f_fastboot due to commit 6a92e9827650 ("usb: ci_udc:
 Check ci_ep->desc before use")
Message-ID: <20260708071255.13f58e98.LW@KARO-electronics.de>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: /
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

commit 6a92e9827650 ("usb: ci_udc: Check ci_ep->desc before use") has
the side effect that an empty buffer is being passed on to
rx_handler_command() in drivers/usb/gadget/f_fastboot.c upon
termination of a fastboot session which leads to a
'command  not recognized' error message being printed on the console.

Obviously without the commit the offending USB request had been silently
dropped but is now delivered to the upper levels.

I'm not sure what the correct fix would be.
Should the fastboot driver ignore the empty command buffer or should
the "Moreover, the patch gets rid of possible outstanding requests
if the endpoint's state changes to disabled." part of the commit be
reverted?


Lothar Wa=C3=9Fmann
