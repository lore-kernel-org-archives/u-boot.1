Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC988C87FCF
	for <u-boot@archiver.kernel.org>; Sun, 10 Aug 2025 22:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D35F98329F;
	Mon, 11 Aug 2025 00:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xhti1hUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A9D833ED; Mon, 11 Aug 2025 00:27:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4838329C
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 00:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f248=2X=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754864815;
 bh=9Oshx8c+2HyH8W7PGx1je5ANJBgcJY0aXYwEao5GATo=;
 b=xhti1hUZWmXbmdi7jy/FKNUoA+hTshAnYRu8xNnujlVdLgEs+fysz+w87Z7xrbRjFkpngM+ch
 SiB6FMYHJC9Tx7P1t3I1UTCGg3JV2mwatcZyWoLgK9tRy9SZ3wzZie8j2Zcqypv5aHgNIKteaLE
 5R3EjOLSkxL4RR6vI3xz89/KKnVBaEu0c5O/4eockOhQ4+Tu2rMQ41neSwT93R9fRJeWenXnriT
 G+EJU8UVJFZzELehnE3kJSGMQGO42nAuKtRtll8r8HP4+tX+zNsQcYqwVn2SvVYgc3/qcfkXbr3
 R2teSFRLnj2w8PP5hXN6ho5ChcUeKBskFPe/T3eZiwNg==
X-Forward-Email-ID: 68991caab34c1b14a67b3872
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/3] rockchip: Add initial RK3582 support
Date: Sun, 10 Aug 2025 22:26:28 +0000
Message-ID: <20250810222644.4095072-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series add initial support for RK3582 support. The RK3582 is a
variant of the RK3588S with a few ip blocks disabled. What blocks are
disabled/non-working is indicated by the ip-state in OTP.

Compared to the vendor U-Boot variant, this mark cpu and vdec/venc with
status=fail instead of removing nodes during DT fixup. Linux skip cpu
cores marked as failed staring from v5.17-rc1, however the GIC driver
will generate a harmless WARN_ON that safely can be ignored. A patch for
Linux will be sent to skip the WARN_ON for failed/disabled cpu cores.

It is recommended to use rk3588_ddr_lp4_1848MHz_lp5_2112MHz_v1.19.bin
as DRAM init blob RK3582, listed in latest RKBOOT/RK3582MINIALL.ini.

Changes in v3:
- Apply same policy for RK3582/RK3583 to match vendor U-Boot
  linux-6.1-stan-rkr6 tag, allow use of the GPU and one vdec core.
- Update rkvdec node name to match latest mainling Linux DT patches.
- Update commit message to reflect updated policy

Changes in v2:
- Refactor code to first apply policy to ip-state and then fail cores
  based on the updated ip-state
- Add support for failing rkvdec and rkvenc cores
- Append soc compatible to board model
- Add patch to add support for ROCK 5C Lite variant

Jonas Karlman (3):
  rockchip: Add initial RK3582 support
  rockchip: rk3588-generic: Enable support for RK3582
  rockchip: rk3588s-rock-5c: Add support for ROCK 5C Lite variant

 arch/arm/dts/rk3588-generic.dts        |   4 +-
 arch/arm/mach-rockchip/rk3588/Kconfig  |   9 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c | 206 +++++++++++++++++++++++++
 configs/generic-rk3588_defconfig       |   1 +
 configs/rock-5c-rk3588s_defconfig      |   1 +
 doc/board/rockchip/rockchip.rst        |   4 +-
 6 files changed, 217 insertions(+), 8 deletions(-)

-- 
2.50.1

