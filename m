Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AD2C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 14:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5E98794F;
	Fri, 12 Jan 2024 15:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="mdM+S036";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33CF879DF; Fri, 12 Jan 2024 14:10:19 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1DF887937
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:1086:5cfb:6e3a:816a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 92D5D3D48651
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:10:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705065017;
 bh=cOOVsOaj6KIWoS4oud6fzjDKI0YM1YQBDZUtN5lP2mI=;
 h=From:Subject:Date:To;
 b=mdM+S0365xFz15avwEBKYDup5JRl7eT0/unIe6DFAlvi7E4t7/v4FnO8EZ1SRfzXB
 gLzFN7M0XX9DqeDTRqIF3/24p4qrao0z/hcmhgZqMFoePmLAiu15TclvfYLh2L8TrQ
 Nbfj85XS/qgC3yJNHQVwy9xVkbRDRAuWvGawaK6U=
From: Jens Maus <mail@jens-maus.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
Message-Id: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
Date: Fri, 12 Jan 2024 14:10:06 +0100
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Mailman-Approved-At: Fri, 12 Jan 2024 15:08:44 +0100
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

Hi Ivan,

first of all, thanks for the updated rpi5 patchset. However, I am unable =
to reproduce that it is actually working as you suggest. Could you =
please quickly elaborate on your test environment and the test =
config.txt for the RaspberryPi5? Here I have compiled U-Boot 2024.01 =
with your patches applied and using the =E2=80=9Erpi_arm64_defconfig=E2=80=
=9C, put the u-boot.bin file on the sd card and then added =
=E2=80=9Ekernel=3Du-boot.bin=E2=80=9C to the config.txt file. The =
environment I am using is a buildroot-based system which boots nicely =
with the default RaspberryPi boot loader and a RaspberryPi5. However, as =
soon as I replace the =E2=80=9Ekernel=3DImage=E2=80=9C line with =
=E2=80=9Ekernel=3Du-boot.bin=E2=80=9C the system stalls and there is no =
HDMI output (nor any console output) with the u-boot 2024.01 version and =
your patches applied.

Best regards,

Jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

