Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C791FC52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 19:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A91B87F5C;
	Sat, 24 Aug 2024 21:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BF4zhQP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FDB8852A; Sat, 24 Aug 2024 21:07:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E6187F19
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 21:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1724526420; x=1725131220; i=xypron.glpk@gmx.de;
 bh=wgkYgZXP9KCNffKAMq8LcHNluycubduON8VrepR8cOY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BF4zhQP6sow0mFKkStGtGS3Xi3ACnKBsJ3R4l/G2BbHbPRaxzYzIZ2RqpDoXWxjw
 1dHZUXPK7RAQc0pioCT4NezRzM0kIeakWTuE82I1zKcFBZNLhZ5MEjeqvJFrZOi7A
 jLywO0SnSm8qfGvTIhBXDwnAcuZgNy+MyGKNf6SIzE4xOcCIQ0M2PNqbCTagzHdRx
 BzthRTO/TTyRTNB0vgBVXity0vVytfmBH3BgYsul5n+Cdua/UkV9FGtBnT2H7EyXI
 hIO39fhtZT1MvngXmClxvcdnJKvHpm0B2bhIRyGz2JdX0omYALOB+i0CsM5SLSRPl
 h0Ipgd+Z4zacR65T2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1rzYj01obi-016ntq; Sat, 24
 Aug 2024 21:07:00 +0200
Message-ID: <dd9352a4-767d-4aef-9d19-08cf301ee8f7@gmx.de>
Date: Sat, 24 Aug 2024 21:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PULL MASTER] Pull request efi-2024-10-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cYh/N1zIRnIBBTDpTI6sIgLvGr2Fq78E0XyVgIBjICFmK1eek+C
 DUBVUHV/aIOKbu9DLo+WrX4efwuPV9e5clk04H6HRvvmO7AdLOJPfBXHMggHQeIgiR8GgbY
 pJcW2iKtJSbloQcCkeKrpWzUzsNs8uA/ZDKAdnPGuoc1KggA/C43Dy0Ufk6ClOy4AgnSl4f
 DxzrgQiOcTGg99HsBs6iA==
UI-OutboundReport: notjunk:1;M01:P0:h0C2Qe/4u9E=;oM9mRZFUYsGlbGdA+/ofmqvgPqG
 SO3KvkENVeGw9SoxtLioDhF/4gHEqXPLH//3RHelh4gdRQWCY9sxbTiyNvU/h+xVcR/p5S7Gl
 xsMYW4jB1/qy6hDywGXzBaP6t29NnbF+KQEuliFjh7JvJ7m/ztGAuvnCXhGx05a8hOKZ8rF23
 6hFE9Wm6UJMG8TQuFWLaxvlGNq3OMTS7zjlEXkYA9w8OY2vpXVsaqMJQkTrpIAmSM81gBUEF+
 Hod78IL63AOWQ/aXg1ESV3x3C75M0EN2b6XpGgu9wKtapIh3vStaykBffy2cJ25yIZyhykA98
 Mq08GDBTPYfic+oEYn7nZsTaebhNoaKjZdpv4k6bVP889VXYoC58C7dn1R8dRIi3asxf2e4hN
 o7QGcyVl0aeateIR5nNVZINaZeke0P7QJgOROcBS0AYhevAMY7dg+NPZxLh3S/X0FL3u0LjGd
 SCw38k053mubgdtAUeNC46+cXLOOPcCKKnKDGcMIcnTk/I5eGCG9uTv+Sggwzovt7593Oh4YS
 SNOrCBSETkmfizKX9Ql7Y/b+h5UNsYtATm2z9CPS4LboFHRz976oxU9AqSC9Kv7FuuHOE7xVL
 aIThmjVPltxZC9iVICAWUsZF77SmMI0eQqlV3Jx1cjx1xRdhs0RWnzCxQ+Xr0OUFG1OB5O4zF
 zlLJ8MqiIDXX+OKAQFsldu1YdEnTboE0nTTkx6mmuClyHI2XfavsN0OQcnQAxR8Z49+EQrssc
 /VoAOQwAPqZtQB34t1kvUt/n+V/HOXHtS60g011sMGdXjx7nTjC6WsvP5XVCtXKsUvv/LXJXe
 VqnIQOXVb8DZ/UiQPKi76O0w==
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

Dear Tom,

The following changes since commit a481740629af5e51732b86b6ead61dc5aa5a440=
d:

   Merge tag 'u-boot-dfu-20240822' of
https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-08-22 08:14:48
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-10-rc4

for you to fetch changes up to dcd1b63b7072749f98ea0a87565d0ae5c8ddfb65:

   efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all architectures
(2024-08-24 11:41:23 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22104

=2D---------------------------------------------------------------
Pull request efi-2024-10-rc4

Documentation:

  * Add description of the pwm command

UEFI

* Correct printf codes in mkeficapsule
* Allow CONFIG_EFI_LOADER_BOUNCE_BUFFER on all architectures
* Free memory in efi_get_dp_from_boot()

=2D---------------------------------------------------------------
Emil Kronborg (1):
       doc: document the pwm command

Heinrich Schuchardt (2):
       tools/mkeficapsule: correct printf codes
       efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all architectures

Ilias Apalodimas (1):
       efi_loader: fix memory freeing in efi_get_dp_from_boot()

  doc/usage/cmd/pwm.rst       | 91
+++++++++++++++++++++++++++++++++++++++++++++
  doc/usage/index.rst         |  1 +
  lib/efi_loader/Kconfig      |  1 -
  lib/efi_loader/efi_helper.c |  5 ++-
  tools/mkeficapsule.c        |  7 ++--
  5 files changed, 99 insertions(+), 6 deletions(-)
  create mode 100644 doc/usage/cmd/pwm.rst
