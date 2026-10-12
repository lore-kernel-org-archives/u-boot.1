Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882E4CA9EDD
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AC3780AF1;
	Mon, 12 Oct 2026 15:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id px6c1IdRy1jq; Mon, 12 Oct 2026 15:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 45F7A80DD0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817281;
	b=OrlVpA2Vn3VJqqluF7u1Tx+R5XdP01q1QI6utoGfvnP3qE2jb0NdCNUfk5PgT2pLTNAb
	 WffV6WQZoyE9eK3vkH0uS9CbBXrnTXcY+sSU5AWXrIBR1QkTkxJdb6iQeF4Q2IzOeOOms
	 O/5dxttp09ZXYKjC8IS56Ki3BJKoSdCa+0JAG8nBuGKZkyRLV+XQfBSqsKBkoOsFAjXL8
	 jxXV8ehoC58ZRB316/WqA56A2KUquyyXXTqCZDkyQVZ7ia02CjcrhDeNIdKJWz5oZKbA/
	 PFReABCSVa4WhnxC6bU+TvImbFIZy7aF5LUx6H1gxo2w9RcqcK6PKDsNJn7r/ksqWIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=6kfanwIa5t80572XJizS65CdaTj/Yrxuf8Wdqokg2rM=;
	b=QbSXjhyDF4QPxTVh5s4ba2ERpxBEqbEL1uizZHxuvv9C9HhVYgp78j0LE9vr7HM8VjB8
	 dIDM1w7g1FQKdIfqplOCq61ewSMJMPOgazTxqW5bpPpxC0cZ9PRySypv7AD/zg4hKZehN
	 ROvZz/7MoGd7dYQLSlJipr/fNQy2hV0RUtUwUXss4Djlc0fBgtpkfiOFDYgeJhLsmAFMf
	 7Mu/ETRk92Q/AA/nqRQqqMPqm9/VlwUOON9uJM1vWHEzOPPSnDH4QlvIW1n6YUQpcT87Z
	 TPeSaAdbacXubt5d0XUzsAnNZuHOZbCR+aoZCovUojv8L/DQDM/Evf927Y2RYGTq6mA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817281;
	bh=6kfanwIa5t80572XJizS65CdaTj/Yrxuf8Wdqokg2rM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=fK23H7rw1/0Un3nNYatXhkn8+YdFaYv5yVBoj9EHhkk3sI4Iu41uQllp+BuNXKx04
	 qdmwOo/Sgi3GXFRxBS/Bxxi8hfP1PIIIUbSE4m0MUcRJZShK4Or/ZP6Zd/66fX/oB5
	 f26aPjJcl6jDX/52louRJHWHhyjSoQXpwyK1AuyF9XNktLTl99Lpdxx8Ppjxo+m1y0
	 3I/XcrFoWAd41mdhkT3t2uUOvDrLhmAkGVxCy4NG2vAURQmgL8FezOiWCNFegVuJn3
	 vsu9vyAyR9gFR/WjVN3f5g+P42akKeaA2KyzZvhJ9eUbHi+YvdmO52Ie9U7KKxJIQY
	 SDYwZiWP1bBaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45F7A80DD0;
	Mon, 12 Oct 2026 15:01:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DB27105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F7986064C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYHLNz9ufFPy for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5F6C605D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791811340;
 b=joeDgZsfPeM5RIgD/l7bgmhbyvhTr8Nz3Th3FaOuU5x0RwHVAKdAI9gy1zeJ7RrGdvDy
 Ct6k4UoBsmFzRU8JczBwjJrwWnb5idZBrwDLUP6nBeO/ducd3RtsYXGEo/O5P3z8/nTyZ
 VI2K8C1Kq9lFkPQ/BQ8tLhL7ZAXk85iO9lEBvglgI3/DUMy0CMmXhHi/RlSbT4vJE0zTU
 ZLV6aqq+/HtjY4rG1hIVesqvVUZm2ontVThzhX2znFwNdmkb9ilws+igKrhn0rYQZdVhx
 Xa0s+fRDGRlJNo01yg7ZEWCc6TMOgADL4tFSlzaOa6qhxnhDUvKk3/O7Unq8vD7Dgrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791811340;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=6kfanwIa5t80572XJizS65CdaTj/Yrxuf8Wdqokg2rM=;
 b=lAKujxcNxa5p+I3mXAwAfh7ri3w+HeQKae/n1G9odxS7sMeOZpVxkG4BK4kO5Yn2wkZV
 cqGURCBDoAl8mZNO3QOFHA71hyP8/7pf8SMg0XOIMq6PMdKJu6gvfvtWWmowenqGpgsjb
 Fn8DhNNEFctMo5dZ7l/UghxNcyFoj/afopq6r+ke6NNlctGO2EiFnXv89/L+cKbW8ooOH
 3yapK7huw11yhBY+v5VA2T6EcyjTHP/z2e3QYQxd+Aqa0UqSC4+zqUJvxE1joq856OoOS
 jgiV2uHVOfUbZRUWR9nPJovQ20vPr5TKiDE3AUyhhfvFAJqdmIAfHihSbwWIWqm5D9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TyjYOyZ3; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TyjYOyZ3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5F6C605D6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CA3343047;
 Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E19E7C2BCC7;
 Mon, 12 Oct 2026 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791811338;
 bh=em4uWzBG5IgjJJuIFVD99J/wvYwEZa2GWIcYh3xj+aY=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=TyjYOyZ3xGU5Xss6gIOwK45M6GSdRFBUN3FUUhFn7cIQov2UEiGZGoDzoRCqHjfFv
 vFJrgD8pFmc9pd+kjTp7YCwWAO9zFpfeoUj4v5iGsEfr1fAhBhQ7TkCHkpGQzL1Q68
 /UaPRf28kJJ43KnN3rbqKD7P+ePXPm04rbZUrY6c4kvWLGD0UqEGywQIOIT0pgkYu6
 RvrPV5pNzE13WEf2I8EVIX7Bodu8/jl0UFJAQw/MM14HVPQl2ceBI24ScNTwFknnfm
 nAdsbsfTVH7uN/ZOXGb0xkNZQqbDaOwjKbweRGb+i/F7zpdgICLuHqdDZZPNp6FJCu
 HHwpg/v5Fh6Zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B926ECA9ED2;
 Mon, 12 Oct 2026 13:22:18 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Subject: [PATCH v2 0/3] rockchip: rk3528: Add FriendlyElec NanoPi R28S
