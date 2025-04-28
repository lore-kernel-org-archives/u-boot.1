Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE028C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AE480FDA;
	Mon, 28 Apr 2025 21:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yo6ok3gX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E878210E; Mon, 28 Apr 2025 21:24:36 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E4280BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227914acd20so53064825ad.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868272; x=1746473072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwIxKDQaEvHVl64FWnDS9OedBXtOLe+lLdJ5CCVW/48=;
 b=Yo6ok3gXnWM79gKW/7OgRDelSZfhifqzqBGnrL1S6iBnZkkxUbJehpz+/TIQzCmkKI
 4PFtxpmk66ue/HSeeLpVPl5+bl4yXUoYtGEpWkTEl0dP7nuxPZbp1cx7O7ibXH9AZHxJ
 R63Ch2UYoHZw/FJGc8TnhO/oUscNHZ5RYossU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868272; x=1746473072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwIxKDQaEvHVl64FWnDS9OedBXtOLe+lLdJ5CCVW/48=;
 b=GYsEk/8GotXgGgaSmOp/FulJ9vXdknktm6Rso9jfhdYbzF6bkykWBgQ8nHMgH8QOak
 7yWsP6pQgspLwgoMGvMYvFfy5dG3xgOG2FF65aeDFcTrL6yFZR4AcJWjdqcIfk5Ktjyt
 EjX9DczT0HyMLnF8ifmdYMW9uc783Zi0bjEWo06XVOWzykKbiTpskX7zGnHYnIWbRiYP
 KMoUR/TnSmSbM6r29qD4CzWK/0eXLaFvRw0BOVT6qd9cdqPgIHtZY7cGnn38Yivgcr/S
 iFlpfh04W0/mZA1fL46NTcRp6AwmqPx9ZWvkvIXp75Jqk3R/sVx4snOHhd+/REmcvG3B
 qi0Q==
X-Gm-Message-State: AOJu0Yx9kvhcjs0t8muNjAMTQZzalbdCkM647O69KGvJuyYMruwYV1ys
 /C2EezgroEw6I+29bOJJflL+vKANjS8XT7tXG/zm3sVCcIYZo1acEs7T6+zuNZVRu9ufgES/bjE
 =
X-Gm-Gg: ASbGncs2sF6fe1BtDUfjuO2ZL5+u/F+ULGOHfIAvNv1wysuEAbINtolidjfJQMHrPqr
 VdnKjsn31fRnam5oW6JSNXRldip+0x/51h1KVU7z1qjZwWfGzOzp2FzyhU2fLc5EZZXpwdqxJFI
 IBmfohkWvUwaGLlR88hw4GEPkBZ3J68UnVw4969dYn9wlHfjhy0TjCSNXVc6gkaUKctiio0aHFE
 oZZszHoFTKrJp3ms8mZYr/21lq6dSvA2UsRR+kHPqf570WSC+AjjvH86jsDnb/OWKCEAsb0PQk2
 yK80iMPtaehhG/0vZ7nJe63VUcaaSSRRZy1l/ly0qJp4ocKZi76zSQYoiL2U26C20snq6++Pn8g
 aWgv5sbWNML2i
X-Google-Smtp-Source: AGHT+IEE1aK/un28ZitzfopSGMVueySMqqyYWKJ4y6rFv0F15lN/h4rzLsYegN1utfFFbQ+7cvY34w==
X-Received: by 2002:a17:902:f143:b0:223:607c:1d99 with SMTP id
 d9443c01a7336-22de6b650e2mr6916135ad.0.1745868272008; 
 Mon, 28 Apr 2025 12:24:32 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db4d77e66sm87409815ad.20.2025.04.28.12.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:31 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 01/17] bootstd: cros: Return negative error code
Date: Mon, 28 Apr 2025 12:24:08 -0700
Message-ID: <20250428192427.3877612-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

This should be negative EFAULT to indicate an error code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 boot/bootmeth_cros.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a0..d4c4ed328bd0 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -340,7 +340,7 @@ static int cros_read_kernel(struct bootflow *bflow)
 
 	/* Check that the header is not smaller than permitted */
 	if (priv->body_offset < PROBE_SIZE)
-		return log_msg_ret("san", EFAULT);
+		return log_msg_ret("san", -EFAULT);
 
 	/* Read kernel body */
 	num_blks = priv->body_size >> desc->log2blksz;
-- 
Sent by a computer, using git, on the internet

