Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D360DC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124F286571;
	Wed, 30 Aug 2023 20:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="12baCjkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8705180770; Wed, 30 Aug 2023 16:04:26 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96A786530
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RbQyX0B5bz9sbC;
 Wed, 30 Aug 2023 16:04:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1693404260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apPxbnd9OUkZxG8OTzHPI3FloW1Y3F5UvegEIOsjAmQ=;
 b=12baCjklnL4cPlRcEs3SzSgMqr9cbbwrE7kJD3c+yL0CdVZRrMpRC1Ou07dWFQvwzNB93H
 HTUWiPAeoL8SigQcB+gLLw0dQnR2VJXr8BZKmb2VrnXMrD1/zhG2IusHmc6Flysf14Sqt3
 9/wG7jwPNrDqmlgB1vtgNdNF52fZhOmTpyL8/IyVEj3iiChA9HTvZtpkR2kloruYcvnvuy
 Wf8tySHKxdoncXrzXf6AvU5q6yTh34Jhexxw+yAj7l2EzIPk9kR0kNWBqA6hjR9pIcUUiJ
 L/FHsT5YVgJOaZpGMWHrWgNyhBfQXyfhH15cnPLxBbw7OAuFhUpITdb16tWhoQ==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 5/5] xilinx: zynqmp: beckhoff cx8200: setup inner cache
 broadcasting
Date: Wed, 30 Aug 2023 16:03:34 +0200
Message-ID: <20230830140349.10801-6-lists@steffen.cc>
In-Reply-To: <20230830140349.10801-1-lists@steffen.cc>
References: <20230830140349.10801-1-lists@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RbQyX0B5bz9sbC
X-Mailman-Approved-At: Wed, 30 Aug 2023 20:15:48 +0200
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

We need it for coherent access between pl and ps.

From xilinx documentation:
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842098/Zynq+UltraScale+MPSoC+Cache+Coherency

Inner Cache Broadcasting

Linux sets up the MMU for cacheable memory to be inner shareable as that supports SMP operation.
As modifying the MMU tables from kernel or userspace is not a straightforwards task, the inner
cache broadcasting feature can be used to allow inner cacheble transactions be broadcasted.
Outside the APU, in the outer domain, the CCI handles coherency across the system.
The brdc_inner bit of the lpd_apu register within the LPD_SLCR module must be written while
the APU is in reset.

The requirement to alter the register while the APU is in reset can be accomplished using the
register initialization feature in the boot image.
.set. 0xFF41A040 = 0x3;

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

---

 board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/regs.init | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/regs.init

diff --git a/board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/regs.init b/board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/regs.init
new file mode 100644
index 0000000000..e7038dd80a
--- /dev/null
+++ b/board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/regs.init
@@ -0,0 +1 @@
+0xFF41A040 0x3
\ No newline at end of file
-- 
2.42.0

