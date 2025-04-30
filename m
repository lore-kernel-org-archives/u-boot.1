Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B444C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 03:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FE38283E;
	Wed, 30 Apr 2025 05:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hS/64i1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4247882AAE; Wed, 30 Apr 2025 04:24:06 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAFD68272A
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 04:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso6783084b3a.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745979842; x=1746584642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrQIv9xCchPUy7jlAtdKUI8idGFTXOVKXG6gDE2gPOU=;
 b=hS/64i1WdHEkVZDTPknsbnk6LzWGhbWBxCURdcRsC9e94wx7vfyOH2JQV+xCHsOauH
 iUfJUvO387iHDt5A13pHHOMr2xsd8v+1xcS11NhA7voa4iLMNMYELIPLHra5sAuuTRI+
 D9MsJPRZiZznXXF2ZafFWllruxSUQzPb245bX+6vBfDP798fK3DLsg1rtU7+DS+9pqZD
 ZUc8ziA/O1o1PJ+DG+vn6HmA4SCfMM0Gz9vLdurOv7X0vtARRx53PH/FAuNqswd39lZP
 CtpAplhTuY/5ea7SJsf9TIkkMnCMeZu7Mjph167/461MHShBWoMLlzEjH/lVkBgotXnr
 Wucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745979842; x=1746584642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrQIv9xCchPUy7jlAtdKUI8idGFTXOVKXG6gDE2gPOU=;
 b=dOWDjrvIZa7wI2AWLoPaoIUacA9BJurb52wmCpSgFLW/5HnF/EpS5m9NHrlTMPilBv
 /4iqgKQ1wQHZYS8vxYh+vn1k+NjZDJftYk+otdwjLjfmTxQMjTDyQUpsXhsFbDijocH1
 Wf1o92ZY4Tf3OSUXfSm5qziU1H8Y5Ll4LcqBCM1hNDC8mhc2EwAdU9DH15/Cv7wenKys
 33vtmgad8WV4LSGerlj0hPZJj4j4VdpsFBC9wzxV9JkTiuhsHWoC45b9dbjhpNSAKlo3
 L7fUtoc/OVcIki71RfT0YBbU3vRwKKutH0suxU+tckpxXdF/HFsOBL4d/lDUig0mySdM
 hiGw==
X-Gm-Message-State: AOJu0YzhrVXZ4MWeixb1VI2V/IOMgQAySaXftaTfXv8v7cvL44nV4Iss
 HjQC7WPKjLGuRR/C2kfl+xtrTAb1KxIKuhWP82iU9M41k37DCXMSorHtGjjz
X-Gm-Gg: ASbGncuIAFSXIHhQc426Qu11peFLj+/xWJ16rNW9INerFeVWRRzVSweeuil7y1ePNp3
 04KexrA1TNYOhtQz5CXkjvmB9zHscPU0sLMx2yxF9lE/11CGnAoWvAHilPbNoJJydPX3NGMMAio
 GVsefkYSoCfABBA8+ypB0LRdLT2kxVNTTw2Lvfdg8/r30AXLyZ2hcWDtSzQhgMerh3ufpHg3wgh
 omhVAyc37XX/1dIQH1wo88K69wWH1GWuWv3ljAUs5YGK+brBOU765g8/ukDw2o9+eh1uAOgJdMn
 Ek/SEmiZsPTFHYA7LKPiNBFCx3pGyXHvocKzfO6L2glcUyKobIT1LVPDjUreTEkmu/UmyzUywUz
 Talf8xyglFPpgWw==
X-Google-Smtp-Source: AGHT+IFBvvH4h6ieolBB128+Er5hn7JhxdSxXc2oryTTowD1/nfTJtWrNVQn7OdcJKcQufywD2LT7A==
X-Received: by 2002:a05:6a00:1411:b0:736:50d1:fc84 with SMTP id
 d2e1a72fcca58-7403a831e52mr1335891b3a.21.1745979841881; 
 Tue, 29 Apr 2025 19:24:01 -0700 (PDT)
Received: from aristo-b7flip.. (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a9478bsm467400b3a.174.2025.04.29.19.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 19:24:01 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
Subject: [PATCH v2 1/1] bootm: improve error message when gzip decompression
 buffer is too small
Date: Wed, 30 Apr 2025 10:23:25 +0800
Message-Id: <20250430022325.156922-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428060757.125596-1-aristo.chen@canonical.com>
References: <20250428060757.125596-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Apr 2025 05:19:45 +0200
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

Currently, when decompressing a gzip-compressed image during bootm, a
generic error such as "inflate() returned -5" is shown when the buffer is
too small. However, it is not immediately clear that this is caused by
CONFIG_SYS_BOOTM_LEN being too small.

This patch improves error handling by:
- Detecting Z_BUF_ERROR (-5) returned from the inflate() call
- Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applicable
- Preserving the original return code from zunzip() instead of overwriting
  it with -1

By providing clearer hints when decompression fails due to insufficient
buffer size, this change helps users diagnose and fix boot failures more
easily.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 4 +++-
 lib/gunzip.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f5cbb10f0d1..f6aa32746b7 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -34,6 +34,7 @@
 
 #include <bootm.h>
 #include <image.h>
+#include <u-boot/zlib.h>
 
 #define MAX_CMDLINE_SIZE	SZ_4K
 
@@ -578,7 +579,8 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
 	if (ret == -ENOSYS)
 		return BOOTM_ERR_UNIMPLEMENTED;
 
-	if (uncomp_size >= buf_size)
+	if ((comp_type == IH_COMP_GZIP && ret == Z_BUF_ERROR) ||
+	    uncomp_size >= buf_size)
 		printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
 	else
 		printf("%s: uncompress error %d\n", name, ret);
diff --git a/lib/gunzip.c b/lib/gunzip.c
index 52007715bda..a05dcde9a75 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -299,7 +299,7 @@ __rcode int zunzip(void *dst, int dstlen, unsigned char *src,
 		if (stoponerr == 1 && r != Z_STREAM_END &&
 		    (s.avail_in == 0 || s.avail_out == 0 || r != Z_BUF_ERROR)) {
 			printf("Error: inflate() returned %d\n", r);
-			err = -1;
+			err = r;
 			break;
 		}
 	} while (r == Z_BUF_ERROR);
-- 
2.34.1

