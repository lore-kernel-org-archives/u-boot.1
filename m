Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C7CC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8128796C;
	Tue,  2 Jan 2024 23:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J+tS6C97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 006D08795F; Tue,  2 Jan 2024 23:13:10 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8EC88756F
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-781df3bc08fso53137985a.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233586; x=1704838386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8supzDilxoS7RxR0deSo6Vi5bEnEygDYrUO3d/EF5Io=;
 b=J+tS6C97yk1QmY9v4+Zz4YcgON6/8Pm+g3pvMZalO0X+wApkXM5enW8WeRuy9DIdiM
 Xq16VAnFK3juDew8rh3sOR0eSCo6v0XM0pXAnMjMJwOe+KfpWP/toiVNZ0HYS+vY2CDD
 QQewS1CJan4eDbbz3t6DwZToedHVE5vRy2U9WkFBjxmQn/Y+7W/L1KcclGku1A1aZBEL
 xSdAv4XKPTrsjbLRwTL09HyuQ+urJnpU1/IYO1gfCYojloYjh51AsH0OMqMRuqG/vr8G
 u6YoXKoMMROigVmoaqhKdZ0wqtma0nYMnPY+uVfvp2zCDZLEaE7fesC9/zLhsm4SxWD2
 aRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233586; x=1704838386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8supzDilxoS7RxR0deSo6Vi5bEnEygDYrUO3d/EF5Io=;
 b=xJ2/veFJbGd7QMQnSnKBL/SQupVm9q+KH7f2X3Q0qtuBKPc3xD0WWRjTt1OL7zJVaP
 ZbCwE7tJgHziS8+AMGQ2ACbnSlIVtWnVjjJ4A3bCCy35JOyNPS1IKyWdfhwQO+Si0kGC
 0AfTtNz6oLXz75zGCiHI7th1KkBh1w5sgKTnFsvRoDBvtqTM5MZY4zV1Al8zfwgTQzIo
 RyFBCzsRnfnY3/JdOnmQJDCWTEaJ9cB89uQ56nU207wf3LXgKd8DmnhdCegmwqrz7Xqx
 dFscF3YBuKsSMWLnw4T//8Euu37FoCGwozbzsun85zqmc9RJRql4mqpv3e0cIa7Z4Gq7
 SxWw==
X-Gm-Message-State: AOJu0YzZMManqviFqG74u6sBhlNVrvgkL9W8lWdC2FPVbJRZHU0/uejM
 gfZVdfxvLGs+WXmeZ7PDBjlxb5/NfK6Ip7vjfH2wu1J+GLc=
X-Google-Smtp-Source: AGHT+IFCxVuDjErYGMhwtHCGBbXN3SHj1Ypcp2DjMU57/Scpy5xFSBEgXa3pAbUm1EeJCJzNGtKbAw==
X-Received: by 2002:ad4:5c87:0:b0:67f:516b:c275 with SMTP id
 o7-20020ad45c87000000b0067f516bc275mr27226412qvh.40.1704233586296; 
 Tue, 02 Jan 2024 14:13:06 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:13:06 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v4 2/9] bloblist: check bloblist with specified buffer size
Date: Tue,  2 Jan 2024 14:12:27 -0800
Message-Id: <20240102221237.1007090-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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
index acf67304d0..4039eb3a03 100644
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
index bf9e12ebf8..1906847c15 100644
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

