Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1074C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 11:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1654B8837D;
	Sun, 11 Aug 2024 13:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bX6hPO00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C40882EF; Sun, 11 Aug 2024 13:01:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D73881A1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 13:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 58DB04119E
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 11:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723374075;
 bh=iMhEnm2FvkkaGBpJNQ1VTEYsNIaxsyBTNyLr2TQ2ZHs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bX6hPO00lFE7urRkaxHiTPjIqXdmbhC34b7SRgb1tdIunselGRoCB8XNnTQ1hqkG9
 YRBZouvMfCVX2m7K+s+UTwV8lxJIq574STnh3F9xs7jgDpuAZlTHqSs6Vf87OlXlvC
 lAJtpPlP1HYwpXMdDfTXeBBFcRsgwBTXdnZNhRu+qhfVfNIRpWGaRehSxOLNzCTq27
 3V16GPJSfMaOkj7JV5jMN5+NxYNdC39JZB7smI2SgHk6zXp3oAeXViD8ZEOJNuRny2
 /Cdw0RW1BoxGX/FxlqEl1O1ZQ7mk6RZyD212NM+nANg1Z8M+NKBiz40LwXzVmtB7NV
 Dx9L0FjDTxlnw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36878581685so1795557f8f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 04:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723374075; x=1723978875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iMhEnm2FvkkaGBpJNQ1VTEYsNIaxsyBTNyLr2TQ2ZHs=;
 b=mPPMWeCUr67dN02FXB7hPDjo8zYfkv2UjbHEM9q+tb/d8Bho6RdO+p1znSjvrbCz2A
 kRBOfnhQcunrYn92VoLMrVrR5YnAV6LwNEmEi92XysWeHPuYjb+g4SKmWfqi3ZjS9rqA
 e3oXAQek73v5bZsdpVSTXfcgwk2s9uGICEnc635tFVTkYWJZazlc+lETKyiG5WXyB49A
 xeToZsVaM/cayle6Ic+JdA0PU4Y5wje+Nl2o7XZbC/fLFEMAZFXZhxzg5zITwCgV8OGQ
 sRFIUJYwQsLRxMn9SzfI7meDj6TnXgsiI26CmS6Br2l5fBErfUZrXaCq8l53oK6xFSrR
 MnsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWphwl0tCL/sMXlim9KbYMrRGbIDYeMP/lIBi4H/CB8sBWwd/TxigAhicvR4Z7+kZcDpDdERWWtCYxD03Uj1Pn5Pzx4hQ==
X-Gm-Message-State: AOJu0YxTdiNWl/58Y6haP7pMCKWb+E1LO+kn3i0/iY8fqCGiJAJMRmHr
 6xMIrV3hnF6v3WRctDx9ljaSJOt9+EhawiioZgwMaCPdO31rOeS8fjzg3WyRg/CarAEK2czOP/r
 sDin0MqxWS0Hl9uTv6Cg5bKHTGQn5SiVkSRl4xsyhBmmh/frKQau2YW0fAV+RGrz1aC8=
X-Received: by 2002:adf:fe8b:0:b0:363:e0e2:eeff with SMTP id
 ffacd0b85a97d-36d5fa9d8b5mr5624162f8f.20.1723374074774; 
 Sun, 11 Aug 2024 04:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhr9BUmW8W6aKamPB1EnQeT86gpiWmue6o7RGK0QV3Fd4z6f4X+tgyNhCm4LUB8ZXaA4mRhA==
X-Received: by 2002:adf:fe8b:0:b0:363:e0e2:eeff with SMTP id
 ffacd0b85a97d-36d5fa9d8b5mr5624143f8f.20.1723374074215; 
 Sun, 11 Aug 2024 04:01:14 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee31fsm4604568f8f.47.2024.08.11.04.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 04:01:13 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] riscv: show registers in crash dumps by default
Date: Sun, 11 Aug 2024 13:01:02 +0200
Message-ID: <20240811110104.143714-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

To minimize SPL size it is reasonable to disable SHOW_REGS. For main U-Boot
the size restrictions are much more relaxed.

* Provide separate Kconfig symbols for SPL and main U-Boot.
* Enable showing registers in main U-Boot by default.

Heinrich Schuchardt (2):
  riscv: allow to enable SHOW_REGS in main U-Boot only
  riscv: enable showing registers by default

 arch/riscv/Kconfig          | 13 +++++++++++++
 arch/riscv/lib/interrupts.c |  7 +++----
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.45.2

