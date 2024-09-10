Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03C8ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F13888FAC;
	Tue, 10 Sep 2024 11:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HWCLlxzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E4388FB4; Tue, 10 Sep 2024 11:20:43 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C114688F9B
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso21825645e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960037; x=1726564837; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RXsLDtSn+yuIut/V8TcI/hXin8AlEwPOWBtFyFIn58w=;
 b=HWCLlxzY+r476K6u+jUvCkMuRb2UMKzO/8dW7M9jjUbxC3X0h80D0dJs6E/54O9Ibk
 fyQWbx7hNbSg257dLzeXbIbzeuwPOPR3/00ATCxPxP117j1AULU5jpme95XmYOmjy5z6
 9u3gUftzL1HwXYFPA5BBAcI+k8rckSD7xc+G0buxM4xYx8OoMvdDkIMJXHVKhW/ZHLTo
 /wVMTnUWb28w/nodf8x3IYL+igvilG31rTwE2O9MUWaowO5IVldUxCDIpZtAFWmjZQRQ
 QcyfigUegr02P03G1pA+hQu29+AlPcdOoO4unv09IT6a+CsGBXA7tV08ikyqcfkVxS0S
 GQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960037; x=1726564837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXsLDtSn+yuIut/V8TcI/hXin8AlEwPOWBtFyFIn58w=;
 b=xHQu4h4POXo0DLY9zfpLOwJbqKFay9+FVS1NLYmwqLivhVQ47MqdYWbgIv0zVOkU30
 ttQs4CIHxKS2eQEMVFhrHNXN1pZ5mkbsQ1Ztp22cv9OfFU01rfzu3HejD0Jwbyln9GyX
 kE4ZveeYMM9f45fd75XgbfwbiKNesYqeR31XInKzQfFRIVgacR6a5yTvJfNlKZuGv8mN
 E701et5YepR+PGvq6UYQ1xQeySH/EwNPFQZc62eLZwx/wRvMjhq/zsfoIlWzI5AtKZIt
 OxFVh358KIFhwNC7G1lRs5nr8rWdNQ+PaLYrmXMEa0TP55ZNTyiGPRecvS6EFnuqrSKf
 KJig==
X-Gm-Message-State: AOJu0Yx3GYct5drfuAiUIXaqfEWhnTaWJ4Ro8OWKO0XgGeDOZJbna4Nf
 x/mdN2HD4MD14bffQWa8dYqhpy36in5Urk6mlXxarS8kga6S1Y2O5oWf06reA+7TRBoXJj4+OPl
 r
X-Google-Smtp-Source: AGHT+IHHpvrIJWbl6Q5MxRicMLGqEzo3EF+EmFPmoBq38YRxMYeivn9QWUmBF+RMsbE0R1smotxaig==
X-Received: by 2002:a05:600c:3b27:b0:42c:b81b:c49c with SMTP id
 5b1f17b1804b1-42cbddeb447mr14614805e9.10.1725960037256; 
 Tue, 10 Sep 2024 02:20:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:36 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:20:28 +0200
Subject: [PATCH 11/13] ufs: Fix debug message in 'ufs_start'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-11-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=648;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HYT2AgyXY0azFUgq+gGCV5dPIL9lk8/Aii9/9kmWuwQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9aBVv3XdB8WlSGua3C3LvARLTz9XhlMltEHJBH
 oYwba6qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWgAKCRB33NvayMhJ0dUND/
 9ufVb8o1Q0HzaT0TgW1XJRsDr2xmJn7F6T1f9dR61jzetyyvtlZzD/rlMf9RPVAzOiJsS2cZvgebqK
 5P1UUmixxD2B8ed/VzapQcdxaaJdwXvw7oBwc3VSd61OH3AyvSgOlmLBhzBypXgd8NjX9kduDDLLVP
 FqVLmIIE0U0eG6xucjgdwKsUfJbSGHFg3s1jvbqwDQ9DbPI9TzU4fY3taoZLHeV3l/dNG8fXfsdDp7
 SB/6cZXpGwxmP8wplC+d/h0f/4yEu0K7z5onYzgDIAUajQNzumzyfg92Esjh7cfjNd5XJTMPgjQL6m
 qsJccvTf0naf3QBRR+2KsIYFb2EW0WxFVSSj48CEmfMgPsRM5lCby/9aOGROCmw5H5z5jB9JZGwF0M
 Q4cIC+EpCUVdSIE+2JZY2N3qMqDWScf8GRDkfBh+wSXoPXu/rcltaljJvAkWBkX1o/ilMkRVmTw2T+
 nrwgehyfB12wDIqSsLCBmm6qJG6VbXQVyqBjgb7TP7Don/JIbJ+zieqS/HDlMkSm8ktBegxunE2u5y
 XmtihXYQO5sHsCY+WOf0I/e6vSoLAqGSkp3ugbV38s50rLuufjWVeTsUQ62uWx8SG97WI4wx1rCUZj
 M9njcbJlpdtjx3xo1a30YxfTfFrI7jJmekTBeZ3NnqmA0ZSPQIJ8kF7OVo7g==
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

Minor typo fix and rewording of printf message
inside 'ufs_start' which announces the availability
of the UFS device.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 5d4e5424358..d2df5c26f76 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1925,7 +1925,7 @@ int ufs_start(struct ufs_hba *hba)
 			return ret;
 		}
 
-		printf("Device at %s up at:", hba->dev->name);
+		debug("UFS Device %s is up!\n", hba->dev->name);
 		ufshcd_print_pwr_info(hba);
 	}
 

-- 
2.34.1

