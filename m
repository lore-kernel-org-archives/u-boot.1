Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0565EE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 23:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D8F4801A0;
	Tue, 17 Dec 2024 00:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KqFGsKUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81586801FB; Tue, 17 Dec 2024 00:39:31 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21626801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 00:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso168604139f.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 15:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734392367; x=1734997167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuuBbs5cN7vmhXre4zKr6z4PLmiIngKMn/F6gvZfmx8=;
 b=KqFGsKUX/57qCvgIkJXzHgTywH2+VUCUfoUvzFEJiVMQ4IuifA6NXqJ3mmaGBNgZfT
 6YXBhWjmRsbHteb+nTnujVrej3blTC/tw0F01G8V/UkQ4N1ibRUc1cCRCGgImm/Ywbrc
 NEweybxM0B8XfhySDLN3dftGWEhL+85/THFCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734392367; x=1734997167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RuuBbs5cN7vmhXre4zKr6z4PLmiIngKMn/F6gvZfmx8=;
 b=ZcBBKUmR6JgggEJvRtIIZlREFOhYA0wPTEMMp3qJyHZNyvVX/yixhDPLBtEbNAXiBB
 0huBWbNUc0REfUdQBWfTiTRypEzijc44oFgswpGArpRulNTNYnzwVLRIBF7J3m8O/Qp+
 9zo7tauAWZQqrivsVq9IsHmWKRGRzrDwZadLAK4SUAunfLqWLj4sONgZr7BShxYl0Nio
 HmR0Ol9GSZnV45she5xu/fzasPuCPWJLVvBwEX0lFLfI+VF043vAh7A0PL+4th2+/ER8
 j+RFYffUZdkOo5Fr6gnyEjnh84aTkRor5KCP2OQnu5ShlWcGWiTlnARn/wh+64Zw3Kkb
 rNVA==
X-Gm-Message-State: AOJu0YxXTPgnJtjSgTLSyhuEhxP0jhW/9SU4Swv0lPIh9qEOennZknUq
 KtM+jHOK2ZfDtgjKH+gxxSEbuSu1rscoTmI0zINyuJUKor7w1s8eK+YhZZGy2Hji8EY0BtWWzJs
 =
X-Gm-Gg: ASbGncunsYliO8NeNmSB5YeKUwhTGsiIqnLdo+46AxXhOLMBUOYfohOz7tLRJcXwnUX
 5JOovD2Oj9R+2Spy5QlPTC2vgIRWb+mXFJBSs6C7cpnJJ/yJ4ZWPGuYKaqRa5smi+1NCrCtsQ+u
 0kuRE26hQD8PaDoH5VMh5t7ywcHMXHUB6hsS/7rhxXjC8cOl10T5s+lOxcUXL8A5C14LdgkMNiJ
 hNRAyULqqzzOMgeeaSuAKHsjxvtUDJNXjaL2pK8iUt5tNVeDJVKYfSUMMJLzjfVf2Lz+cDX893L
 cp5DgnOZB8RhEYX75g==
X-Google-Smtp-Source: AGHT+IFOy9Lmu1iaFv5O7cImcNGIYYxBIplzTRNv3cQIcB0711aoRGgKHJ39IQHShzeVn6h6glzH8g==
X-Received: by 2002:a05:6602:3401:b0:841:99cb:776f with SMTP id
 ca18e2360f4ac-84747e257b4mr116523439f.6.1734392367278; 
 Mon, 16 Dec 2024 15:39:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e3781fa2sm1406731173.118.2024.12.16.15.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 15:39:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 1/1] gitlab: Add a StarFive VisionFive2 to the sjg lab
Date: Mon, 16 Dec 2024 16:38:53 -0700
Message-Id: <20241216233853.2125656-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216233853.2125656-1-sjg@chromium.org>
References: <20241216233853.2125656-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I have one of these boards loaded with Ubuntu 24.10 (64-bit). Add an
entry for it so that it can be used for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rename the board to vf2
- Add a comment about what the board is

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ffcf8532944..a17c1b0a366 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -696,3 +696,9 @@ rpi:
   variables:
     ROLE: rpi
   <<: *lab_dfn
+
+# StarFive VisionFive 2
+vf2:
+  variables:
+    ROLE: vf2
+  <<: *lab_dfn
-- 
2.34.1

