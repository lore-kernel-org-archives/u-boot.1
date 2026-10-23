Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1220606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iRQsYO3F;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guDvftlp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B56AB60A66;
	Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9N53xr0aOc18; Fri, 23 Oct 2026 22:18:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDC216069D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793918;
	b=qsw2Knj85cgnRYLmU0+KHuBFsRwtzjVyzF4n9n9qj9H/XYOz2vtx7qxqrTPCez7mPvzZ
	 eZiZLXTEniwY19ZA6mWPLtz4KmCy8XcE3+2pJND6oMnd6XFG5RNTQFKPOAG/2xs/4mev1
	 eaBYWoDGnmt+qe7OjlvNw44/NTf6p2mjeCnICOmQ6UU0Ewcb1ict/QjC/IP68dHEuPAov
	 +yi/OqTIsD2QJZY4IsD26LxchoRsO/LIOdU7GsNq5rqIYzZfamfxPI/daTiij9FYibiw+
	 v5xhMNv9Int6VVwYeTBi80AfSRaX/lvy9xN6jDyibk8QSiJAjhRLFbp+Byg9kQzd/FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=slY71mDXqAg8VGTglhwsx1srHiKRzwmiGCgx6lI/88Q=;
	b=RQQLaAy8tKNf/Z9/H2v+Sb82UbMw6IihN+ttss2hNBGtQeeiOZ3Qp+RPzoMRmM6Nfr4k
	 kL6SxjqjxAc3ixTtDvv5BWIxNiyedo/SIXPULkRwkJsBGJ4BqgWWfSkwFQzRf0YmtAf8h
	 3cHII0+MqE/8wPlHxzCEw55HoU0yg9mdyZQFiZvoQcD2u/Z6w8UG/h71cLRAzd+UgYfQy
	 11SdkQuGWR8b5idID5PbKDTK1n3ZkSSu+gAAnb3FIkKiUGji8jc90oM7NBClcRSVvCiTE
	 jCoZh06owVCcgqh3l4WHGTu7j5GRwS0IbS/UBwcYAefID497zKnzard5Nmc0xdcVzkQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793918;
	bh=slY71mDXqAg8VGTglhwsx1srHiKRzwmiGCgx6lI/88Q=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iRQsYO3Festi9Xdu9cZQPEj9rDIvbkCNGTwX+SKhNmHflpDsIiCN2bAwskoWnBqIl
	 91ZjRi7BnOdq6H9dCnUfOP+OGckIBzt+nQbVz1YS6kfCHeGfPuA1GO0x9MRDEXNU5C
	 m2XHp9AtBvI/6sbHb0GGUcGeVnodiXVgqsLFV+oZG7Eoh0JxSaEn4Ck0gfTt0IgdCf
	 g6GUyPCLO7dv4RpOAwiKyf50knlxOO1kSewdQwHmi65YjSJQqvYu0egFdWtrVZ6NeQ
	 Swm21MIOEZ+4IDf6yp2U66kRGnXsBd4Aa1DE4k5oe+kbUt/pFIvY7PvI6nGxs13RuU
	 Nuk57G2/fA7Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDC216069D;
	Fri, 23 Oct 2026 22:18:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 748153D9
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5AED44016D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWFmMeQzFQSP for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2153740488
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793915;
 b=ioHROwvC5MJwpL55HWW47tvDzUWwZBN9SX5gO+ku9u1juCmgXM7iT6lWpSl5xHT21GEs
 R1PpH6UEnazlElWsPrGSZ/BvLZ5OOW/PvZRbNvbLrejGXuulNsWvEiW45mKWEfT6F5QYN
 GvzMHJNPy2c87zyZ3zC6vDj4ZmlURU8/ar4wziIkAdPLp5AQz6LpqZq5KlHDEC3kixSqB
 5SeUgDqQkTPFbxWTe1BijPdIFdY/9xgnF9wfk0fxBZPXyAcPDFg84WpjsGzW/hCJ7HW7o
 F8WLSotUfSp7EVxMovmXJ5jmFKCrkIPBAa2+5L5H6B0QZ/4eBCYpSpziI9o/7G0g1DA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793915;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=slY71mDXqAg8VGTglhwsx1srHiKRzwmiGCgx6lI/88Q=;
 b=KPm/rXoyZG/66nTJtHgeXmw7vxElVLs8A4wJinN7voc0uFRP9STWrSaBxms7OGw/0Rei
 sC3geDe3JtJbMCBs0VnlTWQjkNvAXgRsco/p3AN4y/SQ0BoN0NVkECF8yy11yNgVmxVTJ
 TTAUi4kjPv6Syy7XqdY9bfDHDbzi4cVk5W6IIKr0NaSN4vG4akiqv0Zg/nkNogPDIwsYt
 nrxRBbfWv7yh6dMIDbPsp7T/9h4UXezNrOpUodbZ2iBbrVS/h97CcTZuZBBgHlO/HQIoY
 ig+H8Ta+t3gno44B4uLUryt0hfl5ktuI44npkrHmnpFpRL6GPeTSRL7QjAs0wpmE8jQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=guDvftlp; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=guDvftlp
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2153740488
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1456E601DE;
 Fri, 23 Oct 2026 22:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327AB1F01825;
 Fri, 23 Oct 2026 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793912;
 bh=slY71mDXqAg8VGTglhwsx1srHiKRzwmiGCgx6lI/88Q=;
 h=From:Subject:Date:To:Cc;
 b=guDvftlpjvbQUK/GcBI2S5TAVLijnELft2Itez32MVkmzT7sRsH4P/hRIcYtp2eez
 lweetvWt8soK763/Yi9fW/fSPuYfqcNQM9rBeoBrpIs2WxRSw1rP0DnggECsPsDZ5h
 Hk7F0p34G5NWzF7+etW9OmsrTc0K0lke4ljt21GMbNUoUPQ3keRcdoavHVt1pxTsZk
 JiepHSt5qw40EPNq55xb/bKg349nO6D/xbSD0mD9EFjBRBkXLQMXeVF+gOqmNHqtCD
 OMBGDpCuVv8Fhf5gRTSWUwejioznioLBAe7FAf6p+HLq5ZfKNycP5MZ+E5M2QcD9uv
 ByVlGTZJArewQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v8 0/8] arm: u8500: Enable upstream DT based SD card boot
