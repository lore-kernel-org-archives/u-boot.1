Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B23C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E365F87B7F;
	Sat,  3 Feb 2024 17:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KsecMGm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49B387A0E; Sat,  3 Feb 2024 17:37:45 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07AE8767C
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dc6de8a699dso2529144276.3
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978262; x=1707583062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=KsecMGm3V9OPMvk1WX1sJPfVEyxmIdMSInIvtiWtdHcb5ApUNnr8IV9JZJanF0Qmot
 UukFVME5ZGffq2y7/iDfnGvOAZFWjJe3M5q+JPf73wFlnS01+x7ewsA3Hi1RxpUIsIvj
 yM8nvAnzdPdFrBv7lg2o7SnuT35EWmJW3Qor/WsA9fbub/e5GI/5fztX/NNtPtxsLT7l
 emDwfyq+iY7k+gXvJg/i+PmJ/UDCqosYx9obMD9xJ9UQ0gZclCM0/d0dbYXdJnEdBUx7
 cR/8fLMRsqx2GD4REgSvDQlVWnnMtCrccu3sEXU/ySVtqQatXdn0OhT2vvOfqPq/1kpd
 swKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978262; x=1707583062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=hojLI76z5gSjUWfd+vanXOmxoxP0E3COSoxTVzU0hrNficHHugDK937+soCyhsH2Yb
 5P5Ug8evJ1cmT7En6dx9NWSVNCrtdiGjgNKUDbTZi6Kk2Je7tg/nEaoD3NkwKb7ZBRaG
 dh0FxdlVRfR7wdIy6NRaB14oaM2HswHMwIUg2znK69fY6MrmtyIwlSkka4V2GK6za5F1
 CWKS6wAY+eO5VeGTXrZ3tnITrokRfeVe9PgaJ4AMuVRQolTe3LOQrtxkbNSzG9+j8ch2
 0PcPfimkFNriSTMPZ/EyEI5PlN7DmKu8rXOCrZl0+K4gQEnZ6vQhOFNu5fk/ZR8PZBTZ
 N6tw==
X-Gm-Message-State: AOJu0YyLt1G8989y5/kgcBE6BAnUsc1xViZLsF746SfmvLxS01G8pAeR
 LdNkXosBe5mVQOgIIF2dhMcCAy4oBaB10dT6bePuA/sog12+09q22CoBZOwN9mGf7vxovdxxhXc
 C
X-Google-Smtp-Source: AGHT+IGGqZxnNiTeujYaw6aG9CQYmkxSKHw1IoBE5xB6GQGQvWOBCcpImb3eW3NwcmHTGWVTGcU/tw==
X-Received: by 2002:a5b:ad2:0:b0:dc2:2608:af74 with SMTP id
 a18-20020a5b0ad2000000b00dc22608af74mr11347500ybr.26.1706978261979; 
 Sat, 03 Feb 2024 08:37:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWsOR15Z+9poME/ml20tGCUCce03hodzvzSwsrQ+3zHW0Q9uabuNv0i+K8GNoANSfOeeUPqr81rZwrWeWF3Wo0aORE4Ef4tbeu+RkewdsayL5xD783av5txrnAxrk/luW9Xl/V5oTjUWAkzoV0pjjxkzt1K0Co1ag/bAew6c2NvLdneEm8UgTND7sqv4q9ptRQfoZ3a0LpX2IROl9gqGgSqpcQISq74fwRo9ut9vUdNsm1UHO8Ws7VQuGT40bj6MX9x5ARfQ+7Q96+0/VEmj3FtP/sfwwpLL7fFCllqVw6mt4rTRKhb+gX1WMpPPXJxRXrsytbgfhkv0rH+dCoKycSYqQa8QF+lzlxCsQU+qOTBBbW6jJajZreKKf0PKbjvIEsnZh9ITA==
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:37:41 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 2/8] bloblist: check bloblist with specified buffer size
Date: Sat,  3 Feb 2024 08:36:21 -0800
Message-Id: <20240203163631.177508-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
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

Instead of expecting the bloblist total size to be the same as the
pre-allocated buffer size, practically we are more interested in
whether the pre-allocated buffer size is bigger than the bloblist
total size.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- New patch file created for v2.
Changes in v4
- Update function header of bloblist_check().

 common/bloblist.c  | 2 +-
 include/bloblist.h | 9 +++++----
 test/bloblist.c    | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 980b1ddbcb..26b0ba33b1 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -384,7 +384,7 @@ int bloblist_check(ulong addr, uint size)
 		return log_msg_ret("Bad magic", -ENOENT);
 	if (hdr->version != BLOBLIST_VERSION)
 		return log_msg_ret("Bad version", -EPROTONOSUPPORT);
-	if (!hdr->total_size || (size && hdr->total_size != size))
+	if (!hdr->total_size || (size && hdr->total_size > size))
 		return log_msg_ret("Bad total size", -EFBIG);
 	if (hdr->used_size > hdr->total_size)
 		return log_msg_ret("Bad used size", -ENOENT);
diff --git a/include/bloblist.h b/include/bloblist.h
index f7e800f681..cc78259e5a 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -348,12 +348,13 @@ int bloblist_new(ulong addr, uint size, uint flags, uint align_log2);
  * bloblist_check() - Check if a bloblist exists
  *
  * @addr: Address of bloblist
- * @size: Expected size of blobsize, or 0 to detect the size
+ * @size: Reserved space size for blobsize, or 0 to use the total size
  * Return: 0 if OK, -ENOENT if the magic number doesn't match (indicating that
- * there problem is no bloblist at the given address), -EPROTONOSUPPORT
+ * there problem is no bloblist at the given address) or any fields for header
+ * size, used size and total size do not match, -EPROTONOSUPPORT
  * if the version does not match, -EIO if the checksum does not match,
- * -EFBIG if the expected size does not match the detected size, -ENOSPC
- * if the size is not large enough to hold the headers
+ * -EFBIG if the reserved space size is small than the total size or total size
+ * is 0
  */
 int bloblist_check(ulong addr, uint size);
 
diff --git a/test/bloblist.c b/test/bloblist.c
index 17d9dd03d0..7dab9addf8 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -207,7 +207,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	hdr->flags++;
 
 	hdr->total_size--;
-	ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->total_size++;
 
 	hdr->spare++;
-- 
2.25.1

