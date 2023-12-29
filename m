Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE0C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDC087B7C;
	Fri, 29 Dec 2023 18:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zn5Sha/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F189287B7F; Fri, 29 Dec 2023 18:43:21 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882F887B74
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78154f49182so208379085a.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871798; x=1704476598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bFD1uCKXcHp/9GmadkAM7oizaVZRSfINAOE6FPzJD8=;
 b=zn5Sha/qDMpoYY9nrTTeWsRRDDH7/HK50RcnObrnDwTdrWn4DN+tWJgOerLxzUu3vd
 GaN6eKQHXIc8PNbqPHwgBcHTqSwrRycQHeqA5DKGTHvM9adDMZUU8e+KcBwQu+9pqNs1
 aGr74FhnMrOyAE8CuIRyU2u3WiUPq5aqYdTnDi3xbB0lgVnQ/MnTmTC3I0slXqbqV3AH
 aX58aeZgzDbmdICvxuycUxM/WRVPv8rksbTLp0SOyk6uiXoTc+9IXYY59dmdH/sYCLTK
 g4CDTvVLEX1dpkPSuYcQGs/KNNuxgavF9pQKqlDbNq/vsPG76Hw4Qpdvmw7RsEhZc49B
 gfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871798; x=1704476598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bFD1uCKXcHp/9GmadkAM7oizaVZRSfINAOE6FPzJD8=;
 b=uq3RWRZEVVKUUISIULTFIDxn3LbOAZvvhhOpAWtxz3OIrfsG/N5L7c7vmmNdeq1Qd9
 DhL9YrrzyfyAX0kEcPC+QIDLMY7HrryaKMEPAq25STTCK46rdyw5JFOsLJldcjWOcyUI
 xZqhmE9RLWfQY+1DCXW9ZC8sesHNI/bvNtP3pk4sl+685W07Lu1jj8Skk+b474h1YrA7
 5kcYQRZxi75T46M5HNgU9gKLEPkaa+8ZhiY4Zb0vlSMGEIBc369YW3D7HEX5EkXB9Pec
 XjWKOGqMZTRm0UQwJeAEC8hPHbNoy07Aq7c040LjAthwNSe+Agvmtz+iaUoEAjhZPkwO
 bTBg==
X-Gm-Message-State: AOJu0YyTcbCmc7NrQUwKroA+KVrQgf+5znv1Qx9D7MEy/J44OCkujFwn
 Jl+uAjK1kBSNI/1c6BJqvBII96gnL270QORCWwJvss/j6JY=
X-Google-Smtp-Source: AGHT+IEHgSRrs5nTz4IQVnmVQuh8XvtRTyNoZNr6sOZ1U+SHNybkOirmDHp7lX114f8ErTM9BHwKNA==
X-Received: by 2002:a05:620a:472c:b0:781:5f54:455f with SMTP id
 bs44-20020a05620a472c00b007815f54455fmr4636420qkb.70.1703871798188; 
 Fri, 29 Dec 2023 09:43:18 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:17 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 03/11] bloblist: Change the magic value
Date: Fri, 29 Dec 2023 09:42:35 -0800
Message-Id: <20231229174244.892818-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229174244.892818-1-raymond.mao@linaro.org>
References: <20231229174244.892818-1-raymond.mao@linaro.org>
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

This uses a new value with spec v0.9 so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2
- Update the bloblist magic to align to FW handoff spec v0.9.
Changes in v3
- Update the bloblist magic to align to FW handoff spec up to commit 3592349.

 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 5ad1337d1f..72c785411d 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -75,7 +75,7 @@
 
 enum {
 	BLOBLIST_VERSION	= 0,
-	BLOBLIST_MAGIC		= 0xb00757a3,
+	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
 	BLOBLIST_ALIGN		= 1 << BLOBLIST_ALIGN_LOG2,
-- 
2.25.1

