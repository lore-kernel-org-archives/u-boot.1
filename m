Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5371DC47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C74387CEE;
	Fri, 19 Jan 2024 16:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VXbUOLoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493AA87CEB; Fri, 19 Jan 2024 16:12:16 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3080887CDE
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78314e00350so64096485a.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677133; x=1706281933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=VXbUOLoL04eivm93NyYPL3/7p7IMfpf+nkPOJ9HOoUs5XGnpx8YXjfQslDg3UN3oy0
 i+Oie5cq8L98bgS5uechoQTHWaq5WDnQFqb6A59X92RTEYRT10Z5FsuR7DhhMvvv9Ig8
 GLiEmVEu/F2BjZec4MSuLnFTfbiHb1LlLvls7xa1SVg77l26zg9fb/fzcL02S4ShjCq3
 ygexYV45D0a4EFtTbtILeGa/bhDVcwtw9x3cSvQEZNHIpDfqBRNFc4EN4cnsnQryr7dV
 4ubs954dqmbOnUsIC8cUv633hbkevSGaNOAo1snFLuWEWgBZz2aLsQ408OJ6cjaabFs4
 FNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677133; x=1706281933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=JSs7zkBNXesJFwaJoJtaxZ8DoIIgUwYU9+ZDZb3JKd7tvndAgDf0Eb2F/zX88lG49Y
 nBdenFxRSi1saRSiv/A9GG1jK8F0KSYvY1SvhHp+YhJIMliVIN0t8GWtvVnleD3W+gdH
 d2IQYh6Zb3KyQ5dTqMKQXYvl7JrjbiKvKgIY4RQe6nQoyA6DkftZhagzZIu1xk9UR3IY
 Uq/k4WlRKHZMy02QCL0Ac0sii116unSXpcT7BVGiaX6qjOun5XYg+aWT3QFqTpZdBcD3
 pCEd3vt/SAQ3mT0X4aQMiZqDKuGjOzS6IKgbxo+PI+wj6wJDjc7Agvcay3nVLH7fKWEV
 qS3g==
X-Gm-Message-State: AOJu0YyKsfkq09R8gP8ErctGTgnTGrBDD/yhUbGMhqX2Hv9AuNGZSGmK
 kMlT9CYQpxSdiFUA9hOzApEcGA/PnbFxxxarS1dB9J+Pm1DKeYSXjk4q2WygsHL2Uj1iC5ymq8K
 a
X-Google-Smtp-Source: AGHT+IHHGpOnYbCwzvux2JqLGvgxWy43UdRdra2bRSmO0YXQV47E2aTlygm4vJV2qjDd4GYfCHSVLw==
X-Received: by 2002:a05:620a:198f:b0:781:1dc9:4534 with SMTP id
 bm15-20020a05620a198f00b007811dc94534mr21470qkb.66.1705677132859; 
 Fri, 19 Jan 2024 07:12:12 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:12 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 2/8] bloblist: check bloblist with specified buffer size
Date: Fri, 19 Jan 2024 07:09:58 -0800
Message-Id: <20240119151007.715348-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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

