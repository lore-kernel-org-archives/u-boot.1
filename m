Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28933CEACEC
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DAE8925C;
	Tue,  1 Oct 2024 19:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qolFX6T+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D0689241; Tue,  1 Oct 2024 19:16:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2776189230
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 19:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727802963; x=1728407763; i=xypron.glpk@gmx.de;
 bh=bY3zZH/uAQQKZwF6676mHrdYS72643ZVK89zSlJnv9k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qolFX6T+BPIaF5eJa8lVEIemnNkmyVmTMoYWJ/TUVeOsTINdTH32gjwSYefr03Gf
 LijqBUCaj6p3ws2C3nMbAhgUg78rr1qJQ6F19AELpJeSm0C19ovPneuJiEFqzF4YZ
 eZMVv0e1C0eB464JCXNEMS9M2zZHeu2giJBjkDfdyD4XWPZCvELs8IMk/i6hUWZoE
 oUugofqMD8OIdQCi1vyZZB7QQlSGLBB42yzX9uF91Tg1SzNlvnT4whVZ4CoL/oNIE
 LfjK+Yfo20a4IgO3ovSOXVh97NI/qSCBDoBrV4u/SFjsCfGitzUUAJX35E3By0VkP
 cJI5biCwtR2KgbLJXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1sTw402uN9-00Y8KM; Tue, 01
 Oct 2024 19:16:03 +0200
Message-ID: <c1aa3261-2829-4b94-a12f-f89e1bda499a@gmx.de>
Date: Tue, 1 Oct 2024 19:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Kever Yang
 <kever.yang@rock-chips.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried
 <rfried.dev@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240823204824.443631-1-sjg@chromium.org>
 <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2R3bMuB+GsUQGwucXrQvjvaLZBKDXaGbQbLdSDizheqYAqPavw4
 GB5IfAD3WKxnn9awZx29EpAFKgl3pU0TG0cyxtNn/wIC3Stq86krLd7H6mr+5ZcqEIDothd
 7zWg7O/w6cCXXWEkaMug5VuupZh3/Uj2iGqG4BbaNIvWYUtywwLAEXcAv6yzsk8pSFh8td1
 CMqOc/0T6g37+cN/GBVnA==
UI-OutboundReport: notjunk:1;M01:P0:RB3HCCVqD2c=;KJ2p6zdZfAU1cdfeqiZ4rhFYK12
 3PwjTpA6GfAFtSCcdeoiV6dtb4fOZ1MzCadlzdLu8xN5xkkNr+HciICFFKY1Jlf/IauhuSCWd
 lOW4cKSQnI/5D9aPA/sjHQaer05LZhhXuJRuQO+buNFTOmLlNVUeumHbWtLQzoSLu5L88Tjsa
 0TplkDzk7rJC9TnXGYLN9SVcxfrOVhge+cawGxqdS+TU3++w8755+QBX6fbIhmntsDZlQZk/H
 CScvFgpwY11jzLA+AvzYucmygGSd24nYFF+2pwKt92QhLDCzuh1V6IQvlg9+1RF26RxaCSnfW
 zsCvF5feREKdnZDpHquPJIhNdRlo8CMU7fyuYnkNRpqwq5vXS+CKg8legD5lFfaPsFrg1qlKM
 UYoAyrl1JqtXFDVGQoYHsR7W3WHJWX7wbu0fXRO0Rv8vpiEyaotOoC52vGmo3JoiwwlV5+/Rm
 ErxSWgPo6QvF8Kf3cTn6z9GsVEZbWs1/i1zEUC1w/pYC1RKF+GKv1J+HwEZZfLm/LtGlqij/g
 doMYCtQ/hur06bfJ3bxrRCPLPga3tzzM88rx1bgmfhqaU2qg5axRiPGLxoGunW1dCwQZTCJ36
 LxEn8uTEBfs6aM0MKyBOzR/pOvcPvXl0A61AMPjP82BfX69wX6BAdERzQ+eqsO1iOe3p5A2H/
 vby9k2zdVCExnVJ8ohFScLi1xlMWdlJ6wILqHeG4ypI0AKQLTbf9ZltXx8g/VTwvZaWCseA21
 9BKB8tSP7dnLXG1XfAqJB93BpASoaDlHe/EcRyACkQzR6gDsussIYFLpCTY30QDxAx65N95Sp
 7aqaNzJDC6xRnHjrf2IxREjA==
X-Mailman-Approved-At: Tue, 01 Oct 2024 19:18:02 +0200
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

On 01.10.24 13:18, Simon Glass wrote:
> Hi,
>
> On Fri, 23 Aug 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
>>
>> This series attempts to migrate all sunxi boards to use standard boot,
>> along with a text environment.
>>
>> Changes in v2:
>> - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
>> - Put the FEL bootmeth before all other global bootmeths
>> - Convert the other DISTRO_DEFAULTS in the Kconfig too
>> - Keep BOOTCMD_SUNXI_COMPAT
>> - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
>>
>> Simon Glass (8):
>>    blk: Make functions available unconditionally
>>    bootstd: Avoid calling unavailable block functions
>>    bootstd: Avoid depending on BLK
>>    sunxi: Add a bootmeth for FEL
>>    sunxi: Move to bootstd
>>    sunxi: Drop old distro boot variables
>>    env: Provide a work-around for unquoting fdtfile
>>    sunxi: Move to text environment
>>
>>   Makefile                                      |   1 +
>>   arch/arm/Kconfig                              |  10 +-
>>   board/sunxi/sunxi.env                         | 152 +++++++++++
>>   boot/Kconfig                                  |  16 +-
>>   boot/Makefile                                 |   1 +
>>   boot/bootdev-uclass.c                         |   3 +
>>   boot/bootmeth_fel.c                           |  81 ++++++
>>   .../gardena-smart-gateway-mt7688_defconfig    |   1 +
>>   doc/usage/environment.rst                     |  12 +
>>   include/blk.h                                 |   9 +-
>>   include/configs/sunxi-common.h                | 238 -----------------=
-
>>   11 files changed, 278 insertions(+), 246 deletions(-)
>>   create mode 100644 board/sunxi/sunxi.env
>>   create mode 100644 boot/bootmeth_fel.c
>>
>> --
>> 2.34.1
>>
>
> I'm just checking on this series. Are there any comments, or can it be a=
pplied?
>
> Regards,
> Simon

Hello Simon,

My OrangePi PC still shows bootcmd=3D'run distro_bootcmd'. This does not
look like standard boot.

My Pine64-LTS boots fine with this series applied on top of origin/next.
bootcmd=3D'bootflow scan'. The EFI boot manager method is called
successfully to start Ubuntu.

Best regards

Heinrich
