Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EF606A320
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1Nn7p/+v;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh9HMQgX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EF13405B3;
	Wed, 21 Oct 2026 22:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HpQrUIfJV3c; Wed, 21 Oct 2026 22:19:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 662CB40596
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792621174;
	b=JviCwhxS+SPBiFiiHhpF3NX5nm6txC6rKgR0HUaPRZsgjVqkHKfRRRfhQy+fKgglPmD1
	 YWA9/Q6fEEzYj4Zicv233/gbMIatCrd0o0c9CFRy/qu69D+caPmLxk6nqwtDxc0wXABA4
	 6vE0FlI0oUXMUYH8YJqwtKxUmlMI2JSGiHCufNzW17F45G8aDr0t0AEAdPIe2VkJEY8Cu
	 vEVKj1PYPGhD4VBqIT459ItTxdShvIiwkeHzKeA4nzXxy3vIT3aXGoJlH4EQL8JLAfsLl
	 c65dd91L7ApYiT1f37Q1DRCIgVyFJJtBI1/C/ldwbj6dQ5bhs/XbTDBcjVy/wu/MlvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792621174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=uu2h2mt67+k0Qg/aJ/T8BUPt5SNpP24lhsTnUJh4Xdc=;
	b=YI89Z5AGox85xxpeVjZWf27CNVJxCGGCKYABfLPa8sHhIT3pwVJftoo0nRrc1ZjV7Y7E
	 TBmxALAhCFNxBCDhMTgaPjR8A8umoIBiY5G9Si0PU/t3vgBac2cQA6F9WHsO77LJv9412
	 deE6rZkGTaiiwJAOw3qaOA858FadA81pd54EJmjXWbhUYgt/jA4Lmd5rPOTd9AqXS3M0t
	 VP+aoycqNl+TcwNCBZTbZZAzFRb8gtQsQudJ4+deQ06dMRqnM2gHUQlc4yDqEiAmJmieP
	 0KxsORGr2Jt9su5ToktqS3t/5yYs2QnHqGXuRYAc9qxisqFHaGXhtJoS7T21SJeC47g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792621174;
	bh=uu2h2mt67+k0Qg/aJ/T8BUPt5SNpP24lhsTnUJh4Xdc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=1Nn7p/+v9JOytD/n9WccCiKeCjlSKHVbLw3fwhp0klr+i1DRlb0pMoueOPqPL4AaG
	 Nrlo7mDNq49pQhLuUuyhzwLxTo0ho+Ld9/wAMTW+TGFDdGOPu5P465eTYYXcZ0KP/B
	 PpM4NKnMzWGrcgQbspUXpUmt4M4xb2+gweN02gU6xBmY96RY3PEOeCFiWPjE4nLjam
	 qMwnvKifckurZEbzWwpuQOZGfaI0HOWadjGVqrMPjEBYUG3+uSB6hTXoCXrGjIi2Qb
	 5LLsiz22mIfmFAaaAjArSMYHZwPb7LNeqd/e5XxxW5tRRycYC0fliLtAmFd4EPSiZT
	 XmIy0GZ4BPWNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 662CB40596;
	Wed, 21 Oct 2026 22:19:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 952951AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B7F14016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BdU_HW-EXIsE for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 21:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7702140042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792617427;
 b=qm5vkFgZLpmdW0Iv7Zw1JtlF7W//oEi4B8+RDAdMxREjmwU+UFcfypt3zf/yDmVPFMXe
 SZ7I4nTchSoAysgNTrDsIoyvdG0OaS6j4xMQcaT+9qgHgtUBdpA55pOwLurROORFH1f5g
 v3xU9ewZRNJqEQRL8FRM3s1V5qmRq05JZmrASwLYs4zMRnHbgddlRrQcrZKnhmpEGSJ0m
 MhYzKT2DVgCdUZRTU0wOAFl16AEq5L7jfPwntGvsE9cv3ou71jz0srUz7iXuIcOkFW9JR
 CDAkIc60U86nrd4eJY6W0Pu+SbO7NttX+yNBOpdZWZOvoo/DibtRe5sJqUwfVcjvhnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792617427;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=uu2h2mt67+k0Qg/aJ/T8BUPt5SNpP24lhsTnUJh4Xdc=;
 b=adEy3NUNCU8L17TZ/VezyTebHC/dugMmQ55+efB6F/fe+pphDS0wiCShS/SOhyXA7H8G
 Nu4scOBClB3hXWy3ZAJ3EphDOMc+Wy+ebsh+nVv+nln58YxGL209Lrgp6XtHBBoBYzVfq
 2/r5Dh9heJWIL9pCHXAx+sfEVlxZiWy2miYdeg/c5mWWoZXk+iy00jF1st/JpkaS/76QN
 tggMHg9/5LhpG+wGdWl/QAfNL24VcSPIdKh0cpzRO/jN4SpnNDQY80Rrj0PVTlqWBwELg
 IKC6MtxoO/m1mJ0P6i1DLQzcjssWGMiQos68ZDJWpVTYSO/Vitz5XjwlI/u9S5IS8SQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qh9HMQgX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+filipescu.cristian.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qh9HMQgX
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7702140042
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5377160052;
 Wed, 21 Oct 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792617425;
 b=M5vAn++6pV1zA1P391ECfrBD/TtdzdeASz0HzxS/jHcochXbxI5t6+UpAVXg56PARvkU
 N10d19FIaL59Fc9VqluFSdlk7CzqVZIvmv+dfKBbBQMIyCo+p03uZnI1JaibCgGkTeqN7
 4isdnxacPWYogWzb4D8aJVlwOuOO4LLWSsaEpjAbaZRaf6vdz27MHE1FmngBIIyAeCsUG
 /yG0GnTjdVRpA8fqQr/tDPoSxspihfF+UZkSpECdsdHpilJz6zyKTBMh3xtwxSNp5Ip9Z
 IbCQHDEDGcQqn2y0g9wrtFWEFXq6R3nFCODyst9d/GR7nX0+XLiaGGcpu3IRilQKoxw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792617425;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=uu2h2mt67+k0Qg/aJ/T8BUPt5SNpP24lhsTnUJh4Xdc=;
 b=eIKpzjDmMJK0bdIsRow9hgIX+XZ/CLHQRLncdl0lnmh7jbh7sQ9imHrAyGtAmbRlIZiM
 /P/K0rNNR2KBmNffTKz4rZZ5abQ2L1jyHyGkIhNYcdVb00vJTMopJ1IbsocdQkzqEfCyD
 vZuRBotQ65XqWmrABA8brQVXnQmxe+e4LWw6MGUzX74YCyjF//89wcfASdhFEAZQcNX6J
 otEKlpknOHE/Wy8yyMRser0BPYrm5fO47A5G330u0UgjUdw+ctAbMJXNEK9YU1CxOF6hW
 mE0l+aTt6bje5shhjRJbiJyB+4KQ1P8cGoXsH5J62BmYKZkSX3eddU1VTCSU0sSFOxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9F28E1F000C6;
 Wed, 21 Oct 2026 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792617425;
 bh=uu2h2mt67+k0Qg/aJ/T8BUPt5SNpP24lhsTnUJh4Xdc=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=Qh9HMQgXhJILB6G1FRDBZrx1Cb5NijmJvTqqQWnCxr/qYgV9fY6K/+gPuiZ3AsTlf
 TT5d0Gw16cytR6DmLIsyC22WpnZVThUnXaCgLHkLFeJANYDONJLqSR8Qa9MWQjcmzj
 L572RJ/JfFbCt+DCPHDWAyxOL0ms+b4aisTqEcqaA4sM58CUHuxLThXLS39YSpcXHq
 alO9HHo/uC4FyjfROUcI6MuFxt4PiD+XbTKCzuhjhLZztS4n1ZSFiWtO/iiQsKfv/v
 iOFBtljwxsfbWtxLW+eeM946YYK+gsCnSen1ARBYSnQhMBqoPaz98wsL9AH/VE03ho
 Fgb2vszz/LeKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 334E64347F;
 Wed, 21 Oct 2026 21:17:02 +0000 (UTC)
