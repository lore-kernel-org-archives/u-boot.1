Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5E4C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 00:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B24D83108;
	Wed, 16 Jul 2025 02:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LKIglrj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FEA83145; Wed, 16 Jul 2025 02:15:49 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44ECA83106
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 02:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73e5e3c6a37so598881a34.0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752624943; x=1753229743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r81QA4v5nsFihllzCTZsm6+qdJ+GeWy1WzorEyb3BJ8=;
 b=LKIglrj8VLFek7lLNxhZBlVHuJtq6UhiGpmSbVBDuz75uS2V+KSuWcUSCSzbV/p5i5
 o7lSnm2x+NrdTm2S8wKw4VnPibTsq1rEf4YEs4QZ1YdTiik+Fwmp1CMk7DpFPYvSqIot
 OlwAbhPHLp1oaAFj7sPJrPjrYjJqVarqfwHqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752624943; x=1753229743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r81QA4v5nsFihllzCTZsm6+qdJ+GeWy1WzorEyb3BJ8=;
 b=KDa5+Jfcsu8QESispOlai/oSevKFiZg+hZDUWa2VZVjbSKkcThB8CmsDOb7+VbaOZO
 EwEZ/68ISz2LPvceKIi2lcP8KpouR/cJFIcHzpTzu07J/DPINvt88kT+vS320f8E/Xry
 gLbGUmbMCdn448BjKg1v/R7g39Aemf9P2qTW4RfLPZG7OJ15tPp566N8Alxw55AqQoKG
 qkcLiIsxQhxc5TONJiuqftucyANIReazApiovPgyXvf+3xi3pwGmCnX2vpG2b3I4fwSC
 kklw0+frk5ztkNZ9KJe11FsGvba8g06MSTxidY6gGk9XCIdxsNzlWVrkeSsIX+v9oeiu
 2Eeg==
X-Gm-Message-State: AOJu0YzQ2j8YcXEHIVv5SFy1xDDIdfs+OcNj95sqkoeLxmydFD1QQSoE
 rL5b292ZUaF3wkEo7cX576cNAAxSgWNf2lhPdZARtS1p+vxX7X62CoDzwpHTXSqTloOc8iKJa9m
 tDuyktRg=
X-Gm-Gg: ASbGncuGQUR/OkWYEu3SWLvbkOw336BwH7MohzIt0uIwWkyYSRPk/yf1rZQXms0SFk5
 QN4OP/6ftkF2Gq41QaorblDWO8mg8R2kZkokdckny16FzK/m/TJSb5blXBhedZMjE0PWzs9FqOO
 TTrAuS0951yaYHk+qycMZN7f8ww4jrJTzMdnrcREBgsf1PtCAd5qQZl2KNVhcCL1gUV4h8r+Hga
 nvLP/XTzW/kU26F04mxRGFDUGfgb4wq0o/0DB7yJNurBLUYpiaWcaR6NQFX4MByyHL4OdWcFlK3
 w3ekHRH9TmaHTf8+XXE9rL2bZihqYTnJ7oZt7R5p9JxBaJr2f5FWj0pCRyGp2cRoDQexQV8lXzh
 cHwhDc2FrPrAV7/0KpNc4BaEdDzQPbpwmEec3r0itb99HnH24RmLPcWnN2vA=
X-Google-Smtp-Source: AGHT+IGnov/vInZndxucE6Rya80Xhn3KoeHThnfh5UHoezl6LOikjo2ZbyQwA3nedxo61q+QHYmMXA==
X-Received: by 2002:a05:6830:8104:b0:72b:a712:4b72 with SMTP id
 46e09a7af769-73e6613b72dmr389486a34.9.1752624942864; 
 Tue, 15 Jul 2025 17:15:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10adfa9sm2543607a34.30.2025.07.15.17.15.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 17:15:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] Dockerfile: Update to QEMU 10.0.2
Date: Tue, 15 Jul 2025 18:15:38 -0600
Message-ID: <20250716001539.2483390-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716001539.2483390-1-trini@konsulko.com>
References: <20250716001539.2483390-1-trini@konsulko.com>
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

As QEMU 10.0.2 is the current release, update to that so that we can
update other features within CI.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index ceb7a25ad4d7..02821417ca0c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -125,6 +125,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python3-dev \
 	python3-pip \
 	python3-sphinx \
+	python3-tomli \
 	python3-venv \
 	rpm2cpio \
 	sbsigntool \
@@ -218,13 +219,10 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v8.2.0 && \
+	git checkout v10.0.2 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-	git format-patch 0c7ffc977195~..0c7ffc977195 && \
-	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
-	git cherry-pick d3c79c3974 && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
-- 
2.43.0