Date: Sat, 24 Oct 2026 00:18:27 +0200
Message-Id: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTWrDMBAF4KsErauiP0uarnqP0sVIGieiIQ5ya
 lyC7145UOpiBF2+GeYbeHc2Usk0spfDnRWa8piHSw3+6cDiCS9H4jnVzJRQVnip+efcCcFpvlG
 54JmPKWJJHA0455NzQUlWb6+F+jw/3Lf3mk95vA3l6/Fmkuv0R3QNcZJc8EgSVdKIINPrR93T+
 XkoR7aSk/oXo1YGAaUUIUG0O0ZvGd9idGWwS2BAi16HsGPMloEWYyrTy+gj9D1GLXZMt2FUq+2
 pq4xwER0YUgHMjrFbpmsxtjJWGmODjcoD7Rj3y4CQLcZVxigHShOANn+7WZblG9Dc6oZlAgAA
X-Change-ID: 20260813-ux500-external-sdcard-a49778d77b21
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-24.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch the U8500 Stemmy configuration to the upstream Samsung Janice
device tree and enable booting an EFI system from the external SD card.

Add compact DB8500 pinctrl support for applying the default states from
the upstream device trees.

The upstream device trees describe the SD card supplies through the
AB8500 or AB8505 PMIC. Add support for the AUX3 regulator used as
vmmc-supply, using the existing AB8500 PMIC driver for register access.
Enable fixed regulators for the vqmmc level shifters used on the other
supported Samsung boards.

Backport the Linux DTS fixes for Golden's duplicate regulator
name and GPIO key labels. These patches are now in the upstream Linux
kernel tree.

The seven supported device trees are packaged into a FIT appended to U-Boot.
The Samsung firmware machine ID selects the matching tree at runtime. Codina
TMO shares the Codina machine ID and is distinguished by board ID. This keeps
the board-specific SD supplies, level-shifter GPIOs and MMCI signal-direction
settings in their respective device trees while using a single U-Boot binary.

This has been tested successfully to boot PostmarketOS on all the known
Sansung Ux500 devices using the EFI boot flow, with some minimal changes to
the PostmarketOS to use systemd-boot and compile in the right EFI kernel
configs and EFI stub.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v8:
- Rebased on U-Boot main branch and dropping the Pl180 improvements
  already upstream.
