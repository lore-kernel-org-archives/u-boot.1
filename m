Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8724BCF885C
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 13:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48C683EF5;
	Thu, 20 Nov 2025 14:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55DBD840A9; Thu, 20 Nov 2025 13:48:28 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3465983D3C
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBynh5LTWzYRn;
 Thu, 20 Nov 2025 13:48:24 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBynd4tcSzH9; Thu, 20 Nov 2025 13:48:21 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] led: remove legacy API
Date: Thu, 20 Nov 2025 13:48:04 +0100
Message-Id: <20251120-legacy-led-removal-v1-0-369d44338358@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32R22rDMBBEf8XouTK6xzal9D9KHnRZJYLYSiXbp
 IT8e5XYTVNo+7SM4IxmZ88oQwqQUVedUYI55BCHIuhThexeDzvAwRWNGGGSUkbwAXbafpThcII
 +zvqADQMqRUNaqwQq4DGBD6eb6dt20Qnep+I9Lo/f1l21GFN2c4wHh92InWVCEemcbZpuplfPH
 nLWK/K8MoIqJuimFkQKQhSm+KjHFCzUdh9HndyrjznXeaxt7F/Q40r3f9vHhaZhymXY6AA7xaV
 tpfUayJrhN9rGNE95rcPhXQIYsKbSA1Oet8b8w5o7uPTIDLVguNowpf/Cfl4gT8MpYCm0YKZVV
 tCvqEZnKNn6PoxdZZlh0jdeKc0pcA/iuhq3gvPWt1IbUfo2rUHby+UTZqzrdhECAAA=
X-Change-ID: 20251120-legacy-led-removal-b2e154809c64
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huan Wang <alison.wang@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philip Molloy <philip.molloy@analog.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, briansune <briansune@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Thu, 20 Nov 2025 14:58:48 +0100
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

This migrates the last user of the legacy LED API, IMX233-OLinuXino and
net/bootp.c, to the modern LED framework.

I do have concern about being able to use BOOTP in SPL? In which case, I
should probably add an additional check on CONFIG_IS_ENABLED(LED) in
addition to IS_ENABLED(CONFIG_LED_BOOT)?

I haven't tested this as I do not own an IMX233-OLinuXino, so please
give this a try if you own this device.

Then, since there's no user left of this legacy API, it is entirely
removed.

This is a follow-up to:
- https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
- https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
- https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/
- https://lore.kernel.org/all/20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de/
- https://lore.kernel.org/all/20251119-led-legacy-vining-v1-1-6107439085a0@cherry.de/
- https://lore.kernel.org/all/20251119-bus-led-removal-v1-1-340218264e59@cherry.de/
- https://lore.kernel.org/u-boot/20251120-legacy-led-sunxi-v1-1-c4c1422fd242@cherry.de/

to continue the effort of getting rid of the legacy LED API. This series
depends on the series listed above.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      led: migrate last legacy LED user (olinuxino+net) to modern LED framework
      led: remove legacy API

 README                                       |  26 ---
 arch/arm/dts/imx23-olinuxino-u-boot.dtsi     |  15 ++
 arch/m68k/lib/bootm.c                        |   3 -
 board/isee/igep00x0/igep00x0.c               |   1 -
 board/olimex/mx23_olinuxino/mx23_olinuxino.c |   7 -
 boot/image.c                                 |   4 -
 cmd/Makefile                                 |   1 -
 cmd/ide.c                                    |   4 -
 cmd/legacy_led.c                             | 161 ----------------
 common/board_f.c                             |   1 -
 common/board_r.c                             |  11 --
 configs/mx23_olinuxino_defconfig             |  12 +-
 doc/api/led.rst                              |  63 -------
 drivers/led/Kconfig                          | 267 ---------------------------
 drivers/misc/Makefile                        |   2 -
 drivers/misc/gpio_led.c                      |  52 ------
 drivers/misc/status_led.c                    | 124 -------------
 include/status_led.h                         |  68 -------
 net/bootp.c                                  |   8 +-
 19 files changed, 23 insertions(+), 807 deletions(-)
