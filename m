Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224B4C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 09:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A72582A33;
	Tue, 15 Apr 2025 11:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DVCKKGP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D8982A39; Tue, 15 Apr 2025 11:12:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2611182A27
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B18483F287
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744708347;
 bh=PBWhW/1mQw0sjT3km/Qm95W+QydioqIOWnW4V1IcXT4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=DVCKKGP8CVc4UIr1s7MsE7XXYzJLAZzVrmWi8DI3AhdHa4V+ilZgFxU9R6HGGXOUR
 US1OEyeczD7gOXw+/cfN8uwKDTVHngNLTCOYJtHdOa2272PsFbbVUHk5tlj38d6bl4
 La5Mbf0lpLf/cyhOBI9DcomNNMI9cjyw9CWqa/dTIj7VszEkQau/bpgf53In98WfBo
 5jvAwaOz0iol8AAeUFgGV9vwfNlGO6Y86EnBO1LW0g5ng5ci7Sl8xf/HDRfEJQqY0b
 sc3m5IoRW//8OP2UvdjM1+NYGLKVDEthFRtAp9succSdXrSamX3hbRBFe/X8cuTC5K
 P78LurdAZSCOw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912539665cso3157632f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 02:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744708347; x=1745313147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBWhW/1mQw0sjT3km/Qm95W+QydioqIOWnW4V1IcXT4=;
 b=K15B2A334wBy8PYI4x0gXKXY/4tnCxS9jxuMUnhuSYkxY5AgezY4PkKlvhwc8K2s/u
 Bez1G/D8ed/E8zT7+u1WfQu/T48KdoVEmYDnlxt2Z5p7nbHWSErsuT1cH9FwMbJBK6Cw
 SILYccfNSIXl4ENOKgqlsiLyo5lML8yvOV86oZW2AHrGMxcC67eY8TjXZSN5ZvP2LdMK
 eyFnl5qSpsAq13pKOjW81PQD2BuOmAZbJL3dL0ILwKtItUsxM3Lkz3ld/VlM70OsJBI+
 tq3HmRmkx3jCs+ZgVKFu8M+TP1DGzQFYLHGbgQ2yJXg/kD0jYtQYAxM1Fy5bS2k4OvzB
 YEUA==
X-Gm-Message-State: AOJu0YziI5pVpxCgM5mfSBZjfXFyJXD6EC9YduYFiv19HMfb19KkR4gB
 0egcUuzYNmWP1kctQJ3XMb+8Qn65c+VmH92d8Lww3qvqgoTEt2OPWXppnjVy+IMYh5t55WwHwwl
 0E5a77n6kxzMtDgcjwEZq7QM5NaYnEWVJmweuqlOBUldJvIQsQZsOrT+0Wxuht3pSs5k=
X-Gm-Gg: ASbGnct1kb6J6bwAwQ2aGuQqimR6elI6Xz1ZiRc7wATjIGkKFEVDHvFypV1NeTIoKm/
 aq/HcKYqhI5GJds8A0ZgBh73JRP5+Jrr9XO/XxsjMU7tCDz/V1S5VNr7kgEZMymQU/uQ/D6FxlA
 ZpGgls5BKUs6KbFWv72QWDo/p1ZMilYykGgEJKsxUUm/YfYvBzHgCEy1uj97voJQAwtrauD5KZb
 KclVcqDwv+sqnG4GufyWx3TSp/hAcZ/tPZXMzeGPfj/J0GS1lkOK2QLWFtz59KSEqUtO7JZRAA5
 Seut1q6cGX472KRuN77h1upK+/tgK/cM3tkavkDtK4lTY+9YEsrXGKARO9bi3nuVhAnsLz5JtM4
 gFoShDDy6VWQnKQ==
X-Received: by 2002:a5d:5f55:0:b0:39c:1efb:f7c4 with SMTP id
 ffacd0b85a97d-39edc32fef0mr1850516f8f.25.1744708347150; 
 Tue, 15 Apr 2025 02:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJZkcW37sxLJmm5zOSZX3hgAecQtOHGvCdqd/fbTBKB/TYolHB3b2wVVZy2EhCd7CsrmrJDg==
X-Received: by 2002:a5d:5f55:0:b0:39c:1efb:f7c4 with SMTP id
 ffacd0b85a97d-39edc32fef0mr1850492f8f.25.1744708346777; 
 Tue, 15 Apr 2025 02:12:26 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae979663sm13962118f8f.51.2025.04.15.02.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 02:12:26 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [u-boot-test-hooks PATCH 1/1] travis-ci: qemu-riscv64_na: add a
 second network interface
Date: Tue, 15 Apr 2025 11:11:59 +0200
Message-ID: <20250415091159.36204-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

U-Boot allows to have multiple network interfaces and switching between
these. This functionality cannot be tested if QEMU only emulates a single
NIC.

Provide a QEMU configuration with multiple network interfaces.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 bin/travis-ci/conf.qemu-riscv64_na | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/travis-ci/conf.qemu-riscv64_na b/bin/travis-ci/conf.qemu-riscv64_na
index e9190cb..97c3469 100644
--- a/bin/travis-ci/conf.qemu-riscv64_na
+++ b/bin/travis-ci/conf.qemu-riscv64_na
@@ -5,7 +5,7 @@
 console_impl=qemu
 qemu_machine="virt"
 qemu_binary="qemu-system-riscv64"
-qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -device virtio-rng-device"
+qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -netdev user,id=net1,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net1 -device virtio-rng-device"
 qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot"
 reset_impl=none
 flash_impl=none
-- 
2.48.1

