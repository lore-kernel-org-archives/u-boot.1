Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83A5C54736
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0E0888C1;
	Tue, 27 Aug 2024 21:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="KDTXYoIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CBB8897F; Tue, 27 Aug 2024 21:41:36 +0200 (CEST)
Received: from mxc-1-9a4.seznam.cz (mxc-1-9a4.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:9a4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E70887B9
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxc-7895797957-z6j4l
 (smtpc-mxc-7895797957-z6j4l [2a02:598:128:8a00::1000:9a4])
 id 035bd735fdaf659f03d5592d; Tue, 27 Aug 2024 21:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724787692;
 bh=6Jdg7XzM1ogAwvQ5uOMgEyyNeGK9o+Ko2fG+GIMyYyQ=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:References:
 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
 Content-Transfer-Encoding;
 b=KDTXYoIHjQuydb57QjIbVjHy8p8UXV19zEm2IkAljfGrV9qk66K+JcrSW1vJrr6XY
 h/VtHd8wkm6bLCVEpXcpFmKg8wV6F9HgObyh5jqC9JYhTjNnjx+Jd+6oLjyRtiAUiy
 6FJPJS5vIeOlTNOScI/dLk5P/kEjV5bDr6xUNpx7KsrHvatVlrJ6pLHOcKmxk5ADUZ
 XGoX7xU8BLN37y/f77ZCZKqI5rvPToy4/GdIGT6S8mvs/+wk/3z6FrZr49uOZHlDCA
 kXdc1q7PlbmBVTeyZQM84uqqNeuOZzPfGYBq2Ade2jglkltBKyTcHWIkKbixtZ1AJE
 d3KnUW1bL94bQ==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Tue, 27 Aug 2024 21:41:29 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Fabio Estevam" <festevam@gmail.com>
Cc: <u-boot@lists.denx.de>,
	"Tom Rini" <trini@konsulko.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_gpio=3A_mxc=5Fgpio=3A_fix_reading_sta?=
 =?utf-8?q?te_of_GPIO_pins_in_output_mode?=
Date: Tue, 27 Aug 2024 21:41:29 +0200 (CEST)
Message-Id: <K9.Za7d.77W3I8GjZaJ.1cpYlf@seznam.cz>
References: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
 <CAOMZO5Aj9zSEWF9Gm5-tF9hTaczf6FXv0zo_z+Jws+BGPYPwrg@mail.gmail.com>
In-Reply-To: <CAOMZO5Aj9zSEWF9Gm5-tF9hTaczf6FXv0zo_z+Jws+BGPYPwrg@mail.gmail.com>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

>> The PSR register works correctly for GPIO pins in input mode,
>> but always returns 0 for GPIO pins in output mode.
>> The DR register works correctly in both modes.
>
> The current code is correct as is.
> You should set the SION bit to read the value of the output pin.

Hi Fabio,

you are correct that the existing code will work if the SION bit is set, b=
ut this is not always possible or desirable. For example, if you use the c=
ommand "gpio set" to set the state of a pin that is not configured in DTS =
then you will get the error message "Warning: value of pin is still 0". Al=
so the command "gpio status -a" shows wrong states of some output pins wit=
hout this patch.

Please see the chapters "GPIO data register (GPIOx_DR)" and "GPIO pad stat=
us register (GPIOx_PSR)" in the document IMX6ULLRM.pdf which show that it =
is possible to use the DR register instead of the PSR register in this cas=
e.

I also found the exactly same modification in NXP version of U-Boot (https=
://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04e64f43=
7b0c2) made by an NXP employee.

Best regards

Tomas
