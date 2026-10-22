Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6861606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F0ZR9dxJ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoA+7g/S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A9664081C;
	Thu, 22 Oct 2026 07:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tv41E82IuI_Y; Thu, 22 Oct 2026 07:27:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 833DD40801
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792654068;
	b=WLitBa0pu7sy80zEVoyDu9PGGyVAQTCGBzdv3L/kh8PaOriTUi8KiK242EoS+UIRNJBO
	 2a7rpdfGb66BhTMzlgh9nBzdzVOOd53iBryAZJ6X4HO+VwJTWxY3iNTJvq2KuM90Lf1xP
	 kk7Ha+tcLGd3jFDplws0RxCSA2UuFIPwcVyIRu2fgRPQit6Rjfi0yhlnvtKwXsTNwzNFE
	 1EoUWLn1+9AUgpXFieEaw0zw2uHITeKFXN4EzuVe/V1k8rTSkgZJviwkoRaCj6o9lUUKL
	 mwurc6B5KM1WW9R/Q+dExczMSp1w0npz1owoZ+dDMrbXMarapuIpX3BQZz4VvXN1mIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792654068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=NAzyiLOni/kZDJgh2KapIW5Iqwsa3Qg6ig36J14eJZ8=;
	b=BLWoV0RuKGwk8yjS/3EXnowbQwo0aFKdD5x+NUr9Tx5UyrBKxpYizLlr80BPYQjtTmdl
	 KEUa7753SBij4vrQyYEpfLFH8B4Wzib1aefux8CbxHMLxLb69oVgVs07GgXzudiKuEmfh
	 KG3j9lc3+dlqihXFwnB7DonchJEciCDd+WzKyngLNJBCPIWwpqd6kK+RVVlBilvFWqP2D
	 6h1HigFJFGD7VBFONNZvciLiMtBHaYPTRzfVgYbtSuqAoabx+j2h9tEynZJ5eBc2tY56J
	 wxR0hFCLzMM5ymItBUgUHiCU2QXBBATFROS3YCdfP0T2gvXAyY6pdjh3xItEYS2qGWQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792654068;
	bh=NAzyiLOni/kZDJgh2KapIW5Iqwsa3Qg6ig36J14eJZ8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=F0ZR9dxJ8HojI0NsmhfYuD7WmiDM4FgYWdV1jUGz2qhBynKT0ktK1VTU1etVCtE9p
	 vfzeTSvg5PgSQy8fe7svhJv9k6WH/Z4ODvRphzJQO5nMdNVRkYaTDveeQEw+HhqrVr
	 gBmeKwJoSCTZSPE0NtxrPCrbuTLOC6qvo9qnyUibmMB2FZoZFWpR3BYs0DN1sIIEss
	 kflZnE1qmb0qkij0XENvrUa6zAlESmi/91n3e0Y02TlYZXKd70F63UihKE13btD9+O
	 qZ0cPY0czayiLCN6sdtuqJGMJZD08PijpWEsItgZ7foYvPV1DMrf3CIp4FjvrlOSzh
	 y4u07EQ3oWz7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 833DD40801;
	Thu, 22 Oct 2026 07:27:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24847371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B1686068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00jwqyBN49DC for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 05:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F18FE606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792648752;
 b=aTFW1C3cOLhhY4NzHDoj7XdbH2pj0uh8T2wYgqoI4znqwDrT7bLz7hC9bTPu9dGgwe+8
 3SUZXrYIVcfNhKiGFeI82ihsgLs7tJvYicB6NAnjOkgrGDSrYnv9bNReRM3Nb7+ktsRdj
 d5P2MdXI8NMfqlYLJwWKlbJoIGGlvt/fpqYGOER29hT2BIDIJYgP6jGyJGwqp2B/a/wvE
 BrpCN0BK21APn20IVdBmnbFz7vSkpQSBwSW0GtZTJstDIFqOsyNkDTyOQlh8ywM07fLLY
 TbD1DrsEiw2Ff1oSCCiZnJzNCZURT9KRDC7uZH1ofbsOgJMVniRHH68/87rA/2MqmBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792648752;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=NAzyiLOni/kZDJgh2KapIW5Iqwsa3Qg6ig36J14eJZ8=;
 b=phjErYAh854iY2JXF2Z12xfNrOMdZXtGMQOaYE1tVf7+2EGzpTOcLUA1QW2hMY379Jyz
 O17nzvOIKJFV8DnY+YMSiIZGSx784k2NyOKqXPjRIo1BBD4jRhiAJb14iT8e/SG8GJB/K
 5LyAvbNu2ZUbR5xTpKCVDHG0lXEbWpB2HRLosKMLD4NHlXbUMYanXzieY4+rVGwhGjF3R
 +UYiVcm9WuupifDmxP58jcZ3xGIT9W+fphFnBx3T0QUk/GbokGS4od1hJxway/4LZwIPq
 fFxvSegDXC9eX4EPtPsRZutV0l4KFzSZUkBNMedRQpOpPtH2HpUyrifAum83v45fhCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="EoA+7g/S"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+filipescu.cristian.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=EoA+7g/S
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F18FE606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CA4A60211;
 Thu, 22 Oct 2026 05:59:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792648750;
 b=IhmM/DD4YjUhvk8BzVF/TuzG5QlIqVCi/RDoJmkKo+pxieW9CABRZm8VKh1xgf4wdss6
 UzUXr+5vMaUs/HsluAwT3vV9qfX32jImlCzFGbjlt826+t4F6FJd04vY/XRSD4B+Baj9O
 OGQRpSz/xa0pOlR0mlvgkizeWCjqHbvVugFqzQ/QA9H6DFz3/gdwDqqQO0xklEvZ2Kq6Z
 L7A/bQ+5KhkNKVXikWpGxOYov82FzA7QdGVp72JloG/CaTrpuRmJ+KssmqlFQo/3PirJ+
 JGQpbGcu67BmhixUyfdK1tqRMuwPxYvD7YAUYGT1jDd/embYG8dg0VRiEfKiSI0QsuQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792648750;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=NAzyiLOni/kZDJgh2KapIW5Iqwsa3Qg6ig36J14eJZ8=;
 b=Dzp7NAk8RSFQ1xYBN0izvSHA45/b5ehpeL+dK0C+FI7k6CYpvySf/+qOblNCRbuJXAAI
 OfxMrr/k8eFTlEqmS7kCcwu+7T3dUfqPjsJTDq60gMJhUrfvPbKTdzBMwyvIgfG0xs0f5
 863gqIqheOh20PddQn9lsFYdRVo4hpa5tjk3DSJafRNDYWprAAewDLLVJRnknAaQo4q/y
 KpMDIy4TzG051/IyGZZNxo/r3L3DmgMa0TIPDIWZa5P0maK0jigjpWS8yLSmxuzSEKUQz
 459jXTonfLOE5PjVUtiCHMiU3J5ayIVqh0+K8sVN3B5vuuK+z8l1GYttXzIaHNcyUDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E99501F000C2;
 Thu, 22 Oct 2026 05:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792648750;
 bh=NAzyiLOni/kZDJgh2KapIW5Iqwsa3Qg6ig36J14eJZ8=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=EoA+7g/Sy8R0K9zgMS5YTaharOE0qwfEMlZGs4dWlLUqlx+yCAxAdPmD3djzmpqdY
 RQfBp16Y2geJICwqf4XsfCzYHnspA77WlS3Kkaqhr0J15KvQ/HRa8xkn5mKUs+JVa+
 cMgfpIfGlH5aeCvebQaAZ4NePskvINxXqf2yim9E/jRdsUkrWwIC2tSfT2yTCWXSWk
 /+evdTG1fIBiwKPyR6F7g3Ep2aYOD9Q/SEsfskPX6JwCaagGXCEDrR43t+yHlntXz+
 JC8G7pUk2ECW+SOHMDG8uST+43nb92cod+rxzucLp927l09Ta+uSOsv/wLb/52qfm1
 nwpfve2TofO8Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 409AF434FE;
 Thu, 22 Oct 2026 05:59:08 +0000 (UTC)
