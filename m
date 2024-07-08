Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D8EC3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49B7886F3;
	Mon,  8 Jul 2024 13:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VvAGYQCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5FA886DB; Mon,  8 Jul 2024 13:33:10 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10128886AF
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 13:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so4795574a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720438387; x=1721043187; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qvkoZcQ7OJD8CXSX3t0Cqg2dNoEjO5pN9QkaEuTXc8w=;
 b=VvAGYQCPeuoyVk+EXSRdG8Ac6VpCcSFGi7zWvniRsuiL+Y4iDW2DG8IrGGQnnEzQVu
 AsM03YoQ2F3K/Ok47u2hZBx6dRAGoXZwr1nF8BLwSQZqBX280BN5VwuLDWrKmTJFXM+3
 /jcwSA163ljPP6Fs0PXYQByXupWvYurZC2IFoBFkD+9s2x8kUWlmHCxEX03i8Cbege4j
 WnAVdjiPZURpR6gswzq50CnTYRrrebsGo4N4EbGlgjrM81KNkBIp3kObWwtTvAhSHr+e
 q8Z+72CYB/rsXE0KKaTl2IA5YsYUhP2o5SeixpW1+Fpe4xMRwuoE7LQhladxiNGP2fC/
 /cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720438387; x=1721043187;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvkoZcQ7OJD8CXSX3t0Cqg2dNoEjO5pN9QkaEuTXc8w=;
 b=vHLwTxmeHuT128GasyyGD8EjKDD7z0JHPUB7C4dYf6R0aYF4nz6/9B0/bmuY1rEN99
 KsL02XnL74KTJ1ZV94KYoCOf6ciYdQ62vtqztcnn5PPIpdHnbMC7EjXrDbABPIDIellx
 JKWsHWNJbmIkfQirwgFc5xvaUBFfiXjLLat0rylsAj3KB+3axBlBeOEmibFVEVcYZeic
 kb7xKHOgkPAiVRKE1lx587WP/L3oPuLrMhKnmGum5kG6pdfgl22/iCAlC5D9Fi+HuP6G
 /a7hwSxhGd9uv3mgGQPIVdOY52CPxMGj7AS6Dtuoakl0dHI0t85IDhfUI/kobeeN/ls9
 KGSw==
X-Gm-Message-State: AOJu0YwYVL4DpfBS7oPmX5BViSybck9YnLHAh7proBcnSCaissz6FVPI
 Ix60kVanujq861CpAIxQZw5kHk6sSgJnuoYoQpN82b2fvBIE/eAjRHzJdgoETNEXI2mVXYKeExJ
 DXpE=
X-Google-Smtp-Source: AGHT+IHHz2PQpdJTYpGY6uXNJCU8estcYr/8ak2NBiVV/h4WKVSZ0g7bzfgcLlPPjKfvNp7Eou/8KQ==
X-Received: by 2002:a17:906:605:b0:a6f:ddb3:bf2b with SMTP id
 a640c23a62f3a-a77ba48e721mr800451766b.41.1720438387143; 
 Mon, 08 Jul 2024 04:33:07 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c9925463sm303628466b.69.2024.07.08.04.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:33:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Jul 2024 13:32:53 +0200
Subject: [PATCH v2 1/4] linux/bitmap.h: add bitmap_empty helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-b4-qcom-rpmh-v2-1-8bc765606e56@linaro.org>
References: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
In-Reply-To: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=z6XvfLGv5QyURxvw0REJ2jitM49N/Q7K6mgwTQZxddM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi85wLPq+1QG+jhRm6dp+wxvc5LZUnte1wHclN
 MynYWkwIc2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovOcAAKCRAFgzErGV9k
 tmOREACbs1kX9S77/R28BH32B4epkHRt4LGtorVwIWs3ges0KZoAqdCnYsgTpru0jAKCoYfTVWG
 k71Lud4nY8woMGfonpxqiUIQaJCA4xpnywW0/AnNGiIKudJozP4f5RtExGtZDuamQzJK/V0Y8jM
 tobW2SpVn9P+YC3KRi9RhPh1RAGYZwzfBL3v+BRwQZAwWuvsPGP2WdhqjzA4z0SoS5nRAX06CWw
 xshs2nFor2+n0eNJViYoy9TWEXiCEof9EnxjW993LU5sVVQjqqmFNWa/2eb0BdqkYPZRXAtisqk
 sldEXmR+E4zIGMY9CmDQMitGY0oCvo0iZpkvXh59oXKRhGpmrZjcj9eTiQw9Svs1SxD2bK4U8G6
 Ge+HzDJGRW3/SOBc6WjI3Jpy0U1S2cD/0BOzXiP69n2vRxEy+1hlaX39uZqxxYg63NOxrSHQKsb
 bELk8qfGKevh0OvB+iVKghf6QdI+sfcJ+DwNVRvKmcfgBa0N4Q5X+gPRKMV3qILEUQPNkQWgkd+
 v3mxueklHFrvS40NpYCIcMgZZMR8Yy3XTTZtt3N5fm9Fq/0mAikc0lO86R2OCk836bDcz4yCHuQ
 Fpnm9D7zqGhNRx0o5KqnrEwvdCSQDMcW6hyu0TiaS+uLhv94MI3oZcrmb++jAz0+n8HhPBw0Q+u
 xprPu9zRI5chx+A==
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

Import this function from Linux.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/linux/bitmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f14..40ca2212cb40 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -195,8 +195,16 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 	}
 }
 
+static inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !(*src & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_bit(src, nbits) == nbits;
+}
+
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))

-- 
2.45.2

