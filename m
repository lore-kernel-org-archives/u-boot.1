Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74A1E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 10:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D36A89639;
	Fri,  6 Dec 2024 11:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="haTWOL7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F538959E; Fri,  6 Dec 2024 11:11:53 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B5C589639
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 11:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so1299225f8f.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733479910; x=1734084710; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R98GsG67+HMTQ9F16JpjpCdLaj8drkClLDgQ9RibUZo=;
 b=haTWOL7aR+eeQlRm5cEmHIv0TQNpCDB2PGvH9de1nPjoJts0EukbeVETkg1KCDJe4L
 bnXnm10z91ZdiFsoVpocuGJBD0dCYOEIl5o6SuShgbdDQ/slfgigjJj0gn4NMCIVUTfq
 KBDlP9FEGt+ugkACYpC+kypG+xiP521/9CucRY6xA+ICH34nibY70nhpmHVND1ridxGx
 4NBO/d69+MHcN+T7DXcyqd67u5UnL2Wyrix5nC1AppV/R5Q7nl7jW8WgHn63IxjcCGmO
 H/l73qHysaY5+lH5CCqwYCb1e8BSoTuZwWQqBMPp6wUlfJCOs1ePWPAS2DrAciPYiVA+
 AO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733479910; x=1734084710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R98GsG67+HMTQ9F16JpjpCdLaj8drkClLDgQ9RibUZo=;
 b=ci4xNaEecSWSD9GWAcUobhuRDdsWb4Kq/jsdmNeW+DEmdlnRLzt5bzKbc1jHCxfJST
 3pqT2ni3y4AzbU+S5dZt81EEhZOZYYX2Rk8twCfBJALkckRpOdiHcY27jqu/4EEWUlAc
 WVd4skP1y4hNPPPtuKN3X+XPoaiDMBHkPPnevwmnGX8kjCt5CtNIWHg4z6orHzRuUyw0
 amjI3HO7rPPKT5u5nxQ8B+j1Zifj7gC9nh8jBSi9tj7TNywpjoDEbgrUFBycvbITKlSM
 ptProhNt8iXBVQ2zHV9Ckr7sjmqVi5Gu43gJ99Nr6MRzB8cbC95f8deJw/YY3hx/GXqh
 7wug==
X-Gm-Message-State: AOJu0YzHr0lgEkhW2JULsLxkbzClU+92Q4UqAarKavGKoDGDYeKodLch
 PdMPq49e9DNEPSQbXLzmcSkb4FalCwvuAcbGedN3+tw/mJ3XVDHPxkLgm5p2OVx6uU5pQAuq1d0
 sgms=
X-Gm-Gg: ASbGncsuXi324yPzweEOY67RnUb2e6i9TiOE4YbPneSBVaMy7S+O6dB9srpuQ318gFf
 r4fxQk/Ue6SpDArWjDYf/9lZySgn3nFeIcI9MYK0R1GEVB0OJRSLfo8Jsr6cyz9O2jVI0nP3pxf
 GrZaLw6Kp9ZsrVw0lTjCmhw3deiaO/AsI4e1bwYpp5iUvqKEeklHfxkxXIjcEwZ5OyAm+NwdB/d
 dsTDxC8mLVL2e1+Wd8gTDNLS0dTfmx30C4+Eb9wUHwh3u0NKYdqJL+ZrRs=
X-Google-Smtp-Source: AGHT+IHOyHsLYDc4IBjb8F0bWXhDLt7VK38dZ/CeYJBybKnXFRsS98//fiCcpnwmiAp0z2cQ1Ufavg==
X-Received: by 2002:a05:6000:1846:b0:385:e0d6:fb6e with SMTP id
 ffacd0b85a97d-3862b3d0a4amr1755965f8f.37.1733479910409; 
 Fri, 06 Dec 2024 02:11:50 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7bf2:dbba:fd8f:cf0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862190966bsm4290154f8f.75.2024.12.06.02.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 02:11:49 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH] trace: proftool: dump-ftrace should write funcgraph times in
 ns not us
Date: Fri,  6 Dec 2024 11:11:31 +0100
Message-ID: <20241206101132.1094545-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

When converting a U-Boot trace records file to ftrace function graph
format for use by trace-cmd ('proftool -f funcgraph dump-ftrace'), the
time associated to each function is incorrectly saved in microseconds
instead of nanoseconds. Multuply the value by 1000 to fix the issue.

With this change, the trace-cmd output looks consistent. Here is an
example with udelay(25) added to mem_malloc_init() as a test case:

 $ ./tools/proftool -m System.map -t /tmp/trace.bin -f funcgraph \
                    dump-ftrace -o /tmp/trace.dat
 $ trace-cmd report  /tmp/trace.dat >/tmp/trace.log
 $ vi /tmp/trace.log
 [...]
 u-boot-1     [000]     6.719659: funcgraph_entry:                   |    mem_malloc_init() {
 u-boot-1     [000]     6.719659: funcgraph_entry:                   |      udelay() {
 u-boot-1     [000]     6.719660: funcgraph_entry:                   |        schedule() {
 u-boot-1     [000]     6.719660: funcgraph_entry:                   |          cyclic_run() {
 u-boot-1     [000]     6.719660: funcgraph_entry:        1.000 us   |            cyclic_get_list();
 u-boot-1     [000]     6.719661: funcgraph_exit:         1.000 us   |            }
 u-boot-1     [000]     6.719661: funcgraph_exit:         1.000 us   |          }
 u-boot-1     [000]     6.719661: funcgraph_entry:                   |        __udelay() {
 u-boot-1     [000]     6.719662: funcgraph_entry:        0.000 us   |          usec_to_tick();
 u-boot-1     [000]     6.719687: funcgraph_exit:       + 26.000 us  |          }
 u-boot-1     [000]     6.719687: funcgraph_exit:       + 28.000 us  |        }
 u-boot-1     [000]     6.719687: funcgraph_entry:      # 37971.000 us |      memset();
 u-boot-1     [000]     6.757658: funcgraph_exit:       # 37999.000 us |      }
 u-boot-1     [000]     6.757658: funcgraph_exit:       # 38000.000 us |    }

In the above dump, the udelay() call is reported as taking 26 us which
is consistent with the timestamps (6.719687 - 6.719659 = 0.000026).
Without this patch we would have "0.026 us" instead of "+ 26.000 us".

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 tools/proftool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index c2e38099354..af2cdb6d584 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1456,8 +1456,8 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
 				}
 				tw->ptr += tputl(fout, 0);	/* overrun */
 				tw->ptr += tputq(fout, 0);	/* calltime */
-				/* rettime */
-				tw->ptr += tputq(fout, func_duration);
+				/* rettime (nanoseconds) */
+				tw->ptr += tputq(fout, func_duration * 1000);
 			}
 		}
 
-- 
2.43.0

