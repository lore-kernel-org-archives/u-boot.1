Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0310C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C983D8750C;
	Mon, 18 Dec 2023 19:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qci6w/9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A848745E; Mon, 18 Dec 2023 19:20:06 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4399887509
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67aa9a99915so30343856d6.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923601; x=1703528401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WZKJiUZpT3hVKZ6Ft6JJtw1JDFeG+xXrcJjolkRR/s=;
 b=Qci6w/9wEx1ZdD3jwC6E7Cc9xQbfiG3XRZrOjBLvcanuo76c9RY7nc2uPBcY1OAWAw
 nifNQ2MNvPucVFDc1wgtfN/xK0cIDqfKK2pH0DLN4wFCcae4y2/HdIFayIYOs7DjxRoQ
 jWw+OIv5mp8T6LedWw4sqR22QrndFqPATHgNx+KByaCgvLEe/hd6dYFz4BfXxo83ttMT
 jPcGW6Ay6gDrglGsYvWLMnFfgF3UNHJNDe3ysqtnFHUJOENMnHKBa+G7fUQQqx+G7KuJ
 D1MKfoqIIrofqE2T72ZoFjlg/rbtiPA7L4xRW1ogN3dqthGiNMZ/JnHkmtwHhKOgvR/5
 rSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923601; x=1703528401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WZKJiUZpT3hVKZ6Ft6JJtw1JDFeG+xXrcJjolkRR/s=;
 b=vp2/NAe5p8+NhWJIHm8ZaIDXSkDBkacdHqPgfzaLlzsTl55lBMalfsd4f6N+K0Pc4l
 1PvgjGqO2foJl1Cm8pJ8L1wBVreRqC0EtQFRqq457VAEQAn/Kp4UoZiCgUh1Tn+6bcSQ
 Dvuj38oPimdzZ9HuABl1r9Mqvi7BNXzsPNOVKlwAcK6WxuI0GtDqjymPAHZlm2c5sGEs
 cLSy9Xlp+tdiBq5J/33sgOXtk295EoA4WM7BsadPilD5ahDKxeNQl3ZyXCWHi0kUQeA5
 yRoQs7CiZvwOEshcLJNi5SVeKulmx42pTu1UjkQYXdfjrBni8d/6V/CE3tojgLQSSU6h
 8kqg==
X-Gm-Message-State: AOJu0YwxiU5tg5w5cT+1VUJ53ZbE4/jgPHFSO4VBipvxaCl6e+kJOqu3
 Rc33z2XnBYkg/uto48mCeykdTLPTKGzdoBrAOfs=
X-Google-Smtp-Source: AGHT+IGN1ABVC5svvoK4hJCXSZJSRPYWCJPCm9II42XlHumHPOcBXReElSUCVEFlTW/ccwGCXvEDag==
X-Received: by 2002:a05:6214:2a8b:b0:67f:49c:4b6c with SMTP id
 jr11-20020a0562142a8b00b0067f049c4b6cmr11331225qvb.118.1702923601401; 
 Mon, 18 Dec 2023 10:20:01 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:01 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 06/14] bloblist: Drop spare value from bloblist record
Date: Mon, 18 Dec 2023 10:18:51 -0800
Message-Id: <20231218181901.337515-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Drop spare value from bloblist record header.

For now it is still present in the header, with an underscore, so that
tests continue to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Keep the spare value in the bloblist header to align to FW handoff spec up to commit 3592349.

 common/bloblist.c  | 1 -
 include/bloblist.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 168993e0a7..88e2a0f5c0 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -165,7 +165,6 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec->tag = tag;
 	rec->hdr_size = data_start - hdr->alloced;
 	rec->size = size;
-	rec->spare = 0;
 
 	/* Zero the record data */
 	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
diff --git a/include/bloblist.h b/include/bloblist.h
index 7eff709ec8..68f97395b7 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -205,13 +205,12 @@ struct bloblist_hdr {
  *	record's data starts at this offset from the start of the record
  * @size: Size of record in bytes, excluding the header size. This does not
  *	need to be aligned (e.g. 3 is OK).
- * @spare: Spare space for other things
  */
 struct bloblist_rec {
 	u32 tag;
 	u32 hdr_size;
 	u32 size;
-	u32 spare;
+	u32 _spare;
 };
 
 /**
-- 
2.25.1

