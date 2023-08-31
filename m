Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB781C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353B886550;
	Thu, 31 Aug 2023 05:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Re1utLBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAAE786561; Thu, 31 Aug 2023 05:51:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5167B8654A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693453841; x=1694058641; i=xypron.glpk@gmx.de;
 bh=R71TKdnLRsv9cNj148mGMBi0XDmKqW254JYYyYvmmDo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=Re1utLBnq8GqOxOuWqyIWq1IVraAIeg0RG6BuiKfnb6vTb/cLcqEQxay5m8JVOf+3L6r/oG
 sgTkSutL/9sc8P9dXirDSbVzo6ud8P/OU9PK921zEPkqnkn3j7SZnJUhr1y0+Fld4+r0ZhB+0
 pYa3LE8tssKUJbRCMBXD5GNQ/sK7gzBEkcDGoylwFo+QeBc3d3Fjj4uzzhPkmuD8QRTeuH/Wo
 8QUXBGahygN1UTuQQ0iEBkQbYNRwRUJ6rhJ5EAAfmhtdUfnACRzniWVoI7DbiSrDhLDrBIImO
 7bAOpjS25MPhWGTd5NE6YrA4z/0ooUhAcpj8nbns81fN5CzPqkUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1pp51K092l-00v5wc; Thu, 31
 Aug 2023 05:50:41 +0200
Date: Thu, 31 Aug 2023 05:50:38 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>,
 =?ISO-8859-1?Q?Pierre-Cl=E9ment_Tosi?= <ptosi@google.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Roger Knecht <rknecht@pm.me>,
 Roger Quadros <rogerq@kernel.org>, Sean Edmond <seanedmond@microsoft.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [RFX PATCH 0/9] Universal Payload initial series
User-Agent: K-9 Mail for Android
In-Reply-To: <20230830232856.2589218-1-sjg@chromium.org>
References: <20230830232856.2589218-1-sjg@chromium.org>
Message-ID: <47386957-AD73-4DC6-8668-2641FD90F365@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYSVVII2LnYj2bn8PXfplU27p6QpKJCEyJLvEI4Sj/vlBWwSaIA
 CxL7l4hz1d3ITkMErKt5JyPVF+I0rZtRcRANjQVCBS8UWC8wX9mSVxacVWDgCoizdvh16hI
 z+gQQ8/ZUK9rOK19/uAetWqZZ+LDmdLkWKP0LnGH64+uhjH97pOC3NFXh5a08VIoaeoHpyY
 KskvkA2qKpC2lyLRUrALg==
UI-OutboundReport: notjunk:1;M01:P0:PKcyBxL+qIA=;jOIpi/TzQPmGfIcaQ8+PY80bSKa
 fL7/+hubE7QwZW1Vm7gE4/7yF0n9kXPf65dk/F2x2aoAFVXcH823TP2TFvkUOU3Y58FHBGLQq
 ARu2aalG8PfuQR4xJ59DzPrxY2H381rynGZi2bziaKEAw0Fh3eqz4sNdLbfRm6hmeqWmLOg1f
 +vN+oD/KKfl8T9I5bHYF5ec222O1Ftx2Md1knArsYC5IH98+5B1FYGoNZjBRC6RU4O3vGr6G3
 jgeHZZyeU3TUQzDvOqf9OyyP9WAUWGy+cuT06CWItgUwiXOfKSCPqmwkYU+612oyI4yTKB7xI
 1mBq3Ze3EzEpFBs25edjWEEkeaRS/fRgIZPu2vulj1JrI4usv/t3c551xAHUThltjc886K0f7
 4OlXJa37zc0s2O50OOF8+sw4h21x9axKc1VvdKg32LNlE7PRvYzm6MUB7gCtPrmLcMvZua5sI
 4DqqLm3ndpgr66LfYCZ54nKjL+CLUzqU+0EcXz7PkHFgmP9CU3bIzGBlFM1B7q1VV3zfBSH/r
 QYQyQmo4fmp9FiBKv546rOgqPZLUAp81Gl3DhE147FddMKfVZQXYoB47E0HXH2Qw0hvhlipqp
 xTzXM8J/0luMism7YUX9fuF+IJovNsYSOlDiup5U0UlarNFmWStJ/OEWAMk+3yEUEMf/A2wNu
 r0mINGb4wvwU3+6Lv4TYJtEK93mjAKTU+UVZ+nL7+dh6WP+oVnG7muiVwrnX6hgz4uhnZiSNG
 +b+RRSacas5CYPVL4Haf1FjjTJUbb9lUAQgeOtIZ92msZ8A+v/Ks18gS0rreycip/8hVeE64n
 mqb7s8gYz99V4U8D1kJr+wD+MnnsrovNQSCWnaMqaryGu+D9IRU7bGgPVEjyq6cmEhVnlbini
 6d4woq0zKVLgcfBXbYcWi9YkAKSAUCeZpM6xNGEl3mWv3OJnNeypLAjniF2UEHjJXIJX494MS
 3Vp2UNo1HGatQK43j4kOGJb6B8s=
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



