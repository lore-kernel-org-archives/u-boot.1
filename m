Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A899DCCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 15:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D96183642;
	Sat,  1 Nov 2025 16:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=internet-e-mail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=permerror (0-bit key) header.d=internet-e-mail.com header.i=@internet-e-mail.com header.b="PNVG+6ko";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nomHquTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8349683B4F; Sat,  1 Nov 2025 01:22:44 +0100 (CET)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DAE683B43
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=internet-e-mail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew@internet-e-mail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 5DBAF1380287
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:22:40 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
 by phl-compute-05.internal (MEProxy); Fri, 31 Oct 2025 20:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 internet-e-mail.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to; s=fm3; t=
 1761956560; x=1761963760; bh=2c18H999XUx+eeFZETRE4qHzZYxC6NCoWY3
 NDX3CtyY=; b=PNVG+6koUXrX7iU2P+ksg6hUckJczXEHmJ1RyGvBEH3bV5td0eC
 6u80ipfYOqv7X4LPXCCc7y/dJ+Jf0G5uLkI5MXk7A1LZj7xVQm/GsKKM93+RBV6W
 KYFFFdG9X8q3nwvNyMj5uEttzK/iK9rgufLw3ic7b+HfRIwtgwx4MAX4QWYJYAA7
 1k4Tb+4zccGX3M3sMwo/GGFui2T35FB6gdYZhQgKE0cu2CdFyE3MPk7JpxBL2TBv
 j5fs19JRMgTgA7YqhZEvrtZqJjXWSJtX3Ov0YrHsIo610HKELooJfG5Ny2KIy1fJ
 dNvUvzU7rP5TrcUf3zx0jF5ni0gqNN8yp0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761956560; x=1761963760; bh=2c18H999XUx+eeFZETRE4qHzZYxC6NCoWY3
 NDX3CtyY=; b=nomHquTX7poSQ/LbreE2iN4iHfDT6i9GTXq7iETG9fugrkFT8A5
 ivpyN/9smoCPX5gs8rE6hMT64+5Lzi9m3e1VJE4nLlKvUy6Ml0ePKe5DcSXtoU7c
 skIbd9XDGfhNJ3Lq0B7omrWRBPun4KjTSuXLDicSxj7zye+vs4AAq2jc22L4wEfa
 tceinVQR5gKj8j3m+j3z1pZCdsUBmpSp8fB6S5igkH4MG5al+la2f5yJPbk9GsDT
 EEMbzLBieZdFNNnnhXnhLxqeKBkHqGfE26jHLL7uujFPkOAlu4goh9Mqe+rtMaVM
 W243wTC2H4E5nmYzIKoimFECZpIEPLqEIWA==
X-ME-Sender: <xms:0FIFaYlOK1xhsaeOidvyxTZ42fhViQ9mqTjActj7ReJbxJkoXHVzig>
 <xme:0FIFaSpa2jbmqYQ7CKytgGPKOkOmMfqmeolJfddxKzCZrM4SQiJbTfVyk-4C7FhT7
 CuBh4l4xg2OORGUejWKE1YSgJJowGQMbNzjVNV9Gce8_F7YkeHPOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtqhertdertd
 ejnecuhfhrohhmpegrnhgurhgvfiesihhnthgvrhhnvghtqdgvqdhmrghilhdrtghomhen
 ucggtffrrghtthgvrhhnpeeutdffvdeuteeuteegiedtvedvledttdekteeigefgteevvd
 ehfeeuhefhteeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpegrnhgurhgvfiesihhnthgvrhhnvghtqdgvqdhmrghilhdrtghomhdpnhgspg
 hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdqsghoohht
 sehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:0FIFaSUmMIAutnhHwbAKViiErsyI6cgx1tdejKDEJdm2uyHI6hiP5A>
 <xmx:0FIFaej8Vn-e5hOo61ed9cg7NAVSdSW_uk-7MH8NCdZtDBizSkWxJw>
 <xmx:0FIFaTQUR1aTG-Wjx0mvXlk98YPtdkqDYo_d9rWrSsu2mmqwS61Dhw>
 <xmx:0FIFaRE_BRK7BCwNotgiNyb7PSlSglvSHtW4eAGJ5TkZgf7zVHnhXg>
 <xmx:0FIFaeudmuj4b9ybTJrGpvP5Ub98t78YhcW4mmeGkk1O5fUa2T95SlpZ>
Feedback-ID: i72864837:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 1F80418C0066; Fri, 31 Oct 2025 20:22:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 31 Oct 2025 20:22:19 -0400
From: andrew@internet-e-mail.com
To: u-boot@lists.denx.de
Message-Id: <63bb0a47-d02d-4d73-a63a-3f6b37caa09e@app.fastmail.com>
Subject: building u-boot without pxe, dhcp, etc. 
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Nov 2025 16:15:06 +0100
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

I want to build u-boot without a network stack (the target machine only =
needs to boot from usb, nvme and mmc devices) but disabling pxe causes a=
 dependency problem. Does anyone know how to resolve this?=20


include/config_distro_bootcmd.h:443:9: error: expected =E2=80=98}=E2=80=99=
 before =E2=80=98BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_D=
HCP_or_PXE=E2=80=99
  443 |         BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DH=
CP_or_PXE
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
include/config_distro_bootcmd.h:475:9: note: in expansion of macro =E2=80=
=98BOOTENV_DEV_NAME_PXE=E2=80=99
  475 |         BOOTENV_DEV_NAME_##devtypeu(devtypeu, devtypel, instance=
, ## __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
include/configs/sifive-unmatched.h:24:9: note: in expansion of macro =E2=
=80=98BOOTENV_DEV_NAME=E2=80=99
   24 |         func(PXE, pxe, na) \
      |         ^~~~
include/config_distro_bootcmd.h:477:25: note: in expansion of macro =E2=80=
=98BOOT_TARGET_DEVICES=E2=80=99
  477 |         "boot_targets=3D" BOOT_TARGET_DEVICES(BOOTENV_DEV_NAME) =
"\0"
      |                         ^~~~~~~~~~~~~~~~~~~
include/config_distro_bootcmd.h:497:9: note: in expansion of macro =E2=80=
=98BOOTENV_BOOT_TARGETS=E2=80=99
  497 |         BOOTENV_BOOT_TARGETS \
      |         ^~~~~~~~~~~~~~~~~~~~
include/configs/sifive-unmatched.h:51:9: note: in expansion of macro =E2=
=80=98BOOTENV=E2=80=99
   51 |         BOOTENV
      |         ^~~~~~~
include/env_default.h:120:9: note: in expansion of macro =E2=80=98CFG_EX=
TRA_ENV_SETTINGS=E2=80=99
  120 |         CFG_EXTRA_ENV_SETTINGS
      |         ^~~~~~~~~~~~~~~~~~~~~~
In file included from env/common.c:32:
include/env_default.h:27:36: note: to match this =E2=80=98{=E2=80=99
   27 | const char default_environment[] =3D {
      |                                    ^
make[1]: *** [scripts/Makefile.build:256: env/common.o] Error 1
make: *** [Makefile:1857: env] Error 2


--=20
 =20
  andrew@internet-e-mail.com
