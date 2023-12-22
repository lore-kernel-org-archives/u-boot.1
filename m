Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76427C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89B9877F1;
	Fri, 22 Dec 2023 22:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mIwZd8K5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1DB877CA; Fri, 22 Dec 2023 22:31:49 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BE9877BC
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67a338dfca7so13676316d6.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280706; x=1703885506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2rx+gtoX65D+sG5rSlOLf55Ss6HbOoowEp2fYIt45c=;
 b=mIwZd8K55LExVBXJzxDPzlkHkSyaWOr9SmMI1CUmfXx1LTLnsnX59YYw/z7+BQtRQ4
 GuYLIx0U3LHRUf6B29WPtt5nGZf72H0KnePKqW8qNp/E6nRB5Jio7xCe5moyz+/q3fKA
 5H0LVo2DsUL9OWnxksZm24WggfLYJgF/W1mwyY3EmYMm5rDa5v244ZALs08XFqV4Y/im
 pzb3XWCSFapvzH7gKWcq75HZddB1N+i3MO30m7v+epgcyHdAJByWVr+npdUFqbCR7klh
 yncLDSds9NKPUz/F9Le1eq+dGTPWmrBuAad08o3LIxIDdMyaru9Rf7JpwivE1CyMvTI3
 LVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280706; x=1703885506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2rx+gtoX65D+sG5rSlOLf55Ss6HbOoowEp2fYIt45c=;
 b=jEPKuZ+n1Z8OPkBpXDnQ6ELlP4nzUHWU24zx+gszVoNVUj9naQOmiBWhPB7NddMcDX
 AbAbxhKptnpVJ5fJJq6UWRWxh0LGtywHkxPZ1JwqKVHkW0fdT7wzHgnJzhH9PblXB8aW
 4qCygE7QD3GeczY08vvYtTkspi65/QSidc0Q8IuCA1TGI7HGBwAo6SBjr1dRYXS3J1fU
 22wqZ8pbauO8QH7kyhbWMDHE2RGhC/brh9fKuRTLNke8SNGs7RXwV4xn4UBR3Ko+KE+f
 dyj+NC5GVKb9BFB+bky2en5nqv1Dbta1gbsoW6O9NmHnnm+jvE72/FgPH/NmFIIOSWrg
 N9/A==
X-Gm-Message-State: AOJu0Yx3qwG0dtv+Nj0/pK+sZtKla8RgRxXY3SlIWPRlm3JJzbsO8Wim
 0dypufc51AketchDZzUViAvvsuUm4l4QffKaPvmEi9k/hD0=
X-Google-Smtp-Source: AGHT+IE/f2TAU0LuqMMW14psdUqdsqsahdMBT6KBa73SAKyO2z9avP0DbiN+rBpxeSU53+A/kJYs7w==
X-Received: by 2002:a05:6214:1d24:b0:67f:3c59:a1af with SMTP id
 f4-20020a0562141d2400b0067f3c59a1afmr2653252qvd.7.1703280705976; 
 Fri, 22 Dec 2023 13:31:45 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:31:45 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 2/9] bloblist: check bloblist with specified buffer size
Date: Fri, 22 Dec 2023 13:31:02 -0800
Message-Id: <20231222213110.660402-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222213110.660402-1-raymond.mao@linaro.org>
References: <20231222213110.660402-1-raymond.mao@linaro.org>
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

 common/bloblist.c | 2 +-
 test/bloblist.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index ba17dd851a..db3fbb20cf 100644
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

