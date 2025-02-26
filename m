Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9762AC021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214D3807EE;
	Wed, 26 Feb 2025 14:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Lo8Kxo0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCC980F56; Wed, 26 Feb 2025 14:56:52 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACCC805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e4ad1d67bdso709889a12.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1740578210; x=1741183010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3pIylDnRTk7hp+d4N7WmTUoLurZfyu50rARhAzIBegE=;
 b=Lo8Kxo0kPxSUZxBg0HwjXxCynJ+Q9UpntH1zouj4O8FRVyX+qlgy+hLAZz891RGOZv
 vBs/9vyyElUb1fllJOG6sZj5+WVW3dWr3AblESgQyxOfgozq280IGQYTska7d8PFXCOY
 NEjwMmKat0f1S/8ghCbLmDbzMPRAT7IIFYQ4N+DisddN1bx8e9jCsy0xeISd25J2u4wu
 zKb1QhPMaYBw3d79zvMFhRoj1/CADUxMdp95CLsowTfP+qLQwkg+HyR3A225FP+zIznM
 yK0sJDUCx6F6F1w2pyeHdXwqzdPYS3Ty3wbiRDhGdBAIXoMk/Utah6Kk2Nw72jb1nrj+
 wexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578210; x=1741183010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3pIylDnRTk7hp+d4N7WmTUoLurZfyu50rARhAzIBegE=;
 b=E9w4xtvaviRBzU9363ZI09ksxNrD+DoaZEmH/MbnOhTbyKKwkMKclpl+69FKInZxG6
 94LOv6qGLNEcXS65mWMw9xQEL5rm2qVvzf+TZ627H9TaUSccls+96RgG/Hq2rG/ncGVW
 xjcZANbTGCidAsENyk+1fv+F0hLuhMTGzVz4WVQsM46SSCp/ZQ1Y9a5LtONtblUynRyo
 UcMpOXbB9wnyj8n3S1bywuUie70YFlpEiOoFICs0HVBE1BVv66MoCpt8vKMSDoC0Ot6s
 Be88Pvn9IaNu1HbasxeqZ7zkQrnW6WlBOv7WwEOtJCXFH6XNyS+2aZ0E3v5wS2072Hn3
 IJGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc6Lq2bhAZtbRhBPk+cY5cgRu/UTlfi2TsiNKFE0S2LucGgiZTEbjrvASYaJeRXALX0NMPDdo=@lists.denx.de
X-Gm-Message-State: AOJu0YxNbdQwqoXsut0qoizAc56IW4ihV8FP2NjYMEgwFy85TCCJEuSF
 hDDdvqqYe7i2Ow908J7RtvUtToyV+wsI42ylTWcCZEnAQ0vs0Vp5YVYMccAckUryRhidiLsY1Cv
 MteM=
X-Gm-Gg: ASbGncu8h0dR44PMy+P4iENvNLA29NaDLb/YL3GvZuDDeAYtNs01wCHECq6j/MAqPtf
 SiZ9NdLx977bMhjcO6aasQPZKB3e+M97fMIsOX9OZflYwdKjKB9D7VC4XRW7x3RELU6V0h1kkog
 i3y/jZ4BwPIBgSPx3VrpKpVEOlnEzGJQglwlf+JUUF+pG3hG06y3kkE1/koIIWQfKlNleZmvDSI
 UISqa1ekTEGr4qod//fZSdCXkECLAxb0w04VPOzpFcMYUQ5/ljfd2C1qGXxd7K3HjZjTQzmUIgB
 fcyoUhrXuguRADLZQWes+KA/ZSY/ZadueIHZ05wu+crmNT8o1nYDYbInYvp/O8cY16+7LBSPVJp
 cNzGpBFBWExz0HYKR2PYzEXaD
X-Google-Smtp-Source: AGHT+IFcuu8pJeCBQk/HreJNW+lK0zbgf77UuNX7xtOMxlfwx3HOjjUukSMdR91ALKFNMJbJp0GVhA==
X-Received: by 2002:a17:906:32c9:b0:ab7:6fa9:b0a9 with SMTP id
 a640c23a62f3a-abeeecf5df2mr365579966b.11.1740578209848; 
 Wed, 26 Feb 2025 05:56:49 -0800 (PST)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20121adsm335104066b.91.2025.02.26.05.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:56:49 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/3] pci_auto: Downgrade prefetch if necessary
Date: Wed, 26 Feb 2025 14:56:42 +0100
Message-ID: <20250226135647.194842-1-patrick.rudolph@9elements.com>
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

