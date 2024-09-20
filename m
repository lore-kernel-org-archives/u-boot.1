Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E819ECF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E698A89415;
	Fri, 20 Sep 2024 10:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Glo5s2k1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4629893FA; Fri, 20 Sep 2024 10:00:43 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD0C893FD
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so4937165e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819240; x=1727424040; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oRI+braAFRkLtW1tYqHypYCrr66AgFi3eAXR8xLFtVg=;
 b=Glo5s2k1ySNDILyFyo9MEppvwb3NBanTDHBUnupJygd8dymzv6dTV2l20PhkD7SzI0
 qdsgzDxIF0rrnXaAJ0kftp07167sa03VRHeNiE2eoCk6kaTYjRSZhQQvA0ZSTcmPWZjP
 ZPf0ktGpESDzHV/Vz++7t/uq+7owQP5GKk84S5Q5WWGBbKHxuOs5mMsQ6iejBTJjqNea
 oWst6eAb3FJNoYh4ZdiMTkEz33L0XfhVSnA7EpVbjHPe3204smquQ1wSUQcWmRD+jR3X
 J8xHks69q+rsF5osmBBVEDWSV5zg8fHsklTNgqWSOrAcIFfEkZGCLwrJhgLZIbxRCVY/
 uhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819240; x=1727424040;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRI+braAFRkLtW1tYqHypYCrr66AgFi3eAXR8xLFtVg=;
 b=WfNPYlN2AzueX2mkrYrgb+ShsEjUd91noUM8fYtPlutgWZhUCyyNe8VIb77HaKLnX/
 MHvluxyoqQSwMdOk4Fdvfokti60ZHwiC+GYxa01oyJm5dt69Uamv0cmxbbnP0kiXywXG
 HUqXX8ZNwyzCMyAcwBVpdHCvFTBM83tGo//W1+9bwtYOyLzwM//TfruSf7J5XeZQTW3e
 7a5qVIVB2m0/oM94KEf5g0/FBhxUmJmN56D/jdadpu7YGSTEZiAn27iVKUdvVs3ercb2
 i1f/N5dCuyVrhc9pEn8XEwm15zkGurrSQXTWLm9oX8y8uGsys+RGn5eyZEiVCPU7wSTB
 6S+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV59jzwCVH0ZsaIuWW8zpR0rPb+YPj/oq/fkzWy10+mz54SK3bdH5DFUc/9flY4x8OU7gfeoeQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6dIkXX7mzEutCR9KFY132fkXYz5jO0QfX5e0FD4k1occpFuV9
 qeN17MnHtSR+rUQUVk5VcYSxwEDKNiZxUSnxghaoVz5ek3RuCex5TkL7eBPlLxk=
X-Google-Smtp-Source: AGHT+IFoysWOmWsipHdX4o1b8F3PpZo3nmKzKzsYuWEbZjcwn8UJr95wJCaY+wf6EMmG2F6w6JnKLw==
X-Received: by 2002:a5d:51c3:0:b0:374:cb62:b6f1 with SMTP id
 ffacd0b85a97d-37a4313ff8cmr928242f8f.15.1726819240110; 
 Fri, 20 Sep 2024 01:00:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:39 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 20 Sep 2024 10:00:29 +0200
Subject: [PATCH v2 08/13] ufs: Clear UECPA once due to LINERESET has
 happened during LINK_STARTUP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-8-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SucShAGH8B/9B31fOWGfpVy5Vh0aldQ5YL2oHPA
 H+jDoG+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rnAAKCRB33NvayMhJ0ey5EA
 CqeTt134P4yQ+8EMDR1Rm8WH3zm0Fnlj9NuTt/EWIL5yecHzLT5sCjqN6Q5mpc8FoyoMBtzisGs341
 Tbnx4iwAEF8YccNusly7CHJfhdI8ou/XICFLTOZBuruvMGDODbaA8j29QI6c11Fqsn8RAubzCAR5B5
 lDZh67h+Cxehgd5o8LdcIe17pRoM/Akle5c6Dq6jE8pOHm1WC6tDDAgGv9XPkQjsnOyyLoukUtqv+m
 RpzGAHsrlpUE1/gxCiPpjOXf2lEU36u8rCA0b3nyq+CBEYCm+KqiRvGGuDH3NSbifN6emh3GUA+uml
 scK0vrMTKqszv9BFcNl7xMhvEMfIxJeNocOw1rFnW8GfGfAiWRvcqpMCru0FoPsdoraFYpAon6DFBv
 3mrcMLRboNxJnKELVoBXHMMbmK7oU3Pv0bwrYfqKnwCLlVx+MiRetPoVlbSi91iBbsu6jUz+UEjtaC
 J6GhLLZfX0quDsk/umMCQ8eHY9qxn5C1SuPt4YmPrHBzWo1dWZRlD2IwMMdWgmjWHPZOkjhHvsoOjv
 GrUCETtGdBPCety6whK1YVZkr3SlDlJQUMSeoERBdI/ynFD28NY878Xy1BWZn4x18YVvr4DjumVqeJ
 WmwagDSfuAso86eWva9+eyER4g22vdXr/0ayHtLcymW4OUPIhtOpNIu9n0IQ==
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

