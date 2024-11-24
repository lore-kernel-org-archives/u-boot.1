Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECBCE6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D06899DF;
	Sun, 24 Nov 2024 21:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gi9IIX0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93A089550; Sun, 24 Nov 2024 21:27:49 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E22BD89920
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cfadf851e2so5032671a12.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480066; x=1733084866; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2EcU1/WhYjSub51mghC2L/448jRXwuF7SafKgOB6eZQ=;
 b=Gi9IIX0Ljf0icFhs+mNXQYxzYGJbp+MzL1h/pVpgHoIodfSG0LdLJS64KQD8/520sl
 vBE/HMfrm9rdpt7EOczMIHJHwL8P5GKdVYbI4caUF90oNeeU+fhs1qRTb7sok0tzSouv
 nVf7Ii9n7zvrNwFvUTz+iB+BzYyigQa2fkApyVOq2fAZlDXOWj2BDrFRC5Fmu83hw8iz
 hj4kcW4uRPhwnRnSoK/ZFcbjlgkvJmIbSZtw3KYokye3ZdY2PLam0pT2UfpqxNs3bTy+
 l4kkqzy9YsAsnV5dCojNMkgVMKfF7Rst8TMG5Wvn2NKICXNKYcNvi5Bcu3DqhRnZK1ee
 8Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480066; x=1733084866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EcU1/WhYjSub51mghC2L/448jRXwuF7SafKgOB6eZQ=;
 b=AqBAfXdoQn08lwJuh4RAgqvaTSNWZSk6cYVUj3c4kDOvWDB1QOQOvFKy7Yc517oQAh
 6BG3mv/uc1FBKfspBo92FcCDQwyoZmC/IDyZYxGwsR48X+u5TOo7opAuvHSJHe7qy9x1
 GL5HhglwyB3eoNpeIeV6Ncn8vnWV8QPBVi3Z71jAp6DGPrCMEN9kSPv43cKE9RDwNUha
 4FyLM9UiKcQ5SOlghYbL2F6imjsBDOgSlvKDmJeQR3OlAqcpuhhOQvQLjOKvpmqkjYax
 zDEhfRoy33KISX6jbkNNcwHHmRoyfmdmJlbI40TBkfj2YsuKiUoi8WSbsYLAwLv4hG9E
 gWwA==
X-Gm-Message-State: AOJu0Yy3SDjlsOdiV8s7jm2TlmNWfhhPIDwVmtm76cQbMoaMctYwobUT
 RAyb7uLxac+1LdaIYry3UvrslDMTAbM61XqeAI1Qi2wGBhbWd+9dlETpHW3Amo8=
X-Gm-Gg: ASbGncs83ph+cia8POMc0AH5sAkCx5J+XzqZ4rGfUJwuiMFSGvmVeqW0fSW54gTyQEp
 op1SZxIHCJiJrYEvnFbGPv+ArgId0fzQvoCtaqUpKASBBiErPwL/Y1+9rmwOZUcgfPRL07yqdVB
 g2VFfekGo9UMmnH5IiOInMZiUg6l7pGMMhiIliRIBayz6dwgzxhD7Bc/vJTmjQUT+NZjTJOSdpx
 G56Z9Swm2ZLJ2XebvCJnuXanw1VaepACDekzIE+tsKOecVjAomjw6WGIUq0jV2jvs2j
X-Google-Smtp-Source: AGHT+IFOZ0Neebu1RUhnRolKvQ0mWBhr9thmInTwX+23KrZt3BSptqI7OjuxqxAMtiLs/zbJ+KC1dw==
X-Received: by 2002:a17:907:7756:b0:aa5:46d3:4d88 with SMTP id
 a640c23a62f3a-aa546d37037mr297235366b.15.1732480066434; 
 Sun, 24 Nov 2024 12:27:46 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:46 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:07 +0100
Subject: [PATCH RFC 11/14] qcom_defconfig: enable X1E80100 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-11-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=658;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dDJ2Cj/m1v/aGk08+LUmZbB2viS5ymnE60jdyIC9Pm8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHqOXTyxet+ovK2Xn2v/is7ORy9VbTcyn1Cendrxt9
 eRN4d7WUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZiPJeRodE2fd6EtRH2/SXl
 8WGzv5yfKmi7u3SV1SLl92p2s5R/vGL4H1hz/JLqMvF/x1YujDYsfGMvMC913y7bKVFXzi1OEzn
 llgcA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Enable the X1E80100 clock driver in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b49d897123c1..8e9cb3cddaa3 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -53,8 +53,9 @@ CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_QCOM_X1E80100=y
 CONFIG_CLK_QCOM_SC7280=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_SCSI=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000

-- 
2.47.0

