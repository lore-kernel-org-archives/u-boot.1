Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BDEC282DE
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 01:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A9981335;
	Tue, 11 Mar 2025 02:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="bCRosA1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFEE80F77; Tue, 11 Mar 2025 02:39:03 +0100 (CET)
Received: from mail.per1cycle.org (mail.per1cycle.org [188.245.231.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E39801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 02:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 72C6B40044; Tue, 11 Mar 2025 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1741657139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=brRkq0c+rb9smOca4eiu+BbIkk+puJtnya6YV87doaM=;
 b=bCRosA1Kbh4bvE0WQBtdgw/LQSmpzFV5WjM4U319XUy/0KphrTuTv2hbbPAgUamS1xmF4Z
 tXzsnWfMNmIuDdwE0Lcz5OKSf5kcAlwjb3PWNntnvFVNq0Kxjy5lupOtJVJN8McxOZTbq7
 BVxyVEKaop5EdIiXMdQkLMZnGJi1+L91/h94EwShpW3l89hDH1TxXCnK8qtVKYozINO430
 fU6qtd9BIZQ61PjYT03HTYHNKaOYQX15xe02KEXzBCI2yD066+zU3tiWC73nf13+PLOsZ5
 0DZp04iCIbppnHG9g1NZmOWTvCndfUH2y5lr7/9Vm45qIytYYnrTpypQvIAkiw==
From: Huan Zhou <me@per1cycle.org>
Subject: [PATCH v2 0/4] Add k1 reset driver for bananapi-bpif3 platform.
Date: Tue, 11 Mar 2025 09:38:47 +0800
Message-Id: <20250311-reset-k1-v2-0-8a838752c265@per1cycle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACeUz2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDYwML3aLU4tQS3WxDXXNz4+QUS+M0U2NjcyWg8oKi1LTMCrBR0bG1tQC
 szta1WgAAAA==
X-Change-ID: 20250308-reset-k1-773cd93f5337
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741657131; l=1203;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=lHbqfGBv74tYckkraHD//4Yt6tzH7oqp0a/gQdgdKs0=;
 b=EMcSN8dEv0xAGM3CcMUpJ5bwcKlo3fO8HQsEOT6fn98FWRc6Kq/Qy41oE3S7ptszycj0YCQQC
 LTNSln5NkVkCp9tlTs03gc9ajfACtVU9EQo53wwwMr1rg0+qhSwlCUS
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Add device tree bindings and basic reset controller driver for the
BananaPi F3 board.This initial implementation supports the core reset 
functionality.

Changed in v2:
- fixed checkpatch error/warning.
- Links to v1: https://lore.kernel.org/u-boot/20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org/

Signed-off-by: Huan Zhou <me@per1cycle.org>
---
Huan Zhou (4):
      riscv: dt-binding: k1: Add reset driver binding definition.
      riscv: reset: k1: Add reset driver
      riscv: dts: k1: add reset controller node in device tree
      Add reset config options for k1

 arch/riscv/cpu/k1/Kconfig                     |   1 +
 arch/riscv/dts/k1.dtsi                        |  15 +
 configs/bananapi-f3_defconfig                 |   1 +
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-spacemit-k1.c             | 548 ++++++++++++++++++++++++++
 include/dt-bindings/reset/spacemit-k1-reset.h | 118 ++++++
 7 files changed, 691 insertions(+)
---
base-commit: cf6354ab23bfc3337b1087d243e6be4af48abe84
change-id: 20250308-reset-k1-773cd93f5337

Best regards,
-- 
Huan Zhou <me@per1cycle.org>

