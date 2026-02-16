Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF374E83827
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47AE080FA1;
	Mon, 16 Feb 2026 20:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqGl2cwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926E183AAB; Mon, 16 Feb 2026 19:45:16 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC0B80077
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 19:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.kokosinski@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso21419075e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771267514; x=1771872314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=081/fG6CKNtqOX1ooCi+HHg4AKCLic6d5gC8khsM3PE=;
 b=dqGl2cwd4f0E9v2AFU7gFt4ve+Wqb1y+dehEtLQ1U70337iWpf/nZYzXPy8tlRI3g4
 5MzDk5IiQHiJoyYFbfNkuztF3Rp3JkldVfV5dvWDuHPRtLLDh2/7L4ndrwy8pGTNoVHp
 y8ZvwsWVYos2veJ/ZRnEAxHl4rJ8/B7shZ57LTZ8sFcVPS8L8lNKgxWql8K7hoXsSkob
 LPZBnhEWNDQmh++Rl/GJdNe4SbPAXUTrLf/N/iZSJjkI6685wuedbTqCuWk0WZHxwXcR
 hyoKTFEVtxXyaYiSN/PviXuofdUQPldeZDACYUHXcU4KeAY2EgVs9Kzf8yBPIypiHwlz
 gvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771267514; x=1771872314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=081/fG6CKNtqOX1ooCi+HHg4AKCLic6d5gC8khsM3PE=;
 b=BFPYoLy2A/pXnIxqM/tZve+C+QN/fhoNcOoi9PdWUIvkJGYkt1rOhnMpU1+ULZPhkI
 L5IOi1zKHphkIEPM3vDrNBJjqhIyWRAJQRXbXviBGeUKHG8OpspSg1rdslnCUMkjeXbF
 fKRSubpnzZyS2GSBfUUVe94KGCFekZx7mHvo+U1Wh2/1ts3/Ju8p/0VPvl5PcE+VZ9pf
 shP+8pCRxy1Xk67W1slEwgQIn9Q8hFwLfxwVwPKb3k326K7NM5mXQAqXDByqlWlcFGcc
 K1tFwd6ALsb1JkoH6cZ3iHyCjxr1IhOKNT1/pKziObd3xWZYCw9pFucAkVIYTh48ruJf
 YgMQ==
X-Gm-Message-State: AOJu0YwBZh/eCZg8KJ8KIxy4LcTIuMWir+OBkrPrTxMvrc0C7t1+0JDQ
 OTTCrHBbs217Vb02DyqaElor/VDAIT3tZ1zDPZ+XYUudgKq732xAJNBJZKQnyw==
X-Gm-Gg: AZuq6aL+F3B2Hv6fAGWRVc1SQCosx1OfLkXH//9vmF78+Gfl3D+qw+CLObd0EiSBPwC
 XU4bFc2wQkNtwhRDelkgfbKtQD73FhN8QCEEvaCmYgWfp9wGI12ZzF3MWxPActnZ/FXqMkvypg8
 BrJ3vtldeYRPR4RXXM3SGeSITyiFbpByhUoWV2zUX4GqjJqMCyzZopnDQZJTIaatmYCF4J+F8P1
 e1NDfWtwu2m+ug7nyC0SywiAA1jM9/me6GPb281hUFCyJoeYaxcwKYSKgsszTnVfGniXP6h3gaN
 Y9L8rVuy3Yt+pW2NB2w4tpn3WYs/iUEX0zOXBxkflWu1PJHoorGuMO2+gOWF/LsqsK0ZxDcppFh
 YgkfdDS9t0IwDXvgRChANKr69zGSYI6By17pB2C36SD15knBSCtH1g66CqXJmdLcIRO0J88gFai
 OMHJUqWzN5uz0nghyptaU1p2yxNI1/WykOREWwZbBBztZwz79vv+u29KrM9u60HrUh+vTr7M5AO
 +7JAw2uqdQo
X-Received: by 2002:a05:600c:468b:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-48378d9ccd4mr158529645e9.12.1771267513748; 
 Mon, 16 Feb 2026 10:45:13 -0800 (PST)
Received: from desktop.home (83.23.200.152.ipv4.supernova.orange.pl.
 [83.23.200.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm449404165e9.14.2026.02.16.10.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:45:13 -0800 (PST)
From: =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
To: u-boot@lists.denx.de
Cc: mbrugger@suse.com, pbrobinson@gmail.com,
 =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
Subject: [PATCH 0/2] board/raspberry: add FDT for bcm2712d0
Date: Mon, 16 Feb 2026 19:44:50 +0100
Message-ID: <20260216184452.18732-1-filip.kokosinski@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Feb 2026 20:51:34 +0100
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

This series adds the FDT for the d0 stepping of the BCM2712 SoC. The v1.1
revision of the Raspberry Pi 5 board can't boot Linux properly without
additional changes specific to the d0 stepping.

The d0 specific changes can be seen here:
https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm64/boot/dts/broadcom/bcm2712d0-rpi-5-b.dts

To do that, this series introduces support for multiple FDT entries for a single
device type (bits 4-11 from the new-style revision code).

The rpi_model struct is modified by:
* changing fdtfile to fdtfiles (const char * const *)
* adding fdtcount (size_t)

Adding fdtcount is motivated by wanting to keep FDT selection O(1), and avoid
relying on NULL terminating fdtfiles array.

A new FDTFILES macro is added to initialize fdtfile and fdtcount.

In case only a single FDT is provided, or the board revision code doesn't match,
the selected FDT defaults to the first entry in fdtfiles.

Filip Kokosiński (2):
  board/raspberrypi: add multi-FDT support
  board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi 5

 board/raspberrypi/rpi/rpi.c | 96 +++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 41 deletions(-)

-- 
2.51.2

