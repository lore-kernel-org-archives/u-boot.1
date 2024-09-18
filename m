Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD42CDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F420388FCF;
	Wed, 18 Sep 2024 17:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Jcj2l9Pk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DC288FBE; Wed, 18 Sep 2024 17:23:03 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E538F88DBA
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c42bda005eso5650764a12.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672981; x=1727277781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tE3gGM8Mbt2P9fn0Xds2zmj9qx168rJGAMqKfFc4sfg=;
 b=Jcj2l9Pkfbj1YSu9nM4LrggSRukJ+RcCwinczygJ88csEC61Y3dVGZD9wyVttlnQF7
 4QP48r2a9bpknnVmDVdhqfzK1OyLlthmhfEzNUHKd0Zs5mNilStaGpIl5Dh0bOIu5kJy
 yBI63ce5UDSHOlHpODmu231lYOJv85rmxxbTEcUsoCOR66Necp9XbWxsgqHIhwUrke1C
 5OocmMgdQeYj2bO1axad/71MER8R05YRlrOZIIKoPAyQlqZzpsWLO6jZucxzvQiUnTpy
 Qb9UavoZ8E4Nn0R4Gc2XnRaJ0w+bynyowoM2q6RpYGR3nv7Hx4ZDwcLHRs+by0oR8POn
 Fodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672981; x=1727277781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tE3gGM8Mbt2P9fn0Xds2zmj9qx168rJGAMqKfFc4sfg=;
 b=G3pY7IBkDaBU+KtzBrTxbeCNiyFgnMDiwtsTMnAMZSYV/u4Ty3KPqfv+azHc78X/hA
 j+HMNOzNQO/qBJ4S7ITFLokPk7Ml6OKOWpMvDthC1trWp08L7XCt4t575fs9z5k5VCSE
 rOrxCpklvQMKD2z821lmbKxcmwqD+FUsrtG3y1tDxp8kp76WHxYnYtG9M5EsyzFP9+jq
 GPkXTmXBDhDhnirvywr25Ehk8yhqGZn0rh9nsLo8szH7NNK5kp+qskVTrovJghlUy899
 qvOisQgmBxHWhMLr/8z6nPQdMB40Y+w/xuZX16a9NgLLRx0h8AoXyrzZcTrYdweITIih
 0ccw==
X-Gm-Message-State: AOJu0Yy8tJWvq9afxzjMFryM1/gU7nNv0g5Q/HjDizHMo//N9f5uvnjy
 QSnJGh7rCHCceX7IfLTGOffyB9gjC14pOdrWV/ESxwkcO9IgFUf2o6/FJpM8SPgy9ravnUpi3TJ
 8
X-Google-Smtp-Source: AGHT+IFZB6sAh/kAQGwAowejA1xcEpL25R+X2uEkScWFnRNv+StVwWIATE1PFF0+dki0vHr4NbKQ4Q==
X-Received: by 2002:a17:907:e283:b0:a8a:af0c:dba9 with SMTP id
 a640c23a62f3a-a9029444940mr1955750966b.16.1726672981129; 
 Wed, 18 Sep 2024 08:23:01 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:23:00 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 31/35] armv8: cpu: Enable ACPI parking protocol
Date: Wed, 18 Sep 2024 17:20:35 +0200
Message-ID: <20240918152136.3395170-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

Update the generic entry point code to support the ACPI parking protocol.
The ACPI parking protocol can be used when PSCI is not available to bring
up secondary CPU cores.

When enabled secondary CPUs will enter U-Boot proper and spin in their own
4KiB reserved memory page, which also acts as mailbox with the OS to
release the CPU.

TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/cpu/armv8/start.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 7461280261..544a4a5364 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -178,6 +178,18 @@ pie_fixup_done:
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
+#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
+	branch_if_master x0, master_cpu
+	/*
+	 * Waits for ACPI parking protocol memory to be allocated and the spin-table
+	 * code to be written. Once ready the secondary CPUs will jump and spin in
+	 * their own 4KiB memory region, which is also used as mailbox, until released
+	 * by the OS.
+	 * The mechanism is similar to the DT enable-method = "spin-table", but works
+	 * with ACPI enabled platforms.
+	 */
+	b	acpi_pp_secondary_jump
+	/* never return */
 #elif defined(CONFIG_ARMV8_MULTIENTRY)
 	branch_if_master x0, master_cpu
 
-- 
2.46.0

