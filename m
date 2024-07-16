Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79426C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6838D889C1;
	Tue, 16 Jul 2024 09:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PyEVohNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57E8889BE; Tue, 16 Jul 2024 09:04:39 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9097889B7
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42797bcfc77so35801745e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113477; x=1721718277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5yFwJT3foXaetdtzvP87NojvH5E97ADhjBwlOUXm5E=;
 b=PyEVohNyqwAK4d9QinxIa+3dYfPhWbWEFjrXhmjPhO/OVutQXWKxcFa8fXtsRzyOnY
 aNrHE2eI5MxYFXUWfBJlmkx2wnEm8NaTMjG4uMMamCi+R3KRPl2jhb/2HHwz42R+pv+v
 +qPCVjOiQIAElfAGPAT8koXCv0czRnohLpq/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113477; x=1721718277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5yFwJT3foXaetdtzvP87NojvH5E97ADhjBwlOUXm5E=;
 b=Ixd85IXZKe4mAK/HQC+qAjpxBv4lDXRxvimALiQwwr+GlXfF76gxtK88CUbO6mUkbN
 5wjVYvpRRW+daoknuFv8rz45uhMyV55CNmx7+jVGj/Tv9zvGau61AfotEC59eFjbSUSa
 OMObm1LwkkOODjmBb6Zlv4A8rBDRNS7jTtfV4ysxTySrxsPtZtj7z5jihJA1+k8PjDfG
 bV72usl2vuenM+8GCkq5XxKgfr4AcO70QlVcX2C2L5xmjJnPxc9KFdXRvMOve2tNz7n9
 EAiEgERrNCFKb7EgGMyLJ5L2JsbhdrNl1n+RGeJx8/JlQ04Ylsnv3gmKuCsJyuDlc6Gq
 68MQ==
X-Gm-Message-State: AOJu0YxRCFoFYmU+MZPDpIEN6idfuOBg25ZdpUkIvHvwNTW+i62r+oQD
 Pr1HiN0HbbodzYWE4j2KFaajZjxaTGKVuwQxZfpQPrKw9p9w5huMJlwheWvfHIZsYn7fM0mgtuA
 =
X-Google-Smtp-Source: AGHT+IGmgXBkoah4RuYjn3ijfuL76yhQEBFD3qJYiQXeKeL3rARU/dk800/L7l55/YwNOs106ZMsLA==
X-Received: by 2002:a05:600c:4fd2:b0:426:5b3b:88b0 with SMTP id
 5b1f17b1804b1-427ba683f16mr6793735e9.14.1721113477118; 
 Tue, 16 Jul 2024 00:04:37 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glkp@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 13/14] boot: Correct indentation in efi bootmeth
Date: Tue, 16 Jul 2024 08:04:18 +0100
Message-Id: <20240716070419.1897560-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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

Fix a minor indentation / whitespace problem in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glkp@gmx.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/bootmeth_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 56a6e47f5b2..39232eb2e25 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -265,7 +265,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
 
-    /* bootfile should be setup by dhcp*/
+	/* bootfile should be setup by dhcp */
 	bootfile_name = env_get("bootfile");
 	if (!bootfile_name)
 		return log_msg_ret("bootfile_name", ret);
-- 
2.34.1

