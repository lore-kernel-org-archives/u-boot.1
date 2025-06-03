Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EA0C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 04:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A39681E06;
	Tue,  3 Jun 2025 06:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TV64pWih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7418B81E72; Tue,  3 Jun 2025 06:50:48 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4C480BAE
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 06:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bc3987a05so3269424a34.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 21:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748926245; x=1749531045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=25J6Y9xTIQD4dy2Wq5xb4yfs96CVeO0qzCaW5rFb9tM=;
 b=TV64pWihOY7YNAWhV3YHNxhfDLktrjRg5ECK4mxi+Txl0fMKkd8Mb0m31mDEx4b9UY
 MDjFq4/zTaqA5X2WFpZLBjjaVt3KAGOApx+W+DKuUT7VTr4hllAlhXBKR80cec4Av5tJ
 FZxjQT1czgofiG0wDxL0RFO3ynPcPaNLWEHdmBOrV4NuaJPKLeEVIXNvr8AXUcVVTcj8
 EhISzxn59MXXgCnFM4KKQ8PPfgvye956VdiMQ8fcIQRYgr0+GzbwevL47L7mX6mYiiLq
 GBRTaeun6TvsGw1dX36/uHM3N48WQbb5yE7epy3nC4henfx6KIUKtZxSdOuxdH/wnQvD
 YRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748926245; x=1749531045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25J6Y9xTIQD4dy2Wq5xb4yfs96CVeO0qzCaW5rFb9tM=;
 b=oi5rRZE8X01ahsHzgiehCrc/NcnCI3KGxUPbyw964kRyTKLhj7qayYNdmj6MmE8UYs
 oq7KRY8F28bcxUn5e+tpoJjrmOT1UYhKoEfsac1tTBnM2emZ1CZ++1mWqaEQhasRXNAk
 82WLUrg2ED/6DTxyDZsmFUgPfq2ZiujWHR5cuJezxjnV5LVvYHwnvOb0bhPfsVOlHjPL
 fXRMJgt8an5jsRfsEbgx+uhye7uYtuuqwLau0KePWsEMZGydYk9pVLbGs9duMaU/l7J2
 Gqzqvk8acZ9UCWVeHzcEBZkfvpDY3ir2B0WP93a5igxCT2M7q2V0zElrSVqKQ2V4iaji
 U3eA==
X-Gm-Message-State: AOJu0Yx2K6cZURGmTBcM7jhS2vnXTUbEB48++/OLLsmQop38zdY6A/Ni
 DXxydI/nNSqnW4lIYKHlkbbrGWRxKbwefidrmqwH90KeOkRUWnose2Av
X-Gm-Gg: ASbGncuQ19YvyI1ktoHMlhKwdnGsmKj8fA1GMJcUDnd1lJkuvcp+USgd/xREraudCcF
 FBbm4nlywvJZkwfFyjPpsAsusSzXIyCLK2JKkl/v3deCyOETWRuWD3INulg8O77t0zM1NoBZ/Yy
 EtkPppTiZ6k24Zy1d327y7JLmzAPBR+56KXRWbUj6uQy7Dpa6qz/1cz5zz97H554GLhQs4jfWI/
 Te1m5sv7NIVu3q237f3upvNeOfs138keZ0ZVWx10UyIIIqyaTHZKVqL7E1yFa1G4ENfOELE+5As
 8fV6xHGsOrX99eaYWd2ysLrgt/R5l95RSqtnCtm8GA8Rx8iZ5b7XpGbIsNkP56EiyEnneHq+aQv
 MkvFex3nCZCByMVZ47DSBSNDiPBGsG0pPuCRgS8w8e8oMvLkwWA==
X-Google-Smtp-Source: AGHT+IE0Ak2f9Wmr8Hp35SZ3NmG3b0qwhKusHucBu/y5QT4bjG+aKbc2yAJ6FFEuAjVjoibBUltZEQ==
X-Received: by 2002:a05:6830:213:b0:72a:48b6:720 with SMTP id
 46e09a7af769-738593a1c57mr571253a34.14.1748926244667; 
 Mon, 02 Jun 2025 21:50:44 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af878f0bsm1767897a34.39.2025.06.02.21.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 21:50:44 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 0/1] fs: ext4fs: Fix: Data abort in ext4fs_log_gdt()
Date: Mon,  2 Jun 2025 21:50:21 -0700
Message-Id: <20250603045023.29630-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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


Currently, the number of EXT4 journal entries is defined as a constant,
MAX_JOURNAL_ENTRIES = 100. When the HDD is greater than 2TB in capacity,
the number of blocks per gdt (no_blk_pergdt) is a lot larger than 100.
So the function ext4fs_log_gdt causes an array index out-of-bound in the
journal log (journal_ptr[MAX_JOURNAL_ENTRIES]), and results in a data
abort.

This was tested with the Synology DS116 (32-bit Armada 385 SoC) board,
and a 4TB Seagate HDD.



Tony Dinh (1):
  fs: ext4fs: Fix: Data abort in ext4fs_log_gdt()

 fs/ext4/ext4_journal.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.39.5

base-commit: e9f852f7fd2481579bb3521c13663d33a7f22eef
branch: master
