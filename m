Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B8BCE7AEF
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411B984105;
	Fri, 14 Nov 2025 15:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GfbSGwKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC7384114; Fri, 14 Nov 2025 15:39:53 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EDC83EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3DAE84012C
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763131191;
 bh=CE/vwoHTXmeGpT2AZc7qVxDE/kVZuQF2z9KhaeSVTmc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GfbSGwKYarZQDr9uAyQAfGMHjKxz+5j+tzjFtOadDgxebzgglK2ZY2WbIPDV333Ea
 77fSRd9lb2IRro8bGtfF1nxtKnxu1hN7DeBMsTJ1oOn+ttuPnXFVZj2Jrwcnjgs01j
 cPG+MO8gDnRx8T2vQXNESv7QkholyojhfTfpKlWftFIzPlRW04GZw1saoR3oiXJyAz
 7MdLTyNtKa3X77CRQRjeYKEg396ao0wBSrpX+rYHOf4tkz4RsHb65l3UfkTCNkp82W
 Jyg6UFJweWqJ1L6ur3zO5DInxbIqbs6d84+CGe9/+B2n7dWBmrTX1cUFauIvppIw43
 2Oe8AiA0UWwhboyimue8VJXhKVxyrCUrWpgy2l7vfwlk9RwOomXn481qsLPKdnZTfj
 pzSr5hwhAYkXeNp/f4OEGUfmkwtd44vDLYR7KR9IG4kzHKaw9DQkUlBu+ga4CRb7yq
 sJRGZBjfiSEzXaSa0mIBsIiO5M5SkV2pWsvRKdNlSFdx1ch12qCs/7VCpxg+TPC+0P
 cwmnTXJpq81eaoRXHzEEqwMm4vjL76nW6C0w047HcyKGZ+lC62Sys5W6I786XiXpit
 be2qTmr2ycrLlZVDEBoKxZlIVv8ptCGjskW8Xdx27x7S8pJTxSwk9/XoCPx4+nzfKu
 jQWne57HBkWpl+eFCjM5Icm4=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so22219875e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763131191; x=1763735991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CE/vwoHTXmeGpT2AZc7qVxDE/kVZuQF2z9KhaeSVTmc=;
 b=WQCTa1jhvgHPX3z9KJMGXEoHJ43ayWIbA0nl/jQGRuUY3SQTXk7JnhGNkE0Uqkvybu
 A0xO8CA21TeSbsQKEEgM/gzYXqFFoCs1t6zYl2OqYo8T0yKhv3N0a5dh1kCD7LxpQOiy
 S9uJxcOSCKwJFfEyZvMVq/yqMHuPgcztKNy5i9IcqsE1PKSvTs+kW1mpDYWtRmXg9Qn5
 MqqNz1bo8TF4XRKEiaLSU3nShRDbSvU1RR+gKjGOAZnrgWxLjVIzs0U4OGrzc3NPbDn1
 1L5uTmvE01asCFW4GmGi509H+EtcR1wM4yuTAJiV/hSdOkbwX+c8VGewVwZFBI/mtm6o
 Kb6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGRsmTmgmPhaJE+LdCTCedDFVCc911Agpgf63KNQ/jXiAut+ypob1H3zjqZx5Oeu0EqdLE8i4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4Z64/WszmIA9qlbndMfFaqD3Y2g+65asJ0dmdOHqo7nDKe3y7
 KAyrv8Rjvrju8kGkEF++cW8N39cIYLw/hRjdtGRPLXXfQCcs1QxMBlKdSWUXTSFY646+PTQcK61
 Imldbnpumrzd/d53VGWr4khXa60VqFIRK4mrZZ1CANNuzgAHs/K/6QXG/itH6akk+eU/zEJU=
X-Gm-Gg: ASbGncv/JILWsnr815vP1V7AwW8M8LRp5YSTZhB8x999X1dwFb9LUrR0apwBAPkEjFK
 pwlBTXSjKy+Oq7+Uobx9MezGjPWcsnWQ6ngyjtwc8WsPT0e8maNlWUFXGQdpyAIFMZQK1PYFWHn
 bYgY7BqXy3cwwjLvKpuRpAuVZ316Vl6NwGjEnWXoVRXysFkdbBXeOJh2MXRRyY44nb8uHd4hfC/
 4dSI/mGTQk0DmDHQSS+5CZW4rnZW9iYPRjuCNZO2NGKVg6UY0aXEWnO4uGAbLZPSPlEXhvotit8
 PonrN9xLjGUnXnm0x9bVU056u6F1qmpU/LNT8Ohbd28gQHbdLQ0hn8S8UnI1cZ1rXfpLr7ISyJC
 CHQhMydNUkMGwYx2VY1alEZuV6AblAnEQY4wpKmtFahYTs2YxsfFSMe7I+TgVUPEA+A==
X-Received: by 2002:a05:600c:3b19:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-4778fe95fe2mr32836805e9.21.1763131190740; 
 Fri, 14 Nov 2025 06:39:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzG6L53XSrDOqS65uts39UKKSVIRlp7qKv5psNaWLV453rtAy2ZMrv28sX9Io1XFslAUxAHQ==
X-Received: by 2002:a05:600c:3b19:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-4778fe95fe2mr32836575e9.21.1763131190352; 
 Fri, 14 Nov 2025 06:39:50 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47795751d08sm5680185e9.7.2025.11.14.06.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:39:49 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] .mailmap: add Raymond Mao
Date: Fri, 14 Nov 2025 15:39:24 +0100
Message-ID: <20251114143924.155639-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The Linaro email address is no longer valid.
See commit 4cad9faf8d28 ("MAINTAINERS: update my email address")

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e08dfd3a526..04cb2419bfc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -114,6 +114,7 @@ Radhey Shyam Pandey <radhey.shyam.pandey@amd.com> <radhey.shyam.pandey@xilinx.co
 Rajeshwari Shinde <rajeshwari.s@samsung.com>
 Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com> <raju.kumar-pothuraju@xilinx.com>
 Ravi Patel <ravi.patel@amd.com> <ravi.patel@xilinx.com>
+Raymond Mao <raymondmaoca@gmail.com> <raymond.mao@linaro.org>
 Ricardo Ribalda <ricardo@ribalda.com> <ricardo.ribalda@gmail.com>
 Ricardo Ribalda <ricardo@ribalda.com> <ricardo.ribalda@uam.es>
 Rohit Visavalia <rohit.visavalia@amd.com> <rohit.visavalia@xilinx.com>
-- 
2.51.0