From: Cristian Filipescu via B4 Relay
 <devnull+filipescu.cristian.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] sunxi: Add Orange Pi 3 LTS support
Date: Thu, 22 Oct 2026 05:55:00 +0000
Message-Id: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSl2WoC/4WOQQ6DIBBFr9Kw7jSCCdWueo/GBcKg0ygYUGNjv
 HvBHqDL92f+m9lZxEAY2eOys4ArRfIugbhemO6V6xDIJGaiEJIXgkNc3EbgQ55NBCUMcwRh1V0
 alLaUnKXqFNDSdmpfzY/j0r5Rz9mVN1oVEdpk0X2ORkUuxz3F2YfP+c7Kc/3P5ZVDAbxWpbG1q
 EyFzy65hpv2I2uO4/gCYkmjFuEAAAA=
X-Change-ID: 20261021-sunxi-orangepi-3-lts-2fa76de6f361
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792648514; l=4940;
 i=filipescu.cristian@gmail.com; s=uboot-20261021;
 h=from:subject:message-id;
 bh=w2wBOHmwb3OIqFFw3J6DNE2wEyLk5UTaOSqUVQp8+GA=;
 b=wGISQq+6rNX0FPfyHSnse6FVNxRgTsNExFZeGT2iKSRgr+quB6Wgw6KqgqujntnCItsDGIHjx
 xDL86WkT/8xCVlpoILHwDQ7wiH4hry7WLh51CQbZHCTnZpiarVfuj+9
