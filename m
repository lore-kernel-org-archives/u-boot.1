Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B5CCF64A0
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EAE388E3A;
	Mon, 30 Sep 2024 14:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gd0Nfif6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E404388EF8; Mon, 30 Sep 2024 14:44:42 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01EFA88E63
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so40168545e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700280; x=1728305080; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oRI+braAFRkLtW1tYqHypYCrr66AgFi3eAXR8xLFtVg=;
 b=gd0Nfif6gNx28xwkoXTbSv/eEhaj5nAoISdvrmZaL8xc4heHn2dJgJDcUobCNS0gcs
 35OWV+YlSnHRRTgALM24QSI+COd2VQn60aWv4/Bar3WcgYhucliSh6neYFubQ+Ahwajw
 ZgOQtsQeERgtfKCsvI3KYSYbOoOQHrAYO8TGD8y4Iy8sDzYwcSo81jsIns4bXs/0Vntf
 gUbLCIYF56zkBCCi3LqGU+8ev3/ZmLBxVijYz35uGACiVSEieuiYapG2sXtJdv1EfjM6
 +kDXejBc/0e0QszvIp6d5nVqr7qXp8+P1vBfBZNJb3LVys9OCasRKR49x1uK+CYg7vv4
 AAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700280; x=1728305080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRI+braAFRkLtW1tYqHypYCrr66AgFi3eAXR8xLFtVg=;
 b=I8CkAqMUM+c/cgbWvIU08OBKvq+cM8iF9169Xvzi+MAgT+1xrxzR5KREhxyeizj+DE
 2qNgYRcE+WpvNhwBX8dTv/qwUVvae/r/9zGXV656AeraUVcUdAUQyshhQy0K8rBkhYnz
 iVPITbSYWyk9HluPEf4EBP2Ciq+r2xf+wgtQjLR5rR0ot/uNSesIt0xNTLEjGjd9+h5e
 C3DW5oOxxoU93P3xnYGsPW6BfBEYM0SteDtKVFwBAcF1cShoTdeW6PeNY29SY71NzSMr
 xUYWEeaq/tXvqSh6K4U2fvTIFufvbj2ignYYlArs4kLCsvksLCBipaWumJiinO1n2Pv0
 SMDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKxC/QGfGxeXAeTDm0631k0s+PBq4KMqHS/rNd3sevaciW6kDj2RVacg+/lggme8luPkqJue0=@lists.denx.de
X-Gm-Message-State: AOJu0YzQPnSOCVpKL/k2dUfMZSMU7BfGAMTTs3LpVDDgx56GeiwEXUQI
 5vb67/guW/k8o79wIwFW5QIWAw2ZWDkaYmH8LJfq+Z+pmkLDiVkfUkwwKliDOtg=
X-Google-Smtp-Source: AGHT+IFZPKDC/8HgQVMElymk6GWlzOAC67zTyZXeb2uIG/g4ImgWMa3i1trxwEYKmV1CHxcamlmWeQ==
X-Received: by 2002:a05:600c:3b04:b0:42f:4f6:f8bc with SMTP id
 5b1f17b1804b1-42f584339bbmr85225775e9.9.1727700280386; 
 Mon, 30 Sep 2024 05:44:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:40 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Mon, 30 Sep 2024 14:44:30 +0200
Subject: [PATCH v3 08/13] ufs: Clear UECPA once due to LINERESET has
 happened during LINK_STARTUP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-8-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=H/JIMlu6LXL5TwiLe2RHNPxjiY85MChmdMxPyHH9Kvk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0r+Lr48jKRU2C6KU0llUr6CxWX+jXBtz4CfaJ4
 Xi9P1saJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKwAKCRB33NvayMhJ0awAD/
 9FlMjmV6ocdZZsgIP9C28mJ9wso7ZjEVqCPq/5107XSirYf4cJVxRqS5mpwGHMM19URdcz7AHYpWl7
 OBl9c777F7GFGpw6ZyA3lRe3eu8d69uGmVyE9epTSY3QEB4yfyld0OAyg7ABsu0svlYhBIwMFq/71P
 kAFIlaldVUxOWecx/a8zqmz8hCYYwYkBzCRrlWLumLXhYPEiUI20UcArVAOrwvmIhUe8eAYtcAJn4o
 /3dBoEYxnXi9bKqyT3VhhL34tMBRoevqZubkfSnZrDOEII8oGjs60JEAmMXVvuG6VPXCL1YD96jXAS
 000lNiQePGSjghJlb9IBhkjmKXCy883lCoc5HAjM/j64lYxO0lhZ8Ni8y2zzD6NKcZOyK3TAqp5R+u
 RqHjhxYpG7C90AlxPDYsCgKyMeq0XYpiHTZxjp4qSnMNNm+pqcQaHTTHYXk4YOvk+UJJAXBpN5AcqE
 6RkYtgYnN3xS1dR+Ma/Euezwhsoec675HQpLGHb3jx8xOtGDPGZHJgzIIKkjssTuGNPtEChNKTxivQ
 I8HOoPQJD2JMRoH9tPfzKI9+2U4Y8H0rUMEuV/JkiWQrWdPe+5a+d+KkgoNxrIXuxYJLM8B/gkwtQN
 knvwKKRm8tTzST6zU7CUDt3W6rF9qZrpwJLPZpkZFEkuuV2ObyFOHSwHCO8g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Clear UECPA once in u-boot UFS driver due to LINERESET has happened
during LINK_STARTUP. This makes the u-boot ufs driver behavior related
to UECPA similar to Linux UFS driver.

Ported from Linux kernel commit:
2355b66ed20c ("scsi: ufs: Handle LINERESET indication in err handler")

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index d99dcdef7d0..565a6af1404 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -504,6 +504,8 @@ link_startup:
 	if (ret)
 		goto out;
 
+	/* Clear UECPA once due to LINERESET has happened during LINK_STARTUP */
+	ufshcd_readl(hba, REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER);
 	ret = ufshcd_make_hba_operational(hba);
 out:
 	if (ret)

-- 
2.34.1

