Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84F6C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB88D864F8;
	Wed, 23 Aug 2023 23:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NCvCXf80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1BC864CD; Wed, 23 Aug 2023 23:11:27 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69EC4864CD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34bb6d58f84so17805325ab.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825084; x=1693429884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGwqyL9FF5JM4bRMsWunI4SwPZKP5b/39vtqyOveCzM=;
 b=NCvCXf80WdPAkOxV3Q3ySUgZoWi4yK4Cwmh4OKKHNSndjImXeamW4nz/V6k2p2iFQt
 9lCQh1vRw47VEZWb1tV1fz6CHRdvNUGyCi0TRF5YCFksiwaXGflq6zLPdVU8sJu4eLQ3
 SbL2kbmxbWB/ksDkwGzrdk0xix4ENdCoV3/BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825084; x=1693429884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGwqyL9FF5JM4bRMsWunI4SwPZKP5b/39vtqyOveCzM=;
 b=VA4r9BeKUwW9awM1TFSrxU2Phyx56c0bwMIa06/FtmiiOd7cPxHdHHQbS9yJ3iI2mi
 qAWHSM26fFIJHQRpcqpv0BC3/lR+PHF/3/swQA8FJ7BbNG3qiwubM2fcsDoIr9lrQ9Ke
 bfxg+hrJPCH8sKBTdStLtC/ImaNeg/n4VdJqotk/pIoQgmjquiizqxAHuRLfoL9K0Qkm
 y/GjkrL86POFKVb98NgTqUdVoxHQauUfv0sWHGWrBJVZqRkY1OTUCyoB+Exy86D5PJ1H
 vI2x+ab3NTknLQ3sGq8vuTX+41wzEZZlLko+tiwyhMU3qWJo7DafAFr0VqciQJYePFy0
 Tv6w==
X-Gm-Message-State: AOJu0Yw3USISVg0rOI3WVFQIrvfD+w5rwqzG0ywD+pr1qK2urp1hURV9
 c9G8JdTS3nTKP2WMHyT3aKNh8CwsXmEMbfaKQIg=
X-Google-Smtp-Source: AGHT+IEA0m8RFTKKqDhtoAfwQEOBeUlwNpVDT+e54c5adiLdviN3/DWelQ9LuiRTiyzJUpB/YHszPQ==
X-Received: by 2002:a05:6e02:1d9e:b0:349:48eb:4e2f with SMTP id
 h30-20020a056e021d9e00b0034948eb4e2fmr4096305ila.22.1692825084096; 
 Wed, 23 Aug 2023 14:11:24 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 20/20] x86: doc: coreboot: Mention 64-bit Linux distros
Date: Wed, 23 Aug 2023 15:10:37 -0600
Message-ID: <20230823211059.1235147-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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

Add a little more detail as to why coreboot64 is preferred for booting
Linux distros.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch

 doc/board/coreboot/coreboot.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index 88437c27740..a32c3a864f9 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -82,6 +82,8 @@ build in `$CBDIR`::
       -device ahci,id=ahci \
       -device ide-hd,drive=disk,bus=ahci.0 \
 
+This allows booting and installing various distros, many of which are
+64-bit-only, so cannot work with the 32-bit 'coreboot' build.
 
 CBFS access
 -----------
-- 
2.42.0.rc1.204.g551eb34607-goog

