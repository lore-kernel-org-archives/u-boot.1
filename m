Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F62D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2C988D9B;
	Sun,  1 Dec 2024 15:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hv8oeH0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F42048917A; Sun,  1 Dec 2024 15:43:00 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D897489138
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-841a9366b5eso126295539f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064172; x=1733668972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GUSoa0MbwfeKBhqACZgORI3pbZBAHDdWKYcftxoFgE=;
 b=Hv8oeH0lFsEAi0gyRNFg5falbKMiC6Ygdy9iBCaLP6fTw5dlpOKPckAj+MYzs58syy
 /jyySlDAnhrvuPHvIa194sRkGwZpYmUhy4j6OtRTmPGcwuQEqGbvCWR9XIij0NdVHVqE
 0XzNbFCUSIrNC+yijAePssn0SGAThQz/XGMiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064172; x=1733668972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GUSoa0MbwfeKBhqACZgORI3pbZBAHDdWKYcftxoFgE=;
 b=ZwinS6U1qoQgRLZAjvQUuaMnXf+ExU/LHIOUvjSRYq7LA3cMNxOVBBu1eK6ENDuVXm
 QrFGDpQSTzuu1umAnDg7+O/T6SfFuKg2KlZsN/GaJM2s7HF8262Z9sqoc7nCqV5lGkaJ
 5t6oopc9CIr5IzXYdANys5y4tAsBomi7bWDY4anSIOWUf/XFOtFdBv+ldI57tVOj1hWj
 aaVQAOvdq3aiD+IjFXgFwE9T5DG8X42sigMmRXbVs6UbEzT7TPHxkvq5rWKt7MH7y1Ah
 fgOjAs5bE5iwnlV/Y/tp51p1vIxtqxf+qdR1U5C2HsTnGUAmN/gAXSTmzAl4COFiU9s5
 zcdQ==
X-Gm-Message-State: AOJu0YxRGp2Rrq/2YeaRqP4MzHsa41Ao8Kb5P649fFLo13optyvCxxIj
 M3NI4CAAMYXkOv+T3jV5Mpvh+C51JKRT0n49EdTT1Shj7cwSGxxnDtaTwkidLWkk/aA9JCpLAeU
 =
X-Gm-Gg: ASbGncu8s+Qa0KF9q4IOVuFVPI708RUi9gW+CWTmUt5f9l1LLvjMuBpjCJvefsj9LUf
 CMF+BewX56Tbxg2t0tHOgcO9ueCBJlvcxYTjs7B/Ja+X9GofL1vZVH2zORIFHoik5M8qGo9AGzq
 OktIirT0gtr74z/hiA2EOjhthhazNiJS16z0/lA7X17j4kVqmM0T/zB3obqBjEjoVM5ykbVJ33l
 pN3CZ7mnGhvZtG3DU3EPiczxTQQwMQNsSVTXAk7T+32
X-Google-Smtp-Source: AGHT+IG7g2ih3hJrz7SoactmFJD6OJskoFx++kqM5a2NOGOV8cVR/84f5fpPgps3gXO2Ee0Rfx5J+Q==
X-Received: by 2002:a05:6602:6d8c:b0:82a:9cab:9be1 with SMTP id
 ca18e2360f4ac-843ecffc113mr1955316239f.12.1733064172613; 
 Sun, 01 Dec 2024 06:42:52 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:42:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/8] CI: Drop extra condition for sjg lab
Date: Sun,  1 Dec 2024 07:42:29 -0700
Message-ID: <20241201144240.1664398-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

The rules part of the template makes sure that this doesn't run until
specifically requested. Drop the check in the script itself, so it is
possible to trigger a run manually without re-pushing the tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2164ad79a72..9f0b8a1a058 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -534,9 +534,6 @@ coreboot test.py:
       allow_failure: true
   tags: [ 'lab' ]
   script:
-    - if [[ -z "${SJG_LAB}" ]]; then
-        exit 0;
-      fi
     # Environment:
     #   SRC  - source tree
     #   OUT  - output directory for builds
-- 
2.43.0

