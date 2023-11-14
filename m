Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE293C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 00:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE95E86C89;
	Tue, 14 Nov 2023 01:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="kjrFMJ/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E9B286C89; Tue, 14 Nov 2023 01:49:42 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9931987061
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so44114915e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699922978; x=1700527778;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DCJpB7tDLcXdG8ZOsTYe317i3SArry6MQoeLi6+AwL4=;
 b=kjrFMJ/rbhwAXMvY27guy6m3Zwo+8BO2p18FUhO/3eBbfAXxvOMRFHRUs5N5ghWLZZ
 HbDqqaWokte910i0zKX51+H6OLLUEMa4Iv93dwXHI8iYxWwmHTpicP1vG+AMLzGEoy3X
 +NF9cuGxzM3a2jwQ+rOMP2tV4gFapp8MR5Nm+w4bDPJ4ca6q3Bp/BYBPnqZL8UBp/j7+
 1wFz8/P+jm33BoJVYPfcKno8LuFdNiigizOX8E0i4D3cRLNvhaywTuKVx141dcqbAHD+
 dRgYCSZIVHRX2L5u3lYbQKH+pg7TrIdINfJW4dbDu0LQCDceqjSz/ulazWDg+KZK5aiu
 6dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699922978; x=1700527778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCJpB7tDLcXdG8ZOsTYe317i3SArry6MQoeLi6+AwL4=;
 b=tJxqZCTm6WXu7noFzuAgQLwQot99vs/uyo6cyysMPcnFx3mBw+8h0qoxXnfrcN9NWI
 /Ebfa730CJHwgEKCxjE6btSmhm2a5ExmcYRxGzbIYKXe1HGHgmd5hqhDmymo1rAjbaLB
 JAyZWPFqRD+M0zT23UzvdfUzkONMTj4XLl6D52esojQ6OOFDqsG7gpIuFPPnJNbJQJYF
 WSGFd96xVdVs1hxmiB2RdW4Fd4qP/dB0D5Kb0o8XzxEuSPEb8uHB4ok6MmTAsUZ4RR+v
 uvcw7uXhdp9GSQbYjD2CU/NzE8lmgMlQOZLVI4YMuGfbPHZU5lhQKWmWmujQBMxogeWr
 nB6g==
X-Gm-Message-State: AOJu0YwyXhgPy9eRT96+C9gwFeoo8aCjVEZg/rNezMea52O7dPM0bnmW
 jgDzMaj6E4naa9kbWhOp2GznHbKZnwrUbbyvQegrns1Q
X-Google-Smtp-Source: AGHT+IE0kNSPhOD09sMU2skAjFtHN0iTHFFpISJiOYQfPrCeePN8RXPLZwzUSqu3sZX6pvswrV+n/A==
X-Received: by 2002:adf:f609:0:b0:32d:a910:6c2a with SMTP id
 t9-20020adff609000000b0032da9106c2amr4923828wrp.30.1699922977716; 
 Mon, 13 Nov 2023 16:49:37 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0032d2f09d991sm6402675wrm.33.2023.11.13.16.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 16:49:37 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	trini@konsulko.com,
	Shantur Rathore <i@shantur.com>
Subject: [PATCH v1 0/3] bootflow: bootmeth_efi: Fix network efi boot
Date: Tue, 14 Nov 2023 00:48:23 +0000
Message-Id: <20231114004826.815833-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

Currently bootmeth_efi crashes while doing a network (dhcp) boot.
This patch series fixes issues and both network and disk boot works.

Shantur Rathore (3):
  bootflow: bootmeth_efi: Set bootp_arch as hex
  bootflow: bootmeth_efi: Don't set bootdev again
  bootflow: bootmeth_efi: Handle fdt not available.

 boot/bootmeth_efi.c | 15 ++++++++++-----
 include/bootflow.h  |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.40.1

