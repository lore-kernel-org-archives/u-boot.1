Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E711C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD198144A;
	Mon, 28 Apr 2025 19:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TdYvJK9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4E4682103; Mon, 28 Apr 2025 08:09:35 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C27820B7
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 08:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so3685019b3a.3
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745820572; x=1746425372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6YlfkZ/SU5bbZl69lf+KxaE+cQuYW1MXeLfm1G08WE4=;
 b=TdYvJK9Sa0ebkSFzsUho8+Jmt5VFvheKht4oBqPyfFVgzPnFUTXl2FAOvsn4jaU89/
 OOm1rGjz9VInmjjWGf2ejhH48X4fbEpjrp08QvWtzUYZ4wzToJN4Ud3Sr60qBzS9K4+I
 KQNrMDQg4cbbDycajnjnz2mc6SBPdjK2jzB8Yt1VXHAXTtvTCb6HdbsnMu7W8J39cT7G
 Ufr/3cDrneWyJLG8NbOyuaRLzMBiCd9upQ5Zi9pT5O9FMy2ldgT7S4SkDv4TSx3xOByq
 sku0j9qsyGoXy8CwZWBLsGlTOFD2O/th2OABCnFoGHnCiTtT4s/J3uAbG8UHklzgibqG
 JaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745820572; x=1746425372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YlfkZ/SU5bbZl69lf+KxaE+cQuYW1MXeLfm1G08WE4=;
 b=uZ71JhXw2Zhu0NMbVHSKF4+68jpG0WLz+fgxSxUt/SbHyFTDonHQ7i/AjnLfQSDfEh
 Ul5uhWtgpy5KR3P1QosLuRCeu3rpVsjxCVrb2qmFJDKV0GVffHJlXbVMX0ENejETF2nA
 QOZuZrBhpNUs7u6zeRxOyh0aNqiL8h/trqP30du0Fatk7rktXfvCzEQhwgMaeen3t8gW
 F2bcptdm7gNRmPK1KveiKFiWyBJSBmKYFlOOREORHzs/Irh6XAN6akBW8/3dOkvhYx0T
 pNCFRkJMW1s/ob+8/49MDCchioNfaRuk3lH1PYHbetAFvp3GKAGvvtLCPAMEGdWCF9gY
 Bj+Q==
X-Gm-Message-State: AOJu0YxkStzPCmr0mzxL6TmK3ehgc5UXsTI9jZZ7TOPoO63MK0jWi8D9
 3KMs+jChHI3HbieMVu5cr9mwXKXJq/df1629SnksGIwY717IAGk20jOp8jml
X-Gm-Gg: ASbGncs/dQciJiHEVerqbBamlTv2cX2oAXBAwIr93nUQivGP8N2Josu7lh+vf1myDHm
 c1xeZc6cxF+ss2OuXBpMD+yGPA8/5qAXcnaGn7BOhKBz2cUqYQrAYO3dpiZuWkObfvoL+KQfcQR
 07F6b79lj81OBNPS++A3ef/BLLh8gOO1DpoJnIyZAvz9b0dl+KBex48/VV3GOIU8JatCQTNv++2
 LSInEu+vEaibW7mWKNcK2Z9X9E1Z1SlFq7NMPw6EFCHkcdSSpwWGDECAku2u/zgAGhy3zwOTSck
 eEWTSi+5Zg1njy39WM2lsF5jc72Q3Mx6U1AWaETz7RlNGdsJJ9U4wrHQ5ZyIJ5WUdFA8sSN9bNX
 3SpWcBtRjKQ+0YA==
X-Google-Smtp-Source: AGHT+IHLcI+NVWbgbCk9qZ3g6oxilXbYPByOL7gfqdzBw94j/FlFzO1RhyEscsRBz7TVMvfcZ4J9Eg==
X-Received: by 2002:a05:6a00:4f85:b0:736:53ce:a32c with SMTP id
 d2e1a72fcca58-73fd8b6bcbcmr11948065b3a.17.1745820571688; 
 Sun, 27 Apr 2025 23:09:31 -0700 (PDT)
Received: from aristo-b7flip.. (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm7314866b3a.103.2025.04.27.23.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:09:31 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
Subject: [PATCH] bootm: improve error message when gzip decompression buffer
 is too small
Date: Mon, 28 Apr 2025 14:07:57 +0800
Message-Id: <20250428060757.125596-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:53 +0200
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
 boot/bootm.c | 15 +++++++++++++++
 lib/gunzip.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f5cbb10f0d1..eae19232487 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -34,6 +34,7 @@
 
 #include <bootm.h>
 #include <image.h>
+#include <u-boot/zlib.h>
 
 #define MAX_CMDLINE_SIZE	SZ_4K
 
@@ -573,12 +574,26 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
 			       size_t buf_size, int ret)
 {
 	const char *name = genimg_get_comp_name(comp_type);
+	bool likely_buf_too_small = false;
 
 	/* ENOSYS means unimplemented compression type, don't reset. */
 	if (ret == -ENOSYS)
 		return BOOTM_ERR_UNIMPLEMENTED;
 
+	switch (comp_type) {
+	case IH_COMP_GZIP:
+		if (ret == Z_BUF_ERROR) /* -5 */
+			likely_buf_too_small = true;
+		break;
+	// Add more if necessary
+	default:
+		break;
+	}
+
 	if (uncomp_size >= buf_size)
+		likely_buf_too_small = true;
+
+	if (likely_buf_too_small)
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