From: Cristian Filipescu via B4 Relay
 <devnull+filipescu.cristian.gmail.com@kernel.org>
Subject: [PATCH 0/2] sunxi: Add Orange Pi 3 LTS support
Date: Wed, 21 Oct 2026 21:13:01 +0000
Message-Id: <20261021-sunxi-orangepi-3-lts-v1-0-19a3df928d8e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0q2WoC/yWMTQqDMBBGryKz7oBJIIJXKV0kcVJHbJSMiiDev
 Um7fN/Pu0AoMwn0zQWZDhZeUgH1aCCMLr0JeSgMutVWtVqh7OlkXHLtVkaD8yaoo+vsQDYaq6B
 c10yRz5/2+fqz7H6isFVXXXgnhL5Ywlijj+ME9/0FtVd6jo8AAAA=
X-Change-ID: 20261021-sunxi-orangepi-3-lts-2fa76de6f361
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792617188; l=3002;
 i=filipescu.cristian@gmail.com; s=uboot-20261021;
 h=from:subject:message-id;
 bh=+WN3IsTxt3TITUp03kQY8oGQ8ChFZHv0M0LuxDXupvM=;
 b=EJ6QK3dFlAlAvxJTL6Ecrwc2ZO1D0J0YF2JqFbyhOuIK2QEnpCgY1OV3H1VcbgeofKEG9vJAy
 1AJWj4McAWBATyG6nyuUR5BGXWqUFagBibBufw0+pFcoIVnCT305o+C
