Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86C606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zfFhPuDG;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=fGhcNfv/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB20860703;
	Mon,  9 Nov 2026 15:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qLilBc064YUd; Mon,  9 Nov 2026 15:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B2371607C9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794237284;
	b=hlWU30oHlSyp2o6q1KwiVokgE7VQrKsQJig7ervbgLGI0ZbFeo589SMVSMIpIqi8Vzse
	 G5Nx15YbI5IITOaOBXm+JvONUWTqj9cCkbAlSQSQs1C2aMXWvbzSEa2JPKLo3oFu8vM+d
	 gC0qq9T7SgHEgl04m8afaVW2XDnQlxQML08s6kD6qNXu3oC2zYfSTYzKRt53bFGzwic/G
	 cs/i6XYGhEHPYK8x8nfBElGerpR1IVEa5cFX55akaktcN7voNJvaugWsy+tIQPl8XoqiI
	 bCkUgpBCJO0ESBy1Y8jUjXx+mPpYcDaOARKgt+bPRVdER7XVFUPqKuubc0u8mTZOOxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794237284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TqDURY3OXxJ0Vz+89kfu5UPM6Yc2WobvdyP8cIZKQrk=;
	b=RZabirbNBgPybeYv2/6N0wCYb1fTkc6OeZ3FrzuYMoG3139kGehJumYXa91rOzUV4eUU
	 BrBZK5oxvWnkUViDbm4hGJWT/rXEnuDsmr7SS4VzchUmYATSUyx8CLSdOj+qPKN/BmYZj
	 GaLHZCFYr73pRI5GK176fYXI/LdfRRAUXMC91SdNwcwgdEeet1h9Odbx//OE0EmmjCRHu
	 tuEAVUj7Xy28LvkwLHpuLJzqWOeEDrg0ZgG3NLCjFHLDtkyCM7xNbaQ2rMrT4yXM8N8ep
	 L4kLznxc42zIgu18biXJdlwDs/5fuWcvfaR7F/3Yr/XZXADM7LuDIV8jQQuWiVNiGNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794237284;
	bh=TqDURY3OXxJ0Vz+89kfu5UPM6Yc2WobvdyP8cIZKQrk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zfFhPuDGmqnGt+/ULJ06wCs5r7fbJdjszuXq/3acxpsbXevsLT5ExGBquB6+wj3qn
	 ZCGgjEMaF8TlBhW33MazB2b8JFVPrahOCYsar/kMvZF5OsL/i6rQJ2Sq/J/kuFvS+F
	 QSpp66i8Kqd0jT/pTpsT9B1hohCQrannfOzkpgoXDcCWZkPMDbBL+RErvVd13ZyOnR
	 6naYTrf58uXMwhrQ38TtlPaNbvrrbLdiSS4w2pzFetRZSLWMdmGbCIW3XsuEHxO4gA
	 A0QYxLwVM0gpxH7vwrh1hzd4MFZ4Ho2WgpC8TS5vHgirOOe0rmP0Xdl1WPdJ80FB0I
	 ytn5C+nM2JIGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2371607C9;
	Mon,  9 Nov 2026 15:14:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFF344B8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5BE640782
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4F6zw2JZc8U for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0319A40769
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=fGhcNfv/
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0319A40769
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:14:41 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jNYH1306BzMlNF;
 Mon, 09 Nov 2026 16:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1794237277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TqDURY3OXxJ0Vz+89kfu5UPM6Yc2WobvdyP8cIZKQrk=;
 b=fGhcNfv/QnnBsf/2u7kEHUnIa3ZjEXAeXdYiXxnqjlaOEhOEojmqvFnLx7IkOpPVnQLCBo
 HgIqPf34h2mkNcbMmsMKDqdYY2yUBjw7UQ/LE02dER25rl5udN57weR6vzFoUeoBhhZobD
 luYfnXrfv18TSP9HA9ousdM13F6NHsQ0nPqVLpqXHBhKI5UMa3T58WBqy0h1kaJZxev9Tj
 7tpXbXWt0zdo5yMezu4V1+nFiwWwte5TznRx9B5r+HTJERoCEZn+PRYHzVadAEDr9M907B
 YT/UkWEzr2cScw2bOPKKehh7jPkwGraAO6hOX+meTxUALcgAk2On2u8EFzKl9Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH v2 0/2] arm: mediatek: run SPL and pre-relocation U-Boot
 with caches
Date: Mon, 09 Nov 2026 16:13:07 +0100
Message-Id: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBBFf8V07Zi2vF35H4YFLVNbFUo6hWgI/
 y6ge5cnObnnzowwOCR2Psws4OTI+X4FeTwwbZv+huDalZnkMhdcFkCxhXGgGLDpoIulKEug4Qm
 60RYJpEllIXKZJbJi68gQ0LjXHrjWX6ZR3VHHbXUzrKPow3t/MInN+8US/i82CeCg0qzimVai0
 uKiUD+sN+akfcfqZVk+EP4A6eEAAAA=
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
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794237275; l=3406;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=H4+SzRZ5xBZLUM5gyy1NGVoiJtTRyxZP+SaUylgg23k=;
 b=bE6IqjBFo1wXA7LmOLSDQ0IBr6C1ThGkC2szwMa5U8riQD6L5OLb79sMwWAu6NX0eMwwYFNFk
 MzIVji6KDtgAJFrerhwjl0kgIZ4wVppi8+WurGhhkZu+6tH/AGa/6gJ
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jNYH1306BzMlNF
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
On v2027.01-rc1 all MediaTek ARM64 defconfigs build with both patches,
but I only tested on the MT8370 module.

I used an LLM to help write and test the patches.

---
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
Cc: Chris Chen <chris-qj.chen@mediatek.com>
Cc: Carlo Caione <ccaione@baylibre.com>

---
Steffen Dirkwinkel (2):
      arm: mediatek: enable the caches in SPL
      arm: mediatek: run board_init_f() with the caches on

 arch/arm/include/asm/arch-mediatek/misc.h |  3 +++
 arch/arm/mach-mediatek/Makefile           |  3 +++
 arch/arm/mach-mediatek/cpu.c              |  6 ++++++
 arch/arm/mach-mediatek/early_caches.c     | 33 +++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c              | 14 +++++++++++++
 5 files changed, 59 insertions(+)
---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20261027-std-upstream-mt8188-spl-caches-2f4271625329

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

