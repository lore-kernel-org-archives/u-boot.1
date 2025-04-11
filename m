Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B74C369AE
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379C284178;
	Fri, 11 Apr 2025 17:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QKvO4eQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E213084148; Fri, 11 Apr 2025 17:03:49 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F4A84167
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso15540365e9.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383827; x=1744988627; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Msntet+z1hVp+lXklTxDdx8dRWqp1mS+6xaRDI1fhvM=;
 b=QKvO4eQnMwCNCDSDbimRwkdrWVyDqkIYr1n2p+Dhjmzw4Spa6u0VZMDAyeSGBFwpBJ
 nEam2fOm3yQ8mdLmEnSgnut3hRZJFTYCBEbRdU4mGhrFl/P8Wsn8lYJNeck6hi1PlN/I
 V7f15PfcyzvChYBNDO425Pif7oLa4TYGTvPkvlTVm9VpxGl/KHQHrH/TXvwGMBHQrDh3
 LpxKjvcYQGZpOw4rAwDMdkfr7mN8jkP/hMoWgayf3Mve8wsT7dlTrE9bALG5iAVn+sEQ
 nwQXc4TAwfJpQJ54w6UJYDPNHOTfY6S6Tbwr+TkJn4HWri9vEHm3oLiS0arOVKYR+xmC
 J9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383827; x=1744988627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Msntet+z1hVp+lXklTxDdx8dRWqp1mS+6xaRDI1fhvM=;
 b=G/+rIS3fOQ20H7g8UNez3i08VBZNCb2PocAlaRIaQzxzppYj3L7HwPVz0UJb7G9Wh6
 A0WqIwOQpZdtBReKQwZD/xjGJj3SjzritvhLZwYjyDKJNNDaAW0aLqmVyTwrKtGXOzZn
 2uFkjxkBR1WwFT+HAOGp9nV1vxe68JhJ/R7tIQNYnBSikT4E6/NWbTQ3OAVJEm2qSDO/
 36Zu+WurhPKWgR2hUqvu5ca16zvj/PgJ/PkSGTICVy+UmuArB9+AIr1uH10UD2bg1lWR
 QUggDo38TxwRNR9hGU4dwVi0jKL2PUYFmXAj0c0oOWrZSEPPxu5K5EQihRYvjmDDXyY2
 gwJQ==
X-Gm-Message-State: AOJu0YzECv7fO1S0VWbCDb3d6wd7uhI9PPod2RxrH5ATemjlR7K8XCYb
 83AXMkpcovnM2g7tLaV5rud8/tJtAMUYBuQ9kH5ImJjJuC8nEx6BSjO9hXnAC4o=
X-Gm-Gg: ASbGnctFWNSmfMG6/LKGapsfG1bDs8fqAmJIn5rmA/A0q1lkA+XKAFat/hxHmGG+/wP
 XMKtv9RAuK7c/6wnhSxbYk2Bf5nJV2UoPCghaGhV2iaOuXYIpKiM53fhG/JZugoLLOIpGatG3/g
 WM/xAs3k9aoBuijGq/OamDswgR87KhimmWgmYPUc0qlKSIN7apsx2bfxMWDG/0AAJ9aH+YNyu5z
 qLreJrdCqtjAiZDZ/95/AiWMF7oc0VdTzIF/S1rpPE8ClCR1NCUK7EaWLk0TtBVhCoPCckmRHev
 odriOJ4U0bxpOD5GWsHxKF6T67BLbPi6L5CzZxVEEnXPcdNF
X-Google-Smtp-Source: AGHT+IFd5tbIg49otABDG43BrVN/C9znmNXizVbwBmU09ChOrdmU9lqAhWxtXRzDPXpfZZ/NSnacnw==
X-Received: by 2002:a05:600c:c8d:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-43f3a9b02eemr36398745e9.31.1744383824911; 
 Fri, 11 Apr 2025 08:03:44 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445270sm2201005f8f.81.2025.04.11.08.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:03:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 17:03:36 +0200
Subject: [PATCH v2 3/4] dfu: scsi: don't call scsi_scan()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-b4-qcom-capsule-update-improvements-v2-3-27f6b2fcc4a9@linaro.org>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
In-Reply-To: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/qd9iWmTFynlTK1BUZWU9tJpdkIDPqn32jR6qxXJKxc=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+S9JgBeJf56BoeMuhYtmgKNgf8LUUOHLQOQP1
 fk6txv7e7eJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kvSQAKCRAFgzErGV9k
 tiDBEACBiSTtcX2+7bgGZ7un7fR15IHoxd8/UquPB4a5acIxNFU2bIEkWTxUUxnMMpE/AvGPsx8
 rOveInd1fPu0Kp+9vEYcpGpGgDUSudkgr97KiB+TbXsQ+9bZMdg6GrEuTh0BtbMth3QdcjduHSv
 7Q3nvJr0lIlnu3JaYeU6CWVnNVac/+KhXsM19mkmbycrcLWFsPx5T6LZPCnWw3JvVi0PXu7yNJA
 kajZte4SzmXR0OPKyQy8miRml7txWRh3omSLm7YR40ARPxTr4LMc56+KzNhiOjIJR/Qj5SXuTft
 ync1MccHAwbKk1cV0TVSRq4BB51V2v1pSyheuzR6UmAdBkKJ3fpoB4siE9HofDveYFf3IHm73bq
 2VjwkdO9kbq4LIM0aUEijTFM0sBgIhUU1msUqiBp2OaNexwsz68yHa4EUGaEQ9FgWGRAE3XQ1GZ
 zDpuMOlpu+mNGxa4OEsgAHhX0YOogMCfigGbauOAzmUwxvBNIbkyW61z7udMxSy3CKTIMwrHrBp
 UgPa47Jmmgqd8Pc1UV3LCzZJI36P04JCXNcthS42m9gH+QCBnq38XCXIGBMPV/gun/nrvy43YUK
 y7rZ+iXaLFsONQr16KEapdb8qo5u2gNKtxUiN4PkxUfBB+X6oFIfGP+bzV4m9QOob8T8/FrD3+l
 V/UFb9OnqulQ4Yg==
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

Calling scsi_scan() results in all the block devices (and EFI block
devices) being destroyed and re-created. This breaks the EFI filesystem
drivers during capsule update.

Remove the call, since boards really should be calling scsi_scan()
themselves during board_init().

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/dfu/dfu_scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
index 9f95194784c1de00458843276872b1d23d023444..a234548ae46dc2a6ae1ca5770accb58f43782239 100644
--- a/drivers/dfu/dfu_scsi.c
+++ b/drivers/dfu/dfu_scsi.c
@@ -341,13 +341,8 @@ int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr, char **argv, int
 		if (*s)
 			return -EINVAL;
 	}
 
-	if (scsi_scan(false)) {
-		pr_err("Couldn't init scsi device.\n");
-		return -ENODEV;
-	}
-
 	ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
 	if (ret < 0) {
 		pr_err("Couldn't find scsi device no. %d.\n", dfu->data.scsi.lun);
 		return -ENODEV;

-- 
2.49.0

