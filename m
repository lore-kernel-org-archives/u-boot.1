Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC281606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P/HIn2RC;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=j/uflWUF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94640405F4;
	Mon, 23 Nov 2026 01:16:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kcS3eOHWFuW; Mon, 23 Nov 2026 01:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4EF9405AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795396561;
	b=kCmMhHMt/km5xfjQLzyEAXh+13GWrHjtfQB0lPk68Lal53APdrYjl6qLBOUEqAPqO6ww
	 gtB3nBHy82ZgIoiLo52xHtAmsbHlD26LDxUDpMenZTqf16BxbRJ50fhIuBw5S6xQkAT1M
	 if+gq/H0hxBCZB0FJNTOrUXUeQvlChY0nu4XwxOEH+kkTN+7V1R4Q7XXKRZCJMCkC/OMg
	 rh4cm870P2mGmuoBTtKB0KV6ASEDOU8RSfRQr+pUbNIx4L9WuWv49blQ3HDonLKexHGNl
	 cmytqvT7NdqET2BqET7lPUuX1AfYoko0Hn4Rg80w9dkfQoVytE5mSZ4xVkrVS8vlMFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795396561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WkbteLaz5AkZYE5rWlkLsnJtoGTPuZQfXqAUSmFnezM=;
	b=We4J0lfk/XE3PXhrdMi+E+T3EHRXms/cX//7vg+k/3cANKcj9ecfpSPeT8uJQAG5iRS0
	 /W9GbTKyFZ7xI67Gv6crFpIbzEZ7xdE7GMYdUMtnAcjpZxD4/y5DcUkZPxz8a+3GQxxpc
	 RpMkpvTbZl9FvSBRs7xhYSLmpNOQnd3q/Kb+9+lF0UDI78IsCrluSOvJVERPFFEJuHKEe
	 pYi+7jd8pW8hH9SQgZJVp/hKNWtT7VnfjdW0Yk8XmxL9Z1NwCgUoU5oEEVKl5c0bVx15l
	 SDS5+DTDvxbDgeJLVcS4cQFR5YpsIuOpaY+aN5vq1t5RJE5ILmQ1KJOx6S9gmCC5pog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	spf=fail smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b="j/uflWUF";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795396561;
	bh=WkbteLaz5AkZYE5rWlkLsnJtoGTPuZQfXqAUSmFnezM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P/HIn2RCSliXiAMV4AJMOl3cpanIO62LlIFNst1yh2LM8mBQovfX4Kw7UgE/FpmoW
	 Qc5JeOKKRNh88sUS+Kz9M2oCOPMJ0FxoMnetKzGkD+LF8tiqcktKsjbvh0YzWvrVtX
	 s8HdJjeYGlgIbBuJTNyhbCaWMC2kF5WTK9ZpXIGgaQgcCMJ7C5JvZSB8BX2pMM8VCE
	 ztZwAfWfvkE3EnT6889RkONNkmmi9xNO/x3v+iYpe1zZk9gM5ao0LyLUHrI3XxuXmf
	 Mo4qjiiHsBu570X7OQyzfww2W42bU5K4SkGZVkghs/OWhURM4SqxWputGq0fOmeKXF
	 lU+oGZNQSi9xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4EF9405AE;
	Mon, 23 Nov 2026 01:16:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2A14260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D81F6405BF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nm03Z4itjE6t for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 01:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5791C405AC
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=d-silva.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256
 header.s=2025a header.b=j/uflWUF
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5791C405AC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:15:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F4B844F6; Mon, 23 Nov 2026 02:15:54 +0100 (CET)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9973841F2
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 02:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=d-silva.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alastair@d-silva.org
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 754084028E;
 Mon, 23 Nov 2026 12:15:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795396534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WkbteLaz5AkZYE5rWlkLsnJtoGTPuZQfXqAUSmFnezM=;
 b=j/uflWUFe5QCilunt1xK/yZMGG1Lv7YfmQnZau7feyPZN3450iAEFKOnWL5PsPVr13kGY8
 3tzkVNt/3kEinAJi77HCGSwXVz7skDqCuIQtoCkmXCw8mdMoSDnS4bfkKve0/Gykgv18lt
 sNaoQxFhuo3l9FU30cluV+Z70rYXZuICokzfRr9u2vL5SBpcaaW4RNboMEA8Ubt+pB60SF
 V9xyhdgt3eF8WTaxY/2M8AIjAqGi2XkDB+++Q3vNfBHiK57c3GB+PcfFXdDy6TkW/pPFCh
 6LULL5LP/NZBytUrMePfD4gX6grUGQKI9i2vIe5YzvwnM20jPqQkj0IgPgaWmA==
X-GPT-Reason: legitimate_personal_or_technical_communication; the
 email content is a technical patch description for a Linux kernel
 driver (AXP318W PMIC) which is consistent with a developer workflow;
 the sender (alastair@d-silva.org) matches a known personal/business
 mailbox (alastair@d-silva.org) provided in the context; there are
 no phishing indicators, no links, no urgency, and the content is
 highly specific and technical rather than a broad marketing or
 scam message.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 0/3] power: axp: Fix AXP318W bugs and extend SPL support
Date: Mon, 23 Nov 2026 12:15:31 +1100
Message-ID: <20261123011534.1692975-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes two bugs in the AXP318W PMIC/regulator drivers and
extends SPL power support (needed by the Orange Pi 4 Pro):

1. Fix the ELDO1-ELDO6 voltage mask (0x1f -> 0x3f) so voltages above
   1275 mV read back and clear correctly.
2. Use register 0x55 instead of 0x32 for AXP318W sysreset poweroff.
3. Add AXP318W DCDC6/7 and ALDO/BLDO/DLDO/ELDO support in SPL, with
   read-modify-write updates and -1 OTP-default skip semantics.

Alastair D'Silva (3):
  power: regulator: axp: Fix AXP318W ELDO voltage mask
  power: pmic: axp: Fix AXP318W sysreset shutdown register
  power: axp: Extend AXP318W SPL support with DCDC6/7 and LDOs

 board/sunxi/board.c                     |  23 ++++-
 drivers/power/Kconfig                   | 110 ++++++++++++++++++----
 drivers/power/axp_spl.c                 | 119 ++++++++++++++++++++++--
 drivers/power/pmic/axp.c                |   4 +-
 drivers/power/regulator/axp_regulator.c |  12 +--
 include/axp_pmic.h                      |   5 +
 6 files changed, 240 insertions(+), 33 deletions(-)

-- 
2.53.0