X-Developer-Key: i=filipescu.cristian@gmail.com; a=ed25519;
 pk=o7Ui0tU3x+X/6Pq6PZHmd2KFtOdPWttoPuNFOvdD8t0=
X-Endpoint-Received: by B4 Relay for
 filipescu.cristian@gmail.com/uboot-20261021 with auth_id=1255
X-Original-From: Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailman-Approved-At: Thu, 22 Oct 2026 07:27:42 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
  TF-A v2.13.0 (sun50i_h6, DEBUG=1). Cross-build the original
  orangepi_3_defconfig too; its handoff hook remains an empty return.
- Verify the LTS DT model, Ethernet configuration and final combined FIT.
- Match the new defconfig to savedefconfig output.
- Check both patches with checkpatch.pl --strict, excluding only the
  FILE_PATH_CHANGES warning: board/sunxi/MAINTAINERS is updated, but
  checkpatch recognises only a top-level MAINTAINERS change.

The GPIO LEDs are enabled in main U-Boot, with green PL7 on and red
PL4 off. The early SPL LED is disabled. At the OS handoff immediately
after "Starting kernel ...", the LTS-specific board_quiesce_devices()
hook switches green off and red on. Linux's LED defaults retain those
states; diagnostic userspace clears both before starting the shell.
Cristian confirmed this sequence on the corrected 60d788d7056c build:
green in main U-Boot, red at the kernel handoff, both off in the shell.

On-board testing of the pre-LED-change U-Boot 2026.10-gc8f95275fc8f:
- Reaches the console and reports 2 GiB RAM.
- Enumerates SD at 50 MHz/4-bit and eMMC at 52 MHz/8-bit.
- Obtains a DHCP lease and pings two LAN hosts successfully. The control
  device tree confirms phy-mode = "rgmii-id".
- Enumerates EHCI, OHCI and XHCI root hubs. External USB peripherals have
  not been tested.

The submitted v1 (11d60b7149e6) also loaded a mainline Linux Image, DTB
and initramfs from SD and reached a RAM shell with four CPUs and 2 GiB
RAM. Its test-kernel configuration caused a PMIC I2C failure; Linux
peripheral validation remained pending in that first test.

The v2 build (f5a667df5ada) now boots Linux with CONFIG_MODULES=y into
the RAM shell. Linux initializes the AXP806, enumerates SD and eMMC,
registers eth0 and all USB host root hubs. The YT8531 PHY links at
1 Gbps/full duplex; DHCP, DNS and an IPv6 Internet ping passed on that
build. Two direct 8 MiB reads from each of SD and eMMC compared
identical under Linux. Two cold starts with LED, shell and Ethernet
checks were confirmed on the final build. Both LEDs were confirmed off
in the diagnostic shell. Sustained transfer, external USB peripherals
and HDMI remain untested.
The local test builds omit optional Crust firmware; suspend is not tested.

Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
---
Changes in v2:
- Enable GPIO LEDs in main U-Boot; drop early SPL status activation.
- Add board-specific U-Boot DT overrides: green on, red off.
- Set shared Linux defaults to retain green off and red on.
- Switch green off and red on in the LTS OS handoff hook at Starting kernel.
- Retain the original two-patch DTS/defconfig series structure.
- Link to v1: https://patch.msgid.link/20261021-sunxi-orangepi-3-lts-v1-0-19a3df928d8e@gmail.com

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Cristian Filipescu <filipescu.cristian@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>

---
Cristian Filipescu (1):
      sunxi: Add Orange Pi 3 LTS defconfig

Jernej Skrabec (1):
      arm: dts: sunxi: Add Orange Pi 3 LTS device tree

 arch/arm/dts/Makefile                             |   1 +
 arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi |  11 +
 arch/arm/dts/sun50i-h6-orangepi-3-lts.dts         | 362 ++++++++++++++++++++++
 board/sunxi/MAINTAINERS                           |   7 +
 board/sunxi/board.c                               |  19 ++
 configs/orangepi_3_lts_defconfig                  |  19 ++
 6 files changed, 419 insertions(+)
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20261021-sunxi-orangepi-3-lts-2fa76de6f361

Best regards,
--  
Cristian Filipescu <filipescu.cristian@gmail.com>


