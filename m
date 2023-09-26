Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B08E7D271
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD26586D36;
	Tue, 26 Sep 2023 11:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HnMrJPln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F3E86D24; Tue, 26 Sep 2023 11:43:44 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F6A86AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50307acd445so13295355e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721421; x=1696326221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtD+yKia8PEGVa4F1QR9swyrpWC2Zz02KT5LSbTzmnY=;
 b=HnMrJPlnvu8Zbh6PhMpoYZH34DFl3+KFqjpHmoJeNLGI2C3p1reu5sOh1i4hSZeIX8
 ONKaVuTjpheqj8p2kp93Qzefbzf1u5FMQdnY2hx0Bc0kMifr1AvzMmGhNwIXA7/2bhsR
 gtQqZ3iZwZdVWS198G+SD8qe36B+zoWEkMfS9DA2rEONELiy5aTd+1D5FmxdkZDJXvYj
 nDaO2TAHQE6kE+08KOCCDlaWVbOWSaTebMaeBUcGOjvkZ8ARVp5l5GNF/EBR4qOPOwNU
 hYPCS8qhpV0UcZAUqcEjmUPO6W/yM+dYXGM0Hy08aU2KFAqi6K5Nx9uBV9VmxakjyWbb
 c7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721421; x=1696326221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtD+yKia8PEGVa4F1QR9swyrpWC2Zz02KT5LSbTzmnY=;
 b=s0XhEvhgF3x0oaktVgV6ZmnllGvbozRaF8IJcGe51Ktia9T5naOd2yTbc4U86qcpQz
 e3TowdkotuNTywN7/nV1YwYMES360tiQIu36+eggxEC13mekF65H1rAThPcsyDrHvBad
 E+AhfI7Nh+BjUfU1eyF7LkQ1VGKv86xwSSYwJiyaDwx+sjTeX1c+/cEkmpxJR9Uf4ogf
 JyRws/AezD/wI+M+jBiDzzzDejRPXI1JDQ0ZlN6Cmbm2Vh1Err2amy0ZGas8bo2h+IKb
 F4xuKwbhQDxr41wOysVQvXRByEkBgl3DKt88JtXaDRa7UcdZc0Zh6oGHvQWFmf7mkHBk
 VjcQ==
X-Gm-Message-State: AOJu0YzJt2QYHn3jOiIxSCfzWj6DtWP9HcmGLDKVKFJsjq4d1U5QbRXO
 RgCBZfOjnh4W8AO1ZhQHmD3rqC65PSKnoD41qhyUtw==
X-Google-Smtp-Source: AGHT+IGObsa7teDA7YUXTc/ZwgYa8olKKHgEDFyIKuZZKV2ZozVOhIcveg6by/taWbeS6quDBtr0UA==
X-Received: by 2002:a05:6512:158d:b0:502:fdca:2ea6 with SMTP id
 bp13-20020a056512158d00b00502fdca2ea6mr8737906lfb.61.1695721421531; 
 Tue, 26 Sep 2023 02:43:41 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:43:41 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 01/15] submodule: add lwIP as git submodule
Date: Tue, 26 Sep 2023 15:41:10 +0600
Message-Id: <20230926094124.7024-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

add external lwIP library as a git submodule.
Use STABLE-2_2_0_RELEASE tag.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 .gitmodules            | 3 +++
 net/lwip/lwip-external | 1 +
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 net/lwip/lwip-external

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..245ecff585
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,3 @@
+[submodule "lwip"]
+	path = net/lwip/lwip-external
+	url = https://git.savannah.nongnu.org/git/lwip.git
diff --git a/net/lwip/lwip-external b/net/lwip/lwip-external
new file mode 160000
index 0000000000..0a0452b2c3
--- /dev/null
+++ b/net/lwip/lwip-external
@@ -0,0 +1 @@
+Subproject commit 0a0452b2c39bdd91e252aef045c115f88f6ca773
-- 
2.30.2

