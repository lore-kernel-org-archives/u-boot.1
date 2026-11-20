Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70C606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T8xCIYv3;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Th9R/BSD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EAA2816FF;
	Fri, 20 Nov 2026 16:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAHN1Ben_2YP; Fri, 20 Nov 2026 16:30:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4141F8167B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192210;
	b=SjPp5HBBWR4/ekhks7uNZZMVg+ZC/xpkk/aSA35aIom20isfUkw8IJ4Hb/ru6pyJCjmJ
	 GbTdsxxCPHixMV23xwFnUytClzia7hWVbIlJxSN7UyW4pTsQAoXXzSrHUxHll6XEhbZS5
	 ARoy9Vcj9GbMj86Tc+69QFTC5v8Z044vafQtThWinyfMTMxd0nY05ysg7lhqZtbQQe86h
	 BHtqqLYAAXJ44EpMCi8BlOJ1gjj7nV70AyDz1FdzB3wRym0/rmIHjCX7b2QMNaCR78PsC
	 eDFw4YlURhmJlupDpIfw/5theD1ZQiB/IP7IUtz7q3/FZf4Qn0K5wvWdARLkaXpsWig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Pg2IaAiBMDBpTsThI3gWhhNFWMeM/Mq0vVgUoSGPuK0=;
	b=NG+Px1DvOhOrOPK67lhiPTUSamilwU5CrXn1iUtu5kkoc/6ljzBaEKvPSCADgXy6yUSV
	 UbyL9wRMVK2isBwLTtZGtn50YwuhvJtPxKWNaDwt5ZcNXcXh1yKxfpGHBK9oyQuv3WZm1
	 SiwE1w7OtJXIwzrLs9U39+xNEwijYVkjQshLL1xBL9it77AJMsELuTtdnvTV6HCGvBVvB
	 SY3ci7PErTpMJ2hCF5rahJSGFqupwTiHxcIuhx0SODfPQajgFvb6PP0OZzLND2j2WYMBY
	 e+baORDfC2tPUk4+DmZYPwknyG6PtBs+/9GdT0rfSYG4fDU1qkOg3fX+QsnayOeuC8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b="Th9R/BSD";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795192210;
	bh=Pg2IaAiBMDBpTsThI3gWhhNFWMeM/Mq0vVgUoSGPuK0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T8xCIYv331n0VH1tPwFJjYV+d68iLJ7zOPlXCDHwTjIS19CD0QHXoTwAdGzNq5Nkp
	 rIwSkDUpJD0oYn6ROBKxukyVlxgT3jW1HY7FI0cAtrL8KXJUnLIwDPBhkR2Fv3YNh9
	 /uhMyhHpAaO5AYDPGSy3z6K4R/U3DUJivZC1wg9FugLC8JyhevzkcWbUVGUM8F2sB/
	 JrQ9h0PcqSuLIC8scq5+V3vbCQGLDYF9dK0WUtFMTWKwE6cVW1c7u+pr6tn5cE50rL
	 IGkEZJzT2MrSXKu1sP89VTjv40pG04dPbwR2raNfyyWJqpsfwUFOCC639hKqBUH4yF
	 YIb9vrqSoaP6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4141F8167B;
	Fri, 20 Nov 2026 16:30:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E42B70B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1054F814C2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UDe_KMh07KXM for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9170A814D6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=Th9R/BSD
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9170A814D6
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jWLQy1CW6zKnDf;
 Fri, 20 Nov 2026 17:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795192202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pg2IaAiBMDBpTsThI3gWhhNFWMeM/Mq0vVgUoSGPuK0=;
 b=Th9R/BSDmk7vEC+FWY9PNH7371oclrZyHmjYSDxTlxYwOjhgk0LnO2OHg04mBxOcIm/vM9
 Mg3ik7DGG+W3QMA7VzfzaZgVo9Job84LfvrFdHbqOnNwClFtrUUDbT7iHqBFBxpWPgOCMD
 jhENRfPNHS+xuqpKX3EmpWsWj5JPbXZ/hVy7pCpEePD3q/Wbv3aQ+wNfhcp1CPQEmoNX0h
 okbT4tRyVE7BuUKNTSJ+PgQ6dCvwQ6xvw/3zClqixrG9OBB9kXjLZixME+LWzSWWDgdY01
 QxLnK6pyi0c3Z1I8IIZHAxDGQ047b+8h9Ut8JbkF6mTwLkVs1SJabAmbb0y4Tg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH v3 0/2] arm: mediatek: run SPL and pre-relocation U-Boot
 with caches
