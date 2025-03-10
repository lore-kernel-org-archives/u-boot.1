Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B86C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 09:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12CD8004F;
	Mon, 10 Mar 2025 10:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ePa2UU/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E650E812C8; Mon, 10 Mar 2025 10:01:45 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3946280017
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 10:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5b572e45cso6972598a12.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1741597303; x=1742202103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3pIylDnRTk7hp+d4N7WmTUoLurZfyu50rARhAzIBegE=;
 b=ePa2UU/UWsCnsIscXVHup/7/mdWGs7hTZPTR+12Dt+9bXXqRmIF2LhEz9GrCP/JHks
 b8Pb3lb52s8Fqb8nRcp+fZ4wUpq8Rm92QMGsoanrgdUVqXwPjBbOgSgemCZuqsHpxvHp
 NnIJzc4CF9a4I+YmXKQa1Fu7BPtUcUx2opgv8R8t1SiM94aByMZU1TzYDFrzdU6sA0yS
 A6l38UtHSPcEx3pyXa5OEjlG5yojejbbrYUY+D/SOnkgJ329JKWnO4rTpmUhyUwVcX0M
 uqcsfwVKls2DR/mnGxP8HDaf9KHldVE7Of1pdFd1n4slVMEh9YFXlTGca14LiWAXZoto
 ScpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741597303; x=1742202103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3pIylDnRTk7hp+d4N7WmTUoLurZfyu50rARhAzIBegE=;
 b=GVXf56YOjnFK6pqheVrOP11LZoNNPUI777c67cQTMla3wsdLWIqzWvOczdqeNeIttQ
 OQ+00z8bBFC6FTN8tSxvj1K1wYI71BMhbiiIjIOLU7CHuDnGN4paxImYGL+HmcbG5c2J
 buDWNwK5IDPkbwBm3yrfcwSaP8kXGBOv1+RX3v7FL0CPUNqyajp6c3j2XX9GoLf/5+Z/
 OmWQNq1qa6BvNxyZLA2k+NXsWolDjlXeZqYZQLS9EyMxOExAJXFh82kw/22zZB9kLRZt
 KAVfnLRiHErHSZsrecOECjCRCcbHv17U8/7r6CiJ4/ZeMap89HtYSdPI0uqaWQT4ojqy
 sxBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIP7C8vmlcpl34b2mcJZRzMluArogjrecZzbWk796jMEZmHu5fPfcQM9oAUAVo8bBouGm/w3A=@lists.denx.de
X-Gm-Message-State: AOJu0YxdWYHuQWI8PWopJQjsCztMBfj3LHT0HD0fR/dIXuXDwIUt9FDG
 QeQH2iPfTZKmai50kl2IyWit/7+GJVt9fZqAHM4m0Pnj8EDK5yO9DIy2NtXGZCfZrhw3AGWl0C/
 TAsQ=
X-Gm-Gg: ASbGncuUNjM6vb/8Xj1R0CHdICQnTM3VhRjGZslgVBvR5YSozEX5vOXoqrLbZmnDi2I
 i+O3aFTEuZ3YzFAM1XnrxrhSs9Bw8cdkGMinzuVuQX1ZhyndUQL/vgV9amuceYnVWErh0qBXsmI
 +uHfV1+4gNag5D9KeUwoik9DegGCyjEanbz8RXrOvnxN94ccwukog2DCAA2iTAGJ0C8CE7ha9/R
 2OlpokQN3+otgVfUjwBCfStGq5NeNUY6wI/g2B4NGi9k/+dDp3f6Ba6AqMw+kajn8Y6WzxB8t53
 Uef8OkaNhXbsKhDlYnM+a34nJGHjxRiybvM5n4YNTrUumLir3xaZpdzDFxtmeUGEeO0NIPkA0vd
 3NFuZ+Phdw2f9VGBW9W4NFOl121y+6U61TJWx01taKec=
X-Google-Smtp-Source: AGHT+IEHZeACGva8ZY4LbMg9oFITEnhJ/1AJQKp5xkkjmaFEven1J7uH2WqtkZdvpf1iVSjL6wbzOg==
X-Received: by 2002:a05:6402:3495:b0:5e6:20de:f79b with SMTP id
 4fb4d7f45d1cf-5e620df0103mr8364642a12.31.1741597302546; 
 Mon, 10 Mar 2025 02:01:42 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c74a7184sm6578082a12.34.2025.03.10.02.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 02:01:41 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [RESEND PATCH 1/3] pci_auto: Downgrade prefetch if necessary
Date: Mon, 10 Mar 2025 10:01:32 +0100
Message-ID: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
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

Legacy PCI devices, like qemu's Bochs VGA device, are allowed to have
prefetchable 32-bit BARs, while PCIe devices are not allowed to have
32-bit prefetchable BARs. Typically prefetchable BARs are 64-bit and
typically the prefetch MMIO window is also 64-bit and placed above
4GiB, as it's the case on qemu sbsa-ref.

Currently the U-Boot code assumes that prefetchable BARs are
64-bit BARs and always tries to assign them into the prefetch
MMIO window.

When a 32-bit BAR is marked as prefetch, but the prefetch area is
not within the first 4GiB of the address space, then downgrade the
BAR and place it in the non-prefetch MMIO window.

For prefetch BARs there's no downside on being placed in non prefetch
MMIO areas, besides the possible slower performance when a driver tries
to map it Write-Combine.

TEST: Fixes pci_auto on QEMU sbsa-ref fails to autoconfigure BAR0.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pci/pci_auto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci_auto.c b/drivers/pci/pci_auto.c
index 90f81886445..e68e31a8227 100644
--- a/drivers/pci/pci_auto.c
+++ b/drivers/pci/pci_auto.c
@@ -107,7 +107,8 @@ static void dm_pciauto_setup_device(struct udevice *dev,
 			}
 
 			if (prefetch &&
-			    (bar_response & PCI_BASE_ADDRESS_MEM_PREFETCH))
+			    (bar_response & PCI_BASE_ADDRESS_MEM_PREFETCH) &&
+			    (found_mem64 || prefetch->bus_lower < 0x100000000ULL))
 				bar_res = prefetch;
 			else
 				bar_res = mem;
-- 
2.48.1