X-Developer-Key: i=filipescu.cristian@gmail.com; a=ed25519;
 pk=o7Ui0tU3x+X/6Pq6PZHmd2KFtOdPWttoPuNFOvdD8t0=
X-Endpoint-Received: by B4 Relay for
 filipescu.cristian@gmail.com/uboot-20261021 with auth_id=1255
X-Original-From: Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailman-Approved-At: Wed, 21 Oct 2026 22:19:28 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: filipescu.cristian@gmail.com
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a device tree and a separate defconfig for the Orange Pi 3 LTS. The
LTS has an H6, 2 GiB LPDDR3, 8 GiB eMMC and a Motorcomm YT8531C Ethernet
PHY, with power and reset wiring different from the original Orange Pi 3.

The device tree is based on Jernej Skrabec's Linux submission:
https://lore.kernel.org/linux-sunxi/20250413134318.66681-3-jernej.skrabec@gmail.com/

It lives under arch/arm/dts until the board description is merged into
Linux and reaches dts/upstream. The current dts/upstream H6 SoC and OPP
includes are reused. The original authorship and sign-off are retained.

Clock naming, regulator supply chaining and BLDO3 always-on corrections
from the earlier review are included. Ethernet uses the Motorcomm driver
with rgmii-id, zero MAC delays and explicit 1950 ps RX/TX PHY delays, as
proposed during the Linux review. This configuration has been tested on
the board with DHCP and ICMP.

Validation (including the earlier board build):
- Cross-build the revised orangepi_3_lts_defconfig with GCC 14.2.0 and
  TF-A v2.13.0 (sun50i_h6, DEBUG=1). The existing orangepi_3_defconfig
  built in the earlier validation and its sources are unchanged.
- Verify the LTS DT model, Ethernet configuration and final combined FIT.
- Match the new defconfig to savedefconfig output.
- Check both patches with checkpatch.pl --strict, excluding only the
  FILE_PATH_CHANGES warning: board/sunxi/MAINTAINERS is updated, but
  checkpatch recognises only a top-level MAINTAINERS change.

The current source differs from the tested c8f95275fc8f revision only in
LED settings: select green PL7 for the power indicator and SPL status LED,
and describe red PL4 as the status LED. The updated LED indication has
not yet been checked on the board.

On-board testing of the pre-LED-change U-Boot 2026.10-gc8f95275fc8f:
- Reaches the console and reports 2 GiB RAM.
- Enumerates SD at 50 MHz/4-bit and eMMC at 52 MHz/8-bit.
- Obtains a DHCP lease and pings two LAN hosts successfully. The control
  device tree confirms phy-mode = "rgmii-id".
- Enumerates EHCI, OHCI and XHCI root hubs. External USB peripherals have
  not been tested.

Repeated cold starts and an operating-system boot have not been tested.
The local test builds omit optional Crust firmware; suspend is not tested.

Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
---
Cristian Filipescu (1):
      sunxi: Add Orange Pi 3 LTS defconfig

Jernej Skrabec (1):
      arm: dts: sunxi: Add Orange Pi 3 LTS device tree

 arch/arm/dts/Makefile                     |   1 +
 arch/arm/dts/sun50i-h6-orangepi-3-lts.dts | 361 ++++++++++++++++++++++++++++++
 board/sunxi/MAINTAINERS                   |   6 +
 configs/orangepi_3_lts_defconfig          |  19 ++
 4 files changed, 387 insertions(+)
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20261021-sunxi-orangepi-3-lts-2fa76de6f361

Best regards,
--  
Cristian Filipescu <filipescu.cristian@gmail.com>


