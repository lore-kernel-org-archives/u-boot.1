Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D964606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O53JuN1W;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=eC9cv+UJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67FF780E50;
	Fri, 30 Oct 2026 09:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RMUmiSKWxc48; Fri, 30 Oct 2026 09:03:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 10EBC80E01
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793351031;
	b=KdnDwVWZDIOVDB2tf1T/mjk+YpNQnQRANnecUeYw5Vlhxx8Yved6bhxhrstq3dZyvSXV
	 itLwJQVBCr3V5IZ2a9r2U1lzS8tAD+1UducPR+9QMrALUpMoDinAT8GD2S0Oo4z/KO8uI
	 wANeglxUoOQNSZdr+YWiK4Mrol3vkyr5oSAbdzFzIF8KTHGGv6pvXX8DwR0Yn8iY+lTsM
	 3sS2lLog1wUondGl4y3pebgIC0FHBOJ4F5kfl5DuHNdntho88YQSUI911g/wDiobt6n3y
	 xtUgsS+qGZzXWgdW5ATw3MdtIupXjEb2gB7zZ4ZgB4Py7apz720IPe6lQicL9CSDZpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793351031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zJCqWS4x2ATg2DCmWiPf3NDAem5UnpHkuUfRm2syi+E=;
	b=NLRCFCYmL9bV/7kjl0TBK0xy6pqWoTo87Ex56xwq8jLG57ZCrNbGrYZ5lPZeQ3S7nbI+
	 mjaPuSNpFLPRzg0jgfUhkaTG51jVsWgZ5Nzk6Ckk9z88RFP78Zqf8mjNNrrnHyh4LyPxX
	 TIs5Rvp+UK3/VbHnp+a8z15zGZOtTJggBR8GqqQlsoTQSsReJbiFkojzuHQ7J0GeD7qgK
	 idcDxdACva/l+UG9Klp5u5CQXvNmEE2o20QrClOoTjE7VXD2uRQ+zi+yjG70uIpPUC9MZ
	 9lp+rFPLQnEyOmafBzHF18C93Aju7xGB9iKgN4/HD+85ZGH4cxOGwLLsaXk5BZSFDvg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793351031;
	bh=zJCqWS4x2ATg2DCmWiPf3NDAem5UnpHkuUfRm2syi+E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O53JuN1W12BUN0GeHyjChJYbWMGg9AkYezKaFHuLrLEsTfO4YmTS4k5wJm9VF96lw
	 XquzGceF0GWY2yNuYymFynoep5BBQpvNmHYMymWZkO06jD8++fKoBlFKAnKhLin63N
	 VVp51B80oFGapSJ5AXCw/UjVoClMpGVgaTcnIGAqFkLXpy3Zx2Mrksn4buRa5WD6QR
	 gGxva4aqWO3p2TeWBc6s6OS1Qwpi0v9BUqBgEzQAV192Uj0yBOkdfr3LCr4xOZNtiE
	 ohXt/lu9aRnxRMQmdjGfLkr3ZvjDpVevQTtAzn7ZSPkjyHuTs3grQOTpV1hJ/dg77U
	 Pqi16vVYo6m+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10EBC80E01;
	Fri, 30 Oct 2026 09:03:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0FFF1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86AEE4016D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgD-ZpXLAI8n for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 315944010C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793351028;
 b=N5C7pmfUgmHwKSDN8T4B18+Gvx1/yfm66PjkHVLufAKhXMr8qoC4zg6sOHOyoo5ClofI
 XWQDfIm3zy8hO3g+g8boZa+3Ele98UkOntPZzZrZ0zgBbToGpHrgWoVk3pKfM1m6Srd+U
 9pUxVAzWpFF+hs8YWnwGiCiVdv38MabEI5MHGf1MyLH0KowxO0ZXuGiZJqRN4a+ISanVG
 vftAvQOZeZ6aAiuy78Rq9rwWfSCMO9z1A6oQpL2NwoS6NzA1AA57KMxqwOXxRma8GWX5v
 70yjsDDTs1tnC5qjOWRUHwAxxLs3QFzC74+8qijCWOlx4uBtge6dJYao6fP2s9bq8Ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793351028;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Rspamd-Queue-Id;
 bh=zJCqWS4x2ATg2DCmWiPf3NDAem5UnpHkuUfRm2syi+E=;
 b=DyKXPvRLOArESxY9jQr1lgJaL+M3rKTuRF6fFF9jeoF6/SnACDEGDydq1gKV1OMQxFdQ
 Ma1vo6G+xkK5hsNWSmnwerAmr4EmHdEbvMR9U7/hxqd32tQHtB8zadylAnU31s9jCBjiA
 JDnJrmmZ6L9t4aRoVi6pv1k2I+CuZHPUyStSAOV36s1vJxrSLWtYUCnsEwpdEXas2HM11
 9tzF93LBK8tCrTSOK5COIToM/eYfNmTLfYCdzNYuIozh6CsxS+a0iJ0WzPHvBEVtKzmW1
 mw1k6hr7/64Ayuj8D3xVhLZTYZ9o28H5UbDQ2g6x2PYoL5Jm9Hu3ZDIKg7+uSOSrbHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=eC9cv+UJ; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
