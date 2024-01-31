Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8302C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32E487D86;
	Wed, 31 Jan 2024 16:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="us3ysoh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F10A87C09; Wed, 31 Jan 2024 16:17:06 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 683DB87C26
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33ae3cc8a70so3096566f8f.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714222; x=1707319022; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NUKWtJNuzdemEldFviChnZJaROqyAug441mCn6zzdBY=;
 b=us3ysoh6GQmc9VNQgK7vD9xgfJW3gDSLDBfz6Ac7dpQVruJRp3ZV4FLNe6++K6loLH
 FCnLH/gyAaagKpma/ABuNm+tg+L4yDaPblK78EFAKtYVHHTrQDjJwU915wt+YVWiAnTF
 7Om+LPkUAmO92Cc+03JNgYGyTE/ntJrH54FBHJ5XL5tIWGB9/i72ttKgmRfa15mAW1zk
 wExZ0VuxVUpcOoGTc3K+J7dl4kyW0Pl53JRBFJoxVsmL+WD2ef8Jmu0gS5c5YiSMIxnC
 lvB2GfCHw1EnEHuzxOB5HRJwsPyTa3TjO9lgLtm9dYyAKeidMQwjlCXqPkvIj5un5Kdx
 PoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714222; x=1707319022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUKWtJNuzdemEldFviChnZJaROqyAug441mCn6zzdBY=;
 b=W7Pai5NE4BhEgpIdKX3WpbIsZlP8WRW+7xGl3Kk36rU5AeegYZ8PZ2gmcg61BiM6H1
 6NyTzVinC6JS2+3DTnmuhdrDwO9/UAoN+dHa74TS1J8is3wYvBk98la8GBlCZ0ptm1Rn
 UBogq4WBCcVF1BgOpxM7yo+fanktsWwSvOml0zHkvZ553bVGQr4mlQM5Vd1gil9hDP5Q
 vJjXOkQwFLCto2AQW0R6OB2g5H9e6LwbzSCymihHxWSPQd2vU+NkzebH1bXtpfcUUYzq
 +U7Fsm/uBVJkrj6m0KTgIGrP1fAbtfpGccqhgxpci4apfkfED75C3kXgF4WXsZLOz33E
 pD5w==
X-Gm-Message-State: AOJu0YymIMAKT4MKG5rHRMw++teBtxF7O4doY9VVHHdkrvkLLdGwiCc8
 6SHoqoec8pAgKS2UgctFWz82Tt5r16s2ffW4OYbLSgGJIUrceSYj3/kHyIO1IB9Kc7PX/2/0caS
 s
X-Google-Smtp-Source: AGHT+IHm/RGuSgBjj4/yilBE3zhxK5o13W6F/eqwCea+GO/gHX9i3N34HrgmE0p/yZFixcSY4PQvzw==
X-Received: by 2002:adf:f3c4:0:b0:33a:f2a3:d0fc with SMTP id
 g4-20020adff3c4000000b0033af2a3d0fcmr1653760wrp.39.1706714222688; 
 Wed, 31 Jan 2024 07:17:02 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:02 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:16:53 +0000
Subject: [PATCH 01/13] mailmap: update Bhupesh's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-1-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=966;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=K9JW8cy0h3HF9qfFJuSmTvEu0xU4iHHdsafM8i8mZY8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKdm7kxdcuSbktMd2VURI//57ur/+3/o3m7GLc8XSQ
 yH2T2uedpSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJbN/J8N85TMj0kq64v4zo
 8gUr7kcuvmXpOcXH+PMdva+mhyZ17p/LyLBYYP8q4U/H94nrzZfN2zutJn9vp43rgjXrG79cmLP
 /TE8+AA==
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

Update Bhupesh's email to his new one.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1f08f3eca8a..f6e0847b2168 100644
--- a/.mailmap
+++ b/.mailmap
@@ -30,6 +30,7 @@ Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xilinx.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
 Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargava.sreekantappa-gayathri@xilinx.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>

-- 
2.43.0

