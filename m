Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8628CCF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9A6892F6;
	Wed,  2 Oct 2024 11:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="AQVMk7ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B8A892E6; Wed,  2 Oct 2024 11:52:58 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7912088F64
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37cc9aeb01dso3724507f8f.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862776; x=1728467576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/beIsykpVwfAKQjLfhfTQcIU3bBU5wkl48+3YfYwgBg=;
 b=AQVMk7geBbChbHqDxk6gukjieBCSuBPUhwg0JBFY70QXnlB+Y2kDbgg78JEYOfZVWK
 g0pF1L3ZeZIkxBfNLSNiJyncckSix9WwRbxDROxj9rDGBSnwbpwSJG0nq00nARpkVjT3
 84URZiTa3ToQxOXwfnIBnmHcKFSqwdWCyXznYBe97eIjxu6tnuBbzESQ4Mb7eE29VoZ6
 Sj3ZfYNbc8jBWn5OhumxUUIdGgm6CeTaF1m6sYLwJ7O/xiCgMoiR08i2X4CjqjL1qQwR
 6c+Ma94rDZMzMKGkq2p/8RZASgOB01bU9mKBBw3iC+thi7sAWQx1+ABmMp5iFSyCJ45m
 DeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862776; x=1728467576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/beIsykpVwfAKQjLfhfTQcIU3bBU5wkl48+3YfYwgBg=;
 b=FiPlnrNEW+WqXBK4PqVQ8QKBjNIszP5MpgW2pRNZgVBn2I+IUct22lvbhiAYUwNRMD
 cCNDJTQdHTlXQO+Sqrvt+6xSoY3EVwR/LqPXVn3tZ97gBHZXwpBtSqo+ACE0J8VGjbRm
 y5hUQzt2anMb4K2eO3gSEGc7Gc0wMd2dFiwyrIWu/PyhJFbrE0UrgVrWg3UyrrtZwJv8
 l19mnIeQCb9PVRrjWZZLnycpyJQMMy0W+Gkl5roNEMxyw9bL7CozAzCTY71akiU73BAK
 tVb6ABdFPTpoMKaeeZve0NEfNAUsrH89rJSH+3IX4GPlDPl10t8jmAn23nMknCBpyYTt
 e1nA==
X-Gm-Message-State: AOJu0YwoRj0vAaCss9tcJWe+Cvh6fglUGPCLVgciAReXSMYYcCtKGnhN
 1eRTu0wGbZJkgKWdMKUiEbgQoT8zASesGPUGUgm/Ks7OkvuFLGJpmBqltASuC3ZHE/FVDScT3CY
 l
X-Google-Smtp-Source: AGHT+IH+tEFEpCsp8cdNS3LgWvHr2fFRE/UwiiOiTkDMnotFCG7WsaHqqWUTZyu8PAehb6UejSCfgQ==
X-Received: by 2002:a05:6000:1186:b0:37c:d227:d193 with SMTP id
 ffacd0b85a97d-37cfb8a30b6mr1374823f8f.10.1727862775869; 
 Wed, 02 Oct 2024 02:52:55 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:55 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 32/37] arm: Implement read_mpidr on armv7
Date: Wed,  2 Oct 2024 11:47:23 +0200
Message-ID: <20241002094832.24933-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

Implement read_mpidr() on armv7 to make use of it in generic
code that compiles on both armv7 and armv8.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/include/asm/system.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 7e30cac32a..94c6f8f134 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -384,6 +384,15 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+static inline unsigned long read_mpidr(void)
+{
+	unsigned long val;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+	return val;
+}
+
 static inline unsigned long get_cpsr(void)
 {
 	unsigned long cpsr;
-- 
2.46.2

