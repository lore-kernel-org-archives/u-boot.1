Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82116CF3959
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFDE983DA6;
	Wed, 19 Nov 2025 18:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F7883F69; Wed, 19 Nov 2025 18:01:22 +0100 (CET)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9D6835C6
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBSRz3CFlztrW;
 Wed, 19 Nov 2025 18:01:19 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBSRx524gzHkl; Wed, 19 Nov 2025 18:01:17 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/4] led: remove green and red status LEDs from legacy LED API
Date: Wed, 19 Nov 2025 18:01:11 +0100
Message-Id: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02PzW7DIBCEX8XiXCzz22BFVd+jygGWxUGKTQq21
 SrKu5c4VtsDQrMw3+zcSMEcsZC+uZGMaywxTVWwl4bA2U4D0uirJrzjijFmKKS8LoVe0NNcz5A
 RJ2qZCsh1EMY5Uq3XjCF+bdiP01Nn/FwqfX4O/+B9s6P5xkwXT/1MPXCpO+U9HA79yh7MEUuxu
 +W4eyTTXLLXVnZKdp2mjF7tnCNgC+c02+zfQyqlLXMLaXwj/0v95pqaO1j43uKXaSn1guSRei0
 UGAXBYrfv4GzB+jiOce4b4I6rcAhaW8FQBJSP/wKkECYYZZ2sJZxx5HS//wCQaObLaAEAAA==
X-Change-ID: 20251119-corvus-led-red-green-a15fe26f39bb
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

Only the Siemens corvus board seems to be using these two status LEDs
from the legacy LED API.

Since we're trying to get rid of the last users of the legacy LED API,
let's migrate Corvus to the modern LED API instead, which uses DM. For
Corvus's case, it also uses DM_GPIO (already enabled in defconfig).

Since there was no use for the green status_led (not compiled in), it
simply is removed without migrating it to the modern API. If need be, we
can always add a new gpio-led in the FDT.

Note that I do not own a Siemens Corvus board so it's a bit of a shot in
the dark whether it'll work on the first try, only build tested.

The red LED should be on whenever reaching U-Boot proper CLI, if not we
have an issue.

The LED should be controllable with the led command from U-Boot proper
CLI.

This is a follow-up to:
- https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
- https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
- https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/

to continue the effort of getting rid of the legacy LED API. This series
depends on the series listed above.

Multiple other smaller series are coming. I split the whole thing into
different chunks as separate series:
 - "easy" migrations (this series)
 - "shot in the dark" migration of Socfpga Softing Vining board
 - removal of LED support for a board with no easy migration path
 - make Sunxi community bear the cost of maintaining the last part of the
   legacy API by making it Sunxi-specific,
 - migrate Olinuxino to new API (which requires net/bootp.c to use the
   new API at the same time) + remove everything related to legacy LED
   API,

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      corvus: remove green led support
      led: remove support for green status led in legacy API
      corvus: migrate red LED to the modern API
      led: remove support for red LED in legacy API

 arch/arm/dts/at91sam9g45-corvus.dts | 11 +++++++++++
 arch/arm/lib/crt0.S                 |  3 ---
 board/siemens/corvus/board.c        | 22 ----------------------
 cmd/legacy_led.c                    | 12 ------------
 common/board_f.c                    | 16 ----------------
 configs/corvus_defconfig            |  2 ++
 doc/api/led.rst                     | 19 -------------------
 drivers/led/Kconfig                 | 28 ----------------------------
 drivers/misc/gpio_led.c             | 30 ------------------------------
 include/status_led.h                | 16 ----------------
 10 files changed, 13 insertions(+), 146 deletions(-)
---
base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
change-id: 20251119-corvus-led-red-green-a15fe26f39bb
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

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

