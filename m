Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C882606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GuwnGy5p
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A8B640B22;
	Thu, 19 Nov 2026 15:20:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKJfexmMDzux; Thu, 19 Nov 2026 15:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA575409FE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101651;
	b=B7eYk4FZSIy1rrW5o5Q0WCgQHIcWHt76xrRW42HWjzSibo6qCY/PkiXLeLbSHSApcz9p
	 J+GtE39QQR+xOKKr24LTEBn01i4lbnv5Zc2LdNaT7l98I5LBpv493yk7k+GpYBzuCHDwh
	 bRAe6Tuyqo1r30MCnLv4VntvJBpwZ4WhxOaX+u1vc3u3djlzgMUQplyMHBZP/+UbHPgWK
	 gc2Np2YVDcQsKFH1WxjzrQKUA31BK0Hfb94vjc2q84aEjdUBkp/BVvEWEw6WAQJJVlg5R
	 m2K16u9UvGpLIta+5qEUTijuxGH2XL+QOkYXuCuNTGx8IovZ6zDr5zB7tCY0TtTqIEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TOllhKZM5HFvbn9vXAnYSGvkGHsJFJIgofr/d57jK8Q=;
	b=tCB5bAt0gdpUMY4hu89UN3rqvPdA6B9A/KhkikXW3V9PSGVMJ7Ng65xA0OV+RVnB69+k
	 f0khgZIbTxm7xIVa+QeLaKode9jR4LTHkAuz55OJL0VqK0pSaE8OU6FCPLNdZ//YnGRml
	 yYZzV5MsC4CN5yG9O1vUlIM4MZ3vpHjPAKYGww4d4cj8roDhC5YphAoZ5tt7aIz6bmazk
	 N8RGAFdyzEPT3R2fEsfyeq5E9kP0dnp7FjR5NbHSjDkSFrjHHaNW0/+5qtAe+EEQyNOvv
	 WKcjoDSjPqWV9Rj8Md9HUp9yS3dm6FipGXKihwJrypm0T7xm/+bLM9dGLeutsGFHq/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=dave.eu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101651;
	bh=TOllhKZM5HFvbn9vXAnYSGvkGHsJFJIgofr/d57jK8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GuwnGy5pMi8GtFKkZy8R/g+QDt8Clk6Ssk72g82ix/e8UJG3mFS6AYGhUDu09sa74
	 qQZUn5ITT1/srikUhhjw4ya+sqV3bj2xRpF+yBWx8a/Iww3i++u3d/K2+M2IFXDaTi
	 K9Be2xruMjVjF7llQ4Hu5mppuKFepHoRtAG/icNGegtt/78qcMbtOZ1XS4jZIEEmfA
	 FrTBSVoKbs765rkt1k2dEQCT2g+1hgnh7YufUlL+mSfg1Qr8nzLYoqqaT51Etfg+52
	 g7pOnIPnd87JulRXEI/ueUgWpKfb+2jBP9D+Sn8GQ3Mnkckw3DRc+JYGJR9gZQ2phS
	 K0i+xkyJqKdYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA575409FE;
	Thu, 19 Nov 2026 15:20:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 511CD9F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43438409FE
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STK5CAX0iBnQ for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 80E264081C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
X-Greylist: delayed 307 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 19 Nov 2026 15:20:44 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80E264081C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:43 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id A52FF20181;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Date: Thu, 19 Nov 2026 16:15:27 +0100
Subject: [PATCH 6/7] zynq: rsa: do not copy a partition over reserved
 memory
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-zynq-rsa-v1-6-62ed5f983d1e@dave.eu>
References: <20261119-b4-zynq-rsa-v1-0-62ed5f983d1e@dave.eu>
In-Reply-To: <20261119-b4-zynq-rsa-v1-0-62ed5f983d1e@dave.eu>
To: Michal Simek <michal.simek@amd.com>, 
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andrea Scian <andrea.scian@dave.eu>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Each partition is copied to its load address before it is
authenticated. The DDR bounds check still allows that address to be
U-Boot's own code, stack, heap or device tree, so an image that fails
authentication has already overwritten them by then.

Refuse a destination that LMB reports as reserved, as the sf, tftp and
wget commands do.

Fixes: 37e3a36a5475 ("xilinx: zynq: Add support to secure images")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 board/xilinx/zynq/cmds.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index 44ad5442577..af6cc707011 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -4,6 +4,7 @@
  */
 
 #include <command.h>
+#include <lmb.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -399,6 +400,18 @@ static int zynq_verify_image(u32 src_ptr)
 			return -1;
 		}
 
+		/*
+		 * The copy happens before authentication, so it must not
+		 * land on memory U-Boot is using: its code, stack, heap or
+		 * device tree.
+		 */
+		if (CONFIG_IS_ENABLED(LMB) &&
+		    !(part_attr & ZYNQ_ATTRIBUTE_PL_IMAGE_MASK) &&
+		    lmb_read_check(part_load_addr, size)) {
+			printf("RESERVED_LOAD_ADDRESS_FAIL\n");
+			return -1;
+		}
+
 		if (part_attr & ZYNQ_ATTRIBUTE_PL_IMAGE_MASK)
 			part_load_addr = srcaddr;
 		else

-- 
2.50.1