Date: Fri, 20 Nov 2026 17:29:17 +0100
Message-Id: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOwarCMBBFf0WydiSZGtu48j/kLZpxYqPWlkws7
 yH999eqILhxeeByzr0r4RRZ1HZxV4mHKLG7TlAsF4qa+npkiIeJFWrcGI0lSD7ArZecuG6hzZW
 pKpD+AlRTwwIY1liaDdoCnZokfeIQfx+B/c+T5eZPTHm2zosmSu7S3+PBYObdK1bob7HBgAa/t
 k5b8saR2Xmmc9OFsKKuVXNvwLfRaPfViJOxrCj4gp0maz+M4zj+Axxdzl0zAQAA
X-Change-ID: 20261027-std-upstream-mt8188-spl-caches-2f4271625329
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795192198; l=4106;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=xAlQxTAD6WQq4rbgmQL/2lZ6L8OiA9thFYKYyL3uOZA=;
 b=DsPuM+0H9kBvmpI4Z2QFiju5pEiGQnHhUFeVhKZsXdP8nYbjX+Gm8xa84pLl5UYLj6HCOmALW
 AqCj43bMnYADPyTwv5rEMSRmyuH2DV+ZT4NQHHAcxZP0ojR660QMcp1
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jWLQy1CW6zKnDf
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running u-boot without caches is slow, especially if using rsa
signatures. This series turns the caches in u-boot spl and proper on
early.

Measured on an MT8370 module (Beckhoff SM0101, not upstream yet) with TF-A
BL2 as DDR loader and SPL loading a 2.7 MB FIT (BL31, OP-TEE, U-Boot,
SHA-256 hashes) from SPI NOR:

SPL, from its banner and from selecting the FIT to the first BL31
output:

  caches   signature   SPL total              FIT -> BL31
  off      -           848.3 / 848.6 ms       792.3 / 793.1 ms
  on       -           95.7 / 118.8 ms        95.7 / 118.8 ms
  off      RSA-3072    1903.6 / 1903.0 ms     1836.7 / 1837.2 ms
  on       RSA-3072    128.3 / 143.3 ms       128.3 / 143.3 ms

U-Boot proper, from bootstage marks before each initcall:

  initcall          caches off       caches on
  initf_dm          349.8 / 349.7    4.6 / 4.6 ms
  serial_init       204.7 / 204.7    3.0 / 3.0 ms
  dram_init         162.2 / 162.1    2.3 / 2.3 ms
  relocation copy    22.0 / 22.0     0.4 / 0.4 ms
  board_init_f() to main_loop()
                    819 / 819        87 / 87 ms

Autoboot prompt after power-on, which includes a 5 s USB download wait
in the BootROM:

                    unsigned FIT            RSA-3072 signed FIT
  without series    8369 / 8373 ms          9447 / 9437 ms
  patch 1           7634 / 7633 ms          7659 / 7658 ms
  both patches      6901 / 6903 ms          6933 / 6932 ms

The module tests used a v2026.10 based tree with the Genio SPL support
cherry picked.

The early page tables (32K) are at a fixed address, MTK_EARLY_TLB_ADDR,
instead of in a static array. On MT8188 the default is 0x401f8000, the
last 32K of the first 2 MiB of DRAM, as David suggested.

I used an LLM to help write and test the patches.

---
Changes in v3:
- Add MTK_EARLY_CACHES and SPL_MTK_EARLY_CACHES, enabled by default
  only on MT8188
- Use GPL-2.0-only
- Explain the early page table size
- Explain the I-cache handling around cleanup_before_linux()
- Put the early page tables at MTK_EARLY_TLB_ADDR instead of into a
  static array, so we don't increase binary size
- Link to v2: https://patch.msgid.link/20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com

Changes in v2:
- Make it generic for MediaTek ARM64 instead of MT8188 specific
- Put the early page tables into a static allocation
- Enable the I-cache in SPL as well
- Turn the MMU and the caches off with cleanup_before_linux() before
  leaving SPL
- Use if (IS_ENABLED()) instead of #if
- Link to v1: https://patch.msgid.link/20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Chris Chen <chris-qj.chen@mediatek.com>

---
Steffen Dirkwinkel (2):
      arm: mediatek: enable the caches in SPL
      arm: mediatek: run board_init_f() with the caches on

 arch/arm/include/asm/arch-mediatek/misc.h |  3 +++
 arch/arm/mach-mediatek/Kconfig            | 25 +++++++++++++++++++++++++
 arch/arm/mach-mediatek/Makefile           |  1 +
 arch/arm/mach-mediatek/cpu.c              |  6 ++++++
 arch/arm/mach-mediatek/early_caches.c     | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c              | 14 ++++++++++++++
 6 files changed, 80 insertions(+)
---
base-commit: 810d7132c6f03430588ff45dacf62e62f3906598
change-id: 20261027-std-upstream-mt8188-spl-caches-2f4271625329

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

