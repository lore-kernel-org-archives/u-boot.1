Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8AFC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB746879D2;
	Fri, 12 Jan 2024 22:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z2zbV5MT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95813879E0; Fri, 12 Jan 2024 22:34:14 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7728879FE
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-783148737d5so577784785a.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095250; x=1705700050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=Z2zbV5MT7v75Z9SfVkRhtfto903Qi5jcsrC0J+J71o1hPvk6XKisyTit0Z9/fP/vEB
 uh/c5qXpeYQNAUFFrnP9LeHxLw1e0IHaLwzpNNR4lqS+6Ksx7NVZNsC5NuS9zXkEHk33
 lb2B4j5IanMSROojqpqnZGDsTBUQncCtS68DeShKuZYVSkwgrpqdnwcq6LR8LhqDsS5V
 j6JPvamKaouNOrW2nrMlqR2JKnQwajamGW9y0c9OSwQ/rYNw1FHxZIjUsomIOGSJJRp4
 jZlf9nJBEQ1vb8boCJccPjxWgTu1g81VDdBcCAwllm+MItAc+eUCm4JeISn4RpYRChsi
 5WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095250; x=1705700050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=Hqdv2Rhaq8R+xc8AVf9bJgn8dUNArumwSd/NBvIL6A7nD42zmif5kwJQrejIKZJkIq
 5hWxUqaL6Ac7iDfJ+FQKv3naF9Swgf2Fr5+xWnqzc6Rg50IuffxA0iQ26mpIxPDzHZB3
 W+FBYxCn3n+ULx+JHEqSwX21SuAtJSLSLqB68TNCtYQp7/JBki8f5t35t7qZDW4eD52l
 remtjERQ4OEZH9FmyEQapbVui/05y/+I2S5i0ss9mftVSuOOxkJdUG2yX+CGBV6ldNUp
 zn7CYzyQFUl1vB0fsmMBPO3xQBP43uak8HNolPa+3xQ4Hv1jprBXwTlBmIqB1GUt2scI
 4oig==
X-Gm-Message-State: AOJu0YwrDC55YmwZIePY2GTJBtTmHLQad7EhwP3+0M2xCWRc7/h+pAKd
 Wvf4m+2tGJG8i/aIrkT0fpLuAMtGPeXM6VQjM67eCmJ41Js=
X-Google-Smtp-Source: AGHT+IHaHvNtniU/I3Cu8QuvbsvL7OKStHZLRInrdh5cmjCpO0mtFuJcbdfcYixXQ6xlRzZLA0kThg==
X-Received: by 2002:a05:620a:450f:b0:783:5129:1b3c with SMTP id
 t15-20020a05620a450f00b0078351291b3cmr17044qkp.151.1705095250194; 
 Fri, 12 Jan 2024 13:34:10 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:34:09 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 2/8] bloblist: check bloblist with specified buffer size
Date: Fri, 12 Jan 2024 13:33:28 -0800
Message-Id: <20240112213337.185460-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112213337.185460-1-raymond.mao@linaro.org>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
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

