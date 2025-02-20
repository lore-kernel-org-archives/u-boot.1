Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48FCC021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4621810F6;
	Thu, 20 Feb 2025 22:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHyIeVNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80C880F7A; Thu, 20 Feb 2025 21:59:22 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5360806FE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22104c4de96so23912545ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085158; x=1740689958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGZ5MOgB2uO9ZZrvTPaOG7i1a5RZWm50YgM+0IXdv1s=;
 b=EHyIeVNIeNWH+5zUeO+LsZ4PbP/w/SUZE/tZFQcL6NiR3chMVg3zqW0FvFxHuoORlR
 KnBuHkNR2kbMyBvsWb/ydqN/KXrgqdHtA3WjU+IkK/j8s3JzGXlmuJwtlaXAyiqqUt/c
 2AkmgxuWgMCYjVhlBc3vLQjLoCCPsafgo/mpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085158; x=1740689958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGZ5MOgB2uO9ZZrvTPaOG7i1a5RZWm50YgM+0IXdv1s=;
 b=MHucYAw+y98pJ0HrCjuxyniMxFv71Nl2MxqihIBmCTDVYj+wvOQXaSy6qm/7BahuOp
 jVAn4DPWO7DbWirIkEGhwXBbU74t9A5W1amBFNFUGKeZ295awyenYvY//7GCWnIX+04z
 dBTdoYB6wNf95qoP2NmOlOjVeOjoregAJZoh4kW5F6Yq2QmR4xQuiwiFklqlLpIDF8KT
 QCkiBremIjhu1VBKc225uUZ8ZOPq77/3WaCpW/mvpYiGy8DYgcjFId3nYBFnV3GPgQwj
 v0EKSnglZY4DjEEzA3dsho+Apwot6ZDI3LKtR5AKXJcqiATfDhEbMae4RfU2NJ22ghP/
 5xpw==
X-Gm-Message-State: AOJu0YyyMma0vvrNecdSVMdrJ1UDNW/uwelh7AmZKfy7lHNOZaajFatl
 IARECXVon0Bo5cSI6KcQa3eJx8QTJSZM200j7YhrmiCvKKxGrLkiWj5X1Cg9yeHZJfVqKaUcdmA
 =
X-Gm-Gg: ASbGncsAp1PbGYKGbO+JUb2/ttqRVvpkbg4Opnact5vf0MFRtKzogNI84XZP85AQT2C
 HRkFJ6yOeXMkjsDMIiFvCNxDZfoggWgNJFmHKN1U+HqP/R9C8SsuJIkcsObgReJteGVWaMwa2BY
 hwUYnbqdOqO0iPg4WffeVf8m58PY5SPdxZ1fMYvAdVwFZdRX9250byhMliDrCb/RVrR6y06jr3d
 NG4VipWNbRZdMfG6i7UPZHjWo+tr8MAHx4Wg6N3JC/Gm/RrSQkDwmNXa718vQHrzL95OL0S2wXY
 QlhjmMM/P5Q5MVPeofXuwIxFCW+8pl6enwLDjj4UvRfBTEafwxNEPp0=
X-Google-Smtp-Source: AGHT+IGkk9fInS437bYv2VEsJxv8UnXu1/kqkCdznUcUckJV1rOWXafah5rzBV7HAqF2KBtpm1HIYA==
X-Received: by 2002:a05:6a00:22d6:b0:730:94e5:1ea2 with SMTP id
 d2e1a72fcca58-73426c8d91bmr546154b3a.4.1740085158028; 
 Thu, 20 Feb 2025 12:59:18 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7326d58d4d0sm10061392b3a.94.2025.02.20.12.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:17 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 11/12] bootstd: cros: Return negative error code
Date: Thu, 20 Feb 2025 12:58:53 -0800
Message-ID: <20250220205900.3127680-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