Am 31=2E August 2023 01:28:37 MESZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Universal Payload (UPL) is an upcoming Industry Standard for firmware
>components=2E UPL is designed to improve interoperability within the
>firmware industry, allowing mixing and matching of projects with less
>friction and fewer project-specific implementations=2E UPL is
>cross-platform, supporting ARM, x86 and RISC-V initially=2E
>
>This series provides some initial support for this, for comment only=2E
>
>
>Simon Glass (9):
>  upl: Add support for reading a upl handoff
>  upl: Add support for writing a upl handoff
>  upl: Add basic tests
>  upl: Add a command
>  upl: Add support for Universal Payload in SPL
>  spl: Plumb in the Universal Payload handoff
>  Plumb in universal payload to the init process
>  sandbox_vpl: Enable Universal Payload
>  upl: Add initial documentation
>
> boot/Kconfig                      |  72 +++-
> boot/Makefile                     |   4 +
> boot/upl_common=2Ec                 |  51 +++
> boot/upl_common=2Eh                 |  24 ++
> boot/upl_read=2Ec                   | 607 +++++++++++++++++++++++++++++
> boot/upl_write=2Ec                  | 623 ++++++++++++++++++++++++++++++
> cmd/Kconfig                       |   7 +
> cmd/Makefile                      |   1 +
> cmd/upl=2Ec                         |  99 +++++
> common/board_f=2Ec                  |  22 ++
> common/board_r=2Ec                  |   2 +
> common/spl/Makefile               |   2 +
> common/spl/spl=2Ec                  |   6 +
> common/spl/spl_fit=2Ec              |  22 ++
> common/spl/spl_upl=2Ec              | 153 ++++++++
> configs/sandbox_defconfig         |   6 +-
> configs/sandbox_vpl_defconfig     |   4 +
> doc/usage/cmd/upl=2Erst             | 149 +++++++
> doc/usage/index=2Erst               |   2 +
> doc/usage/upl=2Erst                 |  27 ++

/doc/usage/spl_boot=2Erst should be updated, too=2E

Best regards

Heinrich


> include/asm-generic/global_data=2Eh |  15 +
> include/spl=2Eh                     |  11 +
> include/upl=2Eh                     | 361 +++++++++++++++++
> test/boot/Makefile                |   2 +
> test/boot/upl=2Ec                   | 457 ++++++++++++++++++++++
> test/py/tests/test_upl=2Epy         |  25 ++
> 26 files changed, 2750 insertions(+), 4 deletions(-)
> create mode 100644 boot/upl_common=2Ec
> create mode 100644 boot/upl_common=2Eh
> create mode 100644 boot/upl_read=2Ec
> create mode 100644 boot/upl_write=2Ec
> create mode 100644 cmd/upl=2Ec
> create mode 100644 common/spl/spl_upl=2Ec
> create mode 100644 doc/usage/cmd/upl=2Erst
> create mode 100644 doc/usage/upl=2Erst
> create mode 100644 include/upl=2Eh
> create mode 100644 test/boot/upl=2Ec
> create mode 100644 test/py/tests/test_upl=2Epy
>
