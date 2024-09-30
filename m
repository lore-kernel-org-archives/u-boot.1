Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D1BCF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B695E88ED7;
	Mon, 30 Sep 2024 14:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FaUeJgEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3635D88E61; Mon, 30 Sep 2024 14:44:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D4D188D9B
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so40167785e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700277; x=1728305077; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OD2sToIpO1cfLByUX2QOz6TvfjoafJN0nC5KVlPh1ro=;
 b=FaUeJgEczZT7RGx+tvbuZbWUGdEkP8j9c8EKQVPWknDBU7gbmjzWn9/H+8ATFqIXJZ
 u18OogXzsRyySKadRhG25NYvks8pp7R/i9lF9U8lYqCKpMQka+48vaIJ9f8QDyVm5vzW
 ASN4V8LjQsol4M6DELJQuwd7RT7lzMuWnD7ruE4obyEPHTKPkX9tsTemYaJGjBtVl9np
 npqQJ2MZc3kKEXV33YNtz53Nnjh02pl9a5HIdi+pZdpRCeKEaRGexPVoBREUwDsN62eP
 X7p6yiTPX6aT9j+MC6HuDrdvDdEypAWWruwLQjP0GQzDPfoTF0bbnLd3kAykoXUmUgvR
 g7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700277; x=1728305077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OD2sToIpO1cfLByUX2QOz6TvfjoafJN0nC5KVlPh1ro=;
 b=vPhtkE8FoUewFcg6DxdemCqo7k04Xvdcp/1GAqc8ALjGa5VnR1zI743H9Qcg5CGIe0
 +vUiy1COdXBn+Oc7xIqwQzu8LDRs7u2knoUf+bLeL6lcw08vYuqJCxGWCCpGU01wUXY3
 P6yneCNEochMZzpEaygwUNfRb4z185qxQjjnOJL37451F+of7N3Dr6cfR+69MzYAJHS5
 De1E8tlnAe2MeLoFqlQhuYV9NYSmihHmW6uHKWjJkM9te3fP36P/R8xDwBS5Uqp2KqAG
 fNEu0fABCjvMus8PhaF/vV//QXHRWHg4AWSQRjsnmCs+Fo4Go1qEgX2w/fCTLmeRCOJr
 jDkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7phQc8mzZNsgznJf66F0GekZdna5X3HfYSvT0/vuPL9fqBGK/rChRoNTRynLk7PISP6fdMYY=@lists.denx.de
X-Gm-Message-State: AOJu0YxrXs+z7lN1PPl3XarAnHbdJPKhXNNuo+alYl0QOb0GrK85RsuN
 heaGJsd0aUFBq6z6U78Xj3rq3Mcr+abbfHixiM6oGXsMgBHJ4Uy4jcTc+u84zYU=
X-Google-Smtp-Source: AGHT+IGedt9bMemV1q8frTFajeY1OykvZJbSZiOvUAoQVVoJIznMZShQmur0LqDo6LKd69dA3vKOWw==
X-Received: by 2002:a05:600c:314e:b0:42c:b3e5:f688 with SMTP id
 5b1f17b1804b1-42f5840ef38mr90677385e9.4.1727700276628; 
 Mon, 30 Sep 2024 05:44:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:36 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Mon, 30 Sep 2024 14:44:27 +0200
Subject: [PATCH v3 05/13] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-5-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ppGnCnIvQ24RO+CksMocxHg+RzOv3UzcGUUNAD0tfrk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0qxtlQWkHOE5r1fBK6xivUhVKtNJOaKzhTihQk
 ierv7b+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKgAKCRB33NvayMhJ0V1aEA
 CiTzPYWGnvZt7m/1qURhN6+cV1oUrr4O+GVLMOyfuGKDYbXa1E18wI0ffCk44Zr8uQrp5FNX2BYQEd
 BhtSvNY5z3A8u0CZPvJZ+CQYVs5IkbRnrSyc0HR8ZrbC/INO+Sh+9/Ep8TJBQ43fCC8b2s7S6GnduK
 eogorPoxaUxKPnaBYwpGE8/HXIwhNTUosXX1F0L64cu0g65cvSzMkHaL7VBbBTC+6f3AZWmHrv3wI9
 oblo8IltGdeUTIpmPPkJq4DTfHc5w9kdFxlcFvQGFcBB5PaKjqsjmmaLqpmPC8NDoKngH0V73uLefv
 VnUYjC6HdC81OBCkBh5e9mPeiOlTjmlI453u2yWWJsjC+Eae5UTYGNRfBHblRGLGVM19S+2NjpbLJU
 13qXG/5gPSHXizmxRVO+3Vc/at0CoCfwKbHAgLLntzC+Wti49UN/ZxevkBucf+eCkjwysU6Qts3s75
 1w0ze9XAjsPWstZDoq5RSdIFkAxpPrZ8YQX49c7j/iJvbzsw3m9K6jL58nK534Ux19r5uKDFj1F/qn
 qJOxN16yc4HZdCapGjNeccdLkSSR3eGveRNfrripu/oETwu0rs9QXxKS715X/EbzCqzqJXJplJwg8A
 Dfj44M/dKAf+RnX5q58xzW76f0qza9GHVQnBHGfnYFoIVccxxeR0qV/cOIyA==
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
support 64-bit addressing.

Ported from Linux kernel commit
6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 43042c294bb..c92f47d82b5 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -732,6 +732,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_HIBERN_FASTAUTO			BIT(2)
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * 64-bit addressing supported capability but it doesn't work.
+ */
+#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;

-- 
2.34.1

