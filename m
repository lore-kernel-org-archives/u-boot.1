Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07211C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B33289188;
	Fri, 26 Apr 2024 16:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jL+/Wlvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED3EF89173; Fri, 26 Apr 2024 16:19:47 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD7C87F4A
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57225322312so3164316a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714141185; x=1714745985; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CwTsInjpjudXn53fHxDK4wIbcKysXTmFLjOh/p+RuRs=;
 b=jL+/WlviIWlzcTVd0Cgh562J6dVidgRL1sSFkTVX1rIUIx1bo3K1/NU4JiOYK/oE3i
 ON+as+SF94jwnPGq3BBCXr/nLEo13GD6jbrTB7XdF7XQJW6/P+ilJuc3EpDRwBkclkFa
 a4Kzk+b+Th21uqyBSISxthG3D3KsfGqeYIomIPYFoDozYMHjHBgZ8l2lCSqn6QgGk2hK
 sfzV9sfpUpJhutI4U8zeYcYIMMD74G/En59BwRdCqEED0g3sErTL64fB/uI0890xnLHS
 +GfkJo2isRGk0p09KYdh4OcY+T6flAmoFSNA+v5vOdI2WcVfuoEVJlV37F2SN4FRHp44
 paYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714141185; x=1714745985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwTsInjpjudXn53fHxDK4wIbcKysXTmFLjOh/p+RuRs=;
 b=CpOSaqr9NDN9HEUPTeHtF/IKfBdIfhdL5oniLoRSLTnLrlJgIVlOluCW65CBSHUAT4
 LBCrOp0aV5mf5DbfMyNMwRQvsP4HFSFph7gZ7x7SL0X4zSCDEpbZR/UKO+ZNJRMiFHbZ
 +6kKFRsNd2EXDHPNVetfDHq8FDFGAxieIf4/Stl4mAqiWL/7ffEtavGy88r6+xEER8qz
 dZ2qQ5YbyNBFcWAM/KwnHdAd6iKE5bOUBwXlXkFBvDfkK//uAUjhgveFNIINnQxFPVl4
 CmOTFzdqzw1JqTOwV6BHuFzs3+fSMWqQtTmsQYgBpAd8D1S1FXdg9LASCZaAhUHuVZ+s
 Rn9g==
X-Gm-Message-State: AOJu0Yw05OuE33hn9J93HTwEbqA/ZfSBsnfA4j4nXvVwzcz1jZXRZXFf
 /aseNHneC3fC4nfDI7MY7GD+xx0L38B0VIO9MDx5u4i+V6ARnFw0BO9OwLk3eT4=
X-Google-Smtp-Source: AGHT+IE3Lg+eTymjoBmP9edcoiUxdR6moVH3vO162hMJlev1ZUSZFc1Ok/cw9gFN7ccxnkxAd+Gn5Q==
X-Received: by 2002:a50:cd54:0:b0:56d:e6f6:f73c with SMTP id
 d20-20020a50cd54000000b0056de6f6f73cmr1650219edj.42.1714141185591; 
 Fri, 26 Apr 2024 07:19:45 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::9b06])
 by smtp.gmail.com with ESMTPSA id
 ds2-20020a0564021cc200b0057059d26756sm10041182edb.76.2024.04.26.07.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:19:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 26 Apr 2024 16:19:37 +0200
Subject: [PATCH RFC 3/4] doc: uefi: document dynamic GUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-b4-dynamic-uuid-v1-3-e8154e00ec44@linaro.org>
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Hughes <hughsient@gmail.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=LpTzTY0m1P+CE2jca2MTSIniF4NLea/ir3Ovry4WRWk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmK7f9MiwAwCGbX6eJYwWMR+rrF0dW0TgKFn7mv
 lPMPhjhgDSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZiu3/QAKCRAFgzErGV9k
 tkxKD/4hiSFC3tQndAMvuplSrWO5N+u5e7AYG6vlBp/L71l//aGgwdAfS9ALvaA+/sR/y+Kdt5S
 dw1oTTrdEBIm8HnTKGN8b8sz5nX/mHUbDbiPuqO9+5gglDdp9p14ruGxu8EZkS6yqXrsheXd9Vf
 RvNYMg9FuxWB0q/Klbr++4FR7hUe8sqkXfJgUl233CJqJfv9Qdj044WC0MxHG3UCVUXWQJIsZVP
 1tpnwp2149T5QeQT0RlmGPRLF+rLOsddjYxqmB3AFWcblzpNQVnihfye0bUkZYutHV1mTWCXrGm
 gUEdzMk7RK5TbtoVN+3+c8AXnx10LGsqgz14EC1qO+aVRqGrsyq3L9Dlnobbcsx1o3TEZTT6kBj
 DreuDummaO+jSs9OU8SGpIAngT9fCfN2+nbjRViL/eCzna79zi1cI4qG2+d21/I/fq0TjKnTw2l
 fmXVSaSUD1Quf4zT76ijWdyJRyhxjmOx7uDcPDmN6d9hAaAigZ/lQ4l4/TpfXbfSVGmQvZcQnBM
 VSzKe5ALr5K4L83S38pLwVyN6HBgMwNV/FLJeN8qVBasbts++uPEBnmkqO21alUPIiZrjEnUaDp
 rN7pSUj6r5KgiGQwX1QQB7vzREQ5RNc9S2zs6BxLOGEPsqmGjpbykL2yOj1c/Wk0ghEsKITTxQ6
 e5E9A43KjfKRcYA==
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
maintaining a list of GUIDs per-board.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/develop/uefi/uefi.rst | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0389b269c01b..52076fb4c106 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -448,8 +448,43 @@ the location of the firmware updates is not a very secure
 practice. Getting this information from the firmware itself is more
 secure, assuming the firmware has been verified by a previous stage
 boot loader.
 
+The image_type_id contains a GUID value which is specific to the image
+and board being updated, that is to say it should uniquely identify the
+board model (and revision if relevant) and image pair. Traditionally,
+these GUIDs are generated manually and hardcoded on a per-board basis,
+however this scheme makes it difficult to scale up to support many
+boards.
+
+To address this, v5 GUIDs can be used to generate board-specific GUIDs
+at runtime, based on a set of persistent identifiable information:
+
+.. code-block:: c
+
+	/**
+	* efi_capsule_update_info_gen_ids - Generate image_type_id UUIDs
+	* for all firmware images based on a platform namespace UUID.
+	*
+	* @namespace: The arch/platform specific namespace salt. This should be
+	* hardcoded per platform and replaced by vendors.
+	* @soc: A string identifying the SoC used on this board.
+	* @model: The model string for the board.
+	* @compatible: The most specific (first) root compatible string.
+	*
+	* This can be called by board code to populate the image_type_id
+	* UUID fields deterministically based on the board's model. Allowing
+	* many boards to be supported without the need for a large hardcoded
+	* array of fw images. This works using v5 UUIDs.
+	*/
+	int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc,
+										const char *model,
+										const char *compatible);
+
+These strings are combined with the fw_image name to generate GUIDs for
+each image. This function should be called during board init, before the
+EFI subsystem is initialised.
+
 The firmware images structure defines the GUID values, image index
 values and the name of the images that are to be updated through
 the capsule update feature. These values are to be defined as part of
 an array. These GUID values would be used by the Firmware Management

-- 
2.44.0

