Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAADC54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4876488701;
	Wed, 28 Aug 2024 03:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="lZFjFoyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034D98887E; Wed, 28 Aug 2024 03:32:00 +0200 (CEST)
Received: from mxe-1-50f.seznam.cz (mxe-1-50f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:50f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4865585B66
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-6f7b5db655-grmdl
 (smtpc-mxe-6f7b5db655-grmdl [2a02:598:128:8a00::1000:50f])
 id 4fdfc08eb12b72244f514e96; Wed, 28 Aug 2024 03:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724808715;
 bh=mlLNks5kaXvp8nuJsxEwEdm+72mLP/3cnxIevMoRNbQ=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:References:
 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
 Content-Transfer-Encoding;
 b=lZFjFoyIDw/L28B9Na1EGNXGscSd+gYWL35Vg+sj3zTgEerKtwA4U95XvxT+rGi6s
 LMrOX9GzaliRENHlBXWSGsaN6Ol7IyXrGZyKgu4yG9X7yhNp04IafD3S/xC8JvNvzO
 TZQcrMtGZJTcdx2OWahn7+TuVCxqJDZIR6PxJbth0eqktzS3+4+d2yZxz9Dg1tSB5M
 wKqMG43AudOP5Z5R/h/K4TR21traZf5AGzfJm9WlLpNltBtbWe3vOtAEzarmYdK1tA
 NfWpPT28QxwKMqGMJPX/SeVgok0GJm3EgFMZkoEoVe1iLaEs08JI0+n/fa/i5eDWPj
 Sw2inAfMW4kHQ==
Received: from unknown ([82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Wed, 28 Aug 2024 03:31:52 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Fabio Estevam" <festevam@gmail.com>
Cc: <u-boot@lists.denx.de>, "Tom Rini" <trini@konsulko.com>,
 "Ye Li" <ye.li@nxp.com>, "Peng Fan" <peng.fan@nxp.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_gpio=3A_mxc=5Fgpio=3A_fix_reading_sta?=
 =?utf-8?q?te_of_GPIO_pins_in_output_mode?=
Date: Wed, 28 Aug 2024 03:31:52 +0200 (CEST)
Message-Id: <Mh.Zbul.1u3}4uost4Y.1cpdu8@seznam.cz>
References: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
 <CAOMZO5Aj9zSEWF9Gm5-tF9hTaczf6FXv0zo_z+Jws+BGPYPwrg@mail.gmail.com>
 <K9.Za7d.77W3I8GjZaJ.1cpYlf@seznam.cz>
 <CAOMZO5BshEknpJEeEiqip3e_YkN21kAKtKva0ik=8SKGJxmngw@mail.gmail.com>
 <CAOMZO5A1r4F403efkpAPbv9zJD7bjv=aHB8SgOK3pPXtVvzE2g@mail.gmail.com>
In-Reply-To: <CAOMZO5A1r4F403efkpAPbv9zJD7bjv=aHB8SgOK3pPXtVvzE2g@mail.gmail.com>
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

> For more information, please read this thread posted on
> linux-arm-kernel ten years ago:
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/CAJ+vNU3w9Oi=
+dErmy9x8g6ps=3DeLHLNLO-w7=3Dgn_8JtY4Kab6JQ@mail.gmail.com/
>
> I hope this helps to clarify.

There is a good point that using the PSR register is useful for board prot=
otyping,
because it indicates the level sensed on the pad which may differ if there=

is an external level conflict on the pin.

On the other hand, there is a note that enabling SION for all pads in GPIO=
 mode
will have some impact on the power consumption.

I checked the current Linux driver and it uses the DR register for all out=
puts.
This change was implemented about a year later after the mentioned discuss=
ion:

https://lore.kernel.org/all/1430321701-13758-5-git-send-email-vladimir_zap=
olskiy@mentor.com/

So both the Linux kernel and the NXP U-Boot work as expected, but the main=
line U-Boot does not.

Best regards

Tomas
