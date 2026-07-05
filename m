Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2025C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 01:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B417C83314;
	Sun,  5 Jul 2026 03:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WFDO3smO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43ABE8341A; Sun,  5 Jul 2026 03:51:12 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F2D180398
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 03:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so1007109a12.0
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783216268; x=1783821068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0+/dr+W5711GCfEIXSM8pNVuNfE9ZE/lEqnCh1cF9K0=;
 b=WFDO3smOp2TIi/44eiweSNd351f0DO5tAay+enhyQ2Oe3zKg09f6tccj7WI3FW1x8R
 KgwfKGwRmDxb50I03rf2zUuyFT1huVw3/B2MF0vx/KN9k84M83MkVTFO8SwvATa6tRoZ
 pTB0VKvJC/wD8reyLYbiv2/+6oDL/zuC0/GOgMQU40+xCHb9U2XqoRAi+DNaBg2ll1rw
 UM8RhU2eyZq6kwUMn8G0T74vgnHs+vUJ8S8quqtdgoAcIV+TuCGydKn2r6ZmolB8t2kb
 GYYldUQ4v3gvS+WDyrQXFKxLHXeI2KKzPQlvb/VjrHDpLeldYXobjoi56/+3yhxtXgGC
 dsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783216268; x=1783821068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+/dr+W5711GCfEIXSM8pNVuNfE9ZE/lEqnCh1cF9K0=;
 b=Rdogb60sPrSNudY3ANkQzYhriX0494TdaAzd4frbOSWa8Uz+drFsGXf7/tng9wSJtn
 4oxH56R5YDhNw8Bqc+bH9FDMqfr+FE7Ttt/Dufpfyv4MIidSxsv4nzopSG03a2HGz6lm
 PsjhF5Y3zEczcqElBRxVZyDIPz01POgNyXbft8fAaQqvT1UMHc3K76c6hsbvKrbTQ0jM
 rSKnvf9qQLj91GH10D4/f4COsx/tokSBbw8iR8XAs5S6Ddcys747vv/zCVAygQ3zACNB
 pd70/lgXyvQgoxHlYuNaA2P2K86RRECMAJhin2UvwVc/V2f5hPVvovdbSo/R9VPkg6n4
 sCcw==
X-Gm-Message-State: AOJu0YwuoWEquSAbeVaWeb76guTie52iBsKfqsE050IrY18jemlBOeF3
 CWOuD6pxxDYTlqWjiK27OJU5QKFaKLvFBr4g/YCC3hSMqrAHH6k0RnP6
X-Gm-Gg: AfdE7cm5BEzA7w9rlrSEJNCKC+SafwZXptqE1AErwOIbMgYO7lLqn+soHmQwH7jxdFi
 qMpv5V1Ct0nXbxg85KTbSofxUFF0Q6AnhR+zCIkK73zC8nY8RyeHDepB7yWmNLpWsJAS6allYPQ
 MMtqHjwywuF7S2WMG3FTdSTAndOa9yx5ou+PjwRSkLhqXWekFjUqbnoB6ff1uRF6oNvXZvWccIf
 i2zXaebkRlVcBhdX8CSdaHCFY6+jx4LDPnZM2JET7zqgUHHL9ENLpraA9DkD0SRcwJD0Bh+hugI
 /LN6auqXwUq+4uyOY9CWu9vYnXkdIJcTlsFdRgk53uti7RbX7ar22RgGS2UGwZ72FuulOEghPFm
 Fip3wknJ0sbmvYnAIF3aAsdDIoHrE3htYF25g51tEHntBGwrAz0oxFRZMgrFqBqqQ3frxPGMe0L
 FPcPRZBPROGjbvQ0LbfQgi+Gj16Vb4JC6N4GmBpyenpn6taKY07s0/zSXPvg==
X-Received: by 2002:a05:6a21:2291:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3c01cc42d1dmr9135619637.39.1783216268397; 
 Sat, 04 Jul 2026 18:51:08 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:f691:72d3:8b64:121])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f31e7a2a8sm21864241eec.25.2026.07.04.18.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 18:51:07 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH v2] arm: mvebu: Update docs for Allied Telesis x220
Date: Sun,  5 Jul 2026 13:50:54 +1200
Message-ID: <20260705015054.2534191-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The current documentation doesn't work as-is for extracting the DDR
training binary from the vendor bootloader. There are some seemingly
undocumented alignment requirements that we need to meet by padding the
binary file. Add some instructions on how to do this with objcopy. Also
fix a minor spelling mistake while we're here.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

Notes:
    Changes in v2:
    - Remove binary file accidentally included in v1

 doc/board/alliedtelesis/x220.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/board/alliedtelesis/x220.rst b/doc/board/alliedtelesis/x220.rst
index 6ca5f61ec4e1..447867ac7d8a 100644
--- a/doc/board/alliedtelesis/x220.rst
+++ b/doc/board/alliedtelesis/x220.rst
@@ -18,7 +18,7 @@ markets.
 - GS980M/52
 - x230-52
 
-DDR Traning (binhdr)
+DDR Training (binhdr)
 --------------------
 
 The AlleyCat3 uses a binary blob for it's DDR training. This is launched by
@@ -37,3 +37,5 @@ image
 .. prompt:: bash $
 
    ./tools/dumpimage -T kwbimage -p 1 -o board/alliedtelesis/x220/binary.0 u-boot.kwb
+   arm-softfloat-linux-gnueabi-objcopy -I binary -O binary --pad-to=0x12fcc \
+      board/alliedtelesis/x220/binary.0 board/alliedtelesis/x220/binary.0
-- 
2.54.0

