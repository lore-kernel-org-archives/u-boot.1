Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1344EC88E50
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5126B606A7;
	Sat, 12 Sep 2026 01:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeMbAJnFvf-Q; Sat, 12 Sep 2026 01:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7A5DD6064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175251;
	b=dehFTsnK+ozLHMEExdZGytEMizormLSfItHLdku5F3rv12EC1jdfkYFbkcyfKoSmLZK4
	 zmY7VSfvbM1QTofb3JFlC1zJloekZa3DxIbdze7KTKQoOVExLQtnagSg6KJfi3LmA7MfB
	 1OSsgWH9DLWh30cOHCsKBXR1fkw2ZzfLOsZapqAYs5kcp3U+QR+TNBQNWjelpCv5VtSJC
	 lqjaCdtU+WQFwDxgiYrMmNaWY2Q1u6fPtZzbC+6S+KJMcQaE7ZeIcmxg0CWlWpcsZYLm/
	 7sspV78wZ1V7/r2SgspJNzp5b13JAi8h7iZgD/OTcA4pN11otMIuU3wMmgyTL266nxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=6Z8y7K94t96SW0FFKVUumO/UNUAZfuwWJnP9EhJEW2A=;
	b=YRL2jHg5Y1Oe/CFvl8zcgLlY7kxT5FDSNEWYvK8WrMRZYibR1FV156JimDhjDEvdpYQA
	 byrsQZHcwC/Gc2KQcNC7z0edQT5nKqz085iU27vzRPDbF2tK7JNTraivLHLG2PS1GXRG6
	 zN2KSCIRsQWtNDTEs9xIdWRG9s2ky70B69B781zOBxeE6691qH+cqd0uBLWdJnn0q1tak
	 5MOtCDMTD/+OCSQ859qwkK+hl4TPN1fSWfudTniK/Wi7WP4/zFLdiGXeWooRcupXNcVzx
	 88tKG0bRvOSoaYRz2D9RCVCQ0PSx0wbyV9Sz+CouG2aW/UBfzPhZJ9AvutgymIy6sdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HdMXT7EV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175251;
	bh=6Z8y7K94t96SW0FFKVUumO/UNUAZfuwWJnP9EhJEW2A=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=U1Pj/U7A2KX7fJ33ptwVAh4uANtzGTDWnHo+yVkELCFyyf1XYfjkE3rSiaBqws+MH
	 fvpd+YeLFnlon9LybJbQY6kN+AENtjcuzHHuEooGOTHiV6VaA8s2abKip/nN/8VOI/
	 zrRLNNAu4ocjQWK6cLVYzpQiIrPtlH50JClRTJV+IbBQ9bTPNu1OlfHOKUwxQgelYF
	 ke6WcnMYaFjHuLngnlZa0uc5RkvPuEgSqZm4xpVFkIKu72x7qp4+jApj32IGGGTmSw
	 Kt68+Wcxywz0NJcbgC+kzEn3anrvJRFeyu1xUbemfHo8IXjptVJuC5vtGTaRMnMobS
	 2YcrmLw5G2JUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A5DD6064F;
	Sat, 12 Sep 2026 01:07:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1A68255
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D37946061C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rr-l1SW-hacK for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0549D60617
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789150744;
 b=oYyAdqwXv+QEDJPjMPzl7rEnV/MeQpJanFZMCANZqjXWm4VnUUfzvpD5zh+GbRgUF00f
 O1iV5vviFgM6JeLWLnGuLw9uQSowLkNiVrXDpP3hRK22kyr+HdfPN8P3DOsJtCDmZq+G1
 0g73qQCUllkq4wv+E8d6InfM1R1KGlqUlbVAx0P/aGDFlZ2NA0pF3feag7aBTEzl0v/6K
 zyOZcXLcwSczBIpdkygx73Hi3gJ+8SSG2x6bmnV/pc8IiaclFNMLivx0f+uUgzERh/Ev2
 ZRm85WsL2jW/S41DSCvfdxdoygzwAOZUfWk+wTHt8iEzSIfwtoa1fQP5MWA1ZO8j5lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789150744;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=6Z8y7K94t96SW0FFKVUumO/UNUAZfuwWJnP9EhJEW2A=;
 b=mSANSpBD3yXQk5XOg9eDmEr0z5FIwRXjInd685oy30HEOoyEFPk6AGf0GPfCzyoYxmSa
 XOseBsuyAP2WSS55fx48ZEM3xOFozV9t9paN28fDrIW6XZEAoqPV+wqc89VnygXb0G0fh
 qnExq6SMBloGQaI4M0Qaj+c+fo2YL3FJBe18/gpbC5PVIvnyn3eCWFoE+1kpBlaoqHKIj
 PChUKzPirzkXVtDuJIhaotcKxI0GfriWnthxM07vrzGL+HMki4XfcdBplSf0oatCftzaS
 0f+28TSkAYmgmfn3Ztf7H5jrmimTaTCCFC5f+X9mr+IWXe4ttI2tuZNFMEz1Ha2gshA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HdMXT7EV; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HdMXT7EV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0549D60617
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CDC56600AA;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81688C2BCB8;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789150741;
 bh=UasbxUjffhQxY7H0NqWCzpDwwfkLu216GvawNMzwsmg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=HdMXT7EV/nvltJKu2L+ZZxGr+KeY+SgDe6PMjHykvXdKhiP6d8+pWzE+yMET2VKE+
 kuPEOGdM43DrpLcBwrMf6gEaNgXaFmxHM2EVZiEXLbbU4cSuq7bvqni7p/QcZ4YYh0
 zwE76vZBEyTihElcMvB0txI2rqIn5RfUGMSQ52cdLJvzdP/Meng3pA+Sa+j0C+djB0
 jeYCAgdWnFPGtT9SyHbGBAjL5PQE3APOzlXRAEgdTTu5rIpDHB6wHveZI+mC0gdU9R
 1VQNdN0Y/FLtJOAsKu9plTnwu7rKo4c7qN4tknXsiM6TbKy9gicpesY68v0UcGx9p8
 p06GSZ+jpBjdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 57A30C88E45;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 0/4] arm: carry and filter previous bootloader's bootargs