- Link to v7: https://patch.msgid.link/20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org

Changes in v7:
- Picked up final ACKs.
- Rebased on aug 29 main branch.
- Added committ IDs that will be upstream in the Linux kernel
  once the pull requests go in from the ux500-dts-for-soc branch.
  https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/log/?h=ux500-dts-for-soc
- Link to v6: https://patch.msgid.link/20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org

Changes in v6:
- Stop enabling PL180 power-save mode when gating idle card clocks.
- Reformat and group the AB8500 regulator register definitions.
- Document the disabled SDIO controller in the U8500 overlay.
- Scope multi-DTB FIT settings to Stemmy.
- Link to v5: https://patch.msgid.link/20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org

Changes in v5:
- Replace Golden U-Boot overlays with pending Linux DTS backports.
- Add a regulator clamp API in a separate preparatory patch.
- Select the closest supported initial SD supply voltage.
- Support the AB8505 VAUX3 3.05 V selector override.
- Recognize normal and low-power VAUX3 states as enabled.
- Recognize the alternate Gavini firmware machine ID 3296.
- Boot tested on all Ux500 devices including Gavini and Kyle.
- Link to v4: https://patch.msgid.link/20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org

Changes in v4:
- Package all seven Stemmy device trees in an appended FIT.
- Select the Stemmy device tree using the firmware machine and board IDs.
- Print the firmware machine and board IDs for diagnostics.
- Link to v3: https://patch.msgid.link/20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org

Changes in v3:
- Disable unsupported DDR mode on the internal eMMC controller.
- Gate idle PL180 card clocks and honor clock-disable requests.
- Shut down PL180 card supplies at OS handoff.
- Skip global EFI boot entries when scanning the external SD card.
- Disable the unused WLAN SDIO controller in U-Boot.
- Remove the obsolete downstream Stemmy and DBx500 device trees.
- Provide a fixed clock for the internal eMMC controller.
- Enter fastboot when the volume-down button is held.
- Use standard DM helpers to bind the AB8500 AUX3 regulator.
- Select 3.3 V supplies for eMMC-only PL180 hosts.
- Use Nomadik DT-binding macros in the pinctrl driver.
- Link to v2: https://patch.msgid.link/20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org

Changes in v2:
- Use the new mailing list address, no other changes.
- Link to v1: https://patch.msgid.link/20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org

---
Linus Walleij (8):
      pinctrl: Add compact Nomadik pin controller
      power: regulator: Add AB8500 AUX3 support
      arm: u8500: Enable SD card regulators
      configs: stemmy: Boot EFI from external SD card
      arm: u8500: Switch Stemmy to upstream Janice device tree
      ARM: dts: ux500: Make panel regulators have unique names
      ARM: dts: ux500: Harmonize GPIO key names
      arm: u8500: Package Stemmy device trees in FIT

 MAINTAINERS                                        |    2 +
 arch/arm/Kconfig                                   |    5 +
 arch/arm/dts/Makefile                              |    1 -
 arch/arm/dts/ste-dbx5x0-u-boot.dtsi                |   38 -
 arch/arm/dts/ste-dbx5x0.dtsi                       | 1144 --------------------
 arch/arm/dts/ste-ux500-samsung-stemmy.dts          |   36 -
 arch/arm/dts/u8500-u-boot.dtsi                     |   31 +
 board/ste/stemmy/stemmy.c                          |   77 +-
 configs/stemmy_defconfig                           |   10 +-
 drivers/pinctrl/Kconfig                            |    7 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-nomadik.c                  |  230 ++++
 drivers/power/pmic/ab8500.c                        |    1 +
 drivers/power/regulator/Kconfig                    |    7 +
 drivers/power/regulator/Makefile                   |    1 +
 drivers/power/regulator/ab8500.c                   |  171 +++
 .../src/arm/st/ste-ux500-samsung-golden.dts        |   10 +-
 17 files changed, 540 insertions(+), 1232 deletions(-)
---
base-commit: f97bb5c1ad78e95856917b92c7270c82d4b11e21
change-id: 20260813-ux500-external-sdcard-a49778d77b21

Best regards,
--  
Linus Walleij <linusw@kernel.org>

