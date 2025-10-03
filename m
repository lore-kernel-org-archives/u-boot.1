Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A76CCA470
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 08:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B300E837E2;
	Fri,  3 Oct 2025 10:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PhV+c6W/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B80836F0; Fri,  3 Oct 2025 10:56:34 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7B083753
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 10:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso18275615e9.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759481791; x=1760086591; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4j5lBGPq+4h9dCVteHW+rLzCSBF8ELmgmg6FN1iG2yI=;
 b=PhV+c6W/WSmGVD8ZBQZF+P7G+IUH5KYDy4Tv/eSVuNofOEB4IUBQA6mMEIDL2nucgf
 GZ06I2CyOPdaQASHwBpwmOYmTmj4YGo4+Q8gKHWU1LpnzB3udlTBIoHShwdnZu/THI2S
 buatXN31i0Ysx4JAxVPavKFDTO6nDi7YVWeoWmkYm6z3lv+ll5XQQf+JG+6XrxbNzvNH
 1k3KJXkTYoVUueEI3a7GPBCvgZVDFhxjRGCo5rVyV8sZlENLcNq2EpTMLOVLB/e7q6Ue
 3NwEzJFHoVgRpmsMh3gHlqGzzS6Y62omOUSwdn3Ka0/3ItlABWUWO7ChhvMUxi0cTmwt
 earA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759481791; x=1760086591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4j5lBGPq+4h9dCVteHW+rLzCSBF8ELmgmg6FN1iG2yI=;
 b=q9T+gJvmrpWTaA+Fd9PyK0CKj5dk6MT/F7w+fA0NrfLduf3N5cEWFhhVWLaIptTBHO
 G0ZkoKtAhczecQChYaXANeyR+KjkkCg+G2Oj5daGPatlom79i/gZBNKYPuLTuN4jYN95
 px6pR9UTKlV7Ymzjvpwql5yWRNsKE+C38fEbPXsrWR6HKi14pjO0tg5MVmA3wP1jpRNR
 fNJU2wwxRRzpz6eO5gZYIFKL2mpgj4fsHlDc0XF+9dc+0vJnmgjqCJ+2WRVXjsF6hfX9
 h+Rb5uqyNArR2ZxDEcoH3ypwoHXZeL9L5RHpyOBB1eWQ11zjJRSVZnqPsXNUn6TauiHu
 C+qA==
X-Gm-Message-State: AOJu0YyQ9PJht4FncsHNj4W6XrhYIiZ5u9MHYP+wknmgd+xhxlvaH+ei
 AfHFne5H7NDfiJ/tSArYIXllQq72mbYk9QhAjPQt3f2XOZSXW9fhRYrKLBVDwI5qIi0=
X-Gm-Gg: ASbGncsp33EYVRK/xG+D9KzuQ0YqrjvomoxsTbtH6gkSHKH3L+vd5lsMh9gty0euAx9
 W2eSa6wokqwQk356MELXe8S0sSBg90jnZCMXSq6yVPWrTv8P7HP9WS7pWwk6kWrjSbTHTLq9vsT
 uuGqCYmQmUXZEADUpqNOm0jh8o9AGJRuyIIVvuRp1fCUfUQK/zsUwUKpzBKovjkZzlkrp5m0Ozi
 3lwWnlDhWtAJZTRZ7xaVDlI5oCsW+whKJk+iLrEJTq3I0atKakCesK8I6R4dLqgYRNUXW11nRXe
 4lWq1DyikyUEmOL6oa8makqyiu78tSxz8bLd7tujI68JRN1EMMT4uSrtvzypB3p7Rv/52xJrp14
 C2seARXger8Oh3n6EAvKcoM1uNqQsQcY83/0w1J6+H0fkIyR87uE/prcod8DzfDh2hOvyqwc=
X-Google-Smtp-Source: AGHT+IHt+gD9lDU5pvXlNibTHuNeoBHexasgu8vFM6Ze/UmkB/pEHWmGv3MJZStpfSWAzSLW2v4azg==
X-Received: by 2002:a05:600c:4688:b0:46e:384f:bd86 with SMTP id
 5b1f17b1804b1-46e71101aa8mr18003045e9.5.1759481791429; 
 Fri, 03 Oct 2025 01:56:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm6951709f8f.41.2025.10.03.01.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 01:56:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 03 Oct 2025 10:56:26 +0200
Subject: [PATCH RFC 6/6] qcom_defconfig: enable interconnect for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-topic-interconnect-next-v1-6-955eef068b6e@linaro.org>
References: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
In-Reply-To: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=608;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=j/ftOcgheW5VlBMX+z0+NXJRDV4re9/kXgKPIrzT1NU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo34+6RUwbDTckIPna+BVCSx5IktehUoYVP5+w98/e
 FaYQLGmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaN+PugAKCRB33NvayMhJ0ZFYD/
 9v410Fr6mvWLvwQshlh0lojyuh42lpWPHJyBJZX9BBOil/msgcDo//g0pf1fFPEJg/TrEKKu39d3PP
 wUcI4gwV2lkUmZIRoHU2Uvln9dCk+qG7DLOHWgtsoBdJVHWIt7aE4J4dhIwYnn7NXs/qBxVQujiPcx
 wmmeew8RKBFX52lUe+3+mHYUJv2hoVkMc7ughlcFEPXVmXq+u/oKEJ6L3CIT7N+rT8iw8seKVE063O
 xNqyA/dUrGKswyuEtzqXB48y5oujadnJWfviLe49ODtg77wKsaqmhfnra9uBjGc/NRoredaMdDbSOD
 67Wgu/uPnVGwkN97goz4/dttqTe9Wf3yCDBOzfCNSie3wnr02aeJUrDrm+t1T2mWi9eL6+obKxmTWA
 nf7lBO1+Cs1Pu/e6Ck/LYbcOZLVYpQ7pVRoBoTX6QQIl+NAbqxByzLcdAAlzlj0nRfWqzlEiUrtvWF
 XGzZNc3Suj17Oiv19WYcbir5Uiy5QINhQ4PvKVUo+Ugtf/bsIoBIrKBlavHM9KHw4oWjbjAodxaGkA
 LDy8Ezs3TZCWZm0hEG/1f5e6htgrKQG4cLb98m6pUVRCDefHXGB+uvKQZznbGEbAEiL9DY4yCGNO/g
 ndI4umptt5AZW4+A5QWfg89yZZVQzgR53HyEpTNgUHJ2JlQqY747286VAEqg==
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

Enable the Interconnect drivers for SM8650

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 8d1269b4634160de2d249514c75fb42c45f4b5ca..fa0243902d2e246a46ee0513fafcc0ea7ed6eb37 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -150,3 +150,6 @@ CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_WDT=y
 CONFIG_WDT_QCOM=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_QCOM_RPMH=y
+CONFIG_INTERCONNECT_QCOM_SM8650=y

-- 
2.34.1