X-Greylist: delayed 328 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 30 Oct 2026 09:03:48 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=eC9cv+UJ
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 315944010C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:03:47 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jGFPJ4f8XzMlrv;
 Fri, 30 Oct 2026 09:58:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793350692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zJCqWS4x2ATg2DCmWiPf3NDAem5UnpHkuUfRm2syi+E=;
 b=eC9cv+UJC9L6SGg9IQrVvkKABYilok0xijeML1zP2WkwMlqac7bZh8uqm4QY5/HL8M3/NH
 0lHZxsOISiHus4MWgsPpjAgAcxL4G0fZnbilYyo55XsBrg7Dg3nCoAingH16w4BPXqyPsO
 91eNtT2gsZZf9uFbNuCUImg7iD9MAMTm6domKqdKSgWuhS4viNhfuOCrRX8TD6hQozTWPE
 +12OOMjVO5BWRnvxBsma6sz8SeH6obj+m8Mttn4vcsfvkWnzXxrCcz8jaGeEh3Z4VjgkoZ
 BMFkGp/hNqyTRAaqS2iV6fwL2KKy9Q9jo5jl1jfZUMRb9Wlk6AR8B+/mGWn2SQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH 0/2] arm: mediatek: mt8188: run SPL and pre-relocation
 U-Boot with caches
Date: Fri, 30 Oct 2026 09:57:40 +0100
Message-Id: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBA0auQWTsJHRWqVyEuahlkCGDTaY0J4
 e5WXb7N/xsoR2GFa7VB5JeoPNcCc6jAj259MEpfDFRTY2pqUVOPOWiK7BZckjXWooYZvfMjK9J
 wotY0dD7SBUokRB7k/Rt0t7813yf26VuFff8ADaN854IAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793350690; l=2285;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=EE1bM2dgeIU0QVHtb/l6nDwI8vuoZL+JyJBHMVM7FkU=;
 b=9U9spKqyPj5LGR3cTB+vbyQWrpqyLRT1gQYTX94RKCjKtPDeYTlqYJzkziax3LsgL2m12zGuZ
 22BbxEeRi0gBgAFHGhsbkz6vJrbJwlX3ZsmBCmfFmHHptkg2Odb/ad8
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jGFPJ4f8XzMlrv
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
  off      -           864.0 / 864.3 ms       808.1 / 808.3 ms
  on       -           95.8 / 95.8 ms         95.8 / 95.8 ms
  off      RSA-3072    1903.3 / 1903.8 ms     1836.7 / 1836.8 ms
  on       RSA-3072    142.0 / 142.0 ms       142.0 / 142.0 ms

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
  without series    8412 / 8411 ms          9436 / 9437 ms
  patch 1           7650 / 7651 ms          7660 / 7657 ms
  both patches      6902 / 6906 / 6894 ms   6928 / 6924 ms

The module tests used a v2026.10 based tree with the Genio SPL support
cherry picked.
On v2027.01-rc1 the Genio 510 and 700 EVK configurations build with both
patches, but I didn't test on the evk.

I used an LLM to help write and test the patches.

---
Steffen Dirkwinkel (2):
      arm: mediatek: mt8188: enable the caches in SPL
      arm: mediatek: mt8188: run board_init_f() with the caches on

 arch/arm/mach-mediatek/cpu.c         | 14 ++++++++++++++
 arch/arm/mach-mediatek/mt8188/init.c | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c         |  7 +++++++
 3 files changed, 52 insertions(+)
---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20261027-std-upstream-mt8188-spl-caches-2f4271625329

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

