Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F1C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71CB588BC2;
	Fri, 19 Jul 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rq928mbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08BD88BA8; Fri, 19 Jul 2024 14:43:53 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F173F88BA8
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7523f0870cso216885466b.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393031; x=1721997831; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SevkwiymWliOTfLXzsoNS1778V3aELJp2f6GPtw2PGQ=;
 b=Rq928mbdb8Wvark9fzeg6q1GFFn1X6oTazJheSzYnqLruIAXOf0VYrok//uTC9OiUv
 B5Z+vN+JPr2jgZTo/SEWPjdhfyjm+8lzwP4r6FT3Uioh+ToK+1eY4caEwo8YLRyN6vBU
 X2McYHGwTljEGbFVNWiQEzgAieBOajQJM4cyIqt3vgLsv+Q78C1s1M7d3631Hilbduew
 oA0LQvnmDDvSA6SDxjEvYfQ4Z4ci18dmMtyYjA4/kw3V/Yc6oERLg+nUZ+Dtsk6e3Qkl
 RN5P5hCNg3k4EE24BUVBJ+S4/CNothTppGTSCyBniS8e7E0imV4hpE8aYYNXF4bnmXyM
 HRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393031; x=1721997831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SevkwiymWliOTfLXzsoNS1778V3aELJp2f6GPtw2PGQ=;
 b=bElArJTK0YxVj9AQglHDGqtIqb0d824XH0XIOuahLgsF2RgzD9CX/J5Hq6XrCkwUk5
 Inm0L7uyYTG08Uc8Gu4x6cmVZvdYvbnNNVjcZD7T8EGGgsXvUqRoJi2gwe+I5vxVrJLj
 WpDURBkNX0BbQENS2hW6kJ+FdKvkem3jzRPupOqicrrfRDbuwF6gGi5IeqrPofg0fQvl
 9HLdNv3f9kb/AQDvux8CNQAuyZtijES336REQgftJ7i/Fx68H9mYu85AYgGOskd9ue/C
 ZXB+uHWEtoeHBCpnvLHG/nbY40o6qoZaPGF51Bqr9lqTNKVQsWegIDzfddGrGwuSnCIg
 1K/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP3mWDiOGg7HSMj+GrTyqOsIOeKyHN4entCJjvrIs718uF8aVlTMFtItxAsewJ70FJAoHocC5Bt3IkNAFen57mBq7K3A==
X-Gm-Message-State: AOJu0Yym0OUwdXOPQ1EZy/wSAYAhPC8Q1ee++eSfnd1B5ORHoa81xDo8
 yxmyxD904FXMBRPPfaOjijatLaK7cvt2uABDTHgwKuPxnk3l7+I7OG8L3EImW2E=
X-Google-Smtp-Source: AGHT+IEBkfzdEje3FE63aFWVGL5yg2DDWI2GDvLU4jikStwp0AVm/+CC2RqLespnYo6QuTb2EVSssA==
X-Received: by 2002:a17:906:11c4:b0:a77:cdaa:88a7 with SMTP id
 a640c23a62f3a-a7a01349b37mr438203066b.48.1721393031276; 
 Fri, 19 Jul 2024 05:43:51 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:44 +0200
Subject: [PATCH v5 04/11] doc: uefi: document dynamic UUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-4-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=QSNObyu22LJKw0rqXvvMxjl3Wcj3sXgYDSrg4en4GNc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+AEKvYAG1y+bi7QP/5PPqnJHl9eeGI8gFt1
 2kZ4hrctHuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgAAKCRAFgzErGV9k
 trYAD/4+o0TJkebVYtHRuF+9+j3MrimduaJ2kfJ7N+5/2HxwiiYKNmTFl3zje/KZCha1Z8Rk8BW
 0aTnKm7q3ZRhniqyzG9YktyhecLDaVpJfyet/hooV6rthdPhYUXgB9UA9xOGn5/Jzn7oDdzu18Z
 jsoZWlaRKqBDSeYkwSPQz05t5lecSIeFCoAO2vLVOqOhIX1OkihWmCr+732x0aHJCrpsjEk2Icu
 faGF75dqI7ThwRlItmH5VrPbxtnnOT+fciz1M7xyopxXOKTNAc87mAJ8AsT8RQtySfIwxuBzme9
 oaF2BBryhAYJTiMNcEkyhBHCENfViD3UMWRos4FP/i5aitQtJDeq8zeF8yu/Desr9TjjxWKvYOi
 FzXWwlaJ1KbIQRMISn18VbqyvlMm6AMZsoYYNjQoDhgcVTR19bMCKAGUORv3pc7KMLw9Ky0Uibe
 9mYujlGWz2sY0d5TzbUBus7F0ALTqQXeQ4nbUH/TtGUJPg+RUGsYdlw28H7QyDiHEhQQNiIY1da
 3hccsHXgy1UxTXweHcsQW5eNS/1YIe8H9jZF0UjnRQoltyKBmX9J+4ZZnt3rFB+hwqmPlGGm9v/
 UWfpSjjMBOiwceYOs9ZQ4bEiEW4bCalQ+W2fj06AZDZUca1RJW1epUS+1jcLxsbdSURd173mUEX
 7Cvt54dc0MTzW2A==
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

Document how platforms can generate GUIDs at runtime rather than
maintaining a list of UUIDs per-board.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/develop/uefi/uefi.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index d450b12bf801..b284736cf6c2 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -448,8 +448,35 @@ the location of the firmware updates is not a very secure
 practice. Getting this information from the firmware itself is more
 secure, assuming the firmware has been verified by a previous stage
 boot loader.
 
+Dynamic FWU GUIDs
+*****************
+
+The image_type_id contains a GUID value which is specific to the image
+and board being updated, that is to say it should uniquely identify the
+board model (and revision if relevant) and image pair. Traditionally,
+these GUIDs are generated manually and hardcoded on a per-board basis,
+however this scheme makes it difficult to scale up to support many
+boards.
+
+To address this, v5 GUIDs can be used to generate board-specific GUIDs
+at runtime, based on the board's devicetree root compatible 
+(e.g. "qcom,qrb5165-rb5").
+
+These strings are combined with the fw_image name to generate GUIDs for
+each image. Support for dynamic UUIDs can be enabled by generating a new
+namespace UUID and setting EFI_CAPSULE_NAMESPACE_GUID to it. Dynamic GUID
+generation is only enabled if the image_type_id property is unset for your
+firmware images, this is to avoid breaking existing boards with hardcoded
+GUIDs.
+
+The mkeficapsule tool can be used to determine the GUIDs for a particular
+board and image. It can be found in the tools directory.
+
+Firmware update images
+**********************
+
 The firmware images structure defines the GUID values, image index
 values and the name of the images that are to be updated through
 the capsule update feature. These values are to be defined as part of
 an array. These GUID values would be used by the Firmware Management

-- 
2.45.2