Date: Fri, 11 Sep 2026 20:18:46 +0200
Message-Id: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAwAwK9UnrEUCkSUryAGOzHFDAmySwWq+
 ncCjLfcAi6m4nDqFjCZ1bWWhu2mg3SjMgpqboY+9DEMYUDeI5VsVTNyrRPZ6JjI7F1nMdwJc4r
 xeGCK0I6HyVVfv/98+duffJc0fVNY1w+wPiTtgQAAAA==
X-Change-ID: 20260909-b4-android-bootargs-carryover-3ebbc6685ba6
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789150739; l=2075;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=UasbxUjffhQxY7H0NqWCzpDwwfkLu216GvawNMzwsmg=;
 b=aXSZSd2EaeSWO/DbJ/edvsQsgXiRqKfOhMpD5DDY9Y2YUYERXILoHp65cSY7y2RTZ3V2Xf6jy
 hM7lfQZ+EmcCkysM7oiw8Y4ZgLHo+SDJUxred0kq++ejnOeoA0fLuZw
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series supports chainloaded U-Boot on Android devices where the
previous stage bootloader (e.g. Android ABL) hands off a kernel
command line via /chosen/bootargs. Some of those parameters need to
be carried over into U-Boot's own $bootargs, while others such as
skip_initramfs need to be explicitly dropped before the command
line reaches the kernel.

Therefore this series adds a small command-line utility library
and uses it to carry over and filter the inherited bootargs.

Four patches:

  1. common: Add command line parsing utilities
     Parse key=value parameters out of a command-line string.

  2. common: Add command line parameter masking functionality
     Mask or drop individual parameters from a command-line string.

  3. common: Add Android bootloader parameter parsing helper
     Convenience wrapper for the numerous androidboot.* parameters.

  4. arm: carry previous bootloader's bootargs into $bootargs
     Wire the above utilities into the boot path. Copy the previous
     bootloader's /chosen/bootargs into $bootargs. Drop parameters
     that must not survive the handoff (e.g.  skip_initramfs)
     when CONFIG_SAVE_PREV_BL_BOOTARGS is enabled.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (4):
      common: Add command line parsing utilities
      common: Add command line parameter masking functionality
      common: Add Android bootloader parameter parsing helper
      arm: carry previous bootloader's bootargs into $bootargs

 MAINTAINERS                      |   6 +
 arch/arm/lib/save_prev_bl_data.c |  15 +-
 boot/Kconfig                     |   8 +
 include/cmdline_utils.h          |  60 +++++++
 lib/Makefile                     |   1 +
 lib/cmdline_utils.c              | 331 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 420 insertions(+), 1 deletion(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260909-b4-android-bootargs-carryover-3ebbc6685ba6

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


