Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F95C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0285687F86;
	Thu, 15 Feb 2024 21:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XT4DvZzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A8E87EF5; Thu, 15 Feb 2024 21:53:47 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8696E87E6C
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33934567777so770377f8f.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030371; x=1708635171; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFHXi+cU+0jBsp74j7+D6agRqCTP2TSTbsGrSPocxAs=;
 b=XT4DvZzMW9FF1lfHMjI54dUI3VRUgzHcNZ6nN7g/AtJI9gp/STWcThAPkpJB4ReiBL
 c2fCK6ehjq2wh7INnZjyHD4P0EqoBSRWt6Qd+N6LVHtkN+nK/5VdGXr6WZzcvvfn9POB
 3r8+gsngLPI6L272ZENApY9F9tnrhLfydPGT1cM4lqv9qlX38oCU4mm7lzopM9ykOUOz
 pal3MALXxQqFXkSYvVPpQZyrw3Rwb9vgHhcje4TvuGPXIyOVBYgXB1mCbM26Hv5PutwE
 nKO7ShhuzMX43fLOQOSQ9GRY42mDoq/cZT0FfiNIizqJIv9wLgMjV3TkCHkrfgHVc4Gy
 yZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030371; x=1708635171;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFHXi+cU+0jBsp74j7+D6agRqCTP2TSTbsGrSPocxAs=;
 b=WVCuIIDLLeTcwzbVXbq+ZJe/D1ichgomu3kbgREVRedPXMY7ory/EE65Bw3yitaCqK
 +yVHEPzEpbhnumbNL9upqVp9YHj5Wc5VSBQg9Byl8+MG0G262nPp8EKWxdRA1i7X4iI0
 MrgLAJSHqa5zwZ/ceARBGgggKHLq7UZPKzu2FDxYopRbvoa+Gd5vtmydPFHbGWofumk8
 GJRaPKdkA1jVWTaQ1WOozn+IO+2+WUE/imIFIPtvpFCwc9pFBF3Dkdb2zK1nYRET8ioQ
 p8ZfKNA2QVBFBw2H3+cGDzfBdLVwmknh53XweYcCaDQpRyy5tckcw5JtbZkrO3RF4l/t
 pBSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV31Wtdf7QBwi+mUiy5+4IjB/wMBCGIHmJQdo3wcL30P4ILLUIpMHHVls0i6TXIfG2De19MaYia3tD0jS8W01vh47ko+w==
X-Gm-Message-State: AOJu0YyGNVTh+ChESPe/tUJRe8UBnbAo7dqkHXlxS7hgDf0cWsWtErvW
 MlUDraQYtInGvrVIDatQoTKB5/nL9qJIhhEHHuoF+TLTMMFio97QWrh2OfhlpZwRXB0NMbQmoBA
 u
X-Google-Smtp-Source: AGHT+IHJPuFFYjYgRQyD9OlHmkGjf5/nOc47IZv7ktuyW9X5i79I3vdPp7rBRcWo0V+hUuxmlWz2dw==
X-Received: by 2002:a5d:614a:0:b0:33b:41d9:7ae3 with SMTP id
 y10-20020a5d614a000000b0033b41d97ae3mr2556674wrt.19.1708030370763; 
 Thu, 15 Feb 2024 12:52:50 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:44 +0000
Subject: [PATCH v4 26/39] doc: board/qualcomm: link to APQ8016 TRM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-26-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=3KYxQMLZXr6+5lrB8L5dkAGZ4AtAEl2OnDDC2NlbXWo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlW0nAxZWam+IPSroZHNd4v4DpVmTgzcGTuq370lmX
 G8d9zi7o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzkWBPD/3yGz+reVst3MKRM
 S6nkZFt2rl8p3GWb0vaFm9v2vc3QNGP4X1xX4ei7InPyrxLmKR7Hu+TuHN2hlmb1/tGqnw8qzL7
 p1AIA
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

The MSM8916/APQ8016 Technical Reference Manual is publicly available and
contains a lot of useful register maps for many core parts of the SoC.
Include an archive.org link to it in the dragonboard410c documentation.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/board/qualcomm/dragonboard410c.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/qualcomm/dragonboard410c.rst b/doc/board/qualcomm/dragonboard410c.rst
index d0de9dbcbc9a..34629241110c 100644
--- a/doc/board/qualcomm/dragonboard410c.rst
+++ b/doc/board/qualcomm/dragonboard410c.rst
@@ -14,6 +14,8 @@ through LK. This is no longer the case, now U-Boot can replace LK entirely.
 
 .. _96Boards product page: https://www.96boards.org/product/dragonboard410c/
 
+.. _MSM8916/SD410/APQ8016 Technical Reference Manual: https://web.archive.org/web/20210525022203/https://developer.qualcomm.com/qfile/35259/lm80-p0436-100_d_snapdragon_410e_apq8016e_tech_reference_manual_revd.pdf
+
 Installation
 ------------
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``dragonboard410c``::

-- 
2.43.1