Date: Mon, 12 Oct 2026 21:22:15 +0800
Message-Id: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jmbc10LAisvIdhgTDImNg2LRIN6
 d0F3Lp8yfvvLxA5CEeoswUCzxLF2RXokEE3tvbOSvqVgZAKjZqUba3zogKVUWHbd4h4GozJYV3
 4wIO899q1+XF83R7cTVtiM0aJkwuf/W7Wm/e/PGuFCg31BeXVuaTq4oObnD0+GZqU0hcTlUx1u
 AAAAA==
X-Change-ID: 20261012-nanopi-r28s-0adc0003f445
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3019;
 i=HystericalDragons@proton.me; h=from:subject:message-id;
 bh=em4uWzBG5IgjJJuIFVD99J/wvYwEZa2GWIcYh3xj+aY=;
 b=owGbwMvMwCUmepz3XUtTHjvjabUkhqwz9zm57+/Mv7+VY19AdNN+i80/5Vx7CxovvihrSO++f
 mD742+tHaUsDGJcDLJiiiyym6ojhVZFzyxikToOM4eVCWQIAxenAEyk/zPD/xzeh2bWC2+vWtTj
 VFnzyuVwSLz8Pu8M8zaj5Btv7Q2q7jIyrO8uDzrOEd12sMl4w94Js9JTJNr7VFpe7Apznua/4PJ
 ybgA=
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=1DB27B5912AA5B9972041AC715C70DEE84826E07
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/default
 with auth_id=1004
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailman-Approved-At: Mon, 12 Oct 2026 15:01:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: HystericalDragons@proton.me
Errors-To: u-boot-bounces@lists.u-boot-project.org

The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
based on the Rockchip RK3528 SoC. It shares most of its design with the
NanoPi Zero2.

The Linux devicetree for the board has been applied to the Rockchip
tree for v7.4, together with a patch that splits the parts shared with
the NanoPi Zero2 into a common rk3528-nanopi.dtsi:

  fdb087806e80 ("arm64: dts: rockchip: Split out the common NanoPi RK3528 parts")
  c1e23f3425c4 ("arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R28S")

These are not yet available in devicetree-rebasing, so this series only
contains the U-Boot side for review for now. Patch 3 does not build
until the R28S devicetree is in dts/upstream. Once both commits are in
devicetree-rebasing, I will pick them into dts/upstream with
tools/update-subtree.sh and add them at the start of the next version.

Patch 1 moves the U-Boot specific parts of the NanoPi Zero2 into a
common rk3528-nanopi-u-boot.dtsi, following the split in Linux. The
NanoPi Zero2 u-boot.dtb is identical before and after this patch.

Patch 2 adds a NanoPi RK3528 board target that reads the HW_ID on
SARADC channel 2 to select the FDT in SPL and set fdtfile, in the same
way as the Radxa ROCK 2 board target, and moves the NanoPi Zero2 to it.

Patch 3 adds the NanoPi R28S to that board target, so that
nanopi-zero2-rk3528_defconfig supports both boards.

nanopi-zero2-rk3528 was build-tested with the devicetree files from
v7.4-armsoc/dts64 copied into dts/upstream; the resulting FIT contains
both the Zero2 and the R28S FDT.

---
Changes in v2:
- Add a common NanoPi RK3528 board target that selects the FDT using
  the HW_ID on SARADC channel 2, instead of adding a new defconfig for
  the R28S (Jonas)
- Add Jonas Karlman as reviewer for the R28S.
- Link to v1: https://patch.msgid.link/20261012-nanopi-r28s-v1-0-042d62597829@proton.me

---
安容 (3):
      rockchip: rk3528: Split out common NanoPi u-boot.dtsi
      board: rockchip: Add common NanoPi RK3528 board target
      board: rockchip: Add FriendlyElec NanoPi R28S

 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi      |  3 ++
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi           | 16 +++++++
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi     | 10 +---
 arch/arm/mach-rockchip/rk3528/Kconfig            |  7 +++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS        |  6 ---
 board/friendlyelec/nanopi-rk3528/Kconfig         | 14 ++++++
 board/friendlyelec/nanopi-rk3528/MAINTAINERS     | 13 ++++++
 board/friendlyelec/nanopi-rk3528/Makefile        |  3 ++
 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c | 59 ++++++++++++++++++++++++
 configs/nanopi-zero2-rk3528_defconfig            |  3 ++
 doc/board/rockchip/rockchip.rst                  |  2 +-
 11 files changed, 120 insertions(+), 16 deletions(-)
---
base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
change-id: 20261012-nanopi-r28s-0adc0003f445

Best regards,
--  
安容 <HystericalDragons@proton.me>


