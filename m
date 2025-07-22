Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3623AC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E42D833F5;
	Tue, 22 Jul 2025 17:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tBdiV1We";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344D383253; Tue, 22 Jul 2025 17:35:10 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443EA8338C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2621589f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198508; x=1753803308; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iSLMkTzSY1/bZBiIIn9f9r1npCVEluBfBq0yxmEUQ1I=;
 b=tBdiV1WepbULwZuPc6DgZ1Eh6DrI3l2Li0WiZ9fzv8KeVo0hqEQOE8+JySuWl/dLC1
 MbEbiBksGqyo5L8UJmbo68dUhqfrPd/TPI7VudZWhSz2TvCm6kuhsBPUU32L6zYtAqPK
 GpH9D/DxJzNo8g0yTU6HsUWbRbeE5lVYZ9ABWuAAS7gRZMVZXg058gYZ2dNghtZM2BgV
 SDtqIWs83mFUA2UmnyniXvdsHMFcEkG+YW/voZZCmTqcmGt5oJSOVIE6MmHZiBC11bdC
 9rz083gTxgSGWBPC48ivfb4qfqRaLYjP0bxQ9VJEhMEKfSN5jfsLvvqMnOoBXqg37JF1
 j3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198508; x=1753803308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSLMkTzSY1/bZBiIIn9f9r1npCVEluBfBq0yxmEUQ1I=;
 b=sXeixXN7IYnDtPC0xgal5CQV11XYI7Qbbx+zJfldt+dXZQaEBpI9qBYhIGMati/dVE
 wH7gkMUbyxaDcwBDHhB8LEQuCU0uZLTeWBmKFQKeFmGURvQyV08igd58b7lKdB6Jb9e+
 q/1/K4Hd2KGVn9qnUpMM5jcyNDzVQhCkvrLKLEeLf1T3RngvYJnRy4EXBRgrchaj8Vdg
 ivzQXnSbDD4o3jAfHkX9l3flyxALbSQAMub2JhpaRuyjB0ux0mGUSKRTNaP2NACiDOYB
 RHaVifBZ8vieNGjobbYRF4Us/GkxwwD3IEtFxQjIrNptNbou80KxGKy8/hUiZZIhiIZH
 CJlg==
X-Gm-Message-State: AOJu0YydwWj9PvI/6p4c/hQ3MYsQHdAUFQZrf0J8pDEOAzsWywp/akGU
 mjptBSEOi9qRZPLJKelUoTSuBj2Bt2enqLzfgu0feGU1q/lNnJ3Sd22YSNEv3nsA2Jg=
X-Gm-Gg: ASbGncuOy3Wgpgx0+wDDY6Df0ueKmELMNN8rZwk91oYYdEp6vVp2chzejhcNrYeykPh
 aO9x5TgKCNfjM66Jq4dHZ6NlFlCcg75xhmaihQbGZophevrT6JV0tWfoAVA1+9BEhtgKu3oh8lt
 NmYNlkwhBqHhW9yjH0AYEPkO1J2K+2sEMB1rMQakaLgYjQ2s8e3ivDgqCdL0VD2gP6ybdFE+SpL
 2WqhYuTi85i9j+aboZXmrL/aS2DQBv3TW04WXvLX0wZXkucXGIs6eM7/4yRKYRhb3eakKACe18j
 a9Ok/PsuJlp+f/rd7LTrz6cYS72ZXN+U8llV6FeYEooZ6v56W8+n0iocH6gmaKgDKg0L1waOBSS
 MIdj6vr8Rt/5OruynvEBOd73mHQpJgGujcS8UQesITTa1pxB/hoTs7KOZ+bJC/YvOYA==
X-Google-Smtp-Source: AGHT+IG9krJrURhV7uiGFyhodqmOn10a2lD1rFVFDD80V2Q3DUzYRhaomipLSXv3G9apUuZbPjJ6Eg==
X-Received: by 2002:a05:6000:230b:b0:3b6:333:256f with SMTP id
 ffacd0b85a97d-3b613eb49f0mr16546586f8f.58.1753198507646; 
 Tue, 22 Jul 2025 08:35:07 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:06 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:51 +0200
Subject: [PATCH v5 1/8] binman: add $(srctree)/tools to toolpath
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-1-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gNNa3fK2UrnGlTOCK1uwawi5K9QlEt+qLjSOLkF64Zk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69SusmA/tOjYjpe2j5/SfuY+eBwTmXPxwQcQvX0Wo2
 ElYKH9+RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZgIjyTDf6fI7q1V91Mm12/k
 63NuilbKdZDI3f2vQurFlZMynd++7WJkWHD8W4e/JOe8N3EOE6+d+PenYIF03ZVJ968zTtynt3N
 Dmh8A
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

From: Casey Connolly <casey.connolly@linaro.org>

Not all tools need building, look in the srctree toolpath as well as
the objtree.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 93e9f4018423..5b361a0ee398 100644
--- a/Makefile
+++ b/Makefile
@@ -1603,8 +1603,13 @@ else
 binman_dtb = ./u-boot.dtb
 endif
 endif
 
+# Not all tools are in the output dir, use the srctree toolpath as well
+ifneq ($(srctree),$(objtree))
+BINMAN_TOOLPATHS += $(srctree)/tools
+endif
+
 quiet_cmd_binman = BINMAN  $@
 cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
                 --toolpath $(objtree)/tools \

-- 
2.50.1

