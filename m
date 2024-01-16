Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9A2C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFBC87A09;
	Tue, 16 Jan 2024 18:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MPIJt/oS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7836A879EE; Tue, 16 Jan 2024 18:14:22 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0358F87A05
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42987bc95ffso69294841cf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425257; x=1706030057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=MPIJt/oSaqNWEwzvVFQro1cUiRz6VviD8ToX7CXgj5MA9xnWfLOrMjR+YR4bNRly55
 elWS+itlUwdDva+9BOeYvBhlESCPZt4MZL5rQRmCv4dBITcB5dMOUpM1dmwOYBw5v5Cs
 ssFn81N1uJTOteYcXaIPP9/S/TxOHH4WAym9eNvN5/Lvgnw5lFVap8x7juDQQLyGlnOq
 LMmf/XfyCLuUWcxqMRpQfH4S7t4UsnMHrjliWyxYzu93jmneWTqZcnkVczrlqBfDUsCe
 H8GOzd+/w00HP1vOFHlzV8YPQukccpxksQkM2qBDqvqd+7IDO0/EQ4JplDU9JPfdh7eI
 eiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425257; x=1706030057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJigRzS0a6MJW7lXwpZ1Qhu3SapeNrjWUudAElf5jcY=;
 b=iGDF1nur/o+a5UcYZCYmrq62uxIPS8IKva6u5T3b8S/FoCi7mA8fbkvYpbgHcMn1wI
 s0ZqvmgiFdRmra+IV6ivPNTxr3Ti5wxd2gPiE3+xBlYJ6wO06lehMxi2FLhUvLgxfWZ9
 wG2eFLoECxfWCOZMp5W+yMHUTNTs5vKgo5idATFnCQQTz92Rbbh4wBzTUQ8SitmP8cV0
 dKyim0FnUJtdztBV25F7aRIhf0MMuR0y2GgS7d0mHB0ocIUAmRRQfgImAXriDxaFlE77
 xR7YuaXYV24lVR4WRdCViDveTi3uCBpRU1eP/OG7ofHZSM54zU/wbG0pSm0J65oeuofd
 rMMQ==
X-Gm-Message-State: AOJu0YyqL06NDrDnkHyzPrz3K5HS8p2ElMbENEopno12F0jC1PLMu3Tm
 sAySKsWpLv6gKqMX3S3uYYdlJ+anaUf5tHjDENmWj3FZCHM=
X-Google-Smtp-Source: AGHT+IGsNR5Q/qWN5NV+G8jGFVjq/RpSnPDHEhkymXSGJ1w6hQTqqkPuwphwDHweaQ2nY31v/8ldgQ==
X-Received: by 2002:ac8:5a8e:0:b0:429:b1c8:e6f7 with SMTP id
 c14-20020ac85a8e000000b00429b1c8e6f7mr11340711qtc.99.1705425257310; 
 Tue, 16 Jan 2024 09:14:17 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:17 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>, Andrew Davis <afd@ti.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v6 2/7] bloblist: check bloblist with specified buffer size
Date: Tue, 16 Jan 2024 09:13:47 -0800
Message-Id: <20240116171356.376801-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
References: <20240116171356.376801-1-raymond.mao@linaro.org>
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