---
base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
change-id: 20251120-legacy-led-removal-b2e154809c64
prerequisite-change-id: 20251112-led-old-dt-dc24605ddc88:v1
prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
prerequisite-message-id: <20251114162417.4054006-1-patrice.chotard@foss.st.com>
prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
prerequisite-patch-id: b92d833519a5a605c2129ea08a4dc32cbdbab36f
prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
prerequisite-patch-id: 3600c976c13534519ca5d0891a9c4f665dd761ed
prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
prerequisite-patch-id: aa471cc044809dab0ca6068615cfeba8f3bce121
prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
prerequisite-change-id: 20251119-legacy-led-unused-code-d635c95cfae0:v1
prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
prerequisite-patch-id: 3a1b906e26d94930b7634ae0ca35c5043b37f617
prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
prerequisite-patch-id: a0b2962b16facff0acc9b63ab9884400c1df8fd3
prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
prerequisite-patch-id: 2793fca5e19cd95cb92e477b2fe1e0179ce0e9e4
prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
prerequisite-patch-id: bc18b41151c9198e1dcaedf483b5d31aae40f0ca
prerequisite-patch-id: 18f4952525fe4c8c3ab1ae1685e84b65d71c8634
prerequisite-patch-id: 1d432ed6b7fb6482f98a336cdebae29cec8e7a30
prerequisite-patch-id: a096ab165f9fcce2e5806012d385f6fd6cf0f6b5
prerequisite-patch-id: 9677d1503c67524e554b4f7fd8ab5f0cc940e715
prerequisite-change-id: 20251119-corvus-led-red-green-a15fe26f39bb:v1
prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
prerequisite-patch-id: 3a1b906e26d94930b7634ae0ca35c5043b37f617
prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
prerequisite-patch-id: a0b2962b16facff0acc9b63ab9884400c1df8fd3
prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
prerequisite-patch-id: 2793fca5e19cd95cb92e477b2fe1e0179ce0e9e4
prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
prerequisite-patch-id: bc18b41151c9198e1dcaedf483b5d31aae40f0ca
prerequisite-patch-id: 18f4952525fe4c8c3ab1ae1685e84b65d71c8634
prerequisite-patch-id: 1d432ed6b7fb6482f98a336cdebae29cec8e7a30
prerequisite-patch-id: a096ab165f9fcce2e5806012d385f6fd6cf0f6b5
prerequisite-patch-id: 9677d1503c67524e554b4f7fd8ab5f0cc940e715
prerequisite-patch-id: 2af5430af07b98b9f24ff2d81edf8fffb18ba933
prerequisite-patch-id: 6f09f7860e01374b293497011a10ebdef73312aa
prerequisite-patch-id: f84fc6791df9d833579fedc039cabae4b51f6f0d
prerequisite-patch-id: 24a6a996108075f180a934108dfe0145d265ebcd
prerequisite-change-id: 20251119-bus-led-removal-2b1ceb36726a:v1
prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
prerequisite-patch-id: 3a1b906e26d94930b7634ae0ca35c5043b37f617
prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
prerequisite-patch-id: a0b2962b16facff0acc9b63ab9884400c1df8fd3
prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
prerequisite-patch-id: 2793fca5e19cd95cb92e477b2fe1e0179ce0e9e4
prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
prerequisite-patch-id: bc18b41151c9198e1dcaedf483b5d31aae40f0ca
prerequisite-patch-id: 18f4952525fe4c8c3ab1ae1685e84b65d71c8634
prerequisite-patch-id: 1d432ed6b7fb6482f98a336cdebae29cec8e7a30
prerequisite-patch-id: a096ab165f9fcce2e5806012d385f6fd6cf0f6b5
prerequisite-patch-id: 9677d1503c67524e554b4f7fd8ab5f0cc940e715
prerequisite-patch-id: 2af5430af07b98b9f24ff2d81edf8fffb18ba933
prerequisite-patch-id: 6f09f7860e01374b293497011a10ebdef73312aa
prerequisite-patch-id: f84fc6791df9d833579fedc039cabae4b51f6f0d
prerequisite-patch-id: 24a6a996108075f180a934108dfe0145d265ebcd
prerequisite-patch-id: 6ea898c69b7849f31860f42fec9ac11c87d41c7e
prerequisite-patch-id: ee3e130e974ac218ff6785c6a993a1ed113c95a8
prerequisite-change-id: 20251120-legacy-led-sunxi-54a42b96c410:v1
prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
prerequisite-patch-id: 3a1b906e26d94930b7634ae0ca35c5043b37f617
prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
prerequisite-patch-id: a0b2962b16facff0acc9b63ab9884400c1df8fd3
prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
prerequisite-patch-id: 2793fca5e19cd95cb92e477b2fe1e0179ce0e9e4
prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
prerequisite-patch-id: bc18b41151c9198e1dcaedf483b5d31aae40f0ca
prerequisite-patch-id: 18f4952525fe4c8c3ab1ae1685e84b65d71c8634
prerequisite-patch-id: 1d432ed6b7fb6482f98a336cdebae29cec8e7a30
prerequisite-patch-id: a096ab165f9fcce2e5806012d385f6fd6cf0f6b5
prerequisite-patch-id: 9677d1503c67524e554b4f7fd8ab5f0cc940e715
prerequisite-patch-id: 2af5430af07b98b9f24ff2d81edf8fffb18ba933
prerequisite-patch-id: 6f09f7860e01374b293497011a10ebdef73312aa
prerequisite-patch-id: f84fc6791df9d833579fedc039cabae4b51f6f0d
prerequisite-patch-id: 24a6a996108075f180a934108dfe0145d265ebcd
prerequisite-patch-id: 6ea898c69b7849f31860f42fec9ac11c87d41c7e
prerequisite-patch-id: ee3e130e974ac218ff6785c6a993a1ed113c95a8
prerequisite-patch-id: eeac7f5e34057ffde0a1f5b0e24596511d4f66c2

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

